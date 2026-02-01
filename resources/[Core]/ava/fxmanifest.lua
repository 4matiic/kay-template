fx_version "cerulean"
games {"gta5"}
lua54 "yes"

shared_script {
    "shared/*.lua",
}

client_scripts {
    "client/*.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "server/*.lua",
	--[[server.lua]]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
}

files {
    "build/**/*",
    'build/static/js/*.js',
    'build/init.js',
    'build/jquery.js',
}

ui_page "build/index.html"

dependencies {
    'ox_lib',     
}

exports {
    'OpenKeypad',
    'CloseKeypad'
}