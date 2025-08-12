if not Config.DispatchCompatibility then
    return
end

local directions = {
    { "N", "North" },
    { "NE", "North-East" },
    { "E", "East" },
    { "SE", "South-East" },
    { "S", "South" },
    { "SW", "South-West" },
    { "W", "West" },
    { "NW", "North-West" },
}

---@param heading number
---@return [string, string]
local function GetDirection(heading)
    local yaw = math.floor(360.0 - ((heading + 360.0) % 360.0) + 0.5)
    local direction = math.floor((yaw + 22.5) / 45.0) % 8 + 1

    return directions[direction]
end

AddCompatibilityExport("cd_dispatch", "GetPlayerInfo", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerStreetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    local playerStreetName = GetStreetNameFromHashKey(playerStreetHash)
    local zone = GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z)
    local zoneName = GetLabelText(zone)
    local playerStreet = playerStreetName .. ", " .. zoneName
    local isMale = GetEntityModel(playerPed) == `mp_m_freemode_01`

    local info = {
        ped = PlayerPedId(),
        coords = playerCoords,
        street_1 = playerStreetName,
        street_2 = zoneName,
        street = playerStreet,
        sex = isMale and "Male" or "Female",
    }

    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle and DoesEntityExist(vehicle) then
        local vehicleModel = GetEntityModel(vehicle)
        local color = GetVehicleModColor_1(vehicle)
        local heading = GetEntityHeading(vehicle)
        local mph = GetEntitySpeed(vehicle) * 2.236936

        info.vehicle = vehicle
        info.vehicle_label = GetVehicleLabel(vehicleModel)
        info.vehicle_colour = GetVehicleColor(color).label
        info.vehicle_plate = GetVehicleNumberPlateText(vehicle)
        info.heading  = GetDirection(heading)[2]
        info.speed = math.floor(mph + 0.5) .. "MPH"
    end

    return info
end)

AddCompatibilityExport("ps-dispatch", "CustomAlert", function(dispatch)
    TriggerServerEvent("ps-dispatch:server:notify", dispatch)
end)

local psDispatches = {
    "VehicleTheft",
    "Shooting",
    "Hunting",
    "VehicleShooting",
    "SpeedingVehicle",
    "Fight",
    "PrisonBreak",
    "StoreRobbery",
    "FleecaBankRobbery",
    "PaletoBankRobbery",
    "PacificBankRobbery",
    "VangelicoRobbery",
    "HouseRobbery",
    "YachtHeist",
    "DrugSale",
    "SuspiciousActivity",
    "CarJacking",
    "InjuriedPerson",
    "DeceasedPerson",
    "OfficerDown",
    "OfficerBackup",
    "OfficerInDistress",
    "EmsDown",
    "Explosion",
    "ArtGalleryRobbery",
    "HumaneRobbery",
    "TrainRobbery",
    "VanRobbery",
    "UndergroundRobbery",
    "DrugBoatRobbery",
    "UnionRobbery",
    "CarBoosting",
    "SignRobbery",
}

for i = 1, #psDispatches do
    local dispatch = psDispatches[i]

    AddCompatibilityExport("ps-dispatch", dispatch, function()
        TriggerServerEvent("ps-dispatch:server:notify", {
            recipientList = { "police" },
            priority = 2,
            code = "",
            message = dispatch,
            coords = GetEntityCoords(PlayerPedId()),
            alertTime = 120
        })
    end)
end
