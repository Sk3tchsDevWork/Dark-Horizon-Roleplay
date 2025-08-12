local tabletModel = Config.TabletModel or `imp_prop_impexp_tablet`

local dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local anim = "base"
local animFlag = 1 | 8 | 16 | 32 | 1048576

local playerPed = 0
local hidden = false
local animationsEnabled = true
local tabletEntity
local animationTick

function GetTabletObject()
    return tabletEntity
end

local function DeleteTabletObject()
    if Config.ServerSideSpawn then
        TriggerServerEvent("tablet:deleteTabletObject")
    else
        DeleteEntity(tabletEntity)
        TriggerServerEvent("tablet:setTabletObject")
    end

    tabletEntity = nil
end

local function HandleAnimations()
    if not TabletOpen or not animationsEnabled then
        if not animationTick then
            return
        end

        DeleteTabletObject()
        ClearPedTasks(PlayerPedId())
        RemoveAnimDict(dict)
        SetModelAsNoLongerNeeded(tabletModel)

        animationTick = ClearInterval(animationTick)

        return
    end

    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        return
    end

    local playingAnim = IsEntityPlayingAnim(playerPed, dict, anim, 1)
    local inAnyVehicle = IsPedInAnyVehicle(playerPed, true)

    if inAnyVehicle and not hidden then
        hidden = true
        SetEntityVisible(tabletEntity, false, false)
    elseif not inAnyVehicle and hidden then
        hidden = false
        SetEntityVisible(tabletEntity, true, false)
    end

    if inAnyVehicle and playingAnim then
        StopAnimTask(playerPed, dict, anim, -1000.0)
    elseif not inAnyVehicle and not playingAnim and not IsPedRagdoll(playerPed) then
        TaskPlayAnim(playerPed, dict, anim, 8.0, -4.0, -1, animFlag, 0, false, false, false)
    end
end

local function CreateTabletObject()
    if tabletEntity then
        return debugprint("Tablet object already exists")
    elseif not LoadModel(tabletModel) then
        return infoprint("warning", "Failed to load the tablet model")
    end

    local visibleTimer = GetGameTimer() + 650
    local boneIndex = GetPedBoneIndex(playerPed, 28422)
    local tabletOffset = Config.TabletOffset or vector3(0.05, -0.005, -0.04)
    local tabletRotation = Config.TabletRotation or vector3(0.0, 0.0, 0.0)

    if Config.ServerSideSpawn then
        local netId = AwaitCallback("spawnTablet")

        if not netId then
            debugprint("Failed to create tablet object (no net id)")
            return
        end

        tabletEntity = WaitForNetworkId(netId)

        if not tabletEntity or not TakeControlOfEntity(tabletEntity) then
            debugprint("Failed to get/take control of tablet object (timed out)")
            TriggerServerEvent("tablet:failedControl")
            return
        end
    else
        local spawnCoords = GetEntityCoords(playerPed) - vector3(0.0, 0.0, 5.0)
        tabletEntity = CreateObject(tabletModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, true, true, false)

        TriggerServerEvent("tablet:setTabletObject", NetworkGetNetworkIdFromEntity(tabletEntity))
    end

    SetEntityVisible(tabletEntity, false, false)
    AttachEntityToEntity(tabletEntity, playerPed, boneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z, tabletRotation.x, tabletRotation.y, tabletRotation.z, true, true, false, true, 1, true)

    while visibleTimer > GetGameTimer() do
        Wait(0)
    end

    SetEntityVisible(tabletEntity, true, false)

    if not TabletOpen then
        DeleteTabletObject()
    end
end

function UpdateAnimations()
    if not TabletOpen or not animationsEnabled or animationTick then
        return
    end

    playerPed = PlayerPedId()
    hidden = false
    animationTick = SetInterval(HandleAnimations, 500)

    Citizen.CreateThreadNow(CreateTabletObject)
end

---@param enabled boolean
function ToggleAnimations(enabled)
    animationsEnabled = enabled == true
    UpdateAnimations()
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() and tabletEntity then
        DeleteObject(tabletEntity)
        ClearPedTasks(PlayerPedId())
    end
end)
