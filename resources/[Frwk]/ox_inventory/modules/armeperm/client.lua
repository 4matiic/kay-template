if not lib then return end

local ArmesPerm = {}
local Utils = require 'modules.utils.client'

local function isPermanentWeapon(item)
    if not item?.name then return false end
    
    local isWeapon = item.name:upper():sub(1, 7) == 'WEAPON_'
    if not isWeapon then return false end
    
    if item.metadata then
        return (
            item.metadata.perm == true or 
            item.metadata.permanent == true or 
            item.metadata.permament == true or
            item.metadata.isPermament == true or
            item.metadata.isPermanent == true or
            item.metadata.perm == 1 or
            item.metadata.permanent == 1 or
            item.metadata.permament == 1 or
            item.metadata.isPermament == 1 or
            item.metadata.isPermanent == 1
        )
    end
    
    return false
end

function ArmesPerm.CheckWeaponIsPermanent(weaponName)
    if not weaponName then return false end
    
    local result = lib.callback.await('ox_inventory:isPermanentWeapon', false, weaponName)
    return result
end

function ArmesPerm.RequestWeaponMarking()
    TriggerServerEvent('ox_inventory:requestMarkPermanentWeapons')
end

RegisterNetEvent('ox_inventory:setPlayerInventory', function()
    Wait(100)
    ArmesPerm.RequestWeaponMarking()
end)

RegisterNetEvent('ox_inventory:itemNotify', function(data)
    if data and data[1] and data[1].name and string.match(data[1].name:upper(), "WEAPON_") and data[2] == 'ui_added' then
        Wait(100)
        ArmesPerm.RequestWeaponMarking()
    end
end)

RegisterNetEvent('ox_inventory:updateSlots', function()
    Wait(100)
    ArmesPerm.RequestWeaponMarking()
end)

AddEventHandler('ox_inventory:openedInventory', function()
    Wait(100)
    ArmesPerm.RequestWeaponMarking()
end)

CreateThread(function()
    Wait(1000)
    for i = 1, 5 do
        ArmesPerm.RequestWeaponMarking()
        Wait(3000)
    end
end)

AddEventHandler('ox_inventory:playerDied', function()
end)

lib.callback.register('ox_inventory:canDropItem', function(data)
    if data?.name and isPermanentWeapon(data) then
        lib.notify({
            title = 'Arme permanente',
            description = 'Cette arme est permanente et ne peut pas être jetée',
            type = 'error'
        })
        return false
    end
    return true
end)

lib.callback.register('ox_inventory:canGiveItem', function(data)
    if data?.name and isPermanentWeapon(data) then
        lib.notify({
            title = 'Arme permanente',
            description = 'Cette arme est permanente et ne peut pas être donnée',
            type = 'error'
        })
        return false
    end
    return true
end)

return ArmesPerm 