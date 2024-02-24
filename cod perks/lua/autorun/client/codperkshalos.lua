local color_red = Color( 255, 0, 0 )
local color_yellow = Color( 255, 255, 0 )
local color_green = Color( 0, 255, 0 )
local MechClass = {"npc_manhack", "npc_turret_floor", "npc_cscanner", "npc_combine_camera", "npc_turret_ceiling", "npc_rollermine"}

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

if LocalPlayer():GetNWString("Tier 1 Perk") == "Scavenger" and ScavItem:GetNWBool("ScavBox", false) == true and LocalPlayer():GetPos():Distance(ScavItem:WorldSpaceCenter()) <= 312 then
cam.Start3D()
	render.SetMaterial(ScavMat)
	render.DrawSprite(ScavPos, 8, 8, color_white)
cam.End3D()
end

if LocalPlayer():GetNWString("Tier 1 Perk") == "Armorer" and ScavItem:GetNWBool("ArmorBoost", false) == true and LocalPlayer():GetPos():Distance(ScavItem:WorldSpaceCenter()) <= 312 then
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
local hackedtargets = {}
local recontargets = {}

for _,ReconNPC in pairs(ents.FindByClass("npc_*")) do

if ReconNPC:GetNWInt("ReconTimer", 0) > CurTime() and ReconNPC:GetNWBool("HackerSpotted", false) != true and ReconNPC:GetNWBool("PerkSpotted", false) != true and ReconNPC:GetNWInt("ReconTeam", 0) == LocalPlayer():Team() then
	recontargets[ #recontargets + 1 ] = ReconNPC
	ReconNPC:SetNWBool("ReconSpotted", true)
elseif ReconNPC:GetNWInt("ReconTimer", math.huge) < CurTime() and ReconNPC:GetNWBool("ReconSpotted", false) == true then
	table.RemoveByValue(recontargets, ReconNPC)
	ReconNPC:SetNWBool("ReconSpotted", false)
	ReconNPC:SetNWInt("ReconTimer", 0)
end
end

for _,ReconPly in pairs(player.GetAll()) do

if ReconPly:GetNWInt("ReconTimer", 0) > CurTime() and ReconPly:GetNWBool("HackerSpotted", false) != true and ReconPly:GetNWBool("PerkSpotted", false) != true and ReconPly:GetNWInt("ReconTeam", 0) == LocalPlayer():Team() and ReconPly:Alive() then
	recontargets[ #recontargets + 1 ] = ReconPly
	ReconPly:SetNWBool("ReconSpotted", true)
elseif (ReconPly:GetNWInt("ReconTimer", math.huge) < CurTime() or !ReconPly:Alive()) and ReconPly:GetNWBool("ReconSpotted", false) == true then
	table.RemoveByValue(recontargets, ReconPly)
	ReconPly:SetNWBool("ReconSpotted", false)
	ReconPly:SetNWInt("ReconTimer", 0)
end
end

for _,PulsarNPC in pairs(ents.FindByClass("npc_*")) do

if PulsarNPC:GetNWInt("PulsarTimer", 0) > CurTime() and PulsarNPC:GetNWBool("HackerSpotted", false) != true and PulsarNPC:GetNWBool("PerkSpotted", false) != true then
	pulsartargets[ #pulsartargets + 1 ] = PulsarNPC
	PulsarNPC:SetNWBool("PulsarSpotted", true)
elseif PulsarNPC:GetNWInt("PulsarTimer", math.huge) < CurTime() and PulsarNPC:GetNWBool("PulsarSpotted", false) == true then
	table.RemoveByValue(pulsartargets, PulsarNPC)
	PulsarNPC:SetNWBool("PulsarSpotted", false)
end
end

for _,PulsarPly in pairs(player.GetAll()) do

if PulsarPly:GetNWInt("PulsarTimer", 0) > CurTime() and PulsarPly:GetNWBool("HackerSpotted", false) != true and PulsarPly:GetNWBool("PerkSpotted", false) != true then
	pulsartargets[ #pulsartargets + 1 ] = PulsarPly
	PulsarPly:SetNWBool("PulsarSpotted", true)
elseif PulsarPly:GetNWInt("PulsarTimer", math.huge) < CurTime() and PulsarPly:GetNWBool("PulsarSpotted", false) == true then
	table.RemoveByValue(pulsartargets, PulsarPly)
	PulsarPly:SetNWBool("PulsarSpotted", false)
end
end

for _,HackerNPC in pairs(ents.FindByClass("npc_*")) do

if HackerNPC:GetNWBool("ReconSpotted", false) != true and HackerNPC:GetNWInt("HackerTeam", 0) == LocalPlayer():Team() and HackerNPC:GetNWInt("HackerTimer", 0) > CurTime() then
	hackedtargets[ #hackedtargets + 1 ] = HackerNPC
	HackerNPC:SetNWBool("HackerSpotted", true)
elseif HackerNPC:GetNWInt("HackerTimer", math.huge) < CurTime() and HackerNPC:GetNWBool("HackerSpotted", false) == true then
	table.RemoveByValue(hackedtargets, HackerNPC)
	HackerNPC:SetNWBool("HackerSpotted", false)
	HackerNPC:SetNWInt("HackerTimer", 0)
end
end

for _,HackerPly in pairs(player.GetAll()) do

if HackerPly:GetNWBool("ReconSpotted", false) != true and HackerPly:GetNWInt("HackerTeam", 0) == LocalPlayer():Team() and HackerPly:GetNWInt("HackerTimer", 0) > CurTime() then
	hackedtargets[ #hackedtargets + 1 ] = HackerPly
	HackerPly:SetNWBool("HackerSpotted", true)
elseif HackerPly:GetNWInt("HackerTimer", math.huge) < CurTime() and HackerPly:GetNWBool("HackerSpotted", false) == true then
	table.RemoveByValue(hackedtargets, HackerPly)
	HackerPly:SetNWBool("HackerSpotted", false)
	HackerPly:SetNWInt("HackerTimer", 0)
end
end

if GetConVar("CODPerksHaloSystem"):GetInt() == 1 or GetConVar("CODPerksHaloSystem"):GetInt() == 3 then
halo.Add(hackedtargets, color_red, 2, 2, 1, true, true)
halo.Add(pulsartargets, color_red, 2, 2, 1, true, true)
halo.Add(recontargets, color_red, 2, 2, 1, true, true)
end

end)

hook.Add( "PreDrawHalos", "ItemHalos", function()

local targets = {}
local mechs = {}
local friendlymechs = {}
local explosives = {}
local ammo = {}

for _,AmmoItem in pairs(ents.FindByClass("*ammo*")) do
if AmmoItem:GetClass() != "item_ammo_crate" and LocalPlayer():GetNWString("Tier 1 Perk") == "Scrounger" and AmmoItem:GetPos():Distance(LocalPlayer():GetPos()) <= 256 then
	ammo[ #ammo + 1 ] = AmmoItem
	AmmoItem:SetNWBool("ItemSpotted", true)
elseif AmmoItem:GetNWBool("ItemSpotted", false) == true and (LocalPlayer():GetNWString("Tier 1 Perk") != "Scrounger" or AmmoItem:GetPos():Distance(LocalPlayer():GetPos()) > 256) then
	table.RemoveByValue(ammo, AmmoItem)
	AmmoItem:SetNWBool("ItemSpotted", false)
end
end

for _,BuckItem in pairs(ents.FindByClass("*box_buckshot")) do // Buckshot ammo is dumb, so we have to do this
if LocalPlayer():GetNWString("Tier 1 Perk") == "Scrounger" and BuckItem:GetPos():Distance(LocalPlayer():GetPos()) <= 256 then
	BuckItem:SetNWBool("ItemSpotted", true)
	ammo[ #ammo + 1 ] = BuckItem
elseif BuckItem:GetNWBool("ItemSpotted", false) == true and (LocalPlayer():GetNWString("Tier 1 Perk") != "Scrounger" or BuckItem:GetPos():Distance(LocalPlayer():GetPos()) > 256) then
	table.RemoveByValue(ammo, BuckItem)
	BuckItem:SetNWBool("ItemSpotted", false)
end
end

for _,Mech in pairs(ents.FindByClass("npc_*")) do

if Mech:GetClass() != "npc_turret_floor" or (Mech:GetClass() == "npc_turret_floor" and LocalPlayer():Team() != Mech:GetNWInt("HackedTeam", -1)) then
if LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" and Mech:GetPos():Distance(LocalPlayer():GetPos()) <= 300 then
	Mech:SetNWBool("MechSpotted", true)
	table.RemoveByValue(friendlymechs, Mech)
	mechs[ #mechs + 1 ] = Mech
end
end

if Mech:GetClass() == "npc_turret_floor" and LocalPlayer():Team() == Mech:GetNWInt("HackedTeam", -1) and Mech:GetPos():Distance(LocalPlayer():GetPos()) <= 300 then
	Mech:SetNWBool("MechSpottedFriendly", true)
	table.RemoveByValue(mechs, Mech)
	friendlymechs[ #friendlymechs + 1 ] = Mech
end
if Mech:GetNWBool("MechSpotted", false) == true and (LocalPlayer():GetNWString("Tier 2 Perk") != "Engineer" or LocalPlayer():Team() == Mech:GetNWInt("HackedTeam", -1) or Mech:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
	table.RemoveByValue(mechs, Mech)
	Mech:SetNWBool("MechSpotted", false)
end
if Mech:GetNWBool("MechSpottedFriendly", false) == true and (LocalPlayer():Team() != Mech:GetNWInt("HackedTeam", -1) or Mech:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
	table.RemoveByValue(friendlymechs, Mech)
	Mech:SetNWBool("MechSpottedFriendly", false)
end
end

for _,Grens in pairs(ents.FindByClass("npc_grenade_frag")) do

if LocalPlayer():GetNWString("Tier 3 Perk") == "SitRep" and Grens:GetPos():Distance(LocalPlayer():GetPos()) <= 300 then
	Grens:SetNWBool("ExplosiveSpotted", true)
	explosives[ #explosives + 1 ] = Grens
elseif Grens:GetNWBool("ExplosiveSpotted", false) == true and (LocalPlayer():GetNWString("Tier 3 Perk") != "SitRep" or Grens:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
	table.RemoveByValue(explosives, Grens)
	Grens:SetNWBool("ExplosiveSpotted", false)
end
end

for _,Slams in pairs(ents.FindByClass("npc_satchel")) do

if LocalPlayer():GetNWString("Tier 3 Perk") == "SitRep" and Slams:GetPos():Distance(LocalPlayer():GetPos()) <= 300 then
	Slams:SetNWBool("ExplosiveSpotted", true)
	explosives[ #explosives + 1 ] = Slams
elseif Slams:GetNWBool("ExplosiveSpotted", false) == true and (LocalPlayer():GetNWString("Tier 3 Perk") != "SitRep" or Slams:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
	table.RemoveByValue(explosives, Slams)
	Slams:SetNWBool("ExplosiveSpotted", false)
end
end

for _,Slams2 in pairs(ents.FindByClass("npc_tripmine")) do

if LocalPlayer():GetNWString("Tier 3 Perk") == "SitRep" and Slams2:GetPos():Distance(LocalPlayer():GetPos()) <= 300 then
	Slams2:SetNWBool("ExplosiveSpotted", true)
	explosives[ #explosives + 1 ] = Slams2
elseif Slams2:GetNWBool("ExplosiveSpotted", false) == true and (LocalPlayer():GetNWString("Tier 3 Perk") != "SitRep" or Slams2:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
	table.RemoveByValue(explosives, Slams2)
	Slams2:SetNWBool("ExplosiveSpotted", false)
end
end

if GetConVar("CODPerksHaloSystem"):GetInt() == 1 or GetConVar("CODPerksHaloSystem"):GetInt() == 3 then
halo.Add(ammo, color_yellow, 2, 2, 1, true, true)
halo.Add(mechs, color_red, 2, 2, 1, true, true)
halo.Add(friendlymechs, color_green, 2, 2, 1, true, true)
halo.Add(explosives, color_red, 2, 2, 1, true, true)
halo.Add(targets, color_red, 2, 2, 1, true, true)
end

end )