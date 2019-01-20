function Police_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{	
	switch( dialogid ) 
	{	
		case d_police:
		{
			if( !response ) return 1;
				
			switch( listitem )
			{	//������
				case 0: 
				{
					ShowPlayerPenalties( playerid, d_police + 23, "�����" );
				}
				//�������� �����
				case 1:
				{
					ShowPlayerVehicleList( playerid, d_police + 1, "�����" );
				}
				//�������� �� ������
				case 2:
				{
					if( GetStatusPlayerLicense( playerid, LICENSE_GUN_3 ) )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� ��� �������� ��� ������ �������� �� ������." );
						return showPlayerDialog( playerid, d_police, DIALOG_STYLE_LIST, "���� ����������", info_dialog, "�������", "�������" );
					}
				
				
					showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
						�������� ��������\n\
						���������� � ���������", "�������", "�����" );
				}
			}
		}
		
		case d_police + 1:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_police, DIALOG_STYLE_LIST, "���� ����������", info_dialog, "�������", "�������" );
			}
			
			if( !listitem ) 
			{
				ShowPlayerVehicleList( playerid, d_police + 1, "�����" );
			}
			else
			{
				if( Vehicle[ g_dialog_select[playerid][listitem] ][vehicle_number][0] != EOS )
				{
					SendClient:( playerid, C_WHITE, !""gbError"� ����� ���������� ��� ���� �������� ����." );
					ShowPlayerVehicleList( playerid, d_police + 1, "�����" );
					
					return 1;
				}
			
				SetPVarInt( playerid, "Player:VId", g_dialog_select[playerid][listitem] );
				
				format:g_small_string( "\
					"cBLUE"��������� ��������� �����\n\n\
					"cWHITE"�� ������� �������� �������� ���� ��� "cBLUE"%s"cWHITE"?\n\
					"gbDefault"��������� ������������ $%d.", GetVehicleModelName( Vehicle[ g_dialog_select[playerid][listitem] ][vehicle_model] ), 300 );
					
				showPlayerDialog( playerid, d_police + 2, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
		}
		
		case d_police + 2:
		{
			if( !response )
			{
				DeletePVar( playerid, "Player:VId" );
				ShowPlayerVehicleList( playerid, d_police + 1, "�����" );
				
				return 1;
			}
			
			if( Player[playerid][uMoney] < 300 )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
			
				DeletePVar( playerid, "Player:VId" );
				ShowPlayerVehicleList( playerid, d_police + 1, "�����" );
				
				return 1;
			}
			
			new
				vid = GetPVarInt( playerid, "Player:VId" ),
				abcnumber[10] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' },
				abcstring[26] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' },
				number[10];
			
			for( new i; i < 7; i++ )
			{
				if( i < 1 || i > 3 )
				{
					Vehicle[ vid ][vehicle_number][i] = abcnumber[ random(10) ];
					continue;
				}
				
				Vehicle[ vid ][vehicle_number][i] = abcstring[ random(26) ];
			}
			
			SetPlayerCash( playerid, "-", 300 );
			
			format( number, sizeof number, "%s", Vehicle[vid][vehicle_number] );
			SetVehicleNumberPlate( vid, number );
			
			mysql_format:g_small_string( "UPDATE `"DB_VEHICLES"` SET `vehicle_number` = '%e' WHERE `vehicle_id` = %d LIMIT 1", Vehicle[vid][vehicle_number], Vehicle[vid][vehicle_id] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"�� �������� �������� ���� "cBLUE"%s"cWHITE" �� ��������� %s.", Vehicle[vid][vehicle_number], GetVehicleModelName( Vehicle[vid][vehicle_model] ) );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Player:VId" );
		}
		
		case d_police + 3:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_police, DIALOG_STYLE_LIST, "���� ����������", info_dialog, "�������", "�������" );
			}
			
			switch( listitem )
			{
				case 0:
				{
					new
						bool:flag = false;
				
					for( new i; i < MAX_APPLICATION; i++ )
					{
						if( PApply[i][a_user_id] == Player[playerid][uID] )
						{
							SendClient:( playerid, C_WHITE, !""gbError"�� ��� ������ ������ �� ������� ������." );
						
							return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
								�������� ��������\n\
								���������� � ���������", "�������", "�����" );
						}
					
						if( !PApply[i][a_id] ) flag = true;						
					}
					
					if( !flag )
					{
						SendClient:( playerid, C_WHITE, !""gbError"������� ������ �� ��������� �������� ������� �������." );
						
						return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
							�������� ��������\n\
							���������� � ���������", "�������", "�����" );
					}
				
					for( new i; i < MAX_PENALTIES; i++ )
					{
						if( Penalty[playerid][i][pen_id] && !Penalty[playerid][i][pen_type] )
						{
							SendClient:( playerid, C_WHITE, !""gbError"� ��� ���� ������������ ������." );
						
							return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
								�������� ��������\n\
								���������� � ���������", "�������", "�����" );
						}
					}
					
					for( new i; i < MAX_LICENSES; i++ )
					{
						if( License[playerid][i][lic_id] && License[playerid][i][lic_take_date] )
						{
							SendClient:( playerid, C_WHITE, !""gbError"� ��� ���� ������� ��������." );
						
							return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
								�������� ��������\n\
								���������� � ���������", "�������", "�����" );
						}
					}
					
					if( !GetStatusPlayerLicense( playerid, LICENSE_GUN_1 ) )
					{
						if( Player[playerid][uMoney] < PRICE_LIC_GUN_1 )
						{
							SendClient:( playerid, C_WHITE, !NO_MONEY );
							
							return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
								�������� ��������\n\
								���������� � ���������", "�������", "�����" );
						}

						SetPVarInt( playerid, "Player:GunLevel", 1 );
						format:g_small_string( "\
							"cBLUE"�������� �� ������\n\n\
							"cWHITE"�� ������� ��������� ������ �� ��������� �������� �� ������ 1 ������?\n\
							"gbDialog"��������� ��������� �������� "cBLUE"$%d"cWHITE".", PRICE_LIC_GUN_1 );
					}
					else if( !GetStatusPlayerLicense( playerid, LICENSE_GUN_2 ) )
					{
						if( Player[playerid][uMoney] < PRICE_LIC_GUN_2 )
						{
							SendClient:( playerid, C_WHITE, !NO_MONEY );
							
							return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
								�������� ��������\n\
								���������� � ���������", "�������", "�����" );
						}
					
						SetPVarInt( playerid, "Player:GunLevel", 2 );
						format:g_small_string( "\
							"cBLUE"�������� �� ������\n\n\
							"cWHITE"�� ������� ��������� ������ �� ��������� �������� �� ������ 2 ������?\n\
							"gbDialog"��������� ��������� �������� "cBLUE"$%d"cWHITE".", PRICE_LIC_GUN_2 );
					}
					else if( !GetStatusPlayerLicense( playerid, LICENSE_GUN_3 ) )
					{
						if( Player[playerid][uMoney] < PRICE_LIC_GUN_3 )
						{
							SendClient:( playerid, C_WHITE, !NO_MONEY );
							
							return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
								�������� ��������\n\
								���������� � ���������", "�������", "�����" );
						}
					
						SetPVarInt( playerid, "Player:GunLevel", 3 );
						format:g_small_string( "\
							"cBLUE"�������� �� ������\n\n\
							"cWHITE"�� ������� ��������� ������ �� ��������� �������� �� ������ 3 ������?\n\
							"gbDialog"��������� ��������� �������� "cBLUE"$%d"cWHITE".", PRICE_LIC_GUN_3 );
					}
					
					showPlayerDialog( playerid, d_police + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
					
				}
				//���������� � ��������� ��������
				case 1:
				{
					format:g_big_string( info_weapon, PRICE_LIC_GUN_1, PRICE_LIC_GUN_2, PRICE_LIC_GUN_3 );
					showPlayerDialog( playerid, d_police + 24, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
				}
			}
		}
		
		case d_police + 4:
		{
			if( !response )
			{
				DeletePVar( playerid, "Player:GunLevel" );
			
				return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					�������� ��������\n\
					���������� � ���������", "�������", "�����" );
			}
			
			new
				index = INVALID_PARAM,
				level = GetPVarInt( playerid, "Player:GunLevel" );
				
			for( new i; i < MAX_APPLICATION; i++ )
			{
				if( !PApply[i][a_id] )
				{
					index = i;
					break;
				}						
			}
					
			if( index == INVALID_PARAM )
			{
				DeletePVar( playerid, "Player:GunLevel" );
				SendClient:( playerid, C_WHITE, !""gbError"������� ������ �� ��������� �������� ������� �������." );
				
				return showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					�������� ��������\n\
					���������� � ���������", "�������", "�����" );
			}
			
			PApply[index][a_level] = level;
			PApply[index][a_user_id] = Player[playerid][uID];
			PApply[index][a_date] = gettime();
			
			clean:<PApply[index][a_name]>;
			strcat( PApply[index][a_name], Player[playerid][uName], MAX_PLAYER_NAME );
			
			switch( level )
			{
				case 1: SetPlayerCash( playerid, "-", PRICE_LIC_GUN_1 );
				case 2: SetPlayerCash( playerid, "-", PRICE_LIC_GUN_2 );
				case 3: SetPlayerCash( playerid, "-", PRICE_LIC_GUN_3 );
			}
			
			mysql_format:g_small_string( "\
				INSERT INTO `"DB_APPLICATION"` \
				( `a_level`, `a_user_id`, `a_name`, `a_date` ) VALUES \
				( %d, %d, '%s', %d )",
				PApply[index][a_level],
				PApply[index][a_user_id],
				PApply[index][a_name],
				PApply[index][a_date]
			);
			mysql_tquery( mysql, g_small_string, "AddApplycation", "d", index );
			
			DeletePVar( playerid, "Player:GunLevel" );
			
			format:g_small_string( "\
				"cBLUE"����������\n\n\
				"cWHITE"�� �������� ������ �� ��������� �������� �� ������� ������ "cBLUE"%d"cWHITE" ������.\n\
				� ������ �������������� ������� ��� ���������� ����� �������� �� ��� ���������� ����.", level );
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "�������", "" );
		}
		
		case d_police + 5:
		{
			if( !response ) return 1;
			
			SetPVarInt( playerid, "Fraction:SelectApply", g_dialog_select[playerid][listitem] );
			
			format:g_small_string( ""cWHITE"%s %d �������", PApply[ g_dialog_select[playerid][listitem] ][a_name], PApply[ g_dialog_select[playerid][listitem] ][a_level] );
			showPlayerDialog( playerid, d_police + 6, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
				��������\n\
				���������", "�������", "�����" );
				
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_police + 6:
		{
			if( !response )
			{
				DeletePVar( playerid, "Fraction:SelectApply" );
			
				ShowApplications( playerid );
				return 1;
			}
			
			new
				index = GetPVarInt( playerid, "Fraction:SelectApply" );
				
			if( !PApply[index][a_id] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"������� �� ������ ������ ���� ������� �����." );
			
				DeletePVar( playerid, "Fraction:SelectApply" );
			
				ShowApplications( playerid );
				return 1;
			}
				
			switch( listitem )
			{
				case 0:
				{
					format:g_small_string( "\
						"cBLUE"�������� ������\n\n\
						"cWHITE"�� ������������� ������� ������ "cBLUE"%s"cWHITE" ���������� �� ������� ������ "cBLUE"%d"cWHITE" ������?",
						PApply[index][a_name], PApply[index][a_level] );
						
					showPlayerDialog( playerid, d_police + 7, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
				
				case 1:
				{
					format:g_small_string( "\
						"cBLUE"��������� ������\n\n\
						"cWHITE"�� ������������� ������� ��������� ������ "cBLUE"%s"cWHITE" �� ������� ������ "cBLUE"%d"cWHITE" ������?",
						PApply[index][a_name], PApply[index][a_level] );
						
					showPlayerDialog( playerid, d_police + 8, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
			}
		}
		
		case d_police + 7:
		{
			if( !response )
			{
				DeletePVar( playerid, "Fraction:SelectApply" );
			
				ShowApplications( playerid );
				return 1;
			}
			
			new
				index = GetPVarInt( playerid, "Fraction:SelectApply" ),
				bool:flag = false;
				
			if( !PApply[index][a_id] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"������� �� ������ ������ ���� ������� �����." );
			
				DeletePVar( playerid, "Fraction:SelectApply" );
			
				ShowApplications( playerid );
				return 1;
			}
			
			mysql_format:g_small_string( "DELETE FROM `"DB_APPLICATION"` WHERE `a_id` = %d LIMIT 1", PApply[index][a_id] );
			mysql_tquery( mysql, g_small_string );
			
			foreach(new i : Player)
			{
				if( !IsLogged( i ) ) continue;
				
				if( Player[i][uID] == PApply[index][a_user_id] )
				{
					for( new j; j < MAX_LICENSES; j++ )
					{
						if( !License[i][j][lic_id] )
						{
							License[i][j][lic_type] = 3 + PApply[index][a_level];
							License[i][j][lic_gave_date] = gettime();
							
							GivePlayerLicense( i, LIC_INSERT, j );
							
							break;
						}
					}
					
					pformat:( ""gbDefault"� ����������� ������������ ��� ���� �������� � ������ �� ������� ������ %d ������.", PApply[index][a_level] );
					psend:( i, C_WHITE );
					
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				mysql_format:g_string(
				"\
					INSERT INTO `"DB_LICENSES"`\
					(\
						`license_user_id`, \
						`license_name`, \
						`license_type`, \
						`license_gave_date` \
					) VALUES (\
						%d,\
						'%s',\
						%d,\
						%d \
					)",
					PApply[index][a_user_id],
					PApply[index][a_name],
					3 + PApply[index][a_level],
					gettime()
				);
				
				mysql_tquery( mysql, g_string );
			}
			
			pformat:( ""gbSuccess"�� ������ %s ���������� �� ������� ������ %d ������.", PApply[index][a_name], PApply[index][a_level] );
			psend:( playerid, C_WHITE );
			
			PApply[index][a_id] = 
			PApply[index][a_user_id] =
			PApply[index][a_level] = 
			PApply[index][a_date] = 0;
 			
			clean:<PApply[index][a_name]>;
			
			DeletePVar( playerid, "Fraction:SelectApply" );
		}
		
		case d_police + 8:
		{
			if( !response )
			{
				DeletePVar( playerid, "Fraction:SelectApply" );
			
				ShowApplications( playerid );
				return 1;
			}
			
			new
				index = GetPVarInt( playerid, "Fraction:SelectApply" ),
				bool:flag = false;
				
			if( !PApply[index][a_id] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"������� �� ������ ������ ���� ������� �����." );
			
				DeletePVar( playerid, "Fraction:SelectApply" );
			
				ShowApplications( playerid );
				return 1;
			}
			
			mysql_format:g_small_string( "DELETE FROM `"DB_APPLICATION"` WHERE `a_id` = %d LIMIT 1", PApply[index][a_id] );
			mysql_tquery( mysql, g_small_string );
			
			foreach(new i : Player)
			{
				if( !IsLogged( i ) ) continue;
				
				if( Player[i][uID] == PApply[index][a_user_id] )
				{
					switch( PApply[index][a_level] )
					{
						case 1:	SetPlayerBank( i, "+", PRICE_LIC_GUN_1 );
						case 2: SetPlayerBank( i, "+", PRICE_LIC_GUN_2 );
						case 3:	SetPlayerBank( i, "+", PRICE_LIC_GUN_3 );
					}
				
					SendClient:( i, C_WHITE, !""gbDefault"� ����������� ������������ ��� ���� �������� � ������ �� ������� ������. ����� ���������� �� ���������� ����." );
				
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				new
					price;
				
				switch( PApply[index][a_date] )
				{
					case 1:	price += PRICE_LIC_GUN_1;
					case 2: price += PRICE_LIC_GUN_2;
					case 3:	price += PRICE_LIC_GUN_3;
				}
			
				mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uBank` = `uBank` + %d WHERE `uID` = %d",
					price,
					PApply[index][a_user_id]
				);
				mysql_tquery( mysql, g_string );
			}
			
			pformat:( ""gbSuccess"�� �������� � ������ %s �� ������� ������ %d ������.", PApply[index][a_name], PApply[index][a_level] );
			psend:( playerid, C_WHITE );
			
			PApply[index][a_id] = 
			PApply[index][a_user_id] =
			PApply[index][a_level] = 
			PApply[index][a_date] = 0;
 			
			clean:<PApply[index][a_name]>;
			
			DeletePVar( playerid, "Fraction:SelectApply" );
		}
		
		case d_police + 9:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0:
				{
					new
						amount;
						
					for( new i; i < MAX_ARREST; i++ )
					{
						if( VArrest[i][arrest_id] )
							amount++;
					}
					
					format:g_string( "\
						"cBLUE"������������ Police Department\n\n\
						"cWHITE"�����������: %d/%d"cBLUE"\n\n\
						"cWHITE"������ �� ���������: "cBLUE"$%d\n\
						"cWHITE"��������� ������: "cBLUE"$%d\n\n\
						"cGRAY"������������ �������� ����� ���������� �� ������������ 72 ����,\n\
						����� ��������� ����� ������� ��������� �������� �� ��������.",
						amount,
						MAX_ARREST,
						PRICE_FOR_WRECER,
						PRICE_FOR_ARREST );
						
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_string, "�������", "" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_police + 10, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"������������ Police Department\n\n\
						"cWHITE"������� id ���������� (/dl):",
						"�����", "�����" );
						
					g_player_interaction{playerid} = 1;
				}
			}
		}
		
		case d_police + 10:
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				
				return showPlayerDialog( playerid, d_police + 9, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					����������\n\
					������� ���� ���������", "�����", "�������" ); 
			}
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 1 || strval( inputtext ) > MAX_VEHICLES )
			{
				return showPlayerDialog( playerid, d_police + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������������ Police Department\n\n\
					"cWHITE"������� id ���������� (/dl):\n\
					"gbDialogError"������������ ������ �����.",
					"�����", "�����" );
			}
			
			new
				index = INVALID_PARAM,
				year, month, day, hour, minute, 
				price, arresttime;
			
			for( new i; i < MAX_ARREST; i++ )
			{
				if( VArrest[i][arrest_vehid] == Vehicle[strval( inputtext )][vehicle_id] && Vehicle[strval( inputtext )][vehicle_user_id] != INVALID_PARAM )
				{
					index = i;
					break;
				}
			}
			
			if( index == INVALID_PARAM )
			{
				return showPlayerDialog( playerid, d_police + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������������ Police Department\n\n\
					"cWHITE"������� id ���������� (/dl):\n\
					"gbDialogError"�� ������������ ��� ������ ����������.",
					"�����", "�����" );
			}
			
			if( Player[playerid][uID] != Vehicle[strval( inputtext )][vehicle_user_id] )
			{
				return showPlayerDialog( playerid, d_police + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������������ Police Department\n\n\
					"cWHITE"������� id ���������� (/dl):\n\
					"gbDialogError"���� ��������� �� ����������� ���.",
					"�����", "�����" );
			}
			
			
			arresttime = VArrest[index][arrest_date] - 7 * 86400;
			gmtime( arresttime, year, month, day, hour, minute );
			price = floatround( ( gettime() - arresttime ) / 3600 ) * PRICE_FOR_ARREST;
			
			format:g_string( "\
				"cBLUE"������������ Police Department\n\n\
				"cWHITE"����������: "cBLUE"%s %s\n\
				"cWHITE"�����������: %02d.%02d.%d %02d:%02d - "cBLUE"%s\n\n\
				"cWHITE"������ ����������: "cBLUE"$%d\n\
				"cWHITE"������ ������������: "cBLUE"$%d\n\n\
				"cWHITE"������� �������� ����� � ������� ���� ����������?",
				VehicleInfo[GetVehicleModel( strval( inputtext ) ) - 400][v_type],
				GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ),
				day, month, year, hour, minute, VArrest[index][arrest_name],
				PRICE_FOR_WRECER, 
				price );
				
			showPlayerDialog( playerid, d_police + 11, DIALOG_STYLE_MSGBOX, " ", g_string, "��", "���" );
			
			SetPVarInt( playerid, "Arrest:Index", index );
			SetPVarInt( playerid, "Arrest:Price", price + PRICE_FOR_WRECER );
			SetPVarInt( playerid, "Arrest:Vehid", strval( inputtext ) );
		}
		
		case d_police + 11:
		{
			if( !response )
			{
				DeletePVar( playerid, "Arrest:Index" );
				DeletePVar( playerid, "Arrest:Price" );
				DeletePVar( playerid, "Arrest:Vehid" );
			
				return showPlayerDialog( playerid, d_police + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"������������ Police Department\n\n\
					"cWHITE"������� id ���������� (/dl):",
					"�����", "�����" );
			}
			
			new
				index = GetPVarInt( playerid, "Arrest:Index" ),
				price = GetPVarInt( playerid, "Arrest:Price" ),
				vehicleid = GetPVarInt( playerid, "Arrest:Vehid" ),
				pos = random( 3 );
				
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				
				DeletePVar( playerid, "Arrest:Index" );
				DeletePVar( playerid, "Arrest:Price" );
				DeletePVar( playerid, "Arrest:Vehid" );
				g_player_interaction{playerid} = 0;
				
				return showPlayerDialog( playerid, d_police + 9, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					����������\n\
					������� ���� ���������", "�����", "�������" ); 
			}
			
			SetPlayerCash( playerid, "-", price );
			
			mysql_format:g_small_string( "DELETE FROM `"DB_VEHICLES_ARREST"` WHERE `arrest_id` = %d LIMIT 1", VArrest[index][arrest_id] );
			mysql_tquery( mysql, g_small_string );
			
			VArrest[index][arrest_id] =
			VArrest[index][arrest_vehid] =
			VArrest[index][arrest_pos] =
			VArrest[index][arrest_date] = 0;
			
			clean:<VArrest[index][arrest_name]>;
			
			Vehicle[vehicleid][vehicle_pos][0] = vehicle_unarrest_pos[pos][0];
			Vehicle[vehicleid][vehicle_pos][1] = vehicle_unarrest_pos[pos][1];
			Vehicle[vehicleid][vehicle_pos][2] = vehicle_unarrest_pos[pos][2];
			Vehicle[vehicleid][vehicle_pos][3] = vehicle_unarrest_pos[pos][3];
			
			Vehicle[vehicleid][vehicle_arrest] = 
			Vehicle[vehicleid][vehicle_int] =
			Vehicle[vehicleid][vehicle_world] = 0;
			
			/*SetVehicleVirtualWorld( vehicleid, 0 );
			
			SetVehicleZAngle( vehicleid, Vehicle[vehicleid][vehicle_pos][3] );
			setVehiclePos( vehicleid, 
				Vehicle[vehicleid][vehicle_pos][0],
				Vehicle[vehicleid][vehicle_pos][1],
				Vehicle[vehicleid][vehicle_pos][2]
			);*/
			
			mysql_format:g_string( "UPDATE `"DB_VEHICLES"` SET \
				`vehicle_pos` = '%f|%f|%f|%f', \
				`vehicle_world` = 0, \
				`vehicle_arrest` = 0 WHERE `vehicle_id` = %d LIMIT 1", 
				Vehicle[vehicleid][vehicle_pos][0],
				Vehicle[vehicleid][vehicle_pos][1],
				Vehicle[vehicleid][vehicle_pos][2],
				Vehicle[vehicleid][vehicle_pos][3],
				Vehicle[vehicleid][vehicle_id]
			);
			mysql_tquery( mysql, g_string );
			
			SetVehicleToRespawnEx( vehicleid, playerid );
			
			pformat:( ""gbSuccess"�� ��������� "cBLUE"$%d"cWHITE". ��� "cBLUE"%s"cWHITE" ��������� ��������� � ����� ������������.", price, GetVehicleModelName( Vehicle[vehicleid][vehicle_model] ) );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Arrest:Index" );
			DeletePVar( playerid, "Arrest:Price" );
			DeletePVar( playerid, "Arrest:Vehid" );
			g_player_interaction{playerid} = 0;
		}
		//�������� ���������
		case d_police + 12:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				//���������� � ��������
				case 0:
				{
					showPlayerDialog( playerid, d_police + 13, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� � ��������\n\n\
						"cWHITE"������� ��� � ������� ��������:\n\
						"gbDialog"������ �����: Vasya_Pupkin", "�����", "�����" );
				}
				//���������� � ����������
				case 1:
				{
					showPlayerDialog( playerid, d_police + 15, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� � ����������\n\n\
						"cWHITE"������� ���. �����:", "�����", "�����" );
				}
				//���������� � ��������
				case 2:
				{
					showPlayerDialog( playerid, d_police + 17, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� � ��������\n\n\
						"cWHITE"������� ����� ��������:", "�����", "�����" );
				}
				//���������� � ����
				case 3:
				{
					showPlayerDialog( playerid, d_police + 25, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"���������� � ����\n\n\
						"cWHITE"������� ����� ����:", "�����", "�����" );
				}
				//������ ������������� ����
				case 4:
				{
					new
						amount,
						year, month, day;
						
					clean:<g_big_string>;
					strcat( g_big_string, ""cWHITE"������ ������������� �����������\n" );
				
					for( new i; i < MAX_SUSPECT; i++ )
					{
						if( SuspectVehicle[i][s_id] )
						{
							gmtime( SuspectVehicle[i][s_date], year, month, day );
							format:g_string( "\n"cBLUE"%d. "cWHITE"���. ����� %s\t%02d.%02d.%d\t������ "cBLUE"%s"cWHITE": %s",
								amount + 1, SuspectVehicle[i][s_name], day, month, year, SuspectVehicle[i][s_officer_name], SuspectVehicle[i][s_descript] );
								
							strcat( g_big_string, g_string );
							amount++;
						}
					}
					
					if( !amount ) strcat( g_big_string, "\n� ������� ��� ����������" );
					
					showPlayerDialog( playerid, d_police + 14, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
				}
				//����������� ������
				case 5:
				{
					new
						amount,
						year, month, day;
						
					clean:<g_big_string>;
					strcat( g_big_string, ""cWHITE"����������� ������\n" );
				
					for( new i; i < MAX_SUSPECT; i++ )
					{
						if( SuspectPlayer[i][s_id] )
						{
							gmtime( SuspectPlayer[i][s_date], year, month, day );
							format:g_string( "\n"cBLUE"%d. "cWHITE"���������� "cBLUE"%s"cWHITE"\t%02d.%02d.%d\t������ "cBLUE"%s"cWHITE": "cGRAY"%s",
								amount + 1, SuspectPlayer[i][s_name], day, month, year, SuspectPlayer[i][s_officer_name], SuspectPlayer[i][s_descript] );
								
							strcat( g_big_string, g_string );
							amount++;
						}
					}
					
					if( !amount ) strcat( g_big_string, "\n� ������� ��� ������������" );
					
					showPlayerDialog( playerid, d_police + 14, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
				}
				//�������������� �� ������ ��������
				case 6:
				{
					showPlayerDialog( playerid, d_police + 20, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"�������������� �� ������ ��������\n\n\
						"cWHITE"������� ����� ��������:", "�����", "�����" );
				}
			}
		}
		
		case d_police + 13:
		{
			if( !response ) return showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "�������� ���������", dialog_computer, "�������", "�������" );
		
			if( strlen( inputtext ) > MAX_PLAYER_NAME || inputtext[0] == EOS )
			{
				return showPlayerDialog( playerid, d_police + 13, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� � ��������\n\n\
					"cWHITE"������� ��� � ������� ��������:\n\
					"gbDialog"������ �����: Vasya_Pupkin\n\n\
					"gbDialogError"������, ��������� ����.", "�����", "�����" );
			}
			
			new
				index		= INVALID_PARAM;
			
			foreach(new i: Player)
			{
				if( !IsLogged( i ) ) continue;
			
				if( !strcmp( Player[i][uName], inputtext, true ) )
				{
					index = i;
					break;
				}
			}
			
			if( index == INVALID_PARAM )
			{
				return showPlayerDialog( playerid, d_police + 13, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� � ��������\n\n\
					"cWHITE"������� ��� � ������� ��������:\n\
					"gbDialog"������ �����: Vasya_Pupkin\n\n\
					"gbDialogError"������� � ����� ������ �� ������.", "�����", "�����" );
			}
			
			ShowPlayerInformation( playerid, index, d_police + 14 );
		}
		
		case d_police + 14:
		{
			showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "�������� ���������", dialog_computer, "�������", "�������" );
		}
		
		case d_police + 15:
		{
			if( !response ) return showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "�������� ���������", dialog_computer, "�������", "�������" );
		
			if( strlen( inputtext ) > 7 || inputtext[0] == EOS )
			{
				return showPlayerDialog( playerid, d_police + 15, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� � ����������\n\n\
					"cWHITE"������� ���. �����:\n\
					"gbDialogError"������, ��������� ����.", "�����", "�����" );
			}
		
			new
				index		= INVALID_PARAM;
			
			for( new i; i < MAX_VEHICLES; i++ )
			{
				if( !Vehicle[i][vehicle_id] ) continue;
			
				if( !strcmp( Vehicle[i][vehicle_number], inputtext, true ) )
				{
					index = i;
					break;
				}
			}
			
			if( index == INVALID_PARAM )
			{
				return showPlayerDialog( playerid, d_police + 15, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� � ����������\n\n\
					"cWHITE"������� ���. �����:\n\
					"gbDialogError"��������� � ����� ������� �� ������.", "�����", "�����" );
			}
			
			ShowVehiclePInformation( playerid, index, d_police + 14 );
		}
		
		case d_police + 17:
		{
			if( !response ) return showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "�������� ���������", dialog_computer, "�������", "�������" );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_police + 17, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� � ��������\n\n\
					"cWHITE"������� ����� ��������:\n\
					"gbDialogError"������, ��������� ����.", "�����", "�����" );
			}
			
			DLicense[ l_id ] = 
			DLicense[ l_type ] =
			DLicense[ l_gave_date ] =
			DLicense[ l_take_date ] = 0;
			
			DLicense[ l_name ][0] = 
			DLicense[ l_taked_by ][0] = 
			DLicense[ l_gun_name ][0] = EOS;
			
			mysql_format:g_small_string( "SELECT * FROM "DB_LICENSES" WHERE `license_id` = %d", strval( inputtext ) );
			mysql_tquery( mysql, g_small_string, "DownloadLicense" );
			
			format:g_small_string( "\
				"cWHITE"����� � ���� ������ �������� "cBLUE"#%d"cWHITE" ?", strval( inputtext ) );
			showPlayerDialog( playerid, d_police + 18, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
		}
		
		case d_police + 18:
		{
			if( !response ) 
			{
				DLicense[ l_id ] = 
				DLicense[ l_type ] =
				DLicense[ l_gave_date ] =
				DLicense[ l_take_date ] = 0;
				
				DLicense[ l_name ][0] = 
				DLicense[ l_taked_by ][0] = 
				DLicense[ l_gun_name ][0] = EOS;
			
				return showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "�������� ���������", dialog_computer, "�������", "�������" );
			}
		
			if( !DLicense[l_id] )
			{
				return showPlayerDialog( playerid, d_police + 17, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� � ��������\n\n\
					"cWHITE"������� ����� ��������:\n\
					"gbDialogError"�������� �� ������� � ���� ������.", "�����", "�����" );
			}
			
			new
				year, month, day;
			
			clean:<g_big_string>;
			
			format:g_small_string( ""cWHITE"���������� � �������� "cBLUE"#%d\n\n", DLicense[l_id] );
			strcat( g_big_string, g_small_string );
			
			strcat( g_big_string, ""cWHITE"���: " );
			
			switch( DLicense[l_type] )
			{
				case 1: format:g_small_string( "������������ �������������" );
				case 2: format:g_small_string( "�������� ������" );
				case 3: format:g_small_string( "������������� ������������" );
				case 4: format:g_small_string( "���������� �� ������� ������ 1 ������" );
				case 5: format:g_small_string( "���������� �� ������� ������ 2 ������" );
				case 6: format:g_small_string( "���������� �� ������� ������ 3 ������" );
			}
			
			strcat( g_big_string, g_small_string );
			
			if( DLicense[l_gun_name][0] != EOS )
			{
				format:g_small_string( ""cWHITE"\n������ ������: "cBLUE"%s", DLicense[l_gun_name] );
				strcat( g_big_string, g_small_string );
			}
			
			format:g_small_string( ""cWHITE"\n���������: "cBLUE"%s\n", DLicense[l_name] );
			strcat( g_big_string, g_small_string );
			
			gmtime( DLicense[l_gave_date], year, month, day );
			
			format:g_small_string( ""cWHITE"���� ������������: %02d.%02d.%d", day, month, year );
			strcat( g_big_string, g_small_string );
			
			if( DLicense[l_take_date] )
			{
				format:g_small_string( "\n\n"cWHITE"������: %02d.%02d.%d", day, month, year );
				strcat( g_big_string, g_small_string );
				
				format:g_small_string( "\n"cWHITE"���: %s", DLicense[l_taked_by] );
				strcat( g_big_string, g_small_string );
			}
			
			showPlayerDialog( playerid, d_police + 19, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
		}
		
		case d_police + 19:
		{
			DLicense[ l_id ] = 
			DLicense[ l_type ] =
			DLicense[ l_gave_date ] =
			DLicense[ l_take_date ] = 0;
				
			DLicense[ l_name ][0] = 
			DLicense[ l_taked_by ][0] = 
			DLicense[ l_gun_name ][0] = EOS;
		
			showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "�������� ���������", dialog_computer, "�������", "�������" );
		}
		
		case d_police + 20:
		{
			if( !response ) return showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "�������� ���������", dialog_computer, "�������", "�������" );
		
			if( inputtext[0] == EOS || strval( inputtext ) < 1 || !IsNumeric( inputtext ) || strlen( inputtext ) > 6 || strval( inputtext ) == GetPhoneNumber( playerid ) )
			{
				return showPlayerDialog( playerid, d_police + 20, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"�������������� �� ������ ��������\n\n\
					"cWHITE"������� ����� ��������:\n\
					"gbDialogError"������, ��������� ����.", "�����", "�����" );
			}
		
			new
				number = strval( inputtext ),
				index = INVALID_PARAM;
		
			foreach(new i : Player)
			{
				if( !IsLogged( i ) ) continue;
				
				if( GetPhoneNumber( i ) != number ) continue;
				
				if( !IsPlayerInNetwork( i ) )
				{
					return showPlayerDialog( playerid, d_police + 20, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"�������������� �� ������ ��������\n\n\
						"cWHITE"������� ����� ��������:\n\
						"gbDialogError"������� ��������� ��� ���� �������� ����.", "�����", "�����" );
				}
				else
				{
					index = i;
					break;
				}
			}
			
			if( index == INVALID_PARAM )
			{
				return showPlayerDialog( playerid, d_police + 20, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"�������������� �� ������ ��������\n\n\
					"cWHITE"������� ����� ��������:\n\
					"gbDialogError"������ ����� �� ��������������� � ���� SA:Telecom.", "�����", "�����" );
			}
			
			g_player_gps{playerid} = 1;
			SetPVarInt( playerid, "Police:GPSuse", 1 );
			SetPVarInt( playerid, "Police:GPSplayer", index );
			
			SetPoliceCheckpoint( playerid, index );
			
			pformat:( ""gbSuccess"������� � ������� "cBLUE"%d"cWHITE" ������, �������������� �������� �� GPS. ����������� "cBLUE"/gps"cWHITE", ����� ���������� ������������.", number );
			psend:( playerid, C_WHITE );
		}
		
		case d_police + 21:
		{
			if( !response )
			{
				DeletePVar( playerid, "Police:Takeid" );
				return 1;
			}
			
			new
				takeid = GetPVarInt( playerid, "Police:Takeid" ),
				licid = g_dialog_select[playerid][listitem];
			
			if( License[takeid][licid][lic_take_date] )
			{
				DeletePVar( playerid, "Police:Takeid" );
				return SendClient:( playerid, C_WHITE, !""gbError"������ �������� ��� ������." );
			}
			
			SetPVarInt( playerid, "Police:Licid", licid );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			format:g_string( "\
				"cBLUE"������� ��������\n\n\
				"cWHITE"�� ������������� ������� ������ "cBLUE"%s"cWHITE" � "cBLUE"%s"cWHITE"?",
				getLicenseName[ License[takeid][licid][lic_type] - 1 ],
				Player[ takeid ][uRPName] );
				
			showPlayerDialog( playerid, d_police + 22, DIALOG_STYLE_MSGBOX, " ", g_string, "��", "���" );
		}
		
		case d_police + 22:
		{
			if( !response )
			{
				DeletePVar( playerid, "Police:Takeid" );
				return 1;
			}
			
			new
				takeid = GetPVarInt( playerid, "Police:Takeid" ),
				licid = GetPVarInt( playerid, "Police:Licid" );
				
			if( GetDistanceBetweenPlayers( playerid, takeid ) > 3.0 ) 
			{
				DeletePVar( playerid, "Police:Takeid" );
				DeletePVar( playerid, "Police:Licid" );
			
				return SendClient:( playerid, C_WHITE, !""gbError"������� ������ ��� ����� � ����." );
			}
			
			License[takeid][licid][lic_take_date] = gettime();
			License[takeid][licid][lic_taked_by][0] = EOS;
			strcat( License[takeid][licid][lic_taked_by], Player[playerid][uName], MAX_PLAYER_NAME );
			
			GivePlayerLicense( takeid, LIC_UPDATE, licid );
			
			pformat:( ""gbDefault"%s ����� � ��� "cBLUE"%s"cWHITE".", Player[playerid][uRPName], getLicenseName[ License[takeid][licid][lic_type] - 1 ] );
			psend:( takeid, C_WHITE );
			
			pformat:( ""gbDefault"�� ������ "cBLUE"%s"cWHITE" � %s.", getLicenseName[ License[takeid][licid][lic_type] - 1 ], Player[takeid][uRPName] );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Police:Takeid" );
			DeletePVar( playerid, "Police:Licid" );
		}
		
		case d_police + 23:
		{
			showPlayerDialog( playerid, d_police, DIALOG_STYLE_LIST, "���� ����������", info_dialog, "�������", "�������" );
		}
		
		case d_police + 24:
		{
			showPlayerDialog( playerid, d_police + 3, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				�������� ��������\n\
				���������� � ���������", "�������", "�����" );
		}
		
		case d_police + 25:
		{
			if( !response )
				return showPlayerDialog( playerid, d_police + 12, DIALOG_STYLE_LIST, "�������� ���������", dialog_computer, "�������", "�������" );
				
			if( inputtext[0] == EOS || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_police + 25, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� � ����\n\n\
					"cWHITE"������� ����� ����:\n\
					"gbDialogError"������������ ������ �����.", "�����", "�����" );
			}

			clean:<g_string>;
			
			strcat( g_string, ""cBLUE"�����\t"cBLUE"��������\t"cBLUE"�����" );
			new
				zone[28];
			
			for( new h; h < MAX_HOUSE; h++ )
			{
				if( !HouseInfo[h][hID] ) continue;
			
				if( strval( inputtext ) == HouseInfo[h][hID] )
				{
					GetPos2DZone( HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], zone, 28 );
					SetPVarInt( playerid, "MDC:House", h );
					
					if( HouseInfo[h][huID] == INVALID_PARAM )
					{
						format:g_small_string( "\n"cWHITE"#%d\t����������\t%s", HouseInfo[h][hID], zone );
						strcat( g_string, g_small_string );
					}
					else
					{
						format:g_small_string( "\n"cWHITE"#%d\t%s\t%s", HouseInfo[h][hID], HouseInfo[h][hOwner], zone );
						strcat( g_string, g_small_string );
					}
					
					return showPlayerDialog( playerid, d_police + 26, DIALOG_STYLE_TABLIST_HEADERS, "���������� � ����", g_string, "�����", "�����" );
				}
			}
			
			showPlayerDialog( playerid, d_police + 25, DIALOG_STYLE_INPUT, " ", "\
				"cBLUE"���������� � ����\n\n\
				"cWHITE"������� ����� ����:\n\
				"gbDialogError"��� � ����� ������� �� ������.", "�����", "�����" );
		}
		
		case d_police + 26:
		{
			if( !response )
			{
				DeletePVar( playerid, "MDC:House" );
				return showPlayerDialog( playerid, d_police + 25, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"���������� � ����\n\n\
					"cWHITE"������� ����� ����:", "�����", "�����" );
			}
			
			new
				h = GetPVarInt( playerid, "MDC:House" );
			
			g_player_gps{playerid} = 1;
			SetPlayerCheckpoint( playerid, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2], 3.0 );
			
			DeletePVar( playerid, "MDC:House" );
			SendClient:( playerid, C_WHITE, ""gbDefault"�� ���������� ����� �� GPS-����������. ��� ������ ����������� - "cBLUE"/gps"cWHITE"");
		}
		
		case d_police + 27:
		{
			if( !response )
			{
				DeletePVar( playerid, "Suspect:Index" );
				return 1;
			}
		
			new
				index = GetPVarInt( playerid, "Suspect:Index" );
				
			if( inputtext[0] == EOS || strlen( inputtext ) > 32 )
			{
				format:g_small_string( "\
					"cWHITE"�������� � ����������� ������ "cBLUE"%s\n\n\
					"cWHITE"������� �������:\n\
					"gbDialogError"������������ ������ �����.", SuspectPlayer[index][s_time_name] );
					
				return showPlayerDialog( playerid, d_police + 27, DIALOG_STYLE_INPUT, " ", g_small_string, "��������", "�������" );
			}
		
			SuspectPlayer[index][s_date] = gettime();
				
			clean:<SuspectPlayer[index][s_name]>;
			clean:<SuspectPlayer[index][s_officer_name]>;
			clean:<SuspectPlayer[index][s_descript]>;
				
			strcat( SuspectPlayer[index][s_name], SuspectPlayer[index][s_time_name], 24 );
			strcat( SuspectPlayer[index][s_officer_name], Player[ playerid ][uName], MAX_PLAYER_NAME );
			strcat( SuspectPlayer[index][s_descript], inputtext, 32 );
						
			mysql_format:g_string( "INSERT INTO `"DB_SUSPECT"` \
				( `s_name`, `s_officer_name`, `s_date`, `s_descript` ) VALUES \
				( '%s', '%s', '%d', '%e' )",
				SuspectPlayer[index][s_name],
				SuspectPlayer[index][s_officer_name],
				SuspectPlayer[index][s_date],
				SuspectPlayer[index][s_descript] );
			mysql_tquery( mysql, g_string, "InsertSuspectPlayer", "d", index );
			
			pformat:( ""gbSuccess"�� �������� � ����������� ������ "cBLUE"%s"cWHITE" � �������� "cBLUE"%s"cWHITE".", 
				SuspectPlayer[index][s_name],
				SuspectPlayer[index][s_descript] );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Suspect:Index" );
		}
		
		case d_police + 28:
		{
			if( !response )
			{
				clean:<SuspectVehicle[GetPVarInt( playerid, "CarSuspect:Index" )][s_name]>;
				DeletePVar( playerid, "CarSuspect:Index" );
				return 1;
			}
			
			new
				index = GetPVarInt( playerid, "CarSuspect:Index" );
				
			if( inputtext[0] == EOS || strlen( inputtext ) > 32 )
			{
				format:g_small_string( "\
					"cWHITE"�������� � ����������� ������ ��������� ���. ����� "cBLUE"%s\n\n\
					"cWHITE"������� �������:\n\n\
					"gbDialogError"������������ ������ �����.", SuspectVehicle[index][s_name] );
					
				return showPlayerDialog( playerid, d_police + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "��������", "�������" );
			}
			
			clean:<SuspectVehicle[index][s_officer_name]>;
			clean:<SuspectVehicle[index][s_descript]>;
			
			SuspectVehicle[index][s_date] = gettime();
			strcat( SuspectVehicle[index][s_officer_name], Player[ playerid ][uName], MAX_PLAYER_NAME );
			strcat( SuspectVehicle[index][s_descript], inputtext, 32 );
				
			mysql_format:g_string( "INSERT INTO `"DB_SUSPECT_VEHICLE"` \
				( `s_name`, `s_officer_name`, `s_date`, `s_descript` ) VALUES \
				( '%s', '%s', '%d', '%e' )",
				SuspectVehicle[index][s_name],
				SuspectVehicle[index][s_officer_name],
				SuspectVehicle[index][s_date],
				SuspectVehicle[index][s_descript] );
			mysql_tquery( mysql, g_string, "InsertSuspectVehicle", "d", index );
			
			pformat:( ""gbSuccess"�� �������� � ������ ���������� � ���. ������� "cBLUE"%s"cWHITE" � �������� "cBLUE"%s"cWHITE".", 
				SuspectVehicle[index][s_name], SuspectVehicle[index][s_descript] );
			psend:( playerid, C_WHITE );
		}
	}
	
	return 1;
}