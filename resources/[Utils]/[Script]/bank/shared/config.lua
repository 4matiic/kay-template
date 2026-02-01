Config = {
    distance = 3,
    OpenBankMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la bank",
    CreateAccountMessage = "Appuyez sur ~INPUT_CONTEXT~ pour créer un compte bancaire",
}

Config.Banks = {
    {type = 6, vector3(147.352, -1038.93, 29.3679)},
    {type = 6, vector3(249.191208, 220.364838, 106.283569)},
}

Config.CreateAccount = {
    {type = 6, vec3(253.437363, 220.720886, 106.283569)}
}

-- Utilisé coté server !
Config.GetPlayerMoneyItem = function(source)
    return exports.ox_inventory:GetItem(source, 'money')
end
Config.RemoveItem = function(source, item, count)
    return exports.ox_inventory:RemoveItem(source, item, count)
end
Config.AddItem = function(source, item, count)
    return exports.ox_inventory:AddItem(source, item, count)
end

-- Utilisé coté client !
Config.GetAllItems = function()
    return exports.ox_inventory:GetPlayerItems()
end