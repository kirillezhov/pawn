function San_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED( KEY_WALK ) )
	{
		if( IsPlayerInRangeOfPoint( playerid, 1.5, PICKUP_NETWORK ) ) 
		{
			if( !GetPhoneNumber( playerid ) ) 
				return SendClient:( playerid, C_WHITE, !""gbError"��� ������ ���������� ��������� �������." );
				
			if( COUNT_ADVERTS >= MAX_ADVERT_INFO ) 
				return SendClient:( playerid, C_WHITE, !""gbError"������� ������ �����������, ���������� �����." );
				
			format:g_string( "\
				"cBLUE"������ ����������\n\n\
				"cWHITE"����� ���������� ������ ���� ������������� � �� ������ ���������\n\
				����������� ���������. ����� �������� - "cBLUE"100"cWHITE".\n\
				"gbDefault"��������� ���������� - $%d.", NETWORK_ADPRICE );
			showPlayerDialog( playerid, d_cnn, DIALOG_STYLE_INPUT, " ", g_string, "�����", "�������" );
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
		return SendClient:( playerid, C_WHITE, !""gbError"��� ���������� ��� ���������." );
	}

	new
		amount;
	clean:<g_big_string>;
	
	strcat( g_big_string, ""cWHITE"�����������\t"cWHITE"�����\t"cWHITE"������" );
	
	for( new i; i < MAX_ADVERT_INFO; i++ )
	{
		if( AD[i][a_text][0] != EOS )
		{
			format:g_small_string( "\n"cBLUE"%d."cWHITE"%s\t"cWHITE"%d\t"cWHITE"%s",
				amount + 1, AD[i][a_name], AD[i][a_phone], !AD[i][a_used] ? (""cBLUE"���������") : (""cGREEN"�����������") );
		
			strcat( g_big_string, g_small_string );
			
			g_dialog_select[playerid][amount] = i;
			amount++;
		}
	}

	showPlayerDialog( playerid, d_cnn + 2, DIALOG_STYLE_TABLIST_HEADERS, "������ ����������", g_big_string, "�������", "�����" );
	
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