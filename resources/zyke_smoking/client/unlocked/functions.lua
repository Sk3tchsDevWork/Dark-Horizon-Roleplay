function GetAmount()
    return Cache?.itemData?.amount or 0
end

-- Vape-only
function GetBattery()
    return Cache?.itemData?.battery or 0
end

-- Bong-only
function GetWater()
    return Cache?.itemData?.water or 0
end

exports("GetAmount", GetAmount)
exports("GetBattery", GetBattery)
exports("GetWater", GetWater)

---@return CigaretteData | CigaretteData | BongData | VapeData | nil
exports("GetItemData", function()
    return Cache.itemData
end)

-- Because of the changes to environment when dealing with routing buckets, the client can no longer access the prop
-- The prop removal is handled by the "SetObjectNetId" event, where it removes the prop if it does exist already
function EnsureSmokeableProp()
    if (not Cache.currentItem) then return end

    local item = GetItemSettings(Cache.currentItem)
    if (not item) then return end

    local propName = item.prop

    -- Deletes prop if possible, otherwise server handles it
    if (Cache.props.main and DoesEntityExist(Cache.props.main)) then
        DeleteEntity(Cache.props.main)
    end

    Cache.props.main = CreateObject(propName, 0.0, 0.0, 0.0, true, true, true)

    TriggerServerEvent("zyke_smoking:SetObjectNetId", ObjToNet(Cache.props.main))
    EnsurePropPositions()
end

function ResetWalkStyle()
    local ply = PlayerPedId()
    local isMale = IsPedMale(ply)
    local walkStyle = isMale and "move_m@multiplayer" or "move_f@multiplayer"

    SetPedMovementClipset(ply, walkStyle, 1.0)
end

---@param slot integer?
---@param item string
function CreateLighterProp(slot, item)
    RemoveLighterProp()

    local defaultLighter = Config.Settings.lighter.item[1]
    local lighter = Config.LighterProps[item] or Config.LighterProps[defaultLighter]
    if (not lighter) then return end
    if (not lighter[Cache.itemPlacement] or not lighter[Cache.itemPlacement][Cache.itemType]) then return end

    local bone = lighter[Cache.itemPlacement]?[Cache.itemType]?.bone
    local offset = lighter[Cache.itemPlacement]?[Cache.itemType]?.offset
    local rotation = lighter[Cache.itemPlacement]?[Cache.itemType]?.rotation
    if (not bone or not offset or not rotation) then return end

    if (not Z.loadModel(lighter.model)) then return end

    Cache.props.secondary = CreateObject(lighter.model, 0.0, 0.0, 0.0, true, true, false)

    local ply = PlayerPedId()
    local boneIdx = GetPedBoneIndex(ply, bone)
    AttachEntityToEntity(Cache.props.secondary, ply, boneIdx, offset.x, offset.y, offset.z, rotation.x, rotation.y, rotation.z, true, true, false, true, 1, true)
end

function RemoveLighterProp()
    if (Cache.props.secondary and DoesEntityExist(Cache.props.secondary)) then
        DeleteEntity(Cache.props.secondary)
    end
end

---@return boolean
function IsHigh()
    return Cache.effects.isActive
end

exports("IsHigh", IsHigh)

---@return boolean
function HasWalkEffect()
    return IsHigh() and Cache.effects.effects[1].movement ~= nil
end

exports("HasWalkEffect", HasWalkEffect)

function HasScreenEffect()
    return IsHigh() and Cache.effects.effects[1].screen ~= nil
end

exports("HasScreenEffect", HasScreenEffect)

local lastLighterCheck = GetGameTimer()
---@return Success, FailReason?
function LightCigarette()
    local ply = PlayerPedId()

    if (GetGameTimer() - lastLighterCheck < 1000) then return false end
    lastLighterCheck = GetGameTimer()

    local slot, item = Z.callback.await("zyke_smoking:HasLighter")
    if (not slot) then return false, "noLighter" end

    local duration = Config.Settings.lighter.particle.duration

    if (Cache.itemPlacement == "hand") then
        local dict, anim = "misscarsteal2peeing", "peeing_loop"
        if (not Z.loadDict(dict)) then return false end

        CreateLighterProp(slot, item)

        _TaskPlayAnim(ply, dict, anim, 2.0, 2.0, -1, 51, 0, false, false, false) -- 2000 dur
        Wait(1000)

        local count = CreateLighterFx(slot, item)
        Wait(duration * count)

        local res = Z.callback.await("zyke_smoking:LightCigarette", slot)
        if (not res) then return res.reason end

        StopAnimTask(PlayerPedId(), dict, anim, 1.0)
    elseif (Cache.itemPlacement == "mouth") then
        local dict, anim = "amb@world_human_smoking@male@male_a@enter", "enter"
        if (not Z.loadDict(dict)) then return false end

        CreateLighterProp(slot, item)

        _TaskPlayAnim(ply, dict, anim, 2.0, 2.0, -1, 51, 0, false, false, false) -- 5500 dur
        while (not IsEntityPlayingAnim(ply, dict, anim, 3)) do Wait(1) end

        TriggerServerEvent("zyke_smoking:SetAnimTime", dict, anim, 0.2)

        Wait(3500)

        local count = CreateLighterFx(slot, item)
        Wait((duration * count) + 500) -- Remove this extra 500?

        local res = Z.callback.await("zyke_smoking:LightCigarette", slot)
        if (not res) then return res.reason end

        StopAnimTask(PlayerPedId(), dict, anim, 1.0)

        Wait(1500)
    end

    CreateThread(function()
        Wait(300)
        RemoveLighterProp()
    end)

    Cache.itemData.hasLit = true

    return true
end

---@param slot integer | nil @If not provided, will use current item
function RemoveVapeCartridge(slot)
    local success, failReason = Z.callback.await("zyke_smoking:RemoveVapeCartridge", slot)
    if (not success) then
        Z.notify(failReason)
    end
end

exports("RemoveVapeCartridge", RemoveVapeCartridge)

RegisterCommand("remove_cartridge", function()
    RemoveVapeCartridge()
end, false)