local SpotMat = Material("spottext")
local FriendMat = Material("friendmech")
local ItemMat = Material("itemspot")
local DeathPerMat = Material("DeathPerceptionSpot")

hook.Add("PostDrawOpaqueRenderables", "CodPerksStencils", function()

if IsValid(LocalPlayer()) and LocalPlayer():Alive() and (GetConVar("CODPerksHaloSystem"):GetInt() == 2 or GetConVar("CODPerksHaloSystem"):GetInt() == 3) then

for _,SpottedEnts in pairs(ents.GetAll()) do

if IsValid(SpottedEnts) and (SpottedEnts:GetNWBool("ReconSpotted", false) == true or SpottedEnts:GetNWBool("HackerSpotted", false) == true or SpottedEnts:GetNWBool("PulsarSpotted", false) == true or SpottedEnts:GetNWBool("MechSpotted", false) == true or SpottedEnts:GetNWBool("MechSpottedFriendly", false) == true or SpottedEnts:GetNWBool("ItemSpotted", false) == true or SpottedEnts:GetNWBool("ExplosiveSpotted", false) == true or SpottedEnts:GetNWBool("DeathPerception", false) == true or SpottedEnts:GetNWBool("VultureAid", false) == true) then

local EyePos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 10
local EyeAng = LocalPlayer():EyeAngles()
local EyeAngFinal = Angle(EyeAng.p + 90, EyeAng.y, 0)

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilFailOperation(STENCILOPERATION_KEEP)
render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
render.SetStencilPassOperation(STENCILOPERATION_KEEP)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()

render.SetBlend(1)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
cam.Start3D2D(EyePos, EyeAngFinal, 1)

if SpottedEnts:GetNWBool("MechSpottedFriendly", false) == true then
	render.SetMaterial(FriendMat)
	render.DrawScreenQuad()
elseif SpottedEnts:GetNWBool("ItemSpotted", false) == true then
	render.SetMaterial(ItemMat)
	render.DrawScreenQuad()
elseif SpottedEnts:GetNWBool("DeathPerception", false) == true or SpottedEnts:GetNWBool("VultureAid", false) == true then
	render.SetMaterial(DeathPerMat)
	render.DrawScreenQuad()
else
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
cam.End3D2D()
SpottedEnts:DrawModel()

render.SetStencilEnable(false)

end
end
end

end)