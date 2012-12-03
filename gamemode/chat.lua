
ChatCommands = { }

function AddChatCommand(cmd, callback)
	table.insert(ChatCommands, {cmd = cmd, callback = callback});
end

hook.Add("PlayerSay", "ChatCommands", function ( ply, text, team )
	--Do stuff here when I get home
end)