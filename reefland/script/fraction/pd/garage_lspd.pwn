#define police_garage_pos 	1588.8293, -1644.1986, 12.4
#define police_garage_root	192.2468
#define police_garage_exit	1583.2419,-1638.6770,13.3159

new Float:police_garage[][] = {
	{ 1588.3644, -1633.4977, 12.9459, 352.0 },// Центр
	{ 2307.7725, -1318.2841, 23.5543, 90.5832 },// Гетто
	{ 2049.4792, -2120.1016, 13.3047, 358.7 }// Аэро
};

new Float:police_garage_enter[][] = {
	{ 1583.2748, -1637.1438, 13.3905, 357.3250 },
	{2312.4307,-1323.0132,24.0332,90.9316},
	{2057.9963,-2123.7944,13.6328,1.8451}
};

//Двери в оружейку LSPD
GarageLspd_OnGameModeInit() 
{
	/*CreateDynamic3DTextLabel(""cBLUE"[ Служебный гараж ]",C_BLUE, 2049.3599,-2123.7502,16.6328,10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1, -1,-1);
	CreateDynamic3DTextLabel(""cBLUE"[ Служебный гараж ]",C_BLUE, 2311.8723,-1318.1321,25.0361,10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1, -1,-1);
	
	
	CreateDynamic3DTextLabel("{FFFFFF}Оружейная\n\n"cBLUE"ALT",C_BLUE, 1524.49,-1677.89,6.2188,10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1, 1,-1);
	for( new i; i < sizeof police_garage_enter; i++ ) {
		CreateDynamicPickup( 19132, 23, police_garage_enter[i][0], police_garage_enter[i][1], police_garage_enter[i][2] );
		CreateDynamic3DTextLabel( "{ffffff}[ Служебный вход ]\n"cBLUE"ALT",C_BLUE, police_garage_enter[i][0], police_garage_enter[i][1], police_garage_enter[i][2],5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
	}
	CreateDynamicPickup( 19132, 23, police_garage_exit );
	CreateDynamic3DTextLabel( "{ffffff}[ Выход ]\n"cBLUE"ALT", C_BLUE, police_garage_exit,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1, -1, 228 );
	
	// TP из LSPD в гараж
	CreateDynamicPickup( 19132, 23, 1564.0386,-1678.9958,2494.2449 );// vnutri
	CreateDynamicPickup( 19132, 23, 1568.4200,-1690.5000,5.8906, 1 );// snaruji*/

	return true;
}    

GarageL_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	#pragma unused oldkeys
	switch( newkeys ) {
		case KEY_WALK: {
			if( IsPlayerInRangeOfPoint( playerid, 1.5, 1564.0386,-1678.9958,2494.2449 ) ) {
				setPlayerPos( playerid, 1568.4200,-1690.5000,5.8906 );
				SetPlayerVirtualWorld( playerid, 1 );
				SetPlayerInterior( playerid, 228 );
			}
			if( IsPlayerInRangeOfPoint( playerid, 1.5, 1568.4200,-1690.5000,5.8906 ) &&
				GetPlayerVirtualWorld( playerid ) == 1 ) {
				setPlayerPos( playerid, 1564.0386,-1678.9958,2494.2449 );
				SetPlayerVirtualWorld( playerid, 1 );
				SetPlayerInterior( playerid, 1 );	
			}
			if( IsPlayerInRangeOfPoint( playerid, 1.5, 1524.49,-1677.89,6.2188 ) &&
				GetPlayerVirtualWorld( playerid ) == 1 ) {// ЛСПД
				SetPlayerVirtualWorld(playerid, 1);
				setPlayerPos( playerid, 634.442,202.591,2001.08 );
				SetPlayerInterior(playerid, 6);
			}
			if(	IsPlayerInRangeOfPoint(playerid,2.0,634.442,202.591,2001.08 ) && 
				GetPlayerVirtualWorld(playerid) == 1 ) {// ЛСПД
				
				setPlayerPos(playerid, 1524.49,-1677.89,6.2188);
				SetPlayerVirtualWorld( playerid, 1 );
				SetPlayerInterior( playerid, 228 );
			}
			for( new i; i < sizeof police_garage_enter; i++ ) {
				if( IsPlayerInRangeOfPoint( playerid, 1.5, police_garage_enter[i][0], police_garage_enter[i][1], police_garage_enter[i][2] ) ) {
					setPlayerPos( playerid, police_garage_exit );
					SetPlayerFacingAngle( playerid, 185.0 );
					SetPlayerVirtualWorld( playerid, i + 1 );
					SetPlayerInterior( playerid, 228 );
				}
				else if( IsPlayerInRangeOfPoint( playerid, 1.5, police_garage_exit ) &&
						 GetPlayerVirtualWorld( playerid ) == ( i + 1 ) ) {
					setPlayerPos( playerid, police_garage_enter[i][0], police_garage_enter[i][1], police_garage_enter[i][2] );
					SetPlayerFacingAngle( playerid, police_garage_enter[i][3] );
					SetPlayerVirtualWorld( playerid, 0 );
					SetPlayerInterior( playerid, 0 );
				}
			}	
		}
		case KEY_CROUCH: {
			if( IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) {
				if( Player[playerid][uMember] == 2 ) {
					for( new i; i < sizeof police_garage; i++ ) {
						if( IsPlayerInRangeOfPoint( playerid, 5.0, police_garage[i][0], police_garage[i][1], police_garage[i][2] ) ) {
							new v = GetPlayerVehicleID(playerid);
							setVehiclePos( v, police_garage_pos );
							SetVehicleZAngle( v, police_garage_root );
							foreach(new p: Player) {
								if( GetPlayerVehicleID( p ) == v ) {
									SetPlayerVirtualWorld( p, i + 1 );
									SetPlayerInterior( p, 228 );
								}
							}	
							LinkVehicleToInterior( v, 228 );
							SetVehicleVirtualWorld( v, i + 1 );
							
							break;
						}						
					}
					if( IsPlayerInRangeOfPoint( playerid, 5.0, police_garage_pos ) ) {
						new v = GetPlayerVehicleID(playerid), w = GetPlayerVirtualWorld( playerid ) - 1;
						setVehiclePos( v, police_garage[w][0], police_garage[w][1], police_garage[w][2] );
						SetVehicleZAngle( v, police_garage[w][3] );
						foreach(new p: Player) {
							if( GetPlayerVehicleID( p ) == v ) {
								SetPlayerVirtualWorld( p, 0 );
								SetPlayerInterior( p, 0 );
							}
						}	
						LinkVehicleToInterior( v, 0 );
						SetVehicleVirtualWorld( v, 0 );
					}
				}
			}
		}
	}
	return true;
}