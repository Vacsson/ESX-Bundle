local ready = false
local callbacks = {}

MySQL.ready(function()
	ready = true

	for i=1, #callbacks, 1 do
		callbacks[i]()

		table.remove(callbacks, i)
	end
end)

RegisterServerEvent('mysql-hook:callback')
AddEventHandler('mysql-hook:callback', function(callback)
	if ready then
		callback()
	else
		table.insert(callbacks, callback)
	end
end)