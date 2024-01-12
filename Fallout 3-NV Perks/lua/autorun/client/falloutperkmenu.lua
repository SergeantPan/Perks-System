local MenuSet = 0
local FalloutStrangerHP = GetConVar("FalloutStrangerHPLimit"):GetInt()

function PlyHasPerk(p, perk)
local FindPerk = string.find(p:GetNWString("Fallout Perk"), perk)

if FindPerk != nil then
	return true
else
	return false
end
end

hook.Add("Think", "FalloutMenuThink", function()

if GetConVar("FalloutCharacterGender"):GetInt() == 1 and MenuSet != 1 then
	MenuSet = 1
	Perk1Image = "Lady_Killer.png"
	Perk1Text = "Lady Killer"
	Perk2Image = "Confirmedbachelor.png"
	Perk2Text = "Confirmed bachelor"
elseif GetConVar("FalloutCharacterGender"):GetInt() == 2 and MenuSet != 2 then
	MenuSet = 2
	Perk1Image = "CherchezLaFemme.png"
	Perk1Text = "Cherchez La Femme"
	Perk2Image = "Black_Widow.png"
	Perk2Text = "Black Widow"
end

end)

hook.Add( "PopulateToolMenu", "FalloutPerks", function()

	spawnmenu.AddToolMenuOption( "Options", "Player Perks", "FalloutPerksMenu", "Fallout 3/NV Perks", "", "", function( panel )
	panel:ClearControls()

local PerkImage1 = vgui.Create("DImageButton", panel)
PerkImage1:SetPos(13, 70)
PerkImage1:SetSize(90,90)
PerkImage1:SetImage(Perk1Image)
PerkImage1:SetToolTip(Perk1Text .. "\n- Deal +10% DMG vs Female characters.")
local Checkmark1 = vgui.Create("DImage", panel)
	Checkmark1:SetPos(13, 70)
if PlyHasPerk(LocalPlayer(), "01 ") == true then
	Checkmark1:SetSize(90, 90)
else
	Checkmark1:SetSize(0, 0)
end
	Checkmark1:SetImage("Check.png")
PerkImage1.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("01 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "01 ") == true then
	Checkmark1:SetSize(0, 0)
else
	Checkmark1:SetSize(90, 90)
end
end

local PerkImage2 = vgui.Create("DImageButton", panel)
PerkImage2:SetPos(108, 70)
PerkImage2:SetSize(90,90)
PerkImage2:SetImage(Perk2Image)
PerkImage2:SetToolTip(Perk2Text .. "\n- Deal +10% DMG vs Male characters.")
local Checkmark2 = vgui.Create("DImage", panel)
	Checkmark2:SetPos(108, 70)
if PlyHasPerk(LocalPlayer(), "02 ") == true then
	Checkmark2:SetSize(90, 90)
else
	Checkmark2:SetSize(0, 0)
end
	Checkmark2:SetImage("Check.png")
PerkImage2.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("02 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "02 ") == true then
	Checkmark2:SetSize(0, 0)
else
	Checkmark2:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 70)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Little_Leaguer.png")
PerkImage:SetToolTip("Little Leaguer\n- Deal +15% Melee and Explosive DMG.")
local Checkmark3 = vgui.Create("DImage", panel)
	Checkmark3:SetPos(204, 70)
if PlyHasPerk(LocalPlayer(), "03 ") == true then
	Checkmark3:SetSize(90, 90)
else
	Checkmark3:SetSize(0, 0)
end
	Checkmark3:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("03 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "03 ") == true then
	Checkmark3:SetSize(0, 0)
else
	Checkmark3:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 170)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Entomologist.png")
PerkImage:SetToolTip("Entomologist\n- Deal +50% DMG vs Antlions.")
local Checkmark4 = vgui.Create("DImage", panel)
	Checkmark4:SetPos(13, 170)
if PlyHasPerk(LocalPlayer(), "03 ") == true then
	Checkmark4:SetSize(90, 90)
else
	Checkmark4:SetSize(0, 0)
end
	Checkmark4:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("04 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "04 ") == true then
	Checkmark4:SetSize(0, 0)
else
	Checkmark4:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 170)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Iron_Fist.png")
PerkImage:SetToolTip("Iron Fist\n- Deal +15% DMG with unarmed attacks.")
local Checkmark5 = vgui.Create("DImage", panel)
	Checkmark5:SetPos(108, 170)
if PlyHasPerk(LocalPlayer(), "05 ") == true then
	Checkmark5:SetSize(90, 90)
else
	Checkmark5:SetSize(0, 0)
end
	Checkmark5:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("05 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "05 ") == true then
	Checkmark5:SetSize(0, 0)
else
	Checkmark5:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 170)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Toughness.png")
PerkImage:SetToolTip("Toughness\n- Gain +10% DMG resistance.")
local Checkmark6 = vgui.Create("DImage", panel)
	Checkmark6:SetPos(204, 170)
if PlyHasPerk(LocalPlayer(), "06 ") == true then
	Checkmark6:SetSize(90, 90)
else
	Checkmark6:SetSize(0, 0)
end
	Checkmark6:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("06 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "06 ") == true then
	Checkmark6:SetSize(0, 0)
else
	Checkmark6:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 270)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Demolition_Expert.png")
PerkImage:SetToolTip("Demolition Expert\n- Deal +20% DMG with explosives.")
local Checkmark7 = vgui.Create("DImage", panel)
	Checkmark7:SetPos(13, 270)
if PlyHasPerk(LocalPlayer(), "07 ") == true then
	Checkmark7:SetSize(90, 90)
else
	Checkmark7:SetSize(0, 0)
end
	Checkmark7:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("07 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "07 ") == true then
	Checkmark7:SetSize(0, 0)
else
	Checkmark7:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 270)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Rad_Resistance.png")
PerkImage:SetToolTip("Rad Resistance\n- +25% Radiation Resistance.")
local Checkmark8 = vgui.Create("DImage", panel)
	Checkmark8:SetPos(108, 270)
if PlyHasPerk(LocalPlayer(), "08 ") == true then
	Checkmark8:SetSize(90, 90)
else
	Checkmark8:SetSize(0, 0)
end
	Checkmark8:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("08 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "08 ") == true then
	Checkmark8:SetSize(0, 0)
else
	Checkmark8:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 270)
PerkImage:SetSize(90,90)
PerkImage:SetImage("AnimalFriend.png")
PerkImage:SetToolTip("Animal Friend\n- Hostile animals (Antlions) become neutral to you.")
local Checkmark9 = vgui.Create("DImage", panel)
	Checkmark9:SetPos(204, 270)
if PlyHasPerk(LocalPlayer(), "09 ") == true then
	Checkmark9:SetSize(90, 90)
else
	Checkmark9:SetSize(0, 0)
end
	Checkmark9:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("09 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "09 ") == true then
	Checkmark9:SetSize(0, 0)
else
	Checkmark9:SetSize(90, 90)
end
end

local PerkImage3 = vgui.Create("DImageButton", panel)
PerkImage3:SetPos(13, 370)
PerkImage3:SetSize(90,90)
PerkImage3:SetImage("Mysterious_Stranger.png")
PerkImage3:SetToolTip("Mysterious Stranger\n- When attacking an enemy that has " .. FalloutStrangerHP .. " or less HP, there is a 10% chance for the Mysterious Stranger to appear and finish off the enemy.")
local Checkmark10 = vgui.Create("DImage", panel)
	Checkmark10:SetPos(13, 370)
if PlyHasPerk(LocalPlayer(), "10 ") == true then
	Checkmark10:SetSize(90, 90)
else
	Checkmark10:SetSize(0, 0)
end
	Checkmark10:SetImage("Check.png")
PerkImage3.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("10 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "10 ") == true then
	Checkmark10:SetSize(0, 0)
else
	Checkmark10:SetSize(90, 90)
end
end

local Button = vgui.Create("DButton", panel)
Button:SetText("Update Perk Icons/Text")
Button:SetPos(2, 30)
Button:SetSize(300, 30)
Button.DoClick = function()
PerkImage1:SetImage(Perk1Image)
PerkImage1:SetToolTip(Perk1Text .. "\n- Deal +10% DMG vs Female characters.")
PerkImage2:SetImage(Perk2Image)
PerkImage2:SetToolTip(Perk2Text .. "\n- Deal +10% DMG vs Male characters.")
PerkImage3:SetToolTip("Mysterious Stranger\n- When attacking an enemy that has " .. FalloutStrangerHP .. " or less HP, there is a 10% chance for the Mysterious Stranger to appear and finish off the enemy.")
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 370)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Nerd_Rage.png")
PerkImage:SetToolTip("Nerd Rage!\n- Gain +50% DMG Resistance and +25% Unarmed DMG when health drops below 20%.")
local Checkmark11 = vgui.Create("DImage", panel)
	Checkmark11:SetPos(108, 370)
if PlyHasPerk(LocalPlayer(), "11 ") == true then
	Checkmark11:SetSize(90, 90)
else
	Checkmark11:SetSize(0, 0)
end
	Checkmark11:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("11 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "11 ") == true then
	Checkmark11:SetSize(0, 0)
else
	Checkmark11:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 370)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Pyromaniac.png")
PerkImage:SetToolTip("Pyromaniac\n- Deal +50% more Fire DMG.")
local Checkmark12 = vgui.Create("DImage", panel)
	Checkmark12:SetPos(204, 370)
if PlyHasPerk(LocalPlayer(), "12 ") == true then
	Checkmark12:SetSize(90, 90)
else
	Checkmark12:SetSize(0, 0)
end
	Checkmark12:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("12 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "12 ") == true then
	Checkmark12:SetSize(0, 0)
else
	Checkmark12:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 470)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Cannibal.png")
PerkImage:SetToolTip("Cannibal\n- Gain the ability to devour human corpses for 25 HP.\n- Crouch and interact with a corpse to devour it.\n- If a Friendly NPC witnesses you devouring a corpse, they turn hostile. Important NPCs are unaffected.")
local Checkmark13 = vgui.Create("DImage", panel)
	Checkmark13:SetPos(13, 470)
if PlyHasPerk(LocalPlayer(), "13 ") == true then
	Checkmark13:SetSize(90, 90)
else
	Checkmark13:SetSize(0, 0)
end
	Checkmark13:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("13 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "13 ") == true then
	Checkmark13:SetSize(0, 0)
else
	Checkmark13:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 470)
PerkImage:SetSize(90,90)
PerkImage:SetImage("LifeGiver.png")
PerkImage:SetToolTip("Life Giver\n- Gain +30 Max Health.")
local Checkmark14 = vgui.Create("DImage", panel)
	Checkmark14:SetPos(108, 470)
if PlyHasPerk(LocalPlayer(), "14 ") == true then
	Checkmark14:SetSize(90, 90)
else
	Checkmark14:SetSize(0, 0)
end
	Checkmark14:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("14 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "14 ") == true then
	Checkmark14:SetSize(0, 0)
else
	Checkmark14:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 470)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Robotics_Expert.png")
PerkImage:SetToolTip("Robotics Expert\n- Deal +25% DMG vs Manhacks, Scanners and robotic enemies.\n- Gain the ability to disable turrets by crouching and interacting from behind them.")
local Checkmark15 = vgui.Create("DImage", panel)
	Checkmark15:SetPos(204, 470)
if PlyHasPerk(LocalPlayer(), "15 ") == true then
	Checkmark15:SetSize(90, 90)
else
	Checkmark15:SetSize(0, 0)
end
	Checkmark15:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("15 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "15 ") == true then
	Checkmark15:SetSize(0, 0)
else
	Checkmark15:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 570)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Fast_Metabolism.png")
PerkImage:SetToolTip("Fast Metabolism\n- Gain +20% more Health from Health Kits and Vials.")
local Checkmark16 = vgui.Create("DImage", panel)
	Checkmark16:SetPos(13, 570)
if PlyHasPerk(LocalPlayer(), "16 ") == true then
	Checkmark16:SetSize(90, 90)
else
	Checkmark16:SetSize(0, 0)
end
	Checkmark16:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("16 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "16 ") == true then
	Checkmark16:SetSize(0, 0)
else
	Checkmark16:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 570)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Cyborg.png")
PerkImage:SetToolTip("Cyborg\n- Gain +10% Resistance to DMG, Poison and Radiation\n- Deal +10% more DMG with energy weapons.")
local Checkmark17 = vgui.Create("DImage", panel)
	Checkmark17:SetPos(108, 570)
if PlyHasPerk(LocalPlayer(), "17 ") == true then
	Checkmark17:SetSize(90, 90)
else
	Checkmark17:SetSize(0, 0)
end
	Checkmark17:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("17 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "17 ") == true then
	Checkmark17:SetSize(0, 0)
else
	Checkmark17:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 570)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Adamantium_Skeleton.png")
PerkImage:SetToolTip("Adamantium Skeleton\n- Damage to the limbs is reduced by 50%. Does not affect fall damage.")
local Checkmark18 = vgui.Create("DImage", panel)
	Checkmark18:SetPos(204, 570)
if PlyHasPerk(LocalPlayer(), "18 ") == true then
	Checkmark18:SetSize(90, 90)
else
	Checkmark18:SetSize(0, 0)
end
	Checkmark18:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("18 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "18 ") == true then
	Checkmark18:SetSize(0, 0)
else
	Checkmark18:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 670)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Ferocious_Loyalty.png")
PerkImage:SetToolTip("Ferocious Loyalty\n- When your health drops below 50%, NPCs following you gain +50% DMG Resistance.")
local Checkmark19 = vgui.Create("DImage", panel)
	Checkmark19:SetPos(13, 670)
if PlyHasPerk(LocalPlayer(), "19 ") == true then
	Checkmark19:SetSize(90, 90)
else
	Checkmark19:SetSize(0, 0)
end
	Checkmark19:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("19 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "19 ") == true then
	Checkmark19:SetSize(0, 0)
else
	Checkmark19:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 670)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Cowboy.png")
PerkImage:SetToolTip("Cowboy\n- Deal +25% DMG with Shotguns, Revolvers and knives.")
local Checkmark20 = vgui.Create("DImage", panel)
	Checkmark20:SetPos(108, 670)
if PlyHasPerk(LocalPlayer(), "20 ") == true then
	Checkmark20:SetSize(90, 90)
else
	Checkmark20:SetSize(0, 0)
end
	Checkmark20:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("20 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "20 ") == true then
	Checkmark20:SetSize(0, 0)
else
	Checkmark20:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 670)
PerkImage:SetSize(90,90)
PerkImage:SetImage("LivingAnatomy.png")
PerkImage:SetToolTip("Living Anatomy\n- See the Health and Damage Resistance of any target. Deal +5% DMG vs Combine and Human targets.")
local Checkmark21 = vgui.Create("DImage", panel)
	Checkmark21:SetPos(204, 670)
if PlyHasPerk(LocalPlayer(), "21 ") == true then
	Checkmark21:SetSize(90, 90)
else
	Checkmark21:SetSize(0, 0)
end
	Checkmark21:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("21 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "21 ") == true then
	Checkmark21:SetSize(0, 0)
else
	Checkmark21:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 770)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Stonewall.png")
PerkImage:SetToolTip("Stonewall\n- +5% DMG Resistance vs Melee Attacks.")
local Checkmark22 = vgui.Create("DImage", panel)
	Checkmark22:SetPos(13, 770)
if PlyHasPerk(LocalPlayer(), "22 ") == true then
	Checkmark22:SetSize(90, 90)
else
	Checkmark22:SetSize(0, 0)
end
	Checkmark22:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("22 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "22 ") == true then
	Checkmark22:SetSize(0, 0)
else
	Checkmark22:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 770)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Ghastly_Scavenger.png")
PerkImage:SetToolTip("Ghastly Scavenger\n- Gain the ability to devour Zombie, Vortigaunt and Antlion Guard corpses for 50 HP. Requires the Cannibal perk\n- Crouch and interact with a corpse to devour it.\n- If a Friendly NPC witnesses you devouring a body, they turn hostile. Important NPCs are unaffected.")
local Checkmark23 = vgui.Create("DImage", panel)
	Checkmark23:SetPos(108, 770)
if PlyHasPerk(LocalPlayer(), "23 ") == true then
	Checkmark23:SetSize(90, 90)
else
	Checkmark23:SetSize(0, 0)
end
	Checkmark23:SetImage("Check.png")
PerkImage.DoClick = function()
if PlyHasPerk(LocalPlayer(), "13 ") == true then
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("23 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "23 ") == true then
	Checkmark23:SetSize(0, 0)
else
	Checkmark23:SetSize(90, 90)
end
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 770)
PerkImage:SetSize(90,90)
PerkImage:SetImage("HitTheDeck.png")
PerkImage:SetToolTip("Hit the Deck\n- +25% DMG Resistance vs Explosives.")
local Checkmark24 = vgui.Create("DImage", panel)
	Checkmark24:SetPos(204, 770)
if PlyHasPerk(LocalPlayer(), "24 ") == true then
	Checkmark24:SetSize(90, 90)
else
	Checkmark24:SetSize(0, 0)
end
	Checkmark24:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("24 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "24 ") == true then
	Checkmark24:SetSize(0, 0)
else
	Checkmark24:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 870)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Purifier.png")
PerkImage:SetToolTip("Purifier\n- Deal +50% Melee and Unarmed DMG vs Antlions, Zombies and Headcrabs.")
local Checkmark25 = vgui.Create("DImage", panel)
	Checkmark25:SetPos(13, 870)
if PlyHasPerk(LocalPlayer(), "25 ") == true then
	Checkmark25:SetSize(90, 90)
else
	Checkmark25:SetSize(0, 0)
end
	Checkmark25:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("25 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "25 ") == true then
	Checkmark25:SetSize(0, 0)
else
	Checkmark25:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 870)
PerkImage:SetSize(90,90)
PerkImage:SetImage("SprayPray.png")
PerkImage:SetToolTip("Spray and Pray\n- Deal 75% less DMG vs NPCs in your squad.")
local Checkmark26 = vgui.Create("DImage", panel)
	Checkmark26:SetPos(108, 870)
if PlyHasPerk(LocalPlayer(), "26 ") == true then
	Checkmark26:SetSize(90, 90)
else
	Checkmark26:SetSize(0, 0)
end
	Checkmark26:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("26 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "26 ") == true then
	Checkmark26:SetSize(0, 0)
else
	Checkmark26:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 870)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Grunt.png")
PerkImage:SetToolTip("Grunt\n- Deal +25% DMG with Melee, Pistols, SMGs, Rifles, Snipers, Grenades and Rockets.")
local Checkmark27 = vgui.Create("DImage", panel)
	Checkmark27:SetPos(204, 870)
if PlyHasPerk(LocalPlayer(), "27 ") == true then
	Checkmark27:SetSize(90, 90)
else
	Checkmark27:SetSize(0, 0)
end
	Checkmark27:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("27 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "27 ") == true then
	Checkmark27:SetSize(0, 0)
else
	Checkmark27:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 970)
PerkImage:SetSize(90,90)
PerkImage:SetImage("TribalWisdom.png")
PerkImage:SetToolTip("Tribal Wisdom\n- Take 50% less damage from Antlions and Headcrabs\n- Gain +25% Poison Resistance\n- Gain the ability to consume Antlions, birds and Headcrabs for 12 HP.\n- Crouch and interact with a corpse to devour it.")
local Checkmark28 = vgui.Create("DImage", panel)
	Checkmark28:SetPos(13, 970)
if PlyHasPerk(LocalPlayer(), "28 ") == true then
	Checkmark28:SetSize(90, 90)
else
	Checkmark28:SetSize(0, 0)
end
	Checkmark28:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("28 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "28 ") == true then
	Checkmark28:SetSize(0, 0)
else
	Checkmark28:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(108, 970)
PerkImage:SetSize(90,90)
PerkImage:SetImage("ShotgunSurgeon.png")
PerkImage:SetToolTip("Shotgun Surgeon\n- Damage dealt by shotguns ignores up to 10 points of Damage Resistance.")
local Checkmark29 = vgui.Create("DImage", panel)
	Checkmark29:SetPos(108, 970)
if PlyHasPerk(LocalPlayer(), "29 ") == true then
	Checkmark29:SetSize(90, 90)
else
	Checkmark29:SetSize(0, 0)
end
	Checkmark29:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("29 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "29 ") == true then
	Checkmark29:SetSize(0, 0)
else
	Checkmark29:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(204, 970)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Scrounger.png")
PerkImage:SetToolTip("Scrounger\n- When picking up ammo, there is a 75% chance to pick up more ammo.")
local Checkmark30 = vgui.Create("DImage", panel)
	Checkmark30:SetPos(204, 970)
if PlyHasPerk(LocalPlayer(), "30 ") == true then
	Checkmark30:SetSize(90, 90)
else
	Checkmark30:SetSize(0, 0)
end
	Checkmark30:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("30 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "30 ") == true then
	Checkmark30:SetSize(0, 0)
else
	Checkmark30:SetSize(90, 90)
end
end

local PerkImage = vgui.Create("DImageButton", panel)
PerkImage:SetPos(13, 1070)
PerkImage:SetSize(90,90)
PerkImage:SetImage("Piercing_Strike.png")
PerkImage:SetToolTip("Piercing Strike\n- When unarmed or using melee weapons, ignore up to 15 points of Damage Resistance.")
local Checkmark31 = vgui.Create("DImage", panel)
	Checkmark31:SetPos(13, 1070)
if PlyHasPerk(LocalPlayer(), "31 ") == true then
	Checkmark31:SetSize(90, 90)
else
	Checkmark31:SetSize(0, 0)
end
	Checkmark31:SetImage("Check.png")
PerkImage.DoClick = function()
net.Start("FalloutPerk")
net.WriteEntity(LocalPlayer())
net.WriteString("31 ")
net.SendToServer()
if PlyHasPerk(LocalPlayer(), "31 ") == true then
	Checkmark31:SetSize(0, 0)
else
	Checkmark31:SetSize(90, 90)
end
end

end)
end)