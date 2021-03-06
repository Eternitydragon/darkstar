---------------------------------------------
--  Replicator
---------------------------------------------

require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    return 0
end

function onPetAbility(target, automaton, skill, master, action)
    automaton:addRecast(RECAST_ABILITY, skill:getID(), 60)
    local maneuvers = master:countEffect(EFFECT_WIND_MANEUVER)
    local duration = 300
    local shadows = 1 + maneuvers -- math.floor(maneuvers * 3.5) currently on retail

    if target:addStatusEffect(EFFECT_BLINK, shadows, 0, duration) then
        skill:setMsg(MSG_BUFF)
        for i = 1, maneuvers do
            master:delStatusEffectSilent(EFFECT_WIND_MANEUVER)
        end
    else
        skill:setMsg(MSG_NO_EFFECT)
    end

    return EFFECT_BLINK
end
