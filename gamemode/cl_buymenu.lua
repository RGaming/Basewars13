function testpanel() -- Create the function
	DermaPanel = vgui.Create("DFrame") -- Create the frame
	DermaPanel:SetPos(50,50) -- set the frame's position on the screen
	DermaPanel:SetSize(300, 300) -- set the frame size
	DermaPanel:SetTitle( "Test" ) -- set the frame title
	DermaPanel:SetVisible( true ) -- Make the frame visible
	DermaPanel:MakePopup() -- make the frame popup

	local bronze_print = vgui.Create( "DButton" )
	bronze_print:SetParent( DermaPanel ) -- Set parent to our "DermaPanel"
	bronze_print:SetText( "Spawn Printer" )
	bronze_print:SetPos( 75, 50 )
	bronze_print:SetSize( 150, 50 )
	bronze_print.DoClick = function ()
    	RunConsoleCommand( "buy_entity", "money_printer_bronze" ) -- What happens when you press the button
	end

	local power_plant = vgui.Create( "DButton" )
	power_plant:SetParent( DermaPanel ) -- Set parent to our "DermaPanel"
	power_plant:SetText( "Spawn Power Plant" )
	power_plant:SetPos( 75, 150 )
	power_plant:SetSize( 150, 50 )
	power_plant.DoClick = function ()
    	RunConsoleCommand( "buy_entity", "basic_powerplant" ) -- What happens when you press the button
    end

end -- ending the frameunction
concommand.Add("menutest", testpanel) 