local alreadyDead = false

function HandleDead()
    if alreadyDead then
        return
    end

    alreadyDead = true

    ToggleDisabled(true)

    if Config.HideDispatchWhenDead then
        ToggleDispatchVisible(false)
    end

    while IsPedDeadOrDying(PlayerPedId(), false) do
        Wait(500)
    end

    ToggleDisabled(false)

    if Config.HideDispatchWhenDead then
        ToggleDispatchVisible(true)
    end

    alreadyDead = false
end

AddEventHandler("CEventDeath", function(entities, entity, data)
    if entities[1] == PlayerPedId() then
        HandleDead()
    end
end)

AddEventHandler("CEventEntityDamaged", function()
    if IsPedDeadOrDying(PlayerPedId(), false) then
        HandleDead()
    end
end)
