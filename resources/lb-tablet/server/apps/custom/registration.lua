if not Config.RegistrationApp then
    return
end

---@param event string
---@param callback fun(source: number, tabletId: string, characterId: string, ...) : any
---@param defaultReturn any
local function RegistrationCallback(event, callback, defaultReturn)
    ---@param characterId? string
    BaseCallback("registration:" .. event, function(source, tabletId, characterId, ...)
        if not characterId then
            debugprint("No character id provided")
            return false
        end

        if not MySQL.scalar.await("SELECT 1 FROM lbtablet_registration_characters WHERE character_id = ? AND identifier = ?", { characterId, tabletId }) then
            debugprint("Character not found / doesn't belong to player")
            return false
        end

        return callback(source, tabletId, characterId, ...)
    end, defaultReturn)
end

--#region Characters

---@class RegistrationCharacterData
---@field id string
---@field firstname string
---@field lastname string
---@field dob string
---@field isMale boolean
---@field job string
---@field height number
---@field avatar? string
---@field description? string
---@field phoneNumber? string

---@param identifier string
---@param characterData RegistrationCharacterData
---@return string | nil
local function CreateNewCharacter(identifier, characterData)
    local characterId = 1
    local characterIdentifier = characterId .. ":" .. identifier
    local firstname = characterData.firstname
    local lastname = characterData.lastname
    local dob = characterData.dob
    local isMale = characterData.isMale == true
    local job = characterData.job or "unemployed"
    local height = characterData.height
    local avatar = characterData.avatar
    local description = characterData.description or ""
    local phoneNumber = characterData.phoneNumber or ""

    while
        MySQL.scalar.await(
            "SELECT 1 FROM lbtablet_registration_characters WHERE character_id = ?",
            { characterIdentifier }
        )
    do
        characterId += 1
        characterIdentifier = characterId .. ":" .. identifier
        Wait(0)
    end

    if MySQL.update.await(
        "INSERT INTO lbtablet_registration_characters (`identifier`, `character_id`, `firstname`, `lastname`, `dateofbirth`, `is_male`, `job`, `height`, `avatar`, `description`, phone_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        { identifier, characterIdentifier, firstname, lastname, dob, isMale, job, height, avatar, description, phoneNumber }
    ) == 0 then
        debugprint("Failed to create character")
        return
    end

    return characterIdentifier
end

---@param characterData RegistrationCharacterData
---@return string
BaseCallback("registration:saveCharacter", function(source, tabletId, characterData)
    if not characterData.id then
        return CreateNewCharacter(tabletId, characterData)
    end

    if MySQL.update.await([[
        UPDATE lbtablet_registration_characters
        SET
            firstname = ?,
            lastname = ?,
            dateofbirth = ?,
            is_male = ?,
            job = ?,
            height = ?,
            avatar = ?,
            description = ?,
            phone_number = ?
        WHERE character_id = ? AND identifier = ?
    ]], {
        characterData.firstname,
        characterData.lastname,
        characterData.dob,
        characterData.isMale,
        characterData.job,
        characterData.height,
        characterData.avatar,
        characterData.description or "",
        characterData.phoneNumber or "",
        characterData.id,
        tabletId
    }) > 0 then
        return characterData.id
    end
end)

---@param characterId string
BaseCallback("registration:deleteCharacter", function(source, tabletId, characterId)
    local queries = {
        "DELETE FROM lbtablet_registration_properties WHERE character_id = @characterId",
        "DELETE FROM lbtablet_registration_licenses WHERE character_id = @characterId",
        "DELETE FROM lbtablet_registration_vehicles WHERE character_id = @characterId",
        "DELETE FROM lbtablet_registration_characters WHERE character_id = @characterId AND identifier = @identifier"
    }

    return MySQL.transaction.await(queries, { characterId = characterId, identifier = tabletId })
end)

BaseCallback("registration:getCharacters", function(source, tabletId)
    local characters = MySQL.query.await([[
        SELECT
            character_id AS id,
            firstname,
            lastname,
            dateofbirth AS dob,
            is_male AS isMale,
            job,
            height,
            avatar,
            description,
            phone_number AS phoneNumber

        FROM lbtablet_registration_characters
        WHERE identifier = ?
    ]], { tabletId })

    for i = 1, #characters do
        local character = characters[i]

        character.vehicles = MySQL.query.await([[
            SELECT
                id,
                plate,
                model,
                color,
                picture

            FROM lbtablet_registration_vehicles
            WHERE character_id = ?
        ]], { character.id })

        local licenses = MySQL.query.await([[
            SELECT
                license
            FROM lbtablet_registration_licenses
            WHERE character_id = ?
        ]], { character.id })

        character.licenses = {}

        for _, license in pairs(licenses) do
            character.licenses[#character.licenses+1] = license.license
        end

        character.properties = MySQL.query.await([[
            SELECT
                id,
                label,
                address

            FROM lbtablet_registration_properties
            WHERE character_id = ?
        ]], { character.id })
    end

    return characters
end)

--#endregion

--#region Properties

---@param data table
RegistrationCallback("addProperty", function(source, tabletId, characterId, data)
    if not characterId then
        return
    end

    return MySQL.insert.await([[
        INSERT INTO lbtablet_registration_properties (character_id, label, address)
        VALUES (?, ?, ?)
    ]], { characterId, data.label, data.address })
end)

---@param data table
RegistrationCallback("deleteProperty", function(source, tabletId, characterId, data)
    if not characterId then
        return
    end

    return MySQL.update.await([[
        DELETE FROM lbtablet_registration_properties
        WHERE id = ? AND character_id = ?
    ]], { data.id, characterId })
end)

--#endregion

--#region Vehicles

---@param data table
RegistrationCallback("saveVehicle", function(source, tabletId, characterId, data)
    if not characterId then
        return
    end

    if not data.id then
        if MySQL.scalar.await([[
            SELECT 1 FROM lbtablet_registration_vehicles WHERE plate = ?
        ]], { data.plate }) then
            return debugprint("Vehicle with plate already exists")
        end

        return MySQL.insert.await([[
            INSERT INTO lbtablet_registration_vehicles (character_id, plate, model, color, picture)
            VALUES (?, ?, ?, ?, ?)
        ]], { characterId, data.plate, data.model, data.color, data.picture })
    end

    if MySQL.scalar.await(
        "SELECT 1 FROM lbtablet_registration_vehicles WHERE plate = ? AND id != ?",
        { data.plate, data.id }
    ) == 0 then
        return debugprint("Vehicle with plate already exists")
    end

    if MySQL.update.await([[
        UPDATE lbtablet_registration_vehicles
        SET
            plate = ?,
            model = ?,
            color = ?,
            picture = ?
        WHERE id = ? AND character_id = ?
    ]], { data.plate, data.model, data.color, data.picture, data.id, characterId }) > 0 then
        return data.id
    end
end)

RegistrationCallback("deleteVehicle", function(source, tabletId, characterId, id)
    if not characterId then
        return
    end

    return MySQL.update.await([[
        DELETE FROM lbtablet_registration_vehicles
        WHERE character_id = ? AND id = ?
    ]], { characterId, id }) > 0
end)

--#endregion

--#region Licenses

BaseCallback("registration:getLicenses", function(source, tabletId)
    local licenses = {}
    local allLicenses = GetAllLicenses()

    for i = 1, #allLicenses do
        licenses[#licenses+1] = allLicenses[i].label
    end

    return licenses
end)

---@param license string
RegistrationCallback("addLicense", function(source, tabletId, characterId, license)
    if not characterId then
        return
    end

    return MySQL.update.await([[
        INSERT INTO lbtablet_registration_licenses (character_id, license)
        VALUES (?, ?)
    ]], { characterId, license }) > 0
end)

---@param license string
RegistrationCallback("deleteLicense", function(source, tabletId, characterId, license)
    if not characterId then
        return
    end

    return MySQL.update.await([[
        DELETE FROM lbtablet_registration_licenses
        WHERE character_id = ? AND license = ?
    ]], { characterId, license }) > 0
end)

--#endregion
