AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "HUD.lua" )
AddCSLuaFile( "cl_buymenu.lua" )

include( "shared.lua" )
include("money.lua")
include("concommand.lua")
include( "database.lua")

function GM:PlayerInitialSpawn( ply )
	ply:ConCommand("say Binding!")
	ply:ConCommand( "Bind F2 menutest" )
end

function GM:PlayerSpawn( ply )
      ply:SetGravity( 0.75 )
      ply:SetMaxHealth( 100, true )
      ply:SetRunSpeed( 400 )
      ply:SetWalkSpeed( 350 )
	  ply:Give( "weapon_physcannon" )
      ply:Give( "weapon_physgun" )
      ply:Give( "gmod_tool" )
end