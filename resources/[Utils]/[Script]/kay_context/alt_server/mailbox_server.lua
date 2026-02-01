-- Server-side mailbox stash registration and open

local function vec3(x, y, z)
    return { x = x, y = y, z = z }
end

RegisterNetEvent('context:mailbox:open')
AddEventHandler('context:mailbox:open', function(coords)
    local src = source
    if not exports.ox_inventory then return end

    local ped = GetPlayerPed(src)
    if not ped or ped == 0 then return end

    local p = GetEntityCoords(ped)
    local dist = #(vector3(p.x, p.y, p.z) - vector3(coords.x, coords.y, coords.z))
    if dist > 4.0 then return end

    local stashId = (('mailbox_%d_%d'):format(math.floor(coords.x), math.floor(coords.y)))
    local label = ('Boîte aux lettres (%d, %d)'):format(math.floor(coords.x), math.floor(coords.y))

    -- Register the stash if not exists; owner=false => stash partagé
    exports.ox_inventory:RegisterStash(stashId, label, 40, 20000, false, nil, vec3(coords.x, coords.y, coords.z))

    -- Open for this player
    TriggerClientEvent('context:mailbox:openClient', src, stashId, false)
end)