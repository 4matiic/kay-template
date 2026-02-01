if not lib then return end

-- Configuration partagée
return {
    deathEvent = 'esx:onPlayerDeath',
    
    messages = {
        cannotDrop = "Cette arme est permanente et ne peut pas être jetée",
        cannotGive = "Cette arme est permanente et ne peut pas être donnée",
        weaponRestored = "Vos armes permanentes ont été restaurées",
        weaponSetPermanent = "Cette arme est maintenant permanente"
    }
} 