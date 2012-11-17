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

	--Move entities to the end of the PoweredEntities table
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
			if value.PowerUsage != nil and self.SlotsUsed + value.PowerUsage <= self.PowerSlots then
				for j=1, value.PowerUsage, 1 do
					self.PoweredEntities[i] = value
					self.SlotsUsed = self.SlotsUsed + 1
					i = i + 1
				end
			else
				--print("Broke")
				break
			end
		end
		--print("Broke II return of the broke")
	end

	--Power the entities in the PoweredEntities table
	print(self.PoweredEntities)
	PrintTable(self.PoweredEntities)
	for key, value in pairs(self.PoweredEntities) do
		print("Raep time")
		print(value)
		value:Power()
	end
end

-- function ENT:Think()
-- 	local x = ents.FindInSphere(self:GetPos(), 1024) -- List of entities nearby
-- 	for k, v in pairs(x) do
-- 		if v.PowerUsage > 0 and not v.Powered then
-- 			v:Power(self)
-- 		end
-- 	end
-- end
