function Prison_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_prison: 
		{
			if( !response ) return 1;
			
			switch( listitem ) 
			{
				// �������-������� ������ ����� D
				case 0: 
				{
					if( all_block[BLOCK_D] ) 
					{
						SendClient:( playerid, C_GRAY, ""gbDefault"�� ������� ��� ������ ����� 'D'." );
						movePrisonBlock( BLOCK_D, false );
					}	
					else 
					{
						SendClient:( playerid, C_GRAY, ""gbDefault"�� ������� ��� ������ ����� 'D'." );
						movePrisonBlock( BLOCK_D, true );
					}	
					
					format:g_string( prison_computer, 
						all_block[BLOCK_D] ? ("�������"):("�������"),
						all_block[BLOCK_E] ? ("�������"):("�������"),
						prison_alarm ? ("��������������"):("������������")
					);
					showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "�������", "�������" );
				}
				
				// �������-������� ������ ����� E
				case 1: 
				{
					if( all_block[BLOCK_E] ) 
					{
						SendClient:( playerid, C_GRAY, ""gbDefault"�� ������� ��� ������ ����� 'E'." );
						movePrisonBlock( BLOCK_E, false );
					}	
					else 
					{
						SendClient:( playerid, C_GRAY, ""gbDefault"�� ������� ��� ������ ����� 'E'." );
						movePrisonBlock( BLOCK_E, true );
					}	
					
					format:g_string( prison_computer, 
						all_block[BLOCK_D] ? ("�������"):("�������"),
						all_block[BLOCK_E] ? ("�������"):("�������"),
						prison_alarm ? ("��������������"):("������������")
						);
					showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "�������", "�������" );
				}
				// ���������� �������� ���������������
				case 2:
				{
					showPlayerDialog( playerid, d_prison + 1, DIALOG_STYLE_LIST, "���������������", "\
						"cBLUE"1. "cWHITE"��������������� �� ������\n\
						"cBLUE"2. "cWHITE"��������������� �� ������ �\n\
						"cBLUE"3. "cWHITE"��������������� �� ������ B\n\
						"cBLUE"4. "cWHITE"��������������� �� ������ C\n\
						"cBLUE"5. "cWHITE"��������������� �� ������� D,E\n\
						"cBLUE"6. "cWHITE"��������������� �� ������ F\n\
						"cBLUE"7. "cWHITE"��������������� �� ��������", "�������", "�����" );
				}
				//���� ������
				case 3:
				{
					showPlayerDialog( playerid, d_prison + 2, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���� ������\n\n\
						"cWHITE"������� ��� � ������� ������������:\n\
						"gbDialog"������: Vasya_Pupkin", "�����", "�����" );
				}
				//�������
				case 4:
				{
					if( prison_alarm )
					{
						prison_alarm = false;
						SendClient:( playerid, C_WHITE, !""gbDefault"�� �������������� ������ �������." );
						
						foreach(new i: Player)
						{
							if( !IsLogged(i) ) continue;
							
							if( GetPlayerVirtualWorld(i) == 23 )
							{
								PlayerPlaySound( i, 0, 0.0, 0.0, 0.0 );
							}
							else if( !GetPlayerVirtualWorld(i) && IsPlayerInDynamicArea( i, prison_zone ) )
							{
								PlayerPlaySound( i, 0, 0.0, 0.0, 0.0 );
							}
						}
					}
					else
					{
						prison_alarm = true;
						SendClient:( playerid, C_WHITE, !""gbDefault"�� ������������ ������ �������." );
						
						foreach(new i: Player)
						{
							if( !IsLogged(i) ) continue;
							
							if( GetPlayerVirtualWorld(i) == 23 )
							{
								PlayerPlaySound( i, 3401, 0.0, 0.0, 2.0 );
							}
							else if( !GetPlayerVirtualWorld(i) && IsPlayerInDynamicArea( i, prison_zone ) )
							{
								PlayerPlaySound( i, 3401, 0.0, 0.0, 2.0 );
							}
						}
					}
					
					format:g_string( prison_computer, 
						all_block[BLOCK_D] ? ("�������"):("�������"),
						all_block[BLOCK_E] ? ("�������"):("�������"),
						prison_alarm ? ("��������������"):("������������")
						);
					showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "�������", "�������" );
				}
			}
		}
		
		case d_prison + 1: 
		{
			if( !response ) 
			{
				format:g_string( prison_computer, 
					all_block[BLOCK_D] ? ("�������"):("�������"),
					all_block[BLOCK_E] ? ("�������"):("�������"),
					prison_alarm ? ("��������������"):("������������")
					);
					
				return showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "�������", "�������" );
			}
			
			switch( listitem ) 
			{
				case 0: initCCTV( playerid, 6 );
				case 1: initCCTV( playerid, 4 );
				case 2: initCCTV( playerid, 3 );
				case 3: initCCTV( playerid, 2 );
				case 4: initCCTV( playerid, 1 );
				case 5: initCCTV( playerid, 7 );
				case 6: initCCTV( playerid, 5 );
			}
			
			SendClient:( playerid, C_WHITE, !""gbDefault"����������� "cBLUE"�������"cWHITE" ��� ������������ ����� �������������, ������� "cBLUE"N"cWHITE" ��� ������ �� ������ ���������." );
		}
		
		case d_prison + 2:
		{
			if( !response )
			{
				format:g_string( prison_computer, 
					all_block[BLOCK_D] ? ("�������"):("�������"),
					all_block[BLOCK_E] ? ("�������"):("�������"),
					prison_alarm ? ("��������������"):("������������")
					);
					
				return showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "�������", "�������" );
			}
			
			if( inputtext[0] == EOS || strlen( inputtext ) > MAX_PLAYER_NAME )
			{
				return showPlayerDialog( playerid, d_prison + 2, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���� ������\n\n\
					"cWHITE"������� ��� � ������� ������������:\n\
					"gbDialog"������: Vasya_Pupkin\n\n\
					"gbDialogError"������������ ������ �����.", "�����", "�����" );
			}
			
			format:g_small_string( "\
				"cWHITE"����� ���������� � ����������� "cBLUE"%s"cWHITE"?", inputtext );
			showPlayerDialog( playerid, d_prison + 3, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
			
			PrisonTemp[ p_name ][0] =
			PrisonTemp[ p_namearrest ][0] =
			PrisonTemp[ p_reason ][0] =
			PrisonTemp[ p_reasonudo ][0] = EOS;
			
			PrisonTemp[ p_camera ] =
			PrisonTemp[ p_uID ] =
			PrisonTemp[ p_cooler ] =
			PrisonTemp[ p_date ] =
			PrisonTemp[ p_dateexit ] =
			PrisonTemp[ p_dateudo ] = 0;
			
			mysql_format:g_small_string( "SELECT * FROM "DB_PRISON" WHERE `pName` = '%s' AND `pStatus` = 1", inputtext );
			mysql_tquery( mysql, g_small_string, "DownloadArrest" );
		}
		
		case d_prison + 3:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_prison + 2, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���� ������\n\n\
					"cWHITE"������� ��� � ������� ������������:\n\
					"gbDialog"������: Vasya_Pupkin", "�����", "�����" );
			}
			
			if( PrisonTemp[ p_name ][0] == EOS )
			{
				return showPlayerDialog( playerid, d_prison + 2, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���� ������\n\n\
					"cWHITE"������� ��� � ������� ������������:\n\
					"gbDialog"������: Vasya_Pupkin\n\n\
					"gbDialogError"����������� � ����� ����� �� ������.", "�����", "�����" );
			}
			
			new
				year,
				month,
				day;
			
			clean:<g_big_string>;
			
			format:g_small_string( ""cWHITE"����������� "cBLUE"#%d\n\n", PrisonTemp[p_uID] );
			strcat( g_big_string, g_small_string );
			
			format:g_small_string( ""cWHITE"��� � �������: "cBLUE"%s\n", PrisonTemp[p_name] );
			strcat( g_big_string, g_small_string );
			
			gmtime( PrisonTemp[p_date], year, month, day );
			
			format:g_small_string( ""cWHITE"���� ����������: "cBLUE"%02d.%02d.%d\n", day, month, year );
			strcat( g_big_string, g_small_string );
			
			format:g_small_string( ""cWHITE"����� ������: "cBLUE"%d\n", PrisonTemp[p_camera] );
			strcat( g_big_string, g_small_string );
			
			if( PrisonTemp[p_cooler] )
			{
				format:g_small_string( ""cWHITE"����� �������: "cBLUE"%d\n", PrisonTemp[p_cooler] );
				strcat( g_big_string, g_small_string );
			}
			
			format:g_small_string( ""cWHITE"�������:\n"cBLUE"%s\n\n", PrisonTemp[p_reason] );
			strcat( g_big_string, g_small_string );
			
			
			format:g_small_string( ""cWHITE"��� � ������� �������: "cBLUE"%s\n", PrisonTemp[p_namearrest] );
			strcat( g_big_string, g_small_string );
			
			
			if( PrisonTemp[p_dateexit] == INVALID_PARAM )
			{
				strcat( g_big_string, ""cWHITE"���� ������������: ����������\n\n");
			}
			else
			{
				gmtime( PrisonTemp[p_dateexit], year, month, day );
				
				format:g_small_string( ""cWHITE"���� ������������: "cBLUE"%02d.%02d.%d\n\n", day, month, year );
				strcat( g_big_string, g_small_string );
			}
			
			if( PrisonTemp[p_dateudo] )
			{
				gmtime( PrisonTemp[p_dateudo], year, month, day );
				
				format:g_small_string( ""cWHITE"��������� ������������: "cBLUE"%02d.%02d.%d\n", day, month, year );
				strcat( g_big_string, g_small_string );
				
				format:g_small_string( ""cWHITE"�������:\n"cBLUE"%s", PrisonTemp[p_reasonudo] );
				strcat( g_big_string, g_small_string );
			}
			
			showPlayerDialog( playerid, d_prison + 4, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
		}
		
		case d_prison + 4:
		{
			format:g_string( prison_computer, 
				all_block[BLOCK_D] ? ("�������"):("�������"),
				all_block[BLOCK_E] ? ("�������"):("�������"),
				prison_alarm ? ("��������������"):("������������")
			);
					
			return showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "�������", "�������" );
		}

		
		case d_arrest: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Arrest:ID" ), DeletePVar( playerid, "Arrest:ar_info" ),
				DeletePVar( playerid, "Arrest:ar_date" ), DeletePVar( playerid, "Arrest:ar_cam" );
				
				g_player_interaction{playerid} = 0;
				
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					showArrestMenu( playerid );
					return 1;
				}
			
				case 1: 
				{
					showPlayerDialog( playerid, d_arrest + 1, DIALOG_STYLE_INPUT, " ", 
						"������� ������� ������ ������:", "�����", "�����" );	
				}
				
				case 2: 
				{
					showPlayerDialog( playerid, d_arrest + 2, DIALOG_STYLE_INPUT, " ", 
						"������� ���� ���������� ������ � ����:\n\
						"gbDialog"-1 ��� ������������ ����������", "�����", "�����" );	
				}
				
				case 3: 
				{
					showPlayerDialog( playerid, d_arrest + 3, DIALOG_STYLE_INPUT, " ", 
						"������� ����� ������ ��� ������\n\
						"gbDialog"���������� �����: 27", "�����", "�����" );	
				}
				
				case 4: 
				{
					if( !GetPVarInt( playerid, "Arrest:ar_info" ) ||
						!GetPVarInt( playerid, "Arrest:ar_date" ) || 
						!GetPVarInt( playerid, "Arrest:ar_cam" ) ) 
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� ��� ���� ���������." );
						showArrestMenu( playerid );
						return 1;
					}	
					
					new 
						giveplayerid = GetPVarInt( playerid, "Arrest:ID" );
					
					if( !IsLogged( giveplayerid ) || GetDistanceBetweenPlayers( playerid, giveplayerid ) > 3.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld( giveplayerid ) )
					{
						SendClient:( playerid, C_WHITE, !""gbError"������� ������ ��� ����� � ����." );
						
						DeletePVar( playerid, "Arrest:ID" ), DeletePVar( playerid, "Arrest:ar_info_text" ),
						DeletePVar( playerid, "Arrest:ar_info" ), DeletePVar( playerid, "Arrest:ar_date" ), 
						DeletePVar( playerid, "Arrest:ar_cam" );
						
						g_player_interaction{playerid} = 0;
						
						return 1;
					}
					
					Prison[ giveplayerid ][p_date] = gettime();
					
					if( GetPVarInt( playerid, "Arrest:ar_date" ) > INVALID_PARAM )
						Prison[ giveplayerid ][p_dateexit] = gettime() + ( GetPVarInt( playerid, "Arrest:ar_date" ) * 86400 );
					else
						Prison[ giveplayerid ][p_dateexit] = INVALID_PARAM;
					
					Prison[ giveplayerid ][p_camera] = GetPVarInt( playerid, "Arrest:ar_cam" );
					GetPVarString( playerid, "Arrest:ar_info_text", Prison[ giveplayerid ][p_reason], 128 );
					
					format( Prison[ giveplayerid ][p_namearrest], MAX_PLAYER_NAME, "%s", Player[playerid][uName] );
					
					mysql_format:g_string( "INSERT INTO `"DB_PRISON"` \
						( `puID`, `pCamera`, `pName`, `pArrestName`, `pReason`, `pDate`, `pExitDate` ) VALUES \
						( %d, %d, '%s', '%s', '%s', %d, %d )",
						Player[ giveplayerid ][uID],
						Prison[ giveplayerid ][p_camera],
						Player[ giveplayerid ][uName],
						Prison[ giveplayerid ][p_namearrest],
						Prison[ giveplayerid ][p_reason], 
						Prison[ giveplayerid ][p_date],
						Prison[ giveplayerid ][p_dateexit] );
					mysql_tquery( mysql, g_string );
					
					setPlayerPos( giveplayerid, 
						pr_camera[ Prison[ giveplayerid ][p_camera] - 1 ][0],
						pr_camera[ Prison[ giveplayerid ][p_camera] - 1 ][1],
						pr_camera[ Prison[ giveplayerid ][p_camera] - 1 ][2] );
					setPrisonWeather( playerid );
					
					pformat:( ""gbDefault"������ "cBLUE"%s"cWHITE" �������� ��� � ����������� ������.", Player[playerid][uRPName] );
					psend:( giveplayerid, C_WHITE );
					
					pformat:( ""gbDefault"�� ��������� "cBLUE"%s"cWHITE" � ����������� ������.", Player[ giveplayerid ][uRPName] );
					psend:( playerid, C_WHITE );
					
					DeletePVar( playerid, "Arrest:ID" ), DeletePVar( playerid, "Arrest:ar_info_text" ),
					DeletePVar( playerid, "Arrest:ar_info" ), DeletePVar( playerid, "Arrest:ar_date" ), 
					DeletePVar( playerid, "Arrest:ar_cam" );
					
					g_player_interaction{playerid} = 0;
				}
			}
		}
		
		case d_arrest + 1: 
		{
			if( !response ) 
			{
				showArrestMenu( playerid );
				return 1;
			}
			
			if( inputtext[0] == EOS || strlen( inputtext ) > 128 ) 
			{
				return showPlayerDialog( playerid, d_arrest + 1, DIALOG_STYLE_INPUT, " ", 
					"������� ������� ������ ������:\n\
					"gbDialogError"������������ ������ �����.", "�����", "�����" );	
			}
			
			SetPVarInt( playerid, "Arrest:ar_info", 1 );
			SetPVarString( playerid, "Arrest:ar_info_text", inputtext );
			
			showArrestMenu( playerid );
		}
		
		case d_arrest + 2: 
		{
			if( !response ) 
			{
				showArrestMenu( playerid );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) ) 
			{
				return showPlayerDialog( playerid, d_arrest + 2, DIALOG_STYLE_INPUT, " ", 
					"������� ���� ���������� ������ � ����:\n\
					"gbDialog"-1 ��� ������������ ����������\n\n\
					"gbDialogError"������������ ������ �����.", "�����", "�����" );	
			}
			
			if( strval( inputtext ) < INVALID_PARAM || strval( inputtext ) == 0 || strval( inputtext ) > 365 )
			{
				return showPlayerDialog( playerid, d_arrest + 2, DIALOG_STYLE_INPUT, " ", 
					"������� ���� ���������� ������ � ����:\n\
					"gbDialog"-1 ��� ������������ ����������\n\n\
					"gbDialogError"���������� ���� ������ ���� �� -1 �� 365 ( �� ������� 0 ).", "�����", "�����" );	
			}
			
			SetPVarInt( playerid, "Arrest:ar_date", strval( inputtext ) );
			
			showArrestMenu( playerid );
		}
		
		
		case d_arrest + 3: 
		{
			if( !response ) 
			{
				showArrestMenu( playerid );
				return 1;
			}
						
			if( !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 27 ) 
			{
				return showPlayerDialog( playerid, d_arrest + 3, DIALOG_STYLE_INPUT, " ", 
					"������� ����� ������ ��� ������\n\
					"gbDialog"���������� �����: 27\n\n\
					"gbDialogError"������������ ������ �����.", "�����", "�����" );
			}
			
			SetPVarInt( playerid, "Arrest:ar_cam", strval( inputtext ) );
			showArrestMenu( playerid );
		}
	}
	
	return 1;
}