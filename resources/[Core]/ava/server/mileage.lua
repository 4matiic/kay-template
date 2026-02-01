ESX = exports['framework']:getSharedObject()

RegisterServerEvent('carmileage:addMileage')
AddEventHandler('carmileage:addMileage', function(vehPlate, km)
    local identifier = ESX.GetPlayerFromId(source).identifier
    local plate = vehPlate
    local newKM = km

    MySQL.Async.execute('UPDATE veh_km SET km = @kms WHERE carplate = @plate', {
        ['@plate'] = plate,
        ['@kms'] = newKM
    })
end)

ESX.RegisterServerCallback('carmileage:getMileage', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehPlate = plate

    MySQL.Async.fetchAll('SELECT * FROM veh_km WHERE carplate = @plate', {
        ['@plate'] = vehPlate
    }, function(result)
        local found = false
        local KMSend = 0

        for i = 1, #result, 1 do
            local vehicleProps = result[i].carplate

            if vehicleProps == vehPlate then
                KMSend = result[i].km
                found = true
                break
            end
        end

        if found then
            cb(KMSend)
        else
            cb(0)
            MySQL.Async.execute('INSERT INTO veh_km (carplate) VALUES (@carplate)', {
                ['@carplate'] = plate
            })
            Wait(2000)
        end
    end)
end)

