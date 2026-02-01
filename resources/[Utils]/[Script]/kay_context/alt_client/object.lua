local ECM = exports["kay_context"]
local object = nil
local frozenProps = {}
local lastSearchedTrash = {} 



local ESX = exports["framework"]:getSharedObject()

CreateThread(function()
    while not ESX.IsPlayerLoaded() do Wait(50) end
    ESX.PlayerData = ESX.GetPlayerData()
end)

sitchairActive = false
currentSitchairIndex = 1

bedLayActive = false
currentBedEntity = nil


ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    ESX.PlayerData = ESX.GetPlayerData()

    if not hitSomething or not DoesEntityExist(hitEntity) or not IsEntityAnObject(hitEntity) then
        object = nil
        return
    end

    object = hitEntity
    local entityModel = GetEntityModel(object)


    local atmModels = {
        -870868698,     -- prop_atm_01
        -1126237515,    -- prop_atm_02
        -1364697528,    -- prop_atm_03
        506770882,      -- prop_fleeca_atm
    }
    
    for _, atmModel in pairs(atmModels) do
        if entityModel == atmModel then
            local atmMenu = ECM:AddSubmenu(0, "Banque")
            local openAtm = ECM:AddItem(atmMenu, "Ouvrir l'ATM")

            ECM:OnActivate(openAtm, function()
                local playerCoords = GetEntityCoords(PlayerPedId())
                local atmCoords = GetEntityCoords(object)
                local distance = #(playerCoords - atmCoords)

                if distance > 2.0 then
                    Notification(nil, "~r~Vous êtes trop loin de l'ATM~s~.", 3500)
                    return
                end

                if GetResourceState('bank') == 'started' then
                    local ok, err = pcall(function()
                        exports['bank']:OpenATM()
                    end)
                    if not ok then
                        Notification(nil, "~r~Vous rencontrer une erreur lors de l'ouverture de l'ATM~s~." .. tostring(err), 4000)
                    end
                else
                    Notification(nil, "~r~L'ATM est indisponible~s~.", 4000)
                end
            end)

            break
        end
    end
    
    

local trashModels = {
    1614656839,
    -206690185,   -- prop_bin_01a
    1511880420,   -- prop_bin_05a
    -1096777189,  -- prop_bin_06a
    666561306,     -- prop_bin_07a
    -58485588,      --  prop_dumpster_02b
    -228596739, -- prop_bin_07a
    -130812911, -- prop_bin_03a
    -1426008804, -- prop_bin_07c
    218085040 -- prop_dumpster_01a

}

for _, model in pairs(trashModels) do
    if entityModel == model then
        local searchTrash = ECM:AddItem(0, "Fouiller la poubelle")

        ECM:OnActivate(searchTrash, function()
            local playerCoords = GetEntityCoords(PlayerPedId())
            local trashCoords = GetEntityCoords(object)
            local distance = #(playerCoords - trashCoords)
        
            if distance > 2.0 then
                Notification(nil, "~r~Trop loin de la poubelle", 3500)
                return
            end
        
            local x, y, z = table.unpack(trashCoords)
            local trashKey = string.format("%.2f_%.2f_%.2f", x, y, z)
            local now = GetGameTimer()
        
            if lastSearchedTrash[trashKey] and now - lastSearchedTrash[trashKey] < 1800000 then
                local minutesLeft = math.ceil((1800000 - (now - lastSearchedTrash[trashKey])) / 60000)
                Notification(nil, "~o~Tu as déjà fouillé cette poubelle\n~s~Reviens dans ~y~" .. minutesLeft .. " min", 5000)
                return
            end
        
            lastSearchedTrash[trashKey] = now
        
            local ped = PlayerPedId()
            RequestAnimDict("mini@repair")
            while not HasAnimDictLoaded("mini@repair") do Wait(10) end
            TaskPlayAnim(ped, "mini@repair", "fixing_a_ped", 8.0, -8.0, -1, 1, 0, false, false, false)
        
            exports['rprogress']:Custom({
                Duration = 3000,
                Label = "Fouille de la poubelle...",
                DisableControls = { Mouse = false, Player = true, Vehicle = true },
                Animation = nil,
            })
        
            Wait(3000)
            ClearPedTasks(ped)
        
            local items = { "bread", "water", "lockpick", "trash_bread", "trash_burgershot" }
            local item = items[math.random(1, #items)]
            ESX.TriggerServerCallback("kay_context:GiveItemTrash", function(label)
                ESX.ShowNotification("~g~Tu as trouvé : ~s~" .. label)
            end, item)
        end)
    end
end        


local teleModels = {
    608950395,
    -1394674526,   -- prop_bin_01a
    1194029334,   -- prop_bin_05a
    1503218008,  -- prop_bin_06a
    -698352776,     -- prop_bin_07a
    2054093856,      --  prop_dumpster_02b
    -228596739, -- prop_bin_07a
    -130812911

}

for _, model in pairs(teleModels) do
    if entityModel == model then
        local tele = ECM:AddItem(0, "Mettre la télévision")

        ECM:OnActivate(tele, function()
            ExecuteCommand('pmms')
        end)
    end
end    

    local seatModels = {
        GetHashKey('prop_bench_01a'),
        GetHashKey('prop_bench_01b'),
        GetHashKey('prop_chair_01a'),
        GetHashKey('prop_bench_05'),
        GetHashKey('prop_bench_09'),
        GetHashKey('prop_bench_08'),
        GetHashKey('prop_bench_02'),
        GetHashKey('prop_bench_10'),
        GetHashKey('prop_bench_07'),
        GetHashKey('prop_cs_office_chair'),
        GetHashKey('p_armchair_01_s'),
        GetHashKey('v_ilev_chair02_ped'),
        GetHashKey('prop_bench_01c'),
        GetHashKey('prop_bench_03'),
        GetHashKey('prop_bench_04'),
        GetHashKey('prop_bench_06'),
        GetHashKey('prop_bench_11'),
        GetHashKey('prop_bench_12'),
        GetHashKey('prop_bench_13'),
        GetHashKey('prop_bench_14'),
        GetHashKey('prop_chair_01b'),
        GetHashKey('prop_chair_02'),
        GetHashKey('prop_chair_03'),
        GetHashKey('prop_chair_04a'),
        GetHashKey('prop_chair_04b'),
        GetHashKey('prop_chair_05'),
        GetHashKey('prop_chair_06'),
        GetHashKey('prop_chair_07'),
        GetHashKey('prop_chair_08'),
        GetHashKey('prop_off_chair_01'),
        GetHashKey('prop_off_chair_03'),
        GetHashKey('prop_off_chair_04'),
        GetHashKey('prop_off_chair_04b'),
        GetHashKey('prop_chair_pile_01'),
        GetHashKey('v_ret_gc_chair02'),
        GetHashKey('v_ret_gc_chair03'),
        GetHashKey('v_corp_offchair'),
        GetHashKey('v_corp_bk_chair3'),
        GetHashKey('v_corp_cd_chair'),
        GetHashKey('v_corp_lazychair'),
        GetHashKey('v_serv_bs_chair02'),
        GetHashKey('v_med_p_deskchair'),
        1037469683,
        867556671,
        GetHashKey('p_ilev_p_easychair_s')
    }

    do
        local enginePropHash = GetHashKey('prop_car_engine_01')
        if entityModel == enginePropHash then
            if ESX and ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
                local repairEngineItem = ECM:AddItem(0, "Réparer le moteur")

                ECM:OnActivate(repairEngineItem, function()
                    local ped = PlayerPedId()
                    local playerCoords = GetEntityCoords(ped)
                    local engineCoords = GetEntityCoords(object)
                    local distance = #(playerCoords - engineCoords)

                    if distance > 2.0 then
                        Notification(nil, "~r~Trop loin du moteur", 3500)
                        return
                    end

                    RequestAnimDict("mini@repair")
                    while not HasAnimDictLoaded("mini@repair") do Wait(10) end
                    TaskPlayAnim(ped, "mini@repair", "fixing_a_ped", 8.0, -8.0, -1, 1, 0, false, false, false)

                    exports['rprogress']:Custom({
                        Duration = 8000,
                        Label = "Réparation du moteur...",
                        DisableControls = { Mouse = false, Player = true, Vehicle = true },
                        Animation = nil,
                    })

                    Wait(8000)
                    ClearPedTasksImmediately(ped)

                    ESX.ShowNotification("~g~Moteur réparé.")
                    TriggerEvent("benewww:mechanic:markEngineRepaired", object)
                end)
            end
        end
    end

    local sitVariants = {
        { label = 'sitchair',  type = 'command', command = 'e sitchair'  },
        { label = 'sitchair2', type = 'command', command = 'e sitchair2' },
        { label = 'sitchair3', type = 'command', command = 'e sitchair3' },
        { label = 'sitchair4', type = 'command', command = 'e sitchair4' },
        { label = 'sitchair5', type = 'command', command = 'e sitchair5' },
        { label = 'sitchair6', type = 'command', command = 'e sitchair6' },
        { label = 'sitchair7', type = 'command', command = 'e sitchair7' },
        { label = 'sitchair8', type = 'command', command = 'e sitchair8' }
    }

    local function isSeatModel(hash)
        for _, m in ipairs(seatModels) do
            if hash == m then return true end
        end
        return false
    end

    if isSeatModel(entityModel) then
        local sitMenu = ECM:AddSubmenu(0, "S'asseoir")

        for _, v in ipairs(sitVariants) do
            local item = ECM:AddItem(sitMenu, v.label)
            ECM:OnActivate(item, function()
                local ped = PlayerPedId()
                local playerCoords = GetEntityCoords(ped)
                local objCoords = GetEntityCoords(object)
                local dist = #(playerCoords - objCoords)
                if dist > 2.0 then
                    return Notification(nil, "~r~Trop loin du siège", 3000)
                end

                ExecuteCommand(v.command)
                local idx = tonumber(v.label:match('^sitchair(%d+)$')) or 1
                currentSitchairIndex = idx
                sitchairActive = true
            end)
        end

        local cancelItem = ECM:AddItem(sitMenu, "Se lever")
        ECM:OnActivate(cancelItem, function()
            ExecuteCommand('e c')
            sitchairActive = false
        end)
    end

    local bedModels = {
        GetHashKey('wx__hoispital__surgerybed'),
        GetHashKey('wx__hospital__bed'),
        GetHashKey('wx_hospital_surgerybed'),
        GetHashKey('wx_hospital_bed'),
        GetHashKey('v_med_bed1'),
        GetHashKey('v_med_bed2')
    }
    local function isBedModel(hash)
        for _, m in ipairs(bedModels) do
            if hash == m then return true end
        end
        return false
    end

    if isBedModel(entityModel) then
        local bedMenu = ECM:AddSubmenu(0, "S'allonger")

        local bedHeadingOffset = -90.0 -- orientation par défaut par rapport au lit
        local bedVariants = {
            { label = "Sur le dos (sunbathe)",           kind = "anim", dict = "amb@world_human_sunbathe@male@back@base",  name = "base",  ox = 0.0,  oy = 0.05, oz = 0.0, hoff = 90.0 },
            { label = "Sur le ventre (sunbathe)",        kind = "anim", dict = "amb@world_human_sunbathe@male@front@base", name = "base",  ox = 0.0,  oy = 0.05, oz = 0.0, hoff = 90.0 },
            { label = "Sommeil (Tracy)",                 kind = "anim", dict = "timetable@tracy@sleep@",                    name = "idle_c", ox = 0.0,  oy = 0.02, oz = 0.0, hoff = 0.0 },
            { label = "Couché latéral gauche (Bum)",     kind = "anim", dict = "amb@world_human_bum_slumped@male@laying_on_left_side@base",  name = "base", ox = 0.0,  oy = 0.02, oz = 0.0, hoff = 90.0 },
            { label = "Couché latéral droite (Bum)",     kind = "anim", dict = "amb@world_human_bum_slumped@male@laying_on_right_side@base", name = "base", ox = 0.0,  oy = 0.02, oz = 0.0, hoff = 90.0 }
        }

        for _, v in ipairs(bedVariants) do
            local item = ECM:AddItem(bedMenu, v.label)
            ECM:OnActivate(item, function()
                local ped = PlayerPedId()
                local playerCoords = GetEntityCoords(ped)
                local objCoords = GetEntityCoords(object)
                local dist = #(playerCoords - objCoords)
                if dist > 2.5 then
                    return Notification(nil, "~r~Trop loin du lit", 3000)
                end

                local _, maxDim = GetModelDimensions(entityModel)
                local offsetX = v.ox or 0.0
                local offsetY = v.oy or 0.0
                local offsetZ = v.oz or 0.0
                local topPos = GetOffsetFromEntityInWorldCoords(object, offsetX, offsetY, (maxDim.z - 0.02) + offsetZ)

                local bedHeading = (GetEntityHeading(object) + bedHeadingOffset + (v.hoff or 0.0)) % 360
                SetEntityCoords(ped, topPos.x, topPos.y, topPos.z)
                SetEntityHeading(ped, bedHeading)

                if v.kind == "anim" then
                    FreezeEntityPosition(ped, true)
                    RequestAnimDict(v.dict)
                    while not HasAnimDictLoaded(v.dict) do Wait(0) end
                    TaskPlayAnim(ped, v.dict, v.name, 8.0, -8.0, -1, 1, 0.0, false, false, false)
                else
                    ClearPedTasksImmediately(ped)
                    TaskStartScenarioAtPosition(ped, v.scenario, topPos.x, topPos.y, topPos.z, bedHeading, 0, true, true)
                end

                bedLayActive = true
                currentBedEntity = object
            end)
        end

    end

    local isBalise = false

    if type(activeSpots) == "table" then
        for i, spot in ipairs(activeSpots) do
            if DoesEntityExist(spot.object) and NetworkGetNetworkIdFromEntity(spot.object) == netId then
                if not spot.cooldown and spot.visible then
                    local diveContext = ECM:AddSubmenu(0, "Balise de plongée")
                    local searchItem = ECM:AddItem(diveContext, "Fouiller la balise")
                    ECM:OnActivate(searchItem, function()
                        TriggerServerEvent("gold_dive:tryCollect", i)
                    end)
                    isBalise = true
                    break
                end
            end
        end
    end

    local pumpModels = {
        1694452750, -2007231801, 1339433404, 1933174915, -462817101, -469694731, -164877493
    }
    local function isPumpModel(hash)
        for _, m in ipairs(pumpModels) do
            if hash == m then return true end
        end
        return false
    end

    if isPumpModel(entityModel) then
        local fuelItem = ECM:AddItem(0, "Faire le plein")
        ECM:CloseOnActivate(fuelItem, true)
        ECM:OnActivate(fuelItem, function()
            local ped = PlayerPedId()
            local pcoords = GetEntityCoords(ped)

            if IsPedInAnyVehicle(ped, false) then
                if ESX and ESX.ShowNotification then
                    ESX.ShowNotification("Sors du véhicule pour le remplir")
                end
                return
            end

            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicle == 0 then
                vehicle = GetClosestVehicle(pcoords.x, pcoords.y, pcoords.z, 4.0, 0, 71)
            end
            if vehicle == 0 or not DoesEntityExist(vehicle) then
                if ESX and ESX.ShowNotification then
                    ESX.ShowNotification("~y~Aucun véhicule à proximité.")
                end
                return
            end

            if DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
                if ESX and ESX.ShowNotification then
                    ESX.ShowNotification("~y~Le siège conducteur doit être libre.")
                end
                return
            end

            if #(GetEntityCoords(vehicle) - pcoords) > 3.0 then
                if ESX and ESX.ShowNotification then
                    ESX.ShowNotification("~y~Rapproche-toi du véhicule.")
                end
                return
            end

            if GetVehicleFuelLevel(vehicle) >= 95.0 then
                if ESX and ESX.ShowNotification then
                    ESX.ShowNotification("~g~Réservoir déjà plein.")
                end
                return
            end

            local function LoadAnimDict(dict)
                RequestAnimDict(dict)
                local tries = 0
                while not HasAnimDictLoaded(dict) and tries < 100 do
                    Citizen.Wait(10)
                    tries = tries + 1
                end
            end
            LoadAnimDict("timetable@gardener@filling_can")

            local pumpObject = object
            TriggerEvent('fb_fuel:startRefuelFromContext', pumpObject, ped, vehicle)
        end)
    end

    local cctvModels = {
        GetHashKey('prop_cctv_cam_01a'),
        GetHashKey('prop_cctv_cam_05a')
    }
    local function isCctvModel(hash)
        for _, m in ipairs(cctvModels) do
            if hash == m then return true end
        end
        return false
    end

    if isCctvModel(entityModel) then
        local openCamsItem = ECM:AddItem(0, "Regarder les caméras")
        ECM:CloseOnActivate(openCamsItem, true)
        ECM:OnActivate(openCamsItem, function()
            local ped = PlayerPedId()
            local pcoords = GetEntityCoords(ped)
            local objCoords = GetEntityCoords(object)
            if #(pcoords - objCoords) > 5.0 then
                return Notification(nil, "~r~Trop loin de la caméra", 3000)
            end

            TriggerEvent('videoRecordingCameras:WatchNearestCamera', { x = objCoords.x, y = objCoords.y, z = objCoords.z })
        end)

        local openRecordingsItem = ECM:AddItem(0, "Visualiser les enregistrements")
        ECM:CloseOnActivate(openRecordingsItem, true)
        ECM:OnActivate(openRecordingsItem, function()
            local ped = PlayerPedId()
            local pcoords = GetEntityCoords(ped)
            local objCoords = GetEntityCoords(object)
            if #(pcoords - objCoords) > 5.0 then
                return Notification(nil, "~r~Trop loin de la caméra", 3000)
            end
            TriggerEvent('videoRecordingCameras:OpenRecordingsForNearestCamera', { x = objCoords.x, y = objCoords.y, z = objCoords.z })
        end)
    end

        local gizmoOwnProp = ECM:AddItem(0, "Déplacer mon prop (Gizmo)")
        ECM:OnActivate(gizmoOwnProp, function()
            if not DoesEntityExist(object) or not IsEntityAnObject(object) then return end

            local myIdentifier = ESX.PlayerData and ESX.PlayerData.identifier
            local placedOwner = Entity(object).state and Entity(object).state.placedPropOwnerIdentifier
            if placedOwner and myIdentifier and placedOwner ~= myIdentifier then
                Notification(nil, "~r~Vous ne pouvez déplacer que vos propres props.", 3500)
                return
            end

            if not placedOwner then
                local ownerPlayerId = NetworkGetEntityOwner(object)
                local isOwner = (ownerPlayerId == PlayerId())
                if not isOwner then
                    NetworkRequestControlOfEntity(object)
                    local tries = 0
                    while tries < 30 and not NetworkHasControlOfEntity(object) do
                        tries = tries + 1
                        Wait(10)
                    end
                    if not NetworkHasControlOfEntity(object) then
                        Notification(nil, "~r~Vous ne pouvez déplacer que vos propres props.", 3500)
                        return
                    end
                end

                if myIdentifier and IsEntityAMissionEntity(object) and not placedOwner then
                    local state = Entity(object).state
                    if state and state.set then
                        state:set('placedPropOwnerIdentifier', myIdentifier, true)
                    end
                end
            end

            local gizmo = exports.object_gizmo:useGizmo(object)
            if gizmo and gizmo.position and gizmo.rotation then
                NetworkRequestControlOfEntity(object)
                Wait(100)

                local entityCoords = vector3(gizmo.position.x, gizmo.position.y, gizmo.position.z)
                local entityRotation = vector3(gizmo.rotation.x, gizmo.rotation.y, gizmo.rotation.z)

                SetEntityCoords(object, entityCoords)
                SetEntityRotation(object, entityRotation)

                local placedId = Entity(object).state and Entity(object).state.placedPropId
                if placedId then
                    TriggerServerEvent("admin:updatePlacedProp", placedId, entityCoords.x, entityCoords.y, entityCoords.z, entityRotation.z)
                end

                Notification(nil, "✅ Prop déplacé avec Gizmo.", 2500)
            else
                Notification(nil, "❌ Gizmo annulé ou données invalides.", 3000)
            end
        end)

        if ESX.PlayerData and ESX.PlayerData.group and (
            ESX.PlayerData.group == 'superadmin' or
            ESX.PlayerData.group == 'admin' or
            ESX.PlayerData.group == 'mod' or
            ESX.PlayerData.group == 'moderateur' or
            ESX.PlayerData.group == 'fondateur'
        ) then
        local adminMenu = ECM:AddSubmenu(0, "~r~(Admin) Props")

        local delProp = ECM:AddItem(adminMenu, "Supprimer le prop")
        local rotateProp = ECM:AddItem(adminMenu, "Tourner le prop")
        local freezeBtn = ECM:AddItem(adminMenu, "Freeze le prop")
        local unfreezeBtn = ECM:AddItem(adminMenu, "Unfreeze le prop")
        local gizmoProp = ECM:AddItem(adminMenu, "Déplacer avec Gizmo")

        ECM:OnActivate(delProp, function()
            NetworkRequestControlOfEntity(object)
            Wait(100)
            SetEntityAsMissionEntity(object, true, true)
            DeleteEntity(object)
            Notification(nil, "✅ Prop supprimé.", 2500)
        end)

        ECM:OnActivate(freezeBtn, function()
            local netId = NetworkGetNetworkIdFromEntity(object)
            NetworkRequestControlOfEntity(object)
            Wait(100)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)
            SetEntityDynamic(object, false)
            SetEntityCollision(object, true, true)
            frozenProps[netId] = true
            Notification(nil, "✅ Prop figé (immobile).", 2500)
        end)

        ECM:OnActivate(unfreezeBtn, function()
            local netId = NetworkGetNetworkIdFromEntity(object)
            NetworkRequestControlOfEntity(object)
            Wait(100)
            FreezeEntityPosition(object, false)
            SetEntityDynamic(object, true)
            frozenProps[netId] = false
            Notification(nil, "💨 Prop libéré (peut bouger).", 2500)
        end)

        ECM:OnActivate(rotateProp, function()
            local heading = GetEntityHeading(object) + 45.0
            SetEntityHeading(object, heading)
            Notification(nil, "🔁 Prop tourné de 45°", 2500)
        end)

        ECM:OnActivate(gizmoProp, function()
            if not DoesEntityExist(object) then return end

            local gizmo = exports.object_gizmo:useGizmo(object)
            if gizmo and gizmo.position and gizmo.rotation then
                NetworkRequestControlOfEntity(object)
                Wait(100)

                local entityCoords = vector3(gizmo.position.x, gizmo.position.y, gizmo.position.z)
                local entityRotation = vector3(gizmo.rotation.x, gizmo.rotation.y, gizmo.rotation.z)

                SetEntityCoords(object, entityCoords)
                SetEntityRotation(object, entityRotation)

                local placedId = Entity(object).state and Entity(object).state.placedPropId
                if placedId then
                    TriggerServerEvent("admin:updatePlacedProp", placedId, entityCoords.x, entityCoords.y, entityCoords.z, entityRotation.z)
                end

                Notification(nil, "✅ Prop déplacé avec Gizmo.", 2500)
            else
                Notification(nil, "❌ Gizmo annulé ou données invalides.", 3000)
            end
        end)
    end

    if not isBalise then
        local debugMenu = ECM:AddSubmenu(0, "Outils de debug")
        local hashItem = ECM:AddItem(debugMenu, GetEntityArchetypeName(object))
        local coordsItem = ECM:AddItem(debugMenu, GetVector3(object))
        local intHashItem = ECM:AddItem(debugMenu, "Hash (Int32) : " .. tostring(entityModel))

        ECM:OnActivate(intHashItem, function()
            lib.setClipboard(tostring(entityModel))
            Notification(nil, "📋 Hash copié : " .. tostring(entityModel), 3500)
        end)
        

        ECM:OnActivate(hashItem, function()
            lib.setClipboard(GetEntityArchetypeName(object))
            Notification(GetEntityArchetypeName(object), "Copié dans le presse-papier", 3500)
        end)

        ECM:OnActivate(coordsItem, function()
            local coords = GetVector3(object)
            lib.setClipboard(coords)
            Notification(coords, "Coordonnées copiées", 3500)
        end)
    end
end)

CreateThread(function()
    while true do
        local now = GetGameTimer()
        for netId, timestamp in pairs(lastSearchedTrash) do
            if now - timestamp >= 1800000 then 
                lastSearchedTrash[netId] = nil
            end
        end
        Wait(60000) 
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
        if bedLayActive then
            local ped = PlayerPedId()
            if IsControlJustPressed(0, 73) then
                FreezeEntityPosition(ped, false)
                ClearPedTasksImmediately(ped)
                if currentBedEntity and DoesEntityExist(currentBedEntity) then
                    local exitPos = GetOffsetFromEntityInWorldCoords(currentBedEntity, 0.0, -0.75, 0.0)
                    SetEntityCoords(ped, exitPos.x, exitPos.y, exitPos.z)
                end
                bedLayActive = false
                currentBedEntity = nil
            else
                if IsPedInAnyVehicle(ped, false) or IsEntityDead(ped) or IsPedRagdoll(ped) then
                    FreezeEntityPosition(ped, false)
                    ClearPedTasksImmediately(ped)
                    bedLayActive = false
                    currentBedEntity = nil
                end
            end
        else
            Citizen.Wait(200)
        end
    end
end)

local SITCHAIR_VARIANTS = { 'sitchair', 'sitchair2', 'sitchair3', 'sitchair4', 'sitchair5', 'sitchair6', 'sitchair7', 'sitchair8' }
currentSitchairIndex = currentSitchairIndex or 1

CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) or IsEntityDead(ped) then
            Citizen.Wait(200)
        else
            local canCycle = sitchairActive or IsPedActiveInScenario(ped) or IsPedUsingAnyScenario(ped)
            if canCycle then
                if IsControlJustPressed(0, 175) then -- INPUT_CELLPHONE_RIGHT
                    currentSitchairIndex = (currentSitchairIndex % #SITCHAIR_VARIANTS) + 1
                    ExecuteCommand('e ' .. SITCHAIR_VARIANTS[currentSitchairIndex])
                    sitchairActive = true
                    if ESX and ESX.ShowNotification then
                        ESX.ShowNotification(('Animation: %s'):format(SITCHAIR_VARIANTS[currentSitchairIndex]))
                    end
                elseif IsControlJustPressed(0, 174) then -- INPUT_CELLPHONE_LEFT
                    currentSitchairIndex = (currentSitchairIndex - 2) % #SITCHAIR_VARIANTS + 1
                    ExecuteCommand('e ' .. SITCHAIR_VARIANTS[currentSitchairIndex])
                    sitchairActive = true
                    if ESX and ESX.ShowNotification then
                        ESX.ShowNotification(('Animation: %s'):format(SITCHAIR_VARIANTS[currentSitchairIndex]))
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(500)
        if sitchairActive then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) or IsEntityDead(ped) or IsPedRagdoll(ped) then
                sitchairActive = false
            else
                if not IsPedActiveInScenario(ped) and not IsPedUsingAnyScenario(ped) then
                    local speed = GetEntitySpeed(ped)
                    if speed > 0.15 then
                        sitchairActive = false
                    end
                end
            end
        end
    end
end)
