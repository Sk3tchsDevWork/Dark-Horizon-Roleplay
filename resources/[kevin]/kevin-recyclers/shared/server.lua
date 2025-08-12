return {
    recycleTime = 0.3, -- minutes the recycler take to break down items into materials
    recyclers = {
        use = true, -- enable or disable the recycler
        coords = {
            vector4(996.81, -3099.46, -39.0, 270.26)
        }
    },
    emptyCrateItem = 'empty_recycleables_crate', -- item to give the player when they take a empty crate
    fullCrateItem = 'recycleables', -- item to give the player when they get materials from a crate
    shop = {
        use = false, -- enable or disable the shop
        name = 'Ls Recyclers',
        items = {
            { name = 'recycler', price = 5000 },
        },
    },
    recycleables = {
        ['recycleables'] = {
            --job = '', -- only players with this job can recycle this
            rewards = {
                ['iron'] = { min = 0, max = 2 },
                ['copper'] = { min = 0, max = 2 },
                ['aluminum'] = { min = 3, max = 6 },
                ['steel'] = { min = 0, max = 2 },
                ['plastic'] = { min = 3, max = 6 },
                ['glass'] = { min = 3, max = 6 },
            }
        },
        ['beer'] = {
            rewards = {
                ['glass'] = { min = 1, max = 5 },
            }
        },
        ['kurkakola'] = {
            rewards = {
                ['aluminum'] = { min = 1, max = 5 },
            }
        },
        ['scrap'] = {
            rewards = {
                ['iron'] = { min = 1, max = 5 },
                ['copper'] = { min = 1, max = 5 },
                ['aluminum'] = { min = 1, max = 5 },
                ['steel'] = { min = 1, max = 5 },
            }
        },
        ['phone'] = {
            rewards = {
                ['copper'] = { min = 1, max = 5 },
            }
        },
        ['WEAPON_PISTOL'] = {
            rewards = {
                ['copper'] = { min = 1, max = 5 },
            }
        },
    }
}