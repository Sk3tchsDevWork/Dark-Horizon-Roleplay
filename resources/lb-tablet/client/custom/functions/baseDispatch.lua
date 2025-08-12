if not Config.BaseDispatch or not Config.BaseDispatch.Enabled then
    return
end

local weaponGroupLookup = {
    [-755518101] = "DIGISCANNER",
    [-37788308] = "FIREEXTINGUISHER",
    [1175761940] = "HACKINGDEVICE",
    [-1569042529] = "HEAVY",
    [-728555052] = "MELEE",
    [-535475913] = "METALDETECTOR",
    [1159398588] = "MG",
    [-801780072] = "NIGHTVISION",
    [431593103] = "PARACHUTE",
    [1595662460] = "PETROLCAN",
    [416676503] = "PISTOL",
    [970310034] = "RIFLE",
    [860033945] = "SHOTGUN",
    [-957766203] = "SMG",
    [-1212426201] = "SNIPER",
    [690389602] = "STUNGUN",
    [1548507267] = "THROWN",
    [75159441] = "TRANQILIZER",
    [-1609580060] = "UNARMED"
}

local femaleVoices = {
    "a_f_m_bevhills_02_white_full_02",
    "a_f_m_bodybuild_01_black_mini_01",
    "a_f_m_bodybuild_01_white_mini_01",
    "a_f_m_business_02_white_mini_01",
    "a_f_m_eastsa_01_latino_mini_01",
    "a_f_m_fatwhite_01_white_mini_01",
    "a_f_m_salton_01_white_full_01",
    "a_f_m_salton_01_white_full_02",
    "a_f_m_salton_01_white_full_03",
    "a_f_m_salton_01_white_mini_02",
    "a_f_m_salton_01_white_mini_03",
    "a_f_m_tourist_01_white_mini_01",
    "a_f_o_genstreet_01_white_mini_01",
    "a_f_o_indian_01_indian_mini_01",
    "a_f_o_salton_01_white_mini_01",
    "a_f_y_bevhills_01_white_mini_01",
    "a_f_y_bevhills_04_white_mini_01",
    "a_f_y_business_03_chinese_mini_01",
    "a_f_y_business_04_black_mini_01",
    "a_f_y_eastsa_03_latino_full_01",
    "a_f_y_golfer_01_white_mini_01",
    "a_f_y_hipster_01_white_mini_01",
    "a_f_y_indian_01_indian_mini_01",
    "a_f_y_skater_01_white_mini_01",
    "a_f_y_tourist_02_white_mini_01",
    "a_f_y_vinewood_01_white_mini_01",
    "a_f_y_vinewood_02_white_mini_01",
    "a_f_y_vinewood_03_chinese_mini_01",
    "s_f_m_fembarber_black_mini_01",
    "s_f_m_genericcheapworker_01_latino_mini_01",
    "s_f_m_genericcheapworker_01_latino_mini_02",
    "s_f_m_genericcheapworker_01_latino_mini_03",
    "s_f_m_ponsen_01_black_01",
    "s_f_m_shop_high_white_mini_01",
    "s_f_y_airhostess_01_black_full_01",
    "s_f_y_airhostess_01_black_full_02",
    "s_f_y_airhostess_01_white_full_01",
    "s_f_y_airhostess_01_white_full_02",
    "s_f_y_baywatch_01_black_full_01",
    "s_f_y_baywatch_01_black_full_02",
    "s_f_y_baywatch_01_white_full_01",
    "s_f_y_baywatch_01_white_full_02",
    "s_f_y_genericcheapworker_01_black_mini_01",
    "s_f_y_genericcheapworker_01_black_mini_02",
    "s_f_y_genericcheapworker_01_latino_mini_01",
    "s_f_y_genericcheapworker_01_latino_mini_02",
    "s_f_y_genericcheapworker_01_latino_mini_03",
    "s_f_y_genericcheapworker_01_latino_mini_04",
    "s_f_y_genericcheapworker_01_white_mini_01",
    "s_f_y_genericcheapworker_01_white_mini_02",
    "s_f_y_hooker_01_white_full_01",
    "s_f_y_hooker_01_white_full_02",
    "s_f_y_hooker_01_white_full_03",
    "s_f_y_hooker_02_white_full_01",
    "s_f_y_hooker_02_white_full_02",
    "s_f_y_hooker_02_white_full_03",
    "s_f_y_hooker_03_black_full_01",
    "s_f_y_hooker_03_black_full_03",
    "s_f_y_pecker_01_white_01",
    "s_f_y_shop_low_white_mini_01",
    "s_f_y_shop_mid_white_mini_01",
}

local maleVoices = {
    "a_m_m_beach_01_white_mini_02",
    "a_m_m_beach_02_white_mini_01",
    "a_m_m_eastsa_02_latino_mini_01",
    "a_m_m_golfer_01_white_mini_01",
    "a_m_m_hasjew_01_white_mini_01",
    "a_m_m_hillbilly_01_white_mini_01",
    "a_m_m_hillbilly_01_white_mini_02",
    "a_m_m_hillbilly_01_white_mini_03",
    "a_m_m_hillbilly_02_white_mini_01",
    "a_m_m_hillbilly_02_white_mini_02",
    "a_m_m_hillbilly_02_white_mini_03",
    "a_m_m_indian_01_indian_mini_01",
    "a_m_m_ktown_01_korean_mini_01",
    "a_m_m_skater_01_white_mini_01",
    "a_m_m_tranvest_01_white_mini_01",
    "a_m_o_beach_01_white_mini_01",
    "a_m_o_genstreet_01_white_mini_01",
    "a_m_o_salton_01_white_mini_01",
    "a_m_y_beach_01_white_mini_01",
    "a_m_y_busicas_01_white_mini_01",
    "a_m_y_business_01_white_mini_02",
    "a_m_y_business_03_white_mini_01",
    "a_m_y_epsilon_02_white_mini_01",
    "a_m_y_gay_02_white_mini_01",
    "a_m_y_genstreet_01_white_mini_01",
    "a_m_y_golfer_01_white_mini_01",
    "a_m_y_hasjew_01_white_mini_01",
    "a_m_y_hippy_01_white_mini_01",
    "a_m_y_hipster_03_white_mini_01",
    "a_m_y_ktown_01_korean_mini_01",
    "a_m_y_musclbeac_01_white_mini_01",
    "a_m_y_salton_01_white_mini_01",
    "a_m_y_stwhi_01_white_mini_01",
    "a_m_y_stwhi_02_white_mini_01",
    "a_m_y_sunbathe_01_white_mini_01",
    "a_m_y_vinewood_02_white_mini_01",
    "a_m_y_vinewood_03_white_mini_01",
    "a_m_y_vinewood_04_white_mini_01",
    "mp_m_shopkeep_01_chinese_mini_01",
    "mp_m_shopkeep_01_latino_mini_01",
    "mp_m_shopkeep_01_pakistani_mini_01",
    "s_m_m_ammucountry_01_white_01",
    "s_m_m_ammucountry_white_mini_01",
    "s_m_m_autoshop_01_white_01",
    "s_m_m_genericcheapworker_01_latino_mini_01",
    "s_m_m_genericcheapworker_01_latino_mini_02",
    "s_m_m_genericcheapworker_01_latino_mini_03",
    "s_m_m_genericcheapworker_01_latino_mini_04",
    "s_m_m_genericmechanic_01_black_mini_01",
    "s_m_m_genericmechanic_01_black_mini_02",
    "s_m_m_genericpostworker_01_black_mini_01",
    "s_m_m_genericpostworker_01_black_mini_02",
    "s_m_m_genericpostworker_01_white_mini_01",
    "s_m_m_genericpostworker_01_white_mini_02",
    "s_m_m_hairdresser_01_black_mini_01",
    "s_m_m_hairdress_01_black_01",
    "s_m_m_pilot_01_black_full_01",
    "s_m_m_pilot_01_black_full_02",
    "s_m_m_pilot_01_white_full_01",
    "s_m_m_pilot_01_white_full_02",
    "s_m_y_airworker_black_full_01",
    "s_m_y_airworker_black_full_02",
    "s_m_y_airworker_latino_full_01",
    "s_m_y_airworker_latino_full_02",
    "s_m_y_ammucity_01_white_01",
    "s_m_y_ammucity_01_white_mini_01",
    "s_m_y_baywatch_01_black_full_01",
    "s_m_y_baywatch_01_black_full_02",
    "s_m_y_baywatch_01_white_full_01",
    "s_m_y_baywatch_01_white_full_02",
    "s_m_y_genericcheapworker_01_black_mini_01",
    "s_m_y_genericcheapworker_01_black_mini_02",
    "s_m_y_genericcheapworker_01_white_mini_01",
    "s_m_y_genericworker_01_black_mini_01",
    "s_m_y_genericworker_01_black_mini_02",
    "s_m_y_genericworker_01_latino_mini_01",
    "s_m_y_genericworker_01_latino_mini_02",
    "s_m_y_genericworker_01_white_mini_01",
    "s_m_y_genericworker_01_white_mini_02",
    "s_m_y_shop_mask_white_mini_01",
    "u_m_y_tattoo_01_white_mini_01",
}

local reportedVehicles = {}

local cooldowns = {}

---@param action string
local function IsDispatchOnCooldown(action)
    local actionData = Config.BaseDispatch.Actions[action]
    local cooldown = (actionData and actionData.cooldown or 5) * 1000
    local currentTime = GetGameTimer()

    if cooldowns[action] then
        local lastTime = cooldowns[action]

        if currentTime - lastTime < cooldown then
            return true
        end
    end

    cooldowns[action] = currentTime

    return false
end

---@param coords? vector3 | vector4
---@param customCheck? fun(ped: number, coords: vector3, distance: number): boolean | nil
---@return number? ped
---@return { ped: number, distance: number, coords: vector3 }[] nearbyPeds
local function GetNearbyPedForDispatch(coords, customCheck)
    local peds = GetGamePool("CPed")
    local nearbyPeds = {}

    if not coords then
        coords = GetEntityCoords(PlayerPedId())
    end

    for i = 1, #peds do
        local ped = peds[i]
        local populationType = GetEntityPopulationType(ped)
        local pedCoords = GetEntityCoords(ped)
        local distance = #(coords - pedCoords)
        local pedType = GetPedType(ped)

        if
            (populationType ~= 4 and populationType ~= 5)
            or IsPedDeadOrDying(ped, true)
            or (pedType ~= 4 and pedType ~= 5)
            or (distance > Config.BaseDispatch.MaxDistance)
            or IsEntityAMissionEntity(ped)
            or IsEntityPlayingAnim(ped, "cellphone@", "cellphone_call_in", 3)
            or IsEntityPlayingAnim(ped, "cellphone@", "cellphone_call_out", 3)
            or IsEntityPlayingAnim(ped, "cellphone@in_car@ds", "cellphone_call_in", 3)
            or IsEntityPlayingAnim(ped, "cellphone@in_car@ds", "cellphone_call_out", 3)
            or (customCheck and not customCheck(ped, pedCoords, distance))
        then
            goto continue
        end

        nearbyPeds[#nearbyPeds+1] = {
            ped = ped,
            distance = distance,
            coords = pedCoords
        }

        ::continue::
    end

    table.sort(nearbyPeds, function(a, b)
        return a.distance < b.distance
    end)

    if not Config.BaseDispatch.RequireLos then
        if not nearbyPeds[1] then
            return nil, nearbyPeds
        end

        return nearbyPeds[1].ped, nearbyPeds
    end

    for i = 1, #nearbyPeds do
        local nearbyPed = nearbyPeds[i]
        local ped = nearbyPed.ped
        local shapeTest = StartExpensiveSynchronousShapeTestLosProbe(
            nearbyPed.coords.x, nearbyPed.coords.y, nearbyPed.coords.z,
            coords.x, coords.y, coords.z,
            17, ped, 4
        )

        local _, hit = GetShapeTestResult(shapeTest)

        if hit == 0 then
            return ped, nearbyPeds
        end
    end

    return nil, nearbyPeds
end

local function GetAttachedEntities(ped)
    local attachedEntities = {}
    local entities = GetGamePool("CObject")

    for i = 1, #entities do
        local entity = entities[i]

        if DoesEntityExist(entity) and IsEntityAttachedToEntity(entity, ped) then
            attachedEntities[#attachedEntities + 1] = entity
        end
    end

    return attachedEntities
end

---@param netId number
---@return boolean
local function CallPoliceScene(netId)
    local ped = NetToPed(netId)

    if not DoesEntityExist(ped) then
        return false
    end

    local attachedEntities = GetAttachedEntities(ped)

    for i = 1, #attachedEntities do
        local entity = attachedEntities[i]

        DeleteEntity(entity)
    end

    local coords = GetEntityCoords(ped)
    local inCar = IsPedInAnyVehicle(ped, false) and "in_car@ds" or ""
    local dict = LoadDict("cellphone@" .. inCar)

    if Config.BaseDispatch.Debug then
        Citizen.CreateThreadNow(function()
            local timer = GetGameTimer() + 15000

            while timer > GetGameTimer() do
                local playerCoords = GetEntityCoords(PlayerPedId())
                local pedCoords = GetEntityCoords(ped)

                DrawLine(
                    playerCoords.x, playerCoords.y, playerCoords.z,
                    pedCoords.x, pedCoords.y, pedCoords.z,
                    255, 0, 0, 255
                )

                Wait(0)
            end
        end)
    end

    SetEntityAsMissionEntity(ped, true, false)
    SetPedCanPlayAmbientAnims(ped, false)
    SetPedCanPlayAmbientBaseAnims(ped, false)

    local phone

    if Config.ServerSideSpawn then
        local phoneNetId = AwaitCallback("baseDispatch:createPhoneObject")

        WaitForNetworkId(phoneNetId)
        TakeControlOfEntity(phoneNetId)

        phone = NetworkGetEntityFromNetworkId(phoneNetId)
    else
        local phoneModel = `prop_amb_phone`

        LoadModel(phoneModel)

        phone = CreateObject(phoneModel, coords.x, coords.y, coords.z - 3.0, true, false, false)

        SetModelAsNoLongerNeeded(phoneModel)
    end

    if phone and DoesEntityExist(phone) then
        SetEntityVisible(phone, false, false)
        SetEntityCollision(phone, false, false)
        AttachEntityToEntity(phone, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    end

    TaskPlayAnim(ped, dict, "cellphone_call_in", 8.0, 0.0, -1, 2 | 8 | 16 | 32 | 1048576, 0.0, false, false, false)

    Wait(500)

    if phone and DoesEntityExist(phone) then
        SetEntityVisible(phone, true, false)
    end

    Wait(1500)

    if not DoesContextExistForThisPed(ped, "PHONE_CALL_COPS", false) then
        debugprint("Ped doesn't have voiceline, playing random")

        if IsPedMale(ped) then
            PlayPedAmbientSpeechWithVoiceNative(ped, "PHONE_CALL_COPS", maleVoices[math.random(#maleVoices)], "SPEECH_PARAMS_FORCE_NORMAL", false)
        else
            PlayPedAmbientSpeechWithVoiceNative(ped, "PHONE_CALL_COPS", femaleVoices[math.random(#femaleVoices)], "SPEECH_PARAMS_FORCE_NORMAL", false)
        end
    else
        PlayPedAmbientSpeechNative(ped, "PHONE_CALL_COPS", "SPEECH_PARAMS_FORCE_NORMAL")
    end

    Wait(1500)

    local died = IsPedDeadOrDying(ped, false)

    debugprint("Ped dead:", died)

    Citizen.CreateThreadNow(function()
        if not died then
            Wait(4000)
            TaskPlayAnim(ped, dict, "cellphone_call_out", 1000.0, -8.0, -1, 8 | 16 | 32 | 65536 | 1048576, 0.0, false, false, false)
            Wait(500)
            StopAnimTask(ped, dict, "cellphone_call_in", 1000.0)
        end

        RemoveAnimDict(dict)
        SetEntityAsMissionEntity(ped, false, false)
        SetPedCanPlayAmbientAnims(ped, true)
        SetPedCanPlayAmbientBaseAnims(ped, true)

        if Config.ServerSideSpawn then
            TriggerServerEvent("lb-tablet:baseDispatch:deletePhoneObject")
        else
            if phone and DoesEntityExist(phone) then
                DeleteEntity(phone)
            end
        end
    end)

    return not died
end

RegisterClientCallback("baseDispatch:callPolice", CallPoliceScene)

---@param ped number
---@return boolean success # Returns false if the ped dies before the call is started
local function AttemptToCallPolice(ped)
    if not Config.BaseDispatch.CallPolice then
        return true
    end

    local owner = NetworkGetEntityOwner(ped)
    local netId = PedToNet(ped)

    if owner ~= -1 and owner ~= PlayerId() then
        local success = AwaitCallback("baseDispatch:callPolice", netId) --[[@as boolean]]

        return success
    end

    return CallPoliceScene(netId)
end

---@return boolean
local function ShouldCreateDispatch(action)
    if Config.BaseDispatch.IgnorePolice and IsPolice() then
        debugprint("Not creating dispatch as player is police.")
        return false
    end

    if action and IsDispatchOnCooldown(action) then
        return false
    end

    if action and not Config.BaseDispatch.Actions[action] then
        debugprint("Action not found in BaseDispatch.Actions, skipping.", action)
        return false
    end

    if Config.BaseDispatch.Chance < 100 and math.random(100) > Config.BaseDispatch.Chance then
        debugprint("Random chance check failed, not calling police.")
        return false
    end

    if action and Config.BaseDispatch.Actions[action].chance and math.random(100) > Config.BaseDispatch.Actions[action].chance then
        debugprint("Action specific chance check failed, not calling police.", action)
        return false
    end

    if Config.BaseDispatch.RequireWitness then
        local ped = GetNearbyPedForDispatch(nil, function(ped, coords, distance)
            return distance > 5.0
        end)

        if not ped then
            debugprint("No nearby ped found to call police.")
            return false
        end

        if not AttemptToCallPolice(ped) then
            debugprint("Failed to call police.")
            return false
        end
    end

    return true
end

---@param text string
local function ConvertToTitleCase(text)
    return text:gsub("(%a)([%w_']*)", function(a, b)
        return a:upper() .. b:lower()
    end)
end

---@param weapon number
local function GetWeaponGroup(weapon)
    return weaponGroupLookup[GetWeapontypeGroup(weapon)] or "UNKNOWN"
end

---@param coords vector3
RegisterClientCallback("getLocationName", function(coords)
    return GetLocationName(coords)
end)

---@param coords vector3
---@param action string
---@param title string
---@param description string
---@param code string
---@param fields? { icon: string, label: string, value?: string }[]
local function CreateBaseDispatch(coords, action, title, description, code, fields)
    if not Config.BaseDispatch.Actions[action] then
        debugprint("CreateBaseDispatch: Action not found in BaseDispatch.Actions:", action)
        return
    end

    local location = GetLocationName(coords)

    TriggerServerEvent("lb-tablet:addBaseDispatch", action, {
        title = title,
        description = description,
        code = code,
        location = {
            label = location,
            coords = coords.xy
        },
        fields = fields,
    })
end

---@param vehicle number
---@return { model?: string, plate: string, color: string, class: string, manufacturer: string }
local function GetVehicleData(vehicle)
    local model = GetEntityModel(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local primaryColor = GetVehicleColours(vehicle)
    local color = GetVehicleColor(primaryColor).label
    local label = GetVehicleLabel(model) --[[@as string?]]
    local class = GetVehicleClass(vehicle)
    local manufacturer = GetMakeNameFromVehicleModel(model)

    if manufacturer == "CARNOTFOUND" or manufacturer == "NULL" then
        manufacturer = ""
    end

    if manufacturer then
        manufacturer = ConvertToTitleCase(manufacturer)
    end

    if model == "Unknown" then
        label = nil
    end

    return {
        model = label,
        plate = plate,
        color = color,
        class = L("BACKEND.BASE_DISPATCH.VEHICLE_CLASSES." .. class),
        manufacturer = manufacturer
    }
end

-- Car thefts
AddEventHandler("CEventPedJackingMyVehicle", function(_, perpetrator)
    if perpetrator ~= PlayerPedId() then
        return
    end

    local vehicle = GetVehiclePedIsUsing(perpetrator)

    if vehicle == 0 or not DoesEntityExist(vehicle) then
        return debugprint("No vehicle found for the perpetrator.")
    end

    if reportedVehicles[vehicle] then
        return
    end

    reportedVehicles[vehicle] = true

    if not ShouldCreateDispatch("CarJacking") then
        return
    end

    local gender = GetPedGender(perpetrator)
    local vehicleData = GetVehicleData(vehicle)

    local args = {
        gender = gender,
        gender_lower = gender:lower(),

        color = vehicleData.color,
        color_lower = vehicleData.color:lower(),

        class = vehicleData.class,

        manufacturer = vehicleData.manufacturer,
        manufacturer_lower = vehicleData.manufacturer:lower(),

        model = vehicleData.model,
        model_lower = vehicleData.model:lower(),

        plate = vehicleData.plate
    }

    CreateBaseDispatch(
        GetEntityCoords(PlayerPedId()),
        "CarJacking",
        L("BACKEND.BASE_DISPATCH.VEHICLE_JACKING.TITLE", args),
        L("BACKEND.BASE_DISPATCH.VEHICLE_JACKING.DESCRIPTION", args),
        L("BACKEND.BASE_DISPATCH.VEHICLE_JACKING.CODE"),
        {
            {
                icon = "fa-solid fa-wrench",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.BODY_TYPE"),
                value = vehicleData.class:gsub("^%l", string.upper),
            },
            {
                icon = "fa-solid fa-circle-info",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.MANUFACTURER"),
                value = vehicleData.manufacturer or "Unknown",
            },
            {
                icon = "fa-solid fa-car",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.MODEL"),
                value = vehicleData.model or "Unknown",
            },
            {
                icon = "fa-solid fa-palette",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.COLOR"),
                value = vehicleData.color,
            },
            {
                icon = "fa-solid fa-rectangle-list",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.PLATE"),
                value = vehicleData.plate,
            }
        }
    )
end)

AddEventHandler("CEventShockingSeenCarStolen", function(_, perpetrator)
    if perpetrator ~= PlayerPedId() then
        return
    end

    local vehicle = GetVehiclePedIsUsing(perpetrator)

    if vehicle == 0 or not DoesEntityExist(vehicle) then
        return
    end

    if IsVehiclePreviouslyOwnedByPlayer(vehicle) then
        return
    end

    if reportedVehicles[vehicle] then
        return
    end

    reportedVehicles[vehicle] = true

    if not ShouldCreateDispatch("VehicleTheft") then
        return
    end

    local gender = GetPedGender(perpetrator)
    local vehicleData = GetVehicleData(vehicle)

    local args = {
        gender = gender,
        gender_lower = gender:lower(),

        color = vehicleData.color,
        color_lower = vehicleData.color:lower(),

        class = vehicleData.class,

        manufacturer = vehicleData.manufacturer,
        manufacturer_lower = vehicleData.manufacturer:lower(),

        model = vehicleData.model,
        model_lower = vehicleData.model:lower(),

        plate = vehicleData.plate
    }

    CreateBaseDispatch(
        GetEntityCoords(PlayerPedId()),
        "VehicleTheft",
        L("BACKEND.BASE_DISPATCH.VEHICLE_THEFT.TITLE", args),
        L("BACKEND.BASE_DISPATCH.VEHICLE_THEFT.DESCRIPTION", args),
        L("BACKEND.BASE_DISPATCH.VEHICLE_THEFT.CODE"),
        {
            {
                icon = "fa-solid fa-wrench",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.BODY_TYPE"),
                value = vehicleData.class:gsub("^%l", string.upper),
            },
            {
                icon = "fa-solid fa-circle-info",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.MANUFACTURER"),
                value = vehicleData.manufacturer or "Unknown",
            },
            {
                icon = "fa-solid fa-car",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.MODEL"),
                value = vehicleData.model or "Unknown",
            },
            {
                icon = "fa-solid fa-palette",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.COLOR"),
                value = vehicleData.color,
            },
            {
                icon = "fa-solid fa-rectangle-list",
                label = L("BACKEND.BASE_DISPATCH.VEHICLE_DATA.PLATE"),
                value = vehicleData.plate,
            }
        }
    )
end)

-- Shooting
AddEventHandler("CEventGunShot", function(_, perpetrator)
    if perpetrator ~= PlayerPedId() then
        return
    end

    local weapon = GetSelectedPedWeapon(perpetrator)
    local weaponGroup = GetWeaponGroup(weapon)
    local weaponGroupName = L("BACKEND.BASE_DISPATCH.WEAPON_TYPES." .. weaponGroup)
    local gender = GetPedGender(perpetrator)
    local coords = GetEntityCoords(perpetrator)
    local location = GetLocationName(coords)

    if not ShouldCreateDispatch("Gunshot") then
        return
    end

    if table.contains(Config.BaseDispatch.Actions.Gunshot.ignoredWeaponGroups, weaponGroup) then
        return
    end

    local args = {
        gender = gender,
        gender_lower = gender:lower(),
        weapon_type = weaponGroupName,
        weapon_type_lower = weaponGroupName:lower(),
        location = location,
    }

    CreateBaseDispatch(
        coords,
        "Gunshot",
        L("BACKEND.BASE_DISPATCH.GUNSHOT.TITLE", args),
        L("BACKEND.BASE_DISPATCH.GUNSHOT.DESCRIPTION", args),
        L("BACKEND.BASE_DISPATCH.GUNSHOT.CODE")
    )
end)

-- Armed
---@type { weapon: number, cooldown: number }?
local warnedArmed = nil

local function CheckIfArmed()
    local currentTime = GetGameTimer()

    if warnedArmed  then
        if currentTime < warnedArmed.cooldown then
            return
        else
            warnedArmed = nil
        end
    end

    local playerPed = PlayerPedId()
    local equippedWeapon = GetSelectedPedWeapon(playerPed)
    local weaponGroup = GetWeaponGroup(equippedWeapon)

    if
        IsPedInAnyVehicle(playerPed, false)
        or (warnedArmed and warnedArmed.weapon == equippedWeapon)
        or table.contains(Config.BaseDispatch.Actions.Armed.ignoredWeaponGroups, weaponGroup)
    then
        return
    end

    local weaponGroupName = L("BACKEND.BASE_DISPATCH.WEAPON_TYPES." .. weaponGroup)
    local coords = GetEntityCoords(playerPed)
    local location = GetLocationName(coords)
    local gender = GetPedGender(playerPed)

    if not ShouldCreateDispatch() then
        return
    end

    local args = {
        weapon_type = weaponGroupName,
        weapon_type_lower = weaponGroupName:lower(),
        location = location,
        gender = gender,
        gender_lower = gender:lower(),
    }

    CreateBaseDispatch(
        coords,
        "Armed",
        L("BACKEND.BASE_DISPATCH.ARMED.TITLE", args),
        L("BACKEND.BASE_DISPATCH.ARMED.DESCRIPTION", args),
        L("BACKEND.BASE_DISPATCH.ARMED.CODE")
    )

    warnedArmed = {
        weapon = equippedWeapon,
        cooldown = currentTime + Config.BaseDispatch.Actions.Armed.cooldown * 1000
    }
end

if Config.BaseDispatch.Actions.Armed then
    SetInterval(CheckIfArmed, 1000)
end
