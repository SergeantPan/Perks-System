hook.Add( "PopulateToolMenu", "MenuForSettings", function()
spawnmenu.AddToolMenuOption( "Options", "Player Perks", "PerksSettings", "CoD Settings", "", "", function( panel )
	panel:ClearControls()

	panel:NumSlider("Halo/Overlay System", "CODPerksHaloSystem", 0, 3, 0)
	panel:Help("Change how the overlays of spotting-based perks work:\n 0 = Disabled\n 1 = Halo only\n 2 = Overlay only\n 3 = Halo + Overlay")

	panel:ControlHelp("\nPopup settings:")
	panel:NumSlider("Popup Icon X Pos", "CODPerksIconXPos", 0, 1, 2)
	panel:Help("Change the horizontal position of the Perk icon that pops up with Juggernaut/Blast Shield/Scavenger/Armorer. Default is 0.45")
	panel:NumSlider("Popup Icon Y Pos", "CODPerksIconYPos", 0, 1, 2)
	panel:Help("Change the vertical position of the Perk icon that pops up with Juggernaut/Blast Shield/Scavenger/Armorer. Default is 0.5")
	panel:NumSlider("Popup Icon Size", "CODPerksPopupIconSize", 0, 100, 0)
	panel:Help("Change the size of the Perk icon that pops up with Juggernaut/Blast Shield/Scavenger/Armorer. Default is 64")

	panel:ControlHelp("\nEngineer settings:")
	panel:Help("If the turret is not on the back, enable/disable this to change the position.")
	panel:CheckBox("Spawn with turret", "CODPerksEngineerSpawnTurret")
	panel:Help("When enabled, players with the Engineer perk will spawn in with a hacked turret.")
	panel:CheckBox("Limit to first spawn", "CODPerksEngineerSpawnTurretInitial")
	panel:Help('If "Spawn with turret" setting is enabled, only spawn a free turret on the players first spawn.')
	panel:NumSlider("Turret Vertical Offset", "CODPerksEngineerTurretPosX", -5, 5, 2)
	panel:Help("Move the turret on the playermodels back up/down.")
	panel:NumSlider("Turret Forward Offset", "CODPerksEngineerTurretPosY", -5, 5, 2)
	panel:Help("Move the turret on the playermodels back forward/backward.")
	panel:NumSlider("Turret Sideways Offset", "CODPerksEngineerTurretPosZ", -5, 5, 2)
	panel:Help("Move the turret on the playermodels back left/right.")
	panel:NumSlider("Turret Elevation Difference", "CODPerksEngineerUnevenLimit", 0, 20, 0)
	panel:Help("How much empty space below the front/back legs of the turret is allowed before placement becomes invalid. Default is 8")
	panel:NumSlider("Engineer Hacking Speed", "CODPerksEngineerHackingSpeed", 0, 100, 2)
	panel:Help("Adjust the speed at which the Engineer Perk can hack turrets. Default is 0.6")

	panel:ControlHelp("\nPerk Icons settings:")
	panel:NumSlider("Perk Icons X Pos", "CODPerksXPos", 0, 1, 2)
	panel:Help("Change the horizontal position of the perk icons. Default is 0.1")
	panel:NumSlider("Perk Icons Y Pos", "CODPerksYPos", 0, 1, 2)
	panel:Help("Change the vertical position of the perk icons. Default is 0.8")

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

	panel:ControlHelp("\nStalker immunity list:")
	panel:Help("Entities on this list will be affected by the Stalker perk, meaning they will not be triggered when the player walks past them. Only works on entities that depend on traces (e.g. the HL2 SLAM) to detect other entities.")

	local Text = vgui.Create("DTextEntry", frame)
	Text:SetPlaceholderText("Entity Class here (e.g. npc_tripmine)")

	local StalkerList = vgui.Create("DListView", frame)
	StalkerList:AddColumn("Entity")
	StalkerList:SetTall(300)
	StalkerList:SetMultiSelect(false)
	StalkerList:SetSortable(false)

	if file.Exists("codperks/stalkerlist.txt", "DATA") then
		Table = util.JSONToTable(file.Read( "codperks/stalkerlist.txt", "DATA" ))
		for _,Item in pairs(Table) do
			if Item != "" then
			StalkerList:AddLine(tostring(Item))
			end
		end
	end

	function StalkerList:DoDoubleClick( lineID, line )
		Table = util.JSONToTable(file.Read( "codperks/stalkerlist.txt", "DATA" ))
		table.remove(Table, lineID)
		file.Write(File, util.TableToJSON(Table))
		StalkerList:RemoveLine(lineID)
		for num,_ in pairs(StalkerList:GetLines()) do
			StalkerList:RemoveLine(num)
		end
		for _,Item in pairs(Table) do
			if Item != "" then
			StalkerList:AddLine(tostring(Item))
			end
		end
		if table.IsEmpty(Table) and file.Exists(File, "DATA") then
			file.Delete(File, "DATA")
		end
	end

	local Button = vgui.Create("DButton", frame)
	Button:SetText("Add entity to list")
	Button.DoClick = function()

		File = "codperks/stalkerlist.txt"

		if file.Exists(File, "DATA") then
			Table = util.JSONToTable(file.Read( File, "DATA" ))
		else
			Table = {}
		end

		if !table.HasValue(Table, Text:GetText()) then
			table.insert( Table, Text:GetText() )
			StalkerList:AddLine(Text:GetText())
			file.Write(File, util.TableToJSON(Table))
		end
	end

	local Text2 = vgui.Create("DLabel", frame)
	Text2:SetText("Double click an entity on the list to remove it\n")
	Text2:SetTextColor( Color(0, 0, 0) )

	panel:AddItem(Text3)
	panel:AddItem(Text)
	panel:AddItem(Button)
	panel:AddItem(StalkerList)
	panel:AddItem(Text2)
end)

spawnmenu.AddToolMenuOption( "Options", "Player Perks", "Misc", "CoD Misc", "", "", function( panel )
	panel:ClearControls()
	panel:Help("Turret Hacking keybind")
	local binder = vgui.Create( "DBinder", frame )
	panel:AddItem(binder)
	binder:SetValue(GetConVar("CODPerksInteract"):GetInt())
	function binder:OnChange( num )
		RunConsoleCommand("CODPerksInteract", num)
	end
	panel:Help("Toggle Perk Icons")
	local binder = vgui.Create( "DBinder", frame )
	panel:AddItem(binder)
	binder:SetValue(input.GetKeyCode(GetConVar("CODPerksToggleIcons"):GetString()))
	function binder:OnChange( num )
		RunConsoleCommand("CODPerksToggleIcons", string.upper(input.GetKeyName(num)))
	end

	local ArmorerChoice = panel:ComboBox("Armorer Mechanics", "CODPerksArmorerAltMechanic")
	ArmorerChoice:SetSortItems(false)
	ArmorerChoice:AddChoice("Loot + Max Armor", "0")
	ArmorerChoice:AddChoice("Loot + Spawn Armor", "1")
	ArmorerChoice:AddChoice("Spawn + Max Armor", "2")
	panel:Help("Change the mechanics of the Armorer perk:\n Loot + Max Armor = Loot bodies for +5 armor. +25 max armor.\n Loot + Spawn Armor = Loot bodies for +5 armor. Spawn with 50 armor.\n Spawn + Max Armor = +25 max armor. Spawn with 50 armor.")

	panel:CheckBox("Scavenger/Armorer Pickup Icon", "CODPerksEnableScavIcons" )
	panel:Help( "Enable the icons for Scavenger Pack/Armorer Boost pickups." )

	panel:CheckBox( "Enable Gunship balance mechanic", "CODPerksGunshipBalance" )
	panel:Help( "By default, Gunships have only 100 HP. This makes the Hardened perk extremely OP vs Gunships. Enabling the balance mechanic allows for the addon to automatically increase the HP of any Gunships that spawn into the game.")
	panel:NumSlider( "Gunship Health", "CODPerksGunshipBalanceHP", 0, 1000, 0 )
	panel:Help( "The HP the Gunship should spawn in with." )

	panel:CheckBox("Hide Perks after spawning", "CODPerksHideIcons")
	panel:Help("Fade out perk icons shortly after spawning in")

	panel:CheckBox("Horizontal Icons", "CODPerksVerticalHorizontal")
	panel:Help("Change the orientation of the perk icons to list them horizontally instead.")
	panel:CheckBox("Tier 3 Perk at top", "CODPerksTierPosition")
	panel:Help("Change the order in which perks are listed, with the Tier 3 perk being placed at the top.")

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

spawnmenu.AddToolMenuOption( "Options", "Player Perks", "ColaSpawnDefaults", "Perk-A-Cola Defaults", "", "", function( panel )
	panel:ClearControls()

	panel:CheckBox("Spawn with Juggernog", "CODPerkColaJG")
	panel:CheckBox("Spawn with Double Tap", "CODPerkColaDT")
	panel:CheckBox("Spawn with Deadshot Daquiri", "CODPerkColaDD")
	panel:CheckBox("Spawn with Stamin-Up", "CODPerkColaSU")
	panel:CheckBox("Spawn with PhD Flopper", "CODPerkColaPHD")
	panel:CheckBox("Spawn with Electric Cherry", "CODPerkColaEC")
	panel:CheckBox("Spawn with Vulture Aid", "CODPerkColaVA")
	panel:CheckBox("Spawn with Death Perception", "CODPerkColaDP")
	panel:CheckBox("Spawn with Elemental Pop", "CODPerkColaEP")

end)

spawnmenu.AddToolMenuOption( "Options", "Player Perks", "CodPerksStencilSettings", "CoD Spotting Settings", "", "", function( panel )
	panel:ClearControls()

	panel:NumSlider("Recon Spotting style", "CODPerksReconSpotStyle", 0, 3, 0)
	panel:Help("Select the style of the Recon perk spotting highlight.\n0 - None\n1 - Halo only\n2 - Overlay only\n3 - Halo + Overlay\nDefault is 3")
	panel:NumSlider("Spot overlay visiblity", "CODPerksReconStencilVisibility", 0, 2, 0)
	panel:Help("When should the Recon perk Overlay highlight be visible.\n0 - Only when obstructed\n1 - Only when unobstructed\n2 - Always\nDefault is 2")

	panel:NumSlider("Scrounger Spotting style", "CODPerksScroungerSpotStyle", 0, 3, 0)
	panel:Help("Select the style of the Scrounger perk spotting highlight.\n0 - None\n1 - Halo only\n2 - Overlay only\n3 - Halo + Overlay\nDefault is 3")
	panel:NumSlider("Spot overlay visiblity", "CODPerksScroungerStencilVisibility", 0, 2, 0)
	panel:Help("When should the Scrounger perk Overlay highlight be visible.\n0 - Only when obstructed\n1 - Only when unobstructed\n2 - Always\nDefault is 0")

	panel:NumSlider("Hacker Spotting style", "CODPerksHackerSpotStyle", 0, 3, 0)
	panel:Help("Select the style of the Hacker perk spotting highlight.\n0 - None\n1 - Halo only\n2 - Overlay only\n3 - Halo + Overlay\nDefault is 2")
	panel:NumSlider("Spot overlay visiblity", "CODPerksHackerStencilVisibility", 0, 2, 0)
	panel:Help("When should the Hacker perk Overlay highlight be visible.\n0 - Only when obstructed\n1 - Only when unobstructed\n2 - Always\nDefault is 2")

	panel:NumSlider("Engineer Spotting style", "CODPerksEngineerSpotStyle", 0, 3, 0)
	panel:Help("Select the style of the Engineer perk spotting highlight.\n0 - None\n1 - Halo only\n2 - Overlay only\n3 - Halo + Overlay\nDefault is 2")
	panel:NumSlider("Spot overlay visiblity", "CODPerksEngineerStencilVisibility", 0, 2, 0)
	panel:Help("When should the Engineer perk Overlay highlight be visible.\n0 - Only when obstructed\n1 - Only when unobstructed\n2 - Always\nDefault is 2")

	panel:NumSlider("SitRep Spotting style", "CODPerksSitRepSpotStyle", 0, 3, 0)
	panel:Help("Select the style of the SitRep perk spotting highlight.\n0 - None\n1 - Halo only\n2 - Overlay only\n3 - Halo + Overlay\nDefault is 2")
	panel:NumSlider("Spot overlay visiblity", "CODPerksSitRepStencilVisibility", 0, 2, 0)
	panel:Help("When should the SitRep perk Overlay highlight be visible.\n0 - Only when obstructed\n1 - Only when unobstructed\n2 - Always\nDefault is 0")

	panel:NumSlider("Pulsar Spotting style", "CODPerksPulsarSpotStyle", 0, 3, 0)
	panel:Help("Select the style of the Pulsar perk spotting highlight.\n0 - None\n1 - Halo only\n2 - Overlay only\n3 - Halo + Overlay\nDefault is 2")
	panel:NumSlider("Spot overlay visiblity", "CODPerksPulsarStencilVisibility", 0, 2, 0)
	panel:Help("When should the Pulsar perk Overlay highlight be visible.\n0 - Only when obstructed\n1 - Only when unobstructed\n2 - Always\nDefault is 2")

	panel:NumSlider("Death Perception Spotting style", "CODPerksDeathPerSpotStyle", 0, 3, 0)
	panel:Help("Select the style of the Death Perception perk spotting highlight.\n0 - None\n1 - Halo only\n2 - Overlay only\n3 - Halo + Overlay\nDefault is 2")
	panel:NumSlider("Spot overlay visiblity", "CODPerksDeathPerStencilVisibility", 0, 2, 0)
	panel:Help("When should the Death Perception perk Overlay highlight be visible.\n0 - Only when obstructed\n1 - Only when unobstructed\n2 - Always\nDefault is 0")

	panel:NumSlider("Vulture Aid Spotting style", "CODPerksVultureAidSpotStyle", 0, 3, 0)
	panel:Help("Select the style of the Vulture Aid perk spotting highlight.\n0 - None\n1 - Halo only\n2 - Overlay only\n3 - Halo + Overlay\nDefault is 3")
	panel:NumSlider("Spot overlay visiblity", "CODPerksVultureAidStencilVisibility", 0, 2, 0)
	panel:Help("When should the Vulture Aid perk Overlay highlight be visible.\n0 - Only when obstructed\n1 - Only when unobstructed\n2 - Always\nDefault is 0\n")

end)

end)