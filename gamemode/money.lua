include("database.lua")
function GM:PlayerInitialSpawn( ply ) --So when peopel spawn they don't have 0 money
    local ID = ply:SteamID()
    if PlayerExists(ID) then
    	SetMoney(ply,GetPlayer(ID))
    else
    	CreatePlayer(ID)
    	SetMoney(ply, 5000)
    	UpdatePlayer(ID,GetMoney(ply))
    end
end

--Boilerplate shit
function GetMoney(ply)
	ply:GetNWInt("Money", 5000)
end

function CanAfford( ply, amount )
	if GetMoney(ply) < amount then
		return false
	else
		return true
	end
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
