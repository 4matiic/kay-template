fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'kay'
description 'Boites de munitions'

shared_scripts {
    'config.lua'
}


client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua',
}

server_exports {
    'ox_inventory:useItem'
}
