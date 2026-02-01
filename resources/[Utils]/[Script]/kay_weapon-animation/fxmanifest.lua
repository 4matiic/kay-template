fx_version "cerulean"
game "gta5"

ui_page "html/index.html"

files {
	"html/index.html",
	"html/js/jquery-3.6.0.min.js",
	"html/img/*.png",
	"html/js/listener.js",
	"html/style.css",
}

shared_script "config.lua"
server_script "server.lua"
client_script "client.lua"

exports {
    'startRadioAnimation',
    'stopRadioAnimation'
}
