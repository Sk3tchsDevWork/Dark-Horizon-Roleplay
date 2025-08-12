Config = Config or {}
-- moved this to a new file otherwise blackmarket.lua would be too long to edit
Config.Upgrades = {
    ['drugs'] = {
        ['production'] = {
            default = {
                cooldown = 120, -- in minutes, cooldown before the next cook
                purity = {min = 40, max = 50}, -- min and max purity the drug can have by default
                amount = {min = 1, max = 2}, -- min and max to add to Product stash
            },
            cooldown = { -- upgrades for cooldown (in minutes)
                [1] = 100,
                [2] = 80,
                [3] = 60,
            },
            purity = { -- upgrades for purity, needs a min and a max, will be random every time
                [1] = {min = 70, max = 80},
                [2] = {min = 80, max = 95},
                [3] = {min = 95, max = 100},
            },
            amount = { -- amount to add to Product stash
                [1] = {min = 2, max = 3},
                [2] = {min = 3, max = 5},
                [3] = {min = 5, max = 8},
            },
        },
        ['stash'] = {
            default = {
                weight = 5000, -- default 5kg
                slots = 5, -- default 5 slots
            },
            slots = {
                [1] = 10,
                [2] = 20,
                [3] = 30,
            },
            weight = {
                [1] = 10000,
                [2] = 20000,
                [3] = 30000,
            },
        }
    },
    ['laundromat'] = {
        ['production'] = {
            default = {
                cooldown = 120, -- in minutes, cooldown before the next cook
                amount = 10000, -- amount to add to Product stash
            },
            cooldown = { -- upgrades for cooldown (in minutes)
                [1] = 100,
                [2] = 80,
                [3] = 60,
            },
            amount = { -- amount to add to Product stash
                [1] = 15000,
                [2] = 20000,
                [3] = 25000,
            },
        },
        ['stash'] = {
            default = {
                weight = 5000, -- default 5kg
                slots = 5, -- default 5 slots
            },
            slots = {
                [1] = 10,
                [2] = 20,
                [3] = 30,
            },
            weight = {
                [1] = 10000,
                [2] = 20000,
                [3] = 30000,
            },
        }
    },
}