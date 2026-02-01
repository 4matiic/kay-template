local entity = false

Citizen.CreateThread(function()
    while true do
        local wait = 150
        local player = PlayerPedId()
        local entityFound, pedArmed = GetEntityPlayerIsFreeAimingAt(PlayerId())
        if entityFound and entity ~= pedArmed and IsPedInAnyVehicle(pedArmed, false) and IsPedArmed(player, 7) then
            local vehicle = GetVehiclePedIsIn(pedArmed, false)
            local speed = GetEntitySpeed(vehicle) * 3.6 
            if GetDistanceBetweenCoords(GetEntityCoords(player, true), GetEntityCoords(pedArmed, true), true) <= Config.distance and speed <= Config.speedvehicle then
                entity = pedArmed
                if not IsPedAPlayer(pedArmed) then
                    TaskLeaveVehicle(pedArmed, vehicle, 256)
                    while IsPedInAnyVehicle(pedArmed, false) do
                        Citizen.Wait(0)
                    end
                    SetBlockingOfNonTemporaryEvents(pedArmed, true)
                    TaskWanderInArea(pedArmed, 0, 0, 0, 20, 100, 100)
                    TaskSmartFleePed(pedArmed, player, 1000.0, -1, true, true)
                    SetVehRadioStation(vehicle, "OFF")
                    if not IsEntityDead(pedArmed) and math.random(1, 100) <= Config.pourcentage then 
                        local totalWeight = 0
                        for _, weaponData in ipairs(Config.weapons) do
                            totalWeight = totalWeight + weaponData.chance
                        end
                        local randomNum = math.random(1, totalWeight)
                        local chosenWeapon                    
                        for _, weaponData in ipairs(Config.weapons) do
                            randomNum = randomNum - weaponData.chance
                            if randomNum <= 0 then
                                chosenWeapon = weaponData
                                break
                            end
                        end
                        if chosenWeapon then
                            local weapon = GetHashKey(chosenWeapon.hash) 
                            GiveWeaponToPed(pedArmed, weapon, 1000, false, true) 
                            TaskCombatPed(pedArmed, player, 0, 16)
                        end
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)
