--[[

	Pilot
	© Xendom Rayden

]]--

Pilot = {window = {}, button = {},
	["Ziel"] = {
		{1388.5461425781,1567.5434570313,10.820300102234,"Las Venturas Airport"},
		{1852.6374511719,-2493.5791015625,13.554699897766,"Los Santos Airport"},
	},
};

addEvent("Pilot.client",true)
addEventHandler("Pilot.client",root,function()
	if(not(isElement(Pilot.window[1])) and getElementData(localPlayer,"ElementClicked") ~= true)then
		showCursor(true);
		setElementData(localPlayer,"ElementClicked",true);

        Pilot.window[1] = guiCreateWindow(0.41, 0.44, 0.18, 0.12, "Pilot", true)
        guiWindowSetMovable(Pilot.window[1], false)
        guiWindowSetSizable(Pilot.window[1], false)

        Pilot.button[1] = guiCreateButton(0.04, 0.23, 0.92, 0.28, "Starten", true, Pilot.window[1])
        guiSetProperty(Pilot.button[1], "NormalTextColour", "FFAAAAAA")
        Pilot.button[2] = guiCreateButton(0.04, 0.63, 0.92, 0.28, "Schließen", true, Pilot.window[1])
        guiSetProperty(Pilot.button[2], "NormalTextColour", "FFAAAAAA")    
		
		addEventHandler("onClientGUIClick",Pilot.button[1],function()
			triggerServerEvent("Pilot.server",localPlayer);
			showCursor(false);
			destroyElement(Pilot.window[1]);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
		
		addEventHandler("onClientGUIClick",Pilot.button[2],function()
			showCursor(false);
			destroyElement(Pilot.window[1]);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
	end
end)

function Pilot.createMarker(type)
	if(isElement(Pilot.marker))then
		destroyElement(Pilot.marker);
		destroyElement(Pilot.blip);
	end
	if(type)then
		local nr = math.random(1,#Pilot["Ziel"]);
		local x,y,z = Pilot["Ziel"][nr][1],Pilot["Ziel"][nr][2],Pilot["Ziel"][nr][3];
		Pilot.marker = createMarker(x,y,z,"checkpoint",10,255,0,0);
		Pilot.blip = createBlip(x,y,z,0,2,255,0,0);
		setElementDimension(Pilot.marker,getElementDimension(localPlayer));
		setElementDimension(Pilot.blip,getElementDimension(localPlayer));
		infobox("Dein Ziel ist der\n"..Pilot["Ziel"][nr][4].."!",5000,0,255,0);
		
		addEventHandler("onClientMarkerHit",Pilot.marker,function(player)
			if(player == localPlayer)then
				Pilot.createMarker();
				triggerServerEvent("Pilot.finish",localPlayer);
			end
		end)
	end
end
addEvent("Pilot.createMarker",true)
addEventHandler("Pilot.createMarker",root,Pilot.createMarker)