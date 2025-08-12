return {
    {
        enableTeleports = true, -- enable or disable teleporting to this warehouse
        drawtext = {
            -- entrance = 'Press [E] to Enter',
            -- exit = 'Press [E] to Exit',
        },
        target = {
            entrance = {
                icon = 'fas fa-door-open',
                label = 'Enter Warehouse',
                coords = vec3(746.75, -1399.2, 26.85),
                size = vec3(0.5, 1.5, 2.55),
                rotation = 90.0,
            },
            exit = {
                icon = 'fas fa-door-closed',
                label = 'Exit Warehouse',
                coords = vec3(992.0, -3097.8, -39.0),
                size = vec3(0.5, 1.5, 2.55),
                rotation = 0.0,
            },
        },
        bucket = 100,
        -- job = 'recycler', -- job required to access this warehouse
        entrance = vector4(746.8, -1399.63, 26.6, 186.97),
        exit = vector4(992.5, -3097.79, -39.0, 272.56),
        zone = {-- made this a zone because some were having difficulty creating the poly
            coords = vector3(1010.36, -3101.25, -39.0), -- center of the warehouse
            radius = 80.0, -- radius of the zone of the warehouse where the pallets are spawned
        },
        ped = {
            coords = vector4(997.84, -3095.67, -39.0, 274.24),
            model = `a_m_m_farmer_01`,
            enableStore = true, -- enable or disable the store for this warehouse
        },
        blip = {
            name = 'LS Recyclers',
            sprite = 365,
            color = 43,
            scale = 0.8,
            shortRange = true,
        },
        shop = {
            name = 'Ls Recyclers',
            items = {
                { name = 'recycler', amount = 40, price = 5000 },
            },
        },
        crateTimeOut = 5, -- minutes until a pallet can be looted again
        emptyCrateTime = 5000, -- time in ms to collect empty crate
        getMaterialsTime = 5000, -- time in ms to get materials from a pallet
        pallets = {
            models = {
                `sm_prop_smug_crate_m_antiques`,
                `ba_prop_battle_crate_m_bones`,
                `ex_prop_crate_pharma_sc`,
                `ex_prop_crate_art_02_sc`,
                `ex_prop_crate_shide`,
                `ex_prop_crate_furjacket_bc`,
                `ex_prop_crate_art_bc`,
            },
            coords = {
                vector4(1003.56, -3097.03, -39.0, 3.01),
                vector4(1003.61, -3102.79, -39.0, 180.71),
                vector4(1003.62, -3108.37, -39.0, 177.31),
                vector4(1003.72, -3091.56, -39.0, 183.88),
                vector4(1006.09, -3091.77, -39.0, 1.07),
                vector4(1006.06, -3096.92, -39.0, 178.59),
                vector4(1006.01, -3102.6, -39.0, 180.44),
                vector4(1006.03, -3108.44, -39.0, 182.12),
                vector4(1008.53, -3108.65, -39.0, 1.0),
                vector4(1008.51, -3102.92, -39.0, 0.49),
                vector4(1008.56, -3097.25, -39.0, 2.55),
                vector4(1008.48, -3091.63, -39.0, 1.67),
                vector4(1011.07, -3091.69, -39.0, 0.48),
                vector4(1010.74, -3096.8, -39.0, 173.98),
                vector4(1010.85, -3102.55, -39.0, 178.55),
                vector4(1010.79, -3108.33, -39.0, 182.06),
                vector4(1013.36, -3108.51, -39.0, 359.03),
                vector4(1013.35, -3102.91, -39.0, 357.75),
                vector4(1013.34, -3097.18, -39.0, 0.39),
                vector4(1013.34, -3091.71, -39.0, 0.53),
                vector4(1015.76, -3091.69, -39.0, 3.08),
                vector4(1015.63, -3096.85, -39.0, 181.92),
                vector4(1015.56, -3102.47, -39.0, 180.56),
                vector4(1015.64, -3108.13, -39.0, 180.12),
                vector4(1018.09, -3108.66, -39.0, 2.16),
                vector4(1018.1, -3102.91, -39.0, 0.22),
                vector4(1018.1, -3097.24, -39.0, 2.13),
                vector4(1018.11, -3091.83, -39.0, 359.44),
                vector4(1026.96, -3091.51, -39.0, 95.66),
                vector4(1026.32, -3094.15, -39.0, 91.5),
                vector4(1026.7, -3096.48, -39.0, 94.04),
                vector4(1026.79, -3106.6, -39.0, 268.35),
                vector4(1026.61, -3108.99, -39.0, 271.53),
                vector4(1026.7, -3111.43, -39.0, 94.21),
                vector4(993.57, -3111.36, -39.0, 90.63),
                vector4(993.52, -3108.87, -39.0, 87.98),
                vector4(993.39, -3106.48, -39.0, 89.85),
            }
        }
    },
}