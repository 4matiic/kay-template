fx_version "adamant"
games {"gta5"}
name "pmms"
description ""
author ""
repository ""

dependency "httpmanager"

shared_scripts {
	"config.lua",
	"common.lua"
}

server_script "server.lua"

files {
	"ui/index.html",
	"ui/style.css",
	"ui/script.js",
	"ui/mediaelement.min.js",
	"ui/loading.svg",
	"ui/wave.js"
}

ui_page "ui/index.html"

client_scripts {
	"dui.lua",
	"staticEmitters.lua",
	"client.lua"
}
