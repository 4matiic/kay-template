local CHARACTERS = true and 'Characters:'

local ControlsByInput = {
    INPUT_FRONTEND_PAUSE = 199,
    INPUT_FRONTEND_PAUSE_ALTERNATE = 200,
    INPUT_LOOK_LR = 1,
    INPUT_LOOK_UD = 2,
    INPUT_ATTACK = 24,
    INPUT_AIM = 25,
    INPUT_MOVE_LR = 30,
    INPUT_MOVE_UD = 31,
    INPUT_WEAPON_WHEEL_NEXT = 261,
    INPUT_WEAPON_WHEEL_PREV = 262,
    INPUT_CURSOR_SCROLL_UP = 241,
    INPUT_CURSOR_SCROLL_DOWN = 242
}

local tattooCollections = {
    "mpbeach_overlays",
    "multiplayer_overlays",
    "mpbiker_overlays",
    "mpbusiness_overlays",
    "mpchristmas2_overlays",
    "mpgunrunning_overlays",
    "mpheist3_overlays",
    "mpheist4_overlays",
    "mphipster_overlays",
    "mpimportexport_overlays",
    "mpsmuggler_overlays",
    "mpstunt_overlays",
    "mpvinewood_overlays"
}

local function tableCopy(t)
    local copy = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            copy[k] = tableCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end
 
 local function tofloat(num)
    return num and (num + 0.0) or 0.0
 end
 
 local function getComponentId(category)
    local componentIds = {
        face = 0,
        masks = 1,
        hair = 2,
        torsos = 3,
        pants = 4,
        bags = 5,
        shoes = 6,
        necks = 7,
        undershirts = 8,
        vest = 9,
        decals = 10,
        jackets = 11
    }
    return componentIds[category] or 0
 end
 
 local function getPropId(category)
    local propIds = {
        hats = 0,
        glasses = 1,
        earrings = 2,
        watches = 6,
        bracelets = 7
    }
    return propIds[category] or 0
 end

 local constants = {
    HEAD_OVERLAYS = {
        'blemishes',
        'beard',
        'eyebrows',
        'ageing',
        'makeUp',
        'blush',
        'complexion',
        'sunDamage',
        'lipstick',
        'moleAndFreckles',
        'chestHair',
        'bodyBlemishes'
    },
    
    FACE_FEATURES = {
        'noseWidth',
        'nosePeakHigh', 
        'nosePeakSize',
        'noseBoneHigh',
        'nosePeakLowering',
        'noseBoneTwist',
        'eyeBrownHigh',
        'eyeBrownForward',
        'cheeksBoneHigh',
        'cheeksBoneWidth',
        'cheeksWidth',
        'eyesOpening',
        'lipsThickness',
        'jawBoneWidth',
        'jawBoneBackSize',
        'chinBoneLowering',
        'chinBoneLenght',
        'chinBoneSize',
        'chinHole',
        'neckThickness'
    }
}



local function normOpacity(v)
    local o = tonumber(v)
    if o == nil then return 0.0 end     -- défaut à 0%, pas 100%
    if o > 1 then o = o / 100 end       -- support 0–100 venant du NUI
    if o < 0 then o = 0 end
    return math.min(o, 0.99)            -- GTA n’aime pas 1.0 exact
end

local function convertSkinFormat(oldSkin)
    if not oldSkin then return nil end
    
    local currentModel = GetEntityModel(PlayerPedId())
    local defaultModel = currentModel == GetHashKey("mp_f_freemode_01") and "mp_f_freemode_01" or "mp_m_freemode_01"
    
    local headBlendData = oldSkin.headblend or oldSkin.headBlend or {
        shapeFirst = 24,
        shapeSecond = 0, 
        shapeThird = 0,
        skinFirst = 24,
        skinSecond = 0,
        skinThird = 0,
        shapeMix = 0.5,
        skinMix = 0.5,
        thirdMix = 0.0,
        hasParent = false
    }
 
    local newSkin = {
        model = oldSkin.model or defaultModel, 
        headBlend = {
            shapeFirst = tonumber(headBlendData.shapeFirst) or 24,
            shapeSecond = tonumber(headBlendData.shapeSecond) or 0,
            shapeThird = tonumber(headBlendData.shapeThird) or 0, 
            skinFirst = tonumber(headBlendData.skinFirst) or 24,
            skinSecond = tonumber(headBlendData.skinSecond) or 0,
            skinThird = tonumber(headBlendData.skinThird) or 0,
            shapeMix = tonumber(headBlendData.shapeMix) or 0.5,
            skinMix = tonumber(headBlendData.skinMix) or 0.5,
            thirdMix = tonumber(headBlendData.thirdMix) or 0.0
        },
        components = {},
        props = {},
        faceFeatures = {
            noseWidth = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[0]) or 0.0,
            nosePeakHigh = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[1]) or 0.0,
            nosePeakSize = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[2]) or 0.0,
            noseBoneHigh = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[3]) or 0.0,
            nosePeakLowering = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[4]) or 0.0,
            noseBoneTwist = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[5]) or 0.0,
            eyeBrownHigh = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[6]) or 0.0,
            eyeBrownForward = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[7]) or 0.0,
            cheeksBoneHigh = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[8]) or 0.0,
            cheeksBoneWidth = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[9]) or 0.0,
            cheeksWidth = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[10]) or 0.0,
            eyesOpening = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[11]) or 0.0,
            lipsThickness = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[12]) or 0.0,
            jawBoneWidth = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[13]) or 0.0,
            jawBoneBackSize = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[14]) or 0.0,
            chinBoneLowering = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[15]) or 0.0,
            chinBoneLenght = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[16]) or 0.0,
            chinBoneSize = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[17]) or 0.0,
            chinHole = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[18]) or 0.0,
            neckThickness = tonumber(oldSkin.faceFeatures and oldSkin.faceFeatures[19]) or 0.0
        },
        hair = {
            style = oldSkin.hair and oldSkin.hair.style or oldSkin.drawables and oldSkin.drawables.hair and oldSkin.drawables.hair.did or 0,
            color = oldSkin.hair and oldSkin.hair.color or oldSkin.hairColor and oldSkin.hairColor.hair or 0,
            highlight = oldSkin.hair and oldSkin.hair.highlight or oldSkin.hairColor and oldSkin.hairColor.highlight or 0,
            texture = oldSkin.hair and oldSkin.hair.texture or oldSkin.drawables and oldSkin.drawables.hair and oldSkin.drawables.hair.tex or 0
        },
        eyeColor = oldSkin.eyeColor or -1,
        tattoos = oldSkin.tattoos or {},
        headOverlays = {
            blemishes        = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            beard            = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            eyebrows         = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            ageing           = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            makeup           = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            blush            = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            complexion       = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            sunDamage        = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            lipstick         = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            moleAndFreckles  = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            chestHair        = { style = 0, opacity = 0.0, color = 0, secondColor = 0 },
            bodyBlemishes    = { style = 0, opacity = 0.0, color = 0, secondColor = 0 }
        }
    }

    if oldSkin.overlay then
        for k, v in pairs(oldSkin.overlay) do
            local overlayName = k
            if k == 'facialHair' then overlayName = 'beard'
            elseif k == 'molesOrFreckles' then overlayName = 'moleAndFreckles'
            elseif k == 'bodyBlemishes2' then overlayName = 'bodyBlemishes'
            elseif k == 'makeUp' or k == 'makeup' then overlayName = 'makeup'
            elseif k == 'aging' then overlayName = 'ageing'
            end
 
            if newSkin.headOverlays[overlayName] then
                newSkin.headOverlays[overlayName] = {
                    style = tonumber(v.value or v.style) or 0,
                    opacity = normOpacity(v.opacity),
                    color = tonumber(v.firstColour or v.color) or 0,
                    secondColor = tonumber(v.secondColour or v.secondColor) or 0
                }
            end
        end
    end
 
    if oldSkin.drawables then
        for category, data in pairs(oldSkin.drawables) do
            if type(data) == "table" and category ~= "hair" then
                table.insert(newSkin.components, {
                    component_id = getComponentId(category),
                    drawable = tonumber(data.did) or 0,
                    texture = tonumber(data.tex) or 0
                })
            end
        end
    end
 
    if oldSkin.props then
        for category, data in pairs(oldSkin.props) do
            if type(data) == "table" then
                table.insert(newSkin.props, {
                    prop_id = getPropId(category),
                    drawable = tonumber(data.pid) or -1,
                    texture = tonumber(data.tex) or 0
                })
            end
        end
    end
 
    if not newSkin.model then
        newSkin.model = defaultModel
    end
    
    return newSkin
end
 
local function applyHeadBlendAndFeatures(data)
    local playerPed = PlayerPedId()

    local model = GetEntityModel(playerPed)
    if model ~= `mp_m_freemode_01` and model ~= `mp_f_freemode_01` then
        return false
    end

    SetPedHeadBlendData(
        playerPed,
        data.fatherId or 0,        
        data.motherId or 0,       
        0,                     
        data.fatherSkin or 0,     
        data.motherSkin or 0,     
        0,                       
        data.shapeMix or 0.5,    
        data.skinMix or 0.5,     
        0.0                      
    )

    if data.featureIndexX and data.scaleX then
        SetPedFaceFeature(playerPed, data.featureIndexX, data.scaleX)
    end

    if data.featureIndexY and data.scaleY then
        SetPedFaceFeature(playerPed, data.featureIndexY, data.scaleY)
    end

    return true
end

RegisterNetEvent('updateFaceFeatureClient')
AddEventHandler('updateFaceFeatureClient', function(data)
    if data and data.featureIndexX and data.scaleX then
        local playerPed = PlayerPedId()
        SetPedFaceFeature(playerPed, data.featureIndexX, data.scaleX)
        
        local convertedSkin = convertSkinFormat(data)
        TriggerServerEvent('saveAppearance', convertedSkin)
    end
end)

RegisterNUICallback('updateFaceFeature', function(data, cb)

    TriggerServerEvent('updateFaceFeature', data)
    cb('ok')
end)

RegisterNetEvent('applyFaceFeatureChanges')
AddEventHandler('applyFaceFeatureChanges', function(data)
    local playerPed = PlayerPedId()

    if not data or not data.featureIndexX or not data.scaleX then
        return
    end

    if data.featureIndexX == 6 then
        SetPedFaceFeature(playerPed, data.featureIndexX, data.scaleX)
    elseif data.featureIndexX == 7 then
        SetPedFaceFeature(playerPed, data.featureIndexX, data.scaleY)
    elseif data.featureIndexX == 11 then
        SetPedFaceFeature(playerPed, data.featureIndexX, data.scaleX)
    end
end)

RegisterNUICallback('RDR2Characters:SetSexe', function(data, cb)
    if not data or not data.sexe then
        print("[ERREUR-CLIENT] Données invalides reçues depuis le NUI")
        cb({ success = false })
        return
    end

    TriggerServerEvent('RDR2Characters:SetSexe', data)
    cb({ success = true })
end)

RegisterNetEvent('updateHeadClient')
AddEventHandler('updateHeadClient', function(data)
    local playerPed = PlayerPedId()

    if not data or not data.fatherId or not data.motherId or not data.fatherSkin or not data.motherSkin then
        return
    end

    local shapeMix = data.shapeMix or 0.5 
    local skinMix = data.skinMix or 0.5 

    SetPedHeadBlendData(
        playerPed,
        data.fatherId, 
        data.motherId,  
        0,              
        data.fatherSkin, 
        data.motherSkin, 
        0,             
        shapeMix,      
        skinMix,       
        0.0            
    )

end)


RegisterNetEvent('saveAppearance')
AddEventHandler('saveAppearance', function(skin)
    local playerPed = PlayerPedId()
    local currentModel = GetEntityModel(playerPed)
    local modelName = currentModel == GetHashKey("mp_f_freemode_01") and "mp_f_freemode_01" or "mp_m_freemode_01"
    
    if type(skin) == 'table' then
        skin.model = modelName
    end
    
    local convertedSkin = convertSkinFormat(skin)
    TriggerServerEvent('illenium-appearance:server:saveAppearance', convertedSkin)
end)

RegisterNetEvent('loadAppearance')
AddEventHandler('loadAppearance', function(skin)
    local convertedSkin = convertSkinFormat(skin)
    TriggerEvent('illenium-appearance:client:setPedAppearance', convertedSkin)
end)

RegisterNUICallback('updateHead', function(data, cb)

    TriggerServerEvent('updateHead', data)
    cb('ok')
end)

RegisterNetEvent('updateCharacterAppearance')
AddEventHandler('updateCharacterAppearance', function(data)
    TriggerEvent('updateHeadClient', data)
end)

RegisterNUICallback('updateMotherFace', function(data, cb)

    TriggerServerEvent('updateMotherFace', data)
    cb('ok')
end)

RegisterNetEvent('updateHeadClient')
AddEventHandler('updateHeadClient', function(data)
    local playerPed = PlayerPedId()

    if not data or not data.fatherId or not data.motherId or not data.fatherSkin or not data.motherSkin then
        return
    end

    local shapeMix = data.shapeMix or 0.5   
    local skinMix = data.skinMix or 0.5

    SetPedHeadBlendData(
        playerPed,
        data.fatherId,
        data.motherId,
        0,
        data.fatherSkin,
        data.motherSkin,
        0,
        shapeMix,
        skinMix,
        0.0
    )

end)

local lastHeadData = nil
RegisterNetEvent('setSex')
AddEventHandler('setSex', function(data)
    if not data or not data.sexe then
        return
    end
    
    local sexe = data.sexe
    local modelHash = (sexe == "M" or sexe == "m") and `mp_m_freemode_01` or `mp_f_freemode_01`
    
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(0)
    end
    
    SetPlayerModel(PlayerId(), modelHash)
    SetPedDefaultComponentVariation(PlayerPedId())
    
    local playerPed = PlayerPedId()
    if sexe:upper() == "M" then
        SetPedComponentVariation(playerPed, 3, 15, 0, 0)   
        SetPedComponentVariation(playerPed, 4, 61, 1, 0)   
        SetPedComponentVariation(playerPed, 6, 34, 0, 0)  
        SetPedComponentVariation(playerPed, 8, 15, 0, 0)   
        SetPedComponentVariation(playerPed, 11, 15, 0, 0) 
    else
        SetPedComponentVariation(playerPed, 3, 15, 0, 0)   
        SetPedComponentVariation(playerPed, 4, 17, 1, 0)  
        SetPedComponentVariation(playerPed, 6, 35, 0, 0)   
        SetPedComponentVariation(playerPed, 8, 2, 0, 0)    
        SetPedComponentVariation(playerPed, 11, 15, 0, 0) 
    end

    SetModelAsNoLongerNeeded(modelHash)
end)

Config = {
    Overlays = {
        overlay = {
            [3] = 'age',
            [2] = 'eyebrows',
            [1] = 'beard',
            [4] = 'makeup',
            [8] = 'lipstick',
            [0] = 'blemishes',
            [5] = 'blush',
            [7] = 'sun',
            [9] = 'moles',
            [10] = 'chest',
            [11] = 'body',
        },
        drawables = {
            [0] = 'hats',
            [1] = 'masks',
            [3] = 'torsos',
            [4] = 'pants',
            [6] = 'shoes',
            [8] = 'undershirts',
            [11] = 'jackets',
            [10] = 'decals',
            [2] = 'hair',
        },
        props = {
            [1] = 'earrings',
            [2] = 'glasses',
        }
    },
    Prices = {
        overlay = {
            age = 1,
            eyebrows = 2,
            beard = 3,
            makeup = 4,
            lipstick = 5,
            blemishes = 1,
            blush = 2,
            sun = 3,
            moles = 1,
            chest = 4,
            body = 5,
        },
        drawables = {
            hats = 10,
            masks = 15,
            torsos = 20,
            pants = 18,
            shoes = 12,
            undershirts = 8,
            jackets = 25,
            decals = 5,
            hair = 10,
        },
        props = {
            earrings = 7,
            glasses = 12,
        }
    }
}

local cams = {
	['BODY'] = {
        offset = vector3(0, 2.8, 0.3),
        pointAt = vector3(0, 0, 0),
        fov = 45.0,
    },
	['HEAD'] = {
        offset = vector3(0, 1.0, 0.65),
        pointAt = vector3(0, 0.0, 0.6),
        fov = 45.0,
    },
	['CHEST'] = {
        offset = vector3(0, 1.0, 0),
        pointAt = vector3(0, 0, 0),
        fov = 45.0,
    },
    ['ARMS'] = {
        offset = vector3(0, 1.0, 0),
        pointAt = vector3(0, 0, 0),
        fov = 45.0,
    },
    ['HEAD_EARS'] = {
        offset = vector3(0, 1.0, 0.65),
        pointAt = vector3(0, 0, 0.65),
        fov = 45.0,
    },
    ['BODY_BACK'] = {
        offset = vector3(0, 1.0, 0),
        pointAt = vector3(0, 0, 0),
        fov = 45.0,
    },
    ['AERIAL'] = {
        offset = vector3(0, 0, 0),
        pointAt = vector3(0, 0, 0),
        fov = 0.0,
    },
}

local currentCam = nil
local clonedPed = nil
local currentCamType = 'BODY'
local currentZoom = 1.0
local limitations = nil
local targetPed = nil
local previewCategory = nil
local currentSkin = nil
local freeCam = GetResourceKvpInt('freecam') == 1

local YOffset = 0.0

local GetCamPosition = function(camType)
    return GetOffsetFromEntityInWorldCoords(clonedPed, math.lerp(cams[camType].pointAt, cams[camType].offset, currentZoom))
end

local GetCamPositionPointTo = function(camType)
    return GetOffsetFromEntityInWorldCoords(clonedPed, cams[camType].pointAt) + vector3(0, 0, YOffset)
end

local MoveToCam = function(camType, duration)
    if limitations == 'HEALTH' then return end
    if freeCam then
        if currentCam then
            RenderScriptCams(false, true, 1000, true, false, false)

            local deletingCam = currentCam
            SetTimeout(1000, function()
                SetCamActive(deletingCam, false)
                exports.fb:DestroyCam(deletingCam)
            end)
            currentCam = nil
        end
        return
    end
    assert(type(camType) == 'string', 'freeCam ' .. tostring(freeCam))
    assert(type(duration) == 'number', 'freeCam ' .. tostring(freeCam))
    currentCamType = camType
    local position = GetCamPosition(camType)
    local pointCoord = GetCamPositionPointTo(camType)
    local fov = cams[camType].fov

    --[[
    if camType == 'AERIAL' then
        position = vector3(890.07, 1034.03, 8543.52)
        pointCoord = vector3(890.07, 1034.03, 0.0)
        fov = 80.0
        duration = 0
        SetTimecycleModifier('INT_NO_fogALPHA')
        SetTimecycleModifierStrength(1.0)
    else
        ClearTimecycleModifier()
    end
    ]]

    local newCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(newCam, position)
    PointCamAtCoord(newCam, pointCoord)
    SetCamFov(newCam, fov)
    if currentCam then
        if duration == nil or duration <= 0 then
            SetCamActive(newCam, true)
        else
            SetCamActiveWithInterp(newCam, currentCam, duration or 1000, 0, 0)
        end
        local destroyingCam = currentCam
        SetTimeout(duration or 1000, function()
            DestroyCam(destroyingCam)
        end)
    else
        SetCamActive(newCam, true)
    end

    if not currentCam then
        RenderScriptCams(true, true, 1000, true, false, false)
    end
    currentCam = newCam
end

local UpdatePreview = function()
    if not previewCategory then
        return
    end

    local maxTex = 0
    local globeCategory = nil

    for gCat, values in pairs(Config.Overlays) do
        for index, category in pairs(values) do
            if category == previewCategory then
                globeCategory = gCat
                if gCat == 'drawables' then
                    maxTex = GetNumberOfPedTextureVariations(clonedPed, index, currentSkin[globeCategory][previewCategory].did) - 1
                elseif gCat == 'props' then
                    maxTex = GetNumberOfPedPropTextureVariations(clonedPed, index, currentSkin[globeCategory][previewCategory].pid)
                end
            end
        end
    end

    local currentTex = currentSkin[globeCategory][previewCategory].tex

    for i=-3, 3 do
        if i ~= 0 then
            if maxTex > 0 and (currentTex + i) >= 0 and (currentTex + i) <= maxTex then
            else

            end
        end
    end
end

local CreateClonedPed = function()
    if clonedPed then
        DeleteEntity(clonedPed)
    end
    
    clonedPed = ClonePed(targetPed, false)
    Entity(clonedPed).state.deleteOnRestart = true
    SetEntityVisible(clonedPed, false)
    SetEntityCoordsNoOffset(clonedPed, GetEntityCoords(targetPed))
    SetEntityHeading(clonedPed, GetEntityHeading(targetPed))
    FreezeEntityPosition(clonedPed, true)
    SetEntityCanBeDamaged(clonedPed, false)
    if SetPedAsEnemy and not IS_RDR2 then
        SetPedAsEnemy(clonedPed, false)
    end
    SetPedCanBeTargetted(clonedPed, false)
    SetEntityInvincible(clonedPed, true)
    SetBlockingOfNonTemporaryEvents(clonedPed, true)
    SetPedResetFlag(clonedPed, 249, 1)
    SetPedConfigFlag(clonedPed, 185, true)
    SetPedConfigFlag(clonedPed, 108, true)
    if SetPedCanEvasiveDive and not IS_RDR2 then
        SetPedCanEvasiveDive(clonedPed, false)
    end
    SetPedCanRagdollFromPlayerImpact(clonedPed, false)
    SetPedConfigFlag(clonedPed, 208, true)
	SetPedCanBeTargetted(clonedPed, false)
    if SetPedCanLosePropsOnDamage and not IS_RDR2 then
        SetPedCanLosePropsOnDamage(clonedPed, false, 0)
    end
    if SetPedCanPlayInjuredAnims and not IS_RDR2 then
        SetPedCanPlayInjuredAnims(clonedPed, false)
    end
end

function getClothesPrices()
    local prices = {}

    for category, items in pairs(Config.Prices.overlay or {}) do
        if type(items) == "table" then
            for item, price in pairs(items) do
                prices[category .. "_" .. item] = price
            end
        end
    end

    for category, items in pairs(Config.Prices.drawables or {}) do
        if type(items) == "table" then
            for item, price in pairs(items) do
                prices[category .. "_" .. item] = price
            end
        end
    end

    for category, items in pairs(Config.Prices.props or {}) do
        if type(items) == "table" then
            for item, price in pairs(items) do
                prices[category .. "_" .. item] = price
            end
        end
    end

    return prices
end

local clothingPrices = getClothesPrices()
for item, price in pairs(clothingPrices) do
end

RegisterNetEvent('Az_Ui3:characters:edition')
AddEventHandler('Az_Ui3:characters:edition', function(data)
    local prices = getClothesPrices()
    local medicTraits = type(data.medicTraits) == 'table' and data.medicTraits or {}
    medicTraits.specificities = medicTraits.specificities or {}
    medicTraits.allergies = medicTraits.allergies or {}
    medicTraits.diseases = medicTraits.diseases or {}
    medicTraits.addictions = medicTraits.addictions or {}
    medicTraits.bloodType = medicTraits.bloodType or 'A+'

    targetPed = data.targetPedNetId and NetworkGetEntityFromNetworkId(data.targetPedNetId) or PlayerPedId()

    CreateModelHide(-814.51, 175.85, 76.89, 0.1, `v_ilev_mm_doorw`, false)
    CreateModelHide(-814.72, 174.02, 75.74, 0.1, `v_res_m_h_sofa_sml`, false)

    ClearPedTasksImmediately(PlayerPedId())

    SetPedCanPlayAmbientAnims(PlayerPedId(), false)
    if SetPedCanPlayAmbientIdles and not IS_RDR2 then
        SetPedCanPlayAmbientIdles(PlayerPedId(), false, false)
    end
    SetFacialIdleAnimOverride(PlayerPedId(), 'mood_Normal_1', nil)

    limitations = data.limitations
    currentSkin = data.skin
    SendReactMessage(CHARACTERS .. 'SetLimitations', data.limitations)
    SendReactMessage(CHARACTERS .. 'SetPrices', prices)
    SendReactMessage(CHARACTERS .. 'SetCharacter', {
        sexe = data.sexe or 'M',
        firstname = data.firstname or '',
        lastname = data.lastname or '',
        nationality = data.nationality or '',
        dateofbirth = data.dateofbirth or '',
        medicTraits = medicTraits,
        skin = data.skin,
        model = data.model,
        metaPedType = data.metaPedType,
    })

    if limitations == 'CREATION' then
        TriggerEvent('fb:disableWeather', 'characters', true)
    end

    if currentCam then
        DestroyCam(currentCam)
        currentCam = nil
    end

    CreateClonedPed()

    MoveToCam('BODY', 0)
    YOffset = 0.0

    AddNuiFocus('characters')
    AddNuiFocusKeepInput('characters')

    

    -- >>> Injected: set gender for UI at menu open
    do
        local ped = PlayerPedId()
        local g = IsPedMale(ped) and "male" or "female"
        SendNUIMessage({ type = "setGender", gender = g })
    end
    -- <<< Injected
local heading = nil
    local height = nil
    local cursorPosX = nil
    local cursorPosY = nil

    local lastPressed = GetGameTimer()
    local lastRotation = GetGameTimer()

    --[[exports.fb:addInstructionalButtons({
        {
            {'~INPUT_CONTEXT_SECONDARY~', '~INPUT_PICKUP~'},
            'Regarder gauche/droite',
        },
        {
            {'~INPUT_VEH_GUN_LR~'},
            'Tourner le personnage',
        },
        {
            {'~INPUT_CELLPHONE_RIGHT~', '~INPUT_CELLPHONE_LEFT~'},
            'Texture préc/suivante',
        },
        {
            {'~INPUT_WEAPON_WHEEL_NEXT~', '~INPUT_WEAPON_WHEEL_PREV~'},
            'Zoom',
        },
        {
            '~INPUT_JUMP~',
            'Caméra libre',
        },
        FB.IsStaff() and {
            '~INPUT_VEH_HEADLIGHT~',
            'Défini le prix'
        } or nil
    })]]

    FreezeEntityPosition(PlayerPedId(), true)

    while clonedPed do
        local x, y = GetNuiCursorPosition()
        local resX, resY = GetActiveScreenResolution()
        local isInsideNui = x/resX > (IS_RDR2 and 0.48 or 0.31)

        local _, hit = GetShapeTestResult(StartExpensiveSynchronousShapeTestLosProbe(GetFinalRenderedCamCoord(), GetEntityCoords(targetPed), 17, PlayerPedId(), 1))

        local isFixedCamInvalid = (GetInteriorFromPrimaryView() ~= GetInteriorFromEntity(targetPed) or hit == 1 or hit == true)
        if limitations == 'CREATION' then
            isFixedCamInvalid = false
        end
        if isFixedCamInvalid and not freeCam and DoesEntityExist(targetPed) then
            freeCam = true
            MoveToCam()
        end

        if freeCam and not isFixedCamInvalid and GetResourceKvpInt('freecam') ~= 1 then
            MoveToCam(currentCamType, 0)
        end

        if ResetPedMovementClipset then
            ResetPedMovementClipset(targetPed, 0)
        end
        SetPlayerControl(PlayerId(), freeCam, 0)

        if freeCam then
            local x, y = GetNuiCursorPosition()
            local maxX, maxY = GetActiveScreenResolution()

            x = x / maxX
            y = y / maxY

            local allowZone = 0.02

            if x < (1 - allowZone) and x > allowZone and y < (1 - allowZone) and y > allowZone then
                DisableControlAction(0, ControlsByInput.INPUT_LOOK_LR, true)
                DisableControlAction(0, ControlsByInput.INPUT_LOOK_UD, true)
            end

            DisableControlAction(0, ControlsByInput.INPUT_WEAPON_WHEEL_UD, true)
            DisableControlAction(0, ControlsByInput.INPUT_WEAPON_WHEEL_LR, true)
            DisableControlAction(0, ControlsByInput.INPUT_WEAPON_WHEEL_NEXT, true)
            DisableControlAction(0, ControlsByInput.INPUT_WEAPON_WHEEL_PREV, true)
            DisableControlAction(0, ControlsByInput.INPUT_SELECT_NEXT_WEAPON, true)
            DisableControlAction(0, ControlsByInput.INPUT_SELECT_PREV_WEAPON, true)
            DisableControlAction(0, ControlsByInput.INPUT_SPRINT, true)
            DisableControlAction(0, ControlsByInput.INPUT_JUMP, true)
            DisableControlAction(0, ControlsByInput.INPUT_ENTER, true)
            DisableControlAction(0, ControlsByInput.INPUT_ATTACK, true)
            DisableControlAction(0, ControlsByInput.INPUT_AIM, true)
            DisableControlAction(0, ControlsByInput.INPUT_MOVE_LR, true)
            DisableControlAction(0, ControlsByInput.INPUT_MOVE_UD, true)
            DisableControlAction(0, ControlsByInput.INPUT_MOVE_UP_ONLY, true)
            DisableControlAction(0, ControlsByInput.INPUT_MOVE_DOWN_ONLY, true)
            DisableControlAction(0, ControlsByInput.INPUT_MOVE_LEFT_ONLY, true)
            DisableControlAction(0, ControlsByInput.INPUT_MOVE_RIGHT_ONLY, true)
            DisableControlAction(0, ControlsByInput.INPUT_DUCK, true)
            DisableControlAction(0, ControlsByInput.INPUT_SELECT_WEAPON, true)
            DisableControlAction(0, ControlsByInput.INPUT_PICKUP, true)
            DisableControlAction(0, ControlsByInput.INPUT_COVER, true)
            DisableControlAction(0, ControlsByInput.INPUT_RELOAD, true)
            DisableControlAction(0, ControlsByInput.INPUT_DETONATE, true)
            DisableControlAction(0, ControlsByInput.INPUT_ACCURATE_AIM, true)
            DisableControlAction(0, ControlsByInput.INPUT_DIVE, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_MOVE_LR, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_MOVE_UD, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_MOVE_UP_ONLY, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_MOVE_DOWN_ONLY, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_MOVE_LEFT_ONLY, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_MOVE_RIGHT_ONLY, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_SPECIAL, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_ATTACK, true)
            DisableControlAction(0, ControlsByInput.INPUT_VEH_ACCELERATE, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_EXIT, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_HANDBRAKE, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_NEXT_RADIO, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_PREV_RADIO, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_PASSENGER_AIM, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_PASSENGER_ATTACK, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_SELECT_NEXT_WEAPON, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_MOUSE_CONTROL_OVERRIDE, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_FLY_ATTACK, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_FLY_SELECT_NEXT_WEAPON, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_FLY_ATTACK_CAMERA, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE, true)
			DisableControlAction(0, ControlsByInput.INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE, true)
			DisableControlAction(0, ControlsByInput.INPUT_MELEE_ATTACK_LIGHT, true)
			DisableControlAction(0, ControlsByInput.INPUT_FRONTEND_PAUSE, true)
			DisableControlAction(0, ControlsByInput.INPUT_FRONTEND_PAUSE_ALTERNATE, true)
            DisableControlAction(0, ControlsByInput.INPUT_MP_TEXT_CHAT_ALL, true)
			DisableControlAction(0, ControlsByInput.INPUT_MP_TEXT_CHAT_TEAM, true)
			DisableControlAction(0, ControlsByInput.INPUT_ATTACK2, true)
        end

        if IsDisabledControlJustPressed(0, ControlsByInput.INPUT_JUMP) then
            freeCam = not freeCam
            MoveToCam(currentCamType, 500)
            SetResourceKvpInt('freecam', freeCam and 1 or 0)
        end

        if PlayerPedId() == targetPed then
            if IsDisabledControlPressed(0, ControlsByInput.INPUT_CONTEXT_SECONDARY) then
                TaskLookAtCoord(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), -1.2, 0.5, 0.7), 1100)
            elseif IsDisabledControlPressed(0, ControlsByInput.INPUT_CONTEXT or ControlsByInput.INPUT_REVIVE) then
                TaskLookAtCoord(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.2, 0.5, 0.7), 1100)
            else
                TaskLookAtCoord(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.5, 0.7), 1100)
            end
        end

        if not IsEntityPlayingAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_base', 3) then
            ClearPedTasks(PlayerPedId())
        end

        DisableControlAction(0, ControlsByInput.INPUT_FRONTEND_PAUSE, true)
        DisableControlAction(0, ControlsByInput.INPUT_FRONTEND_PAUSE_ALTERNATE, true)

        if IsDisabledControlJustPressed(0, ControlsByInput.INPUT_ATTACK) and isInsideNui then
            heading = GetEntityHeading(targetPed)
            height = YOffset
            cursorPosX = x
            cursorPosY = y
        end

        if IsDisabledControlJustReleased(0, ControlsByInput.INPUT_ATTACK) then
            cursorPosX = nil
        end

        if IsDisabledControlJustPressed(0, ControlsByInput.INPUT_VEH_HEADLIGHT) then
            local newPrice = exports.Ratus_ui:ShowInput('Prix', false, 32, "number")
            if not newPrice or newPrice == '' or tonumber(newPrice) < 0 then return end

            local id = currentSkin.drawables[previewCategory]?.did or currentSkin.props[previewCategory]?.pid
            local tex = currentSkin.drawables[previewCategory]?.tex or currentSkin.props[previewCategory]?.tex
            local name = 'clothes.' .. (IsPedMale(PlayerPedId()) and 'male' or 'female') .. '.' .. previewCategory .. '.' .. id .. '.' .. tex
            TriggerServerEvent('fb:numbervars:changeNumberVar', name, tonumber(newPrice))
        end

        local function UpdatePointCam()
            SetCamCoord(currentCam, GetCamPosition(currentCamType) + vector3(0, 0, YOffset))
            local pointCoord = GetCamPositionPointTo(currentCamType)
            PointCamAtCoord(currentCam, pointCoord)
        end
        if IsDisabledControlPressed(0, ControlsByInput.INPUT_ATTACK) and (cursorPosX and cursorPosY) then
            local currentX, currentY = GetNuiCursorPosition()
            local newHeading = heading + (currentX - cursorPosX) * 0.5
            local newHeight = height + (currentY - cursorPosY) * 0.002
            if newHeight > -1.4 and newHeight < 0.5 then
                YOffset = newHeight
            end
            if freeCam then
                SetEntityHeading(clonedPed, newHeading)
                UpdatePointCam()
            end

            if targetPed == PlayerPedId() then
                SetEntityHeading(PlayerPedId(), newHeading)
                UpdatePointCam()
            else
                if GetGameTimer() - lastRotation > 200 then
                    lastRotation = GetGameTimer()
                    TriggerServerEvent('fb:player:rotateSkin', newHeading)
                end
            end
        end

        local zoom = currentZoom

        if not freeCam and IsDisabledControlJustPressed(0, ControlsByInput.INPUT_CURSOR_SCROLL_UP) and isInsideNui then
            zoom -= 0.2
            if zoom < 0.2 then zoom = 0.2 end
        end

        if not freeCam and IsDisabledControlJustPressed(0, ControlsByInput.INPUT_CURSOR_SCROLL_DOWN) and isInsideNui then
            zoom += 0.2
            if zoom > 1.0 then zoom = 1.0 end
        end

        if not freeCam and currentZoom ~= zoom then
            currentZoom = zoom
            MoveToCam(currentCamType, 500)
        end

        if currentCamType == 'AERIAL' then
            ClearCloudHat()
        end

        if previewCategory then
            local maxTex = 0
            local globeCategory = nil

            for gCat, values in pairs(Config.Overlays) do
                for index, category in pairs(values) do
                    if category == previewCategory then
                        globeCategory = gCat
                        if gCat == 'drawables' then
                            maxTex = GetNumberOfPedTextureVariations(clonedPed, index, currentSkin[globeCategory][previewCategory].did) - 1
                        elseif gCat == 'props' then
                            maxTex = GetNumberOfPedPropTextureVariations(clonedPed, index, currentSkin[globeCategory][previewCategory].pid)
                        end
                    end
                end
            end

            local currentTex = currentSkin[globeCategory][previewCategory].tex

            if (IsDisabledControlJustPressed(0, ControlsByInput.INPUT_CELLPHONE_RIGHT) or (IsDisabledControlPressed(0, ControlsByInput.INPUT_CELLPHONE_RIGHT) and GetGameTimer() - lastPressed > 500)) and currentTex < maxTex then
                lastPressed = GetGameTimer()
                currentSkin[globeCategory][previewCategory].tex = currentTex + 1
                SendReactMessage(CHARACTERS .. 'SetSkin', currentSkin)
                UpdatePreview()
            end

            if (IsDisabledControlJustPressed(0, ControlsByInput.INPUT_CELLPHONE_LEFT) or (IsDisabledControlPressed(0, ControlsByInput.INPUT_CELLPHONE_LEFT) and GetGameTimer() - lastPressed > 500)) and currentTex > 0 then
                lastPressed = GetGameTimer()
                currentSkin[globeCategory][previewCategory].tex = currentTex - 1
                SendReactMessage(CHARACTERS .. 'SetSkin', currentSkin)
                UpdatePreview()
            end
        end

        Wait(0)
    end

    if targetPed == PlayerPedId() then
        StopEntityAnim(targetPed, 'handsup_base', 'missminuteman_1ig_2', 3)
    end
    freeCam = GetResourceKvpInt('freecam') == 1

    cleanPreviewPeds()
    TriggerEvent('fb:movement:calculate')
end)

RegisterNetEvent('Az_Ui3:characters:close', function()
    if not clonedPed then return end

    SetPlayerControl(PlayerId(), true, 0)
    FreezeEntityPosition(PlayerPedId(), false)

    TriggerEvent('fb:disableWeather', 'characters', false)
    RemoveNuiFocus('characters')
    RemoveNuiFocusKeepInput('characters')

    if clonedPed then
        DeleteEntity(clonedPed)
        clonedPed = nil
    end
    
    previewCategory = nil
    currentSkin = nil
    freeCam = false

    if currentCam then
        RenderScriptCams(false, true, 500, true, true)
        DestroyCam(currentCam, true)
        currentCam = nil
    end

    ClearPedTasksImmediately(PlayerPedId())
    SetPedCanPlayAmbientAnims(PlayerPedId(), true)
    if SetPedCanPlayAmbientIdles and not IS_RDR2 then
        SetPedCanPlayAmbientIdles(PlayerPedId(), true, true)
    end

    SendReactMessage(CHARACTERS .. 'SetCharacter', nil)
end)

RegisterNUICallback(CHARACTERS .. 'SetCam', function(data, cb)
    if not clonedPed then return cb(true) end
    YOffset = 0.0
    MoveToCam(data.cam, 500)
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'HandsUp', function(data, cb)
    if IsEntityPlayingAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_base', 3) then
        StopEntityAnim(PlayerPedId(), 'handsup_base', 'missminuteman_1ig_2', 3)
    else
        RequestAnimDict('missminuteman_1ig_2')
        repeat Wait(0) until HasAnimDictLoaded('missminuteman_1ig_2')
        TaskPlayAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_base', 2.0, 2.0, -1, 1, 0, false, false, false)
        RemoveAnimDict('missminuteman_1ig_2')
    end
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'Save', function(data, cb)
    if not clonedPed then return cb(true) end

    if data?.skin?.shopItems then
        local shopItems = {}
        for hash, item in pairs(data.skin.shopItems) do
            shopItems[tonumber(hash)] = item
        end
        data.skin.shopItems = shopItems
    end

    if data.cancel or data.skin == nil then
        TriggerServerEvent('fb:player:cancelSkin')
    elseif data.creation then
        local convertedSkin = convertSkinFormat(data.skin)
        data.skin = convertedSkin
        TriggerServerEvent('fb:character:createCharacter', data)
        TriggerServerEvent('saveAppearance', convertedSkin)
    else
        local convertedSkin = convertSkinFormat(data.skin)
        TriggerServerEvent('saveAppearance', convertedSkin)
    end
    
    exports[GetCurrentResourceName()]:CloseCharacters()
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'ApplyClothes', function(data, cb)
    if not data or not data.data then return cb(false) end

    local convertedSkin = convertSkinFormat(data.data)
    if not convertedSkin then 
        print("^1[ERROR] Failed to convert clothes format^0")
        return cb(false) 
    end

    TriggerServerEvent('saveAppearance', convertedSkin)
    
    currentSkin = convertedSkin
    
    print("^2[SUCCESS] Clothes applied and saved successfully^0")
    cb(true)
 end)

RegisterNUICallback(CHARACTERS .. 'SetSexe', function(data, cb)
    if not data or not data.sexe then
        print("[ERREUR-CLIENT] Données invalides reçues depuis le NUI")
        cb({ success = false })
        return
    end

    ESX.TriggerServerCallback('fb:player:setSexe', function(targetPedNetId, a, b)
        if not targetPedNetId then return cb(nil) end
        
        if clonedPed then
            DeletePed(clonedPed)
            clonedPed = nil
        end
        
        local model = data.sexe == 'M' and 'mp_m_freemode_01' or 'mp_f_freemode_01'
        local hash = GetHashKey(model)
        
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(0)
        end
        
        targetPed = NetworkGetEntityFromNetworkId(targetPedNetId)
        SetPlayerModel(PlayerId(), hash)
        SetModelAsNoLongerNeeded(hash)
        
        local playerPed = PlayerPedId()
        ClearPedDecorations(playerPed)
        ClearPedFacialDecorations(playerPed)
        ClearAllPedProps(playerPed)
        
        for i = 0, 11 do
            SetPedHeadOverlay(playerPed, i, 0, 0.0)
        end
        
        for i = 0, 19 do
            SetPedFaceFeature(playerPed, i, 0.0)
        end
        
        SetPedHairColor(playerPed, 0, 0)
        
        CreateClonedPed()
        
        local defaultSkin = data.sexe == 'M' and Config.DefaultCharacter['mp_m_freemode_01'] or Config.DefaultCharacter['mp_f_freemode_01']
        if not defaultSkin then
            defaultSkin = Config.DefaultCharacter.default
        end
        
        if defaultSkin then
            TriggerEvent('skinchanger:loadSkin', defaultSkin)
        end
        
        freeCam = GetResourceKvpInt('freecam') == 1
        if not freeCam then
            MoveToCam(currentCamType, 0)
        end
        
        cb(defaultSkin)
    end, data.sexe)
end)

RegisterNUICallback(CHARACTERS .. 'UpdateFaceFeature', function(data, cb)
    if not clonedPed then return cb(false) end
    
    local playerPed = PlayerPedId()
    
    if not data or not data.index or not data.scale then
        return cb(false)
    end
    
    local index = tonumber(data.index)
    local scale = tonumber(data.scale)
    
    if index >= 0 and index <= 19 then
        SetPedFaceFeature(playerPed, index, scale)
        
        if clonedPed and DoesEntityExist(clonedPed) then
            SetPedFaceFeature(clonedPed, index, scale)
        end
    end
    
    cb(true)
end)

RegisterNetEvent('updateCharacterFeatures')
AddEventHandler('updateCharacterFeatures', function(data)
    local playerPed = PlayerPedId()
    
    SetPedComponentVariation(playerPed, 2, data.hair.style or 0, 0, 0)
    SetPedHairColor(playerPed, data.hair.color or 0, data.hair.highlight or 0)

    local beardOpacity = normOpacity(data.beard and data.beard.opacity)
    SetPedHeadOverlay(playerPed, 1, data.beard and data.beard.style or 0, beardOpacity)

    local ebOpacity = normOpacity(data.eyebrows and data.eyebrows.opacity)
    SetPedHeadOverlay(playerPed, 2, data.eyebrows and data.eyebrows.style or 0, ebOpacity)
    SetPedHeadOverlayColor(playerPed, 2, 1, data.eyebrows and data.eyebrows.color or 0, data.eyebrows and data.eyebrows.secondColor or 0)

    local currentDrawable = GetPedDrawableVariation(playerPed, 0)
    SetPedComponentVariation(playerPed, 0, currentDrawable, 0, 0)
end)

RegisterNUICallback(CHARACTERS .. 'ApplySkin', function(data, cb)
    local playerPed = PlayerPedId()
    local isFemale = GetEntityModel(playerPed) == GetHashKey('mp_f_freemode_01')
    
    if data.faceFeatures then
        for index, value in pairs(data.faceFeatures) do
            local featureIndex = tonumber(index)
            if featureIndex >= 0 and featureIndex <= 20 then
                SetPedFaceFeature(playerPed, featureIndex, math.min(1.0, math.max(-1.0, value)))
            end
        end
    end
    
    if data.drawables and data.drawables.hair then
        SetPedComponentVariation(playerPed, 2, data.drawables.hair.did or 0, data.drawables.hair.tex or 0, 0)
        if data.hairColor then
            SetPedHairColor(playerPed, data.hairColor.hair or 0, data.hairColor.highlight or 0)
        end
    end
    
if data.overlay then
    -- Barbe
    if data.overlay.facialHair then
        local op = normOpacity(data.overlay.facialHair.opacity)
        SetPedHeadOverlay(playerPed, 1, data.overlay.facialHair.value or 0, op)
        SetPedHeadOverlayColor(playerPed, 1, 1, data.overlay.facialHair.firstColour or 0, data.overlay.facialHair.secondColour or 0)
    end

    -- Sourcils
    if data.overlay.eyebrows then
        local op = normOpacity(data.overlay.eyebrows.opacity)
        SetPedHeadOverlay(playerPed, 2, data.overlay.eyebrows.value or 0, op)
        SetPedHeadOverlayColor(playerPed, 2, 1, data.overlay.eyebrows.firstColour or 0, data.overlay.eyebrows.secondColour or 0)
    end

    -- Age (aging/ageing)
    local aging = data.overlay.aging or data.overlay.ageing
    if aging then
        local op = normOpacity(aging.opacity)
        SetPedHeadOverlay(playerPed, 3, aging.value or 0, op)
    end

    -- Maquillage (makeup/makeUp) -> type couleur 2
    local makeup = data.overlay.makeup or data.overlay.makeUp
    if makeup then
        local op = normOpacity(makeup.opacity)
        SetPedHeadOverlay(playerPed, 4, makeup.value or 0, op)
        SetPedHeadOverlayColor(playerPed, 4, 2, makeup.firstColour or 0, makeup.secondColour or 0)
    end

    -- Blush -> type couleur 2
    if data.overlay.blush then
        local op = normOpacity(data.overlay.blush.opacity)
        SetPedHeadOverlay(playerPed, 5, data.overlay.blush.value or 0, op)
        SetPedHeadOverlayColor(playerPed, 5, 2, data.overlay.blush.firstColour or 0, data.overlay.blush.secondColour or 0)
    end

    -- Complexion (complexion/complextion)
    local complexion = data.overlay.complexion or data.overlay.complextion
    if complexion then
        local op = normOpacity(complexion.opacity)
        SetPedHeadOverlay(playerPed, 6, complexion.value or 0, op)
    end

    -- Sun damage (sunDamage/sun)
    local sun = data.overlay.sunDamage or data.overlay.sun
    if sun then
        local op = normOpacity(sun.opacity)
        SetPedHeadOverlay(playerPed, 7, sun.value or 0, op)
    end

    -- Rouge à lèvres (lipstick) -> type couleur 2
    if data.overlay.lipstick then
        local op = normOpacity(data.overlay.lipstick.opacity)
        SetPedHeadOverlay(playerPed, 8, data.overlay.lipstick.value or 0, op)
        SetPedHeadOverlayColor(playerPed, 8, 2, data.overlay.lipstick.firstColour or 0, data.overlay.lipstick.secondColour or 0)
    end

    -- Grains/Taches (molesOrFreckles/moles)
    local moles = data.overlay.molesOrFreckles or data.overlay.moles
    if moles then
        local op = normOpacity(moles.opacity)
        SetPedHeadOverlay(playerPed, 9, moles.value or 0, op)
    end

    -- Poils torse (chestHair/chest) -> type couleur 1
    local chest = data.overlay.chestHair or data.overlay.chest
    if chest then
        local op = normOpacity(chest.opacity)
        SetPedHeadOverlay(playerPed, 10, chest.value or 0, op)
        SetPedHeadOverlayColor(playerPed, 10, 1, chest.firstColour or 0, chest.secondColour or 0)
    end

    -- Imperfections corps (bodyBlemishes/body)
    local body = data.overlay.bodyBlemishes or data.overlay.body
    if body then
        local op = normOpacity(body.opacity)
        SetPedHeadOverlay(playerPed, 11, body.value or 0, op)
    end

    -- Blemishes visage (index 0)
    if data.overlay.blemishes then
        local op = normOpacity(data.overlay.blemishes.opacity)
        SetPedHeadOverlay(playerPed, 0, data.overlay.blemishes.value or 0, op)
    end
end

 
    if data.eyeColor then
        SetPedEyeColor(playerPed, data.eyeColor)
    end
 
    if data.tattoos then
        ClearPedDecorations(playerPed)
        for _, tattooData in pairs(data.tattoos) do
            if tattooData.collection and tattooData.overlay then
                AddPedDecorationFromHashes(
                    playerPed, 
                    GetHashKey(tattooData.collection),
                    GetHashKey(tattooData.overlay)
                )
            end
        end
    end
 
    if data.outfit_name == "Tenue Nord" or data.isTenueNord then
        if isFemale then
            SetPedComponentVariation(playerPed, 3, 15, 0, 0)
            SetPedComponentVariation(playerPed, 8, 14, 0, 0)
            SetPedComponentVariation(playerPed, 11, 141, 0, 0)
            SetPedComponentVariation(playerPed, 4, 121, 0, 0)
            SetPedComponentVariation(playerPed, 6, 152, 0, 0)
        else
            SetPedComponentVariation(playerPed, 3, 15, 0, 0)
            SetPedComponentVariation(playerPed, 8, 15, 0, 0)
            SetPedComponentVariation(playerPed, 11, 76, 0, 0)
            SetPedComponentVariation(playerPed, 4, 172, 0, 0)
            SetPedComponentVariation(playerPed, 6, 149, 0, 0)
        end
        
        for i=0, 7 do ClearPedProp(playerPed, i) end
        
        TriggerEvent('skinchanger:getSkin', function(skin)
            skin.sex = isFemale and 'f' or 'm'
            skin.model = isFemale and 'mp_f_freemode_01' or 'mp_m_freemode_01'
            TriggerServerEvent('esx_skin:save', skin)
        end)
 
        cb(true)
        return
    end
 
    if data.outfit_name == "Tenue Sud" or data.isTenueSud then
        if isFemale then
            SetPedComponentVariation(playerPed, 3, 15, 0, 0)
            SetPedComponentVariation(playerPed, 8, 14, 0, 0)
            SetPedComponentVariation(playerPed, 11, 18, 0, 0)
            SetPedComponentVariation(playerPed, 4, 23, 0, 0)
            SetPedComponentVariation(playerPed, 6, 19, 0, 0)
        else
            SetPedComponentVariation(playerPed, 3, 5, 0, 0)
            SetPedComponentVariation(playerPed, 8, 15, 0, 0)
            SetPedComponentVariation(playerPed, 11, 5, 0, 0)
            SetPedComponentVariation(playerPed, 4, 5, 0, 0)
            SetPedComponentVariation(playerPed, 6, 3, 0, 0)
        end
        
        for i=0, 7 do ClearPedProp(playerPed, i) end
        
        TriggerEvent('skinchanger:getSkin', function(skin)
            skin.sex = isFemale and 'f' or 'm'
            skin.model = isFemale and 'mp_f_freemode_01' or 'mp_m_freemode_01'
            TriggerServerEvent('esx_skin:save', skin)
        end)
 
        cb(true)
        return
    end
 
    Wait(0)
    local currentDrawable = GetPedDrawableVariation(playerPed, 0)
    SetPedComponentVariation(playerPed, 0, currentDrawable, 0, 0)
    
    currentSkin = data
    cb(true)
 end)


RegisterNUICallback(CHARACTERS .. 'SelectTattoo', function(data, cb)
    if not data or not data.collection or not data.overlay then
        return cb(false)
    end
    
    local playerPed = PlayerPedId()
    
    if not currentSkin then
        currentSkin = {
            tattoos = {}
        }
    end
    
    if not currentSkin.tattoos then
        currentSkin.tattoos = {}
    end
    
    table.insert(currentSkin.tattoos, {
        collection = data.collection,
        overlay = data.overlay,
        zone = data.zone 
    })
    
    ClearPedDecorations(playerPed)
    for _, tattoo in pairs(currentSkin.tattoos) do
        AddPedDecorationFromHashes(
            playerPed,
            GetHashKey(tattoo.collection),
            GetHashKey(tattoo.overlay)
        )
    end
    
    SendReactMessage(CHARACTERS .. 'SetSkin', currentSkin)
    
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'RemoveTattoo', function(data, cb)
    if not currentSkin or not currentSkin.tattoos then
        return cb(false)
    end
    
    local playerPed = PlayerPedId()
    
    for i = #currentSkin.tattoos, 1, -1 do
        if currentSkin.tattoos[i].overlay == data.overlay then
            table.remove(currentSkin.tattoos, i)
        end
    end
    
    ClearPedDecorations(playerPed)
    for _, tattoo in pairs(currentSkin.tattoos) do
        AddPedDecorationFromHashes(
            playerPed,
            GetHashKey(tattoo.collection),
            GetHashKey(tattoo.overlay)
        )
    end
    
    SendReactMessage(CHARACTERS .. 'SetSkin', currentSkin)
    
    cb(true)
end)

function UpdatePedVariation(ped)
    local currentHeadOverlay = GetPedHeadOverlayValue(ped, 0)
    SetPedHeadOverlay(ped, 0, currentHeadOverlay, 1.0)
    local currentDrawable = GetPedDrawableVariation(ped, 0)
    SetPedComponentVariation(ped, 0, currentDrawable, 0, 0)
end

RegisterNetEvent('fb:skin:swap', function(data)
    if data.overlay and data.overlay.eyebrows then
        local function op(v) return normOpacity(v) end
        TriggerEvent('skinchanger:change', 'eyebrows_1', data.overlay.eyebrows.value or 0)
        TriggerEvent('skinchanger:change', 'eyebrows_2', data.overlay.eyebrows.opacity or 1.0)
        TriggerEvent('skinchanger:change', 'eyebrows_3', data.overlay.eyebrows.firstColour or 0)
        TriggerEvent('skinchanger:change', 'eyebrows_4', data.overlay.eyebrows.secondColour or 0)
        -- TriggerEvent('skinchanger:change', 'eyebrows_5', data.overlay.eyebrows.overlayValue or 0)
        -- TriggerEvent('skinchanger:change', 'eyebrows_6', data.overlay.eyebrows.overlayValue or 0)
    end

    if data.overlay and data.overlay.aging then
        TriggerEvent('skinchanger:change', 'age_1', data.overlay.aging.value or 0)
        TriggerEvent('skinchanger:change', 'age_2', data.overlay.aging.opacity or 0)
    end

    if data.overlay and data.overlay.makeup then
        TriggerEvent('skinchanger:change', 'makeup_1', data.overlay.makeup.value or 0)
        TriggerEvent('skinchanger:change', 'makeup_2', data.overlay.makeup.opacity or 0)
        TriggerEvent('skinchanger:change', 'makeup_3', data.overlay.makeup.firstColour or 0)
        TriggerEvent('skinchanger:change', 'makeup_4', data.overlay.makeup.secondColour or 0)
    end

    if data.overlay and data.overlay.blush then
        TriggerEvent('skinchanger:change', 'blush_1', data.overlay.blush.value or 0)
        TriggerEvent('skinchanger:change', 'blush_2', data.overlay.blush.opacity or 0)
        TriggerEvent('skinchanger:change', 'blush_3', data.overlay.blush.firstColour or 0)
    end

    if data.overlay and data.overlay.blemishes then
        TriggerEvent('skinchanger:change', 'blemishes_1', data.overlay.blemishes.value or 0)
        TriggerEvent('skinchanger:change', 'blemishes_2', data.overlay.blemishes.opacity or 0)
    end

    if data.overlay and data.overlay.complexion then
        TriggerEvent('skinchanger:change', 'complexion_1', data.overlay.complexion.value or 0)
        TriggerEvent('skinchanger:change', 'complexion_2', data.overlay.complexion.opacity or 0)
    end

    if data.overlay and data.overlay.sunDamage then
        TriggerEvent('skinchanger:change', 'sun_1', data.overlay.sunDamage.value or 0)
        TriggerEvent('skinchanger:change', 'sun_2', data.overlay.sunDamage.opacity or 0)
    end

    if data.overlay and data.overlay.lipstick then
        TriggerEvent('skinchanger:change', 'lipstick_1', data.overlay.lipstick.value or 0)
        TriggerEvent('skinchanger:change', 'lipstick_2', data.overlay.lipstick.opacity or 0)
        TriggerEvent('skinchanger:change', 'lipstick_3', data.overlay.lipstick.firstColour or 0)
        TriggerEvent('skinchanger:change', 'lipstick_4', data.overlay.lipstick.secondColour or 0)
    end

    if data.overlay and data.overlay.molesOrFreckles then
        TriggerEvent('skinchanger:change', 'moles_1', data.overlay.molesOrFreckles.value or 0)
        TriggerEvent('skinchanger:change', 'moles_2', data.overlay.molesOrFreckles.opacity or 0)
    end

    if data.overlay and data.overlay.chestHair then
        TriggerEvent('skinchanger:change', 'chest_1', data.overlay.chestHair.value or 0)
        TriggerEvent('skinchanger:change', 'chest_2', data.overlay.chestHair.opacity or 0)
        TriggerEvent('skinchanger:change', 'chest_3', data.overlay.chestHair.firstColour or 0)
    end

    if data.overlay and data.overlay.facialHair then
        TriggerEvent('skinchanger:change', 'beard_1', data.overlay.facialHair.value or 0)
        TriggerEvent('skinchanger:change', 'beard_2', data.overlay.facialHair.opacity or 0)
        TriggerEvent('skinchanger:change', 'beard_3', data.overlay.facialHair.firstColour or 0)
        TriggerEvent('skinchanger:change', 'beard_4', data.overlay.facialHair.secondColour or 0)
    end

    if data.faceFeatures then
        TriggerEvent('skinchanger:change', 'eye_squint', data.faceFeatures[20] or 0)
    end

    if data.drawables then
        TriggerEvent('skinchanger:change', 'bodyb_1', data.drawables.bodyb and data.drawables.bodyb.did or 0)
        TriggerEvent('skinchanger:change', 'bodyb_2', data.drawables.bodyb and data.drawables.bodyb.tex or 0)
        TriggerEvent('skinchanger:change', 'bodyb_3', data.drawables.bodyb and data.drawables.bodyb.did or 0)
        TriggerEvent('skinchanger:change', 'bodyb_4', data.drawables.bodyb and data.drawables.bodyb.tex or 0)


        TriggerEvent('skinchanger:change', 'tshirt_1', data.drawables.undershirts and data.drawables.undershirts.did or 0)
        TriggerEvent('skinchanger:change', 'tshirt_2', data.drawables.undershirts and data.drawables.undershirts.tex or 0)
        TriggerEvent('skinchanger:change', 'torso_1', data.drawables.torsos and data.drawables.torsos.did or 0)
        TriggerEvent('skinchanger:change', 'torso_2', data.drawables.torsos and data.drawables.torsos.tex or 0)

        TriggerEvent('skinchanger:change', 'pants_1', data.drawables.pants and data.drawables.pants.did or 0)
        TriggerEvent('skinchanger:change', 'pants_2', data.drawables.pants and data.drawables.pants.tex or 0)

        TriggerEvent('skinchanger:change', 'mask_1', data.drawables.masks and data.drawables.masks.did or 0)
        TriggerEvent('skinchanger:change', 'mask_2', data.drawables.masks and data.drawables.masks.tex or 0)

        TriggerEvent('skinchanger:change', 'arms', data.drawables.arms and data.drawables.arms.did or 0)
        TriggerEvent('skinchanger:change', 'arms_2', data.drawables.arms and data.drawables.arms.tex or 0)

        TriggerEvent('skinchanger:change', 'shoes_1', data.drawables.shoes and data.drawables.shoes.did or 0)
        TriggerEvent('skinchanger:change', 'shoes_2', data.drawables.shoes and data.drawables.shoes.tex or 0)

        TriggerEvent('skinchanger:change', 'bags_1', data.drawables.bags and data.drawables.bags.did or 0)
        TriggerEvent('skinchanger:change', 'bags_2', data.drawables.bags and data.drawables.bags.tex or 0)

        TriggerEvent('skinchanger:change', 'decals_1', data.drawables.decals and data.drawables.decals.did or 0)
        TriggerEvent('skinchanger:change', 'decals_2', data.drawables.decals and data.drawables.decals.tex or 0)

        TriggerEvent('skinchanger:change', 'hair_1', data.drawables.hair and data.drawables.hair.did or 0)
        TriggerEvent('skinchanger:change', 'hair_2', data.drawables.hair and data.drawables.hair.tex or 0)

        TriggerEvent('skinchanger:change', 'bproof_1', data.drawables.vests and data.drawables.vests.did or 0)
        TriggerEvent('skinchanger:change', 'bproof_2', data.drawables.vests and data.drawables.vests.tex or 0)
    end

    if data.props then
        TriggerEvent('skinchanger:change', 'helmet_1', data.props.hats and data.props.hats.pid or -1)
        TriggerEvent('skinchanger:change', 'helmet_2', data.props.hats and data.props.hats.tex or 0)

        TriggerEvent('skinchanger:change', 'glasses_1', data.props.glasses and data.props.glasses.pid or -1)
        TriggerEvent('skinchanger:change', 'glasses_2', data.props.glasses and data.props.glasses.tex or 0)

        TriggerEvent('skinchanger:change', 'ears_1', data.props.earrings and data.props.earrings.pid or -1)
        TriggerEvent('skinchanger:change', 'ears_2', data.props.earrings and data.props.earrings.tex or 0)

        TriggerEvent('skinchanger:change', 'watches_1', data.props.watches and data.props.watches.pid or -1)
        TriggerEvent('skinchanger:change', 'watches_2', data.props.watches and data.props.watches.tex or 0)

        TriggerEvent('skinchanger:change', 'bracelets_1', data.props.bracelets and data.props.bracelets.pid or -1)
        TriggerEvent('skinchanger:change', 'bracelets_2', data.props.bracelets and data.props.bracelets.tex or 0)
    end
end)

RegisterNUICallback(CHARACTERS .. 'GetClothes', function(data, cb)

    ESX.TriggerServerCallback('fb:clothes:getMyClothes', function(_xClothesData)
        local t = {}
        ESX.TriggerServerCallback('fb:getSex', function(sex)
            for _, xClotheData in pairs(_xClothesData) do
                xClotheData.sex = sex
                if xClotheData.name == "Tenue Nord" then
                    xClotheData.isTenueNord = true
                elseif xClotheData.name == "Tenue Sud" then
                    xClotheData.isTenueSud = true
                end
                table.insert(t, xClotheData)
            end
            cb(t)
        end)
    end, limitations)
 end)

RegisterNetEvent('Az_Ui3:receiveNewClothes', function(_xClothesData, newSkin)
    if not clonedPed then return end
    local t = {}
    for _, xClotheData in pairs(_xClothesData) do
        table.insert(t, xClotheData)
    end
    SendReactMessage(CHARACTERS .. 'SetClothes', t)

    if newSkin then
        SendReactMessage(CHARACTERS .. 'SetSkin', newSkin)
    end
end)

exports('CloseCharacters', function()
    if not clonedPed then return end

    SetPlayerControl(PlayerId(), true, 0)
    FreezeEntityPosition(PlayerPedId(), false)

    TriggerEvent('fb:disableWeather', 'characters', false)
    RemoveNuiFocus('characters')
    RemoveNuiFocusKeepInput('characters')

    if clonedPed then
        DeleteEntity(clonedPed)
        clonedPed = nil
    end
    
    previewCategory = nil
    currentSkin = nil
    freeCam = false

    if currentCam then
        RenderScriptCams(false, true, 500, true, true)
        DestroyCam(currentCam, true)
        currentCam = nil
    end

    ClearPedTasksImmediately(PlayerPedId())
    SetPedCanPlayAmbientAnims(PlayerPedId(), true)
    if SetPedCanPlayAmbientIdles and not IS_RDR2 then
        SetPedCanPlayAmbientIdles(PlayerPedId(), true, true)
    end

    SendReactMessage(CHARACTERS .. 'SetCharacter', nil)
end)

RegisterNUICallback(CHARACTERS .. 'SetPreviewCategory', function(data, cb)
    previewCategory = data.internalCategory
    UpdatePreview()
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'CreateClothe', function(clotheData, cb)
    if clotheData.data and clotheData.data.shopItems then
        local shopItems = {}
        for hash, item in pairs(clotheData.data.shopItems) do
            shopItems[tonumber(hash)] = item
        end
        clotheData.data.shopItems = shopItems
    end

    local formattedData = {
        lipstick_3 = clotheData.data.overlay.lipstick and clotheData.data.overlay.lipstick.value or 0,
        torso_1 = clotheData.data.drawables.torsos and clotheData.data.drawables.torsos.did or 0,
        beard_1 = clotheData.data.drawables.beard and clotheData.data.drawables.beard.did or 0,
        shoes_2 = clotheData.data.drawables.shoes and clotheData.data.drawables.shoes.did or 0,
        mask_1 = clotheData.data.drawables.masks and clotheData.data.drawables.masks.did or 0,
        face = clotheData.data.overlay.complextion and clotheData.data.overlay.complextion.value or 0,
        blush_2 = clotheData.data.overlay.blush and clotheData.data.overlay.blush.value or 0,
        blush_1 = clotheData.data.overlay.blush and clotheData.data.overlay.blush.firstColour or 0,
        bracelets_1 = clotheData.data.props.bracelets and clotheData.data.props.bracelets.pid or -1,
        bags_1 = clotheData.data.drawables.bags and clotheData.data.drawables.bags.did or 0,
        hair_color_1 = clotheData.data.hairColor and clotheData.data.hairColor.hair or 0,
        beard_4 = clotheData.data.drawables.beard and clotheData.data.drawables.beard.did or 0,
        chain_1 = clotheData.data.props.chain and clotheData.data.props.chain.pid or 0,
        makeup_1 = clotheData.data.overlay.makeup and clotheData.data.overlay.makeup.value or 0,
        tshirt_1 = clotheData.data.drawables.undershirts and clotheData.data.drawables.undershirts.did or 0,
        sex = clotheData.data.sex or 0,
        eyebrows_4 = clotheData.data.overlay.eyebrows and clotheData.data.overlay.eyebrows.value or 0,
        decals_2 = clotheData.data.drawables.decals and clotheData.data.drawables.decals.did or 0,
        eyebrows_1 = clotheData.data.overlay.eyebrows and clotheData.data.overlay.eyebrows.firstColour or 0,
        mask_2 = clotheData.data.drawables.masks and clotheData.data.drawables.masks.did or 0,
        shoes_1 = clotheData.data.drawables.shoes and clotheData.data.drawables.shoes.did or 0,
        hair_1 = clotheData.data.drawables.hair and clotheData.data.drawables.hair.did or 0,
        chest_2 = clotheData.data.drawables.chest and clotheData.data.drawables.chest.did or 0,
        blush_3 = clotheData.data.overlay.blush and clotheData.data.overlay.blush.value or 0,
        bodyb_1 = clotheData.data.drawables.bodyb and clotheData.data.drawables.bodyb.did or 0,
        watches_2 = clotheData.data.props.watches and clotheData.data.props.watches.pid or -1,
        glasses_1 = clotheData.data.props.glasses and clotheData.data.props.glasses.pid or 0,
        helmet_1 = clotheData.data.props.helmet and clotheData.data.props.helmet.pid or -1,
        sun_1 = clotheData.data.overlay.sunDamage and clotheData.data.overlay.sunDamage.value or 0,
        moles_1 = clotheData.data.overlay.molesOrFreckles and clotheData.data.overlay.molesOrFreckles.value or 0,
        eyebrows_2 = clotheData.data.overlay.eyebrows and clotheData.data.overlay.eyebrows.overlayValue or 0,
        pants_2 = clotheData.data.drawables.pants and clotheData.data.drawables.pants.did or 0,
        makeup_3 = clotheData.data.overlay.makeup and clotheData.data.overlay.makeup.overlayValue or 0,
        skin = clotheData.data.skin or 0,
        complexion_1 = clotheData.data.overlay.complextion and clotheData.data.overlay.complextion.overlayValue or 0,
        chest_3 = clotheData.data.drawables.chest and clotheData.data.drawables.chest.did or 0,
        bodyb_2 = clotheData.data.drawables.bodyb and clotheData.data.drawables.bodyb.did or 0,
        beard_3 = clotheData.data.drawables.beard and clotheData.data.drawables.beard.did or 0,
        makeup_4 = clotheData.data.overlay.makeup and clotheData.data.overlay.makeup.overlayValue or 0,
        tshirt_2 = clotheData.data.drawables.undershirts and clotheData.data.drawables.undershirts.tex or 0,
        beard_2 = clotheData.data.drawables.beard and clotheData.data.drawables.beard.did or 0,
        complexion_2 = clotheData.data.overlay.complextion and clotheData.data.overlay.complextion.value or 0,
        bags_2 = clotheData.data.drawables.bags and clotheData.data.drawables.bags.did or 0,
        lipstick_2 = clotheData.data.overlay.lipstick and clotheData.data.overlay.lipstick.secondColour or 0,
        chest_1 = clotheData.data.drawables.chest and clotheData.data.drawables.chest.did or 0,
        age_1 = clotheData.data.overlay.aging and clotheData.data.overlay.aging.value or 0,
        bproof_2 = clotheData.data.drawables.bodyb and clotheData.data.drawables.bodyb.did or 0,
        makeup_2 = clotheData.data.overlay.makeup and clotheData.data.overlay.makeup.firstColour or 0,
        torso_2 = clotheData.data.drawables.torsos and clotheData.data.drawables.torsos.did or 0,
        bproof_1 = clotheData.data.drawables.bodyb and clotheData.data.drawables.bodyb.did or 0,
        ears_2 = clotheData.data.props.ears and clotheData.data.props.ears.pid or 0,
        ears_1 = clotheData.data.props.ears and clotheData.data.props.ears.pid or -1,
        blemishes_2 = clotheData.data.overlay.bodyBlemishes and clotheData.data.overlay.bodyBlemishes.overlayValue or 0,
        eyebrows_3 = clotheData.data.overlay.eyebrows and clotheData.data.overlay.eyebrows.overlayValue or 0,
        decals_1 = clotheData.data.drawables.decals and clotheData.data.drawables.decals.did or 0,
        sun_2 = clotheData.data.overlay.sunDamage and clotheData.data.overlay.sunDamage.overlayValue or 0,
        eye_color = clotheData.data.eyeColor or 0,
        arms_2 = clotheData.data.drawables.arms and clotheData.data.drawables.arms.did or 0,
        lipstick_1 = clotheData.data.overlay.lipstick and clotheData.data.overlay.lipstick.value or 0,
        bracelets_2 = clotheData.data.props.bracelets and clotheData.data.props.bracelets.pid or 0,
        hair_2 = clotheData.data.drawables.hair and clotheData.data.drawables.hair.did or 0,
        lipstick_4 = clotheData.data.overlay.lipstick and clotheData.data.overlay.lipstick.secondColour or 0,
        blemishes_1 = clotheData.data.overlay.bodyBlemishes and clotheData.data.overlay.bodyBlemishes.value or 0,
        arms = clotheData.data.drawables.arms and clotheData.data.drawables.arms.did or 0,
        glasses_2 = clotheData.data.props.glasses and clotheData.data.props.glasses.pid or 0,
        moles_2 = clotheData.data.overlay.molesOrFreckles and clotheData.data.overlay.molesOrFreckles.value or 0,
        age_2 = clotheData.data.overlay.aging and clotheData.data.overlay.aging.value or 0,
        chain_2 = clotheData.data.props.chain and clotheData.data.props.chain.pid or 0,
        watches_1 = clotheData.data.props.watches and clotheData.data.props.watches.pid or -1,
        helmet_2 = clotheData.data.props.helmet and clotheData.data.props.helmet.pid or 0,
        hair_color_2 = clotheData.data.hairColor and clotheData.data.hairColor.highlight or 0,
        pants_1 = clotheData.data.drawables.pants and clotheData.data.drawables.pants.did or 0
    }

    TriggerServerEvent("esx_skin:save", formattedData)
    TriggerServerEvent('fb:clothes:saveClothes', clotheData.name, formattedData)
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'BuyUniqueClothe', function(data, cb)
    TriggerServerEvent('fb:clothes:buyUnique', data)
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'BuyClothes', function(data, cb)
    print('test2')
    TriggerServerEvent('fb:clothes:getClothesAsItem', data.clotheId)
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'PutClothes', function(data, cb)
    TriggerEvent('skinchanger:loadSkin', data.data)

    TriggerServerEvent('illenium-appearance:server:saveAppearance', data.data)

    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'Delete', function(data, cb)
    TriggerServerEvent('fb:clothes:deleteClothes', data.clotheId)
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'ChangeNumberVar', function(data, cb)
    TriggerServerEvent('fb:numbervars:changeNumberVar', data.reference, tonumber(data.var))
    cb(true)
end)

RegisterNUICallback(CHARACTERS .. 'GetClothesPacked', function(data, cb)
    cb(GetResourceState('fb_rdr2') == 'started' and LoadResourceFile('fb_rdr2', 'data/clothes_packed.json') or '{}')
end)

RegisterNUICallback(CHARACTERS .. 'GetOverlays', function(data, cb)
    cb(GetResourceState('fb_rdr2') == 'started' and LoadResourceFile('fb_rdr2', 'data/overlays.json') or '{}')
end)

RegisterNUICallback(CHARACTERS .. 'SuggestionPrice', function(data, cb)
    local amount = exports.Ratus_ui:ShowInput('Montant', false, 32, "number")
    if amount then
        TriggerServerEvent('fb:numbervars:changeNumberVar', 'clothes.' .. data.sex .. '.' .. data.category .. '.' .. data.index .. '.' .. data.tex, amount)
    end
    cb('ok')
end)

-- local function UpdateReservations()

--     local reservation = 0

--     if FB.Group.HasPermission('knowledge.police') then
--         reservation += 1
--     end
--     if FB.Group.HasPermission('knowledge.medic') then
--         reservation += 2
--     end
--     if FB.Group.HasPermission('knowledge.security') then
--         reservation += 4
--     end
--     if FB.IsGameMaster() then
--         reservation += 8
--     end

--     SendReactMessage(CHARACTERS .. 'SetReservation', reservation)
-- end

CreateThread(function()
    while true do
        Wait(0)
        -- UpdateReservations()
    end
end)

RegisterNetEvent('fb:group:update', function()
    Wait(0)
    -- UpdateReservations()
end)

RegisterNUICallback('chooseSpawn', function(data, cb)
    local ped = PlayerPedId()
    
    if data.spawn == "LosSantos" then
        DoScreenFadeOut(500)
        Wait(500)
        
        SetEntityCoords(ped, -1039.71, -2741.75, 20.17, false, false, false, false)
        SetEntityHeading(ped, 329.87)
        
        FreezeEntityPosition(ped, true)
        Wait(1000)
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(500)
    elseif data.spawn == "SandyShores" then
        DoScreenFadeOut(500)
        Wait(500) 

        SetEntityCoords(ped, 1839.40, 3672.46, 34.28, false, false, false, false)
        SetEntityHeading(ped, 209.52) 
        
        FreezeEntityPosition(ped, true)
        Wait(1000)
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(500)
    end
    
    cb({})
end)

function cleanPreviewPeds()
    if type(previewPeds) ~= "table" then
        previewPeds = {}
        return
    end

    for _, v in pairs(previewPeds) do
        if DoesEntityExist(v) then
            DeleteEntity(v)
        end
    end

    previewPeds = {}
end

RegisterNUICallback(CHARACTERS .. 'GetMax', function(data, cb)
    local internalCategory = data.internalCategory
    local id = data.id

    local max = 0
    local maxTex = 0

    for globeCategory, values in pairs(Config.Overlays) do
        for index, category in pairs(values) do
            if category == internalCategory then
                if globeCategory == 'overlay' then
                    max = GetPedHeadOverlayNum(index) - 1
                    maxTex = 10
                end
                if globeCategory == 'drawables' then
                    max = GetNumberOfPedDrawableVariations(clonedPed, index) - 1
                    maxTex = GetNumberOfPedTextureVariations(clonedPed, index, id) - 1
                end
                if globeCategory == 'props' then
                    max = GetNumberOfPedPropDrawableVariations(clonedPed, index)
                    maxTex = GetNumberOfPedPropTextureVariations(clonedPed, index, id)
                end
            end
        end
    end

    cb({max = max, maxTex = maxTex})
end)

RegisterNetEvent('fb:loadCharacter')
AddEventHandler('fb:loadCharacter', function(skin)
    local playerPed = PlayerPedId()
    
    if skin and skin.model then
        local modelHash = GetHashKey(skin.model)
        if GetEntityModel(playerPed) ~= modelHash then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(0)
            end
            SetPlayerModel(PlayerId(), modelHash)
            SetModelAsNoLongerNeeded(modelHash)
            playerPed = PlayerPedId() 
        end
    end
    
    ClearPedDecorations(playerPed)
    
    local convertedSkin = type(skin) == 'table' and skin or convertSkinFormat(skin)
    
    if convertedSkin.components then
        for _, comp in ipairs(convertedSkin.components) do
            SetPedComponentVariation(playerPed, comp.component_id, comp.drawable, comp.texture, 0)
        end
    end
    
    if convertedSkin.props then
        for _, prop in ipairs(convertedSkin.props) do
            if prop.drawable == -1 then
                ClearPedProp(playerPed, prop.prop_id)
            else
                SetPedPropIndex(playerPed, prop.prop_id, prop.drawable, prop.texture, true)
            end
        end
    end
    
if convertedSkin.tattoos then
    ClearPedDecorations(playerPed)
    for _, tattoo in ipairs(convertedSkin.tattoos) do
        AddPedDecorationFromHashes(
            playerPed,
            GetHashKey(tattoo.collection),
            GetHashKey(tattoo.overlay)
        )
    end
end

    
if convertedSkin.headOverlays then
    for id, overlay in pairs(convertedSkin.headOverlays) do
        local overlayId = {
            beard = 1,
            eyebrows = 2,
            ageing = 3,
            makeUp = 4,   -- camel
            makeup = 4,   -- alias snake
            blush = 5,
            complexion = 6,
            sunDamage = 7,
            lipstick = 8,
            moleAndFreckles = 9,
            chestHair = 10,
            bodyBlemishes = 11,
            blemishes = 0
        }

        local idx = overlayId[id]
        if idx then
            local op = normOpacity(overlay.opacity)
            SetPedHeadOverlay(playerPed, idx, overlay.style or 0, op)

            local isType2 = (id == "blush" or id == "lipstick" or id == "makeUp" or id == "makeup")
            if overlay.color ~= nil then
                SetPedHeadOverlayColor(playerPed, idx, isType2 and 2 or 1, overlay.color or 0, overlay.secondColor or 0)
            end
        end
    end
end

    
    TriggerServerEvent('saveAppearance', convertedSkin)
    
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('fb:requestAppearance')
end)

RegisterNUICallback(CHARACTERS .. 'GetPreviewTex', function(data, cb)
    if not data then return cb({max = 0, maxTex = 0}) end
    
    local max = 0
    local maxTex = 0
    local globeCategory = nil
    local internalCategory = data.category

    for gCat, values in pairs(Config.Overlays) do
        if values[internalCategory] then
            globeCategory = gCat
            max = values[internalCategory].max
            maxTex = values[internalCategory].maxTex or 0
            break
        end
    end

    if not currentSkin or not currentSkin[globeCategory] or not currentSkin[globeCategory][internalCategory] then
        return cb({max = max, maxTex = maxTex})
    end

    local currentTex = currentSkin[globeCategory][internalCategory].tex
    local previewData = {max = max, maxTex = maxTex, previews = {}}

    for i=-3, 3 do
        if i ~= 0 then
            if maxTex > 0 and (currentTex + i) >= 0 and (currentTex + i) <= maxTex then
                previewData.previews[i] = currentTex + i
            end
        end
    end

    cb(previewData)
end)

AddEventHandler('playerSpawned', function()
    Wait(1000)
    TriggerServerEvent('fb:requestAppearance')
end)


RegisterNUICallback('saveHealthInfo', function(data, cb)
    TriggerServerEvent('fb:updateHealthInfo', data)
    cb('ok')
end)

RegisterNUICallback('getHealthInfo', function(data, cb)
    ESX.TriggerServerCallback('fb:getHealthInfo', function(healthInfo)
        cb(healthInfo)
    end)
end)


RegisterCommand('creator', function()
    local pedNetId = NetworkGetNetworkIdFromEntity(PlayerPedId())

    local testSkin = {
        drawables = {
            decals = { did = 0, tex = 0 },
            masks = { did = 0, tex = 0 },
            necks = { did = 0, tex = 0 },
            jackets = { did = 0, tex = 0 },
            vests = { did = 0, tex = 0 },
            undershirts = { did = 0, tex = 0 },
            bags = { did = 0, tex = 0 },
            pants = { did = 0, tex = 0 },
            torsos = { did = 0, tex = 0 },
            hair = { second = 0, did = 0, tex = 0 },
            arms = { did = 0, tex = 0 },
            shoes = { did = 0, tex = 0 }
        },
        bodyb = {
            did = 0,
            tex = 0
        },
        tattoos = {},
        props = {
            watches = { pid = -1, tex = 0 },
            glasses = { pid = -1, tex = 0 },
            earrings = { pid = -1, tex = 0 },
            hats = { pid = -1, tex = 0 },
            bracelets = { pid = -1, tex = 0 }
        },
        headblend = {
            shapeFirst = 0,
            shapeThird = 0,
            thirdMix = 0,
            hasParent = false,
            skinSecond = 0,
            skinThird = 0,
            shapeMix = 0.5,
            skinFirst = 0,
            skinMix = 0.5,
            shapeSecond = 0
        },
        eyeColor = -1,
        faceFeatures = {
            [0] = 0,  
            [1] = 0,   
            [2] = 0,   
            [3] = 0,  
            [4] = 0,   
            [5] = 0,  
            [6] = 0,
            [7] = 0, 
            [8] = 0,  
            [9] = 0, 
            [10] = 0, 
            [11] = 0, 
            [12] = 0, 
            [13] = 0,   
            [14] = 0,  
            [15] = 0,  
            [16] = 0,  
            [17] = 0,  
            [18] = 0,  
            [19] = 0,  
            [20] = 0   
        },
        overlay = {
            aging = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            molesOrFreckles = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            sunDamage = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            bodyBlemishes = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            blush = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            complexion = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            makeup = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            lipstick = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            eyebrows = { opacity = 1, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            chestHair = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            bodyBlemishes2 = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            blemishes = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 },
            facialHair = { opacity = 0, firstColour = 0, secondColour = 0, value = 0, overlayValue = 0 }
        },
        hairColor = { highlight = 0, hair = 1 }
    }

    local testData = {
        medicTraits = {
            specificities = {},
            allergies = {},
            diseases = {},
            addictions = {},
            bloodType = 'A+'
        },
        targetPedNetId = pedNetId,
        sexe = 'm',
        metaPedType = 'male',
        firstname = '',
        lastname = '',
        nationality = '',
        dateofbirth = '',
        skin = testSkin,
        tattoo = {},
        model = 'mp_m_freemode_01',
        limitations = 'CREATION',
        clothes = {
            clotheId = 1,
            name = "Tenue 1",
            upperImage = "https://raw.githubusercontent.com/Ekinoxx0/clothes/v3/mp_f_freemode_01/jackets/67/0.png",
            downImage = "https://raw.githubusercontent.com/Ekinoxx0/clothes/v3/mp_f_freemode_01/pants/99/0.png",
            shoeImage = "https://raw.githubusercontent.com/Ekinoxx0/clothes/v3/mp_f_freemode_01/shoes/129/0.png",
            data = {
                tshirt_1 = 15,
            }
        }
    }

    -- client_gender.lua

-- Envoie un genre par défaut au chargement (utile pour tester)
CreateThread(function()
    Wait(500)
    SendNUIMessage({ type = "setGender", gender = "male" })
end)

-- Commandes de test
RegisterCommand('ui_male', function()
    SendNUIMessage({ type = "setGender", gender = "male" })
end)

RegisterCommand('ui_female', function()
    SendNUIMessage({ type = "setGender", gender = "female" })
end)

-- Option auto: détecte le sexe du ped et l’envoie à l’ouverture
-- Appelle cette fonction quand tu OUVRES le menu (là où tu fais SetNuiFocus(true,true))
function avaSendCurrentGender()
    local ped = PlayerPedId()
    local gender = IsPedMale(ped) and "male" or "female"
    SendNUIMessage({ type = "setGender", gender = gender })
end




    TriggerEvent('Az_Ui3:characters:edition', testData)
end, false)


-- >>> Injected: NUI callback for clicking gender buttons in UI
RegisterNUICallback("selectGender", function(data, cb)
    local g = data and data.gender
    if g == "male" or g == "female" then
        SendNUIMessage({ type = "setGender", gender = g })
    end
    if cb then cb("ok") end
end)
-- <<< Injected
