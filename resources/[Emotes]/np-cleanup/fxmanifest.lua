fx_version 'cerulean'
games {'gta5'}

lua54 'yes'
client_script "@np-sync/client/lib.lua"

client_script 'client.lua'

server_script 'server.lua'


escrow_ignore {
    '*.lua',
}
dependency '/assetpacks'