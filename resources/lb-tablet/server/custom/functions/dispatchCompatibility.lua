if not Config.DispatchCompatibility then
    return
end

---@param jobs? string[]
---@return "police" | "ambulance"
local function GetDispatchJob(jobs)
    if jobs and type(jobs) == "table" then
        if contains(jobs, "ambulance") or contains(jobs, "ems") then
            return "ambulance"
        end
    end

    return "police"
end

RegisterNetEvent("cd_dispatch:AddNotification", function(dispatch)
    local src = source
    local playerPed = GetPlayerPed(src)
    dispatch.coords = dispatch.coords or GetEntityCoords(playerPed)

    local priority = "medium"
    local code = string.match(dispatch.title, "10%-%d%d")

    if dispatch.flash == true or dispatch.flash == 1 then
        priority = "high"
    end

    AddDispatch({
        job = GetDispatchJob(dispatch.job_table),
        priority = priority,
        code = code and code or "",
        title = dispatch.title or "Dispatch",
        description = dispatch.message or "",
        location = {
            label = dispatch.blip?.text or "Unknown",
            coords = vector2(dispatch.coords.x or 0, dispatch.coords.y or 0),
        },
        time = dispatch.blip?.time and math.floor(dispatch.blip.time * 60 + 0.5) or 120,
    })
end)

RegisterNetEvent("qs-dispatch:server:CreateDispatchCall", function(dispatch)
    local src = source

    local fields
    local priority = "medium"
    local playerPed = GetPlayerPed(src)
    local coords = dispatch.callLocation or GetEntityCoords(playerPed)
    local code = string.match(dispatch.callCode?.code, "10%-%d%d") or string.match(dispatch.callCode?.snippet, "10%-%d%d")

    if dispatch.flashes == true or dispatch.blip?.flashes then
        priority = "high"
    end

    if dispatch.otherData then
        fields = {}

        for i = 1, #dispatch.otherData do
            local data = dispatch.otherData[i]

            fields[i] = {
                icon = data.icon,
                label = data.text
            }
        end
    end

    AddDispatch({
        job = GetDispatchJob(dispatch.job),
        priority = priority,
        code = code or "",
        title = dispatch.callCode?.snippet or "Dispatch",
        description = dispatch.message or "",
        location = {
            label = dispatch.blip?.text or "Unknown",
            coords = vector2(coords.x, coords.y),
        },
        time = dispatch.blip?.time and math.ceil(dispatch.blip.time / 1000) or 120,
        image = dispatch.image,
        fields = fields
    })
end)

local function PsDispatchAlert(dispatch)
    local coords = dispatch.coords

    if not coords then
        debugprint("ps-dispatch: Dispatch is missing coords")
        return
    end

    AddDispatch({
        job = GetDispatchJob(dispatch.recipientList),
        priority = dispatch.priority == 1 and "high" or "medium",
        code = dispatch.displayCode or "",
        title = "Dispatch",
        description = dispatch.message or "",
        location = {
            label =  "Unknown",
            coords = vector2(dispatch.coords.x or 0, dispatch.coords.y or 0),
        },
        time = dispatch.alertTime and dispatch.alertTime or 120,
    })
end

AddCompatibilityExport("ps-dispatch", "CustomAlert", function(dispatch)
    PsDispatchAlert(dispatch)
end)

RegisterNetEvent("ps-dispatch:server:notify", function(dispatch)
    local src = source
    local playerPed = GetPlayerPed(src)

    dispatch.coords = dispatch.coords or GetEntityCoords(playerPed)

    PsDispatchAlert(dispatch)
end)

RegisterNetEvent("redutzu-mdt:server:addDispatchToMDT", function(dispatch)
    local src = source
    local playerPed = GetPlayerPed(src)
    local coords = dispatch.coords or GetEntityCoords(playerPed)

    AddDispatch({
        job = "police",
        priority = "medium",
        code = dispatch.code or "",
        title = dispatch.title or "Dispatch",
        description = dispatch.title or "",
        location = {
            label = dispatch.street or "Unknown",
            coords = vector2(coords.x or 0, coords.y or 0),
        },
        time = dispatch.duration and math.ceil(dispatch.duration / 1000) or 120
    })
end)

RegisterNetEvent("police:server:policeAlert", function(title)
    local src = source
    local playerPed = GetPlayerPed(src)
    local coords = GetEntityCoords(playerPed)

    AddDispatch({
        job = "police",
        priority = "medium",
        code = "",
        title = title or "Dispatch",
        description = title or "",
        location = {
            label = "Unknown",
            coords = vector2(coords.x, coords.y),
        },
        time = 120
    })
end)

RegisterNetEvent("hospital:server:ambulanceAlert", function(text)
	local src = source
	local ped = GetPlayerPed(src)
	local coords = GetEntityCoords(ped)

    AddDispatch({
        job = "ambulance",
        priority = "medium",
        code = "",
        title = text or "Dispatch",
        description = text or "",
        location = {
            label = "Location",
            coords = vector2(coords.x, coords.y),
        },
        time = 120
    })
end)
