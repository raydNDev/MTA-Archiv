--[[

	Baserush
	2016 - 2018
	© Xendom Rayden

]]--

Baserushsystem = {window = {}, radiobutton = {}, button = {}, label = {}, memo = {}};

addEvent("Baserushsystem.client",true)
addEventHandler("Baserushsystem.client",root,function()
	if(not(isElement(Baserushsystem.window[1])) and getElementData(localPlayer,"ElementClicked") ~= true)then
		showCursor(true);
		setElementData(localPlayer,"ElementClicked",true);
	
		Baserushsystem.window[1] = guiCreateWindow(0.32, 0.33, 0.36, 0.36, "Baserush System", true)
		guiWindowSetSizable(Baserushsystem.window[1], false)
		guiWindowSetMovable(Baserushsystem.window[1], false)
		
		Baserushsystem.radiobutton[1] = guiCreateRadioButton(0.02, 0.07, 0.40, 0.09, "Mafia", true, Baserushsystem.window[1])
		Baserushsystem.radiobutton[2] = guiCreateRadioButton(0.02, 0.16, 0.40, 0.09, "Triaden", true, Baserushsystem.window[1])
		Baserushsystem.radiobutton[3] = guiCreateRadioButton(0.02, 0.25, 0.40, 0.09, "Los Aztecas", true, Baserushsystem.window[1])
		Baserushsystem.radiobutton[4] = guiCreateRadioButton(0.02, 0.33, 0.40, 0.09, "Angels of Death", true, Baserushsystem.window[1])
		
		Baserushsystem.label[1] = guiCreateLabel(0.02, 0.59, 0.96, 0.06, "________________________________________________________________________", true, Baserushsystem.window[1])
		
		Baserushsystem.button[1] = guiCreateButton(0.02, 0.45, 0.40, 0.13, "Baserush ankündigen", true, Baserushsystem.window[1])
		Baserushsystem.button[2] = guiCreateButton(0.56, 0.68, 0.40, 0.13, "Für 3500$ ausrüsten", true, Baserushsystem.window[1])
		Baserushsystem.button[3] = guiCreateButton(0.02, 0.83, 0.40, 0.13, "Regelwerk anzeigen", true, Baserushsystem.window[1])
		Baserushsystem.button[4] = guiCreateButton(0.56, 0.83, 0.40, 0.13, "Fenster schließen", true, Baserushsystem.window[1])
		
		Baserushsystem.memo[1] = guiCreateMemo(0.48, 0.07, 0.50, 0.50, "Gate muss während des Baserush die ganze Zeit offen bleiben!\nSpezialwaffen wie RPG, Sniper, Molotov etc. sind verboten!\nSpawntrapen/Spawnkillen ist verboten!\nMarkerflucht während des Baserush ist verboten!\nNach der Ankündigung muss 5 Minuten gewartet werden, bis man die Base stürmen darf!", true, Baserushsystem.window[1])
		guiMemoSetReadOnly(Baserushsystem.memo[1], true)
		guiSetVisible(Baserushsystem.memo[1],false);
		
		addEventHandler("onClientGUIClick",Baserushsystem.button[1],function()
			for i = 1,4 do
				if(guiRadioButtonGetSelected(Baserushsystem.radiobutton[i]))then
					triggerServerEvent("Baserushsystem.server",localPlayer,guiGetText(Baserushsystem.radiobutton[i]));
				end
			end
		end,false)
		
		addEventHandler("onClientGUIClick",Baserushsystem.button[2],function()
			triggerServerEvent("Baserushsystem.buy",localPlayer)
		end,false)
		
		addEventHandler("onClientGUIClick",Baserushsystem.button[3],function()
			if(guiGetVisible(Baserushsystem.memo[1]) == false)then
				guiSetVisible(Baserushsystem.memo[1],true);
				guiSetText(Baserushsystem.button[3],"Regelwerk ausblenden");
			else
				guiSetVisible(Baserushsystem.memo[1],false);
				guiSetText(Baserushsystem.button[3],"Regelwerk anzeigen");
			end
		end,false)
		
		addEventHandler("onClientGUIClick",Baserushsystem.button[4],function()
			destroyElement(Baserushsystem.window[1]);
			showCursor(false);
			setElementData(localPlayer,"ElementClicked",false);
		end,false)
	end
end)