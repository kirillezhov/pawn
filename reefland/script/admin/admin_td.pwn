stock AdminUpdateSpectatePanel( playerid, spectateid )
{	
	format:g_small_string("%s ~y~(%d)", 
		GetAccountName( spectateid ),
		spectateid
	);
	
	PlayerTextDrawSetString( playerid, admin_player_name[playerid], g_small_string );
	
	GetWeaponName( GetPlayerWeapon( spectateid ), g_small_string, MAX_PLAYER_NAME + 10 );
	
	format:g_big_string(
		"\
			ID Аккаунта: %d~n~\
			Наличные: %d~n~\
			Скорость: %d / %d~n~\
			Выстрел: %d / %d~n~\
			Оружие: %s~n~\
			Ping: %d ms~n~\
			IP: %s\
		", 
		Player[spectateid][uID],
		Player[spectateid][uMoney],
		Player[spectateid][tVehicleSpeed],
		Player[spectateid][tSpeed],
		Player[spectateid][tTrueShot],
		Player[spectateid][tFalseShot],
		isnull( g_small_string ) ? ("Нет") : g_small_string,
		Player[spectateid][tPing],
		Player[spectateid][tIP]
	);
	
	PlayerTextDrawSetString( playerid, admin_player_info[playerid], g_big_string );

	return 1;
}

stock ShowAdminSpectatePanel( playerid, states, spectateid = INVALID_PLAYER_ID )
{
	if( states && spectateid != INVALID_PLAYER_ID )
	{
		TextDrawShowForPlayer( playerid, admin_bg );

		format:g_small_string("%s ~y~(%d)", 
			GetAccountName( spectateid ),
			spectateid
		);
		
		PlayerTextDrawSetString( playerid, admin_player_name[playerid], g_small_string );
		
		GetWeaponName( GetPlayerWeapon( spectateid ), g_small_string, MAX_PLAYER_NAME + 10 );
		
		format:g_big_string(
			"\
				ID Аккаунта: %d~n~\
				Наличные: %d~n~\
				Скорость: %d / %d~n~\
				Выстрел: %d / %d~n~\
				Оружие: %s~n~\
				Ping: %d ms~n~\
				IP: %s\
			", 
			Player[spectateid][uID],
			Player[spectateid][uMoney],
			Player[spectateid][tVehicleSpeed],
			Player[spectateid][tSpeed],
			Player[spectateid][tTrueShot],
			Player[spectateid][tFalseShot],
			g_small_string,
			Player[spectateid][tPing],
			Player[spectateid][tIP]
		);
		
		PlayerTextDrawSetString( playerid, admin_player_info[playerid], g_big_string );
		
		PlayerTextDrawShow( playerid, admin_player_name[playerid] );
		PlayerTextDrawShow( playerid, admin_player_info[playerid] );
	}
	else
	{
		TextDrawHideForPlayer( playerid, admin_bg );

		PlayerTextDrawHide( playerid, admin_player_name[playerid] );
		PlayerTextDrawHide( playerid, admin_player_info[playerid] );
	}
}

Admin_TextDraws()
{
	admin_bg = TextDrawCreate( 505.999877, 265.249969, "box" );
	TextDrawLetterSize( admin_bg, 0.000000, 10.522295 );
	TextDrawTextSize( admin_bg, 626.500488, 0.000000 );
	TextDrawAlignment( admin_bg, 1 );
	TextDrawColor( admin_bg, -1 );
	TextDrawUseBox( admin_bg, 1 );
	TextDrawBoxColor( admin_bg, 945389666 );
	TextDrawSetShadow( admin_bg, 0 );
	TextDrawSetOutline( admin_bg, 0 );
	TextDrawBackgroundColor( admin_bg, 255 );
	TextDrawFont( admin_bg, 1 );
	TextDrawSetProportional( admin_bg, 1 );
	TextDrawSetShadow( admin_bg, 0 );
}

Admin_PlayerTextDraws( playerid )
{
	admin_player_name[playerid] = CreatePlayerTextDraw( playerid, 566.259521, 267.666595, "Adadadad_Dfghsadersasd(111)" );
	PlayerTextDrawLetterSize( playerid, admin_player_name[playerid], 0.177882, 1.197501 );
	PlayerTextDrawTextSize( playerid, admin_player_name[playerid], 0.000000, 116.000000 );
	PlayerTextDrawAlignment( playerid, admin_player_name[playerid], 2 );
	PlayerTextDrawColor( playerid, admin_player_name[playerid], -1 );
	PlayerTextDrawUseBox( playerid, admin_player_name[playerid], 1 );
	PlayerTextDrawBoxColor( playerid, admin_player_name[playerid], 63 );
	PlayerTextDrawSetShadow( playerid, admin_player_name[playerid], 0 );
	PlayerTextDrawSetOutline( playerid, admin_player_name[playerid], 0 );
	PlayerTextDrawBackgroundColor( playerid, admin_player_name[playerid], 60 );
	PlayerTextDrawFont( playerid, admin_player_name[playerid], 2 );
	PlayerTextDrawSetProportional( playerid, admin_player_name[playerid], 1 );
	PlayerTextDrawSetShadow( playerid, admin_player_name[playerid], 0 );

	admin_player_info[playerid] = CreatePlayerTextDraw( playerid, 509.123229, 283.916595, "2282282~n~$400000~n~90 MP/H~n~100/20~n~M4A1/Pustinniy Orel~n~999 ms~n~127.23.42.123" );
	PlayerTextDrawLetterSize( playerid, admin_player_info[playerid], 0.175058, 1.034166 );
	PlayerTextDrawAlignment( playerid, admin_player_info[playerid], 1 );
	PlayerTextDrawColor( playerid, admin_player_info[playerid], -1 );
	PlayerTextDrawSetShadow( playerid, admin_player_info[playerid], 0 );
	PlayerTextDrawSetOutline( playerid, admin_player_info[playerid], 0 );
	PlayerTextDrawBackgroundColor( playerid, admin_player_info[playerid], 60 );
	PlayerTextDrawFont( playerid, admin_player_info[playerid], 2 );
	PlayerTextDrawSetProportional( playerid, admin_player_info[playerid], 1 );
	PlayerTextDrawSetShadow( playerid, admin_player_info[playerid], 0 );
	
	return 1;
}

Admin_TextDrawsHide( playerid )
{
	TextDrawHideForPlayer( playerid, admin_bg );

	PlayerTextDrawHide( playerid, admin_player_name[playerid] );
	PlayerTextDrawDestroy( playerid, admin_player_name[playerid] );
	
	PlayerTextDrawHide( playerid, admin_player_info[playerid] );
	PlayerTextDrawDestroy( playerid, admin_player_info[playerid] );
	
	return 1;
}