SetTimeout(500, function()
    if not Config.Item.Require or not CreateUsableItem then
        return
    end

    CreateUsableItem(Config.Item.Name, function(source)
        TriggerClientEvent("tablet:toggleOpen", source, true)
    end)
end)
