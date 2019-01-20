
CMD:helmet( playerid, params[] ) 
{
	if( sscanf( params, "iii", params[0], params[1], params[2] ) ) return true;
	new model = 18645, color, color_2;

	switch( params[0] ) 
	{
		case 0: model = 18645;
        case 1: model = 18976;
        case 2: model = 18977;
        case 3: model = 18978;
        case 4: model = 18979;
	}
	switch( params[1] ) 
	{
		case 0: color = 0xFFFFFFFF;
		case 1: color = 0xFF00FFFF;
		case 2: color = 0xFF0000FF;
		case 3: color = 0xFF000000;
		case 4: color = 0xFF00FF00;
		case 5: color = 0xFFff335c;
		case 6: color = 0xFFffff52;
		case 7: color = 0xFFd1e231;
		case 8: color = 0xFF93aa00;
		case 9: color = 0xFFe28b00;
		case 10: color = 0xFF4d2f00;
		case 11: color = 0xFFd63c1a;
		case 12: color = 0xFF42aaff;
		case 13: color = 0xFF00bfff;
		case 14: color = 0xFF0079db;
		case 15: color = 0xFF99caff;
	}
	switch( params[2] ) 
	{
		case 0: color_2 = 0xFFFFFFFF;
		case 1: color_2 = 0xFF00FFFF;
		case 2: color_2 = 0xFF0000FF;
		case 3: color_2 = 0xFF000000;
		case 4: color_2 = 0xFF00FF00;
		case 5: color_2 = 0xFFff335c;
		case 6: color_2 = 0xFFffff52;
		case 7: color_2 = 0xFFd1e231;
		case 8: color_2 = 0xFF93aa00;
		case 9: color_2 = 0xFFe28b00;
		case 10: color_2 = 0xFF4d2f00;
		case 11: color_2 = 0xFFd63c1a;
		case 12: color_2 = 0xFF42aaff;
		case 13: color_2 = 0xFF00bfff;
		case 14: color_2 = 0xFF0079db;
		case 15: color_2 = 0xFF99caff;
	}
	if( IsPlayerAttachedObjectSlotUsed( playerid, 8 ) ) RemovePlayerAttachedObject( playerid, 8 );
	SetPlayerAttachedObject( playerid, 8, model, 2, 0.101, 0.03, 0.0, 5.50, 84.60, 83.7, 
		1, 1, 1, color, color_2 );
	return 1;
}

stock showBag( playerid, name[], states ) 
{
	if( states ) 
	{
		TextDrawShowForPlayer( playerid, invBg[3] );
		TextDrawShowForPlayer( playerid, invBg[2] ); 
		
		for( new i; i < MAX_INVENTORY_BAG; i++ )
		{
			PlayerTextDrawShow( playerid, bagSlot[playerid][i] );
		}
		
		PlayerTextDrawSetString( playerid, bagName[playerid], name );
		PlayerTextDrawShow( playerid, bagName[playerid] );
		PlayerTextDrawShow( playerid, invBagMass[playerid] );
		
		for( new i; i < MAX_INVENTORY_BAG; i++ ) 
		{
			updateImages( playerid, i, TYPE_BAG );
			updateAmount( playerid, i, TYPE_BAG );
			updateSelect( playerid, bagSlot[playerid][i], false );
		}
	}
	else 
	{
		for( new i; i < MAX_INVENTORY_BAG; i++ )
		{
			PlayerTextDrawHide( playerid, bagSlot[playerid][i] );
			PlayerTextDrawHide( playerid, bagInvamount[playerid][i] );
		}
		
		PlayerTextDrawHide( playerid, bagName[playerid] );
		PlayerTextDrawHide( playerid, invBagMass[playerid] );
		
		TextDrawHideForPlayer( playerid, invBg[2] ); 
		TextDrawHideForPlayer( playerid, invBg[3] );
	}
	return 1;
}

stock ShowInventoryAdditional( playerid, name[], states, num_slots = MAX_INVENTORY_WAREHOUSE )
{	
	if( states )
	{
		TextDrawShowForPlayer( playerid, invBg[5] );
		TextDrawShowForPlayer( playerid, invBg[6] );
		
		for( new i; i < num_slots; i++ )
		{
			PlayerTextDrawShow( playerid, warehouseSlot[playerid][i] );
			
			updateImages( playerid, i, TYPE_WARECAR );
			updateAmount( playerid, i, TYPE_WARECAR );
			updateWareHouseSelect( playerid, GetPVarInt( playerid, "Inv:CarId" ), invSelect[playerid], 0, TYPE_WARECAR );
		}
		
		PlayerTextDrawSetString( playerid, warehouseName[playerid], name );
		PlayerTextDrawShow( playerid, warehouseName[playerid] );
	}
	else
	{
		TextDrawHideForPlayer( playerid, invBg[5] );
		TextDrawHideForPlayer( playerid, invBg[6] );
		
		for( new i; i < num_slots; i++ )
		{
			PlayerTextDrawHide( playerid, warehouseSlot[playerid][i] );
			PlayerTextDrawHide( playerid, warehouseInvamount[playerid][i] );
		}
		
		PlayerTextDrawHide( playerid, warehouseName[playerid] );
		PlayerTextDrawHide( playerid, warehouseInformation[playerid] );	
		
		//if( GetPVarInt( playerid, "CarInv:Select" ) != INVALID_PARAM )
			
		format:g_small_string( "закрыл%s багажник", SexTextEnd( playerid ) );
		SendRolePlayAction( playerid, g_small_string, RP_TYPE_AME );
	}
	
	return 1;
}

stock showBuyMenu( playerid, states )
{
	if( states )
	{
		TextDrawShowForPlayer( playerid, invBg[7] );
		TextDrawShowForPlayer( playerid, buyArrow[0] );
		TextDrawShowForPlayer( playerid, buyArrow[1] );
		
		for( new i; i < MAX_INVENTORY_BUY; i++ )
		{
			PlayerTextDrawShow( playerid, buyBox[playerid][i] );
			PlayerTextDrawShow( playerid, buyButton[BUTTON_BUY][playerid][i] );
			PlayerTextDrawShow( playerid, buyButton[BUTTON_INFO][playerid][i] );
			PlayerTextDrawShow( playerid, buyPrice[playerid][i] );
			PlayerTextDrawShow( playerid, buyName[playerid][i] );
			PlayerTextDrawShow( playerid, buyModel[playerid][i] );
		}
		
		SelectTextDraw( playerid, 0x797C7CFF );
	}
	else
	{
		TextDrawHideForPlayer( playerid, invBg[7] );
		TextDrawHideForPlayer( playerid, buyArrow[0] );
		TextDrawHideForPlayer( playerid, buyArrow[1] );
		
		for( new i; i < MAX_INVENTORY_BUY; i++ )
		{
			PlayerTextDrawHide( playerid, buyBox[playerid][i] );
			PlayerTextDrawHide( playerid, buyButton[BUTTON_BUY][playerid][i] );
			PlayerTextDrawHide( playerid, buyButton[BUTTON_INFO][playerid][i] );
			PlayerTextDrawHide( playerid, buyPrice[playerid][i] );
			PlayerTextDrawHide( playerid, buyName[playerid][i] );
			PlayerTextDrawHide( playerid, buyModel[playerid][i] );
		}
		
		//CancelSelectTextDraw( playerid );
	}
	return 1;
}

stock showPreviewModel( playerid, id, model, states )
{
	if( states )
	{
		SetPVarInt( playerid, "Inv:ShowPreviewModel", 1 );
				
		PlayerTextDrawSetPreviewModel( playerid, buyPreviewModel[playerid], model );
		PlayerTextDrawSetPreviewRot( 
					playerid, 
					buyPreviewModel[playerid], 
					inventory[ id ][i_pos][0], 
					inventory[ id ][i_pos][1], 
					inventory[ id ][i_pos][2], 
					inventory[ id ][i_pos][3] 
				); 
		
		PlayerTextDrawShow( playerid, buyPreviewModel[playerid] );
	}
	else
	{
		DeletePVar( playerid, "Inv:ShowPreviewModel" );
		PlayerTextDrawHide( playerid, buyPreviewModel[playerid] );
	}
	
	return 1;
}

stock showInventory( playerid, states ) 
{
	if( states ) 
	{
		for( new i; i < sizeof invBg; i++ ) 
		{
			switch( i ) 
			{
				case 2, 3, 5, 6, 7 : continue;
			}
			
			TextDrawShowForPlayer( playerid, invBg[i] );
		}
		for( new i; i < sizeof invText; i++ ) 
		{
			TextDrawShowForPlayer( playerid, invText[i] );
		}
		
		for( new i; i < MAX_INVENTORY; i++ ) 
		{
			updateImages( playerid, i, 0 );
			updateAmount( playerid, i, 0 );
			updateSelect( playerid, invSlot[playerid][i], false );
		}
		
		for( new i; i < MAX_INVENTORY_USE; i++ ) 
		{
			updateImages( playerid, i, 1 );
			updateSelect( playerid, useSlot[playerid][i], false );
		}
		
		PlayerTextDrawShow( playerid, invMass[playerid] );
		SelectTextDraw( playerid, 0x797C7CFF );
		SetPVarInt( playerid, "Inv:Show", 1 );
		
		updateMass( playerid );
		
		if( getUseBag( playerid ) ) 
		{
			new 
				id;
				
			for( new i; i < MAX_INVENTORY_USE; i++ )
			{
				if( !UseInv[playerid][i][inv_id] )
					continue;
					
				id = getInventoryId( UseInv[playerid][i][inv_id] );
				
				if( inventory[id][i_type] == INV_BAG )
				{
					showBag( playerid, inventory[id][i_name], true );
					break;
				}
			}
		}
	}
	else 
	{
		for( new i; i < sizeof invBg; i++ ) 
		{
			TextDrawHideForPlayer( playerid, invBg[i] );
		}
		
		for( new i; i < sizeof invText; i++ ) 
		{
			TextDrawHideForPlayer( playerid, invText[i] );
		}
		
		for( new i; i < MAX_INVENTORY; i++ ) 
		{
			PlayerTextDrawHide( playerid, invSlot[playerid][i] );
			PlayerTextDrawHide( playerid, invamount[playerid][i] );
		}
		
		for( new i; i < MAX_INVENTORY_USE; i++ ) 
		{
			PlayerTextDrawHide( playerid, useSlot[playerid][i] );
		}
		
		PlayerTextDrawHide( playerid, bagName[playerid] );
		PlayerTextDrawHide( playerid, invInformation[playerid] );
		PlayerTextDrawHide( playerid, invMass[playerid] );
		
		DeletePVar( playerid, "Inv:Show" );
		invSelect[playerid] = INVALID_PTD;
		
		if( getUseBag( playerid ) ) 
		{
			showBag( playerid, "", false );
		}
		
		if( GetPVarInt( playerid, "Inv:CarId" ) != INVALID_PARAM )
		{
			ShowInventoryAdditional( playerid, "", false );
			Vehicle[GetPVarInt( playerid, "Inv:CarId" )][vehicle_use_boot] = false;
			
			if( GetPVarInt( playerid, "Inv:AttachSelectSlot" ) == INVALID_PARAM )
				SetPVarInt( playerid, "Inv:CarId", INVALID_PARAM );
		}
		
		SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
		SetPVarInt( playerid, "UseInv:Select", INVALID_PARAM );
		SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
		SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
	}
	
	return 1;
}	
