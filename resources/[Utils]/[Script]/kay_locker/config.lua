Config = {}
ESX = exports['framework']:getSharedObject()

Config.MaxCasier = 50 -- Max casier
Config.DefaultSlots = 50 -- Default slots
Config.DefaultWeight = 20000 -- Default weight (20kg)

Config.RegisterStash = function(id, name, slots, weight, owner)
    local slots =  Config.DefaultSlots
    local weight = Config.DefaultWeight
    exports.ox_inventory:RegisterStash(id, name, slots, weight, owner)
end