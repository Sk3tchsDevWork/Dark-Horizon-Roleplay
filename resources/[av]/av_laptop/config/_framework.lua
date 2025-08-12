Config = Config or {}
Config.Framework = nil -- Don't edit this

CreateThread(function()
    if GetResourceState("qbx_core") ~= "missing" then
        Config.Framework = "qbox"
        Core = true
        print([[^5If using qbox uncomment the qbox imports from fxmanifest.lua,
You can remove this print in config/_framework.lua line 8-9^7]])
        return
    end
    if GetResourceState("qb-core") ~= "missing" then
        Config.Framework = "qb"
        Core = exports['qb-core']:GetCoreObject()
        return
    end
    if GetResourceState("es_extended") ~= "missing" then
        Config.Framework = "esx"
        Core = exports['es_extended']:getSharedObject()
        return
    end
    print("^3[ERROR]^7 No Framework loaded...please verify config/_framework.lua")
    print("^3[ERROR]^7 No Framework loaded...please verify config/_framework.lua")
    print("^3[ERROR]^7 No Framework loaded...please verify config/_framework.lua")
end)