local escape = false
local unjail = false
local jailTime = 0
local JailLocation = Config.JailLocation

--ESX base
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(3500)

	if ESX.IsPlayerLoaded() == true then
		PlayerData = ESX.GetPlayerData()
	end

	Marker.AddMarker('bail_marker', Config.BailLocation, 'Press ~INPUT_CONTEXT~ to open the bail menu.', nil, 0, 
		function()
			OpenBailMenu()
		end, 
		function()
			ESX.UI.Menu.CloseAll()
		end
	)	
end)

function OpenBailMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'bail_menu',
		{
			title = 'Bail Menu',
			align = 'top-left',
			elements = {
				{
					label = 'Lower Jail Time (-10 minutes) $20,000',
					value = 10
				},
				{
					label = 'Lower Jail Time (-20 minutes) $40,000',
					value = 20
				},
				{
					label = 'Lower Jail Time (-30 minutes) $60,000',
					value = 30
				},
				{
					label = 'Lower Jail Time (-40 minutes) $80,000',
					value = 40
				}
			}
		},
		function(data, menu)
			ESX.TriggerServerCallback('esx_jailer:useBailer', function(id)
				if id == 0 then
					TriggerEvent('esx:showNotification', '~r~You are not in jail!')
				elseif id == -1 then
					TriggerEvent('esx:showNotification', '~r~You can not lower your jailtime more than 40 minutes.')
				elseif id == -2 then
					TriggerEvent('esx:showNotification', '~r~You do not have enough money.')				
				elseif id == 1 then
					TriggerEvent('esx:showNotification', '~g~Successfully lowered your jailtime for ' .. data.current.value .. ' minutes.')
				end
			end, jailTime, data.current.value)
		end,
		function(data, menu)
			menu.close()
		end
	)
end

RegisterNetEvent("esx_jailer:jail")
AddEventHandler("esx_jailer:jail", function(time)
	jailTime = time
	
	if escape == true then
		return
	end

	local sourcePed = GetPlayerPed(-1)
	
	if DoesEntityExist(sourcePed) then
		Citizen.CreateThread(function()
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].female)
				end
			end)
			
			-- Clear player
			SetPedArmour(sourcePed, 0)
			ClearPedBloodDamage(sourcePed)
			ResetPedVisibleDamage(sourcePed)
			ClearPedLastWeaponDamage(sourcePed)
			ResetPedMovementClipset(sourcePed, 0)
			
			SetEntityCoords(sourcePed, JailLocation.x, JailLocation.y, JailLocation.z)
			escape = true
			unjail = false
			while jailTime > 0 and not unjail do
				sourcePed = GetPlayerPed(-1)
				RemoveAllPedWeapons(sourcePed, true)
				if IsPedInAnyVehicle(sourcePed, false) then
					ClearPedTasksImmediately(sourcePed)
				end
				
				if jailTime % 60 == 0 then
					TriggerEvent('chatMessage', _U('judge'), { 147, 196, 109 }, _U('remaining_msg', round(jailTime / 60)))
					TriggerServerEvent('esx_jailer:updateRemaining', jailTime)
				end
				
				Citizen.Wait(20000)
				
				-- Is the player trying to escape?
				if GetDistanceBetweenCoords(GetEntityCoords(sourcePed), JailLocation.x, JailLocation.y, JailLocation.z) > 50.0001 then
					SetEntityCoords(sourcePed, JailLocation.x, JailLocation.y, JailLocation.z)
					TriggerEvent('chatMessage', _U('judge'), { 147, 196, 109 }, _U('escape_attempt'))
				end
				
				jailTime = jailTime - 20
			end
			
			-- jail time served
			TriggerServerEvent('esx_jailer:unjailTime', -1)
			SetEntityCoords(sourcePed, Config.JailBlip.x, Config.JailBlip.y, Config.JailBlip.z)
			
			escape = false
			
			-- Change back the user skin
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end)
	end
end)

RegisterNetEvent("esx_jailer:unjail")
AddEventHandler("esx_jailer:unjail", function(source)
	unjail = true
end)

RegisterNetEvent("esx_jailer:updateTime")
AddEventHandler("esx_jailer:updateTime", function(time)
	jailTime = time
end)

AddEventHandler('skinchanger:modelLoaded', function(spawn)
	TriggerServerEvent('esx_jailer:checkjail')
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.JailBlip.x, Config.JailBlip.y, Config.JailBlip.z)
	SetBlipSprite(blip, 237)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.5)
	SetBlipColour(blip, 1)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end