Config = {}

Config.RandomAmmo = false -- true = oui , false = non
Config.FixedAmmo = 2 -- Nombre de munitions a recevoir si vous mettez false
Config.RandomAmmoRange = { min = 6, max = 23 } -- Nombre de munitions aléatoire si vous mettez true

-- nom de l’item reçu pour chaque boîte
Config.AmmoBoxes = {
    ["box-ammo-9"]       = "ammo-9",
    ["box-ammo-45"]      = "ammo-45",
    ["box-ammo-rifle"]   = "ammo-rifle",
    ["box-ammo-rifle2"]  = "ammo-rifle2",
    ["box-ammo-shotgun"] = "ammo-shotgun"
}

return Config
