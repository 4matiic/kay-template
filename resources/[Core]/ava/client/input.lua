local AllowMove = false
local CanWalk = false
local IsVisible = false
local CurrentRequestId = 0
local DisableControlTask = false

local PendingRequests = {}

local function GetRequestId()
	if CurrentRequestId < 65535 then
		CurrentRequestId = CurrentRequestId + 1
		return CurrentRequestId
	else
		CurrentRequestId = 0
		return CurrentRequestId
	end
end

local ControlsByInput = {
    INPUT_PUSH_TO_TALK = 249, -- N
    INPUT_SELECT_CHARACTER_MICHAEL = 111,
    INPUT_SELECT_CHARACTER_FRANKLIN = 110,
    INPUT_SELECT_CHARACTER_TREVOR = 109,
    INPUT_VEH_PUSHBIKE_FRONT_BRAKE = 72, -- frein avant vélo
    INPUT_CONTEXT_SECONDARY = 51, -- touche E
    INPUT_MOVE_LR = 30,
    INPUT_MOVE_UD = 31,
    INPUT_MOVE_UP_ONLY = 32,
    INPUT_MOVE_DOWN_ONLY = 33,
    INPUT_MOVE_LEFT_ONLY = 34,
    INPUT_MOVE_RIGHT_ONLY = 35
}


local function SpawnMainTask()
	if DisableControlTask then return end
    DisableControlTask = true

    CreateThread(function()
        while DisableControlTask do
            DisableAllControlActions(0)
            EnableControlAction(0, ControlsByInput.INPUT_PUSH_TO_TALK, true)
            EnableControlAction(0, ControlsByInput.INPUT_SELECT_CHARACTER_MICHAEL, true)
            EnableControlAction(0, ControlsByInput.INPUT_SELECT_CHARACTER_FRANKLIN, true)
            EnableControlAction(0, ControlsByInput.INPUT_SELECT_CHARACTER_TREVOR, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_PUSHBIKE_FRONT_BRAKE, true)
            DisableControlAction(0, ControlsByInput.INPUT_CONTEXT_SECONDARY, true)

            if AllowMove and CanWalk then
                EnableControlAction(0, ControlsByInput.INPUT_MOVE_LR, true)
                EnableControlAction(0, ControlsByInput.INPUT_MOVE_UD, true)
                EnableControlAction(0, ControlsByInput.INPUT_MOVE_UP_ONLY, true)
                EnableControlAction(0, ControlsByInput.INPUT_MOVE_DOWN_ONLY, true)
                EnableControlAction(0, ControlsByInput.INPUT_MOVE_LEFT_ONLY, true)
                EnableControlAction(0, ControlsByInput.INPUT_MOVE_RIGHT_ONLY, true)
            end
            Wait(0)
        end
    end)
end

local function Hide()
	SendReactMessage('Input:Hide', {})
	IsVisible = false
	RemoveNuiFocus('input')
	RemoveNuiFocusKeepInput('input')
	DisableControlTask = false
end

exports("ShowInput", function(title_, can_walk, max_length, _type, input_, _password, position)
	assert(type(title_) == 'string', type(title_) .. ' / ' .. tostring(title_))
	assert(type(can_walk) == 'boolean', type(can_walk) .. ' / ' .. tostring(can_walk))
	assert(type(max_length) == 'number', type(max_length) .. ' / ' .. tostring(max_length))
	assert(type(_type) == 'string' and (_type == 'text' or _type == 'small_text' or _type == 'number' or _type == 'text_number'), type(_type) .. ' / ' .. tostring(_type))
	assert(type(input_) == 'string' or type(input_) == 'number' or input_ == nil, type(input_) .. ' / ' .. tostring(input_))
	assert(type(_password) == 'boolean' or _password == nil, type(input_) .. ' / ' .. tostring(input_))
	assert(type(position) == 'string' or position == nil, type(position) .. ' / ' .. tostring(position))

	if IsVisible then return nil end

	local __done = false
	local __return = nil

	local req = GetRequestId()

	IsVisible = true
	CanWalk = can_walk

	SendReactMessage('Input:Prompt', {
		request = req,
		maxlength = max_length,
		title = title_,
		type = _type,
		input = input_,
		password = _password,
		position = position
	})

	PendingRequests[req] = function(data)
		__return = data
		__done = true
	end

	if not DisableControlTask then
		AddNuiFocus('input')
		AddNuiFocusKeepInput('input')
		SpawnMainTask()
	end

	while not __done do
		Wait(0)
	end

	Wait(100)
	return __return
end)

exports("HideInput", function()
	Hide()
end)

RegisterNUICallback("Input:AllowMove", function(data, cb)
	AllowMove = data.AllowMove
	cb('ok')
end)

RegisterNUICallback("Input:Response", function(data, cb)
	Hide()
	local req = data.request
	if req ~= -1 then
		local text = data.value
		if PendingRequests[req] ~= nil then
			PendingRequests[req](text)
			PendingRequests[req] = nil
		end
	end
	cb('ok')
end)
