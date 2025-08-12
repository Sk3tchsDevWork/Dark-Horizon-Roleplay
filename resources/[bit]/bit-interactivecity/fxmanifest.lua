fx_version "cerulean"
game "gta5"
lua54 "yes"

author "bitc0de"

client_scripts {
    "shared.lua",
    "client/main.lua",
    "client/data.lua",
    "client/utils.lua",
    "client/actions/*",
    "client/events/*"
}

server_scripts {
    "version.lua",
    "shared.lua",
    "sconfig.lua",
    "server/actions/*",
    "server/main.lua"
}

escrow_ignore {
    "shared.lua",
    "sconfig.lua"
}

lua54 "yes"

dependency '/assetpacks'