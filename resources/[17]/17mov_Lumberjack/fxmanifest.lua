fx_version "cerulean"
game "gta5"
author "Malizniak - 17Movement"
lua54 "yes"
this_is_a_map 'yes'
version "2.0.67"

files {
    "web/**/*.**",
    "web/*.**",
    'stream/**/**/handling.meta',
    'stream/**/**/vehicles.meta',
    'stream/**/**/carvariations.meta',
    'stream/**/**/vehiclelayouts.meta',
}

ui_page "web/index.html"

shared_script "Config.lua"

server_scripts {
    "server/functions.lua",
    "server/server.lua",
}

client_scripts {
    "client/functions.lua",
    "client/target.lua",
    "client/client.lua",
    "client/crane.lua",
}

escrow_ignore {
    "Config.lua",
    "client/target.lua",
    "client/functions.lua",
    "server/functions.lua",
}


data_file 'DLC_ITYP_REQUEST' 'stream/17mov_chainsaw.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/17mov_woodpallet.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/map/ytyp/17_movement_convo.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/map/ytyp/17movement_hintskip.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/crane/17move_crane.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/map/ytyp/17mov_belts.ytyp'

data_file 'HANDLING_FILE'            'stream/**/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE'     'stream/**/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE'    'stream/**/**/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE'   'stream/**/**/carvariations.meta'

dependency '/assetpacks'