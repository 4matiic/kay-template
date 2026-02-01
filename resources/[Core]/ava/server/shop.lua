ESX = exports['framework']:getSharedObject()

-- supporte sell.Shops ou shop.Shops
local Shops = (sell and sell.Shops) or (shop and shop.Shops) or {}

local function notify(src, msg)
    TriggerClientEvent('esx:showNotification', src, msg)
end

local function getItemCfg(tradeId)
    for _, s in pairs(Shops) do
        for _, it in ipairs(s.items or {}) do
            if it.item == tradeId then return it end
        end
    end
    return nil
end

-- ========== ACHAT ==========
RegisterServerEvent('fb:shop:buy')
AddEventHandler('fb:shop:buy', function(tradeId, count, payWithCard)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    count = tonumber(count) or 0
    if count <= 0 then return end

    local cfg = getItemCfg(tradeId)
    if not cfg then
        -- notify(src, "~r~Cet item n'est pas vendu ici.")
        return
    end

    local unit = tonumber(cfg.itemPrice or 0) or 0
    if unit <= 0 then
        notify(src, "~r~Prix invalide pour cet article.")
        return
    end

    local total = unit * count

    if payWithCard then
        local bank = xPlayer.getAccount('bank').money or 0
        if bank < total then
            notify(src, "~r~Fonds bancaires insuffisants.")
            return
        end
        xPlayer.removeAccountMoney('bank', total)
    else
        local cash = tonumber(exports.ox_inventory:GetItem(src, 'money', nil, true)) or 0
        if cash < total then
            notify(src, "~r~Fonds insuffisants.")
            return
        end
        exports.ox_inventory:RemoveItem(src, 'money', total)
    end

    exports.ox_inventory:AddItem(src, cfg.item, count)
    notify(src, ("~g~Achat: ~w~%s x%d ~g~pour ~w~%d$"):format(cfg.itemName or cfg.item, count, total))
end)

-- ========== VENTE ==========
RegisterServerEvent('fb:shop:sell')
AddEventHandler('fb:shop:sell', function(tradeId, count, payWithCard)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    count = tonumber(count) or 0
    if count <= 0 then return end

    local cfg = getItemCfg(tradeId)
    if not cfg then
       -- notify(src, "~r~Cet item n'est pas repris ici.")
        return
    end

    -- quantité possédée
    local invItem = exports.ox_inventory:GetItem(src, tradeId, nil)
    local have = (invItem and invItem.count) or 0
    if have < count then
        notify(src, "~r~Vous n'avez pas assez de cet item à vendre.")
        return
    end

    -- prix de reprise = itemPrice du config (pas playerItem.price qui est nil)
    local unit = tonumber(cfg.itemPrice or 0) or 0
    if unit <= 0 then
        notify(src, "~r~Prix de reprise invalide.")
        return
    end
    local total = unit * count

    -- retire items
    local ok = exports.ox_inventory:RemoveItem(src, tradeId, count)
    if not ok then
        notify(src, "~r~Erreur inventaire.")
        return
    end

    -- paie
    if payWithCard then
        xPlayer.addAccountMoney('bank', total)
    else
        exports.ox_inventory:AddItem(src, 'money', total)
    end

    notify(src, ("~g~Vente: ~w~%s x%d ~g~pour ~w~%d$"):format(cfg.itemName or cfg.item, count, total))
end)
