RegisterNetEvent("tablet:police:openStash", function(stashId)
    if GetResourceState("ox_inventory") == "started" then
        exports.ox_inventory:openInventory("stash", stashId)
    end

    ToggleOpen(false)
end)
