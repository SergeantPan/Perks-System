hook.Add("InitPostEntity", "CODPerksFirstSpawn", function()

DefaultT1 = GetConVar("CODPerksDefaultT1"):GetString()
DefaultT2 = GetConVar("CODPerksDefaultT2"):GetString()
DefaultT3 = GetConVar("CODPerksDefaultT3"):GetString()

net.Start("Tier1Perk")
	net.WriteEntity(LocalPlayer())
	net.WriteString(DefaultT1)
net.SendToServer()
net.Start("Tier2Perk")
	net.WriteEntity(LocalPlayer())
	net.WriteString(DefaultT2)
net.SendToServer()
net.Start("Tier3Perk")
	net.WriteEntity(LocalPlayer())
	net.WriteString(DefaultT3)
net.SendToServer()

JGSpawn = GetConVar("CODPerkColaJG"):GetBool()
DTSpawn = GetConVar("CODPerkColaDT"):GetBool()
DDSpawn = GetConVar("CODPerkColaDD"):GetBool()
SUSpawn = GetConVar("CODPerkColaSU"):GetBool()
PHDSpawn = GetConVar("CODPerkColaPHD"):GetBool()
ECSpawn = GetConVar("CODPerkColaEC"):GetBool()
VASpawn = GetConVar("CODPerkColaVA"):GetBool()
DPSpawn = GetConVar("CODPerkColaDP"):GetBool()
EPSpawn = GetConVar("CODPerkColaEP"):GetBool()

net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if JGSpawn then
	net.WriteString("Juggernog")
else
	net.WriteString("None")
end
net.SendToServer()
net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if DTSpawn then
	net.WriteString("Double Tap")
else
	net.WriteString("None")
end
net.SendToServer()
net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if DDSpawn then
	net.WriteString("Deadshot Daquiri")
else
	net.WriteString("None")
end
net.SendToServer()
net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if SUSpawn then
	net.WriteString("Stamin-Up")
else
	net.WriteString("None")
end
net.SendToServer()
net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if PHDSpawn then
	net.WriteString("PhD Flopper")
else
	net.WriteString("None")
end
net.SendToServer()
net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if ECSpawn then
	net.WriteString("Electric Cherry")
else
	net.WriteString("None")
end
net.SendToServer()
net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if VASpawn then
	net.WriteString("Vulture Aid")
else
	net.WriteString("None")
end
net.SendToServer()
net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if DPSpawn then
	net.WriteString("Death Perception")
else
	net.WriteString("None")
end
net.SendToServer()
net.Start("PerkACola")
	net.WriteEntity(LocalPlayer())
if EPSpawn then
	net.WriteString("Elemental Pop")
else
	net.WriteString("None")
end
net.SendToServer()

end)

hook.Add( "PopulateToolMenu", "FirstSpawnMenu", function()

spawnmenu.AddToolMenuOption( "Options", "Player Perks", "CodPerksSpawnDefauls", "CoD Spawn Defaults", "", "", function( panel )
	panel:ClearControls()

	panel:ControlHelp("\nMultiplayer Perks:")
	local T1Choice = panel:ComboBox("Default T1 Perk", "CODPerksDefaultT1")
	T1Choice:SetSortItems(false)
	T1Choice:AddChoice("None")
	T1Choice:AddChoice("Blind Eye")
	T1Choice:AddChoice("Recon")
	T1Choice:AddChoice("Marathon")
	T1Choice:AddChoice("Scrounger")
	T1Choice:AddChoice("Scavenger")
	T1Choice:AddChoice("Lightweight")
	T1Choice:AddChoice("Quick-Fix")
	T1Choice:AddChoice("Armorer")
	T1Choice:AddChoice("Hacker")
	panel:Help("Default T1 Perk to select on spawn")
	local T2Choice = panel:ComboBox("Default T2 Perk", "CODPerksDefaultT2")
	T2Choice:SetSortItems(false)
	T2Choice:AddChoice("None")
	T2Choice:AddChoice("Blast Shield")
	T2Choice:AddChoice("Survivalist")
	T2Choice:AddChoice("Assassin")
	T2Choice:AddChoice("Mobility")
	T2Choice:AddChoice("Stopping Power")
	T2Choice:AddChoice("Danger Close")
	T2Choice:AddChoice("Juggernaut")
	T2Choice:AddChoice("Hardened")
	T2Choice:AddChoice("Engineer")
	T2Choice:AddChoice("High Alert")
	T2Choice:AddChoice("Tactical Mask")
	T2Choice:AddChoice("Cold Blooded")
	panel:Help("Default T2 Perk to select on spawn")
	local T3Choice = panel:ComboBox("Default T3 Perk", "CODPerksDefaultT3")
	T3Choice:SetSortItems(false)
	T3Choice:AddChoice("None")
	T3Choice:AddChoice("Marksman")
	T3Choice:AddChoice("Dead Silence")
	T3Choice:AddChoice("SitRep")
	T3Choice:AddChoice("Stalker")
	T3Choice:AddChoice("Commando")
	T3Choice:AddChoice("Pulsar")
	T3Choice:AddChoice("Martyrdom")
	T3Choice:AddChoice("Ninja")
	T3Choice:AddChoice("Executioner")
	panel:Help("Default T3 Perk to select on spawn")

	panel:ControlHelp("\nZombies Perks:")
	panel:CheckBox("Spawn with Juggernog", "CODPerkColaJG")
	panel:CheckBox("Spawn with Double Tap", "CODPerkColaDT")
	panel:CheckBox("Spawn with Deadshot Daquiri", "CODPerkColaDD")
	panel:CheckBox("Spawn with Stamin-Up", "CODPerkColaSU")
	panel:CheckBox("Spawn with PhD Flopper", "CODPerkColaPHD")
	panel:CheckBox("Spawn with Electric Cherry", "CODPerkColaEC")
	panel:CheckBox("Spawn with Vulture Aid", "CODPerkColaVA")
	panel:CheckBox("Spawn with Death Perception", "CODPerkColaDP")
	panel:CheckBox("Spawn with Elemental Pop", "CODPerkColaEP")

end)

end)