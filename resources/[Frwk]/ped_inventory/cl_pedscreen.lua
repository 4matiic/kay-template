local PedCreate, startPedScreen, clonedPed = {}, false, nil

local playerPed = cache.ped
lib.onCache('ped', function(ped)
    playerPed = ped
end)

local function createPed(model, locationx, locationy, locationz)
    lib.requestModel(model, 1)
    return CreatePed(26, model, locationx, locationy, locationz, 0, false, false)
end

local function PedScreenDelete()
    for k, v in pairs(PedCreate) do
        DeleteEntity(v)
    end

    clonedPed = nil
    PedCreate = {}
    startPedScreen = false

    previewCache = {}
    isPreviewActive = false
end

local function RenderCam()
    local totalTime = 1000
    local elapsed = 0
    local startingPitch = GetGameplayCamRelativePitch()
    local targetPitch = 0.0
    local rate = 1.0
    local pitchThreshold = 30.00

    if math.abs(startingPitch + 7.0) < pitchThreshold then
        return
    end

    if LocalPlayer.state.invOpen then
        if math.abs(startingPitch - targetPitch) > 0.01 then
            CreateThread(function()
                while elapsed < totalTime and startPedScreen do
                    Wait(3)
                    elapsed = elapsed + 10
                    local progress = elapsed / totalTime
                    local currentPitch = (1.0 - progress) * startingPitch + progress * targetPitch
                    SetGameplayCamRelativePitch(currentPitch, rate)
                end
            end)
        end
    end
end

local function PedScreenCreate(animation, control, type, data)
    if not control then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if GetEntitySpeed(vehicle) * 3.5 > 80 then
            return
        end
    end

    SetGameplayCamRelativePitch(1.0, 1.0)
    PedScreenDelete()
    RenderCam()

    local screenX = GetDisabledControlNormal(0, 239)
    local screenY = GetDisabledControlNormal(0, 240)
    clonedPed = createPed(GetEntityModel(playerPed), nil, nil, nil)

    SetEntityCollision(clonedPed, false, true)
    SetEntityInvincible(clonedPed, true)
    NetworkSetEntityInvisibleToNetwork(clonedPed, false)
    ClonePedToTarget(playerPed, clonedPed)

    Wait(100)
    SetEntityCanBeDamaged(clonedPed, false)
    SetBlockingOfNonTemporaryEvents(clonedPed, true)
    SetPedAsNoLongerNeeded(clonedPed)
    SetForcePedFootstepsTracks(false)

    if animation.dict and animation.anim then
        lib.requestAnimDict(animation.dict)
        TaskPlayAnim(clonedPed, animation.dict, animation.anim, 8.0, 1.0, -1, 1, 0, false, false, false)
    end

    table.insert(PedCreate, clonedPed)

    startPedScreen = true
    CreateThread(function()
        local positionBuffer = {}
        local bufferSize
        local scaleWidth
        local upTempOffset
        while startPedScreen do
            local world, normal, depth
            if type == "animation" then
                depth = data.depth
                bufferSize = data.bufferSize
                scaleWidth = data.scaleWidth
                upTempOffset = data.upTempOffset
                world, normal = GetWorldCoordFromScreenCoord(0.70035417461395, 0.2587036895752)
            else
                depth = 1.5
                bufferSize = 2
                scaleWidth = 0.50    -- largeur
                upTempOffset = -0.55 -- taille
                world, normal = GetWorldCoordFromScreenCoord(0.50300000000000, 0.4500000000000)
            end

            local target = world + normal * depth
            local camRot = GetGameplayCamRot(2)

            table.insert(positionBuffer, target)
            if #positionBuffer > bufferSize then
                table.remove(positionBuffer, 1)
            end

            local averagedTarget = vector3(0, 0, 0)
            for _, position in ipairs(positionBuffer) do
                averagedTarget = averagedTarget + position
            end
            averagedTarget = averagedTarget / #positionBuffer
            DisableIdleCamera(true)
            SetEntityCollision(clonedPed, false, false)
            SetEntityCoords(clonedPed, averagedTarget.x, averagedTarget.y, averagedTarget.z, false, false, false, true)
            SetEntityHeading(clonedPed, camRot.z + 180.0)
            SetEntityRotation(clonedPed, 0, 0, camRot.z + 180.0, false, false)

            if control then
                DisableAllControlActions(0)
            end

            local forward, right, up, position = GetEntityMatrix(clonedPed)
            right = right * scaleWidth

            SetEntityMatrix(clonedPed, forward, right, up + vector3(0, 0, upTempOffset), averagedTarget)
            Wait(3)
        end
    end)
end

local function ResetPedScreen()
    CreateThread(function()
        PedScreenCreate({
            dict = "anim@amb@nightclub@peds@",
            anim = "rcmme_amanda1_stand_loop_cop"
        })
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
    for k, v in pairs(PedCreate) do
        DeleteEntity(v)
    end
end)

local previewCache = {}
local isPreviewActive = false

local function ApplyClothingPreview(itemData)
    if not clonedPed or not DoesEntityExist(clonedPed) or not itemData then return false end

    if not isPreviewActive then
        previewCache = {
            components = {},
            props = {}
        }

        for i = 0, 11 do
            local drawable = GetPedDrawableVariation(clonedPed, i)
            local texture = GetPedTextureVariation(clonedPed, i)
            previewCache.components[i] = { drawable = drawable, texture = texture }
        end

        for i = 0, 7 do
            local drawable = GetPedPropIndex(clonedPed, i)
            local texture = GetPedPropTextureIndex(clonedPed, i)
            previewCache.props[i] = { drawable = drawable, texture = texture }
        end

        isPreviewActive = true
    end

    local componentIndex = nil
    local isComponent = true

    if itemData.name == 'mask' then
        componentIndex = 1
        isComponent = true
    elseif itemData.name == 'hat' then
        componentIndex = 0
        isComponent = false
    elseif itemData.name == 'earrings' then
        componentIndex = 2
        isComponent = false
    elseif itemData.name == 'glasses' then
        componentIndex = 1
        isComponent = false
    elseif itemData.name == 'chain' then
        componentIndex = 7
        isComponent = true
    elseif itemData.name == 'undershirt' then
        componentIndex = 8
    elseif itemData.name == 'jacket' then
        componentIndex = 11
    elseif itemData.name == 'bodyarmor' then
        componentIndex = 9
    elseif itemData.name == 'bracelet' then
        componentIndex = 7
        isComponent = false
    elseif itemData.name == 'watch' then
        componentIndex = 6
        isComponent = false
    elseif itemData.name == 'bag' then
        componentIndex = 5
    elseif itemData.name == 'pants' then
        componentIndex = 4
    elseif itemData.name == 'shoes' then
        componentIndex = 6
    elseif itemData.name == 'gloves' then
        componentIndex = 3
    end

    if componentIndex then
        if isComponent then
            SetPedComponentVariation(clonedPed, componentIndex, itemData.drawable or 0, itemData.texture or 0, 0)
        else
            SetPedPropIndex(clonedPed, componentIndex, itemData.drawable or 0, itemData.texture or 0, false)
        end
        return true
    end

    return false
end

local function RestoreOriginalClothing()
    if not isPreviewActive or not clonedPed or not DoesEntityExist(clonedPed) then return false end

    if previewCache.components then
        for i, data in pairs(previewCache.components) do
            SetPedComponentVariation(clonedPed, i, data.drawable, data.texture, 0)
        end
    end

    if previewCache.props then
        for i, data in pairs(previewCache.props) do
            if data.drawable >= 0 then
                SetPedPropIndex(clonedPed, i, data.drawable, data.texture, false)
            else
                ClearPedProp(clonedPed, i)
            end
        end
    end

    previewCache = {}
    isPreviewActive = false

    return true
end

local function ApplyPedComponent(components)
    if clonedPed and DoesEntityExist(clonedPed) then
        if components.component_id == 1 then
            SetPedComponentVariation(clonedPed, 1, components.drawable, components.texture, 0)
        elseif components.component_id == 11 then
            SetPedComponentVariation(clonedPed, 11, components.drawable, components.texture, 0)
        elseif components.component_id == 8 then
            SetPedComponentVariation(clonedPed, 8, components.drawable, components.texture, 0)
        elseif components.component_id == 9 then
            SetPedComponentVariation(clonedPed, 9, components.drawable, components.texture, 0)
        elseif components.component_id == 4 then
            SetPedComponentVariation(clonedPed, 4, components.drawable, components.texture, 0)
        elseif components.component_id == 6 then
            SetPedComponentVariation(clonedPed, 6, components.drawable, components.texture, 0)
        elseif components.component_id == 3 then
            SetPedComponentVariation(clonedPed, 3, components.drawable, components.texture, 0)
        elseif components.component_id == 5 then
            SetPedComponentVariation(clonedPed, 5, components.drawable, components.texture, 0)
        end
    end
end

local function ApplyPedProp(props)
    if clonedPed and DoesEntityExist(clonedPed) then
        if props.prop_id == 0 then
            SetPedPropIndex(clonedPed, 0, props.drawable, props.texture, false)
        elseif props.prop_id == 1 then
            SetPedPropIndex(clonedPed, 1, props.drawable, props.texture, false)
        elseif props.prop_id == 2 then
            SetPedPropIndex(clonedPed, 2, props.drawable, props.texture, false)
        elseif props.prop_id == 7 then
            SetPedPropIndex(clonedPed, 7, props.drawable, props.texture, false)
        elseif props.prop_id == 6 then
            SetPedPropIndex(clonedPed, 6, props.drawable, props.texture, false)
        end
    end
end

local function IsPedScreenActive()
    return startPedScreen
end

local function GetClonedPed()
    return clonedPed
end

local function SyncPedWithPlayer()
    if clonedPed and DoesEntityExist(clonedPed) then
        if isPreviewActive then
            previewCache = {}
            isPreviewActive = false
        end

        ClonePedToTarget(playerPed, clonedPed)
        return true
    end
    return false
end

exports('ResetPedScreen', ResetPedScreen)
exports('PedScreenDelete', PedScreenDelete)
exports('PedScreenCreate', PedScreenCreate)
exports('ApplyClothingPreview', ApplyClothingPreview)
exports('RestoreOriginalClothing', RestoreOriginalClothing)
exports('ApplyPedComponent', ApplyPedComponent)
exports('ApplyPedProp', ApplyPedProp)
exports('IsPedScreenActive', IsPedScreenActive)
exports('GetClonedPed', GetClonedPed)
exports('SyncPedWithPlayer', SyncPedWithPlayer)
