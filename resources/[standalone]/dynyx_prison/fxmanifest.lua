fx_version 'cerulean'
game 'gta5'

name "dynyx_prison"
description "Advanced Prison Script"
author "Green"
version "1.3"

lua54 'yes'

shared_scripts {
	"@ox_lib/init.lua",
	"config.lua",
	'locales/*.lua',
}

client_scripts {
	'client/main.lua',
	'client/prison/comserv.lua',
	'client/prison/prisonjobs.lua',
	'client/prison/prisonshops.lua',
	'client/prison/jailbreak.lua',
	-- Jobs
	'client/jobs/electricianjob.lua',
	'client/jobs/cleancells.lua',
	'client/jobs/repairfacility.lua',
	'client/jobs/moveboxes.lua',

	-- Open Source
	'opensource/client/client.lua',
	'opensource/client/functions.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'server/main.lua',
	'opensource/server/server.lua'

}

ui_page 'dist/index.html'

files {
    'dist/index.html',
    'dist/assets/*.js',
    'dist/assets/*.css',
}

escrow_ignore {
    'config.lua',
    'locales/*.lua',
    'opensource/client/*.lua',
    'opensource/server/*.lua',
}

dependency '/assetpacks'