if Config.Framework ~= "esx" then
    return
end

debugprint("Loading ESX")

local export, obj = pcall(function()
    return exports.es_extended:getSharedObject()
end)

if export then
    ESX = obj
else
    while not ESX do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)

        Wait(500)
    end
end

RegisterNetEvent("esx:playerLoaded", function(playerData)
    ESX.PlayerData = playerData
    ESX.PlayerLoaded = true

    TriggerServerEvent("lb-tablet:frameworkLoaded")
end)

RegisterNetEvent("esx:onPlayerLogout", function()
    FrameworkLoaded = false
    ESX.PlayerLoaded = false

    LogOut()

    while not ESX.PlayerLoaded do
        Wait(500)
    end

    FrameworkLoaded = true
    FetchTabletData()
end)

while not ESX.PlayerLoaded do
    Wait(500)
end

TriggerServerEvent("lb-tablet:frameworkLoaded")

function FormatVehicle(vehicle)
    vehicle.vehicle = json.decode(vehicle.vehicle)

    if vehicle.vehicle then
        vehicle.color = GetVehicleColor(vehicle.vehicle.color1)
        vehicle.model = GetVehicleLabel(vehicle.vehicle.model)
        vehicle.vehicle = nil
    end

    if vehicle.name then
        vehicle.owner = {
            name = vehicle.name,
            identifier = vehicle.owner
        }

        vehicle.name = nil
    end

    return vehicle
end

---@return boolean
function IsAdmin()
    ---@diagnostic disable-next-line: redundant-return-value
    return AwaitCallback("isAdmin")
end

---@return boolean
function HasTabletItem()
    if not Config.Item.Require then
        return true
    end

    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
    elseif GetResourceState("qs-inventory") == "started" then
        return (exports["qs-inventory"]:Search(Config.Item.Name) or 0) > 0
    end

    return (ESX.SearchInventory(Config.Item.Name, 1) or 0) > 0
end

RegisterNetEvent("esx:removeInventoryItem", function(item, count)
    if not Config.Item.Require or item ~= Config.Item.Name or count > 0 then
        return
    end

    OnItemCountChange()
end)

RegisterNetEvent("esx:addInventoryItem", function(item, count)
    if not Config.Item.Require or item ~= Config.Item.Name then
        return
    end

    OnItemCountChange()
end)

---@return string
function GetJob()
    return ESX.PlayerData.job.name
end

---@return boolean
function IsOnDuty()
    local duty = ESX.PlayerData.job.onDuty

    if duty == nil then
        return true
    end

    return duty == true
end

---@return number
function GetJobGrade()
    return ESX.PlayerData?.job?.grade or 0
end

RegisterNetEvent("esx:setJob", function(job)
    local oldJob = ESX.PlayerData.job
    local jobChanged = true

    if oldJob.name == job.name and oldJob.grade == job.grade then
        jobChanged = false
    end

    ESX.PlayerData.job = job

    TriggerEvent("lb-tablet:jobUpdated")

    if jobChanged then
        SendReactMessage("services:setCompany", GetCompanyData())
    else
        SendReactMessage("services:setDuty", job.onDuty)
    end
end)

--#region Services

function GetCompanyData()
    local companyData = {
        job = ESX.PlayerData.job.name,
        jobLabel = ESX.PlayerData.job.label,
        isBoss = ESX.PlayerData.job.grade_name == "boss",
        duty = ESX.PlayerData.job.onDuty,
        receiveCalls = GetCompanyCallsStatus and GetCompanyCallsStatus()
    }

    if not companyData.isBoss then
        return companyData
    end

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money)
        companyData.balance = money
    end, companyData.job)

    ESX.TriggerServerCallback("esx_society:getEmployees", function(employees)
        local onlineIdentifiers = AwaitCallback("services:getOnlineIdentifiers")

        for i = 1, #employees do
            local employee = employees[i]

            employees[i] = {
                name = employee.name,
                id = employee.identifier,

                gradeLabel = employee.job.grade_label,
                grade = employee.job.grade,

                canInteract = employee.job.grade_name ~= "boss",

                online = onlineIdentifiers[employee.identifier]
            }
        end

        companyData.employees = employees
    end, companyData.job)

    ESX.TriggerServerCallback("esx_society:getJob", function(job)
        local grades = {}

        for i = 1, #job.grades do
            local grade = job.grades[i]

            grades[i] = {
                label = grade.label,
                grade = grade.grade
            }
        end

        companyData.grades = grades
    end, companyData.job)

    local timeout = GetGameTimer() + 2000

    while not companyData.balance or not companyData.employees or not companyData.grades do
        Wait(0)

        if GetGameTimer() > timeout then
            infoprint("error", "Failed to get company data (timed out after 2s)")
            print("balance: " .. tostring(companyData.balance))
            print("employees: " .. tostring(companyData.employees))
            print("grades: " .. tostring(companyData.grades))

            companyData.employees = companyData.employees or {}
            companyData.balance = companyData.balance or 0
            companyData.grades = companyData.grades or {}
            break
        end
    end

    return companyData
end

function DepositMoney(amount)
    TriggerServerEvent("esx_society:depositMoney", ESX.PlayerData.job.name, amount)
    Wait(500) -- Wait for the server to update the balance

    local newBalancePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money)
        newBalancePromise:resolve(money)
    end, ESX.PlayerData.job.name)

    return Citizen.Await(newBalancePromise)
end

function WithdrawMoney(amount)
    TriggerServerEvent("esx_society:withdrawMoney", ESX.PlayerData.job.name, amount)
    Wait(500) -- Wait for the server to update the balance

    local newBalancePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money)
        newBalancePromise:resolve(money)
    end, ESX.PlayerData.job.name)

    return Citizen.Await(newBalancePromise)
end

function HireEmployee(source)
    local playersPromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getOnlinePlayers", function(players)
        playersPromise:resolve(players)
    end)

    local players = Citizen.Await(playersPromise)
    local player

    for i = 1, #players do
        if players[i].source == source then
            player = players[i]
            break
        end
    end

    if not player then
        return false
    end

    local hirePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:setJob", function()
        hirePromise:resolve(true)
    end, player.identifier, ESX.PlayerData.job.name, 0, "hire")

    if not Citizen.Await(hirePromise) then
        return
    end

    return {
        id = player.identifier,
        name = player.name,
    }
end

function FireEmployee(identifier)
    local firePomise = promise.new()

    ESX.TriggerServerCallback("esx_society:setJob", function()
        firePomise:resolve(true)
    end, identifier, "unemployed", 0, "fire")

    return Citizen.Await(firePomise)
end

function SetGrade(identifier, newGrade)
    local promotePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getJob", function(jobData)
        if newGrade > #jobData.grades - 1 then
            return promotePromise:resolve(false)
        end

        ESX.TriggerServerCallback("esx_society:setJob", function()
            promotePromise:resolve(true)
        end, identifier, ESX.PlayerData.job.name, newGrade, "promote")
    end, ESX.PlayerData.job.name)

    return Citizen.Await(promotePromise)
end

function ToggleDuty()
    TriggerServerEvent("tablet:services:toggleDuty")
end

local weaponList

function GetWeaponsList()
    if weaponList then
        return weaponList
    end

    weaponList = {}

    local weapons = ESX.GetWeaponList()

    for i = 1, #weapons do
        local weapon = weapons[i]
        local label = weapon.label
        local model = weapon.name

        if label and model then
            weaponList[#weaponList + 1] = {
                model = model,
                label = label
            }
        end
    end

    table.sort(weaponList, function(a, b)
        return a.label < b.label
    end)

    return weaponList
end

--#endregion

debugprint("ESX loaded")

FrameworkLoaded = true
