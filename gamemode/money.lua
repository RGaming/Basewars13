function GM:PlayerInitialSpawn( ply ) --So when peopel spawn they don't have 0 money
    ply:SetNWInt( "Money", 5000 )
end

--Boilerplate shit
function AddMoney( ply, amount ) 
	ply:SetNWInt("Money", ply:GetNWInt("Money", 5000) + amount)
end

function SetMoney( ply, amount )
	ply:SetNWInt("Money", amount)
end

function RemoveMoney( ply, amount )
	ply:SetNWInt("Money", ply:GetNWInt("Money", 5000) - amount)
end