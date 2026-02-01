local data_server = {}
resourceName = GetCurrentResourceName()

load = function()
    local filePath = "server/casier.json"

    local file = LoadResourceFile(resourceName, filePath)

    if file then
        data_server = json.decode(file)
    end

    for k,v in pairs(data_server) do
        for i, casier in ipairs(v.casierData) do
            Config.RegisterStash(v.id_u..casier.id .. "open", casier.name, 10, 10000, v.id_u)
        end
    end
end

save = function()
    local jsonData = json.encode(data_server, { indent = true }) or json.encode(data)
    local filePath = "server/casier.json"
    return SaveResourceFile(resourceName, filePath, jsonData, -1)
end

addCasier = function(data)
    data.id_u = GetHashKey(os.date("%c")) -- Generate a unique ID
    table.insert(data_server, data)
    for i, casier in ipairs(data.casierData) do
        Config.RegisterStash(data.id_u..casier.id .. "open", casier.name, 10, 10000, data.id_u)
    end
    save()
end


load()

RegisterNetEvent("casier:addCasier")
AddEventHandler("casier:addCasier", function(data)
    SRC = source
    xPlayer = ESX.GetPlayerFromId(SRC)
    if xPlayer.getGroup() == "user" then
        TriggerClientEvent("casier:notify", SRC, "Vous n'avez pas les permissions pour ajouter un casier")
        return
    end
    addCasier(data)
    TriggerClientEvent("casier:updateCasiers", -1, data_server)
end)

RegisterNetEvent("casier:removeCasier")
AddEventHandler("casier:removeCasier", function(id)
    for i, casier in ipairs(data_server) do
        if casier.id == id then
            table.remove(data_server, i)
            save()
            break
        end
    end
    TriggerClientEvent("casier:updateCasiers", -1, data_server)
end)

RegisterNetEvent("casier:requestCasiers")
AddEventHandler("casier:requestCasiers", function()
    source = source
    TriggerClientEvent("casier:updateCasiers", source, data_server)
end)

RegisterNetEvent("casier:toggleNew")
AddEventHandler("casier:toggleNew", function(casierid,id,name,pin)
    for k,v in pairs(data_server) do
        if v.id_u == casierid then
            if id == nil then
                table.insert(v.casierData, {id = GetHashKey(os.date("%c")), name = name, pin = pin})
            else
                for i, casier in ipairs(v.casierData) do
                    if casier.id == id then
                        casier.name = name
                        casier.pin = pin
                        casier.status = "locked"
                        break
                    end
                end
            end
            refresh = v
            save()
            TriggerClientEvent("casier:updateCasiers", -1, data_server)
            TriggerClientEvent("casier:refresh", -1, refresh, casierid)
            break
        end
    end
end)


RegisterNetEvent("casier:status")
AddEventHandler("casier:status", function(casierid, id, status)
    for k,v in pairs(data_server) do
        if v.id_u == casierid then
            for i, casier in ipairs(v.casierData) do
                if casier.id == id then
                    casier.status = status
                    save()
                    TriggerClientEvent("casier:updateCasiers", -1, data_server)
                    TriggerClientEvent("casier:refresh", -1, v, casierid)
                    break
                end
            end
            break
        end
    end
end)

RegisterNetEvent("casier:addNewCasierInCasier")
AddEventHandler("casier:addNewCasierInCasier", function(casierid)
    src = source
    xPlayer = ESX.GetPlayerFromId(src)
    function count()
        local count = 0
        for k,v in pairs(data_server) do
            if v.id_u == casierid then
                for i, casier in ipairs(v.casierData) do
                    count = count + 1
                end
            end
        end
        return count
    end

    local pass = false

    for k,v in pairs(data_server) do
        if v.id_u == casierid then
            if v.everyOneCanCreate then
                pass = true
            else
                if xPlayer.getJob().grade_name == "boss" then
                   pass = true
                end
            end
        end
    end


    if not pass then
        TriggerClientEvent("casier:notify", src, "Tu n'as pas les permissions pour ajouter un casier (grade boss)")
        return
    end

    if count() >= Config.MaxCasier then
        TriggerClientEvent("casier:notify", src, "Vous avez atteint le nombre maximum de casiers")
        return
    end

    for k,v in pairs(data_server) do
        if v.id_u == casierid then
            table.insert(v.casierData, {id = count()+1, name = "New Casier", pin = "0000", status = "free"})
            refresh = v
            save()
            TriggerClientEvent("casier:updateCasiers", -1, data_server)
            TriggerClientEvent("casier:refresh", -1, refresh, casierid)
            break
        end
    end
end)

