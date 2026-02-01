---- PED PREVIEW
local PedSet = false
local pedv = nil
local cam = nil

Citizen.CreateThread(function()
    DisableIdleCamera(true)
end)


function createPed(model, locationx, locationy, locationz)
    local hash = model
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(1)
    end
    return CreatePed(26, hash, locationx, locationy, locationz, 0, false, false)
end


function CreateVirtualPed(dict, anim)
    if pedv then
        DestroyVirtualPed()
    end
    PedSet = true
    local atm = 0
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) and atm < 1000 do
        Wait(0)
        atm += 1
    end
    if atm >= 1000 then
        return warn('^1[FBEMOTE] ^3Error loading animation dictionary^7')
    end
    clonedPed = createPed(GetEntityModel(PlayerPedId()), nil, nil, nil)
    SetEntityCollision(clonedPed, false, true)
    SetEntityInvincible(clonedPed, true)
    NetworkSetEntityInvisibleToNetwork(clonedPed, true)
    ClonePedToTarget(PlayerPedId(), clonedPed)
    SetEntityCanBeDamaged(clonedPed, false)
    SetBlockingOfNonTemporaryEvents(clonedPed, true)
    TaskPlayAnim(clonedPed, dict, anim, 8.0, 8.0, -1, 1, 0, false, false, false)
    FreezeEntityPosition(clonedPed, true)
    SetPedConfigFlag(clonedPed, 89, false)
    SetEntityDynamic(clonedPed, false)
    SetEntityHasGravity(clonedPed, false)
    SetEntityMotionBlur(clonedPed, false)
    SetPedCanBeTargetted(clonedPed, false)
    SetEntityAlpha(clonedPed, 254, false)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetGameplayCamFov(), false, 0)
    pedv = clonedPed
    Citizen.CreateThread(function()
        while PedSet do
            SetPedCoordsAndScaleWithGetCam()
            Wait(0)
        end
    end)
end

function UpdatePed(dict, anim)
    if pedv then
        DeleteEntity(pedv)
        PedSet = false
        pedv = nil
        PedSet = true
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
        clonedPed = createPed(GetEntityModel(PlayerPedId()), nil, nil, nil)
        SetEntityCollision(clonedPed, false, false)
        SetEntityInvincible(clonedPed, true)
        NetworkSetEntityInvisibleToNetwork(clonedPed, true)
        ClonePedToTarget(PlayerPedId(), clonedPed)
        SetEntityCanBeDamaged(clonedPed, false)
        SetEntityAlpha(clonedPed, 254, false)
        SetBlockingOfNonTemporaryEvents(clonedPed, true)
        SetEntityDynamic(clonedPed, false)
        SetEntityHasGravity(clonedPed, false)
        SetEntityMotionBlur(clonedPed, false)
        SetPedCanBeTargetted(clonedPed, false)
        SetPedAoBlobRendering(clonedPed, false)
        TaskPlayAnim(clonedPed, dict, anim, 8.0, 8.0, -1, 1, 0, false, false, false)
        pedv = clonedPed
    end
end

function SetPedCoordsAndScaleWithGetCam()
    local camType = GetFollowPedCamViewMode()
    local target = 1.0

    SetEntityAlpha(pedv, 254, false)
    local pos = GetFinalRenderedCamCoord()
    SetCamCoord(cam, pos)
    local rot = GetFinalRenderedCamRot(2)
    SetCamRot(cam, vector3(-rot.x, rot.y, rot.z) + vector3(0, 0, 180.0), 2)
    SetCamFov(cam, GetGameplayCamFov())
    local camRight, camForward, camUp, camCoords = GetCamMatrix(cam)
    ClearPedBloodDamage(pedv)

    local coordsDesired = camCoords + camForward * -(target) + (camRight * 0.0) + (camUp * 0.5) -- Déplacement plus à gauche et en haut
    local scaleFactor = 0.6 -- Augmentation de la taille

    if camType == 4 then -- Première personne
        target = 1.0
        scaleFactor = 0.2 -- Un peu plus grand en première personne
        coordsDesired = camCoords + camForward * -(target) + (camRight * 0.3) + (camUp * 0.15)
    end

    if camType == 0 then -- Caméra à la troisième personne
        target = 1.5
        scaleFactor = 0.3
        coordsDesired = camCoords + camForward * -(target) + (camRight * 0.45) + (camUp * 0.23)
    end

    if camType == 1 then -- Caméra après la première personne
        target = 4.0
        scaleFactor = 0.8
        coordsDesired = camCoords + camForward * -(target) + (camRight * 1.2) + (camUp * 0.7)

    elseif camType == 2 then -- Caméra après le double appui sur la première personne
        target = 4.0
        scaleFactor = 0.8
        coordsDesired = camCoords + camForward * -(target) + (camRight * 1.2) + (camUp * 0.7)
    end


    SetEntityCoords(pedv, coordsDesired)
    SetEntityMatrix(pedv, camForward * scaleFactor, camRight * scaleFactor, camUp * scaleFactor, vector3(coordsDesired.x, coordsDesired.y, coordsDesired.z + 0.05))
    FreezeEntityPosition(pedv, true)
end

function DestroyVirtualPed()
    if pedv then
        PedSet = false
        DeleteEntity(pedv)
        DestroyCam(cam, true)
        pedv = nil
    end
end

exports("CreateVirtualPed", CreateVirtualPed)
exports("UpdatePed", UpdatePed)
exports("DestroyVirtualPed", DestroyVirtualPed)