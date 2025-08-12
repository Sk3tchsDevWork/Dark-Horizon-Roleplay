if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
end

---@type { type: string, label: string }[]
local licenses

MySQL.ready(function()
    licenses = MySQL.query.await("SELECT `type`, label FROM licenses")
end)

---@param licenseType string
---@return boolean
local function DoesLicenseExist(licenseType)
    for i = 1, #licenses do
        if licenses[i].type == licenseType then
            return true
        end
    end

    return false
end

---@param identifier string
---@param licenseType string
---@return boolean
function RevokeLicense(identifier, licenseType)
    if not DoesLicenseExist(licenseType) then
        return false
    end

    return MySQL.update.await("DELETE FROM user_licenses WHERE owner = ? AND `type` = ?", { identifier, licenseType }) > 0
end

---@param identifier string
---@param licenseType string
---@return boolean
function AddLicense(identifier, licenseType)
    if not DoesLicenseExist(licenseType) then
        return false
    end

    return MySQL.update.await("INSERT INTO user_licenses (owner, `type`) VALUES (?, ?)", { identifier, licenseType }) > 0
end

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

---@return { label: string, type: string }[]
function GetAllLicenses()
    return licenses
end

---@param identifier string
---@return { type: string, label: string }[]
function GetPlayerLicenses(identifier)
    local playerLicenses = MySQL.query.await("SELECT `type` FROM user_licenses WHERE owner = ?", { identifier })

    for i = 1, #playerLicenses do
        local license = playerLicenses[i]

        license.label = GetLicenseLabel(license.type)
    end

    return playerLicenses
end
