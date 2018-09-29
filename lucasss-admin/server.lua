RegisterServerEvent('revenge-admin:logMessage')
AddEventHandler('revenge-admin:logMessage', function(message)
	print(message)
end)

TriggerEvent('es:addGroupCommand', 'coords', 'admin', function(source, args, user)
  TriggerClientEvent("revenge-admin:coordinates", source)
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Get the coordinates you're at."})

TriggerEvent('es:addGroupCommand', 'clothes', 'admin', function(source, args, user)
  TriggerClientEvent("revenge-admin:clothes", source)
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = 'Get the clothes you currently have on.'})

function string.startsWith(string, value)
   return string.sub(string, 1, string.len(value)) == value
end