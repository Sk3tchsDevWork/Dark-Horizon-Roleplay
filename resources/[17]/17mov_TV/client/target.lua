function AddTargetToObj(obj)
    exports['qb-target']:AddTargetEntity(obj, {
        options = {
            {
                type = "client",
                icon = "fa-solid fa-hands-holding",
                label = "Collect TV",
                action = function(entity)
                    TriggerEvent("17movTV:interaction:RemoveTV", {entity = entity})
                end
            },
            {
                type = "client",
                icon = "fa-solid fa-circle-play",
                label = "Open Menu",
                action = function(entity)
                    TriggerEvent("17movTV:interaction:OpenMenu", {entity = entity})
                end
            },
            {
                type = "client",
                icon = "fa-solid fa-circle-stop",
                label = "Stop Playing",
                action = function(entity)
                    TriggerEvent("17movTV:interaction:stopPlaying", {entity = entity})
                end
            },
        },
        distance = 3.0
    })
end

function RemoveTargetEntity(obj)
    exports["qb-target"]:RemoveTargetEntity(obj)
end