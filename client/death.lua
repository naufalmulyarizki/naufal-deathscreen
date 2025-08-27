-----------------------------------------------------------------------------------------
-- EVENTS --
-----------------------------------------------------------------------------------------

AddEventHandler("gameEventTriggered", function(event, data)
    if event ~= "CEventNetworkEntityDamage" then
        return
    end
    local victim, victimDied = data[1], data[4]
    if not IsPedAPlayer(victim) then
        return
    end
    local player = PlayerId()
    local playerPed = PlayerPedId()
    if victimDied and NetworkGetPlayerIndexFromPed(victim) == player and (IsPedDeadOrDying(victim, true) or IsPedFatallyInjured(victim)) then
        local killerEntity, deathCause = GetPedSourceOfDeath(playerPed), GetPedCauseOfDeath(playerPed)
        local killerClientId = NetworkGetPlayerIndexFromPed(killerEntity)
        if killerEntity ~= playerPed and killerClientId and NetworkIsPlayerActive(killerClientId) then
            PlayerKilledByPlayer(GetPlayerServerId(killerClientId), killerClientId, deathCause)
        else
            PlayerKilled(deathCause)
        end
    end
end)

-----------------------------------------------------------------------------------------
-- FUNCTION --
-----------------------------------------------------------------------------------------

function PlayerKilledByPlayer(killerServerId, killerClientId, deathCause)
    local victimCoords = GetEntityCoords(PlayerPedId())
    local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
    local distance = #(victimCoords - killerCoords)

    local data = {
        victimCoords = { x = lib.math.round(victimCoords.x, 1), y = lib.math.round(victimCoords.y, 1), z = lib.math.round(victimCoords.z, 1) },
        killerCoords = { x = lib.math.round(killerCoords.x, 1), y = lib.math.round(killerCoords.y, 1), z = lib.math.round(killerCoords.z, 1) },

        killedByPlayer = true,
        deathCause = deathCause,
        distance = lib.math.round(distance, 1),

        killerServerId = killerServerId,
        killerClientId = killerClientId,
    }

    TriggerEvent("naufal-deathscreen:client:onplayerdeath", data)
    TriggerServerEvent("naufal-deathscreen:client:onplayerdeath", data)
end

function PlayerKilled(deathCause)
    local playerPed = PlayerPedId()
    local victimCoords = GetEntityCoords(playerPed)

    local data = {
        victimCoords = { x = lib.math.round(victimCoords.x, 1), y = lib.math.round(victimCoords.y, 1), z = lib.math.round(victimCoords.z, 1) },

        killedByPlayer = false,
        deathCause = deathCause,
    }

    TriggerEvent("naufal-deathscreen:client:onplayerdeath", data)
    TriggerServerEvent("naufal-deathscreen:client:onplayerdeath", data)
end