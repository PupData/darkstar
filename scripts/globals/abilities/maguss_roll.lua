-----------------------------------
-- Ability: Magus's Roll
-- Enhances magic defense for party members within area of effect
-- Optimal Job: Blue Mage
-- Lucky Number: 2
-- Unlucky Number: 6
-- Level: 17
--
-- Die Roll    |No BLU  |With BLU
-----------    -------  -----------
-- 1           |+5      |+13
-- 2           |+20     |+28
-- 3           |+6      |+14
-- 4           |+8      |+16
-- 5           |+9      |+17
-- 6           |+3      |+11
-- 7           |+10     |+18
-- 8           |+13     |+21
-- 9           |+14     |+22
-- 10          |+15     |+23
-- 11          |+25     |+33
-- Bust        |-5      |-5
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- onAbilityCheck
-----------------------------------

function onAbilityCheck(player,target,ability)
    local effectID = getCorsairRollEffect(ability:getID());
    ability:setRange(ability:getRange() + player:getMod(MOD_ROLL_RANGE));
    if (player:hasStatusEffect(effectID) or player:hasBustEffect(effectID)) then
        return MSGBASIC_ROLL_ALREADY_ACTIVE,0;
    else
        player:setLocalVar("BLU_roll_bonus", 0);
        return 0,0;
    end
end;

-----------------------------------
-- onUseAbilityRoll
-----------------------------------

function onUseAbilityRoll(caster,target,ability,total)
    local duration = 300 + caster:getMerit(MERIT_WINNING_STREAK)
    local effectpowers = {5, 20, 6, 8, 9, 3, 10, 13, 14, 15, 25, 5}
    local effectpower = effectpowers[total]
    local jobBonus = caster:getLocalVar("BLU_roll_bonus");

    if (total < 12) then -- see chaos_roll.lua for comments
        if (jobBonus == 0) then
            if (caster:hasPartyJob(JOB_BLU) or math.random(0, 99) < caster:getMod(MOD_JOB_BONUS_CHANCE)) then
                jobBonus = 1;
            else
                jobBonus = 2;
            end
        end
        if (jobBonus == 1) then
            effectpower = effectpower + 8;
        end
        if (target:getID() == caster:getID()) then
            caster:setLocalVar("BLU_roll_bonus", jobBonus);
        end
    end

    if (caster:getMainJob() == JOB_COR and caster:getMainLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl());
    elseif (caster:getSubJob() == JOB_COR and caster:getSubLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl());
    end
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(MERIT_BUST_DURATION), EFFECT_MAGUSS_ROLL, effectpower, 0, duration, caster:getID(), total, MOD_MDEF) == false) then
        ability:setMsg(423);
    end
end;
