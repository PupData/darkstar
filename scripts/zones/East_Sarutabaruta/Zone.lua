-----------------------------------
--
-- Zone: East_Sarutabaruta (116)
--
-----------------------------------
package.loaded[ "scripts/zones/East_Sarutabaruta/TextIDs"] = nil;
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/globals/icanheararainbow");
require("scripts/zones/East_Sarutabaruta/TextIDs");
require("scripts/globals/zone");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
end;

-----------------------------------
-- onZoneIn
-----------------------------------

function onZoneIn( player, prevZone)
    local cs = -1;
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then
        player:setPos(305.377,-36.092,660.435,71);		-- Move Player to Tahrongi Canyon Zone
    end
        if (player:getCurrentMission( WINDURST) == THE_HEART_OF_THE_MATTER and player:getVar( "MissionStatus") == 5 and prevZone == 194) then
        cs = 0x0030;									-- WM1-2 Finishing CS
    elseif (triggerLightCutscene(player)) then
        cs = 0x0032;									-- SMN Quest (Clear Sky; Orange)
    elseif (player:getCurrentMission(WINDURST) == VAIN and player:getVar("MissionStatus") ==1) then
        cs = 0x0034;									-- WM8-1 Directions (North)
    end
    return cs;
end;

-----------------------------------
-- onConquestUpdate
-----------------------------------

function onConquestUpdate(zone, updatetype)
    local players = zone:getPlayers();
    for name, player in pairs(players) do
        conquestUpdate(zone, player, updatetype, CONQUEST_BASE);
    end
end;

-----------------------------------
-- onRegionEnter
-----------------------------------

function onRegionEnter( player, region)
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate( player, csid, option)
    if (csid == 0x0032) then							-- SMN Quest (Clear Sky; Orange)
        lightCutsceneUpdate(player);
	elseif (csid == 0x0034) then						-- WM8-1 Directions (North)
        if (player:getPreviousZone() == 241 or player:getPreviousZone() == 115) then
			-- 241-> Windurst Woods; 115->West Sarutabaruta
			if (player:getZPos() < 570) then
                player:updateEvent(0,0,0,0,0,1);		-- Northeast
            else
                player:updateEvent(0,0,0,0,0,2);		-- East
            end
        elseif (player:getPreviousZone() == 194) then	-- 194->Outer Horutoto Ruins
            if (player:getZPos() > 570) then			
                player:updateEvent(0,0,0,0,0,2);		-- East
            end
        end
	end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish( player, csid, option)
    if (csid == 0x0030) then							-- WM1-2 Finishing CS
        player:setVar( "MissionStatus",6);
        player:delKeyItem(FIRST_GLOWING_MANA_ORB);
        player:delKeyItem(SECOND_GLOWING_MANA_ORB);
        player:delKeyItem(THIRD_GLOWING_MANA_ORB);
        player:delKeyItem(FOURTH_GLOWING_MANA_ORB);
        player:delKeyItem(FIFTH_GLOWING_MANA_ORB);
        player:delKeyItem(SIXTH_GLOWING_MANA_ORB);
    elseif (csid == 0x0032) then						-- SMN Quest (Clear Sky; Orange)
        lightCutsceneFinish(player);
		end
end;
