local SpotMat = Material("spottext")
local FriendMat = Material("friendmech")
local ItemMat = Material("itemspot")
local DeathPerMat = Material("DeathPerceptionSpot")

hook.Add("PostDrawOpaqueRenderables", "CodPerksStencils", function()

if IsValid(LocalPlayer()) and LocalPlayer():Alive() and (GetConVar("CODPerksHaloSystem"):GetInt() == 2 or GetConVar("CODPerksHaloSystem"):GetInt() == 3) then

for _,SpottedEnts in pairs(ents.GetAll()) do
if IsValid(SpottedEnts) then

if SpottedEnts:GetNWBool("ReconSpotted", false) == true and (GetConVar("CODPerksReconSpotStyle"):GetInt() == 2 or GetConVar("CODPerksReconSpotStyle"):GetInt() == 3) then

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

if GetConVar("CODPerksReconStencilVisibility"):GetInt() == 0 then
	render.SetBlend(1)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
	SpottedEnts:DrawModel()
end
if GetConVar("CODPerksReconStencilVisibility"):GetInt() == 1 then
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
if GetConVar("CODPerksReconStencilVisibility"):GetInt() == 2 then
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end

render.SetStencilEnable(false)

end

if SpottedEnts:GetNWBool("ItemSpotted", false) == true and (GetConVar("CODPerksScroungerSpotStyle"):GetInt() == 2 or GetConVar("CODPerksScroungerSpotStyle"):GetInt() == 3) then

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

if GetConVar("CODPerksScroungerStencilVisibility"):GetInt() == 0 then
	render.SetBlend(1)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetMaterial(ItemMat)
	render.DrawScreenQuad()
	SpottedEnts:DrawModel()
end
if GetConVar("CODPerksScroungerStencilVisibility"):GetInt() == 1 then
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(ItemMat)
	render.DrawScreenQuad()
end
if GetConVar("CODPerksScroungerStencilVisibility"):GetInt() == 2 then
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(ItemMat)
	render.DrawScreenQuad()
end

render.SetStencilEnable(false)

end

if SpottedEnts:GetNWBool("HackerSpotted", false) == true and (GetConVar("CODPerksHackerSpotStyle"):GetInt() == 2 or GetConVar("CODPerksHackerSpotStyle"):GetInt() == 3) then

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

if GetConVar("CODPerksHackerStencilVisibility"):GetInt() == 0 then
	render.SetBlend(1)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
	SpottedEnts:DrawModel()
end
if GetConVar("CODPerksHackerStencilVisibility"):GetInt() == 1 then
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
if GetConVar("CODPerksHackerStencilVisibility"):GetInt() == 2 then
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end

render.SetStencilEnable(false)

end

if (SpottedEnts:GetNWBool("MechSpotted", false) == true or SpottedEnts:GetNWBool("MechSpottedFriendly", false) == true) and (GetConVar("CODPerksEngineerSpotStyle"):GetInt() == 2 or GetConVar("CODPerksEngineerSpotStyle"):GetInt() == 3) then

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

if GetConVar("CODPerksEngineerStencilVisibility"):GetInt() == 0 then
	render.SetBlend(1)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
if SpottedEnts:GetNWBool("MechSpottedFriendly", false) == true then
	render.SetMaterial(FriendMat)
	render.DrawScreenQuad()
else
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
	SpottedEnts:DrawModel()
end
if GetConVar("CODPerksEngineerStencilVisibility"):GetInt() == 1 then
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
if SpottedEnts:GetNWBool("MechSpottedFriendly", false) == true then
	render.SetMaterial(FriendMat)
	render.DrawScreenQuad()
else
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
end
if GetConVar("CODPerksEngineerStencilVisibility"):GetInt() == 2 then
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
if SpottedEnts:GetNWBool("MechSpottedFriendly", false) == true then
	render.SetMaterial(FriendMat)
	render.DrawScreenQuad()
else
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
end

render.SetStencilEnable(false)

end

if SpottedEnts:GetNWBool("ExplosiveSpotted", false) == true and (GetConVar("CODPerksSitRepSpotStyle"):GetInt() == 2 or GetConVar("CODPerksSitRepSpotStyle"):GetInt() == 3) then

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

if GetConVar("CODPerksSitRepStencilVisibility"):GetInt() == 0 then
	render.SetBlend(1)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
	SpottedEnts:DrawModel()
end
if GetConVar("CODPerksSitRepStencilVisibility"):GetInt() == 1 then
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
if GetConVar("CODPerksSitRepStencilVisibility"):GetInt() == 2 then
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end

render.SetStencilEnable(false)

end

if SpottedEnts:GetNWBool("PulsarSpotted", false) == true and (GetConVar("CODPerksPulsarSpotStyle"):GetInt() == 2 or GetConVar("CODPerksPulsarSpotStyle"):GetInt() == 3) then

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

if GetConVar("CODPerksPulsarStencilVisibility"):GetInt() == 0 then
	render.SetBlend(1)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
	SpottedEnts:DrawModel()
end
if GetConVar("CODPerksPulsarStencilVisibility"):GetInt() == 1 then
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
if GetConVar("CODPerksPulsarStencilVisibility"):GetInt() == 2 then
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end

render.SetStencilEnable(false)

end

if SpottedEnts:GetNWBool("DeathPer", false) == true and (GetConVar("CODPerksDeathPerSpotStyle"):GetInt() == 2 or GetConVar("CODPerksDeathPerSpotStyle"):GetInt() == 3) then

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

if GetConVar("CODPerksDeathPerStencilVisibility"):GetInt() == 0 then
	render.SetBlend(1)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
	SpottedEnts:DrawModel()
end
if GetConVar("CODPerksDeathPerStencilVisibility"):GetInt() == 1 then
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
if GetConVar("CODPerksDeathPerStencilVisibility"):GetInt() == 2 then
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end

render.SetStencilEnable(false)

end

if SpottedEnts:GetNWBool("VultureAid", false) == true and (GetConVar("CODPerksVultureAidSpotStyle"):GetInt() == 2 or GetConVar("CODPerksVultureAidSpotStyle"):GetInt() == 3) then

render.ClearStencil()
render.SetStencilEnable(true)
render.SetStencilWriteMask(255)
render.SetStencilTestMask(255)
render.SetStencilReferenceValue(15)
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
render.SetBlend(0)

SpottedEnts:DrawModel()
render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

if GetConVar("CODPerksVultureAidStencilVisibility"):GetInt() == 0 then
	render.SetBlend(1)
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
	SpottedEnts:DrawModel()
end
if GetConVar("CODPerksVultureAidStencilVisibility"):GetInt() == 1 then
	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end
if GetConVar("CODPerksVultureAidStencilVisibility"):GetInt() == 2 then
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetMaterial(SpotMat)
	render.DrawScreenQuad()
end

render.SetStencilEnable(false)

end

end
end

end

end)