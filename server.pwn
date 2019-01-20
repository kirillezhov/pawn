Server_OnGameModeInit()
{  
	print( "[Load]: "GGAME_VERSION" initialization..." );
	
	DisableInteriorEnterExits();
 	EnableStuntBonusForAll(0);
 	ShowPlayerMarkers(1);
 	SetNameTagDrawDistance(20.0);
    ManualVehicleEngineAndLights();
	
    gettime( ghour, gminute, gsecond );
    SetWorldTime( ghour + 3 );
	
	SetGameModeText( GGAME_VERSION );
    SetTimer( "OnSecondTimer", 1000, true );
    SetTimer( "OnMinuteTimer", 60000, true );
	SetTimer( "OnHourTimer", 3600000, true );
	
	return 1;
}

public Streamer_OnPluginError( error[] ) 
{
	printf( "[STREAMER] %s", error );
	return 1;
}


ServerTimer()
{
	if( server_restart > 0 )
	{
		server_restart--;
	}
	else if( server_restart == 0 )
	{
		foreach(new playerid : Player)
		{
			SavePlayerData( playerid );
		}
		
		SendClientAll:( C_ORANGE, "Уважаемые игроки! Производится технический рестарт сервера. Пожалуйста, перезайдите." );
		SendRconCommand( "gmx" );
	}
	
}