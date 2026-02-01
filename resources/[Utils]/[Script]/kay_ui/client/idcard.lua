local ESX = exports["framework"]:getSharedObject()

local draw = false

AddEventHandler('playerSpawned', function()
    ESX.PlayerData = ESX.GetPlayerData()
end)

exports('setIdCards', function(data)
    SendReactMessage('IdCard:setIdCards', data)
end)

RegisterNetEvent('kay_ui:IdCard')
AddEventHandler('kay_ui:IdCard', function(idCardData)
    SendReactMessage('IdCard:setIdCards', {idCardData})
    Wait(10000)
    SendReactMessage('IdCard:setIdCards', {})
end)


RegisterNetEvent('kay_ui:displayIdCard')
AddEventHandler('kay_ui:displayIdCard', function(idCardData)
    local animDict = "paper_1_rcm_alt1-8"
    local animName = "player_one_dual-8"
    local propModel = "bkr_prop_fakeid_singledriverl"
    local ped = PlayerPedId()

    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestPlayerDistance > 3.0 then
    else
        TriggerServerEvent('kay_ui:showIdCardServer', GetPlayerServerId(closestPlayer), idCardData)
    end

    -- Chargement de l'animation
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    -- Chargement du props
    RequestModel(GetHashKey(propModel))
    while not HasModelLoaded(GetHashKey(propModel)) do
        Wait(10)
    end

    -- Création du props
    local propHash = GetHashKey(propModel)
    local prop = CreateObject(propHash, 0.0, 0.0, 0.0, true, true, false)
    local boneIndex = GetPedBoneIndex(ped, 28422)

    -- Attachement du props
    AttachEntityToEntity(prop, ped, boneIndex,
        0.0700,
        0.0260,
        -0.0320,
        -10.8683,
        -177.8499,
        23.6377,
        true, true, false, true, 1, true)

    -- Jouer l'animation
    TaskPlayAnim(ped, animDict, animName, 8.0, 1.0, -1, 49, 0, false, false, false)

    -- Envoi des données à l'interface
    SendReactMessage('IdCard:setIdCards', {idCardData})

    -- Attendre 10 secondes
    Wait(2750)

    -- Nettoyage
    SendReactMessage('IdCard:setIdCards', {})
    ClearPedTasks(ped)
    DeleteObject(prop)
    RemoveAnimDict(animDict)
    SetModelAsNoLongerNeeded(propModel)
end)

exports("GetVehshot", function()
    local url = nil
    local pPed = PlayerPedId()
    local oldCoords = GetEntityCoords(pPed)
    local oldHeading = GetEntityHeading(pPed)
    local minimapActive = IsRadarEnabled()
    
    -- Vérifier si le joueur est dans un véhicule
    local vehicle = GetVehiclePedIsIn(pPed, false)
    if vehicle == 0 then
        return nil -- Retourne nil si pas de véhicule
    end

    if minimapActive then
        DisplayRadar(false)
    end

    -- Sauvegarder les propriétés du véhicule
    local vehicleModel = GetEntityModel(vehicle)
    local vehicleColors = {primary = GetVehicleColours(vehicle)}
    local vehicleMods = {}
    for i = 0, 49 do
        vehicleMods[i] = GetVehicleMod(vehicle, i)
    end

    TriggerEvent('cd_easytime:PauseSync', true)
    SetEntityCoords(pPed, 743.0683, 1201.1157, 196.9905 -10, 356.4995)
    FreezeEntityPosition(pPed, true)

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, 742.8769, 1196.0880, 197.2905, 0.0)
	PointCamAtCoord(cam, 742.8769, 1196.0880, 197.2905, 0.0)
    RenderScriptCams(true, false, 1500, true, true)

    -- Charger le modèle du véhicule
    if not HasModelLoaded(vehicleModel) then
        RequestModel(vehicleModel)
        repeat Wait(0) until HasModelLoaded(vehicleModel)
    end

    NetworkOverrideClockTime(15, 15, 00)
    SetWeatherTypeNow('EXTRASUNNY')

    -- Créer une copie du véhicule
    local clonedVehicle = CreateVehicle(vehicleModel, 743.0683, 1201.5, 196.9905 -1, 140.0, false, true)
    
    -- Appliquer les mêmes modifications que le véhicule original
    SetVehicleColours(clonedVehicle, vehicleColors.primary)
    for modType, modIndex in pairs(vehicleMods) do
        SetVehicleMod(clonedVehicle, modType, modIndex, false)
    end

    FreezeEntityPosition(clonedVehicle, true)
    SetEntityInvincible(clonedVehicle, true)
    SetVehicleDoorsLocked(clonedVehicle, 2)
    SetVehicleDirtLevel(clonedVehicle, 0.0)

    Wait(3000)

    exports['screenshot-basic']:requestScreenshotUpload('https://api.fivemanage.com/api/image?apiKey=OmCQ3dR2f6UMQUr2IgUc97oqCaGh2tAx', 'image', function(data)
        local resp = json.decode(data)
        if resp then
            DeleteEntity(clonedVehicle)

            RenderScriptCams(false, false, 0, true, true)
            DestroyCam(cam, true)

            SetEntityCoords(pPed, oldCoords)
            SetEntityHeading(pPed, oldHeading)
            FreezeEntityPosition(pPed, false)
            SetPedIntoVehicle(pPed, vehicle, -1)

            if minimapActive then
                DisplayRadar(true)
            end
            url = resp.url
        end
    end)
    repeat Wait(0) until url
    lib.setClipboard(url)
    TriggerEvent('cd_easytime:PauseSync', false)
    return url
end)

exports("GetMugshot", function()
	local url = nil
	local pPed = PlayerPedId()
	local oldCoords = GetEntityCoords(pPed)
	local oldHeading = GetEntityHeading(pPed)
	local minimapActive = IsRadarEnabled()

	if minimapActive then
		DisplayRadar(false)
	end

	TriggerEvent('cd_easytime:PauseSync', true)
	SetEntityCoords(pPed, 743.0683, 1199.4, 196.9905 -1)
    SetEntityHeading(pPed, 0.0)
	FreezeEntityPosition(pPed, true)

	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(cam, 743.0683, 1201.1157, 197.0, 0.0)
	PointCamAtCoord(cam, 743.0683, 1196.0880, 197.0, 0.0)
    RenderScriptCams(true, false, 1500, true, true)

	NetworkOverrideClockTime(6, 30, 00)
	SetWeatherTypeNow('EXTRASUNNY')

    -- faire jouer l'animation cop2

    local animDict = "anim@amb@nightclub@peds@"
    local animName = "rcmme_amanda1_stand_loop_cop"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    TaskPlayAnim(pPed, animDict, animName, 8.0, 8.0, -1, 1, 0, false, false, false)

	Wait(3000)

	exports['screenshot-basic']:requestScreenshotUpload('https://api.fivemanage.com/api/image?apiKey=OmCQ3dR2f6UMQUr2IgUc97oqCaGh2tAx', 'image', function(data)
		local resp = json.decode(data)
		if resp then
			--DeleteEntity(ped)
            ClearPedTasks(pPed)

			RenderScriptCams(false, false, 0, true, true)
			DestroyCam(cam, true)

			SetEntityCoords(pPed, oldCoords)
			SetEntityHeading(pPed, oldHeading)
			FreezeEntityPosition(pPed, false)

			if minimapActive then
				DisplayRadar(true)
			end
			url = resp.url
		end
	end)
	repeat Wait(0) until url
	TriggerEvent('cd_easytime:PauseSync', false)
    lib.setClipboard(url)
	return url
end)

-- POINT
local IdCard = {
    { coords = vector3(-555.5188, -603.0844, 33.80), notification = "Appuyez sur ~INPUT_CONTEXT~ pour obtenir sa carte d'identité", eventName = "fb:idcard:creation" },
 ----   { coords = vector3(-552.30, -635.94, 33.80), notification = "Appuyez sur ~INPUT_CONTEXT~ pour obtenir sa carte d'identité", eventName = "fb:idgrise:creation" }
}

for _, v in ipairs(IdCard) do
    lib.points.new({
        coords = v.coords,
        distance = 3,
        onEnter = function(self)
            ESX.ShowHelpNotification(v.notification, true, true, -1)
        end,
        
        onExit = function(self)
            ESX.ShowHelpNotification(" ", false, false, 1)
        end,
     
        nearby = function(self)
        local Marker = {
            R = 0,
            G = 0,
            B = 0,
        }
        DrawMarker(6, vector3(v.coords), 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, Marker.R, Marker.G, Marker.B, 150, false, true, 2, false, false, false, false)
     
        if self.currentDistance < 2 and IsControlJustReleased(0, 38) then
            if ESX.PlayerData.job then
                playerJob = ESX.PlayerData.job.name
            end
            if v.RequiredJob == nil or v.RequiredJob == playerJob then
                local url = exports['kay_ui']:GetMugshot()
                TriggerServerEvent(v.eventName, ESX.GetPlayerData().lastName, ESX.GetPlayerData().firstName, ESX.GetPlayerData().dateofbirth, ESX.GetPlayerData().sex, url)
            else
                CORE.Notify(nil, nil, nil, nil, "Vous n'avez pas le groupe nécessaire.", 5000)
            end
        end
    end})
end