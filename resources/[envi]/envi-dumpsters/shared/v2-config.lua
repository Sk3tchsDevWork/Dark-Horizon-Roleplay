Config.Target = true -- Set to false to use envi-interact's NEW "PRESS E" Model Detection - Runs at 0.00ms!

Config.LeaveDumpsterAnim = true -- If true, the player will play an animation when they leave the dumpster.

Config.HoboJobRole = "hobo"

Config.BottleCapItem = "bottle_cap"  -- Custom Bottle Cap Item

Config.LeaveCartKey = "X" -- Key to leave the cart when riding, also changable in Keybinds

Config.DisableHoboKingProgressionFeatures = false -- NEW IN 2.2.0 - If true, this will keep the script as a simple Dumpster Searching system, similar to V1

Config.XPSettings = {
    -- XP requirements per level
    LevelRequirements = {
        [1] = 0, -- Starting level
        [2] = 100,
        [3] = 250,
        [4] = 1000, -- Hobo Job Unlock
        [5] = 2000,
        [6] = 3500,
        [7] = 5000,
        [8] = 7500,
        [9] = 15000,
        [10] = 50000
    },

    -- XP
    XPPerBottleCapDonated = 2, -- XP gained per bottle cap donated

    -- Drug donation XP bonuses (per tsunami)
    DrugDonationXP = {
        ['weed'] = { -- item_name
            label = 'Weed',
            xp = 5
        },
        ['meth'] = { -- item_name
            label = 'Meth',
            xp = 10
        },
        ['cocaine'] = { -- item_name
            label = 'Cocaine',
            xp = 15
        },
        ['heroin'] = { -- item_name
            label = 'Heroin',
            xp = 20
        },
        ['crack'] = { -- item_name
            label = 'Crack',
            xp = 30
        },
        -- Add more if you want
    },

    -- Mission completion XP rewards
    MissionXP = {
        [1] = 50,  -- First Steps
        [2] = 75,  -- Rat Problems
        [3] = 125, -- Professional Beggar
        [4] = 100, -- Thrill Ride
        [5] = 125, -- Supply Chain
        [6] = 150, -- Needle and Thread
        [7] = 175, -- Bum Fights
        [8] = 200, -- The Raccoon Whisperer
        [9] = 200  -- Hobo Taxi
    }
}
-- Hobo King Settings
Config.HoboKing = {
    Position = vector4(123.7565, -1187.1653, 29.5033, 256.7901), -- Position for the Hobo King NPC (x, y, z, heading)
    Model = "a_m_m_tramp_01",                                    -- NPC model
    InactivityTimer = 7,                                         -- Days before Hobo King position is stripped from the current player
    FreedomCost = 250000,                                        -- Cost (in bottle caps) to buy your freedom (when you reach level 10) - Allows players to reconsider their choice of being a Hobo For Life
}



-- Unlockable items per level (To Buy From Hobo King Shop)
Config.Unlockables = {
    [1] = {
        {
            name = "cardboard_bed",
            label = "Cardboard Bed",
            description = "A basic sleeping surface made from recycled cardboard",
            price = 50
        },
    },
    [2] = {
        {
            name = "rat_treats",
            label = "Rat Treats",
            description = "Special treats to keep rats away from your belongings",
            price = 150
        },
        {
            name = "WEAPON_HOBO_PIPE",
            label = "Rusty Pipe",
            description = "A basic weapon for self-defense against rats and other threats",
            price = 2000
        },
    },
    [3] = {
        {
            name = "begging_sign",
            label = "Begging Sign",
            description = "A sign to help you collect more money while begging",
            price = 350
        },
    },
    [4] = {
        {
            name = "WEAPON_HOBO_STICK",
            label = "Hobo Stick",
            description = "A sturdy stick for self-defense and rat hunting",
            price = 3000
        },
        {
            name = "sleeping_bag",
            label = "Sleeping Bag",
            description = "A warm and comfortable sleeping bag for better rest",
            price = 500
        },
    },
    [5] = {
        {
            name = "hobo_gloves",
            label = "Hobo Gloves",
            description = "Protective gloves for handling trash and dangerous items",
            price = 1000
        },
        {
            name = "rat_bait",
            label = "Rat Bait",
            description = "Special bait to attract rats",
            price = 1000
        },
    },
    [6] = {
        {
            name = "hobo_tent",
            label = "Hobo Tent",
            description = "A portable shelter for protection from the elements",
            price = 2500
        },
        {
            name = "hobo_bottle",
            label = "Hobo Bottle",
            description = "A reusable water bottle for hydration",
            price = 1000
        },
    },
    [7] = {
        {
            name = "WEAPON_HOBO_DUSTER",
            label = "Nuts N Bolts",
            description = "Home-made Hobo Knuckle Dusters!",
            price = 5000
        },
    },
    [8] = {
        {
            name = "racoon_treats",
            label = "Raccoon Treats",
            description = "Special treats to tame and befriend raccoons",
            price = 1000
        },
    },
    [9] = {
        {
            name = "ration_pack",
            label = "Ration Pack",
            description = "A pack containing food, water, and medical supplies",
            price = 1500
        },
    },
    [10] = {
        {
            name = "WEAPON_HOBO_TOILET",
            label = "Hobo Toilet",
            description = "A smelly toilet seat to whack people with!",
            price = 10000
        },
        {
            name = "WEAPON_HOBO_DIRTYNEEDLE",
            label = "Dirty Needle",
            description = "A dangerous weapon that can poison enemies",
            price = 50000
        },
        {
            name = "WEAPON_HOBO_OLDMACHETE",
            label = "Old Machete",
            description = "A rusty machete that can be used to your foes!",
            price = 20000
        },
        {
            name = "WEAPON_HOBO_PLANK",
            label = "Broken Plank",
            description = "A wooden plank equipped with rusty nails!",
            price = 10000
        },
        {
            name = "WEAPON_HOBO_REBAR",
            label = "Rebar",
            description = "The Original Home-made Hobo Sledgehammer!",
            price = 30000
        },
    }
}

--------------------------------------------------------------------------------------------

Config.Missions = {
    [1] = {
        name = "First Steps",
        Zones = { -- 5 different marked zones to explore
            vector3(363.2059, 258.2572, 102.9974),
            vector3(-348.2647, -103.7508, 45.6639),
            vector3(-1822.6433, -1211.3577, 13.0173),
            vector3(349.5642, -2038.6068, 21.9663),
            vector3(967.3438, -1869.2826, 31.2881)
        },
        ZoneRadius = 50.0,
        description = "Time for you to get your hands dirty! Explore and search dumpsters in 5 different marked zones!",
        descriptionCompleted =
        "You've proven yourself on these streets. Not everyone has the guts to explore those zones."
    },

    [2] = {
        name = "Rat Problems",
        repeatable = true,
        RatAreas = { -- will choose 3 random areas to clear
            vector3(465.4482, -844.8887, 26.8470),
            vector3(344.3250, -1193.0433, 29.2919),
            vector3(5.7729, -1230.5500, 29.5238),
            vector3(-553.0201, -1713.3948, 18.8629),
            vector3(103.1906, -1811.4915, 26.4984),
            vector3(153.2500, -1187.619, 30.8865),
            vector3(423.5489, -1521.3486, 29.2813),
            vector3(-1179.7357, -904.7003, 13.5206),
            vector3(-361.8564, -961.6348, 31.0806),
            vector3(452.5122, -700.0877, 27.5441),
            vector3(242.8166, -824.6507, 29.9793),
            vector3(337.0464, -1088.4724, 29.4064),
        },
        AreaRadius = 25.0,
        description = "We've got a rat problem on our hands. Go kill as many rats as possible in these 3 areas!",
        descriptionCompleted =
        "Those rats won't be a problem anymore. Good work clearing those infestations. Let me know when you're ready for your next challenge."
    },

    [3] = {
        name = "Professional Beggar",
        repeatable = true,
        RequiredAmount = 1000, -- $1000 to collect
        description = "Time to show the world what you're made of. Go out there and beg for as much money as you can!",
        descriptionCompleted = "Look at you, making money out of thin air! That's a real talent."
    },

    [4] = {
        name = "Thrill Ride",
        repeatable = true,
        RequiredDistance = 1000, -- 1000 meters travelled total
        description =
        "Find a shopping cart and ride it for over 1000 meters total. Experience the thrill of speeding down hills in true hobo style! \n\nSpecial cart derby locations are marked on your map!",
        descriptionCompleted =
        "Now that's what I call a wild ride! You've mastered the art of cart surfing. Not many hobos can claim that skill."
    },

    [5] = {
        name = "Supply Chain",
        repeatable = true,
        RequiredItems = 100, -- 100 junk items
        description =
        "We are desperate for some supplies around here. Go collect 100 junk items and I'll give you access to the hobo recycler.",
        descriptionCompleted =
        "One man's trash is our treasure. You've got a good eye for valuable junk. Feel free to use the recycler at any time."
    },

    [6] = {
        name = "Needle and Thread",
        RequiredDumpsters = 100,
        PackageChance = 5, -- 5% chance to find package after minimum amount of dumpsters
        description =
        "My Child, I'm sick with the Hobo Flu. I need a 'Medical Care Package' to save my life. Search dumpsters to find a 'Medical Care Package' and bring it back to me.. Be quick, I don't have much time..",
        descriptionCompleted =
        "This package will surely save my life. Not many care about the Hobo Kingdom, but you did good, kiddo."
    },

    [7] = {
        name = "Bum Fights",
        RivalLocation = vector4(1422.4708, 6349.4858, 23.9850, 274.0450),
        description =
        "Listen up. This one is important. There used to be a tramp named 'Samuel' around here. Word on the street is that he's been stealing from us! Go teach that punk a lesson!",
        descriptionCompleted = "You fought for our honor and won. That's loyalty I don't see often."
    },

    [8] = {
        name = "The Raccoon Whisperer",
        description =
        "Ive heard that we suddenly have a lot of raccoons around here. They have been taking out our trash and stealing our food. Take these treats and go find and  see if you can tame one of them. ",
        descriptionCompleted = "You tamed one of those wild creatures? Wow.. That's impressive!",
        SpawnLocations = {
            vector3(-90.0, -100.0, 30.0),
            vector3(-120.0, -90.0, 30.0),
            vector3(-140.0, -110.0, 30.0)
        }
    },

    [9] = {
        name = "Hobo Taxi",
        description =
        "You know those Shopping Carts we like to push around? We can use them to get around the city faster! I have Hobo's waiting on a ride. Get them to where they need to go!",
        descriptionCompleted =
        "Now, thats how you get Hobo's from A to B! You can start taxi jobs at any time by coming to see me!",
        repeatable = true,
        PickupLocations = {
            vector4(-55.0349, -1213.8828, 28.7008, 80.5107),
            vector4(-85.8015, -1456.9954, 33.0552, 348.2387),
            vector4(71.0508, -1566.6477, 29.5978, 56.4699),
            vector4(474.6123, -1454.2571, 29.2921, 346.6114),
            vector4(113.1992, -1526.4160, 30.0273, 269.0996),
            vector4(528.0711, -1248.9755, 18.6323, 174.9017),
            vector4(712.4208, -1256.7214, 26.3524, 162.4095),
            vector4(689.0983, -1016.3560, 22.6134, 275.1468),
            vector4(734.5854, -861.9752, 24.7771, 185.4494),
            vector4(455.7884, -869.9780, 27.2786, 12.8067),
            vector4(252.0802, -1073.1123, 29.3775, 21.8393),
            vector4(257.1402, -1108.6440, 29.7341, 186.2960),
            vector4(119.4286, -1578.1511, 29.6025, 335.2963),
            vector4(291.1413, -1234.0590, 29.4379, 79.7148),
            vector4(33.0000, -1433.9170, 30.4820, 238.2740),
            vector4(-21.3212, -1534.7759, 30.1945, 325.4472),
            vector4(-250.3188, -954.5213, 31.2200, 265.7514),
            vector4(-348.8181, -815.8940, 31.5544, 184.2784),
            vector4(696.7436, -1016.4307, 22.7127, 86.6200),
        },
        DropoffLocations = {
            vector4(-55.0349, -1213.8828, 28.7008, 80.5107),
            vector4(-85.8015, -1456.9954, 33.0552, 348.2387),
            vector4(71.0508, -1566.6477, 29.5978, 56.4699),
            vector4(474.6123, -1454.2571, 29.2921, 346.6114),
            vector4(113.1992, -1526.4160, 30.0273, 269.0996),
            vector4(528.0711, -1248.9755, 18.6323, 174.9017),
            vector4(712.4208, -1256.7214, 26.3524, 162.4095),
            vector4(689.0983, -1016.3560, 22.6134, 275.1468),
            vector4(734.5854, -861.9752, 24.7771, 185.4494),
            vector4(455.7884, -869.9780, 27.2786, 12.8067),
            vector4(252.0802, -1073.1123, 29.3775, 21.8393),
            vector4(257.1402, -1108.6440, 29.7341, 186.2960),
            vector4(119.4286, -1578.1511, 29.6025, 335.2963),
            vector4(291.1413, -1234.0590, 29.4379, 79.7148),
            vector4(33.0000, -1433.9170, 30.4820, 238.2740),
            vector4(-21.3212, -1534.7759, 30.1945, 325.4472),
            vector4(-250.3188, -954.5213, 31.2200, 265.7514),
            vector4(-348.8181, -815.8940, 31.5544, 184.2784),
            vector4(696.7436, -1016.4307, 22.7127, 86.6200),
        },
        Rewards = {
            XP = 50,
            BottleCaps = 25
        },
        TimeLimit = 10, -- minutes per delivery
    },

    [10] = {   -- 10 is used for Street Hustler Tasks that unlock at various levels
        name = "Street Hustler",
        unlockLevel = 6,
        description = 'Time to grind for that sweet Hobo Rep! Check out the new tasks I have for you!',
        Tasks = {
            {
                name = "Begging Challenge",
                level = 6,
                type = "begging_challenge",
                description = "Collect $5000 through begging.",
                count = 5000,
                bottleCaps = 100, -- reward
            },
            {
                name = "Collect 250 bottle caps",
                level = 7,
                type = "bottle_collection",
                description = "Go around and collect 250 bottle caps from dumpsters.",
                count = 250,
                bottleCaps = 100, -- bonus reward
            },
            {
                name = "Cart Derby Tournament",
                level = 8,
                type = "cart_derby_tournament",
                description = "Host a Cart Derby tournament with at least 5 riders!",
                count = 5,        -- Minimum participants
                bottleCaps = 200, -- reward
            },
            {
                name = "Hobo Bowling",
                level = 9,
                type = "hobo_bowling",
                description = "Host a game of Hobo Bowling with at least 5 players!",
                count = 5,        -- Minimum participants
                bottleCaps = 150, -- reward
            },
            {
                name = "Hobo Taxi",
                level = 10,
                type = "hobo_taxi",
                description = "Complete taxi missions and get paid!",
            }
        }
    },

    [11] = {
        name = "The Ultimate Challenge",
        XPtoUnlock = 500000,
        repeatable = true,
        ChallengeLocation = vector4(134.7184, -1184.7572, 29.5015, 156.0000)
    },
}

---------------------------------------------------------------------------------------------------------

Config.ItemSettings = {
    -- Level 1
    cardboard_bed = {
        model = "prop_rub_cardpile_05",
        regeneration = 1 -- Health per 5 seconds
    },

    -- Level 2
    rat_treats = {
        uses = 1 -- Number of rat attacks it prevents
    },

    -- Level 4
    sleeping_bag = {
        model = "prop_skid_sleepbag_1",
        regeneration = 2 -- Health per tick
    },

    -- Level 6
    hobo_tent = {
        model = "prop_tent_01",
        regeneration = 3, -- Health per tick
    },

    -- Level 7
    hobo_bottle = {
        capacity = 3,  -- Number of uses
        hydration = 25 -- Thirst reduction per use
    },

    -- Level 8
    racoon_treats = {
        duration = 30 -- Minutes the raccoon companion lasts
    },

    -- Level 9
    ration_pack = {
        provides = {
            { item = "burger",  max = 3 },
            { item = "water",   max = 2 },
            { item = "bandage", max = 1 },
        }
    },
}

---------------------------------------------------------------------------------------------------------

Config.BeggingSettings = {
    BegCommand = "beg",
    IgnoreChance = 65,           -- 65% chance to be completely ignored
    MaxBaseReward = 25,          -- Maximum reward amount before multiplier
    MaxTotalReward = 100,        -- Maximum reward amount after multipliers have been applied
    BegWithSignMultiplier = 1.5, -- 1.5x reward for begging with a sign
    TrueHoboMultiplier = 2,      -- 2x reward for true hobos (has hobo job)
    AggressivePedChance = 10,    -- 10% chance for npcs to become aggressive when begging
    BegCooldown = 10,            -- seconds
    ProgressBar = false,         -- if true, the progress bar will be shown when begging

    -- NEW IN 2.2.0 - Car Cleaning --
    CleanCars = true,            -- if true, the player can clean cars
    MinCleanCarReward = 1,    -- minimum reward for cleaning a car
    MaxCleanCarReward = 50,    -- maximum reward for cleaning a car
    MinCleanTime = 7,          -- minimum time for cleaning a car (in seconds)
    MaxCleanTime = 15,         -- maximum time for cleaning a car (in seconds)
    AggressiveCleanCarChance = 50, -- 50% chance for npcs to become aggressive when cleaning a car
}

---------------------------------------------------------------------------------------------------------

Config.RatBaitDuration = 60 -- Seconds

---------------------------------------------------------------------------------------------------------

-- Additional Junk Items you will find in dumpsters - (For Hobo Recycler)
Config.JunkItems = {
    Items = {
        -- Common items (50% chance)
        common = {
            chance = 50,
            items = {
                { name = Config.BottleCapItem,  amount = { 1, 1 }, chance = 20 }, -- needed for progression
                { name = "wooden_junk", amount = { 1, 3 }, chance = 60 },
                { name = "copper_junk", amount = { 1, 2 }, chance = 60 },
            }
        },
        -- Uncommon items (30% chance)
        uncommon = {
            chance = 35,
            items = {
                { name = Config.BottleCapItem,      amount = { 1, 2 }, chance = 20 },
                { name = "scrap_junk",      amount = { 1, 3 }, chance = 40 },
                { name = "cloth_junk",      amount = { 1, 3 }, chance = 40 },
                { name = "plastic_junk",    amount = { 1, 3 }, chance = 40 },
                { name = "electronic_junk", amount = { 1, 3 }, chance = 10 },
            }
        },
        -- Rare items (15% chance)
        rare = {
            chance = 25,
            items = {
                { name = Config.BottleCapItem,      amount = { 2, 3 }, chance = 50 }, -- needed for progression
                { name = "electronic_junk", amount = { 1, 2 }, chance = 30 },
                { name = "broken_phone",    amount = { 1, 1 }, chance = 20 },
            }
        },
        -- Very rare items (5% chance)
        very_rare = {
            chance = 15,
            items = {
                { name = Config.BottleCapItem,    amount = { 3, 4 }, chance = 40 }, -- needed for progression
                { name = "food_waste",    amount = { 1, 1 }, chance = 10 },
                { name = "medical_waste", amount = { 1, 1 }, chance = 5 }
            }
        }
    }
}

Config.RecyclerLocations = {
    [1] = {
        coords = vector3(175.5112, -1200.5493, 29.2951),
        heading = 181.5229,
    },
}

Config.RecycleSettings = {
    duration = 5,             -- time in seconds to recycle
    unlockedByMission = false, -- set this to false if you want the recycler to be unlocked to everyone
}


-- PLEASE NOTE: Make sure you change the `material` to the item you will get back make sure you have this item in your server
Config.RecyclingItems = {
    [Config.BottleCapItem] = {
        material = "metalscrap",
        min = 1,
        max = 3,
    },
    ["scrap_junk"] = {
        material = "metalscrap",
        min = 1,
        max = 2,
    },
    ["cloth_junk"] = {
        material = "cloth",
        min = 1,
        max = 2,
    },
    ["plastic_junk"] = {
        material = "plastic",
        min = 1,
        max = 2,
    },
    ["electronic_junk"] = {
        material = "electronic_scrap",
        min = 1,
        max = 2,
    },
    ["broken_phone"] = {
        material = "electronic_scrap",
        min = 1,
        max = 2,
    },
    ["food_waste"] = {
        material = "compost",
        min = 1,
        max = 2,
    },
    ["medical_waste"] = {
        material = "bandage",
        min = 1,
        max = 2,
    },
    ["paper_junk"] = {
        material = "paper",
        min = 1,
        max = 2,
    },
    ["glass_junk"] = {
        material = "glass",
        min = 1,
        max = 2,
    },
    ["wooden_junk"] = {
        material = "wood",
        min = 1,
        max = 2,
    },
}

---------------------------------------------------------------------------------------------------------------

Config.CartDerby = {
    ConstantBlips = false, -- If false, the blips will only be revealed while on the Thrill Ride mission
    BlipScale = 0.8, -- Scale of the blips
    Tracks = {
        [1] = {
            name = "Downhill Trail",
            npc = vector4(1424.4292, -858.0736, 111.7589, 79.1301),
            cartLocation = vector4(1422.9073, -858.9063, 111.6167, 283.2439),
            startPoint = vector4(1420.2488, -858.6202, 110.3647, 100.0),
            startPointRadius = 10.0,
            showStartZone = true,
        },
        [2] = {
            name = "Rockford Hills",
            npc = vector4(-580.7780, 914.7377, 229.1532, 132.8778),
            cartLocation = vector4(-582.0977, 915.7252, 229.1067, 87.6015),
            startPoint = vector4(-583.7144, 912.3519, 226.6051, 148.9423),
            startPointRadius = 25.0,
            showStartZone = true,
        },
        [3] = {
            name = "Observatory",
            npc = vector4(-436.8737, 1058.2284, 319.9926, 189.9796),
            cartLocation = vector4(-438.5188, 1057.2852, 320.2427, 113.5812),
            startPoint = vector4(-436.8737, 1058.2284, 318.9926, 189.9796),
            startPointRadius = 25.0,
            showStartZone = true,
        },
        [4] = {
            name = "Mount Chiliad",
            npc = vector4(498.5247, 5605.1328, 797.9094, 186.4537),
            cartLocation = vector4(500.1170, 5605.1621, 797.9094, 270.1760),
            startPoint = vector4(498.5247, 5605.1328, 796.9094, 186.4537),
            startPointRadius = 40.0,
            showStartZone = true,
        },
        [5] = {
            name = "Chiliad Trail",
            npc = vector4(-89.5027, 4950.2090, 385.4798, 239.1310),
            cartLocation = vector4(-88.6888, 4950.9355, 385.9283, 221.7422),
            startPoint = vector4(-89.5027, 4950.2090, 385.4798, 239.1310),
            startPointRadius = 25.0,
            showStartZone = true,
        },
        [6] = {
            name = "Thrill Valley",
            npc = vector4(1783.2324, -250.6645, 292.1313, 123.0405),
            cartLocation = vector4(1782.6484, -248.8291, 292.0567, 91.9719),
            startPoint = vector4(1783.2324, -250.6645, 292.1313, 123.0405),
            startPointRadius = 25.0,
            showStartZone = true,
        },
        -- Add more locations if you like
    }
}

------------------------------------------------------------------------

Config.PoisonWeapons = {
    [1] = {
        weapon = -1638292314, -- RAT STICK
        damagePerSecond = 1,
        poisonDuration = 60,  -- seconds
        antidoteItem = "rabies_shot",
    },
    [2] = {
        weapon = `WEAPON_HOBO_DIRTYNEEDLE`,
        damagePerSecond = 2,
        poisonDuration = 600, -- seconds
        antidoteItem = "tetanus_shot",
    },
}

------------------------------------------------------------------------------------------------------------
-- Hobo Bowling (AKA The Stupidest MiniGame I ever made.. Have Fun! :D ) --

Config.HoboBowling = {
    Enabled = true,
    MaxPlayers = 10,
    MinPlayers = 1,
    PointsPerPin = 1,
    StrikeBonus = 3,
    WinnerXP = 10,              -- XP times number of players
    PlayerStartDistance = 15.0, -- Maximum distance from start position allowed before fouling
    PinSpacing = 0.8,

    Locations = {
        {
            name = "Downtown Lanes",
            laneHeading = -230.0,                                           -- The heading/rotation of the bowling lane
            showFoulZone = true,
            npc = vector4(222.3060, -1772.6326, 29.1146, 332.5828),         -- Host NPC
            alley = vector4(229.5850, -1775.9917, 28.8357, 229.7295),       -- Center of alley
            pins = vector4(237.4855, -1782.4124, 28.8041, 43.8897),         -- Pin formation center
            playerStart = vector4(218.3922, -1766.5566, 29.0030, 228.8056), -- Where players must start from
            foulLine = vector4(230.6213, -1774.8726, 28.7465, 320.2130),    -- Line players must not cross
            cartSpawn = vector4(219.4123, -1767.5861, 29.0150, 224.3853),   -- Where cart spawns
        },
        -- Add More if you like
    },

    BowlingHostModel = "a_m_m_skidrow_01",
    PinLeaderModel = "a_m_m_trampbeac_01", -- Model for the NPC at front of pins
    PinPedModels = {
        'a_m_m_trampbeac_01',
        'a_f_m_skidrow_01',
        'a_f_o_salton_01',
        'a_f_y_hippie_01',
        'a_f_y_rurmeth_01',
        'a_m_m_skidrow_01',
        'a_m_o_tramp_01',
        'a_m_o_beach_01',
        'a_m_o_salton_01',
        'a_m_o_soucent_02',
        'a_m_o_soucent_03',
        'a_m_y_methhead_01',
        'a_m_y_salton_01',
    }
}

--------------------------------------------------------------------
-- Aggressive Ped Weapons -- NEW --
--------------------------------------------------------------------

Config.AggressivePedWeapons = {
    ChanceThresholds = {
        Rare = 80,
        Uncommon = 65,
        Common = 20,
    },

    Weapons = {
        Rare = {
            name = "WEAPON_PISTOL",
            ammo = 12  -- Amount of ammo to give with the weapon
        },
        Uncommon = {
            name = "WEAPON_KNIFE",
            ammo = 0   -- Melee weapons don't need ammo
        },
        Common = {
            name = "WEAPON_BOTTLE",
            ammo = 0   -- Melee weapons don't need ammo
        }
    },

    GiveHoboWeapon = {
        enabled = true,
        chance = 20,  -- 20% chance to give a hobo weapon instead of standard weapons
        weapons = {
            "WEAPON_HOBO_PIPE",
            "WEAPON_HOBO_PLANK",
            "WEAPON_HOBO_OLDMACHETE",
            "WEAPON_HOBO_STICK",
            "WEAPON_HOBO_REBAR"
        }
    }
}