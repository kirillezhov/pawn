
function Fire_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	//Тушение пожара
	if( HOLDING(KEY_FIRE) && Player[playerid][uMember] == FRACTION_FIRE && IsPlayerInDynamicArea( playerid, FIRE_ZONE ) && !GetPVarInt( playerid, "Fire:Status" ) )
	{
		if( !IsPlayerInAnyVehicle( playerid ) )
		{
			if( GetPlayerSkin( playerid ) != 277 && GetPlayerSkin( playerid ) != 278 && GetPlayerSkin( playerid ) != 279 ) return 1;
			
			if( GetPlayerWeapon( playerid ) != 42 ) return 1;

			for( new i; i < MAX_IGNITION; i++ )
			{
				if( Fire[i][f_status] )
				{
					if( !IsPlayerInRangeOfPoint( playerid, 4.0, Fire[i][f_pos][0], Fire[i][f_pos][1], Fire[i][f_pos][2] ) ) continue;
				
					SetPVarInt( playerid, "Fire:Status", 1 );
					SetPVarInt( playerid, "Fire:Index", i );
					
					break;
				}
			}
		}
		else if( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
		{		
			if( GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 407 && GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 601 ) return 1;
			
			for( new i; i < MAX_IGNITION; i++ )
			{
				if( Fire[i][f_status] )
				{
					SetPVarInt( playerid, "Fire:Status", 1 );
					SetPVarInt( playerid, "Fire:Index", i );
					
					break;
				}
			}
		}
	}
	
	if( RELEASED(KEY_FIRE) && GetPVarInt( playerid, "Fire:Status" ) )
	{
		DeletePVar( playerid, "Fire:Status" );
		DeletePVar( playerid, "Fire:Index" );
	}
	
	if( PRESSED(KEY_WALK) )
	{
		if( GetPlayerVirtualWorld( playerid ) == 90 || GetPlayerVirtualWorld( playerid ) == 89 || GetPlayerVirtualWorld( playerid ) == 89 )
		{
			for( new i; i < sizeof shower; i++ )
			{
				if( IsPlayerInRangeOfPoint( playerid, 1.0, shower[i][s_player_pos][0], shower[i][s_player_pos][1], shower[i][s_player_pos][2] ) ) 
				{
					if( IsValidDynamicObject( shower_object[i] ) )
					{
						DestroyDynamicObject( shower_object[i] );
						shower_object[i] = 0;
					}
					else
					{
						shower_object[i] = CreateDynamicObject( shower[i][s_object], shower[i][s_pos][0], shower[i][s_pos][1], shower[i][s_pos][2], shower[i][s_pos][3], shower[i][s_pos][4], shower[i][s_pos][5], GetPlayerVirtualWorld( playerid ), 1, -1 );
					}
					
					break;
				}
			}
		}
	}
	
	return 1;
}

stock CreateFire( ignition, Float:X, Float:Y, Float:Z, world, interior )
{
	Fire[ignition][f_status] = true;
	Fire[ignition][f_object][0] = CreateDynamicObject( 18691, X, Y, Z, 0.0, 0.0, 0.0, world, interior, -1, 250.0, 250.0 );
	
	if( random(2) )
		Fire[ignition][f_object][1] = CreateDynamicObject( 18726, X, Y, Z, 0.0, 0.0, 0.0, world, interior, -1, 250.0, 250.0 );
	
	Fire[ignition][f_extinction] = randomize( 20, 30 );
	Fire[ignition][f_zone] = CreateDynamicCircle( X, Y, 1.0, world, interior, -1 );
	
	Fire[ignition][f_pos][0] = X;
	Fire[ignition][f_pos][1] = Y;
	Fire[ignition][f_pos][2] = Z;

	FIRE_AMOUNT++;
		
	return 1;
}

function OnTimerFire()
{
	new
		fire = randomize( 1, 5 ),
		seconds = randomize( 3, 8 ) * 60000,
		
		index = FIRE_AMOUNT + randomize( 1, fire ) - 1,
		amount = FIRE_AMOUNT;

	for( new i = FIRE_AMOUNT; i < fire + amount; i++ )
	{
		if( !Fire[i][f_status] )
		{
			CreateFire( i, GetSVarFloat( "Fire:X" ) + new_fire_pos[i - amount][0], GetSVarFloat( "Fire:Y" ) + new_fire_pos[i - amount][1], GetSVarFloat( "Fire:Z" ), GetSVarInt( "Fire:World" ), GetSVarInt( "Fire:Interior" ) );
		
			if( FIRE_AMOUNT == MAX_IGNITION ) return 1;
		}
	}
	
	SetSVarFloat( "Fire:X", Fire[index][f_pos][0] );
	SetSVarFloat( "Fire:Y", Fire[index][f_pos][1] );
	
	FIRE_TIMER = SetTimer( "OnTimerFire", seconds, 0 );

	return 1;
}

function Fire_OnPlayerEnterDynamicArea( playerid, areaid ) 
{
	if( areaid == FIRE_ZONE )
	{
		if( !IsPlayerInAnyVehicle( playerid ) )
		{
			if( GetPlayerSkin( playerid ) != 277 && GetPlayerSkin( playerid ) != 278 && GetPlayerSkin( playerid ) != 279 )
				UseAnim( playerid, "PED", "gas_cwr", 4.1, 1, 1, 1, 1, 1 );
		}
		else if( GetPVarInt( playerid, "Fire:Water" ) )
		{
			new
				count,
				ready = randomize( 5, 10 );
			
			for( new i; i < MAX_IGNITION; i++ )
			{
				if( Fire[i][f_status] )
				{
					for( new j; j < 2; j++ )
					{
						if( IsValidDynamicObject( Fire[i][f_object][j] ) )
						{
							DestroyDynamicObject( Fire[i][f_object][j] );
							Fire[i][f_object][j] = 0;
						}
					}
					
					if( IsValidDynamicArea( Fire[i][f_zone] ) ) DestroyDynamicArea( Fire[i][f_zone] );

					Fire[i][f_zone] = 
					Fire[i][f_extinction] = 0;
						
					Fire[i][f_status] = false;
						
					Fire[i][f_pos][0] = 
					Fire[i][f_pos][1] = 
					Fire[i][f_pos][2] = 0.0;
		
					FIRE_AMOUNT--;
					count++;
						
					if( count == ready ) break;
				}
			}
			
			pformat:( ""gbSuccess"Потушено очагов возгорания: "cBLUE"%d", count );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Fire:Water" );
			
			if( !FIRE_AMOUNT )
			{
				KillTimer( FIRE_TIMER );
				if( IsValidDynamicArea( FIRE_ZONE ) ) DestroyDynamicArea( FIRE_ZONE );
							
				FIRE_ZONE =
				FIRE_TIMER = 0;
						
				DeleteSVar( "Fire:X" );
				DeleteSVar( "Fire:Y" );
				DeleteSVar( "Fire:Z" );
									
				DeleteSVar( "Fire:World" );
				DeleteSVar( "Fire:Interior" );
			}
		}
	}
	
	for( new i; i < MAX_IGNITION; i++ )
	{
		if( areaid == Fire[i][f_zone] && !IsPlayerInAnyVehicle( playerid ) )
		{
			GivePlayerDamage( playerid, float( randomize( 10, 90 ) ), randomize( 3, 9 ), FIRE_BURN );
			break;
		}
	}

	return 1;
}

function Fire_OnPlayerLeaveDynamicArea( playerid, areaid ) 
{
	if( areaid == FIRE_ZONE )
	{
		ClearAnimations( playerid );
		DeletePVar( playerid, "Fire:Water" );
	}
	
	return 1;
}

FireTimer( playerid )
{
	if( GetPVarInt( playerid, "Fire:Status" ) )
	{
		new
			index = GetPVarInt( playerid, "Fire:Index" );
		
		Fire[GetPVarInt( playerid, "Fire:Index" )][f_extinction]--;
	
		if( Fire[index][f_extinction] <= 0 )
		{
			for( new j; j < 2; j++ )
			{
				if( IsValidDynamicObject( Fire[index][f_object][j] ) )
				{
					DestroyDynamicObject( Fire[index][f_object][j] );
					Fire[index][f_object][j] = 0;
				}
			}

			if( IsValidDynamicArea( Fire[index][f_zone] ) ) DestroyDynamicArea( Fire[index][f_zone] );

			Fire[index][f_zone] = 
			Fire[index][f_extinction] = 0;
			
			Fire[index][f_status] = false;
			
			Fire[index][f_pos][0] = 
			Fire[index][f_pos][1] = 
			Fire[index][f_pos][2] = 0.0;
			
			DeletePVar( playerid, "Fire:Status" );
			DeletePVar( playerid, "Fire:Index" );
			
			SendClient:( playerid, C_WHITE, !""gbSuccess"Возгорание потушено." );
							
			FIRE_AMOUNT--;
		}

		if( !FIRE_AMOUNT )
		{
			KillTimer( FIRE_TIMER );
			if( IsValidDynamicArea( FIRE_ZONE ) ) DestroyDynamicArea( FIRE_ZONE );
					
			FIRE_ZONE =
			FIRE_TIMER = 0;
					
			DeleteSVar( "Fire:X" );
			DeleteSVar( "Fire:Y" );
			DeleteSVar( "Fire:Z" );
							
			DeleteSVar( "Fire:World" );
			DeleteSVar( "Fire:Interior" );
		}
	}

	return 1;
}

stock InstallWaterToVehicle( vehicleid )
{
	switch( Vehicle[vehicleid][vehicle_model] )
	{
		case 417:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.000, -0.930, -1.499, 0.000, 0.000, 0.000);
		}
		
		case 460:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.000, -0.750, -2.099, 0.000, 0.000, 0.000);
		}
		
		case 497:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.000, 0.000, -1.879, 0.000, 0.000, 0.000);
		}
		
		case 511:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.000, -0.830, -2.749, 0.000, 0.000, 0.000);
		}
		
		case 548:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.060, 0.980, -3.049, 0.000, 0.000, 0.000);
		}
		
		case 553:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.011, -1.760, -2.289, 0.000, 0.000, 0.000);
		}
		
		case 563:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, -0.140, -1.341, -1.989, 0.000, 0.000, 0.000);
		}
		
		case 577:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.000, -10.417, 3.380, 0.000, 0.000, 0.000);
			
			Vehicle[vehicleid][vehicle_water][1] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][1], vehicleid, 0.000, -7.081, 3.370, 0.000, 0.000, 0.000);
			
			Vehicle[vehicleid][vehicle_water][2] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][2], vehicleid, 0.000, -3.570, 3.290, 0.000, 0.000, 0.000);
		}
		
		case 593:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.000, -1.210, -1.559, 0.000, 0.000, 0.000);
		}
		
		case 592:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.000, -7.653, 0.090, 0.000, 0.000, 0.000);
			
			Vehicle[vehicleid][vehicle_water][1] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][1], vehicleid, 0.000, -4.595, 0.060, 0.000, 0.000, 0.000);
			
			Vehicle[vehicleid][vehicle_water][2] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][2], vehicleid, 0.000, -1.274, -0.000, 0.000, 0.000, 0.000);
		}
		
		case 487:
		{
			Vehicle[vehicleid][vehicle_water][0] = CreateDynamicObject(18707,0,0,0,0,0,0, -1, -1, -1, 200.0, 200.0);
			AttachDynamicObjectToVehicle(Vehicle[vehicleid][vehicle_water][0], vehicleid, 0.000, 0.000, -1.879, 0.000, 0.000, 0.000);
		}
		
		default: return 0;
	}

	return 1;
}

stock getVehicleLukeType( model )
{
	switch( model )
	{
		case 417, 425, 487, 563, 519, 577, 553: return 1;
		case 592: return 2;
		case 548: return 3;
	}
	
	return 0;
}

PlayerExitHelicopterInt( playerid )
{
	    
	new
	    vehicleid = GetPVarInt( playerid, "Luke:VehicleID" ),
		myvehid;
		
	if( !Vehicle[vehicleid][vehicle_luke] )
	    return 0;
		
	if( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
		myvehid = GetPlayerVehicleID( playerid );

	new 
		Float: x,
		Float: y,
		Float: z,
		Float: angle;
			
	GetVehiclePos( vehicleid, x, y, z );
	GetVehicleZAngle( vehicleid, angle );
	
	if( !myvehid )
	{
		x -= ( 10.0 * ( floatsin( -angle, degrees ) ) );
		y -= ( 10.0 * ( floatcos( -angle, degrees ) ) );
		
		setPlayerPos( playerid, x, y, z );
		SetPlayerFacingAngle( playerid, angle - 180 );
	}
	else
	{
		x -= ( 15.0 * ( floatsin( -angle, degrees ) ) );
		y -= ( 15.0 * ( floatcos( -angle, degrees ) ) );
		
		setVehiclePos( myvehid, x, y, z );
		SetVehicleZAngle( myvehid, angle - 180 );
		SetVehicleVirtualWorld( myvehid, GetVehicleVirtualWorld( vehicleid ) );
		
		foreach(new j : Player)
		{
			if( !IsLogged( j ) || playerid == j )
				continue;
						
			if( IsPlayerInVehicle( j, myvehid ) && GetPlayerState( j ) == 3 )
			{
				SetPlayerVirtualWorld( j, GetVehicleVirtualWorld( vehicleid ) );	
					
				UpdateWeather( j );
				DeletePVar( j, "Luke:VehicleID" );
			}
		}
	}
	
	SetPlayerVirtualWorld( playerid, GetVehicleVirtualWorld( vehicleid ) );
	UpdateWeather( playerid );
	DeletePVar( playerid, "Luke:VehicleID" );
	
	return 1;
}

function OnTimerOxygen( playerid )
{
	//Если использует кислородный баллон
	if( GetPVarInt( playerid, "Fire:Attach" ) )
	{
		setPlayerHealth( playerid, 100.0 );
	}
	
	return 1;
}