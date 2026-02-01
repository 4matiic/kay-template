if IS_RDR2 then return end
local ability = 50
local abilityVisiblity = false
local tmpHideResources = {}
local alwaysDisplayMinimap = true
local forceDisplayMinimap = false
local overrideHealthDisplay = nil

local forceHideRadar = false

RegisterNetEvent('six_f5:forceHideRadar', function(state)
    forceHideRadar = state
end)

local function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()

    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = (xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10))))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

local lastHudData = nil
local SetHudData = function(hudData)
    if TableEquals(lastHudData, hudData) then return end
    lastHudData = hudData

    SendReactMessage('Hud:SetHudData', hudData)
end

CreateThread(function()
    SetBlipAlpha(GetNorthRadarBlip(), 100)
    local minimap = RequestScaleformMovie("minimap")
    SetBigmapActive(false, false)
    repeat Wait(0) until HudReady

    DisplayRadar(true)

    SetBigmapActive(true, false)
    Wait(100)
    SetBigmapActive(false, false)
    SetRadarZoom(1000)

    while true do
        local hunger = 0
        local thirst = 0
        local playerPed = PlayerPedId()

        local tmpHide = false
        for _,_ in pairs(tmpHideResources) do tmpHide = true end

        local hideThisFrame = ((IsPauseMenuActive() ~= false and GetPauseMenuSelection() ~= -1000) or tmpHide)
        local hideRadarFrame = forceHideRadar -- forceHideRadar = option "Masquer la mini-carte" F5

        local vehicle = GetVehiclePedIsIn(playerPed)
        local isInAnyVehicle = vehicle > 0 and (GetPedInVehicleSeat(vehicle, -1) == playerPed or GetPedInVehicleSeat(vehicle, 0) == playerPed)
        local displayRadar = (isInAnyVehicle or alwaysDisplayMinimap or forceDisplayMinimap) and not tmpHide
        local armor = GetPedArmour(playerPed)
        local ui = GetMinimapAnchor()
        local resX, resY = GetActiveScreenResolution()

        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.val / 10000
        end)

        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.val / 10000
        end)

        if hideThisFrame then
            HideSpeedometer(true)
            SetHudData({
                hidden = true,
                x = math.floor(ui.x * resX),
                y = math.floor((ui.x * 1.10) * resY),
                width = math.floor(ui.width * resX),
                height = math.floor((ui.height * 0.08) * resY),
            })
        else
            HideSpeedometer(false)
            SetHudData({
                hidden = false,
                x = math.floor(ui.x * resX),
                y = math.floor(displayRadar and (ui.x * 1.10) * resY or 0),
                width = math.floor(ui.width * resX * (IsBigmapActive() and 1.6 or 1.0)),
                height = math.floor((ui.height * 0.08) * resY),
                health = (overrideHealthDisplay or GetEntityHealth(playerPed)) - 100,
                armor = armor > 0 and armor or nil,
                thirst = thirst,
                hunger = hunger,
                stamina = ability and GetPlayerSprintStaminaRemaining(playerPed) > 0 and abilityVisiblity or nil,
            })
        end

        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()

        -- Affiche ou masque uniquement la minimap selon l'option F5
        DisplayRadar(not hideRadarFrame and displayRadar)
        
        Wait(300)
    end
end)

exports('tmpHideHud', function(value, forceResource)
    if value then
        tmpHideResources[forceResource or GetInvokingResource()] = true
    else
        tmpHideResources[forceResource or GetInvokingResource()] = nil
    end
end)

exports('overrideHealthDisplay', function(value)
    overrideHealthDisplay = value
end)

exports('map', function(value)
    displayRadar = value
end)

RegisterNetEvent("Kyz:updateDisplayMinimap")
AddEventHandler("Kyz:updateDisplayMinimap", function(value)
    alwaysDisplayMinimap = value
end)

RegisterNetEvent("Kyz:forceDisplayMinimap")
AddEventHandler("Kyz:forceDisplayMinimap", function(value)
    SetBigmapActive(value, false) -- Active ou désactive la grande carte en fonction de la valeur reçue du serveur
end)

RegisterNetEvent("Kyz:toggleBigmap")
AddEventHandler("Kyz:toggleBigmap", function(value)
    forceDisplayMinimap = value
end)

AddEventHandler('fb:ability:setVisible', function(toggle)
    abilityVisiblity = toggle
end)

AddEventHandler('fb:ability:setValue', function(value)
    ability = value
end)