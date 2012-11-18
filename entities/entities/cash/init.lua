AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	-- Boiler plate
	self.Entity:SetModel( "models/props_farm/padlock.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	--
end

function ENT:Think()
	entities = ents.FindInSphere(self:GetPos(), 10)	
	for k,v in pairs(entities) do
		if v.worth != nil && v:EntIndex() != self:EntIndex() then
			local ent = ents.Create("cash")
			ent:SetWorth(self:GetWorth() + v:GetWorth())
			ent:SetPos(self:GetPos())
			ent:Spawn()
			self:Remove()
			v:Remove()
		end
	end
end

function ENT:Use( activator, caller )
	AddMoney(activator, self.worth)
	self:Remove()
end

function ENT:SetWorth( worth )
	self.worth = worth
end

function ENT:GetWorth(  )
	return self.worth
end