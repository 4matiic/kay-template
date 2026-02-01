local outfitCache = {}
local uniformCache = {}

local function getMoneyForShop(shopType)
    local money = 0
    if shopType == "clothing" then
        money = Config.ClothingCost
    elseif shopType == "barber" then
        money = Config.BarberCost
    elseif shopType == "tattoo" then
        money = Config.TattooCost
    elseif shopType == "surgeon" then
        money = Config.SurgeonCost
    end

    return money
end

local function GetImageUrl(componentType, gender, drawable)
    local baseType
    local folderMap = {
        ["torso_1"] = "torso",
        ["tshirt_1"] = "tshirt",
        ["pants_1"] = "pants",
        ["shoes_1"] = "shoes",
        ["arms"] = "arms",
        ["helmet_1"] = "helmet", 
        ["glasses_1"] = "glasses",
        ["ears_1"] = "ears",
        ["mask_1"] = "mask",
        ["bags_1"] = "Bags",
        ["bproof_1"] = "bproof",
        ["decals_1"] = "decals",
        ["chain_1"] = "chain",
        ["watches_1"] = "watches",
        ["bracelets_1"] = "bracelets"
    }
    
    if gender ~= "male" and gender ~= "female" then
        gender = "male"
    end
    
    local shortGender = (gender == "male") and "m" or "f"
    
    if type(componentType) == "number" then
        if componentType == 1 then baseType = "mask"
        elseif componentType == 3 then baseType = "arms"
        elseif componentType == 4 then baseType = "pants"
        elseif componentType == 5 then baseType = "Bags"
        elseif componentType == 6 then baseType = "shoes"
        elseif componentType == 7 then baseType = "chain"
        elseif componentType == 8 then baseType = "tshirt"
        elseif componentType == 9 then baseType = "bproof"
        elseif componentType == 10 then baseType = "decals"
        elseif componentType == 11 then baseType = "torso"
        end
    else
        baseType = componentType:gsub("_1", "")
        
        if folderMap[componentType] then
            baseType = folderMap[componentType]
        end
    end
    
    if not baseType then
        baseType = "torso" 
    end
    
    local url = string.format(
        "https://raw.githubusercontent.com/toadrouge/library/master/items/%s/%s/%s_.png",
        baseType,
        shortGender,
        tostring(drawable)
    )
    
    return url
end

local function getOutfitsForPlayer(citizenid)
    outfitCache[citizenid] = {}
    local result = Database.PlayerOutfits.GetAllByCitizenID(citizenid)
    for i = 1, #result, 1 do
        outfitCache[citizenid][#outfitCache[citizenid] + 1] = {
            id = result[i].id,
            name = result[i].outfitname,
            model = result[i].model,
            components = json.decode(result[i].components),
            props = json.decode(result[i].props)
        }
    end
end

local function GenerateUniqueCode()
    local code, exists
    repeat
        code = GenerateNanoID(Config.OutfitCodeLength)
        exists = Database.PlayerOutfitCodes.GetByCode(code)
    until not exists
    return code
end

-- Callback(s)

lib.callback.register("illenium-appearance:server:generateOutfitCode", function(_, outfitID)
    local existingOutfitCode = Database.PlayerOutfitCodes.GetByOutfitID(outfitID)
    if not existingOutfitCode then
        local code = GenerateUniqueCode()
        local id = Database.PlayerOutfitCodes.Add(outfitID, code)
        if not id then
            print("Something went wrong while generating outfit code")
            return
        end
        return code
    end
    return existingOutfitCode.code
end)

lib.callback.register("illenium-appearance:server:importOutfitCode", function(source, outfitName, outfitCode)
    local citizenID = Framework.GetPlayerID(source)
    local existingOutfitCode = Database.PlayerOutfitCodes.GetByCode(outfitCode)
    if not existingOutfitCode then
        return nil
    end

    local playerOutfit = Database.PlayerOutfits.GetByID(existingOutfitCode.outfitid)
    if not playerOutfit then
        return
    end

    if playerOutfit.citizenid == citizenID then return end 
    if Database.PlayerOutfits.GetByOutfit(outfitName, citizenID) then return end 

    local id = Database.PlayerOutfits.Add(citizenID, outfitName, playerOutfit.model, playerOutfit.components, playerOutfit.props)

    if not id then
        print("Something went wrong while importing the outfit")
        return
    end

    outfitCache[citizenID][#outfitCache[citizenID] + 1] = {
        id = id,
        name = outfitName,
        model = playerOutfit.model,
        components = json.decode(playerOutfit.components),
        props = json.decode(playerOutfit.props)
    }

    return true
end)

lib.callback.register("illenium-appearance:server:getAppearance", function(source, model)
    local citizenID = Framework.GetPlayerID(source)
    return Framework.GetAppearance(citizenID, model)
end)

lib.callback.register("illenium-appearance:server:hasMoney", function(source, shopType)
    local money = getMoneyForShop(shopType)
    if Framework.HasMoney(source, "cash", money) then
        return true, money
    else
        return false, money
    end
end)

lib.callback.register("illenium-appearance:server:payForTattoo", function(source, tattoo)
    local src = source
    local cost = tattoo.cost or Config.TattooCost

    if Framework.RemoveMoney(src, "cash", cost) then
        lib.notify(src, {
            title = _L("purchase.tattoo.success.title"),
            description = string.format(_L("purchase.tattoo.success.description"), tattoo.label, cost),
            type = "success",
            position = Config.NotifyOptions.position
        })
        return true
    else
        lib.notify(src, {
            title = _L("purchase.tattoo.failure.title"),
            description = _L("purchase.tattoo.failure.description"),
            type = "error",
            position = Config.NotifyOptions.position
        })
        return false
    end
end)

lib.callback.register("illenium-appearance:server:getOutfits", function(source)
    local citizenID = Framework.GetPlayerID(source)
    if outfitCache[citizenID] == nil then
        getOutfitsForPlayer(citizenID)
    end
    
    if outfitCache[citizenID] == nil then
        outfitCache[citizenID] = {}
    end
    
    return outfitCache[citizenID]
end)

lib.callback.register("illenium-appearance:server:getManagementOutfits", function(source, mType, gender)
    local job = Framework.GetJob(source)
    if mType == "Gang" then
        job = Framework.GetGang(source)
    end

    local grade = tonumber(job.grade.level)
    local managementOutfits = {}
    local result = Database.ManagementOutfits.GetAllByJob(mType, job.name, gender)

    for i = 1, #result, 1 do
        if grade >= result[i].minrank then
            managementOutfits[#managementOutfits + 1] = {
                id = result[i].id,
                name = result[i].name,
                model = result[i].model,
                gender = result[i].gender,
                components = json.decode(result[i].components),
                props = json.decode(result[i].props)
            }
        end
    end
    return managementOutfits
end)

lib.callback.register("illenium-appearance:server:getUniform", function(source)
    return uniformCache[Framework.GetPlayerID(source)]
end)

RegisterServerEvent("illenium-appearance:server:saveAppearance", function(appearance)
    local src = source
    local citizenID = Framework.GetPlayerID(src)
    if appearance ~= nil then
        Framework.SaveAppearance(appearance, citizenID)
    end
end)

RegisterServerEvent("illenium-appearance:server:chargeCustomer", function(shopType)
    local src = source
    local money = getMoneyForShop(shopType)
    if Framework.RemoveMoney(src, "cash", money) then
        lib.notify(src, {
            title = _L("purchase.store.success.title"),
            description = string.format(_L("purchase.store.success.description"), money, shopType),
            type = "success",
            position = Config.NotifyOptions.position
        })
    else
        lib.notify(src, {
            title = _L("purchase.store.failure.title"),
            description = _L("purchase.store.failure.description"),
            type = "error",
            position = Config.NotifyOptions.position
        })
    end
end)

RegisterServerEvent("illenium-appearance:server:saveClothingItems", function(appearance, changedItems)
    local src = source
    local playerPed = GetPlayerPed(src)
    local money = getMoneyForShop("clothing")
    local playerModel = GetEntityModel(playerPed)
    local isMale = playerModel == `mp_m_freemode_01`
    local gender = isMale and "male" or "female"
    
    local itemPrice = #changedItems > 0 and math.ceil(money / #changedItems) or money
    local totalCost = itemPrice * #changedItems
    
    if Framework.RemoveMoney(src, "cash", totalCost) then
        local citizenID = Framework.GetPlayerID(src)
        if appearance then
            Framework.SaveAppearance(appearance, citizenID)
        end
        
        for _, item in ipairs(changedItems) do
            local itemType, itemData, componentId, drawable, texture, compType
            
            if item.componentId then
                componentId = item.componentId
                if Config.ClothingComponents[componentId] then
                    itemType = Config.ClothingComponents[componentId].type
                    itemData = Config.ClothingComponents[componentId]
                end
                drawable = item.drawable
                texture = item.texture
                
                if componentId == 1 then compType = "mask_1"
                elseif componentId == 3 then compType = "arms"
                elseif componentId == 4 then compType = "pants_1"
                elseif componentId == 5 then compType = "bags_1"
                elseif componentId == 6 then compType = "shoes_1"
                elseif componentId == 7 then compType = "chain_1"
                elseif componentId == 8 then compType = "tshirt_1"
                elseif componentId == 9 then compType = "bproof_1"
                elseif componentId == 10 then compType = "decals_1"
                elseif componentId == 11 then compType = "torso_1"
                end
            elseif item.propId then
                componentId = item.propId
                if Config.ClothingProps[componentId] then
                    itemType = Config.ClothingProps[componentId].type
                    itemData = Config.ClothingProps[componentId]
                end
                drawable = item.drawable
                texture = item.texture
                
                if componentId == 0 then compType = "helmet_1"
                elseif componentId == 1 then compType = "glasses_1"
                elseif componentId == 2 then compType = "ears_1"
                elseif componentId == 6 then compType = "watches_1"
                elseif componentId == 7 then compType = "bracelets_1"
                end
            end
            
            if itemType and itemData then
                local imageUrl = GetImageUrl(compType or componentId, gender, drawable)
                
                local metadata = {
                    component = componentId,
                    drawable = drawable,
                    texture = texture,
                    label = string.format("%s #%s", itemData.label, drawable),
                    description = string.format("Variation %s, Texture %s", drawable, texture),
                    gender = gender,
                    imageurl = imageUrl 
                }
                
                if item.propId then
                    metadata.isProp = true
                end
                
                exports.ox_inventory:AddItem(src, itemType, 1, metadata)
            end
        end
        
        lib.notify(src, {
            title = _L("purchase.store.success.title"),
            description = string.format(_L("purchase.store.success.description"), totalCost, "clothing"),
            type = "success",
            position = Config.NotifyOptions.position
        })
    else
        lib.notify(src, {
            title = _L("purchase.store.failure.title"),
            description = _L("purchase.store.failure.description"),
            type = "error",
            position = Config.NotifyOptions.position
        })
    end
end)

RegisterNetEvent("illenium-appearance:server:saveOutfit", function(name, model, components, props)
    local src = source
    local citizenID = Framework.GetPlayerID(src)
    if outfitCache[citizenID] == nil then
        getOutfitsForPlayer(citizenID)
    end
    if model and components and props then
        local id = Database.PlayerOutfits.Add(citizenID, name, model, json.encode(components), json.encode(props))
        if not id then
            return
        end
        outfitCache[citizenID][#outfitCache[citizenID] + 1] = {
            id = id,
            name = name,
            model = model,
            components = components,
            props = props
        }
        
        if Config.SaveClothesAsItems then
            local playerPed = GetPlayerPed(src)
            local playerModel = GetEntityModel(playerPed)
            local isMale = playerModel == `mp_m_freemode_01`
            local gender = isMale and "male" or "female"
            
            local skinData = {}
            
            for _, component in ipairs(components) do
                skinData['comp'..component.component_id] = component.drawable
                skinData['comp'..component.component_id..'_2'] = component.texture
            end
            
            for _, prop in ipairs(props) do
                skinData['prop'..prop.prop_id] = prop.drawable
                skinData['prop'..prop.prop_id..'_2'] = prop.texture
            end
            
            local metadata = {
                outfit = skinData,
                label = name,
                description = "Une tenue complète personnalisée",
                gender = gender,
                imageurl = "nui://ox_inventory/web/images/cloth.png" 
            }
            
            local componentSelection = {}
            for _, component in ipairs(components) do
                local compType
                
                if component.component_id == 1 then compType = "mask_1"
                elseif component.component_id == 3 then compType = "arms"
                elseif component.component_id == 4 then compType = "pants_1"
                elseif component.component_id == 5 then compType = "bags_1"
                elseif component.component_id == 6 then compType = "shoes_1"
                elseif component.component_id == 7 then compType = "chain_1"
                elseif component.component_id == 8 then compType = "tshirt_1"
                elseif component.component_id == 9 then compType = "bproof_1"
                elseif component.component_id == 10 then compType = "decals_1"
                elseif component.component_id == 11 then compType = "torso_1"
                end
                
                if compType then
                    componentSelection[compType] = {
                        index = component.drawable + 1,
                        texture = component.texture
                    }
                end
            end
            
            for _, prop in ipairs(props) do
                local propType
                
                if prop.prop_id == 0 then propType = "helmet_1"
                elseif prop.prop_id == 1 then propType = "glasses_1"
                elseif prop.prop_id == 2 then propType = "ears_1"
                elseif prop.prop_id == 6 then propType = "watches_1"
                elseif prop.prop_id == 7 then propType = "bracelets_1"
                end
                
                if propType then
                    componentSelection[propType] = {
                        index = prop.drawable + 1,
                        texture = prop.texture
                    }
                end
            end
            
            metadata.components = componentSelection
            
            exports.ox_inventory:AddItem(src, 'cloth', 1, metadata)
        end
        
        lib.notify(src, {
            title = _L("outfits.save.success.title"),
            description = string.format(_L("outfits.save.success.description"), name),
            type = "success",
            position = Config.NotifyOptions.position
        })
    end
end)

RegisterNetEvent("illenium-appearance:server:updateOutfit", function(id, model, components, props)
    local src = source
    local citizenID = Framework.GetPlayerID(src)
    if outfitCache[citizenID] == nil then
        getOutfitsForPlayer(citizenID)
    end
    if model and components and props then
        if not Database.PlayerOutfits.Update(id, model, json.encode(components), json.encode(props)) then return end
        local outfitName = ""
        for i = 1, #outfitCache[citizenID], 1 do
            local outfit = outfitCache[citizenID][i]
            if outfit.id == id then
                outfit.model = model
                outfit.components = components
                outfit.props = props
                outfitName = outfit.name
                break
            end
        end
        lib.notify(src, {
            title = _L("outfits.update.success.title"),
            description = string.format(_L("outfits.update.success.description"), outfitName),
            type = "success",
            position = Config.NotifyOptions.position
        })
    end
end)

RegisterNetEvent("illenium-appearance:server:saveManagementOutfit", function(outfitData)
    local src = source
    local id = Database.ManagementOutfits.Add(outfitData)
    if not id then
        return
    end

    lib.notify(src, {
        title = _L("outfits.save.success.title"),
            description = string.format(_L("outfits.save.success.description"), outfitData.Name),
        type = "success",
        position = Config.NotifyOptions.position
    })
end)

RegisterNetEvent("illenium-appearance:server:deleteManagementOutfit", function(id)
    Database.ManagementOutfits.DeleteByID(id)
end)

RegisterNetEvent("illenium-appearance:server:syncUniform", function(uniform)
    local src = source
    uniformCache[Framework.GetPlayerID(src)] = uniform
end)

RegisterNetEvent("illenium-appearance:server:deleteOutfit", function(id)
    local src = source
    local citizenID = Framework.GetPlayerID(src)
    Database.PlayerOutfitCodes.DeleteByOutfitID(id)
    Database.PlayerOutfits.DeleteByID(id)

    for k, v in ipairs(outfitCache[citizenID]) do
        if v.id == id then
            table.remove(outfitCache[citizenID], k)
            break
        end
    end
end)

RegisterNetEvent("illenium-appearance:server:resetOutfitCache", function()
    local src = source
    local citizenID = Framework.GetPlayerID(src)
    if citizenID then
        outfitCache[citizenID] = nil
    end
end)

RegisterNetEvent("illenium-appearance:server:ChangeRoutingBucket", function()
    local src = source
    SetPlayerRoutingBucket(src, src)
end)

RegisterNetEvent("illenium-appearance:server:ResetRoutingBucket", function()
    local src = source
    SetPlayerRoutingBucket(src, 0)
end)

if Config.EnablePedMenu then
    lib.addCommand("pedmenu", {
        help = _L("commands.pedmenu.title"),
        params = {
            {
                name = "playerID",
                type = "number",
                help = "Target player's server id",
                optional = true
            },
        },
        restricted = Config.PedMenuGroup
    }, function(source, args)
        local target = source
        if args.playerID then
            local citizenID = Framework.GetPlayerID(args.playerID)
            if citizenID then
                target = args.playerID
            else
                lib.notify(source, {
                    title = _L("commands.pedmenu.failure.title"),
                    description = _L("commands.pedmenu.failure.description"),
                    type = "error",
                    position = Config.NotifyOptions.position
                })
                return
            end
        end
        TriggerClientEvent("illenium-appearance:client:openClothingShopMenu", target, true)
    end)
end

if Config.EnableJobOutfitsCommand then
    lib.addCommand("joboutfits", { help = _L("commands.joboutfits.title"), }, function(source)
        TriggerClientEvent("illenium-apearance:client:outfitsCommand", source, true)
    end)

    lib.addCommand("gangoutfits", { help = _L("commands.gangoutfits.title"), }, function(source)
        TriggerClientEvent("illenium-apearance:client:outfitsCommand", source)
    end)
end

lib.addCommand("reloadskin", { help = _L("commands.reloadskin.title") }, function(source)
    TriggerClientEvent("illenium-appearance:client:reloadSkin", source)
end)

lib.addCommand("clearstuckprops", { help = _L("commands.clearstuckprops.title") }, function(source)
    TriggerClientEvent("illenium-appearance:client:ClearStuckProps", source)
end)

lib.versionCheck("iLLeniumStudios/illenium-appearance")


