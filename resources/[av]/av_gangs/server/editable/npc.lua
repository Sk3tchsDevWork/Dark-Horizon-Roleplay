RegisterServerEvent('av_gangs:getMoney', function(netId, gang) -- triggered when u rob a gang npc
    dbug("robNPC(netId, gang)", netId, gang)
    local src = source
    local player = GetPlayerPed(src)
    local coords = GetEntityCoords(player)
    local npc = NetworkGetEntityFromNetworkId(netId)
    if npc and DoesEntityExist(npc) then
        local state = Entity(npc).state
        if not state['robbed'] then
            state['robbed'] = true
        else
            dbug("Already robbed, cancel process.")
            return
        end
    else
        dbug("Entity doesn't exist, cancel process.")
        return
    end
    local members = getMembers(gang)
    if members and next(members) then
        for _, v in pairs(members) do
            local Player = exports['av_laptop']:getSourceByIdentifier(v['identifier'])
            if Player then 
                TriggerClientEvent('av_gangs:alertMember', Player, coords, Lang['robbery_alert'])
            end
        end
    end
    local total = math.random(Config.RobMoney['min'], Config.RobMoney['max'])
    exports['av_laptop']:addMoney(src,Config.RobAccount,total)
    if Config.GangLoseXP and Config.GangLoseXP > 0 then
        removeXP(gang,Config.GangLoseXP)
    end
    if Config.GangWinsXP and Config.GangWinsXP > 0 then
        local myGang = getGang(src)
        if myGang and myGang['name'] then
            addXP(myGang['name'],Config.GangWinsXP)
        end
    end
end)