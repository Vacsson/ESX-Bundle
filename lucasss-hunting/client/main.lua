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

local IsHunting = false
local LastPed = nil
local CurrentVehicle = nil
local BlipAlert = nil
local AddMarker = true
local SpawnPostions = {
	{x = -739.89, y = 5206.17, z = 102.12},
	{x = -809.8, y = 5116.4, z = 143.63},
	{x = -544.37, y = 5040.91, z = 127.36},
	{x = -434.6, y = 4932.73, z = 169.09},
	{x = -520.99, y = 4841.9, z = 181.09},
	{x = -466.73, y = 4735.41, z = 239.77},
	{x = -269.75, y = 4755.71, z = 206.14},
	{x = -968.27, y = 5005.93, z = 181.03},
	{x = -971.67, y = 5088.2, z = 183.33},
	{x = -682.63, y = 5337.68, z = 66.94},
	{x = -455.72, y = 5473.63, z = 80.15}
}
local HuntingModels = {
	["307287994"] = {
		label = 'Mountain Lion'
	},
	["-664053099"] = {
		label =  'Deer'
	},
	["1682622302"] = {
		label = 'Coyote'
	},
	["-832573324"] = {
		label = 'Boar'
	}
}

ESX = nil
PlayerData = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj

			if ESX.IsPlayerLoaded() == true then
				PlayerData = ESX.GetPlayerData()

				local blip = AddBlipForCoord(Config.StartPosition.x, Config.StartPosition.y, Config.StartPosition.z)

				SetBlipSprite(blip, 103)
				SetBlipDisplay(blip, 4)
				SetBlipScale(blip, 1.2)
				SetBlipColour(blip, 69)
				SetBlipAsShortRange(blip, true)

			    BeginTextCommandSetBlipName("STRING")
			    AddTextComponentString('Hunting')
	    		EndTextCommandSetBlipName(blip)
			end
		end)

		Citizen.Wait(0)
	end
end)

AddEventHandler('skinchanger:modelLoaded', function(model)
	local blip = AddBlipForCoord(Config.StartPosition.x, Config.StartPosition.y, Config.StartPosition.z)

	SetBlipSprite(blip, 103)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.2)
	SetBlipColour(blip, 69)
	SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Hunting')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Marker.AddMarker('hunting_shop', Config.ShopPosition, 'Press ~INPUT_CONTEXT~ to sell all your meat.', nil, 0,
		function()
			ESX.TriggerServerCallback('revenge-hunting:sellMeat', function(money)
				TriggerEvent('esx:showNotification', 'You sold all your meat for ~g~$' .. money)
			end)
		end
	)

	while true do
		Citizen.Wait(50)

		if AddMarker == true then
			Marker.AddMarker('hunting_start_task', Config.StartPosition, 'Press ~INPUT_CONTEXT~ to start hunting.', nil, 0, 
				function()
					local ped = GetPlayerPed(-1)
					
					IsHunting = true

					if not HasPedGotWeapon(ped, GetHashKey('WEAPON_MUSKET'), false) then
						TriggerServerEvent('revenge-hunting:giveWeapon', GetPlayerServerId(PlayerId()))
					end

					TriggerEvent('esx:showNotification', 'Your hunting session has started. Come here to end it.')

					ESX.Game.SpawnVehicle('mesa3', Config.VehicleSpawnPosition, Config.VehicleSpawnPosition.heading, function(vehicle)
						CurrentVehicle = vehicle

						TaskWarpPedIntoVehicle(ped, vehicle, -1)
					end)

					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
							local clothes = json.decode('{"mask_2":0,"bags_1":0,"shoes_2":18,"tshirt_1":5,"decals_2":0,"torso_1":251,"chain_2":0,"bproof_1":0,"bags_2":0,"glasses_2":0,"tshirt_2":0,"glasses_1":0,"helmet_2":0,"pants_2":18,"shoes_1":71,"bproof_2":0,"decals_1":0,"torso_2":18,"pants_1":98,"mask_1":0,"helmet_1":-1,"arms":105,"chain_1":0}')

							TriggerEvent('skinchanger:loadClothes', skin, clothes)
						else
							local clothes = json.decode('{"mask_2":0,"bags_1":0,"shoes_2":18,"tshirt_1":5,"decals_2":0,"torso_1":259,"chain_2":0,"bproof_1":0,"bags_2":0,"glasses_2":0,"tshirt_2":0,"glasses_1":0,"helmet_2":0,"pants_2":18,"shoes_1":74,"bproof_2":0,"decals_1":0,"torso_2":18,"pants_1":101,"mask_1":0,"helmet_1":-1,"arms":117,"chain_1":0}')

							TriggerEvent('skinchanger:loadClothes', skin, clothes)
						end
					end)

					Marker.RemoveMarker('hunting_start_task')
					Marker.AddMarker('hunting_end_task', Config.StartPosition, 'Press ~INPUT_CONTEXT~ to end your hunting session.', nil, 0, 
						function()
							if CurrentVehicle ~= nil then
								ESX.Game.DeleteVehicle(CurrentVehicle)

								CurrentVehicle = nil
							end

							if HasPedGotWeapon(ped, GetHashKey('WEAPON_MUSKET'), false) then
								TriggerServerEvent('revenge-hunting:removeWeapon', GetPlayerServerId(PlayerId()))
							end

							IsHunting = false
							AddMarker = true

							if BlipAlert ~= nil then
								RemoveBlip(BlipAlert)
							end

							LastPed = nil
							BlipAlert = nil
					
							TriggerEvent('esx:showNotification', 'Your hunting session has ended. Thank you for your visit!')

							ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          						local model = nil

						        if skin.sex == 0 then
						            model = GetHashKey("mp_m_freemode_01")
						        else
						            model = GetHashKey("mp_f_freemode_01")
						        end

						        RequestModel(model)
						        
						        while not HasModelLoaded(model) do
						            RequestModel(model)
						            
						            Citizen.Wait(1)
						        end

						        SetPlayerModel(PlayerId(), model)
						        SetModelAsNoLongerNeeded(model)

						        TriggerEvent('skinchanger:loadSkin', skin)
						        TriggerEvent('esx:restoreLoadout')
						    end)

							Marker.RemoveMarker('hunting_end_task')
						end, nil, 
						{
							red = 255,
							green = 0,
							blue = 0,
							alpha = 75
						}
					)
				end
			)

			AddMarker = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		
		if IsHunting == true then
			local ped = GetPlayerPed(-1)
			local coords = GetEntityCoords(ped)

			if LastPed == nil then
				local hash = 0
				local animal = ''
				local position = {
					x = 0.0,
					y = 0.0,
					z = 0.0,
					distance = 0.0
				}
						
				local length = 0

				for k,v in pairs(HuntingModels) do
					length = length + 1
				end

				local random = math.random(length)
				local currentIndex = 1

				for k,v in pairs(HuntingModels) do
					if currentIndex == random then
						local randomSpawnpoint = math.random(#SpawnPostions)

						for i=1, #SpawnPostions, 1 do
							if i == randomSpawnpoint then
								local current = SpawnPostions[i]
								local distance = GetDistanceBetweenCoords(current.x, current.y, current.z, coords.z, coords.y, coords.z)
								
								if distance > position.distance then
									position = {
										distance = distance,
										x = current.x,
										y = current.y,
										z = current.z
									}

									hash = tonumber(k)
									animal = v.label
								end
							end
						end
					end

					currentIndex = currentIndex + 1
				end

				RequestModel(hash) 
	
				while not HasModelLoaded(hash) do
					Citizen.Wait(0)
				end

				local ped = CreatePed(28, hash, position.x, position.y, position.z, 0, true, true)

				TaskWanderStandard(ped, 0, 0)
				SetEntityAsMissionEntity(ped, false, true)

				TriggerEvent('esx:showNotification', 'A ' .. animal .. ' has been spotted.')

				LastPed = ped
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if LastPed ~= nil then
			if DoesEntityExist(LastPed) then
				local coords = GetEntityCoords(GetPlayerPed(-1))
				local targetCoords = GetEntityCoords(LastPed)
				local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, targetCoords.x, targetCoords.y, targetCoords.z)
			
				RemoveBlip(BlipAlert)

				BlipAlert = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
				     
				SetBlipSprite(BlipAlert, 433)
				SetBlipDisplay(BlipAlert, 4)
				SetBlipScale(BlipAlert, 1.5)
				SetBlipColour(BlipAlert, 6)
	    		SetBlipAsShortRange(BlipAlert, false)

	    		BeginTextCommandSetBlipName("STRING")
		    	AddTextComponentString('Hunting target')
		    	EndTextCommandSetBlipName(BlipAlert)

				if distance < 4 then
					if IsPedDeadOrDying(LastPed) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
						SetTextComponentFormat('STRING')
	     				AddTextComponentString('Press ~INPUT_CONTEXT~ to harvest the body.')
	     				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

	     				if IsControlJustPressed(0, 86) then
	     					playAnimation(nil, 'CODE_HUMAN_MEDIC_KNEEL')

	     					Citizen.Wait(1000)

							ClearPedTasks(GetPlayerPed(-1))
						
							Citizen.Wait(13000)

		     				TriggerServerEvent('revenge-hunting:harvestReward', GetPlayerServerId(PlayerId()))

		     				RemoveBlip(BlipAlert)
		     				DeleteEntity(LastPed)

		     				LastPed = nil
		     				BlipAlert = nil

		     				TriggerEvent('esx:showNotification', 'Now go find another target!')
		     			end
					end
				end
			else
				LastPed = nil
			end
		end
	end
end)

function playAnimation(group, animation)
	if group ~= nil then
		Citizen.CreateThread(function()
			RequestAnimDict(group)

			while not HasAnimDictLoaded(group) do
	        	Citizen.Wait(100)
	      	end

	      	TaskPlayAnim(GetPlayerPed(-1), group, animation, 8.0, -8, -1, 49, 0, 0, 0, 0)
		end)
	else
		TaskStartScenarioInPlace(GetPlayerPed(-1), animation, 0, true)
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)