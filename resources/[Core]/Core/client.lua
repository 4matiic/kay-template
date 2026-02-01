local ESX = exports['framework']:getSharedObject()
local isMenuOpen = false

local mainMenu = RageUI.CreateMenu("BASE KOY", "INTÉRACTIONS")
local infoMenu = RageUI.CreateSubMenu(mainMenu, "BASE KOY", "INFORMATION PERSONNAGE")
local vipMenu = RageUI.CreateSubMenu(mainMenu, "BASE KOY", "Options VIP")
local staffMenu = RageUI.CreateSubMenu(mainMenu, "BASE KOY", "Options Staff")
local staffSubMenu = RageUI.CreateSubMenu(staffMenu, "BASE KOY", "Options internes")
local raccourciMenu = RageUI.CreateSubMenu(mainMenu, "BASE KOY", "TOUCHE DU SERVEUR")
local commandMenu = RageUI.CreateSubMenu(mainMenu, "BASE KOY", "COMMANDES DU SERVEUR")
local vehicleMenu = RageUI.CreateSubMenu(mainMenu, "BASE KOY", "INFORMATION VEHICULE")
local vipObjectsMenu = RageUI.CreateSubMenu(vipMenu, "BASE KOY", "Placez un objet")
local manageObjectsMenu = RageUI.CreateSubMenu(vipMenu, "BASE KOY", "Gérez vos objets")
local objectActionsMenu = RageUI.CreateSubMenu(manageObjectsMenu, "BASE KOY", "Choisissez une action")
local boutiqueMenu = RageUI.CreateSubMenu(boutiqueMenu, "BASE KOY", "BOUTIQUE")
local SettinsMenu = RageUI.CreateSubMenu(settinsmenu, "BASE KOY", "PREFERENCE")



local currentPreview = nil
local emotePreviewPed = nil
local lastPreviewAnim = nil
local lastHoveredEmote = nil
local hoveredIndex = nil

function string.split(inputstr, sep)
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

local selectedObject = nil
local playerInfo = {}
local currentDoor = 0
local limiter = 50
local limiterValues = {"Désactivé", 30, 50, 90, 120}
local engineOn = true
local placedProps = {}

local serverCommands = {
    { label = "Faire un appel à un membre du staff", cmd = "/report" },
    { label = "Effacer son chat (Annonces, report,...)" , cmd = "/clear" },
    { label = "Activer la vente de drogue", cmd = "/drogue" },
    { label = "Ouvrir/fermer l'interface radio", cmd = "/radio" },
    { label = "Afficher votre ID", cmd = "/id" },
    { label = "Pour faire une animation", cmd = "/e" }
}

local keybinds = {
    { label = "Ouvrir/fermer l'interface radio", key = "H" },
    { label = "Ouvrir le menu Animation", key = "F4" },
    { label = "Ouvrir le menu Personnel", key = "F5" },
    { label = "Ouvrir le menu Métier", key = "F6" },
    { label = "Ouvrir le menu Organisation", key = "F7" },
    { label = "Ouvrir le menu Boutique", key = "F1" },
    { label = "Changer l'intensité de la voix", key = "F11" },
    { label = "Montrer du doigt", key = "B" },
    { label = "S'allonger au sol", key = "J" },
    { label = "Ouvrir/fermer le Téléphone", key = "H" },
    { label = "Ouvrir/fermer l'inventaire", key = "TAB" }
}

local isVIP, isStaff = false, false

RegisterCommand("menu_f5", function()
    ESX.TriggerServerCallback('kay_f5:getPermissions', function(vip, staff)
        isVIP = vip
        isStaff = staff
        RageUI.Visible(mainMenu, true)
        isMenuOpen = true
    end)
end, false)


RegisterKeyMapping('menu_f5', 'Ouvrir le menu F1', 'keyboard', 'F5')

local vipProps = {
    {label = "Chaise", prop = "prop_chair_01a"},
    {label = "Table", prop = "prop_table_03"},
    {label = "Sac", prop = "prop_ld_suitcase_01"},
    {label = "Chaise Pliante", prop = "prop_chair_04a"},
}


local previewProp = nil
local previewModel = nil

function ShowPropPreview(model)
    if previewModel == model then return end
    ClearPreviewProp()

    local hash = GetHashKey(model)
    if not IsModelInCdimage(hash) or not IsModelValid(hash) then
        ESX.ShowNotification("~r~Ce prop est invalide.")
        previewModel = nil
        return
    end

    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed) + GetEntityForwardVector(playerPed) * 1.5

    previewProp = CreateObject(hash, coords.x, coords.y, coords.z, false, false, false)
    SetEntityHeading(previewProp, GetEntityHeading(playerPed))
    SetEntityAlpha(previewProp, 180, false)
    SetEntityCollision(previewProp, false, false)
    FreezeEntityPosition(previewProp, true)

    previewModel = model
end

function ClearPreviewProp()
    if previewProp and DoesEntityExist(previewProp) then
        DeleteEntity(previewProp)
    end
    previewProp = nil
    previewModel = nil
end

CreateThread(function()
    while true do
        Wait(1)
        if isMenuOpen then
            RageUI.IsVisible(mainMenu, function()
                RageUI.Button("Utilisateur & Personnages", nil, {}, true, {}, infoMenu)
                RageUI.Button("Touches", nil, {}, true, {}, raccourciMenu)
                RageUI.Button("Commandes", nil, {}, true, {}, commandMenu)
                RageUI.Button("Animations", nil, {}, true, {
                          onSelected = function()
                          ExecuteCommand("emote_menu")
                          RageUI.CloseAll()
                          end})
                RageUI.Button("Options & Paramètres", nil, {}, true, {}, SettinsMenu)
                RageUI.Button("Véhicule", nil, {}, true, {}, vehicleMenu)
                RageUI.Button("Boutique", nil, {}, true, {
                          onSelected = function()
                          ExecuteCommand("boutiqueMenu")
                          RageUI.CloseAll()
                          end})
                if isVIP then RageUI.Button("Menu VIP", nil, {}, true, {}, vipMenu) end
                if isStaff then
                    RageUI.Button("~r~Administration~s~", nil, {}, true, {
                        onSelected = function()
                            TriggerEvent('CoreUI:openMenu')
                        end
                    }, staffMenu)
                end
            end)

            local lastInfoUpdate = 0

            RageUI.IsVisible(infoMenu, function()
                if GetGameTimer() - lastInfoUpdate > 5000 then 
                    TriggerServerEvent('kay_f5:getPlayerInfo')
                    lastInfoUpdate = GetGameTimer()
                end
            
                for _, i in ipairs({
                    { label = "Métier :", value = playerInfo.job or "N/A" },
                    { label = "Métier secondaire :", value = playerInfo.secondjob or "Aucun" },
                    { label = "Espèce :", value = ("%s$"):format(playerInfo.cash or 0) },
                    { label = "Banque :", value = ("%s$"):format(playerInfo.bank or 0) },
                    { label = "Source Inconnue :", value = ("%s$"):format(exports.ox_inventory:Search('count', 'black_money') or 0) },
                    { label = "~y~Temps de jeu :", value = playerInfo.playtime or "N/A" }
                }) do
                    RageUI.Button(i.label, nil, { RightLabel = "~s~" .. i.value }, true, {})
                end
            end)
            
            

            RageUI.IsVisible(raccourciMenu, function()
                for _, bind in ipairs(keybinds) do
                    RageUI.Button(bind.label, nil, { RightLabel = "~b~" .. (bind.key or "?") }, true, {})
                end
            end)

            RageUI.IsVisible(commandMenu, function()
                for _, cmd in ipairs(serverCommands) do
                    RageUI.Button(cmd.label, nil, { RightLabel = "~b~" .. cmd.cmd }, true, {})
                end
            end)

            RageUI.IsVisible(vehicleMenu, function()
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle == 0 then
                    RageUI.Separator("~r~Vous n'êtes pas dans un véhicule")
                    return
                end
                RageUI.List("Ouverture/fermeture des portes", {
                    "Avant gauche", "Avant droite", "Arrière gauche", "Arrière droite"
                }, currentDoor + 1, nil, {}, true, {
                    onListChange = function(i) currentDoor = i - 1 end,
                    onSelected = function()
                        local open = GetVehicleDoorAngleRatio(vehicle, currentDoor) > 0.1
                        if open then
                            SetVehicleDoorShut(vehicle, currentDoor, false)
                        else
                            SetVehicleDoorOpen(vehicle, currentDoor, false, false)
                        end
                    end
                })
                RageUI.List("Limiteur de vitesse", limiterValues, table.find(limiterValues, limiter), tostring(limiter), {}, true, {
                    onListChange = function(i) limiter = limiterValues[i] end,
                    onSelected = function()
                        if type(limiter) == "number" then
                            SetEntityMaxSpeed(vehicle, limiter / 3.6)
                            ESX.ShowNotification("~g~Limitateur réglé à ~s~" .. limiter .. " KM/H")
                        else
                            SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel"))
                            ESX.ShowNotification("~r~Limitateur désactivé")
                        end
                    end
                })
                RageUI.Button("Allumer/arrêter le moteur", nil, {}, true, {
                    onSelected = function()
                        engineOn = not engineOn
                        SetVehicleEngineOn(vehicle, engineOn, false, true)
                    end
                })
                RageUI.Button("Informations du véhicule", nil, {}, true, {
                    onSelected = function()
                        local model = GetEntityModel(vehicle)
                        local name = GetDisplayNameFromVehicleModel(model)
                        local plate = GetVehicleNumberPlateText(vehicle)
                        local speed = math.floor(GetEntitySpeed(vehicle) * 3.6)
                        ESX.ShowNotification(("~b~Modèle :~s~ %s\n~b~Plaque :~s~ %s\n~b~Vitesse :~s~ %skm/h"):format(name, plate, speed))
                    end
                })
            end)

        RageUI.IsVisible(vipMenu, function()
            RageUI.Button("Activer l'auto-pilote", "Votre véhicule se rendra au point GPS.", {}, true, {
                onSelected = function()
                    StartAutoDrive()
                end
            })

            RageUI.Button("Stopper l'auto-pilote", "Arrête immédiatement la conduite automatique.", {}, true, {
                onSelected = function()
                    ClearPedTasks(PlayerPedId())
                    ESX.ShowNotification("~r~Auto-pilote désactivé manuellement.")
                end
            })

            RageUI.Button("Obtenir un item aléatoire", nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback("kay_f5:getRandomItem", function(success, msg)
                        ESX.ShowNotification(msg)
                    end)
                end
            })

            RageUI.Button("Objets", nil, {}, true, {}, vipObjectsMenu)

            if #placedProps > 0 then
                RageUI.Button("Gestion Objets Placés", nil, {}, true, {}, manageObjectsMenu)
            end
        end)


            RageUI.IsVisible(vipObjectsMenu, function()
                for _, item in ipairs(vipProps) do
                    RageUI.Button(item.label, nil, {}, true, {
                        onActive = function()
                            if previewModel ~= item.prop then
                                ShowPropPreview(item.prop)
                            end
                        end,
                        onSelected = function()
                            if not previewProp or not DoesEntityExist(previewProp) then
                                ESX.ShowNotification("~r~Aperçu du prop non chargé.")
                                return
                            end
            
                            local coords = GetEntityCoords(previewProp)
                            local heading = GetEntityHeading(previewProp)
            
                            local prop = CreateObject(GetHashKey(item.prop), coords.x, coords.y, coords.z, true, true, true)
                            SetEntityHeading(prop, heading)
                            PlaceObjectOnGroundProperly(prop)
                            table.insert(placedProps, prop)
                            exports.object_gizmo:useGizmo(prop)
                            ESX.ShowNotification("~g~Objet posé, utilisez le gizmo pour le placer.")
            
                            ClearPreviewProp()
                            Wait(250)
                        end
                    })
                end
            end)
            
            
            

RageUI.IsVisible(manageObjectsMenu, function()
    local hasObject = false

    for i, obj in ipairs(placedProps) do
        if DoesEntityExist(obj) then
            hasObject = true
            RageUI.Button("Objet " .. i, nil, {RightLabel = "➡️"}, true, {
                onActive = function()
                    selectedObject = obj
                end,
                onSelected = function()
                    RageUI.Visible(objectActionsMenu, true)
                end
            })
        end
    end

    if not hasObject then
        RageUI.Separator("")
        RageUI.Separator("")
    end
end)


            
            

            RageUI.IsVisible(objectActionsMenu, function()
                if not selectedObject or not DoesEntityExist(selectedObject) then
                    RageUI.Separator("~r~Objet introuvable")
                    return
                end

                RageUI.Button("Déplacer", "Déplace l'objet avec le gizmo", {}, true, {
                    onSelected = function()
                        exports.object_gizmo:useGizmo(selectedObject)
                    end
                })

                RageUI.Button("Supprimer", "Supprime l'objet définitivement", {}, true, {
                    onSelected = function()
                        DeleteEntity(selectedObject)
                        for i, obj in ipairs(placedProps) do
                            if obj == selectedObject then
                                table.remove(placedProps, i)
                                break
                            end
                        end
                        ESX.ShowNotification("~r~Objet supprimé.")
                        selectedObject = nil
                        RageUI.GoBack()
                    end
                })
            end)

        
            if not RageUI.Visible(mainMenu) 
            and not RageUI.Visible(infoMenu) 
            and not RageUI.Visible(raccourciMenu)
            and not RageUI.Visible(commandMenu)
            and not RageUI.Visible(vehicleMenu)
            and not RageUI.Visible(vipMenu)
            and not RageUI.Visible(staffMenu)
            and not RageUI.Visible(boutiqueMenu)
            and not RageUI.Visible(settinsmenu)
            and not RageUI.Visible(staffSubMenu) 
            and not RageUI.Visible(vipObjectsMenu)
            and not RageUI.Visible(manageObjectsMenu)
            and not RageUI.Visible(objectActionsMenu)
            and not RageUI.Visible(boutiqueMenu)
            and not RageUI.Visible(animationMenu)
            and not RageUI.Visible(emoteMenu)
            and not RageUI.Visible(humeurMenu)
            and not RageUI.Visible(demarcheMenu) then


                isMenuOpen = false
                playerInfo = {}
                ClearPreviewProp()
            end 
        else
            Wait(500)
        end
    end
end)

RegisterNetEvent('kay_f5:setPlayerInfo')
AddEventHandler('zeno_f5:setPlayerInfo', function(data)
    playerInfo = data
end)

table.find = function(tbl, val)
    for i, v in ipairs(tbl) do
        if v == val then return i end
    end
    return 1
end

CreateThread(function()
    while true do
        Wait(0)

        if RageUI.Visible(manageObjectsMenu) then
            for _, obj in ipairs(placedProps) do
                if DoesEntityExist(obj) then
                    local coords = GetEntityCoords(obj)
                    DrawMarker(6, coords.x, coords.y, coords.z + 1.2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0,
                        0.3, 0.3, 0.3,
                        255, 100, 100, 180,
                        false, true, 2, false, nil, nil, false)
                end
            end
        end

        if selectedObject and DoesEntityExist(selectedObject) and RageUI.Visible(objectActionsMenu) then
            local coords = GetEntityCoords(selectedObject)
            DrawMarker(6, coords.x, coords.y, coords.z + 1.2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0,
                0.3, 0.3, 0.3,
                255, 0, 0, 255,
                false, true, 2, false, nil, nil, false)

            local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z + 1.5)
            if onScreen then
                SetTextScale(0.35, 0.35)
                SetTextFont(4)
                SetTextProportional(1)
                SetTextCentre(true)
                SetTextColour(255, 255, 255, 200)
                SetTextEntry("STRING")
                AddTextComponentString("~r~Objet sélectionné")
                DrawText(x, y)
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ClearPreviewProp()
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if previewProp and DoesEntityExist(previewProp) then
            local coords = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 1.5
            SetEntityCoordsNoOffset(previewProp, coords.x, coords.y, coords.z, false, false, false)
        end
    end
end)


function StartAutoDrive()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        ESX.ShowNotification("~r~Tu n'es pas dans un véhicule.")
        return
    end

    local blip = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blip) then
        ESX.ShowNotification("~r~Tu dois placer un point GPS.")
        return
    end

    local coord = GetBlipInfoIdCoord(blip)
    TaskVehicleDriveToCoordLongrange(playerPed, vehicle, coord.x, coord.y, coord.z, 30.0, 786603, 10.0)

    ESX.ShowNotification("~g~Auto-pilote activé. Ton véhicule suit le GPS.")

    CreateThread(function()
        while true do
            Wait(1000)
            if not DoesEntityExist(vehicle) or not IsPedInVehicle(playerPed, vehicle, false) then
                ClearPedTasks(playerPed)
                ESX.ShowNotification("~r~Auto-pilote arrêté.")
                break
            end

            local dist = #(GetEntityCoords(playerPed) - coord)
            if dist < 10.0 then
                ClearPedTasks(playerPed)

                TaskVehicleTempAction(playerPed, vehicle, 27, 1000)
                Wait(1000)

                SetVehicleEngineOn(vehicle, true, true, false)
                SetVehicleHandbrake(vehicle, false)
                SetVehicleBrakeLights(vehicle, false)

                ESX.ShowNotification("~b~Tu es arrivé à destination.")
                break
            end
        end
    end)
end
