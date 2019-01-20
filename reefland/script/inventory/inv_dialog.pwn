
CheckTransferInput( playerid, inputtext[], dialogid, id )
{
	if( inputtext[0] == EOS )
	{			
		clean:<g_big_string>;
		strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
		
		format:g_small_string( ""cWHITE"Введите id игрока, которому Вы хотите передать предмет "cBLUE"%s"cWHITE":\n\n\
			"gbDialog"Игрок должен находиться рядом с Вами.\n\
			"gbDialogError"Введите id игрока.",
			inventory[id][i_name]
		);
		strcat( g_big_string, g_small_string );
		showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
		
		return STATUS_ERROR;
	}
	
	if( !IsNumeric( inputtext ) )
	{
		clean:<g_big_string>;
		strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
		
		format:g_small_string( ""cWHITE"Введите id игрока, которому Вы хотите передать предмет "cBLUE"%s"cWHITE":\n\n\
			"gbDialog"Игрок должен находиться рядом с Вами.\n\
			"gbDialogError"Введите id игрока.",
			inventory[id][i_name]
		);
		strcat( g_big_string, g_small_string );
		showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
		
		return STATUS_ERROR;
	}
	
	if( !IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) )
	{
		clean:<g_big_string>;
		strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
		
		format:g_small_string( ""cWHITE"Введите id игрока, которому Вы хотите передать предмет "cBLUE"%s"cWHITE":\n\n\
			"gbDialog"Игрок должен находиться рядом с Вами.\n\
			"gbDialogError"Вы ввели некорректный id игрока.",
			inventory[id][i_name]
		);
		strcat( g_big_string, g_small_string );
		showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
		
		return STATUS_ERROR;
	}
	
	if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 )
	{
		clean:<g_big_string>;
		strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
		
		format:g_small_string( ""cWHITE"Введите id игрока, которому Вы хотите передать предмет "cBLUE"%s"cWHITE":\n\n\
			"gbDialog"Игрок должен находиться рядом с Вами.",
			inventory[id][i_name]
		);
		strcat( g_big_string, g_small_string );
		showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
		
		return STATUS_ERROR;
	}
	
	return STATUS_OK;
}

Inv_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_inv_settings : 
		{
			if( !response )
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				return 0;
			}
					
			switch( listitem ) 
			{
				case 0 : 
				{
					new
						i,
						id,
						itemamount,
						bag_id,
						car_id;
						
					if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_USE ) 
					{
						i = GetPVarInt( playerid, "Inv:OldSelect" );
						id = getInventoryId( UseInv[playerid][i][inv_id] );
						itemamount = UseInv[playerid][i][inv_amount];
					} 
					else if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_INV ) 
					{
						i = GetPVarInt( playerid, "Inv:OldSelect" );
						id = getInventoryId( PlayerInv[playerid][i][inv_id] );
						itemamount = PlayerInv[playerid][i][inv_amount];
					}
					else if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_BAG )
					{
						i = GetPVarInt( playerid, "Inv:OldSelect" );
						bag_id = getUseBagId( playerid );
						id = getInventoryId( BagInv[bag_id][i][inv_id] );
						itemamount = BagInv[bag_id][i][inv_amount];
					}
					else if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_WARECAR )
					{
						i = GetPVarInt( playerid, "Inv:OldSelect" );
						car_id = GetPVarInt( playerid, "Inv:CarId" );
						id = getInventoryId( CarInv[car_id][i][inv_id] );
						itemamount = CarInv[car_id][i][inv_amount];
					}
					else
						return SendClientMessage( playerid, C_WHITE, ""gbError"Вы не можете просмотреть информацию о данном предмете.");
					
					clean:<g_big_string>;
					strcat( g_big_string, ""gbDefault"Информация о предмете\n\n");
					format:g_small_string(  "Название: "cBLUE"%s"cWHITE"\n\n", inventory[id][i_name] ), strcat( g_big_string, g_small_string );
					format:g_small_string(  "Описание:\n"cBLUE"%s"cWHITE"\n\n", inventory[id][i_text] ), strcat( g_big_string, g_small_string );
					format:g_small_string(  "Количество: "cBLUE"%d"cWHITE"\n\n", itemamount ), strcat( g_big_string, g_small_string );
					format:g_small_string(  "Масса: "cBLUE"%.2f"cWHITE" кг.", inventory[id][i_mass] ), strcat( g_big_string, g_small_string );
					
					if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_SMALL_GUN )
					{
						if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_USE ) 
						{
							new
								save_weapon	[ MAX_WEAPON_SLOT ],
								save_ammo	[ MAX_WEAPON_SLOT ];
								
							for( new j; j < MAX_WEAPON_SLOT; j++ )
							{
								GetPlayerWeaponData( playerid, j, save_weapon[j], save_ammo[j] );
								
								if( save_weapon[j] == getUseGunId( playerid, i ) )
								{
									UseInv[playerid][i][inv_param_1] = save_ammo[j];
									SaveAmmoForUseWeaponSlot( playerid, i );
									break;
								}
							}
							
							if( UseInv[playerid][i][inv_param_2] > INVALID_PARAM )
							{
								format:g_small_string( "\n\nЛицензия: "cBLUE"#%d"cWHITE"\n", UseInv[playerid][i][inv_param_2] );
								strcat( g_big_string, g_small_string );
							}
							else if( UseInv[playerid][i][inv_param_2] == INDEX_FRACTION )
								strcat( g_big_string, "\n\nЛицензия: "cBLUE"Государственное"cWHITE"\n" );
							else
								strcat( g_big_string, "\n\nЛицензия: "cBLUE"Нет"cWHITE"\n" );
								
							format:g_small_string( "Патроны: "cBLUE"%d", UseInv[playerid][i][inv_param_1] );
							strcat( g_big_string, g_small_string );
						} 
						else if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_INV ) 
						{
							if( PlayerInv[playerid][i][inv_param_2] > INVALID_PARAM )
							{
								format:g_small_string( "\n\nЛицензия: "cBLUE"#%d"cWHITE"\n", PlayerInv[playerid][i][inv_param_2] );
								strcat( g_big_string, g_small_string );
							}
							else if( PlayerInv[playerid][i][inv_param_2] == INDEX_FRACTION )
								strcat( g_big_string, "\n\nЛицензия: "cBLUE"Государственное"cWHITE"\n" );
							else
								strcat( g_big_string, "\n\nЛицензия: "cBLUE"Нет"cWHITE"\n" );
							
							format:g_small_string( "Патроны: "cBLUE"%d", PlayerInv[playerid][i][inv_param_1] );
							strcat( g_big_string, g_small_string );
						}
						else if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_BAG )
						{
							if( BagInv[bag_id][i][inv_param_2] > INVALID_PARAM )
							{
								format:g_small_string( "\n\nЛицензия: "cBLUE"#%d"cWHITE"\n", BagInv[bag_id][i][inv_param_2] );
								strcat( g_big_string, g_small_string );
							}
							else if( BagInv[bag_id][i][inv_param_2] == INDEX_FRACTION )
								strcat( g_big_string, "\n\nЛицензия: "cBLUE"Государственное"cWHITE"\n" );
							else
								strcat( g_big_string, "\n\nЛицензия: "cBLUE"Нет"cWHITE"\n" );
							
							format:g_small_string( "Патроны: "cBLUE"%d", BagInv[bag_id][i][inv_param_1] );
							strcat( g_big_string, g_small_string );
						}
						else if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_WARECAR )
						{
							if( CarInv[car_id][i][inv_param_2] > INVALID_PARAM )
							{
								format:g_small_string( "\n\nЛицензия: "cBLUE"#%d"cWHITE"\n", CarInv[car_id][i][inv_param_2] );
								strcat( g_big_string, g_small_string );
							}
							else if( CarInv[car_id][i][inv_param_2] == INDEX_FRACTION )
								strcat( g_big_string, "\n\nЛицензия: "cBLUE"Государственное"cWHITE"\n" );
							else
								strcat( g_big_string, "\n\nЛицензия: "cBLUE"Нет"cWHITE"\n" );
							
							format:g_small_string( "Патроны: "cBLUE"%d", CarInv[car_id][i][inv_param_1] );
							strcat( g_big_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
					
					updateSelect( playerid, invSelect[playerid], 0 );
					updateWareHouseSelect( playerid, car_id, invSelect[playerid], 0, TYPE_WARECAR );
					SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
					SetPVarInt( playerid, "Inv:Type", INVALID_PARAM );
					
					SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
					SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
					SetPVarInt( playerid, "UseInv:Select", INVALID_PARAM );
					SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
				}
				
				case 1 : 
				{
					if( GetPVarInt( playerid, "Inv:Type" ) != TYPE_USE )
					{
						SendClient:( playerid, C_WHITE, ""gbDefault"Предмет должен находиться в активном слоте, для выполнения данного действия.");
					
						updateSelect( playerid, invSelect[playerid], 0 );
						SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
						SetPVarInt( playerid, "Inv:Type", INVALID_PARAM );
					}
					else
					{
						showPlayerDialog( playerid, d_inv_attach + 3, DIALOG_STYLE_LIST, " ",
						""cBLUE"-"cWHITE" Редактировать положение\n\
						 "cBLUE"-"cWHITE" Сбросить положение",
						"Далее", "Назад" );
					}
				}
				
				case 2 : 
				{
					if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_USE )
						return SendClientMessage( playerid, C_WHITE, USE_ACTIVE_SLOT_ACTION );
						
					new 
						i = GetPVarInt( playerid, "Inv:OldSelect" ),
						id;
						
					if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_INV )
						id = getInventoryId( PlayerInv[playerid][i][inv_id] );
					else if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_BAG )
						id = getInventoryId( BagInv[getUseBagId( playerid )][i][inv_id] );
					else 
						return SendClientMessage( playerid, C_WHITE, ""gbError"Вы не можете удалить данный предмет." );
						
					clean_array();
					if( PlayerInv[playerid][i][inv_amount] == 1 ) 
					{
						strcat( g_big_string, ""gbDefault"Удаление предмета.\n\n");
						format:g_small_string(  "Вы действительно хотите удалить "cBLUE"%s"cWHITE" из инвентаря?", inventory[id][i_name] ), strcat( g_big_string, g_small_string );
						showPlayerDialog( playerid, d_inv_settings + 1, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Да", "Нет" );
					} 
					else 
					{
						strcat( g_big_string, ""gbDefault"Удаление предмета.\n\n");
						format:g_small_string(  "Вы действительно хотите удалить "cBLUE"%s"cWHITE" из инвентаря?\n\n", inventory[id][i_name] ), strcat( g_big_string, g_small_string );
						strcat( g_big_string, "Введите количество предмета, которое Вы хотите удалить:" );
						showPlayerDialog( playerid, d_inv_settings + 2, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
				}
			}
			return 1;
		}
		
		case d_inv_settings + 1 : 
		{
			if( response ) 
			{
				new
					i = GetPVarInt( playerid, "Inv:OldSelect" ),
					type =  GetPVarInt( playerid, "Inv:Type" ),
					id,
					number;
				
				if( type == TYPE_INV )
				{
					id = getInventoryId( PlayerInv[playerid][i][inv_id] );
					number = PlayerInv[playerid][i][inv_param_2];
					
					if( isnullSlot( TYPE_INV, playerid, i ) )
						return 1;
				}
				else if( type == TYPE_BAG )
				{
					id = getInventoryId( BagInv[getUseBagId( playerid )][i][inv_id] );
					number = BagInv[getUseBagId( playerid )][i][inv_param_2];
					
					if( isnullSlot( TYPE_BAG, playerid, i ) )
						return 1;
				}
				
				if( removeItem( playerid, i, 1, type ) ) 
				{
					if( inventory[id][i_type] == INV_PHONE )
						DeletePhone( playerid, number );
				
					format:g_small_string(  ""gbDefault"Вы удалили предмет - "cBLUE"%s"cWHITE" из инвентаря.", 
						inventory[id][i_name]
					);
					
					SendClientMessage( playerid, C_WHITE, g_small_string );
					
					format:g_small_string( "(( Игрок удалил предмет '%s' ))",
						inventory[id][i_name]
					);
					SetPlayerChatBubble( playerid, g_small_string, 0xFFFFFF50, 25.0, 2000 );
					
					DeletePVar( playerid, "Inv:OldSelect" );
					DeletePVar( playerid, "Inv:Type" );
				}
			}
			else
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:Type", INVALID_PARAM );
			}
			
			return 1;
		}
		case d_inv_settings + 2 : 
		{
		
			if( response ) 
			{
				new
					i = GetPVarInt( playerid, "Inv:OldSelect" ),
					id,
					itemid,
					itemamount;
				
				if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_INV )
				{
					id = getInventoryId( PlayerInv[playerid][i][inv_id] );
					itemid = PlayerInv[playerid][i][inv_id],
					itemamount = PlayerInv[playerid][i][inv_amount];
				}
				else if( GetPVarInt( playerid, "Inv:Type" ) == TYPE_BAG )
				{
					new 
						bag_id = getUseBagId( playerid );
						
					id = getInventoryId( BagInv[bag_id][i][inv_id] );
					itemid = BagInv[bag_id][i][inv_id];
					itemamount = BagInv[bag_id][i][inv_amount];
				}
					
				if( inputtext[0] == EOS ) 
				{
					strcat( g_big_string, ""gbDefault"Удаление предмета.\n\n");
					format:g_small_string(  "Вы действительно хотите удалить "cBLUE"%s"cWHITE" из инвентаря?\n\n", inventory[id][i_name] ), strcat( g_big_string, g_small_string );
					strcat( g_big_string, "Введите количество, которое Вы хотите удалить:" );
					return showPlayerDialog( playerid, d_inv_settings + 2, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
				}
				
				if( !IsNumeric( inputtext ) )
				{
					strcat( g_big_string, ""gbDefault"Удаление предмета.\n\n");
					format:g_small_string(  "Вы действительно хотите удалить "cBLUE"%s"cWHITE" из инвентаря?\n\n", inventory[id][i_name] ), strcat( g_big_string, g_small_string );
					strcat( g_big_string, "Введите количество, которое Вы хотите удалить:" );
					return showPlayerDialog( playerid, d_inv_settings + 2, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
				}
				
				if( itemamount == 0 && itemid == 0 )
					return 1;
				
				if( itemamount < strval( inputtext ) || strval( inputtext ) < 1 ) 
				{
					strcat( g_big_string, ""gbDefault"Удаление предмета.\n\n");
					format:g_small_string(  "Вы действительно хотите удалить "cBLUE"%s"cWHITE" из инвентаря?\n\n", inventory[id][i_name] ), strcat( g_big_string, g_small_string );
					strcat( g_big_string, ""gbError"Введите корректное количество предмета.\n" );
					strcat( g_big_string, "Введите количество, которое Вы хотите удалить:" );
					return showPlayerDialog( playerid, d_inv_settings + 2, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
				}
			
				if( removeItem( playerid, i, strval( inputtext ), GetPVarInt( playerid, "Inv:Type" ) ) ) 
				{
					format:g_small_string(  ""gbDefault"Вы удалили предмет - "cBLUE"%s"cWHITE" (Количество: "cBLUE"%d"cWHITE") из инвентаря.", 
						inventory[id][i_name],
						strval( inputtext )
					);
					
					SendClientMessage( playerid, C_WHITE, g_small_string );
					
					format:g_small_string( "(( Игрок удалил предмет '%s' ))",
						inventory[id][i_name]
					);
					
					SetPlayerChatBubble( playerid, g_small_string, 0xFFFFFF20, 25.0, 5000 );
					
					SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
					DeletePVar( playerid, "Inv:Type" );
				}
			}
			else
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:Type", INVALID_PARAM );
			}
		}
		
		case d_inv_settings + 3 :
		{
			if( response )
			{
				new 
					bag_id = getUseBagId( playerid ),
					i = GetPVarInt( playerid, "Inv:OldSelect" ),
					id = getInventoryId( BagInv[bag_id][i][inv_id] ),
					type = GetPVarInt( playerid, "Inv:Moreamount");
				
				if( type )
				{
					if( inputtext[0] == EOS )
					{
						clean:<g_big_string>;
						strcat( g_big_string, ""gbDefault"Выбрасывание предмета.\n\n" );
						format:g_small_string("Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?\n\nВведите количество предмета, которое хотите выбросить:",
							inventory[id][i_name]
						);
						
						strcat( g_big_string, g_small_string );
					
						return showPlayerDialog( playerid,  d_inv_settings + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
					
					if( !IsNumeric( inputtext ) )
					{
						clean:<g_big_string>;
						strcat( g_big_string, ""gbDefault"Выбрасывание предмета.\n\n" );
						format:g_small_string("Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?\n\nВведите количество предмета, которое хотите выбросить:",
							inventory[id][i_name]
						);
						
						strcat( g_big_string, g_small_string );
					
						return showPlayerDialog( playerid,  d_inv_settings + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
					
					if( isnullSlot( TYPE_BAG, playerid, i ) )
						return 1;
					
					if( GetPlayerInterior( playerid ) != 0 && Player[playerid][uDMJail] != 0 )
						return SendClientMessage( playerid, C_WHITE, !""gbError"Вы не можете выбросить предмет в текущем месте.");
					
					if( BagInv[bag_id][i][inv_amount] < strval( inputtext ) || strval( inputtext ) < 0 )
					{
						clean:<g_big_string>;
						strcat( g_big_string, ""gbDefault"Выбрасывание предмета.\n\n" );
						format:g_small_string("Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?\n\n"gbError"Введите корректное количество предмета.\n Введите количество предмета, которое хотите выбросить:",
							inventory[id][i_name]
						);
						strcat( g_big_string, g_small_string );
					
						return showPlayerDialog( playerid,  d_inv_settings + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
					
					if( dropItem( playerid, i, strval( inputtext ), TYPE_BAG ) )
					{
						SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
						DeletePVar( playerid, "Inv:Moreamount" );
					}
				}
				else
				{
					if( dropItem( playerid, i, 1, TYPE_BAG ) )
					{
						SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
						DeletePVar( playerid, "Inv:Moreamount" );
					}
				}
			}
			else
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				return 1;
			}
		}
		
		case d_inv_settings + 4 :
		{
			if( response )
			{
				new 
					i = GetPVarInt( playerid, "Inv:OldSelect" ),
					id = getInventoryId( PlayerInv[playerid][i][inv_id] ),
					type = GetPVarInt( playerid, "Inv:Moreamount");
				
				if( type )
				{
					if( inputtext[0] == EOS )
					{
						clean:<g_big_string>;
						strcat( g_big_string, ""gbDefault"Выбрасывание предмета.\n\n" );
						format:g_small_string("Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?\n\nВведите количество предмета, которое хотите выбросить:",
							inventory[id][i_name]
						);
						
						strcat( g_big_string, g_small_string );
					
						return showPlayerDialog( playerid,  d_inv_settings + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
					
					if( !IsNumeric( inputtext ) )
					{
						clean:<g_big_string>;
						strcat( g_big_string, ""gbDefault"Выбрасывание предмета.\n\n" );
						format:g_small_string("Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?\n\nВведите количество предмета, которое хотите выбросить:",
							inventory[id][i_name]
						);
						
						strcat( g_big_string, g_small_string );
					
						return showPlayerDialog( playerid,  d_inv_settings + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
					
					if( isnullSlot( TYPE_INV, playerid, i ) )
						return 1;
					
					if( GetPlayerInterior( playerid ) != 0 && Player[playerid][uDMJail] != 0 )
						return SendClientMessage( playerid, C_WHITE, !""gbError"Вы не можете выбросить предмет в текущем месте.");
					
					if( PlayerInv[playerid][i][inv_amount] < strval( inputtext ) || strval( inputtext ) < 0 )
					{
						clean:<g_big_string>;
						strcat( g_big_string, ""gbDefault"Выбрасывание предмета.\n\n" );
						format:g_small_string("Вы действительно хотите выбросить предмет "cBLUE"%s"cWHITE"?\n\n"gbError"Введите корректное количество предмета.\n Введите количество предмета, которое хотите выбросить:",
							inventory[id][i_name]
						);
						strcat( g_big_string, g_small_string );
					
						return showPlayerDialog( playerid,  d_inv_settings + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
					
					if( dropItem( playerid, i, strval( inputtext ), TYPE_INV ) )
					{
						SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
						DeletePVar( playerid, "Inv:Moreamount" );
					}
				}
				else
				{
					if( dropItem( playerid, i, 1, TYPE_INV ) )
					{
						SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
						DeletePVar( playerid, "Inv:Moreamount" );
					}
				}
			}
			else
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				return 1;
			}
		}

		// Передача с сумки
		case d_inv_settings + 5 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				updateSelect( playerid, invSelect[playerid], 0 );
				return 1;
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				bag_id = getUseBagId( playerid ),
				id = getInventoryId( BagInv[bag_id][i][inv_id] );
			
			if( isnullSlot( TYPE_BAG, playerid, i ) )
				return SendClient:( playerid, C_WHITE, !TRANSFER_IS_BROKEN );
			
			if( CheckTransferInput( playerid, inputtext, d_inv_settings + 5, id ) == STATUS_ERROR )
				return 1;
				
			if( BagInv[bag_id][i][inv_param_2] == INDEX_FRACTION && Player[playerid][uMember] != Player[ strval(inputtext) ][uMember] || !Player[ strval(inputtext) ][uMember] )
			{
				clean:<g_big_string>;
				strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
				
				format:g_small_string( ""cWHITE"Введите id игрока, которому Вы хотите передать предмет "cBLUE"%s"cWHITE":\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы не можете передать данный предмет этому игроку.",
					inventory[id][i_name]
				);
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			
			if(	checkMass( strval( inputtext ) ) + inventory[id][i_mass] > checkMaxMass( strval( inputtext ) ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_MASS_ON_TARGET );
			}
			else if( BagInv[bag_id][i][inv_amount] > 1 )
			{
				SetPVarInt( playerid, "Inv:GivePlayerId", strval( inputtext ) );
				clean:<g_big_string>;
				strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
				
				format:g_small_string( ""cWHITE"Укажите количество предмета "cBLUE"%s"cWHITE" передаваемое игроку "cBLUE"%s[%d]"cWHITE":",
					inventory[id][i_name],
					GetAccountName( strval( inputtext ) ),
					strval( inputtext )
				);
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( playerid,  d_inv_settings + 7, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			else
			{
				SetPVarInt( strval( inputtext ), "Inv:PlayerId", playerid );
				SetPVarInt( playerid, "Inv:GivePlayerId", strval( inputtext ) );
			
				SetPVarInt( playerid, "Inv:amount", 1 );

				format:g_small_string( OFFERED_TRANSFER,
					GetAccountName( strval( inputtext ) ),
					strval( inputtext ),
					inventory[id][i_name],
					GetPVarInt( playerid, "Inv:amount" )
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
				
				clean:<g_big_string>;
				strcat( g_big_string, ""gbDefault"Предложение от игрока.\n\n" );
	
				format:g_small_string( "Игрок "cBLUE"%s[%d]"cWHITE" предлагает передать Вам предмет "cBLUE"%s"cWHITE" (Количество: "cBLUE"1"cWHITE").\n\n\
					"gbDialog"Ваши действия?",
					GetAccountName( playerid ),
					playerid,
					inventory[id][i_name]
				);
				
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( strval( inputtext ),  d_inv_settings + 6, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Принять", "Отклонить" );
			}
		}
		
		// Результат передачи с сумки
		case d_inv_settings + 6 :
		{
			new
				giveplayerid = GetPVarInt( playerid, "Inv:PlayerId" ),
				i = GetPVarInt( giveplayerid, "Inv:OldSelect" ),
				bag_id = getUseBagId( giveplayerid ),
				amount = GetPVarInt( giveplayerid, "Inv:amount" );
			
			if( isnullSlot( TYPE_BAG, giveplayerid, i ) )
			{
				SetPVarInt( giveplayerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
				SetPVarInt( giveplayerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:PlayerId", INVALID_PARAM );
				DeletePVar( giveplayerid, "Inv:amount");
				return SendClient:( playerid, C_WHITE, !TRANSFER_IS_BROKEN );
			}
			
			if( response )
			{
				format:g_small_string( TRANSFER_ITEM_ACCEPT,
					GetAccountName( playerid ),
					playerid
				);
				
				SendClient:( giveplayerid, C_WHITE, g_small_string );
					
				format:g_small_string( TAKE_ITEM_ACCEPT,
					GetAccountName( giveplayerid ),
					giveplayerid
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
		
				if( giveItem( playerid, BagInv[bag_id][i][inv_id], amount, BagInv[bag_id][i][inv_param_1], BagInv[bag_id][i][inv_param_2] ) )
				{
					if( inventory[BagInv[bag_id][i][inv_id]][i_type] == INV_PHONE )
					{
						UpdateUserPhone( Player[playerid][uID], BagInv[bag_id][i][inv_param_2] );
						ClearPhoneNumber( giveplayerid, BagInv[bag_id][i][inv_param_2] );
					}
				
					removeItem( giveplayerid, i, amount, TYPE_BAG );
					
					format:g_small_string( "передал%s что-то %s",
						Player[giveplayerid][uSex] == 2 ? ("а") : (""),
						GetAccountName( playerid )
					);
					
					SendRolePlayAction( giveplayerid, g_small_string, RP_TYPE_AME );
					
					format:g_small_string( "взял%s что-то от %s",
						Player[playerid][uSex] == 2 ? ("а") : (""),
						GetAccountName( giveplayerid )
					);
					
					SendRolePlayAction( playerid, g_small_string, RP_TYPE_AME );
				}
			}
			else
			{
				format:g_small_string( TRANSFER_ITEM_CANCEL,
					GetAccountName( playerid ),
					playerid
				);
				
				SendClient:( giveplayerid, C_WHITE, g_small_string );
					
				format:g_small_string( TAKE_ITEM_CANCEL,
					GetAccountName( giveplayerid ),
					giveplayerid
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
			}

			SetPVarInt( giveplayerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
			SetPVarInt( giveplayerid, "Inv:OldSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:PlayerId", INVALID_PARAM );
			DeletePVar( giveplayerid, "Inv:amount");
		}
		
		// Передача с количеством с сумки
		case d_inv_settings + 7 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				updateSelect( playerid, invSelect[playerid], 0 );
				return 1;
			}
			
			new
				giveplayerid = GetPVarInt( playerid, "Inv:GivePlayerId" ),
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				bag_id = getUseBagId( playerid ),
				id = getInventoryId( BagInv[bag_id][i][inv_id] );
				
			if( isnullSlot( TYPE_BAG, giveplayerid, i ) )
			{
				SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				updateSelect( playerid, invSelect[playerid], 0 );
				return SendClient:( playerid, C_WHITE, !TRANSFER_IS_BROKEN );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) )
			{
				clean:<g_big_string>;
				strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
				
				format:g_small_string( ""cWHITE"Укажите количество предмета "cBLUE"%s"cWHITE" передаваемое игроку "cBLUE"%s[%d]"cWHITE":",
					inventory[id][i_name],
					GetAccountName( giveplayerid ),
					giveplayerid
				);
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( playerid,  d_inv_settings + 7, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			
			if( BagInv[bag_id][i][inv_amount] < strval( inputtext) )
			{
				clean:<g_big_string>;
				strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
				
				format:g_small_string( ""cWHITE"Укажите количество предмета "cBLUE"%s"cWHITE" передаваемое игроку "cBLUE"%s[%d]"cWHITE":\n\n\
				"gbDialogError"Вы указали некорректное количество предмета.",
					inventory[id][i_name],
					GetAccountName( giveplayerid ),
					giveplayerid
				);
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( playerid,  d_inv_settings + 7, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			
			SetPVarInt( giveplayerid, "Inv:PlayerId", playerid );
			SetPVarInt( playerid, "Inv:amount", strval( inputtext ) );
			
			format:g_small_string( OFFERED_TRANSFER,
				GetAccountName( giveplayerid ),
				giveplayerid,
				inventory[id][i_name],
				strval( inputtext )
			);
			SendClient:( playerid, C_WHITE, g_small_string );
			
			clean:<g_big_string>;
			strcat( g_big_string, ""gbDefault"Предложение от игрока.\n\n" );

			format:g_small_string( "Игрок "cBLUE"%s[%d]"cWHITE" предлагает передать Вам предмет "cBLUE"%s"cWHITE" (Количество: "cBLUE"%d"cWHITE").\n\n\
			"gbDialog"Ваши действия?",
				GetAccountName( playerid ),
				playerid,
				inventory[id][i_name],
				strval( inputtext )
			);
			
			strcat( g_big_string, g_small_string );
			
			return showPlayerDialog( giveplayerid,  d_inv_settings + 6, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Принять", "Отклонить" );
			
		}
		
		// Передача предмета с инвентаря
		case d_inv_settings + 8 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				updateSelect( playerid, invSelect[playerid], 0 );
				return 1;
			}
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				id = getInventoryId( PlayerInv[playerid][i][inv_id] );
				
			if( isnullSlot( TYPE_INV, playerid, i ) )
				return SendClient:( playerid, C_WHITE, !TRANSFER_IS_BROKEN );
			
			if( CheckTransferInput( playerid, inputtext, d_inv_settings + 8, id ) == STATUS_ERROR )
				return 1;
			
			if( PlayerInv[playerid][i][inv_param_2] == INDEX_FRACTION && Player[playerid][uMember] != Player[ strval(inputtext) ][uMember] || !Player[ strval(inputtext) ][uMember] )
			{
				clean:<g_big_string>;
				strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
				
				format:g_small_string( ""cWHITE"Введите id игрока, которому Вы хотите передать предмет "cBLUE"%s"cWHITE":\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы не можете передать данный предмет этому игроку.",
					inventory[id][i_name]
				);
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			
			if(	checkMass( strval( inputtext ) ) + inventory[id][i_mass] > checkMaxMass( strval( inputtext ) ) )
			{
				return SendClient:( playerid, C_WHITE, !MAX_MASS_ON_TARGET );
			}
			else if( PlayerInv[playerid][i][inv_amount] > 1 )
			{
				SetPVarInt( playerid, "Inv:GivePlayerId", strval( inputtext ) );
				
				clean:<g_big_string>;
				strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
				
				format:g_small_string( ""cWHITE"Укажите количество предмета "cBLUE"%s"cWHITE" передаваемое игроку "cBLUE"%s[%d]"cWHITE":",
					inventory[id][i_name],
					GetAccountName( strval( inputtext ) ),
					strval( inputtext )
				);
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( playerid,  d_inv_settings + 10, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			else
			{
				SetPVarInt( strval( inputtext ), "Inv:PlayerId", playerid );
				SetPVarInt( playerid, "Inv:GivePlayerId", strval( inputtext ) );
				SetPVarInt( playerid, "Inv:amount", 1 );
				
				format:g_small_string( OFFERED_TRANSFER,
					GetAccountName( strval( inputtext ) ),
					strval( inputtext ),
					inventory[id][i_name],
					GetPVarInt( playerid, "Inv:amount" )
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
				
				clean:<g_big_string>;
				strcat( g_big_string, ""gbDefault"Предложение от игрока.\n\n" );
	
				format:g_small_string( "Игрок "cBLUE"%s[%d]"cWHITE" предлагает передать Вам предмет "cBLUE"%s"cWHITE".\n\n\
					"gbDialog"Ваши действия?",
					GetAccountName( playerid ),
					playerid,
					inventory[id][i_name]
				);
				
				strcat( g_big_string, g_small_string );
				showPlayerDialog( strval( inputtext ),  d_inv_settings + 9, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Принять", "Отклонить" );
			}
		}
		
		// Результат передачи с инвентаря
		case d_inv_settings + 9 :
		{
			new
				giveplayerid = GetPVarInt( playerid, "Inv:PlayerId" ),
				i = GetPVarInt( giveplayerid, "Inv:OldSelect" ),
				amount = GetPVarInt( giveplayerid, "Inv:amount" );
				
			if( isnullSlot( TYPE_INV, giveplayerid, i ) )
			{
				SetPVarInt( giveplayerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
				DeletePVar( giveplayerid, "Inv:amount");
				SetPVarInt( giveplayerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:PlayerId", INVALID_PARAM );
				return SendClient:( playerid, C_WHITE, !TRANSFER_IS_BROKEN );
			}
			
			if( response )
			{
				format:g_small_string( TRANSFER_ITEM_ACCEPT,
					GetAccountName( playerid ),
					playerid
				);
				
				SendClient:( giveplayerid, C_WHITE, g_small_string );
					
				format:g_small_string( TAKE_ITEM_ACCEPT,
					GetAccountName( giveplayerid ),
					giveplayerid
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
				
				// Inv:BagId
				
				if( getItemType( giveplayerid, i, TYPE_INV ) == INV_BAG )
				{
					for( new j; j != MAX_BAGS; j++ )
					{
						if( PlayerInv[giveplayerid][i][inv_bd] == g_bags[j] )
						{
							SetPVarInt( playerid, "Inv:BagId", j );
							
							break;
						}
					}
				}
				else
				{
					SetPVarInt( playerid, "Inv:BagId", INVALID_PARAM );
				}
				
				if( giveItem( playerid, PlayerInv[giveplayerid][i][inv_id], amount, PlayerInv[giveplayerid][i][inv_param_1], PlayerInv[giveplayerid][i][inv_param_2] ) )
				{
					removeItem( giveplayerid, i, amount );
					
					format:g_small_string( "передал%s что-то %s",
						SexTextEnd( giveplayerid ),
						GetAccountName( playerid )
					);
					
					SendRolePlayAction( giveplayerid, g_small_string, RP_TYPE_AME );
					
					format:g_small_string( "взял%s что-то от %s",
						SexTextEnd( playerid ),
						GetAccountName( giveplayerid )
					);
					
					SendRolePlayAction( playerid, g_small_string, RP_TYPE_AME );
				}
			}
			else
			{
				format:g_small_string( TRANSFER_ITEM_CANCEL,
					GetAccountName( playerid ),
					playerid
				);
				
				SendClient:( giveplayerid, C_WHITE, g_small_string );
					
				format:g_small_string( TAKE_ITEM_CANCEL,
					GetAccountName( giveplayerid ),
					giveplayerid
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
			}
			
			SetPVarInt( giveplayerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
			SetPVarInt( giveplayerid, "Inv:OldSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:PlayerId", INVALID_PARAM );
			DeletePVar( giveplayerid, "Inv:amount");
		}
		
		// Передача с количеством из инвентаря
		case d_inv_settings + 10 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				updateSelect( playerid, invSelect[playerid], 0 );
				return 1;
			}
			
			new
				giveplayerid = GetPVarInt( playerid, "Inv:GivePlayerId" ),
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				id = getInventoryId( PlayerInv[playerid][i][inv_id] );
				
			if( isnullSlot( TYPE_INV, giveplayerid, i ) )
			{
				SetPVarInt( playerid, "Inv:GivePlayerId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				updateSelect( playerid, invSelect[playerid], 0 );
				return SendClient:( playerid, C_WHITE, !TRANSFER_IS_BROKEN );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) )
			{
				clean:<g_big_string>;
				strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
				
				format:g_small_string( ""cWHITE"Укажите количество предмета "cBLUE"%s"cWHITE" передаваемое игроку "cBLUE"%s[%d]"cWHITE":",
					inventory[id][i_name],
					GetAccountName( giveplayerid ),
					giveplayerid
				);
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( playerid,  d_inv_settings + 10, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			
			if( PlayerInv[playerid][i][inv_amount] < strval( inputtext) )
			{
				clean:<g_big_string>;
				strcat( g_big_string, ""cBLUE"Передача предмета\n\n" );
				
				format:g_small_string( ""cWHITE"Укажите количество предмета "cBLUE"%s"cWHITE" передаваемое игроку "cBLUE"%s[%d]"cWHITE":\n\n\
				"gbDialogError"Вы указали некорректное количество предмета.",
					inventory[id][i_name],
					GetAccountName( giveplayerid ),
					giveplayerid
				);
				strcat( g_big_string, g_small_string );
				return showPlayerDialog( playerid,  d_inv_settings + 10, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			
			SetPVarInt( giveplayerid, "Inv:PlayerId", playerid );
			SetPVarInt( playerid, "Inv:amount", strval( inputtext ) );
			
			format:g_small_string( OFFERED_TRANSFER,
				GetAccountName( giveplayerid ),
				giveplayerid,
				inventory[id][i_name],
				strval( inputtext )
			);
			SendClient:( playerid, C_WHITE, g_small_string );
			
			clean:<g_big_string>;
			strcat( g_big_string, ""gbDefault"Предложение от игрока.\n\n" );

			format:g_small_string( "Игрок "cBLUE"%s[%d]"cWHITE" предлагает передать Вам предмет "cBLUE"%s"cWHITE" (Количество: "cBLUE"%d"cWHITE").\n\n\
			"gbDialog"Ваши действия?",
				GetAccountName( playerid ),
				playerid,
				inventory[id][i_name],
				strval( inputtext )
			);
			
			strcat( g_big_string, g_small_string );
			
			return showPlayerDialog( giveplayerid,  d_inv_settings + 9, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Принять", "Отклонить" );
			
		}
		
		case d_inv :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				select = GetPVarInt( playerid, "Inv:NewSelect" );
				
				
			SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			
			if( isnullSlot( TYPE_INV, playerid, select ) )
				return 1;
			
			switch( listitem )
			{
				case 1 :
				{
					UseInv[playerid][i][inv_type] = TYPE_USE;
					UseInv[playerid][i][inv_active_type] = STATE_DEFAULT;
					UseInv[playerid][i][inv_slot] = i;
					UseInv[playerid][i][inv_pos_x] = PlayerInv[playerid][select][inv_pos_x];
					UseInv[playerid][i][inv_pos_y] = PlayerInv[playerid][select][inv_pos_y];
					UseInv[playerid][i][inv_pos_z] = PlayerInv[playerid][select][inv_pos_z];
					UseInv[playerid][i][inv_rot_x] = PlayerInv[playerid][select][inv_rot_x];
					UseInv[playerid][i][inv_rot_y] = PlayerInv[playerid][select][inv_rot_y];
					UseInv[playerid][i][inv_rot_z] = PlayerInv[playerid][select][inv_rot_z];
					UseInv[playerid][i][inv_scale_x] = PlayerInv[playerid][select][inv_scale_x];
					UseInv[playerid][i][inv_scale_y] = PlayerInv[playerid][select][inv_scale_y];
					UseInv[playerid][i][inv_scale_z] = PlayerInv[playerid][select][inv_scale_z];
					UseInv[playerid][i][inv_bone] = PlayerInv[playerid][select][inv_bone];
					UseInv[playerid][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
					UseInv[playerid][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
					UseInv[playerid][i][inv_id] = PlayerInv[playerid][select][inv_id];
					
					PlayerInv[playerid][select][inv_amount]--;
					
					if( PlayerInv[playerid][select][inv_amount] < 1 ) 
					{
						UseInv[playerid][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
						saveInventory( playerid, i, INV_UPDATE, I_TO_U );
						
						clearSlot( playerid, select, TYPE_INV );
					}	
					else
					{
						saveInventory( playerid, select, INV_UPDATE, UPD_I );
						saveInventory( playerid, i, INV_INSERT, TYPE_USE );
					}
					
					UseInv[playerid][i][inv_amount] = 1;

					if( GetPVarInt( playerid, "Inv:Show" ) )
					{
						updateImages( playerid, select, TYPE_INV );
						updateAmount( playerid, select, TYPE_INV );
						
						updateImages( playerid, i, TYPE_USE );
						updateAmount( playerid, i, TYPE_USE );
						
						updateSelect( playerid, invSelect[playerid], 0 );
					}
					
					SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );

					updateMass( playerid );
					
					useItem( playerid, i );
				}
			
				case 2 :
				{
					if( isSavedAttachObject( TYPE_INV, playerid, select ) )
					{
						UseInv[playerid][i][inv_type] = TYPE_USE;
						UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
						UseInv[playerid][i][inv_slot] = i;
						UseInv[playerid][i][inv_pos_x] = PlayerInv[playerid][select][inv_pos_x];
						UseInv[playerid][i][inv_pos_y] = PlayerInv[playerid][select][inv_pos_y];
						UseInv[playerid][i][inv_pos_z] = PlayerInv[playerid][select][inv_pos_z];
						UseInv[playerid][i][inv_rot_x] = PlayerInv[playerid][select][inv_rot_x];
						UseInv[playerid][i][inv_rot_y] = PlayerInv[playerid][select][inv_rot_y];
						UseInv[playerid][i][inv_rot_z] = PlayerInv[playerid][select][inv_rot_z];
						UseInv[playerid][i][inv_scale_x] = PlayerInv[playerid][select][inv_scale_x];
						UseInv[playerid][i][inv_scale_y] = PlayerInv[playerid][select][inv_scale_y];
						UseInv[playerid][i][inv_scale_z] = PlayerInv[playerid][select][inv_scale_z];
						UseInv[playerid][i][inv_bone] = PlayerInv[playerid][select][inv_bone];
						UseInv[playerid][i][inv_param_1] = PlayerInv[playerid][select][inv_param_1];
						UseInv[playerid][i][inv_param_2] = PlayerInv[playerid][select][inv_param_2];
						UseInv[playerid][i][inv_id] = PlayerInv[playerid][select][inv_id];
						
						PlayerInv[playerid][select][inv_amount]--;
						
						if( PlayerInv[playerid][select][inv_amount] < 1 ) 
						{
							UseInv[playerid][i][inv_bd] = PlayerInv[playerid][select][inv_bd];
							
							saveInventory( playerid, i, INV_UPDATE, I_TO_U );
							
							clearSlot( playerid, select, TYPE_INV );
						}	
						else
						{
							saveInventory( playerid, select, INV_UPDATE, UPD_U );
							saveInventory( playerid, i, INV_INSERT, TYPE_USE );
						}
	
						UseInv[playerid][i][inv_amount] = 1;

						if( GetPVarInt( playerid, "Inv:Show" ) )
						{
							updateImages( playerid, select, TYPE_INV );
							updateAmount( playerid, select, TYPE_INV );

							updateImages( playerid, i, TYPE_USE );
							updateAmount( playerid, i, TYPE_USE );
							
							updateSelect( playerid, invSelect[playerid], 0 );
							invSelect[playerid] = INVALID_PTD;
						}
						
						SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
						
						useItem( playerid, i, STATE_ATTACH );
						
						SendClient:( playerid, C_WHITE, ""gbSuccess"Данный предмет успешно прикреплён к Вашему персонажу." );
					}
					else
					{
						showPlayerDialog( playerid, d_inv_attach + 1, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
					}
				}
				
				default :		
				{
					showPlayerDialog( playerid, d_inv, DIALOG_STYLE_LIST, " ", 
							""gbDialog"Выберите действие с предметом:\n\
							"cBLUE"-"cWHITE" Взять в руки\n\
							"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
				}
			}
		}
		
		case d_inv_attach + 1 :
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_inv, DIALOG_STYLE_LIST, " ", 
					""gbDialog"Выберите действие с предметом:\n\
					"cBLUE"-"cWHITE" Взять в руки\n\
					"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
			}
			
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 1, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад");
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				id = getInventoryId( PlayerInv[playerid][GetPVarInt( playerid, "Inv:NewSelect")][inv_id] );
				
			if( isnullSlot( TYPE_INV, playerid, GetPVarInt( playerid, "Inv:NewSelect") ) )
				return 1;
			
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachSelectSlot", GetPVarInt( playerid, "Inv:NewSelect") );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_INV );
			
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					inventory[id][i_model], 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					1
			);
			
			SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );	
		}
		
		case d_inv + 1 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				select = GetPVarInt( playerid, "Inv:NewSelect" ),
				bag_id = getUseBagId( playerid );
				
			SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );
			
			if( isnullSlot( TYPE_BAG, playerid, select ) )
				return 1;
			
			switch( listitem )
			{
				case 1 :
				{
					UseInv[playerid][i][inv_type] = TYPE_USE;
					UseInv[playerid][i][inv_active_type] = STATE_DEFAULT;
					UseInv[playerid][i][inv_slot] = i;
					UseInv[playerid][i][inv_pos_x] = BagInv[bag_id][select][inv_pos_x];
					UseInv[playerid][i][inv_pos_y] = BagInv[bag_id][select][inv_pos_y];
					UseInv[playerid][i][inv_pos_z] = BagInv[bag_id][select][inv_pos_z];
					UseInv[playerid][i][inv_rot_x] = BagInv[bag_id][select][inv_rot_x];
					UseInv[playerid][i][inv_rot_y] = BagInv[bag_id][select][inv_rot_y];
					UseInv[playerid][i][inv_rot_z] = BagInv[bag_id][select][inv_rot_z];
					UseInv[playerid][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
					UseInv[playerid][i][inv_scale_y] = BagInv[bag_id][select][inv_scale_y];
					UseInv[playerid][i][inv_scale_z] = BagInv[bag_id][select][inv_scale_z];
					UseInv[playerid][i][inv_bone] = BagInv[bag_id][select][inv_bone];
					UseInv[playerid][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
					UseInv[playerid][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];
					
					UseInv[playerid][i][inv_id] = BagInv[bag_id][select][inv_id];
					
					BagInv[bag_id][select][inv_amount]--;
					
					if( BagInv[bag_id][select][inv_amount] < 1 ) 
					{
						UseInv[playerid][i][inv_bd] = BagInv[bag_id][select][inv_bd];
						
						saveInventory( playerid, i, INV_UPDATE, B_TO_U );
						clearSlot( bag_id, select, TYPE_BAG );
					}	
					else
					{
						saveInventory( playerid, select, INV_UPDATE, UPD_B );
						updateSelect( playerid, bagSlot[playerid][select], 0 );
						
						saveInventory( playerid, i, INV_INSERT, TYPE_USE );
					}

					UseInv[playerid][i][inv_amount] = 1;
					
					if( GetPVarInt( playerid, "Inv:Show" ) )
					{
						updateImages( playerid, select, TYPE_BAG );
						updateAmount( playerid, select, TYPE_BAG );

						updateImages( playerid, i, TYPE_USE );
						updateAmount( playerid, i, TYPE_USE );
						
						updateSelect( playerid, invSelect[playerid], 0 );
					}

					SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );

					updateMass( playerid );
					
					useItem( playerid, i );
				}
			
				case 2 :
				{
					if( isSavedAttachObject( TYPE_BAG, playerid, select ) )
					{
						UseInv[playerid][i][inv_type] = TYPE_USE;
						UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
						UseInv[playerid][i][inv_slot] = i;
						UseInv[playerid][i][inv_pos_x] = BagInv[bag_id][select][inv_pos_x];
						UseInv[playerid][i][inv_pos_y] = BagInv[bag_id][select][inv_pos_y];
						UseInv[playerid][i][inv_pos_z] = BagInv[bag_id][select][inv_pos_z];
						UseInv[playerid][i][inv_rot_x] = BagInv[bag_id][select][inv_rot_x];
						UseInv[playerid][i][inv_rot_y] = BagInv[bag_id][select][inv_rot_y];
						UseInv[playerid][i][inv_rot_z] = BagInv[bag_id][select][inv_rot_z];
						UseInv[playerid][i][inv_scale_x] = BagInv[bag_id][select][inv_scale_x];
						UseInv[playerid][i][inv_scale_y] = BagInv[bag_id][select][inv_scale_y];
						UseInv[playerid][i][inv_scale_z] = BagInv[bag_id][select][inv_scale_z];
						UseInv[playerid][i][inv_bone] = BagInv[bag_id][select][inv_bone];
						UseInv[playerid][i][inv_id] = BagInv[bag_id][select][inv_id];
						UseInv[playerid][i][inv_param_1] = BagInv[bag_id][select][inv_param_1];
						UseInv[playerid][i][inv_param_2] = BagInv[bag_id][select][inv_param_2];
						
						BagInv[bag_id][select][inv_amount]--;
						
						if( BagInv[bag_id][select][inv_amount] < 1 ) 
						{
							UseInv[playerid][i][inv_bd] = BagInv[bag_id][select][inv_bd];
							
							saveInventory( playerid, i, INV_UPDATE, B_TO_U );
							clearSlot( bag_id, select, TYPE_BAG );
						}	
						else
						{
							saveInventory( playerid, select, INV_UPDATE, UPD_B );
							updateSelect( playerid, bagSlot[playerid][select], 0 );
							
							saveInventory( playerid, i, INV_INSERT, TYPE_USE );
						}
				
						UseInv[playerid][i][inv_amount] = 1;

						if( GetPVarInt( playerid, "Inv:Show" ) )
						{
							updateImages( playerid, select, TYPE_BAG );
							updateAmount( playerid, select, TYPE_BAG );

							updateImages( playerid, i, TYPE_USE );
							updateAmount( playerid, i, TYPE_USE );
						
							updateSelect( playerid, invSelect[playerid], 0 );
						}

						SetPVarInt( playerid, "BagInv:Select", INVALID_PARAM );

						updateMass( playerid );
						
						useItem( playerid, i, STATE_ATTACH );
					}
					else
					{
						showPlayerDialog( playerid, d_inv_attach + 2, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
					}
				}
				
				default :		
				{
					showPlayerDialog( playerid, d_inv, DIALOG_STYLE_LIST, " ", 
							""gbDialog"Выберите действие с предметом:\n\
							"cBLUE"-"cWHITE" Взять в руки\n\
							"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
				}
			}
		}
		
		case d_inv + 2 :
		{
			if( !response )
			{
				updateSelect( playerid, invSelect[playerid], 0 );
				invSelect[playerid] = INVALID_PTD;
			
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				select = GetPVarInt( playerid, "Inv:NewSelect" ),
				car_id = GetPVarInt( playerid, "Inv:CarId" );
				
			SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );
			
			if( isnullSlot( TYPE_WARECAR, playerid, select ) )
				return 1;
			
			switch( listitem )
			{
				case 1 :
				{
					UseInv[playerid][i][inv_type] = TYPE_USE;
					UseInv[playerid][i][inv_active_type] = STATE_DEFAULT;
					UseInv[playerid][i][inv_slot] = i;
					UseInv[playerid][i][inv_pos_x] = CarInv[car_id][select][inv_pos_x];
					UseInv[playerid][i][inv_pos_y] = CarInv[car_id][select][inv_pos_y];
					UseInv[playerid][i][inv_pos_z] = CarInv[car_id][select][inv_pos_z];
					UseInv[playerid][i][inv_rot_x] = CarInv[car_id][select][inv_rot_x];
					UseInv[playerid][i][inv_rot_y] = CarInv[car_id][select][inv_rot_y];
					UseInv[playerid][i][inv_rot_z] = CarInv[car_id][select][inv_rot_z];
					UseInv[playerid][i][inv_scale_x] = CarInv[car_id][select][inv_scale_x];
					UseInv[playerid][i][inv_scale_y] = CarInv[car_id][select][inv_scale_y];
					UseInv[playerid][i][inv_scale_z] = CarInv[car_id][select][inv_scale_z];
					UseInv[playerid][i][inv_bone] = CarInv[car_id][select][inv_bone];
					UseInv[playerid][i][inv_id] = CarInv[car_id][select][inv_id];
					UseInv[playerid][i][inv_param_1] = CarInv[car_id][select][inv_param_1];
					UseInv[playerid][i][inv_param_2] = CarInv[car_id][select][inv_param_2];
					
					CarInv[car_id][select][inv_amount]--;
					
					if( CarInv[car_id][select][inv_amount] < 1 ) 
					{
						if( Vehicle[car_id][vehicle_id] )
						{
							UseInv[playerid][i][inv_bd] = CarInv[car_id][select][inv_bd];
							saveInventory( playerid, i, INV_UPDATE, C_TO_U );
						}
						else
							saveInventory( playerid, i, INV_INSERT, TYPE_USE );
						
						clearSlotWareHouse( car_id, select, TYPE_WARECAR );
					}	
					else
					{
						if( Vehicle[car_id][vehicle_id] )
							saveInventory( playerid, select, INV_UPDATE, UPD_C );
						
						saveInventory( playerid, i, INV_INSERT, TYPE_USE );
					}
					
					UseInv[playerid][i][inv_amount] = 1;

					if( GetPVarInt( playerid, "Inv:Show" ) )
					{
						updateImages( playerid, select, TYPE_WARECAR );
						updateAmount( playerid, select, TYPE_WARECAR );

						updateImages( playerid, i, TYPE_USE );
						updateAmount( playerid, i, TYPE_USE );
						
						updateWareHouseSelect( playerid, car_id, invSelect[playerid], 0, TYPE_WARECAR );
					}

					invSelect[playerid] = INVALID_PTD;
					SetPVarInt( playerid, "CarInv:Select", INVALID_PARAM );

					updateMass( playerid );
					
					useItem( playerid, i );
				}
			
				case 2 :
				{
					showPlayerDialog( playerid, d_inv_attach + 11, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
				}
				
				default :		
				{
					showPlayerDialog( playerid, d_inv + 2, DIALOG_STYLE_LIST, " ", 
							""gbDialog"Выберите действие с предметом:\n\
							"cBLUE"-"cWHITE" Взять в руки\n\
							"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
				}
			}
		}
		//Диалог при использовании бронежилета
		case d_inv + 3 :
		{
			new
				i = GetPVarInt( playerid, "InvArmour:Select" );
		
			if( response )
			{
				UseInv[playerid][i][inv_active_type] = STATE_ATTACH;
				if( isSavedAttachObject( TYPE_USE, playerid, i ) )
				{
					iAttachTimer[playerid] = SetTimerEx( "AttachItem", 500, 0, "iiiifffffffff",
						playerid, 
						i, 
						getModelItem( TYPE_USE, playerid, i ), 
						UseInv[playerid][i][inv_bone],
						UseInv[playerid][i][inv_pos_x], 
						UseInv[playerid][i][inv_pos_y], 
						UseInv[playerid][i][inv_pos_z],
						UseInv[playerid][i][inv_rot_x], 
						UseInv[playerid][i][inv_rot_y], 
						UseInv[playerid][i][inv_rot_z],
						UseInv[playerid][i][inv_scale_x],
						UseInv[playerid][i][inv_scale_y],
						UseInv[playerid][i][inv_scale_z]
					);
				}
				else
				{				
					iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
						playerid, 
						i, 
						getModelItem( TYPE_USE, playerid, i ), 
						1,
						6
					);
				}
			}
			else
			{
				DeletePVar( playerid, "InvArmour:Select" );
			}
			
			setPlayerArmour( playerid, float( UseInv[playerid][i][inv_param_1] ) );
		}
		
		case d_inv + 4 :
		{
			if( !response ) 
			{
				DeletePVar( playerid, "InvSpecial:Select" );
				return 1;
			}
		
			new
				i = GetPVarInt( playerid, "InvSpecial:Select" ),
				id = getInventoryId( PlayerInv[playerid][i][inv_id] );
		
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > MAX_PLAYERS )
			{
				format:g_small_string( "\
					"cBLUE"Использование %s\n\n\
					"cWHITE"Для использования введите ID игрока:\n\
					"gbDialogError"Неправильный формат ввода.", inventory[id][i_name] );
					
				return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
			}
			
			if( !IsLogged( strval( inputtext ) ) || strval( inputtext ) == playerid ) 
			{
				format:g_small_string( "\
					"cBLUE"Использование %s\n\n\
					"cWHITE"Для использования введите ID игрока:\n\
					"gbDialogError"Некорректный ID игрока.", inventory[id][i_name] );
					
				return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( strval( inputtext ) ) ) 
			{
				format:g_small_string( "\
					"cBLUE"Использование %s\n\n\
					"cWHITE"Для использования введите ID игрока:\n\
					"gbDialogError"Данного игрока нет рядом с Вами.", inventory[id][i_name] );
					
				return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
			}
			
			switch( PlayerInv[playerid][i][inv_id] )
			{
				case PARAM_CUFF :
				{
					if( Player[playerid][uMember] != FRACTION_CITYHALL && Player[playerid][uMember] != FRACTION_POLICE && 
							Player[playerid][uMember] != FRACTION_SADOC && Player[playerid][uMember] != FRACTION_WOOD || !Player[playerid][uRank] ) 
					{
						format:g_small_string( "\
							"cBLUE"Использование %s\n\n\
							"cWHITE"Для использования введите ID игрока:\n\
							"gbDialogError"У Вас нет доступа, Вы не можете совершить данное действие.", inventory[id][i_name] );
							
						return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
					}
							
					if( Player[playerid][uMember] == FRACTION_POLICE )
					{
						new
							fid = Player[playerid][uMember] - 1,
							rank = getRankId( playerid, fid );
								
						if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_add][6] )
						{
							format:g_small_string( "\
								"cBLUE"Использование %s\n\n\
								"cWHITE"Для использования введите ID игрока:\n\
								"gbDialogError"У Вас нет доступа, Вы не можете совершить данное действие.", inventory[id][i_name] );
								
							return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
						}
					}
				
					if( GetPVarInt( strval( inputtext ), "Player:Cuff" ) == 1 ) 
					{
						format:g_small_string( "\
							"cBLUE"Использование %s\n\n\
							"cWHITE"Для использования введите ID игрока:\n\
							"gbDialogError"Данный игрок уже в наручниках.", inventory[id][i_name] );
							
						return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
					}
					
					SetPlayerSpecialAction( strval( inputtext ), SPECIAL_ACTION_CUFFED );
	
					RemovePlayerAttachedObject( playerid, 4 );
					SetPlayerAttachedObject( strval( inputtext ), 4, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000 );
					SetPVarInt( strval( inputtext ), "Player:Cuff", 1 );
						
					format:g_small_string( "надел%s наручники на %s", SexTextEnd( playerid ), Player[ strval( inputtext ) ][uName] );
					MeAction( playerid, g_small_string, 1 );
						
					useSpecialItem( playerid, PARAM_CUFF, i );
						
					pformat:( ""gbDefault""cBLUE"%s"cWHITE" надел на Вас наручники.", Player[playerid][uRPName] );
					psend:( strval( inputtext ), C_WHITE );
				}
				
				case PARAM_MEDIC :
				{
					if( Player[ strval( inputtext ) ][uDeath] == 1 ) 
					{
						format:g_small_string( "\
							"cBLUE"Использование %s\n\n\
							"cWHITE"Для использования введите ID игрока:\n\
							"gbDialogError"Данный персонаж ранен, аптечку использовать невозможно.", inventory[id][i_name] );
							
						return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
					}
					
					useSpecialItem( playerid, PARAM_MEDIC, i );
					SendClient:( playerid, C_WHITE, ""gbSuccess"Вы использовали аптечку." );
									
					format:g_small_string( "использовал%s аптечку", SexTextEnd( playerid ) );
					MeAction( playerid, g_small_string, 1 );
					
					ClearAnimations( playerid );
					ApplyAnimation( playerid, "MEDIC", "CPR", 4.0, 0, 1, 1, 0, 0, 1 );
					
					if( Player[ strval( inputtext ) ][ uHP ] + 50.0 < 100.0 ) setPlayerHealth( strval( inputtext ), Player[ strval( inputtext ) ][ uHP ] + 50.0 );
					else setPlayerHealth( strval( inputtext ), 100.0 );
				}
				
				case PARAM_BLS :
				{
					if( Player[playerid][uMember] != FRACTION_FIRE && Player[playerid][uMember] != FRACTION_SADOC && 
						Player[playerid][uMember] != FRACTION_HOSPITAL || !Player[playerid][uRank] )
					{
						format:g_small_string( "\
							"cBLUE"Использование %s\n\n\
							"cWHITE"Для использования введите ID игрока:\n\
							"gbDialogError"У Вас нет доступа, Вы не можете совершить данное действие.", inventory[id][i_name] );
							
						return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
					}
					
					new
						fid = Player[playerid][uMember] - 1,
						rank = getRankId( playerid, fid );
						
					if( !FRank[fid][rank][r_medic] )
					{
						format:g_small_string( "\
							"cBLUE"Использование %s\n\n\
							"cWHITE"Для использования введите ID игрока:\n\
							"gbDialogError"У Вас нет доступа, Вы не можете совершить данное действие.", inventory[id][i_name] );
							
						return showPlayerDialog( playerid, d_inv + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
					}
					
					useSpecialItem( playerid, PARAM_BLS, i );
					SendClient:( playerid, C_WHITE, ""gbSuccess"Вы использовали сумку ALS." );
									
					format:g_small_string( "использовал%s сумку ALS", SexTextEnd( playerid ) );
					MeAction( playerid, g_small_string, 1 );
					
					ClearAnimations( playerid );
					ApplyAnimation( playerid, "MEDIC", "CPR", 4.0, 0, 1, 1, 0, 0, 1 );
	
					HealthPlayer( strval( inputtext ) );
				}
			}
			
			DeletePVar( playerid, "InvSpecial:Select" );
		}
		
		case d_inv + 5:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "InvSpecial:Select" );
				return 1;
			}
			
			new
				i = GetPVarInt( playerid, "InvSpecial:Select" ),
				id = getInventoryId( PlayerInv[playerid][i][inv_id] );
		
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || !GetVehicleModel( strval( inputtext ) ) || IsVelo( strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"Использование предмета - "cBLUE"%s\n\n\
					"cWHITE"Для использования введите ID транспорта (/dl):\n\
					"gbDialogError"Некорректный id транспорта.", inventory[id][i_name] );
					
				return showPlayerDialog( playerid, d_inv + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
			}
			
			if( !Vehicle[ strval( inputtext ) ][vehicle_id] )
			{
				format:g_small_string( "\
					"cWHITE"Использование предмета - "cBLUE"%s\n\n\
					"cWHITE"Для использования введите ID транспорта (/dl):\n\
					"gbDialogError"Вы не можете заправить временный транспорт.", inventory[id][i_name] );
					
				return showPlayerDialog( playerid, d_inv + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
			}
			
			if( Vehicle[ strval( inputtext ) ][vehicle_fuel] + 5.0 > VehicleInfo[ GetVehicleModel( strval( inputtext ) ) - 400 ][v_fuel] )
			{
				format:g_small_string( "\
					"cWHITE"Использование предмета - "cBLUE"%s\n\n\
					"cWHITE"Для использования введите ID транспорта (/dl):\n\
					"gbDialogError"Топливый бак не может вместить такое количество.", inventory[id][i_name] );
					
				return showPlayerDialog( playerid, d_inv + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
			}
			
			new
				Float:X, Float:Y, Float:Z;
			GetPlayerPos( playerid, X, Y, Z );
				
			if( GetVehicleDistanceFromPoint( strval( inputtext ), X, Y, Z ) > 5.0 )
			{
				format:g_small_string( "\
					"cWHITE"Использование предмета - "cBLUE"%s\n\n\
					"cWHITE"Для использования введите ID транспорта (/dl):\n\
					"gbDialogError"Вы должны находиться рядом с транспортом.", inventory[id][i_name] );
					
				return showPlayerDialog( playerid, d_inv + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Закрыть" );
			}
			
			Vehicle[strval( inputtext )][vehicle_fuel] += 5.0;
			UpdateVehicleFloat( strval( inputtext ), "vehicle_fuel", Vehicle[ strval( inputtext ) ][vehicle_fuel] );
			
			pformat:( ""gbSuccess"Вы заправили "cBLUE"%s"cWHITE" с помощью канистры на "cBLUE"5"cWHITE" л.", GetVehicleModelName( GetVehicleModel( strval( inputtext ) ) ) );
			psend:( playerid, C_WHITE );
			
			useSpecialItem( playerid, PARAM_BLS, i );
			
			DeletePVar( playerid, "InvSpecial:Select" );
		}
		
		case d_inv_attach + 2 :
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_inv + 1, DIALOG_STYLE_LIST, " ", 
					""gbDialog"Выберите действие с предметом:\n\
					"cBLUE"-"cWHITE" Взять в руки\n\
					"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
			}
			
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 1, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
			}
			
			new
				bag_id = getUseBagId( playerid ),
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				id = getInventoryId( BagInv[bag_id][GetPVarInt( playerid, "Inv:NewSelect")][inv_id] );
			
			if( isnullSlot( TYPE_BAG, playerid, GetPVarInt( playerid, "Inv:NewSelect") ) )
				return 1;
			
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachSelectSlot", GetPVarInt( playerid, "Inv:NewSelect") );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_BAG );
			
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					inventory[id][i_model], 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					1
			);
			
			SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		}
		
		// TODO
		
		case d_inv_attach + 3 :
		{
			if( !response )
				return 1;
				
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" );
						
			if( isnullSlot( TYPE_USE, playerid, i ) )
				return 1;

			if( UseInv[playerid][i][inv_active_type] != 1 )
				return SendClient:( playerid, C_WHITE, !INCORRECT_USE_ITEM );
			
			switch( listitem )
			{
				case 0 :
				{	
					if( inventory[ getInventoryId( UseInv[playerid][i][inv_id] ) ][i_type] == INV_ARMOUR )
					{
						SetPVarInt( playerid, "InvArmour:Select", i );
				
						iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
								playerid, 
								i, 
								getModelItem( TYPE_USE, playerid, i ), 
								1,
								7
						);
						
						return 1;
					}
				
					showPlayerDialog( playerid, d_inv_attach + 7, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
				}
				
				case 1 :
				{
					if( inventory[ getInventoryId( UseInv[playerid][i][inv_id] ) ][i_type] == INV_ARMOUR )
						return SendClient:( playerid, C_WHITE, !INCORRECT_USE_ITEM );
				
					showPlayerDialog( playerid, d_inv_attach + 6, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
				}
			}
		}
		
		case d_inv_attach + 4 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
				
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 4, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад");
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" );
				
			if( isnullSlot( TYPE_INV, playerid, GetPVarInt( playerid, "Inv:NewSelect") ) )
				return 1;
			
			SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachSelectSlot", GetPVarInt( playerid, "Inv:NewSelect") );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_INV );
			
	
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					getModelItem( TYPE_INV, playerid, GetPVarInt( playerid, "Inv:NewSelect") ), 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					1
			);
			
			SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		}
		
		case d_inv_attach + 5 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
				
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 5, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад");
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" );
			
			if( isnullSlot( TYPE_BAG, playerid, GetPVarInt( playerid, "Inv:NewSelect") ) )
				return 1;
			
			SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachSelectSlot", GetPVarInt( playerid, "Inv:NewSelect") );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_BAG );
			
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					getModelItem( TYPE_BAG, playerid, GetPVarInt( playerid, "Inv:NewSelect") ), 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					1
			);
			
			SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		}
		
		case d_inv_attach + 6 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
				
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 6, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад");
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" );
				
			if( isnullSlot( TYPE_USE, playerid, i ) )
				return 1;
				
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_USE );
	
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					getModelItem( TYPE_USE, playerid, i ), 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					2
			);
			
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		}
		
		case d_inv_attach + 7 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
				
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 7, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад");
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" );
				
				
			if( isnullSlot( TYPE_USE, playerid, i ) )
				return 1;
				
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_USE );
	
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					getModelItem( TYPE_USE, playerid, i ), 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					3
			);
			
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		}
		
		case d_inv_attach + 8 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
				
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_inv_attach + 8, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:NewSelect" );
			
			if( isnullSlot( TYPE_INV, playerid, i ) )
				return 1;
			
			SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", GetPVarInt( playerid, "Inv:OldSelect" ) );
			SetPVarInt( playerid, "Inv:AttachSelectSlot", i );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_INV );
			
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					GetPVarInt( playerid, "Inv:OldSelect" ), 
					getModelItem( TYPE_INV, playerid, i ), 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					4
			);
			
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
		}
		
		case d_inv_attach + 9 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
				
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 9, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад");
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" );
			
			if( isnullSlot( TYPE_WARECAR, playerid, GetPVarInt( playerid, "Inv:NewSelect" ) ) )
				return 1;
			
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachSelectSlot", GetPVarInt( playerid, "Inv:NewSelect") );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_WARECAR );
			
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					getModelItem( TYPE_WARECAR, playerid, GetPVarInt( playerid, "Inv:NewSelect" ) ), 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					5
			);
			
			SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		}
		
		case d_inv_attach + 10:
		{
			if( !response )
			{
				SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
				SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
				return 1;
			}
				
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 4, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад");
			}
			
			new 
				i = GetPVarInt( playerid, "Inv:OldSelect" );
				
			if( isnullSlot( TYPE_WARECAR, playerid, GetPVarInt( playerid, "Inv:NewSelect") ) )
				return 1;
			
			SetPVarInt( playerid, "Inv:Select", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachSelectSlot", GetPVarInt( playerid, "Inv:NewSelect") );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_WARECAR );
			
	
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					getModelItem( TYPE_WARECAR, playerid, GetPVarInt( playerid, "Inv:NewSelect") ), 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					1
			);
			
			SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		}
		
		case d_inv_attach + 11 :
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_inv + 2, DIALOG_STYLE_LIST, " ", 
					""gbDialog"Выберите действие с предметом:\n\
					"cBLUE"-"cWHITE" Взять в руки\n\
					"cBLUE"-"cWHITE" Закрепить на персонаже", "Выбрать", "Отмена");
			}
			
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_inv_attach + 11, DIALOG_STYLE_LIST, " ", invcontent_bone, "Далее", "Назад" );
			}
			
			new
				car_id = GetPVarInt( playerid, "Inv:CarId" ),
				i = GetPVarInt( playerid, "Inv:OldSelect" ),
				id = getInventoryId( CarInv[car_id][GetPVarInt( playerid, "Inv:NewSelect")][inv_id] );
			
			if( isnullSlot( TYPE_WARECAR, playerid, GetPVarInt( playerid, "Inv:NewSelect") ) )
				return 1;
			
			SetPVarInt( playerid, "Inv:AttachBone", listitem );
			SetPVarInt( playerid, "Inv:AttachSlot", i );
			SetPVarInt( playerid, "Inv:AttachSelectSlot", GetPVarInt( playerid, "Inv:NewSelect") );
			SetPVarInt( playerid, "Inv:AttachType", TYPE_WARECAR );
			
			iAttachTimer[playerid] = SetTimerEx( "UseAttachItem", 500, 0, "iiiii",
					playerid, 
					i, 
					inventory[id][i_model], 
					GetPVarInt( playerid, "Inv:AttachBone" ),
					1
			);
			
			SetPVarInt( playerid, "Inv:NewSelect", INVALID_PARAM );
			SetPVarInt( playerid, "Inv:OldSelect", INVALID_PARAM );
		}
	}
	
	return 1;
}