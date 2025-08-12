if Config.JailScript ~= "rcore" then
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

    exports.rcore_prison:Jail(source, minutes, reason, officerSource)

    return true
end

---@param identifier string
---@return boolean success
function UnjailPlayer(identifier)
    local source = GetSourceFromIdentifier(identifier)

    if source then
        exports.rcore_prison:Unjail(source)
    else
        exports.rcore_prison:UnjailOffline(identifier)
    end

    return true
end

---@param identifier string
function GetRemainingPrisonSentence(identifier)
    local source = GetSourceFromIdentifier(identifier)

    if source then
        local jailData = exports.rcore_prison:GetPrisonerData(source)

        if not jailData then
            return 0
        end

        return jailData.jail_time or 0
    else
        local jailData = MySQL.scalar.await("SELECT data FROM rcore_prison WHERE owner = ?", { identifier })

        if not jailData then
            return 0
        end

        jailData = json.decode(jailData)

        return jailData.jail_time or 0
    end
end

AddEventHandler("rcore_prison:server:heartbeat", function(actionType, data)
    local prisoner = data.prisoner

    debugprint("rcore_prison:server:heartbeat", actionType, data)

    if not prisoner then
        return
    end

    Wait(1000) -- if updating via the tablet, use that data instead

    if actionType == "PRISONER_NEW" then
        LogJailed(prisoner.owner, prisoner.officerName, prisoner.jail_reason or "", prisoner.jail_time)
    elseif actionType == "PRISONER_RELEASED" then
        UpdateJailSentence(prisoner.owner, 0)
    end
end)
