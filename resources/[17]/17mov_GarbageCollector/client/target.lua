local targetSystem

if Config.Framework == "QBCore" then
    targetSystem = "qb-target"
else
    targetSystem = "qtarget"
end

if GetResourceState("ox_target") ~= "missing" then
    targetSystem = "qtarget"    -- OX_Target have a backward compability to qtarget
end

function SpawnStartingPed()
    local model = Config.TargetPedOptions.model
    Functions.LoadModel(model)
    SpawnedPed = CreatePed(0, model, Config.TargetPedOptions.coords.x, Config.TargetPedOptions.coords.y, Config.TargetPedOptions.coords.z - 1.0, 1.13, false, true)
    SetEntityHeading(SpawnedPed, Config.TargetPedOptions.heading)
    Functions.SpawnedObjects[tostring(SpawnedPed)] = true
    FreezeEntityPosition(SpawnedPed, true)
    SetBlockingOfNonTemporaryEvents(SpawnedPed, true)
    SetEntityInvincible(SpawnedPed, true)
    exports[targetSystem]:AddTargetEntity(SpawnedPed, {
        options = {
            {
                event = "multiplayerGarbage:OpenMainMenu",
                icon = "fa-solid fa-handshake-simple",
                label = _L("Job.Target.StartJob"),
                -- job = "RequiredJob",
                canInteract = function(entity)
                    return #(GetEntityCoords(PlayerPedId()) - vec3(Config.TargetPedOptions.coords.x, Config.TargetPedOptions.coords.y, Config.TargetPedOptions.coords.z)) < 5.0
                end
            },
        },
        distance = 2.5
    })
end

RegisterNetEvent("multiplayerGarbage:OpenMainMenu", function()
    OpenDutyMenu()
end)

function AddDumpstersToTarget(dumpstersModels)
    exports[targetSystem]:AddTargetModel(dumpstersModels, {
        options = {
            {
                event = "multiplayerGarbage:searchDumpster",
                icon = "fa-solid fa-trash-can-arrow-up",
                label = _L("Job.Gameplay.SearchDumpster"),
                canInteract = function()
                    return OnDuty and not Functions.IsInAnim
                end,
            },
        },
        distance = 2
    })
end

function AddModelsToTarget(models)
    exports[targetSystem]:AddTargetModel(models, {
        options = {
            {
                event = "multiplayerGarbage:collectBag",
                icon = "fa-solid fa-trash-can-arrow-up",
                label = _L("Job.Gameplay.Pick"),
                canInteract = function()
                    return OnDuty
                end,
            },
        },
        distance = 2
    })
end

function AddJobVehicleToTargetSystem(vehicle)
    exports[targetSystem]:AddTargetEntity(vehicle, {
        options = {
            {
                event = "multiplayerGarbage:PutIn",
                icon = "fa-solid fa-trash-can",
                label = _L("Job.Gameplay.Throw"),
            },
        },
        distance = 2
    })
end

function DeleteEntityFromTarget(entity)
    exports[targetSystem]:RemoveTargetEntity(entity)
end