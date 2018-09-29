ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj 
end)

RegisterServerEvent('revenge-hunting:harvestReward')
AddEventHandler('revenge-hunting:harvestReward', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		xPlayer.addInventoryItem('raw_meat', math.random(1, 2))
	end
end)

ESX.RegisterServerCallback('revenge-hunting:sellMeat', function(source, callback)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		local item = xPlayer.getInventoryItem('raw_meat')

		if item.count > 0 then
			xPlayer.setMoney(xPlayer.getMoney() + (item.count * 190))
			xPlayer.removeInventoryItem('raw_meat', item.count)

			callback(item.count * 190)
		end
	end
end)

RegisterServerEvent('revenge-hunting:giveWeapon')
AddEventHandler('revenge-hunting:giveWeapon', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		xPlayer.addWeapon('WEAPON_MUSKET', 250)
	end
end)

RegisterServerEvent('revenge-hunting:removeWeapon')
AddEventHandler('revenge-hunting:removeWeapon', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		xPlayer.removeWeapon('WEAPON_MUSKET')
	end
end)