Config = Config or {}

Config.PCs = {
    ['sapd_boss_office'] = { -- an unique identifier
        label = "SAPD",
        coords = { x = 447.9599, y = -973.4294, z = 30.6896 },
        defaultPassword = "12345", -- or false
        canUse = function() -- add your own check and return true or false
            return exports['av_laptop']:hasJob("leo")
        end,
        whitelistedApps = { -- whitelisted apps or set to false to use any app
            ['terminal'] = true,
            ['documents'] = true,
            ['business'] = true
        }

    }
}