local SprintStarted = false
local StaminUpSet = false
local StaminUpWalk = false
local JugSet = false

local ReloadStarted = false

local AcceptedAmmo = {1, 3, 4, 5, 6, 7, 13, 14}

local BrainRotImmune = {"npc_antlionguard", "npc_strider", "npc_helicopter", "npcc_barnacle", "noc_combine_camera", "npc_hunter", "npc_ministrider", "npc_turret_ceiling", "npc_turret_floor", "npc_turret_ground", "npc_clawscanner", "npc_cscanner", "npc_manhack"}

if SERVER then

hook.Add("EntityFireBullets", "TestingDoubleTap", function(entity, data)

if entity:IsPlayer() and entity:GetNWString("Perk3") == "Double Tap" then
	Val1 = entity:GetActiveWeapon():GetNextPrimaryFire() - CurTime()
	Val2 = Val1 * 0.2
	Val3 = entity:GetActiveWeapon():GetNextPrimaryFire() - Val2
if Val3 > CurTime() then
	entity:GetActiveWeapon():SetNextPrimaryFire(Val3)
else
	entity:GetActiveWeapon():SetNextPrimaryFire(CurTime() + 0.05)
end
end

end)

hook.Add("AllowPlayerPickup", "PreventVulturePickup", function(ply, ent)

if ent:GetName() == "Vulture's Aid" then
	return false
end

end)

hook.Add("ScalePlayerDamage", "DeadshotPly", function(ply,hitgroup,dmginfo)
if dmginfo:GetAttacker():GetNWString("Perk4") == "Deadshot Daquiri" and hitgroup == HITGROUP_HEAD then
	dmginfo:SetDamage(dmginfo:GetDamage() * 2)
end
end)
hook.Add("ScaleNPCDamage", "DeadshotNPC", function(npc,hitgroup,dmginfo)
if dmginfo:GetAttacker():GetNWString("Perk4") == "Deadshot Daquiri" and hitgroup == HITGROUP_HEAD then
	dmginfo:SetDamage(dmginfo:GetDamage() * 2)
end
end)

hook.Add("DoAnimationEvent","CODPerksAnimationEvent",function( ply, event, data )
	
if IsValid(ply) and ply:Alive() then

local wep = ply:GetActiveWeapon()

if event != 3 and event != 4 then
	ReloadStarted = false
end

if ply:GetNWString("Perk5") == "Electric Cherry" and IsValid(wep) and ply:KeyPressed(IN_RELOAD) then

local mag = ply:GetActiveWeapon():Clip1()
local maxmag = ply:GetActiveWeapon():GetMaxClip1()
local ammo = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
local RandomSound = {"zap5.wav", "zap6.wav", "zap7.wav", "zap8.wav", "zap9.wav"}
local Sound = table.Random(RandomSound)

if (event == 3 or event == 4) and ReloadStarted == false and ammo > 0 then
	ShockRadius = 360 - (360 * (mag / maxmag))
for _,Shocked in pairs(ents.FindInSphere(ply:GetPos(), ShockRadius)) do
if Shocked:IsNPC() and Shocked:Disposition(ply) == D_HT then
	local Shocker = DamageInfo()
	Shocker:SetDamage(30)
	Shocker:SetAttacker(ply)
	Shocker:SetDamageType(DMG_SHOCK)
	Shocked:TakeDamageInfo(Shocker)
	local Shock = EffectData()
	Shock:SetEntity(Shocked)
	Shock:SetMagnitude(15)
	Shock:SetScale(15)
	util.Effect( "TeslaHitboxes", Shock)
end
end
	local Shock = EffectData()
	Shock:SetEntity(Shocked)
	Shock:SetMagnitude(15)
	Shock:SetScale(15)
	Shock:SetEntity(ply)
	util.Effect( "TeslaHitboxes", Shock)
	ply:EmitSound(Sound)
	ReloadStarted = true
end

end

end

end)

hook.Add("Think", "Perk-A-Colas", function()

for _,ply in pairs(player.GetAll()) do

local wep = ply:GetActiveWeapon()

for _,BrainRot in pairs(ents.FindByClass("npc_*")) do

if IsValid(BrainRot) and BrainRot:GetNWInt("BrainRotTimer", math.huge) < CurTime() and BrainRot:GetNWBool("BrainRot", false) == true then
BrainRot:SetHealth(1)
local RotExplosion = ents.Create("env_explosion")
RotExplosion:SetPos(BrainRot:GetPos())
RotExplosion:SetKeyValue( "fireballsprite", "effects/fire_cloud2.vmt" )
RotExplosion:SetKeyValue( "spawnflags", bit.bor(RotExplosion:GetSpawnFlags() + 48) )
RotExplosion:SetKeyValue( "IMagnitude", 75 )
RotExplosion:SetKeyValue( "IRadiusOverride", 250 )
RotExplosion:SetOwner(BrainRot)
RotExplosion:SetName("Rot Explosion")
RotExplosion:Spawn()
RotExplosion:Fire( "Explode", 0, 0 )
BrainRot:SetNWBool("BrainRot", false)
end

if BrainRot:GetNWInt("BrainRotTeam", -1) == ply:Team() and BrainRot:GetNWBool("BrainRot", false) == true and BrainRot:GetNWInt("BrainRotTimer", 0) > CurTime() then

for _,Targets in pairs(ents.FindByClass("npc_*")) do
if Targets != BrainRot and Targets:IsNPC() and Targets:Disposition(BrainRot) != D_HT and Targets:Disposition(ply) == D_HT and Targets:Disposition(BrainRot) != D_HT then
	Targets:AddEntityRelationship(BrainRot, D_HT, 0)
	BrainRot:AddEntityRelationship(Targets, D_HT, 0)
end
if Targets:IsNPC() and (Targets:Disposition(BrainRot) == D_HT or Targets:Disposition(BrainRot) == D_FR) and Targets:Disposition(ply) == D_LI and BrainRot:Disposition(Targets) != D_LI and Target:GetSquad() == "BrainRot" then
	BrainRot:AddEntityRelationship(Targets, D_LI, 0)
	Targets:AddEntityRelationship(BrainRot, D_LI, 0)
end
end
end

if BrainRot:GetNWInt("BrainRotTeam", -1) != ply:Team() and BrainRot:GetNWBool("BrainRot", false) == true and BrainRot:GetNWInt("BrainRotTimer", 0) > CurTime() then
if BrainRot:Disposition(ply) != D_HT then
	BrainRot:AddEntityRelationship(ply, D_HT, 1)
end
end

if ply:Team() == BrainRot:GetNWInt("BrainRotTeam", -1) and BrainRot:Disposition(ply) != D_LI then
	BrainRot:AddEntityRelationship(ply, D_LI, 1)
end

end

for _,VultAid in pairs(ents.FindByClass("prop_physics*")) do
if VultAid:GetName() == "Vulture's Aid" then
if ply:GetNWString("Perk7") == "Vulture Aid" and VultAid:GetNoDraw() == true then
	VultAid:SetNoDraw(false)
elseif ply:GetNWString("Perk7") != "Vulture Aid" and VultAid:GetNoDraw() == false then
	VultAid:SetNoDraw(true)
end
if ply:GetNWString("Perk7") == "Vulture Aid" and IsValid(wep) and table.HasValue(AcceptedAmmo, wep:GetPrimaryAmmoType()) and ply:GetPos():Distance(VultAid:GetPos()) < 64 then
	VultAid:Remove()
	ply:GiveAmmo(math.Clamp(wep:GetMaxClip1() * 0.1, 1, math.huge), wep:GetPrimaryAmmoType())
end
end
end

if ply:GetNWString("Perk5") != "Electric Cherry" or (ReloadStarted == true and wep:Clip1() >= ply:GetActiveWeapon():GetMaxClip1()) then
	ReloadStarted = false
end

if ply:GetNWString("Perk5") == "Electric Cherry" and IsValid(wep) and ply:KeyPressed(IN_RELOAD) and ReloadStarted == false then
local mag = ply:GetActiveWeapon():Clip1()
local maxmag = ply:GetActiveWeapon():GetMaxClip1()
local ammo = ply:GetAmmoCount(wep:GetPrimaryAmmoType())

local RandomSound = {"zap5.wav", "zap6.wav", "zap7.wav", "zap8.wav", "zap9.wav"}
local Sound = table.Random(RandomSound)

if mag < maxmag and ammo > 0 then
	ShockRadius = 360 - (360 * (mag / maxmag))
for _,Shocked in pairs(ents.FindInSphere(ply:GetPos(), ShockRadius)) do
if Shocked:IsNPC() and Shocked:Disposition(ply) == D_HT then
	local Shocker = DamageInfo()
	Shocker:SetDamage(30)
	Shocker:SetAttacker(ply)
	Shocker:SetDamageType(DMG_SHOCK)
	Shocked:TakeDamageInfo(Shocker)
	local Shock = EffectData()
	Shock:SetEntity(Shocked)
	Shock:SetMagnitude(15)
	Shock:SetScale(15)
	util.Effect( "TeslaHitboxes", Shock)
end
end
	local Shock = EffectData()
	Shock:SetMagnitude(15)
	Shock:SetScale(15)
	Shock:SetEntity(ply)
	util.Effect( "TeslaHitboxes", Shock)
	ply:EmitSound(Sound)
	ReloadStarted = true
end

end

if ply:GetNWString("Perk1") == "Juggernog" and JugSet == false then
	ply:SetMaxHealth(250)
	ply:SetHealth(math.Clamp(ply:Health() + (ply:GetMaxHealth() - ply:Health()), 0, ply:GetMaxHealth()))
	JugSet = true
elseif ply:GetNWString("Perk1") != "Juggernog" and JugSet != false then
	ply:SetHealth(math.Clamp(ply:Health(), 0, 100))
	ply:SetMaxHealth(100)
	JugSet = false
end

for _,BoolNPC in pairs(ents.FindByClass("npc_*")) do
if ply:GetNWString("Perk8") == "Death Perception" and BoolNPC:GetPos():Distance(ply:GetPos()) <= 256 and BoolNPC:IsNPC() and BoolNPC:Disposition(ply) == D_HT then
	BoolNPC:SetNWBool("DeathPer", true)
else
	BoolNPC:SetNWBool("DeathPer", false)
end
end

end

end)

hook.Add("EntityTakeDamage", "DTPhDF", function( target, dmginfo )

local Atk = dmginfo:GetAttacker()

if dmginfo:IsBulletDamage() and Atk:GetNWString("Perk9") == "Elemental Pop" then
	ElementChance = 20 < math.random(0, 100)
	RandomElement = math.random(1, 4)
if ElementChance then
if RandomElement == 1 and !dmginfo:IsDamageType(8) then
	dmginfo:SetDamageType(dmginfo:GetDamageType() + 8)
	target:Ignite(5)
elseif RandomElement == 2 and !dmginfo:IsDamageType(256) then
	dmginfo:SetDamageType(dmginfo:GetDamageType() + 256)
for _,Shocked in pairs(ents.FindInSphere(target:GetPos(), 80)) do
if Shocked:IsNPC() and Shocked:Disposition(Atk) == D_HT then
	local Shocker = DamageInfo()
	Shocker:SetDamage(30)
	Shocker:SetAttacker(dmginfo:GetAttacker())
	Shocker:SetDamageType(DMG_SHOCK)
	Shocked:TakeDamageInfo(Shocker)
	local Shock = EffectData()
	Shock:SetEntity(Shocked)
	Shock:SetMagnitude(15)
	Shock:SetScale(15)
	util.Effect( "TeslaHitboxes", Shock)
end
end
elseif RandomElement == 3 and !dmginfo:IsDamageType(131072) then
	dmginfo:SetDamageType(dmginfo:GetDamageType() + 131072)
if target:IsNPC() and !table.HasValue(BrainRotImmune, target:GetClass()) and target:GetNWBool("BrainRot", false) == false then
	target:SetNWBool("BrainRot", true)
	target:SetNWInt("BrainRotTimer", CurTime() + 10)
	target:SetNWInt("BrainRotTeam", dmginfo:GetAttacker():Team())
	target:SetColor(Color(76, 153, 0))
	target:SetSquad("BrainRot")
	target:SetHealth(target:GetMaxHealth())
end
elseif RandomElement == 4 and !dmginfo:IsDamageType(64) then
	dmginfo:SetDamageType(dmginfo:GetDamageType() + 64)
	local PopPop = ents.Create("env_explosion")
	PopPop:SetPos(target:GetPos())
	PopPop:SetKeyValue( "spawnflags", bit.bor(PopPop:GetSpawnFlags() + 316) )
	PopPop:SetKeyValue( "IMagnitude", 30 )
	PopPop:SetKeyValue( "IRadiusOverride", 150 )
	PopPop:SetOwner(dmginfo:GetAttacker())
	PopPop:SetName("Pop Explosion")
	PopPop:Spawn()
	PopPop:Fire( "Explode", 0, 0 )
end	
end
end

if dmginfo:IsBulletDamage() and Atk:GetNWString("Perk3") == "Double Tap" then
	dmginfo:SetDamage(dmginfo:GetDamage() * 2)
end

if dmginfo:IsExplosionDamage() and target:GetNWString("Perk6") == "PhD Flopper" then
dmginfo:SetDamage(0)
end
if dmginfo:IsFallDamage() and target:GetNWString("Perk6") == "PhD Flopper" then
if dmginfo:GetDamage() > 0 then
PhDBlowup = ents.Create("env_explosion")
PhDBlowup:SetPos(target:GetPos())
PhDBlowup:SetKeyValue( "fireballsprite", "effects/fire_cloud2.vmt" )
PhDBlowup:SetKeyValue( "spawnflags", bit.bor(PhDBlowup:GetSpawnFlags() + 32) )
PhDBlowup:SetKeyValue( "IMagnitude", 150 )
PhDBlowup:SetKeyValue( "IRadiusOverride", 394 )
PhDBlowup:SetOwner(target)
PhDBlowup:SetName("PhD Explosion")
PhDBlowup:Spawn()
PhDBlowup:Fire( "Explode", 0, 0 )
dmginfo:SetDamage(0)
end
end

end)

hook.Add( "Move", "PerkAColasMovement", function( ply, mv )

if ply:Alive() then
if RunSpeed == nil then
	RunSpeed = ply:GetRunSpeed()
end
if WalkSpeed == nil then
	WalkSpeed = ply:GetWalkSpeed()
end
end

if ply:IsSuitEquipped() and GetConVar("gmod_suit"):GetBool() then
if ply:GetNWString("Perk2") == "Stamin-Up" and ply:IsSprinting() and ply:GetVelocity():LengthSqr() > 0 then
	ply:SetSuitPower(ply:GetSuitPower() + 0.09375)
end
end

if ply:GetNWString("Perk2") == "Stamin-Up" and !GetConVar("gmod_suit"):GetBool() and StaminUpSet == false then
	ply:SetRunSpeed(ply:GetRunSpeed() * 1.2)
	StaminUpSet = true
elseif (ply:GetNWString("Perk2") != "Stamin-Up" or GetConVar("gmod_suit"):GetBool()) and StaminUpSet != false then
	ply:SetRunSpeed(RunSpeed)
	StaminUpSet = false
end

if ply:GetNWString("Perk2") == "Stamin-Up" and StaminUpWalk == false then
	ply:SetWalkSpeed(ply:GetWalkSpeed() * 1.07)
	StaminUpWalk = true
elseif ply:GetNWString("Perk2") != "Stamin-Up" and StaminUpWalk != false then 
	ply:SetWalkSpeed(WalkSpeed)
	StaminUpWalk = false
end

end)

hook.Add( "OnNPCKilled", "VultureAidAmmo", function( npc, attacker )

VultureList = 0

if !game.SinglePlayer() then
for _,PlyPerk in pairs(player.GetAll()) do
if PlyPerk:GetNWString("Perk7") == "Vulture Aid" then
	VultureList = VultureList + 1
end
end
end

if (game.SinglePlayer() and Entity(1):IsPlayer() and Entity(1):GetNWString("Perk7") == "Vulture Aid") or (!game.SinglePlayer() and VultureList >= 1) then
local VultureAidDrop = ents.Create("prop_physics")
VultureAidDrop:SetPos(npc:WorldSpaceCenter())
VultureAidDrop:SetCollisionGroup(2)
if IsValid(attacker) and (attacker:IsNPC() or attacker:IsPlayer()) then
	VultureAidDrop:SetOwner(attacker)
end
VultureAidDrop:SetName("Vulture's Aid")
VultureAidDrop:SetModel("models/Items/BoxMRounds.mdl")
VultureAidDrop:Spawn()
VultureAidDrop:GetPhysicsObject():SetVelocity(Vector(math.Rand(-250,250),math.Rand(-250,250),25))
VultureAidDrop:SetNWBool("VultureDrop", true)
constraint.Keepupright(VultureAidDrop, VultureAidDrop:GetAngles(), 0, 100)
end

end)

end

if CLIENT then

hook.Add("Think", "DeathPerceptionClient", function()

for _,DP in pairs(ents.FindByClass("npc*")) do
if LocalPlayer():GetNWString("Perk8") == "Death Perception" and DP:IsNPC() and DP:GetNWBool("DeathPer", false) == true and DP:GetPos():Distance(LocalPlayer():GetPos()) <= 256 then
	DP:SetNWBool("DeathPerception", true)
elseif LocalPlayer():GetNWString("Perk8") != "Death Perception" or DP:GetNWBool("DeathPer", false) == false or DP:GetPos():Distance(LocalPlayer():GetPos()) > 256 then
	DP:SetNWBool("DeathPerception", false)
end
end

end)

end