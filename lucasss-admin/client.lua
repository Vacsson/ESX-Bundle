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
local debug = false

RegisterNetEvent('revenge-admin:coordinates')
AddEventHandler('revenge-admin:coordinates', function()
	local coords = GetEntityCoords(GetPlayerPed(-1))
	local heading = GetEntityHeading(GetPlayerPed(-1))

	TriggerServerEvent('revenge-admin:logMessage', '[INFO] {["x"] = ' .. coords.x .. ', ["y"] = ' .. coords.y .. ', ["z"] = ' .. (coords.z - 1.0) .. ', ["heading"] = ' .. heading .. '}')
end)

RegisterNetEvent('revenge-admin:clothes')
AddEventHandler('revenge-admin:clothes', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
    	local clothes = {
    		["tshirt_1"] = true,
    		["tshirt_2"] = true,
    		["torso_1"] = true,
    		["torso_2"] = true,
    		["decals_1"] = true,
    		["decals_2"] = true,
    		["arms"] = true,
    		["shoes_1"] = true,
    		["shoes_2"] = true,
    		["pants_1"] = true,
    		["pants_2"] = true,
    		["mask_1"] = true,
    		["mask_2"] = true,
    		["bproof_1"] = true,
    		["bproof_2"] = true,
    		["chain_1"] = true,
    		["chain_2"] = true,
    		["helmet_1"] = true,
    		["helmet_2"] = true,
    		["glasses_1"] = true,
    		["glasses_2"] = true,
    		["bag_1"] = true,
    		["bag_2"] = true
    	} 

    	local currentClothes = {}
    	
    	for k,v in pairs(skin) do
    		if clothes[k] then
    			currentClothes[k] = v
    		end
    	end

		TriggerServerEvent('revenge-admin:logMessage', '[INFO] ' .. json.encode(currentClothes))
	end)
end)