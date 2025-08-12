Config = {}

-------------------------------
-- 🔧 General Configuration
-------------------------------
Config.Lan = 'en' -- Sets the language for the script. Options: 'en' (English), 'es' (Spanish), 'de' (German), 'fr' (French)

Config.Notifications = "ox_lib"     -- Notification system to use ("ox_lib", "qb-core")
Config.Inventory = "ox_inventory"   -- Inventory system to use ("ox_inventory", "ps-inventory", "qs-inventory", "ps-inventory")
Config.Target = "ox_target"         -- Target system to use ("ox_target", "qb-target")
Config.ProgressBar = "ox_lib" -- ("ox_lib", "qb-core")
Config.Dispatch = "none" -- ("ps-dispatch" / "cd_dispatch" / "qs-dispatch" / "tk_dispatch" / "rcore_dispatch" / "none")

-- Inventory image directory path
Config.InventoryImagePath = "ox_inventory/web/images" -- ("ox_inventory/web/images" / "ps-inventory/html/images" / "ps-inventory/html/images" / "qs-inventory/html/images")

-- Webhook settings for logging
Config.WebHooks = false -- Enable or disable webhook logging. 'false' means logging is disabled.
Config.WebHookURL = "PLACE_YOUR_WEBHOOK_HERE" -- Webhook URL for logging prison-related activities (only used if WebHooks = true)

Config.TabletItem = "prison_tablet" -- Enables opening the prison tablet via item use (requires the specified item and the correct prison job)
Config.UsePrisonCommand = true -- Enables opening the prison tablet via /prison command (requires the correct prison job, item not needed)
Config.FineSystem = true            -- Enable or disable fines for prisoners
Config.RemoveItemsOnJail = true -- If true: removes and confiscate player items when sent to prison. If false: items are kept.
Config.RequireOfficerNearbyToJail = true         -- Officer must be near player to jail them
Config.RequireOfficerNearbyToRelease = true      -- Officer must be near player to release them
Config.RequireOfficerNearbyToEditSentence = true -- Officer must be near player to modify their sentence
Config.RequiredJobs = { "police" } -- Jobs allowed to handle jail-related tasks
Config.PrisonTickInterval = 60 -- How often (in seconds) a prison sentence is reduced
Config.SentenceReduction = 1   -- Amount of time (in minutes) to reduce sentence every tick

-- Visitation system settings
Config.VisitationRequestDuration = 30 -- Duration (in seconds) the inmate sees the visit request on their screen
Config.VisitationRequestCooldown = 60 -- Cooldown (in seconds) before another visit can be requested
Config.VisitationTime = 60            -- Duration (in seconds) of each visitation period
Config.VisitationCoords = vector4(1828.5759, 2591.8042, 46.0143, 183.6022) -- Coordinates for the visitation room (where the prisoner is teleported during a visit)

-- Blip for the prison location
Config.Blip = {
    Enable = true,
    Coords = vector3(1829.6232, 2605.9277, 45.5662), 
    Sprite = 189,                    
    Display = 4,                            
    Scale = 0.9,                   
    Color = 1,                                  
    Label = "Bolingbroke Penitentiary"       
}

-------------------------------
-- 🍽️ Food System
-------------------------------

Config.PrisonTrayFoods = { -- Items served on the food tray and possible random rewards
    trayItem = "prison_tray", -- Name of the tray item itself
    progressbarDuration = 5000, -- Duration (in milliseconds) of the progress bar for grabbing food
    rewardItems = {
        { name = "sandwich", amount = 1 }, -- Guaranteed item: sandwich
        { name = "water_bottle", amount = 1 }, -- Guaranteed item: water bottle
        { name = "prison_note", amount = 1, chance = 30 }, -- 30% chance to also get prison note
    },
    AvailableHours = { -- Meal serving hours
        morning = {
            startHour = 7,  -- Start of morning meal period
            endHour = 9,    -- End of morning meal period
        },
        evening = {
            startHour = 18, -- Start of evening meal period
            endHour = 20    -- End of evening meal period
        }
    }
}

-------------------------------
-- 👕 Prison Uniform
-------------------------------

Config.PrisonUniform = {
    male = {
        ["t-shirt"]      = { item = 15, texture = 0 },
        ["torso"]        = { item = 5, texture = 0 },
        ["decals"]       = { item = 0,  texture = 0 },
        ["arms"]         = { item = 5, texture = 0 },
        ["pants"]        = { item = 5, texture = 7 },
        ["shoes"]        = { item = 6, texture = 0 },
        ["mask"]         = { item = -1, texture = 0 },
        ["bag"]          = { item = -1, texture = 0 },
        ["helmet"]       = { item = -1, texture = 0 },
        ["chain"]        = { item = -1, texture = 0 },
        ["glasses"]      = { item = -1, texture = 0 },
        ["watch"]        = { item = -1, texture = 0 },
        ["bracelet"]     = { item = -1, texture = 0 }
    },
    female = {
        ["t-shirt"]      = { item = 15, texture = 0 },
        ["torso"]        = { item = 74, texture = 0 },
        ["decals"]       = { item = 0,  texture = 0 },
        ["arms"]         = { item = 15, texture = 0 },
        ["pants"]        = { item = 58, texture = 2 },
        ["shoes"]        = { item = 69, texture = 0 },
        ["mask"]         = { item = -1, texture = 0 },
        ["bag"]          = { item = -1, texture = 0 },
        ["helmet"]       = { item = -1, texture = 0 },
        ["chain"]        = { item = -1, texture = 0 },
        ["glasses"]      = { item = -1, texture = 0 },
        ["watch"]        = { item = -1, texture = 0 },
        ["bracelet"]     = { item = -1, texture = 0 }
    }
}

-------------------------------
-- 🚪 Jail Break Configuration
-------------------------------
Config.ReloadskinOnJailBreak = true -- Reload player skin on successful jailbreak

Config.PrisonZone = { -- This is a poly zone defining the entire prison area. If players leave this zone while jailed, they will be teleported back to their cell.
    vec3(1742.0, 2825.0, 43.0),
    vec3(1862.0, 2717.0, 43.0),
    vec3(1865.0, 2664.0, 43.0),
    vec3(1853.0, 2495.0, 43.0), 
    vec3(1762.0, 2400.0, 43.0), 
    vec3(1657.0, 2386.0, 43.0), 
    vec3(1535.0, 2467.0, 43.0), 
    vec3(1528.0, 2587.0, 43.0), 
    vec3(1564.0, 2682.0, 43.0),
    vec3(1646.0, 2763.0, 43.0),
    vec3(1724.0, 2847.0, 43.0),
}

Config.tunnelpropDespawn = 1 -- How long (in minutes) the tunnel debris prop stays before despawning
Config.JailBreakCooldown = 30 -- Cooldown (in minutes) before another prison break attempt can be made
Config.ExplosiveItem = 'makeshift_explosive' -- Item required to plant explosives for the jailbreak

Config.BribeGuard = {
    BribeItem = "bribe_package",          -- The item the player must offer to bribe a guard
    BribeReward = "prison_keycard",       -- Item the player receives if the bribe is successful
    BribeChance = 65,                     -- Percentage chance that the bribe will succeed (0-100)
    SentenceAddedOnFail = 10,             -- Number of minutes added to the sentence if the bribe fails
}

Config.PrisonBreakSystem = {
    JailBreakWall = {
        WallCoords = vector4(1624.9685, 2572.9958, 45.5648, 271.7144), -- Location and heading of the wall to blow up
        tunnelDebrisProp = 'prop_pile_dirt_06',                         -- Prop model to use for the blown-up wall effect
        tunnelDebrisCoords = vector3(1625.27, 2572.87, 44.00),         -- Location to spawn the debris prop after explosion
        camOffset = vec(2.0, -2.0, 1.0)                                -- Camera offset for cutscene when planting the explosive
    },
    insideTunnel = {
        TunnelEntrance = vector4(-425.1760, 2064.5227, 120.2182, 97.4857), -- Entry point of the underground tunnel (where the player is teleported to)
        ExitZone = { -- Polygon zone defining the exit area of the tunnel
            vec3(-597.0, 2084.0, 131.0),
	        vec3(-584.0, 2088.0, 131.0),
	        vec3(-598.0, 2088.0, 131.0),
        }
    },
    TunnelExit = {
        coords = vector4(1728.0026, 2829.4392, 42.5128, 308.4384) -- Where the player appears after successfully escaping the tunnel
    }
}

Config.Escapedoordespawn = 1 -- How long (in minutes) the "Enter Escape Door" target is active before despawning
Config.KeycardSwipeCooldown = 45 -- How long (in minutes) before the player can swipe the keycard again

Config.KeycardEscape = {
    Keycard = {
        Coords = vector3(1637.21, 2565.95, 45.85), -- Where the keycard swiper is located
        prop = 'h4_prop_h4_ld_keypad_01', -- Model name for the keycard swiper prop
        ItemRequired = "prison_keycard" -- The required item in inventory to swipe the keycard
    },
    Door = {
        Coords = vector3(1636.35, 2565.87, 45.97) -- The prison door that gets unlocked after swiping the keycard
    },
    insideTunnel = {
        TunnelEntrance = vector4(-483.7166, 1894.8309, 119.8146, 95.0017), -- Entry point of the underground tunnel (where the player is teleported to)
        ExitZone = { -- Polygon zone defining the exit area of the tunnel
            vec3(-597.0, 2084.0, 131.0),
            vec3(-584.0, 2088.0, 131.0),
            vec3(-598.0, 2088.0, 131.0),
        }
    },
    TunnelExit = {
        coords = vector4(1728.0026, 2829.4392, 42.5128, 308.4384) -- Where the player appears after successfully escaping the tunnel
    }
}

-------------------------------
-- 💼 Prison Jobs & Peds
-------------------------------

Config.PrisonJob = {
    Ped = {
        coords = vector4(1740.5616, 2520.0981, 45.5650, 227.2604),
        model = 's_m_m_prisguard_01', -- Prisoner Worker ped model
        scenario = 'WORLD_HUMAN_CLIPBOARD' -- Ped idle animation
    },
    FoodPickupPed = {
        coords = vector4(1782.3442, 2560.7769, 45.6731, 179.3114),
        model = 's_m_m_strvend_01', -- Prison Employee Worker ped model
        scenario = 'WORLD_HUMAN_STAND_IMPATIENT' -- Ped idle animation

    },
    FrontDeskPed = {
        coords = vector4(1840.3311, 2577.7727, 46.0144, 0.0489),
        model = 's_m_m_prisguard_01', -- Prison Employee Worker ped model
        scenario = 'WORLD_HUMAN_STAND_IMPATIENT' -- Ped idle animation

    },
    CommunityServicePed = { -- Ped used to retreive items for community serivce
        coords = vector4(-1178.4612, -1768.1094, 3.9021, 169.8800),
        model = 's_m_m_prisguard_01', -- Prison Employee Worker ped model
        scenario = 'WORLD_HUMAN_STAND_IMPATIENT' -- Ped idle animation

    },
    CommissaryFood = {
        coords = vector4(1779.5094, 2560.6841, 45.6731, 181.7391),
        model = 'mp_m_securoguard_01',
        scenario = 'WORLD_HUMAN_STAND_IMPATIENT'

    },
    IllegalShopPed = {
        coords = { -- it will select a random
            vector4(1721.7913, 2502.8813, 45.5649, 118.6933),
            vector4(1625.5107, 2566.9346, 45.5648, 96.2189),
            vector4(1625.7917, 2474.8333, 55.1931, 225.8146),
            vector4(1777.4590, 2513.5605, 55.1436, 222.1106),
        },
        model = 'u_m_y_prisoner_01',
        scenario = 'WORLD_HUMAN_LEANING'
    },
    BribeGuardPed = {
        coords = { -- it will select a random
            vector4(1773.7635, 2520.7891, 54.1548, 300.8994),
            vector4(1665.4535, 2503.1833, 44.5700, 320.1962),
            vector4(1655.3390, 2487.7661, 54.1614, 319.7329),
            vector4(1693.5720, 2540.9490, 44.5648, 359.8102),
        },
        model = 's_m_m_prisguard_01',
        scenario = 'WORLD_HUMAN_SMOKING', 
    },
    Jobs = {
        {
            id = "electrician",       -- Unique identifier for this job (do not modify)
            title = "Electrician",    -- Display name of the job
            description = "Repair broken lights and electrical panels in the prison.", -- Short job description
            payRateMin = 5,           -- Minimum pay rate (in your server's currency) for completing the job
            payRateMax = 10,          -- Maximum pay rate for the job
            SentenceReduction = 15,   -- How much prison time (in minutes or months) is reduced for completing the job
            icon = "fa-bolt",         -- FontAwesome icon to represent the job in UIs (if used)
            progressbarDuration = 2500, -- Duration of the progress bar in milliseconds (2.5 seconds)

            -- Possible contraband rewards while doing the job
            ContraBandItems = {
                ['1'] = { item = "circuit_board", amount = 1, chance = 30 }, -- 30% chance to get 1 circuit_board
                ['2'] = { item = "scrap_metal", amount = 2, chance = 20 },   -- 20% chance to get 1 scrap_metal
            },
        },
        {
            id = "move_boxes",
            title = "Move Boxes",
            description = "Transport supply boxes across the facility.",
            payRateMin = 4,
            payRateMax = 8,
            SentenceReduction = 10,
            icon = "fa-box",
            progressbarDuration = 2500,
            ContraBandItems = {
                ['1'] = { item = "scrap_metal", amount = 3, chance = 25 },
                ['2'] = { item = "prison_note", amount = 1, chance = 15 },
            },
        },
        {
            id = "clean_cells",
            title = "Clean Cells",
            description = "Sweep and sanitize prisoner cells to maintain hygiene.",
            payRateMin = 6,
            payRateMax = 10,
            SentenceReduction = 25,
            icon = "fa-broom",
            progressbarDuration = 5000,
            ContraBandItems = {
                ['1'] = { item = "shank_piece", amount = 1, chance = 20 },
                ['2'] = { item = "rag", amount = 1, chance = 25 },
                ['3'] = { item = "soap_bar", amount = 1, chance = 15 },
            },
        },
        {
            id = "repair_walls",
            title = "Facility Repairs",
            description = "Fix cracked walls, damaged floors, and broken televisions.",
            payRateMin = 6,
            payRateMax = 12,
            SentenceReduction = 25,
            icon = "fa-tools",
            progressbarDuration = 2500,
            ContraBandItems = {
                ['1'] = { item = "scrap_metal", amount = 1, chance = 30 },
                ['2'] = { item = "cleaning_chemicals", amount = 1, chance = 20 },
            },
        },
    },
}
-------------------------------
-- 🛒 Commissary Shop
-------------------------------

Config.PrisonShop = {
    {
        name = "sandwich",         -- The internal item name (must match your inventory system)
        label = "Sandwich",        -- Display name for the item in the shop
        price = 15,                -- Price of the item (currency based on your economy system)
        description = "Fresh made sandwich", -- Short description for the shop UI
        category = "Food",         -- Category for organizing shop items
        limit = 5,                 -- Max number of this item you can buy per transaction
    },
}

Config.IllegalShop = {
    {
        name = "weapon_switchblade", -- The internal item name (must match your inventory system)
        label = "Shank",              -- Display name for the item in the shop
        price = 75,                   -- Price of the item (currency based on your economy system)
        description = "A sharp weapon for defense.", -- Short description for the shop UI
        limit = 2,                    -- Max number of this item you can buy per transaction
    },
    {
        name = "weapon_bat",
        label = "Bat",
        price = 100,
        description = "Heavy blunt object. Causes damage.",
        limit = 2
    },
}

Config.IllegalTrades = {
    {
        id = 1, -- Unique identifier for this trade

        -- Items required for the trade
        required = {
            { name = "circuit_board", label = "Circuit Board", amount = 3 }, -- 3 Circuit Boards
            { name = "cleaning_chemicals", label = "Cleaning Chemicals", amount = 6 }, -- 6 Cleaning Chemicals
            { name = "scrap_metal", label = "Scrap Metal", amount = 5 }, -- 5 Scrap Metal
        },

        -- Reward item(s) for completing the trade
        reward = {
            { name = "makeshift_explosive", label = "Makeshift Explosive", amount = 1 } -- 1 Makeshift Explosive
        }
    },
    {
        id = 2,
        required = {
            { name = "scrap_metal", label = "Scrap Metal", amount = 5 },
            { name = "rag", label = "Rag", amount = 2 },
            { name = "shank_piece", label = "Shank Piece", amount = 3 },
        },
        reward = {
            { name = "weapon_switchblade", label = "Shank", amount = 1 }
        }
    },
    {
        id = 3,
        required = {
            { name = "soap_bar", label = "Soap Bar", amount = 2 },
            { name = "prison_note", label = "Prison Note", amount = 1 },
            { name = "chips_bag", label = "Bag of Chips", amount = 3 },
            { name = "juice_box", label = "Juice Box", amount = 2 },
        },
        reward = {
            { name = "bribe_package", label = "Bribe Package", amount = 1 }
        }
    },

}

-------------------------------
-- 📦 Prison Job Props
-------------------------------

Config.JobProps = {
    ElectricianJob = {
        -- Electrical panel
        {
            model = 'm23_1_prop_m31_electricbox_03a', -- Prop model for the electrical job
            coords = vector4(1773.68, 2487.05, 54.65, 30.0497), -- Location and rotation of this prop
        },
        {
            model = 'tr_prop_tr_elecbox_01a',
            coords = vector4(1776.0350, 2489.8261, 54.1437, 119.5536),
        },
        {
            model = 'tr_prop_tr_elecbox_01a',
            coords = vector4(1692.1221, 2529.7345, 44.5649, 0.6633),
        },
        {
            model = 'm23_1_prop_m31_electricbox_01a',
            coords = vector4(1619.25, 2469.91, 54.92, 230.3129),
        },
        {
            model = 'prop_elecbox_01b',
            coords = vector4(1622.6268, 2467.1775, 54.1931, 53.7298),
        }
    },
    CleanCells = {
        {
            model = 'ng_proc_food_chips01a',
            coords = vector4(1758.6594, 2484.1870, 45.5611, 103.7450),
        },
        {
            model = 'prop_food_bs_burg3',
            coords = vector4(1759.0903, 2484.7039, 45.5611, 310.9209),
        },
        {
            model = 'prop_food_cb_coffee',
            coords = vector4(1759.4603, 2483.9785, 45.5611, 194.3663),
        },
        {
            model = 'prop_food_bs_bag_02',
            coords = vector4(1755.1718, 2486.8254, 45.0777, 307.1671),
        },
        {
            model = 'ng_proc_food_aple1a',
            coords = vector4(1769.1564, 2489.8215, 45.5611, 269.5589),
        },
        {
            model = 'ng_proc_food_chips01b',
            coords = vector4(1768.2766, 2489.9966, 45.5611, 313.2771),
        },
        {
            model = 'prop_rub_litter_8',
            coords = vector4(1768.8054, 2500.2249, 44.7408, 235.6294),
        },
        {
            model = 'prop_rub_litter_8',
            coords = vector4(1761.7047, 2481.1953, 48.0706, 297.4558),
        },
        {
            model = 'prop_rub_binbag_06',
            coords = vector4(1751.3062, 2471.8677, 44.7407, 219.0587),
        },
        {
            model = 'prop_rub_binbag_06',
            coords = vector4(1745.5265, 2474.3159, 44.7407, 301.4149),
        },
        {
            model = 'prop_rub_cardpile_03',
            coords = vector4(1776.9358, 2488.3137, 48.6903, 295.5106),
        },
        {
            model = 'prop_rub_cardpile_02',
            coords = vector4(1765.4615, 2499.2222, 48.6930, 301.9734),
        }
    },
    FacilityRepairs = {
        {
            coords = vector4(1772.04, 2497.45, 45.33, 294.2439)
        },
        {
            coords = vector4(1777.51, 2487.96, 45.34, 294.7543)
        },
        {
            coords = vector4(1760.78, 2493.76, 46.46, 30.6151)
        },
        {
            coords = vector4(1741.12, 2481.17, 46.49, 126.1460)
        },
        {
            coords = vector4(1748.22, 2486.12, 46.11, 305.0774)
        },
        {
            coords = vector4(1754.74, 2490.28, 50.12, 28.7816)
        },
        {
            coords = vector4(1749.47, 2484.34, 49.84, 114.8863)
        },
        {
            coords = vector4(1759.93, 2495.03, 45.95, 295.4702)
        },
        {
            coords = vector4(1756.25, 2494.65, 46.06, 122.1707)
        },
    },
    MoveBoxes = {
        BoxLocations = {
        vector4(1739.2025, 2503.4131, 44.5651, 170.0822), -- Starting box location #1
        vector4(1713.9111, 2525.1768, 44.5648, 21.1526),  -- Starting box location #2
        vector4(1695.2844, 2509.8137, 44.5648, 137.7434), -- Starting box location #3
        vector4(1722.8048, 2504.9875, 44.5648, 212.2838), -- Starting box location #4
        vector4(1767.4491, 2530.8987, 44.5650, 205.7072), -- Starting box location #5
        vector4(1760.2777, 2514.6899, 44.5651, 256.4986), -- Starting box location #6
        vector4(1708.4139, 2522.1414, 44.5649, 33.6749),  -- Starting box location #7
        },

        BoxModel = 'prop_cs_cardbox_01', -- Model for the box the player carries
        DropoffBoxProp = 'prop_boxpile_01a', -- Model for the dropoff location (pile of boxes)
        DropoffPropCoords = vector4(1756.6708, 2499.4097, 44.7407, 298.6996), -- Where the dropoff prop is placed

        CanJump = false, -- Set to true if you want players to be able to jump while holding a box
        CanSprint = true, -- Set to true if you want players to be able to sprint while holding a box
    }
}

-------------------------------
-- 🧻 Toilet Stashes
-------------------------------

Config.ToiletStashInfo = {
    Enabled = true,     -- Enables the toilet stash system (hidden stash spots inside toilets)
    MaxActive = 3,      -- Maximum number of stash zones to activate at once
    Slots = 5,          -- Number of slots in the stash (like an inventory)
    Weight = 5000       -- Maximum weight of items the stash can hold
}

Config.ToiletStashCoords = { -- All possible stash spawn locations in the prison bathrooms (randomly chosen)
    vector3(1767.72, 2502.99, 45.52),
    vector3(1764.58, 2501.18, 45.53),
    vector3(1761.42, 2499.36, 45.49),
    vector3(1755.15, 2495.73, 45.47),
    vector3(1752.0, 2493.91, 45.43),
    vector3(1748.86, 2492.1, 45.48),
    vector3(1767.73, 2503.0, 49.38),
    vector3(1764.58, 2501.18, 49.42),
    vector3(1761.45, 2499.37, 49.37),
    vector3(1758.31, 2497.56, 49.41),
    vector3(1755.14, 2495.73, 49.41),
    vector3(1751.97, 2493.9, 49.42),
    vector3(1748.82, 2492.08, 49.45),
    vector3(1758.16, 2470.46, 45.48),
    vector3(1761.29, 2472.26, 45.42),
    vector3(1764.44, 2474.09, 45.43),
    vector3(1767.56, 2475.88, 45.43),
    vector3(1770.69, 2477.69, 45.45),
    vector3(1773.86, 2479.52, 45.44),
    vector3(1777.02, 2481.34, 45.44),
    vector3(1758.13, 2470.44, 49.36),
    vector3(1761.29, 2472.26, 49.41),
    vector3(1764.43, 2474.08, 49.46),
    vector3(1767.54, 2475.87, 49.35),
    vector3(1770.66, 2477.67, 49.37),
    vector3(1777.01, 2481.34, 49.39),
}


-------------------------------
-- ⛏️ Community Service
-------------------------------

Config.ComServCoords = vector4(-1201.7500, -1800.2966, 3.9086, 70.0877) -- Location where players do community service tasks
Config.ComServReleaseCoords = vector4(-1183.0693, -1773.5372, 3.9085, 303.1825) -- Location to release players after community service

Config.ComServProps = {
    { model = "prop_rub_binbag_sd_01" },  -- Trash bag prop
    { model = "prop_cardbordbox_05a" },   -- Cardboard box prop
    { model = "ng_proc_tyre_01" },        -- Old tire prop
}

Config.ComServAnimation = {
    duration = 4500,
    dict = "anim@amb@drug_field_workers@rake@male_a@base",
    anim = "base",
    prop = "prop_tool_broom",
    bone = 28422,
    pos = vector3(-0.01, 0.04, -0.03),
    rot = vector3(0, 0, 0)
}

Config.ComServ = {
    RemoveItems = true, -- If set to true: all player items will be confiscated. These items can later be retrieved from the prison guard. If false: items are kept and no guard ped will spawn.
    RespawnTime = 10, -- How long (in seconds) before a cleaned prop respawns
    Outline = {
        Enabled = true,                  -- Should props have an outline for players to see them easier?
        Blink = true,                    -- Should the outline blink?
        Color = { r = 72, g = 187, b = 120, a = 255 }, -- Outline color (RGBA)
        Speed = 500                      -- Speed of blinking outline in ms
    },
    CleaningScenario = "WORLD_HUMAN_JANITOR", -- Animation scenario while cleaning

    CommunityServicePolyZone = { -- Polygon zone for the entire community service area
        vec3(-1587.0, -1085.0, 6.0),
        vec3(-1397.0, -1375.0, 6.0),
        vec3(-1348.0, -1465.0, 6.0),
        vec3(-1185.0, -1733.0, 6.0),
        vec3(-1150.0, -1789.0, 6.0),
        vec3(-1273.0, -1901.0, 6.0),
        vec3(-1523.0, -1548.0, 6.0),
        vec3(-1630.0, -1260.0, 6.0),
    }
}

Config.ComServTrash = {
    vector4(-1209.7437, -1830.4808, 2.5593, 127.4095), -- Location of the trash disposal or drop-off
    vector4(-1247.9972, -1832.5280, 2.1465, 74.4071),
    vector4(-1271.0491, -1791.3427, 2.0922, 15.0857),
    vector4(-1276.9249, -1749.6555, 2.5768, 14.2883),
    vector4(-1322.2010, -1735.6211, 1.7045, 47.0501),
    vector4(-1337.0637, -1715.0797, 1.6636, 34.8955),
    vector4(-1336.5973, -1677.8655, 2.1549, 358.9495),
    vector4(-1317.6053, -1647.9121, 3.0608, 328.6714),
    vector4(-1366.1841, -1655.1215, 2.1400, 95.0109),
    vector4(-1384.9491, -1615.8076, 2.1355, 21.3129),
    vector4(-1364.7894, -1564.0175, 3.1587, 337.5625),
    vector4(-1352.2693, -1555.8917, 4.3956, 332.9880),
    vector4(-1407.3175, -1567.8688, 2.1419, 137.0514),
    vector4(-1415.7999, -1527.5210, 2.3446, 353.5094),
    vector4(-1386.2977, -1494.6953, 4.0391, 50.0180),
    vector4(-1433.5938, -1497.6888, 2.1560, 114.7572),
    vector4(-1481.0050, -1483.1981, 2.5099, 68.5255),
    vector4(-1479.7280, -1449.7899, 2.1464, 16.9324),
    vector4(-1464.0638, -1431.3917, 2.1548, 314.6711),
    vector4(-1483.5271, -1401.6794, 2.1475, 58.1099),
}

-------------------------------
-- 🚪 Cells, Cutscene, Release
-------------------------------

Config.ReleaseCutScene = {
    -- Where the player is teleported immediately upon release from prison
    ReleaseCoords = vector4(1846.4431, 2585.6914, 45.6726, 277.9645),

    -- The direction the player will face when the cutscene starts
    heading = 180.0,

    -- Where the player walks during the cutscene (e.g., walking out of prison)
    WalkToCoords = vector4(1852.2715, 2585.8914, 45.6726, 270.5222),

    -- Camera settings for the cutscene (optional cinematic effect)
    CamSettings = {
        CamX = 1854.3851, -- X position of the camera
        CamY = 2582.7332, -- Y position of the camera
        CamZ = 47.6726    -- Z height of the camera
    }
}

Config.CutsceneCell = vector4(1747.6288, 2489.1650, 49.5149, 29.4475)  -- Cell used for cutscene teleport (e.g., intro to prison scene)

Config.CellsLoc = { -- All possible cell spawn locations for prisoners
    vector4(1767.9493, 2500.9873, 45.7407, 203.8192), -- 1
    vector4(1764.33, 2499.19, 45.74, 216.92), -- 2
    vector4(1761.52, 2497.09, 45.74, 203.27), -- 3
    vector4(1755.2, 2493.52, 45.74, 208.79), -- 4
    vector4(1752.19, 2491.79, 45.74, 209.84), -- 5
    vector4(1748.88, 2489.85, 45.74, 211.03), -- 6
    vector4(1768.15, 2500.94, 49.69, 205.45), -- 7
    vector4(1764.79, 2499.28, 49.69, 207.13), -- 8
    vector4(1761.43, 2497.44, 49.69, 210.86), -- 9
    vector4(1758.37, 2495.33, 49.69, 215.36), -- 10
    vector4(1754.86, 2494.17, 49.69, 207.91), -- 11
    vector4(1752.05, 2491.5, 49.69, 210.23), -- 12
    -- vector4(1748.99, 2489.89, 49.69, 208.98), -- 13 Cut Scene Cell
    vector4(1758.34, 2472.36, 45.74, 30.5), -- 14
    vector4(1761.68, 2474.17, 45.74, 26.63), -- 15
    vector4(1764.53, 2475.94, 45.74, 29.93), -- 16
    vector4(1767.97, 2477.9, 45.74, 32.68), -- 17
    vector4(1771.44, 2479.45, 45.74, 34.49), -- 18
    vector4(1774.43, 2481.54, 45.74, 32.09), -- 19
    vector4(1777.44, 2483.44, 45.74, 30.55), -- 20
    vector4(1758.52, 2472.3, 49.69, 29.09), -- 21
    vector4(1761.82, 2474.28, 49.69, 31.04), -- 22
    vector4(1765.05, 2476.47, 49.69, 35.37), -- 23
    vector4(1768.2, 2478.03, 49.69, 30.95), -- 24
    vector4(1771.17, 2479.98, 49.69, 36.08), -- 25
    vector4(1774.45, 2481.43, 49.69, 24.11), -- 26
    vector4(1777.8, 2483.2, 49.69, 36.11), -- 27
}
