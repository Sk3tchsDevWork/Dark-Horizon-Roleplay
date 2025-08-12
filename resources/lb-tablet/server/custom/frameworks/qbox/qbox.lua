if Config.Framework ~= "qbox" then
    return
end

QB = exports["qb-core"]:GetCoreObject()

---@param source number
---@return string | nil
function GetIdentifier(source)
    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if qPlayer?.PlayerData?.citizenid then
        return qPlayer.PlayerData.citizenid
    else
        debugprint("Failed to get citizen id from source:", source)
    end
end

---@param identifier string
---@return number?
function GetSourceFromIdentifier(identifier)
    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)

    if qPlayer?.PlayerData?.source then
        return qPlayer.PlayerData.source
    end
end

---@param source number
---@return string firstname
---@return string lastname
function GetCharacterName(source)
    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer then
        return GetPlayerName(source), ""
    end

    local characterInfo = qPlayer.PlayerData.charinfo

    return characterInfo.firstname, characterInfo.lastname
end

---@param identifier string
---@return string?
function GetCharacterNameFromIdentifier(identifier)
    local characterInfo = QB.Functions.GetPlayerByCitizenId(identifier)?.PlayerData?.charinfo

    if not characterInfo then
        characterInfo = MySQL.scalar.await("SELECT charinfo FROM players WHERE citizenid = ?", { identifier })

        if characterInfo then
            characterInfo = json.decode(characterInfo)
        else
            return
        end
    end

    return characterInfo.firstname .. " " .. characterInfo.lastname
end

---@param source number
function IsAdmin(source)
    ---@diagnostic disable-next-line: param-type-mismatch
    return QB.Functions.HasPermission(source, "admin") or IsPlayerAceAllowed(source, "command.lbphone_admin") == 1
end

---@param identifier string
---@return { plate: string, type: string, vehicle: string }[]
function GetVehicles(identifier)
    local vehicles = MySQL.query.await("SELECT plate, vehicle, mods FROM player_vehicles WHERE citizenid = ?", { identifier })

    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        local vehicleData = QB.Shared.Vehicles[vehicle.vehicle]

        vehicle.vehicle = vehicle.mods
        vehicle.type = vehicleData?.category or "Unknown"
    end

    return vehicles
end

AddEventHandler("QBCore:Server:OnPlayerUnload", function(src)
    Wait(0)
    PlayerLoggedOut(src)
end)
