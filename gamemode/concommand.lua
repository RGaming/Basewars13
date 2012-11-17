function buy_entity( ply, cmd, args )
	local entity = ents.Create(args[1])
	if CanAfford(ply, entity.Price) then
		RemoveMoney(ply, entity.Price)
		position = ply:GetPos()
		entity:SetPos(position)
		entity:Spawn()
	else
		entity:Remove()
	end
end
concommand.Add("buy_entity", buy_entity)