--[[

	Multiple Languagesystem
	© Xendom Rayden

]]--

function loc(text)
	if(not(getElementData(localPlayer,"Langauge")))then type = "DE" else type = getElementData(localPlayer,"Language")end
	local getText = Language[type][text];
	if(not(getText))then
		outputChatBox("ERROR: '"..text.."' not found, contact the team.",125,0,0);
	else
		return getText;
	end
end
