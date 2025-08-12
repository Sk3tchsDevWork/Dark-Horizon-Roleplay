Config.contracts.house = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 35,
        expiry = 24 * 60,
        timeToStart = 2 * 60,
        minMembers = 2,
        -- maxMembers = 4,
        minPolice = 0,
        -- maxStartedLimit = 2
    },

    -- the max duration before the house resets in minutes
    duration = 60,

    -- only available at night
    nightOnly = false,

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_house_title'),
        message = locale('dispatch_house_message'),
    },

    blip = {
        name = locale('target_house'),
        sprite = 492,
        size = 0.75,
        color = 1
    },

    lockpickItem = {
        name = 'lockpick',
        removeAfterUse = false
    },

    hackingItem = {
        name = 'hack_card',
        removeAfterUse = false
    },

    -- Items that are heavy and need to be carried with an animation
    carryItems = {
        enabled = true, -- will detect from inventory
        list = {
            { name = 'tv',        anim = { dict = 'anim@heists@box_carry@', clip = 'idle' }, prop = { model = `prop_tv_flat_03`, pos = vector3(0.0, -0.1, -0.05), rot = vector3(10.0, 0.0, 0.0) } },
            { name = 'microwave', anim = { dict = 'anim@heists@box_carry@', clip = 'idle' }, prop = { model = `prop_micro_02`, pos = vector3(0.0, -0.1, -0.02), rot = vector3(10.0, 0.0, 0.0) } },
            { name = 'monitor',   anim = { dict = 'anim@heists@box_carry@', clip = 'idle' }, prop = { model = `prop_monitor_w_large`, pos = vector3(0.0, -0.1, -0.175), rot = vector3(-30.0, 0.0, 0.0) } },
            { name = 'printer',   anim = { dict = 'anim@heists@box_carry@', clip = 'idle' }, prop = { model = `prop_printer_01`, pos = vector3(0.18, -0.11, 0.24), rot = vector3(-80.0, 6.0, 36.0) } },
            { name = 'flat_tv',   anim = { dict = 'anim@heists@box_carry@', clip = 'idle' }, prop = { model = `prop_tv_flat_01`, pos = vector3(0.0, -0.1, -0.175), rot = vector3(10.0, 0.0, 0.0) } },
            { name = 'old_tv',    anim = { dict = 'anim@heists@box_carry@', clip = 'idle' }, prop = { model = `prop_tv_03`, pos = vector3(0.0, -0.3, 0.25), rot = vector3(-30.0, 0.0, 0.0) } },
            { name = 'dj_deck',   anim = { dict = 'anim@heists@box_carry@', clip = 'idle' }, prop = { model = `prop_dj_deck_02`, pos = vector3(-0.35, -0.05, -0.05), rot = vector3(40.0, 0.0, 0.0) } },
            { name = 'console',   anim = { dict = 'anim@heists@box_carry@', clip = 'idle' }, prop = { model = `prop_console_01`, pos = vector3(0.0, -0.1, -0.12), rot = vector3(10.0, 0.0, 0.0) } },
        }
    },

    ---@class HouseTier
    ---@field label string
    ---@field image string
    ---@field price number
    ---@field chance number
    ---@field requiredExperience number
    ---@field reward { crypto: number, experience: number }

    ---@type table<string, HouseTier>
    tiers = {
        ['low'] = {
            label = locale('house_tier_low'),
            image = './contracts/house_low.jpg',
            price = 25,
            chance = 40,
            requiredExperience = 0,
            reward = { crypto = 0, experience = 100 }
        },
        ['medium'] = {
            label = locale('house_tier_medium'),
            image = './contracts/house_medium.jpg',
            price = 50,
            chance = 30,
            requiredExperience = 0,
            reward = { crypto = 0, experience = 150 }
        },
        ['high'] = {
            label = locale('house_tier_high'),
            image = './contracts/house_high.jpg',
            price = 50,
            chance = 12,
            requiredExperience = 0,
            reward = { crypto = 0, experience = 200 }
        },
        ['high2'] = {
            label = locale('house_tier_high'),
            image = './contracts/house_high.jpg',
            price = 50,
            chance = 12,
            requiredExperience = 0,
            reward = { crypto = 0, experience = 200 }
        },
        ['mafia'] = {
            label = locale('house_tier_mafia'),
            image = './contracts/house_mafia.jpg',
            price = 150,
            chance = 50,
            requiredExperience = 0,
            reward = { crypto = 0, experience = 250 }
        },
        ['celebrity'] = {
            label = locale('house_tier_celebrity'),
            image = './contracts/house_celebrity.jpg',
            price = 100,
            chance = 50,
            requiredExperience = 0,
            reward = { crypto = 0, experience = 250 }
        },
    },

    -- low, medium = no security
    -- high, high2 = lasers + guy
    -- cartel = guards outside + inside and drug loot
    -- politician = guards outside + inside, cash loot and drop from politician guy
    -- celebrity = guards outside + inside, panther and drop from celebrity guy
    interiors = {
        ['low'] = {
            interiorId = 149761,
            coords = vector4(266.1480, -1007.0334, -100.9261, 6.3342),
            exit = vector3(266.0445, -1007.7493, -100.9142), --Target coords
            alarm = {
                coords = vector3(262.5287, -997.9499, -97.1937),
                duration = 60,
            },
            takeLoot = {
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(266.3729, -999.3958, -99.4688),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_snspistol', count = 1, chance = 5 },
                        { name = 'money',            min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(259.7645, -1004.7181, -98.9429),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_pistol', count = 1, chance = 2 },
                        { name = 'money',         min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(261.3701, -1002.2678, -99.5198),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_knife', count = 1, chance = 25 },
                        { name = 'money',        min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(256.8184, -995.3713, -99.5583),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_combatpistol', count = 1,  chance = 1 },
                        { name = 'money',               min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search fridge',
                    progress = 'Searching fridge...',
                    icon = 'magnifying-glass',
                    coords = vector3(266.0520, -997.6392, -99.0526),
                    -- maxItemCount = 4, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'burger',  min = 1, max = 3 },
                        { name = 'water',   min = 1, max = 4 },
                        { name = 'cola',    min = 1, max = 3 },
                        { name = 'mustard', min = 1, max = 2, chance = 25 }
                    }
                },
                {
                    label = 'Take TV',
                    progress = 'Taking TV...',
                    icon = 'tv',
                    removeProp = `prop_tv_flat_03`,
                    coords = vector3(262.682251, -1001.860291, -99.094826),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'tv', count = 1 }
                    }
                },
                {
                    label = 'Take console',
                    progress = 'Taking console...',
                    icon = 'gamepad',
                    removeProp = `prop_console_01`,
                    coords = vector3(263.268097, -1001.897156, -99.243446),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'console', count = 1 }
                    }
                },
                {
                    label = 'Take DJ deck',
                    progress = 'Taking DJ deck...',
                    icon = 'music',
                    removeProp = `prop_dj_deck_02`,
                    coords = vector3(261.376495, -1001.875000, -99.060310),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'dj_deck', count = 1 }
                    }
                },
                {
                    label = 'Take bong',
                    progress = 'Taking bong...',
                    icon = 'bong',
                    removeProp = `prop_bong_01`,
                    coords = vector3(258.946289, -996.472168, -99.418854),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'bong', count = 1 }
                    }
                },
                {
                    label = 'Take microwave',
                    progress = 'Taking microwave...',
                    icon = 'box',
                    removeProp = `prop_micro_02`,
                    coords = vector3(266.350647, -994.849182, -98.872223),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'microwave', count = 1 }
                    }
                },
                {
                    label = 'Take television',
                    progress = 'Taking television...',
                    icon = 'tv',
                    removeProp = `prop_tv_03`,
                    coords = vector3(256.841858, -995.502991, -98.856636),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'old_tv', count = 1 }
                    }
                }
            },
            removeProps = {
                { coords = vector3(266.371857, -994.617615, -98.598289), model = `v_res_fa_bread01` },
                { coords = vector3(266.371857, -994.617615, -98.598289), model = `v_res_tt_cereal01` },
            }

        },
        ['medium'] = {
            interiorId = 148225,
            coords = vector4(346.5103, -1012.8331, -99.1963, 2.6530),
            exit = vector3(346.5015, -1013.4432, -99.0546), --Target coords
            takeLoot = {
                {
                    label = 'Search drawers',
                    progress = 'Searching drawers...',
                    icon = 'magnifying-glass',
                    coords = vector3(345.779083, -1001.731201, -99.422195),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_snspistol', count = 1, chance = 5 },
                        { name = 'money',            min = 1500, max = 3500 }
                    }
                },
                {
                    label = 'Search drawers',
                    progress = 'Searching drawers...',
                    icon = 'magnifying-glass',
                    coords = vector3(339.320465, -1003.717346, -99.760216),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_snspistol', count = 1, chance = 5 },
                        { name = 'money',            min = 1500, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(351.2758, -999.5255, -99.6274),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_pistol', count = 1, chance = 2 },
                        { name = 'money',         min = 1500, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(351.271698, -993.244995, -99.040894),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_knife', count = 1, chance = 25 },
                        { name = 'money',        min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(350.060791, -993.242981, -99.053970),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_knife', count = 1, chance = 25 },
                        { name = 'money',        min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search drawers',
                    progress = 'Searching drawers...',
                    icon = 'magnifying-glass',
                    coords = vector3(348.924316, -994.842102, -99.770111),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_knife', count = 1, chance = 25 },
                        { name = 'money',        min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search chest',
                    progress = 'Searching chest...',
                    icon = 'magnifying-glass',
                    coords = vector3(352.235382, -998.780640, -99.881340),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_combatpistol', count = 1,  chance = 1 },
                        { name = 'money',               min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search shelves',
                    progress = 'Searching shelves...',
                    icon = 'magnifying-glass',
                    coords = vector3(340.8763, -1003.8358, -99.0130),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_combatpistol', count = 1,  chance = 1 },
                        { name = 'money',               min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search fridge',
                    progress = 'Searching fridge...',
                    icon = 'magnifying-glass',
                    coords = vector3(344.5275, -1001.1649, -99.2142),
                    -- maxItemCount = 4, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'burger',  min = 1, max = 3 },
                        { name = 'water',   min = 1, max = 4 },
                        { name = 'cola',    min = 1, max = 3 },
                        { name = 'mustard', min = 1, max = 2, chance = 25 }
                    }
                },
                {
                    label = 'Take TV',
                    progress = 'Taking TV...',
                    icon = 'tv',
                    removeProp = `prop_tv_flat_01`,
                    coords = vector3(337.369995, -996.651428, -98.598854),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'flat_tv', count = 1 }
                    }
                },
                {
                    label = 'Take microwave',
                    progress = 'Taking microwave...',
                    icon = 'box',
                    removeProp = `prop_micro_01`,
                    coords = vector3(344.693634, -1002.065247, -99.064384),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'microwave', count = 1 }
                    }
                },
            },
            props = {
                {
                    model = `prop_shelves_02`,
                    coords = vector4(350.7985, -1007.5171, -100.1964, 90.0),
                }
            }
        },
        ['high'] = {
            interiorId = 207105,
            coords = vector4(-174.2918, 497.6930, 137.6526, 191.6170),
            exit = vector3(-174.3980, 498.1899, 137.7588), --Target coords
            silent = true,                                 -- lasers and alarm has to be defined
            alarm = {
                coords = vector3(-169.9928, 486.4431, 140.2542),
                duration = 60,
            },
            lasers = {
                {
                    origins = {
                        vector3(-172.9193, 489.6176, 136.5334),
                        vector3(-172.9242, 489.6427, 139.2815),
                    },
                    targets = {
                        vector3(-163.3953, 491.2119, 136.5527),
                        vector3(-163.3861, 491.1645, 139.2687),
                    },
                },
                {
                    origin = vector3(-169.9222, 489.0767, 139.4125),
                    targets = {
                        vector3(-173.4356, 492.7072, 136.6535),
                        vector3(-168.9881, 490.9006, 136.4436),
                        vector3(-168.8206, 484.5504, 136.2442),
                    },
                },
                {
                    origins = {
                        vector3(-171.1152, 492.6556, 136.0537),
                        vector3(-178.3149, 492.3770, 136.0537),
                        vector3(-173.1434, 496.9373, 136.0537),
                    },
                    targets = {
                        vector3(-171.1152, 492.6556, 132.8437),
                        vector3(-178.3149, 492.3770, 132.8437),
                        vector3(-173.1434, 496.9373, 132.8437),
                    },
                },
                {
                    origin = vector3(-173.5278, 495.2104, 130.5427),
                    targets = {
                        vector3(-174.4353, 501.0284, 129.1493),
                        vector3(-174.2841, 501.0578, 132.1197),
                    },
                },
                {
                    origins = {
                        vector3(-180.0568, 499.6620, 136.1386),
                        vector3(-179.1131, 494.7946, 136.1055),
                    },
                    targets = {
                        vector3(-176.8225, 500.2828, 136.1436),
                        vector3(-175.8531, 495.3848, 136.1512),
                    },
                },
                {
                    origins = {
                        vector3(-176.8271, 500.3004, 132.3512),
                        vector3(-175.9081, 495.5732, 132.3397),
                    },
                    targets = {
                        vector3(-180.0335, 499.5404, 132.2192),
                        vector3(-179.1163, 494.8198, 132.3108),
                    },
                }
            },
            takeLoot = {
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-172.1232, 486.6920, 136.9652),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_snspistol', count = 1, chance = 5 },
                        { name = 'money',            min = 500, max = 1000 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-171.1154, 482.4599, 136.8367),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_pistol', count = 1, chance = 2 },
                        { name = 'money',         min = 500, max = 1000 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-170.846878, 481.954803, 133.422211),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_knife', count = 1, chance = 25 },
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-175.4622, 489.6720, 129.3880),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_combatpistol', count = 1,  chance = 1 },
                        { name = 'money',               min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search closet',
                    progress = 'Searching closet...',
                    icon = 'magnifying-glass',
                    coords = vector3(-167.6694, 488.6797, 133.9791),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'money',   min = 100, max = 200 },
                        { name = 'bandage', min = 1,   max = 2,  chance = 15 }
                    }
                },
                {
                    label = 'Search fridge',
                    progress = 'Searching fridge...',
                    icon = 'magnifying-glass',
                    coords = vector3(-170.3485, 496.3442, 137.8943),
                    -- maxItemCount = 4, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'burger',  min = 1, max = 3 },
                        { name = 'water',   min = 1, max = 4 },
                        { name = 'cola',    min = 1, max = 3 },
                        { name = 'mustard', min = 1, max = 2, chance = 25 }
                    }
                },
                {
                    label = 'Take ammo',
                    progress = 'Taking ammo...',
                    icon = 'magnifying-glass',
                    coords = vector3(-176.672348, 491.897461, 130.194458),
                    -- maxItemCount = 3, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'ammo-9',     min = 30, max = 90 },
                        { name = 'ammo-45',    min = 30, max = 90 },
                        { name = 'ammo-rifle', min = 30,  max = 90 }
                    }
                },
                {
                    label = 'Take monitor',
                    progress = 'Taking monitor...',
                    icon = 'desktop',
                    removeProp = `prop_monitor_w_large`,
                    coords = vector3(-169.107544, 493.102234, 130.157806),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'monitor', count = 1 }
                    }
                },
                {
                    label = 'Take monitor',
                    progress = 'Taking monitor...',
                    icon = 'desktop',
                    removeProp = `prop_monitor_w_large`,
                    coords = vector3(-168.975555, 492.264038, 130.151062),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'monitor', count = 1 }
                    }
                },
                {
                    label = 'Take keyboard',
                    progress = 'Taking keyboard...',
                    icon = 'keyboard',
                    removeProp = `prop_keyboard_01b`,
                    coords = vector3(-169.336121, 492.851044, 129.796936),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'keyboard', count = 1 }
                    }
                },
                {
                    label = 'Take laptop',
                    progress = 'Taking laptop...',
                    icon = 'laptop',
                    removeProp = `prop_laptop_01a`,
                    coords = vector3(-169.751175, 490.136475, 129.788208),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'laptop', count = 1 }
                    }
                },
                {
                    label = 'Take bong',
                    progress = 'Taking bong...',
                    icon = 'bong',
                    removeProp = `prop_bong_01`,
                    coords = vector3(-166.398056, 482.312927, 136.862656),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'bong', count = 1 }
                    }
                },
                {
                    label = 'Take microwave',
                    progress = 'Taking microwave...',
                    icon = 'box',
                    removeProp = `prop_micro_02`,
                    coords = vector3(-164.572800, 494.546204, 137.774277),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'microwave', count = 1 }
                    }
                },
                {
                    label = 'Take television',
                    progress = 'Taking television...',
                    icon = 'tv',
                    createProp = `prop_tv_flat_01`,
                    coords = vector4(-162.105637, 482.747162, 137.667984, 280.0),
                    -- maxItemCount = 1, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'flat_tv', count = 1 }
                    }
                }
            },
            removeProps = {
                { coords = vector3(-162.088760, 482.660339, 137.508469), model = `apa_mp_h_str_avunits_04` },
            }
        },
        ['high2'] = {
            interiorId = 206337,
            coords = vector4(373.6751, 423.7777, 145.9077, 165.6453),
            exit = vector3(373.7589, 424.1247, 146.1238), --Target coords
            silent = true,
            alarm = {
                coords = vector3(372.4842, 411.2873, 147.7000),
                duration = 60,
            },
            takeLoot = {
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(370.096313, 412.714752, 145.301773),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_snspistol', count = 1 },
                        { name = 'money',            min = 500, max = 1000 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(368.892853, 408.388580, 145.068726),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_pistol', count = 1, chance = 75 },
                        { name = 'money',         min = 500, max = 1000 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(368.776428, 407.780579, 141.604218),
                    -- maxItemCount = 4, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_knife', count = 1, chance = 75 },
                        { name = 'weapon_combatpistol', count = 1, chance = 50 },
                        { name = 'at_suppressor_heavy', count = 1, chance = 25 },
                        { name = 'money',        min = 500, max = 1000 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(370.738800, 426.283325, 138.577148),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_combatpistol', count = 1,  chance = 75 },
                        { name = 'money',               min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(379.4936, 432.2881, 137.6937),
                    -- maxItemCount = 3, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'weapon_combatpistol', count = 1,  chance = 20 },
                        { name = 'bandage', min = 1, max = 3 },
                        { name = 'money',               min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search closet',
                    progress = 'Searching closet...',
                    icon = 'magnifying-glass',
                    coords = vector3(374.5806, 412.5718, 142.1029),
                    -- maxItemCount = 2, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'money',   min = 100, max = 200 },
                        { name = 'bandage', min = 1,   max = 2,  chance = 15 }
                    }
                },
                {
                    label = 'Search fridge',
                    progress = 'Searching fridge...',
                    icon = 'magnifying-glass',
                    coords = vector3(375.3543, 420.6396, 146.0973),
                    -- maxItemCount = 4, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'burger',  min = 1, max = 3 },
                        { name = 'water',   min = 1, max = 4 },
                        { name = 'cola',    min = 1, max = 3 },
                        { name = 'mustard', min = 1, max = 2, chance = 25 }
                    }
                },
                {
                    label = 'Take ammo',
                    progress = 'Taking ammo...',
                    icon = 'magnifying-glass',
                    coords = vector3(379.736267, 429.754791, 138.452606),
                    -- maxItemCount = 3, -- the maximum number of items selected from the items list
                    items = {
                        { name = 'ammo-9',     min = 30, max = 90 },
                        { name = 'ammo-45',    min = 30, max = 90 },
                        { name = 'ammo-rifle', min = 30,  max = 90 }
                    }
                },
                {
                    label = 'Take monitor',
                    progress = 'Taking monitor...',
                    icon = 'desktop',
                    removeProp = `prop_monitor_w_large`,
                    coords = vector3(372.393158, 431.954437, 138.396866),
                    items = {
                        { name = 'monitor', count = 1 }
                    }
                },
                {
                    label = 'Take monitor',
                    progress = 'Taking monitor...',
                    icon = 'desktop',
                    removeProp = `prop_monitor_w_large`,
                    coords = vector3(372.625641, 432.754425, 138.405563),
                    items = {
                        { name = 'monitor', count = 1 }
                    }
                },
                {
                    label = 'Take keyboard',
                    progress = 'Taking keyboard...',
                    icon = 'keyboard',
                    removeProp = `prop_keyboard_01b`,
                    coords = vector3(372.725891, 432.045227, 138.052994),
                    items = {
                        { name = 'keyboard', count = 1 }
                    }
                },
                {
                    label = 'Take laptop',
                    progress = 'Taking laptop...',
                    icon = 'laptop',
                    removeProp = `prop_laptop_01a`,
                    coords = vector3(374.228882, 434.386383, 138.096634),
                    items = {
                        { name = 'laptop', count = 1 }
                    }
                },
                {
                    label = 'Take bong',
                    progress = 'Taking bong...',
                    icon = 'bong',
                    removeProp = `prop_bong_01`,
                    coords = vector3(372.977325, 406.170105, 145.117035),
                    items = {
                        { name = 'bong', count = 1 }
                    }
                },
                {
                    label = 'Take microwave',
                    progress = 'Taking microwave...',
                    icon = 'box',
                    removeProp = `prop_micro_02`,
                    coords = vector3(379.806091, 416.490723, 146.057800),
                    items = {
                        { name = 'microwave', count = 1 }
                    }
                },
                {
                    label = 'Take television',
                    progress = 'Taking television...',
                    icon = 'tv',
                    createProp = `prop_tv_flat_01`,
                    coords = vector4(377.155304, 404.784973, 146.032471, 256.0),
                    items = {
                        { name = 'flat_tv', count = 1 }
                    }
                }
            },
            lasers = {
                {
                    origins = {
                        vector3(374.7541, 422.0512, 147.5784),
                        vector3(374.7495, 422.0528, 145.0255),
                    },
                    targets = {
                        vector3(375.2559, 423.7827, 147.4686),
                        vector3(375.2678, 423.7797, 145.0399),
                    }
                },
                {
                    origins = {
                        vector3(370.3435, 416.0412, 147.7935),
                        vector3(370.3602, 416.1111, 144.8503),
                    },
                    targets = {
                        vector3(379.5125, 412.9946, 147.5890),
                        vector3(379.5072, 412.9734, 144.8053),
                    }
                },
                {
                    origins = {
                        vector3(375.1480, 421.9530, 144.1958),
                        vector3(375.1567, 421.9508, 141.1934),
                    },
                    targets = {
                        vector3(376.1571, 425.9343, 144.2037),
                        vector3(376.0667, 425.9568, 141.1586),
                    }
                },
                {
                    origin = vector3(376.0179, 424.7889, 140.5000),
                    targets = {
                        vector3(375.1987, 427.9164, 137.3001),
                        vector3(373.3112, 428.5041, 137.3001),
                        vector3(375.3313, 422.0892, 137.3001),
                        vector3(376.3993, 426.0699, 137.3000),
                    }
                }
            },
            removeProps = {
                { coords = vector3(377.161346, 404.809204, 146.010681), model = `apa_mp_h_str_avunits_01` },
            }
        },
        ['mafia'] = {
            interiorId = 207105,
            coords = vector4(-174.2918, 497.6930, 137.6526, 191.6170),
            exit = vector3(-174.3980, 498.1899, 137.7588), --Target coords
            alarm = {
                coords = vector3(-168.4519, 487.3255, 140.1918),
                duration = 60,
            },
            guards = {
                model = `s_m_m_highsec_01`,
                ignorePolice = true,
                accuracy = 60, -- from 0 - 100
                combatAbility = 100, -- from 0 - 100, peds can start to run away if less than 50
                looting = {
                    enabled = true, -- Players can loot the guards
                    progressDuration = 5000
                },
                ---@type GuardWeapon[]
                weapons = {
                    { name = 'weapon_assaultrifle', ammo = { name = 'ammo-rifle2', min = 60, max = 180 } },
                    { name = 'weapon_gusenberg', ammo = { name = 'ammo-45', min = 60, max = 180 } },
                },
                locations = {
                    vector4(-167.1931, 495.4595, 137.6535, 103.6151),
                    vector4(-167.4547, 484.9008, 137.2444, 23.0632),
                    vector4(-165.4130, 486.9224, 133.8436, 190.8889),
                    vector4(-172.8867, 492.7326, 130.0434, 358.3112)
                },
            },
            paintings = {
                item = 'painting',
                locations = {
                    vector4(-173.0121, 490.0906, 138.0760, 101.1),
                    vector4(-173.9500, 491.7317, 138.3057, 191.1),
                    vector4(-177.5165, 491.0394, 138.2962, 191.1),

                    vector4(-171.1089, 480.3046, 137.9232, 101.1),
                    vector4(-170.8334, 478.8858, 137.9232, 101.1),

                    vector4(-174.5470, 500.3233, 135.3333, 296.0),
                    vector4(-178.6873, 492.6098, 134.4759, 100.0),
                    vector4(-174.5982, 500.9967, 130.7408, 11.0),

                }
            },
            props = {
                { coords = vector4(-171.8507, 489.8307, 129.0434, 10.0), model = `h4_prop_h4_table_isl_01a` },
                { coords = vector4(-169.9462, 498.9676, 129.0437, 100.5), model = `h4_prop_h4_table_isl_01a` },
                { coords = vector4(-164.0369, 488.8457, 136.4435, 100.0), model = `h4_prop_h4_table_isl_01a` },

                { coords = vector4(-175.8524, 491.7968, 136.6537, 100.5), model = `gr_prop_gr_crates_pistols_01a` },
                { coords = vector4(-175.8524, 491.7968, 132.8537, 100.5), model = `gr_prop_gr_crates_pistols_01a` },

                { coords = vector4(-162.9125, 487.0703, 136.7437, 100.0), model = `prop_fncsec_03d` },
                { coords = vector4(-164.2118, 496.9904, 137.7288, 11.0), model = `prop_shuttering02` },

                { coords = vector4(-164.3918, 479.7406, 136.2653, 191.8432), model = `prop_boxpile_07d` },
                { coords = vector4(-167.9112, 479.0135, 136.2655, 191.8432), model = `prop_boxpile_07d` },
            },
            removeProps = {
                { coords = vector3(-170.857758, 479.299225, 137.777542), model = `apa_p_h_acc_artwalll_03` },
                { coords = vector3(-170.857758, 479.299225, 137.777542), model = `apa_p_h_acc_artwalll_03` },
                { coords = vector3(-170.312241, 497.943420, 129.611267), model = `apa_mp_h_stn_sofa_daybed_02`},
                { coords = vector3(-169.625732, 499.059204, 130.017349), model = `apa_mp_h_acc_bowl_ceramic_01`},
                { coords = vector3(-169.625732, 499.059204, 130.017349), model = `apa_mp_h_acc_dec_sculpt_02`},
                { coords = vector3(-169.625732, 499.059204, 130.017349), model = `apa_mp_h_acc_dec_head_01`},
                { coords = vector3(-169.625732, 499.059204, 130.017349), model = `apa_mp_h_str_sideboards_02`},
                { coords = vector3(-175.634872, 491.458862, 138.076752), model = `apa_p_h_acc_artwalll_01` },
                { coords = vector3(-176.229401, 491.424347, 134.452637), model = `apa_p_h_acc_artwalll_04` },
                { coords = vector3(-168.964127, 492.427368, 137.734222), model = `v_res_m_woodbowl` },
                { coords = vector3(-165.626282, 494.122131, 137.671051), model = `v_res_mchopboard` },
                { coords = vector3(-166.707245, 488.741455, 137.243011), model = `apa_mp_h_din_table_01` },
                { coords = vector3(-166.346619, 489.020966, 137.350708), model = `apa_mp_h_acc_fruitbowl_01` },
                { coords = vector3(-165.3380, 489.2718, 137.4433), model = `apa_mp_h_acc_fruitbowl_01` },
                { coords = vector3(-166.7450, 488.8698, 137.4434), model = `apa_mp_h_din_chair_12` },
                { coords = vector3(-162.425705, 479.781403, 137.528656), model = `prop_t_telescope_01b` },
                { coords = vector3(-163.932709, 484.469330, 136.848984), model = `apa_mp_h_stn_chairstrip_01` },
                { coords = vector3(-167.467316, 481.457123, 136.722519), model = `apa_mp_h_stn_sofacorn_01` },
                { coords = vector3(-167.116287, 481.536835, 138.401199), model = `apa_mp_h_lit_floorlampnight_05` },
            },

            ---@type LootData
            loot = {
                rewards = {
                    ['weed'] = { item = 'weed_brick', count = { pile = 20, trolley = 45 } },
                    ['coke'] = { item = 'coke_brick', count = { pile = 20, trolley = 45 } },
                },
                goldChance = 0,
                locations = {
                    {
                        coords = vector4(-166.5115, 493.6414, 137.6038, 207.0),
                        type = 'pile',
                        forceLootType = 'weed'
                    },
                    {
                        coords = vector4(-171.3968, 490.0337, 129.9885, 189.0),
                        type = 'pile',
                        forceLootType = 'coke'
                    },
                    {
                        coords = vector4(-172.4141, 489.8975, 129.9885, 189.0),
                        type = 'pile',
                        forceLootType = 'coke'
                    },
                    {
                        coords = vector4(-170.2113, 499.4101, 129.9888, 279.0),
                        type = 'pile',
                        forceLootType = 'weed'
                    },
                    {
                        coords = vector4(-170.0277, 498.3962, 129.9888, 279.0),
                        type = 'pile',
                        forceLootType = 'coke'
                    },

                    {
                        coords = vector4(-164.3222, 489.3016, 137.3886, 285.0),
                        type = 'pile',
                        forceLootType = 'coke'
                    },
                    {
                        coords = vector4(-164.1223, 488.2578, 137.3886, 285.0),
                        type = 'pile',
                        forceLootType = 'weed'
                    }
                }
            },
            takeLoot = {
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-172.1232, 486.6920, 136.9652),
                    items = {
                        { name = 'weapon_snspistol', count = 1, chance = 5 },
                        { name = 'money',            min = 500, max = 1000 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-171.1154, 482.4599, 136.8367),
                    items = {
                        { name = 'weapon_pistol', count = 1, chance = 2 },
                        { name = 'money',         min = 500, max = 1000 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-170.846878, 481.954803, 133.422211),
                    items = {
                        { name = 'weapon_knife', count = 1, chance = 25 },
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-175.4622, 489.6720, 129.3880),
                    items = {
                        { name = 'weapon_combatpistol', count = 1,  chance = 1 },
                        { name = 'money',               min = 1500, max = 3500 }
                    }
                },
                {
                    label = 'Search closet',
                    progress = 'Searching closet...',
                    icon = 'magnifying-glass',
                    coords = vector3(-167.6694, 488.6797, 133.9791),
                    items = {
                        { name = 'money',   min = 500, max = 2000 },
                        { name = 'bandage', min = 1,   max = 2,  chance = 15 }
                    }
                },
                {
                    label = 'Search fridge',
                    progress = 'Searching fridge...',
                    icon = 'magnifying-glass',
                    coords = vector3(-170.3485, 496.3442, 137.8943),
                    items = {
                        { name = 'burger',  min = 1, max = 3 },
                        { name = 'water',   min = 1, max = 4 },
                        { name = 'cola',    min = 1, max = 3 },
                        { name = 'mustard', min = 1, max = 2, chance = 25 }
                    }
                },
                {
                    label = 'Take ammo',
                    progress = 'Taking ammo...',
                    icon = 'magnifying-glass',
                    coords = vector3(-176.672348, 491.897461, 130.194458),
                    items = {
                        { name = 'ammo-9',     min = 30, max = 90 },
                        { name = 'ammo-45',    min = 30, max = 90 },
                        { name = 'ammo-rifle', min = 30,  max = 90 }
                    }
                },
                {
                    label = 'Take monitor',
                    progress = 'Taking monitor...',
                    icon = 'desktop',
                    removeProp = `prop_monitor_w_large`,
                    coords = vector3(-169.107544, 493.102234, 130.157806),
                    items = {
                        { name = 'monitor', count = 1 }
                    }
                },
                {
                    label = 'Take monitor',
                    progress = 'Taking monitor...',
                    icon = 'desktop',
                    removeProp = `prop_monitor_w_large`,
                    coords = vector3(-168.975555, 492.264038, 130.151062),
                    items = {
                        { name = 'monitor', count = 1 }
                    }
                },
                {
                    label = 'Take keyboard',
                    progress = 'Taking keyboard...',
                    icon = 'keyboard',
                    removeProp = `prop_keyboard_01b`,
                    coords = vector3(-169.336121, 492.851044, 129.796936),
                    items = {
                        { name = 'keyboard', count = 1 }
                    }
                },
                {
                    label = 'Take laptop',
                    progress = 'Taking laptop...',
                    icon = 'laptop',
                    removeProp = `prop_laptop_01a`,
                    coords = vector3(-169.751175, 490.136475, 129.788208),
                    items = {
                        { name = 'laptop', count = 1 }
                    }
                },
                {
                    label = 'Take bong',
                    progress = 'Taking bong...',
                    icon = 'bong',
                    removeProp = `prop_bong_01`,
                    coords = vector3(-166.398056, 482.312927, 136.862656),
                    items = {
                        { name = 'bong', count = 1 }
                    }
                },
                {
                    label = 'Take microwave',
                    progress = 'Taking microwave...',
                    icon = 'box',
                    removeProp = `prop_micro_02`,
                    coords = vector3(-164.572800, 494.546204, 137.774277),
                    items = {
                        { name = 'microwave', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-169.5098, 493.6773, 137.5938, 237.43),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-169.1820, 492.9107, 137.5938, 156.89),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-164.5588, 495.5916, 137.5956, 42.17),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-167.0414, 497.3900, 137.5913, 312.76),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-163.1410, 480.1087, 133.3068, 89.23),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-164.5299, 483.9842, 133.5040, 178.91),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-162.9866, 482.9831, 133.5037, 267.54),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-163.2402, 484.3167, 133.5053, 123.67),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                },
                {
                    label = 'Take meth',
                    progress = 'Taking meth...',
                    icon = 'box',
                    createProp = `tr_prop_meth_smallbag_01a`,
                    coords = vector4(-165.386734, 482.724365, 136.716629, 210.67),
                    items = {
                        { name = 'meth_bag', count = 1 }
                    }
                }
            }
        },
        ['celebrity'] = {
            interiorId = 207105,
            coords = vector4(-174.2918, 497.6930, 137.6526, 191.6170),
            exit = vector3(-174.3980, 498.1899, 137.7588), --Target coords
            alarm = {
                coords = vector3(-168.4519, 487.3255, 140.1918),
                duration = 60,
            },
            guards = {
                model = `s_m_y_doorman_01`,
                ignorePolice = true,
                accuracy = 30,       -- from 0 - 100
                combatAbility = 100, -- from 0 - 100, peds can start to run away if less than 50
                looting = {
                    enabled = true,  -- Players can loot the guards
                    progressDuration = 5000
                },
                ---@type GuardWeapon[]
                weapons = {
                    { name = 'weapon_combatpistol', ammo = { name = 'ammo-9', min = 60, max = 180 } },
                },
                locations = {
                    vector4(-167.1931, 495.4595, 137.6535, 103.6151),
                    vector4(-167.4547, 484.9008, 137.2444, 23.0632),
                    vector4(-167.0659, 487.7725, 133.8439, 177.2864),
                    vector4(-173.9585, 493.1310, 130.0434, 276.6230)
                },
            },
            paintings = {
                item = 'painting',
                locations = {
                    vector4(-173.0121, 490.0906, 138.0760, 101.1),
                    vector4(-173.9500, 491.7317, 138.3057, 191.1),
                    vector4(-177.5165, 491.0394, 138.2962, 191.1),

                    vector4(-171.1089, 480.3046, 137.9232, 101.1),
                    vector4(-170.8334, 478.8858, 137.9232, 101.1),

                    vector4(-174.5470, 500.3233, 135.3333, 296.0),
                    vector4(-178.6873, 492.6098, 134.4759, 100.0),
                    vector4(-174.5982, 500.9967, 130.7408, 11.0),

                }
            },
            staticPeds = {
                {
                    coords = vector4(-164.9770, 491.5533, 137.4437, 285.8609),
                    model = `a_f_y_bevhills_01`,
                    anim = {
                        dict = 'random@homelandsecurity',
                        clip = 'knees_loop_girl',
                    }
                },
                {
                    coords = vector4(-165.5457, 485.2870, 137.2443, 199.8437),
                    model = `a_f_y_bevhills_02`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_b',
                    }
                },
                {
                    coords = vector4(-164.9034, 483.6848, 137.2653, 30.3273),
                    model = `a_f_y_bevhills_03`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_c',
                    }
                },
                {
                    coords = vector4(-162.5247, 481.2707, 137.2443, 65.0258),
                    model = `a_f_y_bevhills_04`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_d',
                    }
                },
                {
                    coords = vector4(-166.0072, 483.9989, 137.2652, 300.4417),
                    model = `a_m_m_bevhills_01`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_e',
                    }
                },
                {
                    coords = vector4(-169.0260, 482.6821, 137.2459, 169.7081),
                    model = `s_f_y_hooker_01`,
                    anim = {
                        dict = 'random@homelandsecurity',
                        clip = 'knees_loop_girl',
                    }
                },
                {
                    coords = vector4(-169.2137, 481.1138, 137.2443, 287.6278),
                    model = `s_f_y_hooker_02`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_b',
                    }
                },
                {
                    coords = vector4(-163.9679, 490.7779, 137.4435, 20.5081),
                    model = `s_f_y_hooker_02`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_c',
                    }
                },
                {
                    coords = vector4(-164.1333, 485.0398, 133.8695, 291.1113),
                    model = `a_f_y_bevhills_01`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_d',
                    }
                },
                {
                    coords = vector4(-163.1792, 481.8740, 133.8695, 301.9537),
                    model = `s_f_y_hooker_03`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_e',
                    }
                },
                {
                    coords = vector4(-165.0648, 481.6997, 133.8695, 2.4562),
                    model = `s_f_y_hooker_01`,
                    anim = {
                        dict = 'random@homelandsecurity',
                        clip = 'knees_loop_girl',
                    }
                },
                {
                    coords = vector4(-167.7947, 487.8697, 133.8439, 358.8358),
                    model = `a_f_y_bevhills_04`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_b',
                    }
                },
                {
                    coords = vector4(-167.0636, 490.1199, 133.8723, 272.5469),
                    model = `s_f_y_stripper_01`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_c',
                    }
                },
                {
                    coords = vector4(-168.6145, 489.7987, 133.8723, 104.0624),
                    model = `cs_lazlow_2`,
                    anim = {
                        dict = 'anim@heists@ornate_bank@hostages@hit',
                        clip = 'hit_loop_ped_d',
                    }
                },
            },
            props = {
                { coords = vector4(-171.8507, 489.8307, 129.0434, 10.0),  model = `h4_prop_h4_table_isl_01a` },
                { coords = vector4(-166.6504, 488.7827, 137.2436, 0.0),   model = `bkr_prop_coke_painkiller_01a` },
                { coords = vector4(-166.6436, 493.6156, 137.6038, 71.0),  model = `bkr_prop_coke_painkiller_01a` },
                { coords = vector4(-164.6331, 495.4404, 137.6056, 123.0), model = `bkr_prop_coke_painkiller_01a` },
                { coords = vector4(-165.2186, 482.6441, 136.7166, 51.0),  model = `bkr_prop_coke_painkiller_01a` },
                { coords = vector4(-165.2186, 482.6441, 136.7166, 51.0),  model = `bkr_prop_coke_painkiller_01a` },
            },
            removeProps = {
                { coords = vector3(-170.857758, 479.299225, 137.777542), model = `apa_p_h_acc_artwalll_03` },
                { coords = vector3(-170.857758, 479.299225, 137.777542), model = `apa_p_h_acc_artwalll_03` },

            },
            ---@type LootData
            loot = {
                rewards = {
                    ['cash'] = { account = 'money', count = { pile = 1000, trolley = 1500 } },
                },
                goldChance = 0,
                locations = {
                    {
                        coords = vector4(-171.3968, 490.0337, 129.9885, 189.0),
                        type = 'pile',
                    },
                    {
                        coords = vector4(-172.4141, 489.8975, 129.9885, 189.0),
                        type = 'pile',
                    }
                }
            },
            takeLoot = {
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-172.1232, 486.6920, 136.9652),
                    items = {
                        { name = 'weapon_snspistol', count = 1, chance = 5 },
                        { name = 'money',            min = 2000, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-171.1154, 482.4599, 136.8367),
                    items = {
                        { name = 'weapon_pistol', count = 1, chance = 2 },
                        { name = 'money',         min = 2000, max = 3500 }
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-170.846878, 481.954803, 133.422211),
                    items = {
                        { name = 'weapon_knife', count = 1, chance = 25 },
                    }
                },
                {
                    label = 'Search wardrobe',
                    progress = 'Searching wardrobe...',
                    icon = 'magnifying-glass',
                    coords = vector3(-175.4622, 489.6720, 129.3880),
                    items = {
                        { name = 'weapon_combatpistol', count = 1,  chance = 1 },
                        { name = 'money',               min = 1000, max = 3500 }
                    }
                },
                {
                    label = 'Search closet',
                    progress = 'Searching closet...',
                    icon = 'magnifying-glass',
                    coords = vector3(-167.6694, 488.6797, 133.9791),
                    items = {
                        { name = 'money',   min = 1000, max = 2000 },
                        { name = 'bandage', min = 1,   max = 2,  chance = 15 }
                    }
                },
                {
                    label = 'Search fridge',
                    progress = 'Searching fridge...',
                    icon = 'magnifying-glass',
                    coords = vector3(-170.3485, 496.3442, 137.8943),
                    items = {
                        { name = 'burger',  min = 1, max = 3 },
                        { name = 'water',   min = 1, max = 4 },
                        { name = 'cola',    min = 1, max = 3 },
                        { name = 'mustard', min = 1, max = 2, chance = 25 }
                    }
                },
                {
                    label = 'Take ammo',
                    progress = 'Taking ammo...',
                    icon = 'magnifying-glass',
                    coords = vector3(-176.672348, 491.897461, 130.194458),
                    items = {
                        { name = 'ammo-9',     min = 30, max = 90 },
                        { name = 'ammo-45',    min = 30, max = 90 },
                        { name = 'ammo-rifle', min = 30,  max = 90 }
                    }
                },
                {
                    label = 'Take monitor',
                    progress = 'Taking monitor...',
                    icon = 'desktop',
                    removeProp = `prop_monitor_w_large`,
                    coords = vector3(-169.107544, 493.102234, 130.157806),
                    items = {
                        { name = 'monitor', count = 1 }
                    }
                },
                {
                    label = 'Take monitor',
                    progress = 'Taking monitor...',
                    icon = 'desktop',
                    removeProp = `prop_monitor_w_large`,
                    coords = vector3(-168.975555, 492.264038, 130.151062),
                    items = {
                        { name = 'monitor', count = 1 }
                    }
                },
                {
                    label = 'Take keyboard',
                    progress = 'Taking keyboard...',
                    icon = 'keyboard',
                    removeProp = `prop_keyboard_01b`,
                    coords = vector3(-169.336121, 492.851044, 129.796936),
                    items = {
                        { name = 'keyboard', count = 1 }
                    }
                },
                {
                    label = 'Take laptop',
                    progress = 'Taking laptop...',
                    icon = 'laptop',
                    removeProp = `prop_laptop_01a`,
                    coords = vector3(-169.751175, 490.136475, 129.788208),
                    items = {
                        { name = 'laptop', count = 1 }
                    }
                },
                {
                    label = 'Take bong',
                    progress = 'Taking bong...',
                    icon = 'bong',
                    removeProp = `prop_bong_01`,
                    coords = vector3(-166.398056, 482.312927, 136.862656),
                    items = {
                        { name = 'bong', count = 1 }
                    }
                },
                {
                    label = 'Take microwave',
                    progress = 'Taking microwave...',
                    icon = 'box',
                    removeProp = `prop_micro_02`,
                    coords = vector3(-164.572800, 494.546204, 137.774277),
                    items = {
                        { name = 'microwave', count = 1 }
                    }
                },
                {
                    label = 'Take cocaine',
                    progress = 'Taking cocaine...',
                    icon = 'pills',
                    createProp = `prop_coke_block_01`,
                    coords = vector3(-164.8814, 488.9337, 137.2836),
                    items = {
                        { name = 'coke_brick', count = 1 }
                    }
                },
                {
                    label = 'Take cocaine',
                    progress = 'Taking cocaine...',
                    icon = 'pills',
                    createProp = `prop_coke_block_01`,
                    coords = vector3(-169.4533, 493.5934, 137.6438),
                    items = {
                        { name = 'coke_brick', count = 1 }
                    }
                }
            },
            displayCase = {
                model = `h4_prop_h4_glass_disp_01a`,
                coords = vector4(-165.9561, 479.1432, 133.8438, 11.4732),
                target = vector3(-166.0232, 479.4805, 134.1851),
                requiredItem = 'plasma_cutter',
                removeAfterUse = false,
                items = {
                    -- { name = 'pink_diamond', count = 1, model = `h4_prop_h4_diamond_01a` },
                    { name = 'rare_tequila', count = 1, model = `h4_prop_h4_t_bottle_02a` },
                }
            }
        },
    },

    locations = {
        {
        	coords = vector4(232.0902, 672.3226, 189.9459, 41.2593),
        	entrance = vector3(232.5494, 671.8068, 190.0474), --Target coords
        	tier = 'high'
        },
        {
        	coords = vector4(-109.9302, 501.8582, 143.4787, 348.4616),
        	entrance = vector3(-110.1454, 501.3711, 143.6460), --Target coords
        	tier = 'high'
        },
        {
        	coords = vector4(-765.6135, 650.5557, 145.7005, 298.9246),
        	entrance = vector3(-766.4174, 650.1849, 145.6399), --Target coords
        	tier = 'high'
        },
        {
        	coords = vector4(184.7489, 571.6385, 183.3370, 275.9282),
        	entrance = vector3(183.8154, 571.4595, 183.4322), --Target coords
        	tier = 'high2'
        },
        {
        	coords = vector4(150.9166, 556.0003, 183.7374, 110.3141),
        	entrance = vector3(151.4152, 556.2258, 184.0848), --Target coords
        	tier = 'high'
        },
        {
        	coords = vector4(85.1549, 561.9982, 182.7730, 5.4640),
        	entrance = vector3(84.9244, 561.4628, 182.8835), --Target coords
        	tier = 'high2'
        },
        {
        	coords = vector4(45.7632, 556.2398, 180.0819, 25.5341),
        	entrance = vector3(46.0295, 555.5358, 180.5153), --Target coords
        	tier = 'high'
        },
        {
        	coords = vector4(-66.6436, 490.4130, 144.6901, 342.8430),
        	entrance = vector3(-66.9370, 489.6305, 145.0291), --Target coords
        	tier = 'high2'
        },
        {
        	coords = vector4(-7.7136, 468.1860, 145.8641, 338.3519),
        	entrance = vector3(-7.9775, 467.3904, 146.0), --Target coords
        	tier = 'high'
        },
        {
        	coords = vector4(57.6580, 449.8446, 147.0314, 334.8503),
        	entrance = vector3(57.3906, 449.3995, 147.0873), --Target coords
        	tier = 'high2'
        },
        {
        	coords = vector4(107.1179, 466.9041, 147.5620, 358.8527),
        	entrance = vector3(107.1457, 465.9587, 147.7610), --Target coords
        	tier = 'high'
        },
        {
        	coords = vector4(223.6553, 514.2558, 140.7667, 39.5667),
        	entrance = vector3(224.4888, 513.0812, 141.3103), --Target coords
        	tier = 'high2'
        },
        {
        	coords = vector4(318.6596, 552.0211, 156.0236, 294.8277),
        	entrance = vector3(318.0776, 551.7898, 156.2066), --Target coords
        	tier = 'high2'
        },
        {
        	coords = vector4(315.8630, 501.6306, 153.1797, 193.3321),
        	entrance = vector3(315.6570, 502.4647, 153.2378), --Target coords
        	tier = 'high2'
        },
        {
        	coords = vector4(443.4287, -1707.3804, 29.7093, 52.7309),
        	entrance = vector3(444.2701, -1708.0155, 29.5024), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(418.1618, -1735.4202, 29.6077, 108.0985),
        	entrance = vector3(419.3265, -1735.2269, 29.7136), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(405.0500, -1750.9716, 29.7103, 104.2722),
        	entrance = vector3(406.0407, -1750.9625, 29.9271), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(474.6319, -1757.7533, 29.0926, 249.7372),
        	entrance = vector3(474.2507, -1757.6239, 29.3990), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(479.6931, -1735.7250, 29.1510, 162.4400),
        	entrance = vector3(479.8342, -1735.1790, 29.4401), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(467.0052, -1590.3820, 32.8197, 321.2889),
        	entrance = vector3(466.6859, -1590.7395, 33.1355), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(455.0341, -1580.1456, 32.7922, 320.3029),
        	entrance = vector3(454.6276, -1580.5618, 33.1601), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(430.4027, -1559.0891, 32.7923, 317.5270),
        	entrance = vector3(429.8979, -1559.7108, 33.2218), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(440.4092, -1829.9286, 28.3618, 134.3691),
        	entrance = vector3(440.6810, -1829.5179, 28.5025), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(427.7570, -1842.5536, 28.4634, 262.4662),
        	entrance = vector3(426.9583, -1842.4362, 28.6839), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(412.8769, -1856.5437, 27.3231, 276.7806),
        	entrance = vector3(412.1848, -1856.5406, 27.5865), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(384.9147, -1881.6218, 26.0315, 226.4330),
        	entrance = vector3(384.5706, -1881.1110, 26.2204), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(368.5925, -1895.7748, 25.1785, 131.2234),
        	entrance = vector3(369.0513, -1895.3396, 25.4698), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(320.3097, -1854.1477, 27.5110, 49.0517),
        	entrance = vector3(320.4937, -1854.2759, 27.7519), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(329.4351, -1845.9194, 27.7480, 48.9389),
        	entrance = vector3(329.6340, -1846.1260, 28.0319), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(338.6768, -1829.5769, 28.3375, 316.0137),
        	entrance = vector3(338.4554, -1829.8381, 28.5685), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(348.8536, -1820.8110, 28.8941, 320.7766),
        	entrance = vector3(348.5065, -1821.2444, 29.2102), --Target coords
        	tier = 'low'
        },
        {
        	coords = vector4(1204.8903, -557.7361, 69.6152, 85.0229),
        	entrance = vector3(1205.3192, -557.7150, 69.6866), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1200.7917, -575.7746, 69.1390, 131.3147),
        	entrance = vector3(1201.2532, -575.3593, 69.3360), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1203.6316, -598.3725, 68.0635, 182.2578),
        	entrance = vector3(1203.5875, -597.9981, 68.3348), --Target coords
            swapCamera = true,
        	tier = 'medium'
        },
        {
        	coords = vector4(1207.4750, -620.2925, 66.4386, 89.4940),
        	entrance = vector3(1207.8036, -620.2659, 66.5538), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1221.5177, -669.2910, 63.6834, 12.3165),
        	entrance = vector3(1221.6337, -669.7002, 63.6548), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1220.7770, -689.3993, 61.1032, 14.0685),
        	entrance = vector3(1220.9127, -689.9562, 61.3341), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1229.3468, -725.4595, 60.8040, 98.1960),
        	entrance = vector3(1230.2096, -725.3056, 61.3908), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1265.3246, -703.0864, 64.5708, 246.2210),
        	entrance = vector3(1264.2262, -702.4939, 65.0944), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1271.0048, -683.6313, 66.0316, 9.0238),
        	entrance = vector3(1270.9862, -683.8866, 66.3227), --Target coords
            swapCamera = true,
        	tier = 'medium'
        },
        {
        	coords = vector4(1265.6407, -648.4827, 67.9216, 34.8379),
        	entrance = vector3(1265.7793, -648.9035, 68.2562), --Target coords
            swapCamera = true,
        	tier = 'medium'
        },
        {
        	coords = vector4(1251.0896, -621.1227, 69.4132, 209.6829),
        	entrance = vector3(1250.6821, -620.4426, 69.9448), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1240.5764, -601.5881, 69.7828, 273.9178),
        	entrance = vector3(1239.8430, -601.6784, 69.9873), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1241.8040, -566.2859, 69.6574, 312.8280),
        	entrance = vector3(1240.9958, -566.7728, 69.8539), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1250.8070, -515.4427, 69.3490, 253.3367),
        	entrance = vector3(1250.6351, -515.4131, 69.5158), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1251.4250, -494.1296, 69.9069, 260.3994),
        	entrance = vector3(1251.2620, -494.0825, 70.2046), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1259.8306, -480.1555, 70.1887, 301.5445),
        	entrance = vector3(1259.2664, -480.3734, 70.4060), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1265.6450, -458.2702, 70.5169, 274.5439),
        	entrance = vector3(1265.4294, -458.0231, 70.8020), --Target coords
        	tier = 'medium'
        },
        {
        	coords = vector4(1262.3566, -429.8834, 70.0147, 299.3845),
        	entrance = vector3(1261.8950, -430.0649, 70.1359), --Target coords
        	tier = 'medium'
        },
        {
            coords = vector4(-658.4984, 886.3019, 229.3044, 8.3274),
            entrance =vector3(-658.4453, 885.8958, 229.6423),
            tier = 'celebrity',
            outsideGuards = {
                vector4(-665.1878, 879.9319, 229.3438, 122.3086),
                vector4(-650.1417, 889.3726, 229.2438, 288.1743)
            }
        },
        {
            coords = vector4(-151.7160, 910.5463, 235.6558, 42.8493),
            entrance = vector3(-151.3939, 910.1906, 235.9686),
            tier = 'mafia',
            outsideGuards = {
                vector4(-140.5679, 902.2838, 235.6570, 316.8142),
                vector4(-165.7404, 918.0840, 235.6558, 48.5314)
            }
        },
        {
            coords = vector4(-1032.6697, 686.0723, 161.3026, 91.7440),
            entrance = vector3(-1032.5269, 686.0751, 161.6481),
            tier = 'celebrity',
            keypad = vector4(-1032.5542, 684.8942, 161.7623, 270.0),
            outsideGuards = {
                vector4(-1033.1953, 680.7062, 161.3030, 92.3047),
                vector4(-1016.2214, 688.6224, 161.2936, 4.5286)
            }
        },
        {
            coords = vector4(167.2857, 473.8250, 142.5133, 81.4402),
            entrance = vector3(167.8103, 473.7300, 142.8196),
            tier = 'celebrity',
            keypad = vector4(167.7574, 474.8393, 142.9631, 262.0),
            outsideGuards = {
                vector4(161.6328, 470.1932, 142.5123, 350.3965),
                vector4(147.9268, 479.9350, 142.5154, 278.0151)
            }
        },
        {
            coords = vector4(-700.7928, 647.3249, 155.1758, 353.6137),
            entrance = vector3(-700.9564, 646.6873, 155.5869),
            tier = 'mafia',
            keypad = vector4(-701.9573, 647.2248, 155.6172, 168.0),
            outsideGuards = {
                vector4(-705.9946, 648.1466, 155.1752, 77.3384),
                vector4(-694.5791, 644.8394, 155.1752, 350.2597)
            }
        },
        {
            coords = vector4(-1673.0258, 386.2834, 89.3482, 349.5300),
            entrance = vector3(-1673.2346, 385.2595, 89.7834),
            tier = 'mafia',
            keypad = vector4(-1671.3591, 385.7105, 89.9040, 260.0),
            outsideGuards = {
                vector4(-1663.5719, 384.9615, 89.4914, 356.2914),
                vector4(-1683.2242, 389.0372, 88.3468, 353.9264)
            }
        },
        {
            coords = vector4(-867.3915, 785.3200, 191.9342, 6.3637),
            entrance = vector3(-867.3052, 784.3973, 192.1816),
            tier = 'celebrity',
            keypad = vector4(-866.2087, 785.5786, 192.3916, 277.0),
            outsideGuards = {
                vector4(-874.6691, 784.3055, 191.7255, 58.7967),
                vector4(-851.2723, 787.7878, 191.7258, 7.5673)
            },
        },
        {
            coords = vector4(-340.4073, 626.0634, 171.3567, 55.4834),
            entrance = vector3(-339.3202, 625.3637, 171.7475),
            tier = 'mafia',
            keypad = vector4(-339.1247, 626.5352, 171.8344, 327.0),
            outsideGuards = {
                vector4(-338.2099, 629.9899, 172.3535, 62.8044),
                vector4(-349.0771, 612.2755, 171.3578, 112.3072)
            },
        }
    }
}
