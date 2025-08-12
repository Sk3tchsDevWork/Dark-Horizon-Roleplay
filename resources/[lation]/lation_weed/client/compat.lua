-- Initialize variable to store housing system
Housing = nil

-- Get housing system
local function InitHousing()
    if GetResourceState('qs-housing') == 'started' then
        Housing = 'qs-housing'
    end
end

-- Return houseId
local function getHouse()
    if Housing == 'qs-housing' then
        return exports[Housing]:getCurrentHouse()
    end
end

-- Update plant bucket
--- @param plantId number
--- @param bucket number
local function updateBucket(plantId, bucket)
    if not plantId or not bucket or not Housing then return end

    local plant = WeedPlants[plantId]
    if not plant then return end

    plant.bucket = bucket
end

-- Register event(s)
RegisterNetEvent('lation_weed:updateBucket', updateBucket)

-- Register callback(s)
lib.callback.register('lation_weed:getHouse', getHouse)

-- Initialize default(s)
InitHousing()