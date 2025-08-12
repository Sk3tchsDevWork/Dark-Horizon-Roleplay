local busy = false

function canUseSpray(gang)
    dbug('canUseSpray(gang)', gang)
    local canUse = true
    -- Here you can add a check that prevents the player from using the spray
    -- This is just an EXAMPLE. We're only going to allow the player to place the spray if they are close to another graffiti owned by the same gang
    --[[
    local graffitis = lib.callback.await('av_gangs:getGraffitis', false, gang)
    if graffitis and next(graffitis) then
        dbug("The gang have some graffitis...")
        canUse = false
        local myCoords = GetEntityCoords(cache.ped)
        for _, v in pairs(graffitis) do
            local gCoords = v['coords']
            local distance = #(myCoords - vector3(gCoords['x'], gCoords['y'], gCoords['z']))
            dbug('distance?', distance)
            if distance <= (Config.ZoneRadius + 20.0) then
                canUse = true
                break
            end
        end
    end
    dbug("canUse?", canUse)
    if not canUse then
        TriggerEvent('av_laptop:notification', Lang['app_title'], "You need to be close to another graffiti to use this.", 'error')
    end
    ]]--
    return canUse
end

function applySpray() -- Apply Spray
    dbug('applySpray()')
    if busy then
        dbug("Player is busy, return false")
        return false
    end
    lib.requestAnimDict("anim@scripted@freemode@postertag@graffiti_spray@male@")
    lib.requestModel(`prop_cs_spray_can`, 10000)
    local prop = CreateObject(`prop_cs_spray_can`, GetEntityCoords(cache.ped), true, true, true)
    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0, true, true, false, false, 1, true)
    sendDispatch('apply')
    dbug("progress1...")
    local progress1 = progressBar("anim@scripted@freemode@postertag@graffiti_spray@male@", "shake_can_male", 15000)
    dbug("progress1 result", progress1)
    if progress1 then
        ClearPedTasks(cache.ped)
        lib.requestAnimDict("anim@scripted@freemode@postertag@graffiti_spray@male@")
        dbug("Trigger progress2..")
        local progress2 = progressBar("anim@scripted@freemode@postertag@graffiti_spray@male@", "spray_can_var_01_male", Config.PlaceSprayTime * 1000)
        dbug('progress2 result', progress2)
        ClearPedTasks(cache.ped)
        DeleteObject(prop)
        SetModelAsNoLongerNeeded(`prop_cs_spray_can`)
        busy = false
        return progress2
    else
        dbug("progress1 returned false, cancel process")
        ClearPedTasks(cache.ped)
        DeleteObject(prop)
        SetModelAsNoLongerNeeded(`prop_cs_spray_can`)
        busy = false
        return false
    end
end

function removeSpray(gang, identifier) -- Remover function
    dbug("removeSpray(gang, identifier)", gang, identifier)
    if PlayerGang then
        local gangOnline = lib.callback.await('av_gangs:getOnline', false, gang, "removeSpray")
        if gangOnline >= Config.MinMembersForRemover then
            TriggerServerEvent("av_gangs:deleteRemover")
            sendDispatch('removing')
            local res = progressBar("amb@world_human_maid_clean@", "base", Config.RemoveSprayTime * 1000)
            dbug("Anim result?", res)
            if res then
                TriggerServerEvent('av_gangs:removeGraffiti', gang, identifier)
            end
        else
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['not_enough_enemies'],"error")
        end
    else
        TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['not_gang_remover'],"error")
    end
end

function progressBar(dict, anim, duration)
    local waiting = true
    local res = false
    if lib[Config.ProgressType]({
        duration = duration,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
        },
        anim = {
            dict = dict,
            clip = anim,
            flag = 1,
        },
        prop = {
        },
    }) then
        if not exports['av_laptop']:isDead() then
            res = true
            waiting = false
        end
    else
        waiting = false
    end
    while waiting do Wait(50) end
    return res
end