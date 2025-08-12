if not Config.RegistrationApp then
    return
end

local cachedLicenses

local function GetLicenses()
    if cachedLicenses then
        return cachedLicenses
    end

    return AwaitCallback("registration:getLicenses")
end

ReactCallback("Registration", function(data)
    local action = data.action

    if action == "getCharacters" then
        return AwaitCallback("registration:getCharacters", data.data)
    elseif action == "saveCharacter" then
        return AwaitCallback("registration:saveCharacter", data.data)
    elseif action == "deleteCharacter" then
        return AwaitCallback("registration:deleteCharacter", data.id)
    end

    if action == "addProperty" then
        return AwaitCallback("registration:addProperty", data.id, data.data)
    elseif action == "deleteProperty" then
        return AwaitCallback("registration:deleteProperty", data.id, data.data)
    end

    if action == "saveVehicle" then
        return AwaitCallback("registration:saveVehicle", data.id, data.data)
    elseif action == "deleteVehicle" then
        return AwaitCallback("registration:deleteVehicle", data.characterId, data.vehicleId)
    end

    if action == "addLicense" then
        return AwaitCallback("registration:addLicense", data.id, data.license)
    elseif action == "deleteLicense" then
        return AwaitCallback("registration:deleteLicense", data.id, data.license)
    elseif action == "getLicenses" then
        return GetLicenses()
    end
end)
