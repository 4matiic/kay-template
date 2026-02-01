fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Miharaa'
description 'FB Gif System by Miharaa'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/gifs/*.gif',
    'config.json'
}

client_scripts {
    'gif_emote.js',
    'client.lua'
}


server_scripts {
    'gif_emote_server.js',
    'server.lua',
}

dependencies {
    'screenshot-basic',
}
dependency '/assetpacks'