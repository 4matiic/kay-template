-- server.lua (corrigé)
-- Fix principaux :
-- 1) Plus aucun TriggerClientEvent avec source nil (tout est dans des handlers où source existe)
-- 2) La commande toggle ON/OFF (sinon impossible de fermer via commande)
-- 3) Protection console (source == 0)
-- 4) Optionnel : event serveur pour forcer OFF depuis client

ESX = exports['framework']:getSharedObject()

local freecamEnabled = {} -- [source] = true/false

local function isAllowed(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return false end
    local group = xPlayer.getGroup()
    return FreeCam.Groups and FreeCam.Groups[group] == true
end

if FreeCam.Command and FreeCam.Command.active then
    RegisterCommand(FreeCam.Command.name, function(source, args, rawCommand)
        if source == 0 then return end -- pas utilisable depuis console

        if not isAllowed(source) then
            -- Si tu veux une notif côté client quand pas allowed, fais un event dédié.
            -- Ici on ne lance rien (sinon ton client risque d'interpréter "false" comme OFF).
            return
        end

        freecamEnabled[source] = not freecamEnabled[source]

        if freecamEnabled[source] then
            TriggerClientEvent('admin:toggleCamera', source, true)
            TriggerClientEvent('admin:freezePlayer', source, true)
        else
            TriggerClientEvent('admin:toggleCamera', source, false)
            TriggerClientEvent('admin:freezePlayer', source, false)
        end
    end, false)
end

-- Si ton client veut forcer OFF (ex: quand il sort ESC), tu peux appeler cet event
RegisterNetEvent('admin:freecam:disable', function()
    local src = source
    freecamEnabled[src] = false
    TriggerClientEvent('admin:toggleCamera', src, false)
    TriggerClientEvent('admin:freezePlayer', src, false)
end)

-- Nettoyage quand le joueur quitte
AddEventHandler('playerDropped', function()
    local src = source
    freecamEnabled[src] = nil
end)
