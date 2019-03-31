--[[

	Carrob
	2016 - 2018
	© Xendom Rayden

]]--

Carrob = {active = false, gateState = false};
Carrob.gate = createObject(17951,2505.5,-1691,14.300000190735,0,0,270);
Carrob.marker = createMarker(2505.3999023438,-1688.3000488281,12.5,"cylinder",3,0,0,0,0);

addEventHandler("onMarkerHit",Carrob.marker,function(player)
	if(isEvil(player))then
		if(Carrob.gateState == false)then
			Carrob.gateState = true;
			moveObject(Carrob.gate,5000,2505.5,-1691.9000244141,16.10000038147,0,90,0);
			setTimer(function()
				outputChatBox("Die Garage des Innenministers wurde ausgeraubt!",root,175,0,0);
			end,10000,1)
		end
	end
end)

function Carrob.createVehicle()
	Carrob.destroy();
	
	Carrob.vehicle = createVehicle(421,2505.5,-1695.0999755859,13.60000038147,0,0,0);
	setVehicleColor(Carrob.vehicle,200,200,200);
	Carrob.arrow = createMarker(0,0,0,"arrow",0.6,200,0,0);
	attachElements(Carrob.arrow,Carrob.vehicle,0,0,1.8);
	setElementFrozen(Carrob.vehicle,true);
	
	addEventHandler("onVehicleEnter",Carrob.vehicle,function(player)
		if(isEvil(player))then
			if(getPedOccupiedVehicleSeat(player) == 0)then
				setElementFrozen(source,false);
				Carrob.abgabeMarker = createMarker(-311.60000610352,2666.6999511719,62.700000762939,"checkpoint",3,200,0,0);
				Carrob.abgabeBlip = createBlip(-311.60000610352,2666.6999511719,62.700000762939,0,2,255,0,0);
				setElementVisibleTo(Carrob.abgabeMarker,root,false);
				setElementVisibleTo(Carrob.abgabeBlip,root,false);
				setElementVisibleTo(Carrob.abgabeMarker,player,true);
				setElementVisibleTo(Carrob.abgabeBlip,player,true);
				
				addEventHandler("onMarkerHit",Carrob.abgabeMarker,function(player)
					if(isEvil(player))then
						local veh = getPedOccupiedVehicle(player);
						if(veh and veh == Carrob.vehicle)then
							if(getPedOccupiedVehicleSeat(player) == 0)then
								outputChatBox("Das gestohlene Fahrzeug wurde abgegeben!",root,175,0,0);
								infobox(player,"Für die Abgabe\ndes Fahrzeugs\nerhältst du $10.000.",5000,0,255,0);
								givePlayerSaveMoney(player,10000);
								Carrob.destroy();
							end
						end
					end
				end)
				
				setTimer(function()
					Carrob.createVehicle();
					moveObject(Carrob.gate,5000,2505.5,-1691,14.300000190735,0,-90,0);
				end,3600000,1)
			end
		end
	end)
	
	addEventHandler("onVehicleExit",Carrob.vehicle,function(player)
		setElementVisibleTo(Carrob.abgabeMarker,player,false);
		setElementVisibleTo(Carrob.abgabeBlip,player,false);
	end)
	
	addEventHandler("onVehicleExplode",Carrob.vehicle,function(player)
		outputChatBox("Das gestohlene Fahrzeug wurde zerstört aufgefunden!",root,175,0,0);
		Carrob.destroy();
	end)
end

function Carrob.destroy()
	if(isElement(Carrob.vehicle))then
		destroyElement(Carrob.vehicle);
		destroyElement(Carrob.abgabeMarker);
		destroyElement(Carrob.abgabeBlip);
		destroyElement(Carrob.arrow);
	end
end

Carrob.createVehicle();