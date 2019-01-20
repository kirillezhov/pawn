
function Business_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_buy_business: 
		{
			if( !response ) 
			{	
				DeletePVar( playerid, "Enter:BId" ); 
				return 1;
			}
			
			new
				b = GetPVarInt( playerid, "Enter:BId" );
			
			if( !IsPlayerInRangeOfPoint( playerid, 2.0, BusinessInfo[b][b_enter_pos][0], BusinessInfo[b][b_enter_pos][1], BusinessInfo[b][b_enter_pos][2] ) )
			{
				DeletePVar( playerid, "Enter:BId" ); 
				return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ���������� ����� � ������� ������." );
			}
			
			setPlayerPos( playerid, BusinessInfo[b][b_exit_pos][0],
									BusinessInfo[b][b_exit_pos][1],
									BusinessInfo[b][b_exit_pos][2] );
			SetPlayerFacingAngle( playerid, BusinessInfo[b][b_exit_pos][3] );
			
			Player[playerid][tgpsPos][0] = BusinessInfo[b][b_enter_pos][0];
			Player[playerid][tgpsPos][1] = BusinessInfo[b][b_enter_pos][1];
			Player[playerid][tgpsPos][2] = BusinessInfo[b][b_enter_pos][2];
	
			SetPlayerVirtualWorld( playerid, BusinessInfo[b][b_id] );						
			setHouseWeather( playerid );
			//stopPlayer( playerid, 1 );
		}
		
		case d_buy_business + 1:
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_buy_menu, DIALOG_STYLE_LIST, 
					"��������� ������������", 
					"1. "cGRAY"������� �����"cWHITE"\n\
					2. "cGRAY"������� ��������", 
				"�����", "�������" );
			}
			
			switch( listitem ) 
			{
				case 0: 
				{// ������ ���� ��������
					ShowBusinessList( playerid, 1, 0 );
					SetPVarInt( playerid, "BBuy:case", 1 );
				}
				case 1:
				{
					// ���������� �� ������� ���������
					showPlayerDialog( playerid, d_buy_business + 4, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"���������� �� ���������\n\n\
					"cWHITE"������� �������� ��� ��� ��������� ������������ ��� ��������\
					\n������: "cBLUE"60000-200000", "����", "�����" );
					SetPVarInt( playerid, "BBuy:case", 2 );
				}
				case 2: 
				{	// ���������� �� ���� �������
					showPlayerDialog( playerid, d_buy_business + 5, DIALOG_STYLE_LIST, "���������� �� ���� �������",
						"1. "cGRAY"����������"cWHITE"\n\ 
						 2. "cGRAY"���������"cWHITE"\n\
						 3. "cGRAY"����"cWHITE"\n\
						 4. "cGRAY"��������"cWHITE"", 
					"�����", "�������" );
					SetPVarInt( playerid, "BBuy:case", 3 );
				}
				case 3: 
				{
					showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"������� ������������\n\n\
						"cWHITE"������� ����� �������:", "����", "�����" );
				}
				case 4: 
				{
					//������ �������� ������
					ShowBusinessList( playerid, 4, 0 );
				}
				
			}
		}
		
		case d_buy_business + 2:
		{
			if( !response )
			{
				SetPVarInt( playerid, "BBuy:List", -1 );
				
				switch( GetPVarInt( playerid, "BBuy:case" ) )
				{
					case 1:
					{
						DeletePVar( playerid, "BBuy:case" );
						return showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
								"1. ������ ���� ��������\n2. ���������� �� ���������\
								\n3. ���������� �� ���� �������\n4. ������� ������� �� ������\
								\n5. ������� ������", "�����", "�����" 
								);
					}
					
					case 2:
					{
						return showPlayerDialog( playerid, d_buy_business + 4, DIALOG_STYLE_INPUT, " ", 
							""cBLUE"���������� �� ���������\n\n\
							"cWHITE"������� �������� ��� ��� ��������� ������������ ��� ��������\
							\n������: "cBLUE"60000-200000", "����", "�����" );
					}
					
					case 3:
					{
					
						return showPlayerDialog( playerid, d_buy_business + 5, DIALOG_STYLE_LIST, "���������� �� ���� �������",
							"1. "cGRAY"����������"cWHITE"\n\ 
							 2. "cGRAY"���������"cWHITE"\n\
							 3. "cGRAY"����"cWHITE"\n\
							 4. "cGRAY"��������"cWHITE"", 
						"�����", "�������" );
					}
					
					case 4:
					{
						return showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"������� ������������\n\n\
							"cWHITE"������� ����� �������:",
							"����", "�����" );
					}
				}
			}
			
			if( listitem == BBUY_LIST ) 
			{
				return ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) + 1 );
			}
			else if( listitem == BBUY_LIST + 1 || 
				listitem == GetPVarInt( playerid, "BBuy:Last" ) && GetPVarInt( playerid, "BBuy:Last" ) < BBUY_LIST ) 
			{
				return ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) - 1 );
			}
			
			ShowBusinessBuyMenu( playerid, g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_buy_business + 3:
		{
			setPlayerPos( playerid,
				GetPVarFloat( playerid, "BBuy:pos_buy_x" ),
				GetPVarFloat( playerid, "BBuy:pos_buy_y" ),
				GetPVarFloat( playerid, "BBuy:pos_buy_z") 
			);
				
			SetCameraBehindPlayer( playerid );
			
			SetPlayerVirtualWorld( playerid, 13 ), 
			SetPlayerInterior( playerid, 1 );
				
			DeletePVar( playerid, "BBuy:pos_buy_x" ), 
			DeletePVar( playerid, "BBuy:pos_buy_y" ),
			DeletePVar( playerid, "BBuy:pos_buy_z" ),
			DeletePVar( playerid, "BBuy:Camera" );
			
			if( response ) 
			{
				new 
					b = GetPVarInt( playerid, "BBuy:Business" );
				
				if( IsOwnerBusinessCount( playerid ) >= 1 + Premium[playerid][prem_business] ) 
				{
					ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) );
					return SendClient:( playerid, C_WHITE, ""gbError"� ��� ��� ���� ������." );
				}
				
				if( BusinessInfo[b][b_price] > Player[playerid][uMoney] ) 
				{
					ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) );
					return SendClient:( playerid, C_GRAY, ""gbError"� ��� ������������ ������� ��� ������� ����� �������." );
				}
				
				if( BusinessInfo[b][b_user_id] != INVALID_PARAM )
				{
					ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) );
					return SendClient:( playerid, C_WHITE, ""gbError"���� ������ ��� ���������� ���-�� �����." );
				}

				BusinessInfo[b][b_user_id] = Player[playerid][uID];
				UpdateBusiness( b, "b_user_id", BusinessInfo[b][b_user_id] );
				
				BusinessInfo[b][b_products] = 1000;
				UpdateBusiness( b, "b_products", BusinessInfo[b][b_products] );
				
				SetPlayerCash( playerid, "-", BusinessInfo[b][b_price] );
				
				format:g_small_string( "�����%s ����������� ������", SexTextEnd( playerid ) );
				MeAction( playerid, g_small_string, 1 );
			
				InsertPlayerBusiness( playerid, b );
				
				log( LOG_BUY_BUSINESS, "����� ������", Player[playerid][uID], BusinessInfo[b][b_id] );
				
				pformat:(""gbSuccess"�� ����� ���������� "cBLUE"%s #%d"cWHITE". ��� ���������� �������� ����������� ������� "cBLUE"/bpanel"cWHITE".", GetBusinessType( b ), BusinessInfo[b][b_id] );
				psend:( playerid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
			}
			else
			{
				if( GetPVarInt( playerid, "BBuy:case" ) == 4 )
				{
					SetPVarInt( playerid, "BBuy:case", INVALID_PLAYER_ID );
					return showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. ������ ���� ��������\n2. ���������� �� ���������\
					\n3. ���������� �� ���� �������\n4. ������� ������� �� ������\
					\n5. ������� ������", "�����", "�����" );
					
				}
				
				ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) );
			}
						
			DeletePVar( playerid, "BBuy:Business" );
		}
		
		
		case d_buy_business + 4:
		{
			if( !response ) 
			{
				showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. ������ ���� ��������\n2. ���������� �� ���������\
					\n3. ���������� �� ���� �������\n4. ������������ ������� �� ��� ������\
					\n5. ������� ������", "�����", "�����" );
				return 1;
			}
			
			if( sscanf( inputtext, "p<->a<d>[2]", inputtext[0], inputtext[1] ) || inputtext[1] <= inputtext[0] ) 
			{
				showPlayerDialog( playerid, d_buy_business + 4, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"���������� �� ���������\n\n\
					"cWHITE"������� �������� ��� ��� ��������� ������������ ��� ��������\
					\n������: "cBLUE"60000-200000\n\n\
					"gbDialogError"�� ����������� ������� ��������.",
				"����", "�����" );
				return 1;
			}
			
			SetPVarInt( playerid, "BBuy:PriceM", inputtext[0] ), 
			SetPVarInt( playerid, "BBuy:PriceH", inputtext[1] );
			DeletePVar( playerid, "BBuy:Business" );
			ShowBusinessList( playerid, 2, 0 );
		}
		
		case d_buy_business + 5:
		{
			if( !response ) 
			{
				showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. ������ ���� ��������\n2. ���������� �� ���������\
					\n3. ���������� �� ���� �������\n4. ������� ������� �� ������\
					\n5. ������� ������", "�����", "�����" );
				return 1;
			}
			
			SetPVarInt( playerid, "BBuy:btype", listitem );
			ShowBusinessList( playerid, 3, 0 );
			
		}
		
		
		case d_buy_business + 6:
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. ������ ���� ��������\n2. ���������� �� ���������\
					\n3. ���������� �� ���� �������\n4. ������� ������� �� ������\
					\n5. ������� ������", "�����", "�����" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� ������������\n\n\
					"cWHITE"������� ����� �������:\n\
					"gbDialogError"�������� ��������.", "����", "�����" );
			}
			
			for( new b; b < MAX_BUSINESS; b++ )
			{
				if( BusinessInfo[b][b_id] == strval( inputtext ) )
				{
					if( BusinessInfo[b][b_user_id] != INVALID_PARAM )
					{
						return showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"������� ������������\n\n\
							"cWHITE"������� ����� �������:\n\
							"gbDialogError"���� �������� ������� ���-�� ������.",
						"����", "�����" );
					}
					
					ShowBusinessBuyMenu( playerid, b );
					SetPVarInt( playerid, "BBuy:case", 4 );
					return 1;
				}
			}
			
			showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
				"cBLUE"������� ������������\n\n\
				"cWHITE"������� ����� �������:\n\
				"gbDialogError"������ ������� �� ����������. ",
				"����", "�����" );
		}
		
		
		case d_buy_business + 7:
		{
			if( !response )
			{
				showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. ������ ���� ��������\n2. ���������� �� ���������\
					\n3. ���������� �� ���� �������\n4. ������� ������� �� ������\
					\n5. ������� ������", "�����", "�����" 
				);
				return 1;
			}
			
			SetPVarInt( playerid, "BBuy:BId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			showPlayerDialog( playerid, d_buy_business + 8, DIALOG_STYLE_LIST,
				"������� ������������", 
				""cWHITE"1. "cGRAY"������� ������ ���������"cWHITE" \
				\n2. "cGRAY"������� ������ ������",
				"�����", "�����" 
			);	
		}

		
		case d_buy_business + 8:
		{
				
			if( !response )
			{
				ShowBusinessList( playerid, 4, 0 );
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					new
						businessid = GetPVarInt( playerid, "BBuy:BId" );
						
					format:g_string( "\
						"cBLUE"������� �������\n\
						"cWHITE"��� %s #%d ����� ������ ��������� �� $%d.",
						GetBusinessType( businessid ),
						BusinessInfo[businessid][b_id],
						floatround( BusinessInfo[businessid][b_price] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) 
					);
						
						
					showPlayerDialog( playerid, d_buy_business + 11, DIALOG_STYLE_MSGBOX, " ", g_string, 
						"�������", "������" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"������� ������ ������\n\n\
						"cWHITE"��� ������� ������� ������, ������� ��� ID:", "����", "�����" );
				}
			}
		}
		
		
		case d_buy_business + 9:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_buy_business + 8, DIALOG_STYLE_LIST,
					"������� ������������", 
					"1. "cGRAY"������� ������ ���������"cWHITE" \
					\n2. "cGRAY"������� ������ ������",
				"�����", "�����" );
			}
		
			if( inputtext[0] == EOS ) 
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �������.\n\n\
					"cWHITE"������� id ������, �������� �� ������ ������� ������:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"������� id ������.", 
				"�����", "�����" );
			}	
					
			if( !IsLogged( strval( inputtext ) ) || strval( inputtext ) == playerid ) 
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �������.\n\n\
					"cWHITE"������� id ������, �������� �� ������ ������� ������:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"�� ����� ������������ id ������.", 
				"�����", "�����" );
			}
					
			if( IsOwnerBusinessCount( strval( inputtext ) ) >= 1 + Premium[ strval( inputtext ) ][prem_business] ) 
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �������.\n\n\
					"cWHITE"������� id ������, �������� �� ������ ������� ������:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"������ ����� ��� ����� ������.", 
				"�����", "�����" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 )
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �������.\n\n\
					"cWHITE"������� id ������, �������� �� ������ ������� ������:\n\n\
					"gbDialogError"����� ������ ���������� ����� � ����.", 
				"�����", "�����" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� �������.\n\n\
					"cWHITE"������� id ������, �������� �� ������ ������� ������:\n\n\
					"gbDialog"����� ������ ���������� ����� � ����.\n\
					"gbDialogError"�� �� ������ ����������������� � ������ �������.", 
				"�����", "�����" );
			}
			
			SetPVarInt( playerid, "BBuy:PlayerID", strval( inputtext ) );
			ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), " " );
		}
		
		
		case d_buy_business + 10:
		{
			//new 
			//	sellid = GetPVarInt( playerid, "BBuy:PlayerID" );
			
			if( !response )
			{
				DeletePVar( playerid, "BBuy:PlayerID" );
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� ������ ������\n\n\
					"cWHITE"��� ������� ������� ������, ������� ��� ID:", "����", "�����" );
			}
			
			if( inputtext[0] == EOS ) 
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"������� ����� ����:" );
			}
			
			if( !IsNumeric( inputtext ) )
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"������� ����� ����:" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, GetPVarInt( playerid, "BBuy:PlayerID" ) ) > 3.0 )
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"����� ������ ���������� ����� � ����." );
			}
			
			if( strval( inputtext ) < floatround( BusinessInfo[GetPVarInt( playerid, "BBuy:BId" )][b_price] * 0.5 ) ||  strval( inputtext ) > ( BusinessInfo[GetPVarInt( playerid, "BBuy:BId" )][b_price] * 2 ) )
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"��������� ����� ������� �� ����� ����������� ���������." );
			}
		
			if( Player[GetPVarInt( playerid, "BBuy:PlayerID" )][uMoney] < strval( inputtext ) ) 
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"� ������ ��� ������������ ���������� �������� �����." );
			}
			
			pformat:( ""gbSuccess"�� ��������� ����������� ������ "cBLUE"%s[%d]"cWHITE" � ������� "cBLUE"%s #%d"cWHITE".",
				GetAccountName( GetPVarInt( playerid, "BBuy:PlayerID" ) ),
				GetPVarInt( playerid, "BBuy:PlayerID" ),
				GetBusinessType( GetPVarInt( playerid, "BBuy:BId" ) ),
				BusinessInfo[GetPVarInt( playerid, "BBuy:BId" )][b_id]
			);
			
			psend:( playerid, C_WHITE ); 
			
			format:g_big_string( 
				""gbSuccess"����� "cBLUE"%s[%d]"cWHITE" ���������� ���\n\ 
				���������� ��� "cBLUE"%s #%d"cWHITE" �� "cBLUE"$%d"cWHITE".",
				GetAccountName( playerid ),
				playerid,
				GetBusinessType( GetPVarInt( playerid, "BBuy:BId" ) ),
				BusinessInfo[GetPVarInt( playerid, "BBuy:BId" )][b_id],
				strval( inputtext )
			);
			
			showPlayerDialog( GetPVarInt( playerid, "BBuy:PlayerID" ), d_buy_business + 12, DIALOG_STYLE_MSGBOX, " ", g_big_string, "��", "���" );
			
			g_player_interaction{GetPVarInt( playerid, "BBuy:PlayerID" )} = 1;
			
			SetPVarInt( GetPVarInt( playerid, "BBuy:PlayerID" ), "BBuy:SellID", playerid );
			SetPVarInt( GetPVarInt( playerid, "BBuy:PlayerID" ), "BBuy:Price", strval( inputtext ) );
			SetPVarInt( GetPVarInt( playerid, "BBuy:PlayerID" ), "BBuy:BId", GetPVarInt( playerid, "BBuy:BId" ) );
			
			DeletePVar( playerid, "BBuy:PlayerID" );
			DeletePVar( playerid, "BBuy:BId" );
		}
		
		
		case d_buy_business + 11:
		{
			new
				businessid = GetPVarInt( playerid, "BBuy:BId" );
			if( !response )
			{
				return showPlayerDialog( playerid, d_buy_business + 8, DIALOG_STYLE_LIST,
					"������� ������������", 
					"1. "cGRAY"������� ������ ���������"cWHITE" \
					\n2. "cGRAY"������� ������ ������",
				"�����", "�����" );
			}
			
			SellBusiness( businessid );
			
			Player[playerid][uMoney] += floatround( BusinessInfo[businessid][b_price] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) );
				
			UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );
			
			pformat:( ""gbSuccess"�� ������� ������ ��������� �� "cBLUE"$%d"cWHITE".", floatround( BusinessInfo[businessid][b_price] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) );
			psend:( playerid, C_WHITE ); 
			
			RemovePlayerBusiness( playerid, businessid );
			g_player_interaction{playerid} = 0;
			
			SetPVarInt( playerid, "BBuy:BId", INVALID_PLAYER_ID );
		}
		
		case d_buy_business + 12:
		{
			new 
				sellid = GetPVarInt( playerid, "BBuy:SellID" ),
				price = GetPVarInt( playerid, "BBuy:Price" ),
				businessid = GetPVarInt( playerid, "BBuy:BId" );
			
			if( !IsLogged( sellid ) ) 
			{
				SendClient:( playerid, C_GRAY, !""gbError"�������� �� � ����, �������� ��������!" );
					
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			if( !response )
			{
				pformat:(""gbError"�� ���������� �� ������� ������� � ������ "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( sellid ),
					sellid
				);
				
				psend:( playerid, C_WHITE );
				
				pformat:(""gbError"����� "cBLUE"%s[%d]"cWHITE" ��������� �� ������� ������ �������.",
					GetAccountName( playerid ),
					playerid
				);
				
				psend: ( sellid, C_WHITE );

				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				DeletePVar( playerid, "BBuy:BId" );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				return 1;
			}
				
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_GRAY, !NO_MONEY );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
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
				SendClient:( playerid, C_WHITE, !""gbError"�������� ������� ��������� ������� ������ �� ���." );
				
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
			
			if( IsOwnerBusinessCount( playerid ) >= 1 + Premium[ playerid ][prem_business] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"�������� ��������. �� ��� ������ ������." );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"�������� ��������. ����� "cBLUE"%s[%d]"cWHITE" ��� ����� ������.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				
				return 1;
			}			
				
			SetPlayerCash( sellid, "+", price );
			SetPlayerCash( playerid, "-", price );
				
			OfferSalePlayerBusiness( sellid, playerid, businessid );
				
			pformat:( ""gbSuccess"�� ������ "cBLUE"%s #%d"cWHITE" � ������ "cBLUE"%s[%d]"cWHITE" �� $%d.",
				GetBusinessType( businessid ),
				BusinessInfo[businessid][b_id],
				GetAccountName( sellid ),
				sellid,
				price
			);
			psend:( playerid, C_WHITE );
				
			pformat:( ""gbSuccess"�� ������� "cBLUE"%s #%d"cWHITE" ������ "cBLUE"%s[%d]"cWHITE" �� $%d.",
				GetBusinessType( businessid ),
				BusinessInfo[businessid][b_id],
				GetAccountName( playerid ),
				playerid,
				price
			);
			psend:( sellid, C_WHITE );
				
			g_player_interaction{playerid} = 0;
			g_player_interaction{sellid} = 0;
				
			log( LOG_BUY_BUSINESS_FROM_PLAYER, "����� ������ �", Player[playerid][uID], Player[sellid][uID], price );
				
			DeletePVar( playerid, "BBuy:BId" ), 
			DeletePVar( playerid, "BBuy:SellID" ),
			DeletePVar( playerid, "BBuy:Price" );		
		}
		
//----------------------------------------������� � /bpanel--------------------------
//-----------------------------------------------------------------------------------
		
		case d_business_panel:
		{
			if( !response )
			{
				SetPVarInt( playerid, "Bpanel:BId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Bpanel:Interior", INVALID_PLAYER_ID );
			
				CancelSelectTextDraw( playerid );
				return 1;
			}
			
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" ),
				hour;
				
			if( BusinessInfo[businessid][b_products_time] >= gettime() && !BusinessInfo[businessid][b_products] )
			{
				hour = floatround ( ( 259200 - ( BusinessInfo[businessid][b_products_time] - gettime() ) ) / 1200 );
			}
			else
			{
				hour = 0;
			}
			
			switch( listitem )
			{
				case 0:
				{
					format:g_big_string( "\
						"cWHITE"���������� � �������\n\n\
						"cBLUE"%s"cWHITE"\n\
						�����: "cBLUE"%d"cWHITE"\n\n\
						�����: %s\n\n\
						��������: "cBLUE"%s"cWHITE"\n\
						��� �������: "cBLUE"%s"cWHITE"\n\
						��������: "cBLUE"#%d"cWHITE"\n\
						�������� ���������: "cBLUE"$%d"cWHITE"\n\n\
						������������� ������: "cBLUE"%d/%d"cWHITE"\n\n\
						������: "cBLUE"%d/%d"cWHITE" ��.\n\n\
						����������� �����: %s\n\
						����������� ��������: %s\n\n\
						������������: "cBLUE"%d"cWHITE" �.",
						BusinessInfo[businessid][b_name],
						BusinessInfo[businessid][b_id],
						BusinessInfo[businessid][b_lock] ? (""cBLUE"�������"cWHITE"") : 
														   (""cRED"�������"cWHITE""),
						Player[playerid][uName],
						GetBusinessType( businessid ),
						BusinessInfo[businessid][b_interior],
						BusinessInfo[businessid][b_price],
						BusinessInfo[businessid][b_products], BusinessInfo[businessid][b_improve][2],
						BusinessInfo[businessid][b_count_furn], GetMaxFurnBusiness( businessid ),
						BusinessInfo[businessid][b_improve][0] ? (""cBLUE"��"cWHITE"") : 
																 (""cRED"���"cWHITE""),
						BusinessInfo[businessid][b_improve][1] ? (""cBLUE"��"cWHITE"") : 
																 (""cRED"���"cWHITE""),
						hour
					);
					
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�������","" );
				}
					
				case 1:
				{
					format:g_string( b_panel_p2, 
						BusinessInfo[businessid][b_improve][0] ? (""cBLUE"����") : (""cGRAY"���"),
						BusinessInfo[businessid][b_improve][1] ? (""cBLUE"����") : (""cGRAY"���")
					);
					showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "������", "�����" );
				}
				
				case 2:
				{
					format:g_string( "���� - "cBLUE"$%d", BusinessInfo[businessid][b_safe] );
					showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "�������", "�����" );
				}
				
				case 3:
				{
					format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] );
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "�������", "�����" );
				}
			}
		}
		
		case d_business_panel + 1:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "�������", "�������" );
			}
			
			switch( listitem )
			{
				case 0:
				{
					if( BusinessInfo[businessid][b_improve][0] )
					{
						format:g_string( b_panel_p2, 
							BusinessInfo[businessid][b_improve][0] ? (""cBLUE"����") : (""cGRAY"���"),
							BusinessInfo[businessid][b_improve][1] ? (""cBLUE"����") : (""cGRAY"���")
						);
						
						return SendClient:( playerid, C_GRAY, ""gbError"����� ����� ������� ��� ��������." ),
							   showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "������", "�����" );
					}
					
					format:g_small_string( "\
						"cBLUE"���������� ������\n\n\
						"cWHITE"����� ������� ����� �������� � ��� ����.\n\
						����� ������ ������� ������� ���������� �������.\n\n\
						"gbDialog"��������� ���������� "cBLUE"$%d"cWHITE".", GetPriceImprove( businessid ) );
					
					showPlayerDialog( playerid, d_business_panel + 2, DIALOG_STYLE_MSGBOX, " ", g_small_string, "������", "�����" );	
				}
				
				case 1:
				{
					if( BusinessInfo[businessid][b_improve][1] )
					{
						format:g_string( b_panel_p2, 
							BusinessInfo[businessid][b_improve][0] ? (""cBLUE"����") : (""cGRAY"���"),
							BusinessInfo[businessid][b_improve][1] ? (""cBLUE"����") : (""cGRAY"���")
						);
						
						return SendClient:( playerid, C_GRAY, ""gbError"�������� ����� ������� ��� ��������." ),
							   showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "������", "�����" );
					}
					
					format:g_small_string( "\
						"cBLUE"���������� ��������\n\n\
						"cWHITE"�������� ������� ����� �������� � ��� ����.\n\
						�� ������� ��������� ������� ���������� �������.\n\n\
						"gbDialog"��������� ���������� "cBLUE"$%d"cWHITE".", GetPriceImprove2( businessid ) );
					
					showPlayerDialog( playerid, d_business_panel + 3, DIALOG_STYLE_MSGBOX, " ", g_small_string, "������", "�����" );
				}
				
				case 2:
				{
					showPlayerDialog( playerid, d_mebelbuy + 5, DIALOG_STYLE_LIST, " ", furniture_other, "�������", "�����" );
				}
			}
		}
		
		case d_business_panel + 2:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( b_panel_p2, 
					BusinessInfo[businessid][b_improve][0] ? (""cBLUE"����") : (""cGRAY"���"),
					BusinessInfo[businessid][b_improve][1] ? (""cBLUE"����") : (""cGRAY"���")
				);
						
				return showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "������", "�����" ); 
			}
			
			if( BusinessInfo[businessid][b_safe] < GetPriceImprove( businessid ) )
			{
				SendClient:( playerid, C_WHITE, ""gbError"� ����� ������� ������������ ������� ��� ���������� ������." );
			
				format:g_string( b_panel_p2, 
					BusinessInfo[businessid][b_improve][0] ? (""cBLUE"����") : (""cGRAY"���"),
					BusinessInfo[businessid][b_improve][1] ? (""cBLUE"����") : (""cGRAY"���")
				);
						
				return showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "������", "�����" ); 
			}
			
			BusinessInfo[businessid][b_safe] -= GetPriceImprove( businessid );
			UpdateBusiness( businessid, "b_safe", BusinessInfo[businessid][b_safe] );
			
			BusinessInfo[businessid][b_improve][0] = 1;
			BusinessInfo[businessid][b_improve][2] = 100000;
			
			UpdateBusinessSlash( businessid, "b_improve", BusinessInfo[businessid][b_improve] );
		
			showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "�������", "�������" );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"����� ��������, ������ �� ����� ������� �� "cBLUE"100000"cWHITE" �������." );
		}
		
		case d_business_panel + 3:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( b_panel_p2, 
					BusinessInfo[businessid][b_improve][0] ? (""cBLUE"����") : (""cGRAY"���"),
					BusinessInfo[businessid][b_improve][1] ? (""cBLUE"����") : (""cGRAY"���")
				);
						
				return showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_LIST, " ", g_string, "������", "�����" ); 
			}
			
			if( BusinessInfo[businessid][b_safe] < GetPriceImprove2( businessid ) )
			{
				SendClient:( playerid, C_WHITE, ""gbError"� ����� ������� ������������ ������� ��� ���������� ��������." );
			
				format:g_string( b_panel_p2, 
					BusinessInfo[businessid][b_improve][0] ? (""cBLUE"����") : (""cGRAY"���"),
					BusinessInfo[businessid][b_improve][1] ? (""cBLUE"����") : (""cGRAY"���")
				);
						
				return showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "������", "�����" );
			}
			
			BusinessInfo[businessid][b_safe] -= GetPriceImprove2( businessid );
			UpdateBusiness( businessid, "b_safe", BusinessInfo[businessid][b_safe] );
			
			BusinessInfo[businessid][b_improve][1] = 1;
			
			UpdateBusinessSlash( businessid, "b_improve", BusinessInfo[businessid][b_improve] );
			
			showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "�������", "�������" );
		
			SendClient:( playerid, C_WHITE, ""gbSuccess"�������� ��������, ������ �� ������ ��������� ������ �������." );
		}
		
		//������ �����
		case d_business_panel + 4:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "�������", "�������" );
			}
			
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_business_panel + 5, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� ��������:", 
					"�����", "�����" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_business_panel + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"����� ������ �� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� �����:", 
					"�����", "�����" );
				}
			}
		}
		
		case d_business_panel + 5:
		{
			new 
				bid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( "���� - "cBLUE"$%d", BusinessInfo[bid][b_safe] );
				return showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "�������", "�����" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_business_panel + 5, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� ��������:\n\n\
						"gbDialogError"�������� ��������, ��������� ����.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) > Player[playerid][uMoney] )
			{
				return showPlayerDialog( playerid, d_business_panel + 5, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� ��������:\n\n\
						"gbDialogError"� ��� ������������ �������� �����, ��������� ����.", 
					"�����", "�����" );
			}
			
			pformat:( ""gbDefault"�� �������� � ���� "cBLUE"$%d", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			SetPlayerCash( playerid, "-", strval( inputtext ) );
			
			BusinessInfo[bid][b_safe] += strval( inputtext );
			UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
			
			format:g_string( "���� - "cBLUE"$%d", BusinessInfo[bid][b_safe] );
			showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "�������", "�����" );
		}
		
		case d_business_panel + 6:
		{
			new 
				bid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( "���� - "cBLUE"$%d", BusinessInfo[bid][b_safe] );
				return showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "�������", "�����" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				return showPlayerDialog( playerid, d_business_panel + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"����� ������ �� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� �����:\n\n\
						"gbDialogError"�������� ��������, ��������� ����.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) > BusinessInfo[bid][b_safe] )
			{
				return showPlayerDialog( playerid, d_business_panel + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"����� ������ �� �����\n\n\
						"cWHITE"������� �����, ������� �� ������� �����:\n\n\
						"gbDialogError"� ����� ������� ��� ���������� ���������� �����.", 
					"�����", "�����" );
			}
			
			pformat:( ""gbDefault"�� ����� �� ����� "cBLUE"$%d", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			SetPlayerCash( playerid, "+", strval( inputtext ) );
			
			BusinessInfo[bid][b_safe] -= strval( inputtext );
			UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
			
			format:g_string( "���� - "cBLUE"$%d", BusinessInfo[bid][b_safe] );
			showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "�������", "�����" );
		}
		
		case d_business_panel + 7:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "�������", "�������" );
			}
		
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_business_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"��������� �������� �������.\n\n\
						������� �������� �������� ��� ������ ������:\n\n\
						"gbDialog"����������� ����� �������� ��� ����������� ��������.", 
					"�����", "�����" );
				}
			
				case 1:
				{
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"���������� ���� �� 1 �������.\n\n\
						������� ����:\n\n\
						"gbDialog"������� - $3, �������� - $10.", 
					"�����", "�����" );
				}
			
				case 2:
				{
					showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| ����� ���������.\n\n\
						������� ���������� ���������, ������� �� ������ ��������:\n\n\
						"gbDialog"������� ���� �� ������� - $1.\n\
						"gbDialog"������� - 1000 ���������, �������� - 10000 ���������.",
					"�����", "�����" );
				}
			
				case 3:
				{
					showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "�������", "�����" );
				}
			}
		}
		
		//������ � ������� ���������
		case d_business_panel + 22:
		{
			new 
				bid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( b_panel_p4, BusinessInfo[bid][b_product_price] );
				return showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "�������", "�����" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) )
			{
				return showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| ����� ���������.\n\n\
						������� ���������� ���������, ������� �� ������ ��������:\n\n\
						"gbDialog"������� ���� �� ������� - $1.\n\
						"gbDialog"������� - 1000 ���������, �������� - 10000 ���������.\n\n\
						"gbDialogError"������������ ��������, ��������� ����.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) > 10000 || strval( inputtext ) < 1000  )
			{
				return showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| ����� ���������.\n\n\
						������� ���������� ���������, ������� �� ������ ��������:\n\n\
						"gbDialog"������� ���� �� ������� - $1.\n\
						"gbDialog"������� - 1000 ���������, �������� - 10000 ���������.\n\n\
						"gbDialogError"��������� ���������� �� ������ � ���������� ��������, ��������� ����.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) + BusinessInfo[bid][b_products] > BusinessInfo[bid][b_improve][2] )
			{
				return showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| ����� ���������.\n\n\
						������� ���������� ���������, ������� �� ������ ��������:\n\n\
						"gbDialog"������� ���� �� ������� - $1.\n\
						"gbDialog"������� - 1000 ���������, �������� - 10000 ���������.\n\n\
						"gbDialogError"����� ������� �� ����� �������� ��������� ���������� ���������.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) > BusinessInfo[bid][b_safe] )
			{
				return showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| ����� ���������.\n\n\
						������� ���������� ���������, ������� �� ������ ��������:\n\n\
						"gbDialog"������� ���� �� ������� - $1.\n\
						"gbDialog"������� - 1000 ���������, �������� - 10000 ���������.\n\n\
						"gbDialogError"� ����� ������� ������������ ����� ��� ������ �������.", 
					"�����", "�����" );
			}
			
			if( BusinessInfo[bid][b_status_prod] == true )
			{
				format:g_string( b_panel_p4, BusinessInfo[bid][b_product_price] );
				
				return SendClient:( playerid, C_WHITE, ""gbError"��� ���������� ����� ��� �� ��������, ��������� �����."),
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "�������", "�����" );
			}
			
			new 
				bool:count = false;
				
			for( new i; i < MAX_PRODUCT_INFO; i++ )
			{
				if( !ProductsInfo[i][b_id] && !ProductsInfo[i][b_count] )
				{
					ProductsInfo[i][b_id] = bid;
					ProductsInfo[i][b_business_id] = BusinessInfo[bid][b_id];
					ProductsInfo[i][b_count] = strval( inputtext );
					ProductsInfo[i][b_count_time] = strval( inputtext );
					
					count = true;
					
					pformat:( ""gbSuccess"��� ����� �� "cBLUE"%d"cWHITE" ������� ������.", strval( inputtext ) );
					psend:( playerid, C_WHITE );
					
					BusinessInfo[bid][b_safe] -= strval( inputtext );
					UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
					
					BusinessInfo[bid][b_status_prod] = true;
					
					CreateOrder( i );
					
					break;
				}
			}
			
			if( count == false ) 
			{
				SendClient:( playerid, C_WHITE, ""gbError"� ������������� �������� ����� �������, ��������� �����.");
				
				format:g_string( b_panel_p4, BusinessInfo[bid][b_product_price] );
				return showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "�������", "�����" );
			}
		}
		
		case d_business_panel + 8:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
			
			if( !response )
			{
				return 
					format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] ),
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "�������", "�����" );
			}
			
			if( inputtext[0] == EOS )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"��������� �������� �������.\n\n\
						������� �������� �������� ��� ������ ������:\n\n\
						"gbDialog"����������� ����� �������� ��� ����������� ��������.\n\n\
						"gbDialogError"���� ��� ����� �� ������ ���� ������.", 
					"�����", "�����" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"��������� �������� �������.\n\n\
						������� �������� �������� ��� ������ ������:\n\n\
						"gbDialog"����������� ����� �������� ��� ����������� ��������.\n\n\
						"gbDialogError"��������� ���������� ���������� ��������.", 
					"�����", "�����" );
			}
			
			
			clean:<BusinessInfo[businessid][b_name]>;
			
			strcat( BusinessInfo[businessid][b_name], inputtext, 32 );
			
			UpdateBusinessStr( businessid, "b_name", BusinessInfo[businessid][b_name] );
			UpdateBusiness3DText( businessid );
			
			pformat:(""gbSuccess"�� �������� �������� ������� �� "cBLUE"%s"cWHITE".", BusinessInfo[businessid][b_name] );
			psend:( playerid, C_WHITE );

			showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "�������", "�������" );
		}
		
		//���� �� �������
		case d_business_panel + 9:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				return 
					format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] ),
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "�������", "�����" );
			}
			
			if( inputtext[0] == EOS )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"���������� ���� �� 1 �������.\n\n\
						������� ����:\n\n\
						"gbDialog"������� - $3, �������� - $10.\n\
						"gbDialogError"���� ��� ����� �� ������ ���� ������.", 
					"�����", "�����" );
			}
			
			if( !IsNumeric( inputtext ) )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"���������� ���� �� 1 �������.\n\n\
						������� ����:\n\n\
						"gbDialog"������� - $3, �������� - $10.\n\
						"gbDialogError"����������� ������ �����.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) == BusinessInfo[businessid][b_product_price] )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"���������� ���� �� 1 �������.\n\n\
						������� ����:\n\n\
						"gbDialog"������� - $3, �������� - $10.\n\
						"gbDialogError"����� ���� ��� �����������.", 
					"�����", "�����" );
			}
			
			if( strval( inputtext ) < 3 || strval( inputtext ) > 10 )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"���������� ���� �� 1 �������.\n\n\
						������� ����:\n\n\
						"gbDialog"������� - $3, �������� - $10.\n\
						"gbDialogError"���� �� ������ � �������� ��������.", 
					"�����", "�����" );
			}
			
			BusinessInfo[businessid][b_product_price] = strval( inputtext );
			
			UpdateBusiness( businessid, "b_product_price", BusinessInfo[businessid][b_product_price] );
			
			pformat:( ""gbSuccess"�� ���������� "cBLUE"$%d"cWHITE" �� �������.", BusinessInfo[businessid][b_product_price] );
			psend:( playerid, C_WHITE );
			
			format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] );
			showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "�������", "�����" );
		}
		
		case d_business_panel + 11:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				return 
					format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] ),
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "�������", "�����" );
			}
			
			switch( listitem )
			{
				/*case 0:
				{
					ShowBusinessInterior( playerid, businessid );
				}*/
				
				case 0:
				{
					showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, " ", b_panel_texture, "�������", "�����" );
				}
				
				case 1:
				{
					ShowBusinessFurnList( playerid, businessid, 0 );
				}
				
				case 2:
				{
					format:g_small_string( ""cWHITE"%s", 
						BusinessInfo[businessid][b_state_cashbox] == 0 ? ("���������� �����"):("������ �����" ) 
					);
					
					showPlayerDialog( playerid, d_business_panel + 18, DIALOG_STYLE_LIST, " ", g_small_string, "�������", "�����" );
				}
			}
	
		}
		
		/*case d_business_panel + 12:
		{
			new
				interior,
				Float:pos[3],
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "�������", "�����" );
			}
			
			if( GetCountAroundPlayer( playerid, 40.0 ) )
			{
				ShowBusinessInterior( playerid, businessid );
				return SendClient:( playerid, C_WHITE, ""gbError"� ����� ������� ���� ������ ������, ���������� �����." );			
			}
			
			BusinessInfo[businessid][b_lock] = 0; //��������� ������, ����� �� ����� ������� ������
			UpdateBusiness( businessid, "b_lock", BusinessInfo[businessid][b_lock] );
			UpdateBusiness3DText( businessid );
			
			GameTextForPlayer( playerid, "~r~BUSINESS LOCK", 3000, 3 );
			
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
			
			SetPVarFloat( playerid, "Bpanel:pos[0]", pos[0] ),
			SetPVarFloat( playerid, "Bpanel:pos[1]", pos[1] ),
			SetPVarFloat( playerid, "Bpanel:pos[2]", pos[2] );
			
			SetPVarInt( playerid, "Bpanel:Interior", g_dialog_select[playerid][listitem] );
			interior = GetPVarInt( playerid, "Bpanel:Interior" );
			
			setPlayerPos( playerid, business_int[interior][bt_p][0], business_int[interior][bt_p][1], business_int[interior][bt_p][2] );
			stopPlayer( playerid, 2 );
			
			SetPlayerVirtualWorld( playerid, playerid + 100 );
			
			format:g_small_string( "�������� %d: $%d", business_int[interior][bt_id], GetPriceInterior( businessid, interior ) );
			PlayerTextDrawSetString( playerid, interior_info[playerid], g_small_string );
			
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", "\
				"gbDefault"��� ��������� ��������� ��� ������ �� ��������� ������� ������� "cBLUE"ALT"cWHITE".", "�������", "" );
		}*/
		//��������������� - ����� �����
		case d_business_panel + 13:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "�������", "�����" );
			}
			
			SetPVarInt( playerid, "Bpanel:Type", listitem );
			ShowBusinessPartInterior( playerid, GetPVarInt( playerid, "Bpanel:BId" ), listitem );
		}
		
		case d_business_panel + 14:
		{			
			if( !response )
			{
				DeletePVar( playerid, "Bpanel:Type" );
				return showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, "���������������", b_panel_texture, "�������", "�����" );
			}
			
			SelectedType{playerid} = 1;
			ShowTexViewer( playerid, GetPVarInt( playerid, "Bpanel:Type" ), listitem, 0 );
		}
		
		case d_business_panel + 15:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Bpanel:PriceTexture" );
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"�� ������������� ������� ���������� ��� ��������?\n\
						"gbDialog"����: "cBLUE"$%d", GetPVarInt( playerid, "Bpanel:PriceTexture" ) );
						
					showPlayerDialog( playerid, d_business_panel + 23, DIALOG_STYLE_MSGBOX, "���������������", g_small_string, "��", "���" );
				}
				
				case 1:
				{
					new
						bid = GetPVarInt( playerid, "Bpanel:BId" );
				
					switch( Menu3DData[playerid][CurrTextureType] )
					{
						case 0: SetBusinessTexture( bid, BusinessInfo[bid][b_wall][ Menu3DData[playerid][CurrPartNumber] ], 0, Menu3DData[playerid][CurrPartNumber] );
						case 1: SetBusinessTexture( bid, BusinessInfo[bid][b_floor][ Menu3DData[playerid][CurrPartNumber] ], 1, Menu3DData[playerid][CurrPartNumber] );
						case 2: SetBusinessTexture( bid, BusinessInfo[bid][b_roof][ Menu3DData[playerid][CurrPartNumber] ], 2, Menu3DData[playerid][CurrPartNumber] );
						case 3: SetBusinessTexture( bid, BusinessInfo[bid][b_stair], 3, INVALID_PARAM );
					}
				
					DeletePVar( playerid, "Bpanel:Type" );
					DeletePVar( playerid, "Bpanel:PriceTexture" );
					DestroyTexViewer( playerid );
					
					showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, "���������������", h_panel_texture, "�������", "�����" );
				}
			}
		}
		
		case d_business_panel + 23:
		{
			new
				price = GetPVarInt( playerid, "Bpanel:PriceTexture" ),
				bid = GetPVarInt( playerid, "Bpanel:BId" );
		
			if( !response )
			{
				format:g_small_string( "\
					"cWHITE"��������\t"cWHITE"���������\n\
					"cWHITE"������ ��������\t"cBLUE"$%d\n\
					"cWHITE"����� �� ���������", price );
		
				return showPlayerDialog( playerid, d_business_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "���������������", g_small_string, "�������", "�������" );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
			
				format:g_small_string( "\
					"cWHITE"��������\t"cWHITE"���������\n\
					"cWHITE"������ ��������\t"cBLUE"$%d\n\
					"cWHITE"����� �� ���������", price );
		
				return showPlayerDialog( playerid, d_business_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "���������������", g_small_string, "�������", "�������" );
			}
			
			UpdateBusinessTexture( playerid, bid, Menu3DData[playerid][CurrTextureType], Menu3DData[playerid][CurrPartNumber] );
		
			SetPlayerCash( playerid, "-", price );
			
			DeletePVar( playerid, "Bpanel:Type" );
			DeletePVar( playerid, "Bpanel:PriceTexture" );
			DestroyTexViewer( playerid );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"�������� ������� ���������." );
			
			showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, "���������������", b_panel_texture, "�������", "�����" );
		}
		
		case d_business_panel + 16:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Bpanel:FPage" );
				DeletePVar( playerid, "Bpanel:FPageMax" );
				DeletePVar( playerid, "Bpanel:FAll" );
			
				return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "�������", "�����" );
			}
			
			new
				businessid = GetPVarInt( playerid, "Bpanel:BId" ),
				fid;
			
			if( listitem == FURN_PAGE ) 
			{
				if( GetPVarInt( playerid, "Bpanel:FPage" ) == GetPVarInt( playerid, "Bpanel:FPageMax" ) )
					return ShowBusinessFurnList( playerid, businessid, GetPVarInt( playerid, "Bpanel:FPage" ) );
					
				return ShowBusinessFurnList( playerid, businessid, GetPVarInt( playerid, "Bpanel:FPage" ) + 1 );
			}
			else if( listitem == FURN_PAGE + 1 || 
				listitem == GetPVarInt( playerid, "Bpanel:FAll" ) && GetPVarInt( playerid, "Bpanel:FAll" ) < FURN_PAGE ) 
			{
				return ShowBusinessFurnList( playerid, businessid, GetPVarInt( playerid, "Bpanel:FPage" ) - 1 );
			}
			
			SetPVarInt( playerid, "Bpanel:FId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			fid = GetPVarInt( playerid, "Bpanel:FId" );
			 
			format:g_small_string(  ""cBLUE"1. "cGRAY"%s", 
				!BFurn[businessid][fid][f_state] ? ( "��������� ������\n"cBLUE"2. "cGRAY"���������� ������"):("����������� ������\n"cBLUE"2. "cGRAY"������ ������ �� ����� �������\n"cBLUE"3. "cGRAY"���������� ������") );
		    
			showPlayerDialog(playerid, d_business_panel + 17, DIALOG_STYLE_LIST, "���������� �������", g_small_string, "�������", "�����");
		}
		
		case d_business_panel + 17:
		{
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" ),
				fid = GetPVarInt( playerid, "Bpanel:FId" );
				
			if( !response ) return ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) );
				
			switch( listitem )
			{
				case 0:
				{
					if( !BFurn[bid][fid][f_state] )
					{
						new 
							Float:dist = 2.0,
							Float:angle,
							Float:pos[3],
							Float:rot[3];
							
						SendClient:( playerid, C_WHITE, !HELP_EDITOR );
						
						GetPlayerPos( playerid, BFurn[bid][fid][f_pos][0], BFurn[bid][fid][f_pos][1], BFurn[bid][fid][f_pos][2] );
						
						GetPlayerFacingAngle( playerid, angle );

						BFurn[bid][fid][f_pos][0] = BFurn[bid][fid][f_pos][0] + dist * - floatsin( angle, degrees );
	     				BFurn[bid][fid][f_pos][1] = BFurn[bid][fid][f_pos][1] + dist * floatcos( angle, degrees );
						
						for( new i = 0; i != 3; i++ )
						{
							pos[i] = BFurn[bid][fid][f_pos][i];
							rot[i] = BFurn[bid][fid][f_rot][i];
						}
						
						BFurn[bid][fid][f_object] = CreateDynamicObject(
							BFurn[bid][fid][f_model], 
							pos[0], pos[1], pos[2], rot[0], rot[1], rot[2],
							BusinessInfo[bid][b_id] 
						);
						
						EditDynamicObject( playerid, BFurn[bid][fid][f_object] );
						
						BFurn[bid][fid][f_state] = 1;
						
						//UpdateFurnitureBusiness( bid, fid );
						
						SetPVarInt( playerid, "Furn:Edit", 1 );
						
						SendClient:( playerid, C_GRAY, ""gbSuccess"������� ����������." );
						
						return 1;
					}
					
					new 
						Float:fpos[3];
					
					GetDynamicObjectPos( BFurn[bid][fid][f_object], fpos[0], fpos[1], fpos[2] );
					
					if( IsPlayerInRangeOfPoint( playerid, 10.0, fpos[0], fpos[1], fpos[2] ) ) 
					{ 
						EditDynamicObject( playerid, BFurn[bid][fid][f_object] );
						SetPVarInt( playerid, "Furn:Edit", 1 );
						return 1;
					}
					else 
					{
						return 
							ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) ),
							SendClient:( playerid, C_GRAY, ""gbError"������ ������� ������� ������ �� ���." );
					}
				}
				
				case 1:
				{
					if( BFurn[bid][fid][f_state] ) 
					{
						if( IsValidDynamicObject( BFurn[bid][fid][f_object] ) )
							DestroyDynamicObject( BFurn[bid][fid][f_object] );
						
						for( new i = 0; i != 3; i++ )
						{
							BFurn[bid][fid][f_pos][i] = 0.0;
							BFurn[bid][fid][f_rot][i] = 0.0;
						}
						
						BFurn[bid][fid][f_state] = 0;
						
						UpdateFurnitureBusiness( bid, fid );
						
						SendClient:( playerid, C_GRAY, ""gbSuccess"������� ������." );
						
						return ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) );
					}
				}
			}
			
			pformat:( ""gbSuccess"������� "cBLUE"%s"cWHITE" ���������.", BFurn[bid][fid][f_name] );
			psend:( playerid, C_WHITE );
			
			if( IsValidDynamicObject( BFurn[bid][fid][f_object] ) )
				DestroyDynamicObject( BFurn[bid][fid][f_object] );
						
			DeleteFurnitureBusiness( bid, fid );
			BusinessInfo[bid][b_count_furn]--;
						
			ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) );
		}
		
		//������ � ������
		case d_business_panel + 18:
		{
			if( !response ) return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "�������", "�����" );
			
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" );
			
			if( !BusinessInfo[bid][b_state_cashbox] )
			{
				showPlayerDialog( playerid, d_business_panel + 19, DIALOG_STYLE_MSGBOX, " ",
					""cBLUE"��������� �����\n\n\
					"cWHITE"�� ������������� ������� ���������� ����� � ���� �����?\n\n\
					"gbDialog"����� ��������� ������������ �������� ������.",
				"��","���" );
			}
			else
			{
				showPlayerDialog( playerid, d_business_panel + 20, DIALOG_STYLE_MSGBOX, " ",
					""cBLUE"�������� �����\n\n\
					"cWHITE"�� ������������� ������� ������� �����?",
				"��","���" );
			}
		}
		//������ � ������ 2
		case d_business_panel + 19:
		{
			if( !response ) return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "�������", "�����" );
			
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" ),
				Float:pos[3];
			
			BusinessInfo[bid][b_state_cashbox] = 1;
			
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
			
			for( new i = 0; i != 3; i++ )
			{
				BusinessInfo[bid][b_pos_cashbox][i] = pos[i];
			}
			
			UpdateBusinessCashBox( bid );
			
			BusinessInfo[bid][b_cashbox] = CreateDynamicPickup( 1239, 23, 
				BusinessInfo[bid][b_pos_cashbox][0],
				BusinessInfo[bid][b_pos_cashbox][1],
				BusinessInfo[bid][b_pos_cashbox][2], BusinessInfo[bid][b_id] 
			);
			
			SendClient:( playerid, C_BLUE, ""gbSuccess"����� �����������." );
		}
		
		//������ � ������ 3
		case d_business_panel + 20:
		{
			if( !response ) return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "�������", "�����" );
			
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" );
			
			BusinessInfo[bid][b_state_cashbox] = 0;
			
			for( new i = 0; i != 3; i++ )
			{
				BusinessInfo[bid][b_pos_cashbox][i] = 0.0;
			}
			
			UpdateBusinessCashBox( bid );
			
			DestroyDynamicPickup( BusinessInfo[bid][b_cashbox] );
			
			SendClient:( playerid, C_GRAY, ""gbSuccess"����� �������." );
		}
		
		//������ ��� ��������� ���������
		case d_business_panel + 21:
		{
			if( !response ) 
			{
				SelectTextDraw( playerid, 0x797C7CFF );
				SetPVarInt( playerid, "Bpanel:IntShow", 1 );
				return 1;
			}
			
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" ),
				interior = GetPVarInt( playerid, "Bpanel:Interior" ),
				price = GetPriceInterior( bid, interior );
			
			if( BusinessInfo[bid][b_safe] < price )
			{
				SendClient:( playerid, C_WHITE, ""gbError"� ����� ������� ������������ ������� ��� ��������� ���������." );
				
				SelectTextDraw( playerid, 0x797C7CFF );
				SetPVarInt( playerid, "Bpanel:IntShow", 1 );
				return 1;
			}
			
			BusinessInfo[bid][b_interior] = business_int[interior][bt_id];
			
			for( new i = 0; i < 4; i++ )
			{
				BusinessInfo[bid][b_exit_pos][i] = business_int[interior][bt_p][i];
			}
			
			BusinessInfo[bid][b_state_cashbox] = 0;
			for( new i = 0; i != 3; i++ )
			{
				BusinessInfo[bid][b_pos_cashbox][i] = 0.0;
			}
			
			BusinessInfo[bid][b_wall][0] = 
			BusinessInfo[bid][b_wall][1] = 
			BusinessInfo[bid][b_wall][2] = 
			BusinessInfo[bid][b_floor][0] = 
			BusinessInfo[bid][b_floor][1] = 
			BusinessInfo[bid][b_floor][2] = 
			BusinessInfo[bid][b_floor][3] = 
			BusinessInfo[bid][b_roof] = 0;
			
			mysql_format:g_string( "UPDATE `"DB_BUSINESS"` \
			SET `b_int` = '%d', \
				`b_exit_pos` = '%f|%f|%f|%f', \
				`b_wall` = '0|0|0', \
				`b_floor` = '0|0|0|0', \
				`b_roof` = 0 \
			WHERE `b_id` = %d LIMIT 1",
				BusinessInfo[bid][b_interior],
				BusinessInfo[bid][b_exit_pos][0],
				BusinessInfo[bid][b_exit_pos][1],
				BusinessInfo[bid][b_exit_pos][2],
				BusinessInfo[bid][b_exit_pos][3],
				BusinessInfo[bid][b_id]
			);
			mysql_tquery( mysql, g_string );
			
			setPlayerPos( playerid, BusinessInfo[bid][b_exit_pos][0], BusinessInfo[bid][b_exit_pos][1], BusinessInfo[bid][b_exit_pos][2] );
			
			SetPlayerVirtualWorld( playerid, BusinessInfo[bid][b_id] );
			
			DestroyDynamic3DTextLabel( BusinessInfo[bid][b_alt_text] );
			BusinessInfo[bid][b_alt_text] = CreateDynamic3DTextLabel( 
				"Exit", 
				C_BLUE, 
				BusinessInfo[bid][b_exit_pos][0], 
				BusinessInfo[bid][b_exit_pos][1], 
				BusinessInfo[bid][b_exit_pos][2] - 1.0, 
				3.0, 
				INVALID_PLAYER_ID, 
				INVALID_VEHICLE_ID, 
				0,
				BusinessInfo[bid][b_id] 
			);
			
			BusinessInfo[bid][b_safe] -= price;
			UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
			
			pformat:( ""gbSuccess"�� ���������� �������� "cBLUE"#%d"cWHITE", � ������ ������� ������� "cBLUE"$%d"cWHITE".", BusinessInfo[bid][b_interior], price );
			psend:( playerid, C_WHITE );
			
			LoadBusinessInterior( bid );
			UpdateBusinessCashBox( bid );
			
			DestroyDynamicPickup( BusinessInfo[bid][b_cashbox] );
			
			for( new f; f < GetMaxFurnBusiness( bid ); f++ ) 
			{
				if( BFurn[bid][f][f_id] ) 
				{
					if( BFurn[bid][f][f_state] ) 
					{
						if( IsValidDynamicObject( BFurn[bid][f][f_object] ) )
							DestroyDynamicObject( BFurn[bid][f][f_object] );
						
						for( new j = 0; j != 3; j++ )
						{
							BFurn[bid][f][f_pos][j] = 0.0;
							BFurn[bid][f][f_rot][j] = 0.0;
						}
						
						BFurn[bid][f][f_state] = 0;
					}
				}
			}
			
			mysql_format:g_string( "UPDATE `"DB_BUSINESS_FURN"` \
			SET `f_position` = '0.0|0.0|0.0', \
				`f_rotation` = '0.0|0.0|0.0', \
				`f_state` = 0 \
			WHERE `f_bid` = %d",
				BusinessInfo[bid][b_id]
			);
			mysql_tquery( mysql, g_string );
			
			SetPVarInt( playerid, "Bpanel:Interior", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Bpanel:BId", INVALID_PLAYER_ID );
			SetPVarFloat( playerid, "Bpanel:pos[0]", INVALID_PLAYER_ID ),
			SetPVarFloat( playerid, "Bpanel:pos[1]", INVALID_PLAYER_ID ),
			SetPVarFloat( playerid, "Bpanel:pos[2]", INVALID_PLAYER_ID );
				
			PlayerTextDrawHide( playerid, interior_info[playerid] );
		}
	}
	return 1;
}