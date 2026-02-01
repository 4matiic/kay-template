Config = {}
Config.useFBUI = true
Config.UseRpProgress = true -- https://github.com/Mobius1/rprogress

function Notification(title, message, duration) -- Add your notify exports
	exports['ava']:addNotification(nil, nil, nil, title, message, duration, nil)
	--lib.notify({
	--	title = title,
	--	description = message,
	--	duration = duration
	--})
end
function HelpNotification(message, beep, duration) -- Add your help notify exports
	ESX.ShowHelpNotification(message, nil, beep, duration)
end


function GetVehicleLockStatus(vehicle) -- Get doorlock status
	if GetVehicleDoorLockStatus(vehicle) ~= 2 then
		return "ouvert" -- open
	else
		return "fermer" -- close
	end
end
function GetVehicleMotorStatus(vehicle) -- Get engine status
	if GetIsVehicleEngineRunning(vehicle) ~= 1 then
		return "éteint"
	else
		return "allumé"
	end
end
function GetVector4(entity) -- Get vector4 position
    local c, h = GetEntityCoords(entity), GetEntityHeading(entity)
    return vec4(c.x, c.y, c.z, h)
end
function GetVector3(entity) -- Get vector3 position
    local c = GetEntityCoords(entity)
    return vec3(c.x, c.y, c.z)
end
function GetVector2(entity) -- Get vector2 position
    local c = GetEntityCoords(entity)
    return vec2(c.x, c.y)
end
function GetHeanding(entity) -- Get heading position
    local h = GetEntityHeading(entity)
    return vec3(h)
end


-- ==========================
-- CONFIGURATION
-- ==========================
local ropeLength = 8.0
local maxTowingSpeed = 40.0

local entity1, entity2 = nil, nil
local tempRope, localRope = nil, nil
local driverPed = nil

-- ==========================
-- 🔍 Trouver le véhicule le plus proche
-- ==========================
function GetNearestVehicle(x, y, z, radius)
    local vehicles = GetGamePool('CVehicle')
    local closestVeh, minDist = nil, radius

    for _, veh in ipairs(vehicles) do
        local vehCoords = GetEntityCoords(veh)
        local dist = #(vector3(x, y, z) - vehCoords)
        if dist < minDist then
            minDist = dist
            closestVeh = veh
        end
    end

    return closestVeh
end

-- ==========================
-- ⚙️ Fonctions d’attache (positions)
-- ==========================
function GetBoneFront(vehicle)
    -- Cherche un bone avant commun, sinon fallback
    if GetEntityBoneIndexByName(vehicle, "engine") ~= -1 then
        return "engine"
    elseif GetEntityBoneIndexByName(vehicle, "bonnet") ~= -1 then
        return "bonnet"
    else
        return "chassis"
    end
end

function GetBoneRear(vehicle)
    -- Cherche un bone arrière commun, sinon fallback
    if GetEntityBoneIndexByName(vehicle, "boot") ~= -1 then
        return "boot"
    elseif GetEntityBoneIndexByName(vehicle, "trunk") ~= -1 then
        return "trunk"
    else
        return "chassis"
    end
end

-- ==========================
-- 🔗 Attacher le véhicule avant
-- ==========================
function AttachFrontVehicle()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local veh = GetNearestVehicle(coords.x, coords.y, coords.z, 5.0)

    if veh and veh ~= 0 and veh ~= entity2 then
        entity1 = veh
        AttachTempRope(entity1, true)
    else
        print("[TOWING] Aucun véhicule avant trouvé ou déjà sélectionné.")
    end
end

-- ==========================
-- 🔗 Attacher le véhicule arrière
-- ==========================
function AttachRearVehicle()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local veh = GetNearestVehicle(coords.x, coords.y, coords.z, 5.0)

    if veh and veh ~= 0 and veh ~= entity1 then
        entity2 = veh
        AttemptAttachRope()
    else
        print("[TOWING] Aucun véhicule arrière trouvé ou déjà sélectionné.")
    end
end

-- ==========================
-- ❌ Détacher les véhicules
-- ==========================
function DetachVehicles()
    if entity1 and entity2 then
        TriggerServerEvent('towing:detachVehicles')

        if localRope then
            DeleteRope(localRope)
            SetEntityMaxSpeed(entity1, 99999.0)
            SetEntityMaxSpeed(entity2, 99999.0)
            localRope = nil
        end
    elseif tempRope then
        DeleteRope(tempRope)
        tempRope = nil
    end

    if driverPed then
        DeletePed(driverPed)
        driverPed = nil
    end

    entity1, entity2 = nil, nil
end

-- ==========================
-- 🧶 Attache temporaire au joueur
-- ==========================
function AttachTempRope(entity, front)
    local playerPed = PlayerPedId()
    local bone = front and GetBoneRear(entity) or GetBoneFront(entity)
    local pos = GetEntityCoords(playerPed)

    if tempRope then
        DeleteRope(tempRope)
        tempRope = nil
    end

    RopeLoadTextures()
    while not RopeAreTexturesLoaded() do Wait(50) end

    local boneIndex = GetEntityBoneIndexByName(entity, bone)
    local bonePos = GetWorldPositionOfEntityBone(entity, boneIndex)
    if #(bonePos - pos) <= ropeLength * 1.5 then
        tempRope = AddRope(pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, ropeLength * 0.2, 1, ropeLength * 0.75, 0.1, 10.0, true, false, true, 1.0, false)
        AttachEntitiesToRope(tempRope, playerPed, entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, ropeLength - 2.0, true, true, "IK_R_Hand", bone)
    end
end

-- ==========================
-- 🪢 Tentative d’attache des deux véhicules
-- ==========================
function AttemptAttachRope()
    if entity1 and entity2 then
        if tempRope then
            DeleteRope(tempRope)
            tempRope = nil
        end

        local veh1 = NetworkGetNetworkIdFromEntity(entity1)
        local veh2 = NetworkGetNetworkIdFromEntity(entity2)

        TriggerServerEvent('towing:attachVehicles', veh1, veh2)
    else
        print("[TOWING] Impossible d’attacher — véhicules non définis.")
    end
end

-- ==========================
-- 🌐 Événements réseau
-- ==========================
RegisterNetEvent('towing:makeRope', function(veh1_, veh2_)
    if NetworkDoesEntityExistWithNetworkId(veh1_) and NetworkDoesEntityExistWithNetworkId(veh2_) then
        local veh1 = NetworkGetEntityFromNetworkId(veh1_)
        local veh2 = NetworkGetEntityFromNetworkId(veh2_)

        if veh1 and veh2 then
            SetEntityMaxSpeed(veh1, maxTowingSpeed / 2.3)
            SetEntityMaxSpeed(veh2, maxTowingSpeed / 2.3)

            local pos = GetEntityCoords(veh1)
            RopeLoadTextures()
            while not RopeAreTexturesLoaded() do Wait(50) end

            local rope = AddRope(pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, ropeLength * 0.3, 1, ropeLength, 0.1, 10.0, true, false, true, 1.0, false)
            AttachEntitiesToRope(rope, veh1, veh2, 0.0, 0.0, 0.1, 0.0, 0.0, 0.1, ropeLength, false, false, GetBoneRear(veh1), GetBoneFront(veh2))
            localRope = rope
        end
    end
end)

RegisterNetEvent('towing:removeRope', function()
    DetachVehicles()
end)


-- PORTER SUR LE DOS
local carry = {
    InProgress = false,
    targetSrc = -1,
    type = "",
    personCarrying = {
        animDict = "missfinale_c2mcs_1",
        anim = "fin_c2_mcs_1_camman",
        flag = 49,
    },
    personCarried = {
        animDict = "nm",
        anim = "firemans_carry",
        attachX = 0.27,
        attachY = 0.15,
        attachZ = 0.63,
        flag = 33,
    }
}
-- PORTER SUR LE VENTRE
local carry2 = {
    InProgress = false,
    targetSrc = -1,
    type = "",
    personCarrying = {
        animDict = "mxclip_a",
        anim = "mx@piggypack_a",
        flag = 49,
    },
    personCarried = {
        animDict = "mxanim_b",
        anim = "mx@piggypack_b",
        attachX = 0.27,
        attachY = 0.15,
        attachZ = 0.63,
        flag = 33,
    }
}



function DrawText2D(x, y, text, scale)
    SetTextFont(4)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function EnumerateVehicles()
    return coroutine.wrap(function()
        local handle, vehicle = FindFirstVehicle()
        if not handle or handle == -1 then
            EndFindVehicle(handle)
            return
        end
        local success
        repeat
            coroutine.yield(vehicle)
            success, vehicle = FindNextVehicle(handle)
        until not success
        EndFindVehicle(handle)
    end)
end


function GetClosestVehicle()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local radius = 5.0
    local closestVehicle = nil
    local closestDistance = radius
    for vehicle in EnumerateVehicles() do
        if DoesEntityExist(vehicle) then
            local model = GetEntityModel(vehicle)
            if model ~= GetHashKey("flatbed") then
                local vehiclePos = GetEntityCoords(vehicle)
                local distance = #(playerPos - vehiclePos)
                if distance < closestDistance then
                    closestVehicle = vehicle
                    closestDistance = distance
                end
            end
        end
    end

    return closestVehicle
end

function GetClosestFlatbed()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local radius = 10.0
    local closestFlatbed = nil
    local closestDistance = radius

    for vehicle in EnumerateVehicles() do
        if DoesEntityExist(vehicle) then
            local model = GetEntityModel(vehicle)
            if model == GetHashKey("flatbed") then
                local vehiclePos = GetEntityCoords(vehicle)
                local distance = #(playerPos - vehiclePos)
                if distance < closestDistance then
                    closestFlatbed = vehicle
                    closestDistance = distance
                end
            end
        end
    end

    return closestFlatbed
end

function GetCloseVehi()
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()),3.0, 0, 70)
    local vCoords = GetEntityCoords(vehicle)
    DrawMarker(36, vCoords.x, vCoords.y, vCoords.z + 1.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 150, 0, 1, 2, 1, nil, nil, 0)
end

local function ensureAnimDict(animDict)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(100)
		end
	end
	return animDict
end

function CarryPlayer(entity)

    if not carry.InProgress then
        if entity then
            local targetSrc = GetPlayerServerId(NetworkGetEntityOwner(entity))
            if targetSrc ~= -1 then
                carry.InProgress = true
                carry.targetSrc = targetSrc
                TriggerServerEvent("carryPeople:sync",targetSrc)

                ensureAnimDict(carry.personCarrying.animDict)
                TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, -1, carry.personCarrying.flag, 0, false, false, false)

                ensureAnimDict(carry.personCarried.animDict)
                TaskPlayAnim(entity, carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, -1, carry.personCarried.flag, 0, false, false, false)
				HelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour lâcher le joueur.", true, nil)

                AttachEntityToEntity(entity, PlayerPedId(), 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.0, 0.0, 180.0, false, false, false, false, 2, true)
                print("Attachement réussi : " .. tostring(entity))

                carry.type = "carrying"
            else
                Notification("Erreur", "Trop loins...", 3500)
            end
        else
            Notification("Erreur", "Trop loins...", 3500)
        end
    else
        carry.InProgress = false
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
        TriggerServerEvent("carryPeople:stop", carry.targetSrc)
        HelpNotification(" ", false, 1)
        carry.targetSrc = 0
        ExecuteCommand("e c")
    end
end

function CarryPlayer2(entity)

    if not carry2.InProgress then
        if entity then
            local targetSrc = GetPlayerServerId(NetworkGetEntityOwner(entity))
            if targetSrc ~= -1 then
                carry2.InProgress = true
                carry2.targetSrc = targetSrc
                TriggerServerEvent("carryPeople:sync",targetSrc)

                ensureAnimDict(carry2.personCarrying.animDict)
                TaskPlayAnim(PlayerPedId(), carry2.personCarrying.animDict, carry2.personCarrying.anim, 8.0, -8.0, -1, carry2.personCarrying.flag, 0, false, false, false)

                ensureAnimDict(carry2.personCarried.animDict)
                TaskPlayAnim(entity, carry2.personCarried.animDict, carry2.personCarried.anim, 8.0, -8.0, -1, carry2.personCarried.flag, 0, false, false, false)
				HelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour lâcher le joueur.", true, nil)

                AttachEntityToEntity(entity, PlayerPedId(), 0, carry2.personCarried.attachX, carry2.personCarried.attachY, carry2.personCarried.attachZ, 0.0, 0.0, 180.0, false, false, false, false, 2, true)
                print("Attachement réussi : " .. tostring(entity))

                carry2.type = "carrying"
            else
                Notification("Erreur", "Trop loins...", 3500)
            end
        else
            Notification("Erreur", "Trop loins...", 3500)
        end
    else
        carry2.InProgress = false
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
        TriggerServerEvent("carryPeople:stop", carry2.targetSrc)
        HelpNotification(" ", false, 1)
        carry2.targetSrc = 0
        ExecuteCommand("e c")
    end
end

RegisterNetEvent("carryPeople:syncTarget")
AddEventHandler("carryPeople:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "beingcarried"

    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry2.InProgress = true
	ensureAnimDict(carry2.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry2.personCarried.attachX, carry2.personCarried.attachY, carry2.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry2.type = "beingcarried"
end)

RegisterNetEvent("carryPeople:cl_stop")
AddEventHandler("carryPeople:cl_stop", function()
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)

    carry2.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

---

Citizen.CreateThread(function()
	while true do
		if carry.InProgress then
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
				end
			end
		end
		Wait(0)
        if carry2.InProgress then
			if carry2.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry2.personCarried.animDict, carry2.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry2.personCarried.animDict, carry2.personCarried.anim, 8.0, -8.0, 100000, carry2.personCarried.flag, 0, false, false, false)
				end
			elseif carry2.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry2.personCarrying.animDict, carry2.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry2.personCarrying.animDict, carry2.personCarrying.anim, 8.0, -8.0, 100000, carry2.personCarrying.flag, 0, false, false, false)
				end
			end
		end
		Wait(0)
	end
end)

RegisterCommand("stopCarry", function()
    if carry.InProgress == true then
        carry.InProgress = false
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
        TriggerServerEvent("carryPeople:stop", carry.targetSrc)
        HelpNotification(" ", false, 1)
        carry.targetSrc = 0
        ExecuteCommand("e c")
    end
    if carry2.InProgress == true then
        carry2.InProgress = false
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
        TriggerServerEvent("carryPeople:stop", carry2.targetSrc)
        HelpNotification(" ", false, 1)
        carry2.targetSrc = 0
        ExecuteCommand("e c")
    end
end)


RegisterKeyMapping("stopCarry", "Lacher l'individu porté", "keyboard", "E")