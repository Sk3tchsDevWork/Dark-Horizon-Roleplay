local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('banking:getBankInfo')
AddEventHandler('banking:getBankInfo', function(citizenid)
    local src = source
    print("Server received banking:getBankInfo for citizenid:", citizenid)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local playerCitizenid = Player.PlayerData.citizenid
        print("Verified citizenid from player data:", playerCitizenid)
        -- Test different account name formats
        local accountName = citizenid -- Default
        local accountInfo = exports['qb-banking']:GetAccount(accountName)
        if not accountInfo then
            print("Account not found for:", accountName)
            accountName = "player_" .. citizenid -- Try prefixed version
            accountInfo = exports['qb-banking']:GetAccount(accountName)
        end
        print("Account info for", accountName, ":", json.encode(accountInfo))
        TriggerClientEvent('banking:receiveBankInfo', src, accountInfo)
    else
        print("Player not found for source:", src)
        TriggerClientEvent('banking:receiveBankInfo', src, nil)
    end
end)