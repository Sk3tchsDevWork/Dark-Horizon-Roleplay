name 'SW_Lib'
author 'SH4UN'
version '1.1'
description 'SW-Scripts Code Library Script'
fx_version 'cerulean'
game 'gta5'

client_scripts {
	'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
    'config.lua',
	'shared/*.lua',
	'@ox_lib/init.lua'
}

lua54 'yes'

escrow_ignore {
	'config.lua',
	'client/client.lua',
	'shared/shared.lua',
	'server/server.lua',
	'README.md'
}

dependencies {
	'ox_lib'
}
dependency '/assetpacks'