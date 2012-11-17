AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "HUD.lua" )

include( "shared.lua" )
--include( "database.lua")

function GM:PlayerSpawn( ply )
      ply:SetGravity( 0.75 )
      ply:SetMaxHealth( 100, true )
      ply:SetRunSpeed( 400 )
      ply:SetWalkSpeed( 350 )
	  ply:Give( "weapon_physcannon" )
      ply:Give( "weapon_physgun" )
      ply:Give( "gmod_tool" )
end

function GM:PlayerInitialSpawn( ply )
    ply:SetNWInt( "Money", 5000 )
end