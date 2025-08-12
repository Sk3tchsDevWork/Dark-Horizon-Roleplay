-- Resource Metadata
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lunar Scripts'
description 'Advanced robbery'
version '1.6.6'

-- What to run
escrow_ignore {
    'config/cl_edit.lua',
    'config/config.lua',
    'config/sv_config.lua'
}

dependency {
    'lunar_bridge'
}

files {
    'locales/*.json'
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
    'client/*.lua',
} 

server_scripts {
    '@lunar_bridge/framework/esx/server.lua',
    '@lunar_bridge/framework/qb/server.lua',
    'config/sv_config.lua',
    'server/*.lua',
} 

dependency '/assetpacks'