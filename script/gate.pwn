Gate_OnGameModeInit()
{
	for(new i; i < sizeof Gate; i ++) 
	{
	    g_gate_id[i] = CreateDynamicObject(Gate[i][g_object],Gate[i][g_begin_pos][0],Gate[i][g_begin_pos][1],Gate[i][g_begin_pos][2],Gate[i][g_begin_pos][3],Gate[i][g_begin_pos][4],Gate[i][g_begin_pos][5]);
	
		switch( Gate[i][g_object] )
		{
			case 6400: SetDynamicObjectMaterial(g_gate_id[i], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
			case 19906: SetDynamicObjectMaterial( g_gate_id[i], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0xFFFFFFFF );
			case 968:
			{
				SetDynamicObjectMaterial(g_gate_id[i], 1, 18886, "electromagnet1", "hazardtile13-128x128", 0x00000000); 
				SetDynamicObjectMaterial(g_gate_id[i], 2, 18886, "electromagnet1", "hazardtile13-128x128", 0x00000000);
			}
			case 19911: SetDynamicObjectMaterial(g_gate_id[i], 0, 13761, "lahills_whisky", "lasviper6", 0xFFFFFFFF);
			default: continue;
		}
	}
	
	return 1;
}

function Gate_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED(KEY_CROUCH) && Player[playerid][uMember] && IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
	{
		for( new i; i < sizeof Gate; i ++ )
		{
			if( IsPlayerInRangeOfPoint( playerid, 10.0, Gate[i][g_begin_pos][0], Gate[i][g_begin_pos][1], Gate[i][g_begin_pos][2]) ) 
			{
				if( Gate[i][g_frac] != Player[playerid][uMember] && Gate[i][g_frac] ) return 1;
			
				//if( Vehicle[GetPlayerVehicleID( playerid )][vehicle_member] != Gate[i][g_frac] && Gate[i][g_frac] ) return 1;
	
				switch( g_gate_status{i} )
				{
					case false: SetGateState( true, i );
					case true: SetGateState( false, i );
				}
					
				PlayerPlaySoundEx( playerid, 1153 );
					
				break;
			}
		}
	}
	
	if( PRESSED(KEY_CTRL_BACK) && Player[playerid][uMember] && !IsPlayerInAnyVehicle( playerid ) )
	{
		for( new i; i < sizeof Gate; i ++ )
		{
			if( IsPlayerInRangeOfPoint( playerid, 4.5, Gate[i][g_begin_pos][0], Gate[i][g_begin_pos][1], Gate[i][g_begin_pos][2]) ) 
			{
				if( Gate[i][g_frac] != Player[playerid][uMember] && Gate[i][g_frac] ) return 1;
			
				switch( g_gate_status{i} )
				{
					case false: SetGateState( true, i );	
					case true: SetGateState( false, i );	
				}
				
				PlayerPlaySoundEx( playerid, 1153 );
				
				break;
			}
		}
	}
	
	return 1;
}

SetGateState( bool: open, i )
{
	new
		Float:speed,
		Float:angle;
		
	switch( Gate[i][g_object] )
	{
		case 985, 986: 
		{
			speed = 0.1;
		}
		
		case 968: 
		{
			speed = 0.05;
			angle = 0.05;
		}
		
		default: 
		{
			speed = 0.5;
		}
	}

	if( !open )
	{
		
		MoveDynamicObject(g_gate_id[i], Gate[i][g_begin_pos][0], Gate[i][g_begin_pos][1], Gate[i][g_begin_pos][2] + angle, speed, Gate[i][g_begin_pos][3], Gate[i][g_begin_pos][4], Gate[i][g_begin_pos][5] );
		
		g_gate_status{i} = false;
	}
	else
	{
		MoveDynamicObject(g_gate_id[i], Gate[i][g_end_pos][0], Gate[i][g_end_pos][1], Gate[i][g_end_pos][2] - angle, speed, Gate[i][g_end_pos][3], Gate[i][g_end_pos][4], Gate[i][g_end_pos][5] );
		
		g_gate_status{i} = true;
	}
}