author 'Envi-Scripts'
fx_version 'cerulean'

game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

version '2.2.0' -- The True Hobo Edition

client_scripts {
    'client/*.lua',
}
shared_scripts {
    '@envi-bridge/bridge.lua',
	'shared/*.lua',
}

server_scripts {
    'server/*.lua',
}

escrow_ignore {
    'shared/*.lua',
    'client/client_edit.lua',
}

dependencies {
    'envi-bridge',
    'envi-interact',
}

bridge 'envi-bridge'

-- bridge_disable { 'target' } -- UNCOMMENT THIS IF YOU DO NOT HAVE A TARGET RESOURCE INSTALLED AND WANT TO USE ENVI-INTERACT'S 0.00MS PRESS E SYSTEM INSTEAD - ALSO MAKE SURE TO SET CONFIG.TARGET TO FALSE IN v2-config.lua
dependency '/assetpacks'