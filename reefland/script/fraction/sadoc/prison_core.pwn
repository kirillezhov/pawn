function Prison_OnGameModeInit() 
{
	//Компьютеры
	for( new p; p < sizeof pr_panel; p++ ) 
	{
		CreateDynamic3DTextLabel( "Компьютер", C_BLUE, pr_panel[p][0], pr_panel[p][1], pr_panel[p][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1 );
	}
	
	//Двери-решетки между блоками
	for( new b; b < 14; b++ ) 
	{
		block_object[0][b] = CreateDynamicObject( 19303, block[0][b][0], block[0][b][1], block[0][b][2], block[0][b][3], block[0][b][4], block[0][b][5] );
	}
	
	for( new b; b < 13; b++ ) 
	{
		block_object[1][b] = CreateDynamicObject( 19303, block[1][b][0], block[1][b][1], block[1][b][2], block[1][b][3], block[1][b][4], block[1][b][5] );
	}
	
	//Телепорты
	for( new p; p < sizeof pr_teleport; p++ ) 
	{
		pr_teleport_zones[ p ] = CreateDynamicSphere( pr_teleport[p][prt_zone][0], pr_teleport[p][prt_zone][1], pr_teleport[p][prt_zone][2], 2.0 );
	}		
	
	prison_zone = CreateDynamicRectangle( 171.5877, -222.9033, 18.1368, -345.0724, 0, 0, -1 );
	
	return 1;
}

function Prison_OnPlayerEnterDynamicArea( playerid, areaid ) 
{
	if( GetPlayerVirtualWorld( playerid ) == 23 )
	{
		for( new p; p < sizeof pr_teleport; p++ ) 
		{
			if( areaid == pr_teleport_zones[ p ] )
			{
				setPlayerPos( playerid, pr_teleport[p][prt_pos][0], pr_teleport[p][prt_pos][1], pr_teleport[p][prt_pos][2] );
				SetPlayerFacingAngle( playerid, pr_teleport[p][prt_pos][3] );
				break;
			}
		}
	}
	
	if( areaid == prison_zone && prison_alarm )
	{
		PlayerPlaySound( playerid, 3401, 0.0, 0.0, 2.0 );
	}
	
	return 1;
}

function Prison_OnPlayerLeaveDynamicArea( playerid, areaid ) 
{
	if( areaid == prison_zone && prison_alarm && !GetPlayerVirtualWorld( playerid ) )
	{
		PlayerPlaySound( playerid, 0, 0.0, 0.0, 0.0 );
	}

	return 1;
}

function Prison_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	//Камеры
	if( PRESSED(KEY_SECONDARY_ATTACK) && Player[playerid][uMember] == FRACTION_SADOC ) 
	{
		if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uRank] ) return 1;
		
		for( new bl; bl < MAX_BLOCK; bl++ ) 
		{
			for( new b; b < 14; b++ ) 
			{
				if( IsPlayerInRangeOfPoint( playerid, 1.5, block[bl][b][0], block[bl][b][1], block[bl][b][2] ) ) 
				{
					if( !block_status[bl][b] ) 
					{
						MoveDynamicObject( block_object[bl][b], block[bl][b][0] + BLOCK_MOVE, block[bl][b][1], block[bl][b][2],1.0, block[bl][b][3], block[bl][b][4], block[bl][b][5] );
						block_status[bl][b] = true;
					}	
					else 
					{
						MoveDynamicObject( block_object[bl][b], block[bl][b][0], block[bl][b][1], block[bl][b][2], 1.0, block[bl][b][3], block[bl][b][4], block[bl][b][5] );
						block_status[bl][b] = false;
					}
					
					break;
				}
			}
		}
	}
	
	//Компьютеры
	if( PRESSED(KEY_WALK) && Player[playerid][uMember] == FRACTION_SADOC && Player[playerid][uRank] )  
	{
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid );
	
		for( new i; i < sizeof pr_panel; i++ ) 
		{
			if( IsPlayerInRangeOfPoint( playerid, 1.0, pr_panel[i][0], pr_panel[i][1], pr_panel[i][2] ) ) 
			{
				if( !FRank[fid][rank][r_add][1] ) 
					return SendClient:( playerid, C_WHITE, !NO_ACCESS ); 
			
				format:g_string( prison_computer, 
					all_block[BLOCK_D] ? ("Закрыть"):("Открыть"),
					all_block[BLOCK_E] ? ("Закрыть"):("Открыть"),
					prison_alarm ? ("Деактивировать"):("Активировать")
					);
				showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Закрыть" );
				
				break;
			}
		}
	}
	
	if( GetPVarInt( playerid, "CCTV:Use" ) )
	{
		new 
			tv = GetPVarInt( playerid, "CCTV:ID" ),
			blockid = GetPVarInt( playerid, "CCTV:block" );
	
		if( PRESSED(KEY_NO) )
		{
			setPlayerPos( playerid, GetPVarFloat( playerid, "CCTV:oldX" ), GetPVarFloat( playerid, "CCTV:oldY" ), GetPVarFloat( playerid, "CCTV:oldZ" ) );
					
			togglePlayerControllable( playerid, 1 );	
			
			DeletePVar( playerid, "CCTV:Use" );
			DeletePVar( playerid, "CCTV:oldX" );
			DeletePVar( playerid, "CCTV:oldY" );
			DeletePVar( playerid, "CCTV:oldZ" );
			
			PlayerTextDrawHide( playerid, TDPrisonCCTV[playerid] );
			
			SetCameraBehindPlayer( playerid );
		}
		else if( PRESSED(KEY_ANALOG_LEFT) )	
		{
			if( prison_cctv[tv - 1][cctv_block] != blockid || tv - 1 < 0 ) return 1;
			
			setCCTV( playerid, tv - 1 );
		}
		else if( PRESSED(KEY_ANALOG_RIGHT) )		
		{
			if( prison_cctv[tv + 1][cctv_block] != blockid || tv + 1 > sizeof prison_cctv ) return 1;
			
			setCCTV( playerid, tv + 1 );
		}
	}
	
	return 1;
}

function LoadForPlayerPrison( playerid )
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i = 0; i < rows; i++ )
	{
		Prison[playerid][p_camera] = cache_get_field_content_int( i, "pCamera", mysql );
		Prison[playerid][p_cooler] = cache_get_field_content_int( i, "pCooler", mysql );
			
		clean:<g_small_string>;
		cache_get_field_content( i, "pArrestName", g_small_string, mysql );
		strmid( Prison[playerid][p_namearrest], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "pReason", g_small_string, mysql );
		strmid( Prison[playerid][p_reason], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		Prison[playerid][p_date] = cache_get_field_content_int( i, "pDate", mysql );
		Prison[playerid][p_dateexit] = cache_get_field_content_int( i, "pExitDate", mysql );
		Prison[playerid][p_dateudo] = cache_get_field_content_int( i, "pUDODate", mysql );
		
		if( Prison[playerid][p_dateudo] )
		{
			clean:<g_small_string>;
			cache_get_field_content( i, "pUDOReason", g_small_string, mysql );
			strmid( Prison[playerid][p_reasonudo], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
	}
	
	return 1;
}

PrisonTimer( playerid ) 
{
	if( Prison[ playerid ][p_dateexit] > 0 && gettime() > Prison[ playerid ][p_dateexit] ) 
	{
		Player[ playerid ][uArrestStat]++;

		UpdatePlayer( playerid, "uArrestStat", Player[ playerid ][uArrestStat] );
	
		SendClient:( playerid, C_WHITE, !""gbDefault"Вы полностью отбыли срок наказания и выпущены на свободу." );
		
		mysql_format:g_small_string( "UPDATE `"DB_PRISON"` SET `pStatus` = 0 WHERE `puID` = %d", Player[ playerid ][uID] );
		mysql_tquery( mysql, g_small_string );
		
		if( !Prison[playerid][p_dateudo] )
		{
			setPlayerPos( playerid, 97.6320, -238.3941, 1.5785 );
			SetPlayerVirtualWorld( playerid, 0 );
			SetPlayerInterior( playerid, 0 );
		
			UpdateWeather( playerid );
		}
		
		Prison[playerid][p_camera] = 
		Prison[playerid][p_cooler] =
		Prison[playerid][p_date] = 
		Prison[playerid][p_dateudo] = 
		Prison[playerid][p_dateexit] = 0;
		
		Prison[playerid][p_reason][0] =
		Prison[playerid][p_namearrest][0] = 
		Prison[playerid][p_reasonudo][0] = EOS;
	}
	
	return 1;
}

//Открыть двери блоков
stock movePrisonBlock( mblock, bool:status ) 
{
	if( status ) 
	{
		for( new b; b < 14; b++ ) 
		{
			if( !block_status[mblock][b] ) 
			{
				MoveDynamicObject( block_object[mblock][b], block[mblock][b][0] + BLOCK_MOVE, block[mblock][b][1], block[mblock][b][2],
					1.0, block[mblock][b][3], block[mblock][b][4], block[mblock][b][5] );
				
				block_status[mblock][b] = true;
				all_block[mblock] = true;
			}	
			
		}	
	}
	else 
	{
		for( new b; b < 14; b++ ) 
		{
			if( block_status[mblock][b] ) 
			{
				MoveDynamicObject( block_object[mblock][b], block[mblock][b][0], block[mblock][b][1], block[mblock][b][2],
					1.0, block[mblock][b][3], block[mblock][b][4], block[mblock][b][5] );
			
				block_status[mblock][b] = false;
				all_block[mblock] = false;
			}	
		}
	}
	return 1;
}

//Инициализация видеонаблюдения, позиция игрока
stock initCCTV( playerid, blockid ) 
{
	new 
		Float:old_pos[3];
		
	GetPlayerPos( playerid, old_pos[0], old_pos[1], old_pos[2] );
	
	for( new i; i < sizeof prison_cctv; i++ ) 
	{
		if( prison_cctv[i][cctv_block] == blockid ) 
		{
			SetPVarFloat( playerid, "CCTV:oldX", old_pos[0] ),
			SetPVarFloat( playerid, "CCTV:oldY", old_pos[1] ),
			SetPVarFloat( playerid, "CCTV:oldZ", old_pos[2] );
			
			SetPVarInt( playerid, "CCTV:Use", 1 ), 
			SetPVarInt( playerid, "CCTV:ID", i );
			
			SetPVarInt( playerid, "CCTV:block", blockid );
			
			setPlayerPos( playerid, cctv_pos[blockid - 1][0], cctv_pos[blockid - 1][1], cctv_pos[blockid - 1][2] );
			togglePlayerControllable( playerid, false );
			
			setCCTV( playerid, i );
			break;
		}
	}
	
	return 1;
}

//Текстдравы видеонаблюдения
stock setCCTV( playerid, tv )
{
	new 
		dates	[3], 
		time	[2];
		
	SetPlayerCameraPos( playerid, prison_cctv[tv][cctv_x], prison_cctv[tv][cctv_y], prison_cctv[tv][cctv_z] - 0.25 );
	SetPlayerCameraLookAt( playerid, prison_cctv[tv][cctv_rx], prison_cctv[tv][cctv_ry], prison_cctv[tv][cctv_rz], 2 );
	
	gmtime( gettime(), dates[2], dates[1], dates[0], time[0], time[1] );
	
	PlayerTextDrawHide( playerid, TDPrisonCCTV[playerid] );
	format:g_string( 
		"~y~Видеокамера ~w~#%d~n~\
		~y~Дата: ~w~%02d.%02d.%d %02d:%02d~n~\
		~y~Локация: ~w~%s",
		tv + 1, dates[0], dates[1], dates[2], time[0], time[1],
		prison_cctv[tv][cctv_name] );
	
	PlayerTextDrawSetString( playerid, TDPrisonCCTV[playerid], g_string );
	PlayerTextDrawShow( playerid, TDPrisonCCTV[playerid] );
	
	SetPVarInt( playerid, "CCTV:ID", tv );
	
	return 1;
}

stock setPrisonWeather( playerid ) 
{
	SetPlayerTime( playerid, 11, 0 );
	SetPlayerWeather( playerid, 10 );
	
	SetPlayerInterior( playerid, 1 );
	SetPlayerVirtualWorld( playerid, 23 );
	
	return 1;
}

stock showArrestMenu( playerid ) 
{
	clean:<g_big_string>;
	
	new 
		giveplayerid = GetPVarInt( playerid, "Arrest:ID" ),
		camera[4], 
		dates[12], 
		info[64];
		
	format:g_string( ""gbDialog"Арест %s\n", Player[giveplayerid][uRPName] );
	strcat( g_big_string, g_string );
		
	GetPVarString( playerid, "Arrest:ar_info_text", info, sizeof info );
	
	format:g_string( ""cBLUE"1. "cWHITE"Причина ареста: %20s\n", GetPVarInt( playerid, "Arrest:ar_info" ) ? ( info ):("не указана") );
	strcat( g_big_string, g_string );
	
	if( GetPVarInt( playerid, "Arrest:ar_date" ) == INVALID_PARAM )
	{
		format( dates, sizeof dates, "пожизненно" );
	}
	else
	{
		format( dates, sizeof dates, "%d", GetPVarInt( playerid, "Arrest:ar_date" ) );
	}
	format:g_string( ""cBLUE"2. "cWHITE"Срок заключения: %s\n", GetPVarInt( playerid, "Arrest:ar_date" ) ? ( dates ):("не указан") );
	strcat( g_big_string, g_string );
	
	format( camera, sizeof camera, "%d", GetPVarInt( playerid, "Arrest:ar_cam" ) );
	format:g_string( ""cBLUE"3. "cWHITE"Номер камеры: %s\n", GetPVarInt( playerid, "Arrest:ar_cam" ) ? ( camera ):("не указан" ) );
	strcat( g_big_string, g_string );
	
	strcat( g_big_string, ""cBLUE"Посадить заключённого" );

	showPlayerDialog( playerid, d_arrest, DIALOG_STYLE_LIST, " ", g_big_string, "Выбрать", "Закрыть" );
	
	return 1;
}

function DownloadArrest()
{
	new 
		row,
		field;
		
	cache_get_data( row, field );
	
	if( !row )
		return 1;
		
	for( new i = 0; i < row; i++ )
	{
		PrisonTemp[p_camera] = cache_get_field_content_int( i, "puID", mysql );
		PrisonTemp[p_camera] = cache_get_field_content_int( i, "pCamera", mysql );
		PrisonTemp[p_cooler] = cache_get_field_content_int( i, "pCooler", mysql );
			
		clean:<g_small_string>;
		cache_get_field_content( i, "pName", g_small_string, mysql );
		strmid( PrisonTemp[p_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
		clean:<g_small_string>;
		cache_get_field_content( i, "pArrestName", g_small_string, mysql );
		strmid( PrisonTemp[p_namearrest], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "pReason", g_small_string, mysql );
		strmid( PrisonTemp[p_reason], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		PrisonTemp[p_date] = cache_get_field_content_int( i, "pDate", mysql );
		PrisonTemp[p_dateexit] = cache_get_field_content_int( i, "pExitDate", mysql );
		PrisonTemp[p_dateudo] = cache_get_field_content_int( i, "pUDODate", mysql );
		
		if( PrisonTemp[p_dateudo] )
		{
			clean:<g_small_string>;
			cache_get_field_content( i, "pUDOReason", g_small_string, mysql );
			strmid( PrisonTemp[p_reasonudo], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
	}

	return 1;
}

UpdatePrison( playerid, field[], const _: value )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_PRISON"` SET `%s` = %d WHERE `puID` = %d AND `pStatus` = 1",
		field,
		value,
		Player[playerid][uID]
	);
	
	mysql_tquery( mysql, g_string );
}