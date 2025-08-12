fx_version "cerulean"
game "gta5"

author "bitc0de"
description "BIT-LICENSES"

client_scripts {"config/shared.lua", "client/main.lua"}

server_scripts {"versions.lua", "config/shared.lua", "server/main.lua", "config/s_config.lua"}

ui_page "html/index.html"

files {"html/index.html", "html/assets/css/*.css", "html/assets/js/*.js", "html/assets/img/*.*"}

data_file "DLC_ITYP_REQUEST" "stream/bit_licenses.ytyp"

dependency "screenshot-basic"

escrow_ignore {
    "config/*"
}

lua54 "yes"

dependency '/assetpacks'