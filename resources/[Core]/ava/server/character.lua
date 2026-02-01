ESX = exports['framework']:getSharedObject()



RegisterServerEvent('updateFaceFeature')
AddEventHandler('updateFaceFeature', function(data)
    local _source = source

    if data and data.featureIndexX and data.scaleX then
        TriggerClientEvent('applyFaceFeatureChanges', _source, data)
    else
    end
end)

RegisterServerEvent('updateFaceFeature')
AddEventHandler('updateFaceFeature', function(data)
    local _source = source

    if data then
        TriggerClientEvent('updateFaceFeatureClient', _source, data)
    else
    end
end)

RegisterServerEvent('updateHead')
AddEventHandler('updateHead', function(data)
    local _source = source


    if data and data.fatherId and data.motherId and data.fatherSkin and data.motherSkin then
        TriggerClientEvent('updateHeadClient', _source, {
            fatherId = tonumber(data.fatherId),
            motherId = tonumber(data.motherId),
            fatherSkin = tonumber(data.fatherSkin),
            motherSkin = tonumber(data.motherSkin),
            shapeMix = tonumber(data.shapeMix),
            skinMix = tonumber(data.skinMix)
        })
    else
    end
end)



RegisterServerEvent('updateFaceFeature')
AddEventHandler('updateFaceFeature', function(data)
    local _source = source


    if data and data.featureIndexX and data.scaleX and data.featureIndexY and data.scaleY then
        TriggerClientEvent('updateFaceFeatureClient', _source, data)
    else
    end
end)


RegisterServerEvent('RDR2Characters:SetSexe')
AddEventHandler('RDR2Characters:SetSexe', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if not data or not data.sexe or not xPlayer then
        return
    end

    local dbSex = string.lower(data.sexe) == "m" and "m" or "f"
    local modelName = dbSex == "m" and "mp_m_freemode_01" or "mp_f_freemode_01"
    
    local defaultSkin = {
        model = modelName,
        tattoos = dbSex == "m" and {
            {collection = "multiplayer_overlays", overlay = "FM_Tat_M_006"},
            {collection = "multiplayer_overlays", overlay = "FM_Tat_M_003"}
        } or {
            {collection = "multiplayer_overlays", overlay = "FM_Tat_F_006"},
            {collection = "multiplayer_overlays", overlay = "FM_Tat_F_003"}
        },
        headBlend = {
            shapeFirst = dbSex == "m" and 5 or 2,
            shapeSecond = dbSex == "m" and 5 or 8,
            shapeThird = 0,
            skinFirst = dbSex == "m" and 5 or 2,
            skinSecond = dbSex == "m" and 5 or 8,
            skinThird = 0,
            shapeMix = 0.5,
            skinMix = 0.5,
            thirdMix = 0
        },
        components = {},
        props = {},
        headOverlays = {
            blemishes = {style = 0, opacity = 1.0, color = 0, secondColor = 0},
            beard = {style = 0, opacity = dbSex == "m" and 1.0 or 0.0, color = 0, secondColor = 0},
            eyebrows = {style = 0, opacity = 1.0, color = 0, secondColor = 0},
            ageing = {style = 0, opacity = 1.0, color = 0, secondColor = 0},
            makeup = {style = 0, opacity = dbSex == "m" and 0.0 or 1.0, color = 0, secondColor = 0},
            blush = {style = 0, opacity = 1.0, color = 0, secondColor = 0},
            complexion = {style = 0, opacity = 1.0, color = 0, secondColor = 0},
            sunDamage = {style = 0, opacity = 1.0, color = 0, secondColor = 0},
            lipstick = {style = 0, opacity = dbSex == "m" and 0.0 or 1.0, color = 0, secondColor = 0},
            moleAndFreckles = {style = 0, opacity = 1.0, color = 0, secondColor = 0},
            chestHair = {style = 0, opacity = dbSex == "m" and 1.0 or 0.0, color = 0, secondColor = 0},
            bodyBlemishes = {style = 0, opacity = 1.0, color = 0, secondColor = 0}
        }
    }

    MySQL.Async.execute('UPDATE users SET sex = @sex, skin = @skin WHERE identifier = @identifier', {
        ['@sex'] = dbSex,
        ['@skin'] = json.encode(defaultSkin),
        ['@identifier'] = xPlayer.identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('setSex', _source, {
                sexe = data.sexe,
                skin = defaultSkin
            })
        else
        end
    end)
end)

RegisterServerEvent('saveAppearance')
AddEventHandler('saveAppearance', function(skin)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        TriggerEvent('illenium-appearance:server:saveAppearance', _source, skin)
        
        MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
            ['@skin'] = json.encode(skin),
            ['@identifier'] = xPlayer.identifier
        }, function(rowsChanged)
            if rowsChanged > 0 then
            else
            end
        end)
    end
end)

RegisterServerEvent('fb:requestAppearance')
AddEventHandler('fb:requestAppearance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if result[1] and result[1].skin then
                local skin = json.decode(result[1].skin)
                TriggerEvent('illenium-appearance:server:loadAppearance', _source, skin)
                TriggerClientEvent('fb:loadCharacter', _source, skin)
            else
            end
        end)
    end
end)

ESX.RegisterServerCallback('fb:clothes:getMyClothes', function(source, cb, limitations)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.Async.fetchScalar('SELECT sex FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(sex)
        local isFemale = sex == 'f'
        
        local clothes = {
            {
                clotheId = 1,
                name = "Tenue Sud",
                data = {
                    drawables = {
                        jackets = isFemale and { did = 18, tex = 0 } or { did = 5, tex = 0 },
                        torsos = isFemale and { did = 15, tex = 0 } or { did = 5, tex = 0 },
                        undershirts = isFemale and { did = 14, tex = 0 } or { did = 15, tex = 0 },
                        arms = isFemale and { did = 15, tex = 0 } or { did = 5, tex = 0 },
                        pants = isFemale and { did = 23, tex = 0 } or { did = 5, tex = 0 },
                        shoes = isFemale and { did = 19, tex = 0 } or { did = 3, tex = 0 }
                    },
                    props = {
                        hats = { pid = -1, tex = 0 },
                        glasses = { pid = -1, tex = 0 },
                        earrings = { pid = -1, tex = 0 },
                        watches = { pid = -1, tex = 0 },
                        bracelets = { pid = -1, tex = 0 }
                    },
                    outfit_name = "Tenue Sud"
                }
            },
            {
                clotheId = 2,
                name = "Tenue Nord",
                data = {
                    drawables = {
                        jackets = isFemale and { did = 141, tex = 0 } or { did = 76, tex = 0 },
                        torsos = isFemale and { did = 15, tex = 0 } or { did = 15, tex = 0 },
                        undershirts = isFemale and { did = 14, tex = 0 } or { did = 15, tex = 0 },
                        arms = isFemale and { did = 15, tex = 0 } or { did = 15, tex = 0 },
                        pants = isFemale and { did = 121, tex = 0 } or { did = 172, tex = 0 },
                        shoes = isFemale and { did = 152, tex = 0 } or { did = 149, tex = 0 }
                    },
                    props = {
                        hats = { pid = -1, tex = 0 },
                        glasses = { pid = -1, tex = 0 },
                        earrings = { pid = -1, tex = 0 },
                        watches = { pid = -1, tex = 0 },
                        bracelets = { pid = -1, tex = 0 }
                    },
                    outfit_name = "Tenue Nord"
                }
            }
        }
        cb(clothes)
    end)
 end)

ESX.RegisterServerCallback('fb:getSex', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT sex FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(sex)
            cb(sex or 'm')
        end)
    else
        cb('m')
    end
end)

RegisterServerEvent('illenium-appearance:server:saveAppearance')
AddEventHandler('illenium-appearance:server:saveAppearance', function(skin)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer then
        if type(skin) == 'table' then
            if not skin.model then
                local sex = MySQL.Sync.fetchScalar('SELECT sex FROM users WHERE identifier = @identifier', {
                    ['@identifier'] = xPlayer.identifier
                })
                skin.model = sex == 'f' and 'mp_f_freemode_01' or 'mp_m_freemode_01'
            end
            
            MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
                ['@skin'] = json.encode(skin),
                ['@identifier'] = xPlayer.identifier
            })
        end
    end
end)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local _source = source
    local identifier = ESX.GetIdentifier(_source)
    
    if not identifier then return end
    
    MySQL.Async.fetchAll('SELECT firstname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if not result[1] or not result[1].firstname then
            TriggerClientEvent('Az_Ui3:characters:edition', _source, {
                limitations = 'CREATION',
                skin = {}
            })
        end
    end)
end)


RegisterServerEvent('fb:character:createCharacter')
AddEventHandler('fb:character:createCharacter', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if not xPlayer then return end
    
    MySQL.Async.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, nationality = @nationality, dateofbirth = @dateofbirth WHERE identifier = @identifier', {
        ['@firstname'] = data.firstname,
        ['@lastname'] = data.lastname,
        ['@nationality'] = data.nationality,
        ['@dateofbirth'] = data.dateofbirth,
        ['@identifier'] = xPlayer.identifier
    })
    
    if data.medicTraits then
        MySQL.Async.execute('INSERT INTO carnet_sante (identifier, blood_type, allergies, diseases, specificities, addictions) VALUES (@identifier, @blood_type, @allergies, @diseases, @specificities, @addictions)', {
            ['@identifier'] = xPlayer.identifier,
            ['@blood_type'] = data.medicTraits.bloodType,
            ['@allergies'] = json.encode(data.medicTraits.allergies),
            ['@diseases'] = json.encode(data.medicTraits.diseases),
            ['@specificities'] = json.encode(data.medicTraits.specificities),
            ['@addictions'] = json.encode(data.medicTraits.addictions)
        })
    end
end)


ESX.RegisterServerCallback('fb:getHealthInfo', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return cb(nil) end
    
    MySQL.Async.fetchAll('SELECT * FROM carnet_sante WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result[1] then
            result[1].allergies = json.decode(result[1].allergies)
            result[1].diseases = json.decode(result[1].diseases)
            result[1].specificities = json.decode(result[1].specificities)
            result[1].addictions = json.decode(result[1].addictions)
            cb(result[1])
        else
            cb({
                blood_type = 'A+',
                allergies = {},
                diseases = {},
                specificities = {},
                addictions = {}
            })
        end
    end)
end)

RegisterServerEvent('fb:updateHealthInfo')
AddEventHandler('fb:updateHealthInfo', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if not xPlayer then return end
    
    MySQL.Async.execute('UPDATE carnet_sante SET blood_type = @blood_type, allergies = @allergies, diseases = @diseases, specificities = @specificities, addictions = @addictions WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
        ['@blood_type'] = data.bloodType,
        ['@allergies'] = json.encode(data.allergies),
        ['@diseases'] = json.encode(data.diseases),
        ['@specificities'] = json.encode(data.specificities),
        ['@addictions'] = json.encode(data.addictions)
    })
end)

RegisterNetEvent('fb:requestAppearance')
AddEventHandler('fb:requestAppearance', function()
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)

   if xPlayer then
       MySQL.Async.fetchAll('SELECT firstname, skin FROM users WHERE identifier = @identifier', {
           ['@identifier'] = xPlayer.identifier
       }, function(result)
           if not result[1] or not result[1].firstname then
               local defaultSkin = {
                   drawables = {
                       decals = { did = 0, tex = 0 },
                       masks = { did = 0, tex = 0 },
                       necks = { did = 0, tex = 0 },
                       jackets = { did = 0, tex = 0 },
                       vests = { did = 0, tex = 0 },
                       undershirts = { did = 0, tex = 0 },
                       bags = { did = 0, tex = 0 },
                       pants = { did = 0, tex = 0 },
                       torsos = { did = 0, tex = 0 },
                       hair = { second = 0, did = 0, tex = 0 },
                       arms = { did = 0, tex = 0 },
                       shoes = { did = 0, tex = 0 }
                   },
                   bodyb = { did = 0, tex = 0 },
                   tattoos = {},
                   props = {
                       watches = { pid = -1, tex = 0 },
                       glasses = { pid = -1, tex = 0 },
                       earrings = { pid = -1, tex = 0 },
                       hats = { pid = -1, tex = 0 },
                       bracelets = { pid = -1, tex = 0 }
                   },
                   headblend = {
                       shapeFirst = 0,
                       shapeThird = 0,
                       thirdMix = 0,
                       hasParent = false,
                       skinSecond = 0,
                       skinThird = 0,
                       shapeMix = 0.5,
                       skinFirst = 0,
                       skinMix = 0.5,
                       shapeSecond = 0
                   },
                   eyeColor = -1,
                   faceFeatures = {
                       [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0,
                       [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0,
                       [10] = 0, [11] = 0, [12] = 0, [13] = 0, [14] = 0,
                       [15] = 0, [16] = 0, [17] = 0, [18] = 0, [19] = 0, [20] = 0
                   },
                   overlay = {
                       aging = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       molesOrFreckles = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       sunDamage = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       bodyBlemishes = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       blush = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       complexion = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       makeup = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       lipstick = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       eyebrows = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       chestHair = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       bodyBlemishes2 = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       blemishes = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
                       facialHair = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 }
                   },
                   hairColor = { highlight = 0, hair = 1 }
               }

               local defaultData = {
                   medicTraits = {
                       specificities = {},
                       allergies = {},
                       diseases = {},
                       addictions = {},
                       bloodType = 'A+'
                   },
                   targetPedNetId = NetworkGetNetworkIdFromEntity(GetPlayerPed(_source)),
                   sexe = 'm',
                   metaPedType = 'male',
                   firstname = '',
                   lastname = '',
                   nationality = '',
                   dateofbirth = '',
                   skin = defaultSkin,
                   tattoo = {},
                   model = 'mp_m_freemode_01',
                   limitations = 'CREATION'
               }

               TriggerClientEvent('Az_Ui3:characters:edition', _source, defaultData)
           else
               if result[1].skin then
                   local skin = json.decode(result[1].skin)
                   TriggerEvent('illenium-appearance:server:loadAppearance', _source, skin)
                   TriggerClientEvent('fb:loadCharacter', _source, skin)
               else
               end
           end
       end)
   end
end)