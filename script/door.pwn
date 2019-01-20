Door_OnGameModeInit()
{
	for(new i; i < sizeof Door; i ++) 
	{
	    d_door_id[i] = CreateDynamicObject(Door[i][d_object],Door[i][d_begin_pos][0],Door[i][d_begin_pos][1],Door[i][d_begin_pos][2],Door[i][d_begin_pos][3],Door[i][d_begin_pos][4], Door[i][d_begin_pos][5] );
	
		switch( Door[i][d_type] )
		{
			case 4: 
			{
				SetDynamicObjectMaterial(d_door_id[i], 0, -1, "none", "none", 0xFFFFFFFF);
				SetDynamicObjectMaterial(d_door_id[i], 1, 3261, "grasshouse", "hoophouse", 0x00000000);
				SetDynamicObjectMaterial(d_door_id[i], 2, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
			}
			case 1:
			{
				SetDynamicObjectMaterial(d_door_id[i], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
				SetDynamicObjectMaterial(d_door_id[i], 1, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
				SetDynamicObjectMaterial(d_door_id[i], 2, 18049, "ammu_twofloor", "gun_ceiling2", 0x00000000);
			}
			case 2:
			{
				SetDynamicObjectMaterial(d_door_id[i], 0, -1, "none", "none", 0xFFFFFFFF); 
				SetDynamicObjectMaterial(d_door_id[i], 1, 16150, "ufo_bar", "des_intufowin", 0x00000000); 
				SetDynamicObjectMaterial(d_door_id[i], 2, 4829, "airport_las", "liftdoorsac256", 0x00000000);
			}
			
			case 3:
			{
				SetDynamicObjectMaterial(d_door_id[i], 1, 18761, "matracing", "metalfence3", 0);
			}
			
			case 5:
			{
				SetDynamicObjectMaterial(d_door_id[i], 1, 4830, "airport2", "sanairtex3", 0);
				SetDynamicObjectMaterial(d_door_id[i], 2, 1560, "7_11_door", "CJ_CHROME2", 0);
			}
			
			case 6:
			{
				SetDynamicObjectMaterial(d_door_id[i], 0, 9514, "711_sfw", "ws_carpark2", 0);
				SetDynamicObjectMaterial(d_door_id[i], 1, 4830, "airport2", "sanairtex3", 0);
			}
			
			default: continue;
		}
	}
	
	return 1;
}

function Door_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED(KEY_SECONDARY_ATTACK) && Player[playerid][uMember] && GetPlayerVirtualWorld( playerid ) )
	{
		for( new i; i < sizeof Door; i ++ )
		{
			if( IsPlayerInRangeOfPoint( playerid, 2.0, Door[i][d_begin_pos][0], Door[i][d_begin_pos][1], Door[i][d_begin_pos][2]) && Player[playerid][uMember] == Door[i][d_fraction] ) 
			{
				switch( d_door_status{i} )
				{
					case false: SetDoorState( true, i );	
					case true: SetDoorState( false, i );	
				}
				
				break;
			}
		}
	}
	
	return 1;
}

SetDoorState( bool: open, i )
{
	new
		Float:speed;
	
	switch( Door[i][d_object] )
	{
		case 19302, 1495, 3089 : speed = 0.5;
		default: speed = 1.0;
	}

	if( !open )
	{
		MoveDynamicObject(d_door_id[i], Door[i][d_begin_pos][0],Door[i][d_begin_pos][1],Door[i][d_begin_pos][2], speed, Door[i][d_begin_pos][3],Door[i][d_begin_pos][4],Door[i][d_begin_pos][5]);
		
		d_door_status{i} = false;
	}
	else
	{
		MoveDynamicObject(d_door_id[i], Door[i][d_end_pos][0],Door[i][d_end_pos][1],Door[i][d_end_pos][2], speed, Door[i][d_end_pos][3],Door[i][d_end_pos][4],Door[i][d_end_pos][5]);
		
		d_door_status{i} = true;
	}
}