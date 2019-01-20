function San_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED( KEY_WALK ) )
	{
		if( IsPlayerInRangeOfPoint( playerid, 1.5, PICKUP_NETWORK ) ) 
		{
			if( !GetPhoneNumber( playerid ) ) 
				return SendClient:( playerid, C_WHITE, !""gbError"Для подачи объявления необходим телефон." );
				
			if( COUNT_ADVERTS >= MAX_ADVERT_INFO ) 
				return SendClient:( playerid, C_WHITE, !""gbError"Бегущая строка перегружена, попробуйте позже." );
				
			format:g_string( "\
				"cBLUE"Подать объявление\n\n\
				"cWHITE"Текст объявления должен быть информативным и не должен содержать\n\
				нецензурных выражений. Лимит символов - "cBLUE"100"cWHITE".\n\
				"gbDefault"Стоимость объявления - $%d.", NETWORK_ADPRICE );
			showPlayerDialog( playerid, d_cnn, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
		}
	}
	
	return 1;
}

function LoadGlobalSan()
{
	new 
		row = cache_get_row_count();
		
	if( !row ) return 1;	
	
	NETWORK_COFFER = cache_get_field_content_int( 0, "san_coffers", mysql );
	NETWORK_ADPRICE = cache_get_field_content_int( 0, "san_adprice", mysql );
	
	printf( "[SAN] Coffers load - $%d", NETWORK_COFFER );
	printf( "[SAN] Adprice load - $%d", NETWORK_ADPRICE );

	return 1;
}

stock ShowAds( playerid )
{
	if( !COUNT_ADVERTS ) 
	{
		g_player_interaction{playerid} = 0;
		return SendClient:( playerid, C_WHITE, !""gbError"Нет объявлений для модерации." );
	}

	new
		amount;
	clean:<g_big_string>;
	
	strcat( g_big_string, ""cWHITE"Отправитель\t"cWHITE"Номер\t"cWHITE"Статус" );
	
	for( new i; i < MAX_ADVERT_INFO; i++ )
	{
		if( AD[i][a_text][0] != EOS )
		{
			format:g_small_string( "\n"cBLUE"%d."cWHITE"%s\t"cWHITE"%d\t"cWHITE"%s",
				amount + 1, AD[i][a_name], AD[i][a_phone], !AD[i][a_used] ? (""cBLUE"Ожидается") : (""cGREEN"Проверяется") );
		
			strcat( g_big_string, g_small_string );
			
			g_dialog_select[playerid][amount] = i;
			amount++;
		}
	}

	showPlayerDialog( playerid, d_cnn + 2, DIALOG_STYLE_TABLIST_HEADERS, "Список объявлений", g_big_string, "Выбрать", "Назад" );
	
	return 1;
}

function San_OnPlayerDeath( playerid, killerid, reason )
{
	if( GetPVarInt( playerid, "San:AdvertId" ) ) 
		AD[ GetPVarInt( playerid, "San:AdvertId" ) ][a_used] = false;
		
	if( GetPVarInt( playerid, "San:Call" ) )
		ETHER_CALLID = INVALID_PARAM;
		
	if( playerid == ETHER_STATUS )
	{
		ETHER_STATUS = INVALID_PARAM;
		
		ETHER_CALL = 
		ETHER_SMS = false;
	}
	
	if( Player[playerid][tEther] )
		Player[playerid][tEther] = false;
		
	ClearPlayerPVarData( playerid );
		
	return 1;
}

function San_OnPlayerDisconnect( playerid )
{
	if( playerid == ETHER_STATUS )
	{
		ETHER_STATUS = INVALID_PARAM;
		
		ETHER_CALL = 
		ETHER_SMS = false;
	}

	if( GetPVarInt( playerid, "San:Call" ) )
		ETHER_CALLID = INVALID_PARAM;
		
	if( GetPVarInt( playerid, "San:AdvertId" ) ) 
		AD[ GetPVarInt( playerid, "San:AdvertId" ) ][a_used] = false;
	
	return 1;
}