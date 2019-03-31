--[[

	Adminmodus
	2016 - 2018
	© Xendom Rayden

]]--

addEventHandler("onClientPlayerDamage",root,function()
	if(getElementData(localPlayer,"Adminmodus") == true)then
		cancelEvent();
	end
end)