ESX = exports['framework']:getSharedObject()

RegisterNetEvent("Kazuya:client:BuyClothes")
AddEventHandler("Kazuya:client:BuyClothes", function(NameOutfit)
    local ped = PlayerPedId()

    local clothes = {
        Arms = {drawable = GetPedDrawableVariation(ped, 3), texture = GetPedTextureVariation(ped, 3)},
        Pants = {drawable = GetPedDrawableVariation(ped, 4), texture = GetPedTextureVariation(ped, 4)},
        Shoes = {drawable = GetPedDrawableVariation(ped, 6), texture = GetPedTextureVariation(ped, 6)},
        Accessories = {drawable = GetPedDrawableVariation(ped, 7), texture = GetPedTextureVariation(ped, 7)},
        Undershirt = {drawable = GetPedDrawableVariation(ped, 8), texture = GetPedTextureVariation(ped, 8)},
        Decals = {drawable = GetPedDrawableVariation(ped, 10), texture = GetPedTextureVariation(ped, 10)},
        Torso = {drawable = GetPedDrawableVariation(ped, 11), texture = GetPedTextureVariation(ped, 11)},
        Glasses = {drawable = GetPedPropIndex(ped, 1), texture = GetPedPropTextureIndex(ped, 1)}
    }

    TriggerServerEvent('Kazuya:server:BuyClothes', clothes, NameOutfit)
    ESX.ShowNotification("🎽 Tenue achetée avec succès !")
end)

RegisterCommand("tenue", function()
    TriggerEvent("Kazuya:client:BuyClothes")
end)