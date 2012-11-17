AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	-- Boiler plate
	self.Entity:SetModel( "models/props_c17/furnitureStove001a.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	--
	local slots_taken = 0
end

function ENT:Use( activator, caller )
	return
end

function ENT:RemoveSlots()
	
end

function ENT:Think()
	local x = ents.FindInSphere(self:GetPos(), 1024)
	for k, v in pairs(x)
		if v.PowerUsage > 0 and not v.Powered then
			v:Power(self)
