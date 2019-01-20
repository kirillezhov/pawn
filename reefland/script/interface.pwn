Interface_OnPlayerDisconnect( playerid )
{
	// ---- TextDraw: Logo
	if( Player[playerid][uSettings][9] )
	{
		ShowServerLogo( playerid, false );
	}
	
	/* ---- TextDraw: HungerProgress
	else if( Player[playerid][uSettings][2] )
	{
		ShowHunger( playerid, false );
	}*/
	
	// ---- TextDraw: Radio
	else if( Player[playerid][uSettings][8] )
	{
		ShowRadioInfo( playerid, false ); 
	}
	
	return 1;
}

Interface_OnPlayerDeath( playerid )
{
	switch(GetPVarInt(playerid,"PlayerMenuShow")) 
	{
		case 1: 
		{
			for( new i; i != 21; i++ ) TextDrawHideForPlayer( playerid, MenuPlayer[i] );
			for( new i; i != 3; i++ ) PlayerTextDrawHide( playerid, menuPlayer[i][playerid] );
		}
	}
	
	SetPVarInt(playerid,"PlayerMenuShow",0);
    CancelSelectTextDraw(playerid);
	
	return 1;
}

/*stock ShowHunger(playerid, states ) 
{
	if( states )
	{
		TextDrawShowForPlayer( playerid, HungerFon[0]);
		TextDrawShowForPlayer( playerid, HungerFon[1]);
		PlayerTextDrawTextSize( playerid, HungerProgres[playerid], 549.5 + Player[playerid][uHunger] / 100.0 * 54.5, 40.000000 );
		PlayerTextDrawShow( playerid, HungerProgres[playerid] );
	}
	else
	{
		PlayerTextDrawHide( playerid, HungerProgres[playerid] );
		TextDrawHideForPlayer( playerid, HungerFon[0] );
		TextDrawHideForPlayer( playerid, HungerFon[1] );
	}
	
	return 1;
}

stock UpdateHunger( playerid )
{
	TextDrawShowForPlayer( playerid, HungerFon[0] );
	TextDrawShowForPlayer( playerid, HungerFon[1] );
	PlayerTextDrawTextSize( playerid, HungerProgres[playerid], 549.5 + Player[playerid][uHunger] / 100.0 * 54.5, 40.000000 );
	PlayerTextDrawShow( playerid, HungerProgres[playerid] );
	return 1;
}*/

stock UpdateRadioInfo( playerid, type )
{
	if( type == 1 )
	{
		format:g_small_string(  "channel: %d", Player[playerid][uRadioChannel] );
		PlayerTextDrawSetString( playerid, radio[1][playerid], g_small_string );
	}
	else if( type == 2 )
	{
		format:g_small_string(  "slot: %d", Player[playerid][uRadioSubChannel] );
		PlayerTextDrawSetString( playerid, radio[2][playerid], g_small_string );
	}
}

stock ShowRadioInfo( playerid, states ) 
{
	clean_array();
	if( states )
	{
		format:g_small_string(  "channel: %d", Player[playerid][uRadioChannel] );
		PlayerTextDrawSetString( playerid, radio[1][playerid], g_small_string );
		
		format:g_small_string(  "slot: %d", Player[playerid][uRadioSubChannel] );
		PlayerTextDrawSetString( playerid, radio[2][playerid], g_small_string );
		
		for( new i; i < sizeof radio; i++ )
			PlayerTextDrawShow( playerid, radio[i][playerid] );
	
	} 
	else 
	{
		for( new i; i < sizeof radio; i++ )
			PlayerTextDrawHide( playerid, radio[i][playerid] );
	}
	
	return 1;
}

ShowServerLogo( playerid, states )
{
	if( states )
	{
		for( new i; i < sizeof logo; i++ )
		{
			TextDrawShowForPlayer( playerid, logo[i] );
		}
	}
	else
	{
		for( new i; i < sizeof logo; i++ )
		{
			TextDrawHideForPlayer( playerid, logo[i] );
		}
	}
}