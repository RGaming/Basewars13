include('shared.lua')

function ENT:Initialize()
	local min,max = self:GetCollisionBounds()
	self.HealthRing = {self.MaxHealth, max.x * 20, 0}
end

function ENT:DrawEntityOutline(  )
	local whitetexture 	= surface.GetTextureID( "vgui/white" )

	local width = self.HealthRing[2]
	if width==nil then width = 1 end

	local eang = self.Entity:GetAngles()

	local rot = Vector(0, 90, 0)
	if self.HealthAxis then rot = Vector(90,90,0) end

	local offsetright = Vector(0,0,0)
	if self.HealthOffset!=nil then offsetright=self.Entity:GetAngles():Right()*self.HealthOffset end

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(eang:Right(),180)

	cam.Start3D2D(Pos + Ang:Up() * 3.5, Ang, 0.11)--pos, eang, 1)
		local health = 16*math.Round(22.5*(self.Entity:GetAmount()/self.HealthRing[1]))
		if health<=90 then
			surface.SetDrawColor(255,0,0,200)
		elseif health<=180 then
			surface.SetDrawColor(255,255,0,200)
		else
			surface.SetDrawColor(0,255,0,200)
		end
		local innerwidth = width*.5
		surface.SetTexture(whitetexture)
		for i=0,health,22.5 do
			local a = i-20.5
			local o = i-21.5
			local u = i-1
			local e = i-2

			local tbl = {}
			tbl[1]={}
			tbl[2]={}
			tbl[3]={}
			tbl[4]={}

			tbl[1]["x"]=math.sin(math.rad(u))*width
			tbl[1]["y"]=math.cos(math.rad(u))*width
			tbl[2]["x"]=math.sin(math.rad(e))*innerwidth
			tbl[2]["y"]=math.cos(math.rad(e))*innerwidth
			tbl[3]["x"]=math.sin(math.rad(a))*innerwidth
			tbl[3]["y"]=math.cos(math.rad(a))*innerwidth
			tbl[4]["x"]=math.sin(math.rad(o))*width
			tbl[4]["y"]=math.cos(math.rad(o))*width
			surface.DrawPoly(tbl)
		end
		local iwidth = width+1
		local xpos = 0
		local ypos = iwidth
		surface.SetDrawColor(0,200,200,200)
		for i=1,16,1 do
			local throwawayx = math.sin(math.rad(i*22.5))*iwidth
			local throwawayy = math.cos(math.rad(i*22.5))*iwidth
			surface.DrawLine(xpos,ypos, throwawayx,throwawayy)
			xpos=throwawayx
			ypos=throwawayy
		end
	cam.End3D2D()

end

function ENT:DrawInfo()
	Pos = self:GetPos()
	Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)

	local Owner = self:GetBuyer()
	local Name = self.PrintName
	local Health = self:GetAmount()
	local Powered = self:GetPowered()

	local PoweredColor = Color(0,0,0,255)
	if Powered then
		PoweredColor = Color(147,204,26,255)
	else
		PoweredColor = Color(176,28,46,255)
	end

	surface.SetFont( "DermaLarge" )
	local TextWidthOwner = surface.GetTextSize(Owner)
	local TextWidthName = surface.GetTextSize(Name)
	local TextWidthPowered = surface.GetTextSize("Powered")
	local TextWidthHealth = surface.GetTextSize(Health)

	cam.Start3D2D(Pos + Ang:Up() * 3.7, Ang, 0.11)
		draw.WordBox(2, 0 - TextWidthOwner * .5, -60, Owner, "DermaLarge", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, 0 - TextWidthName * .5, -20, Name, "DermaLarge", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, 0 - TextWidthPowered * .5, 20, "Powered", "DermaLarge", Color(0, 0, 0, 100), PoweredColor)
		draw.WordBox(2, 0 - TextWidthHealth * .5, 60, Health, "DermaLarge", Color(0, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()
end