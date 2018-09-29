local Handcuffed = {}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('revenge-interactionmenu:isHandcuffed', function(source, callback, target)
	local handcuffed = false

	if Handcuffed[target] ~= nil then
		handcuffed = Handcuffed[target]
	end

	callback(handcuffed)
end)

RegisterServerEvent('revenge-interactionmenu:handcuff')
AddEventHandler('revenge-interactionmenu:handcuff', function(source, id, useItem)
	if Handcuffed[id] == nil then
		Handcuffed[id] = false
	end

	if Handcuffed[id] == false then
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer ~= nil then
			local item = xPlayer.getInventoryItem('handcuffs')

			if item.count > 0 or not useItem then
				if useItem then
					xPlayer.removeInventoryItem('handcuffs', 1)
				end
			
				Handcuffed[id] = true

				TriggerClientEvent('revenge-interactionmenu:handcuff', id)
			else
				TriggerClientEvent('esx:showNotification', source, 'You need to get some ~r~handcuffs')
			end
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'This player is already ~r~handcuffed')
	end
end)

RegisterServerEvent('revenge-interactionmenu:uncuff')
AddEventHandler('revenge-interactionmenu:uncuff', function(source, id, useItem)
	if Handcuffed[id] == nil then
		Handcuffed[id] = false
	end

	if Handcuffed[id] == true then
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer ~= nil then
			local item = xPlayer.getInventoryItem('key')

			if item.count > 0 or not useItem then
				if useItem then
					xPlayer.removeInventoryItem('key', 1)
				end

				Handcuffed[id] = false

				TriggerClientEvent('revenge-interactionmenu:uncuff', id)
			else
				TriggerClientEvent('esx:showNotification', source, 'You need the ~r~keys ~w~to remove the ~r~handcuffs')
			end
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'This player is not ~r~handcuffed')
	end
end)

RegisterServerEvent('revenge-interactionmenu:drag')
AddEventHandler('revenge-interactionmenu:drag', function(id, ped)
	if Handcuffed[id] == nil then
		Handcuffed[id] = false
	end

	if Handcuffed[id] == true then
		TriggerClientEvent('revenge-interactionmenu:drag', id, ped)
	else
		TriggerClientEvent('esx:showNotification', source, 'You must ~r~handcuff~w~ this player first')
	end
end)

-- Sätt på/ta av ögonbindel
RegisterServerEvent('jsfour-blindfold')
AddEventHandler('jsfour-blindfold', function( player, hasItem )
  local src = source
  TriggerClientEvent('jsfour-blindfold', player, hasItem, src)
end)

-- Notis skickas om spelaren inte har en ögonbindel
RegisterServerEvent('jsfour-blindfold:notis')
AddEventHandler('jsfour-blindfold:notis', function( src )
  TriggerClientEvent('esx:showNotification', src, 'Du har ingen ögonbindel på dig..')
end)

-- Ger spelaren en ögonbindel
RegisterServerEvent('jsfour-blindfold:giveItem')
AddEventHandler('jsfour-blindfold:giveItem', function( src )
  local xPlayer = ESX.GetPlayerFromId(src)
  xPlayer.addInventoryItem('blindfold', 1)
end)

-- Kollar om spelaren har en ögonbindel
ESX.RegisterServerCallback('jsfour-blindfold:itemCheck', function( src, cb )
  local xPlayer = ESX.GetPlayerFromId(src)
  local item    = xPlayer.getInventoryItem('blindfold').count
  if item > 0 then
    cb(true)
    xPlayer.removeInventoryItem('blindfold', 1)
  else
    cb(false)
  end
end)

ESX.RegisterServerCallback('revenge-interactionmenu:fetchVehicle', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles WHERE owner = @identifier', 
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			local found = false

			for i=1, #result, 1 do
				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate == plate then
					found = true
					
					break
				end
			end

			if found then
				cb(true)
			else
				cb(false)
			end
		end
	)
end)