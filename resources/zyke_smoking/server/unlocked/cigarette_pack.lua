AwaitLoader()

-- Handling the metadata reduction for the packs
for packName, packData in pairs(Config.Settings.packs) do
    Z.registerUsableItem(packName, function(plyId, itemData)
        local metadata = itemData.metadata
        local slot = itemData.slot

        if (metadata.amount == nil or metadata.amount <= 0) then
            return Z.notify(plyId, "noAmountInPack")
        end

        metadata.amount -= 1
        metadata.description = T("cigarettePack:amount", {metadata.amount})

        -- If empty and configured to do so, remove the pack
        if (metadata.amount <= 0 and Config.Settings.removePackWhenEmpty) then
            Z.removeFromSlot(plyId, itemData.name, 1, slot)
        else
            Z.setItemMetadata(plyId, slot, metadata, false)
        end

        local itemSettings = Z.getItem(packData.itemToGive)
        if (not itemSettings) then error(("Attempting to unpack an invalid item: %s"):format(packData.itemToGive)) end

        if (Config.Settings.notificationOnCigaretteUnpack) then
            Z.notify(plyId, "unpackedCigarette", {itemSettings.label:lower()})
        end

        Z.addItem(plyId, packData.itemToGive, 1)
    end)
end

for name, data in pairs(Config.Settings.packs) do
    Z.ensureMetadata(name, {
        amount = data.amount,
        description = T("cigarettePack:amount", {data.amount})
    })
end