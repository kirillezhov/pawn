Vehicle_OnGameModeInit() 
{	
	mysql_tquery( mysql, "SELECT * FROM `" #DB_VEHICLES "` WHERE `vehicle_user_id` = -1", "LoadVehicle", "i", INVALID_PLAYER_ID );
	
	for( new i; i < sizeof gas_station_pos; i++ )
	{
		CreateDynamic3DTextLabel( "Бензоколонка '"cBLUE"H"cWHITE"'", 0xFFFFFFFF, gas_station_pos[i][gas_pos][0], gas_station_pos[i][gas_pos][1], gas_station_pos[i][gas_pos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1 );
	}
	
	//Авто в автосалоне
	cars_auto[0][0] = AddStaticVehicleEx(506, 1488.4696, 771.3605, 2500.7498, -180.0000, -1, -1, 100); 
	AddStaticVehicleEx(555, 1494.0498, 771.7970, 2500.6904, -198.1800, -1, -1, 100); 
	AddStaticVehicleEx(477, 1483.0507, 771.4451, 2500.7424, -180.0000, -1, -1, 100); 
	AddStaticVehicleEx(429, 1478.1724, 770.9263, 2500.6265, -96.0600, -1, -1, 100); 
	AddStaticVehicleEx(402, 1478.7578, 766.6012, 2500.7556, -90.0000, -1, -1, 100); 
	cars_auto[0][1] = AddStaticVehicleEx(560, 1488.8682, 764.8917, 2500.6838, -76.2000, -1, -1, 100);
	
	cars_auto[1][0] = AddStaticVehicleEx(517, 1488.3967, 771.6920, 2500.8647, -180.0000, -1, -1, 100); 
	AddStaticVehicleEx(496, 1493.9479, 771.7925, 2500.6904, -198.1800, -1, -1, 100); 
	AddStaticVehicleEx(412, 1482.9050, 770.9406, 2500.7747, -180.0000, -1, -1, 100); 
	AddStaticVehicleEx(400, 1478.1724, 770.9263, 2501.0505, -96.0600, -1, -1, 100); 
	AddStaticVehicleEx(401, 1478.6956, 766.3016, 2500.7959, -88.3200, -1, -1, 100); 
	cars_auto[1][1] = AddStaticVehicleEx(585, 1488.8682, 764.8917, 2500.6492, -76.2000, -1, -1, 100);
	
	cars_auto[2][0] = AddStaticVehicleEx(586, 1488.5370, 771.8918, 2500.5342, -180.0000, -1, -1, 100); 
	AddStaticVehicleEx(581, 1494.3649, 771.9903, 2500.5298, -204.6000, -1, -1, 100); 
	AddStaticVehicleEx(471, 1483.0406, 771.9013, 2500.4670, -180.0000, -1, -1, 100); 
	AddStaticVehicleEx(463, 1477.6323, 770.8629, 2500.5623, -93.6000, -1, -1, 100); 
	AddStaticVehicleEx(463, 1477.8745, 766.2956, 2500.5718, -88.3200, -1, -1, 100); 
	cars_auto[2][1] = AddStaticVehicleEx(521, 1488.8682, 764.8917, 2500.5466, -76.2000, -1, -1, 100);
	
	new
		car_cycle[2];
	
	car_cycle[0] = AddStaticVehicleEx(509, 1530.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1531.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1532.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1533.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1534.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1535.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1536.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1537.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1538.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1539.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1540.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1541.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1542.8081, -1171.4683, 23.5570, -20.5200, -1, -1, 600); 
	AddStaticVehicleEx(509, 1543.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1544.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1545.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1546.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1547.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1548.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1549.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1550.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1551.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1552.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1553.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1554.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1555.8081, -1171.4683, 23.5570, -20.5200, -1, -1, 600); 
	AddStaticVehicleEx(509, 1556.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1557.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1558.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	AddStaticVehicleEx(509, 1559.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600); 
	car_cycle[1] = AddStaticVehicleEx(509, 1529.8081, -1171.4683, 23.5570, -20.5800, -1, -1, 600);
	
	for( new i = car_cycle[0]; i < car_cycle[1] + 1; i++ )
	{
		Vehicle[i][vehicle_health] = 1000.0;
	}
	
	for( new j; j < 3; j++ )
	{
		for( new i = 0; i < 48; i++ )
		{
			if( Salon[j][i][s_model] )
			{
				car_salon = AddStaticVehicleEx( Salon[j][i][s_model], Salon[j][i][s_pos][0], Salon[j][i][s_pos][1], Salon[j][i][s_pos][2], 170.0, -1, -1, 100 ); 
			
				LinkVehicleToInterior( car_salon, 1 );
				SetVehicleVirtualWorld( car_salon, j + 10 );
				
				Vehicle[car_salon][vehicle_health] = 1000.0;
			}
		}
	}
	
	for( new i; i < 3; i++ )
	{
		for( new j = cars_auto[i][0]; j < cars_auto[i][1] + 1; j++ )
		{
			LinkVehicleToInterior( j, 1 );
			SetVehicleVirtualWorld( j, i + 10 );
			
			Vehicle[j][vehicle_health] = 1000.0;
			Vehicle[j][vehicle_state_engine] = 
			Vehicle[j][vehicle_state_light] = 
			Vehicle[j][vehicle_state_alarm] = 
			Vehicle[j][vehicle_state_hood] = 
			Vehicle[j][vehicle_state_obj] = 
			Vehicle[j][vehicle_state_door] = 
			Vehicle[j][vehicle_state_boot] = 0;
			
			Vehicle[j][vehicle_state_window][0] = 
			Vehicle[j][vehicle_state_window][1] =
			Vehicle[j][vehicle_state_window][2] =
			Vehicle[j][vehicle_state_window][3] = 1;
			
			SetVehicleParams( j );
		}
	}
	
	return 1;
}

Vehicle_OnPlayerConnect( playerid )
{
	SetPVarInt( playerid, "Vehicle:ListId", INVALID_PARAM );
	SetPVarInt( playerid, "Vehicle:TradeId", INVALID_PLAYER_ID );
	SetPVarInt( playerid, "Vehicle:SaleId", INVALID_PLAYER_ID );
	SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
	return 1;
}

function LoadVehicle( playerid )
{
	new 
		tmp				[ e_VEHICLE ],
		tmp_settings	[ 7 ],
		car,
		number			[ 34 ],
		callsign		[ 40 ],
		rows 			= cache_get_row_count(),
		bool: load 		= false,
		siren;
		
		
	if( !rows )
		return print( "[Log]: Null cars." );
		
	for( new i; i < rows; i++ )
	{
		load = false;
		
		tmp[vehicle_id] = cache_get_field_content_int( i, "vehicle_id", mysql );
		
		if( playerid != INVALID_PLAYER_ID )
		{
			for( new j; j < MAX_VEHICLES; j++ )
			{
				if( Vehicle[j][vehicle_id] && tmp[vehicle_id] == Vehicle[j][vehicle_id] )
				{
					InsertPlayerVehicle( playerid, j );
					Vehicle[j][vehicle_timer] = 0;
					load = true;
					
					printf( "[Load] Load Vehicle ID %s[%d] for player %s[%d]", GetVehicleModelName( GetVehicleModel(j) ), j, GetAccountName( playerid ), playerid );
					
					break;
				}
			}
		}
		
		if( load )
			continue;
		
		tmp[vehicle_model] = cache_get_field_content_int( i, "vehicle_model", mysql );
		tmp[vehicle_member] = cache_get_field_content_int( i, "vehicle_member", mysql );
		tmp[vehicle_crime] = cache_get_field_content_int( i, "vehicle_crime", mysql );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "vehicle_pos", g_small_string, mysql, 128 );
		sscanf( g_small_string,"p<|>a<f>[4]", tmp[vehicle_pos] );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "vehicle_color", g_small_string, mysql, 128 );
		sscanf( g_small_string,"p<|>a<d>[3]", tmp[vehicle_color] );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "vehicle_settings", g_small_string, mysql, 128 );
		sscanf( g_small_string,"p<|>a<d>[7]", tmp_settings );
		
		if( tmp[vehicle_member] && tmp[vehicle_member] != FRACTION_NEWS )
			siren = VehicleInfo[tmp[vehicle_model] - 400][v_siren];
		
		car = CreateVehicleEx( 
			tmp[vehicle_model], 
			tmp[vehicle_pos][0], 
			tmp[vehicle_pos][1], 
			tmp[vehicle_pos][2], 
			tmp[vehicle_pos][3], 
			tmp[vehicle_color][0], 
			tmp[vehicle_color][1], 
			99999,
			siren
		); 
		
		if( tmp[vehicle_color][2] && IsVehiclePaintjobCompatible( GetVehicleModel( car ) ) )
		{
			ChangeVehiclePaintjob( car, tmp[vehicle_color][2] - 1 );
		}
		
		clean:<g_small_string>;
		cache_get_field_content( i, "vehicle_damage", g_small_string, mysql, 128 );
		sscanf( g_small_string,"p<|>a<d>[4]", Vehicle[car][vehicle_damage] );
		
		SetVehicleDamageStatus( car );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "vehicle_tuning", g_small_string, mysql, 128 );
		sscanf( g_small_string,"p<|>a<d>[12]", Vehicle[car][vehicle_tuning] );
		
		for( new j; j < 12; j++ )
		{
			if( Vehicle[car][vehicle_tuning][j] && IsVehicleUpgradeCompatible( GetVehicleModel( car ), Vehicle[car][vehicle_tuning][j] ) )
			{
				AddVehicleComponent( car, Vehicle[car][vehicle_tuning][j] );
			}
		}
		
		Vehicle[car][vehicle_id] = tmp[vehicle_id];
		Vehicle[car][vehicle_user_id] = cache_get_field_content_int( i, "vehicle_user_id", mysql );
		
		Vehicle[car][vehicle_model] = tmp[vehicle_model];
		Vehicle[car][vehicle_member] = tmp[vehicle_member];
		Vehicle[car][vehicle_crime] = tmp[vehicle_crime];
		
		Vehicle[car][vehicle_pos][0] = tmp[vehicle_pos][0];
		Vehicle[car][vehicle_pos][1] = tmp[vehicle_pos][1];
		Vehicle[car][vehicle_pos][2] = tmp[vehicle_pos][2];
		Vehicle[car][vehicle_pos][3] = tmp[vehicle_pos][3];		
		
		Vehicle[car][vehicle_color][0] = tmp[vehicle_color][0];
		Vehicle[car][vehicle_color][1] = tmp[vehicle_color][1];
		Vehicle[car][vehicle_color][2] = tmp[vehicle_color][2];
		
		Vehicle[car][vehicle_state_engine] = tmp_settings[0];
		Vehicle[car][vehicle_state_light] = tmp_settings[1];
		Vehicle[car][vehicle_state_alarm] = tmp_settings[2];
		Vehicle[car][vehicle_state_door] = tmp_settings[3];
		Vehicle[car][vehicle_state_hood] = tmp_settings[4];
		Vehicle[car][vehicle_state_boot] = tmp_settings[5];
		Vehicle[car][vehicle_state_obj]	= tmp_settings[6];
		
		cache_get_field_content( i, "vehicle_number", Vehicle[car][vehicle_number], mysql, 32 );
		cache_get_field_content( i, "vehicle_callsign", callsign, mysql, 40 );

		Vehicle[car][vehicle_int] = cache_get_field_content_int( i, "vehicle_int", mysql );
		Vehicle[car][vehicle_world] = cache_get_field_content_int( i, "vehicle_world", mysql );
		Vehicle[car][vehicle_date] = cache_get_field_content_int( i, "vehicle_date", mysql );
		Vehicle[car][vehicle_engine_date] = cache_get_field_content_int( i, "vehicle_engine_date", mysql );
		Vehicle[car][vehicle_arrest] = cache_get_field_content_int( i, "vehicle_arrest", mysql );
		
		Vehicle[car][vehicle_fuel] = cache_get_field_content_float( i, "vehicle_fuel", mysql );
		Vehicle[car][vehicle_mile] = cache_get_field_content_float( i, "vehicle_mile", mysql );
		Vehicle[car][vehicle_engine] = cache_get_field_content_float( i, "vehicle_engine", mysql );

		setVehicleHealth( car, Vehicle[car][vehicle_health] );
		SetVehicleParams( car );
		
		LinkVehicleToInterior( car, Vehicle[car][vehicle_int] );
		SetVehicleVirtualWorld( car, Vehicle[car][vehicle_world] );
		
		if( isnull( Vehicle[car][vehicle_number] ) )
		{
			SetVehicleNumberPlate( car, "W/O PLATES" );
		}
		else
		{
			format( number, sizeof number, "%s", Vehicle[car][vehicle_number] );
			SetVehicleNumberPlate( car, number );
		}
		
		if( !isnull( callsign ) )
		{
			Vehicle[car][vehicle_callsign] = CreateDynamic3DTextLabel( callsign, 0xFFFFFF50, -1.0, -2.8, 0.0, 30.0, INVALID_PLAYER_ID, car );
		}
		
		//Запись машин фракции
		if( Vehicle[car][vehicle_member] )
		{
			for( new k; k < MAX_FRACVEHICLES; k++ )
			{
				if( FVehicle[Vehicle[car][vehicle_member] - 1][k][v_number][0] == EOS )
				{
					new
						fid = Vehicle[car][vehicle_member] - 1;
					
					Fraction[fid][f_amountveh]++;
					FVehicle[fid][k][v_id] = car;
			
					clean:<FVehicle[fid][k][v_number]>;
					strcat( FVehicle[fid][k][v_number], Vehicle[car][vehicle_number], 10 );	
					
					break;
				}
			}
		}
		else if( Vehicle[car][vehicle_crime] )
		{
			new
				crime = getIndexCrimeFraction( Vehicle[car][vehicle_crime] );
		
			for( new k; k < MAX_FRACVEHICLES; k++ )
			{
				if( CVehicle[ crime ][k][v_number][0] == EOS )
				{
					CVehicle[ crime ][k][v_id] = car;
			
					clean:<CVehicle[ crime ][k][v_number]>;
					strcat( CVehicle[ crime ][k][v_number], Vehicle[car][vehicle_number], 10 );

					CrimeFraction[ crime ][c_amountveh]++;
					
					break;
				}
			}
		}
		
		if( playerid != INVALID_PLAYER_ID )
		{
			InsertPlayerVehicle( playerid, car );
		}
		
		clean:<g_string>;
		mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_ITEMS " WHERE `item_type_id` = %d AND `item_type` = 3", Vehicle[car][vehicle_id] );
		mysql_tquery( mysql, g_string, "LoadVehicleInventory", "i", car );
	}
	
	printf( "[Load]: Vehicle - Loaded. All - %d.", rows );
	return 1;
}


CreateCar( car )
{
	mysql_format:g_string( "INSERT INTO `"DB_VEHICLES"` \
		( `vehicle_user_id`, `vehicle_member`, `vehicle_crime`, `vehicle_model`, `vehicle_pos`, `vehicle_number`, `vehicle_color`, `vehicle_fuel`, `vehicle_date`, `vehicle_engine`, `vehicle_engine_date` ) VALUES \
		( '%d', '%d', '%d', '%d', '%f|%f|%f|%f', '%s', '%d|%d|%d', '%f', '%d', '%f', '%d' )",
		Vehicle[car][vehicle_user_id],
		Vehicle[car][vehicle_member],
		Vehicle[car][vehicle_crime],
		Vehicle[car][vehicle_model],
		Vehicle[car][vehicle_pos][0],
		Vehicle[car][vehicle_pos][1],
		Vehicle[car][vehicle_pos][2],
		Vehicle[car][vehicle_pos][3],
		Vehicle[car][vehicle_number],
		Vehicle[car][vehicle_color][0],
		Vehicle[car][vehicle_color][1],
		Vehicle[car][vehicle_color][2],
		Vehicle[car][vehicle_fuel],
		Vehicle[car][vehicle_date],
		Vehicle[car][vehicle_engine],
		Vehicle[car][vehicle_engine_date]
	);
			
	mysql_tquery( mysql, g_string, "InsertVehicle", "i", car );
}

function InsertVehicle( car ) 
{
	Vehicle[car][vehicle_id] = cache_insert_id();
	return 1;
}

UpdateVehicleEx( id )
{
	GetVehicleHealth( id, Vehicle[id][vehicle_health] );
	CheckVehicleParams( id );
	CheckVehicleDamageStatus( id );

	mysql_format:g_string( "UPDATE `"DB_VEHICLES"` \
		SET `vehicle_health` = '%f', \
			`vehicle_engine` = '%f', \
			`vehicle_mile` = '%f', \
			`vehicle_int` = '%d', \
			`vehicle_world` = '%d', \
			`vehicle_fuel` = '%f', \
			`vehicle_damage` = '%d|%d|%d|%d', \
			`vehicle_settings` = '%d|%d|%d|%d|%d|%d|%d' \
		WHERE `vehicle_id` = %d LIMIT 1",
			Vehicle[id][vehicle_health],
			Vehicle[id][vehicle_engine],
			Vehicle[id][vehicle_mile],
			Vehicle[id][vehicle_int],
			Vehicle[id][vehicle_world],
			Vehicle[id][vehicle_fuel],
			Vehicle[id][vehicle_damage][0],
			Vehicle[id][vehicle_damage][1],
			Vehicle[id][vehicle_damage][2],
			Vehicle[id][vehicle_damage][3],
			Vehicle[id][vehicle_state_engine],
			Vehicle[id][vehicle_state_light],
			Vehicle[id][vehicle_state_alarm],
			Vehicle[id][vehicle_state_door],
			Vehicle[id][vehicle_state_hood],
			Vehicle[id][vehicle_state_boot],
			Vehicle[id][vehicle_state_obj],
			Vehicle[id][vehicle_id]
		);
	mysql_tquery( mysql, g_string );
	
	return 1;
}

stock RemovePlayerVehicleAll( playerid ) 
{
	for( new i; i < MAX_PLAYER_VEHICLES; i++ )
	{
		Player[playerid][tVehicle][i] = INVALID_VEHICLE_ID;
	}
	
	return 1;
}

stock RemovePlayerVehicle( playerid, vehicleid ) 
{
	for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
	{
		if( Player[playerid][tVehicle][i] == vehicleid ) 
		{
			Player[playerid][tVehicle][i] = INVALID_VEHICLE_ID;
			break;
		}
	}	
	
	return 1;
}

stock InsertPlayerVehicle( playerid, vehicleid ) 
{
	for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
	{
		if( Player[playerid][tVehicle][i] == INVALID_VEHICLE_ID ) 
		{
			Player[playerid][tVehicle][i] = vehicleid;
			break;
		}
	}	
	
	return 1;
}

OfferTradePlayerVehicle( playerid, tradeid ) // Функция обмена автомобилями между игроками
{
	new
		trade_vehicleid = GetPVarInt( tradeid, "Vehicle:Id" ),
		vehicleid = GetPVarInt( playerid, "Vehicle:Id" );
	
	for( new i; i < MAX_PLAYER_VEHICLES; i++ )
	{
		if( Player[playerid][tVehicle][i] == vehicleid )
		{
			Vehicle[vehicleid][vehicle_user_id] = Player[tradeid][uID];
			InsertPlayerVehicle( tradeid, vehicleid );
			
			UpdateVehicle( vehicleid, "vehicle_user_id", Player[tradeid][uID] );
			Player[playerid][tVehicle][i] = INVALID_VEHICLE_ID;
			break;
		}
	}
	
	for( new i; i < MAX_PLAYER_VEHICLES; i++ )
	{
		if( Player[tradeid][tVehicle][i] == trade_vehicleid )
		{
			Vehicle[trade_vehicleid][vehicle_user_id] = Player[playerid][uID];
			InsertPlayerVehicle( playerid, trade_vehicleid );
			
			UpdateVehicle( trade_vehicleid, "vehicle_user_id", Player[playerid][uID] );
			Player[tradeid][tVehicle][i] = INVALID_VEHICLE_ID;
			break;
		}
	}
	
	return 1;
}

OfferSalePlayerVehicle( playerid, saleid, vehicleid, const price ) // Функция продажи автомобиля другому игроку
{	
	for( new i; i < MAX_PLAYER_VEHICLES; i++ )
	{
		if( Player[playerid][tVehicle][i] == vehicleid )
		{
			Vehicle[vehicleid][vehicle_user_id] = Player[saleid][uID];
			InsertPlayerVehicle( saleid, vehicleid );
		
			UpdateVehicle( vehicleid, "vehicle_user_id", Player[saleid][uID] );
			Player[playerid][tVehicle][i] = INVALID_VEHICLE_ID;
			
			SetPlayerCash( playerid, "+", price );
			SetPlayerCash( saleid, "-", price );
			break;
		}
	}
	
	return 1;
}

stock IsOwnerVehicle( playerid, vehicleid )
{
	for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
	{
		if( Player[playerid][tVehicle][i] == vehicleid ) 
		{
			return STATUS_OK;
		}
	}	
	
	return STATUS_ERROR;
}

stock IsOwnerVehicleCount( playerid )
{
	new 
		count = 0;
		
	for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
	{
		if( Player[playerid][tVehicle][i] != INVALID_VEHICLE_ID ) 
		{
			count++;
		}
	}	
	
	return count;
}

stock IsVehicleOccupied( vehicleid )
{
	foreach(new playerid : Player)
	{
		if( IsPlayerInVehicle( playerid, vehicleid ) )
			return STATUS_OK;
	}
	
	return STATUS_ERROR;
}


function Vehicle_OnPlayerDisconnect( playerid, reason ) 
{
	new 
		id;
		
	for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
	{
		id = Player[playerid][tVehicle][i];
		
		if( id != INVALID_VEHICLE_ID ) 
		{
			UpdateVehicleEx( id );
			Vehicle[id][vehicle_timer] = DELETE_CAR_VALUE;
			
			if( i && !Premium[playerid][prem_car] )
			{
				Vehicle[id][vehicle_drop_premium] = 1;
			}
		}
	}
	
	RemovePlayerVehicleAll( playerid );
	
	return 1;
}

VehicleTimer()
{
	for( new i; i < MAX_VEHICLES; i++ )
	{
		if( Vehicle[i][vehicle_timer] > 0 && Vehicle[i][vehicle_user_id] != INVALID_PARAM && Vehicle[i][vehicle_id] )
		{
			Vehicle[i][vehicle_timer]--;
			
			if( !Vehicle[i][vehicle_timer] )
			{
				if( Vehicle[i][vehicle_drop_premium] ) //Если машина на полное удаление (Премиум)
				{
					mysql_format:g_small_string( "SELECT `prem_car` FROM `"DB_PREMIUM"` WHERE `prem_user_id` = %d LIMIT 1", Vehicle[i][vehicle_user_id] );
					mysql_tquery( mysql, g_small_string, "DestroyPremiumVehicle", "d", i );
				}
				else
				{
					printf( "[Log]: Vehicle ID: %s[%d] = vehicle_id[%d], has been deleted on server.", GetVehicleModelName( GetVehicleModel(i) ), i, Vehicle[i][vehicle_id] );
					DestroyVehicleEx( i );
				}
				
				continue;
			}
		}
		
		if( IsVelo( i ) ) continue;
		
		if( Vehicle[i][vehicle_state_engine] && Vehicle[i][vehicle_user_id] )
		{
			if( Vehicle[i][vehicle_engine] <= 20.0 )
			{
				switch( random( 10 ) )
				{
					case 5..9:
					{
						Vehicle[i][vehicle_state_engine] = 0;
						SetVehicleParams( i );
					}
				}
			}
			
			if( Vehicle[i][vehicle_engine] > 5.0 && Vehicle[i][vehicle_mile] > 100 )
			{
				Vehicle[i][vehicle_engine] -= 0.005;
			}
		}
		
		//Если закончилось топливо
		if( Vehicle[i][vehicle_fuel] <= 0.0 )
		{	
			Vehicle[i][vehicle_fuel] = 0.0;
			Vehicle[i][vehicle_state_engine] = 0;
			SetVehicleParams( i );
		}
		
		GetVehicleHealth( i, Vehicle[i][vehicle_health] );
	
		if( Vehicle[i][vehicle_health] <= 400.0 )
		{
			CheckVehicleParams( i );
			
			if( Vehicle[i][vehicle_state_engine] )
			{
				Vehicle[i][vehicle_state_engine] = 0;
				SetVehicleParams( i );
			}
			
			Vehicle[i][vehicle_health] = 400.0;
			setVehicleHealth( i, Vehicle[i][vehicle_health] );
		}
	}
}

stock IsClosedCarWindow( vehicleid )
{		
	if( Vehicle[vehicleid][vehicle_state_window][0] )
	{
		return STATUS_ERROR;
	}
	else if( Vehicle[vehicleid][vehicle_state_window][1] )
	{
		return STATUS_ERROR;
	}
	else if( Vehicle[vehicleid][vehicle_state_window][2] )
	{
		return STATUS_ERROR;
	}
	else if( Vehicle[vehicleid][vehicle_state_window][3] )
	{
		return STATUS_ERROR;
	}
	
	return STATUS_OK;
}

CreateVehicleEx( modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay, addsiren = 0 )
{
	new 
		car = CreateVehicle( modelid, x, y, z, angle, color1, color2, respawn_delay, addsiren );
		
	ClearVehicleData( car );
		
	Vehicle[car][vehicle_model] = modelid;
	Vehicle[car][vehicle_color][0] = color1;
	Vehicle[car][vehicle_color][1] = color2;
	
	Vehicle[car][vehicle_pos][0] = x;
	Vehicle[car][vehicle_pos][1] = y;
	Vehicle[car][vehicle_pos][2] = z;
	Vehicle[car][vehicle_pos][3] = angle;
	Vehicle[car][vehicle_fuel] = VehicleInfo[ Vehicle[car][vehicle_model] - 400 ][v_fuel];
	Vehicle[car][vehicle_mile] = 0.0;
	Vehicle[car][vehicle_engine] = 100.0;
	Vehicle[car][vehicle_health] = 1000.0;
	
	Vehicle[car][vehicle_state_window][0] = 
	Vehicle[car][vehicle_state_window][1] =
	Vehicle[car][vehicle_state_window][2] = 	
	Vehicle[car][vehicle_state_window][3] = 1;
	
	Vehicle[car][vehicle_date] = 
	Vehicle[car][vehicle_engine_date] =
	Vehicle[car][vehicle_damage][0] =
	Vehicle[car][vehicle_damage][1] =
	Vehicle[car][vehicle_damage][2] =
	Vehicle[car][vehicle_damage][3] =
	Vehicle[car][vehicle_state_engine] = 
	Vehicle[car][vehicle_state_light] = 
	Vehicle[car][vehicle_state_alarm] = 
	Vehicle[car][vehicle_state_hood] = 
	Vehicle[car][vehicle_state_boot] =
	Vehicle[car][vehicle_state_obj] = 
	Vehicle[car][vehicle_state_door] = 0;
		
	SetVehicleParams( car );
	
	printf( "[Log] Create Vehicle ID: %s[%d]", GetVehicleModelName( modelid ), car );
	
	return car;
}

DestroyVehicleEx( car )
{
	printf( "[Log]: Destroy vehicle ID: %s[%d] = vehicle_id[%d].", GetVehicleModelName( GetVehicleModel(car) ), car, Vehicle[car][vehicle_id] );
	ClearVehicleData( car );
	
	return ( DestroyVehicle( car ) ) ? 1 : 0;
}

ClearVehicleData( car )
{
	//new
	//	num_slots = VehicleInfo[modelid - 400][v_boot];
	
	/*if( Vehicle[car][vehicle_member] )
	{
		mysql_format:g_string( "DELETE FROM `"DB_ITEMS"` WHERE `item_type_id` = %d AND `item_type` = 2", Vehicle[car][vehicle_id] );	
		mysql_tquery( mysql, g_string );
	}*/
	
	Vehicle[car][vehicle_id] = 
	Vehicle[car][vehicle_model] =  
	Vehicle[car][vehicle_int] = 
	Vehicle[car][vehicle_world] = 
	Vehicle[car][vehicle_member] = 
	Vehicle[car][vehicle_crime] =
	Vehicle[car][vehicle_seat] =
	Vehicle[car][vehicle_color][0] = 
	Vehicle[car][vehicle_color][1] = 
	Vehicle[car][vehicle_color][2] = 0;
	
	Vehicle[car][vehicle_user_id] = INVALID_PARAM;
	
	Vehicle[car][vehicle_number][0] = EOS;
	
	Vehicle[car][vehicle_pos][0] = 
	Vehicle[car][vehicle_pos][1] = 
	Vehicle[car][vehicle_pos][2] =  
	Vehicle[car][vehicle_pos][3] = 
	Vehicle[car][vehicle_fuel] =  
	Vehicle[car][vehicle_engine] = 
	Vehicle[car][vehicle_health] = 
	Vehicle[car][vehicle_mile] = 0.0;
	
	Vehicle[car][vehicle_luke] = 
	Vehicle[car][vehicle_boat] = 
	Vehicle[car][vehicle_arrest] = 
	Vehicle[car][vehicle_state_engine] = 
	Vehicle[car][vehicle_state_light] = 
	Vehicle[car][vehicle_state_alarm] = 
	Vehicle[car][vehicle_state_hood] = 
	Vehicle[car][vehicle_state_boot] =
	Vehicle[car][vehicle_state_obj] = 
	Vehicle[car][vehicle_state_door] = 
	Vehicle[car][vehicle_timer] =
	Vehicle[car][vehicle_limit] =
	Vehicle[car][vehicle_drop_premium] =
	Vehicle[car][vehicle_engine_date] = 0;
	
	Vehicle[car][vehicle_use_boot] = false;
	
	if( IsValidDynamic3DTextLabel( Vehicle[car][vehicle_luke_text] ) )
	{
		DestroyDynamic3DTextLabel( Vehicle[car][vehicle_luke_text] );
	}
	
	if( IsValidDynamic3DTextLabel( Vehicle[car][vehicle_callsign] ) )
	{
		DestroyDynamic3DTextLabel( Vehicle[car][vehicle_callsign] );
	}
	
	Vehicle[car][vehicle_callsign] = 
	Vehicle[car][vehicle_luke_text] = Text3D: INVALID_3DTEXT_ID;
	
	for( new i; i < 12; i++ ) Vehicle[car][vehicle_tuning][i] = 0;
	for( new i; i < MAX_INVENTORY_WAREHOUSE; i++ ) clearSlotWareHouse( car, i, TYPE_WARECAR );
	for( new i; i < 3; i++ ) Vehicle[car][vehicle_water][i] = 0;
	for( new i; i < 6; i++ ) Vehicle[car][vehicle_siren][i] = 0;
}

function Vehicle_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED( KEY_ACTION ) )
	{
		if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER ) 
			return 1;
			
		new 
			vehicle = GetPlayerVehicleID( playerid );
	
		if( !IsVelo( vehicle ) ) CheckEngine( playerid, vehicle );
	}
	else if( PRESSED( KEY_FIRE ) )
	{
		if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER ) 
			return 1;
		
		new 
			vehicle = GetPlayerVehicleID( playerid );
	
		if( !IsVelo( vehicle ) ) CheckLight( vehicle );
	}
	else if( PRESSED( KEY_WALK ) )
	{
		//Автосалон
		if( IsPlayerInRangeOfPoint( playerid, 2.0, PICKUP_SALON ) )
		{
			showPlayerDialog( playerid, d_cars + 10, DIALOG_STYLE_MSGBOX, " ", "\
				"cBLUE"Покупка транспорта\n\n\
				"cWHITE"Желаете перейти к выбору транспорта?", "Да", "Нет" );
		}
		//Утилизация
		else if( IsPlayerInRangeOfPoint( playerid, 2.0, PICKUP_UTILIZATION ) )
		{
			if( GetPVarInt( playerid, "Utilization:Carid" ) )
			{
				format:g_small_string( "\
					"cBLUE"Утилизация %s\n\n\
					"cWHITE"Вы желаете отказаться от утилизации?",
					VehicleInfo[GetVehicleModel( GetPVarInt( playerid, "Utilization:Carid" ) ) - 400][v_name] );
				showPlayerDialog( playerid, d_cars + 15, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				return 1;
			}
		
			ShowPlayerVehicleList( playerid, d_cars + 13 );
		}
	}
	
	else if( PRESSED(KEY_CROUCH) )
	{
		if( IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) 
		{
			for( new i; i < sizeof gas_station_pos; i++ )
			{
				if( GetVehicleDistanceFromPoint( GetPlayerVehicleID( playerid ), gas_station_pos[i][gas_pos][0], gas_station_pos[i][gas_pos][1], gas_station_pos[i][gas_pos][2] ) < 5.0 && 
					!IsVelo( GetPlayerVehicleID( playerid ) ) )
				{
					new
						vehicleid = GetPlayerVehicleID( playerid ),
						price = PRICE_FOR_LITER;
				
					if( gas_station_pos[i][gas_frac] )
					{
						if( !Vehicle[vehicleid][vehicle_member] )
							continue;
						else
						{
							price -= 5;
						}
					}
	
					SetPVarInt( playerid, "Gas:ID", i );
				
					format:g_small_string( "\
						"cBLUE"Заправочная станция\n\n\
						"cWHITE"Транспорт: "cGRAY"%s\n\
						"cWHITE"Топливный бак: "cGRAY"%0.2f/%0.2f"cWHITE" л.\n\
						За литр: "cGRAY"$%d\n\n\
						"cWHITE"Укажите количество литров для заправки:",
						GetVehicleModelName( GetVehicleModel( vehicleid ) ),
						Vehicle[vehicleid][vehicle_fuel], VehicleInfo[ GetVehicleModel( vehicleid ) - 400 ][v_fuel], 
						price );
					return showPlayerDialog( playerid, d_cars + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Заправка", "Закрыть" );
				}
			}
		}
	}

	return 1;
}

stock CheckLight( vehicleid ) 
{
	CheckVehicleParams( vehicleid );
	
	if( !Vehicle[vehicleid][vehicle_state_light] )
	{	
		for( new i; i < 3; i++ )
		{
			if( vehicleid >= cars_auto[i][0] && vehicleid <= cars_auto[i][1] ) return 1;
		}
	
		Vehicle[vehicleid][vehicle_state_light] = 1; 
	}
	else
	{
		Vehicle[vehicleid][vehicle_state_light] = 0;
	}
	
	SetVehicleParams( vehicleid );
	return 1;
}

stock CheckEngine( playerid, vehicleid ) 
{
	CheckVehicleParams( vehicleid );
	GetVehicleHealth( vehicleid, Vehicle[vehicleid][vehicle_health] );
	
	if( IsPlayerInAnyVehicle(  playerid ) )
	{
		if( !Vehicle[vehicleid][vehicle_state_engine] )
		{
			for( new i; i < 3; i++ )
			{
				if( vehicleid >= cars_auto[i][0] && vehicleid <= cars_auto[i][1] ) return 1;
			}
			
			if( Vehicle[vehicleid][vehicle_user_id] != INVALID_PARAM && 
				Vehicle[vehicleid][vehicle_user_id] != Player[playerid][uID] )
			{
				return SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
			}
			
			if( Vehicle[vehicleid][vehicle_member] && !PlayerLeaderFraction( playerid, Vehicle[vehicleid][vehicle_member] - 1 ) )
			{
				if( !Player[playerid][uRank] || Vehicle[vehicleid][vehicle_member] != Player[playerid][uMember] ) 
					return SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
					
				new
					rank = getRankId( playerid, Vehicle[vehicleid][vehicle_member] - 1 ),
					bool:flag = false;
					
				for( new j; j < 10; j++ )
				{
					if( FRank[Vehicle[vehicleid][vehicle_member] - 1][rank][r_vehicles][j] == Vehicle[vehicleid][vehicle_model] )
					{
						flag = true;
						break;
					}
				}
				
				if( !flag )	return SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
			}
			
			if( Vehicle[vehicleid][vehicle_crime] && !PlayerLeaderCrime( playerid, getIndexCrimeFraction( Vehicle[vehicleid][vehicle_crime] ) ) )
			{
				if( !Player[playerid][uCrimeRank] || Vehicle[vehicleid][vehicle_crime] != Player[playerid][uCrimeM] ) 
					return SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
					
				new
					crime = getIndexCrimeFraction( Vehicle[vehicleid][vehicle_crime] ),
					rank = getCrimeRankId( playerid, crime ),
					bool:flag = false;
					
				for( new j; j < 10; j++ )
				{
					if( CrimeRank[crime][rank][r_vehicles][j] == Vehicle[vehicleid][vehicle_model] )
					{
						flag = true;
						break;
					}
				}
				
				if( !flag )	return SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
			}
		
			if( Vehicle[vehicleid][vehicle_fuel] <= 0.0 ) 
				return SendClient:( playerid, C_WHITE, !""gbError"В данном транспорте закончилось топливо." );
			
			if( Vehicle[vehicleid][vehicle_engine] <= 5.0 || Vehicle[vehicleid][vehicle_health] <= 400.0 )
				return SendClient:( playerid, C_WHITE, !""gbError"Двигатель не заводится." );
		
			if( vehicleid >= cars_prod[0] && vehicleid <= cars_prod[1] ) 
			{
				if( Player[playerid][uJob] != JOB_PRODUCTS ) return SendClient:( playerid, C_GRAY, !NO_KEY_CAR );
				if( vehicleid != Job[playerid][j_vehicleid] ) return SendClient:( playerid, C_GRAY, !NO_KEY_CAR );
			}
			
			else if( vehicleid >= cars_bus[0] && vehicleid <= cars_bus[1] ) 
			{
				if( Player[playerid][uJob] != JOB_DRIVEBUS ) return SendClient:( playerid, C_GRAY, !NO_KEY_CAR );
				if( vehicleid != Job[playerid][j_vehicleid] ) return SendClient:( playerid, C_GRAY, !NO_KEY_CAR );
			}
			
			else if( vehicleid >= cars_taxi[0] && vehicleid <= cars_taxi[1] ) 
			{
				if( Player[playerid][uJob] != JOB_DRIVETAXI || vehicleid != Job[playerid][j_vehicleid] ) 
					return SendClient:( playerid, C_GRAY, !NO_KEY_CAR );
			}
			
			else if( vehicleid >= cars_mech[0] && vehicleid <= cars_mech[1] ) 
			{
				if( Player[playerid][uJob] != JOB_MECHANIC || !job_duty{playerid} ) 
					return SendClient:( playerid, C_GRAY, !NO_KEY_CAR );
			}
		
			Vehicle[vehicleid][vehicle_state_engine] = 1;
		}
		else
		{
			Vehicle[vehicleid][vehicle_state_engine] = 0; 
		}	
			
		SetVehicleParams( vehicleid );
	}
	
	return 1;
}	

stock SetVehicleParams( vehicleid ) 
{
	SetVehicleParamsEx( vehicleid, 
		Vehicle[vehicleid][vehicle_state_engine], 
		Vehicle[vehicleid][vehicle_state_light], 
		Vehicle[vehicleid][vehicle_state_alarm], 
		Vehicle[vehicleid][vehicle_state_door], 
		Vehicle[vehicleid][vehicle_state_hood], 
		Vehicle[vehicleid][vehicle_state_boot], 
		Vehicle[vehicleid][vehicle_state_obj] );
	
	SetVehicleParamsCarWindows( vehicleid, 
		Vehicle[vehicleid][vehicle_state_window][0], 
		Vehicle[vehicleid][vehicle_state_window][1], 
		Vehicle[vehicleid][vehicle_state_window][2], 
		Vehicle[vehicleid][vehicle_state_window][3] 
	);	
	return 1;	
}

stock CheckVehicleParams( vehicleid ) 
{
	GetVehicleParamsEx( vehicleid, 
		Vehicle[vehicleid][vehicle_state_engine], 
		Vehicle[vehicleid][vehicle_state_light], 
		Vehicle[vehicleid][vehicle_state_alarm], 
		Vehicle[vehicleid][vehicle_state_door], 
		Vehicle[vehicleid][vehicle_state_hood], 
		Vehicle[vehicleid][vehicle_state_boot], 
		Vehicle[vehicleid][vehicle_state_obj] 
	);
	
	GetVehicleParamsCarWindows( vehicleid, 
		Vehicle[vehicleid][vehicle_state_window][0], 
		Vehicle[vehicleid][vehicle_state_window][1], 
		Vehicle[vehicleid][vehicle_state_window][2], 
		Vehicle[vehicleid][vehicle_state_window][3] 
	);
	
	return 1;
}

stock CheckVehicleDamageStatus( vehicleid )
{
	GetVehicleDamageStatus( vehicleid,
		Vehicle[vehicleid][vehicle_damage][0],
		Vehicle[vehicleid][vehicle_damage][1],
		Vehicle[vehicleid][vehicle_damage][2],
		Vehicle[vehicleid][vehicle_damage][3]		
	);

	return 1;
}

stock SetVehicleDamageStatus( vehicleid )
{
	UpdateVehicleDamageStatus( vehicleid,
		Vehicle[vehicleid][vehicle_damage][0],
		Vehicle[vehicleid][vehicle_damage][1],
		Vehicle[vehicleid][vehicle_damage][2],
		Vehicle[vehicleid][vehicle_damage][3]		
	);

	return 1;
}


GetPosVehicleBoot( vehicleid, &Float:x, &Float:y, &Float:z ) 
{
    new 
		Float: angle,
		Float: distance;
		
    GetVehicleModelInfo( GetVehicleModel( vehicleid ), VEHICLE_MODEL_INFO_SIZE, x, distance, z );
    distance = ( distance / 2 + 0.1 );
    GetVehiclePos( vehicleid, x, y, z );
    GetVehicleZAngle( vehicleid, angle );
    x += ( distance * floatsin( -angle + 180, degrees ) );
    y += ( distance * floatcos( -angle + 180, degrees ) );
	
    return 1;
}

stock GetPosVehicleHood( vehicleid, &Float:x, &Float:y, &Float:z ) 
{
    new 
		Float: angle,
		Float: distance;
		
    GetVehicleModelInfo( GetVehicleModel( vehicleid ), VEHICLE_MODEL_INFO_SIZE, x, distance, z );
    distance = ( distance / 2 + 0.1 );
    GetVehiclePos( vehicleid, x, y, z );
    GetVehicleZAngle( vehicleid, angle );
    x += ( distance * floatsin( angle + 180, degrees ) );
    y += ( distance * floatcos( angle + 180, degrees ) );
	
    return 1;
}

SetSearchVehicleMod( playerid, vehicleid, bool: search )
{
	if( search )
	{
		new
			Float:x,
			Float:y,
			Float:z;
			
		GetVehiclePos( vehicleid, x, y, z );
		
		g_player_gps{playerid} = 1;
		SetPlayerCheckpoint(
			playerid,
			x, 
			y, 
			z, 
			5.0
		);
	}
	else
	{
		g_player_gps{playerid} = 0;
		DisablePlayerCheckpoint( playerid );
	}
}

SetVehiclePark( vehicleid )
{
	GetVehiclePos( vehicleid, 
		Vehicle[vehicleid][vehicle_pos][0],
		Vehicle[vehicleid][vehicle_pos][1],
		Vehicle[vehicleid][vehicle_pos][2]
	);
	
	GetVehicleZAngle( vehicleid, Vehicle[vehicleid][vehicle_pos][3] );
	
	format:g_big_string( "%f|%f|%f|%f",
		Vehicle[vehicleid][vehicle_pos][0],
		Vehicle[vehicleid][vehicle_pos][1],
		Vehicle[vehicleid][vehicle_pos][2],
		Vehicle[vehicleid][vehicle_pos][3]
	);
	
	//UpdateVehicleString( Vehicle[vehicleid][vehicle_id], "vehicle_pos", g_big_string );
	
	mysql_format:g_string( "UPDATE `"DB_VEHICLES"`\
		SET\
			`vehicle_int` = '%d',\
			`vehicle_world` = '%d',\
			`vehicle_pos` = '%f|%f|%f|%f'\
		WHERE `vehicle_id` = %d",
		Vehicle[vehicleid][vehicle_int],
		Vehicle[vehicleid][vehicle_world],
		Vehicle[vehicleid][vehicle_pos][0],
		Vehicle[vehicleid][vehicle_pos][1],
		Vehicle[vehicleid][vehicle_pos][2],
		Vehicle[vehicleid][vehicle_pos][3],
		Vehicle[vehicleid][vehicle_id]
	);
	mysql_tquery( mysql, g_string );
	
	SetVehicleZAngle( vehicleid, Vehicle[vehicleid][vehicle_pos][3] );
	setVehiclePos( vehicleid, 
		Vehicle[vehicleid][vehicle_pos][0],
		Vehicle[vehicleid][vehicle_pos][1],
		Vehicle[vehicleid][vehicle_pos][2]
	);
	
	return 1;
}

ShowDialogVehicleSell( playerid, const vehicleid, reason[] = "", dialogid = d_cars + 8 )
{
	new
		price = GetVehiclePrice( Vehicle[vehicleid][vehicle_model] );
		
	clean:<g_big_string>;
	
	strcat( g_big_string, ""cBLUE"Продажа транспорта.\n\n"cWHITE"Введите сумму продажи данного транспорта:\n" ); 
	format:g_string( ""gbDialogSuccess"Максимальная сумма продажи - $%d.\n"gbDialogError"Минимальная сумма продажи - $1.%s",
		floatround( ( price * 0.2 ) + price ),
		reason
	);
	
	strcat( g_big_string, g_string );
	
	return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
}

ShowVehicleInformation( playerid, vehicleid, dialogid = INVALID_DIALOG_ID, btn[], btn2[] )
{
	clean:<g_string>;
	
	new
		model = GetVehicleModel( vehicleid );
	
	strcat( g_string, ""gbDefault"Информация о транспорте:\n\n" );
	
	format:g_small_string( "Название: "cBLUE"%s"cWHITE"\n",
		GetVehicleModelName( model )
	);
	strcat( g_string, g_small_string );
	
	format:g_small_string( "Тип кузова: "cBLUE"%s"cWHITE"\n",
		VehicleInfo[model - 400][v_type]
	);
	strcat( g_string, g_small_string );
	
	format:g_small_string( "Стоимость: "cBLUE"$%d"cWHITE"\n",
		GetVehiclePrice( model ) 
	);
	strcat( g_string, g_small_string );
	
	format:g_small_string( "Количество сидячих мест: "cBLUE"%d"cWHITE"\n",
		VehicleInfo[model - 400][v_seat]
	);
	strcat( g_string, g_small_string );
	
	format:g_small_string( "Привод: "cBLUE"%s"cWHITE"\n",
		VehicleInfo[model - 400][v_driving]
	);
	strcat( g_string, g_small_string );
	
	if( GetVehicleBag( GetVehicleModel( vehicleid ) ) != 0 )
	{
		format:g_small_string( "Вместимость багажника: "cBLUE"%d мест"cWHITE"\n",
			GetVehicleBag( GetVehicleModel( vehicleid ) )
		);
		strcat( g_string, g_small_string );
	}
	else
	{
		strcat( g_string, "Вместимость багажника: "cBLUE"Не предусмотрено"cWHITE"\n" );
	}
	
	if( VehicleInfo[model - 400][v_speed] == 0.0 )
	{
		strcat( g_string, "Макс. скорость: "cBLUE"Неизвестно"cWHITE"\n" );
	}
	else
	{
		format:g_small_string( "Макс. скорость: "cBLUE"%d м/ч"cWHITE"\n",
			VehicleInfo[model - 400][v_speed]
		);
		strcat( g_string, g_small_string );
	}
	
	if( VehicleInfo[model - 400][v_racing] == 0.0 )
	{
		strcat( g_string, "Разгон до 100 м/ч: "cBLUE"Неизвестно"cWHITE"\n" );
	}
	else
	{
		format:g_small_string( "Разгон до 100 м/ч: "cBLUE"%.1f с."cWHITE"\n",
			VehicleInfo[model - 400][v_racing]
		);
		strcat( g_string, g_small_string );
	}
	
	if( VehicleInfo[model - 400][v_fuel] != 0.0 )
	{
		format:g_small_string( "Ёмкость топливного бака: "cBLUE"%.1f л."cWHITE"\n",
			VehicleInfo[ model - 400 ][v_fuel] 
		);
		strcat( g_string, g_small_string );
		
		format:g_small_string( "Расход на 100 миль: "cBLUE"%.1f л."cWHITE"\n",
			VehicleInfo[ model - 400 ][v_consumption] 
		);
		strcat( g_string, g_small_string );
	}
	
	/*format:g_small_string( "Возможность установки фаркопа: "cBLUE"%s"cWHITE"\n",
		VehicleInfo[ model - 400 ][v_towhitch] ? ("Да") : ("Нет")
	);
	strcat( g_string, g_small_string );*/
	
	if( !IsVelo( vehicleid ) )
	{
		format:g_small_string( "Состояние двигателя: "cBLUE"%.1f %s"cWHITE"\n",
			Vehicle[vehicleid][vehicle_engine], "%" 
		);
		strcat( g_string, g_small_string );
		
		format:g_small_string( "Состояние кузова: %s\n",
			Vehicle[vehicleid][vehicle_damage][0] ? (""cRED"Поврежден"cWHITE"") : (""cBLUE"Не поврежден"cWHITE"")
		);
		strcat( g_string, g_small_string );
		
		format:g_small_string( "Состояние фар: %s\n",
			Vehicle[vehicleid][vehicle_damage][2] ? (""cRED"Повреждены"cWHITE"") : (""cBLUE"Не повреждены"cWHITE"")
		);
		strcat( g_string, g_small_string );
		
		format:g_small_string( "Состояние колёс: %s",
			Vehicle[vehicleid][vehicle_damage][3] ? (""cRED"Повреждены"cWHITE"") : (""cBLUE"Не повреждены"cWHITE"")
		);
		strcat( g_string, g_small_string );
	}
	
	return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_MSGBOX, " ", g_string, btn, btn2 );
}

ShowVehicleAddInformation( playerid, vehicleid, dialogid = INVALID_DIALOG_ID )
{
	clean:<g_string>;
	
	new
		model = GetVehicleModel( vehicleid );

	format:g_small_string( ""gbDefault"Доп. информация о транспорте "cBLUE"%s"cWHITE":\n\n", GetVehicleModelName( model ) );
	strcat( g_string, g_small_string );
	
	CleanDate;
	gmtime( Vehicle[vehicleid][vehicle_engine_date], g_year, g_month, g_day, _, _, _ );
	
	format:g_small_string( "Дата капитального ремонта: "cBLUE"%02d.%02d.%d"cWHITE"\n",
		g_day, g_month, g_year
	);
	strcat( g_string, g_small_string );
	
	if( isnull( Vehicle[vehicleid][vehicle_number] ) )
	{
		strcat( g_string, "Гос. номер: "cBLUE"Нет"cWHITE"\n" );
	}
	else
	{
		format:g_small_string( "Гос. номер: "cBLUE"%s"cWHITE"\n",
			Vehicle[vehicleid][vehicle_number]
		);
		strcat( g_string, g_small_string );
	}
	
	strcat( g_string, "Сигнализация: [ Пусто ]\n" );
	
	for( new i; i < 11; i++ )
	{
		if( Vehicle[vehicleid][vehicle_tuning][i] )
		{
			format:g_small_string( ""cBLUE"%s"cWHITE"\n",
				GetComponentName( Vehicle[vehicleid][vehicle_tuning][i] )
			);
			strcat( g_string, g_small_string );
		}
	}
	
	format:g_small_string( "Пневмоподвеска: "cBLUE"%s"cWHITE"",
		Vehicle[vehicleid][vehicle_tuning][11] ? ("Установлена") : ("Не установлена")
	);
	strcat( g_string, g_small_string );

	return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_MSGBOX, " ", g_string, "Назад", "" );
}

ShowDialogCarManaged( playerid, vehicleid )
{
	clean:<g_string>;

	CheckVehicleParams( vehicleid );
	
	new
		model = GetVehicleModel( vehicleid ),
		count;
	
	if( VehicleInfo[ model - 400 ][v_hood] )
	{
		format:g_small_string( "\
			"cBLUE"-"cWHITE" Капот "cGRAY"(/hood)"cWHITE"\t| %s", 
			( Vehicle[vehicleid][vehicle_state_hood] == 1 ) ? (""cBLUE"Открыт"cWHITE"") : (""cGRAY"Закрыт"cWHITE"") );
			
		strcat( g_string, g_small_string );
		
		g_dialog_select[playerid][count] = 0;
		count++;
	}
	
	if( GetVehicleBag( model ) )
	{
		if( count )
		{
			strcat( g_string, "\n" );
		}
	
		format:g_small_string( "\
			"cBLUE"-"cWHITE" Багажник "cGRAY"(/boot)"cWHITE"\t| %s", 
			( Vehicle[vehicleid][vehicle_state_boot] ) ? (""cBLUE"Открыт"cWHITE"") : (""cGRAY"Закрыт"cWHITE"") );
			
		strcat( g_string, g_small_string );
		
		g_dialog_select[playerid][count] = 1;
		count++;
	}

	if( !count )
		return 0;
	
	return showPlayerDialog( playerid, d_cars + 3, DIALOG_STYLE_TABLIST, " ", g_string, "Далее", "Назад" );
}

ShowPlayerVehicleList( playerid, _: dialogid, btn[] = "Закрыть" )
{
	new 
		count = 1;
	
	clean:<g_big_string>;
	strcat( g_big_string, ""gbDialog"Выберите транспорт" );
		
	for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
	{
		if( Player[playerid][tVehicle][i] != INVALID_VEHICLE_ID ) 
		{
			for( new j; j < MAX_VEHICLES; j++ )
			{
				if( Player[playerid][tVehicle][i] == j )
				{
					format:g_small_string( "\n"cBLUE"-"cWHITE" %s[%d]",
						GetVehicleModelName( Vehicle[j][vehicle_model] ),
						Vehicle[j][vehicle_id]
					);
					
					strcat( g_big_string, g_small_string );
					
					g_dialog_select[playerid][count] = j;
					
					count++;
				}
			}
		}
	}

	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_LIST, " ", g_big_string, "Выбрать", btn );
	return 1;
}

ShowDialogCarPanel( playerid, dialogid = d_cars + 1 )
{
	return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_LIST, 
		GetVehicleModelName( Vehicle[ GetPVarInt( playerid, "Vehicle:Id" ) ][vehicle_model] ), 
		vehcontent_cpanel, 
	"Выбрать", "Назад" );
}


function Vehicle_OnPlayerClickTextDraw( playerid, Text:clickedid ) 
{
	clean_array();
	
	if( _:clickedid == INVALID_TEXT_DRAW  ) 
	{
		if( GetPVarInt( playerid, "Salon:Show" ) )
		{
			PlayerTextDrawHide( playerid, carshop_info[playerid] );
			PlayerTextDrawHide( playerid, tuning_name[playerid] );
			PlayerTextDrawHide( playerid, tuning_price[playerid] );
						
			for( new i; i < 7; i++ )
			{
				TextDrawHideForPlayer( playerid, carshop[i] );
			}
			
			stopPlayer( playerid, 2 );
			setPlayerPos( playerid, PICKUP_SALON );
			SetPlayerVirtualWorld( playerid, GetPVarInt( playerid, "Salon:Shop" ) + 10 );
			SetCameraBehindPlayer( playerid );
			
			DeletePVar( playerid, "Salon:Shop" );
			DeletePVar( playerid, "Salon:Page" );
			DeletePVar( playerid, "Salon:Max" );
			DeletePVar( playerid, "Player:World" );
			DeletePVar( playerid, "Salon:Show" );
			
			return 1;
		}
	}
	else if( clickedid == carshop[3] ) //Стрелка влево
	{
		if( !GetPVarInt( playerid, "Salon:Page" ) )
		{
			ShowSalonPage( playerid, GetPVarInt( playerid, "Salon:Shop" ), GetPVarInt( playerid, "Salon:Max" ) - 1 );
			return 1;
		}
		
		ShowSalonPage( playerid, GetPVarInt( playerid, "Salon:Shop" ), GetPVarInt( playerid, "Salon:Page" ) - 1 );
		return 1;
	}
	else if( clickedid == carshop[4] ) //Стрелка вправо
	{
		if( GetPVarInt( playerid, "Salon:Page" ) + 1 == GetPVarInt( playerid, "Salon:Max" ) )
		{
			ShowSalonPage( playerid, GetPVarInt( playerid, "Salon:Shop" ), 0 );
			return 1;
		}
		
		ShowSalonPage( playerid, GetPVarInt( playerid, "Salon:Shop" ), GetPVarInt( playerid, "Salon:Page" ) + 1 );
		return 1;
	}
	else if( clickedid == carshop[5] ) //Купить
	{
		/*if( !Player[playerid][uLevel] )
		{
			return SendClient:( playerid, C_WHITE, !""gbError"Ваш уровень не позволяет приобрести транспорт." );
		}*/
	
		if( !GetStatusPlayerLicense( playerid, LICENSE_DRIVE ) || GetStatusPlayerLicense( playerid, LICENSE_DRIVE ) == 2 )
		{
			return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет водительского удостоверения." );
		}
	
		if( IsOwnerVehicleCount( playerid ) >= 1 + Premium[playerid][prem_car] )
		{
			return SendClient:( playerid, C_WHITE, !""gbError"У вас уже есть транспортное средство." );
		}
		
		new
			shop = GetPVarInt( playerid, "Salon:Shop" ),
			page = GetPVarInt( playerid, "Salon:Page" ),
			index = Salon[shop][page][s_model] - 400;
		
		if( Player[playerid][uMoney] < VehicleInfo[index][v_price] )
		{
			return SendClient:( playerid, C_WHITE, !NO_MONEY );
		}
		
		DeletePVar( playerid, "Salon:Show" );
		CancelSelectTextDraw( playerid );
		
		format:g_small_string( "\
			"cBLUE"Покупка транспорта\n\n\
			"cWHITE"Вы действительно желаете купить "cBLUE"%s %s"cWHITE" за "cBLUE"$%d"cWHITE"?", 
			VehicleInfo[index][v_type],
			VehicleInfo[index][v_name], 
			VehicleInfo[index][v_price] );
		showPlayerDialog( playerid, d_cars + 11, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		return 1;
	}
	else if( clickedid == carshop[6] ) //Назад
	{
		CancelSelectTextDraw( playerid );
		return 1;
	}
	
	return 0;
	
}

ShowSalonPage( playerid, shop, page )
{
	SetPVarInt( playerid, "Salon:Page", page );
	
	new
		index = Salon[shop][page][s_model] - 400,
		Float: interval = page * 5.3,
		Float: y_salon,
		Float: y_salon_camera,
		Float: y_salon_camera_2,
		camera_type;
		
	if( !page ) 
		camera_type = 2;
	else
		camera_type = 1;
		
	switch( shop )
	{
		case 0: 
		{
			y_salon = 3028.0315;
			y_salon_camera = 3033.634277;
			y_salon_camera_2 = 3031.476074;
		}
		case 1:
		{
			y_salon = 3628.0315;
			y_salon_camera = 3633.634277;
			y_salon_camera_2 = 3631.476074;
		}
		case 2:
		{
			y_salon = 4228.0313;
			y_salon_camera = 4233.634277;
			y_salon_camera_2 = 4231.476074;
		}
	}

	format:g_string(
		"\
			Тип кузова: %s~n~\
			Количество мест: %d~n~\
			Привод: %s~n~\
			Вместимость багажника: %s~n~\
			Макс. скорость: %s~n~\
			Разгон до 100 м/ч: %s~n~\
			Топливный бак: %s~n~\
			Расход на 100 миль: %s\
		", 
		VehicleInfo[index][v_type],
		VehicleInfo[index][v_seat],
		VehicleInfo[index][v_driving],
		inttostr( 0, float(VehicleInfo[index][v_boot])),
		inttostr( 1, float(VehicleInfo[index][v_speed])),
		inttostr( 2, VehicleInfo[index][v_racing]),
		inttostr( 3, VehicleInfo[index][v_fuel]),
		inttostr( 4, VehicleInfo[index][v_consumption])
	);
	PlayerTextDrawSetString( playerid, carshop_info[playerid], g_string );
			
	format:g_small_string( "%s", VehicleInfo[index][v_name] );
	PlayerTextDrawSetString( playerid, tuning_name[playerid], g_small_string );
			
	format:g_small_string( "$%d", VehicleInfo[index][v_price] );
	PlayerTextDrawSetString( playerid, tuning_price[playerid], g_small_string );
	
	setPlayerPos( playerid, 1488.2795 + interval, 760.1283, y_salon );

	SetPlayerCameraPos( playerid, 1488.578491 + interval, 759.764648, y_salon_camera );
	SetPlayerCameraLookAt( playerid, 1488.530639 + interval, 764.274597, y_salon_camera_2, camera_type );
	
	return 1;
}

function Veh_OnPlayerEnterRaceCheckpoint( playerid )
{
	if( GetPVarInt( playerid, "Utilization:Carid" ) )
	{	
		if( IsPlayerInAnyVehicle( playerid ) && GetPlayerVehicleID( playerid ) == GetPVarInt( playerid, "Utilization:Carid" ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) 
		{
			if( GetAmountPassenger( playerid, GetPVarInt( playerid, "Utilization:Carid" ) ) )
			{
				SendClient:( playerid, C_WHITE, ""gbError"В транспорте находятся пассажиры." );
				//SetPlayerCheckpoint( playerid, 1311.0554, 407.4430, 18.5524, 4.0 );
				return 1;
			}
			
			new
				vid = GetPVarInt( playerid, "Utilization:Carid" ),
				price = floatround( float( VehicleInfo[GetVehicleModel( vid ) - 400][v_price] ) / 100.0 * ( 60.0 + float( Premium[playerid][prem_house_property] ) ) );
			
			DisablePlayerRaceCheckpoint( playerid );
			
			mysql_format:g_string( "DELETE FROM `"DB_VEHICLES"` WHERE `vehicle_id` = %d", Vehicle[vid][vehicle_id] );
			mysql_tquery( mysql, g_string );
			
			mysql_format:g_string( "DELETE FROM `"DB_ITEMS"` WHERE `item_type_id` = %d AND `item_type` = 2", Vehicle[vid][vehicle_id] );	
			mysql_tquery( mysql, g_string );

			pformat:( ""gbSuccess"Ваш "cBLUE"%s"cWHITE" успешно утилизирован. Вам возвращены "cBLUE"$%d"cWHITE".", VehicleInfo[GetVehicleModel( vid ) - 400][v_name], price );
			psend:( playerid, C_WHITE );
			
			Player[playerid][uMoney] += price;
			UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );
				
			RemovePlayerVehicle( playerid, vid );
				
			DestroyVehicleEx( vid );
			DeletePVar( playerid, "Utilization:Carid" );
		}
		else
		{
			SendClient:( playerid, C_WHITE, ""gbError"Вы должны находиться в транспорте." );
		}
	}
	
	return 1;
}

stock inttostr( list, Float:value )
{
	new
		result[10];
	
	switch( list )
	{
		case 0:
		{	
			if( value )
			{
				format( result, sizeof( result ), "%.0f", value );
			}
			else result = "-";
		}
		case 1: 
		{
			if( value )
			{
				format( result, sizeof( result ), "%.0f м/ч", value );
			}
			else result = "-";
		}
		case 2:	
		{
			if( value )
			{
				format( result, sizeof( result ), "%.1f c.", value );
			}
			else result = "-";
		}
		case 3:
		{
			if( value )
			{
				format( result, sizeof( result ), "%.1f л.", value );
			}
			else result = "-";
		}
		case 4:	
		{
			if( value )
			{
				format( result, sizeof( result ), "%.1f л.", value );
			}
			else result = "-";
		}
	}
	
	return result;
}

setVehicleHealthEx( vehicleid )
{
	new
		count,
		Float:health;
		
	CheckVehicleDamageStatus( vehicleid );
	GetVehicleHealth( vehicleid, Vehicle[vehicleid][vehicle_health] );
	
	health = 1000.0 - Vehicle[vehicleid][vehicle_health];
	
	for( new i; i < 4; i++ )
	{
		if( Vehicle[vehicleid][vehicle_damage] )
			count++;
	}
	
	switch( count )
	{
		case 0: Vehicle[vehicleid][vehicle_health] = 1000.0;
		case 1: Vehicle[vehicleid][vehicle_health] += health / 100 * 50;
		case 2: Vehicle[vehicleid][vehicle_health] += health / 100 * 33.33;
		case 3: Vehicle[vehicleid][vehicle_health] += health / 100 * 25;
		case 4: Vehicle[vehicleid][vehicle_health] += health / 100 * 20;
	}
	
	setVehicleHealth( vehicleid, Vehicle[vehicleid][vehicle_health] );

	return 1;
}

/*Vehicle_OnGameModeExit( playerid )
{
	for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
	{
		new
			id = Player[playerid][tVehicle][i];
		
		if( id ) 
		{
			UpdateVehicleEx( id );
		}
	}
	
	return 1;
}*/

stock IsVelo( carid ) 
{
	switch( GetVehicleModel( carid ) ) 
	{ 
		case 481, 509, 510 : return 1; 
	}
	
	return 0;
}

stock IsBike( carid )
{
	switch( GetVehicleModel( carid ) )
	{
		case 448, 461, 462, 463, 468, 521, 522, 523, 581, 586 : return 1; 
	}

	return 0;
}

/*function Veh_OnVehicleDamageStatusUpdate( vehicleid, playerid )
{
	GetVehicleHealth( vehicleid, Vehicle[vehicleid][vehicle_health] );
	
	if( Vehicle[vehicleid][vehicle_health] <= 400.0 )
	{
		CheckVehicleParams( vehicleid );
		
		if( Vehicle[vehicleid][vehicle_state_engine] )
		{
			Vehicle[vehicleid][vehicle_state_engine] = 0;
			SendClient:( playerid, C_WHITE, !""gbError"Двигатель заглушен, вызовите механика." );
			SetVehicleParams( vehicleid );
		}
		
		Vehicle[vehicleid][vehicle_health] = 400.0;
		setVehicleHealth( vehicleid, 400.0 );
	}

	return 1;
}*/

function Veh_OnVehicleSpawn( vehicleid )
{
	if( Vehicle[vehicleid][vehicle_death] )
	{
		Vehicle[vehicleid][vehicle_health] = 400.0;
		Vehicle[vehicleid][vehicle_death] = false;
	}
	
	if( vehicleid >= cars_prod[0] && vehicleid <= cars_mech[1] )
	{	
		Vehicle[vehicleid][vehicle_damage][0] =
		Vehicle[vehicleid][vehicle_damage][1] =
		Vehicle[vehicleid][vehicle_damage][2] =
		Vehicle[vehicleid][vehicle_damage][3] = 0;
	
		Vehicle[vehicleid][vehicle_fuel] = VehicleInfo[ GetVehicleModel(vehicleid) - 400 ][v_fuel];
		Vehicle[vehicleid][vehicle_health] = 1000.0;
		Vehicle[vehicleid][vehicle_engine] = 100.0;
	}
	
	for( new j; j < 12; j++ )
	{
		if( Vehicle[vehicleid][vehicle_tuning][j] && IsVehicleUpgradeCompatible( GetVehicleModel( vehicleid ), Vehicle[vehicleid][vehicle_tuning][j] ) )
		{
			AddVehicleComponent( vehicleid, Vehicle[vehicleid][vehicle_tuning][j] );
		}
	}
	
	if( Vehicle[vehicleid][vehicle_color][2] && IsVehiclePaintjobCompatible( GetVehicleModel( vehicleid ) ) )
	{
		ChangeVehiclePaintjob( vehicleid, Vehicle[vehicleid][vehicle_color][2] - 1 );
	}
	
	setVehicleHealth( vehicleid, Vehicle[vehicleid][vehicle_health] );

	Vehicle[vehicleid][vehicle_state_window][0] = 
	Vehicle[vehicleid][vehicle_state_window][1] =
	Vehicle[vehicleid][vehicle_state_window][2] =
	Vehicle[vehicleid][vehicle_state_window][3] = 1;
	
	Vehicle[vehicleid][vehicle_state_hood] = 
	Vehicle[vehicleid][vehicle_state_boot] = 
	Vehicle[vehicleid][vehicle_state_engine] = 
	Vehicle[vehicleid][vehicle_state_light] = 
	Vehicle[vehicleid][vehicle_state_alarm] = 
	Vehicle[vehicleid][vehicle_state_door] = 
	Vehicle[vehicleid][vehicle_state_obj] = 0;
	
	if( Vehicle[vehicleid][vehicle_arrest] )
		Vehicle[vehicleid][vehicle_state_door] = 1;
	
	SetVehicleParams( vehicleid );
	SetVehicleDamageStatus( vehicleid );
	
	Vehicle[vehicleid][vehicle_use_boot] = false;
	
	if( Vehicle[vehicleid][vehicle_id] )
	{
		SetVehicleZAngle( vehicleid, Vehicle[vehicleid][vehicle_pos][3] );
		setVehiclePos( vehicleid, 
			Vehicle[vehicleid][vehicle_pos][0],
			Vehicle[vehicleid][vehicle_pos][1],
			Vehicle[vehicleid][vehicle_pos][2]
		);
	}
	
	return 1;
}

/*
stock SetVehicleNumberPlateEx( car, number[] )
{
	switch( Vehicle[car][vehicle_model] ) 
	{
		case 448, 462:
		{
			Vehicle[car][vehicle_label] = CreateDynamic3DTextLabel( number, 0xFFFFFF60, 0.0, -1.0, 0.0, 10.0, INVALID_PLAYER_ID, car );
		}
		case 461: 
		{
			Vehicle[car][vehicle_label] = CreateDynamic3DTextLabel( number, 0xFFFFFF60, 0.0, -1.3, 0.4, 10.0, INVALID_PLAYER_ID, car );
		}
		case 463, 521, 468: 
		{
			Vehicle[car][vehicle_label] = CreateDynamic3DTextLabel( number, 0xFFFFFF60, 0.0, -1.1, 0.3, 10.0, INVALID_PLAYER_ID, car );
		}
		case 522: 
		{
			Vehicle[car][vehicle_label] = CreateDynamic3DTextLabel( number, 0xFFFFFF60, 0.0, -1.1, 0.4, 10.0, INVALID_PLAYER_ID, car );
		}
		case 581: 
		{
			Vehicle[car][vehicle_label] = CreateDynamic3DTextLabel( number, 0xFFFFFF60, 0.0, -1.1, 0.3, 10.0, INVALID_PLAYER_ID, car );
		}
		case 586: 
		{
			Vehicle[car][vehicle_label] = CreateDynamic3DTextLabel( number, 0xFFFFFF60, 0.0, -1.3, 0.17, 10.0, INVALID_PLAYER_ID, car );
		}
		case 510, 509, 481: 
		{
			Vehicle[car][vehicle_label] = Text3D: INVALID_3DTEXT_ID;
		}
		default: 
		{
			Vehicle[car][vehicle_label] = CreateDynamic3DTextLabel( number, 0xFFFFFF60, 0.0, -2.8, 0.0, 10.0, INVALID_PLAYER_ID, car );
		}
	}
	
	return 1;
}*/

/* - - - - - - - - - - Припарковать транспорт - - - - - - - - - - - */
stock SetVehicleToRespawnEx( vehicleid, playerid = INVALID_PLAYER_ID )
{
	new
		car,
		modelid = GetVehicleModel( vehicleid ),
		addsiren,
		number[10],
		num_slots = VehicleInfo[ modelid - 400 ][v_boot];
		
	if( Vehicle[vehicleid][vehicle_member] )
		addsiren = VehicleInfo[ modelid - 400 ][v_siren];
	CheckVehicleDamageStatus( vehicleid );
		
	DestroyVehicle( vehicleid );
	
	printf( "vehicleid = %d", vehicleid );
	
	car = CreateVehicle( 
		modelid, 
		Vehicle[vehicleid][vehicle_pos][0], 
		Vehicle[vehicleid][vehicle_pos][1], 
		Vehicle[vehicleid][vehicle_pos][2], 
		Vehicle[vehicleid][vehicle_pos][3], 
		Vehicle[vehicleid][vehicle_color][0], 
		Vehicle[vehicleid][vehicle_color][1], 
		99999, 
		addsiren 
	);
	
	/* - - - Присваиваем переменные удаленного транспорта созданному - - - */
	
	Vehicle[car][vehicle_model] = Vehicle[vehicleid][vehicle_model];
	Vehicle[car][vehicle_id] = Vehicle[vehicleid][vehicle_id];
	Vehicle[car][vehicle_int] = Vehicle[vehicleid][vehicle_int];
	Vehicle[car][vehicle_world] = Vehicle[vehicleid][vehicle_world];
	Vehicle[car][vehicle_member] = Vehicle[vehicleid][vehicle_member];
	Vehicle[car][vehicle_crime] = Vehicle[vehicleid][vehicle_crime];
	Vehicle[car][vehicle_color][0] = Vehicle[vehicleid][vehicle_color][0];
	Vehicle[car][vehicle_color][1] = Vehicle[vehicleid][vehicle_color][1];
	Vehicle[car][vehicle_color][2] = Vehicle[vehicleid][vehicle_color][2];
	
	Vehicle[car][vehicle_user_id] = Vehicle[vehicleid][vehicle_user_id];
	
	clean:<Vehicle[car][vehicle_number]>;
	strcat( Vehicle[car][vehicle_number], Vehicle[vehicleid][vehicle_number], 10 );
	
	Vehicle[car][vehicle_pos][0] = Vehicle[vehicleid][vehicle_pos][0];
	Vehicle[car][vehicle_pos][1] = Vehicle[vehicleid][vehicle_pos][1];
	Vehicle[car][vehicle_pos][2] = Vehicle[vehicleid][vehicle_pos][2]; 
	Vehicle[car][vehicle_pos][3] = Vehicle[vehicleid][vehicle_pos][3];
	
	Vehicle[car][vehicle_fuel] = Vehicle[vehicleid][vehicle_fuel];
	Vehicle[car][vehicle_engine] = Vehicle[vehicleid][vehicle_engine];
	Vehicle[car][vehicle_health] = Vehicle[vehicleid][vehicle_health];
	Vehicle[car][vehicle_mile] = Vehicle[vehicleid][vehicle_mile];
	
	Vehicle[car][vehicle_luke] = Vehicle[vehicleid][vehicle_luke];
	Vehicle[car][vehicle_boat] = Vehicle[vehicleid][vehicle_boat];
	Vehicle[car][vehicle_arrest] = Vehicle[vehicleid][vehicle_arrest];
	
	Vehicle[car][vehicle_state_engine] = Vehicle[vehicleid][vehicle_state_engine];
	Vehicle[car][vehicle_engine_date] = Vehicle[vehicleid][vehicle_engine_date];
	
	Vehicle[car][vehicle_use_boot] = false;
	
	Vehicle[car][vehicle_state_hood] = 
	Vehicle[car][vehicle_state_boot] = 
	Vehicle[car][vehicle_state_engine] = 
	Vehicle[car][vehicle_state_light] = 
	Vehicle[car][vehicle_state_alarm] = 
	Vehicle[car][vehicle_state_obj] = 0;
	
	Vehicle[car][vehicle_luke_text] = Vehicle[vehicleid][vehicle_luke_text];
	Vehicle[car][vehicle_callsign] = Vehicle[vehicleid][vehicle_callsign];
	
	if( IsValidDynamic3DTextLabel( Vehicle[car][vehicle_luke_text] ) )
	{
		DestroyDynamic3DTextLabel( Vehicle[car][vehicle_luke_text] );
		Vehicle[car][vehicle_luke_text] = Text3D: INVALID_3DTEXT_ID;
	}
	
	if( IsValidDynamic3DTextLabel( Vehicle[car][vehicle_callsign] ) )
	{
		DestroyDynamic3DTextLabel( Vehicle[car][vehicle_callsign] );
		Vehicle[car][vehicle_callsign] = Text3D: INVALID_3DTEXT_ID;
	}
	
	
	for( new i; i < 12; i++ ) Vehicle[car][vehicle_tuning][i] = Vehicle[vehicleid][vehicle_tuning][i];
	for( new i; i < 3; i++ ) Vehicle[car][vehicle_water][i] = Vehicle[vehicleid][vehicle_water][i];
	for( new i; i < 6; i++ ) Vehicle[car][vehicle_siren][i] = Vehicle[vehicleid][vehicle_siren][i];
	for( new i; i < 4; i++ ) Vehicle[car][vehicle_damage][i] = Vehicle[vehicleid][vehicle_damage][i];
	
	for( new i; i < num_slots; i++ ) 
	{
		CarInv[car][i][inv_bd] = CarInv[vehicleid][i][inv_bd];
		CarInv[car][i][inv_id] = CarInv[vehicleid][i][inv_id];
		CarInv[car][i][inv_amount] = CarInv[vehicleid][i][inv_amount];
		CarInv[car][i][inv_type] = CarInv[vehicleid][i][inv_type]; 
		CarInv[car][i][inv_bone] = CarInv[vehicleid][i][inv_bone];
		CarInv[car][i][inv_param_1] = CarInv[vehicleid][i][inv_param_1];
		CarInv[car][i][inv_param_2] = CarInv[vehicleid][i][inv_param_2];
		CarInv[car][i][inv_active_type] = CarInv[vehicleid][i][inv_active_type];
		CarInv[car][i][inv_slot] = CarInv[vehicleid][i][inv_slot];
		
		CarInv[car][i][inv_pos_x] = CarInv[vehicleid][i][inv_pos_x];
		CarInv[car][i][inv_pos_y] = CarInv[vehicleid][i][inv_pos_y];
		CarInv[car][i][inv_pos_z] = CarInv[vehicleid][i][inv_pos_z];
		CarInv[car][i][inv_rot_x] = CarInv[vehicleid][i][inv_rot_x];
		CarInv[car][i][inv_rot_y] = CarInv[vehicleid][i][inv_rot_y];
		CarInv[car][i][inv_rot_z] = CarInv[vehicleid][i][inv_rot_z];
		CarInv[car][i][inv_scale_x] = CarInv[vehicleid][i][inv_scale_x];
		CarInv[car][i][inv_scale_y] = CarInv[vehicleid][i][inv_scale_y];
		CarInv[car][i][inv_scale_z] = CarInv[vehicleid][i][inv_scale_z];
	}
	
	if( Vehicle[car][vehicle_user_id] != INVALID_PARAM && playerid != INVALID_PLAYER_ID )
	{
		for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
		{
			if( Player[playerid][tVehicle][i] == vehicleid ) 
			{
				Player[playerid][tVehicle][i] = car;
				break;
			}
		}
		
		SetPVarInt( playerid, "Vehicle:Id", car );
	}	
	
	/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

	printf( "car = %d | vehicleid = %d", car, vehicleid );
	
	//ClearVehicleData( vehicleid, modelid );
	
	LinkVehicleToInterior( car, Vehicle[car][vehicle_int] );
	SetVehicleVirtualWorld( car, Vehicle[car][vehicle_world] );
	
	if( isnull( Vehicle[car][vehicle_number] ) )
	{
		SetVehicleNumberPlate( car, "W/O PLATES" );
	}
	else
	{
		format( number, sizeof number, "%s", Vehicle[car][vehicle_number] );
		SetVehicleNumberPlate( car, number );
	}
	
	for( new j; j < 12; j++ )
	{
		if( Vehicle[car][vehicle_tuning][j] && IsVehicleUpgradeCompatible( GetVehicleModel( car ), Vehicle[car][vehicle_tuning][j] ) )
		{
			AddVehicleComponent( car, Vehicle[car][vehicle_tuning][j] );
		}
	}
	
	if( Vehicle[car][vehicle_color][2] && IsVehiclePaintjobCompatible( GetVehicleModel( car ) ) )
	{
		ChangeVehiclePaintjob( car, Vehicle[car][vehicle_color][2] - 1 );
	}
	
	setVehicleHealth( car, Vehicle[car][vehicle_health] );
	
	UpdateVehicleDamageStatus( car,
		Vehicle[car][vehicle_damage][0],
		Vehicle[car][vehicle_damage][1],
		Vehicle[car][vehicle_damage][2],
		Vehicle[car][vehicle_damage][3]		
	);
	
	Vehicle[car][vehicle_state_window][0] = 
	Vehicle[car][vehicle_state_window][1] =
	Vehicle[car][vehicle_state_window][2] =
	Vehicle[car][vehicle_state_window][3] = 1;
	
	if( Vehicle[car][vehicle_arrest] )
		Vehicle[car][vehicle_state_door] = 1;

	SetVehicleParams( car );

	return 1;
}

stock ResetVehicleParams( vehicleid )
{
	Vehicle[vehicleid][vehicle_state_hood] = 
	Vehicle[vehicleid][vehicle_state_boot] = 
	Vehicle[vehicleid][vehicle_state_engine] = 
	Vehicle[vehicleid][vehicle_state_light] = 
	Vehicle[vehicleid][vehicle_state_alarm] = 
	Vehicle[vehicleid][vehicle_state_obj] = 0;
	
	Vehicle[vehicleid][vehicle_state_window][0] = 
	Vehicle[vehicleid][vehicle_state_window][1] =
	Vehicle[vehicleid][vehicle_state_window][2] =
	Vehicle[vehicleid][vehicle_state_window][3] = 1;

	SetVehicleParams( vehicleid );
}

function DestroyPremiumVehicle( vehicleid )
{
	if( !cache_get_row_count() )
	{
		printf( "[Log]: Vehicle ID: %s[%d] = vehicle_id[%d], has been deleted on server.", GetVehicleModelName( GetVehicleModel(vehicleid) ), vehicleid, Vehicle[vehicleid][vehicle_id] );
		DestroyVehicleEx( vehicleid );
		
		return 1;
	}
	
	new
		premcar;
		
	premcar = cache_get_field_content_int(0, "prem_car", mysql);
		
	if( !premcar )
	{
		printf( "[Log]: Vehicle ID: %s[%d] = vehicle_id[%d], has been deleted on server.", GetVehicleModelName( GetVehicleModel(vehicleid) ), vehicleid, Vehicle[vehicleid][vehicle_id] );
		DestroyVehicleEx( vehicleid );
	
		return 1;
	}
	
	mysql_format:g_string( "DELETE FROM `"DB_VEHICLES"` WHERE `vehicle_id` = %d LIMIT 1", Vehicle[vehicleid][vehicle_id] );
	mysql_tquery( mysql, g_string );
			
	mysql_format:g_string( "DELETE FROM `"DB_ITEMS"` WHERE `item_type_id` = %d AND `item_type` = 2", Vehicle[vehicleid][vehicle_id] );	
	mysql_tquery( mysql, g_string );
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE " #DB_USERS " SET uMoney = uMoney + %d WHERE uID = %d LIMIT 1",
		GetVehiclePrice( Vehicle[vehicleid][vehicle_model] ),
		Vehicle[vehicleid][vehicle_user_id]
	);
	mysql_tquery( mysql, g_string );
	
	printf( "[Log]: Vehicle (PREMIUM) ID: %s[%d] = vehicle_id[%d], has been deleted on server.", GetVehicleModelName( GetVehicleModel(vehicleid) ), vehicleid, Vehicle[vehicleid][vehicle_id] );
	DestroyVehicleEx( vehicleid );
	
	return 1;
}