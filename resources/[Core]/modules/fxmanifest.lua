fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.0.0'

client_scripts {
    'node/function/*.lua',
    'addons/client/**/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'node/function/*.lua',
    'addons/server/**/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua',

}

ui_page {
    "dist/index.html"
 }
 
 files {
    "dist/index.html",
    "dist/assets/**",
 }
 

escrow_ignore {
    'shared/*.lua'
}
