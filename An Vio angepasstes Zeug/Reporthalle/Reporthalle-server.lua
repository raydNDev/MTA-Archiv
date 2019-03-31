--[[

	Reporthalle
	2016 - 2018
	© Xendom Rayden

]]--

Reporthalle = {koordinaten = {}};
Reporthalle.pickup = createPickup(2545.54175, -1512.86365, -12.32031, 3, 1239, 1);

addEventHandler("onPickupHit",Reporthalle.pickup,function(player)
	if(getElementDimension(player) == getElementDimension(source))then
		if(vioGetElementData(player,"adminlvl") == 0)then
			infobox(player,"Tippe /hilfe, um\nein Teammitglied\nzu kontaktieren.",5000,0,255,0);
		end
	end
end)

addCommandHandler("report",function(player)
	if(getElementInterior(player) == 0 and getElementDimension(player) == 0)then
		if(not(isPedInVehicle(player)))then
			if(vioGetElementData(player,"Reporthalle") ~= true)then
				local x,y,z = getElementPosition(player);
				Reporthalle.koordinaten[player] = {x,y,z};
				if(vioGetElementData(player,"adminlvl") >= 1)then
					setElementPosition(player,2547.79175, -1520.68982, -12.32031);
				else
					setElementPosition(player,2570.48926, -1523.93347, -12.32031);
				end
				infobox(player,"Tippe /leavereport,\num die Reporthalle\nzu verlassen.",5000,0,255,0);
				vioSetElementData(player,"Reporthalle",true);
				toggleControl(player,"fire",false);
			end
		else infobox(player,"Nur außerhalb von\nFahrzeugen möglich!",5000,255,0,0)end
	else infobox(player,"Nur außerhalb von\nInnenräumen und\nin Dimension\n0 möglich!",5000,255,0,0)end
end)

addCommandHandler("hilfe",function(player)
	if(vioGetElementData(player,"Reporthalle") == true and vioGetElementData(player,"adminlvl") == 0)then
		for _,v in pairs(getElementsByType("player"))do
			if(vioGetElementData(v,"adminlvl") >= 1)then
				outputChatBox("[ADMIN]: "..getPlayerName(player).." benötigt Hilfe! Tippe /report, um zu ihm zu gelangen.",v,200,200,0);
			end
		end
		infobox(player,"Alle Teammitglieder,\ndie online sind,\nwurden benachrichtigt.",5000,0,255,0);
	end
end)

addCommandHandler("leavereport",function(player)
	if(vioGetElementData(player,"Reporthalle") == true)then
		setElementPosition(player,Reporthalle.koordinaten[player][1],Reporthalle.koordinaten[player][2],Reporthalle.koordinaten[player][3]);
		vioSetElementData(player,"Reporthalle",false);
		toggleControl(player,"fire",true);
	end
end)