
stock lockHouse( playerid ) {
	for( new h; h < sizeof HouseInfo; h++ ) {
		if( ( IsPlayerInRangeOfPoint( playerid, 1.5, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] ) && HouseInfo[h][hEnterWorld] == GetPlayerVirtualWorld( playerid ) ) 
			|| ( IsPlayerInRangeOfPoint( playerid, 1.5, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] ) && HouseInfo[h][hID] == GetPlayerVirtualWorld( playerid ) ) ) {
			if( Player[playerid][uHouse] != HouseInfo[h][hID] ) return SendClient:( playerid, -1, ""gbError"У вас нет ключей от этого дома!" );
			if( HouseInfo[h][hLock] ) {
				HouseInfo[h][hLock] = 0;
				format:g_small_string(  "открыл%s дверь дома", Player[playerid][uSex] == 1 ? (""):("a") );
				GameTextForPlayer( playerid, "~g~UNLOCK", 3000, 3 );
			}
			else {
				HouseInfo[h][hLock] = 1;
				format:g_small_string(  "закрыл%s дверь дома", Player[playerid][uSex] == 1 ? (""):("a") );
				GameTextForPlayer( playerid, "~r~LOCK", 3000, 3 );
			}
			houseUpdate( HouseInfo[h][hID], "hLock", HouseInfo[h][hLock] );
			MeAction( playerid, g_small_string, 1 );
		}	
	}
	return true;
}

new ev_slot[MAX_PLAYERS][MAX_EVICT];

HPanel_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) { 
	new evict = GetPVarInt( playerid, "House:Evict" );
	if( PRESSED(KEY_NO) ) {
		if( evict != -1 ) {
			format:g_small_string( "Вы отказались подселяется в дом к игроку %s", Player[ evict ][uName] );
			SendClient:( playerid, C_WHITE, g_small_string );
			format:g_small_string(  "Игрок %s отказался подселятся к вам в дом!", Player[playerid][uName] );
			SendClient:( evict, C_WHITE, g_small_string );
			
			SetPVarInt( playerid, "House:Evict", -1 );
		}		
	}
	else if( PRESSED( KEY_YES ) ) {
		if( evict != -1 ) {
			Player[playerid][uHouse] = Player[evict][uHouse];
			UpdatePlayer( playerid, "uHouse", Player[playerid][uHouse] );
			format:g_small_string(  ""gbDefault"Вы успешно подселили к себе игрока %s", Player[playerid][uName] );
			SendClient:( evict, C_WHITE, g_small_string );
			format:g_small_string(  ""gbDefault"Вы успешно подселились к игроку %s", Player[evict][uName] );
			SendClient:( playerid, C_WHITE, g_small_string );
			SetPVarInt( playerid, "House:Evict", -1 );
		}
	}
	return true;
}

CMD:evict( playerid, params[] ) {
	if( !Player[playerid][uHouse] ) return SendClient:( playerid, C_GRAY, ""gbError"У вас нет дома!" );
	if( sscanf( params, "u", params[0] ) ) return SendClient:( playerid, C_GRAY, ""gbDefault"Введите: /evict [ id ]" );
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) return SendClient:( playerid, C_GRAY, ""gbError"Данного игрока нет рядом с вами!");
	if( Player[ params[0] ][uHouse] ) return SendClient:( playerid, C_GRAY, ""gbError"У игрока уже есть дом в котором он проживает!" );
	if( playerid == params[0] ) return SendClient:( playerid, C_GRAY, ""gbError"Вы не можете подселить себя!" );
	for( new h; h < sizeof HouseInfo; h++ ) {
		if( HouseInfo[h][hID] == Player[playerid][uHouse] ) {
			if( HouseInfo[h][hOwned] == Player[playerid][uID] ) {
				SetPVarInt( params[0], "House:Evict", playerid );
				format:g_small_string( ""gbDefault"Вы предложили игроку "cGREEN"%s"cWHITE" поселиться у Вас в доме", Player[params[0]][uName] );
				SendClient:( playerid, C_WHITE, g_small_string );
				format:g_small_string( ""gbDefault"Игрок "cGREEN"%s"cWHITE" хочет поселить Вас в его дом", Player[playerid][uName] );
				SendClient:( params[0], C_WHITE, g_small_string );
				SendClient:( params[0], C_GRAY, "{1081C7}>> {FAEBD7}Нажмите {33AA33}Y{FAEBD7}, чтобы согласиться или {FF6347}N{FAEBD7}, чтобы отказаться" );
				return true;
			}
		}
	}
	SendClient:( playerid, C_GRAY, ""gbError"Вы не владелец дома!" );
	return true;
}

CMD:hevict( playerid, params[] ) {
	if( !Player[playerid][uHouse] ) return SendClient:( playerid, C_GRAY, ""gbError"У вас нет дома" );
	for( new i; i < sizeof HouseInfo; i++ ) {
		if( HouseInfo[i][hID] == Player[playerid][uHouse] ) {
			if( HouseInfo[i][hOwned] == Player[playerid][uID] ) {
				return SendClient:( playerid, -1, ""gbError"Ошибка, вы являетесь владельцем дома и не можете выселиться!" );
			}
			break;
		}
	}
	Player[playerid][uHouse] = 0;
	UpdatePlayer( playerid, "uHouse", 0 );
	SendClient:( playerid, C_GRAY, ""gbSuccess"Вы успешно выселились из дома!" );
	return true;
}