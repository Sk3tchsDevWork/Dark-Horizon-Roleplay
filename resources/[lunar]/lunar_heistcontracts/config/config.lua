/*
    THANKS FOR PURCHASING OUR HEIST CONTRACTS SCRIPT! <3
    
    You can find the detailed configuration for each heist in lunar_contracts/config/contracts
    Target, 3D prompts, notifications and progress bar can be configured in lunar_bridge/config
    Minigames can be configured in lunar_contracts/config/cl_edit.lua
    Want to use dirty money item as an account? Configure it in lunar_bridge/config/config.lua

    Need help with the script?
    Join our discord, claim the customer role and open a support ticket:
    https://discord.gg/AAuvQYgyqX
*/

---@class Contract
---@field settings ContractSettings

Config = {}
---@type table<string, Contract>
Config.contracts = {}

Config.tabletItem = 'contracts_tablet'
Config.itemCheck = true -- Perform an item check on the client side event
Config.disableTabletAnim = false

-- Makes the main menu inaccessible basically, goes to contracts instead
Config.disableMainMenu = false

-- Whether to enable the custom server-side check that happens in sv_edit.lua
Config.customTabletCheck = false

-- The contract will disappear and the objective UI will hide instantly regardless of this setting
-- This setting is the actual hard stop when all of the heist entities are deleted, etc.
-- I don't recommend changing this
Config.cancelDelay = 5 -- minutes

-- Whether to check the minimum number of police online before purchasing a contract
Config.minPoliceBeforePurchase = false

-- Hide contracts that the player doesn't have enough XP for
Config.hideUnavailableContracts = false

-- Disable the warning about mka-lasers dependency not found (NOT RECOMMENDED, YOU SHOULD INSTALL IT)
Config.disableLasersWarn = false

-- This setting allows the police to cancel the heist by walking inside the building and using the /cancelheist command
-- The policeman first has to come up to the point and play an animation for 30 seconds to prevent abuse
-- The location where they can cancel it is usually the entrance door or the reception inside the building
Config.policeHeistCancelling = {
    enabled = false,
    duration = 30, -- seconds
    minGrade = 0, -- minimum job grade to cancel the heist
    command = 'cancelheist', -- command to cancel the heist
}

Config.generator = {
    -- The minutes between each generation
    minutesBetweenGeneration = 1,

    -- The maximum number of contracts before it stops generating
    max = 16,

    -- The maximum number of contracts at player can own
    playerLimit = 5,

    -- This is how often old contracts get cleared out
    -- Configurator = https://crontab.guru/every-10-minutes
    clearCron = '*/10 * * * *' -- every 10 minutes
}

-- Place the heists that can't be started at the same time here
Config.limitedHeists = {
    -- 'pacific',
    -- 'paleto',
    -- 'mazebank',
    -- 'artasylum'
}

-- Do you want to override the default way crypto or experience is retrieved?
-- Set this to true and plug your export inside sv_edit.lua
-- Values get refreshed every time you open the tablet
Config.overrideCrypto = false
Config.overrideExperience = false

-- Hides crypto from the UI
Config.hideCrypto = false

---@type 'crypto' | 'money' | 'bank'
Config.contractCurrency = 'crypto' -- The currency which contracts are bought with

-- Player's start with this
Config.defaultProfile = {
    image = 'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg',
    crypto = 100,
    xp = 0
}

-- The allowed extensions for profile pictures
Config.allowedImageExtensions = {
    '.jpg',
    '.jpeg',
    '.png',
    '.webp'
}

-- This is only relevant for ESX
-- Use this in server.cfg to give perms on QBCore:
-- add_ace group.admin contracts_admin allow
Config.adminGroups = {
    ['admin'] = true,
    ['god'] = true
}

Config.crypto = {
    -- The currency label
    label = 'GCoin',

    -- This dictates how the reward is handed out
    -- owner = Only the owner receives the crypto reward
    -- members = All of the members receive the reward
    -- members_split = The reward is split between the members instead of the full amount
    ---@type 'owner' | 'members' | 'members_split'
    reward = 'members_split'
}

---@class ShopBuyItem
---@field name string
---@field description string
---@field price { money: integer, crypto: integer }
---@field stock integer
---@field chance integer?

---@class ShopSellItem
---@field name string
---@field price { money: integer?, crypto: integer? }

-- The ped where players can receive orders
Config.ped = {
    oldMenu = false, -- Use the old menu instead of conversation style UI?
    model = `u_m_m_edtoh`,
    -- The blip appears when marked inside the tablet
    blip = {
        name = locale('dealer'),
        sprite = 108,
        size = 0.75,
        color = 26
    },
    buyAccount = 'money', -- The money account used in the transaction
    ---@type ShopBuyItem[]
    buyItems = {
        { name = 'angle_grinder', description = locale('angle_grinder_description'), price = { money = 1000, crypto = 75 }, stock = 3 },
        { name = 'plasma_cutter', description = locale('plasma_cutter_description'), price = { money = 1000, crypto = 75 }, stock = 3 },
        { name = 'hack_usb', description = locale('hack_usb_description'), price = { money = 1250, crypto = 100 }, stock = 5 },
        { name = 'hack_card', description = locale('hack_card_description'), price = { money = 2000, crypto = 150 }, stock = 5 },
        { name = 'thermite', description = locale('thermite_description'), price = { money = 250, crypto = 20 }, stock = 5 },
        { name = 'large_drill', description = locale('large_drill_description'), price = { money = 5000, crypto = 200 }, stock = 3 },
        { name = 'small_drill', description = locale('small_drill_description'), price = { money = 5000, crypto = 200 }, stock = 3 },
        { name = 'explosives', description = locale('explosives_description'), price = { money = 5000, crypto = 200 }, stock = 3 },
        { name = 'weapon_digiscanner', description = locale('signal_booster_description'), price = { money = 2500, crypto = 125 }, stock = 3 },
        { name = 'bomb_c4', description = locale('bomb_c4_description'), price = { money = 7500, crypto = 200 }, stock = 2 },
        { name = 'weapon_pistol', description = locale('weapon_pistol_description'), price = { money = 12500, crypto = 500 }, stock = 2, chance = 25 },
        { name = 'weapon_combatpistol', description = locale('weapon_combatpistol_description'), price = { money = 17500, crypto = 750 }, stock = 2, chance = 25 },
    },
    sellAccount = 'money',
    ---@type ShopSellItem[]
    sellItems = {
        { name = 'gold_bar', price = { money = 7500, crypto = 5 } },
        { name = 'classified_docs', price = { money = 3500, crypto = 2 } },
        { name = 'rare_coins', price = { money = 5250, crypto = 5 } },
        { name = 'diamonds_box', price = { money = 19500, crypto = 10 } },
        { name = 'diamond_necklace', price = { money = 12500, crypto = 5 } },
        { name = 'diamond_ring', price = { money = 7500, crypto = 5 } },
        { name = 'luxurious_watch', price = { money = 11500, crypto = 5 } },
        { name = 'painting', price = { money = 20000, crypto = 5 } },
        { name = 'rare_tequila', price = { money = 50000, crypto = 20 } },
        { name = 'pink_diamond', price = { money = 100000, crypto = 20 } },
        { name = 'coke_brick', price = { money = 3000, crypto = 1 } },
        { name = 'weed_brick', price = { money = 1500, crypto = 1 } },
        { name = 'tv', price = { money = 2500, crypto = 1 } },
        { name = 'microwave', price = { money = 1500, crypto = 1 } },
        { name = 'monitor', price = { money = 1250, crypto = 1 } },
        { name = 'printer', price = { money = 2000, crypto = 1 } },
        { name = 'flat_tv', price = { money = 3000, crypto = 2 } },
        { name = 'old_tv', price = { money = 2000, crypto = 1 } },
        { name = 'dj_deck', price = { money = 1750, crypto = 1 } },
        { name = 'console', price = { money = 1000, crypto = 1 } },
        { name = 'keyboard', price = { money = 250, crypto = 1 } },
        { name = 'laptop', price = { money = 1250, crypto = 1 } },
        { name = 'bong', price = { money = 500, crypto = 1 } },
        { name = 'meth_bag', price = { money = 2500, crypto = 1 } }
    },
    ---@type vector4[]
    locations = {
        vector4(696.1232, -960.1873, 24.0025, 93.2174)
    }
}

Config.leaderboard = {
    limit = 10 -- Only shows the top 10, avoid very big values as it can slow down your server
}

-- This specifies the number of cash/gold in trolley/pile
-- I don't recommend changing this
Config.lootingAnimations = {
    ['cash'] = {
        ['pile'] = { intro = 1500, interval = 800, count = 18 },
        ['trolley'] = { intro = 2100, interval = 1000, count = 45 }
    },
    ['gold'] = {
        ['pile'] = { intro = 1500, interval = 600, count = 20 },
        ['trolley'] = { intro = 2100, interval = 1000, count = 45 }
    },
    ['diamonds'] = {
        ['trolley'] = { intro = 2100, interval = 1000, count = 45 }
    },
    ['weed'] = {
        ['pile'] = { intro = 1500, interval = 600, count = 20 },
    },
    ['coke'] = {
        ['pile'] = { intro = 1500, interval = 600, count = 20 },
    },
}

-- Used for CCTV's in the heists
Config.cameraSettings = {
    rotateSpeed = 0.2,
    controls = {
        left = 34,
        right = 35,
        up = 32,
        down = 33
    }
}

---@class ContractSettings
---@field disabled boolean
---@field chance integer
---@field price integer? can be zero
---@field requiredExperience integer? can be zero
---@field rewards { crypto: integer | { min: integer, max: integer }, experience: integer | { min: integer, max: integer } }?
---@field expiry integer how many minutes does it take for the contract to expire
---@field minMembers integer
---@field maxMembers integer?
---@field timeToStart integer how many minutes does the player have to start the contract after buying it
---@field minPolice integer the minumum number of police online to start the heist, the police job 
---@field maxStartedLimit integer? the maximum number of contracts that can be started at the same time

---@class GuardWeapon
---@field name string
---@field ammo { name: string, min: integer, max: integer }

---@class LootData
---@field rewards table<string, { item: string?, account: string?, count: { pile: integer, trolley: integer } }>
---@field goldChance integer
---@field diamondsChance integer?
---@field locations { coords: vector4, type: 'trolley' | 'pile', alreadySpawned: string?, requires: string?, forceLootType: string? }[]