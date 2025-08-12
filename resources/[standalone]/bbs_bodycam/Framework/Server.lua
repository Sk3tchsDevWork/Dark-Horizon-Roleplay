Framework = {}
local QBCore, ESX
CreateThread(function()
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbox') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('es_extended') == 'started' then
        if exports['es_extended'] and exports['es_extended']:getSharedObject() then
            ESX = exports['es_extended']:getSharedObject()
        else
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
            end)
        end
    end
end)

if Config.ItemSettings.Enabled then
    -- Register The Items!
    if GetResourceState('ox_inventory') == 'started' and exports.ox_inventory then -- checkout ox_items file inside the folder. and add it to your ox_inventory.
        exports('GovermentCam', function(event, item, inventory, slot, data)
            if event == 'usingItem' and inventory.type == 'player' and Config.ItemSettings.JobAssociatedItems[item.name] then
                return StartStreamForJob(inventory.player.source)
            end
        end)
        exports('CommercialCam', function(event, item, inventory, slot, data)
            if event == 'usingItem' and inventory.type == 'player' and Config.ItemSettings.CommercialUseItems[item.name] then
                return StartStreamForCommercial(inventory.player.source)
            end
        end)
        local filterItems = Config.ItemSettings.CommercialUseItems
        for item, _ in pairs(Config.ItemSettings.JobAssociatedItems) do
            filterItems[item] = true
        end
        exports.ox_inventory:registerHook('swapItems', function(payload)
            if payload.source and GetPlayerPed(payload.source) then
                CheckStreamingItems(payload.source)
            end
            return true
        end, {
            itemFilter = filterItems,
        })
    elseif GetResourceState('ps-inventory') == 'started' or GetResourceState('ps-inventory') == 'started' then
        local items = {}
        while not QBCore do Wait(100) end
        for govermentItem, _ in pairs(Config.ItemSettings.JobAssociatedItems) do
            items[govermentItem] = {
                name = govermentItem, -- do not Change this line
                label = 'Goverment Issued Bodycam',
                weight = 20,
                type = 'item',
                image = govermentItem .. '.png', -- can be find in the /itemicons folder, move them to ps-inventory/html/images
                unique = true,
                useable = true,
                shouldClose = true,
                combinable = nil,
            }
            QBCore.Functions.CreateUseableItem(
                govermentItem,
                function(source, item)
                    StartStreamForJob(source)
                end
            )
        end
        for commercialItem, _ in pairs(Config.ItemSettings.CommercialUseItems) do
            items[commercialItem] = {
                name = commercialItem, -- do not Change this line
                label = 'Commercial available Bodycam',
                weight = 20,
                type = 'item',
                image = commercialItem .. '.png', -- can be find in the /itemicons folder, move them to ps-inventory/html/images
                unique = true,
                useable = true,
                shouldClose = true,
                combinable = nil,
            }
            QBCore.Functions.CreateUseableItem(
                commercialItem,
                function(source, item)
                    StartStreamForCommercial(source)
                end
            )
        end
        QBCore.Functions.AddItems(items)

        AddEventHandler('QBCore:Player:SetPlayerData', function(playerData)
            CheckStreamingItems(playerData.source, playerData.items) -- Check If we should stop stream if the player has no bodycam items.
        end)
    elseif GetResourceState('qs-inventory') == 'started' then
        for govermentItem, _ in pairs(Config.ItemSettings.JobAssociatedItems) do
            exports['qs-inventory']:CreateUsableItem(govermentItem, function(source, item)
                StartStreamForJob(source)
            end)
        end
        for commercialItem, _ in pairs(Config.ItemSettings.CommercialUseItems) do
            exports['qs-inventory']:CreateUsableItem(commercialItem, function(source, item)
                StartStreamForCommercial(source)
            end)
        end
        AddEventHandler('ps-inventory:server:itemRemoved', function(source, item, amount, totalAmount)
            if Config.ItemSettings.CommercialUseItems[item] or Config.ItemSettings.JobAssociatedItems[item] then
                CheckStreamingItems(source)
            end -- Check If we should stop stream if the player has no bodycam items.
        end)
    elseif GetResourceState('es_extended') == 'started' then
        for govermentItem, _ in pairs(Config.ItemSettings.JobAssociatedItems) do
            ESX.RegisterUsableItem(govermentItem, function(playerId)
                StartStreamForJob(playerId)
            end)
        end
        for commercialItem, _ in pairs(Config.ItemSettings.CommercialUseItems) do
            ESX.RegisterUsableItem(commercialItem, function(playerId)
                StartStreamForCommercial(playerId)
            end)
        end
        AddEventHandler('esx:onRemoveInventoryItem', function(source, itemname)
            if Config.ItemSettings.CommercialUseItems[itemname] or Config.ItemSettings.JobAssociatedItems[itemname] then
                CheckStreamingItems(source)
            end -- Check If we should stop stream if the player has no bodycam items.
        end)
    else
        -- Add your custom inventory item register here
    end
    Framework.HasItem = function(src, item, count)
        local _item = nil
        if GetResourceState('ox_inventory') == 'started' then
            _item = exports.ox_inventory:GetItem(src, item)
            if _item and _item.count then return _item.count >= count end
        elseif GetResourceState('ps-inventory') == 'started' or GetResourceState('ps-inventory') == 'started' then
            local Player = QBCore.Functions.GetPlayer(src)
            local foundItem = Player.Functions.GetItemByName(item)
            if foundItem then
                _item = foundItem.amount
                return _item >= count
            end
        elseif GetResourceState('qs-inventory') == 'started' then
            _item = exports['qs-inventory']:GetItemTotalAmount(src, item)
            return _item >= count
        elseif GetResourceState('es_extended') == 'started' then
            _item = ESX.GetPlayerFromId(src).getInventoryItem(item).count
            return _item >= count
        else
            -- Add your custom inventory check here
        end
        return false
    end
end
Framework.GetPlayerJob = function(source)
    local job, grade,gradeName
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        job = Player.PlayerData.job.name
        grade = Player.PlayerData.job.grade.level
        gradeName = Player.PlayerData.job.grade.name
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        local jobtbl = xPlayer.getJob()
        job = jobtbl.name
        grade = jobtbl.grade
        gradeName = jobtbl.grade_label
    end
    return job, grade,gradeName
end
Framework.DoJobCheck = function(player, jobs)
    local job, grade,_ = Framework.GetPlayerJob(player)
    if jobs[job] then
        if type(jobs[job]) == "table" then -- Check Grade
            for _, gr in pairs(jobs[job]) do
                if gr == grade then return true end
            end
        else
            return true
        end
    end
    return false
end

-- Player name used in job associated streams.
Framework.GetPlayerName = function(source)
    local name
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)

        name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(source)

        name = xPlayer.getName()
    else
        name = GetPlayerName(source)
    end
    return name
end
-- If there is not badgeNumber found. we will use Playername instead
Framework.GetPlayerBadgeNumber = function(source)
    local badgeNum
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)

        if Player.PlayerData.metadata.callsign then -- If the player had Callsign, we use it.
            badgeNum = Framework.GetPlayerName(source) .. '#' .. Player.PlayerData.metadata.callsign
        end
    else 
        -- Implement your badge number system here.
    end
    return badgeNum
end
