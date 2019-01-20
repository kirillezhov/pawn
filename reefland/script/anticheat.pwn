function AntiCheat_OnGameModeInit()
{
	print( "[R-AC]: Successful loaded on the server. Version: "GGAME_VERSION_AC"." );
	return 1;
}

function AntiCheat_OnPlayerStateChange( playerid, newstate, oldstate )
{
	if( GetAccessAdmin( playerid, ANTICHEAT_MIN_ADMIN_LEVEL ) )
		return 1;
		
	if( newstate == PLAYER_STATE_SPECTATING )
	{
		if( !Player[playerid][tSpectate] )
		{
			CheatDetected( playerid, "Spectate", CHEAT_SPECTATE, 2 );
		}
	}
	
	else if( newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER )
	{
		if( Player[playerid][tEnterVehicle] != GetPlayerVehicleID( playerid ) )
		{
			Player[playerid][tEnterVehicle] = INVALID_VEHICLE_ID;
			return CheatDetected( playerid, "Teleport in car", CHEAT_TP_IN_CAR, 2 );
		}
		
		Player[playerid][tEnterVehicle] = GetPlayerVehicleID( playerid );
	}
	
	else if( newstate == PLAYER_STATE_ONFOOT )
	{
		if( Player[playerid][tEnterVehicle] != INVALID_VEHICLE_ID )
		{
			Player[playerid][tEnterVehicle] = INVALID_VEHICLE_ID;
		}
	}
	
	return 1;
}

AntiCheat_OnPlayerExitVehicle( playerid, vehicleid )
{
	GetPlayerPos( 
		playerid, 
		Player[playerid][tPos][0], 
		Player[playerid][tPos][1], 
		Player[playerid][tPos][2] 
	);
	
	g_player_airbreak_protect{playerid} = ANTICHEAT_EXCEPTION_TIME;
	g_player_carshot{playerid} = ANTICHEAT_EXCEPTION_CARSHOT;
	
	if( Player[playerid][tEnterVehicle] == vehicleid )
	{
		g_player_tp_in_car{playerid} = 3;
		
		Player[playerid][tEnterVehicle] = INVALID_VEHICLE_ID;
	}
	
	return 1;
}

function AntiCheat_OnPlayerEnterVehicle( playerid, vehicleid, ispassenger )
{
	Player[playerid][tEnterVehicle] = vehicleid;
	
	g_player_carshot{playerid} = ANTICHEAT_EXCEPTION_CARSHOT;
	
	return 1;
}

SuspectDetected( playerid, cheat[], code, suspect = 3, permanent_suspect = false ) 
{
	new
	    server_tick = GetTickCount();

	if( GetPVarInt( playerid, "AntiCheat:SuspectDetected" ) > server_tick )
		return 0;
		
	SetPVarInt( playerid, "AntiCheat:SuspectDetected", server_tick + 4000 );

	if( GetPVarInt( playerid, "AntiCheat:Suspect" ) == suspect && !permanent_suspect ) 
	{
		CheatDetected( playerid, cheat, code );
		SetPVarInt( playerid, "AntiCheat:Suspect", 0 );
		return 0;
	} 
	else 
	{
		if( !permanent_suspect )
		{
			SetPVarInt( playerid, "AntiCheat:Suspect", GetPVarInt( playerid, "AntiCheat:Suspect" ) + 1 );
		}
		
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] подозревается в читерстве. (%s | #%d)",
			GetAccountName(playerid),
			playerid,
			cheat,
			code
		);
		
		printf( ""ADMIN_PREFIX" %s[%d] подозревается в читерстве. (%s | #%d)",
			GetAccountName(playerid),
			playerid,
			cheat,
			code
		);

		SendAdminMessage( C_RED, g_small_string );

		clean_array();
	}
	return 1;
}

CheatDetected( playerid, reason[], code, type = 1 ) 
{
	#if defined DEBUG
		#error Debug AntiCheat Detected
	#endif
	
	if( type == 1 ) //Кик
	{
		format:g_small_string( "Кик %s[%d] (%s | #%d)",
			Player[playerid][uName],
			playerid,
			reason,
			code
		);
		
		SendAdminMessage( C_DARKGRAY, g_small_string );
	}
	else if ( type == 2 ) //Бан
	{
		format:g_small_string( ""ADMIN_PREFIX" %s[%d] кикнут R-AC. Причина: %s #%d - IP: %s",
			GetAccountName( playerid ),
			playerid,
			reason,
			code,
			Player[playerid][tIP]
		);
		
		SendAdmin:( C_DARKGRAY, g_small_string );
		
		gbMessageKick( playerid, reason, code, _, false );
	}
	    
	aclog( type, playerid, code, reason );
	
	return 1;
}

stock AntiCheatTimer( playerid )
{
	if( GetAccessAdmin( playerid, ANTICHEAT_MIN_ADMIN_LEVEL ) )
		return 1;
		
	// AntiCheat - JetPack
	if(	GetPlayerSpecialAction( playerid ) == SPECIAL_ACTION_USEJETPACK )
	{
		CheatDetected( playerid, "JetPack", CHEAT_JETPACK, 2 );
	}
	// AntiCheat - JetPack - End
	
	// AntiCheat - Spectate
	
	/*if( GetPlayerState( playerid ) == PLAYER_STATE_SPECTATING && !Player[playerid][tSpectate] )
	{
		CheatDetected( playerid, "Spectate", CHEAT_SPECTATE, 2 );
	}*/
	
	// AntiCheat - SpeedHack
	
	new 
		vehicleid = GetPlayerVehicleID( playerid );
	
	if( IsPlayerInAnyVehicle( playerid ) )
	{
		if( GetVehicleSpeed( vehicleid ) > GetVehicleMaxAcSpeed( GetVehicleModel( vehicleid ) ) )
		{
			new 
				string[ 30 ];
				
			format( string, sizeof( string ), "SpeedHack - %d/%d", 
				GetVehicleSpeed( vehicleid ), 
				GetVehicleMaxAcSpeed( GetVehicleModel( vehicleid ) )
			);
			
			SuspectDetected( playerid, string, CHEAT_SPEEDHACK, 5 ); 
		}
	}
	
	if( IsPlayerInAnyVehicle( playerid ) && GetVehicleSpeed( vehicleid ) > 190 )
	{
		CheatDetected( playerid, "SpeedHack", CHEAT_SPEEDHACK, 2 );
	}
	
	// AntiCheat - SpeedHack - End
	
	// AntiCheat - P.Rvanka
	
	new
		Float: x_velocity,
		Float: y_velocity,
		Float: z_velocity;
	
	GetPlayerVelocity( playerid, x_velocity, y_velocity, z_velocity );
	
	if( floatabs( x_velocity ) > 2.0 || floatabs( y_velocity ) > 2.0 )
	{
		CheatDetected( playerid, "P. Rvanka", CHEAT_P_RVANKA, 2 );
	}
	
	// AntiCheat - P.Rvanka - End
	
	// AntiCheat - AirBreak
		
	if( !g_player_airbreak_protect{playerid} )
	{
		new
			Float: distance = GetPlayerDistanceFromPoint( playerid, 
				Player[playerid][tPos][0], 
				Player[playerid][tPos][1], 
				Player[playerid][tPos][2] ),
			//surf = GetPlayerSurfingVehicleID( playerid ),
			Float:X_pos,
			Float:Y_pos,
			Float:Z_pos;
		
		GetPlayerPos( playerid, X_pos, Y_pos, Z_pos );
		
		/*if( GetPlayerState( playerid ) == PLAYER_STATE_ONFOOT )
		{
			if( distance > 50.0 && distance < 65.0 && !IsAfk( playerid ) && surf == INVALID_VEHICLE_ID )
			{
				SuspectDetected( playerid, "AirBreak/Fly", CHEAT_AIRBREAK, 5 );
			}
			else if( distance > 65.0 && !IsAfk( playerid ) && surf == INVALID_VEHICLE_ID )
			{
				CheatDetected( playerid, "AirBreak/Fly", CHEAT_AIRBREAK, 2 );
			}
		}*/
		
		if( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER || GetPlayerState( playerid ) == PLAYER_STATE_PASSENGER )
		{
			if( !acGetVehicleSpeed( GetPlayerVehicleID( playerid ) ) )
			{
				if( 40.0 < distance < 90.0 )
				{
					SuspectDetected( playerid, "AirBreak Car", CHEAT_AIRBREAK_CAR, 5 );
				}
				else if( distance > 90.0 )
				{
					CheatDetected( playerid, "AirBreak Car", CHEAT_AIRBREAK_CAR, 2 );
				}
			}
		}
		
		Player[playerid][tPos][0] = X_pos,
		Player[playerid][tPos][1] = Y_pos,
		Player[playerid][tPos][2] = Z_pos;
	}
	
	if( g_player_airbreak_protect{playerid} > 0 )
		g_player_airbreak_protect{playerid}--;
		
	if( g_player_carshot{playerid} > 0 )
		g_player_carshot{playerid}--;
		
	if( g_player_tp_in_car{playerid} > 0 )
		g_player_tp_in_car{playerid}--;
	
	// AntiCheat - AirBreak - End
	
	// AntiCheat - Teleport in Vehicle
	   
	/*if( IsPlayerInAnyVehicle( playerid ) && !g_player_tp_in_car{playerid} )
	{
		if( Player[playerid][tEnterVehicle] != GetPlayerVehicleID( playerid ) || Player[playerid][tEnterVehicle] == INVALID_VEHICLE_ID )
		{
			CheatDetected( playerid, "Teleport in car", CHEAT_TP_IN_CAR, 2 );
		}
	}*/
	
	// AntiCheat - Teleport in Vehicle - End
	
	// AntiCheat - Heal Car
	
	if( IsPlayerInAnyVehicle( playerid ) )
	{
		new
			car = GetPlayerVehicleID( playerid ),
			Float:car_health;
			
		GetVehicleHealth( car, car_health );
		
		if( car_health > Vehicle[car][vehicle_health] )
		{
			setVehicleHealth( car, Vehicle[car][vehicle_health] );
			CheatDetected( playerid, "Car Heal", CHEAT_CARHEAL, 2 );
		}
		else if( car_health < Vehicle[car][vehicle_health] )
		{
			Vehicle[car][vehicle_health] = car_health;
		}
	}
	
	// AntiCheat - Gun
	
	if( !g_player_gun_protect{playerid} && !OnAntiCheatWeapon( playerid ) )
	{
		if( Player[playerid][uMember] )
		{
			SuspectDetected( playerid, "DGun", CHEAT_GUN, 2 );
		}
		else
		{
			CheatDetected( playerid, "DGun", CHEAT_GUN, 2 ); 
		}
	}
	
	if( g_player_gun_protect{playerid} > 0 )
		g_player_gun_protect{playerid}--;
		
	// AntiCheat - Gun - End
	
	// AntiCheat - HP / Armour
	
	
	if( !g_player_hp_protect{playerid} )
	{
		new 
			Float: health;
			
		GetPlayerHealth( playerid, health );
		
		if( _: Player[playerid][uHP] != _: health )
		{
			if( Player[playerid][uHP] < health ) 
			{
				setPlayerHealth( playerid, Player[playerid][uHP] );
				//return CheatDetected( playerid, "HP Refill", CHEAT_REFILL, 2 );
			}
			else if( Player[playerid][uHP] > health )
			{
				setPlayerHealth( playerid, health );
			}
		}
	}
	
	if( g_player_hp_protect{playerid} > 0 )
		g_player_hp_protect{playerid}--;
	
	new
		Float:armour_amount;
		
	GetPlayerArmour( playerid, armour_amount );
	if( floatround( armour_amount ) != 0 )
	{
		if( Player[playerid][uArmor] < armour_amount )
		{
			setPlayerArmour( playerid, Player[playerid][uArmor] );
			//return CheatDetected( playerid, "Armour Refill", CHEAT_REFILL, 2 );
		}
		else
		{
			setPlayerArmour( playerid, armour_amount );
		}
	}
	
	// AntiCheat - HP / Armour - End
	
	return 1;
}

OnAntiCheatWeapon( playerid )
{
	static
		id,
		weapon			[ MAX_WEAPON_SLOT ],
		ammo			[ MAX_WEAPON_SLOT ],
		inv_use_slot	[ MAX_WEAPON_SLOT ] = { 0, ... },
		inv_weapon		[ MAX_WEAPON_SLOT ] = { 0, ... },
		inv_ammo		[ MAX_WEAPON_SLOT ] = { 0, ... },
		slot,
		i = 0;

	slot = 
	id = 0;
	
	for( i = 0; i < MAX_WEAPON_SLOT; i++ )
	{
		inv_weapon[i] = 
		inv_ammo[i] = 
		inv_use_slot[i] = 0;
		
		GetPlayerWeaponData( playerid, i, weapon[i], ammo[i] );
	}
	
	for( i = 0; i < MAX_INVENTORY_USE; i++ )
	{
		if( UseInv[playerid][i][inv_active_type] == 1 )
			continue;
	
		id = getInventoryId( UseInv[playerid][i][inv_id] );

		if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_SMALL_GUN )
		{
			slot = GetPlayerWeaponSlot( inventory[id][i_param_1] );
			
			inv_use_slot[slot] = i;
			inv_weapon[slot] = inventory[id][i_param_1];
			inv_ammo[slot] = UseInv[playerid][i][inv_param_1];
		}
		else if( inventory[id][i_type] == INV_COLD_GUN )
		{
			slot = GetPlayerWeaponSlot( inventory[id][i_param_1] );
			
			inv_use_slot[slot] = i;
			inv_weapon[slot] = inventory[id][i_param_1];
			inv_ammo[slot] = 0;
		}
	}
	
	for( i = 0; i < MAX_WEAPON_SLOT; i++ )
	{
		if( weapon[i] != inv_weapon[i] && weapon[i] )
		{
			return STATUS_ERROR;
		}	
		else if( ammo[i] != inv_ammo[i] && inv_ammo[i] )
		{
			if( ammo[i] < inv_ammo[i] )
			{
				UseInv[playerid][ inv_use_slot[i] ][inv_param_1] = ammo[i];
				return STATUS_OK;
			}
			else
			{
				return STATUS_ERROR;
			}
		}
	}
	
	return STATUS_OK;
}

function AntiCheat_OnPlayerTakeDamage( playerid, issuerid, Float: amount, weaponid, bodypart ) 
{
	if( issuerid != INVALID_PLAYER_ID )
	{
		if( !IsLogged( issuerid ) )
			return gbKick( issuerid );

		if( GetPlayerState( issuerid ) == PLAYER_STATE_DRIVER )
		{
			if( weaponid >= 22 && weaponid <= 38 )
			{
				CheatDetected( issuerid, "Damage Drive-By", CHEAT_DAMAGE_DB, 2 );
			}
		}
		else if( GetPlayerState( issuerid ) == PLAYER_STATE_PASSENGER )
		{
			if( weaponid != 29 && weaponid != 32 && weaponid != 28 )
			{
				CheatDetected( issuerid, "Damage Drive-By", CHEAT_DAMAGE_DB, 2 );
			}
		}
	}

	if( weaponid > 0 && weaponid < 44 && issuerid != INVALID_PLAYER_ID )
	{
		new
			bool:cheat = true,
			id;
			
		if( GetAccessAdmin( playerid, 1 ) ) cheat = false;
			
		for( new i = 0; i < MAX_INVENTORY_USE; i++ )
		{
			if( UseInv[issuerid][i][inv_active_type] == 1 )
				continue;
			
			id = getInventoryId( UseInv[issuerid][i][inv_id] );

			if( inventory[id][i_type] == INV_GUN || inventory[id][i_type] == INV_COLD_GUN || inventory[id][i_type] == INV_SMALL_GUN )
			{
				if( weaponid == inventory[id][i_param_1] )
				{
					cheat = false;
					break;
				}
			}
		}
		
		if( cheat )
		{
			if( !IsLogged( playerid ) )
				gbKick( playerid );
		
			return CheatDetected( issuerid, "DGun", CHEAT_GUN_2, 2 );
		}
	}

	return 1;
}

public OnUnoccupiedVehicleUpdate( vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z )
{
	/*if( passenger_seat != 0 && !g_player_carshot{playerid} )
	{
		return CheatDetected( playerid, "Carshot", CHEAT_CARSHOT, 2 );
	}*/

	new
		model = GetVehicleModel( vehicleid );

	switch( model )
	{
		case 435, 450, 569, 570, 584, 590, 591, 606, 607, 608, 610, 611: return 0;
		
		case 417, 425, 447, 460, 469, 476, 487, 488, 497, 511, 512, 513, 519, 520, 548, 553, 563, 577, 592, 593: 
		{
			if( !getUseItem( playerid, INV_GUN, 46, 1 ) && GetPlayerWeapon( playerid ) == 46 )
				return 0;
		}
	}
	
	new 
		Float: ac_x,
		Float: ac_y,
		Float: ac_z,
		
		Float: distance = GetVehicleDistanceFromPoint( vehicleid, new_x, new_y, new_z );
		
	GetVehiclePos( vehicleid, ac_x, ac_y, ac_z );
	
	if( distance > 16.0 && ac_z > -70 
		&& distance > ac_vehicle_pos[ vehicleid ][ vp_distance ] + ( distance / 2 ) && !GetAccessCommand( playerid, "getherecar" ) )
	{	
		GetVehicleZAngle( vehicleid, ac_vehicle_pos[ vehicleid ][ vp_z_angle ] );
		SetVehicleZAngle( vehicleid, ac_vehicle_pos[ vehicleid ][ vp_z_angle ] );
		setVehiclePos( vehicleid, ac_x, ac_y, ac_z );
		
		return CheatDetected( playerid, "Car Spam", CHEAT_CARSPAM, 2 );
	}
	
	ac_vehicle_pos[ vehicleid ][ vp_distance ] = distance;

	return 1;
}

function AntiCheat_OnVehicleDeath( vehicleid, killerid )
{
	if( killerid != INVALID_PLAYER_ID )
    {
        SetPVarInt( killerid, "AntiCheat:CarSpawn", GetPVarInt( killerid,"AntiCheat:CarSpawn" ) + 1 );
		
        if( GetPVarInt( killerid, "AntiCheat:CarSpawn") > 3 )
        {
			CheatDetected( killerid, "Car Spawn", CHEAT_SPAWN_CAR, 2 );
        }
    }
}

/* - - - - - Slapper - - - - - - */

CMD:slp( playerid, params[] )
{
	SendClient:( playerid, C_WHITE, !""gbError"Данная команда не существует. Для помощи используйте - "cBLUE"Y"cWHITE"." );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] возможно пытается использовать Slapper.", GetAccountName( playerid ), playerid );
	SendAdmin:( C_DARKGRAY, g_small_string );

	return 1;
}

/* - - - - - Спавнер авто - - - - - - */

CMD:scar( playerid, params[] )
{
	SendClient:( playerid, C_WHITE, !""gbError"Данная команда не существует. Для помощи используйте - "cBLUE"Y"cWHITE"." );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] возможно пытается использовать Car Spawner.", GetAccountName( playerid ), playerid );
	SendAdmin:( C_DARKGRAY, g_small_string );

	return 1;
}

CMD:carclear( playerid, params[] )
{
	SendClient:( playerid, C_WHITE, !""gbError"Данная команда не существует. Для помощи используйте - "cBLUE"Y"cWHITE"." );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] возможно пытается использовать Cleo CarTP.", GetAccountName( playerid ), playerid );
	SendAdmin:( C_DARKGRAY, g_small_string );

	return 1;
}

CMD:cartp( playerid, params[] )
{
	SendClient:( playerid, C_WHITE, !""gbError"Данная команда не существует. Для помощи используйте - "cBLUE"Y"cWHITE"." );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] возможно пытается использовать Cleo CarTP.", GetAccountName( playerid ), playerid );
	SendAdmin:( C_DARKGRAY, g_small_string );

	return 1;
}