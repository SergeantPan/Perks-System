if SERVER then

hook.Add("DoPlayerDeath", "DeathTurretDrop", function(ply)

if ply:GetNWBool("HasTurret", false) == true then

Name = ply:Nick() .. "'s Turret"

for _,tur in pairs(ents.FindByClass("prop_dynamic")) do
if tur:GetName() == Name and tur:GetOwner() == ply then
	tur:Remove()
end
end

TurretBack = ents.Create("npc_turret_floor")
TurretBack:SetOwner(ply)
TurretBack:SetName(ply:Nick() .. "'s Turret")
TurretBack:SetNWInt("HackedTeam", ply:Team())
TurretBack:Spawn()
TurretBack:SetPos(ply:WorldSpaceCenter())
TurretBack:SetAngles(Angle(0, ply:EyeAngles().y, 0))

ply:SetNWBool("HasTurret", false)

end

end)

hook.Add("Think", "EngineerHacking", function()

net.Receive("TurretHacking", function()
	Hacker = net.ReadEntity()
	Hacked = net.ReadEntity()
	Hacked:SetNWInt("HackedTeam", Hacker:Team())
end)

net.Receive("TurretPickup", function()
	Hacker = net.ReadEntity()
	Hacked = net.ReadEntity()

if ConVarExists("CODPerksEngineerTurretPosY") and ConVarExists("CODPerksEngineerTurretPosZ") then
	TurretPos1 = Vector(-45,6 + GetConVar("CODPerksEngineerTurretPosY"):GetFloat(),1 + GetConVar("CODPerksEngineerTurretPosZ"):GetFloat())
else
	TurretPos1 = Vector(-45,6,1)
end

if ConVarExists("CODPerksEngineerTurretPosY") and ConVarExists("CODPerksEngineerTurretPosZ") then
	TurretPos2 = Vector(-45,2 + GetConVar("CODPerksEngineerTurretPosY"):GetFloat(),3 + GetConVar("CODPerksEngineerTurretPosZ"):GetFloat())
else
	TurretPos2 = Vector(-45,2,3)
end

if IsValid(Hacked) then
Hacked:Remove()
Hacker:SetNWBool("HasTurret", true)
TurretBack = ents.Create("prop_dynamic")
TurretBack:SetModel("models/Combine_turrets/Floor_turret.mdl")
TurretBack:SetOwner(Hacker)
TurretBack:SetName(Hacker:Nick() .. "'s Turret")
TurretBack:Spawn()
if !GetConVar("CODPerksEngineerTurretPos"):GetBool() then
TurretBack:FollowBone(Hacker, 4)
TurretBack:SetPos(TurretPos1)
elseif GetConVar("CODPerksEngineerTurretPos"):GetBool() then
TurretBack:FollowBone(Hacker, 12)
TurretBack:SetPos(TurretPos2)
end
TurretBack:SetAngles(Hacker:GetAngles() + Angle(90, -15, 0))
end

end)

net.Receive("TurretRemove", function()
	P = net.ReadEntity()
	Name = P:Nick() .. "'s Turret"
	EyeTrace = P:GetEyeTraceNoCursor()

if P:GetNWBool("HasTurret", false) == true then

if (EyeTrace.HitWorld or IsValid(EyeTrace.Entity)) and P:EyePos():Distance(EyeTrace.HitPos) < 90 then

for _,tur in pairs(ents.FindByClass("prop_dynamic")) do
if tur:GetName() == Name and tur:GetOwner() == P then
	tur:Remove()
end
end

TurretBack = ents.Create("npc_turret_floor")
TurretBack:SetOwner(Hacker)
TurretBack:SetName(Hacker:Nick() .. "'s Turret")
TurretBack:SetNWInt("HackedTeam", Hacker:Team())
TurretBack:Spawn()
TurretBack:SetPos(EyeTrace.HitPos)
TurretBack:SetAngles(Angle(0, P:EyeAngles().y, 0))

undo.Create("NPC (npc_turret_floor)")
undo.AddEntity(TurretBack)
undo.SetPlayer(P)
undo.SetCustomUndoText("Undone Turret")
undo.Finish()

P:SetNWBool("HasTurret", false)

end

end

end)

for _,EngiPly in pairs(player.GetAll()) do

for _,HackedTurret in pairs(ents.FindByClass("npc_turret_floor")) do

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

concommand.Add("SendTur", function(ply)

net.Start("TurretPickup")
	net.WriteEntity(Entity(2))
	net.WriteEntity(ply:GetEyeTrace().Entity)
net.SendToServer()

end)

local Hacking = 0
local Pickup = 0
local PickupDelay = 0
local Drop = 0
local DropDelay = 0
local PlayerDropping = false

hook.Add("Think", "EngineerHackingHud", function()

if !ConVarExists("CODPerksInteract") then
	BindButton = 18
else
	BindButton = input.GetKeyCode(GetConVar("CODPerksInteract"):GetString())
end

if LocalPlayer():Alive() then

for _,PropHide in pairs(ents.FindByClass("prop_dynamic")) do
if PropHide:GetModel() == "models/combine_turrets/floor_turret.mdl" and PropHide:GetOwner() == LocalPlayer() then
if !LocalPlayer():ShouldDrawLocalPlayer() then
	PropHide:SetNoDraw(true)
else
	PropHide:SetNoDraw(false)
end
end
end

Target = LocalPlayer():GetEyeTrace().Entity

if LocalPlayer():GetNWBool("HasTurret", false) == true and Target:GetClass() != "npc_turret_floor" then
if input.IsButtonDown(BindButton) and DropDelay < CurTime() then
	Drop = math.Clamp(Drop + 0.1, 0, 1)
else
	Drop = 0
end
if Drop == 1 then
	PickupDelay = CurTime() + 1
net.Start("TurretRemove")
	net.WriteEntity(LocalPlayer())
net.SendToServer()
end
end

if LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" then
if IsValid(Target) and LocalPlayer():GetNWBool("HasTurret", false) == false and Target:GetClass() == "npc_turret_floor" and Target:GetOwner() == LocalPlayer() and Target:GetPos():Distance(LocalPlayer():GetPos()) <= 60 and input.IsButtonDown(BindButton) and PickupDelay < CurTime() then
	Pickup = math.Clamp(Pickup + 0.1, 0, 1)
else
	Pickup = 0
end
if Pickup == 1 then
	DropDelay = CurTime() + 1
net.Start("TurretPickup")
	net.WriteEntity(LocalPlayer())
	net.WriteEntity(Target)
net.SendToServer()
end
if IsValid(Target) and Target:GetClass() == "npc_turret_floor" and input.IsButtonDown(BindButton) and Target:GetPos():Distance(LocalPlayer():GetPos()) <= 60 then
	Hacking = math.Clamp(Hacking + 0.3, 0, 100)
else
	Hacking = 0
end
if Hacking == 100 then
	Target:SetOwner(LocalPlayer())
	PickupDelay = CurTime() + 1
net.Start("TurretHacking")
	net.WriteEntity(LocalPlayer())
	net.WriteEntity(Target)
net.SendToServer()
end
end

end

end)

hook.Add("HUDPaint", "HackingText", function()

local Text = "InteractFont"
Target = LocalPlayer():GetEyeTrace().Entity

if LocalPlayer():Alive() then

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
draw.DrawText("Turret Hacked By You", Text, ScrW() * 0.43, ScrH() * 0.53)
if LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" then
if LocalPlayer():GetNWBool("HasTurret", false) == false then
draw.DrawText("Hold " .. string.upper(GetConVar("CODPerksInteract"):GetString()) .. " To Pickup The Turret", Text, ScrW() * 0.42, ScrH() * 0.50)
else
draw.DrawText("Already carrying a Turret", Text, ScrW() * 0.428, ScrH() * 0.50)
end
end
elseif Target:GetOwner() != LocalPlayer() and Target:GetOwner():IsPlayer() then
draw.DrawText("Turret Hacked By " .. Entity(Target:GetOwner():EntIndex()):Nick(), Text, ScrW() * 0.43, ScrH() * 0.53)
end
end

end

end)

end