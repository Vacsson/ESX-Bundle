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

local IsCuffed = false
local DraggedBy = nil
local WasDragged = false
local EngineToggle = false

ESX = nil
PlayerData = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj

			if ESX.IsPlayerLoaded() == true then
				PlayerData = ESX.GetPlayerData()
			end
		end)

		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX ~= nil then
			local ped = GetPlayerPed(-1)

			if IsControlPressed(0, Keys["L"]) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'citizen_interaction') then
				OpenCitizenInteraction()
			end

			if IsControlPressed(0, Keys["M"]) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'vehicle_interaction') then
				OpenVehicleInteraction()
			end

			if IsCuffed and DraggedBy ~= nil then
				if DoesEntityExist(DraggedBy) then
					AttachEntityToEntity(GetPlayerPed(-1), DraggedBy, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

					WasDragged = true
				end
			else
				if WasDragged then
					DetachEntity(GetPlayerPed(-1), true, false)

					WasDragged = false
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = GetPlayerPed(-1)

		if IsCuffed then
			if not IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', true) then
				if not HasAnimDictLoaded('mp_arresting') then
					RequestAnimDict('mp_arresting')

			      	while not HasAnimDictLoaded('mp_arresting') do
			        	Citizen.Wait(50)
			      	end
			    end
			      	
			    TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
			end
			
			DisableControlAction(0, 23, true) -- Enter Car
		    DisableControlAction(0, 44, true) -- Cover
		    DisableControlAction(0, 105, true) -- Hands Up
		    DisableControlAction(0, 140, true) -- Melee attack
		    DisableControlAction(0, 167, true) -- F6
		    DisableControlAction(0, 170, true) -- F3
		    DisableControlAction(0, 288, true) -- F1
		    DisableControlAction(0, 289, true) -- F2
		    DisableControlAction(0, 24, true) -- Attack
		    DisableControlAction(0, 66, true) -- Shoot
		    DisableControlAction(0, 37, true) -- TAB
		    DisableControlAction(0, 73, true) -- X
		    DisableControlAction(0, 25, true) -- Aim
		    DisableControlAction(0, 303, true) -- U
		end

		if EngineToggle then
			local coords = GetEntityCoords(ped)
			local vehicle = nil

			if IsPedInAnyVehicle(ped,  false) then
	    		vehicle = GetVehiclePedIsIn(ped, false)
	 		elseif IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
	    		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	  		end

	  		if vehicle ~= nil then
				if not Citizen.InvokeNative(0xAE31E7DF9B5B132E, vehicle) then
			  		SetVehicleUndriveable(vehicle, true)		
			  	end
			end
		end
	end
end)

function OpenCitizenInteraction()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', 
		{
			title = 'Citizen Menu',
			align = 'top-left',
			elements = {
				{label = 'Search', value = 'search'},
				{label = 'ID menu', value = 'id_card_menu'},
				{label = 'Handcuff', value = 'handcuff'},
				{label = 'Blindfold', value = 'blindfold'},
				{label = 'Unlock Handcuffs', value = 'uncuff'},
				{label = 'Drag', value = 'drag'},
				{label = 'Accessories', value = 'accessories'}
			}
		},
		function(data, menu)
			local ped = GetPlayerPed(-1)

			if data.current.value == 'accessories' then
				TriggerEvent('esx_accessories:openMenu')
			elseif data.current.value == 'search' then
				local target = GetNearestPlayer()

				if target ~= nil then
					OpenBodySearchMenu(target)
				else
					TriggerEvent('esx:showNotification', 'No ~r~players ~w~nearby.')
				end	
			elseif data.current.value == 'handcuff' then
				local target = GetNearestPlayer()

				if target ~= nil then
					TriggerServerEvent('revenge-interactionmenu:handcuff', GetPlayerServerId(PlayerId()), GetPlayerServerId(target), true)
				else
					TriggerEvent('esx:showNotification', 'No ~r~players ~w~nearby.')
				end
			elseif data.current.value == 'blindfold' then
				local player, distance = ESX.Game.GetClosestPlayer()

				if distance ~= -1 and distance <= 3.0 then
					ESX.TriggerServerCallback('jsfour-blindfold:itemCheck', function( hasItem )
						TriggerServerEvent('jsfour-blindfold', GetPlayerServerId(player), hasItem)
					end)
				else
					ESX.ShowNotification('No ~r~players ~w~nearby.')
				end
			elseif data.current.value == 'uncuff' then
				local target = GetNearestPlayer()

				if target ~= nil then
					TriggerServerEvent('revenge-interactionmenu:uncuff', GetPlayerServerId(PlayerId()), GetPlayerServerId(target), true)
				else
					TriggerEvent('esx:showNotification', 'No ~r~players ~w~nearby.')
				end
			elseif data.current.value == 'drag' then
				local target = GetNearestPlayer()

				if target ~= nil then
					TriggerServerEvent('revenge-interactionmenu:drag', GetPlayerServerId(target), GetPlayerServerId(PlayerId()))
				else
					TriggerEvent('esx:showNotification', 'No ~r~players ~w~nearby.')
				end
			elseif data.current.value == 'id_card_menu' then
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'id_card_menu',
					{
						title    = 'ID meny',
						elements = {
							{label = 'Check your ID', value = 'check'},
							{label = 'Show your ID', value = 'show'}
						}
					},
					function(data2, menu2)
						if data2.current.value == 'check' then
							TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
						elseif data2.current.value == 'show' then
							local player, distance = ESX.Game.GetClosestPlayer()

							if distance ~= -1 and distance <= 3.0 then
								TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
							else
								ESX.ShowNotification('No ~r~players ~w~nearby.')
							end
						end
					end,
					function(data2, menu2)
						menu2.close()
					end
				)
			end
		end, 
		function(data, menu)
			menu.close()
		end
	)
end
function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

    local elements = {}

    local blackMoney = 0

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

    table.insert(elements, {
      label          = _U('confiscate_dirty') .. blackMoney,
      value          = 'black_money',
      itemType       = 'item_account',
      amount         = blackMoney
    })

    table.insert(elements, {label = '--- Vapen ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = _U('confiscate') .. ESX.GetWeaponLabel(data.weapons[i].name),
        value          = data.weapons[i].name,
        itemType       = 'item_weapon',
        amount         = data.weapons[i].ammo,
      })
    end

    table.insert(elements, {label = _U('inventory_label'), value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end

	RequestAnimDict('mini@repair')

	while not HasAnimDictLoaded('mini@repair') do
		Citizen.Wait(1)
	end

	TaskPlayAnim(GetPlayerPed(-1), 'mini@repair', 'fixing_a_ped', 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        title    = _U('search'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then

          TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)

          OpenBodySearchMenu(player)

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, GetPlayerServerId(player))
end

function OpenVehicleInteraction()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', 
		{
			title = 'Vehicle Menu',
			align = 'top-left',
			elements = {
				{label = 'Engine', value = 'engine'},
				{label = 'Lock', value = 'lock'},
				{label = 'Doors', value = 'doors'},
				{label = 'Windows', value = 'windows'}
			}
		},
		function(data, menu)
			local ped = GetPlayerPed(-1)
			local coords = GetEntityCoords(ped)
			local vehicle = nil

			if IsPedInAnyVehicle(ped,  false) then
	    		vehicle = GetVehiclePedIsIn(ped, false)
	 		elseif IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
	    		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	  		end

	  		if vehicle ~= nil then
	  			if data.current.value == 'engine' then
	  				local toggle = Citizen.InvokeNative(0xAE31E7DF9B5B132E, vehicle)

	  				EngineToggle = toggle

	  				SetVehicleEngineOn(vehicle, not toggle)
	  			elseif data.current.value == 'lock' then
	  				TriggerEvent('revenge-garage:fetchMetadata', vehicle, function(metadata)
						if metadata.owned then
							local status = GetVehicleDoorLockStatus(vehicle)

			  				if status == 1 then 
								SetVehicleDoorsLocked(vehicle, 2)
								PlayVehicleDoorCloseSound(vehicle, 1)

								TriggerEvent('esx:showNotification', 'You ~r~locked ~w~your vehicle')
							elseif status == 2 then 
								SetVehicleDoorsLocked(vehicle, 1)
								PlayVehicleDoorOpenSound(vehicle, 0)

								TriggerEvent('esx:showNotification', 'You ~g~unlocked ~w~your vehicle')
							end
						else
							TriggerEvent('esx:showNotification', '~r~This is not your vehicle')
						end
					end, GetVehicleNumberPlateText(vehicle))
	  			elseif data.current.value == 'doors' then
	  				menu.close()

	  				OpenVehicleInteractionDoors(vehicle)
	  			elseif data.current.value == 'windows' then
	  				menu.close()

	  				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction_windows',
	  					{
	  						title = 'Windows',
	  						align = 'top-left',
	  						elements = {
	  							{label = 'Roll up', value = 'up'},
	  							{label = 'Roll down', value = 'down'}
	  						}
	  					},
	  					function(data, menu)
	  						if data.current.value == 'up' then		
				  				RollUpWindow(vehicle, 0)
								RollUpWindow(vehcile, 1)
	  						else
				  				RollDownWindow(vehicle, 0)
								RollDownWindow(vehcile, 1)
	  						end
	  					end,
	  					function(data, menu)
	  						menu.close()

	  						OpenVehicleInteraction()
	  					end
	  				)
	  			end
	  		else
	  			TriggerEvent('esx:showNotification', 'You need to be near your ~g~vehicle')
	  		end
		end, 
		function(data, menu)
			menu.close()
		end
	)
end

function OpenVehicleInteractionDoors(vehicle)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction_doors',
		{
			title = 'Windows',
			align = 'top-left',
			elements = {
				{label = 'Hood', value = 'hood'},
				{label = 'Trunk', value = 'trunk'},
				{label = 'Front Doors', value = 'front'},
				{label = 'Rear Doors', value = 'rear'},
				{label = 'All Doors', value = 'all'},
			}
		},
		function(data, menu)
			if data.current.value == 'hood' then		
				if GetVehicleDoorAngleRatio(vehicle, 4) > 0.0 then 
	            SetVehicleDoorShut(vehicle, 4, false)
	        else
	            SetVehicleDoorOpen(vehicle, 4, false)      
	       end
			elseif data.current.value == 'trunk' then
				if GetVehicleDoorAngleRatio(vehicle, 5) > 0.0 then 
	            SetVehicleDoorShut(vehicle, 5, false)
	        else
	            SetVehicleDoorOpen(vehicle, 5, false)      
	       end
			elseif data.current.value == 'all' then
				if GetVehicleDoorAngleRatio(vehicle, 1) > 0.0 then 
		        SetVehicleDoorShut(vehicle, 5, false)        
		        SetVehicleDoorShut(vehicle, 4, false)
		        SetVehicleDoorShut(vehicle, 3, false)
		        SetVehicleDoorShut(vehicle, 2, false)
		        SetVehicleDoorShut(vehicle, 1, false)
		        SetVehicleDoorShut(vehicle, 0, false)         
	        else
		        SetVehicleDoorOpen(vehicle, 5, false)        
		        SetVehicleDoorOpen(vehicle, 4, false)
		        SetVehicleDoorOpen(vehicle, 3, false)
		        SetVehicleDoorOpen(vehicle, 2, false)
		        SetVehicleDoorOpen(vehicle, 1, false)
		        SetVehicleDoorOpen(vehicle, 0, false)  
	       end
			elseif data.current.value == 'front' then
				menu.close()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rear_doors', 
					{
						title = 'Rear Doors',
						align = 'top-left',
						elements = {
							{label = 'Left Door', value = 'left'},
							{label = 'Right Door', value = 'right'}
						}
					},
					function(data, menu)
						if data.current.value == 'left' then
							if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 then 
         						SetVehicleDoorShut(vehicle, 0, false)
	      					else
						        SetVehicleDoorOpen(vehicle, 0, false)
						    end
						else
							if GetVehicleDoorAngleRatio(vehicle, 1) > 0.0 then 
         						SetVehicleDoorShut(vehicle, 1, false)
	      					else
						        SetVehicleDoorOpen(vehicle, 1, false)
						    end
						end
					end,
					function(data, menu)
						menu.close()
						
						OpenVehicleInteractionDoors(vehicle)
					end
				)
			elseif data.current.value == 'rear' then
				menu.close()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rear_doors', 
					{
						title = 'Rear Doors',
						align = 'top-left',
						elements = {
							{label = 'Left Door', value = 'left'},
							{label = 'Right Door', value = 'right'}
						}
					},
					function(data, menu)
						if data.current.value == 'left' then
							if GetVehicleDoorAngleRatio(vehicle, 2) > 0.0 then 
         						SetVehicleDoorShut(vehicle, 2, false)
	      					else
						        SetVehicleDoorOpen(vehicle, 2, false)
						    end
						else
							if GetVehicleDoorAngleRatio(vehicle, 3) > 0.0 then 
         						SetVehicleDoorShut(vehicle, 3, false)
	      					else
						        SetVehicleDoorOpen(vehicle, 3, false)
						    end
						end
					end,
					function(data, menu)
						menu.close()
						
						OpenVehicleInteractionDoors(vehicle)
					end
				)
			end
		end,
		function(data, menu)
			menu.close()

			OpenVehicleInteraction()
		end
	)
end

-- Öppnar/stänger ögonbindel
RegisterNetEvent('jsfour-blindfold')
AddEventHandler('jsfour-blindfold', function( hasItem, src )
	if not open and hasItem then
		TriggerEvent('skinchanger:getSkin', function(skin)
			local clothesSkin = {
				['mask_1'] = 54, ['mask_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)
		open = true
		SendNUIMessage({
			action = "open"
		})
	elseif open then
		TriggerEvent('skinchanger:getSkin', function(skin)
			local clothesSkin = {
				['mask_1'] = 0, ['mask_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)
		open = false
		SendNUIMessage({
			action = "close"
		})
		TriggerServerEvent('jsfour-blindfold:giveItem', src)
	else
		TriggerServerEvent('jsfour-blindfold:notis', src)
	end
end)

RegisterNetEvent('revenge-interactionmenu:handcuff')
AddEventHandler('revenge-interactionmenu:handcuff', function()
	local ped = GetPlayerPed(-1)
	
	IsCuffed = true
	DraggedBy = nil

    SetEnableHandcuffs(ped, true)
    SetPedCanPlayGestureAnims(ped, false)
end)

RegisterNetEvent('revenge-interactionmenu:uncuff')
AddEventHandler('revenge-interactionmenu:uncuff', function()
	local ped = GetPlayerPed(-1)

	IsCuffed = false
	DraggedBy = nil

	ClearPedSecondaryTask(ped)

    SetEnableHandcuffs(ped, false)
    SetPedCanPlayGestureAnims(ped, true)
end)

RegisterNetEvent('revenge-interactionmenu:drag')
AddEventHandler('revenge-interactionmenu:drag', function(ped)
	if DraggedBy == nil then
		local players = ESX.Game.GetPlayers()

		for i=0, #players, 1 do
			local player = players[i]

			if GetPlayerServerId(player) == ped then
				DraggedBy = GetPlayerPed(player)
			end
		end
	else
		DraggedBy = nil
	end
end)

function GetNearestPlayer()
	local ped, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then
    	return ped
    end

    return nil
end