fx_version "cerulean"
lua54 'yes'

games {"gta5"}

description "Lib"

server_scripts {
	"**/sv_*.lua",
	"**/sv_*.js"
}

client_scripts {
	"**/cl_*.lua",
	"**/cl_*.js"
}

shared_script '**/sh_*.*'

escrow_ignore {
    'client/*.lua',
	'server/*.lua',
	'shared/*.lua',
}
dependency '/assetpacks'