local ESX = exports["framework"]:getSharedObject()
RegisterServerEvent('esx_hidecar:storeHiddenVehicle')
AddEventHandler('esx_hidecar:storeHiddenVehicle', function(vehPlate, vehicles, vehposition, class,heading)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local plate = vehPlate
	local vehicles = vehicles
    local positionsss = vehposition
    local tablepersistcar = {}
    --local tablepersistcar2 = {}
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier and plate = @plate', {
			['@identifier'] = xPlayer.identifier,
			['@plate'] = plate,
		})
    local result2test = MySQL.Sync.fetchAll('SELECT plate FROM persist_car WHERE owner = @identifier and plate = @plate', {
        ['@identifier'] = xPlayer.identifier,
        ['@plate'] = plate,
    })
    local result2testcar = MySQL.Sync.fetchAll('SELECT plate FROM persist2_car WHERE owner = @identifier and plate = @plate', {
        ['@identifier'] = xPlayer.identifier,
        ['@plate'] = plate,
    })
    if #result2test <= 0 then
        if #result > 0 then
            MySQL.Async.insert('INSERT INTO persist_car (owner, plate, vehicle, position, classcar, heading) VALUES (@owner, @plate, @vehicle, @position, @classcar, @heading)',{ 
                ['@owner'] = xPlayer.identifier, 
                ['@plate'] = plate, 
                ['@vehicle'] = json.encode(vehicles), 
                ['@position'] = json.encode(positionsss),
                ['@classcar'] = class,
                ['@heading'] = heading,
            },
            function(insertId)
                MySQL.Async.fetchAll('SELECT * FROM persist_car', {}, function(result)
                    if result then
                        for k,v in pairs(result) do
                            local vehicle = json.decode(v.vehicle)
                            local position = json.decode(v.position)
                            table.insert(tablepersistcar, {vehicle = vehicle, plate = v.plate, position = position, classcar = v.classcar, heading = v.heading})
                        end
                    end
                    TriggerClientEvent("Bcore_update_set_client_persist_car_Tableset", -1, tablepersistcar)
                end)
                TriggerClientEvent("esx_hidecar:CoverVehicle", _source)
                if #result2testcar > 0 then
                    MySQL.Async.execute('DELETE FROM persist2_car WHERE plate = @plate', {
                        ['@plate'] = plate
                    })
                    Wait(500)
                    MySQL.Async.fetchAll('SELECT * FROM persist2_car', {}, function(result)
                        for k,v in pairs(result) do
                            local vehicle = json.decode(v.vehicle)
                            local position = json.decode(v.position)
                            table.insert(tablepersistcar2, {vehicle = vehicle, plate = v.plate, position = position, classcar = v.classcar, heading = v.heading, idnetworkcar = v.idnetworkcar})
                        end
                        TriggerClientEvent("Bcore_update_set_client_persist_car_Tableset2", _source, tablepersistcar2)
                    end)
                end
            end)
        else
            TriggerClientEvent("esx:showNotification", _source, "Ce n'est pas votre véhicule")
        end
    end
end)


RegisterServerEvent("Load_Car_Persist_Park")
AddEventHandler("Load_Car_Persist_Park", function()
	local _src = source
    local tablepersistcar = {}
    MySQL.Async.fetchAll('SELECT * FROM persist_car', {}, function(result)
        for k,v in pairs(result) do
            local vehicle = json.decode(v.vehicle)
            local position = json.decode(v.position)
			table.insert(tablepersistcar, {vehicle = vehicle, plate = v.plate, position = position, classcar = v.classcar, heading = v.heading})
        end
        TriggerClientEvent("Bcore_update_set_client_persist_car", _src, tablepersistcar)
    end)
end)

RegisterServerEvent("Bcore_Delete_Vehicle_is_Spawn_Persist")
AddEventHandler("Bcore_Delete_Vehicle_is_Spawn_Persist", function(token,plate)
	local _src = source
    local tablepersistcar = {}
    --if CheckToken(token, _src, "Bcore_Delete_Vehicle_is_Spawn_Persist") then
        MySQL.Async.execute('DELETE FROM persist_car WHERE plate = @plate', {
            ['@plate'] = plate
        })
        MySQL.Async.fetchAll('SELECT * FROM persist_car', {}, function(result)
            if result then
                for k,v in pairs(result) do
                    local vehicle = json.decode(v.vehicle)
                    local position = json.decode(v.position)
                    table.insert(tablepersistcar, {vehicle = vehicle, plate = v.plate, position = position, classcar = v.classcar, heading = v.heading})
                end
            end
            TriggerClientEvent("Bcore_update_set_client_persist_car_Tableset", -1, tablepersistcar)
        end)
    end) 



---check is owner
ESX.RegisterServerCallback("Bcore_Check_Is_Owner_Car_Recup_Persist", function(source, callback, plate)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    MySQL.Async.fetchAll("SELECT owner FROM persist_car WHERE plate = @plate", {
        ['@plate'] = plate
    }, function(result)
        if result[1].owner == xPlayer.identifier then
            callback(true)
        else
            callback(false)
        end
    end)
end)



----persist2
RegisterServerEvent("Bcore_update_Coords_Car_Persist2")
AddEventHandler("Bcore_update_Coords_Car_Persist2", function(vehPlate, vehicles, vehposition, class,heading,idnetworkcar)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local plate = vehPlate
	local vehicles = vehicles
    local positionsss = vehposition
    local tablepersistcar2 = {}
    --if CheckToken(token, _src, "Bcore_update_Coords_Car_Persist2") then
        local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier and plate = @plate', {
                ['@identifier'] = xPlayer.identifier,
                ['@plate'] = plate,
            })
        local result2test = MySQL.Sync.fetchAll('SELECT plate FROM persist2_car WHERE owner = @identifier and plate = @plate', {
            ['@identifier'] = xPlayer.identifier,
            ['@plate'] = plate,
        })
        if #result2test <= 0 then
            if #result > 0 then
                MySQL.Async.insert('INSERT INTO persist2_car (owner, plate, vehicle, position, classcar, heading, idnetworkcar) VALUES (@owner, @plate, @vehicle, @position, @classcar, @heading, @idnetworkcar)',{ 
                    ['@owner'] = xPlayer.identifier, 
                    ['@plate'] = plate, 
                    ['@vehicle'] = json.encode(vehicles), 
                    ['@position'] = json.encode(positionsss),
                    ['@classcar'] = class,
                    ['@heading'] = heading,
                    ['@idnetworkcar'] = idnetworkcar,
                },
                function(insertId)
                    MySQL.Async.fetchAll('SELECT * FROM persist2_car', {}, function(result)
                        if result then
                            for k,v in pairs(result) do
                                local vehicle = json.decode(v.vehicle)
                                local position = json.decode(v.position)
                                table.insert(tablepersistcar2, {vehicle = vehicle, plate = v.plate, position = position, classcar = v.classcar, heading = v.heading, idnetworkcar = v.idnetworkcar})
                            end
                        end
                        TriggerClientEvent("Bcore_update_set_client_persist_car_Tableset2", -1, tablepersistcar2)
                    end)
                end)
            end
        else
            MySQL.Sync.execute('UPDATE persist2_car SET position = @position, heading = @heading, idnetworkcar = @idnetworkcar WHERE plate = @plate', {
                ['@plate'] = plate,
                ['@position'] = json.encode(positionsss),
                ['@heading'] = heading,
                ['@idnetworkcar'] = idnetworkcar,
            })
        end
    end)


RegisterServerEvent("Load_Car_Persist_Park2")
AddEventHandler("Load_Car_Persist_Park2", function()
	local _src = source
    local tablepersistcar2 = {}
    MySQL.Async.fetchAll('SELECT * FROM persist2_car', {}, function(result)
        for k,v in pairs(result) do
            local vehicle = json.decode(v.vehicle)
            local position = json.decode(v.position)
			table.insert(tablepersistcar2, {vehicle = vehicle, plate = v.plate, position = position, classcar = v.classcar, heading = v.heading, idnetworkcar = v.idnetworkcar})
        end
        TriggerClientEvent("Bcore_update_set_client_persist_car_Tableset2", _src, tablepersistcar2)
    end)
end) 

RegisterServerEvent("Bcore_update_network_persist_car")
AddEventHandler("Bcore_update_network_persist_car", function(idnetworkcar,vehplate)
	local _src = source
    local tablepersistcar2 = {}
    MySQL.Sync.execute('UPDATE persist2_car SET idnetworkcar = @idnetworkcar WHERE plate = @plate', {
        ['@plate'] = vehplate,
        ['@idnetworkcar'] = idnetworkcar,
    })
    Wait(500)
    MySQL.Async.fetchAll('SELECT * FROM persist2_car', {}, function(result)
        for k,v in pairs(result) do
            local vehicle = json.decode(v.vehicle)
            local position = json.decode(v.position)
			table.insert(tablepersistcar2, {vehicle = vehicle, plate = v.plate, position = position, classcar = v.classcar, heading = v.heading, idnetworkcar = v.idnetworkcar})
        end
        TriggerClientEvent("Bcore_update_set_client_persist_car_Tableset2", _src, tablepersistcar2)
    end)
end)