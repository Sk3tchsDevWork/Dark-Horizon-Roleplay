---@alias RawOfficer [number, string, string?, string?, [ number, number ], number, string, string?, boolean ]

---@class StrippedOfficer
---@field source number
---@field name string
---@field callsign? string
---@field avatar? string
---@field coords? vector3 | vector2
---@field heading? number
---@field vehicle? string
---@field unit? string
---@field visible? boolean

---@class Officer : StrippedOfficer
---@field identifier string

---@type Officer[]
local policeOfficers = {}
---@type Officer[]
local ambulanceOfficers = {}

OnPlayerDisconnect(function(source)
    for i = 1, #policeOfficers do
        if policeOfficers[i].source == source then
            table.remove(policeOfficers, i)
            debugprint("Removed player from policeOfficers as they logged out", source)

            break
        end
    end

    for i = 1, #ambulanceOfficers do
        if ambulanceOfficers[i].source == source then
            table.remove(ambulanceOfficers, i)
            debugprint("Removed player from ambulanceOfficers as they logged out", source)

            break
        end
    end
end)

---@param source number
---@param officers Officer[]
---@param hasJob boolean
---@return boolean
local function UpdateOfficerTable(source, officers, hasJob)
    for i = 1, #officers do
        if officers[i].source == source then
            if hasJob then
                debugprint("Player is already in officers", source)
            else
                table.remove(officers, i)
                debugprint("Removed player from officers", source)
            end

            return true
        end
    end

    return false
end

local function OnJobChange(source, job, duty)
    local identifier = GetIdentifier(source)

    if not identifier then
        return
    end

    debugprint("OnJobChange", source, job, duty)

    local isPolice = duty and Config.Police.Permissions[job] ~= nil
    local isAmbulance = duty and Config.Ambulance.Permissions[job] ~= nil

    if UpdateOfficerTable(source, policeOfficers, isPolice) and isPolice then
        return
    end

    if UpdateOfficerTable(source, ambulanceOfficers, isAmbulance) and isAmbulance then
        return
    end

    if not isPolice and not isAmbulance then
        return
    end

    local name = GetCharacterName(source)

    if isPolice then
        debugprint("Added player to policeOfficers", source)

        policeOfficers[#policeOfficers+1] = {
            source = source,
            identifier = identifier,
            name = name
        }
    end

    if isAmbulance then
        debugprint("Added player to ambulanceOfficers", source)

        ambulanceOfficers[#ambulanceOfficers+1] = {
            source = source,
            identifier = identifier,
            name = name
        }
    end
end

---@param source number
---@param job string
---@param duty boolean
AddEventHandler("lb-tablet:jobUpdated", function(source, job, duty)
    OnJobChange(source, job, duty)
end)

RegisterNetEvent("lb-tablet:frameworkLoaded", function()
    local src = source

    Wait(1000)

    local job = GetJob(src)

    OnJobChange(src, job.name, IsOnDuty(src))
end)

---@param officers Officer[]
---@param getCallsign function
---@param getAvatar function
---@param event string
local function UpdateOfficerBlips(officers, getCallsign, getAvatar, event)
    ---@type RawOfficer[]
    local officersToSend = {}

    for i = 1, #officers do
        local officer = officers[i]
        local playerPed = GetPlayerPed(officer.source)
        local visible = true

        if Config.RequireItemDutyBlips and not HasTabletItem(officer.source) then
            visible = false
        end

        if playerPed and playerPed ~= 0 then
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if vehicle and vehicle ~= 0 then
                local vehicleType = GetVehicleType(vehicle)

                if
                    vehicleType == "bike"
                    or vehicleType == "heli"
                    or vehicleType == "boat"
                    or vehicleType == "plane"
                then
                    officer.vehicle = vehicleType
                else
                    officer.vehicle = "car"
                end
            else
                officer.vehicle = nil
            end

            officer.callsign = getCallsign(officer.identifier)
            officer.avatar = getAvatar(officer.identifier)
            officer.coords = GetEntityCoords(playerPed)
            officer.heading = GetEntityHeading(playerPed)
        end

        ---@type RawOfficer
        officersToSend[#officersToSend + 1] = {
            officer.source,
            officer.name,
            officer.callsign,
            officer.avatar,
            {
                math.floor(officer.coords.x + 0.5),
                math.floor(officer.coords.y + 0.5)
            },
            math.floor(officer.heading + 0.5),
            officer.vehicle,
            GetPlayerUnit(officer.source),
            visible
        }
    end

    local payload = msgpack.pack_args(officersToSend)
    local length = #payload

    for i = 1, #officers do
        ---@diagnostic disable-next-line: param-type-mismatch
        TriggerClientEventInternal(event, officers[i].source, payload, length)
    end
end

Wait(2500)

local interval = math.floor(math.max(Config.DutyBlipInterval or 5000, 100))

while true do
    if Config.Police.DutyBlips then
        UpdateOfficerBlips(policeOfficers, GetPoliceCallsign, GetPoliceAvatar, "tablet:police:updateOfficerBlips")
    end

    if Config.Ambulance.DutyBlips then
        UpdateOfficerBlips(ambulanceOfficers, GetAmbulanceCallsign, GetAmbulanceAvatar, "tablet:ambulance:updateOfficerBlips")
    end

    Wait(interval)
end
