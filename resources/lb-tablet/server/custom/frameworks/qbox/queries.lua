if Config.Framework ~= "qbox" then
    return
end

while not QB do
    Wait(0)
end

MySQL.ready(function()
    while not GetCollationsForTables do
        Wait(0)
    end

    local collations = GetCollationsForTables({
        players = "citizenid",
        player_vehicles = "plate"
    })

    UsersCollate = collations.players or ""
    VehiclesCollate = collations.player_vehicles or ""
end)

Queries = {}

Queries.Users = {}

Queries.Users = {}
Queries.Users.Table = "players"
Queries.Users.Select = {
    identifier = "user.citizenid",
    name = "CONCAT(JSON_VALUE(user.charinfo, '$.firstname'), ' ', JSON_VALUE(user.charinfo, '$.lastname'))",
    dob = "JSON_VALUE(user.charinfo, '$.birthdate')",
    isMale = "JSON_EXTRACT(user.charinfo, '$.gender') = 0",
    fingerprint = "JSON_UNQUOTE(JSON_EXTRACT(user.metadata, '$.fingerprint'))",
}

Queries.Users.Filter = {}
Queries.Users.Filter.Jobs = "JSON_VALUE(user.job, '$.name') IN (?)"
Queries.Users.Filter.Gender = "JSON_EXTRACT(user.charinfo, '$.gender') = ?"
Queries.Users.Filter.License = "JSON_UNQUOTE(JSON_EXTRACT(user.metadata, '$.licences.%s')) = 'true'"

if Config.JailScript == "qb" then
    Queries.Users.Filter.ExcludeJailed = "NOT EXISTS (SELECT 1 FROM lbtablet_police_jail jail WHERE jail.prisoner = user.citizenid {USERS_COLLATE} AND jail.jail_time > 0)"
end

Queries.Users.FetchProfile = [[
    SELECT
        user.citizenid AS id,
        CONCAT(JSON_VALUE(user.charinfo, '$.firstname'), ' ', JSON_VALUE(user.charinfo, '$.lastname')) AS `name`,
        JSON_VALUE(user.charinfo, '$.birthdate') AS dob,
        JSON_EXTRACT(user.charinfo, '$.gender') = 0 AS isMale,
        JSON_UNQUOTE(JSON_EXTRACT(user.metadata, '$.bloodtype')) AS bloodType,
        JSON_UNQUOTE(JSON_EXTRACT(user.metadata, '$.fingerprint')) AS fingerprint,
        profile.avatar,
        profile.notes,
        JSON_VALUE(user.job, '$.grade.name') AS jobGrade,
        JSON_VALUE(user.job, '$.label') AS job

    FROM players user

    LEFT JOIN {PROFILE_JOIN} profile ON profile.id = user.citizenid {USERS_COLLATE}

    WHERE user.citizenid = ?
]]

Queries.Vehicles = {}
Queries.Vehicles.Table = "player_vehicles"
Queries.Vehicles.Select = {
    plate = "vehicle.plate",
    owner = "vehicle.citizenid",
    vehicle = "vehicle.vehicle",
    mods = "vehicle.mods",
    model = "JSON_EXTRACT(vehicle.mods, '$.model')",
}

Queries.Vehicles.BasicFetch = "SELECT vehicle, mods FROM player_vehicles WHERE plate = ?"
