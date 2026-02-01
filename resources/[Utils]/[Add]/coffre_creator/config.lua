Config = {}

Config.Chest = {
    {
        MarkerColor = { -- Couleur du marker
            R = 255, -- Rouge
            G = 255, -- Vert
            B = 255, -- Bleu
        },
        Coords = vec3(-102.0674, -1781.6776, 14.1528), -- Coordonnées du coffre
        Name = "stash_1", -- Nom du stash (peu être appelé dans un autre script : exports.ox_inventory:openInventory('stash', { id = "stash_1" }) )
        Label = "Coffre N°1", -- Label du coffre (pour le textui et le nom de l'inventaire)
        Slots = 100, -- Nombre de slots max
        Poid = 100000, -- Poid du coffre (toujours ajouter x3 0)
        Personnel = false, -- Si il est personnel, alors lorsque vous posez un truc, vous et uniquement vous voyez l'objet dedans
        Item = {
            ItemRequis = true, -- Item requis ?
            ItemName = "keywarehouseballas" -- Nom de l'item requis (give)
        },
        Job = {
            JobRequis = false, -- Job requis ?
            JobName = nil -- Nom du job (string)
        }
    }, -- Copier-coller pour faire de nouveaux coffres
    
    {
            MarkerColor = { -- Couleur du marker
                R = 255, -- Rouge
                G = 255, -- Vert
                B = 255, -- Bleu
            },
            Coords = vector3(493.68, -36.18, 88.86), -- Coordonnées du coffre
            Name = "stash_2", -- Nom du stash (peu être appelé dans un autre script : exports.ox_inventory:openInventory('stash', { id = "stash_1" }) )
            Label = "Coffre N°2", -- Label du coffre (pour le textui et le nom de l'inventaire)
            Slots = 100, -- Nombre de slots max
            Poid = 100000, -- Poid du coffre (toujours ajouter x3 0)
            Personnel = false, -- Si il est personnel, alors lorsque vous posez un truc, vous et uniquement vous voyez l'objet dedans
            Item = {
                ItemRequis = true, -- Item requis ?
                ItemName = "key" -- Nom de l'item requis (give)
            },
            Job = {
                JobRequis = true, -- Job requis ?
                JobName = "police" -- Nom du job (string)
            }
        }, -- Copier-coller pour faire de nouveaux coffres

    
    {
        MarkerColor = {
            R = 0,
            G = 0,
            B = 0,
        },
        Coords = vec3(461.9092, -996.3224, 30.6896),
        Name = "stash_perso_sasp",
        Label = "Coffre personnel SASP",
        Slots = 101,
        Poid = 30000,
        Personnel = true,
        Item = {
            ItemRequis = true,
            ItemName = "water"
        },
        Job = {
            JobRequis = false,
            JobName = ""
        }
    },
}