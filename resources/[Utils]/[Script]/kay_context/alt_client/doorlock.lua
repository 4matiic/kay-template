local ECM = exports["kay_context"]

local function SafeRightText(itemId, text)
    if itemId and type(itemId) == 'number' and itemId > 0 then
        local ok = pcall(function()
            ECM:RightText(itemId, text)
        end)
        if not ok then
        end
    end
end

doorlockAdvState = doorlockAdvState or {
    isDouble = false,
    accessType = 'aucun',
    itemName = nil,
    itemConsume = false,
    passcode = nil,
    selectedGroups = { police = false, ambulance = false },
    minGrade = nil,
    groupsRaw = nil,
    maxDistance = 2.0,
    lockedDefault = true,
    autolockSeconds = 0
}

local function _captureDoorData(entity)
    if not entity or entity == 0 or GetEntityType(entity) ~= 3 then
        return nil, "Aucun objet valide sous le curseur."
    end

    local coords = GetEntityCoords(entity)
    return {
        entity = entity,
        model = GetEntityModel(entity),
        coords = vec3(coords.x, coords.y, coords.z),
        heading = math.floor(GetEntityHeading(entity) + 0.5)
    }
end

local function createDoorFromEntity(entity)
    if not entity or entity == 0 or GetEntityType(entity) ~= 3 then
        Notification("Doorlock", "❌ Aucun objet valide sous le curseur.", 3500)
        return
    end

    local coords = GetEntityCoords(entity)
    local heading = math.floor(GetEntityHeading(entity) + 0.5)
    local model = GetEntityModel(entity)

    local data = {
        name = ("porte %s"):format(tostring(coords)),
        state = 1, -- verrouillée par défaut
        maxDistance = 2.0,
        model = model,
        coords = vec3(coords.x, coords.y, coords.z),
        heading = heading,
        auto = true
    }

    TriggerServerEvent('ox_doorlock:editDoorlock', false, data)
    Notification("Doorlock", "✅ Porte créée et enregistrée.", 3000)
end

local function deleteDoorFromEntity(entity)
    if not entity or entity == 0 then
        Notification("Doorlock", "❌ Aucun objet sous le curseur.", 3500)
        return
    end

    local id = exports.ox_doorlock:getDoorIdFromEntity(entity)
    if not id then
        Notification("Doorlock", "❌ Aucun doorlock associé à cet objet.", 3500)
        return
    end

    TriggerServerEvent('ox_doorlock:editDoorlock', id)
    Notification("Doorlock", "🗑️ Porte supprimée.", 3000)
end

local function toggleClosestDoor()
    local ok = exports.ox_doorlock:useClosestDoor()
    if not ok then
        Notification("Doorlock", "❌ Aucune porte à proximité.", 3000)
    end
end

local function selectSecondDoor()
    local lastEntity = 0
    local selected = nil

    lib.showTextUI("Sélectionnez la seconde porte (clic gauche). Clic droit pour annuler.")

    while true do
        DisableControlAction(0, 25, true) -- clic droit
        DisablePlayerFiring(cache.playerId, true)

        local hit, entity, coords = lib.raycast.cam(1|16)
        local changed = (lastEntity ~= entity)

        if changed then
            if lastEntity ~= 0 then SetEntityDrawOutline(lastEntity, false) end
            lastEntity = entity
        end

        if hit then
            DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.2, 0.2, 0.2, 255, 42, 24, 100, false, false, 0, true, false, false, false)
        end

        if hit and entity > 0 and GetEntityType(entity) == 3 and exports.ox_doorlock:getDoorIdFromEntity(entity) == nil then
            if changed then SetEntityDrawOutline(entity, true) end

            if IsDisabledControlJustPressed(0, 24) then -- clic gauche
                local data = _captureDoorData(entity)
                if data then
                    selected = data
                    SetEntityDrawOutline(entity, false)
                    break
                end
            end
        end

        if IsDisabledControlJustPressed(0, 25) then -- clic droit = annuler
            if entity and entity ~= 0 then SetEntityDrawOutline(entity, false) end
            selected = nil
            break
        end

        Wait(0)
    end

    lib.hideTextUI()
    return selected
end

local function parseGroupsInput(input)
    if not input or input == '' then return nil end
    local arr, hash, hasGrade = {}, {}, false
    for token in input:gmatch('[^,]+') do
        local name, grade = token:match('^%s*(.-)%s*:%s*(%d+)%s*$')
        if name and grade then
            hasGrade = true
            hash[name] = tonumber(grade)
        else
            local trimmed = token:gsub('^%s+', ''):gsub('%s+$', '')
            if trimmed ~= '' then arr[#arr+1] = trimmed end
        end
    end
    if hasGrade then return hash end
    if #arr > 0 then return arr end
    return nil
end

local function createDoorAdvanced(firstEntity)
    local firstData, err = _captureDoorData(firstEntity)
    if not firstData then
        Notification("Doorlock", "❌ " .. (err or "Objet invalide."), 3500)
        return
    end

    local input = lib.inputDialog("Créer une porte", {
        { type = 'checkbox', label = 'Porte double ?', default = false },
        { type = 'input', label = 'Nom de l\'item requis (optionnel)' },
        { type = 'checkbox', label = 'Consommer l\'item ?', default = false },
        { type = 'input', label = 'Code d\'accès (optionnel)' },
        { type = 'input', label = 'Jobs/Groupes (séparés par des virgules, ex: police,ambulance ou police:2)' },
        { type = 'number', label = 'Distance max', default = 2.0 },
        { type = 'checkbox', label = 'Verrouillée par défaut', default = true },
        { type = 'number', label = 'Autolock (secondes, 0 pour désactiver)', default = 0 }
    })

    if not input then return end

    local isDouble = input[1] == true
    local accessType = input[2]
    local itemName = input[3]
    local itemConsume = input[4] == true
    local passcode = input[5]
    local groupsRaw = input[6]
    local maxDistance = tonumber(input[7]) or 2.0
    local lockedDefault = input[8] == true
    local autolockSeconds = tonumber(input[9]) or 0

    local secondData = nil
    if isDouble then
        secondData = selectSecondDoor()
        if not secondData then
            Notification("Doorlock", "❌ Seconde porte non sélectionnée.", 3500)
            return
        end
    end

    local data = {
        name = ("porte %s"):format(tostring(firstData.coords)),
        state = lockedDefault and 1 or 0,
        maxDistance = maxDistance,
        auto = true
    }

    if isDouble and secondData then
        data.doors = {
            {
                coords = firstData.coords,
                heading = firstData.heading,
                model = firstData.model,
            },
            {
                coords = secondData.coords,
                heading = secondData.heading,
                model = secondData.model,
            }
        }
    else
        data.model = firstData.model
        data.coords = firstData.coords
        data.heading = firstData.heading
    end

    if autolockSeconds and autolockSeconds > 0 then
        data.autolock = autolockSeconds
    end

    if accessType == 'item' and itemName and itemName ~= '' then
        data.items = { { name = itemName, remove = itemConsume } }
    elseif accessType == 'code' and passcode and passcode ~= '' then
        data.passcode = passcode
    elseif accessType == 'job' and groupsRaw and groupsRaw ~= '' then
        data.groups = parseGroupsInput(groupsRaw)
    end

    TriggerServerEvent('ox_doorlock:editDoorlock', false, data)
    Notification("Doorlock", isDouble and "✅ Porte double créée." or "✅ Porte créée.", 3000)
end

ECM:Register(function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    if not hitSomething or not hitEntity or hitEntity == 0 or GetEntityType(hitEntity) ~= 3 then
        return
    end

    local ok, modelName = pcall(function()
        return GetEntityArchetypeName(hitEntity)
    end)
    local nameLower = (ok and type(modelName) == 'string') and modelName:lower() or ''
    local isDoorByName = nameLower:find('^door_') or nameLower:find('^prop_door_') or nameLower:find('door') or nameLower:find('gate')

    local hasDoorlock = false
    local ok2, idOrNil = pcall(function()
        return exports.ox_doorlock:getDoorIdFromEntity(hitEntity)
    end)
    if ok2 and idOrNil then hasDoorlock = true end

    if not isDoorByName and not hasDoorlock then
        return
    end

    local submenu = ECM:AddSubmenu(0, "Doorlock")
    local advSub, advItem = ECM:AddSubmenu(submenu, "Créer une porte")

    local isDouble = doorlockAdvState.isDouble
    local accessType = doorlockAdvState.accessType
    local itemName, itemConsume = doorlockAdvState.itemName, doorlockAdvState.itemConsume
    local passcode = doorlockAdvState.passcode
    local selectedGroups = {
        police = doorlockAdvState.selectedGroups and doorlockAdvState.selectedGroups.police or false,
        ambulance = doorlockAdvState.selectedGroups and doorlockAdvState.selectedGroups.ambulance or false
    }
    local minGrade = doorlockAdvState.minGrade
    local groupsRaw = doorlockAdvState.groupsRaw
    local maxDistance = doorlockAdvState.maxDistance or 2.0
    local lockedDefault = doorlockAdvState.lockedDefault ~= false
    local autolockSeconds = doorlockAdvState.autolockSeconds or 0

    local doubleChk = ECM:AddCheckboxItem(advSub, "Porte double ?", isDouble)
    ECM:OnValueChanged(doubleChk, function(checked)
        isDouble = checked and true or false
        doorlockAdvState.isDouble = isDouble
    end)

    local typeSub, typeItem = ECM:AddSubmenu(advSub, "Type d'accès")
    local function setAccessType(label, value)
        accessType = value
        SafeRightText(typeItem, label)
    end
    local aNone = ECM:AddItem(typeSub, "Aucun")
    ECM:OnActivate(aNone, function()
        accessType = 'aucun'
        itemName, itemConsume = nil, false
        passcode = nil
        groupsRaw = nil
        doorlockAdvState.accessType = accessType
        doorlockAdvState.itemName = itemName
        doorlockAdvState.itemConsume = itemConsume
        doorlockAdvState.passcode = passcode
        doorlockAdvState.groupsRaw = groupsRaw
        SafeRightText(typeItem, "Aucun")
        SafeRightText(itemParent, "aucun")
        SafeRightText(codeParent, "aucun")
        updateGroupsRightText()
    end)
    local aItem = ECM:AddItem(typeSub, "Item")
    ECM:OnActivate(aItem, function()
        local inp = lib.inputDialog("Item requis", {
            { type = 'input', label = "Nom de l'item" },
            { type = 'checkbox', label = "Consommer l'item ?", default = itemConsume }
        })
        if inp then
            itemName = inp[1] ~= '' and inp[1] or nil
            itemConsume = inp[2] == true
            passcode = nil
            groupsRaw = nil
            accessType = 'item'
            doorlockAdvState.accessType = accessType
            doorlockAdvState.itemName = itemName
            doorlockAdvState.itemConsume = itemConsume
            doorlockAdvState.passcode = passcode
            doorlockAdvState.groupsRaw = groupsRaw
            SafeRightText(typeItem, itemName and ("Item: " .. itemName) or "Item")
            SafeRightText(itemParent, itemName or "aucun")
        end
    end)
    local aCode = ECM:AddItem(typeSub, "Code")
    ECM:OnActivate(aCode, function()
        local inp = lib.inputDialog("Code d'accès", {
            { type = 'input', label = 'Code' }
        })
        if inp then
            passcode = inp[1] ~= '' and inp[1] or nil
            itemName, itemConsume = nil, false
            groupsRaw = nil
            accessType = 'code'
            doorlockAdvState.accessType = accessType
            doorlockAdvState.itemName = itemName
            doorlockAdvState.itemConsume = itemConsume
            doorlockAdvState.passcode = passcode
            doorlockAdvState.groupsRaw = groupsRaw
            SafeRightText(typeItem, passcode and ("Code: " .. passcode) or "Code")
            SafeRightText(codeParent, passcode or "aucun")
        end
    end)
    local aJob = ECM:AddItem(typeSub, "Job/Groupe")
    ECM:OnActivate(aJob, function()
        local inp = lib.inputDialog("Jobs/Groupes autorisés", {
            { type = 'input', label = "Jobs/Groupes (ex: police,ambulance ou police:2)" }
        })
        if inp then
            groupsRaw = inp[1]
            itemName, itemConsume = nil, false
            passcode = nil
            accessType = 'job'
            doorlockAdvState.accessType = accessType
            doorlockAdvState.itemName = itemName
            doorlockAdvState.itemConsume = itemConsume
            doorlockAdvState.passcode = passcode
            doorlockAdvState.groupsRaw = groupsRaw
            SafeRightText(typeItem, "Job/Groupe")
            updateGroupsRightText()
        end
    end)

    local distSub, distParent = ECM:AddSubmenu(advSub, "Distance max")
    local function setDistance(v)
        maxDistance = v
        doorlockAdvState.maxDistance = maxDistance
        SafeRightText(distParent, tostring(v))
    end
    SafeRightText(distParent, tostring(maxDistance))
    local d2 = ECM:AddItem(distSub, "2.0")
    ECM:OnActivate(d2, function() setDistance(2.0) end)
    local d3 = ECM:AddItem(distSub, "3.0")
    ECM:OnActivate(d3, function() setDistance(3.0) end)
    local d5 = ECM:AddItem(distSub, "5.0")
    ECM:OnActivate(d5, function() setDistance(5.0) end)

    local lockedChk = ECM:AddCheckboxItem(advSub, "Verrouillée par défaut", lockedDefault)
    ECM:OnValueChanged(lockedChk, function(checked)
        lockedDefault = checked and true or false
        doorlockAdvState.lockedDefault = lockedDefault
    end)

    local autoSub, autoParent = ECM:AddSubmenu(advSub, "Autolock (sec)")
    local function setAutolock(v)
        autolockSeconds = v
        doorlockAdvState.autolockSeconds = autolockSeconds
        SafeRightText(autoParent, tostring(v))
    end
    SafeRightText(autoParent, tostring(autolockSeconds))

    if accessType == 'item' then
        SafeRightText(typeItem, itemName and ("Item: " .. itemName) or "Item")
    elseif accessType == 'code' then
        SafeRightText(typeItem, passcode and ("Code: " .. passcode) or "Code")
    elseif accessType == 'job' then
        SafeRightText(typeItem, "Job/Groupe")
    else
        SafeRightText(typeItem, "Aucun")
    end
    local a0 = ECM:AddItem(autoSub, "0 (désactivé)")
    ECM:OnActivate(a0, function() setAutolock(0) end)
    local a10 = ECM:AddItem(autoSub, "10")
    ECM:OnActivate(a10, function() setAutolock(10) end)
    local a30 = ECM:AddItem(autoSub, "30")
    ECM:OnActivate(a30, function() setAutolock(30) end)
    local a60 = ECM:AddItem(autoSub, "60")
    ECM:OnActivate(a60, function() setAutolock(60) end)

    local advCreate = ECM:AddItem(advSub, "Créer")
    ECM:OnActivate(advCreate, function()
        local firstData, err = _captureDoorData(hitEntity)
        if not firstData then
            return Notification("Doorlock", "❌ " .. (err or "Objet invalide."), 3500)
        end

        local secondData = nil
        if isDouble then
            secondData = selectSecondDoor()
            if not secondData then
                return Notification("Doorlock", "❌ Seconde porte non sélectionnée.", 3500)
            end
        end

        local data = {
            name = ("porte %s"):format(tostring(firstData.coords)),
            state = lockedDefault and 1 or 0,
            maxDistance = maxDistance,
            auto = true
        }

        if secondData then
            data.doors = {
                { coords = firstData.coords, heading = firstData.heading, model = firstData.model },
                { coords = secondData.coords, heading = secondData.heading, model = secondData.model }
            }
        else
            data.model = firstData.model
            data.coords = firstData.coords
            data.heading = firstData.heading
        end

        if autolockSeconds and autolockSeconds > 0 then
            data.autolock = autolockSeconds
        end

        if accessType == 'item' and itemName then
            data.items = { { name = itemName, remove = itemConsume } }
        elseif accessType == 'code' and passcode then
            data.passcode = passcode
        elseif accessType == 'job' then
            if groupsRaw and groupsRaw ~= '' then
                data.groups = parseGroupsInput(groupsRaw)
            else
                local count = (selectedGroups.police and 1 or 0) + (selectedGroups.ambulance and 1 or 0)
                if count > 0 then
                    if minGrade ~= nil then
                        local hash = {}
                        if selectedGroups.police then hash.police = minGrade end
                        if selectedGroups.ambulance then hash.ambulance = minGrade end
                        data.groups = hash
                    else
                        local arr = {}
                        if selectedGroups.police then arr[#arr+1] = 'police' end
                        if selectedGroups.ambulance then arr[#arr+1] = 'ambulance' end
                        data.groups = arr
                    end
                end
            end
        end

        TriggerServerEvent('ox_doorlock:editDoorlock', false, data)
        Notification("Doorlock", secondData and "✅ Porte double créée." or "✅ Porte créée.", 3000)
    end)

    local toggleItem = ECM:AddItem(submenu, "Basculer porte la plus proche")
    ECM:OnActivate(toggleItem, function()
        toggleClosestDoor()
    end)

    local openItem = ECM:AddItem(submenu, "Ouvrir la porte ciblée")
    ECM:OnActivate(openItem, function()
        if not hitEntity or hitEntity == 0 then
            return Notification("Doorlock", "❌ Aucun objet sous le curseur.", 3500)
        end
        local id = exports.ox_doorlock:getDoorIdFromEntity(hitEntity)
        if not id then
            return Notification("Doorlock", "❌ Aucune porte enregistrée sur cet objet.", 3500)
        end
        TriggerServerEvent('ox_doorlock:setState', id, 0)
        Notification("Doorlock", "🔓 Porte déverrouillée (ouverte).", 3000)
    end)

    local closeItem = ECM:AddItem(submenu, "Fermer la porte ciblée")
    ECM:OnActivate(closeItem, function()
        if not hitEntity or hitEntity == 0 then
            return Notification("Doorlock", "❌ Aucun objet sous le curseur.", 3500)
        end
        local id = exports.ox_doorlock:getDoorIdFromEntity(hitEntity)
        if not id then
            return Notification("Doorlock", "❌ Aucune porte enregistrée sur cet objet.", 3500)
        end
        TriggerServerEvent('ox_doorlock:setState', id, 1)
        Notification("Doorlock", "🔒 Porte verrouillée (fermée).", 3000)
    end)

    local deleteItem = ECM:AddItem(submenu, "Supprimer la porte ciblée")
    ECM:OnActivate(deleteItem, function()
        deleteDoorFromEntity(hitEntity)
    end)

    local editItem = ECM:AddItem(submenu, "Modifier la porte ciblée")
    ECM:OnActivate(editItem, function()
        if not hitEntity or hitEntity == 0 then
            return Notification("Doorlock", "❌ Aucun objet sous le curseur.", 3500)
        end

        local id = exports.ox_doorlock:getDoorIdFromEntity(hitEntity)
        if not id then
            return Notification("Doorlock", "❌ Aucune porte enregistrée sur cet objet.", 3500)
        end
        TriggerEvent('ox_doorlock:triggeredCommand', true)
    end)
end)

