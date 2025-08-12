local QBCore = nil
local ESX = nil

CreateThread(function()
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
    end
end)

lib.addCommand('setcraftlevel', {
    help = "Set a player's crafting XP level",
    restricted = "admin",
    params = {
        { name = "targetId", help = "Player ID", type = "playerId" },
        { name = "xp", help = "XP Amount", type = "number" }
    }
}, function(source, args)
    local src = source
    local targetId = args.targetId
    local xp = args.xp

    if not targetId or not xp then
        Notify(src, nil, Loc[Config.Lan]["SetlevelUsage"], "error")
        return
    end

    if QBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player and (QBCore.Functions.HasPermission and QBCore.Functions.HasPermission(src, "admin") or 
            QBCore.Permissions and QBCore.Permissions[src] and QBCore.Permissions[src].admin) then
            TriggerEvent('dynyx_craft:setlevel', targetId, xp)
        else
            Notify(src, nil, Loc[Config.Lan]["NoPermissions"], "error")
        end
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer and (xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin') then
            TriggerEvent('dynyx_craft:setlevel', targetId, xp)
        else
            Notify(src, nil, Loc[Config.Lan]["NoPermissions"], "error")
        end
    end
end)

function GetIdentifier(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return nil end
        return Player.PlayerData.citizenid
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return nil end
        return xPlayer.identifier
    end
    return nil
end

function Notify(src, Title, Desc, type)
    if Config.Notifications == "ox_lib" then
        TriggerClientEvent('ox_lib:notify', src, {
            title = Title,
            description = Desc,
            type = type,
            duration = 5000,
            position = "center-right"
        })
    elseif Config.Notifications == "qb-core" then
        TriggerClientEvent('QBCore:Notify', src, Desc, type)
    else
        print("Invalid Config.Notifications")
    end
end

function AddItem(source, item, quantity)
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:AddItem(source, item, quantity)
    elseif Config.Inventory == "ps-inventory" then
        exports['ps-inventory']:AddItem(source, item, quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "add")
    elseif Config.Inventory == "ps-inventory" then
        exports['ps-inventory']:AddItem(source, item, quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "add")
    elseif Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:AddItem(source, item, quantity)
    else
        print("Invalid Config.Inventory")
    end
end

function RemoveItem(source, item, quantity, slot)
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:RemoveItem(source, item, quantity, nil, slot)
    elseif Config.Inventory == "ps-inventory" then
        exports['ps-inventory']:RemoveItem(source, item, quantity, slot)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "remove")
    elseif Config.Inventory == "ps-inventory" then
        exports['ps-inventory']:RemoveItem(source, item, quantity, slot)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "remove")
    elseif Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:RemoveItem(source, item, quantity, slot)
    else
        print("Invalid Config.Inventory")
    end
end

function GetItemCount(source, material)
    if Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:Search(source, 'count', material) or 0
    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            local item = Player.Functions.GetItemByName(material)
            return item and item.amount or 0
        end
    elseif Config.Inventory == "qs-inventory" then
        local playerInventory = exports['qs-inventory']:GetInventory(source)
        if playerInventory then
            for itemName, itemData in pairs(playerInventory) do   
                if itemData.name == material then
                    return itemData.amount or 0
                end
            end
        end    
    else
        print("Invalid Config.Inventory")
    end
    return 0
end

CreateThread(function()
    if Config.Inventory == "ox_inventory" then
        exports('usetable', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                TriggerClientEvent('dynyx_crafting:placeTable', inventory.id, item.name, slot)
                return false
            end
        end)
    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        if Config.PlaceableTables then
            for tableName, tableData in pairs(Config.PlaceableTables) do
                QBCore.Functions.CreateUseableItem(tableName, function(source, item)
                    local Player = QBCore.Functions.GetPlayer(source)
                    if not Player then return end
                    if not Player.Functions.GetItemByName(item.name) then return end            
                    TriggerClientEvent('dynyx_crafting:placeTable', source, item.name, item.slot)
                end)
            end
        end
    
    elseif Config.Inventory == "qs-inventory" then
        if Config.PlaceableTables then
            for tableName, tableData in pairs(Config.PlaceableTables) do
                exports['qs-inventory']:CreateUsableItem(tableName, function(source, item)
                    TriggerClientEvent('dynyx_crafting:placeTable', source, item.name, item.slot)
                end)
            end
        end
    else
        print("Invalid Config.Inventory setting. Please use 'ox_inventory', 'ps-inventory', 'ps-inventory', or 'qs-inventory'.")
    end
end)
