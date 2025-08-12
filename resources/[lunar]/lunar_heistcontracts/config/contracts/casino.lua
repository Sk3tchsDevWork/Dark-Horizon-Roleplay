Config.contracts.casino = {
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
    image = './contracts/casino.png',

    entranceBlips = {
        {
            coords = vector3(973.1959, 57.8963, 120.2532),
            name = locale('casino_rooftop_entrance'),
        },
        {
            coords = vector3(979.3234, 18.4466, 80.9902),
            name = locale('casino_side_entrance_1'),
        },
        {
            coords = vector3(993.4542, 77.5670, 80.9905),
            name = locale('casino_side_entrance_2'),
        },
        {
            coords = vector3(937.1067, 13.9300, 112.5535),
            name = locale('casino_terrace_entrance_1'),
        },
        {
            coords = vector3(952.9802, 78.5378, 111.2474),
            name = locale('casino_terrace_entrance_2'),
        },
        {
            coords = vector3(950.5275, 6.0904, 111.2834),
            name = locale('casino_terrace_entrance_3'),
        },
        {
            coords = vector3(990.5258, 68.5245, 111.2836),
            name = locale('casino_terrace_entrance_4'),
        },
        {
            coords = vector3(991.9739, -142.2731, 34.7860),
            name = locale('casino_sewer_entrance'),
        },
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_casino_title'),
        message = locale('dispatch_casino_message'),
        coords = vector3(957.4914, 29.1195, 121.1710)
    },

    -- inside the casino basement, outside doesn't make much sense as it would get easily abused
    cancelPoint = vector3(2484.5996, -277.4220, -70.6954),

    alarm = {
        coords = vector3(2533.1204, -268.1025, -55.5136),

        -- This alarm is specific for casino
        -- false = doesn't stop playing
        -- number = stops playing after the number of seconds
        duration = false,
    },

    props = {
        { model = `ch_prop_ch_service_trolley_01a`, coords = vector4(2507.2056, -269.5704, -59.7230, 271.7892) },
        { model = `ch_prop_ch_service_trolley_01a`, coords = vector4(2468.2217, -271.8421, -71.71, 358.6643) },
        { model = `v_corp_banktrolley`,             coords = vector4(2534.8496, -243.4040, -71.7372, 258.7611) },
        { model = `ch_prop_ch_sec_cabinet_05a`,     coords = vec4(2512.031, -256.831, -71.737, 153.750) },
        { model = `ch_prop_ch_sec_cabinet_05a`,     coords = vec4(2504.092, -249.872, -71.737, 123.750) },
        { model = `ch_prop_ch_sec_cabinet_05a`,     coords = vec4(2525.030, -258.540, -71.737, 191.250) },
        { model = `ch_prop_ch_sec_cabinet_05a`,     coords = vec4(2519.709, -218.188, -71.737, 3.750) },
        { model = `ch_prop_ch_sec_cabinet_05a`,     coords = vec4(2504.088, -227.211, -71.737, 56.250) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2507.603, -253.874, -71.737, 138.750) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2517.072, -258.542, -71.737, 168.750) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2505.711, -225.094, -71.737, 48.750) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2525.022, -218.535, -71.737, 348.750) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2532.375, -221.579, -71.737, 326.250) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2541.049, -234.556, -71.737, 281.250) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2538.007, -249.865, -71.737, 236.250) },
        { model = `ch_prop_ch_sec_cabinet_03a`,     coords = vec4(2519.717, -258.889, -71.737, 176.250) },
        { model = `ch_prop_ch_sec_cabinet_03a`,     coords = vec4(2541.051, -242.513, -71.737, 258.750) },
        { model = `ch_prop_ch_sec_cabinet_03a`,     coords = vec4(2512.023, -220.249, -71.737, 26.250) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2502.754, -229.522, -71.737, 63.750) },
        { model = `ch_prop_ch_sec_cabinet_03a`,     coords = vec4(2530.064, -220.245, -71.737, 333.750) },
        { model = `ch_prop_ch_sec_cabinet_03a`,     coords = vec4(2539.337, -229.514, -71.737, 296.250) },
        { model = `ch_prop_ch_sec_cabinet_03a`,     coords = vec4(2504.092, -249.872, -71.737, 123.750) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2509.713, -221.583, -71.737, 33.750) },
        { model = `ch_prop_ch_sec_cabinet_03a`,     coords = vec4(2540.361, -245.090, -71.737, 251.250) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2534.497, -253.869, -71.737, 221.250) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2514.495, -257.852, -71.737, 161.250) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2519.709, -218.188, -71.737, 3.750) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2534.491, -223.202, -71.737, 318.750) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2541.398, -237.200, -71.737, 273.750) },
        { model = `ch_prop_ch_sec_cabinet_05a`,     coords = vec4(2522.385, -258.889, -71.737, 183.750) },
        { model = `ch_prop_ch_sec_cabinet_04a`,     coords = vec4(2507.603, -253.874, -71.737, 138.750) },
        { model = `ch_prop_ch_sec_cabinet_05a`,     coords = vec4(2514.488, -219.227, -71.737, 18.750) },
        { model = `ch_prop_ch_sec_cabinet_05a`,     coords = vec4(2527.599, -219.225, -71.737, 341.250) },
    },

    removeProps = {
        { model = `prop_ld_keypad_01`,              coords = vector3(977.6165, 62.7810, 120.2286) },
        { model = `prop_ld_keypad_01`,              coords = vector3(972.2786, 50.9929, 120.2791) },
        { model = `prop_cd_folder_pile4`,           coords = vector3(2466.865234, -269.478027, -69.691452) },
        { model = `v_corp_tallcabdark01`,           coords = vector3(2466.865967, -269.695801, -70.545929) },
        { model = `v_corp_offshelfdark`,            coords = vector3(2532.055908, -284.274414, -58.407673) },
        { model = `prop_paper_box_02`,              coords = vector3(2531.375244, -284.443878, -57.672466) },
        { model = `prop_large_gold_empty`,          coords = vector3(2536.162109, -243.798172, -70.368294) },
        { model = `ch_prop_ch_service_trolley_01a`, coords = vector3(2519.833252, -287.691345, -58.723152) },
        { model = `ch_prop_ch_sec_cabinet_01j`,     coords = vector3(2519.833252, -287.691345, -58.723152) },
        { model = `ch_prop_ch_sec_cabinet_01j`,     coords = vector3(2520.246338, -288.543121, -58.649033) },
        { model = `ch_prop_ch_sec_cabinet_01j`,     coords = vector3(2521.962158, -288.543121, -58.637508) },
        { model = `ch_prop_ch_sec_cabinet_01j`,     coords = vector3(2523.223633, -287.219208, -58.683968) },
    },

    entrances = {
        requiredItem = 'hack_usb',
        removeAfterUse = false,
        locations = {
            {
                from = {
                    coords = vector4(978.3015, 18.8852, 80.9902, 241.9976),
                    target = vector3(977.7967, 19.1556, 81.2325)
                },
                to = {
                    coords = vector4(2549.9888, -269.4210, -58.7230, 90.0),
                    target = vector3(2550.4224, -269.3992, -58.4139)
                },
                keypad = vector4(978.4053, 19.8484, 81.3511, 57.0),
                shouldSpawn = true
            },
            {
                from = {
                    coords = vector4(992.8070, 76.3565, 80.9905, 331.9098),
                    target = vector3(992.5976, 75.8910, 81.2281)
                },
                to = {
                    coords = vector4(2541.1084, -211.5852, -58.7230, 180.0),
                    target = vector3(2541.089355, -211.160553, -58.431759)
                },
                keypad = vector4(991.4595, 76.7986, 81.3511, 147.0),
                shouldSpawn = true
            },
            {
                from = {
                    coords = vector4(978.2512, 62.0291, 120.2405, 146.8044),
                    target = vector3(978.4153, 62.3576, 120.4663),
                },
                to = {
                    coords = vector4(2521.8213, -264.7481, -24.1149, 0.0),
                    target = vector3(2521.8855, -265.1274, -23.8605),
                },

                keypad = vector4(977.6297, 62.7727, 120.5932, 330.0),
                shouldSpawn = true,
                zoom = true
            },
            {
                from = {
                    coords = vector4(971.7102, 51.6331, 120.2407, 330.0),
                    target = vector3(971.5116, 51.3148, 120.4104),
                },
                to = {
                    coords = vector4(2521.8667, -243.7835, -24.1150, 180.0),
                    target = vector3(2521.902100, -243.352356, -23.930115)
                },
                keypad = vector4(972.2581, 50.9561, 120.6140, 147.5),
                shouldSpawn = true,
                zoom = true
            },
            {
                from = {
                    coords = vector4(953.0349, 78.5979, 111.2474, 331.7124),
                    target = vector3(952.8391, 78.3254, 111.4249),
                },
                to = {
                    coords = vector4(2488.5659, -293.6459, -39.1230, 2.7105),
                    target = vector3(2488.037354, -293.966156, -38.851017)
                },
                keypad = vector4(953.7557, 77.9002, 111.5982, 150.0),
                shouldSpawn = true
            },
            {
                from = {
                    coords = vector4(936.9186, 14.0771, 112.5536, 59.8503),
                    target = vector3(937.4119, 13.8209, 112.7621),
                },
                to = {
                    coords = vector4(2527.2935, -289.3932, -39.1229, 90.0),
                    target = vector3(2527.724609, -289.854095, -38.815243)
                },
                keypad = vector4(936.7946, 13.1468, 112.9019, 236.0),
                shouldSpawn = true
            },
            {
                from = {
                    coords = vector4(936.9186, 14.0771, 112.5536, 59.8503),
                    target = vector3(950.2002, 6.2403, 111.5327),
                },
                to = {
                    coords = vector4(2523.1780, -229.7014, -39.1229, 180.5062),
                    target = vector3(2523.630859, -229.162399, -38.806034)
                },
                keypad = vector4(950.6542, 7.0298, 111.5831, 60.0),
                shouldSpawn = true,
                zoom = true
            },
            {
                from = {
                    coords = vector4(989.8064, 69.0317, 111.2836, 237.4124),
                    target = vector3(989.5729, 69.2497, 111.5172),
                },
                to = {
                    coords = vector4(2500.0735, -233.6497, -39.1229, 270.0),
                    target = vector3(2499.536377, -233.250839, -38.771893)
                },
                keypad = vector4(990.0561, 70.0862, 111.5710, 60.0),
                shouldSpawn = true,
                zoom = true
            },
        }
    },

    sewerEntrance = {
        from = {
            coords = vector4(993.0165, -140.8940, 35.0782, 147.8365),
            target = vector3(993.1978, -140.6324, 35.1846),
        },
        to = {
            coords = vector4(2517.6050, -327.0941, -70.6537, 93.3589),
            target = vector3(2517.8589, -327.1236, -70.2167),
        },
        bomb = {
            requiredItem = 'bomb_c4',
            coords = vector3(2479.984619, -292.335144, -70.151955),
            cutsceneFinalLocations = {
                vector4(2484.1602, -288.0611, -70.7037, 269.6690),
                vector4(2484.0630, -288.9049, -70.7037, 267.9882),
                vector4(2484.0063, -289.7919, -70.7037, 272.0014),
                vector4(2483.1086, -289.4626, -70.7037, 266.5337),
                vector4(2483.1072, -288.2521, -70.7037, 267.5826),
                vector4(2483.2053, -287.3346, -70.7037, 236.6810),
                vector4(2481.6729, -287.3919, -70.7037, 252.0930),
                vector4(2481.7729, -288.6874, -70.7037, 271.8780),
                vector4(2481.9048, -290.1898, -70.7037, 287.8642),
                vector4(2479.9417, -289.4427, -70.4921, 277.1664),
                vector4(2479.7168, -287.4878, -70.7037, 279.4261),
                vector4(2478.7400, -287.6249, -70.7037, 265.2190),
                vector4(2478.7930, -288.4862, -70.7037, 270.1169),
                vector4(2478.3569, -290.0322, -70.7037, 278.0265),
                vector4(2479.9758, -290.2115, -70.4329, 312.9627),
                vector4(2481.3574, -290.5354, -70.4354, 316.8752),
            },
            -- This door gets unlocked when the bomb is planted
            door = {
                model = `v_ilev_rc_door2`,
                coords = vector3(2485.028564, -289.041718, -70.362839),
            }
        }
    },

    -- permanently locked doors
    lockedDoors = {
        {
            model = `ch_prop_ch_service_door_02c`,
            coords = vector3(2468.189209, -272.202698, -70.535156)
        },
        {
            model = `ch_prop_casino_door_01b`,
            coords = vector3(2527.631104, -266.508514, -58.490883)
        },
        {
            model = `ch_prop_ch_service_door_02a`,
            coords = vector3(2509.117676, -260.526031, -54.890182)
        },
        {
            model = `ch_chint07_casino_staff_door_03`,
            coords = vector3(2525.143555, -265.023468, -38.864517)
        },
    },

    keypadDoors = {
        requiredItem = 'hack_card',
        removeAfterUse = false,
        locations = {
            {
                model = `ch_prop_ch_service_door_02c`,
                coords = vector3(2527.194092, -273.054321, -58.523251),
                keypads = {
                    vector4(2528.0754, -272.9377, -58.30, 180.0),
                    vector4(2528.2590, -273.2387, -58.30, 0.0),
                }
            },
            {
                model = `ch_prop_ch_service_door_02c`,
                coords = vector3(2531.475830, -273.842285, -58.474716),
                keypads = {
                    vector4(2530.5444, -273.7302, -58.30, 180.0),
                    vector4(2530.4282, -274.0312, -58.30, 0.0),
                }
            },
            {
                model = `ch_prop_ch_service_door_02c`,
                coords = vector3(2536.189453, -282.948273, -58.484646),
                keypads = {
                    vector4(2536.3564, -283.9340, -58.30, 90.0),
                    vector4(2535.9070, -281.9005, -58.30, 270.0),
                }
            },
            {
                model = `ch_prop_ch_service_door_02c`,
                coords = vector3(2534.305420, -284.973602, -58.482506),
                keypads = {
                    vector4(2535.2273, -285.0886, -58.30, 0.0),
                    vector4(2535.3396, -284.7890, -58.30, 180.0),
                }
            },
            {
                model = `ch_prop_ch_service_door_02a`,
                coords = vector3(2506.522705, -283.370178, -58.436188),
                keypads = {
                    vector4(2506.2590, -284.2594, -58.30, 270.0),
                    vector4(2506.8586, -284.3983, -58.30, 90.0),
                }
            },
            {
                model = `ch_prop_ch_service_door_02c`,
                coords = vector3(2523.892578, -275.352325, -58.464485),
                keypads = {
                    vector4(2523.5923, -276.3499, -58.30, 270.0),
                    vector4(2524.1919, -274.4934, -58.30, 90.0),
                }
            },
            {
                parts = {
                    { model = `ch_prop_ch_service_door_02b`, coords = vector3(2506.6843, -275.7082, -58.53) },
                    { model = `ch_prop_ch_service_door_02b`, coords = vector3(2506.755371, -274.569550, -58.53) },
                },
                keypads = {
                    vector4(2506.5588, -273.8605, -58.30, 270.0),
                    vector4(2506.8845, -273.8975, -58.30, 90.0),
                }
            },
            {
                model = `ch_prop_ch_gendoor_01`,
                coords = vector3(2514.711670, -281.712250, -70.449806),
                keypads = {
                    vector4(2513.8066, -281.5233, -70.30, 180.0),
                    vector4(2515.8455, -282.0399, -70.30, 0.0),
                }

            },
            {
                model = `ch_prop_ch_gendoor_01`,
                coords = vector3(2514.684326, -281.687408, -58.396130),
                keypads = {
                    vector4(2513.3923, -282.0480, -58.30, 0.0),
                    vector4(2513.6587, -281.2738, -58.30, 90.0),
                }
            },
            {
                model = `ch_prop_ch_service_door_02c`,
                coords = vector3(2475.136230, -264.421692, -70.455551),
                keypads = {
                    vector4(2476.0747, -262.2434, -70.30, 0.0),
                    vector4(2474.9331, -263.3846, -70.30, 270.0),
                }

            },
            {
                parts = {
                    { model = `ch_chint07_casino_staff_door_05`, coords = vector3(2525.143555, -252.249573, -38.80) },
                    { model = `ch_chint07_casino_staff_door_04`, coords = vector3(2525.211182, -253.149200, -38.80) },
                },
                keypads = {
                    vector4(2525.3298, -254.0383, -38.70, 90.0),
                    vector4(2525.0701, -251.3610, -38.68, 270.0),
                }
            },
            {
                model = `ch_prop_ch_service_door_02d`,
                coords = vector3(2509.136475, -266.590302, -38.909840),
                keypads = {
                    vector4(2510.2432, -264.9664, -38.7, 270.0),
                    vector4(2508.2034, -266.7010, -38.7, 0.0),
                }
            }
        }
    },

    guards = {
        enabled = true,
        models = {
            normal = `s_m_y_westsec_02`,
            special = `s_m_y_casino_01`,
        },
        ignorePolice = true,
        accuracy = 30,       -- from 0 - 100
        combatAbility = 100, -- from 0 - 100, peds can start to run away if less than 50
        looting = {
            enabled = true,  -- Players can loot the guards
            progressDuration = 5000
        },
        ---@type GuardWeapon[]
        weapons = {
            { name = 'weapon_specialcarbine', ammo = { name = 'ammo-rifle', min = 60, max = 180 } },
            { name = 'weapon_smg',            ammo = { name = 'ammo-9', min = 60, max = 180 } },
            { name = 'weapon_combatpistol',   ammo = { name = 'ammo-9', min = 60, max = 180 } },
        },
        locations = {
            vector4(2543.7280, -274.8314, -58.7231, 178.9749),
            vector4(2532.4275, -286.8565, -58.7230, 267.6809),
            vector4(2523.1104, -290.9065, -58.7230, 87.3865),
            vector4(2504.3518, -289.8361, -58.7230, 359.8965),
            vector4(2533.7920, -275.9737, -58.7230, 264.3683),
            vector4(2515.0479, -283.1876, -58.7230, 270.9731),
            vector4(2540.2905, -257.9346, -58.7299, 319.2128),
            vector4(2531.4031, -269.3255, -58.7230, 267.5590),
            vector4(2520.5171, -269.6014, -58.7230, 294.6364),
            vector4(2534.4675, -283.9414, -58.7235, 268.6825),

            vector4(2514.3777, -231.1708, -39.1230, 181.9525),
            vector4(2507.7239, -292.1179, -39.1230, 3.7907),

            vector4(2510.6326, -280.2684, -62.6743, 280.3953),

            vector4(2524.8828, -278.1479, -70.7131, 79.5169),
            vector4(2525.2041, -282.2081, -70.6445, 95.8989),
            vector4(2508.7407, -283.1302, -70.7153, 80.3740),
            vector4(2498.1223, -276.2593, -70.6942, 87.1000),
            vector4(2489.6462, -283.4704, -70.6942, 134.6105),
            vector4(2487.3921, -262.7260, -70.6947, 193.1212),
            vector4(2490.6477, -255.7356, -70.6942, 174.1795),
            vector4(2515.2175, -272.7906, -70.6978, 185.8506),
        },
    },

    miniVault = {
        terminal = {
            coords = vector4(2531.6050, -284.7890, -58.3309, 180.0), -- Needs to be disabled before hacking computers
            requiredItem = 'hack_usb',
            removeAfterUse = false,
        },
        computers = {
            requiredItem = 'hack_usb',
            removeAfterUse = false,
            hackCount = 2, -- You need to hack 2 computers to open the mini vault
            locations = {
                vector3(2524.9082, -282.7180, -58.8911),
                vector3(2524.8135, -277.5471, -58.8911),
                vector3(2535.3008, -279.1396, -58.8911),
                vector3(2529.8213, -278.1286, -58.8911),
            }
        },
        door = {
            model = `ch_prop_ch_vault_d_door_01a`,
            coords = vector3(2522.064453, -285.502502, -58.400715)
        }
    },

    electricBox = {
        requiredItem = 'hack_usb',
        removeAfterUse = false,
        model = `h4_prop_h4_elecbox_01a`,
        coords = vector4(2466.4521, -270.1478, -70.6943, 270.0),
        unlockDoor = {
            { model = `ch_prop_ch_secure_door_r`, coords = vector3(2475.345947, -280.302002, -70.248322) },
            { model = `ch_prop_ch_secure_door_l`, coords = vector3(2475.345947, -278.217316, -70.251343) },
        }
    },

    tunnel = {
        terminals = {
            requiredItem = 'casino_keycard',
            timing = 3000, -- Time in ms
            model = `ch_prop_fingerprint_scanner_01a`,
            locations = {
                vector4(2464.7528, -276.4111, -70.3864, 68.0),
                vector4(2464.7854, -282.1548, -70.3737, 112.0),
            }
        },
        doors = {
            {
                {
                    model = `ch_prop_ch_tunnel_door_01_r`,
                    coords = vector3(2464.1887, -279.7574, -70.4378),
                },
                {
                    model = `ch_prop_ch_tunnel_door_01_l`,
                    coords = vector3(2464.1926, -278.7042, -70.4447),
                }
            },
            {
                {
                    model = `ch_prop_ch_tunnel_door_01_r`,
                    coords = vector3(2492.318359, -239.009781, -70.500824),
                },
                {
                    model = `ch_prop_ch_tunnel_door_01_l`,
                    coords = vector3(2492.318359, -237.938278, -70.489769),
                }
            }
        }
    },

    depositBoxes = {
        requiredItem = 'small_drill',
        rewards = {
            { account = 'money',         count = { min = 20000, max = 30000 } },
            { item = 'classified_docs',  count = { min = 1, max = 3 } },
            { item = 'rare_coins',       count = { min = 1, max = 3 } },
            { item = 'diamonds_box',     count = { min = 1, max = 2 } },
            { item = 'diamond_necklace', count = { min = 1, max = 2 } },
            { item = 'diamond_ring',     count = { min = 1, max = 3 } },
            { item = 'luxurious_watch',  count = { min = 1, max = 2 } },
            { item = 'weapon_pistol',    count = 1 },
        },
        locations = {
            { coords = vec4(2538.002, -227.204, -71.737, 303.750), requires = 'leftCentralSideVault' },
            { coords = vec4(2536.383, -251.982, -71.737, 228.750), requires = 'rightCentralSideVault' },
            { coords = vec4(2522.377, -218.187, -71.737, 356.250), requires = 'leftSideVault1' },
            { coords = vec4(2540.358, -231.979, -71.737, 288.750), requires = 'mainCentralSideVault' },
            { coords = vec4(2532.381, -255.493, -71.737, 213.750), requires = 'rightCentralSideVault' },
            { coords = vec4(2527.606, -257.849, -71.737, 198.750), requires = 'rightSideVault1' },
            { coords = vec4(2509.720, -255.498, -71.737, 146.250), requires = 'rightSideVault2' },
            { coords = vec4(2536.378, -225.088, -71.737, 311.250), requires = 'leftCentralSideVault' },
            { coords = vec4(2541.398, -239.868, -71.737, 266.250), requires = 'mainCentralSideVault' },
            { coords = vec4(2517.064, -218.536, -71.737, 11.250),  requires = 'leftSideVault1' },
            { coords = vec4(2505.717, -251.988, -71.737, 131.250), requires = 'rightSideVault2' },
            { coords = vec4(2507.597, -223.207, -71.737, 41.250),  requires = 'leftSideVault2' },
            { coords = vec4(2502.758, -247.562, -71.737, 116.250), requires = 'rightSideVault2' },
            { coords = vec4(2519.170, -287.176, -59.715, 90.000),  requires = 'miniVault' },
            { coords = vec4(2523.213, -287.176, -59.715, 270.000), requires = 'miniVault' },
            { coords = vec4(2520.190, -288.532, -59.715, 180.000), requires = 'miniVault' },
            { coords = vec4(2522.192, -288.532, -59.715, 180.000), requires = 'miniVault' },
        }
    },

    vault = {
        doorCoords = vector4(2504.9698, -240.3241, -70.18, 0.0),
        explosives = {
            requiredItem = 'explosives',
            delay = 10, -- Explode 10 seconds after planting the explosive
            locations = {
                left = vector4(2505.1191, -237.6207, -70.4202, 0.0),
                right = vector4(2504.9761, -239.3484, -70.4125, 0.0),
            }
        },
        doors = {
            requiredItem = 'hack_card',
            removeAfterUse = false,
            locations = {
                {
                    model = `ch_prop_ch_vault_slide_door_lrg`,
                    coords = vector3(2521.060059, -226.048904, -70.422386),
                    keypad = vector4(2519.7834, -226.4721, -70.33, 2.0),
                    unlocks = 'leftSideVault1'
                },
                {
                    model = `ch_prop_ch_vault_slide_door_sm`,
                    coords = vector3(2514.493652, -222.791077, -70.457512),
                    keypad = vector4(2514.8621, -223.5174, -70.33, 108.0),
                    unlocks = 'leftSideVault2'
                },
                {
                    model = `ch_prop_ch_vault_slide_door_lrg`,
                    coords = vector3(2533.518066, -238.512604, -70.403870),
                    keypad = vector4(2533.1060, -237.2980, -70.33, 270.0),
                    unlocks = 'mainCentralSideVault'
                },
                {
                    model = `ch_prop_ch_vault_slide_door_sm`,
                    coords = vector3(2536.785400, -231.986984, -70.452751),
                    keypad = vector4(2536.0647, -232.3511, -70.33, 20.0),
                    unlocks = 'leftCentralSideVault'
                },
                {
                    model = `ch_prop_ch_vault_slide_door_sm`,
                    coords = vector3(2536.859131, -245.123108, -70.435387),
                    keypad = vector4(2536.0601, -244.7268, -70.33, 160.0),
                    unlocks = 'rightCentralSideVault'
                },
                {
                    model = `ch_prop_ch_vault_slide_door_lrg`,
                    coords = vector3(2521.073730, -251.007874, -70.419472),
                    keypad = vector4(2519.7227, -250.5970, -70.3240, 182.0),
                    unlocks = 'rightSideVault1'
                },
                {
                    model = `ch_prop_ch_vault_slide_door_sm`,
                    coords = vector3(2514.472656, -254.274567, -70.427170),
                    keypad = vector4(2514.8545, -253.5471, -70.3896, 70.0),
                    unlocks = 'rightSideVault2'
                },
            }
        },
        ---@type LootData
        loot = {
            rewards = {
                ['cash'] = { account = 'money', count = { pile = 72000, trolley = 112500 } },
                ['gold'] = { item = 'gold_bar', count = { pile = 20, trolley = 45 } },
                ['diamonds'] = { item = 'diamonds_box', count = { trolley = 45 } },
            },
            goldChance = 20,
            diamondsChance = 10,
            locations = {
                {
                    coords = vec4(2520.539795, -286.178375, -58.722988, 180.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'miniVault'
                },

                {
                    coords = vector4(2517.6711, -244.8685, -70.7371, -30.0),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2514.901123, -241.879547, -70.737129, -60.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2524.491943, -245.060379, -70.737129, 30.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2526.924658, -242.970432, -70.737129, 55.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2527.532959, -241.887146, -70.737129, 65.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2527.421387, -235.040649, -70.737129, 120.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2524.499756, -232.094620, -70.737129, 150.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2517.446289, -234.088394, -70.737129, -95.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2514.550293, -235.012207, -70.737129, -120.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },

                {
                    coords = vector4(2522.849854, -239.085632, -70.737129, -105.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2522.663086, -237.526028, -70.737129, -55.000000),
                    type = 'trolley',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },

                {
                    coords = vector4(2520.1193, -237.9612, -70.836, 230.000000),
                    type = 'pile',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(2520.3054, -239.2385, -70.836, 300.0),
                    type = 'pile',
                    forceLootType = 'cash',
                    requires = 'mainVault'
                },

                {
                    coords = vector4(2526.469238, -223.405472, -70.737206, 70.000000),
                    type = 'trolley',
                    requires = 'leftSideVault1'
                },
                {
                    coords = vector4(2527.799561, -220.646591, -70.737206, 70.000000),
                    type = 'trolley',
                    requires = 'leftSideVault1'
                },
                {
                    coords = vector4(2514.365479, -220.131607, -70.737129, -70.000000),
                    type = 'trolley',
                    requires = 'leftSideVault1'
                },

                {
                    coords = vector4(2512.184570, -220.743576, -70.737129, -155.000000),
                    type = 'trolley',
                    requires = 'leftSideVault2'
                },
                {
                    coords = vector4(2508.441650, -231.427551, -70.737160, 15.000000),
                    type = 'trolley',
                    requires = 'leftSideVault2'
                },
                {
                    coords = vector4(2503.566406, -230.250366, -70.737160, -25.000000),
                    type = 'trolley',
                    requires = 'leftSideVault2'
                },

                {
                    coords = vector4(2534.436279, -242.038498, -70.737129, -25.000000),
                    type = 'trolley',
                    requires = 'mainCentralSideVault'
                },
                {
                    coords = vector4(2540.441162, -234.651276, -70.737183, 100.000000),
                    type = 'trolley',
                    requires = 'mainCentralSideVault'
                },
                {
                    coords = vector4(2540.447998, -242.355026, -70.737129, 80.000000),
                    type = 'trolley',
                    requires = 'mainCentralSideVault'
                },

                {
                    coords = vector4(2527.182861, -251.420578, -70.737129, -110.000000),
                    type = 'trolley',
                    requires = 'rightCentralSideVault'
                },
                {
                    coords = vector4(2537.598145, -249.538300, -70.737129, 55.000000),
                    type = 'trolley',
                    requires = 'rightCentralSideVault'
                },
                {
                    coords = vector4(2531.693848, -251.232086, -70.737129, -35.000000),
                    type = 'trolley',
                    requires = 'rightCentralSideVault'
                },

                {
                    coords = vector4(2532.428467, -230.592422, -70.737206, -50.000000),
                    type = 'trolley',
                    requires = 'leftCentralSideVault'
                },
                {
                    coords = vector4(2530.787842, -228.033798, -70.737206, -45.000000),
                    type = 'trolley',
                    requires = 'leftCentralSideVault'
                },
                {
                    coords = vector4(2527.894775, -224.212997, -70.737206, -110.000000),
                    type = 'trolley',
                    requires = 'leftCentralSideVault'
                },
                {
                    coords = vector4(2529.406982, -221.030548, -70.737206, -155.000000),
                    type = 'trolley',
                    requires = 'leftCentralSideVault'
                },


                {
                    coords = vector4(2526.445557, -253.486511, -70.737129, 115.000000),
                    type = 'trolley',
                    requires = 'rightSideVault1'
                },
                {
                    coords = vector4(2527.554932, -255.465225, -70.737206, 115.000000),
                    type = 'trolley',
                    requires = 'rightSideVault1'
                },
                {
                    coords = vector4(2516.349121, -252.425903, -70.737129, -185.000000),
                    type = 'trolley',
                    requires = 'rightSideVault1'
                },
                {
                    coords = vector4(2519.745850, -258.422943, -70.737206, -5.000000),
                    type = 'trolley',
                    requires = 'rightSideVault1'
                },

                {
                    coords = vector4(2507.942383, -244.886032, -70.737129, -155.000000),
                    type = 'trolley',
                    requires = 'rightSideVault2'
                },
                {
                    coords = vector4(2504.833008, -246.152206, -70.737129, -155.000000),
                    type = 'trolley',
                    requires = 'rightSideVault2'
                },
                {
                    coords = vector4(2513.407471, -250.091370, -70.737129, 135.000000),
                    type = 'trolley',
                    requires = 'rightSideVault2'
                },
                {
                    coords = vector4(2510.855225, -248.398392, -70.737129, 130.000000),
                    type = 'trolley',
                    requires = 'rightSideVault2'
                },
            }
        }
    },
}
