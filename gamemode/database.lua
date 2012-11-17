if not sql.TableExists( "Basewars13" )
	sql.Query( "CREATE TABLE IF NOT EXISTS Basewars13 (SteamID TEXT, Money REAL);" )
end

function PlayerExists( SteamID )
	SqlString = "SELECT EXISTS(SELECT 1 FROM Basewars13 WHERE SteamID = %s);"
	if sql.Query(string.format(SqlString, sql.SQLStr(SteamID))) then
		return true
	else
		return false
end

function CreatePlayer( SteamID )
	SqlString = "SELECT EXISTS(SELECT 1 FROM Basewars13 WHERE SteamID = %s);"
end