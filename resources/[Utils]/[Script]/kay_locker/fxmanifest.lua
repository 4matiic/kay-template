fx_version 'cerulean'

games {"gta5"}

version '1.0.0'
shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}
lua54 'yes'

ui_page 'web/build/index.html'

client_script "client/**/*"
server_script "server/**/*"

files {
  'web/build/index.html',
  'web/build/**/*'
}


escrow_ignore {
  'config.lua'
}