fx_version "cerulean"

description "A pack of 30+ minigames for FiveM"
author "TeamsGG Development"
version '1.0.0'

lua54 'yes'

game 'gta5'

ui_page 'web/build/index.html'

shared_scripts {
  '@ox_lib/init.lua',
  "config/**/*.lua",
}

client_scripts {
  "client/**/*.lua",
}

server_script 'sv_main.lua'

files {
  'web/build/index.html',
  'web/build/**/*',
}

escrow_ignore {
  'config/**/*',
}

dependencies {
  'ox_lib',
}

dependency '/assetpacks'