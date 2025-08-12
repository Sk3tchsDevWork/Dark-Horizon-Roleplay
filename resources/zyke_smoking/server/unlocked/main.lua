AwaitLoader()

-- Joints
for item, _ in pairs(Config.Cigarettes) do
    Z.registerUsableItem(item, function(source, itemData)
        TriggerClientEvent("zyke_smoking:UseItem", source, item, itemData)
    end)
end

-- Refillables
for item, _ in pairs(Config.Refillables) do
    Z.registerUsableItem(item, function(source, itemData)
        TriggerClientEvent("zyke_smoking:UseItem", source, item, itemData)
    end)
end

Z.registerUsableItem(Config.Settings.vapeExtras.batteryItem, function(source)
    if (not Cache.active[source]) then return end
    if (Cache.active[source].type ~= "vape") then return end

    TriggerClientEvent("zyke_smoking:UseVapeBattery", source)
end)

for capsule in pairs(Config.Settings.vapeExtras.items) do
    Z.registerUsableItem(capsule, function(source, itemData)
        if (not Cache.active[source]) then return end
        if (Cache.active[source].type ~= "vape") then return end

        TriggerClientEvent("zyke_smoking:UseVapeCapsule", source, itemData)
    end)
end

Z.registerUsableItem(Config.Settings.bongExtras.waterItem, function(source)
    if (not Cache.active[source]) then return end
    if (Cache.active[source].type ~= "bong") then return end

    TriggerClientEvent("zyke_smoking:UseBongWater", source)
end)

for item in pairs(Config.Settings.bongExtras.items) do
    Z.registerUsableItem(item, function(source, itemData)
        if (not Cache.active[source]) then return end
        if (Cache.active[source].type ~= "bong") then return end

        TriggerClientEvent("zyke_smoking:UseBongItem", source, itemData)
    end)
end

while (not HasInitializedDatabase) do Wait(100) end

-- Handles giving back items that were active before restart
CreateThread(function()
    Wait(100)

    local savedData = MySQL.query.await("SELECT * FROM zyke_smoking")
    for i = 1, #savedData do
        local plyId = Z.getPlayerId(savedData[i].identifier)

        if (plyId) then
            local data = {
                fromDatabase = true,
                metadata = json.decode(savedData[i].data) or {}
            }

            TriggerClientEvent("zyke_smoking:UseItem", plyId, savedData[i].item, data)
        end
    end
end)

-- Forcefully stops using an item in case anything gets stuck
---@param plyId integer
RegisterCommand("force_stop_use", function(plyId)
    StopUsingItem(plyId)
end, false)