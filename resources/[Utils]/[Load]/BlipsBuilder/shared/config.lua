Config = {}

-- Nom de la table dans ta base de données
Config.DatabaseTable = "blips"

-- Groupes autorisés à ouvrir l'interface de gestion des blips
Config.AllowedGroups = {
    "fondateur" -- celui utilisé actuellement dans le script
}

-- Couleurs possibles (optionnel si tu veux les limiter côté client)
Config.Colors = {
    ["rouge"] = "red",
    ["vert"] = "green",
    ["bleu"] = "blue",
    ["jaune"] = "yellow",
    ["violet"] = "purple"
}

-- Types de blips autorisés (optionnel si tu veux du contrôle côté client)
Config.Types = {
    "car", "shop", "police", "hospital", "bar", "restaurant"
}

-- Taille max autorisée pour les blips
Config.MaxBlipSize = 5

-- Opacité max (déjà vérifié côté serveur mais utile à redéfinir côté client aussi)
Config.MaxOpacity = 100
Config.MinOpacity = 0
