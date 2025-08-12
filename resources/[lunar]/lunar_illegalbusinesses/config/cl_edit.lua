Editable = {}

local function isStarted(resourceName)
    return GetResourceState(resourceName) == 'started'
end

---Used to check if player is dead
---@param ped number
function Editable.isDead(ped)
    return IsEntityDead(ped)
        or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)
end

function Editable.hackingMinigame(minigame)
    if minigame == 'howdy-hackminigame' then
        return exports['howdy-hackminigame']:Begin(4, 5000)
    elseif minigame == 'memorygame' then
        local p = promise.new()
        exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
            function() -- success
                p:resolve(true)
            end,
            function() -- failure
                p:resolve(false)
            end
        )
        return Citizen.Await(p)
    end
end

function Editable.lockpickMinigame(minigame)
    if minigame == 'normal' then
        return exports['lockpick']:startLockpick()
    elseif minigame == 'quasar' then
        local p = promise.new()
        TriggerEvent('lockpick:client:openLockpick', function(success)
            p:resolve(success)
        end)
        return Citizen.Await(p)
    end

    return true
end

function Editable.setVehicleLockState(entity, state)
    SetVehicleDoorsLockedForAllPlayers(entity, state)
end

function Editable.addKeys(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)

    if isStarted('qb-vehiclekeys') then
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    end
end

function Editable.hideActiveWeapon()
    RemoveAllPedWeapons(cache.ped, false)
end

---@param name string
function Editable.openStash(name)
    if Editable.isDead(cache.ped) then
        return
    end

    if isStarted('ox_inventory') then
        exports.ox_inventory:openInventory('stash', name)
    elseif isStarted('ps-inventory')
        or isStarted('qs-inventory')
        or isStarted('ps-inventory')
        or isStarted('lj-inventory') then
        local data = Config.stash
        local name = data.shared and name or (name .. '_' .. Framework.getIdentifier())

        TriggerServerEvent('inventory:server:OpenInventory', 'stash', name, {
            label = Config.stash.label,
            maxweight = Config.stash.maxWeight,
            slots = Config.stash.slots
        })
        TriggerEvent("inventory:client:SetCurrentStash", name)
    else
        warn('Your inventory script doesn\t support stashes. ')
    end
end