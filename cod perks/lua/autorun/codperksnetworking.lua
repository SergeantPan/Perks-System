net.Receive("Tier1Perk", function(len, ply)
net.ReadEntity():SetNWString("Tier 1 Perk", net.ReadString())
end)
net.Receive("Tier2Perk", function(len, ply)
net.ReadEntity():SetNWString("Tier 2 Perk", net.ReadString())
end)
net.Receive("Tier3Perk", function(len, ply)
net.ReadEntity():SetNWString("Tier 3 Perk", net.ReadString())
end)

if SERVER then
	AddCSLuaFile("CODPerksShared.lua")
end
if CLIENT then
	include("CODPerksShared.lua")
end