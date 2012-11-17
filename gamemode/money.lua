include("database.lua")
function GM:PlayerInitialSpawn( ply ) --So when peopel spawn they don't have 0 money
    local ID = ply:SteamID()
    if not PlayerExists(ID)
    	CreatePlayer(ID)
    	SetMoney(ply, 5000)
    	UpdatePlayer(ID,GetMoney(ply))
    else

end

--Boilerplate shit
function GetMoney(ply)
	ply:GetNWInt("Money", 5000)
end

function AddMoney( ply, amount ) 
	ply:SetNWInt("Money", ply:GetNWInt("Money", 5000) + amount)
end

function SetMoney( ply, amount )
	ply:SetNWInt("Money", amount)
end

function RemoveMoney( ply, amount )
	ply:SetNWInt("Money", ply:GetNWInt("Money", 5000) - amount)
end
