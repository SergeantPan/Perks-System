hook.Add( "PopulateToolMenu", "DivisionTalents", function()

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "MedicalTalents", "Division Medical Talents", "", "", function( panel )
	panel:ClearControls()

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("adrenaline.png")
PerkImage:SetToolTip("Adrenaline\n- While at full health, picking up a medical kit will overheal you.\n- Overheal lasts 30 seconds.\n- Overheal is capped at 40 health.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Adrenaline")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("Shock and Awe.png")
PerkImage:SetToolTip("Shock And Awe\n- Damaging the same enemy 4 times in a row grants a 10% speed boost for 10 seconds.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Shock And Awe")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("critical save.png")
PerkImage:SetToolTip("Critical Save\n- Use a medkit while below 30% HP to gain 40% damage resistance for 10 seconds.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Critical Save")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("combat medic.png")
PerkImage:SetToolTip("Combat Medic\n- Using a medkit heals nearby allies.\n- 20 meter radius\n- Allies gain 40% of healing done.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Combat Medic")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("battle buddy.png")
PerkImage:SetToolTip("Battle Buddy\n- Revive a downed teammate to grant 50% damage resistance for you and your  teammate for 10 seconds.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Battle Buddy")
net.SendToServer()
end

end)

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "TechTalents", "Division Tech Talents", "", "", function( panel )
	panel:ClearControls()

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("wildfire.png")
PerkImage:SetToolTip("Wildfire\n- Dealing incendiary damage to an enemy has a 30% chance to deal additional incendiary damage to enemies in a 10 meter radius.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Wildfire")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("demolition expert.png")
PerkImage:SetToolTip("Demolition Expert\n- Killing an enemy with an explosion increases explosive damage by 20% for 15 seconds.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Demolition Expert")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("fear tactics.png")
PerkImage:SetToolTip("Fear Tactics\n- Dealing shock damage to an enemy has a 30% chance to deal additional shock damage to enemeis in a 10 meter radius.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Fear Tactics")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("chemical spill.png")
PerkImage:SetToolTip("Chemical Spill\n- Dealing acid damage to an enemy has a 30% chance to deal additional acid damage to enemeis in a 10 meter radius.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Chemical Spill")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("evasive action.png")
PerkImage:SetToolTip("Evasive Action\n- Sprinting grants 30% damage resistance.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Evasive Action")
net.SendToServer()
end

end)

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "SecuTalents", "Division Security Talents", "", "", function( panel )
	panel:ClearControls()

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("precision.png")
PerkImage:SetToolTip("Precision\n- Headshotting an enemy highlights them for 10 seconds.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Precision")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("repo reaper.png")
PerkImage:SetToolTip("Repo Reaper\n- Killing an enemy with a sidearm restores 30 ammo for primary weapons.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Repo Reaper")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 50)
PerkImage:SetSize(80,80)
PerkImage:SetImage("on the move.png")
PerkImage:SetToolTip("On The Move\n- Killing an enemy while moving grants 30% damage reduction for 10 seconds.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("On The Move")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(15, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("chain reaction.png")
PerkImage:SetToolTip("Chain Reaction\n- Damaging multiple enemies with an explosive increases the damage dealt by 20%")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Chain Reaction")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(100, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("stopping power.png")
PerkImage:SetToolTip("Stopping Power\n- Damaging the same enemy 4 times in a row increases headshot damage on that target by 25% for 10 seconds.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("Stopping Power")
net.SendToServer()
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(185, 150)
PerkImage:SetSize(80,80)
PerkImage:SetImage("one is none.png")
PerkImage:SetToolTip("One Is None\n- Headshotting an enemy has a 50% chance of not consuming ammo.")
PerkImage.DoClick = function()
net.Start("NewTalent")
net.WriteEntity(LocalPlayer())
net.WriteString("One Is None")
net.SendToServer()
end

end)
end)