fx_version "cerulean"
games {"gta5", "rdr3"} 
lua54 "yes"
name 'nz_visitcard'
author 'nezox'
version '1.0'


client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    'client/client.lua', 
	'client/nui.lua', 
}

ui_page 'html/index.html' 

server_script {
    'server/server.lua'
}

files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/fonts/*'
}
