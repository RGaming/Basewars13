AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	-- Boiler plate
	self.Entity:SetModel( "models/props_lab/reciever_cart.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	--
end

function ENT:Use( activator, caller )
	Heal(activator)
	Resupply(activator)
end

function Heal( ply )
	ply:SetHealth(math.Clamp( ply:Health() + 5, 0, 100 ))

end

function Resupply( ply )
	weapon = ply:GetActiveWeapon()
	ply:GiveAmmo(weapon:Clip1() * 2, weapon:GetPrimaryAmmoType())
end