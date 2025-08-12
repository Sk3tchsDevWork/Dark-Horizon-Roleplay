local shouldGenerateTables = false

if not Config.DatabaseChecker?.Enabled and not shouldGenerateTables then
    debugprint("Database checker is disabled")
    DatabaseCheckerFinished = true
    return
end

MySQL.ready.await()

local database = MySQL.scalar.await("SELECT DATABASE()")

if not database then
    infoprint("error", "Database checker: Failed to get database name. The script will still work, but database changes will not apply automatically. To disable this warning, set Config.DatabaseChecker.Enabled to false")
    DatabaseCheckerFinished = true
    return
end

local databaseVersion = MySQL.scalar.await("SELECT VERSION()") or ""

if not databaseVersion:find("MariaDB") then
    infoprint("error", "Database checker: Your database is not MariaDB. The script may not work as expected, and database changes will not apply automatically. To disable this warning, set Config.DatabaseChecker.Enabled to false")
    DatabaseCheckerFinished = true
    return
end

local major, minor, patch = databaseVersion:match("(%d+)%.(%d+)%.(%d+)")

major = major and tonumber(major)
minor = minor and tonumber(minor)
patch = patch and tonumber(patch)

if not major or not minor or not patch then
    infoprint("error", "Database checker: Failed to get database version. The script will still work, but database changes will not apply automatically. To disable this warning, set Config.DatabaseChecker.Enabled to false")
    DatabaseCheckerFinished = true
    return
end

if major < 10 or (major == 10 and minor < 11) then
    infoprint("error", "Database checker: Your database version is outdated. Please update to MariaDB 10.11 or newer. The script may not work as expected, and database changes will not apply automatically. To disable this warning, set Config.DatabaseChecker.Enabled to false")
    DatabaseCheckerFinished = true
    return
end

local defaultTables = GetDefaultDatabaseTables()
local tables = {}

local function FetchTables()
    table.wipe(tables)

    local rows = MySQL.query.await("SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, COLLATION_NAME, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE, COLUMN_DEFAULT, COLUMN_KEY FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = ? AND TABLE_NAME LIKE ?", {
        shouldGenerateTables and "generate_lb" or database, "lbtablet_%"
    })

    for i = 1, #rows do
        local row = rows[i]
        local tableName = row.TABLE_NAME
        local columnName = row.COLUMN_NAME
        local dataType = row.DATA_TYPE
        local collationName = row.COLLATION_NAME
        local characterMaximumLength = row.CHARACTER_MAXIMUM_LENGTH
        local isNullable = row.IS_NULLABLE
        local default = row.COLUMN_DEFAULT
        local isKey = #row.COLUMN_KEY > 0

        if not tables[tableName] then
            tables[tableName] = {}
        end

        tables[tableName][columnName] = {
            type = dataType:upper(),
            collation = collationName,
            allowNull = isNullable == "YES",
            default = default,
            length = characterMaximumLength,
            isKey = isKey,
            keyType = row.COLUMN_KEY:upper()
        }
    end

    return tables
end

FetchTables()

if shouldGenerateTables then
    local luaTable = "local defaultTables = {\n"

    for tableName, columns in pairs(tables) do
        luaTable = ("%s\t%s = {\n"):format(luaTable, tableName)

        for columnName, column in pairs(columns) do
            luaTable = luaTable .. ("\t\t{\n\t\t\tcolumn = \"%s\",\n"):format(columnName)
            luaTable = luaTable .. ("\t\t\ttype = \"%s\",\n"):format(column.type)
            luaTable = luaTable .. ("\t\t\tallowNull = %s,\n"):format(column.allowNull and "true" or "false")
            luaTable = luaTable .. ("\t\t\tisKey = %s,\n"):format(column.isKey and "true" or "false")

            if column.default then
                luaTable = luaTable .. ("\t\t\tdefault = \"%s\",\n"):format(column.default)
            end

            if column.collation then
                luaTable = luaTable .. ("\t\t\tcollation = \"%s\",\n"):format(column.collation)
            end

            if column.length and column.type ~= "LONGTEXT" and column.type ~= "TEXT" then
                luaTable = luaTable .. ("\t\t\tlength = %s,\n"):format(math.floor(column.length))
            end

            luaTable = luaTable .. "\t\t},\n"
        end

        luaTable = luaTable .. "\t},\n"
    end

    luaTable = luaTable .. "}"

    SaveResourceFile(GetCurrentResourceName(), "defaultdb.lua", luaTable, -1)

    DatabaseCheckerFinished = true
    return
end

if not tables.lbtablet_tablets then
    if not Config.DatabaseChecker.AutoFix then
        DatabaseCheckerFinished = true
        return error("Database checker: Missing table lbtablet_tablets. Please run tablet.sql manually using HeidiSQL")
    end

    local SQLFile = LoadResourceFile(GetCurrentResourceName(), "tablet.sql")

    if not SQLFile then
        DatabaseCheckerFinished = true
        return error("Database checker: Failed to load tablet.sql")
    end

    local queries = {}

    for query in SQLFile:gmatch("[^;]+") do
        -- remove comments
        query = query:gsub("%-%-[^\n]*", ""):gsub("/%*.-%*/", ""):gsub("^%s+", ""):gsub("%s+$", "")
        -- remove semicolon
        query = query:sub(1, -1)

        if #query > 0 then
            queries[#queries+1] = query
        end
    end

    if not MySQL.transaction.await(queries) then
        DatabaseCheckerFinished = true
        return error("Database checker: Failed to create tables, please run tablet.sql manually using HeidiSQL")
    else
        infoprint("success", "Database checker: Created tables successfully")
    end

    FetchTables()
end

local fixQueries = {}
local missingTables = {}
local madeChanges = false

local function ValidateOffencesRewrite()
    if tables.lbtablet_police_offences_categories then
        return
    end

    MySQL.rawExecute.await([[
        CREATE TABLE IF NOT EXISTS `lbtablet_police_offences_categories` (
            `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
            `title` VARCHAR(100) NOT NULL,

            PRIMARY KEY (`id`),
            UNIQUE KEY (`title`)
        ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    ]])

    MySQL.rawExecute.await([[
        CREATE TABLE IF NOT EXISTS `lbtablet_police_offences` (
            `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
            `category_id` INT UNSIGNED NOT NULL,
            `class` VARCHAR(100) NOT NULL, -- misdemeanor, felony, etc
            `title` VARCHAR(100) NOT NULL,
            `description` TEXT NOT NULL,
            `fine` INT UNSIGNED NOT NULL DEFAULT 0,
            `jail_time` INT UNSIGNED NOT NULL DEFAULT 0,

            PRIMARY KEY (`id`),
            UNIQUE KEY (`category_id`, `class`, `title`),
            FOREIGN KEY (`category_id`) REFERENCES lbtablet_police_offences(`id`) ON UPDATE CASCADE ON DELETE CASCADE
        ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    ]])

    MySQL.rawExecute.await([[
        DROP TABLE IF EXISTS lbtablet_police_cases_charges
    ]])

    MySQL.rawExecute.await([[
        CREATE TABLE IF NOT EXISTS `lbtablet_police_cases_charges` (
            `case_id` INT UNSIGNED NOT NULL,
            `criminal` VARCHAR(100) NOT NULL,
            `offence_id` INT UNSIGNED NOT NULL,

            PRIMARY KEY (`case_id`, `criminal`, `offence_id`),
            FOREIGN KEY (`case_id`, `criminal`) REFERENCES lbtablet_police_cases_criminals(`case_id`, `id`) ON UPDATE CASCADE ON DELETE CASCADE,
            FOREIGN KEY (`offence_id`) REFERENCES lbtablet_police_offences(`id`) ON UPDATE CASCADE ON DELETE CASCADE
        ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    ]])

    madeChanges = true

    infoprint("info", "Database checker: Added & updated tables for offences rewrite")
end

local function CheckWeaponsTable()
    if tables.lbtablet_police_weapons then
        return
    end

    MySQL.rawExecute([[
        CREATE TABLE IF NOT EXISTS `lbtablet_police_weapons` (
            `serial_number` VARCHAR(100) NOT NULL,

            `owner` VARCHAR(100) DEFAULT NULL,
            `weapon_name` VARCHAR(100) DEFAULT NULL,

            PRIMARY KEY (`serial_number`)
        ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    ]])

    madeChanges = true

    infoprint("info", "Database checker: Added table lbtablet_police_weapons")
end

local function AllowNullJailedBy()
    if not tables.lbtablet_police_jail or tables.lbtablet_police_jail.jailed_by.allowNull then
        return
    end

    MySQL.rawExecute.await("ALTER TABLE `lbtablet_police_jail` MODIFY COLUMN `jailed_by` VARCHAR(100) DEFAULT NULL")
end

local function AddFinedAndJailed()
    if not tables.lbtablet_police_cases_criminals or tables.lbtablet_police_cases_criminals.fined then
        return
    end

    MySQL.rawExecute.await("ALTER TABLE `lbtablet_police_cases_criminals` ADD COLUMN `fined` BOOLEAN NOT NULL DEFAULT FALSE")
    MySQL.rawExecute.await("ALTER TABLE `lbtablet_police_cases_criminals` ADD COLUMN `jailed` BOOLEAN NOT NULL DEFAULT FALSE")

    madeChanges = true
end

local function AddCharges()
    if not tables.lbtablet_police_cases_charges or tables.lbtablet_police_cases_charges.charges then
        return
    end

    MySQL.rawExecute.await("ALTER TABLE `lbtablet_police_cases_charges` ADD COLUMN `charges` TINYINT UNSIGNED NOT NULL DEFAULT 1")

    madeChanges = true

    infoprint("info", "Database checker: Added column charges to lbtablet_police_cases_charges")
end

local function AddLinkedReportsToCases()
    if tables.lbtablet_police_cases_linked_reports then
        return

    end

    MySQL.rawExecute.await([[
        CREATE TABLE IF NOT EXISTS `lbtablet_police_cases_linked_reports` (
            `case_id` INT UNSIGNED NOT NULL,
            `report_id` INT UNSIGNED NOT NULL,

            PRIMARY KEY (`case_id`, `report_id`),
            FOREIGN KEY (`case_id`) REFERENCES lbtablet_police_cases(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
            FOREIGN KEY (`report_id`) REFERENCES lbtablet_police_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE
        ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    ]])

    madeChanges = true

    infoprint("info", "Database checker: Added table lbtablet_police_cases_linked_reports")
end

local function AddPhoneTabTables()
    if tables.lbtablet_police_wiretaps or tables.lbtablet_police_wiretaps_subscribers or tables.lbtablet_police_phone_unlocks then
        return
    end

    MySQL.rawExecute.await([[
        CREATE TABLE IF NOT EXISTS `lbtablet_police_wiretaps` (
            `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the tapped phone
            `creator_tablet_id` VARCHAR(100) NOT NULL, -- the tablet id of the officer who created the wiretap
            `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

            PRIMARY KEY (`phone_number`),
            FOREIGN KEY (`creator_tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
        ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    ]])

    MySQL.rawExecute.await([[
        CREATE TABLE IF NOT EXISTS `lbtablet_police_wiretaps_subscribers` (
            `tablet_id` VARCHAR(100) NOT NULL, -- the tablet id of the officer who subscribed to the wiretap
            `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the tapped phone

            PRIMARY KEY (`tablet_id`, `phone_number`),
            FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
            FOREIGN KEY (`phone_number`) REFERENCES lbtablet_police_wiretaps(`phone_number`) ON UPDATE CASCADE ON DELETE CASCADE
        ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    ]])

    MySQL.rawExecute.await([[
        CREATE TABLE IF NOT EXISTS `lbtablet_police_phone_unlocks` (
            `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the phone to be unlocked
            `attempts` TINYINT UNSIGNED NOT NULL DEFAULT 0, -- the number of attempts used to unlock the phone
            `unlocked` BOOLEAN NOT NULL DEFAULT FALSE, -- whether the phone is unlocked or not
            `finished_at` DATETIME NOT NULL, -- the time when the unlocking process finished

            PRIMARY KEY (`phone_number`)
        ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    ]])

    madeChanges = true
end

if Config.DatabaseChecker.AutoFix then
    ValidateOffencesRewrite()
    CheckWeaponsTable()
    AllowNullJailedBy()
    AddFinedAndJailed()
    AddCharges()
    AddLinkedReportsToCases()
    AddPhoneTabTables()
end

if madeChanges then
    FetchTables()
end

local function GetLastArg(column)
    local lastArg = column.type

    if column.length and column.type ~= "LONGTEXT" and column.type ~= "TEXT" then
        lastArg = lastArg .. ("(%s)"):format(column.length)
    end

    if not column.allowNull then
        lastArg = lastArg .. " NOT NULL"
    end

    if column.default then
        lastArg = lastArg .. (" DEFAULT %s"):format(column.default)
    end

    return lastArg
end

for tableName, columns in pairs(defaultTables) do
    local checkTable = tables[tableName]

    if not checkTable then
        infoprint("error", ("Missing table ^5%s^7 in the database. Please re-run the tablet.sql file."):format(tableName))

        missingTables[#missingTables+1] = tableName

        goto continue
    end

    for i = 1, #columns do
        local defaultColumn = columns[i]
        local column = checkTable[defaultColumn.column]

        if not checkTable[defaultColumn.column] then
            infoprint("warning", ("Missing column ^5%s^7 in the table ^5%s^7."):format(defaultColumn.column, tableName))

            if not defaultColumn.isKey then
                fixQueries[#fixQueries+1] = ("ALTER TABLE `%s` ADD COLUMN `%s` %s"):format(tableName, defaultColumn.column, GetLastArg(defaultColumn))
            else
                infoprint("error", ("Column ^5%s^7 in the table ^5%s^7 is a key and cannot be added automatically. Check the #updates channel for a query to run, or ask in #customer-support"):format(defaultColumn.column, tableName))
            end

            goto continueColumns
        end

        if defaultColumn.type ~= column.type then
            infoprint("warning", ("Column ^5%s^7 in the table ^5%s^7 has the wrong data type."):format(defaultColumn.column, tableName))

            if not defaultColumn.isKey and not column.isKey then
                fixQueries[#fixQueries+1] = ("ALTER TABLE `%s` MODIFY COLUMN `%s` %s"):format(tableName, defaultColumn.column, GetLastArg(defaultColumn))
            else
                infoprint("error", ("Column ^5%s^7 in the table ^5%s^7 is a key and cannot be modified automatically. Check the #updates channel for a query to run, or ask in #customer-support"):format(defaultColumn.column, tableName))
            end

            goto continueColumns
        end

        if defaultColumn.length and defaultColumn.length > column.length then
            infoprint("warning", ("Column ^5%s^7 in the table ^5%s^7 has the wrong length."):format(defaultColumn.column, tableName))

            if not defaultColumn.isKey and not column.isKey then
                fixQueries[#fixQueries+1] = ("ALTER TABLE `%s` MODIFY COLUMN `%s` %s"):format(tableName, defaultColumn.column, GetLastArg(defaultColumn))
            else
                infoprint("error", ("Column ^5%s^7 in the table ^5%s^7 is a key and cannot be modified automatically. Check the #updates channel for a query to run, or ask in #customer-support"):format(defaultColumn.column, tableName))
            end

            goto continueColumns
        end

        if defaultColumn.collation and defaultColumn.collation ~= column.collation then
            infoprint("warning", ("Column ^5%s^7 in the table ^5%s^7 has the wrong collation."):format(defaultColumn.column, tableName))
        end

        ::continueColumns::
    end

    ::continue::
end

local changes = #fixQueries
local missingAnyTables = #missingTables > 0

if changes > 0 then
    if Config.DatabaseChecker.AutoFix then
        infoprint("info", ("Fixing database, applying %i changes..."):format(changes))

        local success = MySQL.transaction.await(fixQueries)

        if success then
            infoprint("success", "Database has been fixed.")
        else
            infoprint("error", "Failed to fix the database.")
        end
    else
        local fixQuery = ""

        for i = 1, #fixQueries do
            fixQuery = fixQuery .. fixQueries[i] .. ";\n"
        end

        SaveResourceFile(GetCurrentResourceName(), "fix.sql", fixQuery, -1)
        infoprint("warning", ("Database has %i changes that need to be fixed. Try running lb-tablet/fix.sql"):format(changes))
    end
end

DatabaseCheckerFinished = true

while (changes > 0 and not Config.DatabaseChecker.AutoFix) or missingAnyTables do
    if changes > 0 and not Config.DatabaseChecker.AutoFix then
        infoprint("warning", ("Database has %i changes that need to be fixed. Try running lb-tablet/fix.sql"):format(changes))
    end

    if missingAnyTables then
        infoprint("error", "The database is missing the table" .. (missingAnyTables == 1 and "s^5 " or "^5 ") ..  table.concat(missingTables, "^7,^5 ") .. "^7. Please re-run the tablet.sql file.")
    end

    Wait(5000)
end
