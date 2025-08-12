fx_version "cerulean"
game "gta5"
version "1.2.1"
lua54 "yes"
author "https://discord.zykeresources.com/"

ui_page "nui/index.html"
-- ui_page "nui_source/hot_reload.html"

files {
    "nui/**/*",
    "locales/*.lua",
    -- "nui_source/hot_reload.html",

    "shared/**/*",
    "client/**/*",
}

-- shared_scripts {
--     "@zyke_lib/imports.lua",
-- }

-- loader {
--     -- Shared
--     "shared/unlocked/config.lua",
--     "shared/unlocked/functions.lua",
--     "shared/locked/animations.lua",
--     "shared/unlocked/main.lua",

--     -- Dependencies
--     "server:@oxmysql/lib/MySQL.lua",

--     -- Server
--     "server/unlocked/database.lua",
--     "server/unlocked/main.lua",
--     "server/locked/main.lua",
--     "server/locked/functions.lua",
--     "server/locked/eventhandler.lua",
--     "server/unlocked/eventhandler.lua",

--     "server/unlocked/cigarette_pack.lua",
--     "server/unlocked/lighter_fluid.lua",

--     -- Client
--     "client/locked/main.lua",
--     "client/locked/functions.lua",
--     "client/locked/eventhandler.lua",
--     "client/unlocked/keys.lua",
--     "client/unlocked/main.lua",
--     "client/unlocked/functions.lua",
--     "client/unlocked/eventhandler.lua",
--     "client/unlocked/utils.lua",

--     "client/locked/using_loops/functions.lua",

--     "client/locked/vape/install_battery.lua",
--     "client/locked/vape/install_capsule.lua",

--     "client/locked/bong/refill_item.lua",
--     "client/locked/bong/refill_water.lua",
-- }

shared_scripts {
    "@zyke_lib/imports.lua",
    "shared/unlocked/config.lua",
    "shared/unlocked/functions.lua",
    "shared/locked/animations.lua",
    "shared/unlocked/main.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",

    "server/unlocked/database.lua",
    "server/unlocked/main.lua",
    "server/locked/main.lua",
    "server/locked/functions.lua",
    "server/locked/eventhandler.lua",
    "server/unlocked/eventhandler.lua",

    "server/unlocked/cigarette_pack.lua",
    "server/unlocked/lighter_fluid.lua",
}

client_scripts {
    "client/locked/main.lua",
    "client/locked/functions.lua",
    "client/locked/eventhandler.lua",
    "client/unlocked/keys.lua",
    "client/unlocked/main.lua",
    "client/unlocked/functions.lua",
    "client/unlocked/eventhandler.lua",
    "client/unlocked/utils.lua",

    "client/locked/using_loops/functions.lua",

    "client/locked/vape/install_battery.lua",
    "client/locked/vape/install_capsule.lua",

    "client/locked/bong/refill_item.lua",
    "client/locked/bong/refill_water.lua",
}

dependency "zyke_lib"
dependency "zyke_sounds"

escrow_ignore {
    "locales/*",
    "client/unlocked/**/*",
    "server/unlocked/**/*",
    "shared/unlocked/**/*",
    "extras/**/*",
}
dependency '/assetpacks'