if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
end

MySQL.ready(function()
    while not GetCollationsForTables do
        Wait(0)
    end

    local collations = GetCollationsForTables({
        users = "identifier",
        owned_vehicles = "plate"
    })

    UsersCollate = collations.users or ""
    VehiclesCollate = collations.owned_vehicles or ""
end)

Queries = {}

Queries.Users = {}

Queries.Users = {}
Queries.Users.Table = "users"
Queries.Users.Select = {
    identifier = "user.identifier",
    name = "CONCAT(user.firstname, ' ', user.lastname)",
    dob = "user.dateofbirth",
    isMale = "user.sex = 'm'",
}

Queries.Users.Filter = {}
Queries.Users.Filter.Jobs = "user.job IN (?)"
Queries.Users.Filter.Gender = "user.sex = ?"
Queries.Users.Filter.License = "EXISTS (SELECT 1 FROM user_licenses license WHERE license.owner = user.identifier AND license.`type` = ?)"

if Config.JailScript == "qalle" then
    Queries.Users.Filter.ExcludeJailed = "user.jail = 0"
elseif Config.JailScript == "esx" then
    Queries.Users.Filter.ExcludeJailed = "user.jail_time = 0"
elseif Config.JailScript == "pickle" then
    Queries.Users.Filter.ExcludeJailed = "NOT EXISTS (SELECT 1 FROM pickle_prisons WHERE identifier = user.identifier {USERS_COLLATE})"
elseif Config.JailScript == "rcore" then
    Queries.Users.Filter.ExcludeJailed = "NOT EXISTS (SELECT 1 FROM rcore_prison WHERE owner = user.identifier {USERS_COLLATE})"
end

Queries.Users.FetchProfile = [[
    SELECT
        user.identifier AS id,
        CONCAT(user.firstname, ' ', user.lastname) AS `name`,
        user.dateofbirth as dob,
        user.height,
        user.sex = "m" AS isMale,
        profile.avatar,
        profile.notes,
        grade.label AS jobGrade,
        job.label AS job

    FROM users user

    LEFT JOIN {PROFILE_JOIN} profile ON profile.id = user.identifier {USERS_COLLATE}

    LEFT JOIN jobs job ON job.`name` = user.job
    LEFT JOIN job_grades grade ON grade.job_name = user.job AND grade.grade = user.job_grade

    WHERE user.identifier = ?
]]

Queries.Vehicles = {}
Queries.Vehicles.Table = "owned_vehicles"
Queries.Vehicles.Select = {
    plate = "vehicle.plate",
    owner = "vehicle.owner",
    vehicle = "vehicle.vehicle",
    model = "JSON_EXTRACT(vehicle.vehicle, '$.model')",
}

Queries.Vehicles.BasicFetch = "SELECT vehicle FROM owned_vehicles WHERE plate = ?"
