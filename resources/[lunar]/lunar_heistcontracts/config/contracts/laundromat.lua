Config.contracts.laundromat = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 10,
        price = 75,
        requiredExperience = 500,
        expiry = 24 * 60,
        timeToStart = 2 * 60,
        minMembers = 0,
        -- maxMembers = 8,
        rewards = { crypto = 35, experience = 350 },
        minPolice = 0
    },

    duration = 120, -- The laundromat will reset after this duration (minutes)
    image = './contracts/laundromat.png',

    -- Blip shown to the players after the contract is started
    blip = {
        coords = vector3(88.0681, -1554.4208, 31.0714),
        name = locale('laundromat'),
        sprite = 1,
        size = 0.75,
        color = 1
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_laundromat_title'),
        message = locale('dispatch_laundromat_message'),
    },

    alarm = {
        coords = vector3(92.7492, -1559.2794, 32.7012),
        duration = 60, -- seconds
    },

    cancelPoint = vector3(94.8542, -1558.8934, 29.6084),

    generator = {
        coords = vector4(106.3586, -1559.4104, 29.7971, 140.0),
        requiredItem = 'hack_usb',
        removeAfterUse = false
    },

    loot = {
        -- Supports metadata, you can also add multiple items and one of them will be added
        items = {
            { name = 'coins', count = { min = 300, max = 600 } }
        },
        locations = {
            vector3(91.2159, -1553.1627, 29.8478),
            vector3(91.7914, -1553.6831, 29.8497),
            vector3(92.4083, -1554.1494, 29.8435),
            vector3(92.9782, -1554.6483, 29.8423),
            vector3(93.5879, -1555.1685, 29.8458),
            vector3(94.1574, -1555.6823, 29.8484),
            vector3(91.8938, -1559.2838, 29.5362),
            vector3(91.3277, -1558.8201, 29.5362),
            vector3(90.1925, -1557.8553, 29.5362),
            vector3(89.0590, -1556.9203, 29.5362),
            vector3(89.0517, -1559.2231, 29.5362),
            vector3(90.1774, -1560.1685, 29.5362),
            vector3(91.3143, -1561.1187, 29.5362),
            vector3(85.7052, -1559.3176, 29.7607),
            vector3(86.3859, -1559.8531, 29.7514),
            vector3(87.0337, -1560.4091, 29.7539),
            vector3(87.7010, -1560.8789, 29.9106),
            vector3(88.3051, -1561.3722, 29.9083),
            vector3(88.8755, -1561.8875, 29.9096),
            vector3(91.4163, -1564.6962, 29.5362),
            vector3(92.3499, -1563.5540, 29.5362),
            vector3(92.8321, -1562.9945, 29.5362),
            vector3(93.2884, -1562.4163, 29.5362),
        }
    },

    office = {
        -- You override the door here
        electricBox = {
            coords = vector4(96.571884, -1565.003540, 30.121641, 162.1242),
            requiredItem = 'hack_usb',
            removeAfterUse = false
        },
        door = {
            model = `3dp_laundromat_prop_door_03`,
            coords = vector3(98.643463, -1557.973267, 29.782478)
        },
        safe = {
            model = `ch_prop_ch_arcade_safe_door`,
            coords = vector3(95.958672, -1555.217773, 30.017233),
            ---@type { item: string?, account: string?, count: integer | { min: integer, max: integer }, chance: integer?, metadata: any? }[]
            rewards = {
                { account = 'money', count = { min = 60000, max = 80000 } },
                { item = 'classified_docs', count = { min = 3, max = 5 } },
                { item = 'rare_coins', count = 1, chance = 75 },
                { item = 'diamonds_box', count = 1, chance = 25 },
                { item = 'diamond_necklace', count = 1, chance = 25 },
                { item = 'diamond_ring', count = 1, chance = 25 },
                { item = 'luxurious_watch', count = { min = 1, max = 2 }, chance = 50 },
                { item = 'WEAPON_PISTOL', count = 1, chance = 25 }
            }
        }
    }
}