if Config.Framework ~= "standalone" then
    return
end

---@param source number
function IsOnDuty(source)
    return true
end

---@param source number
---@return { name: string, label: string, grade: number, grade_label: string }
function GetJob(source)
    return {
        name = "unemployed",
        label = "Unemployed",
        grade = 0,
        grade_label = "Unemployed"
    }
end

---@param jobs string | string[]
---@return { grades: { [string]: { grade: number, label: string }[] }, labels: { [string]: string } }
function GetJobGrades(jobs)
    if type(jobs) == "string" then
        jobs = { jobs }
    end

    local grades = {} -- { [job: string]: { grade: number, label: string }[] }
    local labels = {} -- { [job: string]: string }

    for i = 1, #jobs do
        local job = jobs[i]
        local label = job:gsub("^%l", string.upper)

        labels[job] = label
        grades[job] = {}

        for grade = 0, 4 do
            table.insert(grades[job], {
                grade = grade,
                label = label .. " - " .. grade
            })
        end
    end

    return {
        grades = grades,
        labels = labels
    }
end

---@param companies string[]
---@param accountsTable string
function GetEmployees(companies, accountsTable)
    local selectPhoneNumber = ""
    local joinPhoneTable = ""

    if Config.LBPhone then
        local phoneConfig = GetPhoneConfig()

        selectPhoneNumber = ", phone.phone_number AS phoneNumber"

        if phoneConfig?.Item?.Unique then
            joinPhoneTable = "LEFT JOIN phone_last_phone phone ON user.character_id = phone.id"
        else
            joinPhoneTable = "LEFT JOIN phone_phones phone ON user.character_id = phone.id"
        end
    end

    local query = FormatString([[
        SELECT
            user.character_id AS id,
            account.callsign,
            account.avatar,
            CONCAT(user.firstname, ' ', user.lastname) AS `name`,
            user.job,
            1 AS `rank`
            {SELECT_PHONE_NUMBER}

        FROM lbtablet_registration_characters user

        LEFT JOIN {ACCOUNTS_TABLE} account ON account.id = user.identifier
        {JOIN_PHONE_TABLE}

        WHERE user.job IN (?)
    ]], {
        ACCOUNTS_TABLE = accountsTable,
        SELECT_PHONE_NUMBER = selectPhoneNumber,
        JOIN_PHONE_TABLE = joinPhoneTable
    })

    return MySQL.query.await(query, { companies })
end

---@param jobs { [string]: any }
---@return { source: number, name: string, rank: string, identifier: string }[]
function GetOnDutyEmployees(jobs)
    local employees = {}

    return employees
end

---@param jobs string | string[]
---@return string[]
function GetIdentifiersWithJob(jobs)
    if type(jobs) == "string" then
        jobs = { jobs }
    end

    local identifiers = MySQL.query.await("SELECT character_id FROM lbtablet_registration_characters WHERE job IN (?)", { jobs })
    local result = {}

    for i = 1, #identifiers do
        result[i] = identifiers[i].character_id
    end

    return result
end

-- Implement your own logic for handling job updates here
AddEventHandler("jobUpdated", function(src, job, lastJob)
    Wait(0)
    TriggerEvent("lb-tablet:jobUpdated", src, job.name, IsOnDuty(src))
end)
