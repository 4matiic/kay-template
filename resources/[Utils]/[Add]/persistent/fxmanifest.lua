-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'John Doe <j.doe@example.com>'
description 'Example resource'
version '1.0.0'

-- What to run
client_scripts {
    'cl_persistcar.lua',
    
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'sv_main.lua',
    
}