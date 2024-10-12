hook.Add("PlayerFootstep", "Dead Silence", function(ply, pos, foot, sound, volume, rf)

if ply:GetNWString("Tier 3 Perk") == "Dead Silence" then
return true;
end

end)

local SprintStarted = false
local StalkerSet = false
local MobilitySet = false
local MarathonSet = false

hook.Add( "Move", "CodMovementPerks", function( Ply, mv )

if Ply:Alive() then
if CrouchSpeed == nil then
	CrouchSpeed = Ply:GetCrouchedWalkSpeed()
end
if JumpHeight == nil then
	JumpHeight = Ply:GetJumpPower()
end
if LadderSpeed == nil then
	LadderSpeed = Ply:GetLadderClimbSpeed()
end
end

if Ply:GetNWString("Tier 3 Perk") == "Stalker" and StalkerSet == false then
	Ply:SetCrouchedWalkSpeed(math.Clamp(CrouchSpeed * 1.5, 0, 1))
	StalkerSet = true
elseif Ply:GetNWString("Tier 3 Perk") != "Stalker" and StalkerSet == true then
	Ply:SetCrouchedWalkSpeed(CrouchSpeed)
	StalkerSet = false
end

if Ply:IsSuitEquipped() and GetConVar("gmod_suit"):GetBool() then
if Ply:GetNWString("Tier 1 Perk") == "Marathon" and Ply:IsSprinting() and Ply:GetVelocity():LengthSqr() > 0 and Ply.SprintStarted != true then
	Ply:SetSuitPower(Ply:GetSuitPower() * 2)
	Ply.SprintStarted = true
end

if (Ply:GetNWString("Tier 1 Perk") != "Marathon" or !Ply:IsSprinting() or Ply:GetVelocity():LengthSqr() <= 0 or Ply:WaterLevel() == 3) and Ply.SprintStarted == true then
	Ply.SprintStarted = false
	Ply:SetSuitPower(Ply:GetSuitPower() / 2)
end
end

if Ply:GetNWString("Tier 1 Perk") == "Marathon" and !GetConVar("gmod_suit"):GetBool() and MarathonSet == false then
	Ply:SetRunSpeed(Ply:GetRunSpeed() * 1.2)
	MarathonSet = true
elseif (Ply:GetNWString("Tier 1 Perk") != "Marathon" or GetConVar("gmod_suit"):GetBool()) and MarathonSet != false then
	Ply:SetRunSpeed(Ply:GetRunSpeed())
	MarathonSet = false
end

if Ply:GetNWString("Tier 2 Perk") == "Mobility" and MobilitySet == false then
	Ply:SetWalkSpeed(Ply:GetWalkSpeed() * 1.1)
	Ply:SetJumpPower(Ply:GetJumpPower() * 1.15)
	Ply:SetLadderClimbSpeed(LadderSpeed * 1.15)
	MobilitySet = true
elseif Ply:GetNWString("Tier 2 Perk") != "Mobility" and MobilitySet != false then 
	Ply:SetWalkSpeed(Ply:GetWalkSpeed())
	Ply:SetJumpPower(Ply:GetJumpPower())
	Ply:SetLadderClimbSpeed(LadderSpeed)
	MobilitySet = false
end

end)