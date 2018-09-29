ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj 
end)

-- jail command, obsolete
TriggerEvent('es:addGroupCommand', 'jail', 'mod', function(source, args, user)
	if args[1] and GetPlayerName(args[1]) ~= nil and args[2] then
		TriggerEvent('esx_jailer:sendToJail', tonumber(args[1]), tonumber(args[2] * 60))
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Invalid player ID or jail time!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Put a player in jail", params = {{name = "id", help = "target id"}, {name = "time", help = "jail time in minutes"}}})

-- unjail
TriggerEvent('es:addGroupCommand', 'unjail', 'mod', function(source, args, user)
	if args[1] and GetPlayerName(args[1]) ~= nil then
		TriggerEvent('esx_jailer:unjailQuest', tonumber(args[1]))
	else
		TriggerEvent('esx_jailer:unjailQuest', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Unjail people from jail", params = {{name = "id", help = "target id"}}})

-- send to jail and register in database
RegisterServerEvent('esx_jailer:sendToJail')
AddEventHandler('esx_jailer:sendToJail', function(source, jailTime)
	local identifier = GetPlayerIdentifiers(source)[1]
	
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			MySQL.Sync.execute("UPDATE jail SET jail_time=@jt,jail_purchased=0 WHERE identifier=@id", {['@id'] = identifier, ['@jt'] = jailTime})
		else
			MySQL.Async.execute("INSERT INTO jail (identifier,jail_time,jail_purchased) VALUES (@identifier,@jail_time,@jail_purchased)", {['@identifier'] = identifier, ['@jail_time'] = jailTime, ['@jail_purchased'] = 0})
		end
	end)
	
	TriggerClientEvent('chatMessage', -1, _U('judge'), { 147, 196, 109 }, _U('jailed_msg', GetPlayerName(source), round(jailTime / 60)))
	TriggerClientEvent('esx_jailer:jail', source, jailTime)
end)

-- should the player be in jail?
RegisterServerEvent('esx_jailer:checkjail')
AddEventHandler('esx_jailer:checkjail', function()
	local player = source -- cannot parse source to client trigger for some weird reason
	local identifier = GetPlayerIdentifiers(player)[1] -- get steam identifier
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			TriggerClientEvent('chatMessage', -1, _U('judge'), { 147, 196, 109 }, _U('jailed_msg', GetPlayerName(player), round(gotInfo[1].jail_time / 60)))
			TriggerClientEvent('esx_jailer:jail', player, tonumber(gotInfo[1].jail_time))
		end
	end)
end)

-- unjail via command
RegisterServerEvent('esx_jailer:unjailQuest')
AddEventHandler('esx_jailer:unjailQuest', function(source)
	if source ~= nil then
		unjail(source)
	end
end)

-- unjail after time served
RegisterServerEvent('esx_jailer:unjailTime')
AddEventHandler('esx_jailer:unjailTime', function()
	unjail(source)
end)

-- keep jailtime updated
RegisterServerEvent('esx_jailer:updateRemaining')
AddEventHandler('esx_jailer:updateRemaining', function(jailTime)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			MySQL.Sync.execute("UPDATE jail SET jail_time=@jt WHERE identifier=@id", {['@id'] = identifier, ['@jt'] = jailTime})
		end
	end)
end)

ESX.RegisterServerCallback('esx_jailer:useBailer', function(source, callback, currentTime, minutes)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@identifier', 
		{
			['@identifier'] = identifier
		},
		function(fetched)
			if fetched[1] ~= nil then
				local newTime = currentTime - (minutes * 60)
				local newPurchased = fetched[1].jail_purchased + (minutes * 60)
				local continue = true
				local bankAccount = xPlayer.getAccount('bank')

				if newTime < 0 then
					newTime = 0
				end

				if newPurchased > 2400 then
					newPurchased = 2400
					
					continue = false

					callback(-1)
				end


				if bankAccount.money < ((minutes / 10) * 10000) then
					continue = false

					callback(-2)
				end

				if continue == true then
					MySQL.Async.execute('UPDATE jail SET jail_time=@time, jail_purchased=@purchased WHERE identifier=@identifier',
						{
							["@identifier"] = identifier,
							["@time"] = newTime,
							["@purchased"] = newPurchased
						},
						function()
							callback(1)

							xPlayer.removeAccountMoney('bank', (minutes / 10) * 10000)

							TriggerClientEvent('chatMessage', -1, _U('judge'), { 147, 196, 109 }, _U('used_bail', GetPlayerName(source), round(newTime / 60)))
							TriggerClientEvent('esx_jailer:updateTime', source, newTime)
						end
					)
				end
			else
				callback(0)
			end
		end
	)
end)

function unjail(target)
	local identifier = GetPlayerIdentifiers(target)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			MySQL.Async.execute('DELETE from jail WHERE identifier = @id', {['@id'] = identifier})
			TriggerClientEvent('chatMessage', -1, _U('judge'), { 147, 196, 109 }, _U('unjailed', GetPlayerName(target)))
		end
	end)
	TriggerClientEvent('esx_jailer:unjail', target)
end

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end
