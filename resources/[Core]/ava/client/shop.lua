ESX = exports['framework']:getSharedObject()
local playerPed = PlayerPedId()
local playerCoords = GetEntityCoords(playerPed)

TriggerEvent('fb:disableControlActions', 'shop', false)

RegisterNUICallback('Shop:Buy', function(data, cb)
    local items = {}
    for _, basketItem in pairs(data.basketItems) do
        table.insert(items, basketItem.item)
        TriggerServerEvent('fb:shop:buy', basketItem.item, basketItem.count, data.payWithCard)
    end
    cb(items)
end)

RegisterNUICallback('Shop:Sell', function(data, cb)
    local items = {}
    for _, basketItem in pairs(data.basketItems) do
        table.insert(items, basketItem.item)
        TriggerServerEvent('fb:shop:sell', basketItem.item, basketItem.count, data.payWithCard)
    end
    cb(items)
end)

RegisterNUICallback('Shop:Close', function(data, cb)
    TriggerEvent('fb:disableControlActions', 'shop', false)
    RemoveNuiFocus('shop')
    TriggerServerEvent('fb:shop:closeMenu')
    cb('ok')
end)

RegisterNetEvent('fb:shop:open', function(shopId)
    local shopData = shop.Shops[shopId]
    if not shopData then
        print("Shop not found: " .. shopId)
        return
    end

    local canPayWithCard = true
    AddNuiFocus('shop')
    TriggerEvent('fb:disableControlActions', 'shop', true)
    SendReactMessage('Shop:Open', {
        shopName = shopData.name,
        shopItems = shopData.items,
    })
end)

exports('shop', function(shopName, shopItems)
    TriggerEvent('fb:shop:open', shopName, shopItems)
end)

    if Config.esxversion == "old" then
        ESX = nil
    while not ESX do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(0)
    end
    elseif Config.esxversion == "new" then    
        ESX = exports['framework']:getSharedObject()
    end 

function OpenLTD(name)
exports['ava']:shop(name, items)
end

RegisterNetEvent('fb:shop:close', function()
    SendReactMessage('Shop:Close', nil)
    TriggerEvent('fb:disableControlActions', 'shop', false)
    RemoveNuiFocus('shop')
    TriggerServerEvent('fb:shop:closeMenu')
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local sleep = 1000
        local isInShopZone = false
        local currentShop = nil

        for shopId, shopData in pairs(shop.Shops) do
            local distance = #(playerCoords - shopData.position)
            if distance < shop.DrawDistance then
                sleep = 0
                DrawMarker(shop.MarkerType, shopData.position.x, shopData.position.y, shopData.position.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,shop.MarkerSize.x, shop.MarkerSize.y, shop.MarkerSize.z,shop.MarkerColor.r, shop.MarkerColor.g, shop.MarkerColor.b, 100, false, true, 2, nil, nil, false)


                if distance < shop.InteractionDistance then
                    isInShopZone = true
                    currentShop = shopId
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour faire des achats")
                    if IsControlJustPressed(0, shop.KeyToOpenShop) then
                        TriggerEvent('fb:shop:open', currentShop)
                    end
                end
            end
        end

        if not isInShopZone then
            currentShop = nil
        end

        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    for _, shopData in pairs(shop.Shops) do
        if shopData.showBlip then
            local blip = AddBlipForCoord(shopData.position.x, shopData.position.y, shopData.position.z)
            SetBlipSprite(blip, shopData.blipSprite or 52)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, shopData.blipColor or 0) -- par défaut blanc si manquant
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(shopData.name or "Boutique")
            EndTextCommandSetBlipName(blip)
        end
    end
end)


