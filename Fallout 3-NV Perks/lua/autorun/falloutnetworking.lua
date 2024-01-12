net.Receive("FalloutPerk", function(len, ply)
P = net.ReadEntity()
Perk = net.ReadString()

local FindPerk = string.find(P:GetNWString("Fallout Perk"), Perk)

if FindPerk then
	P:SetNWString("Fallout Perk", string.Replace(P:GetNWString("Fallout Perk"), Perk, ""))
else
	P:SetNWString("Fallout Perk", P:GetNWString("Fallout Perk") .. Perk)
end

end)

net.Receive("FalloutHeal", function(len, ply)
P = net.ReadEntity()
Heal = net.ReadInt(3)

if IsValid(P) and P:Alive() then
if Heal == 1 then
	P:SetHealth(math.Clamp(P:Health() + (GetConVar("sk_healthkit"):GetInt() * 0.2), 0, P:GetMaxHealth()))
elseif Heal == 2 then
	P:SetHealth(math.Clamp(P:Health() + (GetConVar("sk_healthvial"):GetInt() * 0.2), 0, P:GetMaxHealth()))
end
end
end)

if SERVER then
	AddCSLuaFile("falloutfont.lua")
end
if CLIENT then
	include("falloutfont.lua")
end