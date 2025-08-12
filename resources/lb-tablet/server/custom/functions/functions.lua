---@param billerIdentifier string
---@param billedIdentifier string
---@param job "police" | "ambulance"
---@param amount number
---@param reason? string
---@return boolean success
function BillPlayer(billerIdentifier, billedIdentifier, job, amount, reason)
    local senderSource = GetSourceFromIdentifier(billerIdentifier)

    if Config.BillingScript == "framework" then
        return FrameworkBillPlayer(billerIdentifier, billedIdentifier, job, amount, reason)
    elseif Config.BillingScript == "vivum" then
        if not senderSource then
            return false
        end

        local playerJob = GetJob(senderSource)

        if not playerJob then
            return false
        end

        local successPromise = promise.new()

        exports["vivum-billing"]:SendInvoice(senderSource, {
            sender = playerJob.name,
            sender_label = playerJob.label,
            recipient = billedIdentifier,
            recipient_label = GetCharacterNameFromIdentifier(billedIdentifier) or "??",
            amount = amount,
            payments_num = 1,
            payments_period = 7,
            summary = reason or playerJob.label
        }, function(res)
            successPromise:resolve(res.status == "OK")
        end)

        return Citizen.Await(successPromise)
    end

    return false
end

---@param source number
---@param job "Police" | "Ambulance"
---@param permission string
---@param permissionType string
---@return boolean
function HasPermission(source, job, permission, permissionType)
    local playerJob = GetJob(source)
    local jobPermissions = Config[job].Permissions[playerJob.name]

    if not playerJob or not jobPermissions then
        return false
    end

    if not jobPermissions[permission] or not jobPermissions[permission][permissionType] then
        infoprint("warning", ("Permission %s.%s does not exist"):format(permission, permissionType))
        return false
    end

    if playerJob.grade >= jobPermissions[permission][permissionType] then
        return true
    end

    if IsAdmin(source) and Config[job].adminPermissions?[permission]?[permissionType] then
        debugprint("Player has permission due to being admin")
        return true
    end

    return false
end

local anyExternalAllowed = false

for _, v in pairs(Config.AllowExternal) do
    if v then
        anyExternalAllowed = true
    end
end

---@param domain string
---@param domains string[]
---@return boolean
local function IsDomainInArray(domain, domains)
    domain = domain:lower()

    for i = 1, #domains do
        local domainToCheck = domains[i]:lower()

        if domain == domainToCheck then
            return true
        end

        local _, dotCount = domainToCheck:gsub("%.", "")

        if dotCount == 1 then
            if domain:match("^[%w-]+%." .. domainToCheck .. "$") then
                return true
            end
        end
    end

    return false
end

---@param link string
---@return boolean
function IsMediaLinkAllowed(link)
    if not Config.UploadWhitelistedDomains or #Config.UploadWhitelistedDomains == 0 then
        return true
    elseif anyExternalAllowed and #Config.ExternalWhitelistedDomains == 0 and #Config.ExternalBlacklistedDomains == 0 then
        return true
    end

    local domain = link:match("([^/?#]+%.[^/?#]+)")

    if not domain then
        debugprint("IsMediaLinkAllowed: Failed to extract domain from:", link)
        return false
    end

    if not anyExternalAllowed then
        return IsDomainInArray(domain, Config.UploadWhitelistedDomains)
    elseif #Config.ExternalBlacklistedDomains > 0 and IsDomainInArray(domain, Config.ExternalBlacklistedDomains) then
        return false
    elseif #Config.ExternalWhitelistedDomains > 0 and not IsDomainInArray(domain, Config.ExternalWhitelistedDomains) then
        return false
    end

    return true
end

local charsetsToCollation = {
    ["UTF8MB4"] = "COLLATE UTF8MB4_UNICODE_CI",
    ["UTF8MB3"] = "COLLATE UTF8MB3_UNICODE_CI",
}

---@param tables { [string]: string }
---@return { [string]: string }
function GetCollationsForTables(tables)
    local collations = {}
    local databaseInfo = MySQL.single.await("SELECT DATABASE() AS `name`, VERSION() as `version`")

    for tableName, _ in pairs(tables) do
        collations[tableName] = ""
    end

    if not databaseInfo or not databaseInfo.name or not databaseInfo.version then
        return collations
    end

    if not databaseInfo.version:find("MariaDB") then
        return collations
    end

    local major, minor, patch = databaseInfo.version:match("(%d+)%.(%d+)%.(%d+)")

    major = major and tonumber(major)
    minor = minor and tonumber(minor)
    patch = patch and tonumber(patch)

    if not major or not minor or not patch then
        return collations
    end

    if major < 10 or (major == 10 and minor < 11) then
        return collations
    end

    local function GetCharset(tableName, columnName)
        local charset = MySQL.scalar.await([[
            SELECT
                CHARACTER_SET_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE
                TABLE_SCHEMA = ?
                AND TABLE_NAME = ?
                AND COLUMN_NAME = ?
        ]], { databaseInfo.name, tableName, columnName }) or "utf8mb4"

        return string.upper(charset)
    end

    for tableName, column in pairs(tables) do
        local charset = GetCharset(tableName, column)

        if charsetsToCollation[charset] then
            collations[tableName] = charsetsToCollation[charset]
        else
            debugprint("Unknown charset for " .. tableName, "table:", charset)
        end
    end

    return collations
end

local oxLibRequests = {}

RegisterNetEvent("__ox_cb_lb-tablet", function(requestId, ...)
    local promise = oxLibRequests[requestId]

    if not promise then
        return
    end

    oxLibRequests[requestId] = nil
    promise:resolve(...)
end)

function TriggerClientOXLibCallback(callbackName, source, ...)
    local requestId = GenerateString(15)
    local promise = promise.new()

    oxLibRequests[requestId] = promise

    TriggerClientEvent("__ox_cb_" .. callbackName, source, "lb-tablet", requestId, ...)

    SetTimeout(60000, function()
        if oxLibRequests[requestId] then
            oxLibRequests[requestId]:reject("Request timed out")
            oxLibRequests[requestId] = nil
        end
    end)

    return promise
end

---@param source number
function HasTabletItem(source)
    if not Config.Item.Require then
        return true
    end

    return HasItem(source, Config.Item.Name)
end

---@param source number
---@param uploadType "Audio" | "Image" | "Video"
---@return string? presignedUrl
function GetPresignedUrl(source, uploadType)
    local apiKey = API_KEYS[uploadType]

    infoprint("warning", "GetPresignedUrl has not been set up. Set it up in lb-tablet/server/custom/functions/functions.lua, or change your upload method to Fivemanage.")
end

---@param mdtType "police" | "ambulance"
---@param profileType "user" | "vehicle"
---@param id any
---@return { [string]: any }
function GetCustomFields(mdtType, profileType, id)
    return {}
end

---@param source number
---@param phoneNumber string
function CanWiretapNumber(source, phoneNumber)
    return true
end
