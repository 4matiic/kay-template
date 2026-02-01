XVehicleLockStatus = {
    None = 0,
    Unlocked = 1,
    Locked = 2,
    LockedForPlayer = 3,
    StickPlayerInside = 4,
    CanBeBrokenInto = 7,
    CanBeBrokenIntoPersist = 8,
    CannotBeTriedToEnter = 10,
}


local ESX = nil

CreateThread(function()
    while ESX == nil do
		ESX = exports["framework"]:getSharedObject()
        Wait(50)
    end

    while not ESX.IsPlayerLoaded() do
        Wait(50)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)


local Keys = Keys or { LEFTSHIFT = 21, E = 38, A = 34, D = 35 }
local inTrunk = false
local DamageNeededToPush = (Config and Config.DamageNeeded) or 300.0

local function DrawText3DCompat(coords, text)
    local pos = coords
    if type(coords) == 'vector3' then
        pos = { x = coords.x, y = coords.y, z = coords.z }
    end
    if ESX and ESX.Game and ESX.Game.Utils and ESX.Game.Utils.DrawText3D then
        ESX.Game.Utils.DrawText3D(pos, text, 0.4)
    else
        if ESX and ESX.ShowNotification then
            ESX.ShowNotification(text)
        end
    end
end

function startVehiclePush(targetVeh, startNow)
    local ped = PlayerPedId()
    if not DoesEntityExist(targetVeh) or not IsEntityAVehicle(targetVeh) then return end

    if IsPedInAnyVehicle(ped, false) then return end
    if not IsVehicleSeatFree(targetVeh, -1) then return end
    if GetVehicleEngineHealth(targetVeh) > DamageNeededToPush then
        if ESX and ESX.ShowNotification then
            ESX.ShowNotification("~y~Le véhicule n'est pas assez endommagé pour être poussé.")
        end
        return
    end

    local minDim, maxDim = vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0)
    GetModelDimensions(GetEntityModel(targetVeh), minDim, maxDim)
    local dims = maxDim - minDim

    local function computeFrontState()
        local vehPos = GetEntityCoords(targetVeh)
        local fwd = GetEntityForwardVector(targetVeh)
        local pedPos = GetEntityCoords(ped)
        local frontDist = #( (vehPos + fwd) - pedPos )
        local backDist  = #( (vehPos + (fwd * -1.0)) - pedPos )
        return (frontDist <= backDist)
    end

    if not startNow then
        local waitStart = GetGameTimer()
        while true do
            Wait(5)
            if not DoesEntityExist(targetVeh) then return end
            if IsPedInAnyVehicle(ped, false) then return end
            if #(GetEntityCoords(targetVeh) - GetEntityCoords(ped)) > 6.0 then return end
            if not IsVehicleSeatFree(targetVeh, -1) then return end
            if GetVehicleEngineHealth(targetVeh) > DamageNeededToPush then return end

            local textPos = GetEntityCoords(targetVeh)
            DrawText3DCompat(textPos, 'Appuyez sur [~g~SHIFT~w~] et [~g~E~w~] pour pousser le véhicule')

            if IsControlPressed(0, Keys.LEFTSHIFT) and IsControlJustPressed(0, Keys.E) then
                break
            end

            if GetGameTimer() - waitStart > 15000 then return end
        end
    end

    NetworkRequestControlOfEntity(targetVeh)
    local isInFront = computeFrontState()

    local boneIdx = GetPedBoneIndex(ped, 6286)
    if isInFront then
        AttachEntityToEntity(ped, targetVeh, boneIdx, 0.0, (dims.y * -1.0) + 0.1, dims.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
    else
        AttachEntityToEntity(ped, targetVeh, boneIdx, 0.0, (dims.y) - 0.3,      dims.z + 1.0, 0.0, 0.0,   0.0, 0.0, false, false, true, false, true)
    end

    ESX.Streaming.RequestAnimDict('missfinale_c2ig_11')
    TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
    Wait(200)

    local currentVehicle = targetVeh
    while true do
        Wait(5)
        if not DoesEntityExist(currentVehicle) then break end

        if IsControlPressed(0, Keys.A) then
            TaskVehicleTempAction(ped, currentVehicle, 11, 1000)
        end
        if IsControlPressed(0, Keys.D) then
            TaskVehicleTempAction(ped, currentVehicle, 10, 1000)
        end

        if isInFront then
            SetVehicleForwardSpeed(currentVehicle, -1.0)
        else
            SetVehicleForwardSpeed(currentVehicle, 1.0)
        end

        if HasEntityCollidedWithAnything(currentVehicle) then
            SetVehicleOnGroundProperly(currentVehicle)
        end

        if not IsControlPressed(0, Keys.E)
            or IsPedInAnyVehicle(ped, false)
            or #(GetEntityCoords(currentVehicle) - GetEntityCoords(ped)) > 8.0 then
            break
        end
    end
    DetachEntity(ped, false, false)
    StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
    FreezeEntityPosition(ped, false)
end

CreateThread(function()
    Wait(200)
    while true do
        Wait(250)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then goto continue end

        local veh, dist
        if ESX and ESX.Game and ESX.Game.GetClosestVehicle then
            veh, dist = ESX.Game.GetClosestVehicle()
        else
            local coords = GetEntityCoords(ped)
            veh = GetClosestVehicle(coords.x, coords.y, coords.z, 6.0, 0, 70)
            dist = veh and #(GetEntityCoords(veh) - coords) or 999.0
        end

        if veh and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            if dist and dist < 6.0 and IsVehicleSeatFree(veh, -1) and GetVehicleEngineHealth(veh) <= DamageNeededToPush then
                DrawText3DCompat(GetEntityCoords(veh), 'Appuyez sur [~g~SHIFT~w~] et [~g~E~w~] pour pousser le véhicule')
                if IsControlPressed(0, Keys.LEFTSHIFT) and IsControlJustPressed(0, Keys.E) then
                    startVehiclePush(veh, true)
                end
            end
        end

        ::continue::
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if inTrunk then
            local ped = PlayerPedId()
            local vehicle = GetEntityAttachedTo(ped)
            if vehicle ~= 0 and DoesEntityExist(vehicle) and not IsPedDeadOrDying(ped) and not IsPedFatallyInjured(ped) then
                local trunkIndex = GetEntityBoneIndexByName(vehicle, 'boot')
                local coords = trunkIndex ~= -1 and GetWorldPositionOfEntityBone(vehicle, trunkIndex) or GetEntityCoords(vehicle)

                SetEntityCollision(ped, false, false)
                DrawText3DCompat(coords, '[E] Sortir du coffre')

                if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                    SetEntityVisible(ped, false, false)
                else
                    if not IsEntityPlayingAnim(ped, 'timetable@floyd@cryingonbed@base', 'base', 3) then
                        RequestAnimDict('timetable@floyd@cryingonbed@base')
                        while not HasAnimDictLoaded('timetable@floyd@cryingonbed@base') do Wait(0) end
                        TaskPlayAnim(ped, 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
                    end
                    SetEntityVisible(ped, true, false)
                end

                if IsControlJustReleased(0, 38) then -- E
                    SetVehicleDoorOpen(vehicle, 5, false, false)
                    SetEntityCollision(ped, true, true)
                    Wait(750)
                    inTrunk = false
                    DetachEntity(ped, true, true)
                    SetEntityVisible(ped, true, false)
                    ClearPedTasks(ped)

                    local behindPos = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -2.0, 0.0)
                    SetEntityCoords(ped, behindPos.x, behindPos.y, behindPos.z)
                    Wait(250)
                    SetVehicleDoorShut(vehicle, 5)
                    ESX.ShowNotification("~g~Vous êtes sorti du coffre.")
                end
            else
                SetEntityCollision(PlayerPedId(), true, true)
                DetachEntity(PlayerPedId(), true, true)
                SetEntityVisible(PlayerPedId(), true, false)
                ClearPedTasks(PlayerPedId())
                inTrunk = false
                local pedCoords = GetEntityCoords(PlayerPedId())
                SetEntityCoords(PlayerPedId(), pedCoords.x, pedCoords.y - 0.5, pedCoords.z - 0.75)
            end
        end
    end
end)

local ECM = exports["kay_context"]
ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    if (not DoesEntityExist(hitEntity) or not IsEntityAVehicle(hitEntity)) then return end

	object = hitEntity
	local entityModel = GetEntityModel(object)


    local vehicle = hitEntity
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords

	local locked = GetVehicleDoorLockStatus(vehicle)
    local label = (locked == 2) and "~g~Ouvrir le véhicule" or "~r~Fermer le véhicule"
    local openOrLock = ECM:AddItem(0, label)

ECM:OnActivate(openOrLock, function()
    local plate = GetVehicleNumberPlateText(vehicle):gsub("%s+", "")
    local hasKey = false

    local success, keys = pcall(function()
        return exports.ox_inventory:Search('slots', 'carkeys')
    end)

    if not success or type(keys) ~= "table" then
        Notification("Erreur", "Impossible de vérifier les clés.", 3500)
        return
    end

    for _, item in pairs(keys) do
        if item.metadata and item.metadata.plate and item.metadata.plate == plate then
            hasKey = true
            break
        end
    end

    if not hasKey then
        Notification("Erreur", "🔑 Vous n'avez pas les clés de ce véhicule", 3500)
        return
    end

    local ped = PlayerPedId()
    local dict = "anim@mp_player_intmenu@key_fob@"
    local anim = "fob_click"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end

    local prop = GetHashKey("p_car_keys_01")
    RequestModel(prop)
    while not HasModelLoaded(prop) do Wait(0) end

    local bone = GetPedBoneIndex(ped, 57005)
    local keyProp = CreateObject(prop, 1.0, 1.0, 1.0, true, true, false)
    AttachEntityToEntity(keyProp, ped, bone, 0.13, 0.0, 0.0, 90.0, 180.0, 180.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, 1000, 49, 0, false, false, false)

    local locked = GetVehicleDoorLockStatus(vehicle)
    if locked == 2 then
        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        PlaySoundFromEntity(-1, "Remote_Control_Fob", vehicle, "PI_Menu_Sounds", false, 0)
        Notification(nil, "🚗 Véhicule déverrouillé", 3500)
    else
        SetVehicleDoorsLocked(vehicle, 2)
        SetVehicleDoorsLockedForAllPlayers(vehicle, true)
        PlaySoundFromEntity(-1, "Remote_Control_Fob", vehicle, "PI_Menu_Sounds", false, 0)
        Notification(nil, "🔒 Véhicule verrouillé", 3500)
        ExecuteCommand('stopmoteur')
    end

    Wait(800)
    DeleteObject(keyProp)
end)


	local storeVeh = ECM:AddItem(0, "Bâcher le véhicule")
	ECM:OnActivate(storeVeh, function()
        local veh = GetVehiclePedIsIn(playerPed, false)
        
        if veh and veh ~= 0 then
            local vehicleProps = ESX.Game.GetVehicleProperties(veh)
            local vehPlate = vehicleProps.plate
            local vehPosition = GetEntityCoords(veh)
            local heading = GetEntityHeading(veh)
            local class = GetVehicleClass(veh)

            TriggerServerEvent('esx_hidecar:storeHiddenVehicle', vehPlate, vehicleProps, vehPosition, class, heading)
            ESX.ShowNotification("~g~Véhicule bâché avec succès !")
        else
            ESX.ShowNotification("~r~Vous devez être dans un véhicule pour le bâcher.")
        end
	end)

    local pushItem = ECM:AddItem(0, "Pousser le véhicule")
    ECM:OnActivate(pushItem, function()
        startVehiclePush(vehicle)
    end)



    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicleCoords = GetEntityCoords(vehicle)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(vehicleCoords - playerCoords)

        if distance <= 4.0 and GetNumberOfVehicleDoors(vehicle) > 2 then
            local plate = GetVehicleNumberPlateText(vehicle)
            local netid = NetworkGetNetworkIdFromEntity(vehicle)

            if GetVehicleDoorLockStatus(vehicle) ~= 2 then
                local vehicleTrunk = ECM:AddItem(0, "Ouvrir le coffre")
                ECM:OnActivate(vehicleTrunk, function()
                    if not NetworkGetEntityIsNetworked(vehicle) then
                        Notification("Erreur", "🔒 Véhicule non synchronisé", 3500)
                        return
                    end

                    exports.ox_inventory:openInventory('trunk', {
                        id = 'trunk' .. plate,
                        netid = netid
                    })
                    Notification(nil, "🚘 Coffre ouvert", 3500)
                end)
            else
                local vehicleTrunkLocked = ECM:AddItem(0, "Coffre verrouillé")
                ECM:OnActivate(vehicleTrunkLocked, function()
                    Notification("Erreur", "🔒 Véhicule fermé", 3500)
                end)
            end
        elseif GetNumberOfVehicleDoors(vehicle) > 2 then
            local vehicleTrunkTooFar = ECM:AddItem(0, "Trop loin du coffre")
            ECM:OnActivate(vehicleTrunkTooFar, function()
                Notification("Erreur", "📏 Trop loin du véhicule", 3500)
            end)
        end
    else
        if GetVehicleDoorLockStatus(vehicle) ~= 2 then
            local vehicleGlovebox = ECM:AddItem(0, "Ouvrir la boîte à gants")
            ECM:OnActivate(vehicleGlovebox, function()
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)

                if veh ~= 0 and (GetPedInVehicleSeat(veh, -1) == ped or GetPedInVehicleSeat(veh, 0) == ped) then
                    if NetworkGetEntityIsNetworked(veh) then
                        exports.ox_inventory:openInventory('glovebox', {
                            id = 'glove' .. GetVehicleNumberPlateText(veh),
                            netid = NetworkGetNetworkIdFromEntity(veh)
                        })
                        Notification(nil, "📦 Boîte à gants ouverte", 3500)
                    else
                        Notification("Erreur", "🔒 Véhicule non synchronisé", 3500)
                    end
                else
                    Notification("Erreur", "🚗 Tu dois être à l'avant du véhicule", 3500)
                end
            end)
        else
            local gloveboxLocked = ECM:AddItem(0, "Boîte à gants fermée")
            ECM:OnActivate(gloveboxLocked, function()
                Notification("Erreur", "🔒 Véhicule fermé", 3500)
            end)
        end
    end
	
	if GetNumberOfVehicleDoors(vehicle) > 2 then
		local submenuDoor, _ = ECM:AddSubmenu(0, "Gestion des portières")
		local doorNames = {
			"Porte 1",
			"Porte 2",
			"Porte 3",
			"Porte 4",
			"Capot",
			"Coffre"
		}
	
		for i = 1, GetNumberOfVehicleDoors(vehicle) do
			local label = doorNames[i] or ("Porte " .. i)
			local itemDoor = ECM:AddItem(submenuDoor, label)
			ECM:OnActivate(itemDoor, function()
				local door = i - 1
				if GetVehicleDoorLockStatus(vehicle) ~= 2 then
					if GetVehicleDoorAngleRatio(vehicle, door) < 0.1 then
						SetVehicleDoorOpen(vehicle, door, false, false)
					else
						SetVehicleDoorShut(vehicle, door, false)
					end
				else
					Notification("Erreur", "🚗 Véhicule fermé", 3500)
				end
			end)
		end
	end

	if IsPedSittingInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        local menuVehicle = ECM:AddSubmenu(0, "Options Véhicule")

        local submenuActions = ECM:AddSubmenu(menuVehicle, "Actions véhicule")

        local engineItem = ECM:AddItem(submenuActions, "Allumer / Éteindre le moteur")
        ECM:OnActivate(engineItem, function()
            ExecuteCommand('stopmoteur')
        end)

        local limiterItem = ECM:AddItem(submenuActions, "Activer / Désactiver le limitateur")
        ECM:OnActivate(limiterItem, function()
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)

            if veh ~= 0 then
                local currentSpeed = GetEntitySpeed(veh) 
                if limitateurActif then
                    -- désactive
                    SetEntityMaxSpeed(veh, 10000.0 / 3.6)
                    limitateurActif = false
                    ESX.ShowNotification("~r~Limitateur désactivé")
                else
                    -- active
                    SetEntityMaxSpeed(veh, currentSpeed) 
                    limitateurActif = true
                    ESX.ShowNotification("~g~Limitateur activé à " .. math.floor(currentSpeed * 3.6) .. " km/h")
                end
            end
        end)



        local autopilotItem = ECM:AddItem(submenuActions, "Activer / Désactiver la conduite auto")
        ECM:OnActivate(autopilotItem, function()
            local waypoint = Citizen.InvokeNative(0xFA7C7F0AADF25D09, GetFirstBlipInfoId(8), Citizen.ResultAsVector())

            if IsWaypointActive() then
                if pilot then
                    pilot = false
                    ClearPedTasks(GetPlayerPed(-1))
                    ESX.ShowNotification("~r~Conduite automatique désactivée")
                else
                    pilot = true
                    ESX.ShowNotification("~g~Conduite automatique activée")
                    TaskVehicleDriveToCoord(
                        GetPlayerPed(-1),
                        GetVehiclePedIsIn(GetPlayerPed(-1), 0),
                        waypoint["x"], waypoint["y"], waypoint["z"],
                        100.0, 1.0,
                        GetEntityModel(vehicle), 786603, 1.0, 1
                    )
                    Citizen.CreateThread(function()
                        while pilot do
                            Wait(100)
                            local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                            if #(playerCoords - vector3(waypoint["x"], waypoint["y"], waypoint["z"])) < 10.0 then
                                while GetEntitySpeed(vehicle) - 1.0 > 0.0 do
                                    SetVehicleForwardSpeed(vehicle, GetEntitySpeed(vehicle) - 1.0)
                                    Wait(100)
                                end
                                pilot = false
                                ClearPedTasks(GetPlayerPed(-1))
                                ESX.ShowNotification("~b~Vous êtes arrivé à destination")
                            end
                        end
                    end)
                end
            else
                ESX.ShowNotification("~r~Vous devez définir un point GPS !")
            end
        end)
	end

    if not IsPedSittingInAnyVehicle(playerPed) and not IsEntityAttached(playerPed) then
        local enterBootItem = ECM:AddItem(0, "Entrer dans le coffre")
        ECM:OnActivate(enterBootItem, function()
            local ped = PlayerPedId()
            if vehicle ~= 0 and DoesEntityExist(vehicle) then
                local lockStatus = GetVehicleDoorLockStatus(vehicle)
                if lockStatus == 2 then
                    ESX.ShowNotification("~r~Véhicule fermé")
                    return
                end

                if IsEntityAttached(ped) then
                    ESX.ShowNotification("~r~Vous êtes déjà dans un coffre")
                    return
                end

                local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
                if trunk == -1 then
                    ESX.ShowNotification("~r~Ce véhicule n'a pas de coffre exploitable")
                    return
                end

                SetVehicleDoorOpen(vehicle, 5, false, false)
                Wait(350)

                AttachEntityToEntity(ped, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)

                RequestAnimDict('timetable@floyd@cryingonbed@base')
                while not HasAnimDictLoaded('timetable@floyd@cryingonbed@base') do Wait(0) end
                TaskPlayAnim(ped, 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)

                inTrunk = true

                Wait(1500)
                SetVehicleDoorShut(vehicle, 5)
                ESX.ShowNotification("~b~Vous êtes maintenant dans le coffre du véhicule.")
            else
                ESX.ShowNotification("~r~Impossible d’entrer dans le coffre.")
            end
        end)
    elseif IsEntityAttached(PlayerPedId()) then
        local leaveBootItem = ECM:AddItem(0, "Sortir du coffre")
        ECM:OnActivate(leaveBootItem, function()
            local playerPed = PlayerPedId()
            DetachEntity(playerPed, true, true)
            inTrunk = false
            ClearPedTasksImmediately(playerPed)
            SetEntityCollision(playerPed, true, true)

            local coords = GetEntityCoords(playerPed)
            SetEntityCoords(playerPed, coords.x, coords.y - 1.5, coords.z)

            if vehicle ~= 0 and DoesEntityExist(vehicle) then
                if GetVehicleDoorAngleRatio(vehicle, 5) > 0.1 then
                    SetVehicleDoorShut(vehicle, 5, false)
                end
            end

            ESX.ShowNotification("~g~Vous êtes sorti du coffre.")
        end)
    end
	
		
	local musicItem = ECM:AddItem(0, "Mettre de la musique")
	ECM:OnActivate(musicItem, function()
		if GetVehicleDoorLockStatus(vehicle) ~= 2 then
			ExecuteCommand("pmms")
		else
			Notification("Erreur", "~r~Véhicule fermé", 3500)
		end
	end)
	

	local vehID = ECM:AddItem(0, "Vehicle ID : " .. NetworkGetNetworkIdFromEntity(vehicle))
	ECM:OnActivate(vehID, function()
		lib.setClipboard(NetworkGetNetworkIdFromEntity(vehicle))
		Notification(nil, "~g~Copié dans le presse-papier", 3500)
	end)
	
		local debugSub = ECM:AddSubmenu(0, "Outils de debug")
		local debugName = ECM:AddItem(debugSub, GetEntityArchetypeName(vehicle))
		local debugCoords = ECM:AddItem(debugSub, tostring(GetEntityCoords(vehicle)))
		local debugModel = ECM:AddItem(debugSub, tostring(GetEntityModel(vehicle)))

		ECM:OnActivate(debugName, function()
			lib.setClipboard(GetEntityArchetypeName(vehicle))
			Notification(nil, "Nom archétype copié", 3500)
		end)

		ECM:OnActivate(debugCoords, function()
			lib.setClipboard(tostring(GetEntityCoords(vehicle)))
			Notification(nil, "Coordonnées copiées", 3500)
		end)

		ECM:OnActivate(debugModel, function()
			lib.setClipboard(tostring(GetEntityModel(vehicle)))
			Notification(nil, "Model copié", 3500)
		end)


		if ESX.PlayerData and ESX.PlayerData.job.name == 'police' then
			ECM:AddSeparator(0)
	
			ESX.TriggerServerCallback('ContextMenu:Vehicle:GetInfosFromPlate', function(data)
				vehicleInfos = data
			end, GetVehicleNumberPlateText(vehicle))
	
			repeat Wait(0) until vehicleInfos ~= nil
	
			if (#(coords(hitEntity) - coords(cache.ped)) <= 5.0) then
				local SASPvehicleinfo = ECM:AddSubmenu(0, "(SASP) Information")
				local SASPvehicleinfoPlate = ECM:AddItem(SASPvehicleinfo, "Plaque : "..GetVehicleNumberPlateText(vehicle))
				ECM:OnActivate(SASPvehicleinfoPlate, function()
					lib.setClipboard(GetVehicleNumberPlateText(vehicle))
					Notification(GetVehicleNumberPlateText(vehicle), "Copié dans le presse papier", 3500)
				end)
				local SASPvehicleinfoProprio = ECM:AddItem(SASPvehicleinfo, "Propriétaire : "..vehicleInfos.owner_name)
				ECM:OnActivate(SASPvehicleinfoProprio, function()
					lib.setClipboard(vehicleInfos.owner_name)
					Notification(vehicleInfos.owner_name, "Copié dans le presse papier", 3500)
				end)
			end
			
		local SASPvehicleOption = ECM:AddSubmenu(0, "(SASP) Options")
		local SASPvehicleOptionBackup1 = ECM:AddItem(SASPvehicleOption, "Demande de renfort (niveau 1)")
		local SASPvehicleOptionBackup2 = ECM:AddItem(SASPvehicleOption, "Demande de renfort (niveau 2)")
		local SASPvehicleOptionBackup3 = ECM:AddItem(SASPvehicleOption, "Demande de renfort (niveau 3)")
		
		local SASPvehicleOption2 = ECM:AddItem(SASPvehicleOption, "Appeler la fourrière")
        ECM:OnActivate(SASPvehicleOption2, function()
            if isPlayerCloseToVehicle(vehicle, 2.0) then
                ESX.Streaming.RequestAnimDict("cellphone@")
                TaskPlayAnim(playerPed, "cellphone@", "cellphone_call_listen_base", 3.0, -1, -1, 50, 0, false, false, false)

                local phoneModel = GetHashKey("prop_npc_phone_02")
                RequestModel(phoneModel)
                while not HasModelLoaded(phoneModel) do Citizen.Wait(10) end

                phoneProp = CreateObject(phoneModel, 0, 0, 0, true, true, true)
                AttachEntityToEntity(phoneProp, playerPed, GetPedBoneIndex(playerPed, 28422), 0, 0, 0, 0, 0, 0, true, true, false, true, 1, true)

                ESX.ShowNotification("Vous appelez la ~b~fourrière~w~...")
                Citizen.Wait(6000)

                ClearPedTasks(playerPed)
                if phoneProp then
                    DeleteObject(phoneProp)
                    phoneProp = nil
                end

                ESX.ShowNotification("La fourrière va passer prendre le véhicule d'ici ~b~30 secondes~w~!")
                FreezeEntityPosition(vehicle, true)
                SetVehicleEngineOn(vehicle, false, false, true)
                SetVehicleDoorsLocked(vehicle, 2)
                PlayVehicleDoorCloseSound(vehicle, 0)
                PlaySoundFromEntity(-1, "Remote_Control_Close", vehicle, "PI_Menu_Sounds", 1, 0)

                local plateToDelete = GetVehicleNumberPlateText(vehicle)
                local modelToDelete = GetEntityArchetypeName(vehicle)

                Citizen.SetTimeout(30000, function()
                    exports["AdvancedParking"]:DeleteVehicle(vehicle)
                    ESX.ShowNotification('Le véhicule ~b~' .. modelToDelete .. '~w~ immatriculé ~b~' .. plateToDelete .. ' ~w~a été pris par la ~b~fourrière~w~ !')
                end)
            else
                ESX.ShowNotification("~r~Vous devez vous rapprocher du véhicule !")
            end
        end)
        ECM:OnActivate(SASPvehicleOptionBackup1, function()
            ExecuteCommand('backup1')
        end)
        ECM:OnActivate(SASPvehicleOptionBackup2, function()
            ExecuteCommand('backup2')
        end)
        ECM:OnActivate(SASPvehicleOptionBackup3, function()
            ExecuteCommand('backup3')
        end)
	end

	if ESX.PlayerData and ESX.PlayerData.group and (
        ESX.PlayerData.group == 'fondateur' or
        ESX.PlayerData.group == 'admin' or
        ESX.PlayerData.group == 'moderateur'
    ) then

		ECM:AddSeparator(0)

		local vehicle = hitEntity
		local vehicleAdmin = ECM:AddSubmenu(0, "~r~Administrations")
		
		local vehicleAdminSuppr = ECM:AddItem(vehicleAdmin, "Supprimé")
		ECM:OnActivate(vehicleAdminSuppr, function()
			Notification(nil, "Véhicule supprimé avec succès.", 3500)
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			if not netId then
				DeleteEntity(vehicle)
			else
				TriggerServerEvent('ContextMenu:Vehicle:Delete', netId)
			end
		end)
	

		local vehicleAdminRepair = ECM:AddItem(vehicleAdmin, "Réparé")
		ECM:OnActivate(vehicleAdminRepair, function()
			Notification(nil, "Véhicule réparé avec succès.", 3500)
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			if not netId then
				SetVehicleFixed(vehicle)
				SetEntityHeading(vehicle, GetEntityHeading(vehicle))
			else
				TriggerServerEvent('ContextMenu:Vehicle:Repair', netId)
			end
		end)
		
		local vehicleAdminClear = ECM:AddItem(vehicleAdmin, "Nettoyer")
		ECM:OnActivate(vehicleAdminClear, function()
			Notification(nil, "Véhicule nettoyé avec succès.", 3500)
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			if not netId then
				SetVehicleDirtLevel(vehicle, 0.0)
			else
				TriggerServerEvent('ContextMenu:Vehicle:Wash', netId)
			end
		end)


		local vehicleAdminClear = ECM:AddItem(vehicleAdmin, "Salir")
		ECM:OnActivate(vehicleAdminClear, function()
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			if not netId then
				SetVehicleDirtLevel(vehicle, 15.0)
			else
				TriggerServerEvent('ContextMenu:Vehicle:Salir', netId)
			end
			Notification(nil, "Véhicule salie avec succès.", 3500)
		end)
		
		local vehicleAdminFreeze = ECM:AddItem(vehicleAdmin, "Freeze véhicule")
		ECM:OnActivate(vehicleAdminFreeze, function()
			Notification(nil, "Véhicule freeze avec succès.", 3500)
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			if not netId then
				FreezeEntityPosition(vehicle, true)
			else
				TriggerServerEvent('ContextMenu:Vehicle:Freeze', netId, true)
			end
		end)
		
		local vehicleAdminUnfreeze = ECM:AddItem(vehicleAdmin, "Unfreeze véhicule")
		ECM:OnActivate(vehicleAdminUnfreeze, function()
			Notification(nil, "Véhicule unfreeze avec succès.", 3500)
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			if not netId then
				FreezeEntityPosition(vehicle, false)
			else
				TriggerServerEvent('ContextMenu:Vehicle:Freeze', netId, false)
			end
		end)
		
		local vehicleAdminTp = ECM:AddItem(vehicleAdmin, "TP le véhicule sur sois")
		ECM:OnActivate(vehicleAdminTp, function()
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			ExecuteCommand("tpveh "..netId)
		end)

	
		local giveKeyItem = ECM:AddItem(vehicleAdmin, "Give les clés")
		ECM:OnActivate(giveKeyItem, function()
            local plate = GetVehicleNumberPlateText(vehicle):gsub("%s+", "")
            local modelHash = GetEntityModel(vehicle)
            local displayName = GetDisplayNameFromVehicleModel(modelHash)
            local modelName = GetLabelText(displayName)
            if not modelName or modelName == "NULL" then
                modelName = tostring(displayName)
            end
            TriggerServerEvent('sy_carkeys:BuyKeys2', plate, modelName)
            ESX.ShowNotification('Clé du véhicule demandée : ' .. plate)
		end)
		local giveCarteGrise = ECM:AddItem(vehicleAdmin, "Obtenir la carte Grise")
		ECM:OnActivate(giveCarteGrise, function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if vehicle and vehicle ~= 0 then
                local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                local plate = vehicleProps.plate
                local model = vehicleProps.model

                TriggerServerEvent('ContextMenu:BuyGrise', plate, model)
            else
                ESX.ShowNotification("~r~Vous devez être dans un véhicule.")
            end
        end)

		local vehicleAdminGizmo = ECM:AddItem(vehicleAdmin, "Gizmo")
		ECM:OnActivate(vehicleAdminGizmo, function()
			local gizmo = exports.object_gizmo:useGizmo(hitEntity)
			local netId = NetworkGetNetworkIdFromEntity(hitEntity)
			if not netId then
				local entityCoords = vector3(gizmo.position.x, gizmo.position.y, gizmo.position.z)
				local entityRotation = vector3(gizmo.rotation.x, gizmo.rotation.y, gizmo.rotation.z)
				SetEntityCoords(hitEntity, entityCoords)
				SetEntityRotation(hitEntity, entityRotation)
			else
				TriggerServerEvent('ContextMenu:Vehicle:Gizmo', netId, gizmo)
			end
		end)

        local vehicleAdminBoost = ECM:AddItem(vehicleAdmin, "Booster le véhicule")
        ECM:OnActivate(vehicleAdminBoost, function()
            if not DoesEntityExist(vehicle) then return end

            local input = exports["input"]:ShowInput("Multiplicateur de boost (ex: 1.5, 2.0...) attention c'est très rapide", false, 100, "small_text")
            local boost = tonumber(input)

            if boost == nil or boost <= 0 then
                Notification("Erreur", "Valeur invalide pour le boost.", 3500)
                return
            end

            ModifyVehicleTopSpeed(vehicle, boost)
            SetVehicleEnginePowerMultiplier(vehicle, boost * 50.0)
            SetVehicleEngineTorqueMultiplier(vehicle, boost)

            ToggleVehicleMod(vehicle, 18, true) -- turbo
            SetReduceDriftVehicleSuspension(vehicle, true)

            Notification(nil, ("Boost appliqué : x%.1f 🚀"):format(boost), 3500)
        end)

		local vehicleAdminSuppr = ECM:AddItem(vehicleAdmin, "Remplacer")
		ECM:OnActivate(vehicleAdminSuppr, function()
			Citizen.Wait(500)
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			local carHash = exports["input"]:ShowInput('Nom de la voiture que tu veut mettre a la place', false, 100, "small_text")
			local headingVeh = GetEntityHeading(vehicle)
			local coordsVeh = GetEntityCoords(vehicle)
			if not netId then
				Notification(nil, "Véhicule supprimé avec succès.", 3500)
				DeleteEntity(vehicle)
			else
				Notification(nil, "Véhicule supprimé avec succès.", 3500)
				TriggerServerEvent('ContextMenu:Vehicle:Delete', netId)
			end
			Citizen.Wait(500)
			if not IsModelInCdimage(carHash) then return end
			RequestModel(carHash)
			while not HasModelLoaded(carHash) do
			  Wait(0)
			end
			local MyPed = PlayerPedId()
			local Vehicle = CreateVehicle(carHash, coordsVeh, headingVeh, true, false)
			SetModelAsNoLongerNeeded(carHash)
			Notification(nil, "Véhicule spawn avec succès.", 3500)
		end)

		local vehicleAdminReturn = ECM:AddItem(vehicleAdmin, "Retourné")
		ECM:OnActivate(vehicleAdminReturn, function()
			Notification(nil, "Véhicule retourné avec succès.", 3500)
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			if not netId then
				SetEntityHeading(vehicle, GetEntityHeading(vehicle))
			else
				TriggerServerEvent('ContextMenu:Vehicle:Return', netId)
			end
		end)

		if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local vehicleAdminEnterForce = ECM:AddSubmenu(vehicleAdmin, "Rentrer de force")
			local vehicleAdminEnterForce1 = ECM:AddItem(vehicleAdminEnterForce, "Place 1")
			local vehicleAdminEnterForce2 = ECM:AddItem(vehicleAdminEnterForce, "Place 2")
			local vehicleAdminEnterForce3 = ECM:AddItem(vehicleAdminEnterForce, "Place 3")
			local vehicleAdminEnterForce4 = ECM:AddItem(vehicleAdminEnterForce, "Place 4")
			ECM:OnActivate(vehicleAdminEnterForce1, function()
				if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
					SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
					Notification(nil, "Vous êtes entrer de force dans le véhicule.", 3500)
				else
					Notification("Erreur", "Action impossible...", 3500)
				end
			end)
			ECM:OnActivate(vehicleAdminEnterForce2, function()
				if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
					SetPedIntoVehicle(GetPlayerPed(-1), vehicle, 0)
					Notification(nil, "Vous êtes entrer de force dans le véhicule.", 3500)
				else
					Notification("Erreur", "Action impossible...", 3500)
				end
			end)
			ECM:OnActivate(vehicleAdminEnterForce3, function()
				if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
					SetPedIntoVehicle(GetPlayerPed(-1), vehicle, 1)
					Notification("Erreur", "Action impossible...", 3500)
					Notification(nil, "Vous êtes entrer de force dans le véhicule.", 3500)
				else
					Notification("Erreur", "Action impossible...", 3500)
				end
			end)
			ECM:OnActivate(vehicleAdminEnterForce4, function()
				if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
					SetPedIntoVehicle(GetPlayerPed(-1), vehicle, 2)
					Notification(nil, "Vous êtes entrer de force dans le véhicule.", 3500)
				else
					Notification("Erreur", "Action impossible...", 3500)
				end
			end)
	    end

		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local vehicleAdminCustom = ECM:AddSubmenu(vehicleAdmin, "~y~Customiser Custom")

			local btnFullCustom = ECM:AddItem(vehicleAdminCustom, "Full Custom")
		ECM:OnActivate(btnFullCustom, function()
    	if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        SetVehicleModKit(vehicle, 0)

        SetVehicleMod(vehicle, 11, GetNumVehicleMods(vehicle, 11) - 1, false) -- Moteur
        SetVehicleMod(vehicle, 12, GetNumVehicleMods(vehicle, 12) - 1, false) -- Freins
        SetVehicleMod(vehicle, 13, GetNumVehicleMods(vehicle, 13) - 1, false) -- Transmission
        SetVehicleMod(vehicle, 15, GetNumVehicleMods(vehicle, 15) - 1, false) -- Suspension

        ToggleVehicleMod(vehicle, 18, true) -- Turbo

        SetVehicleMod(vehicle, 23, 0, true)
        SetVehicleMod(vehicle, 24, 0, true)

        SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
        SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)

        SetVehicleNumberPlateText(vehicle, "CUSTOM")

        ToggleVehicleMod(vehicle, 22, true)
        SetVehicleXenonLightsColor(vehicle, 0)

        for i = 0, 3 do
            SetVehicleNeonLightEnabled(vehicle, i, true)
        end
        SetVehicleNeonLightsColour(vehicle, 255, 255, 255)

        SetVehicleWindowTint(vehicle, 1)

        Notification(nil, "Full custom noir appliqué avec succès", 3500)
    else
        Notification("Erreur", "Vous n'êtes pas dans un véhicule.", 3500)
    end
end)


	local btnPrimary = ECM:AddItem(vehicleAdminCustom, "Couleur principale")
			ECM:OnActivate(btnPrimary, function()
				if IsPedInAnyVehicle(PlayerPedId()) then
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					local inputColor = exports["input"]:ShowInput('Par exemple : rouge, bleu, vert, noir, blanc, jaune, rose', false, 320., "small_text")
		
					local colorMap = {
						["rouge"] = {r = 255, g = 0, b = 0},
						["bleu"]  = {r = 0, g = 0, b = 255},
						["vert"]  = {r = 0, g = 255, b = 0},
						["noir"]  = {r = 0, g = 0, b = 0},
						["blanc"] = {r = 255, g = 255, b = 255},
						["jaune"] = {r = 255, g = 255, b = 0},
						["rose"]  = {r = 255, g = 105, b = 180},
					}
		
					if inputColor and colorMap[string.lower(inputColor)] then
						local rgb = colorMap[string.lower(inputColor)]
						SetVehicleCustomPrimaryColour(vehicle, rgb.r, rgb.g, rgb.b)
						Notification("Véhicule", "Couleur principale : " .. inputColor, 3500)
					else
						Notification("Erreur", "Couleur non reconnue", 3500)
					end
				else
					Notification("Erreur", "Vous n'êtes pas dans un véhicule.", 3500)
				end
			end)
		
	local btnSecondary = ECM:AddItem(vehicleAdminCustom, "Couleur secondaire")
			ECM:OnActivate(btnSecondary, function()
				if IsPedInAnyVehicle(PlayerPedId()) then
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					local inputColor = exports["input"]:ShowInput('Par exemple : rouge, bleu, vert, noir, blanc, jaune, rose', false, 320., "small_text")
		
					local colorMap = {
						["rouge"] = {r = 255, g = 0, b = 0},
						["bleu"]  = {r = 0, g = 0, b = 255},
						["vert"]  = {r = 0, g = 255, b = 0},
						["noir"]  = {r = 0, g = 0, b = 0},
						["blanc"] = {r = 255, g = 255, b = 255},
						["jaune"] = {r = 255, g = 255, b = 0},
						["rose"]  = {r = 255, g = 105, b = 180},
					}
		
					if inputColor and colorMap[string.lower(inputColor)] then
						local rgb = colorMap[string.lower(inputColor)]
						SetVehicleCustomSecondaryColour(vehicle, rgb.r, rgb.g, rgb.b)
						Notification("Véhicule", "Couleur secondaire : " .. inputColor, 3500)
					else
						Notification("Erreur", "Couleur non reconnue", 3500)
					end
				else
					Notification("Erreur", "Vous n'êtes pas dans un véhicule.", 3500)
				end
			end)
		end

		local vehicleInfos = nil

		ESX.TriggerServerCallback('ContextMenu:Vehicle:GetInfosFromPlate', function(data)
			vehicleInfos = data
		end, GetVehicleNumberPlateText(vehicle))	

		repeat Wait(0) until vehicleInfos ~= nil

		local vehicleAdminInfo = ECM:AddSubmenu(0, "~r~Information Admin")
		local vehicleAdminInfoPlate = ECM:AddItem(vehicleAdminInfo, "Plaque : "..GetVehicleNumberPlateText(vehicle))
		ECM:OnActivate(vehicleAdminInfoPlate, function()
			lib.setClipboard(GetVehicleNumberPlateText(vehicle))
			Notification(GetVehicleNumberPlateText(vehicle), "Copié dans le presse papier", 3500)
		end)

		local vehicleAdminInfoProprio = ECM:AddItem(vehicleAdminInfo, "Propriétaire : "..vehicleInfos.owner_name)
		ECM:OnActivate(vehicleAdminInfoProprio, function()
			lib.setClipboard(vehicleInfos.owner_name)
			Notification(vehicleInfos.owner_name, "Copié dans le presse papier", 3500)
		end)

		local vehicleAdminInfoProprioIdentifier = ECM:AddItem(vehicleAdminInfo, "Identifiant du propriétaire (cliquer)")
		ECM:OnActivate(vehicleAdminInfoProprioIdentifier, function()
			lib.setClipboard(vehicleInfos.owner_identifier)
			Notification(vehicleInfos.owner_identifier, "Copié dans le presse papier", 3500)
		end)

		local vehicleAdminInfoLockStatus = ECM:AddItem(vehicleAdminInfo, "Véhicule "..GetVehicleLockStatus(vehicle))
		ECM:OnActivate(vehicleAdminInfoLockStatus, function()
			exports["gflp10-carkeys"]:ToggleVehicleLock(vehicle)
			Notification(nil, "Vous avez "..GetVehicleLockStatus(vehicle).." le véhicule de force", 3500)
		end)

		local vehicleAdminInfoEngineStatus = ECM:AddItem(vehicleAdminInfo, "Moteur "..GetVehicleMotorStatus(vehicle))
		ECM:OnActivate(vehicleAdminInfoEngineStatus, function()
			exports["gflp10-carkeys"]:ToggleVehicleEngine(vehicle)
			Notification(nil, "Vous avez "..GetVehicleMotorStatus(vehicle).." le véhicule de force", 3500)
            end)
        end

        if ESX and ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
            local mechMenu = ECM:AddSubmenu(0, "~o~(Mécanicien)~w~ Interventions")
            ECM:AddSeparator(mechMenu)
            
            local washItem = ECM:AddItem(mechMenu, "Nettoyer le véhicule")
            ECM:OnActivate(washItem, function()
                local playerPed = PlayerPedId()
                local vehicle = GetClosestVehicle(GetEntityCoords(playerPed), 5.0, 0, 71)
                if vehicle then
                    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
                    Citizen.Wait(8000)
                    ClearPedTasksImmediately(playerPed)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    ESX.ShowNotification("Le véhicule a été nettoyé.")
                end
            end)

            local impoundItem = ECM:AddItem(mechMenu, "Mettre en fourrière")
            ECM:OnActivate(impoundItem, function()
                local playerPed = PlayerPedId()
                local vehicle = GetClosestVehicle(GetEntityCoords(playerPed), 5.0, 0, 71)
                if vehicle then
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                    Citizen.Wait(10000)
                    ClearPedTasksImmediately(playerPed)
                    ESX.Game.DeleteVehicle(vehicle)
                    ESX.ShowNotification("Le véhicule a été mis en Fourrière.")
                else
                    ESX.ShowNotification("~r~Aucun véhicule à proximité.")
                end
            end)

            local flatbedItem = ECM:AddItem(mechMenu, "Mettre sur le plateau")
            ECM:OnActivate(flatbedItem, function()
                local playerPed = PlayerPedId()
                local vehicle = GetClosestVehicle()
                local flatbed = GetClosestFlatbed()
                if vehicle and DoesEntityExist(vehicle) then
                    if flatbed and DoesEntityExist(flatbed) then
                        if not isVehicleOnFlatbed then
                            AttachEntityToEntity(vehicle, flatbed, 20, -0.5, -5.5, 0.85, 0.0, 0.0, 0.0, false, false, true, false, 20, true)
                            towingVehicle = vehicle
                            isVehicleOnFlatbed = true
                            ESX.ShowNotification("Véhicule placé sur le plateau.")
                        else
                            ESX.ShowNotification("Un véhicule est déjà sur le plateau.")
                        end
                    else
                        ESX.ShowNotification("Aucun flatbed à proximité.")
                    end
                else
                    ESX.ShowNotification("Aucun véhicule à proximité.")
                end
            end)

            local unflatbedItem = ECM:AddItem(mechMenu, "Retirer du plateau")
            ECM:OnActivate(unflatbedItem, function()
                local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
                if playerVeh == 0 then
                    Notification("Erreur", "Montez dans un plateau/tow.", 3500)
                    return
                end

                local model = GetEntityModel(playerVeh)
                local isFlatbed = (model == GetHashKey('flatbed')) or (model == GetHashKey('towtruck')) or (model == GetHashKey('towtruck2'))
                if not isFlatbed then
                    Notification("Erreur", "Ce véhicule n'est pas un plateau.", 3500)
                    return
                end

                if not IsEntityAttachedToEntity(vehicle, playerVeh) and not IsEntityAttached(vehicle) then
                    Notification("Erreur", "Aucun véhicule sur votre plateau.", 3500)
                    return
                end

                DetachEntity(vehicle, true, true)
                local dropPos = GetOffsetFromEntityInWorldCoords(playerVeh, 0.0, -6.0, 0.0)
                SetEntityCoords(vehicle, dropPos.x, dropPos.y, dropPos.z, false, false, false, true)
                SetVehicleOnGroundProperly(vehicle)
                SetVehicleHandbrake(vehicle, false)
                Notification(nil, "🛻 Véhicule retiré du plateau.", 3500)
            end)

        end
    end)


RegisterNetEvent('ContextMenu:Vehicle:Repair', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        SetVehicleFixed(vehicle)
        SetEntityHeading(vehicle, GetEntityHeading(vehicle))
    end
end)

RegisterNetEvent('ContextMenu:Vehicle:Return', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        SetEntityHeading(vehicle, GetEntityHeading(vehicle))
    end
end)


RegisterNetEvent("ConntextMenu:Vehicle:gotoveh", function(ped, veh)
    if not IsPedInAnyVehicle(ped) then
        SetPedIntoVehicle(ped, veh, -1)
        Notification(nil, "Vous êtes entrer de force dans le véhicule.", 3500)
    else
        Notification("Erreur", "Action impossible...", 3500)
    end
end)
ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    if not (DoesEntityExist(hitEntity) and IsEntityAVehicle(hitEntity)) then
        return
    end

    local TowSubMenu = ECM:AddSubmenu(0, 'Attacher des véhicules')
    ECM:AddItem(TowSubMenu, "Attacher le premier véhicule", function() AttachFrontVehicle() end)
    ECM:AddItem(TowSubMenu, "Attacher le deuxième véhicule", function() AttachRearVehicle() end)
    ECM:AddItem(TowSubMenu, "Détacher les véhicules", function() DetachVehicles() end)
end)
