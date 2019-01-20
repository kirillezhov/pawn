public OnPlayerUpdate( playerid )
{
	if( GetPVarInt( playerid, "Login:Joined" ) )
		return 1;

    if( !IsLogged( playerid ) )
		return gbKick( playerid );
		
	SetPVarInt( playerid, "Player:Afk", 0 );

	if( GetPlayerMoney( playerid ) != Player[playerid][uMoney] ) 
	{
		ResetPlayerMoney( playerid );
		GivePlayerMoney( playerid, Player[playerid][uMoney] );
	}
		
	if( IsPlayerInAnyVehicle( playerid ) ) //Ограничение на оружие с пассажирского сиденья
	{
	    if( GetPlayerWeapon( playerid ) != 29 && GetPlayerWeapon( playerid ) != 32 && GetPlayerWeapon( playerid ) != 28 )
			SetPlayerArmedWeapon( playerid, 0 );
	}
	
	if( IsPlayerInAnyVehicle( playerid ) ) 
	{
		if( Player[playerid][uSettings][0] == 1) 
		{
			clean:<g_small_string>;
			format:g_small_string( "%d", GetVehicleSpeed( GetPlayerVehicleID( playerid ) ) );
			PlayerTextDrawSetString( playerid, Speed[5][playerid], g_small_string );
		}
		
		if( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER && !IsVelo( GetPlayerVehicleID( playerid ) ) ) 
		{
			foreach(new i : Player) 
			{
  				if( Thorn[i][t_status] == false ) continue;
				
  				if( !IsPlayerInRangeOfPoint( playerid, 3.0, Thorn[i][t_pos][0], Thorn[i][t_pos][1], Thorn[i][t_pos][2] ) ) continue;
					
		        CheckVehicleDamageStatus( GetPlayerVehicleID( playerid ) );
				
				if( !IsBike( GetPlayerVehicleID( playerid ) ) && Vehicle[ GetPlayerVehicleID( playerid ) ][vehicle_damage][3] != 15 )
				{
					Vehicle[ GetPlayerVehicleID( playerid ) ][vehicle_damage][3] = 15;
						
					SetVehicleDamageStatus( GetPlayerVehicleID( playerid ) );
						
					if( GetVehicleSpeed( GetPlayerVehicleID( playerid ) ) > 40.0 ) 
					{
						new 
							Float:angle;
						
						GetVehicleZAngle( GetPlayerVehicleID( playerid ), angle );
						
						switch( random(2) ) 
						{
								case 0: SetVehicleZAngle( GetPlayerVehicleID( playerid ), angle + random(30) );
								case 1: SetVehicleZAngle( GetPlayerVehicleID( playerid ), angle - random(30) );
						}
					}
				}
				else if( IsBike( GetPlayerVehicleID( playerid ) ) && Vehicle[ GetPlayerVehicleID( playerid ) ][vehicle_damage][3] != 3 )
				{
					Vehicle[ GetPlayerVehicleID( playerid ) ][vehicle_damage][3] = 3;
						
					SetVehicleDamageStatus( GetPlayerVehicleID( playerid ) );
						
					if( GetVehicleSpeed( GetPlayerVehicleID( playerid ) ) > 40.0 ) 
					{
						new 
							Float:angle;
						
						GetVehicleZAngle( GetPlayerVehicleID( playerid ), angle );
						
						switch( random(2) ) 
						{
							case 0: SetVehicleZAngle( GetPlayerVehicleID( playerid ), angle + random( 30 ) );
							case 1: SetVehicleZAngle( GetPlayerVehicleID( playerid ), angle - random( 30 ) );
						}
					}
				}
				
				break;
  			}
		}
	}
	
	return 1;
}
	
function OnHourTimer() 
{
	BusinessTimer();
	
	server_weather_type = 0;
	server_weather = server_weather_list[ random( sizeof server_weather_list ) ];
	
	new 
		hour;
	
    gettime( hour, _, _ );
	ghour = hour;
	
	foreach (new playerid : Player) 
	{
		UpdateWeather( playerid );
	}
}
	
function OnMinuteTimer() 
{
	new 
		afk;
	
    foreach (new playerid : Player) 
	{
		//Таймер на ввод и регистрацию
		if( GetPVarInt( playerid, "Join:Timer" ) )
		{
			GivePVarInt( playerid, "Join:Timer", 1 );
			
			if( GetPVarInt( playerid, "Join:Timer" ) == 6 )
			{
				if( IsValidActor( actor_skin[playerid] ) )
				{
					DestroyActor( actor_skin[playerid] );
					actor_skin[playerid] = INVALID_ACTOR_ID;
				}
			
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы кикнуты за превышение времени на авторизацию/регистрацию." );
				gbKick( playerid );
			}
		}
	
		if( !IsLogged( playerid ) || IsKicked( playerid ) ) 
			continue;
			
    	if( Player[playerid][uMute] > 0 )
		{
			Player[playerid][uMute]--;
		}	
    	
		if( Player[playerid][uBMute] > 0 )
		{
			Player[playerid][uBMute]--;
		}
		
		if( Admin[playerid][aHacked] > 0 )
		{
			DeletePercentAdminHack( playerid, 1 );
		}
		
		if( afk > 2400 && !GetAccessAdmin( playerid, 1 ) ) 
		{ 
			gbMessageKick( playerid, "Long AFK" );
			continue;
		}
		
		if( GetPVarInt( playerid, "AntiCheat:Suspect" ) != 0 )
		{
			TakePVarInt( playerid, "AntiCheat:Suspect", 1 );
		}
		
		if( Player[playerid][uPayTime] >= 60 )
		{
			payDay( playerid );
		}
		
		if( !IsAfk( playerid ) )
		{
			Player[playerid][uPayTime] ++;
  		}
		
		if( Player[playerid][uDMJail] > 0 ) 
		{
			Player[playerid][uDMJail]--;
			
			if( Player[playerid][uDMJail] == 0 ) 
			{
				new 
					Float: x, 
					Float: y, 
					Float: z, 
					Float: root;
						
				GetSpawnInfo( playerid, x, y, z, root );
	
				setPlayerPos( playerid, x, y, z );
				SetPlayerFacingAngle( playerid, root );
				
				UpdatePlayer( playerid, "uDMJail", 0 );
				
				SendClient:( playerid, C_WHITE, !""gbSuccess"Вы отсидели свой срок в Де Моргане." );
			}
		}
		
		if( Player[playerid][uJail] && Player[playerid][uJailTime] < gettime() ) 
		{
			new
				jail = Player[playerid][uJail] - 1;
				
			DeletePVar( playerid, "User:inInt" ), UpdateWeather( playerid );
				
			setPlayerPos( playerid, 
				spawnJail[jail][pos_street][0], 
				spawnJail[jail][pos_street][1], 
				spawnJail[jail][pos_street][2] );
			SetPlayerFacingAngle( playerid, spawnJail[jail][pos_street][3] );
			
			SetPlayerVirtualWorld( playerid, 0 );
			SetPlayerInterior( playerid, 0 );

			stopPlayer( playerid, 3 );
			
			Player[playerid][uJail] = 0, 
			Player[playerid][uJailTime] = 0;
				
			UpdatePlayer( playerid, "uJail", 0 ), 
			UpdatePlayer( playerid, "uJailTime", 0 );
			
			SendClient:( playerid, C_WHITE, !""gbSuccess"Вы отсидели свой срок в КПЗ." );
		}
		
		PhoneTimer( playerid );
		PrisonTimer( playerid );
    }
	
	ServerTimer();
	JobTimer();
	CrimeTimer();
}

function OnSecondTimer() 
{
	//clean_array();
	
	//callWeather();
	
    foreach( new i : Player)
	{		
		if( !IsLogged( i ) || IsKicked( i ) ) 
			continue;
			
		GivePVarInt( i, "Player:Afk", 1 );
		user_update_weather[i]++;
		
		AntiCheatTimer( i );
		
		if( user_update_weather[i] > 160 ) 
		{	
			user_update_weather[i] = 0, UpdateWeather( i );
		}
		
		if( stop_time[i] > 0 ) 
		{
			stop_time[i]--;
			if( stop_time[i] < 1 ) 
			{
				togglePlayerControllable( i, true );
			}
		}
		
		/*else if( GetPVarInt( i,"Player:Freeze") != 0) 
		{
		    TakePVarInt( i, "Player:Freeze", 1 );
			if( !GetPVarInt( i,"Player:Freeze" ) ) 
			{
			    togglePlayerControllable( i, true );
			}
		}
		else if(Player[i][uJailSettings][2] != 0) 
		{
			if(Player[i][uJailSettings][3] != 0) 
			{
				Player[i][uJailSettings][3] --;
    			format:g_small_string( "%d",Player[i][uJailSettings][3]);
    			GameTextForPlayer(i, g_small_string, 2000, 6);
    			ApplyAnimation(i, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
    			new Float:health;
    			GetPlayerHealth(i,health);
    			if(health < 100.0) setPlayerHealth(i,health + 5);
			}
			else 
			{
				Player[i][uJailSettings][2] = 0;
				Player[i][uJailSettings][3] = 0;
				format:g_small_string( "%d|%d|%d|%d|%d",Player[i][uJailSettings][0],Player[i][uJailSettings][1],Player[i][uJailSettings][2],Player[i][uJailSettings][3],Player[i][uJailSettings][4]);
				UpdatePlayerString( i, "uJailSettings", g_small_string );
				
				ClearAnimations(i);
				SendClientMessage(i, C_WHITE,""gbDefault"Вы были выписаны из больницы.");
				setPlayerPos(i,1137.4501,-1321.1863,804.5207);
				togglePlayerControllable(i,true);
				SpawnFreezeTime(i);
			 	SetPVarInt(i, "RepeatKill", 0);
			}
		}*/
		
		if(Player[i][uJailSettings][4] != 0) 
		{
			ApplyAnimation( i, "WUZI", "CS_Dead_Guy", 4.0, 1, 0, 0, 0, 0 );
		}
		
		if( GetPVarInt( i, "Player:Stunned" ) ) 
		{
		    GivePVarInt( i, "Player:Stunned", -1 );
			
		    if( GetPlayerAnimationIndex(i) != 388 )
			{
            	ApplyAnimation( i, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1 );
			}
			if( !GetPVarInt( i, "Player:Stunned" ) )
			{
			    togglePlayerControllable( i, true );
			}
		}
		
		if( GetPVarInt( i, "Player:Follow" ) != INVALID_PLAYER_ID && GetPVarInt( i, "Player:Cuff" ) != 0 ) 
		{
		    if( IsLogged( GetPVarInt( i, "Player:Follow" ) ) ) 
			{
		        if( !IsPlayerInAnyVehicle( GetPVarInt( i,"Player:Follow" ) ) ) 
				{
		            if( !IsPlayerInAnyVehicle( i ) ) 
					{
		                if( GetDistanceBetweenPlayers( i, GetPVarInt( i,"Player:Follow" ) ) < 1.5 ) 
						{
							ClearAnimations(i);
						}
						else if(GetDistanceBetweenPlayers( i, GetPVarInt( i,"Player:Follow" ) ) > 1.0 && GetDistanceBetweenPlayers( i, GetPVarInt( i,"Player:Follow" ) ) < 10.0) 
						{
							SetPlayerToFacePlayer( i, GetPVarInt( i, "Player:Follow" ) );
							ApplyAnimation( i, "ped", "WALK_civi", 6.0, 1, 1, 1, 1, 0, 1 );
						}
						else if( GetDistanceBetweenPlayers( i, GetPVarInt( i, "Player:Follow" ) ) > 10.0 ) 
						{
							SendClient:( GetPVarInt( i, "Player:Follow" ), C_WHITE, !""gbDefault"Вы отошли слишком далеко от человека, которого ведёте за собой." );
							
							SetPVarInt( GetPVarInt( i, "Player:Follow" ), "Player:Lead", INVALID_PLAYER_ID );
							SetPVarInt( i, "Player:Follow", INVALID_PLAYER_ID );
							
							togglePlayerControllable(i,false);
						}
		            }
		            else 
					{
					    SetPVarInt( GetPVarInt(i,"Player:Follow"), "Player:Lead",INVALID_PLAYER_ID);
						SetPVarInt( i, "Player:Follow", INVALID_PLAYER_ID);
					}
				}
				else 
				{
				    SetPVarInt( GetPVarInt( i, "Player:Follow" ), "Player:Lead", INVALID_PLAYER_ID );
					SetPVarInt( i, "Player:Follow", INVALID_PLAYER_ID );
				}
		    }
		    else SetPVarInt( i, "Player:Follow", INVALID_PLAYER_ID );
		}
		
		if( GetPVarInt( i, "Admin:SpectateId" ) != INVALID_PLAYER_ID )
		{
			AdminUpdateSpectatePanel( i, GetPVarInt( i, "Admin:SpectateId" ) );
		}
		
		if( GetPVarInt( i, "Police:GPSuse" ) && g_player_gps{i} )
		{
			GivePVarInt( i, "Police:GPSuse", 1 );
			
			if( GetPVarInt( i, "Police:GPSuse" ) == 7 )
			{
				SetPVarInt( i, "Police:GPSuse", 1 );
				SetPoliceCheckpoint( i, GetPVarInt( i, "Police:GPSplayer" ) );
			}
		}
		
		if( GetPVarInt( i, "Job:FoodSpeed" ) )
		{
			GivePVarInt( i, "Job:FoodSpeed", -1 );
		}
		
		DeathTimer( i );
		walktimer( i );
		
		//Проверка на трудовой контракт
		if( Player[i][uJob] && Job[i][j_time] - gettime() == 600 )
		{
			SendClient:( i, C_WHITE, ""gbDefault"До расторжения трудового контракта осталось 10 минут. Завершите свой рабочий день." );
		}
		
		if( Job[i][j_time] && Job[i][j_time] < gettime() )
		{
			Player[i][uJob] = 
			Job[i][j_time] = 
			job_duty{i} = 0;
				
			SendClient:( i, C_WHITE, ""gbSuccess"Ваш трудовой контракт, подписанный на 6 часов, расторгнут." );
			UpdatePlayer( i, "uJob", 0 );
			UpdatePlayer( i, "uJobTime", 0 );
		}
		
		//Удаление объекта с конвейера
		if( Job[i][j_time_wood] && Job[i][j_time_wood] < gettime() )
		{
			DestroyDynamicObject( Job[i][j_object_wood] );
			Job[i][j_time_wood] = 0;
		}
		
		FireTimer( i );
	}
	
	VehicleTimer();
	
	return 1;
}	