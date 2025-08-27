-----------------------------------------------------------------------------------------
-- VARIABLES --
-----------------------------------------------------------------------------------------

local QBCore = exports['qb-core']:GetCoreObject()

-----------------------------------------------------------------------------------------
-- CALLBACK --
-----------------------------------------------------------------------------------------

lib.callback.register('tdm:server:getcustomdeathmessage', function(source, target)
    local src = source
    local Player = QBCore.Functions.GetPlayer(target)
    if not Player then return end
    local cid = Player.PlayerData.citizenid
    local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', { cid })
    if result[1] then 
        return true, result[1].custom_deathmessage
    else
        return false, 'Sixnine Death Message'
    end
end)

-----------------------------------------------------------------------------------------
-- COMMAND --
-----------------------------------------------------------------------------------------

lib.addCommand('setdeathmsg', {
    help = 'Set Death Message FFA',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target Player',
        },
        {
            name = 'msg',
            type = 'longString',
            help = 'Message',
        },
    },
}, function(source, args, raw)
    local src = source
    local target = args.target
    local newMessage = args.msg
    local Player = QBCore.Functions.GetPlayer(target) 
    if not Player then return end
    
    exports.oxmysql:execute('UPDATE players SET custom_deathmessage = ? WHERE citizenid = ?', { newMessage, Player.PlayerData.citizenid }, function(affectedRows)
        if affectedRows then
            TriggerClientEvent('chat:addMessage', src, {
                color = {0, 255, 0},
                args = {"System", "Custom death message player berhasil diupdate!"}
            })
        end
    end)
end)