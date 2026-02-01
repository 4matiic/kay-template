fx_version 'cerulean'
games { 'gta5' }
author 'Zappy'
description 'Coffre'
version '1.0.0'
lua54 'yes'

dependencies { 'ox_lib' }

server_scripts { '@oxmysql/lib/MySQL.lua' }

shared_script { '@ox_lib/init.lua' }
shared_script '@framework/imports.lua'

shared_scripts {
	'config.lua',
}

client_scripts {
	'cl_main.lua',
}

server_scripts {
	'sv_main.lua',
}

server_scripts { '@oxmysql/lib/MySQL.lua' }