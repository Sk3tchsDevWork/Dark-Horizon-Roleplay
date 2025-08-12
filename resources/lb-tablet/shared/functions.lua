IS_BETA_VERSION = GetResourceMetadata(GetCurrentResourceName(), "beta", 0) == "yes"

local tabletVersion = (GetResourceMetadata(GetCurrentResourceName(), "version", 0) or "") .. (IS_BETA_VERSION and "-b" or "")

---@param t table
---@param value any
function table.contains(t, value)
    for i = 1, #t do
        if t[i] == value then
            return true
        end
    end

    return false
end

---@param length? integer
function GenerateString(length)
    length = length or 5
    local result = table.create(length, 0)

    for i = 1, length do
        local character = string.char(math.random(97, 122))

        if math.random(1, 2) == 1 then
            character = string.upper(character)
        end

        result[i] = character
    end

    return table.concat(result)
end

local randomCharacters = { "1", "A", "a" }

---`1` - a random didigt 0-9<br>
---`A` - a random uppercase letter A-Z<br>
---`a` - a random lowercase letter a-z<br>
---`.` - a random letter or digit<br>
---`^` - escape character<br>
---@param pattern string
function GenerateStringFromPattern(pattern)
    local result = table.create(#pattern, 0)
    local amount = 0
    local i = 1

    while i <= #pattern do
        local character = pattern:sub(i, i)
        amount += 1

        if character == "." then
            character = randomCharacters[math.random(1, #randomCharacters)]
        end

        if character == '1' then
            result[amount] = tostring(math.random(0, 9))
        elseif character == 'A' then
            result[amount] = string.char(math.random(65, 90))
        elseif character == 'a' then
            result[amount] = string.char(math.random(97, 122))
        elseif character == '^' and i < #pattern then
            -- Handle escape character - literally match next character
            i += 1
            result[amount] = pattern:sub(i, i)
        else
            result[amount] = character
        end

        i += 1
    end

    return table.concat(result)
end

---@param resource string
function IsResourceStartedOrStarting(resource)
    local state = GetResourceState(resource)

    return state == "started" or state == "starting"
end

function debugprint(...)
    if not Config.Debug then
        return
    end

    local data = { ... }
    local length = #data
    local str = ""

    for i = 1, length do
        if type(data[i]) == "table" then
            str = str .. json.encode(data[i], { indent = true })
        elseif type(data[i]) ~= "string" then
            str = str .. tostring(data[i])
        else
            str = str .. data[i]
        end

        if i ~= length then
            str = str .. " "
        end
    end

    print("^6[LB Tablet " .. tabletVersion .. "] ^5[Debug]^7: " .. str)
end

local infoLevels = {
    success = "^2[SUCCESS]",
    info = "^5[INFO]",
    warning = "^3[WARNING]",
    error = "^1[ERROR]"
}

---@param level "success" | "info" | "warning" | "error"
---@param text string
function infoprint(level, text, ...)
    local prefix = infoLevels[level]

    if not prefix then
        prefix = "^5[INFO]^7:"
    end

    print("^6[LB Tablet " .. tabletVersion .. "] " .. prefix .. "^7: " .. text, ...)
end

if Config.LBPhone == "auto" then
    Config.LBPhone = IsResourceStartedOrStarting("lb-phone")
elseif Config.LBPhone ~= true then
    Config.LBPhone = false
end

if not Config.Item.Inventory or Config.Item.Inventory == "auto" then
    if IsResourceStartedOrStarting("ox_inventory") then
        Config.Item.Inventory = "ox_inventory"
    elseif IsResourceStartedOrStarting("ps-inventory") then
        Config.Item.Inventory = "ps-inventory"
    end
end

if Config.Framework == "auto" then
    debugprint("Detecting framework")

    if IsResourceStartedOrStarting("es_extended") then
        Config.Framework = "esx"
    elseif IsResourceStartedOrStarting("qbx_core") then
        Config.Framework = "qbox"
    elseif IsResourceStartedOrStarting("qb-core") then
        Config.Framework = "qb"
    else
        Config.Framework = "standalone"
    end

    debugprint("Detected framework: " .. Config.Framework)
end

if Config.RegistrationApp == "auto" then
    Config.RegistrationApp = Config.Framework == "standalone"
end

if Config.JailScript == "auto" then
    debugprint("Detecting jail script")

    if IsResourceStartedOrStarting("esx-qalle-jail") then
        Config.JailScript = "qalle"
    elseif IsResourceStartedOrStarting("esx_jail") then
        Config.JailScript = "esx"
    elseif IsResourceStartedOrStarting("pickle_prisons") then
        Config.JailScript = "pickle"
    elseif IsResourceStartedOrStarting("qb-prison") then
        Config.JailScript = "qb"
    elseif IsResourceStartedOrStarting("xt-prison") then
        Config.JailScript = "xt"
    elseif IsResourceStartedOrStarting("qbx_prison") then
        Config.JailScript = "qbox"
    elseif IsResourceStartedOrStarting("rcore_prison") then
        Config.JailScript = "rcore"
    else
        Config.JailScript = false
    end

    if Config.JailScript then
        debugprint("Detected jail script: " .. Config.JailScript)
    else
        infoprint("warning", "No jail script detected")
    end
end

if Config.HousingScript == "auto" then
    Config.HousingScript = false

    debugprint("Detecting housing script")

    local housingScripts = {
        "loaf_housing",
        "qb-houses",
        "qs-housing"
    }

    for i = 1, #housingScripts do
        local script = housingScripts[i]

        if IsResourceStartedOrStarting(script) then
            Config.HousingScript = script
            debugprint("Detected housing script: " .. script)
            break
        end
    end

    if not Config.HousingScript then
        debugprint("No housing script detected")
    end
end

if Config.DobFormat == "auto" then
    debugprint("Setting date of birth format")

    if Config.Framework == "qb" then
        Config.DobFormat = "YYYY-MM-DD"
        debugprint("Framework is set to QB, set date of birth format to: " .. Config.DobFormat)
    elseif Config.Framework == "qbox" then
        Config.DobFormat = "YYYY-MM-DD"
        debugprint("Framework is set to QBox, set date of birth format to: " .. Config.DobFormat)
    elseif Config.Framework == "esx" then
        Config.DobFormat = "DD/MM/YYYY"
        debugprint("Framework is set to ESX, set date of birth format to: " .. Config.DobFormat)
    else
        Config.DobFormat = "DD/MM/YYYY"
    end

    debugprint("Date of birth format: " .. Config.DobFormat)
end

if Config.BillingScript == "auto" then
    debugprint("Detecting billing script")

    if IsResourceStartedOrStarting("vivum-billing") then
        Config.BillingScript = "vivum"
    else
        Config.BillingScript = "framework"
    end

    debugprint("Detected billing script:", Config.BillingScript)
end

---@param locales table
local function GenerateLocales(locales)
    local tempLocals = {}

    local function FormatLocales(localeTable, prefix)
        for k, v in pairs(localeTable) do
            if type(v) == "table" then
                FormatLocales(v, prefix .. k .. ".")
            else
                tempLocals[prefix .. k] = v
            end
        end
    end

    FormatLocales(locales, "")
    return tempLocals
end

---@param locale string
local function LoadLocales(locale)
    local fileContent = LoadResourceFile(GetCurrentResourceName(), "config/locales/" .. locale .. ".json")

    if not fileContent then
        infoprint("error", "Invalid locale '" .. locale .. "' (file not found)")
        return {}
    end

    local decoded = json.decode(fileContent)

    if not decoded then
        infoprint("error", "Invalid locale '" .. locale .. "' (error in file)")
        return {}
    end

    return GenerateLocales(decoded)
end

local locales = LoadLocales(Config.DefaultLocale or "en")
local defaultLocales = Config.DefaultLocale ~= "en" and LoadLocales("en") or {}

---@param input string
---@param variables table<string, string>[]
function FormatString(input, variables)
    assert(type(input) == "string", "input must be a string")
    assert(type(variables) == "table", "variables must be a table")

    for k, v in pairs(variables) do
        local safeValue = tostring(v):gsub("%%", "%%%%")

        input = input:gsub("{" .. k .. "}", safeValue)
    end

    return input
end

---@param path string
---@param args? table
function L(path, args)
    assert(type(path) == "string", "path must be a string")

    local translation = locales[path] or defaultLocales[path] or path

    if args then
        translation = FormatString(translation, args)
    end

    return translation
end

---@param text string
function IsStringOnlyNumbers(text)
    return string.match(text:gsub("%s+", ""), "^[0-9]+$") ~= nil
end

---@param value number
---@param min number
---@param max number
function clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    end

    return value
end

---@param t table
---@param element any
---@return boolean
---@return any?
function contains(t, element)
    for key, value in pairs(t) do
        if value == element then
            return true, key
        end
    end

    return false
end

local magicCharacters = { "(", ")", ".", "%", "+", "-", "*", "?", "[", "^", "$" }

---@param pattern string
function GetStringMatchPattern(pattern)
    local result = {}
    local i = 1

    while i <= #pattern do
        local c = pattern:sub(i, i)

        if c == '^' and i < #pattern then
            i += 1
            local nextCharacter = pattern:sub(i, i)

            if contains(magicCharacters, nextCharacter) then
                result[#result + 1] = "%" .. nextCharacter
            else
                result[#result + 1] = nextCharacter
            end
        elseif c == '1' then
            result[#result + 1] = "%d"
        elseif c == 'A' then
            result[#result + 1] = "[A-Z]"
        elseif c == 'a' then
            result[#result + 1] = "[a-z]"
        elseif c == '.' then
            result[#result + 1] = "[%w]"
        elseif contains(magicCharacters, c) then
            result[#result + 1] = "%" .. c
        else
            result[#result + 1] = c
        end

        i = i + 1
    end

    return "^" .. table.concat(result) .. "$"
end

if Config.Genders == "auto" then
    if Config.Framework == "esx" then
        Config.Genders = {
            {
                label = L("MISC.GENDERS.MALE"),
                value = "m"
            },
            {
                label = L("MISC.GENDERS.FEMALE"),
                value = "f"
            }
        }
    elseif Config.Framework == "qb" or Config.Framework == "qbox" then
        Config.Genders = {
            {
                label = L("MISC.GENDERS.MALE"),
                value = 0
            },
            {
                label = L("MISC.GENDERS.FEMALE"),
                value = 1
            }
        }
    else
        Config.Genders = {
            {
                label = L("MISC.GENDERS.MALE"),
                value = 1
            },
            {
                label = L("MISC.GENDERS.FEMALE"),
                value = 0
            }
        }
    end
end

local lbPhoneConfig

---@return table
function GetPhoneConfig()
    if lbPhoneConfig then
        return lbPhoneConfig
    elseif Config.LBPhone then
        lbPhoneConfig = exports["lb-phone"]:GetConfig()
    end

    return lbPhoneConfig or {}
end

local cellTowers

---@return vector3[]
function GetCellTowers()
    if cellTowers then
        return cellTowers
    elseif Config.LBPhone then
        cellTowers = exports["lb-phone"]:GetCellTowers()
    end

    return cellTowers or {}
end

local intervals = {}

---@param cb function
---@param interval? integer
function SetInterval(cb, interval)
    local id
    interval = interval or 0

    Citizen.CreateThreadNow(function(ref)
        id = ref
        intervals[id] = true

        while intervals[id] do
            cb()
            Wait(interval)
        end

        intervals[id] = nil
    end)

    return id
end

function ClearInterval(id)
    if intervals[id] then
        intervals[id] = nil
    end
end

---@param resource string
---@param export string
---@param handler function
function AddCompatibilityExport(resource, export, handler)
    AddEventHandler(("__cfx_export_%s_%s"):format(resource, export), function(cb)
        cb(handler)
    end)
end
