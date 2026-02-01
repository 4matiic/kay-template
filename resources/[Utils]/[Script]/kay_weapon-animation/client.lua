-- Je vous conseille de ne pas toucher si vous ne savez pas faire, si vous avez besoin d'un support, rejoignez le serveur discord : https://discord.gg/UZUesn59V2


local display = false
local AimAnim = GetResourceKvpString("AimAnim")
local HolsterAnim = GetResourceKvpString("HolsterAnim")
local RadioAnim = GetResourceKvpString("RadioAnim")


RegisterNetEvent("Kenshi:MenuArme")
AddEventHandler('Kenshi:MenuArme', function()
	SetDisplay(not display)
end)


RegisterNUICallback("close", function(data)
    SetDisplay(false)
end)


TriggerEvent('chat:addSuggestion', "/" .. config.openCommand, 'Ouvrir le menu d\'animation', {})


RegisterNUICallback("1", function(data)
    SetResourceKvp("AimAnim", "nil")
    AimAnim = GetResourceKvpString("AimAnim")
    SetDisplay(false)
end)
RegisterNUICallback("2", function(data)
    SetResourceKvp("AimAnim", "GangsterAS")
    AimAnim = GetResourceKvpString("AimAnim")
    SetDisplay(false)
end)
RegisterNUICallback("3", function(data)
    SetResourceKvp("AimAnim", "HillbillyAS")
    AimAnim = GetResourceKvpString("AimAnim")
    SetDisplay(false)
end)

RegisterNUICallback("4", function(data)
    SetResourceKvp("HolsterAnim", "nil")
    HolsterAnim = GetResourceKvpString("HolsterAnim")
    SetDisplay(false)
end)
RegisterNUICallback("5", function(data)
    SetResourceKvp("HolsterAnim", "BackHolsterAnimation")
    HolsterAnim = GetResourceKvpString("HolsterAnim")
    SetDisplay(false)
end)
RegisterNUICallback("6", function(data)
    SetResourceKvp("HolsterAnim", "SideHolsterAnimation")
    HolsterAnim = GetResourceKvpString("HolsterAnim")
    SetDisplay(false)
end)

RegisterNUICallback("7", function(data)
    SetResourceKvp("HolsterAnim", "FrontHolsterAnimation")
    HolsterAnim = GetResourceKvpString("HolsterAnim")
    SetDisplay(false)
end)
RegisterNUICallback("8", function(data)
    SetResourceKvp("HolsterAnim", "AgressiveFrontHolsterAnimation")
    HolsterAnim = GetResourceKvpString("HolsterAnim")
    SetDisplay(false)
end)
RegisterNUICallback("9", function(data)
    SetResourceKvp("HolsterAnim", "SideLegHolsterAnimation")
    HolsterAnim = GetResourceKvpString("HolsterAnim")
    SetDisplay(false)
end)

RegisterNUICallback("10", function(data)
    SetResourceKvp("RadioAnim", "RadioDefault")
    RadioAnim = GetResourceKvpString("RadioAnim")
    SetDisplay(false)
end)
RegisterNUICallback("11", function(data)
    SetResourceKvp("RadioAnim", "RadioPolice")
    RadioAnim = GetResourceKvpString("RadioAnim")
    SetDisplay(false)
end)
RegisterNUICallback("12", function(data)
    SetResourceKvp("RadioAnim", "RadioBras")
    RadioAnim = GetResourceKvpString("RadioAnim")
    SetDisplay(false)
end)

-- Visée
CreateThread(function()
    while true do
        Player = PlayerPedId()
        ped = PlayerPedId()
        
        if AimAnim == "GangsterAS" then
            if CheckWeapon2(ped) then
                inVeh = IsPedInVehicle(PlayerPedId(-1), GetVehiclePedIsIn(PlayerPedId(-1), false), false)
                local _, hash = GetCurrentPedWeapon(Player, 1)
                if not inVeh then
                    loadAnimDict("combat@aim_variations@1h@gang")
                    if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                        if not IsEntityPlayingAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
                            TaskPlayAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3.0, 2.0, -1, 49, 0, 0, 0, 0)
                            SetEnableHandcuffs(Player, true)
                        end
                    elseif IsEntityPlayingAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
                        ClearPedTasks(Player)
                        SetEnableHandcuffs(Player, false)
                    end
                    Citizen.Wait(50)
                end
                Citizen.Wait(50)
            end
        elseif AimAnim == "HillbillyAS" then
            if CheckWeapon2(ped) then
                inVeh = IsPedInVehicle(PlayerPedId(-1), GetVehiclePedIsIn(PlayerPedId(-1), false), false)
                local _, hash = GetCurrentPedWeapon(Player, 1)
                if not inVeh then
                    loadAnimDict("combat@aim_variations@1h@hillbilly")
                    if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                        if not IsEntityPlayingAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 3) then
                            TaskPlayAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                            SetEnableHandcuffs(Player, true)
                        end
                    elseif IsEntityPlayingAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 3) then
                        ClearPedTasks(Player)
                        SetEnableHandcuffs(Player, false)
                    end
                    Citizen.Wait(50)
                end
                Citizen.Wait(50)
            end
        end
        Citizen.Wait(80)
    end
end)

-- Premier Style de sortie d'arme
CreateThread(function()
    while true do
        if HolsterAnim == "SideHolsterAnimation" then
            loadAnimDict("rcmjosh4")
            loadAnimDict("reaction@intimidation@cop@unarmed")
            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            blocked   = true
                                SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                                TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 2.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                                
                                    Citizen.Wait(100)
                                    SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
                                TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 2.0, 2.0, -1, 48, 10, 0, 0, 0 )
                                    Citizen.Wait(400)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(50)
                    else
                        if not holstered then
                                TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 2.0, 2.0, -1, 48, 10, 0, 0, 0 )
                                    Citizen.Wait(500)
                                TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 2.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                                    Citizen.Wait(60)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                    Citizen.Wait(50)
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            else
                holstered = true
            end
        elseif HolsterAnim == "BackHolsterAnimation" then
            loadAnimDict("reaction@intimidation@1h")

            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                            blocked   = true
                                TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 2.0, 2.0, -1, 50, 0.325, 0, 0)
                                    Citizen.Wait(600)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(40)
                    else
                        if not holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                                TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", GetEntityCoords(ped, true), 0, 0, rot, 2.0, 2.0, -1, 50, 0.125, 0, 0)
                                    Citizen.Wait(2000)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                    Citizen.Wait(50)
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            else
                holstered = true
            end
        end
        Citizen.Wait(40)
    end
end)

-- Second Style de sortie d'arme
CreateThread(function()
    while true do
        if HolsterAnim == "FrontHolsterAnimation" then
            loadAnimDict("combat@combat_reactions@pistol_1h_gang")

            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                            blocked   = true
                                TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 2.0, 2.0, -1, 50, 0.325, 0, 0)
                                    Citizen.Wait(600)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(40)
                    else
                        if not holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                                TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 2.0, 2.0, -1, 50, 0.125, 0, 0)
                                    Citizen.Wait(1000)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                    Citizen.Wait(50)
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            else
                holstered = true
            end
        elseif HolsterAnim == "AgressiveFrontHolsterAnimation" then
            loadAnimDict("combat@combat_reactions@pistol_1h_hillbilly")
            loadAnimDict("combat@combat_reactions@pistol_1h_gang")

            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                            blocked   = true
                                TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_hillbilly", "0", GetEntityCoords(ped, true), 0, 0, rot, 2.0, 2.0, -1, 50, 0.325, 0, 0)
                                    Citizen.Wait(600)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(40)
                    else
                        if not holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                                TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 2.0, 2.0, -1, 50, 0.125, 0, 0)
                                    Citizen.Wait(1000)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                    Citizen.Wait(50)
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            else
                holstered = true
            end
        elseif HolsterAnim == "SideLegHolsterAnimation" then
            loadAnimDict("reaction@male_stand@big_variations@d")

            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                            blocked   = true
                                TaskPlayAnimAdvanced(ped, "reaction@male_stand@big_variations@d", "react_big_variations_m", GetEntityCoords(ped, true), 0, 0, rot, 2.0, 2.0, -1, 50, 0.325, 0, 0)
                                    Citizen.Wait(500)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(40)
                    else
                        if not holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                                TaskPlayAnimAdvanced(ped, "reaction@male_stand@big_variations@d", "react_big_variations_m", GetEntityCoords(ped, true), 0, 0, rot, 2.0, 2.0, -1, 50, 0.125, 0, 0)
                                    Citizen.Wait(500)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
                Citizen.Wait(50)
            else
                holstered = true
            end
        end
        Citizen.Wait(40)
    end
end)


local function loadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(10)
    end
end

local function attachRadioToHand()
    local ped = PlayerPedId()
    loadModel("prop_cs_hand_radio")
    currentRadioObject = CreateObject(GetHashKey("prop_cs_hand_radio"), 0.0, 0.0, 0.0, true, true, false)
    AttachEntityToEntity(
        currentRadioObject,
        ped,
        GetPedBoneIndex(ped, 28422),
        0.0750,
        0.0230,
       -0.0230,
      -90.0000,
        0.0,
      -59.9999,
        false, false, false, true, 2, true
    )
end


local function attachRadioToHand3()
    local ped = PlayerPedId()
    loadModel("prop_cs_hand_radio")
    currentRadioObject = CreateObject(GetHashKey("prop_cs_hand_radio"), 0.0, 0.0, 0.0, true, true, false)
    AttachEntityToEntity(
        currentRadioObject,
        ped,
        GetPedBoneIndex(ped, 60309),
        0.0750,
        0.0470,
        0.0110,
      -97.9442,
        3.7058,
        -23.2367,
        false, false, false, true, 2, true
    )
end

local function detachRadioFromHand()
    if DoesEntityExist(currentRadioObject) then
        DeleteEntity(currentRadioObject)
        currentRadioObject = nil
    end
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        
        if RadioAnim == "RadioDefault" then
            loadAnimDict("anim@male@holding_radio")
            
            if IsControlJustReleased(0, 20) then
                ClearPedTasks(ped)
                detachRadioFromHand()
            else
                if IsControlJustPressed(0, 20) and not IsPlayerFreeAiming(PlayerId()) then
                    attachRadioToHand()
                    TaskPlayAnim(ped, "anim@male@holding_radio", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                elseif IsControlJustPressed(0, 20) and IsPlayerFreeAiming(PlayerId()) then
                    attachRadioToHand()
                    TaskPlayAnim(ped, "anim@male@holding_radio", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                end
                if IsEntityPlayingAnim(ped, "anim@male@holding_radio", "generic_radio_enter", 3) then
                    DisableActions(ped)
                end
            end

        elseif RadioAnim == "RadioPolice" then
            loadAnimDict("random@arrests")
            
            if IsControlJustReleased(0, 20) then
                ClearPedTasks(ped)
                detachRadioFromHand()
            else
                if IsControlJustPressed(0, 20) and not IsPlayerFreeAiming(PlayerId()) then
                    TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                elseif IsControlJustPressed(0, 20) and IsPlayerFreeAiming(PlayerId()) then
                    
                    TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                end
                if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_enter", 3) or
                   IsEntityPlayingAnim(ped, "random@arrests", "radio_chatter", 3) then
                    DisableActions(ped)
                end
            end

        elseif RadioAnim == "RadioBras" then
            loadAnimDict("anim@radio_left")
            
            if IsControlJustReleased(0, 20) then
                ClearPedTasks(ped)
                detachRadioFromHand()
            else
                if IsControlJustPressed(0, 20) and not IsPlayerFreeAiming(PlayerId()) then
                    attachRadioToHand3()
                    TaskPlayAnim(ped, "anim@radio_left", "radio_left_clip", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                elseif IsControlJustPressed(0, 20) and IsPlayerFreeAiming(PlayerId()) then
                    attachRadioToHand3()
                    TaskPlayAnim(ped, "anim@radio_left", "radio_left_clip", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                end
                if IsEntityPlayingAnim(ped, "anim@radio_left", "radio_left_clip", 3) then
                    DisableActions(ped)
                end
            end
        end
        
        Wait(40)
    end
end)

exports('startRadioAnimation', function()
    local ped = PlayerPedId()
    print("^3Animation courante :^0 " .. RadioAnim)

    if RadioAnim == "RadioDefault" then
        attachRadioToHand()
        TaskPlayAnim(ped, "anim@male@holding_radio", "holding_radio_clip", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
    elseif RadioAnim == "RadioPolice" then
        
        TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
    elseif RadioAnim == "RadioBras" then
        attachRadioToHand3()
        TaskPlayAnim(ped, "anim@radio_left", "radio_left_clip", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
    else
        print("^1Aucune animation définie pour :^0 " .. RadioAnim)
    end
end)

exports('stopRadioAnimation', function()
    local ped = PlayerPedId()
    print("^2Arrêt de l'animation radio.^0")
    ClearPedTasks(ped)
    detachRadioFromHand()
end)

function DisableActions()
    while true do
        if blocked then
            DisableControlAction(1, 25, true)
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 23, true)
            DisablePlayerFiring(ped, true)
        end
        Citizen.Wait(100)
    end
end

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "open",
        status = bool
    })
end

function CheckWeapon(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #config.DrawingWeapons do
				if GetHashKey(config.DrawingWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function CheckWeapon2(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #config.AimWeapons do
				if GetHashKey(config.AimWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(50)
	end
end


