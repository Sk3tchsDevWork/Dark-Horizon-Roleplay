local QBCore = exports['qb-core']:GetCoreObject()

-- This handles the addition of items to the players inventory.
local function AddItem(source, item, amount, info)
	local src = source
	if Config.Inventory == 'ox' then
		if exports.ox_inventory:CanCarryItem(src, item, amount) then
			exports.ox_inventory:AddItem(src, item, amount, info)
		end
	else
		local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.AddItem(item, amount, nil, info)
		TriggerClientEvent('sw_lib:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
	end
end
exports('AddItem', AddItem)

-- This handles the removal of items from the players inventory.
local function RemoveItem(source, item, amount)
	local src = source
	if Config.Inventory == 'ox' then
		exports.ox_inventory:RemoveItem(src, item, amount)
	else
		local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.RemoveItem(item, amount)
		TriggerClientEvent('sw_lib:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
	end
end
exports('RemoveItem', RemoveItem)

-- This handles the addition of player money in a designated type.
local function AddMoney(source, type, amount)
	local src = source
	if Config.Core == 'qb' then
		local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.AddMoney(type, amount)
	end
end
exports('AddMoney', AddMoney)

-- This handles the removal of player money from a designated type.
local function RemoveMoney(source, type, amount)
	local src = source
	if Config.Core == 'qb' then
		local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.RemoveMoney(type, amount)
	end
end
exports('RemoveMoney', RemoveMoney)

-- This handles the adding of money to the management/boss account. This is triggered when money is transferred from player directly to the business funds, such as paying nightclub entry fees.
RegisterNetEvent('sw_lib:server:addManagementMoney', function(job, amount)
    if Config.Management == 'qb' then
        exports['qb-management']:GetAccount(job, amount)
    end
end)

-- This handles the opening of a stash inventory.
RegisterNetEvent('sw_lib:server:openInventory', function(stashName, maxweight, slots)
	if Config.Inventory == 'qb' then
		local data = { label = stashName, maxweight = maxweight, slots = slots }
		exports['ps-inventory']:OpenInventory(source, stashName, data)
	elseif Config.Inventory == 'ox' then
		exports.ox_inventory:RegisterStash(stashName, stashName, slots, maxweight)
	end
end)