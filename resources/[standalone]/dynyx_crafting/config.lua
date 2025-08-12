Config = {}

Config.Lan = 'en' -- Sets the language for the script. Options: 'en' (English), 'es' (Spanish), 'de' (German), 'fr' (French)

-- Framework and system integrations
Config.Target = "ox_target" -- Determines which targeting system to use. Options: 'ox_target' or 'qb-target'
Config.Inventory = "ox_inventory" -- Determines which inventory system to use. Options: 'ox_inventory' / 'ps-inventory' / 'ps-inventory' / 'qs-inventory'
Config.Notifications = "ox_lib" -- Determines which notification system to use. Options: 'qb-core' or 'ox_lib'
Config.Progressbar = "ox_lib" -- Determines which progress bar system to use. Options: 'qb-core' or 'ox_lib'

-- Inventory image directory path
Config.InventoryImagePath = "ox_inventory/web/images" -- Sets the directory path for item images. Change based on the inventory system used.

-- Crafting level system
Config.LevelSystem = {
    StarterLevel = 0, -- The initial level when a player starts crafting. Recommended: 0
    IncreaseByAfterEachLevelUp = 500 -- The XP required for the next level increases by this amount each time the player levels up
}

-- Webhook settings for logging
Config.WebHooks = false -- Enable or disable webhook logging. 'false' means logging is disabled.
Config.WebHookURL = "PLACE_YOUR_WEBHOOK_HERE" -- Webhook URL for logging crafting-related activities (only used if WebHooks = true)

-- Crafting bench settings
Config.LifetimeofBench = 999999 -- Duration (in seconds) before the crafting bench despawns. '999999' effectively makes it permanent.
Config.SecondsBeforeXpGain = 5 -- The delay (in seconds) before a player gains XP after crafting an item.
Config.CamZoom = false -- Enable or disable scroll wheel zoom in the camera preview
Config.CamDrag = true -- Enable or disable camera rotation and tilt using mouse drag (LMB)
Config.ObjectOutlines = true -- Enable or disable outlines for preview objects
Config.OutlineColor = { r = 255, g = 215, b = 0, a = 255 } -- RGBA color used for preview object outlines (Gold)

Config.PreSetTables = {
    ["Table1"] = { -- Unique identifier for this crafting table (must be different for each table)
        Label = "Crafting table",  -- The name of the crafting table (displayed in UI)
        BenchProp = "gr_prop_gr_bench_02a",  -- The prop model for the crafting bench
        BenchCoords = vector4(586.8718, -3274.8003, 6.0696, 90.0),  -- Position & heading of the bench
        Groups = { "mechanic", "lostmc" },  -- Jobs/Gangs allowed to use this bench
        CitizenID = { "MNT68646" },  -- Specific players allowed to use this bench (QBCore/QBOX Use CitizenID, ESX Use Identifier)
        ["Items"] = { -- List of craftable items for this table
            ["WEAPON_PISTOL"] = { -- ITEM NAME
                Label = "Pistol", -- Display name for the weapon
                DefaultQuantity = 1, -- How many items are given per craft (e.g., crafting once gives 5 ammo)
                XPEnable = false, -- Enable XP system (true = XP is earned, false = no XP)
                Level = 0, -- Required crafting level to create this item
                xpGain = 5, -- Amount of XP gained when crafting this item
                UseBlueprint = true, -- Requires a blueprint to craft this item
                ShowOnList = false, -- If true, always shows the item in the crafting list; if false, only shows if the player owns the blueprint
                RemoveBlueprint = false, -- If true, the blueprint is consumed upon crafting
                BlueprintItem = "blueprint_pistol", -- Name of the blueprint item required to craft
                ConsumeDurability = 0, -- Set to 0 to disable durability consumption (Only applicable for ox_inventory)

                ["Material"] = { -- Materials required for crafting
                    ["rubber"] = { Label = "Rubber", amount = 1 }, -- Material name, label, and amount required
                },
                
                ["Prop"] = { -- Visual representation of the crafted item on the table
                    model = "w_pi_pistol", -- The prop model to be displayed when crafting
                    offset = vector3(1.3, 0.0, -0.3), -- Position offset for placing the prop on the table
                    rotation = vector3(0, 0, 0) -- Rotation values for positioning the prop correctly
                }
            },
            ["WEAPON_CARBINERIFLE"] = {
                Label = "Carbine Rifle",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 1,
                xpGain = 3,
                UseBlueprint = true,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "blueprint_carbinerifle",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 3 },
                    ["iron"] = { Label = "Iron", amount = 30 },
                    ["plastic"] = { Label = "Plastic", amount = 20 },
                },
                ["Prop"] = {
                    model = "w_ar_carbinerifle",
                    offset = vector3(1.3, 0.0, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["WEAPON_ASSAULTRIFLE"] = {
                Label = "Assault Rifle",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 4,
                xpGain = 8,
                UseBlueprint = true,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "blueprint_assaultrifle",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 20 },
                    ["iron"] = { Label = "Iron", amount = 35 },
                    ["plastic"] = { Label = "Plastic", amount = 25 },
                },
                ["Prop"] = {
                    model = "w_ar_assaultrifle",
                    offset = vector3(1.3, 0.0, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
        }
    },
    ["Table2"] = {
        Label = "Crafting Bench",
        BenchProp = "gr_prop_gr_bench_02a",
        BenchCoords = vector4(1670.4270, 4971.1201, 42.2788, 224.93),
        Groups = {},
        CitizenID = {},        
        ["Items"] = {
            ["ammo-9"] = {
                Label = "9mm",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 1,
                xpGain = 3,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["plastic"] = { Label = "Plastic", amount = 6 },
                    ["iron"] = { Label = "Iron", amount = 3 },
                    ["glass"] = { Label = "Glass", amount = 2 },
                },
                ["Prop"] = {
                    model = "w_pi_pistol50_mag1",
                    offset = vector3(1.3, -0.1, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["ammo-45"] = {
                Label = ".45 ACP",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 2,
                xpGain = 4,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 20 },
                    ["iron"] = { Label = "Iron", amount = 20 },
                    ["plastic"] = { Label = "Plastic", amount = 5 },
                },
                ["Prop"] = {
                    model = "w_pi_appistol_mag1",
                    offset = vector3(1.3, -0.1, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },

        }
    },
}

Config.PlaceableTables = {
    ["table_weapon"] = { -- Item name of the bench/table
        Label = "Weapon Crafting Table", -- The name of the crafting table (displayed in UI)
        BenchProp = "gr_prop_gr_bench_02a", -- The prop model for the crafting bench

        ["Items"] = { -- List of craftable items for this table
            ["WEAPON_PISTOL"] = { -- Weapon identifier (FiveM weapon hash name)
                Label = "Pistol", -- Display name for the weapon
                DefaultQuantity = 1,
                XPEnable = true, -- Enable XP system (true = XP is earned, false = no XP)
                Level = 0, -- Required crafting level to create this item
                xpGain = 3, -- Amount of XP gained when crafting this item
                UseBlueprint = true, -- Requires a blueprint to craft this item
                ShowOnList = false, -- If true, always shows the item in the crafting list; if false, only shows if the player owns the blueprint
                RemoveBlueprint = true, -- If true, the blueprint is consumed upon crafting
                BlueprintItem = "blueprint_pistol", -- Name of the blueprint item required to craft
                ConsumeDurability = 0, -- Set to 0 to disable durability consumption (Only applicable for ox_inventory)

                ["Material"] = { -- Materials required for crafting
                    ["rubber"] = { Label = "Rubber", amount = 1 }, -- Material name, label, and amount required
                },

                ["Prop"] = { -- Visual representation of the crafted item on the table
                    model = "w_pi_pistol", -- The prop model to be displayed when crafting
                    offset = vector3(1.3, 0.0, -0.3), -- Position offset for placing the prop on the table
                    rotation = vector3(0, 0, 0) -- Rotation values for positioning the prop correctly
                }
            },
            ["WEAPON_COMBATPISTOL"] = {
                Label = "Combat Pistol",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 0,
                xpGain = 3,
                UseBlueprint = true,
                ShowOnList = true,
                RemoveBlueprint = true,
                BlueprintItem = "blueprint_combatpistol",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 15 },
                    ["iron"] = { Label = "Iron", amount = 25 },
                    ["plastic"] = { Label = "Plastic", amount = 20 },
                },
                ["Prop"] = {
                    model = "w_pi_combatpistol",
                    offset = vector3(1.3, 0.0, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["WEAPON_HEAVYPISTOL"] = {
                Label = "Heavy Pistol",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 0,
                xpGain = 4,
                UseBlueprint = true,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "blueprint_heavypistol",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 15 },
                    ["iron"] = { Label = "Iron", amount = 25 },
                    ["plastic"] = { Label = "Plastic", amount = 20 },
                },
                ["Prop"] = {
                    model = "w_pi_heavypistol",
                    offset = vector3(1.3, 0.0, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["WEAPON_APPISTOL"] = {
                Label = "AP Pistol",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 1,
                xpGain = 5,
                UseBlueprint = true,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "blueprint_appistol",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 15 },
                    ["iron"] = { Label = "Iron", amount = 25 },
                    ["plastic"] = { Label = "Plastic", amount = 20 },
                },
                ["Prop"] = {
                    model = "w_pi_appistol",
                    offset = vector3(1.3, 0.0, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["WEAPON_SMG"] = {
                Label = "SMG",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 2,
                xpGain = 6,
                UseBlueprint = true,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "blueprint_smg",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 15 },
                    ["iron"] = { Label = "Iron", amount = 25 },
                },
                ["Prop"] = {
                    model = "w_sb_smg",
                    offset = vector3(1.3, 0.0, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["WEAPON_CARBINERIFLE"] = {
                Label = "Carbine Rifle",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 3,
                xpGain = 7,
                UseBlueprint = true,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "blueprint_carbinerifle",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 15 },
                    ["iron"] = { Label = "Iron", amount = 30 },
                    ["plastic"] = { Label = "Plastic", amount = 20 },
                },
                ["Prop"] = {
                    model = "w_ar_carbinerifle",
                    offset = vector3(1.3, 0.0, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["WEAPON_ASSAULTRIFLE"] = {
                Label = "Assault Rifle",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 4,
                xpGain = 8,
                UseBlueprint = true,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "blueprint_assaultrifle",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 20 },
                    ["iron"] = { Label = "Iron", amount = 35 },
                    ["plastic"] = { Label = "Plastic", amount = 25 },
                },
                ["Prop"] = {
                    model = "w_ar_assaultrifle",
                    offset = vector3(1.3, 0.0, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            }
        },
    },
    ["table_tools"] = {
        Label = "Tools Crafting Table",
        BenchProp = "gr_prop_gr_bench_03b",
        ["Items"] = {
            ["drill"] = {
                Label = "Drill",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 2,
                xpGain = 5,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 10 },
                    ["iron"] = { Label = "Iron", amount = 20 },
                },
                ["Prop"] = {
                    model = "gr_prop_gr_drill_01a",
                    offset = vector3(1.2, -0.1, -0.3),
                    rotation = vector3(0.5, 0.0, 90.0)
                }
            },
            ["camera"] = {
                Label = "Camera",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 2,
                xpGain = 4,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["iron"] = { Label = "Iron", amount = 4 },
                    ["glass"] = { Label = "Glass", amount = 3 },
                },
                ["Prop"] = {
                    model = "prop_pap_camera_01",
                    offset = vector3(1.2, -0.1, -0.3),
                    rotation = vector3(0, 0, 90)
                }
            },
            ["trojan_usb"] = {
                Label = "Trojan USB",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 3,
                xpGain = 6,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["iron"] = { Label = "Iron", amount = 4 },
                    ["plastic"] = { Label = "Plastic", amount = 5 },
                },
                ["Prop"] = {
                    model = "tr_prop_tr_usb_drive_02a",
                    offset = vector3(1.2, -0.1, -0.3),
                    rotation = vector3(90, 0, 0)
                }
            },
            ["thermite"] = {
                Label = "Thermite",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 3,
                xpGain = 7,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["iron"] = { Label = "Iron", amount = 5 },
                    ["aluminum"] = { Label = "Aluminum", amount = 3 },
                },
                ["Prop"] = {
                    model = "hei_prop_heist_thermite",
                    offset = vector3(1.2, -0.1, -0.3),
                    rotation = vector3(90, 0, 0)
                }
            },
        },
    },
    ["table_ammo"] = {
        Label = "Ammo Crafting Table",
        BenchProp = "imp_prop_impexp_mechbench",
        ["Items"] = {
            ["ammo-9"] = {
                Label = "9mm",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 1,
                xpGain = 3,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["plastic"] = { Label = "Plastic", amount = 6 },
                    ["iron"] = { Label = "Iron", amount = 3 },
                    ["glass"] = { Label = "Glass", amount = 2 },
                },
                ["Prop"] = {
                    model = "w_pi_pistol50_mag1",
                    offset = vector3(1.3, -0.1, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["ammo-45"] = {
                Label = ".45 ACP",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 2,
                xpGain = 4,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 20 },
                    ["iron"] = { Label = "Iron", amount = 20 },
                    ["plastic"] = { Label = "Plastic", amount = 5 },
                },
                ["Prop"] = {
                    model = "w_pi_appistol_mag1",
                    offset = vector3(1.3, -0.1, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["ammo-rifle"] = {
                Label = "5.56",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 3,
                xpGain = 5,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 25 },
                    ["iron"] = { Label = "Iron", amount = 30 },
                    ["plastic"] = { Label = "Plastic", amount = 6 },
                },
                ["Prop"] = {
                    model = "w_ar_carbinerifle_mag1",
                    offset = vector3(1.3, -0.1, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["ammo-shotgun"] = {
                Label = "12 Gauge",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 3,
                xpGain = 5,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 30 },
                    ["iron"] = { Label = "Iron", amount = 30 },
                    ["plastic"] = { Label = "Plastic", amount = 6 },
                },
                ["Prop"] = {
                    model = "w_sg_heavyshotgun_mag1",
                    offset = vector3(1.3, -0.1, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["ammo-sniper"] = {
                Label = "7.62x51",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 4,
                xpGain = 6,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 35 },
                    ["iron"] = { Label = "Iron", amount = 35 },
                    ["plastic"] = { Label = "Plastic", amount = 7 },
                },
                ["Prop"] = {
                    model = "w_sr_sniperrifle_mag1",
                    offset = vector3(1.3, -0.1, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
            ["ammo-heavysniper"] = {
                Label = ".50 BMG",
                DefaultQuantity = 1,
                XPEnable = true,
                Level = 5,
                xpGain = 7,
                UseBlueprint = false,
                ShowOnList = true,
                RemoveBlueprint = false,
                BlueprintItem = "",
                ConsumeDurability = 0,
                ["Material"] = {
                    ["rubber"] = { Label = "Rubber", amount = 40 },
                    ["iron"] = { Label = "Iron", amount = 40 },
                    ["plastic"] = { Label = "Plastic", amount = 8 },
                },
                ["Prop"] = {
                    model = "w_sr_heavysniper_mag1",
                    offset = vector3(1.3, -0.1, -0.3),
                    rotation = vector3(0, 0, 0)
                }
            },
        },
    },
}
