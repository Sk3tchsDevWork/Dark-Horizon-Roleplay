Config.contracts.cashexchange = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 10,
        price = 125,
        requiredExperience = 750,
        expiry = 24 * 60,
        timeToStart = 2 * 60,
        minMembers = 0,
        -- maxMembers = 6,
        rewards = { crypto = 65, experience = 500 }, -- Other rewards such as items are listed below
        minPolice = 0
    },

    duration = 120, -- minutes before reset
    alarmDuration = 30, -- seconds

    -- Blip shown to the players after the contract is started
    blip = {
        name = locale('cashexchange'),
        sprite = 1,
        size = 0.75,
        color = 1
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_cashexchange_title'),
        message = locale('dispatch_cashexchange_message'),
    },

    startPanel = {
        requiredItem = 'hack_usb',
        removeAfterUse = false
    },

    electricBox = {
        requiredItem = 'hack_usb',
        removeAfterUse = false
    },

    unlockVault = {
        requiredItem = 'hack_card',
        removeAfterUse = false,
        delay = 2 -- The vault will unlock in 2 minutes
    },

    doorModels = {
        entry = `3dp_cash_exchange_door_04`,
        other = { `3dp_cash_exchange_door_02`, `3dp_cash_exchange_door_03` },
        vault = `3dp_cash_exchange_door_02`
    },

    locations = {
        {
            image = './contracts/cashexchange.png',
            startPanel = {
                coords = vector4(137.510223, -1334.379028, 29.523590, 130.0),
                offset = vector3(-0.07, 0.05, 0.05)
            },
            alarm = vector3(126.8754, -1348.2876, 32.9710),
            electricBox = vector4(140.079926, -1340.050171, 29.612497, 225.0),
            cancelPoint = vector3(129.1895, -1346.6144, 29.7104),
            doors = {
                entry = vector3(139.417007, -1337.746704, 29.375525),
                other = {
                    vector3(127.804893, -1341.789795, 29.889545),
                    vector3(125.3327, -1342.0090, 29.9427),
                },
                vault = {
                    vector3(134.296585, -1345.308472, 29.874092),
                    vector3(131.122971, -1338.364136, 29.900270)
                }
            },
            props = {
                { coords = vector4(135.6486, -1341.1106, 29.7104, 45.0), model = `3dp_cash_exchange_prop_counter_desk` },
            },
            removeProps = {
                { coords = vector3(134.961700, -1341.251099, 29.314329), model = `v_corp_cashtrolley_2` }
            },
            -- There's also a second location below, don't forget to change the loot there
            ---@type LootData
            loot = {
                rewards = {
                    ['cash'] = { account = 'money', count = { pile = 72000, trolley = 112500 } },
                },
                goldChance = 0,
                locations = {
                    {
                        coords = vector4(135.3649, -1341.2826, 29.5131, 225.0),
                        type = 'pile',
                    },
                    {
                        coords = vector4(132.5434, -1338.0310, 29.7104, 195.5501),
                        type = 'trolley',
                    },
                    {
                        coords = vector4(131.1757, -1340.2222, 29.7104, 315.0),
                        type = 'trolley',
                    },
                    {
                        coords = vector4(134.5490, -1339.4637, 29.7104, 135.0),
                        type = 'trolley',
                    },
                }
            }
        },
        {
            image = './contracts/cashexchange2.png',
            startPanel = {
                coords = vector4(438.2003, -1904.4421, 26.2110, 40.0),
                offset = vector3(-0.26, 0.05, 0.05)
            },
            alarm = vector3(424.3637, -1892.2588, 29.5422),
            electricBox = vector4(432.3601, -1907.0216, 26.3760, 135.0),
            cancelPoint = vector3(425.7914, -1896.1393, 26.4617),
            doors = {
                entry = vector3(434.635406, -1906.385010, 26.076830),
                other = {
                    vector3(430.616241, -1894.750610, 26.690035),
                    vector3(430.407990, -1892.269775, 26.692612),
                },
                vault = {
                    vector3(427.091339, -1901.249878, 26.693468),
                    vector3(434.053009, -1898.067749, 26.702656)
                }
            },
            props = {
                { coords = vector4(431.2534, -1902.5810, 26.4617, 316.5), model = `3dp_cash_exchange_prop_counter_desk` },
            },
            removeProps = {
                { coords = vector3(431.084564, -1901.948486, 26.098267), model = `v_corp_cashtrolley_2` }
            },
            ---@type LootData
            loot = {
                rewards = {
                    ['cash'] = { account = 'money', count = { pile = 72000, trolley = 112500 } },
                },
                goldChance = 0,
                locations = {
                    {
                        coords = vector4(431.059570, -1902.310913, 26.27, 136.5),
                        type = 'pile',
                    },
                    {
                        coords = vector4(433.0109, -1901.5419, 26.4617, 46.0592),
                        type = 'trolley',
                    },
                    {
                        coords = vector4(432.1766, -1898.1288, 26.4617, 226.0),
                        type = 'trolley',
                    },
                    {
                        coords = vector4(434.5969, -1899.4458, 26.4617, 103.9904),
                        type = 'trolley',
                    },
                }
            }
        }
    }
}