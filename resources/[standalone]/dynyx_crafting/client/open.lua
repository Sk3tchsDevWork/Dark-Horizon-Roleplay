local QBCore = nil
local ESX = nil

CreateThread(function()
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            TriggerEvent('dynyx_crafting:Loadtables')
        end)
    elseif GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
        RegisterNetEvent('esx:playerLoaded', function()
            TriggerEvent('dynyx_crafting:Loadtables')
        end)
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    Wait(100)
    TriggerEvent('dynyx_crafting:Loadtables')
end)

function Notify(Title, Desc, type)
    if Config.Notifications == "ox_lib" then
        lib.notify({
            title = Title,
            description = Desc,
            type = type,
            duration = 5000,
            position = "center-right"
        })
    elseif Config.Notifications == "qb-core" then
        QBCore.Functions.Notify({text = Title, caption = Desc}, 'type', 5000)
    else
        print("Invalid Config.Notifications")
    end
end

function progressBar(info)
    if Config.Progressbar == "ox_lib" then
        if info == "craft" then
            lib.progressBar({
                duration = 3500,
                label = Loc[Config.Lan]["PBCraft"],
                useWhileDead = false,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                    mouse = false,
                },
                anim = {
                    dict = "amb@world_human_welding@male@base",
                    clip = "base",
                    flags = 1,
                },
                prop = {
                    model = `prop_weld_torch`,
                    bone = 28422,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 0.0)
                },
            })
        elseif info == "pickup" then
            lib.progressBar({
                duration = 3500,
                label = Loc[Config.Lan]["PBPickup"],
                useWhileDead = false,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                    mouse = false,
                },
                anim = {
                    dict = "random@domestic",
                    clip = "pickup_low",
                    flags = 1,
                },
            })
        elseif info == "placeb" then
            lib.progressBar({
                duration = 3500,
                label = Loc[Config.Lan]["PBPlace"],
                useWhileDead = false,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                    mouse = false,
                },
                anim = {
                    dict = "mini@repair",
                    clip = "fixing_a_ped",
                    flags = 1,
                },
            })
        end
    elseif Config.Progressbar == "qb-core" then
        if info == "craft" then
            QBCore.Functions.Progressbar("crafting", Loc[Config.Lan]["PBCraft"], 3500, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            }, {
                animDict = "amb@world_human_welding@male@base",
                anim = "base",
                flags = 1
            }, {}, {}, function()
            end, function()
            end)
        elseif info == "pickup" then
            QBCore.Functions.Progressbar("pickup_bench", Loc[Config.Lan]["PBPickup"], 3500, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            }, {
                animDict = "random@domestic",
                anim = "pickup_low",
                flags = 1
            }, {}, {}, function()
            end, function()
            end)
        elseif info == "placeb" then
            QBCore.Functions.Progressbar("placing_bench", Loc[Config.Lan]["PBPlace"], 3500, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 1
            }, {}, {}, function()
            end, function()
            end)
        end
    else
        print("Invalid Config.Progressbar")
    end
end

function PlayerData()
    if QBCore then
        local playerData = QBCore.Functions.GetPlayerData()
        return {
            job = playerData.job.name,
            gang = playerData.gang.name,
            cid = playerData.citizenid
        }
    elseif ESX then
        local playerData = ESX.GetPlayerData()
        return {
            job = playerData.job.name,
            gang = playerData.gang and playerData.gang.name or nil,
            cid = playerData.identifier
        }
    end
    return nil
end

function Target(info, id, coords, rot, bench, preset, label, entityObj)
    if Config.Target == "ox_target" then
        if info == "add" then
            local regcoords = coords
            if not preset and coords then regcoords = json.decode(coords) end

            local options = {}
            local canInteract = nil

            if preset then
                local benchConfig = Config.PreSetTables[bench]
                if not benchConfig then return end

                local allowedGroups = benchConfig.Groups or {}
                local allowedCitizenIDs = benchConfig.CitizenID or {}

                canInteract = function(entity, distance, data)
                    if not next(allowedGroups) and not next(allowedCitizenIDs) then
                        return true
                    end

                    local player = PlayerData()
                    if not player then return false end

                    for _, group in pairs(allowedGroups) do
                        if player.job == group or player.gang == group then return true end
                    end

                    for _, cid in pairs(allowedCitizenIDs) do
                        if cid == player.cid then return true end
                    end

                    return false
                end
            end

            table.insert(options, {
                label = label,
                icon = 'fa-solid fa-circle',
                distance = 5.0,
                canInteract = canInteract,
                onSelect = function()
                    if preset then
                        MoveCameraToTable(coords, nil, preset)
                        OpenCraftingUI(bench, preset)
                    else
                        MoveCameraToTable(json.decode(coords), json.decode(rot), preset)
                        OpenCraftingUI(bench)
                    end
                end
            })

            if not preset then
                table.insert(options, {
                    label = Loc[Config.Lan]["PickUpTableTarget"],
                    icon = 'fa-solid fa-circle',
                    distance = 5.0,
                    onSelect = function()
                        progressBar("pickup")
                        TriggerServerEvent('dynyx_crafting:PickupTableServer', coords, bench)
                    end
                })
            end

            if entityObj then
                return exports.ox_target:addLocalEntity(entityObj, options)
            else
                return exports.ox_target:addSphereZone({
                    coords = vec3(regcoords.x, regcoords.y, regcoords.z + 0.5),
                    radius = 0.5,
                    debug = false,
                    options = options
                })
            end

        elseif info == "remove" then
            exports.ox_target:removeZone(id)
        end

    elseif Config.Target == "qb-target" then
        if info == "add" then
            local regcoords = coords
            if not preset and coords then regcoords = json.decode(coords) end

            local zone = "crafting_table_" .. math.random(1, 9999)
            local options = {}
            local canInteract = nil

            if preset then
                local benchConfig = Config.PreSetTables[bench]
                if not benchConfig then return end

                local allowedGroups = benchConfig.Groups or {}
                local allowedCitizenIDs = benchConfig.CitizenID or {}

                canInteract = function()
                    if not next(allowedGroups) and not next(allowedCitizenIDs) then
                        return true
                    end

                    local player = PlayerData()
                    if not player then return false end

                    for _, group in pairs(allowedGroups) do
                        if player.job == group or player.gang == group then return true end
                    end

                    for _, cid in pairs(allowedCitizenIDs) do
                        if cid == player.cid then return true end
                    end

                    return false
                end
            end

            table.insert(options, {
                icon = "fa-solid fa-circle",
                label = label,
                action = function()
                    if preset then
                        MoveCameraToTable(coords, nil, preset)
                        OpenCraftingUI(bench, preset)
                    else
                        MoveCameraToTable(json.decode(coords), json.decode(rot), preset)
                        OpenCraftingUI(bench)
                    end
                end,
                canInteract = preset and canInteract or nil
            })

            if not preset then
                table.insert(options, {
                    icon = "fa-solid fa-circle",
                    label = Loc[Config.Lan]["PickUpTableTarget"],
                    action = function()
                        progressBar("pickup")
                        TriggerServerEvent('dynyx_crafting:PickupTableServer', coords, bench)
                    end
                })
            end

            exports["qb-target"]:AddEntityZone(zone, entityObj, {

                name = zone,
                debugPoly = false,
            }, {
                options = options,
                distance = 2.5
            })

            return zone

        elseif info == "remove" then
            return exports["qb-target"]:RemoveZone(id)
        end
    else
        print("Invalid Config.Target")
    end
end

function GetPlayerMaterials()
    local materials = {}
    local configTable = {}

    for k, v in pairs(Config.PreSetTables or {}) do
        configTable[k] = v
    end
    
    for k, v in pairs(Config.PlaceableTables or {}) do
        configTable[k] = v
    end

    for _, benchData in pairs(configTable) do
        if benchData.Items then
            for _, itemData in pairs(benchData.Items) do
                if itemData.Material then
                    for materialName, _ in pairs(itemData.Material) do
                        materials[string.lower(materialName)] = 0
                    end
                end
            end
        end
    end

    if Config.Inventory == 'ox_inventory' then
        local materialNames = {}
        for name in pairs(materials) do
            table.insert(materialNames, name)
        end

        local inventoryCounts = exports.ox_inventory:Search('count', materialNames)
        if inventoryCounts then
            for name, count in pairs(inventoryCounts) do
                local key = string.lower(name)
                if materials[key] ~= nil then
                    materials[key] = count
                end
            end
        end

    elseif Config.Inventory == 'ps-inventory' or Config.Inventory == "ps-inventory" then
        local Player = QBCore.Functions.GetPlayerData()
        if Player and Player.items then
            for _, item in pairs(Player.items) do
                if item and item.name and materials[string.lower(item.name)] ~= nil then
                    materials[string.lower(item.name)] = item.amount
                end
            end
        end

    elseif Config.Inventory == 'qs-inventory' then
        local inventory = exports['qs-inventory']:getUserInventory()
        if inventory then
            for _, itemData in pairs(inventory) do
                if itemData and itemData.name and materials[string.lower(itemData.name)] ~= nil then
                    materials[string.lower(itemData.name)] = itemData.amount
                end
            end
        end
    else
        print("Invalid Config.Inventory")
        return {}
    end

    return materials
end

function HasBlueprint(itemData)
    if not itemData.UseBlueprint then
        return true
    end

    if not itemData.BlueprintItem then
        return true
    end

    local hasBlueprint = false

    if Config.Inventory == 'ox_inventory' then
        local count = exports.ox_inventory:Search('count', itemData.BlueprintItem)
        hasBlueprint = count and count > 0

    elseif Config.Inventory == 'ps-inventory' or Config.Inventory == 'ps-inventory' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayerData()

        if Player and Player.items then
            for _, item in pairs(Player.items) do
                if item.name == itemData.BlueprintItem and item.amount > 0 then
                    hasBlueprint = true
                    break
                end
            end
        end

    elseif Config.Inventory == 'qs-inventory' then
        local inventory = exports['qs-inventory']:getUserInventory()

        if inventory then
            for _, item in pairs(inventory) do
                if item.name == itemData.BlueprintItem and item.amount > 0 then
                    hasBlueprint = true
                    break
                end
            end
        end
    end

    if itemData.ShowOnList == false then
        return hasBlueprint
    end

    return true
end

function HasBlueprintItem(itemData)
    if not itemData.UseBlueprint then
        return true
    end

    if not itemData.BlueprintItem then
        return true
    end

    if Config.Inventory == 'ox_inventory' then
        local count = exports.ox_inventory:Search('count', itemData.BlueprintItem)
        return count and count > 0

    elseif Config.Inventory == 'ps-inventory' or Config.Inventory == 'ps-inventory' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayerData()

        if Player and Player.items then
            for _, item in pairs(Player.items) do
                if item.name == itemData.BlueprintItem and item.amount > 0 then
                    return true
                end
            end
        end

    elseif Config.Inventory == 'qs-inventory' then
        local inventory = exports['qs-inventory']:getUserInventory()

        if inventory then
            for _, item in pairs(inventory) do
                if item.name == itemData.BlueprintItem and item.amount > 0 then
                    return true
                end
            end
        end
    end

    return false
end
