local ECM = exports["kay_context"]
local MAILBOX_MODEL = GetHashKey('prop_letterbox_01')

local function mnotify(msg)
    if ESX and ESX.ShowNotification then
        ESX.ShowNotification(msg)
    else
        print('[Mailbox] ' .. tostring(msg))
    end
end

RegisterNetEvent('context:mailbox:openClient')
AddEventHandler('context:mailbox:openClient', function(stashId, personal)
    local ox = exports.ox_inventory
    if ox and ox.openInventory then
        ox:openInventory('stash', { id = stashId, owner = personal or false })
    else
        mnotify('~r~ox_inventory non disponible.')
    end
end)

ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    if not hitSomething or not hitEntity or not DoesEntityExist(hitEntity) then return end

    if GetEntityType(hitEntity) ~= 3 then return end

    if GetEntityModel(hitEntity) ~= MAILBOX_MODEL then return end

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local entityCoords = GetEntityCoords(hitEntity)
    if #(playerCoords - entityCoords) > 3.0 then return end

    local itemId = ECM:AddItem(0, "Ouvrir la boîte aux lettres")
    ECM:OnActivate(itemId, function()
        TriggerServerEvent('context:mailbox:open', { x = entityCoords.x, y = entityCoords.y, z = entityCoords.z })
    end)
    ECM:CloseOnActivate(itemId, true)
end)