if not rawget(_G, "lib") then include('ox_lib', 'init') end

WEBHOOK = '' -- REPLACE WITH YOUR WEBHOOK
--- EDIT HERE FOR CHECKING IF VEHICLE IS OWNED AND HARDCORE MODE COMPLETION

local savedPlates = {}

function HardcoreChopComplete(carData, vehicleModel, vehiclePlate)
    if Config.Debug then
        print('DATABASE Plate: ',carData.plate)
        print('Chopping vehicle plate: ', vehiclePlate)
        print('DATABASE vehicle model hash: ',GetHashKey(carData.vehicle))
        print('Chopping vehicle model: ', vehicleModel)
    end
    if not carData then
        return
    end
    if GetHashKey(carData.vehicle) ~= vehicleModel then
        print('envi-chopshop: Possible exploit attempt. - Vehicle model being chopped does not match the database. Player: '..GetPlayerName(source).. ' - Model: '..vehicleModel.. ' - Database Model: '..GetHashKey(carData.vehicle))
        return
    end
    if carData.plate ~= vehiclePlate then
        print('envi-chopshop: Possible exploit attempt. - Vehicle plate being chopped does not match the database. Player: '..GetPlayerName(source)..' - Plate: '..vehiclePlate.. ' - Database Plate: '..carData.plate)
        return
    end
    if Bridge.Framework == 'qbox' or Bridge.Framework == 'qb' then
        MySQL.Async.execute('DELETE FROM player_vehicles WHERE plate = @plate', {
            ['@plate'] = carData.plate
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print('envi-chopshop: '..carData.plate..' has been removed from the database.')
            else
                print('envi-chopshop: '..carData.plate..' was not found in the database.')
            end
        end)

    elseif Bridge.Framework == 'esx' then
        MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = carData.plate
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print('envi-chopshop: '..carData.plate..' has been removed from the database.')
            else
                print('envi-chopshop: '..carData.plate..' was not found in the database.')
            end
        end)
    else
        print('No compatible framework found - please edit server_edit.lua to use this feature!')
        return
    end
    local player = Framework.GetPlayer(source)
    if not player then return end
    local identifier = player.Identifier
    local name = player.Firstname..' '..player.Lastname
    local message = ":fire: Hardcore Chop Completed: "..name.." has chopped an OWNED "..vehicleModel.." with the plate "..vehiclePlate.." - Identifier: "..identifier
    SendDiscordLog(WEBHOOK, message, 15158332)
end

Framework.CreateCallback('envi-chopshop:isVehOwned', function(source, cb, vehiclePlate)
    savedPlates[source] = vehiclePlate
    if Bridge.Framework == 'qbox' or Bridge.Framework == 'qb' then
        MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = @plate', {        
            ['@plate'] = vehiclePlate
        }, function(result)
            if result[1] then
                -- GET ALL VEHICLE DATA
                local vehicleData = result[1]
                -- GET VEHICLE OWNER
                local owner = vehicleData.citizenid
                cb(vehicleData, owner)
            else
                cb(false)
            end
        end)
    elseif Bridge.Framework == 'esx' then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = vehiclePlate
        }, function(result)
            if result[1] then
                -- GET ALL VEHICLE DATA
                local vehicleData = result[1]
                -- GET VEHICLE OWNER
                local owner = vehicleData.owner
                cb(vehicleData, owner)
            else
                cb(false)
            end
        end)
    else
        print('No compatible framework found for isVehOwned - please edit server_edit.lua to use this feature!')
        cb(false)
    end
end)

------------------------------------------------------------------------------------------------------
local paidNetIDs = {}
RegisterNetEvent('envi-chopshop:payOut', function(reward, stage, shopName, netID)
    if not stage then return end
    if not Config.ChopShops[shopName] then return end
    if paidNetIDs[netID] then return end
    paidNetIDs[netID] = true
    local vehicle = NetworkGetEntityFromNetworkId(netID)
    if not DoesEntityExist(vehicle) then return end
    if Config.RewardsAccount then
        if Config.RewardsAccount == 'money' then Config.RewardsAccount = 'cash' end
        local src = source
        local player = Framework.GetPlayer(src)
        if not player then return end
        player.AddMoney(Config.RewardsAccount, reward)
        TriggerClientEvent('envi-chopshop:notify', src, Config.Lang['reward_message'] .. reward, 'success', 3500)
        local identifier = player.Identifier
        local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
        if shop then
            local shopInfo = shop[1]
            if shopInfo then
                if shopInfo.owner ~= identifier then
                    local amount = reward / Config.ChopShops[shopName].Percentage
                    if Config.Debug then
                        print('envi-chopshop: '..shopName..' has been paid '..amount..' by '..identifier)
                    end
                    Database.query('UPDATE `envi-chopshop` SET `funds` = `funds` + ? WHERE `shop` = ?', {amount, shopName})
                end
            end
        end

        if Config.AdditionalRewardsItem then
            Framework.AddItem(src, Config.AdditionalRewardsItem, Config.AdditionalRewardsAmount)
        end
        SetTimeout(Config.DeleteVehicleTime * 1000, function()
            if DoesEntityExist(vehicle) then
                print('envi-chopshop: Deleting vehicle from server: '..netID)
                DeleteEntity(vehicle)
            end
            paidNetIDs[netID] = nil
            print('envi-chopshop: Paid NetID: '..netID..' has been deleted.')
            print(json.encode(paidNetIDs))
        end)
    end
end)

RegisterNetEvent('envi-chopshop:giveItem', function(itemFind, netID)
    if not itemFind then return end
    if not netID then return end
    if not DoesEntityExist(NetworkGetEntityFromNetworkId(netID)) then return end
    local randomItem = Config.LootItems[math.random(#Config.LootItems)]
    local player = Framework.GetPlayer(source)
    if player then
        Framework.AddItem(source, randomItem, math.random(Config.LootMin, Config.LootMax))
    end
end)

RegisterNetEvent('envi-chopshop:salvageParts', function(part, netID)
    if not part then return end
    if not netID then return end
    if not DoesEntityExist(NetworkGetEntityFromNetworkId(netID)) then return end
    local itemFound = false
    for k, v in pairs(Config.CarPartsItems) do
        if v == part then
            itemFound = true
        end
    end
    if itemFound then
        local player = Framework.GetPlayer(source)
        if player then
            Framework.AddItem(source, part, 1)
        end
    else
        print('envi-chopshop: Possible exploit attempt.')
    end
end)


Framework.CreateCallback('envi-chopshop:checkPolice', function(source, cb)
    local job = Config.JobToCheck
    local jobAmount = Config.AmountOnline
    local jobOnline = 0
    if Config.CheckPoliceOnline then
        local players = GetPlayers()
        for k, v in pairs(players) do
            local player = Framework.GetPlayer(tonumber(v))
            if player then
                if player.Job.Name == job then
                    jobOnline = jobOnline + 1
                end
            end
        end
        if jobOnline < jobAmount then
            cb(false)
        else
            cb(true)
        end
    else
        cb(true)
    end
end)

Framework.CreateCallback('envi-chopshop:checkShopOwner', function(source, cb, shopName)
    local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
    if not shop then
        cb(nil)
    end
    local shopInfo = shop[1]
    if shopInfo then
        cb(shopInfo)
    else
        cb(nil)
    end
end)

Framework.CreateCallback('envi-chopshop:buyChopShop', function(source, cb, shopName, price)
    local player = Framework.GetPlayer(source)
    if not player then
        cb(false)
    end
    local identifier = player.Identifier
    local bankBalance = player.GetMoney('bank')
    local ownerName = player.Firstname..' '..player.Lastname
    local existingShop = Database.query('SELECT * FROM `envi-chopshop` WHERE `owner` = ?', {identifier})
    if existingShop and #existingShop > 0 then
        cb(false)
        return
    end
    if bankBalance >= price then
        player.RemoveMoney('bank', price)
        Database.query('INSERT INTO `envi-chopshop` (`shop`, `owner`, `ownerName`) VALUES (?, ?, ?)', {shopName, identifier, ownerName})
        cb(true)
    else
        cb(false)
    end
end)


-- Moved to Server_Edit
Framework.CreateCallback('envi-chopshop:sellChopShop', function(source, cb, shopName, price)
    local player = Framework.GetPlayer(source)
    if not player then
        cb(false)
    end
    local identifier = player.Identifier
    local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
    if not shop then
        cb(false)
    end
    local shopInfo = shop[1]
    if shopInfo then
        if shopInfo.owner == identifier then
            Database.query('DELETE FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
            player.AddMoney('bank', price)
            if shopInfo.funds > 0 then
                player.AddMoney('bank', shopInfo.funds)
                Framework.Notify(source, Config.Lang['recieved']..shopInfo.funds..Config.Lang['from_fund'], 'success', 3500)
            end
            Wait(1000)
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

Framework.CreateCallback('envi-chopshop:transferChopShop', function(source, cb, shopName, ID)
    local player = Framework.GetPlayer(source)
    local buyerPlayer = Framework.GetPlayer(ID)
    if not player then
        cb(false)
    end
    if not buyerPlayer then
        cb(false)
    end
    local identifier = player.Identifier
    local buyerID = buyerPlayer.Identifier
    local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
    if not shop then
        cb(false)
    end
    local shopInfo = shop[1]
    if shopInfo then
        if shopInfo.owner == identifier then
            Database.query('UPDATE `envi-chopshop` SET `owner` = ? WHERE `shop` = ?', {buyerID, shopName})
            print('envi-chopshop: '..identifier..' has transferred '..shopName..' to '..buyerID)
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

Framework.CreateCallback('envi-chopshop:withdrawFunds', function(source, cb, shopName, amount)
    local player = Framework.GetPlayer(source)
    if not player then
        cb(false)
    end
    local identifier = player.Identifier
    local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
    if not shop then
        cb(false)
    end
    local shopInfo = shop[1]
    if shopInfo then
        if shopInfo.owner == identifier then
            local fundsBalance = shopInfo.funds
            if fundsBalance >= amount then
                player.AddMoney('cash', amount)
                Database.query('UPDATE `envi-chopshop` SET `funds` = `funds` - ? WHERE `shop` = ?', {amount, shopName})
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

---

local contractCooldown = {}
RegisterNetEvent('envi-chopshop:generateSpecialContract', function(shopName)
    local src = source
    if not shopName then return end
    local ownerPlayer = Framework.GetPlayer(src)
    if not ownerPlayer then return end
    local ownerName = ownerPlayer.Firstname..' '..ownerPlayer.Lastname
    local currentTime = os.time()
    if not contractCooldown[shopName] or currentTime > contractCooldown[shopName] then
        contractCooldown[shopName] = currentTime + Config.SpecialContractCooldown * 60
        local vehicle, vehicleName
        local attempts, maxAttempts = 0, 25

        repeat
            local contract = math.random(1, #Config.SpecialContractVehicles)
            vehicle = Config.SpecialContractVehicles[contract].model
            vehicleName = lib.callback.await('envi-chopshop:getVehicleInfo', src, vehicle)
            attempts = attempts + 1
            Wait(1000)
        until (vehicle and vehicleName) or attempts >= maxAttempts

        if vehicle and vehicleName then
            Framework.AddItem(src, Config.ContractItem, 1, {vehicle = vehicleName, shop = shopName, shopOwner = ownerName})
        else
            TriggerClientEvent('envi-chopshop:notify', src, 'Failed to generate special contract after several attempts.', 'error', 3500)
        end
    else
        local timeInMins = math.floor((contractCooldown[shopName] - currentTime) / 60)
        TriggerClientEvent('envi-chopshop:notify', src, Config.Lang['cannot_generate']..timeInMins..Config.Lang['min_cooldown'], 'error', 3500)
    end
end)


RegisterNetEvent('envi-chopshop:checkForContracts', function(vehicleName, shopName, reward)
    if not shopName or not vehicleName then return end
    local src = source
    local item = Framework.HasItem(src, Config.ContractItem, 1)
    if item then
        local player = Framework.GetPlayer(src)
        if not player then return end
        local identifier = player.Identifier
        local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
        if not shop then return end
        local shopInfo = shop[1]
        if not shopInfo then return end
        local ownerName = shopInfo.ownerName
        local itemWithData = Framework.HasItem(src, Config.ContractItem, 1, { vehicle = vehicleName, shop = shopName, shopOwner = ownerName})
        if itemWithData then
            if shopInfo then
                if shopInfo.owner == identifier then
                    TriggerClientEvent('envi-chopshop:notify', src, Config.Lang['cannot_claim_own'], 'error', 3500)
                    return
                end
            end
            local removed = Framework.RemoveItem(src, Config.ContractItem, 1, { vehicle = vehicleName, shop = shopName, shopOwner = ownerName})
            print('Contract Removed: ', removed)
            local ownerBonus = Config.ContractCompleteBonus * Config.ChopShops[shopName].Percentage / 100  -- if the reward is 1000 and the percentage is 10, then the owner bonus is 100
            local playerReward = Config.ContractCompleteBonus - ownerBonus
            if removed then
                player.AddMoney(Config.RewardsAccount, playerReward)
                TriggerClientEvent('envi-chopshop:notify', src, Config.Lang['completed_contract']..shopInfo.ownerName..Config.Lang['recieved_extra']..playerReward, 'success', 3500)
                Database.query('UPDATE `envi-chopshop` SET `funds` = `funds` + ? WHERE `shop` = ?', {ownerBonus, shopName})
            end
            -- ADD WEBHOOK FOR CONTRACT 
            local message = ':moneybag: '..player.Firstname..' '..player.Lastname..' has completed a contract for '..shopInfo.ownerName..' and recieved an extra $'..playerReward..' - Vehicle: '..vehicleName..'- Identifier: '..identifier
            SendDiscordLog(WEBHOOK, message, 3066993)
        end
    end
end)

RegisterNetEvent('envi-chopshop:log', function(vehDisplayName, reward, shop, netID)
    if not WEBHOOK or WEBHOOK == '' then
        return
    end
    if not vehDisplayName or not reward or not shop or not netID then return end
    if not Config.ChopShops[shop] then return end
    if not DoesEntityExist(NetworkGetEntityFromNetworkId(netID)) then return end
    local src = source
    local player = Framework.GetPlayer(src)
    if not player then return end
    local identifier = player.Identifier
    local name = player.Firstname..' '..player.Lastname
    local message = ':car: '..name..' has chopped a '..vehDisplayName..' at '..shop..' and recieved '..reward..' - Identifier: '..identifier
    SendDiscordLog(WEBHOOK, message, 3447003)
end)

Framework.CreateUseableItem(Config.ContractItem, function(source, item, data)
    local metadata = data.metadata
    local src = source
    TriggerClientEvent('envi-chopshop:viewContract', src, metadata)
end)

function SendDiscordLog(webhookUrl, message, color)
    local embed = {
        {
            ["color"] = color, -- You can set color based on log type
            ["title"] = "**Chop Shop Log**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Chop Shop Logs",
            },
        }
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function CanStartChop(cb, source)
   -- ADD ADDITIONAL CHECKS HERE
   -- DONT TOUCH IF YOURE UNSURE
   if source then
    if Config.Debug then
        print('CanStartChopServer: '..source)
    end
    cb(true)
   else
    if Config.Debug then
        print('CanStartChopServer: false')
    end
    cb(false)
   end
end