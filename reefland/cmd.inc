CMD:lock( playerid, params[] )
{
	if( sscanf( params, "i", params[0] ) ) return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /lock [ ����� ] ( 1 - ���/2 - ������ ����/3 - ������/4 - ������� ���� )" );
		
	//if( params[0] == 1 ) lockHouse( playerid );
	
	switch( params[0] )
	{
		case 1 : LockHouse( playerid );

		case 2 : 
		{
			if( !IsOwnerVehicleCount( playerid ) )
				return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ������� ����������." );

			new
				id,
				Float:x,
				Float:y,
				Float:z,
				bool:flag = false;
		
			for( new i; i < MAX_PLAYER_VEHICLES; i++ ) 
			{
				id = Player[playerid][tVehicle][i];
				
				if( id == INVALID_VEHICLE_ID )
					continue;
				
				GetVehiclePos( id, x, y, z );
				CheckVehicleParams( id );

				if( IsPlayerInRangeOfPoint( playerid, 4.0, x, y, z ) )
				{
					if( Vehicle[id][vehicle_arrest] )
						return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ �������������� ����� ���������� �� ������������." );
				
					if( !Vehicle[id][vehicle_state_door] )
					{
						GameTextForPlayer( playerid, "~r~DOORS LOCK", 1000, 1 );
						Vehicle[id][vehicle_state_door] = 1;
						format:g_small_string( "������������%s �����", SexTextEnd( playerid ) );
						
						//Vehicle[id][vehicle_state_boot] = false;
						//Vehicle[id][vehicle_state_hood] = false;
					}
					else
					{
						GameTextForPlayer( playerid, "~g~DOORS UNLOCK", 1000, 1 );
						Vehicle[id][vehicle_state_door] = 0;
						format:g_small_string( "�������������%s �����", SexTextEnd( playerid ) );
					}
					MeAction( playerid, g_small_string, 1 );
					SetVehicleParams( id );
				
					flag = true;
					
					break;
				}
				else continue;
			}
			
			if( !flag )
				return SendClient:( playerid, C_WHITE, ""gbError"��� ������ ��������� ������� ������." );
		}
		
		case 3 : LockBusiness( playerid );
	
		case 4 : LockJobCar( playerid );
	}
	
	return 1;
}
	
CMD:untow( playerid, params[] )
{
	if( IsTrailerAttachedToVehicle( GetPlayerVehicleID(playerid) ) ) 
		DetachTrailerFromVehicle( GetPlayerVehicleID(playerid) );
	
	return 1;
}
/*
CMD:pass( playerid, params[] )
{
	new 
		MyHash[64 + 1];
		
	SHA256_PassHash( params[0], "934adse4kks", MyHash, sizeof MyHash );
   
	printf( "Returned hash: %s", MyHash );
   
	return 1;
}
*/

// - Commands - New

CMD:id( playerid, params[] )
{
	if( sscanf( params, "s[25]", params[0] ) )
		return SendClientMessage(playerid, C_WHITE, !""gbDefault"�������: /id [ ���/id ������ ]");
		
	new
		id = 0,
		fmt_afk[ 32 ];
	
	//clean_array();
	//strcat( g_big_string, ""gbDefault"��������� ������:\n\n");
	
	SendClient:( playerid, C_WHITE, !""gbDefault"��������� ������:" );
	
	if( !IsNumeric( params[0] ) )
	{
		foreach (new i : Player)
		{
			if( strfind( GetAccountName( i ), params[0], true ) != -1 )
			{
				/*if( id > 9)
				{
					id++;
					continue;
				}*/
				
				if( IsAfk( i ) ) 
				{
					format( fmt_afk, sizeof fmt_afk, " - "cGREEN"[AFK: %d]",
						GetPVarInt( i, "Player:Afk" )
					);
				}
				
				format:g_small_string(  "%d. "cBLUE"%s[%d]%s"cWHITE"",
					id + 1,
					GetAccountName( i ),
					i,
					IsAfk( i ) ? fmt_afk : ("")
				);
				
				//strcat( g_big_string, g_small_string );
				
				SendClient:( playerid, C_GRAY, g_small_string );
				
				id++;
			}
		}
		
		if( !id )
		{
			//strcat( g_big_string, ""cBLUE"-"cWHITE" ��-������ ������� ������ �� �������.");
			SendClient:( playerid, C_WHITE, ""gbError"��-������ ������� ������ �� �������." );
		}
		/*else if( id > 5)
		{
			format:g_small_string(  "\n"cBLUE"-"cWHITE" ���������� 10 ����������� ��-������ ������� �� "cBLUE"%d"cWHITE".", 
				id
			);
			strcat( g_big_string, g_small_string);
		}*/
		
	}
	else
	{
		if( !IsLogged( strval( params[0] ) ) )
			return SendClientMessage( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
		if( GetPVarInt( strval( params[0] ), "Player:Afk" ) > 0 ) 
		{
			format( fmt_afk, sizeof fmt_afk, " - "cGREEN"[AFK: %d]"cWHITE"",
				GetPVarInt( strval( params[0] ), "Player:Afk" )
			);
		}
		
		format:g_small_string(  ""cBLUE"%s[%d]%s"cWHITE"", 
			GetAccountName( strval( params[0] ) ),
			strval( params[0] ),
			GetPVarInt( strval( params[0] ), "Player:Afk" ) > 0 ? fmt_afk : ("")
		);
		
		//strcat( g_big_string, g_small_string );
		SendClient:( playerid, C_WHITE, g_small_string );
	}
	
	//showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�������", "");
	
	return 1;
}

CMD:report( playerid, params[] )
{
	new
	    server_tick = GetTickCount();
	
	if( GetPVarInt( playerid, "Player:ReportTime" ) > server_tick )
		return SendClientMessage(playerid, C_WHITE, !""gbError"������������ ����� � �������������� ����� ��� � 20 ������.");
	
	if( IsMuted( playerid, OOC ) )
		return SendClientMessage(playerid, C_WHITE, !CHAT_MUTE_OOC );
	
	if( isnull( params ) )
		return SendClientMessage(playerid, C_WHITE, !""gbDefault"�������: /report [ ����� ]");
	
	switch( Premium[playerid][prem_color] )
	{
		case 0:
		{
			format:g_small_string( ""SUPPORT_PREFIX" %s[%d]: %s",
				GetAccountName( playerid ),
				playerid,
				params
			);
			SendSupport:( C_YELLOW, g_small_string, false );
					
			format:g_small_string( ""ADMIN_PREFIX" %s[%d]: %s",
				GetAccountName(playerid),
				playerid,
				params
			);
			SendAdmin:( C_YELLOW, g_small_string );
		}
		
		case 1:
		{
			format:g_small_string( ""SUPPORT_PREFIX" %s[%d]: %s",
				GetAccountName( playerid ),
				playerid,
				params
			);
			SendSupport:( C_LIGHTGREEN, g_small_string, false );
					
			format:g_small_string( ""ADMIN_PREFIX" %s[%d]: %s",
				GetAccountName(playerid),
				playerid,
				params
			);
			SendAdmin:( C_LIGHTGREEN, g_small_string );
		}
		
		case 2:
		{
			format:g_small_string( ""SUPPORT_PREFIX" %s[%d]: %s",
				GetAccountName( playerid ),
				playerid,
				params
			);
			SendSupport:( C_LIGHTORANGE, g_small_string, false );
					
			format:g_small_string( ""ADMIN_PREFIX" %s[%d]: %s",
				GetAccountName(playerid),
				playerid,
				params
			);
			SendAdmin:( C_LIGHTORANGE, g_small_string );
		}
		
		case 3:
		{
			format:g_small_string( ""SUPPORT_PREFIX" %s[%d]: %s",
				GetAccountName( playerid ),
				playerid,
				params
			);
			SendSupport:( C_LIGHTRED, g_small_string, false );
			
			format:g_small_string( ""ADMIN_PREFIX" %s[%d]: %s",
				GetAccountName(playerid),
				playerid,
				params
			);
			SendAdmin:( C_LIGHTRED, g_small_string );
		}
	}
	
	format:g_small_string( ""gbDefault"�����: "cBLUE"%s"cWHITE"",
		params
	);
	
	SendClient:( playerid, C_WHITE, g_small_string );
	SendClient:( playerid, C_WHITE, !""gbDefault"�� ������� ��������� ��������� ��������� � ���������������.");
	
	SetPVarInt( playerid, "Player:ReportTime", server_tick + 20000 );
	return 1;
}

CMD:me( playerid, params[] )
{
	if( IsMuted( playerid, IC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( isnull( params ) )
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"�������: /me [ �������� ]");
		
	SendRolePlayAction( playerid, params, 0 );
	
	return 1;
}

CMD:coin( playerid, params[] )
{
	if( IsMuted( playerid, IC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	clean:<g_small_string>;
	strcat( g_small_string, "����������� �������, �������� " );
	
	if( random( 2 ) == 1 )
		strcat( g_small_string, ""cGRAY"���"cPURPLE"." );
	else 
		strcat( g_small_string, ""cGRAY"�����"cPURPLE"." );
		
	SendRolePlayAction( playerid, g_small_string, 0 );
	
	return 1;
}

CMD:ame( playerid, params[] )
{
	if( IsMuted( playerid, IC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( isnull( params ) )
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"�������: /ame [ �������� ]");
	
	format:g_small_string( "> %s %s", 
		Player[playerid][uRPName], 
		params 
	);
	
	SendClient:( playerid, C_PURPLE, g_small_string );
	SendRolePlayAction( playerid, params, 1 );
	
	return 1;
}

CMD:do( playerid, params[] )
{
	if( IsMuted( playerid, IC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( isnull( params ) )
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"�������: /do [ �������� ]");
		
	SendRolePlayAction( playerid, params, 2 );
	
	return 1;
}

CMD:todo( playerid, params[] )
{
	static 
		string_text		[ 128 ],
		string_action	[ 128 ];
	
	if( IsMuted( playerid, IC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( sscanf( params, "p<*>s[128]s[128]", string_text, string_action ) )
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"�������: /todo [ ����� * �������� ]");	
	
	if( strlen( params ) <= 72 )
	{
		format:g_small_string( "\"%s\", - ������%s %s,"cPURPLE" %s",
			string_text,
			(Player[playerid][uSex] == 2) ? ("�") : (""),
			Player[playerid][uRPName],
			string_action
		);
		
		ProxDetector( 20.0, playerid, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5 );
	}
	else if( strlen( params ) > 72 )
	{
		format:g_small_string( "\"%s\", - ������%s %s ...",
			string_text,
			(Player[playerid][uSex] == 2) ? ("�") : (""),
			GetAccountName( playerid )
		);
		
		ProxDetector( 20.0, playerid, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5 );
		
		format:g_small_string( "... %s",
			string_action
		);
		
		ProxDetector( 20.0, playerid, g_small_string, C_PURPLE, C_PURPLE, C_PURPLE, C_PURPLE, C_PURPLE );
	}
	
	return 1;
}

CMD:ab( playerid, params[] ) 
{
	if( IsMuted( playerid, OOC ) ) 
		return SendClient:( playerid, C_WHITE, !CHAT_MUTE_OOC );
		
	if( sscanf( params, "s[128]", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"�������: /ab [ ����� ]" );
		
	format:g_small_string( "> (( %s[%d]: %s ))", 
		Player[playerid][uName],
		playerid,
		params[0] 
	);
	
	SendClient:( playerid, COLOR_FADE1, g_small_string );
	
	format:g_small_string( "(( %s ))", params[ 0 ] );
	SetPlayerChatBubble( playerid, g_small_string, COLOR_FADE1, 10.0, 5000 );
	
	return 1;
}

CMD:w( playerid, params[] )
{
	if( IsMuted( playerid, IC ) )
		return SendClient:( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( isnull( params ) )
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"�������: /w [ ����� ]");	
	
	format:g_small_string( "%s[%d] ������: %s",
		Player[playerid][uRPName],
		playerid,
		params
	);

	SendLong:( playerid, 3.0, g_small_string, COLOR_FADE3, COLOR_FADE3, COLOR_FADE3, COLOR_FADE3, COLOR_FADE3 );
	
	return 1;
}

CMD:b( playerid, params[] )
{
	if( IsMuted( playerid, OOC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_OOC );
	
	if( isnull( params ) )
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"�������: /b [ ����� ]");	
	
	format:g_small_string( "(( %s[%d]: %s ))",
		GetAccountName( playerid ),
		playerid,
		params
	);
	
	SendLong:( playerid, 18.0, g_small_string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5, 1 );
	
	return 1;
}

CMD:s( playerid, params[] )
{
	if( IsMuted( playerid, IC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_IC );
		
	if( isnull( params ) )
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"�������: /s [ ����� ]");	
	
	format:g_small_string( "%s ������: %s",
		Player[playerid][uRPName],
		params
	);

	SendLong:( playerid, 35.0, g_small_string, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE3 );
	
	if( !IsPlayerInAnyVehicle( playerid ) ) 
		ApplyAnimation( playerid, "RIOT", "RIOT_shout", 4.0, 0, 1, 1, 0, 0, 1 );
		
	return 1;
}

CMD:pm( playerid, params[] )
{	
	new
	    server_tick = GetTickCount();
		
	if( GetPVarInt( playerid, "Player:PMTime" ) > server_tick )
		return SendClientMessage( playerid, C_WHITE, !""gbError"��������� ����� ��������� ������.");
	
	if( IsMuted( playerid, OOC ))
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_OOC );
		
	if( !Player[playerid][uPM] )
		return SendClient:(playerid, C_WHITE, ""gbError"������. �������� ����� ������ ���������." );
		
	if( sscanf( params, "us[144]", params[0], params[1] ) ) 
		return SendClientMessage(playerid, C_WHITE, !""gbDefault"�������: /pm [ ���/id ������ ] [ ����� ]");
		
	if( !IsLogged( params[0] ) || params[0] == playerid || IsPlayerNPC(params[0]) ) 
		return SendClientMessage( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( !Player[params[0]][uPM] )
		return SendClientMessage(playerid, C_WHITE, ""gbError"������ ����� �������� ���� ������ ���������.");
		
	format:g_small_string( "(( PM � %s[%d]: %s ))",
		GetAccountName( params[0] ),
		params[0],
		params[1]
	);
	
	SendLongNoRadius:( playerid, C_YELLOW, g_small_string );
	
	format:g_small_string( "(( PM �� %s[%d]: %s ))",
		GetAccountName( playerid ),
		playerid,
		params[1]
	);

	SendLongNoRadius:( params[0], C_YELLOW, g_small_string );
	
	SetPVarInt( playerid, "Player:PMTime", server_tick + 3500 );
	return 1;
}

CMD:afk( playerid, params[] ) 
{
    if( sscanf( params, "u", params[0] ) ) 
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"�������: /afk [ ���/id ������ ]" );
	
	if( !IsLogged( params[0] ) || params[0] == playerid || IsPlayerNPC(params[0]) ) 
		return SendClientMessage( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( !IsAfk( params[0] ) )
		return SendClientMessage( playerid, C_WHITE, !""gbDefault"������ ����� �� ��������� � AFK." );
		
	format:g_small_string( ""gbDefault"����� "cBLUE"%s[%d]"cWHITE" - AFK: "cBLUE"%d"cWHITE" ������(�).",
		Player[params[0]][uName],
		params[0],
		GetPVarInt( params[0], "Player:Afk" )
	);
	
	SendClient:( playerid, C_WHITE, g_small_string );
	
	return 1;
}

/*CMD:action( playerid )
{
	if( IsMuted( playerid, IC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_IC );
	
	if( Player[playerid][tAction] == Text3D: INVALID_3DTEXT_ID )
	{
		showPlayerDialog( playerid, d_commands, DIALOG_STYLE_INPUT, " ", 
		""cBLUE"���������� ��������\n\n"cWHITE"������� ����� ��������:", 
		"�����", "�������");
	}
	else
	{
		showPlayerDialog( playerid, d_commands + 1, DIALOG_STYLE_LIST, " ", 
		""cBLUE"-"cWHITE" ������� ��������\n\
		 "cBLUE"-"cWHITE" ���������� ����� ��������\n\
		 "cBLUE"-"cWHITE" ������� ��������", 
		"�����", "�������");
	}
	
	return 1;
}*/

CMD:pame( playerid, params[] )
{
	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, ""gbDefault"�������: /pame [ id ������ ]" );
	
	if( !IsLogged( params[0] ) || IsPlayerNPC(params[0]) ) 
		return SendClientMessage( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( isnull( Player[params[0]][uPame] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"�������� � �������� ������ �����������." );
	
	
	format:g_small_string( ""cWHITE"�������� "cBLUE"%s"cWHITE":\n\n%s", Player[params[0]][uName], Player[params[0]][uPame] );
	
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "�������", "" );
	
	return 1;
}

CMD:mypame( playerid )
{
	if( IsMuted( playerid, IC ) )
		return SendClientMessage( playerid, C_WHITE, !CHAT_MUTE_IC );
	
	if( isnull( Player[playerid][uPame] ) )
	{
		showPlayerDialog( playerid, d_commands + 4, DIALOG_STYLE_INPUT, " ", 
		""cBLUE"���������� �������� ���������.\n\n\
		"cWHITE"������� ����� ��������:", 
		"�����", "�������");
	}
	else
	{
		showPlayerDialog( playerid, d_commands + 5, DIALOG_STYLE_LIST, " ", 
		""cBLUE"-"cWHITE" ������� ��������\n\
		 "cBLUE"-"cWHITE" ���������� ����� ��������\n\
		 "cBLUE"-"cWHITE" ������� ��������", 
		"�����", "�������");
	}
	
	return 1;
}
/*
CMD:radio( playerid ) 
{
	clean:<g_big_string>;
	if( IsPlayerInAnyVehicle( playerid ) ) 
	{
		switch( GetVehicleModel( GetPlayerVehicleID( playerid ) ) ) 
		{
			case 448, 461, 462, 463, 468, 471, 481, 509, 510, 521, 522, 523, 581, 586: 
				return SendClient:( playerid, C_WHITE, ""gbError"�� �� ������ ������������ ����� � ������ ����������." );
		}
		
		if( GetPlayerVehicleSeat( playerid ) != 0 ) 
			return SendClient:( playerid, C_WHITE, ""gbError"�� ������ ���������� �� ���� ������������� ��������.");
		
		for( new i; i < sizeof radio_list; i++ ) 
		{
			format:g_small_string(  ""cBLUE"-"cWHITE" %s\n", radio_list[i][0] );
			strcat( g_big_string, g_small_string );
		}
		
		strcat( g_big_string, "���������\n" );
		
		showPlayerDialog(playerid, d_radio, DIALOG_STYLE_LIST, " ", g_big_string, "�������", "�������");
	}
	else if( Player[playerid][uRadio] ) 
	{
		if( !Player[playerid][uRadio] ) 
			return SendClient:(playerid, C_WHITE,""gbError"� ��� ��������� ����� � ��������.");
		
		for( new i; i < sizeof radio_list; i++ ) 
		{
			format:g_small_string(  ""cBLUE"-"cWHITE" %s\n", radio_list[i][0] );
			strcat( g_big_string, g_small_string );
		}
		
		strcat( g_big_string,"���������\n" );
		showPlayerDialog(playerid, d_radio, DIALOG_STYLE_LIST, " ", g_big_string, "�������", "�������");
	}
	
	return 1;
}

CMD:music( playerid )
{
	clean:<g_big_string>;
	
	if( IsPlayerInRangeOfPoint( playerid, 3.0, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ") ) ) 
	{
		for( new i; i < sizeof radio_list; i++ ) 
		{
			format:g_small_string(  ""cBLUE"-"cWHITE" %s\n", radio_list[i][0] );
			strcat( g_big_string, g_small_string );
		}
		
		showPlayerDialog(playerid, d_radio + 1, DIALOG_STYLE_LIST, " ", g_big_string, "�������", "�������");
	}
	
	return 1;
}*/

CMD:leaders( playerid, params[] ) 
{
	new 
		leaders;
		
	clean:<g_big_string>;
	
	foreach(new i: Player) 
	{
		if( !IsLogged(i) || !Player[i][uMember] ) continue;
			
		if( !PlayerLeaderFraction( i, Player[i][uMember] - 1 ) ) continue;
			
		format:g_small_string( ""cBLUE"-"cWHITE" %s\t"cBLUE"%s[%d]"cWHITE"\n", 
			Fraction[ Player[i][uMember] - 1 ][f_name], 
			Player[i][uName], i
		);
		
		strcat( g_big_string, g_small_string );
		
		leaders++;
	}
	
	if( !leaders )
		return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ������ ������� ����������� ��� � ����." );

	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, "������ �����������", g_big_string, "�������", "" );
	
	return 1;
}

CMD:time( playerid, params[] )
{
	static
		year, 
		month, 
		day, 
		hour, 
		minute, 
		second;
	
	getdate( year, month, day );
	gettime( hour, minute, second );

	clean:<g_big_string>;
	
	strcat( g_big_string, ""gbDefault"���������� � ������� � ����:\n\n" );
	format:g_small_string( " - �����: "cBLUE"%02d:%02d:%02d"cWHITE"\n", 
		hour, 
		minute,
		second
	);
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( " - ����: "cBLUE"%02d/%02d/%d"cWHITE"\n\n", 
		day, 
		month, 
		year
	);
	strcat( g_big_string, g_small_string );
	
	if( Player[playerid][uJailTime] > 0 )
	{
		new
			Float:interval = float( Player[playerid][uJailTime] - gettime() ) / 3600.0,
			jail_hour = floatround( interval, floatround_floor ),
			Float:interval_2 = ( interval - float( jail_hour ) ) * 3600.0 / 60.0,
			jail_minute = floatround( interval_2 );
			
		if( jail_hour < 0 ) jail_hour = jail_minute = 0;
	
		format:g_small_string( " - �������� � ���: "cBLUE"%d �. %d ���."cWHITE"\n", jail_hour, jail_minute );
		strcat( g_big_string, g_small_string );
	}
	else if( Player[playerid][uDMJail] )
	{
		format:g_small_string( " - �������� � �� �������: "cBLUE"%d"cWHITE" ���.\n", Player[playerid][uDMJail] );
		strcat( g_big_string, g_small_string );
	}
	else if( Player[playerid][uMute] )
	{
		format:g_small_string( " - �� ������ IC ���������� ����: "cBLUE"%d"cWHITE" ���.\n", Player[playerid][uMute] );
		strcat( g_big_string, g_small_string );
	}
	else if( Player[playerid][uBMute] )
	{
		format:g_small_string( " - �� ������ OOC ���������� ����: "cBLUE"%d"cWHITE" ���.\n", Player[playerid][uBMute] );
		strcat( g_big_string, g_small_string );
	}
	
	format:g_small_string( " - �� ���������� �����: "cBLUE"%d"cWHITE" �����.", 60 - Player[playerid][uPayTime] );
	strcat( g_big_string, g_small_string );
	
	if( Job[playerid][j_time] )
	{
		gmtime( Job[playerid][j_time], _, _, _, hour, minute );
	
		format:g_small_string( "\n - ������������ �������� �������� � "cBLUE"%02d:%02d"cWHITE" �����.", hour, minute );
		strcat( g_big_string, g_small_string );
	}
	
	if( Premium[playerid][prem_time] )
	{
		gmtime( Premium[playerid][prem_time], year, month, day );
		
		format:g_small_string( "\n - ���� �������� �������� �������� "cBLUE"%02d.%02d.%d", day, month, year );
		strcat( g_big_string, g_small_string );
	}
	
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�������", "" );
	
	return 1;
}

CMD:supports( playerid )
{
	if( !Premium[playerid][prem_supports] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	new
		support_count = 0;
				
	clean:<g_big_string>;
	strcat( g_big_string, ""gbDefault"�������� � ����:\n\n" );

	foreach(new i : Player) 
	{
		if( !IsLogged( i ) || !GetAccessSupport( i ) ) 
			continue;
		
		format:g_string( ""cBLUE"%s[%d]%s%s"cWHITE"\n",
			Player[i][uName],
			i,
			!GetPVarInt( i, "Support:Duty" ) ? (" - "cGRAY"[�� �� ���������]"cWHITE"") : ("")
		);
		
		++support_count;
		
		strcat( g_big_string, g_string );
	}
	
	if( support_count == 0 )
		strcat( g_big_string, "��������� ��� � ����.\n" );
	
	format:g_small_string(  "\n\n"cWHITE"����� ��������� � ����: "cBLUE"%d",
		support_count
	);
	
	strcat( g_big_string, g_small_string );
	
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�������", "");
	
	return 1;
}

CMD:clearchat( playerid, params[] ) 
{
	for( new i; i < 20; i++ ) 
		SendClient:( playerid, -1, " " );
		
	printf( "[Log]: Player %s[%d] has been cleared chat.", Player[playerid][uName], playerid );
	
	return 1;
}

CMD:pay( playerid, params[] ) 
{
	if( !Player[playerid][uLevel] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( sscanf( params, "ud", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /pay [ ���/id ������ ] [ ����� ]");
		
	if( !IsLogged( playerid ) || params[0] == playerid || IsPlayerNPC(params[0]) ) 
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( !Player[params[0]][uLevel] )
		return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ �������� ������ ����� ������." );
		
	if( GetDistanceBetweenPlayers( playerid,params[0] ) > 3.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !PLAYER_DISTANCE );
		
	if( Player[playerid][uMoney] < params[1] ) 
		return SendClient:( playerid, C_WHITE, !NO_MONEY);
		
	if( params[1] < 1 || params[1] > 100000 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"����������� ����� �������� - $1 | ������������ - $100.000.");

	SetPlayerCash( playerid, "-", params[1] );
	SetPlayerCash( params[0], "+", params[1] );

	pformat:( ""gbSuccess"�� �������� ������ "cBLUE"%s[%d]"cWHITE" - "cGREEN"$%d"cWHITE".",
		Player[params[0]][uName],
		params[0],
		params[1]
	);
	
	psend:( playerid, C_WHITE );
	
	pformat:( ""gbSuccess"����� "cBLUE"%s[%d]"cWHITE" ������� ��� - "cGREEN"$%d"cWHITE".",
		Player[playerid][uName],
		playerid,
		params[1]
	);
	
	psend:( params[0], C_WHITE );

	ApplyAnimation( playerid,"DEALER", "shop_pay",4.0, 0, 1, 1, 0, 0, 1 );
	
	format:g_small_string( "�������%s ������ %s'�", SexTextEnd( playerid ), Player[params[0]][uName] );
	SendRolePlayAction( playerid, g_small_string, RP_TYPE_AME );
	
	log( LOG_TRANSFER_MONEY, "������� ������", Player[playerid][uID], Player[params[0]][uID], params[1] ); 
	
	return 1;
}

CMD:members( playerid ) 
{
	if( !Player[playerid][uMember] && !Player[playerid][uCrimeM] ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( Player[playerid][uMember] )
	{
		new
			fid = Player[playerid][uMember] - 1,
			year, month, day,
			id;
		
		clean:<g_big_string>;
				
		format:g_small_string( ""cWHITE"������ ����������� "cBLUE"%s", Fraction[fid][f_name] );
		strcat( g_big_string, g_small_string );
						
		strcat( g_big_string, "\n\n"cWHITE"������:\n"cBLUE"" );
						
		foreach(new i: Player)
		{
			if( !IsLogged(i) ) continue;
							
			if( Player[i][uMember] == fid + 1 )
			{
				id = getRankId( i, fid );
							
				if( Player[i][uRank] ) format:g_string( "%s", FRank[fid][id][r_name] );
								
				format:g_small_string( "%s[%d] - %s\n", Player[i][uName], i, 
					!Player[i][uRank] ? ("��� �����") : g_string );
									
				strcat( g_big_string, g_small_string );
			}
		}
						
		strcat( g_big_string, "\n\n"cGRAY"" );
						
		for( new i; i < MAX_MEMBERS; i++ )
		{
			if( FMember[fid][i][m_id] )
			{
				year = month = day = 0;
				gmtime( FMember[fid][i][m_lasttime], year, month, day );
		
				if( FMember[fid][i][m_rank] ) format:g_string( "%s", FRank[fid][ FMember[fid][i][m_rank] - 1 ][r_name] );
		
				format:g_small_string( "%s[ac. %d] - %s - %02d.%02d.%d\n", FMember[fid][i][m_name], FMember[fid][i][m_id],
					!FMember[fid][i][m_rank] ? ("��� �����") : g_string,
					day, month, year );
									
				strcat( g_big_string, g_small_string );
			}
		}
						
		showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�������", "" );
	}
	else
	{
		ShowCrimeMembers( playerid, INVALID_DIALOG_ID, "�������", "" );
	}
	
	return 1;
}

CMD:doc( playerid )
{
	new
		amount,
		year, month, day;
		
	clean:<g_string>;
	strcat( g_string, ""cWHITE"���\t"cWHITE"�����������\t"cWHITE"����" );
	
	for( new i; i < MAX_DOCUMENT; i++ )
	{
		if( Document[playerid][i][d_id] )
		{
			gmtime( Document[playerid][i][d_date], year, month, day );
		
			format:g_small_string( "\n"cGRAY"%d. "cWHITE"%s\t"cBLUE"%s\t%02d.%02d.%d", 
				amount + 1, 
				document_type[ Document[playerid][i][d_type] ],
				Document[playerid][i][d_name], 
				day, month, year );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][amount] = i;
			amount++;
		}
	}
	
	if( !amount )
		return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ����������." );
		
	showPlayerDialog( playerid, d_meria + 13, DIALOG_STYLE_TABLIST_HEADERS, "��� ���������", g_string, "�������", "�������" );

	return 1;
}

/*CMD:play( playerid, params[] )
{
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /play [ id ����� ]");

	PlayerPlaySound( playerid, params[0], 0, 0, 0 );

	return 1;
}*/

CMD:dsmoke( playerid )
{
	if( !GetPVarInt( playerid, "Inv:UseSmokeId" ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"� ������ ������ �� �� ������." );
		
	DeletePVar( playerid, "Inv:UseSmokeId" );
	DeletePVar( playerid, "Inv:UseSmokeCount" );

	ClearAnimations( playerid );

	RemovePlayerAttachedObject( playerid, 5 );
		
	SendClient:( playerid, C_WHITE, !""gbSuccess"�� ��������� ��������." );

	return 1;
}

CMD:dbottle( playerid )
{
	if( !GetPVarInt( playerid, "Inv:UseDrinkId" ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"� ������ ������ �� �� �����." );
		
	DeletePVar( playerid, "Inv:UseDrinkId" );
	DeletePVar( playerid, "Inv:UseDrinkCount" );
	
	ClearAnimations( playerid );
	
	RemovePlayerAttachedObject( playerid, 5 );
		
	SendClient:( playerid, C_WHITE, !""gbSuccess"�� ��������� �������." );

	return 1;
}

CMD:fill( playerid, params[] )
{
	if( IsPlayerInAnyVehicle( playerid ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !getItem( playerid, INV_SPECIAL, PARAM_JERRYCAN ) )
		return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� � ����� ��������." );

	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /fill [ id ���������� (/dl) ]" );
		
	if( !GetVehicleModel( params[0] ) || IsVelo( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_VEHICLEID );
		
	if( !Vehicle[ params[0] ][vehicle_id] )
		return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ��������� ��������� ���������." );
		
	if( Vehicle[ params[0] ][vehicle_fuel] + 5.0 > VehicleInfo[ GetVehicleModel( params[0] ) - 400 ][v_fuel] )
		return SendClient:( playerid, C_WHITE, !""gbError"�������� ��� �� ����� �������� ����� ����������." );
		
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos( playerid, X, Y, Z );
		
	if( GetVehicleDistanceFromPoint( params[0], X, Y, Z ) > 5.0 )
		return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� ����� � �����������." );
		
	Vehicle[params[0]][vehicle_fuel] += 5.0;
	UpdateVehicleFloat( params[0], "vehicle_fuel", Vehicle[ params[0] ][vehicle_fuel] );
	
	pformat:( ""gbSuccess"�� ��������� "cBLUE"%s"cWHITE" � ������� �������� �� "cBLUE"5"cWHITE" �.", GetVehicleModelName( GetVehicleModel( params[0] ) ) );
	psend:( playerid, C_WHITE );
	
	useSpecialItem( playerid, PARAM_JERRYCAN );

	return 1;
}

CMD:donat( playerid ) return cmd_donate( playerid );

CMD:donate( playerid )
{
	mysql_format:g_small_string( "SELECT `uGMoney` FROM `"DB_USERS"` WHERE `uID` = %d", Player[playerid][uID] );
	mysql_tquery( mysql, g_small_string, "showDonatPanel", "i", playerid );

	return 1;
}

CMD:admins( playerid )
{
	if( !Premium[playerid][prem_admins] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	new
		fmt_player[32 + MAX_PLAYER_NAME + 2],
		admin_count = 0;
		
	clean:<g_big_string>;
	strcat( g_big_string, ""gbDefault"�������������� � ����:\n\n" );
	
	foreach(new i : Player) 
	{
		if( !IsLogged( i ) || !GetAccessAdmin( i, 1, false ) ) 
			continue;

		format( fmt_player, sizeof fmt_player, "(%d) "cBLUE"%s[%d]"cWHITE"",
			Admin[i][aLevel],
			Player[i][uName],
			i
		);
		
		format:g_small_string(  "%s%s\n",
			fmt_player,
			!GetPVarInt( i, "Admin:Duty" ) ? (" - "cRED"[�� �����������]"cGRAY"") : ("")
		);
	
		++admin_count;
		strcat( g_big_string, g_small_string );
	}
	
	if( !admin_count )
		strcat( g_big_string, ""cBLUE"���" );
		
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�������", "" );

	return 1;
}

CMD:limit( playerid, params[] )
{
	if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /limit [ ��������, 0 - ��������� ������������ ]" );
	
	new
		vehicleid = GetPlayerVehicleID( playerid );
	
	if( IsVelo( vehicleid ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( !params[0] )
	{
		Vehicle[vehicleid][vehicle_limit] = 0;
		
		pformat:( ""gbSuccess"�� ��������� ������������ �������� �� "cBLUE"%s"cWHITE".", GetVehicleModelName( GetVehicleModel(vehicleid) ) );
		psend:( playerid, C_WHITE );
	}
	else
	{
		if( params[0] < 20 || params[0] > 100 )
			return SendClient:( playerid, C_WHITE, !""gbDefault"������������ �������� �������� ���������� �� 20 �� 100 �/�." );
	
		Vehicle[vehicleid][vehicle_limit] = params[0];
		
		pformat:( ""gbSuccess"�� �������� ������������ �������� �� "cBLUE"%s"cWHITE": "cBLUE"%d"cWHITE" �/�.", GetVehicleModelName( GetVehicleModel(vehicleid) ), params[0] );
		psend:( playerid, C_WHITE );
	}

	return 1;
}

CMD:blind( playerid )
{
	if( !GetPVarInt( playerid, "Player:Blinded" ) )
	{
		TextDrawShowForPlayer( playerid, blind_background );
		SetPVarInt( playerid, "Player:Blinded", 1 );
	}
	else 
	{
		TextDrawHideForPlayer( playerid, blind_background );
		SetPVarInt( playerid, "Player:Blinded", 0 );
		GameTextForPlayer(playerid, "Unblind", 2000, 5 );
	}
	
	return 1;
}

CMD:help( playerid )
{
	return showPlayerDialog( playerid, d_help + 7, DIALOG_STYLE_MSGBOX, " ", d_help_start, "�����", "" );
}