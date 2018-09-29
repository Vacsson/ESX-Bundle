local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local CachedGarages = {}
local Garages = {
	[1] = {
		coords = {["x"] = 231.94430541992, ["y"] = -793.65283203125, ["z"] = 29.586387634277, ["heading"] = 160.43000793457},
		deletor = {["x"] = 216.51968383789, ["y"] = -787.7265625, ["z"] = 29.819911956787},
		price = 10000
	}
}

local lastBlips = {}
local impound = {x = 485.62704467773, y = -1307.0701904297, z = 28.261890411377, heading = 220.0}

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(0)

		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
	end

	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(100)
	end

	CacheGarages(function()
		DisplayMarkers(true)

		local blip = AddBlipForCoord(impound.x, impound.y, impound.z)

		SetBlipSprite(blip, 67)
		SetBlipDisplay(blip, 4)
		SetBlipColour(blip, 6)
		SetBlipAsShortRange(blip, true)

	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentString('Impound')
		EndTextCommandSetBlipName(blip)
		
		Markers.AddMarker('garage_impound', impound, 'Press ~INPUT_CONTEXT~ to get your vehicle for ~b~$5,000', function()
			TriggerEvent('revenge-garage:fetchImpoundedVehicles', function(vehicles)
				local elements = {}

				for i=1, #vehicles, 1 do
					local vehicle = vehicles[i]
					local message = GetDisplayNameFromVehicleModel(vehicle.model)	

					table.insert(elements, {value = vehicle.model, label = message, plate = vehicle.plate, properties = vehicle.properties, impounded = vehicle.impounded})
				end

				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_impound_menu',
					{
						title = 'Impounded Vehicles',
						align = 'top-left',
						elements = elements
					},
					function(data, menu)
						menu.close()

						ESX.TriggerServerCallback('revenge-garage:makePayment', function(success)
							if success then
								ESX.Game.SpawnVehicle(data.current.value, impound, impound.heading, function(callbackVehicle)
									ESX.Game.SetVehicleProperties(callbackVehicle, data.current.properties)

									TriggerEvent('revenge-garage:unimpound', data.current.properties.plate, data.current.properties.model)

									TaskWarpPedIntoVehicle(GetPlayerPed(-1), callbackVehicle, -1)				
								end)
							else
								ESX.ShowNotification('~r~You do not have enough money.')
							end
						end, 5000)
					end,
					function(data, menu)
						menu.close()
					end
				)
			end)
		end)
	end)
end)

function DisplayMarkers(cache)
	for i=1, #lastBlips, 1 do
		RemoveBlip(lastBlips[i])
	end

	Markers.RemoveAll()

	for k,v in orderedPairs(Garages) do
		if CachedGarages[k] == true then
			local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)

			SetBlipSprite(blip, 50)
			SetBlipDisplay(blip, 4)
			SetBlipColour(blip, 38)
			SetBlipAsShortRange(blip, true)

		    BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString('Garage (2 Vehicles)')
			EndTextCommandSetBlipName(blip)

			table.insert(lastBlips, blip)

			Markers.AddMarker('garage_' .. k, v.coords, 'Press ~INPUT_CONTEXT~ to spawn a vehicle', function()
				TriggerEvent('revenge-garage:fetchVehicles', function(vehicles)
					local index = 1
					local elements = {}

					for i=1, #vehicles, 1 do
						local vehicle = vehicles[i]

						if index <= 2 then
							local message = GetDisplayNameFromVehicleModel(vehicle.model)

							if vehicle.impounded then
								message = message .. ' | Impounded'
							else
								message = message .. ' | In Garage'
							end				

							table.insert(elements, {value = vehicle.model, label = message, plate = vehicle.plate, properties = vehicle.properties, impounded = vehicle.impounded})
						
							index = index + 1
						end
					end

					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_menu', 
						{
							title = 'Vehicles',
							align = 'top-left',
							elements = elements
						},
						function(data, menu)
							menu.close()

							if data.current.impounded == true then
								ESX.ShowNotification('Your vehicle ' .. GetDisplayNameFromVehicleModel(data.current.value) .. ' (' .. data.current.plate .. ') is in impound.')
							else
								ESX.Game.SpawnVehicle(data.current.value, v.coords, v.coords.heading, function(callbackVehicle)
									ESX.Game.SetVehicleProperties(callbackVehicle, data.current.properties)

									TriggerEvent('revenge-garage:impound', data.current.properties.plate, data.current.properties.model)

									TaskWarpPedIntoVehicle(GetPlayerPed(-1), callbackVehicle, -1)				
								end)
							end
						end,
						function(data, menu)
							menu.close()
						end
					)
				end)
			end)

			Markers.AddMarker('garage_' .. k, v.deletor, 'Press ~INPUT_CONTEXT~ to park the vehicle', function()
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))

				if vehicle ~= nil then
					TriggerEvent('revenge-garage:fetchMetadata', vehicle, function(metadata)
						if metadata.owned then
							local properties = ESX.Game.GetVehicleProperties(vehicle)

							TriggerEvent('revenge-garage:unimpound', properties.plate, properties.model)
							TriggerEvent('revenge-garage:update', vehicle)

							ESX.Game.DeleteVehicle(vehicle)
						else
							ESX.ShowNotification('~r~This vehicle is not yours')
						end
					end)
				end
			end)
		else
			local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)

			SetBlipSprite(blip, 375)
			SetBlipDisplay(blip, 4)
			SetBlipColour(blip, 4)
			SetBlipAsShortRange(blip, true)

		    BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString('Garage (2 Vehicles)')
			EndTextCommandSetBlipName(blip)

			table.insert(lastBlips, blip)

			Markers.AddMarker('garage_' .. k, v.coords, 'Press ~INPUT_CONTEXT~ to purchase the garage for ~b~$' .. v.price .. ' (Only 2 Vehicles)', function()
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirmation_menu',
					{
						title = 'Are you sure?',
						align = 'top-left',
						elements = {
							{label = 'Yes ($' .. v.price .. ')', value = 'yes'},
							{label = 'No', value = 'no'}
						}
					},
					function(data, menu)
						menu.close()

						ESX.TriggerServerCallback('revenge-garage:makePayment', function(success)
							if success then
								CachedGarages[k] = true

								MySQL.execute('INSERT INTO garages (identifier, id) VALUES (@identifier, @id)',
									{
										["@identifier"] = Identifier(),
										["@id"] = k
									}
								)

								Notifications.PlaySpecialNotification('Purchased garage for $' .. v.price)

								DisplayMarkers()
							else
								ESX.ShowNotification('~r~You do not have enough money.')
							end
						end, v.price)
					end,
					function(data, menu)
						menu.close()
					end
				)
			end)
		end
	end
end

RegisterNetEvent('revenge-garage:fetchGarageLimit')
AddEventHandler('revenge-garage:fetchGarageLimit', function(callback)
	local found = false

	for k,v in orderedPairs(Garages) do
		if CachedGarages[k] == true then
			callback(2)

			found = true

			break
		end
	end

	if not found then
		callback(0)
	end
end)

RegisterNetEvent('revenge-garage:update')
AddEventHandler('revenge-garage:update', function(vehicle)
	local properties = ESX.Game.GetVehicleProperties(vehicle)
	
	MySQL.execute('UPDATE user_vehicles SET properties=@properties WHERE identifier=@identifier AND plate=@plate AND model=@model',
		{
			["@properties"] = json.encode(properties),
			["@identifier"] = Identifier(),
			["@plate"] = properties.plate,
			["@model"] = properties.model
		}
	)
end)

RegisterNetEvent('revenge-garage:impound')
AddEventHandler('revenge-garage:impound', function(plate, model)
	MySQL.execute('UPDATE user_vehicles SET impounded=@impounded WHERE identifier=@identifier AND plate=@plate AND model=@model',
		{
			["@impounded"] = 1,
			["@identifier"] = Identifier(),
			["@plate"] = plate,
			["@model"] = model
		}
	)
end)

RegisterNetEvent('revenge-garage:unimpound')
AddEventHandler('revenge-garage:unimpound', function(plate, model)
	MySQL.execute('UPDATE user_vehicles SET impounded=@impounded WHERE identifier=@identifier AND plate=@plate AND model=@model',
		{
			["@impounded"] = 0,
			["@identifier"] = Identifier(),
			["@plate"] = plate,
			["@model"] = model
		}
	)
end)

RegisterNetEvent('revenge-garage:fetchVehicles')
AddEventHandler('revenge-garage:fetchVehicles', function(callback)
	MySQL.fetchAll('SELECT * FROM user_vehicles WHERE identifier=@identifier',
		{
			["@identifier"] = Identifier()
		},
		function(fetched)
			if fetched ~= nil and fetched[1] ~= nil then
				local vehicles = {}

				for i=1, #fetched, 1 do
					local row = fetched[i]

					table.insert(vehicles, {plate = row.plate, model = tonumber(row.model), impounded = row.impounded, properties = json.decode(row.properties)})
				end

				callback(vehicles)
			else
				callback({})
			end
		end
 	)
end)

RegisterNetEvent('revenge-garage:fetchImpoundedVehicles')
AddEventHandler('revenge-garage:fetchImpoundedVehicles', function(callback)
	MySQL.fetchAll('SELECT * FROM user_vehicles WHERE identifier=@identifier AND impounded=@impounded',
		{
			["@identifier"] = Identifier(),
			["@impounded"] = 1
		},
		function(fetched)
			if fetched ~= nil and fetched[1] ~= nil then
				local vehicles = {}

				for i=1, #fetched, 1 do
					local row = fetched[i]

					table.insert(vehicles, {plate = row.plate, model = tonumber(row.model), impounded = row.impounded, properties = json.decode(row.properties)})
				end

				callback(vehicles)
			else
				callback({})
			end
		end
 	)
end)

RegisterNetEvent('revenge-garage:fetchMetadata')
AddEventHandler('revenge-garage:fetchMetadata', function(vehicle, callback)
	if vehicle ~= nil then
		if DoesEntityExist(vehicle) then
			local properties = ESX.Game.GetVehicleProperties(vehicle)

			MySQL.fetchAll('SELECT * FROM user_vehicles WHERE identifier=@identifier AND plate=@plate AND model=@model',
				{
					["@identifier"] = Identifier(),
					["@plate"] = properties.plate,
					["@model"] = properties.model
				},
				function(fetched)
					if fetched ~= nil and fetched[1] ~= nil then
						if fetched[1].properties ~= nil and fetched[1].impounded ~= nil then
							callback({vehicle = vehicle, properties = json.decode(fetched[1].properties), owned = true, impounded = fetched[1].impounded})
						else
							callback({vehicle = vehicle, properties = {}, owned = false, impounded = false})
						end
					else
						callback({vehicle = vehicle, properties = {}, owned = false, impounded = false})
					end
				end
			)
		else
			callback({vehicle = vehicle, properties = {}, owned = false, impounded = false})
		end
	else
		callback({vehicle = vehicle, properties = {}, owned = false, impounded = false})
	end
end)

RegisterNetEvent('revenge-garage:contract')
AddEventHandler('revenge-garage:contract', function(plate, model, properties)
	MySQL.execute('INSERT INTO user_vehicles (identifier, plate, model, properties, impounded) VALUES (@identifier, @plate, @model, @properties, 0)',
		{
			["@identifier"] = Identifier(),
			["@plate"] = plate,
			["@model"] = model,
			["@properties"] = json.encode(properties)
		}
	)
end)

RegisterNetEvent('revenge-garage:uncontract')
AddEventHandler('revenge-garage:uncontract', function(vehicle)
	if vehicle ~= nil then
		if DoesEntityExist(vehicle) then
			local properties = ESX.Game.GetVehicleProperties(vehicle)

			MySQL.execute('DELETE FROM user_vehicles WHERE identifier=@identifier AND plate=@plate AND model=@model',
				{
					["@identifier"] = Identifier(),
					["@plate"] = properties.plate,
					["@model"] = properties.model
				}
			)
		end
	end
end)

RegisterNetEvent('revenge-garage:lookup')
AddEventHandler('revenge-garage:lookup', function(properties, callback)
	MySQL.fetchAll('SELECT * FROM user_vehicles WHERE plate=@plate and model=@model',
		{
			["@plate"] = properties.plate,
			["@model"] = properties.model
		},
		function(fetched) 
			if fetched ~= nil and fetched[1] ~= nil then
				MySQL.fetchAll('SELECT * FROM users WHERE identifier=@identifier',
		            {
		              ['@identifier'] = fetched[1].identifier
		            },
		            function(result)
						callback({owner = result[1].firstname .. ' ' .. result[1].lastname, plate = properties.plate})
		            end
		        )
			else
				callback({owner = 'Unknown (Not registered)', plate = properties.plate})
			end
		end
	)
end)

function Identifier()
	return ESX.GetPlayerData().identifier
end

function CacheGarages(callback)
	MySQL.fetchAll('SELECT * FROM garages WHERE identifier = @identifier', 
	{
		["@identifier"] = Identifier(),
	}, 
	function(fetched)
		if fetched ~= nil then
			for i=1, #fetched, 1 do
				local row = fetched[i]

				CachedGarages[row.id] = true
			end

			callback()
		end
	end)

	for k,v in pairs(Garages) do
		if CachedGarages[k] == nil then
			CachedGarages[k] = false
		end
	end
end