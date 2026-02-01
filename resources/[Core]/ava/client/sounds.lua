--[[
local soundId = 0
local sounds = {}

local PlaySound = function(ref, url, volume, position, distance, loop)
    assert(type(ref) == 'string' or type(ref) == 'number')
    assert(type(url) == 'string')
    assert(volume == nil or type(volume) == 'number')
    assert(type(position) == 'vector3' or type(position) == 'number' or position == nil)
    assert(distance == nil or type(distance) == 'number')
    assert(loop == nil or type(loop) == 'boolean')
    soundId += 1

    local isBasedOnNetId = type(position) == 'number'

    local sound = {
        url = url,
        volume = volume,
        position = isBasedOnNetId and (NetworkDoesEntityExistWithNetworkId(position) and GetEntityCoords(NetworkGetEntityFromNetworkId(position)) or vector3(0, 0, -10000)) or position,
        distance = distance or 30,
        netId = isBasedOnNetId and position or nil,
        loop = loop,
        playing = false,
    }
    sounds[ref] = sound


    if isBasedOnNetId then
        SendReactMessage('Sound:UpdateCameraAxis', {
            position = GetFinalRenderedCamCoord(),
            rotation = GetFinalRenderedCamRot(0),
        })
    end

    local i = 0
    for ref, sound in pairs(sounds) do
        if not sound.playing and i < 10 then
            SendReactMessage('Sound:Create', {
                index = i,
                ref = ref or soundId,
                sound = sound
            })
        end
        i += 1
    end
end

RegisterNetEvent('fb:sounds:playSound', PlaySound)
exports('playSound', PlaySound)

local Destroy = function(ref)
    assert(type(ref) == 'string' or type(ref) == 'number')
    sounds[ref] = nil
    SendReactMessage('Sound:Destroy', ref)
end

RegisterNetEvent('fb:sounds:destroy', Destroy)
exports('destroySound', Destroy)

RegisterNUICallback('Sounds:Destroyed', function(data, cb)
    sounds[data.ref] = nil
    cb('ok')
end)

CreateThread(function()
    while true do
        local hasActiveSounds = false

        for ref, sound in pairs(sounds) do
            hasActiveSounds = true
            if sound.netId then
                if NetworkDoesEntityExistWithNetworkId(sound.netId) then
                    sound.position = GetEntityCoords(NetworkGetEntityFromNetworkId(sound.netId))
                else
                    sound.position = vector3(0, 0, -10000)
                end

                SendReactMessage('Sound:UpdatePosition', {
                    ref = ref,
                    position = sound.position,
                })
            end
        end

        if hasActiveSounds then
            SendReactMessage('Sound:UpdateCameraAxis', {
                position = GetFinalRenderedCamCoord(),
                rotation = GetFinalRenderedCamRot(0),
            })
        end

        Wait(0)
    end
end)
]]

exports('playSound', function() end)
exports('destroySound', function() end)