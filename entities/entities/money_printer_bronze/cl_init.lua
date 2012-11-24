include('shared.lua')

function ENT:Draw()
	self.Entity:DrawModel()
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
		
	owner = "Broken"
	txt1 = self.PrintName
	
	surface.SetFont("DermaLarge")
	local TextWidth = surface.GetTextSize(txt1)
	local TextWidth2 = surface.GetTextSize(owner)
	
	Ang:RotateAroundAxis(Ang:Up(), 90)
	
	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
		draw.WordBox(2, 0 - TextWidth2 * .5, -30, owner, "DermaLarge", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, 0 - TextWidth * .5, 18, txt1, "DermaLarge", Color(0, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()
end