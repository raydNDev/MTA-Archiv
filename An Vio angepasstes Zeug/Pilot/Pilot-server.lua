--[[

	Pilot
	© Xendom Rayden

]]--

Pilot = {vehicle = {}, dim = 0};
Pilot.pickup = createPickup(-1409.26318, -298.13553, 14.14844,3,1239,50);

addEventHandler("onPickupHit",Pilot.pickup,function(player)
	if(not(isPedInVehicle(player)))then
		if(getElementDimension(player) == 0)then
			triggerClientEvent(player,"Pilot.client",player);
		end
	end
end)

addEvent("Pilot.server",true)
addEventHandler("Pilot.server",root,function()
	if(vioGetElementData(client,"job") ~= "Pilot")then vioSetElementData(player,"job","Pilot")end
	Pilot.vehicle[client] = createVehicle(577,-1644.1955566406,-151.17489624023,13.148400306702,0,0,315.34692382813);
	warpPedIntoVehicle(client,Pilot.vehicle[client]);
	Pilot.dim = Pilot.dim + 1;
	setElementDimension(Pilot.vehicle[client],Pilot.dim);
	setElementDimension(client,Pilot.dim);
	triggerClientEvent(client,"Pilot.createMarker",client,"create");
end)

addEvent("Pilot.finish",true)
addEventHandler("Pilot.finish",root,function()
	destroyElement(Pilot.vehicle[client]);
	local money = math.random(400,500);
	givePlayerSaveMoney(client,money);
	infobox(client,"Passagiere erfolgreich\ntransportiert, du\nerhältst $"..money..".",5000,0,255,0);
	setTimer(function(client)
		setElementPosition(client,-1409.26318, -298.13553, 14.14844);
		setElementDimension(client,0);
	end,100,1,client)
end)

addEventHandler("onPlayerQuit",root,function()
	if(isElement(Pilot.vehicle[source]))then
		destroyElement(Pilot.vehicle[source]);
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if(isElement(Pilot.vehicle[source]))then
		destroyElement(Pilot.vehicle[source]);
		triggerClientEvent(source,"Pilot.createMarker",source);
	end
end)