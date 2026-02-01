const config = JSON.parse(
  LoadResourceFile(GetCurrentResourceName(), 'config.json')
)
let recording = false,
  recordingEmote = '',
  currentFrame = 0,
  maxFrames = 30,
  delay = 100,
  recordingInterval = null,
  cam = null,
  ped = null
function LoadAnimDict(_0x43ed20) {
  return new Promise((_0x720508) => {
    if (!DoesAnimDictExist(_0x43ed20)) {
      console.error("Le dictionnaire d'animation n'existe pas: " + _0x43ed20)
      _0x720508(false)
      return
    }
    RequestAnimDict(_0x43ed20)
    const _0x47e863 = GetGameTimer(),
      _0x591074 = setInterval(() => {
        if (HasAnimDictLoaded(_0x43ed20)) {
          clearInterval(_0x591074)
          _0x720508(true)
        } else {
          GetGameTimer() - _0x47e863 > 5000 &&
            (clearInterval(_0x591074),
            console.error(
              'Timeout lors du chargement du dictionnaire: ' + _0x43ed20
            ),
            _0x720508(false))
        }
      }, 10)
  })
}
async function SetupGreenScreen() {
  SetWeatherTypePersist('EXTRASUNNY')
  SetWeatherTypeNow('EXTRASUNNY')
  NetworkOverrideClockTime(12, 0, 0)
  ped = PlayerPedId()
  SetEntityCoords(
    ped,
    config.greenScreenPosition.x,
    config.greenScreenPosition.y,
    config.greenScreenPosition.z,
    false,
    false,
    false,
    false
  )
  SetEntityRotation(
    ped,
    config.greenScreenRotation.x,
    config.greenScreenRotation.y,
    config.greenScreenRotation.z,
    2,
    false
  )
  FreezeEntityPosition(ped, true)
  await new Promise((_0x1ae4d7) => setTimeout(_0x1ae4d7, 500))
  cam && (DestroyAllCams(true), DestroyCam(cam, true))
  const [_0x53e0dc, _0x47136b, _0xe6f746] = GetEntityCoords(ped, false),
    [_0x24ded7, _0x390e26, _0x53f257] = GetEntityForwardVector(ped),
    _0x4b6e37 = {
      x: _0x53e0dc + _0x24ded7 * config.cameraSettings.distance,
      y: _0x47136b + _0x390e26 * config.cameraSettings.distance,
      z: _0xe6f746 + config.cameraSettings.zPos,
    }
  return (
    (cam = CreateCamWithParams(
      'DEFAULT_SCRIPTED_CAMERA',
      _0x4b6e37.x,
      _0x4b6e37.y,
      _0x4b6e37.z,
      0,
      0,
      0,
      config.cameraSettings.fov,
      true,
      0
    )),
    PointCamAtCoord(
      cam,
      _0x53e0dc,
      _0x47136b,
      _0xe6f746 + config.cameraSettings.zPos
    ),
    SetCamActive(cam, true),
    RenderScriptCams(true, false, 0, true, false, 0),
    true
  )
}
RegisterNetEvent('kay_emote:recordEmoteDirect')
onNet('kay_emote:recordEmoteDirect', async (_0x585435, _0x4184d1) => {
  await RecordEmote(_0x585435, _0x4184d1)
})
function CleanupGreenScreen() {
  cam &&
    (DestroyAllCams(true),
    DestroyCam(cam, true),
    RenderScriptCams(false, false, 0, true, false, 0))
  ped && (FreezeEntityPosition(ped, false), ClearPedTasks(ped))
  SetWeatherTypeNow('CLEAR')
}
async function RecordEmote(_0x2e7f89, _0x1311fc) {
  if (!_0x1311fc) {
    return console.error('Émote non trouvée: ' + _0x2e7f89), false
  }
  recording && StopRecordingEmote()
  const _0x592e87 = await SetupGreenScreen()
  if (!_0x592e87) {
    return false
  }
  recordingEmote = _0x2e7f89
  recording = true
  currentFrame = 0
  console.log("Type d'emoteData:", typeof _0x1311fc)
  if (Array.isArray(_0x1311fc)) {
    console.log('emoteData est un tableau de longueur', _0x1311fc.length)
  } else {
    typeof _0x1311fc === 'object' &&
      console.log('emoteData est un objet avec clés:', Object.keys(_0x1311fc))
  }
  let _0x1636b9,
    _0x249ceb,
    _0x4186c0 = {}
  if (Array.isArray(_0x1311fc) && _0x1311fc.length >= 2) {
    _0x1636b9 = _0x1311fc[0] || _0x1311fc[1]
    _0x249ceb = _0x1311fc[1] || _0x1311fc[0]
    _0x1311fc.length >= 4 &&
      typeof _0x1311fc[3] === 'object' &&
      (_0x4186c0 = _0x1311fc[3])
    for (const _0x3c3332 in _0x1311fc) {
      if (
        _0x3c3332 === 'AnimationOptions' &&
        typeof _0x1311fc[_0x3c3332] === 'object'
      ) {
        _0x4186c0 = _0x1311fc[_0x3c3332]
        break
      }
    }
  } else {
    if (typeof _0x1311fc === 'object') {
      if (_0x1311fc.Dictionary && _0x1311fc.Animation) {
        _0x1636b9 = _0x1311fc.Dictionary
        _0x249ceb = _0x1311fc.Animation
        _0x4186c0 = _0x1311fc.AnimationOptions || {}
      } else {
        if (_0x1311fc.AnimationOptions) {
          _0x4186c0 = _0x1311fc.AnimationOptions
          for (const _0x3893db in _0x1311fc) {
            if (
              _0x3893db !== 'AnimationOptions' &&
              typeof _0x1311fc[_0x3893db] === 'string'
            ) {
              if (!_0x1636b9) {
                _0x1636b9 = _0x1311fc[_0x3893db]
              } else {
                if (!_0x249ceb) {
                  _0x249ceb = _0x1311fc[_0x3893db]
                }
              }
            }
          }
        } else {
          ;(_0x2e7f89 === 'sit' || _0x2e7f89 === 'sitchair') &&
            ((_0x1636b9 = 'anim@amb@business@bgen@bgen_no_work@'),
            (_0x249ceb = 'sit_phone_phoneputdown_idle_nowork'),
            (_0x4186c0 = { EmoteLoop: true }))
        }
      }
    }
  }
  ;(!_0x1636b9 || !_0x249ceb) &&
    (_0x2e7f89 === 'sit' || _0x2e7f89 === 'sitchair'
      ? ((_0x1636b9 = 'anim@amb@business@bgen@bgen_no_work@'),
        (_0x249ceb = 'sit_phone_phoneputdown_idle_nowork'),
        (_0x4186c0 = { EmoteLoop: true }))
      : ((_0x1636b9 = 'anim@amb@nightclub@dancers@solomun_entourage@'),
        (_0x249ceb = 'mi_dance_facedj_17_v1_female^1'),
        (_0x4186c0 = { EmoteLoop: true })))
  emit('chat:addMessage', {
    color: [255, 255, 0],
    multiline: true,
    args: [
      'Système',
      'Animation résolue: Dict=' + _0x1636b9 + ', Name=' + _0x249ceb,
    ],
  })
  if (!(await LoadAnimDict(_0x1636b9))) {
    return (
      emit('chat:addMessage', {
        color: [255, 0, 0],
        multiline: true,
        args: [
          'Système',
          "Impossible de charger le dictionnaire d'animation: " + _0x1636b9,
        ],
      }),
      CleanupGreenScreen(),
      false
    )
  }
  let _0x5bc7a8 = 0
  if (_0x4186c0.EmoteLoop) {
    _0x5bc7a8 |= 1
  }
  if (_0x4186c0.EmoteMoving) {
    _0x5bc7a8 |= 51
  }
  const _0x2b017c = _0x4186c0.EmoteDuration || -1,
    _0x132d77 = PlayerPedId()
  TaskPlayAnim(
    _0x132d77,
    _0x1636b9,
    _0x249ceb,
    8,
    -8,
    _0x2b017c,
    _0x5bc7a8,
    0,
    false,
    false,
    false
  )
  await new Promise((_0x2719b9) => setTimeout(_0x2719b9, 300))
  if (!IsEntityPlayingAnim(_0x132d77, _0x1636b9, _0x249ceb, 3)) {
    return (
      emit('chat:addMessage', {
        color: [255, 0, 0],
        multiline: true,
        args: [
          'Système',
          "L'animation n'a pas démarré correctement: " + _0x2e7f89,
        ],
      }),
      CleanupGreenScreen(),
      false
    )
  }
  return (
    (recordingInterval = setInterval(() => {
      currentFrame < maxFrames
        ? (emitNet('kay_emote:takeScreenshot', recordingEmote, currentFrame),
          currentFrame++)
        : StopRecordingEmote()
    }, delay)),
    true
  )
}
function StopRecordingEmote() {
  recordingInterval &&
    (clearInterval(recordingInterval), (recordingInterval = null))
  recording = false
  CleanupGreenScreen()
  currentFrame > 0 &&
    emitNet('kay_emote:createGif', recordingEmote, currentFrame)
}
RegisterCommand(
  'gifemote',
  async (_0x1048c2, _0x631e6f, _0x39b5d0) => {
    if (!_0x631e6f[0]) {
      emit('chat:addMessage', {
        color: [255, 0, 0],
        multiline: true,
        args: ['Système', "Vous devez spécifier le nom d'une émote."],
      })
      return
    }
    const _0x5a9583 = _0x631e6f[0],
      _0xe295a1 = exports[GetCurrentResourceName()].getEmoteData(_0x5a9583)
    if (!_0xe295a1) {
      emit('chat:addMessage', {
        color: [255, 0, 0],
        multiline: true,
        args: ['Système', "Émote '" + _0x5a9583 + "' non trouvée."],
      })
      return
    }
    emit('chat:addMessage', {
      color: [0, 255, 0],
      multiline: true,
      args: ['Système', "Enregistrement de l'émote '" + _0x5a9583 + "'..."],
    })
    const _0x2dcf24 = await RecordEmote(_0x5a9583, _0xe295a1)
    !_0x2dcf24 &&
      emit('chat:addMessage', {
        color: [255, 0, 0],
        multiline: true,
        args: [
          'Système',
          "Échec de l'enregistrement de l'émote '" + _0x5a9583 + "'.",
        ],
      })
  },
  false
)
on('onResourceStop', (_0x416de2) => {
  if (GetCurrentResourceName() !== _0x416de2) {
    return
  }
  recording && StopRecordingEmote()
})
RegisterCommand(
  'reloadfbemote',
  () => {
    emit('chat:addMessage', {
      color: [255, 255, 0],
      multiline: true,
      args: ['Système', 'Rechargement des émotes...'],
    })
    TriggerEvent('kay_emote:reloadMenu')
  },
  false
)
RegisterCommand(
  'recordemotes',
  function (_0x4c075f, _0x153e84, _0x4bf8f1) {
    !recording
      ? ((recording = true), emitNet('kay_emote:startRecording'))
      : (emitNet('kay_emote:stopRecording'), (recording = false))
  },
  false
)
typeof RegisterNuiCallbackType === 'function' &&
  (RegisterNuiCallbackType('closeEmotePreview'),
  on('__cfx_nui:closeEmotePreview', (_0x5ef022, _0x2f1e3f) => {
    SetNuiFocus(false, false)
    _0x2f1e3f({})
  }))
