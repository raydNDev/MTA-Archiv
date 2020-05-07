--[[

	Multiple Languagesystem
	© Xendom Rayden

]]--

function loc(player,text)
	if(not(getElementData(player,"Langauge")))then type = "DE" else type = getElementData(player,"Language")end
	local getText = Language[type][text];
	if(not(getText))then
		outputChatBox("ERROR: '"..text.."' not found, contact the team.",player,125,0,0);
	else
		return getText;
	end
end

--// Example
addCommandHandler("message",function(player)
	local x,y,z = getElementPosition(player);
	outputChatBox(loc(player,"Message1"),player,0,125,0);
	outputChatBox(loc(player,"Message2"):format(getPlayerName(player)),player,0,125,0);
	outputChatBox(loc(player,"Message3"):format(x,y,z),player,0,125,0);
end)
