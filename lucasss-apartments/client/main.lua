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

local CachedApartments = {}
local Apartments = {
	[1] = {
		label = 'Eclipse Towers',
		ipl = 'apa_v_mp_h_04_a',
		enter = {x = -773.90283203125, y = 311.78427124023, z = 84.698127746582},
		inside = {x = -786.6245, y = 315.6175, z = 217.6385},
		exit = {x = -786.25238037109, y = 315.78594970703, z = 216.63836669922},
		garage = {x = -796.16613769531, y = 308.7936706543, z = 84.704811096191, heading = 180.0},
		upgrade = {x = -784.31475830078, y = 336.07772827148, z = 215.83851623535},
		closet = {x = -797.77941894531, y = 327.81460571289, z = 219.43841552734},
		storage = {x = -796.64031982422, y = 326.56713867188, z = 216.03796386719},
		camera = {x = -792.74230957031, y = 342.35208129883, z = 218.85107421875, rotationX = 0.0, rotationY = 0.0, rotationZ = 200.0},
		price = 750000,
		garages = {
			[2] = {x = 178.89604187012, y = -1005.4610595703, z = -99.999938964844, heading = 120.0, cameraX = 173.81594848633, cameraY = -1008.4037475586, cameraZ = -99.999954223633, cost = 15000, vehicles = {
				{x = 171.46260070801, y = -1002.9697875977, z = -99.999938964844, heading = 180.0},
				{x = 175.54071044922, y = -1002.9197387695, z = -99.999938964844, heading = 180.0}
			}, exit = {x = 173.23643493652, y = -1006.2785644531, z = -99.999938964844}},
			[4] = {x = 207.05030822754, y = -999.07135009766, z = -99.999938964844, heading = 80.0, cameraX = 198.55581665039, cameraY = -1006.4904785156, cameraZ = -100.00000762939, cost = 30000, vehicles = {
				{x = 203.58419494629, y = -997.05769042969, z = -99.999908447266, heading = 180.0},
				{x = 198.32850646973, y = -997.07373046875, z = -99.999923706055, heading = 180.0},
				{x = 193.36447143555, y = -997.03424072266, z = -99.999938964844, heading = 180.0},
				{x = 194.26737976074, y = -1005.2864990234, z = -99.999908447266, heading = 270.0}
			}, exit = {x = 200.21136474609, y = -1004.9016113281, z = -100.00002288818}},
			[6] = {x = 237.65251159668, y = -1004.9808349609, z = -99.999870300293, heading = 95.0, cameraX = 228.42738342285, cameraY = -1001.7737426758, cameraZ = -99.999954223633, cost = 100000, vehicles = {
				{x = 224.15766906738, y = -980.05633544922, z = -99.999870300293, heading = 240.0},
				{x = 224.40971374512, y = -986.24255371094, z = -99.999870300293, heading = 240.0},
				{x = 224.08374023438, y = -994.90966796875, z = -99.999961853027, heading = 240.0},
				{x = 232.53198242188, y = -998.89013671875, z = -99.999870300293, heading = 110.0},
				{x = 232.32531738281, y = -993.56842041016, z = -99.999877929688, heading = 110.0},
				{x = 232.2276763916, y = -985.65606689453, z = -99.999969482422, heading = 110.0}
			}, exit = {x = 227.7095489502, y = -1001.8063964844, z = -99.999870300293}}
		},
		designs = {
			["Modern"] = {ipl = 'apa_v_mp_h_01_a', cost = 30000},
			["Moody"] = {ipl = 'apa_v_mp_h_02_a', cost = 30000},
			["Vibrant"] = {ipl = 'apa_v_mp_h_03_a', cost = 30000},
			["Sharp"] = {ipl = 'apa_v_mp_h_04_a', cost = 30000},
			["Monochrome"] = {ipl = 'apa_v_mp_h_05_a', cost = 30000},
			["Seductive"] = {ipl = 'apa_v_mp_h_06_a', cost = 30000},
			["Regal"] = {ipl = 'apa_v_mp_h_07_a', cost = 30000},
			["Aqua"] = {ipl = 'apa_v_mp_h_08_a', cost = 30000}
		}
	},
	[2] = {
		label = 'Richard Majestic',
		enter = {x = -937.41198730469, y = -379.55880737305, z = 37.961345672607},
		inside = {x = -913.49334716797, y = -365.3835144043, z = 113.27473449707},
		exit = {x = -913.49334716797, y = -365.3835144043, z = 113.27473449707},
		garage = {x = -893.81079101563, y = -350.07525634766, z = 33.534229278564, heading = 30.0},
		upgrade = {x = -907.85400390625, y = -381.27301025391, z = 112.47463226318},
		closet = {x = -903.87280273438, y = -363.51947021484, z = 112.07409667969},
		storage = {x = -929.01184082031, y = -378.97317504883, z = 112.67405700684},
		price = 300000,
		garages = {
			[2] = {x = 178.89604187012, y = -1005.4610595703, z = -99.999938964844, heading = 120.0, cameraX = 173.81594848633, cameraY = -1008.4037475586, cameraZ = -99.999954223633, cost = 15000, vehicles = {
				{x = 171.46260070801, y = -1002.9697875977, z = -99.999938964844, heading = 180.0},
				{x = 175.54071044922, y = -1002.9197387695, z = -99.999938964844, heading = 180.0}
			}, exit = {x = 173.23643493652, y = -1006.2785644531, z = -99.999938964844}},
			[4] = {x = 207.05030822754, y = -999.07135009766, z = -99.999938964844, heading = 80.0, cameraX = 198.55581665039, cameraY = -1006.4904785156, cameraZ = -100.00000762939, cost = 30000, vehicles = {
				{x = 203.58419494629, y = -997.05769042969, z = -99.999908447266, heading = 180.0},
				{x = 198.32850646973, y = -997.07373046875, z = -99.999923706055, heading = 180.0},
				{x = 193.36447143555, y = -997.03424072266, z = -99.999938964844, heading = 180.0},
				{x = 194.26737976074, y = -1005.2864990234, z = -99.999908447266, heading = 270.0}
			}, exit = {x = 200.21136474609, y = -1004.9016113281, z = -100.00002288818}},
			[6] = {x = 237.65251159668, y = -1004.9808349609, z = -99.999870300293, heading = 95.0, cameraX = 228.42738342285, cameraY = -1001.7737426758, cameraZ = -99.999954223633, cost = 100000, vehicles = {
				{x = 224.15766906738, y = -980.05633544922, z = -99.999870300293, heading = 240.0},
				{x = 224.40971374512, y = -986.24255371094, z = -99.999870300293, heading = 240.0},
				{x = 224.08374023438, y = -994.90966796875, z = -99.999961853027, heading = 240.0},
				{x = 232.53198242188, y = -998.89013671875, z = -99.999870300293, heading = 110.0},
				{x = 232.32531738281, y = -993.56842041016, z = -99.999877929688, heading = 110.0},
				{x = 232.2276763916, y = -985.65606689453, z = -99.999969482422, heading = 110.0}
			}, exit = {x = 227.7095489502, y = -1001.8063964844, z = -99.999870300293}}
		}
	},
	[3] = {
		label = 'Dell Perro Heights',
		enter = {x = -1442.6811523438, y = -545.505859375, z = 33.741817474365},
		inside = {x = -1451.9029541016, y = -523.36627197266, z = 68.556655883789},
		exit = {x = -1451.9029541016, y = -523.36627197266, z = 68.556655883789},
		garage =  {x = -1458.7244873047, y = -499.23208618164, z = 31.567230224609, garage = 330.0},
		upgrade = {x = -1478.8909912109, y = -534.24334716797, z = 67.153968811035},
		closet = {x = -1467.0600585938, y = -537.01544189453, z = 62.360134124756},
		storage = {x = -1455.6127929688, y = -531.04541015625, z = 68.562744140625},
		price = 300000,
		garages = {
			[2] = {x = 178.89604187012, y = -1005.4610595703, z = -99.999938964844, heading = 120.0, cameraX = 173.81594848633, cameraY = -1008.4037475586, cameraZ = -99.999954223633, cost = 15000, vehicles = {
				{x = 171.46260070801, y = -1002.9697875977, z = -99.999938964844, heading = 180.0},
				{x = 175.54071044922, y = -1002.9197387695, z = -99.999938964844, heading = 180.0}
			}, exit = {x = 173.23643493652, y = -1006.2785644531, z = -99.999938964844}},
			[4] = {x = 207.05030822754, y = -999.07135009766, z = -99.999938964844, heading = 80.0, cameraX = 198.55581665039, cameraY = -1006.4904785156, cameraZ = -100.00000762939, cost = 30000, vehicles = {
				{x = 203.58419494629, y = -997.05769042969, z = -99.999908447266, heading = 180.0},
				{x = 198.32850646973, y = -997.07373046875, z = -99.999923706055, heading = 180.0},
				{x = 193.36447143555, y = -997.03424072266, z = -99.999938964844, heading = 180.0},
				{x = 194.26737976074, y = -1005.2864990234, z = -99.999908447266, heading = 270.0}
			}, exit = {x = 200.21136474609, y = -1004.9016113281, z = -100.00002288818}},
			[6] = {x = 237.65251159668, y = -1004.9808349609, z = -99.999870300293, heading = 95.0, cameraX = 228.42738342285, cameraY = -1001.7737426758, cameraZ = -99.999954223633, cost = 100000, vehicles = {
				{x = 224.15766906738, y = -980.05633544922, z = -99.999870300293, heading = 240.0},
				{x = 224.40971374512, y = -986.24255371094, z = -99.999870300293, heading = 240.0},
				{x = 224.08374023438, y = -994.90966796875, z = -99.999961853027, heading = 240.0},
				{x = 232.53198242188, y = -998.89013671875, z = -99.999870300293, heading = 110.0},
				{x = 232.32531738281, y = -993.56842041016, z = -99.999877929688, heading = 110.0},
				{x = 232.2276763916, y = -985.65606689453, z = -99.999969482422, heading = 110.0}
			}, exit = {x = 227.7095489502, y = -1001.8063964844, z = -99.999870300293}}
		}
	}
}

local cam = nil
local hidden = {}
local drugs = {
	"weed_pooch",
	"coke_pooch",
	"meth_pooch",
	"weed_seed",
	"coke_ingredients",
	"meth_ingredients"
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
		
		Citizen.Wait(0)
	end

	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(100)
	end

	CacheApartments(function()
		for k,v in pairs(Apartments) do
			local owns = HasApartment(k)
			local enterMessage = 'Press ~INPUT_CONTEXT~ to enter the apartment'

			if not owns then
				enterMessage = 'Press ~INPUT_CONTEXT~ to visit the apartment'
			end

			Markers.AddMarker('apartment_' .. k, v.enter, enterMessage, function()
				OpenApartmentMenu(k, owns)
			end)

			if v.garage ~= nil and GetGarage(k) > 0 then
				Markers.RemoveMarker('apartment_park_' .. k)
				Markers.AddMarker('apartment_park_' .. k, v.garage, 'Press ~INPUT_CONTEXT~ to park your vehicle', function()
					StoreVehicleInGarage(k)
				end, nil, nil, nil, true)
			end

			if v.enter ~= nil then
				local coords = v.enter
				local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

				SetBlipSprite(blip, 357)
				SetBlipDisplay(blip, 4)
				SetBlipColour(blip, 15)
				SetBlipAsShortRange(blip, true)

			    BeginTextCommandSetBlipName("STRING")
			    AddTextComponentString('Apartment')
	    		EndTextCommandSetBlipName(blip)
			end
		end

		TriggerServerEvent('revenge-apartments:playerLoaded', GetPlayerServerId(PlayerId()))
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		for i=1, #hidden, 1 do
			local ped = GetPlayerPed(hidden[i])

			SetEntityLocallyInvisible(ped)
			SetEntityNoCollisionEntity(GetPlayerPed(-1), ped, true)
		end
	end
end)

function Session(data, ...)
	TriggerServerEvent('revenge-apartments:session:' .. data, GetPlayerServerId(PlayerId()), ...)
end

RegisterNetEvent('revenge-apartments:fetchGarageLimit')
AddEventHandler('revenge-apartments:fetchGarageLimit', function(callback)
	local maximum = 0

	for k,v in orderedPairs(Apartments) do
		if HasApartment(k) == true then
			if maximum < GetGarage(k) then
				maximum = GetGarage(k)
			end
		end
	end

	callback(maximum)
end)

RegisterNetEvent('revenge-apartments:voiceChannel')
AddEventHandler('revenge-apartments:voiceChannel', function(channel)
	if channel ~= nil then
		NetworkSetVoiceChannel(channel)
	else	
		Citizen.InvokeNative(0xE036A705F989E049)
	end
end)

RegisterNetEvent('revenge-apartments:show')
AddEventHandler('revenge-apartments:show', function(id)
	for i=1, #ESX.Game.GetPlayers(), 1 do
		if GetPlayerServerId(ESX.Game.GetPlayers()[i]) == id then
			for i=1, #hidden, 1 do
				if GetPlayerServerId(hidden[i]) == id then
					table.remove(hidden, i)
			 	end 
			end
		end
	end
end)

RegisterNetEvent('revenge-apartments:leave')
AddEventHandler('revenge-apartments:leave', function(session)
	if session.data ~= nil then
		if session.data.type == 'apartment' then
			local apartment = session.data.id
			local values = GetApartmentValues(apartment)

			DoScreenFadeOut(1000)

			Citizen.Wait(1500)

			Markers.RemoveMarker('apartment_exit')
			Markers.RemoveMarker('apartment_upgrades')

			SetEntityCoords(GetPlayerPed(-1), values.enter.x, values.enter.y, values.enter.z)

			DoScreenFadeIn(1000)
		else
		end
	end
end)

RegisterNetEvent('revenge-apartments:joinedSession')
AddEventHandler('revenge-apartments:joinedSession', function(session, identifier)
	if session.data ~= nil then
		if session.data.type == 'apartment' then
			EnterApartment(tonumber(session.data.id), false, (session.owner ~= identifier))
		elseif session.data.type == 'garage' then
			EnterGarage(tonumber(session.data.id))
		end
	end
end)

RegisterNetEvent('revenge-apartments:hide')
AddEventHandler('revenge-apartments:hide', function(id)
	for i=1, #ESX.Game.GetPlayers(), 1 do
		if GetPlayerServerId(ESX.Game.GetPlayers()[i]) == id then
			local ped = GetPlayerPed(ESX.Game.GetPlayers()[i])

			table.insert(hidden, ESX.Game.GetPlayers()[i])
		end
	end
end)

RegisterNetEvent('revenge-apartments:gotInvite')
AddEventHandler('revenge-apartments:gotInvite', function(inviter, apartment)
	OpenConfirmationMenu(function(confirmed)
		if confirmed then
			Session('acceptInvite', inviter)

			EnterApartment(apartment, false, true)
		end
	end)
end)

function EnterApartment(apartment, visit, invite)
	Citizen.CreateThread(function()
		local owned = not visit and not invite
		local values = GetApartmentValues(apartment)
		local ped = GetPlayerPed(-1)
			
		if GetApartmentIpl(apartment, values.ipl) ~= nil then
			for i=1, #values.designs, 1 do
				local design = values.designs[i]

				if IsIplActive(design) then
					RemoveIpl(design)

					while IsIplActive(design) do
						Citizen.Wait(1)
					end
				end
			end

			RequestIpl(GetApartmentIpl(apartment, values.ipl))
		end

		DoScreenFadeOut(1000)

		Citizen.Wait(1500)

		SetEntityCoords(ped, values.inside.x, values.inside.y, values.inside.z - 1.0)
		DoScreenFadeIn(1000)

		if owned or visit then
			Session('create', {type = 'apartment', id = apartment})
		end

		if owned then
			Markers.RemoveMarker('apartment_storage')
			Markers.AddMarker('apartment_storage', values.storage, 'Press ~INPUT_CONTEXT~ to open the storage', function()
				OpenStorageMainMenu(apartment)
			end)
		end

		if owned or invited then
			Markers.RemoveMarker('apartment_closet')
			Markers.AddMarker('apartment_closet', values.closet, 'Press ~INPUT_CONTEXT~ to change your clothes', function()
				ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
	          		local elements = {}

			       	for i=1, #dressing, 1 do
			        	table.insert(elements, {label = dressing[i], value = i})
			        end

			        ESX.UI.Menu.Open(
			            'default', GetCurrentResourceName(), 'player_dressing',
			            {
			                title = 'Owned Clothes',
			                align = 'top-left',
			                elements = elements,
			            },
			            function(data, menu)
			                TriggerEvent('skinchanger:getSkin', function(skin)
			                    ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)
			                        TriggerEvent('skinchanger:loadClothes', skin, clothes)
			                        TriggerEvent('esx_skin:setLastSkin', skin)

			                        TriggerEvent('skinchanger:getSkin', function(skin)
			                            TriggerServerEvent('esx_skin:save', skin)
					                end)
			               		end, data.current.value)
			             	end)
			            end,
			            function(data, menu)
			                menu.close()
			            end
			        )
			    end)
			end)
		end

		Markers.RemoveMarker('apartment_exit')
		Markers.AddMarker('apartment_exit', values.exit, 'Press ~INPUT_CONTEXT~ to open the apartment menu', function()
			local garage = GetGarage(apartment)
			local elements = {
				{label = 'Exit To Ground', value = 'exit'}
			}

			if owned or invite then
				table.insert(elements, {label = 'Invite A Friend', value = 'invite'})
			end

			if garage ~= 0 and owned then
				table.insert(elements, {label = 'Enter Garage', value = 'garage'})
			end

			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_teleport_menu',
				{
					title = 'Teleporter',
					align = 'top-left',
					elements = elements
				},
				function(data, menu)
					menu.close()

					if data.current.value == 'exit' then
						if owned or visit then
							Session('delete')
						else
							Session('leave')
						end
					
						DoScreenFadeOut(1000)

						Citizen.Wait(1500)

						Markers.RemoveMarker('apartment_exit')
						Markers.RemoveMarker('apartment_upgrades')

						if GetApartmentIpl(apartment, values.ipl) ~= nil then
							RemoveIpl(GetApartmentIpl(apartment, values.ipl))
						end

						SetEntityCoords(ped, values.enter.x, values.enter.y, values.enter.z)

						DoScreenFadeIn(1000)
					elseif data.current.value == 'garage' then
						if owned or visit then
							Session('delete', true)
						else
							Session('leave')
						end		

						EnterGarage(apartment)

						Citizen.Wait(1500)

						if GetApartmentIpl(apartment, values.ipl) ~= nil then
							RemoveIpl(GetApartmentIpl(apartment, values.ipl))
						end
					elseif data.current.value == 'invite' then
						local playersInArea = ESX.Game.GetPlayersInArea(values.enter, 10.0)
				        local elements = {}

				        for i=1, #playersInArea, 1 do
				            if playersInArea[i] ~= PlayerId() then
				                table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
				            end
				        end

				        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartments_invite',
				            {
				                title = 'Invite',
				                align = 'top-left',
				                elements = elements,
				            },
				            function(data, menu)
				            	menu.close()

				            	Session('invite', GetPlayerServerId(data.current.value), apartment)
				            end,
				            function(data, menu)
				                menu.close()
				            end
				        )
					end
				end,
				function(data, menu)
					menu.close()
				end
			)
		end)

		if values.upgrade ~= nil and owned then
			Markers.RemoveMarker('apartment_upgrades')
			Markers.AddMarker('apartment_upgrades', values.upgrade, 'Press ~INPUT_CONTEXT~ to view upgrades', function()
				OpenUpgradeApartmentMenu(apartment)
			end)
		end
	end)
end

function OpenStorageMainMenu(apartment)
	local elements = {
		{label = 'Items', value = 'items'}
	}

	if HasStorage(apartment, 'weapons') then
		table.insert(elements, {label = 'Weapons', value = 'weapons'})
	end

	if HasStorage(apartment, 'drugs') then
		table.insert(elements, {label = 'Drugs', value = 'drugs'})
	end

	if HasStorage(apartment, 'safe') then
		table.insert(elements, {label = 'Safe', value = 'safe'})
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_storage',
		{
			title = 'Storage',
			align = 'top-left',
			elements = elements
		},
		function(data, menu)
			menu.close()

			OpenStorageUnit(apartment, data.current.value)	
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenStorageUnit(apartment, storage)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_storage_option',
		{
			title = 'Storage',
			align = 'top-left',
			elements = {
				{label = 'Get Item', value = 'get'},
				{label = 'Stash Item', value = 'put'}
			}
		},
		function(data, menu)
			menu.close()

			OpenStorageUnitContent(apartment, storage, data.current.value == 'get')
		end,
		function(data, menu)
			menu.close()

			OpenStorageMainMenu(apartment)
		end
	)
end

function OpenStorageUnitContent(apartment, storage, get)
	MySQL.fetchAll('SELECT items FROM apartments WHERE identifier=@identifier AND id=@id',
		{
			["@identifier"] = ESX.GetPlayerData().identifier,
			["@id"] = apartment
		},
		function(fetched)
			if fetched ~= nil and fetched[1] ~= nil then
				local items = json.decode(fetched[1].items)

				if get then
					if items[storage] ~= nil then
						local elements = {}

						for k,v in pairs(items[storage]) do
							if v ~= nil and v.count ~= nil then
								if v.count > 0 then
									if v.ammo ~= nil then
										table.insert(elements, {label = v.label .. ' x' .. v.count .. ' (' .. v.ammo .. ')', value = k, amount = v.count, rawLabel = v.label})
									elseif v.money == true then
										table.insert(elements, {label = 'Dirty Money ($' .. v.count .. ')', value = k, amount = v.count, rawLabel = 'Dirty Money'})								
									else
										table.insert(elements, {label = v.label .. ' x' .. v.count, value = k, amount = v.count, rawLabel = v.label})
									end
								end
							end
						end

						ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_storage_items',
							{
								title = 'Storage Content',
								align = 'top-left',
								elements = elements
							},
							function(data2, menu)
								menu.close()

				        		local itemName = data2.current.value

				        		OpenQuantityMenu(function(count)
				        			if count <= 0 then
				        				ESX.ShowNotification('~r~Invalid amount. Needs to be greater than 0.')
				        				
				        				return
				        			end

				        			if items[storage] ~= nil and items[storage][itemName] ~= nil then	    
				        				if items[storage][itemName].weapon ~= true then
					        				if items[storage][itemName].count >= count then
						        				items[storage][itemName].count = items[storage][itemName].count - count

						        				if items[storage][itemName].money == true then
						        					ESX.TriggerServerCallback('revenge-apartments:addDirtyMoney', function()
										        	end, count)
						        				else
								        			ESX.TriggerServerCallback('revenge-apartments:addItem', function()
										        	end, itemName, count)
								        		end

												if items[storage][itemName].count < 1 then
								        			items[storage][itemName] = nil
								        		end

						        				MySQL.Sync.execute('UPDATE apartments SET items=@items WHERE identifier=@identifier AND id=@id',
							        				{
							        					["@items"] = json.encode(items),
							        					["@identifier"] = ESX.GetPlayerData().identifier,
							        					["@id"] = apartment
							        				}
						        				)
							        		else
							        			ESX.ShowNotification('The storage does not contain ~r~x' .. count .. ' ' .. data2.current.rawLabel)
							        		end
							        	else
							        		local amount = items[storage][itemName].count

							        		if amount >= count then	  
							        			local weaponAmmo = math.round(items[storage][itemName].ammo / amount)

								        		items[storage][itemName].count = amount - count
								        		items[storage][itemName].ammo = items[storage][itemName].ammo - math.round(items[storage][itemName].ammo / amount) * count

								        		ESX.TriggerServerCallback('revenge-apartments:addWeapon', function()
									        	end, itemName, weaponAmmo, count)

								        		if items[storage][itemName].count < 1 then
								        			items[storage][itemName] = nil
								        		end

						        				MySQL.Sync.execute('UPDATE apartments SET items=@items WHERE identifier=@identifier AND id=@id',
							        				{
							        					["@items"] = json.encode(items),
							        					["@identifier"] = ESX.GetPlayerData().identifier,
							        					["@id"] = apartment
							        				}
						        				)			        	
							        		else
							        			ESX.ShowNotification('The storage does not contain ~r~x' .. count .. ' ' .. data2.current.rawLabel)
							        		end
							        	end
				        			else
				        				ESX.ShowNotification('The storage does not contain ~r~x' .. count .. ' ' .. data2.current.rawLabel)
				        			end						     

								    OpenStorageUnitContent(apartment, storage, get)   		
				        		end)
							end,
							function(data, menu)
								menu.close()

								OpenStorageUnit(apartment, storage)
							end
						)
					end
				else
					ESX.TriggerServerCallback('revenge-apartments:getInventory', function(inventory)
				    	ESX.TriggerServerCallback('revenge-apartments:getDirtyMoney', function(money)
					    	local elements = {}

					    	if storage == 'weapons' then
					    		local weaponList = ESX.GetWeaponList()

							  	for i=1, #weaponList, 1 do
							    	local weaponHash = GetHashKey(weaponList[i].name)

							    	if HasPedGotWeapon(GetPlayerPed(-1),  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
							      		table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name, rawLabel = weaponList[i].label, weapon = true})
							    	end
							  	end
					    	elseif storage == 'safe' then
					    		table.insert(elements, {label = 'Dirty Money ($' .. money .. ')', value = 'dirty', amount = money, money = true})	
					    	else
						    	for i=1, #inventory, 1 do
						      		local item = inventory[i]

						      		if item.count > 0 then
						      			if storage == 'drugs' then
						      				if table.contains(drugs, string.lower(item.name)) then
								        		table.insert(elements, {label = item.label .. ' x' .. item.count, value = item.name, rawLabel = item.label})
								        	end
							        	elseif storage == 'weapons' then
							        		if string.startsWith(string.lower(item.name), 'weapon_') then
								        		table.insert(elements, {label = item.label .. ' x' .. item.count, value = item.name, rawLabel = item.label})		        	
							        		end 		
							        	else
							        		if (not table.contains(drugs, string.lower(item.name)) and (not string.startsWith(string.lower(item.name), 'weapon_'))) then
								        		table.insert(elements, {label = item.label .. ' x' .. item.count, value = item.name, rawLabel = item.label})
								        	end
							        	end
						     	 	end
						    	end
						    end

					    	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_put_stash',
					      		{
					        		title = 'Items',
					        		align = 'top-left',
					        		elements = elements
					      		},
					     		function(data2, menu)
					     			menu.close()

					        		local itemName = data2.current.value

					        		if data2.current.money == true then
					        			OpenQuantityMenu(function(count)
					        				if count <= 0 then
						        				ESX.ShowNotification('~r~Invalid amount. Needs to be greater than 0.')

						        				return
						        			end

					        				if money >= count then
					        					if items[storage] ~= nil and items[storage][itemName] ~= nil then
							        				items[storage][itemName].count = items[storage][itemName].count + count
							        			else
							        				if items[storage] == nil then
							        					items[storage] = {}
							        				end

							        				items[storage][itemName] = {count = count, label = 'Dirty money', money = true}
							        			end

							        			MySQL.Sync.execute('UPDATE apartments SET items=@items WHERE identifier=@identifier AND id=@id',
							        				{
							        					["@items"] = json.encode(items),
							        					["@identifier"] = ESX.GetPlayerData().identifier,
							        					["@id"] = apartment
							        				}
							        			)

							        			ESX.TriggerServerCallback('revenge-apartments:setDirtyMoney', function()
							        			end, (money - count))
					        				else
					        					ESX.ShowNotification("You ~r~don't ~w~have ~r~$" .. count .. " ~w~dirty money.")
					        				end
					        			end)
					        		elseif data2.current.weapon ~= true then
						        		OpenQuantityMenu(function(count)
						        			if count <= 0 then
						        				ESX.ShowNotification('~r~Invalid amount. Needs to be greater than 0.')

						        				return
						        			end

						        			ESX.TriggerServerCallback('revenge-apartments:hasItem', function(has)
						        				if has == true then
						        					if items[storage] ~= nil and items[storage][itemName] ~= nil then
								        				items[storage][itemName].count = items[storage][itemName].count + count
								        			else
								        				if items[storage] == nil then
								        					items[storage] = {}
								        				end

								        				items[storage][itemName] = {count = count, label = data2.current.rawLabel}
								        			end

								        			MySQL.Sync.execute('UPDATE apartments SET items=@items WHERE identifier=@identifier AND id=@id',
								        				{
								        					["@items"] = json.encode(items),
								        					["@identifier"] = ESX.GetPlayerData().identifier,
								        					["@id"] = apartment
								        				}
								        			)

								        			ESX.TriggerServerCallback('revenge-apartments:removeItem', function()
								        			end, itemName, count)
						        				else
						        					ESX.ShowNotification("You ~r~don't ~w~have that ~w~amount")
						        				end
						        			end, itemName, count)

										    OpenStorageUnitContent(apartment, storage, get)				       
						        		end)
						        	else
						        		local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey(itemName))

						        		if items[storage] ~= nil and items[storage][itemName] ~= nil then
					        				items[storage][itemName].count = items[storage][itemName].count + 1
					        				items[storage][itemName].ammo = items[storage][itemName].ammo + ammo
					        			else
					        				if items[storage] == nil then
					        					items[storage] = {}
					        				end

					        				items[storage][itemName] = {count = 1, ammo = ammo, label = data2.current.rawLabel, weapon = true}
					        			end

					        			MySQL.Sync.execute('UPDATE apartments SET items=@items WHERE identifier=@identifier AND id=@id',
					        				{
					        					["@items"] = json.encode(items),
					        					["@identifier"] = ESX.GetPlayerData().identifier,
					        					["@id"] = apartment
					        				}
					        			)

					        			ESX.TriggerServerCallback('revenge-apartments:removeWeapon', function()
					        			end, itemName)
					        		end
					          	end,
					         	function(data, menu)
					            	menu.close()

									OpenStorageUnit(apartment, storage)
					     		end
					    	)
					  	end)
					end)
				end
			end
		end
	)
end

function EnterGarage(apartment)
	Citizen.CreateThread(function()
		local values = GetApartmentValues(apartment)
		local garage = values.garages[GetGarage(apartment)]
		local ped = GetPlayerPed(-1)

		DoScreenFadeOut(1000)
		
		Citizen.Wait(1500)

		Markers.RemoveMarker('apartment_exit')
		Markers.RemoveMarker('apartment_upgrades')

		SetEntityCoords(ped, garage.x, garage.y, garage.z)
		SetEntityHeading(ped, garage.heading)

		DoScreenFadeIn(1000)

		Session('create', {type = 'garage', id = apartment})
		
		local garageVehicles = {}
		local position = 1

		TriggerEvent('revenge-garage:fetchVehicles', function(vehicles)
			for _,i in pairs(vehicles) do
				local model = i.model
				local properties = i.properties

				if not i.impounded then
					local vehiclePosition = garage.vehicles[position]

					if vehiclePosition ~= nil then
						position = position + 1

						while IsAnyVehicleNearPoint(vehiclePosition.x, vehiclePosition.y, vehiclePosition.z, 5.0) do
							Citizen.Wait(5)

							ESX.Game.DeleteVehicle(GetClosestVehicle(vehiclePosition.x, vehiclePosition.y, vehiclePosition.z, 5.0, 0, 71))
						end

						ESX.Game.SpawnLocalVehicle(model, vehiclePosition, vehiclePosition.heading, function(callbackVehicle)
							ESX.Game.SetVehicleProperties(callbackVehicle, properties)

							table.insert(garageVehicles, callbackVehicle)
						end)
					end
				end
			end
		end)

		Markers.RemoveMarker('apartment_garage_vehicle_exit')
		Markers.AddMarker('apartment_garage_vehicle_exit', {x = garage.exit.x, y = garage.exit.y, z = (garage.exit.z + 0.05)}, 'Press ~INPUT_CONTEXT~ to drive out of the garage', function()
			local ped = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(ped)
			local properties = ESX.Game.GetVehicleProperties(vehicle)

			DoScreenFadeOut(1000)

			Citizen.Wait(1000)

			for i=1, #garageVehicles, 1 do
				ESX.Game.DeleteVehicle(garageVehicles[i])
			end

			ESX.Game.SpawnVehicle(properties.model, values.garage, values.garage.heading, function(callbackVehicle)
				ESX.Game.SetVehicleProperties(callbackVehicle, properties)

				TriggerEvent('revenge-garage:impound', properties.plate, properties.model)

				TaskWarpPedIntoVehicle(ped, callbackVehicle, -1)
			end)

			Citizen.Wait(500)

			DoScreenFadeIn(1000)

			Session('delete')
		end, {red = 255, green = 255, blue = 0, alpha = 100}, {x = 4.0, y = 4.0, z = 0.1}, 27, true)

		Markers.RemoveMarker('apartment_garage_exit')
		Markers.AddMarker('apartment_garage_exit', garage, 'Press ~INPUT_CONTEXT~ to exit the garage', function()
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_garage_teleport_menu',
				{
					title = 'Teleporter',
					align = 'top-left',
					elements = {
						{label = 'Enter Apartment', value = 'apartment'},
						{label = 'Exit To Ground', value = 'exit'}
					}
				},
				function(data, menu)
					menu.close()
							
					Session('delete')
					
					if data.current.value == 'exit' then
						DoScreenFadeOut(1000)

						Citizen.Wait(1000)

						for i=1, #garageVehicles, 1 do
							ESX.Game.DeleteVehicle(garageVehicles[i])
						end

						SetEntityCoords(ped, values.enter.x, values.enter.y, values.enter.z)

						Citizen.Wait(500)

						DoScreenFadeIn(1000)
					elseif data.current.value == 'apartment' then
						for i=1, #garageVehicles, 1 do
							ESX.Game.DeleteVehicle(garageVehicles[i])
						end
						
						EnterApartment(apartment, false, false)
					end

					Markers.RemoveMarker('apartment_garage_exit')
					Markers.RemoveMarker('apartment_garage_vehicle_exit')
				end,
				function(data, menu)
					menu.close()
				end
			)
		end)
	end)
end

function OpenApartmentMenu(apartment, owned)
	local values = GetApartmentValues(apartment)

	if owned then
		local garage = GetGarage(apartment)
		local elements = {
			{label = 'Enter Apartment', value = 'apartment'}
		}

		if garage ~= 0 then
			table.insert(elements, {label = 'Enter Garage', value = 'garage'})
		end

		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_menu',
			{
				title = values.label,
				align = 'top-left',
				elements = elements
			},
			function(data, menu)
				menu.close()

				if data.current.value == 'apartment' then
					EnterApartment(apartment, false, false)
				elseif data.current.value == 'garage' then
					EnterGarage(apartment)
				end
			end,
			function(data, menu)
				menu.close()
			end
		)
	else
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_menu',
			{
				title = values.label,
				align = 'top-left',
				elements = {
					{label = 'Visit', value = 'visit'},
					{label = 'Purchase - $' .. values.price, value = 'purchase'}
				}
			},
			function(data, menu)
				menu.close()

				if data.current.value == 'visit' then
					EnterApartment(apartment, true, false)
				elseif data.current.value == 'purchase' then
					OpenConfirmationMenu(function(state)
						if state == true then
							ESX.TriggerServerCallback('revenge-apartments:makePayment', function(success)
								if success then	
									Notifications.PlaySpecialNotification('Purchased ' .. values.label)

									CachedApartments[apartment] = {
										owned = true,
										garage = 0,
										items = '[]',
										modifications = {design = GetApartmentValues(apartment).ipl}
									}

									MySQL.execute('INSERT INTO apartments (id, identifier, modifications, items, garage) VALUES (@id, @identifier, @modifications, @items, @garage)', 
										{
											["@id"] = apartment,
											["@identifier"] = ESX.GetPlayerData().identifier,
											["@modifications"] = json.encode({design = GetApartmentValues(apartment).ipl}),
											["@items"] = '[]',
											["@garage"] = 0,		
										}
									)

									Markers.AddMarker('apartment_' .. apartment, values.enter, 'Press ~INPUT_CONTEXT~ to enter the apartment', function()
										OpenApartmentMenu(apartment, true)
									end)

									if values.garage ~= nil and GetGarage(apartment) > 0 then
										Markers.RemoveMarker('apartment_park_' .. apartment)
										Markers.AddMarker('apartment_park_' .. apartment, values.garage, 'Press ~INPUT_CONTEXT~ to park your vehicle', function()
											StoreVehicleInGarage(apartent)
										end, nil, nil, nil, true)
									end
								else
									ESX.ShowNotification('You do not have enough money. (~r~$' .. values.price .. '~w~)')
								end
							end, values.price)
						end
					end)
				end
			end, 
			function(data, menu)
				menu.close()
			end
		)
	end
end

function OpenUpgradeApartmentMenu(apartment)
	local values = GetApartmentValues(apartment)
	local ped = GetPlayerPed(-1)
	local elements = {
		{label = 'Storage', value = 'storage'},
		{label = 'Garage', value = 'garage'}
	}

	if values.designs ~= nil then
		table.insert(elements, {label = 'Design', value = 'design'})
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_upgrades',
		{
			title = 'Upgrades',
			align = 'top-left',
			elements = elements
		},
		function(data, menu)
			menu.close()

			if data.current.value == 'design' then
				OpenApartmentDesignChooser(apartment)
			elseif data.current.value == 'garage' then
				OpenApartmentGarageMenu(apartment)
			elseif data.current.value == 'storage' then
				local elements = {}

				if not HasStorage(apartment, 'weapons') then
					table.insert(elements, {label = 'Weapon Storage | $175,000', value = 'weapons', cost = 175000})
				end

				if not HasStorage(apartment, 'drugs') then
					table.insert(elements, {label = 'Drugs Storage | $100,000', value = 'drugs', cost = 100000})
				end

				if not HasStorage(apartment, 'safe') then
					table.insert(elements, {label = 'Safe | $100,000', value = 'safe', cost = 100000})
				end

				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_storage_upgrades',
					{
						title = 'Storage Upgrades',
						align = 'top-left',
						elements = elements
					},
					function(data, menu)
						menu.close()

						OpenConfirmationMenu(function(confirmed)
							if confirmed then
								ESX.TriggerServerCallback('revenge-apartments:makePayment', function(success)
									if success then
										UpgradeStorage(apartment, data.current.value)
									else
										ESX.ShowNotification('You do not have enough money. (~r~$' .. data.current.cost .. '~w~)')
									end
								end, data.current.cost)
							end
						end)
					end,
					function(data, menu)
						menu.close()
					end
				)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenApartmentDesignChooser(apartment)
	Citizen.CreateThread(function()
		local values = GetApartmentValues(apartment)
		local currentDesign = GetApartmentIpl(apartment, values.ipl)
		local ped = GetPlayerPed(-1)
		local firstIpl = 'none'
		local designs = {}

		DoScreenFadeOut(500)
		
		TriggerEvent('revenge-cinemamode:show')

		Citizen.Wait(600)

		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
					
		SetCamCoord(cam, values.camera.x, values.camera.y, values.camera.z)
		SetCamRot(cam, values.camera.rotationX, values.camera.rotationY, values.camera.rotationZ)
		SetCamActive(cam,  true)
		
		RenderScriptCams(true,  false,  0,  true,  true)
		
		SetCamCoord(cam, values.camera.x, values.camera.y, values.camera.z)

		SetEntityVisible(ped, false, 0)

		Markers.HideAll()
		
		for k,v in orderedPairs(values.designs) do	
			if firstIpl == 'none' then
				firstIpl = v.ipl
			end

			RemoveIpl(v.ipl)

			if currentDesign == v.ipl then
				table.insert(designs, {label = k .. ' | Owned', value = v.ipl})
			else
				table.insert(designs, {label = k .. ' | $' .. v.cost, value = v.ipl, cost = v.cost})
			end
		end

		local lastIpl = nil

		RequestIpl(firstIpl)

		Citizen.Wait(600)

		DoScreenFadeIn(500)
		
		Citizen.Wait(100)

		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_design_chooser', 
			{
				title = 'Apartment Designs',
				align = 'top-left',
				elements = designs
			},
			function(data, menu)
				if data.current.cost ~= nil then
					menu.close()

					OpenConfirmationMenu(function(confirmed)
						if confirmed then
							ESX.TriggerServerCallback('revenge-apartments:makePayment', function(success)
								if success then
									if cam ~= nil then
										if DoesCamExist(cam) then
											local ped = GetPlayerPed(-1)

											RenderScriptCams(false, false, 0, 1, 0)
											DestroyCam(cam)

											cam = nil

											TriggerEvent('revenge-cinemamode:show')
											SetEntityVisible(ped, true, 0)

											Markers.ShowAll()
										end
									end

									DoScreenFadeOut(500)

									Citizen.Wait(500)
									
									RemoveIpl(currentDesign)

									while IsIplActive(currentDesign) do
										Citizen.Wait(1)
									end

									SetDesign(apartment, data.current.value)

									Session('delete')
									
									Markers.RemoveMarker('apartment_exit')
									Markers.RemoveMarker('apartment_upgrades')

									EnterApartment(apartment, false, false)

									Notifications.PlaySpecialNotification('Purchased the design ' .. data.current.label)
								else
									ESX.ShowNotification('You do not have enough money. (~r~$' .. data.current.cost .. '~w~)')
								end
							end, data.current.cost)
						else
							OpenApartmentDesignChooser(apartment)
						end
					end)
				else
					ESX.ShowNotification('~r~You already own this design.')
				end
			end,
			function(data, menu)
				menu.close()	
			end,
			function(data, menu)
				local ipl = lastIpl

				if ipl == nil then
					ipl = firstIpl
				end

				lastIpl = data.current.value

				DoScreenFadeOut(500)
		
				Citizen.Wait(600)

				RemoveIpl(ipl)

				while IsIplActive(ipl) do
					Citizen.Wait(1)
				end

				RequestIpl(data.current.value)

				while not IsIplActive(data.current.value) do
					Citizen.Wait(1)
				end
				
				Citizen.Wait(600)

				DoScreenFadeIn(500)
			end,
			function(data, menu)
				local ipl = lastIpl

				if ipl == nil then
					ipl = firstIpl
				end
		
				DoScreenFadeOut(500)
				
				Citizen.Wait(600)

				RemoveIpl(ipl)

				while IsIplActive(ipl) do
					Citizen.Wait(1)
				end

				RequestIpl(currentDesign)

				while not IsIplActive(currentDesign) do
					Citizen.Wait(1)
				end
				
				Citizen.Wait(600)
				
				DoScreenFadeIn(500)

				if cam ~= nil then
					if DoesCamExist(cam) then
						local ped = GetPlayerPed(-1)

						RenderScriptCams(false, false, 0, 1, 0)
						DestroyCam(cam)

						cam = nil

						TriggerEvent('revenge-cinemamode:show')
						SetEntityVisible(ped, true, 0)

						Markers.ShowAll()
					end
				end
			end
		)
	end)
end

function OpenApartmentGarageMenu(apartment)
	Citizen.CreateThread(function()
		local values = GetApartmentValues(apartment)
		local ped = GetPlayerPed(-1)
		local coords = {x = GetEntityCoords(ped).x, y = GetEntityCoords(ped).y, z = (GetEntityCoords(ped).z - 1.0)}
		local currentGarage = GetGarage(apartment)
		local elements = {}

		for k,v in orderedPairs(values.garages) do
			if k == currentGarage then
				table.insert(elements, {label = k .. ' Car | Owned', value = k, x = v.cameraX, y = v.cameraY, z = v.cameraZ})
			else
				table.insert(elements, {label = k .. ' Car | $' .. v.cost, value = k, cost = v.cost, x = v.cameraX, y = v.cameraY, z = v.cameraZ})
			end
		end

		DoScreenFadeOut(500)

		Citizen.Wait(600)

		SetEntityCoords(ped, values.garages[2].cameraX, values.garages[2].cameraY, values.garages[2].cameraZ)

		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
					
		SetCamCoord(cam, values.garages[2].cameraX, values.garages[2].cameraY, values.garages[2].cameraZ + 3.0)
		SetCamActive(cam, true)
		
		RenderScriptCams(true,  false,  0,  true,  true)
		
		SetCamCoord(cam, values.garages[2].cameraX, values.garages[2].cameraY, values.garages[2].cameraZ + 3.0)

		TriggerEvent('revenge-cinemamode:show')
		SetEntityVisible(ped, false, 0)

		Markers.HideAll()
		
		Citizen.Wait(600)

		DoScreenFadeIn(500)

		Citizen.Wait(100)
		
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartment_garage_chooser_menu', 
			{
				title = 'Garage Upgrades',
				align = 'top-left',
				elements = elements
			},
			function(data, menu)
				menu.close()

				if data.current.cost ~= nil then
					OpenConfirmationMenu(function(confirmed)
						if confirmed then
							ESX.TriggerServerCallback('revenge-apartments:makePayment', function(success)
								if success then
									Notifications.PlaySpecialNotification('Purchased the ' .. data.current.label .. ' garage')

									SetGarage(apartment, data.current.value)
									
									if values.garage ~= nil and GetGarage(apartment) > 0 then
										Markers.RemoveMarker('apartment_park_' .. apartment)
										Markers.AddMarker('apartment_park_' .. apartment, values.garage, 'Press ~INPUT_CONTEXT~ to park your vehicle', function()
											StoreVehicleInGarage(apartment)
										end, nil, nil, nil, true)
									end
								else
									ESX.ShowNotification('You do not have enough money. (~r~$' .. data.current.cost .. '~w~)')
								end
							end, data.current.cost)
						else
							OpenApartmentGarageMenu(apartment)
						end
					end)
				else
					ESX.ShowNotification('~r~You already own this garage.')
				end
			end,
			function(data, menu)
				menu.close()
			end,
			function(data, menu)
				DoScreenFadeOut(500)

				Citizen.Wait(600)

				SetEntityCoords(ped, data.current.x, data.current.y, data.current.z)
			
				SetCamActive(cam, false)
				SetCamCoord(cam, data.current.x, data.current.y, data.current.z + 3.0)
				SetCamActive(cam, true)
		
				RenderScriptCams(true,  false,  0,  true,  true)
				
				SetCamCoord(cam, data.current.x, data.current.y, data.current.z + 3.0)
				
				Citizen.Wait(100)

				DoScreenFadeIn(500)
			end,
			function(data, menu)
				DoScreenFadeOut(500)

				Citizen.Wait(600)

				if cam ~= nil then
					if DoesCamExist(cam) then
						local ped = GetPlayerPed(-1)

						RenderScriptCams(false, false, 0, 1, 0)
						DestroyCam(cam)

						cam = nil

						TriggerEvent('revenge-cinemamode:show')
						SetEntityVisible(ped, true, 0)

						Markers.ShowAll()
						
						SetEntityCoords(ped, coords.x, coords.y, coords.z)
					end
				end

				Citizen.Wait(500)

				DoScreenFadeIn(500)
			end
		)
	end)
end

function StoreVehicleInGarage(apartment)
	local values = GetApartmentValues(apartment)
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)

	if vehicle ~= nil and vehicle ~= 0 then
		TriggerEvent('revenge-garage:fetchMetadata', vehicle, function(metadata)
			if metadata.owned == true then
				local properties = ESX.Game.GetVehicleProperties(vehicle)

				TriggerEvent('revenge-garage:unimpound', properties.plate, properties.model)
				TriggerEvent('revenge-garage:update', vehicle)

				Citizen.CreateThread(function()
					Citizen.Wait(1000)

					ESX.Game.DeleteVehicle(vehicle)
				end)

				EnterGarage(apartment)
			else
				ESX.ShowNotification('~r~This is not your vehicle!')
			end
		end)
	else
		ESX.ShowNotification('~r~You need to be in a vehicle')
	end
end

function OpenConfirmationMenu(callback)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirmation_menu',
		{
			title = 'Are you sure?',
			align = 'top-left',
			elements = {
				{label = 'Yes', value = 'yes'},
				{label = 'No', value = 'no'}
			}
		},
		function(data, menu)
			menu.close()

			callback(data.current.value == 'yes')
		end,
		function(data, menu)
			menu.close()

			callback()
		end
	)
end

function OpenQuantityMenu(callback)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'quantity_menu',
        {
            title = 'Quantity'
        },
        function(data, menu)
            local count = tonumber(data.value)

            if count == nil then
              	ESX.ShowNotification('Quantity invalid')
            else
              	menu.close()
            
              	callback(count)
            end
        end,
        function(data, menu)
        	menu.close()
        end
    )
end

function HasApartment(apartment)
	return CachedApartments[apartment].owned
end

function GetApartmentIpl(apartment, defaultIpl)
	local ipl = CachedApartments[apartment].modifications.design

	if ipl == nil then
		ipl = defaultIpl
	end

	return ipl
end

function GetApartmentValues(apartment)
	for k,v in pairs(Apartments) do
		if k == apartment then
			return v
		end
	end
end

function GetGarage(apartment)
	return CachedApartments[apartment].garage
end

function SetDesign(apartment, design)
	CachedApartments[apartment].modifications.design = design

	MySQL.execute('UPDATE apartments SET modifications = @modifications WHERE id = @id AND identifier = @identifier', 
		{
			["@modifications"] = json.encode(CachedApartments[apartment].modifications),
			["@id"] = apartment,
			["@identifier"] = ESX.GetPlayerData().identifier
		}
	)
end

function SetGarage(apartment, garage)
	CachedApartments[apartment].garage = garage

	MySQL.execute('UPDATE apartments SET garage = @garage WHERE id = @id AND identifier = @identifier', 
		{
			["@garage"] = garage,
			["@id"] = apartment,
			["@identifier"] = ESX.GetPlayerData().identifier
		}
	)
end

function HasStorage(apartment, storage)	
	return CachedApartments[apartment].modifications[storage] == true
end

function UpgradeStorage(apartment, storage)
	CachedApartments[apartment].modifications[storage] = true

	MySQL.execute('UPDATE apartments SET modifications = @modifications WHERE id = @id AND identifier = @identifier',
		{
			["@modifications"] = json.encode(CachedApartments[apartment].modifications),
			["@id"] = apartment,
			["@identifier"] = ESX.GetPlayerData().identifier
		}
	)
end

function CacheApartments(callback)
	local identifier = ESX.GetPlayerData().identifier

	MySQL.fetchAll('SELECT * FROM apartments WHERE identifier = @identifier', 
	{
		["@identifier"] = identifier,
	}, 
	function(fetched)
		if fetched ~= nil then
			for i=1, #fetched, 1 do
				local row = fetched[i]
				local modifications = json.decode(row.modifications)

				CachedApartments[row.id] = {owned = true, garage = row.garage, modifications = modifications}
			end

			callback()
		end
	end)

	for k,v in pairs(Apartments) do
		if CachedApartments[k] == nil then
			CachedApartments[k] = {owned = false, garage = 0, modifications = {design = v.ipl}}
		end
	end
end