function House_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_house :
		{
			if( !response )	
			{
				DeletePVar( playerid, "House:EnterId" );
				return 1;
			}
			
			new
				h = GetPVarInt( playerid, "House:EnterId" );
			
			if( !IsPlayerInRangeOfPoint( playerid, 2.0, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] ) )
			{
				DeletePVar( playerid, "House:EnterId" );
				return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� ����� � ������� ������." );
			}
				
			SetPlayerInterior( playerid, 1 );
			SetPlayerVirtualWorld( playerid, HouseInfo[h][hID] );
			
			Player[playerid][tgpsPos][0] = HouseInfo[h][hEnterPos][0];
			Player[playerid][tgpsPos][1] = HouseInfo[h][hEnterPos][1];
			Player[playerid][tgpsPos][2] = HouseInfo[h][hEnterPos][2];
	
			setPlayerPos( playerid, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] );
			SetPlayerFacingAngle( playerid, HouseInfo[h][hExitPos][3] );
			
			setHouseWeather( playerid );
		}
	
		case d_buy_menu: 
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			switch( listitem ) 
			{
				case 0: 
				{ // ������� �����
					showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "�����", "�����" );
				}
				
				case 1: 
				{ // ������� ��������
					showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
						"1. ������ ���� ��������\n2. ���������� �� ���������\
						\n3. ���������� �� ���� �������\n4. ������� ������� �� ������\
						\n5. ������� ������", "�����", "�����" );
				}
			}
		
		}
		
		case d_buy_menu + 1: 
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_buy_menu, DIALOG_STYLE_LIST, 
					"��������� ������������", "\
					1. "cGRAY"������� �����\n\
					2. "cGRAY"������� ��������", 
					"�����", "�������" );
			}
			
			switch( listitem ) 
			{
				case 0: 
				{	// ������ ���� �����
					showHouseList( playerid, 1, 0 );
					SetPVarInt( playerid, "HBuy:case", 1 );
				}
				
				case 1: 
				{	// ���������� �� ���������
					showPlayerDialog( playerid, d_buy_menu + 3, DIALOG_STYLE_INPUT, " ", 
						""cBLUE"���������� �� ���������\n\n\
						"cWHITE"������� �������� ��� ��� ��������� ������������� �����:\
						\n������: "cBLUE"60000-200000", "����", "�����" );
					SetPVarInt( playerid, "HBuy:case", 2 );
				}
					// ���������� �� ����
				case 2: 
				{
					showPlayerDialog( playerid, d_buy_menu + 14, DIALOG_STYLE_LIST, " ", ""cWHITE"\
						���\n\
						��������", "�����", "�����" );
					SetPVarInt( playerid, "HBuy:case", 3 );
				}
					// ����� ��� �� ������
				case 3: 
				{
					showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"������� ������������\n\n\
						"cWHITE"������� ����� ���� (��������):", "����", "�����" );
					SetPVarInt( playerid, "HBuy:case", 4 );
				}
				
				case 4:
				{
					showHouseList( playerid, 4, 0 );
				}
			}
		}
		
		case d_buy_menu + 2: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:List" );
				
				switch( GetPVarInt( playerid, "HBuy:case" ) )
				{
					case 2:
					{
						return showPlayerDialog( playerid, d_buy_menu + 3, DIALOG_STYLE_INPUT, " ", 
							""cBLUE"���������� �� ���������\n\n\
							"cWHITE"������� �������� ��� ��� ��������� ������������� �����:\
							\n������: "cBLUE"60000-200000", "����", "�����" );
					}
					
					case 3:
					{
						DeletePVar( playerid, "HBuy:TypeTwo" );
						return showPlayerDialog( playerid, d_buy_menu + 15, DIALOG_STYLE_LIST, " ", dialog_house_type, "�����", "�����" );
					}
					
					case 4:
					{
						return showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"������� ������������\n\n\
							"cWHITE"������� ����� ���� (��������):", "����", "�����" );
					}
					
					default:
					{
						DeletePVar( playerid, "HBuy:case" );
						return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "�����", "�����" );
					}
				}
			}
			
			if( listitem == HBUY_LIST ) 
			{
				return showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) + 1 );
			}
			else if( listitem == HBUY_LIST + 1 || 
				listitem == GetPVarInt( playerid, "HBuy:Last" ) && GetPVarInt( playerid, "HBuy:Last" ) < BBUY_LIST ) 
			{
				return showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) - 1 );
			}
			
			showHouseBuyMenu( playerid, g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_buy_menu + 3: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:case" );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "�����", "�����" );
			}
			
			if( sscanf( inputtext, "p<->a<d>[2]", inputtext[0], inputtext[1] ) || inputtext[1] <= inputtext[0] )
			{
				return showPlayerDialog( playerid, d_buy_menu + 3, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"���������� �� ���������\n\n\
					"cWHITE"������� �������� ��� ��� ��������� ������������� �����:\
					\n������: "cBLUE"60000-200000\n\n\
					"gbDialogError"�� ����������� ������� ��������.", "����", "�����" );
			}
			
			SetPVarInt( playerid, "HBuy:PriceM", inputtext[0] ), 
			SetPVarInt( playerid, "HBuy:PriceH", inputtext[1] );
			DeletePVar( playerid, "HBuy:House" );
			showHouseList( playerid, 2, 0 );
		}
		
		//������ ��� ��������� ����
		case d_buy_menu + 4: 
		{
			if( !response )
			{
				setPlayerPos( playerid,
					GetPVarFloat( playerid, "HBuy:PX" ),
					GetPVarFloat( playerid, "HBuy:PY" ),
					GetPVarFloat( playerid, "HBuy:PZ") 
				);
					
				SetCameraBehindPlayer( playerid );
				
				SetPlayerVirtualWorld( playerid, 13 ), 
				SetPlayerInterior( playerid, 1 );
				
				DeletePVar( playerid, "HBuy:PX" ), 
				DeletePVar( playerid, "HBuy:PY" ),
				DeletePVar( playerid, "HBuy:PZ" ),
				DeletePVar( playerid, "HBuy:Camera" );			
				DeletePVar( playerid, "HBuy:House" );
				
				showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) );
				return 1;
			}
		
			if( listitem == 2 )
			{
				return showPlayerDialog( playerid, d_buy_menu + 13, DIALOG_STYLE_MSGBOX, " ", "\
					"cBLUE"����������\n\n\
					"cWHITE"���� � ��� ������������� ���������� �������� ������� ��� ������� ���� ( �������� ),\n\
					�� ������ ���������� ����� �������, �� ��� ���� ��������� ������� ����� ����������:\n\
					- ���������������,\n\
					- ���������� ������ �������,\n\
					- ������� ������������ ������� ������.\n\n\
					�������� ����� ������� �� ������ � ����������� �����. ������ ����� ������� �� ���������,\n\
					� � ������ ������ ������������� ��������� ������������ �����.", "�����", "" );
			}
		
			new
				h = GetPVarInt( playerid, "HBuy:House" );
					
			if( Player[playerid][uHouseEvict] )
			{
				showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					�������\n\
					������\n\
					����������", "�������", "�����" );
				return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ���������� ������������, ��� ��� ��������� � ������ ���. ����������� "cBLUE"/hevict"cWHITE", ����� ����������." );
			}
			
			if( IsOwnerHouseCount( playerid ) >= 1 + Premium[playerid][prem_house] )
			{
				showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					�������\n\
					������\n\
					����������", "�������", "�����" );
				return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ���� ����� ����������." );
			}			
				
			if( HouseInfo[h][huID] != INVALID_PARAM )
			{
				setPlayerPos( playerid,
					GetPVarFloat( playerid, "HBuy:PX" ),
					GetPVarFloat( playerid, "HBuy:PY" ),
					GetPVarFloat( playerid, "HBuy:PZ") 
				);
					
				SetCameraBehindPlayer( playerid );
				
				SetPlayerVirtualWorld( playerid, 13 ), 
				SetPlayerInterior( playerid, 1 );
				
				DeletePVar( playerid, "HBuy:PX" ), 
				DeletePVar( playerid, "HBuy:PY" ),
				DeletePVar( playerid, "HBuy:PZ" ),
				DeletePVar( playerid, "HBuy:Camera" );			
				DeletePVar( playerid, "HBuy:House" );
			
				showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) );
				return SendClient:( playerid, C_GRAY, !""gbError"���� ��� �������� ���-�� �����." );
			}
			
			if( listitem == 1 )
			{
				if( Player[playerid][uMoney] < GetPriceRentHouse( h ) )
				{
					showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
						�������\n\
						������\n\
						����������", "�������", "�����" );
					return SendClient:( playerid, C_GRAY, !""gbError"� ��� ������������ ������� ��� ������ ������ ����� ���� �� 1 ����." );
				}
			
				HouseInfo[h][hSellDate] = gettime() + 1 * 86400;
			
				format:g_small_string( "���������%s ���", SexTextEnd( playerid ) );
				MeAction( playerid, g_small_string, 1 );
				
				SetPlayerCash( playerid, "-", GetPriceRentHouse( h ) );
			
				HouseInfo[h][hRent] = 1;
				InsertPlayerHouse( playerid, h );
				
				clean:<HouseInfo[h][hOwner]>;
				strcat( HouseInfo[h][hOwner], Player[playerid][uName], MAX_PLAYER_NAME );
					
				HouseInfo[h][huID] = Player[playerid][uID];
				
				pformat:( ""gbSuccess"�� ���������� "cBLUE"%s #%d"cWHITE". �������� ����� ������������� ����������� �� "cBLUE"1"cWHITE" ����.", 
					!HouseInfo[h][hType] ? ("���") : ("��������"), 
					HouseInfo[h][hID] );
				psend:( playerid, C_WHITE );
				
				log( LOG_RENT_HOUSE, "��������� ���", Player[playerid][uID], HouseInfo[h][hID] );
				
				DestroyDynamicPickup( HouseInfo[h][hPickup] );
				
				HouseInfo[h][hPickup] = CreateDynamicPickup( 19524, 23, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2], 
					HouseInfo[h][hType], -1, -1, 30.0 );
			}
			else
			{
				if( HouseInfo[h][hPrice] > Player[playerid][uMoney] )
				{
					showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
						�������\n\
						������\n\
						����������", "�������", "�����" );
					return SendClient:( playerid, C_GRAY, !""gbError"� ��� ������������ ������� ��� ������� ����� ����." );
				}
			
				HouseInfo[h][hSellDate] = gettime() + 2 * 86400;
			
				format:g_small_string( "�����%s ���", SexTextEnd( playerid ) );
				MeAction( playerid, g_small_string, 1 );
					
				SetPlayerCash( playerid, "-", HouseInfo[h][hPrice] );
				InsertPlayerHouse( playerid, h );
				
				clean:<HouseInfo[h][hOwner]>;
				strcat( HouseInfo[h][hOwner], Player[playerid][uName], MAX_PLAYER_NAME );
					
				HouseInfo[h][huID] = Player[playerid][uID];
			
				pformat:( ""gbSuccess"�� ����� ���������� "cBLUE"%s #%d"cWHITE". ����� ������� ������������� �������� �� "cBLUE"2"cWHITE" ���.", 
					!HouseInfo[h][hType] ? ("����") : ("��������"), 
					HouseInfo[h][hID] );
				psend:( playerid, C_WHITE );
				
				log( LOG_BUY_HOUSE, "����� ���", Player[playerid][uID], HouseInfo[h][hID] );
				
				DestroyDynamicPickup( HouseInfo[h][hPickup] );
				
				HouseInfo[h][hPickup] = CreateDynamicPickup( 19522, 23, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2], 
					HouseInfo[h][hType], -1, -1, 30.0 );
			}
			
			mysql_format:g_string( "UPDATE `"DB_HOUSE"` SET `huID` = %d, `hRent` = %d, `hOwner` = '%s', `hSellDate` = %d WHERE `hID` = %d LIMIT 1",
				HouseInfo[h][huID], HouseInfo[h][hRent], HouseInfo[h][hOwner], HouseInfo[h][hSellDate], HouseInfo[h][hID] );
			mysql_tquery( mysql, g_string );
		
			setPlayerPos( playerid,
				GetPVarFloat( playerid, "HBuy:PX" ),
				GetPVarFloat( playerid, "HBuy:PY" ),
				GetPVarFloat( playerid, "HBuy:PZ") 
			);
				
			SetCameraBehindPlayer( playerid );
			
			SetPlayerVirtualWorld( playerid, 13 ), 
			SetPlayerInterior( playerid, 1 );
				
			DeletePVar( playerid, "HBuy:PX" ), 
			DeletePVar( playerid, "HBuy:PY" ),
			DeletePVar( playerid, "HBuy:PZ" ),
			DeletePVar( playerid, "HBuy:Camera" );			
			DeletePVar( playerid, "HBuy:House" );
			DeletePVar( playerid, "HBuy:TypeOne" );
			DeletePVar( playerid, "HBuy:TypeTwo" );
			DeletePVar( playerid, "HBuy:Last" );
			DeletePVar( playerid, "HBuy:PriceM" );
			DeletePVar( playerid, "HBuy:PriceH" );
			DeletePVar( playerid, "HBuy:List" );
			DeletePVar( playerid, "HBuy:Type" );
			DeletePVar( playerid, "HBuy:case" );
			
			g_player_interaction{playerid} = 0;
		}
		
		case d_buy_menu + 5: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:HId" );
				showHouseList( playerid, 4, 0 );
				return 1;
			}
			
			new
				h = GetPVarInt( playerid, "HBuy:HId" );
			
			switch( listitem ) 
			{
				case 0: 
				{
					if( HouseInfo[h][hRent] )
					{
						format:g_small_string( "\
							"cBLUE"�������������\n\n\
							"cWHITE"�� ������������� ������� �������� ������ "cBLUE"%s #%d"cWHITE"?",
							!HouseInfo[h][hType] ? ("����") : ("��������"),
							HouseInfo[h][hID] );
						return showPlayerDialog( playerid, d_buy_menu + 6, DIALOG_STYLE_MSGBOX, " ", g_small_string, "�����", "�����" );
					}
				
					format:g_string( "\
						"cBLUE"������� %s\n\n\
						"cWHITE"��� "cBLUE"%s #%d"cWHITE" ����� ������%s �������� �� "cBLUE"$%d"cWHITE".",
						!HouseInfo[h][hType] ? ("����") : ("��������"),
						!HouseInfo[h][hType] ? ("���") : ("��������"),
						HouseInfo[h][hID],
						!HouseInfo[h][hType] ? ("") : ("�"),
						floatround( HouseInfo[h][hPrice] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) 
					);
					
					showPlayerDialog( playerid, d_buy_menu + 6, DIALOG_STYLE_MSGBOX, " ", g_string, "�������", "������" );
				}
				
				case 1: 
				{
					if( HouseInfo[h][hRent] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ������� ������������ ��� (��������) ������� ������." );
						return showPlayerDialog( playerid, d_buy_menu + 5, DIALOG_STYLE_LIST,
							"������� ������������", "\
							"cWHITE"1. "cGRAY"������� ����� ���������\n\
							"cWHITE"2. "cGRAY"������� ����� ������",
							"�����", "�����" );
					}
				
					showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"������� �����\n\n\
						"cWHITE"��� ������� ����� ������ ������� ��� ID:", "����", "�����" );
				}
			}	
		}
		
		case d_buy_menu + 6: 
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_buy_menu + 5, DIALOG_STYLE_LIST,
					"������� ������������", "\
					"cWHITE"1. "cGRAY"������� ����� ���������\n\
					"cWHITE"2. "cGRAY"������� ����� ������",
				"�����", "�����" );
			}
			
			new 
				h = GetPVarInt( playerid, "HBuy:HId" );
				
			if( !HouseInfo[h][hRent] )
			{
				SetPlayerCash( playerid, "+", floatround( HouseInfo[h][hPrice] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) );
				
				mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uHouseEvict` = 0 WHERE `uHouseEvict` = %d", HouseInfo[h][hID] );
				mysql_tquery( mysql, g_small_string );
			
				foreach( new i : Player) 
				{
					if( !IsLogged(i) ) continue;
				
					if( Player[i][uHouseEvict] == HouseInfo[h][hID] ) 
					{
						SendClient:( i, C_GRAY, !""gbDefault"���, � ������� �� ���������, ��� ������ ����������. �� ��������." );
						Player[i][uHouseEvict] = 0;
					}
				}
				
				pformat:( ""gbSuccess"�� ������� ������� %s ��������� �� $%d.", !HouseInfo[h][hType] ? ("���") : ("��������"), 
					floatround( HouseInfo[h][hPrice] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) );
				psend:( playerid, C_WHITE );
			}
			else
			{
				SendClient:( playerid, C_WHITE, !""gbSuccess"�� ������� �������� ������." );
			}
			
			mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `huID` = -1, `hRent` = 0, `hOwner` = '', `hSellDate` = 0 WHERE `hID` = %d LIMIT 1",
				HouseInfo[h][hID] );
			mysql_tquery( mysql, g_small_string );
			
			RemovePlayerHouse( playerid, h );
			
			clean:<HouseInfo[h][hOwner]>;
			HouseInfo[h][huID] = INVALID_PARAM;
			HouseInfo[h][hRent] =
			HouseInfo[h][hSellDate] = 0;
				
			for( new i; i < MAX_EVICT; i++ )
			{
				HEvict[h][i][hEvictUID] = 0;
				HEvict[h][i][hEvictName][0] = EOS;
			}
			
			DestroyDynamicPickup( HouseInfo[h][hPickup] );
			
			HouseInfo[h][hPickup] = CreateDynamicPickup( 1272, 23, 
				HouseInfo[h][hEnterPos][0], 
				HouseInfo[h][hEnterPos][1],
				HouseInfo[h][hEnterPos][2], HouseInfo[h][hType], -1, -1, 30.0 );
			
			g_player_interaction{playerid} = 0;
			
			log( LOG_SELL_HOUSE, "������ ���", Player[playerid][uID], HouseInfo[h][hID] );
		}
		
		case d_buy_menu + 8:
		{
			new 
				sellid = GetPVarInt( playerid, "HBuy:SellID" ), //��������
				price = GetPVarInt( playerid, "HBuy:Price" ),	//����������
				house = GetPVarInt( playerid, "HBuy:HId" );
		
			if( !IsLogged( sellid ) ) 
			{
				SendClient:( playerid, C_GRAY, !""gbError"�������� �� � ����, �������� ��������!" );
					
				DeletePVar( playerid, "HBuy:HId" ), 
				DeletePVar( playerid, "HBuy:SellID" ),
				DeletePVar( playerid, "HBuy:Price" );
				
				g_player_interaction{playerid} = 0;
				return 1;
			}
		
			if( !response )
			{
				pformat:(""gbError"�� ���������� �� ������� ����� � ������ "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( sellid ),
					sellid
				);
				psend:( playerid, C_WHITE );
				
				pformat:(""gbError"����� "cBLUE"%s[%d]"cWHITE" ��������� �� ������� ������ �����.",
					GetAccountName( playerid ),
					playerid
				);
				psend: ( sellid, C_WHITE );

				DeletePVar( playerid, "HBuy:SellID" ),
				DeletePVar( playerid, "HBuy:Price" );
				DeletePVar( playerid, "HBuy:HId" );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				return 1;
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_GRAY, !NO_MONEY );
				
				DeletePVar( playerid, "HBuy:HId" ), 
				DeletePVar( playerid, "HBuy:SellID" ),
				DeletePVar( playerid, "HBuy:Price" );
				
				pformat:(""gbError"� ������ "cBLUE"%s[%d]"cWHITE" �� ��������� ������������ ���������� �����.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				
				return 1;
			}
			
			if( GetDistanceBetweenPlayers( playerid, sellid ) > 3.0 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"�������� ���� ��������� ������� ������ �� ���." );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"����� "cBLUE"%s[%d]"cWHITE" ��������� ������� ������ �� ���.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				
				return 1;
			}
			
			if( Player[playerid][uHouseEvict] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"�� ��� ��������� � ������ ���." );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"����� "cBLUE"%s[%d]"cWHITE" ��� ������� � ������ ���.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
			}
			
			if( IsOwnerHouseCount( playerid ) >= 1 + Premium[ playerid ][prem_house] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"�� ��� ������ ���." );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"����� "cBLUE"%s[%d]"cWHITE" ��� ����� ���.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
			}
			
			SetPlayerCash( sellid, "+", price );
			SetPlayerCash( playerid, "-", price );
				
			OfferSalePlayerHouse( sellid, playerid, house );
				
			pformat:( ""gbSuccess"�� ������ "cBLUE"%s #%d"cWHITE" � ������ "cBLUE"%s[%d]"cWHITE".",
				!HouseInfo[house][hType] ? ("���") : ("��������"),
				HouseInfo[house][hID],
				GetAccountName( sellid ),
				sellid
			);
			psend:( playerid, C_WHITE );
				
			pformat:( ""gbSuccess"�� ������� "cBLUE"%s #%d"cWHITE" ������ "cBLUE"%s[%d]"cWHITE".",
				!HouseInfo[house][hType] ? ("���") : ("��������"),
				HouseInfo[house][hID],
				GetAccountName( playerid ),
				playerid 
			);
			psend:( sellid, C_WHITE );
				
			g_player_interaction{playerid} = 0;
			g_player_interaction{sellid} = 0;
				
			log( LOG_BUY_HOUSE_FROM_PLAYER, "����� ��� �", Player[playerid][uID], Player[sellid][uID], price );
				
			DeletePVar( playerid, "HBuy:HId" ), 
			DeletePVar( playerid, "HBuy:SellID" ),
			DeletePVar( playerid, "HBuy:Price" );
		}
		
		case d_buy_menu + 9: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:case" );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "�����", "�����" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� ������������\n\n\
					"cWHITE"������� ����� ���� (��������):\n\
					"gbDialogError"�������� ��������.", "����", "�����" );
			}
			
			for( new h; h < MAX_HOUSE; h++ ) 
			{
				if( HouseInfo[h][hID] == strval( inputtext ) )
				{
					if( HouseInfo[h][huID] != INVALID_PARAM ) 
					{
						return showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"������� ������������\n\n\
							"cWHITE"������� ����� ���� (��������):\n\
							"gbDialogError"������ ��� ��� ������.", "����", "�����" );
					}
					
					showHouseBuyMenu( playerid, h );
					return 1;
				}
			}
			
			showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
				"cBLUE"������� ������������\n\n\
				"cWHITE"������� ����� ���� (��������):\n\
				"gbDialogError"���� � ����� ������� �� ����������.", "����", "�����" );
		}
		
		case d_buy_menu + 10: 
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_buy_menu + 5, DIALOG_STYLE_LIST,
					"������� ������������", "\
					"cWHITE"1. "cGRAY"������� ����� ���������\n\
					"cWHITE"2. "cGRAY"������� ����� ������",
				"�����", "�����" );
			}
			
			if( inputtext[0] == EOS ) 
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �����\n\n\
					"cWHITE"��� ������� ����� ������ ������� ��� ID:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"������� id ������.", 
				"�����", "�����" );
			}	
					
			if( !IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) ) 
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �����\n\n\
					"cWHITE"��� ������� ����� ������ ������� ��� ID:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"�� ����� ������������ id ������.", 
				"�����", "�����" );
			}
					
			if( Player[playerid][uHouseEvict] ) 
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �����\n\n\
					"cWHITE"��� ������� ����� ������ ������� ��� ID:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"������ ����� �������.", 
				"�����", "�����" );
			}
			
			if( IsOwnerHouseCount( strval( inputtext ) ) >= 1 + Premium[ strval( inputtext ) ][prem_house] )
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �����\n\n\
					"cWHITE"��� ������� ����� ������ ������� ��� ID:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"������ ����� ��� ����� ���.", 
				"�����", "�����" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 )
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �����\n\n\
					"cWHITE"��� ������� ����� ������ ������� ��� ID:\n\n\
					"gbDialogError"����� ������ ���������� ����� � ����.", 
				"�����", "�����" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �����\n\n\
					"cWHITE"��� ������� ����� ������ ������� ��� ID:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"�� �� ������ ����������������� � ������ �������.", 
				"�����", "�����" );
			}		
			
			g_player_interaction{strval( inputtext )} = 1;
			SetPVarInt( playerid, "HBuy:PlayerID", strval( inputtext ) );
			ShowDialogHouseSell( playerid, GetPVarInt( playerid, "HBuy:HId" ), " " );
		}
		
		case d_buy_menu + 11: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:PlayerID" );
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �����\n\n\
					"cWHITE"��� ������� ����� ������, ������� ��� ID:", "����", "�����" );
			}
		
			new
				h = GetPVarInt( playerid, "HBuy:HId" ),
				sellid = GetPVarInt( playerid, "HBuy:PlayerID" );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) ) 
			{
				return ShowDialogHouseSell( playerid, h, "\n\n"gbDialogError"������������ ������ �����." );
			}
			
			if( GetDistanceBetweenPlayers( playerid, sellid ) > 3.0 )
			{
				return ShowDialogHouseSell( playerid, h, "\n\n"gbDialogError"����� ������ ���������� ����� � ����." );
			}
			
			if( strval( inputtext ) < floatround( HouseInfo[h][hPrice] * 0.5 ) ||  strval( inputtext ) > ( HouseInfo[h][hPrice] * 2 ) )
			{
				return ShowDialogHouseSell( playerid, h, "\n\n"gbDialogError"��������� ����� ������� �� ����� ����������� ���������." );
			}
		
			if( Player[sellid][uMoney] < strval( inputtext ) ) 
			{
				return ShowDialogHouseSell( playerid, h, "\n\n"gbDialogError"� ������ ��� ������������ ���������� �������� �����." );
			}
			
			pformat:( ""gbSuccess"�� ��������� ����������� ������ "cBLUE"%s[%d]"cWHITE" � ������� "cBLUE"%s #%d"cWHITE".",
				GetAccountName( sellid ),
				sellid,
				!HouseInfo[h][hType] ? ("����") : ("��������"),
				HouseInfo[h][hID]
			);
			
			psend:( playerid, C_WHITE ); 
			
			format:g_small_string( 
				""cWHITE"����� "cBLUE"%s[%d]"cWHITE" ���������� ���\n\ 
				���������� ���"cBLUE"%s #%d"cWHITE" �� "cBLUE"$%d"cWHITE".",
				GetAccountName( playerid ),
				playerid,
				!HouseInfo[h][hType] ? ("���") : ("��������"),
				HouseInfo[h][hID],
				strval( inputtext )
			);
			
			showPlayerDialog( sellid, d_buy_menu + 8, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
			
			SetPVarInt( sellid, "HBuy:SellID", playerid );
			SetPVarInt( sellid, "HBuy:Price", strval( inputtext ) );
			SetPVarInt( sellid, "HBuy:HId", h );
			
			DeletePVar( playerid, "HBuy:PlayerID" );
			DeletePVar( playerid, "HBuy:HId" );
		}

		case d_buy_menu + 12:
		{
			if( !response )
			{
				setPlayerPos( playerid,
					GetPVarFloat( playerid, "HBuy:PX" ),
					GetPVarFloat( playerid, "HBuy:PY" ),
					GetPVarFloat( playerid, "HBuy:PZ") 
				);
					
				SetCameraBehindPlayer( playerid );
				
				SetPlayerVirtualWorld( playerid, 13 ), 
				SetPlayerInterior( playerid, 1 );
					
				DeletePVar( playerid, "HBuy:PX" ), 
				DeletePVar( playerid, "HBuy:PY" ),
				DeletePVar( playerid, "HBuy:PZ" ),
				DeletePVar( playerid, "HBuy:Camera" );
				
				if( GetPVarInt( playerid, "HBuy:case" ) == 4 )
				{
					showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"������� ������������\n\n\
						"cWHITE"������� ����� ���� (��������):", "����", "�����" );
				}
				else
				{
					showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) );
				}
				
				DeletePVar( playerid, "HBuy:House" );
				
				return 1;
			}
		
			showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				�������\n\
				������\n\
				����������", "�������", "�����" );
		}
		
		case d_buy_menu + 13:
		{
			showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				�������\n\
				������\n\
				����������", "�������", "�����" );
		}
		
		case d_buy_menu + 14:
		{
			if( !response )
			{
				DeletePVar( playerid, "HBuy:case" );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "�����", "�����" );
			}
			
			if( listitem == 1 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"�� ������ ������ ��� �������, ��������� ��� �������." );
				
				return showPlayerDialog( playerid, d_buy_menu + 14, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					���\n\
					��������", "�����", "�����" );
			}
			
			SetPVarInt( playerid, "HBuy:TypeOne", listitem );
			showPlayerDialog( playerid, d_buy_menu + 15, DIALOG_STYLE_LIST, " ", dialog_house_type, "�����", "�����" );
		}
		
		case d_buy_menu + 15:
		{
			if( !response )
			{
				DeletePVar( playerid, "HBuy:TypeOne" );
				return showPlayerDialog( playerid, d_buy_menu + 14, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					���\n\
					��������", "�����", "�����" );
			}
			
			SetPVarInt( playerid, "HBuy:TypeTwo", listitem );
			showHouseList( playerid, 3, 0 );
		}
		
		case d_buy_menu + 16:
		{
			if( !response ) return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "�����", "�����" );
			
			SetPVarInt( playerid, "HBuy:HId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			showPlayerDialog( playerid, d_buy_menu + 5, DIALOG_STYLE_LIST,
				"������� ������������", "\
				"cWHITE"1. "cGRAY"������� ����� ���������\n\
				"cWHITE"2. "cGRAY"������� ����� ������",
				"�����", "�����" );
		}
		
		
		/*- - - - - - - - - - - - ������� � ������� ���� - - - - - - - - - - - - -*/
		case d_house_panel: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Hpanel:HId" );
				return 1;
			}
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" ),
				year, month, day;
			
			switch( listitem ) 
			{
				//����������
				case 0: 
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					gmtime( HouseInfo[h][hSellDate], year, month, day );
				
					format:g_string(  ""cBLUE"���������� � %s\n\n\
						"cWHITE"������: "cRED"%s\n\
						"cWHITE"����� %s: "cBLUE"%d\n\
						"cWHITE"�������� ���������: "cBLUE"$%d\n\
						"cWHITE"��� ���������: "cBLUE"%s\n\n\
						"cWHITE"��������: "cBLUE"%s\n\
						"cWHITE"�����: %s\n\
						"cWHITE"������: "cBLUE"%d/%d\n\n\
						"cWHITE"������� ��: %02d.%02d.%d", 
						!HouseInfo[h][hType] ? ("����") : ("��������"),
						!HouseInfo[h][hRent] ? ("������") : ("���������"),
						!HouseInfo[h][hType] ? ("����") : ("��������"),
						HouseInfo[h][hID],
						HouseInfo[h][hPrice],
						GetNameInteriorHouse(h),
						HouseInfo[h][hOwner],
						HouseInfo[h][hLock] ? (""cBLUE"�������"cWHITE"") : 
											  (""cRED"�������"cWHITE""),
						HouseInfo[h][hCountFurn],
						GetMaxFurnHouse( h ),
						day, month, year
					);
					
					showPlayerDialog( playerid, d_house_panel + 1, DIALOG_STYLE_MSGBOX, " ", g_string, "�����", "" );
				}
				//����������
				case 1:
				{ 
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( HouseInfo[h][hRent] || Player[playerid][uHouseEvict] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ��������� �������." );
						return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
					}
					
					if( !hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_evict] )
					{
						pformat:( ""gbError"�� �� ������ ��������� ������� � %s.", !HouseInfo[h][hType] ? ("���� ���") : ("��� ��������") );
						psend:( playerid, C_WHITE );
					
						return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
					}
					
					format:g_string( "SELECT * FROM `"DB_USERS"` WHERE `uHouseEvict` = %d", HouseInfo[h][hID] );
					mysql_tquery( mysql, g_string, "checkHouseEvict", "dd", playerid, h );
				}
				//�������� ��������
				case 2: 
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] && !HouseInfo[h][hSettings][0] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ������������ ������ ����." );
						return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
					}
				
					format:g_string( "���� - "cBLUE"$%d", HouseInfo[h][hMoney] );
					showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "�������", "�����" );
				}
				//���������
				case 3: 
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "���������", h_panel_plan, "�������", "�����" );
				}
			}
		}
		
		case d_house_panel + 1: 
		{
			showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
		}
		
		case d_house_panel + 2:
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
		
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
				
			if( !HEvict[h][listitem][hEvictUID] )
			{
				showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"����������\n\n\
					"cWHITE"������� id ������, �������� ������� ���������:", "�����", "�����" );
			}
			else
			{
				format:g_small_string("\
					"cBLUE"���������\n\n\
					"cWHITE"�� ������������� ������� �������� "cBLUE"%s"cWHITE"?", HEvict[h][listitem][hEvictName] );
				showPlayerDialog( playerid, d_house_panel + 5, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
			}
			
			SetPVarInt( playerid, "Hpanel:EvictSlot", listitem );
		}
		
		case d_house_panel + 3: 
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || 
				strval( inputtext ) < 0 || strval( inputtext ) > MAX_PLAYERS || 
				!IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) )
			{
				return showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"����������\n\n\
					"cWHITE"������� id ������, �������� ������� ���������:\n\
					"gbDialogError"������������ id ������.", "�����", "�����" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"����������\n\n\
					"cWHITE"������� id ������, �������� ������� ���������:\n\
					"gbDialogError"�� �� ������ ����������������� � ������ �������.", "�����", "�����" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"����������\n\n\
					"cWHITE"������� id ������, �������� ������� ���������:\n\
					"gbDialogError"������� ������ ��� ����� � ����.", "�����", "�����" );
			}
			
			if( Player[ strval( inputtext ) ][uHouseEvict] || IsOwnerHouseCount( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"����������\n\n\
					"cWHITE"������� id ������, �������� ������� ���������:\n\
					"gbDialogError"� ������� ������ ��� ���� ����� ����������.", "�����", "�����" );
			}
			
			pformat:( ""gbDefault"�� ��������� ����������� "cBLUE"%s[%d]"cWHITE" � ��������� � ���� ���, �������� ��� �������.", Player[ strval( inputtext ) ][uName], strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			format:g_string( "\
				"cBLUE"%s[%d]"cWHITE" ���������� ��� ���������� � %s %s "cBLUE"#%d"cWHITE". �� ��������?",
				Player[playerid][uName], 
				playerid, 
				Player[playerid][uSex] == 2 ? ("�") : ("���"),
				!HouseInfo[h][hType] ? ("���") : ("��������"), 
				HouseInfo[h][hID] 
			);
			showPlayerDialog( strval( inputtext ), d_house_panel + 4, DIALOG_STYLE_MSGBOX, " ", g_string, "��", "���" );
			
			g_player_interaction{ strval( inputtext ) } = 1;
			g_player_interaction{ playerid } = 1;
			
			SetPVarInt( strval( inputtext ), "Hpanel:Playerid", playerid );
		}
		
		case d_house_panel + 4: 
		{
			new
				id = GetPVarInt( playerid, "Hpanel:Playerid" ),
				slot = GetPVarInt( id, "Hpanel:EvictSlot" ),
				h = GetPVarInt( id, "Hpanel:HId" );
				
			if( !IsLogged( id ) || !g_player_interaction{id} || GetDistanceBetweenPlayers( playerid, id ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( id ) )
			{
				g_player_interaction{ id } = 
				g_player_interaction{ playerid } = 0;
				
				DeletePVar( id, "Hpanel:HId" );
				DeletePVar( id, "Hpanel:EvictSlot" );
				DeletePVar( playerid, "Hpanel:Playerid" );
			
				return SendClient:( playerid, C_WHITE, !""gbError"��������� ������ ��� ���������, ���������� ��� ���." );
			}
				
			if( !response )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"�� ���������� �� ���������." );
				
				pformat:( ""gbDefault"����� "cBLUE"%s[%d]"cWHITE" ��������� �� ���������.", Player[playerid][uName], playerid );
				psend:( id, C_WHITE );
					
				DeletePVar( id, "Hpanel:HId" );
				DeletePVar( id, "Hpanel:EvictSlot" );
				DeletePVar( playerid, "Hpanel:Playerid" );
			
				g_player_interaction{ id } = 
				g_player_interaction{ playerid } = 0;
			
				return 1;
			}
			
			HEvict[h][slot][hEvictUID] = Player[playerid][uID];
			strcat( HEvict[h][slot][hEvictName], Player[playerid][uName], MAX_PLAYER_NAME );
			
			pformat:( ""gbDefault"�� �������� � %s #%d, �������� - "cBLUE"%s"cWHITE".", !HouseInfo[h][hType] ? ("���") : ("��������"), HouseInfo[h][hID], Player[id][uName] );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess""cBLUE"%s[%d]"cWHITE" ������ ���� ����������� � ��������� � ��� ���.", Player[playerid][uName], playerid );
			psend:( id, C_WHITE );
			
			Player[playerid][uHouseEvict] = HouseInfo[h][hID];
			UpdatePlayer( playerid, "uHouseEvict", Player[playerid][uHouseEvict] );
			
			DeletePVar( id, "Hpanel:HId" );
			DeletePVar( id, "Hpanel:EvictSlot" );
			DeletePVar( playerid, "Hpanel:Playerid" );
			
			g_player_interaction{ id } = 
			g_player_interaction{ playerid } = 0;
		}
		
		case d_house_panel + 5: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Hpanel:EvictSlot" );
				return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
			}
			
			new
				slot = GetPVarInt( playerid, "Hpanel:EvictSlot" ),
				h = GetPVarInt( playerid, "Hpanel:HId" );
			
			pformat:( ""gbDefault"�� �������� �� %s "cBLUE"%s"cWHITE".", !HouseInfo[h][hType] ? ("������ ����") : ("����� ��������"),
				HEvict[h][slot][hEvictName] );
			psend:( playerid, C_WHITE );
			
			foreach(new i: Player)
			{
				if( !IsLogged( i ) ) continue;
				
				if( HEvict[h][slot][hEvictUID] == Player[i][uID] )
				{
					Player[i][uHouseEvict] = 0;
					
					pformat:( ""gbDefault"�� ���� �������� �� %s #%d ������� "cBLUE"%s[%d]"cWHITE".", 
						!HouseInfo[h][hType] ? ("����") : ("��������" ), HouseInfo[h][hID],
						Player[playerid][uName], playerid );
					psend:( i, C_WHITE );
					
					break;
				}
			}
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uHouseEvict` = 0 WHERE `uID` = %d LIMIT 1", HEvict[h][slot][hEvictUID] );
			mysql_tquery( mysql, g_small_string );
			
			HEvict[h][slot][hEvictName][0] = EOS;
			HEvict[h][slot][hEvictUID] = 0;
			
			DeletePVar( playerid, "Hpanel:EvictSlot" );
			showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
		}
		
		case d_house_panel + 6: 
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
			
			switch( listitem )
			{
				case 0:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					showPlayerDialog( playerid, d_house_panel + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� ��������:", 
					"�����", "�����" );
				}
				
				case 1:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					showPlayerDialog( playerid, d_house_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"����� ������ �� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� �����:", 
					"�����", "�����" );
				}
			}
		}
		
		case d_house_panel + 7:
		{
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			if( !response )
			{
				format:g_string( "���� - "cBLUE"$%d", HouseInfo[h][hMoney] );
				return showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "�������", "�����" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_house_panel + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� ��������:\n\n\
						"gbDialogError"�������� ��������, ��������� ����.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) > Player[playerid][uMoney] )
			{
				return showPlayerDialog( playerid, d_house_panel + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� ��������:\n\n\
						"gbDialogError"� ��� ������������ �������� �����, ��������� ����.", 
					"�����", "�����" );
			}
			
			pformat:( ""gbDefault"�� �������� � ���� "cBLUE"$%d", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			SetPlayerCash( playerid, "-", strval( inputtext ) );
			
			HouseInfo[h][hMoney] += strval( inputtext );
			HouseUpdate( h, "hMoney", HouseInfo[h][hMoney] );
			
			format:g_string( "���� - "cBLUE"$%d", HouseInfo[h][hMoney] );
			showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "�������", "�����" );
		}
		
		case d_house_panel + 8: 
		{
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			if( !response )
			{
				format:g_string( "���� - "cBLUE"$%d", HouseInfo[h][hMoney] );
				return showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "�������", "�����" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				return showPlayerDialog( playerid, d_house_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"����� ������ �� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� �����:\n\n\
						"gbDialogError"�������� ��������, ��������� ����.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) > HouseInfo[h][hMoney] )
			{
				return showPlayerDialog( playerid, d_house_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"����� ������ �� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� �����:\n\n\
						"gbDialogError"� ����� ���� ��� ���������� ���������� �����.", 
					"�����", "�����" );
			}
			
			pformat:( ""gbDefault"�� ����� �� ����� "cBLUE"$%d", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			SetPlayerCash( playerid, "+", strval( inputtext ) );
			
			HouseInfo[h][hMoney] -= strval( inputtext );
			HouseUpdate( h, "hMoney", HouseInfo[h][hMoney] );
			
			format:g_string( "���� - "cBLUE"$%d", HouseInfo[h][hMoney] );
			showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "�������", "�����" );
		}
		
		case d_house_panel + 9: 
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
			
			switch( listitem )
			{
				case 0:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] || HouseInfo[h][hRent] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ������ �������� � ���� ����." );
						return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "���������", h_panel_plan, "�������", "�����" );
					}
					
					showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "���������������", h_panel_texture, "�������", "�����" );
				}
				
				case 1:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] && !HouseInfo[h][hSettings][2] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ����������� ������ � ���� ����." );
						return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "���������", h_panel_plan, "�������", "�����" );
					}
					
					ShowHouseFurnList( playerid, h, 0 );
				}
			
				case 2:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ �������� �������������� ������ � ���� ���." );
						return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "���������", h_panel_plan, "�������", "�����" );
					}
				
					showPlayerDialog( playerid, d_mebelbuy + 8, DIALOG_STYLE_LIST, " ", furniture_other, "�������", "�����" );
				}
				
				case 3:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ �������� ��������� ��� ����������." );
						return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "���������", h_panel_plan, "�������", "�����" );
					}
				
					format:g_small_string( h_panel_evict,
						!HouseInfo[h][hSettings][0] ? ("���") : ("��"),
						!HouseInfo[h][hSettings][1] ? ("���") : ("��"),
						!HouseInfo[h][hSettings][2] ? ("���") : ("��") );
					showPlayerDialog( playerid, d_house_panel + 10, DIALOG_STYLE_TABLIST_HEADERS, "��������� ����������", g_small_string, "��������", "�����" );
				}
			}
		}
		
		case d_house_panel + 10:
		{
			if( !response )
				return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "���������", h_panel_plan, "�������", "�����" );
		
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			if( HouseInfo[h][hSettings][listitem] )
			{
				HouseInfo[h][hSettings][listitem] = 0;
			}
			else
			{
				HouseInfo[h][hSettings][listitem] = 1;
			}
			
			mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `hSettings` = '%d|%d|%d' WHERE `hID` = %d LIMIT 1", 
				HouseInfo[h][hSettings][0], 
				HouseInfo[h][hSettings][1], 
				HouseInfo[h][hSettings][2],
				HouseInfo[h][hID]
			);
			mysql_tquery( mysql, g_small_string );
			
			format:g_small_string( h_panel_evict,
				!HouseInfo[h][hSettings][0] ? ("���") : ("��"),
				!HouseInfo[h][hSettings][1] ? ("���") : ("��"),
				!HouseInfo[h][hSettings][2] ? ("���") : ("��") );
			showPlayerDialog( playerid, d_house_panel + 10, DIALOG_STYLE_TABLIST_HEADERS, "��������� ����������", g_small_string, "��������", "�����" );
		}
		
		case d_house_panel + 11: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Hpanel:FPage" );
				DeletePVar( playerid, "Hpanel:FPageMax" );
				DeletePVar( playerid, "Hpanel:FAll" );
			
				return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "���������", h_panel_plan, "�������", "�����" );
			}
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" ),
				page = GetPVarInt( playerid, "Hpanel:FPage" ),
				
				fid;
			
			if( listitem == FURN_PAGE ) 
			{
				if( page == GetPVarInt( playerid, "Hpanel:FPageMax" ) )
					return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) );
					
				return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) + 1 );
			}
			else if( listitem == FURN_PAGE + 1 || 
				listitem == GetPVarInt( playerid, "Hpanel:FAll" ) && GetPVarInt( playerid, "Hpanel:FAll" ) < FURN_PAGE ) 
			{
				return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) - 1 );
			}
			
			SetPVarInt( playerid, "Hpanel:FId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			fid = GetPVarInt( playerid, "Hpanel:FId" );
			 
			format:g_small_string(  ""cBLUE"1. "cGRAY"%s", 
				!HFurn[h][fid][f_state] ? ( "��������� ������\n"cBLUE"2. "cGRAY"���������� ������"):("����������� ������\n"cBLUE"2. "cGRAY"������ ������ �� �����\n"cBLUE"3. "cGRAY"���������� ������") );
		    
			showPlayerDialog(playerid, d_house_panel + 12, DIALOG_STYLE_LIST, "���������� �������", g_small_string, "�������", "�����");
		}
		
		case d_house_panel + 12:
		{
			new
				h = GetPVarInt( playerid, "Hpanel:HId" ),
				fid = GetPVarInt( playerid, "Hpanel:FId" );
					
			if( !response ) return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) );
					
			switch( listitem )
			{
				case 0:
				{
					if( !HFurn[h][fid][f_state] )
					{
						new 
							Float:dist = 2.0,
							Float:angle,
							Float:pos[3],
							Float:rot[3];
								
						SendClient:( playerid, C_WHITE, !HELP_EDITOR );
							
						GetPlayerPos( playerid, HFurn[h][fid][f_pos][0], HFurn[h][fid][f_pos][1], HFurn[h][fid][f_pos][2] );
							
						GetPlayerFacingAngle( playerid, angle );

						HFurn[h][fid][f_pos][0] = HFurn[h][fid][f_pos][0] + dist * - floatsin( angle, degrees );
						HFurn[h][fid][f_pos][1] = HFurn[h][fid][f_pos][1] + dist * floatcos( angle, degrees );
							
						for( new i = 0; i != 3; i++ )
						{
							pos[i] = HFurn[h][fid][f_pos][i];
							rot[i] = HFurn[h][fid][f_rot][i];
						}
							
						HFurn[h][fid][f_object] = CreateDynamicObject(
							HFurn[h][fid][f_model], 
							pos[0], pos[1], pos[2], rot[0], rot[1], rot[2],
							HouseInfo[h][hID] 
						);
							
						EditDynamicObject( playerid, HFurn[h][fid][f_object] );
							
						HFurn[h][fid][f_state] = 1;
							
						SetPVarInt( playerid, "Furn:Edit", 2 );
							
						SendClient:( playerid, C_GRAY, ""gbSuccess"������� ����������." );
							
						return 1;
					}
						
					new 
						Float:fpos[3];
						
					GetDynamicObjectPos( HFurn[h][fid][f_object], fpos[0], fpos[1], fpos[2] );
						
					if( IsPlayerInRangeOfPoint( playerid, 10.0, fpos[0], fpos[1], fpos[2] ) ) 
					{ 
						EditDynamicObject( playerid, HFurn[h][fid][f_object] );
						SetPVarInt( playerid, "Furn:Edit", 2 );
						return 1;
					}
					else 
					{
						return 
							ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) ),
							SendClient:( playerid, C_GRAY, ""gbError"������ ������� ������� ������ �� ���." );
					}
				}
					
				case 1:
				{
					if( HFurn[h][fid][f_state] ) 
					{
						if( IsValidDynamicObject( HFurn[h][fid][f_object] ) )
							DestroyDynamicObject( HFurn[h][fid][f_object] );
						
						for( new i = 0; i != 3; i++ )
						{
							HFurn[h][fid][f_pos][i] = 
							HFurn[h][fid][f_rot][i] = 0.0;
						}
							
						HFurn[h][fid][f_state] = 0;
							
						UpdateFurnitureHouse( h, fid );
							
						SendClient:( playerid, C_GRAY, ""gbSuccess"������� ������." );
							
						return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) );
					}
				}
			}
				
			pformat:( ""gbSuccess"������� "cBLUE"%s"cWHITE" ���������.", HFurn[h][fid][f_name] );
			psend:( playerid, C_WHITE );
				
			if( IsValidDynamicObject( HFurn[h][fid][f_object] ) )
				DestroyDynamicObject( HFurn[h][fid][f_object] );
							
			DeleteFurnitureHouse( h, fid );
			HouseInfo[h][hCountFurn]--;
							
			ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Bpanel:FPage" ) );
		}
		//���������
		case d_house_panel + 13:
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "���������", h_panel_plan, "�������", "�����" );
		
			SetPVarInt( playerid, "Hpanel:Type", listitem );
			ShowHousePartInterior( playerid, GetPVarInt( playerid, "Hpanel:HId" ), listitem );
		}
		//������ ����
		case d_house_panel + 14:
		{
			if( !response )
			{
				DeletePVar( playerid, "Hpanel:Type" );
				return showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "���������������", h_panel_texture, "�������", "�����" );
			}
			
			ShowTexViewer( playerid, GetPVarInt( playerid, "Hpanel:Type" ), listitem, 0 );
		}
		
		case d_house_panel + 15:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Hpanel:PriceTexture" );
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"�� ������������� ������� ���������� ��� ��������?\n\
						"gbDialog"����: "cBLUE"$%d", GetPVarInt( playerid, "Hpanel:PriceTexture" ) );
						
					showPlayerDialog( playerid, d_house_panel + 16, DIALOG_STYLE_MSGBOX, "���������������", g_small_string, "��", "���" );
				}
				
				case 1:
				{
					new
						h = GetPVarInt( playerid, "Hpanel:HId" );
				
					switch( Menu3DData[playerid][CurrTextureType] )
					{
						case 0: SetHouseTexture( h, HouseInfo[h][hWall][ Menu3DData[playerid][CurrPartNumber] ], 0, Menu3DData[playerid][CurrPartNumber] );
						case 1: SetHouseTexture( h, HouseInfo[h][hFloor][ Menu3DData[playerid][CurrPartNumber] ], 1, Menu3DData[playerid][CurrPartNumber] );
						case 2: SetHouseTexture( h, HouseInfo[h][hRoof][ Menu3DData[playerid][CurrPartNumber] ], 2, Menu3DData[playerid][CurrPartNumber] );
						case 3: SetHouseTexture( h, HouseInfo[h][hStairs], 3, INVALID_PARAM );
					}
				
					DestroyTexViewer( playerid );
					
					showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "���������������", h_panel_texture, "�������", "�����" );
				}
			}
		}
		
		case d_house_panel + 16:
		{
			new
				price = GetPVarInt( playerid, "Hpanel:PriceTexture" ),
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			if( !response )
			{
				format:g_small_string( "\
					"cWHITE"��������\t"cWHITE"���������\n\
					"cWHITE"������ ��������\t"cBLUE"$%d\n\
					"cWHITE"����� �� ���������", price );
		
				return showPlayerDialog( playerid, d_house_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "���������������", g_small_string, "�������", "�������" );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
			
				format:g_small_string( "\
					"cWHITE"��������\t"cWHITE"���������\n\
					"cWHITE"������ ��������\t"cBLUE"$%d\n\
					"cWHITE"����� �� ���������", price );
		
				return showPlayerDialog( playerid, d_house_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "���������������", g_small_string, "�������", "�������" );
			}
			
			switch( Menu3DData[playerid][CurrTextureType] )
			{
				case 0:
				{
					HouseInfo[h][hWall][ Menu3DData[playerid][CurrPartNumber] ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
				
					mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `hWall` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `hID` = %d LIMIT 1", 
						HouseInfo[h][hWall][0],
						HouseInfo[h][hWall][1],
						HouseInfo[h][hWall][2],
						HouseInfo[h][hWall][3],
						HouseInfo[h][hWall][4],
						HouseInfo[h][hWall][5],
						HouseInfo[h][hWall][6],
						HouseInfo[h][hWall][7],
						HouseInfo[h][hWall][8],
						HouseInfo[h][hWall][9],
						HouseInfo[h][hID] );
					mysql_tquery( mysql, g_small_string );
				}
				
				case 1:
				{
					HouseInfo[h][hFloor][ Menu3DData[playerid][CurrPartNumber] ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
				
					mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `hFloor` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `hID` = %d LIMIT 1", 
						HouseInfo[h][hFloor][0],
						HouseInfo[h][hFloor][1],
						HouseInfo[h][hFloor][2],
						HouseInfo[h][hFloor][3],
						HouseInfo[h][hFloor][4],
						HouseInfo[h][hFloor][5],
						HouseInfo[h][hFloor][6],
						HouseInfo[h][hFloor][7],
						HouseInfo[h][hFloor][8],
						HouseInfo[h][hFloor][9],
						HouseInfo[h][hID] );
					mysql_tquery( mysql, g_small_string );
				}
				
				case 2:
				{
					HouseInfo[h][hRoof][ Menu3DData[playerid][CurrPartNumber] ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
				
					mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `hRoof` = '%d|%d|%d|%d|%d|%d|%d' WHERE `hID` = %d LIMIT 1", 
						HouseInfo[h][hRoof][0],
						HouseInfo[h][hRoof][1],
						HouseInfo[h][hRoof][2],
						HouseInfo[h][hRoof][3],
						HouseInfo[h][hRoof][4],
						HouseInfo[h][hRoof][5],
						HouseInfo[h][hRoof][6],
						HouseInfo[h][hID] );
					mysql_tquery( mysql, g_small_string );
				}
				
				case 3:
				{
					HouseInfo[h][hStairs] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
					HouseUpdate( h, "hStairs", HouseInfo[h][hStairs] );
				}
			}
			
			SetPlayerCash( playerid, "-", price );
			
			DeletePVar( playerid, "Hpanel:PriceTexture" );
			DestroyTexViewer( playerid );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"�������� ������� ���������." );
			
			showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "���������������", h_panel_texture, "�������", "�����" );
		}
	}
	
	return 1;
}