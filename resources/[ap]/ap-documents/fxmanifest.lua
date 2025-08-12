fx_version 'adamant'
games { 'gta5' }

mod 'QB AP DOCUMENTS'
version '1.2.1'

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/*.*'
}

shared_scripts {
  --'@ox_lib/init.lua', -- UNCOMMENT THIS IF YOUR USING OX LIBS
  'config.lua',
  'shared/documents.lua'
}

client_scripts {
  'client/main.lua',
  'client/menu.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'server/custominventory.lua'
}

escrow_ignore {
	'config.lua',
  'shared/documents.lua',
  'client/main.lua',
  'client/menu.lua',
  'server/main.lua',
  'server/custominventory.lua'
}
dependency '/assetpacks'