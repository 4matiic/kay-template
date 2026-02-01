local screen = {}
local currentPed = nil

function screen.Create(animation)
    if currentPed then
        DeleteEntity(currentPed)
        currentPed = nil
    end

    local playerPed = PlayerPedId()
    local model = GetEntityModel(playerPed)
    
    lib.requestModel(model, 1000)

    local world, normal = GetWorldCoordFromScreenCoord(0.50300000000000, 0.4500000000000)
    local target = world + normal * 1.5
    local camRot = GetGameplayCamRot(2)

    local ped = CreatePed(4, model, target.x, target.y, target.z, camRot.z + 180.0, false, true)
    currentPed = ped

    if not DoesEntityExist(ped) then return end
    
    SetEntityCollision(ped, false, false)
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    
    ClonePedToTarget(playerPed, ped)
    
    if animation and animation.dict and animation.anim then
        lib.requestAnimDict(animation.dict)
        TaskPlayAnim(ped, animation.dict, animation.anim, 8.0, -8.0, -1, 1, 0.0, false, false, false)
    end
    
    CreateThread(function()
        while DoesEntityExist(ped) and currentPed == ped do
            local world, normal = GetWorldCoordFromScreenCoord(0.50300000000000, 0.4500000000000)
            local target = world + normal * 3.5
            local camRot = GetGameplayCamRot(2)
            
            SetEntityCoords(ped, target.x, target.y, target.z - 1.00, false, false, false, true)
            SetEntityHeading(ped, camRot.z + 180.0)

            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            
            Wait(0)
        end
    end)
    
    return ped
end

function screen.Delete(ped)
    if currentPed and DoesEntityExist(currentPed) then
        SetEntityAsNoLongerNeeded(currentPed)
        DeleteEntity(currentPed)
        currentPed = nil
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        screen.Delete()
    end
end)

exports('PedScreenCreate', screen.Create)
exports('PedScreenDelete', screen.Delete)
