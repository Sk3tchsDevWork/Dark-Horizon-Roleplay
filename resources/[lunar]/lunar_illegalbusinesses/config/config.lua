Config = {}

Config.overlayPosition = 'bottom: 2.5rem; right: 2.5rem;' -- CSS properties
Config.maxBusinessesPerPlayer = -1 -- Set to a number to limit it
Config.currency = { symbol = '$', icon = 'dollar-sign' } -- Fontawesome icon

-- The ped that sells the businesses
Config.ped = {
    model = `g_m_m_armboss_01`,
    -- The label should be in locales
    accounts = { 
        { name = 'money', icon = 'sack-dollar' },
        { name = 'bank', icon = 'building-columns' }
    },
    sell = {
        divisor = 2, -- You'll sell the business only for 50% of the original price
        account = 'money'
    },
    locations = {
        vector4(2639.5864, 4246.0562, 44.7450, 45.7937)
    },
    prohibitedJobs = {
        ['police'] = true,
        ['sheriff'] = true,
        ['ambulance'] = true
    }
}

---@class BlipData
---@field name string
---@field sprite integer
---@field size number
---@field color integer

---@class LocationData
---@field price integer
---@field type string
---@field image string?
---@field coords vector4
---@field target vector3
---@field vehicleSpawn vector4 Vehicles for mission will be spawned here
---@field camera vector4
---@field spawnCamera boolean?

-- The businesses
-- Images can be found in web/build/images
-- The prices are based on the distance to the sandy and grapeseed airports because all sell missions require you to go there
-- =============================================================
-- sandy/grapeseed = most expensive
-- paleto = less expensive but still not cheap
-- los santos = the cheapest option but far from the airports mentioned above
-- =============================================================
---@type table<string, LocationData>
Config.locations = {
    ['sandy1'] = {
        price = 375000,
        type = 'meth',
        image = './images/businesses/1.png',
        coords = vector4(1406.7788, 3604.0256, 35.0098, 197.5982),
        target = vector3(1406.5887, 3604.3064, 35.2928),
        vehicleSpawn = vector4(1405.5842, 3598.4509, 34.8736, 289.2202),
        camera = vector4(1405.5699, 3603.7927, 36.8842, 197.5982),
        spawnCamera = true
    },
    ['sandy2'] = {
        price = 375000,
        type = 'meth',
        image = './images/businesses/2.png',
        coords = vector4(2566.6580, 4283.2500, 41.9737, 325.0891),
        target = vector3(2566.4688, 4282.9121, 42.1892),
        vehicleSpawn = vector4(2580.5234, 4277.6450, 42.0310, 236.8790),
        camera = vector4(2570.08, 4280.5508, 43.0436, 325.0891),
        spawnCamera = true
    },
    ['sandy3'] = {
        price = 375000,
        type = 'meth',
        image = './images/businesses/3.png',
        coords = vector4(2440.4216, 4068.1387, 38.0646, 67.7840),
        target = vector3(2441.0078, 4067.8789, 38.0909),
        vehicleSpawn = vector4(2436.4829, 4068.5938, 38.1832, 158.5744),
        camera = vector4(2441.6412, 4070.0374, 40.0015, 67.1323),
        spawnCamera = true
    },
    ['sandy4'] = {
        price = 450000,
        type = 'coke',
        image = './images/businesses/4.png',
        coords = vector4(983.9380, 2719.0254, 39.5034, 180.2520),
        target = vector3(983.9777, 2719.3301, 39.6300),
        vehicleSpawn = vector4(968.1750, 2711.4932, 39.6082, 176.9819),
        camera = vector4(982.7112, 2719.3306, 40.8236, 180.2176),
        spawnCamera = true
    },
    ['sandy5'] = {
        price = 325000,
        type = 'weed',
        image = './images/businesses/5.png',
        coords = vector4(387.4630, 3584.6250, 33.2922, 352.3442),
        target = vector3(387.3968, 3584.0212, 33.4958),
        vehicleSpawn = vector4(386.5290, 3591.1851, 33.3979, 81.0021),
        camera = vector4(390.2834, 3583.7847, 35.4598, 350.2238),
        spawnCamera = true
    },
    ['grapeseed1'] = {
        price = 450000,
        type = 'coke',
        image = './images/businesses/6.png',
        coords = vector4(2910.6643, 4492.8569, 48.1109, 241.8741),
        target = vector3(2910.3154, 4493.1104, 48.1853),
        vehicleSpawn = vector4(2893.5417, 4468.1748, 48.2881, 235.2832),
        camera = vector4(2908.0513, 4489.6626, 50.1964, 237.0),
        spawnCamera = true
    },
    ['grapeseed2'] = {
        price = 325000,
        type = 'weed',
        image = './images/businesses/7.png',
        coords = vector4(1710.4806, 4728.4551, 42.1447, 107.5304),
        target = vector3(1711.1708, 4728.6846, 42.3612),
        vehicleSpawn = vector4(1699.7042, 4729.9644, 42.2457, 16.6955),
        camera = vector4(1710.1759, 4730.9531, 44.8178, 106),
        spawnCamera = true
    },
    ['grapeseed3'] = {
        price = 450000,
        type = 'coke',
        image = './images/businesses/8.png',
        coords = vector4(1929.9766, 4634.8584, 40.4712, 358.5978),
        target = vector3(1929.9728, 4634.3207, 40.8334),
        vehicleSpawn = vector4(1927.8646, 4641.2065, 40.4101, 70.7316),
        camera = vector4(1932.1797, 4634.370, 43.5587, 361.0),
        spawnCamera = true
    },
    ['paleto1'] = {
        price = 175000,
        type = 'counterfeit_factory',
        image = './images/businesses/9.png',
        coords = vector4(7.8981, 6469.3813, 31.4253, 49.2481),
        target = vector3(8.3723, 6468.9185, 31.7139),
        vehicleSpawn = vector4(-1.2903, 6475.2524, 31.4977, 135.6160),
        camera = vector4(10.7865, 6471.9536, 34.0503, 45.2),
        spawnCamera = true
    },
    ['paleto2'] = {
        price = 350000,
        type = 'coke',
        image = './images/businesses/10.png',
        coords = vector4(416.1261, 6520.8228, 27.7388, 266.7884),
        target = vector3(415.8709, 6520.8530, 28.0),
        vehicleSpawn = vector4(420.8759, 6522.1475, 27.8303, 355.1833),
        camera = vector4(415.48, 6517.4092, 30.0640, 265.0),
        spawnCamera = true
    },
    ['paleto3'] = {
        price = 175000,
        type = 'document_forgery',
        image = './images/businesses/11.png',
        coords = vector4(-167.3230, 6312.2202, 31.4844, 137.9986),
        target = vector3(-166.9001, 6312.6548, 31.8384),
        vehicleSpawn = vector4(-169.6348, 6309.4434, 31.4529, 226.7961),
        camera = vector4(-169.2092, 6314.7354, 33.6585, 133.9205),
        spawnCamera = true
    },
    ['cypress1'] = {
        price = 200000,
        type = 'weed',
        image = './images/businesses/12.png',
        coords = vector4(1019.2697, -2511.6846, 28.4827, 86.7031),
        target = vector3(1019.7964, -2511.7563, 28.6543),
        vehicleSpawn = vector4(1011.9570, -2510.8225, 28.5353, 354.3373),
        camera = vector4(1019.7789, -2509.7991, 30.2711, 86.7),
        spawnCamera = true
    },
    ['cypress2'] = {
        price = 225000,
        type = 'meth',
        image = './images/businesses/13.png',
        coords = vector4(975.5656, -2357.8062, 31.8238, 178.4920),
        target = vector3(975.60, -2357.2791, 32.1002),
        vehicleSpawn = vector4(978.6903, -2372.3845, 30.7756, 266.4625),
        camera = vector4(973.585, -2361.6860, 33.9175, 266.3387),
        spawnCamera = true
    },
    ['docks1'] = {
        price = 125000,
        type = 'document_forgery',
        image = './images/businesses/14.png',
        coords = vector4(-252.6719, -2591.1978, 6.0006, 89.0923),
        target = vector3(-252.2408, -2591.1956, 6.1745),
        vehicleSpawn = vector4(-257.7222, -2581.5176, 6.2322, 359.9601),
        camera = vector4(-252.39, -2586.1895, 8.9996, 90.0),
        spawnCamera = true
    },
    ['docks2'] = {
        price = 225000,
        type = 'meth',
        image = './images/businesses/15.png',
        coords = vector4(-315.5966, -2697.6550, 7.5502, 223.5475),
        target = vector3(-315.7809, -2697.4966, 7.7522),
        vehicleSpawn = vector4(-304.9973, -2702.3196, 6.2318, 223.9389),
        camera = vector4(-311.7933, -2703.0793, 10.6080, 315.0),
        spawnCamera = true
    },
    ['docks3'] = {
        price = 200000,
        type = 'counterfeit_factory',
        image = './images/businesses/16.png',
        coords = vector4(671.8234, -2667.5344, 6.0812, 90.0),
        target = vector3(672.5561, -2667.5383, 6.4577),
        vehicleSpawn = vector4(663.6398, -2672.9990, 6.3140, 90.5724),
        camera = vector4(672.2450, -2664.3159, 8.6597, 90.0),
        spawnCamera = true
    },
    ['vespucci1'] = {
        price = 125000,
        type = 'document_forgery',
        image = './images/businesses/17.png',
        coords = vector4(-1320.1765, -1169.4877, 4.8497, 90.0),
        target = vector3(-1319.6476, -1169.4592, 5.2060),
        vehicleSpawn = vector4(-1323.2697, -1166.5033, 4.8649, 359.8101),
        camera = vector4(-1319.9188, -1167.4281, 7.7098, 90.1803),
        spawnCamera = true
    },
    ['vespucci2'] = {
        price = 275000,
        type = 'coke',
        image = './images/businesses/18.png',
        coords = vector4(-1471.8260, -920.1209, 10.0249, 233.8087),
        target = vector3(-1472.2491, -919.8125, 10.3351),
        vehicleSpawn = vector4(-1461.2311, -924.1044, 10.1727, 229.4936),
        camera = vector4(-1473.0105, -921.1329, 11.0131, 230.3719),
        spawnCamera = true
    },
    ['vespucci3'] = {
        price = 225000,
        type = 'meth',
        image = './images/businesses/19.png',
        coords = vector4(-1320.6843, -757.0616, 20.3843, 128.3880),
        target = vector3(-1320.2527, -756.7042, 20.6936),
        vehicleSpawn = vector4(-1324.2765, -762.4982, 20.5012, 218.2692),
        camera = vector4(-1321.6441, -755.4149, 22.3585, 128.3484),
        spawnCamera = true
    },
    ['bluffs1'] = {
        price = 275000,
        type = 'coke',
        image = './images/businesses/20.png',
        coords = vector4(-2022.3195, -255.4200, 23.4210, 55.2879),
        target = vector3(-2021.6665, -255.9335, 23.7969),
        vehicleSpawn = vector4(-2033.0206, -264.0719, 23.4917, 145.6359),
        camera = vector4(-2020.7306, -253.9135, 25.3781, 55.5150),
        spawnCamera = true
    },
    ['vinewood1'] = {
        price = 275000,
        type = 'coke',
        image = './images/businesses/21.png',
        coords = vector4(189.8956, 309.2420, 105.3895, 183.0883),
        target = vector3(189.8804, 309.6163, 105.7041),
        vehicleSpawn = vector4(185.0796, 304.2277, 105.4647, 94.9263),
        camera = vector4(187.0928, 309.3682, 107.0412, 183.6412),
        spawnCamera = true
    },
    ['vinewood2'] = {
        price = 125000,
        type = 'document_forgery',
        image = './images/businesses/22.png',
        coords = vector4(254.2915, 24.6001, 83.9496, 339.0316),
        target = vector3(254.1955, 24.2324, 84.1712),
        vehicleSpawn = vector4(259.0028, 30.5433, 84.1893, 69.8234),
        camera = vector4(256.4800, 23.5030, 85.5375, 339.8386),
        spawnCamera = true
    },
    ['murrieta1'] = {
        price = 275000,
        type = 'coke',
        image = './images/businesses/23.png',
        coords = vector4(716.7491, -654.5608, 27.7856, 273.1887),
        target = vector3(716.3299, -654.5975, 27.9256),
        vehicleSpawn = vector4(721.7962, -659.1468, 27.9096, 179.8876),
        camera = vector4(716.4721, -660.7780, 30.4769, 272.9428),
        spawnCamera = true
    },
    ['murrieta2'] = {
        price = 200000,
        type = 'weed',
        image = './images/businesses/24.png',
        coords = vector4(844.8999, -902.8033, 25.2515, 271.7178),
        target = vector3(844.1164, -902.8592, 25.5178),
        vehicleSpawn = vector4(852.1138, -903.2523, 25.5148, 181.1226),
        camera = vector4(844.9272, -906.1412, 29.055, 271.8468),
        spawnCamera = true
    },
    ['highway1'] = {
        price = 250000,
        type = 'meth',
        image = './images/businesses/25.png',
        coords = vector4(-2173.7837, 4282.1895, 49.1201, 237.0967),
        target = vector3(-2174.3281, 4282.4897, 49.4073),
        vehicleSpawn = vector4(-2168.5735, 4278.9077, 49.1635, 150.5157),
        camera = vector4(-2172.5364, 4283.2808, 51.9518, 237.0)
    }
}

---@class BusinessTypeData
---@field icon string
---@field blip BlipData
---@field interior InteriorData
---@field product { price: { min: integer, max: integer }, prop: ProductPropData | { normal: ProductPropData, upgraded: ProductPropData }, item: { name: string | { normal: string, upgraded: string }, count: integer } }

---@alias ProductPropData { model: string|number, bone: integer, offset: vector3, rot: vector3, dict: string, clip: string }

---@class InteriorData
---@field exit { coords: vector4, target: vector3 }
---@field laptop vector3
---@field cctv vector3
---@field stash vector3 | { coords: vector3, model: number | string }
---@field guards vector4[]
---@field confiscate vector3

---@type table<string, BusinessTypeData>
Config.businessTypes = {
    ['meth'] = {
        icon = 'flask-vial',
        blip = {
            name = locale('ui_type_meth'),
            sprite = 499,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(997.1076, -3200.6719, -36.3937, 275.0),
                target = vector3(996.5623, -3200.6897, -36.1465),
            },
            laptop = vector3(1001.9495, -3194.1707, -39.1434),
            cctv = vector3(1003.0371, -3194.3442, -39.0958),
            stash = vector3(1004.3560, -3194.3435, -38.8263),
            guards = {
                vector4(999.3573, -3200.0852, -36.3935, 95.6750),
                vector4(1017.1261, -3199.2986, -38.9933, 86.8590)
            },
            confiscate = vector3(1017.5480, -3199.3284, -38.7046)
        },
        product = {
            -- Price per 1%
            price = { min = 2250, max = 2750 },
            prop = {
                model = `bkr_prop_meth_bigbag_04a`,
                bone = 28422,
                offset = vector3(0.0, -0.03, -0.08),
                rot = vector3(35.0, -5.0, 0.0),
                dict = 'anim@heists@box_carry@',
                clip = 'idle'
            },
            -- You can also let the players withdraw an item in addition to the selling missions
            -- 100% product = 20 bags
            -- item = {
            --     name = 'meth_bag',
            --     count = 0.2
            -- }
        }
    },
    ['coke'] = {
        icon = 'flask-vial',
        blip = {
            name = locale('ui_type_coke'),
            sprite = 497,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(1088.7158, -3187.5149, -38.9935, 182.6907),
                target = vector3(1088.6937, -3187.2053, -38.7934),
            },
            laptop = vector3(1086.5826, -3194.2812, -39.1694),
            cctv = vector3(1086.6700, -3198.2395, -39.0915),
            stash = vector3(1096.9198, -3192.5608, -38.8285),
            guards = {
                vector4(1090.7985, -3189.5066, -38.9935, 93.9775),
                vector4(1093.5660, -3199.1763, -38.9935, 3.4853)
            },
            confiscate = vector3(1103.0474, -3196.2319, -39.0686)
        },
        product = {
            price = { min = 2750, max = 3250 }, -- Price per 1%
            prop = {
                normal = {
                    model = `prop_drug_package`,
                    bone = 28422,
                    offset = vector3(0.0, -0.075, 0.0),
                    rot = vector3(30.0, 0.0, 0.0),
                    dict = 'anim@heists@box_carry@',
                    clip = 'idle'
                },
                upgraded = {
                    model = `bkr_prop_coke_doll_bigbox`,
                    bone = 28422,
                    offset = vector3(0.0, -0.1, -0.15),
                    rot = vector3(40.0, 0.0, 0.0),
                    dict = 'anim@heists@box_carry@',
                    clip = 'idle'
                }
            },
            -- You can also let the players withdraw an item in addition to the selling missions
            -- 100% product = 20 bags/dolls
            -- item = {
            --     name = {
            --         normal = 'coke_bag',
            --         upgraded = 'coke_doll'
            --     },
            --     count = 0.2
            -- }
        }
    },
    ['weed'] = {
        icon = 'cannabis',
        blip = {
            name = locale('ui_type_weed'),
            sprite = 496,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(1066.4044, -3183.5330, -39.1638, 93.9428),
                target = vector3(1066.6565, -3183.4431, -38.9503),
            },
            laptop = vector3(1045.1567, -3194.8413, -38.3342),
            cctv = vector3(1045.0583, -3196.6064, -38.2542),
            stash = { coords = vector3(1045.4093, -3198.6733, -38.6549), model = `prop_cabinet_01b` },
            guards = {
                vector4(1060.0353, -3183.9941, -39.1650, 270.0),
                vector4(1038.6803, -3200.9468, -38.1691, 270.0)
            },
            confiscate = vector3(1042.2615, -3193.4773, -38.4454)
        },
        product = {
            price = { min = 1750, max = 2250 }, -- Price per 1%
            prop = {
                model = `bkr_prop_weed_bigbag_03a`,
                bone = 28422,
                offset = vector3(0.0, -0.05, -0.15),
                rot = vector3(0.0, -30.0, 90.0),
                dict = 'anim@heists@box_carry@',
                clip = 'idle'
            },
            -- You can also let the players withdraw an item in addition to the selling missions
            -- 100% product = 20 bags
            -- item = {
            --     name = 'weed_bag',
            --     count = 0.2
            -- }
        },
    },
    ['counterfeit_factory'] = {
        icon = 'money-bill-wave',
        blip = {
            name = locale('ui_type_counterfeit_factory'),
            sprite = 500,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(1138.1237, -3199.1963, -39.6658, 4.5842),
                target = vector3(1138.1060, -3199.4482, -39.4796),
            },
            laptop = vector3(1129.5422, -3193.5024, -40.5682),
            cctv = vector3(1135.2314, -3193.5107, -40.4661),
            stash = vector3(1138.4855, -3193.2441, -40.4541),
            guards = {
                vector4(1136.9071, -3193.2664, -40.3912, 180.0),
                vector4(1127.5344, -3194.2104, -40.3969, 186.5505)
            },
            confiscate = vector3(1118.5190, -3193.7800, -40.7601)
        },
        product = {
            price = { min = 1500, max = 1750 },
            prop = {
                model = `bkr_prop_moneypack_03a`,
                bone = 28422,
                offset = vector3(0.0, -0.05, -0.15),
                rot = vector3(0.0, -30.0, 90.0),
                dict = 'anim@heists@box_carry@',
                clip = 'idle'
            },
            -- You can also let the players withdraw an item in addition to the selling missions
            -- 100% product = 45 000x black money (configure below)
            -- item = {
            --     name = 'black_money',
            --     count = 450
            -- }
        },
        
    },
    ['document_forgery'] = {
        icon = 'id-card',
        blip = {
            name = locale('ui_type_document_forgery'),
            sprite = 498,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(1173.6333, -3196.6851, -39.0080, 90.0),
                target = vector3(1174.0386, -3196.6855, -38.8448),
            },
            laptop = vector3(1160.2932, -3192.8718, -39.1878),
            cctv = vector3(1156.0712, -3194.5017, -39.0003),
            stash = vector3(1171.7858, -3199.3518, -39.0277),
            guards = {
                vector4(1172.2919, -3194.4753, -39.0080, 180.0)
            },
            confiscate = vector3(1161.3427, -3190.3586, -39.0618)
        },
        product = {
            price = { min = 1000, max = 1500 },
            prop = {
                model = `bkr_prop_fakeid_boxdriverl_01a`,
                bone = 28422,
                offset = vector3(0.0, -0.05, -0.15),
                rot = vector3(30.0, 0.0, 0.0),
                dict = 'anim@heists@box_carry@',
                clip = 'idle'
            },
            -- You can also let the players withdraw an item in addition to the selling missions
            -- 100% product = 20 fake IDs
            -- item = {
            --     name = 'fake_id',
            --     count = 0.2
            -- }
        },
    }
}

-- Each business will produce 100% product per 200% supplies, encouraging players to do resupply missions
Config.product = {
    updateCron = '*/30 * * * *',
    add = 2.5, -- This % gets added to product every cycle
    remove = 5.0, -- This % get removed from supplies every cycle

    multipliers = {
        applyOnRemove = false, -- The multipliers will also be applied on the remove value
        employeeUpgrade = 1.25, --25% speed multiplier
        equipmentUpgrade = 1.25 --25% price multiplier
    },
}

Config.camera = {
    rotateSpeed = 0.3,
    controls = {
        left = 34,
        right = 35,
        up = 32,
        down = 33
    }
}

Config.stash = {
    shared = true,
    label = 'Business Stash',
    maxWeight = 120000,
    slots = 50
}

-- The buy supplies option
Config.supplies = {
    account = 'bank',
    price = 50000,
    add = 100.0, -- This % gets added when players buy supplies
}

Config.equipment = {
    account = 'bank',
    upgradePrice = 45000,

    -- The setup truck
    ---@type BlipData
    blip = {
        name = locale('equipment_truck'),
        sprite = 477,
        size = 0.75,
        color = 2
    },

    ---@type vector4[]
    locations = {
        vector4(941.4631, 3611.4692, 32.7135, 89.6993),
        vector4(647.3121, 176.3315, 95.6032, 340.4091),
        vector4(-572.1333, -1148.6094, 22.2848, 346.9533),
        vector4(1203.3523, 1864.5294, 78.5083, 139.5705),
        vector4(1062.4658, -1907.5056, 31.1398, 0.3939),
        vector4(-329.8174, -1489.8960, 30.7097, 268.6609)
    }
}

Config.employees = {
    account = 'bank',
    upgradePrice = 37500,
}

Config.security = {
    account = 'bank',
    price = 35000,
}

Config.guards = {
    weapon = `WEAPON_COMBATPISTOL`,
    scenario = 'WORLD_HUMAN_GUARD_STAND',
    accuracy = 20, -- from 0 - 100
    combatAbility = 70, -- from 0 - 100, peds can start to run away if less than 50
}

Config.raiding = {
    enabled = true,
    chance = 5, -- The chance a business will get reported
    minBought = 5, -- The minimum required count of bought business, otherwise the chance would be too high for one business.
    needsProduct = true, -- The business needs to have at least 1% product
    accept = 20 * 60000, -- The time the police have to break inside the business
    duration = 30 * 60000, -- The maximal duration of the raid, the business will close after this elapses and the raid will be marked as unsuccessful
    interval = 60 * 60000,
    dispatchCode = '10-84',
    ---@type 'normal' | 'quasar'
    minigame = 'normal',

    -- The business will become available after seizedIntervals elapses
    -- Example: A business has been seized and will be available after 10 hours because each cycle is 1 hour (Config.raiding.interval)
    seizedIntervals = 10,
}

-- The minimum number of police to start resupplying and selling missions
Config.minPolice = {
    resupplying = 0,
    selling = 4
}

Config.resupplyMissions = {
    ['cartel'] = {
        -- This value gets added to supply
        addSupplies = 100.0,

        ---@type { coords: vector4, vehicles: vector4[], guards: vector4[], props: { coords: vector4, model: string | number } }[]
        locations = {
            {
                coords = vector4(1247.2516, -2366.0352, 49.3186, 343.9325),
                vehicles = {
                    vector4(1257.9259, -2361.4883, 49.8645, 354.0425),
                    vector4(1253.9811, -2349.5713, 50.0204, 73.6613),
                    vector4(1241.3398, -2353.8369, 49.8999, 311.8073),
                    vector4(1235.2369, -2367.2939, 49.5255, 165.7329),
                    vector4(1249.1901, -2377.9646, 48.6501, 99.7752)
                },
                guards = {
                    vector4(1237.6757, -2369.4700, 49.2718, 252.4012),
                    vector4(1237.5541, -2369.3740, 49.2833, 248.4485),
                    vector4(1243.3423, -2355.4224, 49.8077, 228.5351),
                    vector4(1246.5724, -2348.6135, 50.0918, 9.9241),
                    vector4(1253.3312, -2351.3853, 50.1745, 161.8774),
                    vector4(1259.8169, -2353.9556, 50.3054, 315.0196),
                    vector4(1257.5078, -2365.2712, 49.6679, 184.3665),
                    vector4(1249.9053, -2376.0015, 48.7793, 23.0057),
                    vector4(1222.4058, -2363.8257, 50.2812, 231.2636),
                    vector4(1227.0367, -2356.5725, 50.2815, 235.3814),
                    vector4(1233.8109, -2347.3430, 50.1630, 233.6782),                    
                },
                props = {
                    {
                        coords = vector4(1250.2173, -2356.6824, 49.8315, 167.1767),
                        model = `imp_prop_impexp_boxpile_01`
                    },
                    {
                        coords = vector4(1254.6758, -2371.3171, 49.2876, 242.2704),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(1241.2037, -2374.1599, 48.8868, 142.4322),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(1240.7836, -2362.3914, 49.5505, 254.7222),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            },
            {
                coords = vector4(3260.8445, 5148.9897, 19.6015, 270.8692),
                vehicles = {
                    vector4(3260.0566, 5164.6260, 19.9007, 109.1142),
                    vector4(3243.0723, 5138.8618, 19.7438, 195.8629),
                    vector4(3273.4529, 5142.3936, 19.6453, 299.2679),
                    vector4(3283.3215, 5152.4692, 18.8560, 60.0525),
                    vector4(3251.9722, 5150.0708, 19.7956, 145.0475)
                },
                guards = {
                    vector4(3252.7336, 5148.7124, 19.5327, 238.8389),
                    vector4(3244.8921, 5138.6021, 19.5381, 299.2000),
                    vector4(3244.3145, 5131.8599, 19.6221, 88.9538),
                    vector4(3262.2454, 5147.7852, 19.5764, 205.9565),
                    vector4(3273.9915, 5144.3604, 19.3733, 47.6898),
                    vector4(3282.0476, 5151.5181, 18.7404, 147.9063),
                    vector4(3259.7664, 5162.5635, 19.6854, 207.8613),
                    vector4(3266.5623, 5156.2236, 19.8262, 147.4601),
                    vector4(3253.8633, 5152.9351, 19.6203, 328.4379),
                    vector4(3282.0247, 5145.6025, 18.8684, 74.1059)
                },
                props = {
                    {
                        coords = vector4(3271.1079, 5148.4321, 19.5150, 77.2254),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(3258.7161, 5157.7295, 19.6968, 207.4874),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(3250.0249, 5141.9653, 19.6071, 119.7399),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            },
            {
                coords = vector4(1312.2173, 4330.1641, 38.2834, 176.5406),
                vehicles = {
                    vector4(1331.2623, 4333.0234, 38.0336, 355.4502),
                    vector4(1315.2561, 4354.9790, 41.0139, 77.4892),
                    vector4(1316.0438, 4339.0063, 39.0838, 225.6369),
                    vector4(1298.0200, 4330.1392, 38.6954, 160.4447),
                    vector4(1312.2784, 4315.4360, 38.2792, 268.3763)
                },
                guards = {
                    vector4(1332.8058, 4332.9849, 37.7383, 262.0412),
                    vector4(1317.4680, 4339.4346, 38.8252, 315.8046),
                    vector4(1304.6348, 4340.7881, 41.3209, 251.9367),
                    vector4(1314.5707, 4356.7607, 40.7894, 2.9773),
                    vector4(1313.8979, 4353.9341, 40.7230, 159.7679),
                    vector4(1313.3093, 4327.1787, 38.1933, 258.6804),
                    vector4(1313.0273, 4316.8408, 38.1429, 6.1273),
                    vector4(1298.9424, 4328.8877, 38.4436, 259.3924),
                    vector4(1332.1521, 4356.3657, 43.4204, 140.2391),
                    vector4(1329.5575, 4333.8315, 37.7848, 88.7987)
                },
                props = {
                    {
                        coords = vector4(1320.9781, 4329.9849, 38.1376, 53.4940),
                        model = `imp_prop_impexp_boxpile_01`
                    },
                    {
                        coords = vector4(1304.9008, 4321.5825, 38.1312, 313.4237),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(1311.5784, 4346.3687, 39.8810, 276.2325),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(1323.6210, 4341.5645, 38.7482, 166.9133),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            },
            {
                coords = vector4(598.0219, 2898.3708, 40.0361, 275.0382),
                vehicles = {
                    vector4(610.4671, 2888.2568, 39.6968, 313.2640),
                    vector4(578.6074, 2891.2913, 39.3005, 21.3415),
                    vector4(574.1249, 2913.0017, 40.2399, 336.1572),
                    vector4(620.4548, 2909.5325, 39.9254, 173.6038),
                    vector4(615.0797, 2926.6238, 40.4453, 59.1348)
                },
                guards = {
                    vector4(613.6083, 2925.8860, 40.2374, 153.5292),
                    vector4(618.9485, 2908.5688, 39.7241, 92.5984),
                    vector4(609.9965, 2889.6621, 39.4848, 49.3198),
                    vector4(579.4346, 2892.8777, 39.3218, 286.9238),
                    vector4(575.7310, 2913.2690, 39.9564, 250.1581),
                    vector4(597.8163, 2922.3762, 40.8367, 218.4974),
                    vector4(592.2086, 2935.8518, 40.9455, 11.7683),
                    vector4(606.9976, 2930.7051, 40.6803, 1.4256),
                    vector4(621.5616, 2920.4587, 39.8964, 319.5483),
                    vector4(598.1590, 2900.2490, 40.0107, 12.8860),
                    vector4(598.1119, 2896.3757, 39.9288, 187.1196),
                    vector4(573.7108, 2901.7791, 39.3940, 105.4415),
                    vector4(572.8996, 2924.1743, 40.6491, 88.1809)
                },
                props = {
                    {
                        coords = vector4(588.5804, 2910.8958, 40.1087, 193.5427),
                        model = `imp_prop_impexp_boxpile_01`
                    },
                    {
                        coords = vector4(587.8481, 2891.1504, 39.5138, 173.2756),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(612.6086, 2916.5422, 39.9932, 149.8237),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(609.5984, 2900.8779, 39.6580, 49.2948),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            },
            {
                coords = vector4(-937.7779, 5575.5825, 3.2983, 309.6037),
                vehicles = {
                    vector4(-920.7260, 5589.5898, 3.0922, 222.9705),
                    vector4(-914.3781, 5571.6836, 3.7175, 161.5622),
                    vector4(-924.3270, 5552.7842, 6.8952, 295.4660),
                    vector4(-939.8539, 5549.0098, 6.6701, 72.3847),
                    vector4(-956.9144, 5561.4326, 4.2267, 36.6238)
                },
                guards = {
                    vector4(-921.0704, 5587.9741, 2.8933, 125.0736),
                    vector4(-915.8311, 5571.1655, 3.4397, 76.9503),
                    vector4(-924.2215, 5554.1558, 6.5372, 32.0661),
                    vector4(-940.2032, 5550.4233, 6.2854, 349.7626),
                    vector4(-956.4331, 5562.8984, 3.8412, 310.4549),
                    vector4(-940.0992, 5575.6465, 3.0749, 48.0636),
                    vector4(-938.2595, 5576.9531, 3.0243, 46.4240),
                    vector4(-915.3680, 5581.0835, 3.1566, 305.2593),
                    vector4(-917.6772, 5561.4639, 5.3167, 248.6042),
                    vector4(-931.5181, 5549.2554, 6.6343, 204.2613),
                    vector4(-948.8240, 5552.4956, 5.6190, 164.1301),
                },
                props = {
                    {
                        coords = vector4(-925.3185, 5578.0229, 3.0639, 300.3147),
                        model = `imp_prop_impexp_boxpile_01`
                    },
                    {
                        coords = vector4(-945.5035, 5566.7266, 3.5951, 162.1616),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(-931.8897, 5569.2427, 3.3516, 227.8054),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(-945.5165, 5583.6265, 2.4797, 225.0863),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            }
        },
        
        failOnDeath = false, -- This will fail the mission once the player is dead
        duration = 30 * 60000, -- The player has this much time or the mission will cancel

        ---@type BlipData
        destinationBlip = {
            name = locale('cartel_site'),
            sprite = 456,
            size = 0.75,
            color = 1
        },

        suppliesBlip = {
            name = locale('supplies_vehicle'),
            sprite = 501,
            size = 0.85,
            color = 57
        },

        guard = {
            model = `g_m_m_armlieut_01`,
            accuracy = 20, -- from 0 - 100
            combatAbility = 70, -- from 0 - 100, peds can start to run away if less than 50
            blip = {
                name = locale('cartel_member'),
                sprite = 57,
                size = 0.4,
                color = 1
            },
            weapons = {
                `weapon_assaultrifle`,
                `weapon_compactrifle`
            }
        }
    },
    ['police'] = {
        -- This value gets added to supply
        addSupplies = 100.0,

        locations = {
            { coords = vector4(-665.0396, -2380.0674, 13.9266, 240.0), target = vector3(-663.6684, -2380.8398, 14.2104) },
            { coords = vector(-632.5750, -1779.7797, 24.0103, 308.2451), target = vector3(-631.2947, -1778.8330, 24.5177) },
            { coords = vector4(962.5246, -1529.0660, 31.0475, 91.2167), target = vector3(960.9048, -1529.0809, 31.2324) },
            { coords = vector4(1191.9735, -1261.4790, 35.1752, 87.9828), target = vector3(1190.4578, -1261.3351, 35.7448) }
        },

        interior = {
            coords = vector4(970.9266, -2988.4470, -39.6484, 180.0),
            alarmCoords = vector3(982.6199, -3002.4810, -34.4820),
            vehicles = {
                vector4(977.0986, -3002.0845, -39.8487, 270.0),
                vector4(977.0986, -2997.3154, -39.8912, 270.0),
                vector4(977.0986, -3006.6050, -39.8912, 270.0),
                vector4(995.7874, -3021.5, -39.6622, 360.0),
                vector4(999.7745, -3021.5, -39.6626, 360.0),
                vector4(1003.2407, -3021.5, -39.6620, 360.0),
                vector4(997.7669, -3000.4524, -39.6630, 90.0),
                vector4(998.0952, -3005.2930, -39.6628, 90.0),
                vector4(998.2277, -3009.0459, -39.6624, 90.0),
                vector4(997.8085, -2996.7305, -39.6622, 90.0),
                vector4(961.4186, -3018.2314, -39.6622, 270.0),
                vector4(961.6453, -3023.4067, -39.6619, 270.0),
                vector4(961.6016, -3028.6191, -39.6625, 270.0),
                vector4(970.4099, -3029.8618, -39.6470, 0.0)
            },
            coveredVehicles = {
                vector4(984.6641, -3002.3271, -39.6469, 181.1243),
                vector4(984.7107, -3010.0347, -39.6469, 179.1576),
                vector4(988.0569, -2989.8015, -40.2737, 91.0512),
                vector4(993.3201, -2989.7971, -40.2739, 92.0380),
                vector4(998.4955, -2989.6277, -40.2740, 91.6626)
            },
            guards = {
                vector4(965.0439, -3003.5046, -39.6399, 93.8839),
                vector4(959.5746, -3001.1755, -39.6399, 273.4440),
                vector4(961.1934, -2994.5891, -39.6469, 99.8700),
                vector4(959.9212, -3010.6243, -39.6469, 186.2112),
                vector4(968.4106, -3003.5784, -39.6469, 269.9157),
                vector4(985.9042, -3010.2737, -39.6469, 273.7850),
                vector4(993.3632, -2992.7808, -39.6470, 184.7905),
                vector4(962.5853, -3016.9729, -39.6470, 357.5510),
                vector4(1005.7272, -3007.5935, -39.6470, 93.4400),
                vector4(1008.7323, -3021.8772, -39.6470, 95.5488),
                vector4(977.3017, -3031.1699, -39.6470, 92.5251)
            }
        },
        
        failOnDeath = false, -- This will fail the mission once the player is dead
        duration = 30 * 60000, -- The player has this much time or the mission will cancel

        ---@type BlipData
        destinationBlip = {
            name = locale('police_warehouse'),
            sprite = 473,
            size = 0.75,
            color = 1
        },
        
        suppliesBlip = {
            name = locale('supplies_vehicle'),
            sprite = 501,
            size = 0.85,
            color = 57
        },
       
        guard = {
            model = `s_m_y_cop_01`,
            accuracy = 20, -- from 0 - 100
            combatAbility = 70, -- from 0 - 100, peds can start to run away if less than 50
            ignorePolice = true, -- Ignores players with law enforcement jobs, can be configured in lunar_bridge/config/cl_edit.lua
            count = 8, -- The total count of the spawned guards, make sure this doesn't exceed the number of guard locations
            weapons = {
                `weapon_carbinerifle`,
                `weapon_combatpistol`
            }
        },

        -- The police vehicle models
        vehicles = {
            van = `policet`,
            other = {
                `police`,
                `police2`,
                `police3`
            }
        },

        minigame = 'howdy-hackminigame' -- Can be further configured in cl_edit.lua
    },
    ['bikers'] = {
        -- This value gets added to supply
        addSupplies = 100.0,

        ---@type { coords: vector4, peds: vector4[] }[]
        locations = {
            vector4(105.4674, 3516.1650, 39.7811, 158.7030),
            vector4(2336.9668, 3099.4236, 48.0702, 53.5741),
            vector4(1116.6276, 3344.0469, 34.9756, 171.4902),
            vector4(2625.5308, 5184.0073, 44.7662, 14.4707),
            vector4(2295.0225, 5532.3945, 51.0836, 255.4049),
            vector4(1848.4862, 4580.3652, 36.1875, 98.3344),
            vector4(615.8569, 4240.2886, 54.1649, 93.7509),
            vector4(-1716.7965, 4801.3691, 59.1259, 130.3640),
            vector4(-2855.3928, 2188.2944, 33.4880, 121.2087),
            vector4(-1992.3380, 1909.4169, 186.0895, 247.7335),
            vector4(-430.7834, 2756.6204, 45.7026, 327.6571),
            vector4(928.4147, 2705.7185, 40.4900, 193.2399),
            vector4(1496.7501, 2128.5208, 89.8180, 192.7370),
        },
        
        bikeCount = 5,
        failOnDeath = false, -- This will fail the mission once the player is dead
        duration = 30 * 60000, -- The player has this much time or the mission will cancel

        suppliesBlip = {
            name = locale('supplies_vehicle'),
            sprite = 501,
            size = 0.85,
            color = 57
        },

        guard = {
            model = `g_m_y_lost_01`,
            accuracy = 20, -- from 0 - 100
            combatAbility = 70, -- from 0 - 100, peds can start to run away if less than 50
            blip = {
                name = locale('mc_gang_member'),
                sprite = 270,
                size = 0.5,
                color = 1
            },
            weapons = {
                `weapon_microsmg`,
                `weapon_pistol`
            }
        }
    },
}

--- You can enable this on individual missions
Config.sellingDispatch = {
    code = '10-85',
    title = locale('contraband_transport'),
    message = locale('dispatch_message'),
    interval = 5000 -- How frequently should the vehicle blip update, I don't recommend lowering this
}

Config.sellingMissions = {
    ['heli'] = {
        spawnLocations = {
            vector4(1737.2762, 3288.9695, 41.1432, 195.1313),
            vector4(2127.0159, 4796.5254, 41.1410, 27.2316),
            vector4(2912.2065, 4385.3887, 50.2049, 23.8109),
            vector4(1696.6659, 4801.6987, 41.8139, 90.2743),
            vector4(309.8636, 2878.0466, 43.5068, 36.8846),
            vector4(833.0612, 2140.5862, 52.1965, 288.8540),
        },

        deliveryLocations = {
            vector4(583.9670, 192.0035, 137.2020, 255.0762),
            vector4(376.6259, -702.9108, 85.6122, 182.3180),
            vector4(-577.0567, 59.3893, 116.5382, 93.2602),
            vector4(-771.1755, 244.5480, 132.2933, 193.4232),
            vector4(-754.8808, 334.6453, 230.6368, 92.0278),
            vector4(751.9625, 1295.9928, 360.2964, 93.3296),
            vector4(972.9878, 38.1955, 123.1200, 59.5904),
            vector4(-1103.7469, -1677.4426, 4.4690, 131.2399),
            vector4(-696.5988, -1398.9912, 5.1503, 234.8294),
            vector4(-801.1472, -1341.5168, 5.1503, 354.7481),
            vector4(1213.6854, -1262.7292, 35.2267, 94.5558),
            vector4(1090.1874, -2279.2439, 30.1448, 271.1415),
            vector4(1557.4801, -2123.6709, 77.3325, 104.8235),
            vector4(1735.5421, -1614.1454, 112.4454, 100.9477),
            vector4(770.1660, -1776.7930, 49.3069, 267.0798),
            vector4(-514.9859, -2202.5020, 6.3940, 326.1316),
            vector4(-1560.8677, -569.0653, 114.4484, 40.0019),
            vector4(-1386.9302, -471.2593, 91.2578, 129.6345),
            vector4(-902.6803, -369.7690, 136.2820, 121.5296),
            vector4(232.8006, -1781.4396, 28.9484, 318.6662),
            vector4(536.1611, -1868.1776, 25.3320, 310.9467)
        },

        payoutLocations = {
            vector4(1726.1587, 3290.9607, 41.1870, 206.5707),
            vector4(2137.9722, 4796.8140, 41.1307, 21.8015)
        },

        duration = 30 * 60000,
        van = {
            model = `mule3`,
            offset = vector3(0.0, -3.6, 0.5)
        },
        productsPerLocation = { min = 1, max = 2, },
        stops = 1, -- 1 location per 25% of product
        account = 'money',

        ---@type BlipData
        deliveryBlip = {
            name = locale('heli_dropoff'),
            sprite = 1,
            color = 2,
            size = 0.75
        },

        helicopter = {
            model = `frogger`,
            offset = vector3(0.0, -1.0, 0.2), -- The interaction offset
            ---@type BlipData
            blip = {
                name = locale('heli'),
                sprite = 64,
                color = 2,
                size = 0.75
            }
        },

        payoutPed = {
            model = `s_m_y_armymech_01`,
            ---@type BlipData
            blip = {
                name = locale('payout_ped'),
                sprite = 431,
                color = 2,
                size = 0.9
            }
        },

        dispatch = {
            enabled = true,
            blip = { --The blip attached to the vehicle
                name = locale('contraband_heli'),
                sprite  = 422,
                size   = 1.0,
                color  = 1
            }
        }
    },
    ['plane'] = {
        spawnLocations = {
            vector4(1737.2762, 3288.9695, 41.1432, 195.1313),
            vector4(2127.0159, 4796.5254, 41.1410, 27.2316),
        },

        deliveryLocations = {
            vector3(289.2734, 3464.9768, 35.7487),
            vector3(-289.6734, 3084.8374, 34.4477),
            vector3(-732.1595, 2661.1379, 57.0199),
            vector3(-1366.6406, 2154.0066, 51.7221),
            vector3(-2098.4558, 2308.8042, 37.5695),
            vector3(-2545.7759, 1897.5160, 168.0480),
            vector3(-409.2971, 1183.5721, 325.5504),
            vector3(744.0992, 1293.5536, 360.2964),
            vector3(896.1061, 2179.9189, 49.2168),
            vector3(1029.9441, 2488.2441, 49.3473),
            vector3(1576.1831, 2212.5715, 78.7988),
            vector3(2339.2791, 2538.0339, 46.6672),
            vector3(2682.1182, 2840.0591, 40.0055),
            vector3(2643.0095, 3272.0735, 55.2206),
            vector3(1982.2487, 3775.3289, 32.1810),
            vector3(2173.0125, 3360.6670, 45.4538),
            vector3(1709.3025, 3866.0557, 34.8516),
            vector3(717.9826, 4175.7168, 40.7074),
            vector3(400.5365, 3573.3433, 33.2916),
            vector3(197.9259, 2792.7009, 45.6543),
            vector3(529.1071, 2633.6543, 42.2825),
            vector3(747.6173, 2522.8826, 73.1460),
            vector3(1366.9373, -579.5463, 74.3802),
            vector3(1148.2439, -1329.0793, 34.6567),
            vector3(1629.8605, -2253.0269, 107.1846),
            vector3(-88.0798, -2114.7114, 16.7048),
            vector3(-1181.4564, -1642.2559, 4.3739),
            vector3(-1308.5771, -1092.0389, 6.9965),
            vector3(-1382.0186, -558.0913, 30.2290),
            vector3(-1736.2837, 158.8942, 64.3711),
            vector3(-1171.9829, 89.5488, 58.0573),
            vector3(-772.9894, 153.1267, 67.4745),
            vector3(-1270.2065, 604.2950, 139.2678),
            vector3(-1763.3403, -1142.7482, 13.1078),
            vector3(102.3343, -1939.4664, 20.8037),
            vector3(482.0912, -1979.4932, 24.6279),
            vector3(771.3566, -233.1690, 66.1145)
        },

        payoutLocations = {
            vector4(1726.1587, 3290.9607, 41.1870, 206.5707),
            vector4(2137.9722, 4796.8140, 41.1307, 21.8015)
        },

        duration = 30 * 60000,
        van = {
            model = `mule3`,
            offset = vector3(0.0, -3.6, 0.5)
        },
        stops = 1, -- Locations per 25% of product, will get floored
        maxHeightAboveGround = 150.0,
        account = 'money',

        ---@type BlipData
        deliveryBlip = {
            name = locale('plane_dropoff'),
            sprite = 1,
            color = 60,
            size = 0.75
        },

        plane = {
            model = `cuban800`,
            offset = vector3(0.0, -0.8, -0.2),
            ---@type BlipData
            blip = {
                name = locale('plane'),
                sprite = 578,
                color = 2,
                size = 0.9
            }
        },

        payoutPed = {
            model = `s_m_y_armymech_01`,
            ---@type BlipData
            blip = {
                name = locale('payout_ped'),
                sprite = 431,
                color = 2,
                size = 0.9
            }
        },

        dispatch = {
            enabled = true,
            blip = { --The blip attached to the vehicle
                name = locale('contraband_plane'),
                sprite  = 578,
                size   = 1.0,
                color  = 1
            }
        }
    },
    ['plane2'] = {
        spawnLocations = {
            vector4(1737.2762, 3288.9695, 41.1432, 195.1313),
            vector4(2127.0159, 4796.5254, 41.1410, 27.2316),
        },

        duration = 30 * 60000,
        account = 'money', -- The reward account
        van = {
            model = `mule`,
            offset = vector3(0.0, -3.6, 0.5)
        },
        bags = 1.5, -- Per 25%

        plane = {
            model = `velum`,
            offset = vector3(0.0, -0.8, -0.2),
            ---@type BlipData
            blip = {
                name = locale('plane'),
                sprite = 582,
                color = 2,
                size = 0.9
            }
        },

        delivery = {
            coords = vector4(4497.6743, -4483.4932, 4.2003, 290.0),
            planeCoords = vector4(4489.2456, -4500.1743, 5.1185, 290.6390),
            playerCoords = {
                vector4(4490.6099, -4486.4126, 4.2048, 182.9219),
                vector4(4486.9951, -4487.4307, 4.2053, 198.7189),
                vector4(4482.8887, -4489.3262, 4.2026, 215.7588),
                vector4(4480.3994, -4491.5205, 4.1994, 231.2580)
            },
            ---@type BlipData
            blip = {
                name = locale('buyer'),
                sprite = 431,
                color = 2,
                size = 0.9
            }
        },

        dispatch = {
            enabled = true,
            blip = { --The blip attached to the vehicle
                name = locale('contraband_plane'),
                sprite  = 582,
                size   = 1.0,
                color  = 1
            }
        }
    }
}