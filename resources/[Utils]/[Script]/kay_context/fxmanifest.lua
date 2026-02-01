fx_version 'cerulean'
games { 'gta5' }

author ''
description ''
version '0.8.1'
lua54 'yes'

shared_script { '@ox_lib/init.lua' }
shared_script '@framework/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"alt_server/server.lua",
	"alt_server/mailbox_server.lua",
	"version.lua",
}

client_scripts {
	'Utils/screenToWorld.lua',
	'Utils/TextAlignment.lua',
	'Utils/TextFont.lua',
	'Utils/Log.lua',
	'Utils/Color.lua',

	'DefaultValues.lua',

	'Graphics2D/Object2D.lua',
	'Graphics2D/Rect.lua',
	'Graphics2D/Text.lua',
	'Graphics2D/Sprite.lua',
	'Graphics2D/SpriteUV.lua',
	'Graphics2D/Container.lua',
	'Graphics2D/Border.lua',

	'Items/BaseItem.lua',
	'Items/SeparatorItem.lua',
	'Items/ScrollItem.lua',
	'Items/PageItem.lua',
	'Items/TextItem.lua',
	'Items/Item.lua',
	'Items/SpriteItem.lua',
	'Items/SubmenuItem.lua',
	'Items/CheckboxItem.lua',

	'Menu/Menu.lua',
	'Menu/ScrollMenu.lua',
	'Menu/PageMenu.lua',
	'Menu/MenuPool.lua',

	'Menu/ExportMenu.lua',

	'alt_client/*.lua',
	'function.lua',
	'listitemtouse.lua',
}