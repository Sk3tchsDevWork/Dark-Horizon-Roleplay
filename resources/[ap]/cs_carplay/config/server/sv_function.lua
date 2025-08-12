if CodeStudio.ServerType == "QB" then 
    QBCore = exports['qb-core']:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then 
    ESX = exports['es_extended']:getSharedObject()
end


if CodeStudio.Main.UseWithItem.Enable then 
    if CodeStudio.ServerType == 'ESX' then
        ESX.RegisterUsableItem(CodeStudio.Main.UseWithItem.Item, function(source)
            TriggerClientEvent('cs:carplay:openUI', source)
        end)
    elseif CodeStudio.ServerType == 'QB' then
        QBCore.Functions.CreateUseableItem(CodeStudio.Main.UseWithItem.Item, function(source)
            TriggerClientEvent('cs:carplay:openUI', source)
        end)
    end
end

if CodeStudio.Main.UseWithCommand.Enable then
    lib.addCommand(CodeStudio.Main.UseWithCommand.Command,  {
        help = 'Open Car Play',
    }, function(source, _)
        TriggerClientEvent('cs:carplay:openUI', source)
    end)
end

function GetPlayerData(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local discord = GetIdentifier(source, 'discord')
        local pData = {
            ident = Player.PlayerData.citizenid,
            name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
            discord = discord
        }
        return pData
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local discord = GetIdentifier(source, 'discord')
        local pData = {
            ident = Player.identifier,
            name = Player.getName(),
            discord = discord
        }
        return pData
    else
        --Standlone [You can Edit this accoirdingly] --

        local identifier = GetIdentifier(source, 'license')
        local discord = GetIdentifier(source, 'discord')
        local pData = {
            ident = identifier,
            name = GetPlayerName(source),
            discord = discord
        }
        return pData
    end
end

function GetPlayer_Job(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local job = Player.PlayerData.job.name
        return job
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local job = Player.job.name
        return job
    else
        --Standlone [You can Edit this accoirdingly] --
        return false
    end
end


-- Radio Installer --

if CodeStudio.Main.RadioInstall.Enable and CodeStudio.Main.RadioInstall.Options.RadioItem then
    local installerItem = CodeStudio.Main.RadioInstall.Options.RadioInstallerItem
    if CodeStudio.ServerType == 'ESX' then
        ESX.RegisterUsableItem(installerItem, function(source)
            TriggerClientEvent('cs:carplay:installRadio', source)
        end)
    elseif CodeStudio.ServerType == 'QB' then
        QBCore.Functions.CreateUseableItem(installerItem, function(source)
            TriggerClientEvent('cs:carplay:installRadio', source)
        end)
    end
end

function checkOwnedVehicle(plate)
    local vehicleTable = CodeStudio.ServerType == "QB" and "player_vehicles" or "owned_vehicles"
    local query = ('SELECT * FROM %s WHERE plate = ? LIMIT 1'):format(vehicleTable)
    local result = MySQL.query.await(query, {plate})
    return result and #result > 0
end

function checkRadioItem(source)
    local itemName = CodeStudio.Main.RadioInstall.Options.RadioItem
    local requiredAmount = 1

    if GetResourceState('ox_inventory') == 'started' then
        local oxAmount = exports.ox_inventory:Search(source, 'count', itemName)
        return oxAmount and tonumber(oxAmount) >= requiredAmount
    elseif GetResourceState('qs-inventory') == 'started' then
        local qsAmount = exports['qs-inventory']:GetItemTotalAmount(source, itemName)
        return qsAmount and tonumber(qsAmount) >= requiredAmount
    elseif CodeStudio.ServerType == "QB" then
        return exports['ps-inventory']:HasItem(source, itemName, requiredAmount)
    elseif CodeStudio.ServerType == "ESX" then
        local Player = ESX.GetPlayerFromId(source)
        return Player and Player.getInventoryItem(itemName).count >= requiredAmount
    end
    
    return false
end

function addItem(source)
    local itemName = CodeStudio.Main.RadioInstall.Options.RadioItem
    local amount = 1

    if GetResourceState('ox_inventory') == 'started' then
        if exports.ox_inventory:CanCarryItem(source, itemName, amount) then
            exports.ox_inventory:AddItem(source, itemName, amount)
        end
    elseif GetResourceState('qs-inventory') == 'started' then
        exports['qs-inventory']:AddItem(source, itemName, amount)
    elseif CodeStudio.ServerType == "QB" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then Player.Functions.AddItem(itemName, amount) end
    elseif CodeStudio.ServerType == "ESX" then
        local Player = ESX.GetPlayerFromId(source)
        if Player then Player.addInventoryItem(itemName, amount) end
    end
end

function removeItem(source)
    local itemName = CodeStudio.Main.RadioInstall.Options.RadioItem
    local amount = 1

    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:RemoveItem(source, itemName, amount)
    elseif GetResourceState('qs-inventory') == 'started' then
        exports['qs-inventory']:RemoveItem(source, itemName, amount)
    elseif CodeStudio.ServerType == "QB" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then Player.Functions.RemoveItem(itemName, amount) end
    elseif CodeStudio.ServerType == "ESX" then
        local Player = ESX.GetPlayerFromId(source)
        if Player then Player.removeInventoryItem(itemName, amount) end
    end
end

function RadioInstallRemove(playerID, remove)
    if remove then
        removeItem(playerID)
    else
        addItem(playerID)
    end
end


-- Discord Log --

function SendDiscordLog(source, musicURL)
    local webHook = CodeStudio.DiscordLog.Play_Webhook
    local Player = GetPlayerData(source)
    local embedData = {
        {
            ['title'] = 'Started Playing',
            ['color'] = 16776960,
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = 'Player: '..Player.name..
            '\nPlayer ID: '..source..
            '\nPlayer Identifier: '..Player.ident..
            '\nPlayer Discord: '..replaceDiscordID(Player.discord)..
            '\nMusic Played: '..musicURL,
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Music Player', embeds = embedData}), { ['Content-Type'] = 'application/json' })
end