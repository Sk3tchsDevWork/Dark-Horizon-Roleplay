if not Config.BaseDispatch or not Config.BaseDispatch.Enabled then
    return
end

---@type { [number]: number }
local dispatchPhoneEntities = {}

local function DeletePlayerPhoneObject(source)
    if not dispatchPhoneEntities[source] then
        return
    end

    DeleteEntity(dispatchPhoneEntities[source])

    dispatchPhoneEntities[source] = nil
end

RegisterNetEvent("lb-tablet:baseDispatch:deletePhoneObject", function()
    local src = source

    DeletePlayerPhoneObject(src)
end)

RegisterCallback("baseDispatch:createPhoneObject", function(source)
    if not Config.ServerSideSpawn then
        return
    end

    if dispatchPhoneEntities[source] then
        return
    end

    local spawnCoords = GetEntityCoords(GetPlayerPed(source)) - vector3(0.0, 0.0, 5.0)
    local phoneEntity = CreateObject(`prop_amb_phone`, spawnCoords.x, spawnCoords.y, spawnCoords.z, true, true, false)

    if not WaitForEntity(phoneEntity) then
        DeleteEntity(phoneEntity)

        return infoprint("warning", "Failed to create phone object (timed out).")
    end

    SetEntityIgnoreRequestControlFilter(phoneEntity, true)

    dispatchPhoneEntities[source] = phoneEntity

    return NetworkGetNetworkIdFromEntity(phoneEntity)
end)

RegisterCallback("baseDispatch:callPolice", function(source, networkId)
    local ped = NetworkGetEntityFromNetworkId(networkId)

    if not ped or ped == 0 or not DoesEntityExist(ped) then
        debugprint("baseDispatch:requestControlOfPed: Invalid ped with network ID", networkId, "for source", source)
        return false
    end

    local populationType = GetEntityPopulationType(ped)

    if populationType ~= 4 and populationType ~= 5 then
        debugprint("baseDispatch:requestControlOfPed: Invalid population type", populationType, "for source", source)
        return false
    end

    local owner = NetworkGetEntityOwner(ped)
    local phoneEntity

    if not owner or not GetPlayerName(owner) then
        owner = source
    end

    local success = AwaitClientCallback("baseDispatch:callPolice", owner, networkId, phoneEntity and NetworkGetNetworkIdFromEntity(phoneEntity))

    if phoneEntity then
        DeleteEntity(phoneEntity)
    end

    return success
end, true)

local cooldowns = {}

---@param action string
local function IsDispatchOnCooldown(action)
    local actionData = Config.BaseDispatch.Actions[action]
    local cooldown = (actionData and actionData.serverCooldown or 5) * 1000
    local currentTime = GetGameTimer()

    if cooldowns[action] then
        local lastTime = cooldowns[action]

        if currentTime - lastTime < cooldown then
            return true
        end
    end

    cooldowns[action] = currentTime

    return false
end

---@param action string
---@param data NewDispatchOptions
RegisterNetEvent("lb-tablet:addBaseDispatch", function(action, data)
    if not action or not data then
        debugprint("addBaseDispatch: Invalid action or data")
        return
    end

    if not Config.BaseDispatch.Actions[action] then
        debugprint("addBaseDispatch: Action not found:", action)
        return
    end

    if IsDispatchOnCooldown(action) then
        debugprint("addBaseDispatch skipped due to cooldown for action:", action)
        return
    end

    local actionData = Config.BaseDispatch.Actions[action]

    data.priority = actionData.dispatch.priority or "medium"
    data.sound = actionData.dispatch.sound

    if actionData.police then
        data.job = "police"

        AddDispatch(data)
    end

    if actionData.ambulance then
        data.job = "ambulance"

        AddDispatch(data)
    end
end)

local explosionOptions = Config.BaseDispatch.Actions.Explosion

---@param sender number
---@param data { posX: number, posY: number, posZ: number, explosionType: number }
local function ExplosionEvent(sender, data)
    if not sender or not data or not data.posX or not data.posY or not data.posZ then
        return
    end

    if IsDispatchOnCooldown("Explosion") then
        debugprint("Explosion dispatch skipped due to cooldown")
        return
    end

    local senderPed = GetPlayerPed(sender)

    if not senderPed or senderPed == 0 then
        debugprint("Explosion: invalid sender ped. Sender:", sender)
        return
    end

    local coords = vector3(data.posX, data.posY, data.posZ)

    if #(coords - vector3(0.0, 0.0, 0.0)) < 10 then
        debugprint("Explosion is too close to origin, using player coords")

        coords = GetEntityCoords(senderPed)
    end

    if explosionOptions.ignoredExplosions and table.contains(explosionOptions.ignoredExplosions, data.explosionType) then
        debugprint("Explosion type ignored:", data.explosionType)
        return
    end

    local locationName = AwaitClientCallback("getLocationName", sender, coords) or "Unknown Location"

    debugprint("Explosion at", locationName)

    local args = {
        location = locationName,
    }

    ---@type NewDispatchOptions
    local dispatchData = {
        job = "police",
        priority = explosionOptions.dispatch.priority or "medium",
        title = L("BACKEND.BASE_DISPATCH.EXPLOSION.TITLE", args),
        description = L("BACKEND.BASE_DISPATCH.EXPLOSION.DESCRIPTION", args),
        code = L("BACKEND.BASE_DISPATCH.EXPLOSION.CODE"),
        location = {
            label = locationName,
            coords = coords.xy
        },
        time = explosionOptions.dispatch.time or 300
    }

    if explosionOptions.police then
        AddDispatch(dispatchData)
    end

    if explosionOptions.ambulance then
        dispatchData.job = "ambulance"

        AddDispatch(dispatchData)
    end
end

if explosionOptions then
    AddEventHandler("explosionEvent", ExplosionEvent)
end

OnPlayerDisconnect(function(source)
    DeletePlayerPhoneObject(source)
end)
