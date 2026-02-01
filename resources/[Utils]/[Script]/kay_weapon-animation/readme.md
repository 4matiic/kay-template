Le Script est STANDALONE sauf pour le système de radio (pma-voice)

Voici comment config pma-voice :

client/module/radio.lua ~ ligne 185 replacer toutes la commande +radiotalk par  : 

RegisterCommand('+radiotalk', function()
    if GetConvarInt('voice_enableRadios', 1) ~= 1 then return end
    if isDead() then return end
    if not isRadioEnabled() then return end
    if not radioPressed then
        if radioChannel > 0 then
            logger.info('[radio] Start broadcasting, update targets and notify server.')
            addVoiceTargets(radioData, callData)
            TriggerServerEvent('pma-voice:setTalkingOnRadio', true)
            radioPressed = true
            playMicClicks(true)

            exports['kay_weapon-animation']:startRadioAnimation()

            CreateThread(function()
                TriggerEvent("pma-voice:radioActive", true)
                LocalPlayer.state:set("radioActive", true, true)
                while radioPressed do
                    Wait(0)
                end
            end)
        else
            logger.info("Player tried to talk but was not on a radio channel")
        end
    end
end, false)

client/module/radio.lua ~ ligne 215 replacer toutes la commande -radiotalk par  : 

RegisterCommand('-radiotalk', function()
    if radioChannel > 0 and radioPressed then
        radioPressed = false
        MumbleClearVoiceTargetPlayers(voiceTarget)
        addVoiceTargets(callData)
        TriggerEvent("pma-voice:radioActive", false)
        LocalPlayer.state:set("radioActive", false, true)
        playMicClicks(false)

        exports['kay_weapon-animation']:stopRadioAnimation()

        TriggerServerEvent('pma-voice:setTalkingOnRadio', false)
    end
end, false)