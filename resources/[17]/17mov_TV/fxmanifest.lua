fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Malizniak - 17 Movement | 17mov.pro"

shared_script "config.lua"
server_script "server/server.lua"
server_script "@oxmysql/lib/MySQL.lua"
client_script "client/functions.lua"
client_script "client/target.lua"
client_script "client/player.js"
client_script "client/client.lua"

ui_page 'html/index.html'

files {
	'html/**/**.*',
}

escrow_ignore {
	"config.lua",
	"client/functions.lua",
	"client/target.lua",
}
dependency '/assetpacks'