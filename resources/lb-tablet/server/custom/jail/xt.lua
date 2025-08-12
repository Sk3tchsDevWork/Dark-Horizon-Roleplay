if Config.JailScript ~= "xt" then
    return
end

---@param identifier string
---@param time integer The jail time in seconds
---@param reason string
---@param officerSource number
---@return boolean success
function JailPlayer(identifier, time, reason, officerSource)
    local minutes = math.floor(time / 60)
    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)

    if not qPlayer then
        MySQL.update.await("UPDATE players SET metadata = JSON_SET(metadata, '$.injail', ?) WHERE citizenid = ?", { minutes, identifier })
        return true
    end

    qPlayer.Functions.SetMetaData("injail", minutes)

    TriggerClientOXLibCallback("xt-prison:client:enterJail", qPlayer.PlayerData.source, minutes)

    return true
end

---@param identifier string
---@return boolean success
function UnjailPlayer(identifier)
    local source = GetSourceFromIdentifier(identifier)

    if not source then
        MySQL.update.await("UPDATE players SET metadata = JSON_SET(metadata, '$.injail', 0) WHERE citizenid = ?", { identifier })
        return true
    end

    TriggerClientOXLibCallback("xt-prison:client:exitJail", source, true)

    return true
end

---@param identifier string
---@return integer remainingTime seconds
function GetRemainingPrisonSentence(identifier)
    local source = GetSourceFromIdentifier(identifier)
    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)

    if qPlayer then
        return (qPlayer.Functions.GetMetaData("injail") or 0) * 60
    end

    local inJail = MySQL.scalar.await("SELECT JSON_EXTRACT(metadata, '$.injail') FROM players WHERE citizenid = ?", { identifier })

    inJail = tonumber(inJail or 0)

    return inJail * 60
end

---@param jailTime integer In minutes
RegisterNetEvent("prison:server:SetJailStatus", function(jailTime)
    local src = source
    local qPlayer = QB.Functions.GetPlayer(src)

    if not qPlayer then
        return
    end

    local citizenid = qPlayer.PlayerData.citizenid
    local inJail = GetJailed(citizenid)

    if inJail then
        debugprint("prison:server:SetJailStatus: Updating jail sentence for", citizenid, "to", jailTime)
        UpdateJailSentence(citizenid, jailTime * 60)
    end
end)

RegisterNetEvent("police:server:JailPlayer", function(playerId, time)
    local src = source
    local citizenid = GetIdentifier(src)
    local targetPlayer = QB.Functions.GetPlayer(playerId)
    local targetCitizenid = targetPlayer.PlayerData.citizenid

    if not citizenid or not targetPlayer or time <= 0 then
        return
    end

    Wait(1000)

    if targetPlayer.Functions.GetMetaData("injail") ~= time then
        return
    end

    LogJailed(targetCitizenid, citizenid, "Jailed", time * 60)
end)