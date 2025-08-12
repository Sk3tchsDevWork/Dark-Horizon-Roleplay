QBCore = exports['qb-core']:GetCoreObject()

function OpenTVManageMenu(_entity)
    TriggerEvent("qb-menu:client:openMenu", {
        {
            header = "Manage Tv",
            isMenuHeader = true,
        },
        {
            header = "Open Menu",
            params = {
                event = "17movTV:interaction:OpenMenu",
                args = {
                    entity = _entity
                }
            }
        },
        {
            header = "Stop Playing",
            params = {
                event = "17movTV:interaction:stopPlaying",
                args = {
                    entity = _entity
                }
            }
        },
        {
            header = "Collect TV",
            params = {
                event = "17movTV:interaction:RemoveTV",
                args = {
                    entity = _entity
                }
            }
        },
    })
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

RegisterNetEvent("17movTV:Interaction:SetVolumeLevel", function(data)
    local entity = data.entity
    local input = exports['qb-input']:ShowInput({
        header = "Enter Volume Level [0-10]",
        submitText = "Change",
        inputs = {
            {
                text = "Volume",
                name = "volume",
                type = "number", 
                isRequired = true
            },
        },
    })
    
    if input ~= nil and input.volume ~= nil then
        TriggerEvent("17movTV:interaction:changeVolume", data, tonumber(input.volume))
    end
end)