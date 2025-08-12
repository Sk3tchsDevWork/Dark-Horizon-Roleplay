local server = require 'shared.server'
local inventory = {}

if GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
end

if GetResourceState('ox_inventory') == 'started' then
    local function getRecycleFilerItems()
        local filterItems = {}
        for k, v in pairs(server.recycleables) do
            filterItems[k] = true

            for key, value in pairs(v.rewards) do
                filterItems[key] = true
            end
        end

        return filterItems
    end

    local swapItemsHook = exports.ox_inventory:registerHook('swapItems', function(payload)
        if payload.action ~= 'move' then return false end

        local item = payload.fromSlot.name:lower()
        local filterItems = getRecycleFilerItems()
        if not filterItems[item] then return false end

        if type(payload.toInventory) ~= 'number' then return true end
        if payload.toType ~= 'player' then return false end

        return true
    end, {
        inventoryFilter = {
            '^recycler_'
        },
    })
end

inventory.removeItem = function(source, item, count, slot, metadata)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:RemoveItem(source, item, count, metadata or nil, slot or nil)
    elseif GetResourceState('ps-inventory') == 'started' then
        local success = exports['ps-inventory']:RemoveItem(source, item, count, slot)
        if not success then return false end

        TriggerClientEvent('ps-inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'remove', count)
        return success
    elseif GetResourceState('ps-inventory') == 'started' then
        local success = exports['ps-inventory']:RemoveItem(source, item, count, metadata or nil, slot or nil)
        if not success then return false end

        TriggerClientEvent('ps-inventory:client:ItemBox', source, item, 'remove', count)
        return success
    end
end

inventory.addItem = function(source, item, count, metadata)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:AddItem(source, item, count, metadata or nil)
    elseif GetResourceState('ps-inventory') == 'started' then
        local success = exports['ps-inventory']:AddItem(source, item, count, metadata or nil)
        if not success then return false end
        
        TriggerClientEvent('ps-inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add', count)
        return success
    elseif GetResourceState('ps-inventory') == 'started' then
        local success = exports['ps-inventory']:AddItem(source, item, count, metadata or nil)
        if not success then return false end

        TriggerClientEvent('ps-inventory:client:ItemBox', source, item, 'add', count)
        return success
    end
end

inventory.registerShop = function(warehouse)
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:RegisterShop('recyclers', {
            name = warehouse.shop.name,
            inventory = warehouse.shop.items,
            vector3(warehouse.ped.coords.x, warehouse.ped.coords.y, warehouse.ped.coords.z),
        })
    elseif GetResourceState('ps-inventory') == 'started' then
        local items = {}
        for k, v in pairs(warehouse.shop.items) do
            items[v.name] = {
                name = v.name,
                amount = v.amount,
                price = v.price,
            }
        end
        
        exports['ps-inventory']:CreateShop({
            name = 'recyclers',
            label = warehouse.shop.name,
            coords = vector3(warehouse.ped.coords.x, warehouse.ped.coords.y, warehouse.ped.coords.z),
            slots = #warehouse.shop.items,
            items = items
        })
    elseif GetResourceState('ps-inventory') == 'started' then
        local items = {}
        for k, v in pairs(warehouse.shop.items) do
            items[v.name] = {
                name = v.name,
                amount = v.amount,
                price = v.price,
            }
        end
        
        exports['ps-inventory']:CreateShop({
            name = 'recyclers',
            label = warehouse.shop.name,
            coords = vector3(warehouse.ped.coords.x, warehouse.ped.coords.y, warehouse.ped.coords.z),
            slots = #warehouse.shop.items,
            items = items
        })
    end
end

inventory.registerStash = function(stashId)
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:RegisterStash(stashId, locale('inventoryTitle'), 15, 900000)
    end
end

inventory.hasItem = function(source, item, count)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:Search(source, 'count', item) >= count
    elseif GetResourceState('ps-inventory') == 'started' then
        return exports['ps-inventory']:HasItem(source, item, count)
    elseif GetResourceState('ps-inventory') == 'started' then
        return exports['ps-inventory']:HasItem(source, item, count)
    end
end

inventory.getItemCount = function(inventoryId, item)
    local result = nil
    local count = 0
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:GetItemCount(inventoryId, item)
    else
        result = MySQL.Sync.fetchAll('SELECT * FROM `inventories` WHERE `identifier` = ?', { inventoryId })
        if result then
            local tempItems = json.decode(result[1].items)
            for k, v in pairs(tempItems) do
                if v.name == item then
                    count = count + v.amount
                end
            end
        end
        return count
    end
end

inventory.getItemsFromInventory = function(inventoryId)
    local items = {}
    local result = nil
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:GetInventoryItems(inventoryId, false)
    else
        result = MySQL.Sync.fetchAll('SELECT * FROM `inventories` WHERE `identifier` = ?', { inventoryId })

        if result then
            local tempItems = json.decode(result[1].items)
            for k, v in pairs(tempItems) do
                items[k] = {
                    name = v.name,
                    amount = v.amount,
                }
            end
        end
    end
    return items or nil
end

RegisterNetEvent('kevin-recyclers:server:openShopInventory', function ()
    if GetResourceState('ps-inventory') == 'started' then
        return exports['ps-inventory']:OpenShop(source, 'recyclers')
    elseif GetResourceState('ps-inventory') == 'started' then
        return exports['ps-inventory']:OpenShop(source, 'recyclers')
    end
end)

RegisterNetEvent('kevin-recyclers:server:openInventory', function (inventoryId)
    exports['ps-inventory']:OpenInventory(source, inventoryId, {
        label = locale('inventoryTitle'),
        maxweight = 900000,
        slots = 15,
    })
end)

return inventory