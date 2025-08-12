AwaitLoader()

while (not Translations) do Wait(10) end

local useFluid = Config.Settings.lighter.enableFluidUse == true

---@param plyId integer
---@return integer | boolean, string | nil @Slot / boolean having lighter, Lighter name
function HasLighter(plyId)
    if (useFluid) then
        local slot, itemName = GetAvailableLighterSlot(plyId)

        return slot or false, itemName
    else
        for i = 1, #Config.Settings.lighter.item do
            local hasItem = Z.hasItem(plyId, Config.Settings.lighter.item[i])

            if (hasItem) then
                return true, Config.Settings.lighter.item[i]
            end
        end

        return false
    end
end

local function initMetadata(plyId, slot, metadata)
    local newMetadata = metadata
    newMetadata.fluid = 100

    Z.setItemMetadata(plyId, slot, newMetadata)
end

-- Check your items and fluid level, if there is enough fluid or no metadata, return as valid
-- If there is no metadata, init it
---@param plyId integer
---@return integer | nil, string | nil
function GetAvailableLighterSlot(plyId)
    for i = 1, #Config.Settings.lighter.item do
        local items = Z.getPlayerItem(plyId, Config.Settings.lighter.item[i], false, true)

        if (items) then
            for j = 1, #items do
                local item = items[j]
                local amount = item.metadata.fluid

                if (amount == nil) then
                    initMetadata(plyId, item.slot, item.metadata)

                    return item.slot, item.name
                end

                if (amount >= Config.Settings.lighter.fluidPerUse) then
                    return item.slot, item.name
                end
            end
        end
    end

    return nil, nil
end

for i = 1, #Config.Settings.lighter.item do
    Z.ensureMetadata(Config.Settings.lighter.item[i], {
        fluid = 100,
        description = T("lighter:description", {100})
    })
end

---@param plyId integer
---@param slot integer
function SetNewLighterFluid(plyId, slot)
    local item = Z.getInventorySlot(plyId, slot)
    local metadata = item.metadata
    local newFluid = metadata.fluid - Config.Settings.lighter.fluidPerUse

    newFluid = math.floor(newFluid * 10) / 10

    metadata.fluid = newFluid
    metadata.description = T("lighter:description", {newFluid})

    Z.setItemMetadata(plyId, slot, metadata)
end