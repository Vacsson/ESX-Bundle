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

ESX = nil
PlayerData = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj

			if ESX.IsPlayerLoaded() == true then
				PlayerData = ESX.GetPlayerData()
			end

			for k,v in pairs(Config.Shops) do
				Marker.AddMarker(k .. '_shop_marker', v.Position, 'Press ~INPUT_CONTEXT~ to open shop.', nil, 0, 
					function()
						OpenShopMenu(k, v)
					end,
					function()
						ESX.UI.Menu.CloseAll()
					end, v.HideMarker
				)
			end
		end)

		Citizen.Wait(0)
	end
end)

local HadArmor = false

AddEventHandler('skinchanger:modelLoaded', function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			local ped = GetPlayerPed(-1)
			local armor = GetPedArmour(ped)

			if armor > 0 then
				HadArmor = true
			else
				if HadArmor == true then
					HadArmor = false

					TriggerEvent('skinchanger:getSkin', function(skin)
						local clothes = {
							['bproof_1'] = 0,
							['bproof_2'] = 0
						}

						TriggerEvent('skinchanger:loadClothes', skin, clothes)
					end)
				end
			end
		end
	end)	
end)


function OpenShopMenu(title, values)
	local elements = {}

	for i=1, #values.Content, 1 do
		local item = values.Content[i]

		table.insert(elements, 
			{
				label = item.Label .. ' - $' .. item.Price,
				value = item.Item,
				amount = item.Amount,
				cost = item.Price
			}
		)
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), title .. '_shop_menu', 
		{
			title = title,
			align = 'top-left',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'bulletproof_vest' then
				ESX.TriggerServerCallback('revenge-specialshop:buyBulletproofVest', function(success)
					if success == false then
						TriggerEvent('esx:showNotication', 'You do not have enough money.')
					else
						SetPedArmour(GetPlayerPed(-1), 100)

						TriggerEvent('skinchanger:getSkin', function(skin)
							local clothes = {
								['bproof_1'] = 28,
								['bproof_2'] = 9
							}

							TriggerEvent('skinchanger:loadClothes', skin, clothes)
						end)
					end
				end, data.current.cost)
			else
				ESX.TriggerServerCallback('revenge-specialshop:buyItem', function(success)
					if success == false then
						TriggerEvent('esx:showNotication', 'You do not have enough money.')
					end
				end, data.current.value, data.current.amount, data.current.cost)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)