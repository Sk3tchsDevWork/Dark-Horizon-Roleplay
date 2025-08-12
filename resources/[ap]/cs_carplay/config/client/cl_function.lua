WEATHER_TYPES = {
    { hash = -1750463879, name = "CLEAR"},
    { hash = 916995460, name = "CLOUDS"},
    { hash = -1530260698, name = "EXTRASUNNY"},
    { hash = -1148613331, name = "OVERCAST"},
    { hash = 1420204096, name = "RAIN"},
    { hash = -1233681761, name = "THUNDER"},
    { hash = -1368164796, name = "SNOW"},
    { hash = -1429616491, name = "XMAS"},
    -- Add more weather types as needed --
}

-- Fetch Vehicle Fuel --
function GetVehicleFuel(veh)
    local curFuel
    -- curFuel = exports['LegacyFuel']:GetFuel(veh)
    curFuel = GetVehicleFuelLevel(veh)
    return curFuel
end

-- Open Map --
RegisterNUICallback('openMap', function()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'),0,-1)
end)

-- Actions From AI --
function vehicleDoor(action)
    local playerPed = cache.ped
    local vehicle = cache.vehicle
    if action == 'all' then
        for door = 0, 7 do
            if not IsVehicleDoorDamaged(vehicle, door) then
                SetVehicleDoorOpen(vehicle, door, false, false)
            end
        end
    elseif action == 'closeall' then
        for door = 0, 7 do
            if not IsVehicleDoorDamaged(vehicle, door) then
                SetVehicleDoorShut(vehicle, door, false)
            end
        end
    elseif type(action) == 'number' then
        local doorIndex = tonumber(action)
        local isDoorOpen = GetVehicleDoorAngleRatio(vehicle, doorIndex) > 0.1
        if isDoorOpen then
            SetVehicleDoorShut(vehicle, doorIndex, false)
        else
            SetVehicleDoorOpen(vehicle, doorIndex, false, false)
        end
    elseif action == 'engineOn' then
        SetVehicleEngineOn(vehicle, true, false, true)
    elseif action == 'engineOff' then
        SetVehicleEngineOn(vehicle, false, false, true)
    end
end

if CodeStudio.Main.UseWithKey.Enable then
    local keybind = lib.addKeybind({
        name = 'carplay',
        description = 'press '..CodeStudio.Main.UseWithKey.Keybind..' to open car play',
        defaultKey = CodeStudio.Main.UseWithKey.Keybind,
        onPressed = function()
            TriggerEvent('cs:carplay:openUI')
        end,
    })
end

function InstallRadio(plate, install)
    progText = 'Installing'
    if not install then
        progText = 'Uninstalling'
    end
    ExecuteCommand('e mechanic')

    LocalPlayer.state:set("inv_busy", true, true)
    LocalPlayer.state.invBusy = true
    local qsInventoryEnabled = (GetResourceState('qs-inventory') == 'started')
    if qsInventoryEnabled then
        exports['qs-inventory']:setInventoryDisabled(true)
    end

    local success = lib.progressBar({
        duration = 5000,
        label = progText..' Car Play System',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, combat = true, car = true }
    })

    isDoing = false
    ClearPedTasks(cache.ped)
    LocalPlayer.state:set("inv_busy", false, true)
    LocalPlayer.state.invBusy = false
    if qsInventoryEnabled then
        exports['qs-inventory']:setInventoryDisabled(false)
    end

    if success then
        TriggerServerEvent('cs:carplay:addInstall', plate, install)
        if install then
            Notification('Radio Added to Vehicle')
        else
            Notification('Radio Removed from Vehicle')
        end
    else
        Notification('Cancelled')
    end
end

function Notification(msg)
    lib.notify({
        title = 'Car Play',
        description = msg
    })
end

function DisableControls()  -- Disable Certain Key when player is using car play
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

    DisableControlAction(2, 36, true) -- Disable going stealth

    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 257, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
    DisableControlAction(0, 75, true)  -- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle

    if IsPauseMenuActive() then
        SetPauseMenuActive(false)
    end

    SetVehicleRadioEnabled(cache.vehicle, false)
end

RegisterCommand('resetcarplay_ui', function()
    SendNUIMessage({action = "resetUI"})
    Notification('CarPlay UI Reset')
end, false)
