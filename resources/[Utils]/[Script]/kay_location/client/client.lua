ESX = exports["framework"]:getSharedObject()

local LocActive = false
local sortauto = false
local pos = {}
local heading = {}
local locCallback = nil
local spawnedPeds = {}

-- ========== PNJ ==========

local function SpawnLocationPed(pos)
    local hash = GetHashKey("s_m_m_autoshop_01")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(10)
    end
    local ped = CreatePed(4, hash, pos.x, pos.y, pos.z - 1.0, 0.0, false, true)
    SetEntityHeading(ped, 0.0)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    return ped
end

Citizen.CreateThread(function()
    for k,v in pairs(LocConfig.vehiclespositions) do
        spawnedPeds[k] = SpawnLocationPed(v.menupos)
    end
    for k,v in pairs(LocConfig.boatspositions) do
        spawnedPeds[#spawnedPeds+1] = SpawnLocationPed(v.menupos)
    end
end)

-- ========== FUNCTIONS ==========

OpenLocation = function(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openRent",
        resource = "kay_location",
        vehicles = data.vehicles
    })
end

local function awaitLocResult(timeoutMs)
    locCallback = nil
    local waited = 0
    local limit = timeoutMs or 10000
    while locCallback == nil and waited < limit do
        Citizen.Wait(50)
        waited = waited + 50
    end
    return locCallback
end

RegisterNUICallback('rent', function(data, cb)
    local price = tonumber(data.price) or 0
    local label = data.name or data.displayName or "Véhicule"
    local model = (data.nameHash or data.hash or data.model or data.name)
    if not model or model == "" then
        ESX.ShowNotification("~r~Modèle invalide pour la location.")
        cb('ok')
        return
    end

    TriggerServerEvent("loc:buyLoc", price)
    local result = awaitLocResult(10000)

    if result == 'can_spawn' then
        local p = pos and pos.x and pos or GetEntityCoords(PlayerPedId())
        local h = heading or GetEntityHeading(PlayerPedId())
        spawnLocCar(model)
        ESX.ShowNotification(("~r~-%s$ ~s~| ~g~%s loué"):format(GroupDigits(price), label))
    elseif result == 'not_enough_money' then
        ESX.ShowNotification(("~r~Pas assez d'argent (~y~%s$~r~)"):format(GroupDigits(price)))
    else
        ESX.ShowNotification("~r~Location indisponible pour le moment.")
    end

    cb('ok')
end)

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent("loc:callback")
AddEventHandler("loc:callback", function(cb)
    locCallback = cb
end)

-- ========== SPAWN VEHICLES ==========

function generateLocPlate()
    return "LOC-" .. string.format("%03d", math.random(1, 999))
end

local function isVec3(v)
    return type(v) == "vector3" or (type(v) == "table" and v.x and v.y and v.z)
end

local function dist(a, b)
    return #(vector3(a.x, a.y, a.z) - vector3(b.x, b.y, b.z))
end

local function getNearestRentalSpawn()
    local ped = PlayerPedId()
    local p = GetEntityCoords(ped)
    local best, bestD = nil, nil

    local function scan(list)
        if not list then return end
        for _, v in pairs(list) do
            if v.menupos and v.spawnpos and v.h then
                local d = dist(p, v.menupos)
                if not bestD or d < bestD then
                    bestD = d
                    best = { pos = v.spawnpos, h = v.h }
                end
            end
        end
    end

    scan(LocConfig.vehiclespositions)
    scan(LocConfig.boatspositions)

    return best, (bestD or 99999.0)
end

local function findClearSpot(startPos, heading)
    local pos = startPos
    if not pos then return nil end
    local tries = {
        { x = 0.0, y = 0.0 }, { x = 2.5, y = 0.0 }, { x = -2.5, y = 0.0 },
        { x = 0.0, y = 2.5 }, { x = 0.0, y = -2.5 }, { x = 4.0, y = 0.0 },
    }

    local hdg = heading or 0.0
    local rad = math.rad(hdg)

    for _, o in ipairs(tries) do
        local dx =  o.x * math.cos(rad) - o.y * math.sin(rad)
        local dy =  o.x * math.sin(rad) + o.y * math.cos(rad)
        local test = vector3(pos.x + dx, pos.y + dy, pos.z)
        if not IsAnyVehicleNearPoint(test.x, test.y, test.z, 2.3) then
            local found, z = GetGroundZFor_3dCoord(test.x, test.y, test.z, false)
            if found then test = vector3(test.x, test.y, z + 0.5) end
            return test
        end
    end
    return pos
end

function spawnLocCar(car, pos, heading)
    local modelHash = GetHashKey(car)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local useAuto = true

    if pos and pos.x and pos.y and pos.z then
        local d = #(vector3(pos.x, pos.y, pos.z) - pedCoords)
        useAuto = (d <= 5.0)
    end

    if useAuto then
        local nearest = getNearestRentalSpawn()
        if nearest then
            pos = nearest.pos
            heading = nearest.h
        else
            pos = pedCoords
            heading = GetEntityHeading(ped)
        end
    end

    local spawnAt = findClearSpot(pos, heading or 0.0)

    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        RequestModel(modelHash)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(modelHash, spawnAt.x, spawnAt.y, spawnAt.z, heading or 0.0, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehicleFuelLevel(vehicle, 100.0)
    SetVehicleNumberPlateText(vehicle, generateLocPlate())
    TaskWarpPedIntoVehicle(ped, vehicle, -1)

    ESX.ShowNotification("~y~Véhicule sorti !")
end

-- ========== INTERACTIONS VEHICLES ==========

Citizen.CreateThread(function()
    while true do
        local nearThing = false
        local plyCoords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(LocConfig.vehiclespositions) do
            local dist = #(plyCoords - v.menupos)
            if dist <= 3.0 then
                nearThing = true
                ESX.ShowHelpNotification("Appuyez sur ~y~E~w~ pour ouvrir le menu de la location de véhicules")
                DrawMarker(6, v.menupos.x, v.menupos.y, v.menupos.z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.6,0.6,0.6,255,220,0,140,false,true,2,false,nil,nil,false)

                if IsControlJustPressed(0, 38) then
                    if not LocActive then
                        pos = v.spawnpos
                        heading = v.h
                        v.vehicles = LocConfig.vehicles
                        OpenLocation(v)
                    end
                end
            end
        end

        if not nearThing then Citizen.Wait(500) else Citizen.Wait(0) end
    end
end)

-- ========== INTERACTIONS BOATS ==========

Citizen.CreateThread(function()
    while true do
        local nearThing = false
        local plyCoords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(LocConfig.boatspositions) do
            local dist = #(plyCoords - v.menupos)
            if dist <= 3.0 then
                nearThing = true
                ESX.ShowHelpNotification("Appuyez sur ~y~E~w~ pour ouvrir le menu de la location de bateaux")
                DrawMarker(6,v.menupos.x,v.menupos.y,v.menupos.z,0,0,0,-90,0,0,0.6,0.6,0.6,255,220,0,140,false,true,2,false,nil,nil,false)

                if IsControlJustPressed(0,38) then
                    if not LocActive then
                        pos = v.spawnpos
                        heading = v.h
                        v.vehicles = LocConfig.boats
                        OpenLocation(v)
                    end
                end
            end
        end

        if nearThing then Citizen.Wait(0) else Citizen.Wait(250) end
    end
end)

-- ========== BLIPS ==========

Citizen.CreateThread(function()
    Wait(1000)
    for k,v in pairs(LocConfig.vehiclespositions) do
        local blip = AddBlipForCoord(v.menupos.x, v.menupos.y, v.menupos.z)
        SetBlipSprite(blip, 524)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 14)
        SetBlipAsShortRange(blip,true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Location de véhicules")
        EndTextCommandSetBlipName(blip)
    end
    for k,v in pairs(LocConfig.boatspositions) do
        local blip = AddBlipForCoord(v.menupos.x, v.menupos.y, v.menupos.z)
        SetBlipSprite(blip, 471)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 14)
        SetBlipAsShortRange(blip,true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Location de bateaux")
        EndTextCommandSetBlipName(blip)
    end
end)

-- ========== UTILS ==========

function GroupDigits(value)
    if value == nil then return 0 end
    local left,num,right = string.match(value, '^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1 '):reverse())
end
