CMD:sl( playerid, params[] )
	return cmd_strobelight( playerid, params );
	
CMD:strobelight( playerid, params[] )
{
	new 
		bool: access = false, 
		timer,
		vehicleid;
	
	if( !Player[playerid][uMember] || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	switch( Player[playerid][uMember] )
	{
		case FRACTION_POLICE, FRACTION_SADOC, FRACTION_FIRE, FRACTION_HOSPITAL, FRACTION_WOOD, FRACTION_FBI: access = true;
	}
	
	if( !access )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !( vehicleid = GetPlayerVehicleID( playerid ) ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Для использования команды Вам необходимо находиться в транспорте." );

	if( !GetStrobeValidVehicle( vehicleid ) )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете использовать данную команду в данном транспорте." );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /sl [ 0 - 6 ]" );
	
	if( params[0] < 0 || params[0] > 6 )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /sl [ 0 - 6 ]" );
	
	switch( params[0] )
	{
		case 1,2,4: timer = 250;
		
		case 3: timer = 400;
		
		case 5: timer = 150;
		
		case 6: timer = 50;
	}
	
	CheckVehicleParams( vehicleid );
	
	if( strobelight_timer[ vehicleid ] == -1 )
	{
		if( !params[0] )
			return SendClient:( playerid, C_WHITE, !""gbError"Стробоскопы уже выключены." );
	
		strobelight_timer[ vehicleid ] = SetTimerEx( "OnVehicleStrobeLight", timer, true, "dd", vehicleid, params[0] );
		SendClient:( playerid, C_WHITE, ""gbDefault"Вы включили стробоскопы." );
	
		CheckVehicleParams( vehicleid );
		Vehicle[vehicleid][vehicle_state_light] = 1;
		
		SetVehicleParams( vehicleid );
		
		PlayerTextDrawSetString( playerid, Speed[2][playerid], "~w~LIGHT" );
	}
	else
	{	
		if( !params[0] )
		{
			OnVehicleStrobeTimeOut( vehicleid );
			SendClientMessage( playerid, C_WHITE, ""gbDefault"Вы выключили стробоскопы." );
			
			PlayerTextDrawSetString( playerid, Speed[2][playerid], "~l~LIGHT" );
		}
		else
		{
			KillTimer( strobelight_timer[ vehicleid ] );
			strobelight_flash{ vehicleid } = 0;
		
			strobelight_timer[ vehicleid ] = SetTimerEx( "OnVehicleStrobeLight", timer, true, "dd", vehicleid, params[0] );
			SendClient:( playerid, C_WHITE, ""gbDefault"Режим стробоскоп изменен." );
		}
	}
	
	return 1;
}

function OnVehicleStrobeTimeOut( vehicleid )
{
	new 
		panels,
		doors,
		tires,
		lights;
			
	GetVehicleDamageStatus( vehicleid, panels, doors, lights, tires );
	UpdateVehicleDamageStatus( vehicleid, panels, doors, 0, tires );
	
	CheckVehicleParams( vehicleid );
	Vehicle[vehicleid][vehicle_state_light] = 0;
	
	SetVehicleParams( vehicleid );
		
	strobelight_flash{ vehicleid } = 0;
	
	if( strobelight_timer[ vehicleid ] )
	{
		KillTimer( strobelight_timer[ vehicleid ] );
		strobelight_timer[ vehicleid ] = -1;
	}
	
	if( strobelight_time_out[ vehicleid ] )
	{
		KillTimer( strobelight_time_out[ vehicleid ] );
		strobelight_time_out[ vehicleid ] = -1;
	}
	
	return 1;
}

function Strobe_OnPlayerEnterVehicle( playerid, vehicleid )
{
	if( strobelight_time_out[ vehicleid ] )
	{
		KillTimer( strobelight_time_out[ vehicleid ] );
		strobelight_time_out[ vehicleid ] = -1;
	}
	
	return 1;
}

function Strobe_OnVehicleDeath( vehicleid )
{
	if( strobelight_timer[ vehicleid ] )
	{
		KillTimer( strobelight_timer[ vehicleid ] );
		strobelight_timer[ vehicleid ] = -1;
	}
	
	if( strobelight_time_out[ vehicleid ] )
	{
		KillTimer( strobelight_time_out[ vehicleid ] );
		strobelight_time_out[ vehicleid ] = -1;
	}
	return 1;
}

function Strobe_OnPlayerExitVehicle( playerid, vehicleid )
{
	if( strobelight_time_out[ vehicleid ] )
	{
		strobelight_time_out[ vehicleid ] = SetTimerEx( "OnVehicleStrobeTimeOut", 900000, false, "d", vehicleid );
	}
	
	return 1;
}

function OnVehicleStrobeLight( vehicleid, type )
{
	new 
		panels,
		doors,
		tires,
		lights;
		
	GetVehicleDamageStatus( vehicleid, panels, doors, lights, tires );
	
	switch( type )
	{
		case 1:
		{
			switch( strobelight_flash{ vehicleid } ) 
			{
				case 0: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 1: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 2: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 3: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
			}
			
			strobelight_flash{ vehicleid }++;
			if( strobelight_flash{ vehicleid } > 3 )
			{
				strobelight_flash{ vehicleid } = 0;
			}
		}
		
		case 2:
		{
			switch( strobelight_flash{ vehicleid } ) 
			{
				case 0: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 1: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 2: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 3: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
			}
				
			strobelight_flash{ vehicleid }++;
			if( strobelight_flash{ vehicleid } > 3 )
			{
				strobelight_flash{ vehicleid } = 0;
			}
		}
		
		case 3:
		{
			switch( strobelight_flash{ vehicleid } ) 
			{
				case 0: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 1: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 2: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
			}
				
			strobelight_flash{ vehicleid }++;
			if( strobelight_flash{ vehicleid } > 2 )
			{
				strobelight_flash{ vehicleid } = 0;
			}
		}
		
		case 4:
		{
			switch( strobelight_flash{ vehicleid } ) 
			{
				case 0: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 1: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 2: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 3: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 4: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 5: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 6: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 7: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 8: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 9: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 10: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 11: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 12: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
			}
				
			strobelight_flash{ vehicleid }++;
			if( strobelight_flash{ vehicleid } > 13 )
			{
				strobelight_flash{ vehicleid } = 0;
			}
		}
		
		case 5:
		{
			switch( strobelight_flash{ vehicleid } ) 
			{
				case 0: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 1: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 2: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 3: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 4: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 5: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 6: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 7: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 8: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 9: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 10: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 11: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 12: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 13: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 14: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 15: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
			}
				
			strobelight_flash{ vehicleid }++;
			if( strobelight_flash{ vehicleid } > 16 )
			{
				strobelight_flash{ vehicleid } = 0;
			}
		}
		
		case 6:
		{
			switch( strobelight_flash{ vehicleid } ) 
			{
				case 0: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 1: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 2: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 3: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 4: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 5: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 6: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 7: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 8: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 9: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 10: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 11: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 12: UpdateVehicleDamageStatus( vehicleid, panels, doors, 4, tires );
				case 13: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
				case 14: UpdateVehicleDamageStatus( vehicleid, panels, doors, 2, tires );
				case 15: UpdateVehicleDamageStatus( vehicleid, panels, doors, 5, tires );
			}
			
			strobelight_flash{ vehicleid }++;
			if( strobelight_flash{ vehicleid } > 16 )
			{
				strobelight_flash{ vehicleid } = 0;
			}
		}
	}

	return 1;
}

GetStrobeValidVehicle( vehicleid )
{
	switch( Vehicle[vehicleid][vehicle_member] )
	{
		case FRACTION_POLICE, FRACTION_FIRE, FRACTION_HOSPITAL,
			 FRACTION_SADOC, FRACTION_CITYHALL, FRACTION_FBI, FRACTION_WOOD :
		return 1;
	}
	
	return 0;
}