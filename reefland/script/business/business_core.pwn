Business_OnGameModeInit() 
{	
	mysql_tquery( mysql, "SELECT * FROM `"DB_BUSINESS"` ORDER BY `b_id`", "LoadBusiness" );
	
	return 1;
}

function LoadBusiness()
{
	clean_array();
	
	new 
		rows = cache_get_row_count(),
		start_house = GetTickCount(); 
	
	for( new b; b < rows; b++ )
	{
		if( !BusinessInfo[b][b_id] )
		{
			BusinessInfo[b][b_id] = cache_get_field_content_int( b, "b_id", mysql );
			BusinessInfo[b][b_type] = cache_get_field_content_int( b, "b_type", mysql );
			BusinessInfo[b][b_shop] = cache_get_field_content_int( b, "b_shop", mysql );
			BusinessInfo[b][b_price] = cache_get_field_content_int( b, "b_price", mysql );
			BusinessInfo[b][b_lock] = cache_get_field_content_int( b, "b_lock", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( b, "b_name", g_small_string, mysql );
			strmid( BusinessInfo[b][b_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			BusinessInfo[b][b_products_time] = cache_get_field_content_int( b, "b_products_time", mysql );
			BusinessInfo[b][b_interior] = cache_get_field_content_int( b, "b_int", mysql );
			BusinessInfo[b][b_products] = cache_get_field_content_int( b, "b_products", mysql );
			BusinessInfo[b][b_product_price] = cache_get_field_content_int( b, "b_product_price", mysql );
			BusinessInfo[b][b_safe] = cache_get_field_content_int( b, "b_safe", mysql );
			BusinessInfo[b][b_stair] = cache_get_field_content_int( b, "b_stair", mysql );
			BusinessInfo[b][b_state_cashbox] = cache_get_field_content_int( b, "b_state_cashbox", mysql );
			BusinessInfo[b][b_user_id] = cache_get_field_content_int( b, "b_user_id", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( b, "b_improve", g_small_string, mysql );
			sscanf( g_small_string,"p<|>a<d>[3]", BusinessInfo[b][b_improve] );
			
			clean:<g_small_string>;
			cache_get_field_content( b, "b_wall", g_small_string, mysql );
			sscanf( g_small_string,"p<|>a<d>[5]", BusinessInfo[b][b_wall] );
			
			clean:<g_small_string>;
			cache_get_field_content( b, "b_floor", g_small_string, mysql );
			sscanf( g_small_string,"p<|>a<d>[5]", BusinessInfo[b][b_floor] );
			
			clean:<g_small_string>;
			cache_get_field_content( b, "b_roof", g_small_string, mysql );
			sscanf( g_small_string,"p<|>a<d>[4]", BusinessInfo[b][b_roof] );
			
			clean:<g_small_string>;
			cache_get_field_content( b, "b_pos_cashbox", g_small_string, mysql, 128 );
			sscanf( g_small_string,"p<|>a<f>[3]", BusinessInfo[b][b_pos_cashbox] );
			
			clean:<g_small_string>;
			cache_get_field_content( b, "b_enter_pos", g_small_string, mysql, 128 );
			sscanf( g_small_string,"p<|>a<f>[4]", BusinessInfo[b][b_enter_pos] );
							
			clean:<g_small_string>;
			cache_get_field_content( b, "b_exit_pos", g_small_string, mysql, 128 );
			sscanf( g_small_string,"p<|>a<f>[4]", BusinessInfo[b][b_exit_pos] );
			
			BusinessInfo[b][b_pickup] = CreateDynamicPickup( 19902, 23, 
				BusinessInfo[b][b_enter_pos][0],
				BusinessInfo[b][b_enter_pos][1],
				BusinessInfo[b][b_enter_pos][2], -1, -1, -1, 30.0 );
			
			if( BusinessInfo[b][b_user_id] == INVALID_PARAM )
			{
				format:g_small_string( "\
					"cWHITE"%s\n%s", GetBusinessType( b ), 
					BusinessInfo[b][b_lock] ? (""cBLUE"Открыто"cWHITE"") : 
											  (""cGRAY"Закрыто"cWHITE"") 
				);
			}
			else
			{
				format:g_small_string( "\
					"cWHITE"%s\n%s", 
						BusinessInfo[b][b_name], 
						BusinessInfo[b][b_lock] ? (""cBLUE"Открыто"cWHITE"") : 
												  (""cGRAY"Закрыто"cWHITE"") 
				);
			}
			
			BusinessInfo[b][b_text] = CreateDynamic3DTextLabel( 
				g_small_string, 
				C_WHITE, 
				BusinessInfo[b][b_enter_pos][0], 
				BusinessInfo[b][b_enter_pos][1], 
				BusinessInfo[b][b_enter_pos][2], 
				5.0, 
				INVALID_PLAYER_ID, 
				INVALID_VEHICLE_ID
			);
			
			BusinessInfo[b][b_alt_text] = CreateDynamic3DTextLabel( 
				"Exit", 
				C_BLUE, 
				BusinessInfo[b][b_exit_pos][0], 
				BusinessInfo[b][b_exit_pos][1], 
				BusinessInfo[b][b_exit_pos][2] - 1.0, 
				3.0, 
				INVALID_PLAYER_ID, 
				INVALID_VEHICLE_ID, 
				0,
				BusinessInfo[b][b_id] 
			);
			
			if( BusinessInfo[b][b_state_cashbox] )
			{
				BusinessInfo[b][b_cashbox] = CreateDynamicPickup( 1239, 23, 
					BusinessInfo[b][b_pos_cashbox][0],
					BusinessInfo[b][b_pos_cashbox][1],
					BusinessInfo[b][b_pos_cashbox][2], BusinessInfo[b][b_id]
				);
			}
			
			LoadBusinessInterior( b );
				
			mysql_format:g_string( "SELECT * FROM `"DB_BUSINESS_FURN"` WHERE `f_bid` = %d", BusinessInfo[b][b_id] );
			mysql_tquery( mysql, g_string, "LoadFurnitureBusiness", "d", b );
		}
	}
	
	printf("[Load] Business Loaded - [%d] [time %d ms]", rows, GetTickCount() - start_house );
	return 1;
}

LoadBusinessForPlayer( playerid )
{
	for( new b; b < MAX_BUSINESS; b++ )
	{
		if( BusinessInfo[b][b_user_id] == Player[playerid][uID] )
		{	
			InsertPlayerBusiness( playerid, b );
		}
	}	
	
	return 1;
}

stock InsertPlayerBusiness( playerid, businessid ) 
{
	for( new i; i < MAX_PLAYER_BUSINESS; i++ ) 
	{
		if( Player[playerid][tBusiness][i] == INVALID_PARAM ) 
		{
			Player[playerid][tBusiness][i] = businessid;	
			break;
		}
	}	
	
	return 1;
}

stock IsOwnerBusinessCount( playerid )
{
	new 
		count = 0;
		
	for( new i; i < MAX_PLAYER_BUSINESS; i++ ) 
	{
		if( Player[playerid][tBusiness][i] != INVALID_PARAM ) 
			count++;
	}	
	
	return count;
}

stock RemovePlayerBusinessAll( playerid ) 
{
	for( new i; i < MAX_PLAYER_BUSINESS; i++ )
		Player[playerid][tBusiness][i] = INVALID_PARAM;
	
	return 1;
}

stock RemovePlayerBusiness( playerid, businessid ) 
{
	for( new i; i < MAX_PLAYER_BUSINESS; i++ ) 
	{
		if( Player[playerid][tBusiness][i] == businessid ) 
		{
			Player[playerid][tBusiness][i] = INVALID_PARAM;
			break;
		}
	}	
	
	return 1;
}


stock UpdateBusiness( businessid, field[], const _: value )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_BUSINESS"` SET `%s` = %d WHERE `b_id` = %d",
		field,
		value,
		BusinessInfo[businessid][b_id]
	);
	
	return mysql_tquery( mysql, g_string );
}

stock UpdateBusinessSlash( businessid, field[], value[] )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_BUSINESS"` SET `%s` = '%d|%d|%d' WHERE `b_id` = %d",
		field,
		value[0],
		value[1],
		value[2],
		BusinessInfo[businessid][b_id]
	);
	
	return mysql_tquery( mysql, g_string );
}

stock UpdateBusinessStr( businessid, field[], const value[] )
{
	mysql_format:g_string( "UPDATE `"DB_BUSINESS"` SET `%s` = '%e' WHERE `b_id` = %d",
		field,
		value,
		BusinessInfo[businessid][b_id]
	);
	
	return mysql_tquery( mysql, g_string );
}

BusinessTimer()
{
	new
		playerid;
		
	for( new b; b < MAX_BUSINESS; b++ )
	{
		if( BusinessInfo[b][b_id] )
		{
			if( !BusinessInfo[b][b_products] && BusinessInfo[b][b_products_time] < gettime() )
			{
				if( BusinessInfo[b][b_user_id] == INVALID_PARAM )
					continue;
			
				playerid = IsPlayerOnline( BusinessInfo[b][b_user_id] );
				
				mysql_format:g_string( "UPDATE " #DB_USERS " SET uMoney = uMoney + %d WHERE uID = %d LIMIT 1",
					floatround( BusinessInfo[b][b_price] * 0.3 ),
					BusinessInfo[b][b_user_id]
				);
				mysql_tquery( mysql, g_string );
				
				SellBusiness( b );
				
				if( playerid != INVALID_PLAYER_ID )
				{
					RemovePlayerBusiness( playerid, b );
					Player[playerid][uMoney] += floatround( BusinessInfo[b][b_price] * 0.3 );
										
					SendClient:( playerid, C_GRAY, ""gbError"Ваш бизнес был продан агенству за простаивание. Вам возвращено 30 процентов от его рыночной стоимости." );
				}
			}
		}
	}
}

SellBusiness( bid )
{
	BusinessInfo[bid][b_user_id] = INVALID_PARAM;
	
	clean:<BusinessInfo[bid][b_name]>;
	strcat( BusinessInfo[bid][b_name], GetBusinessType( bid ), 32 );
	
	BusinessInfo[bid][b_lock] = 1;
	BusinessInfo[bid][b_product_price] = 3;
	
	BusinessInfo[bid][b_products_time] =
	BusinessInfo[bid][b_state_cashbox] = 0;
			
	for( new i; i < 3; i++ )
		BusinessInfo[bid][b_pos_cashbox][i] = 0.0;
	
	mysql_format:g_string( "UPDATE `"DB_BUSINESS"` \
	SET \
		`b_user_id` = %d, \
		`b_products_time` = %d, \
		`b_product_price` = %d, \
		`b_name` = '%e', \
		`b_lock` = %d, \
		`b_state_cashbox` = %d, \
		`b_pos_cashbox` = '%f|%f|%f' \
	WHERE \
		`b_id` = %d LIMIT 1",
		BusinessInfo[bid][b_user_id],
		BusinessInfo[bid][b_products_time],
		BusinessInfo[bid][b_product_price],
		BusinessInfo[bid][b_name],
		BusinessInfo[bid][b_lock],
		BusinessInfo[bid][b_state_cashbox],
		BusinessInfo[bid][b_pos_cashbox][0],
		BusinessInfo[bid][b_pos_cashbox][1],
		BusinessInfo[bid][b_pos_cashbox][2],
		BusinessInfo[bid][b_id]
	);
	
	mysql_tquery( mysql, g_string );
	
	DestroyDynamicPickup( BusinessInfo[bid][b_cashbox] );
	UpdateBusiness3DText( bid );
	
	return 1;
}

OfferSalePlayerBusiness( playerid, saleid, businessid ) // Функция продажи бизнеса другому игроку
{	
	for( new i; i < MAX_PLAYER_BUSINESS; i++ )
	{
		if( Player[playerid][tBusiness][i] == businessid )
		{
			BusinessInfo[businessid][b_user_id] = Player[saleid][uID];
			InsertPlayerBusiness( saleid, businessid );
		
			UpdateBusiness( businessid, "b_user_id", Player[saleid][uID] );
			RemovePlayerBusiness( playerid, businessid );

			break;
		}
	}
	
	return 1;
}

ShowDialogBusinessSell( playerid, const businessid, reason[] = "", dialogid = d_buy_business + 10 )
{
	format:g_string( "\
		"cBLUE"Продажа бизнеса.\n\n\
		"cWHITE"Введите сумму продажи данного бизнеса:\n\n\
		Максимальная сумма продажи - "cBLUE"$%d"cWHITE".\n\
		Минимальная сумма продажи - "cBLUE"$%d"cWHITE"%s",
		( BusinessInfo[businessid][b_price] * 2 ),
		floatround( BusinessInfo[businessid][b_price] * 0.5 ),
		reason
	);
	
	return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
}

function CreateBusiness( playerid, b ) 
{
	BusinessInfo[b][b_id] = cache_insert_id();

	BusinessInfo[b][b_lock] = 1;
	BusinessInfo[b][b_pickup] = CreateDynamicPickup( 19132, 23, 
		BusinessInfo[b][b_enter_pos][0],
		BusinessInfo[b][b_enter_pos][1],
		BusinessInfo[b][b_enter_pos][2], -1, -1, -1, 30.0
	);

	format:g_small_string( "\
		"cWHITE"%s\n%s", 
		GetBusinessType( b ), 
		BusinessInfo[b][b_lock] ? (""cBLUE"Открыто"cWHITE"") : 
								  (""cGRAY"Закрыто"cWHITE"") 
	);
	
	BusinessInfo[b][b_text] = CreateDynamic3DTextLabel( 
		g_small_string, 
		C_WHITE, 
		BusinessInfo[b][b_enter_pos][0], 
		BusinessInfo[b][b_enter_pos][1], 
		BusinessInfo[b][b_enter_pos][2], 
		5.0, 
		INVALID_PLAYER_ID, 
		INVALID_VEHICLE_ID, 
		-1 
	);
	
	BusinessInfo[b][b_alt_text] = CreateDynamic3DTextLabel( 
		"Exit", 
		C_BLUE, 
		BusinessInfo[b][b_exit_pos][0], 
		BusinessInfo[b][b_exit_pos][1], 
		BusinessInfo[b][b_exit_pos][2] - 1.0, 
		3.0, 
		INVALID_PLAYER_ID, 
		INVALID_VEHICLE_ID, 
		0,
		BusinessInfo[b][b_id] 
	);
	
	LoadBusinessInterior( b );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] создал бизнес с ID %d: интерьер #%d, цена $%d", 
		Player[playerid][uName], 
		playerid, 
		BusinessInfo[b][b_id], 
		BusinessInfo[b][b_interior], 
		BusinessInfo[b][b_price] );
	SendAdmin:( C_DARKGRAY, g_small_string );
	
	return 1;
}

UpdateBusiness3DText( businessid )
{
	format:g_small_string( "\
		"cWHITE"%s\n%s", 
			BusinessInfo[businessid][b_name], 
			BusinessInfo[businessid][b_lock] ? (""cBLUE"Открыто"cWHITE"") : 
											(""cGRAY"Закрыто"cWHITE"") 
	);
				
	UpdateDynamic3DTextLabelText( BusinessInfo[businessid][b_text], C_WHITE, g_small_string );

	return 1;
}

/*ShowBusinessInterior( playerid, businessid )
{
	new 
		count = 0;
	
	clean:<g_big_string>;
	strcat( g_big_string, ""cWHITE"Название\t"cWHITE"Стоимость\n" );
	
	for( new i = 0; i < sizeof business_int; i++ )
	{
		if( business_int[i][bt_type] == BusinessInfo[businessid][b_type] )
		{
			
			if( business_int[i][bt_id] == BusinessInfo[businessid][b_interior] )
				continue;
			
			format:g_string( "\n"cBLUE"-"cWHITE" интерьер #%d \t"cBLUE"$%d"cWHITE"\n",
				business_int[i][bt_id],
				GetPriceInterior( businessid, i )
			);
			
			strcat( g_big_string, g_string );
			
			g_dialog_select[playerid][count] = i;
			
			count++;
		}
	}
	
	showPlayerDialog( playerid, d_business_panel + 12, DIALOG_STYLE_TABLIST_HEADERS, 
		""cWHITE"Доступные интерьеры", g_big_string, "Посмотреть", "Назад" );
}*/

ShowBusinessPartInterior( playerid, businessid, type )
{
	clean: <g_string>;
	strcat( g_string, ""cWHITE"Часть интерьера\t"cWHITE"Порядковый номер" );

	switch( type ) 
	{
		case 0: //Стены
		{
			for( new i; i < business_int[ BusinessInfo[businessid][b_interior] - 1 ][bt_wall]; i++ )
			{			
				format:g_small_string( "\n"cWHITE"Стена\t"cBLUE"#%i", i + 1 );
				strcat( g_string, g_small_string );
			}
		}
		
		case 1: //Полы
		{
			for( new i; i < business_int[ BusinessInfo[businessid][b_interior] - 1 ][bt_floor]; i++ )
			{
				format:g_small_string( "\n"cWHITE"Пол\t"cBLUE"#%i", i + 1 );
				strcat( g_string, g_small_string );
			}
		}
		
		case 2: //Потолок
		{
			for( new i; i < business_int[ BusinessInfo[businessid][b_interior] - 1 ][bt_roof]; i++ )
			{
				format:g_small_string( "\n"cWHITE"Потолок\t"cBLUE"#%i", i + 1 );
				strcat( g_string, g_small_string );
			}
		}
		
		case 3: //Лестницы
		{
			if( !business_int[ BusinessInfo[businessid][b_interior] - 1 ][bt_stair] )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"В этом бизнесе нет лестниц." );
				return showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", b_panel_texture, "Выбрать", "Назад" );
			}
			
			SelectedType{playerid} = 1;
			ShowTexViewer( playerid, GetPVarInt( playerid, "Bpanel:Type" ), 0, 0 );
			return 1;
		}
	}
	
	return showPlayerDialog( playerid, d_business_panel + 14, DIALOG_STYLE_TABLIST_HEADERS, 
		"Ретекстуризация", g_string, "Изменить", "Назад" );
}

UpdateBusinessCashBox( bid )
{
	mysql_format:g_string( "UPDATE `"DB_BUSINESS"` \
	SET `b_state_cashbox` = %d, \
		`b_pos_cashbox` = '%f|%f|%f' \
	WHERE `b_id` = %d LIMIT 1",
		BusinessInfo[bid][b_state_cashbox],
		BusinessInfo[bid][b_pos_cashbox][0],
		BusinessInfo[bid][b_pos_cashbox][1],
		BusinessInfo[bid][b_pos_cashbox][2],
		BusinessInfo[bid][b_id]
	);
		
	mysql_tquery( mysql, g_string );
	
	return 1;
}

LockBusiness( playerid )
{
	if( IsOwnerBusinessCount( playerid ) )
	{
		for( new i; i < MAX_PLAYER_BUSINESS; i++ )
		{
			if( Player[playerid][tBusiness][i] != INVALID_PARAM )
			{
				new
					b = Player[playerid][tBusiness][i];
					
				if( ( IsPlayerInRangeOfPoint( playerid, 3.0, BusinessInfo[b][b_enter_pos][0], BusinessInfo[b][b_enter_pos][1], BusinessInfo[b][b_enter_pos][2] ) && !GetPlayerVirtualWorld( playerid ) )
					|| ( IsPlayerInRangeOfPoint( playerid, 3.0, BusinessInfo[b][b_exit_pos][0], BusinessInfo[b][b_exit_pos][1], BusinessInfo[b][b_exit_pos][2] ) && BusinessInfo[b][b_id] == GetPlayerVirtualWorld( playerid ) ) ) 
				{
					if( !BusinessInfo[b][b_lock] )
					{
						BusinessInfo[b][b_lock] = 1;
						GameTextForPlayer( playerid, "~g~BUSINESS UNLOCK", 2000, 1 );
						format:g_small_string( "открыл%sдвери бизнеса", Player[playerid][uSex] == 1 ? (" "):("а ") );
					}
					else
					{
						BusinessInfo[b][b_lock] = 0;
						GameTextForPlayer( playerid, "~r~BUSINESS LOCK", 2000, 1 );
						format:g_small_string( "закрыл%sдвери бизнеса", Player[playerid][uSex] == 1 ? (" "):("а ") );
					}
					
					MeAction( playerid, g_small_string, 1 );
					UpdateBusiness( b, "b_lock", BusinessInfo[b][b_lock] );
					UpdateBusiness3DText( b );
					
					return 1;
				}
			}
		}
	}
	else
	{
		return SendClient:( playerid, C_WHITE, !NO_PERSONAL_BUSINESS );
	}
		
	SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться у дверей бизнеса." );
	
	return 1;
}

ShowBusinessPlayerList( playerid, dialogid, btn[], btn2[] )
{
	new 
		count = 0;
	
	clean: <g_string>;

	strcat( g_big_string, ""cWHITE"Название\n" );
				
	for( new i; i < MAX_PLAYER_BUSINESS; i++ ) 
	{
		if( Player[playerid][tBusiness][i] != INVALID_PARAM ) 
		{
			new
				bid = Player[playerid][tBusiness][i];
		
			format:g_small_string( ""cWHITE"%s #%d\n", 
				GetBusinessType( bid ),
				BusinessInfo[bid][b_id]
			);
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = bid;
			count++;
		}
	}	
	
	if( !count )
	{
		SendClient:( playerid, C_GRAY, ""gbError"Вы не являетесь владельцем бизнеса." );
		return 0;
	}
	
	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_LIST, 
		""cWHITE"Список Ваших бизнесов", g_string, btn, btn2 );
				
	return 1;
}

ClearBusinessData( bid )
{
	BusinessInfo[bid][b_id] = 0;
	BusinessInfo[bid][b_name][0] = EOS;
	BusinessInfo[bid][b_user_id] = INVALID_PARAM;
	
	BusinessInfo[bid][b_type] = 
	BusinessInfo[bid][b_shop] = 
	BusinessInfo[bid][b_price] = 
	BusinessInfo[bid][b_products] = 
	BusinessInfo[bid][b_safe] = 
	BusinessInfo[bid][b_lock] = 
	BusinessInfo[bid][b_interior] = 
	BusinessInfo[bid][b_product_price] = 
	BusinessInfo[bid][b_cashbox] = 
	BusinessInfo[bid][b_state_cashbox] = 
	BusinessInfo[bid][b_pickup] = 
	BusinessInfo[bid][b_products_time] = 
	BusinessInfo[bid][b_stair] = 
	BusinessInfo[bid][b_count_furn] = 0;
	
	BusinessInfo[bid][b_status_prod] = false;
	
	for( new i; i < 4; i++ )
	{
		BusinessInfo[bid][b_enter_pos][0] = 
		BusinessInfo[bid][b_exit_pos][0] = 0.0;
	}
	
	for( new i; i < 3; i++ )
	{
		BusinessInfo[bid][b_improve][0] = 0;
		BusinessInfo[bid][b_pos_cashbox][0] = 0.0;
	}
	
	BusinessInfo[bid][b_text] = 
	BusinessInfo[bid][b_alt_text] = Text3D: INVALID_3DTEXT_ID;
	
	for( new i; i < MAX_BUSINESS_WALL; i++ )
	{
		BusinessInfo[bid][b_wall][0] = 0;
	}
	
	for( new i; i < MAX_BUSINESS_FLOOR; i++ )
	{
		BusinessInfo[bid][b_floor][0] = 0;
	}
	
	for( new i; i < MAX_BUSINESS_ROOF; i++ )
	{
		BusinessInfo[bid][b_roof][0] = 0;
	}
}

function Business_OnPlayerDisconnect( playerid, reason )
{
	// Продаем второй бизнес государству, если срок премиум аккаунта истек
	if( !Premium[playerid][prem_business] && Player[playerid][tBusiness][1] != INVALID_PARAM )
	{
		new
			bid = Player[playerid][tBusiness][1];
	
		SellBusiness( bid );
		Player[playerid][uMoney] += BusinessInfo[bid][b_price];
	}
	
	return 1;
}