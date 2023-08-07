local color_red = Color( 255, 0, 0 )
local color_yellow = Color( 255, 255, 0 )
local color_green = Color( 0, 255, 0 )
local MechClass = {"npc_manhack", "npc_turret_floor", "npc_cscanner", "npc_combine_camera", "npc_turret_ceiling", "npc_rollermine"}

net.Receive("PerkSpot", function()
	Target = net.ReadEntity()
	Enemy = net.ReadBool()
	Attacker = net.ReadEntity()
if Attacker:GetNWString("Tier 1 Perk") == "Recon" and Attacker:Team() == LocalPlayer():Team() and Target:IsNPC() and Enemy then
	Target:SetNWBool("PerkSpotted", true)
	Target:SetNWInt("Timer", CurTime() + 8)
end
if Attacker:GetNWString("Tier 1 Perk") == "Recon" and Attacker:Team() == LocalPlayer():Team() and Target:IsPlayer() and Enemy then
	Target:SetNWBool("PerkSpotted", true)
	Target:SetNWInt("Timer", CurTime() + 8)
end
end)

net.Receive("HackerSpot", function()
	Target = net.ReadTable()
	Hated = net.ReadBool()
	Attacker = net.ReadEntity()
if Attacker:GetNWString("Tier 1 Perk") == "Hacker" and Attacker:Team() == LocalPlayer():Team() then
for _,Hater in pairs(ents.FindByClass("npc*")) do
if table.HasValue(Target, Hater) and Hater:IsNPC() and Hater:GetNWBool("HackerSpotted") == true then
	Hater:SetNWBool("HackerSpotted", true)
	Hater:SetNWInt("HackerTimer", CurTime() + 3)
end
end
end
if Attacker:GetNWString("Tier 1 Perk") == "Hacker" and Attacker:Team() == LocalPlayer():Team() then
for _,Enemy in pairs(player.GetAll()) do
if table.HasValue(Target, Enemy) and Enemy:IsPlayer() and Enemy:Team() != LocalPlayer():Team() and Enemy:GetNWString("Tier 3 Perk") != "Ninja" then
	Enemy:SetNWBool("HackerSpotted", true)
	Enemy:SetNWInt("HackerTimer", CurTime() + 3)
end
end
end
end)

local IconXPos = GetConVar("CODPerksIconXPos"):GetFloat()
local IconYPos = GetConVar("CODPerksIconYPos"):GetFloat()

hook.Add("HUDPaint", "PerkIcons", function()

local ScavMat = Material("scavenger.png")
local ArmorMat = Material("bonusarmor.png")

local ScavAlpha = 0
local LootIcon = Material("scavenger.png")

local AwarenessRight = Material("awareness_right.png")
local AwarenessLeft = Material("awareness_left.png")
local AwarenessBack = Material("awareness_behind.png")

if LocalPlayer():GetNWString("Tier 2 Perk") == "High Alert" then
	LeftDrain = LocalPlayer():GetNWInt("LeftAlpha", 0)
	BackDrain = LocalPlayer():GetNWInt("BackAlpha", 0)
	RightDrain = LocalPlayer():GetNWInt("RightAlpha", 0)
else
	LeftDrain = 0
	BackDrain = 0
	RightDrain = 0
end

	surface.SetMaterial(AwarenessRight)
	surface.SetDrawColor( 255, 255, 255, RightDrain)
	surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

	surface.SetMaterial(AwarenessBack)
	surface.SetDrawColor( 255, 255, 255, BackDrain)
	surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

	surface.SetMaterial(AwarenessLeft)
	surface.SetDrawColor( 255, 255, 255, LeftDrain)
	surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

if (LocalPlayer():GetNWString("Tier 1 Perk") == "Scavenger" or LocalPlayer():GetNWString("Tier 1 Perk") == "Armorer") and GetConVar("CODPerksEnableScavIcons"):GetBool() then
for _,ScavItem in pairs(ents.FindByClass("prop_physics")) do

	ScavPos = ScavItem:WorldSpaceCenter() + Vector(0,0,15)
	ArmorPos = ScavItem:WorldSpaceCenter() + Vector(0,0,9)

if LocalPlayer():GetNWString("Tier 1 Perk") == "Scavenger" and ScavItem:GetNWBool("ScavBox", false) == true and LocalPlayer():GetPos():Distance(ScavItem:WorldSpaceCenter()) < 312 then
cam.Start3D()
	render.SetMaterial(ScavMat)
	render.DrawSprite(ScavPos, 8, 8, color_white)
cam.End3D()
end

if LocalPlayer():GetNWString("Tier 1 Perk") == "Armorer" and ScavItem:GetNWBool("ArmorBoost", false) == true and LocalPlayer():GetPos():Distance(ScavItem:WorldSpaceCenter()) < 312 then
cam.Start3D()
	render.SetMaterial(ArmorMat)
	render.DrawSprite(ArmorPos, 12, 12, color_white)
cam.End3D()
end

end
end

if LocalPlayer():GetNWInt("LootTimer", 0) > CurTime() and LocalPlayer():GetNWInt("JugResTimer", 0) < CurTime() and LocalPlayer():GetNWInt("BlstTimer", 0) < CurTime() then
	ScavAlpha = 255
if LocalPlayer():GetNWString("Tier 1 Perk") == "Scavenger" then
	LootIcon = ScavMat
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Armorer" then
	LootIcon = ArmorMat
end
elseif LocalPlayer():GetNWInt("LootTimer", 0) < CurTime() then
	ScavAlpha = math.Clamp(ScavAlpha - 1, 0, 255)
end

if ScavAlpha > 0 then
	surface.SetMaterial(LootIcon)
	surface.SetDrawColor( 255, 255, 255, ScavAlpha)
	surface.DrawTexturedRect( ScrW() * IconXPos, ScrH() * IconYPos, 64, 64 )
end
end)

hook.Add( "PreDrawHalos", "PlayerNPCHalos", function()

local pulsartargets = {}

for _,PulsarNPC in pairs(ents.FindByClass("npc_*")) do

if PulsarNPC:GetNWBool("PulsarSpotted", false) == true and PulsarNPC:GetNWBool("HackerSpotted", false) != true and PulsarNPC:GetNWBool("PerkSpotted", false) != true and !table.HasValue(pulsartargets, PulsarNPC) then
	pulsartargets[ #pulsartargets + 1 ] = PulsarNPC
end
if PulsarNPC:GetNWInt("PulsarTimer", math.huge) < CurTime() and PulsarNPC:GetNWBool("PulsarSpotted", false) == true then
	table.RemoveByValue(pulsartargets, PulsarNPC)
	PulsarNPC:SetNWBool("PulsarSpotted", false)
	PulsarNPC:SetNWInt("PulsarTimer", math.huge)
end
end

for _,PulsarPly in pairs(player.GetAll()) do

if PulsarPly:GetNWBool("PulsarSpotted", false) == true and PulsarPly:GetNWBool("HackerSpotted", false) != true and PulsarPly:GetNWBool("PerkSpotted", false) != true and !table.HasValue(pulsartargets, PulsarPly) then
	pulsartargets[ #pulsartargets + 1 ] = PulsarPly
end
if PulsarPly:GetNWInt("PulsarTimer", math.huge) < CurTime() and PulsarPly:GetNWBool("PulsarSpotted", false) == true then
	table.RemoveByValue(pulsartargets, PulsarPly)
	PulsarPly:SetNWBool("PulsarSpotted", false)
	PulsarPly:SetNWInt("PulsarTimer", math.huge)
end
end

halo.Add(pulsartargets, color_red, 2, 2, 1, true, true)

local hackedtargets = {}

for _,HackerNPC in pairs(ents.FindByClass("npc_*")) do

if HackerNPC:GetNWBool("PerkSpotted", false) != true and HackerNPC:GetNWBool("HackerSpotted", false) == true and !table.HasValue(hackedtargets, HackerNPC) then
	hackedtargets[ #hackedtargets + 1 ] = HackerNPC
end
if HackerNPC:GetNWInt("HackerTimer", math.huge) < CurTime() and HackerNPC:GetNWBool("HackerSpotted", false) == true then
	table.RemoveByValue(hackedtargets, HackerNPC)
	HackerNPC:SetNWBool("HackerSpotted", false)
	HackerNPC:SetNWInt("HackerTimer", math.huge)
end
end

for _,HackerPly in pairs(player.GetAll()) do

if HackerPly:GetNWBool("PerkSpotted", false) != true and HackerPly:GetNWBool("HackerSpotted", false) == true and !table.HasValue(hackedtargets, HackerPly) then
	hackedtargets[ #hackedtargets + 1 ] = HackerPly
end
if HackerPly:GetNWInt("HackerTimer", math.huge) < CurTime() and HackerPly:GetNWBool("HackerSpotted", false) == true then
	table.RemoveByValue(hackedtargets, HackerPly)
	HackerPly:SetNWBool("HackerSpotted", false)
	HackerPly:SetNWInt("HackerTimer", math.huge)
end
end

halo.Add(hackedtargets, color_red, 2, 2, 1, true, true)

end)

hook.Add( "PreDrawHalos", "ItemHalos", function()
local targets = {}
local mechs = {}
local friendlymechs = {}
local explosives = {}
local ammo = {}

for _,AmmoItem in pairs(ents.FindByClass("*ammo*")) do
if AmmoItem:GetClass() != "item_ammo_crate" and !table.HasValue(ammo, AmmoItem) and LocalPlayer():GetNWString("Tier 1 Perk") == "Scrounger" and AmmoItem:GetPos():Distance(LocalPlayer():GetPos()) < 215 then
	ammo[ #ammo + 1 ] = AmmoItem
end
end

for _,BuckItem in pairs(ents.FindByClass("*box_buckshot")) do // Buckshot ammo is dumb, so we have to do this
if !table.HasValue(ammo, BuckItem) and LocalPlayer():GetNWString("Tier 1 Perk") == "Scrounger" and BuckItem:GetPos():Distance(LocalPlayer():GetPos()) < 256 then
	ammo[ #ammo + 1 ] = BuckItem
end
end

halo.Add(ammo, color_yellow, 2, 2, 1, true, true)

for _,Mech in pairs(ents.FindByClass("npc_*")) do

if LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" and !table.HasValue(mechs, Mech) and table.HasValue(MechClass, Mech:GetClass()) and Mech:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
if Mech:GetClass() != "npc_turret_floor" or (Mech:GetClass() == "npc_turret_floor" and LocalPlayer():Team() != Mech:GetNWInt("HackedTeam", -1)) then
	table.RemoveByValue(friendlymechs, Mech)
	mechs[ #mechs + 1 ] = Mech
end
end

if Mech:GetClass() == "npc_turret_floor" and LocalPlayer():Team() == Mech:GetNWInt("HackedTeam", -1) and Mech:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
	table.RemoveByValue(mechs, Mech)
	friendlymechs[ #friendlymechs + 1 ] = Mech
end
end

halo.Add(mechs, color_red, 2, 2, 1, true, true)
halo.Add(friendlymechs, color_green, 2, 2, 1, true, true)

for _,Grens in pairs(ents.FindByClass("npc_grenade_frag")) do

if LocalPlayer():GetNWString("Tier 3 Perk") == "SitRep" and !table.HasValue(explosives, Grens) and Grens:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
	explosives[ #explosives + 1 ] = Grens
end
end

for _,Slams in pairs(ents.FindByClass("npc_satchel")) do

if LocalPlayer():GetNWString("Tier 3 Perk") == "SitRep" and !table.HasValue(explosives, Slams) and Slams:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
	explosives[ #explosives + 1 ] = Slams
end
end

halo.Add(explosives, color_red, 2, 2, 1, true, true)

for _,NPC in pairs(ents.FindByClass("npc_*")) do

if NPC:GetNWBool("PerkSpotted", false) == true and !table.HasValue(targets, NPC) then
	targets[ #targets + 1 ] = NPC
end
if NPC:GetNWInt("Timer", math.huge) < CurTime() and NPC:GetNWBool("PerkSpotted", false) == true then
	table.RemoveByValue(targets, NPC)
	NPC:SetNWBool("PerkSpotted", false)
	NPC:SetNWInt("Timer", math.huge)
end
end

halo.Add(targets, color_red, 2, 2, 1, true, true)

for _,Ply in pairs(player.GetAll()) do

if Ply:GetNWBool("PerkSpotted", false) == true and !table.HasValue(targets, Ply) then
	targets[ #targets + 1 ] = Ply
end
if Ply:GetNWInt("Timer", math.huge) < CurTime() and Ply:GetNWBool("PerkSpotted", false) == true then
	table.RemoveByValue(targets, Ply)
	Ply:SetNWBool("PerkSpotted", false)
	Ply:SetNWInt("Timer", math.huge)
end
end

halo.Add(targets, color_red, 2, 2, 1, true, true)

end )