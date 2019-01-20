
stock showHouseList( playerid, type, page ) 
{
	SetPVarInt( playerid, "HBuy:List", page );
	SetPVarInt( playerid, "HBuy:Type", type );
	
	clean: <g_big_string>;
	
	strcat( g_big_string, ""cWHITE"Название\t"cWHITE"Стоимость\n" );
	
	new 
		idx,
		list;
		
	switch( type ) 
	{
		case 1: 
		{
			for( new h = idx; h < MAX_HOUSE; h++ ) 
			{
				if( HouseInfo[h][hID] && HouseInfo[h][huID] == INVALID_PARAM ) 
				{
					if( page && idx != page * HBUY_LIST )
					{
						idx++;
						continue;
					}
				
					format:g_small_string( ""cWHITE"%d. %s #%d\t"cBLUE"$%d\n", 
						idx + ( list + 1 ),
						!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
						HouseInfo[h][hID], 
						HouseInfo[h][hPrice] );
					
					strcat( g_big_string, g_small_string );

					g_dialog_select[playerid][list] = h;
					list++;
					
					if( list == HBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"Следующая страница" );
						break;
					}
					
				}
			}
			
			if( page || ( page && list < HBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"Предыдущая страница" );
			
			if( !list && !page ) 
			{
				SendClient:( playerid, C_WHITE, ""gbError"Нет жилья, доступного для покупки." );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "Выбор", "Назад" );
			}
			
			SetPVarInt( playerid, "HBuy:Last", list );
			
			showPlayerDialog( playerid, d_buy_menu + 2, DIALOG_STYLE_TABLIST_HEADERS, 
				"Список жилья доступного для покупки", g_big_string, "Выбор", "Назад" );
		}
		// Сортировка по стоимости
		case 2: 
		{
			new 
				price[2]; 
			
			price[0] = GetPVarInt( playerid, "HBuy:PriceM" ),
			price[1] = GetPVarInt( playerid, "HBuy:PriceH" );
			
			for( new h = idx; h < MAX_HOUSE; h++ ) 
			{
				if( HouseInfo[h][hPrice] <= price[1] && HouseInfo[h][hPrice] >= price[0] && 
					HouseInfo[h][hID] && HouseInfo[h][huID] == INVALID_PARAM ) 
				{
					if( page && idx != page * HBUY_LIST )
					{
						idx++;
						continue;
					}
					
					format:g_small_string( ""cWHITE"%d. %s #%d\t"cBLUE"$%d\n", 
						idx + ( list + 1 ),
						!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
						HouseInfo[h][hID], 
						HouseInfo[h][hPrice] );
					
					strcat( g_big_string, g_small_string );

					g_dialog_select[playerid][list] = h;
					list++;
					
					if( list == HBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"Следующая страница" );
						break;
					}
				}	
			}
			
			if( page || ( page && list < BBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"Предыдущая страница" );
			
			if( !list && !page ) 
			{
				showPlayerDialog( playerid, d_buy_menu + 3, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Сортировка по стоимости\n\n\
					"cWHITE"Укажите диапазон цен для просмотра интересующего жилья:\
					\nПример: "cBLUE"60000-200000\n\n\
					"gbDialogError"По данному запросу домов не найдено.", "Ввод", "Назад" );
				SetPVarInt( playerid, "HBuy:case", 2 );
				return 1;
			}
			
			SetPVarInt( playerid, "HBuy:Last", list );
			
			showPlayerDialog( playerid, d_buy_menu + 2, DIALOG_STYLE_TABLIST_HEADERS, 
				"Список жилья доступного для покупки", g_big_string, "Выбор", "Назад" );
		}
		
		case 3:
		{
			new
				type_one = GetPVarInt( playerid, "HBuy:TypeOne" ),
				type_two = GetPVarInt( playerid, "HBuy:TypeTwo" );
				
			for( new h; h < MAX_HOUSE; h++ ) 
			{
				if( HouseInfo[h][hID] && HouseInfo[h][huID] == INVALID_PARAM &&
					HouseInfo[h][hType] == type_one && GetTypeHouse( h ) == type_two ) 
				{
					if( page && idx != page * HBUY_LIST )
					{
						idx++;
						continue;
					}
				
					format:g_small_string( ""cWHITE"%d. %s #%d\t"cBLUE"$%d\n", 
						idx + ( list + 1 ),
						!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
						HouseInfo[h][hID], 
						HouseInfo[h][hPrice] );
					
					strcat( g_big_string, g_small_string );

					g_dialog_select[playerid][list] = h;
					list++;
					
					if( list == HBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"Следующая страница" );
						break;
					}
					
					continue;
				}
			}
			
			if( page || ( page && list < BBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"Предыдущая страница" );
			
			if( !list && !page ) 
			{
				DeletePVar( playerid, "HBuy:TypeTwo" );
				SendClient:( playerid, C_WHITE, ""gbError"По данному запросу домов не найдено." );
				
				return showPlayerDialog( playerid, d_buy_menu + 15, DIALOG_STYLE_LIST, " ", dialog_house_type, "Выбор", "Назад" );
			}
			
			SetPVarInt( playerid, "HBuy:Last", list );
			
			showPlayerDialog( playerid, d_buy_menu + 2, DIALOG_STYLE_TABLIST_HEADERS, "Список жилья доступного для покупки", g_big_string, "Выбор", "Назад" );
		}
		
		case 4:
		{
			new 
				count = 0;
				
			for( new i; i < MAX_PLAYER_HOUSE; i++ ) 
			{
				if( Player[playerid][tHouse][i] != INVALID_PARAM ) 
				{
					new
						h = Player[playerid][tHouse][i];
				
					format:g_small_string( ""cWHITE"%s #%d\t"cBLUE"$%d\n", 
						!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
						HouseInfo[h][hID], 
						HouseInfo[h][hPrice] );
						
					strcat( g_big_string, g_small_string );
					
					g_dialog_select[playerid][count] = h;
					
					count++;
				}
			}
			
			if( !count )
			{
				SendClient:( playerid, C_WHITE, ""gbError"У Вас нет собственного жилья." );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "Выбор", "Назад" );
			}
			
			showPlayerDialog( playerid, d_buy_menu + 16, DIALOG_STYLE_TABLIST_HEADERS, ""cWHITE"Список Вашего жилья", g_big_string, "Продать", "Назад" );
		}
	}	
	
	return 1;
}

stock showHouseBuyMenu( playerid, h ) 
{
	SetPVarInt( playerid, "HBuy:House", h );
	SetPVarInt( playerid, "HBuy:Camera", 1 );
	
	new 
		Float:dist = 6.0, 
		Float:pos[4],
		zone[28];
	
	GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
	
	SetPVarFloat( playerid, "HBuy:PX", pos[0] ),
	SetPVarFloat( playerid, "HBuy:PY", pos[1] ),
	SetPVarFloat( playerid, "HBuy:PZ", pos[2] );
	
	SetPlayerInterior( playerid, 0 );
	SetPlayerVirtualWorld( playerid, 1 );
	
	if( !HouseInfo[h][hType] ) 
	{
		setPlayerPos( playerid, 
			HouseInfo[h][hEnterPos][0] + 7.0 * -floatsin( HouseInfo[h][hEnterPos][3] + 180.0, degrees ),
			HouseInfo[h][hEnterPos][1] + 7.0 * floatcos( HouseInfo[h][hEnterPos][3] + 180.0, degrees ),
			HouseInfo[h][hEnterPos][2] );
					
		InterpolateCameraPos( playerid, 
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2],
			HouseInfo[h][hEnterPos][0] + dist * -floatsin( HouseInfo[h][hEnterPos][3] + 180.0, degrees ), 
			HouseInfo[h][hEnterPos][1] + dist * floatcos( HouseInfo[h][hEnterPos][3] + 180.0, degrees ), 
			HouseInfo[h][hEnterPos][2], 600, 1000 );
			
		InterpolateCameraLookAt( playerid, 
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2],
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2], 600, 1000);

		GetPos2DZone( HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], zone, 28 );
	}
	else 
	{
		for( new i; i < sizeof Hostels; i++) 
		{
			if( Hostels[i][kVirtWorld] == HouseInfo[h][hType] ) 
			{
				setPlayerPos( playerid, 
					Hostels[i][kEnterPos][0] + 7.0 * -floatsin( Hostels[i][kEnterPos][2] + 180.0,degrees), 
					Hostels[i][kEnterPos][1] + 7.0 * floatcos( Hostels[i][kEnterPos][2] + 180.0,degrees), 
					Hostels[i][kEnterPos][2] );
					
				SetPlayerCameraPos( playerid, 
					Hostels[i][kCamPos][0], 
					Hostels[i][kCamPos][1], 
					Hostels[i][kCamPos][2] );
					
				SetPlayerCameraLookAt( playerid, 
					Hostels[i][kEnterPos][0], 
					Hostels[i][kEnterPos][1], 
					Hostels[i][kEnterPos][2] );
					
				GetPos2DZone( Hostels[i][kEnterPos][0], Hostels[i][kEnterPos][1], zone, 28 );
					
				break;
			}
		}	
	}
	
	format:g_big_string( "\
		"cBLUE"Информация о %s\n\n\
		"cWHITE"Номер %s: "cBLUE"%d\n\
		"cWHITE"Рыночная стоимость %s: "cBLUE"$%d"cWHITE"\n\
		Коммунальные: "cBLUE"$%d/день"cWHITE"\n\
		Аренда: "cBLUE"$%d/день\n\n\
		"cWHITE"Район: "cBLUE"%s",
		!HouseInfo[h][hType] ? ("доме") : ("квартире"),
		!HouseInfo[h][hType] ? ("дома") : ("квартиры"),
		HouseInfo[h][hID], 
		!HouseInfo[h][hType] ? ("дома") : ("квартиры"),
		HouseInfo[h][hPrice],
		GetPricePaymentHouse( h ),
		GetPriceRentHouse( h ),
		zone
	);

	showPlayerDialog( playerid, d_buy_menu + 12, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Далее", "Назад" );
	
	return 1;
}

