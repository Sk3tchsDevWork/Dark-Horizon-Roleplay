local QBCore = nil
local ESX = nil

CreateThread(function()
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
    end
end)

------------------
----FUNCTIONS-----
------------------

function GetIdentifier(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return nil end
        return Player.PlayerData.citizenid
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return nil end
        return xPlayer.identifier
    end
    return nil
end

function GetPlayerSource(identifier)
    if QBCore then
        local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
        return player and player.PlayerData.source or 0
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        return xPlayer and xPlayer.source or 0
    end
end

function GetCharacterName(source)
    local name = "Unknown"
    
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        end
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            name = xPlayer.getName()
        end
    end

    return name
end

function SendToDiscord(embedType, ID, jobName, earnedPay, sentenceReduction, purchasedItem, amount, visitDuration, sentence, jailedBy, fineAmount)
    if not Config.WebHooks then return end

    local license = GetIdentifier(ID)
    local embedOptions = {}

    if embedType == "jailed" then
        embedOptions = {
            title = "Player Jailed",
            description = "A player has been jailed in the prison system.",
            color = 16776960,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
                { name = "Jailed By ID", value = jailedBy or "Unknown", inline = true },
                { name = "Sentence (minutes)", value = tostring(sentence), inline = true },
                { name = "Fine Amount", value = fineAmount or "None", inline = true }
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }

    elseif embedType == "releasedPrison" then
        embedOptions = {
            title = "Player Released",
            description = "A player has been released from prison.",
            color = 65280,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }
    elseif embedType == "communityService" then
        embedOptions = {
            title = "Community Service Started",
            description = "A player has been assigned community service.",
            color = 16776960,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
                { name = "Assigned By", value = assignedBy or "Unknown", inline = true },
                { name = "Sentence (minutes)", value = tostring(sentence), inline = true },
                { name = "Fine Amount", value = fineAmount or "None", inline = true }
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }
    elseif embedType == "releasedcommunityService" then
        embedOptions = {
            title = "Player Released",
            description = "A player has been released from prison.",
            color = 65280,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }
    elseif embedType == "prisonBreak" then
        embedOptions = {
            title = "Prison Break Alert!",
            description = "A prison break is in progress! Inmate has escaped from prison.",
            color = 16711680,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }
    elseif embedType == "prisonJobFinished" then
        embedOptions = {
            title = "Prison Job Completed",
            description = "A player has successfully completed a prison job.",
            color = 3447003,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
                { name = "Job", value = jobName, inline = true },
                { name = "Earned Pay", value = earnedPay, inline = true },
                { name = "Sentence Reduction", value = tostring(sentenceReduction) .. " minutes", inline = true }
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }
    elseif embedType == "itemTrade" then
        embedOptions = {
            title = "Item Trade Completed",
            description = "A player has traded items within the prison system.",
            color = 10197915,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
                { name = "Trade ID", value = purchasedItem or "Unknown", inline = true },
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }
    elseif embedType == "illegalShopPurchase" then
        embedOptions = {
            title = "Illegal Shop Purchase",
            description = "A player has purchased an item from the illegal shop.",
            color = 16711680,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
                { name = "Item Purchased", value = purchasedItem, inline = true },
                { name = "Amount", value = tostring(amount), inline = true },
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }

    elseif embedType == "commissaryShopPurchase" then
        embedOptions = {
            title = "Commissary Shop Purchase",
            description = "A player has purchased an item from the prison commissary.",
            color = 15844367,
            fields = {
                { name = "License", value = license, inline = true },
                { name = "Player ID", value = ID, inline = true },
                { name = "Item Purchased", value = purchasedItem, inline = true },
                { name = "Amount", value = tostring(amount), inline = true },
            },
            footerText = "Made by Dynyx Scripts",
            footerIcon = "https://i.imgur.com/aEasQTt.png"
        }
    else
        print("Invalid embedType provided!")
        return
    end

    local payload = {
        username = "Dynyx Scripts - Prison",
        embeds = {
            {
                title = embedOptions.title,
                description = embedOptions.description,
                color = embedOptions.color,
                fields = embedOptions.fields,
                footer = {
                    text = embedOptions.footerText,
                    icon_url = embedOptions.footerIcon
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    }

    PerformHttpRequest(
        Config.WebHookURL,
        function(err, text, headers)
            
        end,
        'POST',
        json.encode(payload),
        { ['Content-Type'] = 'application/json' }
    )
end

function Notify(src, Title, Desc, type)
    if Config.Notifications == "ox_lib" then
        TriggerClientEvent('ox_lib:notify', src, {
            title = Title,
            description = Desc,
            type = type,
            duration = 5000,
            position = "center-right"
        })
    elseif Config.Notifications == "qb-core" then
        TriggerClientEvent('QBCore:Notify', src, Desc, type)
    else
        print("Invalid Config.Notifications")
    end
end   

function AddItem(source, item, quantity, metadata)
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:AddItem(source, item, quantity, metadata)
    elseif Config.Inventory == "ps-inventory" then
        exports['ps-inventory']:AddItem(source, item, quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "add")
    elseif Config.Inventory == "ps-inventory" then
        exports['ps-inventory']:AddItem(source, item, quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "add")
    elseif Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:AddItem(source, item, quantity, nil, metadata)
    else
        print("Invalid Config.Inventory")
    end
end

function RemoveItem(source, item, quantity, slot)
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:RemoveItem(source, item, quantity, nil, slot)
    elseif Config.Inventory == "ps-inventory" then
        exports['ps-inventory']:RemoveItem(source, item, quantity, slot)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "remove")
    elseif Config.Inventory == "ps-inventory" then
        print(source, item, quantity, slot)
        exports['ps-inventory']:RemoveItem(source, item, quantity, slot)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "remove")
    elseif Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:RemoveItem(source, item, quantity, slot)
    else
        print("Invalid Config.Inventory")
    end
end

function GetItemCount(source, itemN)
    if Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:Search(source, 'count', itemN) or 0
    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            local item = Player.Functions.GetItemByName(itemN)
            return item and item.amount or 0
        end
    elseif Config.Inventory == "qs-inventory" then
        local playerInventory = exports['qs-inventory']:GetInventory(source)
        if playerInventory then
            for itemName, itemData in pairs(playerInventory) do   
                if itemData.name == itemN then
                    return itemData.amount or 0
                end
            end
        end    
    else
        print("Invalid Config.Inventory")
    end
    return 0
end

function GetInventory(source)
    if Config.Inventory == "ox_inventory" then
        local playerInventory = exports.ox_inventory:GetInventory(source)
        return playerInventory.items
    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return {} end
        return Player.PlayerData.items
    elseif Config.Inventory == "qs-inventory" then
        local playerInventory = exports['qs-inventory']:GetInventory(source)
        if not playerInventory then return {} end
        return playerInventory
    else
        print("Invalid Config.Inventory")
        return {}
    end
end

function ClearInventory(source)
    if Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:ClearInventory(source)
    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        for k, v in pairs(Player.PlayerData.items) do
            Player.Functions.RemoveItem(v.name, v.amount, v.slot)
        end
    elseif Config.Inventory == "qs-inventory" then
        local playerInventory = exports['qs-inventory']:GetInventory(source)
        if playerInventory then
            for _, itemData in pairs(playerInventory) do
                exports['qs-inventory']:RemoveItem(source, itemData.name, itemData.amount, itemData.slot)
            end
        end
    else
        print("Invalid Config.Inventory")
    end
end


function RegisterStash(source, citizenid)
    local stashId = 'prisonstash_' .. citizenid
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:RegisterStash(
            stashId,
            "Toilet Stash",
            Config.ToiletStashInfo.Slots,
            Config.ToiletStashInfo.Weight,
            citizenid, 
            nil,
            Config.ToiletStashCoords
        )
    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        -- doesnt require anything here
    elseif Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:RegisterStash(
            source,
            stashID,
            Config.ToiletStashInfo.Slots,
            Config.ToiletStashInfo.Weight
        )
    else
        print("Invalid Config.Inventory")
    end
end

function OpenStash(source, citizenid)
    local stashId = 'prisonstash_' .. citizenid
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:forceOpenInventory(source, 'stash', { id = stashId })
    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        exports[Config.Inventory]:OpenInventory(source, stashId, {
            maxweight = Config.ToiletStashInfo.Weight,
            slots = Config.ToiletStashInfo.Slots,
        })
    elseif Config.Inventory == "qs-inventory" then
        TriggerClientEvent('dynyx_prison:qsOpenStash', source, stashId)
    else
        print("Invalid Config.Inventory")
    end
end

function AddPrisonerExternally(serverId, sentence, charges, lifer, serviceType, previousSentence, fine)
    TriggerEvent('dynyx_prison:addprisoner', serverId, sentence, charges, lifer, serviceType, previousSentence, fine)
end

exports('AddPrisonerExternally', AddPrisonerExternally)

function ReleasePrisonerExternally(citizenid, jailbreak)
    TriggerEvent('dynyx_prison:releasePrisoner', citizenid, jailbreak)
end

exports('ReleasePrisonerExternally', ReleasePrisonerExternally)

function ModifyPrisonerSentenceExternally(prisonerCitizenId, newSentence)
    TriggerEvent('dynyx_prison:modifySentence', prisonerCitizenId, newSentence)
end

exports('ModifyPrisonerSentenceExternally', ModifyPrisonerSentenceExternally)

function GetRemainingPrisonSentence(identifier)
    local result = MySQL.query.await('SELECT timeRemaining FROM dynyx_prisoners WHERE citizenid = ?', { identifier })
    if result and result[1] and result[1].timeRemaining then 
        return tonumber(result[1].timeRemaining)
    end
    return 0
end

exports('GetRemainingPrisonSentence', GetRemainingPrisonSentence)

------------------
------EVENTS------
------------------

RegisterNetEvent('dynyx_prison:server:NotifyMealTime', function(time)
    if time == "morning" then
        SendFoodAlertToPrisoners(Loc[Config.Lan]["notifi_meal_morning"].label, Loc[Config.Lan]["notifi_meal_morning"].text)
    elseif time == "evening" then
        SendFoodAlertToPrisoners(Loc[Config.Lan]["notifi_meal_evening"].label, Loc[Config.Lan]["notifi_meal_evening"].text)
    end
end)

RegisterNetEvent('dynyx_prison:fine', function(data)
    if not Config.FineSystem then return end

    local fineamt = data.fine
    local serverId = data.serverId
    if not fineamt then return end

    if QBCore then
        local Player = QBCore.Functions.GetPlayer(serverId)
        if not Player then return end
        Player.Functions.RemoveMoney('bank', fineamt, 'jail-fine')

    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(serverId)
        if not xPlayer then return end
        xPlayer.removeAccountMoney('bank', fineamt)
    end

    local localeData = Loc[Config.Lan] and Loc[Config.Lan]["notifi_fine_issued"]
    if localeData and localeData.text and localeData.label then
        Notify(serverId, localeData.label, localeData.text:format(fineamt), "error")
    else
        print("Invalid locale entry for fine notification")
    end
end)


CreateThread(function()
    if Config.Inventory == "ox_inventory" then
        exports('holdtray', function(event, item, inventory, slot, data)
            if event ~= 'usingItem' or item.name ~= Config.PrisonTrayFoods.trayItem then return end
            for _, reward in pairs(Config.PrisonTrayFoods.rewardItems) do
                if not reward.chance or math.random(100) <= reward.chance then
                    AddItem(inventory.id, reward.name, reward.amount)
                end
            end
        end)
    elseif Config.Inventory == "ps-inventory" or Config.Inventory == "ps-inventory" then
        QBCore.Functions.CreateUseableItem(Config.PrisonTrayFoods.trayItem, function(source, item)
            local Player = QBCore.Functions.GetPlayer(source)
            if not Player then return end
            if not Player.Functions.GetItemByName(item.name) then return end
            if item.name ~= Config.PrisonTrayFoods.trayItem then return end

            for _, reward in pairs(Config.PrisonTrayFoods.rewardItems) do
                if not reward.chance or math.random(100) <= reward.chance then
                    RemoveItem(source, item.name, 1, item.slot)
                    AddItem(source, reward.name, reward.amount)
                end
            end
        end)

        QBCore.Functions.CreateUseableItem(Config.TabletItem, function(source, item)
            TriggerClientEvent('dynyx_prison:openTablet', source)
        end)

    elseif Config.Inventory == "qs-inventory" then
        exports['qs-inventory']:CreateUsableItem(Config.PrisonTrayFoods.trayItem, function(source, item)
            if item.name ~= Config.PrisonTrayFoods.trayItem then return end
            for _, reward in pairs(Config.PrisonTrayFoods.rewardItems) do
                if not reward.chance or math.random(100) <= reward.chance then
                    RemoveItem(source, item.name, 1, item.slot)
                    AddItem(source, reward.name, reward.amount) 
                end
            end
        end)
        exports['qs-inventory']:CreateUsableItem(Config.TabletItem, function(source, item)
            TriggerClientEvent('dynyx_prison:openTablet', source)
        end)

    else
        print("Invalid Config.Inventory setting. Please use 'ox_inventory', 'ps-inventory', 'ps-inventory', or 'qs-inventory'.")
    end
end)