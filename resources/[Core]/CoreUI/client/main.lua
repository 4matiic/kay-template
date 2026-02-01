local selectedPlayer = nil
local ESX = exports['framework']:getSharedObject()

local disablePnjSpawn = false
local disableVehSpawn = false
local playerList = {}


local allowedGroups = {
    ["superadmin"] = true,
    ["admin"] = true,
    ["mod"] = true,
    ["dev"] = true
}


function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then return end
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, {
            __gc = function(enum)
                if enum.destructor and enum.handle then
                    enum.destructor(enum.handle)
                end
            end
        })
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        disposeFunc(iter)
    end)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end


function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        return result
    else
        Wait(500)
        return nil
    end
end


RegisterCommand('adminmenu', function()
    TriggerServerEvent("CoreUI:checkAdmin")
end, false)


RegisterCommand('toggle_noclip', function()
    IsPlayerAuthorizedForNoClip(function(isAllowed)
        if isAllowed then
            ToggleNoClip()
        else
            ESX.ShowNotification("~r~Vous n\'avez pas les permission admin.")
        end
    end)
end, false)
RegisterKeyMapping('toggle_noclip', 'Activer/Désactiver NoClip', 'keyboard', 'F3')




RegisterNetEvent("CoreUI:receivePlayerList")
AddEventHandler("CoreUI:receivePlayerList", function(players)
    playerList = players
end)


local isFrozen = false
RegisterNetEvent("CoreUI:toggleFreezeClient")
AddEventHandler("CoreUI:toggleFreezeClient", function()
    isFrozen = not isFrozen
    FreezeEntityPosition(PlayerPedId(), isFrozen)
    ESX.ShowNotification(isFrozen and "~r~Tu es figé." or "~g~Tu es défigé.")
end)

RegisterNetEvent("CoreUI:doCustomHeal")
AddEventHandler("CoreUI:doCustomHeal", function()
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
    ClearPedBloodDamage(ped)

    local hasStatus = false
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        if status then status.set(1000000) hasStatus = true end
    end)
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        if status then status.set(1000000) hasStatus = true end
    end)

    if not hasStatus then
        ESX.ShowNotification("~y~Faim/soif non détectée dans esx_status.")
    else
        ESX.ShowNotification("~g~Tu as été soigné + nourri.")
    end
end)

RegisterNetEvent("CoreUI:doCustomRevive")
AddEventHandler("CoreUI:doCustomRevive", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
    Wait(100)
    ClearPedTasksImmediately(ped)
    ClearPedBloodDamage(ped)
    SetEntityHealth(ped, 200)

    TriggerEvent("esx:onPlayerSpawn")
    TriggerEvent("playerSpawned")
    TriggerEvent("ars_ambulancejob:revive")
    TriggerServerEvent("ars_ambulancejob:setDeathStatus", false)

    SetPlayerInvincible(PlayerId(), false)
    SetEntityInvincible(PlayerPedId(), false)
    ESX.ShowNotification("~g~Tu as été totalement réanimé.")
end)


RegisterNetEvent("CoreUI:showScreenshot")
AddEventHandler("CoreUI:showScreenshot", function(url)
    print("[CoreUI] Affichage du screenshot via NUI :", url)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "showScreenshot",
        url = url
    })
end)

RegisterNUICallback("closeScreenshot", function(_, cb)
    print("[CoreUI] Fermeture de la NUI screenshot.")
    SetNuiFocus(false, false)
    cb({})
end)

RegisterCommand("testsnap", function()
    TriggerEvent("CoreUI:takeScreenshot", GetPlayerServerId(PlayerId()))
end)

RegisterKeyMapping('adminmenu', 'Ouvrir le menu admin', 'keyboard', 'F10')

RegisterNetEvent("CoreUI:openMenu")
AddEventHandler("CoreUI:openMenu", function()
    if open then return end
    open = true

    local main = RageUI.CreateMenu("ADMIN", "Menu Administration") 
    local players = RageUI.CreateSubMenu(main, "ADMIN", "JOUEURS CONNECTER")
    local perso = RageUI.CreateSubMenu(main, "ADMIN", "ACTIONS PERSONNEL")
    local adminActions = RageUI.CreateSubMenu(main, "ADMIN", "ACTION SUPLEMENTAIRE")
    local vehicleMenu = RageUI.CreateSubMenu(main, "ADMIN", "INFORMATION VEHICULE")
    local illegalMenu = RageUI.CreateSubMenu(main, "ADMIN", "GESTION ILLEGAL")
    local craftMenu = RageUI.CreateSubMenu(main, "ADMIN", "GESTION ILLEGAL")
    local posMenu = RageUI.CreateSubMenu(main, "ADMIN", "GESTION POSITION")
    local superetteMenu = RageUI.CreateSubMenu(posMenu, "ADMIN", "TELEPORTATION LTD")
    local amunationMenu = RageUI.CreateSubMenu(posMenu, "ADMIN", "TELEPORTATION AMMUNATION")
    local shopMenu = RageUI.CreateSubMenu(posMenu, "ADMIN", "TELEPORTATION BOUTIQUE")
    local fuelMenu = RageUI.CreateSubMenu(posMenu, "ADMIN", "TELEPORTATION STATIONS ESSENCE")
    local bankMenu = RageUI.CreateSubMenu(posMenu, "ADMIN", "TELEPORTATION BANK")
    local barberMenu = RageUI.CreateSubMenu(posMenu, "ADMIN", "TELEPORTATION COIFFEUR")
    local clothesMenu = RageUI.CreateSubMenu(posMenu, "ADMIN", "TELEPORTATION BINCO")
    local tattooMenu = RageUI.CreateSubMenu(posMenu, "ADMIN", "TELEPORTATION TATTOO")
    local devMenu = RageUI.CreateSubMenu(main, "ADMIN", "OUTILS DE DEVELOPPEMENT")

    TriggerServerEvent("CoreUI:requestPlayerList")


    RageUI.Visible(main, true)

    CreateThread(function()
        while open do
            Wait(1)
            RageUI.IsVisible(main, function()
                RageUI.Button("Liste des joueurs", nil, {}, true, {}, players)
                RageUI.Button("Personnel", nil, {}, true, {}, perso)
                RageUI.Button("Administrateur", nil, {}, true, {}, adminActions)
                RageUI.Button("Véhicule", nil, {}, true, {}, vehicleMenu)
                RageUI.Button("Illégal", nil, {}, true, {}, illegalMenu)
                RageUI.Button("Gestion", nil, {}, true, {}, posMenu)
                RageUI.Button("Développement", nil, {}, true, {}, devMenu)
            end)
    
        RageUI.IsVisible(players, function()
            for _, player in ipairs(playerList) do
                local serverId = player.id
                local name = player.name

                RageUI.Button(("[%s] %s"):format(serverId, name), nil, {}, true, {
                    onSelected = function()
                        OpenPlayerActions(serverId, name)
                    end
                })
            end
        end)
         
            
            RageUI.IsVisible(perso, function()
                RageUI.Button("Se Revive", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:reviveCustom", GetPlayerServerId(PlayerId()))
                    end
                })
    
                RageUI.Button("Se Heal", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:healPlayer", GetPlayerServerId(PlayerId()))
                    end
                })
            end)
    
            RageUI.IsVisible(adminActions, function()

                    RageUI.Button("Chercher un item", nil, {}, true, {
                        onSelected = function()
                            local patern = exports["ava"]:ShowInput("Nom ou motif d’item à chercher", false, 50, "small_text", "", false, "center")
                            if patern and patern ~= "" then
                                ExecuteCommand("searchitems " .. patern)
                            else
                                ESX.ShowNotification("~r~Motif invalide ou vide.")
                            end
                        end
                    })
                
                    RageUI.Button("Ouvrir la poubelle", nil, {}, true, {
                        onSelected = function()
                            local confirm = exports["ava"]:ShowInput("Confirmer ? (oui/non)", false, 10, "small_text", "", false, "center")
                            if confirm and confirm:lower() == "oui" then
                                ExecuteCommand("trash")
                                ESX.ShowNotification("~g~Poubelle ouverte.")
                            else
                                ESX.ShowNotification("~r~Action annulée.")
                            end
                        end
                    })

                    RageUI.Button("Crée une Annonce", nil, {}, true, {
                          onSelected = function()
                          ExecuteCommand("annoncejob")
                          RageUI.CloseAll()
                          end})

                    RageUI.Button("Panel Kays", nil, {}, true, {
                          onSelected = function()
                          ExecuteCommand("panel")
                          RageUI.CloseAll()
                          end})
                end)
    
            RageUI.IsVisible(vehicleMenu, function()

                RageUI.Button("Spawn un véhicule", nil, {}, true, {
                    onSelected = function()
                        local modelName = exports["ava"]:ShowInput("Nom du modèle", false, 50, "small_text", "", false, "center")
                        if modelName and modelName ~= "" then
                            local model = GetHashKey(modelName)
                            RequestModel(model)
                            local timeout = 0
                            while not HasModelLoaded(model) and timeout < 1000 do Wait(10) timeout += 1 end
                            if HasModelLoaded(model) then
                                local ped = PlayerPedId()
                                local coords = GetEntityCoords(ped)
                                local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z + 1.0, GetEntityHeading(ped), true, false)
                                TaskWarpPedIntoVehicle(ped, vehicle, -1)
                                ESX.ShowNotification("~g~Véhicule spawné.")
                            else
                                ESX.ShowNotification("~r~Modèle invalide.")
                            end
                        end
                    end
                })
            
                RageUI.Button("Supprimer", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        if veh ~= 0 then DeleteVehicle(veh) ESX.ShowNotification("~r~Véhicule supprimé.") end
                    end
                })
            
                RageUI.Button("Réparer", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        SetVehicleFixed(veh)
                        ESX.ShowNotification("~g~Véhicule réparé.")
                    end
                })
            
                RageUI.Button("Nettoyer", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        SetVehicleDirtLevel(veh, 0.0)
                        ESX.ShowNotification("~g~Véhicule nettoyé.")
                    end
                })
            
                RageUI.Button("Salir", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        SetVehicleDirtLevel(veh, 15.0)
                        ESX.ShowNotification("~y~Véhicule sali.")
                    end
                })
            
                RageUI.Button("Freeze véhicule", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        FreezeEntityPosition(veh, true)
                        ESX.ShowNotification("~r~Véhicule figé.")
                    end
                })
            
                RageUI.Button("Unfreeze véhicule", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        FreezeEntityPosition(veh, false)
                        ESX.ShowNotification("~g~Véhicule libéré.")
                    end
                })
            
                RageUI.Button("Gizmo Véhicule", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        if veh and veh ~= 0 then
                            local gizmo = exports.object_gizmo:useGizmo(veh)
                            local netId = NetworkGetNetworkIdFromEntity(veh)
                            if not netId or netId == 0 then
                                local pos = vector3(gizmo.position.x, gizmo.position.y, gizmo.position.z)
                                local rot = vector3(gizmo.rotation.x, gizmo.rotation.y, gizmo.rotation.z)
                                SetEntityCoords(veh, pos)
                                SetEntityRotation(veh, rot)
                            else
                                TriggerServerEvent('ContextMenu:Vehicle:Gizmo', netId, gizmo)
                            end
                        else
                            ESX.ShowNotification("~r~Aucun véhicule détecté.")
                        end
                    end
                })
            
                RageUI.Button("Remplacer", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        local model = GetEntityModel(veh)
                        DeleteVehicle(veh)
                        Wait(500)
                        local coords = GetEntityCoords(PlayerPedId())
                        local newVeh = CreateVehicle(model, coords.x, coords.y, coords.z + 1.0, GetEntityHeading(PlayerPedId()), true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), newVeh, -1)
                        ESX.ShowNotification("~g~Véhicule remplacé.")
                    end
                })
            
                RageUI.Button("Give les clés", nil, {}, true, {
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        if veh and veh ~= 0 then
                            local plate = GetVehicleNumberPlateText(veh)
                            local model = GetEntityModel(veh)
                            local modelName = GetDisplayNameFromVehicleModel(model)
                            TriggerServerEvent("CoreUI:giveCarkey", plate, modelName)
                            ESX.ShowNotification("~g~Clés données (item ajouté).")
                        else
                            ESX.ShowNotification("~r~Tu dois être dans un véhicule.")
                        end
                    end
                })
        
            end)
    
            RageUI.IsVisible(illegalMenu, function()

                RageUI.Button("Craft", nil, {}, true, {}, craftMenu)

            end)

            RageUI.IsVisible(craftMenu, function()

                RageUI.Button("Table de cocaine", "Cocaine", {}, true, {
                    onSelected = function() 
                        local x, y, z = 706.63, -690.43, 31.75
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à table de cocaine.")
                    end
                })
                RageUI.Button("Table de Munitions", "Munitions", {}, true, {
                    onSelected = function() 
                        local x, y, z = 606.19, -3093.08, 6.07
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à table de munitions.")
                    end
                })
            end)

            RageUI.IsVisible(posMenu, function()

                RageUI.Button("Supérette", nil, {}, true, {}, superetteMenu)
                RageUI.Button("Ammunation", nil, {}, true, {}, amunationMenu)
                RageUI.Button("Autres", nil, {}, true, {}, shopMenu)
                RageUI.Button("Pompe a Essence", nil, {}, true, {}, fuelMenu)
                RageUI.Button("Banque", nil, {}, true, {}, bankMenu)
                RageUI.Button("Coiffeur", nil, {}, true, {}, barberMenu)
                RageUI.Button("Magasin Vêtements", nil, {}, true, {}, clothesMenu)
                RageUI.Button("Salon de Tatouage", nil, {}, true, {}, tattooMenu)

            
            end)
            
            

            RageUI.IsVisible(superetteMenu, function()

                RageUI.Button("LTD 1", "Téléporte dans LTD 1", {}, true, {
                    onSelected = function() 
                        local x, y, z = -1821.08, 786.70, 138.03
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 1.")
                    end
                })
            
                RageUI.Button("LTD 2", "Téléporte dans LTD 2", {}, true, {
                    onSelected = function() 
                        local x, y, z = -2976.81, 389.67, 15.02
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 2.")
                    end
                })

                RageUI.Button("LTD 3", "Téléporte dans LTD 3", {}, true, {
                    onSelected = function() 
                        local x, y, z = 1697.30, 4930.26, 42.08
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 3.")
                    end
                })

                RageUI.Button("LTD 4", "Téléporte dans LTD 4", {}, true, {
                    onSelected = function() 
                        local x, y, z = -1494.35, -383.19, 40.12
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 4.")
                    end
                })

                RageUI.Button("LTD 5", "Téléporte dans LTD 5", {}, true, {
                    onSelected = function() 
                        local x, y, z = -1228.69, -900.32, 12.26
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 5.")
                    end
                })

                RageUI.Button("LTD 6", "Téléporte dans LTD 6", {}, true, {
                    onSelected = function()
                        local x, y, z = 544.22, 2676.00, 42.13
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 6.")
                    end
                })
                
                RageUI.Button("LTD 7", "Téléporte dans LTD 7", {}, true, {
                    onSelected = function() 
                        local x, y, z = -3037.25, 590.26, 7.81 
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 7.")
                    end
                })

                RageUI.Button("LTD 8", "Téléporte dans LTD 8", {}, true, {
                    onSelected = function() 
                        local x, y, z = 1396.99, 3597.55, 34.97
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 8.")
                    end
                })

                RageUI.Button("LTD 9", "Téléporte dans LTD 9", {}, true, {
                    onSelected = function() 
                        local x, y, z = 2685.33, 3281.19, 55.24
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 9.")
                    end
                })

                RageUI.Button("LTD 10", "Téléporte dans LTD 10", {}, true, {
                    onSelected = function() 
                        local x, y, z = 1142.87, -980.40, 46.21
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 10.")
                    end
                })

                RageUI.Button("LTD 11", "Téléporte dans LTD 11", {}, true, {
                    onSelected = function() 
                        local x, y, z = 2561.37, 385.10, 108.62
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 11.")
                    end
                })

                RageUI.Button("LTD 12", "Téléporte dans LTD 12", {}, true, {
                    onSelected = function() 
                        local x, y, z = -50.93, -1766.74, 28.97
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 12.")
                    end
                })

                RageUI.Button("LTD 13", "Téléporte dans LTD 13", {}, true, {
                    onSelected = function() 
                        local x, y, z = 28.78, -1350.49, 29.33
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 13.")
                    end
                })

                RageUI.Button("LTD 14", "Téléporte dans LTD 14", {}, true, {
                    onSelected = function() 
                        local x, y, z = 1965.88, 3739.19, 32.32
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 14.")
                    end
                })

                RageUI.Button("LTD 15", "Téléporte dans LTD 15", {}, true, {
                    onSelected = function() 
                        local x, y, z = 1164.73, -327.88, 69.06
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 15.")
                    end
                })

                RageUI.Button("LTD 16", "Téléporte dans LTD 16", {}, true, {
                    onSelected = function() 
                        local x, y, z = -3237.84, 1004.73, 12.45
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 16.")
                    end
                })

                RageUI.Button("LTD 17", "Téléporte dans LTD 17", {}, true, {
                    onSelected = function() 
                        local x, y, z = 4468.29, -4466.63, 4.66
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 17.")
                    end
                })

                RageUI.Button("LTD 18", "Téléporte dans LTD 18", {}, true, {
                    onSelected = function() 
                        local x, y, z = 1167.84, 2701.59, 38.18
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 18.")
                    end
                })

                RageUI.Button("LTD 19", "Téléporte dans LTD 19", {}, true, {
                    onSelected = function() 
                        local x, y, z = 1727.67, 6410.97, 35.00
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 19.")
                    end
                })

                RageUI.Button("LTD 20", "Téléporte dans LTD 20", {}, true, {
                    onSelected = function() 
                        local x, y, z = 371.53, 321.69, 103.52
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à LTD 20.")
                    end
                })
            end)
            

            RageUI.IsVisible(amunationMenu, function()

                RageUI.Button("Ammunation 1", "Téléporte dans Ammunation 1", {}, true, {
                    onSelected = function()
                        local x, y, z = 813.06, -2146.15, 29.39
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Ammunation 1.")
                    end
                })
            
                RageUI.Button("Ammunation 2", "Téléporte dans Ammunation 2", {}, true, {
                    onSelected = function()
                        local x, y, z = -1110.36, 2687.99, 18.61
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Ammunation 2.")
                    end
                })
            
                RageUI.Button("Ammunation 3", "Téléporte dans Ammunation 3", {}, true, {
                    onSelected = function()
                        local x, y, z = -661.60, -948.02, 21.59
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Ammunation 3.")
                    end
                })
            
                RageUI.Button("Ammunation 4", "Téléporte dans Ammunation 4", {}, true, {
                    onSelected = function()
                        local x, y, z = 1702.47, 3752.70, 34.35
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Ammunation 4.")
                    end
                })
            
                RageUI.Button("Ammunation 5", "Téléporte dans Ammunation 5", {}, true, {
                    onSelected = function()
                        local x, y, z = 843.74, -1022.10, 27.64
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Ammunation 5.")
                    end
                })
            
                RageUI.Button("Ammunation 6", "Téléporte dans Ammunation 6", {}, true, {
                    onSelected = function()
                        local x, y, z = -321.54, 6072.56, 31.29
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Ammunation 6.")
                    end
                })
            
                RageUI.Button("Ammunation 7", "Téléporte dans Ammunation 7", {}, true, {
                    onSelected = function()
                        local x, y, z = 2568.51, 306.14, 108.61
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Ammunation 7.")
                    end
                })
            
                RageUI.Button("Ammunation 8", "Téléporte dans Ammunation 8", {}, true, {
                    onSelected = function()
                        local x, y, z = 16.70, -1116.30, 29.79
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Ammunation 8.")
                    end
                })
            
            end)
            
            RageUI.IsVisible(shopMenu, function()

                RageUI.Button("Electronique", "Téléporte dans Digital Den", {}, true, {
                    onSelected = function() 
                        local x, y, z = 393.24, -832.35, 29.29
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Electronique.") 
                    end
                })

                RageUI.Button("Carte d'identité", "Téléporte dans Gouvernement", {}, true, {
                    onSelected = function() 
                        local x, y, z = -555.41, -603.84, 34.68
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Gouvernement.") 
                    end
                })

                RageUI.Button("Pharmacie", "Téléporte dans Pharmacie", {}, true, {
                    onSelected = function() 
                        local x, y, z = 1148.30, -1552.79, 35.38
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Pharmacie.") 
                    end
                })

                RageUI.Button("Armurerie SASP", "Téléporte dans Armurerie SASP", {}, true, {
                    onSelected = function() 
                        local x, y, z = -1027.33, -838.69, 0.68
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Armurerie SASP.") 
                    end
                })

            end)

            RageUI.IsVisible(fuelMenu, function()

                RageUI.Button("Essence 1", "Téléporte dans Essence 1", {}, true, {
                    onSelected = function()
                        local x, y, z = 54.58, 2771.52, 57.88
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 1.")
                    end
                })
            
                RageUI.Button("Essence 2", "Téléporte dans Essence 2", {}, true, {
                    onSelected = function()
                        local x, y, z = 264.01, 2604.43, 44.87
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 2.")
                    end
                })
            
                RageUI.Button("Essence 3", "Téléporte dans Essence 3", {}, true, {
                    onSelected = function()
                        local x, y, z = 1048.28, 2673.80, 39.55
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 3.")
                    end
                })
            
                RageUI.Button("Essence 4", "Téléporte dans Essence 4", {}, true, {
                    onSelected = function()
                        local x, y, z = 1203.17, 2663.86, 37.81
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 4.")
                    end
                })
            
                RageUI.Button("Essence 5", "Téléporte dans Essence 5", {}, true, {
                    onSelected = function()
                        local x, y, z = 2534.75, 2594.57, 37.94
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 5.")
                    end
                })
            
                RageUI.Button("Essence 6", "Téléporte dans Essence 6", {}, true, {
                    onSelected = function()
                        local x, y, z = 2684.63, 3271.00, 55.24
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 6.")
                    end
                })
            
                RageUI.Button("Essence 7", "Téléporte dans Essence 7", {}, true, {
                    onSelected = function()
                        local x, y, z = 2014.83, 3777.71, 32.18
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 7.")
                    end
                })
            
                RageUI.Button("Essence 8", "Téléporte dans Essence 8", {}, true, {
                    onSelected = function()
                        local x, y, z = 1691.43, 4937.31, 42.09
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 8.")
                    end
                })
            
                RageUI.Button("Essence 9", "Téléporte dans Essence 9", {}, true, {
                    onSelected = function()
                        local x, y, z = 1709.05, 6411.41, 33.01
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 9.")
                    end
                })
            
                RageUI.Button("Essence 10", "Téléporte dans Essence 10", {}, true, {
                    onSelected = function()
                        local x, y, z = 180.97, 6592.13, 31.86
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 10.")
                    end
                })
            
                RageUI.Button("Essence 11", "Téléporte dans Essence 11", {}, true, {
                    onSelected = function()
                        local x, y, z = -97.55, 6421.86, 31.45
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 11.")
                    end
                })
            
                RageUI.Button("Essence 12", "Téléporte dans Essence 12", {}, true, {
                    onSelected = function()
                        local x, y, z = -2567.86, 2325.25, 33.02
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 12.")
                    end
                })
            
                RageUI.Button("Essence 13", "Téléporte dans Essence 13", {}, true, {
                    onSelected = function()
                        local x, y, z = -1810.01, 807.42, 138.51
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 13.")
                    end
                })
            
                RageUI.Button("Essence 14", "Téléporte dans Essence 14", {}, true, {
                    onSelected = function()
                        local x, y, z = -1423.12, -286.92, 46.25
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 14.")
                    end
                })
            
                RageUI.Button("Essence 15", "Téléporte dans Essence 15", {}, true, {
                    onSelected = function()
                        local x, y, z = -2098.18, -331.36, 13.02
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 15.")
                    end
                })
            
                RageUI.Button("Essence 16", "Téléporte dans Essence 16", {}, true, {
                    onSelected = function()
                        local x, y, z = -710.07, -938.75, 19.02
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 16.")
                    end
                })
            
                RageUI.Button("Essence 17", "Téléporte dans Essence 17", {}, true, {
                    onSelected = function()
                        local x, y, z = -520.45, -1202.10, 18.52
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 17.")
                    end
                })
            
                RageUI.Button("Essence 18", "Téléporte dans Essence 18", {}, true, {
                    onSelected = function()
                        local x, y, z = -67.20, -1753.38, 29.01
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 18.")
                    end
                })
            
                RageUI.Button("Essence 19", "Téléporte dans Essence 19", {}, true, {
                    onSelected = function()
                        local x, y, z = 263.52, -1274.64, 29.15
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 19.")
                    end
                })
            
                RageUI.Button("Essence 20", "Téléporte dans Essence 20", {}, true, {
                    onSelected = function()
                        local x, y, z = 822.31, -1020.98, 26.21
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 20.")
                    end
                })
            
                RageUI.Button("Essence 21", "Téléporte dans Essence 21", {}, true, {
                    onSelected = function()
                        local x, y, z = 1200.13, -1410.23, 35.23
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 21.")
                    end
                })
            
                RageUI.Button("Essence 22", "Téléporte dans Essence 22", {}, true, {
                    onSelected = function()
                        local x, y, z = 1188.03, -332.12, 69.17
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 22.")
                    end
                })
            
                RageUI.Button("Essence 23", "Téléporte dans Essence 23", {}, true, {
                    onSelected = function()
                        local x, y, z = 623.67, 279.44, 103.09
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 23.")
                    end
                })
            
                RageUI.Button("Essence 24", "Téléporte dans Essence 24", {}, true, {
                    onSelected = function()
                        local x, y, z = 2581.57, 377.04, 108.45
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 24.")
                    end
                })
            
                RageUI.Button("Essence 25", "Téléporte dans Essence 25", {}, true, {
                    onSelected = function()
                        local x, y, z = 160.63, -1569.09, 29.27
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 25.")
                    end
                })
            
                RageUI.Button("Essence 26", "Téléporte dans Essence 26", {}, true, {
                    onSelected = function()
                        local x, y, z = 160.63, -1569.09, 29.27
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 26.")
                    end
                })
            
                RageUI.Button("Essence 27", "Téléporte dans Essence 27", {}, true, {
                    onSelected = function()
                        local x, y, z = -312.20, -1483.20, 30.52
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 27.")
                    end
                })
            
                RageUI.Button("Essence 28", "Téléporte dans Essence 28", {}, true, {
                    onSelected = function()
                        local x, y, z = 1780.30, 3329.11, 41.25
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Essence 28.")
                    end
                })
            
            end)
            

            RageUI.IsVisible(bankMenu, function()

                RageUI.Button("Banque Centrale", "Téléporte dans Banque Centrale", {}, true, {
                    onSelected = function()
                        local x, y, z = 229.06, 214.38, 105.55
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Banque Centrale.")
                    end
                })

                RageUI.Button("Banque 1", "Téléporte dans Banque 1", {}, true, {
                    onSelected = function()
                        local x, y, z = 316.56, -273.21, 53.92
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Banque 1.")
                    end
                })
            
                RageUI.Button("Banque 2", "Téléporte dans Banque 2", {}, true, {
                    onSelected = function()
                        local x, y, z = 152.63, -1035.11, 29.34
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Banque 2.")
                    end
                })
            
                RageUI.Button("Banque 3", "Téléporte dans Banque 3", {}, true, {
                    onSelected = function()
                        local x, y, z = -349.05, -44.59, 49.04
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Banque 3.")
                    end
                })
            
                RageUI.Button("Banque 4", "Téléporte dans Banque 4", {}, true, {
                    onSelected = function()
                        local x, y, z = -1216.01, -322.53, 37.69
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Banque 4.")
                    end
                })
            
                RageUI.Button("Banque 5", "Téléporte dans Banque 5", {}, true, {
                    onSelected = function()
                        local x, y, z = -2969.92, 480.62, 15.46
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Banque 5.")
                    end
                })
            
                RageUI.Button("Banque 6", "Téléporte dans Banque 6", {}, true, {
                    onSelected = function()
                        local x, y, z = 1175.39, 2702.01, 38.17
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Banque 6.")
                    end
                })        
            end)
            
            RageUI.IsVisible(barberMenu, function()

                RageUI.Button("Barber 1", "Téléporte dans Barber 1", {}, true, {
                    onSelected = function()
                        local x, y, z = -825.73, -189.27, 37.61
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Barber 1.")
                    end
                })
            
                RageUI.Button("Barber 2", "Téléporte dans Barber 2", {}, true, {
                    onSelected = function()
                        local x, y, z = 131.31, -1713.58, 29.27
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Barber 2.")
                    end
                })
            
                RageUI.Button("Barber 3", "Téléporte dans Barber 3", {}, true, {
                    onSelected = function()
                        local x, y, z = -1290.27, -1116.93, 6.62
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Barber 3.")
                    end
                })
            
                RageUI.Button("Barber 4", "Téléporte dans Barber 4", {}, true, {
                    onSelected = function()
                        local x, y, z = 1935.13, 3721.32, 32.87
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Barber 4.")
                    end
                })
            
                RageUI.Button("Barber 5", "Téléporte dans Barber 5", {}, true, {
                    onSelected = function()
                        local x, y, z = 1202.39, -472.56, 66.18
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Barber 5.")
                    end
                })
            
                RageUI.Button("Barber 6", "Téléporte dans Barber 6", {}, true, {
                    onSelected = function()
                        local x, y, z = -30.08, -145.34, 57.03
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Barber 6.")
                    end
                })
            
                RageUI.Button("Barber 7", "Téléporte dans Barber 7", {}, true, {
                    onSelected = function()
                        local x, y, z = -283.02, 6234.80, 31.49
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Barber 7.")
                    end
                })
            end)
            
            RageUI.IsVisible(clothesMenu, function()

                RageUI.Button("Magasin Vêtements 1", "Téléporte dans Vêtements 1", {}, true, {
                    onSelected = function()
                        local x, y, z = 1682.35, 4819.58, 42.04
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 1.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 2", "Téléporte dans Vêtements 2", {}, true, {
                    onSelected = function()
                        local x, y, z = -718.44, -156.82, 36.99
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 2.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 3", "Téléporte dans Vêtements 3", {}, true, {
                    onSelected = function()
                        local x, y, z = -1207.29, -782.34, 17.12
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 3.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 4", "Téléporte dans Vêtements 4", {}, true, {
                    onSelected = function()
                        local x, y, z = 415.36, -805.74, 29.35
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 4.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 5", "Téléporte dans Vêtements 5", {}, true, {
                    onSelected = function()
                        local x, y, z = -153.04, -304.97, 38.82
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 5.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 6", "Téléporte dans Vêtements 6", {}, true, {
                    onSelected = function()
                        local x, y, z = 83.29, -1405.06, 29.86
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 6.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 7", "Téléporte dans Vêtements 7", {}, true, {
                    onSelected = function()
                        local x, y, z = -818.42, -1081.54, 11.13
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 7.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 8", "Téléporte dans Vêtements 8", {}, true, {
                    onSelected = function()
                        local x, y, z = -1460.72, -233.62, 49.50
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 8.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 9", "Téléporte dans Vêtements 9", {}, true, {
                    onSelected = function()
                        local x, y, z = -2.73, 6518.22, 31.49
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 9.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 10", "Téléporte dans Vêtements 10", {}, true, {
                    onSelected = function()
                        local x, y, z = 618.13, 2748.81, 42.09
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 10.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 11", "Téléporte dans Vêtements 11", {}, true, {
                    onSelected = function()
                        local x, y, z = 1197.87, 2701.25, 38.16
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 11.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 12", "Téléporte dans Vêtements 12", {}, true, {
                    onSelected = function()
                        local x, y, z = -3167.48, 1058.10, 20.85
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 12.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 13", "Téléporte dans Vêtements 13", {}, true, {
                    onSelected = function()
                        local x, y, z = -1094.02, 2704.15, 19.06
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 13.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 14", "Téléporte dans Vêtements 14", {}, true, {
                    onSelected = function()
                        local x, y, z = -1117.97, -1439.49, 5.11
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 14.")
                    end
                })
            
                RageUI.Button("Magasin Vêtements 15", "Téléporte dans Vêtements 15", {}, true, {
                    onSelected = function()
                        local x, y, z = 131.08, -206.43, 54.48
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Vêtements 15.")
                    end
                })
            
            end)

            RageUI.IsVisible(tattooMenu, function()

                RageUI.Button("Salon de tatouage 1", "Téléporte dans Salon de tatouage 1", {}, true, {
                    onSelected = function()
                        local x, y, z = 1320.27, -1648.59, 52.14
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Salon de tatouage 1.")
                    end
                })
            
                RageUI.Button("Salon de tatouage 2", "Téléporte dans Salon de tatouage 2", {}, true, {
                    onSelected = function()
                        local x, y, z = -1155.39, -1421.60, 4.79
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Salon de tatouage 2.")
                    end
                })
            
                RageUI.Button("Salon de tatouage 3", "Téléporte dans Salon de tatouage 3", {}, true, {
                    onSelected = function()
                        local x, y, z = 321.44, 177.03, 103.57
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Salon de tatouage 3.")
                    end
                })
            
                RageUI.Button("Salon de tatouage 4", "Téléporte dans Salon de tatouage 4", {}, true, {
                    onSelected = function()
                        local x, y, z = -3166.16, 1073.86, 20.84
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Salon de tatouage 4.")
                    end
                })
            
                RageUI.Button("Salon de tatouage 5", "Téléporte dans Salon de tatouage 5", {}, true, {
                    onSelected = function()
                        local x, y, z = 1859.66, 3745.63, 33.06
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Salon de tatouage 5.")
                    end
                })
            
                RageUI.Button("Salon de tatouage 6", "Téléporte dans Salon de tatouage 6", {}, true, {
                    onSelected = function()
                        local x, y, z = -290.66, 6203.60, 31.46
                        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
                        ESX.ShowNotification("~g~Téléporté à Salon de tatouage 6.")
                    end
                })
            
            end)
            
            

            RageUI.IsVisible(devMenu, function()

                RageUI.Button("Obtenir Coordonnées", nil, {}, true, {
                    onSelected = function()
                        local coords = GetEntityCoords(PlayerPedId())
                        local text = ("vector3(%.2f, %.2f, %.2f)"):format(coords.x, coords.y, coords.z)
                        lib.setClipboard(text)
                        print("^2[Coordonnées]^0 " .. text)
                        ESX.ShowNotification("Coordonnées copiées : ~b~" .. text)
                    end
                })
            
                RageUI.Button("Obtenir Heading", nil, {}, true, {
                    onSelected = function()
                        local heading = GetEntityHeading(PlayerPedId())
                        local text = ("Heading: %.2f"):format(heading)
                        lib.setClipboard(text)
                        print("^2[Heading]^0 " .. text)
                        ESX.ShowNotification("Heading copié : ~b~" .. text)
                    end
                })
            
                RageUI.Button("Spawn Objet", nil, {}, true, {
                    onSelected = function()
                        local objectName = exports["ava"]:ShowInput("Nom de l'objet à spawn", false, 50, "small_text", "", false, "center")
                        if objectName and objectName ~= "" then
                            local model = GetHashKey(objectName)
                            RequestModel(model)
                            while not HasModelLoaded(model) do Wait(500) end
            
                            local coords = GetEntityCoords(PlayerPedId())
                            local object = CreateObject(model, coords.x, coords.y, coords.z + 1.0, true, true, true)
                            SetEntityAsMissionEntity(object, true, true)
                            PlaceObjectOnGroundProperly(object)
            
                            exports.object_gizmo:useGizmo(object)
                            ESX.ShowNotification("~g~Objet spawné et gizmo activé : " .. objectName)
                        else
                            ESX.ShowNotification("~r~Nom de l'objet invalide.")
                        end
                    end
                })
            
                RageUI.Button("Supprimer Objet", nil, {}, true, {
                    onSelected = function()
                        local playerCoords = GetEntityCoords(PlayerPedId())
                        local object = GetClosestObject(playerCoords, 5.0)
                        if object and DoesEntityExist(object) then
                            DeleteEntity(object)
                            ESX.ShowNotification("~r~Objet supprimé.")
                        else
                            ESX.ShowNotification("~y~Aucun objet trouvé.")
                        end
                    end
                })
            
                RageUI.Button("Supprimer PNJ civils à pied", nil, {}, true, {
                    onSelected = function()
                        local count = 0
                        for ped in EnumeratePeds() do
                            if not IsPedAPlayer(ped) then
                                DeleteEntity(ped)
                                count += 1
                            end
                        end
                        ESX.ShowNotification("~r~" .. count .. " PNJ supprimés.")
                    end
                })
            
                RageUI.Button("Supprimer véhicules civils & PNJ", nil, {}, true, {
                    onSelected = function()
                        local count = 0
                        for vehicle in EnumerateVehicles() do
                            local driver = GetPedInVehicleSeat(vehicle, -1)
                            if DoesEntityExist(driver) and not IsPedAPlayer(driver) then
                                for i = -1, GetVehicleMaxNumberOfPassengers(vehicle) do
                                    local ped = GetPedInVehicleSeat(vehicle, i)
                                    if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
                                        DeleteEntity(ped)
                                    end
                                end
                                DeleteEntity(vehicle)
                                count += 1
                            end
                        end
                        ESX.ShowNotification("~o~" .. count .. " véhicules supprimés.")
                    end
                })

                RageUI.Separator("~b~Météo")

                local weathers = {
                    { label = "Ensoleillé", value = "EXTRASUNNY" },
                    { label = "Dégagé", value = "CLEAR" },
                    { label = "Nuageux", value = "CLOUDS" },
                    { label = "Pluie", value = "RAIN" },
                    { label = "Orage", value = "THUNDER" },
                    { label = "Brouillard", value = "FOGGY" }
                }

                for _, w in ipairs(weathers) do
                    RageUI.Button(w.label, nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent("CoreUI:syncWeather", w.value)
                            ESX.ShowNotification("~b~Météo changée pour tout le monde : ~s~" .. w.value)
                        end
                    })
                end


                RageUI.Separator("~b~Heure")

                local heures = {
                    { label = "Minuit (0h)", hour = 0 },
                    { label = "Matin (6h)", hour = 6 },
                    { label = "Midi (12h)", hour = 12 },
                    { label = "Soir (18h)", hour = 18 },
                    { label = "Nuit (22h)", hour = 22 }
                }

                for _, h in ipairs(heures) do
                    RageUI.Button(h.label, nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent("CoreUI:syncTime", h.hour, 0)
                            ESX.ShowNotification("~b~Heure réglée pour tous à : ~s~" .. h.hour .. ":00")
                        end
                    })
                end
            end)
    
            if not RageUI.Visible(main)
            and not RageUI.Visible(players)
            and not RageUI.Visible(perso)
            and not RageUI.Visible(adminActions)
            and not RageUI.Visible(vehicleMenu)
            and not RageUI.Visible(illegalMenu)
            and not RageUI.Visible(craftMenu)
            and not RageUI.Visible(posMenu)
            and not RageUI.Visible(superetteMenu)
            and not RageUI.Visible(amunationMenu)
            and not RageUI.Visible(shopMenu)
            and not RageUI.Visible(fuelMenu)
            and not RageUI.Visible(bankMenu)
            and not RageUI.Visible(barberMenu)
            and not RageUI.Visible(clothesMenu)
            and not RageUI.Visible(tattooMenu)
            and not RageUI.Visible(devMenu) then
                open = false
            end
        end
    end)
end)  
    

function IsPlayerAuthorizedForNoClip(cb)
    ESX.TriggerServerCallback('CoreUI:getGroup', function(group)
        cb(allowedGroups[group] == true)
    end)
end



function OpenPlayerActions(serverId, playerName)
    local playerMenu = RageUI.CreateMenu("Admin - " .. playerName, "Actions sur " .. playerName)
    RageUI.Visible(playerMenu, true)

    CreateThread(function()
        while playerMenu do
            Wait(1)
            RageUI.IsVisible(playerMenu, function()

                RageUI.Button("TP à ce joueur", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:tpToPlayer", serverId)
                    end
                })

                RageUI.Button("TP le joueur à moi", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:tpPlayerToMe", serverId)
                    end
                })

                RageUI.Button("Freeze / Unfreeze", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:toggleFreeze", serverId)
                    end
                })

                RageUI.Button("Heal", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:healPlayer", serverId)
                    end
                })

                RageUI.Button("Revive", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:reviveCustom", serverId)
                    end
                })

                RageUI.Button("Kick", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:kickPlayer", serverId, "Vous avez été expulsé de FlashFa. L'admin vous avertit sur votre roleplay !")
                    end
                })

                RageUI.Button("Ban", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("CoreUI:banPlayer", serverId, "Vous avez été bannis de FlashFa ! En cas de problème ou erreur contactez nous sur notre discord.")
                    end
                })

                RageUI.Button("WIPE le joueur", "Tape 'CONFIRMER' pour valider", {}, true, {
                    onSelected = function()
                        local confirm = exports["ava"]:ShowInput("Tape 'CONFIRMER' pour WIPE", false, 15, "small_text", "", false, "center")
                        if confirm and confirm:upper() == "CONFIRMER" then
                            TriggerServerEvent("CoreUI:wipePlayer", serverId)
                            ESX.ShowNotification("~r~Le joueur a été WIPE.")
                        else
                            ESX.ShowNotification("~y~Action annulée.")
                        end
                    end
                })

                RageUI.Button("Envoyer un message", nil, {}, true, {
                    onSelected = function()
                        local msg = exports["ava"]:ShowInput("Message à envoyer à tous", false, 200, "small_text", "", false, "center")
                        if msg and msg ~= "" then
                            TriggerServerEvent("CoreUI:sendGlobalMessage", msg)
                        else
                            ESX.ShowNotification("~r~Message vide ou annulé.")
                        end
                    end
                })

                RageUI.Button("Set Job", nil, {}, true, {
                    onSelected = function()
                        local job = exports["ava"]:ShowInput("Nom du job", false, 50, "small_text", "", false, "center")
                        Wait(250)
                        local grade = exports["ava"]:ShowInput("Grade (0-9)", false, 2, "number", "", false, "center")
                        if job and job ~= "" and grade and tonumber(grade) then
                            TriggerServerEvent("CoreUI:setJob", serverId, job, tonumber(grade))
                            ESX.ShowNotification(("~g~Job défini : %s [%s]"):format(job, grade))
                        else
                            ESX.ShowNotification("~r~Job ou grade invalide.")
                        end
                    end
                })

                RageUI.Button("Give Item", nil, {}, true, {
                    onSelected = function()
                        local item = exports["ava"]:ShowInput("Nom de l'item", false, 50, "small_text", "", false, "center")
                        Wait(250)
                        local amount = exports["ava"]:ShowInput("Quantité", false, 3, "number", "", false, "center")
                        if item and item ~= "" and amount and tonumber(amount) then
                            TriggerServerEvent("CoreUI:giveItem", serverId, item, tonumber(amount))
                            ESX.ShowNotification(("~g~Item donné : %s x%s"):format(item, amount))
                        else
                            ESX.ShowNotification("~r~Nom ou quantité invalide.")
                        end
                    end
                })

                RageUI.Button("Give Argent (cash)", nil, {}, true, {
                    onSelected = function()
                        local amount = exports["ava"]:ShowInput("Montant à donner", false, 6, "number", "", false, "center")
                        if amount and tonumber(amount) then
                            TriggerServerEvent("CoreUI:giveMoney", serverId, "money", tonumber(amount))
                            ESX.ShowNotification(("~g~Argent donné : $%s"):format(amount))
                        else
                            ESX.ShowNotification("~r~Montant invalide.")
                        end
                    end
                })
            end)

            if not RageUI.Visible(playerMenu) then
                playerMenu = RMenu:DeleteType("playerMenu", true)
                break
            end
        end
    end)
end


    local noclip = false
    local noclipSpeedIndex = 2
    local noclipSpeeds = {0.3, 0.9, 1.5, 4.5, 8.0, 10.0, 15.0, 20.0, 25.0}
    local moveMode = "ped"

    function GetNoClipEntity()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        return veh ~= 0 and veh or ped
    end

    function ToggleNoClip()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        local entity = (veh ~= 0) and veh or ped
        noclip = not noclip

        TriggerServerEvent("CoreUI:noclipSyncVisibility", noclip)

        if noclip then
            if veh == 0 then
                ClearPedTasksImmediately(ped)
            end

            FreezeEntityPosition(entity, true)
            SetLocalPlayerInvisibleLocally(false)
            SetEntityVisible(entity, true, false)
            SetEntityAlpha(entity, 150, false)
            NetworkSetEntityInvisibleToNetwork(entity, true)
            SetEntityCollision(entity, false, false)
            SetEntityInvincible(entity, true)
        else
            FreezeEntityPosition(entity, false)

            if veh == 0 then
                local pos = GetEntityCoords(entity)
                local found, groundZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z, 0)
                if found then
                    SetEntityCoords(entity, pos.x, pos.y, groundZ + 1.0, false, false, false, false)
                    SetEntityVelocity(entity, 0.0, 0.0, 0.0)
                end
                ClearPedTasksImmediately(ped)
            else
                local vehCoords = GetEntityCoords(veh)
                local success, groundZ = GetGroundZFor_3dCoord(vehCoords.x, vehCoords.y, vehCoords.z + 100.0, 0)

                if success then
                    SetEntityCoords(veh, vehCoords.x, vehCoords.y, groundZ + 1.0, false, false, false, false)
                    Wait(100)
                    SetVehicleOnGroundProperly(veh)
                else
                    SetVehicleOnGroundProperly(veh)
                end

                Wait(50)
                if GetPedInVehicleSeat(veh, -1) ~= ped then
                    TaskWarpPedIntoVehicle(ped, veh, -1)
                end
            end

            NetworkSetEntityInvisibleToNetwork(entity, false)
            SetLocalPlayerInvisibleLocally(false)
            ResetEntityAlpha(entity)
            SetEntityCollision(entity, true, true)
            SetEntityInvincible(entity, false)
        end
    end

    function CycleSpeed()
        noclipSpeedIndex = noclipSpeedIndex + 1
        if noclipSpeedIndex > #noclipSpeeds then noclipSpeedIndex = 1 end
    --    ESX.ShowNotification(("~b~Vitesse NoClip : x%.2f"):format(noclipSpeeds[noclipSpeedIndex]))
    end

    function ToggleMoveMode()
        moveMode = (moveMode == "camera") and "ped" or "camera"
        ESX.ShowNotification("~y~Mode de déplacement : " .. (moveMode == "camera" and "Caméra" or "Ped"))
    end

    function ButtonMessage(text)
        BeginTextCommandScaleformString("STRING")
        AddTextComponentScaleform(text)
        EndTextCommandScaleformString()
    end

    function Button(ControlButton)
        N_0xe83a3e3557a56640(ControlButton)
    end

    function CreateInstructionalScaleform()
        local scaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
        while not HasScaleformMovieLoaded(scaleform) do Wait(0) end

        PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
        PushScaleformMovieFunctionParameterInt(200)
        PopScaleformMovieFunctionVoid()

        local slot = 0
        local function Add(control, label)
            PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(slot)
            Button(GetControlInstructionalButton(2, control, true))
            ButtonMessage(label)
            PopScaleformMovieFunctionVoid()
            slot = slot + 1
        end

        Add(170, "Désactiver NoClip") -- F3
        Add(21, "Vitesse (x" .. string.format("%.1f", noclipSpeeds[noclipSpeedIndex]) .. ")") -- SHIFT
        Add(182, "Mode (" .. (moveMode == "camera" and "Caméra" or "Ped") .. ")") -- L
        Add(32, "Avancer") -- W
        Add(33, "Reculer") -- S
        Add(44, "Monter") -- Q
        Add(20, "Descendre") -- Z

        PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(160)
        PopScaleformMovieFunctionVoid()

        return scaleform
    end

    function RotToDirection(rot)
        local radZ = math.rad(rot.z)
        local radX = math.rad(rot.x)
        local num = math.abs(math.cos(radX))

        return vector3(
            -math.sin(radZ) * num,
            math.cos(radZ) * num,
            math.sin(radX)
        )
    end

    CreateThread(function()
        while true do
            Wait(0)

            if noclip and IsControlJustPressed(0, 21) then CycleSpeed() end -- SHIFT
            if noclip and IsControlJustPressed(0, 182) then ToggleMoveMode() end -- L

            if noclip then
                local entity = GetNoClipEntity()
                local coords = GetEntityCoords(entity)
                local speed = noclipSpeeds[noclipSpeedIndex]
                local dir = moveMode == "camera" and RotToDirection(GetGameplayCamRot(2)) or GetEntityForwardVector(entity)
                local up = vector3(0.0, 0.0, 1.0)

                if IsControlPressed(0, 32) then coords += (dir * speed) end -- W
                if IsControlPressed(0, 33) then coords -= (dir * speed) end -- S
                if IsControlPressed(0, 44) then coords += (up * speed) end -- Q
                if IsControlPressed(0, 20) then coords -= (up * speed) end -- Z

                SetEntityCoordsNoOffset(entity, coords.x, coords.y, coords.z, true, true, true)

                local camRot = GetGameplayCamRot(2)
                SetEntityHeading(entity, camRot.z)

                local scaleform = CreateInstructionalScaleform()
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            end        
        end
    end)



    RegisterNUICallback("closeScreenshot", function(_, cb)
        SetNuiFocus(false, false)
        cb({})
    end)

    RegisterNetEvent("CoreUI:showScreenshot")
    AddEventHandler("CoreUI:showScreenshot", function(url)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showScreenshot",
            url = url
        })
    end)


    RegisterCommand("testcoords", function()
        CopyCoordinates()
    end, false)

    RegisterCommand("testheading", function()
        CopyHeading()
    end, false)


    for vehicle in EnumerateVehicles() do
    end

    for ped in EnumeratePeds() do
    end

    CreateThread(function()
        while true do
            Wait(0)
            if displayCoords then
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local heading = GetEntityHeading(ped)
                DrawTextOnScreen(coords, heading)
            end
        end
    end)

function GetClosestObject(coords, radius)
    local handle, object = FindFirstObject()
    local success
    local closestObject = nil
    local closestDistance = radius + 0.01

    repeat
        local objCoords = GetEntityCoords(object)
        local dist = #(coords - objCoords)

        if dist < closestDistance and not IsEntityAnObject(PlayerPedId()) then
            closestObject = object
            closestDistance = dist
        end

        success, object = FindNextObject(handle)
    until not success

    EndFindObject(handle)
    return closestObject
end

    CreateThread(function()
        while true do
            Wait(2000) 

            if disablePnjSpawn then
                for ped in EnumeratePeds() do
                    if not IsPedAPlayer(ped) then
                        DeleteEntity(ped)
                    end
                end
            end

            if disableVehSpawn then
                for vehicle in EnumerateVehicles() do
                    local driver = GetPedInVehicleSeat(vehicle, -1)
                    if DoesEntityExist(driver) and not IsPedAPlayer(driver) then
                        DeleteEntity(vehicle)
                    end
                end
            end
        end
    end)

    local invisiblePlayers = {}

    RegisterNetEvent("CoreUI:applyNoClipInvisibility")
    AddEventHandler("CoreUI:applyNoClipInvisibility", function(targetId, isInvisible)
        local myId = GetPlayerServerId(PlayerId())
        local target = GetPlayerFromServerId(targetId)
        if target == -1 then return end

        local ped = GetPlayerPed(target)
        local veh = GetVehiclePedIsIn(ped, false)

        if isInvisible then
            if myId ~= targetId then
                if DoesEntityExist(ped) then
                    SetEntityVisible(ped, false, false)
                    SetEntityAlpha(ped, 0, false)
                end
                if veh and DoesEntityExist(veh) then
                    SetEntityVisible(veh, false, false)
                    SetEntityAlpha(veh, 0, false)
                end
            end
        else
            if DoesEntityExist(ped) then
                SetEntityVisible(ped, true, false)
                ResetEntityAlpha(ped)
            end
            if veh and DoesEntityExist(veh) then
                SetEntityVisible(veh, true, false)
                ResetEntityAlpha(veh)
            end
        end
    end)

    RegisterNetEvent("CoreUI:applyWeather")
    AddEventHandler("CoreUI:applyWeather", function(weatherType)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypeNow(weatherType)
        SetWeatherTypeNowPersist(weatherType)
        SetWeatherTypePersist(weatherType)
    end)

    RegisterNetEvent("CoreUI:applyTime")
    AddEventHandler("CoreUI:applyTime", function(hour, minute)
        NetworkOverrideClockTime(hour, minute or 0, 0)
    end)

    CreateThread(function()
        while true do
            Wait(500)
            for player, _ in pairs(invisiblePlayers) do
                if player ~= PlayerId() then
                    local ped = GetPlayerPed(player)
                    local veh = GetVehiclePedIsIn(ped, false)

                    if DoesEntityExist(ped) then
                        SetEntityVisible(ped, false, false)
                    end

                    if veh and veh ~= 0 then
                        SetEntityVisible(veh, false, false)
                    end
                end
            end
        end
    end)

    RegisterNetEvent("esx:teleport", function(coords)
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
    end)



    RegisterNetEvent("CoreUI:tpHereClient")
    AddEventHandler("CoreUI:tpHereClient", function(sourceId)
        local sourcePlayer = GetPlayerFromServerId(sourceId)
        if sourcePlayer ~= -1 then
            local sourcePed = GetPlayerPed(sourcePlayer)
            local sourceCoords = GetEntityCoords(sourcePed)
            SetEntityCoords(PlayerPedId(), sourceCoords.x, sourceCoords.y, sourceCoords.z, false, false, false, false)
        else
            ESX.ShowNotification("~r~L'administrateur est introuvable.")
        end
    end)

