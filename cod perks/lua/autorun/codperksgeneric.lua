local MechClass = {"npc_manhack", "npc_turret_floor", "npc_cscanner", "npc_combine_camera", "npc_turret_ceiling", "npc_rollermine"}
local EmitSound = false

if SERVER then

hook.Add("AllowPlayerPickup", "PreventScavpickup", function(ply, ent)

if ent:GetName() == "Armorer Boost" or ent:GetName() == "Scavenger Box" then
	return false
end

end)

function HackerFunc(ent, atk)

Hated = false

if ent:IsNPC() then
Hated = ent:Disposition(atk) == D_HT
elseif ent:IsPlayer() then
Hated = ent:Team() != atk:Team()
end

net.Start("HackerSpot")
	net.WriteTable(ents.FindInSphere(ent:GetPos(), 256))
	net.WriteBool(Hated)
	net.WriteEntity(atk)
net.Broadcast()

end

function PulsarFuncTest(ent)

local PulseTable = {}
table.Add(PulseTable, ent)

net.Start("PulsarSpot")
	net.WriteTable(PulseTable)
	net.WriteBool(false)
	net.WriteEntity(TargetedPly)
net.Broadcast()

table.Empty(PulseTable)

end

local AcceptedModels = {"models/props_c17/door01_left.mdl", "models/props_c17/door02_double.mdl", "models/props_c17/gate_door01a.mdl", "models/props_doors/door03_slotted_left.mdl", "models/props_interiors/ElevatorShaft_Door01a.mdl", "models/props_wasteland/interior_fence001g.mdl" }

hook.Add("PlayerUse", "DeadSilenceStopDoorSounds", function(ply, ent)
if ent:GetClass() == "prop_door_rotating" and ply:Alive() and ply:GetNWString("Tier 3 Perk") == "Dead Silence" and table.HasValue(AcceptedModels, ent:GetModel()) then
	ent:SetNWBool("Muted", true)
for _,Doors in pairs(ents.FindByClass("prop_door_rotating")) do
if Doors:GetOwner() == ent and table.HasValue(AcceptedModels, ent:GetModel()) then
	Doors:SetNWBool("Muted", true)
end
end
if ent:GetOwner() != nil then
	ent:GetOwner():SetNWBool("Muted", true)
end
end
end)

local DoorStop = {"doors/default_stop.wav", "doors/door_chainlink_close1.wav", "doors/door_chainlink_close2.wav", "doors/door_metal_large_chamber_close1.wav", "doors/door_metal_large_close2.wav", "doors/door_metal_large_open1.wav", "doors/door_metal_medium_close1.wav", "doors/door_metal_medium_open1.wav", "doors/door_metal_thin_close2.wav", "doors/door_metal_thin_open1.wav", "doors/door_wood_close1.wav", "doors/door1_stop.wav", "doors/wood_stop1.wav", "doors/door_metal_medium_open1.wav", "doors/door_metal_medium_close1.wav", "doors/metal_stop1.wav", "doors/heavy_metal_stop1.wav"}

hook.Add("EntityEmitSound", "MuteDoorsDeadSilence", function(data)
if data.Entity:GetClass() == "prop_door_rotating" and data.Entity:GetNWBool("Muted", false) == true and table.HasValue(DoorStop, data.SoundName) then
	data.Entity:SetNWBool("Muted", false)
	return false
end
if data.Entity:GetClass() == "prop_door_rotating" and data.Entity:GetNWBool("Muted", false) == true then
	return false
end
end)

hook.Add("Think", "ColdBloodedSrv", function()

if ArcticMedShots_ApplyEffect == nil then return end

for _,ply in pairs(player.GetAll()) do

if ply:GetNWInt("Tier 2 Perk") == "Cold Blooded" then
	ArcticMedShots_ApplyEffect(ply, "coldblooded", 1)
end
// Dont sue me for this Arctic, I just think it's a cool feature
end

end)

hook.Add("Think", "CODPerksGenericThink", function()

for _,HackedNPC in pairs(ents.FindByClass("npc_*")) do
if HackedNPC:GetNWBool("HackerSpotted", false) == true and HackedNPC:GetNWInt("HackerTimer", 0) < CurTime() then
	HackedNPC:SetNWBool("HackerSpotted", false)
	HackedNPC:SetNWInt("HackerTimer", math.huge)
end
end

for _,HackedPly in pairs(player.GetAll()) do
if (HackedPly:GetNWBool("HackerSpotted", false) == true and HackedPly:GetNWInt("HackerTimer", 0) < CurTime()) or HackedPly:GetNWString("Tier 3 Perk") == "Ninja" then
	HackedPly:SetNWBool("HackerSpotted", false)
	HackedPly:SetNWInt("HackerTimer", math.huge)
end
if (HackedPly:GetNWBool("PerkSpotted", false) == true and HackedPly:GetNWInt("Timer", 0) < CurTime()) or HackedPly:GetNWString("Tier 3 Perk") == "Ninja" then
	HackedPly:SetNWBool("PerkSpotted", false)
	HackedPly:SetNWInt("Timer", math.huge)
end
if (HackedPly:GetNWBool("PulsarSpotted", false) == true and HackedPly:GetNWInt("Timer", 0) < CurTime()) or HackedPly:GetNWString("Tier 3 Perk") == "Ninja" then
	HackedPly:SetNWBool("PulsarSpotted", false)
	HackedPly:SetNWInt("PulsarTimer", math.huge)
end
end

for _,npc in pairs(ents.FindByClass("npc_*")) do // Blind Eye

if npc:IsNPC() and table.HasValue(MechClass, npc:GetClass()) then

for _,ply in pairs(player.GetAll()) do

if npc.DP == nil then
	npc.DP = npc:Disposition(ply)
end

if ply:Alive() and ply:GetNWString("Tier 1 Perk") == "Blind Eye" and npc:GetNWInt("HackedTeam", -1) != ply:Team() and (npc:Disposition(ply) != D_NU or npc:Disposition(ply) != D_LI) then
	npc:AddEntityRelationship(ply, D_NU, 0)
elseif ply:GetNWString("Tier 1 Perk") != "Blind Eye" and npc:GetNWInt("HackedTeam", -1) != ply:Team() and npc:Disposition(ply) != npc.DP then
	npc:AddEntityRelationship(ply, npc.DP, 0)
end

end

end
end

for _,ply in pairs(player.GetAll()) do

if IsValid(ply) and ply:GetNWString("Tier 3 Perk") == "Pulsar" and ply:GetNWInt("PulsarDelay", 0) < CurTime() then
	ply:SetNWInt("PulsarDelay", CurTime() + 4)
	EmitSound = false
for _,Pulse in pairs(ents.FindInSphere(ply:GetPos(), 256)) do
if Pulse:GetNWBool("PulsarSpotted", false) == true and Pulse:GetNWInt("PulsarTimer", 0) < CurTime() then
	Pulse:SetNWBool("PulsarSpotted", false)
	Pulse:SetNWInt("PulsarTimer", math.huge)
end
if Pulse:IsNPC() and Pulse:Disposition(ply) == D_HT then
	Pulse:SetNWBool("PulsarSpotted", true)
	Pulse:SetNWInt("PulsarTimer", CurTime() + 3)
	PulsarFuncTest(Pulse)
if EmitSound == false then
	ply:EmitSound("blip1.wav", 40)
	EmitSound = true
end
end
if Pulse:IsPlayer() and Pulse:Alive() and Pulse:Team() != ply:Team() then
	Pulse:SetNWBool("PulsarSpotted", true)
	Pulse:SetNWInt("PulsarTimer", CurTime() + 3)
	PulsarFuncTest(Pulse)
if EmitSound == false then
	ply:EmitSound("blip1.wav", 40)
	EmitSound = true
end
end
end
end

if IsValid(ply) and ply:GetNWString("Tier 2 Perk") != "High Alert" then
	ply:SetNWInt("LeftAlpha", 0)
	ply:SetNWInt("BackAlpha", 0)
	ply:SetNWInt("RightAlpha", 0)
end

if IsValid(ply) and ply:GetNWString("Tier 2 Perk") == "High Alert" then

if ply:GetNWInt("LeftAlpha") > 0 then
	ply:SetNWInt("LeftAlpha", ply:GetNWInt("LeftAlpha") - 5)
end
if ply:GetNWInt("BackAlpha") > 0 then
	ply:SetNWInt("BackAlpha", ply:GetNWInt("BackAlpha") - 5)
end
if ply:GetNWInt("RightAlpha") > 0 then
	ply:SetNWInt("RightAlpha", ply:GetNWInt("RightAlpha") - 5)
end

if ply:IsPlayer() and ply:GetPos():Distance(ply:GetPos()) < 250 and ply:GetNWString("Tier 3 Perk") != "Ninja" and ply:Visible(ply) then

if IsValid(ply) and ply:Team() != ply:Team() and ply:Visible(ply) then
	PLYVec = (ply:GetPos() - ply:GetPos()):GetNormalized():Angle().y
	PlyAng = ply:EyeAngles().y
	Result = PLYVec - PlyAng
if Result > 360 then
	Result = Result - 360
elseif Result < 0 then
	Result = Result + 360
end

if Result > 45 and Result <= 135 then
	ply:SetNWInt("LeftAlpha", 255)
end
if Result > 135 and Result < 225 then
	ply:SetNWInt("BackAlpha", 255)
end
if Result >= 225 and Result <= 315 then
	ply:SetNWInt("RightAlpha", 255)
end

end

end

end

for _,NPC in pairs(ents.FindByClass("npc_*")) do

if NPC:IsNPC() and IsValid(NPC) then
TargetedNPC = NPC
end

if NPC:IsNPC() and NPC:GetPos():Distance(ply:GetPos()) < 250 and NPC:Visible(ply) then

if IsValid(NPC) and NPC:Disposition(ply) == D_HT then
	NPCVec = (NPC:GetPos() - ply:GetPos()):GetNormalized():Angle().y
	PlyAng = ply:EyeAngles().y
	Result = NPCVec - PlyAng
if Result > 360 then
	Result = Result - 360
elseif Result < 0 then
	Result = Result + 360
end

if Result > 60 and Result <= 135 then
	ply:SetNWInt("LeftAlpha", 255)
end
if Result > 135 and Result < 225 then
	ply:SetNWInt("BackAlpha", 255)
end
if Result >= 225 and Result <= 300 then
	ply:SetNWInt("RightAlpha", 255)
end

end

end

end

end

end)

hook.Add("PlayerAmmoChanged", "ScroungerFunc", function(ply, ammoID, oldCount, newCount)

if oldCount > newCount then return end

if ply:GetNWString("Tier 1 Perk") == "Scrounger" then
if oldCount < newCount then
AmmoGained = newCount - oldCount
ply:GiveAmmo(AmmoGained * 0.2, ammoID)
end
end

end)

hook.Add("Think", "ScavengerThink", function()

AllowedAmmo = {1, 3, 4, 5, 6, 7, 13, 14, 23, 24, 25, 26}

for _,Ply in pairs(player.GetAll()) do

if MaxArmor == nil then
MaxArmor = Ply:GetMaxArmor()
end

local Snds = {"zipper1.wav", "zipper2.wav", "zipper3.wav", "zipper4.wav"}
local RndSnd = Snds[ math.random( #Snds ) ]

for _,ScavItem in pairs(ents.FindByClass("prop_physics")) do
if ScavItem:GetName() == "Scavenger Box" and Ply:GetNWString("Tier 1 Perk") != "Scavenger" then
	ScavItem:SetNoDraw(true)
elseif ScavItem:GetName() == "Scavenger Box" and Ply:GetNWString("Tier 1 Perk") == "Scavenger" then
	ScavItem:SetNoDraw(false)
if Ply:GetPos():Distance(ScavItem:GetPos()) < 64 then
	ScavItem:Remove()
	Ply:EmitSound(RndSnd)

for _,Weps in pairs(Ply:GetWeapons()) do

if Weps:GetMaxClip1() > 0 and table.HasValue(AllowedAmmo, Weps:GetPrimaryAmmoType()) then
Ply:GiveAmmo(math.Round(Weps:GetMaxClip1() * 0.5, 0), Weps:GetPrimaryAmmoType())
elseif Weps:GetMaxClip1() <= 0 and table.HasValue(AllowedAmmo, Weps:GetPrimaryAmmoType()) then
Ply:GiveAmmo(math.Round(game.GetAmmoMax(Weps:GetPrimaryAmmoType()) * 0.1, 0), Weps:GetPrimaryAmmoType())
end

Ply:SetNWInt("LootTimer", CurTime() + 3)

end
end
end
if ScavItem:GetName() == "Armorer Boost" and Ply:GetNWString("Tier 1 Perk") != "Armorer" then
	ScavItem:SetNoDraw(true)
elseif ScavItem:GetName() == "Armorer Boost" and Ply:GetNWString("Tier 1 Perk") == "Armorer" and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1) then
	ScavItem:SetNoDraw(false)
if Ply:GetPos():Distance(ScavItem:GetPos()) < 64 then
	ScavItem:Remove()
	Ply:EmitSound(RndSnd)

Ply:SetArmor(math.Clamp(Ply:Armor() + 5, 0, Ply:GetMaxArmor()))

Ply:SetNWInt("LootTimer", CurTime() + 3)

end
end
end

end

end)

hook.Add("OnNPCKilled", "HackerNPCKill", function(npc, attacker)

ScavItem = ents.Create("prop_physics")
ArmorerItem = ents.Create("prop_physics")
if (game.SinglePlayer() and Entity(1):IsPlayer() and Entity(1):GetNWString("Tier 1 Perk") == "Scavenger") or !game.SinglePlayer() then
	ScavItem:SetPos(npc:WorldSpaceCenter())
	ScavItem:SetModel("models/items/boxmrounds.mdl")
	ScavItem:SetName("Scavenger Box")
	ScavItem:Spawn()
	ScavItem:SetCollisionGroup(2)
	ScavItem:SetNWBool("ScavBox", true)
end

if (game.SinglePlayer() and Entity(1):IsPlayer() and Entity(1):GetNWString("Tier 1 Perk") == "Armorer" and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1)) or !game.SinglePlayer() then
	ArmorerItem:SetPos(npc:WorldSpaceCenter())
	ArmorerItem:SetModel("models/items/battery.mdl")
	ArmorerItem:SetName("Armorer Boost")
	ArmorerItem:Spawn()
	ArmorerItem:SetCollisionGroup(2)
	ArmorerItem:SetNWBool("ArmorBoost", true)
end

if attacker:IsPlayer() and attacker:GetNWString("Tier 1 Perk") == "Hacker" and attacker:GetNWInt("HackerDelay", 0) < CurTime() and npc:Disposition(attacker) == D_HT then
attacker:SetNWInt("HackerDelay", CurTime() + 5)
for _,NPC in pairs(ents.FindInSphere(npc:GetPos(), 256)) do
HackerFunc(NPC, attacker)
if (IsValid(NPC) and NPC:IsNPC() and NPC:Disposition(attacker) == D_HT) or (NPC:IsPlayer() and NPC:Alive() and NPC:Team() != attacker:Team() and NPC:GetNWString("Tier 2 Perk") != "Ninja") then
	NPC:SetNWBool("HackerSpotted", true)
	NPC:SetNWInt("HackerTimer", CurTime() + 3)
end
end
end

end)

hook.Add("PlayerDeath", "HackerPlyKill", function(victim, attacker)

if attacker:IsPlayer() and attacker:GetNWString("Tier 1 Perk") == "Quick-Fix" then
attacker:SetNWInt("QFHealth", 20)
attacker:SetNWInt("QFTimer", CurTime() + 5)
end

if attacker:IsPlayer() and attacker:GetNWString("Tier 1 Perk") == "Hacker" and attacker:GetNWInt("HackerDelay", 0) < CurTime() and victim:Team() != attacker:Team() then
attacker:SetNWInt("HackerDelay", CurTime() + 5)
for _,PLY in pairs(ents.FindInSphere(victim:GetPos(), 256)) do
if (IsValid(PLY) and PLY:IsNPC() and PLY:Disposition(attacker) == D_HT) or (PLY:IsPlayer() and PLY:Alive() and PLY:Team() != attacker:Team() and NPC:GetNWString("Tier 2 Perk") != "Ninja") then
	PLY:SetNWBool("HackerSpotted", true)
	PLY:SetNWInt("HackerTimer", CurTime() + 3)
end
end
end

end)

end