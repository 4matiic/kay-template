RegisterServerEvent('fb:idcard:creation', function(prenom, nom, date, sexe, url)
    local metadata = {
        title = "Carte d'identité",
        subtitle = "Gouvernement de San Andreas",
        name = prenom .. " " .. nom,
        signature = prenom,
        dob = date,
        sex = sexe,
        url = url
    }

    exports.ox_inventory:AddItem(source, "card_id", 1, metadata)
end)

RegisterServerEvent('fb:idgrise:creation', function(prenom, nom, date, sexe, url, plate)
    local metadata = {
        title = "Carte grise",
        subtitle = "Gouvernement de San Andreas",
        color = "red",
        extraDataTitle = "PLAQUE",
        extraData = plate,
        name = prenom .. " " .. nom,
        signature = prenom,
        dob = date,
        sex = sexe,
        url = url
    }

    exports.ox_inventory:AddItem(source, "card_grise", 1, metadata)
end)

RegisterNetEvent("kay_ui:showIdCardServer", function(target, data)
    TriggerClientEvent('kay_ui:IdCard', target, data)
end)