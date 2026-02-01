local ESX = exports["framework"]:getSharedObject()


ESX.RegisterServerCallback('fb_announce:getIcons', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then cb({}); return end
    exports.oxmysql:fetch('SELECT id, name, url FROM fb_announce_icons WHERE job = ? ORDER BY id ASC', { xPlayer.job.name }, function(rows)
        cb(rows or {})
    end)
end)

RegisterNetEvent('fb_announce:addIcon', function(name, url)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer or type(name)~='string' or name=='' or type(url)~='string' or url=='' then return end
    exports.oxmysql:insert('INSERT INTO fb_announce_icons (name, url, job, identifier) VALUES (?, ?, ?, ?)',
        { name, url, xPlayer.job.name, xPlayer.identifier },
        function(_) TriggerClientEvent('esx:showNotification', src, "~g~Icône ajoutée.") end
    )
end)

RegisterNetEvent('fb_announce:editIcon', function(id, name, url)
    local src = source
    if not tonumber(id) or type(name)~='string' or name=='' or type(url)~='string' or url=='' then return end
    exports.oxmysql:update('UPDATE fb_announce_icons SET name = ?, url = ? WHERE id = ?', { name, url, id }, function(affected)
        TriggerClientEvent('esx:showNotification', src, (affected or 0)>0 and "~g~Icône modifiée." or "~r~Aucune ligne modifiée.")
    end)
end)

RegisterNetEvent('fb_announce:deleteIcon', function(id)
    local src = source
    if not tonumber(id) then return end
    exports.oxmysql:update('DELETE FROM fb_announce_icons WHERE id = ?', { id }, function(affected)
        TriggerClientEvent('esx:showNotification', src, (affected or 0)>0 and "~g~Icône supprimée." or "~r~Icône introuvable.")
    end)
end)


ESX.RegisterServerCallback('fb_announce:getMessages', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then cb({}); return end
    exports.oxmysql:fetch('SELECT id, title, content FROM fb_announce_messages WHERE job = ? ORDER BY id ASC', { xPlayer.job.name }, function(rows)
        cb(rows or {})
    end)
end)

RegisterNetEvent('fb_announce:addMessage', function(title, content)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer or type(title)~='string' or title=='' or type(content)~='string' or content=='' then return end
    exports.oxmysql:insert('INSERT INTO fb_announce_messages (title, content, job, identifier) VALUES (?, ?, ?, ?)',
        { title, content, xPlayer.job.name, xPlayer.identifier },
        function(_) TriggerClientEvent('esx:showNotification', src, "~g~Message prédéfini ajouté.") end
    )
end)

RegisterNetEvent('fb_announce:editMessage', function(id, title, content)
    local src = source
    if not tonumber(id) or type(title)~='string' or title=='' or type(content)~='string' or content=='' then return end
    exports.oxmysql:update('UPDATE fb_announce_messages SET title = ?, content = ? WHERE id = ?', { title, content, id }, function(affected)
        TriggerClientEvent('esx:showNotification', src, (affected or 0)>0 and "~g~Message modifié." or "~r~Aucune ligne modifiée.")
    end)
end)

RegisterNetEvent('fb_announce:deleteMessage', function(id)
    local src = source
    if not tonumber(id) then return end
    exports.oxmysql:update('DELETE FROM fb_announce_messages WHERE id = ?', { id }, function(affected)
        TriggerClientEvent('esx:showNotification', src, (affected or 0)>0 and "~g~Message supprimé." or "~r~Message introuvable.")
    end)
end)


RegisterNetEvent("announce:server:syncNotif", function(title, msg, icon, urgent)
    if type(title) ~= "string" or title == "" then title = "Annonce entreprise" end
    if type(msg) ~= "string" or msg == "" then return end
    if icon ~= nil and type(icon) ~= "string" then icon = nil end
    TriggerClientEvent("announce:syncNotif", -1, title, msg, icon, urgent and true or false)
end)

