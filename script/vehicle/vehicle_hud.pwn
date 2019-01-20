
new updateVehTimer[MAX_PLAYERS];

Vehicle_OnPlayerStateChange( playerid, newstate, oldstate ) 
{
	switch( newstate ) 
	{
		case PLAYER_STATE_DRIVER: 
		{
			new
				vehicleid = GetPlayerVehicleID( playerid );
		
			for( new i; i < 3; i++ )
			{
				if( vehicleid >= cars_auto[i][0] && vehicleid <= cars_auto[i][1] ) return 1;
			}
			
			if( IsVelo( vehicleid ) )
			{
				Vehicle[ vehicleid ][vehicle_state_engine] = 1;
				SetVehicleParams( vehicleid );
				
				if( updateVehTimer[playerid] ) 
					KillTimer( updateVehTimer[playerid] );
				
				updateVehTimer[playerid] = SetTimerEx( "updateVehicleHud", 300, true, "ii", playerid, vehicleid );
				
				return 1;
			}
		
			if( Vehicle[vehicleid][vehicle_member] && Vehicle[vehicleid][vehicle_member] != Player[playerid][uMember] )
			{
				Vehicle[ vehicleid ][vehicle_state_engine] = 0;
				SetVehicleParams( vehicleid );
				
				removePlayerFromVehicle( playerid );
				SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
			}
			else if( Vehicle[vehicleid][vehicle_crime] && Vehicle[vehicleid][vehicle_crime] != Player[playerid][uCrimeM] )
			{
				Vehicle[ vehicleid ][vehicle_state_engine] = 0;
				SetVehicleParams( vehicleid );
				
				removePlayerFromVehicle( playerid );
				SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
			}
			else if( Vehicle[ vehicleid ][vehicle_user_id] != INVALID_PARAM )
			{
				if( Vehicle[ vehicleid ][vehicle_user_id] != Player[playerid][uID] )
				{
					Vehicle[ vehicleid ][vehicle_state_engine] = 0;
					SetVehicleParams( vehicleid );
					
					removePlayerFromVehicle( playerid );
					SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
				}
			}
			else if( vehicleid >= cars_prod[0] && vehicleid <= cars_taxi[1] )
			{
				if( vehicleid != Job[playerid][j_vehicleid] )
				{
					Vehicle[ vehicleid ][vehicle_state_engine] = 0;
					SetVehicleParams( vehicleid );
					
					removePlayerFromVehicle( playerid );
					SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
				}
			}
			else if( vehicleid >= cars_food[0] && vehicleid <= cars_food[1] )
			{
				if( Player[playerid][uJob] != JOB_FOOD || !job_duty{playerid} )
				{
					Vehicle[ vehicleid ][vehicle_state_engine] = 0;
					SetVehicleParams( vehicleid );
					
					removePlayerFromVehicle( playerid );
					SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
				}
				else if( !GetPVarInt( playerid, "Job:Food" ) && IsPlayerInRangeOfPoint( playerid, 50.0, 1685.2498, -1463.9598, 13.5469 ) )
				{
					Vehicle[ vehicleid ][vehicle_state_engine] = 0;
					SetVehicleParams( vehicleid );
					
					removePlayerFromVehicle( playerid );
					SendClient:( playerid, C_WHITE, !""gbError"Возьмите заказ на доставку еды." );
				}
			}
			else if( vehicleid >= cars_mech[0] && vehicleid <= cars_mech[1] )
			{
				if( Player[playerid][uJob] != JOB_MECHANIC || !job_duty{playerid} )
				{
					Vehicle[ vehicleid ][vehicle_state_engine] = 0;
					SetVehicleParams( vehicleid );
					
					removePlayerFromVehicle( playerid );
					SendClient:( playerid, C_WHITE, !NO_KEY_CAR );
				}
			}
		
			showVehicleHud( playerid, true );
			if( updateVehTimer[playerid] ) KillTimer( updateVehTimer[playerid] );
			updateVehTimer[playerid] = SetTimerEx( "updateVehicleHud", 300, true, "ii", playerid, vehicleid );
		}
	}
	switch( oldstate ) 
	{
		case PLAYER_STATE_DRIVER: 
		{
			for( new i; i < 3; i++ )
			{
				if( GetPlayerVehicleID( playerid ) >= cars_auto[i][0] && GetPlayerVehicleID( playerid ) <= cars_auto[i][1] ) return 1;
			}
		
			showVehicleHud( playerid, false );
			KillTimer( updateVehTimer[playerid] );
		}
	}
	return true;
}

stock showVehicleHud( playerid, showed ) 
{
	if( showed ) 
	{
		if( Player[playerid][uSettings][0] )
		{
			for(new i; i != 3; i++) TextDrawShowForPlayer(playerid, SpeedFon[i]);
			for(new i; i != 7; i++) PlayerTextDrawShow(playerid,Speed[i][playerid]);
		}
	}
	else 
	{
		for(new i; i != 3; i++) TextDrawHideForPlayer(playerid, SpeedFon[i]);
		for(new i; i != 7; i++) PlayerTextDrawHide(playerid,Speed[i][playerid]);
	}
	return 1;
}

function updateVehicleHud( playerid, vehicleid ) 
{
	// Пробег
	new Float:ST[4];
	GetVehicleVelocity( vehicleid, ST[0], ST[1], ST[2] );
	ST[3] = floatsqroot( floatpower( floatabs( ST[0] ), 2.0 ) + floatpower( floatabs( ST[1] ), 2.0 ) 
		+ floatpower( floatabs( ST[2] ), 2.0 ) ) * 179.28625;
		
	Vehicle[vehicleid][vehicle_mile] += ST[3]/2500;
	format:g_small_string(  "MILE: %.1f", Vehicle[vehicleid][vehicle_mile] );
	PlayerTextDrawSetString( playerid, Speed[4][playerid], g_small_string );
	
	// Скорость
	if( Vehicle[vehicleid][vehicle_limit] )
	{
		if( GetVehicleSpeed( vehicleid ) > Vehicle[vehicleid][vehicle_limit] )
			SetVehicleSpeed( vehicleid, float( Vehicle[vehicleid][vehicle_limit] ) );
	}
	
	if( IsVelo( vehicleid ) )
	{
		if( GetVehicleSpeed( vehicleid ) > 50 )
			SetVehicleSpeed( vehicleid, 50.0 );
			
		return 1;
	}
	
	format:g_small_string( "%d", GetVehicleSpeed( vehicleid ) );
	PlayerTextDrawSetString( playerid, Speed[5][playerid], g_small_string );
	
	// Топливо
	if( Vehicle[vehicleid][vehicle_state_engine] ) 
	{
		Vehicle[vehicleid][vehicle_fuel] -= ST[3]/( summFuelRate( vehicleid ) );
	}
	
	format:g_small_string( "FUEL: %.1f", Vehicle[vehicleid][vehicle_fuel] );
	PlayerTextDrawSetString( playerid, Speed[6][playerid], g_small_string );
	
	format:g_small_string(  "%sENG", Vehicle[vehicleid][vehicle_state_engine] ? ("~w~"):("~l~") );
	PlayerTextDrawSetString( playerid, Speed[0][playerid], g_small_string );
	
	format:g_small_string(  "%sLIMIT", Vehicle[vehicleid][vehicle_limit] ? ("~w~") : ("~l~") );
	PlayerTextDrawSetString( playerid, Speed[1][playerid], g_small_string );
	
	format:g_small_string(  "%sLIGHT", Vehicle[vehicleid][vehicle_state_light] ? ("~w~"):("~l~") );
	PlayerTextDrawSetString( playerid, Speed[2][playerid], g_small_string );
	
	format:g_small_string(  "%sLOCK", Vehicle[vehicleid][vehicle_state_door] ? ("~w~"):("~l~") );
	PlayerTextDrawSetString( playerid, Speed[3][playerid], g_small_string );
	
	//Таксиметр
	if( vehicleid >= cars_taxi[0] && vehicleid <= cars_taxi[1] )
	{
		if( VehicleJob[vehicleid][v_passenger] != INVALID_PARAM && 
			VehicleJob[vehicleid][v_rate] && GetPlayerVehicleSeat( VehicleJob[vehicleid][v_passenger] ) > 0 )
		{
			VehicleJob[vehicleid][v_mileage] += ST[3]/2500;
			format:g_small_string( "taximeter: $%d", floatround( VehicleJob[vehicleid][v_mileage] ) * VehicleJob[vehicleid][v_rate] );
			
			PlayerTextDrawSetString( playerid, Taximeter[playerid], g_small_string );
			PlayerTextDrawSetString( VehicleJob[vehicleid][v_passenger], Taximeter[VehicleJob[vehicleid][v_passenger]], g_small_string );
		}
	}
	
	return 1;
}
	
function Float:summFuelRate( vehicleid ) 
{
	new 
		index = Vehicle[vehicleid][vehicle_model] - 400,
		Float:summ = 25000*( 10 / VehicleInfo[ index ][v_consumption] );
	
	return Float:summ;
}