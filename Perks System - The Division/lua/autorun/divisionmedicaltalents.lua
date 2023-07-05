if SERVER then

local PickupDelay = 0

hook.Add("PlayerCanPickupItem", "DivisionMedicalHeal", function(ply, item)

if ply:IsPlayer() and ply:GetNWString("Slot 1 Talent", "None") == "Critical Save" or ply:GetNWString("Slot 2 Talent", "None") == "Critical Save" or ply:GetNWString("Slot 3 Talent", "None") == "Critical Save" or ply:GetNWString("Slot 4 Talent", "None") == "Critical Save" then

if item:GetClass() == "item_healthkit" or item:GetClass() == "item_healthvial" then
if true and ply:Health() <= ply:GetMaxHealth() * 0.3 then
	ply:SetNWInt("CTSDmgRes", CurTime() + 10)
end
end

end

if ply:IsPlayer() and ply:GetNWString("Slot 1 Talent", "None") == "Combat Medic" or ply:GetNWString("Slot 2 Talent", "None") == "Combat Medic" or ply:GetNWString("Slot 3 Talent", "None") == "Combat Medic" or ply:GetNWString("Slot 4 Talent", "None") == "Combat Medic" then

if true and ply:Health() < ply:GetMaxHealth() and ply:GetNWInt("ProxyDel", 0) < CurTime() then
	ply:SetNWInt("ProxyDel", CurTime() + 3)

for _,Fren in pairs(ents.FindInSphere(ply:GetPos(), 1050)) do
	if Fren != ply and (Fren:IsPlayer() and Fren:Team() == ply:Team()) or (Fren:IsNPC() and Fren:Disposition(ply) == D_LI) and Fren:GetNWInt("ProxyDel", 0) < CurTime() then

if item:GetClass() == "item_healthkit" then
	Fren:SetHealth(math.Clamp(Fren:Health() + GetConVar("sk_healthkit"):GetInt(), 0, Fren:GetMaxHealth()))
elseif item:GetClass() == "item_healthvial" then
	Fren:SetHealth(math.Clamp(Fren:Health() + GetConVar("sk_healthvial"):GetInt(), 0, Fren:GetMaxHealth()))
end

end
end

end

end

end)

hook.Add("Think", "DivisionMedical", function()

for _,P in pairs(player.GetAll()) do

if WalkSpeed == nil then
	WalkSpeed = P:GetWalkSpeed()
end
if RunSpeed == nil then
	RunSpeed = P:GetRunSpeed()
end

GetSeq = P:GetSequence()
Target = P:GetEyeTrace().Entity

if P:GetNWString("Slot 1 Talent", "None") == "Battle Buddy" or P:GetNWString("Slot 2 Talent", "None") == "Battle Buddy" or P:GetNWString("Slot 3 Talent", "None") == "Battle Buddy" or P:GetNWString("Slot 4 Talent", "None") == "Battle Buddy" then

if ConVarExists("mwii_revive_enable") then
if IsValid(Target) and Target:IsPlayer() and Target:Team() == P:Team() then
if GetSeq == P:LookupSequence("laststand_startrevive") then
	Revived = Target
	Revived:SetNWBool("BBRev", true)
	P:SetNWBool("BBRev", true)
end
if P:GetNWBool("BBRev") and Revived:GetNWBool("BBRev") == true and Revived:GetNWBool("Downed") == false then
	Revived:SetNWBool("BBRev", false)
	Revived:SetNWInt("BBDmgRes", CurTime() + 10)
	Revived = nil
	P:SetNWBool("BBRev", false)
	P:SetNWInt("BBDmgRes", CurTime() + 10)
end
if GetSeq != P:LookupSequence("laststand_startrevive") then
	P:SetNWBool("BBRev", false)
end

end
end
end

if P:GetNWInt("SaWSpeed", 0) > CurTime() then
	P:SetWalkSpeed(WalkSpeed * 1.10)
	P:SetRunSpeed(RunSpeed * 1.10)
elseif P:GetNWInt("SaWSpeed", 0) < CurTime() and P:GetNWInt("SaWSpeed", 0) != 0 then
	P:SetWalkSpeed(WalkSpeed)
	P:SetRunSpeed(RunSpeed)
	P:SetNWInt("SaWSpeed", 0)
end

if P:Health() > P:GetMaxHealth() and P:GetNWInt("Overheal", math.huge) < CurTime() then
P:SetHealth(P:GetMaxHealth())
elseif P:Health() <= P:GetMaxHealth() and P:GetNWInt("Overheal", 0) > CurTime() then
P:SetNWInt("Overheal", 0)
end

if P:GetNWString("Slot 1 Talent", "None") == "Adrenaline" or P:GetNWString("Slot 2 Talent", "None") == "Adrenaline" or P:GetNWString("Slot 3 Talent", "None") == "Adrenaline" or P:GetNWString("Slot 4 Talent", "None") == "Adrenaline" then

if P:Health() == P:GetMaxHealth() and IsValid(Target) and (Target:GetClass() == "item_healthkit" or Target:GetClass() == "item_healthvial") then

if P:KeyDown(IN_USE) and P:GetPos():Distance(Target:GetPos()) <= 90 then
	PickupDelay = math.Clamp(PickupDelay + 0.1, 0, 5)
end

if Target:GetClass() != "item_healthkit" and Target:GetClass() != "item_healthvial" then
	PickupDelay = 0
end

if PickupDelay == 5 and Target:GetClass() == "item_healthkit" then
	Target:Remove()
	P:SetHealth(math.Clamp(P:Health() + GetConVar("sk_healthkit"):GetInt(), 0, P:GetMaxHealth() + 40))
	P:SetNWInt("Overheal", CurTime() + 30)
	PickupDelay = 0
end

if PickupDelay == 5 and Target:GetClass() == "item_healthvial" then
	Target:Remove()
	P:SetHealth(math.Clamp(P:Health() + GetConVar("sk_healthvial"):GetInt(), 0, P:GetMaxHealth() + 40))
	P:SetNWInt("Overheal", CurTime() + 30)
	PickupDelay = 0
end

end
end

end

end)

hook.Add("EntityTakeDamage", "DivisionMedicalDMG", function( target, dmginfo )

local P = dmginfo:GetAttacker()

if P:IsPlayer() and P:GetNWInt("BBDmgRes", 0) > CurTime() then
	dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Critical Save" or P:GetNWString("Slot 2 Talent", "None") == "Critical Save" or P:GetNWString("Slot 3 Talent", "None") == "Critical Save" or P:GetNWString("Slot 4 Talent", "None") == "Critical Save" then
if P:GetNWInt("CTSDmgRes", 0) > CurTime() then
	dmginfo:SetDamage(dmginfo:GetDamage() * 0.6)
end
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Shock And Awe" or P:GetNWString("Slot 2 Talent", "None") == "Shock And Awe" or P:GetNWString("Slot 3 Talent", "None") == "Shock And Awe" or P:GetNWString("Slot 4 Talent", "None") == "Shock And Awe" and target != dmginfo:GetAttacker() then

if (target:IsNPC() and target:Disposition(dmginfo:GetAttacker()) == D_LI) or (target:IsPlayer() and target:Team() == dmginfo:GetAttacker():Team()) then
	P.HitCount = 0
end

if P.LastTarget == nil and (target:IsNPC() and target:Disposition(dmginfo:GetAttacker()) == D_HT) or (target:IsPlayer() and target:Team() != dmginfo:GetAttacker():Team()) then
	P.LastTarget = target
	P.HitCount = 1
end

if target == P.LastTarget and (target:IsNPC() and target:Disposition(dmginfo:GetAttacker()) == D_HT) or (target:IsPlayer() and target:Team() != dmginfo:GetAttacker():Team()) then
	P.HitCount = P.HitCount + 1
elseif target != P.LastTarget and (target:IsNPC() and target:Disposition(dmginfo:GetAttacker()) == D_HT) or (target:IsPlayer() and target:Team() != dmginfo:GetAttacker():Team()) then
	P.LastTarget = target
	P.HitCount = 1
end

if P.HitCount == 4 then
	P:SetNWInt("SaWSpeed", CurTime() + 10)
	P.HitCount = 0
end

end

end)

end