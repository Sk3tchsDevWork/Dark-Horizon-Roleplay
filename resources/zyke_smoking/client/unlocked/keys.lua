while (not Translations) do Wait(0) end

Z.registerKey("smoking:hit", Config.Settings.keys["hit"], T("controls:hit:description"), function()
    local res, reason = TakeHit()
    if (reason and reason ~= "noActiveItem") then Z.notify(reason) end

    Z.debug("TakeHit", res, reason)
end)

Z.registerKey("smoking:switchPlacement", Config.Settings.keys["switchPlacement"], T("controls:switchPlacement:description"), function()
    SwitchItemPlacement()
end)

Z.registerKey("smoking:cancel", Config.Settings.keys["cancel"], T("controls:cancel:description"), function()
    StopUsingItem()
end)

Z.registerKey("smoking:transferItem", Config.Settings.keys["transferItem"], T("controls:transferItem:description"), function()
    TransferItem()
end)