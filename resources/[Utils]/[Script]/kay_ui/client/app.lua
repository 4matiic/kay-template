local focus = {}
HudReady = false
exports('HasFocus', function()
    for f, _ in pairs(focus) do return true end
    return false
end)

RegisterNUICallback('Hud:Ready', function(data, cb)
    HudReady = true
    TriggerEvent('Hud:Ready')
    cb('ok')
end)

CreateThread(function()
    repeat
        SendReactMessage('Hud:IsReady', {})
        Wait(300)
    until HudReady
    repeat Wait(0) until FB
end)

RegisterNUICallback('ready', function(data, cb)
    repeat Wait(0) until FB
    TriggerServerEvent('kay_ui:getTime')
end)

RegisterNetEvent('kay_ui:time', function(time)
    SendReactMessage('App:Time', time)
end)

RegisterNUICallback('App:OpenedNui', function(data, cb)
    TriggerServerEvent('fb:ac:nui')
    cb('ok')
end)

AddNuiFocus = function(ref)
    focus[ref] = true
    SetNuiFocus(true, true)
end

RemoveNuiFocus = function(ref)
    focus[ref] = nil

    local i = 0
    for _, _ in pairs(focus) do
        i += 1
    end
    if i == 0 then
        SetNuiFocus(false, false)
    end
end

local keepinput = {}
local overrideKeepInput = nil

AddNuiFocusKeepInput = function(ref)
    keepinput[ref] = true
    if overrideKeepInput then return end
    SetNuiFocusKeepInput(true)
end

RemoveNuiFocusKeepInput = function(ref)
    keepinput[ref] = nil
    if overrideKeepInput then return end

    local i = 0
    for _, _ in pairs(keepinput) do
        i += 1
    end
    if i == 0 then
        SetNuiFocusKeepInput(false)
    end
end

AddEventHandler('kay_ui:focus', function(actType, ref)
    if actType == 'AddNuiFocus' then
        AddNuiFocus(ref)
    elseif actType == 'RemoveNuiFocus' then
        RemoveNuiFocus(ref)
    elseif actType == 'AddNuiFocusKeepInput' then
        AddNuiFocusKeepInput(ref)
    elseif actType == 'RemoveNuiFocusKeepInput' then
        RemoveNuiFocusKeepInput(ref)
    end
end)

RegisterCommand('restartui', function()
    SendReactMessage('App:Restart')
    focus = {}
    keepinput = {}
    overrideKeepInput = nil
	SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)
    TriggerEvent('kay_ui:restartui')
end, true)

RegisterNUICallback('Error:Catch', function(data, cb)
    TriggerServerEvent('fb:uierror', data)
    cb('ok')
end)

RegisterNUICallback('Error:CrashRestart', function(data, cb)
    focus = {}
    keepinput = {}
    overrideKeepInput = nil
    SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)
    TriggerEvent('kay_ui:restartui')
    cb('ok')
end)

RegisterNUICallback('App:ToggleInput', function(data, cb)
    overrideKeepInput = data.toggleInput
    if IS_GTA5 then
        repeat Wait(0) until IsDisabledControlReleased(0, 25) and IsDisabledControlReleased(0, 24)
    end
    if overrideKeepInput then
        SetNuiFocusKeepInput(false)
    else
        local i = 0
        for _, _ in pairs(keepinput) do
            i += 1
        end
        SetNuiFocusKeepInput(i > 0)
    end
    cb('ok')
end)

function TableEquals(o1, o2)
	if type(o1) ~= type(o2) or type(o1) ~= 'table' then return o1 == o2 end

	local isEqual = true
	for index, value in pairs(o1) do
		if type(value) == 'table' then
			isEqual = isEqual and TableEquals(value, o2[index])
		else
			isEqual = isEqual and value == o2[index]
		end
	end

	for index, value in pairs(o2) do
		if o1[index] == nil then
			return false
		end
	end

    return isEqual
end
