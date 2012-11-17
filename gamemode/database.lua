if not sql.TableExists( "Basewars13" ) then
	sql.Query( "CREATE TABLE IF NOT EXISTS Basewars13 (SteamID TEXT, Money REAL);" )
end

--Fucking clusterfuck of a function
function PlayerExists( SteamID )
	SqlString = "SELECT EXISTS(SELECT 1 FROM Basewars13 WHERE SteamID=%s);"
	for key, value in pairs(sql.Query(string.format(SqlString, sql.SQLStr(SteamID)))[1]) do
		if value == 1 then
			exists = true
		end
	end
	if exists then
		return true
	else
		return false
	end
end

function CreatePlayer( SteamID )
	SqlString = "INSERT INTO Basewars13 (SteamID, Money) VALUES (%s, 0);"
	sql.Query(string.format(SqlString, sql.SQLStr(SteamID)))
end

function UpdatePlayer( SteamID, Money )
	SqlString = "UPDATE Basewars13 SET Money=%s WHERE SteamID=%s;"
	sql.Query(string.format(SqlString, Money, sql.SQLStr(SteamID)))
end

function GetPlayer( SteamID )
	SqlString = "SELECT Money FROM Basewars13 WHERE SteamID=%s;"
	return sql.Query(string.format(SqlString, sql.SQLStr(SteamID)))[1]['Money']
end