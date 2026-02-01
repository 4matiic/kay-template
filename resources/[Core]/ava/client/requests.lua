ESX = exports["framework"]:getSharedObject()

local callbacks = nil

exports('displayPrompt', function(title, message, displayAsColumn, buttons)
    assert(type(title) == 'string' or title == nil, 'invalid title type')
    assert(type(message) == 'string' or message == nil, 'invalid message type')
    assert(type(displayAsColumn) == 'boolean' or displayAsColumn == nil, 'invalid displayAsColumn type ' .. type(displayAsColumn) .. ' / ' .. tostring(displayAsColumn))
    assert(type(buttons) == 'table', 'invalid buttons type')
    
	TriggerEvent('fb:disableControlActions', 'ava', true)
    AddNuiFocus('prompt')
    AddNuiFocusKeepInput('prompt')

    local nuiButtons = {}
    callbacks = {}

    for index, data in pairs(buttons) do
        callbacks[index] = data.cb
        nuiButtons[index] = {
            text = data.text,
            style = data.style,
        }
    end

    CreateThread(function()
        while callbacks do
            DisableAllControlActions(0)
            EnableControlAction(0, 30, true)
            EnableControlAction(0, 31, true)
            Wait(0)
        end
    end)

    SendReactMessage('setPrompt', {
        title = title,
        description = message,
        displayAsColumn = displayAsColumn or false,
        buttons = nuiButtons,
    })
end)

exports('displayRequest', function(title, message, onAccept, onDecline)
    assert(type(onAccept) == 'table' or onAccept == nil, 'invalid onAccept type ' .. type(onAccept) .. ' / ' .. tostring(onAccept))
    assert(type(onDecline) == 'table' or onDecline == nil, 'invalid _onDecline type ' .. type(onDecline) .. ' / ' .. tostring(onDecline))

    exports[GetCurrentResourceName()]:displayPrompt(title, message, false, {
        {
            text = "Refuser",
            style = { color = "red", active = true, icon = "cancel" },
            cb = onDecline,
        },
        {
            text = "Accepter",
            style = { color = "green", active = true, icon = "confirm" },
            cb = onAccept,
        }
    })
end)

exports('payWith', function(canPayAsStaff, canCancel, canPayCash, title, payWith, cancelCb, item, count)
    assert(type(canPayAsStaff) == 'boolean' or canPayAsStaff == nil, 'invalid canPayAsStaff type' .. tostring(canPayAsStaff) .. '/' .. type(canPayAsStaff))
    assert(type(canCancel) == 'boolean' or canCancel == nil, 'invalid canCancel type' .. tostring(canCancel) .. '/' .. type(canCancel))
    assert(type(canPayCash) == 'number' or canPayCash == nil, 'invalid canPayCash type')
    assert(type(title) == 'string' or title == nil, 'invalid title type (' .. tostring(title) .. '/' .. type(title) .. ')')
    assert(type(payWith) == 'table', 'invalid onAccept type ' .. type(payWith) .. ' / ' .. tostring(payWith))

    local payments = {}

    if canCancel then
        table.insert(payments, {
            text = "Annuler",
            style = { color = "red", active = true, icon = "cancel" },
            cb = function()
                ESX.ShowNotification('~r~Paiement annulé')
                if cancelCb then cancelCb() end
            end
        })
    end

    -- BOUTON ESPECES
    if type(canPayCash) == 'number' and canPayCash > 0 then
        table.insert(payments, {
            text = ("Espèces (%d$)"):format(canPayCash),
            style = { color = "green", active = true, icon = "cash" },
            cb = function()
                if payWith and payWith[1] then payWith[1]("cash") end
            end
        })
    end

    ESX.TriggerServerCallback('fb:banking:getPlayerAccounts', function(bankAccounts)
        for _, xBankAccount in pairs(bankAccounts or {}) do
            table.insert(payments, {
                text = "Compte N°" .. xBankAccount.id .. ' | ' .. xBankAccount.iban,
                style = { color = "black", active = true, icon = "card" },
                cb = function()
                    if payWith and payWith[1] then payWith[1]({ iban = xBankAccount.iban, id = xBankAccount.id }) end
                end
            })
        end

        if #payments == (canCancel and 1 or 0) then
            table.insert(payments, {
                text = "Aucun moyen de paiement",
                style = { color = "black", active = true, icon = "cancel" },
                cb = function() if cancelCb then cancelCb() end end,
            })
        end

        exports[GetCurrentResourceName()]:displayPrompt(title, nil, true, payments)
    end)
end)



RegisterNetEvent("payWith")
AddEventHandler("payWith", function(canPayAsStaff, canCancel, canPayCash, title, payWith, cancelCb, item, count)
    assert(type(canPayAsStaff) == 'boolean' or canPayAsStaff == nil, 'invalid canPayAsStaff type' .. tostring(canPayAsStaff) .. '/' .. type(canPayAsStaff))
    assert(type(canCancel) == 'boolean' or canCancel == nil, 'invalid canCancel type' .. tostring(canCancel) .. '/' .. type(canCancel))
    assert(type(canPayCash) == 'number' or canPayCash == nil, 'invalid canPayCash type')
    assert(type(title) == 'string' or title == nil, 'invalid title type (' .. tostring(title) .. '/' .. type(title) .. ')')
    assert(type(payWith) == 'table', 'invalid onAccept type ' .. type(payWith) .. ' / ' .. tostring(payWith))
    assert(type(onAccept) == 'table' or onAccept == nil, 'invalid onAccept type ' .. type(onAccept) .. ' / ' .. tostring(onAccept))
    assert(type(onDecline) == 'table' or onDecline == nil, 'invalid _onDecline type ' .. type(onDecline) .. ' / ' .. tostring(onDecline))

    local payments = {}
    if canCancel then
        table.insert(payments, {
            text = "Annuler",
            style = { color = "red", active = true, icon = "cancel" },
            cb = function()
                ESX.ShowNotification('~r~Paiement annulé')
            end
        })
    end

    ESX.TriggerServerCallback('fb:banking:getPlayerAccounts', function(bankAccounts)
        for accountId, xBankAccount in pairs(bankAccounts) do
            print(json.encode(xBankAccount))
            table.insert(payments, {
                text = "Compte N°" .. xBankAccount.id .. ' | ' .. xBankAccount.iban,
                style = { color = "black", active = true, icon = "card" },
                cb = payWith,
            })
        end

        if #payments == 1 then
            table.insert(payments, {
                text = "Aucun moyen de paiement",
                style = { color = "black", active = true, icon = "cancel" },
                cb = cancelCb,
            })
        end
        exports[GetCurrentResourceName()]:displayPrompt(title, nil, true, payments)
    end)
end)

exports('closeRequest', function()
    RemoveNuiFocus('prompt')
    RemoveNuiFocusKeepInput('prompt')
    SendReactMessage('setPrompt', nil)
    callbacks = nil
    TriggerEvent('fb:disableControlActions', 'ava', false)
end)


RegisterNUICallback("answer", function(data, cb)
    SendReactMessage('setPrompt', nil)
    RemoveNuiFocus('prompt')
    RemoveNuiFocusKeepInput('prompt')

	--// TODO: data.data is a list of { name, value } corresponding to the components of the prompt
    if callbacks[data.index + 1] then -- +1 because of lua<->js conversion
        callbacks[data.index + 1]()
    end
    callbacks = nil
    TriggerEvent('fb:disableControlActions', 'ava', false)

    cb('ok')
end)