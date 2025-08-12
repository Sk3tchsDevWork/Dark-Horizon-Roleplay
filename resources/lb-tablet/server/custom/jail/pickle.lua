if Config.JailScript ~= "pickle" then
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

    exports.pickle_prisons:JailPlayer(source, minutes)

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
    local sentence = MySQL.scalar.await("SELECT time, sentence_date FROM pickle_prisons WHERE identifier = ?", { identifier })

    if not sentence then
        return 0
    end

    local timeLeft = sentence.time - (os.time() - sentence.sentence_date)

    return math.max(0, timeLeft)
end
