if Config.Framework ~= "qb" then
    return
end

debugprint("Loading QB")

QB = exports["qb-core"]:GetCoreObject()

while not LocalPlayer.state.isLoggedIn do
    Wait(500)
end

TriggerServerEvent("lb-tablet:frameworkLoaded")

local SharedVehicles = QB.Shared.Vehicles
local PlayerJob = QB.Functions.GetPlayerData().job
local PlayerData = QB.Functions.GetPlayerData()

debugprint("QB loaded")

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    FrameworkLoaded = false
    PlayerData = {}
    PlayerJob = {}

    LogOut()

    debugprint("ON LOG OUT")
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = QB.Functions.GetPlayerData()

    FrameworkLoaded = true
    TriggerServerEvent("lb-tablet:frameworkLoaded")
    FetchTabletData()
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(jobInfo)
    local oldJob = PlayerJob

    PlayerJob = jobInfo

    TriggerEvent("lb-tablet:jobUpdated")

    if oldJob.name ~= PlayerJob.name or oldJob.grade?.level ~= PlayerJob.grade?.level then
        SendReactMessage("services:setCompany", GetCompanyData())
    else
        SendReactMessage("services:setDuty", jobInfo.onduty)
    end
end)

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
    end

    return QB.Functions.HasItem(Config.Item.Name)
end

RegisterNetEvent("QBCore:Player:SetPlayerData", function(newData)
    PlayerData = newData

    local metadata = PlayerData.metadata

    if metadata and (metadata.isdead or metadata.inlaststand) then
        Citizen.CreateThreadNow(HandleDead)
    end

    if not Config.Item.Require then
        return
    end

    OnItemCountChange()
end)

---@return string
function GetJob()
    return PlayerJob.name
end

---@return boolean
function IsOnDuty()
    return PlayerJob.onduty
end

---@return number
function GetJobGrade()
    return PlayerJob.grade?.level or 0
end

function FormatVehicle(vehicle)
    debugprint("Formatting vehicle", vehicle)

    local mods = json.decode(vehicle.mods)

    if mods then
        vehicle.color = GetVehicleColor(mods.color1)
        vehicle.model = SharedVehicles[vehicle.vehicle]?.name or GetVehicleLabel(mods.model)
    end

    vehicle.mods = nil

    if vehicle.name then
        vehicle.owner = {
            name = vehicle.name,
            identifier = vehicle.owner
        }

        vehicle.name = nil
    end

    return vehicle
end

--#region Services

function GetCompanyData()
    local jobData = {
        job = PlayerJob.name,
        jobLabel = PlayerJob.label,
        isBoss = PlayerJob.isboss,
        duty = PlayerJob.onduty,
        receiveCalls = GetCompanyCallsStatus and GetCompanyCallsStatus()
    }

    if not jobData.isBoss then
        return jobData
    end

    if GetResourceState("qb-management") ~= "started" then
        QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", function(money)
            jobData.balance = money
        end, jobData.job)
    else
        jobData.balance = AwaitCallback("services:getAccount")
    end

    QB.Functions.TriggerCallback("qb-bossmenu:server:GetEmployees", function(employees)
        local onlineCitizenIds = AwaitCallback("services:getOnlineCitizenIds")

        for i = 1, #employees do
            local employee = employees[i]

            employees[i] = {
                name = employee.name,
                id = employee.empSource,

                gradeLabel = employee.grade.name,
                grade = employee.grade.level,

                canInteract = not employee.isboss,

                online = onlineCitizenIds[employee.empSource]
            }
        end

        jobData.employees = employees
    end, jobData.job)

    local timeout = GetGameTimer() + 2000

    while not jobData.balance or not jobData.employees do
        Wait(0)

        if GetGameTimer() > timeout then
            infoprint("error", "Failed to get company data (timed out after 2s)")
            print("balance: " .. tostring(jobData.balance))
            print("employees: " .. tostring(jobData.employees))

            jobData.employees = jobData.employees or {}
            jobData.balance = jobData.balance or 0
            break
        end
    end

    jobData.grades = {}

    for k, v in pairs(QB.Shared.Jobs[jobData.job].grades) do
        jobData.grades[#jobData.grades + 1] = {
            label = v.name,
            grade = tonumber(k)
        }
    end

    table.sort(jobData.grades, function(a, b)
        return a.grade < b.grade
    end)

    return jobData
end

function DepositMoney(amount)
    if GetResourceState("qb-management") == "started" then
        return AwaitCallback("services:addMoney", amount)
    end

    TriggerServerEvent("qb-bossmenu:server:depositMoney", amount)
    Wait(500) -- Wait for the server to update the balance

    local newBalancePromise = promise.new()

    QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", function(balance)
        newBalancePromise:resolve(balance)
    end, PlayerJob.name)

    return Citizen.Await(newBalancePromise)
end

function WithdrawMoney(amount)
    if GetResourceState("qb-management") == "started" then
        return AwaitCallback("services:removeMoney", amount)
    end

    TriggerServerEvent("qb-bossmenu:server:withdrawMoney", amount)
    Wait(500) -- Wait for the server to update the balance

    local newBalancePromise = promise.new()

    QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", function(balance)
        newBalancePromise:resolve(balance)
    end, PlayerJob.name)

    return Citizen.Await(newBalancePromise)
end

function HireEmployee(source)
    TriggerServerEvent("qb-bossmenu:server:HireEmployee", source)

    return AwaitCallback("services:getPlayerData", source)
end

function FireEmployee(citizenid)
    TriggerServerEvent("qb-bossmenu:server:FireEmployee", citizenid)

    return PlayerJob.isboss or false
end

function SetGrade(identifier, newGrade)
    local maxGrade = 0

    for grade, _ in pairs(QB.Shared.Jobs[PlayerJob.name].grades) do
        grade = tonumber(grade)

        if grade and grade > maxGrade then
            maxGrade = grade
        end
    end

    if newGrade > maxGrade then
        return false
    end

    TriggerServerEvent("qb-bossmenu:server:GradeUpdate", {
        cid = identifier,
        grade = newGrade,
        gradename = QB.Shared.Jobs[PlayerJob.name].grades[tostring(newGrade)].name
    })

    return true
end

function ToggleDuty()
    TriggerServerEvent("QBCore:ToggleDuty")
end

local weaponList

function GetWeaponsList()
    if weaponList then
        return weaponList
    end

    weaponList = {}

    local weapons = QB.Shared.Weapons

    for hash, weapon in pairs(weapons) do
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

local _IsPedDeadOrDying = IsPedDeadOrDying

function IsPedDeadOrDying(ped, checkMeleeDeathFlags)
    if ped == PlayerPedId() then
        local metadata = PlayerData.metadata

        if metadata and (metadata.isdead or metadata.inlaststand) then
            return true
        end
    end

    return _IsPedDeadOrDying(ped, checkMeleeDeathFlags)
end

function IsHandcuffed()
    local metadata = PlayerData.metadata

    if metadata and metadata.ishandcuffed then
        return true
    end

    return false
end

FrameworkLoaded = true
