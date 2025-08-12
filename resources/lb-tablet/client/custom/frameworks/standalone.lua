if Config.Framework ~= "standalone" then
    return
end

debugprint("Using standalone/registration framework")

while not NetworkIsSessionStarted() do
    Wait(500)
end

TriggerServerEvent("lb-tablet:frameworkLoaded")

function FormatVehicle(vehicle)
    if vehicle.name then
        vehicle.owner = {
            name = vehicle.name,
            identifier = vehicle.owner
        }

        vehicle.name = nil
    end

    vehicle.color = vehicle.color and {
        label = "",
        hex = vehicle.color
    }

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
    end

    return false
end

---@return string
function GetJob()
    return "unemployed"
end

---@return boolean
function IsOnDuty()
    return true
end

---@return number
function GetJobGrade()
    return 0
end

--#region Services

-- Trigger the following event when the player's job is updated: TriggerEvent("lb-tablet:jobUpdated")

function GetCompanyData()
    local companyData = {
        job = "unemployed",
        jobLabel = "Unemployed",
        isBoss = false,
        duty = true,
        receiveCalls = GetCompanyCallsStatus and GetCompanyCallsStatus()
    }

    -- If the player is boss, also return: balance, employees, grades
    -- see the esx.lua/qb.lua files for examples

    return companyData
end

---@param amount number
---@return number newBalance
function DepositMoney(amount)
    return 0
end

---@param amount number
---@return number newBalance
function WithdrawMoney(amount)
    return 0
end

---@param source number
---@return boolean success
function HireEmployee(source)
    return false
end

---@param identifier string
---@return boolean success
function FireEmployee(identifier)
    return false
end

---@param identifier string
---@param newGrade number
---@return boolean success
function SetGrade(identifier, newGrade)
    return false
end

function ToggleDuty()
    TriggerServerEvent("tablet:services:toggleDuty")
end

---@return { label: string, model: string }[]
function GetWeaponsList()
    return Weapons
end

--#endregion

FrameworkLoaded = true
