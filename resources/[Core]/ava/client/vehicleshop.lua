ESX = exports['framework']:getSharedObject()

local vehiclesTable = {}
local onlyToSelf = false
local isS4NACardealerOpened = false

local coordsTest = vector3(-2126.072265625, 1106.0412597656, -27.366662979126)
local headingTest = 266.5611267089844

local s4nashop = {
    { blip = 523, blipColor = 77, blipScale = 0.5, x = -57.42, y = -1097.25, z = 26.42, blipText = "Concessionaire", S4NACardealerDistance = 3 },
}

local s4nashopmarker = {
    Size  = { x = 0.8, y = 0.8, z = 0.8 },
    Color = { r = 0, g = 0, b = 0 },
    Type  = 6,
}

local vehiclesForSale = {
    -- Supercars
    ["adder"] = { price = 1000000, weight = 50, marginMin = 5, marginMax = 15 },
    ["cheetah"] = { price = 650000, weight = 50, marginMin = 5, marginMax = 15 },
    ["entityxf"] = { price = 795000, weight = 50, marginMin = 5, marginMax = 15 },
    ["infernus"] = { price = 450000, weight = 50, marginMin = 5, marginMax = 15 },
    ["turismor"] = { price = 500000, weight = 50, marginMin = 5, marginMax = 15 },
    ["vacca"] = { price = 240000, weight = 50, marginMin = 5, marginMax = 15 },
    ["zentorno"] = { price = 725000, weight = 50, marginMin = 5, marginMax = 15 },

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
    ["sanchez"] = { price = 15000, weight = 50, marginMin = 5, marginMax = 15 },
    ["sanchez2"] = { price = 18000, weight = 50, marginMin = 5, marginMax = 15 },
    ["thrust"] = { price = 20000, weight = 50, marginMin = 5, marginMax = 15 },
    ["vortex"] = { price = 35000, weight = 50, marginMin = 5, marginMax = 15 },
}


Citizen.CreateThread(function()
    for k, v in ipairs(s4nashop) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.blip)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.blipScale)
        SetBlipColour(blip, v.blipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.blipText)
        EndTextCommandSetBlipName(blip)
    end
end)

function NearS4NACardealer()
    local pos = GetEntityCoords(GetPlayerPed(-1))

    for k, v in pairs(s4nashop) do
        local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)

        if dist <= v.S4NACardealerDistance then
            return true
        elseif dist <= v.S4NACardealerDistance + 5 then
            return "update"
        end
    end
end

Citizen.CreateThread(function()
    local inRange = false
    local shown = false

    while true do
        inRange = false
        Citizen.Wait(0)
        if NearS4NACardealer() and not isS4NACardealerOpened and NearS4NACardealer() ~= "update" then
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour accéder au catalogue")
            if IsControlJustReleased(0, 38) then
                local allowBuying = true
                local allowTesting = true
                local displayPrices = true
                local onlyToSelf = false
                isS4NACardealerOpened = true
                TriggerEvent('ava:vehicleshop:open', vehiclesForSale, allowBuying, allowTesting, displayPrices,
                    onlyToSelf)
            end
        elseif NearS4NACardealer() == "update" then
            Citizen.Wait(300)
        else
            Citizen.Wait(1000)
        end

        if inRange and not shown then
            shown = true
            exports['okokTextUI']:Open('[E] Pour ouvrir le concessionaire', 'darkblue', 'left')
        elseif not inRange and shown then
            shown = false
            exports['okokTextUI']:Close()
        end
    end
end)

RegisterNetEvent('fb:vehicle:shop:spawnVehicle')
AddEventHandler('fb:vehicle:shop:spawnVehicle', function(model, plate, coords)    
    local modelHash = GetHashKey(model)
    
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(0)
    end

    local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, coords.w, true, false)
    
    SetVehicleNumberPlateText(vehicle, plate)

    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    
    SetModelAsNoLongerNeeded(modelHash)
    
    local playerServerId = GetPlayerServerId(PlayerId())
    local d = NetworkGetNetworkIdFromEntity(vehicle) -- Passez le véhicule en paramètre
    TriggerServerEvent('idev_keysss:addKeyToPlayer', d, playerServerId, 1, 0, plate)
    
    TriggerEvent('esx:showNotification', '~g~Votre véhicule a été livré !')
end)


RegisterNetEvent('fb:vehicle:shop:spawnVehicle2')
AddEventHandler('fb:vehicle:shop:spawnVehicle2', function(model, plate, coords)    
    local modelHash = GetHashKey(model)
    
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(0)
    end
    
    local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, coords.w, true, false)
    
    SetVehicleNumberPlateText(vehicle, plate)

    SetModelAsNoLongerNeeded(modelHash)

    local playerServerId = GetPlayerServerId(PlayerId())
    local d = NetworkGetNetworkIdFromEntity(vehicle) -- Passez le véhicule en paramètre
    TriggerServerEvent('idev_keysss:addKeyToPlayer', d, playerServerId, 1, 0, plate)

    TriggerEvent('esx:showNotification', '~g~Votre véhicule a été livré !')
end)

RegisterNetEvent('ava:vehicleshop:open',
    function(rawVehicleTable, allowBuying, allowTesting, displayPrices, _onlyToSelf)
        onlyToSelf = _onlyToSelf

        for model, data in pairs(rawVehicleTable) do
            local modelHash = GetHashKey(model)
            local class = GetVehicleClassFromName and GetVehicleClassFromName(modelHash) or 0

            local name = '?'
            if GetLabelText(model) == "NULL" then
                name = model:gsub("^%l", string.upper)
            else
                name = GetLabelText(model)
            end

            local maxSpeed = (GetVehicleModelEstimatedMaxSpeed and GetVehicleModelEstimatedMaxSpeed(modelHash) or 0) *
                1.25
            local acceleration = (GetVehicleModelAcceleration and GetVehicleModelAcceleration(modelHash) or 0) * 200
            local braking = (GetVehicleModelMaxBraking and GetVehicleModelMaxBraking(modelHash) or 0) * 100
            local agility = (GetVehicleModelMaxTraction and GetVehicleModelMaxTraction(modelHash) or 0) * 25

            if IsModelValid(GetHashKey(model)) then
                table.insert(vehiclesTable, {
                    price = data.price,
                    weight = data.weight,
                    marginMax = data.marginMax,
                    marginMin = data.marginMin,
                    class = class,
                    model = model,
                    name = name,
                    -- link = 'https://docs.fivem.net/vehicles/' .. model .. '.webp',
                    link = 'assets/vehicleshop/' .. model .. '.png',
                    seats = GetVehicleModelNumberOfSeats(modelHash),
                    maxSpeed = maxSpeed,
                    acceleration = acceleration,
                    braking = braking,
                    agility = agility,
                })
            end
        end

        AddNuiFocus('vehicleshop')
        SendReactMessage("VehicleShop:SetVehicles", vehiclesTable)
        SendReactMessage("VehicleShop:SetAllowBuying", allowBuying)
        SendReactMessage("VehicleShop:SetAllowTesting", allowTesting)
        SendReactMessage("VehicleShop:SetDisplayPrices", displayPrices)
    end)

local testDriveEntity = nil
local testDriveTimeout = 15000

RegisterNUICallback('VehicleShop:Test', function(data, cb)
    cb('ok')
    if IS_RDR2 then return end
    local hash = GetHashKey(data.model)
    local lastPlayerCoords = GetEntityCoords(PlayerPedId())

    TriggerServerEvent('fb:vehicle:shop:test', true)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end

    RequestCollisionAtCoord(coordsTest.x, coordsTest.y, coordsTest.z)
    SetEntityCoords(PlayerPedId(), coordsTest.x, coordsTest.y, coordsTest.z)
    repeat Wait(0) until GetGlobalWaterType() == 0
    RemoveNuiFocus('vehicleshop')
    SendReactMessage("VehicleShop:SetVehicles", nil)

    testDriveEntity = CreateVehicle(hash, coordsTest.x, coordsTest.y, coordsTest.z, headingTest, false, true)
    Entity(testDriveEntity).state.hotwired = true

    SetVehicleNumberPlateText(testDriveEntity, "  TEST  ")

    local timeout = GetGameTimer()
    repeat
        SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
        Wait(0)
    until GetVehiclePedIsIn(PlayerPedId()) == testDriveEntity or GetGameTimer() - timeout > 5000
    if GetGameTimer() - timeout > 5000 then testDriveEntity = nil end
    SetEntityCoords(testDriveEntity, coordsTest.x, coordsTest.y, coordsTest.z)

    Citizen.CreateThread(function()
        Wait(testDriveTimeout)
        if testDriveEntity then
            DeleteEntity(testDriveEntity)
            testDriveEntity = nil
            SetEntityCoords(PlayerPedId(), lastPlayerCoords.x, lastPlayerCoords.y, lastPlayerCoords.z)
            TriggerServerEvent('fb:vehicle:shop:test', false)
            AddNuiFocus('vehicleshop')
            SendReactMessage("VehicleShop:SetVehicles", vehiclesTable)
        end
    end)
end)

RegisterNetEvent('ava:vehicleshop:close', function()
    RemoveNuiFocus('vehicleshop')
    SendReactMessage("VehicleShop:SetVehicles", nil)
    vehiclesTable = {}
    isS4NACardealerOpened = false
end)

RegisterNUICallback('VehicleShop:Close', function(data, cb)
    RemoveNuiFocus('vehicleshop')
    SendReactMessage("VehicleShop:SetVehicles", nil)
    vehiclesTable = {}
    isS4NACardealerOpened = false
    cb('ok')
end)

RegisterNUICallback('VehicleShop:Buy', function(data, cb)
    local vehicleColor = "#000000"
    local hex = vehicleColor:gsub('#', '')
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)

    RemoveNuiFocus('vehicleshop')
    SendReactMessage("VehicleShop:SetVehicles", nil)
    vehiclesTable = {}

    TriggerServerEvent('fb:vehicle:shop:buy', GetPlayerServerId(PlayerId()), data.selectedVehicle.model,
        data.selectedVehicle.marginMin or 0, vehicleColor)
    cb('ok')
end)

RegisterNUICallback('VehicleShop:SelectVehicle', function(data, cb)
    cb('ok')
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



RegisterNetEvent('fb:vehicle:shop:cashorbank')
AddEventHandler('fb:vehicle:shop:cashorbank', function(price, model)
    -- Appeler le serveur pour obtenir les comptes bancaires
    ESX.TriggerServerCallback('fb:bankaccount:getPayWith', function(bankAccounts)
        local buttons = {
            {
                text = "En espèce ($".. price ..")",
                style = { color = "black", active = true, icon = "wallet" },
                cb = function()
                    isS4NACardealerOpened = false
                    TriggerServerEvent('fb:vehicle:shop:paycash', price, model)
                end
            }
        }

        if bankAccounts and #bankAccounts > 0 then
            local account = bankAccounts[1] 
            table.insert(buttons, {
                text = "Compte N°".. account.id .. " | " .. account.iban,
                style = { color = "black", active = true, icon = "card" },
                cb = function()
                    isS4NACardealerOpened = false
                    TriggerServerEvent('fb:vehicle:shop:paybank', account.id, price, model)
                end                
            })
        else
            -- Si aucun compte bancaire n'est disponible
            table.insert(buttons, {
                text = "Aucun compte bancaire disponible",
                style = { color = "red", active = false, icon = "cancel" }
            })
        end

        -- Ajouter un bouton d'annulation
        table.insert(buttons, {
            text = "Annuler",
            style = { color = "red", active = true, icon = "cancel" },
            cb = function()
                isS4NACardealerOpened = false
            end
        })

        -- Afficher le menu
        exports['ava']:displayPrompt('Paiement de $'.. price, nil, false, buttons)
    end)
end)


RegisterNetEvent('ava:vehicleshop:notif:notenough')
AddEventHandler('ava:vehicleshop:notif:notenough', function()
    ESX.ShowNotification("~r~Vous n'avez pas assez d'argent.")
end)

RegisterNetEvent('ava:vehicleshop:notif:youbought')
AddEventHandler('ava:vehicleshop:notif:youbought', function(model, price)
    local plate = GeneratePlate()
    local metada = {
        plate = plate,
        description = string.format("Plaque: %s", plate)
    }
    ESX.ShowNotification('~g~L\'achat à été effectué ! \n\n~w~Modèle : ~b~' ..
        model .. '~w~\nPlaque : ~b~' .. plate .. '~w~\nPrix : ~g~' .. price .. '$')
        
    TriggerServerEvent('fb:vehicle:shop:setinsql', plate, model)
end)

local function drawFlatMarker(marker)
    DrawMarker(
        marker.Type,
        marker.x, marker.y, marker.z - 1.0,
        0.0, 0.0, 0.0,
        -90.0, 0.0, 0.0,
        marker.Size.x, marker.Size.y, marker.Size.z,
        marker.Color.r, marker.Color.g, marker.Color.b,
        100,
        false,
        true,
        2,
        nil,
        nil,
        false
    )
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())

        for _, shop in pairs(s4nashop) do
            local distance = #(playerCoords - vector3(shop.x, shop.y, shop.z))
            if distance < shop.S4NACardealerDistance then
                drawFlatMarker({
                    Type = s4nashopmarker.Type,
                    x = shop.x,
                    y = shop.y,
                    z = shop.z,
                    Size = s4nashopmarker.Size,
                    Color = s4nashopmarker.Color
                })
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
