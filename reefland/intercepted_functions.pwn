stock SetPlayerCash( playerid, type[] = "+", _: cash )
{
	clean:<g_string>;
	
	switch( type[0] )
	{
		case '+' :
		{
			Player[playerid][uMoney] += cash;
			
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE " #DB_USERS " SET uMoney = uMoney + %d WHERE uID = %d LIMIT 1",
				cash,
				Player[playerid][uID]
			);
		}
		
		case '-' :
		{
			Player[playerid][uMoney] -= cash;
			
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE " #DB_USERS " SET uMoney = uMoney - %d WHERE uID = %d LIMIT 1",
				cash,
				Player[playerid][uID]
			);
		}
		
		case '=' :
		{
			Player[playerid][uMoney] = cash;
			
			mysql_format( mysql, g_string, sizeof g_string, "UPDATE " #DB_USERS " SET uMoney = %d WHERE uID = %d LIMIT 1",
				cash,
				Player[playerid][uID]
			);
		}
	}
	
	
	return mysql_tquery( mysql, g_string );
}

stock SetPlayerBank( playerid, type[] = "+", _: cash )
{
	clean:<g_small_string>;
	
	new
		history 	[ 32 ],
		bool:flag = false;
	
	switch( type[0] )
	{
		case '+' :
		{
			Player[playerid][uBank] += cash;
			
			mysql_format( mysql, g_small_string, sizeof g_small_string, "UPDATE " #DB_USERS " SET uBank = uBank + %d WHERE uID = %d LIMIT 1",
				cash,
				Player[playerid][uID]
			);
			
			format:history( ""cGREEN"+ $%d", cash );
			
			for( new i; i < MAX_HISTORY; i++ )
			{
				if( !Payment[playerid][i][HistoryTime] )
				{
					Payment[playerid][i][HistoryTime] = gettime();
					
					clean:<Payment[playerid][i][HistoryName]>;
					strcat( Payment[playerid][i][HistoryName], history, 32 );
					
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				Payment[playerid][0][HistoryTime] = gettime();
					
				clean:<Payment[playerid][0][HistoryName]>;
				strcat( Payment[playerid][0][HistoryName], history, 32 );
			}
		}
		
		case '-' :
		{
			Player[playerid][uBank] -= cash;
			
			mysql_format( mysql, g_small_string, sizeof g_small_string, "UPDATE " #DB_USERS " SET uBank = uBank - %d WHERE uID = %d LIMIT 1",
				cash,
				Player[playerid][uID]
			);
			
			format:history( ""cRED"- $%d", cash );
			
			for( new i; i < MAX_HISTORY; i++ )
			{
				if( !Payment[playerid][i][HistoryTime] )
				{
					Payment[playerid][i][HistoryTime] = gettime();
					
					clean:<Payment[playerid][i][HistoryName]>;
					strcat( Payment[playerid][i][HistoryName], history, 32 );
					
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				Payment[playerid][0][HistoryTime] = gettime();
					
				clean:<Payment[playerid][0][HistoryName]>;
				strcat( Payment[playerid][0][HistoryName], history, 32 );
			}
		}
		
		case '=' :
		{
			Player[playerid][uBank] = cash;
			
			mysql_format( mysql, g_small_string, sizeof g_small_string, "UPDATE " #DB_USERS " SET uBank = %d WHERE uID = %d LIMIT 1",
				cash,
				Player[playerid][uID]
			);
		}
	}
	
	
	return mysql_tquery( mysql, g_small_string );
}

stock givePlayerWeapon( playerid, weaponid, ammo )
{
	GivePlayerWeapon( playerid, weaponid, ammo );
	printf( "[Log] For %s[%d] - %d has been added %d ammo.", GetAccountName( playerid ), playerid, weaponid, ammo );
}

stock setPlayerSkin( playerid, skinid ) 
{
	return SetPlayerSkin( playerid, skinid );
}

stock togglePlayerSpectating( playerid, value ) 
{
	Player[playerid][tSpectate] = value;
	return TogglePlayerSpectating( playerid, value );
}

stock togglePlayerControllable( playerid, value )
{
	if(! value ) 
		SetPVarInt( playerid,"Player:Freeze", 0 );
	else 
		SetPVarInt( playerid,"Player:Freeze", 1 );
		
    return TogglePlayerControllable( playerid, value );
}

stock showPlayerDialog( playerid, dialogid, style, caption[], info[], button1[], button2[] ) 
{
	Player[playerid][tDialogId] = dialogid;
	
    return ShowPlayerDialog( playerid, dialogid, style, caption, info, button1, button2 );
}

stock setPlayerHealth( playerid, Float:health )
{
	if( health > 255.0 || health < 0.0 ) 
		return 0;
		
	Player[playerid][uHP] = health;
	
	SetPlayerHealth( playerid, health );
	return 1;
}

stock setPlayerArmour( playerid, Float: amount )
{
	if( amount > 255.0 || amount < 0.0 ) 
		return STATUS_ERROR;
		
	if( GetPVarInt( playerid, "Inv:unUseArmour" ) )
	{
		SetPlayerArmour( playerid, 0 );
		Player[playerid][uArmor] = 0;
		
		DeletePVar( playerid, "Inv:unUseArmour" );
		return STATUS_OK;
	}
		
	new 
		id;
		
	for( new i; i < MAX_INVENTORY_USE; i++ )
	{
		id = getInventoryId( UseInv[playerid][i][inv_id] );
			
		if( inventory[id][i_type] == INV_ARMOUR )
		{
			Player[playerid][uArmor] = amount;
			UseInv[playerid][i][inv_param_1] = floatround( amount );
			
			if( UseInv[playerid][i][inv_param_1] <= 0 )
			{
				if( UseInv[playerid][i][inv_bone] != INVALID_PARAM )
					RemovePlayerAttachedObject( playerid, i );
			
				saveInventory( playerid, i, INV_DELETE, TYPE_USE );
				clearSlot( playerid, i, TYPE_USE );
					
				if( GetPVarInt( playerid, "Inv:Show" ) )
				{
					updateImages( playerid, i, TYPE_USE );
					updateAmount( playerid, i, TYPE_USE );
			
					updateSelect( playerid, invSelect[playerid], 0 );
					invSelect[playerid] = INVALID_PTD;
				}
			}
				
			SetPlayerArmour( playerid, amount );
			return STATUS_OK;
		}
	}
	
    return STATUS_ERROR;
}

stock putPlayerInVehicle( playerid, vehicle, seat )
{
	foreach(new i: Player)
	{
		if( !IsLogged(i) || i == playerid ) continue;
	
		if( GetPlayerVehicleID( i ) == vehicle && GetPlayerVehicleSeat( i ) == seat )
			return STATUS_ERROR;
	}

	SetTimerEx( "OnputPlayerInVehicle", GetPlayerPing( playerid ) + 700, 0, "ddd", playerid, vehicle, seat );
	
	return 1;
}

function OnputPlayerInVehicle( playerid, vehicle, seat )
{
	if( !IsPlayerInAnyVehicle( playerid ) && Player[playerid][tEnterVehicle] == INVALID_VEHICLE_ID )
	{
		CheatDetected( playerid, "NOP putPlayerInVehicle", CHEAT_NOP_PUT_IN_VEH );
	}
	
	return PutPlayerInVehicle( playerid, vehicle, seat );
}

stock removePlayerFromVehicle( playerid ) 
{
	SetTimerEx( "OnPlayerRemoveFromVehicle", GetPlayerPing( playerid ) + 700, 0, "d", playerid );
	
    return 1;
}

function OnPlayerRemoveFromVehicle( playerid )
{
	if( IsPlayerInAnyVehicle( playerid ) && Player[playerid][tEnterVehicle] == INVALID_VEHICLE_ID )
	{
		CheatDetected( playerid, "NOP removePlayerFromVehicle", CHEAT_NOP_REMOVE_FROM_VEH );
	}
	
	RemovePlayerFromVehicle( playerid );
	Player[playerid][tEnterVehicle] = INVALID_VEHICLE_ID;
	
	return 1;
}

stock setVehiclePos( vehicleid, Float:x, Float:y, Float:z ) 
{
	ac_vehicle_pos[ vehicleid ][ vp_x ] = x;
	ac_vehicle_pos[ vehicleid ][ vp_y ] = y;
	ac_vehicle_pos[ vehicleid ][ vp_z ] = z;
	
	new 
		playerid = GetVehiclePlayerID( vehicleid );
	
	if( playerid != INVALID_PLAYER_ID )
	{
		g_player_airbreak_protect{playerid} = 7;
	}
	
	return SetVehiclePos( vehicleid, x, y, z );
}

stock setPlayerPos( playerid, Float: x, Float: y, Float: z ) 
{
	Player[playerid][tPos][0] = x;
	Player[playerid][tPos][1] = y;
	Player[playerid][tPos][2] = z;
	g_player_airbreak_protect{playerid} = ANTICHEAT_EXCEPTION_TIME;
	CancelEdit( playerid);
	
	SetPlayerPos( playerid, x, y, z );
	
	if( !g_player_airbreak_protect{playerid} && !IsAfk( playerid ) && !IsPlayerInRangeOfPoint( playerid, 15.0, x, y, z ) ) 
		return CheatDetected( playerid, "NOP setPlayerPos", CHEAT_NOP_TELEPORT );
	
	return 1;
}

stock setVehicleZAngle( vehicleid, Float:angle )
{
	SetTimerEx( "OnVehicleRotation", 200, false, "df", vehicleid, angle ); 
	return 1;
}

stock setVehicleHealth( vehicleid, Float: amount )
{
	Vehicle[vehicleid][vehicle_health] = amount;
	return SetVehicleHealth( vehicleid, amount );
}

function OnVehicleRotation( vehicleid, Float:angle )
{
	SetVehicleZAngle( vehicleid, angle );
	return 1;
}

#define SetPlayerSkin					setPlayerSkin
//#define SetPlayerPos					setPlayerPos
//#define SetVehiclePos					setVehiclePos
//#define RemovePlayerFromVehicle		removePlayerFromVehicle
//#define PutPlayerInVehicle			putPlayerInVehicle
//#define SetPlayerArmour				setPlayerArmour
//#define SetPlayerHealth				setPlayerHealth
//#define ShowPlayerDialog				showPlayerDialog
//#define TogglePlayerSpectating		togglePlayerSpectating
//#define TogglePlayerControllable		togglePlayerControllable
//#define GivePlayerWeapon				givePlayerWeapon
#define SetVehicleZAngle				setVehicleZAngle
//#define SetVehicleHealth				setVehicleHealth