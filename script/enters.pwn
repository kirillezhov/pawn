Enter_OnGameModeInit() 
{
	mysql_tquery( mysql, "SELECT * FROM `"DB_ENTERS"`", "LoadEnters", "" );
	mysql_tquery( mysql, "SELECT * FROM `"DB_ENTERS_INSIDE"`", "LoadEntersInside" );
	return 1;
}

function entersInsert( playerid, e ) 
{
	EnterInfo[e][eID] = cache_insert_id();
		
	format:g_small_string( ""gbSuccess"Вы успешно добавили вход в интерьер [%s], ID: %d",
		EnterInfo[e][eName], EnterInfo[e][eID]
	);
	
	SendClient:( playerid, C_WHITE, g_small_string );
	
	format:g_small_string( ""gbSuccess"Для добавления выхода в интерьер используйте команду /exitenter %d",
		EnterInfo[e][eID] 
	);
	
	SendClient:( playerid, C_WHITE, g_small_string );
	
	return 1;
}

function LoadEnters()
{
	new
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return print( "[Load]: Null enters." );
	
	COUNT_ENTERS = 0x0;
	
	for( new i; i != rows; i++ )
	{
		EnterInfo[i][eID] = cache_get_field_content_int( i, "eID", mysql );
		EnterInfo[i][eP][0] = cache_get_field_content_float( i, "eP1", mysql );
		EnterInfo[i][eP][1] = cache_get_field_content_float( i, "eP2", mysql );
		EnterInfo[i][eP][2] = cache_get_field_content_float( i, "eP3", mysql );
		EnterInfo[i][eInt][0] = cache_get_field_content_int( i, "eInt", mysql );
		EnterInfo[i][eInt][1] = cache_get_field_content_int( i, "eWorld", mysql );
		
		EnterInfo[i][ePe][0] = cache_get_field_content_float( i, "ePe1", mysql );
		EnterInfo[i][ePe][1] = cache_get_field_content_float( i, "ePe2", mysql );
		EnterInfo[i][ePe][2] = cache_get_field_content_float( i, "ePe3", mysql );
		EnterInfo[i][exInt][0] = cache_get_field_content_int( i, "exInt", mysql );
		EnterInfo[i][exInt][1] = cache_get_field_content_int( i, "exWorld", mysql );
		
		cache_get_field_content( i, "eName", g_small_string, mysql );
		strmid( EnterInfo[i][eName], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	
		CreateDynamicPickup( 
			19902, 
			23, 
			EnterInfo[i][eP][0], 
			EnterInfo[i][eP][1], 
			EnterInfo[i][eP][2] - 0.5, 
			EnterInfo[i][exInt][1],
			-1, -1, 30.0
		);
		
		/*CreateDynamicPickup( 
			19132,
			23, 
			EnterInfo[i][ePe][0], 
			EnterInfo[i][ePe][1], 
			EnterInfo[i][ePe][2], 
			EnterInfo[i][eInt][1] 
		);*/
		
		format:g_small_string( ""cWHITE"%s\n"cBLUE"Открыто", EnterInfo[i][eName] );
		
		CreateDynamic3DTextLabel( 
			g_small_string, 
			C_BLUE, 
			EnterInfo[i][eP][0], 
			EnterInfo[i][eP][1],
			EnterInfo[i][eP][2], 
			5.0, 
			INVALID_PLAYER_ID, 
			INVALID_VEHICLE_ID, 
			1 
		);
		
			
		CreateDynamic3DTextLabel( 
			"Exit", 
			C_BLUE,
			EnterInfo[i][ePe][0], 
			EnterInfo[i][ePe][1], 
			EnterInfo[i][ePe][2] - 0.5,
			5.0, 
			INVALID_PLAYER_ID, 
			INVALID_VEHICLE_ID, 
			1, 
			-1
		);
		
		COUNT_ENTERS++;
	}
	
	return printf( "[Load]: Enters loaded. All - %d.", COUNT_ENTERS );
}

function LoadEntersInside()
{
	new
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return print( "[Load]: Null enters." );
	
	COUNT_ENTERS_INSIDE = 0x0;
	
	for( new i; i < rows; i++ )
	{
		EnterInside[i][e_id] = cache_get_field_content_int( i, "e_id", mysql );
		EnterInside[i][e_world] = cache_get_field_content_int( i, "e_world", mysql );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "e_pos", g_small_string, mysql, 64 );
		sscanf( g_small_string,"p<|>a<f>[3]", EnterInside[i][e_pos] );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "e_pos_exit", g_small_string, mysql, 64 );
		sscanf( g_small_string,"p<|>a<f>[3]", EnterInside[i][e_pos_exit] );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "e_name", g_small_string, mysql );
		strmid( EnterInside[i][e_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		CreateDynamic3DTextLabel( 
			EnterInside[i][e_name], 
			C_BLUE, 
			EnterInside[i][e_pos][0], 
			EnterInside[i][e_pos][1],
			EnterInside[i][e_pos][2] - 0.5, 
			5.0, 
			INVALID_PLAYER_ID, 
			INVALID_VEHICLE_ID, 
			1 
		);
		
			
		CreateDynamic3DTextLabel( 
			EnterInside[i][e_name], 
			C_BLUE,
			EnterInside[i][e_pos_exit][0], 
			EnterInside[i][e_pos_exit][1], 
			EnterInside[i][e_pos_exit][2] - 0.5,
			5.0, 
			INVALID_PLAYER_ID, 
			INVALID_VEHICLE_ID, 
			1
		);
		
		COUNT_ENTERS_INSIDE++;
	}
	
	return printf( "[Load]: Enters Inside loaded. All - %d.", COUNT_ENTERS_INSIDE );
}

Enter_OnPlayerKeyStateChange( playerid, newkeys ) 
{
	switch( newkeys ) 
	{
		case KEY_WALK: 
		{
			for( new i; i < COUNT_ENTERS; i++ ) //Внешние переходы
			{
				if( IsPlayerInRangeOfPoint( playerid, 2.0, EnterInfo[i][eP][0], EnterInfo[i][eP][1], EnterInfo[i][eP][2] ) ) 
				{
					if( EnterInfo[i][eInt][0] ) 
						setHouseWeather( playerid );
					
					Player[playerid][tgpsPos][0] = EnterInfo[i][eP][0];
					Player[playerid][tgpsPos][1] = EnterInfo[i][eP][1];
					Player[playerid][tgpsPos][2] = EnterInfo[i][eP][2];
					
					setPlayerPos( playerid, EnterInfo[i][ePe][0], EnterInfo[i][ePe][1], EnterInfo[i][ePe][2] );
					SetPlayerInterior( playerid, EnterInfo[i][eInt][0] );
					SetPlayerVirtualWorld( playerid, EnterInfo[i][eInt][1] );
					
					//Streamer_UpdateEx( playerid, EnterInfo[i][ePe][0], EnterInfo[i][ePe][1], EnterInfo[i][ePe][2], EnterInfo[i][eInt][1], EnterInfo[i][eInt][0] );
					//SpawnFreezeTime( playerid );
					//stopPlayer( playerid, 2 );
					
					break;
				}
				else if( IsPlayerInRangeOfPoint( playerid, 2.0, EnterInfo[i][ePe][0], EnterInfo[i][ePe][1], EnterInfo[i][ePe][2] ) && GetPlayerVirtualWorld( playerid ) == EnterInfo[i][eInt][1] ) 
				{		
					if( death_timer[playerid] ) //Если находится в больнице
					{
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете покинуть пределы госпиталя, так как проходите курс реабилитации." );
					}
				
					setPlayerPos( playerid, EnterInfo[i][eP][0], EnterInfo[i][eP][1], EnterInfo[i][eP][2] );
					SetPlayerInterior( playerid, EnterInfo[i][exInt][0] );
					SetPlayerVirtualWorld( playerid, EnterInfo[i][exInt][1] );
					DeletePVar( playerid, "User:inInt" );

					Player[playerid][tgpsPos][0] = 
					Player[playerid][tgpsPos][1] = 
					Player[playerid][tgpsPos][2] = 0.0;
					
					UpdateWeather( playerid );
				}
			}
			
			for( new i; i < COUNT_ENTERS_INSIDE; i++ ) //Внутренние переходы
			{
				if( IsPlayerInRangeOfPoint( playerid, 1.0, EnterInside[i][e_pos][0], EnterInside[i][e_pos][1], EnterInside[i][e_pos][2] ) )
				{
					setPlayerPos( playerid, EnterInside[i][e_pos_exit][0], EnterInside[i][e_pos_exit][1], EnterInside[i][e_pos_exit][2] );
				}
				else if( IsPlayerInRangeOfPoint( playerid, 1.0, EnterInside[i][e_pos_exit][0], EnterInside[i][e_pos_exit][1], EnterInside[i][e_pos_exit][2] ) )
				{
					if( EnterInside[i][e_world] && GetPlayerVirtualWorld( playerid ) != EnterInside[i][e_world] )
						continue;
				
					setPlayerPos( playerid, EnterInside[i][e_pos][0], EnterInside[i][e_pos][1], EnterInside[i][e_pos][2] );
				}
			}
		}
	}
	
	return 1;
}