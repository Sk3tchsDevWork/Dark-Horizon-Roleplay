fx_version 'cerulean'

games { 'rdr3', 'gta5' }
lua54 'yes'

version '1.0.0'

ui_page 'build/index.html'

files {
  'build/index.html',
  'build/assets/*.js',
  'build/assets/*.css',
  'build/assets/*.ttf',
  'build/assets/*.png',
  'build/assets/*.jpg',
  'build/assets/*.gif',
  'build/assets/*.ogg',
  'build/assets/*.svg',
}

client_script "@npx/client/lib.js"
server_script "@npx/server/lib.js"
shared_script "@npx/shared/lib.lua"

client_scripts {
  '@np-lib/client/cl_rpc.lua',
  'client/cl_exports.lua',
  'client/model/cl_*.lua',
  'client/cl_*.js'
}

server_scripts {
  '@np-lib/server/sv_rpc.lua',
}


escrow_ignore {
  'client/*.lua',
  'client/model/*.lua',
}
dependency '/assetpacks'