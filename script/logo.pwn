Logo_OnPlayerDisconnect( playerid )
{
	ShowServerLogo( playerid, false );
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