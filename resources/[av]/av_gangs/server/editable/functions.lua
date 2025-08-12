-- This functions are here just in case u need it, I don't provide any support on how to trigger X event/export to other resources that aren't mine, including qb-core/gangs
-- The qb gangs code is just an example, if isn't working anymore bc qb-core got updated is on u to make the needed changes

function newGang(name, label, boss) -- Triggered when a new gang is created
	-- gang name, gang label, boss playerID?
	
end

function removeGang(name) -- Triggered when a gang gets deleted
	-- gang name

end


function AddMember(src,identifier,isboss,gang) -- triggered when someone is added to a gang
    -- local target = Core.Functions.GetPlayer(src)
    -- target.Functions.SetGang(gang, 0)
end

function RemoveMember(identifier,gang) -- triggered when someone is removed from a gang
    -- local Player = Core.Functions.GetPlayerByCitizenId(identifier)
    -- if Player then -- Online
    --     Player.Functions.SetGang("none", '0')
    -- else
    --     local target = MySQL.query.await('SELECT * FROM players WHERE citizenid = ? LIMIT 1', {identifier})
    --     if target[1] ~= nil then
	-- 		Player = target[1]
	-- 		Player.gang = json.decode(Player.gang)
	-- 		local gang = {}
	-- 		gang.name = "none"
	-- 		gang.label = "No Affiliation"
	-- 		gang.payment = 0
	-- 		gang.onduty = true
	-- 		gang.isboss = false
	-- 		gang.grade = {}
	-- 		gang.grade.name = nil
	-- 		gang.grade.level = 0
	-- 		MySQL.update('UPDATE players SET gang = ? WHERE citizenid = ?', {json.encode(gang), identifier})
	-- 	end
    -- end
end

function SprayApplied(source,gang,coords) -- triggered when someone applies a graffiti

end

function SprayRemoved(source,gang) -- triggered when someone removes a graffiti

end

function CanJoinGang(source, gang) -- triggered right before sending an invite to player, return false to cancel the invite
	local canJoin = true
	-- Add your own check here and change canJoin to false/true

	if not canJoin then
		TriggerClientEvent('av_laptop:notification', source, Lang['app_title'], "You can't join the gang", "error") -- Modify the notification
	end
	return canJoin
end