local ECM = exports["kay_context"]
local lastTargetEntity = nil
ESX = exports["framework"]:getSharedObject()
local isCuffed = false
local escortedBy = nil


local ESX = nil

local function isPoliceJob()
    local name = ESX and ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name
    local name2 = ESX and ESX.PlayerData and ESX.PlayerData.job2 and ESX.PlayerData.job2.name
    local policeJobs = { ['police']=true, ['lspd']=true, ['bcso']=true, ['sheriff']=true }
    return (name and policeJobs[name]) or (name2 and policeJobs[name2]) or false
end

CreateThread(function()
    ESX = exports["framework"]:getSharedObject()
    while not ESX.IsPlayerLoaded() do
        Wait(50)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX = ESX or exports["framework"]:getSharedObject()
    ESX.PlayerData = xPlayer or ESX.GetPlayerData()
end)
RegisterNetEvent('esx:setJob', function(job)
    ESX = ESX or exports["framework"]:getSharedObject()
    ESX.PlayerData = ESX.PlayerData or ESX.GetPlayerData()
    ESX.PlayerData.job = job
end)
RegisterNetEvent('esx:setJob2', function(job2)
    ESX = ESX or exports["framework"]:getSharedObject()
    ESX.PlayerData = ESX.PlayerData or ESX.GetPlayerData()
    ESX.PlayerData.job2 = job2
end)

ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    if (not DoesEntityExist(hitEntity) or not IsPedAPlayer(hitEntity)) then
        return
    end

    RegisterNetEvent("targetServerId", function(entity)
        NetworkGetPlayerIndexFromPed(entity)
        GetPlayerServerId(targetPlayer)
    end)
    local targetPlayer = NetworkGetPlayerIndexFromPed(hitEntity)
    local targetServerId = GetPlayerServerId(targetPlayer)
    local targetPseudo = GetPlayerName(targetPlayer)

    local targetPlayerPlayerPed = NetworkGetPlayerIndexFromPed(PlayerPedId())
    local targetPseudoPlayerPed = GetPlayerName(targetPlayerPlayerPed)
    if (PlayerPedId() == hitEntity) then
        return
    end


    local SearchPlayer = ECM:AddItem(0, "Fouiller")
    ECM:OnActivate(SearchPlayer, function()
        local coords = GetEntityCoords
        if (#(coords(hitEntity) - coords(cache.ped)) <= 2.0) then
            local ok1, res1 = pcall(function()
                return exports.ox_inventory:openInventory('other', { id = 'player'..targetServerId })
            end)
            if ok1 and res1 then
                ExecuteCommand("me fouille l'individu")
                return
            end
            local ok2, res2 = pcall(function()
                return exports.ox_inventory:openInventory('other', { id = targetServerId })
            end)
            if ok2 and res2 then
                ExecuteCommand("me fouille l'individu")
                return
            end
            TriggerServerEvent('zeno:openPlayerInventoryForce', targetServerId)
        else
            Notification("Erreur", "Trop loin...", 3500)
        end
    end)

    local GivePlayer = ECM:AddItem(0, "Donner un item")
    ECM:OnActivate(GivePlayer, function()
        if #(GetEntityCoords(cache.ped) - GetEntityCoords(hitEntity)) <= 2.0 then
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(hitEntity))
            if not targetId then
                Notification("Erreur", "ID du joueur introuvable.", 3500)
                return
            end
    
            local ok1, res1 = pcall(function()
                return exports.ox_inventory:openInventory('player', targetId)
            end)
            if ok1 and res1 then
                ExecuteCommand("me donne un item")
                return
            end
            local ok2, res2 = pcall(function()
                return exports.ox_inventory:openInventory('other', { id = targetId })
            end)
            if ok2 and res2 then
                ExecuteCommand("me donne un item")
                return
            end
            TriggerServerEvent('zeno:openPlayerInventoryForce', targetId)
        else
            Notification("Erreur", "Trop loin du joueur.", 3500)
        end
    end)
    
    
    local InteractCarry = ECM:AddSubmenu(0, "Porter")
    local Porte1 = ECM:AddItem(InteractCarry, "Porté sur le dos")
    ECM:OnActivate(Porte1, function()
        local coords = GetEntityCoords
        if (#(coords(hitEntity) - coords(cache.ped)) <= 2.0) then
            CarryPlayer(hitEntity)
        else
            Notification("Erreur", "Trop loin...", 3500)
        end
    end)

    local VoiceLevel1 = ECM:AddItem(0, "Suggérer une animation")
    ECM:OnActivate(VoiceLevel1, function()
        Citizen.Wait(500)
        local animMsg = exports["input"]:ShowInput("Animation a suggérer", false, 100, "small_text")
        if animMsg and animMsg ~= '' then
            TriggerServerEvent('ContextMenu:Player:Notify', targetServerId, nil, targetPseudoPlayerPed.." vous suggère de faire l'animation ~b~"..animMsg)
        else
            Notification(nil, "Vous devez écrire quelque chose.", 3500)
        end
    end)

    local CopyAnim = ECM:AddItem(0, "Imiter l'animation actuelle")
    ECM:OnActivate(CopyAnim, function()
        TriggerServerEvent('kay_context:requestCopyAnim', targetServerId)
        Notification(nil, "Demande de copie d'animation envoyée...", 2500)
    end)

    local VoiceLevel = ECM:AddSubmenu(0, "Suggérer un niveau de voix")

    local VoiceLevel1 = ECM:AddItem(VoiceLevel, "Chuchoté")
    ECM:OnActivate(VoiceLevel1, function()
        TriggerServerEvent('ContextMenu:Player:Notify', targetServerId, nil, targetPseudoPlayerPed.." vous suggère de ~y~chuchoté")
        Notification(nil, "Tu as suggéré de ~y~chuchoter~s~.", 3500)
    end)
    
    local VoiceLevel2 = ECM:AddItem(VoiceLevel, "Parler")
    ECM:OnActivate(VoiceLevel2, function()
        TriggerServerEvent('ContextMenu:Player:Notify', targetServerId, nil, targetPseudoPlayerPed.." vous suggère de ~b~parler")
        Notification(nil, "Tu as suggéré de ~b~parler~s~.", 3500)
    end)
    
    local VoiceLevel3 = ECM:AddItem(VoiceLevel, "Crier")
    ECM:OnActivate(VoiceLevel3, function()
        TriggerServerEvent('ContextMenu:Player:Notify', targetServerId, nil, targetPseudoPlayerPed.." vous suggère de ~r~crier")
        Notification(nil, "Tu as suggéré de ~r~crier~s~.", 3500)
    end)
    
    local Report = ECM:AddSubmenu(0, "Report ("..targetServerId..")")
    local ReportReason1 = ECM:AddItem(Report, "HRP")
    local ReportReason2 = ECM:AddItem(Report, "Vocal HRP")
    local ReportReason3 = ECM:AddItem(Report, "Troll")
    local ReportReason4 = ECM:AddItem(Report, "Freekill")
    local ReportReason5 = ECM:AddItem(Report, "Chicken run")
    local ReportReason6 = ECM:AddItem(Report, "Free loot")
    local ReportReason7 = ECM:AddItem(Report, "Raison custom...")
    ECM:OnActivate(ReportReason1, function()
        ExecuteCommand("report ID Cible : "..targetServerId..", pseudo cible : "..targetPseudo.." | HRP")
    end)
    ECM:OnActivate(ReportReason2, function()
        ExecuteCommand("report ID Cible : "..targetServerId..", pseudo cible : "..targetPseudo.." | Vocal HRP")
    end)
    ECM:OnActivate(ReportReason3, function()
        ExecuteCommand("report ID Cible : "..targetServerId..", pseudo cible : "..targetPseudo.." | Troll")
    end)
    ECM:OnActivate(ReportReason4, function()
        ExecuteCommand("report ID Cible : "..targetServerId..", pseudo cible : "..targetPseudo.." | Freekill")
    end)
    ECM:OnActivate(ReportReason5, function()
        ExecuteCommand("report ID Cible : "..targetServerId..", pseudo cible : "..targetPseudo.." | Chicken run")
    end)
    ECM:OnActivate(ReportReason6, function()
        ExecuteCommand("report ID Cible : "..targetServerId..", pseudo cible : "..targetPseudo.." | Free loot")
    end)
    ECM:OnActivate(ReportReason7, function()
        Citizen.Wait(500)
        local CustomReason = exports["input"]:ShowSync('Raison du report sur le joueur '..targetPseudo..".", false, 100, "small_text")
        ExecuteCommand("reportc ID Cible : "..targetServerId..", pseudo cible : "..targetPseudo.." | "..CustomReason)
    end)

    if isPoliceJob() then
        local policeMenu = ECM:AddSubmenu(0, "~b~(Police)~w~ Interventions")

        local cuffItem = ECM:AddItem(policeMenu, "Menotter")
        ECM:OnActivate(cuffItem, function()
            local ok, count = pcall(function()
                return exports.ox_inventory:Search('count', 'menottes')
            end)
            if not ok or (count or 0) <= 0 then
                Notification("Erreur", "Vous n'avez pas de menottes.", 3500)
                return
            end
            TriggerServerEvent('context:police:cuff', targetServerId)
        end)

        local uncuffItem = ECM:AddItem(policeMenu, "Démenotter")
        ECM:OnActivate(uncuffItem, function()
            local ok, count = pcall(function()
                return exports.ox_inventory:Search('count', 'key_menotte')
            end)
            if not ok or (count or 0) <= 0 then
                Notification("Erreur", "Vous n'avez pas de clé de menottes.", 3500)
                return
            end
            TriggerServerEvent('context:police:uncuff', targetServerId)
        end)

        local escortItem = ECM:AddItem(policeMenu, "Escorter")
        ECM:OnActivate(escortItem, function()
            TriggerServerEvent('context:police:escortStart', targetServerId)
        end)

        local releaseEscortItem = ECM:AddItem(policeMenu, "Relâcher (escorte)")
        ECM:OnActivate(releaseEscortItem, function()
            TriggerServerEvent('context:police:escortStop', targetServerId)
        end)
    end

    if ESX and ESX.PlayerData and (
        (ESX.PlayerData.job and (ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job.name == 'ems')) or
        (ESX.PlayerData.job2 and (ESX.PlayerData.job2.name == 'ambulance' or ESX.PlayerData.job2.name == 'ems'))
    ) then
        local emsMenu = ECM:AddSubmenu(0, "~r~(Ambulance)~w~ Interventions")

        local reviveItem = ECM:AddItem(emsMenu, "Réanimer (coma)")
    ECM:OnActivate(reviveItem, function()
        local coords = GetEntityCoords
        if (#(coords(hitEntity) - coords(cache.ped)) <= 3.0) then
            TriggerServerEvent('eAmbulance:revive', targetServerId)
            TriggerServerEvent('ox_inventory:RemoveItem', 'medikit', 1)
            ExecuteCommand('e cpr')
        else
            Notification("Erreur", "Trop loin pour réanimer.", 3500)
        end
    end)

        local healItem = ECM:AddItem(emsMenu, "Soigner")
        ECM:OnActivate(healItem, function()
            local coords = GetEntityCoords
            if (#(coords(hitEntity) - coords(cache.ped)) <= 3.0) then
                TriggerServerEvent('context:ems:heal', targetServerId)
                ExecuteCommand('e medic')
            else
                Notification("Erreur", "Trop loin pour soigner.", 3500)
            end
        end)

    end

    if playerJob ~= "unemployed" then
        ECM:AddItem(0, "Faire une facture", function()
                ExecuteCommand('creerfacture') 
        end)
    end

    local Debug = ECM:AddSubmenu(0, "Outils de debug")
    local DebugID = ECM:AddItem(Debug, "ID (temp) : "..targetServerId)
    local DebugPseudo = ECM:AddItem(Debug, targetPseudo)
    local DebugPED = ECM:AddItem(Debug, GetEntityArchetypeName(hitEntity))
    ECM:AddSeparator(Debug)
    local DebugTechnique = ECM:AddItem(Debug, "Fiche Joueur")
    ECM:OnActivate(DebugID, function()
        ExecuteCommand('joueurinfos ' .. targetServerId)
    end)
    ECM:OnActivate(DebugPseudo, function()
        lib.setClipboard(targetPseudo)
        Notification(targetPseudo, "Copié dans le presse papier.", 3500)
    end)
    ECM:OnActivate(DebugPED, function()
        lib.setClipboard(GetEntityArchetypeName(hitEntity))
        Notification(GetEntityArchetypeName(hitEntity), "Copié dans le presse papier.", 3500)
    end)
    ECM:OnActivate(DebugTechnique, function()
        lib.setClipboard("Pseudo du joueur : "..targetPseudo..", ID du joueur (temp) : "..targetServerId..", PED du joueur : "..GetEntityArchetypeName(hitEntity))
        Notification("Pseudo du joueur : "..targetPseudo..", ID du joueur (temp) : "..targetServerId..", PED du joueur : "..GetEntityArchetypeName(hitEntity), "Copié dans le presse papier.", 3500)
    end)

    if ESX.PlayerData and ESX.PlayerData.group and (
        ESX.PlayerData.group == 'fondateur' or
        ESX.PlayerData.group == 'admin' or
        ESX.PlayerData.group == 'moderateur'
    ) then

        ECM:AddSeparator(0)

		local ped = hitEntity
		local playerAdmin = ECM:AddSubmenu(0, "~r~Administration")

		local playerAdminGizmo = ECM:AddItem(playerAdmin, "Revive")
		ECM:OnActivate(playerAdminGizmo, function()
            ExecuteCommand('revive '..' '..targetServerId)
		end)

        local playerAdminGizmo = ECM:AddItem(playerAdmin, "Heal")
		ECM:OnActivate(playerAdminGizmo, function()
            ExecuteCommand('heal '..' '..targetServerId)
		end)

        local playerAdminArmourFull = ECM:AddItem(playerAdmin, "Gilet (full)")
        ECM:OnActivate(playerAdminArmourFull, function()
            TriggerServerEvent('kay_context:setArmour', targetServerId, 100)
        end)
        
        local playerAdminArmourEmpty = ECM:AddItem(playerAdmin, "Gilet (vide)")
        ECM:OnActivate(playerAdminArmourEmpty, function()
            TriggerServerEvent('kay_context:setArmour', targetServerId, 0)
        end)
        
        local playerAdminArmourCustom = ECM:AddItem(playerAdmin, "Gilet (valeur au choix)")
        ECM:OnActivate(playerAdminArmourCustom, function()
            local input = exports["input"]:ShowInput('Chiffre entre 0 et 100', false, 100, "small_text")
            local value = tonumber(input)
            if value and value >= 0 and value <= 100 then
                TriggerServerEvent('kay_context:setArmour', targetServerId, value)
            else
                Notification(nil, "❌ Valeur invalide. (0-100)", 3500)
            end
        end)
        
        local playerAdminGiveHandguns = ECM:AddItem(playerAdmin, "Give toutes armes de poing")
        ECM:OnActivate(playerAdminGiveHandguns, function()
            TriggerServerEvent('CoreUI:giveHandguns', targetServerId)
        end)

        local playerAdminGiveLongGuns = ECM:AddItem(playerAdmin, "Give toutes armes longues")
        ECM:OnActivate(playerAdminGiveLongGuns, function()
            TriggerServerEvent('CoreUI:giveLongGuns', targetServerId)
        end)
        
        local screenshotBtn = ECM:AddItem(playerAdmin, "Prendre un screenshot")
        ECM:OnActivate(screenshotBtn, function()
            TriggerServerEvent("kay_context:requestScreenshot", targetServerId)
            Notification(nil, "📸 Demande de capture envoyée...", 3500)
        end)

        local giveVehButton = ECM:AddItem(playerAdmin, "Give véhicule (sauvegardé)")
        ECM:OnActivate(giveVehButton, function()
            local model = exports["input"]:ShowInput("Nom du véhicule à give (ex: sultan)", false, 100, "small_text")
            if not model or model == "" then
                Notification(nil, "Vous devez fournir un nom de véhicule.", 3500)
                return
            end

            TriggerServerEvent("zeno_admin:spawnVehicleForTarget", targetServerId, model)
        end)

    
        local playerAdminClearInv = ECM:AddItem(playerAdmin, "Vider l'inventaire")
        ECM:OnActivate(playerAdminClearInv, function()
            ExecuteCommand('clearinv '..' '..targetServerId)
        end)

        local playerAdminBring = ECM:AddItem(playerAdmin, "Bring")
		ECM:OnActivate(playerAdminBring, function()
            ExecuteCommand('bring '..' '..targetServerId)
		end)

        local playerAdminGoto = ECM:AddItem(playerAdmin, "Goto")
		ECM:OnActivate(playerAdminGoto, function()
            ExecuteCommand('goto '..' '..targetServerId)
		end)

        local playerAdminKill = ECM:AddItem(playerAdmin, "Kill")
		ECM:OnActivate(playerAdminKill, function()
            ExecuteCommand('kill '..' '..targetServerId)
		end)

        local playerAdmintxAdmin = ECM:AddItem(playerAdmin, "Page du joueur")
		ECM:OnActivate(playerAdmintxAdmin, function()
            ExecuteCommand('tx '..' '..targetServerId)
		end)

        local PlayerAdminMpStaff = ECM:AddItem(playerAdmin, "MP STAFF")
		ECM:OnActivate(PlayerAdminMpStaff, function()
            local MpStaff = exports["input"]:ShowInput('"Vient BDA" par exemple', false, 320., "small_text")
            if MpStaff and MpStaff ~= '' then
                Notification(nil, "Message correctement envoyé", 5000)
                TriggerServerEvent('ContextMenu:Player:Notify', targetServerId, "STAFF : "..targetPseudoPlayerPed, "MESSAGE REÇU : "..MpStaff)
            else
                Notification(nil, "Vous devez écrire quelque chose.", 3500)
            end
		end)

        local playerAdminKickPlayer = ECM:AddItem(playerAdmin, "Kick")
		ECM:OnActivate(playerAdminKickPlayer, function()
            Citizen.Wait(500)
            local KickRaison = exports["input"]:ShowInput('"HRP Vocale" par exemple', false, 320., "small_text")
            if KickRaison and KickRaison ~= '' then
                if Config.useFBUI then
                    exports['fb_ui']:displayRequest('Confirmation du kick', 'Êtes-vous sûr de vouloir kick le joueur '..targetPseudo..' pour la raison : "'..KickRaison..'" ?',
                    function()
                        ExecuteCommand("kicks "..targetServerId.." ".. KickRaison)
                        Notification(nil, "Kick avec la raison "..KickRaison.." correctement exécuté .", 5000)
                    end,
                    function()
                        Notification(nil, "Kick annulé.", 3500)
                    end)
                else
                    if KickRaison and KickRaison ~= '' then
                        Notification(nil, "Kick avec la raison "..KickRaison.." correctement exécuté .", 5000)
                        ExecuteCommand("kicks "..targetServerId.." ".. KickRaison)
                    else
                        Notification(nil, "Vous devez fournir une raison.", 3500)
                    end
                end
            else
                Notification(nil, "Vous devez fournir une raison.", 5000)
            end
		end)

        local playerEmote = ECM:AddItem(playerAdmin, "Créer un véhicule sur le joueur")
		ECM:OnActivate(playerEmote, function()
            Citizen.Wait(500)
            local carArgs = exports["input"]:ShowInput(  '"blista" par exemple', false, 100, "small_text")
            if carArgs and carArgs ~= '' then
                TriggerServerEvent('ContextMenu:Player:Command', targetServerId, 'car ' .. carArgs)
            else
                Notification(nil, "Vous devez fournir un model.", 3500)
            end
		end)

        local playerAdminGiveItem = ECM:AddItem(playerAdmin, "Give un item")
		ECM:OnActivate(playerAdminGiveItem, function()
            Citizen.Wait(500)
            local itemName = exports["input"]:ShowInput('"water" par exemple', false, 100, "small_text")
            Citizen.Wait(500)
            local itemCount = exports["input"]:ShowInput('Si vous mettez directement "ENTRE" alors la quantité give sera 1', false, 100, "small_text")
            if itemName and itemCount ~= '' then
                ExecuteCommand("additem "..targetServerId.." "..itemName.." "..itemCount)
            else
                Notification(nil, "Vous devez fournir un item.", 3500)
            end
		end)

        
        local playerAdminRemoveItem = ECM:AddItem(playerAdmin, "Retirer un item")
        ECM:OnActivate(playerAdminRemoveItem, function()
            if not targetServerId then
                Notification(nil, "❌ Aucun joueur ciblé.", 3500)
                return
            end
        
            Citizen.Wait(500)
            local itemName = exports["input"]:ShowInput('Nom de l\'item à retirer (ex: bread, water)', false, 100, "small_text")
            if not itemName or itemName == "" then
                Notification(nil, "❌ Aucun nom d'item entré.", 3500)
                return
            end
        
            Citizen.Wait(500)
            local itemCount = exports["input"]:ShowInput('Quantité à retirer (Entrée = 1)', false, 100, "small_text")
            local count = tonumber(itemCount) or 1
        
            TriggerServerEvent("CoreUI:removeItem", targetServerId, itemName, count)
        end)
        

        local playerAdmin = ECM:AddSubmenu(0, "~o~Administration Troll")
        local playerMe = ECM:AddItem(playerAdmin, "Faire un /me")
		ECM:OnActivate(playerMe, function()
            Citizen.Wait(500)
            local meArgs = exports["input"]:ShowInput('"Regarde Zeno Dev" par exemple', false, 100, "small_text")
            if meArgs and meArgs ~= '' then
                TriggerServerEvent('ContextMenu:Player:Command', targetServerId, 'me ' .. meArgs)
            else
                Notification(nil, "Vous devez fournir un message.", 3500)
            end
		end)

        local playerEmote = ECM:AddItem(playerAdmin, "Faire un /e")
		ECM:OnActivate(playerEmote, function()
            Citizen.Wait(500)
            local emoteArgs = exports["input"]:ShowInput('"hump" par exemple', false, 100, "small_text")
            if emoteArgs and emoteArgs ~= '' then
                TriggerServerEvent('ContextMenu:Player:Command', targetServerId, 'e ' .. emoteArgs)
            else
                Notification(nil, "Vous devez écrire quelque chose.", 3500)
            end
		end)

        local playerEmote = ECM:AddItem(playerAdmin, "Annulé l'emote jouer")
		ECM:OnActivate(playerEmote, function()
            TriggerServerEvent('ContextMenu:Player:Command', targetServerId, "e c")
		end)

        local playerEmote = ECM:AddItem(playerAdmin, "Faire une commande")
		ECM:OnActivate(playerEmote, function()
            Citizen.Wait(500)
            local commandArgs = exports["input"]:ShowInput('Commande à faire exécuter exemple : /car sanchez (sa fait la commande chez lui)', false, 100, "small_text")
            TriggerServerEvent('ContextMenu:Player:Command', targetServerId, commandArgs)
		end)

        local playerExplosion = ECM:AddItem(playerAdmin, "Exploser")
		ECM:OnActivate(playerExplosion, function()
            TriggerEvent('ContextMenu:Player:CreateExplosion', hitEntity, targetServerId)
		end)

        local TrollKill = ECM:AddItem(playerAdmin, "Tuer")
        ECM:OnActivate(TrollKill, function()
            TriggerServerEvent("zeno_admin:killTarget", targetServerId)
        end)
        
        local stripPlayer = ECM:AddItem(playerAdmin, "Mettre nu")
        ECM:OnActivate(stripPlayer, function()
            if not targetServerId then
                Notification("Erreur", "Aucun joueur ciblé", 3000)
                return
            end
            TriggerServerEvent("zeno_admin:stripTarget", targetServerId)
        end)
        
        
        local restorePlayer = ECM:AddItem(playerAdmin, "Remettre les vêtements")
        ECM:OnActivate(restorePlayer, function()
            if not targetServerId then
                Notification("Erreur", "Aucun joueur ciblé", 3000)
                return
            end
            TriggerServerEvent("zeno_admin:restoreTarget", targetServerId)
        end)
        
        local RandomOutfit = ECM:AddItem(playerAdmin, "Tenue aléatoire")
        ECM:OnActivate(RandomOutfit, function()
            local targetPlayer = NetworkGetPlayerIndexFromPed(ped)
            local targetId = GetPlayerServerId(targetPlayer)
        
            if not targetId then
                Notification("Erreur", "Aucun joueur ciblé", 3000)
                return
            end
        
            TriggerServerEvent("zeno_admin:randomOutfit", targetId)
        end)
        

        local SuperJump = ECM:AddItem(playerAdmin, "Faire sauter très haut")
        ECM:OnActivate(SuperJump, function()
            if not targetServerId then
                Notification("Erreur", "Aucun joueur ciblé", 3000)
                return
            end
            TriggerServerEvent("zeno_admin:superJumpTarget", targetServerId)
        end)
        
        local playerRagdoll = ECM:AddItem(playerAdmin, "Faire tomber (5 sec)")
        ECM:OnActivate(playerRagdoll, function()
            TriggerServerEvent("zeno_admin:ragdollTarget", targetServerId)
        end)

        local playerAdminInfo = ECM:AddSubmenu(0, "~r~Information Admin")
        TriggerServerEvent('kay_context:RequestPlayerInfo', targetServerId, playerAdminInfo)  
    end
end)

RegisterNetEvent('kay_context:reviveCompleted')
AddEventHandler('kay_context:reviveCompleted', function(targetId)
    ExecuteCommand('e c')
    Notification(nil, "Réanimation terminée, arrêt du massage.", 2500)
end)


RegisterNetEvent('ContextMenu:Player:Command', function(command)
    ExecuteCommand(command)
end)

RegisterNetEvent('ContextMenu:Player:Notify', function(soustitre, msg)
    Notification(soustitre, msg, 5000)
end)

RegisterNetEvent('ContextMenu:Player:CreateExplosion', function(entity, serverId)
    local coords = GetEntityCoords(entity)
    AddExplosion(coords, 0, 10.0, true, false, 2.0)
end)

RegisterNetEvent('kay_context:applyArmour', function(value)
    SetPedArmour(PlayerPedId(), value)
    Notification(nil, "🛡️ Ton gilet a été réglé à "..value..".", 3000)
end)

RegisterNetEvent('kay_context:ReceivePlayerInfo')
AddEventHandler('kay_context:ReceivePlayerInfo', function(data, menuRef)
    for _, info in ipairs(data) do
        local label = info.label or "Inconnu"
        local value = info.value or "Non défini"

        if label == "License FiveM" then
            local item = exports["kay_context"]:AddItem(menuRef, "Obtenir ID FiveM")
            exports["kay_context"]:OnActivate(item, function()
                lib.setClipboard(value)
                Notification(nil, "Identifiant copié dans le presse-papier.", 3500)
            end)
        else
            exports["kay_context"]:AddItem(menuRef, label .. " : " .. value)
        end
    end
end)



RegisterNetEvent("zeno_admin:spawnClientVehicle", function(model, plate)
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(50) end

    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
    SetVehicleNumberPlateText(vehicle, plate)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true) 
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

    SetModelAsNoLongerNeeded(model)
end)

RegisterNetEvent("zeno_admin:killClient", function()
    SetEntityHealth(PlayerPedId(), 0)
end)


local savedClothes = {}

RegisterNetEvent("zeno_admin:stripPlayer")
AddEventHandler("zeno_admin:stripPlayer", function()
    local ped = PlayerPedId()

    local saved = {
        torso = {drawable = GetPedDrawableVariation(ped, 11), texture = GetPedTextureVariation(ped, 11)},
        arms = {drawable = GetPedDrawableVariation(ped, 3), texture = GetPedTextureVariation(ped, 3)},
        tshirt = {drawable = GetPedDrawableVariation(ped, 8), texture = GetPedTextureVariation(ped, 8)},
        legs = {drawable = GetPedDrawableVariation(ped, 4), texture = GetPedTextureVariation(ped, 4)},
        shoes = {drawable = GetPedDrawableVariation(ped, 6), texture = GetPedTextureVariation(ped, 6)},
        armor = {drawable = GetPedDrawableVariation(ped, 9), texture = GetPedTextureVariation(ped, 9)},
        decals = {drawable = GetPedDrawableVariation(ped, 10), texture = GetPedTextureVariation(ped, 10)},
        mask = {drawable = GetPedDrawableVariation(ped, 1), texture = GetPedTextureVariation(ped, 1)}
    }

    TriggerServerEvent("zeno_admin:saveClothesBeforeStrip", saved)
    
    SetPedComponentVariation(ped, 3, 15, 0, 2)     -- bras
    SetPedComponentVariation(ped, 8, 15, 0, 2)     -- t-shirt
    SetPedComponentVariation(ped, 11, 15, 0, 2)    -- torse
    SetPedComponentVariation(ped, 4, 133, 0, 2)    -- jambes
    SetPedComponentVariation(ped, 6, 15, 0, 2)     -- chaussures
    SetPedComponentVariation(ped, 9, 0, 0, 2)      -- body armor
    SetPedComponentVariation(ped, 10, 0, 0, 2)     -- decals
    SetPedComponentVariation(ped, 1, 0, 0, 2)      -- masque    
end)

RegisterNetEvent("zeno_admin:applyClothesVisual")
AddEventHandler("zeno_admin:applyClothesVisual", function(targetId, data)
    if targetId == GetPlayerServerId(PlayerId()) then return end
    local player = GetPlayerFromServerId(targetId)
    if player == -1 then return end
    local ped = GetPlayerPed(player)

    SetPedComponentVariation(ped, 11, data.torso.drawable, data.torso.texture, 2)
    SetPedComponentVariation(ped, 4, data.legs.drawable, data.legs.texture, 2)
    SetPedComponentVariation(ped, 6, data.shoes.drawable, data.shoes.texture, 2)
    SetPedComponentVariation(ped, 3, data.arms.drawable, data.arms.texture, 2)
    SetPedComponentVariation(ped, 8, data.tshirt.drawable, data.tshirt.texture, 2)
end)

RegisterNetEvent("zeno_admin:applyClothesSelf")
AddEventHandler("zeno_admin:applyClothesSelf", function(data)
    local ped = PlayerPedId()
    SetPedComponentVariation(ped, 11, data.torso.drawable, data.torso.texture, 2)
    SetPedComponentVariation(ped, 4, data.legs.drawable, data.legs.texture, 2)
    SetPedComponentVariation(ped, 6, data.shoes.drawable, data.shoes.texture, 2)
    SetPedComponentVariation(ped, 3, data.arms.drawable, data.arms.texture, 2)
    SetPedComponentVariation(ped, 8, data.tshirt.drawable, data.tshirt.texture, 2)
    Notification(nil, "👕 Vêtements restaurés", 3500)
end)

RegisterNetEvent("zeno_admin:applyRandomOutfit", function()
    local ped = PlayerPedId()

    local function rand(min, max)
        return math.random(min, max)
    end

    SetPedComponentVariation(ped, 3, rand(0, 10), rand(0, 2), 2)   -- bras
    SetPedComponentVariation(ped, 4, rand(0, 15), rand(0, 5), 2)   -- jambes
    SetPedComponentVariation(ped, 6, rand(0, 15), rand(0, 5), 2)   -- chaussures
    SetPedComponentVariation(ped, 8, rand(0, 15), rand(0, 5), 2)   -- t-shirt
    SetPedComponentVariation(ped, 11, rand(0, 25), rand(0, 5), 2)  -- torse
    SetPedComponentVariation(ped, 10, rand(0, 10), rand(0, 3), 2)  -- badge/écharpe
    SetPedComponentVariation(ped, 1, rand(0, 5), rand(0, 3), 2)    -- masque
    SetPedComponentVariation(ped, 9, rand(0, 10), rand(0, 3), 2)   -- gilet pare-balle

    Notification(nil, "🎲 Une tenue aléatoire t’a été assignée", 3500)
end)

RegisterNetEvent("zeno_admin:superJump")
AddEventHandler("zeno_admin:superJump", function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    SetEntityCoords(ped, pos.x, pos.y, pos.z + 1000.0)
end)

RegisterNetEvent("zeno_admin:forceRagdoll", function()
    local ped = PlayerPedId()
    if not IsPedRagdoll(ped) then
        SetPedToRagdoll(ped, 5000, 5000, 0, false, false, false)
    end
end)

RegisterNetEvent('context:police:applyCuff', function(state)
    local ped = PlayerPedId()
    isCuffed = state and true or false
    SetEnableHandcuffs(ped, isCuffed)
    ClearPedTasksImmediately(ped)
    if isCuffed then
        local dict, anim = 'mp_arresting', 'idle'
        RequestAnimDict(dict)
        local tries = 0
        while not HasAnimDictLoaded(dict) and tries < 50 do Wait(10) tries = tries + 1 end
        TaskPlayAnim(ped, dict, anim, 4.0, -4.0, -1, 49, 0, false, false, false)
        Notification(nil, "🔗 Vous êtes menotté.", 3000)
    else
        ClearPedTasks(ped)
        Notification(nil, "🔓 Menottes retirées.", 3000)
    end
end)

CreateThread(function()
    while true do
        if isCuffed then
            DisableControlAction(0, 21, true)  -- sprint
            DisableControlAction(0, 22, true)  -- jump
            DisableControlAction(0, 23, true)  -- enter vehicle
            DisableControlAction(0, 24, true)  -- attack
            DisableControlAction(0, 25, true)  -- aim
            DisableControlAction(0, 140, true) -- melee alt
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            Wait(0)
        else
            Wait(300)
        end
    end
end)

RegisterNetEvent('context:police:escortStart', function(officerServerId)
    local ped = PlayerPedId()
    local playerIndex = GetPlayerFromServerId(officerServerId)
    if playerIndex ~= -1 then
        local officerPed = GetPlayerPed(playerIndex)
        escortedBy = officerServerId
        AttachEntityToEntity(ped, officerPed, 0, 0.45, 0.30, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        TaskSetBlockingOfNonTemporaryEvents(ped, true)
        Notification(nil, "👮 Vous êtes escorté.", 3000)
    end
end)

RegisterNetEvent('context:police:escortStop', function()
    local ped = PlayerPedId()
    DetachEntity(ped, true, true)
    TaskSetBlockingOfNonTemporaryEvents(ped, false)
    escortedBy = nil
    Notification(nil, "✅ Fin d'escorte.", 3000)
end)

RegisterNetEvent('context:ems:applyRevive', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
    ClearPedTasksImmediately(ped)
    ClearPedBloodDamage(ped)
    SetEntityHealth(ped, GetEntityMaxHealth(ped))
    Notification(nil, "🚑 Vous avez été réanimé.", 3500)
end)

RegisterNetEvent('context:ems:applyHeal', function(amount)
    local ped = PlayerPedId()
    local max = GetEntityMaxHealth(ped)
    local target = amount and math.min(max, amount) or max
    SetEntityHealth(ped, target)
    ClearPedBloodDamage(ped)
    Notification(nil, "🩹 Vous avez été soigné.", 3500)
end)

CreateThread(function()
    while true do
        if ESX and ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
            if IsControlJustPressed(0, 73) then -- 73 = X
                TriggerServerEvent('context:police:escortStop') -- cible déduite côté serveur
            end
            Wait(0)
        else
            Wait(400)
        end
    end
end)

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    local tries = 0
    while not HasAnimDictLoaded(dict) and tries < 100 do
        Citizen.Wait(10)
        tries = tries + 1
    end
end

RegisterNetEvent('kay_context:askCurrentAnim')
AddEventHandler('kay_context:askCurrentAnim', function(requesterId)
    local dict, name, options, emoteName
    local ok, data = pcall(function()
        return exports["rpemotes"]:getPlayerAnim()
    end)

    if ok and data then
        dict = data[1]
        name = data[2]
        options = data.AnimationOptions
        emoteName = data[4]
    end
    TriggerServerEvent('kay_context:emoteReport', requesterId, dict, name, options, emoteName)
end)

RegisterNetEvent('kay_context:playCopiedAnim')
AddEventHandler('kay_context:playCopiedAnim', function(dict, name, options, emoteName)
    local ped = PlayerPedId()
    local duration = (options and options.EmoteDuration) or -1
    local flags = (options and options.MovementType) or 0

    if emoteName and exports["rpemotes"] then
        local started = false
        local okStart, res = pcall(function()
            return exports["rpemotes"]:EmoteCommandStart(emoteName)
        end)
        if okStart and res then
            started = true
            local okGet, current = pcall(function()
                return exports["rpemotes"]:getPlayerAnim()
            end)
            if okGet and current and dict and name and current[1] == dict and current[2] == name then
                Notification(nil, "✅ Animation copiée (rpemotes).", 2500)
                return
            end
        end
    end
    if dict and name then
        LoadAnimDict(dict)
        if HasAnimDictLoaded(dict) then
            TaskPlayAnim(ped, dict, name, 4.0, -4.0, duration, flags, 0, false, false, false)
            Notification(nil, "🎞️ Animation copiée (fallback exact).", 2500)
        else
            Notification("Erreur", "Impossible de charger l'animation.", 3500)
        end
    else
        Notification("Erreur", "Aucune animation détectée chez le joueur ciblé.", 3500)
    end
end)
