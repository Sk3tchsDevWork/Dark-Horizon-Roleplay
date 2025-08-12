-- IMPORTANT don't change type (ingredients/products) in lab shells, otherwise it will break everything

Config = Config or {}
Config.TestShell = { -- default coords for test shell
    ['zIndex'] = 20, ['door'] = {x = 1.0, y = 1.0, z = 1.0, heading = 90.0, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'}, 
}
Config.Interiors = {
    ['k4mb1_acid2_shell'] = {
        ['zIndex'] = 25, -- how down should spawn
        ['door'] = {x = -2.6, y = 1.15, z = 1.61, heading = -184.63, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = { -- interactions points, stashes, crafting, whatever u wanna trigger
            {x = -4.27, y = -1.03, z = 2.01, dist = 1.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "ingredients"},
            {x = 3.01, y = -1.37, z = 2.01, dist = 1.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "products"},
        },
        ['peds'] = { -- interior will spawn X peds depending on production level
            {
                x = -0.78, y = -0.96, z = 0.61, heading = -183.60, 
                model = 's_m_m_scientist_01', 
                dict = 'anim@amb@board_room@diagram_blueprints@', animation = 'idle_01_amy_skater_01'
            },
            {
                x = 3.73, y = 1.28, z = 1.0, heading = -285.60, 
                model = 's_m_m_scientist_01', 
                dict = 'mp_fbi_heist', animation = 'loop'
            },
            {
                x = 2.5, y = 1.52, z = 1.0, heading = -4.15,
                model = 's_m_m_scientist_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v6_cokepacker'
            },
        }
    },
    ['k4weed_shell'] = {
        ['zIndex'] = 30,
        ['door'] = {x = -10.6, y = -2.45, z = 3.95, heading = -90.63, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = -0.08, y = 3.37, z = 1.37, dist = 1.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "ingredients"},
            {x = 9.11, y = 2.16, z = 1.37, dist = 2.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "products"},
        },
        ['peds'] = {
            {
                x = 2.04, y = 3.2, z = 0.37, heading = -1.77, 
                model = 'mp_f_weed_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v6_cokepacker'
            },
            {
                x = -6.28, y = -2.99, z = 0.37, heading = -181.64, 
                model = 'mp_m_weed_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v6_cokepacker'
            },
            {
                x = 2.17, y = -1.6, z = 0.37, heading = -210.28,
                model = 'mp_m_weed_01', 
                dict = 'amb@prop_human_movie_bulb@idle_a', animation = 'idle_b'
            },
            {
                x = -1.8, y = -0.26, z = 0.37, heading = -39.68,
                model = 'mp_f_weed_01', 
                dict = 'amb@prop_human_movie_bulb@idle_a', animation = 'idle_b'
            },
        }
    },
    ['k4meth_shell'] = {
        ['zIndex'] = 30,
        ['door'] = {x = -10.6, y = -2.45, z = 3.95, heading = -90.63, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = -0.08, y = 3.37, z = 1.37, dist = 1.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "ingredients"},
            {x = 9.11, y = 2.16, z = 1.37, dist = 2.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "products"},
        },
        ['peds'] = {
            {
                x = 2.04, y = 3.2, z = 0.23, heading = -1.77, 
                model = 'mp_f_meth_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v6_cokepacker'
            },
            {
                x = 4.89, y = -3.36, z = 0.25, heading = -189.0, 
                model = 's_m_m_scientist_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v6_cokepacker'
            },
            {
                x = -2.0, y = -2.25, z = 0.72, heading = -180.48,
                model = 's_m_m_scientist_01', 
                dict = 'amb@prop_human_bum_shopping_cart@male@idle_a', animation = 'idle_c'
            },
            {
                x = 9.25, y = -2.82, z = 0.25, heading = -182.09,
                model = 's_m_m_scientist_01', 
                dict = 'random@train_tracks', animation = 'idle_e'
            },
        }
    },
    ['k4coke_shell'] = {
        ['zIndex'] = 30,
        ['door'] = {x = -10.6, y = -2.45, z = 3.95, heading = -90.63, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = -0.08, y = 3.37, z = 1.37, dist = 1.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "ingredients"},
            {x = 9.11, y = 2.16, z = 1.37, dist = 2.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "products"},
        },
        ['peds'] = {
            {
                x = 2.04, y = 3.2, z = 0.23, heading = -1.77, 
                model = 'mp_f_meth_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v6_cokepacker'
            },
            {
                x = 4.89, y = -3.36, z = 0.25, heading = -189.0, 
                model = 's_m_m_scientist_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v6_cokepacker'
            },
            {
                x = -5.73, y = -2.39, z = 0.25, heading = -185.83,
                model = 's_m_m_scientist_01', 
                dict = 'amb@prop_human_bum_shopping_cart@male@idle_a', animation = 'idle_c'
            },
            {
                x = 3.88, y = -0.4, z = 0.25, heading = -0.61,
                model = 's_m_m_scientist_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v7_cokepacker'
            },
        }
    },
    ['k4mb1_laundry_shell'] = {
        ['zIndex'] = 30,
        ['door'] = {x = 10.35, y = -5.48, z = 2.69, heading = -1.93, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = 10.07, y = 0.76, z = 1.95, dist = 2.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "ingredients"},
            {x = -2.0, y = 5.2, z = 1.96, dist = 1.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "products"},
        },
        ['peds'] = {
            {
                x = -5.63, y = -4.71, z = 0.45, heading = -181.63,
                model = 'g_m_m_chicold_01', 
                dict = 'anim@amb@business@cfm@cfm_cut_sheets@', animation = 'load_guillotine_billcutter'
            }, 
            {
                x = -1.53, y = -4.14, z = 1.20, heading = -183.59, 
                model = 'g_m_m_chicold_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v3_cokepacker'
            },
            {
                x = -3.75, y = 5.39, z = 0.5, heading = -0.54,
                model = 'g_m_m_chicold_01', 
                dict = 'anim@amb@business@cfm@cfm_drying_notes@', animation = 'loading_v1_worker'
            },
            {
                x = 10.03, y = 4.07, z = 0.45, heading = -273.57,
                model = 'g_m_m_chicold_01', 
                dict = 'anim@amb@business@coc@coc_unpack_cut@', animation = 'fullcut_cycle_v7_cokepacker'
            },
        }
    },
    ['container2_shell'] = {
        ['zIndex'] = 25,
        ['door'] = {x = 0.7, y = -5.60, z = 0.5, heading = -360.63, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = 0.31, y = 4.37, z = 1.62, dist = 1.5, label = Lang['open_stash'], event = 'av_gangs:stash', type = "stash"},
        },
        ['peds'] = false
    },
    ['stashhouse3_shell'] = {
        ['zIndex'] = 25,
        ['door'] = {x = -0.08, y = 5.29, z = 0.5, heading = -180.63, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = 1.25, y = -3.58, z = 1.83, dist = 1, label = Lang['open_stash'], event = 'av_gangs:stash', type = "stash"},
        },
        ['peds'] = false
    },
    ['stashhouse1_shell'] = {
        ['zIndex'] = 25,
        ['door'] = {x = 21.02, y = -0.62, z = 1.72, heading = -270.69, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = -19.16, y = 1.61, z = 1.72, dist = 1, label = Lang['open_stash'], event = 'av_gangs:stash', type = "stash"},
            {x = 0.21, y = 6.97, z = 1.72, dist = 1.5, label = Lang['open_crafting'], event = 'av_gangs:crafting'},
        },
        ['peds'] = false
    },
    ['k4mb1_furnishedoffice1_shell'] = {
        ['zIndex'] = 25,
        ['door'] = {x = 3.39, y = -2.02, z = 1.72, heading = -267.53, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = 2.54, y = 3.46, z = 1.72, dist = 1, label = Lang['open_stash'], event = 'av_gangs:stash', type = "stash"},
        },
        ['peds'] = false
    },
    ['k4mb1_furnishedoffice2_shell'] = {
        ['zIndex'] = 25,
        ['door'] = {x = 4.61, y = 3.44, z = 1.52, heading = -180.02, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = -4.63, y = 0.04, z = 1.52, dist = 1, label = Lang['open_stash'], event = 'av_gangs:stash', type = "stash"},
        },
        ['peds'] = false
    },
    ['k4mb1_furnishedoffice4_shell'] = {
        ['zIndex'] = 25,
        ['door'] = {x = 8.63, y = -2.38, z = 1.59, heading = -271.48, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = -8.39, y = -1.27, z = 1.59, dist = 1, label = Lang['open_stash'], event = 'av_gangs:stash', type = "stash"},
        },
        ['peds'] = false
    },
    ['k4mb1_furnishedoffice5_shell'] = {
        ['zIndex'] = 25,
        ['door'] = {x = 0.18, y = -11.76, z = 2.47, heading = -2.04, dist = 2, label = Lang['door_text'], event = 'av_gangs:exit'},
        ['interactions'] = {
            {x = -5.55, y = 13.38, z = 6.27, dist = 1, label = Lang['open_stash'], event = 'av_gangs:stash', type = "stash"},
        },
        ['peds'] = false
    },
}