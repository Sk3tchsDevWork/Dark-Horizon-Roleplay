fx_version "cerulean"
lua54 'yes'

games {"gta5"}

description "Sync Native Execution"

version "1.0.0"

server_script '@np-lib/server/sv_rpc.lua'
client_script '@np-lib/client/cl_rpc.lua'

client_scripts {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}

escrow_ignore {
    'client/*.lua',
    'server/*.lua',
    'tests/*.lua',
}
dependency '/assetpacks'