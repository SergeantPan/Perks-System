function TurretFunc(ply, type)

if type == 1 and ply:GetNWInt("TurretPlace", 0) == 0 then
	ply:SetNWInt("TurretPlace", 1)
elseif type == 1 and ply:GetNWInt("TurretPlace", 0) == 1 then
	ply:SetNWInt("TurretPlace", 0)
end

if type == 2 then
	timer.Simple(1, function() if IsValid(ply) then ply:SetNWInt("TurretPlace", 0) end end)
end

end

hook.Add("PlayerButtonDown", "EngineerPickupButton", function( ply, button )

Target = ply:GetEyeTrace()

if button == GetConVar("CODPerksInteract"):GetInt() then
if !Target.Hit or (Target.Hit and (Target.Entity:GetClass() != "npc_turret_floor" or Target.Entity:GetPos():Distance(ply:GetPos()) > 60)) and ply:GetNWInt("HasTurret", false) == true then
	TurretFunc(ply, 1)
end
end

end)

if SERVER then

hook.Add("DoPlayerDeath", "DeathTurretReset", function(ply)

if ply:GetNWInt("TurretPlace", 0) != 0 then
	ply:SetNWInt("TurretPlace", 0)
	CanPlace = false
end

end)

net.Receive("TurretRemove", function()
	P = net.ReadEntity()
	Pos = net.ReadVector()
	Ang = net.ReadAngle()
	Name = P:Nick() .. "'s Turret"

if P:GetNWBool("HasTurret", false) == true then

for _,tur in pairs(ents.FindByClass("prop_dynamic")) do
if tur:GetName() == Name and tur:GetOwner() == P then
	tur:Remove()
end
end

TurretBack = ents.Create("npc_turret_floor")
TurretBack:SetOwner(P)
TurretBack:SetName(P:Nick() .. "'s Turret")
TurretBack:SetNWInt("HackedTeam", P:Team())
TurretBack:Spawn()
TurretBack:SetPos(Pos)
TurretBack:SetAngles(Ang)

undo.Create("NPC (npc_turret_floor)")
undo.AddEntity(TurretBack)
undo.SetPlayer(P)
undo.SetCustomUndoText("Undone Turret")
undo.Finish()

P:SetNWBool("HasTurret", false)
P:SetNWInt("TurretPlace", 0)
P:EmitSound("npc/turret_floor/deploy.wav")

end

end)

end

if CLIENT then

RotateCool = 0
PlaceAngle = 0

hook.Add("StartCommand", "DisableTurretKeypress", function(ply,cmd)

if ply:GetNWInt("TurretPlace", 0) != 0 then
	ply:ConCommand("-attack")
	ply:ConCommand("-attack2")
if cmd:KeyDown(2048) then
	cmd:RemoveKey(2048)
if RotateCool < CurTime() then
	PlaceAngle = PlaceAngle + 90
	RotateCool = CurTime() + 0.1
if PlaceAngle == 360 then
	PlaceAngle = 0
end
end
end
if cmd:KeyDown(1) then
	cmd:RemoveKey(1)
if CanPlace == true then
	TurretFunc(ply, 2)
	LocalPlayer():SetNWInt("TurretPlace", 2)
net.Start("TurretRemove")
	net.WriteEntity(LocalPlayer())
	net.WriteVector(FinalPos + Vector(0,0,1))
	net.WriteAngle(Angle(0, LocalPlayer():GetAngles().y + PlaceAngle, 0))
net.SendToServer()
	PlaceAngle = 0
end
end
end

end)

TurretRend = ents.CreateClientProp("models/Combine_turrets/Floor_turret.mdl")
ErrorReason = "INVALID POSITION"
Yellow = Color(255, 255, 0)
Red = Color(255, 0, 0)

hook.Add("Think", "TurretGarbageCollect", function()

if LocalPlayer():GetNWInt("TurretPlace", 0) != 1 and TurretRend != nil and IsValid(TurretRend) then
	TurretRend:Remove()
	TurretRend = nil
	PlaceAngle = 0
end

if LocalPlayer():GetNWInt("TurretPlace", 0) == 1 and (TurretRend == nil or !IsValid(TurretRend)) then
	TurretRend = ents.CreateClientProp("models/Combine_turrets/Floor_turret.mdl")
	TurretRend:SetColor()
	TurretRend:SetMaterial("models/debug/debugwhite")
	TurretRend:SetRenderMode( RENDERMODE_TRANSCOLOR )
end

if IsValid(TurretRend) and CanPlace == false then
	TurretRend:SetColor(Red)
elseif IsValid(TurretRend) and CanPlace == true then
	TurretRend:SetColor(Yellow)
end

end)

hook.Add("PostDrawTranslucentRenderables", "TurretRender", function()

if LocalPlayer():GetNWInt("TurretPlace", 0) == 1 and IsValid(TurretRend) then

	CanPlace = true

	local eyePos = LocalPlayer():EyePos()
	local eyeDir = LocalPlayer():GetAimVector()
	local mins = TurretRend:OBBMins()
	local maxs = TurretRend:OBBMaxs()

	local tr = util.TraceHull( {
		start = (eyePos - eyeDir * 10),
		endpos = (eyePos + eyeDir * 100) + Vector(0, 0, -10),
		maxs = maxs,
		mins = mins,
		filter = LocalPlayer()
	} )

	local tr2 = util.TraceLine( {
		start = (tr.HitPos + Vector(0, 0, 10)),
		endpos = tr.HitPos + Vector(0, 0, -100),
		filter = LocalPlayer()
	} )

	local tr3 = util.TraceLine( {
		start = (tr.HitPos + Vector(0,0,10)) + TurretRend:GetForward() * 20,
		endpos = (tr.HitPos + Vector(0, 0, -100)) + TurretRend:GetForward() * 20,
		filter = LocalPlayer()
	} )

	local tr4 = util.TraceLine( {
		start = (tr.HitPos + Vector(0,0,10)) - TurretRend:GetForward() * 20,
		endpos = (tr.HitPos + Vector(0, 0, -100)) - TurretRend:GetForward() * 20,
		filter = LocalPlayer()
	} )

	TR2Spot = tr2.HitPos.z
	TR3Spot = tr3.HitPos.z
	TR4Spot = tr4.HitPos.z
	FinalPos = tr2.HitPos

	if TR3Spot > TR2Spot or TR4Spot > TR2Spot then
	if TR3Spot > TR4Spot then
		FinalPos = tr3.HitPos - TurretRend:GetForward() * 20
	else
		FinalPos = tr4.HitPos + TurretRend:GetForward() * 20
	end
	end


	if (math.Distance(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, tr4.HitPos.x, tr4.HitPos.y) <= 10) or math.Distance(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, tr2.HitPos.x, tr2.HitPos.y) <= 10 then
		CanPlace = false
		ErrorReason = "TOO CLOSE"
	end
	if tr2.Hit and ((tr3.HitPos.z > tr4.HitPos.z + GetConVar("CODPerksEngineerUnevenLimit"):GetInt()) or (tr3.HitPos.z + GetConVar("CODPerksEngineerUnevenLimit"):GetInt() < tr4.HitPos.z)) then
		CanPlace = false
		ErrorReason = "UNEVEN SURFACE"
	end
	if tr2.StartSolid then
		CanPlace = false
		ErrorReason = "POSITION BLOCKED"
	end
	if !tr2.Hit and (!tr3.Hit or !tr4.Hit) then
	if TurretRend:GetNoDraw() == false then
		TurretRend:SetNoDraw(true)
	end
		CanPlace = false
		ErrorReason = "INVALID SURFACE"
	elseif tr2.Hit and TurretRend:GetNoDraw() == true then
		TurretRend:SetNoDraw(false)
	end

	TurretRend:SetPos(FinalPos + Vector(0,0,1))
	TurretRend:SetAngles(Angle(0, LocalPlayer():GetAngles().y + PlaceAngle, 0))

end

end)

CODAlphaClr2 = 0
RectAlpha = 0
TextAlpha = 0

hook.Add("HUDPaint", "CODTurretPlaceHUD", function()

RedText = Color(255, 0, 0, CODAlphaClr2)
Text = "InteractFont"

if input.LookupBinding("+attack") == "ENTER" then
	Attack = "MOUSE1"
else
	Attack = input.LookupBinding("+attack")
end

if LocalPlayer():GetNWInt("TurretPlace", 0) == 0 and CODAlphaClr2 != 0 then
	CODAlphaClr2 = 0
	RectAlpha = 0
	TextAlpha = 0
end

if LocalPlayer():Alive() and LocalPlayer():GetNWInt("TurretPlace", 0) == 1 then
if TextAlpha != 255 or CODAlphaClr2 != 225 or RectAlpha != 100 then
	TextAlpha = math.Clamp(TextAlpha + 3, 0, 255)
	CODAlphaClr2 = math.Clamp(CODAlphaClr2 + 3, 0, 225)
	RectAlpha = math.Clamp(RectAlpha + 3, 0, 100)
end
	surface.SetDrawColor(5, 5, 5, CODAlphaClr2)
	surface.DrawRect(ScrW() * 0.315, ScrH() * 0.529, 300, RectAlpha)
	if CanPlace == true then
		draw.DrawText(Attack .. " - Place Turret", Text, ScrW() * 0.32, ScrH() * 0.53, Color(255, 255, 255, TextAlpha))
	else
		draw.DrawText(ErrorReason, Text, ScrW() * 0.32, ScrH() * 0.53, RedText)
	end
	draw.DrawText(input.LookupBinding("+attack2") .. " - Rotate Turret", Text, ScrW() * 0.32, ScrH() * 0.56, Color(255, 255, 255, TextAlpha))
	draw.DrawText(string.upper(input.GetKeyName(GetConVar("CODPerksInteract"):GetInt())) .. " - Cancel", Text, ScrW() * 0.32, ScrH() * 0.59, Color(255, 255, 255, TextAlpha))
end

end)

end