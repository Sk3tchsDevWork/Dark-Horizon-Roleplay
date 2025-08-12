-- Resource Metadata
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lunar Scripts'
description 'Advanced Reports'
version '1.1.1'

-- What to run
escrow_ignore {
    'config/config.lua',
    'config/sv_config.lua',
    'config/sv_edit.lua'
}

dependency {
    'lunar_bridge'
}

ui_page 'web/build/index.html'

files {
    'locales/*.json',
    'web/build/index.html',
    'web/build/**/*'
}

shared_scripts {
    '@ox_lib/init.lua',
    'init.lua',
    'config/config.lua',
}

client_scripts {
    '@lunar_bridge/framework/esx/client.lua',
    '@lunar_bridge/framework/qb/client.lua',
    'config/cl_edit.lua',
    'client/*.lua'
}

server_scripts {
    '@lunar_bridge/framework/esx/server.lua',
    '@lunar_bridge/framework/qb/server.lua',
    '@oxmysql/lib/MySQL.lua',
    'config/sv_config.lua',
    'config/sv_edit.lua',
    'server/*.lua'
}

dependency '/assetpacks'