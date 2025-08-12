AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    TriggerServerEvent('dynyx_prison:server:loadPrisoners')
    Wait(1000)
    TriggerServerEvent('dynyx_prison:server:checkIfJailed')
    TriggerServerEvent('dynyx_prison:server:syncPeds')
end)

RegisterNUICallback('releasePrisoner', function(data, cb)
    local prisonerId = data.prisonerId
    if not prisonerId then return cb('error') end

    local targetCoords = nil
    local localPed = PlayerPedId()
    local localCoords = GetEntityCoords(localPed)

    for _, prisoner in ipairs(GetPrisonersData()) do
        if prisoner.id == prisonerId then
            if prisoner.source then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(prisoner.source))
                if targetPed then
                    targetCoords = GetEntityCoords(targetPed)
                end
            end
            break
        end
    end

    if Config.RequireOfficerNearbyToRelease and targetCoords then
        if #(localCoords - targetCoords) > 3.0 then
            Notify(Loc[Config.Lan]["notifi_actionfailed_release"].label, Loc[Config.Lan]["notifi_actionfailed_release"].text, 'error')
            return cb('too_far')
        end
    end

    if not HasRequiredJob() then
        Notify(Loc[Config.Lan]["notifi_access_denied_release"].label, Loc[Config.Lan]["notifi_access_denied_release"].text, 'error')
        return cb('unauthorized')
    end

    TriggerServerEvent('dynyx_prison:releasePrisoner', prisonerId)
    Notify(Loc[Config.Lan]["notifi_success_release"].label, Loc[Config.Lan]["notifi_success_release"].text, 'success')
    cb('ok')
end)

RegisterNUICallback('modifySentence', function(data, cb)
    local prisonerId = data.prisonerId
    local newSentence = tonumber(data.newSentence)
    if not prisonerId or not newSentence then return cb('error') end

    local targetCoords = nil
    local localPed = PlayerPedId()
    local localCoords = GetEntityCoords(localPed)

    for _, prisoner in ipairs(GetPrisonersData()) do
        if prisoner.id == prisonerId then
            if prisoner.source then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(prisoner.source))
                if targetPed then
                    targetCoords = GetEntityCoords(targetPed)
                end
            end
            break
        end
    end

    if Config.RequireOfficerNearbyToEditSentence and targetCoords then
        if #(localCoords - targetCoords) > 3.0 then
            Notify(Loc[Config.Lan]["notifi_actionfailed_modify"].label, Loc[Config.Lan]["notifi_actionfailed_modify"].text, 'error')
            return cb('too_far')
        end
    end

    if not HasRequiredJob() then
        Notify(Loc[Config.Lan]["notifi_access_denied_modify"].label, Loc[Config.Lan]["notifi_access_denied_modify"].text, 'error')
        return cb('unauthorized')
    end

    TriggerServerEvent('dynyx_prison:modifySentence', prisonerId, newSentence)
    Notify(Loc[Config.Lan]["notifi_success_modify"].label, Loc[Config.Lan]["notifi_success_modify"].text, 'success')
    cb('ok')
end)

RegisterNUICallback('sendToPrison', function(data, cb)
    local serverId = tonumber(data.serverId)
    local sentence = tonumber(data.sentence)
    local charges = data.charges
    local lifer = data.lifer
    local serviceType = data.serviceType
    local previousSentence = data.includePreviousSentence
    local fine = data.fine
    if not serverId or not sentence or not charges then return cb('error') end

    local targetPed = GetPlayerPed(GetPlayerFromServerId(serverId))

    if Config.RequireOfficerNearbyToJail then
        if not targetPed or #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targetPed)) > 3.0 then
            Notify(Loc[Config.Lan]["notifi_actionfailed_jail"].label, Loc[Config.Lan]["notifi_actionfailed_jail"].text, 'error')
            return cb('too_far')
        end
    end

    if not HasRequiredJob() then
        Notify(Loc[Config.Lan]["notifi_access_denied_jail"].label, Loc[Config.Lan]["notifi_access_denied_jail"].text, 'error')
        return cb('unauthorized')
    end

    TriggerServerEvent('dynyx_prison:addprisoner', serverId, sentence, charges, lifer, serviceType, previousSentence, fine)
    Notify(Loc[Config.Lan]["notifi_success_jail"].label, Loc[Config.Lan]["notifi_success_jail"].text, 'success')
    cb('ok')
end)

-- (qs-inventory Open Stash)
RegisterNetEvent('dynyx_prison:qsOpenStash', function(lockerID)
    local other = {}
    other.maxweight = Config.ToiletStashInfo.Weight
    other.slots = Config.ToiletStashInfo.Slots
    TriggerServerEvent("inventory:server:OpenInventory", "stash", lockerID, other)
    TriggerEvent("inventory:client:SetCurrentStash", lockerID)
end)

RegisterNetEvent('dynyx_prison:openTablet', function()
    exports['dynyx_prison']:OpenPrisonManageUI()
end)

if Config.UsePrisonCommand then
    RegisterCommand('prison', function()
        exports['dynyx_prison']:OpenPrisonManageUI()
    end)
end