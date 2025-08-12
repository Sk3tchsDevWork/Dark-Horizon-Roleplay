if CodeStudio.ServerType == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end

lib.addCommand('documents', { help = 'Open Document Panel'}, function(source)
    TriggerClientEvent('cs:documents:openUI', source)
end)

function GetPlayer(source)
    if CodeStudio.ServerType == 'QB' then
        return QBCore.Functions.GetPlayer(source)
    elseif CodeStudio.ServerType == 'ESX' then
        return ESX.GetPlayerFromId(source)
    end
end

function GetIdentifier(source)
    local Player = GetPlayer(source)
    if not Player then return end

    if CodeStudio.ServerType == 'QB' then
        return Player.PlayerData.citizenid
    elseif CodeStudio.ServerType == 'ESX' then
        return Player.identifier
    end
end

function GetPlayerJob(source)
    local Player = GetPlayer(source)
    if not Player then return end

    if CodeStudio.ServerType == 'QB' then
        return Player.PlayerData.job.name, Player.PlayerData.job.label, Player.PlayerData.job.grade.level
    elseif CodeStudio.ServerType == 'ESX' then
        return Player.job.name, Player.job.label, Player.job.grade
    end
end

function GetPlayerName(source)
    local Player = GetPlayer(source)
    if not Player then return end

    if CodeStudio.ServerType == 'QB' then
        return Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    elseif CodeStudio.ServerType == 'ESX' then
        return Player.get('firstName')..' '..Player.get('lastName')
    end
end

lib.callback.register('cs:documents:getNearbyPlayer', function(source)
    local players = {}
    local nearby = lib.callback.await('cs:documents:getClosestPlayer', source, false)
    if nearby and #nearby > 0 then
        for _, playerID in pairs(nearby) do
            if CodeStudio.ServerType == 'QB' then
                local player = QBCore.Functions.GetPlayer(playerID)
                if player then
                    players[#players+1] = {
                        id = playerID,
                        name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
                    }
                end
            elseif CodeStudio.ServerType == 'ESX' then
                local player = ESX.GetPlayerFromId(playerID)
                if player then
                    players[#players+1] = {
                        id = playerID,
                        name = player.getName()
                    }
                end
            end
        end
    end

    return players
end)


if CodeStudio.Documents.Download_Document_Option then
    --- Only Work When You Enable Download Option ---
    function addItem(source, metadata)
        if GetResourceState('ox_inventory') == 'started' then
            exports['ox_inventory']:AddItem(source, 'document', 1, metadata)
        elseif GetResourceState('qs-inventory') == 'started' then
            exports['qs-inventory']:AddItem(source, 'document', 1, false, metadata)
        elseif GetResourceState('tgiann-inventory') == 'started' then
            exports["tgiann-inventory"]:AddItem(source, 'document', 1, nil, metadata, false)
        elseif GetResourceState('origen_inventory') == 'started' then
            exports['origen_inventory']:addItem(source, 'document', 1, metadata, false)
        else
            if CodeStudio.ServerType == 'QB' then
                local Player = QBCore.Functions.GetPlayer(source)
                Player.Functions.AddItem('document', 1, nil, metadata)
            elseif CodeStudio.ServerType == 'ESX' then
                local Player = ESX.GetPlayerFromId(source)
                Player.addInventoryItem('document', 1, metadata)
            end
        end
    end

    function handleDocUse(source, data)
        local itemInfo = (data and data.metadata) or (data and data.info) or {}
        TriggerClientEvent('cs:documents:useItem', source, itemInfo)
    end

    if CodeStudio.ServerType == "QB" then
        QBCore.Functions.CreateUseableItem('document', function(source, item)
            handleDocUse(source, item)
        end)
    elseif CodeStudio.ServerType == "ESX" then
        ESX.RegisterUsableItem('document', function(source, item, data)
            if GetResourceState('ox_inventory') == 'started' then
                handleDocUse(source, data)
            else
                handleDocUse(source, item)
            end
        end)
    end
end
