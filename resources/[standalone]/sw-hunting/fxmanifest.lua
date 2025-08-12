name 'SW-Hunting'
author 'SH4UN'
version '2.0'
description 'Hunting Script'
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
	'locales/*.lua',
	'@ox_lib/init.lua'
}

lua54 'yes'

escrow_ignore {
	'config.lua',
	'README.md',
	'locales/*.lua'
}

dependencies {
	'sw_lib',
	'ox_lib'
}
dependency '/assetpacks'