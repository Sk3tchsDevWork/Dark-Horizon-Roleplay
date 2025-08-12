local points = {}
local busy = false

for k, v in pairs(Config.PCs) do
    points[#points+1] = lib.points.new({
        coords = v['coords'],
        serial = k,
        canUse = v['canUse'],
        label = Lang['open_pc'],
        distance = 2
    })
end

for k, v in pairs(points) do
    function v:onExit()
        if lib.isTextUIOpen() then
            lib.hideTextUI()
        end
    end     
    function v:nearby()
        if self.currentDistance <= 1.5 then
            if not lib.isTextUIOpen() then
                lib.showTextUI(self.label)
            end
            if IsControlJustPressed(0,38) and not busy then
                busy = true
                if self.canUse() then
                    TriggerEvent("av_laptop:openPC", self.serial)
                else
                    TriggerEvent('av_laptop:notification', Lang['pc_title'], Lang['no_permissions'], 'error')
                end
                CreateThread(function()
                    Wait(3000)
                    busy = false
                end)
            end
        end
    end
end