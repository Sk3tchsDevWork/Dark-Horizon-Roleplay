--  $$$$$$\  $$$$$$$$\ $$$$$$$$\       $$$$$$$\   $$$$$$\ $$$$$$$$\  $$$$$$\
-- $$  __$$\ $$  _____|\__$$  __|      $$  __$$\ $$  __$$\\__$$  __|$$  __$$\
-- $$ /  \__|$$ |         $$ |         $$ |  $$ |$$ /  $$ |  $$ |   $$ /  $$ |
-- $$ |$$$$\ $$$$$\       $$ |         $$ |  $$ |$$$$$$$$ |  $$ |   $$$$$$$$ |
-- $$ |\_$$ |$$  __|      $$ |         $$ |  $$ |$$  __$$ |  $$ |   $$  __$$ |
-- $$ |  $$ |$$ |         $$ |         $$ |  $$ |$$ |  $$ |  $$ |   $$ |  $$ |
-- \$$$$$$  |$$$$$$$$\    $$ |         $$$$$$$  |$$ |  $$ |  $$ |   $$ |  $$ |
--  \______/ \________|   \__|         \_______/ \__|  \__|  \__|   \__|  \__|

function getPersonalData(playerID, xPlayer)
    if Config.Framework == "qb" then
        local result =
            SqlFunc(
            Config.Mysql,
            "fetchAll",
            "SELECT * FROM users WHERE identifier = @identifier",
            {
                ["@identifier"] = xPlayer.identifier
            }
        )[1]

        return {
            name = result.firstname,
            lastname = result.lastname,
            birthday = result.dateofbirth,
            gender = result.sex,
            state = "Los Santos",
            identity = result.identifier,
            job = xPlayer.job.name,
            jobgrade = xPlayer.job.grade
        }
    else
        local player = QBCore.Functions.GetPlayer(playerID)
        local charinfo = player.PlayerData.charinfo
        local job = player.PlayerData.job

        return {
            name = charinfo.firstname,
            lastname = charinfo.lastname,
            birthday = charinfo.birthdate,
            gender = charinfo.gender,
            state = charinfo.nationality,
            identity = player.PlayerData.citizenid,
            job = job.name,
            jobgrade = job.grade.name
        }
    end
end

--  $$$$$$\  $$$$$$\ $$\    $$\ $$$$$$$$\       $$$$$$\ $$$$$$$$\ $$$$$$$$\ $$\      $$\
-- $$  __$$\ \_$$  _|$$ |   $$ |$$  _____|      \_$$  _|\__$$  __|$$  _____|$$$\    $$$ |
-- $$ /  \__|  $$ |  $$ |   $$ |$$ |              $$ |     $$ |   $$ |      $$$$\  $$$$ |
-- $$ |$$$$\   $$ |  \$$\  $$  |$$$$$\            $$ |     $$ |   $$$$$\    $$\$$\$$ $$ |
-- $$ |\_$$ |  $$ |   \$$\$$  / $$  __|           $$ |     $$ |   $$  __|   $$ \$$$  $$ |
-- $$ |  $$ |  $$ |    \$$$  /  $$ |              $$ |     $$ |   $$ |      $$ |\$  /$$ |
-- \$$$$$$  |$$$$$$\    \$  /   $$$$$$$$\       $$$$$$\    $$ |   $$$$$$$$\ $$ | \_/ $$ |
--  \______/ \______|    \_/    \________|      \______|   \__|   \________|\__|     \__|

function giveItem(playerID, xPlayer, license, identifier)
    if Config.Framework == "esx" then
        exports.ox_inventory:AddItem(
            playerID,
            "license_" .. license,
            1,
            {
                license = license,
                identifier = identifier
            }
        )
    else
        local info = {}
        info.identifier = identifier
        info.license = license
        xPlayer.Functions.AddItem("license_" .. license, 1, nil, info)
        TriggerClientEvent("inventory:client:ItemBox", playerID, QBCore.Shared.Items["license_" .. license], "add")
    end
end

-- $$\   $$\  $$$$$$\  $$$$$$$$\  $$$$$$\  $$$$$$$\  $$\       $$$$$$$$\
-- $$ |  $$ |$$  __$$\ $$  _____|$$  __$$\ $$  __$$\ $$ |      $$  _____|
-- $$ |  $$ |$$ /  \__|$$ |      $$ /  $$ |$$ |  $$ |$$ |      $$ |
-- $$ |  $$ |\$$$$$$\  $$$$$\    $$$$$$$$ |$$$$$$$\ |$$ |      $$$$$\
-- $$ |  $$ | \____$$\ $$  __|   $$  __$$ |$$  __$$\ $$ |      $$  __|
-- $$ |  $$ |$$\   $$ |$$ |      $$ |  $$ |$$ |  $$ |$$ |      $$ |
-- \$$$$$$  |\$$$$$$  |$$$$$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$\ $$$$$$$$\
--  \______/  \______/ \________|\__|  \__|\_______/ \________|\________|

local licenses = {
    "taxi",
    "driving",
    "ems",
    "fire",
    "fishing",
    "hunting",
    "idcard",
    "lspd",
    "lssd",
    "press",
    "weapon"
}
function UseableItem(source, item)
    local identifier = nil
    local licensetype = nil
    if item.info ~= nil then
        identifier = item.info.identifier
        licensetype = item.info.license
    elseif item.identifier ~= nil then
        identifier = item.identifier
        licensetype = item.license
    end
    local license, data, userInfo, img = CheckLicenseByIdentifierSmall(identifier, licensetype)
    if not license or not data then
        print("No license found")
        return
    end
    local vehicles = nil
    if data ~= true then
        vehicles = data.type
    end
    TriggerClientEvent("bit-licenses:viewOtherLicense", source, license, vehicles, userInfo, img)
end

if Config.Framework == "esx" then
    for _, name in ipairs(licenses) do
        ESX.RegisterUsableItem(
            "license_" .. name,
            function(source)
                local inventory = exports.oxinventory:GetInventory(source)
                for _, item in pairs(inventory.items) do
                    if item.name == "license" .. name then
                        UseableItem(source, item.metadata or {})
                        break
                    end
                end
            end
        )
    end
else
    for _, name in ipairs(licenses) do
        QBCore.Functions.CreateUseableItem(
            "license_" .. name,
            function(source, item)
                UseableItem(source, item)
            end
        )
    end
end
