hook.Add("HUDDrawTargetID", "ColdBloodHide", function()

local EyeTrace = LocalPlayer():GetEyeTrace().Entity

if IsValid(EyeTrace) and EyeTrace:IsPlayer() then
if EyeTrace:Team() != LocalPlayer():Team() and EyeTrace:GetNWString("Tier 2 Perk") == "Cold Blooded" then
	return false
end
end

end)