net.Receive("PerkACola", function(len, ply)
PlyEnt = net.ReadEntity()
Perk = net.ReadString()

if Perk == "Juggernog" then
if PlyEnt:GetNWString("Perk1", "None") != "Juggernog" then 
	PlyEnt:SetNWString("Perk1", "Juggernog")
else
	PlyEnt:SetNWString("Perk1", "None")
end
end
if Perk == "Double Tap" then
if PlyEnt:GetNWString("Perk2", "None") != "Double Tap" then 
	PlyEnt:SetNWString("Perk2", "Double Tap")
else
	PlyEnt:SetNWString("Perk2", "None")
end
end
if Perk == "Stamin-Up" then
if PlyEnt:GetNWString("Perk3", "None") != "Stamin-Up" then
	PlyEnt:SetNWString("Perk3", "Stamin-Up")
else
	PlyEnt:SetNWString("Perk3", "None")
end
end
if Perk == "Deadshot Daquiri" then
if PlyEnt:GetNWString("Perk4", "None") != "Deadshot Daquiri" then
	PlyEnt:SetNWString("Perk4", "Deadshot Daquiri")
else
	PlyEnt:SetNWString("Perk4", "None")
end
end
if Perk == "PhD Flopper" then
if PlyEnt:GetNWString("Perk5", "None") != "PhD Flopper" then
	PlyEnt:SetNWString("Perk5", "PhD Flopper")
else
	PlyEnt:SetNWString("Perk5", "None")
end
end
if Perk == "Electric Cherry" then
if PlyEnt:GetNWString("Perk6", "None") != "Electric Cherry" then
	PlyEnt:SetNWString("Perk6", "Electric Cherry")
else
	PlyEnt:SetNWString("Perk6", "None")
end
end
if Perk == "Vulture Aid" then
if PlyEnt:GetNWString("Perk7", "None") != "Vulture Aid" then
	PlyEnt:SetNWString("Perk7", "Vulture Aid")
else
	PlyEnt:SetNWString("Perk7", "None")
end
end
if Perk == "Death Perception" then
if PlyEnt:GetNWString("Perk8", "None") != "Death Perception" then
	PlyEnt:SetNWString("Perk8", "Death Perception")
else
	PlyEnt:SetNWString("Perk8", "None")
end
end
if Perk == "Elemental Pop" then
if PlyEnt:GetNWString("Perk9", "None") != "Elemental Pop" then
	PlyEnt:SetNWString("Perk9", "Elemental Pop")
else
	PlyEnt:SetNWString("Perk9", "None")
end
end

end)