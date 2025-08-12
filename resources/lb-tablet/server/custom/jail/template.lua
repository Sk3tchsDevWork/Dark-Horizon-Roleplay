if Config.JailScript ~= "JAIL_SCRIPT" then
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

    return false
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

    return 0
end
