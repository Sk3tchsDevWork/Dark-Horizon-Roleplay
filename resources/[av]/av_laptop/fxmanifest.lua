fx_version 'cerulean'
description 'AV Laptop'
author 'Avilchiis'
version '3.0.0'
lua54 'yes'
games {
    'gta5'
}

ui_page 'ui/dist/index.html'

shared_scripts {
    '@ox_lib/init.lua',
--    '@qbx_core/modules/lib.lua', -- Uncomment this if you are using Qbox
    'config/*.lua'
}

client_scripts {
--    '@qbx_core/modules/playerdata.lua', -- Uncomment this if you are using Qbox
    'client/**/*',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**/*'
}

files {
    'ui/dist/index.html',
    'ui/dist/**/*',
}

escrow_ignore {
    'config/*.lua',
    'client/editable/*.lua',
    'server/editable/*.lua',
}

dependencies {
    "ox_lib",
}

dependency '/assetpacks'