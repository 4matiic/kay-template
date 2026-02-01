local L0_1, L1_1, L2_1
L0_1 = RegisterServerEvent
L1_1 = "kay_emote_gifmaker:setWeather"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "kay_emote_gifmaker:setWeather"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = source
  L4_2 = TriggerClientEvent
  L5_2 = "kay_emote_gifmaker:setWeather"
  L6_2 = L3_2
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = A2_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "kay_emote_gifmaker:resetWeather"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "kay_emote_gifmaker:resetWeather"
function L2_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = source
  L1_2 = TriggerEvent
  L2_2 = "vSync:requestSync"
  L1_2(L2_2)
  L1_2 = TriggerClientEvent
  L2_2 = "kay_emote_gifmaker:resetWeather"
  L3_2 = L0_2
  L1_2(L2_2, L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "kay_emote_gifmaker:syncProps"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "kay_emote_gifmaker:syncProps"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = source
  L2_2 = TriggerClientEvent
  L3_2 = "kay_emote_gifmaker:syncProps"
  L4_2 = -1
  L5_2 = L1_2
  L6_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "kay_emote:gifCreated"
L0_1(L1_1)
