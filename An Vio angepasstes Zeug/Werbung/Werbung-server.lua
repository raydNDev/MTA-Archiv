--[[

	Werbung
	© Xendom Rayden

]]--

Werbung = {timer = {}};
Werbung.pickup = createPickup(-2464.1770019531,788.2529296875,35.171875,3,1239,50);

addEventHandler("onPickupHit",Werbung.pickup,function(player)
	if(not(isPedInVehicle(player)))then
		if(getElementDimension(player) == 0)then
			triggerClientEvent(player,"Werbung.client",player);
		end
	end
end)

addEvent("Werbung.server",true)
addEventHandler("Werbung.server",root,function(text,cash)
	local cash = tonumber(cash);
	if(getDistanceBetweenPoints3D(-2464.1770019531,788.2529296875,35.171875,getElementPosition(client)) <= 5)then
		if(not(isTimer(Werbung.timer[client])))then
			if(vioGetElementData(client,"money") >= cash)then
				takePlayerSaveMoney(client,cash);
				outputChatBox("Werbung von "..getPlayerName(client).." (Telefon: "..vioGetElementData(client,"telenr").."): "..text,root,0,175,0);
				Werbung.timer[client] = setTimer(function(client)
					infobox(client,"Du kannst nun wieder\neine Werbung schalten.",5000,0,175,0);
				end,60000,1,client)
			else infobox(client,"Du benötigst $"..cash.."\nauf der Hand!",5000,255,0,0)end
		else infobox(client,"Du kannst nur\nalle 60 Sekunden eine\nWerbung schalten!",5000,255,0,0)end
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(Werbung.timer[source]))then
		killTimer(Werbung.timer[source]);
	end
end)