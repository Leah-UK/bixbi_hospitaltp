ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('hospital', 'user', function(xPlayer, args, showError)
	if xPlayer.job.name == "ambulance" then
		TriggerEvent("bixbi_hospital:send", args.target, args.duration, args.location)
	end
end, true, {help = 'Send person to hospital.', validate = false, arguments = {
	{name = 'target', help = 'Player ID', type = 'number'},
	{name = 'duration', help = 'Minutes', type = 'number'},
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

RegisterServerEvent('bixbi_hospitaltp:Hospital')
AddEventHandler('bixbi_hospitaltp:Hospital', function(targetId, duration, location)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(targetId)

	-- for k,v in ipairs(xTarget.loadout) do
	-- 	xTarget.removeWeapon(v.name)
	-- end
	if (Config.OxInventory) then TriggerEvent('ox_inventory:disarm', targetId) end
	for k, v in pairs(Config.Items) do exports.bixbi_core:addItem(targetId, k, v) end

	if (duration == nil) then duration = 5 end
	if (duration > Config.MaxTime) then duration = Config.MaxTime end
	if location == nil then location = Config.DefaultLocation end

	local chatMessage = xTarget.name ..' hospitalized for '.. duration ..' minute(s) by [' .. xPlayer.job.grade_label .. '] ' .. xPlayer.name
	for k, v in pairs(ESX.GetExtendedPlayers()) do
		if (v.job.name == 'police' or v.job.name == 'ambulance') then
			TriggerClientEvent('chatMessage', v.playerId, '[EMS] ', { 0, 128, 255 }, chatMessage)
		end
	end

    duration = duration * 60000
	TriggerClientEvent('bixbi_hospital:send', targetId, duration, location)
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetResourceState('bixbi_core') ~= 'started' ) then
        print('Bixbi_HospitalTP - ERROR: Bixbi_Core hasn\'t been found! This could cause errors!')
        StopResource(resourceName)
    end
end)