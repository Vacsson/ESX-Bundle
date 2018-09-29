ESX = nil

TriggerEvent('esx:getSharedObject', function(object)
	ESX = object
end)

ESX.RegisterServerCallback('revenge-apartments:makePayment', function(source, callback, amount)
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

ESX.RegisterServerCallback('revenge-apartments:getInventory', function(source, callback)
  	local player = ESX.GetPlayerFromId(source)

  	if player ~= nil then
	  	callback(player.inventory)
	end
end)

ESX.RegisterServerCallback('revenge-apartments:addItem', function(source, callback, item, amount)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		player.addInventoryItem(item, amount)
	end

	callback()
end)

ESX.RegisterServerCallback('revenge-apartments:addWeapon', function(source, callback, weapon, ammo, amount)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		for i=1, amount, 1 do
			player.addWeapon(weapon, ammo)
		end
	end

	callback()
end)

ESX.RegisterServerCallback('revenge-apartments:removeItem', function(source, callback, item, amount)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		player.removeInventoryItem(item, amount)
	end

	callback()
end)

ESX.RegisterServerCallback('revenge-apartments:removeWeapon', function(source, callback, weapon)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		player.removeWeapon(weapon)
	end

	callback()
end)

ESX.RegisterServerCallback('revenge-apartments:getDirtyMoney', function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		callback(player.getAccount('black_money').money)
	else
		callback(0)
	end
end)

ESX.RegisterServerCallback('revenge-apartments:setDirtyMoney', function(source, callback, money)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		player.setAccountMoney('black_money', money)
	end

	callback()
end)

ESX.RegisterServerCallback('revenge-apartments:addDirtyMoney', function(source, callback, money)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		player.addAccountMoney('black_money', money)
	end

	callback()
end)

ESX.RegisterServerCallback('revenge-apartments:hasItem', function(source, callback, item, amount)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		if player.getInventoryItem(item).count >= amount then
			callback(true)
		else
			callback(false)
		end
	end
end)