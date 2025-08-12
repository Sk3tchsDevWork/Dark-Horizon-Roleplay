Notify = function(message, type, timeout)
    local ntype,cooldown = type,timeout
    if not cooldown then cooldown = 3000 end
    if not ntype then ntype = 'success' end
    local title = "[BBS Bodycam]"
    local translatedMessage = message
    if Config.Notify == "codem" then
        TriggerEvent('codem-notification:Create', translatedMessage, "bminfo", title, cooldown)
    elseif Config.Notify == "esx" then
        ESX.ShowNotification(translatedMessage)
    elseif Config.Notify == "qb" then
        QBCore.Functions.Notify({ text = translatedMessage, caption = title }, ntype, cooldown)
    elseif Config.Notify == "okok" then
        exports['okokNotify']:Alert(title, translatedMessage, cooldown, ntype)
    elseif Config.Notify == 'wasabi' then
        exports.wasabi_notify:notify(title, translatedMessage, cooldown, ntype)
    elseif Config.Notify == 't-notify' then
        exports['t-notify']:Alert({ style = ntype, message = translatedMessage, duration = cooldown, })
    elseif Config.Notify == 'r_notify' then
        exports.r_notify:notify({
            title = title,
            content = translatedMessage,
            type = ntype,
            icon = "fas fa-check",
            duration =
                cooldown,
            position = 'top-right',
            sound = false
        })
    elseif Config.Notify == 'pNotify' then
        exports['pNotify']:SendNotification({
            text = translatedMessage,
            type = ntype,
            timeout = cooldown,
            layout =
            'centerRight'
        })
    elseif Config.Notify == 'mythic' then
        exports['mythic_notify']:SendAlert('inform', translatedMessage, cooldown)
    elseif Config.Notify == "ox_lib" or lib then
        lib.notify({
            title = title,
            description = translatedMessage,
            type = ntype
        })
    end
end
