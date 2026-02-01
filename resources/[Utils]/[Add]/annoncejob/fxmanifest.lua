fx_version 'cerulean'
game 'gta5'
lua54 'yes'

dependencies { 'ox_lib', 'framework' }

shared_scripts {
    '@ox_lib/init.lua',
    '@framework/imports.lua'  
}


client_scripts {
    'RageUI/RMenu.lua',
    'RageUI/menu/RageUI.lua',
    'RageUI/menu/Menu.lua',
    'RageUI/menu/MenuController.lua',

    -- Modules RageUI
    'RageUI/components/*.lua',
    'RageUI/menu/elements/*.lua',
    'RageUI/menu/items/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',
    'client.lua'             
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', 
    'server.lua'
}
