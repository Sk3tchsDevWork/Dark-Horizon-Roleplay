Config = {}

-- WHEN UPDATING TO V2 - MOST OF THE NEW CONFIGS ARE IN v2-config.lua BUT THERE ARE SOME CHANGES HERE TOO!
-- Config.Lang table has been moved to shared/lang.lua
-- Pro Tip: Search for NEW to find the new stuff!

Config.DebugMode = false -- Set to false to disable debug messages / BIG RED ZONES
Config.TrashCooldown = 10 -- The time in MINS a player must wait before they can search the same trash again.

Config.AdvancedCheaterCheck = true -- Set to false to disable the advanced cheater check. [WaveShield does not like this..]

Config.JobLocked = false -- Set to 'jobname' to lock the trash functionality to a job. [Default: false - anyone can search the trash] -- Config.JobLocked = {'job1', 'job2', 'job3'}
Config.StashesEnabled = true -- Set to false to disable the stashes

-- [ NEW ] -- 
Config.ClearDumpstersOnRestart = false -- Set to true if you do not want the dumpster storage to be persistent between restarts

--------------------------------

Config.HideInDumpstersEnabled = true -- Set to false to disable the hide in dumpster feature
Config.LeaveDumpsterHeight = 0.5  -- Added height value when leaving dumpster (only for servers that have an issue with players getting stuck or falling through floor on leaving dumpster)

Config.RustleSoundWhenHiding = true -- NEW!! - Set to false to disable the sound when hiding in a dumpster (added in v2 to easily find a player hiding in a dumpster)

Config.ProgressBars = true -- Set to true to enable progress bars (editable in envi-bridge/utils/client.lua) -- work in progress - MAY BE BUGGY - suggested to use false for now - (may be not fully working for all progress bar types, please keep false if you have any issues)

Config.Fails = {
    EnableFail = true, -- Set to false to disable the fail
    EnableRatEvent = true, -- Set to false to disable RAT / RACOON events
    EnableNeedleEvent = true, -- Set to false to disable NEEDLE events
    FailChancePercent = 35, -- The probability, as a percentage, that a player will fail when attempting to search the trash. A higher number means a greater chance of failure.
    DirtyNeedlesChancePercent = 30, -- The chance, as a percentage, of encountering dirty needles when a failure occurs during trash pickup. This only applies if needle events are enabled.
    DirtyNeedlesEffectTime = 90, -- The time, in seconds, that the dirty needles effect will last. This only applies if needle events are enabled.
    RatChancePercent = 80, -- The chance, as a percentage, of encountering a rat OR racoon when a failure occurs during trash pickup. This only applies if rat events are enabled and is calculated after the dirty needles chance.
    DirtyNeedlesHealthLoss = 20, -- The amount of health a player will lose if they are affected by the dirty needles event.
    HealthLoss = 10, -- The of health a player will lose on a generic fail event, where no specific event like dirty needles or a rat is triggered.
    RatHealthLoss = 5, -- The amount of health a player will lose if they are affected by the rat event. This is a fixed value and only applies if rat events are enabled.
    RacoonChancePercent = 70, -- NEW - The chance, as a percentage, of encountering a racoon instead of a rat. This only applies if rat events are enabled.
    RacoonHealthLoss = 25, -- NEW - The fixed amount of health a player will lose if they are affected by the racoon event.
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Aggressive Ped Settings --

Config.AggressivePedsAttack = true -- Set to false to disable hostile hobo events
Config.AggressivePedDistance = 25 -- The distance, in meters, that a player must be from a hobo before they will become hostile. This only applies if hostile hobo events are enabled.
                                  -- BEWARE: This distance is DOUBLED when searching a model from 'otherSearchables' (Homeless Props)

Config.AggressivePeds = {  -- Hobo Models
    'a_m_m_tramp_01',
    'a_m_m_trampbeac_01',
    'A_M_M_Hillbilly_02',
    'A_M_M_RurMeth_01',
    'A_M_M_Salton_01',
    'A_M_M_Salton_02',
    'A_M_M_Salton_03',
    'A_M_M_Salton_04',
    'a_f_m_skidrow_01',
    'a_f_m_trampbeac_01',
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

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Rewards Settings --

Config.RandomSelection = { -- Configuration for the random item selection
    itemCountMin = 1, -- Number of items to select randomly (DEFAULT: random between 1 and 5)
    itemCountMax = 4, -- Number of items to select randomly (DEFAULT: random between 1 and 5)
}
-- NEW! -- Added Rarity (number 1-100) to each item, the higher the number, the rarer the item
Config.BeachCanItems = {
    {name = "plastic", metadata = {}, min = 1, max = 5, rarity = 25},
    {name = "iron", metadata = {}, min = 1, max = 3, rarity = 50},
    {name = "fish", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "treasuremap", metadata = {}, min = 1, max = 1, rarity = 75},
    {name = "empty_weed_bag", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "vodka", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "whiskey", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "tequila", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "lighter", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "lockpick", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "pizza", metadata = {}, min = 1, max = 1, rarity = 25},
    -- ADD AS MANY AS YOU LIKE
}

Config.BeachCanItemsRare = {
    {name = "diamond_ring", metadata = {}, min = 1, max = 1, rarity = 40},
    {name = "gold", metadata = {}, min = 1, max = 2, rarity = 50},
    {name = "rolex", metadata = {}, min = 1, max = 1, rarity = 75},
    {name = "goldchain", metadata = {}, min = 1, max = 1, rarity = 75},
    -- ADD AS MANY AS YOU LIKE
}

Config.BeachCanItemsRareChance = 5 -- The chance, as a percentage, of finding an extra rare item!

--------------------------------------------------------

Config.DumpsterItems = {
    {name = "steel", metadata = {}, min = 1, max = 6, rarity = 25},
    {name = "aluminum", metadata = {}, min = 1, max = 3, rarity = 50},
    {name = "tequila", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "lighter", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "lockpick", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "rubber", metadata = {}, min = 1, max = 6, rarity = 25},
    {name = "wood", metadata = {}, min = 1, max = 3, rarity = 50},
    {name = "acetone", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "bread", metadata = {}, min = 1, max = 1, rarity = 25},
    -- ADD AS MANY AS YOU LIKE
}

Config.DumpsterItemsRare = {
    {name = "10k_goldchain", metadata = {}, min = 1, max = 1, rarity = 40},
    {name = "trojan_usb", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "goldbar", metadata = {}, min = 1, max = 1, rarity = 60},
    {name = "cryptostick", metadata = {}, min = 1, max = 1, rarity = 65},
    {name = "WEAPON_HOBO_PIPE", metadata = {}, min = 1, max = 1, rarity = 70},
    {name = "WEAPON_HOBO_PLANK", metadata = {}, min = 1, max = 1, rarity = 75},
    {name = "WEAPON_HOBO_OLDMACHETE", metadata = {}, min = 1, max = 1, rarity = 80},
    {name = "WEAPON_HOBO_TOILET", metadata = {}, min = 1, max = 1, rarity = 85},
    {name = "WEAPON_HOBO_REBAR", metadata = {}, min = 1, max = 1, rarity = 90},
    -- ADD AS MANY AS YOU LIKE 

}

Config.DumpsterItemsRareChance = 10 -- The chance, as a percentage, of finding an extra rare item!

--------------------------------------------------------

Config.GarbageCanItems = {
    {name = "empty_weed_bag", metadata = {}, min = 1, max = 1, rarity = 15},
    {name = "lighter", metadata = {}, min = 1, max = 1, rarity = 20},
    {name = "bread", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "wood", metadata = {}, min = 1, max = 3, rarity = 40},
    {name = "potato", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "orange", metadata = {}, min = 1, max = 1, rarity = 75},
    {name = "mushroom", metadata = {}, min = 1, max = 1, rarity = 80},
    -- ADD AS MANY AS YOU LIKE
}

Config.GarbageCanItemsRare = {
    {name = "diamond", metadata = {}, min = 1, max = 1, rarity = 60},
    {name = "casino_chips", metadata = {}, min = 1, max = 1, rarity = 70},
    {name = "weed_joint", metadata = {}, min = 1, max = 1, rarity = 75},
    {name = "meth", metadata = {}, min = 1, max = 1, rarity = 85},
    {name = "WEAPON_HOBO_PIPE", metadata = {}, min = 1, max = 1, rarity = 90},
    {name = "WEAPON_HOBO_SPONGE", metadata = {}, min = 1, max = 1, rarity = 95},
    -- ADD AS MANY AS YOU LIKE
}

Config.GarbageCanItemsRareChance = 15 -- The chance, as a percentage, of finding an extra rare item!




----------------------------------------------------------------

Config.OtherSeachablesItems = {
    {name = "empty_weed_bag", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "vodka", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "water", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "acetone", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "lighter", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "cigarette", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "potato", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "orange", metadata = {}, min = 1, max = 1, rarity = 25},
    -- ADD AS MANY AS YOU LIKE
}

Config.OtherSeachablesItemsRare = {
    {name = "casino_chips", metadata = {}, min = 1, max = 1, rarity = 70},
    {name = "weapon_bat", metadata = {}, min = 1, max = 1, rarity = 75},
    {name = "meth", metadata = {}, min = 1, max = 3, rarity = 80},
    {name = "crack_1oz", metadata = {}, min = 1, max = 1, rarity = 85},
    {name = "WEAPON_HOBO_PLANK", metadata = {}, min = 1, max = 1, rarity = 90},
    {name = "WEAPON_HOBO_OLDMACHETE", metadata = {}, min = 1, max = 1, rarity = 95},
    {name = "WEAPON_HOBO_MOP", metadata = {}, min = 1, max = 1, rarity = 98},
    -- ADD AS MANY AS YOU LIKE
}

Config.OtherSeachablesItemsRareChance = 2 -- The chance, as a percentage, of finding an extra rare item!

----------------------------------------------------------------

Config.GarbageBagsItems = {

    {name = "acetone", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "lighter", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "garden_sheers", metadata = {}, min = 1, max = 1, rarity = 40},
    {name = "lettuce", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "tomato", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "potato", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "orange", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "mushroom", metadata = {}, min = 1, max = 1, rarity = 30},
    {name = "empty_weed_bag", metadata = {}, min = 1, max = 1, rarity = 25},
    {name = "vodka", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "water", metadata = {}, min = 1, max = 1, rarity = 25},

    -- ADD AS MANY AS YOU LIKE

}

Config.GarbageBagsItemsRare = {
    {name = "diamond", metadata = {}, min = 1, max = 1, rarity = 50},
    {name = "casino_chips", metadata = {}, min = 1, max = 1, rarity = 60},
    {name = "weed_joint", metadata = {}, min = 1, max = 1, rarity = 75},
    {name = "phone", metadata = {}, min = 1, max = 1, rarity = 80},
    {name = "WEAPON_HOBO_PLANK", metadata = {}, min = 1, max = 1, rarity = 90},
    {name = "WEAPON_HOBO_SHARD", metadata = {}, min = 1, max = 1, rarity = 95},
    -- ADD AS MANY AS YOU LIKE

}


Config.GarbageBagsItemsRareChance = 15 -- The chance, as a percentage, of finding an extra rare item!
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Storage Settings --

Config.BeachCanStorageSlots = 3 -- The number of slots in the beach can storage
Config.BeachCanStorageWeight = 10000 -- The maximum weight of the beach can storage

Config.DumpsterStorageSlots = 12 -- The number of slots in the dumpster storage
Config.DumpsterStorageWeight = 50000 -- The maximum weight of the dumpster storage

Config.GarbageCanStorageSlots = 4 -- The number of slots in the garbage can storage
Config.GarbageCanStorageWeight = 12000 -- The maximum weight of the garbage can storage

Config.OtherStorageSlots = 5 -- The number of slots in the other storage
Config.OtherStorageWeight = 15000 -- The maximum weight of the other storage

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Exclusive Item Zones --
-- IF YOU ARE IN THESE AREAS, YOU WILL SOMETIMES FIND THESE ITEMS INSTEAD

Config.ExclusiveItemZones = {
    {name = "Burgershot",  -- must have a unique name
    coords = vector3(-1179.7351, -904.6566, 13.5210),
    radius = 5.0,
    chance = 75, -- The chance, as a percentage, of finding these items in this area
    restrictedZone = true, -- If true, there is a chance that the police will be called if you are searching this area
    snitchChance = 100, -- The chance, as a percentage, that a snitch will call the police/employees if you are searching this area
    jobsToInform = {'police', 'burgershot'}, -- The jobs that will be informed if a snitch calls the police
    items = {

           {name = "bs_burger", metadata = { quality = 10 }, min = 1, max = 1},
           {name = "bs_fries", metadata = { quality = 10 }, min = 1, max = 1},
           {name = "bs_drink", metadata = { quality = 10 }, min = 1, max = 1},
            {name = "lettuce", metadata = { quality = 10 }, min = 1, max = 1},
            {name = "tomato",  metadata = { quality = 10 }, min = 1, max = 1},
            {name = "potato", metadata = {}, min = 1, max = 1},
            {name = "empty_weed_bag", metadata = {}, min = 1, max = 1},
            -- ADD AS ITEMS MANY AS YOU LIKE
        },
    },

    {name = "Industrial",  -- must have a unique name
    coords = vector3(722.1307, -729.4524, 26.1094),
    radius = 100.0,
    chance = 30, -- The chance, as a percentage, of finding these items in this area
    restrictedZone = false, -- If true, there is a chance that the police will be called if you are searching this area
    snitchChance = false, -- The chance, as a percentage, that a snitch will call the police/employees if you are searching this area
    jobsToInform = {}, -- The jobs that will be informed if a snitch calls the police
    items = {
           {name = "steel", metadata = {}, min = 1, max = 7},
           {name = "plastic", metadata = {}, min = 1, max = 7},
           {name = "aluminum", metadata = {}, min = 1, max = 7},
           {name = "copper", metadata = {}, min = 1, max = 7},
           {name = "iron", metadata = {}, min = 1, max = 7},
           {name = "steel", metadata = {}, min = 1, max = 7},
           {name = "glass", metadata = {}, min = 1, max = 7},
           {name = "rubber", metadata = {}, min = 1, max = 7},
           {name = "wood", metadata = {}, min = 1, max = 7},
            -- ADD AS ITEMS MANY AS YOU LIKE
        },
    },


    {name = "Grove",  -- must have a unique name
    coords = vector3(107.2442, -1941.9656, 20.8037),
    radius = 50.0,
    chance = 10, -- The chance, as a percentage, of finding these items in this area
    restrictedZone = false, -- If true, there is a chance that the police will be called if you are searching this area
    snitchChance = false, -- The chance, as a percentage, that a snitch will call the police/employees if you are searching this area
    jobsToInform = {}, -- The jobs that will be informed if a snitch calls the police
    items = {
           {name = "lockpick", metadata = {}, min = 1, max = 1},
           {name = "empty_weed_bag", metadata = {}, min = 1, max = 1},
           {name = "coke_baggy", metadata = {}, min = 1, max = 1},
           {name = "weapon_knife", metadata = {}, min = 1, max = 1},
           {name = "pistol_ammo", metadata = {}, min = 1, max = 1},
           {name = "glass", metadata = {}, min = 1, max = 1},
           {name = "weed_joint", metadata = {}, min = 1, max = 1},
           {name = "phone", metadata = {}, min = 1, max = 1},
            -- ADD AS ITEMS MANY AS YOU LIKE
        },
    },


    {name = "SuperRareSpot",  -- must have a unique name
    coords = vector3(169.5135, -1224.2314, 29.3662),
    radius = 10.0,
    chance = 5, -- The chance, as a percentage, of finding these items in this area
    restrictedZone = false, -- If true, there is a chance that the police will be called if you are searching this area
    snitchChance = false, -- The chance, as a percentage, that a snitch will call the police/employees if you are searching this area
    jobsToInform = {}, -- The jobs that will be informed if a snitch calls the police
    items = {
           {name = "buzz_saw", metadata = {}, min = 1, max = 1},
           {name = "impact_driver", metadata = {}, min = 1, max = 1},
           {name = "weapon_smg", metadata = {}, min = 1, max = 1},
           {name = "smg_ammo", metadata = {}, min = 1, max = 1},
           {name = "meth_1oz", metadata = {}, min = 1, max = 1},
           {name = "coke_1oz", metadata = {}, min = 1, max = 1},
            -- ADD AS ITEMS MANY AS YOU LIKE
        },
    },

    -- ADD AS MANY ZONES AS YOU LIKE

}



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Target Models --

BeachCans = {
    "prop_bin_beach_01a",
    "prop_bin_beach_01d",
    "prop_bin_delpiero",
    "prop_bin_delpiero_b",
}

Dumpsters = {
    "prop_cs_dumpster_01a",
    "p_dumpster_t",
    "prop_dumpster_01a",
    "prop_dumpster_02a",
    "prop_dumpster_02b",
    "prop_dumpster_3a",
    "prop_dumpster_4a",
    "prop_dumpster_4b",
}

GarbageCans = {
    "prop_bin_01a",
    "prop_bin_02a",
    "prop_bin_03a",
    "prop_bin_04a",
    "prop_bin_05a",
    "prop_bin_06a",
    "prop_bin_07a",
    "prop_bin_07b",
    "prop_bin_07c",
    "prop_bin_07d",
    "prop_bin_08a",
    "prop_bin_08open",
    "prop_bin_09a",
    "prop_bin_10a",
    "prop_bin_10b",
    "prop_bin_11a",
    "prop_bin_11b",
    "prop_bin_12a",
    "zprop_bin_01a_old",
}

OtherSearchables = {
    "prop_skid_tent_01",
    "prop_skid_tent_01b",
    "prop_skid_tent_03",
}

TrashBagModels = {
    'prop_rub_binbag_01b',
    'prop_rub_binbag_04',
    'prop_rub_binbag_06',

    -- ADD MORE IF YOU LIKE, BUT THESE ONES WORK BEST
}

CustomSearchables = {   -- NEW! You can now add your own searchables for any prop!
    [1] = {
        label = 'Steal Luggage',
        models = {
            "prop_suitcase_01",
            "prop_suitcase_01b", 
            "prop_suitcase_01c",
            "prop_suitcase_01d",
            "prop_suitcase_02",
            "prop_suitcase_03b",
            "prop_ld_suitcase_01",
            "prop_ld_suitcase_02",
            "prop_luggage_01a",
            "prop_luggage_02a",
            "prop_luggage_03a",
            "prop_luggage_04a",
            "prop_luggage_05a",
            "prop_luggage_06a",
            "prop_luggage_07a",
            "prop_luggage_08a",
            "prop_luggage_09a",
            "h4_prop_h4_luggage_01a",
            "h4_prop_h4_luggage_02a",

        },
        anims = {
            { dict = 'anim@gangops@van@drive_grab@', anim = 'grab_drive' },
            { dict = 'amb@code_human_in_car_mp_actions@arse_pick@std@ps@base', anim = 'enter' },
            { dict = 'rcmepsilonism8', anim = 'bag_handler_grab_walk_left' },
            { dict = 'anim@scripted@player@freemode@gen_grab@heeled@', anim = 'low_multi' },
            { dict = 'anim@move_m@trash', anim = 'pickup' },
        },
        loot = {
            {name = "money", metadata = {}, min = 1, max = 50, rarity = 70},
            {name = "goldwatch", metadata = {}, min = 1, max = 1, rarity = 90},
            {name = "goldbar", metadata = {}, min = 1, max = 1, rarity = 95},
            {name = "cryptostick", metadata = {}, min = 1, max = 1, rarity = 98},
        },
        isStealing = true, -- If true, this will trigger a police dispatch (Set up your dispatch trigger in cleint_edit.lua)
        deleteProp = true, -- If true, the prop will be deleted after being looted
    },
    [2] = {
        label = 'Steal From Mailbox',
        models = { 'prop_postbox_01a', 'prop_postbox_ss_01a' },
        anims = { 
            { dict = 'anim@move_m@trash', anim = 'pickup' },
            { dict = 'anim@scripted@player@freemode@gen_grab@heeled@', anim = 'low_multi' },
            { dict = 'rcmepsilonism8', anim = 'bag_handler_grab_walk_left' },


        },
        loot = {
            {name = "letter", metadata = {}, min = 1, max = 3, rarity = 30},
            {name = "money", metadata = {}, min = 1, max = 20, rarity = 70},
        },
        isStealing = true,  -- If true, it will trigger a police dispatch (Set up your dispatch trigger in cleint_edit.lua)
        deleteProp = false, -- If true, the prop will be deleted after being looted
    },
}


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Animation Settings --
-- Fail Animations --
Config.RatFailAnim = { dict = 'misscarsteal2_bin', anim = 'trev_sink_exit' }
Config.DirtyNeedlesFailAnim = { dict = 'misscarsteal2_bin', anim = 'trev_sink_exit' }
Config.FailAnim = { dict = 'move_p_m_two_idles@generic', anim = 'fidget_sniff_fingers'} 

-- Search Animations --
BeachCanAnims = {
    { dict = 'anim@gangops@van@drive_grab@', anim = 'grab_drive' },
    { dict = 'amb@code_human_in_car_mp_actions@arse_pick@std@ps@base', anim = 'enter' },
    { dict = 'rcmepsilonism8', anim = 'bag_handler_grab_walk_left' },
    { dict = 'anim@scripted@player@freemode@gen_grab@heeled@', anim = 'low_multi' },
    { dict = 'anim@move_m@trash', anim = 'pickup' },
    { dict = 'anim@heists@prison_heiststation@heels', anim = 'pickup_bus_schedule' },
}

DumpsterAnims = {
    { dict = 'weapons@first_person@aim_idle@generic@melee@knife@shared@core', anim = 'fidget_low_loop' },
    { dict = 'anim@gangops@facility@servers@bodysearch@', anim = 'player_search' },
    { dict = 'anim@gangops@morgue@table@', anim = 'player_search' },
    { dict = 'missexile3', anim = 'ex03_dingy_search_case_a_michael' },
    { dict = 'anim@amb@inspect@crouch@male_a@base', anim = 'base' },
}

GarbageCanAnims = {
    { dict = 'switch@trevor@garbage_food', anim = 'loop_trevor' },
    { dict = 'amb@prop_human_bum_bin@base', anim = 'base' },
    { dict = 'amb@prop_human_bum_bin@idle_b', anim = 'idle_d' },
    { dict = 'anim@heists@money_grab@briefcase', anim = 'enter' },
}

TrashBagAnims = {
    { dict = 'anim@gangops@facility@servers@bodysearch@', anim = 'player_search' },
    { dict = 'missexile3', anim = 'ex03_dingy_search_case_a_michael' },
    { dict = 'amb@medic@standing@kneel@base', anim = 'base' },
    { dict = 'amb@world_human_bum_wash@male@low@base', anim = 'base' },
    { dict = 'anim@am_hold_up@male', anim = 'shoplift_low' },


}


HideInDumpsterAnims ={
    { dict = 'anim@veh@apc@ds@enter_exit_front', anim = 'climb_up' },

}

KickedOutDumpsterAnims = {
    { dict = 'anim@veh@truck@squaddie@rps@enter_exit', anim = 'jump_out'},
   -- { dict = 'anim@veh@low@lm87@ds@enter_exit', anim = 'jump_out' },
}


Config.GetOutKey = 73 -- The key to get out of the dumpster while hiding inside. (Default: X)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Config.Lang table has been moved to shared/lang.lua