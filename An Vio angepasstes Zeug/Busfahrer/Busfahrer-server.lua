--[[

	Busfahrer
	© Xendom Rayden

]]--

Busfahrer = {vehicle = {}};
Busfahrer.pickup = createPickup(-2226.2053222656,252.05731201172,35.3203125,3,1239,50);

addEventHandler("onPickupHit",Busfahrer.pickup,function(player)
	if(not(isPedInVehicle(player)))then
		if(getElementDimension(player) == 0)then
			triggerClientEvent(player,"Busfahrer.client",player);
		end
	end
end)

addEvent("Busfahrer.start",true)
addEventHandler("Busfahrer.start",root,function()
	if(vioGetElementData(player,"job") ~= "Busfahrer")then vioSetElementData(player,"job","Busfahrer")end
	
	Busfahrer.vehicle[client] = createVehicle(431,-2267.6945800781,168.17590332031,35.414100646973,0,0,270);
	setVehicleLocked(Busfahrer.vehicle[client],true);
	warpPedIntoVehicle(client,Busfahrer.vehicle[client]);
	triggerClientEvent(client,"Busfahrer.createMarker",client);
	
	addEventHandler("onVehicleExit",Busfahrer.vehicle[client],function(player)
		Busfahrer.stop(player);
	end)
	
	addEventHandler("onVehicleExplode",Busfahrer.vehicle[client],function(player)
		destroyElement(Busfahrer.vehicle[player]);
	end)
end)

function Busfahrer.stop(player)
	infobox(player,"Du hast den Job\nbeendet!",5000,255,0,0);
	destroyElement(Busfahrer.vehicle[player]);
	setTimer(function(player)
		setElementPosition(player,-2226.2053222656,252.05731201172,35.3203125);
	end,100,1,player)
	triggerClientEvent(player,"Busfahrer.destroy",player,"points");
end
addEvent("Busfahrer.stop",true)
addEventHandler("Busfahrer.stop",root,Busfahrer.stop)

addEvent("Busfahrer.server",true)
addEventHandler("Busfahrer.server",root,function()
	setElementFrozen(getPedOccupiedVehicle(client),true);
	infobox(client,"Haltestelle\nWarte einen Moment...",3500,0,255,0);
	setTimer(function(client)
		local money = math.random(4,8) * 50;
		setElementFrozen(getPedOccupiedVehicle(client),false);
		givePlayerSaveMoney(client,money);
		infobox(client,"Du hast $"..money.." erhalten.",5000,0,255,0);
	end,3500,1,client)
end)

addEventHandler("onPlayerQuit",root,function()
	if(isElement(Busfahrer.vehicle[source]))then
		destroyElement(Busfahrer.vehicle[source]);
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if(isElement(Busfahrer.vehicle[source]))then
		destroyElement(Busfahrer.vehicle[source]);
		triggerClientEvent(source,"Busfahrer.destroy",source);
	end
end)