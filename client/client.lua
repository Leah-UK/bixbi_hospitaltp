local hosDuration = 0
local location = nil
RegisterNetEvent('esx:playerLoaded')
AddEventHandler("esx:playerLoaded", function(xPlayer)
	while (ESX == nil) do
        Citizen.Wait(100)
    end
	
    ESX.PlayerData = xPlayer
 	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

function InHospital()
	Citizen.CreateThread(function()
		while (location ~= nil) do
			if hosDuration > 0 then
				hosDuration = hosDuration - 1
				
				local playerPed = PlayerPedId()
				local distance = #(GetEntityCoords(playerPed) - location.incoords)

				if distance > location.distance and Config.CheckDistance then
					SetEntityCoords(playerPed, location.incoords)
					hosDuration = hosDuration + 30 -- 30 seconds.
					if hosDuration > Config.MaxTime then
						hosDuration = Config.MaxTime
					end
					exports['bixbi_core']:Notify('', 'Your hospital stay time was extended as you were not officially discharged.', 10000)
				end
	
				if hosDuration == 10 or hosDuration == 30 or hosDuration == 60 or hosDuration == 120 or hosDuration == 300 then
					exports['bixbi_core']:Notify('', 'You have ' .. hosDuration .. ' seconds left in hospital.', 10000)
				end
			elseif location ~= nil then
				TriggerEvent("bixbi_hospital:release")
			end
			Citizen.Wait(1000)
		end
	end)
end

RegisterNetEvent("bixbi_hospital:send")
AddEventHandler("bixbi_hospital:send", function(duration, inputLocation)
	local loc = Config.Locations[inputLocation:upper()]
	if loc ~= nil then
		local playerPed = PlayerPedId()
		if DoesEntityExist(playerPed) then
			
			DoScreenFadeOut(2000)
			Citizen.Wait(2000)

			InHospital()
			location = loc
			hosDuration = duration

			SetEntityCoords(playerPed, loc.incoords)
			RemoveAllPedWeapons(playerPed, true)
			if IsPedInAnyVehicle(playerPed, false) then
				ClearPedTasksImmediately(playerPed)
			end

			exports['bixbi_core']:Notify('', 'You have been sent to ' .. loc.label .. ' for ' .. duration .. ' seconds.')
			TriggerEvent('chatMessage', '[EMS]', { 0, 128, 255 }, ' You have been sent to ' .. loc.label .. ' for ' .. duration .. ' seconds.')
		
			Citizen.Wait(1500)
			DoScreenFadeIn(2000)
			if Config.CheckDistance == false then
				exports['bixbi_core']:Loading(duration * 1000, 'You are being observed by the medical team.')
			else
				exports['bixbi_core']:Loading(3000, 'Welcome to ' .. loc.label .. '.')
			end
		end
	else
		hosDuration = 0
		location = {}
	end
end)

RegisterNetEvent("bixbi_hospital:release")
AddEventHandler("bixbi_hospital:release", function()
	SetEntityCoords(PlayerPedId(), location.outcoords)

	exports['bixbi_core']:Notify('', 'You have been released from ' .. location.label .. '.')

	hosDuration = 0
	location = nil
end)