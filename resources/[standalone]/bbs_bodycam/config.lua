Config                       = {}

Config.AutofillEmptyMonitors = true     -- If there is an empty monitor on a station, and a new player streams to that station, it will auto place it on the empty monitor.
Config.DebugPrints           = true     -- Show debug prints on consoles
Config.Notify                =
"ox_lib"                                -- Notification system to use (supports: codem, esx, qb, okok, wasabi, t-notify, r_notify, pNotify, mythic, ox_lib) Checkout Framework/Client.lua to implement your own notification system
Config.StationSpawnDistance  = 50       -- From how far should we spawn the stations and stream
Config.StreamerUI = {
    defaultColor = '#b4e629', 
    position = {top = '20vh',right = '3vh'} -- CSS positioning
}
Config.Stations              = {        -- Default stations. AVOID having 2 stations within render distance of each other!!
    {
        Location = vector4(454.08, -986.92, 25.67, 92.7),
        IsJobAssociated = true,

        AssociatedJobs = {             -- Players with these jobs will stream their bodycam to this station.
            ['police'] = true,         -- All the grades
            ['sheriff'] = { 1, 2, 3 }, -- Only specific grades
        },
        ControlTitle = 'LSPD Live Cams',
        UseBadgeNumberForNames = true, -- If the player that is streaming his bodycam to this station has a badgenumber(Check Framework/Server.lua) we use it to identify him, otherwise we use his name.
        ControlAccess = {              -- Who can control the Station PC to switch POVs.
            InteractDistance = 3.0,
            Jobs = {
                ['police'] = { 3, 4 },                           -- jobs with specific grades
                ['fib'] = true,                                  -- All Grades within a job
            },
            CanControlThisStation = function(source, job, grade) -- Custom Serverside Function to control access
                return true
            end,
        },
        StreamerUIColor = '#298ee6', -- Supports HTML coloring

    },
    {
        Location = vector4(392.6107, -978.7681, 28.4254, -89.6536),
        IsJobAssociated = false,                                 -- Commercial use!
        ControlIP = 'stream.station1.com',                       -- A dummy URL that players will enter when using commercial bodycam to stream to this station.
        ControlAccess = {                                        -- Who can control the Station PC to switch POVs.
            InteractDistance = 3.0,
            CanControlThisStation = function(source, job, grade) -- Custom Serverside Function to control access
                return true
            end,
        },
        StreamerUIColor = '#b4e629', -- Supports HTML coloring
    }
}
--[[
Note : , If two stations share a Control IP , player stream will stream to both stations. And if Two stations share the same AssociatedJobs , Player will stream to both stations.
]]

-- We auto Detect Frameworks And Inventory Systems, Checkout Framework/Server.lua for more info.
Config.ItemSettings = {    -- Use these items for streaming.
    Enabled = true,
    JobAssociatedItems = { -- Items that will link the stream with job associated stations
        ['goverment_bodycam'] = true,
    },
    CommercialUseItems = { -- Items that will stream to a Specific station IP.
        ['commercial_bodycam'] = true,
    }
}
Config.CommandSettings = { -- If you dont want to use Items, you can opt in for Commands aswell.
    JobAssociatedCommand = {
        enable = false,
        command = 'bodycam' -- /command
    },
    CommercialUseCommand = {
        enable = false,
        command = 'streamto'
    }
}

-- The Script to use for the drawtext, Already Suuports : 'ox_lib', 'cd_drawtextui', 'jg-textui', 'okokTextUI'
Config.DrawTextScript = 'ox_lib'

-- Configuration for displaying the interaction text UI.
Config.DrawTextUI = {
    enable     = true,                              -- Enable or disable the text UI system.
    hotkey     = "e",                               -- Key to press for interaction if using "buttonPress".
    text       = "Press [%s] to Open Control Menu", -- Text to show. "%s" will be replaced by the hotkey automatically.
    custom     = function(text)                     -- Function to show the text UI using the selected DrawTextScript.
        if Config.DrawTextScript == 'ox_lib' and lib then
            lib.showTextUI(text, {
                position = "top-center",
                icon = 'laptop',
                style = {
                    borderRadius = 0,
                    backgroundColor = '#48BB78',
                    color = 'white'
                }
            })
        elseif Config.DrawTextScript == 'cd_drawtextui' then
            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
        elseif Config.DrawTextScript == 'jg-textui' then
            exports['jg-textui']:DrawText(text)
        elseif Config.DrawTextScript == 'lab-HintUI' then
            exports['lab-HintUI']:Show(text, "BBS Bodycam")
        elseif Config.DrawTextScript == 'okokTextUI' then
            exports['okokTextUI']:Open(text, 'darkblue')
        end
    end,
    customhide = function() -- Function to hide the text UI depending on which DrawTextScript is used.
        if Config.DrawTextScript == 'ox_lib' and lib then
            lib.hideTextUI()
        elseif Config.DrawTextScript == 'cd_drawtextui' then
            TriggerEvent('cd_drawtextui:HideUI')
        elseif Config.DrawTextScript == 'jg-textui' then
            exports['jg-textui']:HideText()
        elseif Config.DrawTextScript == 'lab-HintUI' then
            exports['lab-HintUI']:Hide()
        elseif Config.DrawTextScript == 'okokTextUI' then
            exports['okokTextUI']:Close()
        end
    end,
}

Config.StreamSettings = { -- Streaming settings that players with bodycam will use to stream their perspective. Highering these numbers will increase the bandwidth usage and is not recommended.
    FrameRate = 20,       -- Stream FPS.
    Width = 1280,         -- 1280x720P
    Height = 720,
}


Config.Locales = {
    ['no_station_found_job'] = 'No Stations found associated with your current job'
}