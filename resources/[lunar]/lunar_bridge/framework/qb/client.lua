---@diagnostic disable: duplicate-set-field
---@diagnostic disable: duplicate-doc-field

if GetResourceState('qb-core') ~= 'started' then return end

Framework = { name = 'qb-core' }
local sharedObject = exports['qb-core']:GetCoreObject()
Framework.object = sharedObject

local codemInventory = GetResourceState('codem-inventory') == 'started'

function Framework.isPlayerLoaded()
    return next(sharedObject.Functions.GetPlayerData()) ~= nil
end

Framework.onPlayerLoaded = function(cb)
    if Framework.isPlayerLoaded() then
        cb()
    end

    AddEventHandler('QBCore:Client:OnPlayerLoaded', cb)
end

Framework.onPlayerLogout = function(cb)
    AddEventHandler('QBCore:Client:OnPlayerUnload', cb)
end

function Framework.getJob()
    if not Framework.isPlayerLoaded() then
        return false
    end

    return sharedObject.Functions.GetPlayerData().job.name
end

function Framework.getJobGrade()
    return sharedObject.Functions.GetPlayerData().job.grade.level
end

Framework.hasItem = function(name)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:GetItemCount(name) > 0
    end

    if codemInventory then
        local inventory = exports['codem-inventory']:GetClientPlayerInventory()

        -- return early when not loaded yet
        if not inventory or type(inventory) ~= "table" then
            return false
        end

        for _, v in pairs(inventory) do
            if v.name == name then
                return true
            end
        end
    
        return false
    end

    return sharedObject.Functions.HasItem(name)
end

Framework.getInventory = function()
    if codemInventory then
        return exports['codem-inventory']:GetClientPlayerInventory()
    end

    return sharedObject.Functions.GetPlayerData().items
end

function Framework.spawnVehicle(model, coords, heading, cb)
    sharedObject.Functions.SpawnVehicle(model, cb, vector4(coords.x, coords.y, coords.z, heading), true)
end

function Framework.spawnLocalVehicle(model, coords, heading, cb)
    sharedObject.Functions.SpawnVehicle(model, cb, vector4(coords.x, coords.y, coords.z, heading), false)
end

Framework.getIdentifier = function()
    local playerData = sharedObject.Functions.GetPlayerData()
    return playerData.citizenid
end

Framework.getCharacterName = function()
    local playerData = sharedObject.Functions.GetPlayerData()
    return playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname
end

Framework.deleteVehicle = sharedObject.Functions.DeleteVehicle

Framework.getPlayersInArea = sharedObject.Functions.GetPlayersFromCoords