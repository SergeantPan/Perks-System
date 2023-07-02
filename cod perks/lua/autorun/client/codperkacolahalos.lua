local NoHalo = {"weapon_physgun", "gmod_toolgun", "gmod_camera"}
local color_orange = Color( 255, 128, 0 )

net.Receive("VultAidDrop", function()
	VultureDrop = net.ReadEntity()
end)

hook.Add("HUDPaint", "VultureIcon", function()

local VultureIcon = Material("Vulureaid.png")

for _,Aid in pairs(ents.FindByClass("prop_physics")) do

if Aid == VultureDrop then
	VulturePosition = VultureDrop:WorldSpaceCenter() + Vector(0,0,15)
cam.Start3D()
	render.SetMaterial(VultureIcon)
	render.DrawSprite(VulturePosition, 16, 16, color_white)
cam.End3D()
end

end

end)

hook.Add( "PreDrawHalos", "PerkAColaHalos", function()
local WeaponHalos = {}
local DeathHalos = {}

if LocalPlayer():GetNWString("Perk7") == "Vulture Aid" then
for _,Wep in pairs(ents.GetAll()) do
if Wep:IsWeapon() and !Wep:GetOwner():IsPlayer() and !Wep:GetOwner():IsNPC() and !table.HasValue(NoHalo, Wep:GetClass()) and !table.HasValue(WeaponHalos, Wep) and LocalPlayer():GetPos():Distance(Wep:GetPos()) <= 256 then
	WeaponHalos[ #WeaponHalos + 1 ] = Wep
elseif LocalPlayer():GetPos():Distance(Wep:GetPos()) > 256 then
	table.RemoveByValue(WeaponHalos, Wep)
end
if Wep:GetClass() == "prop_physics" and Wep == VultureDrop and !table.HasValue(WeaponHalos, Wep) and LocalPlayer():GetPos():Distance(Wep:GetPos()) <= 256 then
	WeaponHalos[ #WeaponHalos + 1 ] = Wep
elseif LocalPlayer():GetPos():Distance(Wep:GetPos()) > 256 then
	table.RemoveByValue(WeaponHalos, Wep)
end
end

halo.Add(WeaponHalos, color_orange, 2, 2, 1, true, true)
end

if LocalPlayer():GetNWString("Perk8") == "Death Perception" then
for _,Death in pairs(ents.FindByClass("npc_*")) do
if Death:IsNPC() and IsValid(Death) and Death:GetPos():Distance(LocalPlayer():GetPos()) <= 256 and Death:GetNWBool("DeathPerception") == true and !table.HasValue(DeathHalos, Death) then
	DeathHalos[ #DeathHalos + 1 ] = Death
elseif LocalPlayer():GetPos():Distance(Death:GetPos()) > 256 then
	table.RemoveByValue(DeathHalos, Death)
end
end

halo.Add(DeathHalos, color_orange, 2, 2, 1, true, true)
end

end)