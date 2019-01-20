CMD:hood( playerid )
{
	if( !IsPlayerInAnyVehicle( playerid ) )
		return SendClient:( playerid, C_WHITE, !PLAYER_NEED_VEHICLE );
		
	if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
		return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться на водительском месте." );
	
	new 
		vehicleid = GetPlayerVehicleID( playerid );
		
	if( !VehicleInfo[GetVehicleModel( vehicleid ) - 400][v_hood] )
		return SendClient:( playerid, C_WHITE, !""gbError"У данного транспорта отсутствует капот." );
	
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
		return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться на водительском месте." );
	
	new 
		vehicleid = GetPlayerVehicleID( playerid );
		
	if( !GetVehicleBag( GetVehicleModel( vehicleid ) ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У данного транспорта отсутствует багажник." );
	
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
			return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /window [ l - переднее левое | r - переднее правое | rl - заднее левое | rr - заднее правое ]" );
		}

	}
	
	SetVehicleParams( vehicleid );
	
	return 1;
}

CMD:cpanel( playerid ) 
{
	if( IsPlayerInAnyVehicle( playerid ) && Vehicle[GetPlayerVehicleID(playerid)][vehicle_user_id] != Player[playerid][uID] )
		return ShowVehicleInformation( playerid, GetPlayerVehicleID(playerid), INVALID_DIALOG_ID, "Закрыть", "" );
	
	if( !IsOwnerVehicleCount( playerid ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет личного транспорта." );
		
	g_player_interaction{playerid} = 1;
	ShowPlayerVehicleList( playerid, d_cars );
	
	return 1;
}