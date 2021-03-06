--[[

    Airplanedealer • v1.0

    This script was made by Pablo1610 
        
    Twitch: https://twitch.tv/pablo_1610)

    Discord: https://discord.gg/Ksyc97N

]]

ESX = nil
TriggerEvent(trigger, function(obj) ESX = obj end) -- REMPLACEZ CETTE LIGNE EN FONCTION DE VOTRE SERVEUR !

local availableVehicles = {}

local function dispatchEmbed(content)
	local embeds = {
		{
			["title"]=content,
			["type"]="rich",
			["color"] =2061822,
			["footer"]=  {
				["text"]= "esx_airplanedealer",
		   },
		}
	}
	  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = "Airplanedealer",embeds = embeds}), { ['Content-Type'] = 'application/json' })
	
end

local function getLicense(_src)
    for k,v in pairs(GetPlayerIdentifiers(_src)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
end

Citizen.CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM avaible_aeronef ORDER BY avaible_aeronef.price DESC", {}, function(rslt)
        for k, v in pairs(rslt) do
            table.insert(availableVehicles, v)
        end
    end)
end)

RegisterCommand("refreshAeronef", function(source)
    if source == 0 then
        MySQL.Async.fetchAll("SELECT * FROM avaible_aeronef ORDER BY avaible_aeronef.price DESC", {}, function(rslt)
            for k, v in pairs(rslt) do
                table.insert(availableVehicles, v)
            end
        end)
    end
end, false)



RegisterNetEvent("esx_aerodealer:requestVehicles")
AddEventHandler("esx_aerodealer:requestVehicles", function()
    local _src = source
    TriggerClientEvent("esx_aerodealer:callbackVehicles", _src, availableVehicles)
end)

RegisterNetEvent("esx_aerodealer:buyVehicle")
AddEventHandler("esx_aerodealer:buyVehicle", function(buyID, vehicleData)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local price = availableVehicles[buyID].price
    if xPlayer.getMoney() < price then
        TriggerClientEvent("esx_aerodealer:serverCallback", _src, false)
        return
    end
    xPlayer.removeMoney(price)
    local time = os.time()
    local date = os.date("*t", time).day.."/"..os.date("*t", time).month.."/"..os.date("*t", time).year.." à "..os.date("*t", time).hour.."h"..os.date("*t", time).min
    MySQL.Async.execute("INSERT INTO owned_aeronef (license,model,props,ownedAt) VALUES (@a,@b,@c,@d)",
    {
        ['a'] = getLicense(_src),
        ['b'] = availableVehicles[buyID].model,
        ['c'] = json.encode(vehicleData),
        ['d'] = date
    }, function()
        TriggerClientEvent("esx_aerodealer:serverCallback", _src, true)
        dispatchEmbed("User "..GetPlayerName(_src).. " (||"..getLicense(_src).."||) purchased "..availableVehicles[buyID].label.." for "..availableVehicles[buyID].price)
    end)
end)

RegisterNetEvent("esx_aerodealer:vehicleBackToGarage")
AddEventHandler("esx_aerodealer:vehicleBackToGarage", function(vehID,owner)
    MySQL.Async.execute("UPDATE owned_aeronef SET outside = 0 WHERE id = @a",
    {['a'] = vehID}, function()   
    end)
end)

RegisterNetEvent("esx_aerodealer:requestOwnedAeronefs")
AddEventHandler("esx_aerodealer:requestOwnedAeronefs", function()
    local _src = source
    local license = getLicense(_src)
    local result = {}
    MySQL.Async.fetchAll("SELECT * FROM owned_aeronef WHERE license = @a", {['a'] = license}, function(rslt)
        for k,v in pairs(rslt) do
            table.insert(result, v)
        end
        TriggerClientEvent("esx_aerodealer:callbackAeronefs", _src, result)
    end)
end)

RegisterNetEvent("esx_aerodealer:outFromGarage")
AddEventHandler("esx_aerodealer:outFromGarage", function(vehID)
    local _src = source
    MySQL.Async.execute("UPDATE owned_aeronef SET outside = 1 WHERE id = @a",
    {['a'] = vehID}, function()   
        TriggerClientEvent("esx_aerodealer:okOut", _src)
    end)
end)

