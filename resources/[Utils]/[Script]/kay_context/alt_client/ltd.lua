local ESX = nil
ESX = exports['framework']:getSharedObject()

local ECM = exports["kay_context"]

local pedData = {
    {
        position = vec3(-527.05, 7559.54, 5.52),
        heading = 233.88,
        model = "mp_m_shopkeep_01",
        id = "Shop2"
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
                local talkToPed = ECM:AddItem(0, "Ouvrir le shop")
                ECM:OnActivate(talkToPed, function()
                    TriggerEvent('fb:shop:open', pedInfo.id)
                end)
        end)
    end
end)

RegisterNetEvent('fb:shop:open', function(shopId)
    TriggerEvent('fb:disableControlActions', 'shop', true)
end)