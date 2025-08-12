xSound = exports.xsound
CodeStudio = {}
CodeStudio.AutoSQL = true

-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework
-- false = For Standalone (DO NOT PUT 'false')

CodeStudio.ServerType = false    --['QB'|'ESX'|false]

CodeStudio.Main = {
    UseWithCommand = {
        Enable = true,  -- Enable to use the car radio with command
        Command = 'carplay',  -- Command Name
    },
    UseWithKey = {
        Enable = true, -- Enable to use the car radio with Keybind
        Keybind = 'J'   -- Default Key 
    },
    UseWithItem = {  -- This option is only for framework-specific servers
        Enable = false,  -- Enable to use the car radio with item
        Item = 'carplay'   -- Item Name
    },
    Restrict_Radio = {  -- Restrict Car Play. Leave empty if you want everyone to access it (Jobs/Gangs/Identifiers/Ace Perms/Discord Roles)
        -- 'police',
        -- 'discord:968848387132772434',
    },
    RadioInstall = {
        Enable = false,      -- Enable this if you want mechanics to manually install radios on owned vehicles
        Options = {
            RadioItem = 'carplay',   -- Alternatively, put false and you can also use the event directly from other scripts
            RadioInstallerItem = 'radioinstaller',  -- This is the radio installer item required to install a radio in vehicles [*RadioItem Required]
            OnlyOwned = false,   -- Enable to allow radios to be installed only in owned vehicles, not on NPC vehicles
        }
    }
}

CodeStudio.Apps = {     --Enable/Disable Car Play Apps and Features 
    Music_Playlist = true,
    AI_Assistant = true,
    Music_Overlay = true,
    Video_Player = true,
    Car_Control = true,
    Car_Info = true,
    Car_Automation = true,
    Game = true,
    Music_Neon_RGB = true
}

CodeStudio.Default_Music_Volume = 20        --Default Music Volume [0-100] 
CodeStudio.MarkedLocation_Unit = 'Km'       --Option = [Km/Mi]
CodeStudio.OnlyDriver = false               --Only Driver Can Access Car Play System 
CodeStudio.Music_Outside_Veh = true         --Enable/Disable Music To Play Outside Vehicle
CodeStudio.Outside_Music_Distance = 80.0    --The distance of music
CodeStudio.EnableControl = false             --Enable Mouse and Vehicle Control While Using Radio

CodeStudio.AutoPilot = {
    MaxSpeed = 200.0,
    DriveStyle = 786859     --You Can Make Your Own Custom Driving Style Here: https://vespura.com/fivem/drivingstyle/
}

-- Front|Reverse Parking Sensor --
CodeStudio.ParkingSensor = {
    Enable = true,
    SensorDistance = 3.0
}

CodeStudio.DebugCamera = false -- Set this to true to find new camera offsets for vehicles
CodeStudio.VehCamOffset = {
    -- This script includes a built-in offset finder. Simply enable DebugCamera to determine the correct camera offsets
    [`bus`] = { front = {0.000000, 6.680000, 0.670000} },
    [`bati`] = { front = {0.000000, 0.350000, 0.790000}, back = {0.000000, -1.230000, 0.650000} },
}


-- Add Discord Webhook to log music playing --
CodeStudio.DiscordLog = {
    Enable = false,
    Play_Webhook = 'PUT_YOUR_WEBHOOK'
}

-- You can add your own default playlist --
CodeStudio.Default_Playlist = {
    -- [1] = 'https://www.youtube.com/watch?v=FdPgd0w_pb4',  -- Song 1
    -- [2] = 'https://www.youtube.com/watch?v=jjsVzMtXzxg',  -- Song 2
    -- [3] = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'   -- Song 3
}

-- Vehicle Car Play Restriction --
-- BL = Blacklist Method | WL = Whitelist Method
CodeStudio.RestrictionMethod = 'BL'

-- Add Vehicles Below based on WL/BL -- 
CodeStudio.AddVehicle = {
    `hydra`,
    `jet`,
}