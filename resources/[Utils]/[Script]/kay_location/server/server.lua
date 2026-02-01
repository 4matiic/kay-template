ESX = exports["framework"]:getSharedObject()

-- Table pour stocker les locations en cours par joueur
local PlayerRentals = {}

-- Fonction helper pour envoyer le résultat au client
local function sendCallback(src, result)
    TriggerClientEvent("loc:callback", src, result)
end

-- Evénement pour acheter/louer un véhicule
RegisterNetEvent("loc:buyLoc")
AddEventHandler("loc:buyLoc", function(price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if not xPlayer then
        sendCallback(_src, "not_enough_money")
        return
    end

    local money = xPlayer.getMoney() -- On utilise cash
    if money >= price then
        xPlayer.removeMoney(price)
        -- On peut stocker info si nécessaire
        PlayerRentals[_src] = {time = os.time(), price = price}
        sendCallback(_src, "can_spawn")
    else
        sendCallback(_src, "not_enough_money")
    end
end)

-- Optionnel : réinitialiser location après X minutes
Citizen.CreateThread(function()
    while true do
        local now = os.time()
        for src, data in pairs(PlayerRentals) do
            if now - data.time > 3600 then -- 1h, par ex.
                PlayerRentals[src] = nil
            end
        end
        Citizen.Wait(60000) -- vérifie toutes les minutes
    end
end)

-- Pour debug : afficher les locations en cours
RegisterCommand("rentstatus", function(src, args, raw)
    print("=== Locations en cours ===")
    for k,v in pairs(PlayerRentals) do
        print("PlayerID:", k, "Price:", v.price, "Time:", v.time)
    end
end, true)
