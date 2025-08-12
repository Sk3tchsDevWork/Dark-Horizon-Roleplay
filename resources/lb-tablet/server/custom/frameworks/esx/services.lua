if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
end

RegisterNetEvent("tablet:services:toggleDuty", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        xPlayer.setJob(xPlayer.job.name, xPlayer.job.grade, not xPlayer.job.onDuty)
    end
end)

---@param company string
function GetEmployeeList(company)
    local numberTable = Config.LBPhone and (GetPhoneConfig()?.Item?.Unique and "phone_last_phone" or "phone_phones") or nil
    local joinPhone = Config.LBPhone and ("LEFT JOIN %s p ON u.identifier %s = p.id"):format(numberTable, UsersCollate) or ""

    local employees = MySQL.query.await([[
        SELECT
            u.identifier,
            u.firstname, u.lastname,
            u.job_grade AS grade,
            ]] .. (Config.LBPhone and "p.phone_number AS `number`," or "") .. [[
            j.label AS gradeLabel

        FROM users u
        ]] .. joinPhone .. [[
        JOIN job_grades j ON u.job = j.job_name AND u.job_grade = j.grade
        WHERE u.job = ?
    ]], { company })

    local onlineEmployees = ESX.GetExtendedPlayers("job", company)
    local onlineIdentifiers = {}

    for i = 1, #onlineEmployees do
        onlineIdentifiers[onlineEmployees[i].identifier] = true
    end

    for i = 1, #employees do
        local employee = employees[i]

        employee.online = onlineIdentifiers[employee.identifier] or false
        employee.identifier = nil
    end

    return employees
end

function RefreshCompanies()
    if ESX.JobsPlayerCount or ESX.GetNumPlayers then
        debugprint("Using new ESX method for refreshing companies")

        for i = 1, #Config.Services.Companies do
            local jobData = Config.Services.Companies[i]
            local jobKey = ("%s:count"):format(jobData.job)

            jobData.open = (GlobalState[jobKey] or 0) > 0
            debugprint("Job", jobData.job, "is open:", jobData.open)
        end

        return
    end

    debugprint("Using old ESX method for refreshing companies")

    local openJobs = {}
    local xPlayers = ESX.GetExtendedPlayers and ESX.GetExtendedPlayers() or ESX.GetPlayers()

    if ESX.GetExtendedPlayers then
        for _, xPlayer in pairs(xPlayers) do
            openJobs[xPlayer.job.name] = true
        end

        infoprint("warning", "You are running an outdated version of ESX. The script will still work, but you should consider updating. (you can remove this warning in server/custom/frameworks/esx.lua)")
    else
        for _, source in pairs(xPlayers) do
            local job = ESX.GetPlayerFromId(source).job.name

            openJobs[job] = true
        end

        infoprint("warning", "You are running an extremely old version of ESX. The script will still work, but you should consider updating. (you can remove this warning in server/custom/frameworks/esx.lua)")
    end

    for i = 1, #Config.Services.Companies do
        local jobData = Config.Services.Companies[i]

        jobData.open = openJobs[jobData.job] or false
    end
end

for i = 1, #Config.Services.Companies do
    local jobData = Config.Services.Companies[i]
    local jobKey = ("%s:count"):format(jobData.job)

    AddStateBagChangeHandler(jobKey, "global", function(_, _, value)
        Wait(0) -- prevent print from showing in F8 when using command

        if type(value) ~= "number" then
            return
        end

        local isOpen = value > 0

        if jobData.open ~= isOpen then
            jobData.open = isOpen
            TriggerClientEvent("tablet:services:updateOpen", -1, jobData.job, isOpen)
        end

        debugprint(("Job count for job ^5%s^7 changed. Is open: %s"):format(jobData.job, jobData.open))
    end)
end

BaseCallback("services:getOnlineIdentifiers", function(source, tabletId)
    local job = GetJob(source).name
    local onlineEmployees = ESX.GetExtendedPlayers("job", job)
    local onlineIdentifiers = {}

    for i = 1, #onlineEmployees do
        onlineIdentifiers[onlineEmployees[i].identifier] = true
    end

    return onlineIdentifiers
end)
