ESX = exports["framework"]:getSharedObject()

function ESX.GetTextInput(title)
    -- exports['menulib']:SetNuiFocusKeepInput(false)
    
    local input = lib.inputDialog(
        title,
        {
            { type = "input", label = title }
        },
        { allowCancel = true }
    )
    
    -- exports['menulib']:SetNuiFocusKeepInput(true)

    if input == nil or input[1] == nil or #input[1] == 0 or input[1] == "" then
        return nil
    end

    return input[1]
end

function ESX.GetNumberInput(title, min, max)
    -- exports['menulib']:SetNuiFocusKeepInput(false)
    
    local input = lib.inputDialog(
        title,
        {
            { type = "number", label = title, min = min or 0, max = max or 999999 }
        },
        { allowCancel = true }
    )
    
    -- exports['menulib']:SetNuiFocusKeepInput(true)

    if input == nil or input[1] == nil then
        return nil
    end

    return tonumber(input[1])
end

function ESX.ShowNotification(message, type)
    lib.notify({
        title = 'Notification',
        description = message,
        type = type or 'info'
    })
end

function ESX.HasPermission(source, permission)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    
    return xPlayer.getGroup() == permission
end

function ESX.GetPlayerPos(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return nil end
    
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    
    return {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        heading = heading
    }
end

function ESX.Progress(title, duration, callback)
    if lib.progressBar({
        duration = duration,
        label = title,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        }
    }) then
        if callback then
            callback(true)
        end
    else
        if callback then
            callback(false)
        end
    end
end

function ESX.GetDistance(coords1, coords2)
    return #(vector3(coords1.x, coords1.y, coords1.z) - vector3(coords2.x, coords2.y, coords2.z))
end

function ESX.CreateBlip(coords, sprite, color, text, scale)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, scale or 1.0)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function ESX.FormatMoney(amount)
    local formatted = tostring(math.floor(amount))
    local k
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end
    return formatted
end

function ESX.CanPlayerAfford(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    
    return xPlayer.getMoney() >= amount
end