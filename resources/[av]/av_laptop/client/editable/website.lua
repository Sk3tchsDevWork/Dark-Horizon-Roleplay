local allWebsites = {
    ['192.168.l00.1'] = "https://av-scripts.tebex.io/",
    ['localhost'] = "https://blend-roleplay.gitbook.io/blend-roleplay",
    ['uwucafe'] = "https://uwucatcafe.com/",
    ['uwucafe.com'] = "https://uwucatcafe.com/",
}

RegisterNUICallback("website", function(data,cb)
    local website = allWebsites and allWebsites[data] or false
    if not website then
        TriggerEvent('av_laptop:notificationUI', Lang['browser_title'], Lang['not_found'], "error")
    end
    cb(website)
end)