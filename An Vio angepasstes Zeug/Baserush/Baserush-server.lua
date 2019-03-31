--[[

	Baserush
	2016 - 2018
	© Xendom Rayden

]]--

Baserushsystem = {state = {}, active = false,
	["Fraktionen"] = {
		["Mafia"] = 2,
		["Triaden"] = 3,
		["Los Aztecas"] = 7,
		["Angels of Death"] = 9
	},
};

addCommandHandler("baserush",function(player)
	if(isEvil(player))then
		triggerClientEvent(player,"Baserushsystem.client",player);
	end
end)

function evilFactionMSG(text)
	for _,v in pairs(getElementsByType("player"))do
		if(isEvil(player))then
			outputChatBox(text,v,175,0,0);
		end
	end
end

addEvent("Baserushsystem.buy",true)
addEventHandler("Baserushsystem.buy",root,function()
	if(vioGetElementData(client,"money") >= 3500)then
		takePlayerSaveMoney(client,3500);
		giveWeapon(player,24,1000);
		giveWeapon(player,39,500);
		giveWeapon(player,31,500);
		infobox(client,"Du hast dich mit\nWaffen ausgerüstet.",5000,0,255,0);
	else infobox(client,"Du hast nicht genug\nGeld bei dir!",5000,255,0,0)end
end)

addEvent("Baserushsystem.server",true)
addEventHandler("Baserushsystem.server",root,function(faction)
	if(isEvil(player))then
		local factionID = Baserushsystem["Fraktionen"][faction];
		if(vioGetElementData(client,"fraktion") ~= factionID)then
			if(Baserushsystem.state[factionID] ~= true)then
				if(Baserushsystem.active == false)then
					Baserushsystem.active = true;
					Baserushsystem.state[factionID] = true;
					evilFactionMSG(getPlayerName(client).." hat einen Baserush bei den/der "..fraktionNames[factionID].." angekündigt!");
					evilFactionMSG("In fünf Minuten darf gestürmt werden! Alle Tore müssen nun geöffnet werden!");
					setTimer(function(factionID)
						evilFactionMSG("Die Base der "..fraktionNames[factionID].." darf nun gestürmt werden!");
						evilFactionMSG("Der Baserush geht fünf Minuten.");
						
						setTimer(function(factionID)
							evilFactionMSG("Der Baserush bei der/den "..fraktionNames[factionID].." ist vorbei!");
							Baserushsystem.active = false;
						end,300000,1,factionID)
					end,2000,1,factionID)
				else infobox(client,"Zurzeit läuft bereits\nein Baserush!",5000,255,0,0)end
			else infobox(client,"Bei der ausgewählten\nFraktion fand heute\nbereits ein\nBaserush statt!",5000,255,0,0)end
		else infobox(client,"Du kannst bei\ndeiner eigenen\nFraktion keinen\nBaserush ankündigen!",5000,255,0,0)end
	end
end)