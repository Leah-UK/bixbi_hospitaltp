function b.Notify(title, text, type)
    -- Replace code with your own notify script if you wish to change the default.
    lib.notify({title = title, description = text, type = type})
end
RegisterNetEvent('bixbi_hospitaltp:Notify', b.Notify)

b.hosDuration = 0
b.location = nil
function b:InHospital()
	Citizen.CreateThread(function()
		while (self['location'] ~= nil and self['Framework'].PlayerLoaded) do
			if (self['hosDuration'] > 0) then
				self['hosDuration'] -= 1
				
				local playerPed = PlayerPedId()
				local distance = #(GetEntityCoords(playerPed) - self['location'].incoords)

				if (distance > b['location'].distance and Config.CheckDistance) then
					SetEntityCoords(playerPed, self['location'].incoords)
					self['hosDuration'] += 30 -- 30 seconds.
					if (self['hosDuration'] > Config.MaxTime) then self['hosDuration'] = Config.MaxTime end
                    self.Notify('Hospital', 'Your hospital stay time was extended as you were not officially discharged.', 'error')
				end

			elseif (self['location'] ~= nil) then
				self:Release()
			end
			Citizen.Wait(1000)
		end
	end)
end

function b:Send(duration, inputLocation)
    local loc = Config.Locations[inputLocation:upper()]
	if (loc ~= nil) then
		local playerPed = PlayerPedId()
		if (DoesEntityExist(playerPed)) then
			
			DoScreenFadeOut(2000)
			Citizen.Wait(2000)

			self:InHospital()
			self['location'] = loc
			self['hosDuration'] = duration

			SetEntityCoords(playerPed, self['location'].incoords)
			RemoveAllPedWeapons(playerPed, true)
			if (IsPedInAnyVehicle(playerPed, false)) then ClearPedTasksImmediately(playerPed) end

            self.Notify('Hospital', 'You have been sent to ' .. self['location'].label .. ' for ' .. duration / 60000 .. ' minute(s).', 'error')
			TriggerEvent('chatMessage', '[EMS]', { 0, 128, 255 }, ' You have been sent to ' .. self['location'].label .. ' for ' .. duration / 60000 .. ' minute(s).')
		
			Citizen.Wait(1500)
			DoScreenFadeIn(2000)
		end
	else
		self['location'] = {}
        self['hosDuration'] = 0
	end
end
function SendToHospital(duration, inputLocation) then b:Send(duration, inputLocation) end
RegisterNetEvent('bixbi_hospitaltp:Send', SendToHospital)

function b:Release()
    SetEntityCoords(PlayerPedId(), self['location'].outcoords)
    self.Notify('Hospital', 'You have been released from ' .. self['location'].label .. '.')

	self['hosDuration'] = 0
	self['location'] = nil
end
function ReleaseFromHospital() then b:Release() end
RegisterNetEvent('bixbi_hospitaltp:Release', ReleaseFromHospital)