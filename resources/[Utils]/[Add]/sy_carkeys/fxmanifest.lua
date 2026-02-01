fx_version 'cerulean'
game 'gta5' 



shared_scripts{
    '@framework/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
} 


client_scripts{
    'client/*.lua'
} 

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
} 


files {
    'locales/*.json'
}

lua54 'yes'