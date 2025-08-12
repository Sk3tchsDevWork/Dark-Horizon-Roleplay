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
    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
end

debugprint("ESX loaded")

---@param source number
---@return string | nil
function GetIdentifier(source)
    return ESX.GetPlayerFromId(source)?.identifier
end

---@param identifier string
---@return number?
function GetSourceFromIdentifier(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then
        return xPlayer.source
    end
end

---@param source number
---@return string firstname
---@return string lastname
function GetCharacterName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local firstName = xPlayer.get and xPlayer.get("firstName")
    local lastName = xPlayer.get and xPlayer.get("lastName")

    if not firstName or not lastName then
        local row = MySQL.single.await("SELECT firstname, lastname FROM users WHERE identifier=?", { GetIdentifier(source) })

        firstName = row?.firstname or GetPlayerName(source)
        lastName = row?.lastname or ""
    end

    return firstName, lastName
end

---@param identifier string
---@return string?
function GetCharacterNameFromIdentifier(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier and ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then
        return xPlayer.getName()
    end

    return MySQL.scalar.await("SELECT CONCAT(firstname, ' ', lastname) FROM users WHERE identifier = ?", { identifier }) or ""
end

---@param source number
function IsAdmin(source)
    ---@diagnostic disable-next-line: param-type-mismatch
    return ESX.GetPlayerFromId(source)?.getGroup() == "superadmin" or IsPlayerAceAllowed(source, "command.lbtablet_admin") == 1
end

---@param identifier string
---@return { plate: string, type: string, vehicle: string }[]
function GetVehicles(identifier)
    return MySQL.query.await("SELECT plate, vehicle, `type` FROM owned_vehicles WHERE owner = ?", { identifier })
end

AddEventHandler("esx:playerLogout", function(source)
    PlayerLoggedOut(source)
end)

