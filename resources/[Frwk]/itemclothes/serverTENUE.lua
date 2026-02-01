ESX = exports['framework']:getSharedObject()

RegisterNetEvent('Kazuya:server:BuyClothes')
AddEventHandler('Kazuya:server:BuyClothes', function(clothes, NameOutfit)
    local itemData = clothes -- On garde la table originale
        itemData.label = NameOutfit -- Ajoute le label personnalisé

    exports.ox_inventory:AddItem(source, "cloth_outfit", 1, itemData)

end)

