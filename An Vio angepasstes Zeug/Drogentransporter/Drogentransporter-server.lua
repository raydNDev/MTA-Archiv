--[[

	Drogentransporter
	© Xendom Rayden

]]--

Drogentransporter = {active = false};
Drogentransporter.pickup = createPickup(2230.97510, -1367.22095, 23.99219,3,1239,50);

addEventHandler("onPickupHit",Drogentransporter.pickup,function(player)
	if(not(isPedInVehicle(player)))then
		if(getElementDimension(player) == 0 and isEvil(player))then
			infobox(player,"Tippe\n/drogentransporter, um\neinen\nDrogentransporter\nzu starten.",5000,0,255,0);
		end
	end
end)

addCommandHandler("drogentransporter",function(player)
	if(isEvil(player))then
		if(getDistanceBetweenPoints3D(2230.97510, -1367.22095, 23.99219,getElementPosition(player)) <= 5)then
			if(Drogentransporter.active == false)then
				Drogentransporter.active = true;
				setTimer(function()
					Drogentransporter.destroy();
					Drogentransporter.active = false;
					outputChatBox("Es kann wieder ein Drogentransporter gestartet werden!",root,175,0,0);
				end,3600000,1)
				Drogentransporter.vehicle = createVehicle(455,2229.22656, -1356.91101, 25.02301,0,0,0);
				Drogentransporter.marker = createMarker(2238.02100, -1302.81506, 24.91024,"checkpoint",3,0,255,0);
				Drogentransporter.blip = createBlip(2238.02100, -1302.81506, 24.91024,0,2,255,0,0);
				warpPedIntoVehicle(player,Drogentransporter.vehicle);
				outputChatBox("Ein Drogentransporter wurde beladen!",root,175,0,0);
				
				addEventHandler("onVehicleExplode",Drogentransporter.vehicle,function(player)
					Drogentransporter.destroy();
					outputChatBox("Der Drogentransporter ist explodiert!",root,175,0,0);
				end)
				
				addEventHandler("onMarkerHit",Drogentransporter.marker,function(player)
					if(getElementType(player) == "vehicle")then
						local player = getVehicleOccupant(player,0);
						if(getPedOccupiedVehicleSeat(player) == 0 and getPedOccupiedVehicle(player) == Drogentransporter.vehicle)then
							outputChatBox("Der Drogentransporter wurde abgegeben!",root,175,0,0);
							outputChatBox("Für die Abgabe erhältst du 4000g Drogen.",player,0,175,0);
							vioSetElementData(player,"drugs",vioGetElementData(player,"drugs")+4000);
							Drogentransporter.destroy();
						end
					end
				end)
			else infobox(player,"Vor kurzem wurde\nbereits ein\nDrogentransporter gestartet!",5000,255,0,0)end
		end
	end
end)

function Drogentransporter.destroy()
	if(isElement(Drogentransporter.marker))then
		destroyElement(Drogentransporter.marker);
		destroyElement(Drogentransporter.vehicle);
		destroyElement(Drogentransporter.blip);
	end
end