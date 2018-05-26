local InvokerQuickCast= {}

InvokerQuickCast.optionEnable = Menu.AddOption({"Hero Specific","InvokerQuickCast"}, "On InvokerQuickCast", "")
InvokerQuickCast.cold_snap = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "1 Cold Snap",Enum.ButtonCode.KEY_6)
InvokerQuickCast.ghost_walk = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "2 Ghost Walk",Enum.ButtonCode.KEY_0)
InvokerQuickCast.ice_wall = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "3 Ice Wall",Enum.ButtonCode.KEY_5)
InvokerQuickCast.emp = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "4 Emp",Enum.ButtonCode.KEY_2)
InvokerQuickCast.tornado = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "5 Tornado",Enum.ButtonCode.KEY_1)
InvokerQuickCast.alacrity = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "6 Alacrity",Enum.ButtonCode.KEY_9)
InvokerQuickCast.sun_strike = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "7 Sun Strike",Enum.ButtonCode.KEY_8)
InvokerQuickCast.forge_spirit = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "8 Forge Spirit",Enum.ButtonCode.KEY_7)
InvokerQuickCast.chaos_meteor = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "9 Chaos Meteor",Enum.ButtonCode.KEY_3)
InvokerQuickCast.deafening_blast = Menu.AddKeyOption({"Hero Specific","InvokerQuickCast","Key Auto Cast"}, "10 Deafening Blast",Enum.ButtonCode.KEY_4)

function InvokerQuickCast.OnUpdate()
	if not Menu.IsEnabled(InvokerQuickCast.optionEnable) then return end
	local myHero = Heroes.GetLocal()
	if not myHero then return end
	if Entity.IsAlive(myHero) then
		local Q = NPC.GetAbility(myHero,"invoker_quas") 
		local W = NPC.GetAbility(myHero,"invoker_wex") 
		local E = NPC.GetAbility(myHero,"invoker_exort") 
		local R = NPC.GetAbility(myHero,"invoker_invoke") 
		if R and Ability.IsCastable(R,NPC.GetMana(myHero)) then
			if Menu.IsKeyDownOnce(InvokerQuickCast.cold_snap) then
				InvokerQuickCast.quick_cast(Q,Q,Q)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.ghost_walk) then
				InvokerQuickCast.quick_cast(Q,Q,W)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.ice_wall) then
				InvokerQuickCast.quick_cast(Q,Q,E)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.emp) then
				InvokerQuickCast.quick_cast(W,W,W)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.tornado) then
				InvokerQuickCast.quick_cast(W,W,Q)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.alacrity) then
				InvokerQuickCast.quick_cast(W,W,E)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.sun_strike) then
				InvokerQuickCast.quick_cast(E,E,E)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.forge_spirit) then
				InvokerQuickCast.quick_cast(E,E,Q)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.chaos_meteor) then
				InvokerQuickCast.quick_cast(E,E,W)
			elseif Menu.IsKeyDownOnce(InvokerQuickCast.deafening_blast) then
				InvokerQuickCast.quick_cast(Q,W,E)
			end
		end
	end
end
function InvokerQuickCast.quick_cast(one,two,three)
	Ability.CastNoTarget(one)
	Ability.CastNoTarget(two)
	Ability.CastNoTarget(three)
	Ability.CastNoTarget(NPC.GetAbility(Heroes.GetLocal(),"invoker_invoke"))
end
return InvokerQuickCast