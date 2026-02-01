ESX = exports["framework"]:getSharedObject()


local function GeneratePlate()
    local charset = {}
    for i = 48, 57 do table.insert(charset, string.char(i)) end -- 0-9
    for i = 65, 90 do table.insert(charset, string.char(i)) end -- A-Z

    math.randomseed(GetGameTimer())

    return string.upper(string.format("%s%s%s%d%d%d", 
        charset[math.random(#charset)], 
        charset[math.random(#charset)], 
        charset[math.random(#charset)], 
        math.random(0,9), 
        math.random(0,9), 
        math.random(0,9)
    ))
end

RegisterNetEvent("admin:toggleBlipsForAll", function(state)
    TriggerClientEvent("admin:setBlips", -1, state)
end)




RegisterNetEvent('ContextMenu:Player:Notify', function(target, soustitre, msg)
    TriggerClientEvent('ContextMenu:Player:Notify', target, soustitre, msg)
end)

RegisterNetEvent('ContextMenu:Misc:CreatePed', function(modelHash, worldPosition, heading)
    CreatePed(nil, modelHash, worldPosition, heading, true)
end)

RegisterNetEvent('ContextMenu:Player:Command', function(target, command)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer and xPlayer.group ~= 'user' then
        TriggerClientEvent('ContextMenu:Player:Command', target, command)
    end
end)

RegisterServerEvent('ContextMenu:Vehicle:Delete')
AddEventHandler('ContextMenu:Vehicle:Delete', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end
end)

RegisterServerEvent('ContextMenu:Vehicle:Repair')
AddEventHandler('ContextMenu:Vehicle:Repair', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        TriggerClientEvent('ContextMenu:Vehicle:Repair', NetworkGetEntityOwner(vehicle), netId)
    end
end)

RegisterServerEvent('ContextMenu:Vehicle:Wash')
AddEventHandler('ContextMenu:Vehicle:Wash', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        SetVehicleDirtLevel(vehicle, 0.0)
    end
end)

RegisterServerEvent('ContextMenu:Vehicle:Salir')
AddEventHandler('ContextMenu:Vehicle:Salir', function(netId, Chiffre)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        SetVehicleDirtLevel(vehicle, 15.0)
    end
end)

 
local function officerIsMechanic(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer and xPlayer.job and xPlayer.job.name == 'mechanic'
end

RegisterNetEvent('context:mechanic:repairWithKit', function(netId)
    local src = source
    if not officerIsMechanic(src) then return end
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(vehicle) then return end

    local hasKit = false
    local inv = exports.ox_inventory:GetInventoryItems(src)
    if inv then
        for _, item in pairs(inv) do
            if item and item.name == 'fixkit' and (item.count or 0) > 0 then
                hasKit = true
                break
            end
        end
    end

    if not hasKit then
        TriggerClientEvent("kay_context:notify", src, "~g~ Vous n'avez pas de fixkit.")
        return
    end

    exports.ox_inventory:RemoveItem(src, 'fixkit', 1)
    TriggerClientEvent('ContextMenu:Vehicle:Repair', NetworkGetEntityOwner(vehicle), netId)
    TriggerClientEvent("kay_context:notify", src, "~g~ Véhicule réparé avec un kit.")
end)

RegisterNetEvent('context:mechanic:wash', function(netId)
    local src = source
    if not officerIsMechanic(src) then return end
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        SetVehicleDirtLevel(vehicle, 0.0)
        TriggerClientEvent("kay_context:notify", src, "~g~ Véhicule nettoyé.")
    end
end)

RegisterNetEvent('context:mechanic:impound', function(netId)
    local src = source
    if not officerIsMechanic(src) then return end
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(vehicle) then return end

    DeleteEntity(vehicle)
    TriggerClientEvent("kay_context:notify", src, "~g~ Véhicule envoyé en fourrière.")
end)
RegisterServerEvent('ContextMenu:Vehicle:Freeze')
AddEventHandler('ContextMenu:Vehicle:Freeze', function(netId, freeze)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        FreezeEntityPosition(vehicle, freeze)
    end
end)

RegisterServerEvent('ContextMenu:Vehicle:Gizmo')
AddEventHandler('ContextMenu:Vehicle:Gizmo', function(netId, gizmo)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        local entityCoords = vector3(gizmo.position.x, gizmo.position.y, gizmo.position.z)
        local entityRotation = vector3(gizmo.rotation.x, gizmo.rotation.y, gizmo.rotation.z)
        SetEntityCoords(vehicle, entityCoords)
        SetEntityRotation(vehicle, entityRotation)
    end
end)

RegisterServerEvent('ContextMenu:Vehicle:Return')
AddEventHandler('ContextMenu:Vehicle:Return', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        TriggerClientEvent('ContextMenu:Vehicle:Return', NetworkGetEntityOwner(vehicle), netId)
    end
end)

RegisterNetEvent('towing:attachVehicles', function(netVeh1, netVeh2)
    local src = source
    if not netVeh1 or not netVeh2 then return end
    if NetworkDoesEntityExistWithNetworkId(netVeh1) and NetworkDoesEntityExistWithNetworkId(netVeh2) then
        local v1 = NetworkGetEntityFromNetworkId(netVeh1)
        local v2 = NetworkGetEntityFromNetworkId(netVeh2)
        if DoesEntityExist(v1) and DoesEntityExist(v2) then
            local c1 = GetEntityCoords(v1)
            local c2 = GetEntityCoords(v2)
            if #(c1 - c2) <= 30.0 then
                TriggerClientEvent('towing:makeRope', -1, netVeh1, netVeh2)
            else
                TriggerClientEvent('kay_context:notify', src, "~r~ Véhicules trop éloignés.")
            end
        else
            TriggerClientEvent('kay_context:notify', src, "~r~ Véhicule(s) introuvable(s).")
        end
    else
        TriggerClientEvent('kay_context:notify', src, "~r~ Véhicule(s) introuvable(s).")
    end
end)

RegisterNetEvent('towing:detachVehicles')
AddEventHandler('towing:detachVehicles', function()
    TriggerClientEvent('towing:removeRope', -1)
end)

RegisterServerEvent('ContextMenu:Vehicle:TpAir500')
AddEventHandler('ContextMenu:Vehicle:TpAir500', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local c = GetEntityCoords(vehicle)
	SetEntityCoords(vehicle, c.x, c.y, 500.0)
end)
RegisterServerEvent('ContextMenu:Vehicle:TpAir1000')
AddEventHandler('ContextMenu:Vehicle:TpAir1000', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local c = GetEntityCoords(vehicle)
	SetEntityCoords(vehicle, c.x, c.y, 1000.0)
end)
RegisterServerEvent('ContextMenu:Vehicle:TpAir1500')
AddEventHandler('ContextMenu:Vehicle:TpAir1500', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local c = GetEntityCoords(vehicle)
	SetEntityCoords(vehicle, c.x, c.y, 1500.0)
end)

ESX.RegisterServerCallback('ContextMenu:Vehicle:GetInfosFromPlate', function(source, cb, plate)
    local data = {
        owner_name = 'Aucun propriétaire',
        owner_identifier = 'Aucun propriétaire'
    }
    if plate then
        local owner = MySQL.scalar.await('SELECT `owner` FROM `owned_vehicles` WHERE `plate` = ? LIMIT 1', {plate})
        if owner then
            data.owner_identifier = owner
        end

        local user = MySQL.single.await('SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = ? LIMIT 1', {data.owner_identifier})
        if user then
            data.owner_name = user.firstname .. ' ' .. user.lastname
        end
    end
    cb(data)
end)


RegisterServerEvent('ContextMenu:Vehicle:SetEntityCoords')
AddEventHandler('ContextMenu:Vehicle:SetEntityCoords', function(source, netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local player = source
    local ped = GetPlayerPed(player)
    local GetPedPos = GetEntityCoords(ped)
    print(ped)
    print(GetPedPos)
    if DoesEntityExist(vehicle) then
        SetEntityCoords(vehicle, GetPedPos)
    end
end)

lib.addCommand('kicks', {
    help = 'Kick un joueur',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'ID',
        },
        {
            name = 'kickraison',
            type = 'longString',
            help = 'Raison du kick',
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    DropPlayer(args.target, args.kickraison)
end)

lib.addCommand('kick', {
    help = 'Kick un joueur',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'ID',
        },
        {
            name = 'pseudo',
            type = 'longString',
            help = 'Votre pseudo',
        },
        {
            name = 'kickraison',
            type = 'longString',
            help = 'Raison du kick',
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    DropPlayer(args.target, "STAFF : "..args.pseudo.." "..args.kickraison)
end)

lib.addCommand('mp', {
    help = 'Envoyez un message STAFF a un joueur',
    params = {
        {
            name = 'playerId',
            type = 'number',
            help = 'Player ID',
            optional = false,
        },
        {
            name = 'message',
            type = 'longString',
            help = 'Message',
            optional = false,
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    TriggerEvent('ContextMenu:Player:Notify', args.playerId, "STAFF : "..GetPlayerName(source), "MESSAGE REÇU : "..args.message)
end)

lib.addCommand('gotoveh', {
    help = 'TP un véhicule sur soit. Nécéssite une ID',
    params = {
        {
            name = 'netId',
            type = 'number',
            help = 'NetID',
            optional = false,
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent("ConntextMenu:Vehicle:gotoveh", source, args.netId)
end)

lib.addCommand('tpveh', {
    help = 'TP un véhicule sur soit. Nécéssite une ID',
    params = {
        {
            name = 'netId',
            type = 'number',
            help = 'NetID',
            optional = false,
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    TriggerEvent("ContextMenu:Vehicle:SetEntityCoords", source, args.netId)
end)

lib.addCommand('searchitems', {
	help = 'Rechercher un item',
	params = {
		{ name = 'pattern', type = 'string', help = 'Pattern of name or label item' },
	},
	restricted = 'group.admin',
}, function(source, args)
	local ox_inventory = exports.ox_inventory
	local allitems = ox_inventory:Items()
	local table = {}
	local maxWeight = 0
	for name, item in pairs(allitems) do
		if name and item and (
			args.pattern:lower() == 'item' and 
			(not string.find(name:lower(), ('weapon_'):lower()) and 
			 not string.find(name:lower(), ('ammo-'):lower()) and 
			 not string.find(name:lower(), ('at_'):lower()))
			) or 
			string.find(name:lower(), args.pattern:lower()) or 
			string.find(item.label:lower(), args.pattern:lower()) 
		then
			table[#table+1] = {name, 500000}
			maxWeight = maxWeight + (item.weight * 500000)
		end
	end
	local stash = ox_inventory:CreateTemporaryStash({
		label = 'Item patter: ' .. args.pattern,
		slots = #table,
		maxWeight = maxWeight,
		items = table
	})
	TriggerClientEvent('ox_inventory:openInventory', source, 'stash', stash)
end)



lib.addCommand('trash', {
	help = 'Poubelle',
	params = {},
	restricted = 'group.admin',
}, function(source, args)
	local ox_inventory = exports.ox_inventory
	local stash = ox_inventory:CreateTemporaryStash({
		label = 'Poubelle',
		slots = 1000000,
		maxWeight = 1000000 * 1000000,
		items = {}
	})
	TriggerClientEvent('ox_inventory:openInventory', source, 'stash', stash)
end)

local carrying = {}
local carried = {}

RegisterServerEvent("carryPeople:sync")
AddEventHandler("carryPeople:sync", function(targetSrc)
	local source = source
	local sourcePed = GetPlayerPed(source)
   	local sourceCoords = GetEntityCoords(sourcePed)
	local targetPed = GetPlayerPed(targetSrc)
    local targetCoords = GetEntityCoords(targetPed)
	if #(sourceCoords - targetCoords) <= 3.0 then 
		TriggerClientEvent("carryPeople:syncTarget", targetSrc, source)
		carrying[source] = targetSrc
		carried[targetSrc] = source
	end
end)

RegisterServerEvent("carryPeople:stop")
AddEventHandler("carryPeople:stop", function(targetSrc)
	local source = source

	if carrying[source] then
		TriggerClientEvent("carryPeople:cl_stop", targetSrc)
		carrying[source] = nil
		carried[targetSrc] = nil
	elseif carried[source] then
		TriggerClientEvent("carryPeople:cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if carrying[source] then
		TriggerClientEvent("carryPeople:cl_stop", carrying[source])
		carried[carrying[source]] = nil
		carrying[source] = nil
	end

	if carried[source] then
		TriggerClientEvent("carryPeople:cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

RegisterNetEvent("CoreUI:revivePlayer", function(target)
    TriggerClientEvent("CoreUI:doRevive", target)
end)

RegisterNetEvent("CoreUI:clearInventory", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local inventory = exports.ox_inventory:GetInventoryItems(source)

    for _, item in pairs(inventory) do
        exports.ox_inventory:RemoveItem(source, item.name, item.count)
    end
end)


local armesDePoing = {
    "weapon_ball", "weapon_bat", "weapon_battleaxe", "weapon_bottle",
    "weapon_crowbar", "weapon_dagger", "weapon_fireextinguisher", "weapon_flare",
    "weapon_flashlight", "weapon_golfclub", "weapon_hammer", "weapon_hatchet",
    "weapon_knife", "weapon_knuckle", "weapon_machete", "weapon_molotov",
    "weapon_nightstick", "weapon_poolcue", "weapon_snowball", "weapon_stone_hatchet", 
    "weapon_switchblade", "weapon_wrench",
}

local armesFeuLongues = {
    "weapon_advancedrifle", "weapon_appistol", "weapon_assaultrifle", "weapon_assaultrifle_mk2",
    "weapon_specialcarbine", "weapon_specialcarbine_mk2", "weapon_bullpuprifle", "weapon_bullpuprifle_mk2",
    "weapon_microsmg", "weapon_smg", "weapon_smg_mk2", "weapon_assaultsmg", "weapon_mg", "weapon_combatmg",
    "weapon_combatmg_mk2", "weapon_heavysniper", "weapon_heavysniper_mk2", "weapon_sniperrifle",
    "weapon_marksmanrifle", "weapon_marksmanrifle_mk2", "weapon_pumpshotgun", "weapon_autoshotgun",
    "weapon_assaultshotgun", "weapon_bullpupshotgun", "weapon_heavyshotgun", "weapon_sawnoffshotgun",
    "weapon_dbshotgun"
}


RegisterNetEvent('ContextMenu:BuyGrise')
AddEventHandler('ContextMenu:BuyGrise', function(plate, modelOrProps)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local identifier = xPlayer.getIdentifier()

    if not plate or plate == '' then
        TriggerClientEvent('esx:showNotification', src, '~r~Plaque invalide.')
        return
    end

    local vehJson
    local modelVal
    if type(modelOrProps) == 'table' then
        modelOrProps.plate = plate
        vehJson = json.encode(modelOrProps)
        modelVal = modelOrProps.model
    else
        vehJson = json.encode({ plate = plate, model = modelOrProps })
        modelVal = modelOrProps
    end

    local exists = MySQL.scalar.await('SELECT 1 FROM `owned_vehicles` WHERE `plate` = ? LIMIT 1', {plate})
    if exists then
        MySQL.update.await('UPDATE `owned_vehicles` SET `owner` = ?, `vehicle` = ? WHERE `plate` = ? LIMIT 1', {identifier, vehJson, plate})
    else
        MySQL.insert.await('INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`) VALUES (?, ?, ?)', {identifier, plate, vehJson})
    end

    TriggerClientEvent('esx:showNotification', src, ('~g~Carte grise créée/transférée pour %s'):format(plate))

    TriggerClientEvent('_CH:_CH_CREATE_GREY_CARD', src, plate, {
        owner = identifier,
        model = modelVal,
        plate = plate
    })
end)

RegisterNetEvent('custom:getCarKey')
AddEventHandler('custom:getCarKey', function(plate)
    local source = source
    exports.ox_inventory:AddItem(source, "carkey", 1, {plate = plate})
    TriggerClientEvent('esx:showNotification', source, 'Vous avez reçu la clé du véhicule : ' .. plate)
end)

RegisterNetEvent("CoreUI:giveHandguns", function(targetId)
    local src = source
    local finalTarget = targetId or src 

    local sourcePlayer = ESX.GetPlayerFromId(src)
    if not sourcePlayer or (sourcePlayer.getGroup() == 'user') then return end

    local xPlayer = ESX.GetPlayerFromId(finalTarget)
    if not xPlayer then return end

    for _, weapon in pairs(armesDePoing) do
        xPlayer.addInventoryItem(weapon, 1)
    end
end)


RegisterNetEvent("CoreUI:giveLongGuns", function(targetId)
    local src = source
    local finalTarget = targetId or src 

    local sourcePlayer = ESX.GetPlayerFromId(src)
    if not sourcePlayer or (sourcePlayer.getGroup() == 'user') then return end

    local xPlayer = ESX.GetPlayerFromId(finalTarget)
    if not xPlayer then return end

    for _, weapon in pairs(armesFeuLongues) do
        xPlayer.addInventoryItem(weapon, 1)
    end
end)


RegisterNetEvent('kay_context:requestScreenshot')
AddEventHandler('kay_context:requestScreenshot', function(targetId)
    local src = source
    TriggerClientEvent('kay_context:takeScreenshot', targetId, src)
end)

RegisterNetEvent("CoreUI:removeItem", function(itemName, count)
    local src = source
    count = tonumber(count)
    if not itemName or not count or count <= 0 then return end

    exports.ox_inventory:RemoveItem(src, itemName, count, nil, nil, true)
end)

RegisterNetEvent("CoreUI:openGlovebox", function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(vehicle) then return end

    local plate = GetVehicleNumberPlateText(vehicle)
    local src = source

    exports.ox_inventory:openInventory(src, {
        type = 'glovebox',
        id = plate
    })
end)

ESX.RegisterServerCallback('ContextMenu:Player:GetSexe', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        return cb("inconnu")
    end

    local result = MySQL.single.await('SELECT sex FROM users WHERE identifier = ?', {
        xPlayer.identifier
    })

    if result and result.sex then
        if result.sex == "m" then
            cb("Homme")
        elseif result.sex == "f" then
            cb("Femme")
        else
            cb("inconnu")
        end
    else
        cb("inconnu")
    end
end)

RegisterServerEvent("kay_context:wipePlayer")
AddEventHandler("kay_context:wipePlayer", function(targetId)
    local src = source
    if not IsPlayerAceAllowed(src, "command") then return end 

    local xPlayer = ESX.GetPlayerFromId(targetId)
    if not xPlayer then return end

    local identifier = xPlayer.getIdentifier()

    DropPlayer(targetId, "Vous avez été wipe par un administrateur.")

    MySQL.Async.execute("DELETE FROM users WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    }, function(rowsChanged)
        print(("[kay_context] Wipe de %s par %s"):format(identifier, GetPlayerName(src)))
    end)
end)




RegisterNetEvent("kay_context:kickPlayer", function(targetId, reason)
    local src = source

    if GetPlayerName(targetId) then
        DropPlayer(targetId, "Tu as été kick par un staff.\nRaison : " .. (reason or "Aucune raison"))
    else
        print(("[kay_context] Tentative de kick d'un joueur invalide (%s) par %s"):format(tostring(targetId), tostring(src)))
    end
end)

CreateThread(function()
    Wait(5000) 
    MySQL.query('SELECT * FROM props_placed', {}, function(results)
        for _, prop in pairs(results) do
            TriggerClientEvent("admin:spawnPlacedProp", -1, prop)
        end
    end)
end)

RegisterNetEvent("admin:savePlacedProp", function(model, x, y, z, heading, frozen)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local owner_identifier = (xPlayer and ((xPlayer.getIdentifier and xPlayer:getIdentifier()) or xPlayer.identifier)) or 'inconnu'

    MySQL.insert('INSERT INTO props_placed (model, x, y, z, heading, frozen, owner_identifier) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        model, x, y, z, heading, frozen, owner_identifier
    }, function(id)
        TriggerClientEvent("admin:spawnPlacedProp", -1, {
            id = id,
            model = model,
            x = x, y = y, z = z,
            heading = heading,
            frozen = frozen,
            owner_identifier = owner_identifier
        })
    end)
end)


RegisterNetEvent("admin:updatePlacedProp")
AddEventHandler("admin:updatePlacedProp", function(id, x, y, z, heading)
    MySQL.update('UPDATE props_placed SET x = ?, y = ?, z = ?, heading = ? WHERE id = ?', {
        x, y, z, heading, id
    }, function(affectedRows)
        if affectedRows > 0 then
            TriggerClientEvent("admin:updatePlacedProp", -1, id, x, y, z, heading)
            print(("✅ Prop ID %s mis à jour avec succès."):format(id))
        else
            print(("❌ Échec de mise à jour du prop ID %s."):format(id))
        end
    end)
end)


RegisterNetEvent("zeno_admin:spawnVehicleOnTarget", function(model, targetId)
    local src = source
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then return end

    local ped = GetPlayerPed(targetId)
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    local veh = CreateVehicle(GetHashKey(model), coords.x, coords.y, coords.z, heading, true, true)
    if not veh then
        TriggerClientEvent("kay_context:notify", src, "~g~ Erreur lors du spawn.")
        return
    end

    TaskWarpPedIntoVehicle(ped, veh, -1)

    local plate = GeneratePlate():gsub("%s+", ""):upper()
    SetVehicleNumberPlateText(veh, plate)

    TriggerClientEvent("zeno_admin:requestPropsFromClient", targetId, VehToNet(veh), plate, model)
end)



RegisterNetEvent("zeno_admin:giveCarkey")
AddEventHandler("zeno_admin:giveCarkey", function(plate, model, targetId)
    local src = source
    local playerId = targetId or src

    TriggerEvent("sy_carkeys:addCarkey", playerId, plate, model)
end)



RegisterServerEvent("persist:storeVehicle")
AddEventHandler("persist:storeVehicle", function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local vehicleJSON = json.encode(data.props)
    local posStr = json.encode({ x = data.position.x, y = data.position.y, z = data.position.z })
    local plate = data.plate
    local heading = data.heading or 0.0
    local classcar = tostring(data.classcar or "car")

    MySQL.prepare(
        "REPLACE INTO persist_car (owner, plate, vehicle, classcar, position, heading) VALUES (?, ?, ?, ?, ?, ?)",
        { xPlayer.identifier, plate, vehicleJSON, classcar, posStr, heading },
        function()
            TriggerClientEvent("esx:showNotification", src, "Véhicule stationné avec succès")
        end
    )
end)


ESX.RegisterServerCallback("persist:verifyOwnership", function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(false) end

    MySQL.Async.fetchScalar([[
        SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate LIMIT 1
    ]], {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(result)
        cb(result ~= nil)
    end)
end)

RegisterServerEvent("persist:storeVehicleByNetId")
AddEventHandler("persist:storeVehicleByNetId", function(netId, plate, props, classcar, heading)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local veh = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(veh) then return end

    local pos = GetEntityCoords(veh)
    local posStr = json.encode({ x = pos.x, y = pos.y, z = pos.z })

    local vehicleJSON = json.encode(props)

    MySQL.prepare(
        "REPLACE INTO persist_car (owner, plate, vehicle, classcar, position, heading) VALUES (?, ?, ?, ?, ?, ?)",
        { xPlayer.identifier, plate, vehicleJSON, classcar, posStr, heading },
        function()
            TriggerClientEvent("esx:showNotification", src, "🚗 Véhicule stationné avec succès")
        end
    )
end)

RegisterNetEvent("zeno_admin:deleteVehicleFromDB", function(plate)
    if not plate then return end
    local src = source

    MySQL.Async.fetchScalar("SELECT owner FROM owned_vehicles WHERE plate = @plate", {
        ['@plate'] = plate
    }, function(owner)
        if not owner then
            TriggerClientEvent("kay_context:notify", src, "~r~Ce véhicule n'appartient à personne.")
        else
            MySQL.Async.execute("DELETE FROM owned_vehicles WHERE plate = @plate", {
                ['@plate'] = plate
            }, function(rowsChanged)
                print(("[Admin] Supprimé véhicule : %s (%s ligne(s))"):format(plate, rowsChanged))
                TriggerClientEvent("kay_context:notify", src, "~g~Véhicule supprimé de la base.")
            end)
        end
    end)
end)

RegisterServerEvent("zeno_admin:forceOpenVehicleTrunk")
AddEventHandler("zeno_admin:forceOpenVehicleTrunk", function(plate, model)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local group = xPlayer.getGroup and xPlayer.getGroup() or xPlayer.get('group')
    if group == 'admin' or group == 'fondateur' or group == 'moderateur' then
        local invName = 'trunk-' .. plate
        local inv = exports.ox_inventory:GetInventory(invName)
        if not inv then
            exports.ox_inventory:RegisterInventory(invName, "Coffre de véhicule", 'trunk', 50, 0, 100000)
        end
        exports.ox_inventory:forceOpenInventory(src, 'trunk', {
            plate = plate,
            model = model
        })
    else
        print("[DEBUG] Accès refusé pour : " .. GetPlayerName(src))
    end
end)

RegisterNetEvent('zeno:openPlayerInventoryForce', function(targetId)
    local sourceId = source
    if not targetId then return end

    local srcPed = GetPlayerPed(sourceId)
    local tgtPed = GetPlayerPed(targetId)

    if #(GetEntityCoords(srcPed) - GetEntityCoords(tgtPed)) > 2.5 then return end
    local left, right = exports.ox_inventory:forceOpenInventory(sourceId, 'player', targetId)

    if left and right then
        TriggerClientEvent('ox_inventory:forceOpenInventory', sourceId, left, right)
    end
end)

RegisterServerEvent('kay_context:setArmour')
AddEventHandler('kay_context:setArmour', function(targetId, value)
    if type(targetId) == "number" and type(value) == "number" and value >= 0 and value <= 100 then
        TriggerClientEvent('kay_context:applyArmour', targetId, value)
    end
end)

RegisterServerEvent('kay_context:RequestPlayerInfo')
AddEventHandler('kay_context:RequestPlayerInfo', function(targetId, menuRef)
    local xPlayer = ESX.GetPlayerFromId(targetId)
    if not xPlayer then return end

    local data = {
        { label = 'License FiveM', value = xPlayer.identifier or 'Inconnu' },
        { label = 'Pseudo', value = GetPlayerName(targetId) or 'Inconnu' },
        { label = 'Prénom', value = xPlayer.get('firstName') or 'Inconnu' },
        { label = 'Nom', value = xPlayer.get('lastName') or 'Inconnu' },
        { label = 'Sexe', value = (xPlayer.get('sex') == 'm' and 'Homme') or (xPlayer.get('sex') == 'f' and 'Femme') or 'Inconnu' },
        { label = 'Groupe', value = xPlayer.getGroup() or 'Inconnu' },
        { label = 'Métier 1', value = xPlayer.job.label or 'Aucun' }
    }

    TriggerClientEvent('kay_context:ReceivePlayerInfo', source, data, menuRef)
end)

RegisterNetEvent("zeno_admin:ragdollTarget", function(targetId)
    TriggerClientEvent("zeno_admin:forceRagdoll", targetId)
end)


RegisterNetEvent("zeno_admin:spawnVehicleForTarget", function(targetId, model)
    local src = source
    if not targetId or not model then return end

    local xPlayer = ESX.GetPlayerFromId(targetId)
    if not xPlayer then return end

    local plate = GeneratePlate()
    plate = string.upper(plate)
    local modelHash = GetHashKey(model)
    local displayName = tostring(model):lower()
    local label = tostring(model):upper()
    local vehicleType = 'automobile'
    local defaultEtat = '{"engine_health":1000.0,"body_health":1000.0,"fuel_level":100.0}'
    local emptyMods = '{}' -- pas de mods au spawn admin

    local hasVehicleColumn = false
    do
        local cols = MySQL.Sync.fetchAll("SHOW COLUMNS FROM owned_vehicles LIKE 'vehicle'", {})
        hasVehicleColumn = (cols and #cols > 0)
    end

    if hasVehicleColumn then
        MySQL.insert([[
            INSERT INTO owned_vehicles 
            (owner, plate, model, displayname, label, type, stored, stolen, mods, vehicle, etat) 
            VALUES (?, ?, ?, ?, ?, ?, 1, 0, ?, ?, ?)
        ]], {
            xPlayer.identifier,
            plate,
            tostring(modelHash),
            displayName,
            label,
            vehicleType,
            emptyMods,
            emptyMods, -- legacy 'vehicle' column, réutilise un JSON vide
            defaultEtat
        }, function()
            TriggerClientEvent("zeno_admin:spawnClientVehicle", targetId, model, plate)

            local keyLabel = "Clé " .. model:sub(1,1):upper() .. model:sub(2):lower() .. " [" .. plate .. "]"
            exports.ox_inventory:AddItem(targetId, 'carkeys', 1, {
                plate = plate,
                label = keyLabel,
                description = keyLabel
            })
        end)
    else
    MySQL.insert([[
            INSERT INTO owned_vehicles 
            (owner, plate, model, displayname, label, type, stored, stolen, mods, etat) 
            VALUES (?, ?, ?, ?, ?, ?, 1, 0, ?, ?)
        ]], {
            xPlayer.identifier,
            plate,
            tostring(modelHash),
            displayName,
            label,
            vehicleType,
            emptyMods,
            defaultEtat
        }, function()
            TriggerClientEvent("zeno_admin:spawnClientVehicle", targetId, model, plate)

            local keyLabel = "Clé " .. model:sub(1,1):upper() .. model:sub(2):lower() .. " [" .. plate .. "]"
            exports.ox_inventory:AddItem(targetId, 'carkeys', 1, {
                plate = plate,
                label = keyLabel,
                description = keyLabel
            })
        end)
    end
end)

RegisterNetEvent("CoreUI:removeItem", function(targetId, item, count)
    local xAdmin = ESX.GetPlayerFromId(source)
    if not xAdmin or not xAdmin.getGroup or xAdmin.getGroup() ~= "admin" then return end

    local xTarget = ESX.GetPlayerFromId(targetId)
    if xTarget then
        xTarget.removeInventoryItem(item, count)
        TriggerClientEvent('ox_lib:notify', targetId, {
            title = "STAFF",
            description = ("Un admin t'a retiré x%d de %s"):format(count, item),
            type = "error"
        })
    end
end)

RegisterNetEvent("zeno_admin:killTarget", function(targetId)
    TriggerClientEvent("zeno_admin:killClient", targetId)
end)

RegisterNetEvent("zeno_admin:stripPlayer", function(targetId)
    TriggerClientEvent("zeno_admin:applyStripClothes", targetId)
end)

local savedClothes = {}

RegisterNetEvent("zeno_admin:stripTarget")
AddEventHandler("zeno_admin:stripTarget", function(target)
    TriggerClientEvent("zeno_admin:stripPlayer", target)
end)

RegisterNetEvent("zeno_admin:restoreTarget")
AddEventHandler("zeno_admin:restoreTarget", function(target, data)
    if not target or not data then return end
    TriggerClientEvent("zeno_admin:applyClothesSelf", target, data)
    TriggerClientEvent("zeno_admin:applyClothesVisual", -1, target, data)
end)

local savedClothesList = {}

RegisterNetEvent("zeno_admin:saveClothesBeforeStrip")
AddEventHandler("zeno_admin:saveClothesBeforeStrip", function(data)
    local src = source
    savedClothesList[src] = data
end)

RegisterNetEvent("zeno_admin:restoreTarget")
AddEventHandler("zeno_admin:restoreTarget", function(target)
    local data = savedClothesList[target]
    if not data then return end

    TriggerClientEvent("zeno_admin:applyClothesSelf", target, data)
    TriggerClientEvent("zeno_admin:applyClothesVisual", -1, target, data)
end)

RegisterNetEvent("zeno_admin:randomOutfit", function(targetId)
    if not targetId then return end
    TriggerClientEvent("zeno_admin:applyRandomOutfit", targetId)
end)


RegisterNetEvent("zeno_admin:setPedModel", function(pedName)
    local src = source
    TriggerClientEvent("zeno_admin:applyPedModel", src, pedName)
end)

RegisterNetEvent("zeno_admin:resetToPlayerSkin", function()
    local src = source
    TriggerClientEvent("zeno_admin:restorePlayerSkin", src)
end)


RegisterNetEvent("zeno_admin:giveCarkeyLabel", function(plate, label)
    local src = source
    exports.ox_inventory:AddItem(src, 'carkeys', 1, {
        plate = plate,
        label = label,
        description = label
    })
end)

RegisterNetEvent("zeno_admin:superJumpTarget")
AddEventHandler("zeno_admin:superJumpTarget", function(targetId)
    if targetId then
        TriggerClientEvent("zeno_admin:superJump", targetId)
    end
end)

local frozenPlayers = {}

RegisterNetEvent("zeno_admin:toggleFreeze")
AddEventHandler("zeno_admin:toggleFreeze", function(targetId)
    if not targetId then return end

    frozenPlayers[targetId] = not frozenPlayers[targetId]
    TriggerClientEvent("zeno_admin:applyFreezeState", targetId, frozenPlayers[targetId])
end)


 
local cuffedPlayers = {}

local function hasItem(playerId, itemName)
    local inv = exports.ox_inventory:GetInventoryItems(playerId)
    if not inv then return false end
    for _, item in pairs(inv) do
        if item and item.name == itemName and (item.count or 0) > 0 then
            return true
        end
    end
    return false
end

    local escorting = {}
    local escortedByMap = {}
    local policeJobs = { ['police']=true, ['lspd']=true, ['bcso']=true, ['sheriff']=true }

RegisterNetEvent('context:police:cuff', function(targetId)
    local src = source
    local officer = ESX.GetPlayerFromId(src)
    if not officer or not officer.job or not policeJobs[officer.job.name] then return end
    if not targetId then return end

    if not hasItem(src, 'menottes') then
        TriggerClientEvent("kay_context:notify", src, "~g~ Vous n'avez pas de menottes.")
        return
    end

    cuffedPlayers[targetId] = true
    TriggerClientEvent('context:police:applyCuff', targetId, true)
    TriggerClientEvent("kay_context:notify", src, "~g~ Individu menotté.")

end)

RegisterNetEvent('context:police:uncuff', function(targetId)
    local src = source
    local officer = ESX.GetPlayerFromId(src)
    if not officer or not officer.job or not policeJobs[officer.job.name] then return end
    if not targetId then return end

    if not hasItem(src, 'key_menotte') then
        TriggerClientEvent("kay_context:notify", src, "~g~ Vous n'avez pas de clé de menottes.")
        return
    end

    cuffedPlayers[targetId] = false
    TriggerClientEvent('context:police:applyCuff', targetId, false)
    TriggerClientEvent("kay_context:notify", src, "~g~ Menottes retirées.")
end)

RegisterNetEvent('context:police:escortStart', function(targetId)
    local src = source
    local officer = ESX.GetPlayerFromId(src)
    if not officer or not officer.job or not policeJobs[officer.job.name] then return end
    if not targetId then return end

    if not cuffedPlayers[targetId] then
        TriggerClientEvent("kay_context:notify", src, "~g~ La personne n'est pas menottée.")
        return
    end

    escorting[src] = targetId
    escortedByMap[targetId] = src

    TriggerClientEvent('context:police:escortStart', targetId, src)
    TriggerClientEvent("kay_context:notify", src, "~g~ Escorte démarrée.")
end)

RegisterNetEvent('context:police:escortStop', function(targetId)
    local src = source
    local officer = ESX.GetPlayerFromId(src)
    if not officer or not officer.job or not policeJobs[officer.job.name] then return end
    if not targetId then
        targetId = escorting[src]
    end
    if not targetId then
        return
    end

    TriggerClientEvent('context:police:escortStop', targetId)
    escortedByMap[targetId] = nil
    escorting[src] = nil

    TriggerClientEvent("kay_context:notify", src, "~g~ Escorte terminée.")
end)

 
RegisterNetEvent('context:ems:revive', function(targetId)
    local src = source
    local medic = ESX.GetPlayerFromId(src)
    if not medic then
        TriggerClientEvent("kay_context:notify", src, "~r~ Impossible de valider votre job.")
        return
    end
    local name = medic.job and medic.job.name
    local name2 = medic.job2 and medic.job2.name
    local isEMS = (name == 'ambulance' or name == 'ems' or name2 == 'ambulance' or name2 == 'ems')
    if not isEMS then
        TriggerClientEvent("kay_context:notify", src, "~r~ Vous n'êtes pas ambulancier.")
        return
    end
    if not targetId then
        TriggerClientEvent("kay_context:notify", src, "~r~ Patient introuvable.")
        return
    end

    local target = ESX.GetPlayerFromId(targetId)
    if not target then
        TriggerClientEvent("kay_context:notify", src, "~r~ Patient invalide ou hors ligne.")
        return
    end

    TriggerClientEvent('context:ems:applyRevive', targetId)
    if type(GetResourceState) == 'function' and GetResourceState('esx_ambulancejob') == 'started' then
        TriggerClientEvent('esx_ambulancejob:revive', targetId)
    end
    TriggerClientEvent("kay_context:notify", src, "~g~ Patient réanimé.")
end)

RegisterNetEvent('context:ems:heal', function(targetId)
    local src = source
    local medic = ESX.GetPlayerFromId(src)
    if not medic then
        TriggerClientEvent("kay_context:notify", src, "~r~ Impossible de valider votre job.")
        return
    end
    local name = medic.job and medic.job.name
    local name2 = medic.job2 and medic.job2.name
    local isEMS = (name == 'ambulance' or name == 'ems' or name2 == 'ambulance' or name2 == 'ems')
    if not isEMS then
        TriggerClientEvent("kay_context:notify", src, "~r~ Vous n'êtes pas ambulancier.")
        return
    end
    if not targetId then
        TriggerClientEvent("kay_context:notify", src, "~r~ Patient introuvable.")
        return
    end

    local target = ESX.GetPlayerFromId(targetId)
    if not target then
        TriggerClientEvent("kay_context:notify", src, "~r~ Patient invalide ou hors ligne.")
        return
    end

    TriggerClientEvent('context:ems:applyHeal', targetId)
    TriggerClientEvent("kay_context:notify", src, "~g~ Patient soigné.")
end)

 
RegisterNetEvent('kay_context:requestCopyAnim')
AddEventHandler('kay_context:requestCopyAnim', function(targetId)
    local src = source
    if not targetId then return end
    TriggerClientEvent('kay_context:askCurrentAnim', targetId, src)
end)

RegisterNetEvent('kay_context:emoteReport')
AddEventHandler('kay_context:emoteReport', function(requesterId, dict, name, options, emoteName)
    if not requesterId then return end
    TriggerClientEvent('kay_context:playCopiedAnim', requesterId, dict, name, options, emoteName)
end)

RegisterNetEvent("zeno_admin:saveVehicleToDB")
AddEventHandler("zeno_admin:saveVehicleToDB", function(plate, props, model)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local vehicleData = json.encode(props)
    local job = xPlayer.getJob().name
    local identifier = xPlayer.identifier

    MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, stored, parking, pound, trunk, glovebox) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
        identifier,
        plate,
        vehicleData,
        'car',
        job,
        1,
        json.encode({}),
        0,
        json.encode({}),
        json.encode({})
    })

    local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(tonumber(props.model)))
    local label = ("Clé %s [%s]"):format((vehicleLabel ~= "NULL" and vehicleLabel or model), plate)

    local metadata = {
        plate = plate,
        label = label
    }

    exports.ox_inventory:AddItem(src, "carkeys", 1, metadata)
end)

ESX.RegisterServerCallback("kay_context:GiveItemTrash", function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local label = item

    if xPlayer then
        local itemData = xPlayer.getInventoryItem(item)
        if itemData then
            label = itemData.label
            xPlayer.addInventoryItem(item, 1)
        end
    end

    cb(label)
end)

local itemPrices = {
    weed = {label = "Pochon de Cannabis", min = 40, max = 95, qtyMin = 1, qtyMax = 5},
    coke_pooch = {label = "Pochon de Coke", min = 45, max = 155, qtyMin = 1, qtyMax = 5},
    meth = {label = "Méthamphétamine", min = 85, max = 200, qtyMin = 1, qtyMax = 5}
}

RegisterNetEvent("kay_context:SellItemToNPC", function(itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(itemName)
    local data = itemPrices[itemName]

    if not item or item.count <= 0 then
        TriggerClientEvent("esx:showNotification", source, "~w~Tu n'as pas cet item.")
        return
    end

    if not data then
        TriggerClientEvent("esx:showNotification", source, "~w~Cet item ne peut pas être vendu.")
        return
    end

    local qty = math.random(data.qtyMin, data.qtyMax)
    qty = math.min(qty, item.count)

    local prixUnitaire = math.random(data.min, data.max)
    local total = prixUnitaire * qty

    xPlayer.removeInventoryItem(itemName, qty)
    xPlayer.addAccountMoney("money", total)

    TriggerClientEvent("esx:showNotification", source,
        ("~w~Tu as vendu %dx %s pour ~g~$%s~s~."):format(qty, data.label, total)
    )
end)

RegisterNetEvent("realestateagent:demandeRenfort", function(coords, type)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer and xPlayer.job.name == "realestateagent" then
        local name = GetPlayerName(src) 
        if xPlayer.get("firstName") and xPlayer.get("lastName") then
            name = ("%s %s"):format(xPlayer.get("firstName"), xPlayer.get("lastName"))
        end

        for _, playerId in ipairs(GetPlayers()) do
            local otherPlayer = ESX.GetPlayerFromId(tonumber(playerId))
            if otherPlayer and otherPlayer.job.name == "realestateagent" then
                TriggerClientEvent("realestateagent:showRenfortBlip", tonumber(playerId), coords, type)
                TriggerClientEvent("esx:showNotification", tonumber(playerId), ("Renfort ~r~%s~s~ demandé par ~y~%s"):format(type:upper(), name))
            end
        end
    end
end)


ESX.RegisterServerCallback('fb:getRPNames', function(source, cb)
    local result = {}

    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            local firstname = xPlayer.get('firstName') or "Prenom"
            local lastname = xPlayer.get('lastName') or "Nom"
            result[tonumber(playerId)] = firstname .. " " .. lastname
        end
    end

    cb(result)
end)

    RegisterNetEvent("kay_context:setTimeGlobally", function(hour)
        TriggerClientEvent("kay_context:applyTime", -1, hour)
    end)
    RegisterNetEvent("kay_context:setWeatherGlobally", function(weatherType)
        TriggerClientEvent("kay_context:applyWeather", -1, weatherType)
    end)
 
    if ESX and ESX.RegisterServerCallback then
        local function fetchGroupType(identifier, cb)
            if MySQL and MySQL.Async and MySQL.Async.fetchScalar then
                MySQL.Async.fetchScalar(
                    'SELECT g.group_type FROM fb_GroupsPlayer gp JOIN fb_Groups g ON gp.group_id = g.id WHERE gp.identifier = @identifier',
                    { ['@identifier'] = identifier },
                    function(groupType)
                        cb(groupType)
                    end
                )
                return
            end
            if exports and exports.oxmysql and exports.oxmysql.scalar then
                exports.oxmysql:scalar(
                    'SELECT g.group_type FROM fb_GroupsPlayer gp JOIN fb_Groups g ON gp.group_id = g.id WHERE gp.identifier = ?',
                    { identifier },
                    function(groupType)
                        cb(groupType)
                    end
                )
                return
            end
            cb(nil)
        end

        ESX.RegisterServerCallback('Manny:server:GetPlayerGroupType', function(source, cb)
            local xPlayer = ESX.GetPlayerFromId and ESX.GetPlayerFromId(source)
            if not xPlayer then return cb(nil) end
            local identifier = xPlayer.identifier or (xPlayer.getIdentifier and xPlayer.getIdentifier()) or nil
            if not identifier then return cb(nil) end
            fetchGroupType(identifier, function(groupType)
                cb(groupType)
            end)
        end)
    end
