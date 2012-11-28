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
	self.Entity:SetModel( self.Model )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self:SetAmount(self.MaxHealth)
	--
end

function ENT:Use( activator, caller )
	if timer.Exists(self:EntIndex().."resup") then  --If we've already resupplied recently then end
	
	else
		timer.Create(self:EntIndex().."resup", 1, 1, function() Resupply(activator) end) --resupply every secound
	end
end

function Resupply( ply )
	weapon = ply:GetActiveWeapon()
	ply:SetHealth(math.Clamp( ply:Health() + 5, 0, 100 )) --Set health 5 more then it already is
	if weapon:Clip1() == 0 then
		ply:GiveAmmo(1, weapon:GetPrimaryAmmoType()) --If they have no ammo then give them 1
	end
	ply:GiveAmmo(weapon:Clip1() * 2, weapon:GetPrimaryAmmoType()) --Double their ammo
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
