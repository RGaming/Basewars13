local Panel = vgui.Create( "DFrame" )
Panel:Hide()
-- function buy_menu()
-- 	Panel:Show()
-- 	Panel:SetPos( ScrW() / 2 - 100, ScrH() / 2 - 100)
-- 	Panel:SetSize( 200, 200 )
-- 	Panel:SetTitle( "Spawn Icon Test" )
-- 	Panel:SetVisible( true )
-- 	Panel:SetDraggable( false )
-- 	Panel:ShowCloseButton( true )
-- 	Panel:MakePopup()

-- 	models = {'models/props_c17/furnitureStove001a.mdl','models/props_c17/consolebox01a.mdl','models/props_lab/reciever_cart.mdl' }
-- 	ent_names = {'basic_powerplant', 'money_printer_bronze', 'dispenser'}
-- 	entities = {vgui.Create( "SpawnIcon" , Panel ), vgui.Create( "SpawnIcon" , Panel ), vgui.Create( "SpawnIcon" , Panel )}
-- 	for i = 1, 3 do
-- 		entities[i]:SetPos(15, -40 + 60 * i)
-- 		entities[i]:SetModel(models[i])
-- 		entities[i].DoClick = function ()
-- 			LocalPlayer():ConCommand("buy_entity "..ent_names[i])
-- 		end
-- 	end
-- end
-- concommand.Add("openbuymenu", buy_menu) 

-- local b = false;
-- hook.Add("Think", "keyboardevents", function()
--     if input.IsKeyDown(KEY_F2) and (not b) then
--        b = true;
--        buy_menu()
--     elseif (not input.IsKeyDown(KEY_F2)) and b then
--         Panel:Hide()
--         b = false;
--     end
-- end)

hook.Add( "PopulateBasewars", "AddEntityContent", function( pnlContent, tree, node )

    local Categorised = {}
    
    -- Add this list into the tormoil
    local SpawnableEntities = scripted_ents.GetSpawnable()
    
    for k,v in pairs(SpawnableEntities) do --Remove all non basewars items
        if v.Price == nil then
            table.remove(SpawnableEntities, k)
        end
    end

    if ( SpawnableEntities ) then
        for k, v in pairs( SpawnableEntities ) do
            v.Category = v.Category or "Other"
            Categorised[ v.Category ] = Categorised[ v.Category ] or {}
            table.insert( Categorised[ v.Category ], v )
            
        end
    end

    --
    -- Add a tree node for each category
    --
    for CategoryName, v in SortedPairs( Categorised ) do
                    
        -- Add a node to the tree
        local node = tree:AddNode( CategoryName, "icon16/bricks.png" );

            -- When we click on the node - populate it using this function
        node.DoPopulate = function( self )
    
            -- If we've already populated it - forget it.
            if ( self.PropPanel ) then return end
        
            -- Create the container panel
            self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
            self.PropPanel:SetVisible( false )
            self.PropPanel:SetTriggerSpawnlistChange( false )
        
            for k, ent in SortedPairsByMemberValue( v, "PrintName" ) do
                            
                local Icon = spawnmenu.CreateContentIcon( ent.ScriptedEntityType or "entity", self.PropPanel, 
                { 
                    nicename    = ent.PrintName or ent.ClassName,
                    spawnname   = ent.ClassName,
                    material    = "entities/"..ent.ClassName..".png",
                    admin       = ent.AdminOnly || ( !ent.Spawnable && ent.AdminSpawnable )
                            
                })
                Icon.DoClick = function ()
                    LocalPlayer():ConCommand("buy_entity "..ent.ClassName)
                end
                local Tooltip =  Format( "Name: %s\nPrice: %s", ent.PrintName, ent.Price )
                Icon:SetTooltip( Tooltip )
                                                                
            end
                    
        end

        -- If we click on the node populate it and switch to it.
        node.DoClick = function( self )
    
            self:DoPopulate()       
            pnlContent:SwitchPanel( self.PropPanel );
    
        end

    end

    -- Select the first node
    local FirstNode = tree:Root():GetChildNode( 0 )
    if ( IsValid( FirstNode ) ) then
        FirstNode:InternalDoClick()
    end

end )

spawnmenu.AddCreationTab( "Basewars", function()

    local ctrl = vgui.Create( "SpawnmenuContentPanel" )
    ctrl:CallPopulateHook( "PopulateBasewars" );

    return ctrl

end, "icon16/basket.png", 20 )
