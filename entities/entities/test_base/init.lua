AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

-- function ENT:SetupDataTables()
-- 	self:NetworkVar( "Float", 0, "Amount" );
-- 	self:NetworkVar( "String", 1, "Buyer");
-- end

function ENT:Initialize()
	self:SetAmount(self.MaxHealth)
	self:SetBuyer(self.Buyer)
end

function ENT:OnTakeDamage(dmg)
	local damage = dmg:GetDamage()
	local currenthealth = self:GetAmount()
	if currenthealth - damage < 0 then
		DropMoney(self:GetPos(), math.floor(self.Price / 2))
		self:Remove()
	else
		self:SetAmount(currenthealth - damage)
	end	
end