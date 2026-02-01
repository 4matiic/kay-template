ESX = exports["framework"]:getSharedObject()


local reports = {}

RegisterServerEvent('__cfx_internal:commandFallback')
AddEventHandler('__cfx_internal:commandFallback', function(command)
    local _source = source
    local name = GetPlayerName(_source)
    TriggerEvent('chatMessage', _source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command)
    end

    CancelEvent()
end)

-- Système de clear

RegisterCommand("cls", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if playerGroup == 'admin' then
        TriggerClientEvent("chat:clear", -1)
        TriggerClientEvent('chat:addMessage', -1, { args = { "\n^1🚩 ^1NETTOYAGE - ^2Le chat à été clear !" }
        })
    end
end, false)

RegisterServerEvent('_chat:messageEntered')
AddEventHandler('_chat:messageEntered', function(author, color, message)
    local _source = source

    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', _source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author, { 255, 255, 255 }, message)
    end

    print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('onServerResourceStart', function(resName)
    Citizen.Wait(500)
    local players = GetPlayers()

    for i = 1, #players, 1 do
        refreshCommands(players[i])
    end
end)

function refreshCommands(playerId)
    local registeredCommands = GetRegisteredCommands()
    local suggestions = {}

    for i = 1, #registeredCommands do
        if IsPlayerAceAllowed(playerId, ('command.%s'):format(registeredCommands[i].name)) then
            table.insert(suggestions, {
                name = '/' .. registeredCommands[i].name,
                help = ''
            })
        end
    end

    TriggerClientEvent('chat:addSuggestions', playerId, suggestions)
end

AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
    TriggerClientEvent('chat:addMessage', source, { args = { '' } })
end)

-- Système de reports

local reportCounter = 100
local reports = {} -- Table pour stocker les reports ouverts

local function getNextReportNumber()
    reportCounter = reportCounter + 1
    return reportCounter
end

-- Commande pour créer un report
RegisterCommand('report', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = GetPlayerName(source)
    local playerId = source

    if #args == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source,
            "~r~Erreur:~s~ Vous devez fournir un message pour votre report.")
        return
    end

    local reportMessage = table.concat(args, " ")
    local reportNumber = getNextReportNumber()

    -- Stockage du report dans la table
    reports[reportNumber] = {
        playerName = playerName,
        playerId = playerId,
        message = reportMessage,
        status = "open"
    }

    -- Formatage du message
    local formattedMessage = string.format(
        "(👁️ ^2%s | ^2%d | ^2Report N°%d^7) ^7%s",
        playerName, playerId, reportNumber, reportMessage
    )

    -- Notification pour les modérateurs et administrateurs
    for _, modId in ipairs(GetPlayers()) do
        local xTarget = ESX.GetPlayerFromId(modId)
        if xTarget then
            local playerGroup = xTarget.getGroup()
            if playerGroup == 'mod' or playerGroup == 'admin' or playerGroup == '_dev' then
                -- Envoi uniquement du message formaté sans notification supplémentaire
                TriggerClientEvent('chat:addMessage', modId, {
                    args = { formattedMessage }
                })
            end
        end
    end

    -- Notification pour le joueur qui a envoyé le report
    TriggerClientEvent('chat:addMessage', source, {
        args = { formattedMessage }
    })
end, false)

-- Commande pour clôturer un report
RegisterCommand('clo', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()

    -- Vérification des permissions du joueur
    if playerGroup ~= 'mod' and playerGroup ~= 'admin' and playerGroup ~= '_dev' then
        TriggerClientEvent('esx:showNotification', xPlayer.source,
            "~r~Erreur:~s~ Vous n'avez pas la permission de clôturer un report.")
        return
    end

    -- Vérification de l'ID du report
    if #args < 1 then
        TriggerClientEvent('esx:showNotification', xPlayer.source,
            "~r~Erreur:~s~ Vous devez spécifier l'ID du report à clôturer.")
        return
    end

    local reportId = tonumber(args[1])
    if not reports[reportId] or reports[reportId].status ~= "open" then
        TriggerClientEvent('esx:showNotification', xPlayer.source,
            "~r~Erreur:~s~ Ce report n'existe pas ou est déjà clôturé.")
        return
    end

    -- Clôture du report
    reports[reportId].status = "closed"
    local reportOwnerId = reports[reportId].playerId
    local staffName = GetPlayerName(source)

    -- Notification pour le staff
    local closeMessage = string.format(
        "^1[INFO]^7 Report N°%d clôturé par ^2%s",
        reportId, staffName
    )
    TriggerClientEvent('chat:addMessage', source, { args = { closeMessage } })

    -- Notification pour le joueur qui a créé le report
    TriggerClientEvent('chat:addMessage', reportOwnerId, {
        args = { string.format("^5INFO^7 Report N°%d clôturé par %s !", reportId, staffName) }
    })

    -- Notification pour les autres membres du staff
    for _, modId in ipairs(GetPlayers()) do
        local xTarget = ESX.GetPlayerFromId(modId)
        local targetGroup = xTarget.getGroup()
        if targetGroup == 'mod' or targetGroup == 'admin' or targetGroup == '_dev' then
            TriggerClientEvent('chat:addMessage', modId, {
                args = { closeMessage }
            })
        end
    end
end, false)


-- Système d'annonce

local webhookURL = "TON WEBHOOK HERMANO"

local function sendAnnonceWebhook(playerName, message)
    local data = {
        username = "Annonce IG",
        embeds = {
            {
                title = "Nouvelle Annonce",
                color = 16711680,
                fields = {
                    { name = "Joueur",  value = playerName, inline = true },
                    { name = "Message", value = message,    inline = false }
                },
                footer = {
                    text = "Système d'Annonce"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    }

    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode(data),
        { ['Content-Type'] = 'application/json' })
end

ESX.RegisterCommand('annonce', 'fondateur', function(xPlayer, args, showError)
    if #args > 0 then
        local message = table.concat(args, " ")
        TriggerClientEvent('chat:addMessage', -1, {
            template = [[
                <div class="annonce">
                    Annonce:<br>
                    {1}
                </div>
            ]],
            args = { xPlayer.getName(), message }
        })
        sendAnnonceWebhook(xPlayer.getName(), message)
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source,
            "~r~Erreur:~s~ Vous devez fournir un message pour votre annonce.")
    end
end, true)

-- Commande pour parler entre staff (/r)

local staffGroups = {
    ["mod"] = "🔧",
    ["admin"] = "🛡️",
    ["_dev"] = "💻"
}

local staffGroupNames = {
    ["mod"] = "Modérateur",
    ["admin"] = "Administrateur",
    ["_dev"] = "Développeur"
}

RegisterCommand('msg', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer == nil then
        print('Erreur : Impossible de récupérer le joueur avec l\'ID source.')
        return
    end

    local message = table.concat(args, " ")
    if message == nil or message:gsub("%s+", "") == "" then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous devez entrer un message !")
        return
    end

    local playerGroup = xPlayer.getGroup()
    local playerEmoji = staffGroups[playerGroup] or "❓"
    local playerGroupName = staffGroupNames[playerGroup] or "Staff"

    if staffGroups[playerGroup] then
        for _, playerId in ipairs(ESX.GetPlayers()) do
            local targetPlayer = ESX.GetPlayerFromId(playerId)
            if targetPlayer and staffGroups[targetPlayer.getGroup()] then
                TriggerClientEvent('chat:addMessage', playerId, {
                    color = { 255, 255, 255 },
                    multiline = true,
                    args = {
                        string.format("^7( %s ^1%s | %s ^7)^7 : %s", playerEmoji, GetPlayerName(source), playerGroupName,
                            message)
                    }
                })
            end
        end
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas la permission d'utiliser cette commande.")
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(9999999999999)

        for _, playerId in ipairs(ESX.GetPlayers()) do
            local targetPlayer = ESX.GetPlayerFromId(playerId)
            if targetPlayer and staffGroups[targetPlayer.getGroup()] then
                TriggerClientEvent('chat:addMessage', playerId, {
                    color = { 255, 255, 255 },
                    multiline = true,
                    args = {
                        "^1 Utiliser la commande /msg pour échanger avec les membres du personnel"
                    }
                })
            end
        end
    end
end)
