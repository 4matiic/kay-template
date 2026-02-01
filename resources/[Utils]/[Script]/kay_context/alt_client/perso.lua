local ECM = exports["kay_context"]

ESX = exports["framework"]:getSharedObject()


local ESX

CreateThread(function()
    while ESX == nil do
        ESX = exports["framework"]:getSharedObject()
        Wait(50)
    end

    while not ESX.IsPlayerLoaded() do
        Wait(50)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)



function GeneratePlate()
    local charset = {}
    for i = 48, 57 do table.insert(charset, string.char(i)) end 
    for i = 65, 90 do table.insert(charset, string.char(i)) end 

    math.randomseed(GetGameTimer())
    local plate = ""
    for i = 1, 8 do
        plate = plate .. charset[math.random(1, #charset)]
    end
    return plate
end


ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
	if (not DoesEntityExist(hitEntity) or PlayerPedId() ~= hitEntity) then
        return
    end
    
    local worldMe = ECM:AddItem(0, "/me")
    ECM:OnActivate(worldMe, function()
        Citizen.Wait(100)
        local meWorld = exports["input"]:ShowInput('Par exemple : La personne à envie de tapé Zeno', false, 100, "small_text")
        if meWorld and meWorld ~= '' then
            ExecuteCommand('me '..' '.. meWorld)
        else
            Notification(nil, "Vous devez écrire un message.", 3500)
        end
    end)
      

    local worldReport = ECM:AddItem(0, "/report")
    ECM:OnActivate(worldReport, function()
        local worldReport = exports["input"]:ShowInput('Message a transmettre a l\'équie STAFF', false, 320., "small_text")
        if Config.useFBUI then
            if worldReport and worldReport ~= '' then
                exports['fb_ui']:displayRequest('Confirmation du report', 'Êtes-vous sûr de vouloir faire un report pour la raison : "'..worldReport..'" ?',
                function()
                    if worldReport and worldReport ~= '' then
                        ExecuteCommand("report "..worldReport)
                        Notification(nil, "Report envoyé à l'équipe STAFF.", 3500)
                    else
                        Notification(nil, "Vous devez fournir un message.", 3500)
                    end
                end,
                function()
                    Notification(nil, "Report annulé.", 3500)
                end)
            else
                Notification(nil, "Report annulé.", 3500)
            end
        else
            if worldReport and worldReport ~= '' then
                ExecuteCommand("report "..worldReport)
                Notification(nil, "Report envoyé à l'équipe STAFF.", 3500)
            else
                Notification(nil, "Vous devez fournir un message.", 3500)
            end
        end
    end)

    local lastEmote = nil 

    local AnimationSubmenu = ECM:AddSubmenu(0, "Animation") 
    
    local animWorld = ECM:AddItem(AnimationSubmenu, "/e")
    local animLast = ECM:AddItem(AnimationSubmenu, "Rejouez la dernière animation")
    local nue = ECM:AddItem(AnimationSubmenu, "Se déshabiller")

    ECM:AddSeparator(AnimationSubmenu)
    local wave = ECM:AddItem(AnimationSubmenu, "Faire coucou")
    local surrender6 = ECM:AddItem(AnimationSubmenu, "Se rendre")
    local salute = ECM:AddItem(AnimationSubmenu, "Salut militaire")
    local sleep = ECM:AddItem(AnimationSubmenu, "Dormir")
    
    ECM:OnActivate(sleep, function()
        lastEmote = "sleep"
        ExecuteCommand('e sleep')
    end)
    
    ECM:OnActivate(nue, function()
        ExecuteCommand('clearskin')
    end)
   
    ECM:OnActivate(salute, function()
        lastEmote = "salute"
        ExecuteCommand('e salute')
    end)
    
    ECM:OnActivate(surrender6, function()
        lastEmote = "surrender6"
        ExecuteCommand('e surrender6')
    end)
    
    ECM:OnActivate(wave, function()
        lastEmote = "wave"
        ExecuteCommand('e wave')
    end)
    
    ECM:OnActivate(animWorld, function()
        Citizen.Wait(500)
        local animWorld = exports["input"]:ShowInput('"sit" par exemple', false, 320., "small_text")
        if animWorld and animWorld ~= '' then
            lastEmote = animWorld
            ExecuteCommand('e ' .. animWorld)
        else
            Notification(nil, "Vous devez écrire quelque chose.", 3500)
        end
    end)
    
    ECM:OnActivate(animLast, function()
        if lastEmote then
            ExecuteCommand('e ' .. lastEmote)
        else
            Notification(nil, "Aucune animation précédente enregistrée.", 3000)
        end
    end)
    


    local moveAnim = ECM:AddItem(AnimationSubmenu, "Déplacer l'animation")
    ECM:OnActivate(moveAnim, function()
        local ped = PlayerPedId()
        local PedPose = GetEntityCoords(ped)
        local getIfPlayerPlayAnim = exports["rpemotes"]:IsPlayerInAnim()
        if getIfPlayerPlayAnim and not IsPedInAnyVehicle(ped, false) then

            local clonePed = ClonePed(ped, false, false, true)
            local getPlayedAnim = exports["rpemotes"]:getPlayerAnim()
            local animOption = getPlayedAnim.AnimationOptions

            if getPlayedAnim then
                SetEntityNoCollisionEntity(ped, clonePed, false)
                FreezeEntityPosition(ped, true)

                TaskPlayAnim(clonePed, getPlayedAnim[1], getPlayedAnim[2], 2.0, 2.0, -1, 0, 0, false, false, false)
                SetEntityHeading(clonePed, GetEntityHeading(ped))
                SetEntityAlpha(clonePed, 50, true)
                FreezeEntityPosition(clonePed, true)
                SetEntityInvincible(clonePed, true)
                TaskSetBlockingOfNonTemporaryEvents(clonePed, true)

                CreateThread(function()
                    while getIfPlayerPlayAnim and clonePed do
                        if not IsEntityPlayingAnim(clonePed, getPlayedAnim[1], getPlayedAnim[2], 3) then
                            TaskPlayAnim(clonePed, getPlayedAnim[1], getPlayedAnim[2], 5.0, 5.0, animOption.EmoteDuration, animOption.MovementType, 0, false, false, false)
                        end
                        Wait(clonePed and 0 or 1000)
                    end
                end)

                exports.object_gizmo:useGizmo(clonePed)

                local clonePedPose = GetEntityCoords(clonePed)
                SetEntityCoordsNoOffset(ped, clonePedPose.x, clonePedPose.y, clonePedPose.z, true, true, true)
                SetEntityHeading(ped, GetEntityHeading(clonePed))
                DeleteEntity(clonePed)
                exports["rpemotes"]:EmoteCommandStart(getPlayedAnim[4])
                FreezeEntityPosition(ped, true)

                CreateThread(function()
                    while true do 
                        Wait(500) 
                        if not exports["rpemotes"]:IsPlayerInAnim() then 
                            FreezeEntityPosition(ped, false) 
                            break 
                        end 
                    end 
                end)
            else
                ESX.ShowNotification("~r~GetAnim return nil")
            end
        else
            ESX.ShowNotification("~r~Vous devez faire une animation")
        end
    end)

    local cleanWorld = ECM:AddItem(0, "~w~Se nettoyer")
    ECM:OnActivate(cleanWorld, function()
        local ped = PlayerPedId()
        
        local dict = "missmic2_washing_face"
        local anim = "michael_washing_face"
    
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do Wait(0) end
    
        TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
    
        exports.rprogress:Start('Vous vous nettoyez...', 3000)
        Wait(3000)
    
        ClearPedBloodDamage(ped)
        ResetPedVisibleDamage(ped)
        ClearPedLastWeaponDamage(ped)
        ClearPedEnvDirt(ped)
        ClearPedWetness(ped)
        ClearPedTasks(ped)
        ExecuteCommand('me vient de se laver')
    end)
    

    local _src = source
    local playerPed = PlayerPedId(_src)
    local targetPlayer = NetworkGetPlayerIndexFromPed(hitEntity)
    local targetServerId = GetPlayerServerId(targetPlayer)
    local targetPseudo = GetPlayerName(targetPlayer)
    local hash = GetEntityModel(PlayerPedId())

    local Debug = ECM:AddSubmenu(0, "Outils de debug")
    local DebugID = ECM:AddItem(Debug, "ID (temp) : "..targetServerId)
    local DebugPseudo = ECM:AddItem(Debug, targetPseudo)
    local DebugPED = ECM:AddItem(Debug, GetEntityArchetypeName(hitEntity))
    local DebugTechnique = ECM:AddItem(Debug, "Fiche technique")
    ECM:OnActivate(DebugID, function()
        lib.setClipboard(targetServerId)
        Notification(targetServerId, "📄 Copié dans le presse papier.", 3500)
    end)
    ECM:OnActivate(DebugPseudo, function()
        lib.setClipboard(targetPseudo)
        Notification(targetPseudo, "📄 Copié dans le presse papier.", 3500)
    end)
    ECM:OnActivate(DebugPED, function()
        lib.setClipboard(GetEntityArchetypeName(hitEntity))
        Notification(GetEntityArchetypeName(hitEntity), "📄 Copié dans le presse papier.", 3500)
    end)
    ECM:OnActivate(DebugTechnique, function()
        ExecuteCommand('joueurinfos ' .. targetServerId)
    end)


    if ESX.PlayerData and ESX.PlayerData.job.name == 'police' then
        local immoMenu = ECM:AddSubmenu(0, "Police")
    
        local btn1 = ECM:AddItem(immoMenu, "Demande de renfort léger")
        local btn2 = ECM:AddItem(immoMenu, "Demande de renfort moyen")
        local btn3 = ECM:AddItem(immoMenu, "Demande de renfort urgent")

        ECM:OnActivate(btn1, function()
			ExecuteCommand('backup1')
		end)
		ECM:OnActivate(btn2, function()
			ExecuteCommand('backup2')
		end)
		ECM:OnActivate(btn3, function()
            ExecuteCommand('backup3')
        end)
    end
    
    
    
    if ESX.PlayerData and ESX.PlayerData.group and (
        ESX.PlayerData.group == 'superadmin' or
        ESX.PlayerData.group == 'admin' or
        ESX.PlayerData.group == 'mod'
    ) then

        ECM:AddSeparator(0)

        local playerAdmin = ECM:AddSubmenu(0, "~r~Administrations")


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
        
 
        local playerAdminRevive = ECM:AddItem(playerAdmin, "Revive")
        ECM:OnActivate(playerAdminRevive, function()
            local ped = PlayerPedId()
            if IsEntityDead(ped) then
                ExecuteCommand("revive me")
                Notification(nil, "~g~Vous avez été réanimé~s~.", 3500)
            else
                Notification(nil, "~r~Vous êtes déjà en vie~s~.", 3500)
            end
        end)

        local playerAdminBleed = ECM:AddItem(playerAdmin, "Se Faire saigner")
        ECM:OnActivate(playerAdminBleed, function()
            local ped = PlayerPedId()
        
            ClearPedBloodDamage(ped)
        
            for i = 0, 5 do
                ApplyPedDamagePack(ped, "BigHitByVehicle", 0.0, 12.0)
                ApplyPedDamagePack(ped, "SCR_Torture", 0.0, 12.0)
                Wait(100)
            end
        
            Notification(nil, "Du sang est visible sur toi.", 3000)
        end)
        


    local playerAdminHeal = ECM:AddItem(playerAdmin, "Heal")
	ECM:OnActivate(playerAdminHeal, function()
         ExecuteCommand('heal me')
	end)
    local playerAdminHeal = ECM:AddItem(playerAdmin, "Feed")
	ECM:OnActivate(playerAdminHeal, function()
         ExecuteCommand('feed me')
	end)
    local playerAdminArmourFull = ECM:AddItem(playerAdmin, "Gilet Full")
    ECM:OnActivate(playerAdminArmourFull, function()
        SetPedArmour(PlayerPedId(), 100)
        Notification(nil, "🛡️ Gilet mis à 100.", 3000)
    end)

    local playerAdminArmourEmpty = ECM:AddItem(playerAdmin, "Gilet Vide")
    ECM:OnActivate(playerAdminArmourEmpty, function()
        SetPedArmour(PlayerPedId(), 0)
        Notification(nil, "🛡️ Gilet retiré.", 3000)
    end)

    local playerAdminArmourCustom = ECM:AddItem(playerAdmin, "Gilet Valeur au choix")
    ECM:OnActivate(playerAdminArmourCustom, function()
        local input = exports["input"]:ShowInput('Chiffre entre 0 et 100 (0 = vide, 100 = full)', false, 100, "small_text")
        local value = tonumber(input)
        if value and value >= 0 and value <= 100 then
            SetPedArmour(PlayerPedId(), value)
            Notification(nil, "🛡️ Gilet mis à " .. value .. ".", 3000)
        else
            Notification(nil, "❌ Valeur invalide. Utilise un chiffre entre 0 et 100.", 3500)
        end
    end)


        local playerAdminCreateCar = ECM:AddItem(playerAdmin, "Créer un véhicule")
		ECM:OnActivate(playerAdminCreateCar, function()
            Citizen.Wait(500)
            local carHash = exports["input"]:ShowInput('Par exemple : sultan, primo2, ', false, 100, "small_text")
            ExecuteCommand('car '..carHash)
		end)

       -- local playerAdminPedmenu = ECM:AddItem(playerAdmin, "Pedmenu")
	--	ECM:OnActivate(playerAdminPedmenu, function()
      --      ExecuteCommand("pedmenu")
	--	end)

      --  local playerAdminClotheShop = ECM:AddItem(playerAdmin, "Magasin de vêtements")
	--	ECM:OnActivate(playerAdminClotheShop, function()
     --       ExecuteCommand("open_shop")
	--	end)

        local playerAdminSearchItems = ECM:AddItem(playerAdmin, "Rechercher un items")
		ECM:OnActivate(playerAdminSearchItems, function()
            Citizen.Wait(500)
            local SearchItemsName = exports["input"]:ShowInput(  'Par exemple : water', false, 100, "small_text")
            ExecuteCommand("searchitems "..SearchItemsName)
		end)

    --    local playerAdminSearchItems = ECM:AddItem(playerAdmin, "🔎 Voir tous les items")
	--	ECM:OnActivate(playerAdminSearchItems, function()
      --      ExecuteCommand("allitems")
		--end)

        local playerAdminHeal = ECM:AddItem(playerAdmin, "Poubelle Item")
		ECM:OnActivate(playerAdminHeal, function()
            ExecuteCommand('trash')
		end)

        local becomePed = ECM:AddItem(playerAdmin, "Se mettre en ped GTA")
        ECM:OnActivate(becomePed, function()
            local pedName = exports["input"]:ShowInput("Nom du ped (ex: s_m_y_cop_01)", false, 100, "small_text")
            if not pedName or pedName == "" then
                Notification(nil, "❌ Aucun nom entré", 3000)
                return
            end

            TriggerServerEvent("zeno_admin:setPedModel", pedName)
        end)

        local resetPed = ECM:AddItem(playerAdmin, "Revenir en perso")
        ECM:OnActivate(resetPed, function()
            TriggerServerEvent("zeno_admin:resetToPlayerSkin")
        end)


        local playerAdminClearInv = ECM:AddItem(playerAdmin, "Vider l'inventaire")
        ECM:OnActivate(playerAdminClearInv, function()
            TriggerServerEvent("CoreUI:clearInventory")
        end)
        
        local playerAdminGiveHandguns = ECM:AddItem(playerAdmin, "Give toutes armes de poing")
        ECM:OnActivate(playerAdminGiveHandguns, function()
            TriggerServerEvent("CoreUI:giveHandguns")
        end)

        local playerAdminGiveLongGuns = ECM:AddItem(playerAdmin, "Give toutes armes a feu")
        ECM:OnActivate(playerAdminGiveLongGuns, function()
            TriggerServerEvent("CoreUI:giveLongGuns")
        end)

        local screenshotBtn = ECM:AddItem(playerAdmin, "Prendre un screenshot")
        ECM:OnActivate(screenshotBtn, function()
            TriggerServerEvent("kay_context:requestScreenshot", targetServerId)
            Notification(nil, "📸 Demande de capture envoyée...", 3500)
        end)

        local kickPlayer = ECM:AddItem(playerAdmin, "Kick joueur")
        ECM:OnActivate(kickPlayer, function()
            local reason = exports["input"]:ShowInput('Raison du Kick ?', false, 100, "small_text")
            if reason and reason ~= "" then
                TriggerServerEvent("kay_context:kickPlayer", targetServerId, reason)
            end
        end)

        local wipePlayer = ECM:AddItem(playerAdmin, "Wipe joueur")
        ECM:OnActivate(wipePlayer, function()
            local confirm = exports["input"]:ShowInput("Écris 'CONFIRM' pour confirmer le wipe", false, 100, "small_text")
            if confirm and confirm:lower() == "confirm" then
                TriggerServerEvent("kay_context:wipePlayer", targetServerId)
            else
                ESX.ShowNotification("~r~Wipe annulé.")
            end
        end)

        local giveVehPersist = ECM:AddItem(playerAdmin, "Give véhicule (sauvegardé)")
        ECM:OnActivate(giveVehPersist, function()
            Wait(500)
        
            local model = exports["input"]:ShowInput("Par exemple : sultan, buffalo, dominator", false, 100, "small_text")
            if not model or model == "" then return end
        
            model = string.lower(model)
        
            if not IsModelInCdimage(model) then
                Notification("Erreur", "Modèle invalide", 3500)
                return
            end
        
            local playerId = GetPlayerServerId(PlayerId())
            TriggerServerEvent("zeno_admin:spawnVehicleForTarget", playerId, model)
        
            Notification(nil, "Véhicule spawné, clé donnée et sauvegardé", 3500)
        end)
        
        
    
        
        local deleteVehPersist = ECM:AddItem(playerAdmin, "Supprimer véhicule (monde + DB)")

        ECM:OnActivate(deleteVehPersist, function()
            local plate = exports["input"]:ShowInput("Plaque du véhicule à supprimer", false, 100, "small_text")
        
            if not plate or plate == "" then
                Notification("Erreur", "Aucune plaque entrée", 3000)
                return
            end
        
            local vehicles = GetGamePool("CVehicle")
            local found = false
        
            for _, veh in pairs(vehicles) do
                if DoesEntityExist(veh) then
                    local vehPlate = string.gsub(GetVehicleNumberPlateText(veh), "%s+", "")
                    if string.lower(vehPlate) == string.lower(plate) then
                        DeleteEntity(veh)
                        found = true
                        break
                    end
                end
            end
        
            TriggerServerEvent("zeno_admin:deleteVehicleFromDB", plate)
        
            if found then
                Notification("Succès", "Véhicule supprimé du monde et de la base", 4000)
            else
                Notification("Info", "Véhicule non trouvé dans le monde, suppression en base uniquement", 4000)
            end
        end)
        
        local playerAdminGiveItem = ECM:AddItem(playerAdmin, "Give un item")
		ECM:OnActivate(playerAdminGiveItem, function()
            Citizen.Wait(500)
            local itemName = exports["input"]:ShowInput('Par exemple : water, bread, ammo-9', false, 100, "small_text")
            Citizen.Wait(500)
            local itemCount = exports["input"]:ShowInput('Si vous faites "Entrer" sa donnera directement x1', false, 100, "small_text")
            ExecuteCommand("additem me "..itemName.." "..itemCount)
		end)

        local playerAdminRemoveItem = ECM:AddItem(playerAdmin, "Retirer un item")
        ECM:OnActivate(playerAdminRemoveItem, function()
            Citizen.Wait(500)
            local itemName = exports["input"]:ShowInput('Nom de l\'item à retirer (ex: bread, water)', false, 100, "small_text")
            if not itemName or itemName == "" then
                Notification(nil, "❌ Aucun nom d'item entré.", 3500)
                return
            end

            Citizen.Wait(500)
            local itemCount = exports["input"]:ShowInput('Quantité à retirer (Entrée = 1)', false, 100, "small_text")
            local count = tonumber(itemCount) or 1

            TriggerServerEvent("CoreUI:removeItem", itemName, count)
        end)
 

        local playerAdminInfo = ECM:AddSubmenu(0, "~r~Information Admin")
        local playerAdminInfoIdentifiant = ECM:AddItem(playerAdminInfo, "Obtenir ID FiveM")
		ECM:OnActivate(playerAdminInfoIdentifiant, function()
            lib.setClipboard(ESX.PlayerData.identifier)
            Notification(ESX.PlayerData.identifier, "📄 Copié dans le presse papier.", 3500)
		end)
        local playerAdminInfoPseudo = ECM:AddItem(playerAdminInfo, "Pseudo : "..targetPseudo)
		ECM:OnActivate(playerAdminInfoPseudo, function()
            lib.setClipboard(targetPseudo)
            Notification(targetPseudo, "📄 Copié dans le presse papier.", 3500)
		end)
        local playerAdminInfoPrenom = ECM:AddItem(playerAdminInfo, "Prénom : " .. ESX.PlayerData.firstName)
        ECM:OnActivate(playerAdminInfoPrenom, function()
            lib.setClipboard(ESX.PlayerData.firstName)
            Notification(nil, "📄 Prénom copié dans le presse-papiers.", 3500)
        end)

        local playerAdminInfoNom = ECM:AddItem(playerAdminInfo, "Nom : " .. ESX.PlayerData.lastName)
        ECM:OnActivate(playerAdminInfoNom, function()
            lib.setClipboard(ESX.PlayerData.lastName)
            Notification(nil, "📄 Nom copié dans le presse-papiers.", 3500)
        end)

        ESX.TriggerServerCallback('ContextMenu:Player:GetSexe', function(sex)
            local playerAdminInfoSexe = ECM:AddItem(playerAdminInfo, "Sexe : " .. sex)
            ECM:OnActivate(playerAdminInfoSexe, function()
                lib.setClipboard(sex)
                Notification(sex, "📄 Copié dans le presse papier.", 3500)
        end)

        local group = ESX.PlayerData.group or "inconnu"
            local playerAdminInfoGroup = ECM:AddItem(playerAdminInfo, "Groupe : " .. group)
            ECM:OnActivate(playerAdminInfoGroup, function()
                lib.setClipboard(group)
                Notification(group, "📄 Copié dans le presse papier.", 3500)
            end)
        end)
        
        local devActions = ECM:AddSubmenu(0, "~y~Outils de développement")

        local blipsBtn = ECM:AddItem(devActions, "Créer un blips")
        ECM:OnActivate(blipsBtn, function()
            ExecuteCommand("blips")
        end)
        local tpCoordsBtn = ECM:AddItem(devActions, "Se téléporter (coords)")
        ECM:OnActivate(tpCoordsBtn, function()
            Wait(500)
            local coordsInput = exports["input"]:ShowInput("Coordonnées (x, y, z)", false, 100, "small_text")
            if coordsInput and coordsInput ~= "" then
                local x, y, z = coordsInput:match("([^,]+),%s*([^,]+),%s*([^,]+)")
                x, y, z = tonumber(x), tonumber(y), tonumber(z)
        
                if x and y and z then
                    SetEntityCoords(PlayerPedId(), x, y, z)
                    Notification(nil, ("✅ Téléporté à : ~g~%.2f, %.2f, %.2f"):format(x, y, z), 3000)
                else
                    Notification(nil, "~r~Format invalide. Utilise : -184.36, -1003.15, 29.28", 3000)
                end
            end
        end)
        local showcoordsBtn = ECM:AddItem(devActions, "Téléporter au marker (TPM)")
        ECM:OnActivate(showcoordsBtn, function()
            ExecuteCommand("tpm")
        end)
        local getCoordsBtn = ECM:AddItem(devActions, "Obtenir coordonnées (vector3)")
        ECM:OnActivate(getCoordsBtn, function()
            local coords = GetEntityCoords(PlayerPedId())
            local vectorStr = ("vector3(%.2f, %.2f, %.2f)"):format(coords.x, coords.y, coords.z)
            lib.setClipboard(vectorStr)
            Notification(nil, "~g~Coordonnées copiées :~s~ " .. vectorStr, 4000)
        end)
        local getCoordsWithHeadingBtn = ECM:AddItem(devActions, "Obtenir coordonnées (vector4)")
        ECM:OnActivate(getCoordsWithHeadingBtn, function()
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            local vectorStr = ("vector4(%.2f, %.2f, %.2f, %.2f)"):format(coords.x, coords.y, coords.z, heading)
            lib.setClipboard(vectorStr)
            Notification(nil, "~g~Coordonnées copiées :~s~ " .. vectorStr, 4000)
        end)
        local getHeadingBtn = ECM:AddItem(devActions, "Obtenir mon heading")
        ECM:OnActivate(getHeadingBtn, function()
            local heading = GetEntityHeading(PlayerPedId())
            local headingStr = ("%.2f"):format(heading)
            lib.setClipboard(headingStr)
            Notification(nil, "~g~Heading copié :~s~ " .. headingStr, 4000)
        end)
        local tpToPlayer = ECM:AddItem(devActions, "TP sur un joueur")
        ECM:OnActivate(tpToPlayer, function()
            Citizen.Wait(300)
            local targetId = exports["input"]:ShowInput("ID du joueur", false, 5, "small_text")
        
            local myId = GetPlayerServerId(PlayerId())
            if tonumber(targetId) == myId then
                Notification(nil, "~o~Tu es déjà sur toi-même", 3000)
                return
            end
        
            if targetId and tonumber(targetId) then
                ExecuteCommand("tp " .. targetId)
            else
                Notification(nil, "~r~ID invalide", 3000)
            end
        end)
        local showcoordsBtn = ECM:AddItem(devActions, "Recharger son perso")
        ECM:OnActivate(showcoordsBtn, function()
            ExecuteCommand("reloadskin")
        end)        
    end
end)

    



RegisterNetEvent('kay_context:takeScreenshot', function(adminSource)
    print("[kay_context] Screenshot demandé par : ", adminSource)

    exports['screenshot-basic']:requestScreenshotUpload(
        'https://discord.com/api/webhooks/1374511997097611355/EcE5kDXkxMy3zeP9XUBDD0Ck8B8CjkkX4lQtmjxw3ZCebxgA9H41OXNj8hJatsawDEIG',
        'files[]',
        function(data)
            print("[kay_context] Réponse de l'envoi : ", json.encode(data))
            TriggerServerEvent("kay_context:screenshotTaken", adminSource, json.decode(data))
        end
    )
end)

local playerNames = {}

function RequestRPNames()
    ESX.TriggerServerCallback('fb:getRPNames', function(data)
        playerNames = data or {}
    end)
end

CreateThread(function()
    while true do
        RequestRPNames()
        Wait(30000)
    end
end)

CreateThread(function()
    while true do
        Wait(0)

        if showNames then
            for _, playerId in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(playerId)

                if DoesEntityExist(ped) and not IsEntityDead(ped) then
                    local coords = GetEntityCoords(ped)
                    local myCoords = GetEntityCoords(PlayerPedId())
                    local dist = #(coords - myCoords)

                    if dist < 50.0 and HasEntityClearLosToEntity(PlayerPedId(), ped, 17) then
                        local serverId = GetPlayerServerId(playerId)
                        local steamName = GetPlayerName(playerId)
                        local rp = playerNames[serverId] or "Inconnu"
                        local name = ("[%s] %s | %s"):format(serverId, steamName, rp)
                        DrawText3D(coords.x, coords.y, coords.z + 1.1, name)
                        SetPedHasAiBlip(ped, true)
                        SetPedAiBlipForcedOn(ped, true)
                        SetPedAiBlipHasCone(ped, false)
                        SetPedAiBlipSprite(ped, 1) -- 1 = barre classique
                    end
                end
            end
        else
            Wait(500)
            for _, playerId in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(playerId)
                if DoesEntityExist(ped) then
                    SetPedHasAiBlip(ped, false)
                end
            end
        end
    end
end)


function DrawHealthBar(x, y, z, healthPercent)
    local width = 0.04
    local height = 0.006
    local r, g, b = 200, 0, 0

    DrawRect3D(x, y, z, width, height, 0, 0, 0, 150)
    DrawRect3D(x - (1 - healthPercent) * width / 2, y, z, width * healthPercent, height, r, g, b, 220)
end

function DrawRect3D(x, y, z, width, height, r, g, b, a)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        DrawRect(_x, _y, width, height, r, g, b, a)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35) -- taille fixe
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 225, 0, 255)
        SetTextCentre(true)
        SetTextDropshadow(1, 1, 1, 1, 255)
        SetTextOutline()

        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(_x, _y)
    end
end


RegisterNetEvent("kay_context:notify")
AddEventHandler("kay_context:notify", function(msg)
    Notification(nil, msg, 4000)
end)

RegisterNetEvent("zeno_admin:requestPropsFromClient", function(netVeh, plate, model)
    local veh = NetToVeh(netVeh)
    local props = ESX.Game.GetVehicleProperties(veh)
    TriggerServerEvent("zeno_admin:finalizeVehicle", props, plate, model)
end)


RegisterNetEvent("zeno_admin:applyPedModel", function(pedName)
    if not IsModelInCdimage(pedName) or not IsModelValid(pedName) then
        Notification(nil, "❌ Modèle invalide", 3000)
        return
    end

    RequestModel(pedName)
    while not HasModelLoaded(pedName) do Wait(50) end

    SetPlayerModel(PlayerId(), pedName)
    SetModelAsNoLongerNeeded(pedName)
end)

RegisterNetEvent("zeno_admin:restorePlayerSkin", function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

RegisterNetEvent("realestateagent:showRenfortBlip", function(coords, type)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    if type == "light" then
        SetBlipSprite(blip, 161) 
        SetBlipColour(blip, 2)   
        SetBlipScale(blip, 1.5) 
    elseif type == "moyen" then
        SetBlipSprite(blip, 161) 
        SetBlipColour(blip, 17)   
        SetBlipScale(blip, 1.5)  
    elseif type == "urgent" then
        SetBlipSprite(blip, 161) 
        SetBlipColour(blip, 1) 
        SetBlipScale(blip, 1.5)  
    end

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Demande de renfort - " .. (type == "light" and "Moyen" or "Urgent"))
    EndTextCommandSetBlipName(blip)

    Wait(30000)
    RemoveBlip(blip)
end)

