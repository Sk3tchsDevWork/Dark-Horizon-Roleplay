fx_version 'cerulean'
game 'gta5'

description 'ShadowByte Radio With Metadata'
version '1.0.1'

shared_script {
  '@qb-core/shared/locale.lua',
  'config.lua',
  'locales.lua'
}

client_scripts {
  'client.lua',
  'radio_events.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server.lua',
}

ui_page('html/ui.html')

files {
  'html/ui.html',
  'html/js/script.js',
  'html/css/style.css',
}

dependencies {
  'pma-voice',
} 

escrow_ignore {
  'README.md',
  'config.lua',
  'locales.lua',
  'radio_events.lua',
}

lua54 'yes'

dependency '/assetpacks'