--[[

	Waffentransport
	© Xendom Rayden

]]--

Waffentransport = {window = {}, label = {}, button = {}};

addEvent("Waffentransport.client",true)
addEventHandler("Waffentransport.client",root,function()
	if(not(isElement(Waffentransport.window[1])) and getElementData(localPlayer,"ElementClicked") ~= true)then
		showCursor(true);
		setElementData(localPlayer,"ElementClicked",true);
		
		Waffentransport.window[1] = guiCreateWindow(0.39, 0.40, 0.22, 0.21, "Waffentransport", true)
        guiWindowSetMovable(Waffentransport.window[1], false)
        guiWindowSetSizable(Waffentransport.window[1], false)

        Waffentransport.button[1] = guiCreateButton(0.03, 0.59, 0.94, 0.15, "Starten", true, Waffentransport.window[1])
        guiSetProperty(Waffentransport.button[1], "NormalTextColour", "FFAAAAAA")
        Waffentransport.button[2] = guiCreateButton(0.03, 0.79, 0.94, 0.15, "Schließen", true, Waffentransport.window[1])
        guiSetProperty(Waffentransport.button[2], "NormalTextColour", "FFAAAAAA")
        Waffentransport.label[1] = guiCreateLabel(0.03, 0.14, 0.94, 0.39, "Bei der Abgabe eines Waffentransporter erhältst du eine Desert Eagle, Mp5, M4 und County Rifle mit einigen Schüssen.", true, Waffentransport.window[1])
        guiSetFont(Waffentransport.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(Waffentransport.label[1], "center", true)
        guiLabelSetVerticalAlign(Waffentransport.label[1], "center")    
		
		addEventHandler("onClientGUIClick",Waffentransport.button[1],function()
			triggerServerEvent("Waffentransport.server",localPlayer);
			destroyElement(Waffentransport.window[1]);
			showCursor(false);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
		
		addEventHandler("onClientGUIClick",Waffentransport.button[2],function()
			destroyElement(Waffentransport.window[1]);
			showCursor(false);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
	end
end)

addEvent("Waffentransport.clientMarker",true)
addEventHandler("Waffentransport.clientMarker",root,function(type)
	if(isElement(Waffentransport.marker))then destroyElement(Waffentransport.marker)end
	if(isElement(Waffentransport.blip))then destroyElement(Waffentransport.blip)end
	if(type)then
		Waffentransport.marker = createMarker(2035.2635498047,-109.49715423584,0.64687269926071,"checkpoint",3,255,0,0);
		Waffentransport.blip = createBlip(2035.2635498047,-109.49715423584,0.64687269926071,0,2,255,0,0);
		addEventHandler("onClientMarkerHit",Waffentransport.marker,function(player)
			if(player == localPlayer)then
				triggerServerEvent("Waffentransport.serverAbgabe",localPlayer);
			end
		end)
	end
end)