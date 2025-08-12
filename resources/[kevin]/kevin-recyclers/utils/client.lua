local client = require 'shared.client'
local utils = {}

utils.notify = function(data)
    lib.notify({
        title = data.title or 'Notification',
        description = data.description or '',
        type = data.type or 'info',
        position = data.position or 'top',
        duration = data.duration or 3000,
    })
end

utils.progressBar = function(data)
    local success = lib.progressCircle({
        duration = data.duration,
        position = 'bottom',
        label = data.label,
        useWhileDead = false,
        canCancel = data.canCancel or true,
        disable = data.disable,
        anim = data.anim or nil,
        prop = data.prop or nil,
    })

    if success then
        if data.onSuccess then
            data.onSuccess()
        end
    else
        if data.onCancel then
            data.onCancel()
        end
    end
end

utils.createBlip = function(data)
    local blip = 0
    if data.entity then
        blip = AddBlipForEntity(data.entity)
    elseif data.coords and not data.radius then
        blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
    elseif data.radius then
        blip = AddBlipForRadius(data.coords.x, data.coords.y, data.coords.z, data.radius)
    end

    if not data.radius then
        SetBlipSprite(blip, data.sprite or 1)
        SetBlipScale(blip, data.scale or 1.0)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(data.name or 'Blip')
        EndTextCommandSetBlipName(blip)
    end

    SetBlipAlpha(blip, data.alpha or 255)
    SetBlipColour(blip, data.color or 1)

    SetBlipAsShortRange(blip, data.shortRange or true)
    SetBlipRoute(blip, data.route or false)
    SetBlipRouteColour(blip, data.routeColor or data.color)

    return blip
end

utils.createSphereZone = function(data)
    local zone = lib.zones.sphere({
        coords = vector3(data.coords.x, data.coords.y, data.coords.z),
        radius = data.radius or 30.0,
        debug = data.debug or false,
        onEnter = function()
            if data.onEnter then
                data.onEnter()
            end
        end,
        onExit = function()
            if data.onExit then
                data.onExit()
            end
        end,
        inside = function()
            if data.inside then
                data.inside()
            end
        end,
    })

    return zone
end

utils.createPoint = function(data)
    local coords = vector3(data.coords.x, data.coords.y, data.coords.z)
    local point = lib.points.new({
        coords = coords,
        distance = data.distance or 30.0,
    })
    
    if data.onEnter then
        function point:onEnter()
            data.onEnter(self)
        end
    end

    if data.onExit then
        function point:onExit()
            data.onExit(self)
        end
    end

    if data.nearby then
        function point:nearby()
            data.nearby(self)
        end
    end

    return point
end

utils.createObject = function(data)
    local model = data.model
    lib.requestModel(model, 20000)
    local object = CreateObject(model, data.coords.x, data.coords.y, data.coords.z - 1, false, false, false)
    SetEntityHeading(object, data.coords.w)
    SetEntityAsMissionEntity(object, true, true)
    FreezeEntityPosition(object, true)
    PlaceObjectOnGroundProperly(object)
    SetModelAsNoLongerNeeded(model)
    SetEntityAlpha(object, 0)

    CreateThread(function ()
        for i = 0, 255, 51 do
            Wait(50)
            SetEntityAlpha(object, i, false)
        end
    end)
    
    return object
end

utils.createPed = function(data)
    local model = data.model
    lib.requestModel(model, 20000)
    local ped = CreatePed(0, model, data.coords.x, data.coords.y, data.coords.z - 1, data.coords.w, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetModelAsNoLongerNeeded(model)

    return ped
end

utils.getTargetOptions = function(options)
    local targetOptions = {}
    for i = 1, #options do
        targetOptions[i] = {
            icon = options[i].icon,
            label = options[i].label,
            onSelect = options[i].onSelect,
            action = options[i].onSelect,
            canInteract = options[i].canInteract,
            distance = options[i].distance or 2.5,
        }
    end
    return targetOptions
end

utils.addLocalEntityTarget = function(data)
    if client.interaction.resource == 'ox' then
        exports.ox_target:addLocalEntity(data.entity, utils.getTargetOptions(data.options))
    elseif client.interaction.resource == 'qb' then
        exports['qb-target']:AddTargetEntity(data.entity, {
            options = utils.getTargetOptions(data.options),
            distance = client.interaction.distance,
        })
    end
end

utils.addBoxTarget = function(data)
    if client.interaction.resource == 'ox' then
        exports.ox_target:addBoxZone({
            name = data.name,
            coords = vec3(data.coords.x, data.coords.y, data.coords.z),
            size = vec3(data.size.x, data.size.y, data.size.z),
            rotation = data.rotation or 0.0,
            debug = false,
            options = utils.getTargetOptions(data.options),
        })
    elseif client.interaction.resource == 'qb' then
        exports['qb-target']:AddBoxZone(data.name, vector3(data.coords.x, data.coords.y, data.coords.z), data.size.x, data.size.y, {
            name = data.name,
            heading = data.rotation or 0.0,
            debugPoly = true,
            minZ = data.coords.z -1,
            maxZ = data.coords.z + 1,
        }, {
            options = utils.getTargetOptions(data.options),
            distance = 3.0
        })
    end
end

utils.drawText = function (text)
    lib.showTextUI(text, { position = 'left-center' })
end

utils.hideText = function ()
    lib.hideTextUI()
end

return utils