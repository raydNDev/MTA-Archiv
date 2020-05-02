--[[
	
	This script allows to communicate via a globalchat from server to server.
	Just start this script on your other server too and change the id.
	
	GLOBAL.Server = 2;
	Line 29: local result = dbPoll(dbQuery(HANDLER,"SELECT * FROM globalchat WHERE Server = '1'"),-1);
	
	Now your users can communicate from server to server.
	
]]--

GLOBAL = {Server = 1};
local HANDLER = dbConnect("mysql","dbname=/;host=/","root","/");

addCommandHandler("Global",function(player,cmd,...)
	local msg = table.concat({...}," ");
	if(#msg >= 1)then
		outputChatBox("[GLOBAL] "..getPlayerName(player)..": "..msg,root,255,255,255);
		dbExec(HANDLER,"INSERT INTO globalchat (Username,Server,Message) VALUES ('"..getPlayerName(player).."','"..GLOBAL.Server.."','"..msg.."')");
	end
end)

function GLOBAL.setBindKey(player)
	bindKey(player,"g","down","chatbox","Global");
end
addEventHandler("onPlayerJoin",root,function() GLOBAL.setBindKey(source) end)
for _,v in pairs(getElementsByType("player"))do GLOBAL.setBindKey(v) end

--// Check new global messages
setTimer(function()
	local result = dbPoll(dbQuery(HANDLER,"SELECT * FROM globalchat WHERE Server = '2'"),-1);
	if(#result >= 1)then
		for _,v in pairs(result)do
			outputChatBox("[GLOBAL] "..v["Username"]..": "..v["Message"],root,255,255,255);
			dbExec(HANDLER,"DELETE FROM globalchat WHERE ID = '"..v["ID"].."'");
		end
	end
end,500,0)