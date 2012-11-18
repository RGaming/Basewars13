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

function ENT:Use( activator, caller )
	Heal(activator)
	Resupply(activator)
end

function Heal( ply )
	ply:SetHealth(ply:Health() + 20)
end

function Resupply( ply )
	weapon = ply:GetActiveWeapon()
	ply:GiveAmmo(weapon:Clip1() * 2, weapon:GetPrimaryAmmoType())
end