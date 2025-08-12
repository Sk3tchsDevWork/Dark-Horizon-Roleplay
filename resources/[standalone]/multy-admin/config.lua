Config = {}

-- For webhook configuration, edit server/webhooks.lua
-- Documentation: https://multy.lol/docs/multy-admin

-- Language Configuration
Config.Language = 'en' -- Options: en, zh, es, fr, ar, ru, hi, nl, no

-- Debug mode (shows permission checks in console)
Config.Debug = false

Config.Permissions = {
    -- IMPORTANT: Framework-specific setup requirements:
    -- 
    -- For QB-Core:
    -- 1. Add your custom groups here in 'groups'
    -- 2. ALSO add them to qb-core/config.lua in QBConfig.Server.Permissions
    --    Example: QBConfig.Server.Permissions = {'god', 'admin', 'mod', 'example'}
    -- 3. Then add permissions in server.cfg:
    --    add_principal identifier.discord:123456789 qbcore.example
    --
    -- For Qbox:
    -- 1. Add your custom groups in the 'groups' section below
    -- 2. Define ACE groups in permissions.cfg:
    --    add_ace group.example example allow
    -- 3. Assign players to groups in server.cfg:
    --    add_principal identifier.discord:123456789 group.example
    --
    -- Permission groups configuration (from lowest to highest level)
    -- Define display properties and hierarchy for each group
    groups = {
        ['mod'] = {
            level = 1,
            label = "Moderator", 
            color = "#f39c12",
            description = "Can moderate players and handle basic admin tasks"
        },
        ['admin'] = {
            level = 2,
            label = "Administrator",
            color = "#e74c3c", 
            description = "Full admin access except destructive commands"
        },
        ['god'] = {
            level = 3,
            label = "God/Owner",
            color = "#9b59b6",
            description = "Complete server control"
        },
        -- Example: Custom group
        -- ['example'] = {
        --     level = 1,  -- Same level as mod, but different permissions
        --     label = "Example Group",
        --     color = "#3498db",
        --     description = "Example custom permission group"
        -- }
    },
    
    -- Minimum permission group required to open the admin menu
    minimumGroup = 'mod',
    
    features = {
        -- Player Interaction
        playerInteraction = {
            spectate = 'mod',           -- Watch players
            teleportToPlayer = 'mod',   -- Teleport to a player
            bringPlayer = 'mod',        -- Bring player to you
            returnLastLocation = 'mod', -- Return player to last location
            freeze = 'mod',             -- Freeze/unfreeze player
            heal = 'mod',               -- Heal player  
            kill = 'admin',             -- Kill player
            revive = 'mod',             -- Revive player
            reviveAll = 'admin',        -- Revive all players
        },
        
        -- Player Management
        playerManagement = {
            playerInfo = 'mod',         -- View detailed player information
            viewPlayerIP = 'admin',     -- View player IP addresses in player info
            warn = 'mod',               -- Warn players
            kick = 'mod',               -- Kick from server
            ban = 'admin',              -- Ban from server
            unban = 'admin',            -- Remove bans
            viewBans = 'mod',           -- View ban list
            offlineBan = 'admin',       -- Ban offline players
            openInventory = 'mod',      -- View player inventory
            clearInventory = 'admin',   -- Clear player inventory
            setJob = 'admin',           -- Change player job
            setGang = 'admin',          -- Change player gang
            screenshot = 'admin',       -- Take screenshot of player's screen
            removePlayerCar = 'admin',  -- Remove car from player's garage
        },
        
        -- Resource Giving
        giveResources = {
            giveItem = 'admin',         -- Give items to players
            giveItemAll = 'god',        -- Give items to all players
            giveMoney = 'admin',        -- Give money to players
            giveMoneyAll = 'god',       -- Give money to all players
            giveCar = 'admin',          -- Give vehicle ownership
            fixPlayerCar = 'mod',       -- Fix player's current vehicle
            giveClothingMenu = 'mod',   -- Give player clothing menu
        },
        
        -- Vehicle Management  
        vehicleOptions = {
            spawnVehicle = 'mod',       -- Spawn vehicles
            deleteVehicle = 'mod',      -- Delete vehicles
            repairVehicle = 'mod',      -- Repair vehicles
            flipVehicle = 'mod',        -- Flip overturned vehicles
            maxTuneVehicle = 'admin',   -- Fully upgrade vehicle
            changePlate = 'admin',      -- Change license plate
        },
        
        -- World Management
        worldManagement = {
            changeWeather = 'admin',    -- Change weather
            changeTime = 'admin',       -- Change time
            freezeTime = 'admin',       -- Stop time progression
            clearArea = 'admin',        -- Clear area of objects
            clearAllVehicles = 'god',   -- Delete ALL vehicles (dangerous!)
        },
        
        -- Server Management
        serverManagement = {
            announcement = 'admin',     -- Server-wide announcements
            refreshJobs = 'god',        -- Reload job data
            refreshItems = 'god',       -- Reload item data
        },
        
        -- Teleportation
        teleportOptions = {
            teleportWaypoint = 'mod',   -- Teleport to waypoint
            teleportCoords = 'admin',   -- Teleport to coordinates
            teleportLocations = 'mod',  -- Teleport to preset locations
        },
        
        -- Developer Tools
        developerTools = {
            noclip = 'mod',             -- Fly through walls
            godmode = 'admin',          -- Invincibility
            invisible = 'admin',        -- Invisibility
            showCoords = 'mod',         -- Display coordinates
            copyCoords = 'mod',         -- Copy coordinates
            entityInfo = 'admin',       -- Entity inspector
            playerBlips = 'admin',      -- Show all players on map
            playerNames = 'admin',      -- Show player names overhead
            infiniteAmmo = 'god',       -- Unlimited ammunition
        },
        
        -- Report System
        reportSystem = {
            viewReports = 'mod',        -- View player reports
            claimReport = 'mod',        -- Claim a report
            closeReport = 'mod',        -- Close completed reports
            deleteReport = 'mod',       -- Delete reports
            respondToReport = 'mod',    -- Send messages in reports
        },
        
        -- Communication
        communication = {
            adminChat = 'mod',          -- Access to admin chat
        }
    }
}

Config.ReportSystem = {
    enabled = true,
    maxReportLength = 500,
    reportTypes = {
        ['player'] = {
            label = 'Player Report',
            icon = 'fas fa-user-shield',
            color = '#e74c3c'
        },
        ['bug'] = {
            label = 'Bug Report',
            icon = 'fas fa-bug',
            color = '#f39c12'
        },
        ['question'] = {
            label = 'Question',
            icon = 'fas fa-question-circle',
            color = '#3498db'
        }
    },
    commands = {
        report = 'report',
        reports = 'reports'
    }
}

Config.InventorySystem = {
    -- Auto-detect inventory system (recommended)
    autoDetect = true,
    
    -- Manual override (set autoDetect to false to use this)
    -- Options: 'ps-inventory', 'ox_inventory', 'ps-inventory'
    manualSystem = 'ps-inventory',
    systems = {
        ['ps-inventory'] = {
            openFunction = function(adminSrc, targetId)
                if exports['ps-inventory'] and exports['ps-inventory'].OpenInventoryById then
                    exports['ps-inventory']:OpenInventoryById(adminSrc, targetId)
                else
                    TriggerEvent("inventory:server:OpenInventory", "otherplayer", adminSrc, targetId)
                end
            end,
            clearFunction = function(targetPlayer)
                if targetPlayer.PlayerData and targetPlayer.PlayerData.items then
                    for slot, _ in pairs(targetPlayer.PlayerData.items) do
                        if targetPlayer.PlayerData.items[slot] then
                            targetPlayer.Functions.RemoveItem(targetPlayer.PlayerData.items[slot].name, targetPlayer.PlayerData.items[slot].amount, slot)
                        end
                    end
                end
                if targetPlayer.Functions.ClearInventory then
                    targetPlayer.Functions.ClearInventory()
                end
            end
        },
        
        ['ox_inventory'] = {
            openFunction = function(adminSrc, targetId)
                if exports.ox_inventory then
                    print("[Multy Admin] Attempting to open ox_inventory for admin " .. adminSrc .. " to target player " .. targetId)
                    TriggerClientEvent('ox_inventory:openInventory', adminSrc, 'player', targetId)
                    print("[Multy Admin] Triggered ox_inventory:openInventory client event")
                    

                    pcall(function()
                        exports.ox_inventory:forceOpenInventory(adminSrc, 'player', targetId)
                        print("[Multy Admin] Called forceOpenInventory")
                    end)
                else
                    print("[Multy Admin] ox_inventory export not available")
                end
            end,
            clearFunction = function(targetPlayer)
                local playerId = targetPlayer.PlayerData.source
                if exports.ox_inventory then
                    exports.ox_inventory:ClearInventory(playerId)
                else
                    local items = exports.ox_inventory:GetInventoryItems(playerId)
                    if items then
                        for slot, item in pairs(items) do
                            exports.ox_inventory:RemoveItem(playerId, item.name, item.count, nil, slot)
                        end
                    end
                end
            end
        },
        
        ['ps-inventory'] = {
            openFunction = function(adminSrc, targetId)
                if exports['ps-inventory'] and exports['ps-inventory'].OpenInventory then
                    exports['ps-inventory']:OpenInventory(adminSrc, 'player', targetId)
                else
                    TriggerEvent("inventory:server:OpenInventory", "otherplayer", adminSrc, targetId)
                end
            end,
            clearFunction = function(targetPlayer)
                local playerId = targetPlayer.PlayerData.source
                if exports['ps-inventory'] and exports['ps-inventory'].ClearInventory then
                    exports['ps-inventory']:ClearInventory(playerId)
                else
                    if targetPlayer.PlayerData and targetPlayer.PlayerData.items then
                        for slot, _ in pairs(targetPlayer.PlayerData.items) do
                            if targetPlayer.PlayerData.items[slot] then
                                targetPlayer.Functions.RemoveItem(targetPlayer.PlayerData.items[slot].name, targetPlayer.PlayerData.items[slot].amount, slot)
                            end
                        end
                    end
                    if targetPlayer.Functions.ClearInventory then
                        targetPlayer.Functions.ClearInventory()
                    end
                end
            end
        }
    }
}

Config.MenuCommands = {
    openCommand = 'madmin',
    openKey = 'F9'
}

Config.Keybinds = {
    noclip = {
        enabled = true,
        key = 'F2',
        description = 'Toggle Admin Noclip'
    }
}

Config.Features = {
    playerManagement = true,
    vehicleOptions = true,
    weatherTime = true,
    serverManagement = true,
    teleportOptions = true,
    developerOptions = true
}

Config.VehicleSettings = {
    spawnDistance = 3.0,
    platePrefix = 'CAR',
    setFuel = true,
    giveKeys = true,
    putInVehicle = true
}

Config.TeleportLocations = {
    ['police'] = {
        coords = vector3(441.93, -982.29, 30.69),
        label = 'Police Station'
    },
    ['hospital'] = {
        coords = vector3(298.78, -584.66, 43.26),
        label = 'Hospital'
    },
    ['airport'] = {
        coords = vector3(-1037.51, -2963.24, 13.95),
        label = 'Airport'
    },
    ['legion'] = {
        coords = vector3(195.17, -933.77, 30.69),
        label = 'Legion Square'
    },
    ['paleto'] = {
        coords = vector3(-447.24, 6013.46, 31.72),
        label = 'Paleto Bay'
    },
    ['sandy'] = {
        coords = vector3(1863.28, 3673.88, 33.74),
        label = 'Sandy Shores'
    }
}

Config.Noclip = {
    defaultSpeed = 1.0,
    maxSpeed = 16.0,
    controls = {
        speedUp = 15,
        speedDown = 14,
        speedReset = 348,
        fastModifier = 21,
        fasterModifier = 19,
        slowModifier = 36
    }
}

Config.Logging = {
    enabled = true,
    logToConsole = true,
    logActions = {
        teleport = true,
        kick = true,
        ban = true,
        unban = true,
        spawn = true,
        give = true,
        revive = true,
        spectate = true,
        noclip = true,
        godmode = true,
        heal = true,
        freeze = true,
        kill = true,
        setJob = true,
        openInventory = true,
        clearInventory = true,
        deleteVehicle = true,
        repairVehicle = true,
        weather = true,
        time = true,
        announcement = true,
        clearArea = true,
        clearAllVehicles = true,
        refreshJobs = true,
        refreshItems = true,
        screenshot = true,
        adminchat = true,
        fixPlayerCar = true,
        giveClothingMenu = true,
        removeplayercar = true
    }
}

Config.Screenshot = {
    enabled = true,
    quality = 85, -- Screenshot quality
    uploadTimeout = 30000, -- 30 seconds timeout
    embedColor = 15158332, -- Red color
    embedTitle = "[MULTY ADMIN] Player Screenshot",
    includeMetadata = true, -- Include player info in embed
    cooldown = 30, -- Cooldown between screenshots
    maxFileSize = 10
}

-- Vehicle Categories and Models
Config.VehicleCategories = {
    ['sports'] = {
        'comet2', 'sultan', 'futo', 'jester', 'elegy2', 'banshee', 'buffalo', 
        'carbonizzare', 'ninef', 'alpha', 'jester2', 'massacro', 'kuruma', 
        'seven70', 'specter', 'streiter', 'neon', 'pariah', 'raiden', 'revolter', 
        'schlagen', 'vstr', 'comet6', 'growler', 'vectre', 'cypher', 'sultan3'
    },
    
    ['super'] = {
        'adder', 'zentorno', 't20', 'turismor', 'osiris', 'entityxf', 'reaper', 
        'italigtb', 'pfister811', 'prototipo', 'tyrus', 'penetrator', 'tempesta', 
        'voltic', 'infernus', 'bullet', 'vacca', 'fmj', 'gp1', 'autarch', 
        'cyclone', 'visione', 'sc1', 'tezeract', 'taipan', 'entity2', 'emerus', 
        'krieger', 'zorrusso', 'tigon', 'furia'
    },
    
    ['sedans'] = {
        'asea', 'emperor', 'fugitive', 'glendale', 'intruder', 'premier', 'primo', 
        'regina', 'schafter2', 'stanier', 'stratum', 'superd', 'surge', 'tailgater', 
        'warrener', 'washington', 'stretch', 'cognoscenti', 'cog55', 'tailgater2', 
        'cinquemila', 'deity', 'jubilee'
    },
    
    ['coupes'] = {
        'cogcabrio', 'exemplar', 'f620', 'felon', 'felon2', 'jackal', 'oracle', 
        'oracle2', 'sentinel', 'sentinel2', 'windsor', 'windsor2', 'zion', 'zion2', 
        'previon', 'champion', 'ignus', 'zeno'
    },
    
    ['suvs'] = {
        'baller', 'baller2', 'bjxl', 'cavalcade', 'cavalcade2', 'dubsta', 'dubsta2', 
        'fq2', 'granger', 'gresley', 'habanero', 'huntley', 'landstalker', 'mesa', 
        'patriot', 'radi', 'rocoto', 'seminole', 'serrano', 'xls', 'baller3', 
        'baller4', 'baller5', 'baller6', 'contender', 'toros', 'novak', 'rebla', 
        'landstalker2', 'seminole2', 'granger2', 'astron', 'baller7', 'jubilee', 
        'patriot3'
    },
    
    ['offroad'] = {
        'bifta', 'blazer', 'blazer3', 'brawler', 'dloader', 'dubsta3', 'dune', 
        'inject', 'marshall', 'mesa3', 'monster', 'rancherxl', 'rebel', 'rebel2', 
        'sandking', 'sandking2', 'technical', 'trophy', 'trophy2', 'blazer4', 
        'caracara', 'kamacho', 'riata', 'freecrawler', 'menacer', 'brutus', 
        'monster3', 'nightshark', 'rcbandito', 'hellion', 'zhaba', 'outlaw', 
        'vagrant', 'everon', 'winky', 'slamtruck', 'squaddie', 'patriot2', 
        'yosemite3', 'draugur'
    },
    
    ['muscle'] = {
        'blade', 'buccaneer', 'chino', 'coquette3', 'dominator', 'dukes', 'gauntlet', 
        'hotknife', 'faction', 'nightshade', 'phoenix', 'picador', 'sabregt', 
        'sabregt2', 'slamvan', 'stalion', 'tampa', 'vigero', 'virgo', 'voodoo', 
        'dukes2', 'stalion2', 'dominator2', 'buffalo2', 'buffalo4', 'impaler', 
        'tulip', 'vamos', 'clique', 'deviant', 'yosemite', 'gauntlet3', 'gauntlet4', 
        'peyote2', 'dominator3', 'manana2', 'glendale2', 'gauntlet5', 'dominator7', 
        'dominator8', 'greenwood', 'buffalo5', 'weevil2'
    },
    
    ['compacts'] = {
        'blista', 'brioso', 'dilettante', 'issi2', 'panto', 'prairie', 'rhapsody', 
        'brioso2', 'weevil', 'club', 'kanjo', 'asbo', 'brioso3'
    },
    
    ['motorcycles'] = {
        'akuma', 'avarus', 'bagger', 'bati', 'bati2', 'bf400', 'carbonrs', 'chimera', 
        'cliffhanger', 'daemon', 'daemon2', 'defiler', 'double', 'enduro', 'esskey', 
        'faggio', 'faggio2', 'faggio3', 'fcr', 'fcr2', 'gargoyle', 'hakuchou', 
        'hakuchou2', 'hexer', 'innovation', 'lectro', 'manchez', 'nemesis', 
        'nightblade', 'oppressor', 'oppressor2', 'pcj', 'ratbike', 'ruffian', 
        'sanchez', 'sanchez2', 'sanctus', 'shotaro', 'sovereign', 'thrust', 'vader', 
        'vindicator', 'vortex', 'wolfsbane', 'zombiea', 'zombieb', 'diablous', 
        'diablous2', 'stryder', 'rrocket', 'deathbike', 'manchez2', 'manchez3', 
        'shinobi', 'reever', 'powersurge'
    },
    
    ['vans'] = {
        'bison', 'bobcatxl', 'boxville', 'burrito', 'burrito3', 'gburrito', 'journey', 
        'minivan', 'moonbeam', 'moonbeam2', 'paradise', 'pony', 'pony2', 'rumpo', 
        'rumpo2', 'rumpo3', 'speedo', 'surfer', 'surfer2', 'taco', 'youga', 'youga2', 
        'youga3', 'speedo4', 'youga4'
    },
    
    ['emergency'] = {
        'ambulance', 'fbi', 'fbi2', 'firetruk', 'lguard', 'pbus', 'police', 'police2', 
        'police3', 'police4', 'policeb', 'polmav', 'policeold1', 'policeold2', 
        'policet', 'pranger', 'predator', 'riot', 'riot2', 'sheriff', 'sheriff2'
    },
    
    ['service'] = {
        'airbus', 'brickade', 'bus', 'coach', 'rallytruck', 'rentalbus', 'taxi', 
        'tourbus', 'trash', 'trash2', 'wastelander'
    },
    
    ['commercial'] = {
        'benson', 'biff', 'hauler', 'hauler2', 'mule', 'mule2', 'mule3', 'mule4', 
        'packer', 'phantom', 'phantom2', 'phantom3', 'pounder', 'pounder2', 
        'stockade', 'stockade3', 'terbyte'
    },
    
    ['military'] = {
        'apc', 'barracks', 'barracks2', 'barracks3', 'barrage', 'chernobog', 
        'crusader', 'halftrack', 'khanjali', 'rhino', 'scarab', 'scarab2', 
        'scarab3', 'thruster', 'trailersmall2', 'vetir', 'minitank', 'patrolboat'
    }
}