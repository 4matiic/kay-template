ESX = exports["framework"]:getSharedObject()

-- Config
local Config = {
    BackBone = 24816,
    Position = { x = 0.1, y = -0.18, z = 0.02 },
    Rotation = { x = 0.0, y = 0.0, z = 0.0 },
    UpdateTime = 1000,
    
    WeaponModels = {
        ["WEAPON_CARBINERIFLE"] = "w_ar_carbinerifle",
        ["WEAPON_CARBINERIFLE_MK2"] = "w_ar_carbineriflemk2",
        ["WEAPON_ASSAULTRIFLE"] = "w_ar_assaultrifle",
        ["WEAPON_SPECIALCARBINE"] = "w_ar_specialcarbine",
        ["WEAPON_BULLPUPRIFLE"] = "w_ar_bullpuprifle",
        ["WEAPON_ADVANCEDRIFLE"] = "w_ar_advancedrifle",
        ["WEAPON_MICROSMG"] = "w_sb_microsmg",
        ["WEAPON_ASSAULTSMG"] = "w_sb_assaultsmg",
        ["WEAPON_SMG"] = "w_sb_smg",
        ["WEAPON_SMG_MK2"] = "w_sb_smgmk2",
        ["WEAPON_GUSENBERG"] = "w_sb_gusenberg",
        ["WEAPON_SNIPERRIFLE"] = "w_sr_sniperrifle",
        ["WEAPON_ASSAULTSHOTGUN"] = "w_sg_assaultshotgun",
        ["WEAPON_BULLPUPSHOTGUN"] = "w_sg_bullpupshotgun",
        ["WEAPON_PUMPSHOTGUN"] = "w_sg_pumpshotgun",
        ["WEAPON_MUSKET"] = "w_ar_musket",
        ["WEAPON_HEAVYSHOTGUN"] = "w_sg_heavyshotgun",
        ["WEAPON_FIREWORK"] = "w_lr_firework",
        ["WEAPON_BAT"] = "w_me_bat"
    },
    
    SpecialPositions = {
        ["WEAPON_BAT"] = {x = 0.11, y = -0.14, z = 0.0, xr = -75.0, yr = 185.0, zr = 92.0}
    }
}

local attachedObjects = {}
local currentWeapon = nil

-- Liste des sacs 
local BlockedBags = {
    {drawable = 45, texture = 0},
    {drawable = 44, texture = 1}, 
    {drawable = 81, texture = 0},

}


local function IsWearingBag()
    local playerPed = PlayerPedId()
    local drawable, texture = GetPedDrawableVariation(playerPed, 5), GetPedTextureVariation(playerPed, 5)
    
    for _, bag in ipairs(BlockedBags) do
        if drawable == bag.drawable and texture == bag.texture then
            return true
        end
    end
    return false
end

local function GetAllPlayerWeapons()
    local weapons = {}
    local playerPed = PlayerPedId()
    
    for weaponName, _ in pairs(Config.WeaponModels) do
        if HasPedGotWeapon(playerPed, GetHashKey(weaponName), false) then
            weapons[weaponName] = true
        end
        if exports['ox_inventory']:GetItemCount(weaponName) > 0 then
            weapons[weaponName] = true
        end
    end
    
    return weapons
end

local function GetCurrentEquippedWeapon()
    local playerPed = PlayerPedId()
    local hash = GetSelectedPedWeapon(playerPed)
    
    for weaponName, _ in pairs(Config.WeaponModels) do
        if hash == GetHashKey(weaponName) then
            return weaponName
        end
    end
    
    return nil
end

local function AttachWeapon(weaponName, modelName)
    if attachedObjects[weaponName] then return end
    
    local playerPed = PlayerPedId()
    local modelHash = GetHashKey(modelName)
    
    if not IsModelValid(modelHash) then return end
    
    RequestModel(modelHash)
    local timeout = 0
    while not HasModelLoaded(modelHash) and timeout < 30 do
        Wait(100)
        timeout = timeout + 1
    end
    
    if not HasModelLoaded(modelHash) then return end
    
    local obj = CreateObject(modelHash, 1.0, 1.0, 1.0, true, true, false)
    if DoesEntityExist(obj) then
        local x, y, z = Config.Position.x, Config.Position.y, Config.Position.z
        local xr, yr, zr = Config.Rotation.x, Config.Rotation.y, Config.Rotation.z
        
        if Config.SpecialPositions[weaponName] then
            x = Config.SpecialPositions[weaponName].x
            y = Config.SpecialPositions[weaponName].y
            z = Config.SpecialPositions[weaponName].z
            xr = Config.SpecialPositions[weaponName].xr
            yr = Config.SpecialPositions[weaponName].yr
            zr = Config.SpecialPositions[weaponName].zr
        end
        
        local boneIndex = GetPedBoneIndex(playerPed, Config.BackBone)
        
        SetEntityCollision(obj, false, false)
        AttachEntityToEntity(obj, playerPed, boneIndex, x, y, z, xr, yr, zr, true, true, false, true, 2, true)
        
        attachedObjects[weaponName] = obj
    end
    
    SetModelAsNoLongerNeeded(modelHash)
end

local function DetachWeapon(weaponName)
    if attachedObjects[weaponName] and DoesEntityExist(attachedObjects[weaponName]) then
        DeleteObject(attachedObjects[weaponName])
    end
    attachedObjects[weaponName] = nil
end

local function DetachAllWeapons()
    for weaponName, obj in pairs(attachedObjects) do
        if DoesEntityExist(obj) then
            DeleteObject(obj)
        end
    end
    attachedObjects = {}
end

local function UpdateWeaponsOnBack()
    local playerPed = PlayerPedId()
    
    if IsEntityDead(playerPed) or IsPedInAnyVehicle(playerPed, true) then
        DetachAllWeapons()
        return
    end
    
    currentWeapon = GetCurrentEquippedWeapon()
    local playerWeapons = GetAllPlayerWeapons()
    
    for weaponName, _ in pairs(attachedObjects) do
        if weaponName == currentWeapon or not playerWeapons[weaponName] then
            DetachWeapon(weaponName)
        end
    end
    
    if not IsWearingBag() then
        for weaponName, modelName in pairs(Config.WeaponModels) do
            if playerWeapons[weaponName] and weaponName ~= currentWeapon and not attachedObjects[weaponName] then
                AttachWeapon(weaponName, modelName)
            end
        end
    else
        DetachAllWeapons()
    end
end

RegisterNetEvent('weapons_back:checkInventory')
AddEventHandler('weapons_back:checkInventory', function()
    UpdateWeaponsOnBack()
end)

RegisterNetEvent('ox_inventory:itemCount')
AddEventHandler('ox_inventory:itemCount', function(item, count)
    if string.find(item, "WEAPON_") then
        Wait(500)
        UpdateWeaponsOnBack()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    Wait(2000)
    UpdateWeaponsOnBack()
end)

Citizen.CreateThread(function()
    Wait(5000)
    TriggerEvent('weapons_back:checkInventory')
    
    while true do
        UpdateWeaponsOnBack()
        Wait(Config.UpdateTime)
    end
end)

Citizen.CreateThread(function()
    local lastEquippedWeapon = nil
    
    while true do
        local playerPed = PlayerPedId()
        local currentHash = GetSelectedPedWeapon(playerPed)
        
        if currentHash ~= lastEquippedWeapon then
            lastEquippedWeapon = currentHash
            Wait(500)
            UpdateWeaponsOnBack()
        end
        
        Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0, 289) then
            Wait(1000)
            UpdateWeaponsOnBack()
        end
        Wait(10)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DetachAllWeapons()
    end
end)
