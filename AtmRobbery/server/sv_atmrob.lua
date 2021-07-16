ESX 						   = nil
local connectedPolice       	   = 0
local playerConnected = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Count Police
function CountPolice()
	local xPlayers = ESX.GetPlayers()
	connectedPolice = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			connectedPolice = connectedPolice + 1
		end
	end
	
	SetTimeout(60000, CountPolice)
end

CountPolice()

ESX.RegisterUsableItem('usb', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if connectedPolice >= Config.RequiredCops then
        TriggerClientEvent('nb_atmrob:client:ATMCheck', source)
    else
        xPlayer.showNotification(_U('There are not enough cops in the city.', Config.RequiredCops))
    end
end)

RegisterServerEvent('nb_atmrob:server:getcash')
AddEventHandler('nb_atmrob:server:getcash', function(dalto, atm)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cash = math.random(Config.Lowest,Config.MaxCash)
    if atm and dalto then 
        if Config.BlackMoney then 
            xPlayer.addAccountMoney('black_money', cash)
        else
            xPlayer.addMoney(cash)
        end
        xPlayer.removeInventoryItem('usb', 1)
        xPlayer.showNotification(_U('You got the cash. Now Run!', cash))
    else
        xPlayer.removeInventoryItem('usb', 1)
    end
end)