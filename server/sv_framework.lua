b = { Framework = nil }
function b:GetFramework()
    if (self.Framework) then return end
    if (not Config.Framework or Config.Framework == '') then print("^3[bixbi_hospitaltp]^7 You must set your Framework in sh_config.lua") end

    Config.Framework = Config.Framework:upper() -- Makes framework checks use ALL CAPS. To remove case-sensitivity issues.
    if (Config.Framework == "ESX") then
        self.PlayerLoaded = 'esx:playerLoaded'
        TriggerEvent("esx:getSharedObject", function(obj) self.Framework = obj end)
    elseif (Config.Framework == "QBCORE") then
        self.PlayerLoaded = 'QBCore:Server:PlayerLoaded'
        self.Framework = exports['qb-core']:GetCoreObject()
    else
        -- Add in your framework related code here.
    end
end

function b:RegisterCommands()
    if (Config.Framework == "ESX") then
        self['Framework'].RegisterCommand('hospital', 'user'), function(xPlayer, args, showError)
            if (self.GetPlayerJob(xPlayer) ~= Config.Job or not args.target or args.duration) then return end
            self:Hospital(source, args.target, args.duration, args.location)
        end, false, {help = 'Send person to hospital.', arguments = {
            {name = 'target', help = 'Player ID', type = 'number'},
            {name = 'duration', help = 'Minutes', type = 'number'},
            {name = 'location', help = 'P = Pillbox, S = Sandy, B = Paleto Bay', type = 'string'}
        }})
        
        self['Framework'].RegisterCommand('unhospital', 'user', function(xPlayer, args, showError)
            if (xPlayer.job.name ~= Config.Job or not args.target) then return end
            TriggerClientEvent('bixbi_hospitaltp:Release', args.target)
        end, true, {help = 'Release person from hospital.', validate = false, arguments = {
            {name = 'target', help = 'Player ID', type = 'number'}
        }})

    elseif (Config.Framework == "QBCORE") then
        self['Framework'].Commands.Add('hospital', 'Send person to hospital', { { name = 'target', help = 'Player ID' }, { name = 'duration', help = 'Minutes' }, { name = 'location', help = 'P = Pillbox, S = Sandy, B = Paleto Bay' } }, false, function(source, args)
            local target, duration, player = args[1] or source, args[2] or 5, self:GetPlayerFromId(source)
            -- local duration = args[2] or 5
            -- local player = self:GetPlayerFromId(source)
            if (not player) return end
            if (self.GetPlayerJob(player) ~= Config.Job) then return end
            self:Hospital(source, target, duration, args[3])
        end, 'user')

        self['Framework'].Commands.Add('unhospital', 'Release person from hospital.', { { name = 'target', help = 'Player ID' } }, false, function(source, args)
            local target, player = args[1] or source, self:GetPlayerFromId(source)
            -- local player = self:GetPlayerFromId(source)
            if (not player) return end
            if (self.GetPlayerJob(player) ~= Config.Job) then return end
            TriggerClientEvent('bixbi_hospitaltp:Release', target)
        end, 'user')
    else
        -- Add in your framework related code here.
    end
end

function b:GetPlayerFromId(id)
    if (Config.Framework == "ESX") then
        return self['Framework'].GetPlayerFromId(id)
    elseif (Config.Framework == "QBCORE") then
        return self['Framework'].Functions.GetPlayer(id)
    else
        -- Add in your framework related code here.
    end
end

function b:GetPlayers()
    if (Config.Framework == "ESX") then
        return self['Framework'].Game.GetPlayers()
    elseif (Config.Framework == "QBCORE") then
        return self['Framework'].Functions.GetPlayers()
    else
        -- Add in your framework related code here.
    end
end

function b.GetPlayerJob(player)
    if (not player) then return end
    if (Config.Framework == "ESX") then
        return player.job.name
    elseif (Config.Framework == "QBCORE") then
        return player.PlayerData.job.name
    else
        -- Add in your framework related code here.
    end
end

function b.GetPlayerServerId(player)
    if (not player) then return end
    if (Config.Framework == "ESX") then
        return player.playerId
    elseif (Config.Framework == "QBCORE") then
        return player.PlayerData.source
    else
        -- Add in your framework related code here.
    end
end

function b.GetPlayerName(player)
    if (not player) then return end
    if (Config.Framework == "ESX") then
        return player.name
    elseif (Config.Framework == "QBCORE") then
        return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    else
        -- Add in your framework related code here.
    end
end

function b.PlayerAddItem(player, item, count)
    if (not player or not item) then return end
    count = count or 1
    if (Config.Framework == "ESX") then
        player.addInventoryItem(item, count)
        return true
    elseif (Config.Framework == "QBCORE") then
        player.Functions.AddItem(item, count)
    else
        -- Add in your framework related code here.
    end
end