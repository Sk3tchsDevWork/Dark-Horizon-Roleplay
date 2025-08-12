-- Initialize variable to store housing system
Housing = nil

-- Get housing system
local function InitHousing()
    if GetResourceState('qs-housing') == 'started' then
        Housing = 'qs-housing'
    end
end

-- Update house
--- @param houseId number
local function updateHouse(houseId)
    if not houseId or not Housing then return end

    if Housing == 'qs-housing' then
        local bucket = exports[Housing]:getHouseRoutingId(houseId)
        if not bucket then return end

        local updated = MySQL.update.await('UPDATE lation_weed SET bucket = ? WHERE house = ?', {bucket, houseId})
        if updated == 0 then return end

        local query = MySQL.query.await('SELECT * FROM lation_weed WHERE house = ?', {houseId})

        for _, data in pairs(query) do
            if WeedPlants[data.plant_id] then
                WeedPlants[data.plant_id].bucket = data.bucket
            end
            TriggerClientEvent('lation_weed:updateBucket', -1, data.plant_id, data.bucket)
        end
    end
end

-- Set houseId
--- @param plantId number
function SetHouse(source, plantId)
    if not source or not plantId or not Housing then return end

    local house = lib.callback.await('lation_weed:getHouse', source)
    if not house then return end

    local plant = WeedPlants[plantId]
    if not plant then return end

    plant.house = house
    MySQL.update('UPDATE lation_weed SET house = ? WHERE plant_id = ?', {house, plantId})
end

-- Initialize default(s)
InitHousing()

-- Register event(s) when applicable
if Housing == 'qs-housing' then
    RegisterNetEvent('housing:setInside', function(insideId, bool)
        if not bool then return end
        updateHouse(insideId)
    end)
end

-- Alter lation_weed table if applicable
if Housing then
    MySQL.query([[ALTER TABLE `lation_weed` ADD IF NOT EXISTS `house` VARCHAR(255) NULL DEFAULT NULL]])
end