fx_version 'cerulean'
game 'gta5'

name "dynyx_crafting"
description "Crafting Script by Dynyx"
author "Dynyx Scripts"
version "1.9.2"

lua54 'yes'

shared_scripts {
    "@ox_lib/init.lua",
    "config.lua",
    'locales/*.lua',
}

client_scripts {
    'client/main.lua',
    'client/open.lua',
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server/main.lua',
    'server/open.lua',
}

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/assets/*.js',
    'web/dist/assets/*.css',
}

escrow_ignore {
    'config.lua',
    'README.md',
    'client/open.lua',
    'server/open.lua',
    'locales/*.lua',
}


dependency '/assetpacks'