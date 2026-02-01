
ESX = exports["framework"]:getSharedObject()


RegisterNetEvent("CoreUI:checkAdmin", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    print(("[ADMIN DEBUG] %s (%s) | Groupe: %s"):format(GetPlayerName(source), xPlayer.identifier, group))

    if group == "admin" or group == "owner" then
        TriggerClientEvent("CoreUI:openMenu", source)
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas les permission admin.')
    end
end)

RegisterNetEvent("CoreUI:syncWeather")
AddEventHandler("CoreUI:syncWeather", function(weatherType)
    TriggerClientEvent("CoreUI:applyWeather", -1, weatherType)
end)

RegisterNetEvent("CoreUI:syncTime")
AddEventHandler("CoreUI:syncTime", function(hour, minute)
    TriggerClientEvent("CoreUI:applyTime", -1, hour, minute)
end)


RegisterNetEvent("CoreUI:requestPlayerList")
AddEventHandler("CoreUI:requestPlayerList", function()
    local src = source
    local playerList = {}

    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        table.insert(playerList, {
            id = tonumber(playerId),
            name = name
        })
    end

    TriggerClientEvent("CoreUI:receivePlayerList", src, playerList)
end)


RegisterNetEvent("CoreUI:tpToPlayer", function(targetId)
    local src = source
    TriggerClientEvent("CoreUI:tpToPlayerClient", src, targetId)
end)

RegisterNetEvent("CoreUI:tpPlayerToMe", function(targetId)
    local src = source
    TriggerClientEvent("CoreUI:tpHereClient", targetId, src)
end)


RegisterNetEvent("CoreUI:tpToPlayer", function(targetId)
    local src = source
    local targetPed = GetPlayerPed(targetId)
    if targetPed then
        local coords = GetEntityCoords(targetPed)
        TriggerClientEvent("esx:teleport", src, coords)
    else
        TriggerClientEvent("esx:showNotification", src, "~r~Impossible de trouver ce joueur.")
    end
end)

RegisterNetEvent("CoreUI:tpPlayerToMe", function(targetId)
    local src = source
    local srcPed = GetPlayerPed(src)
    if srcPed then
        local coords = GetEntityCoords(srcPed)
        TriggerClientEvent("esx:teleport", targetId, coords)
    else
        TriggerClientEvent("esx:showNotification", src, "~r~Impossible de récupérer ta position.")
    end
end)



RegisterNetEvent("CoreUI:requestScreenshot")
AddEventHandler("CoreUI:requestScreenshot", function(targetId)
    print("[CoreUI] Demande de screenshot : targetId=", targetId, " adminSrc=", adminSrc)
    local adminSrc = source
    local xAdmin = ESX.GetPlayerFromId(adminSrc)
    if xAdmin and (xAdmin.getGroup() == "admin" or xAdmin.getGroup() == "owner") then
        TriggerClientEvent("CoreUI:takeScreenshot", targetId, adminSrc)
    else
        TriggerClientEvent("esx:showNotification", adminSrc, "~r~Tu n'as pas la permission.")
    end
end)


ESX.RegisterServerCallback('CoreUI:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
end)


RegisterNetEvent("CoreUI:receiveScreenshot")
AddEventHandler("CoreUI:receiveScreenshot", function(url, adminSrc)
    TriggerClientEvent("CoreUI:showScreenshot", adminSrc, url)
end)


RegisterNetEvent("CoreUI:tpPlayerToMe", function(targetId)
    local coords = GetEntityCoords(GetPlayerPed(source))
    TriggerClientEvent("esx:teleport", targetId, coords)
end)

RegisterNetEvent("CoreUI:toggleFreeze", function(targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "owner" then
        TriggerClientEvent("CoreUI:toggleFreezeClient", targetId)
    end
end)

RegisterNetEvent("CoreUI:healPlayer", function(targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "owner" then
        TriggerClientEvent("CoreUI:doCustomHeal", targetId)
    else
        TriggerClientEvent("esx:showNotification", source, "~r~Tu n'as pas la permission.")
    end
end)

RegisterNetEvent("CoreUI:reviveCustom", function(targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "owner" then
        TriggerClientEvent("CoreUI:doCustomRevive", targetId)
    else
        TriggerClientEvent("esx:showNotification", source, "~r~Tu n'as pas la permission de revive.")
    end
end)

RegisterNetEvent("CoreUI:kickPlayer", function(targetId, reason)
    DropPlayer(targetId, reason or "Kické par un administrateur")
end)

RegisterNetEvent("CoreUI:banPlayer", function(targetId, reason)
    DropPlayer(targetId, reason or "Vous avez été bannis de FlashFa ! En cas de problème ou erreur contactez nous sur notre discord.istrateur")
end)

RegisterNetEvent("CoreUI:sendGlobalMessage", function(msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and (xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "owner") then
        TriggerClientEvent('chat:addMessage', -1, {
            args = { "^3[Message Admin]", msg },
            color = { 255, 255, 0 }
        })
    else
        TriggerClientEvent("esx:showNotification", source, "~r~Tu n'as pas la permission d'envoyer un message.")
    end
end)

RegisterServerEvent("CoreUI:giveItem")
AddEventHandler("CoreUI:giveItem", function(targetId, item, amount)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if xTarget then
        xTarget.addInventoryItem(item, amount)
    end
end)

RegisterServerEvent("CoreUI:giveMoney")
AddEventHandler("CoreUI:giveMoney", function(targetId, account, amount)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if xTarget then
        xTarget.addAccountMoney(account, amount)
    end
end)



RegisterNetEvent("CoreUI:setJob", function(targetId, job, grade)
    local xAdmin = ESX.GetPlayerFromId(source)
    if xAdmin and (xAdmin.getGroup() == "admin" or xAdmin.getGroup() == "owner") then
        local xTarget = ESX.GetPlayerFromId(targetId)
        if xTarget then
            xTarget.setJob(job, grade)
            TriggerClientEvent('esx:showNotification', targetId, "~y~Tu es maintenant ~b~" .. job .. "~s~ (grade " .. grade .. ")")
            TriggerClientEvent('esx:showNotification', source, "~g~Job défini avec succès.")
        end
    end
end)

RegisterServerEvent("CoreUI:giveCarkey")
AddEventHandler("CoreUI:giveCarkey", function(plate, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local metadata = {
            label = "Clé " .. model,
            plate = plate,
            model = model,
            type = "car"
        }

        print("[DEBUG] Don de clé à", xPlayer.getName(), "→", json.encode(metadata)) 

        xPlayer.addInventoryItem("carkeys", 1, metadata)
    end
end)


RegisterNetEvent("CoreUI:openTrashSafely", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and (xPlayer.getGroup() == "owner" or xPlayer.getGroup() == "fondateur") then
        ExecuteCommand("trash " .. source)
    end
end)

RegisterNetEvent("CoreUI:getGroup", function(targetId)
    local xPlayer = ESX.GetPlayerFromId(targetId)
    local src = source
    if xPlayer then
        local group = xPlayer.getGroup()
        TriggerClientEvent("esx:showNotification", src, ("Le joueur est dans le groupe : ~b~%s~s~"):format(group))
    else
        TriggerClientEvent("esx:showNotification", src, "~r~Joueur introuvable.")
    end
end)

RegisterNetEvent("CoreUI:openInventory", function(targetId)
    TriggerClientEvent("ox_inventory:openInventory", source, { type = 'player', id = targetId })
end)

RegisterServerEvent("CoreUI:wipePlayer")
AddEventHandler("CoreUI:wipePlayer", function(targetId)
    local src = source
    local xAdmin = ESX.GetPlayerFromId(src)
    if not xAdmin or (xAdmin.getGroup() ~= "fondateur" and xAdmin.getGroup() ~= "owner") then
        return DropPlayer(src, "Tentative de wipe non autorisée.")
    end

    local xTarget = ESX.GetPlayerFromId(targetId)
    if xTarget then
        local identifier = xTarget.getIdentifier()
        DropPlayer(targetId, "Ton personnage a été réinitialisé.")
        MySQL.update('DELETE FROM users WHERE identifier = ?', {identifier})
        MySQL.update('DELETE FROM owned_vehicles WHERE owner = ?', {identifier})
        MySQL.update('DELETE FROM addon_account_data WHERE owner = ?', {identifier})
        MySQL.update('DELETE FROM billing WHERE identifier = ?', {identifier})
        MySQL.update('DELETE FROM datastore_data WHERE owner = ?', {identifier})
        MySQL.update('DELETE FROM user_inventory WHERE identifier = ?', {identifier})
        MySQL.update('DELETE FROM properties WHERE owner = ?', {identifier})
        print(('[WIPE] %s (%s) a été wipe par %s (%s)'):format(identifier, targetId, xAdmin.getIdentifier(), src))
    end
end)

local reports = {}

RegisterServerEvent("CoreUI:sendReport")
AddEventHandler("CoreUI:sendReport", function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    table.insert(reports, {
        source = source,
        name = xPlayer.getName(),
        reason = reason
    })
    updateReportsForAdmins()
end)

RegisterServerEvent("CoreUI:markReportHandled")
AddEventHandler("CoreUI:markReportHandled", function(src)
    for i, report in ipairs(reports) do
        if report.source == src then
            table.remove(reports, i)
            break
        end
    end
    updateReportsForAdmins()
end)

function updateReportsForAdmins()
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("CoreUI:updateReports", tonumber(playerId), reports)
    end
end

RegisterNetEvent("CoreUI:noclipSyncVisibility")
AddEventHandler("CoreUI:noclipSyncVisibility", function(state)
    local src = source
    TriggerClientEvent("CoreUI:applyNoClipInvisibility", -1, src, state)
    TriggerClientEvent("CoreUI:applyNoClipInvisibility", src, src, state)
end)


