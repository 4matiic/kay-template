local labels = {}

RegisterNetEvent('drops:addLabel', function(dropId, coords, text, model)
    labels[dropId] = {coords = coords, text = text, model = model, entity = 0, miss = 0}
end)

CreateThread(function()
    while true do
        local idle = 100
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)

        for id, d in pairs(labels) do
            if d.entity == 0 or not DoesEntityExist(d.entity) then
                d.entity = GetClosestObjectOfType(d.coords.x, d.coords.y, d.coords.z, 1.5, d.model, false, false, false)
            end

            if d.entity ~= 0 and DoesEntityExist(d.entity) then
                local x, y, z = table.unpack(GetEntityCoords(d.entity))
                local dist = #(pcoords - vector3(x, y, z))

                if dist < 2.0 then
                    idle = 0
                    DrawText3D(x, y, z + 0.35, d.text)
                end

                d.miss = 0
            else
                d.miss = d.miss + 1
                if d.miss > 150 then labels[id] = nil end
            end
        end

        Wait(idle)
    end
end)

function DrawText3D(x, y, z, text)
    SetDrawOrigin(x, y, z, 0)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(0, 255, 0, 215)
    SetTextCentre(1)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Joue l'anim quand un item est retiré d'un drop
RegisterNetEvent('drops:playPickupAnim', function()
    local ped = PlayerPedId()
    RequestAnimDict("pickup_object")
    while not HasAnimDictLoaded("pickup_object") do Wait(0) end
    TaskPlayAnim(ped, "pickup_object", "pickup_low", 5.0, -1, 1250, 49, 0, false, false, false)
    Wait(1200)
    ClearPedTasks(ped)
end)