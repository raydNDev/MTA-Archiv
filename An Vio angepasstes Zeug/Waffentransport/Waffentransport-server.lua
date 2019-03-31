--[[

	Waffentransport
	2016 - 2018
	© Xendom Rayden

]]--

Waffentransport = {active = false, playerInMarker = 0, boat = {},
	["Spawn"] = {
		{2099.201171875,-112.3106918335,5.9608282754198e-09,0,0,107.32873535156},
		{2094.8483886719,-107.27894592285,5.9608282754198e-09,0,0,107.32543945313},
		{2095.9990234375,-101.02433013916,5.9608282754198e-09,0,0,107.32543945313},
	},
};
Waffentransport.marker = createMarker(2160.5832519531,-98.377586364746,2.8080148696899-1,"cylinder",3,0,200,0);

addEventHandler("onMarkerHit",Waffentransport.marker,function(player)
	if(not(isPedInVehicle(player)))then
		if(getElementDimension(player) == 0 and isEvil(player))then
			if(Waffentransport.playerInMarker <= 3)then
				Waffentransport.playerInMarker = Waffentransport.playerInMarker + 1;
				setElementData(player,"inWaffentransportMarker",true);
				if(Waffentransport.playerInMarker >= 3)then
					triggerClientEvent(player,"Waffentransport.client",player);
				end
			end
		end
	end
end)

addEventHandler("onMarkerLeave",Waffentransport.marker,function(player)
	if(getElementData(player,"inWaffentransportMarker") == true)then
		setElementData(player,"inWaffentransportMarker",false);
		Waffentransport.playerInMarker = Waffentransport.playerInMarker - 1;
	end
end)

addEvent("Waffentransport.server",true)
addEventHandler("Waffentransport.server",root,function()
	if(Waffentransport.active == false)then
		if(Waffentransport.playerInMarker >= 1)then
			local counter = 0;
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"inWaffentransportMarker") == true)then
					counter = counter + 1;
					local tbl = Waffentransport["Spawn"][counter];
					setElementData(v,"inWaffentransportMarker",false);
					Waffentransport.boat[counter] = createVehicle(473,tbl[1],tbl[2],tbl[3],tbl[4],tbl[5],tbl[6]);
					setElementData(Waffentransport.boat[counter],"Waffentransport",true);
					warpPedIntoVehicle(v,Waffentransport.boat[counter]);
					triggerClientEvent(v,"Waffentransport.clientMarker",v,"create");
					
					addEventHandler("onVehicleEnter",Waffentransport.boat[counter],function(player)
						if(getPedOccupiedVehicleSeat(player) == 0)then
							triggerClientEvent(player,"Waffentransport.clientMarker",v,"create");
						end
					end)
					
					addEventHandler("onVehicleExit",Waffentransport.boat[counter],function(player)
						triggerClientEvent(player,"Waffentransport.clientMarker",player);
					end)
					
					addEventHandler("onVehicleExplode",Waffentransport.boat[counter],function()
						destroyElement(source);
					end)
					
					if(counter >= 1)then break end
				end
			end
			Waffentransport.active = true;
			setTimer(function()
				Waffentransport.active = false;
				outputChatBox("Es kann wieder ein Waffentransport gestartet werden!",175,0,0);
				for i = 1,3 do
					if(isElement(Waffentransport.boat[i]))then
						destroyElement(Waffentransport.boat[i]);
					end
				end
				for _,v in pairs(getElementsByType("player"))do
					triggerClientEvent(v,"Waffentransport.clientMarker",v);
				end
			end,3600000,1)
		else infobox(client,"Es müssen mindestens\ndrei böse\nFraktionisten im\nMarker sein!",5000,255,0,0)end
	else infobox(client,"Vor kurzem wurde\nbereits ein\nWaffentransport\ngestartet!",5000,255,0,0)end
end)

addEvent("Waffentransport.serverAbgabe",true)
addEventHandler("Waffentransport.serverAbgabe",root,function()
	local veh = getPedOccupiedVehicle(client);
	if(veh and getElementData(veh,"Waffentransport") == true)then
		destroyElement(veh);
		triggerClientEvent(client,"Waffentransport.clientMarker",client);
		giveWeapon(client,24,50,true);
		giveWeapon(client,29,250,true);
		giveWeapon(client,31,250,true);
		giveWeapon(client,33,25,true);
		infobox(client,"Du hast den\nWaffentransporter\nerfolgreich abgegeben.",5000,0,255,0);
	end
end)

addEventHandler("onPlayerWasted",root,function()
	triggerClientEvent(source,"Waffentransport.clientMarker",source);
end)