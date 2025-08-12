if Config.Framework ~= "qbox" then
    return
end

debugprint("Loading QBox")

QB = exports["qb-core"]:GetCoreObject()

while not LocalPlayer.state.isLoggedIn do
    Wait(500)
end

TriggerServerEvent("lb-tablet:frameworkLoaded")

local SharedVehicles = QB.Shared.Vehicles
local PlayerJob = QB.Functions.GetPlayerData().job
local PlayerData = QB.Functions.GetPlayerData()

debugprint("QBox loaded")

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

RegisterNetEvent("QBCore:Client:SetDuty", function(onDuty)
    PlayerJob.onduty = onDuty

    TriggerEvent("lb-tablet:jobUpdated")
    SendReactMessage("services:setDuty", onDuty)
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(jobInfo)
    local oldJob = PlayerJob

    PlayerJob = jobInfo

    TriggerEvent("lb-tablet:jobUpdated")

    if oldJob.name ~= PlayerJob.name or oldJob.grade?.level ~= PlayerJob.grade?.level then
        SendReactMessage("services:setCompany", GetCompanyData())
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

    jobData.balance = AwaitCallback("qbx:services:getAccount")
    jobData.employees = AwaitCallback("qbx:services:getEmployees")
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
    return AwaitCallback("qbx:services:addMoney", amount)
end

function WithdrawMoney(amount)
    return AwaitCallback("qbx:services:removeMoney", amount)
end

function HireEmployee(source)
    if not AwaitCallback("qbx:services:hireEmployee", source) then
        return false
    end

    return AwaitCallback("services:getPlayerData", source)
end

function FireEmployee(citizenid)
    return AwaitCallback("qbx:services:fireEmployee", citizenid)
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

    return AwaitCallback("qbx:services:setGrade", identifier, newGrade)
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

    if GetResourceState("ox_inventory") ~= "started" then
        infoprint("warning", "ox_inventory is not started. Please configure GetWeaponsList manually.")
        return weaponList
    end

    local items = exports.ox_inventory:Items()

    for name, item in pairs(items) do
        if item.weapon then
            weaponList[#weaponList + 1] = {
                model = name,
                label = item.label
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
