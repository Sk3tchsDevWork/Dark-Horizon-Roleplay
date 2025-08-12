-- It is recommended that you use zyke_status for the best experience when using effects (Free)
-- https://github.com/ZykeWasTaken/zyke_status

Config = Config or {}

Config.Settings = {
    debug = false,
    hud = true, -- Master switch to toggle hud, more info: https://docs.zykeresources.com/paid-resources/smoking/config#hud
    language = "en",
    maxInhale = 3.0, -- 0.1-3.0
    cancelBenefitsOnMaxHit = true, -- Cancel effects such as gaining health and armor if you hit the max
    firstTimeUseDiscalimer = true, -- First time you use one of the smokeables, you will get a pop-up with insutrctions, it will then be saved and not pop up again
    disableSmokingWhenArmed = true, -- Stops you from being able to inhale if you have a weapon out
    disableAttackingWhenSmoking = true, -- Completely blocks shooting / punching / aiming when you are inhaling
    automaticSmoking = false, -- If enabled, players can tap the smoke button and perform a full inhale, does not restrict you from holding like normal, disable to force holding to inhale
    removePackWhenEmpty = true, -- If enabled, it will remove your cigarette pack if it becomes empty
    notificationOnCigaretteUnpack = true, -- Gives you a notification that you grabbed a cigarette from a pack
    lighter = {
        item = {"lighter", "lighter2"}, -- Will use first item as default, and refer back to if prop / sound etc does not exist for another lighter
        enableFluidUse = true, -- If fluid metadata should be changed & checked when lighting, note that your item has to be unique (not stackable)
        fluidPerUse = 0.4, -- Fluid to use per lighter use, if fluid use is enabled
        particle = {dict = "core", name = "ent_brk_sparking_wires_sp", duration = 600},
        attempts = {min = 1, max = 3}, -- Random amount of attempts to light the lighter
    },
    keys = {
        -- These are the defaults
        -- They are keymapped and can be changed in the game settings
        ["hit"] = "E",
        ["switchPlacement"] = "H",
        ["cancel"] = "X",
        ["transferItem"] = "J",
    },
    passiveSmoke = {
        joint = 0.03,
        cigarette = 0.03,
        cigar = 0.05,
    },
    exhaleSmoke = {
        joint = 0.17,
        cigarette = 0.15,
        cigar = 0.18,
        bong = 0.3,
        vape = 0.25,
    },
    decay = {
        -- When cigarattes are lit, there is a decay once a second
        joint = 0.1,
        cigarette = 0.1,
        cigar = 0.2,
    },
    useMultiplier = {
        -- There is a base use amount of 1.0 per second of inhale
        -- In here, you can adjust the amount of use per hit
        -- Note that the effects and such are affected by this, as you are using more or less per hit
        -- Example, setting a value to 0.5 will double the amount of hits you can take, and the effects will be halved during each hit
        -- A value of 1.0 will result in 100 seconds of use

        joint = 1.4,
        cigarette = 1.6,
        cigar = 1.3,
        bong = 1.0,
        vape = 0.4,
    },
    propPosition = {
        ["hand"] = {
            ["p_amb_joint_01"] = {
                bone = 64016,
                offset = {x = 0.065, y = -0.01, z = 0.0},
                rotation = {x = 0.0, y = 300.0, z = 50.0},
            },
            ["ng_proc_cigarette01a"] = {
                bone = 64097,
                offset = {x = 0.02, y = 0.02, z = -0.008},
                rotation = {x = 100.0, y = 0.0, z = 100.0},
            },
            ["prop_cigar_03"] = {
                bone = 64097,
                offset = {x = 0.02, y = -0.07, z = -0.008},
                rotation = {x = 100.0, y = 0.0, z = 100.0},
            },
            ["ba_prop_battle_vape_01"] = {
                bone = 18905,
                offset = {x = 0.135, y = 0.04, z = 0.0},
                rotation = {x = 150.0, y = -35.0, z = -20.0},
            },
            ["prop_bong_01"] = {
                bone = 18905,
                offset = {x = 0.13, y = -0.23, z = 0.07},
                rotation = {x = 80.0, y = 190.0, z = 180.0},
            }
        },
        ["mouth"] = {
            ["p_amb_joint_01"] = {
                bone = 47419,
                offset = {x = 0.015, y = -0.009, z = 0.003},
                rotation = {x = 55.0, y = 0.0, z = 80.0},
            },
            ["ng_proc_cigarette01a"] = {
                bone = 47419,
                offset = {x = 0.015, y = -0.009, z = 0.003},
                rotation = {x = 55.0, y = 0.0, z = 80.0},
            },
            ["prop_cigar_03"] = {
                bone = 47419,
                offset = {x = -0.01, y = -0.1, z = 0.008},
                rotation = {x = 55.0, y = 0.0, z = 80.0},
            }
        }
    },
    particles = {
        -- R (255), G (255), B (255), A (1.0)
        color = {190, 190, 190, 1.0},
        offsets = {
            ["p_amb_joint_01"] = {x = -0.11, y = 0.0, z = 0.0},
            ["ng_proc_cigarette01a"] = {x = -0.07, y = 0.0, z = 0.0},
            ["prop_cigar_03"] = {x = -0.01, y = 0.0, z = 0.0},
            ["prop_bong_01"] = {x = 0.06, y = 0.0, z = 0.1}, -- Lighter effect only
        }
    },
    effects = {
        -- Recommended to use zyke_status (Free)
        -- decay is not of use when using zyke_status, it is handled by the status system
        -- https://github.com/ZykeWasTaken/zyke_status

        maxDuration = 600, -- Seconds
        minAmount = 100.0, -- Minimum amount to use to start feeling the effect
        multiplier = 12.0, -- Multiplier of the amount you used, if you inhale for 10 seconds, and use 10.0 amount, you will now gain 120.0 seconds instead at the default 12.0 multiplier
        decay = 1.0, -- Every 5 seconds you are not high, this set amount will be removed (unused with zyke_status)
    },
    -- Extra settings for vapes
    vapeExtras = {
        batteryItem = "vape_battery",
        batteryDrain = 0.12, -- Drain per second when inhaling
        items = {
            -- The vanilla flavour contains all available effects, as a demo
            ["vape_vanilla_flavour"] = {
                effects = {
                    -- Standard effects
                    stress = -100.0,
                    stamina = 2500.0, -- Has to be quite a high value since you lose stamina fast, with quick and good timings, you can constantly run with a little over 3000.0 stamina gain.
                    clientFunc = function(value, capsule, metadata)
                        -- print("Total amount has been removed:", value)
                        -- print("Used capsule", capsule)

                        -- print("Raw data received:", json.encode(metadata))
                    end,
                    serverFunc = function(playerId, value, capsule, metadata)
                        -- exports["zyke_status"]:RemoveFromStatus(playerId, "stress", value / 2) -- Remove any built up stress
                        -- exports["zyke_status"]:AddToStatus(playerId, {"addiction", "nicotine"}, value * 10) -- Character creates & manages an addiction
                        -- exports["zyke_status"]:AddToStatus(playerId, {"high", "nicotine"}, value * 10) -- Instant effect as soon as it hits treshold
                    end,

                    -- Works for all, enhanced with zyke_status
                    health = 500.0,
                    armor = 80.0,
                    screenEffect = "BeastLaunch02",
                    walkEffect = "move_m@drunk@a", -- Set to nil or empty string to disable

                    -- zyke_status only
                    food = 100.0,
                    water = 100.0,
                }
            },
            ["vape_purple_flavour"] = {
                color = {128, 0, 128, 1.0},
                effects = {
                    health = 100.0,
                    armor = 500.0,
                    stress = -100.0,
                    stamina = 500.0,

                    -- All of the screen & walk effects are tied to your addiction/high status

                    -- Example of getting high & managing an addiction, this is for more long-term roleplay
                    serverFunc = function(playerId, value, capsule, metadata)
                        exports["zyke_status"]:AddToStatus(playerId, {"addiction", "meth"}, value * 10) -- Character creates & manages an addiction
                        exports["zyke_status"]:AddToStatus(playerId, {"high", "meth"}, value * 10) -- Instant effect as soon as it hits treshold
                    end,
                }
            },
            ["vape_green_flavour"] = {
                color = {0, 255, 0, 1.0},
                effects = {
                    health = 500.0,
                    armor = 100.0,
                    stress = -100.0,
                    food = 30.0,
                    water = 30.0,

                    -- All of the screen & walk effects are tied to your addiction/high status

                    -- Example of getting high & managing an addiction, this is for more long-term roleplay
                    serverFunc = function(playerId, value, capsule, metadata)
                        exports["zyke_status"]:AddToStatus(playerId, {"addiction", "thc"}, value * 10) -- Character creates & manages an addiction
                        exports["zyke_status"]:AddToStatus(playerId, {"high", "thc"}, value * 10) -- Instant effect as soon as it hits treshold
                    end,
                }
            },
            ["vape_rainbow_flavour"] = {
                color = "rainbow",
                effects = {
                    health = 250.0,
                    armor = 250.0,
                    stress = -100.0,
                    food = 30.0,
                    water = 30.0,
                    stamina = 1000.0,

                    -- This uses a direct screen & walk effect via zyke_status
                    -- This effect is not tied to any status and is very temporary
                    screenEffect = "DaxTrip03",
                    walkEffect = "move_m@drunk@a",
                }
            }
        }
    },
    bongExtras = {
        waterItem = "bong_water",
        waterDrain = 0.5, -- Drain per second when inhaling
        items = {
            ["weed_nugget"] = {
                color = {0, 255, 100, 1.0},
                effects = {
                    health = 50.0,
                    armor = 25.0,
                    screenEffect = "BikerFilter",
                    clientFunc = function(value, item)
                        -- print("Total amount has been removed:", value)
                        -- print("Used item", item)
                    end,
                    serverFunc = function(playerId, value, item)
                        -- print("Server function triggered by", playerId)
                        -- print("Total amount has been removed:", value)
                        -- print("Used item", item)
                    end
                }
            }
        }
    },
    sound = {
        ["exhale"] = {
            name = "exhale.wav",
            volume = 0.2,
            distance = 2.0,
        },
        ["inhale"] = {
            name = "inhale.wav",
            volume = 0.05,
            distance = 2.0,
        },
        ["inhale_bong"] = {
            name = "inhale_bong.wav",
            volume = 0.15,
            distance = 3.5,
        },
        ["inhale_vape"] = {
            name = "inhale_vape.wav",
            volume = 0.25,
            distance = 3.0,
        },
        ["lighter"] = {
            name = "lighter.wav",
            volume = 0.1,
            distance = 1.5,
        },
        -- Play other custom lighter sounds by name reference here, and add the sound in zyke_sounds
        -- ["lighter2"] = {
        --     name = "some_other_sound.wav",
        --     volume = 0.1,
        --     distance = 1.5,
        -- },
        ["m_cough"] = {
            name = {"cough_m1.wav", "cough_m2.ogg", "cough_m3.ogg", "cough_m4.ogg", "cough_m5.ogg"},
            volume = 0.2,
            distance = 5.0,
        },
        ["f_cough"] = {
            name = {"cough_f1.wav", "cough_f2.wav", "cough_f3.wav", "cough_f4.wav", "cough_f5.wav", "cough_f6.wav"},
            volume = 0.2,
            distance = 5.0,
        },
        ["vape_beep"] = {
            name = "vape_beep.mp3",
            volume = 0.01,
            distance = 5.0,
        }
    },
    packs = {
        -- Name of the pack
        ["cigarette_pack"] = {
            itemToGive = "cigarette", -- Item you get when you use the pack
            amount = 20, -- Total amount of cigarettes in the pack, will set this amount on inventory update and there is no amount metadata
        },
        -- Feel free to add more types of packs below
    },
    -- Styling & positioning of indicators
    itemDataIndicators = {
        color = "var(--blue)", -- Color of the progress & icon
        endColor = "var(--redMuted)", -- Color of the progress when it reaches the end
        animation = {
            ["finished"] = {
                opacity = 1,
                bottom = "0.5rem",
            },
            ["exit"] = {
                opacity = 0,
                bottom = "-2rem",
            }
        },
        -- Styling applied to the container for the indicators
        style = {
            transform = "translateX(calc(-50% - 17rem))", -- To the left of the inhale indicator
        }
    },
}

---@type table<string, CigaretteSettings>
Config.Cigarettes = {
    ["joint"] = {
        type = "joint",
        prop = "p_amb_joint_01",
        color = {0, 255, 0, 1.0},
        effects = {
            health = 50.0, -- Total gained, will be divided during hits
            armor = 25.0,
            screenEffect = "NG_filmic09",
            walkEffect = "move_m@drunk@verydrunk", -- Set to nil or empty string to disable
            multiplier = 5.0,
            clientFunc = function(value, item, metadata)
                -- print("Total amount has been removed:", value)
                -- print("Used item", item)

                -- print("Raw data received:", json.encode(metadata))
            end,
            serverFunc = function(playerId, value, item, metadata)
                -- print("Server function triggered by", playerId)
                -- print("Total amount has been removed:", value)
                -- print("Used item", item)

                -- print("Raw data received:", json.encode(metadata))
            end
        }
    },
    ["cigarette"] = {
        type = "cigarette",
        prop = "ng_proc_cigarette01a",
        effects = {
            health = 20.0,
            armor = 15.0,
        }
    },
    ["cigar"] = {
        type = "cigar",
        prop = "prop_cigar_03",
        effects = {
            health = 10.0,
            armor = 65.0,
        },
    },
}

---@type table<string, RefillableSettings>
Config.Refillables = {
    ["bong"] = {
        type = "bong",
        prop = "prop_bong_01",
    },
    ["vape"] = {
        type = "vape",
        prop = "ba_prop_battle_vape_01",
    },
}

Config.LighterProps = {
    ["lighter"] = {
        model = "p_cs_lighter_01",

        ["hand"] = {
            ["bong"] = {
                bone = 64016,
                offset = {x = 0.01, y = -0.03, z = -0.02},
                rotation = {x = -50.0, y = 50.0, z = -50.0},
            },
            ["cigarette"] = {
                bone = 18905,
                offset = {x = 0.135, y = 0.04, z = 0.0},
                rotation = {x = 150.0, y = -35.0, z = 200.0},
            },
            ["cigar"] = {
                bone = 18905,
                offset = {x = 0.135, y = 0.04, z = 0.0},
                rotation = {x = 150.0, y = -35.0, z = 200.0},
            },
            ["joint"] = {
                bone = 18905,
                offset = {x = 0.135, y = 0.04, z = 0.0},
                rotation = {x = 150.0, y = -35.0, z = 200.0},
            },
        },

        ["mouth"] = {
            ["cigarette"] = {
                bone = 64016,
                offset = {x = 0.0, y = -0.03, z = -0.02},
                rotation = {x = -50.0, y = 50.0, z = -50.0},
            },
            ["cigar"] = {
                bone = 64016,
                offset = {x = 0.0, y = -0.03, z = -0.02},
                rotation = {x = -50.0, y = 50.0, z = -50.0},
            },
            ["joint"] = {
                bone = 64016,
                offset = {x = 0.0, y = -0.03, z = -0.02},
                rotation = {x = -50.0, y = 50.0, z = -50.0},
            }
        }
    },
    -- Add other lighter props here
}