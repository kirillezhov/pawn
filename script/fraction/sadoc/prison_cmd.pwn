CMD:prison( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uRank] ) return 1;

	if( sscanf( params, "u", params[0] ) ) 
		return SendClient:( playerid, C_GRAY, !""gbDefault"�������: /prison [ id ������ ]" );
		
	if( !IsLogged( params[0] ) || playerid == params[0] )  
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Prison[ params[0] ][p_date] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������ ����� ��� ��������� ��� �������." );
	
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������� ������ ��� ����� � ����." );
	
	SetPVarInt( playerid, "Arrest:ID", params[0] );
	showArrestMenu( playerid );
	
	g_player_interaction{playerid} = 1;
	
	return 1;
}

CMD:transfer( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uRank] ) return 1;
	
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /transfer [ id ������ ] [ ������ ]" );

	if( !IsLogged( params[0] ) || playerid == params[0] )  
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( !Prison[ params[0] ][p_date] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������ ����� �� �������� �����������." );
		
	if( params[1] < 1 || params[1] > 27 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /transfer [ id ������ ] [ ������ ]" );
	
	Prison[ params[0] ][p_camera] = params[1];
	
	mysql_format:g_small_string( "UPDATE `"DB_PRISON"` SET `pCamera` = %d WHERE `puID` = %d AND `pStatus` = 1 LIMIT 1", params[1], Player[ params[0] ][uID] );
	mysql_tquery( mysql, g_small_string );
	
	pformat:( ""gbDefault"�� ������� �������� ������ %s � ������ %d.", Player[ params[0] ][uName], params[1] );
	psend:( playerid, C_WHITE );
	
	return 1;
}

CMD:cooler( playerid, params[] ) 
{
	if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uRank] ) return 1;
	
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /cooler [ id ������ ][ id ������� ]");
	
	if( !IsLogged( params[0] ) || playerid == params[0] )  
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( !Prison[ params[0] ][p_date] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������ ����� �� �������� �����������." );
	
	if( params[1] < 0 || params[1] > 4 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /cooler [ id ������ ][ id ������� ]" );
	
	if( params[1] == 0 ) 
	{
		Prison[ params[0] ][p_cooler] = 0;
		UpdatePrison( playerid, "pCooler", 0 );
		
		pformat:( ""gbDefault"�� ������� ��������� ������ "cBLUE"%s"cWHITE" �� �������", Player[ params[0] ][uName] );
		psend:( playerid, C_WHITE );
	}
	else 
	{
		Prison[ params[0] ][p_cooler] = params[1];
		UpdatePrison( playerid, "pCooler", params[1] );
		
		pformat:( ""gbDefault"�� ������� �������� ������ "cBLUE"%s"cWHITE" � ������ %d", Player[ params[0] ][uName], params[1] );
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
		return SendClient:( playerid, C_WHITE, ""gbDefault"�������: /udo [ id ][ ������� ]" );
	
	if( !IsLogged( params[0] ) || playerid == params[0] )  
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( !Prison[ params[0] ][p_date] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������ ����� �� �������� �����������." );
		
	if( Prison[ params[0] ][p_dateudo] )
		return SendClient:( playerid, C_WHITE, !""gbError"������ ����� ��� �������� ����������." );
	
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������� ������ ��� ����� � ����." );
	
	strcat( Prison[ params[0] ][p_reasonudo], reason, 128 );
	
	Player[ params[0] ][uArrestStat]++;
	Prison[ params[0] ][p_dateudo] = gettime();
	
	UpdatePlayer( params[0], "uArrestStat", Player[ params[0] ][uArrestStat] );

	pformat:( ""gbSuccess"�� ��������� ������ "cBLUE"%s"cWHITE" �� ���.", Player[ params[0] ][uName] );
	psend:( playerid, C_WHITE );
	
	pformat:( ""gbSuccess"�� ���� �������� �� ��� �������� "cBLUE"%s"cWHITE".", Player[playerid][uName] );
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