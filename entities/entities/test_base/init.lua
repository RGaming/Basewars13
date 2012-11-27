AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:OnTakeDamage(dmg)
	local damage = dmg:GetDamage()
	local currenthealth = self:GetAmount()
	if currenthealth - damage < 0 then
		print("Health less then zero dying")
		DropMoney(self:GetPos(), math.floor(self.Price / 2))
		self:Remove()
	else
		self:SetAmount(currenthealth - damage)
	end	
	print(Format("I just took %s points of damage, now my health is %s", damage, self:GetAmount()))

end