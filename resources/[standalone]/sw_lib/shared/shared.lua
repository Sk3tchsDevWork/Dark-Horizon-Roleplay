local QBCore = exports['qb-core']:GetCoreObject()

-- This handles the retrieval of an item's proper name for menu purposes.
local function GetItemLabel(itemName)
	if Config.Inventory == 'ox' then
		return exports.ox_inventory:Items(itemName).label
	else
		return QBCore.Shared.Items[itemName].label
	end
end
exports('GetItemLabel', GetItemLabel)

-- This handles the retrieval of an item's image for menu purposes.
local function GetItemImage(itemName)
	if Config.Inventory == 'ox' then
		return 'https://cfx-nui-'..Config.Link..itemName..'.png'
	else
		return 'https://cfx-nui-'..Config.Link..QBCore.Shared.Items[itemName].image
	end
end
exports('GetItemImage', GetItemImage)