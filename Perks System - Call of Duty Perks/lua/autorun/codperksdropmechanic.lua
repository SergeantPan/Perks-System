PerkTable = {"Armorer", "Assassin", "Blast Shield", "Blind Eye", "Cold Blooded", "Commando", "Danger Close", "Dead Silence", "Engineer", "Executioner", "Hacker", "Hardened", "High Alert", "Juggernaut", "Lightweight", "Marathon", "Marksman", "Martyrdom", "Mobility", "Ninja", "Pulsar", "Quick-Fix", "Recon", "Scavenger", "Scrounger", "SitRep", "Stalker", "Stopping Power", "Survivalist", "Tactical Mask"}

function DropPerk(ent, perk)

if ent:IsPlayer() then
if perk == 1 && ent:GetNWString("Tier 1 Perk", "None") != "None" then
	DroppedPerk = string.Replace(ent:GetNWString("Tier 1 Perk"), " ", "")
	DroppedItem = ents.Create("PerkPickup" .. DroppedPerk)
	DroppedItem:SetPos(ent:WorldSpaceCenter())
	DroppedItem:Spawn()
	if ent:Alive() then
		DroppedItem:GetPhysicsObject():SetVelocity(ent:GetForward() * 100)
	else
		DroppedItem:GetPhysicsObject():SetVelocity(Vector(math.Rand(-25,25),math.Rand(-25,25),45))
	end
	DroppedItem:SetNWInt("PickupDelay", CurTime() + 3)
	ent:SetNWString("Tier 1 Perk", "None")
end
if perk == 2 && ent:GetNWString("Tier 2 Perk", "None") != "None" then
	DroppedPerk = string.Replace(ent:GetNWString("Tier 2 Perk"), " ", "")
	DroppedItem = ents.Create("PerkPickup" .. DroppedPerk)
	DroppedItem:SetPos(ent:WorldSpaceCenter())
	DroppedItem:Spawn()
	if ent:Alive() then
		DroppedItem:GetPhysicsObject():SetVelocity(ent:GetForward() * 100)
	else
		DroppedItem:GetPhysicsObject():SetVelocity(Vector(math.Rand(-25,25),math.Rand(-25,25),45))
	end
	DroppedItem:SetNWInt("PickupDelay", CurTime() + 3)
	ent:SetNWString("Tier 2 Perk", "None")
end
if perk == 3 && ent:GetNWString("Tier 3 Perk", "None") != "None" then
	DroppedPerk = string.Replace(ent:GetNWString("Tier 3 Perk"), " ", "")
	DroppedItem = ents.Create("PerkPickup" .. DroppedPerk)
	DroppedItem:SetPos(ent:WorldSpaceCenter())
	DroppedItem:Spawn()
	if ent:Alive() then
		DroppedItem:GetPhysicsObject():SetVelocity(ent:GetForward() * 100)
	else
		DroppedItem:GetPhysicsObject():SetVelocity(Vector(math.Rand(-25,25),math.Rand(-25,25),45))
	end
	DroppedItem:SetNWInt("PickupDelay", CurTime() + 3)
	ent:SetNWString("Tier 3 Perk", "None")
end

if ent:GetNWString("Tier 1 Perk", "None") == "None" and ent:GetNWString("Tier 2 Perk", "None") == "None" and ent:GetNWString("Tier 3 Perk", "None") == "None" then
	timer.Simple(0.01, function() ent:SetNWInt("DropPerkMenu", 0) end)
end
end

if ent:IsNPC() or ent:GetClass() == "item_item_crate" then
	if game.SinglePlayer() then
		DupeTable = {}
		table.CopyFromTo(PerkTable, DupeTable)
		table.RemoveByValue(DupeTable, Entity(1):GetNWString("Tier 1 Perk", "None"))
		table.RemoveByValue(DupeTable, Entity(1):GetNWString("Tier 2 Perk", "None"))
		table.RemoveByValue(DupeTable, Entity(1):GetNWString("Tier 3 Perk", "None"))
		DroppedItem = ents.Create("PerkPickup" .. string.Replace(DupeTable[math.random(1, #DupeTable)], " ", ""))
	else
		DroppedItem = ents.Create("PerkPickup" .. string.Replace(PerkTable[math.random(1, #PerkTable)], " ", ""))
	end
	DroppedItem:SetPos(ent:WorldSpaceCenter())
	DroppedItem:Spawn()
	DroppedItem:GetPhysicsObject():SetVelocity(Vector(math.Rand(-25,25),math.Rand(-25,25),25))
	Rand = math.random(1, 100)
	if util.IsValidModel("models/nirrti/tablet/tab_02.mdl") and Rand <= 15 then
		DroppedItem:SetModel("models/nirrti/tablet/tab_02.mdl")
		DroppedItem:SetSkin(3)
	end
end
end

// Prevent weapon switching when using perk drop menu
hook.Add("PlayerSwitchWeapon", "PerkMenuPreventSwitch", function(ply)
if ply:GetNWInt("DropPerkMenu", 0) == 1 then
	return true
end
end)

hook.Add("PlayerButtonDown", "DropPerkMenuOpen", function(ply, button)

if button == GetConVar("CODPerksDropPerk"):GetInt() then
if ply:GetNWInt("DropPerkMenu", 0) == 0 then
	ply:SetNWInt("DropPerkMenu", 1)
else
	ply:SetNWInt("DropPerkMenu", 0)
end
end

end)

hook.Add("PlayerButtonDown", "PerkMenuPress", function(ply, button)

if ply:GetNWInt("DropPerkMenu", 0) == 1 then
if button == 2 then
	DropPerk(ply, 1)
	ply:StopSound("player/suit_denydevice.wav")
end
if button == 3 then
	DropPerk(ply, 2)
	ply:StopSound("player/suit_denydevice.wav")
end
if button == 4 then
	DropPerk(ply, 3)
	ply:StopSound("player/suit_denydevice.wav")
end
end

end)

hook.Add("OnNPCKilled", "CodPerksNPCPerkDrop", function(npc, attacker)

CombineNPC = {"npc_combine_s", "npc_metropolice", "npc_zombine"}
ZombieNPC = {"npc_fastzombie", "npc_fastzombie_torso", "npc_poisonzombie", "npc_zombie", "npc_zombie_torso"} 

if GetConVar("CODPerksNPCDropPerks"):GetBool() and !npc:IsNextBot() then

if (table.HasValue(CombineNPC, npc:GetClass()) and GetConVar("CODPerksNPCDropPerksCombine"):GetBool()) or (table.HasValue(ZombieNPC, npc:GetClass()) and GetConVar("CODPerksNPCDropPerksZombies"):GetBool()) or (npc:GetClass() == "npc_hunter" and GetConVar("CODPerksNPCDropPerksHunter"):GetBool()) then
	Rand = math.random(1, 100)
	Chance = GetConVar("CODPerksNPCDropPerksChance"):GetInt()
if npc:GetClass() == "npc_hunter" then
	Chance = GetConVar("CODPerksNPCDropPerksChance"):GetInt() + 10
end
if table.HasValue(ZombieNPC, npc:GetClass()) and npc:GetClass() != "npc_poisonzombie" then
	Chance = math.Clamp(GetConVar("CODPerksNPCDropPerksChance"):GetInt() - 5, 1, 100)
end
if Rand <= Chance then
	DropPerk(npc, 0)
end
end

end

end)

hook.Add("DoPlayerDeath", "CodPerksPlayerPerkDrop", function(ply) 

if GetConVar("CODPerksDropOnDeath"):GetBool() then

if ply:GetNWString("Tier 1 Perk", "None") != "None" then
	DropPerk(ply, 1)
if GetConVar("CODPerksRemoveOnDeath"):GetBool() then
	ply:SetNWString("Tier 1 Perk", "None")
end
end
if ply:GetNWString("Tier 2 Perk", "None") != "None" then
	DropPerk(ply, 2)
if GetConVar("CODPerksRemoveOnDeath"):GetBool() then
	ply:SetNWString("Tier 2 Perk", "None")
end
end
if ply:GetNWString("Tier 3 Perk", "None") != "None" then
	DropPerk(ply, 3)
if GetConVar("CODPerksRemoveOnDeath"):GetBool() then
	ply:SetNWString("Tier 3 Perk", "None")
end
end

end

end)

hook.Add("PropBreak", "CodPerksItemCratePerkDrop", function(att,prop)

Rand = math.random(1, 100)

if IsValid(prop) and prop:GetClass() == "item_item_crate" and Rand <= GetConVar("CODPerksCrateDropPerksChance"):GetInt() then
	DropPerk(prop, 0)
end

end)

if CLIENT then

CODAlphaClr3 = 0
RectAlpha = 0
TextAlpha = 0
Tier1 = 0
Tier2 = 0
Tier3 = 0
TargetName = ""

hook.Add("HUDPaint", "CODDropPerkHud", function()

surface.SetFont("InteractFont")
Target = LocalPlayer():GetEyeTrace().Entity

if input.LookupBinding("use") == nil then
	UseKey = "UNBOUND"
else
	UseKey = string.upper(input.LookupBinding("use"))
end

if IsValid(Target) then

TargetRemoved = string.Replace(Target:GetClass(), "perkpickup", "")
TargetName = string.upper(string.sub(TargetRemoved, 1, 1)) .. string.sub(TargetRemoved, 2)

if TargetRemoved == "blastshield" then
	TargetName = "Blast Shield"
end
if TargetRemoved == "blindeye" then
	TargetName = "Blind Eye"
end
if TargetRemoved == "coldblooded" then
	TargetName = "Cold Blooded"
end
if TargetRemoved == "dangerclose" then
	TargetName = "Danger Close"
end
if TargetRemoved == "deadsilence" then
	TargetName = "Dead Silence"
end
if TargetRemoved == "highalert" then
	TargetName = "High Alert"
end
if TargetRemoved == "stoppingpower" then
	TargetName = "Stopping Power"
end
if TargetRemoved == "tacticalmask" then
	TargetName = "Tactical Mask"
end
end

if LocalPlayer():Alive() and IsValid(Target) and table.HasValue(PerkTable, TargetName) and LocalPlayer():GetPos():Distance(Target:GetPos()) < 80 then
	Output = "Press " .. UseKey .. " to pickup the " .. TargetName .. " perk"
	surface.SetDrawColor(5, 5, 5, 225)
	width, height = surface.GetTextSize(Output)
	surface.DrawRect((ScrW() * 0.495) - (width / 2), (ScrH() * 0.563) - (height / 2), surface.GetTextSize(Output) + 20, 35)
	draw.DrawText(Output, Text, ScrW() * 0.5, ScrH() * 0.55, Color(255, 255, 255), TEXT_ALIGN_CENTER)
end

if LocalPlayer():GetNWString("Tier 1 Perk", "None") != "None" then
	Tier1 = 1
else
	Tier1 = 0
end
if LocalPlayer():GetNWString("Tier 2 Perk", "None") != "None" then
	Tier2 = 1
else
	Tier2 = 0
end
if LocalPlayer():GetNWString("Tier 3 Perk", "None") != "None" then
	Tier3 = 1
else
	Tier3 = 0
end

if (Tier1 == 0 and Tier2 == 0 and Tier3 == 0 and LocalPlayer():GetNWInt("DropPerkMenu", 0) != 0) or !LocalPlayer():Alive() then
	LocalPlayer():SetNWInt("DropPerkMenu", 0)
end

if isnumber(GetConVar("CODPerksDropPerk"):GetInt()) and GetConVar("CODPerksDropPerk"):GetInt() > 0 and GetConVar("CODPerksDropPerk"):GetInt() <= 171 then
	BindKey = string.upper(input.GetKeyName(GetConVar("CODPerksDropPerk"):GetInt()))
else
	BindKey = "UNBOUND"
end

if LocalPlayer():GetNWInt("DropPerkMenu", 0) == 0 and CODAlphaClr3 != 0 then
	CODAlphaClr3 = 0
	RectAlpha = 0
	TextAlpha = 0
end

local width, height = surface.GetTextSize("Sample text")

if LocalPlayer():Alive() and LocalPlayer():GetNWInt("DropPerkMenu", 0) == 1 then
if TextAlpha != 255 or CODAlphaClr3 != 225 then
	TextAlpha = math.Clamp(TextAlpha + 3, 0, 255)
	CODAlphaClr3 = math.Clamp(CODAlphaClr3 + 3, 0, 225)
end
	RectAlpha = 35 + (height * (Tier1 + Tier2 + Tier3))

if GetConVar("CODPerksVerticalHorizontal"):GetBool() then
	HortPos = ScrW() * GetConVar("CODPerksXPos"):GetFloat() - 5
	VertPos = ScrH() * GetConVar("CODPerksYPos"):GetFloat() - 135 + (125 - RectAlpha)
else
	HortPos = ScrW() * GetConVar("CODPerksXPos"):GetFloat() + 85
	VertPos = ScrH() * GetConVar("CODPerksYPos"):GetFloat() - 105 + (125 - RectAlpha)
end

	surface.SetDrawColor(5, 5, 5, CODAlphaClr3)
	surface.DrawRect(HortPos, VertPos, 275, RectAlpha)
	if LocalPlayer():GetNWString("Tier 1 Perk", "None") != "None" then
		draw.DrawText("1 - Drop " .. LocalPlayer():GetNWString("Tier 1 Perk"), Text, HortPos + 5, VertPos, Color(255, 255, 255, TextAlpha))
	end
	if LocalPlayer():GetNWString("Tier 2 Perk", "None") != "None" then
		draw.DrawText("2 - Drop " .. LocalPlayer():GetNWString("Tier 2 Perk"), Text, HortPos + 5, VertPos + (30 * Tier1), Color(255, 255, 255, TextAlpha))
	end
	if LocalPlayer():GetNWString("Tier 3 Perk", "None") != "None" then
		draw.DrawText("3 - Drop " .. LocalPlayer():GetNWString("Tier 3 Perk"), Text, HortPos + 5, VertPos + (30 * Tier1) + (30 * Tier2), Color(255, 255, 255, TextAlpha))
	end
	draw.DrawText(BindKey .. " - Cancel", Text, HortPos + 5, VertPos + (30 * Tier1) + (30 * Tier2) + (30 * Tier3), Color(255, 255, 255, TextAlpha))
end

end)

end
