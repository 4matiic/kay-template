-- Je vous conseille de ne pas toucher si vous ne savez pas faire, si vous avez besoin d'un support, rejoignez le serveur discord : https://discord.gg/UZUesn59V2

RegisterCommand(config.openCommand, function(source, args, rawCommand)
    TriggerClientEvent('Kenshi:MenuArme', source)
end, false)
