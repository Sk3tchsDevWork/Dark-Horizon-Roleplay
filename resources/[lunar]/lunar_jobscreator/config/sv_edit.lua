Editable = {}

local tables = {
    [[
        CREATE TABLE IF NOT EXISTS `lunar_jobscreator` (
            `name` varchar(30) NOT NULL,
            `data` longtext NOT NULL,
            PRIMARY KEY (`name`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]],
    [[
       CREATE TABLE IF NOT EXISTS `lunar_jobscreator_history` (
            `username` varchar(50) DEFAULT NULL,
            `action` varchar(150) DEFAULT NULL,
            `timestamp` int(11) DEFAULT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; 
    ]],
    [[
        CREATE TABLE IF NOT EXISTS `lunar_jobscreator_settings` (
            `key` varchar(30) NOT NULL,
            `value` text NOT NULL,
            PRIMARY KEY (`key`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]],
    [[
        CREATE TABLE IF NOT EXISTS `lunar_jobscreator_webhooks` (
            `name` varchar(50) NOT NULL,
            `url` varchar(100) NOT NULL,
            PRIMARY KEY (`name`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]]
}

MySQL.ready(function()
    for i = 1, #tables do
        MySQL.query.await(tables[i])
    end
end)

---@type table<string, number>
local activeVehicles = {}

---@param source integer
---@param vehicleType string
---@param shared boolean
---@return table?
function Editable.getVehicles(source, vehicleType, shared)
    local player = Framework.getPlayerFromId(source)

    if not player then return end

    local query = shared and
        'SELECT * FROM lunar_jobscreator_vehicles WHERE job = ? and type = ?'
        or
        'SELECT * FROM lunar_jobscreator_vehicles WHERE job = ? and type = ? and owner = ?'
        
    local vehicles = MySQL.query.await(query, {
        player:getJob(), vehicleType, not shared and player:getIdentifier() or nil
    })

    for _, vehicle in ipairs(vehicles) do
        local entity = activeVehicles[vehicle.plate]

        if vehicle.stored == true or vehicle.stored == 1 then
            vehicle.state = 'in_garage'
        elseif entity then
            if DoesEntityExist(entity) then
                if GetVehiclePetrolTankHealth(entity) <= 0 or GetVehicleBodyHealth(entity) <= 0 then
                    DeleteEntity(entity)
                    activeVehicles[vehicle.plate] = nil
                    vehicle.state = 'in_impound'
                else
                    vehicle.state = 'outside'
                end
            else
                activeVehicles[vehicle.plate] = nil
                vehicle.state = 'in_impound'
            end
        else
            vehicle.state = 'in_impound'
        end
    end

    return vehicles
end

---@param source integer
---@param netId integer
---@param props VehicleProperties
---@param type string
---@return boolean
function Editable.saveVehicle(source, netId, props, type)
    local player = Framework.getPlayerFromId(source)

    if not player then return false end

    local entity = NetworkGetEntityFromNetworkId(netId)

    if not DoesEntityExist(entity) then return false end

    local query = 'SELECT * FROM lunar_jobscreator_vehicles WHERE plate = ?'
    local query2 = 'UPDATE lunar_jobscreator_vehicles SET stored = ?, props = ? WHERE plate = ?'

    local vehicle = MySQL.single.await(query, { props.plate })
    
    if vehicle and vehicle.type == type and (vehicle.owner == player:getIdentifier() or vehicle.job == player:getJob()) then
        local oldProps = json.decode(vehicle.props)

        if props.model ~= oldProps.model then
            return false
        end

        MySQL.update.await(query2, { true, json.encode(props), props.plate })

        SetTimeout(300, function()
            if DoesEntityExist(entity) then
                DeleteEntity(entity)
            end
        end)

        return true
    end

    return false
end

---@type string[], string[]
local numbers, chars = {}, {}

for i = 48, 57 do table.insert(numbers, string.char(i)) end
for i = 65, 90 do table.insert(chars, string.char(i)) end

local function generatePlate(length)
    while true do
        local plate = ''

        for _ = 1, length do
            plate = plate .. (math.random(2) == 1 and Utils.randomFromTable(chars) or Utils.randomFromTable(numbers))
        end

        if not MySQL.single.await('SELECT * FROM lunar_jobscreator_vehicles WHERE plate = ?') then
            return plate
        end

        Wait(0)
    end
end

---@param source integer
---@param index integer
---@param vehicleIndex integer
---@return boolean
function Editable.buyVehicle(source, index, vehicleIndex, props, account)
    local player = Framework.getPlayerFromId(source)

    if not player
    or not Config.accountsByKey[account] then
        return false
    end

    local job = GetJobs()[player:getJob()]

    if not job then return false end

    local garage = job.garages[index]
    local vehicle = garage?.vehicles[vehicleIndex]

    if not vehicle
    or not vehicle.price then
        return false
    end

    local query = 'INSERT INTO lunar_jobscreator_vehicles (owner, plate, props, type, job, stored) VALUES(?, ?, ?, ?, ?, ?)'

    if player:getAccountMoney(account) >= vehicle.price then
        player:removeAccountMoney(account, vehicle.price)

        props.plate = generatePlate(6) -- 6 to prevent collisions with esx_vehicleshop and qb-vehicleshop
        props.model = joaat(vehicle.model)

        MySQL.insert.await(query, {
            player:getIdentifier(), props.plate, json.encode(props), garage.vehicleType, player:getJob(), true
        })
        
        if Webhooks.settings.vehicleBought then
            Logs.send(source, job.name, ('Bought work vehicle.\nModel/label: %s\nPrice: %s$'):format(vehicle.label or vehicle.model, vehicle.price))
        end

        return true
    end

    return false
end

lib.callback.register('lunar_unijob:canSpawnVehicle', function(source, plate)
    local player = Framework.getPlayerFromId(source)

    if not player then return end
    
    local query = 'SELECT * FROM lunar_jobscreator_vehicles WHERE plate = ? and (owner = ? or job = ?)'

    return MySQL.single.await(query, { plate, player:getIdentifier(), player:getJob() })?.stored
end)

RegisterNetEvent('lunar_unijob:vehicleSpawned', function(plate, netId)
    local source = source
    local player = Framework.getPlayerFromId(source)
    local vehicle = NetworkGetEntityFromNetworkId(netId)

    if not player
    or not DoesEntityExist(vehicle) then return end

    local query = 'SELECT * FROM lunar_jobscreator_vehicles WHERE plate = ? and (owner = ? or job = ?)'
    local query2 = 'UPDATE lunar_jobscreator_vehicles SET stored = ? WHERE plate = ?'

    if MySQL.single.await(query, { plate, player:getIdentifier(), player:getJob() })?.stored then
        MySQL.update.await(query2, { false, plate })
        activeVehicles[plate] = vehicle
    end
end)

lib.callback.register('lunar_unijob:canRetrieveVehicle', function(source, plate)
    local player = Framework.getPlayerFromId(source)

    if not player 
    or player:getAccountMoney('money') < Settings.impoundPrice then
        return false, locale('not_enough_money')
    end

    local query = 'SELECT * FROM lunar_jobscreator_vehicles WHERE plate = ? and (owner = ? or job = ?)'
    local vehicle = MySQL.single.await(query, { plate, player:getIdentifier(), player:getJob() })

    return not activeVehicles[plate] and (vehicle?.stored == false or vehicle?.stored == 0)
end)

RegisterNetEvent('lunar_unijob:vehicleRetrieved', function(plate, netId)
    local source = source
    local player = Framework.getPlayerFromId(source)
    local vehicle = NetworkGetEntityFromNetworkId(netId)

    if not player
    or not DoesEntityExist(vehicle)
    or activeVehicles[plate] then return end

    local query = 'SELECT * FROM lunar_jobscreator_vehicles WHERE plate = ? and (owner = ? or job = ?)'

    if MySQL.single.await(query, { plate, player:getIdentifier(), player:getJob() }) then
        activeVehicles[plate] = vehicle
        player:removeAccountMoney('money', Settings.impoundPrice)
    end
end)

---Can be used externally to easily get job owned vehicles
---@param plate string
---@return { plate: string, owner: string, props: VehicleProperties, stored: boolean, job: string, type: string }?
exports('getVehicleFromDatabase', function(plate)
    -- Trim in case of padded plate being passed in
    plate = plate:strtrim(' ')

    local vehicle = MySQL.single.await('SELECT * FROM lunar_jobscreator_vehicles WHERE plate = ?', { plate })

    if vehicle then
        vehicle.props = json.decode(vehicle.props)
    end

    return vehicle
end)

local ox_inventory = GetResourceState('ox_inventory') == 'started'

---Should only be used for inventories that require registering stashes
---@param job Job
---@param name string
---@param data StashData
---@param coords LocationData
function Editable.registerStash(job, name, data, coords)
    if ox_inventory then
        exports.ox_inventory:RegisterStash(name, data.label, data.slots, data.maxWeight, not data.shared or false,
            not data.global and { [job.name] = data.grade or 0 } or nil)
    end
end

---@param job Job
---@param name string
---@param data ShopData
function Editable.registerShop(job, name, data)
    if ox_inventory then
        local locations = {}

        for _, coords in ipairs(data.locations) do
            table.insert(locations, coords.xyz)
        end

        exports.ox_inventory:RegisterShop(name, {
            name = data.label,
            inventory = data.items,
            locations = locations,
            groups = {
                [job.name] = data.grade or 0
            }
        })
    end
end

---@param society string
---@param amount integer
function Editable.addSocietyMoney(society, amount)
    if GetResourceState('lunar_multijob') == 'started' then
        exports['lunar_multijob']:addAccountBalance(society, amount)
        return
    end

    if Framework.name == 'es_extended' then
        local p = promise.new()

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. society, function(account)
            if not account then
                p:resolve(false)
                return
            end

            account.addMoney(amount)
            p:resolve(true)
        end)

        local success = Citizen.Await(p)

        if not success then
            error(('Unable to find society account for job: %s'):format(society))
        end
    else
        local success = pcall(function()
            exports['qb-management']:AddMoney(society, amount)
        end)
    
        if success then return end
    
        local success = pcall(function()
            exports['qb-banking']:AddMoney(society, amount)
        end)

        if success then
            return
        end

        local success = pcall(function()
            exports['Renewed-Banking']:addAccountMoney(society, amount)
        end)
    
        if not success then
            error('Unable to change account balance in qb-management/qb-banking/Renewed-Banking. Add your banking system in sv_edit.lua')
        end
    end
end

---@param society string
---@return integer
function Editable.getSocietyMoney(society)
    if GetResourceState('lunar_multijob') == 'started' then
        return exports['lunar_multijob']:getAccountBalance(society)
    end

    if Framework.name == 'es_extended' then
        local p = promise.new()

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. society, function(account)
            if not account then
                p:resolve(0)
                return
            end

            p:resolve(account?.money or 0)
        end)

        local amount = Citizen.Await(p)

        if not amount then
            error(('Unable to find society account for job: %s'):format(society))
        end

        return amount
    else
        local success, amount = pcall(function()
            return exports['qb-management']:GetAccountBalance(society)
        end)
    
        if success then 
            return amount 
        end
    
        local success, amount = pcall(function()
            return exports['qb-banking']:GetAccountBalance(society)
        end)
    
        if success then
            return amount
        end

        local _, amount  = pcall(function()
            return exports['Renewed-Banking']:getAccountMoney(society)
        end)

        if not amount then
            warn('Unable to fetch society balance, implement your banking in sv_edit.lua')
            return 0
        end

        return amount
    end
end

local function isStarted(resourceName)
    return GetResourceState(resourceName) == 'started'
end

---@type string
local path

if isStarted('ox_inventory') then
    path = 'nui://ox_inventory/web/images/%s.png'
elseif isStarted('ps-inventory') then
    path = 'nui://ps-inventory/html/images/%s.png'
elseif isStarted('ps-inventory') then
    path = 'nui://ps-inventory/html/images/%s.png'
elseif isStarted('lj-inventory') then
    path = 'nui://lj-inventory/html/images/%s.png'
elseif isStarted('qs-inventory') then
    path = 'nui://qs-inventory/html/images/%s.png' -- Not really sure
end

---Returns the NUI path of an icon.
---@param itemName string
---@return string?
---@diagnostic disable-next-line: duplicate-set-field
function Editable.getInventoryIcon(itemName)
    if not path then
        warn('Inventory images path not set in sv_edit.lua!')
        return
    end

    return path:format(itemName) .. '?height=128'
end

---@param source integer
---@param targetId integer
---@param state boolean
---@param handcuffType 'handcuffs' | 'zipties'
function Editable.onCuffStateChanged(source, targetId, state, handcuffType)
    if Settings.handcuffsSkillCheck and state then
        lib.callback('lunar_unijob:skillCheck', targetId, function(success)
            if success then
                Wait(700)
                exports['lunar_unijob']:uncuff(targetId)
                LR.notify(source, locale('player_refused'), 'error')
            end
        end)
    end

    -- Implement your own logic here
end

if Framework.name == 'qb-core' then
    local query = 'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)'

    RegisterNetEvent('lunar_unijob:giveInvoice', function(targetId, amount)
        local source = source
        local player = Framework.getPlayerFromId(source)
        local target = Framework.getPlayerFromId(source)

        if not player
        or not target then
            return
        end

        if not Utils.distanceCheck(source, targetId, 10.0) then
            LR.notify(source, locale('target_too_far'), 'error')
            return
        end

        if not Actions.hasAccess(player, 'bill') then return end

        MySQL.insert.await(query, { target:getIdentifier(), amount, player:getJob(), player:getFirstName(), player:getIdentifier() })
    end)
end

RegisterNetEvent('lunar_unijob:revivePlayer', function(targetId)
    local source = source
    local player = Framework.getPlayerFromId(source)

    if not player
    or not Actions.hasAccess(player, 'revive')
    or not Utils.distanceCheck(source, targetId, 10.0) then return end

    if Framework.name == 'es_extended' then
        TriggerClientEvent('esx_ambulancejob:revive', targetId)
    else
        TriggerClientEvent('hospital:client:Revive', targetId)
    end
end)

RegisterNetEvent('lunar_unijob:healPlayer', function(targetId)
    local source = source
    local player = Framework.getPlayerFromId(source)

    if not player
    or not Actions.hasAccess(player, 'heal')
    or not Utils.distanceCheck(source, targetId, 10.0) then return end

    TriggerClientEvent('lunar_unijob:healed', targetId)
end)

---@param source integer
---@param action string
---@return boolean
function Editable.onVehicleAction(source, action)
    local player = Framework.getPlayerFromId(source)
    
    if not player
    or not Actions.hasAccess(player, action) then
        return false
    end

    if type(action) == 'table' then
        if player:getItemCount(action.item) > 0 then
            if action.removeAfterUse then
                player:removeItem(action.item, 1)
            end
            
            PendingVehicleActions[source] = true
            return true
        end

        return false
    end

    PendingVehicleActions[source] = true
    return true
end

---@param source integer
---@param job table xPlayer or QBPlayer job data depending on your framework
function Editable.getPlayerDuty(source, job)
    if Framework.name == 'es_extended' then
        return true
    else
        return job.onduty
    end
end

MySQL.query([[
CREATE TABLE IF NOT EXISTS `lunar_jobscreator_vehicles` (
	`plate` VARCHAR(8) NOT NULL COLLATE 'utf8mb4_general_ci',
	`owner` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`props` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`stored` TINYINT(1) NOT NULL,
	`job` VARCHAR(30) NOT NULL COLLATE 'utf8mb4_general_ci',
	`type` VARCHAR(30) NOT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`plate`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;
]])