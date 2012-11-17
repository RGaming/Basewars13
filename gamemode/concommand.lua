function buyprint_bronze( ply )
	local printer = ents.Create("money_printer_bronze")
	if CanAfford(ply, printer.Price) then
		RemoveMoney(ply, printer.Price)
		position = ply:GetPos()
		printer:SetPos(position)
		printer:Spawn()
	else
		printer:Remove()
end
concommand.Add("buyprint_bronze", buyprint_bronze(ply))