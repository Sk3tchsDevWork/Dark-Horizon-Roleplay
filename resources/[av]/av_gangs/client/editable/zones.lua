local points = {}
local busyPoint = false
local hideUI = false

function registerZones(data)
    for k, v in pairs(data) do
        points[#points+1] = lib.points.new({
            coords = {x = v['entry']['x'], y = v['entry']['y'], z = v['entry']['z']},
            distance = 2,
            gang = v['gang'],
            identifier = v['identifier'],
            type = v['type'],
            isOpen = v['isOpen'] or false,
        })
    end
    refreshZones()
end

function refreshZones()
    for k, v in pairs(points) do
        function v:nearby()
            if self.currentDistance <= 2 and not busyPoint then
                if not lib.isTextUIOpen() and not hideUI then
                    lib.showTextUI(Lang['door_text'])
                end
                if IsControlJustReleased(0, 38) then
                    if lib.isTextUIOpen() then
                        hideUI = true
                        lib.hideTextUI()
                    end
                    busyPoint = true
                    doorOptions(self.identifier, self.type, self.gang, self.isOpen)
                    CreateThread(function() -- prevents spam
                        Wait(3000)
                        busyPoint = false
                        hideUI = false
                    end)
                end
            end
        end
        function v:onExit()
            hideUI = false
            if lib.isTextUIOpen() then
                lib.hideTextUI()
            end
        end
    end
end

function isCloseToProperty()
    local myCoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(points) do
        local dist = #(myCoords - v['coords'])
        if dist <= Config.PropertyDistance then
            return true
        end
    end
end

function wipeZones(gang)
    local isClose = isCloseToProperty()
    for k, v in pairs(points) do
        if v['gang'] == gang then
            v:remove()
            table.remove(points, k)
        end
    end
    refreshZones()
    Wait(250)
    if isClose and lib.isTextUIOpen() then
        hideUI = false
        lib.hideTextUI()
    end
end

RegisterNetEvent('av_gangs:newZone', function(data)
    points[#points+1] = lib.points.new({
        coords = {x = data['entry']['x'], y = data['entry']['y'], z = data['entry']['z']},
        distance = 2,
        gang = data['gang'],
        identifier = data['identifier'],
        type = data['type'],
        isOpen = data['isOpen'] or false,
    })
    refreshZones()
end)

RegisterNetEvent('av_gangs:deleteZone', function(identifier)
    local isClose = isCloseToProperty()
    for k, v in pairs(points) do
        if v['identifier'] == identifier then
            v:remove()
            table.remove(points, k)
            break
        end
    end
    refreshZones()
    Wait(250)
    if isClose and lib.isTextUIOpen() then
        hideUI = false
        lib.hideTextUI()
    end
end)