function buy_entity( ply, cmd, args )
	local entity = ents.Create(args[1])
	local tr = ply:GetEyeTrace()
	if CanAfford(ply, entity.Price) then
		RemoveMoney(ply, entity.Price)
		entity:SetPos(tr.HitPos + Vector(0,0,60))
		entity:Spawn()
		entity:SetBuyer(ply:Nick())
		entity:SetAmount(entity.MaxHealth)
	else
		entity:Remove()
	end
end
concommand.Add("buy_entity", buy_entity)

function drop_money( ply, cmd, args )
	local tr = ply:GetEyeTrace()
	if CanAfford(ply, args[1]) then -- and ply:GetPos():Distance(tr.HitPos) < 200 then
		RemoveMoney(ply, args[1])
		local cash = ents.Create( "cash" )
		cash:SetWorth(args[1])
		cash:SetPos(tr.HitPos)
		cash:Spawn()
	else
		if not CanAfford(ply,args[1]) then
			print("Not enough money")
		else
			print("Too far away")
		end
	end
end
concommand.Add("drop_money", drop_money)

function Collision_bounds( ply, cmd, args )
	local tr = ply:GetEyeTrace()
	if tr.Entity != nil then
		print(tr.Entity:GetCollisionBounds())
	end
end
concommand.Add("collison", Collision_bounds)