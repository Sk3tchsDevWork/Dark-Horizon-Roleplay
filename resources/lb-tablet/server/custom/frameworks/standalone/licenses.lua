if Config.Framework ~= "standalone" then
    return
end

---@type { type: string, label: string }[]
local licenses = {
    { type = "driver", label = "Driver's License" },
    { type = "weapon", label = "Weapon License" },
}

---@param licenseType string
---@return string
function GetLicenseLabel(licenseType)
    for i = 1, #licenses do
        if licenses[i].type == licenseType then
            return licenses[i].label
        end
    end

    return licenseType
end

---@param identifier string
---@param licenseType string
---@return boolean
function RevokeLicense(identifier, licenseType)
    local label = GetLicenseLabel(licenseType)

    if not label then
        return false
    end

    MySQL.update.await("DELETE FROM lbtablet_registration_licenses WHERE character_id = ? AND license = ?", { identifier, label })

    return true
end

---@param identifier string
---@param licenseType string
---@return boolean
function AddLicense(identifier, licenseType)
    local label = GetLicenseLabel(licenseType)

    if not label then
        return false
    end

    MySQL.update.await("INSERT INTO lbtablet_registration_licenses (character_id, license) VALUES (?, ?)", { identifier, label })

    return false
end

---@return { label: string, type: string }[]
function GetAllLicenses()
    return licenses
end

local function GetLicenseFromLabel(label)
    for i = 1, #licenses do
        if licenses[i].label == label then
            return licenses[i]
        end
    end
end

---@param identifier string
---@return { type: string, label: string }[]
function GetPlayerLicenses(identifier)
    local playerLicenses = MySQL.query.await("SELECT license FROM lbtablet_registration_licenses WHERE character_id = ?", { identifier })
    local formattedLicenses = {}

    for i = 1, #playerLicenses do
        local license = GetLicenseFromLabel(playerLicenses[i].license)

        if license then
            formattedLicenses[#formattedLicenses+1] = {
                type = license.type,
                label = license.label
            }
        end
    end

    return formattedLicenses
end
