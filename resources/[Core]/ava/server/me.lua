local Languages = {
  ['fr'] = {
      commandName = 'me',
      commandDescription = 'Affiche une action au dessus de votre tête.',
      commandSuggestion = {{ name = 'action', help = '"se gratte le nez" par exemple.'}},
      prefix = 'La personne ' -- Préfixe ajouté avant le message
  },
}

local function onMeCommand(source, args)
  local xPlayer = ESX.GetPlayerFromId(source)
  local text = "* " .. Languages['fr'].prefix .. table.concat(args, " ") .. " *" -- Ajout du préfixe "La personne"

  -- Vérifie les abus liés à l'injection de code HTML
  if string.find(text, "<img src") then
      xPlayer.ban(0, '(/me usebug)')
      return
  end

  -- Diffuse le texte à tous les joueurs
  TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end

-- Enregistrement de la commande /me
RegisterCommand(Languages['fr'].commandName, onMeCommand)

