CreateConVar("FalloutDefaultPerks", "", 128, "Default Perks that the player will spawn with. It's best not to manually alter this.")
CreateConVar("FalloutAutoSavePerks", 1, 128, "Automatically save the current Perks as the ones that the player will spawn with by default.")

concommand.Add("FalloutSavePerks", function(ply)

GetConVar("FalloutDefaultPerks"):SetString(ply:GetNWString("Fallout Perk", ""))

end)

hook.Add( "Think", "FalloutAutosavePerks", function()

if GetConVar("FalloutAutoSavePerks"):GetBool() and GetConVar("FalloutDefaultPerks"):GetString() != LocalPlayer():GetNWString("Fallout Perk") then
	GetConVar("FalloutDefaultPerks"):SetString(LocalPlayer():GetNWString("Fallout Perk", ""))
end

end)

hook.Add( "PopulateToolMenu", "FalloutSpawnSettings", function()

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "FalloutFirstSpawnMenu", "Fallout Spawn", "", "", function( panel )
	panel:ClearControls()

	panel:Button("Save current perks as default", "FalloutSavePerks")
	panel:CheckBox( "Autosave current Perks", "FalloutAutoSavePerks" )
	panel:Help( "Automatically save the currently selected perks as the default to be used.")

end)
end)

hook.Add("InitPostEntity", "FalloutFirstSpawn", function()

CurNum = ""

if GetConVar("FalloutDefaultPerks"):GetString() != "" then
for _,num in ipairs(string.ToTable(GetConVar("FalloutDefaultPerks"):GetString())) do

if num != " " then
if CurNum == "" then
	CurNum = num
else
	CurNum = CurNum .. num
end
else
if num == " " then
	CurNum = CurNum .. num
end
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString(CurNum)
net.SendToServer()
CurNum = ""
end

end
end

end)