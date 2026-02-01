fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Miharaa'
description 'Système de drogues by Miharaa'

ui_page 'ui/index.html'


data_file 'DLC_ITYP_REQUEST' 'stream/pots.ytyp'

shared_scripts {
    '@framework/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'functions.lua',
    'client.lua',
    'DuiHandle.lua',
    'Scaleform.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}

dependencies {
    'ox_inventory',
    'ox_lib'
}

escrow_ignore {
    'config.lua',
}