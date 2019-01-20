
new const 
	Float: hotel_spawn_random[][] = 
	{
		{ 1470.9451, -1176.7994, 23.9379, 53.8867 },
		{ 1512.9850, -1178.1942, 24.0714, 3.7528 },
		{ 1502.1064, -1187.4799, 23.9358, 298.8922 },
		{ 1524.2852, -1186.8789, 23.9271, 74.3750 }
	};

function GetSpawnInfo( playerid, &Float:x, &Float:y, &Float:z, &Float:root ) 
{
	new 
		bool:spawned = true;
	
	if( Player[playerid][uDeath] && spawned ) 
	{
		/*x = Player[playerid][uP][0];
		y = Player[playerid][uP][1];
		z = Player[playerid][uP][2];
		
		death_pos[ playerid ][ d_pos_x ] = x;
		death_pos[ playerid ][ d_pos_y ] = y;
		death_pos[ playerid ][ d_pos_z ] = z;
		death_pos[ playerid ][ d_world ] = Player[ playerid ][uInt][0];
		death_pos[ playerid ][ d_int ] = Player[ playerid ][uInt][1];
		
		SetPlayerInterior( playerid, Player[playerid][uInt][0] );
		SetPlayerVirtualWorld( playerid, Player[playerid][uInt][1] );*/
		
		new 
			rand = random( sizeof spawnHospital );
		
		x = spawnHospital[rand][0];
		y = spawnHospital[rand][1];
		z = spawnHospital[rand][2];
		root = spawnHospital[rand][3];
		
		SetPlayerInterior( playerid, 1 );
		SetPlayerVirtualWorld( playerid, 63 );
		
		togglePlayerControllable( playerid, true );
		spawned = false;
	}

	if( Prison[playerid][p_date] && !Prison[playerid][p_dateudo] ) 
	{
		if( Prison[playerid][p_cooler] ) 
		{
			x = pr_cooler[ Prison[playerid][p_cooler] - 1 ][0],
			y = pr_cooler[ Prison[playerid][p_cooler] - 1 ][1],
			z = pr_cooler[ Prison[playerid][p_cooler] - 1 ][2];
		}
		else 
		{
			x = pr_camera[ Prison[playerid][p_camera] - 1 ][0],
			y = pr_camera[ Prison[playerid][p_camera] - 1 ][1],
			z = pr_camera[ Prison[playerid][p_camera] - 1 ][2];
		}	
		
		setPrisonWeather( playerid );
		spawned = false;
	}
	
	if( GetPVarInt( playerid, "Passenger:VehicleID" ) != INVALID_VEHICLE_ID 
		&& GetPVarInt( playerid, "Passenger:InVehicle" )
	)
	{
		new
			vehicleid = GetPVarInt( playerid, "Passenger:VehicleID" );

		GetVehiclePos( vehicleid, x, y, z );
		GetVehicleZAngle( vehicleid, root );
		
		x += ( 6.0 * ( floatsin( -root + 90, degrees ) ) );
		y += ( 6.0 * ( floatcos( -root + 90, degrees ) ) );
		root -= 90.0;
		
		Player[playerid][uInt][0] = 0;
		Player[playerid][uInt][1] = GetVehicleVirtualWorld( vehicleid );
		
		spawned = false;
	}
	
	/*if( Player[playerid][uRole] == 2 && !Player[playerid][uArrest] ) 
	{
		setPrisonSpawnLogin( playerid, x, y, z );
		spawned = false;
	}*/
	
	if( Player[playerid][uDMJail] && spawned ) 
	{
		x = 3958.6768, 
		y = -942.3129, 
		z = 3.8427, 
		root = 0.0;
		
		togglePlayerControllable( playerid, true );
		spawned = false;
    }
	
	if( Player[playerid][uJail] && spawned ) 
	{
		x = spawnJail[ Player[playerid][uJail] - 1 ][pos_enter][0],
		y = spawnJail[ Player[playerid][uJail] - 1 ][pos_enter][1],
		z = spawnJail[ Player[playerid][uJail] - 1 ][pos_enter][2];
		root = spawnJail[ Player[playerid][uJail] - 1 ][pos_enter][3];
		
		SetPlayerInterior( playerid, spawnJail[ Player[playerid][uJail] - 1 ][pos_int] );
		SetPlayerVirtualWorld( playerid, spawnJail[ Player[playerid][uJail] - 1 ][pos_world] );
		
		SendClient:( playerid, C_WHITE, !""gbDefault"Вы отбываете свой срок в КПЗ." );
		spawned = false;
	}
	// 900
	if(Player[playerid][uLastTime] + (900) >= gettime() && Player[playerid][uLastTime] != 0 && spawned ) 
	{
		// Игрок перезашёл через 15 минут
		x = Player[playerid][uP][0], 
		y = Player[playerid][uP][1],
		z = Player[playerid][uP][2];
		
		SetPlayerInterior( playerid, Player[playerid][uInt][0] );
		SetPlayerVirtualWorld( playerid, Player[playerid][uInt][1] );
		
		togglePlayerControllable( playerid, true );
		spawned = false;
	}

	if( spawned ) 
	{
		if( Player[playerid][uSettings][1] == 1 ) 
		{
			if( !Player[playerid][uMember] || !Player[playerid][uRank] )
			{
				Player[playerid][uSettings][1] = 0;
			}
			else if( FRank[ Player[playerid][uMember] - 1 ][ getRankId( playerid, Player[playerid][uMember] - 1 ) ][r_spawn][0] == 0.0 )
			{
				Player[playerid][uSettings][1] = 0;
			}
		}
	
		// Класс в настройках
		switch( Player[playerid][uSettings][1] ) 
		{
			// Отель
			case 0: 
			{ 
				new 
					rand = random( sizeof( hotel_spawn_random ) );
						
				x = hotel_spawn_random[rand][0];
				y = hotel_spawn_random[rand][1];
				z = hotel_spawn_random[rand][2];
				root = hotel_spawn_random[rand][3];
				
				Player[playerid][uInt][0] =
				Player[playerid][uInt][1] = 0;
				
				spawned = false;
			}
			// Фракция
			case 1: 
			{
				new 
					fid = Player[playerid][uMember] - 1, 
					rank = getRankId( playerid, fid );
					
				x = FRank[fid][rank][r_spawn][0];
				y = FRank[fid][rank][r_spawn][1];
				z = FRank[fid][rank][r_spawn][2];
				root = FRank[fid][rank][r_spawn][3];
					
				Player[playerid][uInt][1] = FRank[fid][rank][r_world][0];
				Player[playerid][uInt][0] = FRank[fid][rank][r_world][1];
					
				spawned = false;
			}
			//Дом
			case 2: 
			{
				if( Player[playerid][tHouse][0] != INVALID_PARAM ) 
				{
					new
						h = Player[playerid][tHouse][0];
						
					x = HouseInfo[h][hExitPos][0],
					y = HouseInfo[h][hExitPos][1],
					z = HouseInfo[h][hExitPos][2],
					root = HouseInfo[h][hExitPos][3];
						
					Player[playerid][uInt][0] = 1;
					Player[playerid][uInt][1] = HouseInfo[h][hID];
						
					setHouseWeather( playerid );
						
					spawned = false;
				}
				else if( Player[playerid][uHouseEvict] )
				{
					for( new h; h < MAX_HOUSE; h++ )
					{
						if( HouseInfo[h][hID] == Player[playerid][uHouseEvict] )
						{
							x = HouseInfo[h][hExitPos][0],
							y = HouseInfo[h][hExitPos][1],
							z = HouseInfo[h][hExitPos][2],
							root = 0.0;
								
							Player[playerid][uInt][0] = 1;
							Player[playerid][uInt][1] = HouseInfo[h][hID];
								
							setHouseWeather( playerid );
								
							spawned = false;
						
							break;
						}
					}
				}
				else
				{
					new 
						rand = random( sizeof( hotel_spawn_random ) );
						
					x = hotel_spawn_random[rand][0];
					y = hotel_spawn_random[rand][1];
					z = hotel_spawn_random[rand][2];
					root = hotel_spawn_random[rand][3];
					
					Player[playerid][uInt][0] = 
					Player[playerid][uInt][1] = 0;
					
					SendClient:( playerid, C_WHITE, !""gbDefault"Возможно Вас выселили из дома или дом, в котором Вы жили, был продан.");
					
					format:g_small_string( "%d|%d|%d|%d|%d|%d|%d|%d",Player[playerid][uSettings][0],Player[playerid][uSettings][1],Player[playerid][uSettings][2],
					Player[playerid][uSettings][3],Player[playerid][uSettings][4],Player[playerid][uSettings][5],Player[playerid][uSettings][6],Player[playerid][uSettings][7]);

					UpdatePlayerString( playerid, "uSettings", g_small_string );
					
					spawned = false;
				}	
			}
			// Там где вышел
			case 3: 
			{
				x = Player[playerid][uP][0], 
				y = Player[playerid][uP][1],
				z = Player[playerid][uP][2];
				
				spawned = false;
			}
		}
		
		SetPlayerInterior( playerid, Player[playerid][uInt][0] );
		SetPlayerVirtualWorld( playerid, Player[playerid][uInt][1] );
		
		togglePlayerControllable( playerid, true );
	}
	
	if( spawned ) 
	{
		new 
			rand = random( sizeof( hotel_spawn_random ) );
	
		x = hotel_spawn_random[rand][0];
		y = hotel_spawn_random[rand][1];
		z = hotel_spawn_random[rand][2];
		root = hotel_spawn_random[rand][3];
		
		Player[playerid][uInt][0] =
		Player[playerid][uInt][1] = 0;
	}
	
	if( GetPlayerVirtualWorld( playerid ) )
	{
		SetPVarInt( playerid, "User:inInt", 1 );
		UpdateWeather( playerid );
	}
	
	Player[playerid][tPos][0] = x;
	Player[playerid][tPos][1] = y;
	Player[playerid][tPos][2] = z;
	
	return 1;
}