AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

--Nick's new and improved Power Plant
--Network functions are for casuals, we'll be 
--using nothing but clever loop logic today! 

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
	--PoweredEntities is actually totally unsafe, there is no reliable way to find out what
	--entities a Power Plant is powering. That said, PoweredEntities is a pretty good guess
	self.PoweredEntities = {}
	timer.Create(self:EntIndex().."TakePay", self.Delay, 0, function() self:TakePay() end)
end

function ENT:Use( activator, caller )
	return
end


function ENT:TakePay(  )
	RemoveMoney(self.Owner, self.UseCost)
end

function ENT:OnRemove()
	timer.Destroy(self:EntIndex().."TakePay")
	for key, value in pairs(self.PoweredEntities) do
		value:UnPower()
	end
end

function ENT:Think()
	self.Entity:NextThink(CurTime()+1)

	--Invalidate entities that don't exist and count up the empty slots
	--We don't use SlotsUsed directly to avoid inaccurate values while we count
	local EmptySlots = 0
	for i=1, self.PowerSlots, 1 do
		if not IsValid(self.PoweredEntities[i]) then
			self.PoweredEntities[i] = nil
			EmptySlots = EmptySlots + 1
		end
	end
	self.SlotsUsed = self.PowerSlots - EmptySlots

	--Move existing entities to the end of the PoweredEntities table
	--Also, validate entity position while we're at it
	local TempTable = {}
	i=self.PowerSlots
	for key, value in pairs(self.PoweredEntities) do
		if value:GetPos():Distance(self:GetPos())<=self.PowerDist then
			TempTable[i] = value
			i = i - 1
		else
			value:UnPower()
			--It's OK to alter SlotsUsed here because it's an accurate count
			self.SlotsUsed = self.SlotsUsed - 1
		end

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
	for key, value in pairs(self.PoweredEntities) do
		value:Power()
	end
end