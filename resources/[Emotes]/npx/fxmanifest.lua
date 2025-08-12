fx_version "cerulean"

games { "gta5" }
lua54 'yes'

description "Atlas Library"

version "0.1.0"

server_scripts {
    "server/*.js",
}

client_scripts {
    "client/*.js",
}

shared_scripts {
    "shared/*.*",
}

exports {
    'GetLibrary',
}


escrow_ignore {
    'client/*.lua',
	'server/*.lua',
	'shared/*.lua',
}
dependency '/assetpacks'