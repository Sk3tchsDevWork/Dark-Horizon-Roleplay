local tabletDisconnectCallbacks = {}

---@param cb fun(tabletId: string, source: number)
function OnTabletDisconnect(cb)
    assert(type(cb) == "function", "Invalid argument #1 (function expected), got: " .. type(cb))

    tabletDisconnectCallbacks[#tabletDisconnectCallbacks+1] = cb
end

local playerDisconnectCallbacks = {}

---@param cb fun(source: number)
function OnPlayerDisconnect(cb)
    assert(type(cb) == "function", "Invalid argument #1 (function expected), got: " .. type(cb))

    playerDisconnectCallbacks[#playerDisconnectCallbacks+1] = cb
end

---@param source number
function PlayerLoggedOut(source)
    local tabletId = GetEquippedTablet(source)

    if tabletId then
        for i = 1, #tabletDisconnectCallbacks do
            Citizen.CreateThreadNow(function()
                tabletDisconnectCallbacks[i](tabletId, source)
            end)
        end
    end

    for i = 1, #playerDisconnectCallbacks do
        Citizen.CreateThreadNow(function()
            playerDisconnectCallbacks[i](source)
        end)
    end
end

AddEventHandler("playerDropped", function()
    PlayerLoggedOut(source)
end)
