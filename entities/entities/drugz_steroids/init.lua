AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	-- Boiler plate
	self.Entity:SetModel( "models/props_lab/jar01a.mdl" )
	self.Entity:SetColor(150, 50, 50, 255)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	--
end

function ENT:Use( activator, caller )
	self:AddEffect()
	self:Remove()
end

function ENT:SetWorth( worth )
	self.worth = worth
end