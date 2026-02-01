if not lib then return end

local ArmesPerm = {}
local processingDeaths = {}

local permanentWeapons = {
    'WEAPON_PISTOL',
    'WEAPON_COMBATPISTOL',
    'WEAPON_APPISTOL',
    'WEAPON_PISTOL50',
    'WEAPON_SNSPISTOL',
    'WEAPON_HEAVYPISTOL',
    'WEAPON_VINTAGEPISTOL',
    'WEAPON_MARKSMANPISTOL',
    'WEAPON_REVOLVER',
    'WEAPON_MICROSMG',
    'WEAPON_SMG',
    'WEAPON_ASSAULTSMG',
    'WEAPON_COMBATPDW',
    'WEAPON_PUMPSHOTGUN',
    'WEAPON_ASSAULTSHOTGUN',
    'WEAPON_BULLPUPSHOTGUN',
    'WEAPON_ASSAULTRIFLE',
    'WEAPON_CARBINERIFLE',
    'WEAPON_ADVANCEDRIFLE',
    'WEAPON_SPECIALCARBINE',
    'WEAPON_BULLPUPRIFLE',
    'WEAPON_MUSKET'
}

local permanentWeaponsHash = {}
for _, weapon in ipairs(permanentWeapons) do
    permanentWeaponsHash[weapon] = true
end

function ArmesPerm.IsWeaponPermanent(weaponName)
    if not weaponName then return false end
    
    local name = weaponName:upper()
    if name:sub(1, 7) ~= 'WEAPON_' then
        name = 'WEAPON_' .. name
    end
    
    return permanentWeaponsHash[name] or false
end

lib.callback.register('ox_inventory:isPermanentWeapon', function(source, weaponName)
    return ArmesPerm.IsWeaponPermanent(weaponName)
end)

local Items = require 'modules.items.server'
local originalMetadata = Items.Metadata

Items.Metadata = function(inv, item, metadata, count)
    local resultMetadata, resultCount = originalMetadata(inv, item, metadata, count)
    
    if item and item.weapon and item.name and ArmesPerm.IsWeaponPermanent(item.name) then
        resultMetadata.permanent = true
    end
    
    return resultMetadata, resultCount
end

function ArmesPerm.GetPlayerPermanentWeapons(playerId)
    if not playerId then return {} end
    
    local inventory = exports.ox_inventory:GetInventory(playerId)
    if not inventory or not inventory.items then return {} end
    
    local permanentWeapons = {}
    for _, item in pairs(inventory.items) do
        if item and item.name and item.name:upper():sub(1, 7) == 'WEAPON_' then
            if ArmesPerm.IsWeaponPermanent(item.name) or (item.metadata and (
                item.metadata.perm == true or 
                item.metadata.permanent == true or 
                item.metadata.permament == true or
                item.metadata.isPermament == true or
                item.metadata.isPermanent == true or
                item.metadata.perm == 1 or
                item.metadata.permanent == 1 or
                item.metadata.permament == 1 or
                item.metadata.isPermament == 1 or
                item.metadata.isPermanent == 1)
            ) then
                permanentWeapons[#permanentWeapons + 1] = item
            end
        end
    end
    
    return permanentWeapons
end

function ArmesPerm.SetWeaponAsPermanent(playerId, slotId)
    if not playerId or not slotId then return false end
    
    local inventory = exports.ox_inventory:GetInventory(playerId)
    if not inventory or not inventory.items then return false end
    
    local item = inventory.items[slotId]
    if not item or not item.name or item.name:upper():sub(1, 7) ~= 'WEAPON_' then 
        return false 
    end
    
    if not item.metadata then item.metadata = {} end
    item.metadata.permanent = true
    
    exports.ox_inventory:SetMetadata(playerId, slotId, item.metadata)
    
    TriggerClientEvent('ox_lib:notify', playerId, {
        title = 'Arme permanente',
        description = 'Cette arme est maintenant permanente',
        type = 'success'
    })
    
    return true
end

RegisterNetEvent('esx:onPlayerDeath', function(data)
    local playerId = source
    
    if processingDeaths[playerId] then
        return
    end
    
    processingDeaths[playerId] = true
    
    Wait(2000)
    
    local currentInventory = exports.ox_inventory:GetInventory(playerId)
    local permanentWeapons = ArmesPerm.GetPlayerPermanentWeapons(playerId)
    
    if #permanentWeapons > 0 then
        local weaponCounts = {}
        
        if currentInventory and currentInventory.items then
            for _, item in pairs(currentInventory.items) do
                if item and item.name and string.match(item.name:upper(), "WEAPON_") then
                    weaponCounts[item.name] = (weaponCounts[item.name] or 0) + 1
                end
            end
        end
        
        local addedWeapons = false
        
        for _, weapon in ipairs(permanentWeapons) do
            local count = weaponCounts[weapon.name] or 0
            if count < 1 then
                exports.ox_inventory:AddItem(playerId, weapon.name, 1, weapon.metadata)
                addedWeapons = true
            end
        end
        
        if addedWeapons then
            TriggerClientEvent('ox_lib:notify', playerId, {
                title = 'Armes permanentes',
                description = 'Vos armes permanentes ont été restaurées',
                type = 'info'
            })
        end
    end
    
    processingDeaths[playerId] = false
end)

local Inventory = require 'modules.inventory.server'

local originalCanSwapItems = Inventory.CanSwapItems
Inventory.CanSwapItems = function(fromInventory, toInventory, fromSlot, toSlot)
    local item = fromInventory.items[fromSlot]
    
    if item and item.name and item.name:upper():sub(1, 7) == 'WEAPON_' then
        if ArmesPerm.IsWeaponPermanent(item.name) or (item.metadata and (
            item.metadata.perm == true or 
            item.metadata.permanent == true or 
            item.metadata.permament == true or
            item.metadata.isPermament == true or
            item.metadata.isPermanent == true or
            item.metadata.perm == 1 or
            item.metadata.permanent == 1 or
            item.metadata.permament == 1 or
            item.metadata.isPermament == 1 or
            item.metadata.isPermanent == 1)
        ) then
            if toInventory.id ~= fromInventory.id and fromInventory.type == 'player' then
                TriggerClientEvent('ox_lib:notify', fromInventory.id, {
                    title = 'Arme permanente',
                    description = 'Cette arme est permanente et ne peut pas être donnée',
                    type = 'error'
                })
                return false
            end
        end
    end
    
    return originalCanSwapItems(fromInventory, toInventory, fromSlot, toSlot)
end

lib.callback.register('ox_inventory:isWeaponPermanent', function(source, weaponName)
    return ArmesPerm.IsWeaponPermanent(weaponName)
end)

RegisterNetEvent('ox_inventory:updateWeaponStyle', function(slot)
    local source = source
    local inventory = exports.ox_inventory:GetInventory(source)
    if not inventory or not inventory.items[slot] then return end
    
    local item = inventory.items[slot]
    if not item.name or not string.match(item.name:upper(), "WEAPON_") then return end
    
    if ArmesPerm.IsWeaponPermanent(item.name) then
        if not item.metadata then item.metadata = {} end
        item.metadata.permanent = true
        
        exports.ox_inventory:SetMetadata(source, slot, item.metadata)
        
        TriggerClientEvent('ox_inventory:updateInventory', source, inventory.items, inventory.weight, inventory.maxWeight)
        
        for playerId in pairs(inventory.openedBy or {}) do
            TriggerClientEvent('ox_inventory:updateInventory', playerId, inventory.items, inventory.weight, inventory.maxWeight)
        end
    end
end)

exports('MarkWeaponAsPermanent', function(playerId, weaponName)
    if not playerId or not weaponName then return false end
    
    local inventory = exports.ox_inventory:GetInventory(playerId)
    if not inventory then return false end
    
    local found = false
    
    for slot, item in pairs(inventory.items) do
        if item and item.name and item.name:upper() == weaponName:upper() then
            if not item.metadata then item.metadata = {} end
            item.metadata.permanent = true
            exports.ox_inventory:SetMetadata(playerId, slot, item.metadata)
            found = true
            
            TriggerClientEvent('ox_inventory:updateInventory', playerId, inventory.items, inventory.weight, inventory.maxWeight)
        end
    end
    
    return found
end)

RegisterNetEvent('ox_inventory:requestMarkPermanentWeapons', function()
    local source = source
    if not source then return end
    
    exports.MarkWeaponsAsPermanent(source)
end)

local originalAddItem = exports.ox_inventory.AddItem

exports('AddItem', function(playerId, item, count, metadata, slot, cb)
    if type(item) == 'string' and string.match(item:upper(), "WEAPON_") then
        if ArmesPerm.IsWeaponPermanent(item) then
            if not metadata then metadata = {} end
            metadata.permanent = true
        end
        
        local success, response = originalAddItem(playerId, item, count, metadata, slot, cb)
        
        if success then
            CreateThread(function()
                Wait(100)
                exports.MarkWeaponsAsPermanent(playerId)
            end)
        end
        
        return success, response
    else
        return originalAddItem(playerId, item, count, metadata, slot, cb)
    end
end)

RegisterNetEvent('ox_inventory:forceWeaponRefresh', function()
    local source = source
    local inventory = exports.ox_inventory:GetInventory(source)
    if not inventory or not inventory.items then return end
    
    local updated = false
    
    for slot, item in pairs(inventory.items) do
        if item and item.name and string.match(item.name:upper(), "WEAPON_") then
            if ArmesPerm.IsWeaponPermanent(item.name) then
                if not item.metadata then item.metadata = {} end
                if not item.metadata.permanent then
                    item.metadata.permanent = true
                    exports.ox_inventory:SetMetadata(source, slot, item.metadata)
                    updated = true
                end
            end
        end
    end
    
    if updated then
        TriggerClientEvent('ox_inventory:updateInventory', source, inventory.items, inventory.weight, inventory.maxWeight)
    end
end)

exports('MarkWeaponsAsPermanent', function(playerId)
    local inventory = exports.ox_inventory:GetInventory(playerId)
    if not inventory or not inventory.items then return false end
    
    local weaponsUpdated = false
    
    for slot, item in pairs(inventory.items) do
        if item and item.name and string.match(item.name:upper(), "WEAPON_") then
            if ArmesPerm.IsWeaponPermanent(item.name) then
                if not item.metadata then item.metadata = {} end
                if not item.metadata.permanent then
                    item.metadata.permanent = true
                    exports.ox_inventory:SetMetadata(playerId, slot, item.metadata)
                    weaponsUpdated = true
                end
            end
        end
    end
    
    if weaponsUpdated then
        TriggerClientEvent('ox_inventory:updateInventory', playerId, inventory.items, inventory.weight, inventory.maxWeight)
    end
    
    return weaponsUpdated
end)

AddEventHandler('ox_inventory:setPlayerInventory', function(data)
    if data and data.source then
        Wait(500) 
        exports.MarkWeaponsAsPermanent(data.source)
    end
end)

local originalInventorySetSlot = Inventory and Inventory.SetSlot

if originalInventorySetSlot then
    Inventory.SetSlot = function(inv, item, count, metadata, slot)
        if item and item.name and string.match(item.name:upper(), "WEAPON_") then
            if ArmesPerm.IsWeaponPermanent(item.name) then
                if not metadata then 
                    metadata = {} 
                end
                metadata.permanent = true
            end
        end
        
        return originalInventorySetSlot(inv, item, count, metadata, slot)
    end
end

lib.callback.register('ox_inventory:getPermanentWeapons', function()
    return permanentWeapons
end)

RegisterNetEvent('esx:onPlayerSpawn', function()
    local playerId = source
    if processingDeaths[playerId] then
        processingDeaths[playerId] = false
    end
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    if processingDeaths[playerId] then
        processingDeaths[playerId] = nil
    end
end)

return ArmesPerm 