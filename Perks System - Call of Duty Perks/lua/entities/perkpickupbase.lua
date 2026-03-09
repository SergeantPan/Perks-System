AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.PrintName = "Perk Pickup Base"
ENT.Category = "CoD Perks"
ENT.Spawnable = false

ENT.Perk = "None"
ENT.Tier = "Tier 0 Perk"
ENT.WorldIcon = "None"
ENT.IconW = 8
ENT.IconH = 8

function ENT:Initialize()
	if util.IsValidModel("models/nirrti/tablet/tablet.mdl") then
		self:SetModel("models/nirrti/tablet/tablet.mdl")
		self:SetSkin(2)
	else
		self:SetModel("models/Items/BoxSRounds.mdl")
		self:SetModelScale(0.5)
	end
	self:SetCollisionGroup(2)
    if SERVER then
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
	self:PhysWake()
	self:SetTrigger(true)
    end
end

function ENT:Draw()
	self:DrawModel()
	pos = self:WorldSpaceCenter() + Vector(0,0,8)

	if LocalPlayer():GetPos():Distance(self:WorldSpaceCenter()) <= GetConVar("CODPerksPickupIconDist"):GetInt() then
	cam.Start3D()
		render.SetMaterial(self.WorldIcon)
		render.DrawSprite(pos, self.IconW, self.IconH, color_white)
	cam.End3D()
	end
end

function ENT:Use(ply)
	if ply:IsPlayer() and ply:Alive() then
		if ply:GetNWString(self.Tier, "None") != "None" then
			EntName = string.Replace(ply:GetNWString(self.Tier), " ", "")
			Ent = ents.Create("PerkPickup" .. EntName)
			Ent:SetPos(ply:WorldSpaceCenter())
			Ent:Spawn()
			Ent:GetPhysicsObject():AddVelocity(ply:GetForward() * 100)
		end
		ply:SetNWString(self.Tier, self.Perk)
		self:Remove()
		ply:EmitSound("items/battery_pickup.wav")
	end
end

function ENT:Touch(ply)
	if ply:IsPlayer() and ply:Alive() and GetConVar("CODPerksAutoPickup"):GetBool() then
	if ply:GetNWString(self.Tier, "None") == "None" and CurTime() >= self:GetNWInt("PickupDelay", 0) then
		self:Use(ply)
	end
	end
end

function ENT:OnTakeDamage(dmginfo)
	if dmginfo:GetDamage() >= 5 and self:GetModel() == "models/nirrti/tablet/tablet.mdl" then
		self:SetModel("models/nirrti/tablet/tab_02.mdl")
		self:SetSkin(3)
	end
end