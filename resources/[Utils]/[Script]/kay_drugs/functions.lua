local lib = exports.ox_lib

function LoadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(10)
        end
    end
end

function CreateAndSetupScaleform(title, subtitle, progress, stage)
    local scaleform = RequestScaleformMovie("mp_car_stats_01")
    local timeout = 1000 
    local startTime = GetGameTimer()
    while not HasScaleformMovieLoaded(scaleform) and GetGameTimer() - startTime < timeout do
        Wait(10)
    end
    if not HasScaleformMovieLoaded(scaleform) then
        print("Failed to load scaleform for pot")
        return nil
    end
    BeginScaleformMovieMethod(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString(title)
    PushScaleformMovieFunctionParameterString(subtitle)
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterString(Config.Texts.PotStage.." "..stage)
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterString(Config.Texts.PotEvolution)
    PushScaleformMovieFunctionParameterString("")
    PushScaleformMovieFunctionParameterFloat(progress)
    PushScaleformMovieFunctionParameterBool(true)
    EndScaleformMovieMethod()
    
    return scaleform
end

function GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2)
    return #(vector3(x1, y1, z1) - vector3(x2, y2, z2))
end

function SetupCustomTexture(scaleform, textureName)
    RequestStreamedTextureDict("kay_drugs_textures")
    
    while not HasStreamedTextureDictLoaded("kay_drugs_textures") do
        Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "SET_TEXTURE")
    ScaleformMovieMethodAddParamTextString("kay_drugs_textures")
    ScaleformMovieMethodAddParamTextString(textureName)
    EndScaleformMovieMethod()
end

function IsLocationValid(coords, allPots)
    for _, pot in pairs(allPots) do
        local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, pot.x, pot.y, pot.z)
        if distance < Config.MinimumDistance then
            return false
        end
    end
    return true
end

function CreateHighlightObject(model, coords, isValid)
    local cannabisModel = `bkr_prop_weed_01_small_01c`
    if not HasModelLoaded(cannabisModel) then
        RequestModel(cannabisModel)
        while not HasModelLoaded(cannabisModel) do
            Wait(200)
        end
    end
    local object = CreateObject(cannabisModel, coords.x, coords.y, coords.z, false, false, false)
    SetEntityNoCollisionEntity(object, PlayerPedId(), false)
    SetEntityCollision(object, false, false)
    FreezeEntityPosition(object, true)
    NetworkSetEntityInvisibleToNetwork(object, true)
    SetEntityDrawOutline(object, true)
    
    if isValid then
        SetEntityDrawOutlineColor(0, 255, 0, 255)
    else
        SetEntityDrawOutlineColor(255, 0, 0, 255)
    end
    
    return object
end

function LoadCustomTexture(textureDict, textureName)
    if not HasStreamedTextureDictLoaded(textureDict) then
        RequestStreamedTextureDict(textureDict)
        while not HasStreamedTextureDictLoaded(textureDict) do
            Wait(10)
        end
    end
    return textureDict, textureName
end

function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end