local ESX = exports["framework"]:getSharedObject()

local TableSQLPersist = {}
local TableSQLPersist2 = {}
local objectPersist = {}
CreateThread(function()
	while true do
        local attente = 0
		local playerped = PlayerPedId()		
		if IsPedInAnyVehicle(playerped, false) then	
			local veh = GetVehiclePedIsUsing(playerped)	
			if GetPedInVehicleSeat(veh, -1) == playerped then
                local speed = (GetEntitySpeed(veh) * 3.6)
                attente = 0
                if speed == 0.0 then
                --    ESX.ShowHelpNotification("Appuyer sur ~INPUT_SELECT_CHARACTER_MICHAEL~ pour stationner le véhicule.")
                    if IsControlJustPressed(1, 166) then
                        local prop = nil
                        local vehicleProps = ESX.Game.GetVehicleProperties(veh)	
                        local vehplate = vehicleProps.plate
                        local vehposition = GetEntityCoords(veh)
                        local heading = GetEntityHeading(veh)
                        local class = GetVehicleClass(veh)
                        if class == 0 then
                            prop = "imp_prop_covered_vehicle_02a"
                        elseif class == 1 then
                            prop = "imp_prop_covered_vehicle_03a"
                        elseif class == 2 then
                            prop = "imp_prop_covered_vehicle_07a"
                        elseif class == 3 then
                            prop = "imp_prop_covered_vehicle_01a"
                        elseif class == 4 then
                            prop = "imp_prop_covered_vehicle_04a"
                        elseif class == 5 then
                            prop = "imp_prop_covered_vehicle_06a"
                        elseif class == 6 then
                            prop = "imp_prop_covered_vehicle_03a"
                        elseif class == 7 then
                            prop = "imp_prop_covered_vehicle_01a"
                        elseif class == 8 then
                            prop = "prop_ztype_covered"
                        elseif class == 11 then
                            prop = "imp_prop_covered_vehicle_07a"
                        elseif class == 12 then
                            prop = "imp_prop_covered_vehicle_07a"
                        elseif class == 13 then
                            prop = "prop_ztype_covered"
                        elseif class == 18 then
                            prop = "imp_prop_covered_vehicle_03a"
                        end
                        TriggerServerEvent('esx_hidecar:storeHiddenVehicle', vehplate, vehicleProps,vehposition,prop,heading)
                    end
                end
			end
		end
        Wait(attente)
	end
end)

local obj = nil
local prop_car_test_name = nil
RegisterNetEvent('esx_hidecar:CoverVehicle')
AddEventHandler('esx_hidecar:CoverVehicle', function(source,args)
    obj = nil
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false)
	local class = GetVehicleClass(vehicle)
    local heading = GetEntityHeading(vehicle)
    local modelcar = GetEntityModel(vehicle)
	local x,y,z = table.unpack(GetEntityCoords(ped, true))

		TaskLeaveVehicle(ped,vehicle,64)
		Wait(2000)

        print(class)
		if class == 0 then
            local objectname = 'imp_prop_covered_vehicle_02a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end

		if class == 1 then
            local objectname = 'imp_prop_covered_vehicle_03a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
           -- TriggerServerEvent("Load_Car_Persist_Park")
		end
	
		if class == 2 then
            local objectname = 'imp_prop_covered_vehicle_07a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end

		if class == 3 then
            local objectname = 'imp_prop_covered_vehicle_01a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end

		if class == 4 then
            local objectname = 'imp_prop_covered_vehicle_04a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
           --TriggerServerEvent("Load_Car_Persist_Park")
		end	

		if class == 5 then
            local objectname = 'imp_prop_covered_vehicle_06a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
           -- TriggerServerEvent("Load_Car_Persist_Park")
		end	

		if class == 6 then
            local objectname = 'imp_prop_covered_vehicle_03a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end	

		if class == 7 then
            local objectname = 'imp_prop_covered_vehicle_01a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end
        if class == 8 then
            local objectname = 'prop_ztype_covered'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end

        if class == 12 then
            local objectname = 'imp_prop_covered_vehicle_07a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end

        if class == 13 then
            local objectname = 'prop_ztype_covered'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end

        if class == 11 then
            local objectname = 'imp_prop_covered_vehicle_07a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end
        if class == 18 then
            local objectname = 'imp_prop_covered_vehicle_03a'
            if not HasModelLoaded(objectname) then
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Wait(1)
                end
            end
            DeleteVehicle(vehicle)
            Wait(200)
            local obj = CreateObject(objectname, x, y, z, true, true, true)
            prop_car_test_name = ObjToNet(obj)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityHeading(obj, heading)
            PlaceObjectOnGroundProperly(obj)
            SetEntityCollision(obj, 0, 0)
            SetEntityAlpha(obj, 170, 170)

            local NetId = NetworkGetNetworkIdFromEntity(obj)
            table.insert(objectPersist, {
                id = NetId,
                label = objectname
            })
            --TriggerServerEvent("Load_Car_Persist_Park")
		end
	Wait(100)
end)



---create spawn props load player 
CreateThread(function()
    TriggerServerEvent("Load_Car_Persist_Park")
end)

CreateThread(function()
    TriggerServerEvent("Load_Car_Persist_Park2")
end)

RegisterNetEvent("Bcore_update_set_client_persist_car")
AddEventHandler("Bcore_update_set_client_persist_car", function(table)
    TableSQLPersist = table
    local playerped = PlayerPedId()
    StartFunctionRecupCAr(TableSQLPersist)
    for k,v in pairs(TableSQLPersist) do
        if TableSQLPersist then
            if not HasModelLoaded(v.classcar) then
                RequestModel(v.classcar)
                while not HasModelLoaded(v.classcar) do
                    Wait(1)
                end
            end
            local objectId2 = GetClosestObjectOfType(v.position.x, v.position.y, v.position.z, 5.0, v.classcar, false)
            if not DoesEntityExist(objectId2) then
                local ObjTable = CreateObject(v.classcar, v.position.x, v.position.y, v.position.z -0.5, true, false, true)
                SetEntityAsMissionEntity(ObjTable, true, true)
                SetEntityHeading(ObjTable, v.heading)
                PlaceObjectOnGroundProperly(ObjTable)
                SetEntityCollision(ObjTable, false, false)
                --SetEntityInvincible(ObjTable, true)
                SetEntityAlpha(ObjTable, 170, 170)
            end
        end
    end
end)

function RemovePersistOBJ(id, k)
    CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            DeleteObject(entity)
            if not DoesEntityExist(entity) then 
                table.remove(objectPersist, k)
            end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
    end)
end


function StartFunctionRecupCAr(table)
    TableSQLPersist = table
    CreateThread(function()
        while true do
            local NearZone = false
            local player = PlayerPedId()
            local pCoords = GetEntityCoords(player)
            for k,v in pairs(TableSQLPersist) do
                if TableSQLPersist then
                    if(v.position and type(v.position) ~= "table") then
                        v.position = json.decode(v.position)
                    end
                    local dst = GetDistanceBetweenCoords(pCoords, v.position.x,v.position.y,v.position.z, true)
                    if dst < 5.0 then
                        if block == true then 
                            NearZone = false
                        else
                            NearZone = true
                            if dst <= 1.5 then
                                if not InAction then
                                    local objectId2s = GetClosestObjectOfType(v.position.x, v.position.y, v.position.z, 3.0, v.classcar, false)
                                    if objectId2s ~= 0 then
                                        if DoesEntityExist(objectId2s) then
                                            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour récuperer le véhicule.")
                                            if IsControlJustReleased(1, 38) then
                                                ESX.TriggerServerCallback("Bcore_Check_Is_Owner_Car_Recup_Persist", function(verif)
                                                    if verif then
                                                        SpawnCarPersist(objectId2s, v.vehicle, v.position, v.heading)
                                                        DeleteObject(objectId2s)
                                                        DeleteEntity(objectId2s)
                                                    else 
                                                        RageUI.Popup({message = "Ce n'est pas votre véhicule"})
                                                    end
                                                end, v.vehicle.plate)
                                            end
                                        end
                                    else
                                        if #objectPersist > 0 then 
                                            for _,m in pairs(objectPersist) do
                                                local coord = GetEntityCoords(PlayerPedId())
                                                local entity = NetworkGetEntityFromNetworkId(m.id)
                                                local ObjCoords = GetEntityCoords(entity)
                                                local objectId2stest = GetClosestObjectOfType(ObjCoords.x, ObjCoords.y, ObjCoords.z, 3.0, m.label, false)
                                                local distancefin = GetDistanceBetweenCoords(coord, ObjCoords.x, ObjCoords.y, ObjCoords.z, true)
                                                if DoesEntityExist(objectId2stest) then
                                                    if distancefin <= 1.5 then
                                                        ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour récuperer le véhicule.")
                                                        if IsControlJustReleased(1, 38) then
                                                            ESX.TriggerServerCallback("Bcore_Check_Is_Owner_Car_Recup_Persist", function(verif)
                                                                if verif then
                                                                    SpawnCarPersist(objectId2stest, v.vehicle, v.position, v.heading)
                                                                    RemovePersistOBJ(m.id, _)
                                                                else 
                                                                    RageUI.Popup({message = "Ce n'est pas votre véhicule"})
                                                                end
                                                            end, v.vehicle.plate)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                break
                            end
                        end
                    end
                end
            end

            if not NearZone then
                Wait(1000)
            else
                Wait(1)
            end
        end
    end)
end

function SpawnCarPersist(objectId2s, vehicle, position, heading)
    ESX.Game.SpawnVehicle(vehicle.model, vector3(position.x, position.y, position.z), heading, function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
        SetVehRadioStation(callback_vehicle, "OFF")
        --SetVehicleDoorsLocked(callback_vehicle, 2)
        --TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
    end)
    TriggerServerEvent("Bcore_Delete_Vehicle_is_Spawn_Persist", token, vehicle.plate)
end

RegisterNetEvent("Bcore_update_set_client_persist_car_Tableset")
AddEventHandler("Bcore_update_set_client_persist_car_Tableset", function(table)
    TableSQLPersist = table
end)

RegisterNetEvent("Bcore_update_set_client_persist_car_Tableset2")
AddEventHandler("Bcore_update_set_client_persist_car_Tableset2", function(table2)
    TableSQLPersist2 = table2
end)

-----véhicle no despawn 2 
CreateThread(function()
	while true do
        local attente = 0
		local playerped = PlayerPedId()		
        local veh = GetVehiclePedIsUsing(playerped)
        if IsPedInAnyVehicle(playerped, false) then
            attente = 0
            if IsControlJustPressed(1, 166) then
                if IsPedInAnyVehicle(playerped, false) then
                    veh = GetVehiclePedIsUsing(playerped)
                    local prop = nil
                    local vehicleProps = ESX.Game.GetVehicleProperties(veh)	
                    local vehplate = vehicleProps.plate
                    local vehposition = GetEntityCoords(veh)
                    local heading = GetEntityHeading(veh)
                    local class = GetVehicleClass(veh)
                    local idnetworkcar = ObjToNet(veh)
                    if class == 0 then
                        prop = "imp_prop_covered_vehicle_02a"
                    elseif class == 1 then
                        prop = "imp_prop_covered_vehicle_03a"
                    elseif class == 2 then
                        prop = "imp_prop_covered_vehicle_07a"
                    elseif class == 3 then
                        prop = "imp_prop_covered_vehicle_01a"
                    elseif class == 4 then
                        prop = "imp_prop_covered_vehicle_04a"
                    elseif class == 5 then
                        prop = "imp_prop_covered_vehicle_06a"
                    elseif class == 6 then
                        prop = "imp_prop_covered_vehicle_03a"
                    elseif class == 7 then
                        prop = "imp_prop_covered_vehicle_01a"
                    elseif class == 8 then
                        prop = "prop_ztype_covered"
                    elseif class == 11 then
                        prop = "imp_prop_covered_vehicle_07a"
                    elseif class == 12 then
                        prop = "imp_prop_covered_vehicle_07a"
                    elseif class == 13 then
                        prop = "prop_ztype_covered"
                    elseif class == 18 then
                        prop = "imp_prop_covered_vehicle_03a"
                    end
                    TriggerServerEvent("Bcore_update_Coords_Car_Persist2", token,vehplate, vehicleProps,vehposition,prop,heading,idnetworkcar)
                end
            end
        else
            attente = 0
        end
        Wait(attente)
	end
end)


CreateThread(function()
    while true do
        local NearZone = false
        local player = PlayerPedId()
        local pCoords = GetEntityCoords(player)
        local entity = nil
        local tabltest = {}
        for k,v in pairs(TableSQLPersist2) do
            if TableSQLPersist2 then
                if(v.position and type(v.position) ~= "table") then
                    v.position = json.decode(v.position)
                end
                if (v.vehicle and type(v.vehicle) ~= "table") then
                    v.vehicle = json.decode(v.vehicle)
                end
                if not NetworkDoesEntityExistWithNetworkId(v.idnetworkcar) then
                    if v.vehicle.model ~= tabltest["modelcar"] then
                        local cartest = GetClosestVehicle(v.position.x, v.position.y, v.position.z, 5.0, 0, 71)
                        if not DoesEntityExist(cartest) then
                            ESX.Game.SpawnVehicle(v.vehicle.model, vector3(v.position.x, v.position.y, v.position.z), v.heading, function(callback_vehicle)
                                ESX.Game.SetVehicleProperties(callback_vehicle, v.vehicle)
                                SetVehRadioStation(callback_vehicle, "OFF")
                                local idnetworkcar = ObjToNet(callback_vehicle)
                                local vehicleProps = ESX.Game.GetVehicleProperties(callback_vehicle)	
                                local vehplate = vehicleProps.plate
                                SetVehicleDoorsLocked(callback_vehicle, 2)
                                TriggerServerEvent("Bcore_update_network_persist_car",idnetworkcar,vehplate)
                                SetNetworkIdCanMigrate(idnetworkcar, true)
                                entity = NetworkGetEntityFromNetworkId(idnetworkcar)
                                table.insert(tabltest, {modelcar = v.vehicle.model, entity = entity})
                                NetworkRequestControlOfEntity(entity)
                            end)
                        end
                    end
                end
            end
        end

        if not NearZone then
            Wait(1000)
        else
            Wait(1)
        end
    end
end)
