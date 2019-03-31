--[[

	Busfahrer
	2016 - 2018
	© Xendom Rayden

]]--

Busfahrer = {points = 0, route = nil, window = {}, button = {},
	["Route"] = {
		{-2255.2006835938,155.30792236328,35.171875},
		{-2256.3830566406,87.347793579102,35.171875},
		{-2258.91796875,27.261186599731,35.171875},
	},
};

addEvent("Busfahrer.client",true)
addEventHandler("Busfahrer.client",root,function()
	if(not(isElement(Busfahrer.window[1])) and getElementData(localPlayer,"ElementClicked") ~= true)then
		showCursor(true);
		setElementData(localPlayer,"ElementClicked",true);

        Busfahrer.window[1] = guiCreateWindow(0.41, 0.44, 0.18, 0.12, "Busfahrer", true)
        guiWindowSetMovable(Busfahrer.window[1], false)
        guiWindowSetSizable(Busfahrer.window[1], false)

        Busfahrer.button[1] = guiCreateButton(0.04, 0.23, 0.92, 0.28, "Starten", true, Busfahrer.window[1])
        guiSetProperty(Busfahrer.button[1], "NormalTextColour", "FFAAAAAA")
        Busfahrer.button[2] = guiCreateButton(0.04, 0.63, 0.92, 0.28, "Schließen", true, Busfahrer.window[1])
        guiSetProperty(Busfahrer.button[2], "NormalTextColour", "FFAAAAAA")    
		
		addEventHandler("onClientGUIClick",Busfahrer.button[1],function()
			triggerServerEvent("Busfahrer.start",localPlayer);
			showCursor(false);
			destroyElement(Busfahrer.window[1]);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
		
		addEventHandler("onClientGUIClick",Busfahrer.button[2],function()
			showCursor(false);
			destroyElement(Busfahrer.window[1]);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
	end
end)
 
function Busfahrer.createMarker(route)
	Busfahrer.points = Busfahrer.points + 1;
	Busfahrer.destroy();
	
	if(Busfahrer.points > #Busfahrer["Route"])then
		triggerServerEvent("Busfahrer.stop",localPlayer,localPlayer);
	else
		local x,y,z = Busfahrer["Route"][Busfahrer.points][1],Busfahrer["Route"][Busfahrer.points][2],Busfahrer["Route"][Busfahrer.points][3];
		Busfahrer.marker = createMarker(x,y,z,"checkpoint",2,0,200,0);
		Busfahrer.blip = createBlip(x,y,z,0,2,255,0,0);
		
		addEventHandler("onClientMarkerHit",Busfahrer.marker,function(player)
			if(player == localPlayer)then
				setTimer(function()
					Busfahrer.createMarker();
				end,3500,1)
				triggerServerEvent("Busfahrer.server",localPlayer);
			end
		end)
	end
end
addEvent("Busfahrer.createMarker",true)
addEventHandler("Busfahrer.createMarker",root,Busfahrer.createMarker)

function Busfahrer.destroy(type)
	if(isElement(Busfahrer.marker))then
		destroyElement(Busfahrer.marker);
		destroyElement(Busfahrer.blip);
	end
	if(type)then Busfahrer.points = 0 end
end
addEvent("Busfahrer.destroy",true)
addEventHandler("Busfahrer.destroy",root,Busfahrer.destroy)