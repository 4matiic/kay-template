fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'ClotheShop'
version '1.0.0'

ui_page 'dist/index.html'


shared_scripts {
    'shared/config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

files {
    'dist/index.html',
    'dist/assets/**'
}

escrow_ignore {
    'shared/config.lua'
}

