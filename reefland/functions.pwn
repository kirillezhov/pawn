UpdatePlayerString( playerid, field[], const value[] )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_USERS"` SET `%s` = '%e' WHERE `uID` = %d",
		field,
		value,
		Player[playerid][uID]
	);
	
	mysql_tquery( mysql, g_string );
}

UpdatePlayer( playerid, field[], const _: value )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_USERS"` SET `%s` = %d WHERE `uID` = %d",
		field,
		value,
		Player[playerid][uID]
	);
	
	mysql_tquery( mysql, g_string );
}

stock UpdatePlayerFloat( playerid, field[], const Float: value )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_USERS"` SET `%s` = %f WHERE `uID` = %d",
		field,
		value,
		Player[playerid][uID]
	);
	
	mysql_tquery( mysql, g_string );
}

UpdateAdminString( playerid, field[], const value[] )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_ADMINS"` SET `%s` = '%e' WHERE `aID` = %d",
		field,
		value,
		Admin[playerid][aID]
	);
	
	return mysql_tquery( mysql, g_string, "", "" );
}

UpdateAdmin( playerid, field[], const _: value )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_ADMINS"` SET `%s` = %d WHERE `aID` = %d",
		field,
		value,
		Admin[playerid][aID]
	);
	
	return mysql_tquery( mysql, g_string, "", "" );
}

stock UpdateAdminFloat( playerid, field[], const Float: value )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_ADMINS"` SET `%s` = %f WHERE `aID` = %d",
		field,
		value,
		Admin[playerid][aID]
	);
	
	return mysql_tquery( mysql, g_string, "", "" );
}

/*UpdateVehicleString( vehicleid, field[], const value[] )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_VEHICLES"` SET `%s` = '%e' WHERE `vehicle_id` = %d",
		field,
		value,
		vehicleid
	);
	
	return mysql_tquery( mysql, g_string, "", "" );
}*/

stock UpdateVehicle( vehicleid, field[], const _: value )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_VEHICLES"` SET `%s` = %d WHERE `vehicle_id` = %d",
		field,
		value,
		Vehicle[vehicleid][vehicle_id]
	);
	
	return mysql_tquery( mysql, g_string );
}

stock UpdateVehicleFloat( vehicleid, field[], const Float: value )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_VEHICLES"` SET `%s` = %f WHERE `vehicle_id` = %d",
		field,
		value,
		Vehicle[vehicleid][vehicle_id]
	);
	
	return mysql_tquery( mysql, g_string );
}

function OnPlayerDelayKick( playerid ) 
{
	DeletePVar( playerid, "Player:Kicked" );
	return Kick( playerid );
}

stock gbWarn( playerid, const reason[], adminid )
{
	new
		year,
		month,
		day,
		second,
		minute,
		hour;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	Player[playerid][uWarn] += 1;
	if( Player[playerid][uWarn] > 2 )
	{
		UpdatePlayer( playerid, "uWarn", 0 );
		
		gbBan( playerid, reason, _, adminid );
	}
	else
	{
		UpdatePlayer( playerid, "uWarn", Player[playerid][uWarn] );
	
		clean_array();
		strcat( g_big_string, ""gbError"Вы получили предупреждение на сервере.\n\n"cWHITE"");
		format:g_small_string( "- Администратор: "cBLUE"%s"cWHITE"\n", GetAccountName( adminid )), strcat( g_big_string, g_small_string);
		format:g_small_string( "- Имя: "cBLUE"%s"cWHITE"\n", GetAccountName( playerid )), strcat( g_big_string, g_small_string);
		format:g_small_string( "- Дата: "cBLUE"%02d/%02d/%04d"cWHITE"\n", day, month, year), strcat( g_big_string, g_small_string);
		format:g_small_string( "- Время: "cBLUE"%02d:%02d:%02d"cWHITE"\n", hour, minute, second), strcat( g_big_string, g_small_string);
		format:g_small_string( "- Причина:"cBLUE"%s"cWHITE"\n\n", reason), strcat( g_big_string, g_small_string);
		strcat( g_big_string, "Если Вы не согласны, то сделайте скриншот ("cBLUE"F8"cWHITE") и подайте апелляцию.");
		showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "");
	}
	
	gbKick( playerid );
	return 1;
}

stock gbBan( playerid, const reason[], lasttime = INFINITY_DATE, adminid = INVALID_PLAYER_ID, bool:hide = false, code = -1 ) 
{
	clean_array();
	
	if( !hide )
	{
	    new
	        year,
	        month,
	        day,
	        second,
	        minute,
	        hour;

		getdate(year, month, day);
		gettime(hour, minute, second);
		
		if( code == -1 )
		{
			strcat( g_big_string, ""gbError"Вы были заблокированы на сервере.\n\n"cWHITE"");
		}
		else
		{
			strcat( g_big_string, ""gbError"Вы были заблокированы на сервере античитом "cRED"R-AC"cWHITE".\nВаш аккаунт не подлежит разблокированию.\n\n"cWHITE"");
		}
		
		if( adminid != INVALID_PLAYER_ID ) format:g_small_string( "- Администратор: "cBLUE"%s"cWHITE"\n", GetAccountName( adminid )), strcat( g_big_string, g_small_string);
		format:g_small_string( "- Имя: "cBLUE"%s"cWHITE"\n", GetAccountName( playerid )), strcat( g_big_string, g_small_string);
		format:g_small_string( "- Дата: "cBLUE"%02d/%02d/%04d"cWHITE"\n", day, month, year), strcat( g_big_string, g_small_string);
		format:g_small_string( "- Время: "cBLUE"%02d:%02d:%02d"cWHITE"\n", hour, minute, second), strcat( g_big_string, g_small_string);
		format:g_small_string( "- Причина:"cBLUE"%s"cWHITE"\n\n", reason), strcat( g_big_string, g_small_string );
		
		if( code == -1 )
		{
			strcat( g_big_string, "Если Вы не согласны, то сделайте скриншот ("cBLUE"F8"cWHITE") и подайте апелляцию.");
		}
		
		showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "");
	}
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "\
		INSERT INTO "DB_BANS"\
			(bAdminName, bAdminID, bUserName, bUserID, bDate, bLastDate, bReason, bAdminIP, bUserIP, bHide)\
		VALUES\
		    ('%s', %d, '%s', %d, %d, %d, '%e', '%s', '%s', %d)",
		Player[adminid][uName],
		Admin[adminid][aID],
		Player[playerid][uName],
		Player[playerid][uID],
		gettime(),
		lasttime,
		reason,
		Player[adminid][tIP],
		Player[playerid][tIP],
		hide
	);

	mysql_tquery( mysql, g_string );

	gbKick( playerid );
	
	return 1;
}

stock gbMessageKick( playerid, const reason[], code = -1, adminid = INVALID_PLAYER_ID, bool:show = true ) 
{
    new
        year,
        month,
        day,
        second,
        minute,
        hour;
        
	if( show && adminid == INVALID_PLAYER_ID ) 
	{
	    if (code == -1) 
		{
			format:g_small_string( ""ADMIN_PREFIX" %s[%d] отсоединён от сервера. (%s)",
			    Player[playerid][uName],
			    playerid,
			    reason
			);
		} 
		else 
		{
			format:g_small_string( ""ADMIN_PREFIX" %s[%d] отсоединён от сервера. (%s | #%d)",
			    Player[playerid][uName],
			    playerid,
			    reason,
			    code
			);
		}
		
		SendAdminMessage( C_DARKGRAY, g_small_string );
	}
	
	getdate(year, month, day);
	gettime(hour, minute, second);
	
	clean:<g_big_string>;

	if( code == -1 )
	{
		strcat( g_big_string, ""gbError"Вы были отключены от сервера.\n\n"cWHITE"");
	}
	else if( code == -2 )
	{
		strcat( g_big_string, ""gbError"Вашему игровому персонажу выдали "cBLUE"Character Kill"cWHITE".\n\n"cWHITE"");
	}
	else
	{
		strcat( g_big_string, ""gbError"Вы были отключены от сервера античитом "cRED"R-AC"cWHITE".\n\n"cWHITE"");
	}
	
	if( adminid != INVALID_PLAYER_ID )
	{
		format:g_small_string( "- Администратор: "cBLUE"%s"cWHITE"\n", GetAccountName( adminid )), strcat( g_big_string, g_small_string);
	}
	
	format:g_small_string( "- Имя: "cBLUE"%s"cWHITE"\n", GetAccountName( playerid )), strcat( g_big_string, g_small_string);
	format:g_small_string( "- Дата: "cBLUE"%02d/%02d/%04d"cWHITE"\n", day, month, year), strcat( g_big_string, g_small_string);
	format:g_small_string( "- Время: "cBLUE"%02d:%02d:%02d"cWHITE"\n", hour, minute, second), strcat( g_big_string, g_small_string);
	if( code == -1 )
	{
		format:g_small_string( "- Причина: "cBLUE"%s"cWHITE"", reason ), strcat( g_big_string, g_small_string );
	}
	else if( code != -2 )
	{
	    format:g_small_string( "- Причина: Подозрение в читерстве. Код "cBLUE"#%d"cWHITE"\n\n", code), strcat( g_big_string, g_small_string );
		format:g_small_string( "Если Вы кикнуты ошибочно, сообщите об этом на форум "cBLUE"reeflandrp.ru/forum"cWHITE"\n\
			в разделе "cBLUE"Ошибки и недоработки - Античит"cWHITE", обязательно приложив скриншот." ), strcat( g_big_string, g_small_string );
	}
	
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
	gbKick( playerid );

	return 1;
}

function Float: GetDistanceBetweenPlayers( playerid_one, playerid_two ) 
{
	new 
		Float: x1,
		Float: y1,
		Float: z1,
		Float: x2,
		Float: y2,
		Float: z2;
		
	GetPlayerPos( playerid_one, x1, y1, z1 );
	GetPlayerPos( playerid_two, x2, y2, z2 );
	
	return floatsqroot( 
		 floatpower( floatabs( floatsub( x2,x1 ) ), 2) 
		 + floatpower( floatabs( floatsub( y2, y1 ) ), 2 ) 
		 + floatpower( floatabs( floatsub( z2,z1 ) ), 2 ) 
		 );
}

stock PlayerPlaySoundEx( playerid, sound ) 
{
	static 
		Float:x, 
		Float:y, 
		Float:z;
		
	GetPlayerPos( playerid, x, y, z );
	
	foreach (new i : Player) 
	{
		if( !IsLogged(i) ) continue;
		if( IsPlayerInRangeOfPoint( i, 30.0, x, y, z ) ) PlayerPlaySound( i, sound, x, y, z );
	}
	
	return 1;
}

CheckNormalPassword( pass[] ) 
{
	for(new i = 0; i < strlen(pass); i ++) 
	{
	    if(!((pass[i] >= 'a' && pass[i] <= 'z') || (pass[i] >= 'A' && pass[i] <= 'Z') || (pass[i] >= '0' && pass[i] <= '9'))) 
	        return 0;
	}
	return 1;
}

CheckNormalName( playerid )
{
	new 
		name[ MAX_PLAYER_NAME ];
		
    GetPlayerName( playerid, name, MAX_PLAYER_NAME );

	if( strlen( name ) < 6 )
		return STATUS_ERROR;
	
    for( new i = 0; i < strlen( name ); i++ )
    {
		// недопустимые символы в нике
		if( !( ( name[i] >= 'a' && name[i] <= 'z' ) || ( name[i] >= 'A' && name[i] <= 'Z' ) || name[i] == '_' ) )
                return STATUS_ERROR;
	}
		
	new 
		d = strfind( name, "_" );
			
	// нет _ в нике
    if( d == INVALID_PARAM ) 
		return STATUS_ERROR; 
		
	// больше одного _ в нике
    if( strfind( name, "_", false, d + 1 ) != INVALID_PARAM ) 
		return STATUS_ERROR; 
		
	new 
		pname[10];
    strmid( pname, name, 0, d, sizeof pname );
        
	new 
		surname[10];
    strmid( surname, name, d + 1, strlen( name ), sizeof surname);
		
	// неверная длина имени
    if( strlen( pname ) < 3 || strlen( surname ) < 3 ) 
		return STATUS_ERROR;
        
	// первая буква имени не заглавная
	if( !( pname[0] >= 'A' && pname[0] <= 'Z' ) )
		return STATUS_ERROR;
			
	// первая буква фамилии не заглавная
    if( !( surname[0] >= 'A' && surname[0]<='Z' ) ) 
		return STATUS_ERROR; 
			
	// неверные буквы в имени
    for( new i = 1; i < strlen( pname ); i++ )
    {
        if( !( pname[i] >= 'a' && pname[i] <= 'z' ) ) 
			return STATUS_ERROR; 
    }
		
	// неверные буквы в фамилии
    for( new i = 1; i < strlen( surname ); i++ )
    {
        if( !( surname[i] >= 'a' && surname[i] <= 'z' ) )
			return STATUS_ERROR;
	}
		
    return STATUS_OK;
}

stock stopPlayer( playerid, time ) 
{ 
	stop_time[playerid] = time;
	togglePlayerControllable( playerid, false );
	return 1;
}

stock MeAction( playerid, text[], type ) {
	//clean_array();
	switch(type) {
	    case 0: 
		{
			format:g_big_string( "%s %s", Player[playerid][uName], text );
			SendLong:( playerid, 20.0, g_big_string, C_PURPLE, C_PURPLE, C_PURPLE, C_PURPLE, C_PURPLE );
        }
        case 1: {
            format:g_big_string("%s", text );
			SetPlayerChatBubble( playerid, g_big_string, C_PURPLE, 15.0, 5000 );
        }
	}
	return 1;
}

stock GetPlayerID( name[ MAX_PLAYER_NAME ] )
{
	foreach(new i : Player)
	{
		if( !strcmp( name, Player[i][uName], true ) ) 
			return i;
	}
	
	return INVALID_PLAYER_ID;
}

SendLongMessage( playerid, Float: radius, message[], color1, color2, color3, color4, color5, type = 0 )
{
	new 
		len = strlen( message ),
		i_len = len / MAX_CHARS_PER_LINE;
		
	if( len % MAX_CHARS_PER_LINE )
		i_len++;
	
	new
		line[MAX_CHARS_PER_LINE + 5],
		_:index;
		
	while( index < i_len )
	{
		strmid( 
			line, 
			message, 
			( index * MAX_CHARS_PER_LINE ), 
			( index * MAX_CHARS_PER_LINE ) + MAX_CHARS_PER_LINE 
		);
		
		if( i_len > 1 )
		{
			if( !index )
				format( line, sizeof line, "%s ...", line );
			else if( index > 0 && ( index + 1 ) < i_len )
				format( line, sizeof line, "... %s ...", line );
			else 
				format( line, sizeof line, "... %s", line );
		}	
		
		ProxDetector( radius, playerid, line, color1, color2, color3, color4, color5, type );
		
		index++;
	}
	
	return 1;
}

SendLongNoRadius( playerid, color, message[] )
{
	new 
		len = strlen( message ),
		i_len = len / MAX_CHARS_PER_LINE;
		
	if( len % MAX_CHARS_PER_LINE )
		i_len++;
	
	new
		line[MAX_CHARS_PER_LINE + 5],
		_:index;
		
	while( index < i_len )
	{
		strmid( 
			line, 
			message, 
			( index * MAX_CHARS_PER_LINE ), 
			( index * MAX_CHARS_PER_LINE ) + MAX_CHARS_PER_LINE 
		);
		
		if( i_len > 1 )
		{
			if( !index )
				format( line, sizeof line, "%s ...", line );
			else if( index > 0 && ( index + 1 ) < i_len )
				format( line, sizeof line, "... %s ...", line );
			else 
				format( line, sizeof line, "... %s", line );
		}	

		SendClient:( playerid, color, line );
		
		index++;
	}
	
	return 1;
}

SendAdminLongMessageToAll( color, message[], type = 1 )
{
	new 
		len = strlen( message ),
		i_len = len / MAX_CHARS_PER_LINE;
		
	if( len % MAX_CHARS_PER_LINE )
		i_len++;
	
	new
		line[MAX_CHARS_PER_LINE + 5],
		_:index;
		
	while( index < i_len )
	{
		strmid( 
			line, 
			message, 
			( index * MAX_CHARS_PER_LINE ), 
			( index * MAX_CHARS_PER_LINE ) + MAX_CHARS_PER_LINE 
		);
		
		if( i_len > 1 )
		{
			if( !index )
				format( line, sizeof line, "%s ...", line );
			else if( index > 0 && ( index + 1 ) < i_len )
				format( line, sizeof line, "... %s ...", line );
			else 
				format( line, sizeof line, "... %s", line );
		}	
		
		if( type == 1 )
		{
			SendAdminMessageToAll( color, line );
		}
		
		index++;
	}
	
	return 1;
}

stock SendRadioMessageForSubChanel( channel, subchannel, text[] )
{
    foreach(new i: Player)
	{
	    if( !IsLogged( i ) ) 
			continue;

	    if( Player[i][uRadioChannel] == channel && Player[i][uRadioSubChannel] == subchannel ) 
		{
			if( getItem( i, INV_SPECIAL, PARAM_RADIO ) )
			{
				PlayerPlaySound( i, 6400, 0, 0, 0 );
				SendClient:(i, C_LIGHTBLUE, text);
			}
		}
	}
}

stock SendRadioMessage( channel, text[] )
{
	foreach(new i: Player)
	{
	    if( !IsLogged( i ) ) 
			continue;

	    if( Player[i][uRadioChannel] == channel )
		{
			switch( Player[i][uJob] )
			{
				case JOB_DRIVETAXI:
				{
					if( job_duty{i} && 
						IsPlayerInAnyVehicle( i ) && 
						( GetPlayerVehicleID( i ) >= cars_taxi[0] || GetPlayerVehicleID( i ) <= cars_taxi[1] ) &&
						GetPlayerState( i ) == PLAYER_STATE_DRIVER
					)
					{
						PlayerPlaySound( i, 6400, 0, 0, 0 );
						SendClient:(i, C_LIGHTBLUE_TWO, text);	
					}
				}
				
				case JOB_PRODUCTS:
				{
					if( job_duty{i} && 
						IsPlayerInAnyVehicle( i ) && 
						( GetPlayerVehicleID( i ) >= cars_prod[0] || GetPlayerVehicleID( i ) <= cars_prod[1] ) &&
						GetPlayerState( i ) == PLAYER_STATE_DRIVER
					)
					{
						PlayerPlaySound( i, 6400, 0, 0, 0 );
						SendClient:(i, C_LIGHTBLUE_TWO, text);	
					}
				}
				
				case JOB_MECHANIC:
				{
					if( job_duty{i} && IsPlayerInAnyVehicle( i ) && 
						( GetPlayerVehicleID( i ) >= cars_mech[0] || GetPlayerVehicleID( i ) <= cars_mech[1] ) &&
						GetPlayerState( i ) == PLAYER_STATE_DRIVER )
					{
						PlayerPlaySound( i, 6400, 0, 0, 0 );
						SendClient:(i, C_LIGHTBLUE_TWO, text);	
					}
				}
				
				default:
				{
					if( getItem( i, INV_SPECIAL, PARAM_RADIO ) )
					{
						PlayerPlaySound( i, 6400, 0, 0, 0 );
						SendClient:(i, C_LIGHTBLUE_TWO, text);
					}
				}
			}	
		}			
	}
}

stock ProxDetector( Float: radi, playerid, string[], color1, color2, color3, color4, color5, type = 0, subtype = 0 )
{
	new 
		Float: x,
		Float: y,
		Float: z,
		Float: radius;
	
	GetPlayerPos( playerid, x, y, z );
	
	if( GetPlayerVirtualWorld( playerid ) != 0 || GetPlayerInterior( playerid ) != 0 )
		radi = radi / 2;
	
	foreach(new i : Player)
	{
		if( !IsPlayerStreamedIn( playerid, i ) || !IsLogged(i) )
			continue;
			
		if( type == 1 )
		{
			if( !Player[i][uOOC] )
				continue;
		}
		
		else if( type == 3 )
		{
			if( !Player[i][uSettings][10] )
				continue;
		}
		
		else if( type == 4 )
		{
			if( GetPlayerVehicleID( i ) != GetPlayerVehicleID( playerid ) )
				continue;
		}
		
		
		if( GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( i ) 
			|| GetPlayerInterior( playerid ) != GetPlayerInterior( i )
		  )
			continue;
			
		if( ( radius = GetPlayerDistanceFromPoint( i, x, y, z ) ) > radi )
			continue;

		if( radius < radi / 16 ) 
			SendClient:( i, color1, string );
        else if( radius < radi / 8 ) 
			SendClient:( i, color2, string );
        else if( radius < radi / 4 ) 
			SendClient:( i, color3, string );
        else if( radius < radi / 2 ) 
			SendClient:( i, color4, string );
        else if( radius < radi ) 
			SendClient:( i, color5, string );	
	}
	
	//Если не рация
	if( !subtype ) SendClient:( playerid, color1, string );
	
	return 1;
}

stock IsNumeric( const string[] )
{
	for( new i = 0, j = strlen( string ); i < j; i++ ) 
	{
		if( string[i] > '9' || string[i] < '0' || string[i] == '%' )
			return 0;
	}
		
	return 1;
}

stock SpeedPed( playerid ) 
{
    new 
		Float:x, 
		Float:y, 
		Float:z;
		
    GetPlayerVelocity(playerid, x, y, z);
    return floatround( floatsqroot( x * x+ y* y) * 100 );
}

stock strreplace( string[], find, replace ) 
{
	for( new i = 0; string[i]; i++ ) 
	{
		if( string[i] != find ) 
			continue;
			
		string[i] = replace;
	}
}

stock GetVehicleSpeed( vehicleid ) 
{
    new 
		Float: x, 
		Float: y, 
		Float: z;
		
    GetVehicleVelocity( vehicleid, x, y, z );
    return floatround( floatsqroot( x * x + y * y ) * 150 );
}

stock acGetVehicleSpeed( vehicleid ) 
{
    new 
		Float: x, 
		Float: y, 
		Float: z;
		
    GetVehicleVelocity( vehicleid, x, y, z );
    return floatround( floatsqroot( x * x + y * y + z * z ) * 100 );
}

stock SetVehicleSpeed( vehicleid, Float:speed ) 
{
    new 
		Float: x1, 
		Float: y1, 
		Float: z1, 
		Float: x2, 
		Float: y2, 
		Float: z2, 
		Float: a;
		
    GetVehicleVelocity( vehicleid, x1, y1, z1);
    GetVehiclePos( vehicleid, x2, y2, z2);
    GetVehicleZAngle( vehicleid, a); 
	
	a = 360 - a;
    x1 = ( floatsin( a, degrees ) * ( speed/150 ) + floatcos( a, degrees ) * 0 + x2 ) - x2;
    y1 = ( floatcos( a, degrees ) * ( speed/150 ) + floatsin( a, degrees ) * 0 + y2 ) - y2;
	
    SetVehicleVelocity( vehicleid, x1, y1, z1);
}

stock SendRolePlayAction( playerid, const text[], type = 0 )
{
	switch( type )
	{
		case 0 : 
		{
			format:g_big_string( "* %s %s", 
				Player[playerid][uRPName], 
				text 
			);
			
			SendLong:( playerid, 20.0, g_big_string, C_PURPLE, C_PURPLE, C_PURPLE, C_PURPLE, C_PURPLE );
		}
		
		case 1 :
		{
            format:g_big_string( "%s", text );
			SetPlayerChatBubble( playerid, g_big_string, C_PURPLE, 15.0, 5000 );
		}
		
		case 2 :
		{
			format:g_big_string( "* %s (( %s ))", 
				text, 
				Player[playerid][uName] 
			);
			
			SendLong:( playerid, 20.0, g_big_string, C_PURPLE, C_PURPLE, C_PURPLE, C_PURPLE, C_PURPLE );
		}
	}
}

stock IsMuted( playerid, type )
{
	if( type == 0 )
	{
		if( Player[playerid][uMute] > 0 )
			return 1;
	}
	else
	{
		if( Player[playerid][uBMute] > 0 )
			return 1;
	}
	
	return 0;
}

stock IsAfk( playerid )
{
	return GetPVarInt( playerid, "Player:Afk") > 3 ? true : false;
}

stock GetPlayerWeaponSlot( weaponid ) 
{
	switch( weaponid ) 
	{
		case 0, 1: return 0;
 		case 2 .. 9: return 1;
		case 22 .. 24: return 2;
		case 25 .. 27: return 3;
		case 28, 29, 32: return 4;
		case 30, 31 : return 5;
		case 33, 34 : return 6;
		case 35 .. 38 : return 7;
		case 16 .. 18, 39 : return 8;
		case 41 .. 43 : return 9;
		case 10 .. 15 : return 10;
		case 44 .. 46 : return 11;
		case 40 : return 12;
		default : return 0;
	}
	
	return -1;
}

stock GetPlayerSpeed( playerid )
{
	new 
		Float: x,
		Float: y,
		Float: z;
		
	GetPlayerVelocity( playerid, x, y, z );
	
	return floatround( floatsqroot(
			floatpower( floatabs( x ), 2.0 ) +
			floatpower( floatabs( y ), 2.0 ) +
			floatpower( floatabs( z ), 2.0 ) *
			213.3
		) );
}

stock RemovePlayerWeapon( playerid, select, weaponid )
{
	if( weaponid < 1 || weaponid > 46 )
		return 0;
	
	new
		save_weapon	[ MAX_WEAPON_SLOT ],
		save_ammo	[ MAX_WEAPON_SLOT ];
		
	for( new i; i < MAX_WEAPON_SLOT; i++ )
	{
		GetPlayerWeaponData( playerid, i, save_weapon[i], save_ammo[i] );
		
		if( save_weapon[i] == weaponid )
		{
			UseInv[playerid][select][inv_param_1] = save_ammo[i];
			SaveAmmoForUseWeaponSlot( playerid, select );
		}
	}
	
	ResetPlayerWeapons( playerid );
	
	if( Player[playerid][uDeath] ) return 1;
	
	//Выдаем оружие в активных слотах
	for( new i; i < MAX_WEAPON_SLOT; i++ )
	{
		if( save_weapon[i] == weaponid || !save_ammo[i] )
			continue;
		
		givePlayerWeapon( playerid, save_weapon[i], save_ammo[i] );
		
		break;
	}
	
	givePlayerWeapon( playerid, 0, 1 );
	
	return 1;
}

stock RandomArray( array_input[], const array_size )
{
    for( new i = 0; i < array_size; i++ )
	{
        array_input[i] = random(array_size);

        for( new j = 0; j < array_size; j++ ) 
		{
            if( i != j && array_input[i] == array_input[j] ) 
			{
                j = -1;
                array_input[i] = random(array_size);
            }
        }
    }
}

/*
nowUpdateInfo ( playerid , const type [ ] , db_table [ ] , db_name_field [ ] , field [ ] , {Float, _}:...) {
    static const STATIC_ARGS = 0x5 ;
	clean_array();
    new g_szName [ MAX_PLAYER_NAME ] ;
    GetPlayerName ( playerid , g_szName , sizeof ( g_szName ) ) ;
    mysql_real_escape_string ( g_szName , g_szName ) ;
   
   for ( new i , x = numargs ( ) - STATIC_ARGS ; i != x ; i++ ) 
	{
        switch ( type [ i ] ) {
            case 'i','d' : format ( g_string , sizeof g_string , "update `%s` set `%s`=%d where BINARY `%s`='%s' limit 1;" , db_table , field , getarg (i + STATIC_ARGS ) , db_name_field , g_szName );
            case 'f' : format ( g_string , sizeof g_string , "update `%s` set `%s`=%f where BINARY `%s`='%s' limit 1;" , db_table , field , Float:getarg ( i + STATIC_ARGS ) , db_name_field , g_szName );
            case 's' : {
                for ( new a ; getarg ( i + STATIC_ARGS , a ) != 0x0 ; a++) {
                    g_small_string [ a ] = getarg ( i+STATIC_ARGS , a ) ;
                }
                format ( g_string , sizeof g_string , "update `%s` set `%s`='%s' where BINARY `%s`='%s' limit 1;" , db_table , field , g_small_string , db_name_field , g_szName ) ;
            }
        }
    }
    return mysql_tquery ( mysql, g_string ) ;
}*/

stock GetPlayer2DZone(playerid, zone[], len) 
{
        new 
			Float:x, 
			Float:y, 
			Float:z;
			
        GetPlayerPos(playerid, x, y, z);
		
        for(new i = 0; i != sizeof(gSAZones); i++ ) 
		{
            if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4]) 
			{
                return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
            }
        }
        return 0;
}

stock GetPos2DZone( Float:x, Float:y, zone[], len )
{
	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock SpawnFreezeTime( playerid ) 
{
	togglePlayerControllable( playerid, false );
	SetPVarInt( playerid, "Player:FreezeTime", MAX_TIME_UNFREEZE_P );
}


stock GetCountAroundPlayer( playerid, Float:radius ) //Проверка на наличие других игроков в радиусе 
{
	new
		count = 0;
	
	foreach( Player, i )
	{
		if( playerid == i ) continue;
		
		if( GetDistanceBetweenPlayers( playerid, i ) < radius )
		{
			if( GetPlayerVirtualWorld( playerid ) == GetPlayerVirtualWorld( i ) )
			count++;
		}
	}
	
	return count;
}

stock GetWithoutUnderscore( string[], dest[] )
{
	for( new i; i < MAX_PLAYER_NAME + 2; i++ )
	{
		dest[i] = 0;
	}

	for( new i = 0; i < strlen( string ); i++ )
	{	
		switch( string[i] )
		{
			case '_' :
			{
				dest[i] = ' ';
			}
			
			default :
			{
				dest[i] = string[i];
			}
		}
	}
}

stock GetEditText( string[], dest[], length = 30 )
{
	dest[0] = EOS;
	
	for( new i, k = 1; i < strlen( string ) + 2; i++ )
	{
		if( i == k * length + k )
		{
			dest[i] = '\n';
			k++;
			
			continue;
		}
		
		dest[i] = string[i - (k - 1)];
	}
}

stock randomize( min, max ) // Рандом в диапазоне
{
	max++;
	
	new 
		a = random( max - min ) + min; 
	
	return a;
}  

stock GetVehiclePlayerID( vehicleid ) 
{
	foreach(new i : Player) 
		if( IsPlayerInVehicle( i, vehicleid ) ) 
			return i;
	
	return INVALID_PLAYER_ID;
}

stock getPlayerRank( playerid )
{
	new
		rank[ 32 ];
		
	switch( Player[playerid][uLevel] )
	{
		case 0..2: strcat( rank, "Начинающий", 32 );
		
		case 3..6: strcat( rank, "Освоившийся", 32 );
		
		case 7..10: strcat( rank, "Продвинутый", 32 );
		
		case 11..19: strcat( rank, "Знаток", 32 );
		
		case 20..29: strcat( rank, "Эксперт", 32 );
		
		default: strcat( rank, "Олдфаг", 32 );
	}
	
	return rank;
}

stock getLevelHours( playerid )
{
	new
		amount;

	if( !Player[playerid][uLevel] ) return 0;
		
	for( new i = 1; i < Player[playerid][uLevel] + 1; i++ )
	{
		amount += i * 6;
	}
	
	return amount;
}

stock getCountsOfDigits( number ) //Количество цифр в числе
{
	new
		count = ( !number ? 1 : 0 );
		
	while( number != 0 )
	{
		count++;
        number /= 10;
	}

	return count;
}

stock GetDistanceBetweenPoints( Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2 )
{
	new
		Float:distance = floatsqroot( floatpower( X2 - X1, 2 ) + floatpower( Y2 - Y1, 2 ) + floatpower( Z2 - Z1, 2 ) );
		
	return floatround( distance );
}