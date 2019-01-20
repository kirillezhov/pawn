
function Job_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED ( KEY_WALK ) )
	{
		if( IsPlayerInRangeOfPoint( playerid, 2.0, job_info[0][j_start_job_pos][0], job_info[0][j_start_job_pos][1], job_info[0][j_start_job_pos][2] ) )
		{
			if( Player[playerid][uJob] == JOB_PRODUCTS )
			{
				format:g_string( job_dialog, job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
			}
			else
			{
				format:g_string( job_dialog, "Начать" );
			}
			return showPlayerDialog( playerid, d_daln, DIALOG_STYLE_LIST, "Транспортная компания", g_string, "Выбрать", "Закрыть" );
		}
		else if( IsPlayerInRangeOfPoint( playerid, 2.0, 1036.5643, -306.3587, 2076.6460 ) )
		{
			new
				world = GetPlayerVirtualWorld( playerid );
					
			SetPVarInt( playerid, "Job:Stock", world - 1 );
			return showPlayerDialog( playerid, d_daln + 2, DIALOG_STYLE_LIST, " ", dialog_stocks, "Далее", "Закрыть" );
		}
		else if( IsPlayerInRangeOfPoint( playerid, 2.0, 1033.4, -310.017, 2076.65 ) )
		{
			DeletePVar( playerid, "Job:Stock" );
		}
		else if( IsPlayerInRangeOfPoint( playerid, 2.0, job_info[1][j_start_job_pos][0], job_info[1][j_start_job_pos][1],job_info[1][j_start_job_pos][2] ) )
		{
			return showPlayerDialog( playerid, d_bus - 1, DIALOG_STYLE_LIST, "Пассажирская компания", "\
				Водитель автобуса\n\
				Водитель такси",
			"Выбрать", "Закрыть" );
		}
		else if( IsPlayerInRangeOfPoint( playerid, 2.0, job_info[2][j_start_job_pos][0], job_info[2][j_start_job_pos][1], job_info[2][j_start_job_pos][2] ) ||
			IsPlayerInRangeOfPoint( playerid, 2.0, job_info[3][j_start_job_pos][0], job_info[3][j_start_job_pos][1], job_info[3][j_start_job_pos][2] ) || 
			IsPlayerInRangeOfPoint( playerid, 2.0, job_info[4][j_start_job_pos][0], job_info[4][j_start_job_pos][1], job_info[4][j_start_job_pos][2] ) ||
			IsPlayerInRangeOfPoint( playerid, 2.0, job_info[5][j_start_job_pos][0], job_info[5][j_start_job_pos][1], job_info[5][j_start_job_pos][2] ) )
		{
			if( Player[playerid][uJob] == JOB_MECHANIC )
			{
				format:g_string( "\
					"cBLUE"1. "cWHITE"%s рабочий день\n\
					"cBLUE"2. "cWHITE"Ознакомиться с работой\n\
					"cBLUE"3. "cWHITE"Устроиться на работу", job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
			}
			else
			{
				format:g_string( "\
					"cBLUE"1. "cWHITE"Начать рабочий день\n\
					"cBLUE"2. "cWHITE"Ознакомиться с работой\n\
					"cBLUE"3. "cWHITE"Устроиться на работу" );
			}
			showPlayerDialog( playerid, d_mech, DIALOG_STYLE_LIST, "Станция тех. обслуживания", g_string, "Выбрать", "Закрыть" );
		}
		else if( IsPlayerInRangeOfPoint( playerid, 2.0, job_info[6][j_start_job_pos][0], job_info[6][j_start_job_pos][1], job_info[6][j_start_job_pos][2] ) )
		{
			if( GetPVarInt( playerid, "Job:WoodCheckpoint" ) )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Отнесите переработанную древесину на конвейер." );
				return 1;
			}
		
			if( !Player[playerid][uJob] && !Player[playerid][uMember] )
			{
				format:g_small_string( "\
					"cBLUE"1. "cWHITE"%s рабочий день\n\
					"cBLUE"2. "cWHITE"Ознакомиться с работой", job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
			}
			else
			{
				format:g_small_string( "\
					"cBLUE"1. "cWHITE"Начать рабочий день\n\
					"cBLUE"2. "cWHITE"Ознакомиться с работой" );
			}
				
			showPlayerDialog( playerid, d_wood, DIALOG_STYLE_LIST, "Лесное хозяйство", g_small_string, "Выбрать", "Закрыть" );
		}
		else if( IsPlayerInRangeOfPoint( playerid, 2.0, job_info[7][j_start_job_pos][0], job_info[7][j_start_job_pos][1], job_info[7][j_start_job_pos][2] ) )
		{
			if( Player[playerid][uJob] == JOB_FOOD )
			{
				format:g_small_string( "\
					"cBLUE"1. "cWHITE"%s рабочий день\n\
					"cBLUE"2. "cWHITE"Взять заказ на доставку\n\
					"cBLUE"3. "cWHITE"Ознакомиться с работой", job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
			}
			else
			{
				format:g_small_string( "\
					"cBLUE"1. "cWHITE"Начать рабочий день\n\
					"cBLUE"2. "cWHITE"Взять заказ на доставку\n\
					"cBLUE"3. "cWHITE"Ознакомиться с работой" );
			}
				
			showPlayerDialog( playerid, d_food, DIALOG_STYLE_LIST, "Служба доставки еды", g_small_string, "Выбрать", "Закрыть" );
		}
	}

	if( PRESSED ( KEY_CROUCH ) )
	{
		//Загрузка товаров для бизнеса
		if( IsPlayerInRangeOfPoint( playerid, 7.0, 1078.9844, -340.3599, 73.9922 ) )
		{
			if( job_duty{playerid} && Player[playerid][uJob] == 3 )
			{
				if( IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER &&
					GetPlayerVehicleID( playerid ) >= cars_prod[0] && GetPlayerVehicleID( playerid ) <= cars_prod[1] )
				{

					switch( GetVehicleModel( GetPlayerVehicleID( playerid ) ) )
					{
						case 499,414:
						{
							if( GetPVarInt( playerid, "Load:Products" ) )
								return SendClient:( playerid, C_GRAY, ""gbError"Вы уже загрузились." );
								
							format:g_string( load_products, MAX_PRODUCTS_INCAR );
							return showPlayerDialog( playerid, d_daln + 3, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
						}
					}
				}
			}
		}
		//Разгрузка прицепа
		if( Job[playerid][j_trailerid] && IsPlayerInAnyVehicle( playerid )
			&& GetPlayerState( playerid ) == PLAYER_STATE_DRIVER && IsTrailerAttachedToVehicle( Job[playerid][j_vehicleid] )
		)
		{
			for( new j; j < MAX_STOCKS; j++ )
			{
				if( IsPlayerInRangeOfPoint( playerid, 10.0, Server[j][s_pos_unload][0], Server[j][s_pos_unload][1], Server[j][s_pos_unload][2] ) )
				{
					if( j == GetPVarInt( playerid, "Job:StockLoad" ) )
						return SendClient:( playerid, C_WHITE, ""gbError"Вы не можете разгрузить товар на этом складе!" );
					
					if( GetPlayerVehicleID( playerid ) >= cars_prod[0] && GetPlayerVehicleID( playerid ) <= cars_prod[1] )
					{
						switch( GetVehicleModel( GetPlayerVehicleID( playerid ) ) )
						{
							case 403,514,515:
							{
								new
									vid = Job[playerid][j_vehicleid],
									product;
								
								product = GetPVarInt( playerid, "Job:SelectProduct" );
								SetPVarInt( playerid, "Job:StockUnload", j );
							
								format:g_string( "\
									"cWHITE"Укажите, какое количество тонн Вы хотите разгрузить:\n\n\
									На складе: "cBLUE"%d"cWHITE"\n\
									Цена за 1 тонну: "cBLUE"$%d"cWHITE"\n\n\
									"gbDialog"В вашем прицепе "cBLUE"%d"cWHITE" т.",
									Server[j][s_value][product],
									GetPriceForProducts( product, Server[j][s_value][product] ),
									VehicleJob[vid][v_count_tons][product]
								);
								
								format:g_small_string( ""cBLUE"%s", name_products[product] );
								return showPlayerDialog( playerid, d_daln + 9, DIALOG_STYLE_INPUT, g_small_string, g_string, "Далее", "Назад" );
							}	
						}
					}
				}
			}
		}
	}
	return 1;
}

Job_OnGameModeInit()
{
	mysql_tquery( mysql, "SELECT * FROM `"DB_SERVER"`", "LoadValuesServer" );
	mysql_tquery( mysql, "SELECT * FROM `"DB_BUSINESS_ORDERS"`", "LoadOrderProducts" );
	
	for( new i; i < MAX_ROUTES; i++ )
	{
		mysql_format:g_string( "SELECT * FROM `"DB_ROUTES"` WHERE `r_route` = %d ORDER BY `r_id`", routes[i] );
		mysql_tquery( mysql, g_string, "LoadCheckpoints", "i", i );
	}
	
	cars_prod[0] = CreateVehicleEx( 514, 2209.7996, -2205.6858, 14.1584, 225.9467, 113, 1, 800 );
	CreateVehicleEx( 514, 2205.8357, -2209.5637, 14.1266, 224.4389, 75, 1, 800 );
	CreateVehicleEx( 514, 2202.4187, -2212.9319, 14.1137, 226.7155, 54, 1, 800 );
	CreateVehicleEx( 514, 2198.4260, -2216.8774, 14.1591, 224.9003, 40, 1, 800 );
	CreateVehicleEx( 514, 2195.0054, -2220.2231, 14.1135, 224.8400, 36, 1, 800 );
	CreateVehicleEx( 514, 2191.0068, -2224.2302, 14.1546, 224.9515, 28, 1, 800 );
	CreateVehicleEx( 514, 2187.7905, -2227.3909, 14.0757, 223.8284, 25, 1, 800 );
	CreateVehicleEx( 514, 2183.6467, -2231.5796, 14.0272, 224.4547, 10, 1, 800 );
	CreateVehicleEx( 515, 2206.0527, -2275.6997, 14.5296, 44.9607, 39, 78, 800 );
	CreateVehicleEx( 515, 2213.2498, -2268.1726, 14.5319, 44.7891, 54, 77, 800 ); 
	CreateVehicleEx( 515, 2220.6802, -2260.8777, 14.5500, 45.5307, 42, 76, 800 ); 
	CreateVehicleEx( 515, 2228.2593, -2253.3372, 14.5790, 45.0003, 63, 78, 800 ); 
	CreateVehicleEx( 515, 2235.4800, -2245.9099, 14.5794, 45.1031, 24, 77, 800 ); 
	CreateVehicleEx( 515, 2175.5137, -2267.9636, 14.4554, 224.9774, 11, 76, 800 ); 
	CreateVehicleEx( 515, 2168.0588, -2275.2498, 14.4541, 224.9661, 62, 77, 800 ); 
	CreateVehicleEx( 515, 2161.3745, -2282.0010, 14.4545, 224.9626, 13, 76, 800 ); 
	CreateVehicleEx( 414, 2196.2290, -2291.6904, 13.6324, 45.0000, 28, 1, 800 ); 
	CreateVehicleEx( 414, 2193.2454, -2294.6487, 13.6284, 45.0000, 43, 1, 800 ); 
	CreateVehicleEx( 414, 2190.2957, -2297.6396, 13.6270, 45.0000, 67, 1, 800 ); 
	CreateVehicleEx( 414, 2187.0635, -2300.7290, 13.6277, 45.0376, 72, 1, 800 );
	CreateVehicleEx( 414, 2183.9680, -2303.8867, 13.6717, 45.0472, 9, 1, 800 ); 
	CreateVehicleEx( 499, 2163.1025, -2312.3413, 13.5577, 315.0000, 112, 32, 800 );
	CreateVehicleEx( 499, 2166.7268, -2316.0613, 13.5454, 315.0000, 10, 32, 800 );
	CreateVehicleEx( 499, 2170.4250, -2319.7185, 13.5454, 315.0000, 109, 32, 800 );
	cars_prod[1] = CreateVehicleEx( 499, 2174.0227, -2323.3208, 13.5454, 315.0000, 30, 44, 800 );
	
	cars_bus[0] = CreateVehicleEx( 431, 1088.6610, -1336.4084, 13.8003, 181.2671, 2, 7, 800);
	CreateVehicleEx( 431, 1084.2358, -1336.5458, 13.8026, 180.5430, 12, 41, 800);
	CreateVehicleEx( 431, 1085.2113, -1378.4407, 13.7983, 0.9040, 12, 1, 800);
	CreateVehicleEx( 431, 1089.7904, -1378.4021, 13.8043, 0.4196, 15, 11, 800);
	CreateVehicleEx( 437, 1094.2772, -1378.1305, 13.8342, 0.3774, 26, 35, 800);
	CreateVehicleEx( 437, 1098.8201, -1378.0939, 13.8341, 0.7661, 32, 41, 800);
	CreateVehicleEx( 437, 1103.5282, -1378.0840, 13.8351, 0.2916, 22, 52, 800);
	cars_bus[1] = CreateVehicleEx( 437, 1108.2139, -1378.0463, 13.8338, 359.3697, 3, 5, 800);
	
	cars_taxi[0] = CreateVehicleEx( 420, 1138.9656, -1380.7704, 13.4805, 359.9228, 6, 6, 800);
	CreateVehicleEx( 420, 1142.3777, -1380.7736, 13.4802, 0.3241, 6, 6, 800);
	CreateVehicleEx( 420, 1145.6788, -1380.7094, 13.4798, 0.9917, 6, 6, 800);
	CreateVehicleEx( 420, 1148.9795, -1380.6543, 13.5123, 0.0248, 6, 6, 800);
	CreateVehicleEx( 420, 1152.4445, -1380.5811, 13.4799, 0.0589, 6, 6, 800);
	CreateVehicleEx( 420, 1155.8571, -1380.5277, 13.4799, 0.3464, 6, 6, 800);
	CreateVehicleEx( 420, 1159.3225, -1380.5387, 13.4801, 359.8059, 6, 6, 800);
	CreateVehicleEx( 438, 1096.6525, -1315.5955, 13.7075, 178.2276, 6, 6, 800);
	CreateVehicleEx( 438, 1083.9546, -1352.2943, 13.7053, 270.3152, 6, 6, 800);
	CreateVehicleEx( 438, 1083.9337, -1355.8673, 13.7183, 268.7615, 6, 6, 800);
	CreateVehicleEx( 438, 1092.2780, -1331.2341, 13.7079, 178.6375, 6, 6, 800);
	CreateVehicleEx( 438, 1092.4540, -1323.9032, 13.7047, 177.9180, 6, 6, 800);
	cars_taxi[1] = CreateVehicleEx( 438, 1092.7427, -1315.3553, 13.7032, 177.8105, 6, 6, 800);
	
	cars_food[0] = CreateVehicleEx( 448, 1684.0359, -1457.8495, 13.0326, 190.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1682.5750, -1457.8495, 13.0326, 190.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1681.1140, -1457.8495, 13.0326, 190.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1679.6530, -1457.8495, 13.0326, 190.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1678.1920, -1457.8495, 13.0326, 190.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1676.7310, -1457.8495, 13.0326, 190.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1676.8003, -1463.0789, 13.0326, -10.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1678.2614, -1463.0789, 13.0326, -10.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1679.7224, -1463.0789, 13.0326, -10.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1681.1833, -1463.0789, 13.0326, -10.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1682.6443, -1463.0789, 13.0326, -10.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1691.8973, -1463.0789, 13.0326, 0.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1690.4363, -1463.0789, 13.0326, 0.0000, 6, 6, 600);
	CreateVehicleEx( 448, 1688.9753, -1463.0789, 13.0326, 0.0000, 6, 6, 600);
	cars_food[1] = CreateVehicleEx( 448, 1687.5143, -1463.0789, 13.0326, 0.0000, 6, 6, 600);
	
	cars_mech[0] = CreateVehicleEx( 525, 2115.3391, -2159.0637, 13.4285, 271.5066, 0, 6, 800);
	CreateVehicleEx( 525, 2115.2493, -2163.1753, 13.4192, 268.7713, 0, 6, 800);
	CreateVehicleEx( 525, 2115.1304, -2167.5986, 13.4186, 269.6750, 0, 6, 800);
	CreateVehicleEx( 525, 2531.6050, -1565.5406, 23.8841, 359.9694, 0, 6, 800);
	CreateVehicleEx( 525, 2535.5249, -1561.8462, 23.8818, 359.5813, 0, 6, 800);
	CreateVehicleEx( 525, 962.1224, -1346.8033, 13.3986, 270.8239, 0, 6, 800);
	CreateVehicleEx( 525, 953.7838, -1341.7584, 13.4012, 269.3483, 0, 6, 800);
	CreateVehicleEx( 525, 941.6079, -1341.6844, 13.3962, 269.4840, 0, 6, 800);
	CreateVehicleEx( 525, 1363.7050, 179.6716, 19.4056, 64.8417, 0, 6, 800);
	CreateVehicleEx( 525, 1339.5536, 200.4823, 19.4446, 247.1877, 0, 6, 800);
	cars_mech[1] = CreateVehicleEx( 525, 1337.8184, 196.4582, 19.4406, 246.0448, 0, 6, 800);
	
	for( new i = cars_prod[0]; i != cars_mech[1] + 1; i++ )
	{
		VehicleJob[i][v_passenger] =
		VehicleJob[i][v_driverid] = INVALID_PARAM;
	}
	
	for( new t; t < MAX_TAXICALLS; t++ )
	{
		Taxi[t][t_playerid] = 
		Mechanic[t][m_playerid] = 
		g_dialog_taxi[t] = 
		g_dialog_mech[t] = INVALID_PARAM;
	}

	for( new j; j < sizeof job_info; j++ )
	{
		CreateDynamicPickup( 1210, 23, job_info[j][j_start_job_pos][0], job_info[j][j_start_job_pos][1], job_info[j][j_start_job_pos][2], -1  );

		format:g_string( "%s", job_info[j][j_name] );
		CreateDynamic3DTextLabel( g_string, 0xFFFFFFFF, job_info[j][j_start_job_pos][0], job_info[j][j_start_job_pos][1], job_info[j][j_start_job_pos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1 );
	}
	
	for( new k; k < MAX_ZONES_REPAIR; k++ )
	{
		area_repair[k] = CreateDynamicRectangle( zone_repair[k][0], zone_repair[k][1], zone_repair[k][2], zone_repair[k][3], 0, 0, INVALID_PARAM ); 
	}
	
	for( new i; i < sizeof Woods; i++ ) 
	{
		WoodInfo[i][w_zone] = CreateDynamicSphere( Woods[i][0], Woods[i][1], Woods[i][2], 1.5 );
		WoodInfo[i][w_object] = CreateDynamicObject( 660, Woods[i][0], Woods[i][1], Woods[i][2], 0.0, 0.0, 0.0 );
		
		WoodInfo[i][w_use] = 
		WoodInfo[i][w_drop] = false;
		
		WoodInfo[i][w_count] = 100;
		WoodInfo[i][w_time] = 0;
	}
	WOOD_ZONE = CreateDynamicRectangle( -587.9761, -184.3508, -422.3939, -39.3727, 0, 0, -1 );
	
	WOOD_OBJECT[0] = CreateDynamicObject(684,-504.292,-64.833,1801.610,-0.200,20.000,-90.000,-1,-1,-1,300.000,300.000); 
	WOOD_OBJECT[1] = CreateDynamicObject(684,-563.095,-64.833,1801.721,-0.200,20.000,-90.000,-1,-1,-1,300.000,300.000); 
	
	for( new i; i < 2; i++ )
	{
		SetDynamicObjectMaterial(WOOD_OBJECT[i], 0, -1, "none", "none", 0xFFFFFFFF); 
		SetDynamicObjectMaterial(WOOD_OBJECT[i], 1, 19480, "signsurf", "sign", 0x00000000);
		MoveDynamicObject( WOOD_OBJECT[i], -536.095, -64.833, 1801.721, 0.4, -0.200, 20.000, -90.000 );
	}
	
	CreateDynamic3DTextLabel( "[ Загрузка товаров ]\n\nНажмите "cBLUE"H", 0xFFFFFFFF, 1078.9844, -340.3599, 73.9922, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1 );

	CreateDynamicPickup( 1239, 23, 1036.5643, -306.3587, 2076.6460, -1 ); //Пикап работы на складах

	//Иконки складов
	CreateDynamicMapIcon( 2398.88, -2221.9, 13.5413, 51, 0, -1, -1, -1, 2000.0 ); //Склад Ocean Docks
	CreateDynamicMapIcon( 1032.95, -319.576, 73.9922, 51, 0, -1, -1, -1, 2000.0 ); //Склад Hilltop Farms
	CreateDynamicMapIcon( -49.7751, -269.388, 6.6332, 51, 0, -1, -1, -1, 2000.0 ); //Склад Blueberry 48 Road
	CreateDynamicMapIcon( -1717.2, -125.997, 3.5489, 51, 0, -1, -1, -1, 2000.0 ); //Склад Doherty
	CreateDynamicMapIcon( 2361.91, 2778.53, 10.8203, 51, 0, -1, -1, -1, 2000.0 ); //Склад Spinybed
	
	//Иконки СТО
	CreateDynamicMapIcon( 943.7028, -1390.7491, 13.2598, 27, 0, -1, -1, -1, 500.0 ); //Market
	CreateDynamicMapIcon( 2529.4634, -1508.7498, 23.8300, 27, 0, -1, -1, -1, 500.0 ); //Bell
	CreateDynamicMapIcon( 1364.2821, 210.8708, 19.4063, 27, 0, -1, -1, -1, 500.0 ); //Simpson
	CreateDynamicMapIcon( 2120.4001, -2152.9995, 13.5469, 27, 0, -1, -1, -1, 500.0 ); //Harbor
	
	//Иконки Оружейных магазинов
	CreateDynamicMapIcon( 1368.78, -1279.79, 13.5469, 6, 0, -1, -1, -1, 500.0 ); 
	CreateDynamicMapIcon( 2400.38, -1981.39, 13.5469, 6, 0, -1, -1, -1, 500.0 ); 
	CreateDynamicMapIcon( 2333.57, 61.6305, 26.7058, 6, 0, -1, -1, -1, 500.0 ); 
	CreateDynamicMapIcon( 242.922, -178.37, 1.5822, 6, 0, -1, -1, -1, 500.0 ); 
	
	//Иконки АЗС
	CreateDynamicMapIcon( 1002.9230, -936.0809, 48.2118, 47, 0, -1, -1, -1, 500.0 );
	CreateDynamicMapIcon( 1939.6833, -1772.3999, 13.3906, 47, 0, -1, -1, -1, 500.0 );
	CreateDynamicMapIcon( 1382.2324, 461.4151, 20.0923, 47, 0, -1, -1, -1, 500.0 );
	CreateDynamicMapIcon( -1605.8776, -2714.5972, 48.5391, 47, 0, -1, -1, -1, 500.0 );
	CreateDynamicMapIcon( -2243.7910, -2561.7322, 31.9219, 47, 0, -1, -1, -1, 500.0 );
	CreateDynamicMapIcon( -91.4068, -1170.7679, 2.3892, 47, 0, -1, -1, -1, 500.0 );
	
	//Иконки автосалонов
	CreateDynamicMapIcon( 557.1735, -1256.6133, 17.2422, 55, 0, -1, -1, -1, 500.0 );
	CreateDynamicMapIcon( 842.3514, -1040.9869, 25.2378, 55, 0, -1, -1, -1, 500.0 );
	CreateDynamicMapIcon( 1365.5477, 409.2536, 19.4063, 55, 0, -1, -1, -1, 500.0 );
	
	//Иконка банка
	CreateDynamicMapIcon( 1461.6461, -1011.0612, 26.8438, 52, 0, -1, -1, -1, 500.0 );
	
	//3D текст загрузки
	Server[0][s_load_text] = CreateDynamic3DTextLabel( ""cBLUE"Очередь на загрузку:", -1, 2391.6731, -2215.3848, 17.5413, 15.0 );
	Server[1][s_load_text] = CreateDynamic3DTextLabel( ""cBLUE"Очередь на загрузку:", -1, 1018.9197, -321.5060, 78.9922, 15.0 );
	Server[2][s_load_text] = CreateDynamic3DTextLabel( ""cBLUE"Очередь на загрузку:", -1, -23.1886, -269.3631, 9.4297, 15.0 );
	Server[3][s_load_text] = CreateDynamic3DTextLabel( ""cBLUE"Очередь на загрузку:", -1, -1721.2806, -116.7817, 9.5489, 15.0 );
	Server[4][s_load_text] = CreateDynamic3DTextLabel( ""cBLUE"Очередь на загрузку:", -1, 2368.2600, 2760.1504, 12.8203, 15.0 );
}

/*Job_OnGameModeExit( playerid )
{

	if( GetPVarInt( playerid, "Job:Wood" ) )
	{
		if( GetPVarInt( playerid, "Job:WoodCheckpoint" ) )
		{		
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_NONE );
			
			DisablePlayerCheckpoint( playerid );
			DeletePVar( playerid, "Job:WoodCheckpoint" );
		}
		
		RemovePlayerAttachedObject( playerid, 9 );
		DeletePVar( playerid, "Job:Wood" );
	}
	
	return 1;
}*/

function Job_OnDynamicObjectMoved( objectid )
{
	//Движение бревна в интерьере лесопилки
	if( objectid == WOOD_OBJECT[0] )
	{
		SetDynamicObjectPos( objectid, -504.292, -64.833, 1801.610 );
		MoveDynamicObject( objectid, -536.095, -64.833, 1801.721, 0.4, -0.200, 20.000, -90.000 );
	}
	else if( objectid == WOOD_OBJECT[1] )
	{
		SetDynamicObjectPos( objectid, -563.095, -64.833, 1801.721 );
		MoveDynamicObject( objectid, -536.095, -64.833, 1801.721, 0.4, -0.200, 20.000, -90.000 );
	}

	return 1;
}

function LoadValuesServer()
{
	for( new i; i < MAX_STOCKS; i++ )
	{
		clean:<g_small_string>;
		cache_get_field_content( i, "s_name", g_small_string, mysql );
		strmid( Server[i][s_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );

		Server[i][s_value][0] = cache_get_field_content_int( i, "s_alcohol", mysql );
		Server[i][s_value][1] = cache_get_field_content_int( i, "s_water", mysql );
		Server[i][s_value][2] = cache_get_field_content_int( i, "s_dioxide", mysql );
		Server[i][s_value][3] = cache_get_field_content_int( i, "s_clothes", mysql );
		Server[i][s_value][4] = cache_get_field_content_int( i, "s_part", mysql );
		Server[i][s_value][5] = cache_get_field_content_int( i, "s_materials", mysql );

		clean:<g_small_string>;
		cache_get_field_content( i, "s_unload", g_small_string, mysql, 128 );
		sscanf( g_small_string,"p<|>a<f>[3]", Server[i][s_pos_unload] );

		CreateDynamic3DTextLabel( "[ Разгрузка ]\n\nНажмите "cBLUE"H", 0xFFFFFFFF, Server[i][s_pos_unload][0], Server[i][s_pos_unload][1], Server[i][s_pos_unload][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1 );
	}

	return 1;
}

function LoadOrderProducts()
{
	clean_array();

	new
		rows = cache_get_row_count( );

	if( rows )
	{
		for( new b; b < rows; b++ )
		{
			ProductsInfo[b][b_business_id] = cache_get_field_content_int( b, "b_business_id", mysql );

			ProductsInfo[b][b_count] = cache_get_field_content_int( b, "b_order_products", mysql );

			ProductsInfo[b][b_count_time] = ProductsInfo[b][b_count];

			for( new j; j < MAX_BUSINESS; j++ )
			{
				if( BusinessInfo[j][b_id] == ProductsInfo[b][b_business_id] )
				{
					ProductsInfo[b][b_id] = j;
					BusinessInfo[j][b_status_prod] = true;
					break;
				}
			}
		}
	}

	return 1;
}

CreateOrder( order )
{
	mysql_format:g_small_string( "INSERT INTO `"DB_BUSINESS_ORDERS"` \
		( `b_business_id`, `b_order_products` ) VALUES \
		( '%d', '%d' )",
		ProductsInfo[order][b_business_id],
		ProductsInfo[order][b_count]
	);

	mysql_tquery( mysql, g_small_string );

	return 1;
}

UpdateOrder( order )
{
	mysql_format:g_string( "UPDATE `"DB_BUSINESS_ORDERS"` \
	SET `b_order_products` = %d \
	WHERE `b_business_id` = %d LIMIT 1",
		ProductsInfo[order][b_count],
		ProductsInfo[order][b_business_id]
	);

	mysql_tquery( mysql, g_string );

	return 1;
}

DeleteOrder( order )
{
	mysql_format:g_string( "DELETE FROM `"DB_BUSINESS_ORDERS"` WHERE `b_business_id` = %d", ProductsInfo[order][b_business_id] );

	mysql_tquery( mysql, g_string );

	return 1;
}

UpdateTurnLoad( jstock )
{
	clean:<g_big_string>;

	strcat( g_big_string, ""cBLUE"Очередь на загрузку:"cWHITE"" );
	
	for( new i; i < MAX_LISTITEM_LOAD; i++ )
	{
		if( job_load_truck[jstock][i] )
		{
			foreach(new j: Player)
			{
				if( job_load_truck[jstock][i] == Player[j][uID] )
				{
					format:g_string( "\n%i. %s", i + 1, Player[j][uRPName] );
					strcat( g_big_string, g_string );
					break;
				}
			}
		}
	}
	
	UpdateDynamic3DTextLabelText( Server[jstock][s_load_text], C_WHITE, g_big_string );
}

CreateTrailerForPlayer( jstock, playerid )
{
	if( job_load_truck[jstock][0] == Player[playerid][uID] && IsLogged( playerid ) )
	{
		new
			model = GetPVarInt( playerid, "Job:TrailerModel" );

		SendClient:( playerid, C_GRAY, ""gbDefault"Подошла очередь для загрузки. У Вас есть минута, чтобы забрать прицеп." );
		SetTimerEx( "OnTimerDestroyTrailer", 60000, false, "dd", jstock, playerid );

		Job[playerid][j_trailerid] = CreateVehicle( model, create_pos_trailer[jstock][0], create_pos_trailer[jstock][1], create_pos_trailer[jstock][2], create_pos_trailer[jstock][3], INVALID_PARAM, INVALID_PARAM, INVALID_PARAM );

		SetPVarInt( playerid, "Job:CreateTrailer", 1 );
	}

	return 1;
}

OpenListOrders( playerid )
{
	new
		count = 0;

	clean:<g_big_string>;

	strcat( g_big_string, "Номер\tКоличество\tБизнес\n" );

	for( new i; i < MAX_PRODUCT_INFO; i ++ )
	{
		if( ProductsInfo[i][b_count_time] )
		{
			format:g_small_string( ""cWHITE"Заказ #%i\t"cBLUE"%d тов.\t"cWHITE"%s #%d\n",
				i + 1, ProductsInfo[i][b_count_time], GetBusinessType( ProductsInfo[i][b_id] ), ProductsInfo[i][b_business_id] );

			strcat( g_big_string, g_small_string );

			g_dialog_select[playerid][count] = i;

			count++;
		}
	}

	if( !count )
	{
		return SendClient:( playerid, C_WHITE, ""gbError"В данный момент активных заказов нет!" );
	}

	return showPlayerDialog( playerid, d_daln + 4, DIALOG_STYLE_TABLIST_HEADERS, "Информационное окно", g_big_string, "Далее", "Закрыть" );
}


Job_OnPlayerEnterCheckpoint( playerid )
{
	if( GetPVarInt( playerid, "Job:Box" ) )
	{
		new
			order = GetPVarInt( playerid, "Job:SelectOrder" ),
			vid = Job[playerid][j_vehicleid],
			bid = ProductsInfo[order][b_id],
			earn; //Деньги, которые получает развозчик, при доставке заказа

		if( IsPlayerInRangeOfPoint( playerid, 2.0, BusinessInfo[bid][b_enter_pos][0], BusinessInfo[bid][b_enter_pos][1], BusinessInfo[bid][b_enter_pos][2] ) )
		{
			if( GetPVarInt( playerid, "Job:UnloadCount" ) != Job[playerid][j_count] && VehicleJob[vid][v_count_prod] )
			{			
				Job[playerid][j_count_order] -= MAX_BOX_PRODUCTS;
				
				BusinessInfo[bid][b_products] += MAX_BOX_PRODUCTS;
				UpdateBusiness( bid, "b_products", BusinessInfo[bid][b_products] );

				VehicleJob[vid][v_count_prod] -= MAX_BOX_PRODUCTS;
				ProductsInfo[order][b_count] -= MAX_BOX_PRODUCTS;
				
				earn = floatround( BusinessInfo[bid][b_product_price] * MAX_BOX_PRODUCTS / 100 * 3 );
				Job[playerid][j_earn] += earn;
				
				Player[playerid][uCheck] += earn;
				UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
				
				pformat:( ""gbDefault"Вы разгрузили "cBLUE"%d"cWHITE" ящик. В Вашей машине еще "cBLUE"%d"cWHITE" товаров.", GetPVarInt( playerid, "Job:UnloadCount" ), VehicleJob[vid][v_count_prod] );
				psend:( playerid, C_WHITE );
				
				GivePVarInt( playerid, "Job:UnloadCount", 1 );
				DeletePVar( playerid, "Job:Box" );
			}
			else
			{
				BusinessInfo[bid][b_products] += Job[playerid][j_count_order];
				UpdateBusiness( bid, "b_products", BusinessInfo[bid][b_products] );

				VehicleJob[vid][v_count_prod] -= Job[playerid][j_count_order];
				ProductsInfo[order][b_count] -= Job[playerid][j_count_order];

				earn = floatround( BusinessInfo[bid][b_product_price] * Job[playerid][j_count_order] / 100 * 3 );
					
				Job[playerid][j_earn] += earn;
				Player[playerid][uCheck] += earn;
				UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );

				Job[playerid][j_count_order] = 0;
				
				DestroyDynamicArea( Job[playerid][j_zone_unload] );
				Job[playerid][j_zone_unload] = 0;

				pformat:( ""gbSuccess"Фургон полностью разгружен. Вы заработали "cBLUE"$%d"cWHITE".", Job[playerid][j_earn] );
				psend:( playerid, C_WHITE );

				if( VehicleJob[vid][v_count_prod] )
				{
					pformat:( ""gbDefault"В Вашей машине еще "cBLUE"%d"cWHITE" товаров, используйте "cBLUE"/job"cWHITE", чтобы выбрать другой заказ.", VehicleJob[vid][v_count_prod] );
					psend:( playerid, C_WHITE );
				}

				if( !ProductsInfo[order][b_count] )
				{
					DeleteOrder( order );
				}
				else
				{
					UpdateOrder( order );
				}

				CheckVehicleParams( vid );
				Vehicle[vid][vehicle_state_boot] = false;
				SetVehicleParams( vid );
				
				DeletePVar( playerid, "Job:SetCheckPointProd" );
				DeletePVar( playerid, "Job:SelectOrder" );
				DeletePVar( playerid, "Job:Box" );
				DeletePVar( playerid, "Job:UnloadCount" );
				DeletePVar( playerid, "Job:Unload" );
				DeletePVar( playerid, "Load:Products" );
			}
			
			ApplyAnimation(playerid,"CARRY","putdwn",4.1,0,1,1,0,1000,1);
			
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_NONE );
			RemovePlayerAttachedObject( playerid, 5 );
			
			format:g_small_string( "Products: %d", VehicleJob[vid][v_count_prod] );
			PlayerTextDrawSetString( playerid, Taximeter[playerid], g_small_string );
		}
	}

	//Отметка на карте
	if( GetPVarInt( playerid, "Taxi:Route" ) && IsPlayerInAnyVehicle( playerid ) )
	{
		DeletePVar( playerid, "Taxi:Route" );
		DisablePlayerCheckpoint( playerid );
	}
	
	if( GetPVarInt( playerid, "Mech:Accept" ) )
	{
		Player[DeletePVar( playerid, "Mech:Callid" )][jMech] = false;
		Job[playerid][j_mech] = false;
		
		DeletePVar( playerid, "Mech:Accept" );
		DeletePVar( playerid, "Mech:Callid" );
	}
	//Чекпоинты в лесном хозяйстве
	if( GetPVarInt( playerid, "Job:WoodCheckpoint" ) ) 
	{
		if( IsPlayerInRangeOfPoint( playerid, 3.0, -482.8413, -88.6971, 60.7133 ) ) 
		{
			DisablePlayerCheckpoint( playerid );
	        DeletePVar( playerid, "Job:WoodCheckpoint" );
			
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_NONE );
			ClearAnimations( playerid );
			ApplyAnimation( playerid, "CARRY", "putdwn", 4.1, 0, 1, 1, 0, 1000, 1 );
			
			RemovePlayerAttachedObject( playerid, 9 );
	        SetPlayerAttachedObject( playerid, 9, 341, 6 );
			
			Job[playerid][j_earn] += EARN_FOR_WOOD;
			Player[playerid][uCheck] += EARN_FOR_WOOD;
			UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
			
			Job[playerid][j_object_wood] = CreateDynamicObject( 1463, -482.71729, -86.98010, 60.59190, -34.0, 0.0, -90.0 );
	        MoveDynamicObject( Job[playerid][j_object_wood], -482.71729, -77.47610, 60.59190, 1, -34.0, 0.0, -90.0 );
			Job[playerid][j_time_wood] = gettime() + 10;

			format:g_small_string( "положил%s древесину на конвейер", SexTextEnd( playerid ) );
	        MeAction( playerid, g_small_string, 1 );
	    }
	}
	//Чекпоинты в службе доставки
	if( GetPVarInt( playerid, "Job:Food" ) ) 
	{
		new
			house = GetPVarInt( playerid, "Job:FoodHouse" ),
			distance,
			price;
	
		if( IsPlayerInRangeOfPoint( playerid, 3.0, HouseInfo[house][hEnterPos][0], HouseInfo[house][hEnterPos][1], HouseInfo[house][hEnterPos][2] ) ) 
		{
			DisablePlayerCheckpoint( playerid );
			RemovePlayerAttachedObject( playerid, 9 );
			
			distance = GetDistanceBetweenPoints( 1685.2498, -1463.9598, 13.5469, HouseInfo[house][hEnterPos][0], HouseInfo[house][hEnterPos][1], HouseInfo[house][hEnterPos][2] );
			
			price += floatround( distance * 0.05 );
			
			if( GetPVarInt( playerid, "Job:FoodSpeed" ) )
			{
				price += floatround( distance * 0.05 * 0.2 );
				
				pformat:( ""gbSuccess"Еда успешно доставлена, Вы заработали "cBLUE"$%d"cWHITE" (+ 20%% за скорость). Деньги перечислены на чековую книжку.", price );
				psend:( playerid, C_WHITE );
			}
			else
			{
				pformat:( ""gbSuccess"Еда успешно доставлена, Вы заработали "cBLUE"$%d"cWHITE". Деньги перечислены на чековую книжку.", price );
				psend:( playerid, C_WHITE );
			}
			
			SendClient:( playerid, C_WHITE, !""gbDefault"Возьмите новый заказ в службе доставки." );
			
			Job[playerid][j_earn] += price;
			Player[playerid][uCheck] += price;
			UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
			
			DeletePVar( playerid, "Job:Food" );
			DeletePVar( playerid, "Job:FoodSpeed" );
			DeletePVar( playerid, "Job:FoodHouse" );
		}
	}
	
	return 1;
}

Job_OnPlayerEnterDynamicArea( playerid, areaid ) 
{
	if( GetPVarInt( playerid, "Job:Unload" ) && areaid == Job[playerid][j_zone_unload] && !GetPVarInt( playerid, "Job:Box" ) )
	{
		new 
			order = GetPVarInt( playerid, "Job:SelectOrder" ),
			bid = ProductsInfo[order][b_id];
		
		ClearAnimations( playerid );
		RemovePlayerAttachedObject( playerid, 5 );
		ApplyAnimation( playerid, "CARRY", "liftup", 4.1, 0, 1, 1, 0, 1000, 1 );
			
		MeAction( playerid, "достает коробку", 1 );
			
		SetPlayerAttachedObject( playerid, 5, 1271, 5, 0.086, 0.214, 0.212, 7.6, 9.9, 2.2, 0.749, 0.636, 0.821 );
		SetPlayerSpecialAction( playerid, SPECIAL_ACTION_CARRY );
			
		SetPlayerCheckpoint( playerid, BusinessInfo[bid][b_enter_pos][0], BusinessInfo[bid][b_enter_pos][1], BusinessInfo[bid][b_enter_pos][2], 1.0 );
		SetPVarInt( playerid, "Job:Box", 1 );
	}
	
	if( WoodInfo[0][w_zone] <= areaid < WoodInfo[sizeof Woods - 1][w_zone] ) 
	{
		if( job_duty{playerid} && !Player[playerid][uJob] && 
			!Player[playerid][uMember] && 
			!GetPVarInt( playerid, "Job:WoodCheckpoint" ) &&
			GetPVarInt( playerid, "Job:Wood" ) )
		{
			new
				wood = areaid - WoodInfo[0][w_zone];
			
			if( WoodInfo[wood][w_use] )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Это дерево обрабатывает другой человек." );
				return 1;
			}
			
			if( WoodInfo[wood][w_count] > 0 ) 
			{
				if( !WoodInfo[wood][w_drop] )
				{
					WoodInfo[wood][w_use] = true;
					SetTimerEx( "OnTimerWood", 10000, false, "ddd", playerid, wood, 0 );
					
					togglePlayerControllable( playerid, false );
					
					ClearAnimations( playerid );
					ApplyAnimation( playerid, "CHAINSAW", "WEAPON_csaw", 1.0, 1, 0, 0, 0, 10000, 1 );
					
					MeAction( playerid, "пилит дерево", 1 );
				}
				else
				{
					SetTimerEx( "OnTimerWood", 10000, false, "ddd", playerid, wood, 1 );
					togglePlayerControllable( playerid, false );
						
					ClearAnimations( playerid );
					ApplyAnimation( playerid, "CHAINSAW", "CSAW_G", 1.0, 1, 0, 0, 0, 10000, 1 );
					
					MeAction( playerid, "пилит дерево", 1 );
				}
			}
		}
	}
	
	return 1;
}

Job_OnPlayerLeaveDynamicArea( playerid, areaid )
{
	if( areaid == WOOD_ZONE && GetPVarInt( playerid, "Job:Wood" ) )
	{
		if( GetPVarInt( playerid, "Job:WoodCheckpoint" ) )
		{		
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_NONE );
			
			DisablePlayerCheckpoint( playerid );
			DeletePVar( playerid, "Job:WoodCheckpoint" );
		}
		
		RemovePlayerAttachedObject( playerid, 9 );
		DeletePVar( playerid, "Job:Wood" );
		SendClient:( playerid, C_WHITE, ""gbDefault"Вы покинули территорию лесного хозяйства. Завершите рабочий день." );
		
		SetPlayerSkin( playerid, setUseSkin( playerid, true ) );
	}
	return 1;
}

//Если игрок взрывает транспорт
Job_OnVehicleDeath( vehicleid, killerid )
{
	if( vehicleid == Job[killerid][j_vehicleid] )
	{
		CheckIsMadeOrder( killerid );
		
		if( Job[killerid][j_trailerid] && vehicleid != Job[killerid][j_trailerid] )
		{
			new
				product = GetPVarInt( killerid, "Job:SelectProduct" ),
				jstock = GetPVarInt( killerid, "Job:StockLoad" ),
				vid = Job[killerid][j_vehicleid];
				
			if( Server[jstock][s_value][product] + VehicleJob[vid][v_count_tons][product] > MAX_COUNT_STOCKS )
			{
				Server[jstock][s_value][product] = MAX_COUNT_STOCKS;
			}
			else
			{
				Server[jstock][s_value][product] += VehicleJob[vid][v_count_tons][product];
			}
			
			UpdateValueServer( jstock, product );
			DestroyVehicle( Job[killerid][j_trailerid] );
			printf( "[Log]: Destroy job trailer ID: %d = killerid %s[%d].", Job[killerid][j_trailerid], GetAccountName( killerid ), killerid );
			
			VehicleJob[vid][v_damages] = 0.0;
			
			VehicleJob[ Job[killerid][j_vehicleid] ][v_driverid] = INVALID_PARAM;
			
			VehicleJob[vid][v_count_tons][product] = 
			Job[killerid][j_vehicleid] =
			Job[killerid][j_trailerid] = 0;
			
			DeletePVar( killerid, "Job:SelectProduct" ),
			DeletePVar( killerid, "Job:StockLoad" );
			
			PlayerTextDrawHide( killerid, Trucker[killerid] );
			TextDrawHideForPlayer( killerid, TaxiBackground );
			
			SendClient:( killerid, C_WHITE, ""gbError"Вы уничтожили свой рабочий транспорт, весь груз возвращен на склад." );
		}
		else if( vehicleid == Job[killerid][j_trailerid] )
		{
			new
				product = GetPVarInt( killerid, "Job:SelectProduct" ),
				jstock = GetPVarInt( killerid, "Job:StockLoad" ),
				vid = Job[killerid][j_vehicleid];
			
			if( Server[jstock][s_value][product] + VehicleJob[vid][v_count_tons][product] > MAX_COUNT_STOCKS )
			{
				Server[jstock][s_value][product] = MAX_COUNT_STOCKS;
			}
			else
			{
				Server[jstock][s_value][product] += VehicleJob[vid][v_count_tons][product];
			}
			
			UpdateValueServer( jstock, product );
			
			DestroyVehicle( Job[killerid][j_trailerid] );
			printf( "[Log]: Destroy job trailer ID: %d = killerid %s[%d].", Job[killerid][j_trailerid], GetAccountName( killerid ), killerid );
			
			VehicleJob[vid][v_count_tons][product] = 
			Job[killerid][j_trailerid] = 0;
			
			DeletePVar( killerid, "Job:SelectProduct" ),
			DeletePVar( killerid, "Job:StockLoad" );
			
			PlayerTextDrawHide( killerid, Trucker[killerid] );
			TextDrawHideForPlayer( killerid, TaxiBackground );
				
			SendClient:( killerid, C_WHITE, ""gbError"Вы уничтожили свой груз." );
		}
		else if( Job[killerid][j_vehicleid] )
		{
			if( Job[killerid][j_vehicleid] >= cars_bus[0] && Job[killerid][j_vehicleid] <= cars_bus[1] )
			{
				DisablePlayerRaceCheckpoint( killerid );
				DestroyDynamicObject( VehicleJob[Job[killerid][j_vehicleid]][v_bus_text] );
				
				VehicleJob[Job[killerid][j_vehicleid]][v_route] = 0;
				
				DeletePVar( killerid, "Job:Bus" );
				
				PlayerTextDrawHide( killerid, Drivebus[killerid] );
				TextDrawHideForPlayer( killerid, TaxiBackground );
			}
			else if( Job[killerid][j_vehicleid] >= cars_taxi[0] && Job[killerid][j_vehicleid] <= cars_taxi[1] )
			{
				DisablePlayerCheckpoint( killerid );
				DestroyDynamicObject( VehicleJob[Job[killerid][j_vehicleid]][v_taxi_text] );
				
				PlayerTextDrawHide( killerid, Taximeter[killerid] );
				TextDrawHideForPlayer( killerid, TaxiBackground );	
				
				VehicleJob[ Job[killerid][j_vehicleid] ][v_passenger] = INVALID_PARAM;

				VehicleJob[ Job[killerid][j_vehicleid] ][v_mileage] = 0.0;
				VehicleJob[ Job[killerid][j_vehicleid] ][v_rate] = 0;
			}
			else if( Job[killerid][j_vehicleid] >= cars_prod[0] && Job[killerid][j_vehicleid] <= cars_prod[1] )
			{
				PlayerTextDrawHide( killerid, Trucker[killerid] );
				TextDrawHideForPlayer( killerid, TaxiBackground );		
			}
			else if( Job[killerid][j_vehicleid] >= cars_bus[0] && Job[killerid][j_vehicleid] <= cars_bus[1] )
			{
				PlayerTextDrawHide( killerid, Drivebus[killerid] );
				TextDrawHideForPlayer( killerid, TaxiBackground );
			}
		
			if( Job[killerid][j_vehicleid] )
				VehicleJob[ Job[killerid][j_vehicleid] ][v_driverid] = INVALID_PARAM;
		
			new
				price = floatround( 6.0 * VehicleInfo[ GetVehicleModel( Job[killerid][j_vehicleid] ) - 400 ][v_price] * 0.005 );
		
			if( price )
			{
				format:g_small_string( "\
					"cWHITE"Рабочий транспорт уничтожен, аренда обнулена.\n\
					"gbDialogError"Вы заплатили штраф $%d. Деньги списаны с Вашего банковского счета.", price );
				showPlayerDialog( killerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
	
				SetPlayerBank( killerid, "-", price );
			}
			else
			{
				SendClient:( killerid, C_WHITE, !""gbError"Рабочий транспорт уничтожен, аренда обнулена." );
			}
		
			showPlayerDialog( killerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_string, "Закрыть", "" );
			Job[killerid][j_vehicleid] = 0;
		}
	}

    return 1;
}

//Если игрок выходит из игры
Job_OnPlayerDisconnect( playerid )
{
	CheckIsMadeOrder( playerid );

	if( Job[playerid][j_trailerid] )
	{
		new
			product = GetPVarInt( playerid, "Job:SelectProduct" ),
			jstock = GetPVarInt( playerid, "Job:StockLoad" ),
			vid = Job[playerid][j_vehicleid];
			
		if( Server[jstock][s_value][product] + VehicleJob[vid][v_count_tons][product] > MAX_COUNT_STOCKS )
		{
			Server[jstock][s_value][product] = MAX_COUNT_STOCKS;
		}
		else
		{
			Server[jstock][s_value][product] += VehicleJob[vid][v_count_tons][product];
		}
		
		UpdateValueServer( jstock, product );
		
		DestroyVehicle( Job[playerid][j_trailerid] );
		printf( "[Log]: Destroy job trailer ID: %d = playerid %s[%d].", Job[playerid][j_trailerid], GetAccountName( playerid ), playerid );
		
		SetVehicleToRespawn( Job[playerid][j_vehicleid] );
		
		VehicleJob[Job[playerid][j_vehicleid]][v_driverid] = INVALID_PARAM;
		
		VehicleJob[vid][v_count_tons][product] = 
		Job[playerid][j_vehicleid] =
		Job[playerid][j_trailerid] = 0;
			
		DeletePVar( playerid, "Job:SelectProduct" ),
		DeletePVar( playerid, "Job:StockLoad" );
	}
	
	if( Job[playerid][j_vehicleid] )
	{
		if( Job[playerid][j_vehicleid] >= cars_bus[0] || Job[playerid][j_vehicleid] <= cars_bus[1] )
		{
			DisablePlayerRaceCheckpoint( playerid );
			DestroyDynamicObject( VehicleJob[Job[playerid][j_vehicleid]][v_bus_text] );
			
			VehicleJob[Job[playerid][j_vehicleid]][v_route] = 0;
			
			DeletePVar( playerid, "Job:Bus" );
		}
		
		if( Job[playerid][j_vehicleid] >= cars_taxi[0] || Job[playerid][j_vehicleid] <= cars_taxi[1] )
		{
			DisablePlayerCheckpoint( playerid );
			DestroyDynamicObject( VehicleJob[Job[playerid][j_vehicleid]][v_taxi_text] );
			
			VehicleJob[Job[playerid][j_vehicleid]][v_passenger] = INVALID_PARAM;
							
			VehicleJob[Job[playerid][j_vehicleid]][v_mileage] = 0.0;
			VehicleJob[Job[playerid][j_vehicleid]][v_rate] = 0;
		}
		
		if( Job[playerid][j_vehicleid] )
		VehicleJob[Job[playerid][j_vehicleid]][v_driverid] = INVALID_PARAM;
		
		SetVehicleToRespawn( Job[playerid][j_vehicleid] );
		
		Job[playerid][j_vehicleid] = 0;
	}
	
	if( GetPVarInt( playerid, "Job:Wood" ) )
	{
		if( GetPVarInt( playerid, "Job:WoodCheckpoint" ) )
		{		
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_NONE );
			
			DisablePlayerCheckpoint( playerid );
			DeletePVar( playerid, "Job:WoodCheckpoint" );
		}
		
		RemovePlayerAttachedObject( playerid, 9 );
		DeletePVar( playerid, "Job:Wood" );
	}
	
	
    job_duty{playerid} = 0;

	return 1;
}

//Если игрок умирает
Job_OnPlayerDeath( playerid )
{
	CheckIsMadeOrder( playerid );
	
	if( GetPVarInt( playerid, "Job:Wood" ) )
	{
		if( GetPVarInt( playerid, "Job:WoodCheckpoint" ) )
		{		
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_NONE );
			
			DisablePlayerCheckpoint( playerid );
			DeletePVar( playerid, "Job:WoodCheckpoint" );
		}
		
		RemovePlayerAttachedObject( playerid, 9 );
		DeletePVar( playerid, "Job:Wood" );
	}

	return 1;
}

//Когда игрок повреждает транспорт
Job_OnVehicleDamageStatusUpdate( vehicleid, playerid )
{
	if( IsTrailerAttachedToVehicle( Job[playerid][j_vehicleid] ) && vehicleid == Job[playerid][j_vehicleid] )
	{	
		switch( GetPVarInt( playerid, "Job:SelectProduct" ) ) 
		{
			case 0,1,2:
			{
				new 
					Float:health_vehicle,
					Float:health_trailer,
					Float:temp,
					trailerid = Job[playerid][j_trailerid],
					product = GetPVarInt( playerid, "Job:SelectProduct" );
				
				GetVehicleHealth( vehicleid, health_vehicle );
				GetVehicleHealth( trailerid, health_trailer );
				
				if( health_vehicle >= VehicleJob[vehicleid][v_damages] )
					VehicleJob[vehicleid][v_damages] = health_vehicle;
					
				if( health_vehicle < VehicleJob[vehicleid][v_damages] && health_trailer > 500.0 )
				{
					temp = VehicleJob[vehicleid][v_damages] - health_vehicle;
				
					if( health_trailer - temp > 500.0 )
					{
						setVehicleHealth( trailerid, health_trailer - temp );
						VehicleJob[trailerid][v_damages_trailer] = health_trailer - temp;
					}
					else
					{
						setVehicleHealth( trailerid, 500.0 );
						VehicleJob[trailerid][v_damages_trailer] = 500.0;
					}
				}
				
				format:g_small_string( "%s: %d t. ~r~%d%s", name_trucker[product], VehicleJob[vehicleid][v_count_tons][product], GetDamagesProduct( trailerid ) ,"%" );
				PlayerTextDrawSetString( playerid, Trucker[playerid], g_small_string );
			}
			default: 
				return 1;
		}
	}
	
	return 1;
}


CheckIsMadeOrder( playerid )
{
	if( GetPVarInt( playerid, "Job:SetCheckPointProd" ) )
	{
		new
			order = GetPVarInt( playerid, "Job:SelectOrder" ),
			vid = Job[playerid][j_vehicleid];

		if( vid )
		{
			if( vid >= cars_prod[0] || vid <= cars_prod[1] )
			{
				if( !IsPlayerInAnyVehicle( playerid ) || ( IsPlayerInAnyVehicle( playerid ) && vid != GetPlayerVehicleID( playerid ) ) )
				{
					SetVehicleToRespawn( vid );
				}

				VehicleJob[vid][v_count_prod] = 0;
			}
		}

		ProductsInfo[order][b_count_time] += Job[playerid][j_count_order];
		
		VehicleJob[ vid ][v_driverid] = INVALID_PARAM;
		
		Job[playerid][j_count_order] = 
		Job[playerid][j_vehicleid] = 0;

		KillTimer( timer_order[playerid] );

		DisablePlayerCheckpoint( playerid );

		SendClient:( playerid, C_WHITE, ""gbError"Выполнение заказа на доставку товаров прервано. Рабочий транспорт возвращен в транспортную компанию." );
		
		PlayerTextDrawHide( playerid, Taximeter[playerid] );
		TextDrawHideForPlayer( playerid, TaxiBackground );	

		DeletePVar( playerid, "Job:SetCheckPointProd" );
		DeletePVar( playerid, "Job:SelectOrder" );
		DeletePVar( playerid, "Load:Products" );
	}
	
	return 1;
}

LockJobCar( playerid )
{
	new
		Float:pos[3],
		carid,
		rank,
		fid,
		crime,
		bool:flag = false;
		
	if( Player[playerid][uJob] )
	{
		if( !job_duty{playerid} )
			return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет рабочего транспорта!" );
			
		if( Job[playerid][j_vehicleid] )
		{
			carid = Job[playerid][j_vehicleid];

			GetVehiclePos( carid, pos[0], pos[1], pos[2] );
			CheckVehicleParams( carid );

			if( IsPlayerInRangeOfPoint( playerid, 3.0, pos[0], pos[1], pos[2] ) )
			{
				if( !Vehicle[carid][vehicle_state_door] )
				{
					GameTextForPlayer( playerid, "~r~DOORS LOCK", 1000, 1 );
					Vehicle[carid][vehicle_state_door] = 1;
					format:g_small_string( "заблокировал%s двери", SexTextEnd( playerid ) );
					
					Vehicle[carid][vehicle_state_boot] = false;
					Vehicle[carid][vehicle_state_hood] = false;
				}
				else
				{
					GameTextForPlayer( playerid, "~g~DOORS UNLOCK", 1000, 1 );
					Vehicle[carid][vehicle_state_door] = 0;
					format:g_small_string( "разблокировал%s двери", SexTextEnd( playerid ) );
				}
				
				MeAction( playerid, g_small_string, 1 );
				SetVehicleParams( carid );
			}
			else
				return SendClient:( playerid, C_WHITE, ""gbError"Ваш рабочий транспорт слишком далеко." );
		}
		else if( Player[playerid][uJob] == JOB_MECHANIC )
		{
			for( new i; i < MAX_VEHICLES; i++ )
			{
				if( !GetVehicleModel( i ) || Vehicle[i][vehicle_member] == Player[playerid][uMember] || i < cars_mech[0] || i > cars_mech[1] ) continue;
				
				GetVehiclePos( i, pos[0], pos[1], pos[2] );
			
				if( !IsPlayerInRangeOfPoint( playerid, 2.0, pos[0], pos[1], pos[2] ) ) continue;
				
				CheckVehicleParams( i );
		
				if( !Vehicle[i][vehicle_state_door] )
				{
					GameTextForPlayer( playerid, "~r~DOORS LOCK", 1000, 1 );
					Vehicle[i][vehicle_state_door] = 1;
					format:g_small_string( "заблокировал%s двери", SexTextEnd( playerid ) );
					
					Vehicle[i][vehicle_state_boot] = false;
					Vehicle[i][vehicle_state_hood] = false;
				}
				else
				{
					GameTextForPlayer( playerid, "~g~DOORS UNLOCK", 1000, 1 );
					Vehicle[i][vehicle_state_door] = 0;
					format:g_small_string( "разблокировал%s двери", SexTextEnd( playerid ) );
				}
				MeAction( playerid, g_small_string, 1 );
				
				SetVehicleParams( i );
			
				break;
			}
		}
	}
	else if( Player[playerid][uMember] && Player[playerid][uRank] )
	{
		fid = Player[playerid][uMember] - 1;
		rank = getRankId( playerid, fid );
	
		for( new i; i < MAX_VEHICLES; i++ )
		{
			if( !GetVehicleModel( i ) || Vehicle[i][vehicle_member] != Player[playerid][uMember] ) continue;
			
			for( new j; j < 10; j++ )
			{
				if( FRank[fid][rank][r_vehicles][j] == GetVehicleModel( i ) )
				{
					flag = true;
					break;
				}
			}
			
			if( !flag ) continue;
			
			GetVehiclePos( i, pos[0], pos[1], pos[2] );
			
			if( !IsPlayerInRangeOfPoint( playerid, 2.0, pos[0], pos[1], pos[2] ) ) continue;
			
			CheckVehicleParams( i );
		
			if( !Vehicle[i][vehicle_state_door] )
			{
				GameTextForPlayer( playerid, "~r~DOORS LOCK", 1000, 1 );
				Vehicle[i][vehicle_state_door] = 1;
				format:g_small_string( "заблокировал%s двери", SexTextEnd( playerid ) );
				
				Vehicle[i][vehicle_state_boot] = false;
				Vehicle[i][vehicle_state_hood] = false;
			}
			else
			{
				GameTextForPlayer( playerid, "~g~DOORS UNLOCK", 1000, 1 );
				Vehicle[i][vehicle_state_door] = 0;
				format:g_small_string( "разблокировал%s двери", SexTextEnd( playerid ) );
			}
			MeAction( playerid, g_small_string, 1 );
			
			SetVehicleParams( i );
		
			break;
		}
	}
	else if( Player[playerid][uCrimeM] && Player[playerid][uCrimeRank] )
	{
		crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
		rank = getCrimeRankId( playerid, crime );
	
		for( new i; i < MAX_VEHICLES; i++ )
		{
			if( !GetVehicleModel( i ) || Vehicle[i][vehicle_crime] != Player[playerid][uCrimeM] ) continue;
			
			for( new j; j < 10; j++ )
			{
				if( CrimeRank[crime][rank][r_vehicles][j] == GetVehicleModel( i ) )
				{
					flag = true;
					break;
				}
			}
			
			if( !flag ) continue;
			
			GetVehiclePos( i, pos[0], pos[1], pos[2] );
			
			if( !IsPlayerInRangeOfPoint( playerid, 2.0, pos[0], pos[1], pos[2] ) ) continue;
			
			CheckVehicleParams( i );
		
			if( !Vehicle[i][vehicle_state_door] )
			{
				GameTextForPlayer( playerid, "~r~DOORS LOCK", 1000, 1 );
				Vehicle[i][vehicle_state_door] = 1;
				format:g_small_string( "заблокировал%s двери", SexTextEnd( playerid ) );
				
				Vehicle[i][vehicle_state_boot] = false;
				Vehicle[i][vehicle_state_hood] = false;
			}
			else
			{
				GameTextForPlayer( playerid, "~g~DOORS UNLOCK", 1000, 1 );
				Vehicle[i][vehicle_state_door] = 0;
				format:g_small_string( "разблокировал%s двери", SexTextEnd( playerid ) );
			}
			MeAction( playerid, g_small_string, 1 );
			
			SetVehicleParams( i );
		
			break;
		}
	}
	else
		return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет рабочего транспорта!" );

	return 1;
}

public OnPlayerAttachTrailer( playerid, vehicleid, trailerid )
{
	if( Job[playerid][j_vehicleid] && trailerid != Job[playerid][j_trailerid] && Player[playerid][uJob] == JOB_PRODUCTS )
	{
		SendClient:( playerid, C_GRAY, ""gbError"Этот прицеп не подходит к Вашему тягачу.");

        return DetachTrailerFromVehicle( Job[playerid][j_vehicleid] );
	}
	else if( GetPVarInt( playerid, "Job:CreateTrailer" ) )
	{
		new
			vid = Job[playerid][j_vehicleid],
			product = GetPVarInt( playerid, "Job:SelectProduct" ),
			count = GetPVarInt( playerid, "Job:CountTons" ),
			jstock = GetPVarInt( playerid, "Job:StockLoad" );

		if( Player[playerid][uMoney] < count * GetPriceForProducts( product, Server[jstock][s_value][product] ) )
		{
			SendClient:( playerid, C_WHITE, ""gbError"У Вас недостаточно денег для оплаты груза." );
			return DetachTrailerFromVehicle( Job[playerid][j_vehicleid] );
		}

		Player[playerid][uMoney] -= count * GetPriceForProducts( product, Server[jstock][s_value][product] );

		UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );

		pformat:( ""gbSuccess"В Ваш прицеп загружено "cBLUE"%d"cWHITE" т. товара "cBLUE"%s"cWHITE". Вы заплатили "cBLUE"$%d"cWHITE".", count, name_products[product], count * GetPriceForProducts( product, Server[jstock][s_value][product] ) );
		psend:( playerid, C_WHITE );
		
		GetVehicleHealth( vid, VehicleJob[vid][v_damages] );
		
		VehicleJob[vid][v_count_tons][product] = count;
		Server[jstock][s_value][product] -= count;
		
		UpdateValueServer( jstock, product );

		SendClient:( playerid, C_WHITE, ""gbDefault"Доставьте груз на один из складов. Используйте "cBLUE"/gps"cWHITE"." );

		switch( product )
		{
			case 0,1,2:
				format:g_small_string( "%s: %d t. %d%s", name_trucker[product], count, GetDamagesProduct( Job[playerid][j_trailerid] ) ,"%" );
			case 3,4,5:
				format:g_small_string( "%s: %d t.", name_trucker[product], count );
		}
		PlayerTextDrawSetString( playerid, Trucker[playerid], g_small_string );
		
		if( Player[playerid][uSettings][0] )
		{		
			PlayerTextDrawShow( playerid, Trucker[playerid] );
			TextDrawShowForPlayer( playerid, TaxiBackground );
		}
		
		DeletePVar( playerid, "Job:CountTons" );
		DeletePVar( playerid, "Job:TrailerModel" );
		DeletePVar( playerid, "Job:CreateTrailer" );
		DeletePVar( playerid, "Job:Turn" );
	}
	else if( vehicleid == Job[playerid][j_vehicleid] && trailerid == Job[playerid][j_trailerid] )
	{
		if( Player[playerid][uSettings][0] )
		{		
			PlayerTextDrawShow( playerid, Trucker[playerid] );
			TextDrawShowForPlayer( playerid, TaxiBackground );
		}
	}

	return 1;
}

public OnPlayerDeattachTrailer( playerid, vehicleid, trailerid )
{
	
	return 1;
}

ShowStocksInfo( playerid, list )
{
	new
		jstock = GetPVarInt( playerid, "Job:Stock" );

	clean:<g_big_string>;
	
	switch( list )
	{
		case 1:
		{
			format:g_small_string( ""cWHITE"Наименование товара\t%s\t%s\t%s", 
				!jstock ? (""cBLUE"Ocean Docks") : (""cWHITE"Ocean Docks"),
				jstock == 1 ? (""cBLUE"Hilltop Farm") : (""cWHITE"Hilltop Farm"),
				jstock == 2 ? (""cBLUE"Blueberry 48 Road" ) : (""cWHITE"Blueberry 48 Road")
			);
	
			strcat( g_big_string, g_small_string );
				
			for( new i; i < MAX_PRODUCTS_STOCKS; i++ )
			{
				format:g_string( "\
					\n\%s\tСклад "cBLUE"%d"cWHITE" т. | За тонну "cBLUE"$%d"cWHITE"\t\
					Склад "cBLUE"%d"cWHITE" т. | За тонну "cBLUE"$%d"cWHITE"\t\
					Склад "cBLUE"%d"cWHITE" т. | За тонну "cBLUE"$%d",
					name_products[i],
					Server[0][s_value][i], GetPriceForProducts( i, Server[0][s_value][i] ),
					Server[1][s_value][i], GetPriceForProducts( i, Server[1][s_value][i] ),
					Server[2][s_value][i], GetPriceForProducts( i, Server[2][s_value][i] )
				);
				SetPVarInt( playerid, "Stock:List", list );
				strcat( g_big_string, g_string );		
			}

			return showPlayerDialog( playerid, d_daln + 6, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "Далее", "Назад" );
		}
		case 2:
		{
			format:g_small_string( ""cWHITE"Наименование товара\t%s\t%s", 
				jstock == 3 ? (""cBLUE"Doherty") : (""cWHITE"Doherty"),
				jstock == 4 ? (""cBLUE"Spinybed") : (""cWHITE"Spinybed")
			);
	
			strcat( g_big_string, g_small_string );
				
			for( new i; i < MAX_PRODUCTS_STOCKS; i++ )
			{
				format:g_string( "\
					\n\%s\tСклад "cBLUE"%d"cWHITE" т. | За тонну "cBLUE"$%d"cWHITE"\t\
					Склад "cBLUE"%d"cWHITE" т. | За тонну "cBLUE"$%d",
					name_products[i],
					Server[3][s_value][i], GetPriceForProducts( i, Server[3][s_value][i] ),
					Server[4][s_value][i], GetPriceForProducts( i, Server[4][s_value][i] )
				);
				
				strcat( g_big_string, g_string );		
			}
			SetPVarInt( playerid, "Stock:List", list );
			return showPlayerDialog( playerid, d_daln + 6, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "Назад", "" );
		}
	}
	return 1;
}

stock UpdateValueServer( jstock, product )
{
	clean:<g_string>;

	switch( product )
	{
		case 0:
		{
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_SERVER"` SET `s_alcohol` = %d WHERE `s_name` = '%e'",
				Server[jstock][s_value][product],
				Server[jstock][s_name]
			);
		}

		case 1:
		{
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_SERVER"` SET `s_water` = %d WHERE `s_name` = '%e'",
				Server[jstock][s_value][product],
				Server[jstock][s_name]
			);
		}

		case 2:
		{
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_SERVER"` SET `s_dioxide` = %d WHERE `s_name` = '%e'",
				Server[jstock][s_value][product],
				Server[jstock][s_name]
			);
		}

		case 3:
		{
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_SERVER"` SET `s_clothes` = %d WHERE `s_name` = '%e'",
				Server[jstock][s_value][product],
				Server[jstock][s_name]
			);
		}

		case 4:
		{
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_SERVER"` SET `s_part` = %d WHERE `s_name` = '%e'",
				Server[jstock][s_value][product],
				Server[jstock][s_name]
			);
		}

		case 5:
		{
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_SERVER"` SET `s_materials` = %d WHERE `s_name` = '%e'",
				Server[jstock][s_value][product],
				Server[jstock][s_name]
			);
		}
	}

	return mysql_tquery( mysql, g_string, "", "" );
}

//Вычисление стоимости за 1 тонну
GetPriceForProducts( product, value )
{
	new
		Float:number = ( 100.0 / value ) * price_products[product]; 
		
	return floatround( number );
}

AddCheckpoint( playerid, route, param )
{
	for( new i; i < MAX_CHECKPOINTS; i++ )
	{
		if( !Bus[route][i][r_id] )
		{
			new
				vehicleid = GetPlayerVehicleID( playerid ),
				Float:pos[3];
				
			GetVehiclePos( vehicleid, pos[0], pos[1], pos[2] );	
			
			Bus[route][i][r_route] = Route[route][r_number];
			Bus[route][i][r_pos][0] = pos[0];
			Bus[route][i][r_pos][1] = pos[1];
			Bus[route][i][r_pos][2] = pos[2];
			Bus[route][i][r_param] = param;
			
			mysql_format:g_small_string( "INSERT INTO `"DB_ROUTES"` \
				( `r_route`, `r_pos`, `r_param` ) VALUES \
				( '%d', '%f|%f|%f', '%d' )",
				Bus[route][i][r_route],
				Bus[route][i][r_pos][0],
				Bus[route][i][r_pos][1],
				Bus[route][i][r_pos][2],
				Bus[route][i][r_param]
			);
			
			mysql_tquery( mysql, g_small_string, "InsertRoute", "dd", route, i );
			
			break;
		}
	}
	
	Route[route][r_point] ++;
	
	pformat:( ""gbSuccess"Маршрут "cBLUE"%d"cWHITE" - чекпоинт "cBLUE"#%d"cWHITE" добавлен!", Route[route][r_number], Route[route][r_point] );
	psend:( playerid, C_WHITE );
	
	return 1;
}

function InsertRoute( route, point )
{
	Bus[route][point][r_id] = cache_insert_id();
	return 1;
}

function LoadCheckpoints( route )
{
	new 
		rows = cache_get_row_count();

	if( !rows )
		return 1;

	Route[route][r_number] = routes[route];
		
	for( new i; i < rows; i++ )
	{
		if( !Bus[route][i][r_id] )
		{
			Bus[route][i][r_id] = cache_get_field_content_int( i, "r_id", mysql );
			Bus[route][i][r_route] = cache_get_field_content_int( i, "r_route", mysql );
			Bus[route][i][r_param] = cache_get_field_content_int( i, "r_param", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_pos", g_small_string, mysql, 128 );
			sscanf( g_small_string,"p<|>a<f>[3]", Bus[route][i][r_pos] );
				
			Route[route][r_point] ++;
		}
	}
	
	mysql_format:g_small_string( "SELECT * FROM `"DB_ROUTES_DESCRIPT"` WHERE `r_route` = %d", Route[route][r_number] );
	mysql_tquery( mysql, g_small_string, "LoadRouteDescript", "i", route );
	
	return 1;
}

function LoadRouteDescript( route )
{
	new
		rows = cache_get_row_count();

	if( !rows )
		return 1;
	
	for( new i; i < rows; i++ )
	{
		clean:<g_small_string>;
		cache_get_field_content( i, "r_description", g_small_string, mysql );
		strmid( Route[route][r_description], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	}

	return 1;
}

DeleteRoute( route )
{	
	mysql_format:g_string( "DELETE FROM `"DB_ROUTES"` WHERE `r_route` = %d", Route[route][r_number] );
	mysql_tquery( mysql, g_string );
	
	if( Route[route][r_description][0] != EOS )
	{
		mysql_format:g_string( "DELETE FROM `"DB_ROUTES_DESCRIPT"` WHERE `r_route` = %d", Route[route][r_number] );
		mysql_tquery( mysql, g_string );
	}
	
	return 1;
}

ShowRoutes( playerid )
{
	new
		count;
						
	clean:<g_string>;	
					
	for( new i; i < MAX_ROUTES; i++ )
	{
		if( Route[i][r_number] )
		{
			format:g_small_string( ""cWHITE"Маршрут "cBLUE"%d"cWHITE"\n", Route[i][r_number] );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			count++;
		}
	}
					
	if( !count )
	{		
		SendClient:( playerid, C_WHITE, ""gbError"Маршруты не найдены!" );
						
		return showPlayerDialog( playerid, d_makeroute, DIALOG_STYLE_LIST, " ", "\
			Добавить чекпоинты\n\
			Удалить маршрут\n\
			Добавить описание", 
		"Выбрать", "Закрыть" );
	}	

	return showPlayerDialog( playerid, d_makeroute + 2, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
}

AddDescriptionRoute( route, descript[] )
{
	if( Route[route][r_description][0] == EOS )
	{
		clean:<Route[route][r_description]>;
		strcat( Route[route][r_description], descript, 32 );
		
		mysql_format:g_string( "INSERT INTO `"DB_ROUTES_DESCRIPT"` \
			( `r_route`, `r_description` ) VALUES \
			( '%d', '%e' )",
			Route[route][r_number],
			Route[route][r_description]
		);
	}
	else
	{
		clean:<Route[route][r_description]>;
		strcat( Route[route][r_description], descript, 32 );
		
		mysql_format:g_string( "UPDATE `"DB_ROUTES_DESCRIPT"` \
			SET `r_description` = '%e' \
			WHERE `r_route` = %d LIMIT 1",
			Route[route][r_description],
			Route[route][r_number]
		);
	}
	
	mysql_tquery( mysql, g_string );
	
	return 1;
}

Job_OnPlayerEnterRaceCheckpoint( playerid )
{
	if( Job[playerid][j_vehicleid] )
	{
		new
			vehicleid = GetPlayerVehicleID( playerid ),
			route = GetPVarInt( playerid, "Job:SelectRoute" ),
			point = Job[playerid][j_point],
			count = Route[route][r_point] - 1;
					
		if( vehicleid >= cars_bus[0] && vehicleid <= cars_bus[1] )
		{
			Job[playerid][j_earn] += EARN_FOR_CHECKPOINT;
			
			Player[playerid][uCheck] += EARN_FOR_CHECKPOINT;
			UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
			
			//Если остановка
			if( !Bus[route][point][r_param] )
			{
				DisablePlayerRaceCheckpoint( playerid );
				
				SendClient:( playerid, C_WHITE, ""gbDefault"Вы подъехали к автобусной остановке, ожидайте пассажиров." );
				
				SetTimerEx( "OnTimerBusStop", 10000, false, "d", playerid );	
				
				return 1;
			}
		
			//Если конечный чекпоинт
			if( point == count )
			{
				DisablePlayerRaceCheckpoint( playerid );
				
				DeletePVar( playerid, "Job:Bus" );
				if( Player[playerid][uSettings][0] )
				{
					PlayerTextDrawShow( playerid, Drivebus[playerid] );
					TextDrawShowForPlayer( playerid, TaxiBackground );
				}
				
				SetVehicleSpeed( Job[playerid][j_vehicleid], 0.0 );
				
				format:g_small_string( "\
					"cWHITE"Вы завершили маршрут "cBLUE"#%d %s"cWHITE"!\n\n\
					Желаете продолжить рабочий день?", Route[route][r_number], Route[route][r_description] );
				
				showPlayerDialog( playerid, d_bus + 2, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				
				return 1;
			}
			
			//Если прошлый чекпоинт остановка
			if( GetPVarInt( playerid, "Job:StopLast" ) )
			{
				SetPlayerRaceCheckpoint( playerid, 0, 
					Bus[route][point][r_pos][0], 
					Bus[route][point][r_pos][1], 
					Bus[route][point][r_pos][2],
					Bus[route][point + 1][r_pos][0], 
					Bus[route][point + 1][r_pos][1], 
					Bus[route][point + 1][r_pos][2],
					5.0
				);
				
				DeletePVar( playerid, "Job:StopLast" );
				
				return 1;
			}
			
			point++;
			
			//Если следующий чекпоинт конечный
			if( point == count )
			{
				SetPlayerRaceCheckpoint( playerid, 1, 
					Bus[route][point][r_pos][0], 
					Bus[route][point][r_pos][1], 
					Bus[route][point][r_pos][2],
					Bus[route][point + 1][r_pos][0], 
					Bus[route][point + 1][r_pos][1], 
					Bus[route][point + 1][r_pos][2],
					5.0
				);
				
				Job[playerid][j_point]++;
				return 1;
			}
			
			//Если следующий чекпоинт остановка
			if( !Bus[route][point][r_param] )
			{
				SetPlayerRaceCheckpoint( playerid, 1, 
					Bus[route][point][r_pos][0], 
					Bus[route][point][r_pos][1], 
					Bus[route][point][r_pos][2],
					Bus[route][point + 1][r_pos][0], 
					Bus[route][point + 1][r_pos][1], 
					Bus[route][point + 1][r_pos][2],
					5.0
				);
				
				Job[playerid][j_point]++;
				return 1;
			}
			
			SetPlayerRaceCheckpoint( playerid, 0, 
				Bus[route][point][r_pos][0], 
				Bus[route][point][r_pos][1], 
				Bus[route][point][r_pos][2],
				Bus[route][point + 1][r_pos][0], 
				Bus[route][point + 1][r_pos][1], 
				Bus[route][point + 1][r_pos][2],
				5.0
			);
			
			Job[playerid][j_point]++;
		}
	}
	
	return 1;
}

function Job_OnPlayerClickMap( playerid, Float:fX, Float:fY, Float:fZ )
{
	new 
		vehicleid = GetPlayerVehicleID( playerid ),
		driverid = GetPVarInt( playerid, "Taxi:Driver" );
		
	if( vehicleid >= cars_taxi[0] && vehicleid <= cars_taxi[1] ) 
	{
		if( GetPlayerVehicleSeat( playerid ) ) 
		{
	        if( IsPlayerInAnyVehicle( driverid ) && !GetPlayerVehicleSeat( driverid ) ) 
			{
			    if( !GetPVarInt( driverid, "Taxi:Route" ) ) 
				{
			   		SetPlayerCheckpoint( driverid, Float:fX, Float:fY, Float:fZ, 5.0 );
					SetPVarInt( driverid, "Taxi:Route", 1 );
					
					SendClient:( driverid, C_GRAY, !""gbDefault"Пассажир указал Вам дорогу." );
	   		        SendClient:( playerid, C_GRAY, !""gbDefault"Вы указали маршрут водителю такси." );
					
					format:g_small_string( "показал%s дорогу водителю", SexTextEnd( playerid ) );
	   		        MeAction( playerid, g_small_string, 1 );
			    }
			    else 
					SendClient:( playerid, C_GRAY, !""gbError"Водитель уже едет по указанному маршруту." );
	        }
	    }
	}
    return 1;
}

function Job_OnPlayerStateChange( playerid, newstate, oldstate ) 
{
	switch( newstate )
	{
		case PLAYER_STATE_DRIVER:
		{
			if( Job[playerid][j_vehicleid] )
			{
				new
					vehicleid = GetPlayerVehicleID( playerid );
					
				if( vehicleid >= cars_bus[0] && vehicleid <= cars_bus[1] && Job[playerid][j_vehicleid] == vehicleid )
				{
					if( !GetPVarInt( playerid, "Job:Bus" ) )
						StartRouteBus( playerid, vehicleid );
					else
					{
						if( Player[playerid][uSettings][0] )
						{
							PlayerTextDrawShow( playerid, Drivebus[playerid] );
							TextDrawShowForPlayer( playerid, TaxiBackground );
						}
					}
				}
				else if( vehicleid >= cars_taxi[0] && vehicleid <= cars_taxi[1] && Job[playerid][j_vehicleid] == vehicleid )
				{
					if( Player[playerid][uSettings][0] )
					{
						PlayerTextDrawShow( playerid, Taximeter[playerid] );
						TextDrawShowForPlayer( playerid, TaxiBackground );
					}
				}
				else if( vehicleid >= cars_prod[0] && vehicleid <= cars_prod[1] && Job[playerid][j_vehicleid] == vehicleid )
				{
					switch( GetVehicleModel( vehicleid ) )
					{
						case 414, 499:
						{
							format:g_small_string( "Products: %d", VehicleJob[vehicleid][v_count_prod] );
							PlayerTextDrawSetString( playerid, Taximeter[playerid], g_small_string );
							
							if( IsValidDynamicArea( Job[playerid][j_zone_unload] ) )
							{
								DestroyDynamicArea( Job[playerid][j_zone_unload] );
								Job[playerid][j_zone_unload] = 0;
							}
							
							if( Player[playerid][uSettings][0] )
							{
								PlayerTextDrawShow( playerid, Taximeter[playerid] );
								TextDrawShowForPlayer( playerid, TaxiBackground );
							}
						}
						
						case 515, 514:
						{
							if( IsTrailerAttachedToVehicle( Job[playerid][j_vehicleid] ) )
							{
								if( Player[playerid][uSettings][0] )
								{	
									PlayerTextDrawShow( playerid, Trucker[playerid] );
									TextDrawShowForPlayer( playerid, TaxiBackground );
								}
							}
						}
					}
				}
			}
		}
		
		case PLAYER_STATE_PASSENGER:
		{
			new
				vehicleid = GetPlayerVehicleID( playerid );
					
			if( vehicleid >= cars_bus[0] && vehicleid <= cars_bus[1] )
			{
					
				for( new i; i < MAX_ROUTES; i++ )
				{
					if( VehicleJob[vehicleid][v_route] == Route[i][r_number] )
					{
						pformat:( ""gbDialog"Автобус движется по маршруту "cBLUE"%s %d"cWHITE".", Route[i][r_description], Route[i][r_number] );
						psend:( playerid, C_WHITE );
						
						break;
					}
				}					
			}
			else if( vehicleid >= cars_taxi[0] && vehicleid <= cars_taxi[1] )
			{
				if( VehicleJob[vehicleid][v_rate] && !GetAmountPassenger( playerid, vehicleid ) )
				{
					VehicleJob[vehicleid][v_mileage] = 0.0;	
					
					PlayerTextDrawShow( playerid, Taximeter[playerid] );
					TextDrawShowForPlayer( playerid, TaxiBackground );
					
					VehicleJob[vehicleid][v_passenger] = playerid;
					
					SetPVarInt( playerid, "Taxi:Inside", vehicleid );
				}
			}
		}
	}
	
	switch( oldstate )
	{
		case PLAYER_STATE_PASSENGER:
		{
			new
				vehicleid = GetPVarInt( playerid, "Taxi:Inside" ),
				newpassenger = INVALID_PARAM;
			
			if( vehicleid >= cars_taxi[0] && vehicleid <= cars_taxi[1] )
			{
				if( Player[playerid][jTaxi] )
					Player[playerid][jTaxi] = false;
				
				if( GetPVarInt( playerid, "Taxi:Driver" ) != INVALID_PLAYER_ID )
				{
					Job[ GetPVarInt( playerid, "Taxi:Driver" ) ][j_taxi] = false;
					DeletePVar( GetPVarInt( playerid, "Taxi:Driver" ), "Taxi:Route" );
					SetPVarInt( playerid, "Taxi:Driver", INVALID_PLAYER_ID );
				}
				
				foreach(new i : Player)
				{
					if( !IsLogged( i ) || playerid == i )
						continue;
				
					if( IsPlayerInVehicle( i, vehicleid ) && GetPlayerState( i ) == 3 )
					{
						newpassenger = i;
						break;
					}
				}
				
				PlayerTextDrawHide( playerid, Taximeter[playerid] );
				TextDrawHideForPlayer( playerid, TaxiBackground );
				
				if( newpassenger == INVALID_PARAM && vehicleid != INVALID_PARAM )
				{
					VehicleJob[vehicleid][v_mileage] = 0.0;	
					VehicleJob[vehicleid][v_passenger] = INVALID_PARAM;
					DeletePVar( playerid, "Taxi:Inside" );
							
					PlayerTextDrawSetString( VehicleJob[vehicleid][v_driverid], Taximeter[ VehicleJob[vehicleid][v_driverid] ], "taximeter: $0" );		
				}
				else if( newpassenger != INVALID_PARAM && vehicleid != INVALID_PARAM )
				{
					SetPVarInt( newpassenger, "Taxi:Inside", vehicleid );
					VehicleJob[vehicleid][v_passenger] = newpassenger;
					
					format:g_small_string( "taximeter: $%d", floatround( VehicleJob[vehicleid][v_mileage] ) * VehicleJob[vehicleid][v_rate] );
					PlayerTextDrawSetString( newpassenger, Taximeter[newpassenger], g_small_string );
					
					PlayerTextDrawShow( newpassenger, Taximeter[newpassenger] );
					TextDrawShowForPlayer( newpassenger, TaxiBackground );
				}
			}
		}
		
		case PLAYER_STATE_DRIVER:
		{
			new
				vehicleid = Job[playerid][j_vehicleid];
			
			if( vehicleid >= cars_prod[0] && vehicleid <= cars_prod[1] )
			{
				switch( GetVehicleModel( vehicleid ) )
				{
					case 414, 499:
					{
						PlayerTextDrawHide( playerid, Taximeter[playerid] );
						TextDrawHideForPlayer( playerid, TaxiBackground );
						
						if( GetPVarInt( playerid, "Job:Unload" ) )
						{
							new
								Float:x,
								Float:y,
								Float:z;
						
							if( IsValidDynamicArea( Job[playerid][j_zone_unload] ) )
							{
								DestroyDynamicArea( Job[playerid][j_zone_unload] );
								Job[playerid][j_zone_unload] = 0;
							}
								
							GetPosVehicleBoot( vehicleid, x, y, z );
							Job[playerid][j_zone_unload] = CreateDynamicSphere( x, y, z, 1.0, 0, 0, playerid );
						}
					}
					
					case 515, 514:
					{
						PlayerTextDrawHide( playerid, Trucker[playerid] );
						TextDrawHideForPlayer( playerid, TaxiBackground );
					}
				}
			}
			else if( vehicleid >= cars_taxi[0] && vehicleid <= cars_taxi[1] )
			{
				PlayerTextDrawHide( playerid, Taximeter[playerid] );
				TextDrawHideForPlayer( playerid, TaxiBackground );
			}
			else if( vehicleid >= cars_bus[0] && vehicleid <= cars_bus[1] )
			{
				PlayerTextDrawHide( playerid, Drivebus[playerid] );
				TextDrawHideForPlayer( playerid, TaxiBackground );
			}
		}
	}
	return 1;
}

StartRouteBus( playerid, vehicleid )
{
	new
		count,
		route,
		point;
		
	for( new i; i < MAX_ROUTES; i++ )
	{
		if( Route[i][r_number] )
			count++;
	}
					
	SetPVarInt( playerid, "Job:SelectRoute", random( count ) );
	route = GetPVarInt( playerid, "Job:SelectRoute" );
	SetPVarInt( playerid, "Job:Bus", 1 );
	
	Job[playerid][j_point] = 
	point = 0;
	
	pformat:( ""gbDefault"Ваш маршрут "cBLUE"%s #%d"cWHITE". Проезд в общественном транспорте бесплатный.",
		Route[route][r_description], Route[route][r_number] );
	psend:( playerid, C_WHITE );
	
	format:g_small_string( ""cWHITE"Ваш маршрут "cBLUE"%s #%d"cWHITE"\n\n\
		"gbDefault"Проезд в общественном транспорте бесплатный.",
		Route[route][r_description],
		Route[route][r_number]
	);
					
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
	
	format:g_small_string( "Route: %d", Route[route][r_number] );
	PlayerTextDrawSetString( playerid, Drivebus[playerid], g_small_string );
	
	if( Player[playerid][uSettings][0] )
	{
		PlayerTextDrawShow( playerid, Drivebus[playerid] );
		TextDrawShowForPlayer( playerid, TaxiBackground );
	}

	VehicleJob[vehicleid][v_route] = Route[route][r_number];
	VehicleJob[vehicleid][v_bus_text] = CreateDynamicObject( 19477, 0, 0, -1000.0, 0, 0, 0, 0); 
					
	switch( GetVehicleModel( vehicleid ) )
	{
		case 431:
			AttachDynamicObjectToVehicle(VehicleJob[vehicleid][v_bus_text], vehicleid, 1.060, 5.721, 1.700, 0.000, -11.300, 89.700 );
						
		case 437:
			AttachDynamicObjectToVehicle(VehicleJob[vehicleid][v_bus_text], vehicleid, -0.911, 5.391, 1.660, 0.000, 0.000, 90.000 );
	}
	
	format:g_string( "%d", Route[route][r_number] );
	SetDynamicObjectMaterialText( VehicleJob[vehicleid][v_bus_text], 0, g_string, 130, "Ariel", 32, 1, 0xFFFFFFFF, 0, 1 );
					
	SetPlayerRaceCheckpoint( playerid, 0, 
		Bus[route][point][r_pos][0], 
		Bus[route][point][r_pos][1], 
		Bus[route][point][r_pos][2],
		Bus[route][point + 1][r_pos][0], 
		Bus[route][point + 1][r_pos][1], 
		Bus[route][point + 1][r_pos][2],
		5.0
	);
	
	return 1;
}

ShowListTaxiCalls( playerid )
{
	new
		count;
		
	clean:<g_big_string>;
	
	strcat( g_big_string, " \tРайон\tОписание клиента\n" );
	
	for( new i; i < MAX_TAXICALLS; i++ )
	{
		if( Taxi[i][t_playerid] != INVALID_PARAM )
		{
			format:g_small_string( ""cWHITE"%d.\t%s\t"cBLUE"%s\n",
				count + 1,
				Taxi[i][t_zone],
				Taxi[i][t_place]
			);
			strcat( g_big_string, g_small_string );
		
			g_dialog_taxi[count] = i;
			count++;
		}
	}

	if( !count )
	{
		SendClient:( playerid, C_WHITE, ""gbError"В данный момент активных заявок нет." );
		
		format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
		return showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
	}
	
	showPlayerDialog( playerid, d_taxi + 6, DIALOG_STYLE_TABLIST_HEADERS, "Диспетчерская", g_big_string, "Принять", "Назад" );
	return 1;
}

ShowListMechCalls( playerid )
{
	new
		count;
		
	clean:<g_big_string>;
	
	strcat( g_big_string, " \tРайон\tОписание клиента\n" );
	
	for( new i; i < MAX_MECHCALLS; i++ )
	{
		if( Mechanic[i][m_playerid] != INVALID_PARAM )
		{
			format:g_small_string( ""cWHITE"%d.\t%s\t"cBLUE"%s\n",
				count + 1,
				Mechanic[i][m_zone],
				Mechanic[i][m_place]
			);
			strcat( g_big_string, g_small_string );
		
			g_dialog_mech[count] = i;
			count++;
		}
	}

	if( !count )
		return SendClient:( playerid, C_WHITE, ""gbError"В данный момент активных заявок нет." );
	
	showPlayerDialog( playerid, d_mech + 3, DIALOG_STYLE_TABLIST_HEADERS, "Диспетчерская", g_big_string, "Принять", "Закрыть" );
	return 1;
}

stock GetDamagesProduct( trailerid )
{
	new
		Float:damage = VehicleJob[trailerid][v_damages_trailer],
		Float:interval,
		temp;
	
	if( damage )
	{
		interval = ( 500.0 - ( damage - 500.0 ) ) / 500.0,
		temp = floatround( interval * 100 );
	}
	else
		return 0;
	
	return temp;
}

stock GetAmountPassenger( playerid, vehicleid )
{
	new
		amount = 0;
		
	foreach(new i : Player)
	{
		if( !IsLogged( i ) || playerid == i )
			continue;
			
		if( IsPlayerInVehicle( i, vehicleid ) && GetPlayerState( i ) == 3 )
		{
			amount++;
		}
	}

	return amount;
}

stock IsPlayerInAreaRepair( playerid )
{
	for( new i; i < sizeof zone_repair; i++ )
	{
		if( IsPlayerInDynamicArea( playerid, area_repair[i] ) )
			return i;
	}
	
	return -1;
}

RepairPartVehicle( playerid, repairid, vehicleid, part )
{
	new
		price,
		model = GetVehicleModel( vehicleid );

	if( GetPVarInt( repairid, "Repair:Vid" ) )
		return SendClient:( playerid, C_WHITE, ""gbError"Эту машину ремонтирует другой механик." );	
		
	switch( part )
	{
		case 0:
		{
			if( VehicleInfo[model - 400][v_repair] > 0 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Вы не можете произвести капитальный ремонт двигателя на этом транспорте." );
					
				format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );	
				return showPlayerDialog( playerid, d_mech + 5, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Двигатель\n\
					Кузов\n\
					Фары\n\
					Покрышки\n\
					Комплексный ремонт",
				"Выбрать", "Закрыть" );
			}
		
			if( repairid == playerid )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_ENGINE );
				SetPVarInt( playerid, "Repair:Part", part );
			
				format:g_small_string( "\
					"cBLUE"Капитальный ремонт двигателя\n\n\
					"cWHITE"Вы действительно желаете произвести капитальный ремонт двигателя "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?", 
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
					
				showPlayerDialog( playerid, d_mech + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else if( repairid != INVALID_PARAM )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_ENGINE );
			
				if( Player[repairid][uMoney] < price )
				{
					DeletePVar( playerid, "Mech:VId" );
					return SendClient:( playerid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
				}
			
				pformat:( ""gbSuccess"Вы отправили запрос на капитальный ремонт двигателя "cBLUE"%s"cWHITE", ожидайте подтверждения от владельца.",
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ) );
				psend:( playerid, C_WHITE );
				
				SetPVarInt( repairid, "Repair:Driverid", playerid );
				SetPVarInt( repairid, "Repair:Vid", vehicleid );
				SetPVarInt( repairid, "Repair:Part", part );
					
				format:g_small_string( "\
					"cBLUE"Капитальный ремонт двигателя\n\n\
					"cWHITE"Механик предлагает произвести капитальный ремонт двигателя "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".\n\n\
				Вы согласны?", GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
						
				showPlayerDialog( repairid, d_mech + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else
			{
				pformat:( ""gbSuccess"Вы произвели капитальный ремонт двигателя на "cBLUE"%s"cWHITE".", GetVehicleModelName( GetVehicleModel( vehicleid ) ) );
				psend:( playerid, C_WHITE );
				
				Vehicle[vehicleid][vehicle_engine] = 100.0;
				Vehicle[vehicleid][vehicle_engine_date] = gettime();
				
				DeletePVar( playerid, "Mech:VId" );
			}
		}
		
		case 1:
		{
			if( VehicleInfo[model - 400][v_repair] > 0 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Вы не можете отремонтировать кузов на этом транспорте." );
					
				format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );	
				return showPlayerDialog( playerid, d_mech + 5, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Двигатель\n\
					Кузов\n\
					Фары\n\
					Покрышки\n\
					Комплексный ремонт",
				"Выбрать", "Закрыть" );
			}
		
			if( Vehicle[vehicleid][vehicle_damage][2] )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Прежде чем ремонтировать кузов, замените фары." );
			
				format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( GetVehicleModel( vehicleid ) ) );	
				showPlayerDialog( playerid, d_mech + 5, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Двигатель\n\
					Кузов\n\
					Фары\n\
					Покрышки\n\
					Комплексный ремонт",
				"Выбрать", "Закрыть" );
				return 1;
			}
		
			if( repairid == playerid )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_BODY );
				SetPVarInt( playerid, "Repair:Part", part );
			
				format:g_small_string( "\
					"cBLUE"Ремонт кузова\n\n\
					"cWHITE"Вы действительно желаете отремонтировать кузов "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?", 
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
					
				showPlayerDialog( playerid, d_mech + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else if( repairid != INVALID_PARAM )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_BODY );
			
				if( Player[repairid][uMoney] < price )
				{
					DeletePVar( playerid, "Mech:VId" );
					return SendClient:( playerid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
				}
			
				pformat:( ""gbSuccess"Вы отправили запрос на ремонт кузова "cBLUE"%s"cWHITE", ожидайте подтверждения от владельца.",
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ) );
				psend:( playerid, C_WHITE );
				
				SetPVarInt( repairid, "Repair:Driverid", playerid );
				SetPVarInt( repairid, "Repair:Vid", vehicleid );
				SetPVarInt( repairid, "Repair:Part", part );
					
				format:g_small_string( "\
					"cBLUE"Ремонт кузова\n\n\
					"cWHITE"Механик предлагает отремонтировать кузов "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".\n\n\
				Вы согласны?", GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
						
				showPlayerDialog( repairid, d_mech + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else
			{
				pformat:( ""gbSuccess"Вы отремонтировали кузов на "cBLUE"%s"cWHITE".", GetVehicleModelName( GetVehicleModel( vehicleid ) ) );
				psend:( playerid, C_WHITE );
				
				Vehicle[vehicleid][vehicle_damage][1] = 0;
				Vehicle[vehicleid][vehicle_damage][0] = 0;
				SetVehicleDamageStatus( vehicleid );
				
				setVehicleHealthEx( vehicleid );
				
				DeletePVar( playerid, "Mech:VId" );
			}
		}
		
		case 2:
		{
			if( VehicleInfo[model - 400][v_repair] >= 1 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Вы не можете заменить фары на этом транспорте." );
					
				format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );	
				return showPlayerDialog( playerid, d_mech + 5, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Двигатель\n\
					Кузов\n\
					Фары\n\
					Покрышки\n\
					Комплексный ремонт",
				"Выбрать", "Закрыть" );
			}
		
			if( repairid == playerid )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_LIGHT );
				SetPVarInt( playerid, "Repair:Part", part );
			
				format:g_small_string( "\
					"cBLUE"Замена фар\n\n\
					"cWHITE"Вы действительно желаете заменить фары "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?", 
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
					
				showPlayerDialog( playerid, d_mech + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else if( repairid != INVALID_PARAM )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_LIGHT );
			
				if( Player[repairid][uMoney] < price )
				{
					DeletePVar( playerid, "Mech:VId" );
					return SendClient:( playerid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
				}
			
				pformat:( ""gbSuccess"Вы отправили запрос на замену фар "cBLUE"%s"cWHITE", ожидайте подтверждения от владельца.",
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ) );
				psend:( playerid, C_WHITE );
				
				SetPVarInt( repairid, "Repair:Driverid", playerid );
				SetPVarInt( repairid, "Repair:Vid", vehicleid );
				SetPVarInt( repairid, "Repair:Part", part );
					
				format:g_small_string( "\
					"cBLUE"Замена фар\n\n\
					"cWHITE"Механик предлагает заменить фары "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".\n\n\
				Вы согласны?", GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
						
				showPlayerDialog( repairid, d_mech + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else
			{
				pformat:( ""gbSuccess"Вы заменили фары на"cBLUE"%s"cWHITE".", GetVehicleModelName( GetVehicleModel( vehicleid ) ) );
				psend:( playerid, C_WHITE );
				
				Vehicle[vehicleid][vehicle_damage][2] = 0;
				SetVehicleDamageStatus( vehicleid );
				
				setVehicleHealthEx( vehicleid );
				
				DeletePVar( playerid, "Mech:VId" );
			}
		}
		
		case 3:
		{
			if( VehicleInfo[model - 400][v_repair] == 2 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Вы не можете заменить покрышки на этом транспорте." );
					
				format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );	
				return showPlayerDialog( playerid, d_mech + 5, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Двигатель\n\
					Кузов\n\
					Фары\n\
					Покрышки\n\
					Комплексный ремонт",
				"Выбрать", "Закрыть" );
			}
		
			if( repairid == playerid )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_WHEELS );
				SetPVarInt( playerid, "Repair:Part", part );
			
				format:g_small_string( "\
					"cBLUE"Замена покрышек\n\n\
					"cWHITE"Вы действительно желаете заменить покрышки "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?", 
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
					
				showPlayerDialog( playerid, d_mech + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else if( repairid != INVALID_PARAM )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_WHEELS );
			
				if( Player[repairid][uMoney] < price )
				{
					DeletePVar( playerid, "Mech:VId" );
					return SendClient:( playerid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
				}
			
				pformat:( ""gbSuccess"Вы отправили запрос на замену покрышек "cBLUE"%s"cWHITE", ожидайте подтверждения от владельца.",
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ) );
				psend:( playerid, C_WHITE );
				
				SetPVarInt( repairid, "Repair:Driverid", playerid );
				SetPVarInt( repairid, "Repair:Vid", vehicleid );
				SetPVarInt( repairid, "Repair:Part", part );
					
				format:g_small_string( "\
					"cBLUE"Замена покрышек\n\n\
					"cWHITE"Механик предлагает заменить покрышки "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".\n\n\
				Вы согласны?", GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
						
				showPlayerDialog( repairid, d_mech + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else
			{
				pformat:( ""gbSuccess"Вы заменили покрышки на "cBLUE"%s"cWHITE".", GetVehicleModelName( GetVehicleModel( vehicleid ) ) );
				psend:( playerid, C_WHITE );
				
				Vehicle[vehicleid][vehicle_damage][3] = 0;
				SetVehicleDamageStatus( vehicleid );
				
				setVehicleHealthEx( vehicleid );
				
				DeletePVar( playerid, "Mech:VId" );
			}
		}
		
		case 4:
		{
			if( repairid == playerid )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_COMPLEX );
				SetPVarInt( playerid, "Repair:Part", part );
			
				format:g_small_string( "\
					"cBLUE"Комплексный ремонт\n\n\
					"cWHITE"Вы действительно желаете произвести комплексный ремонт "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?", 
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
					
				showPlayerDialog( playerid, d_mech + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else if( repairid != INVALID_PARAM )
			{
				price = floatround ( float( GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ) ) / 100 * REPAIR_MECH_COMPLEX );
				
				if( Player[repairid][uMoney] < price )
				{
					DeletePVar( playerid, "Mech:VId" );
					return SendClient:( playerid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
				}
			
				pformat:( ""gbSuccess"Вы отправили запрос на комплексный ремонт "cBLUE"%s"cWHITE", ожидайте подтверждения от владельца.",
					GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ) );
				psend:( playerid, C_WHITE );
				
				SetPVarInt( repairid, "Repair:Driverid", playerid );
				SetPVarInt( repairid, "Repair:Vid", vehicleid );
				SetPVarInt( repairid, "Repair:Part", part );
				
				format:g_small_string( "\
					"cBLUE"Комплексный ремонт\n\n\
					"cWHITE"Механик предлагает произвести комплексный ремонт "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".\n\n\
				Вы согласны?", GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ), price );
						
				showPlayerDialog( repairid, d_mech + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else
			{
				pformat:( ""gbSuccess"Вы произвели комплексный ремонт "cBLUE"%s"cWHITE".", GetVehicleModelName( GetVehicleModel( vehicleid ) ) );
				psend:( playerid, C_WHITE );
				
				RepairVehicle( vehicleid );
				
				DeletePVar( playerid, "Mech:VId" );
			}
		}
	}
	
	return 1;
}

JobTimer()
{
	for( new i; i < MAX_TAXICALLS; i++ )
	{
		if( Taxi[i][t_time] < gettime() && Taxi[i][t_time] )
		{
			if( IsLogged( Taxi[i][t_playerid] ) )
			{
				SendClient:( Taxi[i][t_playerid], C_WHITE, ""gbDialog"Ваша заявка в службу такси была анулирована." );
				Player[Taxi[i][t_playerid]][jTaxi] = false;
			}
				
			Taxi[i][t_playerid] = INVALID_PARAM;
			Taxi[i][t_time] = 0;
			
			Taxi[i][t_place][0] =
			Taxi[i][t_zone][0] = EOS;
		
			Taxi[i][t_pos][0] =
			Taxi[i][t_pos][1] =	
			Taxi[i][t_pos][2] = 0.0;			
		}
		
		if( Mechanic[i][m_time] < gettime() && Mechanic[i][m_time] )
		{
			if( IsLogged( Mechanic[i][m_playerid] ) )
			{
				SendClient:( Mechanic[i][m_playerid], C_WHITE, ""gbDialog"Ваша заявка в сервисную службу была анулирована." );
				Player[Mechanic[i][m_playerid]][jMech] = false;
			}
				
			Mechanic[i][m_playerid] = INVALID_PARAM;
			Mechanic[i][m_time] = 0;
			
			Mechanic[i][m_place][0] =
			Mechanic[i][m_zone][0] = EOS;
		
			Mechanic[i][m_pos][0] =
			Mechanic[i][m_pos][1] =	
			Mechanic[i][m_pos][2] = 0.0;			
		}
		
		if( CPolice[i][p_time] < gettime() && CPolice[i][p_time] )
		{
			if( IsLogged( CPolice[i][p_playerid] ) )
			{
				//SendClient:( CPolice[i][p_playerid], C_WHITE, ""gbDialog"Ваш звонок в службу 911 был анулирован." );
				Player[ CPolice[i][p_playerid] ][jPolice] = false;
			}
			
			CPolice[i][p_playerid] = 
			CPolice[i][p_time] = 
			CPolice[i][p_type] = 0;
				
			CPolice[i][p_number][0] =
			CPolice[i][p_descript][0] = 
			CPolice[i][p_zone][0] = EOS;
			
			CPolice[i][p_pos][0] =
			CPolice[i][p_pos][1] = 
			CPolice[i][p_pos][2] = 0.0;
		}
	}
	
	for( new i; i < sizeof Woods; i++ )
	{
		if( WoodInfo[i][w_count] <= 0 )
		{
			WoodInfo[i][w_time]++;
		}
		
		if( WoodInfo[i][w_time] >= 5 )
		{
			WoodInfo[i][w_object] = CreateDynamicObject( 660, Woods[i][0], Woods[i][1], Woods[i][2], 0.0, 0.0, 0.0 );
		
			WoodInfo[i][w_use] = 
			WoodInfo[i][w_drop] = false;
				
			WoodInfo[i][w_count] = 100;
			WoodInfo[i][w_time] = 0;
		}
	}
	
	return 1;
}

//Таймеры
function OnTimerDestroyTrailer( jstock, playerid )
{
	if( !IsTrailerAttachedToVehicle( Job[playerid][j_vehicleid] ) && IsLogged( playerid ) && GetPVarInt( playerid, "Job:Turn" ) )
	{
		DeletePVar( playerid, "Job:Turn" );
		DestroyVehicle( Job[playerid][j_trailerid] );
		printf( "[Log]: Destroy job trailer ID: %d = playerid %s[%d].", Job[playerid][j_trailerid], GetAccountName( playerid ), playerid );
		
		Job[playerid][j_trailerid] = 0;

		SendClient:( playerid, C_GRAY, !""gbError"Загрузка Вашего прицепа прервана. Займите очередь повторно." );
	}

	job_load_truck[jstock][0] = 0;
	
	for( new i = 1; i < MAX_LISTITEM_LOAD; i++ )
	{
		if( job_load_truck[jstock][i] )
		{
			job_load_truck[jstock][i - 1] = job_load_truck[jstock][i];
			job_load_truck[jstock][i] = 0;
		}
	}
	
	UpdateTurnLoad( jstock );
	
	if( job_load_truck[jstock][0] )
	{	
		foreach(new j : Player)
		{
			if( job_load_truck[jstock][0] == Player[j][uID] )
			{
				CreateTrailerForPlayer( jstock, j );
				break;
			}
		}
	}

	return 1;
}

function OnTimerUpdateOrder( playerid )
{
	if( GetPVarInt( playerid, "Job:SetCheckPointProd" ) )
	{
		new
			order = GetPVarInt( playerid, "Job:SelectOrder" ),
			vid = Job[playerid][j_vehicleid];

		ProductsInfo[order][b_count_time] += Job[playerid][j_count_order];
		
		Job[playerid][j_count_order] = 0;
		KillTimer( timer_order[playerid] );

		DisablePlayerCheckpoint( playerid );

		SendClient:( playerid, C_WHITE, ""gbError"Выполнение заказа на доставку товаров прервано." );
		
		format:g_small_string( "Products: %d", VehicleJob[ vid ][v_count_prod] );
		PlayerTextDrawSetString( playerid, Taximeter[playerid], g_small_string );

		DeletePVar( playerid, "Job:SetCheckPointProd" );
		DeletePVar( playerid, "Job:SelectOrder" );
	}

	return 1;
}

function OnTimerBusStop( playerid )
{
	new
		route = GetPVarInt( playerid, "Job:SelectRoute" ),
		point = Job[playerid][j_point];
	
	SetPlayerRaceCheckpoint( playerid, 0, 
		Bus[route][point][r_pos][0], 
		Bus[route][point][r_pos][1], 
		Bus[route][point][r_pos][2],
		Bus[route][point + 1][r_pos][0], 
		Bus[route][point + 1][r_pos][1], 
		Bus[route][point + 1][r_pos][2],
		5.0
	);
	
	SetPVarInt( playerid, "Job:StopLast", point );
	
	Job[playerid][j_point]++;
	
	return 1;
}

function OnTimerWood( playerid, wood, select )
{
	switch( select )
	{
		case 0:
		{
			WoodInfo[wood][w_count] -= 25;
			WoodInfo[wood][w_drop] = true;
	        WoodInfo[wood][w_use] = false;
			
	        MoveDynamicObject( WoodInfo[wood][w_object], Woods[wood][0], Woods[wood][1], Woods[wood][2] - 0.05, 0.05, Woods[wood][3], Woods[wood][4], 0.0 );
	        
			SendClient:( playerid, C_WHITE, ""gbDefault"Для продолжения первичной обработки дерева подойдите к его основанию." );
            
			RemovePlayerAttachedObject( playerid, 9 );
			SetPlayerAttachedObject( playerid, 9, 1463, 5, 0.073999, 0.186000, 0.105998, 95.299972, -175.499984, -72.199935, 0.540999, 0.350999, 0.610999 );
	        
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_CARRY );
			SetPVarInt( playerid, "Job:WoodCheckpoint", _: SetPlayerCheckpoint( playerid, -482.8413, -88.6971, 60.7133, 1.0 ) );
		}
		
		case 1:
		{
			WoodInfo[wood][w_count] -= 25;
		
			RemovePlayerAttachedObject( playerid, 9 );
			SetPlayerAttachedObject( playerid, 9, 1463, 5, 0.073999, 0.186000, 0.105998, 95.299972, -175.499984, -72.199935, 0.540999, 0.350999, 0.610999 );
	        
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_CARRY );
			SetPVarInt( playerid, "Job:WoodCheckpoint", _: SetPlayerCheckpoint( playerid, -482.8413, -88.6971, 60.7133, 1.0 ) );
	        
			if( WoodInfo[wood][w_count] <= 0 && IsValidDynamicObject( WoodInfo[wood][w_object] ) ) 
				DestroyDynamicObject( WoodInfo[wood][w_object] );
		}
	}
	
	togglePlayerControllable( playerid, true );
	return 1;
}

GetPriceForBadVehicle( vehicleid )
{
	new
		Float:health,
		Float:interval,
		price;
		
	GetVehicleHealth( vehicleid, health );
	interval = 1000.0 - health;
	
	if( floatround( interval ) )
	{
		price = floatround( interval / 100 * VehicleInfo[ GetVehicleModel( vehicleid ) - 400 ][v_price] * 0.002 );
		return price;
	}
	
	return STATUS_ERROR;
}

function Job_OnPlayerEnterVehicle( playerid, vehicleid )
{
	if( vehicleid >= cars_food[0] && vehicleid <= cars_food[1] )
	{
		if( GetPVarInt( playerid, "Job:Food" ) )
		{
			RemovePlayerAttachedObject( playerid, 9 );
		}
	}
	
	return 1;
}

function Job_OnPlayerExitVehicle( playerid, vehicleid )
{
	if( vehicleid >= cars_food[0] && vehicleid <= cars_food[1] )
	{
		if( GetPVarInt( playerid, "Job:Food" ) )
		{
			switch( Player[playerid][uSex] )
			{
				case 1:	
				{
					SetPlayerAttachedObject( playerid, 9, 19571, 5, 0.463, 0.013, 0.0, 0.5, -93.7, 23.8, 0.928, 1.0, 0.93 );
				}
			
				case 2:
				{
					SetPlayerAttachedObject( playerid, 9, 2814, 5, 0.279, 0.004, 0.0, 0.0, -98.6, 22.8, 1.0, 0.657, 0.845 );
				}
			}
		}
	}
	
	return 1;
}