Admin_OnGameModeInit()
{
	mysql_tquery( mysql, "SELECT * FROM "DB_PERMISSIONS"", "LoadPermissions" );
	
	AdminSpectateMenu = CreateMenu( "Admin", 0, 5.0, 160.0, 50.0 );
	SetMenuColumnHeader( AdminSpectateMenu, 0, "Menu");
	AddMenuItem( AdminSpectateMenu, 0, " Next");
	AddMenuItem( AdminSpectateMenu, 0, " Back");
	AddMenuItem( AdminSpectateMenu, 0, " Update");
	AddMenuItem( AdminSpectateMenu, 0, " Exit");
	
	Admin_TextDraws();
	return 1;
}

Admin_OnPlayerConnect( playerid ) 
{
	// Admin 
	
	ClearAdminData( playerid );
	ClearSupportData( playerid );
	
	Admin_PlayerTextDraws( playerid );
	return 1;
}

Admin_OnPlayerDisconnect( playerid, reason ) 
{
	if( reason == 1 && GetAccessAdmin( playerid, 1 ) )
		OnAdminDisconnect( playerid );
		
	AddDisconnectLog( playerid, reason );
	
	Admin_TextDrawsHide( playerid );
	return 1;
}

Admin_OnPlayerDeath( playerid, killerid, reason )
{
	if( killerid != INVALID_PLAYER_ID && reason < 47 )
		AddKillLog( playerid, killerid, reason );
	
	foreach(new i: Player)
	{
		if( !IsLogged(i) ) continue;
		
		if( GetAccessAdmin( i, 1 ) )
			SendDeathMessageToPlayer( i, killerid, playerid, reason );
	}
	
	return 1;
}

Admin_OnPlayerClickMap( playerid, Float:fX, Float:fY, Float:fZ )
{
	if( GetAccessAdmin( playerid, 1 ) && !IsPlayerInAnyVehicle( playerid ) )
	{
		setPlayerPos( playerid, fX, fY, fZ + 0.5 );
		SetPlayerInterior( playerid, 0);
		SetPlayerVirtualWorld( playerid, 0);
		
		format:g_small_string( ""gbSuccess"Вы успешно телепортировались по координатам: "cBLUE"%0.2f, %0.2f, %0.2f"cWHITE".", fX, fY, fZ );
		SendClient:( playerid, C_WHITE, g_small_string );
	}

	return 1;
}

Admin_OnPlayerClickPlayer( playerid, clickedplayerid )
{
	if( GetAccessAdmin( playerid, 1 ) )
	{
		showPlayerDialog( playerid, d_admin + 8, DIALOG_STYLE_LIST, GetAccountName( clickedplayerid ), 
			""cBLUE"-"cWHITE" Наблюдать\n\
			 "cBLUE"-"cWHITE" Телепортироваться\n\
			 "cBLUE"-"cWHITE" Статистика\n\
			 "cBLUE"-"cWHITE" Подбросить\n\
			 ",
			"Далее", "Закрыть"
		);
		
		
		SetPVarInt( playerid, "Admin:ClickedPlayerid", clickedplayerid );
	}
	
	return 1;
}

ClearAdminData( playerid )
{
	Admin[playerid][aID] = 
	Admin[playerid][aUserID] =
	Admin[playerid][aLevel] =
	Admin[playerid][aStatus] =
	Admin[playerid][aActive] =
	Admin[playerid][aHacked] = 0x0;
	
	Admin[playerid][aName][0] =
	Admin[playerid][aPassword][0] =
	Admin[playerid][aStats][0] =
	Admin[playerid][aOnline][0] =
	Admin[playerid][aFirstIp][0] = EOS;

	SetPVarInt( playerid, "Admin:SpectateId", INVALID_PLAYER_ID );
    SetPVarInt( playerid, "Admin:Duty", 0 );
	SetPVarInt( playerid, "Admin:ClickedPlayerid", INVALID_PLAYER_ID );
}

ClearSupportData( playerid )
{
	Support[playerid][sID] = 
	Support[playerid][sStatus] = 
	Support[playerid][sActive] =
	Support[playerid][sUserID] = 0x0;
	
	Support[playerid][sName][0] = 
	Support[playerid][sStats][0] = EOS;
	
	SetPVarInt( playerid, "Support:Duty", 0 );
}

Admin_OnPlayerWeaponShot( playerid, hitid )
{
	if( hitid )
	{
		Player[playerid][tTrueShot]++;
	}
	else
	{
		Player[playerid][tFalseShot]++;
	}
		
	return 1;
}

stock AddPercentAdminHack( playerid, _: percent )
{
	Admin[playerid][aHacked] += percent;
	
	return 1;
}

stock DeletePercentAdminHack( playerid, _: percent )
{
	Admin[playerid][aHacked] -= percent;
	
	if( Admin[playerid][aHacked] < 0 )
		Admin[playerid][aHacked] = 0;
		
	return 1;
}

stock AdminIsHacked( playerid, const type = -1, params[] = "", params_2 = INVALID_PLAYER_ID )
{
	if( type != -1 )
	{
		switch( type )
		{	
			case TYPE_CMD :
			{
				new
					server_tick = GetTickCount();
					
				if( GetPVarInt( playerid, "Admin:UseCommandTick" ) > server_tick )
				{	
					if( params[0] != 0 )
					{
						clean_array();
						GetPVarString( playerid, "Admin:Reason", g_small_string, sizeof g_small_string );
						
						if( !strcmp( params, g_small_string, true ))
							AddPercentAdminHack( playerid, 20 );
						else
							AddPercentAdminHack( playerid, 10 );
							
						DeletePVar( playerid, "Admin:Reason" );
					}
					else
					{
						AddPercentAdminHack( playerid, 10 );
					}
				}
				else
				{
					if( params[0] != 0 )
						SetPVarString( playerid, "Admin:Reason", params );
						
					SetPVarInt( playerid, "Admin:UseCommandTick", server_tick + 30000 );
				}
				
			}
			
			case TYPE_ADMIN :
			{
				if( GetAccessAdmin( params_2, 1 ) )
				{
					if( GetAccessAdmin( playerid, 6 ))
						AddPercentAdminHack( playerid, 15 );
					else
						AddPercentAdminHack( playerid, 50 );
				}
			}
		}
	}
	
	if( Admin[playerid][aHacked] > 99 )
	{
		clean_array();
		
		if( GetPVarInt( playerid, "Admin:Duty") )
		{
			SetPVarInt( playerid, "Admin:Duty", false );
		}
		
		UpdateAdmin( playerid, "aActive", 0 );
		
		format:g_small_string(  ""ADMIN_PREFIX" Аккаунт администратора %s[%d] отключён. (Подозрение на взлом)",
			GetAccountName( playerid ),
			playerid
		);
		SendAdminMessage( C_RED, g_small_string );
		
		gbMessageKick( playerid, ""cRED"Ваш аккаунт администратора был отключён\nпо подозрению взлома. Обратитесь к ведущему администратору"cWHITE".", _, _, false );
	}
	
	return 1;
}

stock AdminSpectatePlayer( playerid, spectateid )
{
	if( !GetPVarInt( playerid, "Admin:Spectate" ) )
	{
		GetPlayerPos( playerid, Player[playerid][tPos][0], Player[playerid][tPos][1], Player[playerid][tPos][2] );
	
		SetPVarFloat( playerid, "Admin:PosX", Player[playerid][tPos][0] );
		SetPVarFloat( playerid, "Admin:PosY", Player[playerid][tPos][1] );
		SetPVarFloat( playerid, "Admin:PosZ", Player[playerid][tPos][2] );
		
		SetPVarInt( playerid, "Admin:World", GetPlayerVirtualWorld( playerid ) );
		SetPVarInt( playerid, "Admin:Int", GetPlayerInterior( playerid ) );
	}
	
	SetPVarInt( playerid, "Admin:SpectateId", spectateid );
	SetPVarInt( playerid, "Admin:Spectate", 1 );
	
	togglePlayerSpectating( playerid, true );
	
	ShowAdminSpectatePanel( playerid, true, spectateid );
	ShowMenuForPlayer( AdminSpectateMenu, playerid );
	
	SetPlayerInterior( playerid, GetPlayerInterior( spectateid ) );
	SetPlayerVirtualWorld( playerid, GetPlayerVirtualWorld( spectateid ) );
	
	if( !IsPlayerInAnyVehicle( spectateid ) )
		return PlayerSpectatePlayer( playerid, spectateid );
	else
		return PlayerSpectateVehicle( playerid, GetPlayerVehicleID( spectateid ) );
}

stock AdminUpdateSpectatePlayer( playerid, spectateid )
{
	ShowMenuForPlayer( AdminSpectateMenu, playerid );
	AdminUpdateSpectatePanel( playerid, spectateid );
	
	SetPlayerInterior( playerid, GetPlayerInterior( spectateid ) );
	SetPlayerVirtualWorld( playerid, GetPlayerVirtualWorld( spectateid ) );
	
	if( !IsPlayerInAnyVehicle( spectateid ))
		return PlayerSpectatePlayer( playerid, spectateid );
	else
		return PlayerSpectateVehicle( playerid, GetPlayerVehicleID( spectateid ));
}

stock AdminUnSpectate( playerid, bool: default_pos = true )
{
	ShowAdminSpectatePanel( playerid, false );
	togglePlayerSpectating( playerid, false );
	
	if( default_pos )
	{
		setPlayerPos( 
			playerid,
			GetPVarFloat( playerid, "Admin:PosX"), 
			GetPVarFloat( playerid, "Admin:PosY"), 
			GetPVarFloat( playerid, "Admin:PosZ")
		);
	}
	
	SetPlayerVirtualWorld( playerid, GetPVarInt( playerid, "Admin:World") );
	SetPlayerInterior( playerid, GetPVarInt( playerid, "Admin:Int") );
	
	setUseSkin( playerid, false );
	
	HideMenuForPlayer( AdminSpectateMenu, playerid );
	
	Player[playerid][tSpectate] = false;
	
	DeletePVar( playerid, "Admin:PosX");
	DeletePVar( playerid, "Admin:PosY");
	DeletePVar( playerid, "Admin:PosZ");
	DeletePVar( playerid, "Admin:World");
	DeletePVar( playerid, "Admin:Int");
	SetPVarInt( playerid, "Admin:SpectateId", INVALID_PLAYER_ID );
	DeletePVar( playerid, "Admin:Spectate" );

	return 1;
}

function ReloadSupportAccount( playerid, server_tick ) 
{
	new
	    rows,
	    fields;

	cache_get_data( rows, fields );

	if( !rows )
	    return 0; 
	    
 	Support[playerid][sID] = cache_get_field_content_int( 0, "sID", mysql );
	Support[playerid][sUserID] = cache_get_field_content_int( 0, "sUserID", mysql );
    Support[playerid][sStatus] = cache_get_field_content_int( 0, "sStatus", mysql );
    Support[playerid][sActive] = cache_get_field_content_int( 0, "sActive", mysql );
		
    cache_get_field_content( 0, "sName", Support[playerid][sName], mysql, MAX_PLAYER_NAME );
    cache_get_field_content( 0, "sStats", g_small_string, mysql );
    sscanf( g_small_string, "p<|>a<d>[2]", Support[playerid][sStats] );
    
	printf( "[Log]: Support account - %s[%d] has been successful reloaded.", Support[playerid][sName], playerid );
	
	if( Support[playerid][sID] != 0 )
	{
		SendClient:( playerid, C_WHITE, ""gbSuccess"Ваш аккаунт саппорта успешно загружен.");
		SendClient:( playerid, C_WHITE, ""gbSuccess"Для выхода на дежурство используйте - "cBLUE"/sduty"cWHITE".");
	}
	else
	{
		SendClient:( playerid, C_WHITE, ""gbError"Вы не являетесь саппортом.");
		SetPVarInt( playerid, "Support:DutyTime", server_tick + 60000 );
	}
	
	return 1;
}

function LoadSupportAccount( playerid ) 
{
	new
	    rows,
	    fields;

	cache_get_data( rows, fields );

	if( !rows )
	    return 0; 
	    
 	Support[playerid][sID] = cache_get_field_content_int( 0, "sID", mysql );
	Support[playerid][sUserID] = cache_get_field_content_int( 0, "sUserID", mysql );
    Support[playerid][sStatus] = cache_get_field_content_int( 0, "sStatus", mysql );
    Support[playerid][sActive] = cache_get_field_content_int( 0, "sActive", mysql );
		
    cache_get_field_content( 0, "sName", Support[playerid][sName], mysql, MAX_PLAYER_NAME );
    cache_get_field_content( 0, "sStats", g_small_string, mysql );
    sscanf( g_small_string, "p<|>a<d>[2]", Support[playerid][sStats] );
    
    printf( "[Load]: Support account - %s[%d] has been successful loaded.", Support[playerid][sName], playerid );

    if( Support[playerid][sActive] )
	{
		SendClient:( playerid, C_WHITE, ""gbSuccess"Вы вошли как саппорт. Для выхода на дежурство используйте - "cBLUE"/sduty"cWHITE"." );
	}
	return 1;
}

function ReloadAdminAccount( playerid, type, server_tick )
{
	clean:<g_small_string>;
	
	new
	    rows,
	    fields;
	    
	cache_get_data( rows, fields );
	
	if( !rows )
	    return 0; 

	Admin[playerid][aID] = cache_get_field_content_int( 0, "aID", mysql );
	Admin[playerid][aUserID] = cache_get_field_content_int( 0, "aUserID", mysql );
    Admin[playerid][aLevel] = cache_get_field_content_int( 0, "aLevel", mysql );
    Admin[playerid][aStatus] = cache_get_field_content_int( 0, "aStatus", mysql );
    Admin[playerid][aActive] = cache_get_field_content_int( 0, "aActive", mysql );
    
	clean:<g_small_string>;
	cache_get_field_content( 0, "aName", g_small_string, mysql, MAX_PLAYER_NAME );
	strmid( Admin[playerid][aName], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	
	clean:<g_small_string>;
	cache_get_field_content( 0, "aPassword", g_small_string, mysql, 65 );
	strmid( Admin[playerid][aPassword], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	
	clean:<g_small_string>;
    cache_get_field_content( 0, "aStats", g_small_string, mysql );
    sscanf( g_small_string, "p<|>a<d>[4]", Admin[playerid][aStats] );

    printf( "[Log]: Admin account - %s[%d] has been successful reloaded.", Admin[playerid][aName], playerid );
	
	if( type == 1 )
	{
		if( Admin[playerid][aLevel] != 0 && Admin[playerid][aID] != 0 )
		{
			SendClient:( playerid, C_WHITE, ""gbSuccess"Ваш аккаунт администратора успешно загружен.");
			SendClient:( playerid, C_WHITE, ""gbSuccess"Для продолжения регистрации введите ещё раз - "cBLUE"/aduty"cWHITE".");
		}
		else
		{
			SendClient:( playerid, C_WHITE, ""gbError"Вы не являетесь администратором.");
		}
	}
	else if( type == 2 )
	{
		if( GetPVarInt( playerid, "Admin:Level" ) != Admin[playerid][aLevel] )
		{
			format:g_small_string( ""gbSuccess"Обновление прав доступа.\n\n"gbDialogSuccess"Ваш уровень доступа изменён с %d уровня на %d.",
				GetPVarInt( playerid, "Admin:Level" ),
				Admin[playerid][aLevel]
			);
			showPlayerDialog( playerid, d_admin + 7, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Назад", "Закрыть" );
			
			format:g_small_string( ""ADMIN_PREFIX" Уровень доступа администратора %s[%d] изменён с %d на %d уровень.",
				GetAccountName( playerid ),
				playerid,
				GetPVarInt( playerid, "Admin:Level" ),
				Admin[playerid][aLevel]
			);
			
			SendAdmin:( C_ORANGE, g_small_string );
		
		}
		else
		{
			showPlayerDialog( playerid, d_admin + 7, DIALOG_STYLE_MSGBOX, " ", ""gbSuccess"Обновление прав доступа.\n\n"gbDialogError"Ваш уровень доступа не изменился.", "Назад", "Закрыть" );
		}
		
		SetPVarInt( playerid, "Admin:UpdateTime", server_tick + 60000 );
	}
	
	return 1;
}

function LoadAdminAccount( playerid ) 
{
	clean:<g_small_string>;
	
	new
	    rows,
	    fields;
	    
	cache_get_data( rows, fields );
	
	if( !rows )
	    return 0; 

	Admin[playerid][aID] = cache_get_field_content_int( 0, "aID", mysql );
	Admin[playerid][aUserID] = cache_get_field_content_int( 0, "aUserID", mysql );
    Admin[playerid][aLevel] = cache_get_field_content_int( 0, "aLevel", mysql );
    Admin[playerid][aStatus] = cache_get_field_content_int( 0, "aStatus", mysql );
    Admin[playerid][aActive] = cache_get_field_content_int( 0, "aActive", mysql );
    
	cache_get_field_content( 0, "aName", g_small_string, mysql, MAX_PLAYER_NAME );
	strmid( Admin[playerid][aName], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	
	cache_get_field_content( 0, "aPassword", g_small_string, mysql, 65 );
	strmid( Admin[playerid][aPassword], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	
    cache_get_field_content( 0, "aStats", g_small_string, mysql );
    sscanf( g_small_string, "p<|>a<d>[4]", Admin[playerid][aStats] );

    printf( "[Load]: Admin account - %s[%d] has been successful loaded.", Admin[playerid][aName], playerid );
	
	if( isnull( Admin[playerid][aPassword] ) )
	{
		SendClient:( playerid, C_WHITE, ""gbError"Вы вошли как незарегистрированный администратор. Для регистрации используйте - "cBLUE"/aduty"cWHITE"." );
	}
	else if( !isnull( Admin[playerid][aPassword] ) && Admin[playerid][aActive] )
	{
	
		format:g_small_string( ""gbSuccess"Вы вошли как администратор "cBLUE"%d"cWHITE" уровня. Для авторизации используйте - "cBLUE"/aduty"cWHITE".",
			Admin[playerid][aLevel]
		);
		
		SendClient:( playerid, C_WHITE, g_small_string );
	}
	
	return 1;
}

function LoadPermissions() 
{
	new
		rows,
		fields;
	cache_get_data( rows, fields, mysql );
	
	if( !rows )
		return print("[Load]: Permissions - Not loaded. Null rows in "DB_PERMISSIONS".");
		
	COUNT_PERMISSIONS = 0x0;
	
	for( new i; i < rows; i++ ) 
	{
		cache_get_field_content( i, "pName",  Permission[i][pName], mysql, 64 );
		cache_get_field_content( i, "pDescription", Permission[i][pDescription], mysql, 128 );
        Permission[i][pLevel] = cache_get_field_content_int( i, "pLevel", mysql );
		
        COUNT_PERMISSIONS++;
	}
	
	printf( "[Load]: Permissions - Loaded. All - %d", COUNT_PERMISSIONS );
	
	clean_array();
	return 1;
}

function OnRemoveAdmin( playerid, const adminid )
{
	new
		rows,
		fields;
	
	cache_get_data( rows, fields );
	
	if( !rows )
		return SendClientMessage( playerid, C_WHITE, ""gbError"Данный игрок не является администратором.");
	
	mysql_format( mysql, g_string, sizeof g_string, "DELETE FROM "DB_ADMINS" WHERE aID = %d", 
		Admin[adminid][aID]
	);
	
	mysql_tquery( mysql, g_string );
	
	format:g_small_string(  ""ADMIN_PREFIX" %s[%d] снял %s[%d] с должносности администратора.",
			GetAccountName( playerid ),
			playerid,
			GetAccountName( adminid ),
			adminid
	);
		
	SendAdminMessage( C_GRAY, g_small_string );
	
	format:g_small_string(  ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" снял Вас с должности администратора.",
			GetAccountName( playerid ),
			playerid
	);
		
	SendClientMessage( adminid, C_WHITE, g_small_string );
	
	SendClientMessage( playerid, C_WHITE, ""gbDefault"Ваша сессия администратора была очищена.");
	
	if( GetPVarInt( adminid, "Admin:Duty") )
	{
		SetPVarInt( adminid, "Admin:Duty", false );
	}
	
	ClearAdminData( playerid );
	
	gbMessageKick( adminid, ""cRED"Вы были сняты с должности администратора"cWHITE".", _, playerid, false );
	
	OnAdminLogout( playerid, "Сессия очищена сервером" );
	return 1;
}

function OnRemoveSupport( playerid, const supportid )
{
	new
		rows,
		fields;
	
	cache_get_data( rows, fields );
	
	if( !rows )
		return SendClientMessage( playerid, C_WHITE, ""gbError"Данный игрок не является саппортом.");
	
	mysql_format( mysql, g_string, sizeof g_string, "DELETE FROM "DB_SUPPORTS" WHERE sID = %d", 
		Support[supportid][sID]
	);
	
	mysql_tquery( mysql, g_string, "", "" );
	
	format:g_small_string(  ""SUPPORT_PREFIX" %s[%d] снял %s[%d] с должносности саппорта.",
			GetAccountName( playerid ),
			playerid,
			GetAccountName( supportid ),
			supportid
	);
		
	SendSupportMessage( C_GRAY, g_small_string );
	
	DeletePVar( supportid, "Support:Duty" );
	
	ClearSupportData( playerid );
	
	format:g_small_string(  ""gbDefault"Администратор "cBLUE"%s[%d]"cWHITE" снял Вас с должности саппорта.",
			GetAccountName( playerid ),
			playerid
	);
		
	SendClientMessage( supportid, C_WHITE, g_small_string );
	
	return 1;
}

stock AddKillLog( playerid, killerid, gun )
{	
	if( COUNT_KILL_LOG >= MAX_LOGS )
		COUNT_KILL_LOG = 0;
		
	KillLog[COUNT_KILL_LOG][killerID] = killerid;
	KillLog[COUNT_KILL_LOG][killedID] = playerid;
	KillLog[COUNT_KILL_LOG][killerGun] = gun;
	strmid( KillLog[COUNT_KILL_LOG][killerName], GetAccountName( killerid ), 0, strlen( GetAccountName( killerid ) ), MAX_PLAYER_NAME );
	strmid( KillLog[COUNT_KILL_LOG][killedName], GetAccountName( playerid ), 0, strlen( GetAccountName( playerid ) ), MAX_PLAYER_NAME );
	KillLog[COUNT_KILL_LOG][killedTime] = gettime();
	
	COUNT_KILL_LOG++;
	
	return 1;
}

stock AddDisconnectLog( playerid, reason )
{
	static const
		reason_text[3][] = 
		{
			"Вылетел",
			"Вышел",
			"Отсоединён"
		};
	
	if( COUNT_DISCONNECT_LOG >= MAX_LOGS )
		COUNT_DISCONNECT_LOG = 0;
		
	strmid( DisconnectLog[COUNT_DISCONNECT_LOG][disconnectName], GetAccountName( playerid ), 0, strlen( GetAccountName( playerid ) ), MAX_PLAYER_NAME );
	strmid( DisconnectLog[COUNT_DISCONNECT_LOG][disconnectReason], reason_text[reason], 0, strlen( reason_text[reason] ), 12 );
	DisconnectLog[COUNT_DISCONNECT_LOG][disconnectTime] = gettime();
	
	COUNT_DISCONNECT_LOG++;
	
	return 1;
}

stock SendAdminMessage( color, const message[], level = 1 ) 
{
	foreach(new playerid : Player)
		if ( GetAccessAdmin( playerid, level ) )
		    SendClientMessage( playerid, color, message );

	return 1;
}

stock SendAdminMessageToAll( color, const message[] ) 
{
	foreach(new playerid : Player)
	{
		if( IsLogged( playerid ) )
		{
			if( Player[playerid][uSettings][5] == 1 )
			{
				SendClientMessage( playerid, color, message );
			}
		}
	}

	return 1;
}

stock SendSupportMessage( color, const message[], bool: show_admin = true ) 
{
	foreach (new playerid : Player)
	{
		if( !show_admin )
		{
			if ( GetPVarInt( playerid, "Support:Duty" ) )
				SendClientMessage( playerid, color, message );
		}
		else
		{
			if ( GetPVarInt( playerid, "Support:Duty" ) || GetAccessAdmin( playerid, 1 ) )
				SendClientMessage( playerid, color, message );
		}
	}
	
	return 1;
}

stock GetAccessCommand( playerid, const command[] ) 
{
	for( new i; i != COUNT_PERMISSIONS; i++ ) 
	{
		if ( !strcmp( command, Permission[i][pName], true ) ) 
		{
		    if ( Admin[playerid][aLevel] >= Permission[i][pLevel] && GetPVarInt( playerid, "Admin:Duty" ) ) 
			{
		        return 1;
		    }
			
		    break;
		}
	}
	
	return 0;
}

stock GetAccessSupport( playerid, bool:duty = true ) {
	if( duty ) 
	{
    	if( Support[playerid][sID] != 0 && GetPVarInt( playerid, "Support:Duty" ) )
			return 1;
	} 
	else 
	{
		if( Support[playerid][sID] != 0 )
			return 1;
	}
	
	return 0;
}

stock GetAccessAdmin( playerid, level, bool:duty = true ) 
{
	if( duty ) 
	{
		if ( Admin[playerid][aLevel] >= level && GetPVarInt( playerid, "Admin:Duty" ) )
		    return 1;
	}
	else 
	{
        if ( Admin[playerid][aLevel] >= level )
		    return 1;
	}

	return 0;
}

stock ForbiddenAdminLogin( playerid, const reason[] )
{
	format:g_small_string(  ""ADMIN_PREFIX" %s[%d] не смог авторизоваться [IP: %s]. (%s)",
		Player[playerid][uName],
		playerid,
		Player[playerid][tIP],
		reason
	);
	SendAdminMessage( C_RED, g_small_string );
	
	SendClient:( playerid, C_WHITE, !""gbError"Вы не смогли авторизоваться." );
	
	return 1;
}

stock OnAdminRegister( playerid, password[] ) 
{
	clean_array();
	new
		hash[ 64 + 1 ];
	
	SHA256_PassHash( password, "934adse4kks", hash, sizeof hash );
	format( Admin[playerid][aPassword], 65, "%s", hash );
	
	UpdateAdminString( playerid, "aPassword", Admin[playerid][aPassword] );
	UpdateAdminString( playerid, "aFirstIp", Player[playerid][tIP] );
	
	format:g_small_string(  ""ADMIN_PREFIX" Аккаунт администратора %s[%d] - %d уровня зарегистрирован.",
				GetAccountName( playerid ),
				playerid,
				Admin[playerid][aLevel]
	);
			
	SendAdminMessage( C_GREEN, g_small_string );
	
	format:g_small_string(  ""gbDefault"Вы успешно зарегистрировались. Ваш пароль администрирования: "cBLUE"%s"cWHITE".",
		Admin[playerid][aPassword]
	);
	SendClientMessage( playerid, C_WHITE, g_small_string );
	
	SendClientMessage( playerid, C_WHITE, ""gbDefault"Для авторизации в панели администрирования, используйте ещё раз - "cBLUE"/aduty"cWHITE"." );
	return 1;
}

stock OnAdminLogin( playerid, password[] ) 
{
	if( !Admin[playerid][aActive] ) {
		SendClientMessage( playerid, C_WHITE, ""gbDefault"Вы не можете авторизоваться, Ваш аккаунт администратора неактивен." );
		return ForbiddenAdminLogin( playerid, "Неактивный аккаунт" );
	}
	
	if( strcmp(Player[playerid][uName], Admin[playerid][aName], true) )
	{
		UpdateAdmin( playerid, "aActive", 0 );

		format:g_small_string(  ""ADMIN_PREFIX" Аккаунт администратора %s[%d] отключён.",
			Player[playerid][uName],
			playerid
		);

		SendAdminMessage( C_RED, g_small_string );
		SendClientMessage( playerid, C_WHITE, ""gbDefault"Ваш аккаунт администратора отключён." );
		return ForbiddenAdminLogin( playerid, "Неактивный аккаунт" );
	}
	
	new
		hash[ 64 + 1 ];
		
	SHA256_PassHash( password, "934adse4kks", hash, sizeof hash );
	
    if( !strcmp(Admin[playerid][aPassword], hash, true) )
    {
		UpdateAdmin( playerid, "aStatus", 1 );
		
		SetPVarInt( playerid, "Admin:Duty", 1 );
		
		format:g_small_string(  ""ADMIN_PREFIX" %s[%d] авторизовался как администратор %d уровня.",
			Player[playerid][uName],
			playerid,
			Admin[playerid][aLevel]
		);
			
		SendAdminMessage( C_BLUE, g_small_string );
		
		SendClientMessage( playerid, C_WHITE, ""gbDefault"Панель администратора - "cBLUE"/acp"cWHITE"." );
		
    }
    else
		return ForbiddenAdminLogin( playerid, "Неверный пароль" );

    clean_array();
    return 1;
	
}

stock OnAdminLogout( playerid, reason[] = "" ) 
{
	UpdateAdmin( playerid, "aStatus", 0 );
	
	if( !strlen( reason ) )
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] вышел как администратор %d уровня.",
			Player[playerid][uName],
			playerid,
			Admin[playerid][aLevel]
		);
	}
	else
	{
		format:g_small_string(  ""ADMIN_PREFIX" %s[%d] вышел как администратор %d уровня. (%s)",
			Player[playerid][uName],
			playerid,
			Admin[playerid][aLevel],
			reason
		);
	}
	
	SendAdminMessage( C_BLUE, g_small_string );
	
	SetPVarInt( playerid, "Admin:Duty", 0 );
	
	return 1;
}

stock OnAdminDisconnect( playerid ) 
{
	UpdateAdmin( playerid, "aStatus", 0 );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] отсоединился от сервера как администратор %d уровня.",
		Player[playerid][uName],
		playerid,
		Admin[playerid][aLevel]
	);

	SendAdminMessage( C_DARKGRAY, g_small_string );
	
	SetPVarInt( playerid, "Admin:Duty", 0 );
	
	return 1;
}

function OnUnbannedIp( playerid, ip[] )
{
	new
		rows = cache_get_row_count();
		
	if( !rows )
		return SendClient:( playerid, C_WHITE, !""gbError"Данный IP адрес не заблокирован.");
		
	mysql_format:g_string( 
		"DELETE FROM "DB_IPBANS" WHERE ipban_ip = '%e'",
		 ip
	);
	
	mysql_tquery( mysql, g_string, "", "" );
	
		
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] разблокировал IP адрес: %s.",
		Player[playerid][uName],
		playerid,
		ip
	);

	SendAdmin:( C_DARKGRAY, g_small_string );
	
	return 1;
}

function OnUnbannedPlayer( playerid, name[] )
{
	new
		rows = cache_get_row_count();
	
	if( !rows )
		return SendClient:( playerid, C_WHITE, ""gbError"Данный игрок не заблокирован.");
	
	mysql_format:g_string( "DELETE FROM "DB_BANS" WHERE bUserName = '%e'", name );
	mysql_tquery( mysql, g_string, "", "" );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] разблокировал аккаунт: %s.",
		Player[playerid][uName],
		playerid,
		name
	);

	SendAdmin:( C_DARKGRAY, g_small_string );
	
	return 1;
}

function OnUnretestPlayer( playerid, name[] )
{
	new
		rows = cache_get_row_count();
		
	if( !rows )
		return SendClient:( playerid, C_WHITE, ""gbError"Данный игрок не найден в базе данных.");
		
	if( cache_get_field_content_int( 0, "uRetest" ) == 0 )
		return SendClient:( playerid, C_WHITE, ""gbError"Данный игрок не находится на ретесте.");
		
	mysql_format:g_string( "UPDATE "DB_USERS" SET uRetest = 0 WHERE uName = '%e'", name );
	mysql_tquery( mysql, g_string, "", "" );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] снял ретест с аккаунта: %s.",
		Player[playerid][uName],
		playerid,
		name
	);

	SendAdmin:( C_DARKGRAY, g_small_string );	
	
	return 1;
}

function OnOfflineBanStepOne( playerid, days )
{
	if( !cache_get_row_count() )
	{
		clean:<offline_ban[ban_reason]>;
		clean:<offline_ban[ban_name]>;
		offline_ban[ban_days] = 0;
		return SendClient:( playerid, C_WHITE, !""gbError"Данный игрок не найден в базе данных." );
	}	
	
	new
		u_id;
	
	u_id = cache_get_field_content_int(0, "uID", mysql );
	
	mysql_format:g_small_string( "SELECT `bUserID` FROM `"DB_BANS"` WHERE `bUserID` = %d", u_id );
	mysql_tquery( mysql, g_small_string, "OnOfflineBanStepTwo", "id", playerid, u_id );

	return 1;
}

function OnOfflineBanStepTwo( adminid, uid )
{
	if( cache_get_row_count() )
	{
		clean:<offline_ban[ban_reason]>;
		clean:<offline_ban[ban_name]>;
		offline_ban[ban_days] = 0;
		
		return SendClient:( adminid, C_WHITE, !""gbError"Данный игрок уже заблокирован." );
	}	
	
	if( !offline_ban[ ban_days ] ) 
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] заблокировал оффлайн %s навсегда. (%s)",
			Player[adminid][uName],
			adminid,
			offline_ban[ ban_name ],
			offline_ban[ ban_reason ]
		);
	} 
	else 
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] заблокировал оффлайн %s на %d дней. (%s)",
			Player[adminid][uName],
			adminid,
			offline_ban[ ban_name ],
			offline_ban[ ban_days ],
			offline_ban[ ban_reason ]
		);
	}
	SendAdmin:( C_DARKGRAY, g_small_string );
	
	new
		lastdate = INFINITY_DATE;

	if( offline_ban[ ban_days ] != 0 )
		lastdate = gettime() + offline_ban[ ban_days ] * 86400;
	
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "\
		INSERT INTO "DB_BANS"\
			(bAdminName, bAdminID, bUserName, bUserID, bDate, bLastDate, bReason, bAdminIP, bUserIP, bHide)\
		VALUES\
		    ('%s', %d, '%s', %d, %d, %d, '%e', '%s', 'Offline', 1 )",
		Player[adminid][uName],
		Admin[adminid][aID],
		offline_ban[ban_name],
		uid,
		gettime(),
		lastdate,
		offline_ban[ban_reason],
		Player[adminid][tIP]
	);

	mysql_tquery( mysql, g_string );
	
	clean:<offline_ban[ban_name]>;
	clean:<offline_ban[ban_reason]>;
	offline_ban[ ban_days ] = 0;
	return 1;
}