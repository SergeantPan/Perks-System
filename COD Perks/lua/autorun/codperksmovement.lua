hook.Add("PlayerFootstep", "Dead Silence", function(ply, pos, foot, sound, volume, rf)

if ply:GetNWString("Tier 3 Perk") == "Dead Silence" then
return true;
end

end)

local SprintStarted = false

hook.Add( "Move", "CodMovementPerks", function( Ply, mv )

if RunSpeed == nil then
RunSpeed = Ply:GetRunSpeed()
end
if WalkSpeed == nil then
WalkSpeed = Ply:GetWalkSpeed()
end
if CrouchSpeed == nil then
CrouchSpeed = Ply:GetCrouchedWalkSpeed()
end
if JumpHeight == nil then
JumpHeight = Ply:GetJumpPower()
end

if Ply:GetNWString("Tier 3 Perk") == "Stalker" and Ply:Crouching() then
Ply:SetCrouchedWalkSpeed(math.Clamp(CrouchSpeed * 1.5, 0, 1))
else
Ply:SetCrouchedWalkSpeed(CrouchSpeed)
end

if Ply:IsSuitEquipped() and GetConVar("gmod_suit"):GetBool() then
if Ply:GetNWString("Tier 1 Perk") == "Marathon" and Ply:IsSprinting() and Ply:GetVelocity():LengthSqr() > 0 and Ply.SprintStarted != true then
Ply:SetSuitPower(Ply:GetSuitPower() * 2)
Ply.SprintStarted = true
end

if (Ply:GetNWString("Tier 1 Perk") != "Marathon" or !Ply:IsSprinting() or Ply:GetVelocity():LengthSqr() <= 0) and Ply.SprintStarted == true then
Ply.SprintStarted = false
Ply:SetSuitPower(Ply:GetSuitPower() / 2)
end
end

if Ply:GetNWString("Tier 1 Perk") == "Marathon" and !GetConVar("gmod_suit"):GetBool() then
Ply:SetRunSpeed(RunSpeed * 1.1)
else
Ply:SetRunSpeed(RunSpeed)
end

if Ply:GetNWString("Tier 2 Perk") == "Mobility" then
Ply:SetWalkSpeed(WalkSpeed * 1.1)
Ply:SetJumpPower(JumpHeight * 1.15)
else
Ply:SetWalkSpeed(WalkSpeed)
Ply:SetJumpPower(JumpHeight)
end

end)