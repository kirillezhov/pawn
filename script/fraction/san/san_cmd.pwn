CMD:newspanel( playerid ) 
{
	if( Player[playerid][uMember] != FRACTION_NEWS || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid );
		
	if( !FRank[fid][rank][r_add][0] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( ETHER_STATUS == INVALID_PARAM )
	{
		format:g_small_string( ""cBLUE"��������" );
	}
	else
	{
		format:g_small_string( ""cBLUE"%s", Player[ ETHER_STATUS ][uRPName] );
	}
		
	format:g_string( dialog_sanpanel,
		COUNT_ADVERTS,
		g_small_string,
		ETHER_CALL ? (""cBLUE"��") : (""cGRAY"���"),
		ETHER_SMS ? (""cBLUE"��") : (""cGRAY"���"),
		NETWORK_ADPRICE,
		NETWORK_COFFER );
	
	g_player_interaction{playerid} = 1;
	showPlayerDialog( playerid, d_cnn + 1, DIALOG_STYLE_LIST," ", g_string, "�������", "�������" );
	
	return 1;
}

CMD:n( playerid, params[] ) 
{
	if( !Player[playerid][tEther] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( IsMuted( playerid, IC ) )
		return SendClient:( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( ETHER_STATUS == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"� ������ ������ ��� �������� �����." );
		
	if( IsPlayerInAnyVehicle( playerid ) )
	{
		if( GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 488 && GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 582 )
			return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������������������ ����������." );
						
		if( Vehicle[ GetPlayerVehicleID( playerid ) ][vehicle_member] != FRACTION_NEWS )
			return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ���������� SAN." );
	}
	else if( !IsPlayerInDynamicArea( playerid, NETWORK_ZONE ) )
		return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������." );

	if( sscanf( params, "s[128]", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /n [ ����� ]" );
	
	pformat:( "[���� %s] %s: %s", Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uRPName], params[0] );
		
	foreach(new i : Player) 
	{
		if( !IsLogged(i) || !Player[playerid][uSettings][2] ) continue;
		psend:( i, C_LIGHTGREEN );
	}

	return 1;
}

CMD:ether( playerid )
{
	if( ETHER_STATUS != playerid || Player[playerid][uMember] != FRACTION_NEWS || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( ETHER_CALLID == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"� ���� ����� ������� �� ���������." );
		
	if( !IsLogged( ETHER_CALLID ) || !GetPVarInt( ETHER_CALLID, "San:Call" ) )
	{
		ETHER_CALLID = INVALID_PARAM;
		return SendClient:( playerid, C_WHITE, !""gbError"��� �������� ������ ��������� ������ ����." );
	}
		
	switch( GetPVarInt( ETHER_CALLID, "San:Call" ) )
	{
		case 1:
		{
			pformat:( "[���� %s] �� ���������� %s[%d] � �����. ����������� /ether ��� ���, ����� ��������� �����.",
				Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName], playerid );
			psend:( playerid, C_LIGHTGREEN );
		
			SetPVarInt( ETHER_CALLID, "San:Call", 2 );
			SendClient:( ETHER_CALLID, C_WHITE, !""gbDefault"�� ����������� � ������ ����, ��������... ( "cBLUE"N"cWHITE" )" );
		}
		
		case 2:
		{
			pformat:( "[���� %s] �� ��������� ����� %s[%d].", 
				Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName], playerid );
			psend:( playerid, C_LIGHTGREEN );
			
			DeletePVar( ETHER_CALLID, "San:Call" );
			SendClient:( ETHER_CALLID, C_WHITE, !""gbDefault"�� ���� ��������� ������� �� ������� �����." );
			
			PhoneStatus( ETHER_CALLID, false );
			ETHER_CALLID = INVALID_PARAM;
		}
	}
		
	return 1;
}