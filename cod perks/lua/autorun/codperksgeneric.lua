local MechClass = {"npc_manhack", "npc_turret_floor", "npc_cscanner", "npc_combine_camera", "npc_turret_ceiling", "npc_rollermine"}
local DefaultArmor = 100

if SERVER then

hook.Add("AllowPlayerPickup", "PreventScavpickup", function(ply, ent)

if ent:GetName() == "Armorer Boost" or ent:GetName() == "Scavenger Box" then
	return false
end

end)

local AcceptedModels = {"models/props_c17/door01_left.mdl", "models/props_c17/door02_double.mdl", "models/props_c17/gate_door01a.mdl", "models/props_doors/door03_slotted_left.mdl", "models/props_interiors/ElevatorShaft_Door01a.mdl", "models/props_wasteland/interior_fence001g.mdl" }

hook.Add("PlayerUse", "DeadSilenceStopDoorSounds", function(ply, ent)
if ent:GetClass() == "prop_door_rotating" and ply:Alive() and ply:GetNWString("Tier 3 Perk") == "Dead Silence" and table.HasValue(AcceptedModels, ent:GetModel()) then
	ent:SetNWBool("Muted", true)
for _,Doors in pairs(ents.FindByClass("prop_door_rotating")) do
if Doors:GetOwner() == ent and table.HasValue(AcceptedModels, ent:GetModel()) then
	Doors:SetNWBool("Muted", true)
end
end
if IsValid(ent:GetOwner()) and ent:GetOwner() != nil then
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
end

end)

hook.Add("Think", "CODPerksGenericThink", function()

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

if IsValid(ply) then
if ply.DefaultArmor == nil then
	ply.DefaultArmor = ply:GetMaxArmor()
end
if ply:GetNWString("Tier 1 Perk") == "Armorer" and ply:GetMaxArmor() != (ply.DefaultArmor + 25) and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 2) then
	ply:SetMaxArmor(ply.DefaultArmor + 25)
elseif (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1 or ply:GetNWString("Tier 1 Perk") != "Armorer") and ply:GetMaxArmor() != ply.DefaultArmor then
	ply:SetMaxArmor(ply.DefaultArmor)
end
end

if IsValid(ply) and (ply:GetNWString("Tier 2 Perk") != "High Alert" or !ply:Alive()) then
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

for _,Target in pairs(ents.FindInSphere(ply:GetPos(), 256)) do
if Target != ply and Target:IsPlayer() and Target:Alive() and Target:GetNWString("Tier 2 Perk") != "Cold Blooded" and Target:Visible(ply) then

if IsValid(Target) and Target:Team() != ply:Team() then
	PLYVec = (Target:GetPos() - ply:GetPos()):GetNormalized():Angle().y
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

if NPC:IsNPC() and NPC:GetPos():Distance(ply:GetPos()) < 256 and NPC:Visible(ply) then

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

if ply:GetNWString("Tier 3 Perk") != "Pulsar" then
	ply:SetNWInt("PulsarDelay", CurTime() + 0.25)
end

if IsValid(ply) and ply:Alive() and ply:GetNWString("Tier 3 Perk") == "Pulsar" and ply:GetNWInt("PulsarDelay", math.huge) < CurTime() then
	ply:SetNWInt("PulsarDelay", CurTime() + 4)
	CanPulse = false

for _,Pulse in pairs(ents.FindInSphere(ply:GetPos(), 256)) do

if (Pulse:IsNPC() and Pulse:Disposition(ply) == D_HT) or (Pulse:IsPlayer() and Pulse:Alive() and Pulse:Team() != ply:Team()) then

if Pulse:GetNWString("Tier 3 Perk") != "Ninja" then
	Pulse:SetNWBool("PulseCanSpot", true)
end

if CanPulse == false then
	ply:EmitSound("blip1.wav", 75)
	CanPulse = true
end

end
end
end

end

end)

hook.Add("PlayerAmmoChanged", "ScroungerFunc", function(ply, ammoID, oldCount, newCount)

if oldCount > newCount then return end

if ply:GetNWString("Tier 1 Perk") == "Scrounger" and (CanTriggerNew == true or CanTriggerNew == nil) then
if oldCount < newCount then
	CanTriggerNew = false
	AmmoGained = newCount - oldCount
	ply:GiveAmmo(AmmoGained * 0.2, ammoID)
end
	CanTriggerNew = true
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
if ScavItem:GetName() == "Scavenger Box" then
if Ply:GetNWString("Tier 1 Perk") == "Scavenger" and ScavItem:GetNoDraw() == true then
	ScavItem:SetNoDraw(false)
elseif Ply:GetNWString("Tier 1 Perk") != "Scavenger" and ScavItem:GetNoDraw() == false then
	ScavItem:SetNoDraw(true)
end
if Ply:GetNWString("Tier 1 Perk") == "Scavenger" and Ply:GetPos():Distance(ScavItem:GetPos()) < 64 and Ply:Alive() then
	ScavItem:Remove()
	Ply:EmitSound(RndSnd)

for _,Weps in pairs(Ply:GetWeapons()) do

if Weps:GetMaxClip1() > 0 and table.HasValue(AllowedAmmo, Weps:GetPrimaryAmmoType()) then
	Ply:GiveAmmo(math.Clamp(math.Round(Weps:GetMaxClip1() * 0.5), 1, math.huge), Weps:GetPrimaryAmmoType())
elseif Weps:GetMaxClip1() <= 0 and table.HasValue(AllowedAmmo, Weps:GetPrimaryAmmoType()) then
	Ply:GiveAmmo(math.Clamp(math.Round(Weps:GetMaxClip1() * 0.5), 1, math.huge), Weps:GetPrimaryAmmoType())
end

Ply:SetNWInt("LootTimer", CurTime() + 3)

end
end
end

if ScavItem:GetName() == "Armorer Boost" and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1) then
if Ply:GetNWString("Tier 1 Perk") == "Armorer" and ScavItem:GetNoDraw() == true then
	ScavItem:SetNoDraw(false)
elseif Ply:GetNWString("Tier 1 Perk")!= "Armorer" and ScavItem:GetNoDraw() == false then
	ScavItem:SetNoDraw(true)
end
if Ply:GetNWString("Tier 1 Perk") == "Armorer" and Ply:Armor() < Ply:GetMaxArmor() and Ply:GetPos():Distance(ScavItem:GetPos()) < 64 and Ply:Alive() then
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

ScavengerList = 0
ArmorerList = 0

if !game.SinglePlayer() then
for _,PlyPerk in pairs(player.GetAll()) do
if PlyPerk:GetNWString("Tier 1 Perk") ==  "Scavenger" then
	ScavengerList = ScavengerList + 1
end
if PlyPerk:GetNWString("Tier 1 Perk") ==  "Armorer" and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1) then
	ArmorerList = ArmorerList + 1
end
end
end

ScavItem = ents.Create("prop_physics")
ArmorerItem = ents.Create("prop_physics")
if (game.SinglePlayer() and Entity(1):IsPlayer() and Entity(1):GetNWString("Tier 1 Perk") == "Scavenger") or (!game.SinglePlayer() and ScavengerList >= 1) then
	ScavItem:SetPos(npc:WorldSpaceCenter())
	ScavItem:SetModel("models/items/boxmrounds.mdl")
	ScavItem:SetName("Scavenger Box")
	ScavItem:Spawn()
	ScavItem:SetCollisionGroup(2)
	ScavItem:SetNWBool("ScavBox", true)
end

if (game.SinglePlayer() and Entity(1):IsPlayer() and Entity(1):GetNWString("Tier 1 Perk") == "Armorer" and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1)) or (!game.SinglePlayer() and ArmorerList >= 1) then
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
if (NPC:IsNPC() and NPC:Disposition(attacker) == D_HT) or (NPC:IsPlayer() and NPC:Alive() and NPC:Team() != attacker:Team()) then
NPC:SetNWBool("HackerTimer", CurTime() + 3)
NPC:SetNWInt("HackerTeam", attacker:Team())
end
end
end

end)

hook.Add("PlayerDeath", "HackerPlyKill", function(victim, attacker)

ScavengerList = 0
ArmorerList = 0

if !game.SinglePlayer() then
for _,PlyPerk in pairs(player.GetAll()) do
if PlyPerk:GetNWString("Tier 1 Perk") ==  "Scavenger" then
	ScavengerList = ScavengerList + 1
end
if PlyPerk:GetNWString("Tier 1 Perk") ==  "Armorer" and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1) then
	ArmorerList = ArmorerList + 1
end
end
end

ScavItem = ents.Create("prop_physics")
ArmorerItem = ents.Create("prop_physics")
if (game.SinglePlayer() and Entity(1):IsPlayer() and Entity(1):GetNWString("Tier 1 Perk") == "Scavenger") or (!game.SinglePlayer() and ScavengerList >= 1) then
	ScavItem:SetPos(victim:WorldSpaceCenter())
	ScavItem:SetModel("models/items/boxmrounds.mdl")
	ScavItem:SetName("Scavenger Box")
	ScavItem:Spawn()
	ScavItem:SetCollisionGroup(2)
	ScavItem:SetNWBool("ScavBox", true)
end

if (game.SinglePlayer() and Entity(1):IsPlayer() and Entity(1):GetNWString("Tier 1 Perk") == "Armorer" and (GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 or GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1)) or (!game.SinglePlayer() and ArmorerList >= 1) then
	ArmorerItem:SetPos(victim:WorldSpaceCenter())
	ArmorerItem:SetModel("models/items/battery.mdl")
	ArmorerItem:SetName("Armorer Boost")
	ArmorerItem:Spawn()
	ArmorerItem:SetCollisionGroup(2)
	ArmorerItem:SetNWBool("ArmorBoost", true)
end

if attacker:IsPlayer() and attacker:GetNWString("Tier 1 Perk") == "Hacker" and attacker:GetNWInt("HackerDelay", 0) < CurTime() and victim:Team() != attacker:Team() then
attacker:SetNWInt("HackerDelay", CurTime() + 5)
for _,PLY in pairs(ents.FindInSphere(victim:GetPos(), 256)) do
if (PLY:IsNPC() and PLY:Disposition(attacker) == D_HT) or (PLY:IsPlayer() and PLY:Alive() and PLY:Team() != attacker:Team() and PLY:GetNWString("Tier 2 Perk") != "Ninja") then
	PLY:SetNWBool("HackerTimer", CurTime() + 3)
	PLY:SetNWInt("HackerTeam", attacker:Team())
end
end
end

end)

end

if CLIENT then

hook.Add("Think", "PulsarClientThink", function()

local ply = LocalPlayer()

if IsValid(ply) and ply:Alive() and ply:GetNWString("Tier 3 Perk") == "Pulsar" and ply:GetNWInt("PulsarDelay", math.huge) < CurTime() then
for _,Pulse in pairs(ents.FindInSphere(ply:GetPos(), 256)) do
if Pulse:IsNPC() or (Pulse:IsPlayer() and Pulse:Alive() and Pulse:Team() != ply:Team()) then
	Pulse:SetNWInt("PulsarTimer", CurTime() + 3)
end
end
end

end)

end