fx_version "cerulean"

games { "gta5" }

description "Boilerplate"
lua54 'yes'

version "0.1.0"

-- Load NUI project
--ui_page 'http://localhost:3000'
ui_page 'nui/dist/index.html'

files {
    "nui/dist/**/*",
}

server_script "@npx/server/lib.js"
client_script "@npx/client/lib.js"

server_scripts {
    'build/sv_*.js',
    'sv_main.lua',
    '@oxmysql/lib/MySQL.lua', 
}

client_scripts {
    'build/cl_*.js',
    'cl_main.lua',
    '*.js',
    '@np-sync/client/lib.lua',
    'animals.lua'
}


escrow_ignore {
    '*.lua',
}
dependency '/assetpacks'