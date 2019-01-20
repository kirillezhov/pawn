function Crime_OnGameModeInit() 
{
	mysql_tquery( mysql, "SELECT * FROM `"DB_CRIME_GUNDEALER"` ORDER BY `g_id`", "loadCrimeDealer" );
	mysql_tquery( mysql, "SELECT * FROM `"DB_CRIME"` ORDER BY `c_id`", "loadCrime" );
	
	return 1;
}

function loadCrime() 
{
	new 
		rows = cache_get_row_count(); 
	
	COUNT_CRIMES = 0x0;
	
    if( !rows )
		return 1;
		
	for( new cr; cr < rows; cr++ ) 
	{
		if( !CrimeFraction[ cr ][ c_id ] ) 
		{
			CrimeFraction[ cr ][ c_id ] = cache_get_field_content_int( cr, "c_id", mysql );
			CrimeFraction[ cr ][ c_type ] = cache_get_field_content_int( cr, "c_type", mysql );
			CrimeFraction[ cr ][ c_vehicles ] = cache_get_field_content_int( cr, "c_vehicles", mysql );
			CrimeFraction[ cr ][ c_type_weapon ] = cache_get_field_content_int( cr, "c_type_weapon", mysql );
			CrimeFraction[ cr ][ c_time ] = cache_get_field_content_int( cr, "c_time", mysql );
			CrimeFraction[ cr ][ c_time_dealer ] = cache_get_field_content_int( cr, "c_time_dealer", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( cr, "c_name", g_small_string, mysql );
			strmid( CrimeFraction[ cr ][c_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_small_string>;
			cache_get_field_content( cr, "c_leader", g_small_string, mysql );
			sscanf( g_small_string,"p<|>a<d>[3]", CrimeFraction[ cr ][c_leader] );
			
			CrimeFraction[ cr ][ c_type_vehicles ] = cache_get_field_content_int( cr, "c_type_vehicles", mysql );
			
			if( CrimeFraction[ cr ][c_leader][0] )
			{
				clean:<g_small_string>;
				cache_get_field_content( cr, "c_leadername_1", g_small_string, mysql );
				strmid( CNameLeader[ CrimeFraction[ cr ][ c_id ] - 1 ][0], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			}
			
			if( CrimeFraction[ cr ][c_leader][1] )
			{
				clean:<g_small_string>;
				cache_get_field_content( cr, "c_leadername_2", g_small_string, mysql );
				strmid( CNameLeader[ CrimeFraction[ cr ][ c_id ] - 1 ][1], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			}
			
			if( CrimeFraction[ cr ][c_leader][2] )
			{
				clean:<g_small_string>;
				cache_get_field_content( cr, "c_leadername_3", g_small_string, mysql );
				strmid( CNameLeader[ CrimeFraction[ cr ][ c_id ] - 1 ][2], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			}
			
			mysql_format:g_small_string( "SELECT * FROM " #DB_CRIME_RANKS " WHERE `r_fracid` = %d", CrimeFraction[ cr ][ c_id ] );
			mysql_tquery( mysql, g_small_string, "loadCrimeRank", "i", cr );
			
			mysql_format:g_small_string( "SELECT * FROM " #DB_USERS " WHERE `uCrimeM` = %d", CrimeFraction[ cr ][ c_id ] );
			mysql_tquery( mysql, g_small_string, "loadCrimeMember", "i", cr );
			
			CrimeFraction[ cr ][ c_index_dealer ] = INVALID_PARAM;
			if( CrimeFraction[ cr ][ c_time_dealer ] )
			{
				for( new i; i < COUNT_GUNDEALERS; i++ )
				{
					if( GunDealer[i][g_fracid] && GunDealer[i][g_fracid] == CrimeFraction[ cr ][ c_id ] )
					{
						CrimeFraction[ cr ][ c_index_dealer ] = i;
						break;
					}
				}
			}
			
			COUNT_CRIMES++;
		}
	}
	
	printf( "[Load]: Criminal Structures loaded. All - %d", COUNT_CRIMES );
	
	return 1;
}

function loadCrimeDealer()
{
	new 
		rows = cache_get_row_count(); 
	
    if( !rows )
		return 1;
		
	COUNT_GUNDEALERS = 0x0;
	
	for( new i; i < rows; i++ ) 
	{
		if( !GunDealer[ i ][ g_id ] ) 
		{
			GunDealer[ i ][ g_id ] = cache_get_field_content_int( i, "g_id", mysql );
			GunDealer[ i ][ g_actor ] = cache_get_field_content_int( i, "g_actor", mysql );
			GunDealer[ i ][ g_car ] = cache_get_field_content_int( i, "g_car", mysql );
			GunDealer[ i ][ g_time ] = cache_get_field_content_int( i, "g_time", mysql );
			GunDealer[ i ][ g_fracid ] = cache_get_field_content_int( i, "g_fracid", mysql );

			clean:<g_small_string>;
			cache_get_field_content( i, "g_actor_pos", g_small_string, mysql );
			sscanf( g_small_string,"p<|>a<f>[4]", GunDealer[ i ][g_actor_pos] );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "g_car_pos", g_small_string, mysql );
			sscanf( g_small_string,"p<|>a<f>[4]", GunDealer[ i ][g_car_pos] );
			//Если точка активная - создаем ее
			if( GunDealer[ i ][ g_fracid ] ) 
			{
				if( GunDealer[ i ][ g_time ] ) CreateCrimePoint( i );
				
				for( new j; j < 2; j++ )
				{
					mysql_format:g_small_string( "SELECT * FROM " #DB_CRIME_ORDER " WHERE `point_id` = %d AND `point_type`", GunDealer[ i ][ g_id ], j + 1 );
					mysql_tquery( mysql, g_small_string, "loadCrimeOrder", "ii", i, j );
				}
			}

			COUNT_GUNDEALERS ++;
		}
	}
	
	return 1;
}

function loadCrimeOrder( point, type )
{
	new 
		rows = cache_get_row_count(); 
	
    if( !rows )
		return 1;
		
	for( new i; i < rows; i++ ) 
	{
		clean:<g_small_string>;
		cache_get_field_content( i, "point_gunid", g_small_string, mysql );
		sscanf( g_small_string,"p<|>a<d>[10]", DealerOrder[ point ][type][gun_id] );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "point_amount", g_small_string, mysql );
		sscanf( g_small_string,"p<|>a<d>[10]", DealerOrder[ point ][type][gun_amount] );
	}
	
	return 1;
}

function loadCrimeRank( crime ) 
{
	new 
		rows = cache_get_row_count();
    
	if( !rows )
		return 1;
	
	if( rows ) 
	{
		for( new cr; cr < rows; cr++ ) 
		{
			if( !CrimeRank[crime][cr][r_id] ) 
			{
				CrimeRank[crime][cr][r_id] = cache_get_field_content_int( cr, "r_id", mysql );
				CrimeRank[crime][cr][r_fracid] = cache_get_field_content_int( cr, "r_fracid", mysql );
				CrimeRank[crime][cr][r_invite] = cache_get_field_content_int( cr, "r_invite", mysql );
				CrimeRank[crime][cr][r_uninvite] = cache_get_field_content_int( cr, "r_uninvite", mysql );
				CrimeRank[crime][cr][r_attach] = cache_get_field_content_int( cr, "r_attach", mysql );
				CrimeRank[crime][cr][r_spawnveh] = cache_get_field_content_int( cr, "r_spawnveh", mysql );
				CrimeRank[crime][cr][r_call_weapon] = cache_get_field_content_int( cr, "r_call_weapon", mysql );
				
				clean:<g_small_string>;
				cache_get_field_content( cr, "r_name", g_small_string, mysql );
				strmid( CrimeRank[crime][cr][r_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
				
				clean:<g_small_string>;
				cache_get_field_content( cr, "r_spawn", g_small_string, mysql );
				sscanf( g_small_string, "p<|>a<f>[4]", CrimeRank[crime][cr][r_spawn] );
				
				clean:<g_small_string>;
				cache_get_field_content( cr, "r_world", g_small_string, mysql );
				sscanf( g_small_string, "p<|>a<d>[2]", CrimeRank[crime][cr][r_world] );
				
				clean:<g_small_string>;
				cache_get_field_content( cr, "r_vehicles", g_small_string, mysql );
				sscanf( g_small_string, "p<|>a<d>[10]", CrimeRank[crime][cr][r_vehicles] );
				
				CrimeFraction[crime][c_ranks]++;
			}
		}	
	}
	
	return 1;
}

function loadCrimeMember( crime )
{
	new 
		rows = cache_get_row_count(),
		tmp;
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		if( !CMember[crime][i][m_id] )
		{
			tmp = cache_get_field_content_int( i, "uCrimeRank", mysql );
			CMember[crime][i][m_lasttime] = cache_get_field_content_int( i, "uLastTime", mysql );
			CMember[crime][i][m_id] = cache_get_field_content_int( i, "uID", mysql );
		
			clean:<g_small_string>;
			cache_get_field_content( i, "uName", g_small_string, mysql );
			strmid(  CMember[crime][i][m_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			if( tmp )
			{
				for( new j; j < MAX_RANKS; j++ )
				{
					if( CrimeRank[crime][j][r_id] == tmp )
					{
						CMember[crime][i][m_rank] = j + 1;
						break;
					}
				}
			}
			
			CrimeFraction[crime][c_members]++;
		}
	}
	
	return 1;
}

function InsertCrimeFraction( playerid, crime )
{
	CrimeFraction[crime][c_id] = cache_insert_id();
	
	pformat:( ""gbSuccess"Вы успешно добавили "cBLUE"New Crime Fraction #%d"cWHITE".", CrimeFraction[crime][c_id] );
	psend:( playerid, C_WHITE );

	return 1;
}

ShowCrimeMembers( playerid, dialogid, btn[], btn2[] )
{
	new
		crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
		year, month, day,
		rank;
			
	clean:<g_big_string>;
				
	format:g_small_string( ""cWHITE"Состав криминальной структуры\n"cBLUE"%s", CrimeFraction[crime][c_name] );
	strcat( g_big_string, g_small_string );
						
	strcat( g_big_string, "\n\n"cWHITE"Онлайн:\n"cBLUE"" );
						
	foreach(new i: Player)
	{
		if( !IsLogged(i) ) continue;
							
		if( Player[i][uCrimeM] == CrimeFraction[crime][c_id] )
		{
			rank = getCrimeRankId( i, crime );
							
			if( Player[i][uCrimeRank] ) format:g_small_string( "%s", CrimeRank[crime][rank][r_name] );
								
			format:g_string( "%s[%d] - %s\n", Player[i][uName], i, 
				!Player[i][uCrimeRank] ? ("Нет ранга") : g_small_string );
									
			strcat( g_big_string, g_string );
		}
	}
						
	strcat( g_big_string, "\n\n"cGRAY"" );
						
	for( new i; i < MAX_MEMBERS; i++ )
	{
		if( CMember[crime][i][m_id] )
		{
			year = month = day = 0;
			gmtime( CMember[crime][i][m_lasttime], year, month, day );
						
			if( CMember[crime][i][m_rank] ) format:g_small_string( "%s", CrimeRank[crime][ CMember[crime][i][m_rank] - 1 ][r_name] );
								
			format:g_string( "%s[ac. %d] - %s - %02d.%02d.%d\n", CMember[crime][i][m_name], CMember[crime][i][m_id],
				!CMember[crime][i][m_rank] ? ("Нет ранга") : g_small_string,
				day, month, year );
									
			strcat( g_big_string, g_string );
		}
	}
						
	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_MSGBOX, " ", g_big_string, btn, btn2 );

	return 1;
}

stock ShowCrimeRanks( playerid, crime, dialogid, btn[] = "Назад" )
{
	clean:<g_big_string>;
	
	new
		count = 0;
	
	if( dialogid == d_crime + 2 ) strcat( g_big_string, ""gbDialog"Добавить ранг" );
	else strcat( g_big_string, ""gbDialog"Без ранга" );
	
	for( new i; i < MAX_RANKS; i++ )
	{
		if( CrimeRank[crime][i][r_id] )
		{
			format:g_small_string( "\n"cBLUE"%i. "cWHITE"%s", i + 1, CrimeRank[crime][i][r_name] );
			strcat( g_big_string, g_small_string );
						
			g_dialog_select[playerid][count] = i;
							
			count++;
		}
	}
	
	format:g_small_string( ""cBLUE"%s", CrimeFraction[crime][c_name] );
	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_LIST, g_small_string, g_big_string, "Выбрать", btn );

	return 1;
}

stock CreateCrimeRank( rank, crime )
{
	CrimeRank[crime][rank][r_fracid] = CrimeFraction[crime][c_id];
	
	CrimeRank[crime][rank][r_spawn][0] = 
	CrimeRank[crime][rank][r_spawn][1] =
	CrimeRank[crime][rank][r_spawn][2] = 
	CrimeRank[crime][rank][r_spawn][3] = 0.0;
	
	CrimeRank[crime][rank][r_attach] =
	CrimeRank[crime][rank][r_invite] =
	CrimeRank[crime][rank][r_uninvite] = 0;
	
	for( new i; i < 10; i++ )
	{
		CrimeRank[crime][rank][r_vehicles][i] = 0;
	}
		
	mysql_format:g_small_string( "INSERT INTO `"DB_CRIME_RANKS"` \
		( `r_fracid`, `r_name` ) VALUES \
		( '%d', '%e' )",
		CrimeRank[crime][rank][r_fracid],
		CrimeRank[crime][rank][r_name]
	);
	mysql_tquery( mysql, g_small_string, "InsertCrimeRank", "dd", rank, crime );
	
	return 1;
}

function InsertCrimeRank( rank, crime )
{
	CrimeRank[crime][rank][r_id] = cache_insert_id();
	return 1;
}

stock ShowCrimeRankSettings( playerid, crime, rank )
{
	format:g_small_string( "Ранг "cBLUE"%s", CrimeRank[crime][rank][r_name] );
	
	format:g_big_string( 
		mpanel_settings, 
		!CrimeRank[crime][rank][r_invite] ? ("Нет") : ("Да"),
		!CrimeRank[crime][rank][r_uninvite] ? ("Нет") : ("Да"),
		!CrimeRank[crime][rank][r_attach] ? ("Нет") : ("Да"),
		!CrimeRank[crime][rank][r_spawnveh] ? ("Нет") : ("Да"),
		!CrimeRank[crime][rank][r_call_weapon] ? ("Нет") : ("Да")
	);
				
	showPlayerDialog( playerid, d_crime + 4, DIALOG_STYLE_TABLIST_HEADERS, g_small_string, g_big_string, "Изменить", "Назад" );

	return 1;
}

stock UpdateCrimeRank( rankid, field[], const _: value )
{
	mysql_format:g_small_string( "UPDATE `"DB_CRIME_RANKS"` SET `%s` = %d WHERE `r_id` = %d",
		field,
		value,
		rankid
	);
	
	return mysql_tquery( mysql, g_small_string );
}

stock ShowCrimeVehicles( playerid, crime, rank )
{
	clean:<g_string>;
	new
		count;
	
	strcat( g_string, ""gbDialog"Добавить транспорт"cWHITE"" );
	
	for( new i; i < 10; i++ )
	{
		if( CrimeRank[crime][rank][r_vehicles][i] )
		{
			format:g_small_string( "\n%s", GetVehicleModelName( CrimeRank[crime][rank][r_vehicles][i] ) );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			count++;
		}
	}

	showPlayerDialog( playerid, d_crime + 6, DIALOG_STYLE_LIST, " ", g_string, "Далее", "Назад" );
	return 1;
}

stock ClearDataCrimeRank( crime, rank )
{
	CrimeRank[crime][rank][r_id] =
	CrimeRank[crime][rank][r_fracid] =
	CrimeRank[crime][rank][r_invite] =
	CrimeRank[crime][rank][r_uninvite] =
	CrimeRank[crime][rank][r_attach] =
	CrimeRank[crime][rank][r_spawnveh] =
	CrimeRank[crime][rank][r_call_weapon] = 0;

	for( new i; i < 10; i++ )
	{
		CrimeRank[crime][rank][r_vehicles][i] = 0;
	}
	
	for( new i; i < 4; i++ ) CrimeRank[crime][rank][r_spawn][i] = 0.0;
	for( new i; i < 2; i++ ) CrimeRank[crime][rank][r_world][i] = 0;
	
	CrimeRank[crime][rank][r_name][0] = EOS;
	
	return 1;
}

stock CrimeVehicles( playerid, crime )
{
	clean:<g_string>;
					
	format:g_small_string( ""cWHITE"Транспорт "cBLUE"%s"cWHITE"\n", CrimeFraction[crime][c_name] );
	strcat( g_string, g_small_string );
	
	for( new i; i < MAX_FRACVEHICLES; i++ )
	{
		if( CVehicle[crime][i][v_number][0] != EOS )
		{
			format:g_small_string( "\n"cBLUE"%s\t"cGRAY"%s[%d]", CVehicle[crime][i][v_number], GetVehicleModelName( GetVehicleModel( CVehicle[crime][i][v_id] ) ), CVehicle[crime][i][v_id] );
			strcat( g_string, g_small_string );
		}
	}
	
	showPlayerDialog( playerid, d_crime + 19, DIALOG_STYLE_MSGBOX, " ", g_string, "Назад", "" );
	
	return 1;
}

CreateCrimePoint( point )
{
	GunDealer[point][g_actor_id] = CreateActor( GunDealer[point][g_actor], 
		GunDealer[point][g_actor_pos][0],
		GunDealer[point][g_actor_pos][1],
		GunDealer[point][g_actor_pos][2],
		GunDealer[point][g_actor_pos][3] );
		
	ApplyActorAnimation( GunDealer[point][g_actor_id], "DEALER","DEALER_IDLE", 3.0,0,1,1,1,0 );
		
	GunDealer[point][g_text] = CreateDynamic3DTextLabel( "Действие '"cBLUE"H"cWHITE"'", C_WHITE, 
		GunDealer[point][g_actor_pos][0], 
		GunDealer[point][g_actor_pos][1], 
		GunDealer[point][g_actor_pos][2],
		2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
		
	if( GunDealer[point][g_car] )
	{
		GunDealer[point][g_car_id] = CreateVehicle( GunDealer[point][g_car], 
			GunDealer[point][g_car_pos][0], 
			GunDealer[point][g_car_pos][1], 
			GunDealer[point][g_car_pos][2], 
			GunDealer[point][g_car_pos][3], 
			random(255), random(255), INVALID_PARAM );
	}

	return 1;
}

DestroyCrimePoint( point )
{
	DestroyActor( GunDealer[point][g_actor_id] );

	if( IsValidDynamic3DTextLabel( GunDealer[point][g_text] ) )
		DestroyDynamic3DTextLabel( GunDealer[point][g_text] );

	if( GunDealer[point][g_car] )
	{
		printf( "[Log]: Destroy GunDealer vehicle ID: %s[%d] = point #%d.", GetVehicleModelName( GetVehicleModel(GunDealer[point][g_car_id]) ), GunDealer[point][g_car_id], point );
		DestroyVehicle( GunDealer[point][g_car_id] );
	}
	
	GunDealer[point][g_text] = Text3D: INVALID_3DTEXT_ID;
	
	GunDealer[point][g_fracid] = 
	GunDealer[point][g_car_id] = 
	GunDealer[point][g_actor_id] = 
	GunDealer[point][g_time] = 0;
	
	for( new i; i < 2; i++ )
	{
		for( new j; j < 10; j++ )
		{
			DealerOrder[point][i][gun_id][j] =
			DealerOrder[point][i][gun_amount][j] = 0;
		}
	}
	
	mysql_format:g_small_string( "DELETE FROM `"DB_CRIME_ORDER"` WHERE `point_id` = %d", GunDealer[point][g_id] );
	mysql_tquery( mysql, g_small_string );
	
	return 1;
}

function insertGunDealer( playerid, point )
{
	GunDealer[point][g_id] = cache_insert_id();
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] добавил точку гандилера ID %d: скин %d",
		Player[playerid][uName],
		playerid,
		GunDealer[point][g_id], GunDealer[point][g_actor] );
		
	SendAdmin:( C_DARKGRAY, g_small_string );
	
	COUNT_GUNDEALERS ++;

	return 1;
}

stock ShowWeaponsCrime( playerid, type, crime )
{
	clean:<g_string>;
	
	new
		id;
	
	strcat( g_string, ""cWHITE"Наименование\t"cWHITE"Количество" );

	switch( CrimeFraction[crime][c_type_weapon] )
	{
		case 1:
		{
			for( new i; i < 10; i++ )
			{
				if( weapons_info[type][i][gun_type] < 2 && weapons_info[type][i][gun_id] )
				{
					id = getInventoryId( weapons_info[type][i][gun_id] );
					
					format:g_small_string( "\n"cWHITE"%s\t"cBLUE"%d", inventory[id][i_name], CrimeOrder[crime][type][gun_amount][i] );
					strcat( g_string, g_small_string );
				}
			}
		}
				
		case 2:
		{
			for( new i; i < 10; i++ )
			{
				if( weapons_info[type][i][gun_type] < 3 && weapons_info[type][i][gun_id] )
				{
					id = getInventoryId( weapons_info[type][i][gun_id] );
							
					format:g_small_string( "\n"cWHITE"%s\t"cBLUE"%d", inventory[id][i_name], CrimeOrder[crime][type][gun_amount][i] );
					strcat( g_string, g_small_string );
				}
			}
		}
		
		case 3:
		{
			for( new i; i < 10; i++ )
			{
				if( weapons_info[type][i][gun_id] )
				{
					id = getInventoryId( weapons_info[type][i][gun_id] );
							
					format:g_small_string( "\n"cWHITE"%s\t"cBLUE"%d", inventory[id][i_name], CrimeOrder[crime][type][gun_amount][i] );
					strcat( g_string, g_small_string );
				}
			}
		}
	}
	
	SetPVarInt( playerid, "GunDealer:Type", type );
	showPlayerDialog( playerid, d_crime + 35, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Выбрать", "Назад" );
	
	return 1;
}

ShowWeaponsOrder( playerid, type, order )
{
	clean:<g_string>;
	
	new
		id,
		count;
	
	strcat( g_string, ""cWHITE"Наименование\t"cWHITE"Количество" );
		
	for( new i; i < 10; i++ )
	{
		if( DealerOrder[order][type][gun_id][i] )
		{
			id = getInventoryId( DealerOrder[order][type][gun_id][i] );
			
			format:g_small_string( "\n"cWHITE"%s\t"cBLUE"%d", inventory[id][i_name], DealerOrder[order][type][gun_amount][i] );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			
			count++;
		}
	}

	if( !count )
	{
		SendClient:( playerid, C_WHITE, !""gbDefault"Заказ полностью разобран." );
	
		DeletePVar( playerid, "Crime:Type" );
		return showPlayerDialog( playerid, d_crime + 39, DIALOG_STYLE_LIST, "Гандилер", "\
			"cBLUE"1."cWHITE" Оружие\n\
			"cBLUE"2."cWHITE" Патроны", "Выбрать", "Закрыть" );
	}
	
	return showPlayerDialog( playerid, d_crime + 40, DIALOG_STYLE_TABLIST_HEADERS, "Гандилер", g_string, "Далее", "Назад" );
}

ShowAmountOrder( playerid, type, order, index )
{
	clean:<g_string>;
	
	new
		id = getInventoryId( DealerOrder[order][type][gun_id][index] );
	
	strcat( g_string, ""cWHITE"Оружие\t"cWHITE"Стоимость" );
	
	for( new i; i < DealerOrder[order][type][gun_amount][index]; i++ )
	{
		format:g_small_string( "\n"cWHITE"%s\t"cBLUE"$%d", inventory[id][i_name], weapons_info[type][index][gun_price] );
		strcat( g_string, g_small_string );
	}
	
	showPlayerDialog( playerid, d_crime + 41, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Забрать", "Назад" );
	
	return 1;
}

SendCrimeMessage( crime, color, text[] )
{
	foreach(new i: Player)
	{
		if( !IsLogged(i) ) continue;
		
		if( Player[i][uCrimeM] == CrimeFraction[crime][c_id] ) SendClient:( i, color, text );
	}

	return 1;
}

CrimeTimer()
{
	for( new i; i < COUNT_CRIMES; i++ )
	{
		if(  CrimeFraction[i][c_time_dealer] && CrimeFraction[i][c_time_dealer] < gettime() )
		{
			new
				dealer = CrimeFraction[i][c_index_dealer];
		
			CreateCrimePoint( dealer );
			GunDealer[ dealer ][g_time] = gettime() + 30 * 60;
			
			format:g_small_string( ""FRACTION_PREFIX" Дилер прибыл на место и будет ожидать 30 минут: район %s.", GunDealer[ dealer ][g_zone] );
			SendCrimeMessage( i, C_DARKGRAY, g_small_string );
			
			CrimeFraction[i][c_time_dealer] = 0;
			
			mysql_format:g_small_string( "UPDATE `"DB_CRIME"` SET `c_time_dealer` = 0 WHERE `c_id` = %d LIMIT 1",
				CrimeFraction[i][c_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_small_string( "UPDATE `"DB_CRIME_GUNDEALER"` SET `g_time` = %d WHERE `g_id` = %d LIMIT 1",
				GunDealer[ dealer ][g_time], GunDealer[ dealer ][g_id] );
			mysql_tquery( mysql, g_small_string );
		}
		else if( CrimeFraction[i][c_time] && CrimeFraction[i][c_time] < gettime() )
		{
			CrimeFraction[i][c_time] = 0;
			
			mysql_format:g_small_string( "UPDATE `"DB_CRIME"` SET `c_time` = 0 WHERE `c_id` = %d LIMIT 1",
				CrimeFraction[i][c_id] );
			mysql_tquery( mysql, g_small_string );
		}
	}
	
	for( new i; i < COUNT_GUNDEALERS; i++ )
	{
		if( GunDealer[i][g_time] && GunDealer[i][g_time] < gettime() )
		{
			DestroyCrimePoint( i );
			
			mysql_format:g_small_string( "UPDATE `"DB_CRIME_GUNDEALER"` SET `g_time` = 0, `g_fracid` = 0 WHERE `g_id` = %d LIMIT 1",
				GunDealer[ i ][g_id] );
			mysql_tquery( mysql, g_small_string );
		}
	}

	return 1;
}

function Crime_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED(KEY_CTRL_BACK) && Player[playerid][uCrimeM] && Player[playerid][uCrimeRank] )
	{
		for( new i; i < COUNT_GUNDEALERS; i++ )
		{
			if( GunDealer[i][g_time] && IsPlayerInRangeOfPoint( playerid, 1.0, GunDealer[i][g_actor_pos][0], GunDealer[i][g_actor_pos][1], GunDealer[i][g_actor_pos][2] ) )
			{
				SetPVarInt( playerid, "Crime:Order", i );
				return showPlayerDialog( playerid, d_crime + 39, DIALOG_STYLE_LIST, "Гандилер", "\
					"cBLUE"1."cWHITE" Оружие\n\
					"cBLUE"2."cWHITE" Патроны", "Выбрать", "Закрыть" );
			}
		}
	}

	return 1;
}

stock ShowCrimePriceInfo( playerid, type )
{
	clean:<g_string>;
	
	format:g_small_string( ""cWHITE"Вашей криминальной организации доступно оружие "cBLUE"%d"cWHITE" группы\n", type + 1 );
	strcat( g_string, g_small_string );
	
	new
		id;

	switch( type )
	{
		case 0:
		{		
			for( new i; i < 2; i++ )
			{
				for( new j; j < 10; j++ )
				{
					if( weapons_info[i][j][ gun_type ] < 2 && weapons_info[i][j][ gun_type ] != 0 )
					{
						id = getInventoryId( weapons_info[i][j][ gun_id ] );
						
						format:g_small_string( "\n"cBLUE"$%d\t%d пт.\t"cGRAY"%s", 
							weapons_info[i][j][ gun_price ],
							weapons_info[i][j][ gun_amount ],
							inventory[ id ][i_name]	);
						strcat( g_string, g_small_string );
					}
				}
			}
		}
		
		case 1:
		{
			for( new i; i < 2; i++ )
			{
				for( new j; j < 10; j++ )
				{
					if( weapons_info[i][j][ gun_type ] < 3 && weapons_info[i][j][ gun_type ] != 0 )
					{
						id = getInventoryId( weapons_info[i][j][ gun_id ] );
						
						format:g_small_string( "\n"cBLUE"$%d\t%d пт.\t"cGRAY"%s", 
							weapons_info[i][j][ gun_price ],
							weapons_info[i][j][ gun_amount ],
							inventory[ id ][i_name]	);
						strcat( g_string, g_small_string );
					}
				}
			}
		}
		
		case 2:
		{
			for( new i; i < 2; i++ )
			{
				for( new j; j < 10; j++ )
				{
					if( weapons_info[i][j][ gun_type ] != 0 )
					{
						id = getInventoryId( weapons_info[i][j][ gun_id ] );
						
						format:g_small_string( "\n"cBLUE"$%d\t%d пт.\t"cGRAY"%s", 
							weapons_info[i][j][ gun_price ],
							weapons_info[i][j][ gun_amount ],
							inventory[ id ][i_name]	);
						strcat( g_string, g_small_string );
					}
				}
			}
		}
	}
	
	return showPlayerDialog( playerid, d_crime + 42, DIALOG_STYLE_MSGBOX, "Информация", g_string, "Назад", "" );
}