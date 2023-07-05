if SERVER then

function DoShockDMG(ent, damage)
	local dmginfo = DamageInfo()

if ent:GetNWBool("FearTacTriggered", false) == true then
	dmginfo:SetDamageType(DMG_BURN)
	dmginfo:SetDamage(damage)
	ent:TakeDamageInfo(dmginfo)
	ent:SetNWBool("FearTacTriggered", false)
end
end

function DoFireDMG(ent, damage)
	local dmginfo = DamageInfo()

if ent:GetNWBool("WildFireTriggered", false) == true then
	dmginfo:SetDamageType(DMG_SHOCK)
	dmginfo:SetDamage(damage)
	ent:TakeDamageInfo(dmginfo)
	ent:SetNWBool("WildFireTriggered", false)
end
end

function DoAcidDMG(ent, damage)
	local dmginfo = DamageInfo()

if ent:GetNWBool("ChemSpillTriggered", false) == true then
	dmginfo:SetDamageType(DMG_ACID)
	dmginfo:SetDamage(damage)
	ent:TakeDamageInfo(dmginfo)
	ent:SetNWBool("ChemSpillTriggered", false)
end
end

hook.Add("Move", "DivisionTechMove", function(ply, mv)

if ply:IsPlayer() and ply:GetNWString("Slot 1 Talent", "None") == "Evasive Action" or ply:GetNWString("Slot 2 Talent", "None") == "Evasive Action" or ply:GetNWString("Slot 3 Talent", "None") == "Evasive Action" or ply:GetNWString("Slot 4 Talent", "None") == "Evasive Action" then

if ply:IsSprinting() and ply:GetVelocity():LengthSqr() > 0 then
	ply:SetNWInt("EADmgRes", CurTime() + 3)
end

end

end)

hook.Add("OnNPCKilled", "DivisionTechKill", function(npc, attacker)

if attacker:IsPlayer() and attacker:GetNWString("Slot 1 Talent", "None") == "Demolition Expert" or attacker:GetNWString("Slot 2 Talent", "None") == "Demolition Expert" or attacker:GetNWString("Slot 3 Talent", "None") == "Demolition Expert" or attacker:GetNWString("Slot 4 Talent", "None") == "Demolition Expert" then

if npc:IsNPC() and npc:Disposition(attacker) == D_HT then
	attacker:SetNWInt("DEDmgBns", CurTime() + 15)
end

end

end)

hook.Add("PlayerDeath", "DivisionTechKillPly", function(victim, inflictor, attacker)

if attacker:IsPlayer() and attacker:GetNWString("Slot 1 Talent", "None") == "Demolition Expert" or attacker:GetNWString("Slot 2 Talent", "None") == "Demolition Expert" or attacker:GetNWString("Slot 3 Talent", "None") == "Demolition Expert" or attacker:GetNWString("Slot 4 Talent", "None") == "Demolition Expert" then

if victim:IsPlayer() and victim:Team() != attacker:Team() then
	attacker:SetNWInt("DEDmgBns", CurTime() + 15)
end

end

end)

hook.Add("EntityTakeDamage", "DivisionTechDMG", function( target, dmginfo )

local P = dmginfo:GetAttacker()

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Wildfire" or P:GetNWString("Slot 2 Talent", "None") == "Wildfire" or P:GetNWString("Slot 3 Talent", "None") == "Wildfire" or P:GetNWString("Slot 4 Talent", "None") == "Wildfire" then

if (target:IsNPC() and target:Disposition(P) == D_HT) or (target:IsPlayer() and target:Team() != P:Team()) and target:GetNWInt("WildFireTrig", 0) < CurTime() and dmginfo:IsDamageType(DMG_BURN) then
if math.random(1, 100) < 30 then
	target:SetNWInt("WildFireTrig", CurTime() + 0.5)
	for _,WildFire in pairs(ents.FindInSphere(target:GetPos(), 525)) do

	if (WildFire:IsNPC() and WildFire:Disposition(P) == D_HT) or (WildFire:IsPlayer() and WildFire:Team() != P:Team()) and WildFire:GetNWInt("WildFireTrig", 0) < CurTime() and WildFire != target then
		WildFire:SetNWInt("WildFireTrig", CurTime() + 0.5)
		WildFire:SetNWBool("WildFireTriggered", true)
		Damage = dmginfo:GetDamage() * 0.25
		DoFireDMG(WildFire, Damage)
	end
	end
end
end

end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Fear Tactics" or P:GetNWString("Slot 2 Talent", "None") == "Fear Tactics" or P:GetNWString("Slot 3 Talent", "None") == "Fear Tactics" or P:GetNWString("Slot 4 Talent", "None") == "Fear Tactics" then

if (target:IsNPC() and target:Disposition(P) == D_HT) or (target:IsPlayer() and target:Team() != P:Team()) and target:GetNWInt("FearTacTrig", 0) < CurTime() and dmginfo:IsDamageType(DMG_SHOCK) then
if math.random(1, 100) < 30 then
	target:SetNWBool("FearTacTrig", CurTime() + 0.5)
	for _,FearTac in pairs(ents.FindInSphere(target:GetPos(), 525)) do

	if FearTac != target and (FearTac:IsNPC() and FearTac:Disposition(P) == D_HT) or (FearTac:IsPlayer() and FearTac:Team() != P:Team()) and FearTac:GetNWInt("FearTacTrig", 0) < CurTime() then
		FearTac:SetNWInt("FearTacTrig", CurTime() + 0.5)
		FearTac:SetNWBool("FearTacTriggered", true)
		Damage = dmginfo:GetDamage() * 0.25
		DoShockDMG(FearTac, Damage)
	end
	end
end
end

end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Chemical Spill" or P:GetNWString("Slot 2 Talent", "None") == "Chemical Spill" or P:GetNWString("Slot 3 Talent", "None") == "Chemical Spill" or P:GetNWString("Slot 4 Talent", "None") == "Chemical Spill" then

if (target:IsNPC() and target:Disposition(P) == D_HT) or (target:IsPlayer() and target:Team() != P:Team()) and target:GetNWInt("ChemSpillTrig", 0) < CurTime() and dmginfo:IsDamageType(DMG_ACID) then
if math.random(1, 100) < 30 then
	target:SetNWBool("ChemSpillTrig", CurTime() + 0.5)
	for _,ChemSpill in pairs(ents.FindInSphere(target:GetPos(), 525)) do

	if ChemSpill != target and (ChemSpill:IsNPC() and ChemSpill:Disposition(P) == D_HT) or (ChemSpill:IsPlayer() and ChemSpill:Team() != P:Team()) and ChemSpill:GetNWInt("ChemSpillTrig", 0) < CurTime() then
		ChemSpill:SetNWInt("ChemSpillTrig", CurTime() + 0.5)
		ChemSpill:SetNWBool("ChemSpillTriggered", true)
		Damage = dmginfo:GetDamage() * 0.25
		DoAcidDMG(ChemSpill, Damage)
	end
	end
end
end

end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Evasive Action" or P:GetNWString("Slot 2 Talent", "None") == "Evasive Action" or P:GetNWString("Slot 3 Talent", "None") == "Evasive Action" or P:GetNWString("Slot 4 Talent", "None") == "Evasive Action" then

if P:GetNWInt("EADmgRes", 0) > CurTime() then
dmginfo:SetDamage(dmginfo:GetDamage() * 0.7)
end

end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 2 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 3 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 4 Talent", "None") == "Demolition Expert" then

if dmginfo:IsExplosionDamage() and P:GetNWInt("DEDmgBns", 0) > CurTime() and (target:IsNPC() and target:Disposition(P) == D_HT) or (target:IsPlayer() and target:Team() != P:Team()) then
dmginfo:SetDamage(dmginfo:GetDamage() * 1.2)
end

end

end)

end