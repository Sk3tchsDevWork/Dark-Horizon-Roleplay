RegisterNUICallback('getMissions', function(data,cb)
    local res = lib.callback.await('av_gangs:getMissions', false)
    cb(res)
end)

RegisterNUICallback('startMission', function(data,cb)
    if data and not data['started'] then
        if data['isClient'] then
            TriggerEvent(data['event'],data)
        else
            TriggerServerEvent(data['event'], data)
        end
    end
    cb('ok')
end)