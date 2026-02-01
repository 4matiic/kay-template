local ESX = nil
ESX = exports['framework']:getSharedObject()

local ECM = exports["kay_context"]

local pedData = {
    {
        position = vector3(-52.85, -1100.29, 25.44),
        heading = 341.0,
        model = "a_m_y_beachvesp_01",
       -- id = "ArmurieSASPSUD"
    },
}

function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(500)
    end
end

Citizen.CreateThread(function()
    for _, pedInfo in ipairs(pedData) do
        LoadModel(pedInfo.model)

        local ped = CreatePed(4, pedInfo.model, pedInfo.position.x, pedInfo.position.y, pedInfo.position.z, pedInfo.heading, false, true)
        SetEntityAsMissionEntity(ped, true, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)

        ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
            if (not DoesEntityExist(hitEntity) or not IsEntityAPed(hitEntity) or hitEntity ~= ped) then
                return
            end

            local playerData = ESX.GetPlayerData()
           -- if playerData.job and playerData.job.name == "police" then  -- Check if player has the police job
                local talkToPed = ECM:AddItem(0, "Ouvrir le serrurier")
                ECM:OnActivate(talkToPed, function()
                    TriggerEvent('sy_carkeys:obtenerLlaves')
                end)
          --  end
        end)
    end
end)

RegisterNetEvent('fb:shop:open', function(shopId)
    TriggerEvent('fb:disableControlActions', 'shop', true)
end)