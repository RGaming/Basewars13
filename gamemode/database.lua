if not sql.TableExists( "Basewars13" )
	sql.Query( "CREATE TABLE IF NOT EXISTS Basewars13 (Money TEXT, SteamID TEXT)" )
end

