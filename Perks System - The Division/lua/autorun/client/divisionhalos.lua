local color_red = Color( 255, 0, 0 )

net.Receive("TalentSpot", function()
	Target = net.ReadEntity()
	Enemy = net.ReadBool()
	Attacker = net.ReadEntity()
if Attacker:Team() == LocalPlayer():Team() and Target:IsNPC() and Enemy then
	Target:SetNWBool("TalentSpotted", true)
	Target:SetNWInt("TalentTimer", CurTime() + 10)
end
if Attacker:Team() == LocalPlayer():Team() and Target:IsPlayer() and Enemy then
	Target:SetNWBool("TalentSpotted", true)
	Target:SetNWInt("TalentTimer", CurTime() + 10)
end
end)

hook.Add( "PreDrawHalos", "DivisionHalos", function()

local PrecisionTargets = {}

for _,PingedNPC in pairs(ents.FindByClass("npc_*")) do
if PingedNPC:GetNWBool("TalentSpotted", false) == true and !table.HasValue(PrecisionTargets, PingedNPC) then
	PrecisionTargets[ #PrecisionTargets + 1 ] = PingedNPC
end
if PingedNPC:GetNWInt("TalentTimer", math.huge) < CurTime() and PingedNPC:GetNWBool("TalentSpotted", false) == true then
	table.RemoveByValue(PrecisionTargets, PingedNPC)
	PingedNPC:SetNWBool("TalentSpotted", false)
	PingedNPC:SetNWInt("TalentTimer", math.huge)
end
end

halo.Add(PrecisionTargets, color_red, 2, 2, 1, true, true)

end)