if not sql.TableExists( "Basewars13" ) then
	sql.Query( "CREATE TABLE IF NOT EXISTS Basewars13 (SteamID TEXT, Money REAL);" )
end

function PlayerExists( SteamID )
	local SqlString = "SELECT Money FROM Basewars13 WHERE SteamID=%s"
	if sql.Query(string.format(sqlString, sql.SQLStr(SteamID))) == nil then
		return False
	else
		return True
	end
end

function CreatePlayer( SteamID )
	local SqlString = "INSERT INTO Basewars13 (SteamID, Money) VALUES (%s, 0);"
	sql.Query(string.format(SqlString, sql.SQLStr(SteamID)))
end

function UpdatePlayer( SteamID, Money )
	local SqlString = "UPDATE Basewars13 SET Money=%s WHERE SteamID=%s;"
	sql.Query(string.format(SqlString, Money, sql.SQLStr(SteamID)))
end

function GetPlayer( SteamID )
	local SqlString = "SELECT Money FROM Basewars13 WHERE SteamID=%s;"
	return sql.Query(string.format(SqlString, sql.SQLStr(SteamID)))[1]['Money']
end