ESX = exports['framework']:getSharedObject()
visible = false

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i, v in pairs(Config.Banks) do
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, v[1].x, v[1].y, v[1].z)

            if distance < Config.distance then
                Marker(v.type, v[1].x, v[1].y, v[1].z, Config.OpenBankMessage)


                if IsControlJustPressed(0, 38) then
                    local accounts = {}
                    local items = Config.GetAllItems()
                    local totalCards = 0
                    local loadedCallbacks = 0

                    local function checkIfAllLoaded()
                        loadedCallbacks += 1
                        local expected = totalCards *
                            3
                        if loadedCallbacks == expected then
                            visible = not visible
                            SendNUIMessage({
                                type = "SET_VISIBILITY",
                                visible = visible,
                                accounts = accounts
                            })
                            SetNuiFocus(visible, visible)
                        end
                    end

                    for _, item in pairs(items) do
                        if item.name == "cb" then
                            totalCards += 1

                            local account = {
                                id = 0,
                                iban = item.metadata.iban,
                                name = item.metadata.name,
                                pin = item.metadata.pin,
                                balance = 0,
                                transactions = {},
                                datas = {}
                            }

                            table.insert(accounts, account)
                            local index = #accounts

                            -- Récupérer l'ID d'abord
                            ESX.TriggerServerCallback('bank:getId', function(id)
                                accounts[index].id = id or 0

                                -- Ensuite, on peut récupérer les transactions
                                ESX.TriggerServerCallback('bank:getTransactions', function(transactions)
                                    accounts[index].transactions = transactions or {}
                                    checkIfAllLoaded()
                                end, id)

                                -- Et les données
                                ESX.TriggerServerCallback('bank:getDatas', function(datas)
                                    accounts[index].datas = datas or {}
                                    checkIfAllLoaded()
                                end, id)
                            end, account.iban)

                            -- Peut être appelée sans ID
                            ESX.TriggerServerCallback('bank:getBalance', function(balance)
                                accounts[index].balance = balance or 0
                                checkIfAllLoaded()
                            end, account.iban)
                        end
                    end
                end
            end
        end

        for i, v in pairs(Config.CreateAccount) do
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, v[1].x, v[1].y, v[1].z)

            if distance < Config.distance then
                Marker(v.type, v[1].x, v[1].y, v[1].z, Config.CreateAccountMessage)

                if IsControlJustPressed(0, 38) then
                    visible = not visible

                    ESX.TriggerServerCallback('bank:getAllIbans', function(allIbans)
                        SendNUIMessage({
                            type = "SET_VISIBILITY",
                            visible = visible,
                            creation = visible,
                            ibans = allIbans
                        })
                        SetNuiFocus(visible, visible)
                    end)
                end
            end
        end

        Wait(0)
    end
end)

RegisterNUICallback("addTransaction", function(data, cb)
    TriggerServerEvent('bank:addTransaction', data)
    cb("ok")
end)

RegisterNUICallback("checkMoney", function(data, cb)
    ESX.TriggerServerCallback('bank:checkMoney', function(result)
        if result then
            cb("ok")
        end
    end, data.montant, data.type, data.iban)
end)

RegisterNUICallback("close", function(data, cb)
    visible = not visible
    SendNUIMessage({
        type = "SET_VISIBILITY",
        visible = visible
    })
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNUICallback("createAccount", function(data, cb)
    TriggerServerEvent('bank:createAccount', data)
    cb("ok")
end)

RegisterNUICallback("changeAccountDatas", function(data, cb)
    if data.iban then
        TriggerServerEvent('bank:changeAccountIbanDatas', data.iban)
    elseif data.pin then
        TriggerServerEvent('bank:changeAccountPinDatas', data.pin)
    elseif data.name then
        TriggerServerEvent('bank:changeAccountNameDatas', data.name)
    end
    cb("ok")
end)
