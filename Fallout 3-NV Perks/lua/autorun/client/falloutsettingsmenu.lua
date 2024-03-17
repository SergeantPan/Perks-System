CreateClientConVar("FalloutPromptR", "255", true, false, "Red color value of the prompt", 0, 255)
CreateClientConVar("FalloutPromptG", "255", true, false, "Green color value of the prompt", 0, 255)
CreateClientConVar("FalloutPromptB", "255", true, false, "Blue color value of the prompt", 0, 255)

hook.Add( "PopulateToolMenu", "FalloutSettings", function()

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "FalloutSettingsMenu", "Fallout Settings", "", "", function( panel )
	panel:ClearControls()

	local Gender = panel:ComboBox("Character Gender", "FalloutCharacterGender")
	Gender:SetSortItems(false)
	Gender:AddChoice("Male", 1)
	Gender:AddChoice("Female", 2)
	panel:Help("Choose the Gender of your character. Used by the Lady Killer/Black Widow and Confirmed Bachelor/Cherchez La Femme perks.")

	panel:NumSlider("Mysterious Stranger HP", "FalloutStrangerHPLimit", 0, 100, 0)
	panel:Help("The maximum HP an NPC can have before the Mysterious Stranger can spawn.")

	panel:NumSlider("Cannibal React Chance", "FalloutCannibalReactChance", 0, 100, 0)
	panel:Help("The percentage chance for a nearby NPC to react to the player cannibalizing a corpse.")

	panel:NumSlider("Perk Limit", "FalloutMaxPerks", 0, 31, 0)
	panel:Help("The maximum number of perks a player can have.\n0 = No Limit.")

	panel:NumSlider("Prompt Horizontal Pos", "FalloutPromptX", 0, 1, 2)
	panel:Help("Adjust the horizontal position of the Interact prompt for the Cannibal and Robotics Expert perks. Default is 0.46.")
	panel:NumSlider("Prompt Vertical Pos", "FalloutPromptY", 0, 1, 2)
	panel:Help("Adjust the vertical position of the Interact prompt for the Cannibal and Robotics Expert perks. Default is 0.53.")

	panel:ColorPicker( "Prompt Color", "FalloutPromptR", "FalloutPromptG", "FalloutPromptB" )
	panel:Help('Change the color used by the "Hold USE to" prompt')

	panel:NumSlider("Health Horizontal Pos", "FalloutHealthX", 0, 1, 2)
	panel:Help("Adjust the horizontal position of the Health text for the Living Anatomy perk. Default is 0.48.")
	panel:NumSlider("Health Vertical Pos", "FalloutHealthY", 0, 1, 2)
	panel:Help("Adjust the vertical position of the Health text for the Living Anatomy perk. Default is 0.8.")

end)
end)