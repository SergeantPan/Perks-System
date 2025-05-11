net.Receive("PerkACola", function(len, ply)
Player = net.ReadEntity()
Perk = net.ReadString()

if Player:GetNWString("Perk1", "None") != "Juggernog" and Perk == "Juggernog" then
	Player:SetNWString("Perk1", "Juggernog")
elseif Player:GetNWString("Perk1", "None") == "Juggernog" and Perk == "Juggernog" then
	Player:SetNWString("Perk1", "None")
end
if Player:GetNWString("Perk2", "None") != "Stamin-Up" and Perk == "Stamin-Up" then
	Player:SetNWString("Perk2", "Stamin-Up")
elseif Player:GetNWString("Perk2", "None") == "Stamin-Up" and Perk == "Stamin-Up" then
	Player:SetNWString("Perk2", "None")
end
if Player:GetNWString("Perk3", "None") != "Double Tap" and Perk == "Double Tap" then
	Player:SetNWString("Perk3", "Double Tap")
elseif Player:GetNWString("Perk3", "None") == "Double Tap" and Perk == "Double Tap" then
	Player:SetNWString("Perk3", "None")
end
if Player:GetNWString("Perk4", "None") != "Deadshot Daquiri" and Perk == "Deadshot Daquiri" then
	Player:SetNWString("Perk4", "Deadshot Daquiri")
elseif Player:GetNWString("Perk4", "None") == "Deadshot Daquiri" and Perk == "Deadshot Daquiri" then
	Player:SetNWString("Perk4", "None")
end
if Player:GetNWString("Perk5", "None") != "Electric Cherry" and Perk == "Electric Cherry" then
	Player:SetNWString("Perk5", "Electric Cherry")
elseif Player:GetNWString("Perk5", "None") == "Electric Cherry" and Perk == "Electric Cherry" then
	Player:SetNWString("Perk5", "None")
end
if Player:GetNWString("Perk6", "None") != "PhD Flopper" and Perk == "PhD Flopper" then
	Player:SetNWString("Perk6", "PhD Flopper")
elseif Player:GetNWString("Perk6", "None") == "PhD Flopper" and Perk == "PhD Flopper" then
	Player:SetNWString("Perk6", "None")
end
if Player:GetNWString("Perk7", "None") != "Vulture Aid" and Perk == "Vulture Aid" then
	Player:SetNWString("Perk7", "Vulture Aid")
elseif Player:GetNWString("Perk7", "None") == "Vulture Aid" and Perk == "Vulture Aid" then
	Player:SetNWString("Perk7", "None")
end
if Player:GetNWString("Perk8", "None") != "Death Perception" and Perk == "Death Perception" then
	Player:SetNWString("Perk8", "Death Perception")
elseif Player:GetNWString("Perk8", "None") == "Death Perception" and Perk == "Death Perception" then
	Player:SetNWString("Perk8", "None")
end
if Player:GetNWString("Perk9", "None") != "Elemental Pop" and Perk == "Elemental Pop" then
	Player:SetNWString("Perk9", "Elemental Pop")
elseif Player:GetNWString("Perk9", "None") == "Elemental Pop" and Perk == "Elemental Pop" then
	Player:SetNWString("Perk9", "None")
end

end)