function DisableControls()  --Works if you enable EnableMouseControl in config
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1

    DisableControlAction(0, 45, true) -- Reload
    DisableControlAction(0, 22, true) -- Jump
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 23, true) -- Also 'enter'?

    DisableControlAction(0, 288, true) -- Disable phone
    DisableControlAction(0, 289, true) -- Inventory
    DisableControlAction(0, 170, true) -- Animations
    DisableControlAction(0, 167, true) -- Job

    DisableControlAction(0, 26, true) -- Disable looking behind
    DisableControlAction(0, 73, true) -- Disable clearing animation
    DisableControlAction(2, 199, true) -- Disable pause screen

    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle

    DisableControlAction(2, 36, true) -- Disable going stealth

    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 257, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
    DisableControlAction(0, 75, true)  -- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle
end


function Notificaton(msg)
    lib.notify({
        title = 'Documents',
        description = msg
    })
end

RegisterNetEvent('cs:documents:notification', function (msg)
    Notificaton(msg)
end)

function ManageUI_Animation()
    ClearPedTasks(cache.ped)

    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(cache.ped, v) then
            DeleteObject(v)
            DetachEntity(v, 0, 0)
            SetEntityAsMissionEntity(v, true, true)
            Wait(100)
            DeleteEntity(v)
        end
    end

    lib.requestAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
    TaskPlayAnim(cache.ped, "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", 3.0, -3.0, -1, 49, 0, 0, 0, 0)
    local model = `prop_cs_tablet`
    lib.requestModel(model)
    animProp = CreateObject(model, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(animProp, cache.ped, GetPedBoneIndex(cache.ped, 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,false, true, 1, true)
end

function ViewDocument_Animation()
    ClearPedTasks(cache.ped)

    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(cache.ped, v) then
            DeleteObject(v)
            DetachEntity(v, 0, 0)
            SetEntityAsMissionEntity(v, true, true)
            Wait(100)
            DeleteEntity(v)
        end
    end

    lib.requestAnimDict("missfam4")
    TaskPlayAnim(cache.ped, "missfam4", "base", 3.0, -3.0, -1, 49, 0, 0, 0, 0)
    local model = `p_amb_clipboard_01`
    lib.requestModel(model)
    animProp = CreateObject(model, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(animProp, cache.ped, GetPedBoneIndex(cache.ped, 36029), 0.16, 0.08, 0.1, -130.0, -50.0, 0.0, true, true,false, true, 1, true)
end

function ClearAnimations()
    ClearPedTasks(cache.ped)

    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(cache.ped, v) then
            DeleteObject(v)
            DetachEntity(v, 0, 0)
            SetEntityAsMissionEntity(v, true, true)
            Wait(100)
            DeleteEntity(v)
        end
    end
end

lib.callback.register('cs:documents:getClosestPlayer', function()
    local nearPly = {}
    local nearby = lib.getNearbyPlayers(GetEntityCoords(cache.ped), 2.0, false)
    if #nearby == 0 then return end
    for _, v in pairs(nearby) do
        table.insert(nearPly, GetPlayerServerId(v.id))
    end
    return nearPly
end)