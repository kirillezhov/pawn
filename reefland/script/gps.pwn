
new gps_cat[][32] = 
{
	{ "Государственные организации" },
	{ "Другие организации" },
	{ "Работы" },
	{ "Складские помещения" },
	{ "Транспортные узлы" }
};

enum gps_info 
{ 
	gps_category,
	gps_text				[ 128 char ],
	Float:gps_pos			[ 3 ]
}

new const
	gps_cat_check[][gps_info] = 
	{
		{ 0, !"Мэрия 'City Hall'", { 1480.7650,-1736.5615,13.3828 } },
		{ 0, !"Центральный банк", { 1461.9851,-1029.1039,23.6563 } },
		{ 0, !"Полицейский департамент 'LS'", { 1536.2625,-1672.7974,13.3828 } },
		{ 0, !"Патрульный дивизион '77 st'", { 2801.5010,-1204.3617,26.3836 } },
		{ 0, !"Полицейский департамент 'Harbour'", { 2162.8867,-2663.1294,13.5469 } },
		{ 0, !"Центральный госпиталь 'County'", { 2000.5913,-1447.2627,13.5606 } },
		{ 0, !"Пожарная станция '101'", { 1093.7190,-1707.5149,13.3828 } },
		{ 0, !"Пожарная станция '505'", { 1316.3556,-918.8550,37.9074 } },
		{ 0, !"Станция парамедиков '707'", { 2742.4541,-1439.3396,30.2813 } },
		{ 0, !"Штаб департамента шерифов", { 636.8927,-572.4571,16.1875 } },
		{ 0, !"Департамент шерифов 'Palomino Creek'", { 2198.6775,50.6210,26.4844 } },
		{ 0, !"Государственная СТО", { 2713.9333,-2503.4507,13.4937 } },
		{ 0, !"Верховный Суд", { 981.834,-1162.16,25.0859 } },
		{ 0, !"Тренировочный полигон 'FD'", { 1142.2042,1368.4746,10.6810 } },
		{ 1, !"Агентство недвижимости", { 1809.77,-1166.77,24.2266 } },
		{ 1, !"Центр лицензирования", { 708.5787,-1410.3665,13.3913 } },
		{ 1, !"Новостной офис 'SAN'", { 1685.0990,-1635.4109,13.3828 } },
		{ 1, !"Центральный отель", { 1469.2407,-1165.3324,23.8202 } },
		{ 1, !"Церковь 'Baker'", { 2265.5457,-32.9019,26.3359 } },
		{ 1, !"Церковь 'Roosevelt'", { 2231.3706,-1305.2501,23.8520 } },
		{ 1, !"Национальный парк", { -1664.0332,-2251.1865,37.7331 } },
		{ 2, !"Пассажирская компания", { 1190.7950,-1338.6523,13.3986 } },
		{ 2, !"Транспортная компания", { 2237.8774,-2211.4446,13.2911 } },
		{ 2, !"СТО 'Market'", { 943.7028,-1390.7491,13.2598 } },
		{ 2, !"СТО 'Bell'", { 2529.4634,-1508.7498,23.8300 } },
		{ 2, !"СТО 'Simpson'", { 1364.2821,210.8708,19.4063 } },
		{ 2, !"СТО 'Harbour'", { 2120.4001,-2152.9995,13.5469 } },
		{ 2, !"Лесное хозяйство", { -507.9670,-86.5572,62.1092 } },
		{ 2, !"Служба доставки еды", { 1685.1887,-1463.3378,13.5469 } },
		{ 3, !"Склад 'Hilltop Farm'", { 1025.5461,-344.3430,73.9922 } },
		{ 3, !"Склад 'Blueberry 48 Road'", { -27.2633,-311.9980,5.4229 } },
		{ 3, !"Склад 'Spinybed'", { 2348.0732,2725.0754,10.8203 } },
		{ 3, !"Склад 'Doherty'", { -1749.2855,-116.4739,3.5547 } },
		{ 3, !"Склад 'Ocean Docks'", { 2423.7717,-2231.4666,13.3724 } },
		{ 4, !"Автосалон 'Grotti'", { 557.1735,-1256.6133,17.2422 } },
		{ 4, !"Автосалон 'Economy Grotti'", { 842.3514,-1040.9869,25.2378 } },
		{ 4, !"Мотосалон 'Grotti'", { 1365.5477,409.2536,19.4063 } },
		{ 4, !"СТО 'Market'", { 943.7028,-1390.7491,13.2598 } },
		{ 4, !"СТО 'Bell'", { 2529.4634,-1508.7498,23.8300 } },
		{ 4, !"СТО 'Simpson'", { 1364.2821,210.8708,19.4063 } },
		{ 4, !"СТО 'Harbour'", { 2120.4001,-2152.9995,13.5469 } },
		{ 4, !"Утилизация транспорта", { 1295.4329,382.1285,19.5547 } }
	},
	
	Float:gps_furniture[][] = 
	{
		{ 1791.85, -1163.12, 23.83 },
		{ 2352.0, -1412.11, 23.99 },
		{ 1252.95, 352.17, 19.55 }
	},
	
	Float:gps_weapon[][] = 
	{
		{ 1368.78, -1279.79, 13.5469 },
		{ 2400.38, -1981.39, 13.5469 },
		{ 2333.57, 61.6305, 26.7058 },
		{ 242.922, -178.37, 1.5822 }
	};

new gps_select	[ MAX_PLAYERS ][ sizeof gps_cat_check ];

CMD:gps( playerid ) 
{
	if( GetPVarInt( playerid, "Job:Food" ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Чтобы воспользоваться GPS-навигатором, сначала доставьте заказ клиенту." );

	if( !g_player_gps{playerid} ) 
	{
		clean:<g_big_string>;
		for( new i; i < sizeof gps_cat; i++ ) 
		{
			format:g_small_string( ""cBLUE"-"cWHITE" %s\n", gps_cat[i] );
			strcat( g_big_string, g_small_string );
		}
		
		format:g_small_string( "%s", static_gps );
		strcat( g_big_string, g_small_string );
		
		showPlayerDialog( playerid, d_gps, DIALOG_STYLE_LIST, " ", g_big_string, "Выбор", "Закрыть" );
	}
	else 
	{
		g_player_gps{playerid} = 0;
        DisablePlayerCheckpoint( playerid );
		SendClient:( playerid, C_GRAY, ""gbSuccess"Вы убрали метку с Вашего GPS-навигатора." );
		
		if( GetPVarInt( playerid, "GPSuse" ) )
		{
			DeletePVar( playerid, "GPSuse" );
			DeletePVar( playerid, "GPSplayer" );
		}
	}
	
	return 1;
}

GPS_OnPlayerEnterCheckpoint( playerid ) 
{
	if( g_player_gps{playerid} ) 
	{
		DisablePlayerCheckpoint( playerid );
		g_player_gps{playerid} = 0;
		SendClient:( playerid, C_WHITE, ""gbSuccess"Вы достигли места назначения на GPS-навигаторе." );
	}
	
	return 1;
}

function GPS_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_gps: 
		{
			if( !response ) 
				return 1;
				
			new 
				gps_dialog = sizeof gps_cat;
			
			if( listitem == gps_dialog ) 
			{
				showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					Найти свой дом\n\
					Найти свой бизнес\n\
					Найти ближайший магазин\n\
					Найти ближайшее заведение\n\
					Найти ближайшую бензоколонку", "Выбор", "Назад" );
			}
			else 
			{
				new 
					slot,
					string[64];
				
				clean:<g_big_string>;
				
				for( new i; i < sizeof gps_cat_check; i++ ) 
				{
					if( gps_cat_check[i][gps_category] != listitem ) 
						continue; 
					
					strunpack( string, gps_cat_check[i][gps_text] );
					
					format:g_small_string( ""cBLUE"-"cWHITE" %s\n", string );
					strcat( g_big_string, g_small_string );
					gps_select[playerid][slot] = i;
					slot++;
				}
				
				showPlayerDialog( playerid, d_gps + 1, DIALOG_STYLE_LIST, " ", g_big_string, "Выбор", "Назад" );
			}
		}
		
		case d_gps + 1: 
		{
			if( !response ) return cmd_gps( playerid ), DeletePVar( playerid, "Player:GPSCat" );
			
			new 
				i = gps_select[playerid][listitem];
				
			SetPlayerCheckpoint( playerid, gps_cat_check[i][gps_pos][0], gps_cat_check[i][gps_pos][1], gps_cat_check[i][gps_pos][2], 5.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы установили метку на GPS-навигаторе. Для отмены используйте - "cBLUE"/gps"cWHITE"");
		}
		
		case d_gps + 2: 
		{
		    if( !response ) return cmd_gps( playerid ), DeletePVar( playerid, "Player:GPSCat" );
		    
			if( listitem == 0 )
			{
				if( !ShowHousePlayerList( playerid, d_gps + 5, "Найти", "Назад" ) )
				{
					return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
						Найти свой дом\n\
						Найти свой бизнес\n\
						Найти ближайший магазин\n\
						Найти ближайшее заведение\n\
						Найти ближайшую бензоколонку", "Выбор", "Назад" );
				}	
			}
			else if( listitem == 1 )
			{
				if( !ShowBusinessPlayerList( playerid, d_gps + 6, "Найти", "Назад" ) )
				{
					return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
						Найти свой дом\n\
						Найти свой бизнес\n\
						Найти ближайший магазин\n\
						Найти ближайшее заведение\n\
						Найти ближайшую бензоколонку", "Выбор", "Назад" );
				}
			}
			if( listitem == 2 )
			{
				showPlayerDialog( playerid, d_gps + 3, DIALOG_STYLE_LIST, " ", "\
					Магазин мебели\n\
					Магазин одежды\n\
					Магазин аксессуаров\n\
					Магазин электроники\n\
					Магазин туризма\n\
					Оружейный магазин", "Выбор", "Назад" );
			}
			else if( listitem == 3 )
			{
				showPlayerDialog( playerid, d_gps + 4, DIALOG_STYLE_LIST, " ", "\
					Ресторан\n\
					Закусочная\n\
					Бар", "Выбор", "Назад" );
			}
			else if( listitem == 4 )
			{
				new
					Float:x,
					Float:y,
					Float:z;
			
				findShop( playerid, 3, 0, -1, x, y, z );
				SetPlayerCheckpoint( playerid, x, y, z, 3.0 );
			
				g_player_gps{playerid} = 1;
				SendClient:( playerid, C_WHITE, ""gbDefault"Вы установили метку на GPS-навигаторе. Для отмены используйте - "cBLUE"/gps"cWHITE"");
			}
		}
		
		case d_gps + 3: 
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					Найти свой дом\n\
					Найти свой бизнес\n\
					Найти ближайший магазин\n\
					Найти ближайшее заведение\n\
					Найти ближайшую бензоколонку", "Выбор", "Назад" );
			}
			
			new
				Float:x,
				Float:y,
				Float:z;
			
			switch( listitem )
			{
				case 0: findShop( playerid, 1, 0, -1, x, y, z );
				case 1: findShop( playerid, 0, 3, 0, x, y, z );
				case 2: findShop( playerid, 0, 3, 1, x, y, z );
				case 3: findShop( playerid, 0, 3, 2, x, y, z );
				case 4: findShop( playerid, 0, 3, 3, x, y, z );
				case 5: findShop( playerid, 2, 0, -1, x, y, z );
			}
			
			SetPlayerCheckpoint( playerid, x, y, z, 3.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы установили метку на GPS-навигаторе. Для отмены используйте - "cBLUE"/gps"cWHITE"");
		}
		
		case d_gps + 4: 
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					Найти свой дом\n\
					Найти свой бизнес\n\
					Найти ближайший магазин\n\
					Найти ближайшее заведение\n\
					Найти ближайшую бензоколонку", "Выбор", "Назад" );
			}
			
			new
				Float:x,
				Float:y,
				Float:z;
			
			switch( listitem )
			{
				case 0: findShop( playerid, 0, 1, -1, x, y, z );
				case 1: findShop( playerid, 0, 0, -1, x, y, z );
				case 2: findShop( playerid, 0, 2, -1, x, y, z );
			}
			
			SetPlayerCheckpoint( playerid, x, y, z, 3.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы установили метку на GPS-навигаторе. Для отмены используйте - "cBLUE"/gps"cWHITE"");
		}
		
		case d_gps + 5:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					Найти свой дом\n\
					Найти свой бизнес\n\
					Найти ближайший магазин\n\
					Найти ближайшее заведение\n\
					Найти ближайшую бензоколонку", "Выбор", "Назад" );
			}
			
			new
				h = g_dialog_select[playerid][listitem];
				
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			SetPlayerCheckpoint( playerid, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2], 3.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы установили метку на GPS-навигаторе. Для отмены используйте - "cBLUE"/gps"cWHITE"");
		}
		
		case d_gps + 6:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					Найти свой дом\n\
					Найти свой бизнес\n\
					Найти ближайший магазин\n\
					Найти ближайшее заведение\n\
					Найти ближайшую бензоколонку", "Выбор", "Назад" );
			}
			
			new
				b = g_dialog_select[playerid][listitem];
				
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			SetPlayerCheckpoint( playerid, BusinessInfo[b][b_enter_pos][0], BusinessInfo[b][b_enter_pos][1], BusinessInfo[b][b_enter_pos][2], 3.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы установили метку на GPS-навигаторе. Для отмены используйте - "cBLUE"/gps"cWHITE"");
		}
	}
	
	return 1;
}

function findShop( playerid, type, subtype, shop, &Float:x, &Float:y, &Float:z )
{
	new
		Float:minimum = 0.0;
		
	switch( type )
	{	
		//Бизнес
		case 0:
		{
			new
				Float:spos[ 90 ];
				
			for( new i; i < MAX_BUSINESS; i++ )
			{
				if( !BusinessInfo[i][b_id] || BusinessInfo[i][b_type] != subtype ) continue;
				
				if( shop != INVALID_PARAM )
				{
					switch( shop )
					{
						//Магазины одежды
						case 0:
						{
							if( BusinessInfo[i][b_shop] < 2 || BusinessInfo[i][b_shop] > 5 ) continue;
						}
						//Магазины аксессуаров
						case 1:
						{
							if( BusinessInfo[i][b_shop] < 6 ) continue;
						}
						//Магазины электроники
						case 2:
						{
							if( BusinessInfo[i][b_shop] != 1 ) continue;
						}
						//Магазины все для отдыха
						case 3:
						{
							if( BusinessInfo[i][b_shop] ) continue;
						}
					}
				}
				
				spos[i] = GetPlayerDistanceFromPoint( playerid, BusinessInfo[i][b_enter_pos][0], BusinessInfo[i][b_enter_pos][1], BusinessInfo[i][b_enter_pos][2] );
			
				if( minimum == 0.0 )
				{
					minimum = spos[i];
					
					x = BusinessInfo[i][b_enter_pos][0];
					y = BusinessInfo[i][b_enter_pos][1];
					z = BusinessInfo[i][b_enter_pos][2];
					
					continue;
				}
			
				if( spos[i] < minimum )
				{
					minimum = spos[i];
					
					x = BusinessInfo[i][b_enter_pos][0];
					y = BusinessInfo[i][b_enter_pos][1];
					z = BusinessInfo[i][b_enter_pos][2];
				}
			}
		}
		//Магазин мебели
		case 1:
		{
			new
				Float:spos[ sizeof gps_furniture ];
		
			for( new i; i < sizeof gps_furniture; i++ )
			{
				spos[i] = GetPlayerDistanceFromPoint( playerid, gps_furniture[i][0], gps_furniture[i][1], gps_furniture[i][2] );
			
				if( !i ) 
				{
					minimum = spos[i];
					
					x = gps_furniture[i][0];
					y = gps_furniture[i][1];
					z = gps_furniture[i][2];
					
					continue;
				}
			
				if( spos[i] < minimum )
				{
					minimum = spos[i];
					
					x = gps_furniture[i][0];
					y = gps_furniture[i][1];
					z = gps_furniture[i][2];
				}
			}
		}
		//Оружейный магазин
		case 2:
		{
			new
				Float:spos[ sizeof gps_weapon ];
		
			for( new i; i < sizeof gps_weapon; i++ )
			{
				spos[i] = GetPlayerDistanceFromPoint( playerid, gps_weapon[i][0], gps_weapon[i][1], gps_weapon[i][2] );
			
				if( !i ) 
				{
					minimum = spos[i];
					
					x = gps_weapon[i][0];
					y = gps_weapon[i][1];
					z = gps_weapon[i][2];
					
					continue;
				}
			
				if( spos[i] < minimum )
				{
					minimum = spos[i];
					
					x = gps_weapon[i][0];
					y = gps_weapon[i][1];
					z = gps_weapon[i][2];
				}
			}
		}
		//Бензоколонка
		case 3:
		{
			new
				Float:spos[ sizeof gas_station_pos ];
		
			for( new i; i < sizeof gas_station_pos; i++ )
			{
				if( gas_station_pos[i][gas_frac] ) continue;
			
				spos[i] = GetPlayerDistanceFromPoint( playerid, gas_station_pos[i][gas_pos][0], gas_station_pos[i][gas_pos][1], gas_station_pos[i][gas_pos][2] );
			
				if( !i ) 
				{
					minimum = spos[i];
					
					x = gas_station_pos[i][gas_pos][0];
					y = gas_station_pos[i][gas_pos][1];
					z = gas_station_pos[i][gas_pos][2];
					
					continue;
				}
			
				if( spos[i] < minimum )
				{
					minimum = spos[i];
					
					x = gas_station_pos[i][gas_pos][0];
					y = gas_station_pos[i][gas_pos][1];
					z = gas_station_pos[i][gas_pos][2];
				}
			}
		}
	}
}