Config, Noti, Lang = {}, {}, {}

--  $$$$$$\   $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$\   $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\
-- $$  __$$\ $$  __$$\ $$$\  $$ |$$  _____|\_$$  _|$$  __$$\ $$ |  $$ |$$  __$$\ $$  __$$\\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |
-- $$ /  \__|$$ /  $$ |$$$$\ $$ |$$ |        $$ |  $$ /  \__|$$ |  $$ |$$ |  $$ |$$ /  $$ |  $$ |     $$ |  $$ /  $$ |$$$$\ $$ |
-- $$ |      $$ |  $$ |$$ $$\$$ |$$$$$\      $$ |  $$ |$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$ |  $$ |     $$ |  $$ |  $$ |$$ $$\$$ |
-- $$ |      $$ |  $$ |$$ \$$$$ |$$  __|     $$ |  $$ |\_$$ |$$ |  $$ |$$  __$$< $$  __$$ |  $$ |     $$ |  $$ |  $$ |$$ \$$$$ |
-- $$ |  $$\ $$ |  $$ |$$ |\$$$ |$$ |        $$ |  $$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |  $$ |     $$ |  $$ |  $$ |$$ |\$$$ |
-- \$$$$$$  | $$$$$$  |$$ | \$$ |$$ |      $$$$$$\ \$$$$$$  |\$$$$$$  |$$ |  $$ |$$ |  $$ |  $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |
--  \______/  \______/ \__|  \__|\__|      \______| \______/  \______/ \__|  \__|\__|  \__|  \__|   \______| \______/ \__|  \__|

-- Use "esx", "qb" or "qbox"
Config.Framework = "qb"
-- Set to true to enable debug mode
Config.debug = false
-- Key to get up if sitAndLay is true (default: "X")
Config.KeyToGetUp = 73
-- Set to true to force the player to get up
Config.forceGetUp = true
-- Add the hash of the NPC you want to blacklist
Config.NPCBlacklist = {
    "mp_m_shopkeep_01"
}

-- Check if the player has a weapon from the list

function HasWeapon(ped)
    for _, v in pairs(Config.AllowedWeapons) do
        if HasPedGotWeapon(ped, GetHashKey(v), false) then
            local weapon = v
            return true, weapon
        end
    end
    return false
end

--  $$$$$$\   $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\  $$$$$$\
-- $$  __$$\ $$  __$$\\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |$$  __$$\
-- $$ /  $$ |$$ /  \__|  $$ |     $$ |  $$ /  $$ |$$$$\ $$ |$$ /  \__|
-- $$$$$$$$ |$$ |        $$ |     $$ |  $$ |  $$ |$$ $$\$$ |\$$$$$$\
-- $$  __$$ |$$ |        $$ |     $$ |  $$ |  $$ |$$ \$$$$ | \____$$\
-- $$ |  $$ |$$ |  $$\   $$ |     $$ |  $$ |  $$ |$$ |\$$$ |$$\   $$ |
-- $$ |  $$ |\$$$$$$  |  $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |\$$$$$$  |
-- \__|  \__| \______/   \__|   \______| \______/ \__|  \__| \______/

Actions = {
    sitAndLay = true,
    hidrants = true,
    traffic_lights = true,
    vending_machines = true,
    beach_fire = true,
    phone_booths = true, -- anim
    garbage = true,
    animals = true,
    telescopes = true,
    flat_tires = true,
    kick_trash = true,
    hostage_player = true,
    hostage_npc = true,
    food_trucks = true,
    shoplifting = true,
    carry_things = true,
    barriers = true,
    user_id = true,
    talk_with_npc = true,
    rob_npc = true,
    throw_in_trash = true,
    letterbox = true,
    custom = true
}

-- $$\   $$\  $$$$$$\ $$$$$$$$\ $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\   $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\  $$$$$$\
-- $$$\  $$ |$$  __$$\\__$$  __|\_$$  _|$$  _____|\_$$  _|$$  __$$\ $$  __$$\\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |$$  __$$\
-- $$$$\ $$ |$$ /  $$ |  $$ |     $$ |  $$ |        $$ |  $$ /  \__|$$ /  $$ |  $$ |     $$ |  $$ /  $$ |$$$$\ $$ |$$ /  \__|
-- $$ $$\$$ |$$ |  $$ |  $$ |     $$ |  $$$$$\      $$ |  $$ |      $$$$$$$$ |  $$ |     $$ |  $$ |  $$ |$$ $$\$$ |\$$$$$$\
-- $$ \$$$$ |$$ |  $$ |  $$ |     $$ |  $$  __|     $$ |  $$ |      $$  __$$ |  $$ |     $$ |  $$ |  $$ |$$ \$$$$ | \____$$\
-- $$ |\$$$ |$$ |  $$ |  $$ |     $$ |  $$ |        $$ |  $$ |  $$\ $$ |  $$ |  $$ |     $$ |  $$ |  $$ |$$ |\$$$ |$$\   $$ |
-- $$ | \$$ | $$$$$$  |  $$ |   $$$$$$\ $$ |      $$$$$$\ \$$$$$$  |$$ |  $$ |  $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |\$$$$$$  |
-- \__|  \__| \______/   \__|   \______|\__|      \______| \______/ \__|  \__|  \__|   \______| \______/ \__|  \__| \______/

function notifications(notitype, message, time)
    -- Change this trigger for your notification system keeping the variables
    TriggerEvent("codem-notification", message, time, notitype)
end

-- Notifications types:
Noti.info = "info"
Noti.check = "check"
Noti.error = "error"

-- Notification time:
Noti.time = 5000

--  $$$$$$\ $$$$$$$$\ $$$$$$$\  $$$$$$$$\  $$$$$$\   $$$$$$\
-- $$  __$$\\__$$  __|$$  __$$\ $$  _____|$$  __$$\ $$  __$$\
-- $$ /  \__|  $$ |   $$ |  $$ |$$ |      $$ /  \__|$$ /  \__|
-- \$$$$$$\    $$ |   $$$$$$$  |$$$$$\    \$$$$$$\  \$$$$$$\
--  \____$$\   $$ |   $$  __$$< $$  __|    \____$$\  \____$$\
-- $$\   $$ |  $$ |   $$ |  $$ |$$ |      $$\   $$ |$$\   $$ |
-- \$$$$$$  |  $$ |   $$ |  $$ |$$$$$$$$\ \$$$$$$  |\$$$$$$  |
--  \______/   \__|   \__|  \__|\________| \______/  \______/

--Set to true if you want to use the stress system.
Config.useStress = true

function stress(stressLevel)
    -- If you use any stress system you can add here what is necessary to decrease the stress when the player is seated.
end

-- $$$$$$$$\  $$$$$$\  $$$$$$$\   $$$$$$\  $$$$$$$$\ $$$$$$$$\
-- \__$$  __|$$  __$$\ $$  __$$\ $$  __$$\ $$  _____|\__$$  __|
--    $$ |   $$ /  $$ |$$ |  $$ |$$ /  \__|$$ |         $$ |
--    $$ |   $$$$$$$$ |$$$$$$$  |$$ |$$$$\ $$$$$\       $$ |
--    $$ |   $$  __$$ |$$  __$$< $$ |\_$$ |$$  __|      $$ |
--    $$ |   $$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |         $$ |
--    $$ |   $$ |  $$ |$$ |  $$ |\$$$$$$  |$$$$$$$$\    $$ |
--    \__|   \__|  \__|\__|  \__| \______/ \________|   \__|

Config.Target = "qb-target"

function target(elements, options)
    exports["qb-target"]:AddTargetModel(
        elements,
        {
            options = options,
            distance = 3.0
        }
    )
end

function targetBoxZone(store, options, location)
    exports["qb-target"]:AddBoxZone(
        "store-" .. tonumber(store),
        vector3(location.x, location.y, location.z),
        1.7,
        1.0,
        {
            name = "store-" .. tonumber(store),
            heading = location.w,
            minZ = location.z - 1,
            maxZ = location.z + 1
        },
        {
            options = options,
            distance = 1.5
        }
    )
end

function targetPlayer(options)
    exports["qb-target"]:AddGlobalPlayer(
        {
            options = options,
            distance = 3.0
        }
    )
end

function targetNPC(options)
    exports["qb-target"]:AddGlobalPed(
        {
            options = options,
            distance = 3.0
        }
    )
end

function bones(bones, options)
    exports["qb-target"]:AddTargetBone(
        bones,
        {
            options = options,
            distance = 1
        }
    )
end

-- $$$$$$\ $$\   $$\ $$$$$$$$\ $$$$$$$$\ $$$$$$$\   $$$$$$\   $$$$$$\ $$$$$$$$\
-- \_$$  _|$$$\  $$ |\__$$  __|$$  _____|$$  __$$\ $$  __$$\ $$  __$$\\__$$  __|
--   $$ |  $$$$\ $$ |   $$ |   $$ |      $$ |  $$ |$$ /  $$ |$$ /  \__|  $$ |
--   $$ |  $$ $$\$$ |   $$ |   $$$$$\    $$$$$$$  |$$$$$$$$ |$$ |        $$ |
--   $$ |  $$ \$$$$ |   $$ |   $$  __|   $$  __$$< $$  __$$ |$$ |        $$ |
--   $$ |  $$ |\$$$ |   $$ |   $$ |      $$ |  $$ |$$ |  $$ |$$ |  $$\   $$ |
-- $$$$$$\ $$ | \$$ |   $$ |   $$$$$$$$\ $$ |  $$ |$$ |  $$ |\$$$$$$  |  $$ |
-- \______|\__|  \__|   \__|   \________|\__|  \__|\__|  \__| \______/   \__|

Config.useInteract = true

function interact()
    TriggerEvent("bit-interact:Start", "X", "To get up")
end

--  $$$$$$\  $$$$$$\   $$$$$$\  $$\   $$\  $$$$$$\
-- \_$$  _|$$  __$$\ $$  __$$\ $$$\  $$ |$$  __$$\
--   $$ |  $$ /  \__|$$ /  $$ |$$$$\ $$ |$$ /  \__|
--   $$ |  $$ |      $$ |  $$ |$$ $$\$$ |\$$$$$$\
--   $$ |  $$ |      $$ |  $$ |$$ \$$$$ | \____$$\
--   $$ |  $$ |  $$\ $$ |  $$ |$$ |\$$$ |$$\   $$ |
-- $$$$$$\ \$$$$$$  | $$$$$$  |$$ | \$$ |\$$$$$$  |
-- \______| \______/  \______/ \__|  \__| \______/
Config.icons = {
    sit = "fas fa-chair",
    lay = "fas fa-bed",
    manipulate = "fas fa-hands",
    pistol = "fas fa-gun",
    talk = "fas fa-comment"
}

-- $$\        $$$$$$\  $$\   $$\  $$$$$$\  $$\   $$\  $$$$$$\   $$$$$$\  $$$$$$$$\
-- $$ |      $$  __$$\ $$$\  $$ |$$  __$$\ $$ |  $$ |$$  __$$\ $$  __$$\ $$  _____|
-- $$ |      $$ /  $$ |$$$$\ $$ |$$ /  \__|$$ |  $$ |$$ /  $$ |$$ /  \__|$$ |
-- $$ |      $$$$$$$$ |$$ $$\$$ |$$ |$$$$\ $$ |  $$ |$$$$$$$$ |$$ |$$$$\ $$$$$\
-- $$ |      $$  __$$ |$$ \$$$$ |$$ |\_$$ |$$ |  $$ |$$  __$$ |$$ |\_$$ |$$  __|
-- $$ |      $$ |  $$ |$$ |\$$$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |
-- $$$$$$$$\ $$ |  $$ |$$ | \$$ |\$$$$$$  |\$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$$\
-- \________|\__|  \__|\__|  \__| \______/  \______/ \__|  \__| \______/ \________|

Lang.sitDown = "Sit Down"
Lang.layDown = "Lay Down"
Lang.occupied = "You can't sit here"
Lang.noSeat = "No seat found"
Lang.tilted = "This seat is too tilted"
Lang.tooFar = "You are too far away"
Lang.inVehicle = "First get out of the vehicle to do that"
Lang.manipulate = "Manipulate"
Lang.press = "Press"
Lang.noMoney = "You don't have enough money"
Lang.warmsTheHands = "Warms the hands"
Lang.policeCall = "Call the police"
Lang.ambulanceCall = "Call the ambulance"
Lang.mechanicCall = "Call the mechanic"
Lang.taxiCall = "Call a cab"
Lang.phonePolice = "Phone booth - Person requires police assistance"
Lang.phoneAmbulance = "Phone booth - Person requires medical assistance"
Lang.phoneMechanic = "Phone booth - Person requires mechanical assistance"
Lang.phoneTaxi = "Phone booth - Person requires a taxi"
Lang.dispatchTitle = "Notification"
Lang.dispatchDone = "An alert has been sent to"
Lang.searchInGarbage = "Search in the garbage"
Lang.caress = "Caress"
Lang.use = "Use"
Lang.exitTelescope = "Exit Telescope"
Lang.toFarAway = "You went to far away"
Lang.telescopeInUse = "The telescope is in use"
Lang.flatTire = "Flat Tire"
Lang.noWeapon = "You don't have a weapon to do that"
Lang.alreadyFlat = "This tire is already flat"
Lang.kick = "Kick"
Lang.takeHostage = "Take Hostage"
Lang.hostageOptions = "Press ~r~[G]~w~ to release, ~r~[H]~w~ to execute"
Lang.hostageNoWeapon = "You don't have a gun to take hostages"
Lang.noNPC = "NPC is not near you"
Lang.noPlayersNearby = "No players nearby"
Lang.youAreFree = "You have been freed"
Lang.hostageAlert = "You have been taken hostage!"
Lang.alreadyShoplifted = "You have recently shoplifted"
Lang.steal = "Steal"
Lang.shopliftingAlert = "Shoplifting in progress"
Lang.shopliftingSuccess = "You have successfully shoplifted"
Lang.shopliftingFailed = "You have failed to shoplift"
Lang.carry = "Carry"
Lang.carryStop = "Press ~r~[X]~w~ to stop carrying"
Lang.raiseBarrier = "Raise Barrier"
Lang.showId = "Show ID"
Lang.talkWithNPC = "Talk with NPC"
Lang.robNPC = "Rob NPC"
Lang.robFled = "The victim has fled"
Lang.robbed = "You have robbed"
Lang.currency = "$"
Lang.dontHurtMe = "Please don't hurt me!"
Lang.Blacklist = "You can't do that to this NPC"
Lang.throwInTrash = "Throw in the trash"
Lang.openLetterbox = "Open Letterbox"
Lang.drag = "Drag"
Lang.hostageDispatch = "A criminal has taken a citizen as hostage"
Lang.robNPCDispatch = "A criminal is stealing from a citizen"
Lang.letterBoxCooldown = "You can't do that yet"
Lang.robCooldown = "You can't do that yet"
Lang.garbageCooldown = "You must wait a while to search the trash again"
Lang.deadNPC = "Dead people do not speak"
Lang.deadNPCRob = "You can't rob a dead person"
Lang.hostageDead = "You can't take a dead person hostage"
Lang.noBullet = "You don't have bullets"

-- $$\      $$\ $$\       $$$$$$\
-- $$$\    $$$ |$$ |     $$  __$$\
-- $$$$\  $$$$ |$$ |     $$ /  $$ |
-- $$\$$\$$ $$ |$$ |     $$ |  $$ |
-- $$ \$$$  $$ |$$ |     $$ |  $$ |
-- $$ |\$  /$$ |$$ |     $$ |  $$ |
-- $$ | \_/ $$ |$$$$$$$$\ $$$$$$  |
-- \__|     \__|\________|\______/

-- Set true or false to enable or disable the sit/lay down in the following mlo's
MLO = {
    coroner = true,
    lscustoms = false,
    mrpd = false,
    pacific_standard = false,
    paleto_bank = false,
    paleto_so = false,
    pdm = false,
    sandy_so = false,
    submarine = false,
    tattoo_shops = true,
    tequilala = true,
    trevors_trailer = true,
    vanilla_unicorn = false,
    uniqx_burgershot = false,
    rtx_club77 = false,
    gabz_altruists = false,
    gabz_atom = false,
    gabz_aztecas = false,
    gabz_bahama = false,
    gabz_ballas = false,
    gabz_bennys = false,
    gabz_burgershot = false,
    gabz_catcafe = false,
    gabz_bobcat = false,
    gabz_diner = false,
    gabz_families = false,
    gabz_firedept = false,
    gabz_harmony = false,
    gabz_haters = false,
    gabz_hayes = false,
    gabz_hornys = false,
    gabz_import = false,
    gabz_koi = false,
    gabz_lamesa_pd = false,
    gabz_lostsc = false,
    gabz_lscustoms = false,
    gabz_marabunta = false,
    gabz_mba = false,
    gabz_mrpd = false,
    gabz_paletocamp = false,
    gabz_ottos = false,
    gabz_pacific_standard = false,
    gabz_pacific_standard_old = false,
    gabz_paleto_bank = false,
    gabz_paleto_so = false,
    gabz_park_ranger = false,
    gabz_pdm = false,
    gabz_pillbox = false,
    gabz_pizzeria = false,
    gabz_prison = false,
    gabz_records = false,
    gabz_sandy_so = false,
    gabz_townhall = false,
    gabz_triads = false,
    gabz_tuners = false,
    gabz_vagos = false,
    gabz_vanilla_unicorn = false,
    gabz_weedcamp = false
}

-- $$\    $$\ $$$$$$$$\ $$\   $$\ $$$$$$$\  $$$$$$\ $$\   $$\  $$$$$$\
-- $$ |   $$ |$$  _____|$$$\  $$ |$$  __$$\ \_$$  _|$$$\  $$ |$$  __$$\
-- $$ |   $$ |$$ |      $$$$\ $$ |$$ |  $$ |  $$ |  $$$$\ $$ |$$ /  \__|
-- \$$\  $$  |$$$$$\    $$ $$\$$ |$$ |  $$ |  $$ |  $$ $$\$$ |$$ |$$$$\
--  \$$\$$  / $$  __|   $$ \$$$$ |$$ |  $$ |  $$ |  $$ \$$$$ |$$ |\_$$ |
--   \$$$  /  $$ |      $$ |\$$$ |$$ |  $$ |  $$ |  $$ |\$$$ |$$ |  $$ |
--    \$  /   $$$$$$$$\ $$ | \$$ |$$$$$$$  |$$$$$$\ $$ | \$$ |\$$$$$$  |
--     \_/    \________|\__|  \__|\_______/ \______|\__|  \__| \______/

DrinkMachines = {
    {
        event = "buycola",
        icon = Config.icons.manipulate,
        label = "Buy Cola (10$)",
        price = 10,
        giveItem = "kurkakola"
    },
    {
        event = "buysprunk",
        icon = Config.icons.manipulate,
        label = "Buy Sprunk (10$)",
        price = 10,
        giveItem = "sprunk"
    },
    {
        event = "buywater",
        icon = Config.icons.manipulate,
        label = "Buy water (10$)",
        price = 10,
        giveItem = "water_bottle"
    }
}

CoffeeMachines = {
    {
        event = "buycoffee",
        icon = Config.icons.manipulate,
        label = "Buy coffee (10$)",
        price = 10,
        giveItem = "coffee"
    }
}

WaterMachines = {
    {
        event = "buywater",
        icon = Config.icons.manipulate,
        label = "Buy water (5$)",
        price = 5,
        giveItem = "water_bottle"
    }
}

SnacksMachines = {
    {
        event = "buytwerks",
        icon = Config.icons.manipulate,
        label = "Buy Twerks (10$)",
        price = 10,
        giveItem = "twerks"
    },
    {
        event = "buysnikkel",
        icon = Config.icons.manipulate,
        label = "Buy Snikkel (10$)",
        price = 10,
        giveItem = "snikkel"
    }
}

-- $$$$$$$$\  $$$$$$\   $$$$$$\  $$$$$$$\        $$$$$$$$\ $$$$$$$\  $$\   $$\  $$$$$$\  $$\   $$\  $$$$$$\
-- $$  _____|$$  __$$\ $$  __$$\ $$  __$$\       \__$$  __|$$  __$$\ $$ |  $$ |$$  __$$\ $$ | $$  |$$  __$$\
-- $$ |      $$ /  $$ |$$ /  $$ |$$ |  $$ |         $$ |   $$ |  $$ |$$ |  $$ |$$ /  \__|$$ |$$  / $$ /  \__|
-- $$$$$\    $$ |  $$ |$$ |  $$ |$$ |  $$ |         $$ |   $$$$$$$  |$$ |  $$ |$$ |      $$$$$  /  \$$$$$$\
-- $$  __|   $$ |  $$ |$$ |  $$ |$$ |  $$ |         $$ |   $$  __$$< $$ |  $$ |$$ |      $$  $$<    \____$$\
-- $$ |      $$ |  $$ |$$ |  $$ |$$ |  $$ |         $$ |   $$ |  $$ |$$ |  $$ |$$ |  $$\ $$ |\$$\  $$\   $$ |
-- $$ |       $$$$$$  | $$$$$$  |$$$$$$$  |         $$ |   $$ |  $$ |\$$$$$$  |\$$$$$$  |$$ | \$$\ \$$$$$$  |
-- \__|       \______/  \______/ \_______/          \__|   \__|  \__| \______/  \______/ \__|  \__| \______/

FoodTrucks = {
    {
        event = "buyhotdog",
        icon = Config.icons.manipulate,
        label = "Buy Hot Dog (10$)",
        price = 10,
        giveItem = "hotdog"
    },
    {
        event = "buyhamburger",
        icon = Config.icons.manipulate,
        label = "Buy Hamburger (10$)",
        price = 10,
        giveItem = "hamburger"
    },
    {
        event = "buysandwich",
        icon = Config.icons.manipulate,
        label = "Buy Sandwich (10$)",
        price = 10,
        giveItem = "sandwich"
    }
}

-- $$$$$$$\  $$$$$$\  $$$$$$\  $$$$$$$\   $$$$$$\ $$$$$$$$\  $$$$$$\  $$\   $$\
-- $$  __$$\ \_$$  _|$$  __$$\ $$  __$$\ $$  __$$\\__$$  __|$$  __$$\ $$ |  $$ |
-- $$ |  $$ |  $$ |  $$ /  \__|$$ |  $$ |$$ /  $$ |  $$ |   $$ /  \__|$$ |  $$ |
-- $$ |  $$ |  $$ |  \$$$$$$\  $$$$$$$  |$$$$$$$$ |  $$ |   $$ |      $$$$$$$$ |
-- $$ |  $$ |  $$ |   \____$$\ $$  ____/ $$  __$$ |  $$ |   $$ |      $$  __$$ |
-- $$ |  $$ |  $$ |  $$\   $$ |$$ |      $$ |  $$ |  $$ |   $$ |  $$\ $$ |  $$ |
-- $$$$$$$  |$$$$$$\ \$$$$$$  |$$ |      $$ |  $$ |  $$ |   \$$$$$$  |$$ |  $$ |
-- \_______/ \______| \______/ \__|      \__|  \__|  \__|    \______/ \__|  \__|

Config.policejob = "police"
Config.ambulancejob = "ambulance"
Config.mechanicjob = "mechanic"
Config.taxijob = "taxi"

function dispatch(job, title, message)
    -- Example with cd_dispatch:
    --[[ local data = exports["cd_dispatch"]:GetPlayerInfo()
    TriggerServerEvent(
        "cd_dispatch:AddNotification",
        {
            job_table = {job},
            coords = data.coords,
            title = title,
            message = "Requires assistance " .. data.street,
            flash = 0,
            unique_id = tostring(math.random(0000000, 9999999)),
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = message,
                time = 5,
                sound = 1
            }
        }
    ) ]]
    notifications(Noti.info, Lang.dispatchDone .. " " .. job, Noti.time)
end

--  $$$$$$\   $$$$$$\  $$$$$$$\  $$$$$$$\   $$$$$$\   $$$$$$\  $$$$$$$$\
-- $$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  _____|
-- $$ /  \__|$$ /  $$ |$$ |  $$ |$$ |  $$ |$$ /  $$ |$$ /  \__|$$ |
-- $$ |$$$$\ $$$$$$$$ |$$$$$$$  |$$$$$$$\ |$$$$$$$$ |$$ |$$$$\ $$$$$\
-- $$ |\_$$ |$$  __$$ |$$  __$$< $$  __$$\ $$  __$$ |$$ |\_$$ |$$  __|
-- $$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |
-- \$$$$$$  |$$ |  $$ |$$ |  $$ |$$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$$\
--  \______/ \__|  \__|\__|  \__|\_______/ \__|  \__| \______/ \________|

-- Max number of slots in the trash inventory
Config.throwInTrashSize = 15

Config.searchInGarbageCooldown = 30 -- seconds

function generateStash(trashId)
    if Config.Framework == "esx" then
        local playerID = GetPlayerServerId(PlayerId())
        TriggerServerEvent("bit-interactivecity:registerStash", trashId)
        TriggerEvent("ox_inventory:openInventory", "stash", trashId)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", trashId)
        TriggerEvent("inventory:client:SetCurrentStash", trashId)
    end
end

GarbageAmount = {
    min = 1,
    max = 5
}

RandomItems = {
    "cigarette",
    "chain",
    "rope",
    "tech_parts",
    "spring",
    "rubber",
    "brokenknife",
    "lighter"
}

-- $$$$$$$$\ $$\        $$$$$$\ $$$$$$$$\       $$$$$$$$\ $$$$$$\ $$$$$$$\  $$$$$$$$\  $$$$$$\
-- $$  _____|$$ |      $$  __$$\\__$$  __|      \__$$  __|\_$$  _|$$  __$$\ $$  _____|$$  __$$\
-- $$ |      $$ |      $$ /  $$ |  $$ |            $$ |     $$ |  $$ |  $$ |$$ |      $$ /  \__|
-- $$$$$\    $$ |      $$$$$$$$ |  $$ |            $$ |     $$ |  $$$$$$$  |$$$$$\    \$$$$$$\
-- $$  __|   $$ |      $$  __$$ |  $$ |            $$ |     $$ |  $$  __$$< $$  __|    \____$$\
-- $$ |      $$ |      $$ |  $$ |  $$ |            $$ |     $$ |  $$ |  $$ |$$ |      $$\   $$ |
-- $$ |      $$$$$$$$\ $$ |  $$ |  $$ |            $$ |   $$$$$$\ $$ |  $$ |$$$$$$$$\ \$$$$$$  |
-- \__|      \________|\__|  \__|  \__|            \__|   \______|\__|  \__|\________| \______/

Config.allowedWeapons = {
    "WEAPON_DAGGER",
    "WEAPON_BOTTLE",
    "WEAPON_HATCHET",
    "WEAPON_SWITCHBLADE",
    "WEAPON_MACHETE",
    "WEAPON_KNIFE"
}

-- This function checks if the player has a weapon from the list
CanUseWeapon = function(allowedWeapons)
    local plyPed = PlayerPedId()
    local plyCurrentWeapon = GetSelectedPedWeapon(plyPed)
    for i = 1, #allowedWeapons do
        if Config.Framework == "esx" then
            local weaponHash = GetHashKey(allowedWeapons[i])
            if weaponHash == plyCurrentWeapon then
                return true
            end
        else
            if allowedWeapons[i] == plyCurrentWeapon then
                return true
            end
        end
    end
    return false
end

-- $$\   $$\  $$$$$$\   $$$$$$\ $$$$$$$$\  $$$$$$\   $$$$$$\  $$$$$$$$\  $$$$$$\
-- $$ |  $$ |$$  __$$\ $$  __$$\\__$$  __|$$  __$$\ $$  __$$\ $$  _____|$$  __$$\
-- $$ |  $$ |$$ /  $$ |$$ /  \__|  $$ |   $$ /  $$ |$$ /  \__|$$ |      $$ /  \__|
-- $$$$$$$$ |$$ |  $$ |\$$$$$$\    $$ |   $$$$$$$$ |$$ |$$$$\ $$$$$\    \$$$$$$\
-- $$  __$$ |$$ |  $$ | \____$$\   $$ |   $$  __$$ |$$ |\_$$ |$$  __|    \____$$\
-- $$ |  $$ |$$ |  $$ |$$\   $$ |  $$ |   $$ |  $$ |$$ |  $$ |$$ |      $$\   $$ |
-- $$ |  $$ | $$$$$$  |\$$$$$$  |  $$ |   $$ |  $$ |\$$$$$$  |$$$$$$$$\ \$$$$$$  |
-- \__|  \__| \______/  \______/   \__|   \__|  \__| \______/ \________| \______/

Config.hostageAllowedWeapons = {
    "WEAPON_PISTOL",
    "WEAPON_COMBATPISTOL",
    "WEAPON_GLOCK",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_SNSPISTOL",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_APPISTOL"
}

Config.hostageNPCUseDispatch = false

--  $$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$\  $$\       $$$$$$\ $$$$$$$$\ $$$$$$$$\ $$$$$$\ $$\   $$\  $$$$$$\
-- $$  __$$\ $$ |  $$ |$$  __$$\ $$  __$$\ $$ |      \_$$  _|$$  _____|\__$$  __|\_$$  _|$$$\  $$ |$$  __$$\
-- $$ /  \__|$$ |  $$ |$$ /  $$ |$$ |  $$ |$$ |        $$ |  $$ |         $$ |     $$ |  $$$$\ $$ |$$ /  \__|
-- \$$$$$$\  $$$$$$$$ |$$ |  $$ |$$$$$$$  |$$ |        $$ |  $$$$$\       $$ |     $$ |  $$ $$\$$ |$$ |$$$$\
--  \____$$\ $$  __$$ |$$ |  $$ |$$  ____/ $$ |        $$ |  $$  __|      $$ |     $$ |  $$ \$$$$ |$$ |\_$$ |
-- $$\   $$ |$$ |  $$ |$$ |  $$ |$$ |      $$ |        $$ |  $$ |         $$ |     $$ |  $$ |\$$$ |$$ |  $$ |
-- \$$$$$$  |$$ |  $$ | $$$$$$  |$$ |      $$$$$$$$\ $$$$$$\ $$ |         $$ |   $$$$$$\ $$ | \$$ |\$$$$$$  |
--  \______/ \__|  \__| \______/ \__|      \________|\______|\__|         \__|   \______|\__|  \__| \______/

-- Percentage chance to succeded in stealing something in the store
Config.chance = 90
-- Cooldown time in minutes
Config.shopLiftCooldown = 1
-- Police alert
Config.policeAlertChance = 0.5

StoresLocations = {
    [1] = vector4(30.94, -1345.33, 29.51, 271.66),
    [2] = vector4(28.21, -1345.191, 29.51, 271.66),
    [3] = vector4(-709.75, -912.34, 19.26, 131.63),
    [4] = vector4(-713.7043, -913.0905, 19.28019, 131.63),
    [5] = vector4(-712.2653, -911.6414, 19.2957, 131.63),
    [6] = vector4(-715.6313, -911.6693, 19.29983, 131.63)
}

Config.shopliftAmount = {
    min = 1,
    max = 5
}

ShopliftingItems = {
    "water_bottle"
}

--  $$$$$$\   $$$$$$\  $$$$$$$\  $$$$$$$\ $$\     $$\
-- $$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\\$$\   $$  |
-- $$ /  \__|$$ /  $$ |$$ |  $$ |$$ |  $$ |\$$\ $$  /
-- $$ |      $$$$$$$$ |$$$$$$$  |$$$$$$$  | \$$$$  /
-- $$ |      $$  __$$ |$$  __$$< $$  __$$<   \$$  /
-- $$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |  $$ |   $$ |
-- \$$$$$$  |$$ |  $$ |$$ |  $$ |$$ |  $$ |   $$ |
--  \______/ \__|  \__|\__|  \__|\__|  \__|   \__|

-- If you want to see the xOffset, yOffset, zOffset, xRot, yRot, zRot of the entity you are carrying
-- and use keys to edit the positions and rotations, set this to true.
-- More info: https://docs.bit-code.dev/
Config.carryDebug = false

carryEntities = {
    [1395334609] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 0.88,
        yOffset = -0.16,
        zOffset = 0.01,
        xRot = -1082.0,
        yRot = 114.0,
        zRot = 120.0
    },
    [-1386777370] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 0.87,
        yOffset = -0.62,
        zOffset = 0.37,
        xRot = -18.0,
        yRot = 112.0,
        zRot = 128.0
    },
    [1679057497] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 0.87,
        yOffset = -0.62,
        zOffset = 0.37,
        xRot = -18.0,
        yRot = 112.0,
        zRot = 128.0
    },
    [-1601152168] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 0.87,
        yOffset = -0.62,
        zOffset = 0.37,
        xRot = -18.0,
        yRot = 112.0,
        zRot = 128.0
    },
    -- Cones
    [862664990] = {
        dict = nil,
        anim = nil,
        xOffset = 0.71,
        yOffset = -0.16,
        zOffset = -0.04,
        xRot = -80.0,
        yRot = 56.0,
        zRot = 128.0
    },
    [-534360227] = {
        dict = nil,
        anim = nil,
        xOffset = 0.71,
        yOffset = -0.16,
        zOffset = -0.04,
        xRot = -80.0,
        yRot = 56.0,
        zRot = 128.0
    },
    [1839621839] = {
        dict = nil,
        anim = nil,
        xOffset = 0.71,
        yOffset = -0.16,
        zOffset = -0.04,
        xRot = -80.0,
        yRot = 56.0,
        zRot = 128.0
    },
    -- wheel
    [-1570565546] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 0.10,
        yOffset = 0.22,
        zOffset = -0.29,
        xRot = -194.0,
        yRot = 42.0,
        zRot = 128.0
    },
    --bin
    [-1096777189] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 0.76,
        yOffset = -0.92,
        zOffset = 0.18,
        xRot = -1098.0,
        yRot = 104.0,
        zRot = 108.0
    },
    --shopping cart
    [-230045366] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 0.83,
        yOffset = -0.25,
        zOffset = 0.08,
        xRot = -1090.0,
        yRot = 110.0,
        zRot = 114.0
    },
    -- oil can
    [-276344022] = {
        dict = nil,
        anim = nil,
        xOffset = 0.34,
        yOffset = -0.07,
        zOffset = -0.05,
        xRot = -460.0,
        yRot = 66.0,
        zRot = 134.0
    },
    [-1532806025] = {
        dict = nil,
        anim = nil,
        xOffset = 0.34,
        yOffset = -0.07,
        zOffset = -0.05,
        xRot = -460.0,
        yRot = 66.0,
        zRot = 134.0
    },
    --boombox
    [1729911864] = {
        dict = nil,
        anim = nil,
        xOffset = 0.28,
        yOffset = -0.09,
        zOffset = 0.00,
        xRot = -460.0,
        yRot = 66.0,
        zRot = 134.0
    },
    -- beach ring
    [1677315747] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 0.30,
        yOffset = 0.05,
        zOffset = -0.27,
        xRot = -194.0,
        yRot = 42.0,
        zRot = 128.0
    },
    --surf board
    [-105032410] = {
        dict = nil,
        anim = nil,
        xOffset = 0.28,
        yOffset = -0.09,
        zOffset = 0.00,
        xRot = -460.0,
        yRot = 66.0,
        zRot = 134.0
    },
    --flat truck
    [531440379] = {
        dict = "anim@heists@box_carry@",
        anim = "idle",
        xOffset = 1.27,
        yOffset = -0.65,
        zOffset = 0.40,
        xRot = -1094.0,
        yRot = 116.0,
        zRot = 120.0
    }
}

-- $$\   $$\ $$$$$$$\   $$$$$$\        $$$$$$$$\  $$$$$$\  $$\       $$\   $$\
-- $$$\  $$ |$$  __$$\ $$  __$$\       \__$$  __|$$  __$$\ $$ |      $$ | $$  |
-- $$$$\ $$ |$$ |  $$ |$$ /  \__|         $$ |   $$ /  $$ |$$ |      $$ |$$  /
-- $$ $$\$$ |$$$$$$$  |$$ |               $$ |   $$$$$$$$ |$$ |      $$$$$  /
-- $$ \$$$$ |$$  ____/ $$ |               $$ |   $$  __$$ |$$ |      $$  $$<
-- $$ |\$$$ |$$ |      $$ |  $$\          $$ |   $$ |  $$ |$$ |      $$ |\$$\
-- $$ | \$$ |$$ |      \$$$$$$  |         $$ |   $$ |  $$ |$$$$$$$$\ $$ | \$$\
-- \__|  \__|\__|       \______/          \__|   \__|  \__|\________|\__|  \__|

NPCphrases = {
    "What's up, buddy?",
    "You need something?",
    "Hey, watch where you're walking!",
    "What are you up to?",
    "This neighborhood's dangerous, you know?",
    "Hey, can i help you with something?",
    "Have you seen a guy in a black jacket?",
    "You come looking for trouble?",
    "Life in Los Santos is not easy",
    "Interested in some business?",
    "You know where I can find some good weed?",
    "You got a light?",
    "Hey, don't mess with me!",
    "You don't see many people like you around here",
    "What brings you here?",
    "If you're looking for trouble, you're going to find it",
    "Do you like it here?",
    "I don't get in trouble, do you?",
    "Do you have any plans for today?",
    "This place is total chaos",
    "Are you new around here?",
    "The police are everywhere lately",
    "Watch your back!",
    "You come from Vinewood?",
    "Business is tough these days",
    "If you need anything, just ask",
    "Sometimes I miss the quiet of the country",
    "Have you heard the latest rumors?",
    "Watch out for gangs, they're everywhere",
    "You never know what awaits you in this town",
    "Looking for a thrill?",
    "There's more crime here than in an action movie",
    "You better not mess with the wrong people",
    "The streets aren't safe at night",
    "Are you coming alone or with someone?",
    "Traffic is impossible today",
    "Have you tried the tacos here?",
    "There is a good place to have fun near here",
    "The nightlife in Los Santos is amazing"
}

-- $$$$$$$\   $$$$$$\  $$$$$$$\        $$\   $$\ $$$$$$$\   $$$$$$\
-- $$  __$$\ $$  __$$\ $$  __$$\       $$$\  $$ |$$  __$$\ $$  __$$\
-- $$ |  $$ |$$ /  $$ |$$ |  $$ |      $$$$\ $$ |$$ |  $$ |$$ /  \__|
-- $$$$$$$  |$$ |  $$ |$$$$$$$\ |      $$ $$\$$ |$$$$$$$  |$$ |
-- $$  __$$< $$ |  $$ |$$  __$$\       $$ \$$$$ |$$  ____/ $$ |
-- $$ |  $$ |$$ |  $$ |$$ |  $$ |      $$ |\$$$ |$$ |      $$ |  $$\
-- $$ |  $$ | $$$$$$  |$$$$$$$  |      $$ | \$$ |$$ |      \$$$$$$  |
-- \__|  \__| \______/ \_______/       \__|  \__|\__|       \______/

-- Cooldown time in seconds | Default 300 = 5 minutes
Config.cooldown = 300
-- "money" or "item"
Config.giveMoneyOrItem = "money"
-- Set to true if you want to use dispatch
Config.robNPCUseDispatch = false

-- Random item to rob
RobItem = {
    "lighter",
    "cola"
}
-- Random money amount to rob
RobMoney = {
    min = 100,
    max = 500
}

-- $$\       $$$$$$$$\ $$$$$$$$\ $$$$$$$$\ $$$$$$$$\ $$$$$$$\        $$$$$$$\   $$$$$$\  $$\   $$\
-- $$ |      $$  _____|\__$$  __|\__$$  __|$$  _____|$$  __$$\       $$  __$$\ $$  __$$\ $$ |  $$ |
-- $$ |      $$ |         $$ |      $$ |   $$ |      $$ |  $$ |      $$ |  $$ |$$ /  $$ |\$$\ $$  |
-- $$ |      $$$$$\       $$ |      $$ |   $$$$$\    $$$$$$$  |      $$$$$$$\ |$$ |  $$ | \$$$$  /
-- $$ |      $$  __|      $$ |      $$ |   $$  __|   $$  __$$<       $$  __$$\ $$ |  $$ | $$  $$<
-- $$ |      $$ |         $$ |      $$ |   $$ |      $$ |  $$ |      $$ |  $$ |$$ |  $$ |$$  /\$$\
-- $$$$$$$$\ $$$$$$$$\    $$ |      $$ |   $$$$$$$$\ $$ |  $$ |      $$$$$$$  | $$$$$$  |$$ /  $$ |
-- \________|\________|   \__|      \__|   \________|\__|  \__|      \_______/  \______/ \__|  \__|

Config.letterBoxItems = {
    "water"
}

-- Cooldown time in seconds | Default 30 seconds
Config.cooldownLetterBox = 30

Config.letterBoxItemsAmount = {
    min = 1,
    max = 5
}

--  $$$$$$\  $$\   $$\  $$$$$$\ $$$$$$$$\  $$$$$$\  $$\      $$\
-- $$  __$$\ $$ |  $$ |$$  __$$\\__$$  __|$$  __$$\ $$$\    $$$ |
-- $$ /  \__|$$ |  $$ |$$ /  \__|  $$ |   $$ /  $$ |$$$$\  $$$$ |
-- $$ |      $$ |  $$ |\$$$$$$\    $$ |   $$ |  $$ |$$\$$\$$ $$ |
-- $$ |      $$ |  $$ | \____$$\   $$ |   $$ |  $$ |$$ \$$$  $$ |
-- $$ |  $$\ $$ |  $$ |$$\   $$ |  $$ |   $$ |  $$ |$$ |\$  /$$ |
-- \$$$$$$  |\$$$$$$  |\$$$$$$  |  $$ |    $$$$$$  |$$ | \_/ $$ |
--  \______/  \______/  \______/   \__|    \______/ \__|     \__|

customEntities = {
    [-639994124] = {
        -- Prop hash
        options = {
            {
                icon = Config.icons.manipulate, -- Icon for the target option
                label = "Custom", -- Label for the target option
                action = function(entity)
                    if DoesEntityExist(entity) then
                    -- Do something with the entity

                    --[[ 
                        Example:
                        loadAnimation("mini@repair")
                        TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 4.0, 1.0, -1, 49, 0, 0, 0, 0)
                        Citizen.Wait(5000)
                        ClearPedTasks(PlayerPedId()) ]]
                    end
                end
            }
        }
    }
}

--  $$$$$$\  $$$$$$\ $$$$$$$$\
-- $$  __$$\ \_$$  _|\__$$  __|
-- $$ /  \__|  $$ |     $$ |
-- \$$$$$$\    $$ |     $$ |
--  \____$$\   $$ |     $$ |
-- $$\   $$ |  $$ |     $$ |
-- \$$$$$$  |$$$$$$\    $$ |
-- \______/ \______|   \__|

customProps = {
    [1626425496] = {
        sit = {
            type = "chair2", -- Can use chair, chair2, chair3, deck, barstool, stool, sunlounger, barber, wall, sitground, tattoo, strip_watch
            teleportIn = true,
            seats = {
                [1] = vector4(-0.25, 0.0, 0.2, 90.0),
                [2] = vector4(0.25, 0.0, 0.2, 270.0)
            }
        },
        lay = {
            type = "bed", -- Can use layside_reverse, layside, bed, lay, medical
            teleportIn = true,
            seats = {
                [1] = vector4(0.0, 0.0, 0.2, 180.0)
            }
        }
    }
}

customMLO = {
    ["custom_mlo"] = {
        enabled = false,
        center = vector3(1854.98, 3686.48, 34.0),
        radius = 15.0,
        polys = {
            ["mlo_chair1"] = {
                sit = {
                    type = "chair2",
                    seats = {
                        [1] = vector4(1858.59, 3689.30, 33.85, 120.0)
                    }
                },
                poly = {
                    center = vector3(1858.59, 3689.30, 33.9),
                    length = 0.75,
                    width = 0.75,
                    height = 1.0
                }
            },
            ["mlo_chair2"] = {
                sit = {
                    type = "chair2",
                    seats = {
                        [1] = vector4(1856.56, 3685.03, 33.85, 30.0)
                    }
                },
                poly = {
                    center = vector3(1856.56, 3685.03, 33.9),
                    length = 0.75,
                    width = 0.75,
                    height = 1.0
                }
            }
        }
    }
}
