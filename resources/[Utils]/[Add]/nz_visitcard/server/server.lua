RegisterNetEvent("nz:giveVisitCard", function(data) 
    local src = source 

    local success = exports.ox_inventory:AddItem(src, 'visite_card', 1, {
        name = data.name,
        description = data.description,
        number = data.number,
        image = data.image,
        width = data.width,
        height = data.height,
        imageurl = data.image
    }) 
end) 

RegisterNetEvent("nz:delEmptyCard", function() 
    local src = source

    exports.ox_inventory:RemoveItem(src, 'visite_empty_card', 1)  

end) 


RegisterNetEvent('nz:server:useVisitCard', function(data, radius)
    local src = source
    local playersInArea = GetPlayersInRadius(src, radius)

    for _, playerId in ipairs(playersInArea) do
        TriggerClientEvent('nz:card:show', playerId, data)
    end
end)

function GetPlayersInRadius(source, radius)
    local playersInRadius = {}
    local srcPed = GetPlayerPed(source)
    local srcCoords = GetEntityCoords(srcPed)

    for _, playerId in ipairs(GetPlayers()) do
        if playerId ~= source then
            local targetPed = GetPlayerPed(playerId)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(srcCoords - targetCoords)

            if distance <= radius then
                table.insert(playersInRadius, playerId)
            end
        end
    end

    return playersInRadius
end 