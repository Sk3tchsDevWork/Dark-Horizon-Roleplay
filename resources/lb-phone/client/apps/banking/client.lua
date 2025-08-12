local QBCore = exports['qb-core']:GetCoreObject()

-- Handle NUI callback from the app
RegisterNUICallback('getBankInfo', function(data, cb)
    print("NUI Callback 'getBankInfo' triggered")
    local Player = QBCore.Functions.GetPlayerData()
    local citizenid = Player.citizenid
    TriggerServerEvent('banking:getBankInfo', citizenid)
    cb('ok')
end)

RegisterNetEvent('banking:receiveBankInfo')
AddEventHandler('banking:receiveBankInfo', function(accountInfo)
    print("Received bank info:", json.encode(accountInfo))
    SendNUIMessage({
        type = 'updateBankInfo',
        account_name = accountInfo and accountInfo.account_name or 'Unknown',
        account_balance = accountInfo and accountInfo.account_balance or 'N/A',
        account_type = accountInfo and accountInfo.account_type or 'N/A'
    })
end)