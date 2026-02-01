local ECM = exports["kay_context"]

local function tryGetESX()
    local ok, obj = pcall(function()
        return exports['framework']:getSharedObject()
    end)
    if not (hitEntity and hitEntity ~= 0 and DoesEntityExist(hitEntity) and IsEntityAnObject(hitEntity)) then
        return
    end
    local propName = GetEntityModel(hitEntity)
    if ok then return obj end
end
local ESX = tryGetESX()

local AfficherPseudoValue = false
local DebugCoordsValue = false
local DebugObjectOutlinesValue = false
local DebugEntityIDsValue = false
local DebugEntityModelsValue = false
local DebugEntityModelsPedValue = false
local DebugEntityModelsVehicleValue = false
local DebugPropsIDsValue = false
local DebugLightIDsValue = false
local DebugParticleIDsValue = false
local DebugVehicleSpeedValue = false
local DebugAllVehicleInfosValue = false
local DebugBonesVehicleValue = false
local DebugBonesPedValue = false
local DebugMarkerIDsValue = false

local function EnumerateObjects()
    return coroutine.wrap(function()
        local handle, object = FindFirstObject()
        if handle == -1 then return end
        local success = true
        repeat
            if DoesEntityExist(object) then
                coroutine.yield(object)
            end
            success, object = FindNextObject(handle)
        until not success
        EndFindObject(handle)
    end)
end

local function RotationToDirection(rot)
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end

local function hasPermission()
    if ESX and ESX.GetPlayerData then
        local data = ESX.GetPlayerData()
        if data and data.group then
            local g = string.lower(tostring(data.group))
            if g == 'admin' or g == 'superadmin' or g == 'owner' then
                return true
            end
        end
    end
    if type(GetGroup) ~= 'nil' then
        return GetGroup == "admin" or GetGroup == "superadmin" or GetGroup == "owner"
    end
    return true
end

ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    if DoesEntityExist(hitEntity) then
        return
    end

    if not hasPermission() then
        return
    end

    local AfficherPseudo = ECM:AddCheckboxItem(0, "Afficher les noms", AfficherPseudoValue)
    ECM:OnValueChanged(AfficherPseudo, function(value)
        AfficherPseudoValue = value
        TriggerEvent('admin:togglePlayerNames', value)
        if ESX and ESX.ShowNotification then
            if value then
                ESX.ShowNotification("~g~Noms des joueurs affichés")
            else
                ESX.ShowNotification("~r~Noms des joueurs cachés")
            end
        end
    end)

    local Debug = ECM:AddSubmenu(0, "Outils de Debug")

    local DebugDebug = ECM:AddItem(Debug, "Désactiver tous les debug")
    ECM:OnActivate(DebugDebug, function()
        AfficherPseudoValue = false
        DebugVehicleSpeedValue = false
        DebugCoordsValue = false
        DebugEntityModelsVehicleValue = false
        DebugEntityModelsPedValue = false
        DebugObjectOutlinesValue = false
        DebugEntityIDsValue = false
        DebugEntityModelsValue = false
        DebugPropsIDsValue = false
        DebugLightIDsValue = false
        DebugParticleIDsValue = false
        DebugMarkerIDsValue = false
        DebugAllVehicleInfosValue = false
        DebugBonesVehicleValue = false
        DebugBonesPedValue = false
        AimTargetInfoValue = false

        for object in EnumerateObjects() do
            if DoesEntityExist(object) then
                SetEntityDrawOutline(object, false)
            end
        end
        for ped in (function()
            return coroutine.wrap(function()
                local h, p = FindFirstPed()
                if h == -1 then return end
                local ok = true
                repeat
                    if DoesEntityExist(p) then coroutine.yield(p) end
                    ok, p = FindNextPed(h)
                until not ok
                EndFindPed(h)
            end)
        end)() do
            if DoesEntityExist(ped) then
                SetEntityDrawOutline(ped, false)
            end
        end
    end)

    local DebugCoords = ECM:AddCheckboxItem(Debug, "Voir les coordonnées", DebugCoordsValue)
    ECM:OnValueChanged(DebugCoords, function(value) DebugCoordsValue = value end)

    local DebugObjectOutlines = ECM:AddCheckboxItem(Debug, "Voir les contours des objets", DebugObjectOutlinesValue)
    ECM:OnValueChanged(DebugObjectOutlines, function(value) DebugObjectOutlinesValue = value end)

    local DebugEntityIDs = ECM:AddCheckboxItem(Debug, "Voir les id des entités", DebugEntityIDsValue)
    ECM:OnValueChanged(DebugEntityIDs, function(value) DebugEntityIDsValue = value end)

    local DebugEntityModels = ECM:AddCheckboxItem(Debug, "Voir les models des entités", DebugEntityModelsValue)
    ECM:OnValueChanged(DebugEntityModels, function(value) DebugEntityModelsValue = value end)

    local DebugEntityModelsPed = ECM:AddCheckboxItem(Debug, "Voir les models des peds", DebugEntityModelsPedValue)
    ECM:OnValueChanged(DebugEntityModelsPed, function(value) DebugEntityModelsPedValue = value end)

    local DebugEntityModelsVehicle = ECM:AddCheckboxItem(Debug, "Voir les models des véhicules", DebugEntityModelsVehicleValue)
    ECM:OnValueChanged(DebugEntityModelsVehicle, function(value) DebugEntityModelsVehicleValue = value end)

    local DebugPropsIDs = ECM:AddCheckboxItem(Debug, "Voir les id des props", DebugPropsIDsValue)
    ECM:OnValueChanged(DebugPropsIDs, function(value) DebugPropsIDsValue = value end)

    local DebugLightIDs = ECM:AddCheckboxItem(Debug, "Voir les id des lumières", DebugLightIDsValue)
    ECM:OnValueChanged(DebugLightIDs, function(value) DebugLightIDsValue = value end)

    local DebugParticleIDs = ECM:AddCheckboxItem(Debug, "Voir les id des particules", DebugParticleIDsValue)
    ECM:OnValueChanged(DebugParticleIDs, function(value) DebugParticleIDsValue = value end)

    local DebugVehicleSpeed = ECM:AddCheckboxItem(Debug, "Voir la vitesse des véhicules", DebugVehicleSpeedValue)
    ECM:OnValueChanged(DebugVehicleSpeed, function(value) DebugVehicleSpeedValue = value end)

    local DebugAllVehicleInfos = ECM:AddCheckboxItem(Debug, "Voir toutes les infos véhicules", DebugAllVehicleInfosValue)
    ECM:OnValueChanged(DebugAllVehicleInfos, function(value) DebugAllVehicleInfosValue = value end)

    local DebugBonesVehicle = ECM:AddCheckboxItem(Debug, "Voir les bone du véhicule", DebugBonesVehicleValue)
    ECM:OnValueChanged(DebugBonesVehicle, function(value) DebugBonesVehicleValue = value end)

    local DebugBonesPed = ECM:AddCheckboxItem(Debug, "Voir les bone du ped", DebugBonesPedValue)
    ECM:OnValueChanged(DebugBonesPed, function(value) DebugBonesPedValue = value end)
end)


local function DrawText2D(x, y, text, scale, r, g, b, a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale or 0.35, scale or 0.35)
    SetTextColour(r or 255, g or 255, b or 255, a or 215)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end

local function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local camCoords = GetGameplayCamCoord()
        local dist = #(vector3(x, y, z) - camCoords)
        local s = (scale or 0.35) / (dist / 5.0)
        if s < 0.25 then s = 0.25 end
        DrawText2D(_x, _y, text, s, 255, 255, 255, 230)
    end
end

local function EnumeratePeds()
    return coroutine.wrap(function()
        local handle, ped = FindFirstPed()
        if handle == -1 then return end
        local success = true
        repeat
            if DoesEntityExist(ped) then
                coroutine.yield(ped)
            end
            success, ped = FindNextPed(handle)
        until not success
        EndFindPed(handle)
    end)
end

local function EnumerateVehicles()
    return coroutine.wrap(function()
        local handle, veh = FindFirstVehicle()
        if handle == -1 then return end
        local success = true
        repeat
            if DoesEntityExist(veh) then
                coroutine.yield(veh)
            end
            success, veh = FindNextVehicle(handle)
        until not success
        EndFindVehicle(handle)
    end)
end

local cachedPeds, cachedVehicles, cachedObjects = {}, {}, {}
local cacheLastUpdate = 0
local particleRegistry = {} 

local function refreshEntityCaches(radius)
    cachedPeds, cachedVehicles, cachedObjects = {}, {}, {}
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)
    local r2 = (radius or 60.0) ^ 2

    for ped in EnumeratePeds() do
        if ped ~= plyPed then
            local c = GetEntityCoords(ped)
            if Vdist2(c.x, c.y, c.z, plyCoords.x, plyCoords.y, plyCoords.z) <= r2 then
                cachedPeds[#cachedPeds+1] = ped
            end
        end
    end
    for veh in EnumerateVehicles() do
        local c = GetEntityCoords(veh)
        if Vdist2(c.x, c.y, c.z, plyCoords.x, plyCoords.y, plyCoords.z) <= r2 then
            cachedVehicles[#cachedVehicles+1] = veh
        end
    end
    for obj in EnumerateObjects() do
        local c = GetEntityCoords(obj)
        if Vdist2(c.x, c.y, c.z, plyCoords.x, plyCoords.y, plyCoords.z) <= r2 then
            cachedObjects[#cachedObjects+1] = obj
        end
    end
end

local outlinedObjects = {}
local outlinedPeds = {}
local lastObjOutline = false
local lastPedOutline = false

local function clearOutlines(set)
    for ent, _ in pairs(set) do
        if DoesEntityExist(ent) then
            SetEntityDrawOutline(ent, false)
        end
        set[ent] = nil
    end
end


CreateThread(function()
    while true do
        Wait(0)
        
        local time = GetGameTimer()
        if time - cacheLastUpdate > 2000 then
            refreshEntityCaches(60.0)
            cacheLastUpdate = time
        end

        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)

        if AfficherPseudoValue then
            local players = {}
            if GetActivePlayers ~= nil then
                players = GetActivePlayers()
            else
                for i = 0, 255 do
                    if NetworkIsPlayerActive(i) then
                        players[#players+1] = i
                    end
                end
            end
            local r2 = 70.0 * 70.0
            for _, pid in ipairs(players) do
                if pid ~= PlayerId() then
                    local ped = GetPlayerPed(pid)
                    if ped ~= 0 and DoesEntityExist(ped) then
                        local c = GetEntityCoords(ped)
                        if Vdist2(c.x, c.y, c.z, plyCoords.x, plyCoords.y, plyCoords.z) <= r2 then
                            local name = GetPlayerName(pid) or "[?]"
                            DrawText3D(c.x, c.y, c.z + 1.05, ("%s"):format(name), 0.36)
                        end
                    end
                end
            end
        end

        if DebugCoordsValue then
            local h = GetEntityHeading(plyPed)
            local text = ("Coords: ~b~%.2f %.2f %.2f~s~ | Heading: ~b~%.1f"):format(plyCoords.x, plyCoords.y, plyCoords.z, h)
            DrawText2D(0.015, 0.75, text, 0.35, 255, 255, 255, 220)
        end

        if DebugObjectOutlinesValue ~= lastObjOutline then
            if not DebugObjectOutlinesValue then
                clearOutlines(outlinedObjects)
            end
            lastObjOutline = DebugObjectOutlinesValue
        end
        
        if DebugObjectOutlinesValue then
            for _, obj in ipairs(cachedObjects) do
                if DoesEntityExist(obj) and not outlinedObjects[obj] then
                    SetEntityDrawOutline(obj, true)
                    outlinedObjects[obj] = true
                end
            end
        end

        local veh = GetVehiclePedIsIn(plyPed, false)
        if veh ~= 0 then
            if DebugVehicleSpeedValue or DebugAllVehicleInfosValue then
                local speedKmh = GetEntitySpeed(veh) * 3.6
                DrawText2D(0.015, 0.78, ("Vitesse: ~b~%d km/h"):format(math.floor(speedKmh + 0.5)), 0.38, 255,255,255,220)
            end
            if DebugAllVehicleInfosValue then
                local gear = GetVehicleCurrentGear(veh)
                local rpm = GetVehicleCurrentRpm(veh) * 100
                local engH = GetVehicleEngineHealth(veh)
                local bodH = GetVehicleBodyHealth(veh)
                local fuel = (GetVehicleFuelLevel and GetVehicleFuelLevel(veh)) or 0.0
                DrawText2D(0.015, 0.805, ("Rapport: ~b~%d~s~ | RPM: ~b~%d%%"):format(gear, math.floor(rpm)), 0.34, 255,255,255,220)
                DrawText2D(0.015, 0.83, ("Moteur: ~b~%d~s~ | Carrosserie: ~b~%d~s~ | Carburant: ~b~%d"):format(engH, bodH, math.floor(fuel)), 0.34, 255,255,255,220)
            end
        end

        if DebugEntityIDsValue or DebugEntityModelsValue or DebugEntityModelsPedValue or DebugEntityModelsVehicleValue or DebugPropsIDsValue then
            local showIDsAll = DebugEntityIDsValue
            local showModelsAll = DebugEntityModelsValue

            if #cachedPeds > 0 then
                for _, ped in ipairs(cachedPeds) do
                    if DoesEntityExist(ped) then
                        local pos = GetEntityCoords(ped)
                        local label = nil
                        if DebugEntityModelsPedValue or showModelsAll then
                            label = (label and label .. "\n" or "") .. ("Ped model: ~b~%s~s~"):format(GetEntityModel(ped))
                        end
                        if showIDsAll then
                            label = (label and label .. "\n" or "") .. ("Ped id: ~b~%s~s~"):format(ped)
                        end
                        if label then DrawText3D(pos.x, pos.y, pos.z + 1.0, label, 0.35) end
                    end
                end
            end
            if #cachedVehicles > 0 then
                for _, v in ipairs(cachedVehicles) do
                    if DoesEntityExist(v) then
                        local pos = GetEntityCoords(v)
                        local label = nil
                        if DebugEntityModelsVehicleValue or showModelsAll then
                            label = (label and label .. "\n" or "") .. ("Veh model: ~b~%s~s~"):format(GetEntityModel(v))
                        end
                        if showIDsAll then
                            label = (label and label .. "\n" or "") .. ("Veh id: ~b~%s~s~"):format(v)
                        end
                        if label then DrawText3D(pos.x, pos.y, pos.z + 1.0, label, 0.35) end
                    end
                end
            end
            if #cachedObjects > 0 then
                for _, o in ipairs(cachedObjects) do
                    if DoesEntityExist(o) then
                        local pos = GetEntityCoords(o)
                        local label = nil
                        if showModelsAll then
                            label = (label and label .. "\n" or "") .. ("Obj model: ~b~%s~s~"):format(GetEntityModel(o))
                        end
                        if DebugPropsIDsValue or showIDsAll then
                            label = (label and label .. "\n" or "") .. ("Obj id: ~b~%s~s~"):format(o)
                        end
                        if label then DrawText3D(pos.x, pos.y, pos.z + 0.8, label, 0.33) end
                    end
                end
            end
        end

        if DebugBonesVehicleValue and veh ~= 0 then
            local vehicleBones = { 'engine', 'exhaust', 'wheel_lf', 'wheel_rf', 'wheel_lr', 'wheel_rr', 'platelight' }
            for _, name in ipairs(vehicleBones) do
                local idx = GetEntityBoneIndexByName(veh, name)
                if idx ~= -1 then
                    local pos = GetWorldPositionOfEntityBone(veh, idx)
                    DrawMarker(2, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.15, 0.15, 0.15, 0, 200, 255, 180, false, true, 2, nil, nil, false)
                    DrawText3D(pos.x, pos.y, pos.z + 0.05, name, 0.3)
                end
            end
        end

        if DebugBonesPedValue then
            local ped = plyPed
            local pedBones = { 'SKEL_Head', 'SKEL_R_Hand', 'SKEL_L_Hand', 'SKEL_R_Foot', 'SKEL_L_Foot', 'SKEL_Spine_Root' }
            for _, name in ipairs(pedBones) do
                local idx = GetEntityBoneIndexByName(ped, name)
                if idx ~= -1 then
                    local pos = GetWorldPositionOfEntityBone(ped, idx)
                    DrawMarker(2, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 120, 0, 180, false, true, 2, false, nil, nil, false)
                    DrawText3D(pos.x, pos.y, pos.z + 0.05, name, 0.28)
                end
            end
        end
    end
end)

local notifiedUnsupported = { LightIDs=false, ParticleIDs=false, MarkerIDs=false }
local function notifyOnce(key, msg)
    if not notifiedUnsupported[key] then
        if ESX and ESX.ShowNotification then
            ESX.ShowNotification(msg)
        else
            BeginTextCommandThefeedPost("STRING")
            AddTextComponentSubstringPlayerName(msg)
            EndTextCommandThefeedPostTicker(true, true)
        end
        notifiedUnsupported[key] = true
    end
end

CreateThread(function()
    while true do
        Wait(200)
        if DebugLightIDsValue then notifyOnce('LightIDs', '~y~Info:~s~ Affichage des id des lumieres non supporte (natives indisponibles).') end
        if DebugParticleIDsValue then notifyOnce('ParticleIDs', '~y~Info:~s~ Affichage des id des particules non supporte.') end
        if DebugMarkerIDsValue then notifyOnce('MarkerIDs', '~y~Info:~s~ Affichage des id des markers non supporte.') end
    end
end)

RegisterNetEvent('contextmenu:registerParticle')
AddEventHandler('contextmenu:registerParticle', function(id, x, y, z, name)
    if id == nil then return end
    if type(x) == 'vector3' then
        particleRegistry[id] = { pos = x, name = name }
    else
        particleRegistry[id] = { pos = vector3(tonumber(x) or 0.0, tonumber(y) or 0.0, tonumber(z) or 0.0), name = name }
    end
end)

RegisterNetEvent('contextmenu:unregisterParticle')
AddEventHandler('contextmenu:unregisterParticle', function(id)
    if id == nil then return end
    particleRegistry[id] = nil
end)