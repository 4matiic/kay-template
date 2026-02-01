fx_version "adamant"
game "gta5"
use_fxv2_oal "yes"
lua54 "yes"
name ""
author ""
version ""

ui_page "web/dist/index.html"

files {
    "web/dist/index.html",
    "web/dist/assets/*.js",
    "web/dist/assets/*.css",
    "web/dist/*.png"
}

client_scripts { "client/**/*.lua" }
shared_scripts { "shared/*.lua" }
server_scripts { "@oxmysql/lib/MySQL.lua", "server/**/*.lua"}