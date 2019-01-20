
function insertHostels( playerid, i ) {
	Hostels[i][kID] = cache_insert_id();
	Hostels[i][kVirtWorld] = Hostels[i][kID];
	format:g_string( "UPDATE `gb_hostel` SET `kVirtualWorld` = '%d' WHERE `kID` = '%d'",
		Hostels[i][kVirtWorld], Hostels[i][kID] );
	mysql_query( mysql, g_string );
	format:g_small_string( ""gbDefault"Вы успешно создали подъезд! ID подъезда %d", Hostels[i][kID] );
	SendClient:( playerid, C_WHITE, g_small_string );
	
	SendClient:( playerid, -1, ""gbDefault"Не забудьте установить второй вход с помощью команды /enterhostel!" );  
	SendClient:( playerid, -1, ""gbDefault"И установите положение камеры с помощью команды /camerahostel" );           
	CreateDynamicPickup(19132,23,Hostels[i][kEnterPos][0], Hostels[i][kEnterPos][1], Hostels[i][kEnterPos][2], -1);
    //          
	CreateDynamicPickup(19132,23,Hostels[i][kExitPos][0], Hostels[i][kExitPos][1], Hostels[i][kExitPos][2], Hostels[i][kVirtWorld]);
	CreateDynamicPickup(19132,23,Hostels[i][kExitPos_Two][0], Hostels[i][kExitPos_Two][1], Hostels[i][kExitPos_Two][2], Hostels[i][kVirtWorld]);  
	return true;
}

Hostel_OnGameModeInit() {
	mysql_tquery( mysql, "SELECT * FROM `gb_hostel` ORDER BY `kID`", "loadHostels", "" );
	return true;
}

Hostel_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	#pragma unused oldkeys
	switch( newkeys ) {
		case KEY_WALK: {
			for(new i; i < sizeof( Hostels ); i ++) {
				if( IsPlayerInRangeOfPoint( playerid,1.0, Hostels[i][kEnterPos][0], Hostels[i][kEnterPos][1], Hostels[i][kEnterPos][2]) 
					|| IsPlayerInRangeOfPoint(playerid,1.0,Hostels[i][kEnterPos_Two][0],Hostels[i][kEnterPos_Two][1],Hostels[i][kEnterPos_Two][2])) {
					if(IsPlayerInRangeOfPoint(playerid,1.0,Hostels[i][kEnterPos][0],Hostels[i][kEnterPos][1],Hostels[i][kEnterPos][2])) {
						setPlayerPos(playerid,Hostels[i][kExitPos][0],Hostels[i][kExitPos][1],Hostels[i][kExitPos][2]);
						SetPlayerInterior(playerid,Hostels[i][kInt]);
						SetPlayerVirtualWorld(playerid,Hostels[i][kVirtWorld]);
						setHouseWeather( playerid );
						break;
					}
					else if(IsPlayerInRangeOfPoint(playerid,1.0,Hostels[i][kEnterPos_Two][0],Hostels[i][kEnterPos_Two][1],Hostels[i][kEnterPos_Two][2])) {
						setPlayerPos(playerid,Hostels[i][kExitPos_Two][0],Hostels[i][kExitPos_Two][1],Hostels[i][kExitPos_Two][2]);
						SetPlayerInterior(playerid,Hostels[i][kInt]);
						SetPlayerVirtualWorld(playerid,Hostels[i][kVirtWorld]);
						setHouseWeather( playerid );
						break;
					}
				}
				else if( GetPlayerVirtualWorld( playerid ) == Hostels[i][kVirtWorld] && ( IsPlayerInRangeOfPoint(playerid,1.0,Hostels[i][kExitPos][0],Hostels[i][kExitPos][1],Hostels[i][kExitPos][2]) || IsPlayerInRangeOfPoint(playerid,1.0,Hostels[i][kExitPos_Two][0],Hostels[i][kExitPos_Two][1],Hostels[i][kExitPos_Two][2] ) ) )
				{
					if(IsPlayerInRangeOfPoint(playerid,1.0,Hostels[i][kExitPos][0],Hostels[i][kExitPos][1],Hostels[i][kExitPos][2]))
					{
						setPlayerPos(playerid,Hostels[i][kEnterPos][0],Hostels[i][kEnterPos][1],Hostels[i][kEnterPos][2]);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						DeletePVar( playerid, "User:inInt" ), UpdateWeather( playerid );
						
					}
					else if(IsPlayerInRangeOfPoint(playerid,1.0,Hostels[i][kExitPos_Two][0],Hostels[i][kExitPos_Two][1],Hostels[i][kExitPos_Two][2])) {
						setPlayerPos(playerid,Hostels[i][kEnterPos_Two][0],Hostels[i][kEnterPos_Two][1],Hostels[i][kEnterPos_Two][2]);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						DeletePVar( playerid, "User:inInt" ), UpdateWeather( playerid );
					}
				}
			}	
		}
	}	
	return true;
}

function loadHostels() {
	clean_array();
	new rows, fields;
    cache_get_data( rows, fields );
	if( rows ) {
		for(new j; j < rows; j++) {
	        Hostels[j][kID] = cache_get_field_content_int(j, "kID");
		    Hostels[j][kEnterPos][0] = cache_get_field_content_float(j, "kEnterPosX");
			Hostels[j][kEnterPos][1] = cache_get_field_content_float(j, "kEnterPosY");
			Hostels[j][kEnterPos][2] = cache_get_field_content_float(j, "kEnterPosZ");
				//
			Hostels[j][kEnterPos_Two][0] = cache_get_field_content_float(j, "kEnterPosX_Two");
			Hostels[j][kEnterPos_Two][1] = cache_get_field_content_float(j, "kEnterPosY_Two");
			Hostels[j][kEnterPos_Two][2] = cache_get_field_content_float(j, "kEnterPosZ_Two");
				//
				
			Hostels[j][kExitPos][0] = cache_get_field_content_float(j, "kExitPosX");
		    Hostels[j][kExitPos][1] = cache_get_field_content_float(j, "kExitPosY");
			Hostels[j][kExitPos][2] = cache_get_field_content_float(j, "kExitPosZ");
				//
			Hostels[j][kExitPos_Two][0] = cache_get_field_content_float(j, "kExitPosX_Two");
		    Hostels[j][kExitPos_Two][1] = cache_get_field_content_float(j, "kExitPosY_Two");
			Hostels[j][kExitPos_Two][2] = cache_get_field_content_float(j, "kExitPosZ_Two");
				//
			Hostels[j][kInt] = cache_get_field_content_int(j, "kInt");
			Hostels[j][kCity] = cache_get_field_content_int(j, "kCity");
			Hostels[j][kVirtWorld] = cache_get_field_content_int(j, "kVirtualWorld");
				//
			Hostels[j][kCamPos][0] = cache_get_field_content_float(j, "kCamPosX");
			Hostels[j][kCamPos][1] = cache_get_field_content_float(j, "kCamPosY");
			Hostels[j][kCamPos][2] = cache_get_field_content_float(j, "kCamPosZ");
				//
				
				
			/*CreateDynamic3DTextLabel("[ Вход ]\n\n"cBLUE"ALT",0xFFFFFFFF,Hostels[j][kEnterPos][0], Hostels[j][kEnterPos][1], Hostels[j][kEnterPos][2],5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,-1);
			CreateDynamic3DTextLabel("[ Вход ]\n\n"cBLUE"ALT",0xFFFFFFFF,Hostels[j][kEnterPos_Two][0], Hostels[j][kEnterPos_Two][1], Hostels[j][kEnterPos_Two][2],5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,-1);
			CreateDynamic3DTextLabel("[ Выход ]\n\n"cBLUE"ALT",0xFFFFFFFF,Hostels[j][kExitPos][0], Hostels[j][kExitPos][1], Hostels[j][kExitPos][2],5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,-1);
			CreateDynamic3DTextLabel("[ Выход ]\n\n"cBLUE"ALT",0xFFFFFFFF,Hostels[j][kExitPos_Two][0], Hostels[j][kExitPos_Two][1], Hostels[j][kExitPos_Two][2],5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,-1);
            CreateDynamicPickup(19132,23,Hostels[j][kEnterPos][0], Hostels[j][kEnterPos][1], Hostels[j][kEnterPos][2], -1);
            CreateDynamicPickup(19132,23,Hostels[j][kEnterPos_Two][0], Hostels[j][kEnterPos_Two][1], Hostels[j][kEnterPos_Two][2], -1);
                
		    CreateDynamicPickup(19132,23,Hostels[j][kExitPos][0], Hostels[j][kExitPos][1], Hostels[j][kExitPos][2], Hostels[j][kVirtWorld]);
		    CreateDynamicPickup(19132,23,Hostels[j][kExitPos_Two][0], Hostels[j][kExitPos_Two][1], Hostels[j][kExitPos_Two][2], Hostels[j][kVirtWorld]);   */
		}
	}
	printf( "[Load] Apartment Loaded - [%d]", rows );
	return true;
}
