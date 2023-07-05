CreateConVar("TalentsSlot1X", 0.1, 128, "Adjust the horizontal position of the slot 1 talent. Default is 0.1")
CreateConVar("TalentsSlot2X", 0.133, 128, "Adjust the horizontal position of the slot 2 talent. Default is 0.133")
CreateConVar("TalentsSlot3X", 0.166, 128, "Adjust the horizontal position of the slot 3 talent. Default is 0.166")
CreateConVar("TalentsSlot4X", 0.199, 128, "Adjust the horizontal position of the slot 4 talent. Default is 0.199")
CreateConVar("TalentsSlot1Y", 0.6, 128, "Adjust the vertical position of the slot 1 talent. Default is 0.6")
CreateConVar("TalentsSlot2Y", 0.6, 128, "Adjust the vertical position of the slot 2 talent. Default is 0.6")
CreateConVar("TalentsSlot3Y", 0.6, 128, "Adjust the vertical position of the slot 3 talent. Default is 0.6")
CreateConVar("TalentsSlot4Y", 0.6, 128, "Adjust the vertical position of the slot 4 talent. Default is 0.6")
CreateConVar("TalentsGap", 0, 128, "Adjust the gap between the icons. Default is 0")
CreateConVar("TalentsSize", 60, 128, "Adjust the size of the icons. Default is 60")

hook.Add("HUDPaint", "TheDivisionIcons", function()

local P = LocalPlayer()
local Slot1X = GetConVar("TalentsSlot1X"):GetFloat()
local Slot2X = GetConVar("TalentsSlot2X"):GetFloat()
local Slot3X = GetConVar("TalentsSlot3X"):GetFloat()
local Slot4X = GetConVar("TalentsSlot4X"):GetFloat()
local Slot1Y = GetConVar("TalentsSlot1Y"):GetFloat()
local Slot2Y = GetConVar("TalentsSlot2Y"):GetFloat()
local Slot3Y = GetConVar("TalentsSlot3Y"):GetFloat()
local Slot4Y = GetConVar("TalentsSlot4Y"):GetFloat()
local TalentGap = GetConVar("TalentsGap"):GetFloat()
local Size = GetConVar("TalentsSize"):GetInt()

if P:GetNWString("Slot 1 Talent", "None") != "None" then
	surface.SetMaterial(Material("materials/" .. P:GetNWString("Slot 1 Talent", "None") .. ".png"))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Slot1X, ScrH() * Slot1Y, Size, Size )
end
if P:GetNWString("Slot 2 Talent", "None") != "None" then
	surface.SetMaterial(Material("materials/" .. P:GetNWString("Slot 2 Talent", "None") .. ".png"))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Slot2X + TalentGap, ScrH() * Slot2Y, Size, Size )
end
if P:GetNWString("Slot 3 Talent", "None") != "None" then
	surface.SetMaterial(Material("materials/" .. P:GetNWString("Slot 3 Talent", "None") .. ".png"))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Slot3X + (TalentGap * 2), ScrH() * Slot3Y, Size, Size )
end
if P:GetNWString("Slot 4 Talent", "None") != "None" then
	surface.SetMaterial(Material("materials/" .. P:GetNWString("Slot 4 Talent", "None") .. ".png"))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Slot4X + (TalentGap * 3), ScrH() * Slot4Y, Size, Size )
end

Text = "InteractFont"
P = LocalPlayer()
Target = P:GetEyeTrace().Entity

if (P:GetNWString("Slot 1 Talent", "None") == "Adrenaline" or P:GetNWString("Slot 2 Talent", "None") == "Adrenaline" or P:GetNWString("Slot 3 Talent", "None") == "Adrenaline" or P:GetNWString("Slot 4 Talent", "None") == "Adrenaline") then

if P:GetNWString("Slot 1 Talent") == "Adrenaline" then
	AdrPos1 = ScrW() * Slot1X
	AdrPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Adrenaline" then
	AdrPos1 = ScrW() * Slot2X + TalentGap
	AdrPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Adrenaline" then
	AdrPos1 = ScrW() * Slot3X + (TalentGap * 2)
	AdrPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Adrenaline" then
	AdrPos1 = ScrW() * Slot4X + (TalentGap * 3)
	AdrPos2 = Slot4Y
end

if IsValid(Target) and (Target:GetClass() == "item_healthkit" or Target:GetClass() == "item_healthvial") and Target:GetPos():Distance(P:GetPos()) <= 90 and P:Health() == P:GetMaxHealth() then
	draw.DrawText("Hold " .. string.upper(input.LookupBinding("+use")) .. " To Overheal", Text, ScrW() * 0.445, ScrH() * 0.53)
end
if P:GetNWInt("Overheal", 0) > CurTime() then
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(AdrPos1, ScrH() * AdrPos2, Size, (Size / 30) * (P:GetNWInt("Overheal", 0) - CurTime()))
end
end

if (P:GetNWString("Slot 1 Talent", "None") == "Shock And Awe" or P:GetNWString("Slot 2 Talent", "None") == "Shock And Awe" or P:GetNWString("Slot 3 Talent", "None") == "Shock And Awe" or P:GetNWString("Slot 4 Talent", "None") == "Shock And Awe") and P:GetNWInt("SaWSpeed", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "Shock And Awe" then
	SaWPos1 = ScrW() * Slot1X
	SaWPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Shock And Awe" then
	SaWPos1 = ScrW() * Slot2X + TalentGap
	SaWPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Shock And Awe" then
	SaWPos1 = ScrW() * Slot3X + (TalentGap * 2)
	SaWPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Shock And Awe" then
	SaWPos1 = ScrW() * Slot4X + (TalentGap * 3)
	SaWPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(SaWPos1, ScrH() * SaWPos2, Size, (Size / 10) * (P:GetNWInt("SaWSpeed", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Critical Save" or P:GetNWString("Slot 2 Talent", "None") == "Critical Save" or P:GetNWString("Slot 3 Talent", "None") == "Critical Save" or P:GetNWString("Slot 4 Talent", "None") == "Critical Save" and P:GetNWInt("CTSDmgRes", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "Critical Save" then
	CTSPos1 = ScrW() * Slot1X
	CTSPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Critical Save" then
	CTSPos1 = ScrW() * Slot2X + TalentGap
	CTSPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Critical Save" then
	CTSPos1 = ScrW() * Slot3X + (TalentGap * 2)
	CTSPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Critical Save" then
	CTSPos1 = ScrW() * Slot4X + (TalentGap * 3)
	CTSPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(CTSPos1, ScrH() * CTSPos2, Size, (Size / 10) * (P:GetNWInt("CTSDmgRes", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Combat Medic" or P:GetNWString("Slot 2 Talent", "None") == "Combat Medic" or P:GetNWString("Slot 3 Talent", "None") == "Combat Medic" or P:GetNWString("Slot 4 Talent", "None") == "Combat Medic" and P:GetNWInt("ProxyDel", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "Combat Medic" then
	CMDPos1 = ScrW() * Slot1X
	CMDPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Combat Medic" then
	CMDPos1 = ScrW() * Slot2X + TalentGap
	CMDPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Combat Medic" then
	CMDPos1 = ScrW() * Slot3X + (TalentGap * 2)
	CMDPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Combat Medic" then
	CMDPos1 = ScrW() * Slot4X + (TalentGap * 3)
	CMDPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(CMDPos1, ScrH() * CMDPos2, Size, (Size / 3) * (P:GetNWInt("ProxyDel", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Battle Buddy" or P:GetNWString("Slot 2 Talent", "None") == "Battle Buddy" or P:GetNWString("Slot 3 Talent", "None") == "Battle Buddy" or P:GetNWString("Slot 4 Talent", "None") == "Battle Buddy" and P:GetNWInt("BBDmgRes", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "Battle Buddy" then
	BBPos1 = ScrW() * Slot1X
	BBPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Battle Buddy" then
	BBPos1 = ScrW() * Slot2X + TalentGap
	BBPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Battle Buddy" then
	BBPos1 = ScrW() * Slot3X + (TalentGap * 2)
	BBPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Battle Buddy" then
	BBPos1 = ScrW() * Slot4X + (TalentGap * 3)
	BBPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(BBPos1, ScrH() * BBPos2, Size, (Size / 10) * (P:GetNWInt("BBDmgRes", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") != "Battle Buddy" and P:GetNWString("Slot 2 Talent", "None") != "Battle Buddy" and P:GetNWString("Slot 3 Talent", "None") != "Battle Buddy" and P:GetNWString("Slot 4 Talent", "None") != "Battle Buddy" and P:GetNWInt("BBDmgRes", 0) > CurTime() then
	surface.SetMaterial(Material("materials/battle buddy.png"))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( ScrW() * Slot1X, ScrH() * BBPos2 - 0.05, Size, Size )
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(ScrW() * Slot1X, ScrH() * BBPos2 - 0.05, Size, (Size / 10) * (P:GetNWInt("BBDmgRes", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Evasive Action" or P:GetNWString("Slot 2 Talent", "None") == "Evasive Action" or P:GetNWString("Slot 3 Talent", "None") == "Evasive Action" or P:GetNWString("Slot 4 Talent", "None") == "Evasive Action" and P:GetNWInt("EADmgRes", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "Evasive Action" then
	EAPos1 = ScrW() * Slot1X
	EAPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Evasive Action" then
	EAPos1 = ScrW() * Slot2X + TalentGap
	EAPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Evasive Action" then
	EAPos1 = ScrW() * Slot3X + (TalentGap * 2)
	EAPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Evasive Action" then
	EAPos1 = ScrW() * Slot4X + (TalentGap * 3)
	EAPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(EAPos1, ScrH() * EAPos2, Size, (Size / 3) * (P:GetNWInt("EADmgRes", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 2 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 3 Talent", "None") == "Demolition Expert" or P:GetNWString("Slot 4 Talent", "None") == "Demolition Expert" and P:GetNWInt("DEDmgBns", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "Demolition Expert" then
	DEPos1 = ScrW() * Slot1X
	DEPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Demolition Expert" then
	DEPos1 = ScrW() * Slot2X + TalentGap
	DEPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Demolition Expert" then
	DEPos1 = ScrW() * Slot3X + (TalentGap * 2)
	DEPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Demolition Expert" then
	DEPos1 = ScrW() * Slot4X + (TalentGap * 3)
	DEPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(DEPos1, ScrH() * DEPos2, Size, (Size / 15) * (P:GetNWInt("DEDmgBns", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "On The Move" or P:GetNWString("Slot 2 Talent", "None") == "On The Move" or P:GetNWString("Slot 3 Talent", "None") == "On The Move" or P:GetNWString("Slot 4 Talent", "None") == "On The Move" and P:GetNWInt("OTMDmgRes", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "On The Move" then
	OTMPos1 = ScrW() * Slot1X
	OTMPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "On The Move" then
	OTMPos1 = ScrW() * Slot2X + TalentGap
	OTMPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "On The Move" then
	OTMPos1 = ScrW() * Slot3X + (TalentGap * 2)
	OTMPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "On The Move" then
	OTMPos1 = ScrW() * Slot4X + (TalentGap * 3)
	OTMPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(OTMPos1, ScrH() * OTMPos2, Size, (Size / 10) * (P:GetNWInt("OTMDmgRes", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Stopping Power" or P:GetNWString("Slot 2 Talent", "None") == "Stopping Power" or P:GetNWString("Slot 3 Talent", "None") == "Stopping Power" or P:GetNWString("Slot 4 Talent", "None") == "Stopping Power" and P:GetNWInt("SPBuffTrig", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "Stopping Power" then
	SPPos1 = ScrW() * Slot1X
	SPPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Stopping Power" then
	SPPos1 = ScrW() * Slot2X + TalentGap
	SPPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Stopping Power" then
	SPPos1 = ScrW() * Slot3X + (TalentGap * 2)
	SPPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Stopping Power" then
	SPPos1 = ScrW() * Slot4X + (TalentGap * 3)
	SPPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(SPPos1, ScrH() * SPPos2, Size, (Size / 10) * (P:GetNWInt("SPBuffTrig", 0) - CurTime()))
end

if P:IsPlayer() and P:GetNWString("Slot 1 Talent", "None") == "Chain Reaction" or P:GetNWString("Slot 2 Talent", "None") == "Chain Reaction" or P:GetNWString("Slot 3 Talent", "None") == "Chain Reaction" or P:GetNWString("Slot 4 Talent", "None") == "Chain Reaction" and P:GetNWInt("CrTrig", 0) > CurTime() then

if P:GetNWString("Slot 1 Talent") == "Chain Reaction" then
	CRPos1 = ScrW() * Slot1X
	CRPos2 = Slot1Y
elseif P:GetNWString("Slot 2 Talent") == "Chain Reaction" then
	CRPos1 = ScrW() * Slot2X + TalentGap
	CRPos2 = Slot2Y
elseif P:GetNWString("Slot 3 Talent") == "Chain Reaction" then
	CRPos1 = ScrW() * Slot3X + (TalentGap * 2)
	CRPos2 = Slot3Y
elseif P:GetNWString("Slot 4 Talent") == "Chain Reaction" then
	CRPos1 = ScrW() * Slot4X + (TalentGap * 3)
	CRPos2 = Slot4Y
end
	surface.SetDrawColor(255,255,255,55)
	surface.DrawRect(CRPos1, ScrH() * CRPos2, Size, (Size / 3) * (P:GetNWInt("CrTrig", 0) - CurTime()))
end

end)