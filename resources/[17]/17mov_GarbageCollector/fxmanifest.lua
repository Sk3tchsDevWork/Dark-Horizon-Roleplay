fx_version "cerulean"
game "gta5"
author "Malizniak - 17Movement"
lua54 "yes"
version "4.0.7"
this_is_a_map 'yes'

shared_scripts {
    "shared/locale.lua",
    "locale/*.lua",
    "Config.lua",
    "shared/core.lua",
}

server_scripts {
    "server/core.lua",
    "server/functions.lua",
    "server/server.lua",
}

client_scripts {
    "client/core.lua",
    "client/functions.lua",
    "client/target.lua",
    "client/client.lua",
}

ui_page "web/driver.html"
files {
    "web/**/*.**",
    "web/*.**",
}

escrow_ignore {
    "Config.lua",
    "client/target.lua",
    "client/functions.lua",
    "server/functions.lua",
    "stream/*.**",
    "locale/*.**",
}

dependency '/assetpacks'