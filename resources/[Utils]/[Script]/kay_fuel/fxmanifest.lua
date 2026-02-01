fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'KLHHH'
name 'Fuel System style FB'
version '1.0'

client_scripts {
	'config.lua',
	'functions/functions_client.lua',
	'functions/dui.lua',
	'source/fuel_client.lua'
}

server_scripts {
	'config.lua',
	'source/fuel_server.lua',
}


exports {
	'GetFuel', 
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/script.js',
    'ui/styles.css'
}
