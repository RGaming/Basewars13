function buy_entity( ply, cmd, args )
	local entity = ents.Create(args[1])
	local tr = ply:GetEyeTrace()
	if CanAfford(ply, entity.Price) then
		RemoveMoney(ply, entity.Price)
		entity:SetPos(tr.HitPos)
		entity:Spawn()
		entity.Owner = ply
	else
		entity:Remove()
	end
end

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
concommand.Add("buy_entity", buy_entity)
concommand.Add("drop_money", drop_money)