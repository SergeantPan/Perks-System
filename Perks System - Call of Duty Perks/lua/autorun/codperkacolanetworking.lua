net.Receive("PerkACola", function(len, ply)
PlyEnt = net.ReadEntity()
Perk = net.ReadString()

if PlyEnt:GetNWString("Perk1", "None") != "Juggernog" and Perk == "Juggernog" then
	PlyEnt:SetNWString("Perk1", "Juggernog")
elseif PlyEnt:GetNWString("Perk1", "None") == "Juggernog" and Perk == "Juggernog" then
	PlyEnt:SetNWString("Perk1", "None")
end
if PlyEnt:GetNWString("Perk2", "None") != "Double Tap" and Perk == "Double Tap" then
	PlyEnt:SetNWString("Perk2", "Double Tap")
elseif PlyEnt:GetNWString("Perk2", "None") == "Double Tap" and Perk == "Double Tap" then
	PlyEnt:SetNWString("Perk2", "None")
end
if PlyEnt:GetNWString("Perk3", "None") != "Stamin-Up" and Perk == "Stamin-Up" then
	PlyEnt:SetNWString("Perk3", "Stamin-Up")
elseif PlyEnt:GetNWString("Perk3", "None") == "Stamin-Up" and Perk == "Stamin-Up" then
	PlyEnt:SetNWString("Perk3", "None")
end
if PlyEnt:GetNWString("Perk4", "None") != "Deadshot Daquiri" and Perk == "Deadshot Daquiri" then
	PlyEnt:SetNWString("Perk4", "Deadshot Daquiri")
elseif PlyEnt:GetNWString("Perk4", "None") == "Deadshot Daquiri" and Perk == "Deadshot Daquiri" then
	PlyEnt:SetNWString("Perk4", "None")
end
if PlyEnt:GetNWString("Perk5", "None") != "PhD Flopper" and Perk == "PhD Flopper" then
	PlyEnt:SetNWString("Perk5", "PhD Flopper")
elseif PlyEnt:GetNWString("Perk5", "None") == "PhD Flopper" and Perk == "PhD Flopper" then
	PlyEnt:SetNWString("Perk5", "None")
end
if PlyEnt:GetNWString("Perk6", "None") != "Electric Cherry" and Perk == "Electric Cherry" then
	PlyEnt:SetNWString("Perk6", "Electric Cherry")
elseif PlyEnt:GetNWString("Perk6", "None") == "Electric Cherry" and Perk == "Electric Cherry" then
	PlyEnt:SetNWString("Perk6", "None")
end
if PlyEnt:GetNWString("Perk7", "None") != "Vulture Aid" and Perk == "Vulture Aid" then
	PlyEnt:SetNWString("Perk7", "Vulture Aid")
elseif PlyEnt:GetNWString("Perk7", "None") == "Vulture Aid" and Perk == "Vulture Aid" then
	PlyEnt:SetNWString("Perk7", "None")
end
if PlyEnt:GetNWString("Perk8", "None") != "Death Perception" and Perk == "Death Perception" then
	PlyEnt:SetNWString("Perk8", "Death Perception")
elseif PlyEnt:GetNWString("Perk8", "None") == "Death Perception" and Perk == "Death Perception" then
	PlyEnt:SetNWString("Perk8", "None")
end
if PlyEnt:GetNWString("Perk9", "None") != "Elemental Pop" and Perk == "Elemental Pop" then
	PlyEnt:SetNWString("Perk9", "Elemental Pop")
elseif PlyEnt:GetNWString("Perk9", "None") == "Elemental Pop" and Perk == "Elemental Pop" then
	PlyEnt:SetNWString("Perk9", "None")
end

end)