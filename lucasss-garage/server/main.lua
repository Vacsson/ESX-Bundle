ESX = nil

TriggerEvent('esx:getSharedObject', function(object)
	ESX = object
end)

ESX.RegisterServerCallback('revenge-garage:makePayment', function(source, callback, amount)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		local bank = player.getAccount('bank')

		if bank.money >= amount then
			player.removeAccountMoney('bank', amount)

			callback(true)
		else
			callback(false)
		end
	end
end)