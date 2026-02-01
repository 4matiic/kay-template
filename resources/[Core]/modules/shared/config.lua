Config = {
    Settings = {
        DeathTime = 600,
        EMSJob = 'lsmc',
        AdminGroups = {'admin', 'superadmin'}, 
        debugMode = false, 
        SpawnPoint = {
            coords = vector3(1141.93, -1534.45, 35.38),
            heading = 268.93
        }
    },

    Messages = {
        NoPermission = 'Vous n\'avez pas la permission de faire ça.',
        ReviveSuccess = 'Vous avez réanimé %s.',
        EMSAccept = 'Un EMS arrive pour vous!',
        EMSDecline = 'L\'EMS a refusé l\'appel',
        InvalidTarget = 'Joueur invalide.'
    },

    DeathReasons = {
        ['fall'] = 'Chute mortelle',
        ['drown'] = 'Noyade',
        ['weapon'] = 'Blessure par arme',
        ['accident'] = 'Accident de la route',
        ['unknown'] = 'Cause inconnue'
    },

    Logs = {
        enabled = true,
        webhooks = {
            death = "VOTRE_WEBHOOK_ICI", 
            revive = "VOTRE_WEBHOOK_ICI", 
            emsCall = "VOTRE_WEBHOOK_ICI" 
        },
        colors = {
            death = 15158332, 
            revive = 3066993, 
            emsCall = 3447003
        }
    },
}