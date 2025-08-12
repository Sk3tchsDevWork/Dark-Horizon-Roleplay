Z.callback.register("zyke_smoking:TakeHit", function(source, data)
    Z.debug(json.encode(Cache.active[source]))

    local active = Cache.active[source]
    if (not active) then return {status = false, reason = "notActive"} end

    local itemSettings = GetItemSettings(active.item)
    if (not itemSettings) then return {status = false, reason = "noItemSettings"} end

    local inhaleMultiplier = data.useMultiplier
    local baseAmount = 1.0
    local itemTypeMultiplier = Config.Settings.useMultiplier[active.type]
    local finalAmount = baseAmount * inhaleMultiplier * itemTypeMultiplier

    local currAmount = active.data.amount
    if (finalAmount > currAmount) then
        finalAmount = currAmount
    end

    active.data.amount = Z.numbers.round(active.data.amount - finalAmount, 3)

    if (active.type == "joint" or active.type == "cigar" or active.type == "cigarette") then
        if (active.data.amount <= 0.0) then
            StopUsingItem(source)
        end
    end

    local effectMultiplier = finalAmount
    -- Handle battery drain for vape
    if (active.type == "vape") then
        local toRemove = data.useMultiplier * Config.Settings.vapeExtras.batteryDrain

        active.data.battery = Z.numbers.round(active.data.battery - toRemove, 3)
        if (active.data.battery <= 0.0) then active.data.battery = 0.0 end
    elseif (active.type == "bong") then
        local toRemove = data.useMultiplier * Config.Settings.bongExtras.waterDrain

        active.data.water = Z.numbers.round(active.data.water - toRemove, 3)
        if (active.data.water <= 0.0) then active.data.water = 0.0 end
    end

    TriggerClientEvent("zyke_smoking:SyncItemData", source, active.data)

    CreateSmokeParticle(source, "exhale", effectMultiplier)

    -- If the benefits can be cancelled because of various reasons
    -- Such as inhaling too long on a vape
    -- Handle it here
    local shouldRunEffects = true
    if (data.canCancelBenefits) then
        if (active.type == "vape" and Config.Settings.cancelBenefitsOnMaxHit) then
            shouldRunEffects = false
        end

        -- If you can cancel, cough instead (held inhale too long)
        local gender = Z.getGender(source)
        PlaySound(source, gender == "male" and "m_cough" or "f_cough")
    else
        -- If you can't cancel the benefits
        PlaySound(source, "exhale")
    end

    local effects
    if (active.type == "joint" or active.type == "cigarette" or active.type == "cigar") then
        effects = itemSettings.effects
    elseif (active.type == "vape") then
        effects = Config.Settings.vapeExtras.items[active.data.item.name]?.effects
    elseif (active.type == "bong") then
        effects = Config.Settings.bongExtras.items[active.data.item.name]?.effects
    end

    if (effects) then
        local multiplier = (itemSettings?.effects?.multiplier or Config.Settings.effects.multiplier)

        if (effects.screenEffect) then
            local dur = multiplier * effectMultiplier
            AddToEffects(source, effects, dur)
        end

        if (UsingStatus) then
            if (effects.food) then
                exports["zyke_status"]:AutoToStatus(source, {"hunger"}, effects.food * (effectMultiplier / 100))
            end

            if (effects.water) then
                exports["zyke_status"]:AutoToStatus(source, {"thirst"}, effects.water * (effectMultiplier / 100))
            end

            if (effects.stress) then
                exports["zyke_status"]:AutoToStatus(source, {"stress"}, effects.stress * (effectMultiplier / 100))
            end
        end

        TriggerClientEvent("zyke_smoking:ApplyEffect", source, effectMultiplier, inhaleMultiplier)

        if (shouldRunEffects == true) then
            -- Handle server-sided effects
            if (effects.serverFunc) then
                local totalValue = finalAmount
                local flavorUsedName = GetFlavorName(active)

                effects.serverFunc(source, totalValue, flavorUsedName, active.data)
            end
        end
    end

    return {status = true}
end)

---@param activeData ActiveSmoking
function GetFlavorName(activeData)
    if (activeData.type == "joint" or activeData.type == "cigarette" or activeData.type == "cigar") then
        return activeData.item
    else
        return activeData.data.item.name
    end
end

---@return integer | boolean, string?
Z.callback.register("zyke_smoking:HasLighter", function(source)
    return HasLighter(source)
end)