Player_OnPlayerConnect( playerid )
{
	if( IsPlayerNPC( playerid ) ) 
		return BanEx( playerid, "Fake NPC" );
	
	PlayerPlaySound( playerid, 0, 0.0, 0.0, 0.0 );
	PlayerPlaySound( playerid, 1187, 0.0, 0.0, 0.0 );

	if( server_restart == 0 )
	{
		SendClient:( playerid, C_WHITE, ""gbDefault"Производится рестарт сервера. Пожалуйста, подождите." );
		gbKick( playerid );
		return 1;
	}
	
	SetPlayerColor( playerid, 0xFFFFFF00 );
	//PlayerPlaySound( playerid, 1097, 0.0, 0.0, 0.0 );
	
	ClearPlayerData( playerid ); 
	ClearPlayerPVarData( playerid );
	
	GetPlayerIp( playerid, Player[playerid][tIP], 16 );
	
	mysql_format:g_string( "SELECT `ipban_reason` FROM `"DB_IPBANS"` WHERE `ipban_ip` = '%s'", Player[playerid][tIP] );
	mysql_tquery( mysql, g_string, "OnPlayerIpBanned", "d", playerid );
	return 1;
}

function OnPlayerIpBanned(playerid)
{	
	if( cache_get_row_count() )
	{
		new 
			reason[ 32 ];
			
		cache_get_field_content( 0, "ipban_reason", reason, mysql );
		
	    SendClient:( playerid, C_WHITE, ""gbError"Вы не можете присоединиться к игре, Ваш IP адрес заблокирован.");
		
		if( !isnull( reason ) )
		{
			pformat:( ""gbDefault"Причина: "cBLUE"%s"cWHITE".", reason );
			psend:( playerid, C_WHITE );
		}
		
	    return gbKick( playerid );
	}
	
	return 1;
}

stock LoadPlayerAccount( playerid )
{	
	Player[playerid][uLevel] = cache_get_field_content_int(0, "uLevel", mysql);
	Player[playerid][uSex] = cache_get_field_content_int(0, "uSex", mysql);
	Player[playerid][uColor] = cache_get_field_content_int(0, "uColor", mysql);
	Player[playerid][uNation] = cache_get_field_content_int(0, "uNation", mysql);
	Player[playerid][uCountry] = cache_get_field_content_int(0, "uCountry", mysql);
	Player[playerid][uRole] = cache_get_field_content_int(0, "uRole", mysql);
	Player[playerid][uAge] = cache_get_field_content_int(0, "uAge", mysql);
	Player[playerid][uMoney] = cache_get_field_content_int(0, "uMoney", mysql);
	Player[playerid][uJob] = cache_get_field_content_int(0, "uJob", mysql);
	Player[playerid][uHP] = cache_get_field_content_float(0, "uHP", mysql);
	Player[playerid][uArmor] = cache_get_field_content_float(0, "uArmor", mysql);
	Player[playerid][uP][0] = cache_get_field_content_float(0, "uP1", mysql);
	Player[playerid][uP][1] = cache_get_field_content_float(0, "uP2", mysql);
	Player[playerid][uP][2] = cache_get_field_content_float(0, "uP3", mysql);
	Player[playerid][uLastTime] = cache_get_field_content_int(0, "uLastTime", mysql);
	Player[playerid][uInt][0] = cache_get_field_content_int(0, "uInt", mysql);
	Player[playerid][uInt][1] = cache_get_field_content_int(0, "uWorld", mysql);
	
	Player[playerid][uSuspect] = cache_get_field_content_int(0, "uSuspect", mysql);
	cache_get_field_content( 0, "uSuspectReason", Player[playerid][uSuspectReason], mysql ); 
	
	Player[playerid][uRadioChannel] = cache_get_field_content_int(0, "uRadioChannel", mysql);
	Player[playerid][uRadioSubChannel] = cache_get_field_content_int(0, "uRadioSubChannel", mysql);
	
	clean:<g_small_string>;
	cache_get_field_content(0, "uSettings", g_small_string, mysql);
	sscanf(g_small_string,"p<|>a<d>[11]", Player[playerid][uSettings]);
	
	clean:<g_small_string>;
	cache_get_field_content( 0, "uJailSettings", g_small_string, mysql ); 
	sscanf( g_small_string,"p<|>a<d>[5]",Player[playerid][uJailSettings] );
	
	clean:<g_small_string>;
	cache_get_field_content( 0, "favAnim", g_small_string, mysql); 
	sscanf( g_small_string, "p<|>a<d>[10]", Player[playerid][uAnimList] );
	
	clean:<g_small_string>;
	cache_get_field_content( 0, "favAnimParams", g_small_string, mysql );
	sscanf( g_small_string, "p<|>a<d>[10]", Player[playerid][uAnimListParam] );

	cache_get_field_content( 0, "uEmail", Player[playerid][uEmail], mysql, 64 ); 
	cache_get_field_content( 0, "uLastIP", Player[playerid][uLastIP], mysql );
	cache_get_field_content( 0, "uRegIP", Player[playerid][uRegIP], mysql );
	
	Player[playerid][uLeader] = cache_get_field_content_int(0, "uLeader", mysql);
	Player[playerid][uMember] = cache_get_field_content_int(0, "uMember", mysql);
	Player[playerid][uRank] = cache_get_field_content_int(0, "uRank", mysql);

	Player[playerid][uWarn] = cache_get_field_content_int(0, "uWarn", mysql);
	Player[playerid][uMute] = cache_get_field_content_int(0, "uMute", mysql);
	Player[playerid][uBMute] = cache_get_field_content_int(0, "uBMute", mysql);
	Player[playerid][uPayTime] = cache_get_field_content_int(0, "uPayTime", mysql);

	Player[playerid][uRegDate] = cache_get_field_content_int(0, "uRegDate", mysql);
	Player[playerid][uBank] = cache_get_field_content_int(0, "uBank", mysql);
	Player[playerid][uPM] = cache_get_field_content_int(0, "uPM", mysql);
	Player[playerid][uOOC] = cache_get_field_content_int(0, "uOOC", mysql);
	Player[playerid][uRO] = cache_get_field_content_int(0, "uRO", mysql);
	Player[playerid][uRadio] = cache_get_field_content_int(0, "uRadio", mysql);
	Player[playerid][uDMJail] = cache_get_field_content_int(0, "uDMJail", mysql);

	Player[playerid][uGMoney] = cache_get_field_content_int(0, "uGMoney", mysql);
	Player[playerid][uCheck] = cache_get_field_content_int(0, "uCheck", mysql);

	Player[playerid][uDeath] = cache_get_field_content_int(0, "uDeath", mysql);
	Player[playerid][uCrimeL] = cache_get_field_content_int(0, "uCrimeL", mysql);
	Player[playerid][uCrimeM] = cache_get_field_content_int(0, "uCrimeM", mysql);
	Player[playerid][uCrimeRank] = cache_get_field_content_int(0, "uCrimeRank", mysql);

	Player[playerid][uHouseEvict] = cache_get_field_content_int(0, "uHouseEvict", mysql);

	Player[playerid][uArrestStat] = cache_get_field_content_int(0, "uArrestStat", mysql);

	Player[playerid][uJail] = cache_get_field_content_int(0, "uJail", mysql);
	Player[playerid][uJailTime] = cache_get_field_content_int(0, "uJailTime", mysql);
	
	Job[playerid][j_time] = cache_get_field_content_int( 0, "uJobTime", mysql );
	
	cache_get_field_content( 0, "uPame", Player[playerid][uPame], mysql ); 
	Player[playerid][uHours] = cache_get_field_content_int(0, "uHours", mysql);
	
	Player[playerid][uChangeStyle] = cache_get_field_content_int(0, "uChangeStyle", mysql);
	
	clean:<g_small_string>;
	cache_get_field_content( 0, "uStyle", g_small_string, mysql ); 
	sscanf( g_small_string,"p<|>a<d>[5]",Player[playerid][uStyle] );

	new 
		Float: x, 
		Float: y, 
		Float: z, 
		Float: root;
		
	GetSpawnInfo( playerid, x, y, z, root );
	SetSpawnInfo( playerid, 264, setUseSkin( playerid, true ), x, y, z, root, 0, 0, 0, 0, 0, 0 );
	
	UpdatePlayer( playerid, "uStatus", 1 );
	UpdateWeather( playerid );
	stopPlayer( playerid, 3 );
	
	Player[playerid][tFirstTime] = gettime();
	Player[playerid][uHP] = Player[playerid][uHP] < 25.0 ? 25.0 : Player[playerid][uHP];

	CancelSelectTextDraw( playerid );
	
	ShowRadioInfo( playerid, Player[playerid][uSettings][8] );
	ShowServerLogo( playerid, Player[playerid][uSettings][9] );

	SetPlayerColor( playerid, 0xFFFFFF00 );
	SetPlayerScore( playerid, Player[playerid][uLevel] );
	return 1;
}

Player_OnPlayerDisconnect( playerid, reason )
{
	if( Player[playerid][uSuspect] != 0 && GetPVarInt( playerid,"Player:Cuff" ) || GetPVarInt( playerid, "Player:Follow" ) != INVALID_PLAYER_ID ) 
	{
        Player[playerid][uJail] = 1;
        Player[playerid][uJailTime] = gettime() + 2880 * 60;
		
        Player[playerid][uSuspect] = 0;
		Player[playerid][uSuspectReason][0] = EOS;
	}
	
	if( GetPVarInt( playerid, "Player:Follow" ) != INVALID_PLAYER_ID ) 
	{
		SetPVarInt( GetPVarInt( playerid,"Player:Follow" ), "Player:Lead", INVALID_PLAYER_ID );
	}
	else if( GetPVarInt( playerid, "Player:Lead" ) != INVALID_PLAYER_ID )
	{
		SetPVarInt( GetPVarInt( playerid,"Player:Lead" ), "Player:Follow", INVALID_PLAYER_ID );
	}
	
	if( GetPVarInt( playerid, "Fraction:UseBK" ) )
	{
		BackupClear( playerid );
	}
	
	if( GetPVarInt( playerid, "Passenger:InVehicle" ) )
	{
		Vehicle[ GetPVarInt( playerid, "Passenger:VehicleID" ) ][vehicle_seat] --;
	}
	
	format:g_small_string("(( %s[%d] ", GetAccountName( playerid ), playerid );
	
	switch( reason )
	{
		case 0 : strcat( g_small_string, "вылетел. ))" );
		case 1 : strcat( g_small_string, "вышел. ))" );
		case 2 : strcat( g_small_string, "отсоединён. ))" );
	}
	
	ProxDetector( 20.0, playerid, g_small_string, COLOR_FADE2, COLOR_FADE3, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5, 3 );
	
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "\
		INSERT INTO "DB_SESSIONS" (session_name, session_ip, session_time_start, session_time_end, session_end_reason) \
			VALUES \
		('%s', '%s', %d, %d, %d ) \
		",
		GetAccountName( playerid ),
		Player[playerid][tIP],
		Player[playerid][tFirstTime],
		gettime(),
		reason
	);
	
	mysql_tquery( mysql, g_string );
	
	if( Player[playerid][tAction] != Text3D: INVALID_3DTEXT_ID )
	{
		if( IsValidDynamic3DTextLabel( Player[playerid][tAction] ) )
		{
			DestroyDynamic3DTextLabel( Player[playerid][tAction] );
		}
		
		Player[playerid][tAction] = Text3D: INVALID_3DTEXT_ID;
		clean:<Player[playerid][tActionText]>;
	}
		
	if( Player[playerid][jTaxi] || Player[playerid][jMech] || Player[playerid][jPolice] )
	{
		for( new i; i < MAX_TAXICALLS; i++ )
		{
			if( Player[playerid][jTaxi] )
			{
				Player[playerid][jTaxi] = false;
				
				Taxi[i][t_playerid] = INVALID_PARAM;
				Taxi[i][t_time] = 0;
				
				Taxi[i][t_place][0] =
				Taxi[i][t_zone][0] = EOS;
			
				Taxi[i][t_pos][0] =
				Taxi[i][t_pos][1] =	
				Taxi[i][t_pos][2] = 0.0;				
			}
			
			if( Player[playerid][jMech] )
			{
				Player[playerid][jMech] = false;
			
				Mechanic[i][m_playerid] = INVALID_PARAM;
				Mechanic[i][m_time] = 0;
				
				Mechanic[i][m_place][0] =
				Mechanic[i][m_zone][0] = EOS;
			
				Mechanic[i][m_pos][0] =
				Mechanic[i][m_pos][1] =	
				Mechanic[i][m_pos][2] = 0.0;	
			}
			
			if( Player[playerid][jPolice] )
			{
				Player[playerid][jPolice] = false;
				
				CPolice[i][p_playerid] = 
				CPolice[i][p_time] = 
				CPolice[i][p_status] = 
				CPolice[i][p_type] = 0;
					
				CPolice[i][p_number][0] =
				CPolice[i][p_descript][0] = 
				CPolice[i][p_zone][0] = EOS;
				
				CPolice[i][p_pos][0] =
				CPolice[i][p_pos][1] = 
				CPolice[i][p_pos][2] = 0.0;
			}
		}
	}
	
	if( GetPVarInt( playerid, "Hpanel:Playerid" ) )
	{
		g_player_interaction{ GetPVarInt( playerid, "Hpanel:Playerid" ) } = 0;
	}
	
	if( GetPVarInt( playerid, "Inv:CarId" ) != INVALID_PARAM )
	{
		Vehicle[ GetPVarInt( playerid, "Inv:CarId" ) ][vehicle_use_boot] = false;
	}
	
	checkPlayerUseTexViewer( playerid );
	SavePlayerData( playerid );
	
	return 1;
}

stock SavePlayerData( playerid )
{
	new
		world,
		interior;

	if( IsPlayerInAnyVehicle( playerid ) ) 
	{
		GetVehiclePos( GetPlayerVehicleID( playerid ), Player[playerid][tPos][0], Player[playerid][tPos][1], Player[playerid][tPos][2]);
		
		world = GetPlayerVirtualWorld( playerid );
		interior = GetPlayerInterior( playerid );
	}
    else 
	{
		switch( GetPVarInt( playerid, "Player:World" ) )
		{
			//Если игрок выбирает мебель 'Разное'
			case 5:
			{
				Player[playerid][tPos][0] = BusinessInfo[GetPVarInt( playerid, "Bpanel:BId" )][b_exit_pos][0];
				Player[playerid][tPos][1] = BusinessInfo[GetPVarInt( playerid, "Bpanel:BId" )][b_exit_pos][1];
				Player[playerid][tPos][2] = BusinessInfo[GetPVarInt( playerid, "Bpanel:BId" )][b_exit_pos][2];
				
				world = BusinessInfo[GetPVarInt( playerid, "Bpanel:BId" )][b_id];
				interior = 0;
			}
			//Если игрок выбирает мебель
			case 10:
			{
				Player[playerid][tPos][0] = -489.8045; 
				Player[playerid][tPos][1] = -262.2372;
				Player[playerid][tPos][2] =	3095.8960;
				
				world = GetPVarInt( playerid, "Furn:IntWorld" );
				interior = 1;
			}
			//Если игрок выбирает машину
			case 15:
			{
				Player[playerid][tPos][0] = 1490.7559; 
				Player[playerid][tPos][1] = 764.9916;
				Player[playerid][tPos][2] =	2001.0859;
				
				world = GetPVarInt( playerid, "Salon:Shop" ) + 10;
				interior = 1;
			}
		
			default: 
			{
				GetPlayerPos( playerid, Player[playerid][tPos][0], Player[playerid][tPos][1], Player[playerid][tPos][2] );
				
				world = GetPlayerVirtualWorld( playerid );
				interior = GetPlayerInterior( playerid );
			}
		}
	}

    if( Player[playerid][tPos][0] != 0.0 ) 
	{
		clean:<g_string>;
		mysql_format( mysql, g_string, sizeof g_string,
			"UPDATE "DB_USERS" \
			 SET \
				uP1 = %f, \
				uP2 = %f, \
				uP3 = %f, \
				uInt = %d, \
				uWorld = %d \
			WHERE uID = %d",
			Player[playerid][tPos][0],
			Player[playerid][tPos][1],
			Player[playerid][tPos][2],
			interior,
			world,
			Player[playerid][uID]
		);
		
		mysql_tquery( mysql, g_string );
		
    }
	
	//Если надет бронежилет
	for( new i; i < MAX_INVENTORY_USE; i++ )
	{
		if( inventory[ getInventoryId( UseInv[playerid][i][inv_id] ) ][i_type] == INV_ARMOUR )
		{
			new
				Float:amount;
		
			GetPlayerArmour( playerid, amount );
			if( floatround( amount ) < UseInv[playerid][i][inv_param_1] )
				Player[playerid][uArmor] = amount;
			
			break;
		}
	}
	
    clean:<g_big_string>;
	mysql_format( mysql, g_big_string, sizeof g_big_string,
		"UPDATE "DB_USERS" \
		 SET \
			uSuspect = %d, \
			uSuspectReason = '%e', \
			uStatus = 0, \
			uMute = %d, \
			uMoney = %d, \
			uBank = %d, \
			uJailSettings = '%d|%d|%d|%d|%d', \
			uDMJail = %d, \
			uBMute = %d, \
			uPayTime = %d, \
			uDeath = %d, \
			uLastTime = %d, \
			uLastIP = '%s', \
			uHP = %f, \
			uArmor = %f, \
			uJail = %d, \
			uJailTime = %d \
		WHERE \
			uID = %d",
		Player[playerid][uSuspect], 
		Player[playerid][uSuspectReason], 
		Player[playerid][uMute], 
		Player[playerid][uMoney],
		Player[playerid][uBank],
		Player[playerid][uJailSettings][0],
		Player[playerid][uJailSettings][1],
		Player[playerid][uJailSettings][2],
		Player[playerid][uJailSettings][3],
		Player[playerid][uJailSettings][4],
		Player[playerid][uDMJail],
		Player[playerid][uBMute], 
		Player[playerid][uPayTime],
		Player[playerid][uDeath],
		gettime(),
		Player[playerid][tIP],
		Player[playerid][uHP],
		Player[playerid][uArmor],
		Player[playerid][uJail],
		Player[playerid][uJailTime],
		Player[playerid][uID]
	);
	
	mysql_tquery( mysql, g_big_string );
	
	SaveAmmoForUseWeapon( playerid );
	SavePlayerSettings( playerid );
	
	printf("[Save]: Account %s[%d] has been saved.", Player[playerid][uName], playerid );
	return 1;
}

stock EndLoadPlayerData( playerid )
{
	g_player_login{playerid} = 1;
	
	g_player_gun_protect{playerid} = 
	g_player_airbreak_protect{playerid} =
	g_player_hp_protect{playerid} =	ANTICHEAT_EXCEPTION_TIME;
	
	pformat:( ""gbSuccess"Вы успешно авторизовались, "cBLUE"%s"cWHITE".", GetAccountName( playerid ) );
	psend:( playerid, C_WHITE );
	
	pformat:( ""gbSuccess"Чтобы открыть меню, используйте клавишу "cBLUE"Y"cWHITE"." );
	psend:( playerid, C_WHITE );
	
	GetWithoutUnderscore( Player[playerid][uName], Player[playerid][uRPName] );
	
	DeletePVar( playerid, "Login:Joined" );
	togglePlayerSpectating( playerid, 0 );
	
	//SpawnPlayer( playerid );
}

function OnPlayerLogin( playerid, pass[] ) 
{
	clean_array();
	
	new 
		rows, 
		fields,
		password[ 65 ],
		hash[ 64 + 1 ];
		
    cache_get_data( rows, fields );
	
	cache_get_field_content( 0, "uPass", password, mysql, 65 );
	SHA256_PassHash( pass, "58gdm42bit9", hash, sizeof hash );
	
	if( strcmp( hash, password, true) )
    {
		if( GetPVarInt( playerid, "Login:WrongPass" ) == 2 ) 
		{
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", errortext, "Закрыть", "" );
			gbKick( playerid );
			return 1;
		}
		
		GivePVarInt( playerid, "Login:WrongPass", 1 );
		format:g_small_string(  ""gbError"Вы ввели неверный пароль. Осталось попыток: "cBLUE"%d/3", GetPVarInt( playerid, "Login:WrongPass" ) );
		SendClientMessage( playerid, C_WHITE, g_small_string );
		
		format:g_string( logtext, GetAccountName( playerid ) );
		return showPlayerDialog( playerid, d_auth, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
	}
	
	SetPVarInt( playerid, "Login:Auth", 1 );

	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_ITEMS " WHERE `item_type` < 2 AND item_type_id = %d", Player[playerid][uID] );
	mysql_tquery( mysql, g_string, "LoadPlayerInventory", "i", playerid );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_ADMINS " WHERE aUserID = %d", Player[playerid][uID]);
	mysql_tquery( mysql, g_string, "LoadAdminAccount", "i", playerid );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_SUPPORTS " WHERE sUserID = %d", Player[playerid][uID]);
	mysql_tquery( mysql, g_string, "LoadSupportAccount", "i", playerid);
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_VEHICLES " WHERE vehicle_user_id = %d", Player[playerid][uID]);
	mysql_tquery( mysql, g_string, "LoadVehicle", "i", playerid );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PHONES " WHERE p_user_id = %d", Player[playerid][uID] );
	mysql_tquery( mysql, g_string, "LoadPhones", "i", playerid );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_LICENSES " WHERE license_user_id = %d", Player[playerid][uID] );
	mysql_tquery( mysql, g_string, "LoadLicenses", "i", playerid );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PENALTIES " WHERE `pen_name` = '%s'", Player[playerid][uName] );
	mysql_tquery( mysql, g_string, "LoadPlayerPenalty", "i", playerid );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_DOCUMENT " WHERE `d_user_id` = %d ORDER BY `d_id`", Player[playerid][uID] );
	mysql_tquery( mysql, g_string, "LoadDocument", "i", playerid );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PRISON " WHERE `puID` = %d AND `pStatus` = 1", Player[playerid][uID] );
	mysql_tquery( mysql, g_string, "LoadForPlayerPrison", "i", playerid );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PREMIUM " WHERE `prem_user_id` = %d", Player[playerid][uID] );
	mysql_tquery( mysql, g_string, "LoadPremiumAccount", "i", playerid );
	
	LoadHouseForPlayer( playerid );
	LoadBusinessForPlayer( playerid );
	LoadPlayerAccount( playerid );
		
	EndLoadPlayerData( playerid );
	
	return 1;
}

function OnPlayerOldLogin( playerid, password[] )
{
	if( !cache_get_row_count() )
	{
		if( GetPVarInt( playerid, "Login:WrongPass" ) == 2 ) 
		{
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", "\
				"gbError"Информация\n\n\
				Вы были отсоединены от сервера за неправильный ввод данных.", "Закрыть", "" );
			return gbKick( playerid );
		}
		
		GivePVarInt( playerid, "Login:WrongPass", 1 );
		
		format:g_small_string(  ""gbError"Вы ввели неверный пароль. Осталось попыток: "cBLUE"%d/3", GetPVarInt( playerid, "Login:WrongPass" ) );
		SendClientMessage( playerid, C_WHITE, g_small_string );
		
		format:g_string( logtextold, Player[playerid][uName] );
		return showPlayerDialog( playerid, d_auth + 1, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
	}
	
	new
		hash [ 64 + 1 ];

	SHA256_PassHash( password, "58gdm42bit9", hash, sizeof hash );
	cache_get_field_content( 0, "uEmail", Player[playerid][uEmail], mysql, 64 ); 
	
	printf( "[Log MAIL] %s[%d] = %s", Player[playerid][uName], playerid, Player[playerid][uEmail] );
	
	if( mail_is_valid( Player[playerid][uEmail] ) )	
	{
		strcat( Player[playerid][uHash], hash, 64 + 1 );
		
		Player[playerid][uSex] = cache_get_field_content_int(0, "uSex", mysql);
		Player[playerid][uColor] = cache_get_field_content_int(0, "uColor", mysql);
		Player[playerid][uNation] = cache_get_field_content_int(0, "uNation", mysql);
		Player[playerid][uCountry] = cache_get_field_content_int(0, "uCountry", mysql);
		Player[playerid][uAge] = cache_get_field_content_int(0, "uAge", mysql);
		Player[playerid][uMoney] = cache_get_field_content_int(0, "uMoney", mysql);
		Player[playerid][uGMoney] = cache_get_field_content_int(0, "uGMoney", mysql);
		Player[playerid][uRegDate] = gettime();
		
		format:g_string( "\
			"cBLUE"Регистрация: почта\n\n\
			"cWHITE"Аккаунт "cBLUE"%s"cWHITE" привязан к почтовому ящику "cBLUE"%s"cWHITE".\n\
			Вы желаете отправить на данный адрес код подтверждения?\n\n\
			"gbDialog"Без кода подтверждения Вы не сможете завершить регистрацию.\n\
			"gbDialog"Отказываясь, Вы будете отключены от сервера.",
			Player[playerid][uName],
			Player[playerid][uEmail] );
			
		showPlayerDialog( playerid, d_auth + 12, DIALOG_STYLE_MSGBOX, " ", g_string, "Да", "Нет" );
	}
	else
	{
		SendClient:( playerid, C_WHITE, !""gbError"Привязанный к аккаунту E-Mail адрес некорректен. Обратитесь за помощью к администрации." );
		gbKick( playerid );
	}
	
	return 1;
}

function OnPlayerBanned( playerid ) 
{
	if( !cache_get_row_count() )
	{
	    return 0;
	}

    new
    	hide = cache_get_field_content_int( 0, "bHide", mysql ),
		firstdate = cache_get_field_content_int( 0, "bDate", mysql ),
		lastdate = cache_get_field_content_int( 0, "bLastDate", mysql ),
		admin_id = cache_get_field_content_int( 0, "bAdminID", mysql ),
		admin_name[ MAX_PLAYER_NAME ],
		reason[ 64 ];

	clean:<g_small_string>;
	cache_get_field_content( 0, "bReason", g_small_string, mysql, 64 );
	strmid( reason, g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );

	clean:<g_small_string>;
	cache_get_field_content( 0, "bAdminName", g_small_string, mysql, MAX_PLAYER_NAME );
	strmid( admin_name, g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
    
	clean_array();

	if( lastdate > gettime() ) 
	{
		strcat( g_big_string, ""gbError"Ваш аккаунт заблокирован на сервере.\n\n");
		format:g_small_string(  "- Имя: "cBLUE"%s"cWHITE"\n", GetAccountName( playerid ) ), strcat( g_big_string, g_small_string);
		format:g_small_string(  "- Дата блокирования: "cBLUE"%s"cWHITE"\n", date("%hh:%ii:%ss %dd/%mm/%yy", firstdate) ), strcat( g_big_string, g_small_string);

		if( lastdate == INFINITY_DATE ) 
		{
			strcat( g_big_string, "- Дата разблокирования: "cBLUE"Никогда"cWHITE"\n");
		} 
		else 
		{
			format:g_small_string( "- Дата разблокирования: "cBLUE"%s"cWHITE"\n", date("%hh:%ii:%ss %dd/%mm/%yy", lastdate) );
			strcat( g_big_string, g_small_string);
		}
		
		if( admin_id != -1 && !hide )
		{
			format:g_small_string( "- Администратор: "cBLUE"%s"cWHITE"\n", admin_name ); 
			strcat( g_big_string, g_small_string);
		}
		
		format:g_small_string( "- Причина: "cBLUE"%s"cWHITE"", reason ), 
		strcat( g_big_string, g_small_string);
		
		showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
		
		return gbKick( playerid );
		
    } 
	else 
	{
		mysql_format( mysql, g_string, sizeof g_string, "DELETE FROM "DB_BANS" WHERE bUserID = %d", Player[playerid][uID]);
		mysql_tquery( mysql, g_string, "", "" );
		SendClientMessage( playerid, C_WHITE, ""gbSuccess"Срок блокировки истёк, Ваш аккаунт разблокирован." );
	}
	
    clean_array();
	
	return 1;
}

function Player_OnPlayerSpawn( playerid ) 
{	
	if( GetPVarInt( playerid, "Login:Joined" ) ) 
		return 1;

	if( GetPVarInt( playerid, "Join:Timer" ) )
	{
		setPlayerHealth( playerid, Player[playerid][uHP] );
		
		if( floatround( Player[playerid][uArmor] ) )
			setPlayerArmour( playerid, Player[playerid][uArmor] );
		
		togglePlayerControllable( playerid, 1 );
		DeletePVar( playerid, "Join:Timer" );
		
		//Загрузка контактов и сообщений в телефоне активного слота
		if( GetPhoneNumber( playerid ) )
		{
			clean:<g_string>;
			mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PHONES_CONTACTS " WHERE p_owner = %d ORDER BY `p_id`", GetPhoneNumber( playerid ) );
			mysql_tquery( mysql, g_string, "LoadContacts", "d", playerid );
				
			clean:<g_string>;
			mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PHONES_MESSAGES " WHERE m_number = %d OR m_numberto = %d ORDER BY `m_id`", GetPhoneNumber( playerid ), GetPhoneNumber( playerid ) );
			mysql_tquery( mysql, g_string, "LoadMessages", "d", playerid );
		}
	}

	PreloadAnim( playerid );
	
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
	
	if( GetPVarInt( playerid, "Player:Cuff" ) ) 
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
        SetPlayerAttachedObject(playerid, 4, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
	}
	
	PlayerPlaySound(playerid, 1098, 0.0, 0.0, 0.0);
	
	if( GetPVarInt( playerid, "Player:Follow" ) != INVALID_PLAYER_ID ) 
	{
		SetPVarInt( GetPVarInt( playerid,"Player:Follow" ), "Player:Lead", INVALID_PLAYER_ID );
	}
	else if( GetPVarInt( playerid, "Player:Lead" ) != INVALID_PLAYER_ID )
	{
		SetPVarInt( GetPVarInt( playerid,"Player:Lead" ), "Player:Follow", INVALID_PLAYER_ID );
	}
	
	SetPlayerInterior( playerid, Player[playerid][uInt][0] );
	SetPlayerVirtualWorld(playerid, Player[playerid][uInt][1] );
	
	SetPlayerFightingStyleEx( playerid );
	
	return 1;
}

function Player_OnPlayerRequestClass( playerid ) 
{
	if( IsPlayerNPC( playerid ) ) 
		return 1;
		
   	if( IsLogged( playerid ) ) 
		return SpawnPlayer(playerid);
  
	SetPVarInt( playerid, "Login:Joined", 1 );
	togglePlayerSpectating( playerid, 1 );
	
	if( !GetPVarInt( playerid, "Login:Auth" ) )
		OnPlayerJoin( playerid );
	
    return 1;
}

function OnPlayerJoin( playerid ) 
{
	SetTimerEx( "SetConnectCameraPos", 200, false, "i", playerid );
	GetPlayerName( playerid, Player[playerid][uName], MAX_PLAYER_NAME );
	
	ShowServerLogo( playerid, true );
	
	clean:<g_string>;
    mysql_format( mysql, g_string, sizeof g_string, "SELECT `uID`, `uActive`, `uRetest`, `uPinCode` FROM `gb_users` WHERE `uName` = '%s' LIMIT 1", Player[playerid][uName] );
	mysql_tquery( mysql, g_string, "OnPlayerAccount", "d", playerid);
	
	SetPVarInt( playerid, "Join:Timer", 1 );
    
	return 1;
}

function OnPlayerAccount( playerid ) 
{	
    if( !cache_get_row_count() ) 
	{
		/*showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", regtext, "Выход", "" );
		return gbKick(playerid);
		
		clean:<g_string>;
		mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM `gb_users_old` WHERE `uName` = '%s' LIMIT 1", Player[playerid][uName] );
		mysql_tquery( mysql, g_string, "OnPlayerOldAccount", "d", playerid );*/
		
		if( !CheckNormalName( playerid ) )
		{
			format:g_string( regnick, Player[playerid][uName] );
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_string, "Закрыть", "" );
			
			return gbKick( playerid );
		}
	
		format:g_string( regpass, GetAccountName( playerid ) );
		showPlayerDialog( playerid, d_auth + 4, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
		
		return 1;
	}
				
	Player[playerid][uID] = cache_get_field_content_int( 0, "uID", mysql );
	Player[playerid][uPinCode] = cache_get_field_content_int( 0, "uPinCode", mysql );

	mysql_format:g_string( "SELECT bAdminID, bAdminName, bDate, bLastDate, bReason, bHide FROM "DB_BANS" WHERE bUserID = %d", Player[playerid][uID]);
	mysql_tquery( mysql, g_string, "OnPlayerBanned", "i", playerid );
	
	format:g_string( logtext, GetAccountName( playerid ) );
	showPlayerDialog( playerid, d_auth, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
	
	/*switch( cache_get_field_content_int( 0, "uActive", mysql ) )
	{
		case 0 : 
		{
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", checktext, "Выйти", "" );
			return gbKick( playerid );
		}
		case 1 :
		{
			if( cache_get_field_content_int( 0, "uRetest", mysql ) != 0 )
			{
				showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", retesttext, "Закрыть", "" );
				return gbKick( playerid );
			}
			
			showPlayerDialog( playerid, d_auth, DIALOG_STYLE_PASSWORD, " ", logtext, "Далее", "Выйти" );
		}
		case 2 :
		{
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", unactive, "Выйти", "" );
			return gbKick( playerid );
		}
		
		case 3 :
		{
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", cktext, "Выйти", "" );
			return gbKick( playerid );
		}
	}*/
	
	return 1;
}

function OnPlayerOldAccount( playerid ) 
{
	if( !cache_get_row_count() ) //Если аккаунт не найден в базе данных, вызываем диалог регистрации
	{
		if( !CheckNormalName( playerid ) )
		{
			format:g_string( regnick, Player[playerid][uName] );
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_string, "Закрыть", "" );
			
			return gbKick( playerid );
		}
	
		format:g_string( regpass, GetAccountName( playerid ) );
		showPlayerDialog( playerid, d_auth + 4, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
		
		return 1;
	}
	
	format:g_string( logtextold, Player[playerid][uName] );
	showPlayerDialog( playerid, d_auth + 1, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );

	return 1;
}

Player_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	#pragma unused listitem
	clean_array();
	switch(dialogid) 
	{
		case d_auth: 
		{
			if( !response) 
				return gbKick(playerid);
				
			if( inputtext[0] == EOS ) 
			{
				format:g_string( logtext, GetAccountName( playerid ) );
				return showPlayerDialog( playerid, d_auth, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти");
			}
			
			if( !CheckNormalPassword( inputtext ) ) 
			{
				format:g_string( logtext, GetAccountName( playerid ) );
				return showPlayerDialog( playerid, d_auth, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти");
			}
			
			clean:<g_string>;
			mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM `" #DB_USERS "` WHERE `uID` = %d", Player[playerid][uID] );
			mysql_tquery( mysql, g_string, "OnPlayerLogin", "is", playerid, inputtext );
		}
		
		case d_auth + 1:
		{
			if( !response )
				return gbKick( playerid );
				
			if( inputtext[0] == EOS ) 
			{
				format:g_string( logtextold, Player[playerid][uName] );
				return showPlayerDialog( playerid, d_auth + 1, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
			}
			
			if( !CheckNormalPassword( inputtext ) ) 
			{
				format:g_string( logtextold, Player[playerid][uName] );
				return showPlayerDialog( playerid, d_auth + 1, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
			}
			
			mysql_format:g_small_string( "SELECT * FROM `gb_users_old` WHERE `uPass` = md5(md5('%s')) AND BINARY `uName` = '%s'", inputtext, GetAccountName( playerid ) );
			mysql_tquery( mysql, g_small_string, "OnPlayerOldLogin", "is", playerid, inputtext );
		}
		/*
		case d_auth + 2: //Диалог кода подтверждения
		{
			if( !response )
				return gbKick( playerid );
				
			if( !IsNumeric( inputtext ) || strval( inputtext ) != Player[playerid][uConfirm] )
			{
				format:g_string( logerror, Player[playerid][uEmail] );
				return showPlayerDialog( playerid, d_auth + 2, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Выйти" );
			}
			
			new 
				rand = random( sizeof hotel_spawn_random ),
				Float: x = hotel_spawn_random[rand][0],
				Float: y = hotel_spawn_random[rand][1], 
				Float: z = hotel_spawn_random[rand][2], 
				Float: root = hotel_spawn_random[rand][3];
				
			SetSpawnInfo( playerid, 264, setUseSkin( playerid, true ), x, y, z, root, 0, 0, 0, 0, 0, 0 );
			
			UpdatePlayer( playerid, "uStatus", 1 );
			UpdateWeather( playerid );
			stopPlayer( playerid, 3 );
			
			Player[playerid][tFirstTime] = gettime();
			Player[playerid][uHP] = 100.0;
			
			ShowRadioInfo( playerid, Player[playerid][uSettings][8] );
			ShowServerLogo( playerid, Player[playerid][uSettings][9] );

			SetPlayerColor( playerid, 0xFFFFFF00 );
			SetPlayerScore( playerid, 1 );

			g_player_login{playerid} = 1;
			
			g_player_gun_protect{playerid} = 
			g_player_airbreak_protect{playerid} =
			g_player_hp_protect{playerid} =	ANTICHEAT_EXCEPTION_TIME;
			
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", regtext, "Закрыть", "" );
			
			format:g_small_string( ""ADMIN_PREFIX" Новый персонаж %s[%d] - email: %s - IP: %s",
				Player[playerid][uName],
				playerid,
				Player[playerid][uEmail],
				Player[playerid][tIP]
			);
			
			SendAdminMessage( C_DARKGRAY, g_small_string );
			
			GetWithoutUnderscore( Player[playerid][uName], Player[playerid][uRPName] );
			
			DeletePVar( playerid, "Login:Joined" );
			togglePlayerSpectating( playerid, 0 );
			
			//SpawnPlayer( playerid );
		}
		*/
		case d_auth + 3: //Подтверждение выбора скина
		{
			if( !response )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Skin:Show", 1 );
				return 1;
			}
		
			mysql_format:g_string( "\
				INSERT INTO `"DB_USERS"` \
					( `uName`, `uEmail`, `uPass`, `uSex`, `uColor`, `uNation`, `uCountry`, `uAge`, `uMoney`, `uRegIP`, `uRegDate`, `uGMoney` ) \
				VALUES \
					( '%s', '%s', '%s', %d, %d, %d, %d, %d, %d, '%s', %d, %d )",
					Player[playerid][uName],
					Player[playerid][uEmail],
					Player[playerid][uHash],
					Player[playerid][uSex],
					Player[playerid][uColor],
					Player[playerid][uNation],
					Player[playerid][uCountry],
					Player[playerid][uAge],
					Player[playerid][uMoney],
					Player[playerid][tIP],
					Player[playerid][uRegDate],
					Player[playerid][uGMoney]
				);
			mysql_tquery( mysql, g_string, "GetNewAccountId", "ii", playerid, GetPVarInt( playerid, "Skin:Choose" ) );
		
			//format:g_string( logtexmail, Player[playerid][uEmail] );
			//showPlayerDialog( playerid, d_auth + 2, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Выйти" );
			
			showChooseSkin( playerid, 0 );
			
			Player[playerid][uSettings][0] = 
			Player[playerid][uSettings][2] = 
			Player[playerid][uSettings][3] = 
			Player[playerid][uSettings][4] = 
			Player[playerid][uSettings][5] = 
			Player[playerid][uSettings][9] = 
			Player[playerid][uSettings][10] = 1;
			
			Player[playerid][uOOC] = 
			Player[playerid][uRO] =
			Player[playerid][uPM] = 1;
		}
		
		case d_auth + 4: //Ввода пароля
		{
			if( inputtext[0] == EOS || !CheckNormalPassword( inputtext ) || strlen( inputtext ) < 8 || strlen( inputtext ) > 20 )
			{
				format:g_string( regpass, GetAccountName( playerid ) );
				strcat( g_string, "\n\n"gbDialogError"Неправильный формат пароля." );
				
				return showPlayerDialog( playerid, d_auth + 4, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
			}
			
			clean:<Player[playerid][uHash]>;
			strcat( Player[playerid][uHash], inputtext, 65 );
			
			showPlayerDialog( playerid, d_auth + 5, DIALOG_STYLE_PASSWORD, " ", regpassrepeat, "Далее", "" );
		}
		
		case d_auth + 5: //Подтверждения пароля
		{
			if( inputtext[0] == EOS || !CheckNormalPassword( inputtext ) || strlen( inputtext ) < 8 || strlen( inputtext ) > 20 )
			{
				format:g_string( regpassrepeat );
				strcat( g_string, "\n\n"gbDialogError"Неправильный формат пароля." );
				
				return showPlayerDialog( playerid, d_auth + 5, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "" );
			}
			
			if( !strcmp( Player[playerid][uHash], inputtext, true ) )
			{
				new
					hash[ 64 + 1 ];
			
				SHA256_PassHash( inputtext, "58gdm42bit9", hash, sizeof hash );
				
				clean:<Player[playerid][uHash]>;
				strcat( Player[playerid][uHash], hash, 65 );
				
				showPlayerDialog( playerid, d_auth + 6, DIALOG_STYLE_INPUT, " ", regmail, "Далее", "" );
			}
			else
			{
				format:g_string( regpassrepeat );
				strcat( g_string, "\n\n"gbDialogError"Пароли не совпадают." );
				
				showPlayerDialog( playerid, d_auth + 5, DIALOG_STYLE_PASSWORD, " ", g_string, "Далее", "Выйти" );
			}
		}
		
		case d_auth + 6: //Ввод e-mail
		{
			if( !mail_is_valid( inputtext ) || strlen( inputtext ) > 64 )
			{
				format:g_string( regmail );
				strcat( g_string, "\n\n"gbDialogError"Неккоректный Email адрес." );
				
				return showPlayerDialog( playerid, d_auth + 6, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "" );
			}
			
			clean:<Player[playerid][uEmail]>;
			strcat( Player[playerid][uEmail], inputtext, 64 );
			
			mysql_format:g_small_string( "SELECT * FROM `"DB_USERS"` WHERE `uEmail` LIKE '%e'", inputtext );
			mysql_tquery( mysql, g_small_string, "checkIsMail", "i", playerid );
		}
		
		case d_auth + 7: //Выбор пола
		{
			if( !response )
				Player[playerid][uSex] = 2;
			else
				Player[playerid][uSex] = 1;
				
			showPlayerDialog( playerid, d_auth + 8, DIALOG_STYLE_MSGBOX, " ", regcolor, "Светлый", "Темный" );
		}
		
		case d_auth + 8: //Цвет кожи
		{
			if( !response )
				Player[playerid][uColor] = 1;
			else
				Player[playerid][uColor] = 2;
				
			showPlayerDialog( playerid, d_auth + 9, DIALOG_STYLE_LIST, ""cBLUE"Регистрация: национальность", regnation, "Выбрать", "" );
		}
		
		case d_auth + 9: //Национальность
		{
			if( !listitem )
				return showPlayerDialog( playerid, d_auth + 9, DIALOG_STYLE_LIST, ""cBLUE"Регистрация: национальность", regnation, "Выбрать", "" );
				
			Player[playerid][uNation] = listitem;
			
			showPlayerDialog( playerid, d_auth + 10, DIALOG_STYLE_LIST, ""cBLUE"Регистрация: страна рождения", regcountry, "Выбрать", "" );
		}
		
		case d_auth + 10: //Страна рождения
		{
			if( !listitem )
				return showPlayerDialog( playerid, d_auth + 10, DIALOG_STYLE_LIST, ""cBLUE"Регистрация: страна рождения", regcountry, "Выбрать", "" );
		
			Player[playerid][uCountry] = listitem;
			
			showPlayerDialog( playerid, d_auth + 11, DIALOG_STYLE_INPUT, " ", regage, "Далее", "" );
		}
		
		case d_auth + 11: //Возраст
		{
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 16 || strval( inputtext ) > 70 )
			{
				format:g_string( regage );
				strcat( g_string, "\n\n"gbDialogError"Неккоректный возраст." );
				
				return showPlayerDialog( playerid, d_auth + 11, DIALOG_STYLE_INPUT, " ", regage, "Далее", "" );
			}
			
			Player[playerid][uAge] = strval( inputtext );
			Player[playerid][uMoney] = 600;	
			Player[playerid][uRegDate] = gettime();
			
			format:g_string( "\
				"cBLUE"Регистрация: одежда\n\n\
				"cWHITE"При выборе одежды продумайте роль,\n\
				а также учитывайте национальность и возраст Вашего персонажа:"cBLUE"\n\
				- %s, %d %s", 
				GetNationName( Player[playerid][uNation] ), 
				Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ) );
			
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_string, "Закрыть", "" );
			
			new
				amount;
			
			for( new i; i < 120; i++ )
			{
				if( info_skin[ Player[playerid][uSex] - 1 ][ Player[playerid][uColor] - 1 ][i] ) 
					amount++;
			}
			
			SetPVarInt( playerid, "Skin:Amount", amount );
			SetPVarInt( playerid, "Skin:Choose", 0 );
			
			showChooseSkin( playerid, 1 );
		}
		
		case d_auth + 12:
		{
			if( !response )
				return gbKick( playerid );
		
			format:g_string( "\
				"cBLUE"Регистрация: одежда\n\n\
				"cWHITE"При выборе одежды продумайте роль,\n\
				а также учитывайте национальность и возраст Вашего персонажа:"cBLUE"\n\
				- %s, %d %s", 
				GetNationName( Player[playerid][uNation] ), 
				Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ) );
			
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_string, "Закрыть", "" );
			
			new
				amount;
			
			for( new i; i < 120; i++ )
			{
				if( info_skin[ Player[playerid][uSex] - 1 ][ Player[playerid][uColor] - 1 ][i] ) 
					amount++;
			}
			
			SetPVarInt( playerid, "Skin:Amount", amount );
			SetPVarInt( playerid, "Skin:Choose", 0 );
			
			showChooseSkin( playerid, 1 );
		}
	}
	
	return 1;
}

ClearPlayerData( playerid )
{
	// Int
	Player[playerid][uID] = 
	Player[playerid][uSex] =
	Player[playerid][uColor] =
	Player[playerid][uNation] =
	Player[playerid][uCountry] =
	Player[playerid][uRole] =
	Player[playerid][uAge] =
	Player[playerid][uMoney] =
	Player[playerid][uJob] =
	Player[playerid][uLastTime] =
	Player[playerid][uInt][0] =
	Player[playerid][uInt][1] =
	Player[playerid][uSuspect] =
	Player[playerid][uLeader] =
	Player[playerid][uMember] =
	Player[playerid][uRank] =
	Player[playerid][uWarn] =
	Player[playerid][uMute] =
	Player[playerid][uRegDate] =
	Player[playerid][uBank] =
	Player[playerid][uLevel] =
	Player[playerid][uPM] =
	Player[playerid][uOOC] =
	Player[playerid][uRO] =
	Player[playerid][uRadio] =
	Player[playerid][uDMJail] =
    Player[playerid][uGMoney] =
	Player[playerid][uCheck] =
	Player[playerid][uChangeStyle] =
	Player[playerid][uRadioChannel] =
	Player[playerid][uRadioSubChannel] =
	Player[playerid][uRetest] =
	Player[playerid][uBMute] =
	Player[playerid][uPayTime] =
	Player[playerid][uPinCode] =
	Player[playerid][uHours] =
	
	Player[playerid][uDeath] =
	Player[playerid][uCrimeL] =
	Player[playerid][uCrimeM] =
	Player[playerid][uCrimeRank] =
	
	Player[playerid][uHouseEvict] =

	Player[playerid][uArrestStat] =
	
	Player[playerid][uJail] =
	Player[playerid][uJailTime] =

	Player[playerid][tSpectate] =
	Player[playerid][tFirstTime] =
	Player[playerid][tEnterVehicleTime] =
	Player[playerid][tDialogId] =
	Player[playerid][tTrueShot] =
	Player[playerid][tFalseShot] =
	Player[playerid][tPing] =
	Player[playerid][tSpeed] =
	Player[playerid][tVehicleSpeed] = 0;
	
	Player[playerid][tEnterVehicle] = INVALID_VEHICLE_ID;
	
	// String
	Player[playerid][uName][0] = 
	Player[playerid][uHash][0] = 
	Player[playerid][uSuspectReason][0] =
	Player[playerid][uSettings][0] =
	Player[playerid][uLastIP][0] =
	Player[playerid][uJailSettings][0] =
	Player[playerid][uEmail][0] =
	Player[playerid][uAnimList][0] =
	Player[playerid][uAnimListParam][0] =
	Player[playerid][uStyle][0] =
	Player[playerid][uPame][0] =
	Player[playerid][uRPName][0] =
	Player[playerid][tIP][0] = EOS;
	
	//  Job
	Job[playerid][j_time] =
	Job[playerid][j_vehicleid] = 
	Job[playerid][j_trailerid] = 
	Job[playerid][j_earn] = 
	Job[playerid][j_point] = 
	Job[playerid][j_zone_unload] =
	Job[playerid][j_object_wood] =
	Job[playerid][j_time_wood] =
	Job[playerid][j_count_order] = 0;
	
	// Prison
	Prison[playerid][p_camera] = 
	Prison[playerid][p_cooler] =
	Prison[playerid][p_date] = 
	Prison[playerid][p_dateudo] = 
	Prison[playerid][p_dateexit] = 0;
	Prison[playerid][p_reason][0] =
	Prison[playerid][p_namearrest][0] = 
	Prison[playerid][p_reasonudo][0] = EOS;
	
	Player[playerid][tEther] =
	Player[playerid][jTaxi] =
	Player[playerid][jMech] =
	Player[playerid][jPolice] =
	Job[playerid][j_mech] = 
	Job[playerid][j_taxi] = false;
	
	//Penalty
	for( new i; i < MAX_PENALTIES; i++ )
	{
		Penalty[playerid][i][pen_id] =
		Penalty[playerid][i][pen_date] =
		Penalty[playerid][i][pen_type] =
		Penalty[playerid][i][pen_price] = 0;
		
		Penalty[playerid][i][pen_name][0] = 
		Penalty[playerid][i][pen_descript][0] = EOS;
	}
	
	// Float
	Player[playerid][tgpsPos][0] =
	Player[playerid][tgpsPos][1] =
	Player[playerid][tgpsPos][2] =
	Player[playerid][tPos][0] =
	Player[playerid][tPos][1] =
	Player[playerid][tPos][2] =
	Player[playerid][uArmor] =
	Player[playerid][uP][0] =
	Player[playerid][uP][1] =
	Player[playerid][uP][2] = 0.0;
	Player[playerid][uHP] = 100.0;
	
	// Text3D
	Player[playerid][tAction] = Text3D: INVALID_3DTEXT_ID;
	
	// PVars
	SetPVarInt( playerid, "Player:Follow", INVALID_PLAYER_ID ); //Идти за кем-то
	SetPVarInt( playerid, "Player:Lead", INVALID_PLAYER_ID );	//Вести кого-то за собой
	SetPVarInt( playerid, "Taxi:Driver", INVALID_PLAYER_ID ); 	//Хранить id водителя такси
	SetPVarInt( playerid, "Player:Freeze", 1 );
	SetPVarInt( playerid, "Player:AdvertId", -1 );
	SetPVarInt( playerid, "Login:PinCode", 0 );
	SetPVarInt( playerid, "Login:Auth", 0 );
	SetPVarInt( playerid, "Passenger:VehicleID", INVALID_VEHICLE_ID );
	SetPVarInt( playerid, "Passenger:InVehicle", 0 );
	
	// Global Player Variables
	g_player_airbreak_protect		{playerid} = 255;
	
	g_player_tp_in_car				{playerid} = 
	g_player_carshot				{playerid} = 
	g_player_attach_mode			{playerid} =
	g_player_edit_mode				{playerid} =
	g_player_interaction			{playerid} =
	g_player_login					{playerid} = 
	g_player_gps					{playerid} = 
	g_player_taser					{playerid} = 0;
	
	for( new i; i < MAX_PLAYER_BUSINESS; i++ )
		Player[playerid][tBusiness][i] = INVALID_PARAM;	
		
	for( new i; i < MAX_PLAYER_HOUSE; i++ )
		Player[playerid][tHouse][i] = INVALID_PARAM;
	
	for( new i; i < MAX_PLAYER_VEHICLES; i++ )
		Player[playerid][tVehicle][i] = INVALID_VEHICLE_ID;
	
	for( new i; i < MAX_LICENSES; i++ )
	{
		License[playerid][i][lic_id] =
		License[playerid][i][lic_type] = 
		License[playerid][i][lic_gave_date] = 
		License[playerid][i][lic_take_date] = 0;
		
		License[playerid][i][lic_taked_by][0] = EOS;
	}
	
	// DataPhone
	for( new i; i < MAX_PHONES; i++ )
	{
		Phone[playerid][i][p_id] = 
		Phone[playerid][i][p_user_id] = 
		Phone[playerid][i][p_number] = 
		
		Phone[playerid][i][p_settings][0] = 
		Phone[playerid][i][p_settings][1] = 
		Phone[playerid][i][p_settings][2] = 
		Phone[playerid][i][p_settings][3] = 0;
	}
	
	CleanPhoneData( playerid );
	
	for( new i; i < MAX_MESSAGES; i++ )
	{
		Messages[playerid][i][m_id] = 
		Messages[playerid][i][m_number] = 
		Messages[playerid][i][m_numberto] = 
		Messages[playerid][i][m_read] = 
		Messages[playerid][i][m_date] = 0; 
		Messages[playerid][i][m_text][0] = EOS;
	}
	
	// Call
	Call[playerid][c_call_id] = 
	Call[playerid][c_sound] = 0;
	Call[playerid][c_status] = 
	Call[playerid][c_accept] = false;
	Call[playerid][c_name][0] = EOS;
	
	IsValidPhone{playerid} = 0;
	timer_oxygen[playerid] = 0; // FD
	
	Clear3DMenuData( playerid );
	
	//Payment
	for( new i; i < MAX_HISTORY; i++ )
	{
		Payment[playerid][i][HistoryTime] = 0;
		Payment[playerid][i][HistoryName][0] = EOS;
	}
	
	// Premium Data
	Premium[playerid][prem_time] = 
	Premium[playerid][prem_type] = 
	Premium[playerid][prem_color] = 
	Premium[playerid][prem_gmoney] = 
	Premium[playerid][prem_bank] = 
	Premium[playerid][prem_salary] = 
	Premium[playerid][prem_benefit] = 
	Premium[playerid][prem_mass] = 
	Premium[playerid][prem_admins] = 
	Premium[playerid][prem_supports] = 
	Premium[playerid][prem_h_payment] = 
	Premium[playerid][prem_house] = 
	Premium[playerid][prem_car] = 
	Premium[playerid][prem_business] = 
	Premium[playerid][prem_house_property] = 
	Premium[playerid][prem_drop_retreature] = 
	Premium[playerid][prem_drop_tuning] = 
	Premium[playerid][prem_drop_repair] = 
	Premium[playerid][prem_drop_payment] = 0;
	
	actor_skin			[playerid] = INVALID_ACTOR_ID;
}

stock showIdCard( playerid, forplayerid )
{
	new
		first_name[ 16 ],
		last_name[ 16 ],
		license_date[ 3 ],
		index;
		
	clean:<g_big_string>;
	
	sscanf( Player[playerid][uName], "p<_>s[16]s[16]", first_name, last_name );
	strcat( g_big_string, ""gbDefault"Идентификационная карта\n\n" );
	format:g_small_string(" - Имя: "cBLUE"%s"cWHITE"\n", first_name ), strcat( g_big_string, g_small_string );
	format:g_small_string(" - Фамилия: "cBLUE"%s"cWHITE"\n", last_name ), strcat( g_big_string, g_small_string );
	format:g_small_string(" - Пол: "cBLUE"%s"cWHITE"\n", GetSexName( Player[playerid][uSex] ) ), strcat( g_big_string, g_small_string );
	format:g_small_string(" - Место рождения: "cBLUE"%s"cWHITE"\n", GetCountryName( Player[playerid][uCountry] ) ), strcat( g_big_string, g_small_string );
	format:g_small_string(" - Национальность: "cBLUE"%s"cWHITE"\n", GetNationName( Player[playerid][uNation] ) ), strcat( g_big_string, g_small_string );
	format:g_small_string(" - Возраст: "cBLUE"%d %s"cWHITE"\n\n", Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ) ), strcat( g_big_string, g_small_string );
	strcat( g_big_string, ""gbDefault"Лицензии:\n\n" );
	
	
	switch( GetStatusPlayerLicense( playerid, LICENSE_DRIVE ) )
	{
		case 0:	strcat( g_big_string, " - водительское удостоверение: "cRED"отсутствует"cWHITE"\n" );
		
		case 1:	
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_DRIVE );
		
			gmtime( License[playerid][index][lic_gave_date], license_date[0], license_date[1], license_date[2] );
			
			format:g_small_string(" - водительское удостоверение: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0] );
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_DRIVE );
		
			gmtime( License[playerid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - водительское удостоверение: "cRED"#%d изъято %02d.%02d.%d ( %s )"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[playerid][index][lic_taked_by] ); 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	switch( GetStatusPlayerLicense( playerid, LICENSE_AIR ) )
	{
		case 0:	strcat( g_big_string, " - лицензия пилота: "cRED"отсутствует"cWHITE"\n" );
		
		case 1:	
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_AIR );	
				
			gmtime( License[playerid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - лицензия пилота: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0] ); 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_AIR );
		
			gmtime( License[playerid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - лицензия пилота: "cRED"#%d изъята %02d.%02d.%d ( %s )"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[playerid][index][lic_taked_by] ); 
			strcat( g_big_string, g_small_string ); 
		}
	}

	switch( GetStatusPlayerLicense( playerid, LICENSE_WATER ) )
	{
		case 0:	strcat( g_big_string, " - свидетельство судоводителя: "cRED"отсутствует"cWHITE"\n" );
		
		case 1:	
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_WATER );
		
			gmtime( License[playerid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - свидетельство судоводителя: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0] ), 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_WATER );
		
			gmtime( License[playerid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - свидетельство судоводителя: "cRED"#%d изъято %02d.%02d.%d ( %s )"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[playerid][index][lic_taked_by] ), 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	switch( GetStatusPlayerLicense( playerid, LICENSE_GUN_1 ) )
	{
		case 0:	strcat( g_big_string, " - разрешение на ношение оружия 1 уровня: "cRED"отсутствует"cWHITE"\n" );
		
		case 1:	
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_GUN_1 );
		
			gmtime( License[playerid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 1 уровня: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0] ), 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_GUN_1 );
		
			gmtime( License[playerid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 1 уровня: "cRED"#%d изъято %02d.%02d.%d ( %s )"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[playerid][index][lic_taked_by] ), 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	switch( GetStatusPlayerLicense( playerid, LICENSE_GUN_2 ) )
	{
		case 0:	strcat( g_big_string, " - разрешение на ношение оружия 2 уровня: "cRED"отсутствует"cWHITE"\n" );
		
		case 1:	
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_GUN_2 );
		
			gmtime( License[playerid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 2 уровня: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0] ), 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_GUN_2 );
		
			gmtime( License[playerid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 2 уровня: "cRED"#%d изъято %02d.%02d.%d ( %s )"cWHITE"\n", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[playerid][index][lic_taked_by] ), 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	switch( GetStatusPlayerLicense( playerid, LICENSE_GUN_3 ) )
	{
		case 0:	strcat( g_big_string, " - разрешение на ношение оружия 3 уровня: "cRED"отсутствует"cWHITE"" );
		
		case 1:	
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_GUN_3 );
		
			gmtime( License[playerid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 3 уровня: "cBLUE"#%d от %02d.%02d.%d"cWHITE"", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0] ), 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( playerid, LICENSE_GUN_3 );
		
			gmtime( License[playerid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 3 уровня: "cRED"#%d изъято от %02d.%02d.%d ( %s )"cWHITE"", License[playerid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[playerid][index][lic_taked_by] ), 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	showPlayerDialog( forplayerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
	
	return 1;
}

IsPlayerOnline( userid )
{
	foreach( Player, i )
	{
		if( Player[i][uID] == userid )
		{
			return i;
		}
	}
	return INVALID_PLAYER_ID;
}

stock SetPlayerFightingStyleEx( playerid )
{
	switch( Player[playerid][uChangeStyle] )
	{
		case 0: SetPlayerFightingStyle( playerid, 4 );
		case 1: SetPlayerFightingStyle( playerid, 5 );
		case 2: SetPlayerFightingStyle( playerid, 6 );
		case 3: SetPlayerFightingStyle( playerid, 7 );
		case 4: SetPlayerFightingStyle( playerid, 15 );
		case 5: SetPlayerFightingStyle( playerid, 26 );
	}

	return 1;
}

function GetNewAccountId( playerid, index )
{
	Player[playerid][uID] = cache_insert_id();
	
	//Добавляем скин в инвентарь
	UseInv[playerid][0][inv_id] = 1;
	UseInv[playerid][0][inv_amount] = 1;
	UseInv[playerid][0][inv_type] = TYPE_USE;
	UseInv[playerid][0][inv_active_type] = STATE_DEFAULT;
	UseInv[playerid][0][inv_slot] = 0;
			
	UseInv[playerid][0][inv_param_1] = info_skin[ Player[playerid][uSex] - 1 ][ Player[playerid][uColor] - 1 ][ index ];
	UseInv[playerid][0][inv_param_2] = INVALID_PARAM;

	saveInventory( playerid, 0, INV_INSERT, TYPE_USE );

	//Добавляем ID карту в инвентарь
	PlayerInv[playerid][0][inv_id] = 33;
	PlayerInv[playerid][0][inv_amount] = 1;
	PlayerInv[playerid][0][inv_type] = TYPE_INV;
	PlayerInv[playerid][0][inv_active_type] = STATE_DEFAULT;
	PlayerInv[playerid][0][inv_slot] = 0;
			
	PlayerInv[playerid][0][inv_param_1] = 
	PlayerInv[playerid][0][inv_param_2] = INVALID_PARAM;
			
	saveInventory( playerid, 0, INV_INSERT, TYPE_INV );
	
	if( IsValidActor( actor_skin[playerid] ) )
	{
		DestroyActor( actor_skin[playerid] );
		actor_skin[playerid] = INVALID_ACTOR_ID;
	}
	
	new 
		Float: x, 
		Float: y, 
		Float: z, 
		Float: root;
				
	GetSpawnInfo( playerid, x, y, z, root );
	SetSpawnInfo( playerid, 264, UseInv[playerid][0][inv_param_1], x, y, z, root, 0, 0, 0, 0, 0, 0 );
			
	UpdatePlayer( playerid, "uStatus", 1 );
	UpdateWeather( playerid );
	stopPlayer( playerid, 3 );
			
	Player[playerid][tFirstTime] = gettime();
	Player[playerid][uHP] = 100.0;
			
	ShowRadioInfo( playerid, Player[playerid][uSettings][8] );
	ShowServerLogo( playerid, Player[playerid][uSettings][9] );

	SetPlayerColor( playerid, 0xFFFFFF00 );
	SetPlayerScore( playerid, Player[playerid][uLevel] );

	g_player_login{playerid} = 1;
	
	g_player_gun_protect{playerid} = 
	g_player_airbreak_protect{playerid} =
	g_player_hp_protect{playerid} =	ANTICHEAT_EXCEPTION_TIME;

	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", regtext, "Закрыть", "" );
	
	format:g_small_string( ""ADMIN_PREFIX" Новый персонаж %s[%d] - email: %s - IP: %s",
		Player[playerid][uName],
		playerid,
		Player[playerid][uEmail],
		Player[playerid][tIP]
	);

	SendAdminMessage( C_DARKGRAY, g_small_string );
	
	pformat:( ""gbSuccess"Вы успешно зарегистрировались, "cBLUE"%s"cWHITE".", GetAccountName( playerid ) );
	psend:( playerid, C_WHITE );
	
	pformat:( ""gbSuccess"Чтобы открыть меню, используйте клавишу "cBLUE"Y"cWHITE"." );
	psend:( playerid, C_WHITE );
	
	GetWithoutUnderscore( Player[playerid][uName], Player[playerid][uRPName] );

	DeletePVar( playerid, "Login:Joined" );
	togglePlayerSpectating( playerid, 0 );

	return 1;
}

function checkIsMail( playerid )
{
	if( cache_get_row_count() )
	{
		clean:<Player[playerid][uEmail]>;
	
		format:g_string( regmail );
		strcat( g_string, "\n\n"gbDialogError"Такой почтовый адрес уже используется." );

		return showPlayerDialog( playerid, d_auth + 6, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "" );
	}
	
	showPlayerDialog( playerid, d_auth + 7, DIALOG_STYLE_MSGBOX, " ", regsex, "Мужской", "Женский" );
	
	return 1;
}

function SetConnectCameraPos( playerid )
{
	SetPlayerCameraPos(playerid, 1820.435546, -1035.398193, 276.798461);
	SetPlayerCameraLookAt(playerid, 1818.060546, -1039.697753, 275.863800);
}

function Player_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if(newkeys & KEY_FIRE  || (newkeys & KEY_SPRINT && newkeys & KEY_FIRE ))
	{
		if( !IsPlayerInAnyVehicle( playerid ) )
		{
			for( new i; i < sizeof server_green_zone; i++ )
			{
				if( IsPlayerInRangeOfPoint( playerid, 100.0, server_green_zone[i][0], server_green_zone[i][1], server_green_zone[i][2] ) )
				{
					stopPlayer( playerid, 5 );
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Внимание!", ""cWHITE"Вы находитесь в "cBLUE"Зелезной Зоне"cWHITE". Стрельба (драка) в Зеленой Зоне запрещена!\n"gbDefault"Вы заморожены на 5 секунд.", "Закрыть", "" );
					SetPVarInt( playerid, "Shoot:GreenZone", 1 );
				
					return 1;
				}
			}
		
			
		
			if( GetPlayerVirtualWorld( playerid ) == 63 )
			{
				stopPlayer( playerid, 5 );
				showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Внимание!", ""cWHITE"Вы находитесь в "cBLUE"Зелезной Зоне"cWHITE". Стрельба (драка) в Зеленой Зоне запрещена!\n"gbDefault"Вы заморожены на 5 секунд.", "Закрыть", "" );
				SetPVarInt( playerid, "Shoot:GreenZone", 1 );
			}
		}
	}

	return 1;
}