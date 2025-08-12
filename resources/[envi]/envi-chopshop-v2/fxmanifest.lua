author 'Envi-Scripts'
fx_version 'cerulean'

game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

data_file 'AUDIO_WAVEPACK'  'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'data/chop.dat'

files {
    'data/chop.dat54.rel',
    'audiodirectory/chopshop.awc'
}

version '2.4.0b'
 
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
    'install/*/*',
    'server/server_edit.lua',
    'ui/**',
}
 
files {
    'ui/**'
}

ui_page 'ui/index.html'

dependency '/assetpacks'

bridge 'envi-bridge'
dependency '/assetpacks'