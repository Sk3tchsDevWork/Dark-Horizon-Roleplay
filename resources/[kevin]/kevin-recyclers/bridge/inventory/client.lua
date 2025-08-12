local inventory = {}

inventory.hasItem = function(item, count)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:Search('count', item) >= count
    elseif GetResourceState('ps-inventory') then
        return exports['ps-inventory']:HasItem(item, count)
    elseif GetResourceState('ps-inventory') then
        return exports['ps-inventory']:HasItem(item, count)
    end
end

inventory.openShopInventory = function()
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:openInventory('shop', { type = 'recyclers'})
    elseif GetResourceState('ps-inventory') then
        TriggerServerEvent('kevin-recyclers:server:openShopInventory')
    end
end

inventory.openInventory = function(inventoryId)
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:openInventory('stash', inventoryId)
    elseif GetResourceState('ps-inventory') then
        TriggerServerEvent('kevin-recyclers:server:openInventory', inventoryId)
    end
end

return inventory