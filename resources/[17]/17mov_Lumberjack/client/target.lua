local targetSystem

if Config.Framework == "QBCore" then
    targetSystem = "qb-target"
else
    targetSystem = "qtarget"
end

if GetResourceState("ox_target") ~= "missing" then
    targetSystem = "qtarget"    -- OX_Target have a backward compability to qtarget
end

function SpawnPeds()
    local model = `a_m_m_bevhills_02`
    RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(50)
	end

    SpawnedPed = CreatePed(0, model, Config.Locations.DutyToggle.Coords[1].x, Config.Locations.DutyToggle.Coords[1].y, Config.Locations.DutyToggle.Coords[1].z - 1.0, 66.74, false, true)
    DecorSetBool(SpawnedPed, "entityIsNeeded", true)

    FreezeEntityPosition(SpawnedPed, true)
    SetBlockingOfNonTemporaryEvents(SpawnedPed, true)
    SetEntityInvincible(SpawnedPed, true)
    exports[targetSystem]:AddTargetEntity(SpawnedPed, {
        options = {
            {
                event = "multiplayerLumberjack:OpenMainMenu",
                icon = "fa-solid fa-handshake-simple",
                label = "Start Job",
                -- job = "RequiredJob",
                canInteract = function(entity)
                    return #(GetEntityCoords(PlayerPedId()) - vec3(Config.Locations.DutyToggle.Coords[1].x, Config.Locations.DutyToggle.Coords[1].y, Config.Locations.DutyToggle.Coords[1].z)) < 5.0
                end
            },
        },
        distance = 2.5
    })

    if not Config.EnableVehicleLegacyMode then return end

    local model2 = `a_m_m_rurmeth_01`
    RequestModel(model2)
	while not HasModelLoaded(model2) do
		Wait(50)
	end

    local rentForkliftPed = CreatePed(0, model2, Config.Locations.rentForklift.Coords[1].x, Config.Locations.rentForklift.Coords[1].y, Config.Locations.rentForklift.Coords[1].z - 1.0, 182.1, false, true)
    DecorSetBool(rentForkliftPed, "entityIsNeeded", true)

    FreezeEntityPosition(rentForkliftPed, true)
    SetBlockingOfNonTemporaryEvents(rentForkliftPed, true)
    SetEntityInvincible(rentForkliftPed, true)
    exports[targetSystem]:AddTargetEntity(rentForkliftPed, {
        options = {
            {
                event = "muliplayerLumberjack:OpenForkliftMenu",
                icon = "fa-solid fa-handshake-simple",
                label = "Rent Forklift",
                -- job = "RequiredJob",
                canInteract = function(entity)
                    return OnDuty and #(GetEntityCoords(PlayerPedId()) - vec3(Config.Locations.rentForklift.Coords[1].x, Config.Locations.rentForklift.Coords[1].y, Config.Locations.rentForklift.Coords[1].z)) < 5.0
                end
            },
        },
        distance = 2.5
    })

    local model3 = `a_m_m_salton_02`
    RequestModel(model3)
	while not HasModelLoaded(model3) do
		Wait(50)
	end

    local truckPed = CreatePed(0, model3, Config.Locations.WithdrawTruck.Coords[1].x, Config.Locations.WithdrawTruck.Coords[1].y, Config.Locations.WithdrawTruck.Coords[1].z - 1.0, 69.96, false, true)
    DecorSetBool(truckPed, "entityIsNeeded", true)

    FreezeEntityPosition(truckPed, true)
    SetBlockingOfNonTemporaryEvents(truckPed, true)
    SetEntityInvincible(truckPed, true)
    exports[targetSystem]:AddTargetEntity(truckPed, {
        options = {
            {
                event = "muliplayerLumberjack:OpenTruckMenu",
                icon = "fa-solid fa-handshake-simple",
                label = "Rent Truck",
                -- job = "RequiredJob",
                canInteract = function(entity)
                    return OnDuty and #(GetEntityCoords(PlayerPedId()) - vec3(Config.Locations.WithdrawTruck.Coords[1].x, Config.Locations.WithdrawTruck.Coords[1].y, Config.Locations.WithdrawTruck.Coords[1].z)) < 5.0
                end
            },
        },
        distance = 2.5
    })
end

RegisterNetEvent("multiplayerLumberjack:OpenMainMenu", function()
    OpenDutyMenu()
end)

RegisterNetEvent("muliplayerLumberjack:OpenForkliftMenu", function()
    OpenPanel("rentForklift")
end)

RegisterNetEvent("muliplayerLumberjack:OpenTruckMenu", function()
    OpenPanel("rentTruck")
end)

function DeleteTreeFromTarget(entity)
    if GetResourceState("ox_target") == "started" then
        exports.ox_target:removeEntity(NetworkGetNetworkIdFromEntity(entity), entity)
    else
        exports[targetSystem]:RemoveTargetEntity(entity)
    end
end

function AddTreeToTarget(entity, array)
    exports[targetSystem]:AddTargetEntity(entity, {
        options = {
            {
                icon = "fa-solid fa-tree",
                label = "Cut down tree",
                -- job = "RequiredJob",
                action = function()
                    CutDownTree(array)
                end,
            },
        },
        distance = 1.5
    })
end