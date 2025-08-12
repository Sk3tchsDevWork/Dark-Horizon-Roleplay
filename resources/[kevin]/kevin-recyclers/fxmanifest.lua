
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
author 'KevinGirardx'
lua54 'yes'
game 'gta5'

files {
    'locales/*.json',
    'shared/*.lua',
    'utils/client.lua',
    'utils/server.lua',
    'bridge/**/client.lua',
    'bridge/**/server.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    '@Renewed-Lib/init.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server/*.lua',
    'bridge/framework/server.lua',
}

ox_libs {
	'math',
	'locale',
}

-- escrow_ignore { -- none escrow
--     'bridge/**/*.lua',
--     'client/*.lua',
--     'server/*.lua',
--     'utils/*.lua',
--     'locales/*.json',
--     'shared/*.lua',
--     'Sql/*.sql',
-- }

escrow_ignore {
    'bridge/**/*.lua',
    'shared/*.lua',
    'locales/*.json',
    'utils/*.lua',
    'Sql/*.sql',
}
dependency '/assetpacks'