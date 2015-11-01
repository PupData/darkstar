-----------------------------------
--
-- Zone: West_Sarutabaruta (115)
--
-----------------------------------
	-- Clear & Reload TextIDs
package.loaded[ "scripts/zones/West_Sarutabaruta/TextIDs"] = nil;
require( "scripts/zones/West_Sarutabaruta/TextIDs");
-----------------------------------
	-- SMN Unlock Quest
require( "scripts/globals/icanheararainbow");
	-- Zone Default Data
require("scripts/globals/zone");
	-- Conquest Data
require("scripts/globals/conquest");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
	-- Load Regional Conquest NPC (W.W. etc)
    SetRegionalConquestOverseers(zone:getRegionID())
end;

-----------------------------------
-- onZoneIn
-----------------------------------

function onZoneIn(player, prevZone)
    local cs = -1;

    -- 
	if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-374.008, -23.712, 63.289, 213);
    end

    -- Quest: I Can Hear A Rainbow
	if (triggerLightCutscene(player)) then
        cs = 0x0030;
		
	-- Mission: Windurst 1-1
	elseif (player:getCurrentMission(WINDURST) == VAIN and player:getVar("MissionStatus") == 1) then
        cs = 0x0032;
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

function onEventUpdate(player, csid, option)
    
	-- DEBUG DATA
	printf("CSID: %u",csid);
    printf("RESULT: %u",option);
	
    -- Quest: I Can Hear A Rainbow
	if (csid == 0x0030) then
        lightCutsceneUpdate(player);

	-- Mission: Windurst 1-1
	elseif (csid == 0x0032) then
        if (player:getZPos() > 470) then
            player:updateEvent(0,0,0,0,0,2);
        else
            player:updateEvent(0,0,0,0,0,1);
        end
    end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish( player, csid, option)
    
	-- DEBUG DATA
	printf("CSID: %u",csid);
    printf("RESULT: %u",option);
	
    -- Quest: I Can Hear A Rainbow
	if (csid == 0x0030) then
        lightCutsceneFinish(player);
    end
end;