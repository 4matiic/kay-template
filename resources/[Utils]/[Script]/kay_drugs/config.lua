Config = {}

Config.MinimumDistance = 1.0 -- Distance minimale entre les pots (en mètres)
Config.MaxPots = 20 -- Nombre maximum de pots à placer
Config.PotModel = `bkr_prop_weed_01_small_01c` -- Nom du prop

Config = { 
    EnablePoliceNotification = true, -- Activer/désactiver les notifications police
    PoliceNotificationChance = 100, -- Probabilité en % qu'une notification soit envoyée
    PoliceJobs = {'police', 'sheriff'}, -- Jobs qui recevront la notification
    NotificationText = "~r~ALERTE~w~: Des citoyens signalent une forte odeur suspecte dans le secteur", -- Texte de la notification
    NotificationCoordOffset = 50.0, -- Offset en mètres pour ne pas donner la position exacte
    BlipDuration = 30, -- Durée du blip en secondes
    BlipSprite = 140, -- Sprite du blip 
    BlipColor = 1, -- Couleur du blip 
    BlipScale = 1.0, -- Taille du blip
    MinimumDistance = 1.0,
    MaxPots = 20,
    PotModel = `bkr_prop_weed_01_small_01c`,
    TotalGrowthTime = 350000, -- 350000 millisecondes
    LightRange = 5.0, -- Distance maximale de la lumière
    LightIntensityFalloff = false, -- Laissez désactivé
    LightMinimumDot = 0.6, -- Angle du faisceau de la lumière 
    PlacedLights = {},

    GrowthStages = {
        [1] = 5,   
        [2] = 10,   
        [3] = 15,   
        [4] = 20    
    },

    PotStates = {
        empty = {
            title = "Pot vide",
            subtitle = "(0/?)",
            texture_dict = "kay_pot",
            texture_name = "pot_stage1",
            stats = {
                "?",
                "?",
                "?",
                "Evolution"
            }
        },
        weed = {
            title = "Graîne de chanvre",
            subtitle = {
                [1] = "Petite pousse (1/4)",
                [2] = "Pousse moyenne (2/4)",
                [3] = "Grande pousse (3/4)", 
                [4] = "Plante accomplie (4/4)"
            },
            rewards = {
                [3] = {
                    item = 'cannabis',
                    min = 1,
                    max = 3
                },
                [4] = {
                    item = 'cannabis',
                    min = 4,
                    max = 6
                }
            }, 
            texture_dict = "kay_weed", 
            texture_name = "pot_stage", 
            stats = {
                "~b~Eau",
                "~y~Lumière",
                "~g~Fertilisant",
                "~w~Evolution"
            }
        },
        coke = {
            title = "Graîne de coke",
            subtitle = {
                [1] = "Petite pousse (1/4)",
                [2] = "Pousse moyenne (2/4)",
                [3] = "Grande pousse (3/4)",
                [4] = "Plante accomplie (4/4)"
            },
            texture_dict = "kay_drugs",
            texture_name = "pot_stage",
            rewards = {
                [3] = {
                    item = 'crack',
                    min = 1,
                    max = 3
                },
                [4] = {
                    item = 'crack',
                    min = 4,
                    max = 6
                }
            },
            stats = {
                "~b~Eau",
                "~y~Lumière",
                "~g~Fertilisant",
                "~w~Evolution"
            }
        }
    },

    GrowthStages = {
        [1] = {
            minWater = 20,
            waterConsumption = 20,
            minLight = 50,
            lightConsumption = 0,
            minFertilizer = 50,
            fertilizerConsumption = 0,
            duration = 350000
        },
        [2] = {
            minWater = 20,
            waterConsumption = 20,
            minLight = 50,
            lightConsumption = 0,
            minFertilizer = 50,
            fertilizerConsumption = 0,
            duration = 350000
        },
        [3] = {
            minWater = 20,
            waterConsumption = 20,
            minLight = 50,
            lightConsumption = 0,
            minFertilizer = 50,
            fertilizerConsumption = 0,
            duration = 350000
        },
        [4] = {
            minWater = 20,
            waterConsumption = 20,
            minLight = 50,
            lightConsumption = 0,
            minFertilizer = 50,
            fertilizerConsumption = 0,
            duration = 350000
        }
    }
}

-- Temps total de croissance
Config.TotalGrowthTime = 50 -- minutes

Config.Textures = {
    "pot_empty",
    "pot_stage1",
    "pot_stage2",
    "pot_stage3",
    "pot_stage4"
}

Config.Colors = {
    Valid = {0, 255, 0, 100},    -- Vert avec transparence
    Invalid = {255, 0, 0, 100}   -- Rouge avec transparence
}

Config.Animations = {
    Watering = {
        Dictionary = "amb@prop_human_bum_bin@base",
        Clip = "base",
        Flag = 1
    },
    Fertilizing = {
        Dictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        Clip = "machinic_loop_mechandplayer",
        Flag = 1
    },
    PlacingLight = {
        Dictionary = "anim@heists@box_carry@",
        Clip = "idle",
        Flag = 50
    }
}

Config.Texts = {
    PlaceObject = "Placer un pot (Placement continu)",
    CancelPlacement = "Arrêter le placement avec X",
    TooClose = "~r~Trop près d'un autre objet",
    PotPlaced = "~g~Pot placé avec succès",
    PotTitle = "Pot",
    PotTitleEmpty = "Pot Vide",
    PotEvolution = "Evolution",
    PotStage = "Étape",
    NoMorePots = "~y~Vous n'avez plus de pots à placer"
}