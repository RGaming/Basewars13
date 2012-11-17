concommand.Add( "addmoney", function ( ply,args )
	for k,v in pairs(player.GetHuman())
		if v.Nick() == args[1]
			v:AddMoney(v, args[2])	
		end
	end
end)