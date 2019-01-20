/*CMD:ooc( playerid, params[] ) 
{
 	if( sscanf( params, "s[128]", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /ooc [ текст ]" );
	
	format:g_small_string( "Тестер %s[%d]: %s",
		Player[playerid][uName],
		playerid,
		params[0]
	);
	
	SendClient:ToAll( C_WHITE, g_small_string );

    //clean_array();
	return 1;
}*/

/*
*
* * * * Support Commands
*
*/

CMD:h( playerid, params[] ) 
{
	if( GetAccessAdmin( playerid, 1 )) 
	{
		if( IsMuted( playerid, OOC ) )
			return SendClient:( playerid, C_WHITE, !CHAT_MUTE_OOC );
		
		if ( sscanf( params, "s[128]", params[0] ) )
			return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /h [ текст ]" );
			
		format:g_small_string( ""SUPPORT_PREFIX" Администратор %s[%d]: %s",
			Player[playerid][uName],
			playerid,
			params[0]
		);
		
	    SendSupportMessage( C_LIGHTORANGE, g_small_string );
	}
	else if( GetAccessSupport( playerid ) )
	{
		if( IsMuted( playerid, OOC ) )
			return SendClient:( playerid, C_WHITE, !CHAT_MUTE_OOC );
			
		if ( sscanf( params, "s[128]", params[0] ) )
			return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /h [ текст ]" );
		
		format:g_small_string( ""SUPPORT_PREFIX" Саппорт %s[%d]: %s",
			Player[playerid][uName],
			playerid,
			params[0]
		);
		
	    SendSupportMessage( C_LIGHTORANGE, g_small_string );
	}
	else
		return SendClient:( playerid, C_WHITE, NO_ACCESS_CMD);

    clean_array();
	return 1;
}

CMD:scp( playerid ) 
{
	if( !GetAccessSupport( playerid ) )
 		return SendClient:( playerid, C_WHITE, NO_ACCESS_CMD);

	showPlayerDialog( playerid, d_support, DIALOG_STYLE_LIST, " ", hcontent_hcp, "Далее", "Закрыть" );

	return 1;
}

CMD:sduty( playerid ) 
{
	new 
		server_tick = GetTickCount();
	
	if( GetPVarInt( playerid, "Support:DutyTime" ) > server_tick )
		return SendClient:(playerid, C_WHITE, !""gbError"Вы не можете использовать данную команду так часто.");
	
	if ( GetAccessSupport( playerid ) ) 
	{
	    format:g_small_string( ""SUPPORT_PREFIX" Саппорт %s[%d] покинул дежурство.",
			Player[playerid][uName],
			playerid
		);
		
		SendSupportMessage( C_LIGHTORANGE, g_small_string );

		SetPVarInt( playerid, "Support:Duty", 0 );
		SetPVarInt( playerid, "Support:DutyTime", server_tick + 20000 );

	} 
	else if ( GetAccessSupport( playerid, false ) ) 
	{
	    SetPVarInt( playerid, "Support:Duty", 1 );
		
	    format:g_small_string( ""SUPPORT_PREFIX" Саппорт %s[%d] вышел на дежурство.",
			Player[playerid][uName],
			playerid
		);
		
		SendSupportMessage( C_LIGHTORANGE, g_small_string );
		
		SendClient:(playerid, C_WHITE, !""gbSuccess"Панель саппорта - "cBLUE"/scp"cWHITE".");
	} 
	else 
	{
		clean:<g_string>;
		mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM "DB_SUPPORTS" WHERE sUserID = %d", Player[playerid][uID] );
		mysql_tquery( mysql, g_string, "ReloadSupportAccount", "ii", playerid, server_tick );
	}
	
	return 1;
}

CMD:ans( playerid, params[] ) 
{
	if ( GetAccessCommand( playerid, "ans" ) ) 
	{
		if ( sscanf( params, "us[128]", params[0], params[1] ) )
			return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /ans [ имя/id игрока ] [ текст ]" );
			
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] для %s[%d]: %s",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0],
			params[1]
		);
		SendAdmin:( C_ORANGE, g_small_string );

		format:g_small_string( "Администратор %s[%d] ответил Вам: %s",
			Player[playerid][uName],
			playerid,
			params[1]
		);
		
		SendClient:( params[0], C_ORANGE, g_small_string );
		
		printf("[A] %s[%d] >> %s[%d]: %s", 
			Player[playerid][uName], 
			playerid,
			GetAccountName(params[0]),
			params[0],
			params[1]
		);
	} 
	else if( GetAccessSupport( playerid ) ) 
	{
		if ( sscanf( params, "us[128]", params[0], params[1] ) )
			return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /ans [ имя/id игрока ] [ текст ]" );
			
		format:g_small_string( ""SUPPORT_PREFIX" %s[%d] для %s[%d]: %s",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0],
			params[1]
		);
		
		SendSupportMessage( C_ORANGE, g_small_string );

		format:g_small_string( "Саппорт %s[%d] ответил Вам: %s",
			Player[playerid][uName],
			playerid,
			params[1]
		);
		
		SendClient:( params[0], C_ORANGE, g_small_string );
		
		printf("[S] %s[%d] >> %s[%d]: %s", 
			Player[playerid][uName], 
			playerid,
			GetAccountName(params[0]),
			params[0],
			params[1]
		);
		
	}
	else
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
	
	return 1;
}

/*
*
* * * * Admin Commands
*
*/

CMD:a( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "a" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
	
	if( IsMuted( playerid, OOC ) )
		return SendClient:( playerid, C_WHITE, !CHAT_MUTE_OOC );
	
 	if( isnull( params ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /a [ текст ]" );
		
	format:g_small_string( ""ADMIN_PREFIX" (%d) %s[%d]: %s",
		Admin[playerid][aLevel],
		Player[playerid][uName],
		playerid,
		params
	);
	
	SendAdmin:( C_GREEN, g_small_string );
	return 1;
}

CMD:gotopos( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "gotopos" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params,"fff", params[0], params[1], params[2] ) ) 
		return SendClient:(playerid, C_WHITE,""gbDefault"Введите: /gotopos [ координата x ] [ координата y ] [ координата z ]");
		
	setPlayerPos( playerid, params[0], params[1], params[2] );
	
	format:g_small_string( ""gbSuccess"Вы успешно телепортировались на координаты: "cBLUE"%f, %f, %f"cWHITE".", params[0], params[1], params[2] ); 
	SendClient:( playerid, C_WHITE, g_small_string );
	
	checkPlayerUseTexViewer( playerid );
	
	return 1;
}

CMD:rspawnveh( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "rspawnveh" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params,"d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /rspawnveh [ радиус ]" );
	
	if( params[0] < 0 )
		return SendClient:( playerid, C_WHITE, ""gbError"Радиус не может быть отрицательным." );
	
	new
		Float: x,
		Float: y,
		Float: z;
	
	for( new i; i < MAX_VEHICLES; i++ )
	{
		GetVehiclePos( playerid, x, y, z );
		if( IsPlayerInRangeOfPoint( playerid, params[0], x, y, z ) )
		{
			SetVehicleToRespawn( i );
		}
	}
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] зареспавнил тс в радиусе: %d.", 
		GetAccountName( playerid ), 
		playerid, 
		params[0] 
	); 
	
	SendAdmin:( C_GRAY, g_small_string );
	return 1;
}

CMD:spawnveh( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "spawnveh" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
	
	if( sscanf( params,"d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /spawnveh [ id транспортного средства (/dl) ]" );
		
	if( params[0] < 0 || params[0] > MAX_VEHICLES )
		return SendClient:( playerid, C_WHITE, ""gbError"Некорректный идентификатор транспортного средства." );

	SetVehicleToRespawn( params[0] );
		
	format:g_small_string( ""gbSuccess"Вы успешно зареспавнили транспортное средство: "cBLUE"%d"cWHITE".", 
		params[0] 
	); 
		
	SendClient:( playerid, C_WHITE, g_small_string );
	
	return 1;
}

CMD:repairveh( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "repairveh" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
	
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /repairveh [ id транспортного средства (/dl) ]" );
		
	if( params[0] < 0 || params[0] > MAX_VEHICLES )
		return SendClient:( playerid, C_WHITE, ""gbError"Некорректный идентификатор транспортного средства." );

	RepairVehicle( params[0] );
		
	format:g_small_string( ""gbSuccess"Вы успешно отремонтировали транспортное средство: "cBLUE"%d"cWHITE".", 
		params[0] 
	); 
		
	SendClient:( playerid, C_WHITE, g_small_string );
	
	return 1;
}

CMD:aspawn( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "aspawn" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "u", params[0] ) ) 
		return SendClient:(playerid, C_WHITE,""gbDefault"Введите: /aspawn [ имя/id игрока ]");
		
	SpawnPlayer( params[0] );
	
	if( params[0] != playerid )
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] зареспавнил %s[%d].",
			GetAccountName( playerid ),
			playerid,
			GetAccountName( params[0] ),
			params[0]
		); 
		
		SendAdmin:( C_GRAY, g_small_string );
	}
	else
	{
		SendClient:( playerid, C_WHITE, ""gbDefault"Вы успешно себя зареспавнили.");
	}
	
	return 1;
}

CMD:delaction( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "delaction" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "us[64]", params[0], params[1] ) ) 
		return SendClient:(playerid,C_GRAY,""gbDefault"Введите: /delaction [ имя/id игрока ] [ причина ]");
	
	if( !IsLogged(params[0]) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Player[params[0]][tAction] == Text3D: INVALID_3DTEXT_ID ) 
		return SendClient:(playerid,C_GRAY,""gbError"Данный игрок не устанавливал какое-либо действие.");
	
	if( IsValidDynamic3DTextLabel( Player[params[0]][tAction] ) )
	{
		DestroyDynamic3DTextLabel( Player[params[0]][tAction] );
	}
	
	Player[params[0]][tAction] = Text3D: INVALID_3DTEXT_ID;
	clean:<Player[params[0]][tActionText]>;
	
	format:g_small_string(""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" удалил ваше действие. ("cBLUE"%s"cWHITE")",
		Player[playerid][uName],
		playerid,
		params[1]
	);
	
	SendClient:( params[0], C_WHITE, g_small_string );
	
	return 1;
}

CMD:delpame( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "delpame" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "us[64]", params[0], params[1] ) ) 
		return SendClient:(playerid,C_GRAY,""gbDefault"Введите: /delpame [ имя/id игрока ] [ причина ]");
	
	if( !IsLogged( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( isnull( Player[params[0]][uPame] )  ) 
		return SendClient:(playerid, C_GRAY, ""gbDefault"Данный игрок не использует описание персонажа.");
	
	
	Player[params[0]][uPame][0] = EOS;
	
	format:g_small_string(""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" удалил ваше описание. ("cBLUE"%s"cWHITE")",
		Player[playerid][uName],
		playerid,
		params[1]
	);
	
	SendClient:( params[0], C_WHITE, g_small_string );
	
	return 1;
}

CMD:setfrac( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "setfrac" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE,""gbDefault"Введите: /setfrac [ id фракции ][ ранг ]" );
	
	if( params[0] > COUNT_FRACTIONS || params[0] < 0 )
		return SendClient:( playerid, C_WHITE, ""gbError"Неверный или несуществующий идентификатор организации." );
		
	if( Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, ""gbError"Вы состоите в криминальной организации." );
	
	if( params[0] != 0 && params[1] >= 0  )
	{
		if( params[1] > Fraction[ params[0] - 1 ][f_ranks] - 1 || params[1] < 0 )
			return SendClient:( playerid, C_WHITE, ""gbError"Неверный или несуществующий идентификатор ранга." );
		
		Player[playerid][uMember] = params[0];
		Player[playerid][uRank] = params[1];
		Player[playerid][uJob] = 0;	
		
		format:g_small_string(""ADMIN_PREFIX" %s[%d] временно вступил в организацию: '%s' (Ранг: %s).",
			GetAccountName( playerid ),
			playerid,
			Fraction[ Player[playerid][uMember] - 1 ][f_short_name],
			FRank[ Player[playerid][uMember] - 1 ][ params[1] ][r_name]
		);
		
		SendAdmin:( C_GRAY, g_small_string );
	}
	else if( !params[0] )
	{
		if( !Player[playerid][uMember] )
			return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в организации." );
	
		format:g_small_string( ""gbDefault"Вы покинули организацию: '%s'.",
			Fraction[ Player[playerid][uMember] - 1 ][f_short_name]
		);
	
		Player[playerid][uMember] = 
		Player[playerid][uRank] = 0;
		
		SendClient:( playerid, C_WHITE, g_small_string );
	}
	
	return 1;
}

CMD:setcrime( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "setcrime" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE,""gbDefault"Введите: /setcrime [ id фракции ][ ранг ]" );
		
	if( Player[playerid][uMember] )
		return SendClient:( playerid, C_WHITE, ""gbError"Вы состоите в государственной организации." );
	
	if( params[0] != 0 && params[1] >= 0  )
	{
		new
			crime = INVALID_PARAM;
	
		for( new i; i < COUNT_CRIMES; i++ )
		{
			if( CrimeFraction[ i ][c_id] == params[0] )
			{
				crime = i;
				break;
			}	
		}
	
		if( crime == INVALID_PARAM )
			return SendClient:( playerid, C_WHITE, ""gbError"Неверный или несуществующий идентификатор организации." );
	
		if( params[1] > CrimeFraction[ crime ][c_ranks] - 1 || params[1] < 0 )
			return SendClient:( playerid, C_WHITE, ""gbError"Неверный или несуществующий идентификатор ранга." );
		
		Player[playerid][uCrimeM] = params[0];
		Player[playerid][uCrimeRank] = params[1];
		Player[playerid][uJob] = 0;	
		
		format:g_small_string(""ADMIN_PREFIX" %s[%d] временно вступил в криминальную структуру: '%s' (Ранг: %s).",
			GetAccountName( playerid ),
			playerid,
			CrimeFraction[ crime ][c_name],
			CrimeRank[ crime ][ params[1] ][r_name]
		);
		
		SendAdmin:( C_GRAY, g_small_string );
	}
	else if( !params[0] )
	{
		if( !Player[playerid][uCrimeM] )
			return SendClient:( playerid, C_WHITE, !""gbError"Вы не состоите в криминальной структуре." );
	
		new
			crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
	
		format:g_small_string( ""gbDefault"Вы покинули криминальную структуру: '%s'.",
			CrimeFraction[ crime ][c_name]
		);
	
		Player[playerid][uCrimeM] = 
		Player[playerid][uRank] = 0;
		
		SendClient:( playerid, C_WHITE, g_small_string );
	}
	
	return 1;
}

CMD:setleader( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "setleader" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "ui", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE,""gbDefault"Введите: /setleader [ имя/id игрока ] [ id организации ]" );
	
	if( !IsLogged(params[0]) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( Player[params[0]][uLeader] || Player[params[0]][uCrimeL] )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже является лидером." );
		
	if( Player[ params[0] ][uMember] || Player[ params[0] ][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже состоит в организации." );
	
	if( params[1] > COUNT_FRACTIONS || params[1] < 1 )
		return SendClient:( playerid, C_WHITE, ""gbError"Неверный или несуществующий идентификатор организации." );
	
	new 
		id = params[0],
		fid = params[1] - 1,
		flag = INVALID_PARAM;
	
	for( new i; i < 3; i++ )
	{
		if( !Fraction[fid][f_leader][i] )
		{
			flag = i;
			break;
		}
	}
	
	if( flag == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, ""gbError"В данной организации нет свободных слотов для лидера." );
		
	Player[id][uLeader] = params[1];
	Player[id][uMember] = params[1];
	Player[id][uRank] = 0;
	Player[id][uJob] = 0;
				
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, 
		"\
			UPDATE "DB_USERS" \
			SET \
				uLeader = %d, \
				uMember = %d, \
				uJob = %d, \
				uRank = %d \
			WHERE uID = %d\
		",
		Player[id][uLeader],
		Player[id][uMember],
		Player[id][uJob],
		Player[id][uRank],
		Player[id][uID]
	);		
	mysql_tquery( mysql, g_string );
			
	Fraction[fid][f_leader][flag] = Player[id][uID];
	
	clean:<FNameLeader[fid][flag]>;
	strcat( FNameLeader[fid][flag], Player[id][uName], MAX_PLAYER_NAME );
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, 
		"\
			UPDATE "DB_FRACTIONS" \
			SET \
				`f_leader` = '%d|%d|%d', \
				`f_leadername_1` = '%s', \
				`f_leadername_2` = '%s', \
				`f_leadername_3` = '%s' \
			WHERE `f_id` = %d\
		",
		Fraction[fid][f_leader][0],
		Fraction[fid][f_leader][1],
		Fraction[fid][f_leader][2],
		FNameLeader[fid][0],
		FNameLeader[fid][1],
		FNameLeader[fid][2],
		Fraction[fid][f_id]
	);		
	mysql_tquery( mysql, g_string );
				
	format:g_small_string("" #ADMIN_PREFIX " %s[%d] назначил %s[%d] лидером организации '%s'.",
		GetAccountName( playerid ),
		playerid,
		GetAccountName( id ),
		id,
		Fraction[fid][f_name]
	);
				
	SendAdmin:( C_GRAY, g_small_string );
				
	format:g_small_string("" #gbDefault "Администратор "cBLUE"%s[%d]"cWHITE" назначил Вас лидером организации "cBLUE"'%s'"cWHITE".",
		GetAccountName( playerid ),
		playerid,
		Fraction[fid][f_name]
	);
	SendClient:( id, C_WHITE, g_small_string );
	
	return 1;
}

CMD:unleader( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "unleader" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( sscanf( params, "i", params[0] ) ) 
		return SendClient:( playerid, C_WHITE,""gbDefault"Введите: /unleader [ id организации ]" );
	
	if( params[0] > COUNT_FRACTIONS || params[0] < 1 )
		return SendClient:( playerid, C_WHITE, ""gbError"Неверный или несуществующий идентификатор организации." );
		
	clean:<g_big_string>;
	strcat( g_big_string, "\t"cWHITE"Организация\t"cWHITE"Лидер" );
		
	for( new i; i < 3; i++ )
	{
		if( Fraction[params[0] - 1][f_leader][i] ) format:g_small_string( "%s", FNameLeader[params[0] - 1][i] );
		
		format:g_string( "\n"cWHITE"%s\t"cBLUE"%s",
			Fraction[params[0] - 1][f_name],
			!Fraction[params[0] - 1][f_leader][i] ? ("Нет") : g_small_string
		);
		strcat( g_big_string, g_string );
	}
	
	SetPVarInt( playerid, "UnLeader:Fraction", params[0] - 1 );	
	showPlayerDialog( playerid, d_makeleader, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "Снять", "Закрыть" );
		
	return 1;
}

CMD:setcleader( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "setcleader" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "ui", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE,""gbDefault"Введите: /setcleader [ имя/id игрока ] [ id организации ]" );
	
	if( !IsLogged( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( Player[params[0]][uLeader] || Player[params[0]][uCrimeL] )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже является лидером." );
		
	if( Player[ params[0] ][uMember] || Player[ params[0] ][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже состоит в организации." );
	
	new
		crime = getIndexCrimeFraction( params[1] ),
		id = params[0],
		flag = INVALID_PARAM;
	
	if( crime == INVALID_PARAM || !params[1] )
		return SendClient:( playerid, C_WHITE, ""gbError"Неверный или несуществующий идентификатор криминальной структуры." );
	
	for( new i; i < 3; i++ )
	{
		if( !CrimeFraction[crime][c_leader][i] )
		{
			flag = i;
			break;
		}
	}
	
	if( flag == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, ""gbError"В данной криминальной структуре нет свободных слотов для лидера." );
		
	Player[id][uCrimeL] = params[1];
	Player[id][uCrimeM] = params[1];
	Player[id][uCrimeRank] = 0;
				
	mysql_format:g_string(
		"\
			UPDATE "DB_USERS" \
			SET \
				uCrimeL = %d, \
				uCrimeM = %d, \
				uCrimeRank = 0 \
			WHERE uID = %d\
		",
		Player[id][uCrimeL],
		Player[id][uCrimeM],
		Player[id][uID]
	);		
	mysql_tquery( mysql, g_string );
			
	CrimeFraction[crime][c_leader][flag] = Player[id][uID];
	
	clean:<CNameLeader[ crime ][flag]>;
	strcat( CNameLeader[ crime ][flag], Player[id][uName], MAX_PLAYER_NAME );
	
	mysql_format:g_string( 
		"\
			UPDATE "DB_CRIME" \
			SET \
				`c_leader` = '%d|%d|%d', \
				`c_leadername_1` = '%s', \
				`c_leadername_2` = '%s', \
				`c_leadername_3` = '%s' \
			WHERE `c_id` = %d\
		",
		CrimeFraction[crime][c_leader][0],
		CrimeFraction[crime][c_leader][1],
		CrimeFraction[crime][c_leader][2],
		CNameLeader[crime][0],
		CNameLeader[crime][1],
		CNameLeader[crime][2],
		CrimeFraction[crime][c_id]
	);		
	mysql_tquery( mysql, g_string );
				
	format:g_small_string("" #ADMIN_PREFIX " %s[%d] назначил %s[%d] лидером криминальной структуры '%s'.",
		GetAccountName( playerid ),
		playerid,
		GetAccountName( id ),
		id,
		CrimeFraction[crime][c_name]
	);
				
	SendAdmin:( C_GRAY, g_small_string );
				
	format:g_small_string("" #gbDefault "Администратор "cBLUE"%s[%d]"cWHITE" назначил Вас лидером криминальной структуры "cBLUE"'%s'"cWHITE".",
		GetAccountName( playerid ),
		playerid,
		CrimeFraction[crime][c_name]
	);
	SendClient:( id, C_WHITE, g_small_string );
	
	return 1;
}

CMD:uncleader( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "uncleader" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( sscanf( params, "i", params[0] ) ) 
		return SendClient:( playerid, C_WHITE,""gbDefault"Введите: /unсleader [ id криминальной структуры ]" );
	
	new
		crime = getIndexCrimeFraction( params[0] );
	
	if( crime == INVALID_PARAM || !params[0] )
		return SendClient:( playerid, C_WHITE, ""gbError"Неверный или несуществующий идентификатор криминальной структуры." );
		
	clean:<g_big_string>;
	
	
	strcat( g_string, ""cWHITE"Аккаунт\t"cWHITE"Никнейм" );
		
	for( new i; i < 3; i++ )
	{
		if( CrimeFraction[crime][c_leader][i] ) 
		{
			format:g_small_string( "\n"cWHITE"%d\t"cBLUE"%s",
				CrimeFraction[crime][c_leader][i],
				CNameLeader[crime][i]
			);
			strcat( g_string, g_small_string );
		}
	}
	
	format:g_small_string( ""cWHITE"%s", CrimeFraction[ crime ][c_name] );
	
	SetPVarInt( playerid, "UnLeader:Crime", crime );
	showPlayerDialog( playerid, d_makeleader + 2, DIALOG_STYLE_TABLIST_HEADERS, g_small_string, g_string, "Снять", "Закрыть" );

	return 1;
}
/*
CMD:addenter( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "addenter" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "s[64]", params ) ) 
		return SendClient:( playerid, -1, ""gbError"Введите: /addenter [ название ]" );
		
	new Float:pos[3];
	GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
	for( new e; e < sizeof EnterInfo; e++ ) 
	{
		if( !EnterInfo[e][eID] ) 
		{
			for( new i; i < 3; i++ ) EnterInfo[e][eP][i] = pos[i];
			EnterInfo[e][exInt][0] = GetPlayerInterior( playerid ),
			EnterInfo[e][exInt][1] = GetPlayerVirtualWorld( playerid );
			CreateDynamicPickup( 19132, 23, EnterInfo[e][eP][0], EnterInfo[e][eP][1], EnterInfo[e][eP][2], EnterInfo[e][exInt][1] );

			format( EnterInfo[e][eName], 64, "%s", params );
			format:g_small_string("{ffffff}[ %s ]\n"cBLUE"ALT", EnterInfo[e][eName]);
			CreateDynamic3DTextLabel( g_small_string, C_BLUE, EnterInfo[e][eP][0], EnterInfo[e][eP][1], EnterInfo[e][eP][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1 );
			format:g_string( "INSERT INTO `gb_enters` \
				( `eP1`, `eP2`, `eP3`, `exInt`, `exWorld`, `eName` ) \
				VALUES ( '%f', '%f', '%f', '%d', '%d', '%s' )",
				EnterInfo[e][eP][0], EnterInfo[e][eP][1], EnterInfo[e][eP][2],
				EnterInfo[e][exInt][0], EnterInfo[e][exInt][1],
				EnterInfo[e][eName] );
			mysql_tquery( mysql, g_string, "entersInsert", "dd", playerid, e );	
			break;
		}
	}
	return true;
}

CMD:enterexit( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "enterexit" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, -1, ""gbError"Введите: /enterexit [ id ]" );
		
	for( new e; e < sizeof EnterInfo; e++ ) {
		if( EnterInfo[e][eID] == params[0] ) {
			new Float:pos[3];
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
			for( new i; i < 3; i++ ) EnterInfo[e][ePe][i] = pos[i];
			EnterInfo[e][eInt][0] = GetPlayerInterior( playerid ),
			EnterInfo[e][eInt][1] = EnterInfo[e][eID];
			CreateDynamicPickup( 19132, 23, EnterInfo[e][ePe][0], EnterInfo[e][ePe][1], EnterInfo[e][ePe][2], EnterInfo[e][eInt][1], EnterInfo[e][eInt][0] );
			CreateDynamic3DTextLabel( "ALT", C_BLUE, EnterInfo[e][ePe][0], EnterInfo[e][ePe][1], EnterInfo[e][ePe][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, EnterInfo[e][eInt][1] );
			
			format:g_string( "UPDATE `gb_enters` SET `ePe1` = '%f', `ePe2` = '%f', `ePe3` = '%f', \
				`eInt` = '%d', `eWorld` = '%d' WHERE `eID` = '%d'", 
				EnterInfo[e][ePe][0], EnterInfo[e][ePe][1], EnterInfo[e][ePe][2], 
				EnterInfo[e][eInt][0], EnterInfo[e][eInt][1],
				EnterInfo[e][eID] );
			mysql_query( mysql, g_string );
			

			format:g_small_string( ""gbSuccess"Вы успешно добавили выход в интерьер [%s] ID:%d",
				EnterInfo[e][eName], EnterInfo[e][eID] );
				
			SendClient:( playerid, C_WHITE, g_small_string );
			return true;
		}
	}
	SendClient:( playerid, -1, ""gbError"Вы указали неверный ID входа" );
	return true;
}

CMD:gfmenu( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "gfmenu" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new count;
	for(new i; i < MAX_SPRAY; i++) {
		if( !SprayInfo[i][grID] ) continue;
		if( SprayInfo[i][grVarificated] == 0 && strlen( SprayInfo[i][grAuthorName] ) > 2) {
			if( count > 14 ) break;
			format:g_small_string( "[%d] — %s\n", count + 1, SprayInfo[i][grAuthorName] );
			strcat( g_string, g_small_string );
			count++;
		}
	}
	if( !count ) return SendClient:( playerid, C_GRAY, ""gbError"Нет граффити для одобрения!" );
	showPlayerDialog( playerid, d_spraytag + 6, DIALOG_STYLE_LIST, " ", g_string, "Далее", "Отмена");
	return true;
}
	
CMD:gfids( playerid, params[] ) {
	if( !GetAccessCommand( playerid, "gfids" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	new count;
	for(new i; i < MAX_SPRAY; i++) {
		if( !SprayInfo[i][grID] ) continue;
		if(IsPlayerInRangeOfPoint(playerid,5.0,SprayInfo[i][grX], SprayInfo[i][grY], SprayInfo[i][grZ])) {
			format:g_small_string( "[ID: %d] %s\n", SprayInfo[i][grID], SprayInfo[i][grAuthorName]);
			strcat( g_string, g_small_string );
			count++;
			if(count >= 15) break;
		}
	}
	if( !count ) return SendClient:( playerid, C_GRAY, ""gbError"Рядом с Вами нет граффити!" );
	showPlayerDialog( playerid, 9999, 0, " ", g_string, "Закрыть","");
	return true;
}
	
CMD:gfdell( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "gfdell" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) return SendClient:(playerid,C_GRAY,""gbDefault"Введите: /gfdell [Mysql ID]"), SendClient:(playerid,C_GRAY,""gbDefault"Просмотреть список граффити в 5-ти метрах можно командой /gfids");
	new id, bool: status = false;
	for(new i; i != MAX_SPRAY; i++) {
		if( !SprayInfo[i][grID] ) continue;
		if( SprayInfo[i][grID] == params[0]) {
			id = i, status = true;
			break;
		}
	}
	if( status == false ) return SendClient:(playerid,C_GRAY,""gbError"Не найдено граффити с таким ID");
	if( IsValidDynamicObject( SprayInfo[id][grObject] ) ) DestroyDynamicObject( SprayInfo[id][grObject] );
	for(new Grnfo:i; i < Grnfo; ++i) SprayInfo[id][i] = 0;
	SendClient:(playerid, -1, "Вы удалили граффити!");
	
	format:g_small_string( "DELETE FROM `gb_spraytag` WHERE `sID` = %d", params[0]);
	mysql_tquery( mysql, g_string, "", "");
	return true;
}

CMD:addhostel( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "addhostel" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, -1, ""gbDefault"Введите: /hostels [ тип падика ]" );
		
	if( GetPlayerInterior( playerid ) > 0 || GetPlayerVirtualWorld( playerid ) > 0 ) 
		return SendClient:( playerid, -1, ""gbError"Вы должны находиться на улице!" );
		
	if( params[0] < 1 && params[0] > 2 ) 
		return SendClient:( playerid, -1, ""gbError"Вы указали недопустимое значение" );
		
	for( new i; i < sizeof Hostels; i++ ) 
	{
		if( !Hostels[i][kID] ) 
		{
			new Float:pos[3];
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] ); 
			for( new p; p < 3; p++ ) 
			{
				Hostels[i][kEnterPos][p] = pos[p],
				Hostels[i][kExitPos][p] = hostels_position[ params[0] - 1 ][p],
				Hostels[i][kInt] = floatround( hostels_position[ params[0] - 1 ][6] ),
				Hostels[i][kExitPos_Two][p] = hostels_position[ params[0] - 1 ][p + 3];
			}
			format:g_string( "INSERT INTO `gb_hostel` ( \
				`kEnterPosX`, `kEnterPosY`, `kEnterPosZ`,\
				`kExitPosX`, `kExitPosY`, `kExitPosZ`,\
				`kExitPosX_Two`, `kExitPosY_Two`, `kExitPosZ_Two`, \
				`kInt` ) \
				VALUES ( '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%d' )",
				Hostels[i][kEnterPos][0], Hostels[i][kEnterPos][1], Hostels[i][kEnterPos][2], 
				Hostels[i][kExitPos][0], Hostels[i][kExitPos][1], Hostels[i][kExitPos][2], 
				Hostels[i][kExitPos_Two][0], Hostels[i][kExitPos_Two][1], Hostels[i][kExitPos_Two][2],
				Hostels[i][kInt] );
			mysql_tquery( mysql, g_string, "insertHostels", "dd", playerid, i ); 	
			break;
		}
	}
	
	return 1;
}

CMD:camerahostel( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "camerahostel" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, -1, ""gbDefault"Введите: /camerahostel [ид]" );
		
	for( new i; i < sizeof Hostels; i++ ) 
	{
		if( Hostels[i][kID] == params[0] ) 
		{
			new Float:pos[3];
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] ); 
			for( new p; p < 3; p++ ) Hostels[i][kCamPos][p] = pos[p];
			format:g_string( "UPDATE `gb_hostel` SET \
				`kCamPosX` = '%f', `kCamPosY` = '%f', `kCamPosZ` = '%f' \
				WHERE `kID` = '%d'", 
				Hostels[i][kCamPos][0], Hostels[i][kCamPos][1], Hostels[i][kCamPos][2],
				Hostels[i][kID] );
			mysql_query( mysql, g_string );
			
			format:g_small_string( ""gbDefault"Вы успешно установили положение камеры подъезду %d", Hostels[i][kID] );
			SendClient:( playerid, C_WHITE, g_small_string );
			break;
		}
	}	
	
	return 1;
}

CMD:enterhostel( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "enterhostel" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, -1, ""gbDefault"Введите: /enterhostel [ id ]" );
		
	for( new i; i < sizeof Hostels; i++ ) 
	{
		if( Hostels[i][kID] == params[0] ) 
		{
			new Float:pos[3];
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] ); 
			for( new p; p < 3; p++ ) Hostels[i][kEnterPos_Two][p] = pos[p];
			format:g_string( "UPDATE `gb_hostel` SET \
				`kEnterPosX_Two` = '%f', `kEnterPosY_Two` = '%f', `kEnterPosZ_Two` = '%f' \
				WHERE `kID` = '%d'", 
				Hostels[i][kEnterPos_Two][0], Hostels[i][kEnterPos_Two][1], Hostels[i][kEnterPos_Two][2],
				Hostels[i][kID] );
			mysql_query( mysql, g_string );
			CreateDynamicPickup(19132,23,Hostels[i][kEnterPos_Two][0], Hostels[i][kEnterPos_Two][1], Hostels[i][kEnterPos_Two][2], -1);
			format:g_small_string( ""gbDefault"Вы успешно установили второй вход подъезду %d", Hostels[i][kID] );
			SendClient:( playerid, C_WHITE, g_small_string );
			break;
		}
	}	
	
	return 1;
}*/

CMD:hp( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "hp" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "ud", params[0], params[1] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /hp [ имя/id игрока ] [ значение ]" );
		
	if( !IsLogged(params[0]) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Admin[playerid][aLevel] < Admin[params[0]][aLevel])
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
	
	if( params[0] != playerid )
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] установил здоровье %s[%d] (%d ед)",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0],
			params[1]
		);
		
		SendAdmin:( C_GRAY, g_small_string );
	}
	else
	{
		format:g_small_string( ""gbDefault"Вы установили себе здоровье: %d единиц.", params[1] );
	}
	
	setPlayerHealth( params[0], params[1] );
	
    clean_array();
	return 1;
}



CMD:kick( playerid, params[] ) 
{
	#define reason  params[1]
	if( !GetAccessCommand( playerid, "kick" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
 	if( sscanf( params, "us[32]", params[0], reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /kick [ имя/id игрока ] [ причина ]" );

	if( GetAccessAdmin( params[0], 7 ) && !GetAccessAdmin( playerid, 7 ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( !IsPlayerConnected( params[0] ) || IsKicked( params[0] ) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	 
	AdminIsHacked( playerid, TYPE_CMD, reason );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	format:g_small_string( "Администратор %s[%d] отсоединил игрока %s[%d] от сервера (%s)",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0],
		params[1]
	);
	
	SendAdmin:ToAll( C_RED, g_small_string );

	gbMessageKick( params[0], reason, _, playerid, false );
	
    clean_array();
    #undef reason
	return 1;
}

CMD:warn( playerid, params[] ) 
{
	#define reason  params[1]
	if( !GetAccessCommand( playerid, "warn" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

 	if( sscanf( params, "us[32]", params[0], reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /warn [ имя/id игрока ] [ причина ]" );

	if( !IsLogged(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	AdminIsHacked( playerid, TYPE_CMD, reason );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	if( (Player[params[0]][uWarn] + 1) > 2 )
	{
		format:g_small_string( "Администратор %s[%d] заблокировал игрока %s[%d] (3/3) (%s)",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0],
			reason
		);
	
	}
	else
	{
		format:g_small_string( "Администратор %s[%d] выдал предупреждение игроку %s[%d] (%d/3). (%s)",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0],
			Player[params[0]][uWarn] + 1,
			reason
		);
	}
	
	SendAdmin:ToAll( C_RED, g_small_string );

	gbWarn( params[0], reason, playerid );
	
    clean_array();
    #undef reason
	return 1;
}

CMD:unwarn( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "unwarn" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unwarn [ имя/id игрока ]" );

	if( !IsLogged( params[0] ) || IsKicked( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	 
	if( !Player[params[0]][uWarn] )
		return SendClient:( playerid, C_WHITE, ""gbDefault"Данный игрок не имеет предупреждений." );
	
	AdminIsHacked( playerid, TYPE_CMD );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] снял предупреждение с %s[%d].",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0]
	);
	
	SendAdmin:( C_GRAY, g_small_string );
	
	format:g_small_string( ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" снял с Вас предупреждение.",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0]
	);
	
	SendClient:( params[0], C_WHITE, g_small_string );

	Player[params[0]][uWarn] -= 1;
	UpdatePlayer( playerid, "uWarn", Player[params[0]][uWarn] );
	
    clean_array();
	return 1;
}

CMD:mute( playerid, params[] ) 
{
	#define reason  params[2]
	
	if( !GetAccessCommand( playerid, "mute" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

 	if( sscanf( params, "uds[32]", params[0], params[1], reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /mute [ имя/id игрока ] [ минуты ] [ причина ]" );

	if( !IsLogged(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	 
	if( Player[params[0]][uMute] != 0 )
		return SendClient:( playerid, C_WHITE, ""gbDefault"Данный игрок уже имеет блокировку IC чата." );
	
	if( params[1] < 1 || params[1] > 600 )
		return SendClient:( playerid, C_WHITE, ""gbDefault"Некорректное количество минут. Используйте от 1 до 600 минут." );
	
	AdminIsHacked( playerid, TYPE_CMD, reason );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	format:g_small_string( "Администратор %s[%d] заблокировал IC чат игроку %s[%d] на %d минут. (%s)",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0],
		params[1],
		reason
	);
	
	SendAdmin:ToAll( C_RED, g_small_string );

	Player[params[0]][uMute] = params[1];
	UpdatePlayer( playerid, "uMute", Player[params[0]][uMute] );
	
    clean_array();
    #undef reason
	return 1;
}

CMD:unmute( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "unmute" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unmute [ имя/id игрока ]" );

	if( !IsLogged( params[0] ) || IsKicked( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	 
	if( Player[params[0]][uMute] == 0 )
		return SendClient:( playerid, C_WHITE, ""gbDefault"Данный игрок не имеет блокировки IC чата." );
	
	AdminIsHacked( playerid, TYPE_CMD );
		
	format:g_small_string( "Администратор %s[%d] разблокировал IC чат игроку %s[%d].",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0]
	);
	
	SendAdmin:ToAll( C_RED, g_small_string );

	Player[params[0]][uMute] = 0;
	UpdatePlayer( playerid, "uMute", 0 );
	
    clean_array();
	return 1;
}

CMD:bmute( playerid, params[] ) 
{
	#define reason  params[2]
	if( !GetAccessCommand( playerid, "bmute" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

 	if( sscanf( params, "uds[32]", params[0], params[1], reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /bmute [ имя/id игрока ] [ минуты ] [ причина ]" );

	if( !IsLogged(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	 
	if( Player[params[0]][uBMute] != 0 )
		return SendClient:( playerid, C_WHITE, ""gbDefault"Данный игрок уже имеет блокировку OOC чата." );
	
	if( params[1] < 1 || params[1] > 600 )
		return SendClient:( playerid, C_WHITE, ""gbDefault"Некорректное количество минут. Используйте от 1 до 600 минут." );
	
	AdminIsHacked( playerid, TYPE_CMD, reason );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	format:g_small_string( "Администратор %s[%d] заблокировал OOC чат игроку %s[%d] на %d минут. (%s)",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0],
		params[1],
		reason
	);
	
	SendAdmin:ToAll( C_RED, g_small_string );

	Player[params[0]][uBMute] = params[1];
	UpdatePlayer( playerid, "uMute", Player[params[0]][uBMute] );
    
	clean_array();
    #undef reason
	return 1;
}

CMD:unbmute( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "unbmute" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unbmute [ имя/id игрока ]" );

	if( !IsLogged(params[0]) || IsKicked(params[0]) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	 
	if( Player[params[0]][uBMute] == 0 )
		return SendClient:( playerid, C_WHITE, ""gbDefault"Данный игрок не имеет блокировки IC чата." );
	
	format:g_small_string( "Администратор %s[%d] разблокировал OOC чат игроку %s[%d].",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0]
	);
	
	SendAdmin:ToAll( C_RED, g_small_string );

	Player[params[0]][uBMute] = 0;
	UpdatePlayer( playerid, "uBMute", 0 );
	
    clean_array();
	return 1;
}

CMD:sp( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "sp" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /sp [ имя/id игрока ]" );

	if( !IsLogged(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( Admin[params[0]][aLevel] >= 5 && Admin[playerid][aLevel] < 5 )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
	
	AdminSpectatePlayer( playerid, params[0] );
	return 1;
}

CMD:unsp( playerid )
{
	if( !GetAccessCommand( playerid, "unsp" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	return AdminUnSpectate( playerid );
}

CMD:cleardrop( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "cleardrop" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /cleardrop [ радиус ]" );
		
	if( params[0] < 0 )
		return SendClient:( playerid, C_WHITE, !""gbError"Радиус не может быть отрицательным." );
	
	for( new i; i != MAX_DROP_ITEMS; i++ )
	{
		if( IsPlayerInRangeOfPoint( playerid, params[0], DropItem[i][item_pos_x], DropItem[i][item_pos_y], DropItem[i][item_pos_z] ) )
		{		
			if( DropItem[i][item_id] == 0 )
				continue;
			
			if( IsValidDynamicObject( DropItem[i][item_object] ) )
			{
				DestroyDynamicObject( DropItem[i][item_object] );
			}
			
			if( IsValidDynamic3DTextLabel( DropItem[i][item_label] ) )
			{
				DestroyDynamic3DTextLabel( DropItem[i][item_label] );
			}	
			
			clearDropItem( i );
		}
	}
	
	return 1;
}

CMD:ban( playerid, params[] ) 
{
	#define days    	params[1]
	#define reason  	params[2]
	
	if( !GetAccessCommand( playerid, "ban" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "uds[32]", params[0], days, reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /ban [ имя/id игрока ] [ количество дней ] [ причина ]" );

	if( !IsPlayerConnected(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( GetAccessAdmin( params[0], 7 ) && !GetAccessAdmin( playerid, 7 ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );

	if( days < 1 || days > 60 )
	    return SendClient:( playerid, C_WHITE, !""gbError"Максимальное количество дней - 60, минимальное - 1." );
	  
	AdminIsHacked( playerid, TYPE_CMD, reason );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	format:g_small_string( "Администратор %s[%d] заблокировал игрока %s[%d] на %d дней. (%s)",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0],
		days,
		reason
	);

	SendAdmin:ToAll( C_RED, g_small_string );
	
	format:g_small_string( ""ADMIN_PREFIX" - IP: %s", Player[params[0]][tIP] );
	SendAdmin:( C_RED, g_small_string );
	    
	gbBan( params[0], reason, gettime() + days * 86400, playerid );
	
	
	#undef days
	#undef reason
	return 1;
}

CMD:offban( playerid, params[] )
{
	#define days    	params[0]
	
	static 
		string_reason	[ 128 ],
		string_name		[ MAX_PLAYER_NAME ];
	
	if( !GetAccessCommand( playerid, "offban" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( sscanf( params, "dp<|>s[24]s[128]", params[0], string_name, string_reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /offban [ количество дней - 0 навсегда ] [ имя игрока|причина ]" );

	foreach( new i: Player)
	{
		if( Player[i][uName][0] != EOS && !strcmp( Player[i][uName], string_name, true ) )
		{
			return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок находится в сети, используйте "cBLUE"/ban"cWHITE"." );
		}
	}

	if( days < 0 || days > 60 )
	    return SendClient:( playerid, C_WHITE, !""gbError"Максимальное количество дней - 60, минимальное - 1, навсегда - 0" );

	AdminIsHacked( playerid, TYPE_CMD, string_reason );
	
	clean:<offline_ban[ban_reason]>;
	clean:<offline_ban[ban_name]>;
	strcat( offline_ban[ban_reason], string_reason, 128 );
	strcat( offline_ban[ban_name], string_name, 24 );
	
	offline_ban[ban_days] = days;

	mysql_format:g_small_string( "SELECT `uID`, `uName` FROM `"DB_USERS"` WHERE `uName` = '%e'", string_name );
	mysql_tquery( mysql, g_small_string, "OnOfflineBanStepOne", "ii", playerid, days );
	
	#undef days
	return 1;
}

/*CMD:ack( playerid, params[] ) 
{
	new
	    server_tick = GetTickCount();
	
	if( GetPVarInt( playerid, "Admin:CkTime" ) > server_tick )
		return SendClientMessage( playerid, C_WHITE, !""gbError"Использовать данную команду можно раз в 30 секунд.");
	
	if( !GetAccessCommand( playerid, "ack" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /ack [ имя/id игрока ]" );

	if( !IsLogged( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	  
	AdminIsHacked( playerid, TYPE_CMD );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	format:g_small_string( "Администратор %s[%d] утвердил <Character Kill> персонажу %s.",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName]
	);

	SendAdmin:ToAll( C_RED, g_small_string );
	
	gbMessageKick( params[0], "", -2, playerid, false );
	
	UpdatePlayer( params[0], "uActive", 3 );
	
	SetPVarInt( playerid, "Admin:CkTime", server_tick + ( 30 * 1000 ) );
	
	return 1;
}*/

CMD:banip( playerid, params[] ) 
{
	new
		ip[ 16 ],
		reason[ 32 ];
	
	if( !GetAccessCommand( playerid, "banip" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "s[16]s[32]", ip, reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /banip [ ip игрока ] [ причина ]" );
	
	mysql_format( mysql, g_string, sizeof g_string, 
		"INSERT INTO "DB_IPBANS"\
			( ipban_admin_id, ipban_admin_name, ipban_ip, ipban_reason, ipban_time )\
		 VALUES\
			( %d, '%s', '%s', '%e', %d )",
		 Admin[playerid][aID],
		 Admin[playerid][aName],
		 ip,
		 reason,
		 gettime()
	);
	
	mysql_tquery( mysql, g_string );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] заблокировал IP адрес: %s (%s)",
		Player[playerid][uName],
		playerid,
		ip,
		reason
	);

	SendAdmin:( C_DARKGRAY, g_small_string );
	
	return 1;
}

CMD:unbanip( playerid, params[] ) 
{
	new
		ip[ 16 ];
	
	if( !GetAccessCommand( playerid, "unbanip" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "s[16]", ip ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unbanip [ ip игрока ]" );
	
	mysql_format( mysql, g_string, sizeof g_string, 
		"SELECT ipban_id FROM "DB_IPBANS" WHERE ipban_ip = '%e'",
		 ip
	);
	
	mysql_tquery( mysql, g_string, "OnUnbannedIp", "ds", playerid, ip );

	return 1;
}

CMD:unban( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "unban" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "s[21]", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unban [ имя игрока ]" );
	
	mysql_format( mysql, g_string, sizeof g_string, 
		"SELECT bID FROM "DB_BANS" WHERE bUserName = '%e'",
		params[0]
	);
	
	mysql_tquery( mysql, g_string, "OnUnbannedPlayer", "ds", playerid, params[0] );
	
	return 1;
}

/*CMD:unretest( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "unretest" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "s[21]", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unretest [ имя игрока ]" );
	
	mysql_format( mysql, g_string, sizeof g_string, 
		"SELECT uRetest FROM "DB_USERS" WHERE uName = '%e'",
		 params[0]
	);
	
	mysql_tquery( mysql, g_string, "OnUnretestPlayer", "ds", playerid, params[0] );
	
	return 1;
}*/

CMD:jail( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "jail" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "uds[32]", params[0], params[1], params[2] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /jail [ имя/id игрока ] [ количество минут ] [ причина ]" );
	
	if( !IsLogged( params[0] ) || IsKicked( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Admin[playerid][aLevel] < Admin[params[0]][aLevel] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
	
	if( Player[params[0]][uDMJail] != 0 )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже находится в Де Моргане.");
	
	if( params[1] > 600 || params[1] < 1 )
		return SendClient:( playerid, C_WHITE, !""gbError"Максимальное количество минут - 600, минимальное 1." );
		
	Player[params[0]][uDMJail] = params[1];
	
	SetPlayerVirtualWorld( params[0], 5 );
	setPlayerPos( params[0], RANGE_DE_MORGAN );
	
	format:g_small_string( "Администратор %s[%d] посадил игрока %s[%d] в Де Морган на %d минут. (%s)",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0],
		params[1],
		params[2]
	);

	SendAdmin:ToAll( C_RED, g_small_string );
	checkPlayerUseTexViewer( params[0] );
	
	UpdatePlayer( params[0], "uDMJail", Player[params[0]][uDMJail] );
	
	return 1;
}


CMD:unjail( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "unjail" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unjail [ имя/id игрока ]" );
	
	if( !IsLogged( params[0] ) || IsKicked( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Player[params[0]][uDMJail] == 0 )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок не находится в Де Моргане." );
	
	static 
		Float: x, 
		Float: y, 
		Float: z, 
		Float: root;
		
	Player[params[0]][uDMJail] = 0;
		
	GetSpawnInfo( playerid, x, y, z, root );
	//SetPlayerVirtualWorld( params[0], 0 );
	setPlayerPos( params[0], x, y, z );
	SetPlayerFacingAngle( params[0], root );
	
	format:g_small_string( "Администратор %s[%d] выпустил игрока %s[%d] из Де Моргана.",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0]
	);

	SendAdmin:ToAll( C_RED, g_small_string );
	
	format:g_small_string( ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" выпустил Вас из Де Моргана.",
		Player[playerid][uName],
		playerid
	);

	SendClient:( params[0], C_WHITE, g_small_string );
	
	UpdatePlayer( params[0], "uDMJail", 0 );
	
	return 1;
}


CMD:freeze( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "freeze" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /freeze [ имя/id игрока ]" );
	
	if( !IsLogged( params[0] ) || IsKicked( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Admin[playerid][aLevel] < Admin[params[0]][aLevel])
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
	
	/*if( !GetPVarInt( params[0], "Player:Freeze" ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок уже заморожен." );*/
	
	togglePlayerControllable( params[0], 0 );

	format:g_small_string( ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" заморозил Вас.",
		Player[playerid][uName],
		playerid
	);

	SendClient:( params[0], C_WHITE, g_small_string );
	
	format:g_small_string( ""gbSuccess"Вы заморозили игрока "cBLUE"%s[%d]"cWHITE".",
		GetAccountName( params[0] ),
		params[0]
	);

	SendClient:( playerid, C_WHITE, g_small_string );

	return 1;
}

CMD:unfreeze( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "unfreeze" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unfreeze [ имя/id игрока ]" );
	
	if( !IsLogged( params[0] ) || IsKicked( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	/*if( GetPVarInt( params[0], "Player:Freeze" ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок не заморожен." );*/
	
	togglePlayerControllable( playerid, 1 );

	format:g_small_string( ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" разморозил Вас.",
		Player[playerid][uName],
		playerid
	);

	SendClient:( params[0], C_WHITE, g_small_string );
	
	format:g_small_string( ""gbSuccess"Вы разморозили игрока "cBLUE"%s[%d]"cWHITE".",
		GetAccountName( params[0] ),
		params[0]
	);

	SendClient:( playerid, C_WHITE, g_small_string );

	return 1;
}

CMD:iban( playerid, params[] ) 
{
	#define reason  	params[1]

	if( !GetAccessCommand( playerid, "iban" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "us[32]", params[0], reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /iban [ имя/id игрока ] [ причина ]" );

	if( !IsPlayerConnected(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( GetAccessAdmin( params[0], 7 ) && !GetAccessAdmin( playerid, 7 ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	AdminIsHacked( playerid, TYPE_CMD, reason );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	format:g_small_string( "Администратор %s[%d] заблокировал игрока %s[%d] навсегда. Причина: %s",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0],
		reason
	);

	SendAdmin:( C_RED, g_small_string );

	format:g_small_string( ""ADMIN_PREFIX" - IP: %s", Player[params[0]][tIP] );
	SendAdmin:( C_DARKGRAY, g_small_string );
	
	gbBan( params[0], reason, _, playerid );
	
    clean_array();

	#undef reason
	return 1;
}

CMD:sban( playerid, params[] ) 
{
	#define days    	params[1]
	#define reason  	params[2]

	if( !GetAccessCommand( playerid, "sban" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "uds[32]", params[0], days, reason ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /sban [ имя/id игрока ] [ количество дней - 0 навсегда ] [ причина ]" );

	if( !IsPlayerConnected(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );

	if( days < 0 || days > 60 )
	    return SendClient:( playerid, C_WHITE, !""gbError"Максимальное количество дней - 60, минимальное - 1, навсегда - 0" );

	AdminIsHacked( playerid, TYPE_CMD, reason );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	if( days == 0 ) 
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] тихо заблокировал %s[%d] навсегда. (%s)",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0],
			reason
		);
	} 
	else 
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] тихо заблокировал %s[%d] на %d дней. (%s)",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0],
			days,
			reason
		);
	}

	SendAdmin:( C_DARKGRAY, g_small_string );
	
	format:g_small_string( ""ADMIN_PREFIX" - IP: %s", Player[params[0]][tIP] );
	SendAdmin:( C_DARKGRAY, g_small_string );
	
    new
		lastdate = INFINITY_DATE;

	if( days != 0 )
		lastdate = gettime() + days * 86400;

	gbBan( params[0], reason, lastdate, playerid, true );
	
    clean_array();
	
	#undef days
	#undef reason
	return 1;
}

CMD:skick( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "skick" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /skick [ имя/id игрока ] " );

	if( !IsPlayerConnected(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	AdminIsHacked( playerid, TYPE_CMD );
	AdminIsHacked( playerid, TYPE_ADMIN, _, params[0] );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] тихо отсоединил %s[%d] от сервера.",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0]
	);

	SendAdmin:( C_DARKGRAY, g_small_string );

	gbKick( params[0] );
	
    clean_array();
	return 1;
}

CMD:goto( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "goto" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /goto [ имя/id игрока ] " );

	if( !IsLogged(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	   
	/*if( Admin[params[0]][aLevel] >= 5 && Admin[playerid][aLevel] < 5 )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );*/
		
	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos( params[0], x, y, z );
	
	if( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) {
		new
		    Float:vehicle_x,
		    Float:vehicle_y,
		    Float:vehicle_z;
		    
		GetVehicleVelocity( GetPlayerVehicleID( playerid ), vehicle_x, vehicle_y, vehicle_z );
		setVehiclePos( GetPlayerVehicleID( playerid ), x + 1.0, y + 1.0, z );
		SetVehicleVelocity( GetPlayerVehicleID( playerid ), vehicle_x, vehicle_y, vehicle_z );
	} 
	else 
	{
		setPlayerPos( playerid, x + 1.0, y + 1.0, z );
	}
	
	SetPlayerInterior( playerid, GetPlayerInterior( params[0] ) );
    SetPlayerVirtualWorld( playerid, GetPlayerVirtualWorld( params[0] ) );
    
	format:g_small_string( ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" телепортировался к Вам.",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0]
	);

	SendClient:( params[0], C_DARKGRAY, g_small_string );

	format:g_small_string( ""gbSuccess"Вы телепортировались к игроку "cBLUE"%s[%d]"cWHITE".",
		Player[params[0]][uName],
		params[0]
	);

	SendClient:( playerid, C_DARKGRAY, g_small_string );
	
	checkPlayerUseTexViewer( playerid );
    clean_array();
	
	return 1;
}

CMD:bgoto( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "bgoto" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /bgoto [ id бизнеса ] " );

	if( GetPlayerVirtualWorld( playerid ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете телепортироваться из этого места." );
		
	new
		bool:flag = false,
		bid;
		
	for( new i; i < MAX_BUSINESS; i++ )
	{
		if( params[0] == BusinessInfo[i][b_id] && params[0] != 0 )
		{
			flag = true;
			bid = i;
			break;
		}
	}
	
	if( !flag )	return SendClient:( playerid, C_WHITE, !""gbError"Указанного бизнеса не существует." );
	
	setPlayerPos( playerid, BusinessInfo[bid][b_enter_pos][0], BusinessInfo[bid][b_enter_pos][1], BusinessInfo[bid][b_enter_pos][2] );
	
	format:g_small_string( ""gbSuccess"Вы телепортировались к "cBLUE"%s #%d"cWHITE".",
		GetBusinessType( bid ),
		params[0]
	);

	SendClient:( playerid, C_DARKGRAY, g_small_string );
	
	return 1;
}

CMD:hgoto( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "hgoto" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /hgoto [ id дома ] " );

	if( GetPlayerVirtualWorld( playerid ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете телепортироваться из этого места." );
		
	new
		bool:flag = false,
		h;
		
	for( new i; i < MAX_HOUSE; i++ )
	{
		if( params[0] == HouseInfo[i][hID] && params[0] != 0 )
		{
			flag = true;
			h = i;
			break;
		}
	}
	
	if( !flag )	return SendClient:( playerid, C_WHITE, !""gbError"Указанного дома не существует." );
	
	setPlayerPos( playerid, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] );
	
	format:g_small_string( ""gbSuccess"Вы телепортировались к "cBLUE"дому #%d"cWHITE".",
		params[0]
	);
	SendClient:( playerid, C_DARKGRAY, g_small_string );
	
	return 1;
}

CMD:gethere( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "gethere" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /gethere [ имя/id игрока ] " );

	if( !IsLogged(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	/*if( Admin[params[0]][aLevel] >= 5 && Admin[playerid][aLevel] < 5 )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );*/
	
	new
		Float: x,
		Float: y,
		Float: z,
		_: player_state;

	GetPlayerPos( playerid, x, y, z );

	player_state = GetPlayerState( params[0] );
	
	if( player_state == PLAYER_STATE_DRIVER ) 
	{
		new
		    Float:vehicle_x,
		    Float:vehicle_y,
		    Float:vehicle_z;

		GetVehicleVelocity( GetPlayerVehicleID( params[0] ), vehicle_x, vehicle_y, vehicle_z );
		setVehiclePos( GetPlayerVehicleID( params[0] ), x + 1.0, y + 1.0, z );
		SetVehicleVelocity( GetPlayerVehicleID( params[0] ), vehicle_x, vehicle_y, vehicle_z );
	}
	else if( player_state == PLAYER_STATE_SPECTATING && GetAccessAdmin( params[0], 1 ) )
	{
		AdminUnSpectate( params[0], false );
		setPlayerPos( params[0], x + 1.0, y + 1.0, z );
	}
	else 
	{
		setPlayerPos( params[0], x + 1.0, y + 1.0, z );
	}

	SetPlayerInterior( params[0], GetPlayerInterior( playerid ) );
    SetPlayerVirtualWorld( params[0], GetPlayerVirtualWorld( playerid ) );

	format:g_small_string( ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" телепортировал Вас к себе.",
		Player[playerid][uName],
		playerid
	);

	SendClient:( params[0], C_DARKGRAY, g_small_string );
	
	checkPlayerUseTexViewer( params[0] );

	format:g_small_string( ""ADMIN_PREFIX" %s[%d] телепортировал к себе %s[%d].",
		Player[playerid][uName],
		playerid,
		Player[params[0]][uName],
		params[0]
	);

	SendAdmin:( C_GRAY, g_small_string );

    clean_array();
	return 1;
}

CMD:weapon( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "weapon" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /weapon [ id игрока ] " );
		
	if( !IsLogged( params[0] ) || IsKicked( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	new 
		weapon[ MAX_WEAPON_SLOT ],
		ammo[ MAX_WEAPON_SLOT ],
		weapon_name[ 32 ],
		bool: count = false;
		
	clean:<g_big_string>;
	
	format:g_small_string( ""gbDefault"Информация об оружии игрока "cBLUE"%s[%d]"cWHITE"\n\n",
		GetAccountName( params[0] ),
		params[0]
	);
	strcat( g_big_string, g_small_string );
	
	for( new i; i < MAX_WEAPON_SLOT; i++ )
	{
		GetPlayerWeaponData( params[0], i, weapon[i], ammo[i] );
		
		if( !weapon[i] )
			continue;
			
		GetWeaponName(  weapon[i], weapon_name, sizeof weapon_name );
		format:g_small_string( " - Оружие: "cBLUE"%s"cWHITE" (Патронов: "cBLUE"%d"cWHITE") | Слот: "cBLUE"%d"cWHITE"\n",
			weapon_name,
			ammo[i],
			i
		);
		
		strcat( g_big_string, g_small_string );
		
		count = true;
	}
	
	if( !count )
		return SendClient:( playerid, C_WHITE, ""gbDefault"У данного игрока отсутствует оружие." );
	
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
	
	return 1;
}

CMD:slap( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "slap" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

 	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /slap [ имя/id игрока ] " );

	if( !IsLogged(params[0]) || IsKicked(params[0]) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Admin[playerid][aLevel] < Admin[params[0]][aLevel])
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		
	new
		Float:x,
		Float:y,
		Float:z,
		Float:health;
		
	GetPlayerHealth( params[0], health );
	setPlayerHealth( params[0], health - 5 );
	GetPlayerPos( params[0], x, y, z );
	setPlayerPos( params[0], x, y, z + 5 );

	if( params[0] != playerid )
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] подкинул %s[%d].",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0]
		);

		SendAdmin:( C_GRAY, g_small_string );
	}
	
	PlayerPlaySound( params[0], 1130, x, y, z + 5 );
	
    clean_array();
	return 1;
}

CMD:veh( playerid, params[] ) 
{
	#define model   	params[0]
	#define color1  	params[1]
	#define color2  	params[2]
	
	if( !GetAccessCommand( playerid, "veh" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "ddd", model, color1, color2 ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /veh [ модель ] [ цвет 1 ] [ цвет 2 ]" );

	if( model < 400 || model > 611  )
	    return SendClient:( playerid, C_WHITE, !""gbError"Модель создаваемого транспорта должна быть от 400 до 600." );

	if( color1 < 0 || color1 > 255 )
	    return SendClient:( playerid, C_WHITE, !""gbError"Цвет создаваемого транспорта должен быть от 0 до 255." );
	    
	if( color2 < 0 || color2 > 255 )
	    return SendClient:( playerid, C_WHITE, !""gbError"Цвет создаваемого транспорта должен быть от 0 до 255." );

	if( GetPlayerInterior( playerid ) != 0 )
	    return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете создать транспорт в интерьере." );
		
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos( playerid, x, y, z );

	new
	    vehicleid = CreateVehicleEx( model, x + 1.5, y + 1.5, z, 0.0, color1, color2, -1 );

    COUNT_ADMIN_VEHICLES++;
	
    AdminVehicle[vehicleid][avID] 		= COUNT_ADMIN_VEHICLES;
	AdminVehicle[vehicleid][avServerID] = vehicleid;
	AdminVehicle[vehicleid][avModel] 	= model;
	strmid( AdminVehicle[vehicleid][avAdmin], GetAccountName( playerid ), 0, strlen( GetAccountName( playerid ) ), MAX_PLAYER_NAME );
	
	SetVehicleVirtualWorld( vehicleid, GetPlayerVirtualWorld( playerid ) );
	LinkVehicleToInterior( vehicleid, GetPlayerInterior( playerid ) );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] создал транспорт %s[%d].",
	    GetAccountName( playerid ),
	    playerid,
	    GetVehicleModelName( model ),
	    vehicleid
	);
	
	SendAdmin:( C_GRAY, g_small_string );
	
	format:g_small_string( ""gbSuccess"Вы успешно создали транспорт - ID: "cBLUE"%d"cWHITE".",
	    vehicleid
	);
	
	SendClient:( playerid, C_WHITE, g_small_string );
	
	clean_array();

    #undef model
    #undef color1
    #undef color2
	return 1;
}

CMD:settime( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "settime" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0]) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /settime [ час ]" );
	
	if( params[0] < -1 || params[0] > 23 )
		return SendClient:( playerid, C_WHITE, !""gbError"Час не может быть больше 23 и меньше -1." );
	
	server_weather_time = params[0];
	
	if( server_weather_time == INVALID_PARAM )
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] установил игровое время по умолчанию.",
			GetAccountName( playerid ),
			playerid
		);
	}
	else
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] изменил игровое время на %02d:00.",
			GetAccountName( playerid ),
			playerid,
			params[0]
		);
	}

	SendAdmin:( C_GRAY, g_small_string );
	
	foreach(new i : Player)
	{
		UpdateWeather( i );
	}
	
	return 1;
}

CMD:dveh( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "dveh" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /dveh [ id транспорта ]" );

	if( !AdminVehicle[ params[0] ][avID] || !GetVehicleModel( params[0] ) )
	       return SendClient:( playerid, C_WHITE, !""gbError"Некорректный ID созданного транспорта." );

	DestroyVehicleEx( params[0] );
		
	COUNT_ADMIN_VEHICLES--;
    
    AdminVehicle[ params[0] ][avServerID] 	= 
	AdminVehicle[ params[0] ][avID] 		=  
	AdminVehicle[ params[0] ][avModel] 		= 0;
	
	AdminVehicle[ params[0] ][avAdmin][0] = EOS;
	
	SendClient:( playerid, C_WHITE, !""gbSuccess"Вы успешно удалили созданный транспорт." );

	return 1;
}

CMD:dvehall( playerid ) 
{
	if( !GetAccessCommand( playerid, "dvehall" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

	if( COUNT_ADMIN_VEHICLES == 0x0 )
		return SendClient:( playerid, C_WHITE, ""gbError"Созданный транспорт на данный момент отсутствует на сервере.");
		
	for( new i; i < MAX_VEHICLES; i++ ) 
	{
		if( !AdminVehicle[i][avID] ) continue;
		
		DestroyVehicleEx( i );
		
		AdminVehicle[ i ][avServerID] 	= 
		AdminVehicle[ i ][avID] 		=  
		AdminVehicle[ i ][avModel] 		= 0;
		
		AdminVehicle[ i ][avAdmin][0] = EOS;
	}
	
	COUNT_ADMIN_VEHICLES = 0x0;
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] удалил весь созданный транспорт.",
		GetAccountName( playerid ),
		playerid
	);

	SendAdmin:( C_GRAY, g_small_string );

	return 1;
}

CMD:setweather( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "setweather" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /setweather [ id погоды | -1 погода установленная сервером ]" );

	if( params[0] < -1 || params[0] > 20 )
		return SendClient:( playerid, C_WHITE, !""gbError"Идентификатор погоды должен быть не менее 0 и не более 20." );
		
	if( params[0] == -1 )
	{
		server_weather_type = 0;
		server_weather = server_weather_list[ random( sizeof server_weather_list ) ];
		SetPlayerWeather( playerid, server_weather_list[ server_weather ] );
		
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] установил погоду по умолчанию.",
			GetAccountName( playerid ),
			playerid
		);
		
		SendAdmin:( C_GRAY, g_small_string );
	}
	else
	{
		server_weather_type = 1;
		server_weather = params[0];
		SetPlayerWeather( playerid, server_weather_list[ server_weather ] );
		
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] установил погоду на сервере - %d.",
			GetAccountName( playerid ),
			playerid,
			params[0]
		);
		
		SendAdmin:( C_GRAY, g_small_string );
	}
	
	foreach(new i : Player)
	{
		UpdateWeather( i );
	}
	
	return 1;
}

CMD:aheal( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "aheal" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "u", params[0] ) ) 
		return SendClient:(playerid, C_WHITE, !""gbDefault"Введите: /aheal [ имя/id игрока ]");
	
	if( !IsLogged( params[0] ) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	HealthPlayer( params[0] );
	
	if( params[0] != playerid ) 
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] вылечил %s[%d].",
			GetAccountName( playerid ),
			playerid,
			GetAccountName( params[0] ),
			params[0]
		);
		
		SendAdmin:( C_GRAY, g_small_string );
		
		format:g_small_string( ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" вылечил Вас.",
			Player[playerid][uName],
			playerid,
			Player[params[0]][uName],
			params[0]
		);
		
		SendClient:( params[0], C_WHITE, g_small_string );
	} 
	else 
	{
		SendClient:( playerid, C_WHITE, ""gbDefault"Вы успешно вылечили себя." );
	}
	
	return 1;
}

CMD:giveitem( playerid, params[] ) 
{
	#define itemid	params[1]
	
	if( !GetAccessCommand( playerid, "giveitem" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "uddd", params[0], itemid, params[2], params[3] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /giveitem [ имя/id игрока ] [ id предмета ] [ параметры ]");
	
	if( !IsLogged( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( itemid < 1 || itemid > COUNT_INVENTORY_ITEMS - 1 ) 
	{
		pformat:( ""gbDefault"Идентификатор предмета должен быть не менее 1 и не более "cBLUE"%d"cWHITE".", 
			COUNT_INVENTORY_ITEMS
		);
		psend:( playerid, C_WHITE );
		
		return 1;
	}
	
	switch( inventory[ getInventoryId( itemid ) ][i_type] )
	{
		case INV_PHONE :
		{
			new
				number = randomize( 100000, 999999 ); //Генерируем уникальный номер телефона

			CreatePhone( params[0], number );
			
			pformat:( ""gbDefault"Номер выданного телефона - "cBLUE"%d"cWHITE".", number );
			psend:( playerid, C_WHITE );
			
			if( !giveItem( params[0], itemid, 1, 18874, number ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У данного игрока нет свободного места в инвентаре." );
		}
		
		case INV_ARMOUR :
		{
			if( params[2] < 1 || params[2] > 100 )
				return SendClient:( playerid, C_WHITE, !""gbError"Значение бронежилета должно быть от 1 до 100." );
		
			if( !giveItem( params[0], itemid, 1, params[2] ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У данного игрока нет свободного места в инвентаре." );
		}
		
		case INV_ATTACH :
		{
			if( inventory[ getInventoryId( itemid ) ][i_model] == INVALID_PARAM )
			{
				if( !giveItem( params[0], itemid, 1, params[2] ) )
					return SendClient:( playerid, C_WHITE, ""gbError"У данного игрока нет свободного места в инвентаре." );
			}
			else
			{
				if( !giveItem( params[0], itemid ) )
					return SendClient:( playerid, C_WHITE, ""gbError"У данного игрока нет свободного места в инвентаре." );
			}
		}
		
		case INV_SKIN :
		{
			if( params[2] < 1 || params[2] > 311 )
				return SendClient:( playerid, C_WHITE, !""gbError"Параметр одежды должен быть в диапазоне от 1 до 311." );
		
			if( !giveItem( params[0], itemid, 1, params[2] ) )
				return SendClient:( playerid, C_WHITE, !""gbError"У данного игрока нет свободного места в инвентаре." );
		}
		
		case INV_GUN, INV_AMMO, INV_SMALL_GUN, INV_COLD_GUN :
		{
			if( !giveItem( params[0], itemid, 1, params[2] ) )
					return SendClient:( playerid, C_WHITE, ""gbError"У данного игрока нет свободного места в инвентаре." );
		}
		
		default:
		{
			if( !giveItem( params[0], itemid ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У данного игрока нет свободного места в инвентаре." );
		}
	}
	
	if( params[0] != playerid ) 
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] выдал %s[%d] предмет - %s[%d].",
				GetAccountName( playerid ),
				playerid,
				GetAccountName( params[0] ),
				params[0],
				inventory[itemid][i_name],
				itemid
		);
			
		SendAdmin:( C_GRAY, g_small_string );
	} 
	else 
	{			
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] выдал себе предмет - %s[%d].",
				GetAccountName( playerid ),
				playerid,
				inventory[itemid][i_name],
				itemid
		);
			
		SendAdmin:( C_GRAY, g_small_string );
	}
	
	#undef itemid
	
	return 1;
}

CMD:vehlist( playerid ) 
{
	if( !GetAccessCommand( playerid, "vehlist" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

	new
		count;
		
	clean:<g_big_string>;
	
	strcat( g_big_string, ""cBLUE"ID\t"cBLUE"Модель\t"cBLUE"Создал\n" );

	for( new i = 0; i != MAX_VEHICLES; i++ ) 
	{
		if( !AdminVehicle[i][avServerID] ) 
			continue;
			
		format:g_small_string( "%d\t%s\t"cBLUE"%s"cWHITE"\n",
			AdminVehicle[i][avServerID],
			GetVehicleModelName( AdminVehicle[i][avModel] ),
			AdminVehicle[i][avAdmin]
		);

		strcat( g_big_string, g_small_string );
		g_dialog_select[playerid][count] = i;
		
		count ++;
	}
	
	if( !count )
		return SendClient:( playerid, C_WHITE, ""gbDefault"На данный момент нет созданных транспортных средств.");
	
	showPlayerDialog( playerid, d_admin + 4, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "Действия", "Закрыть" );
	
	clean_array();
	return 1;
}

CMD:o( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "o" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);

 	if( sscanf( params, "s[128]", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /o [ текст ]" );
	
	format:g_small_string( "Администратор %s[%d]: %s",
		Player[playerid][uName],
		playerid,
		params[0]
	);
	
	SendAdminLongAll:( C_ORANGE, g_small_string );

    clean_array();
	return 1;
}

CMD:removeadmin( playerid, params[] )
{
	#define adminid		params[0]
	
	if( !GetAccessCommand( playerid, "removeadmin" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /removeadmin [ имя/id администратора ]" );
	
	if( !IsLogged(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Admin[playerid][aLevel] < Admin[params[0]][aLevel])
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
	
	if( Admin[adminid][aID] == 0 && Admin[adminid][aLevel] == 0 )
		return SendClient:( playerid, C_WHITE, ""gbError"Данный игрок не является администратором.");
	
	mysql_format( mysql, g_string, sizeof g_string, "SELECT aID FROM "DB_ADMINS" WHERE aID = %d", 
		Admin[adminid][aID]
	);
	
	mysql_tquery( mysql, g_string, "OnRemoveAdmin", "ii", playerid, adminid );
	
	#undef adminid
	
	return 1;
}

CMD:restart( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "restart" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
	
	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /restart [ время в минутах | 0 - отменить рестарт ]" );
		
	if( params[0] < 0 || params[0] > 30 )
		return SendClient:( playerid, C_WHITE, !""gbError"Минимальное количество временени - 1 | Максимальное - 30.");
	
	if( params[0] == 0 )
	{
		server_restart = -1;
		SendClient:( playerid, C_WHITE, ""gbDefault"Вы отменили рестарт сервера." );
	}
	else
	{
		server_restart = params[0];
		
		format:g_small_string( "Администратор %s[%d] установил время рестарта на %d минут.",
			GetAccountName( playerid ),
			playerid,
			params[0]
		);
		
		SendClientAll:( C_RED, g_small_string );
	}
	
	return 1;
}

CMD:removesupport( playerid, params[] )
{
	#define supportid		params[0]
	
	if( !GetAccessCommand( playerid, "removesupport" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "u", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /removesupport [ имя/id саппорта ]" );
	
	if( !IsLogged(params[0]) || IsKicked(params[0]) || params[0] == playerid )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( Support[supportid][sID] == 0 )
		return SendClient:( playerid, C_WHITE, ""gbError"Данный игрок не является саппортом.");
	
	mysql_format( mysql, g_string, sizeof g_string, "SELECT sID FROM "DB_SUPPORTS" WHERE sID = %d", 
		Support[supportid][sID]
	);
	
	mysql_tquery( mysql, g_string, "OnRemoveSupport", "ii", playerid, supportid );
	
	#undef supportid
	
	return 1;
}

CMD:kickall( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "kickall" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
		
	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /kickall [ тип: 0 - всех | 1 - всех, кроме администраторов ]" );
	
	if( params[0] < 0 || params[0] > 1 )
		return SendClient:( playerid, C_WHITE, ""gbError"Укажите корректный тип: 0 - отсоединить от сервера всех | 1 - всех кроме администраторов.");
	
	SendClientAll:( C_ORANGE, "Уважаемые игроки! Производится технический рестарт сервера. Пожалуйста, перезайдите. ");
	//SendAdmin:( C_DARKGRAY, ""ADMIN_PREFIX" Пароль на сервер установлен - 74213473." );
	//SendRconCommand( "password 74213473" );
	
	foreach(new i : Player)
	{
		if( !params[0] )
		{
			if( IsKicked( i ) || i == playerid )
				continue;
		}
		else
		{
			if( IsKicked( i ) || i == playerid || GetAccessAdmin( i, 1 ))
				continue;
		}
		
		gbMessageKick( i, ""cRED"Технический рестарт"cWHITE"" );
	}
	
	return 1;
}

CMD:aduty( playerid ) 
{
	new
	    server_tick = GetTickCount();
		
	if( GetAccessAdmin( playerid, 1 ) ) 
	{
 		OnAdminLogout( playerid );
		//SetPVarInt( playerid, "Admin:DutyTime", server_tick + 20000 );
	}
	else if( GetAccessAdmin( playerid, 1, false ) ) 
	{
		if( !Admin[playerid][aPassword] )
		{
			showPlayerDialog( playerid, d_admin + 6, DIALOG_STYLE_INPUT, " ", acontent_reg, "Далее", "Закрыть" );
		}
		else
		{
			showPlayerDialog( playerid, d_admin, DIALOG_STYLE_INPUT, " ", acontent_login, "Далее", "Закрыть" );
		}
	}
	else
	{
		clean:<g_string>;
		mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM "DB_ADMINS" WHERE aUserID = %d", Player[playerid][uID] );
		mysql_tquery( mysql, g_string, "ReloadAdminAccount", "iii", playerid, 1, server_tick );
	}
	
	return 1;
}

CMD:acp( playerid ) 
{
	if( !GetAccessCommand( playerid, "acp" ) )
 		return SendClient:( playerid, C_WHITE, NO_ACCESS_CMD );

	showPlayerDialog( playerid, d_admin + 1, DIALOG_STYLE_LIST, " ", acontent_acp, "Далее", "Закрыть" );

	return 1;
}

CMD:updatepermission( playerid )
{
	if ( !GetAccessAdmin( playerid, 7 ) )
	    return SendClient:( playerid, C_WHITE, NO_ACCESS_CMD );
	    
	mysql_tquery( mysql, "SELECT * FROM "DB_PERMISSIONS"", "LoadPermissions" );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] обновил права доступа.",
		Player[playerid][uName],
		playerid
	);

	SendAdmin:( C_ORANGE, g_small_string );
	
	printf("[A] %s[%d] has been updated admin permission.", GetAccountName( playerid ), playerid );
	return 1;
}

CMD:unjob( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "unjob" ) )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( sscanf( params, "d", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /unjob [ id игрока ]" );
		
	if( !IsLogged( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( !Player[ params[0] ][uJob] )
		return SendClient:( playerid, C_WHITE, !""gbError"Игрок не устроен на работу." );
		
	if( job_duty{params[0]} )
		return SendClient:( playerid, C_WHITE, !""gbError"Игрок должен завершить рабочий день." );
		
	Player[ params[0] ][uJob] = 
	Job[ params[0] ][j_time] =
	job_duty{ params[0] } = 0;

	pformat:( ""gbDefault"Администратор %s[%d] уволил Вас с текущей работы.", Player[playerid][uName], playerid );
	psend:( params[0], C_WHITE );
	
	UpdatePlayer( params[0], "uJob", 0 );
	UpdatePlayer( params[0], "uJobTime", 0 );
		
	return 1;
}

CMD:getherecar( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "getherecar" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
	
	if( sscanf( params, "i", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /getherecar [ id автомобиля ]" );
		
	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы ввели некорректный id автомобиля." );
		
	new 
		Float:kX,
		Float:kY,
		Float:kZ;
		
	GetPlayerPos( playerid, kX, kY, kZ );
	setVehiclePos( params[0], kX+2.0, kY+2.0, kZ );
	
	SetVehicleVirtualWorld( params[0], GetPlayerVirtualWorld( playerid ) );
	LinkVehicleToInterior( params[0], GetPlayerInterior( playerid ) );
	
	return 1;
}

CMD:gotocar( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "gotocar" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD);
	
	if( GetPlayerVirtualWorld( playerid ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете телепортироваться из этого места." );
	
	if( sscanf( params, "i", params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /gotocar [ id автомобиля ]" );
		
	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы ввели некорректный id автомобиля." );
		
	new 
		car = params[0], 
		Float:pos[3];
		
	GetVehiclePos( car, pos[0], pos[1], pos[2] );
	setPlayerPos( playerid, pos[0], pos[1]+5, pos[2]+5 );
	
	return 1;
}

CMD:fillveh( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "fillveh" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "ii", params[0], params[1] ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /fillveh [ id автомобиля ] [ литры ]" );
		
	if( !GetVehicleModel( params[0] ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы ввели некорректный id автомобиля." );
		
	if( float( params[1] ) < 1.0 || float( params[1] ) > VehicleInfo[GetVehicleModel( params[0] ) - 400][v_fuel] )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете установить такой объем." );
		
	Vehicle[params[0]][vehicle_fuel] = params[1];
	return 1;
}

CMD:frac( playerid )
{
	if( !GetAccessCommand( playerid, "frac" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	clean:<g_string>;
	
	new
		count;

	for( new i; i < MAX_FRACTIONS; i++ )
	{
		if( Fraction[i][f_name][0] != EOS )
		{
			format:g_small_string( ""cBLUE"%d. "cWHITE"%s\n", Fraction[i][f_id], Fraction[i][f_name] );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			
			count++;
		}
	}
		
	showPlayerDialog( playerid, d_admin + 9, DIALOG_STYLE_LIST, "Список организаций", g_string, "Выбрать", "Закрыть" );

	return 1;
}

CMD:cfrac( playerid )
{
	if( !GetAccessCommand( playerid, "cfrac" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	clean:<g_string>;
	
	strcat( g_string, ""gbDialog"Добавить организацию" );
	
	new
		count;
		
	for( new i; i < MAX_CRIMINAL; i++ )
	{
		if( CrimeFraction[i][c_id] )
		{
			format:g_small_string( "\n"cBLUE"%d. #%d "cWHITE"%s", count + 1, CrimeFraction[i][c_id], CrimeFraction[i][c_name] );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			
			count++;
		}
	}
		
	showPlayerDialog( playerid, d_admin + 20, DIALOG_STYLE_LIST, "Криминальные организации", g_string, "Выбрать", "Закрыть" );
		
	return 1;
}

CMD:setmoney( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "setmoney" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "ud", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /setmoney [ id/имя игрока ] [ сумма ]" );
	
	if( !IsLogged( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );

	SetPlayerCash( params[0], "=", params[1] );
	
	pformat:( ""gbSuccess"Администратор %s[%d] установил Вам - "cBLUE"$%d"cWHITE".",
		Player[ playerid ][uName],
		playerid,
		params[1]
	);
	psend:( params[0], C_WHITE );
	
	if( params[0] == playerid )
	{
		format:g_small_string( "%s установил себе количество денег - $%d.",
			Player[playerid][uName],
			params[1]
		);
	}
	else
	{
		format:g_small_string( "%s установил %s количество денег - $%d.",
			Player[playerid][uName],
			Player[ params[0] ][uName],
			params[1]
		);
	}
	
	SendAdmin:( C_GRAY, g_small_string );
	
	return 1;
}

CMD:makefire( playerid )
{
	if( !GetAccessCommand( playerid, "makefire" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );

	if( FIRE_AMOUNT )
		return SendClient:( playerid, C_WHITE, !""gbError"Уже есть активный пожар." );

	showPlayerDialog( playerid, d_fire, DIALOG_STYLE_MSGBOX, " ", "\
		"cWHITE"Вы действительно желаете устроить пожар в этом месте?",
		"Да", "Нет" );

	return 1;
}

CMD:delfire( playerid )
{
	if( !GetAccessCommand( playerid, "delfire" ) && Player[playerid][uMember] != FRACTION_FIRE )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( Player[playerid][uMember] == FRACTION_FIRE )
	{
		if( !Player[playerid][uRank] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
		new
			fid = Player[playerid][uMember] - 1,
			rank = getRankId( playerid, fid );
			
		if( !FRank[fid][rank][r_add][1] )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	}
		
	if( !FIRE_AMOUNT )
		return SendClient:( playerid, C_WHITE, !""gbError"Нет активного пожара." );
	
	KillTimer( FIRE_TIMER );
	if( IsValidDynamicArea( FIRE_ZONE ) ) DestroyDynamicArea( FIRE_ZONE );
	
	for( new i; i < MAX_IGNITION; i++ )
	{
		for( new j; j < 2; j++ )
		{
			if( IsValidDynamicObject( Fire[i][f_object][j] ) )
			{
				DestroyDynamicObject( Fire[i][f_object][j] );
				Fire[i][f_object][j] = 0;
			}
		}
		
		if( IsValidDynamicArea( Fire[i][f_zone] ) ) DestroyDynamicArea( Fire[i][f_zone] );
		
		Fire[i][f_zone] =
		Fire[i][f_extinction] = 0;
		
		Fire[i][f_status] = false;
		
		Fire[i][f_pos][0] = 
		Fire[i][f_pos][1] = 
		Fire[i][f_pos][2] = 0.0;
		
	}
	
	FIRE_ZONE =
	FIRE_TIMER = 
	FIRE_AMOUNT = 0;
	
	DeleteSVar( "Fire:X" );
	DeleteSVar( "Fire:Y" );
	DeleteSVar( "Fire:Z" );
			
	DeleteSVar( "Fire:World" );
	DeleteSVar( "Fire:Interior" );
	
	SendClient:( playerid, C_WHITE, !""gbDefault"Пожар полностью удален." );
	
	return 1;
}

CMD:leave( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "leave" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /leave [ id игрока ]" );
		
	if( !IsLogged(params[0]) )
	    return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( Player[ params[0] ][uMember] )
	{
		if( PlayerLeaderFraction( params[0], Player[ params[0] ][uMember] - 1 ) )
			return SendClient:( playerid, C_WHITE, !""gbError"Чтобы уволить лидера организации, воспользуйтесь /unleader." );
			
		new
			fid = Player[ params[0] ][uMember] - 1;
			
		for( new i; i < MAX_MEMBERS; i++ )
		{
			if( FMember[fid][i][m_id] == Player[ params[0] ][uID] )
			{
				FMember[fid][i][m_id] = 
				FMember[fid][i][m_lasttime] = 
				FMember[fid][i][m_rank] = 0;
			
				FMember[fid][i][m_name][0] = EOS;
			
				break;
			}
		}
				
		mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uMember` = 0, `uRank` = 0 WHERE `uID` = %d", Player[ params[0] ][uID] );
		mysql_tquery( mysql, g_string );
				
		Fraction[fid][f_members]--;
				
		Player[ params[0] ][uMember] = 
		Player[ params[0] ][uRank] = 0;
				
		format:g_string( ""ADMIN_PREFIX" %s[%d] уволил из %s игрока %s[%d]", Player[playerid][uName], playerid, Fraction[fid][f_name], Player[ params[0] ][uName], params[0] );
		SendAdminMessage( C_DARKGRAY, g_string );	
				
		pformat:( ""gbDialog"Вы уволены из "cBLUE"%s"cGRAY" администратором "cBLUE"%s[%d]"cGRAY".", Fraction[fid][f_name], Player[playerid][uName], playerid );
		psend:( params[0], C_GRAY );
	}
	else if( Player[playerid][uCrimeM] )
	{
		new
			crime = getIndexCrimeFraction( Player[ params[0] ][uCrimeM] );
	
		if( PlayerLeaderCrime( params[0], crime ) )
			return SendClient:( playerid, C_WHITE, !""gbError"Чтобы уволить лидера группировки, воспользуйтесь /unсleader." );
			
		for( new i; i < MAX_MEMBERS; i++ )
		{
			if( CMember[crime][i][m_id] == Player[ params[0] ][uID] )
			{
				CMember[crime][i][m_id] = 
				CMember[crime][i][m_lasttime] = 
				CMember[crime][i][m_rank] = 0;
			
				CMember[crime][i][m_name][0] = EOS;
			
				break;
			}
		}
				
		mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeM` = 0, `uCrimeRank` = 0 WHERE `uID` = %d", Player[ params[0] ][uID] );
		mysql_tquery( mysql, g_string );
				
		CrimeFraction[crime][c_members]--;
				
		Player[ params[0] ][uCrimeM] = 
		Player[ params[0] ][uCrimeRank] = 0;
				
		format:g_string( ""ADMIN_PREFIX" %s[%d] уволил из %s игрока %s[%d]", Player[playerid][uName], playerid, CrimeFraction[crime][c_name], Player[ params[0] ][uName], params[0] );
		SendAdminMessage( C_DARKGRAY, g_string );	
				
		pformat:( ""gbDialog"Вы уволены из "cBLUE"%s"cGRAY" администратором "cBLUE"%s[%d]"cGRAY".", CrimeFraction[crime][c_name], Player[playerid][uName], playerid );
		psend:( params[0], C_GRAY );
	}
	else
	{
		return SendClient:( playerid, C_WHITE, !""gbError"Игрок не состоит в организации." );
	}
		
	return 1;
}

CMD:delthorn( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "delthorn" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /delthorn [ id ленты ]" );
		
	if( !Thorn[ params[0] ][t_status] )
		return SendClient:( playerid, C_WHITE, !""gbError"У этого игрока не установлена лента с шипами." );
		
	if( IsValidDynamicObject( Thorn[ params[0] ][t_object] ) )
		DestroyDynamicObject( Thorn[ params[0] ][t_object] );
			
	if( IsValidDynamic3DTextLabel( Thorn[ params[0] ][t_object_text] ) )
		DestroyDynamic3DTextLabel( Thorn[ params[0] ][t_object_text] );
			
	Thorn[ params[0] ][t_status] = false;
		
	Thorn[ params[0] ][t_pos][0] = 
	Thorn[ params[0] ][t_pos][1] = 
	Thorn[ params[0] ][t_pos][2] = 0.0;
	
	pformat:( ""gbDefault"Вы удалили ленту с шипами - "cBLUE"%d"cWHITE".", params[0] );
	psend:( playerid, C_WHITE );
	
	pformat:( ""gbDefault"Ваша лента с шипами удалена администратором "cBLUE"%s"cWHITE".", Player[playerid][uName] );
	psend:( params[0], C_WHITE );
	
	return 1;
}

CMD:savepoint( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "savepoint" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /savepoint [ id точки/0-создать ][ тип: 0-актер/1-транспорт ]" );
		
	if( params[0] < 0 || params[1] != 1 && params[1] != 0 )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /savepoint [ id точки/0-создать ][ тип: 0-актер/1-транспорт ]" );
		
	if( !params[0] )
	{
		for( new i; i < MAX_POINTS; i++ )
		{
			if( !GunDealer[i][g_id] )
			{
				switch( params[1] )
				{
					case 0:
					{
						if( IsPlayerInAnyVehicle( playerid ) )
							return SendClient:( playerid, C_WHITE, !""gbError"Для сохранения позиции актера выйдите из транспорта." );
					
						GetPlayerPos( playerid, GunDealer[i][g_actor_pos][0], GunDealer[i][g_actor_pos][1], GunDealer[i][g_actor_pos][2] );
						GetPlayerFacingAngle( playerid, GunDealer[i][g_actor_pos][3] );
						
						GunDealer[i][g_actor] = GetPlayerSkin( playerid );
					}
					
					case 1: return SendClient:( playerid, C_WHITE, !""gbError"Для создания точки используйте тип актера." );
				}
				
				mysql_format:g_small_string( "INSERT INTO `"DB_CRIME_GUNDEALER"` \
					( `g_actor`, `g_actor_pos` ) \
					VALUES \
					( '%d', '%f|%f|%f|%f' )",
					GunDealer[i][g_actor],
					GunDealer[i][g_actor_pos][0],
					GunDealer[i][g_actor_pos][1],
					GunDealer[i][g_actor_pos][2],
					GunDealer[i][g_actor_pos][3]
				);
				
				mysql_tquery( mysql, g_small_string, "insertGunDealer", "dd", playerid, i );
			
				return 1;
			}
		}
		
		SendClient:( playerid, C_WHITE, !""gbError"Количественный лимит точек гандилеров превышен." );
	}
	else
	{
		for( new i; i < MAX_POINTS; i++ )
		{
			if( GunDealer[i][g_id] == params[0] )
			{
				if( GunDealer[i][g_fracid] )
					return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете изменить активную точку." );
			
				switch( params[1] )
				{
					case 0:
					{
						if( IsPlayerInAnyVehicle( playerid ) )
							return SendClient:( playerid, C_WHITE, !""gbError"Для сохранения позиции актера выйдите из транспорта." );
					
						GetPlayerPos( playerid, GunDealer[i][g_actor_pos][0], GunDealer[i][g_actor_pos][1], GunDealer[i][g_actor_pos][2] );
						GetPlayerFacingAngle( playerid, GunDealer[i][g_actor_pos][3] );
						
						GunDealer[i][g_actor] = GetPlayerSkin( playerid );
					}
					
					case 1:
					{
						if( !IsPlayerInAnyVehicle( playerid ) )
							return SendClient:( playerid, C_WHITE, !""gbError"Для сохранения позиции Вы должны находится в транспорте." );
					
						new
							vid = GetPlayerVehicleID( playerid );
							
						GunDealer[i][g_car] = GetVehicleModel( vid );
						GetVehiclePos( vid, GunDealer[i][g_car_pos][0], GunDealer[i][g_car_pos][1], GunDealer[i][g_car_pos][2] );
						GetVehicleZAngle( vid, GunDealer[i][g_car_pos][3] );
					}
				}
				
				mysql_format:g_small_string( "UPDATE `"DB_CRIME_GUNDEALER"` SET \
					`g_actor` = %d, \
					`g_actor_pos` = '%f|%f|%f|%f', \
					`g_car` = %d, \
					`g_car_pos` = '%f|%f|%f|%f' WHERE \
					`g_id` = %d LIMIT 1",
					GunDealer[i][g_actor],
					GunDealer[i][g_actor_pos][0],
					GunDealer[i][g_actor_pos][1],
					GunDealer[i][g_actor_pos][2],
					GunDealer[i][g_actor_pos][3],
					GunDealer[i][g_car],
					GunDealer[i][g_car_pos][0],
					GunDealer[i][g_car_pos][1],
					GunDealer[i][g_car_pos][2],
					GunDealer[i][g_car_pos][3],
					GunDealer[i][g_id] );
				mysql_tquery( mysql, g_small_string );
				
				format:g_small_string( ""ADMIN_PREFIX" %s[%d] изменил точку гандилера ID %d: скин %d, модель %d",
					Player[playerid][uName],
					playerid,
					GunDealer[i][g_id], GunDealer[i][g_actor], GunDealer[i][g_car] );
					
				SendAdmin:( C_DARKGRAY, g_small_string );
				
				return 1;
			}	
		}
		
		SendClient:( playerid, C_WHITE, !""gbError"Точки с таким ID не найдено." );
	}
	
	return 1;
}

CMD:showpoint( playerid )
{
	if( !GetAccessCommand( playerid, "showpoint" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( COUNT_GUNDEALERS == 0x0 )
		return SendClient:( playerid, C_WHITE, !""gbError"Нет созданных точек гандилеров." );
		
	clean:<g_big_string>;
	
	strcat( g_big_string, ""cWHITE"Район\t"cWHITE"Параметры" );
	
	for( new i; i < COUNT_GUNDEALERS; i++ )
	{
		GetPos2DZone( GunDealer[i][g_actor_pos][0], GunDealer[i][g_actor_pos][1], GunDealer[i][g_zone], 28 );
	
		format:g_small_string( "\n"cBLUE"%i. "cWHITE"%s\tСкин %d Модель %d", i + 1, 
			GunDealer[i][g_zone], GunDealer[i][g_actor], GunDealer[i][g_car] );
		strcat( g_big_string, g_small_string );
	}
	
	showPlayerDialog( playerid, d_admin + 30, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "Действия", "Закрыть" );
		
	return 1;
}

CMD:setint( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "setint" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /setint [ id игрока ][ интерьер ]" );
		
	if( !IsLogged( params[0] ) || params[0] < 0 || params[0] > MAX_PLAYERS )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( params[1] < 0 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Неправильный идентификатор интерьера." );
	
	SetPlayerInterior( params[0], params[1] );
	
	return 1;
}

CMD:setworld( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "setworld" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /setworld [ id игрока ][ виртуальный мир ]" );
	
	if( !IsLogged( params[0] ) || params[0] < 0 || params[0] > MAX_PLAYERS )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( params[1] < 0 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Неправильный идентификатор виртуального мира." );
	
	SetPlayerVirtualWorld( params[0], params[1] );
	
	return 1;
}

CMD:stats( playerid, params[] ) 
{
	if( isnull( params ) )
	{
		ShowStats( playerid, playerid );
	}
	else
	{
		if( !GetAccessCommand( playerid, "stats" ) )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
		if( sscanf( params, "d", params[0] ) ) 
			return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /stats [ id игрока ]" );
			
		if( !IsLogged( params[0] ) || params[0] == playerid )
			return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
		ShowStats( playerid, params[0] );
	}
	
	return 1;
}

CMD:createadmin( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "createadmin" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /createadmin [ id игрока ]" );
		
	if( !IsLogged( params[0] ) || params[0] == playerid )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );

	return 1;
}

CMD:createsupport( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "createsupport" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /createsupport [ id игрока ]" );
		
	if( !IsLogged( params[0] ) || params[0] == playerid )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );

	return 1;
}