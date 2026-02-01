local ESX = nil
ESX = exports['framework']:getSharedObject()

local ECM = exports["kay_context"]

local pedData = {
    {
        position = vec3(14.51, -1105.37, 28.11),
        heading = 158.2,
        model = "mp_m_weapexp_01",
        id = "Armurie"
    },
    {
        position = vec3(1695.46, 3760.2, 33.75),
        heading = 142.23,
        model = "mp_m_weapexp_01",
        id = "Armurie"
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
                local talkToPed = ECM:AddItem(0, "Ouvrir l'armurerie")
                ECM:OnActivate(talkToPed, function()
                    TriggerEvent('fb:shop:open', pedInfo.id)
                end)
        end)
    end
end)

RegisterNetEvent('fb:shop:open', function(shopId)
    TriggerEvent('fb:disableControlActions', 'shop', true)
end)
