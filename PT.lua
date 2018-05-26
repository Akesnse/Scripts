local ptswitch = {}
ptswitch.optionEnable = Menu.AddOptionBool({"Utility"}, "PT Switcher", false)
test = true
test2 = false
hits = {}
function ptswitch.OnUpdate()
	if not Menu.IsEnabled(ptswitch.optionEnable) or not Engine.IsInGame() or not Heroes.GetLocal() then return end
	local myHero = Heroes.GetLocal()
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return end
	if not Entity.IsAlive(myHero) then return end
	local primAttribute = Hero.GetPrimaryAttribute(myHero)
	if primAttribute == 1 then primAttribute = 2 elseif primAttribute == 2 then primAttribute = 1 end
	local pt = NPC.GetItem(myHero, "item_power_treads", true)
	if #hits > 0 then
		for i, hit in ipairs(hits) do
			local timing = ((Entity.GetAbsOrigin(hit.source) - Entity.GetAbsOrigin(myHero)):Length2D() - NPC.GetHullRadius(hit.target)) / hit.movespeed
			if math.floor(timing + hit.starttime,2) == math.floor(GameRules.GetGameTime(),2) then
				test2 = true				
			end
			if math.floor(timing+hit.starttime) ~= math.floor(GameRules.GetGameTime()) and math.floor(timing+hit.starttime) ~= math.floor(GameRules.GetGameTime())+1 then
				test2 = false
				table.remove(hits)
			end	
		end
	end	
	if test == true then
		if NPC.IsStunned(myHero) or not pt then return end 
		if NPC.IsRunning(myHero) and not NPC.HasState(myHero,Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.IsAttacking(myHero) then
			if test2 == false and not NPC.HasModifier(myHero, "modifier_sniper_assassinate") then
				if PowerTreads.GetStats(pt) == 0 and changed == false then
					Ability.CastNoTarget(pt)
					Ability.CastNoTarget(pt)
					changed = true
				elseif PowerTreads.GetStats(pt) == 1 and changed == false then
					Ability.CastNoTarget(pt)
					changed = true	
				end
			else changed = false	
			end
		else changed = false	
		end
		if NPC.IsAttacking(myHero) then 
			if PowerTreads.GetStats(pt) - primAttribute == (1 or -2) and changed2 == false then
				Ability.CastNoTarget(pt)
				Ability.CastNoTarget(pt)
				changed2 = true
			elseif PowerTreads.GetStats(pt) - primAttribute == (2 or -1) and changed2 == false then
				Ability.CastNoTarget(pt)
				changed2 = true	
			end	
			test2 = false
		else changed2 = false	
		end
		if test2 == true  then
			if PowerTreads.GetStats(pt) == 1 and changed3 == false then
				Ability.CastNoTarget(pt)
				Ability.CastNoTarget(pt)
				changed3 = true
			elseif PowerTreads.GetStats(pt) == 2 and changed3 == false then
				Ability.CastNoTarget(pt)
				changed3 = true
			end
		else changed3 = false
		end	
	end
end
function ptswitch.OnProjectile(projectile)
	if not Heroes.GetLocal() or not Engine.IsInGame() or not Menu.IsEnabled(ptswitch.optionEnable) then return end
	if not projectile then return end
	if projectile.source == Heroes.GetLocal() then return end
	if Entity.GetClassName(projectile.source) == "C_DOTA_BaseNPC_Creep_Lane" then return end
	if projectile.source and projectile.isAttack and projectile.target == Heroes.GetLocal() then
		local moveSpeed = projectile.moveSpeed
		local myProjectedPosition = Entity.GetAbsOrigin(Heroes.GetLocal())
		local startTime = GameRules.GetGameTime()
		local projectileTiming = ((Entity.GetAbsOrigin(projectile.source) - myProjectedPosition):Length2D() - NPC.GetHullRadius(Heroes.GetLocal())) / projectile.moveSpeed
		table.insert(hits, { source = projectile.source, target = projectile.target, movespeed = moveSpeed, starttime = startTime})
	end	
end
function ptswitch.OnPrepareUnitOrders(orders)
	if not Menu.IsEnabled(ptswitch.optionEnable) or not Engine.IsInGame() or not Heroes.GetLocal() or not orders then test = true return end
	if NPC.HasState(Heroes.GetLocal(), Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then test = true return end
	if orders.order ~= 5 and orders.order ~= 6 and orders.order ~= 7 and orders.order ~= 8 and orders.order ~= 9 then test = true return end 
	local myHero = Heroes.GetLocal()
	local primAttribute = Hero.GetPrimaryAttribute(myHero)
	if primAttribute == 1 then primAttribute = 2 elseif primAttribute == 2 then primAttribute = 1 end
	local pt = NPC.GetItem(myHero, "item_power_treads", true)
	if pt then
		if orders.ability and Entity.IsAbility(orders.ability) then
			if Ability.GetManaCost(orders.ability) <= 0 then return end
			if NPC.IsStunned(myHero) or not pt then return end
			if PowerTreads.GetStats(pt) == 0 then 
				Ability.CastNoTarget(pt)
			elseif PowerTreads.GetStats(pt) == 2 then
				Ability.CastNoTarget(pt)
				Ability.CastNoTarget(pt)
			end
		end	
	end
end


return ptswitch