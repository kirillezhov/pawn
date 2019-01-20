function Death_OnPlayerConnect( playerid )
{
	ClearDeathData( playerid );
	
	return 1;
}

function Death_OnPlayerDisconnect( playerid, reason )
{
	if( IsValidDynamic3DTextLabel( death_text[ playerid ] ) )
	{
		DestroyDynamic3DTextLabel( death_text[ playerid ] );
		death_text[ playerid ] = Text3D: INVALID_3DTEXT_ID;
	}
	
	return 1;
}


function Death_OnPlayerSpawn( playerid )
{
	if( !GetPlayerSkin( playerid ) )
	{
		SetPlayerSkin( playerid, setUseSkin( playerid, true ) );
	}
	
	/*if( GetPVarInt( playerid, "Death:Save" ) )
	{
		Player[ playerid ][ uDeath ] += 1;
		
		if( Player[ playerid ][ uDeath ] > 2 )
		{
			Player[ playerid ][ uDeath ] = 2;
		}
		
		UpdatePlayer( playerid, "uDeath", Player[ playerid ][ uDeath ] );
		SetPVarInt( playerid, "Death:Save", 0 );
	}
	
	new 
		player_death = Player[ playerid ][ uDeath ],
		count;
		
	if( !player_death )
		return 1;
		
	setPlayerHealth( playerid, 100.0 );
	
	stopPlayer( playerid, 3 );

	ClearAnimations( playerid );
	ApplyDeathAnimation( playerid, player_death );
	
	SetPlayerDeathStage( playerid, player_death );
	SetPlayerVirtualWorld( playerid, death_pos[ playerid ][ d_world ] );
	SetPlayerInterior( playerid, death_pos[ playerid ][ d_int ] );
	
	for( new i; i < MAX_INVENTORY_USE; i++ )
	{
		if( getUseGunId( playerid, i ) )
		{
			RemovePlayerWeapon( playerid, i, getUseGunId( playerid, i ) );
		}		
	}
	
	count = GetPlayerDamagesCount( playerid );
	
	printf( "Playerid: %d | Death: %d", playerid, player_death );
	
	switch( player_death )
	{
		case PLAYER_INJURED :
		{
			if( count )
			{
				format:g_string( ""gbDefault"Ваш персонаж был ранен "cBLUE"%d раз(-а)"cWHITE". Для проверки повреждений, используйте - "cBLUE"/dm"cWHITE".",
					count
				);
			}
			else 
			{
				format:g_string( ""gbDefault"Ваш персонаж был ранен, Вы не можете двигаться." );
			}
			
			SendClient:( playerid, C_WHITE, g_string );
		}
		
		case PLAYER_DIED :
		{
			if( count )
			{
				format:g_string( ""gbDefault"Ваш персонаж был убит. Для проверки повреждений, используйте - "cBLUE"/dm"cWHITE"." );
			}
			else 
			{
				format:g_string( ""gbDefault"Ваш персонаж был убит, Вы не можете двигаться." );
			}
			
			SendClient:( playerid, C_WHITE, g_string );
		}
	}*/
	
	if( Player[playerid][uDeath] )
	{
		setPlayerHealth( playerid, 3.0 );
	
		stopPlayer( playerid, 5 );
		ClearAnimations( playerid );
		
		SetPlayerInterior( playerid, 1 );
		SetPlayerVirtualWorld( playerid, 63 );
		
		SetPVarInt( playerid, "User:inInt", 1 );
		UpdateWeather( playerid );
		
		SetCameraBehindPlayer( playerid );
		
		format:g_string( "\
			"cBLUE"Центральный госпиталь\n\n\
			"cWHITE"Ваш персонаж получил серьезные повреждения и помещен в госпиталь для прохождения курса реабилитации.\n\n\
			"gbDialog"Курс реабилитации занимает 5 минут, за это время Вы не cможете выйти из госпиталя\n\
			"gbDialog"Вы можете обратиться к одному из сотрудников госпиталя для ускорения процесса реабилитации" );
			
		death_timer[ playerid ] = 300;

		showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_string, "Закрыть", "" );
	}
	
	return 1;
}

function Death_OnPlayerDeath( playerid, killerid, reason )
{	
	/*if( Player[ playerid ][ uDeath ] != PLAYER_DIED )
	{
		GetPlayerPos( 
			playerid, 
			death_pos[ playerid ][ d_pos_x ], 
			death_pos[ playerid ][ d_pos_y ], 
			death_pos[ playerid ][ d_pos_z ] 
		);
			
		GetPlayerFacingAngle( playerid, death_pos[ playerid ][ d_angle ] );
		death_pos[ playerid ][ d_world ] = GetPlayerVirtualWorld( playerid );
		death_pos[ playerid ][ d_int ] = GetPlayerInterior( playerid );
		
		SetSpawnInfo( 
			playerid, 
			264, 
			setUseSkin( playerid, true), 
			death_pos[ playerid ][ d_pos_x ], 
			death_pos[ playerid ][ d_pos_y ], 
			death_pos[ playerid ][ d_pos_z ], 
			death_pos[ playerid ][ d_angle ], 
			0, 0, 0, 0, 0, 0 
		);
	
		SetPVarInt( playerid, "Death:Save", 1 );
	}*/
	
	new 
		rand = random( sizeof spawnHospital );
	
	SetSpawnInfo( 
		playerid, 
		264, 
		setUseSkin( playerid, true), 
		spawnHospital[rand][0], 
		spawnHospital[rand][1], 
		spawnHospital[rand][2], 
		spawnHospital[rand][3], 
		0, 0, 0, 0, 0, 0 
	);
	
	Player[ playerid ][ uDeath ] = 1;
	Player[ playerid ][ uHP ] = 0.0;
	
	UpdatePlayer( playerid, "uDeath", 1 );
	
	checkPlayerUseTexViewer( playerid );
	return 1;
}

function Death_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	/*if( dialog_cheat_use[ playerid ] ) 
		return 1;*/
		
	/*switch( dialogid ) 
	{
		case d_death : 
		{
			if( response ) 
			{
				new 
					rand = random( sizeof spawnHospital );
				
				Player[playerid][uJailSettings][2] = 1; 
				Player[playerid][uJailSettings][3] = 300;
				
				setPlayerPos( playerid, spawnHospital[rand][0], spawnHospital[rand][1], spawnHospital[rand][2] );
				SetPlayerFacingAngle( playerid, spawnHospital[rand][3] );
				
				stopPlayer( playerid, 3 );
				
				SetPlayerInterior( playerid, 1 );
				SetPlayerVirtualWorld( playerid, 63 );
				
				SetPlayerDeathStage( playerid, PLAYER_HEALTHY );
				
				Player[playerid][uDeath] = 0;
				UpdatePlayer( playerid, "uDeath", Player[playerid][uDeath] );
				
				SetPVarInt( playerid, "User:inInt", 1 );
				UpdateWeather( playerid );
			}
			else 
			{
				death_timer[ playerid ] = 150;
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы остались на месте. Повторный выбор появится через 2.5 минуты." );
			}
		}
	}*/
	
	return 1;
}

function Death_OnPlayerGiveDamage( playerid, damagedid, Float: amount, weaponid, bodypart ) 
{
	/*if( Player[ damagedid ][ uDeath ] == PLAYER_DIED )
	{
		setPlayerHealth( damagedid, 100.0 );
	}
	else if( Player[ damagedid ][ uDeath ] == PLAYER_INJURED && playerid != INVALID_PLAYER_ID ) 
	{
		Player[ damagedid ][ uDeath ] = PLAYER_DIED;
		UpdatePlayer( damagedid, "uDeath", Player[ damagedid ][uDeath] );
		setPlayerHealth( damagedid, 100.0 );
		ApplyDeathAnimation( damagedid, PLAYER_DIED );
		SetPlayerDeathStage( damagedid, PLAYER_DIED );
	}*/
	
	if( weaponid == 22 && g_player_taser{playerid} || weaponid == 24 && g_player_taser{playerid} || weaponid == 25 && g_player_taser{playerid} )
	{
		if( GetPlayerState( damagedid ) != PLAYER_STATE_ONFOOT || GetDistanceBetweenPlayers( playerid, damagedid ) > 10.0 )
			return 1;
				
		SetPVarInt( damagedid, "Player:Stunned", 30 );
		togglePlayerControllable( damagedid, false );
		
		SendClient:( damagedid, C_WHITE, !""gbDefault"Вы были оглушены электрошокером на 30 секунд." );
		
		format:g_small_string( "оглушил%s %s", SexTextEnd( playerid ), Player[damagedid][uName] );
		MeAction( playerid, g_small_string, 1 );
		
		ApplyAnimation( damagedid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1 );
	}
	
	return 1;
}


function Death_OnPlayerTakeDamage( playerid, issuerid, Float: amount, weaponid, bodypart ) 
{
	if( Player[playerid][uDeath] == PLAYER_INJURED || IsAfk( playerid ) ) 
		return 1;
		
	if( weaponid > 21 && weaponid < 35 )
	{
		GivePlayerDamage( playerid, damage_bodypart[ bodypart - 3 ][ weaponid - 22 ], bodypart, weaponid );
	}
	else
	{
		GivePlayerDamage( playerid, amount, bodypart, weaponid );
	}

    /*if( issuerid != INVALID_PLAYER_ID && GetPVarInt( playerid,"PlayerMenuShow" ) == 4 )  
	{
		
    }
	
	setPlayerArmour( playerid, 0.0 );*/
	
    return 1;
}

DeathTimer( playerid )
{
	/*if( Player[ playerid ][ uDeath ] == PLAYER_HEALTHY )
		return 1;
	
	if( Player[ playerid ][ uDeath ] == PLAYER_INJURED )
	{
		if( GetPlayerAnimationIndex( playerid ) != 1701 )
		{
			ApplyDeathAnimation( playerid, Player[playerid][uDeath] );
		}
	}
	else if( Player[playerid][uDeath] == PLAYER_DIED )
	{	
		if( GetPlayerAnimationIndex( playerid ) != 1151 )
		{
			ApplyDeathAnimation( playerid, Player[playerid][uDeath] );
		}
		
		if( death_timer[ playerid ] )
		{
			death_timer[ playerid ]--;
			
			format:g_string( "%d", death_timer[ playerid ] );
			GameTextForPlayer( playerid, g_string, 3000, 3 );
			
			if( Player[ playerid ][ uHP ] < 100.0 )
			{
				setPlayerHealth( playerid, 100.0 );
			}
		}
		else 
		{
			showPlayerDialog( playerid, d_death, DIALOG_STYLE_MSGBOX, "",
				""cBLUE"Ваш персонаж умер.\n\n\
				"cWHITE"Остаться на месте смерти или отправиться в госпиталь?\n\
				"gbDialog"Выбирая госпиталь, Вы будете обязаны забыть как проходило Ваше убийство.",
				"Госпиталь", "Остаться"
			);
		}
	}*/
	
	if( death_timer[ playerid ] )
	{
		death_timer[ playerid ]--;
			
		/*format:g_string( "%d", death_timer[ playerid ] );
		GameTextForPlayer( playerid, g_string, 3000, 3 );*/
		
		if( !(death_timer[ playerid ] % 6) )
		{
			//GameTextForPlayer( playerid, "~g~+ 2 HP", 1000, 4 );
			//setPlayerHealth( playerid, Player[ playerid ][ uHP ] + 2.0 );
			if( Player[ playerid ][ uHP ] < 100.0 )
			{
				GameTextForPlayer( playerid, "~g~+ 2 HP", 1000, 4 );
				setPlayerHealth( playerid, Player[ playerid ][ uHP ] + 2.0 );
			}
		}
		
		if( !death_timer[ playerid ] )
		{
			Player[playerid][uDeath] = 0;
			UpdatePlayer( playerid, "uDeath", 0 );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Курс реабилитации пройден, Вы вылечены." );
			
			//pformat:( "%f", Player[ playerid ][ uHP ] );
			//psend:( playerid, C_WHITE );
			
			for( new i; i < MAX_DAMAGES; i++ )
			{	
				Damage[ playerid ][ i ][ dm_amount ] = 0.0;
				
				Damage[ playerid ][ i ][ dm_body ] = 
				Damage[ playerid ][ i ][ dm_weapon ] =
				Damage[ playerid ][ i ][ dm_unix ] = 0;
			}
		}
	}
	
	return 1;
}

stock GivePlayerDamage( playerid, Float: amount, body, weaponid )
{
	if( floatround( amount ) )
	{
		if( Player[ playerid ][ uArmor ] )
		{
			if( floatsub( Player[ playerid ][ uArmor ], amount ) <= 0 )
			{
				DamageForPlayer( 0, playerid, floatsub( Player[ playerid ][ uArmor ], amount ) );
				setPlayerArmour( playerid, 0.0 );
			}
			else 
			{
				DamageForPlayer( 1, playerid, amount );
			}
		}
		else 
		{
			DamageForPlayer( 0, playerid, amount );
		}
	}
	
	for( new i; i < MAX_DAMAGES; i++ )
	{
		if( Damage[ playerid ][ i ][ dm_unix ] )
			continue;
			
		Damage[ playerid ][ i ][ dm_amount ] = amount;
		Damage[ playerid ][ i ][ dm_unix ] = gettime();
		Damage[ playerid ][ i ][ dm_body ] = body;
		Damage[ playerid ][ i ][ dm_weapon ] = weaponid;
		
		break;
	}
	
	return 1;
}

DamageForPlayer( type, playerid, Float: amount )
{
	if( type == 0 ) // Health
	{
		new
			Float:health;
	
		if( Player[ playerid ][ uHP ] <= 0 )
			return 0;
			
		if( floatsub( Player[ playerid ][ uHP ], amount ) > 0 )
		{
			setPlayerHealth( playerid, floatsub( Player[ playerid ][ uHP ], amount ) );
		}
		
		GetPlayerHealth( playerid, health );
		
		if( floatround( health ) <= 2 )
		{		
			/*GetPlayerPos( 
				playerid, 
				death_pos[ playerid ][ d_pos_x ], 
				death_pos[ playerid ][ d_pos_y ], 
				death_pos[ playerid ][ d_pos_z ] 
			);
				
			GetPlayerFacingAngle( playerid, death_pos[ playerid ][ d_angle ] );
			death_pos[ playerid ][ d_world ] = GetPlayerVirtualWorld( playerid );
			death_pos[ playerid ][ d_int ] = GetPlayerInterior( playerid );
			
			SetSpawnInfo( 
				playerid, 
				264, 
				setUseSkin( playerid, true), 
				death_pos[ playerid ][ d_pos_x ], 
				death_pos[ playerid ][ d_pos_y ], 
				death_pos[ playerid ][ d_pos_z ], 
				death_pos[ playerid ][ d_angle ], 
				0, 0, 0, 0, 0, 0 
			);
		
			SetPVarInt( playerid, "Death:Save", 1 );*/
			setPlayerHealth( playerid, 0 );
		}		
		
		/*if( floatsub( Player[ playerid ][ uHP ], amount ) <= 0 && !Player[ playerid ][ uDeath ] )
		{
			ApplyAnimation( playerid, "PED", "null", 4.0, 0, 0, 0, 1, 0, 1 );
			ApplyAnimation( playerid, "PED", "KO_shot_stom", 4.0, 0, 0, 0, 1, 0, 1 );
			setPlayerHealth( playerid, 0 );
		}
		else 
		{
			setPlayerHealth( playerid, floatsub( Player[ playerid ][ uHP ], amount ) );
		}*/
	}
	else if( type == 1 ) // Armor
	{
		if( Player[ playerid ][ uArmor ] <= 0 )
			return 0;
		
		if( floatsub( Player[ playerid ][ uArmor ], amount ) <= 0 )
		{
			setPlayerArmour( playerid, 0.0 );
		}
		else 
		{
			setPlayerArmour( playerid, floatsub( Player[ playerid ][ uArmor ], amount ) );
		}
	}
	
	return 1;
}

/*ApplyDeathAnimation( playerid, stage )
{
	switch( stage )
	{
		case 1 :
		{
			ApplyAnimation( playerid, "SWEET", "null", 4.0, 0, 0, 0, 1, 0, 1 );
			ApplyAnimation( playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0 );
		}
		
		case 2 :
		{
			ApplyAnimation( playerid, "SWEET", "null", 4.0, 0, 0, 0, 1, 0, 1 );
			ApplyAnimation( playerid, "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 0 );
		}
	}	
}*/

stock SetPlayerDeathStage( playerid )
{
	/*switch( stage )
	{
		case PLAYER_INJURED :
		{
			format:g_string( "(( Данный персонаж ранен %d раз(-а) - /dm %d ))", 
				GetPlayerDamagesCount( playerid ), 
				playerid 
			);
		}
		
		case PLAYER_DIED :
		{
			g_string[0] = EOS;
			strcat( g_string, "(( ДАННЫЙ ПЕРСОНАЖ МЁРТВ ))" );
			
			death_timer[ playerid ] = 300;
		}
	}
	
	if( stage )
	{
		if( IsValidDynamic3DTextLabel( death_text[ playerid ] ) )
		{
			UpdateDynamic3DTextLabelText( 
				death_text[ playerid ], 
				C_LIGHTRED, 
				g_string 
			);
		}
		else 
		{
			death_text[ playerid ] = CreateDynamic3DTextLabel( 
				g_string, 
				C_LIGHTRED, 
				0.0, 
				0.0, 
				0.0, 
				10.0, 
				playerid, 
				INVALID_VEHICLE_ID 
			);
		}
	}
	else 
	{
	if( IsValidDynamic3DTextLabel( death_text[ playerid ] ) )
	{
		DestroyDynamic3DTextLabel( death_text[ playerid ] );
		death_text[ playerid ] = Text3D: INVALID_3DTEXT_ID;
	}*/
		
	for( new i; i < MAX_DAMAGES; i++ )
	{	
		Damage[ playerid ][ i ][ dm_amount ] = 0.0;
			
		Damage[ playerid ][ i ][ dm_body ] = 
		Damage[ playerid ][ i ][ dm_weapon ] =
		Damage[ playerid ][ i ][ dm_unix ] = 0;
	}
		
	death_timer[ playerid ] = 0;
		
	return 1;
}


GetPlayerDamagesCount( playerid )
{
	new 
		count = 0;

	for( new i; i < MAX_DAMAGES; i++ )
	{
		if( !Damage[playerid][i][dm_unix] )
			continue;
			
		count++;
	}
	
	return count;
}

ClearDeathData( playerid )
{
	death_text[ playerid ] = Text3D: INVALID_3DTEXT_ID;
	death_timer[ playerid ] = 0;
	
	death_pos[ playerid ][ d_pos_x ] =
	death_pos[ playerid ][ d_pos_y ] =
	death_pos[ playerid ][ d_pos_z ] = 
	death_pos[ playerid ][ d_angle ] = 0.0;
	death_pos[ playerid ][ d_world ] =
	death_pos[ playerid ][ d_int ] = 0;
	
	for( new i; i < MAX_DAMAGES; i++ )
	{	
		Damage[ playerid ][ i ][ dm_amount ] = 0.0;
		
		Damage[ playerid ][ i ][ dm_body ] = 
		Damage[ playerid ][ i ][ dm_weapon ] =
		Damage[ playerid ][ i ][ dm_unix ] = 0;
	}
	
	SetPVarInt( playerid, "Death:Save", 0 );
}

stock GetDeathBodyPart( part, dest[] )
{
	dest[ 0 ] = EOS;
	switch( part )
	{
		case 3 : strcat( dest, "Торс", 32 );
		case 4 : strcat( dest, "Пах", 32 );
		case 5 : strcat( dest, "Левая рука", 32 );
		case 6 : strcat( dest, "Правая рука", 32 );
		case 7 : strcat( dest, "Левая нога", 32 );
		case 8 : strcat( dest, "Правая нога", 32 );
		case 9 : strcat( dest, "Голова", 32 );
		default : strcat( dest, "Неизвестно", 32 );
	}
}

stock GetDeathDuration( time, dest[] )
{
	if( time < 0 || time == gettime( ) || time > 2592000 ) 
	{
	    strcat( dest, "Никогда", 32 );
	    return 1;
	}
	else if( time < 60 )
	{
		format( dest, 256, "%d секунд(-у, -а)", time );
	}
	else if( time >= 0 && time < 60 )
	{
		format( dest, 256, "%d секунда", time );
	}
	else if( time >= 60 && time < 3600 )
	{
		format( dest, 256, ( time >= 120 ) ? ( "%d минут(-ы)" ) : ( "%d минуту" ), time / 60 );
	}
	else if( time >= 3600 && time < 86400)
	{
		format( dest, 256, ( time >= 7200 ) ? ("%d часа(-ов)" ) : ( "%d час" ), time / 3600 );
	}
	else if( time >= 86400 && time < 2592000 )
	{	
		format( dest, 256, ( time >= 172800 ) ? ( "%d дня(-ей)" ) : ( "%d день" ), time / 86400 );
	}

	return 1;
}

GetPlayerDamagesInfo( playerid, damageid )
{
	clean_array();
	
	if( !GetPlayerDamagesCount( damageid ) )
		return 0;
		
	new 
		weapon_name[ 32 ],
		body_part[ 32 ],
		duration[ 32 ];
		
	for( new i; i < MAX_DAMAGES; i++ ) 
	{
		clean:<weapon_name>;
		clean:<body_part>;
		clean:<duration>;
	
  	    if( !Damage[ damageid ][ i ][ dm_unix ] ) 
			continue;
			
		switch( Damage[ damageid ][ i ][ dm_weapon ] )
		{
			case FIRE_BURN:
				strcat( weapon_name, "Burn" );
			
			case 1..42, 49, 53, 54 :
				GetWeaponName( Damage[ damageid ][ i ][ dm_weapon ], weapon_name, sizeof weapon_name );
			
			default:
				strcat( weapon_name, "Fist" );
		}
		
		GetDeathDuration( gettime( ) - Damage[ damageid ][ i ][ dm_unix ], duration );
		GetDeathBodyPart( Damage[ damageid ][ i ][ dm_body ], body_part );
		
		format:g_string( ""cBLUE"%d."cWHITE" %s, %s, %s\n", 
			i + 1, 
			duration, 
			weapon_name, 
			body_part
		);
		
		strcat( g_big_string, g_string );
  	}
	
    return showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, Player[ damageid ][uName], g_big_string, "Закрыть", "" );
}

HealthPlayer( playerid )
{
	if( Player[ playerid ][uJailSettings][2] != 0 ) 
	{
		Player[ playerid ][uJailSettings][2] = 0;
	}
	
	else if( Player[ playerid ][uJailSettings][3] != 0 ) 
	{
		Player[ playerid ][uJailSettings][3] = 2;
	}
	
	else if( Player[ playerid ][uJailSettings][4] != 0 ) 
	{
		Player[ playerid ][uJailSettings][4] = 0;
	}
	
	format:g_string( "%d|%d|%d|%d|%d",
		Player[ playerid ][uJailSettings][0],
		Player[ playerid ][uJailSettings][1],
		Player[ playerid ][uJailSettings][2],
		Player[ playerid ][uJailSettings][3],
		Player[ playerid ][uJailSettings][4]
	);
	
	Player[ playerid ][uDeath] = 0; 
	
	UpdatePlayerString( playerid, "uJailSettings", g_string );
	UpdatePlayer( playerid, "uDeath", 0 );
	
	ClearAnimations( playerid );
	SetPlayerDeathStage( playerid );
	
	setPlayerHealth( playerid, 100.0 );
	
	return 1;
}

CMD:damages( playerid, params[] ) return cmd_dm( playerid, params );
	
CMD:dm( playerid, params[] ) 
{
	if( sscanf( params, "u", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /dm [ id игрока ]" );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 10.0 
		|| GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) 
		&& !GetAccessAdmin( playerid, 1 ) 
	) 
		return SendClient:( playerid, C_WHITE,""gbError"Данный игрок не находиться рядом с Вами.");
	
	if( !GetPlayerDamagesInfo( playerid, params[0] ) )
	{
		SendClient:( playerid, C_WHITE, ""gbDefault"У данного игрока отсутствуют повреждения." );
	}
	
	return 1;
}