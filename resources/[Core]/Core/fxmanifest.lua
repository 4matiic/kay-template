fx_version 'cerulean'
game 'gta5'

author ''
description ''
version '1.0.0'
lua54 'yes'


client_scripts {
    '@framework/imports.lua',

    -- RageUI
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    'client.lua' 
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', 
    '@framework/imports.lua',
    'server.lua',
}

dependencies {
    'oxmysql'
}
