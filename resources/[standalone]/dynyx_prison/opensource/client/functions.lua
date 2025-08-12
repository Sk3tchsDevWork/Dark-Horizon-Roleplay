local QBCore = nil
local ESX = nil
CreateThread(function()
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            TriggerServerEvent('dynyx_prison:server:loadPlayerPrisonData')
            Wait(1000)
            TriggerServerEvent('dynyx_prison:server:checkIfJailed')
            TriggerServerEvent('dynyx_prison:server:syncPeds')
        end)
        RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
            TriggerServerEvent('dynyx_prison:server:unloadPlayerPrisonData')
        end)
    elseif GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
        RegisterNetEvent('esx:playerLoaded', function()
            TriggerServerEvent('dynyx_prison:server:loadPlayerPrisonData')
            Wait(1000)
            TriggerServerEvent('dynyx_prison:server:checkIfJailed')
            TriggerServerEvent('dynyx_prison:server:syncPeds')
        end)
    end
end)

local activeProp = nil
local activeAnim = nil
local activeDict = nil

function Notify(Title, Desc, type)
    if Config.Notifications == "ox_lib" then
        lib.notify({
            title = Title,
            description = Desc,
            type = type,
            duration = 5000,
            position = "center-right"
        })
    elseif Config.Notifications == "qb-core" then
        QBCore.Functions.Notify({text = Title, caption = Desc}, 'type', 5000)
    else
        print("Invalid Config.Notifications")
    end
end

function SendDispatchAlert(coords, message)
    if Config.Dispatch == "ps-dispatch" then
        exports['ps-dispatch']:PrisonBreak()
    elseif Config.Dispatch == "cd_dispatch" then
        local playerData = exports['cd_dispatch']:GetPlayerInfo()
        local notificationData = {
            job_table = { 'police' },
            coords = coords,
            title = '10-35 - Prison Alert',
            message = message,
            flash = 0,
            unique_id = playerData.unique_id,
            sound = 1,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = '911 - Prison Alert',
                time = 5,
                radius = 0
            }
        }
        TriggerServerEvent('cd_dispatch:AddNotification', notificationData)

    elseif Config.Dispatch == "qs-dispatch" then
        exports['qs-dispatch']:PrisonBreak()
    elseif Config.Dispatch == "tk_dispatch" then
        exports['tk_dispatch']:addCall({
            title = 'Prison Alert',
            code = '10-35',
            priority = 'Priority 2',
            coords = coords,
            showLocation = true,
            showGender = true,
            playSound = true,
            blip = {
                color = 3,
                sprite = 357,
                scale = 1.0
            },
            jobs = { 'police' }
        })
    elseif Config.Dispatch == "rcore_dispatch" then
        local alertData = {
            code = '10-35',
            default_priority = 'high',
            coords = coords,
            job = 'police',
            text = message,
            type = 'alerts',
            blip_time = 5,
            blip = {
                sprite = 54,
                colour = 3,
                scale = 0.7,
                text = 'Prison Alert',
                flashes = false,
                radius = 0
            }
        }
        TriggerServerEvent('rcore_dispatch:server:sendAlert', alertData)
    elseif Config.Dispatch == "false" then

    else
        print("Invalid dispatch system configured!")
    end
end

function GetIdentifier()
    if QBCore then
        return QBCore.Functions.GetPlayerData().citizenid
    elseif ESX then
        local data = ESX.GetPlayerData()
        return data.identifier
    end
end

function GetItemCount(itemN)
    if Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:Search('count', itemN) or 0

    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        local items = QBCore.Functions.GetPlayerData().items
        for _, v in pairs(items) do
            if v.name == itemN then
                return v.amount or 0
            end
        end

    elseif Config.Inventory == "qs-inventory" then
        local inventory = exports['qs-inventory']:getUserInventory()
        if inventory then
            for _, itemData in pairs(inventory) do
                if itemData.name == itemN then
                    return itemData.amount or 0
                end
            end
        end

    else
        print("Invalid Config.Inventory")
    end

    return 0
end

function Reloadskin()
    ExecuteCommand("reloadskin")
end

function retrieveItems()
    TriggerServerEvent('dynyx_prison:server:retrievePrisonItems')
end

function ApplyPrisonClothes()
    local ped = PlayerPedId()
    local gender = IsPedModel(ped, `mp_f_freemode_01`) and "female" or "male"
    local uniform = Config.PrisonUniform[gender]

    if not uniform then return end

    local componentMap = {
        ["mask"]     = 1,
        ["t-shirt"]  = 8,
        ["torso"]    = 11,
        ["decals"]   = 10,
        ["arms"]     = 3,
        ["pants"]    = 4,
        ["shoes"]    = 6,
        ["bag"]      = 5,
        ["chain"]    = 7,
    }

    local propMap = {
        ["helmet"]    = 0,
        ["glasses"]   = 1,
        ["watch"]     = 6,
        ["bracelet"]  = 7,
    }

    -- Set clothing components
    for name, data in pairs(uniform) do
        local componentId = componentMap[name]
        if componentId and data.item ~= -1 then
            SetPedComponentVariation(ped, componentId, data.item, data.texture or 0, 2)
        end
    end

    -- Set props
    for name, data in pairs(uniform) do
        local propId = propMap[name]
        if propId then
            if data.item == -1 then
                ClearPedProp(ped, propId)
            else
                SetPedPropIndex(ped, propId, data.item, data.texture or 0, true)
            end
        end
    end
end

function HasRequiredJob()
    local playerData

    if QBCore then
        playerData = exports['qb-core']:GetCoreObject().Functions.GetPlayerData()
    elseif ESX then
        playerData = ESX.GetPlayerData()
    end

    for _, job in pairs(Config.RequiredJobs) do
        if playerData.job.name == job then
            return true
        end
    end
    return false
end

function loadPtfx(dict)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(10)
    end
    UseParticleFxAssetNextCall(dict)
end

function EndVisitation()
    Notify(Loc[Config.Lan]["notifi_visitation_end"].label, Loc[Config.Lan]["notifi_visitation_end"].text, 'error')
    DoScreenFadeOut(1000)
    Wait(1500)

    local ped = PlayerPedId()
    local randomCell = Config.CellsLoc[math.random(#Config.CellsLoc)]
    SetEntityCoords(ped, randomCell.x, randomCell.y, randomCell.z)
    SetEntityHeading(ped, randomCell.w)

    Wait(1000)
    DoScreenFadeIn(1000)
end

function FinishCleanCellsJob()
    Notify(Loc[Config.Lan]["notifi_job_complete_cleaning"].label, Loc[Config.Lan]["notifi_job_complete_cleaning"].text, 'success')
    SetPrisonJobActive(false, true)
    TriggerServerEvent('dynyx_prison:server:completeJob', 'clean_cells')
end

function FinishElectricianJob()
    Notify(Loc[Config.Lan]["notifi_job_complete_electrical"].label, Loc[Config.Lan]["notifi_job_complete_electrical"].text, 'success')
    SetPrisonJobActive(false, true)
    TriggerServerEvent('dynyx_prison:server:completeJob', 'electrician')
end

function FinishMoveBoxesJob()
    Notify(Loc[Config.Lan]["notifi_job_complete_boxes"].label, Loc[Config.Lan]["notifi_job_complete_boxes"].text, 'success')
    SetPrisonJobActive(false, true)
    TriggerServerEvent('dynyx_prison:server:completeJob', 'move_boxes')
end

function FinishFacilityRepairsJob()
    Notify(Loc[Config.Lan]["notifi_job_complete_repairs"].label, Loc[Config.Lan]["notifi_job_complete_repairs"].text, 'success')
    SetPrisonJobActive(false, true)
    TriggerServerEvent('dynyx_prison:server:completeJob', 'repair_walls')
end

function finishCommunityService()
    lib.hideTextUI()
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), Config.ComServReleaseCoords.x, Config.ComServReleaseCoords.y, Config.ComServReleaseCoords.z)
    SetEntityHeading(PlayerPedId(), Config.ComServReleaseCoords.w)
    DoScreenFadeIn(1000)
    Notify(Loc[Config.Lan]["notifi_comserv_complete"].label, Loc[Config.Lan]["notifi_comserv_complete"].text, 'success')
end

function EnterTunnel()
    local playerPed = PlayerPedId()
    SetTunnelState(true)
    
    DoScreenFadeOut(2000)
    Wait(1000)
    SetEntityCoords(playerPed, Config.PrisonBreakSystem.insideTunnel.TunnelEntrance.x, Config.PrisonBreakSystem.insideTunnel.TunnelEntrance.y, Config.PrisonBreakSystem.insideTunnel.TunnelEntrance.z, false, false, false, true)
    SetEntityHeading(PlayerPedId(), Config.PrisonBreakSystem.insideTunnel.TunnelEntrance.w)
    DoScreenFadeIn(1000)
end

function EnterTunnelKeyCardEscape()
    local playerPed = PlayerPedId()
    SetTunnelState(true)
    
    DoScreenFadeOut(2000)
    Wait(1000)
    SetEntityCoords(playerPed, Config.KeycardEscape.insideTunnel.TunnelEntrance.x, Config.KeycardEscape.insideTunnel.TunnelEntrance.y, Config.KeycardEscape.insideTunnel.TunnelEntrance.z, false, false, false, true)
    SetEntityHeading(PlayerPedId(), Config.KeycardEscape.insideTunnel.TunnelEntrance.w)
    DoScreenFadeIn(1000)
end  

function ExitTunnel()
    SetTunnelState(false)
    Notify(Loc[Config.Lan]["notifi_jailbreak_escaped"].label, Loc[Config.Lan]["notifi_jailbreak_escaped"].text, 'inform')
    TriggerServerEvent('dynyx_prison:server:markAsEscaped')
end

function PrisonBlip()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(Config.Blip.Coords.x, Config.Blip.Coords.y, Config.Blip.Coords.z)
        SetBlipSprite(blip, Config.Blip.Sprite)
        SetBlipDisplay(blip, Config.Blip.Display)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.Blip.Color)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blip.Label)
        EndTextCommandSetBlipName(blip)
    end
end

function PlayAnimWithProp(dict, anim, propModel, bone, pos, rot)
    local ped = PlayerPedId()
    activeDict = dict
    activeAnim = anim
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)
    RequestModel(propModel)
    while not HasModelLoaded(propModel) do Wait(0) end
    activeProp = CreateObject(propModel, GetEntityCoords(ped), true, true, true)

    AttachEntityToEntity(activeProp, ped, GetPedBoneIndex(ped, bone), pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, true, true, false, true, 1, true)
end

function StopAnimWithProp()
    local ped = PlayerPedId()

    if activeDict and activeAnim then
        ClearPedTasks(ped)
        RemoveAnimDict(activeDict)
    end

    if activeProp and DoesEntityExist(activeProp) then
        DeleteEntity(activeProp)
        activeProp = nil
    end

    activeDict = nil
    activeAnim = nil
end

function AddTargetToEntity(entity, options, distance)
    local formattedOptions = {}

    for _, option in pairs(options) do
        local formatted = {
            name = option.name,
            label = option.label,
            icon = option.icon,
            canInteract = option.canInteract,
            distance = distance
        }

        if Config.Target == "ox_target" then
            formatted.onSelect = option.onSelect
        elseif Config.Target == "qb-target" then
            formatted.action = option.onSelect
        end

        table.insert(formattedOptions, formatted)
    end

    if Config.Target == "ox_target" then
        exports.ox_target:addLocalEntity(entity, formattedOptions)
    elseif Config.Target == "qb-target" then
        exports['qb-target']:AddTargetEntity(entity, {
            options = formattedOptions,
            distance = distance
        })
    else
        print("Invalid target system in Config.Target")
    end
end

function AddTargetSphereZone(name, coords, radius, options, distance)
    local formattedOptions = {}

    for _, option in pairs(options) do
        local formatted = {
            name = option.name,
            label = option.label,
            icon = option.icon,
            canInteract = option.canInteract,
            distance = distance
        }

        if Config.Target == "ox_target" then
            formatted.onSelect = option.onSelect
        elseif Config.Target == "qb-target" then
            formatted.action = option.onSelect
        end

        table.insert(formattedOptions, formatted)
    end

    if Config.Target == "ox_target" then
        ZoneID = exports.ox_target:addSphereZone({
            name = name,
            coords = coords,
            radius = radius,
            debug = false,
            options = formattedOptions
        })
        return ZoneID
    elseif Config.Target == "qb-target" then
        exports['qb-target']:AddCircleZone(name, coords, radius, {
            name = name,
            debugPoly = false,
            useZ = true
        }, {
            options = formattedOptions,
            distance = distance
        })
    else
        print("Invalid target system in Config.Target")
    end
end

function RemoveTargetOptionFromEntity(entity, labels)
    if Config.Target == "ox_target" then
        exports.ox_target:removeLocalEntity(entity)
    elseif Config.Target == "qb-target" then
        exports['qb-target']:RemoveTargetEntity(entity, labels)
    else
        print("Invalid target system in Config.Target")
    end
end

function RemoveTargetZone(zoneID, ZoneName)
    if Config.Target == "ox_target" then
        exports.ox_target:removeZone(zoneID)
    elseif Config.Target == "qb-target" then
        exports['qb-target']:RemoveZone(ZoneName)
    else
        print("Invalid target system in Config.Target")
    end
end

function GetImagePath()
    local imagePath = Config.InventoryImagePath
    if not string.find(imagePath, "nui://") then
        imagePath = "nui://" .. imagePath
    end
    return imagePath
end

function StartProgressBar(label, duration, animation, disableControls)
    label = label or "Processing..."
    duration = duration or 5000
    disableControls = disableControls or {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }

    if Config.ProgressBar == "ox_lib" then
        local success = lib.progressBar({
            duration = duration,
            label = label,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = disableControls.disableCarMovement,
                move = disableControls.disableMovement,
                mouse = disableControls.disableMouse,
                combat = disableControls.disableCombat,
            },
            anim = animation and {
                dict = animation.animDict,
                clip = animation.anim
            } or nil
        })

        return success 

    elseif Config.ProgressBar == "qb-core" then
        local p = promise.new()
        QBCore.Functions.Progressbar("custom_task", label, duration, false, true, disableControls, animation or {}, {}, {}, function()
            p:resolve(true)
        end, function()
            p:resolve(false)
        end)
        return Citizen.Await(p)
    else
        print("Invalid Config.ProgressBar. Must be 'ox_lib' or 'qb-core'")
        return false
    end
end