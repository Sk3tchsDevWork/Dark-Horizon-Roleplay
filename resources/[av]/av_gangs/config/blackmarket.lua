Config = Config or {}
Config.MoneyAccount = 'bank' -- account used to buy labs and upgrades, if u want to use another payment method edit server/editable/money.lua
Config.MaxProperties = {
    ['offices'] = 2, -- Max offices a gang can own
    ['warehouse'] = 3, -- Max warehouse a gang can own
    ['labs'] = 1, -- Max labs a gang can own
}
Config.MustBeInZone = false -- true = players can only setup the property entrance inside their own territory or false = create it anywhere
Config.PropertyInZone = true -- true/false = if the gang graffiti gets removed, the property door will be locked until gang recovers control of the zone
-- how close a property can be from another one / don't use lower than 5 to prevent overlaping zones 
-- keep high number so it motivates gangs to expand their territory and not having everything in the same zone
Config.PropertyDistance = 50
Config.SellPercentage = 50 -- Percentage of the original price the gang will receive on property sell

-- List of all available products in blackmarket tab, this shop can't be used for items is only for interiors...
Config.Categories = {
    -- name must match a key index in Config.Products
    -- label is the text when player hover on the icon
    -- icons are from https://fontawesome.com/search?o=r&m=free
    -- level required to access that category
    ['labs'] = {
        name = "labs",
        label = "Labs",
        icon = "fa-solid fa-flask",
        level = 0,
        haveAccess = function()
            -- add your own check here and return true or false
            -- EXAMPLE:
            --[[
            local myGang = exports['av_gangs']:getGang() -- retrieve player gang
            if myGang and myGang['name'] == "ballas" then -- if player is part of ballas gang return true to show the category or false to hide it
                return true
            else
                return false
            end
            ]]
            return true
        end
    },
    ['offices'] = {
        name = "offices", 
        label = "Offices", 
        icon = "fa-solid fa-building",
        level = 0, 
        haveAccess = function()
            return true
        end
    },
    ['warehouse'] = {
        name = "warehouse",
        label = "Storages",
        icon = "fa-solid fa-warehouse",
        level = 0, 
        haveAccess = function()
            return true
        end
    },
}

Config.Products = {
    ['labs'] = { -- key index must match a category name
        ['k4mb1_acid2_shell'] = { -- I use shell model as key index to access data faster when needed
            type = "drugs", -- lab type, needs to match a value from Config.Upgrades
            label = "Acid Lab", -- Shown in Laptop
            shell = "k4mb1_acid2_shell", -- shell model as string (don't use ` ` hash)
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 1, -- required gang level to buy this lab
            photo = "https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/acid.jpg",
            ingredients = "drug_package", -- needed ingredient for the lab to work
            product = "weed_brick", -- item cooked by the lab
            upgrades = {
                ['stash'] = {
                    value = 'stash',
                    label = "Stash Size",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    },
                },
                ['production'] = {
                    value = 'production',
                    label = "Production",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    },
                },
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['k4weed_shell'] = { -- I use shell model as key index to access data faster when needed
            type = "drugs",
            label = "Weed Lab",
            shell = 'k4weed_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 1,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/a3e2807967ae87239c24c7d1686384bd80c4b37b.jpg",
            ingredients = "drug_package", -- needed ingredient for the lab to work
            product = "weed_brick", -- item cooked by the lab
            upgrades = {
                ['stash'] = {
                    value = 'stash',
                    label = "Stash Size",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
                ['production'] = {
                    value = 'production',
                    label = "Production",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['k4meth_shell'] = {
            type = "drugs",
            label = "Meth Lab",
            shell = 'k4meth_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 2,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/2776d84ac66023cb1f1366b246f5bb45078c73da.jpg",
            ingredients = "drug_package", -- needed ingredient for the lab to work
            product = "weed_brick", -- item cooked by the lab
            upgrades = {
                ['stash'] = {
                    value = 'stash',
                    label = "Stash Size",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
                ['production'] = {
                    value = 'production',
                    label = "Production",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['k4coke_shell'] = {
            type = "drugs",
            label = "Coke Lab",
            shell = 'k4coke_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 3,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/81867d88cc5c076fe39676fcb1e836de30301912.jpg",
            ingredients = "drug_package", -- needed ingredient for the lab to work
            product = "weed_brick", -- item cooked by the lab
            upgrades = {
                ['stash'] = {
                    value = 'stash',
                    label = "Stash Size",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
                ['production'] = {
                    value = 'production',
                    label = "Production",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['k4mb1_laundry_shell'] = {
            type = "laundromat",
            label = "Laundromat",
            shell = 'k4mb1_laundry_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 3,
            photo = "https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/laundromat.png",
            ingredients = "markedbills", -- needed ingredient for the lab to work
            product = "money", -- item cooked by the lab
            upgrades = {
                ['stash'] = {
                    value = 'stash',
                    label = "Stash Size",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
                ['production'] = {
                    value = 'production',
                    label = "Production",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
    },
    ['warehouse'] = { -- key index must match a category name
        ['container2_shell'] = { -- I use shell model as key index to access data faster when needed
            label = "Container",
            shell = 'container2_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 1,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/156c04ac052c92914eaad5de5c0af6b190e3be2f.jpg",
            inventory = {
                slots = 25, -- stash slots
                weight = 50000 -- stash weight (50kg)
            },
            upgrades = {
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['stashhouse3_shell'] = {
            label = "Small Warehouse",
            shell = 'stashhouse3_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 2,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/667f243c847f4dc45672ecfc760c6c09c9f647f6.jpg",
            inventory = {
                slots = 50, -- stash slots
                weight = 100000 -- stash weight (100kg)
            },
            upgrades = {
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['stashhouse1_shell'] = {
            label = "Big Warehouse",
            shell = 'stashhouse1_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 3,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/4799957bdce82616dec7ad77b9987d10bb11157d.jpg",
            inventory = {
                slots = 100, -- stash slots
                weight = 500000 -- stash weight (500kg)
            },
            upgrades = {
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
    },
    ['offices'] = {
        ['k4mb1_furnishedoffice1_shell'] = {
            label = "Office 1",
            shell = 'k4mb1_furnishedoffice1_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 1,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/3c65f6fddb48aba7b2a2356d465ee7ba30aa819e.jpg",
            inventory = {
                slots = 10, -- stash slots
                weight = 10000 -- stash weight (10kg)
            },
            upgrades = {
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['k4mb1_furnishedoffice2_shell'] = {
            label = "Office 2",
            shell = 'k4mb1_furnishedoffice2_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 1,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/0d983bf42c2d454b2a7b06264a923ca790c04bb8.jpg",
            inventory = {
                slots = 15, -- stash slots
                weight = 15000 -- stash weight (15kg)
            },
            upgrades = {
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['k4mb1_furnishedoffice4_shell'] = {
            label = "Office 3",
            shell = 'k4mb1_furnishedoffice4_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 2,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/255068e8e47468f60725f7cc17749b6c3b8b1499.jpg",
            inventory = {
                slots = 20, -- stash slots
                weight = 20000 -- stash weight (20kg)
            },
            upgrades = {
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
        ['k4mb1_furnishedoffice5_shell'] = {
            label = "Office 4",
            shell = 'k4mb1_furnishedoffice5_shell',
            description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Autem est earum itaque dolor a aut labore natus nemo ipsa totam?",
            price = 25000,
            level = 3,
            photo = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1027823/982586ea46febfd68fa59ab66df266b346c1f537.jpg",
            inventory = {
                slots = 30, -- stash slots
                weight = 30000 -- stash weight (30kg)
            },
            upgrades = {
                ['security'] = {
                    value = 'security',
                    label = "Security",
                    prices = {
                        [1] = {level = 1, price = 2000},
                        [2] = {level = 2, price = 5000},
                        [3] = {level = 3, price = 10000},
                    }
                },
            }
        },
    }
}