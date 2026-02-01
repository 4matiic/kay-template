local players = {}
local totalSumChance = 0

CreateThread(function()
  for _,priceInfo in pairs(Config.Prices) do
    totalSumChance = totalSumChance + priceInfo['chance']
  end 
end)

ESX.RegisterUsableItem('scratch_ticket', function(source)
  TriggerClientEvent("dr-scratching:isActiveCooldown", source)
end)

RegisterNetEvent("dr-scratching:handler", function(returncooldown, cooldown)
  local _source <const> = source
  local tempsrc <const> = tonumber(_source)
  local playerName, playerIdentifier = GetPlayerName(_source), GetPlayerIdentifier(_source, 0)
  local xPlayer <const> = ESX.GetPlayerFromId(_source)
  local count <const> = xPlayer.getInventoryItem('scratch_ticket').count
  local randomNumber <const> = math.random(1, totalSumChance)
  local add = 0

  if returncooldown then
    if Config.ShowCooldownNotifications then
      xPlayer.showNotification(_U('active_cooldown', cooldown), false, false)
    end
    return
  end

  if count >= 1 then
    xPlayer.removeInventoryItem('scratch_ticket', 1)
    TriggerClientEvent("dr-scratching:setCooldown", _source)
  else
    sendWebhook(playerName, playerIdentifier, "important", "Player triggered event without having said scratching ticket")
    return
  end

  TriggerClientEvent("dr-scratching:startScratchingEmote", _source)

  for key, priceInfo in pairs(Config.Prices) do
    local chance = priceInfo['chance']
    if randomNumber > add and randomNumber <= add + chance then
      local price_is_item = priceInfo['price']['item']['price_is_item']
      local amount = priceInfo['price']['item']['item_amount']
      local price_type, price = nil

      if not price_is_item then
        price = priceInfo['price']['price_money']
        price_type = 'money'
      else 
        price = priceInfo['price']['item']['item_label']
        price_type = 'item'
      end

      -- Vérifier si le prix est valide (évite un gain de 0)
      if not price or (price_type == 'money' and tonumber(price) <= 0) then
        DebugPrint(("%s (%s) n'a rien gagné."):format(playerName, playerIdentifier))
        if key ~= "loose" then
          TriggerClientEvent("dr-scratching:nuiOpenCard", _source, key, price, amount, price_type)
          end      
        return
      end

      players[tempsrc] = tostring(price)
      TriggerClientEvent("dr-scratching:nuiOpenCard", _source, key, price, amount, price_type)
      return price
    end
    add = add + chance
  end
end)

RegisterNetEvent("dr-scratching:deposit", function(key, price, amount, type)
  local _source = source
  local playerName, playerIdentifier = GetPlayerName(_source), GetPlayerIdentifier(_source, 0)
  local xPlayer = ESX.GetPlayerFromId(_source)
  local tempsrc = tonumber(_source)
  local giveItem = false
  local giveMoney = false
  local priceAmount = nil

  -- Vérification anti-triche : le prix doit être valide
  if not price or (type == 'money' and tonumber(price) <= 0) then
    DebugPrint(("%s (%s) a tenté de recevoir un gain invalide. Annulation."):format(playerName, playerIdentifier))
    players[tempsrc] = nil
    return
  end

  if players[tempsrc] ~= tostring(price) then
    sendWebhook(playerName, playerIdentifier, "important", "Player triggered event with a non matching price assigned to name. Assigned price: " .. players[tempsrc] .. " Requested price: " .. tostring(price) .. ". Possible unauthorized event trigger")
    print(("%s (%s) somehow managed to trigger the deposit event with a non-matching price. Possible cheating attempt."):format(playerName, playerIdentifier))
    players[tempsrc] = nil
    return
  end

  if type == 'money' then
    giveMoney = true
  else
    giveItem = true
  end

  for priceKey, priceInfo in pairs(Config.Prices) do
    if priceKey == key then
      priceAmount = priceInfo["price"]["item"]["item_amount"]
      if Config.ShowResultTicketNotification then
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('lottery_name'), _U('lottery_subject'), priceInfo['message'], 'CHAR_BANK_BOL', 9)
      end

      if type == 'item' and giveItem then
        if tonumber(amount) == priceAmount then
          local price = priceInfo["price"]["item"]["item_name"]
          DebugPrint(("Successfully added prize (item: %sx %s) to %s (%s)"):format(priceAmount, price, playerName, playerIdentifier))
          xPlayer.addInventoryItem(price, priceAmount)
        else
          sendWebhook(playerName, playerIdentifier, "important", "Player managed to trigger deposit event with a non-matching item. Possible unauthorized event trigger")
          print(("%s (%s) somehow managed to trigger the deposit event with a non-matching item. Possible cheating attempt."):format(playerName, playerIdentifier))
          players[tempsrc] = nil
          return
        end
      elseif type == 'money' and giveMoney then
        if tonumber(amount) == priceAmount then
          DebugPrint(("Successfully added prize (money: %s) to %s (%s)"):format(price, playerName, playerIdentifier))
          xPlayer.addMoney(price)
        else
          sendWebhook(playerName, playerIdentifier, "important", "Player managed to trigger deposit event with a non-matching money amount. Possible unauthorized event trigger")
          print(("%s (%s) somehow managed to trigger the deposit event with a non-matching amount. Possible cheating attempt."):format(playerName, playerIdentifier))
          players[tempsrc] = nil
          return
        end
      end
    end
  end

  sendWebhook(playerName, playerIdentifier, type, price, priceAmount)
  players[tempsrc] = nil
  return
end)


RegisterNetEvent("dr-scratching:stopScratching", function(price, amount, type)
  local _source = source
  local playerName, playerIdentifier = GetPlayerName(_source), GetPlayerIdentifier(_source, 0)
  local tempsrc = tonumber(_source)

  sendWebhook(playerName, playerIdentifier, type, price, amount, "early")
  players[tempsrc] = nil
  return
end)