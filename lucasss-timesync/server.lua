Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)

		local time = os.date("*t", os.time())
		
		TriggerClientEvent('revenge-timesync:updateTime', -1, time["hour"], time["min"], time["sec"])
	end
end)