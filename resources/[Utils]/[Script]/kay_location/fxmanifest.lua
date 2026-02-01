fx_version 'cerulean'
game 'gta5'

version '1.0.0'

ui_page('html/shops.html')
files {
    "html/shops.html",
}

client_scripts {
    "shared/*.lua",
    "client/*.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'shared/*.lua',
    'server/*.lua',
}