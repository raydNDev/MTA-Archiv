--[[

	Adminmodus
	© Xendom Rayden

]]--

Adminmodus = {oldSkin = {}};

addCommandHandler("amode",function(player)
	if(vioGetElementData(player,"adminlvl") >= 1)then
		if(vioGetElementData(player,"Adminmodus") ~= true)then
			infobox(player,"Du hast den Adminmodus betreten.",5000,0,255,0);
			vioSetElementData(player,"Adminmodus",true);
			Adminmodus.oldSkin[player] = getElementModel(player);
			setElementModel(player,260);
		else
			infobox(player,"Du hast den Adminmodus verlassen.",5000,255,0,0);
			vioSetElementData(player,"Adminmodus",false);
			setElementModel(player,Adminmodus.oldSkin[player]);
		end
	end
end)