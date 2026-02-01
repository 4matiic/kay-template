local ESX = nil
ESX = exports['framework']:getSharedObject()

local ECM = exports["kay_context"]

local pedData = {
    {
        position = vec3(-2925.95, 6242.18, 8.60),
        heading =220.28097534179688,
        model = "a_m_y_genstreet_01",
        id = "Shop3"
    },

    {
        position = vec3(-3113.24, 6115.97, 6.31),
        heading =271.28097534179688,
        model = "a_m_y_genstreet_01",
        id = "Shop"
    },
    {
        position = vec3(-2774.66, 7037.4, 27.65),
        heading =177.28097534179688,
        model = "a_m_y_genstreet_01",
        id = "Shop"
    },
    {
        position = vec3(-1226.24, 6926.98, 19.48),
        heading =65.28097534179688,
        model = "a_m_y_genstreet_01",
        id = "Shop"
    },
    {
        position = vec3(-382.57, 7207.09, 17.22),
        heading =171.67,
        model = "a_m_y_genstreet_01",
        id = "Shop"
    }
}

local pedData2 = {
    {
        position = vec3(-1604.24, -832.07, 9.08),
        heading = 321.67,
        model = "a_m_y_genstreet_01",
        id = "shopclub77"
    }
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


--pour le job

Citizen.CreateThread(function()
    for _, pedInfo in ipairs(pedData2) do
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
            if playerData.job and playerData.job.name == "mechanic" then  -- Check if player has the police job
                local talkToPed = ECM:AddItem(0, "Ouvrir la boutique")
                ECM:OnActivate(talkToPed, function()
                    TriggerEvent('fb:shop:open', pedInfo.id)
                end)
            end
        end)
    end
end)


RegisterNetEvent('fb:shop:open', function(shopId)
    TriggerEvent('fb:disableControlActions', 'shop', true)
end)