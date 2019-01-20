
stock showHouseList( playerid, type, page ) 
{
	SetPVarInt( playerid, "HBuy:List", page );
	SetPVarInt( playerid, "HBuy:Type", type );
	
	clean: <g_big_string>;
	
	strcat( g_big_string, ""cWHITE"��������\t"cWHITE"���������\n" );
	
	new 
		idx,
		list;
		
	switch( type ) 
	{
		case 1: 
		{
			for( new h = idx; h < MAX_HOUSE; h++ ) 
			{
				if( HouseInfo[h][hID] && HouseInfo[h][huID] == INVALID_PARAM ) 
				{
					if( page && idx != page * HBUY_LIST )
					{
						idx++;
						continue;
					}
				
					format:g_small_string( ""cWHITE"%d. %s #%d\t"cBLUE"$%d\n", 
						idx + ( list + 1 ),
						!HouseInfo[h][hType] ? ("���") : ("��������"),
						HouseInfo[h][hID], 
						HouseInfo[h][hPrice] );
					
					strcat( g_big_string, g_small_string );

					g_dialog_select[playerid][list] = h;
					list++;
					
					if( list == HBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"��������� ��������" );
						break;
					}
					
				}
			}
			
			if( page || ( page && list < HBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"���������� ��������" );
			
			if( !list && !page ) 
			{
				SendClient:( playerid, C_WHITE, ""gbError"��� �����, ���������� ��� �������." );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "�����", "�����" );
			}
			
			SetPVarInt( playerid, "HBuy:Last", list );
			
			showPlayerDialog( playerid, d_buy_menu + 2, DIALOG_STYLE_TABLIST_HEADERS, 
				"������ ����� ���������� ��� �������", g_big_string, "�����", "�����" );
		}
		// ���������� �� ���������
		case 2: 
		{
			new 
				price[2]; 
			
			price[0] = GetPVarInt( playerid, "HBuy:PriceM" ),
			price[1] = GetPVarInt( playerid, "HBuy:PriceH" );
			
			for( new h = idx; h < MAX_HOUSE; h++ ) 
			{
				if( HouseInfo[h][hPrice] <= price[1] && HouseInfo[h][hPrice] >= price[0] && 
					HouseInfo[h][hID] && HouseInfo[h][huID] == INVALID_PARAM ) 
				{
					if( page && idx != page * HBUY_LIST )
					{
						idx++;
						continue;
					}
					
					format:g_small_string( ""cWHITE"%d. %s #%d\t"cBLUE"$%d\n", 
						idx + ( list + 1 ),
						!HouseInfo[h][hType] ? ("���") : ("��������"),
						HouseInfo[h][hID], 
						HouseInfo[h][hPrice] );
					
					strcat( g_big_string, g_small_string );

					g_dialog_select[playerid][list] = h;
					list++;
					
					if( list == HBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"��������� ��������" );
						break;
					}
				}	
			}
			
			if( page || ( page && list < BBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"���������� ��������" );
			
			if( !list && !page ) 
			{
				showPlayerDialog( playerid, d_buy_menu + 3, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"���������� �� ���������\n\n\
					"cWHITE"������� �������� ��� ��� ��������� ������������� �����:\
					\n������: "cBLUE"60000-200000\n\n\
					"gbDialogError"�� ������� ������� ����� �� �������.", "����", "�����" );
				SetPVarInt( playerid, "HBuy:case", 2 );
				return 1;
			}
			
			SetPVarInt( playerid, "HBuy:Last", list );
			
			showPlayerDialog( playerid, d_buy_menu + 2, DIALOG_STYLE_TABLIST_HEADERS, 
				"������ ����� ���������� ��� �������", g_big_string, "�����", "�����" );
		}
		
		case 3:
		{
			new
				type_one = GetPVarInt( playerid, "HBuy:TypeOne" ),
				type_two = GetPVarInt( playerid, "HBuy:TypeTwo" );
				
			for( new h; h < MAX_HOUSE; h++ ) 
			{
				if( HouseInfo[h][hID] && HouseInfo[h][huID] == INVALID_PARAM &&
					HouseInfo[h][hType] == type_one && GetTypeHouse( h ) == type_two ) 
				{
					if( page && idx != page * HBUY_LIST )
					{
						idx++;
						continue;
					}
				
					format:g_small_string( ""cWHITE"%d. %s #%d\t"cBLUE"$%d\n", 
						idx + ( list + 1 ),
						!HouseInfo[h][hType] ? ("���") : ("��������"),
						HouseInfo[h][hID], 
						HouseInfo[h][hPrice] );
					
					strcat( g_big_string, g_small_string );

					g_dialog_select[playerid][list] = h;
					list++;
					
					if( list == HBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"��������� ��������" );
						break;
					}
					
					continue;
				}
			}
			
			if( page || ( page && list < BBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"���������� ��������" );
			
			if( !list && !page ) 
			{
				DeletePVar( playerid, "HBuy:TypeTwo" );
				SendClient:( playerid, C_WHITE, ""gbError"�� ������� ������� ����� �� �������." );
				
				return showPlayerDialog( playerid, d_buy_menu + 15, DIALOG_STYLE_LIST, " ", dialog_house_type, "�����", "�����" );
			}
			
			SetPVarInt( playerid, "HBuy:Last", list );
			
			showPlayerDialog( playerid, d_buy_menu + 2, DIALOG_STYLE_TABLIST_HEADERS, "������ ����� ���������� ��� �������", g_big_string, "�����", "�����" );
		}
		
		case 4:
		{
			new 
				count = 0;
				
			for( new i; i < MAX_PLAYER_HOUSE; i++ ) 
			{
				if( Player[playerid][tHouse][i] != INVALID_PARAM ) 
				{
					new
						h = Player[playerid][tHouse][i];
				
					format:g_small_string( ""cWHITE"%s #%d\t"cBLUE"$%d\n", 
						!HouseInfo[h][hType] ? ("���") : ("��������"),
						HouseInfo[h][hID], 
						HouseInfo[h][hPrice] );
						
					strcat( g_big_string, g_small_string );
					
					g_dialog_select[playerid][count] = h;
					
					count++;
				}
			}
			
			if( !count )
			{
				SendClient:( playerid, C_WHITE, ""gbError"� ��� ��� ������������ �����." );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "�����", "�����" );
			}
			
			showPlayerDialog( playerid, d_buy_menu + 16, DIALOG_STYLE_TABLIST_HEADERS, ""cWHITE"������ ������ �����", g_big_string, "�������", "�����" );
		}
	}	
	
	return 1;
}

stock showHouseBuyMenu( playerid, h ) 
{
	SetPVarInt( playerid, "HBuy:House", h );
	SetPVarInt( playerid, "HBuy:Camera", 1 );
	
	new 
		Float:dist = 6.0, 
		Float:pos[4],
		zone[28];
	
	GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
	
	SetPVarFloat( playerid, "HBuy:PX", pos[0] ),
	SetPVarFloat( playerid, "HBuy:PY", pos[1] ),
	SetPVarFloat( playerid, "HBuy:PZ", pos[2] );
	
	SetPlayerInterior( playerid, 0 );
	SetPlayerVirtualWorld( playerid, 1 );
	
	if( !HouseInfo[h][hType] ) 
	{
		setPlayerPos( playerid, 
			HouseInfo[h][hEnterPos][0] + 7.0 * -floatsin( HouseInfo[h][hEnterPos][3] + 180.0, degrees ),
			HouseInfo[h][hEnterPos][1] + 7.0 * floatcos( HouseInfo[h][hEnterPos][3] + 180.0, degrees ),
			HouseInfo[h][hEnterPos][2] );
					
		InterpolateCameraPos( playerid, 
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2],
			HouseInfo[h][hEnterPos][0] + dist * -floatsin( HouseInfo[h][hEnterPos][3] + 180.0, degrees ), 
			HouseInfo[h][hEnterPos][1] + dist * floatcos( HouseInfo[h][hEnterPos][3] + 180.0, degrees ), 
			HouseInfo[h][hEnterPos][2], 600, 1000 );
			
		InterpolateCameraLookAt( playerid, 
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2],
			HouseInfo[h][hEnterPos][0], 
			HouseInfo[h][hEnterPos][1], 
			HouseInfo[h][hEnterPos][2], 600, 1000);

		GetPos2DZone( HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], zone, 28 );
	}
	else 
	{
		for( new i; i < sizeof Hostels; i++) 
		{
			if( Hostels[i][kVirtWorld] == HouseInfo[h][hType] ) 
			{
				setPlayerPos( playerid, 
					Hostels[i][kEnterPos][0] + 7.0 * -floatsin( Hostels[i][kEnterPos][2] + 180.0,degrees), 
					Hostels[i][kEnterPos][1] + 7.0 * floatcos( Hostels[i][kEnterPos][2] + 180.0,degrees), 
					Hostels[i][kEnterPos][2] );
					
				SetPlayerCameraPos( playerid, 
					Hostels[i][kCamPos][0], 
					Hostels[i][kCamPos][1], 
					Hostels[i][kCamPos][2] );
					
				SetPlayerCameraLookAt( playerid, 
					Hostels[i][kEnterPos][0], 
					Hostels[i][kEnterPos][1], 
					Hostels[i][kEnterPos][2] );
					
				GetPos2DZone( Hostels[i][kEnterPos][0], Hostels[i][kEnterPos][1], zone, 28 );
					
				break;
			}
		}	
	}
	
	format:g_big_string( "\
		"cBLUE"���������� � %s\n\n\
		"cWHITE"����� %s: "cBLUE"%d\n\
		"cWHITE"�������� ��������� %s: "cBLUE"$%d"cWHITE"\n\
		������������: "cBLUE"$%d/����"cWHITE"\n\
		������: "cBLUE"$%d/����\n\n\
		"cWHITE"�����: "cBLUE"%s",
		!HouseInfo[h][hType] ? ("����") : ("��������"),
		!HouseInfo[h][hType] ? ("����") : ("��������"),
		HouseInfo[h][hID], 
		!HouseInfo[h][hType] ? ("����") : ("��������"),
		HouseInfo[h][hPrice],
		GetPricePaymentHouse( h ),
		GetPriceRentHouse( h ),
		zone
	);

	showPlayerDialog( playerid, d_buy_menu + 12, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "�����" );
	
	return 1;
}

