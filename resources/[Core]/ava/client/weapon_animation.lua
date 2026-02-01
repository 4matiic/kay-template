if IS_RDR2 then return end

-- Ouverture de l'interface d'animation d'arme
RegisterNetEvent('fb:weaponanimation:open', function()
    SendReactMessage('weapon_animation:visibility', {
        visibility = true,
    })
    AddNuiFocus('weapon_animation')
    AddNuiFocusKeepInput('weapon_animation')
    TriggerEvent('fb:disableControlActions', 'fb_weapon_animation', true)
end)

-- Fonction pour fermer l'interface d'animation d'arme
local function CloseWeaponAnimation()
    RemoveNuiFocus('weapon_animation')
    RemoveNuiFocusKeepInput('weapon_animation')
    SendReactMessage('weapon_animation:visibility', {
        visibility = false,
    })
    TriggerEvent('fb:disableControlActions', 'fb_weapon_animation', false)
end

-- Enregistrement de l'événement pour fermer l'interface d'animation d'arme
RegisterNetEvent('fb:weaponanimation:close', CloseWeaponAnimation)

-- Callback NUI pour fermer l'interface d'animation d'arme
RegisterNUICallback('weapon_animation:close', function(_, cb)
    CloseWeaponAnimation()
    cb('ok')
end)

-- Callback NUI pour sélectionner une animation d'arme
RegisterNUICallback('weapon_animation:select', function(data, cb)
    local value = data.value == 'default' and nil or data.value
    if data.type == 'aim' then
        TriggerServerEvent('fb:character:setAimAnim', value)
    elseif data.type == 'holster' then
        TriggerServerEvent('fb:character:setHolsterAnim', value)
    end
    cb('ok')
end)

-- Enregistrement de l'événement pour définir l'animation de visée
RegisterNetEvent('fb:setAimAnim', function(aimAnim)
    FB.AimAnim = aimAnim
end)

-- Enregistrement de l'événement pour définir l'animation de dégainage
RegisterNetEvent('fb:setHolsterAnim', function(holsterAnim)
    FB.HolsterAnim = holsterAnim
end)

-- Commande pour ouvrir l'interface d'animation d'arme
RegisterCommand('openweaponanimation', function()
    TriggerEvent('fb:weaponanimation:open')
end, false)
