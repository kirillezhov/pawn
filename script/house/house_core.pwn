function House_OnGameModeInit() 
{
	mysql_tquery( mysql, "SELECT * FROM `"DB_HOUSE"` ORDER BY `hID`", "loadHouse" );
	return 1;
}

stock inHouseMessage( h, color, text[] ) 
{
	foreach( new i : Player) 
	{
		if( !IsLogged(i) ) continue;
	
		if( IsPlayerInRangeOfPoint( i, 15.0, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] )
			&& HouseInfo[h][hID] == GetPlayerVirtualWorld( i ) )
		{
			SendClient:( i, color, text );	
		}
	}
	
	return 1;
}

stock HouseUpdate( house, params[], values ) 
{
	clean:<g_string>;
	
	mysql_format:g_string( "UPDATE `"DB_HOUSE"` SET `%s` = '%d' WHERE `hID` = '%d'", 
		params, values, HouseInfo[house][hID] );
		
	mysql_tquery( mysql, g_string );	
	
	return 1;
}

stock houseUpdateFloat( house, params[], Float:values ) 
{
	clean:<g_string>;
	
	mysql_format:g_string( "UPDATE `"DB_HOUSE"` SET `%s` = '%f' WHERE `hID` = '%d'", 
		params, values, HouseInfo[house][hID] );
		
	mysql_tquery( mysql, g_string );	
	
	return 1;
}

stock houseUpdateStr( house, params[], values[] ) 
{
	clean:<g_string>;
	
	format:g_string( "UPDATE `"DB_HOUSE"` SET `%s` = '%s' WHERE `hID` = '%d'", 
		params, values, HouseInfo[house][hID] );
	mysql_tquery( mysql, g_string );	
	
	return 1;
}

function loadHouse() 
{
	new 
		start_house = GetTickCount(),
		rows, 
		fields;
	
	clean_array();
    cache_get_data( rows, fields );
	COUNT_HOUSES = 0x0;
	
	if( !rows ) return 1;
		
	for( new h; h < rows; h++ ) 
	{
		if( !HouseInfo[h][hID] ) 
		{
			HouseInfo[h][hID] = cache_get_field_content_int( h, "hID", mysql );
			HouseInfo[h][huID] = cache_get_field_content_int( h, "huID", mysql );
			HouseInfo[h][hRent] = cache_get_field_content_int( h, "hRent", mysql );
				
			clean:<g_small_string>;
			cache_get_field_content( h, "hOwner", g_small_string, mysql );
			strmid( HouseInfo[h][hOwner], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			HouseInfo[h][hType] = cache_get_field_content_int( h, "hType", mysql );
				
			HouseInfo[h][hEnterPos][0] = cache_get_field_content_float( h, "hPosX", mysql );
			HouseInfo[h][hEnterPos][1] = cache_get_field_content_float( h, "hPosY", mysql );
			HouseInfo[h][hEnterPos][2] = cache_get_field_content_float( h, "hPosZ", mysql );
			HouseInfo[h][hEnterPos][3] = cache_get_field_content_float( h, "hPosA", mysql );
				
			HouseInfo[h][hExitPos][0] = cache_get_field_content_float( h, "hExPosX", mysql );
			HouseInfo[h][hExitPos][1] = cache_get_field_content_float( h, "hExPosY", mysql );
			HouseInfo[h][hExitPos][2] = cache_get_field_content_float( h, "hExPosZ", mysql );
			HouseInfo[h][hExitPos][3] = cache_get_field_content_float( h, "hExPosA", mysql );
			
			HouseInfo[h][hPrice] = cache_get_field_content_int( h, "hPrice", mysql );
			HouseInfo[h][hMoney] = cache_get_field_content_int( h, "hMoney", mysql );
			HouseInfo[h][hSettings] = cache_get_field_content_int( h, "hSettings", mysql );
			
			HouseInfo[h][hSellDate] = cache_get_field_content_int( h, "hSellDate", mysql );
				
			HouseInfo[h][hLock] = cache_get_field_content_int( h, "hLock", mysql );
			HouseInfo[h][hInterior] = cache_get_field_content_int( h, "hInterior", mysql );  
				
			clean:<g_small_string>;
			cache_get_field_content( h, "hWall", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[10]", HouseInfo[h][hWall] );
			
			clean:<g_small_string>;
			cache_get_field_content( h, "hRoof", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[7]", HouseInfo[h][hRoof] );
			
			clean:<g_small_string>;
			cache_get_field_content( h, "hFloor", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[10]", HouseInfo[h][hFloor] ); 
			
			HouseInfo[h][hStairs] = cache_get_field_content_int( h, "hStairs", mysql ); 
			
			clean:<g_small_string>;
			cache_get_field_content( h, "hSettings", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[3]", HouseInfo[h][hSettings] );
			
			if( HouseInfo[h][hSellDate] && HouseInfo[h][hSellDate] < gettime() )
			{
				mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `huID` = -1, `hRent` = 0, `hOwner` = '', `hSellDate` = 0 WHERE `hID` = %d LIMIT 1",
					HouseInfo[h][hID] );
				mysql_tquery( mysql, g_small_string );
					
				mysql_format:g_small_string( "UPDATE " #DB_USERS " SET uMoney = uMoney + %d WHERE uID = %d LIMIT 1",
					floatround( HouseInfo[h][hPrice] * 0.3 ),
					HouseInfo[h][huID]
				);
				mysql_tquery( mysql, g_small_string );
				
				mysql_format:g_small_string( "UPDATE " #DB_USERS " SET uHouseEvict = 0 WHERE uHouseEvict = %d", HouseInfo[h][hID] );
				mysql_tquery( mysql, g_small_string );
				
				clean:<HouseInfo[h][hOwner]>;
				HouseInfo[h][huID] = INVALID_PARAM;
				HouseInfo[h][hRent] =
				HouseInfo[h][hSellDate] = 0;
				
				for( new i; i < MAX_EVICT; i++ )
				{
					HEvict[h][i][hEvictUID] = 0;
					HEvict[h][i][hEvictName][0] = EOS;
				}
			}
			
			if( HouseInfo[h][huID] == INVALID_PARAM ) 
			{
				HouseInfo[h][hPickup] = CreateDynamicPickup( 1272, 23, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2], 
					HouseInfo[h][hType], -1, -1, 30.0 );
			}
			else if( !HouseInfo[h][hRent] )
			{
				HouseInfo[h][hPickup] = CreateDynamicPickup( 19522, 23, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2], 
					HouseInfo[h][hType], -1, -1, 30.0 );
			}
			else
			{
				HouseInfo[h][hPickup] = CreateDynamicPickup( 19524, 23, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2], 
					HouseInfo[h][hType], -1, -1, 30.0 );
			}
			
			if( !HouseInfo[h][hType] ) 
			{
				format:g_small_string( "Дом #%d", HouseInfo[h][hID] );
				
				HouseInfo[h][hText][0] = CreateDynamic3DTextLabel( 
					g_small_string, 0xFFFFFFFF, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2],
					5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1 );	
			}
			else 
			{
				format:g_small_string( "Квартира #%d", HouseInfo[h][hID] );
				
				HouseInfo[h][hText][0] = CreateDynamic3DTextLabel( 
					g_small_string, 0xFFFFFFFF, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2],
					5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, HouseInfo[h][hType] );
			}	
				
			HouseInfo[h][hText][1] = CreateDynamic3DTextLabel( "Exit", C_BLUE, 
				HouseInfo[h][hExitPos][0], 
				HouseInfo[h][hExitPos][1], 
				HouseInfo[h][hExitPos][2] - 1.0,
				5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1 );
					
			mysql_format:g_string( "SELECT * FROM `"DB_HOUSE_FURN"` WHERE `f_hid` = %d", HouseInfo[h][hID] );
			mysql_tquery( mysql, g_string, "LoadFurnitureHouse", "d", h );	
				
			loadHouseInterior( h );
			COUNT_HOUSES ++;
		}
	}
		
	printf("[Load] Houses Loaded - %d [time %d ms]", COUNT_HOUSES, GetTickCount() - start_house );
	
	return 1;
}

LoadHouseForPlayer( playerid )
{
	for( new h; h < MAX_HOUSE; h++ )
	{
		if( HouseInfo[h][huID] == Player[playerid][uID] )
		{	
			InsertPlayerHouse( playerid, h );
		}
		
		if( Player[playerid][tHouse][0] != INVALID_PARAM ) break;
	}
	
	return 1;
}

stock InsertPlayerHouse( playerid, house ) 
{
	for( new i; i < MAX_PLAYER_HOUSE; i++ ) 
	{
		if( Player[playerid][tHouse][i] == INVALID_PARAM ) 
		{
			Player[playerid][tHouse][i] = house;	
			break;
		}
	}	
	
	return 1;
}

ShowDialogHouseSell( playerid, const house, reason[] = "", dialogid = d_buy_menu + 11 )
{
	format:g_string( "\
		"cBLUE"Продажа жилья\n\n\
		"cWHITE"Введите сумму продажи жилья:\n\n\
		Максимальная сумма продажи - "cBLUE"$%d"cWHITE".\n\
		Минимальная сумма продажи - "cBLUE"$%d"cWHITE"%s",
		( HouseInfo[house][hPrice] * 2 ),
		floatround( HouseInfo[house][hPrice] * 0.5 ),
		reason
	);
	
	return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
}

OfferSalePlayerHouse( playerid, saleid, house ) // Функция продажи дома другому игроку
{	
	for( new i; i < MAX_PLAYER_HOUSE; i++ )
	{
		if( Player[playerid][tHouse][i] == house )
		{
			clean:<HouseInfo[house][hOwner]>;
			strcat( HouseInfo[house][hOwner], Player[saleid][uName], MAX_PLAYER_NAME );
		
			HouseInfo[house][huID] = Player[saleid][uID];
			HouseInfo[house][hSellDate] = gettime() + 2 * 86400;
			InsertPlayerHouse( saleid, house );
		
			HouseUpdate( house, "huID", HouseInfo[house][huID] );
			HouseUpdate( house, "hSellDate", HouseInfo[house][hSellDate] );
			HouseUpdate( house, "hOwner", HouseInfo[house][hOwner] );
			
			RemovePlayerHouse( playerid, house );

			break;
		}
	}
	
	return 1;
}


stock RemovePlayerHouse( playerid, house ) 
{
	for( new i; i < MAX_PLAYER_HOUSE; i++ ) 
	{
		if( Player[playerid][tHouse][i] == house ) 
		{
			Player[playerid][tHouse][i] = INVALID_PARAM;
			break;
		}
	}	
	
	return 1;
}

stock IsOwnerHouseCount( playerid )
{
	new 
		count = 0;
		
	for( new i; i < MAX_PLAYER_HOUSE; i++ ) 
	{
		if( Player[playerid][tHouse][i] != INVALID_PARAM ) 
			count++;
	}	
	
	return count;
}

function checkHouseEvict( playerid, h ) 
{
	clean:<g_string>;

	new
		rows = cache_get_row_count(),
		amount;
	
	if( rows )
	{
		for( new e; e < rows; e++ ) 
		{
			HEvict[h][e][hEvictUID] = cache_get_field_content_int( e, "uID", mysql );
			cache_get_field_content( e, "uName", HEvict[h][e][hEvictName], mysql, MAX_PLAYER_NAME );
					
			format:g_small_string( ""cWHITE"%d ячейка: "cBLUE"%s\n", e + 1, HEvict[h][e][hEvictName] );
			strcat( g_string, g_small_string );
		}
		
		amount = rows;
	}
		
	if( rows < hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_evict] )
	{
		for( new e = amount; e < hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_evict]; e++ )
		{
			format:g_small_string( ""cWHITE"%d ячейка: "cBLUE"нет\n", e + 1 );
			strcat( g_string, g_small_string );
			
			HEvict[h][e][hEvictUID] = 0;
			HEvict[h][e][hEvictName][0] = EOS;
		}
	}
		
	showPlayerDialog( playerid, d_house_panel + 2, DIALOG_STYLE_LIST, "Жильцы дома", g_string, "Выбор", "Назад" );
	
	return 1;
}

stock LockHouse( playerid ) 
{
	if( IsOwnerHouseCount( playerid ) )
	{
		for( new i; i < MAX_PLAYER_HOUSE; i++ )
		{
			if( Player[playerid][tHouse][i] != INVALID_PARAM )
			{
				new
					h = Player[playerid][tHouse][i]; 
			
				if( ( IsPlayerInRangeOfPoint( playerid, 1.5, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] ) && !GetPlayerVirtualWorld( playerid ) ) 
					|| ( IsPlayerInRangeOfPoint( playerid, 1.5, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] ) && HouseInfo[h][hID] == GetPlayerVirtualWorld( playerid ) ) )
				{
					if( HouseInfo[h][hLock] ) 
					{
						HouseInfo[h][hLock] = 0;
						
						format:g_small_string(  "закрыл%s дверь %s", SexTextEnd( playerid ), !HouseInfo[h][hType] ? ("дома") : ("квартиры") );
						GameTextForPlayer( playerid, "~r~LOCK", 1000, 1 );
					}
					else 
					{
						HouseInfo[h][hLock] = 1;
						
						format:g_small_string(  "открыл%s дверь %s", SexTextEnd( playerid ), !HouseInfo[h][hType] ? ("дома") : ("квартиры") );
						GameTextForPlayer( playerid, "~g~UNLOCK", 1000, 1 );
					}
					
					HouseUpdate( h, "hLock", HouseInfo[h][hLock] );
					MeAction( playerid, g_small_string, 1 );
					
					return 1;
				}
			}
		}
	}
	else if( Player[playerid][uHouseEvict] )
	{
		for( new h; h < sizeof HouseInfo; h++ ) 
		{
			if( !HouseInfo[h][hID] ) continue;
		
			if( ( IsPlayerInRangeOfPoint( playerid, 1.5, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] ) && !GetPlayerVirtualWorld( playerid ) ) 
				|| ( IsPlayerInRangeOfPoint( playerid, 1.5, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] ) && HouseInfo[h][hID] == GetPlayerVirtualWorld( playerid ) ) )
			{
				if( Player[playerid][uHouseEvict] != HouseInfo[h][hID] ) 
					return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет ключей от этого дома." );
				
				if( HouseInfo[h][hLock] ) 
				{
					HouseInfo[h][hLock] = 0;
						
					format:g_small_string(  "закрыл%s дверь %s", SexTextEnd( playerid ), !HouseInfo[h][hType] ? ("дома") : ("квартиры") );
					GameTextForPlayer( playerid, "~r~LOCK", 1000, 1 );
				}
				else 
				{
					HouseInfo[h][hLock] = 1;
						
					format:g_small_string(  "открыл%s дверь %s", SexTextEnd( playerid ), !HouseInfo[h][hType] ? ("дома") : ("квартиры") );
					GameTextForPlayer( playerid, "~g~UNLOCK", 1000, 1 );
				}
				
				HouseUpdate( HouseInfo[h][hID], "hLock", HouseInfo[h][hLock] );
				MeAction( playerid, g_small_string, 1 );
				
				return 1;
			}	
		}
	}
	else
	{
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет собственного жилья." );
	}
	
	SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться у дверей дома." );
	
	return 1;
}


ShowHousePlayerList( playerid, dialogid, btn[], btn2[] )
{
	new 
		count = 0;
		
	clean:<g_string>;
	
	strcat( g_string, ""cWHITE"Жилье\t"cWHITE"Статус" );
				
	for( new i; i < MAX_PLAYER_HOUSE; i++ ) 
	{
		if( Player[playerid][tHouse][i] != INVALID_PARAM ) 
		{
			new
				h = Player[playerid][tHouse][i];
				
			format:g_small_string( "\n"cWHITE"%s #%d\t%s", 
				!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
				HouseInfo[h][hID],
				!HouseInfo[h][hRent] ? (""cRED"Куплен") : (""cWHITE"Арендован") );
						
			strcat( g_string, g_small_string );
					
			g_dialog_select[playerid][count] = h;
					
			count++;
		}
	}
			
	if( !count ) 
	{
		SendClient:( playerid, C_WHITE, !""gbError"У Вас нет собственного жилья." );
		return 0;
	}
			
	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_TABLIST_HEADERS, ""cWHITE"Список Вашего жилья", g_string, btn, btn2 );
	
	return 1;
}

function insertHouseCreate( playerid, h ) 
{
	HouseInfo[h][hID] = cache_insert_id();
	
	HouseInfo[h][hPickup] = CreateDynamicPickup( 1272, 23, 
		HouseInfo[h][hEnterPos][0], 
		HouseInfo[h][hEnterPos][1], 
		HouseInfo[h][hEnterPos][2], 
		HouseInfo[h][hType], -1, -1, 30.0 );
			
	if( !HouseInfo[h][hType] ) 
	{
		format:g_small_string( "Дом #%d", HouseInfo[h][hID] );
				
		HouseInfo[h][hText][0] = CreateDynamic3DTextLabel( 
			g_small_string, 0xFFFFFFFF, 
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2],
			5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1 );	
	}
	else 
	{
		format:g_small_string( "Квартира #%d", HouseInfo[h][hID] );
				
		HouseInfo[h][hText][0] = CreateDynamic3DTextLabel( 
			g_small_string, 0xFFFFFFFF, 
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2],
			5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, HouseInfo[h][hType] );
	}
	
	HouseInfo[h][hText][1] = CreateDynamic3DTextLabel( "Exit", C_BLUE, 
		HouseInfo[h][hExitPos][0], 
		HouseInfo[h][hExitPos][1], 
		HouseInfo[h][hExitPos][2] - 1.0,
		5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1 );
	
	loadHouseInterior( h );	
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] создал дом с ID %d: интерьер #%d, цена $%d.", 
		Player[playerid][uName], 
		playerid, 
		HouseInfo[h][hID], 
		HouseInfo[h][hInterior], 
		HouseInfo[h][hPrice] );
	SendAdmin:( C_DARKGRAY, g_small_string );
	
	return 1;
}

stock clearDataHouse( h )
{
	HouseInfo[h][hID] =  
	HouseInfo[h][hType] = 
	HouseInfo[h][hRent] = 
	HouseInfo[h][hPrice] = 
	HouseInfo[h][hSellDate] = 
	HouseInfo[h][hMoney] = 
	HouseInfo[h][hInterior] = 
	HouseInfo[h][hLock] = 
	HouseInfo[h][hPickup] = 
	HouseInfo[h][hCountFurn] = 
	HouseInfo[h][hStairs] = 
	HouseInfo[h][huID] = 0;

	for( new i; i < 4; i++ )
	{
		HouseInfo[h][hEnterPos][i] =
		HouseInfo[h][hExitPos][i] = 0.0;
	}
	
	HouseInfo[h][hOwner][0] = 
	HouseInfo[h][hWall][0] = 
	HouseInfo[h][hFloor][0] = 
	HouseInfo[h][hRoof][0] = 
	HouseInfo[h][hSettings][0] = EOS;
}

ShowHousePartInterior( playerid, h, type )
{
	clean: <g_big_string>;
	strcat( g_big_string, ""cWHITE"Часть интерьера\t"cWHITE"Порядковый номер" );

	switch( type ) 
	{
		case 0: //Стена
		{		
			for( new i; i < hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_wall]; i++ )
			{			
				format:g_string( "\n"cWHITE"Стена\t"cBLUE"#%i", i + 1 );
				strcat( g_big_string, g_string );
			}
			
			showPlayerDialog( playerid, d_house_panel + 14, DIALOG_STYLE_TABLIST_HEADERS, 
				"Ретекстуризация", g_big_string, "Изменить", "Назад" );
		}
		
		case 1: //Пол
		{
			for( new i; i < hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_floor]; i++ )
			{			
				format:g_string( "\n"cWHITE"Пол\t"cBLUE"#%i", i + 1 );
				strcat( g_big_string, g_string );
			}
			
			showPlayerDialog( playerid, d_house_panel + 14, DIALOG_STYLE_TABLIST_HEADERS, 
				"Ретекстуризация", g_big_string, "Изменить", "Назад" );
		}
		
		case 2: //Потолок
		{
			for( new i; i < hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_roof]; i++ )
			{			
				format:g_string( "\n"cWHITE"Потолок\t"cBLUE"#%i", i + 1 );
				strcat( g_big_string, g_string );
			}
			
			showPlayerDialog( playerid, d_house_panel + 14, DIALOG_STYLE_TABLIST_HEADERS, 
				"Ретекстуризация", g_big_string, "Изменить", "Назад" );
		}
		
		case 3: //Лестница
		{
			if( !hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_stair] )
			{
				pformat:( ""gbDefault"В %s нет лестниц.", HouseInfo[h][hType] ? ("этой квартире") : ("этом доме") );
				psend:( playerid, C_WHITE );
					
				return showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", h_panel_texture, "Выбрать", "Назад" );
			}
			
			ShowTexViewer( playerid, GetPVarInt( playerid, "Hpanel:Type" ), 0, 0 );
		}
	}
	
	return 1;
}

function House_OnPlayerDisconnect( playerid, reason )
{
	// Продаем второй дом государству, если срок премиум аккаунта истек
	if( !Premium[playerid][prem_house] && Player[playerid][tHouse][1] != INVALID_PARAM )
	{
		new
			h = Player[playerid][tHouse][1];
			
		mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `huID` = -1, `hRent` = 0, `hOwner` = '', `hSellDate` = 0 WHERE `hID` = %d LIMIT 1",
			HouseInfo[h][hID] );
		mysql_tquery( mysql, g_small_string );
			
		clean:<HouseInfo[h][hOwner]>;
		HouseInfo[h][huID] = INVALID_PARAM;
		HouseInfo[h][hRent] =
		HouseInfo[h][hSellDate] = 0;
		
		Player[playerid][uMoney] += HouseInfo[h][hPrice];
				
		mysql_format:g_small_string( "UPDATE " #DB_USERS " SET uHouseEvict = 0 WHERE uHouseEvict = %d", HouseInfo[h][hID] );
		mysql_tquery( mysql, g_small_string );
		
		for( new i; i < MAX_EVICT; i++ )
		{
			HEvict[h][i][hEvictUID] = 0;
			HEvict[h][i][hEvictName][0] = EOS;
		}
		
		foreach(new i: Player)
		{
			if( !IsLogged(i) || !Player[i][uHouseEvict] ) continue;
			
			if( Player[i][uHouseEvict] == HouseInfo[h][hID] )
			{
				Player[i][uHouseEvict] = 0;
				SendClient:( i, C_WHITE, !""gbDefault"Дом, в который Вы были подселены, продан агенству недвижимости по рыночной стоимости." );
			}
		}
		
		DestroyDynamicPickup( HouseInfo[h][hPickup] );
		HouseInfo[h][hPickup] = CreateDynamicPickup( 1272, 23, 
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2], 
			HouseInfo[h][hType], -1, -1, 30.0 );
	}

	return 1;
}