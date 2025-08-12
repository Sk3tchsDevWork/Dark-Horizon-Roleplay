if GetResourceState('qb-core') == 'started' then
    local QBCore = exports['qb-core']:GetCoreObject()
    QBCore.Functions.CreateUseableItem('recycler', function(source)
        TriggerClientEvent('kevin-recyclers:client:placeObject', source)
    end)
elseif GetResourceState('qbx_core') == 'started' then
    exports.qbx_core:CreateUseableItem('recycler', function(source, item)
        TriggerClientEvent('kevin-recyclers:client:placeObject', source)
    end)
end