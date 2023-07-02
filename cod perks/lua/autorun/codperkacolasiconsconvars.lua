hook.Add("HUDPaint", "PerkAColasDraw", function()

Jug = Material("materials/juggernog.png")
Stamin = Material("materials/staminup.png")
Double = Material("materials/doubletap.png")
Deadshot = Material("materials/deadshotdaquiri.png")
EC = Material("materials/electriccherry.png")
PHD = Material("materials/phdflopper.png")
Vult = Material("materials/vulureaid.png")
Death = Material("materials/deathperception.png")
Popper = Material("materials/elementalpop.png")
Spot2 = 0.135 + GetConVar("CODPerksXPos"):GetInt() + GetConVar("CODPerksGap"):GetInt()
Spot3 = 0.17 + GetConVar("CODPerksXPos"):GetInt() + GetConVar("CODPerksGap"):GetInt()
Spot4 = 0.205 + GetConVar("CODPerksXPos"):GetInt() + GetConVar("CODPerksGap"):GetInt()
Spot5 = 0.24 + GetConVar("CODPerksXPos"):GetInt() + GetConVar("CODPerksGap"):GetInt()
Spot6 = 0.275 + GetConVar("CODPerksXPos"):GetInt() + GetConVar("CODPerksGap"):GetInt()
Spot7 = 0.31 + GetConVar("CODPerksXPos"):GetInt() + GetConVar("CODPerksGap"):GetInt()
Spot8 = 0.345 + GetConVar("CODPerksXPos"):GetInt() + GetConVar("CODPerksGap"):GetInt()
Spot9 = 0.38 + GetConVar("CODPerksXPos"):GetInt() + GetConVar("CODPerksGap"):GetInt()
Height = ScrH() * 0.78 + GetConVar("CODPerksYPos"):GetInt()
Size = GetConVar("CODPerksIconSize"):GetInt()

if LocalPlayer():GetNWString("Perk1", "None") == "None" then
Spot2 = Spot2 - 0.035
Spot3 = Spot3 - 0.035
Spot4 = Spot4 - 0.035
Spot5 = Spot5 - 0.035
Spot6 = Spot6 - 0.035
Spot7 = Spot7 - 0.035
Spot8 = Spot8 - 0.035
Spot9 = Spot9 - 0.035
end
if LocalPlayer():GetNWString("Perk2", "None") == "None" then
Spot3 = Spot3 - 0.035
Spot4 = Spot4 - 0.035
Spot5 = Spot5 - 0.035
Spot6 = Spot6 - 0.035
Spot7 = Spot7 - 0.035
Spot8 = Spot8 - 0.035
Spot9 = Spot9 - 0.035
end
if LocalPlayer():GetNWString("Perk3", "None") == "None" then
Spot4 = Spot4 - 0.035
Spot5 = Spot5 - 0.035
Spot6 = Spot6 - 0.035
Spot7 = Spot7 - 0.035
Spot8 = Spot8 - 0.035
Spot9 = Spot9 - 0.035
end
if LocalPlayer():GetNWString("Perk4", "None") == "None" then
Spot5 = Spot5 - 0.035
Spot6 = Spot6 - 0.035
Spot7 = Spot7 - 0.035
Spot8 = Spot8 - 0.035
Spot9 = Spot9 - 0.035
end
if LocalPlayer():GetNWString("Perk5", "None") == "None" then
Spot6 = Spot6 - 0.035
Spot7 = Spot7 - 0.035
Spot8 = Spot8 - 0.035
Spot9 = Spot9 - 0.035
end
if LocalPlayer():GetNWString("Perk6", "None") == "None" then
Spot7 = Spot7 - 0.035
Spot8 = Spot8 - 0.035
Spot9 = Spot9 - 0.035
end
if LocalPlayer():GetNWString("Perk7", "None") == "None" then
Spot8 = Spot8 - 0.035
Spot9 = Spot9 - 0.035
end
if LocalPlayer():GetNWString("Perk8", "None") == "None" then
Spot9 = Spot9 - 0.035
end

if LocalPlayer():GetNWString("Perk1", "None") == "Juggernog" then
	surface.SetMaterial(Jug)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * 0.1, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk2", "None") == "Stamin-Up" then
	surface.SetMaterial(Stamin)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Spot2, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk3", "None") == "Double Tap" then
	surface.SetMaterial(Double)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Spot3, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk4", "None") == "Deadshot Daquiri" then
	surface.SetMaterial(Deadshot)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Spot4, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk5", "None") == "Electric Cherry" then
	surface.SetMaterial(EC)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Spot5, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk6", "None") == "PhD Flopper" then
	surface.SetMaterial(PHD)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Spot6, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk7", "None") == "Vulture Aid" then
	surface.SetMaterial(Vult)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Spot7, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk8", "None") == "Death Perception" then
	surface.SetMaterial(Death)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Spot8, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk9", "None") == "Elemental Pop" then
	surface.SetMaterial(Popper)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Spot9, Height, Size, Size )
end
end)