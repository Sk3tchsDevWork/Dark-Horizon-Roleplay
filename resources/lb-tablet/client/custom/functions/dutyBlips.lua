---<b>Key:</b> source
---@type { [number]: { blip: number, hasJob: (fun(): boolean), ped?: number }? }
local gameBlips = {}

---@param officers StrippedOfficer[]
---@param hasJob fun(): boolean
local function RefreshDutyBlips(officers, hasJob)
    if not Config.DutyBlipOptions or not Config.DutyBlipOptions.Show then
        return
    end

    for i = 1, #officers do
        local officer = officers[i]
        local player = GetPlayerFromServerId(officer.source)
        ---@type number?
        local ped = player ~= -1 and GetPlayerPed(player) or nil
        local oldBlip = gameBlips[officer.source]
        local blip = oldBlip and oldBlip.blip

        if ped and ped ~= 0 and DoesEntityExist(ped) then
            if oldBlip and oldBlip.ped ~= ped then
                RemoveBlip(oldBlip.blip)

                oldBlip = nil
            end

            if not oldBlip then
                blip = AddBlipForEntity(ped)
            end
        else
            ped = nil

            if oldBlip and oldBlip.ped then
                RemoveBlip(oldBlip.blip)

                oldBlip = nil
            end

            if oldBlip then
                SetBlipCoords(oldBlip.blip, officer.coords.x, officer.coords.y, 0.0)
            else
                blip = AddBlipForCoord(officer.coords.x, officer.coords.y, 0.0)
            end
        end

        if not blip then
            goto continue
        end

        if Config.DutyBlipOptions.Category then
            SetBlipCategory(blip, Config.DutyBlipOptions.Category)
        end

        local sprite = Config.DutyBlipOptions.Sprite or 1

        if officer.vehicle and Config.DutyBlipOptions.VehicleTypes and Config.DutyBlipOptions.VehicleTypes[officer.vehicle] then
            sprite = Config.DutyBlipOptions.VehicleTypes[officer.vehicle]
        end

        SetBlipSprite(blip, sprite)
        SetBlipColour(blip, Config.DutyBlipOptions.Color or 0)
        SetBlipScale(blip, Config.DutyBlipOptions.Scale or 0.9)
        SetBlipAsShortRange(blip, Config.DutyBlipOptions.ShortRange == true)
        DisplayPlayerNameTagsOnBlips(true)
        ShowHeightOnBlip(blip, false)

        if Config.DutyBlipOptions.FriendIndicator then
            ShowFriendIndicatorOnBlip(blip, true)
        end

        if Config.DutyBlipOptions.Outline then
            ShowOutlineIndicatorOnBlip(blip, true)

            if Config.DutyBlipOptions.OutlineColor then
                local r, g, b = table.unpack(Config.DutyBlipOptions.OutlineColor)

                SetBlipSecondaryColour(blip, r or 93, g or 182, b or 229)
            end
        end

        if Config.DutyBlipOptions.ShowHeading then
            SetBlipRotation(blip, math.floor(officer.heading))
            ShowHeadingIndicatorOnBlip(blip, true)
        end

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(
            FormatString(Config.DutyBlipOptions.Name, {
                name = officer.name,
                callsign = officer.callsign
            })
        )
        EndTextCommandSetBlipName(blip)

        gameBlips[officer.source] = {
            blip = blip,
            hasJob = hasJob,
            ped = ped
        }

        ::continue::
    end

    for source, blip in pairs(gameBlips) do
        if not blip.hasJob() then
            RemoveBlip(blip.blip)

            gameBlips[source] = nil
        end
    end
end

---@param officer? RawOfficer
---@return StrippedOfficer | nil
local function FormatOfficer(officer)
    if not officer then
        debugprint("FormatOfficer: officer is nil")
        return
    end

    ---@type StrippedOfficer
    return {
        source = officer[1],
        name = officer[2],
        callsign = officer[3],
        avatar = officer[4],
        coords = vector2(officer[5][1], officer[5][2]),
        heading = officer[6],
        vehicle = officer[7],
        unit = officer[8],
        visible = officer[9]
    }
end

---@param job "police" | "ambulance"
---@param hasJob fun(): boolean
function RegisterDutyBlipsListener(job, hasJob)
    local showBlips = false

    if job == "police" then
        showBlips = Config.Police.DutyBlips
    elseif job == "ambulance" then
        showBlips = Config.Ambulance.DutyBlips
    end

    ---@param officerBlips RawOfficer[]
    RegisterNetEvent("tablet:" .. job .. ":updateOfficerBlips", function(officerBlips)
        if not hasJob() then
            debugprint("updateOfficerBlips: does not have job", job)
            return
        end

        ---@type { source: number, name: string, unit?: string, callsign?: string, avatar?: string }[]
        local allOfficersList = {}
        local formattedOfficers = {}
        local playerSource = GetPlayerServerId(PlayerId())

        for i = 1, #officerBlips do
            local officer = FormatOfficer(officerBlips[i])

            if officer and showBlips and officer.visible and officer.source ~= playerSource then
                formattedOfficers[#formattedOfficers+1] = officer
            end

            if officer then
                allOfficersList[#allOfficersList+1] = {
                    source = officer.source,
                    name = officer.name,
                    unit = officer.unit,
                    callsign = officer.callsign,
                    avatar = officer.avatar
                }
            end
        end

        SendReactMessage(job .. ":updateOfficers", allOfficersList)

        if showBlips then
            SendReactMessage(job .. ":updateOfficerBlips", formattedOfficers)
            RefreshDutyBlips(formattedOfficers, hasJob)
        end
    end)
end

if Config.DutyBlipOptions and Config.DutyBlipOptions.Show then
    AddEventHandler("lb-tablet:jobUpdated", function()
        for source, blip in pairs(gameBlips) do
            if not blip.hasJob() then
                RemoveBlip(blip.blip)

                gameBlips[source] = nil
            end
        end
    end)
end
