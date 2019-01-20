CMD:fpanel( playerid )
{
	if( !Player[playerid][uMember] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = Player[playerid][uMember] - 1;
		
	format:g_small_string( ""cBLUE"%s", Fraction[fid][f_name] );
	showPlayerDialog( playerid, d_fpanel, DIALOG_STYLE_LIST, g_small_string, fpanel_dialog, "Выбрать", "Закрыть" );

	return 1;
}

CMD:fixcar( playerid, params[] )
{
	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в организации." );
		
	if( sscanf( params,"d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /fixcar [ id транспортного средства (/dl)]" );
		
	if( Player[playerid][uMember] )
	{
		if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
	
		if( !Player[playerid][uRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_spawnveh] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
		next:
			
		if( Vehicle[params[0]][vehicle_member] != Player[playerid][uMember] )
			return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
			
		if( IsVehicleOccupied( params[0] ) )
			return SendClient:( playerid, C_WHITE, !""gbError"Данный транспорт используется." );
			
		SetVehicleZAngle( params[0], Vehicle[params[0]][vehicle_pos][3] );
		setVehiclePos( params[0], 
			Vehicle[ params[0] ][vehicle_pos][0],
			Vehicle[ params[0] ][vehicle_pos][1],
			Vehicle[ params[0] ][vehicle_pos][2]
		);
			
		LinkVehicleToInterior( params[0], Vehicle[ params[0] ][vehicle_int] );
		SetVehicleVirtualWorld( params[0], Vehicle[ params[0] ][vehicle_world] );
			
		ResetVehicleParams( params[0] );
			
		pformat:( ""gbSuccess"Транспорт "cBLUE"%s[%d]"cWHITE" возвращен на парковочное место.", GetVehicleModelName( Vehicle[params[0]][vehicle_model] ), params[0] );
		psend:( playerid, C_WHITE );
		
		format:g_small_string( ""FRACTION_PREFIX" %s[%d] вернул транспорт %s[%d] на парковочное место.", Player[playerid][uName], playerid, GetVehicleModelName( Vehicle[ params[0] ][vehicle_model] ), params[0] );
		SendLeaderMessage( Player[playerid][uMember] - 1, C_DARKGRAY, g_small_string );
	}
	else if( Player[playerid][uCrimeM] )
	{
		new
			crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
			rank;
			
		if( PlayerLeaderCrime( playerid, crime ) ) goto next_crime;
		
		if( !Player[playerid][uCrimeRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
		rank = getCrimeRankId( playerid, crime );
			
		if( !CrimeRank[crime][rank][r_spawnveh] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
		next_crime:
			
		if( Vehicle[ params[0] ][vehicle_crime] != Player[playerid][uCrimeM] )
			return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
			
		if( IsVehicleOccupied( params[0] ) )
			return SendClient:( playerid, C_WHITE, !""gbError"Данный транспорт используется." );
		
		SetVehicleZAngle( params[0], Vehicle[params[0]][vehicle_pos][3] );
		setVehiclePos( params[0], 
			Vehicle[ params[0] ][vehicle_pos][0],
			Vehicle[ params[0] ][vehicle_pos][1],
			Vehicle[ params[0] ][vehicle_pos][2]
		);
			
		LinkVehicleToInterior( params[0], Vehicle[ params[0] ][vehicle_int] );
		SetVehicleVirtualWorld( params[0], Vehicle[ params[0] ][vehicle_world] );
			
		ResetVehicleParams( params[0] );
			
		pformat:( ""gbSuccess"Транспорт "cBLUE"%s[%d]"cWHITE" возвращен на парковочное место.", GetVehicleModelName( Vehicle[params[0]][vehicle_model] ), params[0] );
		psend:( playerid, C_WHITE );
		
		format:g_small_string( ""FRACTION_PREFIX" %s[%d] вернул транспорт %s[%d] на парковочное место.", Player[playerid][uName], playerid, GetVehicleModelName( Vehicle[ params[0] ][vehicle_model] ), params[0] );
		SendCrimeLeaderMessage( crime, C_DARKGRAY, g_small_string );
	}

	return 1;
}

CMD:fixcarall( playerid )
{
	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в организации." );
		
	if( Player[playerid][uMember] )
	{
		if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
	
		if( !Player[playerid][uRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_spawnveh] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
			
		next:
		
		showPlayerDialog( playerid, d_fpanel + 44, DIALOG_STYLE_MSGBOX, " ", "\
			"cWHITE"Вы действительно желаете вернуть весь неиспользуемый транспорт\n\
			Вашей организации на парковочные места?",
			"Да", "Нет" );
	}
	else if( Player[playerid][uCrimeM] )
	{
		new
			crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
			rank;
			
		if( PlayerLeaderCrime( playerid, crime ) ) goto next_crime;
		
		if( !Player[playerid][uCrimeRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
		rank = getCrimeRankId( playerid, crime );
			
		if( !CrimeRank[crime][rank][r_spawnveh] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
			
		next_crime:
		
		showPlayerDialog( playerid, d_crime + 27, DIALOG_STYLE_MSGBOX, " ", "\
			"cWHITE"Вы действительно желаете вернуть весь неиспользуемый транспорт\n\
			Вашей организации на парковочные места?",
			"Да", "Нет" );
	}

	return 1;
}

CMD:park( playerid, params[] )
{
	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в организации." );
		
	if( sscanf( params,"d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /park [ id транспортного средства (/dl)]" );
		
	if( Player[playerid][uMember] )
	{
		if( !PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) )
			return SendClient:( playerid, C_WHITE, !NO_LEADER );	
			
		if( Vehicle[params[0]][vehicle_member] != Player[playerid][uMember] )
			return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
			
		if( !IsPlayerInVehicle( playerid, params[0] ) && GetVehicleModel( params[0] ) != 591 && GetVehicleModel( params[0] ) != 584 )
			return SendClient:( playerid, C_WHITE, !""gbError"Для совершения данного действия Вы должны находиться в транспорте." );
			
		format:g_small_string( "\
			"cWHITE"Припарковать транспорт "cBLUE"%s[%d]\n\n\
			"cWHITE"Вы действительно желаете припарковать транспорт в этом месте?", GetVehicleModelName( Vehicle[params[0]][vehicle_model] ), params[0] );
			
		showPlayerDialog( playerid, d_fpanel + 29, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		SetPVarInt( playerid, "Fraction:VId", params[0] );
	}
	else if( Player[playerid][uCrimeM] )
	{
		new
			crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );

		if( !PlayerLeaderCrime( playerid, crime ) )
			return SendClient:( playerid, C_WHITE, !NO_LEADER );
			
		if( Vehicle[ params[0] ][vehicle_crime] != Player[playerid][uCrimeM] )
			return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
			
		if( !IsPlayerInVehicle( playerid, params[0] ) )
			return SendClient:( playerid, C_WHITE, !""gbError"Для совершения данного действия Вы должны находиться в транспорте." );
			
		format:g_small_string( "\
			"cWHITE"Припарковать транспорт "cBLUE"%s[%d]\n\n\
			"cWHITE"Вы действительно желаете припарковать транспорт в этом месте?", GetVehicleModelName( Vehicle[params[0]][vehicle_model] ), params[0] );
			
		showPlayerDialog( playerid, d_crime + 29, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		SetPVarInt( playerid, "Crime:VId", params[0] );
	}
	
	return 1;
}

CMD:setrank( playerid, params[] )
{
	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в организации." );

	if( Player[playerid][uMember] )
	{
		if( !PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) )
			return SendClient:( playerid, C_WHITE, !NO_LEADER );
		
		if( sscanf( params,"d", params[0] ) ) 
			return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /setrank [ id игрока ]" );
		
		if( !IsLogged( params[0] ) )	
			return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
			
		if( Player[ params[0] ][uMember] != Player[playerid][uMember] )
		{
			pformat:( ""gbError"Игрок не состоит в "cBLUE"%s"cWHITE".", Fraction[Player[playerid][uMember] - 1][f_name] );
			psend:( playerid, C_WHITE );
			
			return 1;
		}

		SetPVarInt( playerid, "Fraction:PlayerID", params[0] );	
		g_player_interaction{playerid} = 1;
		
		ShowFractionRanks( playerid, Player[playerid][uMember] - 1, d_fpanel + 38, "Закрыть" );
	}
	else
	{
		new
			crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
	
		if( !PlayerLeaderCrime( playerid, crime ) )
			return SendClient:( playerid, C_WHITE, !NO_LEADER );
		
		if( sscanf( params,"d", params[0] ) ) 
			return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /setrank [ id игрока ]" );
		
		if( !IsLogged( params[0] ) )	
			return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
			
		if( Player[ params[0] ][uCrimeM] != Player[playerid][uCrimeM] )
		{
			pformat:( ""gbError"Игрок не является членом криминальной структуры "cBLUE"%s"cWHITE".", CrimeFraction[crime][c_name] );
			psend:( playerid, C_WHITE );
			
			return 1;
		}

		SetPVarInt( playerid, "Crime:PlayerID", params[0] );	
		g_player_interaction{playerid} = 1;
		
		ShowCrimeRanks( playerid, crime, d_crime + 12, "Закрыть" );
	}

	return 1;
}

CMD:invite( playerid, params[] )
{
	if( g_player_interaction{playerid} )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в организации." );

	if( sscanf( params,"d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /invite [ id игрока ]" );
		
	if( !IsLogged( params[0] ) )	
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( g_player_interaction{ params[0] } )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_INTERACTION );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );
		
	if( Player[ params[0] ][uMember] )
	{
		pformat:( ""gbError"Игрок уже состоит в "cBLUE"%s"cWHITE".", Fraction[Player[ params[0] ][uMember] - 1][f_name] );
		psend:( playerid, C_WHITE );
		
		return 1;
	}
	
	if( Player[ params[0] ][uCrimeM] )
	{
		pformat:( ""gbError"Игрок уже состоит в "cBLUE"%s"cWHITE".", CrimeFraction[ getIndexCrimeFraction( Player[ params[0] ][uCrimeM] ) ][c_name] );
		psend:( playerid, C_WHITE );
		
		return 1;
	}
		
	if( Player[playerid][uMember] )
	{
		new
			fid = Player[playerid][uMember] - 1,
			rank;
	
		if( PlayerLeaderFraction( playerid, fid ) ) goto fnext;
		
		if( !Player[playerid][uRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
		rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_invite] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

		fnext:
		
		if( Fraction[fid][f_members] >= MAX_MEMBERS )
			return SendClient:( playerid, C_WHITE, !""gbDialog"Превышен количественный лимит членов в организации." );
		
		SetPVarInt( playerid, "Fraction:PlayerID", params[0] );	
		g_player_interaction{playerid} = 1;
		
		ShowFractionRanks( playerid, fid, d_fpanel + 39, "Закрыть" );
	}
	else if( Player[playerid][uCrimeM] )
	{
		new
			crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
			rank;
	
		if( PlayerLeaderCrime( playerid, crime ) ) goto next;
		
		if( !Player[playerid][uCrimeRank] )
			SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
		rank = getCrimeRankId( playerid, crime );
			
		if( !CrimeRank[crime][rank][r_invite] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

		next:
		
		if( CrimeFraction[crime][c_members] >= MAX_MEMBERS )
			return SendClient:( playerid, C_WHITE, !""gbDialog"Превышен количественный лимит членов в криминальной структуре." );
		
		SetPVarInt( playerid, "Crime:PlayerID", params[0] );	
		g_player_interaction{playerid} = 1;
		
		ShowCrimeRanks( playerid, crime, d_crime + 13, "Закрыть" );
	}
		
	return 1;
}

CMD:uninvite( playerid )
{
	if( g_player_interaction{playerid} )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в организации." );

	if( Player[playerid][uMember] )
	{
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid );
	
		if( PlayerLeaderFraction( playerid, fid ) ) goto fnext;
		
		if( !Player[playerid][uRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
			
		if( !FRank[fid][rank][r_uninvite] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

		fnext:
		
		g_player_interaction{playerid} = 1;
		showPlayerDialog( playerid, d_fpanel + 41, DIALOG_STYLE_LIST, " ", ""cWHITE"\
			Уволить по ID игрока\n\
			Уволить по номеру аккаунта", "Выбрать", "Закрыть" );
	}
	else if( Player[playerid][uCrimeM] )
	{
		new
			crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
			rank = getCrimeRankId( playerid, crime );
			
		if( PlayerLeaderFraction( playerid, crime )	) goto next;
		
		if( !Player[playerid][uCrimeRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
			
		if( !CrimeRank[crime][rank][r_uninvite] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

		next:
		
		g_player_interaction{playerid} = 1;
		showPlayerDialog( playerid, d_crime + 15, DIALOG_STYLE_LIST, " ", ""cWHITE"\
			Исключить по ID игрока\n\
			Исключить по номеру аккаунта", "Выбрать", "Закрыть" );
	}

	return 1;
}

CMD:accept( playerid )
{
	if( !Player[playerid][uMember] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в организации." );
		
	if( Player[playerid][uMember] == FRACTION_NEWS || Player[playerid][uMember] == FRACTION_CITYHALL || !Player[playerid][uMember] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid );
		
	if( !FRank[fid][rank][r_add][0] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	ShowEmergencyCall( playerid, Player[playerid][uMember] );

	return 1;
}

CMD:bk( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_FIRE || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( GetPVarInt( playerid, "Fraction:UseBK" ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Вы уже вызвали поддержку, отмените текущий запрос /unbk." );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid );
		
	if( !FRank[fid][rank][r_add][0] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params,"d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /bk [ 1 - POLICE, 2 - FIRE, 3 - POLICE&FIRE ]" );
		
	if( params[0] < 1 || params[0] > 3 )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /bk [ 1 - POLICE, 2 - FIRE, 3 - POLICE&FIRE ]" );
		
	switch( params[0] )
	{
		case 1: format:g_small_string( "[CH: 911] Диспетчер: %s %s запрашивает поддержку полицейского департамента.", 
					FRank[fid][rank][r_name],
					Player[playerid][uRPName]
				);
		case 2: format:g_small_string( "[CH: 911] Диспетчер: %s %s запрашивает поддержку пожарного департамента.", 
					FRank[fid][rank][r_name],
					Player[playerid][uRPName]
				);
		case 3: format:g_small_string( "[CH: 911] Диспетчер: %s %s запрашивает поддержку пожарного и полицейского департаментов.", 
					FRank[fid][rank][r_name],
					Player[playerid][uRPName]
				);
	}
	
	SendEmergencyMessage( playerid, params[0], g_small_string );
	
	SendClient:( playerid, C_WHITE, ""gbDefault"Введите /unbk, чтобы отменить ваш запрос на поддержку." );
	SetPVarInt( playerid, "Fraction:UseBK", 1 );

	return 1;
}

CMD:unbk( playerid )
{
	if( !GetPVarInt( playerid, "Fraction:UseBK" ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	BackupClear( playerid );
	SetPlayerColor( playerid, 0xFFFFFF00 );
	SendClient:( playerid, C_WHITE, ""gbSuccess"Вы отменили запрос о поддержке." );

	return 1;
}

CMD:re( playerid, params[] )
{
	if( IsMuted( playerid, IC ) )
		return SendClient:( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( !getItem( playerid, INV_SPECIAL, PARAM_RADIO ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует рация." );
		
	if( Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_FIRE &&
		Player[playerid][uMember] != FRACTION_HOSPITAL && Player[playerid][uMember] != FRACTION_FBI &&
		Player[playerid][uMember] != FRACTION_WOOD || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid );
		
	if( !FRank[fid][rank][r_add][0] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( isnull( params ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /re [ текст ]" );

	format:g_small_string( "[CH: 911] %s: %s", 
		Player[playerid][uRPName], 
		params
	);
	
	foreach(new i : Player)
	{
		if( !IsLogged( i )  || !Player[i][uRank] ) continue;
				
		if( Player[i][uMember] != FRACTION_POLICE && 
			Player[i][uMember] != FRACTION_FIRE && 
			Player[i][uMember] != FRACTION_FBI && 
			Player[i][uMember] != FRACTION_WOOD && 
			Player[i][uMember] != FRACTION_HOSPITAL ) continue;
				
		if( !FRank[ Player[i][uMember] - 1 ][getRankId( i, Player[i][uMember] - 1 )][r_add][0] ) continue;
		
		if( !getItem( i, INV_SPECIAL, PARAM_RADIO ) ) continue;

		SendClient:( i, C_LIGHTBLUE, g_small_string );
		PlayerPlaySound( i, 6400, 0, 0, 0 );
	}
	
	format:g_small_string( ""gbRadio"%s: %s", Player[playerid][uRPName], params );
	ProxDetector( 8.0, playerid, g_small_string, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, 2, 1 );
	
	return 1;
}

CMD:f( playerid, params[] ) 
{
	if( IsMuted( playerid, OOC ) )
		return SendClient:( playerid, C_WHITE, !CHAT_MUTE_OOC );
		
	if( isnull( params ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /f [ текст ]" );
	
	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	format:g_small_string("(( "FRACTION_PREFIX" %s[%d]: %s ))",
		Player[playerid][uName],
		playerid,
		params
	);
	
	if( Player[playerid][uMember] )
	{
		foreach(new i : Player) 
		{
			if( !IsLogged( i ) || !Player[i][uMember] || !Player[i][uRO] ) continue;
				
			if( Player[i][uMember] != Player[playerid][uMember] ) continue;

			SendClient:( i, 0x6699FFAA, g_small_string );
		}
	}
	else
	{
		foreach(new i : Player) 
		{
			if( !IsLogged( i ) || !Player[i][uCrimeM] || !Player[i][uRO] ) continue;
				
			if( Player[i][uCrimeM] != Player[playerid][uCrimeM] ) continue;

			SendClient:( i, 0x6699FFAA, g_small_string );
		}
	}
	
	return 1;
}

CMD:color( playerid, params[] )
{
	if( !Player[playerid][uMember] && !Player[playerid][uRank] && !Player[playerid][uCrimeM] && !Player[playerid][uCrimeRank] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( sscanf( params, "d", params[0] ) )  
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /color [ 0 - снять, 1 - установить ]" );
		
	if( params[0] < 0 || params[0] > 1 )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /color [ 0 - снять, 1 - установить ]" );
		
	if( !params[0] ) 
	{
		SetPlayerColor( playerid, 0xFFFFFF00 );
		SendClient:( playerid, C_WHITE, ""gbDefault"Цвет клиста установлен по умолчанию." );
	}
	else
	{
		if( Player[playerid][uMember] )
		{
			SetPlayerColor( playerid, FracColor[0][ Player[playerid][uMember] - 1 ] );
		}
		else
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
		
			SetPlayerColor( playerid, FracColor[1][ crime ] );
		}
		
		SendClient:( playerid, C_WHITE, ""gbDefault"Цвет клиста установлен." );
	}	
	
	return 1;
}

CMD:heal( playerid, params[] )
{		
	if( GetPVarInt( playerid, "Inv:Show" ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );

	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /heal [ id игрока ] [ 0 - аптечка / 1 - сумка ALS ]" );
		
	if( params[1] != 0 && params[1] != 1 )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /heal [ id игрока ] [ 0 - аптечка / 1 - сумка ALS ]" );
	
	if( !IsLogged( params[0] ) || params[0] == playerid ) 
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Player[ params[0] ][uJailSettings][2] != 0 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данный персонаж уже проходит реабилитацию." );
	
	if( Player[ params[0] ][uDeath] == 2 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данный персонаж мёртв, его невозможно вылечить." );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 5.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );
	
	switch( params[1] )
	{
		case 0:
		{
			if( Player[ params[0] ][uDeath] == 1 ) 
				return SendClient:( playerid, C_WHITE, !""gbError"Данный персонаж ранен, аптечку использовать невозможно." );
		
			if( !getItem( playerid, INV_SPECIAL, PARAM_MEDIC ) )
				return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет с собой аптечки." );
				
			useSpecialItem( playerid, PARAM_MEDIC );
			SendClient:( playerid, C_WHITE, ""gbSuccess"Вы использовали аптечку." );
							
			format:g_small_string( "использовал%s аптечку", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
			
			ClearAnimations( playerid );
			ApplyAnimation( playerid, "MEDIC", "CPR", 4.0, 0, 1, 1, 0, 0, 1 );
			
			if( Player[ params[0] ][ uHP ] + 50.0 < 100.0 ) setPlayerHealth( params[0], Player[ params[0] ][ uHP ] + 50.0 );
			else HealthPlayer( params[0] );
		}
		
		case 1:
		{
			if( Player[playerid][uMember] != FRACTION_FIRE && Player[playerid][uMember] != FRACTION_SADOC && 
				Player[playerid][uMember] != FRACTION_HOSPITAL || !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
				
			new
				fid = Player[playerid][uMember] - 1,
				rank = getRankId( playerid, fid );
				
			if( !FRank[fid][rank][r_medic] )
				return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
				
			if( !getItem( playerid, INV_SPECIAL, PARAM_BLS ) )
				return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет с собой сумки ALS." );
				
			useSpecialItem( playerid, PARAM_BLS );
			SendClient:( playerid, C_WHITE, ""gbSuccess"Вы использовали сумку ALS." );
							
			format:g_small_string( "использовал%s сумку ALS", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
			
			ClearAnimations( playerid );
			ApplyAnimation( playerid, "MEDIC", "CPR", 4.0, 0, 1, 1, 0, 0, 1 );
				
			HealthPlayer( params[0] );
		}
	}
	
	return 1;
}

CMD:m( playerid, params[] )
{
	if( IsMuted( playerid, IC ) )
		return SendClient:( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( Player[playerid][uMember] != FRACTION_FIRE && Player[playerid][uMember] != FRACTION_SADOC && 
		Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_HOSPITAL &&
		Player[playerid][uMember] != FRACTION_WOOD && Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( !IsPlayerInAnyVehicle( playerid ) ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new 
		vehicleid = GetPlayerVehicleID( playerid ),
		fid,
		rank;
		
	if( IsVelo( vehicleid ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Vehicle[vehicleid][vehicle_member] != Player[playerid][uMember] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы находитесь не в служебном транспорте." );
	
	if( sscanf( params, "s[128]", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /m [ текст ]" );
	
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid );
		
		if( !FRank[fid][rank][r_add][5] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
	
	format:g_small_string( "[Мегафон %s] %s: %s", Fraction[ Player[playerid][uMember] - 1 ][f_short_name], Player[playerid][uRPName], params[0] );
	ProxDetector( 30.0, playerid, g_small_string, C_YELLOW, C_YELLOW, C_YELLOW, C_YELLOW, C_YELLOW );
	PlayerPlaySoundEx( playerid, 21001 );
	
	return 1;
}

CMD:callsign( playerid, params[] ) 
{
	new
		vehicleid,
		rank;

	if( Player[playerid][uMember] != FRACTION_FIRE && Player[playerid][uMember] != FRACTION_SADOC && 
		Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_FBI &&
		Player[playerid][uMember] != FRACTION_WOOD || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerState( playerid ) != PLAYER_STATE_DRIVER ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	vehicleid = GetPlayerVehicleID( playerid );
	
	if( IsVelo( vehicleid ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( Vehicle[vehicleid][vehicle_member] != Player[playerid][uMember] || Vehicle[vehicleid][vehicle_user_id] != INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы находитесь не в служебном транспорте." );
		
	if( IsValidDynamic3DTextLabel( Vehicle[vehicleid][vehicle_callsign] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"На этом транспорте уже установлена маркировка. Используйте /dsign для удаления." );
	
	if( sscanf( params, "s[64]", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /callsign [ текст ]" );
		
	Vehicle[vehicleid][vehicle_callsign] = CreateDynamic3DTextLabel( params[0], 0xFFFFFF50, -1.0, -2.8, 0.0, 30.0, INVALID_PLAYER_ID, vehicleid );
	
	rank = getRankId( playerid, Player[playerid][uMember] - 1 );
	format:g_small_string( ""FRACTION_PREFIX"%s %s установил маркировку [%d]: %s ", FRank[ Player[playerid][uMember] - 1 ][rank][r_name], Player[ playerid ][uName], vehicleid, params[0] );
	
	SendLeaderMessage( Player[playerid][uMember] - 1, C_DARKGRAY, g_small_string );
	
	//mysql_format:g_string( "UPDATE `"DB_VEHICLES"` SET `vehicle_callsign` = '%s' WHERE `vehicle_id` = %d", params[0], Vehicle[vehicleid][vehicle_id] );
	//mysql_tquery( mysql, g_string );
	
	pformat:( ""gbSuccess"Вы установили маркировку на "cBLUE"%s"cWHITE". Используйте /dsign для удаления.", GetVehicleModelName( GetVehicleModel( vehicleid ) ) );
	psend:( playerid, C_WHITE );
	
	return 1;
}

CMD:dsign( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_FIRE && Player[playerid][uMember] != FRACTION_SADOC && 
		Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_WOOD && 
		Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /dsign [ id авто ]" );
		
	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_VEHICLEID );
		
	if( Vehicle[ params[0] ][vehicle_member] != Player[playerid][uMember] || Vehicle[ params[0] ][vehicle_user_id] != INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
		
	if( !IsValidDynamic3DTextLabel( Vehicle[ params[0] ][vehicle_callsign] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"На этом транспорте не установлена маркировка." );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid ),
		Float:x, Float:y, Float:z;
		
	if( PlayerLeaderFraction( playerid, fid ) )
	{
		DestroyDynamic3DTextLabel( Vehicle[ params[0] ][vehicle_callsign] );
		Vehicle[ params[0] ][vehicle_callsign] = Text3D: INVALID_3DTEXT_ID;
	}
	else
	{
		GetVehiclePos( params[0], x, y, z );
		
		if( GetPlayerDistanceFromPoint( playerid, x, y, z ) > 10.0 || GetPlayerVirtualWorld( playerid ) != GetVehicleVirtualWorld( params[0] ) )
			return SendClient:( playerid, C_WHITE, !""gbError"Данного транспорта нет рядом с Вами." );
			
		DestroyDynamic3DTextLabel( Vehicle[ params[0] ][vehicle_callsign] );
		Vehicle[ params[0] ][vehicle_callsign] = Text3D: INVALID_3DTEXT_ID;
		
		format:g_small_string( ""FRACTION_PREFIX"%s %s удалил маркировку на %s[%d].", FRank[fid][rank][r_name], Player[ playerid ][uName], GetVehicleModelName( Vehicle[ params[0] ][vehicle_model] ), params[0] );
		SendLeaderMessage( Player[playerid][uMember] - 1, C_DARKGRAY, g_small_string );
	}
	
	mysql_format:g_string( "UPDATE `"DB_VEHICLES"` SET `vehicle_callsign` = '' WHERE `vehicle_id` = %d", Vehicle[ params[0] ][vehicle_id] );
	mysql_tquery( mysql, g_string );
	
	pformat:( ""gbSuccess"Вы удалили маркировку на "cBLUE"%s"cWHITE".", GetVehicleModelName( Vehicle[ params[0] ][vehicle_model] ) );
	psend:( playerid, C_WHITE );

	return 1;
}

CMD:spu( playerid )
{
	new
		vehicleid,
		fid,
		rank;

	if( Player[playerid][uMember] != FRACTION_FIRE && Player[playerid][uMember] != FRACTION_WOOD && Player[playerid][uMember] != FRACTION_FBI &&
		Player[playerid][uMember] != FRACTION_POLICE && Player[playerid][uMember] != FRACTION_CITYHALL || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		fid = Player[playerid][uMember] - 1;
		rank = getRankId( playerid, fid );
		
		if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_mechanic] ) return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}

	if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerState( playerid ) != PLAYER_STATE_DRIVER ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	vehicleid = GetPlayerVehicleID( playerid );
		
	if( Vehicle[vehicleid][vehicle_member] != Player[playerid][uMember] || !Vehicle[vehicleid][vehicle_member] )
		return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
		
	if( IsValidDynamicObject( Vehicle[vehicleid][vehicle_siren][0] ) ) 
	{
		for( new i; i < 6; i++ )
		{
			if( IsValidDynamicObject( Vehicle[vehicleid][vehicle_siren][i] ) )
			{			
				DestroyDynamicObject( Vehicle[vehicleid][vehicle_siren][i] );
				Vehicle[vehicleid][vehicle_siren][i] = 0;
			}
		}
		
		pformat:( ""gbDefault"Вы убрали мигалку с %s.", GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ) );
		psend:( playerid, C_WHITE );
		
		return 1;
	}
	else 
	{
		if( !InstallSpuToVehicle( vehicleid ) )
			return SendClient:( playerid, C_WHITE, !""gbError"На данный транспорт невозможно установить мигалку." );
	}
	
	pformat:( ""gbDefault"Вы уcтановили мигалку на %s.", GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ) );
	psend:( playerid, C_WHITE );
	
	return 1;
}

CMD:frepair( playerid, params[] )
{
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid ),
		Float:pX,
		Float:pY,
		Float:pZ;
		
	if( !FRank[fid][rank][r_mechanic] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !IsPlayerInDynamicArea( playerid, area_gov_repair[0] ) && !IsPlayerInDynamicArea( playerid, area_gov_repair[1] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться на территории гос. СТО" );
		
	if( GetPVarInt( playerid, "Mech:VId" ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы уже занимаетесь ремонтом." );
		
	if( sscanf( params, "i", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /frepair [ id машины в /dl ]" );
		
	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Некорректный id автомобиля." );
		
	if( Vehicle[ params[0] ][vehicle_user_id] != INVALID_PARAM || VehicleInfo[GetVehicleModel( params[0] ) - 400][v_repair] == INVALID_PARAM	)
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете отремонтировать этот транспорт." );
		
	GetPlayerPos( playerid, pX, pY, pZ );
	
	if( GetVehicleDistanceFromPoint( params[0], pX, pY, pZ ) > 5.0 )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы слишком далеко от машины." ); 
		
	format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( GetVehicleModel( params[0] ) ) );	
	showPlayerDialog( playerid, d_frac + 2, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
		Двигатель\n\
		Кузов\n\
		Фары\n\
		Покрышки\n\
		Комплексный ремонт",
	"Выбрать", "Закрыть" );
	
	SetPVarInt( playerid, "Mech:VId", params[0] );

	return 1;
}

CMD:ftow( playerid, params[] )
{
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid ),
		Float:pX,
		Float:pY,
		Float:pZ;
		
	if( !FRank[fid][rank][r_mechanic] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerState( playerid ) != PLAYER_STATE_DRIVER ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 525 ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Vehicle[ GetPlayerVehicleID(playerid) ][vehicle_member] != Player[playerid][uMember] )
		return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
		
	if( sscanf( params, "i", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /ftow [ id машины в /dl ]" );
		
	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_VEHICLEID );
		
	GetPosVehicleBoot( GetPlayerVehicleID( playerid ), pX, pY, pZ );
	
	if( GetVehicleDistanceFromPoint( params[0], pX, pY, pZ ) > 5.0 )	
		return SendClient:( playerid, C_WHITE, ""gbError"Вы слишком далеко от машины." ); 
		
	AttachTrailerToVehicle( params[0], GetPlayerVehicleID( playerid ) ); 

	return 1;
}

CMD:mic( playerid, params[] )
{
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( sscanf( params, "s[256]", params[0] ) ) 
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"Введите: /mic [ текст ]" );
		
	format:g_small_string( "[Микрофон] %s: %s", Player[playerid][uRPName], params[0] );
	ProxDetector( 30.0, playerid, g_small_string, C_ORANGE, C_ORANGE, C_ORANGE, C_ORANGE, C_ORANGE );
	
	return 1;
}

CMD:object( playerid )
{
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid );
		
	if( !FRank[fid][rank][r_object] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	clean:<g_big_string>;
	
	for( new i; i < 30; i++ )
	{
		if( f_objects[ fid ][i][obj_name][0] == EOS ) continue;
		
		format:g_small_string( ""cBLUE"%d. "cGRAY"%s\n",
			i + 1,
			f_objects[ fid ][i][obj_name]
		);
		
		strcat( g_big_string, g_small_string );
	}
	
	showPlayerDialog( playerid, d_fobject, DIALOG_STYLE_LIST, "Объекты", g_big_string, "Выбрать", "Закрыть" );
	return 1;
}

CMD:dobject( playerid, params[] )
{
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid );
		
	if( !FRank[fid][rank][r_object] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
	{
		return showPlayerDialog( playerid, d_fobject + 1, DIALOG_STYLE_LIST, "Удалить объект", 
			""cBLUE"1. "cGRAY"Удаление по ID: /dobject [ id ]\n\
			"cBLUE"2. "cGRAY"Удалить объект по клику",
			"Выбрать", "Закрыть"
		);
	}
	
	params[0]--;
	
	if( params[0] < 0 || params[0] > MAX_OBJECT )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы ввели неверный ID объекта." );
		
	if( !Object[ fid ][params[0]][f_object_id] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы ввели неверный ID объекта." );
	
	for( new i; i < MAX_OBJECT; i++ ) 
	{
		if( !Object[ fid ][i][f_object_id] )
			continue;
			
		if( Object[ fid ][ params[0] ][f_object] == Object[ fid ][i][f_object] )
		{
			if( IsValidDynamicObject( Object[ fid ][i][f_object] ) )
			{
				DestroyDynamicObject( Object[ fid ][i][f_object] );
			}
			
			DestroyDynamic3DTextLabel( Object[ fid ][i][f_object_text] );
			Object[ fid ][i][f_object_text] = Text3D: INVALID_3DTEXT_ID;
						
			ClearFObjectData( fid, i );
			CancelEdit( playerid );
			
			pformat:( ""gbSuccess"Вы удалили объект с ID: "cBLUE"%d", params[0] + 1 );
			psend:( playerid, C_WHITE );
			
			break;
		}
	}
	
	return 1;
}

CMD:attach( playerid )
{
	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( Player[playerid][uMember] )
	{
		if( !Player[playerid][uRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
			
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid ),
			bool:flag;
			
		if( !FRank[fid][rank][r_attach] ) 
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

		clean:<g_big_string>;
			
		for( new i; i < 30; i++ )
		{
			if( f_attach[fid][i][f_a_name][0] == EOS ) 
			{
				flag = true;
				
				SetPVarInt( playerid, "FAttach:Delete", i );
				strcat( g_big_string, ""cBLUE"— Удалить объекты" );
				
				break;
			}
		
			format:g_small_string( ""cBLUE"%d. "cGRAY"%s\n", 
				i + 1,
				f_attach[fid][i][f_a_name]
			);
			
			strcat( g_big_string, g_small_string );
		}
		
		if( !flag )
		{
			SetPVarInt( playerid, "FAttach:Delete", 30 );
			strcat( g_big_string, ""cBLUE"— Удалить объекты" );
		}
		
		showPlayerDialog( playerid, d_attach, DIALOG_STYLE_LIST, " ", g_big_string, "Выбрать", "Закрыть" );
	}
	else
	{
		if( !Player[playerid][uCrimeRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
			
		new
			crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
			rank = getRankId( playerid, crime );
			
		if( !CrimeRank[crime][rank][r_attach] ) 
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

		clean:<g_big_string>;
			
		for( new i; i < sizeof crime_attach; i++ )
		{
			if( i == sizeof crime_attach - 1 ) 
			{
				SetPVarInt( playerid, "FAttach:Delete", i );
				strcat( g_big_string, ""cBLUE"— Удалить объекты" );
				
				break;
			}
		
			format:g_small_string( ""cBLUE"%d. "cGRAY"%s\n", 
				i + 1,
				crime_attach[i][c_a_name]
			);
			
			strcat( g_big_string, g_small_string );
		}
		
		showPlayerDialog( playerid, d_attach, DIALOG_STYLE_LIST, " ", g_big_string, "Выбрать", "Закрыть" );
	}

	return 1;
}

CMD:cuff( playerid, params[] ) 
{
	if( !Player[playerid][uMember] || Player[playerid][uMember] == FRACTION_FIRE || 
		Player[playerid][uMember] == FRACTION_NEWS || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( GetPVarInt( playerid, "Inv:Show" ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_add][6] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}

	if( !getItem( playerid, INV_SPECIAL, PARAM_CUFF ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет с собой наручников." );
	
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /cuff [ id игрока ]" );
		
	if( !IsLogged( params[0] ) || params[0] == playerid ) 
		return SendClient:( playerid, C_GRAY, !INCORRECT_PLAYERID );
	 
	if( GetPVarInt( params[0], "Player:Cuff" ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже в наручниках." );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );
	
	SetPlayerSpecialAction( params[0], SPECIAL_ACTION_CUFFED );
	
	RemovePlayerAttachedObject( playerid, 4 );
	SetPlayerAttachedObject( params[0], 4, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000 );
	SetPVarInt( params[0], "Player:Cuff", 1 );
	
	format:g_small_string( "надел%s наручники на %s", SexTextEnd( playerid ), Player[ params[0] ][uName] );
	MeAction( playerid, g_small_string, 1 );
	
	useSpecialItem( playerid, PARAM_CUFF );
	
	pformat:( ""gbDefault""cBLUE"%s"cWHITE" надел на Вас наручники.", Player[playerid][uRPName] );
	psend:( params[0], C_WHITE );
	
	return 1;
}

CMD:uncuff( playerid, params[] ) 
{
	if( !Player[playerid][uMember] || Player[playerid][uMember] == FRACTION_FIRE || 
		Player[playerid][uMember] == FRACTION_NEWS || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( GetPVarInt( playerid, "Inv:Show" ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_add][6] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
	
	if( sscanf(params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /uncuff [ id игрока ]" );
	
	if( !IsLogged( params[0] ) || playerid == params[0] )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );

	if( GetPVarInt( params[0], "Player:Follow" ) != INVALID_PLAYER_ID ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Нельзя снять наручники с этого игрока.");
	
	if( !GetPVarInt( params[0], "Player:Cuff" ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Этот игрок не находится в наручниках.");
	
	SetPlayerSpecialAction( params[0], SPECIAL_ACTION_NONE );
	RemovePlayerAttachedObject( params[0], 4 );
	
	if( !getItem( playerid, INV_SPECIAL, PARAM_CUFF ) )
		giveItem( playerid, 97, 1, -1, INDEX_FRACTION );
	
	DeletePVar( params[0], "Player:Cuff" );
	
	format:g_small_string( "снял%s наручники с %s", SexTextEnd( playerid ), Player[ params[0] ][uRPName] );
	MeAction( playerid, g_small_string, 1 );
	
	pformat:( ""gbDefault""cBLUE"%s"cWHITE" снял с Вас наручники.", Player[playerid][uRPName] );
	psend:( params[0], C_WHITE );
	
	return 1;
}

CMD:frisk( playerid, params[] )
{
	if( !Player[playerid][uMember] || Player[playerid][uMember] == FRACTION_FIRE || 
		Player[playerid][uMember] == FRACTION_NEWS || !Player[playerid][uRank] || Player[playerid][uMember] == FRACTION_HOSPITAL )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Player[playerid][uMember] == FRACTION_POLICE )
	{
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][5] && !FRank[fid][rank][r_add][6] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
	
	if( sscanf(params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /frisk [ id игрока ]" );
		
	new 
		server_tick = GetTickCount();
	
	if( GetPVarInt( playerid, "Target:FriskTime" ) > server_tick )
		return SendClient:( playerid, C_WHITE, !TIME_CMD );

	if( !IsLogged( params[0] ) || playerid == params[0] )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );
		
	if( GetPVarInt( params[0], "Player:Cuff" ) )
	{
		new
			id,
			bag_id,
			bool:flag = false,
			bool:find = false;
	
		clean:<g_big_string>;
		
		format:g_small_string( ""cWHITE"При обыске %s найдено:\n", Player[ params[0] ][uRPName] );
		strcat( g_big_string, g_small_string );
		
		for( new i; i < MAX_INVENTORY_USE; i++ )
		{
			if( !UseInv[ params[0] ][i][inv_id] ) continue;
		
			id = getInventoryId( UseInv[ params[0] ][i][inv_id] );
			
			if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_SMALL_GUN )
			{
				if( UseInv[ params[0] ][i][inv_param_2] > INVALID_PARAM )
				{
					format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Лицензия #%d", inventory[id][i_name], UseInv[ params[0] ][i][inv_amount], UseInv[ params[0] ][i][inv_param_2] );
					strcat( g_big_string, g_small_string );
				}
				else if( UseInv[ params[0] ][i][inv_param_2] == INDEX_FRACTION )
				{
					format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Государственное", inventory[id][i_name], UseInv[ params[0] ][i][inv_amount] );
					strcat( g_big_string, g_small_string );
				}
				else
				{
					format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Нет лицензии", inventory[id][i_name], UseInv[ params[0] ][i][inv_amount] );
					strcat( g_big_string, g_small_string );
				}
			}
			else
			{
				format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d", inventory[id][i_name], UseInv[ params[0] ][i][inv_amount] );
				strcat( g_big_string, g_small_string );
			}
			
			if( !find ) find = true;
			flag = true;
		}

		if( flag ) strcat( g_big_string, "\n" );
		flag = false;
		
		for( new i; i < MAX_INVENTORY; i++ )
		{
			if( !PlayerInv[ params[0] ][i][inv_id] ) continue;
		
			id = getInventoryId( PlayerInv[ params[0] ][i][inv_id] );
			
			if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_SMALL_GUN )
			{
				if( PlayerInv[ params[0] ][i][inv_param_2] > INVALID_PARAM )
				{
					format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Лицензия #%d", inventory[id][i_name], PlayerInv[ params[0] ][i][inv_amount], PlayerInv[ params[0] ][i][inv_param_2] );
					strcat( g_big_string, g_small_string );
				}
				else if( PlayerInv[ params[0] ][i][inv_param_2] == INDEX_FRACTION )
				{
					format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Государственное", inventory[id][i_name], PlayerInv[ params[0] ][i][inv_amount] );
					strcat( g_big_string, g_small_string );
				}
				else
				{
					format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Нет лицензии", inventory[id][i_name], PlayerInv[ params[0] ][i][inv_amount] );
					strcat( g_big_string, g_small_string );
				}
			}
			else
			{
				format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d", inventory[id][i_name], PlayerInv[ params[0] ][i][inv_amount] );
				strcat( g_big_string, g_small_string );
			}
			
			if( !find ) find = true;
			flag = true;
		}
		
		if( getUseBag( params[0] ) )
		{
			if( flag ) strcat( g_big_string, "\n" );
			flag = false;
		
			strcat( g_big_string, "В сумке: " );
			bag_id = getUseBagId( params[0] );
			
			for( new i; i < MAX_INVENTORY_BAG; i++ )
			{
				if( !BagInv[ bag_id ][i][inv_id] ) continue;
				
				id = getInventoryId( BagInv[ bag_id ][i][inv_id] );
				
				if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_SMALL_GUN )
				{
					if( BagInv[ params[0] ][i][inv_param_2] > INVALID_PARAM )
					{
						format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Лицензия #%d", inventory[id][i_name], BagInv[ params[0] ][i][inv_amount], BagInv[ params[0] ][i][inv_param_2] );
						strcat( g_big_string, g_small_string );
					}
					else if( BagInv[ params[0] ][i][inv_param_2] == INDEX_FRACTION )
					{
						format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Государственное", inventory[id][i_name], BagInv[ params[0] ][i][inv_amount] );
						strcat( g_big_string, g_small_string );
					}
					else
					{
						format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d "cGRAY"- Нет лицензии", inventory[id][i_name], BagInv[ params[0] ][i][inv_amount] );
						strcat( g_big_string, g_small_string );
					}
				}
				else
				{
					format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d", inventory[id][i_name], BagInv[ bag_id ][i][inv_amount] );
					strcat( g_big_string, g_small_string );
				}
				
				flag = true;
			}
			
			if( !flag ) strcat( g_big_string, "пусто" );
		}
	
		if( !find )
		{
			pformat:( ""gbDefault"При обыске %s ничего не найдено.", Player[ params[0] ][uName] );
			psend:( playerid, C_WHITE );
		}
		else
		{
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
		}
	
		format:g_small_string( "обыскал%s %s", SexTextEnd( playerid ), Player[ params[0] ][uRPName] );
		MeAction( playerid, g_small_string, 1 );
		
		pformat:( ""gbDefault""cBLUE"%s"cWHITE" обыскал Вас.", Player[playerid][uName] );
		psend:( params[0], C_WHITE );
	}
	else
	{
		format:g_small_string( ""gbDefault"Вы предложили игроку "cBLUE"%s[%d]"cWHITE" обыскать его.",
			GetAccountName( params[0] ),
			params[0]
		);
		SendClient:( playerid, C_WHITE, g_small_string );
				
		clean:<g_big_string>;
		strcat( g_big_string, ""gbDefault"Предложение от игрока\n\n" );
		format:g_small_string( "Игрок "cBLUE"%s[%d]"cWHITE" пытается обыскать Вас.\n\n\
		"gbDialog"Ваши действия?",
			GetAccountName( playerid ),
			playerid
		);
		strcat( g_big_string, g_small_string );
		
		showPlayerDialog( params[0], d_frac + 3, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Принять", "Отказаться" );
		
		SetPVarInt( params[0], "Target:Player", playerid );
	}
	
	SetPVarInt( playerid, "Target:FriskTime", server_tick + 5000 );
	
	return 1;
}

CMD:shield( playerid )
{
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( GetPVarInt( playerid, "Inv:Show" ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		
	if( IsPlayerAttachedObjectSlotUsed( playerid, 9 ) )
	{
		RemovePlayerAttachedObject( playerid, 9 );
		
		if( GetPVarInt( playerid, "Player:Shield" ) )
		{
			DeletePVar( playerid, "Player:Shield" );
			
			if( Player[playerid][uHP] > 100 ) setPlayerHealth( playerid, 100.0 );
			
			if( !getItem( playerid, INV_SPECIAL, PARAM_SHIELD ) )
				giveItem( playerid, 101, 1, -1, INDEX_FRACTION );
			
			return 1;
		}
	}

	if( !getItem( playerid, INV_SPECIAL, PARAM_SHIELD ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет с собой полицейского щита." );
	
	//Аттачим щит в левую руку в слот 9
	SetPlayerAttachedObject( playerid, 9, 18637, 4, 0.0, 0.0, 0.0, 0.0, 180.0, 180.0 );
	
	SetPVarInt( playerid, "Player:Shield", 1 );
	if( Player[playerid][uHP] >= 100.0 ) setPlayerHealth( playerid, 200.0 );

	useSpecialItem( playerid, PARAM_SHIELD );
	
	return 1;
}

CMD:thorn( playerid )
{
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( GetPVarInt( playerid, "Inv:Show" ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		
	if( IsPlayerInAnyVehicle( playerid ) || GetPlayerVirtualWorld( playerid ) != 0 || GetPlayerInterior( playerid ) != 0 ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Thorn[playerid][t_status] )
	{
		if( !IsPlayerInRangeOfPoint( playerid, 2.0, Thorn[playerid][t_pos][0], Thorn[playerid][t_pos][1], Thorn[playerid][t_pos][2] ) )
			return SendClient:( playerid, C_WHITE, !""gbDefault"Вы должны находится рядом с объектом." );
	
		if( IsValidDynamicObject( Thorn[playerid][t_object] ) )
			DestroyDynamicObject( Thorn[playerid][t_object] );
			
		if( IsValidDynamic3DTextLabel( Thorn[playerid][t_object_text] ) )
			DestroyDynamic3DTextLabel( Thorn[playerid][t_object_text] );
			
		if( !getItem( playerid, INV_SPECIAL, PARAM_THORNS ) )
			giveItem( playerid, 100, 1, -1, INDEX_FRACTION );
			
		Thorn[playerid][t_status] = false;
		
		Thorn[playerid][t_pos][0] = 
		Thorn[playerid][t_pos][1] = 
		Thorn[playerid][t_pos][2] = 0.0;
		
		SendClient:( playerid, C_WHITE, !""gbDefault"Вы убрали ленту с шипами." );
	}
	else
	{
		if( !getItem( playerid, INV_SPECIAL, PARAM_THORNS ) )
			return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет с собой ленты с шипами." );
	
		new 
			Float:p[4];
	
		GetPlayerPos( playerid, p[0], p[1], p[2] );
		GetPlayerFacingAngle( playerid, p[3] );
		
		Thorn[playerid][t_object] = CreateDynamicObject( 2899, p[0] + 1.0 * -floatsin( p[3], degrees ), p[1] + 1.0 * floatcos( p[3], degrees ), p[2] - 0.9, 0, 0, p[3] );
		
		format:g_small_string( "[ %d ]", playerid );
		Thorn[playerid][t_object_text] = CreateDynamic3DTextLabel( g_small_string, C_GRAY, p[0] + 1.0 * -floatsin( p[3], degrees ), p[1] + 1.0 * floatcos( p[3], degrees ), p[2] - 0.4, 3.0 );
		
		Thorn[playerid][t_status] = true;
		
		Thorn[playerid][t_pos][0] = p[0];
		Thorn[playerid][t_pos][1] = p[1];
		Thorn[playerid][t_pos][2] = p[2];
		
		ApplyAnimation( playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 0 );
		SendClient:( playerid, C_WHITE, "Вы установили ленту с шипами. Введите "cBLUE"/thorn"cWHITE", чтобы убрать её." );
	
		format:g_small_string( "установил%s ленту с шипами", SexTextEnd( playerid ) );
		MeAction( playerid, g_small_string, 1 );
		
		useSpecialItem( playerid, PARAM_THORNS );
	}	
		
	return 1;
}

CMD:rb( playerid ) //Тазер
{
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( GetPlayerWeapon( playerid ) != 22 && GetPlayerWeapon( playerid ) != 24 && GetPlayerWeapon( playerid ) != 25 )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете использовать это оружие как электрошоковое." );
		
	new
		bool:cheat = true,
		weaponid = GetPlayerWeapon( playerid );
		
	for( new i; i < MAX_INVENTORY_USE; i++ )
	{
		if( getUseGunId( playerid, i ) == weaponid )
		{
			cheat = false;
			break;
		}
	}
	
	if( cheat ) 
		return SuspectDetected( playerid, "DGun", CHEAT_GUN_2, 2 );
		
	if( g_player_taser{playerid} )
	{
		g_player_taser{playerid} = 0;
		SendClient:( playerid, C_WHITE, !""gbDefault"Вы прекратили использовать это оружие как электрошоковое." );
	}
	else
	{
		g_player_taser{playerid} = 1;
		SendClient:( playerid, C_WHITE, !""gbDefault"Вы начали использовать это оружие как электрошоковое." );
	}

	return 1;
}