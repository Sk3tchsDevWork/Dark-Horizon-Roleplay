if Config.Framework ~= "standalone" then
    return
end

---@param company string
---@return { identifier: string, firstname: string, lastname: string, grade: number, gradeLabel: string, number?: string, online: boolean }[]
function GetEmployeeList(company)
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
            user.character_id AS identifier,
            user.firstname,
            user.lastname,
            0 AS grade,
            user.job AS gradeLabel
            {SELECT_PHONE_NUMBER}

        FROM lbtablet_registration_characters user

        {JOIN_PHONE_TABLE}

        WHERE user.job = ?
    ]], {
        SELECT_PHONE_NUMBER = selectPhoneNumber,
        JOIN_PHONE_TABLE = joinPhoneTable
    })

    return MySQL.query.await(query, { company })
end

---Refresh the open status for all companies
function RefreshCompanies()
    for i = 1, #Config.Services.Companies do
        local jobData = Config.Services.Companies[i]

        jobData.open = false
    end
end

---Get a lookup table of identifiers that are online for the player's job
---@return table<string, boolean>
BaseCallback("services:getOnlineIdentifiers", function(source, tabletId)
    local job = GetJob(source).name
    local onlineEmployees = {} -- implement your framework's function to get all online employees for a job here
    local onlineIdentifiers = {}

    for i = 1, #onlineEmployees do
        onlineIdentifiers[onlineEmployees[i].identifier] = true
    end

    return onlineIdentifiers
end)
