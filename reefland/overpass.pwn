Overpass_OnGameModeInit()
{
	for( new i; i < MAX_OVERPASS; i ++) 
	{
		if( i > 13 )
		{
			o_overpass_id[i] = CreateDynamicObject( 16322, Overpass[i][0][0], Overpass[i][0][1], Overpass[i][0][2], 0.000, 0.000, Overpass[i][0][3], -1, -1, -1, 300.000, 300.000 );
			SetDynamicObjectMaterial(o_overpass_id[i], 0, -1, "none", "none", 0xFFFFFFFF);
		}
		else
		{
			o_overpass_id[i] = CreateDynamicObject( 19872, Overpass[i][0][0], Overpass[i][0][1], Overpass[i][0][2], 0.000, 0.000, Overpass[i][0][3], -1, -1, -1, 300.000, 300.000 );
		
			if( i > 7 ) SetDynamicObjectMaterial(o_overpass_id[i], 0, 9583, "bigshap_sfw", "shipceiling_sfw", 0x00000000);
		}
		CreateDynamic3DTextLabel( "Пульт", C_BLUE, Overpass[i][5][0], Overpass[i][5][1], Overpass[i][5][2] + 1.0, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0 );
	}
	
	for( new i; i < sizeof TuningPosition; i++ )
	{
		CreateDynamic3DTextLabel( "Использовать '"cBLUE"H"cWHITE"'", C_WHITE, TuningPosition[i][0], TuningPosition[i][1], TuningPosition[i][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0 );
	}
	
	return 1;
}

function Overpass_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED( KEY_WALK ) )
	{
		for(new i; i < MAX_OVERPASS; i ++)
		{
			if( IsPlayerInRangeOfPoint( playerid, 1.5, Overpass[i][5][0], Overpass[i][5][1], Overpass[i][5][2] ) ) 
			{
				if( i < 8 )
				{
					if( Player[playerid][uJob] != JOB_MECHANIC ) 
						return 1;
				}
				
				if( i >= 8 )
				{
					if( !Player[playerid][uRank] || !Player[playerid][uMember] ) 
						return 1;
						
					if( !FRank[ Player[playerid][uMember] - 1 ][ getRankId( playerid, Player[playerid][uMember] - 1 ) ][r_mechanic] )
						return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
				}
			
				format:g_string( "\
					%s\n\
					%s\n\
					%s\n\
					%s\n\
					%s",
					!o_overpass_status[i] ? (""cBLUE"Начальное положение") : (""cWHITE"Начальное положение"),
					o_overpass_status[i] == 1 ? (""cBLUE"Положение 1") : (""cWHITE"Положение 1"),
					o_overpass_status[i] == 2 ? (""cBLUE"Положение 2") : (""cWHITE"Положение 2"),
					o_overpass_status[i] == 3 ? (""cBLUE"Положение 3") : (""cWHITE"Положение 3"),
					o_overpass_status[i] == 4 ? (""cBLUE"Положение 4") : (""cWHITE"Положение 4") );
			
				SetPVarInt( playerid, "Overpass", i );
				showPlayerDialog( playerid, d_mech + 8, DIALOG_STYLE_LIST, "Станция тех. обслуживания", g_string, "Выбрать", "Закрыть" );
				break;
			}
		}
	}
	
	return 1;
}


SetOverpassState( i, flag )
{
	switch( flag ) 
	{
		case 1:
			MoveDynamicObject( o_overpass_id[i], Overpass[i][1][0], Overpass[i][1][1], Overpass[i][1][2], 0.3, 0.0 , 0.0, Overpass[i][1][3] );

		case 2:
			MoveDynamicObject( o_overpass_id[i], Overpass[i][2][0], Overpass[i][2][1], Overpass[i][2][2], 0.3, 0.0 , 0.0, Overpass[i][2][3] );
		
		case 3:
			MoveDynamicObject( o_overpass_id[i], Overpass[i][3][0], Overpass[i][3][1], Overpass[i][3][2], 0.3, 0.0 , 0.0, Overpass[i][3][3] );
		
		case 4:
			MoveDynamicObject( o_overpass_id[i], Overpass[i][4][0], Overpass[i][4][1], Overpass[i][4][2], 0.3, 0.0 , 0.0, Overpass[i][4][3] );
		
		case 0:
			MoveDynamicObject( o_overpass_id[i], Overpass[i][0][0], Overpass[i][0][1], Overpass[i][0][2], 0.3, 0.0 , 0.0, Overpass[i][0][3] );
	}
	return 1;
}

Overpass_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	#pragma unused inputtext
	clean_array();
	
	switch( dialogid ) 
	{
		case d_mech + 8:
		{
			if( !response )
			{
				DeletePVar( playerid, "Overpass" );
				return 1;
			}
				
			new
				o_id = GetPVarInt( playerid, "Overpass" );
				
			if( o_overpass_status[o_id] == listitem )
				return SendClient:( playerid, C_WHITE, ""gbError"Подъемник уже находится в этом положении." );
					
			o_overpass_status[o_id] = listitem;
			SetOverpassState( o_id, listitem );
				
			format:g_small_string( "нажал%s кнопку на пульте", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );

			DeletePVar( playerid, "Overpass" );
		}
	}

	return 1;
}
