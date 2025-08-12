local QBCore = exports['qb-core']:GetCoreObject()

local function UpdateRadioItemDescription(channel)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if not PlayerData or not PlayerData.items then return end

    for _, item in pairs(PlayerData.items) do
        if item.name == Config.RadioItem then
            local newDescription = channel and (Lang:t('connected_to_channel')..channel.." MHz") or Lang:t('noconnected_to_channel')
            TriggerServerEvent("sbs-radio:updateItemDescription", item.slot, newDescription)
            break
        end
    end
end

RegisterNetEvent('sbs-radio:client:JoinRadioChannel1', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 1
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end

    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel2', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 2
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel3', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 3
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel4', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 4
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel5', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 5
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel6', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 6
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel7', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 7
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel8', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 8
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel9', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 9
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:JoinRadioChannel10', function()
    QBCore.Functions.TriggerCallback("sbs-radio:hasRadioItem", function(hasRadio)
        if not hasRadio then
            QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
            return
        end

        local channel = 10
        local job = QBCore.Functions.GetPlayerData().job.name
        local onDuty = QBCore.Functions.GetPlayerData().job.onduty

        if Config.RestrictedChannels[channel] and (not Config.RestrictedChannels[channel][job] or not onDuty) then
            QBCore.Functions.Notify(Lang:t('restricted_channel_error'), "error")
            return
        end

        RadioChannel = channel
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(channel)

        UpdateRadioItemDescription(channel)

        TriggerServerEvent("sb-radio:logRadioAction", "join", channel)

        if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. ' MHz'}), 'success')
    else
        QBCore.Functions.Notify(Lang:t('joined_to_radio', {channel = channel .. '.00 MHz'}), 'success')
    end
    end)
end)

RegisterNetEvent('sbs-radio:client:LeaveRadioChannel', function()
    if not QBCore.Functions.HasItem(Config.RadioItem, 1) then
        QBCore.Functions.Notify(Lang:t('radio_needed'), "error")
        return
    end

    if RadioChannel == 0 then
        QBCore.Functions.Notify(Lang:t('not_on_radio'), "error")
        return
    end

    if RadioChannel and RadioChannel ~= 0 then
        TriggerServerEvent("sb-radio:logRadioAction", "leave", RadioChannel)
    end

    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    
    RadioChannel = 0
    onRadio = false

    UpdateRadioItemDescription(nil)

    QBCore.Functions.Notify(Lang:t('log_leave'), "error")
end)
