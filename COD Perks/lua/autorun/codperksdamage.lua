local KillableArmorClass = {"npc_strider"}
local UnkillableArmorClass = {"npc_turret_floor", "npc_rollermine"}

function PerkFuncNPC(ent, atk)

net.Start("PerkSpot")
	net.WriteEntity(ent)
	net.WriteBool(ent:Disposition(atk) == D_HT)
	net.WriteEntity(atk)
net.Broadcast()

end

function PerkFuncPly(ent, atk)

net.Start("PerkSpot")
	net.WriteEntity(ent)
	net.WriteBool(ent:Team() != atk:Team())
	net.WriteEntity(atk)
net.Broadcast()

end

function ResTimers(atk, type)

net.Start("ResTimers")
	net.WriteBool(type)
net.Send(atk)

end

hook.Add("ScalePlayerDamage", "MarksmanBonusPly", function(ply,hitgroup,dmginfo)
if dmginfo:GetAttacker():GetNWString("Tier 3 Perk") == "Marksman" and hitgroup == HITGROUP_HEAD then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
end
end)
hook.Add("ScaleNPCDamage", "MarksmanBonusNPC", function(npc,hitgroup,dmginfo)
if dmginfo:GetAttacker():GetNWString("Tier 3 Perk") == "Marksman" and hitgroup == HITGROUP_HEAD then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
end
end)

hook.Add("PlayerSpawn", "ArmorSpawn", function(ply)
if ply:Alive() and ply:GetNWString("Tier 1 Perk") == "Armorer" and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 2) then
	timer.Simple(0.5, function() if IsValid(ply) then ply:SetArmor(ply:Armor() + 50) end end)
end

end)

hook.Add("PlayerDeath", "QFMartyrPly", function(victim, inflictor, attacker)

if victim:GetNWString("Tier 3 Perk") == "Martyrdom" then
MartyrNade = ents.Create("npc_grenade_frag")
MartyrNade:SetPos( victim:WorldSpaceCenter() )
MartyrNade:SetCollisionGroup(9)
MartyrNade:SetOwner(victim)
MartyrNade:Spawn()
MartyrNade:Fire("SetTimer", 3, 0)
end

if attacker:IsPlayer() and attacker:GetNWString("Tier 1 Perk") == "Quick-Fix" and attacker:Alive() then
attacker:SetNWInt(attacker:GetNWInt("QFHealth", 0) + 20)
attacker:SetNWInt("QFHealth", "QFTimer", CurTime() + 5)
attacker:SetHealth( math.Clamp(attacker:Health() + 20, 0, attacker:GetMaxHealth() + 20) )
end

end)

hook.Add("OnNPCKilled", "QFKilledNPC", function(npc, attacker)

if attacker:IsPlayer() and attacker:GetNWString("Tier 1 Perk") == "Quick-Fix" and attacker:Alive() then
if attacker:Health() < attacker:GetMaxHealth() + 20 then
attacker:SetNWInt("QFHealth", math.Clamp(attacker:GetNWInt("QFHealth", 0) + 20, 0, attacker:GetMaxHealth() + 20))
attacker:SetHealth( math.Clamp(attacker:Health() + 20, 0, attacker:GetMaxHealth() + 20) )
end
attacker:SetNWInt("QFTimer", CurTime() + 5)
end

end)

hook.Add("Think", "QFTempHPThink", function()

for _,AllNPC in pairs(ents.FindByClass("npc_*")) do
if AllNPC:IsNPC() then
if AllNPC:GetNWBool("PerkSpotted", false) == true and AllNPC:GetNWInt("Timer", math.huge) < CurTime() then
	AllNPC:SetNWBool("PerkSpotted", false)
	AllNPC:SetNWInt("Timer", math.huge)
end
end
end

for _,QFPly in pairs(player.GetAll()) do

if QFPly:IsPlayer() and QFPly:Alive() and QFPly:GetNWString("Tier 2 Perk") == "Survivalist" then
HealthSeg1 = QFPly:Health() < 80 and QFPly:Health() > 60
HealthSeg2 = QFPly:Health() < 60 and QFPly:Health() > 40
HealthSeg3 = QFPly:Health() < 40 and QFPly:Health() > 20
HealthSeg4 = QFPly:Health() < 20 and QFPly:Health() >= 1
LastHit = QFPly:GetNWInt("SurvRegen", 0) < CurTime()
if HealthSeg1 and LastHit then
	QFPly:SetHealth(math.Clamp(QFPly:Health() + 1, 0, QFPly:GetMaxHealth() * 0.8))
	QFPly:SetNWInt("SurvRegen", CurTime() + 3)
elseif HealthSeg2 and LastHit then
	QFPly:SetHealth(math.Clamp(QFPly:Health() + 1, 0, QFPly:GetMaxHealth() * 0.6))
	QFPly:SetNWInt("SurvRegen", CurTime() + 3)
elseif HealthSeg3 and LastHit then
	QFPly:SetHealth(math.Clamp(QFPly:Health() + 1, 0, QFPly:GetMaxHealth() * 0.4))
	QFPly:SetNWInt("SurvRegen", CurTime() + 3)
elseif HealthSeg4 and LastHit then
	QFPly:SetHealth(math.Clamp(QFPly:Health() + 1, 0, QFPly:GetMaxHealth() * 0.2))
	QFPly:SetNWInt("SurvRegen", CurTime() + 3)
end

end

if QFPly:IsPlayer() then
if !QFPly:Alive() or (QFPly:GetNWBool("PerkSpotted", false) == true and QFPly:GetNWInt("Timer", math.huge) < CurTime()) or QFPly:GetNWString("Tier 2 Perk") == "Ninja" then
	QFPly:SetNWBool("PerkSpotted", false)
	QFPly:SetNWInt("Timer", math.huge)
end
end

if QFPly:GetNWInt("QFHealth", 0) > 0 and QFPly:GetNWInt("QFTimer", 0) < CurTime() and QFPly:Alive() then
	QFPly:SetHealth(QFPly:Health() - QFPly:GetNWInt("QFHealth", 0))
	QFPly:SetNWInt("QFHealth", 0)
end
end

end)

hook.Add("EntityTakeDamage", "CodPerksDMGHooks", function( target, dmginfo )

local Atk = dmginfo:GetAttacker()

if (target:IsNPC() and target:Disposition(Atk) == D_HT) or (target:IsPlayer() and target:Alive() and target:Team() != Atk:Team()) and target:GetPos():Distance(Atk:GetPos()) < 350 and Atk:GetNWInt("Tier 2 Perk") == "Assassin" then

if IsValid(target) then
	NPCVec = (target:GetPos() - Atk:GetPos()):GetNormalized():Angle().y
	PlyAng = target:EyeAngles().y
	Result = NPCVec - PlyAng
if Result > 360 then
	Result = Result - 360
elseif Result < 0 then
	Result = Result + 360
end

if Result <= 100 or Result >= 265 then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.2)
end

end

end

if target:IsPlayer() and target:Alive() and target:GetNWString("Tier 2 Perk") == "Survivalist" then
	target:SetNWInt("SurvRegen", CurTime() + 5)
else
	target:SetNWInt("SurvRegen", 0)
end

if target:GetNWString("Tier 3 Perk") == "Tactical Mask" then
if dmginfo:IsDamageType(DMG_NERVEGAS + DMG_POISON + DMG_ACID) then
dmginfo:SetDamage(dmginfo:GetDamage() * 0.1)
end
if dmginfo:IsDamageType(DMG_RADIATION) then
dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
end
end

if Atk:IsPlayer() and Atk:GetNWString("Tier 3 Perk") == "Executioner" and target:GetNWString("Tier 2 Perk") != "Juggernaut" then
if target:Health() <= target:GetMaxHealth() * 0.5 and target:Health() > target:GetMaxHealth() * 0.25 then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.2)
elseif target:Health() <= target:GetMaxHealth() * 0.25 then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.35)
end
end

if Atk:IsPlayer() and Atk:GetNWString("Tier 1 Perk") == "Recon" then
if (target:IsNPC() and target:Disposition(Atk) == D_HT and IsValid(target)) or (target:IsPlayer() and target:Team() != Atk:Team() and target:Alive()) then
if (target:IsNPC() and target:Disposition(Atk) == D_HT and IsValid(target)) then
	PerkFuncNPC(target, Atk)
elseif (target:IsPlayer() and target:Team() != Atk:Team() and target:Alive()) then
	PerkFuncPly(target, Atk)
end
	target:SetNWBool("PerkSpotted", true)
	target:SetNWInt("Timer", CurTime() + 8)
end
end

if Atk:IsPlayer() and Atk:GetPos():Distance(target:GetPos()) < 250 then

if IsValid(Atk) and (target:IsNPC() and IsValid(target) and target:Disposition(Atk) == D_HT) or (target:IsPlayer() and target:Alive() and Atk:Team() != target:Team()) then
	AtkVec = (Atk:GetPos() - target:GetPos()):GetNormalized():Angle().y
	AtkAng = target:EyeAngles().y
	Result = AtkVec - AtkAng
if Result > 360 then
	Result = Result - 360
elseif Result < 0 then
	Result = Result + 360
end

if Result > 90 and Result <= 260 then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.2)
end

end
end

if Atk:IsPlayer() and Atk:GetNWString("Tier 2 Perk") == "Hardened" then
if target:IsNPC() and table.HasValue(UnkillableArmorClass, target:GetClass()) and dmginfo:IsBulletDamage() then
	target:SetHealth(math.Clamp(target:Health() - (dmginfo:GetDamage() * 0.25), 1, target:GetMaxHealth()))
end
if target:IsNPC() and table.HasValue(KillableArmorClass, target:GetClass()) and dmginfo:IsBulletDamage() then
	target:SetHealth(target:Health() - (dmginfo:GetDamage() * 0.25))
end
if target:GetClass() == "npc_turret_floor" and target:Health() == 1 then
	target:Fire("selfdestruct","",0.1)
end
if target:GetClass() == "npc_rollermine" and target:Health() <= 1 then
	dmginfo:SetDamageType(DMG_BLAST)
end
if target:IsPlayer() and target:Armor() > 0 and dmginfo:IsBulletDamage() then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
end
end

if Atk:IsPlayer() and Atk:GetNWString("Tier 3 Perk") == "Commando" then
local MeleeTypes = {"melee", "fist", "melee2", "knife"}
if table.HasValue(MeleeTypes, Atk:GetActiveWeapon():GetHoldType()) then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
end
end

if dmginfo:IsExplosionDamage() and target:GetNWString("Tier 2 Perk") == "Blast Shield" then
	ResTimers(dmginfo:GetAttacker(), false)
if Atk:GetNWString("Tier 2 Perk") != "Danger Close" then
	dmginfo:SetDamage(dmginfo:GetDamage() * 0.55)
end
end

if dmginfo:IsBulletDamage() and target:GetNWString("Tier 2 Perk") == "Juggernaut" then
	ResTimers(dmginfo:GetAttacker(), true)
if Atk:IsPlayer() and Atk:GetNWString("Tier 2 Perk") != "Stopping Power" then
	dmginfo:SetDamage(dmginfo:GetDamage() * 0.75)
end
end

if target:GetNWInt("QFHealth", 0) > 0 then
	target:SetNWInt("QFHealth", math.Clamp(target:GetNWInt("QFHealth", 0) - dmginfo:GetDamage(), 0, target:GetMaxHealth() + 20))
end

if Atk:IsPlayer() and Atk:GetNWString("Tier 2 Perk") == "Stopping Power" then
if dmginfo:IsBulletDamage() and target:GetNWString("Tier 2 Perk") != "Juggernaut" then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
end
end

if Atk:IsPlayer() and Atk:GetNWString("Tier 2 Perk") == "Danger Close" then
if dmginfo:IsExplosionDamage() and target:GetNWString("Tier 2 Perk") != "Blast Shield" then
	dmginfo:SetDamage(dmginfo:GetDamage() * 1.25)
end
end

if dmginfo:IsFallDamage() and dmginfo:GetDamage() <= 25 and target:GetNWString("Tier 1 Perk") == "Lightweight" then
	dmginfo:SetDamage(0)
elseif dmginfo:IsFallDamage() and dmginfo:GetDamage() > 25 and dmginfo:GetDamage() < target:GetMaxHealth() and target:GetNWString("Tier 1 Perk") == "Lightweight" then
	dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
end

end)

if ConVarExists("CODPerksIconXPos") then
	IconXPos = GetConVar("CODPerksIconXPos"):GetFloat()
else
	IconXPos = 0.45
end
if ConVarExists("CODPerksIconYPos") then
	IconYPos = GetConVar("CODPerksIconYPos"):GetFloat()
else
	IconYPos = 0.5
end

if CLIENT then

local p = LocalPlayer()
local JugRes = Material("juggernaut.png")
local JugResTimer = 0
local BlstShld = Material("blastshield.png")
local BlstResTimer = 0
local JugAlpha = 0
local BlstShldAlpha = 0

net.Receive("ResTimers", function()
	IsJug = net.ReadBool()
if IsJug then
	JugResTimer = CurTime() + 1.5
else
	BlstResTimer = CurTime() + 1.5
end
end)

hook.Add("HUDPaint", "ResIcons", function()

if JugResTimer > CurTime() and p:GetNWInt("LootTimer", 0) < CurTime() and BlstResTimer < CurTime() then
	JugAlpha = 255
elseif JugResTimer < CurTime() then
	JugAlpha = math.Clamp(JugAlpha - 1, 0, 255)
end

if JugAlpha > 0 then
	surface.SetMaterial(JugRes)
	surface.SetDrawColor( 255, 255, 255, JugAlpha)
	surface.DrawTexturedRect( ScrW() * IconXPos, ScrH() * IconYPos, 64, 48 )
end

if BlstResTimer > CurTime() and p:GetNWInt("LootTimer", 0) < CurTime() and JugResTimer < CurTime() then
	BlstShldAlpha = 255
elseif BlstResTimer < CurTime() then
	BlstShldAlpha = math.Clamp(BlstShldAlpha - 1, 0, 255)
end
if BlstShldAlpha > 0 then
	surface.SetMaterial(BlstShld)
	surface.SetDrawColor( 255, 255, 255, BlstShldAlpha)
	surface.DrawTexturedRect( ScrW() * IconXPos, ScrH() * IconYPos, 64, 64 )
end
end)

end