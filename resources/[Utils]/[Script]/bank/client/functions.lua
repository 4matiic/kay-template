function Marker(type, posX, posY, posZ, text)
    DrawMarker(type, posX, posY, posZ - 0.98, 0.0, 0.0, 0.0, 90.0, 270.0, 360.0, 1.0, 1.0, 1.0, 0, 0, 0, 102)

    if text ~= nil then
        ShowHelpNotification(text)
    end
end

function ShowHelpNotification(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end