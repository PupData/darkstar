-----------------------------------	
-- Area: West Sarutabaruta	
-- MOB:  Carrion Crow	
-- Note: PH for Nunyenunc (10% Spawn Rate)
-- 		 NM ID: 17248517
-- 		 NM Name: Nunyenunc
--		 Group ID: 6332
--		 XYZ: 25,-15,385,127
--	     Pool ID: 2921
--		 Zone ID: 115
--		 Respawn: 14400
--		 Spawn Type: 128
--		 Drop ID: 2493
--		 HP: 0
--		 MP: 0
--		 Min Lv: 12
--		 Max Lv: 12
--		 Ally: 0
-----------------------------------	
	
require("scripts/zones/West_Sarutabaruta/MobIDs");

-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)
	mob = mob:getID();
    if (Nunyenunc_PH[mob] ~= nil) then
        ToD = GetServerVariable("[POP]Nunyenunc");
        if (ToD <= os.time(t) and GetMobAction(Nunyenunc) == 0) then
            if (math.random((1),(10)) == 5) then
                UpdateNMSpawnPoint(Nunyenunc);
                GetMobByID(Nunyenunc):setRespawnTime(GetMobRespawnTime(mob));
                SetServerVariable("[PH]Nunyenunc", mob);
                DeterMob(mob, true);
            end
        end
    end
    
end;	
