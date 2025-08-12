if Config.JailScript ~= "qalle" then
    return
end

---@param identifier string
---@param time integer The jail time in seconds
---@param reason string
---@param officerSource number
---@return boolean success
function JailPlayer(identifier, time, reason, officerSource)
    local minutes = math.floor(time / 60)
    local source = GetSourceFromIdentifier(identifier)

    MySQL.update.await("UPDATE users SET jail = ? WHERE identifier = ?", { minutes, identifier })

    if source then
        TriggerClientEvent("esx-qalle-jail:jailPlayer", source, minutes)
    end

    return true
end

---@param identifier string
---@return boolean success
function UnjailPlayer(identifier)
    local source = GetSourceFromIdentifier(identifier)

    MySQL.update.await("UPDATE users SET jail = 0 WHERE identifier = ?", { identifier })

    if source then
        TriggerClientEvent("esx-qalle-jail:unJailPlayer", source)
    end

    return true
end

---@param identifier string
function GetRemainingPrisonSentence(identifier)
    local source = GetSourceFromIdentifier(identifier)
    local minutesRemaining = MySQL.scalar.await("SELECT jail FROM users WHERE identifier = ?", { identifier }) or 0

    return math.floor(minutesRemaining * 60)
end
