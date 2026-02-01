fx_version('cerulean')
games({ 'gta5' })

Author('d4rko.re')
Description('FreeCam script fivem')
Version('1.0.0')

shared_scripts({
    'src/shared.lua'
});

server_scripts({
    'src/sv_cam.lua'
});

client_scripts({
    'src/functions/*.lua',
    'src/cl_cam.lua'
});