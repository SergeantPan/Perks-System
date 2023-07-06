if SERVER then

hook.Add("Think", "EngineerHacking", function()

for _,EngiPly in pairs(player.GetAll()) do

for _,HackedTurret in pairs(ents.FindByClass("npc_turret_floor")) do

net.Receive("TurretHacking", function()
	Hacker = net.ReadEntity()
	HackedTurret:SetNWInt("HackedTeam", Hacker:Team())
end)

if HackedTurret:GetNWInt("HackedTeam") == EngiPly:Team() then

for _,EnemyTargets in pairs(ents.FindByClass("npc_*")) do

if EnemyTargets:IsNPC() and EnemyTargets:Disposition(HackedTurret) != D_HT and EnemyTargets:Disposition(EngiPly) == D_HT and HackedTurret:Disposition(EnemyTargets) != D_HT then
	HackedTurret:AddEntityRelationship(EnemyTargets, D_HT, 0)
	EnemyTargets:AddEntityRelationship(HackedTurret, D_HT, 0)
end
if EnemyTargets:IsNPC() and (EnemyTargets:Disposition(HackedTurret) == D_HT or EnemyTargets:Disposition(HackedTurret) == D_FR) and EnemyTargets:Disposition(EngiPly) == D_LI and HackedTurret:Disposition(EnemyTargets) != D_LI then
	HackedTurret:AddEntityRelationship(EnemyTargets, D_LI, 0)
	EnemyTargets:AddEntityRelationship(HackedTurret, D_LI, 0)
end

end

if EngiPly:Team() != HackedTurret:GetNWInt("HackedTeam", -1) and EngiPly:GetNWString("Tier 1 Perk") != "Blind Eye" and HackedTurret:Disposition(EngiPly) != D_HT then
	HackedTurret:AddEntityRelationship(EngiPly, D_HT, 1)
end
if EngiPly:Team() == HackedTurret:GetNWInt("HackedTeam", -1) and HackedTurret:Disposition(EngiPly) != D_LI then
	HackedTurret:AddEntityRelationship(EngiPly, D_LI, 1)
end

end

end
end

end)

end

if CLIENT then

local Hacking = 0

hook.Add("Think", "EngineerHackingHud", function()

if !ConVarExists("CODPerksInteract") then
	BindButton = 18
else
	BindButton = input.GetKeyCode(GetConVar("CODPerksInteract"):GetString())
end

Target = LocalPlayer():GetEyeTrace().Entity

if LocalPlayer():GetNWString("Tier 2 Perk") != "Engineer" or !IsValid(Target) or Target:GetClass() != "npc_turret_floor" or !input.IsButtonDown(BindButton) or Target:GetPos():Distance(LocalPlayer():GetPos()) > 60 then
	Hacking = 0
end

if LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" and IsValid(Target) and Target:GetClass() == "npc_turret_floor" then
if input.IsButtonDown(BindButton) and Target:GetPos():Distance(LocalPlayer():GetPos()) <= 60 then
	Hacking = math.Clamp(Hacking + 0.2, 0, 100)
end
if Hacking == 100 then
	Target:SetOwner(LocalPlayer())
net.Start("TurretHacking")
	net.WriteEntity(LocalPlayer())
net.SendToServer()
end
end

end)

local RedVal = 255

hook.Add("HUDPaint", "HackingText", function()

local Text = "InteractFont"
Target = LocalPlayer():GetEyeTrace().Entity

	YellowVal = math.Clamp(0 + (255 * Hacking / 50), 0, 255)
if YellowVal == 255 then
	RedVal = math.Clamp(RedVal - 1, 0, 255)
else
	RedVal = 255
end
	ColorVal = Color(RedVal, YellowVal, 0, 125)
	Box = Color(0, 0, 0, 125)

if LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" and IsValid(Target) and Target:GetClass() == "npc_turret_floor" and Target:GetNWInt("HackedTeam", -1) != LocalPlayer():Team() and Target:GetPos():Distance(LocalPlayer():GetPos()) <= 60 then
if Hacking == 0 then
draw.DrawText("Hold " .. string.upper(GetConVar("CODPerksInteract"):GetString()) .. " To Hack The Turret", Text, ScrW() * 0.43, ScrH() * 0.53)
else
draw.DrawText("Hacking The Turret", Text, ScrW() * 0.446, ScrH() * 0.53)
draw.DrawText(math.Round(Hacking, 0) .. "%", Text, ScrW() * 0.494, ScrH() * 0.5)
end
end

if IsValid(Target) and Target:GetClass() == "npc_turret_floor" and Target:GetNWInt("HackedTeam", -1) == LocalPlayer():Team() and Target:GetPos():Distance(LocalPlayer():GetPos()) <= 60 then
if Target:GetOwner() == LocalPlayer() then
draw.DrawText("Turret Has Been Hacked", Text, ScrW() * 0.43, ScrH() * 0.53)
elseif Target:GetOwner() != LocalPlayer() and Target:GetOwner():IsPlayer() then
draw.DrawText("Turret Hacked By " .. Entity(Target:GetOwner():EntIndex()):Nick(), Text, ScrW() * 0.43, ScrH() * 0.53)
end
end

end)

end