local lastPositionData = nil
local tmpHideResources = {}
local isHidden = false

local SetPosition = function(positionData)
    if TableEquals(lastPositionData, positionData) then return end
    lastPositionData = positionData

    SendReactMessage('Notifications:SetPosition', positionData)
end

local SetHideNotification = function(hide)
    SendReactMessage('Notifications:hideNotification', hide)
end

CreateThread(function()
    repeat Wait(0) until HudReady
    while true do
        local ui = GetMinimapAnchor()
        local resX, resY = GetActiveScreenResolution()

        local x = ui.x * resX
        local y = ui.x * resY + ui.height * resY
        local width = ui.width * resX

        local tmpHide = false
        for _,_ in pairs(tmpHideResources) do tmpHide = true end

        if IsPauseMenuActive() then
            x = 0
            y = 0
        elseif IS_GTA5 and not IsMinimapRendering() then
            x = ui.x * resX
            y = ui.x * resY * 0.4
        elseif IsBigmapActive() then
            x = ui.x * resX
            y = ui.x * resY + ui.height * resY * 2.4
        elseif  IsRadarHidden() then 
            x = ui.x * resX
            y = ui.x * resY * 1.5
        end

        if tmpHide ~= isHidden then
            SetHideNotification(tmpHide)
        end

        SetPosition({
            x = math.floor(x),
            y = math.floor(y),
            width = math.floor(width * (IsBigmapActive() and 1.6 or 1.0)),
        })

        isHidden = tmpHide

        Wait(100)
    end
end)
local i = 0
exports('addNotification', function(icon, header, title, subtitle, content, duration, sticky, variant)
    i += 1
    SendReactMessage('addNotification', {
        id = i,
        icon = icon,
        header = header,
        title = title,
        subtitle = subtitle,
        content = content,
        duration = duration or 10000,
        sticky = sticky or false,
        variant = variant or "default", -- 🔴 ajout
    })
    return i
end)

RegisterNetEvent('fb_notif:addNotification')
AddEventHandler('fb_notif:addNotification', function(icon, header, title, subtitle, content, duration, sticky, variant)
    exports['ava']:addNotification(icon, header, title, subtitle, content, duration, sticky, variant)
end)


exports('tmpHideNotification', function(value, forceResource)
    if value then
        tmpHideResources[forceResource or GetInvokingResource()] = true
    else
        tmpHideResources[forceResource or GetInvokingResource()] = nil
    end
end)