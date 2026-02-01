fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.0.0'

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

shared_scripts {
    'shared/config.lua'
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

