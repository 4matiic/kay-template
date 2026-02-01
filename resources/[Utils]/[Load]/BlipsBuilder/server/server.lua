ESX = exports["framework"]:getSharedObject()


local blips = {}

CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS ]]..Config.DatabaseTable..[[ (
            id VARCHAR(50) PRIMARY KEY,
            name VARCHAR(50) NOT NULL,
            type VARCHAR(10) NOT NULL,
            size INT NOT NULL,
            opacity INT NOT NULL,
            outlined BOOLEAN NOT NULL,
            hidden BOOLEAN NOT NULL,
            isCommerce BOOLEAN NOT NULL,
            color VARCHAR(10) NOT NULL,
            x FLOAT NOT NULL,
            y FLOAT NOT NULL
        )
    ]])
    LoadBlipsFromDatabase()
end)

function LoadBlipsFromDatabase()
    MySQL.Async.fetchAll('SELECT * FROM '..Config.DatabaseTable, {}, function(results)
        if results then
            local blipsArray = {}
            for _, blip in ipairs(results) do
                blip.outlined = blip.outlined == 1
                blip.hidden = blip.hidden == 1
                blip.isCommerce = blip.isCommerce == 1
                blip.x = tonumber(blip.x)
                blip.y = tonumber(blip.y)
                table.insert(blipsArray, blip)
            end
            blips = blipsArray
            TriggerClientEvent('blips:updateBlips', -1, blipsArray)
        end
    end)
end

RegisterServerEvent('blips:checkPermission')
AddEventHandler('blips:checkPermission', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'founder' then
        TriggerClientEvent('blips:openUI', source)
    else
        TriggerClientEvent('esx:showNotification', source, '~y~Vous n\'avez pas la permission !')
    end
end)

RegisterServerEvent('blips:saveBlip')
AddEventHandler('blips:saveBlip', function(blipData)
    local source = source

    if tonumber(blipData.opacity) > 100 then
        blipData.opacity = 100
    elseif tonumber(blipData.opacity) < 0 then
        blipData.opacity = 0
    end

    MySQL.Async.execute([[
        INSERT INTO ]]..Config.DatabaseTable..[[ 
        (id, name, type, size, opacity, outlined, hidden, isCommerce, color, x, y) 
        VALUES 
        (@id, @name, @type, @size, @opacity, @outlined, @hidden, @isCommerce, @color, @x, @y)
        ON DUPLICATE KEY UPDATE
        name=@name, type=@type, size=@size, opacity=@opacity, outlined=@outlined, 
        hidden=@hidden, isCommerce=@isCommerce, color=@color, x=@x, y=@y
    ]], {
        ['@id'] = blipData.id,
        ['@name'] = blipData.name,
        ['@type'] = blipData.type,
        ['@size'] = blipData.size,
        ['@opacity'] = blipData.opacity,
        ['@outlined'] = blipData.outlined,
        ['@hidden'] = blipData.hidden,
        ['@isCommerce'] = blipData.isCommerce,
        ['@color'] = blipData.color,
        ['@x'] = blipData.x,
        ['@y'] = blipData.y
    }, function(rowsChanged)
        if rowsChanged then
            LoadBlipsFromDatabase()
            TriggerClientEvent('esx:showNotification', source, 'Blip sauvegardé avec succès')
        end
    end)
end)

RegisterServerEvent('blips:deleteBlip')
AddEventHandler('blips:deleteBlip', function(blipId)
    local source = source

    MySQL.Async.execute('DELETE FROM '..Config.DatabaseTable..' WHERE id = @id', {
        ['@id'] = blipId
    }, function(rowsChanged)
        if rowsChanged > 0 then
            LoadBlipsFromDatabase() 
            TriggerClientEvent('esx:showNotification', source, 'Blip supprimé avec succès')
        end
    end)
end)

RegisterServerEvent('blips:toggleVisibility')
AddEventHandler('blips:toggleVisibility', function(blipId)
    local source = source

    MySQL.Async.execute('UPDATE '..Config.DatabaseTable..' SET hidden = NOT hidden WHERE id = @id', {
        ['@id'] = blipId
    }, function(rowsChanged)
        if rowsChanged > 0 then
            for i, blip in ipairs(blips) do
                if blip.id == blipId then
                    blips[i].hidden = not blips[i].hidden
                    TriggerClientEvent('blips:visibilityUpdated', source, blipId, blips[i].hidden)
                    break
                end
            end
        end
    end)
end)

RegisterServerEvent('blips:requestSingleBlip')
AddEventHandler('blips:requestSingleBlip', function(blipId)
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM '..Config.DatabaseTable..' WHERE id = @id', {
        ['@id'] = blipId
    }, function(result)
        if result and result[1] then
            local blipData = result[1]
            blipData.outlined = blipData.outlined == 1
            blipData.hidden = blipData.hidden == 1
            blipData.isCommerce = blipData.isCommerce == 1
            blipData.x = tonumber(blipData.x)
            blipData.y = tonumber(blipData.y)
            TriggerClientEvent('blips:receiveSingleBlip', source, blipData)
        end
    end)
end)

RegisterServerEvent('blips:requestBlips')
AddEventHandler('blips:requestBlips', function()
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM '..Config.DatabaseTable, {}, function(results)
        if results then
            local blipsArray = {}
            for _, blip in ipairs(results) do
                blip.outlined = blip.outlined == 1
                blip.hidden = blip.hidden == 1
                blip.isCommerce = blip.isCommerce == 1
                blip.x = tonumber(blip.x)
                blip.y = tonumber(blip.y)
                table.insert(blipsArray, blip)
            end
            blips = blipsArray
            TriggerClientEvent('blips:updateBlips', source, blipsArray)
        else
            TriggerClientEvent('blips:updateBlips', source, {})
        end
    end)
end)

RegisterServerEvent('blips:onMapOpen')
AddEventHandler('blips:onMapOpen', function()
    local source = source
    TriggerClientEvent('blips:showMapNotification', source)
end)