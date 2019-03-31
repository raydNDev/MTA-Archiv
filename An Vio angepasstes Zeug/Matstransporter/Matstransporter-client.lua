--[[

	Matstransporter
	2016 - 2018
	© Xendom Rayden

]]--

Matstransporter = {button = {},window = {},label = {}}
setElementData(localPlayer,"ElementClicked",false);

addEvent("Matstransporter.client",true)
addEventHandler("Matstransporter.client",root,function()
	if(not(isElement(Matstransporter.window[1])) and getElementData(localPlayer,"ElementClicked") ~= true)then
		showCursor(true);
		setElementData(localPlayer,"ElementClicked",true);

        Matstransporter.window[1] = guiCreateWindow(0.39, 0.40, 0.22, 0.21, "Matstransporter", true)
        guiWindowSetMovable(Matstransporter.window[1], false)
        guiWindowSetSizable(Matstransporter.window[1], false)

        Matstransporter.button[1] = guiCreateButton(0.03, 0.59, 0.94, 0.15, "Starten", true, Matstransporter.window[1])
        guiSetProperty(Matstransporter.button[1], "NormalTextColour", "FFAAAAAA")
        Matstransporter.button[2] = guiCreateButton(0.03, 0.79, 0.94, 0.15, "Schließen", true, Matstransporter.window[1])
        guiSetProperty(Matstransporter.button[2], "NormalTextColour", "FFAAAAAA")
        Matstransporter.label[1] = guiCreateLabel(0.03, 0.14, 0.94, 0.39, "Hier kannst du einen Matstransporter beladen. Solltest du den Matstransporter erfolgreich abgeben, erhälst du 1000 Materialien.", true, Matstransporter.window[1])
        guiSetFont(Matstransporter.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(Matstransporter.label[1], "center", true)
        guiLabelSetVerticalAlign(Matstransporter.label[1], "center")    
		
		addEventHandler("onClientGUIClick",Matstransporter.button[1],function()
			triggerServerEvent("Matstransporter.server",localPlayer);
			destroyElement(Matstransporter.window[1]);
			showCursor(false);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
		
		addEventHandler("onClientGUIClick",Matstransporter.button[2],function()
			destroyElement(Matstransporter.window[1]);
			showCursor(false);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
	end
end)