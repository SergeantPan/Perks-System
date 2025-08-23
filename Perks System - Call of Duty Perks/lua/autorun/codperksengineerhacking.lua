if SERVER then

hook.Add("PlayerSpawn", "CODPerksEngineerTurretSpawn", function(ply)

if ply.FirstSpawn == false and GetConVar("CODPerksEngineerSpawnTurretInitial"):GetBool() then
	ply.FirstSpawn = true
end
if ply.FirstSpawn == nil or !GetConVar("CODPerksEngineerSpawnTurretInitial"):GetBool() then
	ply.FirstSpawn = false
end

if GetConVar("CODPerksEngineerTurretPosX"):GetFloat() and ConVarExists("CODPerksEngineerTurretPosY") and ConVarExists("CODPerksEngineerTurretPosZ") then
	TurretPos = Vector(-45 + GetConVar("CODPerksEngineerTurretPosX"):GetFloat(), 2 + GetConVar("CODPerksEngineerTurretPosY"):GetFloat(), 3 + GetConVar("CODPerksEngineerTurretPosZ"):GetFloat())
else
	TurretPos = Vector(-45,2,3)
end

if GetConVar("CODPerksEngineerSpawnTurret"):GetBool() and ply:GetNWString("Tier 2 Perk", "None") == "Engineer" and ply.FirstSpawn == false then
ply:SetNWBool("HasTurret", true)
TurretBack = ents.Create("prop_dynamic")
TurretBack:SetModel("models/Combine_turrets/Floor_turret.mdl")
TurretBack:SetOwner(ply)
TurretBack:SetName(ply:Nick() .. "'s Turret")
TurretBack:AddEFlags(16)
TurretBack:SetMoveType(MOVETYPE_NONE)
TurretBack:Spawn()
TurretBack:FollowBone(Hacker, Hacker:LookupBone("ValveBiped.Bip01_Spine4"))
TurretBack:SetPos(TurretPos)
TurretBack:SetAngles(Hacker:GetAngles() + Angle(90, -15, 0))
end

end)

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

if GetConVar("CODPerksEngineerTurretPosX"):GetFloat() and ConVarExists("CODPerksEngineerTurretPosY") and ConVarExists("CODPerksEngineerTurretPosZ") then
	TurretPos = Vector(-45 + GetConVar("CODPerksEngineerTurretPosX"):GetFloat(), 2 + GetConVar("CODPerksEngineerTurretPosY"):GetFloat(), 3 + GetConVar("CODPerksEngineerTurretPosZ"):GetFloat())
else
	TurretPos = Vector(-45,2,3)
end

net.Receive("TurretHacking", function()
	Hacker = net.ReadEntity()
	Hacked = net.ReadEntity()
	Hacked:SetNWInt("HackedTeam", Hacker:Team())
	Hacked:SetOwner(Hacker)
end)

net.Receive("TurretPickup", function()
	Hacker = net.ReadEntity()
	Hacked = net.ReadEntity()

if IsValid(Hacked) then
Hacked:Remove()
Hacker:SetNWBool("HasTurret", true)
TurretBack = ents.Create("prop_dynamic")
TurretBack:SetModel("models/Combine_turrets/Floor_turret.mdl")
TurretBack:SetOwner(Hacker)
TurretBack:SetName(Hacker:Nick() .. "'s Turret")
TurretBack:AddEFlags(16)
TurretBack:SetMoveType(MOVETYPE_NONE)
TurretBack:Spawn()
TurretBack:FollowBone(Hacker, Hacker:LookupBone("ValveBiped.Bip01_Spine4"))
TurretBack:SetPos(TurretPos)
TurretBack:SetAngles(Hacker:GetAngles() + Angle(90, -15, 0))
Hacker:EmitSound("npc/turret_floor/retract.wav")
end

end)

for _,EngiPly in pairs(player.GetAll()) do

if EngiPly:GetNWBool("HasTurret", false) == true then
for _,Tur in pairs(ents.FindByClass("prop_dynamic")) do
if Tur:GetName() == EngiPly:Nick() .. "'s Turret" then
if Tur:GetParentAttachment() != Hacker:LookupBone("ValveBiped.Bip01_Spine4") then
	Tur:FollowBone(Hacker, Hacker:LookupBone("ValveBiped.Bip01_Spine4"))
	Tur:SetPos(TurretPos)
	Tur:SetAngles(EngiPly:GetAngles() + Angle(90, -15, 0))
end
if Tur:GetLocalPos() != TurretPos then
	Tur:SetPos(TurretPos)
end
end
end
end

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
if isnumber(GetConVar("CODPerksInteract"):GetInt()) and GetConVar("CODPerksInteract"):GetInt() > 0 and GetConVar("CODPerksInteract"):GetInt() <= 171 then
	BindButton = GetConVar("CODPerksInteract"):GetInt()
else
	BindButton = -1
end
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
if IsValid(Target) and Target:GetClass() == "npc_turret_floor" and Target:GetNWInt("HackedTeam", -1) != LocalPlayer():Team() and input.IsButtonDown(BindButton) and Target:GetPos():Distance(LocalPlayer():GetPos()) <= 60 then
	Hacking = math.Clamp(Hacking + GetConVar("CODPerksEngineerHackingSpeed"):GetFloat(), 0, 100)
else
	Hacking = 0
end
if Hacking == 100 then
	PickupDelay = CurTime() + 1
net.Start("TurretHacking")
	net.WriteEntity(LocalPlayer())
	net.WriteEntity(Target)
net.SendToServer()
end
end

end

end)

CODAlphaClr1 = 0
TextAlpha1 = 0
BoxHeight = 0
BoxHeightMax = 0
BoxWidth = 320
BoxSide = ScrW() * 0.417
BoxHigh = ScrH() * 0.565
Output1 = ""
Output2 = ""

hook.Add("HUDPaint", "HackingText", function()

Text = "InteractFont"
Target = LocalPlayer():GetEyeTrace().Entity

if !LocalPlayer():Alive() and TextAlpha1 != 0 then
	CODAlphaClr1 = 0
	TextAlpha1 = 0
	BoxHeight = 0
end

if isnumber(GetConVar("CODPerksInteract"):GetInt()) and GetConVar("CODPerksInteract"):GetInt() > 0 and GetConVar("CODPerksInteract"):GetInt() <= 171 then
	BindKey = string.upper(input.GetKeyName(GetConVar("CODPerksInteract"):GetInt()))
else
	BindKey = "UNBOUND"
end

if LocalPlayer():Alive() then

if (!IsValid(Target) or Target:GetClass() != "npc_turret_floor" or Target:GetPos():Distance(LocalPlayer():GetPos()) > 60) and (TextAlpha1 != 0 or CODAlphaClr1 != 0 or BoxHeight != 0) then
	CODAlphaClr1 = math.Clamp(CODAlphaClr1 - 5, 0, 225)
	TextAlpha1 = math.Clamp(TextAlpha1 - 5, 0, 255)
	BoxHeight = math.Clamp(BoxHeight - 2, 0, BoxHeightMax)
end

if IsValid(Target) and Target:GetClass() == "npc_turret_floor" and Target:GetPos():Distance(LocalPlayer():GetPos()) <= 60 then
if (LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" and Target:GetNWInt("HackedTeam", -1) != LocalPlayer():Team()) or (Target:GetNWInt("HackedTeam", -1) == LocalPlayer():Team()) then
if TextAlpha1 != 255 or CODAlphaClr1 != 225 or BoxHeight != BoxHeightMax then
	TextAlpha1 = math.Clamp(TextAlpha1 + 5, 0, 255)
	CODAlphaClr1 = math.Clamp(CODAlphaClr1 + 5, 0, 225)
	BoxHeight = math.Clamp(BoxHeight + 2, 0, BoxHeightMax)
end
end
end

if IsValid(Target) and Target:GetClass() == "npc_turret_floor" and Hacking == 0 and Target:GetNWInt("HackedTeam", -1) != LocalPlayer():Team() then
	Output1 = "Hold " .. BindKey .. " To Hack The Turret"
	Output2 = ""
	BoxHeightMax = 40
	BoxWidth = string.len(Output1) * 13.5
	BoxSide = ScrW() * (0.5 - (string.len(Output1) * 0.0035))
	BoxHigh = ScrH() * 0.4975
elseif Hacking >= 1 then
	Output1 = "Hacking..."
	Output2 = math.Round(Hacking, 0) .. "%"
	BoxHeightMax = 70
	BoxWidth = 115
	BoxSide = ScrW() * 0.47
	BoxHigh = ScrH() * 0.5
end

if IsValid(Target) and Target:GetOwner() == LocalPlayer() then
	Output1 = "Turret Hacked By You"
	BoxSide = ScrW() * (0.5 - (string.len(Output2) * 0.0035))
	BoxHigh = ScrH() * 0.5
	BoxWidth = string.len(Output2) * 13.5
if LocalPlayer():GetNWString("Tier 2 Perk") == "Engineer" then
	BoxHeightMax = 70
if LocalPlayer():GetNWBool("HasTurret", false) == false then
	Output2 = "Hold " .. BindKey .. " To Pickup The Turret"
else
	Output2 = "Already carrying a Turret"
end
elseif Target:GetOwner() != LocalPlayer() and Target:GetOwner():IsPlayer() then
	Output1 = "Turret Hacked By " .. Entity(Target:GetOwner():EntIndex()):Nick()
	Output2 = ""
	BoxSide = ScrW() * 0.4141
	BoxWidth = 330
end
end

if TextAlpha1 > 1 then
	surface.SetDrawColor(5, 5, 5, CODAlphaClr1)
	surface.DrawRect(BoxSide, BoxHigh, BoxWidth, BoxHeight)
	draw.DrawText(Output1, Text, ScrW() * 0.5, ScrH() * 0.5, Color(255, 255, 255, TextAlpha1), TEXT_ALIGN_CENTER)
	draw.DrawText(Output2, Text, ScrW() * 0.5, ScrH() * 0.53, Color(255, 255, 255, TextAlpha1), TEXT_ALIGN_CENTER)
end

end

end)

end