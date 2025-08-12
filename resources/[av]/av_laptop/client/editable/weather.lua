local weatherScript = ''

CreateThread(function()
    if GetResourceState('av_weather') == 'started' then
        weatherScript = 'av_weather'
        return
    end
    if GetResourceState('qb-weathersync') == 'started' then
        weatherScript = 'qb-weathersync'
        return
    end
    if GetResourceState('vSync') == 'started' then
        weatherScript = 'vSync'
        return
    end
    if GetResourceState('cd_easytime') == 'started' then
        weatherScript = 'cd_easytime'
        return
    end
end)

exports('getWeatherScript', function()
    return weatherScript
end)