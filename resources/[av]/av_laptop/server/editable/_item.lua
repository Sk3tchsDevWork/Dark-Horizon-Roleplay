AddEventHandler('ox_inventory:usedItem', function(playerId, name, slotId, metadata)
    dbug("ox_inventory:usedItem", name)
    if not name or not playerId then return end
    metadata = metadata or {}
    if Config.LaptopItem and name == Config.LaptopItem then
        dbug("item name matches")
        local identifier = getIdentifier(playerId)
        local slot = slotId
        metadata = metadata or {}
        if metadata and not metadata['serial'] then
            local info = {}
            local serial = lib.string.random('..............')
            info['serial'] = serial
            dbug("^3[DEBUG]:^7 ".."durability: ", metadata['durability'])
            info['durability'] = metadata['durability'] or 100
            info['password'] = false
            if info['durability'] > 100 then
                dbug("^3[DEBUG]:^7 ".."more than 100")
                info['durability'] = 100
            end
            allDevices[serial] = os.time()
            setItemMetadata(playerId, Config.LaptopItem, slot, info)
            TriggerClientEvent("av_laptop:openUI", playerId, info, slot, true)
        else
            if metadata['serial'] == identifier then
                metadata['serial'] = lib.string.random('..............')
                setItemMetadata(playerId, Config.LaptopItem, slot, metadata)
            end
            allDevices[metadata['serial']] = os.time()
            TriggerClientEvent("av_laptop:openUI", playerId, metadata, slot, true)
        end
    end
end)