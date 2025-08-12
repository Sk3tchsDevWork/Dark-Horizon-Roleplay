fx_version 'adamant'
version '1.2.1'
game 'gta5'
author 'CodeStudio'
description 'Documents Creator'

ui_page 'ui/index.html'

shared_scripts {'@ox_lib/init.lua', 'config/*.lua'}
client_scripts {'main/client.lua', 'config/function/cl_function.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua', 'main/server.lua', 'config/function/sv_function.lua'}

files {'ui/**'}

escrow_ignore {'config/**'}

dependencies {'oxmysql', 'ox_lib'}

lua54 'yes'
dependency '/assetpacks'