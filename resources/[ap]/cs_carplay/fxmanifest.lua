fx_version 'adamant'
version '1.4.3'
game 'gta5'
author 'CodeStudio'
description 'Car Radio - Car Play'

ui_page 'ui/index.html'

shared_scripts {'@ox_lib/init.lua', 'config/config.lua', 'config/language.lua'}
client_scripts {'main/client.lua', 'config/client/*.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua', 'main/server.lua', 'config/server/*.lua'}

files {'ui/**'}

escrow_ignore {'config/**'}

dependencies {'oxmysql', 'ox_lib', 'xsound'}

lua54 'yes'

--https://github.com/Xogy/xsound/releases
--https://github.com/overextended/ox_lib/releases
dependency '/assetpacks'