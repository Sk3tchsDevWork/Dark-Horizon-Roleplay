fx_version "cerulean"
game "gta5"
lua54 "yes"

author "LB"
description "Tablet script for FiveM, made by LB"
website "https://store.lbscripts.com/"
version "1.5.1"

shared_scripts {
    "config/**.lua",
    "shared/**.lua"
}

client_script {
    "lib/client/**.lua",
    "client/**.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "lib/server/**.lua",
    "server/**.lua",
}

files {
    "config/**.json",
    "ui/dist/**/*",

    "ui/components.js",
}

ui_page "ui/dist/index.html"

dependency "oxmysql"

escrow_ignore {
    "lib/**",
    "config/**",
    "shared/**",
    "client/custom/**",
    "server/custom/**",
    "client/apps/custom/**",
    "server/apps/custom/**",
    "server/apiKeys.lua",
    "server/misc/databaseChecker/**",
}

dependency '/assetpacks'