AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "Amount" );
	self:NetworkVar( "String", 1, "Buyer");
	self:NetworkVar( "Bool", 2, "Powered" );
end

function ENT:Initialize()
	-- Boiler plate
	self.Entity:SetModel( "models/props_lab/reciever01b.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetColor(self.PrintColor)
	self.Entity:SetMaterial( "models/debug/debugwhite" )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	timer.Create(self:EntIndex().."paytimer", self.Delay, 0, function () self:Payday() end)
	self.Powered = false
end

function ENT:Payday()
	if self.Powered then
		local pay = math.random(self.PayLow, self.PayHigh)
		local position = self.GetPos(self)
		DropMoney(position, pay)
	end
end

function ENT:Think(  )
end

function ENT:Use( activator, caller )
	--self:Payday()
	return
end

function ENT:OnRemove()
	timer.Destroy( self:EntIndex().."paytimer" )
end

function ENT:Power()
	self:SetPowered(true)
end

function ENT:UnPower()
	self:SetPowered(false)
end

function ENT:IsPowered()
	return self:GetPowered()
end
