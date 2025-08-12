fx_version 'adamant'
games { 'gta5' }

mod 'QB AP ADDONJOB'
version '1.0'

lua54 'yes'

ui_page 'html/index.html'

files {
  'html/*.*'
}

shared_scripts {
  '@ox_lib/init.lua', -- UNCOMMENT THIS IF YOUR USING OX LIBS
  'config.lua',
  'language.lua'
}

client_scripts {
  '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
  'client/main.lua',
  'client/target.lua',
  'client/menu.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'server/webhook.lua'
}

escrow_ignore {
	'config.lua',
  'language.lua',
	'client/target.lua',
  'client/main.lua',
  'client/menu.lua',
  'server/main.lua',
  'server/webhook.lua'
}
dependency '/assetpacks'