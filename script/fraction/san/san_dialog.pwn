function San_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_cnn: 
		{
			if( !response ) return 1;
			
			if( inputtext[0] == EOS )
			{
				format:g_string( "\
					"cBLUE"������ ����������\n\n\
					"cWHITE"����� ���������� ������ ���� ������������� � �� ������ ���������\n\
					����������� ���������. ����� �������� - "cBLUE"100"cWHITE".\n\
					"gbDefault"��������� ���������� - $%d.\n\n\
					"gbDialogError"���� ��� ����� ������.", NETWORK_ADPRICE );
				return showPlayerDialog( playerid, d_cnn, DIALOG_STYLE_INPUT, " ", g_string, "�����", "�������" );
			}
			
			if( strlen( inputtext ) > 100 )
			{
				format:g_string( "\
					"cBLUE"������ ����������\n\n\
					"cWHITE"����� ���������� ������ ���� ������������� � �� ������ ���������\n\
					����������� ���������. ����� �������� - "cBLUE"100"cWHITE".\n\
					"gbDefault"��������� ���������� - $%d.\n\n\
					"gbDialogError"�������� ���������� ����� ��������.", NETWORK_ADPRICE );
				return showPlayerDialog( playerid, d_cnn, DIALOG_STYLE_INPUT, " ", g_string, "�����", "�������" );
			}
			
			if( COUNT_ADVERTS >= MAX_ADVERT_INFO ) 
				return SendClient:( playerid, C_WHITE, !""gbError"������� ������ �����������, ���������� �����." );
			
			for( new i; i < MAX_ADVERT_INFO; i++ )
			{
				if( AD[i][a_text][0] == EOS )
				{
					strcat( AD[i][a_text], inputtext, 100 );
					strcat( AD[i][a_name], Player[playerid][uName], MAX_PLAYER_NAME );
					
					AD[i][a_phone] = GetPhoneNumber( playerid );
					AD[i][a_used] = false;
					
					COUNT_ADVERTS++;
					break;
				}
			}
			
			SetPlayerCash( playerid, "-", NETWORK_ADPRICE );
			NETWORK_COFFER += floatround( NETWORK_ADPRICE * 0.85 );
			
			mysql_format:g_small_string( "UPDATE `"DB_SAN"` SET `san_coffers` = %d WHERE 1", NETWORK_COFFER );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"���� ���������� ���������� �� ��������� ����������� SAN, �� ��������� "cBLUE"$%d"cWHITE".", NETWORK_ADPRICE );
			psend:( playerid, C_WHITE );
		}
		
		case d_cnn + 1:
		{
			if( !response ) 
			{
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			switch( listitem )
			{
				//������ ����������
				case 0:
				{
					ShowAds( playerid );
				}
				//������ ����
				case 1:
				{
					if( ETHER_STATUS != INVALID_PARAM )
					{
						if( ETHER_STATUS == playerid )
						{
							SendClient:( playerid, C_WHITE, !""gbDefault"�� �������� ������ ����." );
							
							Player[playerid][tEther] = false;
							
							ETHER_STATUS = INVALID_PARAM;
							
							ETHER_CALL = 
							ETHER_SMS = false;
						}
						else
						{
							pformat:( ""gbError"� ����� ��� ��������� ������� %s.", Player[ ETHER_STATUS ][uName] );
							psend:( playerid, C_WHITE );
						}
						
						g_player_interaction{playerid} = 0;
						return 1;
					}
				
					if( IsPlayerInAnyVehicle( playerid ) )
					{
						if( GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 488 && GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 582 )
						{
							g_player_interaction{playerid} = 0;
							return SendClient:( playerid, C_WHITE, !""gbError"��� ������ ����� �� ������ ���������� � ������������������ ����������." );
						}
						if( Vehicle[ GetPlayerVehicleID( playerid ) ][vehicle_member] != FRACTION_NEWS )
						{	
							g_player_interaction{playerid} = 0;
							return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
						}
					}
					else if( !IsPlayerInDynamicArea( playerid, NETWORK_ZONE ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"��� ������ ����� �� ������ ���������� � ������." );
					}
					
					ETHER_STATUS = playerid;
					SendClient:( playerid, C_WHITE, !""gbDefault"�� ����� � ������ ����. ����������� "cBLUE"/n"cWHITE" ��� �������� ���������." );
				
					Player[playerid][tEther] = true;
				}
				//���������� � ����
				case 2:
				{
					if( ETHER_STATUS != playerid )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"�� �� ��������� ������� �����." );
					}
						
					showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� ������ � ����\n\n\
						"cWHITE"������� id ������, �������� ������ ���������� � ����:",
						"�����", "�����" );
				}
				//������� � �����
				case 3:
				{
					if( ETHER_STATUS != playerid && !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"�� �� ��������� ������� �����." );
					}
					
					showPlayerDialog( playerid, d_cnn + 9, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"������� ������ � �����\n\n\
						"cWHITE"������� id ������, �������� ������ ������� � �����:",
						"�����", "�����" );
				}
				//����� �������
				case 4:
				{
					if( ETHER_STATUS != playerid && !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"�� �� ��������� ������� �����." );
					}
					
					if( ETHER_CALL )
					{
						ETHER_CALL = false;
					}
					else
					{
						ETHER_CALL = true;
					}
					
					cmd_newspanel( playerid );
				}
				//����� ���
				case 5:
				{
					if( ETHER_STATUS != playerid && !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"�� �� ��������� ������� �����." );
					}
					
					if( ETHER_SMS )
					{
						ETHER_SMS = false;
					}
					else
					{
						ETHER_SMS = true;
					}
					
					cmd_newspanel( playerid );
				}
				//��������� ����������
				case 6:
				{
					if( !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !NO_LEADER );
					}
					
					format:g_small_string( "\
						"cBLUE"�������� ��������� ����������\n\
						"cGRAY"������� ���������: "cBLUE"$%d"cWHITE"\n\n\
						���������� ����� ���������:\n\
						"gbDefault"�������� �� $1 �� $100.", NETWORK_ADPRICE );
						
					showPlayerDialog( playerid, d_cnn + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
				//������ �����������
				case 7:
				{
					if( !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !NO_LEADER );
					}
					
					format:g_small_string( "\
						"cBLUE"������� �� ���������� ����\n\
						"cGRAY"��������� �����: "cBLUE"$%d"cWHITE"\n\n\
						������� ����� ��� �������� �� ���������� ����:", NETWORK_COFFER );
						
					showPlayerDialog( playerid, d_cnn + 11, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
			}
		}
		
		case d_cnn + 2:
		{
			if( !response ) return cmd_newspanel( playerid );
			
			if( AD[ g_dialog_select[playerid][listitem] ][a_used] ) 
				return SendClient:( playerid, C_WHITE, !""gbError"��� ���������� ��� ������������� ���� �� ����������� San Andreas Network." );
			
			SetPVarInt( playerid, "San:AdvertId", g_dialog_select[playerid][listitem] );
			AD[ g_dialog_select[playerid][listitem] ][a_used] = true;
			
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "�������", "�����" );
		}
		
		case d_cnn + 3:
		{
			if( !response )
			{
				AD[ GetPVarInt( playerid, "San:AdvertId" ) ][a_used] = false;
				DeletePVar( playerid, "San:AdvertId" );
				
				ShowAds( playerid );
				return 1;
			}
			
			new
				aid = GetPVarInt( playerid, "San:AdvertId" );
			
			switch(listitem) 
			{
				//��������� � ��������� ����������
				case 0: 
				{
					format:g_small_string( "\
						"cWHITE"�����:\n\n"cBLUE"%s\n\n\
						"cGRAY"�������: "cBLUE"%s"cGRAY"\n\
						"cGRAY"�������: "cBLUE"%d\n\n\
						"cWHITE"��������� ��� ����������?", AD[aid][a_text], AD[aid][a_name], AD[aid][a_phone] );
					
					showPlayerDialog( playerid, d_cnn + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
				//������������� ����������
				case 1: 
				{
					format:g_small_string( "\
						"cWHITE"�����:\n\n"cBLUE"%s\n\n\
						"cGRAY"�������: "cBLUE"%s"cGRAY"\n\
						"cGRAY"�������: "cBLUE"%d\n\n\
						"cWHITE"������� ����������������� �����:", AD[aid][a_text], AD[aid][a_name], AD[aid][a_phone] );
					
					showPlayerDialog( playerid, d_cnn + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "��", "�����" );
				}
				//������� ����������
				case 2: 
				{
					format:g_small_string( "\
						"cWHITE"�� ������������� ������� ������� ����������, ������������ "cBLUE"%s"cWHITE"?", AD[aid][a_name] );
						
					showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
			}
		}
		
		case d_cnn + 4:
		{
			if( !response ) return showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "�������", "�����" );
		
			new
				aid = GetPVarInt( playerid, "San:AdvertId" ),
				fid = Player[playerid][uMember] - 1,
				rank = getRankId( playerid, fid );
				
			foreach(new i : Player) 
			{
				if( !IsLogged(i) || !Player[i][uSettings][4] ) continue;
			
				pformat:( "����������: %s. ���.: %d", AD[aid][a_text], AD[aid][a_phone] );
				psend:( i, C_GREEN );

				pformat:( "�������������� %s %s.", FRank[fid][rank][r_name], Player[playerid][uRPName] );
				psend:( i, C_GREEN );
			}
			
			clean:<AD[aid][a_text]>;
			clean:<AD[aid][a_name]>;
					
			AD[aid][a_used] = false;
			AD[aid][a_phone] = 0;
			
			COUNT_ADVERTS --;
			DeletePVar( playerid, "San:AdvertId" );
			
			g_player_interaction{playerid} = 0;
		}
		
		case d_cnn + 5:
		{
			if( !response ) return showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "�������", "�����" );
			
			new
				aid = GetPVarInt( playerid, "San:AdvertId" );
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"�����:\n\n"cBLUE"%s\n\n\
					"cGRAY"�������: "cBLUE"%s"cGRAY"\n\
					"cGRAY"�������: "cBLUE"%d\n\n\
					"cWHITE"������� ����������������� �����:\n\
					"gbDialogError"���� ��� ����� ������.", AD[aid][a_text], AD[aid][a_name], AD[aid][a_phone] );
					
				return showPlayerDialog( playerid, d_cnn + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "��", "�����" );
			}
			
			if( strlen( inputtext ) > 100 )
			{
				format:g_small_string( "\
					"cWHITE"�����:\n\n"cBLUE"%s\n\n\
					"cGRAY"�������: "cBLUE"%s"cGRAY"\n\
					"cGRAY"�������: "cBLUE"%d\n\n\
					"cWHITE"������� ����������������� �����:\n\
					"gbDialogError"�������� ���������� ����� ��������.", AD[aid][a_text], AD[aid][a_name], AD[aid][a_phone] );
					
				return showPlayerDialog( playerid, d_cnn + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "��", "�����" );
			}
			
			clean:<AD[aid][a_text]>;
			strcat( AD[aid][a_text], inputtext, 100 );
			
			SendClient:( playerid, C_WHITE, !""gbSuccess"����� ���������� ������� ��������������." );
			showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "�������", "�����" );
		}
		
		case d_cnn + 6:
		{
			if( !response ) return showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "�������", "�����" );
			
			new
				aid = GetPVarInt( playerid, "San:AdvertId" );
				
			pformat:( ""gbSuccess"���������� ������ %s ������� �������.", AD[aid][a_name] );
			psend:( playerid, C_WHITE );
				
			clean:<AD[aid][a_text]>;
			clean:<AD[aid][a_name]>;
					
			AD[aid][a_used] = false;
			AD[aid][a_phone] = 0;
			
			COUNT_ADVERTS--;
			DeletePVar( playerid, "San:AdvertId" );
			
			ShowAds( playerid );
		}
		
		case d_cnn + 7:
		{
			if( !response ) return cmd_newspanel( playerid );
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 0 || strval( inputtext ) > MAX_PLAYERS || !IsLogged( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� ������ � ����\n\n\
					"cWHITE"������� id ������, �������� ������ ���������� � ����:\n\n\
					"gbDialogError"������������ ������ �����.",
					"�����", "�����" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� ������ � ����\n\n\
					"cWHITE"������� id ������, �������� ������ ���������� � ����:\n\n\
					"gbDialogError"�� �� ������ ����������������� � ���� �������.",
					"�����", "�����" );
			}
			
			if( Player[ strval( inputtext ) ][tEther] )
			{
				return showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� ������ � ����\n\n\
					"cWHITE"������� id ������, �������� ������ ���������� � ����:\n\n\
					"gbDialogError"������ ����� ��� ��������� � �����.",
					"�����", "�����" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� ������ � ����\n\n\
					"cWHITE"������� id ������, �������� ������ ���������� � ����:\n\n\
					"gbDialogError"������� ������ ��� ����� � ����.",
					"�����", "�����" );
			}
			
			pformat:( ""gbSuccess"�� ��������� ����������� %s � ����, �������� �������������.", Player[ strval( inputtext ) ][uName] );
			psend:( playerid, C_WHITE );
			
			format:g_small_string( "\
				"cBLUE"%s"cWHITE" ���������� ��� �� ������� � �����. �� ��������?", Player[playerid][uRPName] );
			
			showPlayerDialog( strval( inputtext ), d_cnn + 8, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );	
			g_player_interaction{ strval( inputtext ) } = 1;		
				
			cmd_newspanel( playerid );
		}
		
		case d_cnn + 8:
		{
			if( !response )
			{
				if( IsLogged( ETHER_STATUS ) && ETHER_STATUS != INVALID_PARAM )
				{
					pformat:( ""gbError"%s ��������� �� ������� � �����.", Player[playerid][uName] );
					psend:( ETHER_STATUS, C_WHITE );
				}
			
				SendClient:( playerid, C_WHITE, !""gbDefault"�� ���������� �� ������� � �����." );
			
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			if( IsLogged( ETHER_STATUS ) && ETHER_STATUS != INVALID_PARAM )
			{
				pformat:( "[ ���� %s] %s ������������� � �����.", Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName] );
				psend:( ETHER_STATUS, C_LIGHTGREEN );
			}
			
			SendClient:( playerid, C_WHITE, !""gbDefault"�� �������������� � �����. ����������� "cBLUE"/n"cWHITE" ��� �������� ��������� � ����." );
			
			Player[playerid][tEther] = true;
			g_player_interaction{playerid} = 0;
		}
		
		case d_cnn + 9:
		{
			if( !response ) return cmd_newspanel( playerid );
		
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 0 || strval( inputtext ) > MAX_PLAYERS || !IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) )
			{
				return showPlayerDialog( playerid, d_cnn + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� ������ � �����\n\n\
					"cWHITE"������� id ������, �������� ������ ������� � �����:\n\n\
					"gbDialogError"������������ ������ �����.",
					"�����", "�����" );
			}
			
			if( !Player[ strval( inputtext ) ][tEther] )
			{
				return showPlayerDialog( playerid, d_cnn + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������� ������ � �����\n\n\
					"cWHITE"������� id ������, �������� ������ ������� � �����:\n\n\
					"gbDialogError"������ ����� �� ��������� � �����.",
					"�����", "�����" );
			}
			
			if( strval( inputtext ) == ETHER_STATUS )
			{
				ETHER_STATUS = INVALID_PARAM;
				
				ETHER_CALL = 
				ETHER_SMS = false;
				
				pformat:( ""gbDialog"�� ��������� �������� %s �� �����.", Player[ strval( inputtext ) ][uName] );
			}
			else
				pformat:( ""gbDialog"�� ��������� %s �� �����.", Player[ strval( inputtext ) ][uName] );
			
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbDefault"�� ���� ��������� �� ����� ������� %s.", Player[playerid][uName] );
			psend:( strval( inputtext ), C_WHITE );
			
			Player[ strval( inputtext ) ][tEther] = false;
			cmd_newspanel( playerid );
		}
		
		case d_cnn + 10:
		{
			if( !response ) return cmd_newspanel( playerid );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 100 )
			{
				format:g_small_string( "\
					"cBLUE"�������� ��������� ����������\n\
					"cGRAY"������� ���������: "cBLUE"$%d"cWHITE"\n\n\
					���������� ����� ���������:\n\
					"gbDefault"�������� �� $1 �� $100.\n\n\
					"gbDialogError"������������ ������ �����.", NETWORK_ADPRICE );
						
				return showPlayerDialog( playerid, d_cnn + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}

			if( strval( inputtext ) == NETWORK_ADPRICE )
			{
				format:g_small_string( "\
					"cBLUE"�������� ��������� ����������\n\
					"cGRAY"������� ���������: "cBLUE"$%d"cWHITE"\n\n\
					���������� ����� ���������:\n\
					"gbDefault"�������� �� $1 �� $100.\n\n\
					"gbDialogError"��������� ��������� ��������� � �������.", NETWORK_ADPRICE );
						
				return showPlayerDialog( playerid, d_cnn + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			NETWORK_ADPRICE = strval( inputtext );
			
			mysql_format:g_small_string( "UPDATE `"DB_SAN"` SET `san_adprice` = %d WHERE 1", NETWORK_ADPRICE );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"��������� ���������� �������� �� "cBLUE"$%d"cWHITE".", NETWORK_ADPRICE );
			psend:( playerid, C_WHITE );
			
			cmd_newspanel( playerid );
		}
		
		case d_cnn + 11:
		{
			if( !response ) return cmd_newspanel( playerid );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > NETWORK_COFFER )
			{
				format:g_small_string( "\
					"cBLUE"������� �� ���������� ����\n\
					"cGRAY"��������� �����: "cBLUE"$%d"cWHITE"\n\n\
					������� ����� ��� �������� �� ���������� ����:\n\n\
					"gbDialogError"������������ ������ �����.", NETWORK_COFFER );
					
				return showPlayerDialog( playerid, d_cnn + 11, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			NETWORK_COFFER -= strval( inputtext );
			SetPlayerBank( playerid, "+", strval( inputtext ) );
			
			mysql_format:g_small_string( "UPDATE `"DB_SAN"` SET `san_coffers` = %d WHERE 1", NETWORK_COFFER );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"�� �������� �� ���������� ���� "cBLUE"$%d"cWHITE".", strval( inputtext ) );
			psend:( playerid, C_WHITE );
	
			cmd_newspanel( playerid );
		}
	}
	
	return 1;
}