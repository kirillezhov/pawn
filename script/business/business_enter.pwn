Business_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED ( KEY_WALK ) )
	{
		for( new b; b < MAX_BUSINESS; b++ )
		{
			if( BusinessInfo[b][b_id] )
			{
				if( IsPlayerInRangeOfPoint( playerid, 1.5, BusinessInfo[b][b_exit_pos][0], BusinessInfo[b][b_exit_pos][1], BusinessInfo[b][b_exit_pos][2] ) 
					&& GetPlayerVirtualWorld( playerid ) == BusinessInfo[b][b_id] )
				{
					if( !BusinessInfo[b][b_lock] )
						return SendClient:( playerid, C_WHITE, ""gbError"Двери бизнеса закрыты на ключ!" );
						
					checkPlayerUseTexViewer( playerid );
				
					Player[playerid][tgpsPos][0] = 
					Player[playerid][tgpsPos][1] = 
					Player[playerid][tgpsPos][2] = 0.0;
				
					setPlayerPos( playerid, BusinessInfo[b][b_enter_pos][0],
											BusinessInfo[b][b_enter_pos][1],
											BusinessInfo[b][b_enter_pos][2]
								);
					SetPlayerFacingAngle( playerid, BusinessInfo[b][b_enter_pos][3] - 180.0 );		
					SetPlayerVirtualWorld( playerid, 0 );
					
					DeletePVar( playerid, "User:inInt" );
					DeletePVar( playerid, "Enter:BId" );
					
					UpdateWeather( playerid );
					
					break;
				}
			
				if( IsPlayerInRangeOfPoint( playerid, 1.5, BusinessInfo[b][b_enter_pos][0], BusinessInfo[b][b_enter_pos][1], BusinessInfo[b][b_enter_pos][2] ) )
				{
					if( BusinessInfo[b][b_user_id] == INVALID_PARAM )	
					{
						format:g_small_string( "\
							"cBLUE"%s #%d\n\n\
							"cWHITE"Рыночная стоимость: "cBLUE"$%d"cWHITE"\n\
							Интерьер: "cBLUE"#%d"cWHITE"",
							GetBusinessType( b ),
							BusinessInfo[b][b_id],
							BusinessInfo[b][b_price], 
							BusinessInfo[b][b_interior]
						);
							
						SetPVarInt( playerid, "Enter:BId", b );
						return showPlayerDialog( playerid, d_buy_business, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Вход", "Закрыть" );
					}
					
					if( !BusinessInfo[b][b_lock] )
					{
						return SendClient:( playerid, C_WHITE, ""gbError"Двери бизнеса закрыты на ключ." );
					}
					
					Player[playerid][tgpsPos][0] = BusinessInfo[b][b_enter_pos][0];
					Player[playerid][tgpsPos][1] = BusinessInfo[b][b_enter_pos][1];
					Player[playerid][tgpsPos][2] = BusinessInfo[b][b_enter_pos][2];
				
					setPlayerPos( playerid, BusinessInfo[b][b_exit_pos][0],
											BusinessInfo[b][b_exit_pos][1],
											BusinessInfo[b][b_exit_pos][2] );
					SetPlayerFacingAngle( playerid, BusinessInfo[b][b_exit_pos][3] );
					SetPlayerVirtualWorld( playerid, BusinessInfo[b][b_id] );
					
					setHouseWeather( playerid );					
					break;
				}
			}
			
			//Пикап с кассой
			if( BusinessInfo[b][b_state_cashbox] && GetPlayerVirtualWorld( playerid ) == BusinessInfo[b][b_id]  )
			{
				if( IsPlayerInRangeOfPoint( playerid, 1.5,
					BusinessInfo[b][b_pos_cashbox][0],
					BusinessInfo[b][b_pos_cashbox][1],
					BusinessInfo[b][b_pos_cashbox][2] ) )
				{
					SetPVarInt( playerid, "BuyMenu:Page", 0 );
					SetPVarInt( playerid, "BuyMenu:Show", 1 );
					SetPVarInt( playerid, "BuyMenu:BId", b );
					SetPVarInt( playerid, "BuyMenu:BShop", BusinessInfo[b][b_shop] );
					SetPVarInt( playerid, "BuyMenu:Type", BusinessInfo[b][b_type] );
					
					g_player_interaction{playerid} = 1;
					
					UpdateImagesBuyMenu( playerid, BusinessInfo[b][b_type], 0 );
					
					showBuyMenu( playerid, true );
					showInventory( playerid, true );
					
					return 1;
				}
			}
			
			if( BusinessInfo[b][b_user_id] == Player[playerid][uID] && GetPlayerVirtualWorld( playerid ) == playerid + 100 )
			{
				PlayerTextDrawShow( playerid, interior_info[playerid] );
				SetPVarInt( playerid, "Bpanel:IntShow", 1 );
			}
		}
		
		//Магазины оружия
		if( IsPlayerInRangeOfPoint( playerid, 1.0, PICKUP_WEAPON ) )
		{
			new
				amount = 0;
			
			for( new i; i < MAX_STATIC_ITEMS; i++ )
			{
				if( static_items[ STATIC_SHOP_GUN ][i][s_id] )
					amount++;
			}
			
			SetPVarInt( playerid, "Static:MaxPage", floatround( float( amount ) / float( MAX_INVENTORY_BUY ) , floatround_ceil ) );
			SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
			SetPVarInt( playerid, "BuyMenu:Page", 0 );
			SetPVarInt( playerid, "BuyMenu:Type", STATIC_SHOP_GUN );
			
			g_player_interaction{playerid} = 1;
			
			sUpdateImagesBuyMenu( playerid, STATIC_SHOP_GUN, 0 );
		
			showBuyMenu( playerid, true );
			showInventory( playerid, true );
		}
		else if( IsPlayerInRangeOfPoint( playerid, 1.0, PICKUP_REFILL ) || IsPlayerInRangeOfPoint( playerid, 1.0, PICKUP_REFILL_2 ) )
		{
			new
				amount = 0;
			
			for( new i; i < MAX_STATIC_ITEMS; i++ )
			{
				if( static_items[ STATIC_SHOP_REFILL ][i][s_id] )
					amount++;
			}
			
			SetPVarInt( playerid, "Static:MaxPage", floatround( float( amount ) / float( MAX_INVENTORY_BUY ) , floatround_ceil ) );
			SetPVarInt( playerid, "Static:ShowBuyMenu", 1 );
			SetPVarInt( playerid, "BuyMenu:Page", 0 );
			SetPVarInt( playerid, "BuyMenu:Type", STATIC_SHOP_REFILL );
			
			g_player_interaction{playerid} = 1;
			
			sUpdateImagesBuyMenu( playerid, STATIC_SHOP_REFILL, 0 );
		
			showBuyMenu( playerid, true );
			showInventory( playerid, true );
		}
	}
	
	return 1;
}