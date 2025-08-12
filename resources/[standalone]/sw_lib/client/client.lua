local QBCore = exports['qb-core']:GetCoreObject()

-- This handles the opening of a stash inventory. This will open the inventory for the player to view and interact with. The event will depend on which framework/inventory resource you use.
local function OpenStash(stashName, maxweight, slots)
    if Config.Inventory == 'qb' then
        TriggerServerEvent('sw_lib:server:openInventory', stashName, maxweight, slots)
    elseif Config.Inventory == 'ox' then
        TriggerServerEvent('sw_lib:server:openInventory', stashName, maxweight, slots)
        exports.ox_inventory:openInventory('stash', stashName)
    else
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashName, { maxweight = maxweight, slots = slots })
        TriggerEvent('inventory:client:SetCurrentStash', stashName)
    end
end
exports('OpenStash', OpenStash)

-- This handles the opening of the management/boss menu. This allows players with boss privileges to manage their businesses.
local function OpenManagement()
    if Config.Management == 'sw' then
        TriggerEvent('sw-management:client:accessManagementMenu')
    elseif Config.Management == 'qb' then
        TriggerEvent('qb-bossmenu:client:OpenMenu')
    elseif Config.Management == 'qbx' then
        exports.qbx_management:OpenBossMenu('job')
    end
end
exports('OpenManagement', OpenManagement)

-- This handles the cash register/till payments. This is optional, but will charge the player for a given payment amount.
local function ChargePlayer()
    if Config.Payments == 'none' then
        return
    elseif Config.Payments == 'jim' then
        TriggerEvent('jim-payments:client:Charge')
    end
end
exports('ChargePlayer', ChargePlayer)

-- This handles the triggering of player animations. If you are configuring this to handle a different animations menu, use the event that triggers an emote here.
local function StartEmote(emote)
    if Config.Animations == 'rpemotes' then
        TriggerEvent('animations:client:EmoteCommandStart', {emote})
    elseif Config.Animations == 'scully' then
        exports.scully_emotemenu:playEmoteByCommand(emote)
    else
        TriggerEvent('animations:client:EmoteCommandStart', {emote})
    end
end
exports('StartEmote', StartEmote)

-- Similar to the above, this handles the cancelling of player animations. If you are configuring this to handle a different animations menu, use the event that cancels an emote here.
local function CancelEmote()
    if Config.Animations == 'rpemotes' then
        exports['rpemotes']:EmoteCancel()
    elseif Config.Animations == 'scully' then
        exports.scully_emotemenu:cancelEmote()
    else
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
    end
end
exports('CancelEmote', CancelEmote)

-- This handles stating whether the player is in an active animation, or not. This may not be required for all animations menus.
local function SetPlayerInAnimation(bool)
    if Config.Animations == 'rpemotes' then
        exports['rpemotes']:IsPlayerInAnim(bool)
    elseif Config.Animations == 'scully' then
        return
    end
end
exports('SetPlayerInAnimation', SetPlayerInAnimation)

-- This handles the toggling of duty status. This is used to toggle the player's duty status, such as on/off duty.
local function ToggleDuty()
    if Config.ToggleDuty == 'qb' then
        TriggerServerEvent('QBCore:ToggleDuty')
    end
end
exports('ToggleDuty', ToggleDuty)

-- This handles the opening of the wardrobe. This allows players to change their outfits.
local function OpenClothing()
    if Config.Clothing == 'qb' then
        TriggerEvent('qb-clothing:client:openMenu')
    end
end
exports('OpenClothing', OpenClothing)

-- This handles the opening of the wardrobe. This allows players to change their outfits.
local function OpenWardrobe()
    if Config.Clothing == 'qb' then
        TriggerEvent('qb-clothing:client:openOutfitMenu')
    end
end
exports('OpenWardrobe', OpenWardrobe)

-- This handles changing the player's appearance to a specific outfit and/or look.
local function SetPlayerAppearance(data)
    if Config.Clothing == 'qb' then
        local gender = QBCore.Functions.GetPlayerData().charinfo.gender
        if gender == 0 then
            TriggerEvent('qb-clothing:client:loadOutfit', {
                outfitData = {
                    ['t-shirt'] = { item = data.male.shirt.item, texture = data.male.shirt.texture },
                    ['torso2'] = { item = data.male.jacket.item, texture = data.male.jacket.texture },
                    ['arms'] = { item = data.male.arms.item, texture = data.male.arms.texture },
                    ['pants'] = { item = data.male.pants.item, texture = data.male.pants.texture },
                    ['shoes'] = { item = data.male.shoes.item, texture = data.male.shoes.texture }
                }
            })
        else
            TriggerEvent('qb-clothing:client:loadOutfit', {
                outfitData = {
                    ['t-shirt'] = { item = data.female.shirt.item, texture = data.female.shirt.texture },
                    ['torso2'] = { item = data.female.jacket.item, texture = data.female.jacket.texture },
                    ['arms'] = { item = data.female.arms.item, texture = data.female.arms.texture },
                    ['pants'] = { item = data.female.pants.item, texture = data.female.pants.texture },
                    ['shoes'] = { item = data.female.shoes.item, texture = data.female.shoes.texture }
                }
            })
        end
    end
end
exports('SetPlayerAppearance', SetPlayerAppearance)

-- This handles the setting of vehicle fuel. This is required when spawning vehicles.
local function SetFuel(vehicle, amount)
    if Config.Fuel == 'cdn' then
        exports['cdn-fuel']:SetFuel(vehicle, amount)
    elseif Config.Fuel == 'Legacy' then
        exports['ps-fuel']:SetFuel(vehicle, amount)
    elseif Config.Fuel == 'ps' then
        exports['ps-fuel']:SetFuel(vehicle, amount)
    elseif Config.Fuel == 'ox' then
        Entity(vehicle).state.fuel = amount
    end
end
exports('SetFuel', SetFuel)

-- This handles the triggering of sound effects such as browsing wardrobes or sink hand-washing.
local function PlaySound(sound, volume)
    if Config.Sounds == 'interact' then
        TriggerServerEvent('InteractSound_SV:PlayOnSource', sound, volume)
    end
end
exports('PlaySound', PlaySound)

-- This handles checking whether a player has a specific item, and amount of it.
local function HasItem(item, amount)
    amount = amount or 1
    if Config.Inventory == 'ox' then
        return exports.ox_inventory:Search('count', item) >= amount
    elseif Config.Core == 'qb' then
        return QBCore.Functions.HasItem(item, amount)
    end
end
exports('HasItem', HasItem)

-- This handles checking the amount of a specific item the player has.
local function GetItemCount(item)
    if Config.Inventory == 'ox' then
        return exports.ox_inventory:Search('count', item)
    elseif Config.Core == 'qb' then
        local itemData = QBCore.Functions.HasItem(item)
        return itemData and itemData.amount or 0
    end
    return 0
end
exports('GetItemCount', GetItemCount)

-- This handles the spawning of vehicle models.
local function SpawnVehicle(args)
    if Config.Core == 'qb' then
        local p = promise.new()
        QBCore.Functions.SpawnVehicle(args.model, function(vehicle)
            if args.warp then TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1) end
            SetVehicleEngineOn(vehicle, true, true)
            SetVehicleNumberPlateText(vehicle, args.plate..tostring(math.random(1000, 9999)))
            if args.colour then SetVehicleColours(vehicle, args.colour[1], args.colour[2]) end
            exports.sw_lib:SetFuel(vehicle, args.fuel)
            SetEntityAsMissionEntity(vehicle, true, true)
            TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(vehicle))
            p:resolve(vehicle)
        end, args.location, true)
        return Citizen.Await(p)
    end
end
exports('SpawnVehicle', SpawnVehicle)

-- This handles the displaying of a notification message.
RegisterNetEvent('sw_lib:client:Notify', function(message, type)
    if Config.Notify == 'qb' then
        QBCore.Functions.Notify(message, type)
    elseif Config.Notify == 'ox' then
        lib.notify({
            title = message,
            type = type
        })
    elseif Config.Notify == 'fl' then
        if type == 'error' then type = 1
        elseif type == 'success' then type = 2
        elseif type == 'info' then type = 3 end
        exports['FL-Notify']:Notify('Notification', ' ', message, 5000, type, 3)
    end
end)

-- This handles the displaying of an item box. This is used to show the player when they have gained or lost an item.
RegisterNetEvent('sw_lib:client:ItemBox', function(item, type, amount)
	if Config.Inventory == 'qb' then
		TriggerEvent('ps-inventory:client:ItemBox', item, type, amount)
	else
		TriggerEvent('inventory:client:ItemBox', item, type, amount)
	end
end)

-- This handles the display of menu items. This will display a given menu image on screen to the player. By default, this is only set to use ps-ui (https://github.com/Project-Sloth/ps-ui).
RegisterNetEvent('sw_lib:client:displayImage', function(imageLink)
    if Config.MenuDisplay == 'ps-ui' then
        exports['ps-ui']:ShowImage(imageLink)
    end
end)

-- This handles the starting of a skillbar. This is used to show the player a skillbar to complete a task. If set to 'none', it will automatically complete the task without a minigame.
RegisterNetEvent('sw_lib:client:startSkillbar', function(args)
	if Config.Skillbar == 'none' then
		TriggerEvent(args.resource..':client:finishSkillbar', args, 1)
	elseif Config.Skillbar == 'ps-ui' then
		exports['ps-ui']:Circle(function(success)
			if success then
				TriggerEvent(args.resource..':client:finishSkillbar', args, 1)
			else
				TriggerEvent(args.resource..':client:finishSkillbar', args)
			end
		end, 4, 10) -- NumberOfCircles, MS
	elseif Config.Skillbar == 'ox' then
		local success = lib.skillCheck({'easy', 'easy', 'easy'}, {'w', 'a', 's', 'd'})
		if success then
			TriggerEvent(args.resource..':client:finishSkillbar', args, 1)
		else
			TriggerEvent(args.resource..':client:finishSkillbar', args)
		end
	elseif Config.Skillbar == 'qb' then
		local success = exports['qb-minigames']:Skillbar()
		if success then
			TriggerEvent(args.resource..':client:finishSkillbar', args, 1)
		else
			TriggerEvent(args.resource..':client:finishSkillbar', args)
		end
	end
end)

-- This handles the triggering of police dispatch alerts.
RegisterNetEvent('sw_lib:client:startDispatch', function(alert)
    if Config.Dispatch == 'ps' then
        if alert == 'GraveRobbery' then
            exports['ps-dispatch']:GraveRobbery()
        elseif alert == 'CoralRobbery' then
            exports['ps-dispatch']:CoralRobbery()
        elseif alert == 'ContainerRobbery' then
            exports['ps-dispatch']:ContainerRobbery()
        elseif alert == 'SuspiciousActivity' then
            exports['ps-dispatch']:SuspiciousActivity()
        elseif alert == 'Poaching' then
            exports['ps-dispatch']:Poaching()
        elseif alert == 'TerminalHack' then
            exports['ps-dispatch']:TerminalHack()
        elseif alert == 'TrainRobbery' then
            exports['ps-dispatch']:TrainRobbery()
        elseif alert == 'HumaneRobbery' then
            exports['ps-dispatch']:HumaneRobbery()
        elseif alert == 'Assassination' then
            exports['ps-dispatch']:Assassination()
        elseif alert == 'PanicButton' then
            exports['ps-dispatch']:PanicButton()
        end
    end
end)