if Config.Framework ~= "standalone" then
    return
end

---@param source number
---@return string | nil
function GetIdentifier(source)
    ---@diagnostic disable-next-line: param-type-mismatch
    return GetPlayerIdentifierByType(source, "license")
end

---@param identifier string
---@return number?
function GetSourceFromIdentifier(identifier)
    local players = GetPlayers()

    for i = 1, #players do
        ---@diagnostic disable-next-line: param-type-mismatch
        if GetIdentifier(players[i]) == identifier then
            ---@diagnostic disable-next-line: return-type-mismatch
            return players[i]
        end
    end
end

---@param source number
---@return string firstname
---@return string lastname
function GetCharacterName(source)
    local firstname = GetPlayerName(source)
    local lastname = tostring(source)

    return firstname, lastname
end

---@param identifier string
---@return string?
function GetCharacterNameFromIdentifier(identifier)
    return MySQL.scalar.await("SELECT CONCAT(firstname, ' ', lastname) FROM lbtablet_registration_characters WHERE character_id = ?", { identifier })
end

---@param source number
function IsAdmin(source)
    ---@diagnostic disable-next-line: param-type-mismatch
    return IsPlayerAceAllowed(source, "command.lbtablet_admin") == 1
end

---@param identifier string
---@return { plate: string, type: string, vehicle: string }[]
function GetVehicles(identifier)
    return MySQL.query.await("SELECT plate, model, color FROM lbtablet_registration_vehicles WHERE character_id = ?", { identifier })
end
