local tablet = false
local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local tabletAnim = "base"
local tabletProp = `prop_cs_tablet`
local tabletBone = 60309
local tabletOffset = vector3(0.03, 0.002, -0.0)
local tabletRot = vector3(10.0, 160.0, 0.0)

function ToggleTablet(toggle)
    if toggle and not tablet then
        tablet = true
        CreateThread(function()
            RequestAnimDict(tabletDict)
            while not HasAnimDictLoaded(tabletDict) do
                Wait(150)
            end
            RequestModel(tabletProp)
            while not HasModelLoaded(tabletProp) do
                Wait(150)
            end
            local playerPed = PlayerPedId()
            local tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)
            local tabletBoneIndex = GetPedBoneIndex(playerPed, tabletBone)
            SetCurrentPedWeapon(playerPed, `weapon_unarmed`, true)
            AttachEntityToEntity(tabletObj, playerPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z,
                tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
            SetModelAsNoLongerNeeded(tabletProp)
            while tablet do
                Wait(100)
                playerPed = PlayerPedId()

                if not IsEntityPlayingAnim(playerPed, tabletDict, tabletAnim, 3) then
                    TaskPlayAnim(playerPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                end
            end
            ClearPedSecondaryTask(playerPed)
            Wait(450)
            DetachEntity(tabletObj, true, false)
            DeleteEntity(tabletObj)
        end)
    elseif not toggle and tablet then
        tablet = false
    end
end

function openLaptop() -- Triggered when player opens laptop // just in case u want to trigger something (?)

end

function closeLaptop() -- Triggered when player closes laptop // just in case u want to trigger something (?)
    
end
