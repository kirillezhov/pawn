CMD:ticket( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_WOOD || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid ),
		index = INVALID_PARAM,
		type;
	
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		if( !FRank[fid][rank][r_add][3] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
		
	if( sscanf( params, "dds[32]", params[0], params[1], params[2] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /ticket [ id игрока ] [ cумма ] [ причина ]" );
		
	if( !IsLogged( params[0] ) || params[0] == playerid )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( params[1] < 0 || params[1] > 50000 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Сумма штрафа должна быть не менее $0 и не более $50000." );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с вами." );

	for( new i; i < MAX_PENALTIES; i++ )
	{
		if( !Penalty[ params[0] ][i][pen_id] )
		{
			index = i;
			type = 1;
			
			goto next;
			break;
		}
	}

	if( index == INVALID_PARAM )
	{
		for( new i; i < MAX_PENALTIES; i++ )
		{
			if( Penalty[ params[0] ][i][pen_type] )
			{
				index = i;
				type = 2;
				
				goto next;
				break;
			}
		}
	}
	
	if( index == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"У игрока слишком много неоплаченных штрафов." );
	
	next:
	
	Penalty[ params[0] ][index][pen_price] = params[1];
	Penalty[ params[0] ][index][pen_date] = gettime();
	
	clean:<Penalty[ params[0] ][index][pen_name]>;
	clean:<Penalty[ params[0] ][index][pen_descript]>;
	
	strcat( Penalty[ params[0] ][index][pen_name], Player[ params[0] ][uName], 32 );
	strcat( Penalty[ params[0] ][index][pen_descript], params[2], 32 );
	
	if( !params[1] )
	{
		Penalty[ params[0] ][index][pen_type] = 2;
		
		pformat:( ""gbSuccess"%s выписал Вам штраф-предупреждение по причине: "cBLUE"%s"cWHITE".", Player[playerid][uRPName], Penalty[ params[0] ][index][pen_descript] );
		psend:( params[0], C_WHITE );
		
		pformat:( ""gbSuccess"Вы выписали штраф-предупреждение %s по причине: "cBLUE"%s"cWHITE".", Player[ params[0] ][uRPName], Penalty[ params[0] ][index][pen_descript] );
		psend:( playerid, C_WHITE );
	}
	else
	{
		Penalty[ params[0] ][index][pen_type] = 0;
		
		pformat:( ""gbSuccess"%s выписал Вам штраф на сумму $%d по причине: "cBLUE"%s"cWHITE".", Player[playerid][uRPName], params[1], Penalty[ params[0] ][index][pen_descript] );
		psend:( params[0], C_WHITE );
		
		pformat:( ""gbSuccess"Вы выписали штраф %s на сумму $%d по причине: "cBLUE"%s"cWHITE".", Player[ params[0] ][uRPName], params[1], Penalty[ params[0] ][index][pen_descript] );
		psend:( playerid, C_WHITE );
	}
	
	switch( type )
	{
		case 1:
		{
			mysql_format:g_string( "INSERT INTO `"DB_PENALTIES"` \
				( `pen_name`, `pen_type`, `pen_price`, `pen_date`, `pen_descript` ) VALUES \
				( '%s', '%d', '%d', '%d', '%e' )",
				Penalty[ params[0] ][index][pen_name],
				Penalty[ params[0] ][index][pen_type],
				Penalty[ params[0] ][index][pen_price],
				Penalty[ params[0] ][index][pen_date],
				Penalty[ params[0] ][index][pen_descript]
			);
			mysql_tquery( mysql, g_string, "InsertPenalty", "dd", params[0], index );
		}
		
		case 2:
		{
			mysql_format:g_string( "\
				UPDATE `"DB_RANKS"`\
				SET\
					`pen_type` = '%d',\
					`pen_price` = '%d',\
					`pen_date` = '%d',\
					`pen_descript` = '%e'\
				WHERE `pen_id` = %d",
				Penalty[ params[0] ][index][pen_type],
				Penalty[ params[0] ][index][pen_price],
				Penalty[ params[0] ][index][pen_date],
				Penalty[ params[0] ][index][pen_descript],
				Penalty[ params[0] ][index][pen_id]
			);
			mysql_tquery( mysql, g_string );
		}
	}
	
	return 1;
}

CMD:cticket( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_POLICE || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = FRACTION_POLICE - 1,
		rank = getRankId( playerid, fid ),
		ownerid = INVALID_PARAM,
		index = INVALID_PARAM,
		type,
		Float:x, Float:y, Float:z;
		
	if( !FRank[fid][rank][r_add][3] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "dds[32]", params[0], params[1], params[2] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /ticket [ id авто ] [ cумма ] [ причина ]" );
		
	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_VEHICLEID );
		
	if( Vehicle[ params[0] ][vehicle_user_id] == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"У данного транспорта нет владельца." );
		
	foreach(new i : Player)
	{
		if( !IsLogged(i) ) continue;
	
		if( Vehicle[ params[0] ][vehicle_user_id] == Player[i][uID] )
		{
			ownerid = i;
			break;
		}
	}
		
	if( ownerid == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"Владельца транспорта неизвестен." );
		
	if( params[1] < 0 || params[1] > 50000 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Сумма штрафа должна быть не менее $0 и не более $50000." );
		
	GetVehiclePos( params[0], x, y, z );
	if( GetPlayerDistanceFromPoint( playerid, x, y, z ) > 7.0 || GetPlayerVirtualWorld( playerid ) != GetVehicleVirtualWorld( params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Данного транспорта нет рядом с Вами." );	

	for( new i; i < MAX_PENALTIES; i++ )
	{
		if( !Penalty[ ownerid ][i][pen_id] )
		{
			index = i;
			type = 1;
			
			goto next;
			break;
		}
	}

	if( index == INVALID_PARAM )
	{
		for( new i; i < MAX_PENALTIES; i++ )
		{
			if( Penalty[ ownerid ][i][pen_type] )
			{
				index = i;
				type = 2;
				
				goto next;
				break;
			}
		}
	}
	
	if( index == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"У владельца слишком много неоплаченных штрафов." );
	
	next:
	
	Penalty[ ownerid ][index][pen_price] = params[1];
	Penalty[ ownerid ][index][pen_date] = gettime();
	
	clean:<Penalty[ ownerid ][index][pen_name]>;
	clean:<Penalty[ ownerid ][index][pen_descript]>;
	
	strcat( Penalty[ ownerid ][index][pen_name], Player[ ownerid ][uName], 32 );
	strcat( Penalty[ ownerid ][index][pen_descript], params[2], 32 );
	
	if( !params[1] )
	{
		Penalty[ ownerid ][index][pen_type] = 2;
		
		pformat:( ""gbSuccess"%s выписал Вам штраф-предупреждение по причине: "cBLUE"%s"cWHITE".", Player[playerid][uRPName], Penalty[ ownerid ][index][pen_descript] );
		psend:( ownerid, C_WHITE );
		
		pformat:( ""gbSuccess"Вы выписали штраф-предупреждение %s по причине: "cBLUE"%s"cWHITE".", Player[ ownerid ][uRPName], Penalty[ ownerid ][index][pen_descript] );
		psend:( playerid, C_WHITE );
	}
	else
	{
		Penalty[ ownerid ][index][pen_type] = 0;
		
		pformat:( ""gbSuccess"%s выписал Вам штраф на сумму $%d по причине: "cBLUE"%s"cWHITE".", Player[playerid][uRPName], params[1], Penalty[ ownerid ][index][pen_descript] );
		psend:( ownerid, C_WHITE );
		
		pformat:( ""gbSuccess"Вы выписали штраф %s на сумму $%d по причине: "cBLUE"%s"cWHITE".", Player[ ownerid ][uRPName], params[1], Penalty[ ownerid ][index][pen_descript] );
		psend:( playerid, C_WHITE );
	}
	
	switch( type )
	{
		case 1:
		{
			mysql_format:g_string( "INSERT INTO `"DB_PENALTIES"` \
				( `pen_name`, `pen_type`, `pen_price`, `pen_date`, `pen_descript` ) VALUES \
				( '%s', '%d', '%d', '%d', '%e' )",
				Penalty[ ownerid ][index][pen_name],
				Penalty[ ownerid ][index][pen_type],
				Penalty[ ownerid ][index][pen_price],
				Penalty[ ownerid ][index][pen_date],
				Penalty[ ownerid ][index][pen_descript]
			);
			mysql_tquery( mysql, g_string, "InsertPenalty", "dd", ownerid, index );
		}
		
		case 2:
		{
			mysql_format:g_string( "\
				UPDATE `"DB_RANKS"`\
				SET\
					`pen_type` = '%d',\
					`pen_price` = '%d',\
					`pen_date` = '%d',\
					`pen_descript` = '%e'\
				WHERE `pen_id` = %d",
				Penalty[ ownerid ][index][pen_type],
				Penalty[ ownerid ][index][pen_price],
				Penalty[ ownerid ][index][pen_date],
				Penalty[ ownerid ][index][pen_descript],
				Penalty[ ownerid ][index][pen_id]
			);
			mysql_tquery( mysql, g_string );
		}
	}

	return 1;
}

CMD:hale( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_WOOD &&
		Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = FRACTION_POLICE - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_add][6] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
		
	if( GetPVarInt( playerid, "Player:Lead" ) != INVALID_PLAYER_ID ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Вы уже ведёте за собой кого-то." );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /hale [ id игрока ]" );
	
	if( !GetPVarInt( params[0], "Player:Cuff" ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок должен быть в наручниках." );
		
	if( !IsLogged( params[0] ) || params[0] == playerid || IsPlayerNPC( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClientMessage( playerid, C_GRAY, !""gbError"Данного игрока нет рядом с вами." );
			
	SetPVarInt( playerid, "Player:Lead", params[0] );
	SetPVarInt( params[0], "Player:Follow", playerid );
	
	pformat:( ""gbSuccess"Вы заставили %s идти за Вами, /unhale - отпустить.", Player[ params[0] ][uName] );
	psend:( playerid, C_WHITE );

	pformat:( ""gbSuccess"%s заставил%s Вас идти за %s.", Player[playerid][uName], SexTextEnd( playerid ), Player[playerid][uSex] == 2 ? ("ней") : ("ним") );
	psend:( params[0], C_WHITE );
	
	togglePlayerControllable( params[0], true );
	
	return 1;
}

CMD:unhale( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_WOOD &&
		Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = FRACTION_POLICE - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_add][6] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}

	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unhale [ id игрока ]" );
	
	if( GetPVarInt( playerid, "Player:Lead" ) != params[0] ) 
		return SendClientMessage( playerid, C_WHITE, !""gbError"Данный игрок идёт не за Вами." );
	
	if( !IsLogged( params[0] ) || params[0] == playerid ) 
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );
	
	SetPVarInt( playerid, "Player:Lead", INVALID_PLAYER_ID );
	SetPVarInt( params[0], "Player:Follow", INVALID_PLAYER_ID );
	
	/*if( GetPVarInt( params[0], "Player:Cuff" ) )*/
	togglePlayerControllable( params[0], true );
	
	pformat:( ""gbSuccess"Вы прекратили вести за собой %s.", Player[ params[0] ][uName] );
	psend:( playerid, C_WHITE );
	
	pformat:( ""gbSuccess"Вы прекратили идти за %s.", Player[playerid][uName] );
	psend:( params[0], C_WHITE );
	
	return 1;
}

CMD:put( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_WOOD &&
		Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		Float:X,
		Float:Y,
		Float:Z;
		
	if( IsPlayerInAnyVehicle( playerid ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = FRACTION_POLICE - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_add][6] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
		
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /put [ id игрока ] [ id транспорта ]" );
		
	if( !IsLogged( params[0] ) || params[0] == playerid ) 
		return SendClientMessage( playerid, C_GRAY, !INCORRECT_PLAYERID );
		
	if( !GetVehicleModel( params[1] ) || Vehicle[ params[1] ][vehicle_member] != Player[playerid][uMember]  ) 
		return SendClientMessage( playerid, C_GRAY, !INCORRECT_VEHICLEID );

	GetVehiclePos( params[1], X, Y, Z );
	
	if( GetPlayerDistanceFromPoint( playerid, X, Y, Z ) > 5.0 )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы слишком далеко от машины." ); 
		
	if( GetPlayerDistanceFromPoint( params[0], X, Y, Z ) > 5.0 )
		return SendClient:( playerid, C_WHITE, !""gbError"Игрок слишком далеко от машины." ); 
		
	Player[ params[0] ][tEnterVehicle] = params[1];
	
	if( !putPlayerInVehicle( params[0], params[1], 3 ) && !putPlayerInVehicle( params[0], params[1], 2 ) )
	{
		Player[ params[0] ][tEnterVehicle] = INVALID_VEHICLE_ID;
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете посадить игрока в эту машину." );
	}
		
	return 1;
}

CMD:eject( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_WOOD &&
		Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !IsPlayerInAnyVehicle( playerid ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		vehicleid;
		
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = FRACTION_POLICE - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_add][6] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}

	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /eject [ id игрока ]" );
		
	if( !IsLogged( params[0] ) || params[0] == playerid ) 
		return SendClient:( playerid, C_GRAY, !INCORRECT_PLAYERID );
		
	vehicleid = GetPlayerVehicleID( playerid );
	
	if( Vehicle[vehicleid][vehicle_member] != Player[playerid][uMember] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( GetPlayerVehicleSeat( params[0] ) != 2 && GetPlayerVehicleSeat( params[0] ) != 3 )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете выбросить этого игрока из машины." );
		
	Player[ params[0] ][tEnterVehicle] = vehicleid;
		
	if( !removePlayerFromVehicle( params[0] ) )
	{
		Player[ params[0] ][tEnterVehicle] = INVALID_VEHICLE_ID;
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете выбросить этого игрока из машины." );
	}
		
	return 1;
}

CMD:givelic( playerid )
{
	if( Player[playerid][uMember] != FRACTION_POLICE || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = FRACTION_POLICE - 1,
		rank = getRankId( playerid, fid );

	if( !FRank[fid][rank][r_add][1] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	ShowApplications( playerid );
		
	return 1;
}

CMD:carrest( playerid )
{
	if( Player[playerid][uMember] != FRACTION_POLICE || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( !IsPlayerInRangeOfPoint( playerid, 7.0, RANGE_CAR_ARREST_1 ) && !IsPlayerInRangeOfPoint( playerid, 7.0, RANGE_CAR_ARREST_2 ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
			
	if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerState( playerid ) != PLAYER_STATE_DRIVER ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	new
		vehicleid = GetPlayerVehicleID( playerid ),
		attachid,
		fid = FRACTION_POLICE - 1,
		rank = getRankId( playerid, fid ),
		bool:flag = false,
		tmp[ MAX_ARREST ];
		
	if( Vehicle[vehicleid][vehicle_member] != FRACTION_POLICE || GetVehicleModel( vehicleid ) != 525 ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_mechanic] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( GetAmountPassenger( playerid, vehicleid ) )
		return SendClient:( playerid, C_WHITE, !""gbError"В Вашем эвакуаторе есть пассажиры." );
		
	if( !GetVehicleTrailer( vehicleid ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вашего эвакуатора нет транспорта." );
		
	attachid = GetVehicleTrailer( vehicleid );
	
	if( Vehicle[attachid][vehicle_user_id] == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"Невозможно поставить на штрафстоянку этот транспорт." );
		
	for( new i; i < MAX_ARREST; i++ )
	{
		tmp[ i ] = INVALID_PARAM;
		if( VArrest[i][arrest_id] )
		{
			tmp[ i ] = VArrest[i][arrest_pos];
		}
	}
		
	for( new i; i < MAX_ARREST; i++ )
	{
		if( !VArrest[i][arrest_id] )
		{
			for( new j; j < MAX_ARREST; j++ )
			{
				if( tmp[ j ] == INVALID_PARAM )
				{
					VArrest[i][arrest_pos] = j;
					break;
				}
			}

			VArrest[i][arrest_date] = gettime() + 7 * 86400;
			VArrest[i][arrest_vehid] = Vehicle[attachid][vehicle_id]; 
			
			clean:<VArrest[i][arrest_name]>;
			strcat( VArrest[i][arrest_name], Player[playerid][uName], MAX_PLAYER_NAME );
			
			Vehicle[attachid][vehicle_pos][0] = vehicle_arrest_pos[ VArrest[i][arrest_pos] ][0];
			Vehicle[attachid][vehicle_pos][1] = vehicle_arrest_pos[ VArrest[i][arrest_pos] ][1];
			Vehicle[attachid][vehicle_pos][2] = vehicle_arrest_pos[ VArrest[i][arrest_pos] ][2];
			Vehicle[attachid][vehicle_pos][3] = vehicle_arrest_pos[ VArrest[i][arrest_pos] ][3];
			
			Vehicle[attachid][vehicle_arrest] = 
			Vehicle[attachid][vehicle_int] = 1;
			Vehicle[attachid][vehicle_world] = 22;
			
			Vehicle[attachid][vehicle_state_engine] = 
			Vehicle[attachid][vehicle_state_light] = 
			Vehicle[attachid][vehicle_state_alarm] = 
			Vehicle[attachid][vehicle_state_hood] = 
			Vehicle[attachid][vehicle_state_boot] = 
			Vehicle[attachid][vehicle_state_obj] = 0;
			Vehicle[attachid][vehicle_state_door] = 1;
			
			mysql_format:g_string( "UPDATE `"DB_VEHICLES"` SET \
				`vehicle_pos` = '%f|%f|%f|%f', \
				`vehicle_int` = %d, \
				`vehicle_world` = %d, \
				`vehicle_settings` = '0|0|0|1|0|0|0', \
				`vehicle_arrest` = 1 WHERE `vehicle_id` = %d LIMIT 1", 
				Vehicle[attachid][vehicle_pos][0],
				Vehicle[attachid][vehicle_pos][1],
				Vehicle[attachid][vehicle_pos][2],
				Vehicle[attachid][vehicle_pos][3],
				Vehicle[attachid][vehicle_int],
				Vehicle[attachid][vehicle_world],
				Vehicle[attachid][vehicle_id]
			);
			mysql_tquery( mysql, g_string );
			
			/*SetVehicleVirtualWorld( attachid, Vehicle[attachid][vehicle_world] );
			
			SetVehicleZAngle( attachid, Vehicle[attachid][vehicle_pos][3] );
			setVehiclePos( attachid, Vehicle[attachid][vehicle_pos][0], Vehicle[attachid][vehicle_pos][1], Vehicle[attachid][vehicle_pos][2] );
			
			SetVehicleParams( attachid );*/
			
			SetVehicleToRespawnEx( attachid );
			
			mysql_format:g_string( "INSERT INTO `"DB_VEHICLES_ARREST"` (\ 
				`arrest_vehid`, `arrest_pos`, `arrest_name`, `arrest_date` ) VALUE (\ 
				%d, %d, '%s', %d )",
				VArrest[i][arrest_vehid],
				VArrest[i][arrest_pos],
				VArrest[i][arrest_name],
				VArrest[i][arrest_date] );
			mysql_tquery( mysql, g_string, "InsertArrest", "d", i );
			
			pformat:( ""gbSuccess"Вы припарковали "cBLUE"%s"cWHITE" на штрафстоянку. Парковочное место "cBLUE"%d"cWHITE".", GetVehicleModelName( Vehicle[attachid][vehicle_model] ), VArrest[i][arrest_pos] + 1 );
			psend:( playerid, C_WHITE );
			
			flag = true;
			break;
		}
	}
	
	if( !flag )
		return SendClient:( playerid, C_WHITE, !""gbError"На штрафстоянке нет свободных мест." );
		
	return 1;
}

CMD:mdc( playerid )
{
	if( Player[playerid][uMember] != FRACTION_POLICE &&
		Player[playerid][uMember] != FRACTION_WOOD &&
		Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( GetPVarInt( playerid, "Inv:Show" ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid );
			
	if( !FRank[fid][rank][r_add][4] && Player[playerid][uMember] == FRACTION_POLICE )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "Бортовой компьютер", dialog_computer, "Выбрать", "Закрыть" );
		
	return 1;
}

CMD:arrest( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_WOOD || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /arrest [ ID игрока ][ кол-во минут ]");
	
	if( !IsLogged( params[0] ) || playerid == params[0] ) 
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( Player[ params[0] ][uJail] )
		return SendClient:( playerid, C_WHITE, !""gbError"Этот игрок уже находится в КПЗ." );
		
	if( params[1] < 1 || params[1] > 2880 )
		return SendClient:( playerid, C_WHITE, !""gbError"Срок в КПЗ может быть от 1 минуты до 48 часов." );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );
		
	new
		bool:flag = false;
		
	for( new i; i < sizeof spawnJail; i++ )
	{
		if( IsPlayerInRangeOfPoint( playerid, 1.0, spawnJail[i][pos_exit][0], spawnJail[i][pos_exit][1], spawnJail[i][pos_exit][2] ) )
		{
			Player[ params[0] ][uJail] = i + 1;
		
			setPlayerPos( params[0], 
				spawnJail[ i ][pos_enter][0],
				spawnJail[ i ][pos_enter][1],
				spawnJail[ i ][pos_enter][2] );
			SetPlayerFacingAngle( params[0], spawnJail[i][pos_enter][3] );
		
			flag = true;
			break;
		}
	}
	if( !flag ) return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться рядом с КПЗ." );
		
	Player[ params[0] ][uJailTime] = gettime() + params[1] * 60;
	
	Player[ params[0] ][uSuspect] = 0;
	clean:<Player[ params[0] ][uSuspectReason]>;
	
	pformat:( ""gbDefault"Вы были помещены в КПЗ "cBLUE"%s"cWHITE" на "cBLUE"%d"cWHITE" мин.",
		Player[playerid][uName], 
		params[1]
	);
	psend:( params[0], C_WHITE );
		
	pformat:( ""gbSuccess"Вы поместили в КПЗ "cBLUE"%s"cWHITE" на "cBLUE"%d"cWHITE" мин.",
		Player[ params[0] ][uName], 
		params[1] );
	psend:( playerid, C_WHITE );
	
	UpdatePlayer( params[0], "uSuspect", 0 ), 
	UpdatePlayerString( params[0], "uSuspectReason", Player[ params[0] ][uSuspectReason] );
	UpdatePlayer( params[0], "uJail", Player[ params[0] ][uJail] ),
	UpdatePlayer( params[0], "uJailTime", Player[ params[0] ][uJailTime] );
	
	if( GetPVarInt( params[0], "Player:Follow" ) != INVALID_PLAYER_ID ) 
	{
		SetPVarInt( GetPVarInt( params[0], "Player:Follow" ), "Player:Lead", INVALID_PLAYER_ID );
		SetPVarInt( params[0], "Player:Follow", INVALID_PLAYER_ID );
	}
	
	if( GetPVarInt( params[0], "Player:Cuff" ) ) 
	{
		DeletePVar( params[0], "Player:Cuff" );
	
		SetPlayerSpecialAction( params[0], SPECIAL_ACTION_NONE );
		RemovePlayerAttachedObject( params[0], 4 );
	
		togglePlayerControllable( params[0], true );	
	}	
	
	return 1;
}

CMD:unarrest( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_WOOD || !Player[playerid][uRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unarrest [ ID игрока ]");
	
	if( !IsLogged( params[0] ) || playerid == params[0] ) 
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( !Player[ params[0] ][uJail] )
		return SendClient:( playerid, C_WHITE, !""gbError"Этот игрок не находится в КПЗ." );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 5.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );
		
	new
		jail = Player[ params[0] ][uJail] - 1;
		
	setPlayerPos( params[0], 
		spawnJail[ jail ][pos_exit][0],
		spawnJail[ jail ][pos_exit][1],
		spawnJail[ jail ][pos_exit][2] );
	SetPlayerFacingAngle( params[0], spawnJail[jail][pos_exit][3] );
	
	Player[ params[0] ][uJail] = 0, 
	Player[ params[0] ][uJailTime] = 0;

	UpdatePlayer( params[0], "uJail", 0 ), 
	UpdatePlayer( params[0], "uJailTime", 0 );
	
	pformat:( ""gbSuccess"Вы выпустили "cBLUE"%s"cWHITE" из КПЗ.", Player[ params[0] ][uName] );
	psend:( playerid, C_WHITE );
	
	pformat:( ""gbSuccess""cBLUE"%s"cWHITE" выпустил Вас из КПЗ.", Player[playerid][uName] );
	psend:( params[0], C_WHITE );
		
	return 1;
}

CMD:su( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_POLICE && 
		Player[playerid][uMember] != FRACTION_WOOD && 
		Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = FRACTION_POLICE - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
	
	if( sscanf( params, "dds[64]", params[0], params[1], params[2] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /su [ id игрока ] [ 0 - снять / 1 - объявить ] [ причина ]" );
	
	if( !IsLogged( params[0] ) || params[0] == playerid )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	switch( params[1] )
	{
		case 0:
		{
			if( !Player[ params[0] ][uSuspect] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок не в розыске." );
			
			Player[ params[0] ][uSuspect] = 0;
			clean:<Player[ params[0] ][uSuspectReason]>;
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uSuspect` = 0, `uSuspectReason` = '' WHERE `uID` = %d LIMIT 1", Player[ params[0] ][uID] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Вы сняли розыск с "cBLUE"%s"cWHITE".", Player[ params[0] ][uRPName] );
			psend:( playerid, C_WHITE );
		}
		
		case 1:
		{
			if( Player[ params[0] ][uSuspect] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже находится в розыске." );
				
			if( strlen( params[2] ) < 1 || strlen( params[2] ) > 64 )
				return SendClient:( playerid, C_WHITE, !""gbError"Укажите корректно причину розыска." );
				
			Player[ params[0] ][uSuspect] = 1;
			
			clean:<Player[ params[0] ][uSuspectReason]>;
			strcat( Player[ params[0] ][uSuspectReason], params[2], 64 );
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uSuspect` = 1, `uSuspectReason` = '%e' WHERE `uID` = %d LIMIT 1", 
				Player[ params[0] ][uSuspectReason],
				Player[ params[0] ][uID] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Вы объявили в розыск "cBLUE"%s"cWHITE" c причиной "cBLUE"%s"cWHITE".", Player[ params[0] ][uRPName], Player[ params[0] ][uSuspectReason] );
			psend:( playerid, C_WHITE );
		}
	}
	
	return 1;
}

CMD:wanted( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_POLICE && 
		Player[playerid][uMember] != FRACTION_FBI &&
		Player[playerid][uMember] != FRACTION_WOOD || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = FRACTION_POLICE - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
	
	if( sscanf( params, "ds[24]", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /wanted [ 0 - снять / 1 - объявить ][ имя игрока ]" );
		
	new
		index = INVALID_PARAM;
	
	switch( params[0] )
	{
		case 0:
		{
			for( new i; i < MAX_SUSPECT; i++ )
			{
				if( SuspectPlayer[i][s_name][0] != EOS && !strcmp( SuspectPlayer[i][s_name], params[1], true ) )
				{
					index = i;
					break;
				}
			}
			
			if( index == INVALID_PARAM ) 
				return SendClient:( playerid, C_WHITE, !""gbError"Игрок с таким ником не находится в федеральном розыске." );
			
			SuspectPlayer[index][s_id] = 
			SuspectPlayer[index][s_date] = 0;
					
			SuspectPlayer[index][s_name][0] =
			SuspectPlayer[index][s_time_name][0] =
			SuspectPlayer[index][s_officer_name][0] =
			SuspectPlayer[index][s_descript][0] = EOS;
						
			mysql_format:g_small_string( "DELETE FROM `"DB_SUSPECT"` WHERE `s_name` LIKE '%e' ", params[1] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Вы сняли федеральный розыск с "cBLUE"%s"cWHITE".", params[1] );
			psend:( playerid, C_WHITE );
		}
		
		case 1:
		{
			for( new i; i < MAX_SUSPECT; i++ )
			{
				if( SuspectPlayer[i][s_name][0] != EOS && !strcmp( SuspectPlayer[i][s_name], params[1], true ) ) 
					return SendClient:( playerid, C_WHITE, !""gbError"Игрок с таким ником уже находится в федеральном розыске." );
			
				if( !SuspectPlayer[i][s_id] ) index = i;
			}
		
			if( index == INVALID_PARAM ) 
				return SendClient:( playerid, C_WHITE, !""gbError"В федеральном розыске слишком много преступников." );
			
			SetPVarInt( playerid, "Suspect:Index", index );
		
			clean:<SuspectPlayer[index][s_time_name]>;
			strcat( SuspectPlayer[index][s_time_name], params[1], 24 );
			
			format:g_small_string( "\
				"cWHITE"Объявить в федеральный розыск "cBLUE"%s\n\n\
				"cWHITE"Укажите причину:", SuspectPlayer[index][s_time_name] );
				
			return showPlayerDialog( playerid, d_police + 27, DIALOG_STYLE_INPUT, " ", g_small_string, "Объявить", "Закрыть" );
		}
		
		default: 
			return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /wanted [ 0 - снять / 1 - объявить ][ имя игрока ]" );
	}
	
	return 1;
}

CMD:carsu( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_POLICE &&
		Player[playerid][uMember] != FRACTION_WOOD &&
		Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid ),
		index = INVALID_PARAM,
		string_number[ 8 ];
			
	if( !FRank[fid][rank][r_add][5] && Player[playerid][uMember] == FRACTION_POLICE )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "s[8]d", string_number, params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /carsu [ гос. номер ] [ 0 - снять / 1 - объявить ] " );
	
	switch( params[0] )
	{
		case 0:
		{
			for( new i; i < MAX_SUSPECT; i++ )
			{
				if( SuspectVehicle[i][s_name][0] != EOS && !strcmp( SuspectVehicle[i][s_name], string_number, true ) )
				{
					index = i;
					break;
				}
			}
		
			if( index == INVALID_PARAM ) return SendClient:( playerid, C_WHITE, !""gbError"Автомобиль с таким гос. номером не находится в розыске." );
		
			SuspectVehicle[index][s_id] = 
			SuspectVehicle[index][s_date] = 0;
				
			SuspectVehicle[index][s_name][0] = 
			SuspectVehicle[index][s_officer_name][0] =
			SuspectVehicle[index][s_descript][0] = 0;
				
			mysql_format:g_small_string( "DELETE FROM `"DB_SUSPECT_VEHICLE"` WHERE `s_name` = '%e' LIMIT 1", string_number );
			mysql_tquery( mysql, g_small_string );
		
			pformat:( ""gbSuccess"Вы сняли розыск с автомобиля гос. номер "cBLUE"%s"cWHITE".", string_number );
			psend:( playerid, C_WHITE );
		}
		
		case 1:
		{
			for( new i; i < MAX_SUSPECT; i++ )
			{
				if( SuspectVehicle[i][s_name][0] != EOS && !strcmp( SuspectVehicle[i][s_name], string_number, true ) ) 
				{
					return SendClient:( playerid, C_WHITE, !""gbError"Автомобиль с таким гос. номером уже находится в розыске." );
				}
			
				if( !SuspectVehicle[i][s_id] ) index = i;
			}

			if( index == INVALID_PARAM ) 
				return SendClient:( playerid, C_WHITE, !""gbError"В розыске слишком много транспорта." );
			
			SetPVarInt( playerid, "CarSuspect:Index", index );
			
			clean:<SuspectVehicle[index][s_name]>;
			strcat( SuspectVehicle[index][s_name], string_number, 8 );
			
			format:g_small_string( "\
				"cWHITE"Объявить в федеральный розыск транспорт гос. номер "cBLUE"%s\n\n\
				"cWHITE"Укажите причину:", SuspectVehicle[index][s_name] );
				
			showPlayerDialog( playerid, d_police + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Объявить", "Закрыть" );
		}
		
		default:
			SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /carsu [ гос. номер ] [ 0 - снять / 1 - объявить ]" );
	}
		
	return 1;
}

CMD:takelic( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_POLICE || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	new
		fid = FRACTION_POLICE - 1,
		rank = getRankId( playerid, fid ),
		bool:flag = false,
		count,
		year, month, day;
			
	if( !FRank[fid][rank][r_add][5] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /takelic [ id игрока ]" );
		
	if( !IsLogged( params[0] ) || params[0] == playerid )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );
		
	clean:<g_string>;
	
	strcat( g_string, ""cWHITE"Тип лицензии\tДата получения" );
		
	for( new i; i < MAX_LICENSES; i++ )
	{
		if( License[ params[0] ][i][lic_id] )
		{
			format:g_small_string( "\n%s", getLicenseName[ License[ params[0] ][i][lic_type] - 1 ] );
			strcat( g_string, g_small_string );
			
			gmtime( License[ params[0] ][i][lic_gave_date], year, month, day );
			
			format:g_small_string( "\t%02d.%02d.%d", day, month, year );
			strcat( g_string, g_small_string );
		
			g_dialog_select[playerid][count] = i;
			count++;
			
			flag = true;
		}
	}

	if( !flag ) return SendClient:( playerid, C_WHITE, !""gbError"У данного игрока нет лицензий." );
	
	SetPVarInt( playerid, "Police:Takeid", params[0] );
	showPlayerDialog( playerid, d_police + 21, DIALOG_STYLE_TABLIST_HEADERS, "Изъять", g_string, "Выбрать", "Закрыть" );
	
	return 1;
}