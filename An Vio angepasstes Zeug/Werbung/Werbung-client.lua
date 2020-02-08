--[[

	Werbung
	© Xendom Rayden

]]--

Werbung = {button = {}, window = {}, label = {}, edit = {}};

addEvent("Werbung.client",true)
addEventHandler("Werbung.client",root,function()
	if(not(isElement(Werbung.window[1])) and getElementData(localPlayer,"ElementClicked") ~= true)then
		showCursor(true);
		setElementData(localPlayer,"ElementClicked",true);
		
        Werbung.window[1] = guiCreateWindow(0.37, 0.39, 0.26, 0.22, "Werbung", true)
        guiWindowSetMovable(Werbung.window[1], false)
        guiWindowSetSizable(Werbung.window[1], false)

        Werbung.button[1] = guiCreateButton(0.03, 0.81, 0.46, 0.14, "Absenden", true, Werbung.window[1])
        guiSetProperty(Werbung.button[1], "NormalTextColour", "FFAAAAAA")
        Werbung.edit[1] = guiCreateEdit(0.03, 0.60, 0.95, 0.16, "", true, Werbung.window[1])
        Werbung.label[1] = guiCreateLabel(0.03, 0.13, 0.95, 0.42, "Trage einen Text zwischen 10 und 70 Zeichen in das untere Feld ein und klicke anschließend auf absenden. Der Grundpreis einer Werbung liegt bei $4. Dazu kommen $2 pro Zeichen.", true, Werbung.window[1])
        guiSetFont(Werbung.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(Werbung.label[1], "center", true)
        guiLabelSetVerticalAlign(Werbung.label[1], "center")
        Werbung.button[2] = guiCreateButton(0.52, 0.81, 0.46, 0.14, "Schließen", true, Werbung.window[1])
        guiSetProperty(Werbung.button[2], "NormalTextColour", "FFAAAAAA")    

		addEventHandler("onClientGUIClick",Werbung.button[1],function()
			local text = guiGetText(Werbung.edit[1]);
			if(#text >= 10 and #text <= 70)then
				local costs = 4 + #text * 2;
				triggerServerEvent("Werbung.server",localPlayer,text,costs);
				destroyElement(Werbung.window[1]);
				showCursor(false);
				setElementData(localPlayer,"ElementClicked",false);
			else outputChatBox("Trage einen Text zwischen 10 und 70 Buchstaben ein!",125,0,0)end
		end,false)
		
		addEventHandler("onClientGUIClick",Werbung.button[2],function()
			destroyElement(Werbung.window[1]);
			showCursor(false);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
	end
end)

setElementData(localPlayer,"ElementClicked",false);