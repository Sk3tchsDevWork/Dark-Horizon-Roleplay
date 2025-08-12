Config = {
    DefaultKey = {
        Enable = true,
        Key = "E"
    },
    Areas = {
        [1] = {
            data = {
                type ="3dtext",
                coords = vector3(461.27496, -999.7532, 30.689516),
                displayDist = 6,
                interactDist = 2,
                enableKeyClick = true,
                keyNum = 38,
                key = "E",
                text = "Example Text",
                theme = "red", -- Optional: specify a theme, defaults to "green"
                job = "police", -- Optional: specify a job requirement, defaults to "all"
                canInteract = function()
                    -- Check if the player is allowed to interact based on your conditions
                    -- For example, you might check if the player is on duty if the job is restricted
                    return true -- For simplicity, always allow interaction in this example
                end,
            },
            onKeyClick = function()
                -- Write your export or events here
            end
        },
        [2] = {
            data = {
                type = "textui", -- textui or 3dtext
                coords = vector3(470.4, -986.63, 30.69), 
                dist = 3,
                keyNum = 38, -- Key number
                key = "E", -- Key name
                text = "Label"
            },
            onKeyClick = function()
                -- Write your export or events here
            end
        }
    }
}


