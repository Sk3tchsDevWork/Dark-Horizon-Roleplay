fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

client_scripts {
  "cl_*.lua"
}

server_scripts {
  '@np-lib/server/sv_rpc.lua',
  'server.lua'
}

export "canPullWeaponHoldingEntity"

escrow_ignore {
  '*.lua',
}
dependency '/assetpacks'