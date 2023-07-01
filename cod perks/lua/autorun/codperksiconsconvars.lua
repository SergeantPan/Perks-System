CreateConVar("CODPerksArmorerAltMechanic", 0, 128, "Change the mechanics of the Armorer perk:\n 0 = Loot bodies for +5 armor. +25 max armor.\n 1 = Loot bodies for +5 armor. Spawn with 50 armor.\n 2 = +25 max armor. Spawn with 50 armor.")
CreateConVar("CODPerksIconXPos", 0.45, 128, "Change the horizontal position of the Scavenger/Blast Shield/Juggernaut icon. Default is 0.45")
CreateConVar("CODPerksIconYPos", 0.5, 128, "Change the vertical position of the Scavenger/Blast Shield/Juggernaut icon. Default is 0.5")
CreateConVar("CODPerksXPos", 0.1, 128, "Change the horizontal position of the perk icons. Default is 0.1")
CreateConVar("CODPerksYPos", 0.8, 128, "Change the vertical position of the perk icons. Default is 0.8")
CreateConVar("CODPerksVerticalHorizontal", 0, 128, "Change the orientation of the perk icons. 0 = Vertical, 1 = Horizontal")
CreateConVar("CODPerksTierPosition", 0, 128, "Change the order of the perks from top to bottom. 0 = Tier 1, Tier 2, Tier 3, 1 = Tier 3, Tier 2, Tier 1")
CreateConVar("CODPerksGap", 0, 128, "Increase the gap between the perk icons. For use with bigger perk icons. Default is 0")
CreateConVar("CODPerksIconSize", 60, 128, "Change the size of the perk icons. Default is 60")CreateConVar("CODPerksT1X", 0, 128, "Adjust the horizontal position of the T1 Perk (Blue)")
CreateConVar("CODPerksT1Y", 0, 128, "Adjust the vertical position of the T1 Perk (Blue)")
CreateConVar("CODPerksT2X", 0, 128, "Adjust the horizontal position of the T2 Perk (Red)")
CreateConVar("CODPerksT2Y", 0, 128, "Adjust the vertical position of the T2 Perk (Red)")
CreateConVar("CODPerksT3X", 0, 128, "Adjust the horizontal position of the T3 Perk (Yellow)")
CreateConVar("CODPerksT3Y", 0, 128, "Adjust the vertical position of the T3 Perk (Yellow)")
CreateConVar("CODPerksInteract", "C", 128, "The key used to hack turrets. Use the settings menu preferrably")

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

local SitRep = Material("materials/sitrep.png")
local Commando = Material("materials/commando.png")
local DeadSilence = Material("materials/deadsilence.png")
local Marksman = Material("materials/marksman.png")
local Stalker = Material("materials/stalker.png")
local Scrambler = Material("materials/scrambler.png")
local Martyrdom = Material("materials/martyrdom.png")
local Assassin = Material("materials/assassin.png")
local Executioner = Material("materials/executioner.png")

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

if LocalPlayer():GetNWString("Tier 1 Perk", "None") != "None" then
if LocalPlayer():GetNWString("Tier 1 Perk") == "Blind Eye" then
	surface.SetMaterial(BlindEye)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Recon" then
	surface.SetMaterial(Recon)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Scavenger" then
	surface.SetMaterial(Scavenger)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1 - 7, HorT1 - 5, PerkSize + 15, PerkSize + 15 )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Lightweight" then
	surface.SetMaterial(Lightweight)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1 - 7, HorT1 - 15, PerkSize + 15, PerkSize + 15 )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Marathon" then
	surface.SetMaterial(Marathon)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Hacker" then
	surface.SetMaterial(Hacker)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1, HorT1 - 12, PerkSize, PerkSize + 10 )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Armorer" then
	surface.SetMaterial(BonusArmor)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1 - 7, HorT1 - 15, PerkSize + 15, PerkSize + 15 )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Scrounger" then
	surface.SetMaterial(Scrounger)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1, HorT1, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 1 Perk") == "Quick-Fix" then
	surface.SetMaterial(QuickFix)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT1 - 7, HorT1 - 15, PerkSize + 15, PerkSize + 15 )
end
end
if LocalPlayer():GetNWString("Tier 2 Perk", "None") != "None" then
if LocalPlayer():GetNWString("Tier 2 Perk") == "Blast Shield" then
	surface.SetMaterial(BlastShield)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2, HorT2, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Mobility" then
	surface.SetMaterial(Mobility)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2 - 8, HorT2 - 10, PerkSize + 18, PerkSize + 18 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Stopping Power" then
	surface.SetMaterial(Power)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2 - 5, HorT2 - 7, PerkSize + 12, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Danger Close" then
	surface.SetMaterial(DangerClose)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2 - 8, HorT2 - 10, PerkSize + 18, PerkSize + 18 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" then
	surface.SetMaterial(Engineer)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2 - 6, HorT2 - 6, PerkSize + 12, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Hardened" then
	surface.SetMaterial(Hardened)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2 - 9, HorT2 - 6, PerkSize + 12, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Juggernaut" then
	surface.SetMaterial(Juggernaut)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2 - 3, HorT2, PerkSize + 8, PerkSize - 1 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "High Alert" then
	surface.SetMaterial(Awareness)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2 - 6, HorT2 - 6, PerkSize + 12, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Tactical Mask" then
	surface.SetMaterial(TacMask)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2 - 6, HorT2 - 6, PerkSize + 12, PerkSize + 12 )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Survivalist" then
	surface.SetMaterial(Survivalist)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2, HorT2, PerkSize, PerkSize  )
elseif LocalPlayer():GetNWString("Tier 2 Perk") == "Assassin" then
	surface.SetMaterial(Ninja)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT2, HorT2, PerkSize, PerkSize  )
end
end
if LocalPlayer():GetNWString("Tier 3 Perk", "None") != "None" then
if LocalPlayer():GetNWString("Tier 3 Perk") == "SitRep" then
	surface.SetMaterial(SitRep)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3, HorT3, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Commando" then
	surface.SetMaterial(Commando)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3 - 8, HorT3 - 12, PerkSize + 16, PerkSize + 16 )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Dead Silence" then
	surface.SetMaterial(DeadSilence)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3, HorT3, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Marksman" then
	surface.SetMaterial(Marksman)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3, HorT3, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Stalker" then
	surface.SetMaterial(Stalker)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3, HorT3, PerkSize, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Pulsar" then
	surface.SetMaterial(Scrambler)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3 - 8, HorT3 - 12, PerkSize + 16, PerkSize + 16 )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Martyrdom" then
	surface.SetMaterial(Martyrdom)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3 - 5, HorT3 - 4, PerkSize + 12, PerkSize )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Executioner" then
	surface.SetMaterial(Executioner)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3 - 7, HorT3 - 11, PerkSize + 15, PerkSize + 15 )
elseif LocalPlayer():GetNWString("Tier 3 Perk") == "Ninja" then
	surface.SetMaterial(Assassin)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( VertT3 - 7, HorT3 - 11, PerkSize + 15, PerkSize + 15 )
end
end
end)