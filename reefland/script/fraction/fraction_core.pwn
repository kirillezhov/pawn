Frac_OnGameModeInit()
{
	mysql_tquery( mysql, "SELECT * FROM " #DB_FRACTIONS " ORDER BY `f_id`", "LoadFractionData" );
	
	for( new i; i < MAX_FRACTIONS; i++ )
	{
		mysql_format:g_small_string( "SELECT * FROM " #DB_FRAC_INFO " ORDER BY `i_id`" );
		mysql_tquery( mysql, g_small_string, "LoadFractionInfo", "i", i );
		
		mysql_format:g_small_string( "SELECT * FROM " #DB_RANKS " WHERE `r_fracid` = %d ORDER BY `r_id`", i );
		mysql_tquery( mysql, g_small_string, "LoadFractionRanks", "i", i );
		
		mysql_format:g_small_string( "SELECT * FROM " #DB_USERS " WHERE `uMember` = %d", i + 1 );
		mysql_tquery( mysql, g_small_string, "LoadFractionMember", "i", i );
	}
	
	mysql_tquery( mysql, "SELECT * FROM " #DB_SAN " ", "LoadGlobalSan" );

	for( new i; i < 2; i++ )
		area_gov_repair[i] = CreateDynamicRectangle( zone_gov_repair[i][0], zone_gov_repair[i][1], zone_gov_repair[i][2], zone_gov_repair[i][3], 0, 0, INVALID_PARAM ); 
	
	CreateDynamicPickup( 1239, 23, PICKUP_NETWORK, -1 );
	CreateDynamic3DTextLabel( "Подача объявления", 0xFFFFFFFF, PICKUP_NETWORK, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	NETWORK_ZONE = CreateDynamicRectangle( 1658.7837, -1624.4113, 1647.5829, -1635.4731 );
		
	for( new i; i < sizeof FStock; i++ )
	{
		new
			actor;
	
		actor = CreateActor( FStock[i][s_skin], FStock[i][s_pos][0], FStock[i][s_pos][1], FStock[i][s_pos][2], FStock[i][s_pos][3] );
		SetActorVirtualWorld( actor, FStock[i][s_world] );
		
		switch( FStock[i][s_anim] )
		{
			//seat
			case 1:	ApplyActorAnimation( actor, "INT_HOUSE","LOU_In",4.0,0,0,1,1,0 );
			//lean 3
			case 2: ApplyActorAnimation( actor, "CAR_CHAT","car_talkm_loop",4.0,0,1,1,1,0 );
			//sit
			case 3: ApplyActorAnimation( actor, "PED","SEAT_down",4.0,0,0,1,1,0 );
			//lean 2
			case 4: ApplyActorAnimation( actor, "MISC","Plyrlean_loop",4.0,0,1,1,1,0 );
		}
	}
	
	return 1;
}

function Frac_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED( KEY_WALK ) )
	{
		if( Player[playerid][uRank] )
		{
			for( new i; i < sizeof FStock; i++ )
			{
				if( !IsPlayerInRangeOfPoint( playerid, 3.0, FStock[i][s_pos][0], FStock[i][s_pos][1], FStock[i][s_pos][2] ) || Player[playerid][uMember] != FStock[i][s_member] ) continue;
			
				showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
			
				break;
			}
		}
	}
	//Гаражи
	else if( PRESSED(KEY_CROUCH) && IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER && Player[playerid][uMember] )
	{
		for( new i; i < sizeof garage_info; i++ )
		{
			if( IsPlayerInRangeOfPoint( playerid, 7.0, garage_info[i][g_entry][0], garage_info[i][g_entry][1], garage_info[i][g_entry][2] ) )
			{
				new
					vehicleid = GetPlayerVehicleID( playerid );
					
				setVehiclePos( vehicleid, garage_info[i][g_pos_inside][0],  garage_info[i][g_pos_inside][1], garage_info[i][g_pos_inside][2] );
				SetVehicleZAngle( vehicleid, garage_info[i][g_pos_inside][3] );
				
				SetVehicleVirtualWorld( vehicleid, garage_info[i][g_world] );
				LinkVehicleToInterior( vehicleid, 1 );
				
				foreach(new j: Player)
				{
					if( !IsLogged(j) || !GetPlayerVehicleID( j ) ) continue;
				
					if( GetPlayerVehicleID( j ) == vehicleid )
					{
						SetPVarInt( j, "User:inInt", 1 );
						UpdateWeather( j );
					
						Player[j][tPos][0] = garage_info[i][g_pos_inside][0];
						Player[j][tPos][1] = garage_info[i][g_pos_inside][1];
						Player[j][tPos][2] = garage_info[i][g_pos_inside][2];
					
						SetPlayerVirtualWorld( j, garage_info[i][g_world] ),
						SetPlayerInterior( j, 1 );
					}
				}
			
				break;
			}
			else if( IsPlayerInRangeOfPoint( playerid, 7.0, garage_info[i][g_exit][0], garage_info[i][g_exit][1], garage_info[i][g_exit][2] ) && GetPlayerVirtualWorld( playerid ) == garage_info[i][g_world] )
			{
				new
					vehicleid = GetPlayerVehicleID( playerid );
					
				setVehiclePos( vehicleid, garage_info[i][g_pos_outside][0],  garage_info[i][g_pos_outside][1], garage_info[i][g_pos_outside][2] );
				SetVehicleZAngle( vehicleid, garage_info[i][g_pos_outside][3] );
				
				SetVehicleVirtualWorld( vehicleid, 0 );
				LinkVehicleToInterior( vehicleid, 0 );
				
				foreach(new j: Player)
				{
					if( !IsLogged(j) || !GetPlayerVehicleID( j ) ) continue;
				
					if( GetPlayerVehicleID( j ) == vehicleid )
					{
						DeletePVar( j, "User:inInt" );
						UpdateWeather( j );
					
						Player[j][tPos][0] = garage_info[i][g_pos_outside][0];
						Player[j][tPos][1] = garage_info[i][g_pos_outside][1];
						Player[j][tPos][2] = garage_info[i][g_pos_outside][2];
					
						SetPlayerVirtualWorld( j, 0 ),
						SetPlayerInterior( j, 0 );
					}
				}
			
				break;
			}
		}
	}
	
	else if( PRESSED( KEY_SECONDARY_ATTACK ) ) 
	{
		if( GetPVarInt( playerid, "Passenger:VehicleID" ) == INVALID_VEHICLE_ID
			&& !GetPVarInt( playerid, "Passenger:InVehicle" ) ) 
			return 1;
			
		PlayerExitAdditionalSeat( playerid );
	}

	return 1;
}

function LoadFractionData()
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return printf( "[Load]: Null fractions." );
	
	COUNT_FRACTIONS = 0x0;
		
	for( new i; i < rows; i++ )
	{
		Fraction[i][f_id] = cache_get_field_content_int( i, "f_id", mysql );
		Fraction[i][f_vehicles] = cache_get_field_content_int( i, "f_vehicles", mysql );
		Fraction[i][f_salary] = cache_get_field_content_int( i, "f_salary", mysql );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "f_name", g_small_string, mysql );
		strmid( Fraction[i][f_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "f_short_name", g_small_string, mysql );
		strmid( Fraction[i][f_short_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "f_leader", g_small_string, mysql );
		sscanf( g_small_string,"p<|>a<d>[3]", Fraction[i][f_leader] );
		
		if( Fraction[i][f_leader][0] )
		{
			clean:<g_small_string>;
			cache_get_field_content( i, "f_leadername_1", g_small_string, mysql );
			strmid( FNameLeader[Fraction[i][f_id] - 1][0], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
		
		if( Fraction[i][f_leader][1] )
		{
			clean:<g_small_string>;
			cache_get_field_content( i, "f_leadername_2", g_small_string, mysql );
			strmid( FNameLeader[Fraction[i][f_id] - 1][1], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
		
		if( Fraction[i][f_leader][2] )
		{
			clean:<g_small_string>;
			cache_get_field_content( i, "f_leadername_3", g_small_string, mysql );
			strmid( FNameLeader[Fraction[i][f_id] - 1][2], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
		
		clean:<g_small_string>;
		cache_get_field_content( i, "f_skin", g_small_string, mysql );
		sscanf( g_small_string, "p<|>a<d>[20]", Fraction[i][f_skin] );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "f_gun", g_small_string, mysql );
		sscanf( g_small_string, "p<|>a<d>[10]", Fraction[i][f_gun] );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "f_stock", g_small_string, mysql );
		sscanf( g_small_string, "p<|>a<d>[10]", Fraction[i][f_stock] );
		
		COUNT_FRACTIONS++;
	}
	
	return printf( "[Load]: Fractions loaded. All - %d", COUNT_FRACTIONS );
}

function LoadFractionMember( fraction )
{
	new 
		rows,
		fields,
		tmp;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		if( !FMember[fraction][i][m_id] )
		{
			tmp = cache_get_field_content_int( i, "uRank", mysql );
			FMember[fraction][i][m_lasttime] = cache_get_field_content_int( i, "uLastTime", mysql );
			FMember[fraction][i][m_id] = cache_get_field_content_int( i, "uID", mysql );
		
			clean:<g_small_string>;
			cache_get_field_content( i, "uName", g_small_string, mysql );
			strmid(  FMember[fraction][i][m_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			if( tmp )
			{
				for( new j; j < MAX_RANKS; j++ )
				{
					if( FRank[fraction][j][r_id] == tmp )
					{
						FMember[fraction][i][m_rank] = j + 1;
						break;
					}
				}
			}
			
			Fraction[fraction][f_members]++;
		}
	}
	
	return 1;
}

function LoadFractionRanks( fraction )
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		if( !FRank[fraction][i][r_id] )
		{
			FRank[fraction][i][r_id] = cache_get_field_content_int( i, "r_id", mysql );
			FRank[fraction][i][r_fracid] = cache_get_field_content_int( i, "r_fracid", mysql );
			FRank[fraction][i][r_salary] = cache_get_field_content_int( i, "r_salary", mysql );
			FRank[fraction][i][r_invite] = cache_get_field_content_int( i, "r_invite", mysql );
			FRank[fraction][i][r_uninvite] = cache_get_field_content_int( i, "r_uninvite", mysql );
			FRank[fraction][i][r_mechanic] = cache_get_field_content_int( i, "r_mechanic", mysql );
			FRank[fraction][i][r_medic] = cache_get_field_content_int( i, "r_medic", mysql );
			FRank[fraction][i][r_radio] = cache_get_field_content_int( i, "r_radio", mysql );
			FRank[fraction][i][r_info] = cache_get_field_content_int( i, "r_info", mysql );
			FRank[fraction][i][r_attach] = cache_get_field_content_int( i, "r_attach", mysql );
			FRank[fraction][i][r_object] = cache_get_field_content_int( i, "r_object", mysql );
			FRank[fraction][i][r_boot] = cache_get_field_content_int( i, "r_boot", mysql );
			FRank[fraction][i][r_spawnveh] = cache_get_field_content_int( i, "r_spawnveh", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_name", g_small_string, mysql );
			strmid( FRank[fraction][i][r_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_spawn", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<f>[4]", FRank[fraction][i][r_spawn] );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_world", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[2]", FRank[fraction][i][r_world] );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_vehicles", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[10]", FRank[fraction][i][r_vehicles] );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_gun", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[10]", FRank[fraction][i][r_gun] );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_skin", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[20]", FRank[fraction][i][r_skin] );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_add", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[10]", FRank[fraction][i][r_add] );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_stock", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[10]", FRank[fraction][i][r_stock] );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_stock", g_small_string, mysql );
			sscanf( g_small_string, "p<|>a<d>[10]", FRank[fraction][i][r_stock] );
			
			Fraction[fraction][f_ranks]++;
			
			if( Fraction[fraction][f_salary] - FRank[fraction][i][r_salary] >= 0 )
				Fraction[fraction][f_salary] -= FRank[fraction][i][r_salary];
		}
	}
	
	return 1;
}

function LoadFractionInfo( fraction )
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		if( !FInfo[fraction][i][i_id] )
		{
			FInfo[fraction][i][i_id] = cache_get_field_content_int( i, "i_id", mysql );
			FInfo[fraction][i][i_fracid] = cache_get_field_content_int( i, "i_fracid", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "i_name", g_small_string, mysql );
			strmid( FInfo[fraction][i][i_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "i_theme", g_small_string, mysql );
			strmid( FInfo[fraction][i][i_theme], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_string>;
			cache_get_field_content( i, "i_text", g_string, mysql );
			strmid( FInfo[fraction][i][i_text], g_string, 0, strlen( g_string ), sizeof g_string );
		}
	}
		
	return 1;
}

stock PlayerLeaderFraction( playerid, fraction )
{
	for( new i; i < 3; i++ )
	{
		if( Player[playerid][uLeader] == Fraction[fraction][f_id] && 
			Player[playerid][uID] == Fraction[fraction][f_leader][i] )
			return 1;
	}

	return 0;
}

stock CreateRank( rank, fraction )
{
	FRank[fraction][rank][r_fracid] = fraction;
	
	FRank[fraction][rank][r_spawn][0] = 
	FRank[fraction][rank][r_spawn][1] =
	FRank[fraction][rank][r_spawn][2] = 
	FRank[fraction][rank][r_spawn][3] = 0.0;
	
	FRank[fraction][rank][r_attach] =
	FRank[fraction][rank][r_radio] =
	FRank[fraction][rank][r_info] =
	FRank[fraction][rank][r_object] = 
	FRank[fraction][rank][r_mechanic] = 
	FRank[fraction][rank][r_medic] = 
	FRank[fraction][rank][r_salary] = 
	FRank[fraction][rank][r_invite] =
	FRank[fraction][rank][r_uninvite] = 0;
	
	for( new i; i < 10; i++ )
	{
		FRank[fraction][rank][r_gun][i] = 
		FRank[fraction][rank][r_add][i] = 
		FRank[fraction][rank][r_vehicles][i] = 0;
	}
	
	for( new i; i < 20; i++ )
		FRank[fraction][rank][r_skin][i] = 0;
		
	mysql_format:g_small_string( "INSERT INTO `"DB_RANKS"` \
		( `r_fracid`, `r_name` ) VALUES \
		( '%d', '%s' )",
		FRank[fraction][rank][r_fracid],
		FRank[fraction][rank][r_name]
	);
	mysql_tquery( mysql, g_small_string, "InsertRank", "dd", rank, fraction );
	
	return 1;
}

function InsertRank( rank, fraction )
{
	FRank[fraction][rank][r_id] = cache_insert_id();
	return 1;
}

function InsertFracInfo( fid, index )
{
	FInfo[fid][index][i_id] = cache_insert_id();
	return 1;
}

stock ShowFractionRanks( playerid, fid, dialogid, btn[] = "Назад" )
{
	clean:<g_big_string>;
	
	new
		count = 0;
	
	if( dialogid == d_fpanel + 2 ) 
		strcat( g_big_string, ""gbDialog"Добавить ранг" );
	else 
		strcat( g_big_string, ""gbDialog"Без ранга" );
	
	for( new i; i < MAX_RANKS; i++ )
	{
		if( FRank[fid][i][r_id] )
		{
			format:g_string( "\n"cBLUE"%d. "cWHITE"%s", count + 1, FRank[fid][i][r_name] );
			strcat( g_big_string, g_string );
						
			g_dialog_select[playerid][count] = i;
							
			count++;
		}
	}
	
	format:g_small_string( ""cBLUE"%s", Fraction[fid][f_name] );
	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_LIST, g_small_string, g_big_string, "Выбрать", btn );

	return 1;
}

stock ShowFractionVehicles( playerid, fid, rank )
{
	clean:<g_string>;
	new
		count;
	
	strcat( g_string, ""gbDialog"Добавить транспорт"cWHITE"" );
	
	for( new i; i < 10; i++ )
	{
		if( FRank[fid][rank][r_vehicles][i] )
		{
			format:g_small_string( "\n%s", GetVehicleModelName( FRank[fid][rank][r_vehicles][i] ) );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			count++;
		}
	}

	showPlayerDialog( playerid, d_fpanel + 7, DIALOG_STYLE_LIST, " ", g_string, "Далее", "Назад" );
	return 1;
}

stock ShowFractionSkins( playerid, fid, rank )
{
	clean:<g_string>;
	
	new
		count;
	
	strcat( g_string, ""cWHITE"Номер\t"cWHITE"Значение" );
	
	for( new i; i < 20; i++ )
	{
		if( Fraction[fid][f_skin][i] )
		{
			format:g_small_string( "\n"cWHITE"Скин %d\t"cBLUE"%s", Fraction[fid][f_skin][i], 
				!FRank[fid][rank][r_skin][i] ? ("Нет") : ("Да") );
			strcat( g_string, g_small_string );
			
			count++;
		}
	}
	
	if( !count )
	{
		SendClient:( playerid, C_WHITE, !""gbError"Список доступных скинов пуст." );
		ShowRankSettings( playerid, fid, rank );
		
		return 1;
	}

	showPlayerDialog( playerid, d_fpanel + 10, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Изменить", "Назад" );
	return 1;
}

stock ShowFractionStock( playerid, fid, rank )
{
	clean:<g_string>;
	
	new
		count,
		id;
	
	strcat( g_string, ""cWHITE"Предмет\t"cWHITE"Значение" );
	
	for( new i; i < 10; i++ )
	{
		if( Fraction[fid][f_stock][i] )
		{
			id = getInventoryId( Fraction[fid][f_stock][i] );
		
			format:g_small_string( "\n"cWHITE"%s\t"cBLUE"%s", inventory[id][i_name], 
				!FRank[fid][rank][r_stock][i] ? ("Нет") : ("Да") );
			strcat( g_string, g_small_string );
			
			count++;
		}
	}
	
	if( !count )
	{
		SendClient:( playerid, C_WHITE, !""gbError"Нет доступных предметов." );
		ShowRankSettings( playerid, fid, rank );
		
		return 1;
	}

	showPlayerDialog( playerid, d_fpanel + 12, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Изменить", "Назад" );
	return 1;
}

stock ShowFractionGun( playerid, fid, rank )
{
	clean:<g_string>;
	
	new
		count,
		id;
	
	strcat( g_string, ""cWHITE"Оружие\t"cWHITE"Значение" );
	
	for( new i; i < 10; i++ )
	{
		if( Fraction[fid][f_gun][i] )
		{
			id = getInventoryId( Fraction[fid][f_gun][i] );
		
			format:g_small_string( "\n"cWHITE"%s\t"cBLUE"%s", inventory[id][i_name], 
				!FRank[fid][rank][r_gun][i] ? ("Нет") : ("Да") );
			strcat( g_string, g_small_string );
			
			count++;
		}
	}
	
	if( !count )
	{
		SendClient:( playerid, C_WHITE, !""gbError"Нет доступного оружия." );
		ShowRankSettings( playerid, fid, rank );
		
		return 1;
	}

	showPlayerDialog( playerid, d_fpanel + 13, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Изменить", "Назад" );
	return 1;
}

stock ShowRankSettings( playerid, fid, rank )
{
	format:g_small_string( "Ранг "cBLUE"%s", FRank[fid][rank][r_name] );
	
	format:g_big_string( 
		fpanel_settings, 
		FRank[fid][rank][r_salary], 
		!FRank[fid][rank][r_invite] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_uninvite] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_info] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_radio] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_attach] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_object] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_boot] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_spawnveh] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_mechanic] ? ("Нет") : ("Да"),
		!FRank[fid][rank][r_medic] ? ("Нет") : ("Да") 
	);
				
	showPlayerDialog( playerid, d_fpanel + 4, DIALOG_STYLE_TABLIST_HEADERS, g_small_string, g_big_string, "Изменить", "Назад" );

	return 1;
}

stock UpdateRank( rankid, field[], const _: value )
{
	mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `%s` = %d WHERE `r_id` = %d",
		field,
		value,
		rankid
	);
	
	return mysql_tquery( mysql, g_string );
}

ClearDataRank( fid, rank )
{
	Fraction[fid][f_salary] += FRank[fid][rank][r_salary];

	FRank[fid][rank][r_id] =
	FRank[fid][rank][r_fracid] =
	FRank[fid][rank][r_salary] =
	FRank[fid][rank][r_invite] =
	FRank[fid][rank][r_uninvite] =
	FRank[fid][rank][r_info] =
	FRank[fid][rank][r_radio] =
	FRank[fid][rank][r_attach] =
	FRank[fid][rank][r_object] =
	FRank[fid][rank][r_boot] =
	FRank[fid][rank][r_spawnveh] =
	FRank[fid][rank][r_mechanic] =
	FRank[fid][rank][r_medic] = 0;

	for( new i; i < 10; i++ )
	{
		FRank[fid][rank][r_gun][i] = 
		FRank[fid][rank][r_add][i] = 
		FRank[fid][rank][r_stock][i] = 
		FRank[fid][rank][r_vehicles][i] = 0;
	}
	
	for( new i; i < 20; i++ ) FRank[fid][rank][r_skin][i] = 0;
	for( new i; i < 4; i++ ) FRank[fid][rank][r_spawn][i] = 0.0;
	for( new i; i < 2; i++ ) FRank[fid][rank][r_world][i] = 0;
	
	FRank[fid][rank][r_name][0] = EOS;
	
	return 1;
}

stock FractionVehicles( playerid, fid, page )
{
	clean:<g_big_string>;
					
	format:g_small_string( ""cWHITE"Транспорт "cBLUE"%s"cWHITE"\n", Fraction[fid][f_name] );
	strcat( g_big_string, g_small_string );

	switch( page )
	{
		case 1:
		{
			for( new i; i < 51; i++ )
			{
				if( FVehicle[fid][i][v_number][0] != EOS )
				{
					format:g_small_string( "\n"cBLUE"%s\t"cGRAY"%s[%d]", FVehicle[fid][i][v_number], GetVehicleModelName( GetVehicleModel( FVehicle[fid][i][v_id] ) ), FVehicle[fid][i][v_id] );
					strcat( g_big_string, g_small_string );
				}
			}
					
			if( FVehicle[fid][51][v_number][0] != EOS )
			{
				showPlayerDialog( playerid, d_fpanel + 18, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Далее", "Назад" );
			}
			else
			{
				showPlayerDialog( playerid, d_fpanel + 17, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );
			}
		}
		
		case 2:
		{
			for( new i = 51; i < 101; i++ )
			{
				if( FVehicle[fid][i][v_number][0] != EOS )
				{
					format:g_small_string( "\n"cBLUE"%s\t"cGRAY"%s[%d]", FVehicle[fid][i][v_number], GetVehicleModelName( GetVehicleModel( FVehicle[fid][i][v_id] ) ), FVehicle[fid][i][v_id] );
					strcat( g_big_string, g_small_string );
				}
			}
					
			if( FVehicle[fid][101][v_number][0] != EOS )
			{
				showPlayerDialog( playerid, d_fpanel + 20, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Далее", "Назад" );
			}
			else
			{
				showPlayerDialog( playerid, d_fpanel + 19, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );
			}
		}
		
		case 3:
		{
			for( new i = 101; i < MAX_FRACVEHICLES; i++ )
			{
				if( FVehicle[fid][i][v_number][0] != EOS )
				{
					format:g_small_string( "\n"cBLUE"%s\t"cGRAY"%s[%d]", FVehicle[fid][i][v_number], GetVehicleModelName( GetVehicleModel( FVehicle[fid][i][v_id] ) ), FVehicle[fid][i][v_id] );
					strcat( g_big_string, g_small_string );
				}
			}
					
			showPlayerDialog( playerid, d_fpanel + 21, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );
		}
	}

	return 1;
}

stock ShowFractionInfo( playerid, fid )
{
	clean:<g_string>;
	
	new
		count;
	
	strcat( g_string, ""gbDialog"Добавить новость" );
	
	for( new i; i < MAX_POSTS; i++ )
	{
		if( FInfo[fid][i][i_text][0] != EOS )
		{
			format:g_small_string( "\n"cWHITE"%d. "cBLUE"%s", count + 1, FInfo[fid][i][i_theme] );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			count++;
		}
	}

	showPlayerDialog( playerid, d_fpanel + 32, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
	
	return 1;
}

ShowFracVehicleInformation( playerid, model, dialogid = INVALID_DIALOG_ID, btn[], btn2[] )
{
	clean:<g_string>;
	
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
	
	if( dialogid == d_crime + 22 )
	{
		format:g_small_string( ""cRED"Вы заплатите %d %%: $%d"cWHITE"\n", PERCENT_FOR_VEHICLE, floatround( VehicleInfo[ model - 400 ][v_price] / 100 * PERCENT_FOR_VEHICLE ) );
		strcat( g_string, g_small_string );
	}
	
	format:g_small_string( "Количество сидячих мест: "cBLUE"%d"cWHITE"\n",
		VehicleInfo[model - 400][v_seat]
	);
	strcat( g_string, g_small_string );
	
	format:g_small_string( "Привод: "cBLUE"%s"cWHITE"\n",
		VehicleInfo[model - 400][v_driving]
	);
	strcat( g_string, g_small_string );
	
	if( GetVehicleBag( model ) != 0 )
	{
		format:g_small_string( "Вместимость багажника: "cBLUE"%d мест"cWHITE"\n",
			GetVehicleBag( model )
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
	
	format:g_small_string( "Сирена: "cBLUE"%s",
		!VehicleInfo[ model - 400 ][v_siren] ? ("Да") : ("Нет")
	);
	strcat( g_string, g_small_string );
	
	return showPlayerDialog( playerid, dialogid, DIALOG_STYLE_MSGBOX, " ", g_string, btn, btn2 );
}

stock getRankId( playerid, fraction )
{
	for( new i; i < Fraction[fraction][f_ranks]; i++ )
	{
		if( FRank[fraction][i][r_id] == Player[playerid][uRank] )
			return i;
	}

	return STATUS_ERROR;
}

SendEmergencyCall( playerid, type, call )
{
	new
		rank,
		fid;

	foreach(new i: Player)
	{
		if( !IsLogged( i ) || !Player[i][uRank] ) continue;
		
		switch( type )
		{
			case 0: if( Player[i][uMember] != FRACTION_POLICE && Player[i][uMember] != FRACTION_FBI && Player[i][uMember] != FRACTION_WOOD ) continue;
			
			case 1:	if( Player[i][uMember] != FRACTION_FIRE && Player[i][uMember] != FRACTION_HOSPITAL ) continue;

			case 2: if( Player[i][uMember] != FRACTION_POLICE && 
						Player[i][uMember] != FRACTION_FIRE && 
						Player[i][uMember] != FRACTION_HOSPITAL && 
						Player[i][uMember] != FRACTION_FBI && 
						Player[i][uMember] != FRACTION_WOOD )
						continue;
		}
	
		fid = Player[i][uMember] - 1;
		rank = getRankId( i, fid );
		
		if( !FRank[fid][rank][r_add][0] ) continue;
		
		SendClient:( i, C_BLUE, "===============911===============" );
		
		pformat:( "Входящий вызов #%s: %010s", CPolice[call][p_number], CPolice[call][p_descript] );
		psend:( i, C_BLUE );
		
		pformat:( "Звонок поступил от: %s[%d], тел. %d", GetCharacterName(playerid), playerid, GetPhoneNumber( playerid ) );
		psend:( i, C_BLUE );
		
		pformat:( "Район: %s", CPolice[call][p_zone] );
		psend:( i, C_BLUE );
		
		SendClient:( i, C_BLUE, "=================================" );
		
		PlayerPlaySound( i, 41603, 0, 0, 0 );
	}

	return 1;
}

ShowEmergencyCall( playerid, fraction )
{
	new
		count;
	
	clean:<g_string>;
	strcat( g_string, "\t"cWHITE"Номер вызова\t"cWHITE"Описание" );
	
	switch( fraction )
	{
		case FRACTION_POLICE, FRACTION_WOOD, FRACTION_FBI :
		{
			for( new i; i < MAX_POLICECALLS; i++ )
			{
				if( CPolice[i][p_time] && ( CPolice[i][p_type] == 0 || CPolice[i][p_type] == 2 ) )
				{
					format:g_small_string( "\n#%s\t%010s", CPolice[i][p_number], CPolice[i][p_descript] );
					strcat( g_string, g_small_string );
					
					g_dialog_select[playerid][count] = i;
					count++;
				}
			}
		}
		
		case FRACTION_FIRE, FRACTION_HOSPITAL:
		{
			for( new i; i < MAX_POLICECALLS; i++ )
			{
				if( CPolice[i][p_time] && ( CPolice[i][p_type] == 1 || CPolice[i][p_type] == 2 ) )
				{
					format:g_small_string( "\n#%s\t%010s", CPolice[i][p_number], CPolice[i][p_descript] );
					strcat( g_string, g_small_string );
					
					g_dialog_select[playerid][count] = i;
					count++;
				}
			}
		}
	}
	
	if( !count )
		return SendClient:( playerid, C_WHITE, ""gbError"В службе нет зарегистрированных экстренных вызовов." );
	
	showPlayerDialog( playerid, d_frac, DIALOG_STYLE_TABLIST_HEADERS, "Служба 911", g_string, "Подробнее", "Закрыть" );
	return 1;
}

SendEmergencyMessage( playerid, type, text[] )
{
	foreach(new i : Player)
	{
		if( !IsLogged( i ) || !Player[i][uRank] ) continue;
				
		if( Player[i][uMember] != FRACTION_POLICE && Player[i][uMember] != FRACTION_FIRE ) continue;
				
		if( !FRank[ Player[i][uMember] - 1 ][getRankId( i, Player[i][uMember] - 1 )][r_add][0] ) continue;
		
		if( !getItem( i, INV_SPECIAL, PARAM_RADIO ) ) continue;

		SendClient:( i, C_LIGHTBLUE, text );
		
		switch( type )
		{
			case 1: if( Player[i][uMember] == FRACTION_POLICE ) SetPlayerMarkerForPlayer( i, playerid, 0xF62222AA );
			case 2:	if( Player[i][uMember] == FRACTION_FIRE ) SetPlayerMarkerForPlayer( i, playerid, 0xF62222AA );
			case 3: if( Player[i][uMember] == FRACTION_POLICE || Player[i][uMember] == FRACTION_FIRE ) SetPlayerMarkerForPlayer( i, playerid, 0xF62222AA );
		}
	}
	
	return 1;
}


stock BackupClear( playerid )
{
	foreach(new i: Player)
	{
		if( !IsLogged(i) || !Player[i][uMember] || playerid == i ) continue;
		
		if( Player[i][uMember] == FRACTION_POLICE || Player[i][uMember] == FRACTION_FIRE ) 
			SetPlayerMarkerForPlayer(i, playerid, 0xFFFFFF00 );
	}
		
	DeletePVar( playerid, "Fraction:UseBK" );
	
	return 1;
}

InstallSpuToVehicle( vehicleid )
{
	switch( Vehicle[vehicleid][vehicle_member] )
	{
		case FRACTION_POLICE:
		{
			switch( Vehicle[vehicleid][vehicle_model] )
			{
				case 400:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.38400, 2.07500, -0.29690,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.37850, 2.07500, -0.20410,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.37850, 2.07500, -0.29690,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, -0.38400, 2.07500, -0.20410,   0.00000, 180.00000, 180.00000);
				}
				 
				case 402:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.52010, 2.51870, -0.28600,   6.00000, 180.00000, 189.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.52370, 2.52080, -0.28600,   6.00000, 180.00000, 171.00000);
				}
					
				case 405:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.31070, 2.19000, -0.11450,   14.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.31070, 2.19000, -0.01200,   14.00000, 180.00000, 180.00000);
		 
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.31000, 2.19000, -0.01200,   14.00000, 180.00000, 180.00000);
		 
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.31000, 2.19000, -0.11450,   14.00000, 180.00000, 180.00000);
				}
				 
				case 411:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.45300, 2.77850, -0.28130,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.45580, 2.77850, -0.28130,   0.00000, 180.00000, 180.00000);
				}
					
				case 413:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.55500, 2.45000, -0.17000,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.55500, 2.45000, -0.07430,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.53740, 2.45000, -0.17000,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.53740, 2.45000, -0.07430,   0.00000, 180.00000, 180.00000);
				}
					
				case 415:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid,  0.00000, 2.61000, -0.23000,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.00000, 0.15000, 0.44000,   0.00000, 0.00000, 180.00000);
				}
					
				case 420:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.00000, 2.39900, -0.01000,   0.00000, 0.00000, 180.00000);
				}
					
				case 422:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.00000, -0.28000, 0.41000,   0.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.62000, 2.12100, -0.01000,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.62000, 2.13200, -0.12000,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, -0.61500, 2.12100, -0.01000,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][4] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][4], vehicleid, -0.61500, 2.12100, -0.12000,   0.00000, 180.00000, 180.00000);
				}
				 
				case 423:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.58800, 2.20000, -0.29600,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.58800, 2.20000, -0.20130,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.58200, 2.20000, -0.29600,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.58200, 2.20000, -0.20130,   0.00000, 180.00000, 180.00000);
				}
				 
				case 424:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.00000, 0.15000, 0.75000,   0.00000, 0.00000, 180.00000);
				}
					
				case 426:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.00000, 2.39600, -0.05990,   5.00000, 0.00000, 180.00000);
				}
					
				case 429:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.51000, 2.26000, -0.28120,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.50600, 2.26000, -0.28120,   0.00000, 180.00000, 180.00000);
				}
					
				case 431:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 1.01000, 5.66100, 1.72000,   180.00000, 180.00000, 0.00000);
				}
				 
				case 438:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.90000, 2.56700, -0.26900,   180.00000, 270.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.80600, 2.56700, -0.26900,   180.00000, 270.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.89380, 2.56700, -0.26900,   180.00000, 90.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.79980, 2.56700, -0.26900,   180.00000, 90.00000, 0.00000);
				}
					
				case 439:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.65500, 2.08900, -0.11000,   180.00000, 0.00000, 12.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.65500, 2.08900, -0.20490,   180.00000, 0.00000, 12.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.63520, 2.08900, -0.20490,   180.00000, 0.00000, -12.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.63520, 2.08900, -0.11000,   180.00000, 0.00000, -12.00000);
				}
					
				case 442:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.53000, 2.60900, -0.25000,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.53000, 2.60900, -0.15500,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.53000, 2.60900, -0.15500,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.53000, 2.60900, -0.25000,   180.00000, 0.00000, 0.00000);
				}
				 
				case 445:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.00000, 0.30000, 0.68200,   180.00000, 180.00000, 0.00000);
				}
					
				case 477:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.55200, 2.67700, -0.41560,   150.00000, 0.00000, 7.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.55300, 2.67700, -0.41560,   150.00000, 0.00000, -7.00000);
				}
				 
				case 482:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.51000, 2.40500, -0.31600,   170.00000, 0.00000, 5.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.51400, 2.40500, -0.31600,   170.00000, 0.00000, -5.00000);
					
					printf("Vehicle[%d][vehicle_siren][0] = %d", vehicleid, Vehicle[vehicleid][vehicle_siren][0] );
					printf("Vehicle[%d][vehicle_siren][1] = %d", vehicleid, Vehicle[vehicleid][vehicle_siren][1] );
				}
				 
				case 489:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.70000, 2.44900, 0.00000,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.70000, 2.44900, 0.10075,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.70000, 2.44900, 0.10070,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.70000, 2.44900, 0.00000,   180.00000, 0.00000, 0.00000);
				}
				 
				case 492:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.00000, 0.39000, 0.73000,   180.00000, 0.00000, 0.00000);
				}
					
				case 505:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.70000, 2.44900, 0.00000,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.70000, 2.44900, 0.10075,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.70000, 2.44900, 0.10070,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.70000, 2.44900, 0.00000,   180.00000, 0.00000, 0.00000);
				}
		 
				case 525:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
				}
				 
				case 528:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.49000, 2.49100, -0.29498,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.49000, 2.49100, -0.21311,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.49200, 2.49100, -0.21310,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.49200, 2.49100, -0.29500,   180.00000, 0.00000, 0.00000);
				}
				 
				case 534:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.530, 0.490, 0.000, 0.000, 180.000);
				}
				 
				case 535:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.720, 0.660, 0.000, 0.000, 180.000);
				}
					
				case 541:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.350, 2.321, -0.240, 163.000, 0.000, 5.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.350, 2.329, -0.242, 163.000, 0.000, 0.000);
				}
					
				case 552:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(11702,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.820, 1.380, 0.000, 0.000, 0.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.000, 1.321, 0.039, 0.000, 0.000, 0.000);
				}
				 
				case 559:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.180, 0.580, 0.000, 0.000, 180.000);
				}
		 
				case 560:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.560, 0.640, 0.000, 0.000, 180.000);
				}
				 
				case 561:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.450, 0.630, 0.000, 0.000, 180.000);
				}
				 
				case 566:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.460, 0.680, 0.000, 0.000, 180.000);
				}
				 
				case 574:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.950, -0.150, 0.000, 0.000, 0.000);
				}
					
				case 579:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.67000, 2.33000, -0.01000,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.67000, 2.33000, 0.08806,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.70800, 2.33000, 0.08810,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.70800, 2.33000, -0.01000,   180.00000, 360.00000, 0.00000);
				}
		 
				case 600:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.64000, 2.60100, 0.01000,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.64000, 2.60100, -0.08439,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.65000, 2.60100, -0.08440,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.65000, 2.60100, 0.01000,   180.00000, 360.00000, 0.00000);
				}
		 
				default: return STATUS_ERROR;
			}
		}
		 
		case FRACTION_FIRE:
		{
			switch( Vehicle[vehicleid][vehicle_model] )
			{
				case 525:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
				}
		 
				case 417:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -1.951, 0.329, -2.110, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -1.951, 0.300, -2.130, 0.000, 0.000, 90.000);
				}
				 
				case 460: 
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.510, 0.360, -2.460, 0.000, 0.000, 90.000);
				}
				 
				case 472:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, -2.498, 0.870, 0.000, 0.000, 0.000);
				}
				 
				case 487:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.450, 0.430, -2.220, 0.000, 0.000, 90.000);
				}
				 
				case 497:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.450, 0.430, -2.220, 0.000, 0.000, 90.000);
				}
				 
				case 548:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.930, 1.251, -3.530, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.930, 1.301, -3.630, 0.000, 0.000, 90.000);
				}
				 
				case 553:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.470, 4.051, -3.100, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.470, 2.148, -3.140, 0.000, 0.000, 90.000);
				}
				 
				case 563:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.501, 0.000, -2.480, 0.000, 0.000, 90.000);
				}
				 
				case 577:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.490, 3.638, -0.709, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.490, 1.718, -0.740, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, -0.490, 0.000, 0.000, 0.000, 0.000, 0.000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, -0.490, -0.390, -0.759, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][4] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][4], vehicleid, -0.490, 5.673, -0.730, 0.000, 0.000, 90.000);
				}
				 
				case 592:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.470, -0.789, -2.750, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.470, -2.750, -2.750, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, -0.470, 1.240, -2.770, 0.000, 0.000, 90.000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, -0.470, 3.201, -2.810, 0.000, 0.000, 90.000);
				}
					
				case 593:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.480, 0.279, -2.440, 0.000, 0.000, 90.000);
				}
		 
				default: return STATUS_ERROR;
			}
		}
		 
		case FRACTION_CITYHALL:
		{
			switch( Vehicle[vehicleid][vehicle_model] )
			{
				case 525:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
				}
					
				case 489:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.70000, 2.44900, 0.00000,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.70000, 2.44900, 0.10075,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.70000, 2.44900, 0.10070,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.70000, 2.44900, 0.00000,   180.00000, 0.00000, 0.00000);
				}
		 
				case 507:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 2.692, -0.140, 0.000, 0.000, 180.000);
				}
				 
				case 560:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.560, 0.640, 0.000, 0.000, 180.000);
				}
				 
				case 574:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.930, -0.090, 0.000, 0.000, 0.000);
				}
				 
				case 579:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.67000, 2.33000, -0.01000,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.67000, 2.33000, 0.08806,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.70800, 2.33000, 0.08810,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.70800, 2.33000, -0.01000,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][4] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][4], vehicleid, -0.67000, 2.33000, 0.19705,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][5] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][5], vehicleid, 0.70800, 2.33000, 0.19700,   180.00000, 360.00000, 0.00000);
				}
		 
				default: return STATUS_ERROR;
			}
		}
		 
		case FRACTION_WOOD:
		{
			switch( Vehicle[vehicleid][vehicle_model] )
			{
				case 525:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
				}
					
				case 422:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.00000, -0.28000, 0.41000,   0.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.62000, 2.12100, -0.01000,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.62000, 2.13200, -0.12000,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, -0.61500, 2.12100, -0.01000,   0.00000, 180.00000, 180.00000);
		 
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][4], vehicleid, -0.61500, 2.12100, -0.12000,   0.00000, 180.00000, 180.00000);
				}
				 
				case 472:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, -2.498, 0.870, 0.000, 0.000, 0.000);
				}
		 
				case 489:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19620,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.000, 1.120, 0.000, 0.000, 0.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.70000, 2.44900, 0.18640,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, -0.70000, 2.44900, 0.18640,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, -0.70000, 2.44900, 0.09833,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][4] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][4], vehicleid, 0.70000, 2.44900, 0.09830,   180.00000, 360.00000, 0.00000);
				}
				 
				case 554:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19620,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.000, 1.069, 0.000, 360.000, 360.000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.53800, 2.59000, -0.09000,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.54000, 2.59000, -0.09000,   180.00000, 360.00000, 0.00000);
				}
				 
				case 579:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.67000, 2.33000, -0.01000,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.67000, 2.33000, 0.08806,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.70800, 2.33000, 0.08810,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.70800, 2.33000, -0.01000,   180.00000, 360.00000, 0.00000);
				}
		 
				default: return STATUS_ERROR;
			}
		}
		 
		case FRACTION_HOSPITAL:
		{
			switch( Vehicle[vehicleid][vehicle_model] )
			{
				case 525:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
				}
					
				case 482:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.51000, 2.40500, -0.31600,   170.00000, 0.00000, 5.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.51400, 2.40500, -0.31600,   170.00000, 0.00000, -5.00000);
				}
		 
				default: return STATUS_ERROR;
			}
		}
		 
		case FRACTION_FBI:
		{
			switch( Vehicle[vehicleid][vehicle_model] )
			{
				case 400:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.38400, 2.07500, -0.29690,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.37850, 2.07500, -0.20410,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.37850, 2.07500, -0.29690,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, -0.38400, 2.07500, -0.20410,   0.00000, 180.00000, 180.00000);
				}
				 
				case 423:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.58800, 2.20000, -0.29600,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.58800, 2.20000, -0.20130,   0.00000, 180.00000, 180.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.58200, 2.20000, -0.29600,   0.00000, 180.00000, 180.00000);
				}
			
				case 426:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.00000, 2.39600, -0.05990,   5.00000, 0.00000, 180.00000);
				}
			
				case 428:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.63860, 2.66100, -0.53000,   180.00000, 90.00000, 0.00000);
		 
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, 0.64140, 2.66100, -0.53000,   180.00000, -90.00000, 0.00000);
		 
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.64340, 2.65700, -0.41200,   180.00000, -90.00000, 0.00000);
		 
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, -0.64060, 2.65700, -0.41200,   180.00000, 90.00000, 0.00000);
				}
			
				case 490:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.68210, 2.95000, -0.11190,   180.00000, 0.00000, 0.00000);
		 
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.68210, 2.95000, -0.02600,   180.00000, 0.00000, 0.00000);
		 
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.68390, 2.95000, -0.11190,   180.00000, 0.00000, 0.00000);
		 
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.68390, 2.95000, -0.02600,   180.00000, 0.00000, 0.00000);
				}
		 
				case 507:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 2.692, -0.140, 0.000, 0.000, 180.000);
				}
		 
				case 525:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19803,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
				}
		 
				case 528:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.49000, 2.49100, -0.29498,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.49000, 2.49100, -0.21311,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.49200, 2.49100, -0.21310,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.49200, 2.49100, -0.29500,   180.00000, 0.00000, 0.00000);
				}
		 
				case 551:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.40870, 2.35000, -0.10150,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.40870, 2.35000, -0.00630,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.40530, 2.35000, -0.00630,   180.00000, 0.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.40530, 2.35000, -0.10150,   180.00000, 0.00000, 0.00000);
				}
		 
				case 560:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, 0.000, 0.560, 0.640, 0.000, 0.000, 180.000);
				}
					
				case 579:
				{
					Vehicle[vehicleid][vehicle_siren][0] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][0], vehicleid, -0.67000, 2.33000, -0.01000,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][1] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][1], vehicleid, -0.67000, 2.33000, 0.08806,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][2] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][2], vehicleid, 0.70800, 2.33000, 0.08810,   180.00000, 360.00000, 0.00000);
					
					Vehicle[vehicleid][vehicle_siren][3] = CreateDynamicObject(19797,0,0,0,0,0,0);
					AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_siren][3], vehicleid, 0.70800, 2.33000, -0.01000,   180.00000, 360.00000, 0.00000);
				}
		 
				default: return STATUS_ERROR;
			}
		}
	}

	return 1;
}

stock SendLeaderMessage( fraction, color, const message[] )
{
	foreach(new playerid : Player)
		if( IsLogged( playerid ) )
			if( PlayerLeaderFraction( playerid, fraction ) )
				SendClientMessage( playerid, color, message );

	return 1;
}

function Frac_OnPlayerEnterVehicle( playerid, vehicleid, ispassenger )
{
	if( ispassenger == 1 && GetAvailableSeat( vehicleid ) == INVALID_PARAM && GetVehicleAdditionalSeat( vehicleid ) )
	{
		if( Vehicle[vehicleid][vehicle_seat] >= GetVehicleAdditionalSeat( vehicleid ) )
			return 1;
			
		if( !Vehicle[vehicleid][vehicle_member] )
			return 1;
		
		SetPVarInt( playerid, "Passenger:VehicleID", vehicleid );
		SetPVarInt( playerid, "Passenger:InVehicle", 1 );
		
		togglePlayerSpectating( playerid, 1 );
		
		PlayerSpectateVehicle( playerid, vehicleid );
		
		Vehicle[vehicleid][vehicle_seat]++;
	}
	
	return 1;
}

GetVehicleAdditionalSeat( vehicleid )
{
	switch( GetVehicleModel( vehicleid ) )	
	{
		case 497 : return 15;
		case 563 : return 22;
		case 417 : return 29;
		case 548 : return 48;
		case 416, 552, 609 : return 8;
		case 427, 577, 544, 573, 418, 428, 407, 487 : return 10;
		case 495 : return 4;
		case 455 : return 12;
	}
	
	return 0;
}

PlayerExitAdditionalSeat( playerid )
{	
	new 
		Float: x,
		Float: y,
		Float: z,
		Float: angle,
		_: vehicleid = GetPVarInt( playerid, "Passenger:VehicleID" );
		
	GetSpawnInfo( playerid, x, y, z, angle );
	SetSpawnInfo( playerid, 264, setUseSkin( playerid, true ), x, y, z, angle, 0, 0, 0, 0, 0, 0 );
	
	SetPVarInt( playerid, "Passenger:VehicleID", INVALID_VEHICLE_ID );
	SetPVarInt( playerid, "Passenger:InVehicle", 0 );
	
	Vehicle[vehicleid][vehicle_seat]--;
	
	if( Vehicle[vehicleid][vehicle_seat] < 0 )
	{
		Vehicle[vehicleid][vehicle_seat] = 0;
	}
	
	togglePlayerSpectating( playerid, 0 );
}

function Frac_OnVehicleDeath( vehicleid )
{
	foreach( new playerid : Player)
	{
		if( GetPVarInt( playerid, "Passenger:VehicleID" ) == vehicleid && GetPVarInt( playerid, "Passenger:InVehicle" ) )
		{
			PlayerExitAdditionalSeat( playerid );
			setPlayerHealth( playerid, 0.0 );
			
			break;
		}
		else if( GetPVarInt( playerid, "Luke:VehicleID" ) )
		{
			PlayerExitHelicopterInt( playerid );
			setPlayerHealth( playerid, 0.0 );
			
			break;
		}
	}
}