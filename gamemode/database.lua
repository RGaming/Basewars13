if not sql.TableExists( "Basewars13" )
	sql.Query( "CREATE TABLE IF NOT EXISTS Basewars13 (SteamID TEXT, Money REAL);" )
end

function PlayerExists( SteamID )
	SqlString = "SELECT EXISTS(SELECT 1 FROM Basewars13 WHERE SteamID=%s);"
	if sql.Query(string.format(SqlString, sql.SQLStr(SteamID))) then
		return true
	else
		return false
end

function CreatePlayer( SteamID )
	SqlString = "INSERT INTO Basewars13(SteamID, Money) VALUES (%s, 0);"
	sql.Query(string.format(SqlString, sql.SQLStr(SteamID)))
end

function UpdatePlayer( SteamID, Money )
	SqlString = "UPDATE Basewars13 SET Money=%s WHERE SteamID=%s;"
	sql.Query(string.format(SqlString, Money, sql.SQLStr(SteamID)))
end

function GetPlayer( SteamID )
	SqlString = "SELECT Money FROM Basewars13 WHERE SteamID=%s;"
	return sql.Query(string.format(SqlString, sql.SQLStr(SteamID)))
end