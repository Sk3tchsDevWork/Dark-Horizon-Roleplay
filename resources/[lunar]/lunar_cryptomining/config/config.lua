Config = {}

-- Warehouse seller/buyer
Config.Ped = {
    ---@type BlipData | false
    Blip = {
        Name = 'Warehouse Estate',
        Sprite = 474,
        Size = 0.75,
        Color = 0
    },
    Model = `a_m_y_business_01`,
    Locations = {
        vector4(-998.9855, -419.6353, 39.6161, 302.5884),
    }
}

Config.WarehouseBlip = {
    Name = 'Warehouse',
    Sprite = 473,
    Size = 0.75,
    Color = 26
}

-- The max warehouses count per player, can be overriden in sv_edit.lua
-- Set to -1 for infinite warehouses
Config.MaxWarehouses = 1

Config.SellDivisor = 2 -- warehouse price / 2 = sell price
Config.SellIfPaidBill = true -- Allows you to sell the warehouse only if the bills are paid

---@class Warehouse
---@field Description string
---@field Interior string
---@field Coords vector3
---@field Teleport vector4
---@field Price integer
---@field Image string?

-- The warehouses
---@type table<string, Warehouse>
Config.Warehouses = {
    ['docks1'] = {
        Description = 'A renovated warehouse in the docks. Convenient for waterfront access.',
        Image = Utils.getImageUrl('1_low.png'),
        Interior = 'small',
        Price = 25000,
        Coords = vector3(-9.6305, -2536.6160, 7.6488),
        Teleport = vector4(-9.2744, -2536.1985, 7.3854, 328.9574)
    },
    ['docks2'] = {
        Description = 'A modern storage facility by the docks. Easily accessible for your shipping needs.',
        Image = Utils.getImageUrl('2_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(-68.9481, -2656.7463, 6.0543),
        Teleport = vector4(-68.9670, -2655.8430, 6.0007, 3.3712)
    },
    ['docks3'] = {
        Description = 'An industrial warehouse near the docks. Ideal for heavy-duty storage.',
        Image = Utils.getImageUrl('3_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(195.9873, -3275.9768, 5.9138),
        Teleport = vector4(195.5154, -3275.9758, 5.7903, 93.0142)
    },
    ['docks4'] = {
        Description = 'A renovated dockside storage unit with a view of the city skyline.',
        Image = Utils.getImageUrl('4_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(-292.9915, -2668.8513, 6.4767),
        Teleport = vector4(-293.5202, -2668.4133, 6.3901, 48.8426)
    },
    ['docks5'] = {
        Description = 'A modern warehouse near the docks.',
        Image = Utils.getImageUrl('5_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(-318.4821, -2717.9358, 7.5914),
        Teleport = vector4(-318.3604, -2718.1282, 7.5482, 226.9935)
    },
    ['docks6'] = {
        Description = 'A spacious industrial storage by the docks.',
        Image = Utils.getImageUrl('6_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(94.6536, -2676.8826, 6.4123),
        Teleport = vector4(94.6747, -2676.6553, 6.0046, 0.9081)
    },
    ['pillbox1'] = {
        Description = 'Secure storage in Pillbox Hill. State-of-the-art security.',
        Image = Utils.getImageUrl('7_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(314.8447, -684.4070, 30.0440),
        Teleport = vector4(315.5959, -684.7968, 29.8461, 252.2349)
    },
    ['pillbox2'] = {
        Description = 'A discreet lockup in Pillbox Hill. Store your belongings with elegance.',
        Image = Utils.getImageUrl('8_low.png'),
        Interior = 'small',
        Price = 25000,
        Coords = vector3(-36.6801, -571.3304, 39.1970),
        Teleport = vector4(-36.3979, -570.6140, 38.8333, 340.0968)
    },
    ['pillbox3'] = {
        Description = 'A hidden safehouse in Pillbox Hill. Keep your most prized possessions secure.',
        Image = Utils.getImageUrl('9_low.png'),
        Interior = 'small',
        Price = 75000,
        Coords = vector3(-50.0140, -1061.1144, 27.9578),
        Teleport = vector4(-50.6197, -1060.8933, 27.7362, 72.8456)
    },
    ['vinewood1'] = {
        Description = 'Luxury storage in Vinewood Hills. Ideal for valuable collections.',
        Image = Utils.getImageUrl('10_low.png'),
        Interior = 'small',
        Price = 75000,
        Coords = vector3(660.6481, 592.7740, 129.2846),
        Teleport = vector4(659.9901, 593.1107, 129.0509, 70.4004)
    },
    ['vinewood2'] = {
        Description = 'A discreet lockup in Vinewood Hills. Store your belongings with elegance.',
        Image = Utils.getImageUrl('11_low.png'),
        Interior = 'small',
        Price = 25000,
        Coords = vector3(-173.0047, 238.1734, 93.4140),
        Teleport = vector4(-172.9419, 238.8722, 93.1979, 353.9065)
    },
    ['vinewood3'] = {
        Description = 'A high-security vault in Vinewood Hills. Trustworthy storage for your assets.',
        Image = Utils.getImageUrl('12_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(-293.0295, 283.2109, 90.2637),
        Teleport = vector4(-292.9749, 282.8550, 89.8868, 179.0461)
    },
    ['sandy1'] = {
        Description = 'Storage units in Sandy Shores. A convenient storage solution in the desert.',
        Image = Utils.getImageUrl('13_low.png'),
        Interior = 'small',
        Price = 25000,
        Coords = vector3(1360.6179, 3604.4663, 34.2467),
        Teleport = vector4(1360.9022, 3603.7695, 34.9561, 199.5035)
    },
    ['sandy2'] = {
        Description = 'A spacious warehouse in the scenic Palomino Highlands.',
        Image = Utils.getImageUrl('14_low.png'),
        Interior = 'small',
        Price = 75000,
        Coords = vector3(905.8370, 3585.7905, 33.6643),
        Teleport = vector4(905.7722, 3586.4946, 33.4213, 1.6165)
    },
    ['sandy3'] = {
        Description = 'A spacious warehouse in the scenic Palomino Highlands.',
        Image = Utils.getImageUrl('15_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(614.6630, 2783.9917, 43.7102),
        Teleport = vector4(614.6791, 2784.3293, 43.4812, 6.6016)
    },
    ['sandy4'] = {
        Description = 'Sandy Shores Oasis Storage. Rural charm with all the modern amenities.',
        Image = Utils.getImageUrl('16_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(1738.0909, 3708.5554, 34.5244),
        Teleport = vector4(1737.8992, 3709.1162, 34.1352, 20.6834)
    },
    ['grapeseed1'] = {
        Description = 'Storage facilities in Grapeseed. Rural storage for agricultural and small-town needs.',
        Image = Utils.getImageUrl('17_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(1725.7404, 4765.6050, 41.1127),
        Teleport = vector4(1726.0939, 4765.5894, 41.9396, 270.5621)
    },
    ['grapeseed2'] = {
        Description = 'A spacious warehouse in grapeseed.',
        Image = Utils.getImageUrl('18_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(2564.9492, 4679.7607, 34.1769),
        Teleport = vector4(2564.5974, 4680.1650, 34.0768, 38.6774)
    },
    ['cypress1'] = {
        Description = 'Urban storage for industrial needs.',
        Image = Utils.getImageUrl('19_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(907.3032, -2220.7021, 30.9922),
        Teleport = vector4(907.9861, -2220.8523, 30.4935, 268.2057)
    },
    ['cypress2'] = {
        Description = 'A warehouse located in the cypress industrial zone.',
        Image = Utils.getImageUrl('20_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(964.5996, -1786.8324, 31.6852),
        Teleport = vector4(964.0058, -1786.7205, 31.2354, 83.5307)
    },
    ['cypress3'] = {
        Description = 'A storage facility next to a power plant.',
        Image = Utils.getImageUrl('21_low.png'),
        Interior = 'small',
        Price = 25000,
        Coords = vector3(768.9636, -1914.4482, 29.7626),
        Teleport = vector4(769.7406, -1914.4938, 29.3215, 266.3897)
    },
    ['cypress4'] = {
        Description = 'City storage for your convenience.',
        Image = Utils.getImageUrl('22_low.png'),
        Interior = 'small',
        Price = 75000,
        Coords = vector3(1036.9023, -2173.0989, 31.8614),
        Teleport = vector4(1037.5104, -2173.2043, 31.5333, 267.3445)
    },
    ['banham1'] = {
        Description = 'Hidden storage in the scenic Banham Canyon.',
        Image = Utils.getImageUrl('23_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(-3178.5208, 1093.0161, 21.2620),
        Teleport = vector4(-3179.2261, 1093.2825, 20.8407, 69.0178)
    },
    ['paleto1'] = {
        Description = 'Ideal for businesses in the peaceful coastal town.',
        Image = Utils.getImageUrl('24_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(-54.9508, 6392.2983, 31.8196),
        Teleport = vector4(-55.3876, 6392.7354, 31.4903, 51.5538)
    },
    ['paleto2'] = {
        Description = 'Paleto Bay Coastal Vault. Your coastal fortress for business and leisure.',
        Image = Utils.getImageUrl('25_low.png'),
        Interior = 'small',
        Price = 75000,
        Coords = vector3(-65.6007, 6507.0117, 31.7679),
        Teleport = vector4(-65.6453, 6506.1870, 31.5357, 182.6550)
    },
    ['vespucci1'] = {
        Description = 'Beachfront storage for beach-loving businesses.',
        Image = Utils.getImageUrl('26_low.png'),
        Interior = 'small',
        Price = 25000,
        Coords = vector3(-1146.5635, -1561.6920, 4.5423),
        Teleport = vector4(-1147.0631, -1562.0033, 4.4009, 127.9717)
    },
    ['vespucci2'] = {
        Description = 'Vespucci Beach Resort Storage. Beachfront luxury for your goods and wares.',
        Image = Utils.getImageUrl('27_low.png'),
        Interior = 'small',
        Price = 75000,
        Coords = vector3(-1273.1317, -1372.1099, 4.5006),
        Teleport = vector4(-1273.1736, -1371.9326, 4.3028, 22.4723)
    },
    ['vespucci3'] = {
        Description = 'Vespucci Beach Hideout. Your secret beachfront storage for discreet operations.',
        Image = Utils.getImageUrl('28_low.png'),
        Interior = 'small',
        Price = 75000,
        Coords = vector3(-1310.2003, -1317.7783, 4.0660),
        Teleport = vector4(-1310.0454, -1317.7241, 4.8731, 291.6198)
    },
    ['pacific1'] = {
        Description = 'Upscale storage in the scenic Pacific Bluffs.',
        Image = Utils.getImageUrl('29_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(-1866.2856, -308.8619, 49.4120),
        Teleport = vector4(-1865.6648, -308.3747, 49.1460, 311.1843)
    },
    ['pacific2'] = {
        Description = 'Pacific Bluffs Exclusive Chamber. High-end storage for the elite clientele.',
        Image = Utils.getImageUrl('30_low.png'),
        Interior = 'small',
        Price = 25000,
        Coords = vector3(-1500.3789, -202.1060, 51.1064),
        Teleport = vector4(-1499.7939, -201.6182, 50.7786, 309.7232)
    },
    ['boilingbroke1'] = {
        Description = 'A spacious warehouse near the boilingbroke penitentiary.',
        Image = Utils.getImageUrl('31_low.png'),
        Interior = 'big',
        Price = 75000,
        Coords = vector3(1878.9580, 2728.6780, 46.0303),
        Teleport = vector4(1879.4413, 2728.8672, 45.8341, 297.6756)
    },
    ['mirror1'] = {
        Description = 'Mirror Park Enigma Vault. Store your enigmatic belongings in style.',
        Image = Utils.getImageUrl('32_low.png'),
        Interior = 'small',
        Price = 25000,
        Coords = vector3(1224.6759, -495.7972, 66.6493),
        Teleport = vector4(1225.2299, -495.9311, 66.3938, 254.0200)
    },
}

---@class Interior
---@field Label string
---@field Coords vector3
---@field Teleport vector4
---@field Laptop vector3
---@field FuseBox { Spawn: boolean, Coords: vector3 | vector4 }
---@field LightOrigin vector3
---@field Locations vector4[]

---@type table<string, Interior>
Config.Interiors = {
    ['small'] = {
        Label = 'Small',
        Coords = vector3(1087.1264, -3099.3972, -38.8949),
        Teleport = vector4(1087.3448, -3099.4021, -39.0000, 271.3152),
        Laptop = vector3(1087.737427, -3101.296143, -39.175861),
        FuseBox = {
            Spawn = false,
            Coords = vector3(1087.387207, -3102.937500, -37.891453)
        },
        LightOrigin = vector3(1095.8873, -3105.3318, -37.6023),
        Locations = {
            vector4(1088.1830, -3097.2598, -39.0000, 0.0),
            vector4(1089.2830, -3097.2598, -39.0000, 0.0),
            vector4(1090.7530, -3097.2598, -39.0000, 0.0),
            vector4(1091.8530, -3097.2598, -39.0000, 0.0),
            vector4(1094.5030, -3097.2598, -39.0000, 0.0),
            vector4(1095.6030, -3097.2598, -39.0000, 0.0),
            vector4(1097.0500, -3097.2598, -39.0000, 0.0),
            vector4(1098.1500, -3097.2598, -39.0000, 0.0),
            vector4(1100.7500, -3097.2598, -39.0000, 0.0),
            vector4(1101.8500, -3097.2598, -39.0000, 0.0),
            vector4(1103.3000, -3097.2598, -39.0000, 0.0),
            vector4(1104.4000, -3097.2598, -39.0000, 0.0),
        }
    },
    ['big'] = {
        Label = 'Big',
        Coords = vector3(1047.7938, -3097.0796, -38.9248),
        Teleport = vector4(1048.0212, -3097.0806, -39.0000, 270.6254),
        Laptop = vector3(1048.316895, -3100.665039, -39.135666),
        LightOrigin = vector3(1060.2432, -3102.6221, -33.4297),
        FuseBox = {
            Spawn = true,
            Coords = vector4(1047.7684, -3102.9077, -38.2907, 90.0)
        },
        Locations = {
            -- First row
            vector4(1052.5600, -3096.0, -39.0000, 0.0),
            vector4(1053.6634, -3096.0, -39.0000, 0.0),
            vector4(1054.9634, -3096.0, -39.0000, 0.0),
            vector4(1056.0634, -3096.0, -39.0000, 0.0),
            vector4(1057.3634, -3096.0, -39.0000, 0.0),
            vector4(1058.4634, -3096.0, -39.0000, 0.0),
            vector4(1059.7934, -3096.0, -39.0000, 0.0),
            vector4(1060.8634, -3096.0, -39.0000, 0.0),
            vector4(1062.1934, -3096.0, -39.0000, 0.0),
            vector4(1063.2934, -3096.0, -39.0000, 0.0),
            vector4(1064.60, -3096.0, -39.0000, 0.0),
            vector4(1065.70, -3096.0, -39.0000, 0.0),
            vector4(1067.02, -3096.0, -39.0000, 0.0),
            vector4(1068.12, -3096.0, -39.0000, 0.0),
            
            -- -- Second row
            vector4(1052.5634, -3102.0, -39.0000, 180.0),
            vector4(1053.6634, -3102.0, -39.0000, 180.0),
            vector4(1054.9634, -3102.0, -39.0000, 180.0),
            vector4(1056.0634, -3102.0, -39.0000, 180.0),
            vector4(1057.3634, -3102.0, -39.0000, 180.0),
            vector4(1058.4634, -3102.0, -39.0000, 180.0),
            vector4(1059.7934, -3102.0, -39.0000, 180.0),
            vector4(1060.8634, -3102.0, -39.0000, 180.0),
            vector4(1062.1934, -3102.0, -39.0000, 180.0),
            vector4(1063.2934, -3102.0, -39.0000, 180.0),
            vector4(1064.60, -3102.0, -39.0000, 180.0),
            vector4(1065.70, -3102.0, -39.0000, 180.0),
            vector4(1067.02, -3102.0, -39.0000, 180.0),
            vector4(1068.12, -3102.0, -39.0000, 180.0),

            -- Third row
            vector4(1052.5634, -3103.30, -39.0000, 0.0),
            vector4(1053.6634, -3103.30, -39.0000, 0.0),
            vector4(1054.9634, -3103.30, -39.0000, 0.0),
            vector4(1056.0634, -3103.30, -39.0000, 0.0),
            vector4(1057.3634, -3103.30, -39.0000, 0.0),
            vector4(1058.4634, -3103.30, -39.0000, 0.0),
            vector4(1059.7934, -3103.30, -39.0000, 0.0),
            vector4(1060.8634, -3103.30, -39.0000, 0.0),
            vector4(1062.1934, -3103.30, -39.0000, 0.0),
            vector4(1063.2934, -3103.30, -39.0000, 0.0),
            vector4(1064.60, -3103.30, -39.0000, 0.0),
            vector4(1065.70, -3103.30, -39.0000, 0.0),
            vector4(1067.02, -3103.30, -39.0000, 0.0),
            vector4(1068.12, -3103.30, -39.0000, 0.0),

            -- Third row
            vector4(1052.5634, -3109.30, -39.0000, 180.0),
            vector4(1053.6634, -3109.30, -39.0000, 180.0),
            vector4(1054.9634, -3109.30, -39.0000, 180.0),
            vector4(1056.0634, -3109.30, -39.0000, 180.0),
            vector4(1057.3634, -3109.30, -39.0000, 180.0),
            vector4(1058.4634, -3109.30, -39.0000, 180.0),
            vector4(1059.7934, -3109.30, -39.0000, 180.0),
            vector4(1060.8634, -3109.30, -39.0000, 180.0),
            vector4(1062.1934, -3109.30, -39.0000, 180.0),
            vector4(1063.2934, -3109.30, -39.0000, 180.0),
            vector4(1064.60, -3109.30, -39.0000, 180.0),
            vector4(1065.70, -3109.30, -39.0000, 180.0),
            vector4(1067.02, -3109.30, -39.0000, 180.0),
            vector4(1068.12, -3109.30, -39.0000, 180.0),
        }
    }
}

Config.Crypto = {
    Icon = { 'fab', 'bitcoin' }, -- Font awesome icon
    Price = {
        -- The price will always fluctuate between these points
        Min = 20000,
        Max = 60000,

        -- The prices will get changed every hour by this random value
        MinChange = 1000,
        MaxChange = 5000,

        -- Set this to true and implement GetCryptoPrice, GetLastCryptoPrice in sv_edit.lua
        -- Recommended only for advanced users
        OverridePriceCalculation = false
    },

    -- This option allows you to withdraw the currency to your phone for example.
    -- You need to add your export in sv_edit.lua otherwise this won't work!
    WithdrawOption = false
}

Config.MiningRig = {
    Model = `xm_base_cia_server_01`,
    PropOffset = vector4(0.0, 0.0, -1.0, 0.0),
    Account = 'bank', -- Buy/sell/upgrade account
    BuyPrice = 10000,
    SellPrice = 5000,
    Consumption = 100, -- The base energy consumption per hour, shown as watt-hours 
    MaxGraphicsCards = 8, -- The maximum count of GPUs a mining rig can hold
    UpgradePrices = {
        CPU = 2000,
        Cooler = 1000,
    },
    RepairDuration = 30000,
    MaintenanceDuration = 30000,
    InstallDuration = 5000, -- Install GPU animation duration
    RemoveDuration = 5000, -- Remove GPU animation duration

    -- ADVANCED SETTINGS
    -- Random disasters can occurr every hour based on disaster chance
    Disaster = {
        Start = 0.001, -- Starting distaster chance
        Add = 0.0005,  -- Disaster chance added per hour
        Maintenance = 0.05 -- This value gets removed from disaster chance when maintanence is done
    },
    Multipliers = {
        CPU = 1.20, -- 20% more crypto mined when CPU is upgraded
        Cooler = 0.75 -- 25% less disaster chance added each hour when cooler is upgraded
    }
}

---@class GraphicsCard
---@field Consumption integer Energy consumption per hour, shown as watt-hours 
---@field Revenue number Cryptocurrency revenue

---@type table<string, GraphicsCard>
Config.GraphicsCards = {
    ['card_2070'] = {
        Consumption = 175,
        Revenue = 0.00010
    },
    ['card_2080'] = {
        Consumption = 220,
        Revenue = 0.00025
    },
    ['card_3080'] = {
        Consumption = 320,
        Revenue = 0.00050
    },
    ['card_3090'] = {
        Consumption = 340,
        Revenue = 0.00075
    },
    ['card_4080'] = {
        Consumption = 360,
        Revenue = 0.00100
    },
    ['card_4090'] = {
        Consumption = 450,
        Revenue = 0.00200
    },
}

Config.Electricity = {
    Price = 0.20, -- Price per kWh
    Invoice = {
        -- Cron expression that runs every sunday at 23:59
        -- Player will receive the electricity bill
        Cron = '59 23 * * SUN'
    }
}

-- The techshop
Config.TechShop = {
    ---@type BlipData | false
    Blip = {
        Name = 'Los Santos Electronics',
        Sprite = 521,
        Size = 0.75,
        Color = 5
    },
    PedModel = `hc_hacker`,
    -- When you buy from the ped
    BuyItems = {
        { name = 'card_2070', price = 500, account = 'money', image = GetInventoryIcon('card_2070') },
        { name = 'card_2080', price = 600, account = 'money', image = GetInventoryIcon('card_2080') },
        { name = 'card_3080', price = 750, account = 'money', image = GetInventoryIcon('card_3080') },
        { name = 'card_3090', price = 900, account = 'money', image = GetInventoryIcon('card_3090') },
        { name = 'card_4080', price = 1200, account = 'money', image = GetInventoryIcon('card_4080') },
        { name = 'card_4090', price = 1350, account = 'money', image = GetInventoryIcon('card_4090') },
    },
    -- When you sell to the ped
    SellItems = {
        { name = 'card_2070', price = 250, account = 'money', image = GetInventoryIcon('card_2070') },
        { name = 'card_2080', price = 250, account = 'money', image = GetInventoryIcon('card_2080') },
        { name = 'card_3080', price = 375, account = 'money', image = GetInventoryIcon('card_3080') },
        { name = 'card_3090', price = 450, account = 'money', image = GetInventoryIcon('card_3090') },
        { name = 'card_4080', price = 600, account = 'money', image = GetInventoryIcon('card_4080') },
        { name = 'card_4090', price = 675, account = 'money', image = GetInventoryIcon('card_4090') },
    },
    Random = true, -- Whether to pick a random location or spawn the ped in all of the locations
    Locations = {
        vector4(-1009.5200, -732.2584, 21.5297, 38.4328)
    }
}

-- The techshop
Config.IllegalSeller = {
    ---@type BlipData | false
    Blip = false,
    PedModel = `s_m_y_waretech_01`,
    Items = {
        { name = 'lockpick', price = 500, account = 'black_money', image = GetInventoryIcon('lockpick') },
        { name = 'usb_drive', price = 2000, account = 'black_money', image = GetInventoryIcon('usb_drive') },
        { name = 'warehouse_locator', price = 2000, account = 'black_money', image = GetInventoryIcon('warehouse_locator') },
    },
    Random = true, -- Whether to pick a random location or spawn the ped in all of the locations
    Locations = {
        vector4(-214.3466, -1366.7797, 31.2582, 33.1571)
    }
}

Config.Robbery = {
    Enabled = true,
    MinPolice = 0,
    MaxCount = 2, -- Maximum concurrent robberies
    FindDuration = 10 * 60000, -- The duration the player has to find the warehouse
    Duration = 30 * 60000, -- The duration of the robbery, the warehouse will close after that
    Price = 10000, -- The price to start the robbery
    StealDuration = 5000, -- Steal graphics card animation duration
    GraphicsCardsLimit = false, -- Set to a number to limit how many 

    -- The required items to start the robbery
    LockpickItem = 'lockpick', -- Can be false
    HackingItem = 'usb_drive', -- Can be false
    LocatorItem = 'warehouse_locator', -- Cannot be false

    -- The minigames
    -- Can be further modified inside cl_edit.lua
    ---@type 'normal' | 'quasar'
    LockpickMinigame = 'normal',
    ---@type 'howdy-hackminigame' | 'memorygame'
    HackingMinigame = 'howdy-hackminigame',

    -- The start mission ped
    Ped = {
        Model = `a_m_m_og_boss_01`,
        Random = true, -- Whether to pick a random location or spawn the ped in all of the locations
        Locations = {
            vector4(137.5301, -1695.7959, 29.2917, 320.0050)
        }  
    },

    Dispatch = {
		Code = '10-68',
		Title = 'Warehouse Robbery',
		Message = 'Ongoing warehouse robbery.'
	}
}