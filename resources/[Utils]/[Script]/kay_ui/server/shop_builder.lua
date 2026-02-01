local ESX = exports['framework']:getSharedObject()
local resourceName = GetCurrentResourceName()

local Shops = nil -- copie côté serveur de shop.Shops, avec positions en vector3

-- Utilitaires de deep copy
local function deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepCopy(orig_key)] = deepCopy(orig_value)
        end
        setmetatable(copy, deepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

-- Serialisation: vector3 -> table simple, et inverse
local function serializePosition(pos)
    if type(pos) == 'vector3' or (type(pos) == 'table' and pos.x and pos.y and pos.z) then
        return { x = pos.x + 0.0, y = pos.y + 0.0, z = pos.z + 0.0 }
    end
    return pos
end

local function deserializePosition(p)
    if type(p) == 'table' and p.x and p.y and p.z then
        return vector3(tonumber(p.x) or 0.0, tonumber(p.y) or 0.0, tonumber(p.z) or 0.0)
    end
    return p
end

local function toSavableTable(shops)
    local out = {}
    for id, data in pairs(shops or {}) do
        out[id] = {}
        for k, v in pairs(data) do
            if k == 'position' then
                out[id][k] = serializePosition(v)
            else
                out[id][k] = v
            end
        end
    end
    return out
end

local function fromSavableTable(tbl)
    local out = {}
    for id, data in pairs(tbl or {}) do
        out[id] = {}
        for k, v in pairs(data) do
            if k == 'position' then
                out[id][k] = deserializePosition(v)
            else
                out[id][k] = v
            end
        end
        -- sécurité
        out[id].items = out[id].items or {}
    end
    return out
end

local function SaveShopsToJson()
    local savable = toSavableTable(Shops)
    local content = json.encode(savable)
    SaveResourceFile(resourceName, 'shops.json', content or '{}', -1)
end

local function LoadShopsFromJson()
    local data = LoadResourceFile(resourceName, 'shops.json')
    if data and data ~= '' then
        local ok, decoded = pcall(json.decode, data)
        if ok and type(decoded) == 'table' then
            return fromSavableTable(decoded)
        end
    end
    return nil
end

local function BroadcastShops()
    -- On convertit position en table simple pour le réseau côté client (client reconstruira vector3)
    local payload = toSavableTable(Shops)
    TriggerClientEvent('fb:shopbuilder:updateAll', -1, payload)
end

-- Initialisation au démarrage: copie du config.lua (shop.Shops), surcharge JSON si dispo
CreateThread(function()
    while shop == nil or shop.Shops == nil do Wait(0) end
    Shops = deepCopy(shop.Shops)
    -- items/positions par défaut s'ils manquent
    for id, sdata in pairs(Shops) do
        sdata.items = sdata.items or {}
        if sdata.position and not sdata.position.x then
            sdata.position = deserializePosition(sdata.position)
        end
    end
    local persisted = LoadShopsFromJson()
    if persisted then
        Shops = persisted
    else
        SaveShopsToJson()
    end
    BroadcastShops()
end)

-- Autorisations: ESX group (admin/superadmin par défaut), configurable ici
local AllowedGroups = {
    admin = true,
    superadmin = true,
}

local function IsAllowed(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return false end
    local grp = xPlayer.getGroup and xPlayer.getGroup() or 'user'
    return AllowedGroups[grp] == true
end

-- Sync: envoi de l'état actuel au client demandeur
RegisterNetEvent('fb:shopbuilder:requestAll', function()
    local src = source
    local payload = toSavableTable(Shops)
    TriggerClientEvent('fb:shopbuilder:updateAll', src, payload)
end)

-- Ouverture: vérifie droits et autorise l'UI
RegisterNetEvent('fb:shopbuilder:requestOpen', function()
    local src = source
    if not IsAllowed(src) then
        TriggerClientEvent('esx:showNotification', src, '~r~Accès refusé')
        return
    end
    TriggerClientEvent('fb:shopbuilder:open', src)
    local payload = toSavableTable(Shops)
    TriggerClientEvent('fb:shopbuilder:updateAll', src, payload)
end)

-- CRUD Shops
RegisterNetEvent('fb:shopbuilder:addShop', function(id, data)
    local src = source
    if not IsAllowed(src) then return end
    if not id or id == '' then return end
    if Shops[id] then
        TriggerClientEvent('esx:showNotification', src, '~y~Un shop avec cet ID existe déjà')
        return
    end
    local s = data or {}
    s.items = s.items or {}
    s.position = deserializePosition(s.position or GetEntityCoords(GetPlayerPed(src)))
    s.name = s.name or 'Nouveau Shop'
    s.showBlip = s.showBlip ~= false
    s.blipSprite = tonumber(s.blipSprite) or 59
    Shops[id] = s
    SaveShopsToJson()
    BroadcastShops()
end)

RegisterNetEvent('fb:shopbuilder:updateShopMeta', function(id, fields)
    local src = source
    if not IsAllowed(src) then return end
    local s = Shops[id]
    if not s then return end
    for k, v in pairs(fields or {}) do
        if k == 'position' then
            s.position = deserializePosition(v)
        elseif k == 'blipSprite' then
            s.blipSprite = tonumber(v) or s.blipSprite
        else
            s[k] = v
        end
    end
    SaveShopsToJson()
    BroadcastShops()
end)

RegisterNetEvent('fb:shopbuilder:deleteShop', function(id)
    local src = source
    if not IsAllowed(src) then return end
    if not Shops[id] then return end
    Shops[id] = nil
    SaveShopsToJson()
    BroadcastShops()
end)

-- CRUD Items
RegisterNetEvent('fb:shopbuilder:addItem', function(shopId, item)
    local src = source
    if not IsAllowed(src) then return end
    local s = Shops[shopId]
    if not s then return end
    s.items = s.items or {}
    table.insert(s.items, item)
    SaveShopsToJson()
    BroadcastShops()
end)

RegisterNetEvent('fb:shopbuilder:updateItem', function(shopId, index, fields)
    local src = source
    if not IsAllowed(src) then return end
    local s = Shops[shopId]
    if not s or not s.items or not s.items[index] then return end
    local it = s.items[index]
    for k, v in pairs(fields or {}) do
        if k == 'itemPrice' or k == 'itemAmount' then
            it[k] = tonumber(v) or it[k]
        else
            it[k] = v
        end
    end
    SaveShopsToJson()
    BroadcastShops()
end)

RegisterNetEvent('fb:shopbuilder:deleteItem', function(shopId, index)
    local src = source
    if not IsAllowed(src) then return end
    local s = Shops[shopId]
    if not s or not s.items or not s.items[index] then return end
    table.remove(s.items, index)
    SaveShopsToJson()
    BroadcastShops()
end)

-- Hook pour la logique d'achat: lire depuis Shops au lieu de shop.Shops côté serveur
-- On remplace les accès directs à shop.Shops par Shops via exports
exports('GetShopsData', function()
    return Shops
end)