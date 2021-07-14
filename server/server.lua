ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterCommand('hospital', 'user', function(xPlayer, args, showError)
	if xPlayer.job.name == "ambulance" then
		local duration = args.duration
		if duration == nil or duration < 10 then
			duration = 10
		elseif duration > Config.MaxTime then
			duration = Config.MaxTime
		end

		local targetPlayer = ESX.GetPlayerFromId(args.target)
		for k,v in ipairs(targetPlayer.loadout) do
			targetPlayer.removeWeapon(v.name)
		end

		TriggerClientEvent('chatMessage', -1, '[EMS]', { 0, 128, 255 }, " " .. GetPlayerName(args.target) ..' hospitalized for '.. duration ..' seconds by [' .. xPlayer.job.grade_label .. '] ' .. xPlayer.name )
		
		local location = args.location
		if location == nil then
			location = Config.DefaultLocation
		end
		targetPlayer.triggerEvent("bixbi_hospital:send", duration, location)
	end
end, true, {help = 'Send person to hospital.', validate = false, arguments = {
	{name = 'target', help = 'Player ID', type = 'number'},
	{name = 'duration', help = 'Seconds', type = 'number'},
	{name = 'location', help = 'P = Pillbox, S = Sandy, B = Paleto Bay', type = 'string'}
}})

ESX.RegisterCommand('unhospital', 'user', function(xPlayer, args, showError)
	if xPlayer.job.name == "ambulance" then
		local targetPlayer = ESX.GetPlayerFromId(args.target)
		targetPlayer.triggerEvent("bixbi_hospital:release")
	end
end, true, {help = 'Release person from hospital.', validate = false, arguments = {
	{name = 'target', help = 'Player ID', type = 'number'}
}})

AddEventHandler('onResourceStart', function(resourceName)
	if (GetResourceState('bixbi_core') ~= 'started' ) then
        print('Bixbi_HospitalTP - ERROR: Bixbi_Core hasn\'t been found! This could cause errors!')
        StopResource(resourceName)
    end
end)