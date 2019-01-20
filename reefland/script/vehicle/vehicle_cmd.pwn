CMD:hood( playerid )
{
	if( !IsPlayerInAnyVehicle( playerid ) )
		return SendClient:( playerid, C_WHITE, !PLAYER_NEED_VEHICLE );
		
	if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
		return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� �� ������������ �����." );
	
	new 
		vehicleid = GetPlayerVehicleID( playerid );
		
	if( !VehicleInfo[GetVehicleModel( vehicleid ) - 400][v_hood] )
		return SendClient:( playerid, C_WHITE, !""gbError"� ������� ���������� ����������� �����." );
	
	CheckVehicleParams( vehicleid );
	
	if( Vehicle[vehicleid][vehicle_state_hood] ) 
	{
		Vehicle[vehicleid][vehicle_state_hood] = false;
	}
	else 
	{
		Vehicle[vehicleid][vehicle_state_hood] = true;
	}
	
	SetVehicleParams( vehicleid );
	
	return 1;
}

CMD:boot( playerid )
{
	if( !IsPlayerInAnyVehicle( playerid ) )
		return SendClient:( playerid, C_WHITE, !PLAYER_NEED_VEHICLE );
	
	if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
		return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� �� ������������ �����." );
	
	new 
		vehicleid = GetPlayerVehicleID( playerid );
		
	if( !GetVehicleBag( GetVehicleModel( vehicleid ) ) )
		return SendClient:( playerid, C_WHITE, !""gbError"� ������� ���������� ����������� ��������." );
	
	CheckVehicleParams( vehicleid );
	
	if( Vehicle[vehicleid][vehicle_state_boot] ) 
	{
		Vehicle[vehicleid][vehicle_state_boot] = false;
	}
	else 
	{
		Vehicle[vehicleid][vehicle_state_boot] = true;
	}
	
	SetVehicleParams( vehicleid );
	
	return 1;
}

CMD:window( playerid, params[] )
{
	if( !IsPlayerInAnyVehicle( playerid ) )
		return SendClient:( playerid, C_WHITE, !PLAYER_NEED_VEHICLE );
	
	new
		vehicleid = GetPlayerVehicleID( playerid ),
		seat = GetPlayerVehicleSeat( playerid );
		
	if( !vehicleid || seat == 128 || seat > 3 )
		return 1;
	
	if( isnull( params ) )
	{
		if( !Vehicle[vehicleid][vehicle_state_window][seat] )
		{
			Vehicle[vehicleid][vehicle_state_window][seat] = true;
		}
		else
		{
			Vehicle[vehicleid][vehicle_state_window][seat] = false;
		}
	}
	else if( !isnull( params ) && seat == 0 )
	{
		if( !strcmp( params, "l", true ) )
		{
			if( !Vehicle[vehicleid][vehicle_state_window][0] )
			{
				Vehicle[vehicleid][vehicle_state_window][0] = true;
			}
			else
			{
				Vehicle[vehicleid][vehicle_state_window][0] = false;
			}
		}
		else if( !strcmp( params, "r", true ) )
		{
			if( !Vehicle[vehicleid][vehicle_state_window][1] )
			{
				Vehicle[vehicleid][vehicle_state_window][1] = true;
			}
			else
			{
				Vehicle[vehicleid][vehicle_state_window][1] = false;
			}
		}
		else if( !strcmp( params, "rl", true ) )
		{
			if( !Vehicle[vehicleid][vehicle_state_window][2] )
			{
				Vehicle[vehicleid][vehicle_state_window][2] = true;
			}
			else
			{
				Vehicle[vehicleid][vehicle_state_window][2] = false;
			}
			
		}
		else if( !strcmp( params, "rr", true ) )
		{
			if( !Vehicle[vehicleid][vehicle_state_window][3] )
			{
				Vehicle[vehicleid][vehicle_state_window][3] = true;
			}
			else
			{
				Vehicle[vehicleid][vehicle_state_window][3] = false;
			}
		}
		else
		{
			return SendClient:( playerid, C_WHITE, ""gbDefault"�������: /window [ l - �������� ����� | r - �������� ������ | rl - ������ ����� | rr - ������ ������ ]" );
		}

	}
	
	SetVehicleParams( vehicleid );
	
	return 1;
}

CMD:cpanel( playerid ) 
{
	if( IsPlayerInAnyVehicle( playerid ) && Vehicle[GetPlayerVehicleID(playerid)][vehicle_user_id] != Player[playerid][uID] )
		return ShowVehicleInformation( playerid, GetPlayerVehicleID(playerid), INVALID_DIALOG_ID, "�������", "" );
	
	if( !IsOwnerVehicleCount( playerid ) )
		return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ������� ����������." );
		
	g_player_interaction{playerid} = 1;
	ShowPlayerVehicleList( playerid, d_cars );
	
	return 1;
}