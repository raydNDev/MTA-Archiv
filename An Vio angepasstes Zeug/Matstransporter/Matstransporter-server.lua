--[[

	Matstransporter
	© Xendom Rayden

]]--

Matstransporter = {active = false};
Matstransporter.pickup = createPickup(-2616.06396, 188.89139, 4.35713,3,1239,50);

addEventHandler("onPickupHit",Matstransporter.pickup,function(player)
	if(not(isPedInVehicle(player)))then
		if(getElementDimension(player) == 0 and isEvil(player))then
			triggerClientEvent(player,"Matstransporter.client",player);
		end
	end
end)

addEvent("Matstransporter.server",true)
addEventHandler("Matstransporter.server",root,function()
	if(isEvil(client))then
		if(getDistanceBetweenPoints3D(-2616.06396, 188.89139, 4.35713,getElementPosition(client)) <= 5)then
			if(Matstransporter.active == false)then
				setTimer(function()
					Matstransporter.destroy();
					Matstransporter.active = false;
					outputChatBox("Es kann wieder ein Matstransporter gestartet werden!",root,175,0,0);
				end,3600000,1)
				Matstransporter.vehicle = createVehicle(455,2229.22656, -1356.91101, 25.02301,0,0,0);
				Matstransporter.marker = createMarker(2238.02100, -1302.81506, 24.91024,"checkpoint",3,0,255,0);
				Matstransporter.blip = createBlip(2238.02100, -1302.81506, 24.91024,0,2,255,0,0);
				warpPedIntoVehicle(client,Matstransporter.vehicle);
				outputChatBox("Ein Matstransporter wurde beladen!",root,175,0,0);
				
				addEventHandler("onVehicleExplode",Matstransporter.vehicle,function(client)
					Matstransporter.destroy();
					outputChatBox("Der Matstransporter ist explodiert!",root,175,0,0);
				end)
				
				addEventHandler("onMarkerHit",Matstransporter.marker,function(client)
					if(getElementType(client) == "vehicle")then
						local client = getVehicleOccupant(client,0);
						if(getPedOccupiedVehicleSeat(client) == 0 and getPedOccupiedVehicle(client) == Matstransporter.vehicle)then
							outputChatBox("Der Matstransporter wurde abgegeben!",root,175,0,0);
							outputChatBox("Für die Abgabe erhältst du 1000 Materialien.",client,0,175,0);
							vioSetElementData(client,"mats",vioGetElementData(client,"mats")+1000);
							Matstransporter.destroy();
						end
					end
				end)
			else infobox(client,"Vor kurzem wurde\nbereits ein\nMatstransporter gestartet!",5000,255,0,0)end
		end
	end
end)

function Matstransporter.destroy()
	if(isElement(Matstransporter.marker))then
		destroyElement(Matstransporter.marker);
		destroyElement(Matstransporter.vehicle);
		destroyElement(Matstransporter.blip);
	end
end