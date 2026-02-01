ESX = exports['framework']:getSharedObject()

local inventory = exports.ox_inventory

local vehiclesForSale = {
    -- Supercars

    ["adder"] = { price = 1000000, weight = 50, marginMin = 5, marginMax = 15 },
    ["cheetah"] = { price = 650000, weight = 50, marginMin = 5, marginMax = 15 },
    ["entityxf"] = { price = 795000, weight = 50, marginMin = 5, marginMax = 15 },
    ["infernus"] = { price = 450000, weight = 50, marginMin = 5, marginMax = 15 },
    ["turismor"] = { price = 500000, weight = 50, marginMin = 5, marginMax = 15 },
    ["vacca"] = { price = 240000, weight = 50, marginMin = 5, marginMax = 15 },
    ["zentorno"] = { price = 725000, weight = 50, marginMin = 5, marginMax = 15 },
    ["emerus"] = { price = 2750000, weight = 50, marginMin = 5, marginMax = 15 },
    ["krieger"] = { price = 2875000, weight = 50, marginMin = 5, marginMax = 15 },
    ["t20"] = { price = 2200000, weight = 50, marginMin = 5, marginMax = 15 },
    ["osiris"] = { price = 1950000, weight = 50, marginMin = 5, marginMax = 15 },
    ["italigtb"] = { price = 1189000, weight = 50, marginMin = 5, marginMax = 15 },
    ["tezeract"] = { price = 2825000, weight = 50, marginMin = 5, marginMax = 15 },
    ["xa21"] = { price = 2375000, weight = 50, marginMin = 5, marginMax = 15 },
    ["sultanrs"] = { price = 795000, weight = 50, marginMin = 5, marginMax = 15 },
    ["calico"] = { price = 1995000, weight = 50, marginMin = 5, marginMax = 15 },
    ["previon"] = { price = 1490000, weight = 50, marginMin = 5, marginMax = 15 },
    ["champion"] = { price = 2995000, weight = 50, marginMin = 5, marginMax = 15 },
    ["ignus"] = { price = 2765000, weight = 50, marginMin = 5, marginMax = 15 },
    ["patriot3"] = { price = 1710000, weight = 50, marginMin = 5, marginMax = 15 },
    ["jubilee"] = { price = 1650000, weight = 50, marginMin = 5, marginMax = 15 },
    ["lm87"] = { price = 2975000, weight = 50, marginMin = 5, marginMax = 15 },
    ["torero2"] = { price = 2890000, weight = 50, marginMin = 5, marginMax = 15 },
    ["corsita"] = { price = 1797000, weight = 50, marginMin = 5, marginMax = 15 },
    ["rhinehart"] = { price = 1598000, weight = 50, marginMin = 5, marginMax = 15 },
    ["tulipm100"] = { price = 1745000, weight = 50, marginMin = 5, marginMax = 15 },
    ["virtue"] = { price = 2980000, weight = 50, marginMin = 5, marginMax = 15 },
    ["cyclone2"] = { price = 2295000, weight = 50, marginMin = 5, marginMax = 15 },
    ["neon"] = { price = 1500000, weight = 50, marginMin = 5, marginMax = 15 },
    ["raiden"] = { price = 1375000, weight = 50, marginMin = 5, marginMax = 15 },

    -- SUVs
    ["bison"] = { price = 30000, weight = 60, marginMin = 5, marginMax = 15 },
    ["dubsta"] = { price = 80000, weight = 70, marginMin = 5, marginMax = 15 },
    ["granger"] = { price = 55000, weight = 70, marginMin = 5, marginMax = 15 },
    ["huntley"] = { price = 195000, weight = 60, marginMin = 5, marginMax = 15 },
    ["landstalker"] = { price = 58000, weight = 65, marginMin = 5, marginMax = 15 },
    ["patriot"] = { price = 50000, weight = 70, marginMin = 5, marginMax = 15 },
    ["radi"] = { price = 32000, weight = 55, marginMin = 5, marginMax = 15 },

    -- Sports cars
    ["alpha"] = { price = 150000, weight = 40, marginMin = 5, marginMax = 15 },
    ["banshee"] = { price = 105000, weight = 45, marginMin = 5, marginMax = 15 },
    ["carbonizzare"] = { price = 195000, weight = 50, marginMin = 5, marginMax = 15 },
    ["elegyx"] = { price = 95000, weight = 50, marginMin = 5, marginMax = 15 },
    ["feltzer2"] = { price = 115000, weight = 50, marginMin = 5, marginMax = 15 },
    ["massacro"] = { price = 275000, weight = 50, marginMin = 5, marginMax = 15 },
    ["penumbra"] = { price = 24000, weight = 40, marginMin = 5, marginMax = 15 },
    ["sultan"] = { price = 125000, weight = 50, marginMin = 5, marginMax = 15 },
    ["surano"] = { price = 110000, weight = 50, marginMin = 5, marginMax = 15 },
    ["vstr"] = { price = 95000, weight = 50, marginMin = 5, marginMax = 15 },

    -- Muscle cars
    ["dominator"] = { price = 35000, weight = 50, marginMin = 5, marginMax = 15 },
    ["gauntlet"] = { price = 32000, weight = 50, marginMin = 5, marginMax = 15 },
    ["picador"] = { price = 12000, weight = 45, marginMin = 5, marginMax = 15 },
    ["vigero"] = { price = 21000, weight = 50, marginMin = 5, marginMax = 15 },

    -- Coupes
    ["f620"] = { price = 80000, weight = 50, marginMin = 5, marginMax = 15 },
    ["jackal"] = { price = 60000, weight = 50, marginMin = 5, marginMax = 15 },
    ["oracle"] = { price = 80000, weight = 50, marginMin = 5, marginMax = 15 },
    ["sentinel"] = { price = 60000, weight = 50, marginMin = 5, marginMax = 15 },

    -- Sedans
    ["buffalo"] = { price = 35000, weight = 40, marginMin = 5, marginMax = 15 },
    ["kuruma"] = { price = 126000, weight = 50, marginMin = 5, marginMax = 15 },
    ["schafter2"] = { price = 65000, weight = 50, marginMin = 5, marginMax = 15 },
    ["superd"] = { price = 150000, weight = 60, marginMin = 5, marginMax = 15 },

    -- Nouveaux véhicules
    ["asteropers"] = { price = 300000, weight = 50, marginMin = 5, marginMax = 15 },
    ["callista"] = { price = 400000, weight = 50, marginMin = 5, marginMax = 15 },
    ["caracaran"] = { price = 750000, weight = 50, marginMin = 5, marginMax = 15 },
    ["ccadefxt"] = { price = 250000, weight = 50, marginMin = 5, marginMax = 15 },
    ["coquette4c"] = { price = 900000, weight = 50, marginMin = 5, marginMax = 15 },
    ["domc"] = { price = 220000, weight = 50, marginMin = 5, marginMax = 15 },
    ["dubsta22"] = { price = 80000, weight = 70, marginMin = 5, marginMax = 15 },
    ["estancia"] = { price = 60000, weight = 60, marginMin = 5, marginMax = 15 },
    ["fmx"] = { price = 50000, weight = 50, marginMin = 5, marginMax = 15 },
    ["gauntletc"] = { price = 30000, weight = 50, marginMin = 5, marginMax = 15 },
    ["hachura"] = { price = 150000, weight = 50, marginMin = 5, marginMax = 15 },
    ["huntley2"] = { price = 195000, weight = 60, marginMin = 5, marginMax = 15 },
    ["kunoichi"] = { price = 350000, weight = 50, marginMin = 5, marginMax = 15 },
    ["kusa"] = { price = 450000, weight = 50, marginMin = 5, marginMax = 15 },
    ["navarra"] = { price = 60000, weight = 50, marginMin = 5, marginMax = 15 },
    ["nexus"] = { price = 550000, weight = 50, marginMin = 5, marginMax = 15 },
    ["nriata"] = { price = 120000, weight = 50, marginMin = 5, marginMax = 15 },
    ["nriata2"] = { price = 130000, weight = 50, marginMin = 5, marginMax = 15 },
    ["nscout"] = { price = 400000, weight = 50, marginMin = 5, marginMax = 15 },
    ["primolx"] = { price = 75000, weight = 50, marginMin = 5, marginMax = 15 },
    ["remustwo"] = { price = 200000, weight = 50, marginMin = 5, marginMax = 15 },
    ["roxanne"] = { price = 250000, weight = 50, marginMin = 5, marginMax = 15 },
    ["schlagenstr"] = { price = 900000, weight = 50, marginMin = 5, marginMax = 15 },
    ["seraph10"] = { price = 700000, weight = 50, marginMin = 5, marginMax = 15 },
    ["seraph3"] = { price = 650000, weight = 50, marginMin = 5, marginMax = 15 },
    ["severo"] = { price = 90000, weight = 50, marginMin = 5, marginMax = 15 },
    ["spritzer"] = { price = 75000, weight = 50, marginMin = 5, marginMax = 15 },
    ["streiter2"] = { price = 85000, weight = 50, marginMin = 5, marginMax = 15 },
    ["windsor2c"] = { price = 600000, weight = 50, marginMin = 5, marginMax = 15 },
    ["sultan2c"] = { price = 600000, weight = 50, marginMin = 5, marginMax = 15 },
    ["sentinelsg4"] = { price = 47500, weight = 50, marginMin = 5, marginMax = 15 },

    -- Motos
    ["akuma"] = { price = 12000, weight = 50, marginMin = 5, marginMax = 15 },
    ["bati"] = { price = 15000, weight = 50, marginMin = 5, marginMax = 15 },
    ["bati2"] = { price = 20000, weight = 50, marginMin = 5, marginMax = 15 },
    ["bf400"] = { price = 18000, weight = 50, marginMin = 5, marginMax = 15 },
    ["chimera"] = { price = 22000, weight = 50, marginMin = 5, marginMax = 15 },
    ["cliffhanger"] = { price = 25000, weight = 50, marginMin = 5, marginMax = 15 },
    ["daemon"] = { price = 15000, weight = 50, marginMin = 5, marginMax = 15 },
    ["daemon2"] = { price = 16000, weight = 50, marginMin = 5, marginMax = 15 },
    ["enduro"] = { price = 12000, weight = 50, marginMin = 5, marginMax = 15 },
    ["faggio"] = { price = 5000, weight = 50, marginMin = 5, marginMax = 15 },
    ["faggio2"] = { price = 6000, weight = 50, marginMin = 5, marginMax = 15 },
    ["faggio3"] = { price = 7000, weight = 50, marginMin = 5, marginMax = 15 },
    ["gargoyle"] = { price = 18000, weight = 50, marginMin = 5, marginMax = 15 },
    ["hakuchou"] = { price = 60000, weight = 50, marginMin = 5, marginMax = 15 },
    ["hakuchou2"] = { price = 75000, weight = 50, marginMin = 5, marginMax = 15 },
    ["lectro"] = { price = 35000, weight = 50, marginMin = 5, marginMax = 15 },
    ["manchez"] = { price = 18000, weight = 50, marginMin = 5, marginMax = 15 },
    ["nemesis"] = { price = 25000, weight = 50, marginMin = 5, marginMax = 15 },
    ["ratbike"] = { price = 5000, weight = 50, marginMin = 5, marginMax = 15 },
    ["reaper"] = { price = 220000, weight = 50, marginMin = 5, marginMax = 15 },
    ["sanchez"] = { price = 15000, weight = 50, marginMin = 5, marginMax = 15 },
    ["sanchez2"] = { price = 18000, weight = 50, marginMin = 5, marginMax = 15 },
    ["thrust"] = { price = 20000, weight = 50, marginMin = 5, marginMax = 15 },
    ["vortex"] = { price = 35000, weight = 50, marginMin = 5, marginMax = 15 },
}


RegisterServerEvent('fb:vehicle:shop:test')
AddEventHandler('fb:vehicle:shop:test', function(isTesting)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if isTesting then
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez ~g~15 secondes~w~ pour tester le véhicule.')
    end
end)

ESX.RegisterServerCallback('fb:bankaccount:getPayWith', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(nil)
        return
    end

    local identifier = xPlayer.getIdentifier() -- Identifier du joueur
    local bankAccounts = {}

    MySQL.Async.fetchAll('SELECT id, iban FROM bank_accounts WHERE owner = @owner', {
        ['@owner'] = identifier
    }, function(results)
        for _, account in ipairs(results) do
            table.insert(bankAccounts, {
                id = account.id,       -- Ajouter l'ID du compte
                iban = account.iban    -- IBAN du compte
            })
        end

        cb(bankAccounts) -- Retourner les comptes avec ID et IBAN
    end)
end)


function GeneratePlate()
    local plate = string.upper(GetRandomLetter(5) .. '' .. GetRandomNumber(3))
    return plate
end

function GetRandomLetter(length)
    local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local randomString = ''
    math.randomseed(GetGameTimer())

    for i = 1, length do
        local rand = math.random(#chars)
        randomString = randomString .. chars:sub(rand, rand)
    end

    return randomString
end

function GetRandomNumber(length)
    local nums = '0123456789'
    local randomString = ''
    math.randomseed(GetGameTimer())

    for i = 1, length do
        local rand = math.random(#nums)
        randomString = randomString .. nums:sub(rand, rand)
    end

    return randomString
end

RegisterServerEvent('fb:vehicle:shop:buy')
AddEventHandler('fb:vehicle:shop:buy', function(playerId, model, marginMin)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    local vehicleData = vehiclesForSale[model]
    if not vehicleData then
        TriggerClientEvent('esx:showNotification', playerId, '~r~Ce véhicule n\'est pas en vente.')
        return
    end

    local price = vehicleData.price
    TriggerClientEvent('fb:vehicle:shop:cashorbank', source, price, model)
end)

RegisterServerEvent('fb:vehicle:shop:paycash')
AddEventHandler('fb:vehicle:shop:paycash', function(amount, model)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local count = xPlayer.getInventoryItem("money").count

        if type(count) == "number" and count >= amount then
            local removed = xPlayer.removeInventoryItem('money', amount)
            TriggerClientEvent('ava:vehicleshop:notif:youbought', source, model, amount)
        else
            TriggerClientEvent('ava:vehicleshop:notif:notenough', source)
        end
end)

RegisterServerEvent('fb:vehicle:shop:paybank')
AddEventHandler('fb:vehicle:shop:paybank', function(accountId, amount, model)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchScalar('SELECT balance FROM bank_accounts WHERE id = @id AND owner = @owner', {
        ['@id'] = tonumber(accountId),
        ['@owner'] = identifier
    }, function(balance)
        if balance and tonumber(balance) >= tonumber(amount) then
            MySQL.Async.execute('UPDATE bank_accounts SET balance = balance - @amount WHERE id = @id AND owner = @owner', {
                ['@amount'] = tonumber(amount),
                ['@id'] = tonumber(accountId),
                ['@owner'] = identifier
            }, function(affectedRows)
                if affectedRows > 0 then
                    TriggerClientEvent('ava:vehicleshop:notif:youbought', _source, model, amount)
                else
                    TriggerClientEvent('ava:vehicleshop:notif:notenough', _source)
                end
            end)
        else
            TriggerClientEvent('ava:vehicleshop:notif:notenough', _source)
        end
    end)
end)





RegisterServerEvent('fb:vehicle:shop:setinsql')
AddEventHandler('fb:vehicle:shop:setinsql', function(plate, model)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local identifier = xPlayer.identifier
        local vehicleProps = {
            model = GetHashKey(model),
            plate = plate
        }

        -- INSERT véhicule en base
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
            ['@owner'] = identifier,
            ['@plate'] = plate,
            ['@vehicle'] = json.encode(vehicleProps)
        }, function(rowsChanged)
            if rowsChanged > 0 then
                -- ✅ Donne l'item clé avec metadata
                local keyMetadata = {
                    label = "Clé - " .. plate,
                    plate = plate,
                    owner = identifier
                }

                exports.ox_inventory:AddItem(_source, 'carkeys', 1, keyMetadata)

                -- 🚗 Spawn du véhicule
                local vehicleSpawnCoords = { x = -31.48, y = -1090.69, z = 26.42, w = 338.50 }  
                TriggerClientEvent('fb:vehicle:shop:spawnVehicle', _source, model, plate, vehicleSpawnCoords)
            end
        end)
    end
end)


