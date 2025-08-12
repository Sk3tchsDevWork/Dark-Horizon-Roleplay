Config = {}

Config.UseTarget = true                    -- Select beetween qb-menu or qb-target. You can configure or change both systems in /client/functions.lua or /client/target.lua
Config.EnableSoundcloud = false             -- In our previous versions of the script, the Soundcloud platform for playing music was available. Unfortunately, it did not support the new TV volume change system, so it was withdrawn. You can restore it here, but it will not support volume change
Config.SaveInHouses = false                 -- Set to true if u are using housing like loaf_housing, or others simillar. We do not recommend this if you are using Routing Bucket-based housing. That is, several people have an apartment in one place, but they can't see each other
Config.SaveOutdoor = true                   -- Set to false if you dont want to save Tvs outside

Config.SetOwnershipOfTV = false                                 -- When we set this value to true, only the person who placed the TV will be able to collect it
Config.noOwnerNotifcation = "You are not the owner of this TV"  -- If Config.SetOwnershipOfTV = true, then this notification will show up if someone else will try to collect the TV

Config.NotSavingInHouseString = "Tvs inside apartments or houses cannot be saved. We dont delete your item, but you have to place tv again after server restart."
Config.HintNotification = "Press ~INPUT_CONTEXT~ to manage TV"      -- If you're not using target, this HintNotification will appear.

Config.Props = {                            -- Here you can add more Tv's object, but dont forget to also create the "Config.TvRendering" for new tv's
    ["smalltv"] = "prop_tv_03",
    ["mediumtv"] = "prop_tv_flat_02",
    ["bigtv"] = "prop_tv_flat_michael",
}

Config.TvRendering = {
    ["smalltv"] = {
        renderDistance = 25.0,
        offest = {-0.345, -0.1075, 0.214},
        scaleX = 0.03,
        scaleY = 0.029,
    },
    ["mediumtv"] = {
        renderDistance = 25.0,
        offest = {-0.54, -0.014, 0.55},
        scaleX = 0.0445,
        scaleY = 0.0445,
    },
    ["bigtv"] = {
        renderDistance = 25.0,
        offest = {-0.7, -0.06, 0.44},
        scaleX = 0.0585,
        scaleY = 0.0585,
    }
}

if IsDuplicityVersion() then
    function getFramework()
        return exports['qb-core']:GetCoreObject()
    end
end