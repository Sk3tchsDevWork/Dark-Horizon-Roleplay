Editable = {}

local ox_inventory = GetResourceState('ox_inventory') ~= 'missing'

---Should only be used for inventories that require registering stashes
---@param name string
---@param coords vector3
function Editable.registerStash(coords, name)
    if ox_inventory then
        exports.ox_inventory:RegisterStash(
            name, 
            Config.stash.label,
            Config.stash.slots, 
            Config.stash.maxWeight, 
            not Config.stash.shared or false,
            nil,
            coords.xyz
        )
    end
end

---@param player Player
---@return boolean
function CanPlayerBuy(player)
    if Config.maxBusinessesPerPlayer == -1 then
        return true
    end

    local identifier = player:getIdentifier()
    local count = 0
    
    for _, business in pairs(Businesses.data()) do
        if business.identifier == identifier then
            count += 1
        end
    end

    return count < Config.maxBusinessesPerPlayer
end

MySQL.ready(function()
    MySQL.query.await([[
    CREATE TABLE IF NOT EXISTS `lunar_illegalbusiness` (
        `identifier` varchar(46) DEFAULT NULL,
        `name` varchar(20) DEFAULT NULL,
        `data` longtext DEFAULT NULL,
        UNIQUE KEY `identifier` (`identifier`,`name`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
    ]])
end)