hook.Add("Think", "ColdBlooded", function()

if ArcticMedShots_ApplyEffect == nil then return end

if LocalPlayer():GetNWInt("Tier 2 Perk") == "Cold Blooded" and LocalPlayer().ArcticMedShots_ActiveEffects["coldblooded"] != math.huge then
	ArcticMedShots_ApplyEffect(LocalPlayer(), "coldblooded", math.huge)
elseif LocalPlayer():GetNWInt("Tier 2 Perk") != "Cold Blooded" then
	ArcticMedShots_ApplyEffect(LocalPlayer(), "coldblooded", 0)
end
// Dont sue me for this Arctic, I just think it's a cool feature

end)

hook.Add( "PopulateToolMenu", "ExternalPerks", function()

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "PerksMenuExt", "External Perks", "", "", function( panel )
	panel:ClearControls()

panel:Help("These perks require external addons for functionality. See tooltips for specifics.")

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 60)
PerkImage:SetSize(90,90)
PerkImage:SetImage("coldblooded.png")
PerkImage:SetToolTip("Cold Blooded\n- Immune to ArcCW Thermal Scopes\n- Requires Arctic's Combat Stims to work.")
PerkImage.DoClick = function()
net.Start("Tier2Perk")
if LocalPlayer():GetNWString("Tier 2 Perk") != "Cold Blooded" then
net.WriteEntity(LocalPlayer())
net.WriteString("Cold Blooded")
else
net.WriteEntity(LocalPlayer())
net.WriteString("None")
end
net.SendToServer()
end

end)
end)