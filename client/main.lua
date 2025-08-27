-----------------------------------------------------------------------------------------
-- VARIABLES --
-----------------------------------------------------------------------------------------

local custom_death_message = 'MATI LU BABI' -- Variable Pertama
local death_reason = 'BELUM JUGA PERANG, DAH MATI AJA, SITU SEHAT?'

-----------------------------------------------------------------------------------------
-- FUNCTION --
-----------------------------------------------------------------------------------------

local function checkArray(array, val)
	for name, value in ipairs(array) do
		if value == val then
			return true
		end
	end
	return false
end

local function GET_WEAPON_LABEL(hash)
    if(type(hash) ~= "string") then
        hash = tostring(hash)
    end

    local label = Config.weaponhashtable[hash]
    if label ~= nil then
        return label
    end

    return "WT_INVALID" -- Return the invalid label
end

local function ShowDeathScreen(death_reason, custom_death_message)
	sf = RequestScaleformMovieWithIgnoreSuperWidescreen("HACKING_MESSAGE")
	while (not HasScaleformMovieLoaded(sf)) do
		Wait(0)
	end
	BeginScaleformMovieMethod(sf, 'SET_DISPLAY')
	ScaleformMovieMethodAddParamInt(4)
	ScaleformMovieMethodAddParamPlayerNameString(custom_death_message)
	ScaleformMovieMethodAddParamPlayerNameString(death_reason)
	ScaleformMovieMethodAddParamInt(255)
	ScaleformMovieMethodAddParamInt(0)
	ScaleformMovieMethodAddParamInt(0)
	ScaleformMovieMethodAddParamBool(false)
	EndScaleformMovieMethod()

    CreateThread(function()
        while exports['69_jobs']:isDead() do
            Wait(0)
            DrawScaleformMovieFullscreen(sf, 255, 255, 255, 255, 0)
        end
        SetScaleformMovieAsNoLongerNeeded(sf)
    end)
end
exports('ShowDeathScreen', ShowDeathScreen)

-----------------------------------------------------------------------------------------
-- EVENTS --
-----------------------------------------------------------------------------------------

AddEventHandler('naufal-deathscreen:client:onplayerdeath', function(datal)
    local death
    local kb = nil
    local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, -2067956739, 1141786504, -102323637, -1834847097, -102973651, -656458692, -581044007, -1951375401, -538741184, -1810795771, 419712736, -853065399 }
    local Bullet = { 453432689, 1593441988, 584646201, 2578377531, 324215364, 736523883, 4024951519, 3220176749, 2210333304, 2937143193, 2634544996, 2144741730, 487013001, 2017895192, 3800352039, 2640438543, 911657153, 100416529, 205991906, 856002082, 2726580491, 1305664598, 2982836145, 1119849093, 3218215474, 1627465347, 3231910285, 3523564046, 2132975508, 137902532, 2828843422, 984333226, 3342088282, 1672152130, 171789620, 3249783761, 1649403952, 3173288789, 0xCB96392F, 0x97EA20B8, 0x2B5EF5EC, 0x917F6C8C, 0x57A4368C, 0x78A97CD0, 0x5A96BA4, 0x9D1F17E6, 0x394F415C, 0xFAD1F1C9, 0x969C3D67, 0x84D6FAFD, 0xA914799, 0xBFE256D4, 0x88374054, `WEAPON_REVOLVER_MK269`, `WEAPON_DOUBLEACTION69`, `WEAPON_CERAMICPISTOL`, `WEAPON_PISTOL5069`, `WEAPON_MICROSMG69` }
    local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
    local Car = { 133987706, -1553120962 }
    local Animal = { -100946242, 148160082 }
    local FallDamage = { -842959696 }
    local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
    local Gas = { -1600701090 }
    local Burn = { 615608432, 883325847, -544306709 }
    local Drown = { -10959621, 1936677264 }

    local playerPed = PlayerPedId()
    death = datal.deathCause
    local killer_server_id = datal.killerServerId
    
    if checkArray (Melee, death) then
        kb = "menggunakan "..GET_WEAPON_LABEL(death)
    elseif checkArray (Bullet, death) then
        kb = "menggunakan "..GET_WEAPON_LABEL(death)
    elseif checkArray (Knife, death) then
        kb = "menggunakan "..GET_WEAPON_LABEL(death)
    elseif checkArray (Car, death) then
        kb = "karena tertabrak kendaraan"
    elseif checkArray (Animal, death) then
        kb = "karena digigit hewan"
    elseif checkArray (FallDamage, death) then
        kb = "bunuh diri"
    elseif checkArray (Explosion, death) then
        kb = "terkena ledakan"
    elseif checkArray (Gas, death) then
        kb = "keracunan gas"
    elseif checkArray (Burn, death) then
        kb = "terbakar"
    elseif checkArray (Drown, death) then
        kb = "tenggelam"
    else
        kb = "tidak diketahui"
    end

    killer = GetPedSourceOfDeath(playerPed)

    local sec_message = "Kamu telah dibunuh oleh "..GetPlayerName(datal.killerClientId).. " "..kb.." "

    if(datal.killerClientId) then
        sec_message = "Kamu telah dibunuh oleh "..GetPlayerName(datal.killerClientId).. " "..kb.." "
    else
        sec_message = "Kamu mati karena "..kb.." "
    end

    death_message  = sec_message
    sec_message = 'BELUM JUGA PERANG, DAH MATI AJA, SITU SEHAT?'

    local success, custom_death_message = lib.callback.await('tdm:server:getcustomdeathmessage', false, killer_server_id)

    if not success then
        ShowDeathScreen(death_message, 'Sixnine Death Message')
    else
        ShowDeathScreen(death_message, custom_death_message)
    end
end)

-----------------------------------------------------------------------------------------
-- DEBUG COMMAND --
-----------------------------------------------------------------------------------------

if Config.Debug then
    RegisterCommand('tstds', function(source, args, rawCommands)
        ShowDeathScreen('MATI LU BABI', 'BELUM JUGA PERANG, DAH MATI AJA, SITU SEHAT?')
    end)
end
