fx_version 'cerulean'
game 'gta5'

author 'Multy'
description 'Multy Admin - Advanced admin menu for QB-Core framework'
version '1.2.0'

escrow_ignore {
    'ui/**',
    'server/webhooks.lua',
    'config.lua',
    'translations.lua'
}

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua',
    'translations.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/inventory.lua',
    'server/bans.lua',
    'server/main.lua',
    'server/webhooks.lua',
    'server/reports.lua',
    'server/admin_chat.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js'
}

dependencies {
    'qb-core'
}

lua54 'yes'
dependency '/assetpacks'