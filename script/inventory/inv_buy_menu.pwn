#define INVALID_PAGE_ID ( -1 ) 

new
	MAX_PAGES [ MAX_TYPES ][ MAX_SHOPS ];

IBusiness_OnGameModeInit() 
{	
	for( new i; i < MAX_TYPES; i++ )
	{
		mysql_format:g_string( "SELECT * FROM `"DB_BUSINESS_ITEMS"` WHERE `b_type` = '%d'", i );		
		mysql_tquery( mysql, g_string, "LoadBusinessItems", "d", i );
	}
	
	return 1;
}

function LoadBusinessItems( type )
{
	clean_array();
	
	new 
		rows = cache_get_row_count( ),
		count[ MAX_TYPES ][ MAX_SHOPS ];
	
	if( rows )
	{
		for( new b; b < rows; b++ )
		{
			business_items[type][b][b_id] = cache_get_field_content_int( b, "id", mysql );
			business_items[type][b][b_item] = cache_get_field_content_int( b, "b_item", mysql );
			business_items[type][b][b_products] = cache_get_field_content_int( b, "b_products", mysql );
			business_items[type][b][b_param_3] = cache_get_field_content_int( b, "b_param_3", mysql );
			
			count[type][business_items[type][b][b_param_3]]++;
			
			MAX_PAGES[type][business_items[type][b][b_param_3]] = floatround( float(count[type][business_items[type][b][b_param_3]]) / 5.000 , floatround_ceil );
			
			if( type == B_TYPE_SHOP )
			{
				business_items[type][b][b_param_1] = cache_get_field_content_int( b, "b_param_1", mysql );
				business_items[type][b][b_param_2] = cache_get_field_content_int( b, "b_param_2", mysql );
			}
		}
	
	}
	return 1;
}

UpdateImagesBuyMenu( playerid, type, page ) 
{ 
	new  
		id,
		temp = 0,
		j,
		bid = GetPVarInt( playerid, "BuyMenu:BId" ),
		shop = GetPVarInt( playerid, "BuyMenu:BShop" ),
		idx = page * MAX_INVENTORY_BUY + GetPVarInt( playerid, "BuyMenu:BItem" );
		
	if( !page )
	{
		SetPVarInt( playerid, "BuyMenu:BItem", INVALID_PARAM );
		idx = page * MAX_INVENTORY_BUY;
	}
		
	SetPVarInt( playerid, "BuyMenu:Page", page );
	
	for( new i = idx; i < MAX_BUSINESS_ITEMS; i++ ) 
	{
		if( business_items[type][i][b_id] && business_items[type][i][b_param_3] == shop )
		{
			if( ( id = getInventoryId( business_items[type][i][b_item] ) ) == STATUS_ERROR ) 
				continue;
			
			if( GetPVarInt( playerid, "BuyMenu:BItem" ) == INVALID_PARAM )
				SetPVarInt( playerid, "BuyMenu:BItem", i );
			
			j = temp;
			
			while( j < MAX_INVENTORY_BUY ) 
			{	
				PlayerTextDrawHide( playerid, buyModel[ playerid ][ j ] ); 
				
				PlayerTextDrawSetPreviewModel( 
					playerid, 
					buyModel[ playerid ][ j ], 
					GetModelItemBusiness( type, i )
				); 
				
				PlayerTextDrawSetPreviewRot( 
					playerid, 
					buyModel[ playerid ][ j ], 
					inventory[ id ][i_pos][0], 
					inventory[ id ][i_pos][1], 
					inventory[ id ][i_pos][2], 
					inventory[ id ][i_pos][3] 
				); 
				
				format:g_small_string( "$%d", business_items[type][i][b_products] * BusinessInfo[bid][b_product_price] );
				PlayerTextDrawSetString( playerid, buyPrice[playerid][ j ], g_small_string );
				
				PlayerTextDrawSetString( playerid, buyName[playerid][ j ], inventory[id][i_name] );
				
				PlayerTextDrawShow( playerid, buyModel[ playerid ][ j ] ); 
				
				buy_menu_select[playerid][j] = i;
				j++;
				
				temp = j;
			
				break;
			}
		}
		
		if( temp == MAX_INVENTORY_BUY )
		{
			for( new k; k < MAX_INVENTORY_BUY; k++ )
			{
				PlayerTextDrawShow( playerid, buyBox[playerid][k] );
				PlayerTextDrawShow( playerid, buyButton[BUTTON_BUY][playerid][k] );
				PlayerTextDrawShow( playerid, buyButton[BUTTON_INFO][playerid][k] );
				PlayerTextDrawShow( playerid, buyPrice[playerid][k] );
				PlayerTextDrawShow( playerid, buyName[playerid][k] );
				PlayerTextDrawShow( playerid, buyModel[playerid][k] );
			}
			break;
		}
	}
	
	if( temp < MAX_INVENTORY_BUY )
	{
		for( new k = temp; k < MAX_INVENTORY_BUY; k++ )
		{
			PlayerTextDrawHide( playerid, buyBox[playerid][k] );
			PlayerTextDrawHide( playerid, buyButton[BUTTON_BUY][playerid][k] );
			PlayerTextDrawHide( playerid, buyButton[BUTTON_INFO][playerid][k] );
			PlayerTextDrawHide( playerid, buyPrice[playerid][k] );
			PlayerTextDrawHide( playerid, buyName[playerid][k] );
			PlayerTextDrawHide( playerid, buyModel[playerid][k] );
		}
	}

	return 1; 
}

sUpdateImagesBuyMenu( playerid, type, page ) 
{ 
	new  
		id, j,
		temp = 0,
		model,
		idx = page * MAX_INVENTORY_BUY;
		
	SetPVarInt( playerid, "BuyMenu:Page", page );
	
	for( new i = idx; i < MAX_STATIC_ITEMS; i++ ) 
	{
		if( static_items[type][i][s_id] )
		{
			if( ( id = getInventoryId( static_items[type][i][s_id] ) ) == STATUS_ERROR ) 
				continue;
		
			switch( type )
			{
				case STATIC_SHOP_GUN, STATIC_SHOP_REFILL: model = inventory[ id ][i_model];
			}
			
			j = temp;
			
			while( j < MAX_INVENTORY_BUY ) 
			{	
				PlayerTextDrawHide( playerid, buyModel[ playerid ][ j ] ); 
				
				PlayerTextDrawSetPreviewModel( 
					playerid, 
					buyModel[ playerid ][ j ], 
					model
				); 
				
				PlayerTextDrawSetPreviewRot( 
					playerid, 
					buyModel[ playerid ][ j ], 
					inventory[ id ][i_pos][0], 
					inventory[ id ][i_pos][1], 
					inventory[ id ][i_pos][2], 
					inventory[ id ][i_pos][3] 
				); 
				
				format:g_small_string( "$%d", static_items[type][i][s_price] );
				PlayerTextDrawSetString( playerid, buyPrice[playerid][ j ], g_small_string );
				
				PlayerTextDrawSetString( playerid, buyName[playerid][ j ], inventory[id][i_name] );
				
				PlayerTextDrawShow( playerid, buyModel[ playerid ][ j ] ); 
				
				buy_menu_select[playerid][j] = i;
				j++;
				
				temp = j;
			
				break;
			}
		}
		
		if( temp == MAX_INVENTORY_BUY )
		{
			for( new k; k < MAX_INVENTORY_BUY; k++ )
			{
				PlayerTextDrawShow( playerid, buyBox[playerid][k] );
				PlayerTextDrawShow( playerid, buyButton[BUTTON_BUY][playerid][k] );
				PlayerTextDrawShow( playerid, buyButton[BUTTON_INFO][playerid][k] );
				PlayerTextDrawShow( playerid, buyPrice[playerid][k] );
				PlayerTextDrawShow( playerid, buyName[playerid][k] );
				PlayerTextDrawShow( playerid, buyModel[playerid][k] );
			}
			break;
		}
	}
	
	if( temp < MAX_INVENTORY_BUY )
	{
		for( new k = temp; k < MAX_INVENTORY_BUY; k++ )
		{
			PlayerTextDrawHide( playerid, buyBox[playerid][k] );
			PlayerTextDrawHide( playerid, buyButton[BUTTON_BUY][playerid][k] );
			PlayerTextDrawHide( playerid, buyButton[BUTTON_INFO][playerid][k] );
			PlayerTextDrawHide( playerid, buyPrice[playerid][k] );
			PlayerTextDrawHide( playerid, buyName[playerid][k] );
			PlayerTextDrawHide( playerid, buyModel[playerid][k] );
		}
	}

	return 1; 
}

GetModelItemBusiness( type, item )
{
	new
		id = getInventoryId( business_items[type][item][b_item] );
	
	switch( type )
	{
		case B_TYPE_SHOP:
		{
			if( business_items[type][item][b_param_1] == INVALID_PARAM )
				return inventory[id][i_model];
			else
				return business_items[type][item][b_param_1];
		}		
		
		default: // Дефолт
		{
			if( inventory[id][i_id] == business_items[type][item][b_item] )
				return inventory[id][i_model];
		}	
	}
	
	return 0;
}

IBusiness_OnPlayerClickTextDraw( playerid, Text:clickedid ) 
{
	if( _:clickedid == INVALID_TEXT_DRAW ) 
	{
		if( GetPVarInt( playerid, "BuyMenu:Show" ) )
		{
			showBuyMenu( playerid, false );
			
			DeletePVar( playerid, "BuyMenu:Page" );
			DeletePVar( playerid, "BuyMenu:Show" );
			DeletePVar( playerid, "BuyMenu:BId" );
			DeletePVar( playerid, "BuyMenu:BShop" );
			DeletePVar( playerid, "BuyMenu:Type" );
			
			g_player_interaction{playerid} = 0;
			
			return 1;
		}
		
		if( GetPVarInt( playerid, "Static:ShowBuyMenu" ) )
		{
			
			showBuyMenu( playerid, false );
		
			DeletePVar( playerid, "Static:ShowBuyMenu" );
			DeletePVar( playerid, "Static:MaxPage" );
			DeletePVar( playerid, "Static:Item" );
			DeletePVar( playerid, "BuyMenu:Page" );
			DeletePVar( playerid, "BuyMenu:Type" );
			
			g_player_interaction{playerid} = 0;
			
			return 1;
		}
	}
	else if( clickedid == buyArrow[0] )	//Next
	{
		if( GetPVarInt( playerid, "Static:ShowBuyMenu" ) )
		{
			if( GetPVarInt( playerid, "BuyMenu:Page" ) + 1 >= GetPVarInt( playerid, "Static:MaxPage" ) ) 
				return 1; 
		
			sUpdateImagesBuyMenu( playerid, GetPVarInt( playerid, "BuyMenu:Type" ), GetPVarInt( playerid, "BuyMenu:Page" ) + 1 );
		
			return 1;
		}
	
		new
			bid = GetPVarInt( playerid, "BuyMenu:BId" );
			
		if( GetPVarInt( playerid, "BuyMenu:Page" ) + 1 == GetMaxPageBusiness( bid ) && !BusinessInfo[bid][b_improve][1] )
		{
			return SendClient:( playerid, C_WHITE, !""gbDefault"В этом бизнесе не установлен расширенный прилавок." );
		}
	
		if( GetPVarInt( playerid, "BuyMenu:Page" ) + 1 >= MAX_PAGES[ GetPVarInt( playerid, "BuyMenu:Type") ][ BusinessInfo[ bid ][b_shop] ] ) 
			return 1; 	
			
		UpdateImagesBuyMenu( playerid, GetPVarInt( playerid, "BuyMenu:Type" ), GetPVarInt( playerid, "BuyMenu:Page" ) + 1 ); 
		return 1;
	}
	else if( clickedid == buyArrow[1] ) //Back
	{
		if( GetPVarInt( playerid, "Static:ShowBuyMenu" ) )
		{
			if( ( GetPVarInt( playerid, "BuyMenu:Page" ) - 1 ) == INVALID_PAGE_ID ) 
				return 1;
			
			sUpdateImagesBuyMenu( playerid, GetPVarInt( playerid, "BuyMenu:Type" ), GetPVarInt( playerid, "BuyMenu:Page" ) - 1 ); 
			
			return 1;
		}
	
		if( ( GetPVarInt( playerid, "BuyMenu:Page" ) - 1 ) == INVALID_PAGE_ID ) 
			return 1;

		UpdateImagesBuyMenu( playerid, GetPVarInt( playerid, "BuyMenu:Type" ), GetPVarInt( playerid, "BuyMenu:Page" ) - 1 ); 
		return 1;
	}

	return 0;
}

Bus_OnPlayerClickPlayerTextDraw( playerid, PlayerText: playertextid ) 
{
	/* - Действия в меню покупки - */
	for( new i; i < MAX_INVENTORY_BUY; i++ ) 
	{
		new
			item = buy_menu_select[ playerid ][i],
			type = GetPVarInt( playerid, "BuyMenu:Type" ),
			id = getInventoryId( business_items[type][item][b_item] ),
			model,
			status,
			index;
			
		if( playertextid == buyButton[BUTTON_INFO][playerid][i] ) 
		{
			if( GetPVarInt( playerid, "Static:ShowBuyMenu" ) )
			{
				DeletePVar( playerid, "Inv:Show" );
				DeletePVar( playerid, "Static:ShowBuyMenu" );
				CancelSelectTextDraw( playerid );
				
				id = getInventoryId( static_items[type][item][s_id] );
			
				switch( type )
				{
					case STATIC_SHOP_GUN, STATIC_SHOP_REFILL: model = inventory[ id ][i_model];
				}
			
				format:g_string( ""cBLUE"Информация\n\n"cWHITE"%s", inventory[id][i_text] );
				showPlayerDialog( playerid, d_buy_menu_select + 2, DIALOG_STYLE_MSGBOX, " ", g_string, "Закрыть", "" );
			
				showPreviewModel( playerid, id, model, true );
				return 1;
			}
			
			DeletePVar( playerid, "Inv:Show" );
			DeletePVar( playerid, "BuyMenu:Show" );
			CancelSelectTextDraw( playerid );
			
			format:g_big_string( ""cBLUE"Информация\n\n"cWHITE"%s", inventory[id][i_text] );
			showPlayerDialog( playerid, d_buy_menu_select, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
			
			showPreviewModel( playerid, id, GetModelItemBusiness( type, item ), true );
		}
		
		if( playertextid == buyButton[BUTTON_BUY][playerid][i] ) 
		{
			if( GetPVarInt( playerid, "Static:ShowBuyMenu" ) )
			{
				id = getInventoryId( static_items[type][item][s_id] );
			
				if( type == STATIC_SHOP_GUN )
				{
					model = inventory[ id ][i_model];
				
					switch( static_items[type][item][s_other] )
					{
						case 1:
						{
							status = GetStatusPlayerLicense( playerid, LICENSE_GUN_1 );
							if( !status || status == 2 ) 
								return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует лицензия 1 уровня." );
							
							index = GetIndexPlayerLicense( playerid, LICENSE_GUN_1 );
							
							if( !isnull( License[playerid][index][lic_gun_name] ) )	
								return SendClient:( playerid, C_WHITE, !""gbError"Вы уже покупали оружие на эту лицензию ранее." );
						}
						case 2:
						{
							status = GetStatusPlayerLicense( playerid, LICENSE_GUN_2 );
							if( !status || status == 2 ) return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует лицензия 2 уровня." );
							
							index = GetIndexPlayerLicense( playerid, LICENSE_GUN_2 );
							
							if( !isnull( License[playerid][index][lic_gun_name] ) )	
								return SendClient:( playerid, C_WHITE, !""gbError"Вы уже покупали оружие на эту лицензию ранее." );
						}
						case 3:
						{
							status = GetStatusPlayerLicense( playerid, LICENSE_GUN_3 );
							if( !status || status == 2 ) return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует лицензия 3 уровня." );
							
							index = GetIndexPlayerLicense( playerid, LICENSE_GUN_3 );
							
							if( !isnull( License[playerid][index][lic_gun_name] ) )	
								return SendClient:( playerid, C_WHITE, !""gbError"Вы уже покупали оружие на эту лицензию ранее." );
						}
						
						case 4:
						{
							status = GetStatusPlayerLicense( playerid, LICENSE_GUN_1 );
							if( !status || status == 2 ) return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует лицензия 1 уровня." );
						}
						
						case 5:
						{
							status = GetStatusPlayerLicense( playerid, LICENSE_GUN_2 );
							if( !status || status == 2 ) return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует лицензия 2 уровня." );
						}
						
						case 6:
						{
							status = GetStatusPlayerLicense( playerid, LICENSE_GUN_3 );
							if( !status || status == 2 ) return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует лицензия 3 уровня." );
						}
					}
				}
			
				if( Player[playerid][uMoney] < static_items[type][i][s_price] )
				{
					SendClient:( playerid, C_WHITE, !NO_MONEY );
					return 1;
				}
				
				DeletePVar( playerid, "Inv:Show" );
				DeletePVar( playerid, "Static:ShowBuyMenu" );
				CancelSelectTextDraw( playerid );
				
				SetPVarInt( playerid, "Static:Item", item );
				
				format:g_small_string( "\
					"cBLUE"Покупка\n\n\
					"cWHITE"Вы действительно хотите купить "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?", 
					inventory[ id ][i_name],
					static_items[type][item][s_price]
				);
				showPlayerDialog( playerid, d_buy_menu_select + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				
				return 1;
			}
			
			DeletePVar( playerid, "Inv:Show" );
			DeletePVar( playerid, "BuyMenu:Show" );
			CancelSelectTextDraw( playerid );
		
			format:g_small_string( "\
				"cBLUE"Покупка\n\n\
				"cWHITE"Вы действительно хотите купить "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?", 
				inventory[id][i_name], business_items[type][item][b_products] * BusinessInfo[ GetPVarInt( playerid, "BuyMenu:BId" ) ][b_product_price]
			);
			showPlayerDialog( playerid, d_buy_menu_select + 1, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			
			SetPVarInt( playerid, "BuyMenu:Item", item );
		}
	}
	
	return 1;
}

IBusiness_OnDialogResponse( playerid, dialogid, response, inputtext[] ) 
{
	#pragma unused inputtext
	clean_array();
	
	switch( dialogid ) 
	{
		case d_buy_menu_select: 
		{
			showPreviewModel( playerid, 0, 0, false );
			
			SetPVarInt( playerid, "BuyMenu:Show", 1 );
			SetPVarInt( playerid, "Inv:Show", 1 );
			
			SelectTextDraw( playerid, 0x797C7CFF );
		}
		
		case d_buy_menu_select + 1: 
		{
			if( !response )
			{
				SetPVarInt( playerid, "BuyMenu:Show", 1 );
				SetPVarInt( playerid, "Inv:Show", 1 );
				
				SelectTextDraw( playerid, 0x797C7CFF );
				return 1;
			}
			
			new
				item = GetPVarInt( playerid, "BuyMenu:Item"),
				type = GetPVarInt( playerid, "BuyMenu:Type" ),
				bid = GetPVarInt( playerid, "BuyMenu:BId" ),
				id = getInventoryId( business_items[type][item][b_item] ),
				price = business_items[type][item][b_products] * BusinessInfo[bid][b_product_price],
				earn = floatround( float( price ) / 100 * 70 ),
				bool:status = false;
			
			if( Player[playerid][uMoney] < price )
			{
				SetPVarInt( playerid, "BuyMenu:Show", 1 );
				SetPVarInt( playerid, "Inv:Show", 1 );
				
				SelectTextDraw( playerid, 0x797C7CFF );
				return SendClient:( playerid, C_GRAY, !NO_MONEY );
			}
			
			if( BusinessInfo[bid][b_products] < business_items[type][item][b_products] )
			{
				SetPVarInt( playerid, "BuyMenu:Show", 1 );
				SetPVarInt( playerid, "Inv:Show", 1 );
				
				SelectTextDraw( playerid, 0x797C7CFF );
				return SendClient:( playerid, C_WHITE, ""gbError"В бизнесе недостаточно продуктов!" );
			}
			
			if( type == B_TYPE_SHOP )
			{
				if( inventory[id][i_type] == INV_PHONE )
				{
					for( new i; i < MAX_PHONES; i++ )
					{
						if( !Phone[playerid][i][p_id] )
						{
							new 
								number = randomize( 100000, 999999 ); //Генерируем уникальный номер телефона
								
							if( !giveItem( playerid, id, 1, business_items[type][item][b_param_1], number ) )
							{
								SetPVarInt( playerid, "BuyMenu:Show", 1 );
								SetPVarInt( playerid, "Inv:Show", 1 );
								
								SelectTextDraw( playerid, 0x797C7CFF );
								return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
							}
							
							CreatePhone( playerid, number );
							
							pformat:( ""gbSuccess"Номер купленного телефона - "cBLUE"%d"cWHITE".", number );
							psend:( playerid, C_WHITE );
							
							status = true;
							
							break;
						}
					}
					
					if( !status )
					{
						SetPVarInt( playerid, "BuyMenu:Show", 1 );
						SetPVarInt( playerid, "Inv:Show", 1 );
						
						SelectTextDraw( playerid, 0x797C7CFF );
						return SendClient:( playerid, C_WHITE, ""gbError"У Вас слишком много телефонов!" );
					}
				}
				else if( inventory[id][i_id] == 30 )
				{
					if( !giveItem( playerid, id, 1, 30 ) )
					{
						SetPVarInt( playerid, "BuyMenu:Show", 1 );
						SetPVarInt( playerid, "Inv:Show", 1 );
								
						SelectTextDraw( playerid, 0x797C7CFF );
						return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
					}
				}
				else
				{
					if( !giveItem( playerid, id, 1, business_items[type][item][b_param_1], business_items[type][item][b_param_2] ) )
					{
						SetPVarInt( playerid, "BuyMenu:Show", 1 );
						SetPVarInt( playerid, "Inv:Show", 1 );
								
						SelectTextDraw( playerid, 0x797C7CFF );
						return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
					}
				}
			}
			else
			{
				if( !giveItem( playerid, id ) )
				{
					SetPVarInt( playerid, "BuyMenu:Show", 1 );
					SetPVarInt( playerid, "Inv:Show", 1 );
								
					SelectTextDraw( playerid, 0x797C7CFF );
					return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
				}
			}
			
			SetPlayerCash( playerid, "-", price );
			
			BusinessInfo[bid][b_safe] += earn;
			UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
			
			BusinessInfo[bid][b_products] -= business_items[type][item][b_products];
			UpdateBusiness( bid, "b_products", BusinessInfo[bid][b_products] );
			
			if( !BusinessInfo[bid][b_products] )
			{
				BusinessInfo[bid][b_products_time] = gettime() + 259200;
				UpdateBusiness( bid, "b_products_time", BusinessInfo[bid][b_products_time] );
			}
			
			pformat:( ""gbSuccess"Вы приобрели предмет - "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", inventory[id][i_name], price );
			psend:( playerid, C_WHITE );
			
			SetPVarInt( playerid, "BuyMenu:Show", 1 );
			SetPVarInt( playerid, "Inv:Show", 1 );
			
			SelectTextDraw( playerid, 0x797C7CFF );
			
			for( new j; j < MAX_INVENTORY; j++ )
			{
				updateImages( playerid, j, TYPE_INV );
				updateAmount( playerid, j );
			}
			
			updateMass( playerid );
			
			updateSelect( playerid, invSelect[playerid], 0 );
			invSelect[playerid] = INVALID_PTD;
		}
		
		case d_buy_menu_select + 2: 
		{
			showPreviewModel( playerid, 0, 0, false );
			
			SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
			SetPVarInt( playerid, "Inv:Show", 1 );
			
			SelectTextDraw( playerid, 0x797C7CFF );
		}
		
		/*case d_buy_menu_select + 3: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Static:Item" );
			
				SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
				SetPVarInt( playerid, "Inv:Show", 1 );
				
				SelectTextDraw( playerid, 0x797C7CFF );
				return 1;
			}
			
			new
				item = GetPVarInt( playerid, "Static:Item" ),
				id = getInventoryId( static_items[ STATIC_SHOP_GUN ][item][s_id] );
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 100 )
			{
				format:g_small_string( "\
					"cBLUE"Покупка %s\n\n\
					"cWHITE"Укажите количество для покупки:\n\
					"gbDialogError"Неправильный формат ввода.", 
					inventory[ id ][i_name]
				);
				return showPlayerDialog( playerid, d_buy_menu_select + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Купить", "Назад" );
			}
			
			if( Player[playerid][uMoney] < strval( inputtext ) * static_items[ STATIC_SHOP_GUN ][item][s_price] )
			{
				format:g_small_string( "\
					"cBLUE"Покупка %s\n\n\
					"cWHITE"Укажите количество для покупки:\n\
					"gbDialogError"Недостаточно денег.", 
					inventory[ id ][i_name]
				);
				return showPlayerDialog( playerid, d_buy_menu_select + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Купить", "Назад" );
			}
			
			if( !giveItem( playerid, id, strval( inputtext ) ) )
			{
				SendClient:( playerid, C_WHITE, !""gbError"У Вас нет свободного места в инвентаре." );
				
				DeletePVar( playerid, "Static:Item" );
			
				SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
				SetPVarInt( playerid, "Inv:Show", 1 );
				
				SelectTextDraw( playerid, 0x797C7CFF );
			}
		}*/
		
		case d_buy_menu_select + 4: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Static:Item" );
			
				SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
				SetPVarInt( playerid, "Inv:Show", 1 );
				
				SelectTextDraw( playerid, 0x797C7CFF );
				return 1;
			}
		
			new
				item = GetPVarInt( playerid, "Static:Item"),
				type = GetPVarInt( playerid, "BuyMenu:Type" ),
				id = getInventoryId( static_items[ type ][item][s_id] ),
				index;
				
			switch( inventory[ id ][i_type] )
			{
				case INV_GUN, INV_SMALL_GUN :
				{
					switch( static_items[ type ][item][s_other] )
					{
						case 1: index = GetIndexPlayerLicense( playerid, LICENSE_GUN_1 );
						case 2:	index = GetIndexPlayerLicense( playerid, LICENSE_GUN_2 );
						case 3:	index = GetIndexPlayerLicense( playerid, LICENSE_GUN_3 );
					}	
				
					if( !giveItem( playerid, static_items[ type ][item][s_id], 1, static_items[ type ][item][s_param], License[playerid][index][lic_id] ) )
					{
						DeletePVar( playerid, "Static:Item" );
						SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
						SetPVarInt( playerid, "Inv:Show", 1 );
						
						SelectTextDraw( playerid, 0x797C7CFF );
						return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
					}
					
					clean:<License[playerid][index][lic_gun_name]>;
					strcat( License[playerid][index][lic_gun_name], inventory[ id ][i_name], 32 );
					
					GivePlayerLicense( playerid, LIC_UPDATE, index );
				}
				
				default:
				{
					if( !giveItem( playerid, static_items[ type ][item][s_id], 1, static_items[ type ][item][s_param] ) )
					{
						DeletePVar( playerid, "Static:Item" );
						SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
						SetPVarInt( playerid, "Inv:Show", 1 );
						
						SelectTextDraw( playerid, 0x797C7CFF );
						return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
					}
				}
			}
		
			SetPlayerCash( playerid, "-", static_items[ type ][item][s_price] );
			pformat:( ""gbSuccess"Вы приобрели предмет - "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", inventory[id][i_name], static_items[ type ][item][s_price] );
			psend:( playerid, C_WHITE );
		
			DeletePVar( playerid, "Static:Item" );
			SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
			SetPVarInt( playerid, "Inv:Show", 1 );
			
			SelectTextDraw( playerid, 0x797C7CFF );
			
			for( new j; j < MAX_INVENTORY; j++ )
			{
				updateImages( playerid, j, TYPE_INV );
				updateAmount( playerid, j );
			}
			
			updateMass( playerid );
			
			updateSelect( playerid, invSelect[playerid], 0 );
			invSelect[playerid] = INVALID_PTD;
		}
	}
	
	return 1;
}