--[[

	Memory
	© Xendom Rayden

]]--

clearChatBox();
outputChatBox("Use /memory to play.");
local x,y = guiGetScreenSize();

Memory = {money = 1000, cardDatas = {}, cards = {}, lifes = 3, gameActive = false, cardsOpen = 0, openCards = {}, couples = 0, open = false,
	["CardPositions"] = {
		{456, 189, 125, 158},
		{591, 189, 125, 158},
		{861, 189, 125, 158},
		{726, 189, 125, 158},
		{456, 357, 125, 158},
		{591, 357, 125, 158},
		{726, 357, 125, 158},
		{861, 357, 125, 158},
		{456, 525, 125, 158},
		{591, 525, 125, 158},
		{726, 525, 125, 158},
		{861, 525, 125, 158},
	},
	["CardDatas"] = {0,0,0,0,0,0},
};

function isCursorOnElement( posX, posY, width, height )
	if isCursorShowing( ) then
		local mouseX, mouseY = getCursorPosition( )
		local clientW, clientH = guiGetScreenSize( )
		local mouseX, mouseY = mouseX * clientW, mouseY * clientH
		if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
			return true
		end
	end
	return false
end

function Memory.dxDrawInfo()
    dxDrawText("Memory", 644*(x/1440), 10*(y/900), 796*(x/1440), 46*(y/900), tocolor(255, 255, 255, 255), 2.00*(x/1440), "default-bold", "center", "center", false, true, false, false, false)
    dxDrawText("You have three tries to find all six pairs. Use the left and right arrow keys to change the amount of money you will bet. If you win, you'll get back the double of it.", 521*(x/1440), 56*(y/900), 919*(x/1440), 137*(y/900), tocolor(255, 255, 255, 255), 1.20*(x/1440), "default-bold", "center", "center", false, true, false, false, false)
    dxDrawText("You bet $"..Memory.money.." - Enter to start, backspace for close.", 521*(x/1440), 147*(y/900), 919*(x/1440), 179*(y/900), tocolor(255, 255, 255, 255), 1.20*(x/1440), "default-bold", "center", "center", false, true, false, false, false)
end

function Memory.renderCards()
	for _,v in pairs(Memory.cards)do
		if(Memory.cardDatas[v[1]][1] == "dontShow" and Memory.cardDatas[v[1]][2] == "dontLetOpen")then
			dxDrawImage(v[2],v[3],v[4],v[5],"Card.jpg",0,0,0,tocolor(255,255,255,255),false);
		else
			dxDrawImage(v[2],v[3],v[4],v[5],v[6]..".jpg",0,0,0,tocolor(255,255,255,255),false);
		end
	end

	for i = 1, Memory.lifes do
		local coordinates = 459 + (i - 1) * 36
		dxDrawImage(coordinates*(x/1400),693*(y/900),26*(x/1400),26*(y/900),"Life.png",0,0,0,tocolor(255,255,255,255),false);
	end
end

function Memory.generateCards()
	for i,v in ipairs(Memory["CardPositions"])do
		local picture = Memory.getFreeCard();
		Memory["CardDatas"][picture] = Memory["CardDatas"][picture] + 1;
		Memory.cardDatas[i] = {"dontShow","dontLetOpen"};
		table.insert(Memory.cards,{i,v[1]*(x/1440),v[2]*(y/900),v[3]*(x/1440),v[4]*(y/900),picture});
	end

	addEventHandler("onClientRender",root,Memory.renderCards);
	addEventHandler("onClientRender",root,Memory.dxDrawInfo);
	bindKey("arrow_l","down",Memory.priceDown);
	bindKey("arrow_r","down",Memory.priceHigher);
	bindKey("enter","down",Memory.startGame);
	bindKey("backspace","down",Memory.refreshAll);
	toggleAllControls(false);
end
addCommandHandler("memory",Memory.generateCards)

function Memory.getFreeCard()
	local tbl = {};
	for i = 1,6 do
		if(Memory["CardDatas"][i] < 2)then
			table.insert(tbl,{i});
		end
	end
	return tbl[math.random(1,#tbl)][1];
end

function Memory.priceDown()
	if(Memory.money > 1000)then
		Memory.money = Memory.money - 1000;
	else outputChatBox("You must bet at least $1000!",255,0,0)end
end

function Memory.priceHigher()
	if(Memory.money < 5000)then
		Memory.money = Memory.money + 1000;
	else outputChatBox("You can bet maximum $5000!",255,0,0)end
end

function Memory.startGame()
	if(getElementData(localPlayer,"Money") >= Memory.money)then
		unbindKey("arrow_l","down",Memory.priceDown);
		unbindKey("arrow_r","down",Memory.priceHigher);
		unbindKey("enter","down",Memory.startGame);
		Memory.gameActive = true;
		outputChatBox("Find the couples.",0,125,0);
		showCursor(true);
		addEventHandler("onClientClick",root,Memory.clickCards);
		setElementData(localPlayer,"Money",getElementData(localPlayer,"Money")-Memory.money);
	else outputChatBox("You don't have enough money!",255,0,0)end
end

function Memory.clickCards(button,state)
	if(button == "left" and state == "down")then
		for _,v in pairs(Memory.cards)do
			if(isCursorOnElement(v[2],v[3],v[4],v[5]))then
				if(Memory.couples < 6)then
					if(Memory.cardsOpen < 2)then
						if(Memory.cardDatas[v[1]][1] == "dontShow" and Memory.cardDatas[v[1]][2] == "dontLetOpen")then
							if(v[6] == 6)then playSound("meddl.mp3") end
							Memory.cardsOpen = Memory.cardsOpen + 1;
							Memory.cardDatas[v[1]][1] = "show";
							table.insert(Memory.openCards,{v[1],v[6]});
							if(Memory.cardsOpen >= 2)then
								if(Memory.openCards[1][2] == Memory.openCards[2][2])then
									Memory.cardDatas[Memory.openCards[1][1]][2] = "letShow";
									Memory.cardDatas[Memory.openCards[2][1]][2] = "letShow";
									outputChatBox("You found a pair.",0,255,0);
									Memory.couples = Memory.couples + 1;
									if(Memory.couples >= 6)then
										outputChatBox("You won and got $"..Memory.money * 2 ..".",0,255,0);
										setElementData(localPlayer,"Money",getElementData(localPlayer,"Money")+Memory.money*2);
										Memory.finishTimer = setTimer(function()
											Memory.refreshAll();
										end,1000,1)
									end
								else
									outputChatBox("You doesn't found a pair... ;(",255,0,0);
									Memory.lifes = Memory.lifes - 1;
									if(Memory.lifes == 0)then
										outputChatBox("You lost... ;(",255,0,0);
										Memory.refreshAll();
									end
								end
								Memory.resetTimer = setTimer(function()
									for i = 1,12 do
										if(Memory.cardDatas[i])then
											Memory.cardDatas[i][1] = "dontShow";
										end
									end
									Memory.openCards = {};
									Memory.cardsOpen = 0;
								end,1000,1);
							end
						end
					end
				end
			end
		end
	end
end

function Memory.refreshAll()
	Memory.open = false;
	if(isTimer(Memory.finishTimer))then killTimer(Memory.finishTimer)end
	if(isTimer(Memory.resetTimer))then killTimer(Memory.resetTimer)end
	Memory.money = 1000;
	Memory.cards = {};
	Memory.lifes = 3;
	Memory.cardsOpen = 0;
	Memory.openCards = {};
	unbindKey("arrow_l","down",Memory.priceDown);
	unbindKey("arrow_r","down",Memory.priceHigher);
	unbindKey("enter","down",Memory.startGame);
	Memory.gameActive = false;
	removeEventHandler("onClientClick",root,Memory.clickCards);
	removeEventHandler("onClientRender",root,Memory.renderCards);
	removeEventHandler("onClientRender",root,Memory.dxDrawInfo);
	showCursor(false);
	toggleAllControls(true);
	Memory.couples = 0;
	Memory.cardDatas = {};
	unbindKey("backspace","down",Memory.refreshAll);
	for i = 1,6 do Memory["CardDatas"][i] = 0 end
end
