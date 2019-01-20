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
		format:g_small_string( ""cBLUE"Свободно" );
	}
	else
	{
		format:g_small_string( ""cBLUE"%s", Player[ ETHER_STATUS ][uRPName] );
	}
		
	format:g_string( dialog_sanpanel,
		COUNT_ADVERTS,
		g_small_string,
		ETHER_CALL ? (""cBLUE"Да") : (""cGRAY"Нет"),
		ETHER_SMS ? (""cBLUE"Да") : (""cGRAY"Нет"),
		NETWORK_ADPRICE,
		NETWORK_COFFER );
	
	g_player_interaction{playerid} = 1;
	showPlayerDialog( playerid, d_cnn + 1, DIALOG_STYLE_LIST," ", g_string, "Выбрать", "Закрыть" );
	
	return 1;
}

CMD:n( playerid, params[] ) 
{
	if( !Player[playerid][tEther] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( IsMuted( playerid, IC ) )
		return SendClient:( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( ETHER_STATUS == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"В данный момент нет текущего эфира." );
		
	if( IsPlayerInAnyVehicle( playerid ) )
	{
		if( GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 488 && GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 582 )
			return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться в специализированном транспорте." );
						
		if( Vehicle[ GetPlayerVehicleID( playerid ) ][vehicle_member] != FRACTION_NEWS )
			return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться в транспорте SAN." );
	}
	else if( !IsPlayerInDynamicArea( playerid, NETWORK_ZONE ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться в студии." );

	if( sscanf( params, "s[128]", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /n [ текст ]" );
	
	pformat:( "[Эфир %s] %s: %s", Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uRPName], params[0] );
		
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
		return SendClient:( playerid, C_WHITE, !""gbError"В эфир новых звонков не поступало." );
		
	if( !IsLogged( ETHER_CALLID ) || !GetPVarInt( ETHER_CALLID, "San:Call" ) )
	{
		ETHER_CALLID = INVALID_PARAM;
		return SendClient:( playerid, C_WHITE, !""gbError"При входящем вызове произошла ошибка сети." );
	}
		
	switch( GetPVarInt( ETHER_CALLID, "San:Call" ) )
	{
		case 1:
		{
			pformat:( "[Эфир %s] Вы подключили %s[%d] к эфиру. Используйте /ether еще раз, чтобы завершить вызов.",
				Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName], playerid );
			psend:( playerid, C_LIGHTGREEN );
		
			SetPVarInt( ETHER_CALLID, "San:Call", 2 );
			SendClient:( ETHER_CALLID, C_WHITE, !""gbDefault"Вы дозвонились в прямой эфир, говорите... ( "cBLUE"N"cWHITE" )" );
		}
		
		case 2:
		{
			pformat:( "[Эфир %s] Вы завершили вызов %s[%d].", 
				Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName], playerid );
			psend:( playerid, C_LIGHTGREEN );
			
			DeletePVar( ETHER_CALLID, "San:Call" );
			SendClient:( ETHER_CALLID, C_WHITE, !""gbDefault"Вы были отключены ведущим от прямого эфира." );
			
			PhoneStatus( ETHER_CALLID, false );
			ETHER_CALLID = INVALID_PARAM;
		}
	}
		
	return 1;
}