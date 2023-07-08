function TalentSpottingNPC(ent, atk)

net.Start("TalentSpot")
	net.WriteEntity(ent)
	net.WriteBool(ent:Disposition(atk) == D_HT)
	net.WriteEntity(atk)
net.Broadcast()

end

function TalentSpottingPly(ent, atk)

net.Start("TalentSpot")
	net.WriteEntity(ent)
	net.WriteBool(ent:Team() != atk:Team())
	net.WriteEntity(atk)
net.Broadcast()

end

function CRBonusDMG(dmg)
	local dmginfo = DamageInfo()

for _,Bonus in pairs(ents.FindByClass("npc_*")) do
if Bonus:IsNPC() and Bonus:GetNWBool("CRBnsDmg", false) == true then
	dmginfo:SetDamageType(DMG_BLAST)
	dmginfo:SetDamage(dmg)
	Bonus:TakeDamageInfo(dmginfo)
	Bonus:SetNWBool("CRBnsDmg", false)
end
end

end

hook.Add("ScalePlayerDamage", "DivisionSecuritySpotPly", function(ply, hitgroup, dmginfo)

local Atk = dmginfo:GetAttacker()
local Wep = Atk:GetActiveWeapon()

if Atk:IsPlayer() and Atk:GetNWString("Slot 1 Talent", "None") == "One Is None" or Atk:GetNWString("Slot 2 Talent", "None") == "One Is None" or Atk:GetNWString("Slot 3 Talent", "None") == "One Is None" or Atk:GetNWString("Slot 4 Talent", "None") == "One Is None" then

if ply:IsPlayer() and ply:Team() != Atk:Team() and hitgroup == HITGROUP_HEAD then
if math.random(1,2) == 2 then
if Wep:IsWeapon() and Wep:Clip1() != -1 then
	Wep:SetClip1(math.Clamp(Wep:Clip1() + 1, 0, Wep:GetMaxClip1()))
end
end
end

end

if ply:IsPlayer() and (Atk:IsPlayer() and ply:Team() != Atk:Team()) or (Atk:IsNPC() and Atk:Disposition(ply) == D_HT) and ply:GetNWInt("SPDmgBuff", 0) > CurTime() and hitgroup == HITGROUP_HEAD then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
end

if Atk:IsPlayer() and Atk:GetNWString("Slot 1 Talent", "None") == "Precision" or Atk:GetNWString("Slot 2 Talent", "None") == "Precision" or Atk:GetNWString("Slot 3 Talent", "None") == "Precision" or Atk:GetNWString("Slot 4 Talent", "None") == "Precision" then

if ply:Team() != Atk:Team() and hitgroup == HITGROUP_HEAD and ply:Alive() then
	TalentSpottingPly(ply, Atk)
end

end

end)

hook.Add("ScaleNPCDamage", "DivisionSecuritySpotNPC", function(npc, hitgroup, dmginfo)

local Atk = dmginfo:GetAttacker()
local Wep = Atk:GetActiveWeapon()

if Atk:IsPlayer() and Atk:GetNWString("Slot 1 Talent", "None") == "One Is None" or Atk:GetNWString("Slot 2 Talent", "None") == "One Is None" or Atk:GetNWString("Slot 3 Talent", "None") == "One Is None" or Atk:GetNWString("Slot 4 Talent", "None") == "One Is None" then

if npc:IsNPC() and npc:Disposition(Atk) == D_HT and hitgroup == HITGROUP_HEAD then
if math.random(1,2) == 2 then
if Wep:IsWeapon() and Wep:Clip1() != -1 then
	Wep:SetClip1(math.Clamp(Wep:Clip1() + 1, 0, Wep:GetMaxClip1()))
end
end
end

end

if npc:IsNPC() and npc:Disposition(Atk) == D_HT and npc:GetNWInt("SPDmgBuff", 0) > CurTime() and hitgroup == HITGROUP_HEAD then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
end

if Atk:IsPlayer() and Atk:GetNWString("Slot 1 Talent", "None") == "Precision" or Atk:GetNWString("Slot 2 Talent", "None") == "Precision" or Atk:GetNWString("Slot 3 Talent", "None") == "Precision" or Atk:GetNWString("Slot 4 Talent", "None") == "Precision" then

if IsValid(npc) and npc:Disposition(Atk) == D_HT and hitgroup == HITGROUP_HEAD then
	TalentSpottingNPC(npc, Atk)
end

end

end)

hook.Add("OnNPCKilled", "DivisionSecurityKill", function(npc, attacker)

RepoAmmo = {1, 3, 4, 5, 7}

if attacker:IsPlayer() and attacker:GetNWString("Slot 1 Talent", "None") == "Repo Reaper" or attacker:GetNWString("Slot 2 Talent", "None") == "Repo Reaper" or attacker:GetNWString("Slot 3 Talent", "None") == "Repo Reaper" or attacker:GetNWString("Slot 4 Talent", "None") == "Repo Reaper" then

if npc:IsNPC() and npc:Disposition(attacker) == D_HT and attacker:GetActiveWeapon():IsWeapon() and attacker:GetActiveWeapon():GetSlot() == 1 then
	for _,Repo in pairs(attacker:GetWeapons()) do
	if table.HasValue(RepoAmmo, Repo:GetPrimaryAmmoType()) and (Repo:GetSlot() == 2 or Repo:GetSlot() == 3) then
		attacker:GiveAmmo(30, Repo:GetPrimaryAmmoType())
	end
	end
end

end

if attacker:IsPlayer() and attacker:GetNWString("Slot 1 Talent", "None") == "On The Move" or attacker:GetNWString("Slot 2 Talent", "None") == "On The Move" or attacker:GetNWString("Slot 3 Talent", "None") == "On The Move" or attacker:GetNWString("Slot 4 Talent", "None") == "On The Move" then

if attacker:GetVelocity():LengthSqr() > 50 and npc:IsNPC() and npc:Disposition(attacker) == D_HT then
	attacker:SetNWInt("OTMDmgRes", CurTime() + 10)
end

end

end)

hook.Add("PlayerDeath", "DivisionSecurityKillPly", function(victim, inflictor, attacker)

RepoAmmo = {1, 3, 4, 5, 7}

if attacker:IsPlayer() and attacker:GetNWString("Slot 1 Talent", "None") == "Repo Reaper" or attacker:GetNWString("Slot 2 Talent", "None") == "Repo Reaper" or attacker:GetNWString("Slot 3 Talent", "None") == "Repo Reaper" or attacker:GetNWString("Slot 4 Talent", "None") == "Repo Reaper" then

if victim:IsPlayer() and victim:Team() != attacker:Team() and attacker:GetActiveWeapon():IsWeapon() and attacker:GetActiveWeapon():GetSlot() == 1 then
	for _,Repo in pairs(attacker:GetWeapons()) do
	if table.HasValue(RepoAmmo, Repo:GetPrimaryAmmoType()) and (Repo:GetSlot() == 3 or Repo:GetSlot() == 4) then
		attacker:GiveAmmo(30, Repo:GetPrimaryAmmoType())
	end
	end
end

end

if attacker:IsPlayer() and attacker:GetNWString("Slot 1 Talent", "None") == "On The Move" or attacker:GetNWString("Slot 2 Talent", "None") == "On The Move" or attacker:GetNWString("Slot 3 Talent", "None") == "On The Move" or attacker:GetNWString("Slot 4 Talent", "None") == "On The Move" then

if attacker:GetVelocity():LengthSqr() > 50 and victim:IsPlayer() and victim:Team() != attacker:Team() then
	attacker:SetNWInt("OTMDmgRes", CurTime() + 10)
end

end

end)

local DMGCount = 0
local DMGTimer = 0

hook.Add("Think", "DivisionSecurityDMGBonus", function()

if DMGTimer < CurTime() then
	DMGCount = 0
for _,NPC in pairs(ents.FindByClass("npc_*")) do
if NPC:IsNPC() and NPC:GetNWBool("CRBnsDmg", false) == true then
	NPC:SetNWBool("CRBnsDmg", false)
end
end
end

end)

hook.Add("EntityTakeDamage", "DivisionSecurityDMG", function( target, dmginfo )

local P = dmginfo:GetAttacker()

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Stopping Power" or P:GetNWString("Slot 2 Talent", "None") == "Stopping Power" or P:GetNWString("Slot 3 Talent", "None") == "Stopping Power" or P:GetNWString("Slot 4 Talent", "None") == "Stopping Power" then

if (target:IsNPC() and target:Disposition(dmginfo:GetAttacker()) == D_LI) or (target:IsPlayer() and target:Team() == dmginfo:GetAttacker():Team()) then
	P.HitCount = 0
end

if P.LastTarget == nil and (target:IsNPC() and target:Disposition(dmginfo:GetAttacker()) == D_HT) or (target:IsPlayer() and target:Team() != dmginfo:GetAttacker():Team()) then
	P.LastTarget = target
	P.HitCount = 1
end

if target == P.LastTarget and (target:IsNPC() and target:Disposition(dmginfo:GetAttacker()) == D_HT) or (target:IsPlayer() and target:Team() != dmginfo:GetAttacker():Team()) then
	P.HitCount = P.HitCount + 1
elseif target != P.LastTarget and (target:IsNPC() and target:Disposition(dmginfo:GetAttacker()) == D_HT) or (target:IsPlayer() and target:Team() != dmginfo:GetAttacker():Team()) then
	P.LastTarget = target
	P.HitCount = 1
end

if P.HitCount == 4 then
	target:SetNWInt("SPDmgBuff", CurTime() + 10)
	P:SetNWInt("SPBuffTrig", CurTime() + 10)
	P.HitCount = 0
end

end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Chain Reaction" or P:GetNWString("Slot 2 Talent", "None") == "Chain Reaction" or P:GetNWString("Slot 3 Talent", "None") == "Chain Reaction" or P:GetNWString("Slot 4 Talent", "None") == "Chain Reaction" then

if dmginfo:IsExplosionDamage() and target:GetNWBool("CRBnsDmg", false) == false then
	DMGCount = DMGCount + 1
	DMGTimer = CurTime() + 0.25
	target:SetNWBool("CRBnsDmg", true)
end

if DMGCount >= 3 then
	CRBonusDMG(dmginfo:GetDamage() * 0.25)
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
	P:SetNWInt("CrTrig", CurTime() + 3)
end

end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "On The Move" or P:GetNWString("Slot 2 Talent", "None") == "On The Move" or P:GetNWString("Slot 3 Talent", "None") == "On The Move" or P:GetNWString("Slot 4 Talent", "None") == "On The Move" then

if P:GetNWInt("OTMDmgRes", 0) > CurTime() then
	dmginfo:SetDamage(dmginfo:GetDamage() * 0.7)
end

end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 2 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 3 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 4 Talent", "None") == "Demolition Expert" then

if dmginfo:IsExplosionDamage() and P:GetNWInt("DEDmgBns", 0) > CurTime() and (target:IsNPC() and target:Disposition(P) == D_HT) or (target:IsPlayer() and target:Team() != P:Team()) then
dmginfo:SetDamage(dmginfo:GetDamage() * 1.2)
end

end

end)