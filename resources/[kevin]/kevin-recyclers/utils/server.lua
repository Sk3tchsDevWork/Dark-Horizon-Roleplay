local utils = {}

utils.isNearCoords = function(entity, coords)
    local entityCoords = GetEntityCoords(entity)
    local distance = #(entityCoords - coords)
    return distance < 10.0
end

utils.notify = function(data)
    TriggerClientEvent('ox_lib:notify', data.source, data)
end

utils.generateId = function(prefix)
    math.randomseed(os.time())
    local characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local id = ''
    local length = math.random(8, 14)
    for i = 1, length do
        local randomCharcter = math.random(1, #characters)
        id = id .. string.sub(characters, randomCharcter, randomCharcter)
    end

    return id
end

return utils