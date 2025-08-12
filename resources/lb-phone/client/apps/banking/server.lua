local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('banking:getBankInfo')
AddEventHandler('banking:getBankInfo', function(citizenid)
    local src = source
    local accountInfo = exports['qb-banking']:GetAccount(citizenid)
    TriggerClientEvent('banking:receiveBankInfo', src, accountInfo)
end)