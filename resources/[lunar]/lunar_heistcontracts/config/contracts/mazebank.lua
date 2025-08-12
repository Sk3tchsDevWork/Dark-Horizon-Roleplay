Config.contracts.mazebank = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 2,
        price = 1250,
        requiredExperience = 2000,
        expiry = 24 * 60,
        timeToStart = 2 * 60,
        minMembers = 0,
        -- maxMembers = 16,
        rewards = { crypto = 625, experience = 3500 },
        minPolice = 0
    },

    duration = 120, -- The bank will reset after this duration (minutes)
    image = './contracts/mazebank.png',
    
    blip = {
        coords = vector3(-1305.2987, -822.9234, 18.5427),
        name = locale('mazebank'),
        sprite = 1,
        size = 0.75,
        color = 1
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_mazebank_title'),
        message = locale('dispatch_mazebank_message'),
    },

    alarm = {
        coords = vector3(-1300.8414, -819.5316, 24.8872),
        duration = 60, -- seconds
        silentDelay = 2 -- minutes after the main vault door is opened
    },

    cancelPoint = vector3(-1308.7822, -822.1907, 16.9513),

    miniSafe = {
        model = `ch_prop_ch_arcade_safe_door`,
        ---@type { item: string?, account: string?, count: integer | { min: integer, max: integer }, chance: integer? }[]
        rewards = {
            { account = 'money', count = { min = 10000, max = 20000 } },
            { item = 'classified_docs', count = { min = 1, max = 3 } },
            { item = 'rare_coins', count = 1, chance = 75 },
            { item = 'luxurious_watch', count = { min = 1, max = 2 }, chance = 50 },
            { item = 'WEAPON_PISTOL', count = 1, chance = 25 }
        },
        locations = {
            vector3(-1301.263062, -833.949951, 17.028463),
            vector3(-1298.733765, -837.328491, 17.020092)
        }
    },
    
    securityDoors = {
        requiredItem = 'hack_card',
        removeAfterUse = false,
        locations = {
            { 
                model = `3dp_heist_mb_door_03a`,
                coords = vector3(-1306.282959, -802.649170, 17.699638),
            },
            {
                model = `3dp_heist_mb_door_03b`,
                coords = vector3(-1287.248413, -833.732056, 17.186550)
            },
            {
                model = `3dp_heist_mb_door_03a`,
                coords = vector3(-1290.830078, -820.436890, 13.401421)
            },
            {
                {
                    model = `3dp_heist_mb_door_03c`,
                    coords = vector3(-1304.760376, -813.675903, 16.993603)
                },
                {
                    model = `3dp_heist_mb_door_03d`,
                    coords = vector3(-1305.718384, -814.404358, 17.008446)
                }
            },
            {
                model = `3dp_heist_mb_door_03b`,
                coords = vector3(-1312.940918, -819.711975, 17.020773),
            },
            {
                {
                    model = `3dp_heist_mb_door_03a`,
                    coords = vector3(-1317.250977, -815.547119, 17.210863)
                },
                {
                    model = `3dp_heist_mb_door_03e`,
                    coords = vector3(-1318.238525, -816.297729, 17.240623)
                }
            },
            {
                model = `3dp_heist_mb_door_03c`,
                coords = vector3(-1296.918091, -823.382080, 12.176346)
            }
        }
    },

    garage = {
        door = {
            model = `3dp_heist_mb_door_garage`,
            coords = vector3(-1308.8259, -799.2615, 17.5770)
        },
        panel = vector3(-1310.6274, -797.3398, 18.1308)
    },

    -- The doors you get access to by hacking the laptops
    keypadDoors = {
        laptops = {
            model = `xm_prop_x17_laptop_mrsr`,
            requiredItem = 'hack_usb',
            removeAfterUse = false,
            locations = {
                vector4(-1316.3192, -824.4130, 21.6517 + 0.08, 120.0),
                vector4(-1302.1145, -831.2632, 16.7762 + 0.08, 305.0),
                vector4(-1293.2780, -841.9716, 16.8312, 40.0),
                vector4(-1310.7767, -822.2935, 16.9795, 217.5),
            }
        },
        keypads = {
            vector3(-1294.145996, -825.609253, 12.326508),
            vector3(-1320.644409, -809.222473, 17.895773)
        },
        doors = {
            model = `3dp_heist_mb_door_02`,
            locations = {
                vector3(-1294.769775, -826.188110, 12.155995),
                vector3(-1320.020752, -808.642944, 17.739954)
            }
        }
    },

    sewers = {
        doors = {
            model = `3dp_heist_mb_door_05`,
            locations = {
                vector3(-1309.419067, -832.891174, 2.261971),
                vector3(-1327.538208, -832.636047, 2.271874)
            }
        },
        generators = {
            requiredItem = 'hack_usb',
            removeAfterUse = false,
            locations = {
                vector4(-1299.5825, -818.5009, 2.1823, 35.0),
                vector4(-1296.7056, -816.3258, 2.1879, 35.0),
            }
        }
    },

    elevator = {
        door = {
            {
                model = `3dp_heist_mb_door_elevator_01`,
                coords = vector3(-1308.3474, -816.4176, 12.2113) 
            },
            {
                model = `3dp_heist_mb_door_elevator_02`,
                coords = vector3(-1309.2589, -817.1027, 12.2109) 
            },
        },
        requiredWeapon = `WEAPON_CROWBAR` -- The player needs to have the crowbar in his hand to open it
    },

    lasers = {
        -- The lasers will only render when 25.0 meters close
        -- This saves resmon for players that are not near
        render = {
            coords = vector4(-1304.2406, -821.7767, 12.0517, 128.2417),
            radius = 25.0,
            debug = false
        },
        -- Players need to disable this so the lasers go away
        electricBox = {
            model = `h4_prop_h4_elecbox_01a`,
            coords = vector4(-1288.8845, -828.3317, 4.1502, 127.5),
            requiredItem = false,
        },
        origins = {
            -- vector3(-1314.0662, -826.4775, 11.5519),
            -- vector3(-1311.5367, -829.8341, 11.5941),

            vector3(-1304.4268, -819.2604, 11.4),
            vector3(-1304.4268, -819.2604, 11.7),
            vector3(-1304.4268, -819.2604, 12.0),
            vector3(-1304.4268, -819.2604, 12.3),
            vector3(-1304.4268, -819.2604, 12.6),
            vector3(-1304.4268, -819.2604, 12.9),
            vector3(-1304.4268, -819.2604, 13.2),
            vector3(-1304.4268, -819.2604, 13.5),

            vector3(-1301.9183, -822.5892, 11.4),
            vector3(-1301.9183, -822.5892, 11.7),
            vector3(-1301.9183, -822.5892, 12.0),
            vector3(-1301.9183, -822.5892, 12.3),
            vector3(-1301.9183, -822.5892, 12.6),
            vector3(-1301.9183, -822.5892, 12.9),
            vector3(-1301.9183, -822.5892, 13.2),
            vector3(-1301.9183, -822.5892, 13.5),
        },
        ends = {
            vector3(-1314.0662, -826.4775, 11.4),
            vector3(-1314.0662, -826.4775, 11.7),
            vector3(-1314.0662, -826.4775, 12.0),
            vector3(-1314.0662, -826.4775, 12.3),
            vector3(-1314.0662, -826.4775, 12.6),
            vector3(-1314.0662, -826.4775, 12.9),
            vector3(-1314.0662, -826.4775, 13.2),
            vector3(-1314.0662, -826.4775, 13.5),

            vector3(-1311.5367, -829.8341, 11.4),
            vector3(-1311.5367, -829.8341, 11.7),
            vector3(-1311.5367, -829.8341, 12.0),
            vector3(-1311.5367, -829.8341, 12.3),
            vector3(-1311.5367, -829.8341, 12.6),
            vector3(-1311.5367, -829.8341, 12.9),
            vector3(-1311.5367, -829.8341, 13.2),
            vector3(-1311.5367, -829.8341, 13.5),
        }
    },

    serverRoomTerminal = {
        coords = vector4(-1292.4137, -830.0056, 12.4114, 128.0),
        requiredItem = 'hack_card',
        removeAfterUse = false
    },
    
    cameras = {
        desks = {
            vector3(-1323.8210, -809.8907, 17.4086),
            vector3(-1325.3060, -807.9097, 17.4086), 
        },
        settings = {
            rotateSpeed = 0.2,
            controls = {
                left = 34,
                right = 35,
                up = 32,
                down = 33
            }
        },
        options = {
            {
                title = locale('cam_deposit_1'),
                coords = vector4(-1305.0790, -816.2936, 15.1372, 266.4106)
            },
            {
                title = locale('cam_deposit_2'),
                coords = vector4(-1299.3949, -823.7425, 15.3611, 18.2077)
            },
            {
                title = locale('cam_sidevault_1'),
                coords = vector4(-1304.0852, -831.8907, 15.2046, 12.9721)
            },
            {
                title = locale('cam_sidevault_2'),
                coords = vector4(-1311.7469, -817.2324, 15.2785, 189.5077)
            },
            {
                title = locale('cam_prevault_1'),
                coords = vector4(-1310.1140, -830.9611, 14.1929, 12.8440)
            },
            {
                title = locale('cam_prevault_2'),
                coords = vector4(-1312.5603, -823.0410, 14.3020, 207.4496)
            },
            {
                title = locale('cam_vault_1'),
                coords = vector4(-1311.6313, -831.3225, 14.3237, 69.4187)
            },
            {
                title = locale('cam_vault_2'),
                coords = vector4(-1319.5225, -829.2480, 14.6493, 261.7414)
            },
            {
                title = locale('cam_lobby_1'),
                coords = vector4(-1314.3197, -826.1542, 20.0718, 276.0187)
            },
            {
                title = locale('cam_lobby_2'),
                coords = vector4(-1307.5133, -831.3788, 20.1469, 359.4450)
            },
            {
                title = locale('cam_lobby_3'),
                coords = vector4(-1299.0554, -825.3466, 19.8510, 37.0073)
            },
            {
                title = locale('cam_lobby_4'),
                coords = vector4(-1306.6877, -815.6227, 20.1358, 256.0231)
            },
            {
                title = locale('cam_top_1'),
                coords = vector4(-1315.8098, -832.1481, 25.0747, 321.2171)
            },
            {
                title = locale('cam_top_2'),
                coords = vector4(-1305.8054, -815.5667, 25.1052, 261.7289)
            },
            {
                title = locale('cam_top_3'),
                coords = vector4(-1298.7698, -825.0369, 25.0529, 2.0440)
            },
            {
                title = locale('cam_offices_1'),
                coords = vector4(-1300.4890, -827.3513, 19.4853, 261.3729)
            },
            {
                title = locale('cam_offices_2'),
                coords = vector4(-1289.6581, -841.5853, 19.3767, 17.6316)
            },
            {
                title = locale('cam_break_room'),
                coords = vector4(-1322.6204, -811.2996, 19.9035, 266.1359)
            },
            {
                title = locale('cam_garage'),
                coords = vector4(-1311.4835, -797.1412, 20.8492, 184.8769)
            }
        }
    },

    basement = {
        doors = {
            {
                model = `3dp_heist_mb_door_gate`,
                coords = vector3(-1302.9448, -820.6892, 12.1813),
            },
            {
                model = `3dp_heist_mb_door_gate`,
                coords = vector3(-1306.3124, -823.2307, 12.2070),
            },
            {
                model = `3dp_heist_mb_door_gate`,
                coords = vector3(-1310.8629, -820.6621, 12.1973),
                unlocks = 'sideVault1' -- Don't change, cheater protection
            },
            {
                model = `3dp_heist_mb_door_gate`,
                coords = vector3(-1305.1381, -828.4243, 12.1794),
                unlocks = 'sideVault2' -- Don't change, cheater protection
            },
            {
                model = `3dp_heist_mb_door_gate`,
                coords = vector3(-1309.6855, -825.7685, 12.2102),
            },
            {
                model = `ch_prop_ch_vault_d_door_01a`,
                coords = vector3(-1312.9121, -828.2128, 12.2882),
                unlocks = 'mainVault1',
                shouldScramble = true, -- Should scramble without the overloaded circuit
                triggersReward = true -- This triggers the XP rewards for the contract, should only be included once
            },
            {
                model = `3dp_heist_mb_door_gate`,
                coords = vector3(-1316.9974, -826.4031, 12.2231),
                unlocks = 'mainVault2',
                shouldScramble = true -- Should scramble without the overloaded circuit
            },
            {
                model = `3dp_heist_mb_door_gate`,
                coords = vector3(-1319.5332, -828.3121, 12.2227),
                unlocks = 'mainVault3',
                shouldScramble = true -- Should scramble without the overloaded circuit
            },
        },
        circuitOverload = {
            coords = vector4(-1304.7633, -825.8755, 12.3002, 307.5),
            requiredItem = 'hack_usb',
            removeAfterUse = false
        },
        props = {
            { coords = vector4(-1303.1086, -831.1240, 12.0516, 37.5), model = `h4_prop_h4_table_isl_01a` },
            { coords = vector4(-1312.8877, -817.9288, 12.0516, 217.5), model = `h4_prop_h4_table_isl_01a` },
        },
        ---@type LootData
        loot = {
            rewards = {
                ['cash'] = { account = 'money', count = { pile = 72000, trolley = 112500 } },
                ['gold'] = { item = 'gold_bar', count = { pile = 20, trolley = 45 } },
            },
            goldChance = 20,
            locations = {
                -- Prevault
                {
                    coords = vector4(-1301.3899, -827.4785, 12.1, 217.5),
                    type = 'pile',
                    
                },
                {
                    coords = vector4(-1300.4899, -826.7785, 12.1, 217.5),
                    type = 'pile',
                },

                -- Prevault 2
                {
                    coords = vector4(-1313.9698, -823.5629, 12.1, 37.5),
                    type = 'pile',
                    
                },
                {
                    coords = vector4(-1313.9698 + 0.9, -823.5629 + 0.7, 12.1, 37.5),
                    type = 'pile',
                },

                -- Prevault 3
                {
                    coords = vector4(-1308.6738, -830.5372, 12.1, 217.5),
                    type = 'pile',
                    
                },
                {
                    coords = vector4(-1308.6738 - 0.9, -830.5372 - 0.7, 12.1, 217.5),
                    type = 'pile',
                },

                -- Sidevault 1
                {
                    coords = vector4(-1313.2615, -818.3142, 11.9967, 37.5),
                    type = 'pile',
                    requires = 'sideVault1'
                },
                {
                    coords = vector4(-1312.4131, -817.7117, 11.9967, 37.5),
                    type = 'pile',
                    requires = 'sideVault1'
                },
                {
                    coords = vector4(-1313.0394, -820.3602, 12.0517, 127.5 + 180),
                    type = 'trolley',
                    requires = 'sideVault1'
                },
                {
                    coords = vector4(-1310.6160, -818.4807, 12.0517, 127.5),
                    type = 'trolley',
                    requires = 'sideVault1'
                },

                -- Sidevault 2
                {
                    coords = vector4(-1302.7822, -830.6837, 11.9967, 217.5),
                    type = 'pile',
                    requires = 'sideVault2'
                },
                {
                    coords = vector4(-1303.6038, -831.3204, 11.9967, 217.5),
                    type = 'pile',
                    requires = 'sideVault2'
                },
                {
                    coords = vector4(-1305.4136, -830.5985, 12.0516, 307.5),
                    type = 'trolley',
                    requires = 'sideVault2'
                },
                {
                    coords = vector4(-1302.9343, -828.6907, 12.0516, 127.5),
                    type = 'trolley',
                    requires = 'sideVault2'
                },

                -- Main vault
                {
                    coords = vector4(-1312.1935, -830.8665, 11.9994, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'cash',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1316.0842, -833.7097, 11.9994, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'cash',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1314.5886, -830.2810, 12.0516, 217.5),
                    type = 'trolley',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1315.4613, -830.9506, 12.0516, 217.5),
                    type = 'trolley',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1316.3340, -831.6203, 12.0516, 217.5),
                    type = 'trolley',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1314.9539, -829.8050, 12.0516, 37.5),
                    type = 'trolley',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1315.8265, -830.4746, 12.0516, 37.5),
                    type = 'trolley',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1316.6992, -831.1443, 12.0516, 37.5),
                    type = 'trolley',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1318.5496, -831.0931, 12.0516, 307.5),
                    type = 'trolley',
                    requires = 'mainVault1'
                },
                {
                    coords = vector4(-1317.8036, -827.5658, 11.9994, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'cash',
                    requires = 'mainVault1',
                },


                -- Mainvault subvault 1
                {
                    coords = vector4(-1318.8784, -826.8162, 11.9994, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'gold',
                    requires = 'mainVault2'
                },
                {
                    coords = vector4(-1319.5227, -825.9693, 11.9994, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'gold',
                    requires = 'mainVault2'
                },
                {
                    coords = vector4(-1321.3621, -827.3868, 12.0516, 307.5),
                    type = 'trolley',
                    requires = 'mainVault2'
                },
                
                -- Mainvault subvault 2
                {
                    coords = vector4(-1316.8834, -823.9268, 11.9994, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'gold',
                    requires = 'mainVault3'
                },
                {
                    coords = vector4(-1316.2268, -824.7755, 11.9994, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'gold',
                    requires = 'mainVault3'
                },
                {
                    coords = vector4(-1318.7197, -825.4058, 12.0516, 307.5),
                    type = 'trolley',
                    requires = 'mainVault3'
                },
            }
        }
    }
}