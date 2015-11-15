-----------------------------------
-- Area: East Sarutabaruta
-- NPC:  Pore-Ohre
-- Involved In Mission: The Heart of the Matter
-- @pos 261 -17 -458 116
-----------------------------------
package.loaded["scripts/zones/East_Sarutabaruta/TextIDs"] = nil;
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/East_Sarutabaruta/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if (player:getCurrentMission(WINDURST) == THE_HEART_OF_THE_MATTER) then
		MissionStatus = player:getVar("MissionStatus");
		if (MissionStatus == 1) then
			player:startEvent(0x002e);		-- WM1-2 Intro
		elseif (MissionStatus == 2) then
			player:startEvent(0x002f);		-- WM1-2 Instructions
		elseif (MissionStatus == 6) then
			player:startEvent(0x0031);		-- WM1-2 Turn-In Instructions
		end
	else
		player:startEvent(0x002d);			-- Default Text
	end
	
end; 
 
-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
	if (csid == 0x002e) then				-- WM1-2 Intro
		player:setVar("MissionStatus",2);
		player:addKeyItem(SOUTHEASTERN_STAR_CHARM);
		player:messageSpecial(KEYITEM_OBTAINED,SOUTHEASTERN_STAR_CHARM);
	end
	
end;