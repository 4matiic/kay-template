RegisterNetEvent('ScreenCapture:StartCapture', function()
    SendReactMessage('ScreenCapture:StartCapture')
end)

RegisterNetEvent('ScreenCapture:StartWatching', function(id)
    SendReactMessage('ScreenCapture:StartWatching', id)
end)

RegisterNetEvent('ScreenCapture:StopCapture', function()
    SendReactMessage('ScreenCapture:StopCapture')
end)

RegisterNetEvent('ScreenCapture:StopWatching', function()
    SendReactMessage('ScreenCapture:StopWatching')
end)

RegisterNetEvent('Recorder:ToggleVideoRecording', function()
    SendReactMessage('Recorder:ToggleVideoRecording')
end)

RegisterNetEvent('Recorder:RecordAudio', function(toggle, _ignoreTalking)
    SendReactMessage('Recorder:RecordAudio', {
        toggle = toggle,
        _ignoreTalking = _ignoreTalking,
    })
end)

RegisterNetEvent('Recorder:RecordVideo', function(toggle)
    SendReactMessage('Recorder:RecordVideo', {
        toggle = toggle,
    })
end)

RegisterNUICallback('ScreenCapture:CaptureStarted', function(data, cb)
    TriggerServerEvent('ScreenCapture:CaptureStarted', data.id)
    cb('ok')
end)

RegisterNUICallback('ScreenCapture:CaptureEnded', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('Recorder:VideoEnded', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('Recorder:AudioEnded', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('Recorder:Error', function(data, cb)
    cb('ok')
end)

RegisterNuiCallback('Recorder:GetUploadApi', function(data, cb)
    cb('https://img.flashfa.fr/upload')
end)

CreateThread(function()
    local talking = false

    while true do
        Wait(100)

        if MumbleIsPlayerTalking(PlayerId()) and not talking then
            talking = true
            SendReactMessage("Recorder:ToggleMicrophone", talking)
        elseif not MumbleIsPlayerTalking(PlayerId()) and talking then
            talking = false
            SendReactMessage("Recorder:ToggleMicrophone", talking)
        end
    end
end)