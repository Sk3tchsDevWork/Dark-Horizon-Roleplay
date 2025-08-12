local graffitiBlips = {}
local showBlips = Config.ShowTerritoriesByDefault

RegisterCommand(Config.BlipsCommand, function()
    if not PlayerGang then return end
    showBlips = not showBlips
    SetBlips()
    if showBlips then
        TriggerEvent('av_laptop:notification', Lang['app_title'], Lang['blips_enabled'], 'success')
    else
        TriggerEvent('av_laptop:notification', Lang['app_title'], Lang['blips_disabled'], 'error')
    end
end)

function SetBlips()
    if not PlayerGang then return end
    if showBlips then
        if graffitiBlips and next(graffitiBlips) then
            for i=1, #graffitiBlips do
                RemoveBlip(graffitiBlips[i])
            end
        end
        if allGraffitis and next(allGraffitis) then
            for k, v in pairs(allGraffitis) do
                for _, j in pairs(v) do
                    local blip = AddBlipForRadius(j['coords'].x, j['coords'].y, j['coords'].z, Config.ZoneRadius)
                    local color = 1
                    if gangSettings and (gangSettings[k] and gangSettings[k]) then
                        color = gangSettings[k]['blip']
                    end
                    SetBlipColour(blip, color)
                    SetBlipAlpha(blip, 128)
                    graffitiBlips[#graffitiBlips+1] = blip
                end
            end
        end
    else
        if graffitiBlips and next(graffitiBlips) then
            for i=1, #graffitiBlips do
                RemoveBlip(graffitiBlips[i])
            end
        end
    end
end

function refreshBlips()
    if not PlayerGang then return end
    if showBlips then
        if graffitiBlips and next(graffitiBlips) then
            for i=1, #graffitiBlips do
                RemoveBlip(graffitiBlips[i])
            end
        end
        if allGraffitis and next(allGraffitis) then
            for k, v in pairs(allGraffitis) do
                for h, j in pairs(v) do
                    local blip = AddBlipForRadius(j['coords'].x, j['coords'].y, j['coords'].z, Config.ZoneRadius)
                    local color = 1
                    if gangSettings and (gangSettings[k] and gangSettings[k]) then
                        color = gangSettings[k]['blip']
                    end
                    SetBlipColour(blip, color)
                    SetBlipAlpha(blip, 128)
                    graffitiBlips[#graffitiBlips+1] = blip
                end
            end
        end
    end
end