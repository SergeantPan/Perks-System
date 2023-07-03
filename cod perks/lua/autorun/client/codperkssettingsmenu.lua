hook.Add( "PopulateToolMenu", "MenuForSettings", function()
spawnmenu.AddToolMenuOption( "Options", "Player Perks", "PerksSettings", "Settings", "", "", function( panel )
	panel:ClearControls()

	panel:NumSlider("Armorer Mechanic", "CODPerksArmorerAltMechanic", 0, 2, 0)
	panel:Help("Change how the Armorer perk functions:\n 0 = Loot bodies for +5 armor. +25 max armor.\n 1 = Loot bodies for +5 armor. Spawn with 50 armor.\n 2 = +25 max armor. Spawn with 50 armor.")
	panel:NumSlider("Popup Icon X Pos", "CODPerksIconXPos", 0, 1, 2)
	panel:Help("Change the horizontal position of the Perk icon that pops up with Juggernaut/Blast Shield/Scavenger/Armorer. Default is 0.45")
	panel:NumSlider("Popup Icon Y Pos", "CODPerksIconYPos", 0, 1, 2)
	panel:Help("Change the vertical position of the Perk icon that pops up with Juggernaut/Blast Shield/Scavenger/Armorer. Default is 0.5")
	panel:NumSlider("Perk Icons X Pos", "CODPerksXPos", 0, 1, 2)
	panel:Help("Change the horizontal position of the perk icons. Default is 0.1")
	panel:NumSlider("Perk Icons Y Pos", "CODPerksYPos", 0, 1, 2)
	panel:Help("Change the vertical position of the perk icons. Default is 0.8")

	panel:CheckBox("Vertical/Horizontal Icons", "CODPerksVerticalHorizontal")
	panel:Help("Change the orientation of the perk icons. Off = Vertical, On = Horizontal")
	panel:CheckBox("Tier 1 Perk at top/bottom", "CODPerksTierPosition")
	panel:Help("Change the order in which perks are listed. Off = Tier 1 at top, On = Tier 3 at top")

	panel:CheckBox("Hide Perks after spawning", "CODPerksHideIcons")
	panel:Help("Fade out perk icons shortly after spawning in")

	panel:NumSlider("Perk Icons Gap", "CODPerksGap", 0, 100, 0)
	panel:Help("Increase the gap between the perk icons. For use with bigger perk icons. Default is 0")
	panel:NumSlider("Perk Icons Size", "CODPerksIconSize", 0, 120, 0)
	panel:Help("Change the size of the perk icons. Default is 60")

	panel:NumSlider("T1 Perk X Pos", "CODPerksT1X", -100, 100, 2)
	panel:Help("Adjust the horizontal position of the T1 Perk (Blue)")
	panel:NumSlider("T1 Perk Y Pos", "CODPerksT1Y", -100, 100, 2)
	panel:Help("Adjust the vertical position of the T1 Perk (Blue)")
	panel:NumSlider("T2 Perk X Pos", "CODPerksT2X", -100, 100, 2)
	panel:Help("Adjust the horizontal position of the T2 Perk (Red)")
	panel:NumSlider("T2 Perk Y Pos", "CODPerksT2Y", -100, 100, 2)
	panel:Help("Adjust the vertical position of the T2 Perk (Red)")
	panel:NumSlider("T3 Perk X Pos", "CODPerksT3X", -100, 100, 2)
	panel:Help("Adjust the horizontal position of the T3 Perk (Yellow)")
	panel:NumSlider("T3 Perk Y Pos", "CODPerksT3Y", -100, 100, 2)
	panel:Help("Adjust the vertical position of the T3 Perk (Yellow)")
end)

spawnmenu.AddToolMenuOption( "Options", "Player Perks", "Misc", "Miscellaneous", "", "", function( panel )
	panel:ClearControls()
	panel:Help("Turret Hacking keybind")
	local binder = vgui.Create( "DBinder", frame )
	panel:AddItem(binder)
	function binder:OnChange( num )
		RunConsoleCommand("CODPerksInteract", string.upper(input.GetKeyName(num)))
	end
	panel:Help("Toggle Perk Icons")
	local binder = vgui.Create( "DBinder", frame )
	panel:AddItem(binder)
	function binder:OnChange( num )
		RunConsoleCommand("CODPerksToggleIcons", string.upper(input.GetKeyName(num)))
	end

	local ArmorerChoice = panel:ComboBox("Armorer Mechanics", "CODPerksArmorerAltMechanic")
	ArmorerChoice:SetSortItems(false)
	ArmorerChoice:AddChoice("Loot + Max Armor", "0")
	ArmorerChoice:AddChoice("Loot + Spawn Armor", "1")
	ArmorerChoice:AddChoice("Spawn + Max Armor", "2")
	panel:Help("Change the mechanics of the Armorer perk:\n Loot + Max Armor = Loot bodies for +5 armor. +25 max armor.\n Loot + Spawn Armor = Loot bodies for +5 armor. Spawn with 50 armor.\n Spawn + Max Armor = +25 max armor. Spawn with 50 armor.")

	local T1Choice = panel:ComboBox("Default T1 Perk", "CODPerksDefaultT1")
	T1Choice:SetSortItems(false)
	T1Choice:AddChoice("None")
	T1Choice:AddChoice("Blind Eye")
	T1Choice:AddChoice("Recon")
	T1Choice:AddChoice("Marathon")
	T1Choice:AddChoice("Scrounger")
	T1Choice:AddChoice("Scavenger")
	T1Choice:AddChoice("Lightweight")
	T1Choice:AddChoice("Quick-Fix")
	T1Choice:AddChoice("Armorer")
	T1Choice:AddChoice("Hacker")
	panel:Help("Default T1 Perk to select on spawn")
	local T2Choice = panel:ComboBox("Default T2 Perk", "CODPerksDefaultT2")
	T2Choice:SetSortItems(false)
	T2Choice:AddChoice("None")
	T2Choice:AddChoice("Blast Shield")
	T2Choice:AddChoice("Survivalist")
	T2Choice:AddChoice("Assassin")
	T2Choice:AddChoice("Mobility")
	T2Choice:AddChoice("Stopping Power")
	T2Choice:AddChoice("Danger Close")
	T2Choice:AddChoice("Juggernaut")
	T2Choice:AddChoice("Hardened")
	T2Choice:AddChoice("Engineer")
	T2Choice:AddChoice("High Alert")
	T2Choice:AddChoice("Tactical Mask")
	T2Choice:AddChoice("Cold Blooded")
	panel:Help("Default T2 Perk to select on spawn")
	local T3Choice = panel:ComboBox("Default T3 Perk", "CODPerksDefaultT3")
	T3Choice:SetSortItems(false)
	T3Choice:AddChoice("None")
	T3Choice:AddChoice("Marksman")
	T3Choice:AddChoice("Dead Silence")
	T3Choice:AddChoice("SitRep")
	T3Choice:AddChoice("Stalker")
	T3Choice:AddChoice("Commando")
	T3Choice:AddChoice("Pulsar")
	T3Choice:AddChoice("Martyrdom")
	T3Choice:AddChoice("Ninja")
	T3Choice:AddChoice("Executioner")
	panel:Help("Default T3 Perk to select on spawn")
	
end)
end)