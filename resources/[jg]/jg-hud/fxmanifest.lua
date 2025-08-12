fx_version "cerulean"
game "gta5"
lua54 "yes"
use_experimental_fxv2_oal "yes"

version 'v1.2'
version "dev"
author "JG Scripts"

client_scripts {
  "framework/main.lua",
  "framework/cl-functions.lua",
  "locales/*.lua",
  "client/cl-main.lua",
  "client/*.lua",
}

server_scripts {
  "server/*.lua"
}

shared_scripts {
  "@ox_lib/init.lua",
  "config/config.lua",
  "config/config.data.lua"
}

dependencies {
  "ox_lib"
}

ui_page "web/dist/index.html"

files {
  "web/dist/index.html",
  "web/dist/**/*",
  "data/**/*",
  "server-logo.png"
}

escrow_ignore {
  "framework/**/*",
  "data/**/*",
  "config/**/*",
  "locales/**/*",
  "client/cl-seatbelt.lua"
}
dependency '/assetpacks'