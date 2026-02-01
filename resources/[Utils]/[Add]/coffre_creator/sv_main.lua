for k,v in ipairs(Config.Chest) do
    exports.ox_inventory:RegisterStash(v.Name, v.Label, v.Slots, v.Poid, v.Personnel)
end