fx_version('bodacious')
game('gta5')
ui_page('html/index.html')
--client_script('@korioz/lib.lua')
client_script('client/main.lua')
server_script('server/main.lua')
files({
	'html/index.html',
	'html/index.css',
	'html/config.default.js',
	'html/App.js',
	'html/Message.js',
	'html/Suggestions.js',
	'html/vendor/vue.2.3.3.min.js',
	'html/vendor/flexboxgrid.6.3.1.min.css',
	'html/vendor/animate.3.5.2.min.css',
	'html/vendor/latofonts.css',
	'html/vendor/fonts/LatoRegular.woff2',
	'html/vendor/fonts/LatoRegular2.woff2',
	'html/vendor/fonts/LatoLight2.woff2',
	'html/vendor/fonts/LatoLight.woff2',
	'html/vendor/fonts/LatoBold.woff2',
	'html/vendor/fonts/LatoBold2.woff2'
})
-- Chat
files {
	'fb_chat.css',
	'fb_chat.js'
}
chat_theme 'fb' {
	styleSheet = 'fb_chat.css',
	script = 'fb_chat.js',
	msgTemplates = {
		default = '<b>{0}</b><span>{1}</span>',
		annonce = '<div class="annonce">Annonce:<br> {0}<br></div>',
		report = '<div class="report">(^{0}{1} | {2}^0) {3}<br></div>',
	}
}