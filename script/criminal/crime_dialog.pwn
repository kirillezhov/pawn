function Crime_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	switch( dialogid )
	{
		case d_crime :
		{
			if( !response ) return 1;
			
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
			
			switch( listitem )
			{
				case 0: //������ �����������
				{
					ShowCrimeMembers( playerid, d_crime + 1, "�����", "" );
				}
				case 1: //������ ������
				{
					ShowCrimeRanks( playerid, crime, d_crime + 2 );
				}
				case 2: //���������
				{
					showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
				}
				case 3: //�������� ���������� ������
				{
					if( CrimeFraction[crime][c_index_dealer] != INVALID_PARAM )
					{
						if( CrimeFraction[crime][c_time_dealer] )
						{
							SendClient:( playerid, C_WHITE, !""gbError"����� ��� �� ������ �� ������������ �����." );
					
							format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
							return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "�������", "�������" );
						}
						
						new
							dealer = CrimeFraction[crime][c_index_dealer];
							
						SetPlayerCheckpoint( playerid, GunDealer[dealer][g_actor_pos][0], GunDealer[dealer][g_actor_pos][1], GunDealer[dealer][g_actor_pos][2], 3.0 );
						
						g_player_gps{playerid} = 1;
						return SendClient:( playerid, C_WHITE, ""gbDefault"�� ���������� ����� �� GPS-����������. ��� ������ ����������� - "cBLUE"/gps"cWHITE"");
					}
					
					SendClient:( playerid, C_WHITE, !""gbError"� ��������� ����� ������ �� ���������." );
					
					format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
					return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "�������", "�������" );
				}
			}
		}
		
		case d_crime + 1:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
		
			format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
			showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "�������", "�������" );
		}
		
		case d_crime + 2:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
		
			if( !response )
			{
				format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
				return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "�������", "�������" );
			}
			
			if( !PlayerLeaderCrime( playerid, crime ) )
			{
				SendClient:( playerid, C_WHITE, !NO_ACCESS );
						
				ShowCrimeRanks( playerid, crime, d_crime + 2 );
				return 1;
			}
			
			if( !listitem )
			{
				format:g_small_string( "\
					"cWHITE"���������� ����� ���\n"cBLUE"%s\n\n\
					"cWHITE"������� �������� ��� ������ �����:", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			else
			{
				new
					rank = g_dialog_select[playerid][listitem - 1];
				
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				ShowCrimeRankSettings( playerid, crime, rank );
			
				SetPVarInt( playerid, "Crime:Rank", rank );
			}
		}
		
		case d_crime + 3:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				bool:flag = false;
		
			if( !response )
			{
				ShowCrimeRanks( playerid, crime, d_crime + 2 );
				return 1;
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"���������� ����� ���\n"cBLUE"%s\n\n\
					"cWHITE"������� �������� ��� ������ �����:\n\
					"gbDialogError"������������ ������ �����.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				format:g_small_string( "\
					"cWHITE"���������� ����� ���\n"cBLUE"%s\n\n\
					"cWHITE"������� �������� ��� ������ �����:\n\
					"gbDialogError"�������� ���������� ����� ��������.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			for( new i; i < MAX_RANKS; i++ )
			{
				if( !CrimeRank[crime][i][r_id] )
				{
					flag = true;
					
					clean:<CrimeRank[crime][i][r_name]>;
					strcat( CrimeRank[crime][i][r_name], inputtext, 32 );
					
					CreateCrimeRank( i, crime );
					
					pformat:( ""gbSuccess"�� �������� ���� "cBLUE"%s"cWHITE". ��������� ���.", CrimeRank[crime][i][r_name] );
					psend:( playerid, C_WHITE );
					
					CrimeFraction[crime][c_ranks]++;
					
					break;
				}
			}
			
			if( !flag ) 
			{
				SendClient:( playerid, C_WHITE, ""gbError"�������� �������������� ����� ������ ��� ���� �����������." );
				
				format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
				return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "�������", "�������" );
			}
			
			ShowCrimeRanks( playerid, crime, d_crime + 2 );
		}
		
		case d_crime + 4:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:Rank" );
				ShowCrimeRanks( playerid, crime, d_crime + 2 );
				return 1;
			}
			
			switch( listitem )
			{
				//��������
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"��������� ����� "cBLUE"%s\n\n\
						"cWHITE"������� ����� �������� ��� �����:", CrimeRank[crime][rank][r_name] );
					
					showPlayerDialog( playerid, d_crime + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
				//������
				case 1:
				{
					if( !CrimeRank[crime][rank][r_invite] )
					{
						CrimeRank[crime][rank][r_invite] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_invite] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_invite", CrimeRank[crime][rank][r_invite] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//��������
				case 2:
				{
					if( !CrimeRank[crime][rank][r_uninvite] )
					{
						CrimeRank[crime][rank][r_uninvite] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_uninvite] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_uninvite", CrimeRank[crime][rank][r_uninvite] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//������
				case 3:
				{
					if( !CrimeRank[crime][rank][r_attach] )
					{
						CrimeRank[crime][rank][r_attach] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_attach] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_attach", CrimeRank[crime][rank][r_attach] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//����� ����������
				case 4:
				{
					if( !CrimeRank[crime][rank][r_spawnveh] )
					{
						CrimeRank[crime][rank][r_spawnveh] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_spawnveh] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_spawnveh", CrimeRank[crime][rank][r_spawnveh] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//������ ���������
				case 5:
				{
					if( !CrimeRank[crime][rank][r_call_weapon] )
					{
						CrimeRank[crime][rank][r_call_weapon] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_call_weapon] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_call_weapon", CrimeRank[crime][rank][r_call_weapon] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//���������
				case 6:
				{
					ShowCrimeVehicles( playerid, crime, rank );
				}
				//�����
				case 7:
				{
					format:g_small_string( "\
						"cWHITE"��������� ������ ��� "cBLUE"%s\n\n\
						"cWHITE"�� ������������� ������� ���������� ����� � ���� �����?\n\n\
						"gbDialog""cRED"��������! "cGRAY"���������� ������������ �������� ������.", CrimeRank[crime][rank][r_name] );
						
					showPlayerDialog( playerid, d_crime + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
				//���������� ���� ������
				case 8:
				{
					format:g_small_string( "\
						"cWHITE"���������� ���� "cBLUE"%s\n\n\
						"cWHITE"������� ID ������, �������� ������� ���������� ����:", CrimeRank[crime][rank][r_name] );
				
					showPlayerDialog( playerid, d_crime + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
				//������� ����
				case 9:
				{
					if( !GetAccessAdmin( playerid, 5 ) )
					{
						SendClient:( playerid, C_WHITE, !""gbError"��� �������� ����� ���������� � ��������������." );
						
						ShowCrimeRankSettings( playerid, crime, rank );
						return 1;
					}
				
					format:g_small_string( "\
						"cWHITE"�������� ����� "cBLUE"%s\n\n\
						"cWHITE"�� ������������� ������� ������� ����?", CrimeRank[crime][rank][r_name] );
				
					showPlayerDialog( playerid, d_crime + 11, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
			}
		}
		
		case d_crime + 5:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"��������� ����� "cBLUE"%s\n\n\
					"cWHITE"������� ����� �������� ��� �����:\n\
					"gbDialogError"������������ ������ �����.", CrimeRank[crime][rank][r_name] );
					
				return showPlayerDialog( playerid, d_crime + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				format:g_small_string( "\
					"cWHITE"��������� ����� "cBLUE"%s\n\n\
					"cWHITE"������� ����� �������� ��� �����:\n\
					"gbDialogError"�������� ���������� ����� ��������.", CrimeRank[crime][rank][r_name] );
					
				return showPlayerDialog( playerid, d_crime + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			clean:<CrimeRank[crime][rank][r_name]>;
			strcat( CrimeRank[crime][rank][r_name], inputtext, 32 );
			
			mysql_format:g_string( "UPDATE `"DB_CRIME_RANKS"` SET `r_name` = '%e' WHERE `r_id` = %d",
				CrimeRank[crime][rank][r_name],
				CrimeRank[crime][rank][r_id]
			);
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"�� �������� �������� ����� �� "cBLUE"%s"cWHITE".", CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowCrimeRankSettings( playerid, crime, rank );
		}
		
		case d_crime + 6:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
			
			if( !listitem )
			{
				format:g_small_string( "\
					"cWHITE"���������� ���������� ���������� ��� "cBLUE"%s\n\n\
					"cWHITE"������� ����� ������ ����������:", CrimeRank[crime][rank][r_name] );
				
				showPlayerDialog( playerid, d_crime + 7, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			else
			{
				new
					index = g_dialog_select[playerid][listitem - 1];
			
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				SetPVarInt( playerid, "Crime:Vehicle", index );
			
				format:g_small_string( "\
					"cWHITE"�������� ���������� ��� "cBLUE"%s\n\n\
					"cWHITE"�� ������������� ������� ������ �� ������� "cBLUE"%s"cWHITE"?", CrimeRank[crime][rank][r_name], GetVehicleModelName( CrimeRank[crime][rank][r_vehicles][index] ) );
					
				showPlayerDialog( playerid, d_crime + 8, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
			}
		}
		
		case d_crime + 7:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" ),
				bool:flag = false;
		
			if( !response )
			{
				ShowCrimeVehicles( playerid, crime, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 400 || strval( inputtext ) > 611 )
			{
				format:g_small_string( "\
					"cWHITE"���������� ���������� ���������� ��� "cBLUE"%s\n\n\
					"cWHITE"������� ����� ������ ����������:\n\n\
					"gbDialogError"������������ ������ �����.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 7, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			for( new j; j < 30; j++ )
			{
				if( !crime_vehicles[ CrimeFraction[crime][c_type] ][j] ) continue;
				
				if( crime_vehicles[ CrimeFraction[crime][c_type] ][j] == strval( inputtext ) )
				{
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				format:g_small_string( "\
					"cWHITE"���������� ���������� ���������� ��� "cBLUE"%s\n\n\
					"cWHITE"������� ����� ������ ����������:\n\n\
					"gbDialogError"������ ��������� ���������� ��� ����� �����������.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 7, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			flag = false;
			
			for( new i; i < 10; i++ )
			{
				if( !CrimeRank[crime][rank][r_vehicles][i] )
				{
					CrimeRank[crime][rank][r_vehicles][i] = strval( inputtext );
					flag = true;
					
					mysql_format:g_string( "UPDATE `"DB_CRIME_RANKS"` SET `r_vehicles` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
						CrimeRank[crime][rank][r_vehicles][0],
						CrimeRank[crime][rank][r_vehicles][1],
						CrimeRank[crime][rank][r_vehicles][2],
						CrimeRank[crime][rank][r_vehicles][3],
						CrimeRank[crime][rank][r_vehicles][4],
						CrimeRank[crime][rank][r_vehicles][5],
						CrimeRank[crime][rank][r_vehicles][6],
						CrimeRank[crime][rank][r_vehicles][7],
						CrimeRank[crime][rank][r_vehicles][8],
						CrimeRank[crime][rank][r_vehicles][9],
						CrimeRank[crime][rank][r_id]
					);
					
					mysql_tquery( mysql, g_string );
					break;
				}
			}
			
			if( !flag )
			{
				format:g_small_string( "\
					"cWHITE"���������� ���������� ���������� ��� "cBLUE"%s\n\n\
					"cWHITE"������� ����� ������ ����������:\n\n\
					"gbDialogError"�������������� ����� ��� ����� ��������.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 7, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			pformat:( ""gbSuccess"��������� "cBLUE"%s"cWHITE" �������� ��� ����� "cBLUE"%s"cWHITE".", GetVehicleModelName( strval( inputtext ) ), CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowCrimeVehicles( playerid, crime, rank );
		}
		
		case d_crime + 8:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" ),
				index = GetPVarInt( playerid, "Crime:Vehicle" );
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:Vehicle" );
			
				ShowCrimeVehicles( playerid, crime, rank );
				return 1;
			}
			
			CrimeRank[crime][rank][r_vehicles][index] = 0;
			
			mysql_format:g_string( "UPDATE `"DB_CRIME_RANKS"` SET `r_vehicles` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
				CrimeRank[crime][rank][r_vehicles][0],
				CrimeRank[crime][rank][r_vehicles][1],
				CrimeRank[crime][rank][r_vehicles][2],
				CrimeRank[crime][rank][r_vehicles][3],
				CrimeRank[crime][rank][r_vehicles][4],
				CrimeRank[crime][rank][r_vehicles][5],
				CrimeRank[crime][rank][r_vehicles][6],
				CrimeRank[crime][rank][r_vehicles][7],
				CrimeRank[crime][rank][r_vehicles][8],
				CrimeRank[crime][rank][r_vehicles][9],
				CrimeRank[crime][rank][r_id]
			);
					
			mysql_tquery( mysql, g_string );
			
			DeletePVar( playerid, "Crime:Vehicle" );
			ShowFractionVehicles( playerid, crime, rank );
		}
		
		case d_crime + 9:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
			
			GetPlayerPos( playerid, CrimeRank[crime][rank][r_spawn][0], CrimeRank[crime][rank][r_spawn][1], CrimeRank[crime][rank][r_spawn][2] );
			GetPlayerFacingAngle( playerid, CrimeRank[crime][rank][r_spawn][3] );
			
			CrimeRank[crime][rank][r_world][0] = GetPlayerVirtualWorld( playerid );
			CrimeRank[crime][rank][r_world][1] = GetPlayerInterior( playerid );
			
			mysql_format:g_string( "UPDATE `"DB_CRIME_RANKS"` SET `r_spawn` = '%f|%f|%f|%f', `r_world` = '%d|%d' WHERE `r_id` = %d",
				CrimeRank[crime][rank][r_spawn][0],
				CrimeRank[crime][rank][r_spawn][1],
				CrimeRank[crime][rank][r_spawn][2],
				CrimeRank[crime][rank][r_spawn][3],
				CrimeRank[crime][rank][r_world][0],
				CrimeRank[crime][rank][r_world][1],
				CrimeRank[crime][rank][r_id]
			);
					
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"�� ���������� ����� ��� ����� "cBLUE"%s"cWHITE".", CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowCrimeRankSettings( playerid, crime, rank );
		}
		
		case d_crime + 10:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || !IsLogged( strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"���������� ���� "cBLUE"%s\n\n\
					"cWHITE"������� ID ������, �������� ������� ���������� ����:\n\n\
					"gbDialogError"������������ ID ������.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( Player[strval( inputtext )][uCrimeM] != Player[playerid][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"���������� ���� "cBLUE"%s\n\n\
					"cWHITE"������� ID ������, �������� ������� ���������� ����:\n\n\
					"gbDialogError"����� �� ������� � ����� ������������ �����������.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( CMember[crime][i][m_id] == Player[strval( inputtext )][uID] )
				{
					CMember[crime][i][m_rank] = rank + 1;
					
					clean:<CMember[crime][i][m_name]>;
					strcat( CMember[crime][i][m_name], Player[strval( inputtext )][uName], 32 );
					
					break;
				}				
			}
			
			Player[strval( inputtext )][uCrimeRank] = CrimeRank[crime][rank][r_id];
			UpdatePlayer( strval( inputtext ), "uCrimeRank", CrimeRank[crime][rank][r_id] );
			
			pformat:( ""gbSuccess"�� ���������� ������ "cBLUE"%s"cWHITE" ���� "cBLUE"%s"cWHITE".", Player[strval( inputtext )][uName], CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"%s ��������� ��� ���� "cBLUE"%s"cWHITE".", Player[playerid][uName], CrimeRank[crime][rank][r_name] );
			psend:( strval( inputtext ), C_WHITE );
			
			ShowCrimeRankSettings( playerid, crime, rank );
		}
		
		case d_crime + 11:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
		
			mysql_format:g_small_string( "DELETE FROM `"DB_CRIME_RANKS"` WHERE `r_id` = %d LIMIT 1", CrimeRank[crime][rank][r_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeRank` = 0 WHERE `uCrimeRank` = %d AND `uCrimeM` = %d",
				CrimeRank[crime][rank][r_id],
				CrimeFraction[crime][c_id] );
			mysql_tquery( mysql, g_string );
			
			foreach(new i : Player)
			{
				if( Player[i][uCrimeM] == CrimeFraction[crime][c_id] && Player[i][uCrimeRank] == CrimeRank[crime][rank][r_id] )
					Player[i][uCrimeRank] = 0;
			}
			
			CrimeFraction[crime][c_ranks]--;
			
			pformat:( ""gbSuccess"���� "cBLUE"%s"cWHITE" ������� ������.", CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ClearDataCrimeRank( crime, rank );	

			DeletePVar( playerid, "Crime:Rank" );
			ShowCrimeRanks( playerid, crime, d_crime + 2 );
		}
		
		case d_crime + 12:
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				DeletePVar( playerid, "Crime:PlayerID" );
				return 1;
			}
			
			new
				id = GetPVarInt( playerid, "Crime:PlayerID" ),
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank;
			
			if( !listitem )
			{
				for( new i; i < MAX_MEMBERS; i++ )
				{
					if( CMember[crime][i][m_id] == Player[id][uID] )
					{
						CMember[crime][i][m_rank] = 0;
						
						clean:<CMember[crime][i][m_name]>;
						strcat( CMember[crime][i][m_name], Player[id][uName], 32 );
						
						break;
					}				
				}
				
				Player[id][uCrimeRank] = 0;
				UpdatePlayer( id, "uCrimeRank", Player[id][uCrimeRank] );
				
				pformat:( ""gbSuccess"�� ������� ���� ������ "cBLUE"%s"cWHITE".", Player[id][uName] );
				psend:( playerid, C_WHITE );
				
				pformat:( ""gbSuccess"%s ������ ��� ����.", Player[playerid][uName] );
				psend:( id, C_WHITE );
			}
			else
			{
				rank = g_dialog_select[playerid][listitem - 1];
				
				for( new i; i < MAX_MEMBERS; i++ )
				{
					if( CMember[crime][i][m_id] == Player[id][uID] )
					{
						CMember[crime][i][m_rank] = rank + 1;
						
						clean:<CMember[crime][i][m_name]>;
						strcat( CMember[crime][i][m_name], Player[id][uName], 32 );
						
						break;
					}				
				}
				
				Player[id][uCrimeRank] = CrimeRank[crime][rank][r_id];
				UpdatePlayer( id, "uCrimeRank", Player[id][uCrimeRank] );
				
				pformat:( ""gbSuccess"�� ���������� ������ "cBLUE"%s[%d]"cWHITE" ���� "cBLUE"%s"cWHITE".", Player[id][uName], id, CrimeRank[crime][rank][r_name] );
				psend:( playerid, C_WHITE );
				
				pformat:( ""gbSuccess"%s[%d] ��������� ��� ���� "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, CrimeRank[crime][rank][r_name] );
				psend:( id, C_WHITE );
			}
			
			g_player_interaction{playerid} = 0;
			DeletePVar( playerid, "Crime:PlayerID" );
		}
		
		case d_crime + 13:
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				DeletePVar( playerid, "Crime:PlayerID" );
				return 1;
			}
			
			new
				sendid = GetPVarInt( playerid, "Crime:PlayerID" ),
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank;
			
			if( !listitem )
			{
				SetPVarInt( sendid, "Crime:RankID", INVALID_PARAM );
			
				pformat:( ""gbDefault"�� ��������� ����������� "cBLUE"%s[%d]"cWHITE" � ���������� � "cBLUE"%s"cWHITE".", Player[sendid][uName], sendid, CrimeFraction[crime][c_name] );
				psend:( playerid, C_WHITE );
			
				format:g_small_string( "\
					"gbDefault"����� "cBLUE"%s[%d]"cWHITE" ���������� ���\n\
					�������� � "cBLUE"%s"cWHITE". �� ��������?", Player[playerid][uName], playerid, CrimeFraction[crime][c_name] );
					
				showPlayerDialog( sendid, d_crime + 14, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
			}
			else
			{
				rank = g_dialog_select[playerid][listitem - 1];
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				
				SetPVarInt( sendid, "Crime:RankID", rank );
			
				pformat:( ""gbDefault"�� ��������� ����������� "cBLUE"%s[%d]"cWHITE" � ���������� � ������ "cBLUE"%s"cWHITE".", Player[sendid][uName], sendid, CrimeRank[crime][rank][r_name] );
				psend:( playerid, C_WHITE );
			
				format:g_small_string( "\
					"gbDefault"����� "cBLUE"%s[%d]"cWHITE" ���������� ���\n\
					�������� � "cBLUE"%s"cWHITE" c ������ "cBLUE"%s"cWHITE". �� ��������?", 
					Player[playerid][uName], 
					playerid, 
					CrimeFraction[crime][c_name],
					CrimeRank[crime][rank][r_name] );
					
				showPlayerDialog( sendid, d_crime + 14, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
			}
			
			SetPVarInt( sendid, "Crime:PlayerID", playerid );
			SetPVarInt( sendid, "Crime:ID", crime );
			
			g_player_interaction{sendid} = 1;
		}
		
		case d_crime + 14:
		{
			new
				leaderid = GetPVarInt( playerid, "Crime:PlayerID" ),
				crime = GetPVarInt( playerid, "Crime:ID" ),
				rank = GetPVarInt( playerid, "Crime:RankID" ),
				member = INVALID_PARAM;
		
			if( !response )
			{
				pformat:( ""gbError"����� "cBLUE"%s[%d]"cWHITE" ��������� �� ���������� � "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, CrimeFraction[crime][c_name] );
				psend:( leaderid, C_WHITE );
				
				pformat:( ""gbError"�� ���������� �� ���������� � "cBLUE"%s"cWHITE".", CrimeFraction[crime][c_name] );
				psend:( playerid, C_WHITE );
				
				g_player_interaction{leaderid} =
				g_player_interaction{playerid} = 0;
				
				DeletePVar( playerid, "Crime:PlayerID" );
				DeletePVar( leaderid, "Crime:PlayerID" );
				
				DeletePVar( playerid, "Crime:ID" );
				DeletePVar( playerid, "Crime:RankID" );
				
				return 1;
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( !CMember[crime][i][m_id] )
				{
					member = i;
					break;
				}
			}
			
			if( member == INVALID_PARAM )
			{
				pformat:( ""gbError"����� "cBLUE"%s[%d]"cWHITE" �� ����� �������� � "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, CrimeFraction[crime][c_name] );
				psend:( leaderid, C_WHITE );
				
				pformat:( ""gbError"�� �� ������ �������� � "cBLUE"%s"cWHITE".", CrimeFraction[crime][c_name] );
				psend:( playerid, C_WHITE );
				
				g_player_interaction{leaderid} =
				g_player_interaction{playerid} = 0;
				
				DeletePVar( playerid, "Crime:PlayerID" );
				DeletePVar( leaderid, "Crime:PlayerID" );
				
				DeletePVar( playerid, "Crime:ID" );
				DeletePVar( playerid, "Crime:RankID" );
				
				return 1;
			}
			
			CMember[crime][member][m_id] = Player[playerid][uID];
			
			clean:<CMember[crime][member][m_name]>;
			strcat( CMember[crime][member][m_name], Player[playerid][uName], 32 );
			
			CMember[crime][member][m_lasttime] = Player[playerid][uLastTime];
			
			CrimeFraction[crime][c_members]++;
			
			pformat:( ""gbSuccess"����� "cBLUE"%s[%d]"cWHITE" ������������� � "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, CrimeFraction[crime][c_name] );
			psend:( leaderid, C_WHITE );
			
			switch( rank )
			{
				case INVALID_PARAM :
				{
					pformat:( ""gbSuccess"�� ����� ������ ������������ ��������� "cBLUE"%s"cWHITE" ��� �����.", CrimeFraction[crime][c_name] );
					psend:( playerid, C_WHITE );
				
					Player[playerid][uCrimeM] = CrimeFraction[crime][c_id];
					Player[playerid][uCrimeRank] = 0;
				}
				
				default :
				{
					pformat:( ""gbSuccess"�� ����� ������ ������������ ��������� "cBLUE"%s"cWHITE" � ������ "cBLUE"%s"cWHITE".", CrimeFraction[crime][c_name], CrimeRank[crime][rank][r_name] );
					psend:( playerid, C_WHITE );
					
					CMember[crime][member][m_rank] = rank + 1;
				
					Player[playerid][uCrimeM] = CrimeFraction[crime][c_id];
					Player[playerid][uCrimeRank] = CrimeRank[crime][rank][r_id];
				}
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeM` = %d, `uCrimeRank` = %d WHERE `uID` = %d",
				Player[playerid][uCrimeM],
				Player[playerid][uCrimeRank],
				Player[playerid][uID]
			);
			mysql_tquery( mysql, g_string );
			
			g_player_interaction{leaderid} =
			g_player_interaction{playerid} = 0;
				
			DeletePVar( playerid, "Crime:PlayerID" );
			DeletePVar( leaderid, "Crime:PlayerID" );
				
			DeletePVar( playerid, "Crime:ID" );
			DeletePVar( playerid, "Crime:RankID" );
		}
		
		case d_crime + 15:
		{
			if( !response ) 
			{
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
				
			switch( listitem )
			{
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"��������� �� ������������ ���������\n\
						"cBLUE"%s\n\n\
						"cWHITE"������� id ������:", CrimeFraction[crime][c_name] );
						
					showPlayerDialog( playerid, d_crime + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
				
				case 1:
				{
					format:g_small_string( "\
						"cWHITE"��������� �� ������������ ���������\n\
						"cBLUE"%s\n\n\
						"cWHITE"������� ����� ��������:", CrimeFraction[crime][c_name] );
						
					showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
			}
		}
		
		case d_crime + 16:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 15, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					��������� �� ID ������\n\
					��������� �� ������ ��������", "�������", "�������" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || !IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) )
			{
				format:g_small_string( "\
					"cWHITE"��������� �� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� id ������:\n\
					"gbDialogError"������������ id ������.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( PlayerLeaderCrime( strval( inputtext ), crime ) )
			{
				format:g_small_string( "\
					"cWHITE"��������� �� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� id ������:\n\
					"gbDialogError"�� �� ������ ������� ������.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( Player[strval( inputtext )][uCrimeM] != Player[playerid][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"��������� �� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� id ������:\n\
					"gbDialogError"����� �� �������� ������ ���� ������������ ���������.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( CMember[crime][i][m_id] == Player[strval( inputtext )][uID] )
				{
					CMember[crime][i][m_id] = 
					CMember[crime][i][m_lasttime] = 
					CMember[crime][i][m_rank] = 0;
				
					CMember[crime][i][m_name][0] = EOS;
				
					break;
				}
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeM` = 0, `uCrimeRank` = 0 WHERE `uID` = %d", Player[strval( inputtext )][uID] );
			mysql_tquery( mysql, g_string );
			
			CrimeFraction[crime][c_members]--;
			
			Player[strval( inputtext )][uCrimeM] = 
			Player[strval( inputtext )][uCrimeRank] = 0;
			
			pformat:( ""gbSuccess"�� ������� "cBLUE"%s[%d]"cWHITE" �� "cBLUE"%s"cWHITE".", Player[strval( inputtext )][uName], strval( inputtext ), CrimeFraction[crime][c_name] );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"�� ������� �� "cBLUE"%s"cWHITE" ������� "cBLUE"%s[%d]"cWHITE".", CrimeFraction[crime][c_name], Player[playerid][uName], playerid );
			psend:( strval( inputtext ), C_WHITE );
			
			g_player_interaction{playerid} = 0;
		}
		
		case d_crime + 17:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 15, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					��������� �� ID ������\n\
					��������� �� ������ ��������", "�������", "�������" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				member = INVALID_PARAM;
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || Player[playerid][uID] == strval( inputtext ) || strval( inputtext ) < 1 )
			{
				format:g_small_string( "\
					"cWHITE"��������� �� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ����� ��������:\n\
					"gbDialogError"������������ ����� ��������.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			foreach(new i : Player)
			{
				if( strval( inputtext ) == Player[i][uID] )
				{
					format:g_small_string( "\
						"cWHITE"��������� �� ������������ ���������\n\
						"cBLUE"%s\n\n\
						"cWHITE"������� ����� ��������:\n\
						"gbDialogError"����� � �������, �������������� ������ �������� ����������.", CrimeFraction[crime][c_name] );
							
					return showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
			}
			
			for( new i; i < 3; i++ )
			{
				if( strval( inputtext ) == CrimeFraction[crime][c_leader][i] )
				{
					format:g_small_string( "\
						"cWHITE"��������� �� ������������ ���������\n\
						"cBLUE"%s\n\n\
						"cWHITE"������� ����� ��������:\n\
						"gbDialogError"�� �� ������ ������� ������.", CrimeFraction[crime][c_name] );
							
					return showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( strval( inputtext ) == CMember[crime][i][m_id] )
				{
					member = i;
					break;
				}
			}
			
			if( member == INVALID_PARAM )
			{
				format:g_small_string( "\
					"cWHITE"��������� �� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ����� ��������:\n\
					"gbDialogError"����� �� �������� ������ ���� ������������ ���������.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeM` = 0, `uCrimeRank` = 0 WHERE `uID` = %d", strval( inputtext ) );
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"�� ������� "cBLUE"%s"cWHITE" �� "cBLUE"%s"cWHITE".", CMember[crime][member][m_name], CrimeFraction[crime][c_name] );
			psend:( playerid, C_WHITE );
			
			CrimeFraction[crime][c_members]--;
			
			CMember[crime][member][m_id] = 
			CMember[crime][member][m_lasttime] = 
			CMember[crime][member][m_rank] = 0;
				
			CMember[crime][member][m_name][0] = EOS;
				
			g_player_interaction{playerid} = 0;
		}
		//���������
		case d_crime + 18:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				rank;
		
			if( !response )
			{
				format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
				return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "�������", "�������" );
			}
			
			switch( listitem )
			{
				case 0: CrimeVehicles( playerid, crime );
				
				case 1:
				{
					if( !PlayerLeaderCrime( playerid, crime ) )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
						
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
					}
					
					if( CrimeFraction[crime][c_amountveh] >= CrimeFraction[crime][c_vehicles] )
					{
						pformat:( ""gbError"�������������� ����� ���������� ��� ����� ������� �������� [%d/%d].", CrimeFraction[crime][c_amountveh], CrimeFraction[crime][c_vehicles] );
						psend:( playerid, C_WHITE );
					
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
					}
				
					if( !CrimeFraction[crime][c_type_vehicles] )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
					
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
					}
				
					showPlayerDialog( playerid, d_crime + 20, DIALOG_STYLE_LIST, "������������ ����������", "\
						������ ���������� ����������\n\
						* ����������", "�������", "�����" );
				}
				
				case 2: // cspawn
				{
					if( PlayerLeaderCrime( playerid, crime ) ) goto next_crime;
					
					if( !Player[playerid][uCrimeRank] )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
					}
					
					rank = getCrimeRankId( playerid, crime );
						
					if( !CrimeRank[crime][rank][r_spawnveh] )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
					}
					
					next_crime:
				
					format:g_small_string( "\
						"cWHITE"������� ��������� ������������ �����������\n\
						"cBLUE"%s "cWHITE"�� ����������� �����\n\n\
						"cWHITE"������� ID ���������� � /dl:", CrimeFraction[crime][c_name] );
				
					showPlayerDialog( playerid, d_crime + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
				
				case 3: // fixcarall
				{
					cmd_fixcarall( playerid );
				}
				
				case 4: // ������������ ���������
				{
					format:g_small_string( "\
						"cWHITE"������������ ��������� ������������ �����������\n\
						"cBLUE"%s\n\n\
						"cWHITE"������� ID ���������� � /dl:", CrimeFraction[crime][c_name] );
						
					showPlayerDialog( playerid, d_crime + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
				
				case 5: //��������
				{
					if( !PlayerLeaderCrime( playerid, crime ) )
					{
						SendClient:( playerid, C_WHITE, !NO_LEADER );
						
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
					}
					
					if( !GetAccessAdmin( playerid, 5 ) )
					{
						SendClient:( playerid, C_WHITE, !""gbError"��� �������� ���������� ����������� ���������� � ��������������." );
						
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
					}
				
					format:g_small_string( "\
						"cWHITE"�������� ���������� ������������ �����������\n\
						"cBLUE"%s\n\n\
						"cWHITE"������� ID ���������� � /dl:", CrimeFraction[crime][c_name] );
				
					showPlayerDialog( playerid, d_crime + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
			}
		}
		
		case d_crime + 19:
		{
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
		}
		
		case d_crime + 20:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				type = CrimeFraction[crime][c_type];
			
			switch( listitem )
			{
				case 0:
				{
					clean:<g_string>;
					strcat( g_string, ""cGRAY"����� ������������ ����������� ��������:\n" );
				
					for( new i; i < 30; i++ )
					{
						if( crime_vehicles[type][i] )
						{
							format:g_small_string( "\n"cWHITE"������: %d, "cBLUE"%s"cWHITE"", crime_vehicles[type][i], GetVehicleModelName( crime_vehicles[type][i] ) );
							strcat( g_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_crime + 32, DIALOG_STYLE_MSGBOX, "������ ���������� ����������", g_string, "�����", "" );
				}
				
				case 1:
				{
					format:g_small_string( "\
						"cWHITE"������������ ���������� ��� ������������ ���������\n\
						"cBLUE"%s\n\n\
						"cWHITE"������� ����� ������ ����������:", CrimeFraction[crime][c_name] );
					showPlayerDialog( playerid, d_crime + 21, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
			}
		}
		
		case d_crime + 21:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 20, DIALOG_STYLE_LIST, "������������ ����������", "\
					������ ���������� ����������\n\
					* ����������", "�������", "�����" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				type = CrimeFraction[crime][c_type],
				bool:flag = false;
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 400 || strval( inputtext ) > 611 || VehicleInfo[strval( inputtext ) - 400][v_fracspawn] == INVALID_PARAM )
			{
				format:g_small_string( "\
					"cWHITE"������������ ���������� ��� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ����� ������ ����������:\n\
					"gbDialogError"������������ ������ �����.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 21, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
		
			for( new i; i < 66; i++ )
			{
				if( !crime_vehicles[type][i] ) continue;
			
				if( crime_vehicles[type][i] == strval( inputtext ) )
				{
					flag = true;					
					break;
				}
			}
			
			if( flag == false )
			{
				format:g_small_string( "\
					"cWHITE"������������ ���������� ��� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ����� ������ ����������:\n\
					"gbDialogError"������ ��������� ���������� ��� ����� ������������ ���������.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 21, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
		
			SetPVarInt( playerid, "Crime:BuyVehicle", strval(inputtext) );
			ShowFracVehicleInformation( playerid, strval(inputtext), d_crime + 22, "�����", "�����" );
		}
		
		case d_crime + 22:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				model = GetPVarInt( playerid, "Crime:BuyVehicle" ),
				price = floatround( VehicleInfo[ model - 400 ][v_price] / 100 * PERCENT_FOR_VEHICLE );
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:BuyVehicle" );
				
				format:g_small_string( "\
					"cWHITE"������������ ���������� ��� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ����� ������ ����������:", CrimeFraction[crime][c_name] );
				return showPlayerDialog( playerid, d_crime + 21, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				
				ShowFracVehicleInformation( playerid, strval(inputtext), d_crime + 22, "�����", "�����" );
				return 1;
			}
			
			format:g_small_string( "\
				"cWHITE"������������ ���������� ��� ������������ ���������\n\
				"cBLUE"%s\n\n\
				"cWHITE"������� ������ ���� ��� "cBLUE"%s"cWHITE":", CrimeFraction[crime][c_name], GetVehicleModelName( model ) );
				
			showPlayerDialog( playerid, d_crime + 23, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
		}
		
		case d_crime + 23:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				model = GetPVarInt( playerid, "Crime:BuyVehicle" );
		
			if( !response )
			{
				ShowFracVehicleInformation( playerid, model, d_crime + 22, "�����", "�����" );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 255 )
			{
				format:g_small_string( "\
					"cWHITE"������������ ���������� ��� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ������ ���� ��� "cBLUE"%s"cWHITE":\n\
					"gbDialogError"������������ ������ �����.", CrimeFraction[crime][c_name], GetVehicleModelName( model ) );
					
				return showPlayerDialog( playerid, d_crime + 23, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			SetPVarInt( playerid, "Crime:Color1Vehicle", strval( inputtext ) );
			format:g_small_string( "\
				"cWHITE"������������ ���������� ��� ������������ ���������\n\
				"cBLUE"%s\n\n\
				"cWHITE"������� ������ ���� ��� "cBLUE"%s"cWHITE":\n\
				"gbDialog"������ ����: %d", CrimeFraction[crime][c_name], GetVehicleModelName( model ), strval( inputtext ) );
					
			showPlayerDialog( playerid, d_crime + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
		}
		
		case d_crime + 24:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				model = GetPVarInt( playerid, "Crime:BuyVehicle" ),
				price = floatround( VehicleInfo[ model - 400 ][v_price] / 100 * PERCENT_FOR_VEHICLE ),
				color_1 = GetPVarInt( playerid, "Crime:Color1Vehicle" ),
				color_2,
				spawnveh = VehicleInfo[model - 400][v_fracspawn],
				index = random(5),
				bool:flag = false,
				car,
				number[ 10 ],
				abcnumber[10] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' },
				abcstring[26] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:Color1Vehicle" );
				
				format:g_small_string( "\
					"cWHITE"������������ ���������� ��� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ������ ���� ��� "cBLUE"%s"cWHITE":", CrimeFraction[crime][c_name], GetVehicleModelName( model ) );
					
				return showPlayerDialog( playerid, d_crime + 23, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 255 )
			{
				format:g_small_string( "\
					"cWHITE"������������ ���������� ��� ������������ ���������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ������ ���� ��� "cBLUE"%s"cWHITE":\n\
					"gbDialog"������ ����: %d\n\n\
					"gbDialogError"������������ ������ �����.", CrimeFraction[crime][c_name], GetVehicleModelName( model ), color_1 );
						
				return showPlayerDialog( playerid, d_crime + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				DeletePVar( playerid, "Crime:BuyVehicle" );
				DeletePVar( playerid, "Crime:Color1Vehicle" );
			
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
			}
			
			color_2 = strval( inputtext );
			
			for( new i; i < 7; i++ )
			{
				if( i < 1 || i > 3 )
				{
					number[i] = abcnumber[ random(10) ];
					continue;
				}
				
				number[i] = abcstring[ random(26) ];
			}
			
			for( new i; i < CrimeFraction[crime][c_vehicles]; i++ )
			{
				if( CVehicle[crime][i][v_number][0] == EOS )
				{					
					CVehicle[crime][i][v_id] = CreateVehicle( model, crime_vehicles_spawn[spawnveh][index][0], crime_vehicles_spawn[spawnveh][index][1], crime_vehicles_spawn[spawnveh][index][2], crime_vehicles_spawn[spawnveh][index][3], color_1, color_2, INVALID_PARAM );
					car = CVehicle[crime][i][v_id];
					
					clean:<CVehicle[crime][i][v_number]>;			
					strcat( CVehicle[crime][i][v_number], number, 10 );
										
					ClearVehicleData( car );
					
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				DeletePVar( playerid, "Crime:BuyVehicle" );
				DeletePVar( playerid, "Crime:Color1Vehicle" );
			
				SendClient:( playerid, C_WHITE, ""gbSuccess"�������������� ����� ��� ����� ������������ ����������� ��������." );
				return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
			}
			
			SetPlayerCash( playerid, "-", price );
			
			Vehicle[car][vehicle_user_id] = INVALID_PARAM;
			Vehicle[car][vehicle_model] = model;
			Vehicle[car][vehicle_crime] = Player[playerid][uCrimeM]; 
					
			Vehicle[car][vehicle_pos][0] = crime_vehicles_spawn[spawnveh][index][0];
			Vehicle[car][vehicle_pos][1] = crime_vehicles_spawn[spawnveh][index][1];
			Vehicle[car][vehicle_pos][2] = crime_vehicles_spawn[spawnveh][index][2];
			Vehicle[car][vehicle_pos][3] = crime_vehicles_spawn[spawnveh][index][3];
					
			Vehicle[car][vehicle_color][0] = color_1;
			Vehicle[car][vehicle_color][1] = color_2;
			Vehicle[car][vehicle_color][2] = 0;
					
			Vehicle[car][vehicle_fuel] = VehicleInfo[model - 400][v_fuel] / 100.0 * 20.0;
			Vehicle[car][vehicle_engine] = 100.0;
					
			Vehicle[car][vehicle_state_window][0] = 
			Vehicle[car][vehicle_state_window][1] =
			Vehicle[car][vehicle_state_window][2] =
			Vehicle[car][vehicle_state_window][3] = 1;
					
			Vehicle[car][vehicle_engine_date] = 
			Vehicle[car][vehicle_date] = gettime();
			
			clean:<Vehicle[car][vehicle_number]>;
			strcat( Vehicle[car][vehicle_number], number, 10 );
			
			SetVehicleNumberPlate( car, number );

			CreateCar( car );
			SetVehicleParams( car );
					
			CrimeFraction[crime][c_amountveh]++;
			
			pformat:( ""gbSuccess"�� ��������� "cBLUE"%s %s"cWHITE" ���. ����� "cBLUE"%s"cWHITE" ��� ����� ������������ �����������.", VehicleInfo[model - 400][v_type], GetVehicleModelName( model ), number );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"%s", crime_vehicles_description[spawnveh] );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Crime:BuyVehicle" );
			DeletePVar( playerid, "Crime:Color1Vehicle" );
			
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
		}
		
		case d_crime + 26:
		{
			if( !response ) return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"������� ��������� ������������ �����������\n\
					"cBLUE"%s "cWHITE"�� ����������� �����\n\n\
					"cWHITE"������� ID ���������� � /dl:\n\
					"gbDialogError"������������ ������ �����.", CrimeFraction[ crime ][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_crime] != Player[ playerid ][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"������� ��������� ������������ �����������\n\
					"cBLUE"%s "cWHITE"�� ����������� �����\n\n\
					"cWHITE"������� ID ���������� � /dl:\n\
					"gbDialogError"������ ��������� �� ����������� ����� ������������ �����������.", CrimeFraction[ crime ][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( IsVehicleOccupied( strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"������� ��������� ������������ �����������\n\
					"cBLUE"%s "cWHITE"�� ����������� �����\n\n\
					"cWHITE"������� ID ���������� � /dl:\n\
					"gbDialogError"������ ��������� ������������.", CrimeFraction[ crime ][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			SetVehicleZAngle( strval( inputtext ), Vehicle[strval( inputtext )][vehicle_pos][3] );
			setVehiclePos( strval( inputtext ), 
				Vehicle[ strval( inputtext ) ][vehicle_pos][0],
				Vehicle[ strval( inputtext ) ][vehicle_pos][1],
				Vehicle[ strval( inputtext ) ][vehicle_pos][2]
			);
			
			LinkVehicleToInterior( strval( inputtext ), Vehicle[ strval( inputtext ) ][vehicle_int] );
			SetVehicleVirtualWorld( strval( inputtext ), Vehicle[ strval( inputtext ) ][vehicle_world] );
			
			ResetVehicleParams( strval( inputtext ) );
			
			pformat:( ""gbSuccess"��������� "cBLUE"%s[%d]"cWHITE" ��������� �� ����������� �����.", GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ), strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
		}
		
		case d_crime + 27:
		{
			if( !response ) return 1;
			
			new
				vehicleid,
				amount,
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
			
			for( new i; i < CrimeFraction[crime][c_vehicles]; i++ )
			{
				if( CVehicle[crime][i][v_id]  )
				{
					vehicleid = CVehicle[crime][i][v_id];
				
					if( IsVehicleOccupied( vehicleid ) ) continue;
				
					SetVehicleZAngle( vehicleid, Vehicle[vehicleid][vehicle_pos][3] );
					setVehiclePos( vehicleid, 
						Vehicle[ vehicleid ][vehicle_pos][0],
						Vehicle[ vehicleid ][vehicle_pos][1],
						Vehicle[ vehicleid ][vehicle_pos][2]
					);
						
					LinkVehicleToInterior( vehicleid, Vehicle[ vehicleid ][vehicle_int] );
					SetVehicleVirtualWorld( vehicleid, Vehicle[ vehicleid ][vehicle_world] );
						
					ResetVehicleParams( vehicleid );
					
					amount++;
				}
			}
			
			if( !amount ) return SendClient:( playerid, C_WHITE, !""gbError"��� ���������� ����������." );
			
			pformat:( ""gbSuccess"�� ������� ������� �������������� ��������� �� ����������� �����: "cBLUE"%d", amount );
			psend:( playerid, C_WHITE );
			
			format:g_small_string( ""FRACTION_PREFIX" %s[%d] ������ �������������� ��������� �� ����������� �����: %d", Player[playerid][uName], playerid, amount );
			SendCrimeLeaderMessage( crime, C_DARKGRAY, g_small_string );
		}
		
		case d_crime + 28:
		{
			if( !response ) return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
			
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"������������ ��������� ������������ �����������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ID ���������� � /dl:", CrimeFraction[ crime ][c_name] );
							
				return showPlayerDialog( playerid, d_crime + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_crime] != Player[playerid][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"������������ ��������� ������������ �����������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ID ���������� � /dl:\n\
					"gbDialogError"������ ��������� �� ����������� ����� �����������.", CrimeFraction[ crime ][c_name] );
							
				return showPlayerDialog( playerid, d_crime + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( !IsPlayerInVehicle( playerid, strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"������������ ��������� ������������ �����������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ID ���������� � /dl:\n\
					"gbDialogError"��� ���������� ������� �������� �� ������ ���������� � ���� ����������.", CrimeFraction[ crime ][c_name] );
							
				return showPlayerDialog( playerid, d_crime + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			Vehicle[strval( inputtext )][vehicle_world] = GetVehicleVirtualWorld( strval( inputtext ) );
			
			if( Vehicle[strval( inputtext )][vehicle_world] )
				Vehicle[strval( inputtext )][vehicle_int] = 1;
			else
				Vehicle[strval( inputtext )][vehicle_int] = 0;
				
			SetVehiclePark( strval( inputtext ) );
			
			pformat:( ""gbSuccess"�� ������� ������������ ��������� - "cBLUE"%s[%d]"cWHITE".", GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ), strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
		}
		
		case d_crime + 29:
		{
			if( !response )
			{
				DeletePVar( playerid, "Crime:VId" );
				return 1;
			}
			
			new
				vid = GetPVarInt( playerid, "Crime:VId" );
				
			if( !IsPlayerInVehicle( playerid, vid ) )
			{
				DeletePVar( playerid, "Fraction:VId" );
				return SendClient:( playerid, C_WHITE, !""gbError"��� ���������� ������� �������� �� ������ ���������� � ����������." );
			}
			
			Vehicle[vid][vehicle_world] = GetVehicleVirtualWorld( vid );
			
			if( Vehicle[vid][vehicle_world] )
				Vehicle[vid][vehicle_int] = 1;
			else
				Vehicle[vid][vehicle_int] = 0;
			
			SetVehiclePark( vid );
			
			pformat:( ""gbSuccess"�� ������� ������������ ��������� - "cBLUE"%s[%d]"cWHITE".", GetVehicleModelName( Vehicle[vid][vehicle_model] ), vid );
			psend:( playerid, C_WHITE );
				
			DeletePVar( playerid, "Crime:VId" );
		}
		
		case d_crime + 30:
		{
			if( !response ) return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
		
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"�������� ���������� ������������ �����������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ID ���������� � /dl:\n\
					"gbDialogError"������������ ������ �����.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_crime] != Player[playerid][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"�������� ���������� ������������ �����������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ID ���������� � /dl:\n\
					"gbDialogError"������ ��������� �� ����������� ����� �����������.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			SetPVarInt( playerid, "Crime:VId", strval( inputtext ) );			
			
			format:g_small_string( "\
				"cWHITE"�������� ���������� ������������ �����������\n\
				"cBLUE"%s\n\n\
				"cWHITE"�� ������������� ������� ������� "cBLUE"%s[%d] ���. ����� %s"cWHITE"?",
				CrimeFraction[crime][c_name], 
				GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ),
				strval( inputtext ),
				Vehicle[strval( inputtext )][vehicle_number]
			);
			showPlayerDialog( playerid, d_crime + 31, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
		}
		
		case d_crime + 31:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				vid = GetPVarInt( playerid, "Crime:VId" );
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:VId" );
			
				format:g_small_string( "\
					"cWHITE"�������� ���������� ������������ �����������\n\
					"cBLUE"%s\n\n\
					"cWHITE"������� ID ���������� � /dl:", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			for( new i; i < CrimeFraction[crime][c_vehicles]; i++ )
			{
				if( CVehicle[crime][i][v_id] == vid )
				{
					CVehicle[crime][i][v_id] = 0;
					CVehicle[crime][i][v_number][0] = EOS;
					break;
				}
			}
			
			CrimeFraction[crime][c_amountveh]--;
			
			mysql_format:g_string( "DELETE FROM `"DB_VEHICLES"` WHERE `vehicle_id` = %d", Vehicle[vid][vehicle_id] );
			mysql_tquery( mysql, g_string );
			
			mysql_format:g_string( "DELETE FROM `"DB_ITEMS"` WHERE `item_type_id` = %d AND `item_type` = 2", Vehicle[vid][vehicle_id] );	
			mysql_tquery( mysql, g_string );

			pformat:( ""gbSuccess""cBLUE"%s"cWHITE" ������� ������.", GetVehicleModelName( GetVehicleModel( vid ) ) );
			psend:( playerid, C_WHITE );
			
			DestroyVehicleEx( vid );
			DeletePVar( playerid, "Crime:VId" );
			
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "�������", "�����" );
		}
		//�������� ��������
		case d_crime + 32:
		{
			showPlayerDialog( playerid, d_crime + 20, DIALOG_STYLE_LIST, "������������ ����������", "\
				������ ���������� ����������\n\
				* ����������", "�������", "�����" );
		}
		//������ ���������
		case d_crime + 33:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
				
			if( !response )
			{
				CrimeFraction[crime][c_time_dealer] = 0;
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"������� �����\n\
					"cWHITE"������ ��������� �����\n\
					������ ������\n\
					������ ���� �����",
				"�������", "�������" );
			}
			
			CrimeFraction[crime][c_time] = gettime() + DAYS_TO_GUNDEALER * 86400;
			
			switch( CrimeFraction[crime][c_type_weapon] )
			{
				case 1: CrimeFraction[crime][c_amount_weapon] = 15;
				case 2: CrimeFraction[crime][c_amount_weapon] = 30;
				case 3: CrimeFraction[crime][c_amount_weapon] = 45;
			}
			
			for( new i; i < 2; i++ )
			{
				for( new j; j < 10; j++ )
				{
					CrimeOrder[crime][i][gun_id][j] = 
					CrimeOrder[crime][i][gun_amount][j] = 0;
				}
			}
			
			showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "����� ������", "\
				"cBLUE"1."cWHITE" ������\n\
				"cBLUE"2."cWHITE" �������\n\
				"cBLUE"3."cWHITE" ����������\n\
				"gbDialog"����������", "�������", "������" );
		}
		
		case d_crime + 34:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
				
			if( !response )
			{
				CrimeFraction[crime][c_time] = 0;
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"������� �����\n\
					"cWHITE"������ ��������� �����\n\
					������ ������\n\
					������ ���� �����",
				"�������", "�������" );
			}
			
			if( listitem == 3 )
			{
				new
					total,
					amount;
			
				switch( CrimeFraction[crime][c_type_weapon] )
				{
					case 1: 
					{
						if( CrimeFraction[crime][c_amount_weapon] == 15 )
						{
							SendClient:( playerid, C_WHITE, !""gbError"�� �� �������� ������ ������." );
							return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "����� ������", "\
								"cBLUE"1."cWHITE" ������\n\
								"cBLUE"2."cWHITE" �������\n\
								"cBLUE"3."cWHITE" ����������\n\
								"gbDialog"����������", "�������", "������" );
						}
						
						amount = 15;
					}
					case 2: 
					{
						if( CrimeFraction[crime][c_amount_weapon] == 30 )
						{
							SendClient:( playerid, C_WHITE, !""gbError"�� �� �������� ������ ������." );
							return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "����� ������", "\
								"cBLUE"1."cWHITE" ������\n\
								"cBLUE"2."cWHITE" �������\n\
								"cBLUE"3."cWHITE" ����������\n\
								"gbDialog"����������", "�������", "������" );
						}
						
						amount = 30;
					}
					case 3: 
					{
						if( CrimeFraction[crime][c_amount_weapon] == 45 )
						{
							SendClient:( playerid, C_WHITE, !""gbError"�� �� �������� ������ ������." );
							return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "����� ������", "\
								"cBLUE"1."cWHITE" ������\n\
								"cBLUE"2."cWHITE" �������\n\
								"cBLUE"3."cWHITE" ����������\
								"gbDialog"����������", "�������", "������" );
						}
						
						amount = 45;
					}
				}
			
				for( new i; i < 2; i++ )
				{
					for( new j; j < 10; j++ )
					{
						if( CrimeOrder[crime][i][gun_amount][j] )
						{
							total += CrimeOrder[crime][i][gun_amount][j] * weapons_info[i][j][gun_price];
						}
					}
				}
			
				format:g_small_string( "\
					"cBLUE"����� ������\n\n\
					"cWHITE"����� ���������� ������: "cBLUE"%d\n\
					"cWHITE"�� �����: "cBLUE"$%d\n\n\
					"cWHITE"�������� ������?",
					amount - CrimeFraction[crime][c_amount_weapon], total );
					
				return showPlayerDialog( playerid, d_crime + 37, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
			}
			else if( listitem == 2 )
			{
				ShowCrimePriceInfo( playerid, CrimeFraction[crime][c_type_weapon] - 1 );
				return 1;
			}
			
			ShowWeaponsCrime( playerid, listitem, crime );
		}
		
		case d_crime + 35:
		{
			if( !response )
			{
				DeletePVar( playerid, "GunDealer:Type" );
				return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "����� ������", "\
					"cBLUE"1."cWHITE" ������\n\
					"cBLUE"2."cWHITE" �������\n\
					"cBLUE"3."cWHITE" ����������\n\
					"gbDialog"����������", "�������", "������" );
			}
			
			new
				type = GetPVarInt( playerid, "GunDealer:Type" ),
				id = getInventoryId( weapons_info[type][listitem][gun_id] ),
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
				
			SetPVarInt( playerid, "GunDealer:Weapon", listitem );
			format:g_small_string( "\
				"cBLUE"����� ������\n\n\
				"cWHITE"������� ���������� "cBLUE"%s"cWHITE":\n\
				"gbDialog"��� ��������: %d",
				inventory[id][i_name],
				CrimeFraction[crime][c_amount_weapon] + CrimeOrder[crime][type][gun_amount][listitem] );
			showPlayerDialog( playerid, d_crime + 36, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
		}
		
		case d_crime + 36:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				type = GetPVarInt( playerid, "GunDealer:Type" ),
				index = GetPVarInt( playerid, "GunDealer:Weapon" ),
				id = getInventoryId( weapons_info[type][index][gun_id] );
		
			if( !response )
			{
				DeletePVar( playerid, "GunDealer:Weapon" );
				ShowWeaponsCrime( playerid, type, crime );
				
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				format:g_small_string( "\
					"cBLUE"����� ������\n\n\
					"cWHITE"������� ���������� "cBLUE"%s"cWHITE":\n\
					"gbDialog"��� ��������: %d\n\n\
					"gbDialogError"������������ ������ �����",
					inventory[id][i_name],
					CrimeFraction[crime][c_amount_weapon] + CrimeOrder[crime][type][gun_amount][index] );
				return showPlayerDialog( playerid, d_crime + 36, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( CrimeFraction[crime][c_amount_weapon] - strval( inputtext ) < 0 )
			{
				format:g_small_string( "\
					"cBLUE"����� ������\n\n\
					"cWHITE"������� ���������� "cBLUE"%s"cWHITE":\n\
					"gbDialog"��� ��������: %d\n\n\
					"gbDialogError"�� ��������� �����",
					inventory[id][i_name],
					CrimeFraction[crime][c_amount_weapon] + CrimeOrder[crime][type][gun_amount][index] );
				return showPlayerDialog( playerid, d_crime + 36, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			if( CrimeOrder[crime][type][gun_amount][index] )
			{
				CrimeFraction[crime][c_amount_weapon] += CrimeOrder[crime][type][gun_amount][index];
			}
			
			CrimeFraction[crime][c_amount_weapon] -= strval( inputtext );
			
			CrimeOrder[crime][type][gun_amount][index] = strval( inputtext );
			
			DeletePVar( playerid, "GunDealer:Weapon" );
			GetPVarInt( playerid, "GunDealer:Type" );
			
			ShowWeaponsCrime( playerid, type, crime );
		}
		
		case d_crime + 37:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "����� ������", "\
					"cBLUE"1."cWHITE" ������\n\
					"cBLUE"2."cWHITE" �������\n\
					"cBLUE"3."cWHITE" ����������\n\
					"gbDialog"����������", "�������", "������" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				//time = randomize( 600, 1 * 3600 ),
				time = randomize( 300, 400 ),
				index = random( COUNT_GUNDEALERS ),
				hour, minute;
			
			if( GunDealer[ index ][g_fracid] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"������ � �������� ������. ���������� ��� ���." );
			
				return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "����� ������", "\
					"cBLUE"1."cWHITE" ������\n\
					"cBLUE"2."cWHITE" �������\n\
					"cBLUE"3."cWHITE" ����������\n\
					"gbDialog"����������", "�������", "������" );
			}
			
			for( new i; i < 2; i++ )
			{
				for( new j; j < 10; j++ )
				{
					if( CrimeOrder[crime][i][gun_amount][j] )
					{
						DealerOrder[ index ][i][gun_id][j] = weapons_info[i][j][gun_id];
						DealerOrder[ index ][i][gun_amount][j] = CrimeOrder[crime][i][gun_amount][j];
					}
					
					CrimeOrder[crime][i][gun_id][j] = 
					CrimeOrder[crime][i][gun_amount][j] = 0;
				}
				
				mysql_format:g_string( "INSERT INTO `"DB_CRIME_ORDER"` \
					( `point_id`, `point_type`, `point_gunid`, `point_amount` ) \
					VALUES \
					( %d, %d, '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d', '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' )",
					GunDealer[index][g_id],
					i + 1,
					DealerOrder[ index ][i][gun_id][0], DealerOrder[ index ][i][gun_id][1], DealerOrder[ index ][i][gun_id][2],
					DealerOrder[ index ][i][gun_id][3], DealerOrder[ index ][i][gun_id][4], DealerOrder[ index ][i][gun_id][5],
					DealerOrder[ index ][i][gun_id][6], DealerOrder[ index ][i][gun_id][7], DealerOrder[ index ][i][gun_id][8],
					DealerOrder[ index ][i][gun_id][9], 
					DealerOrder[ index ][i][gun_amount][0], DealerOrder[ index ][i][gun_amount][1], DealerOrder[ index ][i][gun_amount][2],
					DealerOrder[ index ][i][gun_amount][3], DealerOrder[ index ][i][gun_amount][4], DealerOrder[ index ][i][gun_amount][5],
					DealerOrder[ index ][i][gun_amount][6], DealerOrder[ index ][i][gun_amount][7], DealerOrder[ index ][i][gun_amount][8],
					DealerOrder[ index ][i][gun_amount][9] );
				mysql_tquery( mysql, g_string );
			}
			
			GunDealer[ index ][g_fracid] = CrimeFraction[crime][c_id];
			CrimeFraction[crime][c_time_dealer] = gettime() + time;
			CrimeFraction[crime][c_index_dealer] = index;
			GetPos2DZone( GunDealer[index][g_actor_pos][0], GunDealer[index][g_actor_pos][1], GunDealer[index][g_zone], 28 );
			
			gmtime( CrimeFraction[crime][c_time_dealer], _, _, _, hour, minute );
			
			format:g_small_string( ""FRACTION_PREFIX" %s[%d] ������� ����� �� ������: ����� ����� ������� � ������ %s � %02d:%02d",
				Player[playerid][uName], playerid, GunDealer[index][g_zone], hour, minute );
			SendCrimeMessage( crime, C_DARKGRAY, g_small_string );
			
			mysql_format:g_small_string( "UPDATE `"DB_CRIME"` SET `c_time` = %d, `c_time_dealer` = %d WHERE `c_id` = %d LIMIT 1",
				CrimeFraction[crime][c_time], CrimeFraction[crime][c_time_dealer], CrimeFraction[crime][c_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_small_string( "UPDATE `"DB_CRIME_GUNDEALER"` SET `g_fracid` = 1 WHERE `g_id` = %d LIMIT 1",
				GunDealer[ index ][g_id] );
			mysql_tquery( mysql, g_small_string );
			
			format:g_small_string("\
				"cBLUE"����� ������ � �������\n\n\
				"cWHITE"����� ����� ������� ��� � ������ "cBLUE"%s � %02d:%02d"cWHITE".", 
				GunDealer[index][g_zone], hour, minute );
				
			showPlayerDialog( playerid, d_crime + 38, DIALOG_STYLE_MSGBOX, " ", g_small_string, "�������", "" );
		}
		
		case d_crime + 38:
		{
			showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
				"gbDialog"������� �����\n\
				"cWHITE"������ ��������� �����\n\
				������ ������\n\
				������ ���� �����",
			"�������", "�������" );
		}
		
		case d_crime + 39:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Crime:Order" );
				return 1;
			}
			
			SetPVarInt( playerid, "Crime:Type", listitem );
			ShowWeaponsOrder( playerid, listitem, GetPVarInt( playerid, "Crime:Order" ) );
		}
		
		case d_crime + 40:
		{
			new
				type = GetPVarInt( playerid, "Crime:Type" ),
				order = GetPVarInt( playerid, "Crime:Order" );
				
			if( !response )
			{
				DeletePVar( playerid, "Crime:Type" );
				return showPlayerDialog( playerid, d_crime + 39, DIALOG_STYLE_LIST, "��������", "\
					"cBLUE"1."cWHITE" ������\n\
					"cBLUE"2."cWHITE" �������", "�������", "�������" );
			}
			
			SetPVarInt( playerid, "Crime:Index", g_dialog_select[playerid][listitem] );
			ShowAmountOrder( playerid, type, order, g_dialog_select[playerid][listitem] );
			
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_crime + 41:
		{
			new
				type = GetPVarInt( playerid, "Crime:Type" ),
				order = GetPVarInt( playerid, "Crime:Order" ),
				index = GetPVarInt( playerid, "Crime:Index" );
			
			if( !response )
			{
				DeletePVar( playerid, "Crime:Index" );
				ShowWeaponsOrder( playerid, type, order );
				return 1;
			}
			
			if( Player[playerid][uMoney] < weapons_info[type][index][gun_price] )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
			
				DeletePVar( playerid, "Crime:Index" );
				ShowWeaponsOrder( playerid, type, order );
				return 1;
			}
			
			if( !DealerOrder[order][type][gun_amount][index] )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"���� ����� ��������� ��������." );
			
				DeletePVar( playerid, "Crime:Index" );
				ShowWeaponsOrder( playerid, type, order );
				return 1;
			}
			
			if( !giveItem( playerid, DealerOrder[order][type][gun_id][index], 1, weapons_info[type][index][gun_amount] ) )
				return SendClient:( playerid, C_WHITE, ""gbError"� ��� ��� ���������� ����� � ���������." );
			
			DealerOrder[order][type][gun_amount][index] --;
			SetPlayerCash( playerid, "-", weapons_info[type][index][gun_price] );
			
			if( !DealerOrder[order][type][gun_amount][index] )
			{
				DealerOrder[order][type][gun_id][index] = 0;
			
				DeletePVar( playerid, "Crime:Index" );
				ShowWeaponsOrder( playerid, type, order );
				return 1;
			}
			
			ShowAmountOrder( playerid, type, order, index );
		}
		
		case d_crime + 42:
		{
			showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "����� ������", "\
				"cBLUE"1."cWHITE" ������\n\
				"cBLUE"2."cWHITE" �������\n\
				"cBLUE"3."cWHITE" ����������\n\
				"gbDialog"����������", "�������", "������" );
		}
	}
	
	return 1;
}