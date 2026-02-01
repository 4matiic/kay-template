ESX = exports['framework']:getSharedObject()

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        -- Vérifie et crée la table bank_accounts
        MySQL.Async.execute([[
            CREATE TABLE IF NOT EXISTS bank_accounts (
                id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                owner VARCHAR(150) DEFAULT NULL,
                name VARCHAR(50) NOT NULL,
                iban VARCHAR(50) NOT NULL,
                pin VARCHAR(4) NOT NULL,
                balance INT NOT NULL
            );
        ]], {}, function(rowsChanged)
            if rowsChanged == 0 then
            else
            end
        end)

        -- Vérifie et crée la table bank_datas
        MySQL.Async.execute([[
            CREATE TABLE IF NOT EXISTS bank_datas (
                id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                revenus VARCHAR(200) DEFAULT NULL,
                depenses VARCHAR(200) DEFAULT NULL,
                date VARCHAR(50) NOT NULL,
                accountId VARCHAR(50) NOT NULL
            );
        ]], {}, function(rowsChanged)
            if rowsChanged == 0 then
            else
            end
        end)

        MySQL.Async.execute([[
            CREATE TABLE IF NOT EXISTS bank_transactions (
                id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                accountId VARCHAR(50) NOT NULL,
                reason VARCHAR(200) DEFAULT NULL,
                more VARCHAR(200) DEFAULT NULL,
                montant VARCHAR(50) NOT NULL,
                type VARCHAR(20) NOT NULL,
                date VARCHAR(300) NOT NULL
            );
        ]], {}, function(rowsChanged)
            if rowsChanged == 0 then
            else
            end
        end)
    end
end)


ESX.RegisterServerCallback('bank:getBankAccounts', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * FROM bank_accounts WHERE owner = @license', {
        ['@license'] = license
    }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('bank:getAllIbans', function(source, cb)
    local allIbans = {}
    MySQL.Async.fetchAll('SELECT * FROM bank_accounts', {}, function(result)
        for _, v in pairs(result) do
            table.insert(allIbans, v.iban)
        end
        cb(allIbans)
    end)
end)

ESX.RegisterServerCallback('bank:getId', function(source, cb, iban)
    MySQL.Async.fetchAll('SELECT * FROM bank_accounts WHERE iban = @iban', {
        ['@iban'] = iban
    }, function(result)
        if result[1] then
            cb(result[1].id)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('bank:getBalance', function(source, cb, iban)
    MySQL.Async.fetchAll('SELECT * FROM bank_accounts WHERE iban = @iban', {
        ['@iban'] = iban
    }, function(result)
        if result[1] then
            cb(result[1].balance)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('bank:getTransactions', function(source, cb, iban)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM bank_transactions WHERE accountId = @id', {
            ['@id'] = iban
        }, function(transactions)
            cb(transactions)
        end)
    else
        cb({})
    end
end)

ESX.RegisterServerCallback('bank:getDatas', function(source, cb, iban)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        MySQL.Async.fetchAll(
            'SELECT revenus, depenses, date FROM bank_datas WHERE accountId = @id ORDER BY STR_TO_DATE(date, "%d/%m/%Y")',
            {
                ['@id'] = iban
            }, function(datas)
                -- Convertir les valeurs en nombres
                for i, data in ipairs(datas) do
                    datas[i].revenus = tonumber(data.revenus)
                    datas[i].depenses = tonumber(data.depenses)
                end
                cb(datas)
            end)
    else
        cb({})
    end
end)

ESX.RegisterServerCallback('bank:checkMoney', function(source, cb, amount, type, iban)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        print("Erreur: Joueur non trouvé.")
        cb(false)
        return
    end

    if type == 'deposit' then
        local item = Config.GetPlayerMoneyItem(source)
        if not item then
            print("Erreur: Objet non trouvé dans l'inventaire.")
            cb(false)
            return
        end

        if tonumber(item.count) >= tonumber(amount) then
            cb(true)
        else
            SendNotificationPlayer(source, 'Vous n\'avez pas assez d\'argent.')
            cb(false)
        end
    else
        MySQL.Async.fetchAll('SELECT * FROM bank_accounts WHERE id = @iban', {
            ['@iban'] = iban,
        }, function(result)
            if not result or #result == 0 then
                print("Erreur: Compte bancaire non trouvé pour l'IBAN:", iban, "et l'identifiant:", xPlayer.identifier)
                cb(false)
                return
            end
            local balance = tonumber(result[1].balance)
            if not balance then
                print("Erreur: Solde non valide pour l'IBAN:", iban)
                cb(false)
                return
            end

            if tonumber(balance) >= tonumber(amount) then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)

RegisterServerEvent('bank:addTransaction')
AddEventHandler('bank:addTransaction', function(data)
    local amount = tonumber(data.amount)
    local type = data.type
    local iban = data.iban
    local destinataire = data.more

    if type == 'deposit' then
        Config.RemoveItem(source, "money", amount)
    elseif type == 'withdraw' then
        Config.AddItem(source, "money", amount)
    end

    MySQL.Async.execute(
        'INSERT INTO bank_transactions (accountId, reason, more, montant, type, date) VALUES (@iban, @reason, @more, @montant, @type, @date)',
        {
            ['@iban'] = iban,
            ['@reason'] = data.reason or 'Label par default',
            ['@more'] = data.more or '',
            ['@montant'] = amount,
            ['@type'] = type,
            ['@date'] = data.date
        }, function(rowsChanged)
            MySQL.Async.execute('UPDATE bank_accounts SET balance = balance + @amount WHERE id = @iban', {
                ['@amount'] = (type == 'deposit' and amount or -amount),
                ['@iban'] = iban
            })

            MySQL.Async.fetchAll('SELECT * FROM bank_datas WHERE accountId = @iban AND date = @date', {
                ['@iban'] = iban,
                ['@date'] = data.date
            }, function(result)
                if result[1] then
                    if type == 'deposit' then
                        MySQL.Async.execute(
                            'UPDATE bank_datas SET revenus = revenus + @amount WHERE accountId = @iban AND date = @date',
                            {
                                ['@amount'] = amount,
                                ['@iban'] = iban,
                                ['@date'] = data.date
                            })
                    else
                        MySQL.Async.execute(
                            'UPDATE bank_datas SET depenses = depenses + @amount WHERE accountId = @iban AND date = @date',
                            {
                                ['@amount'] = amount,
                                ['@iban'] = iban,
                                ['@date'] = data.date
                            })
                    end

                    if destinataire then
                        MySQL.Async.fetchAll('SELECT * FROM bank_accounts WHERE iban = @iban', {
                            ['@iban'] = destinataire
                        }, function(result1)
                            if result1[1] then
                                MySQL.Async.fetchAll('SELECT * FROM bank_datas WHERE accountId = @iban AND date = @date',
                                    {
                                        ['@iban'] = result1[1].id,
                                        ['@date'] = data.date
                                    }, function(result2)
                                        if result2[1] then
                                            MySQL.Async.execute(
                                                'UPDATE bank_datas SET revenus = revenus + @amount WHERE accountId = @iban AND date = @date',
                                                {
                                                    ['@amount'] = amount,
                                                    ['@iban'] = result1[1].id,
                                                    ['@date'] = data.date
                                                })
                                        else
                                            MySQL.Async.execute(
                                                'INSERT INTO bank_datas (revenus, depenses, date, accountId) VALUES (@revenus, @depenses, @date, @iban)',
                                                {
                                                    ['@iban'] = result1[1].id,
                                                    ['@revenus'] = amount,
                                                    ['@depenses'] = 0,
                                                    ['@date'] = data.date
                                                })
                                        end

                                        MySQL.Async.fetchAll('SELECT * FROM bank_accounts WHERE id = @id',
                                            {
                                                ['@id'] = iban
                                            }, function(result3)
                                                if result3[1] then
                                                    MySQL.Async.execute(
                                                        'INSERT INTO bank_transactions (accountId, reason, more, montant, type, date) VALUES (@iban, @reason, @more, @montant, @type, @date)',
                                                        {
                                                            ['@iban'] = result1[1].id,
                                                            ['@reason'] = "Virement bancaire",
                                                            ['@more'] = result3[1].iban,
                                                            ['@montant'] = amount,
                                                            ['@type'] = "deposit",
                                                            ['@date'] = data.date
                                                        })

                                                    MySQL.Async.execute(
                                                        'UPDATE bank_accounts SET balance = balance + @amount WHERE id = @iban',
                                                        {
                                                            ['@amount'] = (type == 'deposit' and -amount or amount),
                                                            ['@iban'] = result1[1].id
                                                        })
                                                end
                                            end)
                                    end)
                            end
                        end)
                    end
                else
                    -- Create new entry
                    MySQL.Async.execute(
                        'INSERT INTO bank_datas (revenus, depenses, date, accountId) VALUES (@revenus, @depenses, @date, @iban)',
                        {
                            ['@iban'] = iban,
                            ['@revenus'] = (type == 'deposit' and amount or 0),
                            ['@depenses'] = (type == 'withdraw' and amount or 0),
                            ['@date'] = data.date
                        })
                end
            end)
        end)
end)

RegisterServerEvent('bank:createAccount')
AddEventHandler('bank:createAccount', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute(
        'INSERT INTO bank_accounts (owner, name, iban, pin, balance) VALUES (@owner, @name, @iban, @pin, @balance)',
        {
            ['@owner'] = xPlayer.identifier,
            ['@name'] = data.name,
            ['@iban'] = data.iban,
            ['@pin'] = data.pin,
            ['@balance'] = 0
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerEvent(GetCurrentResourceName() .. ':giveCreditCard', xPlayer.source, data.iban, data.pin,
                data.name)
            end
        end)
end)

-- RegisterCommand('GetCB', function(source, args, rawCommand)
--     local idAccount = args[1]

--     MySQL.Async.fetchAll('SELECT * FROM bank_accounts WHERE id = @idAccount', {
--         ['@idAccount'] = idAccount,
--     }, function(result)
--         if result[1] then
--             exports.ox_inventory:AddItem(source, "cb", 1, {
--                 iban = result[1].iban,
--                 pin = result[1].pin,
--                 name = result[1].name,
--             })
--         end
--     end)
-- end, false)

RegisterServerEvent('bank:changeAccountIbanDatas')
AddEventHandler('bank:changeAccountIbanDatas', function(data)
    MySQL.Async.fetchAll('SELECT * FROM bank_accounts WHERE iban = @iban', {
        ['@iban'] = data.new
    }, function(result)
        if result[1] then
            SendNotificationPlayer(source, 'Ce compte bancaire existe déjà.')
        else
            MySQL.Async.execute('UPDATE bank_accounts SET iban = @iban WHERE iban = @oldIban', {
                ['@iban'] = data.new,
                ['@oldIban'] = data.old,
            })

            TriggerEvent(GetCurrentResourceName() .. ':changeData', source, 'iban', data.old, data.new)
        end
    end)
end)

RegisterServerEvent('bank:changeAccountPinDatas')
AddEventHandler('bank:changeAccountPinDatas', function(data)
    MySQL.Async.execute('UPDATE bank_accounts SET pin = @pin WHERE iban = @iban', {
        ['@pin'] = data.new,
        ['@iban'] = data.iban,
    })
    TriggerEvent(GetCurrentResourceName() .. ':changeData', source, 'pin', data.old, data.new)
end)

RegisterServerEvent('bank:changeAccountNameDatas')
AddEventHandler('bank:changeAccountNameDatas', function(data)
    MySQL.Async.execute('UPDATE bank_accounts SET name = @name WHERE iban = @iban', {
        ['@name'] = data.new,
        ['@iban'] = data.iban,
    })
    TriggerEvent(GetCurrentResourceName() .. ':changeData', source, 'name', data.old, data.new)
end)
