local micClicksEnabled = true

RegisterNetEvent('Radio:SetOpened')
AddEventHandler('Radio:SetOpened', function(toggle)
    if toggle then
        AddNuiFocus('radio')
        if LocalPlayer.state.inventoryOpened then
            ExecuteCommand('OPEN_INVENTORY')
        end
    else
        RemoveNuiFocus('radio')
    end
    SendReactMessage('Radio:SetOpened', toggle)
end)

RegisterNetEvent('Radio:SetRadio')
AddEventHandler('Radio:SetRadio', function(radio)
    SendReactMessage('Radio:SetRadio', radio)
end)

RegisterNUICallback('Radio:LeaveRadio', function(_, cb)
	exports["pma-voice"]:removePlayerFromRadio()
    cb('ok')
end)

RegisterNUICallback('Radio:Exit', function(_, cb)
    RemoveNuiFocus('radio')
    cb('ok')
end)

RegisterNUICallback('Radio:VolUp', function(_, cb)
    local currentVolume = exports['pma-voice']:getRadioVolume()
    local newVolume = math.min(math.floor(currentVolume + 10), 100)
    exports['pma-voice']:setRadioVolume(newVolume)
    ESX.ShowNotification('Le volume est à ~g~' .. newVolume .. '~s~%')
    cb('ok')
end)

RegisterNUICallback('Radio:VolDown', function(_, cb)
    local currentVolume = exports['pma-voice']:getRadioVolume()
    local newVolume = math.max(math.floor(currentVolume - 10), 0)
    exports['pma-voice']:setRadioVolume(newVolume)
    ESX.ShowNotification('Le volume est à ~r~' .. newVolume .. '~s~%')
    cb('ok')
end)

RegisterNUICallback('Radio:Clicks', function(_, cb)
    TriggerEvent('nui:fb:radio:clicks')
    micClicksEnabled = not micClicksEnabled
    exports['pma-voice']:setVoiceProperty('micClicks', micClicksEnabled)
    if micClicksEnabled then
        ESX.ShowNotification('Les bip radio sont ~g~activés')
    else
        ESX.ShowNotification('Les bip radio sont ~r~désactivés')
    end
    cb('ok')
end)

RegisterNUICallback('Radio:Join', function(data, cb)
    exports["pma-voice"]:SetRadioChannel(tonumber(data.radio))
    cb(true)
end)