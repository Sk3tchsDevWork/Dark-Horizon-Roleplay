-- Resource Metadata
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lunar Scripts'
description 'Illegal Businesses'
version '1.1.3'

-- What to run
escrow_ignore {
    'config/*.lua',
}

dependency {
    'lunar_bridge'
}

files {
    'locales/*.json',
    'web/build/**'
}

ui_page 'web/build/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'init.lua',
    'config/config.lua',
}

client_scripts {
    '@lunar_bridge/framework/esx/client.lua',
    '@lunar_bridge/framework/qb/client.lua',
    'config/cl_edit.lua',
    'client/*.lua',
    'client/ipls/*.lua',
    'client/supplies/*.lua',
    'client/selling/*.lua'
}

server_scripts {
    '@lunar_bridge/framework/esx/server.lua',
    '@lunar_bridge/framework/qb/server.lua',
    '@oxmysql/lib/MySQL.lua',
    'config/sv_config.lua',
    'config/sv_edit.lua',
    'server/*.lua',
    'server/supplies/*.lua',
    'server/selling/*.lua'
}

dependency '/assetpacks'