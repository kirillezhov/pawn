	
Weather_OnGameModeInit() 
{
	server_weather_type = 0;
	server_weather = server_weather_list[ random( sizeof server_weather_list ) ];
	
	return 1;
}	
	
stock UpdateWeather( playerid ) 
{
	if( !GetPVarInt( playerid, "User:inInt" ) ) 
	{
		if( server_weather_type == 0 ) // Погода по умолчанию
		{
			SetPlayerWeather( playerid, server_weather_list[ server_weather ] );
		}
		else if( server_weather_type == 1 )
		{
			SetPlayerWeather( playerid, server_weather );
		}
		
		if( server_weather_time != -1 )
		{
			SetPlayerTime( playerid, server_weather_time, 0 );
		}
		else
		{
			SetPlayerTime( playerid, ghour + 3, 0 );
		}
	}	
	
	return 1;
}

stock callWeather() 
{
	server_update_weather++;
	
	if( server_update_weather >= 2100 ) 
	{
		server_update_weather = 0;
		server_weather++;
		
		if( server_weather > 47 ) server_weather = 0;
	}
	return true;
}