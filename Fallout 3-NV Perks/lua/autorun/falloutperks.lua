local StrangerNoTarget = {"npc_turret_floor", "npc_rollermine", "npc_helicopter", "npc_combinegunship", "npc_combinedropship", "prop_vehicle_apc", "npc_manhack", "npc_cscanner", "npc_strider", "npc_hunter"}
local RobotTarget = {"npc_manhack", "npc_cscanner", "npc_turret_floor", "npc_rollermine"}
local PurifierTable = {"npc_antlion", "npc_antlion_worker", "npc_antlionguard", "npc_fastzombie", "npc_fastzombie_torso", "npc_headcrab", "npc_headcrab_black", "npc_headcrab_fast", "npc_poisonzombie", "npc_zombie", "npc_zombie_torso", "npc_zombine", "npc_antlionguardian"}
local AdamantiumLimbs = {4, 5, 6, 7}
local MeleeTypes = {"melee", "fist", "melee2", "Knife"}
local StrangerExists = false
local CannibalRate = 0
local GhoulCannibalRate = 0
local TribalCannibalRate = 0
local TurretDisable = 0 // Stuffing this many local variables into one file is a bad idea, but IDGAF
// I'm not making a different file for each perk or some shit

function PlyHasPerk(p, perk)
local FindPerk = string.find(p:GetNWString("Fallout Perk"), perk)

if FindPerk != nil then
	return true
else
	return false
end
end

function PerformCannibalism(p, rag, eyepos, bloodtype)

if IsValid(p) and p:Alive() then

p:SetNWInt("Cannibalizing", bloodtype)
p:EmitSound("falloutcannibal.mp3")
p:ConCommand("+duck")
if p:GetEyeTrace().Entity:GetClass() == "prop_ragdoll" then
	EP = p:GetEyeTrace().HitPos
else
	EP = rag:GetPos()
end
ED = EffectData()
ED:SetEntity(rag)
ED:SetOrigin(EP)
util.Effect("BloodImpact", ED)
rag:GetPhysicsObject():SetVelocity(p:GetAimVector() * (-900 / rag:GetPhysicsObject():GetMass()))
print(rag:GetPhysicsObject():GetMass())
print(-900 / rag:GetPhysicsObject():GetMass())
if bloodtype == 1 then
	util.Decal("Blood", p:EyePos(), rag:GetPos(), p)
	timer.Simple(4, function() if IsValid(p) and p:Alive() and p:GetNWInt("Cannibalizing", 0) == 1 then p:SetHealth(math.Clamp(p:Health() + 10, 0, p:GetMaxHealth())) util.Effect("BloodImpact", ED) util.Decal("Blood", p:EyePos(), rag:GetPos(), p) end end)
	timer.Simple(8, function() if IsValid(p) and p:Alive() and p:GetNWInt("Cannibalizing", 0) == 1 then p:SetHealth(math.Clamp(p:Health() + 15, 0, p:GetMaxHealth())) p:SetNWInt("Cannibalizing", 0) p:ConCommand("-duck") end end)
elseif bloodtype == 2 then
	util.Decal("YellowBlood", p:EyePos(), eyepos, p)
	timer.Simple(4, function() if IsValid(p) and p:Alive() and p:GetNWInt("Cannibalizing", 0) == 2 then p:SetHealth(math.Clamp(p:Health() + 20, 0, p:GetMaxHealth())) util.Effect("BloodImpact", ED) util.Decal("YellowBlood", p:EyePos(), eyepos, p) end end)
	timer.Simple(8, function() if IsValid(p) and p:Alive() and p:GetNWInt("Cannibalizing", 0) == 2 then p:SetHealth(math.Clamp(p:Health() + 30, 0, p:GetMaxHealth())) p:SetNWInt("Cannibalizing", 0) p:ConCommand("-duck") end end)
elseif bloodtype == 3 then
	util.Decal("YellowBlood", p:EyePos(), eyepos, p)
	timer.Simple(4, function() if IsValid(p) and p:Alive() and p:GetNWInt("Cannibalizing", 0) == 3 then p:SetHealth(math.Clamp(p:Health() + 4, 0, p:GetMaxHealth())) util.Effect("BloodImpact", ED) util.Decal("YellowBlood", p:EyePos(), eyepos, p) end end)
	timer.Simple(8, function() if IsValid(p) and p:Alive() and p:GetNWInt("Cannibalizing", 0) == 3 then p:SetHealth(math.Clamp(p:Health() + 8, 0, p:GetMaxHealth())) p:SetNWInt("Cannibalizing", 0) p:ConCommand("-duck") end end)
end

FemaleDisgust = {"gethellout.wav", "goodgod.wav", "gordead_ans04.wav", "gordead_ans19.wav", "gordead_ques13.wav", "notthemanithought01.wav", "notthemanithought02.wav", "wetrustedyou01.wav", "wetrustedyou02.wav"}
MaleDisgust = {"gethellout.wav", "goodgod.wav", "gordead_ans04.wav", "gordead_ans19.wav", "gordead_ques13.wav", "notthemanithought01.wav", "notthemanithought02.wav", "wetrustedyou01.wav", "wetrustedyou02.wav"}
Barney = {"ba_danger02.wav", "ba_no01.wav", "ba_no02.wav", "ba_pain09.wav"}
ImmuneAlly = {"npc_alyx", "npc_monk", "npc_barney"}
ImmuneGeneric = {"npc_turret_floor", "npc_antlion", "npc_antlion_worker"}
CannibalSndChance = math.Rand(1, 100)

for _,ally in pairs(ents.FindInSphere(p:GetPos(), 512)) do
if (bloodtype == 1 or bloodtype == 2) and ally:IsNPC() and ally:Disposition(p) == D_LI and !table.HasValue(ImmuneAlly, ally:GetClass()) and !table.HasValue(ImmuneGeneric, ally:GetClass()) and ally:GetNWBool("Stranger", false) == false then
	ally:AddEntityRelationship(p, D_HT, 1)
	ally:Fire("RemoveFromPlayerSquad","",0.1)
if ally:GetClass() == "npc_citizen" and string.find(ally:GetModel(), "female") and CannibalSndChance >= GetConVar("FalloutCannibalReactChance"):GetInt() then
	ally:EmitSound("vo/npc/female01/" .. table.Random(FemaleDisgust))
end
if ally:GetClass() == "npc_citizen" and !string.find(ally:GetModel(), "female") and string.find(ally:GetModel(), "male") and CannibalSndChance >= GetConVar("FalloutCannibalReactChance"):GetInt() then
	ally:EmitSound("vo/npc/male01/" .. table.Random(MaleDisgust))
end
end
if ally:IsNPC() and ally:Disposition(p) == D_LI and table.HasValue(ImmuneAlly, ally:GetClass()) and CannibalSndChance >= GetConVar("FalloutCannibalReactChance"):GetInt() then
if ally:GetClass() == "npc_alyx" then
	ally:EmitSound("vo/alyx/ohgod01.wav")
elseif ally:GetClass() == "npc_barney" then
	ally:EmitSound("vo/npc/barney/" .. table.Random(Barney))
end
end
end
end

end

hook.Add("EntityTakeDamage", "FalloutDMGPerks", function( target, dmginfo )

local Atk = dmginfo:GetAttacker()
DMGBuff = 1
DMGRes = 1

local MaleTargets = {"npc_barney", "npc_breen", "npc_breen", "npc_kleiner", "npc_magnusson", "npc_combine_s", "npc_metropolice", "npc_breen", "npc_odessa", "npc_monk"}
local FemaleTargets = {"npc_alyx", "npc_mossman"}
local Entomology = {"npc_antlion", "npc_antlionguard", "npc_antlion_worker", "npc_antlionguardian"}
local TribalResistance = {"npc_antlion", "npc_antlionguard", "npc_antlion_worker", "npc_headcrab", "npc_headcrab_black", "npc_headcrab_fast"}
local GruntAmmo = {1, 3, 4, 6, 13, 14}

if Atk:IsNPC() and Atk:GetNWBool("Stranger", false) == true then
	dmginfo:ScaleDamage(1.25)
end

if Atk:IsPlayer() then
	Wep = Atk:GetActiveWeapon()

if PlyHasPerk(Atk, "01 ") == true and (target:IsNPC() or target:IsPlayer()) then
if table.HasValue(FemaleTargets, target:GetClass()) or string.find(target:GetModel(), "female") or (target:IsPlayer() and target:GetNWString("FalloutGender") == "Female") then
	DMGBuff = DMGBuff + 0.1	
end
end
if PlyHasPerk(Atk, "02 ") == true and (target:IsNPC() or target:IsPlayer()) then
if (table.HasValue(MaleTargets, target:GetClass()) or (string.find(target:GetModel(), "male") or (target:IsPlayer() and target:GetNWString("FalloutGender") == "Male")) and !string.find(target:GetModel(), "female")) then
	DMGBuff = DMGBuff + 0.1
end
end
if PlyHasPerk(Atk, "03 ") == true then
if dmginfo:IsExplosionDamage() or (dmginfo:IsDamageType(DMG_SLASH + DMG_CLUB) and Wep:GetSlot() == 0) then
	DMGBuff = DMGBuff + 0.15
end
end
if PlyHasPerk(Atk, "04 ") == true and target:IsNPC() then
if table.HasValue(Entomology, target:GetClass()) then
	DMGBuff = DMGBuff + 0.5
end
end
if PlyHasPerk(Atk, "05 ") == true and (target:IsNPC() or target:IsPlayer()) then
if Wep:GetClass() == "weapon_fists" or (IsValid(Wep:GetHoldType()) and Wep:GetHoldType() == "fist") then
	DMGBuff = DMGBuff + 0.15
end
end
if PlyHasPerk(Atk, "07 ") == true and dmginfo:IsExplosionDamage() then
	DMGBuff = DMGBuff + 0.2
end
if PlyHasPerk(Atk, "10 ") == true and target:IsNPC() and !table.HasValue(StrangerNoTarget, target:GetClass()) and target:Health() <= GetConVar("FalloutStrangerHPLimit"):GetInt() and target:Health() > 0 and StrangerExists == false then
StrangerChance = math.random(1, 100)
if StrangerChance <= 10 then
	CreateStranger(target, Atk)
end
end
if PlyHasPerk(Atk, "11 ") == true and Atk:Health() <= Atk:GetMaxHealth() * 0.2 then
if Wep:GetClass() == "weapon_fists" or (IsValid(Wep:GetHoldType()) and Wep:GetHoldType() == "fist") then
	DMGBuff = DMGBuff + 0.25
end
end
if PlyHasPerk(Atk, "12 ") == true and dmginfo:IsDamageType(DMG_BURN) then
	DMGBuff = DMGBuff + 0.5
end
if PlyHasPerk(Atk, "15 ") == true and table.HasValue(RobotTarget, target:GetClass()) then
	DMGBuff = DMGBuff + 0.25
end
if PlyHasPerk(Atk, "17 ") == true and dmginfo:IsDamageType(DMG_ENERGYBEAM + DMG_PLASMA + DMG_DISSOLVE) then
	DMGBuff = DMGBuff + 0.1
end
if PlyHasPerk(Atk, "20 ") == true and IsValid(Wep) and (Wep:GetPrimaryAmmoType() == 5 or (IsValid(Wep:GetHoldType()) and Wep:GetHoldType() == "knife") or Wep:GetPrimaryAmmoType() == 7) then
	DMGBuff = DMGBuff + 0.25
end
if PlyHasPerk(Atk, "21 ") == true and (target:GetClass() == "npc_citizen" or target:GetClass() == "npc_combine_s") then
	DMGBuff = DMGBuff + 0.05
end
if PlyHasPerk(Atk, "25 ") == true and target:IsNPC() then
if dmginfo:IsDamageType(DMG_SLASH + DMG_CLUB) and table.HasValue(PurifierTable, target:GetClass()) and ((IsValid(Wep:GetHoldType()) and table.HasValue(MeleeTypes, Wep:GetHoldType())) or Wep:GetSlot() == 0) then
	DMGBuff = DMGBuff + 0.5
end
end
if PlyHasPerk(Atk, "27 ") == true and (((IsValid(Wep:GetHoldType()) and table.HasValue(MeleeTypes, Wep:GetHoldType()))
 or Wep:GetSlot() == 0) or ((dmginfo:GetInflictor():GetClass() == "crossbow_bolt" or dmginfo:GetInflictor():GetClass() == "npc_grenade_frag" or dmginfo:GetInflictor():GetClass() == "rpg_missile") and dmginfo:GetInflictor():GetOwner() == Atk) or table.HasValue(GruntAmmo, dmginfo:GetAmmoType())) then
	DMGBuff = DMGBuff + 0.25
end
	dmginfo:ScaleDamage(DMGBuff)
end

if target:IsPlayer() then
if (Atk:IsNPC() or Atk:IsPlayer()) and IsValid(Atk:GetActiveWeapon()) then
	Wep = Atk:GetActiveWeapon()
end
if target:GetNWInt("Cannibalizing", 0) > 0 then
	target:ConCommand("-duck")
	target:SetNWInt("Cannibalizing", 0)
	target:StopSound("falloutcannibal.mp3")
end
if PlyHasPerk(target, "06 ") == true then
	DMGRes = DMGRes - 0.1
end
if PlyHasPerk(target, "08 ") == true and dmginfo:IsDamageType(DMG_RADIATION) then
	DMGRes = DMGRes - 0.25
end
if PlyHasPerk(target, "11 ") == true and target:Health() <= target:GetMaxHealth() * 0.2 then
	DMGRes = DMGRes - 0.5
end
if PlyHasPerk(target, "17 ") == true then
	DMGRes = DMGRes - 0.1
if dmginfo:IsDamageType(DMG_POISON + DMG_RADIATION) then
	DMGRes = DMGRes - 0.1
end
end
if PlyHasPerk(target, "18 ") == true and !dmginfo:IsDamageType(DMG_FALL) and table.HasValue(AdamantiumLimbs, target:LastHitGroup()) then
	DMGRes = DMGRes - 0.5
end
if PlyHasPerk(target, "22 ") == true and dmginfo:IsDamageType(DMG_GENERIC + DMG_SLASH + DMG_CLUB) and ((IsValid(Wep:GetHoldType()) and table.HasValue(MeleeTypes, Wep:GetHoldType())) or Wep:GetSlot() == 0) then
	DMGRes = DMGRes - 0.05
end
if PlyHasPerk(target, "24 ") == true and dmginfo:IsExplosionDamage() then
	DMGRes = DMGRes - 0.25
end
if PlyHasPerk(target, "28 ") == true then
if table.HasValue(TribalResistance, Atk:GetClass()) then
	DMGRes = DMGRes - 0.5
end
if dmginfo:IsDamageType(DMG_POISON) then
	DMGRes = DMGRes - 0.25
end
end
if PlyHasPerk(Atk, "29 ") == true and dmginfo:GetAmmoType() == 7 then
	DMGRes = DMGRes + 0.1
end
if PlyHasPerk(Atk, "31 ") == true and dmginfo:IsDamageType(DMG_GENERIC + DMG_SLASH + DMG_CLUB) and ((IsValid(Wep:GetHoldType()) and table.HasValue(MeleeTypes, Wep:GetHoldType())) or Wep:GetSlot() == 0) then
	DMGRes = DMGRes + 0.15
end
	DMGRes = math.Clamp(DMGRes, 0.15, 1)
	dmginfo:ScaleDamage(DMGRes)
end

if target:IsNPC() and target:GetNWBool("FerociousLoyalty", false) == true then
	dmginfo:ScaleDamage(0.5)
end
if target:IsNPC() and target:Disposition(Atk) == D_LI and Atk:IsPlayer() and PlyHasPerk(Atk, "26 ") == true then
if target:GetSquad() == "player_squad" then
	dmginfo:ScaleDamage(0.75)
end
end

end)

function CreateStranger(Target, Ply)
if !IsValid(Target) or !Ply:Alive() then
	StrangerExists = false
end
if IsValid(Target) and Ply:Alive() then
	RandX = math.Rand(-150, 150)
if RandX < 50 and RandX >= 0 then
	RandY = math.Rand(75, 150)
elseif RandX >= -50 and RandX < 0 then
	RandY = math.Rand(-150, -75)
else
	RandY = math.Rand(-150, 150)
end
	RandSpot = Target:GetPos() + Vector(RandX, RandY, 20)
	QTrace = util.QuickTrace(RandSpot, RandSpot - Vector(0,0,30))
	Spot = Vector(RandSpot + Vector(0,0,1))
	Stranger = ents.Create("npc_citizen")
if util.IsValidModel("models/npc/tfa_bc_mysteriousstranger.mdl") then
	StrangerModel = "models/npc/tfa_bc_mysteriousstranger.mdl"
else
	StrangerModel = "models/Humans/Group03/male_07.mdl"
end
end
if IsValid(Target) and Target:Health() <= GetConVar("FalloutStrangerHPLimit"):GetInt() and Target:Disposition(Ply) == D_HT and StrangerExists == false and (!Target:VisibleVec(Spot) or QTrace.StartSolid == true or !QTrace.HitWorld) then
	timer.Simple(0.1, function() CreateStranger(Target, Ply) end)
end
if IsValid(Target) and Target:OnGround() and !table.HasValue(StrangerNoTarget, Target:GetClass()) and Target:Health() <= GetConVar("FalloutStrangerHPLimit"):GetInt() and Target:VisibleVec(Spot) and Target:Disposition(Ply) == D_HT and StrangerExists == false then
	StrangerExists = true
	Stranger:SetPos(Spot)
	Stranger:PointAtEntity(Target)
	Stranger:Spawn()
	Stranger:SetAngles(Angle(0, Stranger:GetAngles().y, 0))
	Stranger:SetModel(StrangerModel)
	Stranger:Give("weapon_357")
	Stranger:SetHealth(10000)
	Stranger:SetTarget(Target)
	Stranger:SetNWBool("Stranger", true)
	Stranger:SetCurrentWeaponProficiency(4)
	SetNoTarget(Stranger)
	Ply:EmitSound("mysteriousstranger.ogg")
end
end

if SERVER then

hook.Add("PlayerAmmoChanged", "FalloutScroungerBonus", function(ply, ammo, old, new)

if old > new then return end

if ply:IsPlayer() and PlyHasPerk(ply, "30 ") == true then
if old < new then
AmmoRand = math.Rand(1, 100)
Ammo = new - old
if AmmoRand >= 25 then
	ply:GiveAmmo(math.ceil(AmmoGained * 0.5), ammo)
end
end
end

end)

function SetNoTarget(Target)
if IsValid(Target) then
for _,npc in pairs(ents.FindByClass("npc_*")) do
if npc != Target then
	npc:AddEntityRelationship(Target, D_NU, 1)
end
end
end
end

hook.Add("StartCommand", "CannibalNoMove", function(ply, cmd)

if ply:Alive() and ply:GetNWInt("Cannibalizing", 0) > 0 then
	cmd:ClearMovement()
end

end)

hook.Add("Think", "FalloutThinkPerks", function()

NoCannibalModels = {"models/humans/charple01.mdl", "models/humans/charple02.mdl", "models/humans/charple03.mdl", "models/humans/charple04.mdl", "models/humans/corpse1.mdl"}
GhoulScavengerOnly = {"models/zombie/zombie_soldier.mdl", "models/zombie/classic.mdl", "models/zombie/classic_torso.mdl", "models/zombie/fast.mdl", "models/gibs/fast_zombie_torso.mdl", "models/zombie/classic_legs.mdl", "models/gibs/fast_zombie_legs.mdl", "models/zombie/poison.mdl", "models/vortigaunt.mdl", "models/antlion_guard.mdl"}
TribalBirds = {"models/crow.mdl", "models/pigeon.mdl", "models/seagull.mdl", "models/headcrabblack.mdl"}

for _,ent in pairs(ents.FindByClass("prop_ragdoll")) do
if IsValid(ent) and ent:GetMaterialType() == 70 and !table.HasValue(NoCannibalModels, ent:GetModel()) and !table.HasValue(GhoulScavengerOnly, ent:GetModel()) and !table.HasValue(TribalBirds, ent:GetModel()) and ent:GetNWInt("CanCannibalize", 0) == 0 then
	ent:SetNWInt("CanCannibalize", 1)
end
if IsValid(ent) and (ent:GetModel() == "models/antlion_guard.mdl" or ent:GetMaterialType() == 70 or ent:GetMaterialType() == 72) and !table.HasValue(NoCannibalModels, ent:GetModel()) and table.HasValue(GhoulScavengerOnly, ent:GetModel()) and ent:GetNWInt("CanGhoulCannibalize", 0) == 0 then
	ent:SetNWInt("CanGhoulCannibalize", 1)
end
if IsValid(ent) and ((ent:GetMaterialType() == 65 and ent:GetModel() != "models/antlion_guard.mdl") or table.HasValue(TribalBirds, ent:GetModel()) or ent:GetMaterialType() == 72) and !table.HasValue(GhoulScavengerOnly, ent:GetModel()) and ent:GetNWInt("CanTribalCannibalize", 0) == 0 then
	ent:SetNWInt("CanTribalCannibalize", 1)
end
end

for _,Dude in pairs(ents.FindByClass("npc_citizen")) do
if Dude:IsNPC() and Dude:GetNWBool("Stranger", false) == true then
if !IsValid(Dude:GetTarget()) then
	timer.Simple(1, function() if IsValid(Dude) then StrangerExists = false Dude:Remove() end end)
end
end
end

for _,ply in pairs(player.GetAll()) do

if !ply:Alive() and ply:GetNWInt("Cannibalizing", 0) > 0 then
	ply:SetNWInt("Cannibalizing", 0)
end

if PlyHasPerk(ply, "13 ") == false and PlyHasPerk(ply, "23 ") == true then
	ply:SetNWString("Fallout Perk", string.Replace(ply:GetNWString("Fallout Perk"), "23 ", ""))
end

for _,NPC in pairs(ents.FindByClass("npc_*")) do
if IsValid(NPC) and NPC:IsNPC() and NPC:Health() > 0 then
if PlyHasPerk(ply, "21 ") == true then

if NPC:Disposition(ply) == D_HT and NPC:GetNWInt("Disp", 0) != 1 then
	NPC:SetNWInt("Disp", 1)
elseif NPC:Disposition(ply) == D_LI and NPC:GetNWInt("Disp", 0) != 3 then
	NPC:SetNWInt("Disp", 3)
elseif NPC:Disposition(ply) == D_NU and NPC:GetNWInt("Disp", 0) != 4 then
	NPC:SetNWInt("Disp", 4)
elseif (NPC:Disposition(ply) == D_FR or NPC:Disposition(ply) == D_ER) and NPC:GetNWInt("Disp", 0) != 0 then
	NPC:SetNWInt("Disp", 0)
end

end
end
end

if PlyHasPerk(ply, "19 ") == true and ply:Health() <= ply:GetMaxHealth() * 0.5 then
for _,Squad in pairs(ents.FindByClass("npc_*")) do
if Squad:GetSquad() == "player_squad" then
	Squad:SetNWBool("FerociousLoyalty", true)
else
	Squad:SetNWBool("FerociousLoyalty", false)
end
end
end

if IsValid(ply:GetEyeTrace().Entity) then
	EyeTrace = ply:GetEyeTrace().Entity
end

if PlyHasPerk(ply, "15 ") == true and IsValid(EyeTrace) and EyeTrace:GetClass() == "npc_turret_floor" then
	NPCVec = (EyeTrace:GetPos() - ply:GetPos()):GetNormalized():Angle().y
	PlyAng = EyeTrace:GetAngles().y
	Result = NPCVec - PlyAng
if Result > 360 then
	Result = Result - 360
elseif Result < 0 then
	Result = Result + 360
end
else
	Result = 0
end

if (Result <= 100 or Result >= 265) and IsValid(EyeTrace) and EyeTrace:GetClass() == "npc_turret_floor" and ply:Crouching() and ply:KeyDown(IN_USE) and EyeTrace:GetNWBool("Disabled", false) == false and EyeTrace:GetPos():Distance(ply:GetPos()) <= 70 then
	TurretDisable = math.Clamp(TurretDisable + 0.1, 0, 5)
else
	TurretDisable = 0
end

if TurretDisable == 5 and IsValid(EyeTrace) and EyeTrace:GetNWBool("Disabled", false) == false then
	EyeTrace:SetNWBool("Disabled", true)
	EyeTrace:Fire("disable","",0.1)
end

if PlyHasPerk(ply, "14 ") == true and (ply.HPBoostSet == nil or ply.HPBoostSet == false) then
	ply:SetMaxHealth(ply:GetMaxHealth() + 30)
	ply:SetHealth(math.Clamp(ply:Health() + 30, 1, ply:GetMaxHealth()))
	ply.HPBoostSet = true
elseif PlyHasPerk(ply, "14 ") == false and ply.HPBoostSet == true then
	ply:SetMaxHealth(ply:GetMaxHealth() - 30)
	ply:SetHealth(math.Clamp(ply:Health() - 30, 1, ply:GetMaxHealth()))
	ply.HPBoostSet = false
end

if PlyHasPerk(ply, "13 ") == true and IsValid(EyeTrace) and EyeTrace:GetClass() == "prop_ragdoll" and EyeTrace:GetNWInt("CanCannibalize", 0) == 1 and ply:Crouching() and EyeTrace:GetPos():Distance(ply:GetPos()) <= 60 then
if ply:KeyDown(IN_USE) then
	CannibalRate = math.Clamp(CannibalRate + 0.1, 0, 5)
else
	CannibalRate = 0
end
if CannibalRate == 5 then
	EyeTrace:SetNWInt("CanCannibalize", 2)
	PerformCannibalism(ply, EyeTrace, ply:GetEyeTrace().HitPos, 1)
end
end

if PlyHasPerk(ply, "23 ") == true and IsValid(EyeTrace) and EyeTrace:GetClass() == "prop_ragdoll" and EyeTrace:GetNWInt("CanGhoulCannibalize", 0) == 1 and ply:Crouching() and EyeTrace:GetPos():Distance(ply:GetPos()) <= 60 then
if ply:KeyDown(IN_USE) then
	GhoulCannibalRate = math.Clamp(GhoulCannibalRate + 0.1, 0, 5)
else
	GhoulCannibalRate = 0
end
if GhoulCannibalRate == 5 then
	EyeTrace:SetNWInt("CanGhoulCannibalize", 2)
	PerformCannibalism(ply, EyeTrace, ply:GetEyeTrace().HitPos, 2)
end
end

if PlyHasPerk(ply, "28 ") == true and IsValid(EyeTrace) and EyeTrace:GetClass() == "prop_ragdoll" and EyeTrace:GetNWInt("CanTribalCannibalize", 0) == 1 and ply:Crouching() and EyeTrace:GetPos():Distance(ply:GetPos()) <= 60 then
if ply:KeyDown(IN_USE) then
	TribalCannibalRate = math.Clamp(TribalCannibalRate + 0.1, 0, 5)
else
	TribalCannibalRate = 0
end
if TribalCannibalRate == 5 then
	EyeTrace:SetNWInt("CanTribalCannibalize", 2)
	PerformCannibalism(ply, EyeTrace, ply:GetEyeTrace().HitPos, 3)
end
end

for _,Antlion in pairs(ents.FindByClass("npc_antlion*")) do
if Antlion:GetSequenceName(Antlion:GetSequence()) != "" and Antlion.DP == nil then
	Antlion.DP = Antlion:Disposition(ply)
end

if Antlion:GetSequenceName(Antlion:GetSequence()) != "" then
if (Antlion:GetClass() == "npc_antlion" or Antlion:GetClass() == "npc_antlion_worker") and ply:Alive() and PlyHasPerk(ply, "09 ") == true and (Antlion:Disposition(ply) != D_NU or Antlion:Disposition(ply) != D_LI) then
	Antlion:AddEntityRelationship(ply, D_NU, 0)
elseif (Antlion:GetClass() == "npc_antlion" or Antlion:GetClass() == "npc_antlion_worker") and PlyHasPerk(ply, "09 ") == false and Antlion:Disposition(ply) != Antlion.DP then
	Antlion:AddEntityRelationship(ply, Antlion.DP, 0)
end
end
end
end

end)

hook.Add("EntityEmitSound", "MuteStranger", function(data)

if data.Entity:IsNPC() and data.Entity:GetNWBool("Stranger", false) == true and data.Channel == 2 then
	return false
end

end)

end

if CLIENT then

hook.Add("InputMouseApply", "DisableCannibalMouse", function(cmd)

if LocalPlayer():GetNWInt("Cannibalizing", 0) > 0 then
	cmd:SetMouseX(0)
	cmd:SetMouseY(0)
	return true
end

end)

hook.Add("HUDItemPickedUp", "FalloutHealing", function(i)

// Exceptionally stupid way of ensuring Fast Metabolism works the way its supposed to
// But LUA is a massive pain in the ass, and there's no "Player picked up item" function in Shared/Server that allows me to do it easier

if LocalPlayer():IsPlayer() and PlyHasPerk(LocalPlayer(), "16 ") == true then
if i == "item_healthkit" then
net.Start("FalloutHeal")
net.WriteEntity(LocalPlayer())
net.WriteInt(1, 3)
net.SendToServer()
elseif i == "item_healthvial" then
net.Start("FalloutHeal")
net.WriteEntity(LocalPlayer())
net.WriteInt(2, 3)
net.SendToServer()
end
end

end)

hook.Add("HUDPaint", "FalloutHUDText", function()

local Text = "FalloutFont"
ETR = LocalPlayer():GetEyeTrace().Entity
local Perk06, Perk11, Perk17, Perk22, Perk24, Perk29, Perk31 = 0, 0, 0, 0, 0, 0, 0
local PromptColor = Color(GetConVar("FalloutPromptR"):GetInt(), GetConVar("FalloutPromptG"):GetInt(), GetConVar("FalloutPromptB"):GetInt(), 255)

if LocalPlayer():Crouching() and IsValid(ETR) and ETR:GetClass() == "prop_ragdoll" and ETR:GetPos():Distance(LocalPlayer():GetPos()) <= 60 then
if LocalPlayer():GetNWInt("Cannibalizing", 0) == 0 and ((PlyHasPerk(LocalPlayer(), "13 ") == true and ETR:GetNWInt("CanCannibalize", 0) == 1) or (PlyHasPerk(LocalPlayer(), "23 ") == true and ETR:GetNWInt("CanGhoulCannibalize", 0) == 1) or (PlyHasPerk(LocalPlayer(), "28 ") == true and ETR:GetNWInt("CanTribalCannibalize", 0) == 1)) then
	draw.SimpleTextOutlined("Hold [" .. string.upper(input.LookupBinding("+use")) .. "] Devour", Text, ScrW() * GetConVar("FalloutPromptX"):GetFloat(), ScrH() * GetConVar("FalloutPromptY"):GetFloat(), PromptColor, 0, 0, 1, Color(0,0,0))
end
end

if PlyHasPerk(LocalPlayer(), "15 ") == true and IsValid(EyeTrace) and EyeTrace:GetClass() == "npc_turret_floor" then
	NPCVec = (EyeTrace:GetPos() - LocalPlayer():GetPos()):GetNormalized():Angle().y
	PlyAng = EyeTrace:GetAngles().y
	Result = NPCVec - PlyAng
if Result > 360 then
	Result = Result - 360
elseif Result < 0 then
	Result = Result + 360
end
else
	Result = 0
end

if (Result <= 100 or Result >= 265) and LocalPlayer():Crouching() and PlyHasPerk(LocalPlayer(), "15 ") == true and IsValid(ETR) and ETR:GetClass() == "npc_turret_floor" and ETR:GetPos():Distance(LocalPlayer():GetPos()) <= 70 and ETR:GetNWBool("Disabled", false) == false then
	draw.SimpleTextOutlined("Hold [" .. string.upper(input.LookupBinding("+use")) .. "] Disable", Text, ScrW() * (GetConVar("FalloutPromptX"):GetFloat() - 0.01), ScrH() * GetConVar("FalloutPromptY"):GetFloat(), PromptColor, 0, 0, 1, Color(0,0,0))
end

if PlyHasPerk(LocalPlayer(), "21 ") == true and IsValid(ETR) then

if ETR:IsNPC() then 
if ETR:GetNWInt("Disp", 0) == 1 then
	Clr1 = Color(255, 0, 0)
elseif ETR:GetNWInt("Disp", 0) == 3 then
	Clr1 = Color(0, 255, 60)
elseif ETR:GetNWInt("Disp", 0) == 4 then
	Clr1 = Color(255, 255, 0)
elseif ETR:GetNWInt("Disp", 0) == 0 then
	Clr1 = Color(0, 0, 255)
end
end

if ETR:IsPlayer() then
if ETR:Team() == LocalPlayer():Team() then
	Clr2 = Color(0, 255, 60)
elseif ETR:Team() != LocalPlayer():Team() then
	Clr2 = Color(255, 0, 0)
end
if PlyHasPerk(ETR, "06 ") == true then // This is fucking ridiculous, but I can't think of anything better RN
	Perk06 = 10
else
	Perk06 = 0
end
if PlyHasPerk(ETR, "11 ") == true and ETR:Health() <= ETR:GetMaxHealth() * 0.2 then
	Perk11 = 50
else
	Perk11 = 0
end
if PlyHasPerk(ETR, "17 ") == true then
	Perk17 = 10
else
	Perk17 = 0
end
if PlyHasPerk(ETR, "22 ") == true and table.HasValue(MeleeTypes, LocalPlayer():GetActiveWeapon():GetHoldType()) and LocalPlayer():GetActiveWeapon():GetSlot() == 0 then
	Perk22 = 5
else
	Perk22 = 0
end
if PlyHasPerk(ETR, "24 ") == true and IsValid(LocalPlayer():GetActiveWeapon()) and (game.GetAmmoDamageType(game.GetAmmoID(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())) == 64 or LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() == 8 or LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() == 9 or LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() == 10 or LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() == 11) then
	Perk24 = 25
else
	Perk24 = 0
end
if PlyHasPerk(LocalPlayer(), "29 ") == true and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() == 7 then
	Perk29 = 10
else
	Perk29 = 0
end
if PlyHasPerk(LocalPlayer(), "31 ") == true and table.HasValue(MeleeTypes, LocalPlayer():GetActiveWeapon():GetHoldType()) and LocalPlayer():GetActiveWeapon():GetSlot() == 0 then
	Perk31 = 15
else
	Perk31 = 0
end
end

local DT = math.Clamp(Perk06 + Perk11 + Perk17 + Perk22 + Perk24 - Perk29 - Perk31, 0, 85)

if ETR:IsNPC() then
	draw.SimpleTextOutlined("HP: " .. ETR:Health(), Text, ScrW() * GetConVar("FalloutHealthX"):GetFloat(), ScrH() * GetConVar("FalloutHealthY"):GetFloat(), Clr1, 0, 0, 1, Color(0,0,0))
elseif ETR:IsPlayer() then
	draw.SimpleTextOutlined("HP: " .. ETR:Health() .. " DT: " .. DT, Text, ScrW() * (GetConVar("FalloutHealthX"):GetFloat() - 0.03), ScrH() * GetConVar("FalloutHealthY"):GetFloat(), Clr2, 0, 0, 1, Color(0,0,0))
end

end

end)

end