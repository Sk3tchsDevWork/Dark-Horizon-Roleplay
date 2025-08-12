local QBCore = exports['qb-core']:GetCoreObject()

for plateType, config in pairs(Config.ArmorPlates) do
    QBCore.Functions.CreateUseableItem(config.item, function(source)
        TriggerClientEvent('paradise_armorplate:client:useArmor', source, plateType)
    end)
end

RegisterNetEvent('paradise_armorplate:server:removePlate', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    Player.Functions.RemoveItem(itemName, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "remove")
end)