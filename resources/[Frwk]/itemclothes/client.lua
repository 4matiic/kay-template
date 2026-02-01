ESX = exports["framework"]:getSharedObject()

RegisterNetEvent('savePlayer', function()
    if Config.SkinMethod == 'esx_skin' then
        TriggerEvent('skinchanger:getSkin', function(appearance)
            TriggerServerEvent('itemclothes:saveownesx', getoldskin(), appearance)
        end)
    elseif Config.SkinMethod == 'illenium-appearance' then
        local appearance = exports['illenium-appearance']:getPedAppearance(PlayerPedId())
        TriggerServerEvent("illenium-appearance:server:saveAppearance", appearance)
    end
end)

if Config.SkinMethod == 'esx_skin' then
    local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
    local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}

    function GetDrawables()
        drawables = {}
        local model = GetEntityModel(PlayerPedId())
        local mpPed = false
        if (model == 'mp_f_freemode_01' or model == 'mp_m_freemode_01') then
            mpPed = true
        end
        for i = 0, #drawable_names-1 do
            if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(PlayerPedId(), i) == -1 then
                SetPedComponentVariation(PlayerPedId(), i, 15, 0, 2)
            end
            drawables[tonumber(i)] = {drawable_names[i+1], GetPedDrawableVariation(PlayerPedId(), i)}
        end
        return drawables
    end

    function GetProps()
        props = {}
        for i = 0, #prop_names-1 do
            props[i] = {prop_names[i+1], GetPedPropIndex(PlayerPedId(), i)}
        end
        return props
    end

    function GetDrawTextures()
        textures = {}
        for i = 0, #drawable_names-1 do
            table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(PlayerPedId(), i)})
        end
        return textures
    end

    function GetPropTextures()
        textures = {}
        for i = 0, #prop_names-1 do
            table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(PlayerPedId(), i)})
        end
        return textures
    end

    function getoldskin()
        local skin = {}
        skin.tshirt_1 = GetDrawables()[8][2]
        skin.tshirt_2 = GetDrawTextures()[9][2]
        skin.torso_1 = GetDrawables()[11][2]
        skin.torso_2 = GetDrawTextures()[12][2]
        skin.shoes_1 = GetDrawables()[6][2]
        skin.shoes_2 = GetDrawTextures()[7][2]
        skin.pants_1 = GetDrawables()[4][2]
        skin.pants_2 = GetDrawTextures()[5][2]
        skin.vest_1 = GetDrawables()[9][2]
        skin.vest_2 = GetDrawTextures()[10][2]
        skin.mask_1 = GetDrawables()[1][2]
        skin.mask_2 = GetDrawTextures()[2][2]
        skin.bags_1 = GetDrawables()[5][2]
        skin.bags_2 = GetDrawTextures()[6][2]
        skin.chain_1 = GetDrawables()[7][2]
        skin.chain_2 = GetDrawTextures()[8][2]
        skin.arms = GetDrawables()[3][2]
        skin.arms_2 = GetDrawTextures()[4][2]
        skin.helmet_1 = GetProps()[0][2]
        skin.helmet_2 = GetPropTextures()[1][2]
        skin.glasses_1 = GetProps()[1][2]
        skin.glasses_2 = GetPropTextures()[2][2]
        skin.ears_1 = GetProps()[2][2]
        skin.ears_2 = GetPropTextures()[3][2]
        skin.watches_1 = GetProps()[6][2]
        skin.watches_2 = GetPropTextures()[7][2]
        skin.bracelets_1 = GetProps()[7][2]
        skin.bracelets_2 = GetPropTextures()[8][2]
    return skin
    end
end

RegisterNetEvent('setOutfit', function(components)

    if type(components) == 'table' and next(components) ~= nil then
        if Config.UseRPROGRESS == true then
            exports.rprogress:Custom({
                Duration = 1000,
                ShowTimer = true,
                ShowProgress = false,
                Label = "Changement de tenue...",
                Animation = {
                    animationDictionary = "clothingtie",
                    animationName = "try_tie_positive_a",
                    scenario = nil
                },
                onComplete = function()
                    local ped = PlayerPedId()

                    SetPedComponentVariation(ped, 3, components.Arms.drawable or 0, components.Arms.texture or 0, 0)
                    SetPedComponentVariation(ped, 4, components.Pants.drawable or 0, components.Pants.texture or 0, 0)
                    SetPedComponentVariation(ped, 6, components.Shoes.drawable or 0, components.Shoes.texture or 0, 0)
                    SetPedComponentVariation(ped, 7, components.Accessories.drawable or 0, components.Accessories.texture or 0, 0)
                    SetPedComponentVariation(ped, 8, components.Undershirt.drawable or 0, components.Undershirt.texture or 0, 0)
                    SetPedComponentVariation(ped, 10, components.Decals.drawable or 0, components.Decals.texture or 0, 0)
                    SetPedComponentVariation(ped, 11, components.Torso.drawable or 0, components.Torso.texture or 0, 0)
                    ClearPedProp(ped, 1)
                    SetPedPropIndex(ped, 1, components.Glasses.drawable, components.Glasses.drawable, true)

                    TriggerEvent('savePlayer')
                    exports['pedscreen']:ResetPedScreen()
                end
            })
        else
            local ped = PlayerPedId()

            SetPedComponentVariation(ped, 3, components.Arms.drawable or 0, components.Arms.texture or 0, 0)
            SetPedComponentVariation(ped, 4, components.Pants.drawable or 0, components.Pants.texture or 0, 0)
            SetPedComponentVariation(ped, 6, components.Shoes.drawable or 0, components.Shoes.texture or 0, 0)
            SetPedComponentVariation(ped, 7, components.Accessories.drawable or 0, components.Accessories.texture or 0, 0)
            SetPedComponentVariation(ped, 8, components.Undershirt.drawable or 0, components.Undershirt.texture or 0, 0)
            SetPedComponentVariation(ped, 10, components.Decals.drawable or 0, components.Decals.texture or 0, 0)
            SetPedComponentVariation(ped, 11, components.Torso.drawable or 0, components.Torso.texture or 0, 0)
            ClearPedProp(ped, 1)
            SetPedPropIndex(ped, 1, components.Glasses.drawable, components.Glasses.drawable, true)

            TriggerEvent('savePlayer')
            exports['pedscreen']:ResetPedScreen()
        end
    else
        ESX.ShowNotification("❌ Impossible d'appliquer la tenue. (--> /Report ou Ticket !)")
    end
end)


RegisterNetEvent('setPedComponent', function(components)
    if Config.UseRPROGRESS == true then
        exports.rprogress:Custom({
            Duration = 1000,
            ShowTimer = true,
            ShowProgress = false,
            Label = "Changement de vêtement...",
            Animation = {
                animationDictionary = "clothingtie",
                animationName = "try_tie_positive_a",
                scenario = nil
            },
            onComplete = function()
                SetPedComponentVariation(PlayerPedId(), components.component_id, components.drawable, components.texture, 0)
                TriggerEvent('savePlayer')
                exports['pedscreen']:ResetPedScreen()
            end
        })
    else
        SetPedComponentVariation(PlayerPedId(), components.component_id, components.drawable, components.texture, 0)
        TriggerEvent('savePlayer')
        exports['pedscreen']:ResetPedScreen()
    end
end)

RegisterNetEvent('setPedProp', function(props)
    if Config.UseRPROGRESS == true then
        exports.rprogress:Custom({
            Duration = 1000,
            ShowTimer = true,
            ShowProgress = false,
            Label = "Changement de vêtement...",
            Animation = {
                animationDictionary = "clothingspecs",
                animationName = "try_glasses_positive_a",
                scenario = nil
            },
            onComplete = function()
                ClearPedProp(PlayerPedId(), props.prop_id)
                SetPedPropIndex(PlayerPedId(), props.prop_id, props.drawable, props.texture, true)
                TriggerEvent('savePlayer')
                exports['pedscreen']:ResetPedScreen()
            end
        })
    else
        ClearPedProp(PlayerPedId(), props.prop_id)
        SetPedPropIndex(PlayerPedId(), props.prop_id, props.drawable, props.texture, true)
        TriggerEvent('savePlayer')
        exports['pedscreen']:ResetPedScreen()
    end
end)

local clothesComponentID = {1, 0, 2, 1, 7, 8, 11, 9, 7, 6, 5, 4, 6, 3}
local defaultClothingWoman = {
	[1] = { draw = 0, text = 0 },
	[2] = { draw = -1, text = -1 },
	[3] = { draw = -1, text = -1 },
	[4] = { draw = -1, text = -1 },
	[5] = { draw = 0, text = 0 },
	[6] = { draw = 15, text = 0 },
	[7] = { draw = 15, text = 0 },
	[8] = { draw = 0, text = 0 },
	[9] = { draw = -1, text = -1 },
	[10] = { draw = -1, text = -1 },
	[11] = { draw = 0, text = 0 },
	[12] = { draw = 15, text = 0 },
	[13] = { draw = 35, text = 0 },
    [14] = { draw = 15, text = 0 }
}

local defaultClothingMen = {
	[1] = { draw = 0, text = 0 },
	[2] = { draw = -1, text = -1 },
	[3] = { draw = -1, text = -1 },
	[4] = { draw = -1, text = -1 },
	[5] = { draw = 0, text = 0 },
	[6] = { draw = 15, text = 0 },
	[7] = { draw = 15, text = 0 },
	[8] = { draw = 0, text = 0 },
	[9] = { draw = -1, text = -1 },
	[10] = { draw = -1, text = -1 },
	[11] = { draw = 0, text = 0 },
	[12] = { draw = 21, text = 0 },
	[13] = { draw = 34, text = 0 },
    [14] = { draw = 15, text = 0 }
}

function clearSkin()
	local src = source
    for index, _ in ipairs(clothesComponentID) do
		local playerIdx = GetPlayerFromServerId(src)
        local ped = GetPlayerPed(playerIdx)
        local hash = GetEntityModel(ped)
        if(hash == 1885233650) then
            if index == 2 or index == 4 or index == 3 or index == 10 or index == 9 then
                local props = {
                    texture = defaultClothingMen[index].text,
                    drawable = defaultClothingMen[index].draw,
                    prop_id = clothesComponentID[index]
                }
                ClearPedProp(PlayerPedId(), props.prop_id)

            else
                local components = {
                    texture = defaultClothingMen[index].text,
                    drawable = defaultClothingMen[index].draw,
                    component_id = clothesComponentID[index]
                }
                SetPedComponentVariation(PlayerPedId(), components.component_id, components.drawable, components.texture, 0)
            end
        else
            if index == 2 or index == 4 or index == 3 or index == 10 or index == 9 then
                local props = {
                    texture = defaultClothingWoman[index].text,
                    drawable = defaultClothingWoman[index].draw,
                    prop_id = clothesComponentID[index]
                }
                ClearPedProp(PlayerPedId(), props.prop_id)
            else
                local components = {
                    texture = defaultClothingWoman[index].text,
                    drawable = defaultClothingWoman[index].draw,
                    component_id = clothesComponentID[index]
                }
                SetPedComponentVariation(PlayerPedId(), components.component_id, components.drawable, components.texture, 0)
            end
        end
    end
    TriggerEvent('savePlayer')
end
exports('clearSkin', clearSkin)

RegisterCommand("clearskin", function()
	exports['itemclothes']:clearSkin()
end)

function canChangeClothes(canCC)
    Player(-1).state:set('canChangeClothes', canCC,true)
end
exports('canChangeClothes', canChangeClothes)