RegisterNetEvent('ava:openTicket', function(data)
    SendReactMessage('Ticket:SetTicketData', data)
    AddNuiFocus('ticket')
end)

RegisterNUICallback('Ticket:Close', function(data, cb)
    RemoveNuiFocus('ticket')
    cb('ok')
end)

RegisterNUICallback('Ticket:Ended', function(data, cb)
    TriggerServerEvent('fb:ticket:ended')
    cb('ok')
end)