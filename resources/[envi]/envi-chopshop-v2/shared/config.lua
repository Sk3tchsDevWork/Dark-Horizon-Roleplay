Config = {}

-- 2.4.0 UPDATE NOTES-- 
-- Ctrl+F and search for NEW to find the config changes!

-- Add support for NATIVE Sounds (Real GTA Game Sound) - Disable this to still use interact-sound/ xSound
-- Fixed issue with networked Particle FX

Config.Debug = false -- Set to true to enable debug mode

Config.OpenAllDoorsOnStart = true -- Set to true to open all doors on the vehicle when starting the chop

Config.AdvancedParking = false -- Set to true if you use AdvancedParking 

Config.PartsDeleteTimer =  60 -- Time in seconds before the parts are deleted from the drop-off location
Config.DeleteVehicleTime = 10 -- Time in seconds before the vehicle when finishing the chop

Config.InteractionKey = 38 -- Change the key for interactions for Start Chop Vehicle and Manage Chop Shop [Default: E]

Config.DropToolsKey = 73 -- Key to drop the tools [Default: X]


-- Cool Down Time
Config.CooldownTime = 30 -- Time in minutes before you can chop another vehicle
Config.ShowTimeRemaining = true -- Shows a notification with the time remaining until you can chop another vehicle

-- Contract Settings
Config.SpecialContractCooldown = 60 -- Time in minutes before you can generate another contract
Config.ContractItem = 'chop_contract' -- Item to receive when generating a contract
Config.ContractCompleteBonus = 5000 -- Bonus for completing a contract


-- Location Settings

Config.ChopShops = { -- Add as many as you need
    ['LS Customs'] = {   -- Name of the Chop Shop - [MUST BE UNIQUE]
        ChopLocation = vec3(732.99, -1088.95, 22.16),               -- Center of the ChopShop Area
        DropPartsLocation = vector3(728.43, -1072.27, 20.39),
        FinishChopLocation = vec3(725.7445, -1071.1239, 27.31),
        ChopZoneRadius = 30.0,                  -- Radius of the zone of the shop, for spawning props etc
        ChoppingAreaRadius = 10.0,         -- Radius of the area where you can chop the vehicle (MUST be smaller than ChopZoneRadius)

        -- Tool Locations
        ImpactDriverLocation = vec3(737.2314, -1078.6794, 22.1687),
        SawLocation = vec3(731.1500, -1077.4465, 22.1688),

        -- Job Settings
        AllowedJobsOnly = {enabled = false, jobs = {'police', 'ambulance'}},
        BlacklistedJobs = {enabled = true, jobs = {'police', 'ambulance'}},

        -- Management Settings
        Ownable = true,
        ManagementLocation = vec3(727.8610, -1067.2437, 27.31),
        Price = 100000,
        Percentage = 10,   -- Owner will recieve 10% of the total chop value into management fund
        CanSell = true,    -- Can sell the business to get back % of the original price
        SellPercentage = 50, -- % of the original price you get back when selling the business
        CanTransfer = true, -- Can transfer ownership of the business to another player

        -- Ped Settings (Optional)
        
        Ped = { -- Handy to use as a place to add FinishChopLocation if there is no desk
            Enabled = false,
            PedHash = 'a_m_m_hillbilly_01',
            PedCoords = vector4(727.5610, -1067.5437, 28.31, 180.0),
            PedHeading = 180.0,
            PedAnimation = 'WORLD_HUMAN_AA_SMOKE',
        },

        -- Dispatch 
        Dispatch = false, -- Set to true to enable police alerts when chopping a vehicle
    },

    ['Sandy Shores'] = {   -- Name of the Chop Shop - [MUST BE UNIQUE]
        ChopLocation = vector3(2052.68, 3176.29, 45.17),
        DropPartsLocation = vector3(2048.24, 3196.82, 45.49),
        FinishChopLocation = vec3(2041.43, 3187.44, 45.18),
        ChopZoneRadius = 60.0,
        ChoppingAreaRadius = 30.0,

        -- Tool Locations
        ImpactDriverLocation = vector3(2059.96, 3192.56, 45.19),
        SawLocation = vector3(2048.34, 3200.37, 45.19),

        -- Job Settings
        AllowedJobsOnly = {enabled = false, jobs = {'police', 'ambulance'}},
        BlacklistedJobs = {enabled = true, jobs = {'hobo', 'ambulance'}},

        -- Management Settings
        Ownable = true,
        ManagementLocation = vector3(2041.43, 3187.44, 45.18),
        Price = 75000,
        Percentage = 10,   -- Owner will recieve 10% of the total chop value into management fund
        CanSell = true,    -- Can sell the business to get back % of the original price
        SellPercentage = 50, -- % of the original price you get back when selling the business
        CanTransfer = true, -- Can transfer ownership of the business to another player

        -- Ped Settings (Optional)

        Ped = { -- Handy to use as a place to add FinishChopLocation/ Management if there is no desk
            Enabled = true,
            PedHash = 'a_m_m_hillbilly_01',
            PedCoords = vector3(2041.43, 3187.44, 45.18),
            PedHeading = 250.0,
            PedAnimation = 'WORLD_HUMAN_AA_SMOKE',
        },

        -- Dispatch 
        Dispatch = true, -- Set to true to enable police alerts when chopping a vehicle
    },
}

Config.TargetDistance = 1.2 -- Distance to show the target options

Config.HardcoreMode = true -- Set to true to enable PLAYER OWNED VEHICLE CHOPPING
-- [IMPORTANT - PLEASE READ] -- 
-- [IF NOT USING QB/QBOX OR ESX THIS WILL REQUIRE YOU TO CODE YOUR OWN LOGIC IN THE SERVER_EDIT.LUA FILE FOR CHECKING OWNERSHIP AND IF YOU WANT TO DELETE, OR RETURN THE VEHICLE TO THE IMPOUND ETC ]
-- EDIT envi-chopshop:isVehOwned AND HardcoreChopComplete()

Config.CheckPoliceOnline = false -- Set to true to check if police are online before chopping a vehicle
Config.JobToCheck = 'police' -- Job to check if online
Config.AmountOnline = 1 -- Minimum Amount of that job online before you can chop a vehicle


-- Sound Settings          -- You must have the sound files in your Interact-Sound folder for this to work!
Config.SawVolume = 0.7    -- [0.1 = 10% volume, 1.0 = 100% volume]
Config.ImpactDriverVolume = 0.5


-- NEW --

Config.NativeSounds = true

function SoundEvent(coords, soundFile, volume) -- Change this to your own sound system if you want
    if Config.NativeSounds then
        DoSound(soundFile)
    else
        TriggerServerEvent('InteractSound_SV:PlayOnSource', soundFile, volume)
    end
end

-------------------------------------------------------------------------------------

-- Rewards 
Config.ClassMultipliers = {  -- Reward Multiplier for each vehicle class
    [0] = 1.0, -- Compacts
    [1] = 1.1, -- Sedans
    [2] = 1.2, -- SUVs
    [3] = 1.3, -- Coupes
    [4] = 1.4, -- Muscle
    [5] = 1.5, -- Sports Classics
    [6] = 1.6, -- Sports
    [7] = 1.8, -- Super
    [8] = 0.6, -- Motorcycles
    [9] = 1.2, -- Off-road
    [10] = 1.0, -- Industrial
    [11] = 1.0, -- Utility
    [12] = 1.1, -- Vans
    [13] = 0.4, -- Cycles
    [14] = 1.0, -- Boats
    [15] = 0.0, -- Helicopters
    [16] = 0.0, -- Planes
    [17] = 0.5, -- Service
    [18] = 0.5, -- Emergency
    [19] = 1.0, -- Military
    [20] = 1.0  -- Commercial
}


Config.RewardsAccount = 'cash' -- [QB] - 'cash' or 'bank' or 'crypto' // [ESX] - 'cash' or 'bank' or 'black_money'   -- Go to Server/server_edit.lua to edit the reward functions to your liking if you want to use something else.
Config.Rewards = 1000 -- Base reward for each vehicle - (please keep above 10 for the multiplier to work)
Config.AdditionalRewardsItem = 'cryptostick' -- Item to receive when using item rewards, set to false to disable
Config.AdditionalRewardsAmount = math.random(1,3) -- Amount of item to receive when using item rewards

-- Item Rewards
Config.LootItems = { -- These are recieved when removing batter, scrap, gearboxes and radiators
    'steel',
    'copper',
    'aluminum',
    'metalscrap',
    'plastic',
    'rubber',
    'iron',
    'glass',
    'metalscrap',
}

Config.LootMin = 1 -- Min amount of items to receive
Config.LootMax = 3 -- Max amount of items to receive


-- Optional Advanced Rewards Per Chopping Stage
Config.CarPartsItems = {
    Enabled = false, -- Set to false to disable
    Door = 'car_door',   -- 'item_name'
    Wheels = 'car_wheel',
    Battery = 'car_battery',
    GearBox = 'car_gearbox',
    Radiator = 'car_radiator',
    Scrap = 'car_scrap',
    Hood = 'car_hood',
    Trunk = 'car_trunk',
}


-- Tool Prop Settings
Config.Tools = {
    ImpactDriverProp = { prop = `sf_prop_impact_driver_01a`, offsets = {0.14, -0.14, -0.1, 82.0, -94.0, 155.0} }, -- Impact Driver Prop - (must be in backticks like `prop_name`)
    SawProp = { prop = `prop_tool_consaw`, offsets = {0.09, 0.03, -0.01, -100.64, -158.35, -64.21}}  -- Saw Prop - (must be in backticks like `prop_name`)
}

Config.BlacklistedVehicles = {   -- Add as many as you need (must be in backticks like `spawn_name`)
    `police`,
    `police2`,
    `police3`,
    `taxi`,
    `taxi2`,
    `ambulance`,
    `ambulance2`,
    `firetruk`,
    `sheriff`,
    `sheriff2`,

}


Config.SpecialContractVehicles = {
    -- SUVs
    { model = 'baller', display = 'Gallivanter Baller' },
    { model = 'cavalcade', display = 'Albany Cavalcade' },
    { model = 'dubsta', display = 'Benefactor Dubsta' },
    { model = 'fq2', display = 'Fathom FQ 2' },
    { model = 'granger', display = 'Declasse Granger' },
    { model = 'landstalker', display = 'Dundreary Landstalker' },
    { model = 'rocoto', display = 'Obey Rocoto' },
    { model = 'seminole', display = 'Canis Seminole' },
    { model = 'serrano', display = 'Benefactor Serrano' },

    -- Sports Cars
    { model = 'banshee', display = 'Bravado Banshee' },
    { model = 'buffalo', display = 'Bravado Buffalo' },
    { model = 'carbonizzare', display = 'Grotti Carbonizzare' },
    { model = 'comet', display = 'Pfister Comet' },
    { model = 'coquette', display = 'Invetero Coquette' },
    { model = 'feltzer', display = 'Benefactor Feltzer' },
    { model = 'fusilade', display = 'Schyster Fusilade' },
    { model = 'ninef', display = 'Obey 9F' },
    { model = 'rapidgt', display = 'Dewbauchee Rapid GT' },
    { model = 'schwarzer', display = 'Benefactor Schwartzer' },
    { model = 'sultan', display = 'Karin Sultan' },
    
    -- Supercars and High-End Cars
    { model = 'baller2', display = 'Gallivanter Baller Sport' },
    { model = 'cheetah', display = 'Grotti Cheetah' },
    { model = 'entityxf', display = 'Overflod Entity XF' },
    { model = 'feltzer2', display = 'Benefactor Feltzer' },
    { model = 'infernus', display = 'Pegassi Infernus' },
    { model = 'vacca', display = 'Pegassi Vacca' },
    { model = 'voltic', display = 'Coil Voltic' }
}

Config.DamagePenalty = true -- Set to true to enable a damage penalty for the vehicle

Config.DamageDividers = { -- if DamagePenalty = true - The total payout amount will be divided by the dividedBy value if the vehicle is below the percentHealth health value
    {percentHealth = 30, dividedBy = 2.0},   -- make sure they go in assending order like seen here
    {percentHealth = 40, dividedBy = 1.8},
    {percentHealth = 50, dividedBy = 1.6},
    {percentHealth = 60, dividedBy = 1.4},
    {percentHealth = 70, dividedBy = 1.2},
    {percentHealth = 80, dividedBy = 1.1}
}

-- (Used on battery, scrap, gearboxes and radiators stages - only need to edit if you have vehicles with missing bones)

Config.FrontBones = {
    'engine',
    'bumper_f',
}

Config.BackBones = {
    'engine',
    'bumper_r',
}

 
-- Notifications / Dispatch Functions
function Notify(message, type, time) -- Change this to your own notification system if you want
    lib.notify({                     -- [ox_lib by default]
        id = 'chopshop-notify',
        title = 'Chop Shop',
        description = message,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#909296'
        },
        icon = 'car-burst',
        iconColor = '#C53030',
        length = time
    })
end

function DispatchEvent(coords) 
    exports['ps-dispatch']:SuspiciousActivity() -- Change this to your own dispatch triggers
end

function ShowTextUI(message)
    lib.showTextUI(message)
end

function HideTextUI()
    lib.hideTextUI()
end


-- Language
Config.Lang = {
    -- Marker and Notifications                                                     
    ['chop_vehicle'] = '[E] - Chop Vehicle',
    ['door_stage'] = 'Nice find! First - you\'ll need to remove the doors!',
    ['tire_stage'] = 'Let\'s get started on the tires!',
    ['battery_stage'] = 'Now we need to disconnect the battery!',
    ['gear_box_stage'] = 'Now go ahead and remove the gear box',
    ['rad_stage'] = 'Let\'s get that radiator out!',
    ['scrap_stage'] = 'You think there\'s anything left in there?',
    ['drop_part'] = 'Go drop the parts over there on the trolley!',
    ['cooldown_error'] = 'You need to wait before you can chop another vehicle!',
    ['need_saw'] = 'You need something to chop the door!',
    ['need_impact_driver'] = 'You can\'t unscrew these bolts by hand..',
    ['sell_chop'] = 'Job Done! Head up to the desk and collect your pay!',
    ['owned_vehicle_error'] = 'You can\'t chop an owned vehicle!',

    -- Cooldown Remaining (if ShowTimeRemaining is set to true)
    ['cooldown_left'] = 'Come back in ',
    ['minutes'] = 'minutes',

    -- Rewards
    ['reward_message'] = 'You successfully chopped the vehicle and recieved a payment of $',

    -- Door Names
    ['driver_door'] = 'Driver Door',
    ['passenger_door'] = 'Passenger Door',
    ['back_driver_door'] = 'Back Driver Door',
    ['back_passenger_door'] = 'Back Passenger Door',
    ['hood'] = 'Hood',
    ['trunk'] = 'Trunk',

    -- Tire stage
    ['remove_wheel'] = 'Remove Wheel',
    ['tires_removed'] = 'Tires removed: ',
    ['all_tires_removed'] = 'All tires removed, proceed to the next stage',

    -- Target labels
    ['chop_target'] = 'Chop ',
    ['impact_driver'] = 'Impact Driver',
    ['buzz_saw'] = 'Buzz Saw',
    ['drop_parts'] = 'Drop Parts',
    ['remove_battery'] = 'Remove Battery',
    ['remove_radiator'] = 'Remove Radiator',
    ['remove_scrap'] = 'Remove Scrap',
    ['remove_gear_box'] = 'Remove Gear Box',
    ['sell_chopped_vehicle'] = 'Sell Chopped Vehicle',

    -- Debug Mode
    ['adding_door_target_zones'] = 'Adding door target zones...',
    ['adding_gear_box_target_zone'] = 'Adding gear box target zone...',
    ['adding_rad_target_zone'] = 'Adding raditator target zone...',
    ['adding_battery_target_zones'] = 'Adding battery target zone...',
    ['adding_tire_target_zones'] = 'Adding tire target zones...',
    ['adding_scrap_target_zone'] = 'Adding scrap target zone...',
    ['not_holding_driver'] = 'Not holding impact driver so won\'t check tires removed',
    ['chop_abandoned'] = 'You abandoned the chop!',
    ['own_vehicle_error'] = 'You can\'t chop your own vehicle!',
    ['blacklisted_vehicle'] = 'We can\'t accept this vehicle, sorry!',
    ['not_allowed_job'] = 'Employees only!',
    ['blacklisted_job'] = 'You\'re not allowed to do this!',
    ['no_police'] = 'Not enough Police activity to do this right now!',
    ['manage_shop'] = '[E] - Manage Chop Shop',
    ['not_shop_owner'] = 'This business is owned by somebody else!',
    ['purchase_success'] = 'Congratulations! You are the new owner of ',
    ['purchase_fail'] = 'Purchase Failed!',
    ['withdraw_success'] = 'You have successfully withdrawn $',
    ['withdraw_fail'] = 'Withdrawal Failed!',
    ['sell_success'] = 'Sale Confirmed! You are no longer the owner of ',
    ['sell_fail'] = 'Sale Failed!',
    ['transfer_success'] = 'Successfully transfered ownership of ',
    ['transfer_fail'] = 'Transfer Failed!',
    ['recieved'] =  'You have received $',
    ['from_funds'] = ' from the shop funds.',
    ['completed_contract'] = 'You have completed a contract for ',
    ['recieved_extra'] = ' and received an extra $',
    ['cannot_claim_own'] = 'You cannot vlaim your own vehicle contracts!',
    ['damaged_vehicle'] = 'The total pay-out has been reduced due to vehicle damage!',

    -- NEW 
    ['not_allowed_error'] = 'You are not allowed to do this!',

    -- Management Menu
    ['title'] = 'Chop Shop - ',
    ['forsale'] = ' - [FOR SALE]',
    ['management'] = ' - [MANAGEMENT]',
    ['purchase'] = 'Purchase Business',
    ['price'] = 'Price: $',
    ['withdraw'] = "Withdraw Funds",
    ['funds'] = 'Avaliable Balance: $',
    ['register'] = 'Cash Register',
    ['how_much'] = 'How much would you like to withdraw?',
    ['generate'] = 'Generate Special Contract',
    ['create'] = 'Create a special contract for a specific random vehicle',
    ['sell'] = "Sell Business",
    ['value'] = 'Value: $',
    ['transfer'] = 'Transfer Business',
    ['transfer_desc'] = 'Transfer ownership of this business to another citizen',
    ['transfer_id'] = 'Enter the ID of the player you would like to transfer this business to.',
    ['cannot_generate'] = 'You cannot generate a special contract for another ',
    ['min_cooldown'] = ' minutes',

    -- New in 2.3.5
    ['put_away_weapon'] = 'You cannot pick up an item while holding a weapon!',

}