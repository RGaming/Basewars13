include('shared.lua')
function ENT:Initialize()
	local matOutlineWhite 	= Material( "white_outline" )
	local ScaleOutline1		= 1.05
	local ScaleOutline2		= 2.1
	local matOutlineBlack 	= Material( "black_outline" )

	--First Outline
	self.OutLine1 = ClientsideModel(self:GetModel(), RENDERGROUP_OPAQUE)
	self.OutLine1:SetModelScale( ScaleOutline2, 0 )
	self.OutLine1:SetMaterial( matOutlineBlack )
	
	--Secound Outline
	-- self.OutLine2 = ClientsideModel(self:GetModel(), RENDERGROUP_OPAQUE)
	-- self.OutLine2:SetModelScale( ScaleOutline1, 0 )
	-- self.OutLine2:SetMaterial( matOutlineWhite )
end
function ENT:DrawEntityOutline( size )

	-- size = 1--size or 1.0
	-- render.SuppressEngineLighting( true )
	-- render.SetAmbientLight( 1, 1, 1 )
	-- render.SetColorModulation( 1, 1, 1 )

	-- -- First Outline	
	-- self:SetModelScale( ScaleOutline2 * size, 0 )
	-- self:SetMaterial( matOutlineBlack )
	-- self:DrawModel()

	-- -- Second Outline
	-- self:SetModelScale( ScaleOutline1 * size, 0 )
	-- self:SetMaterial(matOutlineWhite)
	-- self:DrawModel()

	-- -- Revert everything back to how it should be
	-- self:SetModelScale( ScaleNormal, 0 )
	-- self:DrawModel()
	self.OutLine1:SetPos(self:GetPos())
	-- self.OutLine2:SetPos(self:GetPos())
	--self.OutLine1:SetAngles(self:GetAngles())
	-- self.OutLine2:SetAngles(self:GetAngles())
end
-- 	render.SuppressEngineLighting( false )

-- 	local r, g, b = self:GetColor()
-- 	render.SetColorModulation( r/255, g/255, b/255 )


-- 	local width = self.HealthRing[2]
-- 	if width==nil then width = 1 end
-- 	local eang = self.Entity:GetAngles()
-- 	local rot = Vector(0, 90, 0)
-- 	if self.HealthAxis then rot = Vector(90,90,0) end
-- 	local offsetright = Vector(0,0,0)
-- 	if self.HealthOffset!=nil then offsetright=self.Entity:GetAngles():Right()*self.HealthOffset end
-- 	local pos = self.Entity:GetPos()+self.Entity:GetAngles():Up()*self.HealthRing[3]+offsetright
-- 	eang:RotateAroundAxis(eang:Right(), rot.x)
-- 	eang:RotateAroundAxis(eang:Up(), rot.y)
-- 	eang:RotateAroundAxis(eang:Forward(), rot.z)

-- 	cam.Start3D2D(pos, eang, 1)
-- 		local health = 16*math.Round(22.5*(self.Entity:GetAmount()/self.HealthRing[1]))
-- 		if health<=90 then
-- 			surface.SetDrawColor(255,0,0,200)
-- 		elseif health<=180 then
-- 			surface.SetDrawColor(255,255,0,200)
-- 		else
-- 			surface.SetDrawColor(0,255,0,200)
-- 		end
-- 		local innerwidth = width*.5
-- 		surface.SetTexture(whitetexture)
-- 		for i=0,health,22.5 do
-- 			local a = i-20.5
-- 			local o = i-21.5
-- 			local u = i-1
-- 			local e = i-2

-- 			local tbl = {}
-- 			tbl[1]={}
-- 			tbl[2]={}
-- 			tbl[3]={}
-- 			tbl[4]={}

-- 			tbl[1]["x"]=math.sin(math.rad(u))*width
-- 			tbl[1]["y"]=math.cos(math.rad(u))*width
-- 			tbl[2]["x"]=math.sin(math.rad(e))*innerwidth
-- 			tbl[2]["y"]=math.cos(math.rad(e))*innerwidth
-- 			tbl[3]["x"]=math.sin(math.rad(a))*innerwidth
-- 			tbl[3]["y"]=math.cos(math.rad(a))*innerwidth
-- 			tbl[4]["x"]=math.sin(math.rad(o))*width
-- 			tbl[4]["y"]=math.cos(math.rad(o))*width
-- 			surface.DrawPoly(tbl)
-- 		end
-- 		local iwidth = width+1
-- 		local xpos = 0
-- 		local ypos = iwidth
-- 		surface.SetDrawColor(0,200,200,200)
-- 		for i=1,16,1 do
-- 			local throwawayx = math.sin(math.rad(i*22.5))*iwidth
-- 			local throwawayy = math.cos(math.rad(i*22.5))*iwidth
-- 			surface.DrawLine(xpos,ypos, throwawayx,throwawayy)
-- 			xpos=throwawayx
-- 			ypos=throwawayy
-- 		end
-- 	cam.End3D2D()

-- end