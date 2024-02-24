CreateConVar("CODPerksArmorerAltMechanic", 0, 128, "Change the mechanics of the Armorer perk:\n 0 = Loot bodies for +5 armor. +25 max armor.\n 1 = Loot bodies for +5 armor. Spawn with 50 armor.\n 2 = +25 max armor. Spawn with 50 armor.")

CreateConVar("CODPerksIconXPos", 0.45, 128, "Change the horizontal position of the Scavenger/Blast Shield/Juggernaut icon. Default is 0.45")
CreateConVar("CODPerksIconYPos", 0.5, 128, "Change the vertical position of the Scavenger/Blast Shield/Juggernaut icon. Default is 0.5")
CreateConVar("CODPerksPopupIconSize", 64, 128, "Change the size of the Scavenger/Blast Shield/Juggernaut icon. Default is 60")
CreateConVar("CODPerksEnableScavIcons", 1, 128, "Enable/Disable the icons for Scavenger Packs/Armorer Boosts.")

CreateConVar("CODPerksXPos", 0.1, 128, "Change the horizontal position of the perk icons. Default is 0.1")
CreateConVar("CODPerksYPos", 0.8, 128, "Change the vertical position of the perk icons. Default is 0.8")

CreateConVar("CODPerksVerticalHorizontal", 0, 128, "Change the orientation of the perk icons.\n0 = Vertical\n1 = Horizontal")
CreateConVar("CODPerksTierPosition", 0, 128, "Change the order of the perks from top to bottom.\n0 = Tier 1, Tier 2, Tier 3\n1 = Tier 3, Tier 2, Tier 1")

CreateConVar("CODPerksGap", 0, 128, "Increase the gap between the perk icons. For use with bigger perk icons. Default is 0")
CreateConVar("CODPerksIconSize", 60, 128, "Change the size of the perk icons. Default is 60")

CreateConVar("CODPerksT1X", 0, 128, "Adjust the horizontal position of the T1 Perk (Blue)")
CreateConVar("CODPerksT1Y", 0, 128, "Adjust the vertical position of the T1 Perk (Blue)")
CreateConVar("CODPerksT2X", 0, 128, "Adjust the horizontal position of the T2 Perk (Red)")
CreateConVar("CODPerksT2Y", 0, 128, "Adjust the vertical position of the T2 Perk (Red)")
CreateConVar("CODPerksT3X", 0, 128, "Adjust the horizontal position of the T3 Perk (Yellow)")
CreateConVar("CODPerksT3Y", 0, 128, "Adjust the vertical position of the T3 Perk (Yellow)")

CreateConVar("CODPerksInteract", "H", 128, "The key used to hack turrets. Use the settings menu preferrably")

CreateConVar("CODPerksDefaultT1", "None", 128, "The default T1 perk you want to spawn with")
CreateConVar("CODPerksDefaultT2", "None", 128, "The default T2 perk you want to spawn with")
CreateConVar("CODPerksDefaultT3", "None", 128, "The default T3 perk you want to spawn with")
CreateConVar("CODPerksHideIcons", 0, 128, "Perk icons hide themselves automatically.")
CreateConVar("CODPerksToggleIcons", "y", 128, "Key that will toggle icon visibility.")
CreateConVar("CODPerksHaloSystem", 3, 128, "Determine which functions Spotting Perks use for highlighting enemies\n0 = Disabled\n1 = Halo Only\n2 = Overlay only\n3 = Both")

CreateConVar("CODPerksEngineerTurretPos", 0, 128, "If the turret on a players back is not in the proper position, set this to 1 to use an alternate position.")
CreateConVar("CODPerksEngineerTurretPosY", 0, 128, "If the turret on a players back is not in the proper position, use this to adjust the vertical position.")
CreateConVar("CODPerksEngineerTurretPosZ", 0, 128, "If the turret on a players back is not in the proper position, use this to adjust the horizontal position.")

CreateConVar("CODPerksGunshipBalance", 1, 128, "Enable the Combine Gunship balance mechanic")
CreateConVar("CODPerksGunshipBalanceHP", 300, 128, "How much HP the Combine Gunship receive. By default it has 100 HP")

CreateConVar("CODPerkColaJG", 0, 128, "Spawn in with the Juggernog Perk-A-Cola.")
CreateConVar("CODPerkColaDT", 0, 128, "Spawn in with the Double Tap Perk-A-Cola.")
CreateConVar("CODPerkColaDD", 0, 128, "Spawn in with the Deadshot Daquiri Perk-A-Cola.")
CreateConVar("CODPerkColaSU", 0, 128, "Spawn in with the Stamin-Up Perk-A-Cola.")
CreateConVar("CODPerkColaPHD", 0, 128, "Spawn in with the PhD Flopper Perk-A-Cola.")
CreateConVar("CODPerkColaEC", 0, 128, "Spawn in with the Electric Cherry Perk-A-Cola.")
CreateConVar("CODPerkColaVA", 0, 128, "Spawn in with the Vulture Aid Perk-A-Cola.")
CreateConVar("CODPerkColaDP", 0, 128, "Spawn in with the Death Perception Perk-A-Cola.")
CreateConVar("CODPerkColaEP", 0, 128, "Spawn in with the Elemental Pop Perk-A-Cola.")

local BlindEye = Material("materials/blindeye.png")
local Recon = Material("materials/recon.png")
local Scavenger = Material("materials/scavenger.png")
local Lightweight = Material("materials/lightweight.png")
local Marathon = Material("materials/marathon.png")
local Hacker = Material("materials/hijacker.png")
local BonusArmor = Material("materials/bonusarmor.png")
local Scrounger = Material("materials/sleightofhand.png")
local QuickFix = Material("materials/quickfix.png")

local BlastShield = Material("materials/blastshield.png")
local Mobility = Material("materials/mobility.png")
local Power = Material("materials/power.png")
local DangerClose = Material("materials/dangerclose.png")
local Engineer = Material("materials/engineer.png")
local Hardened = Material("materials/penetration.png")
local Juggernaut = Material("materials/juggernaut.png")
local Ninja = Material("materials/ninja.png")
local TacMask = Material("materials/tacticalmask.png")
local Awareness = Material("materials/awareness.png")
local Survivalist = Material("materials/survivalist.png")
local ColdBlooded = Material("materials/coldblooded.png")

local SitRep = Material("materials/sitrep.png")
local Commando = Material("materials/commando.png")
local DeadSilence = Material("materials/deadsilence.png")
local Marksman = Material("materials/marksman.png")
local Stalker = Material("materials/stalker.png")
local Scrambler = Material("materials/scrambler.png")
local Martyrdom = Material("materials/martyrdom.png")
local Assassin = Material("materials/assassin.png")
local Executioner = Material("materials/executioner.png")

local Alpha = 255
local IconDelay = 0
local ShowIcons = true

hook.Add("HUDPaint", "CodPerksDraw", function()

local PerkXPos = GetConVar("CODPerksXPos"):GetFloat()
local PerkYPos = GetConVar("CODPerksYPos"):GetFloat()
local PerkSize = GetConVar("CODPerksIconSize"):GetInt()
local Orientation = GetConVar("CODPerksVerticalHorizontal"):GetBool()
local TopBottom = GetConVar("CODPerksTierPosition"):GetBool()
local ExtraSize = GetConVar("CODPerksGap"):GetFloat()
local T1X = GetConVar("CODPerksT1X"):GetFloat()
local T1Y = GetConVar("CODPerksT1Y"):GetFloat()
local T2X = GetConVar("CODPerksT2X"):GetFloat()
local T2Y = GetConVar("CODPerksT2Y"):GetFloat()
local T3X = GetConVar("CODPerksT3X"):GetFloat()
local T3Y = GetConVar("CODPerksT3Y"):GetFloat()
local Text = "InteractFont"

if TopBottom then
T1BonusX = ExtraSize * 3 + 130
T1BonusY = ExtraSize
T3BonusX = ExtraSize
T3BonusY = ExtraSize * 3 + 130
else
T1BonusX = ExtraSize
T1BonusY = ExtraSize * 3 + 130
T3BonusX = ExtraSize * 3 + 130
T3BonusY = ExtraSize
end

if Orientation then
	VertT1 = (ScrW() * PerkXPos + T1BonusX - 5 + T1X)
	VertT2 = (ScrW() * PerkXPos + 64 + ExtraSize * 2 + T2X)
	VertT3 = (ScrW() * PerkXPos + T3BonusX + T3X)
	HorT1 = (ScrH() * PerkYPos + T1Y)
	HorT2 = (ScrH() * PerkYPos + T2Y)
	HorT3 = (ScrH() * PerkYPos + T3Y)
else
	VertT1 = (ScrW() * PerkXPos + T1X)
	VertT2 = (ScrW() * PerkXPos + T2X)
	VertT3 = (ScrW() * PerkXPos + T3X)
	HorT1 = (ScrH() * PerkYPos - T1BonusY + T1Y)
	HorT2 = (ScrH() * PerkYPos - 66 - ExtraSize * 2 + T2Y)
	HorT3 = (ScrH() * PerkYPos - T3BonusY + T3Y)
end

if !ConVarExists("CODPerksToggleIcons") then
	ToggleButton = 35
else
	ToggleButton = input.GetKeyCode(GetConVar("CODPerksToggleIcons"):GetString())
end

if input.IsButtonDown(ToggleButton) and ShowIcons == false and Alpha == 0 then
	ShowIcons = true
	IconDelay = math.huge
end
if input.IsButtonDown(ToggleButton) and ShowIcons == true and Alpha == 255 then
	ShowIcons = false
end

if !GetConVar("CODPerksHideIcons"):GetBool() then
	Alpha = 255
end
if !LocalPlayer():Alive() then
	IconDelay = 0
	Alpha = 0
end
if GetConVar("CODPerksHideIcons"):GetBool() and LocalPlayer():Alive() and IconDelay == 0 then
	IconDelay = CurTime() + 4
	Alpha = 255
end
if IconDelay < CurTime() and Alpha == 255 and ShowIcons == true then
	ShowIcons = false
end
if ShowIcons == false then
	Alpha = math.Clamp(Alpha - 1, 0, 255)
else
	Alpha = math.Clamp(Alpha + 1, 0, 255)
end

if LocalPlayer():GetNWString("Tier 1 Perk", "None") != "None" then
if LocalPlayer():GetNWString("Tier 1 Perk") == "Blind Eye" then
	surface.SetMaterial(BlindEye)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Recon" then
	surface.SetMaterial(Recon)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Scavenger" then
	surface.SetMaterial(Scavenger)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Lightweight" then
	surface.SetMaterial(Lightweight)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1 - 12, HorT1 - 7, PerkSize + 15, PerkSize + 15 )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Marathon" then
	surface.SetMaterial(Marathon)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Hacker" then
	surface.SetMaterial(Hacker)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1, HorT1 - 6, PerkSize, PerkSize + 10 )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Armorer" then
	surface.SetMaterial(BonusArmor)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1 - 12, HorT1 - 7, PerkSize + 15, PerkSize + 15 )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Scrounger" then
	surface.SetMaterial(Scrounger)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Quick-Fix" then
	surface.SetMaterial(QuickFix)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT1 - 12, HorT1 - 7, PerkSize + 15, PerkSize + 15 )
end
end
if LocalPlayer():GetNWString("Tier 2 Perk", "None") != "None" then
if LocalPlayer():GetNWString("Tier 2 Perk") == "Blast Shield" then
	surface.SetMaterial(BlastShield)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2, HorT2, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Mobility" then
	surface.SetMaterial(Mobility)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 8, HorT2 - 9, PerkSize + 18, PerkSize + 18 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Stopping Power" then
	surface.SetMaterial(Power)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 4.2, HorT2 - 6, PerkSize + 11, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Danger Close" then
	surface.SetMaterial(DangerClose)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 8, HorT2 - 9, PerkSize + 18, PerkSize + 18 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Cold Blooded" then
	surface.SetMaterial(ColdBlooded)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 8, HorT2 - 9, PerkSize + 18, PerkSize + 18 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" then
	surface.SetMaterial(Engineer)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 6, HorT2 - 6, PerkSize + 12, PerkSize + 12 )
if LocalPlayer():GetNWBool("HasTurret", false) == true then
if !Orientation then
	draw.DrawText(string.upper(input.GetKeyName(input.GetKeyCode(GetConVar("CODPerksInteract"):GetString()))), Text, VertT2 + 75, HorT2 + 15, Color(255, 255, 255, Alpha))
else
	draw.DrawText(string.upper(input.GetKeyName(input.GetKeyCode(GetConVar("CODPerksInteract"):GetString()))), Text, VertT2 + 19, HorT2 - 35, Color(255, 255, 255, Alpha))
end
end
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Hardened" then
	surface.SetMaterial(Hardened)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 9, HorT2 - 4, PerkSize + 12, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Juggernaut" then
	surface.SetMaterial(Juggernaut)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 3, HorT2, PerkSize + 8, PerkSize - 1 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "High Alert" then
	surface.SetMaterial(Awareness)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 6, HorT2 - 6, PerkSize + 12, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Tactical Mask" then
	surface.SetMaterial(TacMask)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2 - 6, HorT2 - 6, PerkSize + 12, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Survivalist" then
	surface.SetMaterial(Survivalist)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2, HorT2, PerkSize, PerkSize  )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Assassin" then
	surface.SetMaterial(Ninja)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT2, HorT2, PerkSize, PerkSize  )
end
end
if LocalPlayer():GetNWString("Tier 3 Perk", "None") != "None" then
if LocalPlayer():GetNWString("Tier 3 Perk") == "SitRep" then
	surface.SetMaterial(SitRep)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3, HorT3, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Commando" then
	surface.SetMaterial(Commando)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3 + 5, HorT3 - 7, PerkSize + 13, PerkSize + 13 )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Dead Silence" then
	surface.SetMaterial(DeadSilence)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3, HorT3, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Marksman" then
	surface.SetMaterial(Marksman)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3, HorT3, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Stalker" then
	surface.SetMaterial(Stalker)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3, HorT3, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Pulsar" then
	surface.SetMaterial(Scrambler)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3 + 5, HorT3 - 7, PerkSize + 13, PerkSize + 13 )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Martyrdom" then
	surface.SetMaterial(Martyrdom)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3 + 5, HorT3, PerkSize + 14, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Executioner" then
	surface.SetMaterial(Executioner)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3 + 5, HorT3 - 7, PerkSize + 13, PerkSize + 13 )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Ninja" then
	surface.SetMaterial(Assassin)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( VertT3 + 5, HorT3 - 7, PerkSize + 13, PerkSize + 13 )
end
end

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

if !GetConVar("CODPerksHideIcons"):GetBool() then
	Alpha = 255
end
if !LocalPlayer():Alive() then
	IconDelay = 0
	Alpha = 0
end
if GetConVar("CODPerksHideIcons"):GetBool() and LocalPlayer():Alive() and IconDelay == 0 then
	IconDelay = CurTime() + 4
	Alpha = 255
end
if IconDelay < CurTime() and Alpha == 255 and ShowIcons == true then
	ShowIcons = false
end
if ShowIcons == false then
	Alpha = math.Clamp(Alpha - 1, 0, 255)
else
	Alpha = math.Clamp(Alpha + 1, 0, 255)
end

if LocalPlayer():GetNWString("Perk1", "None") == "Juggernog" then
	surface.SetMaterial(Jug)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * 0.1, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk2", "None") == "Stamin-Up" then
	surface.SetMaterial(Stamin)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * Spot2, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk3", "None") == "Double Tap" then
	surface.SetMaterial(Double)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * Spot3, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk4", "None") == "Deadshot Daquiri" then
	surface.SetMaterial(Deadshot)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * Spot4, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk5", "None") == "Electric Cherry" then
	surface.SetMaterial(EC)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * Spot5, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk6", "None") == "PhD Flopper" then
	surface.SetMaterial(PHD)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * Spot6, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk7", "None") == "Vulture Aid" then
	surface.SetMaterial(Vult)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * Spot7, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk8", "None") == "Death Perception" then
	surface.SetMaterial(Death)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * Spot8, Height, Size, Size )
end
if LocalPlayer():GetNWString("Perk9", "None") == "Elemental Pop" then
	surface.SetMaterial(Popper)
	surface.SetDrawColor( 255, 255, 255, Alpha )
	surface.DrawTexturedRect( ScrW() * Spot9, Height, Size, Size )
end
end)