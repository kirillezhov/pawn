Radio_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid )
	{
		case d_radio :
		{
		    if( !response ) 
				return 1;
			
			new
				vehicleid;
			
		    if ( listitem < sizeof radio_list - 1 )
		    {
		        SendClient:(playerid, C_WHITE,""gbDefault"Для отключения клиентовских сообщений - 'Audio Stream: (URL)'. Используйте - "cBLUE"/audiomsg"cWHITE".");
				
				if( IsPlayerInAnyVehicle( playerid ) )
				{
					vehicleid = GetPlayerVehicleID( playerid );
					
					vehicle_radio_list[ vehicleid ] = listitem;
			        foreach(new i : Player) 
					{
			            if( !IsPlayerConnected( i ) || GetPlayerVehicleID( i ) != vehicleid ) 
							continue;
							
		     			PlayAudioStreamForPlayer( i, radio_list[listitem][1] );
					}
				}
				else PlayAudioStreamForPlayer( playerid, radio_list[listitem][1] );
			}
			else if ( listitem == sizeof radio_list - 1 ) 
			{
			    showPlayerDialog( playerid, d_radio + 3, DIALOG_STYLE_INPUT, " ", ""gbDefault"Собственная радиостанция.\n\nВведите ссылку на онлайн поток радиостанции или любого трека:\n\
				"gbDefault"Пример: http://www.g-rp.su/station_709.m3u", "Далее", "Назад" );
			}
			else if ( listitem >= sizeof radio_list )
			{
			    if( IsPlayerInAnyVehicle( playerid ) )
				{
					vehicleid = GetPlayerVehicleID( playerid );
					
				    vehicle_radio_list[ vehicleid ] = -1;
				    vehicle_radio_list_station[ vehicleid ][0] = EOS;
				    foreach(new i: Player) 
					{
		 				if( !IsPlayerConnected(i) || GetPlayerVehicleID(i) != vehicleid ) continue;
		     			StopAudioStreamForPlayer( i );
					}
				}
				else StopAudioStreamForPlayer(playerid) ;
		    }
			
		    return 1;
		}
		
		case d_radio + 1:
	    {
	        if( !response ) 
				return 1;
				
	        if( listitem == sizeof radio_list - 1 ) 
			{
	            showPlayerDialog( playerid, d_radio + 2, DIALOG_STYLE_INPUT, " ", ""gbDefault"Собственная радиостанция.\n\nВведите ссылку на онлайн поток радиостанции или любого трека:\n"gbDefault"Пример: http://www.g-rp.su/station_709.m3u", 
					"Далее", "Назад" 
				);
				
	            return 1;
	        }
			
			foreach(new i: Player) 
			{
				if( IsPlayerInDynamicArea( i, GetPVarInt(playerid, "BBArea") ) ) 
				{
					PlayAudioStreamForPlayer(i, radio_list[listitem][1], GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ"), 10.0, 1);
		  		}
		  	}
			
		  	SetPVarString(playerid, "BBStation", radio_list[listitem][1] );
			return 1;
		}
		
		case d_radio + 2: 
		{
		    if( !response ) 
				return CallLocalFunction( "cmd_music", "i", playerid );
				
		    foreach(new i : Player) 
			{
				if( IsPlayerInDynamicArea( i, GetPVarInt( playerid, "BBArea") ) ) 
				{
					PlayAudioStreamForPlayer( i, inputtext, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ"), 10.0, 1 );
		  		}
		  	}
			
		  	SetPVarString(playerid, "BBStation", inputtext );
		}
		
		case d_radio + 3: 
		{
            if( !response ) 
				return CallLocalFunction( "cmd_radio_list", "i", playerid );
				
			
            if( IsPlayerInAnyVehicle( playerid ) ) 
			{
				new 
					vehicleid = GetPlayerVehicleID(playerid);
					
				vehicle_radio_list[vehicleid] = sizeof radio_list;
				format( vehicle_radio_list_station[ vehicleid ], 72, "%s", inputtext );
				
    			foreach(new i : Player) 
				{
       				if( !IsPlayerConnected( i ) || GetPlayerVehicleID( i ) != vehicleid ) 
						continue;
						
  					PlayAudioStreamForPlayer( i, inputtext );
				}
			}
			else PlayAudioStreamForPlayer( playerid, inputtext );
        }
	}
	return 1;
}

