-- Resource Metadata
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lunar Scripts'
description 'Jobs Creator'
version '3.1.1'

-- What to run
escrow_ignore {
    'config/**/*.lua',
}

dependency {
    'lunar_bridge'
}

files {
    'locales/*.json',
    'web/dist/**/*',
}

ui_page 'web/dist/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'init.lua',
    'config/config.lua',
}

client_scripts {
    '@lunar_bridge/framework/esx/client.lua',
    '@lunar_bridge/framework/qb/client.lua',
    'config/cl_edit.lua',
    'client/settings.lua',
    'client/modules/*.lua',
    'client/utils.lua',
    'client/helper.lua',
    'client/main.lua',
    'client/actions.lua',
    'client/actions/cuff.lua',
    'client/actions/drag.lua',
    'client/actions/carry.lua',
    'client/actions/other.lua',
    'client/actions/vehicle.lua',
    'client/actions/tackle.lua',
    'client/consumables.lua',
    'client/ui.lua'
}

server_scripts {
    '@lunar_bridge/framework/esx/server.lua',
    '@lunar_bridge/framework/qb/server.lua',
    '@oxmysql/lib/MySQL.lua',
    'config/sv_config.lua',
    'config/sv_edit.lua',
    'server/webhooks.lua',
    'server/settings.lua',
    'server/modules/*.lua',
    'server/logs.lua',
    'server/parser.lua',
    'server/main.lua',
    'server/history.lua',
    'server/stats.lua',
    'server/actions.lua',
    'server/consumables.lua',
    'server/discord.lua'
}

dependency '/assetpacks'