Config = Config or {}
Config.UsingPhone = false
Config.PhoneItems = {
    ['phone'] = true,
}

CreateThread(function()
    if GetResourceState("qb-phone") == "started" then
        Config.UsingPhone = "qb-phone"
        return
    end
    if GetResourceState("qs-smartphone-pro") == "started" then
        Config.UsingPhone = "qs-smartphone-pro"
        if IsDuplicityVersion() then
            Config.PhoneItems = exports['qs-smartphone-pro']:getPhoneNames()
        end
        return
    end
    if GetResourceState("lb-phone") == "started" then
        Config.UsingPhone = "lb-phone"
    end
end)