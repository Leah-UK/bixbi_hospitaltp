AddEventHandler('onResourceStart', function(resourceName)
    if (resourceName ~= GetCurrentResourceName()) then return end
    b:GetFramework()
    b:RegisterCommands()
end)

function b:Hospital(source, targetId, duration, location)
    local player = self:GetPlayerFromId(source)
    local target = self:GetPlayerFromId(targetId)

    for k, v in pairs(Config.Items) do 
        self.PlayerAddItem(target, k, v)
    end

    duration = duration or 5
    if (duration > Config.MaxTime) then duration = Config.MaxTime end
    location = location or Config.DefaultLocation

    local chatMessage = self.GetPlayerName(target) ..' hospitalized for '.. duration ..' minute(s) by ' .. self.GetPlayerName(player)
    if (Config.SendMessageToJob) then
        for k, v in pairs(self:GetPlayers()) do
            print(k)
            print(v)
            local jobName = self.GetPlayerJob(v)
            if (jobName == Config.Job) then
                TriggerClientEvent('chatMessage', self.GetPlayerServerId(v), '[EMS] ', { 0, 128, 255 }, chatMessage)
            end
        end
    end
    duration = duration * 60000
    TriggerClientEvent('bixbi_hospitaltp:Send', targetId, duration, location)
end