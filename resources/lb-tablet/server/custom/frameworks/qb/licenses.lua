if Config.Framework ~= "qb" then
    return
end

while not QB do
    Wait(0)
end

local licenses = {
    {
        label = "Driver's License",
        type = "driver"
    },
    {
        label = "Weapon License",
        type = "weapon"
    }
}

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
    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)

    if qPlayer then
        qPlayer.PlayerData.metadata.licences[licenseType] = false
        qPlayer.Functions.SetMetaData("licences", qPlayer.PlayerData.metadata.licences)

        return true
    end

    local metadata = MySQL.scalar.await("SELECT metadata FROM players WHERE citizenid = ?", { identifier })

    if not metadata then
        debugprint("RevokeLicense: no metadata")
        return false
    end

    metadata = json.decode(metadata)
    metadata.licences = metadata.licences or {}
    metadata.licences[licenseType] = false

    return MySQL.update.await("UPDATE players SET metadata = ? WHERE citizenid = ?", { json.encode(metadata), identifier }) > 0
end

---@param identifier string
---@param licenseType string
---@return boolean
function AddLicense(identifier, licenseType)
    if not DoesLicenseExist(licenseType) then
        return false
    end

    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)

    if qPlayer then
        qPlayer.PlayerData.metadata.licences[licenseType] = true
        qPlayer.Functions.SetMetaData("licences", qPlayer.PlayerData.metadata.licences)
        return true
    end

    local metadata = MySQL.scalar.await("SELECT metadata FROM players WHERE citizenid = ?", { identifier })

    if not metadata then
        return false
    end

    metadata = json.decode(metadata)
    metadata.licences = metadata.licences or {}
    metadata.licences[licenseType] = true

    return MySQL.update.await("UPDATE players SET metadata = ? WHERE citizenid = ?", { json.encode(metadata), identifier }) > 0
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
    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)
    local cleanedLicenses = {}
    local playerLicenses

    if qPlayer then
        playerLicenses = qPlayer.PlayerData.metadata.licences or {}
    else
        local metadata = MySQL.scalar.await("SELECT metadata FROM players WHERE citizenid = ?", { identifier })

        metadata = metadata and json.decode(metadata)
        playerLicenses = metadata?.licences or {}
    end

    for licenseType, hasLicense in pairs(playerLicenses) do
        if hasLicense then
            cleanedLicenses[#cleanedLicenses+1] = {
                type = licenseType,
                label = GetLicenseLabel(licenseType)
            }
        end
    end

    return cleanedLicenses
end
