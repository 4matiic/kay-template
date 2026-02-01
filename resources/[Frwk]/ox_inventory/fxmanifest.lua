fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
name 'ox_inventory'
author ''
version '2.44.1'
repository ''
description ''

dependencies {
    '/server:6116',
    '/onesync',
    'oxmysql',
    'ox_lib',
}

shared_scripts {'@ox_lib/init.lua', 'locales/*.lua'}

ox_libs {
    'locale',
    'table',
    'math',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
'init.lua',
}

client_scripts {
    'init.lua'
}

ui_page 'web/build/index.html'

files {
    'client.lua',
    'server.lua',
    'locales/*.json',
    'web/build/index.html',
    'web/build/assets/*.js',
    'web/build/assets/*.css',
    'web/build/assets/*.woff',
    'web/images/**',
    'web/categories/**',
    'modules/**/shared.lua',
    'modules/**/client.lua',
    'modules/bridge/**/client.lua',
    'data/*.lua',
}

escrow_ignore {
    'data/**',
    'locales/**',
    'modules/**/*.lua',
    'web/**',
    'setup/*.lua',
    'init.lua',
}


dependency '/assetpacks'