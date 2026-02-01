local ECM = exports["kay_context"]

local pnjDejaVendu = {}

local ESX = nil

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


ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    local ped = hitEntity
local playerIndex = NetworkGetPlayerIndexFromPed(ped)
if playerIndex ~= -1 then
    local serverId = GetPlayerServerId(playerIndex)
    local idText = "ID : " .. tostring(serverId)
    local idItem = ECM:AddItem(0, idText)
    ECM:OnActivate(idItem, function()
        lib.setClipboard(tostring(serverId))
        Notification(idText, "📋 Copié dans le presse-papier", 3000)
    end)
end

    if DoesEntityExist(hitEntity) and IsEntityAPed(hitEntity) and NetworkGetPlayerIndexFromPed(ped) == -1 then

        local netId = NetworkGetNetworkIdFromEntity(ped)
        if pnjDejaVendu[netId] then
            ESX.ShowNotification("~r~Tu as déjà vendu à cette personne.")
            return
        end
        
        
        local sellMenu = ECM:AddSubmenu(0, "Vendre un item")

        local itemsAVendre = {
            {label = "Pochon de Cannabis", item = "weed"},
            {label = "Pochon de Coke", item = "coke_pooch"},
            {label = "Méthamphétamine", item = "meth"}
        }
        
        local hasItemToSell = false
        
        for _, data in pairs(itemsAVendre) do
            local count = exports.ox_inventory:Search("count", data.item) or 0
        
            if count > 0 then
                hasItemToSell = true
                local labelText = ("%s ~p~(%sx)"):format(data.label, count)
                local itemBtn = ECM:AddItem(sellMenu, labelText)
        
                ECM:OnActivate(itemBtn, function()
                    local netId = NetworkGetNetworkIdFromEntity(ped)
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local pedCoords = GetEntityCoords(ped)
                    local distance = #(playerCoords - pedCoords)
        
                    if distance > 3.0 then
                        ESX.ShowNotification("~w~Tu es trop loin de cette personne.")
                        return
                    end
        
                    if pnjDejaVendu[netId] then
                        ESX.ShowNotification("~w~Tu as déjà vendu à cette personne.")
                        return
                    end
        
                    pnjDejaVendu[netId] = true
        
                    if math.random(1, 100) <= 25 then
                        ESX.ShowNotification("~w~Ce PNJ a refusé de faire affaire et s'est enfui.")
                        ClearPedTasksImmediately(ped)
                        TaskSmartFleePed(ped, PlayerPedId(), 100.0, -1, false, false)
                        return
                    end
                    ClearPedTasksImmediately(ped)
                    TaskStandStill(ped, 3000)
        
                    RequestAnimDict("mp_common")
                    while not HasAnimDictLoaded("mp_common") do Wait(0) end
                    TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 8.0, -8.0, 1500, 0, 0, false, false, false)

                    Wait(1200)
                    TriggerServerEvent("kay_context:SellItemToNPC", data.item)
                    CreateThread(function()
                        Wait(500) 
                        TriggerEvent("kay_context:checkStopDrugSelling")
                    end)

                    CreateThread(function()
                        Wait(1500)
                        if DoesEntityExist(ped) and not IsPedDeadOrDying(ped) then
                            ClearPedTasksImmediately(ped)
                            TaskWanderStandard(ped, 1.0, 10)
                            SetPedKeepTask(ped, true)
                        end
                    end)
                end)
            end
        end
        
        if not hasItemToSell then
            local nothing = ECM:AddItem(sellMenu, "~c~Aucun item disponible")
        end
        
        
        
        local DebugPed = ECM:AddSubmenu(0, "Outils de debug")
        local DebugPedPED = ECM:AddItem(DebugPed, GetEntityArchetypeName(hitEntity))
        local DebugPedPos = ECM:AddItem(DebugPed, GetEntityCoords(ped))
        ECM:OnActivate(DebugPedPED, function()
            lib.setClipboard(GetEntityArchetypeName(hitEntity))
            Notification(GetEntityArchetypeName(hitEntity), "Copier dans le presse papier.", 3500)
        end)
        ECM:OnActivate(DebugPedPos, function()
            lib.setClipboard(""..GetEntityCoords(ped))
            Notification(""..GetEntityCoords(ped), "Copier dans le presse papier.", 3500)
        end)


        if ESX.PlayerData and ESX.PlayerData.group and (
            ESX.PlayerData.group == 'fondateur' or
            ESX.PlayerData.group == 'admin' or
            ESX.PlayerData.group == 'moderateur'
       ) then
        
            ECM:AddSeparator(0)
            local PedAdmin = ECM:AddSubmenu(0, "~r~Administrations")
            
            local PedAdminDelete = ECM:AddItem(PedAdmin, "Supprimer")
            ECM:OnActivate(PedAdminDelete, function()
                if (ped ~= nil and DoesEntityExist(ped)) then
                    SetEntityAsMissionEntity(ped)
                    DeleteEntity(ped)
                    Notification(nil, "Ped supprimé.", 3500)
                end
            end)

            local PedAdminTp = ECM:AddSubmenu(PedAdmin, "Téléport")

            local PedAdminTpMe = ECM:AddItem(PedAdminTp, "Me to Ped")
            ECM:OnActivate(PedAdminTpMe, function()
                SetEntityCoords(PlayerPedId(), GetEntityCoords(ped))
                Notification(nil, "Téléporté sur le ped.", 3500)
            end)

            local PedAdminTpPed = ECM:AddItem(PedAdminTp, "Ped to Me")
            ECM:OnActivate(PedAdminTpPed, function()
                SetEntityCoords(ped, GetEntityCoords(PlayerPedId()))
                Notification(nil, "Ped téléporté sur vous.", 3500)
            end)

            local PedAdminGestion = ECM:AddSubmenu(PedAdmin, "Gestion")

            local PedAdminFreeze = ECM:AddItem(PedAdminGestion, "Freeze")
            ECM:OnActivate(PedAdminFreeze, function()
                FreezeEntityPosition(ped, true)
                Notification(nil, "Ped freezé.", 3500)
            end)

            local PedAdminUnfreeze = ECM:AddItem(PedAdminGestion, "Unfreeze")
            ECM:OnActivate(PedAdminUnfreeze, function()
                FreezeEntityPosition(ped, false)
                Notification(nil, "Ped unfreezé.", 3500)
            end)

            ECM:AddSeparator(PedAdminGestion)

            local PedAdminApaiser = ECM:AddItem(PedAdminGestion, "Apaiser")
            ECM:OnActivate(PedAdminApaiser, function()
                ClearPedTasksImmediately(ped)
                Notification(nil, "Ped apaisé.", 3500)
            end)

            local PedAdminFuir = ECM:AddItem(PedAdminGestion, "Faire Fuir")
            ECM:OnActivate(PedAdminFuir, function()
                TaskSmartFleePed(ped, PlayerPedId(), 100.0, -1, false, false)
                Notification(nil, "Ped en fuite.", 3500)
            end)

            local PedAdminClone = ECM:AddItem(PedAdminGestion, "Cloner")
            ECM:OnActivate(PedAdminClone, function()
                local coords = GetEntityCoords(hitEntity)
                local ped = ClonePed(hitEntity, true, true, true)
                SetEntityCoords(ped, coords.x +1, coords.y +1, coords.z, coords.h)
                Notification(nil, "Ped dupliquer.", 3500)
            end)

            local PedAdminClone = ECM:AddItem(PedAdminGestion, "Donner mon apparence")
            ECM:OnActivate(PedAdminClone, function()
                local coords = GetEntityCoords(hitEntity)
                SetEntityAsMissionEntity(hitEntity)
                DeleteEntity(hitEntity)
                local ped = ClonePed(PlayerPedId(), true, true, true)
                SetEntityCoords(ped, coords.x, coords.y, coords.z -1, coords.h)
                Notification(nil, "Le ped a pris votre skin.", 3500)
            end)

            local PedAdminRagdoll = ECM:AddItem(PedAdminGestion, "Radgoll (5 secondes)")
            ECM:OnActivate(PedAdminRagdoll, function()
                SetPedToRagdoll(hitEntity, 5000, 5000, 0, false, false, false)
                Notification(nil, "Ped en ragdoll.", 3500)
            end)

            ECM:AddSeparator(PedAdminGestion)

            local PedAdminKill = ECM:AddItem(PedAdminGestion, "Tuer")
            ECM:OnActivate(PedAdminKill, function()
                SetEntityHealth(ped, 0)
                Notification(nil, "Ped tué.", 3500)
            end)

            local PedAdminRevive = ECM:AddItem(PedAdminGestion, "Réanimer")
            ECM:OnActivate(PedAdminRevive, function()
                if not IsPedDeadOrDying(ped, true) then
                    Notification(nil, "Le ped est déjà en vie.", 3500)
                else
                    local model = GetEntityModel(ped)
                    local coords = GetEntityCoords(ped)
                    DeleteEntity(ped)
                    local ReaPed = CreatePed(4, model, coords, 0.0, false, false)
                    TaskWanderStandard(ReaPed, 10.0, 10)
                    Notification(nil, "Ped réanimé.", 3500)
                end
            end)
        end
        return
    end
end)

function Mettreuneclaque(ped) 
    pram = {
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'plyr_takedown_front_slap', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'victim_takedown_front_slap', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,
            
                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    }
    local posPlayer = GetEntityCoords(PlayerPedId())
    local dist = #(GetEntityCoords(ped)-posPlayer)
    
    if dist > 3 then
        Notification("Erreur", "Trop loin...", 3500)
        return
    end

    ClearPedTasksImmediately(ped)
    ClearPedTasksImmediately(PlayerPedId())
    RequestAnimDict(pram['Requester']['Dict'])
    while not HasAnimDictLoaded(pram['Requester']['Dict']) do
        Citizen.Wait(0)
    end
    AttachEntityToEntity(PlayerPedId(), ped, GetPedBoneIndex(ped, pram['Accepter']['Attach']['Bone']), pram['Accepter']['Attach']['xP'], pram['Accepter']['Attach']['yP'], pram['Accepter']['Attach']['zP'], pram['Accepter']['Attach']['xR'], pram['Accepter']['Attach']['yR'], pram['Accepter']['Attach']['zR'], true, true, false, true, 1, true)
    TaskPlayAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 8.0, -8.0, -1, pram['Requester']['Flags'], 0, false, false, false)
    TaskPlayAnim(ped, pram['Accepter']['Dict'], pram['Accepter']['Anim'], 8.0, -8.0, -1, pram['Accepter']['Flags'], 0, false, false, false)
    Citizen.Wait(1000)
    while IsEntityPlayingAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 3) do
        Citizen.Wait(0)    
    end
    DetachEntity(PlayerPedId(), true, false)
    if math.random(1, 100) <= 25 then
        SetEntityHealth(ped, 0)
        Notification(nil, "Vous avez tuer le citoyen.", 3500)
    end
    if GetEntityHealth(ped) > 0 then 
        ClearPedTasksImmediately(ped)
        Notification(nil, "Le citoyen ce relève.", 3500)
        SetPedToRagdoll(ped, 0, 0, 0)
    end
    ClearPedTasksImmediately(PlayerPedId())

end
function CarryPed(ped)
    pram = {
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'missfinale_c2mcs_1', ['Anim'] = 'fin_c2_mcs_1_camman', ['Flags'] = 49,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'nm', ['Anim'] = 'firemans_carry', ['Flags'] = 33, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.075,
                ['yP'] = 1.0,
                ['zP'] = 0.0,

                ['xR'] = 0.27,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    }

    local posPlayer = GetEntityCoords(PlayerPedId())
    local dist = #(GetEntityCoords(ped)-posPlayer)
    
    if dist > 3 then
        Notification("Erreur", "Trop loin...", 3500)
        return
    end

    ClearPedTasksImmediately(ped)
    ClearPedTasksImmediately(PlayerPedId())
    RequestAnimDict(pram['Requester']['Dict'])
    while not HasAnimDictLoaded(pram['Requester']['Dict']) do
        Citizen.Wait(0)
    end
    AttachEntityToEntity(PlayerPedId(), ped, GetPedBoneIndex(ped, pram['Accepter']['Attach']['Bone']), pram['Accepter']['Attach']['xP'], pram['Accepter']['Attach']['yP'], pram['Accepter']['Attach']['zP'], pram['Accepter']['Attach']['xR'], pram['Accepter']['Attach']['yR'], pram['Accepter']['Attach']['zR'], true, true, false, true, 1, true)
    TaskPlayAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 8.0, -8.0, -1, pram['Requester']['Flags'], 0, false, false, false)
    TaskPlayAnim(ped, pram['Accepter']['Dict'], pram['Accepter']['Anim'], 8.0, -8.0, -1, pram['Accepter']['Flags'], 0, false, false, false)
    Citizen.Wait(1000)
    while IsEntityPlayingAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 3) do
        Citizen.Wait(0)
    end
    DetachEntity(PlayerPedId(), true, false)

    ClearPedTasksImmediately(ped)
    ClearPedTasksImmediately(PlayerPedId())
end

function Serrerlamain(ped) 
    pram = {
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.075,
                ['yP'] = 1.0,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    }

    local posPlayer = GetEntityCoords(PlayerPedId())
    local dist = #(GetEntityCoords(ped)-posPlayer)
    
    if dist > 3 then
        Notification("Erreur", "Trop loin...", 3500)
        return
    end

    FreezeEntityPosition(PlayerPedId(), true)
    ClearPedTasksImmediately(ped)
    ClearPedTasksImmediately(PlayerPedId())
    RequestAnimDict(pram['Requester']['Dict'])
    while not HasAnimDictLoaded(pram['Requester']['Dict']) do
        Citizen.Wait(0)
    end
    AttachEntityToEntity(PlayerPedId(), ped, GetPedBoneIndex(ped, pram['Accepter']['Attach']['Bone']), pram['Accepter']['Attach']['xP'], pram['Accepter']['Attach']['yP'], pram['Accepter']['Attach']['zP'], pram['Accepter']['Attach']['xR'], pram['Accepter']['Attach']['yR'], pram['Accepter']['Attach']['zR'], true, true, false, true, 1, true)
    TaskPlayAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 8.0, -8.0, -1, pram['Requester']['Flags'], 0, false, false, false)
    TaskPlayAnim(ped, pram['Accepter']['Dict'], pram['Accepter']['Anim'], 8.0, -8.0, -1, pram['Accepter']['Flags'], 0, false, false, false)
    Citizen.Wait(1000)
    while IsEntityPlayingAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 3) do
        Citizen.Wait(0)
    end
    DetachEntity(PlayerPedId(), true, false)
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasksImmediately(ped)
    ClearPedTasksImmediately(PlayerPedId())
end