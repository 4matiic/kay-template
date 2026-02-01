dmeC = {
    language = 'fr',
    color = { r = 99, g = 0, b = 13, a = 255 },
    font = 0,
    time = 5000,
    scale = 0.75,
    dist = 250, 
}

Languages = {
    ['fr'] = {
        commandName = 'me',
        commandDescription = 'Affiche une action au dessus de votre tête.',
        commandSuggestion = {{ name = 'action', help = '"se gratte le nez" par exemple.'}},
        prefix = 'La personne '
    },
}


shop = {}

Config = {
    esxversion = "new", -- ( old or new)
}

shop.Shops = {
    ['Shop1'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 20, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 2, item = "empty_bag", itemName = "Sachet Vide", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 100, item = "skateboard", itemName = "Skateboard", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 20, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 4, item = "sprite", itemName = "Sprite", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(24.44, -1347.16, 29.50)
        
    },
    ['Shop2'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(-46.78, -1758.72, 29.42)
    },
    ['Shop3'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(-1488.90, -380.68, 40.16)
    },
    ['Shop4'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(2557.02, 380.59, 108.62)
    },
    ['Shop5'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(1134.06, -982.27, 46.42)
    },
    ['Shop6'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" }, 
        },
        position = vector3(372.35, 326.63, 103.57)
    },
    ['Shop7'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(1165.00, -323.45, 69.21)
    },
    ['Shop8'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" }, 
        },
        position = vector3(-2966.32, 390.99, 15.04)
    },
    ['Shop9'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(-1819.71, 794.02, 138.08)
    },
    ['Shop10'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(1727.93, 6415.93, 35.04)
    },
    ['Shop11'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(1697.62, 4922.87, 42.06)
    },
    ['Shop12'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(2677.30, 3279.54, 55.24)
    },
    ['Shop13'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(1165.87, 2710.91, 38.16)
    },
    ['Shop14'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(1391.94, 3606.23, 34.98)
    },
    ['Shop15'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(-3039.26, 584.06, 7.91)
    },
    ['Shop16'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(-3242.63, 999.78, 12.83)
    },
    ['Shop17'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(1959.66, 3740.15, 32.34)
    },
    ['Shop18'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" }, 
        },
        position = vector3(549.32, 2671.13, 42.16)
    },
    ['Shop19'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" }, 
        },
        position = vector3(-1221.79, -908.38, 12.33)
    },
    ['Shop20'] = {
        name = "24/7",
        showBlip = true,
        shopType = "superette",
        blipSprite = 52,
        blipColor = 2,
        items = {
            { itemPrice = 10, item = "bread", itemName = "Pain", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
            { itemPrice = 10, item = "water", itemName = "Eau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Boutique" },
        },
        position = vector3(4468.29, -4466.63, 4.29)
    },

    ['Shop21'] = {
        name = "BlackMarket",
        showBlip = false,
        shopType = "illegal",
        blipSprite = 84,
        blipColor = 1,
        items = {
            { itemPrice = 10, item = "weapon_knife", itemName = "Couteau", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Illégal" },
            { itemPrice = 10, item = "flowerpot", itemName = "Pot", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Illégal" },
        },
        position = vector3(2748.03, 3472.48, 55.67)
    },

    ['Shop22'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(-662.14, -933.54, 21.83)
    },

    ['Shop24'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(810.43, -2159.28, 29.62)
    },

    ['Shop25'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(1692.09, 3761.19, 34.71)
    },


    ['Shop26'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(-331.80, 6085.25, 31.45)
    },

    ['Shop27'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(254.07, -50.76, 69.94)
    },

    ['Shop27'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(22.94, -1105.30, 29.80)
    },

    ['Shop28'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(2567.80, 292.25, 108.73)
    },

    ['Shop29'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(-1118.95, 2700.28, 18.55)
    },

    ['Shop30'] = {
        name = "Ammunation",
        showBlip = true,
        shopType = "Armes",
        blipSprite = 110,
        blipColor = 0,
        items = {
            { itemPrice = 10, item = "WEAPON_KNIFE", itemName = "Couteaux", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_BAT", itemName = "Batte de baseball", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_PISTOL", itemName = "Pistolet", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "WEAPON_MACHETE", itemName = "Machette", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Armes" },
            { itemPrice = 10, item = "ammo-rifle2", itemName = "Balles Fusilt D'assault", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-grenade", itemName = "Balles Grenade", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-38", itemName = "Balles de revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-emp", itemName = "Balles Compact EMP", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-firework", itemName = "Balles Artifice", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-flare", itemName = "Balles Pistolet de Detresse", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-45", itemName = "Balles 45", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-rocket", itemName = "Balles De rocket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-heavysniper", itemName = "Balles Heavy Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-22", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-sniper", itemName = "Balles Sniper", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-musket", itemName = "Balles de musket", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-44", itemName = "Balles de Revolver", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-50", itemName = "Balles Cal 50", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-railgun", itemName = "Balles Railgun", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
            { itemPrice = 10, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Munitions" },
        },
        position = vector3(842.38, -1035.65, 28.19)
    },

    ['Shop31'] = {
        name = "Pharmacie",
        showBlip = true,
        shopType = "Pharmacie",
        blipSprite = 51,
        blipColor = 11,
        items = {
            { itemPrice = 10, item = "medikit", itemName = "Kit de soins", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "soins" },
            { itemPrice = 10, item = "bandage", itemName = "Bandage", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "soins" },
            { itemPrice = 10, item = "stretcher", itemName = "Brancard", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "soins" },
        },
        position = vector3(308.31, -595.48, 43.28)
    },

    ['Shop32'] = {
        name = "SASP Armurerie",
        showBlip = true,
        shopType = "SASP Armurerie",
        blipSprite = 110,
        blipColor = 29,
        items = {
            { itemPrice = 0, item = "WEAPON_STUNGUN", itemName = "Tazer", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "WEAPON_BZGAS", itemName = "Gaz BZ", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "WEAPON_COMBATPISTOL", itemName = "Pistolet de Combat", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "WEAPON_FLASHLIGHT", itemName = "Lampe torche", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "WEAPON_PISTOL", itemName = "Beretta", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "WEAPON_COMBATSHOTGUN", itemName = "Fusil a pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "ammo-shotgun", itemName = "Balles Pompe", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "ammo-9", itemName = "Balles 9mm", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "handcuffs", itemName = "Menotte", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "handcuff_key", itemName = "Clée de menotte", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
            { itemPrice = 0, item = "test_poudre", itemName = "Test de poudre", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "SASP" },
        },
        position = vector3(452.56, -997.26, 30.71)
    },

    ['Shop33'] = {
        name = "Electronique",
        showBlip = true,
        shopType = "electronique",
        blipSprite = 459,
        blipColor = 7,
        items = {
            { itemPrice = 300, item = "phone", itemName = "Telephone", moneyType = "$", tradeType = "buy", itemAmount = 1, category = "Social" }
        },
        position = vector3(393.24,-832.35,28.30)
    },

    ['Shop34'] = {
        name = "Electronique",
        showBlip = true,
        shopType = "electronique",
        blipSprite = 459,
        blipColor = 7,
        items = {
            { itemPrice = 300, item = "phone", itemName = "Telephone", moneyType = "$", tradeType = "sell", itemAmount = 1, category = "Test" }
        },
        position = vector3(235.38, -877.50, 30.49)
    }
}


shop.MarkerType = 23 
shop.MarkerColor = { r = 31, g = 33, b = 204}  
shop.MarkerSize = { x = 0.6, y = 0.6, z = 0.6}  
shop.DrawDistance = 9.0  
shop.InteractionDistance = 2.0  
shop.KeyToOpenShop = 38  