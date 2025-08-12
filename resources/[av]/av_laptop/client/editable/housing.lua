function insideHouse()
    -- verify if player is inside a house, return true/false
    -- if player is inside house it will block him from buying a lab in av_gangs
    if GetResourceState("origen_housing") == "started" then
        return exports['origen_housing']:insideHouse()
    end
    if GetResourceState("qs-housing") == "started" then
        return exports['qs-housing']:getCurrentHouse()
    end
    if GetResourceState("ps-housing") == "started" then
        if Config.Framework == "qbox" then
            if QBX.PlayerData.metadata then
                local insideMeta = QBX.PlayerData.metadata and QBX.PlayerData.metadata['inside'] or false
                if insideMeta and insideMeta.property_id then return true end
            end
        else
            local PlayerData = Core.Functions.GetPlayerData()
            local insideMeta = PlayerData.metadata["inside"]
            if insideMeta and insideMeta.property_id then return true end
        end
    end
    if GetResourceState("qb-houses") == "started" then
        if Config.Framework == "qbox" then
            if QBX and QBX.PlayerData then
                return QBX.PlayerData.metadata and QBX.PlayerData.metadata['currentPropertyId'] or false
            end
        else
            local PlayerData = Core.Functions.GetPlayerData()
            local insideMeta = PlayerData.metadata["inside"]
            if insideMeta and insideMeta.house then return true end
        end
    end
    if GetResourceState("qbx_properties") == "started" then
        if QBX.PlayerData.metadata then
            return QBX.PlayerData.metadata and QBX.PlayerData.metadata['currentPropertyId'] or false
        end
    end
    return false
end

exports("insideHouse", insideHouse)