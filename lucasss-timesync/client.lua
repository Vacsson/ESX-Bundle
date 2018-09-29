RegisterNetEvent('revenge-timesync:updateTime')
AddEventHandler('revenge-timesync:updateTime', function(hours, minutes, seconds)
	NetworkOverrideClockTime(hours, minutes, seconds)
end)