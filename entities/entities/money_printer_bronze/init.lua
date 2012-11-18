AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	-- Boiler plate
	self.Entity:SetModel( "models/props_c17/consolebox01a.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	timer.Create(self:EntIndex().."paytimer", self.Delay, 0, function () self:Payday() end)
	self.Powered = false
end

function ENT:Payday()
	if self.Powered then
		local cash = ents.Create("cash")
		local pay = math.random(self.PayLow, self.PayHigh)
		cash:SetWorth(pay)
		position = self.GetPos(self)
		cash:SetPos(position)
		cash:Spawn()
	end
end

function ENT:Think(  )
	if self.Powered then
		self.Entity:SetColor(Color(0,255,0,255))
	else
		self.Entity:SetColor(Color(255,255,255,255))
	end
end

function ENT:Use( activator, caller )
	--self:Payday()
	return
end

function ENT:OnRemove()
	timer.Destroy( self:EntIndex().."paytimer" )
end

function ENT:Power()
	self.Powered = true
end

function ENT:UnPower()
	self.Powered = false
end

function ENT:IsPowered()
	return self.Powered
end