local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1
L0_1 = exports
L0_1 = L0_1.framework
L1_1 = L0_1
L0_1 = L0_1.getSharedObject
L0_1 = L0_1(L1_1)
ESX = L0_1
L0_1 = RP
if not L0_1 then
  L0_1 = {}
  RP = L0_1
end
L0_1 = false
L1_1 = false
L2_1 = {}
L3_1 = 0
L4_1 = 0
L5_1 = {}
L6_1 = nil
L7_1 = false
L8_1 = nil
L9_1 = nil
L10_1 = _G
if not L10_1 then
  L10_1 = {}
end
L11_1 = {}
L10_1.ActiveProps = L11_1
L11_1 = nil
L12_1 = pcall
function L13_1()
  local L0_2, L1_2, L2_2
  L0_2 = LoadResourceFile
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  L2_2 = "config.json"
  return L0_2(L1_2, L2_2)
end
L12_1, L13_1 = L12_1(L13_1)
if L12_1 and L13_1 then
  L14_1 = pcall
  function L15_1()
    local L0_2, L1_2
    L0_2 = json
    L0_2 = L0_2.decode
    L1_2 = L13_1
    return L0_2(L1_2)
  end
  L14_1, L15_1 = L14_1(L15_1)
  if L14_1 and L15_1 then
    L11_1 = L15_1
  end
end
if not L11_1 then
  L12_1 = {}
  L13_1 = {}
  L13_1.x = -1289.02
  L13_1.y = -3409.83
  L13_1.z = 13.94
  L12_1.greenScreenPosition = L13_1
  L13_1 = {}
  L13_1.x = 0
  L13_1.y = 0
  L13_1.z = 330
  L12_1.greenScreenRotation = L13_1
  L13_1 = {}
  L13_1.fov = 50
  L13_1.zPos = 0.2
  L13_1.distance = 2.0
  L12_1.cameraSettings = L13_1
  L12_1.debug = false
  L11_1 = L12_1
end
function L12_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Config
  if L0_2 then
    L0_2 = Config
    L0_2 = L0_2.Anims
    if L0_2 then
      L0_2 = Config
      L0_2 = L0_2.Anims
      RP = L0_2
      L0_2 = true
      return L0_2
    end
  end
  L0_2 = pcall
  function L1_2()
    local L0_3, L1_3
    L0_3 = exports
    L0_3 = L0_3.kay_emote
    if L0_3 then
      L0_3 = exports
      L0_3 = L0_3.kay_emote
      L0_3 = L0_3.getAnimList
      if L0_3 then
        L0_3 = exports
        L0_3 = L0_3.kay_emote
        L0_3 = L0_3.getAnimList
        return L0_3()
      end
    end
    L0_3 = nil
    return L0_3
  end
  L0_2, L1_2 = L0_2(L1_2)
  if L0_2 and L1_2 then
    RP = L1_2
    L2_2 = true
    return L2_2
  end
  L2_2 = {}
  L3_2 = {}
  L2_2.Emotes = L3_2
  L3_2 = {}
  L2_2.PropEmotes = L3_2
  L3_2 = {}
  L2_2.Dances = L3_2
  L3_2 = {}
  L2_2.Shared = L3_2
  L3_2 = {}
  L2_2.Expressions = L3_2
  RP = L2_2
  L2_2 = false
  return L2_2
end
LoadAnimationsFromRPEmotes = L12_1
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = L0_1
  if L0_2 then
    L0_2 = true
    return L0_2
  end
  L0_2 = PlayerPedId
  L0_2 = L0_2()
  L1_2 = GetEntityCoords
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L8_1 = L1_2
  L1_2 = GetEntityHeading
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L9_1 = L1_2
  L1_2 = vector3
  L2_2 = L11_1.greenScreenPosition
  L2_2 = L2_2.x
  L3_2 = L11_1.greenScreenPosition
  L3_2 = L3_2.y
  L4_2 = L11_1.greenScreenPosition
  L4_2 = L4_2.z
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = ESX
  L2_2 = L2_2.Game
  L2_2 = L2_2.Teleport
  L3_2 = L0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
  L2_2 = SetEntityHeading
  L3_2 = L0_2
  L4_2 = L11_1.greenScreenRotation
  L4_2 = L4_2.z
  L2_2(L3_2, L4_2)
  L2_2 = Citizen
  L2_2 = L2_2.Wait
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = DoesCamExist
  L3_2 = L6_1
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = DestroyCam
    L3_2 = L6_1
    L4_2 = true
    L2_2(L3_2, L4_2)
  end
  L2_2 = CreateCam
  L3_2 = "DEFAULT_SCRIPTED_CAMERA"
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L6_1 = L2_2
  L2_2 = GetEntityCoords
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = L2_2.x
  L5_2 = math
  L5_2 = L5_2.sin
  L6_2 = math
  L6_2 = L6_2.rad
  L7_2 = 330.0
  L6_2, L7_2, L8_2 = L6_2(L7_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L5_2 = L5_2 * 3.5
  L4_2 = L4_2 - L5_2
  L3_2.x = L4_2
  L4_2 = L2_2.y
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = math
  L6_2 = L6_2.rad
  L7_2 = 330.0
  L6_2, L7_2, L8_2 = L6_2(L7_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L5_2 = L5_2 * 3.5
  L4_2 = L4_2 + L5_2
  L3_2.y = L4_2
  L4_2 = L2_2.z
  L4_2 = L4_2 + 0.25
  L3_2.z = L4_2
  L10_1.fixedCameraPosition = L3_2
  L3_2 = SetCamCoord
  L4_2 = L6_1
  L5_2 = L10_1.fixedCameraPosition
  L5_2 = L5_2.x
  L6_2 = L10_1.fixedCameraPosition
  L6_2 = L6_2.y
  L7_2 = L10_1.fixedCameraPosition
  L7_2 = L7_2.z
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = SetCamRot
  L4_2 = L6_1
  L5_2 = 2.0
  L6_2 = 0.0
  L7_2 = 150.0
  L8_2 = 2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = SetCamFov
  L4_2 = L6_1
  L5_2 = 50.0
  L3_2(L4_2, L5_2)
  L3_2 = DisableAllControlActions
  L4_2 = 0
  L3_2(L4_2)
  L3_2 = DisableAllControlActions
  L4_2 = 1
  L3_2(L4_2)
  L3_2 = DisableAllControlActions
  L4_2 = 2
  L3_2(L4_2)
  L3_2 = SetCamActive
  L4_2 = L6_1
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = RenderScriptCams
  L4_2 = true
  L5_2 = true
  L6_2 = 500
  L7_2 = true
  L8_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = true
  L7_1 = L3_2
  L3_2 = true
  L0_1 = L3_2
  L3_2 = NetworkSetInSpectatorMode
  L4_2 = true
  L5_2 = L0_2
  L3_2(L4_2, L5_2)
  L3_2 = Citizen
  L3_2 = L3_2.CreateThread
  function L4_2()
    local L0_3, L1_3
    L0_3 = Citizen
    L0_3 = L0_3.Wait
    L1_3 = 1000
    L0_3(L1_3)
    while true do
      L0_3 = L7_1
      if not L0_3 then
        break
      end
      L0_3 = DisableFirstPersonCamThisFrame
      L0_3()
      L0_3 = DisableAllControlActions
      L1_3 = 1
      L0_3(L1_3)
      L0_3 = Citizen
      L0_3 = L0_3.Wait
      L1_3 = 0
      L0_3(L1_3)
    end
  end
  L3_2(L4_2)
  L3_2 = true
  return L3_2
end
SetupCameraForGifRecording = L12_1
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = L0_1
  if L0_2 then
    L0_2 = L7_1
    if L0_2 then
      L0_2 = L10_1.fixedCameraPosition
      if L0_2 then
        goto lbl_11
      end
    end
  end
  do return end
  ::lbl_11::
  L0_2 = SetCamCoord
  L1_2 = L6_1
  L2_2 = L10_1.fixedCameraPosition
  L2_2 = L2_2.x
  L3_2 = L10_1.fixedCameraPosition
  L3_2 = L3_2.y
  L4_2 = L10_1.fixedCameraPosition
  L4_2 = L4_2.z
  L0_2(L1_2, L2_2, L3_2, L4_2)
  L0_2 = SetCamRot
  L1_2 = L6_1
  L2_2 = 2.0
  L3_2 = 0.0
  L4_2 = 150.0
  L5_2 = 2
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = PlayerPedId
  L0_2 = L0_2()
  L1_2 = SetEntityHeading
  L2_2 = L0_2
  L3_2 = 326.0
  L1_2(L2_2, L3_2)
  L1_2 = GetEntityCoords
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PointCamAtCoord
  L3_2 = L6_1
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L7_2 = L11_1.cameraSettings
  if L7_2 then
    L7_2 = L11_1.cameraSettings
    L7_2 = L7_2.zPos
    if L7_2 then
      goto lbl_49
    end
  end
  L7_2 = 0.2
  ::lbl_49::
  L6_2 = L6_2 + L7_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
RecalibrateCameraPosition = L12_1
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = L7_1
  if L0_2 then
    L0_2 = RenderScriptCams
    L1_2 = false
    L2_2 = true
    L3_2 = 500
    L4_2 = true
    L5_2 = true
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
    L0_2 = Citizen
    L0_2 = L0_2.Wait
    L1_2 = 500
    L0_2(L1_2)
    L0_2 = DoesCamExist
    L1_2 = L6_1
    L0_2 = L0_2(L1_2)
    if L0_2 then
      L0_2 = DestroyCam
      L1_2 = L6_1
      L2_2 = false
      L0_2(L1_2, L2_2)
    end
    L0_2 = false
    L7_1 = L0_2
    L0_2 = EnableAllControlActions
    L1_2 = 0
    L0_2(L1_2)
    L0_2 = EnableAllControlActions
    L1_2 = 1
    L0_2(L1_2)
    L0_2 = EnableAllControlActions
    L1_2 = 2
    L0_2(L1_2)
    L0_2 = NetworkSetInSpectatorMode
    L1_2 = false
    L2_2 = PlayerPedId
    L2_2, L3_2, L4_2, L5_2 = L2_2()
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
    L0_2 = L8_1
    if nil ~= L0_2 then
      L0_2 = PlayerPedId
      L0_2 = L0_2()
      L1_2 = ESX
      L1_2 = L1_2.Game
      L1_2 = L1_2.Teleport
      L2_2 = L0_2
      L3_2 = L8_1
      L1_2(L2_2, L3_2)
      L1_2 = SetEntityHeading
      L2_2 = L0_2
      L3_2 = L9_1
      L1_2(L2_2, L3_2)
      L1_2 = ESX
      L1_2 = L1_2.ShowNotification
      L2_2 = "~g~Retour \195\160 votre position d'origine"
      L1_2(L2_2)
      L1_2 = nil
      L8_1 = L1_2
      L1_2 = nil
      L9_1 = L1_2
    end
  end
  L0_2 = false
  L0_1 = L0_2
end
DisableCameraForGifRecording = L12_1
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if not A0_2 then
    L1_2 = {}
    return L1_2
  end
  L1_2 = {}
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "table" == L2_2 then
    L2_2 = A0_2.AnimationOptions
    if L2_2 then
      L2_2 = A0_2.AnimationOptions
      L3_2 = L2_2.Prop
      if L3_2 then
        L3_2 = {}
        L4_2 = L2_2.Prop
        L3_2.name = L4_2
        L4_2 = L2_2.PropBone
        if not L4_2 then
          L4_2 = 60309
        end
        L3_2.bone = L4_2
        L4_2 = L2_2.PropPlacement
        if not L4_2 then
          L4_2 = {}
          L5_2 = 0.0
          L6_2 = 0.0
          L7_2 = 0.0
          L8_2 = 0.0
          L9_2 = 0.0
          L10_2 = 0.0
          L4_2[1] = L5_2
          L4_2[2] = L6_2
          L4_2[3] = L7_2
          L4_2[4] = L8_2
          L4_2[5] = L9_2
          L4_2[6] = L10_2
        end
        L3_2.placement = L4_2
        L1_2.prop = L3_2
      end
      L3_2 = L2_2.SecondProp
      if L3_2 then
        L3_2 = {}
        L4_2 = L2_2.SecondProp
        L3_2.name = L4_2
        L4_2 = L2_2.SecondPropBone
        if not L4_2 then
          L4_2 = 60309
        end
        L3_2.bone = L4_2
        L4_2 = L2_2.SecondPropPlacement
        if not L4_2 then
          L4_2 = {}
          L5_2 = 0.0
          L6_2 = 0.0
          L7_2 = 0.0
          L8_2 = 0.0
          L9_2 = 0.0
          L10_2 = 0.0
          L4_2[1] = L5_2
          L4_2[2] = L6_2
          L4_2[3] = L7_2
          L4_2[4] = L8_2
          L4_2[5] = L9_2
          L4_2[6] = L10_2
        end
        L3_2.placement = L4_2
        L1_2.secondProp = L3_2
      end
    else
      L2_2 = type
      L3_2 = A0_2[3]
      L2_2 = L2_2(L3_2)
      if "table" == L2_2 then
        L2_2 = A0_2[3]
        L3_2 = L2_2.Prop
        if L3_2 then
          L3_2 = {}
          L4_2 = L2_2.Prop
          L3_2.name = L4_2
          L4_2 = L2_2.PropBone
          if not L4_2 then
            L4_2 = 60309
          end
          L3_2.bone = L4_2
          L4_2 = L2_2.PropPlacement
          if not L4_2 then
            L4_2 = {}
            L5_2 = 0.0
            L6_2 = 0.0
            L7_2 = 0.0
            L8_2 = 0.0
            L9_2 = 0.0
            L10_2 = 0.0
            L4_2[1] = L5_2
            L4_2[2] = L6_2
            L4_2[3] = L7_2
            L4_2[4] = L8_2
            L4_2[5] = L9_2
            L4_2[6] = L10_2
          end
          L3_2.placement = L4_2
          L1_2.prop = L3_2
        end
        L3_2 = L2_2.SecondProp
        if L3_2 then
          L3_2 = {}
          L4_2 = L2_2.SecondProp
          L3_2.name = L4_2
          L4_2 = L2_2.SecondPropBone
          if not L4_2 then
            L4_2 = 60309
          end
          L3_2.bone = L4_2
          L4_2 = L2_2.SecondPropPlacement
          if not L4_2 then
            L4_2 = {}
            L5_2 = 0.0
            L6_2 = 0.0
            L7_2 = 0.0
            L8_2 = 0.0
            L9_2 = 0.0
            L10_2 = 0.0
            L4_2[1] = L5_2
            L4_2[2] = L6_2
            L4_2[3] = L7_2
            L4_2[4] = L8_2
            L4_2[5] = L9_2
            L4_2[6] = L10_2
          end
          L3_2.placement = L4_2
          L1_2.secondProp = L3_2
        end
      end
    end
  end
  return L1_2
end
ExtractPropInfo = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2
  if not A0_2 then
    L3_2 = nil
    return L3_2
  end
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = GetEntityCoords
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = table
  L5_2 = L5_2.unpack
  L6_2 = A2_2
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2(L6_2)
  L11_2 = GetHashKey
  L12_2 = A0_2
  L11_2 = L11_2(L12_2)
  L12_2 = RequestModel
  L13_2 = L11_2
  L12_2(L13_2)
  L12_2 = 0
  while true do
    L13_2 = HasModelLoaded
    L14_2 = L11_2
    L13_2 = L13_2(L14_2)
    if not (not L13_2 and L12_2 < 50) then
      break
    end
    L12_2 = L12_2 + 1
    L13_2 = RequestModel
    L14_2 = L11_2
    L13_2(L14_2)
    L13_2 = Citizen
    L13_2 = L13_2.Wait
    L14_2 = 20
    L13_2(L14_2)
  end
  L13_2 = HasModelLoaded
  L14_2 = L11_2
  L13_2 = L13_2(L14_2)
  if not L13_2 then
    L13_2 = print
    L14_2 = "Impossible de charger le mod\195\168le du prop: "
    L15_2 = A0_2
    L14_2 = L14_2 .. L15_2
    L13_2(L14_2)
    L13_2 = nil
    return L13_2
  end
  L13_2 = CreateObject
  L14_2 = L11_2
  L15_2 = L4_2.x
  L16_2 = L4_2.y
  L17_2 = L4_2.z
  L17_2 = L17_2 + 0.2
  L18_2 = true
  L19_2 = true
  L20_2 = true
  L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L14_2 = DoesEntityExist
  L15_2 = L13_2
  L14_2 = L14_2(L15_2)
  if not L14_2 then
    L14_2 = print
    L15_2 = "Impossible de cr\195\169er l'objet: "
    L16_2 = A0_2
    L15_2 = L15_2 .. L16_2
    L14_2(L15_2)
    L14_2 = SetModelAsNoLongerNeeded
    L15_2 = L11_2
    L14_2(L15_2)
    L14_2 = nil
    return L14_2
  end
  L14_2 = SetEntityVisible
  L15_2 = L13_2
  L16_2 = true
  L17_2 = false
  L14_2(L15_2, L16_2, L17_2)
  L14_2 = SetEntityAlpha
  L15_2 = L13_2
  L16_2 = 255
  L17_2 = false
  L14_2(L15_2, L16_2, L17_2)
  L14_2 = GetPedBoneIndex
  L15_2 = L3_2
  L16_2 = A1_2
  L14_2 = L14_2(L15_2, L16_2)
  L15_2 = AttachEntityToEntity
  L16_2 = L13_2
  L17_2 = L3_2
  L18_2 = L14_2
  L19_2 = L5_2
  L20_2 = L6_2
  L21_2 = L7_2
  L22_2 = L8_2
  L23_2 = L9_2
  L24_2 = L10_2
  L25_2 = true
  L26_2 = true
  L27_2 = false
  L28_2 = true
  L29_2 = 1
  L30_2 = true
  L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
  L15_2 = SetModelAsNoLongerNeeded
  L16_2 = L11_2
  L15_2(L16_2)
  return L13_2
end
CreateProp = L12_1
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = L10_1.ActiveProps
  if L0_2 then
    L0_2 = ipairs
    L1_2 = L10_1.ActiveProps
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = DoesEntityExist
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if L6_2 then
        L6_2 = DetachEntity
        L7_2 = L5_2
        L8_2 = true
        L9_2 = true
        L6_2(L7_2, L8_2, L9_2)
        L6_2 = DeleteEntity
        L7_2 = L5_2
        L6_2(L7_2)
      end
    end
    L0_2 = {}
    L10_1.ActiveProps = L0_2
  end
end
DeleteExistingProps = L12_1
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  if not A0_2 or "" == A0_2 then
    L1_2 = L11_1.debug
    if L1_2 then
      L1_2 = print
      L2_2 = "[kay_emote_gifmaker] LoadAnim: dict vide"
      L1_2(L2_2)
    end
    L1_2 = false
    return L1_2
  end
  L1_2 = RequestAnimDict
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = 0
  L2_2 = 500
  while true do
    L3_2 = HasAnimDictLoaded
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if not (not L3_2 and L1_2 < L2_2) then
      break
    end
    L1_2 = L1_2 + 1
    L3_2 = L1_2 % 50
    if 0 == L3_2 then
      L3_2 = L11_1.debug
      if L3_2 then
        L3_2 = print
        L4_2 = "[kay_emote_gifmaker] LoadAnim still waiting for "
        L5_2 = A0_2
        L6_2 = " ("
        L7_2 = L1_2
        L8_2 = ")"
        L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2
        L3_2(L4_2)
      end
    end
    L3_2 = Citizen
    L3_2 = L3_2.Wait
    L4_2 = 10
    L3_2(L4_2)
  end
  L3_2 = HasAnimDictLoaded
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = L11_1.debug
    if L3_2 then
      L3_2 = print
      L4_2 = "[kay_emote_gifmaker] LoadAnim: Timeout loading anim dict: "
      L5_2 = tostring
      L6_2 = A0_2
      L5_2 = L5_2(L6_2)
      L4_2 = L4_2 .. L5_2
      L3_2(L4_2)
    end
    L3_2 = false
    return L3_2
  end
  L3_2 = true
  return L3_2
end
LoadAnim = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = DeleteExistingProps
  L3_2()
  L3_2 = SetEntityHeading
  L4_2 = L2_2
  L5_2 = 326.0
  L3_2(L4_2, L5_2)
  L3_2 = nil
  L4_2 = nil
  L5_2 = {}
  L6_2 = type
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  if "table" == L6_2 then
    L6_2 = #A1_2
    if L6_2 >= 2 then
      L3_2 = A1_2[1]
      L4_2 = A1_2[2]
      L6_2 = A1_2.AnimationOptions
      if L6_2 then
        L5_2 = A1_2.AnimationOptions
      else
        L6_2 = type
        L7_2 = A1_2[3]
        L6_2 = L6_2(L7_2)
        if "table" == L6_2 then
          L5_2 = A1_2[3]
        end
      end
  end
  else
    L6_2 = type
    L7_2 = A1_2
    L6_2 = L6_2(L7_2)
    if "table" == L6_2 then
      L6_2 = A1_2.Dictionary
      if L6_2 then
        L6_2 = A1_2.Animation
        if L6_2 then
          L3_2 = A1_2.Dictionary
          L4_2 = A1_2.Animation
          L6_2 = A1_2.Options
          if L6_2 then
            L5_2 = A1_2.Options
          end
      end
    end
    else
      L6_2 = TriggerEvent
      L7_2 = "chat:addMessage"
      L8_2 = {}
      L9_2 = {}
      L10_2 = 255
      L11_2 = 0
      L12_2 = 0
      L9_2[1] = L10_2
      L9_2[2] = L11_2
      L9_2[3] = L12_2
      L8_2.color = L9_2
      L8_2.multiline = false
      L9_2 = {}
      L10_2 = "Syst\195\168me"
      L11_2 = "Format d'\195\169mote invalide: "
      L12_2 = A0_2
      L11_2 = L11_2 .. L12_2
      L9_2[1] = L10_2
      L9_2[2] = L11_2
      L8_2.args = L9_2
      L6_2(L7_2, L8_2)
      L6_2 = false
      return L6_2
    end
  end
  if "Scenario" == L3_2 or "MaleScenario" == L3_2 or "ScenarioObject" == L3_2 then
    if "Scenario" == L3_2 then
      L6_2 = TaskStartScenarioInPlace
      L7_2 = L2_2
      L8_2 = L4_2
      L9_2 = 0
      L10_2 = true
      L6_2(L7_2, L8_2, L9_2, L10_2)
    elseif "MaleScenario" == L3_2 then
      L6_2 = TaskStartScenarioInPlace
      L7_2 = L2_2
      L8_2 = L4_2
      L9_2 = 0
      L10_2 = true
      L6_2(L7_2, L8_2, L9_2, L10_2)
    elseif "ScenarioObject" == L3_2 then
      L6_2 = GetOffsetFromEntityInWorldCoords
      L7_2 = L2_2
      L8_2 = 0.0
      L9_2 = -0.5
      L10_2 = -0.5
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
      L7_2 = TaskStartScenarioAtPosition
      L8_2 = L2_2
      L9_2 = L4_2
      L10_2 = L6_2.x
      L11_2 = L6_2.y
      L12_2 = L6_2.z
      L13_2 = GetEntityHeading
      L14_2 = L2_2
      L13_2 = L13_2(L14_2)
      L14_2 = 0
      L15_2 = true
      L16_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    end
    L6_2 = Citizen
    L6_2 = L6_2.Wait
    L7_2 = 500
    L6_2(L7_2)
    L6_2 = true
    return L6_2
  end
  L6_2 = ExtractPropInfo
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L7_2 = {}
  if not (L3_2 and "" ~= L3_2 and L4_2) or "" == L4_2 then
    L8_2 = TriggerEvent
    L9_2 = "chat:addMessage"
    L10_2 = {}
    L11_2 = {}
    L12_2 = 255
    L13_2 = 0
    L14_2 = 0
    L11_2[1] = L12_2
    L11_2[2] = L13_2
    L11_2[3] = L14_2
    L10_2.color = L11_2
    L10_2.multiline = false
    L11_2 = {}
    L12_2 = "Syst\195\168me"
    L13_2 = "Animation invalide (dict/name): dict='"
    L14_2 = tostring
    L15_2 = L3_2
    L14_2 = L14_2(L15_2)
    L15_2 = "' name='"
    L16_2 = tostring
    L17_2 = L4_2
    L16_2 = L16_2(L17_2)
    L17_2 = "' pour \195\169mote: "
    L18_2 = A0_2
    L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2 .. L17_2 .. L18_2
    L11_2[1] = L12_2
    L11_2[2] = L13_2
    L10_2.args = L11_2
    L8_2(L9_2, L10_2)
    L8_2 = false
    return L8_2
  end
  L8_2 = LoadAnim
  L9_2 = L3_2
  L8_2 = L8_2(L9_2)
  if not L8_2 then
    L8_2 = TriggerEvent
    L9_2 = "chat:addMessage"
    L10_2 = {}
    L11_2 = {}
    L12_2 = 255
    L13_2 = 0
    L14_2 = 0
    L11_2[1] = L12_2
    L11_2[2] = L13_2
    L11_2[3] = L14_2
    L10_2.color = L11_2
    L10_2.multiline = false
    L11_2 = {}
    L12_2 = "Syst\195\168me"
    L13_2 = "Impossible de charger l'animation: "
    L14_2 = tostring
    L15_2 = L3_2
    L14_2 = L14_2(L15_2)
    L13_2 = L13_2 .. L14_2
    L11_2[1] = L12_2
    L11_2[2] = L13_2
    L10_2.args = L11_2
    L8_2(L9_2, L10_2)
    L8_2 = false
    return L8_2
  end
  L8_2 = 0
  L9_2 = L5_2.EmoteLoop
  if L9_2 then
    L8_2 = L8_2 | 1
  end
  L9_2 = L5_2.EmoteMoving
  if L9_2 then
    L8_2 = L8_2 | 51
  end
  L9_2 = TaskPlayAnim
  L10_2 = L2_2
  L11_2 = L3_2
  L12_2 = L4_2
  L13_2 = 8.0
  L14_2 = -8.0
  L15_2 = -1
  L16_2 = L8_2
  L17_2 = 0
  L18_2 = false
  L19_2 = false
  L20_2 = false
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L9_2 = Citizen
  L9_2 = L9_2.Wait
  L10_2 = 300
  L9_2(L10_2)
  L9_2 = L6_2.prop
  if L9_2 then
    L9_2 = CreateProp
    L10_2 = L6_2.prop
    L10_2 = L10_2.name
    L11_2 = L6_2.prop
    L11_2 = L11_2.bone
    L12_2 = L6_2.prop
    L12_2 = L12_2.placement
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    if L9_2 then
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L7_2
      L12_2 = L9_2
      L10_2(L11_2, L12_2)
      L10_2 = TriggerEvent
      L11_2 = "chat:addMessage"
      L12_2 = {}
      L13_2 = {}
      L14_2 = 0
      L15_2 = 255
      L16_2 = 0
      L13_2[1] = L14_2
      L13_2[2] = L15_2
      L13_2[3] = L16_2
      L12_2.color = L13_2
      L12_2.multiline = false
      L13_2 = {}
      L14_2 = "Syst\195\168me"
      L15_2 = "Prop attach\195\169: "
      L16_2 = L6_2.prop
      L16_2 = L16_2.name
      L15_2 = L15_2 .. L16_2
      L13_2[1] = L14_2
      L13_2[2] = L15_2
      L12_2.args = L13_2
      L10_2(L11_2, L12_2)
    end
  end
  L9_2 = L6_2.secondProp
  if L9_2 then
    L9_2 = CreateProp
    L10_2 = L6_2.secondProp
    L10_2 = L10_2.name
    L11_2 = L6_2.secondProp
    L11_2 = L11_2.bone
    L12_2 = L6_2.secondProp
    L12_2 = L12_2.placement
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    if L9_2 then
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L7_2
      L12_2 = L9_2
      L10_2(L11_2, L12_2)
      L10_2 = TriggerEvent
      L11_2 = "chat:addMessage"
      L12_2 = {}
      L13_2 = {}
      L14_2 = 0
      L15_2 = 255
      L16_2 = 0
      L13_2[1] = L14_2
      L13_2[2] = L15_2
      L13_2[3] = L16_2
      L12_2.color = L13_2
      L12_2.multiline = false
      L13_2 = {}
      L14_2 = "Syst\195\168me"
      L15_2 = "Second prop attach\195\169: "
      L16_2 = L6_2.secondProp
      L16_2 = L16_2.name
      L15_2 = L15_2 .. L16_2
      L13_2[1] = L14_2
      L13_2[2] = L15_2
      L12_2.args = L13_2
      L10_2(L11_2, L12_2)
    end
  end
  L10_1.ActiveProps = L7_2
  L9_2 = true
  return L9_2
end
PlayEmoteForRecording = L12_1
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = 0
  L2_2 = 9
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = TriggerServerEvent
    L6_2 = "kay_emote:takeScreenshot"
    L7_2 = A0_2
    L8_2 = L4_2
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = Citizen
    L5_2 = L5_2.Wait
    L6_2 = 200
    L5_2(L6_2)
  end
  L1_2 = TriggerServerEvent
  L2_2 = "kay_emote:createGif"
  L3_2 = A0_2
  L4_2 = 10
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = false
  L2_2 = RegisterNetEvent
  L3_2 = "kay_emote:gifCreated"
  L2_2(L3_2)
  L2_2 = AddEventHandler
  L3_2 = "kay_emote:gifCreated"
  function L4_2(A0_3)
    local L1_3
    L1_3 = A0_2
    if A0_3 == L1_3 then
      L1_3 = true
      L1_2 = L1_3
    end
  end
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = 0
  while not L1_2 and L3_2 < 20 do
    L4_2 = Citizen
    L4_2 = L4_2.Wait
    L5_2 = 500
    L4_2(L5_2)
    L3_2 = L3_2 + 1
  end
  L4_2 = RemoveEventHandler
  L5_2 = L2_2
  L4_2(L5_2)
  L4_2 = TriggerEvent
  L5_2 = "chat:addMessage"
  L6_2 = {}
  L7_2 = {}
  L8_2 = 93
  L9_2 = 0
  L10_2 = 255
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L6_2.color = L7_2
  L6_2.multiline = false
  L7_2 = {}
  L8_2 = "Syst\195\168me"
  L9_2 = " GIF cr\195\169\195\169 pour: "
  L10_2 = A0_2
  L9_2 = L9_2 .. L10_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L6_2.args = L7_2
  L4_2(L5_2, L6_2)
  L4_2 = true
  return L4_2
end
CreateGifForEmote = L12_1
function L12_1()
  local L0_2, L1_2
  return
end
AdjustCameraForPedHeight = L12_1
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = L1_1
  if L0_2 then
    L0_2 = L2_1
    L0_2 = #L0_2
    if 0 ~= L0_2 then
      goto lbl_17
    end
  end
  L0_2 = ESX
  L0_2 = L0_2.ShowNotification
  L1_2 = "~g~Toutes les \195\169motes ont \195\169t\195\169 enregistr\195\169es!"
  L0_2(L1_2)
  L0_2 = false
  L1_1 = L0_2
  L0_2 = DisableCameraForGifRecording
  L0_2()
  do return end
  ::lbl_17::
  L0_2 = L7_1
  if not L0_2 then
    L0_2 = SetupCameraForGifRecording
    L0_2()
  else
    L0_2 = RecalibrateCameraPosition
    L0_2()
  end
  L0_2 = L3_1
  L0_2 = L0_2 + 1
  L3_1 = L0_2
  L0_2 = table
  L0_2 = L0_2.remove
  L1_2 = L2_1
  L2_2 = 1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L0_2.name
  L2_2 = L0_2.category
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = SetEntityHeading
  L5_2 = L3_2
  L6_2 = 326.0
  L4_2(L5_2, L6_2)
  L4_2 = Citizen
  L4_2 = L4_2.Wait
  L5_2 = 100
  L4_2(L5_2)
  L4_2 = L3_1
  L4_2 = L4_2 % 5
  if 0 ~= L4_2 then
    L4_2 = L3_1
    if 1 ~= L4_2 then
      L4_2 = L3_1
      L5_2 = L4_1
      if L4_2 ~= L5_2 then
        goto lbl_67
      end
    end
  end
  L4_2 = math
  L4_2 = L4_2.floor
  L5_2 = L3_1
  L6_2 = L4_1
  L5_2 = L5_2 / L6_2
  L5_2 = L5_2 * 100
  L4_2 = L4_2(L5_2)
  ::lbl_67::
  L4_2 = ClearPedTasks
  L5_2 = PlayerPedId
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L5_2()
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = DeleteExistingProps
  L4_2()
  L4_2 = nil
  if "PropEmotes" == L2_2 then
    L5_2 = RP
    L5_2 = L5_2.PropEmotes
    if L5_2 then
      L5_2 = RP
      L5_2 = L5_2.PropEmotes
      L4_2 = L5_2[L1_2]
  end
  else
    if "Emotes" == L2_2 then
      L5_2 = RP
      L5_2 = L5_2.Emotes
      if L5_2 then
        L5_2 = RP
        L5_2 = L5_2.Emotes
        L4_2 = L5_2[L1_2]
    end
    else
      if "Dances" == L2_2 then
        L5_2 = RP
        L5_2 = L5_2.Dances
        if L5_2 then
          L5_2 = RP
          L5_2 = L5_2.Dances
          L4_2 = L5_2[L1_2]
      end
      elseif "Shared" == L2_2 then
        L5_2 = RP
        L5_2 = L5_2.Shared
        if L5_2 then
          L5_2 = RP
          L5_2 = L5_2.Shared
          L4_2 = L5_2[L1_2]
        end
      end
    end
  end
  if not L4_2 then
    L5_2 = TriggerEvent
    L6_2 = "chat:addMessage"
    L7_2 = {}
    L8_2 = {}
    L9_2 = 255
    L10_2 = 0
    L11_2 = 0
    L8_2[1] = L9_2
    L8_2[2] = L10_2
    L8_2[3] = L11_2
    L7_2.color = L8_2
    L7_2.multiline = false
    L8_2 = {}
    L9_2 = "Syst\195\168me"
    L10_2 = "\195\137mote non trouv\195\169e: "
    L11_2 = L1_2
    L10_2 = L10_2 .. L11_2
    L8_2[1] = L9_2
    L8_2[2] = L10_2
    L7_2.args = L8_2
    L5_2(L6_2, L7_2)
    L5_2 = Citizen
    L5_2 = L5_2.Wait
    L6_2 = 200
    L5_2(L6_2)
    L5_2 = RecordEmotesSequentially
    L5_2()
    return
  end
  L5_2 = PlayEmoteForRecording
  L6_2 = L1_2
  L7_2 = L4_2
  L5_2 = L5_2(L6_2, L7_2)
  if L5_2 then
    L6_2 = Citizen
    L6_2 = L6_2.Wait
    L7_2 = 500
    L6_2(L7_2)
    L6_2 = CreateGifForEmote
    L7_2 = L1_2
    L6_2(L7_2)
  end
  L6_2 = Citizen
  L6_2 = L6_2.Wait
  L7_2 = 1500
  L6_2(L7_2)
  L6_2 = RecordEmotesSequentially
  L6_2()
end
RecordEmotesSequentially = L12_1
L12_1 = RegisterCommand
L13_1 = "gifallemotes"
function L14_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L3_2 = L1_1
  if L3_2 then
    L3_2 = ESX
    L3_2 = L3_2.ShowNotification
    L4_2 = "~r~Enregistrement d\195\169j\195\160 en cours. Utilisez /stopgifallemotes pour l'arr\195\170ter."
    L3_2(L4_2)
    return
  end
  L3_2 = LoadAnimationsFromRPEmotes
  L3_2 = L3_2()
  if not L3_2 then
    L3_2 = ESX
    L3_2 = L3_2.ShowNotification
    L4_2 = "~r~Impossible de charger les animations depuis RPEmotes"
    L3_2(L4_2)
    return
  end
  L3_2 = A1_2[1]
  if not L3_2 then
    L3_2 = "all"
  end
  L4_2 = tonumber
  L5_2 = A1_2[2]
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = 0
  end
  L5_2 = {}
  L5_2.emotes = "Emotes"
  L5_2.props = "PropEmotes"
  L5_2.dances = "Dances"
  L5_2.shared = "Shared"
  L5_2.all = "all"
  L6_2 = L5_2[L3_2]
  if not L6_2 then
    L6_2 = ESX
    L6_2 = L6_2.ShowNotification
    L7_2 = "~r~Cat\195\169gorie invalide. Utilisez: emotes, props, dances, shared, all"
    L6_2(L7_2)
    return
  end
  L6_2 = SetupCameraForGifRecording
  L6_2 = L6_2()
  if not L6_2 then
    L6_2 = ESX
    L6_2 = L6_2.ShowNotification
    L7_2 = "~r~Impossible de configurer la cam\195\169ra"
    L6_2(L7_2)
    return
  end
  L6_2 = {}
  L2_1 = L6_2
  if "all" == L3_2 then
    L6_2 = pairs
    L7_2 = RP
    L7_2 = L7_2.Emotes
    if not L7_2 then
      L7_2 = {}
    end
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = table
      L12_2 = L12_2.insert
      L13_2 = L2_1
      L14_2 = {}
      L14_2.name = L10_2
      L14_2.category = "Emotes"
      L12_2(L13_2, L14_2)
    end
    L6_2 = pairs
    L7_2 = RP
    L7_2 = L7_2.PropEmotes
    if not L7_2 then
      L7_2 = {}
    end
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = table
      L12_2 = L12_2.insert
      L13_2 = L2_1
      L14_2 = {}
      L14_2.name = L10_2
      L14_2.category = "PropEmotes"
      L12_2(L13_2, L14_2)
    end
    L6_2 = pairs
    L7_2 = RP
    L7_2 = L7_2.Dances
    if not L7_2 then
      L7_2 = {}
    end
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = table
      L12_2 = L12_2.insert
      L13_2 = L2_1
      L14_2 = {}
      L14_2.name = L10_2
      L14_2.category = "Dances"
      L12_2(L13_2, L14_2)
    end
    L6_2 = pairs
    L7_2 = RP
    L7_2 = L7_2.Shared
    if not L7_2 then
      L7_2 = {}
    end
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = table
      L12_2 = L12_2.insert
      L13_2 = L2_1
      L14_2 = {}
      L14_2.name = L10_2
      L14_2.category = "Shared"
      L12_2(L13_2, L14_2)
    end
  else
    L6_2 = L5_2[L3_2]
    L7_2 = RP
    L7_2 = L7_2[L6_2]
    if L7_2 then
      L7_2 = pairs
      L8_2 = RP
      L8_2 = L8_2[L6_2]
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = table
        L13_2 = L13_2.insert
        L14_2 = L2_1
        L15_2 = {}
        L15_2.name = L11_2
        L15_2.category = L6_2
        L13_2(L14_2, L15_2)
      end
    end
  end
  L6_2 = L2_1
  L6_2 = #L6_2
  if 0 == L6_2 then
    L6_2 = ESX
    L6_2 = L6_2.ShowNotification
    L7_2 = "~r~Aucune \195\169mote trouv\195\169e dans la cat\195\169gorie "
    L8_2 = L3_2
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    return
  end
  if L4_2 > 0 then
    L6_2 = L2_1
    L6_2 = #L6_2
    if L4_2 < L6_2 then
      L6_2 = {}
      L7_2 = L4_2 + 1
      L8_2 = L2_1
      L8_2 = #L8_2
      L9_2 = 1
      for L10_2 = L7_2, L8_2, L9_2 do
        L11_2 = table
        L11_2 = L11_2.insert
        L12_2 = L6_2
        L13_2 = L2_1
        L13_2 = L13_2[L10_2]
        L11_2(L12_2, L13_2)
      end
      L2_1 = L6_2
    end
  end
  L6_2 = L2_1
  L6_2 = #L6_2
  L4_1 = L6_2
  L6_2 = 0
  L3_1 = L6_2
  L6_2 = true
  L1_1 = L6_2
  L6_2 = RecordEmotesSequentially
  L6_2()
end
L15_1 = false
L12_1(L13_1, L14_1, L15_1)
L12_1 = RegisterCommand
L13_1 = "stopgifallemotes"
function L14_1()
  local L0_2, L1_2
  L0_2 = L1_1
  if L0_2 then
    L0_2 = false
    L1_1 = L0_2
    L0_2 = {}
    L2_1 = L0_2
    L0_2 = DisableCameraForGifRecording
    L0_2()
    L0_2 = ClearPedTasks
    L1_2 = PlayerPedId
    L1_2 = L1_2()
    L0_2(L1_2)
    L0_2 = DeleteExistingProps
    L0_2()
  else
    L0_2 = ESX
    L0_2 = L0_2.ShowNotification
    L1_2 = "~y~Aucun enregistrement en cours."
    L0_2(L1_2)
    L0_2 = L7_1
    if L0_2 then
      L0_2 = DisableCameraForGifRecording
      L0_2()
    end
  end
end
L15_1 = false
L12_1(L13_1, L14_1, L15_1)
L12_1 = Citizen
L12_1 = L12_1.CreateThread
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = TriggerEvent
  L1_2 = "chat:addSuggestion"
  L2_2 = "/gifallemotes"
  L3_2 = "Cr\195\169er des GIFs pour plusieurs \195\169motes"
  L4_2 = {}
  L5_2 = {}
  L5_2.name = "category"
  L5_2.help = "Cat\195\169gorie: emotes, props, dances, shared, all"
  L6_2 = {}
  L6_2.name = "startindex"
  L6_2.help = "Index de d\195\169part (optionnel)"
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L0_2(L1_2, L2_2, L3_2, L4_2)
  L0_2 = TriggerEvent
  L1_2 = "chat:addSuggestion"
  L2_2 = "/stopgifallemotes"
  L3_2 = "Arr\195\170ter l'enregistrement des GIFs"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = LoadAnimationsFromRPEmotes
  L0_2()
end
L12_1(L13_1)
