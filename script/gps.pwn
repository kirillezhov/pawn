
new gps_cat[][32] = 
{
	{ "��������������� �����������" },
	{ "������ �����������" },
	{ "������" },
	{ "��������� ���������" },
	{ "������������ ����" }
};

enum gps_info 
{ 
	gps_category,
	gps_text				[ 128 char ],
	Float:gps_pos			[ 3 ]
}

new const
	gps_cat_check[][gps_info] = 
	{
		{ 0, !"����� 'City Hall'", { 1480.7650,-1736.5615,13.3828 } },
		{ 0, !"����������� ����", { 1461.9851,-1029.1039,23.6563 } },
		{ 0, !"����������� ����������� 'LS'", { 1536.2625,-1672.7974,13.3828 } },
		{ 0, !"���������� �������� '77 st'", { 2801.5010,-1204.3617,26.3836 } },
		{ 0, !"����������� ����������� 'Harbour'", { 2162.8867,-2663.1294,13.5469 } },
		{ 0, !"����������� ��������� 'County'", { 2000.5913,-1447.2627,13.5606 } },
		{ 0, !"�������� ������� '101'", { 1093.7190,-1707.5149,13.3828 } },
		{ 0, !"�������� ������� '505'", { 1316.3556,-918.8550,37.9074 } },
		{ 0, !"������� ����������� '707'", { 2742.4541,-1439.3396,30.2813 } },
		{ 0, !"���� ������������ �������", { 636.8927,-572.4571,16.1875 } },
		{ 0, !"����������� ������� 'Palomino Creek'", { 2198.6775,50.6210,26.4844 } },
		{ 0, !"��������������� ���", { 2713.9333,-2503.4507,13.4937 } },
		{ 0, !"��������� ���", { 981.834,-1162.16,25.0859 } },
		{ 0, !"������������� ������� 'FD'", { 1142.2042,1368.4746,10.6810 } },
		{ 1, !"��������� ������������", { 1809.77,-1166.77,24.2266 } },
		{ 1, !"����� ��������������", { 708.5787,-1410.3665,13.3913 } },
		{ 1, !"��������� ���� 'SAN'", { 1685.0990,-1635.4109,13.3828 } },
		{ 1, !"����������� �����", { 1469.2407,-1165.3324,23.8202 } },
		{ 1, !"������� 'Baker'", { 2265.5457,-32.9019,26.3359 } },
		{ 1, !"������� 'Roosevelt'", { 2231.3706,-1305.2501,23.8520 } },
		{ 1, !"������������ ����", { -1664.0332,-2251.1865,37.7331 } },
		{ 2, !"������������ ��������", { 1190.7950,-1338.6523,13.3986 } },
		{ 2, !"������������ ��������", { 2237.8774,-2211.4446,13.2911 } },
		{ 2, !"��� 'Market'", { 943.7028,-1390.7491,13.2598 } },
		{ 2, !"��� 'Bell'", { 2529.4634,-1508.7498,23.8300 } },
		{ 2, !"��� 'Simpson'", { 1364.2821,210.8708,19.4063 } },
		{ 2, !"��� 'Harbour'", { 2120.4001,-2152.9995,13.5469 } },
		{ 2, !"������ ���������", { -507.9670,-86.5572,62.1092 } },
		{ 2, !"������ �������� ���", { 1685.1887,-1463.3378,13.5469 } },
		{ 3, !"����� 'Hilltop Farm'", { 1025.5461,-344.3430,73.9922 } },
		{ 3, !"����� 'Blueberry 48 Road'", { -27.2633,-311.9980,5.4229 } },
		{ 3, !"����� 'Spinybed'", { 2348.0732,2725.0754,10.8203 } },
		{ 3, !"����� 'Doherty'", { -1749.2855,-116.4739,3.5547 } },
		{ 3, !"����� 'Ocean Docks'", { 2423.7717,-2231.4666,13.3724 } },
		{ 4, !"��������� 'Grotti'", { 557.1735,-1256.6133,17.2422 } },
		{ 4, !"��������� 'Economy Grotti'", { 842.3514,-1040.9869,25.2378 } },
		{ 4, !"��������� 'Grotti'", { 1365.5477,409.2536,19.4063 } },
		{ 4, !"��� 'Market'", { 943.7028,-1390.7491,13.2598 } },
		{ 4, !"��� 'Bell'", { 2529.4634,-1508.7498,23.8300 } },
		{ 4, !"��� 'Simpson'", { 1364.2821,210.8708,19.4063 } },
		{ 4, !"��� 'Harbour'", { 2120.4001,-2152.9995,13.5469 } },
		{ 4, !"���������� ����������", { 1295.4329,382.1285,19.5547 } }
	},
	
	Float:gps_furniture[][] = 
	{
		{ 1791.85, -1163.12, 23.83 },
		{ 2352.0, -1412.11, 23.99 },
		{ 1252.95, 352.17, 19.55 }
	},
	
	Float:gps_weapon[][] = 
	{
		{ 1368.78, -1279.79, 13.5469 },
		{ 2400.38, -1981.39, 13.5469 },
		{ 2333.57, 61.6305, 26.7058 },
		{ 242.922, -178.37, 1.5822 }
	};

new gps_select	[ MAX_PLAYERS ][ sizeof gps_cat_check ];

CMD:gps( playerid ) 
{
	if( GetPVarInt( playerid, "Job:Food" ) )
		return SendClient:( playerid, C_WHITE, !""gbError"����� ��������������� GPS-�����������, ������� ��������� ����� �������." );

	if( !g_player_gps{playerid} ) 
	{
		clean:<g_big_string>;
		for( new i; i < sizeof gps_cat; i++ ) 
		{
			format:g_small_string( ""cBLUE"-"cWHITE" %s\n", gps_cat[i] );
			strcat( g_big_string, g_small_string );
		}
		
		format:g_small_string( "%s", static_gps );
		strcat( g_big_string, g_small_string );
		
		showPlayerDialog( playerid, d_gps, DIALOG_STYLE_LIST, " ", g_big_string, "�����", "�������" );
	}
	else 
	{
		g_player_gps{playerid} = 0;
        DisablePlayerCheckpoint( playerid );
		SendClient:( playerid, C_GRAY, ""gbSuccess"�� ������ ����� � ������ GPS-����������." );
		
		if( GetPVarInt( playerid, "GPSuse" ) )
		{
			DeletePVar( playerid, "GPSuse" );
			DeletePVar( playerid, "GPSplayer" );
		}
	}
	
	return 1;
}

GPS_OnPlayerEnterCheckpoint( playerid ) 
{
	if( g_player_gps{playerid} ) 
	{
		DisablePlayerCheckpoint( playerid );
		g_player_gps{playerid} = 0;
		SendClient:( playerid, C_WHITE, ""gbSuccess"�� �������� ����� ���������� �� GPS-����������." );
	}
	
	return 1;
}

function GPS_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_gps: 
		{
			if( !response ) 
				return 1;
				
			new 
				gps_dialog = sizeof gps_cat;
			
			if( listitem == gps_dialog ) 
			{
				showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					����� ���� ���\n\
					����� ���� ������\n\
					����� ��������� �������\n\
					����� ��������� ���������\n\
					����� ��������� ������������", "�����", "�����" );
			}
			else 
			{
				new 
					slot,
					string[64];
				
				clean:<g_big_string>;
				
				for( new i; i < sizeof gps_cat_check; i++ ) 
				{
					if( gps_cat_check[i][gps_category] != listitem ) 
						continue; 
					
					strunpack( string, gps_cat_check[i][gps_text] );
					
					format:g_small_string( ""cBLUE"-"cWHITE" %s\n", string );
					strcat( g_big_string, g_small_string );
					gps_select[playerid][slot] = i;
					slot++;
				}
				
				showPlayerDialog( playerid, d_gps + 1, DIALOG_STYLE_LIST, " ", g_big_string, "�����", "�����" );
			}
		}
		
		case d_gps + 1: 
		{
			if( !response ) return cmd_gps( playerid ), DeletePVar( playerid, "Player:GPSCat" );
			
			new 
				i = gps_select[playerid][listitem];
				
			SetPlayerCheckpoint( playerid, gps_cat_check[i][gps_pos][0], gps_cat_check[i][gps_pos][1], gps_cat_check[i][gps_pos][2], 5.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"�� ���������� ����� �� GPS-����������. ��� ������ ����������� - "cBLUE"/gps"cWHITE"");
		}
		
		case d_gps + 2: 
		{
		    if( !response ) return cmd_gps( playerid ), DeletePVar( playerid, "Player:GPSCat" );
		    
			if( listitem == 0 )
			{
				if( !ShowHousePlayerList( playerid, d_gps + 5, "�����", "�����" ) )
				{
					return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
						����� ���� ���\n\
						����� ���� ������\n\
						����� ��������� �������\n\
						����� ��������� ���������\n\
						����� ��������� ������������", "�����", "�����" );
				}	
			}
			else if( listitem == 1 )
			{
				if( !ShowBusinessPlayerList( playerid, d_gps + 6, "�����", "�����" ) )
				{
					return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
						����� ���� ���\n\
						����� ���� ������\n\
						����� ��������� �������\n\
						����� ��������� ���������\n\
						����� ��������� ������������", "�����", "�����" );
				}
			}
			if( listitem == 2 )
			{
				showPlayerDialog( playerid, d_gps + 3, DIALOG_STYLE_LIST, " ", "\
					������� ������\n\
					������� ������\n\
					������� �����������\n\
					������� �����������\n\
					������� �������\n\
					��������� �������", "�����", "�����" );
			}
			else if( listitem == 3 )
			{
				showPlayerDialog( playerid, d_gps + 4, DIALOG_STYLE_LIST, " ", "\
					��������\n\
					����������\n\
					���", "�����", "�����" );
			}
			else if( listitem == 4 )
			{
				new
					Float:x,
					Float:y,
					Float:z;
			
				findShop( playerid, 3, 0, -1, x, y, z );
				SetPlayerCheckpoint( playerid, x, y, z, 3.0 );
			
				g_player_gps{playerid} = 1;
				SendClient:( playerid, C_WHITE, ""gbDefault"�� ���������� ����� �� GPS-����������. ��� ������ ����������� - "cBLUE"/gps"cWHITE"");
			}
		}
		
		case d_gps + 3: 
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					����� ���� ���\n\
					����� ���� ������\n\
					����� ��������� �������\n\
					����� ��������� ���������\n\
					����� ��������� ������������", "�����", "�����" );
			}
			
			new
				Float:x,
				Float:y,
				Float:z;
			
			switch( listitem )
			{
				case 0: findShop( playerid, 1, 0, -1, x, y, z );
				case 1: findShop( playerid, 0, 3, 0, x, y, z );
				case 2: findShop( playerid, 0, 3, 1, x, y, z );
				case 3: findShop( playerid, 0, 3, 2, x, y, z );
				case 4: findShop( playerid, 0, 3, 3, x, y, z );
				case 5: findShop( playerid, 2, 0, -1, x, y, z );
			}
			
			SetPlayerCheckpoint( playerid, x, y, z, 3.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"�� ���������� ����� �� GPS-����������. ��� ������ ����������� - "cBLUE"/gps"cWHITE"");
		}
		
		case d_gps + 4: 
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					����� ���� ���\n\
					����� ���� ������\n\
					����� ��������� �������\n\
					����� ��������� ���������\n\
					����� ��������� ������������", "�����", "�����" );
			}
			
			new
				Float:x,
				Float:y,
				Float:z;
			
			switch( listitem )
			{
				case 0: findShop( playerid, 0, 1, -1, x, y, z );
				case 1: findShop( playerid, 0, 0, -1, x, y, z );
				case 2: findShop( playerid, 0, 2, -1, x, y, z );
			}
			
			SetPlayerCheckpoint( playerid, x, y, z, 3.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"�� ���������� ����� �� GPS-����������. ��� ������ ����������� - "cBLUE"/gps"cWHITE"");
		}
		
		case d_gps + 5:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					����� ���� ���\n\
					����� ���� ������\n\
					����� ��������� �������\n\
					����� ��������� ���������\n\
					����� ��������� ������������", "�����", "�����" );
			}
			
			new
				h = g_dialog_select[playerid][listitem];
				
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			SetPlayerCheckpoint( playerid, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2], 3.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"�� ���������� ����� �� GPS-����������. ��� ������ ����������� - "cBLUE"/gps"cWHITE"");
		}
		
		case d_gps + 6:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_gps + 2, DIALOG_STYLE_LIST, " ", "\
					����� ���� ���\n\
					����� ���� ������\n\
					����� ��������� �������\n\
					����� ��������� ���������\n\
					����� ��������� ������������", "�����", "�����" );
			}
			
			new
				b = g_dialog_select[playerid][listitem];
				
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			SetPlayerCheckpoint( playerid, BusinessInfo[b][b_enter_pos][0], BusinessInfo[b][b_enter_pos][1], BusinessInfo[b][b_enter_pos][2], 3.0 );
			
			g_player_gps{playerid} = 1;
			SendClient:( playerid, C_WHITE, ""gbDefault"�� ���������� ����� �� GPS-����������. ��� ������ ����������� - "cBLUE"/gps"cWHITE"");
		}
	}
	
	return 1;
}

function findShop( playerid, type, subtype, shop, &Float:x, &Float:y, &Float:z )
{
	new
		Float:minimum = 0.0;
		
	switch( type )
	{	
		//������
		case 0:
		{
			new
				Float:spos[ 90 ];
				
			for( new i; i < MAX_BUSINESS; i++ )
			{
				if( !BusinessInfo[i][b_id] || BusinessInfo[i][b_type] != subtype ) continue;
				
				if( shop != INVALID_PARAM )
				{
					switch( shop )
					{
						//�������� ������
						case 0:
						{
							if( BusinessInfo[i][b_shop] < 2 || BusinessInfo[i][b_shop] > 5 ) continue;
						}
						//�������� �����������
						case 1:
						{
							if( BusinessInfo[i][b_shop] < 6 ) continue;
						}
						//�������� �����������
						case 2:
						{
							if( BusinessInfo[i][b_shop] != 1 ) continue;
						}
						//�������� ��� ��� ������
						case 3:
						{
							if( BusinessInfo[i][b_shop] ) continue;
						}
					}
				}
				
				spos[i] = GetPlayerDistanceFromPoint( playerid, BusinessInfo[i][b_enter_pos][0], BusinessInfo[i][b_enter_pos][1], BusinessInfo[i][b_enter_pos][2] );
			
				if( minimum == 0.0 )
				{
					minimum = spos[i];
					
					x = BusinessInfo[i][b_enter_pos][0];
					y = BusinessInfo[i][b_enter_pos][1];
					z = BusinessInfo[i][b_enter_pos][2];
					
					continue;
				}
			
				if( spos[i] < minimum )
				{
					minimum = spos[i];
					
					x = BusinessInfo[i][b_enter_pos][0];
					y = BusinessInfo[i][b_enter_pos][1];
					z = BusinessInfo[i][b_enter_pos][2];
				}
			}
		}
		//������� ������
		case 1:
		{
			new
				Float:spos[ sizeof gps_furniture ];
		
			for( new i; i < sizeof gps_furniture; i++ )
			{
				spos[i] = GetPlayerDistanceFromPoint( playerid, gps_furniture[i][0], gps_furniture[i][1], gps_furniture[i][2] );
			
				if( !i ) 
				{
					minimum = spos[i];
					
					x = gps_furniture[i][0];
					y = gps_furniture[i][1];
					z = gps_furniture[i][2];
					
					continue;
				}
			
				if( spos[i] < minimum )
				{
					minimum = spos[i];
					
					x = gps_furniture[i][0];
					y = gps_furniture[i][1];
					z = gps_furniture[i][2];
				}
			}
		}
		//��������� �������
		case 2:
		{
			new
				Float:spos[ sizeof gps_weapon ];
		
			for( new i; i < sizeof gps_weapon; i++ )
			{
				spos[i] = GetPlayerDistanceFromPoint( playerid, gps_weapon[i][0], gps_weapon[i][1], gps_weapon[i][2] );
			
				if( !i ) 
				{
					minimum = spos[i];
					
					x = gps_weapon[i][0];
					y = gps_weapon[i][1];
					z = gps_weapon[i][2];
					
					continue;
				}
			
				if( spos[i] < minimum )
				{
					minimum = spos[i];
					
					x = gps_weapon[i][0];
					y = gps_weapon[i][1];
					z = gps_weapon[i][2];
				}
			}
		}
		//������������
		case 3:
		{
			new
				Float:spos[ sizeof gas_station_pos ];
		
			for( new i; i < sizeof gas_station_pos; i++ )
			{
				if( gas_station_pos[i][gas_frac] ) continue;
			
				spos[i] = GetPlayerDistanceFromPoint( playerid, gas_station_pos[i][gas_pos][0], gas_station_pos[i][gas_pos][1], gas_station_pos[i][gas_pos][2] );
			
				if( !i ) 
				{
					minimum = spos[i];
					
					x = gas_station_pos[i][gas_pos][0];
					y = gas_station_pos[i][gas_pos][1];
					z = gas_station_pos[i][gas_pos][2];
					
					continue;
				}
			
				if( spos[i] < minimum )
				{
					minimum = spos[i];
					
					x = gas_station_pos[i][gas_pos][0];
					y = gas_station_pos[i][gas_pos][1];
					z = gas_station_pos[i][gas_pos][2];
				}
			}
		}
	}
}