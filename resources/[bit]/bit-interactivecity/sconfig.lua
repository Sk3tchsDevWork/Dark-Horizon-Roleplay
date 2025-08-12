if Config.Framework == "esx" then
    Citizen.CreateThread(
        function()
            Citizen.Wait(3000)
            ESX.RegisterServerCallback(
                "bit-interactivecity:getMoney",
                function(source, cb)
                    local xPlayer = ESX.GetPlayerFromId(source)
                    money = xPlayer.getMoney()
                    cb(money)
                end
            )
        end
    )
else
    Citizen.CreateThread(
        function()
            Citizen.Wait(3000)
            QBCore.Functions.CreateCallback(
                "bit-interactivecity:getMoney",
                function(source, cb)
                    local xPlayer = QBCore.Functions.GetPlayer(source)
                    money = xPlayer.Functions.GetMoney("cash")
                    cb(money)
                end
            )
        end
    )
end

RegisterNetEvent("bit-interactivecity:removeMoney")
AddEventHandler(
    "bit-interactivecity:removeMoney",
    function(playerID, amount)
        if Config.Framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerID)
            xPlayer.removeMoney(amount)
        else
            local xPlayer = QBCore.Functions.GetPlayer(playerID)
            xPlayer.Functions.RemoveMoney("cash", amount)
        end
    end
)

RegisterNetEvent("bit-interactivecity:giveItem")
AddEventHandler(
    "bit-interactivecity:giveItem",
    function(playerID, item, amount)
        if Config.Framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerID)
            if amount == nil then
                xPlayer.addInventoryItem(item, 1)
            else
                xPlayer.addInventoryItem(item, amount)
            end
        else
            local xPlayer = QBCore.Functions.GetPlayer(playerID)
            if amount == nil then
                xPlayer.Functions.AddItem(item, 1)
            else
                xPlayer.Functions.AddItem(item, amount)
            end
        end
    end
)

RegisterNetEvent("bit-interactivecity:giveMoney")
AddEventHandler(
    "bit-interactivecity:giveMoney",
    function(playerID, amount)
        if Config.Framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerID)
            xPlayer.addMoney(amount)
        else
            local xPlayer = QBCore.Functions.GetPlayer(playerID)
            xPlayer.Functions.AddMoney("cash", amount)
        end
    end
)

RegisterNetEvent("bit-interactivecity:registerStash")
AddEventHandler(
    "bit-interactivecity:registerStash",
    function(trashId)
        if Config.Framework == "esx" then
            exports.ox_inventory:RegisterStash(trashId, "Stash", Config.throwInTrashSize, 300000, false)
        end
    end
)
