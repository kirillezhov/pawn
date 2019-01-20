CMD:drop( playerid )
{
	if( Player[playerid][uMember] != FRACTION_FIRE || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !IsPlayerInAnyVehicle( playerid ) ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new 
		vehicleid = GetPlayerVehicleID( playerid );
		
	if( Vehicle[vehicleid][vehicle_member] != FRACTION_FIRE )
		return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
		
	if( IsValidDynamicObject( Vehicle[vehicleid][vehicle_water][0] ) ) 
	{
		for( new i; i < 3; i++ )
		{
			if( IsValidDynamicObject( Vehicle[vehicleid][vehicle_water][i] ) )
			{			
				DestroyDynamicObject( Vehicle[vehicleid][vehicle_water][i] );
				Vehicle[vehicleid][vehicle_water][i] = 0;
			}
		}
		
		SendClient:( playerid, C_WHITE, !""gbDefault"�� ���������� ����� ����." );
		
		foreach(new i: Player)
		{
			if( !IsLogged(i) || Player[i][uMember] != FRACTION_FIRE ) continue;
			
			if( GetPVarInt( i, "Fire:Water" ) ) DeletePVar( i, "Fire:Water" );
		}
	}
	else
	{
		if( !InstallWaterToVehicle( vehicleid ) )
			return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
			
		SendClient:( playerid, C_WHITE, !""gbDefault"�� ������ ����� ����." );
		SetPVarInt( playerid, "Fire:Water", 1 );
	}

	return 1;
}

CMD:boat( playerid )
{
	if( Player[playerid][uMember] != FRACTION_FIRE || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !IsPlayerInAnyVehicle( playerid ) ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new 
		vehicleid = GetPlayerVehicleID( playerid ),
		Float: x, Float: y, Float: z, Float: angle;
		
	if( Vehicle[vehicleid][vehicle_member] != FRACTION_FIRE )
		return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
		
	switch( GetVehicleModel( vehicleid ) )
	{
		case 427, 573, 563 :
		{
			if( Vehicle[vehicleid][vehicle_boat] )
			{
				DestroyVehicleEx( Vehicle[vehicleid][vehicle_boat] );
				Vehicle[vehicleid][vehicle_boat] = 0;
				
				SendClient:( playerid, C_WHITE, !""gbSuccess"�� ������� �������� �����, ������������ �� ���� �����������." );
			}
			else
			{
				GetVehiclePos( vehicleid, x, y, z );
				GetVehicleZAngle( vehicleid, angle );
			
				Vehicle[vehicleid][vehicle_boat] = CreateVehicleEx( 473, x + 7.0 * -floatsin( angle + 180.0, degrees ), y + 7.0 * floatcos( angle + 180.0, degrees ), z, angle, 3, 3, 60000 );
				
				SendClient:( playerid, C_WHITE, !""gbSuccess"�� ��������� �������� �����." );
			}
		}
		
		case 433, 417, 548 :
		{
			if( Vehicle[vehicleid][vehicle_boat] )
			{
				DestroyVehicleEx( Vehicle[vehicleid][vehicle_boat] );
				Vehicle[vehicleid][vehicle_boat] = 0;
				
				SendClient:( playerid, C_WHITE, !""gbSuccess"�� ������� ������������ �����, ������������ �� ���� �����������." );
			}
			else
			{
				GetVehiclePos( vehicleid, x, y, z );
				GetVehicleZAngle( vehicleid, angle );
			
				Vehicle[vehicleid][vehicle_boat] = CreateVehicleEx( 472, x + 7.0 * -floatsin( angle + 180.0, degrees ), y + 7.0 * floatcos( angle + 180.0, degrees ), z, angle, 3, 3, 60000 );
				
				SendClient:( playerid, C_WHITE, !""gbSuccess"�� ��������� ������������ �����." );
			}
		}
		
		default: return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ������������ ������� � ���� ����������." );
	}

	return 1;
}

CMD:oxygen( playerid )
{
	if( Player[playerid][uMember] != FRACTION_FIRE || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( IsPlayerInAnyVehicle( playerid ) ) 
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( !GetPVarInt( playerid, "Fire:Attach" ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"����������� ������ �� �����." );
		
	if( !timer_oxygen[playerid] )
	{
		timer_oxygen[playerid] = SetTimerEx( "OnTimerOxygen", 300, true, "d", playerid );
		SendClient:( playerid, C_WHITE, !""gbSuccess"�� ������ ������������ ����������� ������. ������� "cBLUE"/oxygen"cWHITE", ����� ���������� ������ ���������." );
	}
	else
	{
		KillTimer( timer_oxygen[playerid] );
		timer_oxygen[playerid] = 0;
		
		SendClient:( playerid, C_WHITE, !""gbSuccess"�� ���������� ������ ���������." );
	}

	return 1;
}

CMD:luke( playerid )
{
	if( Player[playerid][uMember] != FRACTION_FIRE || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		
	if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
	    return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� �� ����� ������." );

	new
		vehicleid = GetPlayerVehicleID( playerid ),
		model = GetVehicleModel( vehicleid );
	
	if( Vehicle[vehicleid][vehicle_member] != FRACTION_FIRE )
		return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������������������ ����������." );
	
	if( !getVehicleLukeType( model ) )
		return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� � ������������������ ����������." );
		
	if( !Vehicle[vehicleid][vehicle_luke] )
	{
		new 
			Float: x,
			Float: y,
			Float: z,
			Float: z_angle;
			
		GetVehiclePos( vehicleid, x, y, z );
		GetVehicleZAngle( vehicleid, z_angle );
		
		x -= ( 30.0 * floatsin( -z_angle, degrees ) );
		y -= ( 30.0 * floatcos( -z_angle, degrees ) ); 
		z -= 2.0;
		
		Vehicle[vehicleid][vehicle_luke] = 1;
		Vehicle[vehicleid][vehicle_luke_text] = CreateDynamic3DTextLabel( 
			"[ ��� ������ ]",C_WHITE, 
			x,
			y,
			z,
			10.0,
			INVALID_PLAYER_ID,
			vehicleid,
			1,
			-1,
			-1
		);
		
		SendClient:( playerid, C_WHITE, !""gbDefault"�� ������� ���." );
	}
	else 
	{
		Vehicle[vehicleid][vehicle_luke] = 0;
		
		if( IsValidDynamic3DTextLabel( Vehicle[vehicleid][vehicle_luke_text] ) )
		{
			DestroyDynamic3DTextLabel( Vehicle[vehicleid][vehicle_luke_text] );
			Vehicle[vehicleid][vehicle_luke_text] = Text3D: INVALID_3DTEXT_ID;
		}
		
		SendClient:( playerid, C_WHITE, !""gbDefault"�� ������� ���." );
	}
	
	return 1;
}

CMD:air( playerid )
{
	if( GetPVarInt( playerid, "Luke:VehicleID" ) )
	{
		if( !PlayerExitHelicopterInt( playerid ) )
		{
			return SendClient:( playerid, C_WHITE, !""gbError"��� ������, �� �� ������ �������� ���������." );
		}
	}
	else if( !GetPlayerVirtualWorld( playerid ) )
	{
		new 
			Float: x,
			Float: y,
			Float: z,
			type,
			vehicleid;
			
		if( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
			vehicleid = GetPlayerVehicleID( playerid );
		
		for( new i; i < MAX_VEHICLES; i++ )
		{
			if( !Vehicle[i][vehicle_luke] ) continue;
				
			type = getVehicleLukeType( GetVehicleModel(i) );
				
			if( !type ) continue;
				
			GetVehiclePos( i, x, y, z );
					
			if( !vehicleid && IsPlayerInRangeOfPoint( playerid, 10.0, x, y, z ) )
			{
				setPlayerPos( playerid, luke_pos[ type - 1 ][0], luke_pos[ type - 1 ][1], luke_pos[ type - 1 ][2] );
				SetPlayerVirtualWorld( playerid, i );
				
				SetPVarInt( playerid, "Luke:VehicleID", i );
					
				setHouseWeather( playerid );
				break;
			}
			else if( vehicleid && IsPlayerInRangeOfPoint( playerid, 15.0, x, y, z ) )
			{
				if( Vehicle[i][vehicle_model] != 592 && Vehicle[i][vehicle_model] != 548 ) return 1;
			
				setVehiclePos( vehicleid, luke_pos[ type - 1 ][3], luke_pos[ type - 1 ][4], luke_pos[ type - 1 ][5] );
				SetVehicleZAngle( vehicleid, luke_pos[ type - 1 ][6] );
				
				SetVehicleVirtualWorld( vehicleid, i );
				SetPlayerVirtualWorld( playerid, i );
				
				SetPVarInt( playerid, "Luke:VehicleID", i );
				setHouseWeather( playerid );
				
				foreach(new j : Player)
				{
					if( !IsLogged( j ) || playerid == j )
						continue;
						
					if( IsPlayerInVehicle( j, vehicleid ) && GetPlayerState( j ) == 3 )
					{
						SetPlayerVirtualWorld( j, i );	
					
						SetPVarInt( j, "Luke:VehicleID", i );
						setHouseWeather( j );
					}
				}

				break;
			}
		}
	}

	return 1;
}