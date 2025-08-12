if Config.JailScript ~= "esx" then
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

    if not source then
        return false
    end

    TriggerEvent("esx_jail:sendToJail", source, minutes)

    return true
end

---@param identifier string
---@return boolean success
function UnjailPlayer(identifier)
    local source = GetSourceFromIdentifier(identifier)

    return false
end

---@param identifier string
---@return integer remainingTime seconds
function GetRemainingPrisonSentence(identifier)
    local source = GetSourceFromIdentifier(identifier)

    return MySQL.scalar.await("SELECT jail_time FROM users WHERE identifier = ?", { identifier }) or 0
end
