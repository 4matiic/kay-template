local ECM = exports["kay_context"]
local ESX = exports["framework"]:getSharedObject()

local drugSellingActive = false
local spawnedDrugPeds = {}
local spawnThreadActive = false
drugToggle = nil



local itemPrices = {
    weed = {label = "Pochon de Cannabis", min = 40, max = 95, qtyMin = 1, qtyMax = 5},
    coke_pooch = {label = "Pochon de Coke", min = 45, max = 155, qtyMin = 1, qtyMax = 5},
    meth = {label = "Méthamphétamine", min = 85, max = 200, qtyMin = 1, qtyMax = 5}
}



local weathers = {
    "Clear", "Extrasunny", "Clouds", "Overcast", "Rain", "Clearing", "Thunder",
    "Smog", "Foggy", "Xmas", "Halloween", "Snowlight", "Blizzard"
}

local times = {
    { "Matin", 8 }, { "Midi", 12 }, { "Milieu d'après midi", 15 },
    { "Début de soirée", 18 }, { "Nuit", 22 }
}

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
    ESX.PlayerData = ESX.PlayerData or {}
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setGroup', function(group)
    if ESX.PlayerData then
        ESX.PlayerData.group = group
    end
end)

CreateThread(function()
    while not ESX.PlayerData or not ESX.PlayerData.group do
        Wait(100)
    end

    ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
        if hitEntity and (IsEntityAPed(hitEntity) or IsEntityAVehicle(hitEntity)) then return end

        -- Vérifie si le joueur a des drogues sur lui
        local hasDrugs = false
        for itemName in pairs(itemPrices) do
            local count = exports.ox_inventory:Search("count", itemName) or 0
            if count > 0 then
                hasDrugs = true
                break
            end
        end

        -- Ajoute le toggle seulement si le joueur a une drogue
        if hasDrugs then
            drugToggle = ECM:AddCheckboxItem(0, "Mode vente de drogue", drugSellingActive)

            ECM:OnActivate(drugToggle, function()
                drugSellingActive = not drugSellingActive

                if drugSellingActive then
                    Notification(nil, "~g~Vous avez activé la vente de drogue~s~.", 3500)
                    StartSpawningCivils()
                else
                    Notification(nil, "~r~Vous avez désactivée la vente de drogue~s~.", 3500)
                    StopSpawningCivils()
                end
            end)
        end

--  ____________________________________________________________________________________________________________ --

        ECM:AddSeparator(0)

        local playerAdmin = ECM:AddSubmenu(0, "~r~Administration")

        local ped = hitEntity
        local targetPlayer = NetworkGetPlayerIndexFromPed(hitEntity)
        local targetServerId = GetPlayerServerId(targetPlayer)

        local adminBlazeDesJoueur = ECM:AddCheckboxItem(playerAdmin, "Afficher le nom des joueurs", showNames)


        ECM:OnActivate(adminBlazeDesJoueur, function()
            showNames = not showNames 
            if showNames then
                Notification(nil, "~g~Vous avez activé les gametags~s~." , 3500)
            else
                Notification(nil, "~r~Vous avez désactivée les gametags~s~." , 3500)
            end
        end)

                local adminPlayerBlips = ECM:AddCheckboxItem(playerAdmin, "Afficher les blips des joueurs", showPlayerBlips)
                      ECM:OnActivate(adminPlayerBlips, function()
                          showPlayerBlips = not showPlayerBlips

                          if showPlayerBlips then
                              Notification(nil, "~g~Blips des joueurs activés~s~.", 3500)

                              Citizen.CreateThread(function()
                                  while showPlayerBlips do
                                      for _, player in ipairs(GetActivePlayers()) do
                                          local ped = GetPlayerPed(player)
                                          if DoesEntityExist(ped) then
                                              if not playerBlips[player] then
                                                  local blip = AddBlipForEntity(ped)
                                                  SetBlipSprite(blip, 1)
                                                  SetBlipScale(blip, 0.85)
                                                  SetBlipColour(blip, 0)
                                                  SetBlipAsShortRange(blip, false)
                                                  BeginTextCommandSetBlipName("STRING")
                                                  AddTextComponentString(GetPlayerName(player))
                                                  EndTextCommandSetBlipName(blip)
                                                  playerBlips[player] = blip
                                              end
                                          end
                                      end
                                      Citizen.Wait(1000)
                                  end
                              end)
                          else
                              Notification(nil, "~r~Blips des joueurs désactivés~s~.", 3500)
                              for _, blip in pairs(playerBlips) do
                                  if DoesBlipExist(blip) then
                                      RemoveBlip(blip)
                                  end
                              end
                              playerBlips = {}
                          end
                      end)


                       local playerAdminSearchItems = ECM:AddItem(playerAdmin, "Give un Items")
		                      ECM:OnActivate(playerAdminSearchItems, function()
                                  Citizen.Wait(500)
                                  local SearchItemsName = exports["ava"]:ShowInput(  'Par exemple : water', false, 100, "small_text")
                                  ExecuteCommand("searchitems "..SearchItemsName)
		                      end)

                       local playerAdminHeal = ECM:AddItem(playerAdmin, "Retirer un Items")
	                      	ECM:OnActivate(playerAdminHeal, function()
                                  ExecuteCommand('trash')
	                      	end)

	                   local playerAdminSearchItems = ECM:AddItem(playerAdmin, "Ouvrir le Panel Kays")
	                      	ECM:OnActivate(playerAdminSearchItems, function()
    	                      	ExecuteCommand("panel")
	                      	end)


--  ____________________________________________________________________________________________________________ --

local devActions = ECM:AddSubmenu(0, "~r~Outils de développement")

-- Créer un casier
local createLockerBtn = ECM:AddItem(devActions, "Créer un casier")
ECM:OnActivate(createLockerBtn, function()
    ExecuteCommand("addLocker")
end)

-- Supprimer un casier
local deleteLockerBtn = ECM:AddItem(devActions, "Supprimer un casier")
ECM:OnActivate(deleteLockerBtn, function()
    ExecuteCommand("delLocker")
end)

-- Créer un blip
local createBlipBtn = ECM:AddItem(devActions, "Créer un blip")
ECM:OnActivate(createBlipBtn, function()
    ExecuteCommand("blips")
end)

-- Téléportation via coordonnées
local tpCoordsBtn = ECM:AddItem(devActions, "Se téléporter (coords)")
ECM:OnActivate(tpCoordsBtn, function()
    Wait(500)

    local coordsInput = exports["ava"]:ShowInput(
        "Coordonnées (x, y, z)",
        false,
        100,
        "small_text"
    )

    if coordsInput and coordsInput ~= "" then
        local x, y, z = coordsInput:match("([^,]+),%s*([^,]+),%s*([^,]+)")
        x, y, z = tonumber(x), tonumber(y), tonumber(z)

        if x and y and z then
            SetEntityCoords(PlayerPedId(), x, y, z)
            Notification(
                nil,
                ("✅ Téléporté à : ~g~%.2f, %.2f, %.2f"):format(x, y, z),
                3000
            )
        else
            Notification(
                nil,
                "~r~Format invalide. Exemple : -184.36, -1003.15, 29.28",
                3000
            )
        end
    end
end)

-- Téléportation au marker (TPM)
local tpmBtn = ECM:AddItem(devActions, "Téléporter au marker (TPM)")
ECM:OnActivate(tpmBtn, function()
    ExecuteCommand("tpm")
end)

-- Copier coordonnées vector3
local getVector3Btn = ECM:AddItem(devActions, "Obtenir coordonnées (vector3)")
ECM:OnActivate(getVector3Btn, function()
    local coords = GetEntityCoords(PlayerPedId())
    local vectorStr = ("vector3(%.2f, %.2f, %.2f)"):format(coords.x, coords.y, coords.z)

    lib.setClipboard(vectorStr)
    Notification(nil, "~g~Coordonnées copiées :~s~ " .. vectorStr, 4000)
end)

-- Copier coordonnées vector4
local getVector4Btn = ECM:AddItem(devActions, "Obtenir coordonnées (vector4)")
ECM:OnActivate(getVector4Btn, function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    local vectorStr = ("vector4(%.2f, %.2f, %.2f, %.2f)")
        :format(coords.x, coords.y, coords.z, heading)

    lib.setClipboard(vectorStr)
    Notification(nil, "~g~Coordonnées copiées :~s~ " .. vectorStr, 4000)
end)

-- Copier heading
local getHeadingBtn = ECM:AddItem(devActions, "Obtenir mon heading")
ECM:OnActivate(getHeadingBtn, function()
    local heading = GetEntityHeading(PlayerPedId())
    local headingStr = ("%.2f"):format(heading)

    lib.setClipboard(headingStr)
    Notification(nil, "~g~Heading copié :~s~ " .. headingStr, 4000)
end)

-- TP sur un joueur
local tpToPlayerBtn = ECM:AddItem(devActions, "TP sur un joueur")
ECM:OnActivate(tpToPlayerBtn, function()
    Wait(300)

    local targetId = exports["ava"]:ShowInput(
        "ID du joueur",
        false,
        5,
        "small_text"
    )

    local myId = GetPlayerServerId(PlayerId())

    if tonumber(targetId) == myId then
        Notification(nil, "~r~Vous ne pouvez pas vous téléporter sur vous-même~s~.", 3000)
        return
    end

    if targetId and tonumber(targetId) then
        ExecuteCommand("tp " .. targetId)
    else
        Notification(nil, "~r~L'ID du joueur est invalide~s~.", 3000)
    end
end)

-- Recharger le personnage
local reloadSkinBtn = ECM:AddItem(devActions, "Recharger son perso")
ECM:OnActivate(reloadSkinBtn, function()
    ExecuteCommand("reloadskin")
end)


--  ____________________________________________________________________________________________________________ --

        -- bloc admin
        if ESX.PlayerData and ESX.PlayerData.group and (
            ESX.PlayerData.group == 'admin'
            or ESX.PlayerData.group == 'fondateur'
            or ESX.PlayerData.group == 'moderateur'
        ) then
            if not hitSomething then
                local submenuWeather = ECM:AddSubmenu(0, "Changer la météo")
                for i = 1, #weathers do
                    local itemWeather = ECM:AddItem(submenuWeather, weathers[i])
                    ECM:OnActivate(itemWeather, function()
                        TriggerServerEvent("kay_context:setWeatherGlobally", weathers[i])
                    end)
                end

                local submenuTime = ECM:AddSubmenu(0, "Changer l'heure")
                for i = 1, #times do
                    local itemTime = ECM:AddItem(submenuTime, times[i][1])
                    ECM:OnActivate(itemTime, function()
                        TriggerServerEvent("kay_context:setTimeGlobally", times[i][2])
                    end)
                end
            end
        end
    end) -- fin ECM:Register
end) -- fin CreateThread ✅



function StartSpawningCivils()
    if spawnThreadActive then return end
    spawnThreadActive = true

    CreateThread(function()
        local modelList = {
            `a_m_m_bevhills_01`, `a_m_y_hipster_01`, `a_f_y_tourist_01`,
            `a_m_m_business_01`, `a_f_y_hipster_01`
        }

        while drugSellingActive do
            -- Cleanup des peds trop loin/morts
            local ply = PlayerPedId()
            local plyPos = GetEntityCoords(ply)
            for i = #spawnedDrugPeds, 1, -1 do
                local ped = spawnedDrugPeds[i]
                if (not DoesEntityExist(ped))
                or IsPedDeadOrDying(ped)
                or #(GetEntityCoords(ped) - plyPos) > 80.0 then
                    if DoesEntityExist(ped) then
                        DeleteEntity(ped)
                    end
                    table.remove(spawnedDrugPeds, i)
                end
            end

            -- Spawn si on n'a pas atteint le cap
            if #spawnedDrugPeds < 10 then
                local model = modelList[math.random(#modelList)]
                RequestModel(model)
                local tries = 0
                while not HasModelLoaded(model) and tries < 300 do
                    Wait(0); tries = tries + 1
                end
                if not HasModelLoaded(model) then
                    print("[drug] Model load failed:", model)
                else
                    local offsetX = math.random(-25, 25)
                    local offsetY = math.random(-25, 25)
                    local basePos = GetEntityCoords(PlayerPedId())
                    local spawnGuess = vector3(basePos.x + offsetX, basePos.y + offsetY, basePos.z + 2.0)

                    -- ⚠️ Bon usage de GetSafeCoordForPed : renvoie (found, safeVec3)
                    local found, safePos = GetSafeCoordForPed(spawnGuess.x, spawnGuess.y, spawnGuess.z, true, 16)
                    if not found then
                        -- fallback : récupère le Z du sol
                        local groundZ = 0.0
                        local ok, z = GetGroundZFor_3dCoord(spawnGuess.x, spawnGuess.y, spawnGuess.z, true)
                        if ok then groundZ = z end
                        safePos = vector3(spawnGuess.x, spawnGuess.y, groundZ)
                    end

                    -- Petit check distance pour éviter de pop sur le joueur
                    if #(safePos - basePos) > 12.0 then
                        local ped = CreatePed(4, model, safePos.x, safePos.y, safePos.z, math.random(0, 360)+0.0, true, true)
                        if DoesEntityExist(ped) then
                            SetEntityAsMissionEntity(ped, true, true)
                            SetBlockingOfNonTemporaryEvents(ped, true)
                            SetPedFleeAttributes(ped, 0, false)
                            SetPedCombatAttributes(ped, 46, true)
                            SetPedCanRagdoll(ped, true)
                            TaskWanderStandard(ped, 1.0, 10)
                            table.insert(spawnedDrugPeds, ped)
                        else
                            print("[drug] CreatePed failed at", safePos.x, safePos.y, safePos.z)
                        end
                    end

                    SetModelAsNoLongerNeeded(model)
                end
            end

            Wait(1500)
        end

        spawnThreadActive = false
    end)
end



function StopSpawningCivils()
    drugSellingActive = false
    for _, ped in ipairs(spawnedDrugPeds) do
        if DoesEntityExist(ped) then
            ClearPedTasks(ped)
            SetPedKeepTask(ped, true)
            DeleteEntity(ped) -- si tu veux vraiment nettoyer tout de suite
        end
    end
    spawnedDrugPeds = {}
end


RegisterNetEvent("kay_context:checkStopDrugSelling")
AddEventHandler("kay_context:checkStopDrugSelling", function()
    local hasDrugs = false
    for itemName in pairs(itemPrices) do
        local count = exports.ox_inventory:Search("count", itemName) or 0
        if count > 0 then
            hasDrugs = true
            break
        end
    end

    if not hasDrugs and drugSellingActive then
        StopDrugSelling()
    end
end)

function StopDrugSelling()
    drugSellingActive = false

    if type(drugToggle) == "table" and drugToggle.SetChecked then
        drugToggle:SetChecked(false)
    end

    Notification(nil, "Plus aucune drogue vente de drogue ~r~désactivée", 4000)
    StopSpawningCivils()
end

RegisterNetEvent("kay_context:applyTime")
AddEventHandler("kay_context:applyTime", function(hour)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    NetworkClearClockTimeOverride()

    NetworkOverrideClockTime(hour, 0, 0)
end)

RegisterNetEvent("kay_context:applyWeather")
AddEventHandler("kay_context:applyWeather", function(weatherType)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypeOvertimePersist(weatherType, 5.0)
    SetWeatherTypeNowPersist(weatherType)
    SetWeatherTypeNow(weatherType)
end)
