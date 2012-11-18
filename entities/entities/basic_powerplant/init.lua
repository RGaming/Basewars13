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
	self.SlotsUsed = 0
	self.PoweredEntities = {}
end

function ENT:Use( activator, caller )
	return
end

function ENT:Think()
	self.Entity:NextThink(CurTime()+1)
	local EmptySlots = 0

	--Invalidate entities that don't exist and count up the empty slots
	for i=1, self.PowerSlots, 1 do
		if not IsValid(self.PoweredEntities[i]) then
			self.PoweredEntities[i] = nil
			EmptySlots = EmptySlots + 1
		end
	end
	self.SlotsUsed = self.PowerSlots - EmptySlots

	--Move existing entities to the end of the PoweredEntities table
	i=5
	TempTable = {}
	for key, value in pairs(self.PoweredEntities) do
		TempTable[i] = value
		i = i - 1
	end
	self.PoweredEntities = {}
	for key, value in pairs(TempTable) do
		self.PoweredEntities[key] = value
	end

	--Insert new entities into the PoweredEntities table
	if self.SlotsUsed < self.PowerSlots then
		i = 1
		local NewEntityList = ents.FindInSphere(self:GetPos(), self.PowerDist)
		for key, value in pairs(NewEntityList) do
			print(string.format("%s: %s", value, value.PowerUsage))
			if value.PowerUsage != nil and self.SlotsUsed + value.PowerUsage <= self.PowerSlots and not value:IsPowered() then
				for j=1, value.PowerUsage, 1 do
					self.PoweredEntities[i] = value
					self.SlotsUsed = self.SlotsUsed + 1
					i = i + 1
				end
			end
		end
	end

	--Power the entities in the PoweredEntities table
	PrintTable(self.PoweredEntities)
	for key, value in pairs(self.PoweredEntities) do
		value:Power()
	end
end