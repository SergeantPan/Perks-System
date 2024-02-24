local NoHalo = {"weapon_physgun", "gmod_toolgun", "gmod_camera"}
local color_orange = Color( 255, 128, 0 )

hook.Add("HUDPaint", "VultureIcon", function()

local VultureIcon = Material("Vulureaid.png")

for _,Aid in pairs(ents.FindByClass("prop_physics")) do
	VulturePosition = Aid:WorldSpaceCenter() + Vector(0,0,15)

if Aid:GetNWBool("VultureAid", false) == true then
cam.Start3D()
	render.SetMaterial(VultureIcon)
	render.DrawSprite(VulturePosition, 8, 8, color_white)
cam.End3D()
end

end

end)

hook.Add( "PreDrawHalos", "PerkAColaHalos", function()

local WeaponHalos = {}
local ItemHalos = {}
local DeathHalos = {}

for _,Wep in pairs(ents.GetAll()) do
if Wep:IsWeapon() and !Wep:GetOwner():IsPlayer() and !Wep:GetOwner():IsNPC() and LocalPlayer():GetNWString("Perk7") == "Vulture Aid" and LocalPlayer():GetPos():Distance(Wep:GetPos()) <= 256 then
	WeaponHalos[ #WeaponHalos + 1 ] = Wep
	Wep:SetNWBool("VultureAid", true)
elseif Wep:IsWeapon() and !Wep:GetOwner():IsPlayer() and !Wep:GetOwner():IsNPC() and Wep:GetNWBool("VultureAid", false) == true and (LocalPlayer():GetNWString("Perk7") != "Vulture Aid" or LocalPlayer():GetPos():Distance(Wep:GetPos()) > 256) then
	table.RemoveByValue(WeaponHalos, Wep)
	Wep:SetNWBool("VultureAid", false)
end
end

for _,Prop in pairs(ents.FindByClass("prop_physics")) do
if Prop:GetNWBool("VultureDrop", false) == true and LocalPlayer():GetNWString("Perk7") == "Vulture Aid" and LocalPlayer():GetPos():Distance(Prop:GetPos()) <= 256 then
	ItemHalos[ #ItemHalos + 1 ] = Prop
	Prop:SetNWBool("VultureAid", true)
elseif Prop:GetNWBool("VultureAid", false) == true and (LocalPlayer():GetNWString("Perk7") != "Vulture Aid" or LocalPlayer():GetPos():Distance(Prop:GetPos()) > 256) then
	table.RemoveByValue(ItemHalos, Prop)
	Prop:SetNWBool("VultureAid", false)
end
end

for _,Ammo in pairs(ents.FindByClass("*ammo*")) do
if Ammo:GetClass() != "item_ammo_crate" and LocalPlayer():GetNWString("Perk7") == "Vulture Aid" and Ammo:GetPos():Distance(LocalPlayer():GetPos()) <= 256 then
	ItemHalos[ #ItemHalos + 1 ] = Ammo
	Ammo:SetNWBool("VultureAid", true)
elseif Ammo:GetNWBool("VultureAid", false) == true and (LocalPlayer():GetNWString("Perk7") != "Vulture Aid" or LocalPlayer():GetPos():Distance(Ammo:GetPos()) > 256) then
	table.RemoveByValue(ItemHalos, Ammo)
	Ammo:SetNWBool("VultureAid", false)
end
end

for _,Buck in pairs(ents.FindByClass("*box_buckshot")) do // Buckshot ammo is dumb, so we have to do this
if LocalPlayer():GetNWString("Perk7") == "Vulture Aid" and Buck:GetPos():Distance(LocalPlayer():GetPos()) <= 256 then
	ItemHalos[ #ItemHalos + 1 ] = Buck
	Buck:SetNWBool("VultureAid", true)
elseif Buck:GetNWBool("VultureAid", false) == true and (LocalPlayer():GetNWString("Perk7") != "Vulture Aid" or LocalPlayer():GetPos():Distance(Buck:GetPos()) > 256) then
	table.RemoveByValue(ItemHalos, Buck)
	Buck:SetNWBool("VultureAid", false)
end
end

for _,Death in pairs(ents.FindByClass("npc_*")) do
if LocalPlayer():GetNWString("Perk8") == "Death Perception" and Death:GetNWBool("DeathPer", false) == true and Death:GetPos():Distance(LocalPlayer():GetPos()) <= 256 then
	DeathHalos[ #DeathHalos + 1 ] = Death
elseif LocalPlayer():GetNWString("Perk8") != "Death Perception" or Death:GetNWBool("DeathPer", false) == false or Death:GetPos():Distance(LocalPlayer():GetPos()) > 256 then
	table.RemoveByValue(DeathHalos, Death)
end
end

if GetConVar("CODPerksHaloSystem"):GetInt() == 1 or GetConVar("CODPerksHaloSystem"):GetInt() == 3 then
halo.Add(DeathHalos, color_orange, 2, 2, 1, true, true)
halo.Add(WeaponHalos, color_orange, 2, 2, 1, true, true)
halo.Add(ItemHalos, color_orange, 2, 2, 1, true, true)
end
end)