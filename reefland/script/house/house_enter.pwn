
function House_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED(KEY_WALK) )
	{
		for( new h; h < MAX_HOUSE; h++ ) 
		{
			if( HouseInfo[h][hID] ) 
			{
				if( IsPlayerInRangeOfPoint( playerid, 1.5, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] ) 
					&& HouseInfo[h][hType] == GetPlayerVirtualWorld( playerid ) ) 
				{
					if( HouseInfo[h][huID] == INVALID_PARAM ) 
					{
						format:g_small_string( "\
							"cWHITE"%s #%d\n\n\
							Интерьер: "cBLUE"%s"cWHITE"\n\
							Рыночная стоимость: "cBLUE"$%d"cWHITE"\n\
							Коммунальные: "cBLUE"$%d/день"cWHITE"\n\
							Аренда: "cBLUE"$%d/день", 
							!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
							HouseInfo[h][hID],
							GetNameInteriorHouse( h ),
							HouseInfo[h][hPrice],
							GetPricePaymentHouse( h ),
							GetPriceRentHouse( h ) );
							
						SetPVarInt( playerid, "House:EnterId", h );
						return showPlayerDialog( playerid, d_house, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Войти", "Закрыть" );
					}
					
					if( !HouseInfo[h][hLock] ) 
						return SendClient:( playerid, C_WHITE, ""gbDefault"Двери дома закрыты на ключ." );
						
					SetPlayerInterior( playerid, 1 );
					SetPlayerVirtualWorld( playerid, HouseInfo[h][hID] );
					
					Player[playerid][tgpsPos][0] = HouseInfo[h][hEnterPos][0];
					Player[playerid][tgpsPos][1] = HouseInfo[h][hEnterPos][1];
					Player[playerid][tgpsPos][2] = HouseInfo[h][hEnterPos][2];
					
					setPlayerPos( playerid, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] );
					SetPlayerFacingAngle( playerid, HouseInfo[h][hExitPos][3] );
					
					setHouseWeather( playerid );
					
					break;
				}
				else if( IsPlayerInRangeOfPoint( playerid, 1.5, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] ) 
					&& HouseInfo[h][hID] == GetPlayerVirtualWorld( playerid ) ) 
				{
					if( !HouseInfo[h][hLock] && HouseInfo[h][huID] != INVALID_PARAM ) 
						return SendClient:( playerid, C_WHITE, ""gbDefault"Двери дома закрыты на ключ." );
					
					checkPlayerUseTexViewer( playerid );
					
					setPlayerPos( playerid, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] );
					SetPlayerFacingAngle( playerid, HouseInfo[h][hEnterPos][3] + 180.0 );
					
					SetPlayerInterior( playerid, 0 );
					SetPlayerVirtualWorld( playerid, HouseInfo[h][hType] );
					
					Player[playerid][tgpsPos][0] = 
					Player[playerid][tgpsPos][1] = 
					Player[playerid][tgpsPos][2] = 0.0;
					
					DeletePVar( playerid, "User:inInt" ), UpdateWeather( playerid );

					DeletePVar( playerid, "House:EnterId" );
					break;
				}
			}
		}

		if( IsPlayerInRangeOfPoint( playerid, 1.0, 1072.4669, -342.6463, 2797.7004 ) ) 
		{
			if( g_player_interaction{playerid} )
				return SendClient:( playerid, C_WHITE, ""gbError"В данный момент Вы не можете воспользоваться услугами агентства." );
			
			showPlayerDialog( playerid, d_buy_menu, DIALOG_STYLE_LIST, 
				"Агентство недвижимости", 
				"1. "cGRAY"Каталог жилья{ffffff}\
				\n2. "cGRAY"Каталог бизнесов", 
				"Дальше", "Закрыть" );
		
			g_player_interaction{playerid} = 1;
			
			return 1;	
		}		
	}

	return 1;
}

stock setHouseWeather( playerid ) 
{
	SetPlayerTime( playerid, 11, 0 );
	SetPlayerWeather( playerid, 3 );
	SetPVarInt( playerid, "User:inInt", 1 );
	return 1;
}