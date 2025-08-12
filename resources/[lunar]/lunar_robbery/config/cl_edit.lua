local fontId = nil

--Change this only if u want to use a custom font.
AddEventHandler('onClientResourceStart', function()
    RegisterFontFile('roboto')
    fontId = RegisterFontId('Roboto')
end)

function Draw3DText(pos, text, lineCount)
	SetTextScale(0.4, 0.25)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
    SetDrawOrigin(pos.x, pos.y, pos.z, false)
    local factor = (string.len(text)) / 250
    DrawRect(0.0,0.0105, 0.003+ factor, 0.03, 0, 0, 0, 150)
	DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

--Return true if success
function ATMMinigame()
    local p = promise.new()
    TriggerEvent('utk_fingerprint:Start', 2, 6, 2, function(outcome, reason)
        Wait(3500) --This wait is not mandatory, only used for timing
        p:resolve(outcome)
    end)
    return Citizen.Await(p)
end

function BankMinigame()
    local p = promise.new()
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start", 7, 35, function(success)
        TriggerEvent("mhacking:hide")
        Wait(1000)
        p:resolve(success)
    end)
    return Citizen.Await(p)
end

function CarMinigame()
    return lib.skillCheck({'easy', 'medium', 'medium', 'medium', 'medium'}, { 'e' })
end

--Return true if success
function UnlockDoorMinigame()
    local result = exports['lockpick']:startLockpick()
    return result
end

function ATMCanInteract(entity)
    return not Config.ATMs.RequiredItem or Framework.hasItem(Config.ATMs.RequiredItem)
end

local vehicleBlip = nil

RegisterNetEvent('lunar_robbery:dispatch:updateVehicleBlip')
AddEventHandler('lunar_robbery:dispatch:updateVehicleBlip', function(coords, data)
    if Utils.isPolice() then
        if vehicleBlip ~= nil then
            vehicleBlip.remove()
        end
        vehicleBlip = Utils.createBlip(coords, {
            Name = data.Text,
            Sprite = data.Sprite,
            Size = data.Scale,
            Color = data.Colour
        })
        SetBlipDisplay(vehicleBlip.value, 6)
    end
end)

RegisterNetEvent('lunar_robbery:dispatch:removeVehicleBlip')
AddEventHandler('lunar_robbery:dispatch:removeVehicleBlip', function(id, data)
    if vehicleBlip ~= nil then
        vehicleBlip.remove()
    end
end)