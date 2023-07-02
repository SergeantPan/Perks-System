hook.Add( "PopulateToolMenu", "MenuForPerks", function()

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "PerksMenu1", "Tier 1 Perk", "", "", function( panel )
	panel:ClearControls()

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("blindeye.png")
PerkImage:SetToolTip("Blind Eye\n- Invisible to enemy turrets and manhacks.")
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Blind Eye" then
net.WriteEntity(LocalPlayer())
net.WriteString("Blind Eye")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("recon.png")
PerkImage:SetToolTip("Recon\n- Damaging enemies highlights them for 8 seconds.\n- Highlights are shared among teammates.")
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Recon" then
net.WriteEntity(LocalPlayer())
net.WriteString("Recon")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("marathon.png")
PerkImage:SetToolTip("Marathon\n- With Aux Power: Double sprint power.\n- Without Aux Power: Sprint 10% faster.")
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Marathon" then
net.WriteEntity(LocalPlayer())
net.WriteString("Marathon")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("sleightofhand.png")
PerkImage:SetToolTip("Scrounger\n- Picking up ammo grants 20% bonus ammo.\n- Nearby ammo pickups are highlighted.")
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Scrounger" then
net.WriteEntity(LocalPlayer())
net.WriteString("Scrounger")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("scavenger.png")
PerkImage:SetToolTip("Scavenger\n- Receive ammo from dead bodies.\n- Bodies can only be looted once.")
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Scavenger" then
net.WriteEntity(LocalPlayer())
net.WriteString("Scavenger")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("lightweight.png")
PerkImage:SetToolTip("Lightweight\n- Reduced fall damage.\n- Falldamage below 25 is fully negated.\n- Falldamage above 25 is halved.")
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Lightweight" then
net.WriteEntity(LocalPlayer())
net.WriteString("Lightweight")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 250)
PerkImage:SetSize(80,80)
PerkImage:SetImage("quickfix.png")
PerkImage:SetToolTip("Quick-Fix\n- Killing an enemy grants 20 temporary health.\n- Temporary health lasts 5 seconds.\n- Each kill refreshes timer.\n- Can overheal, capped at Max HP + 20")
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Quick-Fix" then
net.WriteEntity(LocalPlayer())
net.WriteString("Quick-Fix")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 250)
PerkImage:SetSize(80,80)
PerkImage:SetImage("bonusarmor.png")
if GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 0 then
PerkImage:SetToolTip("Armorer\n- Looting dead bodies grants +5 armor.\n- Bodies can only be looted once.\n- Max armor increased by 25.")
elseif GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 1 then
PerkImage:SetToolTip("Armorer\n- Looting dead bodies grants +5 armor.\n- Bodies can only be looted once.\n- Spawn with 50 armor.")
elseif GetConVar("CODPerksArmorerAltMechanic"):GetInt() == 2 then
PerkImage:SetToolTip("Armorer\n- Max armor increased by 25.\n- Spawn with 50 armor.")
end
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Armorer" then
net.WriteEntity(LocalPlayer())
net.WriteString("Armorer")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 250)
PerkImage:SetSize(70,80)
PerkImage:SetImage("hijacker.png")
PerkImage:SetToolTip("Hacker\n- Killing an enemy pings nearby enemies.\n- Ping radius is 5 meters.\n- Highlight lasts 3 seconds.\n- Can only trigger every 5 seconds.\n- Highlights are shared among teammates.")
PerkImage.DoClick = function()
net.Start("Tier1Perk")
if LocalPlayer():GetNWString("Tier 1 Perk") != "Hacker" then
net.WriteEntity(LocalPlayer())
net.WriteString("Hacker")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

end)
end)

hook.Add( "PopulateToolMenu", "MenuForPerks2", function()

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "PerksMenu2", "Tier 2 Perk", "", "", function( panel )
	panel:ClearControls()

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("blastshield.png")
PerkImage:SetToolTip("Blast Shield\n- 45% explosive damage resistance. Negates Danger Close.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Blast Shield" then
net.WriteEntity(LocalPlayer())
net.WriteString("Blast Shield")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("survivalist.png")
PerkImage:SetToolTip("Survivalist\n- After not taking damage for a short period of time, regenerate up to a fifth of your health.\n- Regeneration will only go up to 20%, 40%, 60% and 80% health.\n- Health will not regenerate beyond the current 20%")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Survivalist" then
net.WriteEntity(LocalPlayer())
net.WriteString("Survivalist")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("ninja.png")
PerkImage:SetToolTip("Assassin\n- Enemies who cannot see you take 20% more damage.\n- Ignores Juggernaut.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Assassin" then
net.WriteEntity(LocalPlayer())
net.WriteString("Assassin")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("mobility.png")
PerkImage:SetToolTip("Mobility\n- Walk 10% faster.\n- Jump 15% higher.\n- Climb ladders 15% faster.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Mobility" then
net.WriteEntity(LocalPlayer())
net.WriteString("Mobility")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("power.png")
PerkImage:SetToolTip("Stopping Power\n- Weapons deal 25% more damage. Negates Juggernaut.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Stopping Power" then
net.WriteEntity(LocalPlayer())
net.WriteString("Stopping Power")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("dangerclose.png")
PerkImage:SetToolTip("Danger Close\n- Explosives deal 25% more damage. Negates Blast Shield.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Danger Close" then
net.WriteEntity(LocalPlayer())
net.WriteString("Danger Close")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 260)
PerkImage:SetSize(80,60)
PerkImage:SetImage("juggernaut.png")
PerkImage:SetToolTip("Juggernaut\n- 25% bullet damage resistance. Negates Stopping Power.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Juggernaut" then
net.WriteEntity(LocalPlayer())
net.WriteString("Juggernaut")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 250)
PerkImage:SetSize(80,80)
PerkImage:SetImage("penetration.png")
PerkImage:SetToolTip("Hardened\n- Weapons deal 25% of their base damage to armored enemies (Striders, turrets, rollermines.)\n- Enemies with suit armor take 25% more damage, ignores Juggernaut.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Hardened" then
net.WriteEntity(LocalPlayer())
net.WriteString("Hardened")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 250)
PerkImage:SetSize(80,80)
PerkImage:SetImage("Engineer.png")
PerkImage:SetToolTip("Engineer\n- Detect mechanical enemy units through walls.\n- Gain the ability to hack enemy turrets.\n- Hacked turrets target hostile NPCs and players not on your team.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Engineer" then
net.WriteEntity(LocalPlayer())
net.WriteString("Engineer")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 350)
PerkImage:SetSize(80,80)
PerkImage:SetImage("awareness.png")
PerkImage:SetToolTip("High Alert\n- Your vision pulses when enemies outside of your view see you.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "High Alert" then
net.WriteEntity(LocalPlayer())
net.WriteString("High Alert")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 350)
PerkImage:SetSize(80,80)
PerkImage:SetImage("tacticalmask.png")
PerkImage:SetToolTip("Tactical Mask\n- Reduce damage taken from poison, acid and other gas-based damage by 90%\n- Radiation damage is reduced by 50%")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Tactical Mask" then
net.WriteEntity(LocalPlayer())
net.WriteString("Tactical Mask")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

end)
end)

hook.Add( "PopulateToolMenu", "MenuForPerks3", function()

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "PerksMenu3", "Tier 3 Perk", "", "", function( panel )
	panel:ClearControls()

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("marksman.png")
PerkImage:SetToolTip("Marksman\n- Headshot damage is increased by 25%")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "Marksman" then
net.WriteEntity(LocalPlayer())
net.WriteString("Marksman")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("deadsilence.png")
PerkImage:SetToolTip("Dead Silence\n- The sounds of your footsteps and opening doors are muted.")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "Dead Silence" then
net.WriteEntity(LocalPlayer())
net.WriteString("Dead Silence")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("sitrep.png")
PerkImage:SetToolTip("SitRep\n- See enemy explosives through walls.")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "SitRep" then
net.WriteEntity(LocalPlayer())
net.WriteString("SitRep")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("stalker.png")
PerkImage:SetToolTip("Stalker\n- Crouched movement speed is increased by 50%\n- While crouching, every fifth hit you take deals 75% less damage.")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "Stalker" then
net.WriteEntity(LocalPlayer())
net.WriteString("Stalker")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("commando.png")
PerkImage:SetToolTip("Commando\n- Melee weapons deal 50% more damage.")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "Commando" then
net.WriteEntity(LocalPlayer())
net.WriteString("Commando")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("scrambler.png")
PerkImage:SetToolTip("Pulsar\n- Periodically emit a radar pulse that detecs nearby enemies\n- Pulses every 4 seconds.\n- Radius is 5 meters.\n- Enemies are highlighted for two seconds.\n- Highlights are unique to user.")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "Pulsar" then
net.WriteEntity(LocalPlayer())
net.WriteString("Pulsar")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 260)
PerkImage:SetSize(80,60)
PerkImage:SetImage("martyrdom.png")
PerkImage:SetToolTip("Martyrdom\n- Drop a live grenade upon death.")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "Martyrdom" then
net.WriteEntity(LocalPlayer())
net.WriteString("Martyrdom")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 250)
PerkImage:SetSize(80,80)
PerkImage:SetImage("assassin.png")
PerkImage:SetToolTip("Ninja\n- Immune to the spotting effects of Pulsar, Recon, High Alert and Hacker.\n- Pulsar will still emit a sound, but will not highlight you.")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "Ninja" then
net.WriteEntity(LocalPlayer())
net.WriteString("Ninja")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 250)
PerkImage:SetSize(80,80)
PerkImage:SetImage("executioner.png")
PerkImage:SetToolTip("Executioner\n- Enemies at or below 50% health take 20% more damage\n- Enemies at or below 25% health take 35% more damage.\n- Negated by Juggernaut.")
PerkImage.DoClick = function()
net.Start("Tier3Perk")
if LocalPlayer():GetNWString("Tier 3 Perk") != "Executioner" then
net.WriteEntity(LocalPlayer())
net.WriteString("Executioner")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

end)
end)