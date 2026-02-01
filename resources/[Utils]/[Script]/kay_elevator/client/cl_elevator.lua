local ESX = exports['framework']:getSharedObject()
local PlayerData = {}
local Elevators = {}
local elevatorMenu = RageUI.CreateMenu("ELEVATOR-BUILDER", "CREATION D'ASCENSEURS")
local floorSubMenu = RageUI.CreateSubMenu(elevatorMenu, "ELEVATOR-BUILDER", "GERER LES ETAGES")
local managementSubMenu = RageUI.CreateSubMenu(elevatorMenu, "ELEVATOR-BUILDER", "GERER LES ASCENSEURS")
local elevatorActionsSubMenu = RageUI.CreateSubMenu(managementSubMenu, "ELEVATOR-BUILDER", "GERER CET ASCENSEURS")
local currentElevatorName = ""
local currentFloors = {}
local selectedElevatorId = nil

local function OpenElevatorBuilder()
    RageUI.Visible(elevatorMenu, true)

    CreateThread(function()
        while true do
            RageUI.IsVisible(elevatorMenu, function()
                RageUI.Separator('          Création d\'un ascenseur')
        
                RageUI.Button("Titre de l\'ascenseur", nil, {RightLabel = currentElevatorName or "Obligatoire"}, true, {
                    onSelected = function()
                        local input = nil
                        repeat
                            input = exports["input"]:ShowSync('Nom de l\'ascenseur :', false, 320., "small_text")
                        until input and input ~= ""
                        currentElevatorName = input
                        ESX.ShowNotification("Nom de l'ascenseur défini sur : ~y~" .. " " .. input)
                    end
                })

                RageUI.Separator('          Création des étages')

                RageUI.Button("Créer des étages", nil, {RightLabel = "→"}, true, {}, floorSubMenu)

                RageUI.Button("Confirmer la création", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        if currentElevatorName ~= "" and #currentFloors > 0 then
                            TriggerServerEvent('elevator:createElevator', currentElevatorName, currentFloors)
                            RageUI.CloseAll()
                            currentElevatorName = ""
                            currentFloors = {}
                        else
                            ESX.ShowNotification("Nom d'ascenseur et au moins un étage requis")
                        end
                    end
                })

                RageUI.Separator('Modifications des ascenseurs')
                RageUI.Button("Gestions", nil, {RightLabel = "→"}, true, {}, managementSubMenu)
            end)

            RageUI.IsVisible(floorSubMenu, function()
                RageUI.Button("Ajouter un étage", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        local playerCoords = GetEntityCoords(PlayerPedId())
                        local input = nil
                        repeat
                            input = exports["input"]:ShowSync('Nom de l\'étage (ex: -1, RDC, 12) :', false, 320., "small_text")
                        until input and input ~= ""
                        table.insert(currentFloors, {
                            name = input,
                            x = playerCoords.x,
                            y = playerCoords.y,
                            z = playerCoords.z
                        })
                        ESX.ShowNotification("~g~Étage " .. input .. " créé avec succès!")
                    end
                })

                RageUI.Separator('Étages crées')
                for i, floor in ipairs(currentFloors) do
                    RageUI.Button(floor.name, nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            table.remove(currentFloors, i)
                            ESX.ShowNotification("~r~Etage supprimé avec succès!")
                        end
                    })
                end
            end)

            RageUI.IsVisible(managementSubMenu, function()
                for id, elevator in pairs(Elevators) do
                    RageUI.Button(elevator.name, "Modifier", {RightLabel = "→"}, true, {
                        onSelected = function()
                            selectedElevatorId = id
                            RageUI.Visible(elevatorActionsSubMenu, true)
                        end
                    })
                end
            end)

            RageUI.IsVisible(elevatorActionsSubMenu, function()
                local elevator = Elevators[selectedElevatorId]
                if elevator then
                    RageUI.Button("Se téléporter", "Téléportation vers le build", {}, true, {
                        onSelected = function()
                            if elevator.floors and #elevator.floors > 0 then
                                local firstFloor = elevator.floors[1]
                                SetEntityCoords(PlayerPedId(), firstFloor.x, firstFloor.y, firstFloor.z)
                                ESX.ShowNotification("Vous avez été téléporté à l'ascenseur : " .. elevator.name)
                            else
                                ESX.ShowNotification("Impossible de se téléporter.")
                            end
                        end
                    })

                    RageUI.Button("Changer le nom", "Changer le nom de l'ascenseur", {}, true, {
                        onSelected = function()
                            local input = KeyboardInput("Nouveau nom de l'ascenseur", "", 30)
                            if input and input ~= "" then
                                TriggerServerEvent('elevator:renameElevator', selectedElevatorId, input)
                            end
                        end
                    })

                    RageUI.Button("Supprimer", "Supprimer cet ascenseur (Supprimer définitivement)", {}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('elevator:deleteElevator', function(success)
                                if success then
                                    ESX.ShowNotification("~r~Ascenseur supprimé avec succès")
                                    Elevators[selectedElevatorId] = nil
                                    RageUI.GoBack()
                                else
                                    ESX.ShowNotification("~r~Erreur lors de la suppression de l'ascenseur")
                                end
                            end, selectedElevatorId)
                        end
                    })
                end
            end)

            if not RageUI.Visible(elevatorMenu) and not RageUI.Visible(floorSubMenu) and not RageUI.Visible(managementSubMenu) and not RageUI.Visible(elevatorActionsSubMenu) then
                break
            end
            Wait(0)
        end
    end)
end

RegisterNetEvent('elevator:OpenElevatorMenu')
AddEventHandler('elevator:OpenElevatorMenu', function()
    OpenElevatorBuilder() -- Appelle la fonction pour ouvrir le menu
end)
RegisterCommand("elevator", function()
    TriggerEvent('elevator:OpenElevatorMenu') -- D�clenche ton �v�nement
end, false) 
RegisterNetEvent('elevator:syncElevators')
AddEventHandler('elevator:syncElevators', function(elevators)
    Elevators = elevators
end)

local function OpenElevatorMenu(elevatorId)
    local elevator = Elevators[elevatorId]
    if elevator then
        local floors = {}
        for i, floor in ipairs(elevator.floors) do
            local displayName = floor.floor_name or floor.name or ("Étage " .. i)
            table.insert(floors, {
                number = i,
                name = displayName
            })
        end
        
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "openElevator",
            elevatorId = elevatorId,
            floors = floors
        })
    else
        print("Ascenseur non trouvé")
    end
end

local inElevatorZone = {}

CreateThread(function()
    while true do
        local waitTime = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for id, elevator in pairs(Elevators) do
            for index, floor in ipairs(elevator.floors) do
                local distance = #(playerCoords - vector3(floor.x, floor.y, floor.z))
                local key = id .. "_" .. index

                -- Si le joueur est proche
                if distance < 2.0 then
                    waitTime = 0
                    DrawMarker(25, floor.x, floor.y, floor.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 1.0, 255, 255, 255, 100, false, true, 2, false, nil, nil, false)
                    
                    if distance < 1.5 then
                        if not inElevatorZone[key] then
                            -- joueur entre dans la zone
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour retourner � l'ascenseur")
                            inElevatorZone[key] = true
                        end

                        if IsControlJustReleased(0, 38) then
                            OpenElevatorMenu(id)
                        end
                    else
                        inElevatorZone[key] = false -- joueur sort de la zone
                    end
                else
                    inElevatorZone[key] = false
                end
            end
        end

        Wait(waitTime)
    end
end)

RegisterNUICallback('closeElevator', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('selectFloor', function(data, cb)
    local elevatorId = data.elevatorId
    local floorNumber = data.floorNumber
    
    local elevator = Elevators[elevatorId]
    if elevator and elevator.floors[floorNumber] then
        local selectedFloor = elevator.floors[floorNumber]
        SetEntityCoords(PlayerPedId(), selectedFloor.x, selectedFloor.y, selectedFloor.z)
        local floorName = selectedFloor.floor_name or selectedFloor.name or "Inconnu"
        ESX.ShowNotification("Vous êtes arrivé à l'étage : ~y~" .. floorName)
    else
        ESX.ShowNotification("Étage non trouvé")
    end

    SetNuiFocus(false, false)
    cb('ok')
end)

CreateThread(function()
    TriggerServerEvent('elevator:requestSync')
    while true do
        Wait(60000)
        TriggerServerEvent('elevator:requestSync')
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end