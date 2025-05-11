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