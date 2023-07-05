net.Receive("NewTalent", function(len, ply)
Player = net.ReadEntity()
Perk = net.ReadString()

if Player:GetNWString("Slot 1 Talent", "None") == Perk then
Player:SetNWString("Slot 1 Talent", "None")
return end
if Player:GetNWString("Slot 2 Talent", "None") == Perk then
Player:SetNWString("Slot 2 Talent", "None")
return end
if Player:GetNWString("Slot 3 Talent", "None") == Perk then
Player:SetNWString("Slot 3 Talent", "None")
return end
if Player:GetNWString("Slot 4 Talent", "None") == Perk then
Player:SetNWString("Slot 4 Talent", "None")
return end

if Player:GetNWString("Slot 1 Talent", "None") == "None" then
Player:SetNWString("Slot 1 Talent", Perk)
elseif Player:GetNWString("Slot 1 Talent", "None") != "None" and Player:GetNWString("Slot 2 Talent", "None") == "None" then
Player:SetNWString("Slot 2 Talent", Perk)
elseif Player:GetNWString("Slot 2 Talent", "None") != "None" and Player:GetNWString("Slot 3 Talent", "None") == "None" then
Player:SetNWString("Slot 3 Talent", Perk)
elseif Player:GetNWString("Slot 3 Talent", "None") != "None" and Player:GetNWString("Slot 4 Talent", "None") == "None" then
Player:SetNWString("Slot 4 Talent", Perk)
end

end)

if SERVER then
	AddCSLuaFile("divisionperksshared.lua")
end
if CLIENT then
	include("divisionperksshared.lua")
end