fx_version 'bodacious'
game 'gta5'

description 'RProgress type Flashback, Redesign by s4na.re'
author 'Karl Saunders'

version '1.1.9'

client_scripts {
    'config.lua',
    'utils.lua',
    'client.lua',
}

ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/fonts/*.ttf',
    'ui/css/*.css',
    'ui/js/*.js',
}

exports {
    "Start",
    "Custom",
    "Stop",
    "Static",
    "Linear",
    "MiniGame"
}