HotspotList = {
    { 
        name = "uwucafe", -- an unique name
        label = "UwU Customers", -- How players will see it in their laptop WiFi
        password = false, -- password (string: "") or false
        coords = { -580.3973, -1059.5032, 22.3442 }, -- coords where this hotspot is located
        canConnect = function() -- run your own check, return true or false to show/hide the hotspot from players
            return true
        end,
    },
    { 
        name = "uwucafe_boss", 
        label = "UwU Boss", 
        password = '123', 
        coords = { -580.3973, -1059.5032, 22.3442 },
        canConnect = function() -- run your own check, return true or false to show/hide the hotspot from players
            -- THIS IS JUST AN EXAMPLE!
            -- Checks if the player holds the boss grade and if their job name is 'uwu_cafe'
            local isBoss = exports['av_laptop']:isBoss() -- true or false
            local isUwU = exports['av_laptop']:hasJob('uwu_cafe') -- true or false
            return (isBoss and isUwU) -- both true? returns true, 1 true but other one is false? return false, both false returns false
        end,
    },
    { 
        name = "vanilla_employees", 
        label = "Vanilla Employees", 
        password = "123", 
        coords = { 114.7914, -1286.0952, 28.2621 },
        canConnect = function() -- run your own check, return true or false to show/hide the hotspot from players
            return true
        end,
    },
}