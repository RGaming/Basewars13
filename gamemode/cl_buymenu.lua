local Panel = vgui.Create( "DFrame" )
Panel:Hide()
function buy_menu()
	Panel:Show()
	Panel:SetPos( 200, 200 )
	Panel:SetSize( 200, 200 )
	Panel:SetTitle( "Spawn Icon Test" )
	Panel:SetVisible( true )
	Panel:SetDraggable( false )
	Panel:ShowCloseButton( true )
	Panel:MakePopup()

	models = {'models/props_c17/furnitureStove001a.mdl','models/props_c17/consolebox01a.mdl','models/props_c17/FurnitureWashingmachine001a.mdl' }
	ent_names = {'basic_powerplant', 'money_printer_bronze', 'dispenser'}
	entities = {vgui.Create( "SpawnIcon" , Panel ), vgui.Create( "SpawnIcon" , Panel ), vgui.Create( "SpawnIcon" , Panel )}
	for i = 1, 3 do
		entities[i]:SetPos(15, -40 + 60 * i)
		entities[i]:SetModel(models[i])
		entities[i].DoClick = function ()
			RunConsoleCommand( "buy_entity", ent_names[i] )
		end
	end
end
concommand.Add("openbuymenu", buy_menu) 

local b = false;
hook.Add("Think", "keyboardevents", function()
    if input.IsKeyDown(KEY_F2) and (not b) then
       b = true;
       buy_menu()
    elseif (not input.IsKeyDown(KEY_F2)) and b then
        Panel:Hide()
        b = false;
    end
end)

