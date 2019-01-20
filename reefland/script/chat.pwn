Chat_OnPlayerText( playerid, text[] ) 
{
	new
		server_tick = GetTickCount();
	
	if( GetPVarInt( playerid, "Chat:Time" ) > server_tick )
	{
		SendClient:(playerid, C_WHITE, !""gbError"Вы не можете использовать игровой чат так часто.");
		return 0;
	}

	//clean_array();
	
	if( !IsLogged( playerid ) ) 
		return 0;
		
	if( IsMuted( playerid, IC ) ) 
	{
		SendClientMessage(playerid, C_WHITE,""gbError"У Вас блокировка чата, Вы не можете отправить сообщение.");
		return 0;
	}
	
	if( Player[playerid][tSpectate] && GetAccessAdmin( playerid, 1 ) && !IsMuted( playerid, OOC ) )
	{
		format:g_small_string( "(( Администратор %s[%d]: %s ))", 
			GetAccountName(playerid), 
			playerid, 
			text
		);

		SendLong:( playerid, 25.0, g_small_string, COLOR_FADE1, COLOR_FADE1, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2 );
		return 0;
	}
	else if( GetAccessAdmin( playerid, 1 ) && !IsMuted( playerid, OOC ) )
	{
		format:g_small_string( "(( Администратор %s[%d]: %s ))", Player[playerid][uName], playerid, text);
		SendLong:( playerid, 20.0, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5 );
		return 0;
	}
	
	if( Player[playerid][uJailSettings][2] != 0 || Player[playerid][uJailSettings][4] != 0 )
	{
		SendClientMessage(playerid, C_WHITE,""gbError"Вы не в состоянии говорить что-то.");
		return 0;
	}
	
	if( IsPlayerInAnyVehicle( playerid ) )
	{
		format:g_small_string(  ""gbVehicle"%s говорит: %s", 
			Player[playerid][uRPName], 
			text
		);
	
		if( IsClosedCarWindow( GetPlayerVehicleID( playerid ) ) )
		{
			SendLong:( playerid, 10.0, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5, 4 );
		}
		else
		{
			SendLong:( playerid, 10.0, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5 );
		}
		
		SetPVarInt( playerid, "Chat:Time", server_tick + 3000 );
		
		return 0;
	}

	if( GetPVarInt( playerid, "San:Call" ) == 2 && ETHER_STATUS != INVALID_PARAM )
	{
		pformat:( "[Эфир %s] %s: %s", Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uRPName], text );
		
		foreach(new i : Player) 
		{
			if( !IsLogged(i) || !Player[playerid][uSettings][2] ) continue;
			psend:( i, C_LIGHTGREEN );
		}
		
		format:g_small_string( "%s говорит по телефону: %s ", Player[playerid][uRPName], text );
		SendLong:( playerid, 10.0, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5 );
		
		SetPVarInt( playerid, "Chat:Time", server_tick + 3000 );
		
		return 0;
	}
	
	if( Call[playerid][c_accept] ) //Разговор по телефону
	{
		new
			callid = Call[playerid][c_call_id];
			
		pformat:( ""gbPhone" %s", text );
		psend:( callid, C_WHITE );
			
		format:g_small_string( "%s говорит по телефону: %s ", Player[playerid][uRPName], text );
		SendLong:( playerid, 10.0, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5 );
		
		SetPVarInt( playerid, "Chat:Time", server_tick + 3000 );
		
		return 0;
	}
	
	if( !GetPVarInt(playerid,"Anim:States"))
	{
		if( Player[playerid][uSettings][7] == 0 ) 
			ApplyAnimation(playerid,"ped", Talk[Player[playerid][uSettings][7]], 4.1,1, 1,1, 1,1, 1 );
		else if( Player[playerid][uSettings][7] != 0 ) 
			ApplyAnimation(playerid,"GANGS", Talk[Player[playerid][uSettings][7]], 4.1,1,1,1, 1,1, 1 );
	}
	
	if( !GetPVarInt( playerid, "Anim:States" ) ) 
		SetTimerEx("ClearAnimationsDelay", strlen(text) * 200 + 1000, false, "i", playerid);
	
	format:g_small_string( "%s говорит: %s", 
		Player[playerid][uRPName], 
		text
	);
	
	SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 15.0, 5000);
	SendLong:( playerid, 20.0, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5 );
	
	SetPVarInt( playerid, "Chat:Time", server_tick + 3000 );
	
	return 0;
}

function ClearAnimationsDelay( playerid ) 
	return ApplyAnimation(playerid,"ped","IDLE_chat",4.1,1,0,0,0,1,1);