const fs = require('fs'),
  path = require('path'),
  GIFEncoder = require('gifencoder'),
  PNG = require('png-js'),
  resName = GetCurrentResourceName(),
  resourcePath = GetResourcePath(resName).replace(/\\/g, '/'),
  screenshotsDir = path.join(resourcePath, 'temp_screenshots'),
  gifsDir = path.join(resourcePath, 'html', 'gifs')
try {
  !fs.existsSync(screenshotsDir) &&
    (fs.mkdirSync(screenshotsDir, { recursive: true }),
    console.log("Dossier de captures d'écran créé: " + screenshotsDir))
  !fs.existsSync(gifsDir) &&
    (fs.mkdirSync(gifsDir, { recursive: true }),
    console.log('Dossier de GIFs créé: ' + gifsDir))
} catch (_0x62e8c6) {
  console.error('Erreur lors de la création des dossiers: ' + _0x62e8c6.message)
}
try {
  const testScreenshotPath = path.join(screenshotsDir, 'test.txt')
  fs.writeFileSync(testScreenshotPath, 'Test file')
  fs.unlinkSync(testScreenshotPath)
  const testGifPath = path.join(gifsDir, 'test.txt')
  fs.writeFileSync(testGifPath, 'Test file')
  fs.unlinkSync(testGifPath)
} catch (_0xe8d79) {
  console.error(
    "ERREUR CRITIQUE: Impossible d'écrire dans les dossiers - " +
      _0xe8d79.message
  )
  console.error(
    'SOLUTION: Vérifiez les permissions des dossiers ' +
      screenshotsDir +
      ' et ' +
      gifsDir
  )
}
const greenScreenConfig = {
  minGreen: 80,
  greenRedRatio: 1.4,
  greenBlueRatio: 1.4,
  transparentColor: 65280,
}
try {
  const testScreenshotPath = path.join(screenshotsDir, 'test.txt')
  fs.writeFileSync(testScreenshotPath, 'Test file')
  fs.unlinkSync(testScreenshotPath)
  const testGifPath = path.join(gifsDir, 'test.txt')
  fs.writeFileSync(testGifPath, 'Test file')
  fs.unlinkSync(testGifPath)
} catch (_0x1296b3) {
  console.error(
    "ERREUR CRITIQUE: Impossible d'écrire dans les dossiers - " +
      _0x1296b3.message
  )
  console.error(
    'SOLUTION: Vérifiez les permissions des dossiers ' +
      screenshotsDir +
      ' et ' +
      gifsDir
  )
}
function updateGreenScreenConfig(_0x3011b5) {
  if (_0x3011b5.minGreen !== undefined) {
    greenScreenConfig.minGreen = _0x3011b5.minGreen
  }
  if (_0x3011b5.greenRedRatio !== undefined) {
    greenScreenConfig.greenRedRatio = _0x3011b5.greenRedRatio
  }
  if (_0x3011b5.greenBlueRatio !== undefined) {
    greenScreenConfig.greenBlueRatio = _0x3011b5.greenBlueRatio
  }
  if (_0x3011b5.transparentColor !== undefined) {
    greenScreenConfig.transparentColor = _0x3011b5.transparentColor
  }
  console.log(
    'Configuration du fond vert mise à jour: ' +
      JSON.stringify(greenScreenConfig)
  )
}
try {
  !fs.existsSync(screenshotsDir) &&
    fs.mkdirSync(screenshotsDir, { recursive: true })
  !fs.existsSync(gifsDir) && fs.mkdirSync(gifsDir, { recursive: true })
} catch (_0x84186c) {
  console.error('Erreur lors de la création des dossiers: ' + _0x84186c.message)
}
function decodeFromFile(_0xa75f99) {
  return new Promise((_0xe72de9, _0x46fee4) => {
    try {
      const _0x2b06dd = new PNG(fs.readFileSync(_0xa75f99))
      _0x2b06dd.decode((_0x224540) => {
        _0xe72de9({
          pixels: _0x224540,
          width: _0x2b06dd.width,
          height: _0x2b06dd.height,
        })
      })
    } catch (_0x503023) {
      _0x46fee4(_0x503023)
    }
  })
}
RegisterNetEvent('kay_emote:takeScreenshot')
onNet('kay_emote:takeScreenshot', (_0x214214, _0xa35e8e) => {
  const _0x48e4f3 = global.source,
    _0x3e7a59 = path.join(screenshotsDir, _0x214214 + '_' + _0xa35e8e + '.png')
  exports['screenshot-basic'].requestClientScreenshot(
    _0x48e4f3,
    {
      fileName: _0x3e7a59,
      encoding: 'png',
      quality: 1,
    },
    (_0x19e54b) => {
      if (_0x19e54b) {
        console.error("Erreur lors de la capture d'écran: " + _0x19e54b)
        emitNet(
          'kay_emote:screenshotTaken',
          _0x48e4f3,
          _0x214214,
          _0xa35e8e,
          false
        )
      } else {
        if (fs.existsSync(_0x3e7a59)) {
          const _0x494096 = fs.statSync(_0x3e7a59).size
          _0x494096 > 1000
            ? emitNet(
                'kay_emote:screenshotTaken',
                _0x48e4f3,
                _0x214214,
                _0xa35e8e,
                true
              )
            : (console.error(
                "Capture d'écran trop petite: " +
                  _0x3e7a59 +
                  ' (' +
                  _0x494096 +
                  ' bytes)'
              ),
              emitNet(
                'kay_emote:screenshotTaken',
                _0x48e4f3,
                _0x214214,
                _0xa35e8e,
                false
              ))
        } else {
          console.error("Capture d'écran non sauvegardée: " + _0x3e7a59)
          emitNet(
            'kay_emote:screenshotTaken',
            _0x48e4f3,
            _0x214214,
            _0xa35e8e,
            false
          )
        }
      }
    }
  )
})
async function createEmptyGif(_0xd482fc) {
  try {
    const _0x35aeef = new GIFEncoder(320, 240)
    !fs.existsSync(gifsDir) && fs.mkdirSync(gifsDir, { recursive: true })
    const _0x538629 = path.join(gifsDir, _0xd482fc + '.gif')
    console.log('Tentative de création du GIF à: ' + _0x538629)
    try {
      fs.writeFileSync(path.join(gifsDir, 'test.txt'), 'Test write')
      fs.unlinkSync(path.join(gifsDir, 'test.txt'))
    } catch (_0x48ed8d) {
      return (
        console.error(
          "ERREUR: Impossible d'écrire dans le dossier GIF: " +
            _0x48ed8d.message
        ),
        false
      )
    }
    const _0x41521d = fs.createWriteStream(_0x538629)
    _0x35aeef.createReadStream().pipe(_0x41521d)
    _0x35aeef.start()
    _0x35aeef.setRepeat(0)
    _0x35aeef.setDelay(100)
    _0x35aeef.setQuality(10)
    const _0x4df85a = new Uint8Array(307200)
    for (let _0x5d0aab = 0; _0x5d0aab < _0x4df85a.length; _0x5d0aab += 4) {
      _0x4df85a[_0x5d0aab] = 100
      _0x4df85a[_0x5d0aab + 1] = 100
      _0x4df85a[_0x5d0aab + 2] = 100
      _0x4df85a[_0x5d0aab + 3] = 255
    }
    _0x35aeef.addFrame(_0x4df85a)
    _0x35aeef.finish()
    if (fs.existsSync(_0x538629)) {
      const _0x9fa430 = fs.statSync(_0x538629)
      return (
        console.log(
          'GIF de secours créé pour l\'émote "' +
            _0xd482fc +
            '" à ' +
            _0x538629 +
            ' (' +
            _0x9fa430.size +
            ' bytes)'
        ),
        true
      )
    } else {
      return (
        console.error("Échec: le fichier GIF n'a pas été créé à " + _0x538629),
        false
      )
    }
  } catch (_0x5e5a3b) {
    return (
      console.error(
        'Erreur détaillée lors de la création du GIF de secours: ' +
          _0x5e5a3b.message
      ),
      console.error(_0x5e5a3b.stack),
      false
    )
  }
}
RegisterCommand(
  'adjustgreenscreen',
  (_0x3c5161, _0x68967a) => {
    if (_0x68967a.length < 3) {
      console.log(
        'Usage: /adjustgreenscreen [minGreen] [greenRedRatio] [greenBlueRatio]'
      )
      return
    }
    const _0x4121d8 = parseInt(_0x68967a[0]),
      _0x17b7f0 = parseFloat(_0x68967a[1]),
      _0x3556a4 = parseFloat(_0x68967a[2])
    updateGreenScreenConfig({
      minGreen: _0x4121d8,
      greenRedRatio: _0x17b7f0,
      greenBlueRatio: _0x3556a4,
    })
    console.log('Paramètres du fond vert mis à jour.')
  },
  true
)
function removeGreenBackground(_0xb61781, _0x30b3f6, _0x5b909c) {
  const _0x1623d4 = new Uint8Array(_0xb61781.length)
  for (let _0x512dc4 = 0; _0x512dc4 < _0xb61781.length; _0x512dc4++) {
    _0x1623d4[_0x512dc4] = _0xb61781[_0x512dc4]
  }
  for (let _0x862e64 = 0; _0x862e64 < _0x5b909c; _0x862e64++) {
    for (let _0x5a3d66 = 0; _0x5a3d66 < _0x30b3f6; _0x5a3d66++) {
      const _0xbf0833 = (_0x862e64 * _0x30b3f6 + _0x5a3d66) * 4,
        _0x551c62 = _0xb61781[_0xbf0833],
        _0x32f492 = _0xb61781[_0xbf0833 + 1],
        _0x15c731 = _0xb61781[_0xbf0833 + 2]
      _0x32f492 > greenScreenConfig.minGreen &&
        _0x32f492 > _0x551c62 * greenScreenConfig.greenRedRatio &&
        _0x32f492 > _0x15c731 * greenScreenConfig.greenBlueRatio &&
        (_0x1623d4[_0xbf0833 + 3] = 0)
    }
  }
  return _0x1623d4
}
async function createGifFromScreenshots(_0x230c54, _0x51d362) {
  try {
    const _0x9309f4 = []
    let _0x31c21a = 0,
      _0x4b5a00 = 0
    for (let _0x2c234d = 0; _0x2c234d < _0x51d362; _0x2c234d++) {
      const _0x4f03e3 = path.join(
        screenshotsDir,
        _0x230c54 + '_' + _0x2c234d + '.png'
      )
      if (fs.existsSync(_0x4f03e3)) {
        try {
          const _0x454e2a = await decodeFromFile(_0x4f03e3)
          _0x9309f4.push(_0x454e2a)
          _0x31c21a = _0x454e2a.width
          _0x4b5a00 = _0x454e2a.height
        } catch (_0x4d53d1) {
          console.error(
            "Erreur lors du décodage de l'image " +
              _0x2c234d +
              ': ' +
              _0x4d53d1.message
          )
        }
      }
    }
    if (_0x9309f4.length === 0) {
      return (
        console.error("Aucune image valide trouvée pour l'émote " + _0x230c54),
        false
      )
    }
    const _0x20a94f = new GIFEncoder(_0x31c21a, _0x4b5a00),
      _0x1e49e7 = path.join(gifsDir, _0x230c54 + '.gif'),
      _0x5adb01 = fs.createWriteStream(_0x1e49e7)
    _0x20a94f.createReadStream().pipe(_0x5adb01)
    _0x20a94f.start()
    _0x20a94f.setRepeat(0)
    _0x20a94f.setDelay(100)
    _0x20a94f.setQuality(10)
    _0x20a94f.setTransparent(65280)
    for (const _0x12634c of _0x9309f4) {
      const _0x37057f = removeGreenBackground(
        _0x12634c.pixels,
        _0x12634c.width,
        _0x12634c.height
      )
      _0x20a94f.addFrame(_0x37057f)
    }
    return (
      _0x20a94f.finish(),
      console.log(
        'GIF créé avec succès pour l\'émote "' + _0x230c54 + '" à ' + _0x1e49e7
      ),
      true
    )
  } catch (_0x3302f7) {
    return (
      console.error('Erreur lors de la création du GIF: ' + _0x3302f7.message),
      false
    )
  }
}
function verifyGifOutput(_0x2947c2) {
  const _0x7731c0 = path.join(gifsDir, _0x2947c2 + '.gif')
  try {
    if (fs.existsSync(_0x7731c0)) {
      const _0x1c5efd = fs.statSync(_0x7731c0).size
      return _0x1c5efd > 1000
        ? (console.log(
            'GIF créé avec succès pour "' +
              _0x2947c2 +
              '" (' +
              _0x1c5efd +
              ' bytes)'
          ),
          true)
        : (console.error(
            'Le GIF généré pour "' +
              _0x2947c2 +
              '" est trop petit (' +
              _0x1c5efd +
              ' bytes)'
          ),
          false)
    } else {
      return false
    }
  } catch (_0x39c88a) {
    return (
      console.error(
        'Erreur lors de la vérification du GIF pour "' +
          _0x2947c2 +
          '": ' +
          _0x39c88a.message
      ),
      false
    )
  }
}
function cleanupTempFiles(_0x1f9f32, _0x2fa9c6) {
  try {
    for (let _0xe1917d = 0; _0xe1917d < _0x2fa9c6; _0xe1917d++) {
      const _0x8f1ab8 = path.join(
        screenshotsDir,
        _0x1f9f32 + '_' + _0xe1917d + '.png'
      )
      fs.existsSync(_0x8f1ab8) && fs.unlinkSync(_0x8f1ab8)
    }
  } catch (_0x466055) {
    console.error(
      'Erreur lors du nettoyage des fichiers temporaires: ' + _0x466055.message
    )
  }
}
RegisterNetEvent('kay_emote:createGif')
onNet('kay_emote:createGif', async (_0x2f7ead, _0x477b0a) => {
  const _0x374db5 = global.source,
    _0x1c0521 = verifyGifOutput(_0x2f7ead)
  if (_0x1c0521) {
    console.log('GIF vérifié et valide pour "' + _0x2f7ead + '"')
  } else {
  }
  try {
    const _0x3c6c4f = path.join(gifsDir, _0x2f7ead + '.gif')
    if (fs.existsSync(_0x3c6c4f)) {
      console.log('Le GIF pour l\'émote "' + _0x2f7ead + '" existe déjà.')
      emitNet('kay_emote:gifCreated', _0x374db5, _0x2f7ead)
      return
    }
    await new Promise((_0x4bdecd) => setTimeout(_0x4bdecd, 2000))
    let _0x512749 = 0
    for (let _0x2098f4 = 0; _0x2098f4 < _0x477b0a; _0x2098f4++) {
      const _0x5a7d8b = path.join(
        screenshotsDir,
        _0x2f7ead + '_' + _0x2098f4 + '.png'
      )
      fs.existsSync(_0x5a7d8b) &&
        fs.statSync(_0x5a7d8b).size > 1000 &&
        _0x512749++
    }
    if (_0x512749 === 0) {
      console.error("Aucune image valide trouvée pour l'émote " + _0x2f7ead)
      const _0x1508b2 = await createEmptyGif(_0x2f7ead)
      emitNet('kay_emote:gifCreated', _0x374db5, _0x2f7ead)
      return
    }
    const _0x10a72b = await createGifFromScreenshots(_0x2f7ead, _0x477b0a)
    if (_0x10a72b) {
      cleanupTempFiles(_0x2f7ead, _0x477b0a)
      emitNet('kay_emote:gifCreated', _0x374db5, _0x2f7ead)
    } else {
      console.error(
        'Échec de la création du GIF pour l\'émote "' + _0x2f7ead + '"'
      )
      const _0x2c2027 = await createEmptyGif(_0x2f7ead)
      emitNet('kay_emote:gifCreated', _0x374db5, _0x2f7ead)
    }
  } catch (_0x213012) {
    console.error('Erreur lors de la création du GIF: ' + _0x213012.message)
    try {
      await createEmptyGif(_0x2f7ead)
    } catch (_0x1cfc0d) {
      console.error(
        'Impossible de créer un GIF de secours: ' + _0x1cfc0d.message
      )
    }
    emitNet('kay_emote:gifCreated', _0x374db5, _0x2f7ead)
  }
})