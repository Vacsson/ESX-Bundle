local sessions = {}
local mysql = false

TriggerEvent('mysql-hook:callback', function()
	MySQL.Async.fetchAll('SELECT * FROM apartment_sessions', {}, function(fetched)
		if fetched ~= nil then
			for i=1, #fetched, 1 do
				local row = fetched[i]

				sessions[row.owner] = {data = json.decode(row.data), players = json.decode(row.players)}
			end
		end

		mysql = true
	end)
end)

RegisterServerEvent('revenge-apartments:playerLoaded')
AddEventHandler('revenge-apartments:playerLoaded', function(source)
	CheckSession(source)
end)

function CheckSession(source)
	Citizen.CreateThread(function()
		while not mysql do
			Citizen.Wait(100)
		end

		local player = ESX.GetPlayerFromId(source)

		if player ~= nil then
			local identifier = player.getIdentifier()

			if identifier ~= nil then
				local owner = nil
				local session = nil

				if sessions[identifier] ~= nil then
					owner = identifier
					session = sessions[identifier]
				else
					for k,v in pairs(sessions) do
						if v.players ~= nil then
							for i=1, #v.players, 1 do
								if v.players[i] == identifier then
									owner = k
									session = v
								
									break
								end
							end
						end
					end
				end

				if session ~= nil and owner ~= nil then
					session.owner = owner

					ShowToSession(source, owner)

					TriggerClientEvent('revenge-apartments:joinedSession', source, session, identifier)
					TriggerClientEvent('revenge-apartments:voiceChannel', source, string.gsub(identifier, 'steam:', ''))
				end

				for k,v in pairs(sessions) do
					if k ~= owner then
						HideFromSession(source, k)
					end
				end
			end
		end
	end)
end

RegisterServerEvent('revenge-apartments:session:create')
AddEventHandler('revenge-apartments:session:create', function(source, data)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		if sessions[player.getIdentifier] == nil then
			MySQL.Async.execute('INSERT INTO apartment_sessions (owner, data, players) VALUES (@owner, @data, @players)', 
				{
					["@owner"] = player.getIdentifier(),
					["@data"] = json.encode(data),
					["@players"] = json.encode({})
				}
			)
		else
			MySQL.Async.execute('UPDATE apartment_sessions SET data = @data, players = @players WHERE owner = @owner', 
				{
					["@owner"] = player.getIdentifier(),
					["@data"] = json.encode(data),
					["@players"] = json.encode({})
				}
			)
		end

		sessions[player.getIdentifier()] = {
			["data"] = data,
			["players"] = {player.getIdentifier()}
		}
		
		TriggerClientEvent('revenge-apartments:voiceChannel', source, string.gsub(player.getIdentifier(), 'steam:', ''))

		for i=1, #ESX.GetPlayers(), 1 do
			local currentPlayer = ESX.GetPlayers()[i]

			if currentPlayer ~= source then
				HideFromSession(currentPlayer, player.getIdentifier())
			end
		end
	end
end)

RegisterServerEvent('revenge-apartments:session:delete')
AddEventHandler('revenge-apartments:session:delete', function(source, ignoreLeave)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		for i=1, #ESX.GetPlayers(), 1 do
			local currentPlayer = ESX.GetPlayers()[i]

			ShowToSession(currentPlayer, player.getIdentifier())
		end

		if sessions[player.getIdentifier()] ~= nil and sessions[player.getIdentifier()].players ~= nil then
			for i=1, #sessions[player.getIdentifier()].players, 1 do
				for i=1, #ESX.GetPlayers(), 1 do
					local currentPlayer = ESX.GetPlayerFromId(ESX.GetPlayers()[i])

					if currentPlayer.getIdentifier() == sessions[player.getIdentifier()].players[i] then
						if ESX.GetPlayers()[i] ~= source and ignoreLeave ~= true then
							TriggerClientEvent('revenge-apartments:voiceChannel', ESX.GetPlayers()[i], nil)
							TriggerClientEvent('revenge-apartments:leave', ESX.GetPlayers()[i], sessions[player.getIdentifier()])
						end
					end 
				end
			end
		end
		
		TriggerClientEvent('revenge-apartments:voiceChannel', source, nil)

		sessions[player.getIdentifier()] = nil

		MySQL.Async.execute('DELETE FROM apartment_sessions WHERE owner = @owner', 
			{
				["@owner"] = player.getIdentifier()
			}
		)
	end
end)

RegisterServerEvent('revenge-apartments:session:join')
AddEventHandler('revenge-apartments:session:join', function(source, targetSource)
	local player = ESX.GetPlayerFromId(source)
	local target = ESX.GetPlayerFromId(targetSource)

	if player ~= nil and target ~= nil then
		local players = sessions[target.getIdentifier()].players

		table.insert(players, player.getIdentifier())

		sessions[target.getIdentifier()].players = players

		ShowToSession(source, target.getIdentifier())

		TriggerClientEvent('revenge-apartments:voiceChannel', source, string.gsub(target.getIdentifier(), 'steam:', ''))
	end
end)

RegisterServerEvent('revenge-apartments:session:leave')
AddEventHandler('revenge-apartments:session:leave', function(source)
	local player = ESX.GetPlayerFromId(source)

	if player ~= nil then
		for k,v in pairs(sessions) do
			if v.players ~= nil then
				for i=1, #v.players, 1 do
					if v.players[i] == player.getIdentifier() then
						table.remove(v.players, i)

						TriggerClientEvent('revenge-apartments:voiceChannel', source, nil)

						HideFromSession(source, k)
					
						break
					end
				end
			end
		end
	end
end)

RegisterServerEvent('revenge-apartments:session:invite')
AddEventHandler('revenge-apartments:session:invite', function(source, target, apartment)
	TriggerClientEvent('revenge-apartments:gotInvite', target, source, apartment)
end)

RegisterServerEvent('revenge-apartments:session:acceptInvite')
AddEventHandler('revenge-apartments:session:acceptInvite', function(source, targetSource)
	TriggerEvent('revenge-apartments:session:join', source, targetSource)
end)

function ShowToSession(source, sessionName)
	local session = sessions[sessionName]

	if session ~= nil then
		if session.players ~= nil then
			for i=1, #session.players, 1 do
				TriggerClientEvent('revenge-apartments:show', GetIdFromIdentifier(session.players[i]), source)
			end
		else
			print("Session players was not found. This shouldn't happen. Data: ID=" .. source .. ':SESSION=' .. sessionName)
		end
	end
end

function HideFromSession(source, sessionName)
	local session = sessions[sessionName]

	if session ~= nil then
		if session.players ~= nil then
			if not table.contains(session.players, ESX.GetPlayerFromId(source).getIdentifier()) then
				for i=1, #session.players, 1 do
					TriggerClientEvent('revenge-apartments:hide', GetIdFromIdentifier(session.players[i]), source)
				end
			end
		else
			print("Session players was not found. This shouldn't happen. Data: ID=" .. source .. ':SESSION=' .. sessionName)
		end
	end
end

function GetIdFromIdentifier(identifier)
	local players = ESX.GetPlayers()
	
	for i=1, #players, 1 do
		local player = ESX.GetPlayerFromId(players[i])

		if player.getIdentifier() == identifier then
			return players[i]
		end
	end
end