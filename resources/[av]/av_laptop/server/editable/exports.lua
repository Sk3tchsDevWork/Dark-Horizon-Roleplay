while not Config.Framework or not Config.Inventory do Wait(1) end

local avBusiness = false
local itemList = GetResourceState("codem-inventory") == "started" and exports['codem-inventory']:GetItemList()

-- Get Framework Core
function getCore()
    if not Core then
        if Config.Framework == "qb" then
            return exports['qb-core']:GetCoreObject()
        elseif Config.Framework == "esx" then
            return exports['es_extended']:getSharedObject()
        end
    end
    return Core
end

-- Register Item
function registerItem(name)
    dbug('registerItem(name)', name)
    local callback = function(source, item, info)
        usedItem(source, item, info, name)
    end
    if Config.Framework == "qb" then
        Core.Functions.CreateUseableItem(name, callback)
    elseif Config.Framework == "qbox" then
        exports.qbx_core:CreateUseableItem(name, callback)
    elseif Config.Framework == "esx" then
        Core.RegisterUsableItem(name,callback)
    end
end

-- used Item
function usedItem(source,item,info,name)
    if Config.Inventory == "ox_inventory" then return end -- No need to trigger item, we are gonna use ox_inv event directly
    local metadata, slot = getMetadata(item, info)
    dbug('usedItem(source, item, metadata, slot)', source, name, metadata and json.encode(metadata), slot)
    TriggerEvent('ox_inventory:usedItem', source, name, slot, metadata)
end

-- get item label
function getItemLabel(name)
    if Config.Inventory == "ox_inventory" then
        local data = exports.ox_inventory:Items(name)
        if data and data['label'] then return data['label'] or false end
    end
    if Config.Inventory == "qs-inventory" then
        return exports['qs-inventory']:GetItemLabel(name)
    end
    if Config.Inventory == "origen_inventory" then
        return exports.origen_inventory:GetItemLabel(name)
    end
    if Config.Framework == "qb" then
        if Core and Core.Shared and Core.Shared.Items then
            return Core.Shared.Items[name] and Core.Shared.Items[name]['label'] or false
        end
    end
    if Config.Framework == "esx" then
        return Core and Core.GetItemLabel(name) or false
    end
    return false
end

-- Get Player ID by identifier
function getSourceByIdentifier(identifier)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayerByCitizenId(identifier)
        if Player then
            return Player.PlayerData.source
        end
    elseif Config.Framework == "qbox" then
        local Player = getPlayerByIdentifier(identifier)
        if Player then
            return Player.PlayerData.source
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            return xPlayer.source
        end
    end
    return false
end

function getPlayerByIdentifier(identifier)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayerByCitizenId(identifier)
        if Player then
            return Player
        end
    elseif Config.Framework == "qbox" then
        return exports.qbx_core:GetPlayerByCitizenId(identifier)
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            return xPlayer
        end
    end
    return false
end

-- Save Player
function savePlayer(source)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        if Player then
            Player.Functions.Save()
        end
    elseif Config.Framework == "qbox" then
        exports.qbx_core:Save(source)
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(source)
        if Core.SavePlayer and xPlayer then
            Core.SavePlayer(xPlayer)
        end
    end
end

local myAdmins = {
    ['license:123456'] = true,
    ['license:234567'] = true,
}

-- Get Player Permission Level
function getPermission(src, level)
    if Config.Framework == "qb" then
        if IsPlayerAceAllowed(src, level) or Core.Functions.HasPermission(src, level) then
            return true
        else
            local identifier = GetPlayerIdentifierByType(src, "license")
            return myAdmins and myAdmins[identifier] or false
        end
    elseif Config.Framework == "qbox" then
        if IsPlayerAceAllowed(src, level) then
            return true
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        return xPlayer.getGroup() == level
    end
    return false
end

-- Get Player Identifier
function getIdentifier(src)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.citizenid
        end
    elseif Config.Framework == "qbox" then
        local Player = exports.qbx_core:GetPlayer(src)
        if Player then
            return Player.PlayerData.citizenid
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.identifier
        end
    end
    return false
end

-- Get Player Object
function getPlayer(src)
    if Config.Framework == "qb" then
        return Core.Functions.GetPlayer(src)
    elseif Config.Framework == "qbox" then
        return exports.qbx_core:GetPlayer(src)
    elseif Config.Framework == "esx" then
        return Core.GetPlayerFromId(src)
    end
end

-- Add Item to player
function addItem(src, item, amount, info, slot)
    if not src then return false end
    if Config.Inventory == "tgiann-inventory" then
        return exports["tgiann-inventory"]:AddItem(src, item, amount, slot, info)
    end
    if Config.Inventory and Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:AddItem(src, item, amount, info, slot)
    end
    if Config.Framework == "qbox" then
        print("^1You should be using ox_inventory with qbox, otherwise edit the addItem function in laptop/server/editable/exports.lua^7")
        return false
    end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        return Player.Functions.AddItem(item, amount, false, info)
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        if xPlayer.canCarryItem(item, amount) then
            if Config.Inventory == "qs-inventory" then
                exports['qs-inventory']:AddItem(src, item, amount, slot, info)
            else
                xPlayer.addInventoryItem(item, amount, info)
            end
            return true
        end
    end
    return false
end

-- Remove Item from Player
function removeItem(src, item, amount, slot, metadata)
    if not src then return false end
    local amount = amount or 1
    if Config.Inventory and Config.Inventory == "ox_inventory" then
        return exports['ox_inventory']:RemoveItem(src, item, amount, metadata, slot)
    elseif Config.Inventory == "ps-inventory" and not Config.OldQBInventory then
        return exports[Config.Inventory]:RemoveItem(src, item, amount, slot)
    else
        return exports[Config.Inventory]:RemoveItem(src, item, amount, slot, metadata)
    end
end

-- Set Item metadata
function setItemMetadata(src, item, slot, metadata)
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:SetMetadata(src, slot, metadata)
        return
    end
    if Config.Inventory == 'qs-inventory' then
        exports['qs-inventory']:SetItemMetadata(src, slot, metadata)
        return
    end
    if Config.Inventory == "origen_inventory" then
        local name = item
        if type(name) == "table" then
            name = item.name
        end
        exports['origen_inventory']:AddItemMetadata(src, name, slot, metadata)
        return
    end
    if Config.Inventory == "codem-inventory" then
        exports['codem-inventory']:SetItemMetadata(src, slot, metadata)
        return
    end
    if Config.Inventory == "tgiann-inventory" then
        local itemName = item
        if type(item) == "table" then
            itemName = item and item[1]
        end
        exports["tgiann-inventory"]:UpdateItemMetadata(tostring(src), itemName, tostring(slot), metadata)
        return
    end
    exports[Config.Inventory]:SetItemData(src, item, 'info', metadata, slot)
end

-- Set Item Metadata in Stash, don't ask me why there's 2 exports doing (almost) exactly the same -.-
function setItemMetadataStash(stash, item, slot, metadata)
    --    print(stash, item, slot, json.encode(metadata))
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:SetMetadata(stash, slot, metadata)
        return
    end
end

-- Get Player money
function getMoney(src, account)
    dbug("getMoney(src,account)", src, account)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = getPlayer(src)
        if Player then
            if (Player.PlayerData and Player.PlayerData.metadata) and Player.PlayerData.metadata.crypto then
                if Player.PlayerData.metadata.crypto[account] then
                    return Player.PlayerData.metadata.crypto[account] or 0
                end
            end
            if Player.PlayerData.money[account] then
                return Player.PlayerData.money[account] or 0
            end
        end
        return false
    elseif Config.Framework == "qbox" then
        local identifier = getIdentifier(src)
        if identifier then
            return exports.qbx_core:GetMoney(identifier, account) or 0
        end
    elseif Config.Framework == "esx" then
        local xPlayer = getPlayer(src)
        if xPlayer and xPlayer.getAccount(account) then
            return xPlayer.getAccount(account).money
        else
            return false
        end
    end
end

-- Add Money
function addMoney(src, account, amount, reason)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        local Crypto = Player.PlayerData.metadata and Player.PlayerData.metadata.crypto or false
        if Crypto and Crypto[account] then
            Crypto[account] += tonumber(amount)
            Player.Functions.SetMetaData("crypto", Crypto)
        else
            Player.Functions.AddMoney(account, amount)
        end
    elseif Config.Framework == "qbox" then
        local identifier = getIdentifier(src)
        if identifier then
            exports.qbx_core:AddMoney(identifier, account, amount, reason or '')
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        xPlayer.addAccountMoney(account, amount)
    end
end

-- Add Money to Offline Player
function addMoneyOffline(identifier, account, amount, reason)
    if Config.Framework == "qb" or Config.Framework == "qbox" then
        local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', { identifier })
        if result and result[1] then
            local RecieverMoney = result[1].money and json.decode(result[1].money) or {}
            RecieverMoney[account] = RecieverMoney[account] or 0
            RecieverMoney[account] = (RecieverMoney[account] + amount)
            MySQL.update.await('UPDATE players SET money = ? WHERE citizenid = ?',
                { json.encode(RecieverMoney), identifier })
        end
    elseif Config.Framework == "esx" then
        local result = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', { identifier })
        if result and result[1] then
            local RecieverMoney = result[1].accounts and json.decode(result[1].accounts)
            RecieverMoney[account] = RecieverMoney[account] or 0
            RecieverMoney[account] = (RecieverMoney[account] + amount)
            MySQL.update.await('UPDATE users SET accounts = ? WHERE identifier = ?',
                { json.encode(RecieverMoney), identifier })
        end
    end
end

-- Remove money from player
function removeMoney(src, account, amount, reason)
    dbug("removeMoney(src, account, amount)", src, account, amount)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        if Player then
            local Crypto = Player.PlayerData.metadata and Player.PlayerData.metadata.crypto or false
            if Crypto and Crypto[account] then
                Crypto[account] -= amount
                Player.Functions.SetMetaData("crypto", Crypto)
            else
                Player.Functions.RemoveMoney(account, amount)
            end
        end
    elseif Config.Framework == "qbox" then
        local identifier = getIdentifier(src)
        if identifier then
            exports.qbx_core:RemoveMoney(identifier, account, amount, reason or '')
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        xPlayer.removeAccountMoney(account, amount)
    end
end

-- Has item?
function hasItem(src, name, amount)
    if not src then return false end
    local qty = amount and tonumber(amount) or 1
    if Config.Inventory == "ox_inventory" then
        local item = exports['ox_inventory']:GetItem(src, name, nil, true)
        if item and tonumber(item) >= qty then
            return true
        else
            return false
        end
    end
    if Config.Inventory == "tgiann-inventory" then
        return exports["tgiann-inventory"]:HasItem(src, name, qty)
    end
    if Config.Framework == "qb" then
        return exports[Config.Inventory]:HasItem(src, name, qty)
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        local item = xPlayer.getInventoryItem(name)
        if item and item['count'] >= qty then
            return true
        end
    end
    return false
end

-- Get Player Job
function getJob(src)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        return Player.PlayerData.job
    elseif Config.Framework == "qbox" then
        local Player = getPlayer(src)
        return Player.PlayerData.job
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        return xPlayer.getJob()
    end
end

-- Check if player have X job or job type
function hasJob(source,job)
    if not source or not job then
        print("^3[WARNING] hasJob exports received null as argument (source, job):", source, job)
        return false
    end
    local PlayerJob = getJob(source)
    if type(job) == "string" then
        if PlayerJob and (PlayerJob.name == job or PlayerJob.type == job) then
            return true
        end
    else
        for _, name in pairs(job) do
            if PlayerJob.name == name or PlayerJob.type == name then
                return true
            end
        end
    end
    return false
end

-- Get Player Name
function getName(src)
    if not src then return false end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        end
    elseif Config.Framework == "qbox" then
        local Player = getPlayer(src)
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.getName()
        end
    end
    return false
end

function getMetadata(item, info)
    local metadata = {}
    local slot = 1
    if item and type(item) == "table" and next(item) then
        local itemInfo = item.metadata or item.info or {}
        metadata = itemInfo or {}
        slot = item.slot or 1
    end
    if info and type(info) == "table" and next(info) then
        local itemInfo = info.metadata or info.info or {}
        metadata = itemInfo or {}
        slot = info.slot or 1
    end
    return metadata, slot
end

function getInventoryItem(source, name)
    if Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:GetItem(source, name)
    end
    if Config.Inventory == "origen_inventory" then
        return exports.origen_inventory:GetItemByName(source, name)
    end
    return exports[Config.Inventory]:GetItemByName(source, name)
end

-- Get All items from Player
function GetInventoryItems(source)
    if Config.Inventory == "ox_inventory" then
        return exports['ox_inventory']:GetInventoryItems(source)
    end
    if Config.Inventory == "tgiann-inventory" then
        local list = exports["tgiann-inventory"]:GetPlayerItems(source)
        local items = {}
        if list and next(list) then
            for _, item in pairs(list) do
                items[#items+1] = item
            end
        end
        return items
    end
    if Config.Framework == "qbox" then
        print("^1If using Qbox with other inv than ox_inv you need to edit the GetInventoryItems function in laptop/server/editable/exports.lua^7")
    end
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData.items
        end
    end
    if Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.getInventory()
        end
    end
    return {}
end

-- Get all players from X job
function getJobPlayers(job)
    if Config.Framework == "qb" then
        local data = {}
        local added = {}
        local Players = Core.Functions.GetQBPlayers()
        for k, v in pairs(Players) do
            if v['PlayerData']['job']['name'] == job then
                data[#data + 1] = {
                    identifier = v['PlayerData']['citizenid'],
                    name = v.PlayerData.charinfo.firstname .. ' ' .. v.PlayerData.charinfo.lastname,
                    grade = v.PlayerData.job.grade,
                }
                added[v['PlayerData']['citizenid']] = true
            end
        end
        local Players2 = MySQL.query.await("SELECT * FROM players WHERE job LIKE '%" .. job .. "%'", {})
        for k, v in pairs(Players2) do
            if not added[v['citizenid']] then
                local Player = getPlayerByIdentifier(v['citizenid'])
                if Player then
                    if Player.PlayerData.job.name == job then
                        data[#data + 1] = {
                            identifier = v['citizenid'],
                            name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                            grade = Player.PlayerData.job.grade,
                        }
                    end
                else
                    data[#data + 1] = {
                        identifier = v['citizenid'],
                        name = json.decode(v['charinfo']).firstname .. ' ' .. json.decode(v['charinfo']).lastname,
                        grade = json.decode(v['job']).grade,
                    }
                end
            end
        end
        return data
    elseif Config.Framework == "qbox" then
        local data = {}
        local Players = exports.qbx_core:SearchPlayers({job = job})
        if Players and next(Players) then
            for k, v in pairs(Players) do
                local PlayerData = v['PlayerData']
                data[#data + 1] = {
                    identifier = PlayerData['citizenid'],
                    name = PlayerData.charinfo.firstname .. ' ' .. PlayerData.charinfo.lastname,
                    grade = PlayerData.job.grade,
                }
            end
        end
        return data
    elseif Config.Framework == "esx" then
        local data = {}
        local Players = MySQL.query.await("SELECT * FROM users WHERE job = ?", { job })
        for k, v in pairs(Players) do
            local xPlayer = getPlayerByIdentifier(v['identifier'])
            if xPlayer then
                local job = xPlayer.getJob()
                data[#data + 1] = {
                    identifier = v['identifier'],
                    name = xPlayer.getName(),
                    grade = { name = job.grade_label, level = job.grade },
                }
            else
                if Core.Jobs and not Core.Jobs[v['job']] then
                    Core = exports['es_extended']:getSharedObject()
                end
                local jobData = Core.Jobs[v['job']]
                local myGrade = jobData['grades'] and jobData['grades'][tostring(v['job_grade'])]
                if myGrade then
                    data[#data + 1] = {
                        identifier = v['identifier'],
                        name = v['firstname'] .. ' ' .. v['lastname'],
                        grade = { name = myGrade['label'], level = v['job_grade'] },
                    }
                else
                    dbug("No data for job grade ", v['job_grade'], " in job ", v['job'])
                end
            end
        end
        return data
    end
end

function setJob(target, job, grade)
    target = tonumber(target)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(target)
        if Player then
            if Core.Shared.Jobs[job] then
                Player.Functions.SetJob(job, 0)
                local jobData = Core.Shared.Jobs[job]['grades']['0']
                if not jobData then
                    jobData = Core.Shared.Jobs[job]['grades'][0] or Core.Shared.Jobs[job]['grades'][1]
                end
                if jobData then
                    local info = {
                        name = jobData['name'],
                        onduty = true,
                        isboss = false,
                        payment = jobData['payment'],
                        grade = { name = jobData['name'], level = 0 }
                    }
                    MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?',
                        { json.encode(info), Player.PlayerData.citizenid })
                    return true
                else
                    print("^3[WARNING]^7 Job "..job.." doesn't have grade 0 or 1")
                end
            end
        end
    elseif Config.Framework == "qbox" then
        local identifier = getIdentifier(target)
        if identifier then
            exports.qbx_core:SetJob(identifier, job, grade or 0)
            exports.qbx_core:Save(target)
            return true
        end
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(target)
        if xPlayer then
            xPlayer.setJob(job, 0)
            MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', { job, 0, xPlayer
                .identifier })
            return true
        end
    end
    return false
end

function setJobGrade(identifier, job, grade)
    local grade = grade
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayerByCitizenId(identifier)
        local jobData = Core.Shared.Jobs[job]['grades'][grade]
        if not jobData then
            grade = tonumber(grade)
            jobData = Core.Shared.Jobs[job]['grades'][grade]
        end
        if not jobData then
            print("^3[WARNING] ^7Job grade "..grade.." not found in job "..job)
            return 
        end
        if Player then
            Player.Functions.SetJob(job, grade)
        end
        local info = {
            name = job,
            onduty = true,
            isboss = jobData['isboss'],
            payment = jobData['payment'],
            grade = { name = jobData['name'], level = grade }
        }
        MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(info), identifier })
    elseif Config.Framework == "qbox" then
        exports.qbx_core:SetJob(identifier, job, grade or 0)
    elseif Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            xPlayer.setJob(job, grade)
        end
        MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', { job, grade, identifier })
    end
end

function toggleDuty(source,state)
    if Config.Framework == "qbox" then
        local identifier = getIdentifier(source)
        if identifier then
            exports.qbx_core:SetJobDuty(identifier, state)
        end
    elseif Config.Framework == "qb" then
        local Player = getPlayer(source)
        if Player then
            Player.Functions.SetJobDuty(state)
        end
    elseif Config.Framework == "esx" then
        local Player = getPlayer(source)
        if Player then
            Player.setMeta("jobDuty", state)
        end
    end
end

function Discord(webhook, message)
    PerformHttpRequest(webhook, function() end, 'POST', json.encode({ username = 'AV Scripts', embeds = message }),
        { ['Content-Type'] = 'application/json' })
end

function getPhone(source)
    local phone = ""
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        if Player then
            phone = Player.PlayerData.charinfo.phone
        end
    elseif Config.Framework == "qbox" then
        local Player = getPlayer(source)
        if Player then
            phone = Player.PlayerData.charinfo.phone
        end
    elseif Config.Framework == "esx" then

    end
    return phone
end

function addToStash(name, item, count, metadata, slot)
    if Config.Inventory == "qs-inventory" then
        return exports['qs-inventory']:AddItemIntoStash(name, item, count, slot, metadata)
    end
    if Config.Inventory == "ox_inventory" then
        local success, _ = exports['ox_inventory']:AddItem(name, item, count, metadata, slot)
        return success
    end
    if Config.Inventory == "tgiann-inventory" then
        return exports["tgiann-inventory"]:AddItemToSecondaryInventory('stash', name, item, count, slot, metadata)
    end
    if Config.Inventory == "origen_inventory" then
        exports[Config.Inventory]:AddStashItem(name, slot, slot, item, count, metadata)
        TriggerEvent("inventory:server:SaveInventory", "stash", name)
        return
    end
    if Config.Inventory == "codem-inventory" then
        local stash_items = exports['codem-inventory']:GetStashItems(name)
        stash_items = stash_items or {}
        if stash_items then
            local slot = slot or #stash_items+1
            local itemInfo = itemList[item] or {}
            stash_items[tostring(slot)] = {
                name = itemInfo.name or item,
                label = itemInfo.label or exports['codem-inventory']:GetItemLabel(item),
                image = itemInfo.image or "",
                weight = itemInfo.weight or 0,
                type = itemInfo.type or 'item',
                amount = count,
                description = itemInfo.description or '',
                slot = slot and tostring(slot) or "1",
                info = metadata or {},
                unique = itemInfo.unique or true,
                useable = itemInfo.useable or false,
                shouldClose = itemInfo.shouldClose or false
            }
            exports['codem-inventory']:UpdateStash(name, stash_items)
            return true
        end
        return false
    end
    if Config.Inventory == "ps-inventory" and not Config.OldQBInventory then
        local res = exports[Config.Inventory]:AddItem(name, item, count, slot, metadata, false)
        return res
    else
        local res = exports[Config.Inventory]:addStashItem(name, slot, slot, item, count, metadata)
        TriggerEvent("inventory:server:SaveInventory", "stash", name)
        return res
    end
end

function getStashItems(name)
    if Config.Inventory == "ox_inventory" then
        local inv = exports['ox_inventory']:GetInventory(name)
        if inv and inv.items then
            return inv.items
        end
        return false
    end
    if Config.Inventory == "codem-inventory" then
        local items = {}
        local stash = exports[Config.Inventory]:GetStashItems(name)
        if stash and next(stash) then
            for _, v in pairs(stash) do
                items[#items+1] = v
            end
        end
        return items
    end
    if Config.Inventory == "tgiann-inventory" then
        local list = exports["tgiann-inventory"]:GetSecondaryInventoryItems("stash", name)
        local items = {}
        if list and next(list) then
            for _, item in pairs(list) do
                items[#items+1] = item
            end
        end
        return items
    end
    if Config.Inventory == "ps-inventory" and not Config.OldQBInventory then
        local inventories = MySQL.single.await('SELECT `items` FROM `inventories` WHERE `identifier` = ?', {
            name
        })
        if inventories and inventories['items'] then
            return json.decode(inventories['items'])
        end
    else
        local items = exports[Config.Inventory]:GetStashItems(name)
        if items then
            return items
        end
    end
    return false
end

-- Delete all stash items
function wipeStash(name)
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:ClearInventory(name)
        return
    end
    if Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:ClearOtherInventory('stash', name)
    end
    if Config.Inventory == "tgiann-inventory" then
        exports["tgiann-inventory"]:DeleteInventory('stash', name)
        return
    end
    if Config.Inventory == "origen_inventory" then
        local name = "stash_"..name
        local exists = MySQL.single.await('SELECT `items` FROM `stashitems` WHERE `stash` = ?', {
            name
        })
        if exists and exists['items'] then
            local empty = {}
            MySQL.update.await('UPDATE `stashitems` SET `items` = ? WHERE `stash` = ?', {
                json.encode(empty), name
            })
        end
        return
    end
    if Config.Inventory == "codem-inventory" then
        exports['codem-inventory']:UpdateStash(name, {})
        return
    end
    return exports[Config.Inventory]:WipeStash(name)
end

-- Remove a specific item from a stash
-- Remove a specific item from a stash
function removeStashItem(inv, item, count, metadata, slot)
    dbug('removeStashItem(inv,item,count,metadata,slot)', inv, item, count, metadata, slot)
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:RemoveItem(inv, item, count, metadata, slot)
        return
    end
    if Config.Inventory == "tgiann-inventory" then
        local res = exports["tgiann-inventory"]:RemoveItemFromSecondaryInventory('stash', inv, item, count, tostring(slot))
        dbug(res)
        return res
    end
    if Config.Inventory == "codem-inventory" then
        local found = false
        local count = count and tonumber(count) or 999
        local stashItems = exports['codem-inventory']:GetStashItems(inv)
        stashItems = stashItems or {}
        local slot = slot and tostring(slot) or false
        if slot then
            local itemExists = stashItems[slot] or false
            if itemExists and itemExists['name'] == item then
                local itemAmount = itemExists.amount or 1
                itemAmount -= count
                if itemAmount <= 0 then
                    stashItems[slot] = nil
                else
                    stashItems[slot].amount = itemAmount
                end
            end
            found = true
        end
        if not found then -- item not found (?)
            for k, v in pairs(stashItems) do
                if v['name'] == item then
                    local itemAmount = v.amount or 1
                    itemAmount -= count
                    if itemAmount <= 0 then
                        stashItems[k] = nil
                    else
                        stashItems[k].amount = itemAmount
                    end
                    found = true
                    break
                end
            end
        end
        if found then
            exports['codem-inventory']:UpdateStash(inv, stashItems)
        end
        return found
    end
    if Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:RemoveItemIntoStash(inv, item, count, slot)
    else
        if Config.Inventory == "ps-inventory" and not Config.OldQBInventory then
            exports[Config.Inventory]:RemoveItem(inv, item, count, slot)
        else
            exports[Config.Inventory]:RemoveFromStash(inv, slot, item, count)
            TriggerEvent("inventory:server:SaveInventory", "stash", inv)
        end
    end
end

-- Register new stash (needed for ox_inventory)
function registerStash(name, label, slots, weight)
    if Config.Inventory == "ox_inventory" then
        exports['ox_inventory']:RegisterStash(name, label or name, slots, weight)
        return true
    end
    if Config.Inventory == "tgiann-inventory" then
        exports["tgiann-inventory"]:RegisterStash(name, label or name, slots, weight)
        return true
    end
    if Config.Inventory == "origen_inventory" then
        exports['origen_inventory']:RegisterStash(name, {
            label = name or label,
            slots = slots or 10,
            weight = weight or 10
        })
        return true
    end
    if Config.Inventory == "ps-inventory" and not Config.OldQBInventory then
        local data = {
            label = label,
            maxweight = weight,
            slots = slots
        }
        return exports['ps-inventory']:registerInventory(name, data)
    end
    return false
end

function canCarryItem(inventory, item, amount)
    if Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:CanCarryItem(inventory, item, amount)
    end
    return true
end

-- Is Player boss?
function isBoss(src)
    if Config.Framework == "qb" then
        local Player = Core.Functions.GetPlayer(src)
        return Player.PlayerData.job.isboss
    elseif Config.Framework == "qbox" then
        local Player = getPlayer(src)
        return Player.PlayerData.job.isboss
    elseif Config.Framework == "esx" then
		local xPlayer = Core.GetPlayerFromId(src)
		return Config.BossGrades[xPlayer.job.grade_name]
    end
    return false
end

function getJobData(job)
    if Config.Framework == "qb" then
        return Core.Shared.Jobs[job]
    elseif Config.Framework == "qbox" then
        return exports.qbx_core:GetJob(job)
    elseif Config.Framework == "esx" then
		if Core.Jobs and not Core.Jobs[job] then
            Core = exports['es_extended']:getSharedObject()
        end
        return Core.Jobs[job]
    end
    return false
end

-- Get all available grades from X job
function getJobGrades(job)
    local grades = {}
    if Config.Framework == "qb" then
        local jobData = Core.Shared.Jobs[job]
        if jobData then
            for k, v in pairs(jobData.grades) do
                grades[#grades+1] = {
                    value = tostring(k),
                    label = v.name
                }
            end
        end
        return grades
    elseif Config.Framework == "qbox" then
        local jobData = exports.qbx_core:GetJob(job)
        if jobData then
            for k, v in pairs(jobData.grades) do
                grades[#grades+1] = {
                    value = tostring(k),
                    label = v.name
                }
            end
        end
        return grades
    elseif Config.Framework == "esx" then
        if not Core or not Core.Jobs then
            Core = exports['es_extended']:getSharedObject()
        end
        if not Core.Jobs[job] then
            Core = exports['es_extended']:getSharedObject() -- don't ask me why, this shitty Framework gives a lot of problems -.-
        end
        if Core and Core.Jobs[job] then
            local jobData = Core.Jobs[job].grades
            for k, v in pairs(jobData) do
                grades[#grades+1] = {
                    value = k,
                    label = v.label
                }
            end
        else
            print("[ERROR] Job "..job.." doesn't exist in Core? couldn't be found in Core.Jobs table")
        end
    end
    return grades
end

-- Get all available jobs names and label (return a table with name and label)
function getAllJobs()
    if Config.Framework == "qb" then
        local allJobs = Core.Shared.Jobs
        local result = {}
        for k, v in pairs(allJobs) do
            result[#result+1] = {
                name = k,
                label = v['label']
            }
        end
        return result
    end
    if Config.Framework == "qbox" then
        local allJobs = exports.qbx_core:GetJobs()
        local result = {}
        for k, v in pairs(allJobs) do
            result[#result+1] = {
                name = k,
                label = v['label']
            }
        end
        return result
    end
    if Config.Framework == "esx" then
        local allJobs = MySQL.query.await("SELECT * FROM jobs")
        local result = {}
        for k, v in pairs(allJobs) do
            result[#result+1] = {
                name = v['name'],
                label = v['label']
            }
        end
        return result
    end
    return {}
end

-- Returns society money or false
function getSociety(name)
    dbug("getSociety(name)", name)
    if not name then print('[ERROR] Function getSociety received NULL as argument') return end
    local res = MySQL.single.await('SELECT money FROM av_society WHERE job = ?', {name})
    if res and res['money'] then
        return res['money']
    else
        return false
    end
end

function addSociety(src, job, amount, name, description)
    dbug("addSociety(src, job, amount, name, description)", src, job, amount, name, description)
    if avBusiness then
        exports['av_business']:addMoney(name, job, amount, description)
    end
    local exists = getSociety(job)
    if exists then
        MySQL.update.await('UPDATE av_society SET money = (money + ?) WHERE job = ?', {amount, job})
    else
        MySQL.insert.await('INSERT INTO av_society (job, money) VALUES (?, ?)', {job, amount})
    end
end

function removeSociety(src, job, amount, name, description)
    dbug("removeSociety(src, job, amount, name, description)", src, job, amount, name, description)
    if avBusiness then
        exports['av_business']:removeMoney(name, job, amount, description)
    end
    MySQL.update.await('UPDATE av_society SET money = (money - ?) WHERE job = ?', {amount, job})
end

function newSociety(job, label) -- Triggered when getSociety returns false in av_business:
    dbug("newSociety(job, label)", job, label)
    MySQL.insert.await('INSERT INTO av_society (job, money) VALUES (?, ?)', {job, 0})
end

function setOfflineJob(identifier, jobName, grade)
    dbug("setOfflineJob(identifier, jobName, grade)", identifier, jobName, grade)
    if Config.Framework == "qb" then
        local jobData = Core.Shared.Jobs[jobName] and Core.Shared.Jobs[jobName]['grades']['0'] or false
        if not jobData then
            jobData = Core.Shared.Jobs[jobName] and Core.Shared.Jobs[jobName]['grades'][0] or Core.Shared.Jobs[jobName] and Core.Shared.Jobs[jobName]['grades'][1]
        end
        local newJob = {
            name = jobData['name'] or "unemployed",
            onduty = true,
            isboss = false,
            payment = jobData['payment'] or 10,
            grade = { name = jobData['name'] or "Freelancer", level = 0 }
        }
        MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(newJob), identifier })
    elseif Config.Framework == "qbox" then
        exports.qbx_core:SetJob(identifier, jobName, grade or 0)
    elseif Config.Framework == "esx" then
        MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?',
            { jobName, 0, identifier })
    end
end

function itemExists(item)
    if Config.Inventory == "ox_inventory" then
        local items = exports['ox_inventory']:Items()
        return items[item]
    end
    if Config.Inventory == "tgiann-inventory" then
        local items = exports["tgiann-inventory"]:Items()
        return items[item]
    end
    if Config.Framework == 'qb' then
        return Core.Shared.Items[name]
    elseif Config.Framework == 'esx' then
        if Core and not Core.Items then
            Core = exports['es_extended']:getSharedObject()
        end
        return Core.Items[name]
    end
    return false
end

function getItemBySlot(source,slot)
    if Config.Inventory == "ox_inventory" then
        return exports['ox_inventory']:GetSlot(source, slot)
    end
    return exports[Config.Inventory]:GetItemBySlot(source, slot)
end

function getNumPlayersFromJob(job) -- used by /cops.lua to get online players from specific job/job type
    if not job then return end
    local amount = 0
    if type(job) == "string" and alreadyCounted[job] then
        return alreadyCounted[job]
    end
    if Config.Framework == "qbox" then
        if type(job) == "string" then
            local count, players = exports['qbx_core']:GetDutyCountJob(job)
            return count
        else
            for k, v in pairs(job) do
                local count, players = exports['qbx_core']:GetDutyCountJob(v)
                amount += count
                alreadyCounted[v] = amount
            end
            return amount
        end
    end
    if Config.Framework == "qb" then
        if type(job) == "string" then
            local players = Core.Functions.GetQBPlayers()
            for _, v in pairs(players) do
                if v and (v.PlayerData.job.type == job or v.PlayerData.job.name == job) and v.PlayerData.job.onduty then
                    amount += 1
                    alreadyCounted[job] = amount
                end
            end
            return amount
        else
            local players = Core.Functions.GetQBPlayers()
            for _, v in pairs(job) do
                for _, j in pairs(players) do
                    if j and (j.PlayerData.job.type == v or j.PlayerData.job.name == v) and j.PlayerData.job.onduty then
                        amount += 1
                        alreadyCounted[v] = amount
                    end
                end
            end
            return amount
        end
    elseif Config.Framework == "esx" then
        if type(job) == "string" then
            local xPlayers = Core.GetExtendedPlayers('job', job)
            amount = #xPlayers
            alreadyCounted[job] = amount
            return amount
        else
            for _, v in pairs(job) do
                local xPlayers = Core.GetExtendedPlayers('job', v)
                amount += #xPlayers
                alreadyCounted[v] = amount
            end
            return amount
        end
    end
    return amount
end

-- Export List
exports('getSourceByIdentifier', getSourceByIdentifier)
exports('getPlayerByIdentifier', getPlayerByIdentifier)
exports('getPermission', getPermission)
exports('getIdentifier', getIdentifier)
exports('getPlayer', getPlayer)
exports('savePlayer', savePlayer)
exports('registerItem', registerItem)
exports('addItem', addItem)
exports('removeItem', removeItem)
exports('getMoney', getMoney)
exports('addMoney', addMoney)
exports('addMoneyOffline', addMoneyOffline)
exports('removeMoney', removeMoney)
exports('hasItem', hasItem)
exports('getJob', getJob)
exports('hasJob', hasJob)
exports('getName', getName)
exports('getMetadata', getMetadata)
exports('getItem', getInventoryItem)
exports('getInventoryItem', getInventoryItem)
exports('getJobPlayers', getJobPlayers)
exports('setJob', setJob)
exports('setJobGrade', setJobGrade)
exports('toggleDuty', toggleDuty)
exports('setOfflineJob', setOfflineJob)
exports('Discord', Discord)
exports('getPhone', getPhone)
exports('canCarryItem', canCarryItem)
exports('addToStash', addToStash)
exports('getStashItems', getStashItems)
exports('wipeStash', wipeStash)
exports('removeStashItem', removeStashItem)
exports('registerStash', registerStash)
exports('isBoss', isBoss)
exports('getJobData', getJobData)
exports('getJobGrades', getJobGrades)
exports('newSociety', newSociety)
exports('removeSociety', removeSociety)
exports('addSociety', addSociety)
exports('getSociety', getSociety)
exports('getAllJobs', getAllJobs)
exports('itemExists', itemExists)
exports('getItemBySlot', getItemBySlot)
exports('getCore', getCore)
exports('setItemMetadata', setItemMetadata)
exports('getNumPlayersFromJob', getNumPlayersFromJob)
exports('getInventoryItems', GetInventoryItems)
exports('getItemLabel', getItemLabel)
exports('avBusiness', function() avBusiness = true end)