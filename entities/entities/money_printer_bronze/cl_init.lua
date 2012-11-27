include('shared.lua')

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "Amount" );
	self:NetworkVar( "String", 1, "Buyer" );
	self:NetworkVar( "Bool", 2, "Powered" );
end

function ENT:Draw()
	self.Entity:DrawModel()
	self:DrawEntityOutline(1)
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
		
	owner = self:GetBuyer()
	txt1 = self.PrintName
	
	Ang:RotateAroundAxis(Ang:Up(), 90)

	local Health = self:GetAmount()

	surface.SetFont("DermaLarge")
	local TextWidth = surface.GetTextSize(txt1)
	local TextWidth2 = surface.GetTextSize(owner)
	local TextWidth3 = surface.GetTextSize(Health)
	local TextWidth4 = surface.GetTextSize("Powered")

	local poweredcolor = Color(0,0,0,255)
	if self:GetPowered() then 
		poweredcolor = Color(147,204,26,255)
	else
		poweredcolor = Color(176,28,46,255)
	end
	
	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
		draw.WordBox(2, 0 - TextWidth2 * .5, -100, owner, "DermaLarge", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, 0 - TextWidth * .5, -60, txt1, "DermaLarge", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, 0 - TextWidth3 * .5, 30, Health, "DermaLarge", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, 0 - TextWidth4 * .5, -20, "Powered", "DermaLarge", Color(0, 0, 0, 100), poweredcolor)
	cam.End3D2D()
end