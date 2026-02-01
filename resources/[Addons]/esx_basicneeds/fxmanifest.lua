fx_version 'adamant'

game 'gta5'

description 'Adds a Hunger & Thrist system'
lua54 'yes'
version '1.0'
legacyversion '1.9.1'

shared_script '@framework/imports.lua'

server_scripts {
    '@framework/locale.lua',
    'locales/*.lua',
    'config.lua',
'server/main.lua',
	--[[server.lua]]
}

client_scripts {
    '@framework/locale.lua',
    'locales/*.lua',
    'config.lua',
    'client/main.lua'
}

dependencies {
    'framework',
    'esx_status'
}
