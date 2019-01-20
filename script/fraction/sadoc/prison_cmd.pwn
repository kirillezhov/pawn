CMD:prison( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uRank] ) return 1;

	if( sscanf( params, "u", params[0] ) ) 
		return SendClient:( playerid, C_GRAY, !""gbDefault"Введите: /prison [ id игрока ]" );
		
	if( !IsLogged( params[0] ) || playerid == params[0] )  
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Prison[ params[0] ][p_date] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже находится под арестом." );
	
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с вами." );
	
	SetPVarInt( playerid, "Arrest:ID", params[0] );
	showArrestMenu( playerid );
	
	g_player_interaction{playerid} = 1;
	
	return 1;
}

CMD:transfer( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uRank] ) return 1;
	
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /transfer [ id игрока ] [ камера ]" );

	if( !IsLogged( params[0] ) || playerid == params[0] )  
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( !Prison[ params[0] ][p_date] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок не является заключенным." );
		
	if( params[1] < 1 || params[1] > 27 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /transfer [ id игрока ] [ камера ]" );
	
	Prison[ params[0] ][p_camera] = params[1];
	
	mysql_format:g_small_string( "UPDATE `"DB_PRISON"` SET `pCamera` = %d WHERE `puID` = %d AND `pStatus` = 1 LIMIT 1", params[1], Player[ params[0] ][uID] );
	mysql_tquery( mysql, g_small_string );
	
	pformat:( ""gbDefault"Вы успешно перевели игрока %s в камеру %d.", Player[ params[0] ][uName], params[1] );
	psend:( playerid, C_WHITE );
	
	return 1;
}

CMD:cooler( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uRank] ) return 1;
	
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /cooler [ id игрока ][ id карцера ]");
	
	if( !IsLogged( params[0] ) || playerid == params[0] )  
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( !Prison[ params[0] ][p_date] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок не является заключенным." );
	
	if( params[1] < 0 || params[1] > 4 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /cooler [ id игрока ][ id карцера ]" );
	
	if( params[1] == 0 ) 
	{
		Prison[ params[0] ][p_cooler] = 0;
		UpdatePrison( playerid, "pCooler", 0 );
		
		pformat:( ""gbDefault"Вы успешно выпустили игрока "cBLUE"%s"cWHITE" из карцера", Player[ params[0] ][uName] );
		psend:( playerid, C_WHITE );
	}
	else 
	{
		Prison[ params[0] ][p_cooler] = params[1];
		UpdatePrison( playerid, "pCooler", params[1] );
		
		pformat:( ""gbDefault"Вы успешно перевели игрока "cBLUE"%s"cWHITE" в карцер %d", Player[ params[0] ][uName], params[1] );
		psend:( playerid, C_WHITE );
	}
	
	return 1;
}	

CMD:udo( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uRank] ) return 1;
	
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid ),
		reason[128];
		
	if( !FRank[fid][rank][r_add][2] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD ); 
	
	if( sscanf( params, "ds[128]", params[0], reason ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /udo [ id ][ причина ]" );
	
	if( !IsLogged( params[0] ) || playerid == params[0] )  
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( !Prison[ params[0] ][p_date] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок не является заключенным." );
		
	if( Prison[ params[0] ][p_dateudo] )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже досрочно освобожден." );
	
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с вами." );
	
	strcat( Prison[ params[0] ][p_reasonudo], reason, 128 );
	
	Player[ params[0] ][uArrestStat]++;
	Prison[ params[0] ][p_dateudo] = gettime();
	
	UpdatePlayer( params[0], "uArrestStat", Player[ params[0] ][uArrestStat] );

	pformat:( ""gbSuccess"Вы выпустили игрока "cBLUE"%s"cWHITE" по УДО.", Player[ params[0] ][uName] );
	psend:( playerid, C_WHITE );
	
	pformat:( ""gbSuccess"Вы были выпущены по УДО офицером "cBLUE"%s"cWHITE".", Player[playerid][uName] );
	psend:( params[0], C_WHITE );

	mysql_format:g_string( "UPDATE `"DB_PRISON"` SET `pUDODate` = %d, `pUDOReason` = '%e' WHERE `puID` = %d AND `pStatus` = '1'", 
		Prison[ params[0] ][p_dateudo], Prison[ params[0] ][p_reasonudo], Player[ params[0] ][uID] );
	mysql_tquery( mysql, g_string );
	
	if( Player[ params[0] ][uRole] == 2 )
		Player[ params[0] ][uRole] = 1, UpdatePlayer( params[0], "uRole", 1 );
	
	setPlayerPos( params[0], 97.6320, -238.3941, 1.5785 );
	SetPlayerVirtualWorld( params[0], 0 );
	SetPlayerInterior( params[0], 0 );
		
	UpdateWeather( params[0] );
	
	return 1;
}