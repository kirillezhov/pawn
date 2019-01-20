function showDonatPanel( playerid )
{
	Player[playerid][uGMoney] = cache_get_field_content_int( 0, "uGMoney", mysql );
	showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );

	return 1;
}

function Donate_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_donate:
		{
			if( !response )
				return 1;
				
			switch( listitem )
			{
				case 0: //����������
				{
					showPlayerDialog( playerid, d_donate + 1, DIALOG_STYLE_LIST, "����������", donatinfo, "�������", "�����" );
				}
				
				case 1: //����� ������
				{
					format:g_small_string( donatmoney, Player[playerid][uGMoney] );
					showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
				}
				
				case 2: //������� ��������
				{
					showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
				}
				
				case 3: //�������������� �����������
				{
					ShowDonatAdd( playerid );
				}
			}
		}
		
		case d_donate + 1:
		{
			if( !response )
				return showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
				
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_donate + 25, DIALOG_STYLE_MSGBOX, " ", donattotal, "�����", "" );
				}
				
				case 1:
				{
					format:g_string( donatbalance, Player[playerid][uGMoney] );
					showPlayerDialog( playerid, d_donate + 25, DIALOG_STYLE_MSGBOX, " ", g_string, "�����", "" );
				}
				
				case 2:
				{
					if( !Premium[playerid][prem_id] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ������� ��������." );
						return showPlayerDialog( playerid, d_donate + 1, DIALOG_STYLE_LIST, "����������", donatinfo, "�������", "�����" );
					}
					
					ShowMyPremiumInfo( playerid );
				}
			}
		}
		
		case d_donate + 2:
		{
			if( !response )
				return showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
				
			if( listitem == 4 ) //���������
			{
				if( !Premium[playerid][prem_id] )
				{
					SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ������� ��������." );
					return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
				}
				
				if( Premium[playerid][prem_type] == 4 )
				{
					SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ �������� ������� ������� '�������������'." );
					return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
				}
				
				new
					days,
					Float:interval;
					
				interval = float( Premium[playerid][prem_time] - gettime() ) / 86400.0;
				days = floatround( interval, floatround_floor );
				
				if( days > 7 )
				{
					SendClient:( playerid, C_WHITE, !""gbError"�� ������ �������� ������� ������� �� 7 ���� �� ��������� ����� ��������." );
					return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
				}
				
				if( Player[playerid][uGMoney] < premium_info[ Premium[playerid][prem_type] ][prem_price] || !Player[playerid][uGMoney] )
				{
					SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
				}
				
				Premium[playerid][prem_time] = Premium[playerid][prem_time] + 30 * 86400;
				Player[playerid][uGMoney] -= premium_info[ Premium[playerid][prem_type] ][prem_price];
				UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
				
				mysql_format:g_small_string( "UPDATE `"DB_PREMIUM"` SET `prem_time` = %d WHERE `prem_id` = %d LIMIT 1", 
					Premium[playerid][prem_time], Premium[playerid][prem_id] );
				mysql_tquery( mysql, g_small_string );
				
				pformat:( ""gbSuccess"�� ������� �������� ������� ������� %s%s"cWHITE" (%d RCoin) �� "cBLUE"30"cWHITE" ����.", GetPremiumColor( Premium[playerid][prem_color] ), 
					GetPremiumName( Premium[playerid][prem_type] ), premium_info[ Premium[playerid][prem_type] ][prem_price] );
				psend:( playerid, C_WHITE );
				
				showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
			}
			else if( listitem == 3 ) //�������������
			{
				TimePremium[playerid][prem_id] =
				TimePremium[playerid][prem_time] = 
				TimePremium[playerid][prem_type] = 
				TimePremium[playerid][prem_color] = 
				TimePremium[playerid][prem_gmoney] = 
				TimePremium[playerid][prem_bank] = 
				TimePremium[playerid][prem_salary] = 
				TimePremium[playerid][prem_benefit] = 
				TimePremium[playerid][prem_mass] = 
				TimePremium[playerid][prem_admins] = 
				TimePremium[playerid][prem_supports] = 
				TimePremium[playerid][prem_h_payment] = 
				TimePremium[playerid][prem_house] = 
				TimePremium[playerid][prem_car] = 
				TimePremium[playerid][prem_business] = 
				TimePremium[playerid][prem_house_property] = 
				TimePremium[playerid][prem_drop_retreature] = 
				TimePremium[playerid][prem_drop_tuning] = 
				TimePremium[playerid][prem_drop_repair] = 
				TimePremium[playerid][prem_drop_payment] = 0;
				
				ValuePremium[playerid][value_amount] =
				ValuePremium[playerid][value_gmoney] = 0;
				ValuePremium[playerid][value_days] = 30;
			
				SetPVarInt( playerid, "Premium:Type", listitem + 1 );
				ShowPremiumSettings( playerid );
			}
			else
			{
				SetPVarInt( playerid, "Premium:Type", listitem + 1 );
				ShowPremiumInfo( playerid, listitem + 1 );
			}
		}
		
		case d_donate + 3: //������� ����������, �����������, ������������ 
		{
			if( !response )
			{
				DeletePVar( playerid, "Premium:Type" );
				return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
			}
			
			new
				type = GetPVarInt( playerid, "Premium:Type" );
				
			if( Premium[playerid][prem_id] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ���� ������� �������." );
				
				DeletePVar( playerid, "Premium:Type" );
				return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
			}
				
			if( Player[playerid][uGMoney] < premium_info[type][prem_price] )
			{
				SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
				
				DeletePVar( playerid, "Premium:Type" );
				return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
			}
			
			Player[playerid][uGMoney] -= premium_info[type][prem_price];
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
				
			Premium[playerid][prem_time] 		= gettime() + 30 * 86400;
			Premium[playerid][prem_type] 		= type;
			Premium[playerid][prem_color] 		= premium_info[type][prem_color][0];
			Premium[playerid][prem_gmoney]	 	= premium_info[type][prem_gmoney][0];
			Premium[playerid][prem_bank] 		= premium_info[type][prem_bank][0];
			Premium[playerid][prem_salary]		= premium_info[type][prem_salary][0];
			Premium[playerid][prem_benefit]	 	= premium_info[type][prem_benefit][0];
			Premium[playerid][prem_mass]	 	= premium_info[type][prem_mass][0];
			Premium[playerid][prem_admins]		= premium_info[type][prem_admins][0];
			Premium[playerid][prem_supports] 	= premium_info[type][prem_supports][0];
			Premium[playerid][prem_h_payment]	= premium_info[type][prem_h_payment][0];
			Premium[playerid][prem_car]			= premium_info[type][prem_car][0];
			Premium[playerid][prem_house]		= premium_info[type][prem_house][0];
			Premium[playerid][prem_business]	= premium_info[type][prem_business][0];
			Premium[playerid][prem_house_property]	= premium_info[type][prem_house_property][0];
			Premium[playerid][prem_drop_retreature]	= premium_info[type][prem_drop_retreature][0];
			Premium[playerid][prem_drop_tuning]		= premium_info[type][prem_drop_tuning][0];
			Premium[playerid][prem_drop_repair]		= premium_info[type][prem_drop_repair][0];
			Premium[playerid][prem_drop_payment]	= premium_info[type][prem_drop_payment][0];
			
			mysql_format:g_string( "\
				INSERT INTO `"DB_PREMIUM"`\
					( `prem_user_id`, `prem_type`, `prem_time`, `prem_color`, `prem_gmoney`, `prem_bank`, `prem_salary`,\
					`prem_benefit`, `prem_mass`, `prem_admins`, `prem_supports`, `prem_h_payment`, `prem_house`,\
					`prem_car`, `prem_business`, `prem_house_property`, `prem_drop_retreature`, `prem_drop_tuning`,\
					`prem_drop_repair`, `prem_drop_payment`\
					) \
				VALUES \
					( %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d )",
				Player[playerid][uID], 
				Premium[playerid][prem_type], 
				Premium[playerid][prem_time],
				Premium[playerid][prem_color],
				Premium[playerid][prem_gmoney],
				Premium[playerid][prem_bank],
				Premium[playerid][prem_salary],
				Premium[playerid][prem_benefit],
				Premium[playerid][prem_mass],
				Premium[playerid][prem_admins],
				Premium[playerid][prem_supports],
				Premium[playerid][prem_h_payment],
				Premium[playerid][prem_house],
				Premium[playerid][prem_car],
				Premium[playerid][prem_business],
				Premium[playerid][prem_house_property],
				Premium[playerid][prem_drop_retreature],
				Premium[playerid][prem_drop_tuning],
				Premium[playerid][prem_drop_repair],
				Premium[playerid][prem_drop_payment]
			);
			
			mysql_tquery( mysql, g_string, "AddPremium", "d", playerid );
			
			pformat:( ""gbSuccess"�� ��������� ������� ������� %s%s"cWHITE" (%d RCoin), c��� �������� - "cBLUE"30"cWHITE" ����.", GetPremiumColor( Premium[playerid][prem_color] ), premium_info[type][prem_price], GetPremiumName( type ) );
			psend:( playerid, C_WHITE );
			
			log( LOG_BUY_PREMIUM, "����� ������� �������", Player[playerid][uID], type );
			
			DeletePVar( playerid, "Premium:Type" );
			showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
		}
		
		case d_donate + 4: //����� ������
		{
			if( !response )
				return showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1  )
			{
				clean:<g_string>;
			
				format:g_small_string( donatmoney, Player[playerid][uGMoney] ), strcat( g_string, g_small_string );
				strcat( g_string, "\n"gbDialogError"������������ ������ �����." );
				
				return showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_string, "�����", "�����" );
			}
			
			if( strval( inputtext ) > Player[playerid][uGMoney] )
			{
				clean:<g_string>;
			
				format:g_small_string( donatmoney, Player[playerid][uGMoney] ), strcat( g_string, g_small_string );
				strcat( g_string, "\n"gbDialogError"�� ����� ����� ������������ RCoin." );
				
				return showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_string, "�����", "�����" );
			}
			
			SetPVarInt( playerid, "Donat:Money", strval( inputtext ) );
			
			format:g_small_string( "\
				"cBLUE"����� ������"cWHITE"\n\n\
				�������������: �� ����������� "cBLUE"%d RCoin"cWHITE" �� "cBLUE"$%d"cWHITE".\n\
				����������?",
				strval( inputtext ),
				strval( inputtext ) * 100 );
			showPlayerDialog( playerid, d_donate + 5, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
		}
		
		case d_donate + 5:
		{
			if( !response )
			{
				DeletePVar( playerid, "Donat:Money" );
				
				format:g_small_string( donatmoney, Player[playerid][uGMoney] );
				return showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "�����", "�����" );
			}
			
			new
				money = GetPVarInt( playerid, "Donat:Money" );
				
			if( money > Player[playerid][uGMoney] || !Player[playerid][uGMoney] )
			{
				clean:<g_string>;
			
				format:g_small_string( donatmoney, Player[playerid][uGMoney] ), strcat( g_string, g_small_string );
				strcat( g_string, "\n"gbDialogError"�� ����� ����� ������������ RCoin." );
				
				return showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_string, "�����", "�����" );
			}
			
			Player[playerid][uGMoney] -= money;
			
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			SetPlayerCash( playerid, "+", money * 100 );
			
			DeletePVar( playerid, "Donat:Money" );
			
			pformat:( ""gbSuccess"�� �������� "cBLUE"%d"cWHITE" RCoin �� "cBLUE"$%d"cWHITE".", money, money * 100 );
			psend:( playerid, C_WHITE );
			
			log( LOG_TRANSFER_RCOIN, "������� ������", Player[playerid][uID], money, money * 100 );
			
			showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
		}
		
		case d_donate + 6: //������ � ���������� ��������
		{
			if( !response )
			{
				TimePremium[playerid][prem_id] =
				TimePremium[playerid][prem_time] = 
				TimePremium[playerid][prem_type] = 
				TimePremium[playerid][prem_color] = 
				TimePremium[playerid][prem_gmoney] = 
				TimePremium[playerid][prem_bank] = 
				TimePremium[playerid][prem_salary] = 
				TimePremium[playerid][prem_benefit] = 
				TimePremium[playerid][prem_mass] = 
				TimePremium[playerid][prem_admins] = 
				TimePremium[playerid][prem_supports] = 
				TimePremium[playerid][prem_h_payment] = 
				TimePremium[playerid][prem_house] = 
				TimePremium[playerid][prem_car] = 
				TimePremium[playerid][prem_business] = 
				TimePremium[playerid][prem_house_property] = 
				TimePremium[playerid][prem_drop_retreature] = 
				TimePremium[playerid][prem_drop_tuning] = 
				TimePremium[playerid][prem_drop_repair] = 
				TimePremium[playerid][prem_drop_payment] = 0;
				
				ValuePremium[playerid][value_amount] =
				ValuePremium[playerid][value_gmoney] = 0;
				ValuePremium[playerid][value_days] = 30;
			
				DeletePVar( playerid, "Premium:Type" );
				return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "������� ��������", donatpremium, "�������", "�����" );
			}
			
			clean:<g_string>;
			
			new
				count = 0;
			
			switch( listitem )
			{
				case 0: //����
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						format:g_small_string( "\n%s������� ����", GetPremiumColor( i ) );
						strcat( g_string, g_small_string );
					}
					
					showPlayerDialog( playerid, d_donate + 7, DIALOG_STYLE_LIST, "���� ��������", g_string, "�������", "�����" );
				}
				
				case 1: //RCoin
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_gmoney ][0] )
						{
							format:g_small_string( "\n%d RCoin", premium_info[i][ prem_gmoney ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 8, DIALOG_STYLE_LIST, "RCoin � PayDay", g_string, "�������", "�����" );
				}
				
				case 2: //����
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_bank ][0] )
						{
							format:g_small_string( "\n0.%d %%", premium_info[i][ prem_bank ][0] );
							strcat( g_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_donate + 9, DIALOG_STYLE_LIST, "���������� ����������", g_string, "�������", "�����" );
				}
				
				case 3: //��������
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_salary ][0] )
						{
							format:g_small_string( "\n%d %%", premium_info[i][ prem_salary ][0] );
							strcat( g_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_donate + 10, DIALOG_STYLE_LIST, "���������� �����", g_string, "�������", "�����" );
				}
				
				case 4: //������� �� �����������
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_benefit ][0] )
						{
							format:g_small_string( "\n%d %%", premium_info[i][ prem_benefit ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 11, DIALOG_STYLE_LIST, "������� �� �����������", g_string, "�������", "�����" );
				}
				
				case 5: //��� 
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_mass ][0] )
						{
							format:g_small_string( "\n%d ��", premium_info[i][ prem_mass ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 12, DIALOG_STYLE_LIST, "�������������� ���", g_string, "�������", "�����" );
				}
				
				case 6: //admins 
				{
					showPlayerDialog( playerid, d_donate + 13, DIALOG_STYLE_LIST, "������� /admins", "���\n��", "�������", "�����" );
				}
				
				case 7: //supports 
				{
					showPlayerDialog( playerid, d_donate + 14, DIALOG_STYLE_LIST, "������� /supports", "���\n��", "�������", "�����" );
				}
				
				case 8: //��� �� ������ ����
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_h_payment ][0] )
						{
							format:g_small_string( "\n+ %d ����", premium_info[i][ prem_h_payment ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 15, DIALOG_STYLE_LIST, "������ ����", g_string, "�������", "�����" );
				}
				
				case 9: //���������
				{
					showPlayerDialog( playerid, d_donate + 16, DIALOG_STYLE_LIST, "����������� ����� 2 ����", "���\n��", "�������", "�����" );
				}
				
				case 10: //����
				{
					showPlayerDialog( playerid, d_donate + 17, DIALOG_STYLE_LIST, "����������� ����� 2 ����", "���\n��", "�������", "�����" );
				}
				
				case 11: //�������
				{
					showPlayerDialog( playerid, d_donate + 18, DIALOG_STYLE_LIST, "����������� ����� 2 �������", "���\n��", "�������", "�����" );
				}
				
				case 12: //������� ���������
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_house_property ][0] )
						{
							format:g_small_string( "\n+ %d %%", premium_info[i][ prem_house_property ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 19, DIALOG_STYLE_LIST, "������� ��������� �����������", g_string, "�������", "�����" );
				}
				
				case 13: //���������
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_drop_retreature ][0] )
						{
							format:g_small_string( "\n- %d %%", premium_info[i][ prem_drop_retreature ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 20, DIALOG_STYLE_LIST, "��������� ���������������", g_string, "�������", "�����" );
				}
				
				case 14: //������
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_drop_tuning ][0] )
						{
							format:g_small_string( "\n- %d %%", premium_info[i][ prem_drop_tuning ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 21, DIALOG_STYLE_LIST, "��������� �������", g_string, "�������", "�����" );
				}
				
				case 15: //������
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_drop_repair ][0] )
						{
							format:g_small_string( "\n- %d %%", premium_info[i][ prem_drop_repair ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 22, DIALOG_STYLE_LIST, "��������� �������", g_string, "�������", "�����" );
				}
				
				case 16: //������������ �������
				{
					strcat( g_string, "���" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_drop_payment ][0] )
						{
							format:g_small_string( "\n- %d %%", premium_info[i][ prem_drop_payment ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 23, DIALOG_STYLE_LIST, "������ ����", g_string, "�������", "�����" );
				}
				
				case 17: //��� ������� �������� ���� �������� ��������
				{
					if( Premium[playerid][prem_id] )
					{
						ShowPremiumSettings( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ���� ������� �������." );
					}
				
					if( Player[playerid][uGMoney] < ValuePremium[playerid][value_gmoney] || !Player[playerid][uGMoney] )
					{
						ShowPremiumSettings( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( ValuePremium[playerid][value_gmoney] < premium_info[1][prem_price] || ValuePremium[playerid][value_amount] < 11 )
					{
						ShowPremiumSettings( playerid );
						
						pformat:( ""gbError"������������ �������� ("cBLUE"%d/11"cWHITE") ��� ������� ������� ��������.", ValuePremium[playerid][value_amount] );
						psend:( playerid, C_WHITE );
						return 1;
					}
				
					format:g_small_string( "\
						"cWHITE"���������� ����\t"cWHITE"���������\n\
						"cWHITE"30 ����\t"cBLUE"%d RCoin\n\
						"cWHITE"60 ����\t"cBLUE"%d RCoin "cGREEN"(������ 6 %%)\n\
						"cWHITE"90 ����\t"cBLUE"%d RCoin "cGREEN"(������ 12 %%)\n",
						ValuePremium[playerid][value_gmoney], 
						floatround( ValuePremium[playerid][value_gmoney] * 2 * 0.94 ),
						floatround( ValuePremium[playerid][value_gmoney] * 3 * 0.88 ) );
			
					showPlayerDialog( playerid, d_donate + 24, DIALOG_STYLE_TABLIST_HEADERS, "���� �������� ��������", g_small_string, "������", "�����" );
				}
				
				case 18: //������
				{
					if( Premium[playerid][prem_id] )
					{
						ShowPremiumSettings( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ���� ������� �������." );
					}
				
					if( Player[playerid][uGMoney] < ValuePremium[playerid][value_gmoney] || !Player[playerid][uGMoney] )
					{
						ShowPremiumSettings( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( ValuePremium[playerid][value_gmoney] < premium_info[1][prem_price] || ValuePremium[playerid][value_amount] < 11 )
					{
						ShowPremiumSettings( playerid );
						
						pformat:( ""gbError"������������ �������� ("cBLUE"%d/11"cWHITE") ��� ������� ������� ��������.", ValuePremium[playerid][value_amount] );
						psend:( playerid, C_WHITE );
						return 1;
					}
					
					Player[playerid][uGMoney] -= ValuePremium[playerid][value_gmoney];
					UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
						
					Premium[playerid][prem_time] 		= gettime() + ValuePremium[playerid][value_days] * 86400;
					Premium[playerid][prem_type] 		= 4;
					Premium[playerid][prem_color] 		= TimePremium[playerid][prem_color];
					Premium[playerid][prem_gmoney]	 	= TimePremium[playerid][prem_gmoney];
					Premium[playerid][prem_bank] 		= TimePremium[playerid][prem_bank];
					Premium[playerid][prem_salary]		= TimePremium[playerid][prem_salary];
					Premium[playerid][prem_benefit]	 	= TimePremium[playerid][prem_benefit];
					Premium[playerid][prem_mass]	 	= TimePremium[playerid][prem_mass];
					Premium[playerid][prem_admins]		= TimePremium[playerid][prem_admins];
					Premium[playerid][prem_supports] 	= TimePremium[playerid][prem_supports];
					Premium[playerid][prem_h_payment]	= TimePremium[playerid][prem_h_payment];
					Premium[playerid][prem_car]			= TimePremium[playerid][prem_car];
					Premium[playerid][prem_house]		= TimePremium[playerid][prem_house];
					Premium[playerid][prem_business]	= TimePremium[playerid][prem_business];
					Premium[playerid][prem_house_property]	= TimePremium[playerid][prem_house_property];
					Premium[playerid][prem_drop_retreature]	= TimePremium[playerid][prem_drop_retreature];
					Premium[playerid][prem_drop_tuning]		= TimePremium[playerid][prem_drop_tuning];
					Premium[playerid][prem_drop_repair]		= TimePremium[playerid][prem_drop_repair];
					Premium[playerid][prem_drop_payment]	= TimePremium[playerid][prem_drop_payment];
					
					mysql_format:g_string( "\
						INSERT INTO `"DB_PREMIUM"`\
							( `prem_user_id`, `prem_type`, `prem_time`, `prem_color`, `prem_gmoney`, `prem_bank`, `prem_salary`,\
							`prem_benefit`, `prem_mass`, `prem_admins`, `prem_supports`, `prem_h_payment`, `prem_house`,\
							`prem_car`, `prem_business`, `prem_house_property`, `prem_drop_retreature`, `prem_drop_tuning`,\
							`prem_drop_repair`, `prem_drop_payment`\
							) \
						VALUES \
							( %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d )",
						Player[playerid][uID], 
						Premium[playerid][prem_type], 
						Premium[playerid][prem_time],
						Premium[playerid][prem_color],
						Premium[playerid][prem_gmoney],
						Premium[playerid][prem_bank],
						Premium[playerid][prem_salary],
						Premium[playerid][prem_benefit],
						Premium[playerid][prem_mass],
						Premium[playerid][prem_admins],
						Premium[playerid][prem_supports],
						Premium[playerid][prem_h_payment],
						Premium[playerid][prem_house],
						Premium[playerid][prem_car],
						Premium[playerid][prem_business],
						Premium[playerid][prem_house_property],
						Premium[playerid][prem_drop_retreature],
						Premium[playerid][prem_drop_tuning],
						Premium[playerid][prem_drop_repair],
						Premium[playerid][prem_drop_payment]
					);
					
					mysql_tquery( mysql, g_string, "AddPremium", "d", playerid );
					
					pformat:( ""gbSuccess"�� ��������� ������� ������� %s�������������"cWHITE", c��� �������� - "cBLUE"%d"cWHITE" ����.", GetPremiumColor( Premium[playerid][prem_color] ), ValuePremium[playerid][value_days] );
					psend:( playerid, C_WHITE );
					
					log( LOG_BUY_PREMIUM, "����� ������� �������", Player[playerid][uID], 4 );
					
					TimePremium[playerid][prem_id] =
					TimePremium[playerid][prem_time] = 
					TimePremium[playerid][prem_type] = 
					TimePremium[playerid][prem_color] = 
					TimePremium[playerid][prem_gmoney] = 
					TimePremium[playerid][prem_bank] = 
					TimePremium[playerid][prem_salary] = 
					TimePremium[playerid][prem_benefit] = 
					TimePremium[playerid][prem_mass] = 
					TimePremium[playerid][prem_admins] = 
					TimePremium[playerid][prem_supports] = 
					TimePremium[playerid][prem_h_payment] = 
					TimePremium[playerid][prem_house] = 
					TimePremium[playerid][prem_car] = 
					TimePremium[playerid][prem_business] = 
					TimePremium[playerid][prem_house_property] = 
					TimePremium[playerid][prem_drop_retreature] = 
					TimePremium[playerid][prem_drop_tuning] = 
					TimePremium[playerid][prem_drop_repair] = 
					TimePremium[playerid][prem_drop_payment] = 0;
					
					ValuePremium[playerid][value_amount] =
					ValuePremium[playerid][value_gmoney] = 0;
					ValuePremium[playerid][value_days] = 30;
					
					showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
				}
			}
		}
		
		/* - - - - - - - ������������� ������� ������� - - - - - - - */
		
		case d_donate + 7: //����
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_color] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_color] == premium_info[i][ prem_color ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_color ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_color] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_color] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_color] == premium_info[i][ prem_color ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_color ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[listitem][ prem_color ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_color] = listitem;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 8: //RCoin
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_gmoney] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_gmoney] == premium_info[i][ prem_gmoney ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_gmoney ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_gmoney] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_gmoney] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_gmoney] == premium_info[i][ prem_gmoney ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_gmoney ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_gmoney ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_gmoney] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_gmoney ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}

		case d_donate + 9: //����
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_bank] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_bank] == premium_info[i][ prem_bank ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_bank ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_bank] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_bank] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_bank] == premium_info[i][ prem_bank ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_bank ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[listitem][ prem_bank ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_bank] = premium_info[listitem][ prem_bank ][0];
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 10: //���������� �����
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_salary] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_salary] == premium_info[i][ prem_salary ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_salary ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_salary] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_salary] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_salary] == premium_info[i][ prem_salary ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_salary ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[listitem][ prem_salary ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_salary] = premium_info[listitem][ prem_salary ][0];
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 11: //������� �� �����������
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_benefit] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_benefit] == premium_info[i][ prem_benefit ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_benefit ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_benefit] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_benefit] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_benefit] == premium_info[i][ prem_benefit ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_benefit ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_benefit ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_benefit] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_benefit ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 12: //���
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_mass] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_mass] == premium_info[i][ prem_mass ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_mass ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_mass] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_mass] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_mass] == premium_info[i][ prem_mass ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_mass ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_mass ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_mass] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_mass ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 13: //admins
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_admins] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_admins ][1];
				}
				
				TimePremium[playerid][prem_admins] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_admins] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[ 3 ][ prem_admins ][1];
				}
				
				TimePremium[playerid][prem_admins] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 14: //supports
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_supports] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_supports ][1];
				}
				
				TimePremium[playerid][prem_supports] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_supports] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[3][ prem_supports ][1];
				}
				
				TimePremium[playerid][prem_supports] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 15: //��� ��� ������ ����
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_h_payment] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_h_payment] == premium_info[i][ prem_h_payment ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_h_payment ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_h_payment] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_h_payment] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_h_payment] == premium_info[i][ prem_h_payment ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_h_payment ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_h_payment ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_h_payment] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_h_payment ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 16: //���������
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_car] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_car ][1];
				}
				
				TimePremium[playerid][prem_car] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_car] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[3][ prem_car ][1];
				}
				
				TimePremium[playerid][prem_car] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 17: //����
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_house] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_house ][1];
				}
				
				TimePremium[playerid][prem_house] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_house] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[3][ prem_house ][1];
				}
				
				TimePremium[playerid][prem_house] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 18: //�������
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_business] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_business ][1];
				}
				
				TimePremium[playerid][prem_business] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_business] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[3][ prem_business ][1];
				}
				
				TimePremium[playerid][prem_business] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 19: //������� ���������
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_house_property] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_house_property] == premium_info[i][ prem_house_property ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_house_property ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_house_property] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_house_property] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_house_property] == premium_info[i][ prem_house_property ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_house_property ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_house_property ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_house_property] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_house_property ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 20: //���������
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_drop_retreature] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_drop_retreature] == premium_info[i][ prem_drop_retreature ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_retreature ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_drop_retreature] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_drop_retreature] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_drop_retreature] == premium_info[i][ prem_drop_retreature ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_retreature ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_retreature ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_drop_retreature] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_retreature ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 21: //������
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_drop_tuning] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_drop_tuning] == premium_info[i][ prem_drop_tuning ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_tuning ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_drop_tuning] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_drop_tuning] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_drop_tuning] == premium_info[i][ prem_drop_tuning ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_tuning ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_tuning ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_drop_tuning] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_tuning ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 22: //������
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_drop_repair] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_drop_repair] == premium_info[i][ prem_drop_repair ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_repair ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_drop_repair] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_drop_repair] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_drop_repair] == premium_info[i][ prem_drop_repair ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_repair ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_repair ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_drop_repair] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_repair ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 23: //������ ����
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_drop_payment] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_drop_payment] == premium_info[i][ prem_drop_payment ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_payment ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_drop_payment] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_drop_payment] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_drop_payment] == premium_info[i][ prem_drop_payment ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_payment ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_payment ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_drop_payment] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_payment ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 24: //�����
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			new
				price;
			
			ValuePremium[playerid][value_days] = 30 * (listitem + 1);
			
			switch( listitem )
			{
				case 0: price = ValuePremium[playerid][value_gmoney];
				case 1: price = floatround( ValuePremium[playerid][value_gmoney] * 2 * 0.94 );
				case 2: price = floatround( ValuePremium[playerid][value_gmoney] * 3 * 0.88 );
			}
			
			if( Premium[playerid][prem_id] )
			{
				ShowPremiumSettings( playerid );
				return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ���� ������� �������." );
			}
				
			if( Player[playerid][uGMoney] < price || !Player[playerid][uGMoney] )
			{
				ShowPremiumSettings( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
					
			if( ValuePremium[playerid][value_gmoney] < premium_info[1][prem_price] || ValuePremium[playerid][value_amount] < 11 )
			{
				ShowPremiumSettings( playerid );
						
				pformat:( ""gbError"������������ �������� ("cBLUE"%d/11"cWHITE") ��� ������� ������� ��������.", ValuePremium[playerid][value_amount] );
				psend:( playerid, C_WHITE );
				return 1;
			}
					
			Player[playerid][uGMoney] -= price;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
						
			Premium[playerid][prem_time] 		= gettime() + ValuePremium[playerid][value_days] * 86400;
			Premium[playerid][prem_type] 		= 4;
			Premium[playerid][prem_color] 		= TimePremium[playerid][prem_color];
			Premium[playerid][prem_gmoney]	 	= TimePremium[playerid][prem_gmoney];
			Premium[playerid][prem_bank] 		= TimePremium[playerid][prem_bank];
			Premium[playerid][prem_salary]		= TimePremium[playerid][prem_salary];
			Premium[playerid][prem_benefit]	 	= TimePremium[playerid][prem_benefit];
			Premium[playerid][prem_mass]	 	= TimePremium[playerid][prem_mass];
			Premium[playerid][prem_admins]		= TimePremium[playerid][prem_admins];
			Premium[playerid][prem_supports] 	= TimePremium[playerid][prem_supports];
			Premium[playerid][prem_h_payment]	= TimePremium[playerid][prem_h_payment];
			Premium[playerid][prem_car]			= TimePremium[playerid][prem_car];
			Premium[playerid][prem_house]		= TimePremium[playerid][prem_house];
			Premium[playerid][prem_business]	= TimePremium[playerid][prem_business];
			Premium[playerid][prem_house_property]	= TimePremium[playerid][prem_house_property];
			Premium[playerid][prem_drop_retreature]	= TimePremium[playerid][prem_drop_retreature];
			Premium[playerid][prem_drop_tuning]		= TimePremium[playerid][prem_drop_tuning];
			Premium[playerid][prem_drop_repair]		= TimePremium[playerid][prem_drop_repair];
			Premium[playerid][prem_drop_payment]	= TimePremium[playerid][prem_drop_payment];
					
			mysql_format:g_string( "\
				INSERT INTO `"DB_PREMIUM"`\
					( `prem_user_id`, `prem_type`, `prem_time`, `prem_color`, `prem_gmoney`, `prem_bank`, `prem_salary`,\
					`prem_benefit`, `prem_mass`, `prem_admins`, `prem_supports`, `prem_h_payment`, `prem_house`,\
					`prem_car`, `prem_business`, `prem_house_property`, `prem_drop_retreature`, `prem_drop_tuning`,\
					`prem_drop_repair`, `prem_drop_payment`\
					) \
				VALUES \
					( %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d )",
				Player[playerid][uID], 
				Premium[playerid][prem_type], 
				Premium[playerid][prem_time],
				Premium[playerid][prem_color],
				Premium[playerid][prem_gmoney],
				Premium[playerid][prem_bank],
				Premium[playerid][prem_salary],
				Premium[playerid][prem_benefit],
				Premium[playerid][prem_mass],
				Premium[playerid][prem_admins],
				Premium[playerid][prem_supports],
				Premium[playerid][prem_h_payment],
				Premium[playerid][prem_house],
				Premium[playerid][prem_car],
				Premium[playerid][prem_business],
				Premium[playerid][prem_house_property],
				Premium[playerid][prem_drop_retreature],
				Premium[playerid][prem_drop_tuning],
				Premium[playerid][prem_drop_repair],
				Premium[playerid][prem_drop_payment]
			);
					
			mysql_tquery( mysql, g_string, "AddPremium", "d", playerid );
			
			pformat:( ""gbSuccess"�� ��������� ������� ������� %s�������������"cWHITE" (%d RCoin), c��� �������� - "cBLUE"%d"cWHITE" ����.", GetPremiumColor( Premium[playerid][prem_color] ), price, ValuePremium[playerid][value_days] );
			psend:( playerid, C_WHITE );
					
			TimePremium[playerid][prem_id] =
			TimePremium[playerid][prem_time] = 
			TimePremium[playerid][prem_type] = 
			TimePremium[playerid][prem_color] = 
			TimePremium[playerid][prem_gmoney] = 
			TimePremium[playerid][prem_bank] = 
			TimePremium[playerid][prem_salary] = 
			TimePremium[playerid][prem_benefit] = 
			TimePremium[playerid][prem_mass] = 
			TimePremium[playerid][prem_admins] = 
			TimePremium[playerid][prem_supports] = 
			TimePremium[playerid][prem_h_payment] = 
			TimePremium[playerid][prem_house] = 
			TimePremium[playerid][prem_car] = 
			TimePremium[playerid][prem_business] = 
			TimePremium[playerid][prem_house_property] = 
			TimePremium[playerid][prem_drop_retreature] = 
			TimePremium[playerid][prem_drop_tuning] = 
			TimePremium[playerid][prem_drop_repair] = 
			TimePremium[playerid][prem_drop_payment] = 0;
					
			ValuePremium[playerid][value_amount] =
			ValuePremium[playerid][value_gmoney] = 0;
			ValuePremium[playerid][value_days] = 30;
					
			showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
		}
		
		case d_donate + 25:
		{
			showPlayerDialog( playerid, d_donate + 1, DIALOG_STYLE_LIST, "����������", donatinfo, "�������", "�����" );
		}
		
		/* - - - - - - - - - - �������������� ����������� - - - - - - - - - - */
		
		case d_donate + 26:
		{
			if( !response )
				return showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "�������", donat, "�������", "�������" );
		
			switch( listitem )
			{
				case 0: //����� ����
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_ROLE )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
				
					showPlayerDialog( playerid, d_donate + 27, DIALOG_STYLE_LIST, ""cBLUE"��������: ���", "\
							"gbDialog"�������� ��� ������ ���������:\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�������\
						", "�������", "�����" );
				}
				
				case 1: //����� ����
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_SEX )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 33, DIALOG_STYLE_LIST, ""cBLUE"��������: ���", "\
							"gbDialog"�������� ��� ������ ���������:\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�������\
						", "�������", "�����" );
				}
				
				case 2: //����� ����� ����
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_COLOR )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 34, DIALOG_STYLE_LIST, ""cBLUE"��������: ���� ����", "\
							"gbDialog"�������� ���� ���� ������ ���������:\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"�������\
						", "�������", "�����" );
				}
				
				case 3: //����� ��������������
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_NATION )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 35, DIALOG_STYLE_LIST, ""cBLUE"��������: ��������������", "\
							"gbDialog"�������� �������������� ������ ���������:\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"����������������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"���\n\
							"cBLUE"- "cWHITE"������\
						", "�������", "�����" );
				}
				
				case 4: //����� ������ ��������
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_COUNTRY )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 36, DIALOG_STYLE_LIST, ""cBLUE"��������: ������ ��������", "\
							"gbDialog"�������� ������ �������� ������ ���������:\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"���\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"������\
						", "�������", "�����" );
				}
				
				case 5: //����� ��������
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_AGE )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 37, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"��������: �������\n\n\
							"cWHITE"������� ������� ������ ���������:\n\
							"gbDialog"�� 16 �� 70 ���",
						"�����", "�����" );
				}
				
				case 6: //����� ����
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_NAME )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 39, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"��������: �������\n\n\
								"cWHITE"������� ����� ��� � �������:\n\n\
								���������� ������������ ��������� �����/�������:\n\
								"cBLUE"- "cGRAY"������� ������ �������� ������ �� ��������� ����,\n\
								"cBLUE"- "cGRAY"����� ����� � ������� ������ �������������� ���� '_',\n\
								"cBLUE"- "cGRAY"������� �� ������ ��������� ������ 24 � ������ 6 ��������,\n\
								"cBLUE"- "cGRAY"��� �(���) ������� �� ������ ��������� ������ 3 ��������,\n\
								"cBLUE"- "cGRAY"��� � ������� ������ ���������� � ��������� ����.",
						"�����", "�����" );
				}
				
				case 7: //������� ����� ���
				{
					if( Player[playerid][uGMoney] < PRICE_STYLE )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
				
					showPlayerDialog( playerid, d_donate + 40, DIALOG_STYLE_LIST, "������� ����� ���", "\
						"gbDialog"�������� ����� ���:\n\
						"cBLUE"- "cWHITE"����\n\
						"cBLUE"- "cWHITE"���� ��\n\
						"cBLUE"- "cWHITE"���� �������\n\
						"cBLUE"- "cWHITE"���� �����\n\
						"cBLUE"- "cWHITE"���� ������", "�������", "�����" );
				}
				
				case 8: //������� ��� ����� ���
				{
					if( Player[playerid][uGMoney] < PRICE_STYLE_ALL )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					new
						amount = 5;
					
					for( new i; i < 5; i++ )
					{
						if( Player[playerid][uStyle][i] )
							amount--;
					}
					
					if( !amount )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"��� ����� ��� ��� �������." );
					}
					
					clean:<g_string>;
					
					strcat( g_string, ""cBLUE"������� ��� ����� ���\n\n"cWHITE"�� �������:" );
					
					if( !Player[playerid][uStyle][0] )
						strcat( g_string, "\n"cBLUE"����" );
					
					if( !Player[playerid][uStyle][1] )
						strcat( g_string, "\n"cBLUE"���� ��" );
						
					if( !Player[playerid][uStyle][2] )
						strcat( g_string, "\n"cBLUE"���� �������" );
						
					if( !Player[playerid][uStyle][3] )
						strcat( g_string, "\n"cBLUE"���� �����" );
					
					if( !Player[playerid][uStyle][4] )
						strcat( g_string, "\n"cBLUE"���� ������" );
						
					format:g_small_string( "\n\n"cWHITE"��������� "cBLUE"%d"cWHITE" RCoin. ����������?", PRICE_STYLE_ALL );
					strcat( g_string, g_small_string );
					
					showPlayerDialog( playerid, d_donate + 41, DIALOG_STYLE_MSGBOX, " ", g_string, "��", "���" );
				}
				
				case 9: //����� ��������������
				{
					if( Player[playerid][uGMoney] < PRICE_UNWARN )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( !Player[playerid][uWarn] )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ��������������." );
					}
					
					format:g_small_string( "\
						"cBLUE"����� ��������������\n\n\
						"cWHITE"� ��� ��������������: "cBLUE"%d/3\n\
						"cWHITE"��������� ������ ������ �������������� "cBLUE"%d"cWHITE" RCoin. ����������?", 
						Player[playerid][uWarn], PRICE_UNWARN );
					
					showPlayerDialog( playerid, d_donate + 42, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
				
				case 10: //����� ��� ��������������
				{
					if( Player[playerid][uGMoney] < PRICE_UNWARN_ALL )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( !Player[playerid][uWarn] )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ��������������." );
					}
					
					format:g_small_string( "\
						"cBLUE"����� ��� ��������������\n\n\
						"cWHITE"� ��� ��������������: "cBLUE"%d/3\n\
						"cWHITE"��������� ������ ���� �������������� "cBLUE"%d"cWHITE" RCoin. ����������?", 
						Player[playerid][uWarn], PRICE_UNWARN_ALL );
					
					showPlayerDialog( playerid, d_donate + 43, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
				
				case 11: //����������� ��������
				{
					if( Player[playerid][uGMoney] < PRICE_UNJOB )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( !Player[ playerid ][uJob] )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"�� �� �������� �� ������." );
					}
						
					if( job_duty{playerid} )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"�� ������ ��������� ������� ����." );
					}
					
					format:g_small_string( "\
						"cBLUE"����������� ������������ ������� ��������\n\n\
						"cWHITE"��������� ����������� ��������� ��������� �� ������� ������ "cBLUE"%d"cWHITE" RCoin. ����������?",
						PRICE_UNJOB );
					
					showPlayerDialog( playerid, d_donate + 44, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
				}
				
				case 12: //������� ����� ��������
				{
					if( Player[playerid][uGMoney] < PRICE_NUMBER_PHONE )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( !GetPhoneNumber( playerid ) )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"���������� � �������� ���� ��������� �������, �� ������� ������� �������� �����." );
					}
					
					showPlayerDialog( playerid, d_donate + 45, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"�������� ����� ��������\n\n\
						"cWHITE"������� �������� ����� ��������:\n\
						"gbDialog"����� �������� ������ ���� 6-�������", "�����", "�����" );
				}
			}
		}
		
		case d_donate + 27:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
		
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 27, DIALOG_STYLE_LIST, ""cBLUE"��������: ���", "\
						"gbDialog"�������� ��� ������ ���������:\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������\
					", "�������", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Sex", listitem );
			
			showPlayerDialog( playerid, d_donate + 28, DIALOG_STYLE_LIST, ""cBLUE"��������: ���� ����", "\
					"gbDialog"�������� ���� ���� ������ ���������:\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"�������\
				", "�������", "�����" );
		}
		
		case d_donate + 28: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Sex" );
				return showPlayerDialog( playerid, d_donate + 27, DIALOG_STYLE_LIST, ""cBLUE"��������: ���", "\
						"gbDialog"�������� ��� ������ ���������:\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������\
					", "�������", "�����" );
			}
		
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 28, DIALOG_STYLE_LIST, ""cBLUE"��������: ���� ����", "\
						"gbDialog"�������� ���� ���� ������ ���������:\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"�������\
					", "�������", "�����" );
			}
		
			SetPVarInt( playerid, "Change:Color", listitem );
		
			showPlayerDialog( playerid, d_donate + 29, DIALOG_STYLE_LIST, ""cBLUE"��������: ��������������", "\
					"gbDialog"�������� �������������� ������ ���������:\n\
					"cBLUE"- "cWHITE"����������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"����������\n\
					"cBLUE"- "cWHITE"����������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"��������\n\
					"cBLUE"- "cWHITE"���������\n\
					"cBLUE"- "cWHITE"���������\n\
					"cBLUE"- "cWHITE"�����\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"���������\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"���������\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"����������������\n\
					"cBLUE"- "cWHITE"����������\n\
					"cBLUE"- "cWHITE"�����\n\
					"cBLUE"- "cWHITE"�����\n\
					"cBLUE"- "cWHITE"����������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"�����\n\
					"cBLUE"- "cWHITE"��������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"���\n\
					"cBLUE"- "cWHITE"������\
				", "�������", "�����" );
		}
		
		case d_donate + 29: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Color" );
				return showPlayerDialog( playerid, d_donate + 28, DIALOG_STYLE_LIST, ""cBLUE"��������: ���� ����", "\
						"gbDialog"�������� ���� ���� ������ ���������:\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"�������\
					", "�������", "�����" );
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 29, DIALOG_STYLE_LIST, ""cBLUE"��������: ��������������", "\
						"gbDialog"�������� �������������� ������ ���������:\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"����������������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"���\n\
						"cBLUE"- "cWHITE"������\
					", "�������", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Nation", listitem );
			
			showPlayerDialog( playerid, d_donate + 30, DIALOG_STYLE_LIST, ""cBLUE"��������: ������ ��������", "\
					"gbDialog"�������� ������ �������� ������ ���������:\n\
					"cBLUE"- "cWHITE"���������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"��������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"��������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"�����\n\
					"cBLUE"- "cWHITE"��������\n\
					"cBLUE"- "cWHITE"�����\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"����������\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"����������\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"���\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"�����\n\
					"cBLUE"- "cWHITE"������\
				", "�������", "�����" );
		}
		
		case d_donate + 30:
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Nation" );
				return showPlayerDialog( playerid, d_donate + 29, DIALOG_STYLE_LIST, ""cBLUE"��������: ��������������", "\
						"gbDialog"�������� �������������� ������ ���������:\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"����������������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"���\n\
						"cBLUE"- "cWHITE"������\
					", "�������", "�����" );
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 30, DIALOG_STYLE_LIST, ""cBLUE"��������: ������ ��������", "\
						"gbDialog"�������� ������ �������� ������ ���������:\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"���\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"������\
					", "�������", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Country", listitem );
			
			showPlayerDialog( playerid, d_donate + 31, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"��������: �������\n\n\
					"cWHITE"������� ������� ������ ���������:\n\
					"gbDialog"�� 16 �� 70 ���",
				"�����", "�����" );
		}
		
		case d_donate + 31:
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Country" );
				return showPlayerDialog( playerid, d_donate + 30, DIALOG_STYLE_LIST, ""cBLUE"��������: ������ ��������", "\
						"gbDialog"�������� ������ �������� ������ ���������:\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"��������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"���\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"������\
					", "�������", "�����" );
			}
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 16 || strval( inputtext ) > 70 )
			{
				return showPlayerDialog( playerid, d_donate + 31, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"��������: �������\n\n\
						"cWHITE"������� ������� ������ ���������:\n\
						"gbDialog"�� 16 �� 70 ���\n\n\
						"gbDialogError"������������ ������ �����",
					"�����", "�����" );
			}
			 
			SetPVarInt( playerid, "Change:Age", strval( inputtext ) );
			
			format:g_string( ""cBLUE"����������� ��������� ����\n\n\
				"cWHITE"������� ����:\n\
				"cWHITE"��� - "cBLUE"%s,\n\
				"cWHITE"���� ���� - "cBLUE"%s,\n\
				"cWHITE"�������������� - "cBLUE"%s,\n\
				"cWHITE"������ �������� - "cBLUE"%s,\n\
				"cWHITE"������� - "cBLUE"%d %s\n\n\
				"cWHITE"����� ����:\n\
				"cWHITE"��� - "cBLUE"%s,\n\
				"cWHITE"���� ���� - "cBLUE"%s,\n\
				"cWHITE"�������������� - "cBLUE"%s,\n\
				"cWHITE"������ �������� - "cBLUE"%s,\n\
				"cWHITE"������� - "cBLUE"%d %s\n\n\
				"cWHITE"��������� ��������� ���� "cBLUE"%d"cWHITE" RCoin. ����������?",
				GetSexName( Player[playerid][uSex] ),
				Player[playerid][uColor] == 2 ? ("�������") : ("������"),
				GetNationName( Player[playerid][uNation] ),
				GetCountryName( Player[playerid][uCountry] ),
				Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ), 
				GetSexName( GetPVarInt( playerid, "Change:Sex" ) ),
				GetPVarInt( playerid, "Change:Color" ) == 2 ? ("�������") : ("������"),
				GetNationName( GetPVarInt( playerid, "Change:Nation" ) ),
				GetCountryName( GetPVarInt( playerid, "Change:Country" ) ),
				GetPVarInt( playerid, "Change:Age" ), AgeTextEnd( GetPVarInt( playerid, "Change:Age" )%10 ),
				PRICE_CHANGE_ROLE );
				
			showPlayerDialog( playerid, d_donate + 32, DIALOG_STYLE_MSGBOX, " ", g_string, "��", "���" );
		}
		
		case d_donate + 32:
		{
			if( !listitem )
			{
				DeletePVar( playerid, "Change:Sex" );
				DeletePVar( playerid, "Change:Color" );
				DeletePVar( playerid, "Change:Nation" );
				DeletePVar( playerid, "Change:Country" );
				DeletePVar( playerid, "Change:Age" );
				
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !""gbDefault"�� ���������� �� ��������� ����." );
			}
			
			if( Player[playerid][uGMoney] < PRICE_CHANGE_ROLE )
			{
				DeletePVar( playerid, "Change:Sex" );
				DeletePVar( playerid, "Change:Color" );
				DeletePVar( playerid, "Change:Nation" );
				DeletePVar( playerid, "Change:Country" );
				DeletePVar( playerid, "Change:Age" );
			
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= PRICE_CHANGE_ROLE;
			
			Player[playerid][uSex] = GetPVarInt( playerid, "Change:Sex" );
			Player[playerid][uColor] = GetPVarInt( playerid, "Change:Color" );
			Player[playerid][uNation] = GetPVarInt( playerid, "Change:Nation" );
			Player[playerid][uCountry] = GetPVarInt( playerid, "Change:Country" );
			Player[playerid][uAge] = GetPVarInt( playerid, "Change:Age" );
			
			DeletePVar( playerid, "Change:Sex" );
			DeletePVar( playerid, "Change:Color" );
			DeletePVar( playerid, "Change:Nation" );
			DeletePVar( playerid, "Change:Country" );
			DeletePVar( playerid, "Change:Age" );
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET \
				`uSex` = %d, `uColor` = %d, `uNation` = %d, `uCountry` = %d, `uAge` = %d, `uGMoney` = %d \
				WHERE `uID` = %d LIMIT 1", 
				Player[playerid][uSex],
				Player[playerid][uColor],
				Player[playerid][uNation],
				Player[playerid][uCountry],
				Player[playerid][uAge],
				Player[playerid][uGMoney],
				Player[playerid][uID] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"�� ������� �������� ���� ��������� (%d RCoin). ����������� ������, ���������� ��� ����� ����.", PRICE_CHANGE_ROLE );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 33: //����� ����
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 33, DIALOG_STYLE_LIST, ""cBLUE"��������: ���", "\
						"gbDialog"�������� ��� ������ ���������:\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������\
					", "�������", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Sex", listitem );
			ConfirmChangePlayer( playerid, 0 );
		}
		
		case d_donate + 34: //����� ����� ����
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 34, DIALOG_STYLE_LIST, ""cBLUE"��������: ���� ����", "\
							"gbDialog"�������� ���� ���� ������ ���������:\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"�������\
						", "�������", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Color", listitem );
			ConfirmChangePlayer( playerid, 1 );
		}
		
		case d_donate + 35: //����� ��������������
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 35, DIALOG_STYLE_LIST, ""cBLUE"��������: ��������������", "\
							"gbDialog"�������� �������������� ������ ���������:\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"����������������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"���\n\
							"cBLUE"- "cWHITE"������\
						", "�������", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Nation", listitem );
			ConfirmChangePlayer( playerid, 2 );
		}
		
		case d_donate + 36: //����� ������ ��������
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 36, DIALOG_STYLE_LIST, ""cBLUE"��������: ������ ��������", "\
							"gbDialog"�������� ������ �������� ������ ���������:\n\
							"cBLUE"- "cWHITE"���������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"��������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"����������\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"���\n\
							"cBLUE"- "cWHITE"������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�������\n\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"������\
						", "�������", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Country", listitem );
			ConfirmChangePlayer( playerid, 3 );
		}
		
		case d_donate + 37: //����� ��������
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 16 || strval( inputtext ) > 70 )
			{
				return showPlayerDialog( playerid, d_donate + 37, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"��������: �������\n\n\
						"cWHITE"������� ������� ������ ���������:\n\
						"gbDialog"�� 16 �� 70 ���\n\n\
						"gbDialogError"������������ ������ �����",
					"�����", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Age", strval( inputtext ) );
			ConfirmChangePlayer( playerid, 4 );
		}
		
		case d_donate + 38: //������ ������������� ���������
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Sex" );
				DeletePVar( playerid, "Change:Color" );
				DeletePVar( playerid, "Change:Nation" );
				DeletePVar( playerid, "Change:Country" );
				DeletePVar( playerid, "Change:Age" );
				DeletePVar( playerid, "Change:Price" );
				DeletePVar( playerid, "Change:Type" );
				DeletePVar( playerid, "Change:Name" );
			
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !""gbError"�� ���������� �� ���������." );
			}
			
			new
				price = GetPVarInt( playerid, "Change:Price" ),
				type = GetPVarInt( playerid, "Change:Type" );
				
			if( Player[playerid][uGMoney] < price )
			{
				DeletePVar( playerid, "Change:Sex" );
				DeletePVar( playerid, "Change:Color" );
				DeletePVar( playerid, "Change:Nation" );
				DeletePVar( playerid, "Change:Country" );
				DeletePVar( playerid, "Change:Age" );
				DeletePVar( playerid, "Change:Price" );
				DeletePVar( playerid, "Change:Type" );
				DeletePVar( playerid, "Change:Name" );
			
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= price;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			switch( type )
			{
				case 0:
				{
					Player[playerid][uSex] = GetPVarInt( playerid, "Change:Sex" );
					pformat:( ""gbSuccess"�� ������� �������� ��� �� "cBLUE"%s"cWHITE" (%d RCoin).", GetSexName( Player[playerid][uSex] ), price );
					UpdatePlayer( playerid, "uSex", Player[playerid][uSex] );
				}
				
				case 1:
				{
					Player[playerid][uColor] = GetPVarInt( playerid, "Change:Color" );
					pformat:( ""gbSuccess"�� ������� �������� ���� ���� �� "cBLUE"%s"cWHITE" (%d RCoin).", Player[playerid][uColor] == 2 ? ("�������") : ("������"), price );
					UpdatePlayer( playerid, "uColor", Player[playerid][uColor] );
				}
				
				case 2:
				{
					Player[playerid][uNation] = GetPVarInt( playerid, "Change:Nation" );
					pformat:( ""gbSuccess"�� ������� �������� �������������� �� "cBLUE"%s"cWHITE" (%d RCoin).", GetNationName( Player[playerid][uNation] ), price );
					UpdatePlayer( playerid, "uNation", Player[playerid][uNation] );
				}
				
				case 3:
				{
					Player[playerid][uCountry] = GetPVarInt( playerid, "Change:Country" );
					pformat:( ""gbSuccess"�� ������� �������� ������ �������� �� "cBLUE"%s"cWHITE" (%d RCoin).", GetCountryName( Player[playerid][uCountry] ), price );
					UpdatePlayer( playerid, "uCountry", Player[playerid][uCountry] );
				}
				
				case 4:
				{
					Player[playerid][uAge] = GetPVarInt( playerid, "Change:Age" );
					pformat:( ""gbSuccess"�� ������� �������� ������� �� "cBLUE"%d %s"cWHITE" (%d RCoin).", Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ), price );
					UpdatePlayer( playerid, "uAge", Player[playerid][uAge] );
				}
				
				case 5:
				{
					new
						name[ MAX_PLAYER_NAME ];
					GetPVarString( playerid, "Change:Name", name, MAX_PLAYER_NAME );
				
					format:g_small_string( "%s ������� ������� �� %s", Player[playerid][uName], name );
					log( LOG_CHANGE_NAME, g_small_string, Player[playerid][uID] );
				
					format:g_small_string( ""ADMIN_PREFIX" %s[%d] ������� ������� �� %s",
						Player[playerid][uName],
						playerid,
						name );
						
					SendAdmin:( C_DARKGRAY, g_small_string );
				
					SetPlayerName( playerid, name );
					
					Player[playerid][uName][0] = EOS;
					GetPlayerName( playerid, Player[playerid][uName], MAX_PLAYER_NAME );
					
					pformat:( ""gbSuccess"�� ������� �������� ������� �� "cBLUE"%s"cWHITE" (%d RCoin).", Player[playerid][uName], price );
					UpdatePlayerString( playerid, "uName", Player[playerid][uName] );
				}	
			}
			
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Change:Sex" );
			DeletePVar( playerid, "Change:Color" );
			DeletePVar( playerid, "Change:Nation" );
			DeletePVar( playerid, "Change:Country" );
			DeletePVar( playerid, "Change:Age" );
			DeletePVar( playerid, "Change:Price" );
			DeletePVar( playerid, "Change:Type" );
			DeletePVar( playerid, "Change:Name" );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 39:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
		
			if( !CheckDonateName( inputtext ) )
			{
				return showPlayerDialog( playerid, d_donate + 39, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"��������: �������\n\n\
								"cWHITE"������� ����� ��� � �������:\n\
								"gbDialogError"������������ �������\n\n\
								��������� ������������ ��������� �����/������� � ���������� ��� ���:\n\
								"cBLUE"- "cGRAY"������� ������ �������� ������ �� ��������� ����,\n\
								"cBLUE"- "cGRAY"����� ����� � ������� ������ �������������� ���� '_',\n\
								"cBLUE"- "cGRAY"������� �� ������ ��������� ������ 24 � ������ 6 ��������,\n\
								"cBLUE"- "cGRAY"��� �(���) ������� �� ������ ��������� ������ 3 ��������,\n\
								"cBLUE"- "cGRAY"��� � ������� ������ ���������� � ��������� ����.",
						"�����", "�����" );
			}
			
			SetPVarString( playerid, "Change:Name", inputtext );
			ConfirmChangePlayer( playerid, 5 );
		}
		
		case d_donate + 40:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 40, DIALOG_STYLE_LIST, "������� ����� ���", "\
							"gbDialog"�������� ����� ���:\n\
							"cBLUE"- "cWHITE"����\n\
							"cBLUE"- "cWHITE"���� ��\n\
							"cBLUE"- "cWHITE"���� �������\n\
							"cBLUE"- "cWHITE"���� �����\n\
							"cBLUE"- "cWHITE"���� ������", 
						"�������", "�����" );
			}
			
			if( Player[playerid][uStyle][listitem - 1] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"������ ����� ��� ��� ������." );
				return showPlayerDialog( playerid, d_donate + 40, DIALOG_STYLE_LIST, "������� ����� ���", "\
							"gbDialog"�������� ����� ���:\n\
							"cBLUE"- "cWHITE"����\n\
							"cBLUE"- "cWHITE"���� ��\n\
							"cBLUE"- "cWHITE"���� �������\n\
							"cBLUE"- "cWHITE"���� �����\n\
							"cBLUE"- "cWHITE"���� ������", 
						"�������", "�����" );
			}
			
			if( Player[playerid][uGMoney] < PRICE_STYLE )
			{
				SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
				return showPlayerDialog( playerid, d_donate + 40, DIALOG_STYLE_LIST, "������� ����� ���", "\
							"gbDialog"�������� ����� ���:\n\
							"cBLUE"- "cWHITE"����\n\
							"cBLUE"- "cWHITE"���� ��\n\
							"cBLUE"- "cWHITE"���� �������\n\
							"cBLUE"- "cWHITE"���� �����\n\
							"cBLUE"- "cWHITE"���� ������", 
						"�������", "�����" );
			}
			
			Player[playerid][uStyle][listitem - 1] = 1;
			Player[playerid][uGMoney] -= PRICE_STYLE;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uStyle` = '%d|%d|%d|%d|%d' WHERE `uID` = %d LIMIT 1",
				Player[playerid][uStyle][0],
				Player[playerid][uStyle][1],
				Player[playerid][uStyle][2],
				Player[playerid][uStyle][3],
				Player[playerid][uStyle][4],
				Player[playerid][uID]
				);
			mysql_tquery( mysql, g_small_string );
			
			switch( listitem )
			{
				case 1: pformat:( ""gbSuccess"�� ������� ������� ����� ��� "cBLUE"����"cWHITE" (%d RCoin).", PRICE_STYLE );
				case 2: pformat:( ""gbSuccess"�� ������� ������� ����� ��� "cBLUE"���� ��"cWHITE" (%d RCoin).", PRICE_STYLE );
				case 3: pformat:( ""gbSuccess"�� ������� ������� ����� ��� "cBLUE"���� �������"cWHITE" (%d RCoin).", PRICE_STYLE );
				case 4: pformat:( ""gbSuccess"�� ������� ������� ����� ��� "cBLUE"���� �����"cWHITE" (%d RCoin).", PRICE_STYLE );
				case 5: pformat:( ""gbSuccess"�� ������� ������� ����� ��� "cBLUE"���� ������"cWHITE" (%d RCoin).", PRICE_STYLE );
			}
			
			psend:( playerid, C_WHITE );
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 41:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( Player[playerid][uGMoney] < PRICE_STYLE )
			{
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			for( new i; i < 5; i++ )
			{
				if( !Player[playerid][uStyle][i] )
					Player[playerid][uStyle][i] = 1;
			}
			
			Player[playerid][uGMoney] -= PRICE_STYLE_ALL;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uStyle` = '1|1|1|1|1' WHERE `uID` = %d LIMIT 1", Player[playerid][uID] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"�� ������� ������� ��� ����� ��� (%d RCoin).", PRICE_STYLE_ALL );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 42: //����� ��������������
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( Player[playerid][uGMoney] < PRICE_UNWARN )
			{
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= PRICE_UNWARN;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			Player[playerid][uWarn] --;
			UpdatePlayer( playerid, "uWarn", Player[playerid][uWarn] );
			
			pformat:( ""gbSuccess"�� ������� ����� ���� �������������� (%d RCoin). ��������������: "cBLUE"%d/3", PRICE_UNWARN, Player[playerid][uWarn] );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 43: //����� ��� ��������������
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( Player[playerid][uGMoney] < PRICE_UNWARN_ALL )
			{
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= PRICE_UNWARN_ALL;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
		
			Player[playerid][uWarn] = 0;
			UpdatePlayer( playerid, "uWarn", 0 );
			
			pformat:( ""gbSuccess"�� ������� ����� ��� �������������� (%d RCoin).", PRICE_UNWARN_ALL );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 44: //����������� ��������
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( Player[playerid][uGMoney] < PRICE_UNJOB )
			{
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= PRICE_UNJOB;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			Player[ playerid ][uJob] = 
			Job[ playerid ][j_time] =
			job_duty{ playerid } = 0;
			
			UpdatePlayer( playerid, "uJob", 0 );
			UpdatePlayer( playerid, "uJobTime", 0 );
			
			pformat:( ""gbSuccess"�� ������� ��������� ������������ ������� �������� (%d RCoin).", PRICE_UNJOB );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 45:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 100000 || strval( inputtext ) > 999999 || strlen( inputtext ) < 6 )
			{
				return showPlayerDialog( playerid, d_donate + 45, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"�������� ����� ��������\n\n\
					"cWHITE"������� �������� ����� ��������:\n\
					"gbDialog"����� �������� ������ ���� 6-�������\n\n\
					"gbDialogError"������������ ������ �����.", "�����", "�����" );
			}
			
			SetPVarInt( playerid, "Change:Phone", strval( inputtext ) );
			
			format:g_small_string( "\
				"cBLUE"�������� ����� ��������\n\n\
				"cWHITE"������� �����: "cBLUE"%d\n\
				"cWHITE"����� �����: "cBLUE"%d\n\n\
				"cWHITE"��������� ��������� ������ �������� "cBLUE"%d"cWHITE" RCoin. ����������?\n\
				"gbDialog"����� ������������� ��������� �������� ��������� ������ �� �������������.",
				GetPhoneNumber( playerid ),
				strval( inputtext ),
				PRICE_NUMBER_PHONE );
				
			showPlayerDialog( playerid, d_donate + 46, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
		}
		
		case d_donate + 46:
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Phone" );
				return showPlayerDialog( playerid, d_donate + 45, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"�������� ����� ��������\n\n\
					"cWHITE"������� �������� ����� ��������:\n\
					"gbDialog"����� �������� ������ ���� 6-�������", "�����", "�����" );
			}
		
			new
				number = GetPVarInt( playerid, "Change:Phone" );
		
			if( Player[playerid][uGMoney] < PRICE_NUMBER_PHONE )
			{
				DeletePVar( playerid, "Change:Phone" );
				ShowDonatAdd( playerid );
				
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
		
			mysql_format:g_small_string( "SELECT * FROM `"DB_PHONES"` WHERE `p_number` = %d", number );
			mysql_tquery( mysql, g_small_string, "ChangeNumber", "dd", playerid, number );
		}
	}
	
	return 1;
}

function LoadPremiumAccount( playerid )
{
	new 
		rows = cache_get_row_count(); 
	
	if( !rows )
		return 1;
		
	Premium[playerid][prem_id] = cache_get_field_content_int( 0, "prem_id", mysql );
	Premium[playerid][prem_type] = cache_get_field_content_int( 0, "prem_type", mysql );
	Premium[playerid][prem_time] = cache_get_field_content_int( 0, "prem_time", mysql );
	Premium[playerid][prem_color] = cache_get_field_content_int( 0, "prem_color", mysql );
	Premium[playerid][prem_gmoney] = cache_get_field_content_int( 0, "prem_gmoney", mysql );
	Premium[playerid][prem_bank] = cache_get_field_content_int( 0, "prem_bank", mysql );
	Premium[playerid][prem_salary] = cache_get_field_content_int( 0, "prem_salary", mysql );
	Premium[playerid][prem_benefit] = cache_get_field_content_int( 0, "prem_benefit", mysql );
	Premium[playerid][prem_mass] = cache_get_field_content_int( 0, "prem_mass", mysql );
	Premium[playerid][prem_admins] = cache_get_field_content_int( 0, "prem_admins", mysql );
	Premium[playerid][prem_supports] = cache_get_field_content_int( 0, "prem_supports", mysql );
	Premium[playerid][prem_h_payment] = cache_get_field_content_int( 0, "prem_h_payment", mysql );
	
	Premium[playerid][prem_house] = cache_get_field_content_int( 0, "prem_house", mysql );
	Premium[playerid][prem_car] = cache_get_field_content_int( 0, "prem_car", mysql );
	Premium[playerid][prem_business] = cache_get_field_content_int( 0, "prem_business", mysql );
	
	Premium[playerid][prem_house_property] = cache_get_field_content_int( 0, "prem_house_property", mysql );
	
	Premium[playerid][prem_drop_retreature] = cache_get_field_content_int( 0, "prem_drop_retreature", mysql );
	Premium[playerid][prem_drop_tuning] = cache_get_field_content_int( 0, "prem_drop_tuning", mysql );
	Premium[playerid][prem_drop_repair] = cache_get_field_content_int( 0, "prem_drop_repair", mysql );
	Premium[playerid][prem_drop_payment] = cache_get_field_content_int( 0, "prem_drop_payment", mysql );
	
	printf( "[load] Load Premium #%d for %s[%d]", Premium[playerid][prem_type], Player[playerid][uName], playerid );
	
	if( Premium[playerid][prem_time] )
	{
		new
			day,
			Float:interval;
			
		interval = float( Premium[playerid][prem_time] - gettime() ) / 86400.0;
		day = floatround( interval, floatround_floor );
	
		pformat:( ""gbDialog"���� �������� ������� �������� %s%s"cGRAY" �������� ����� "cBLUE"%d"cGRAY" ����.", GetPremiumColor( Premium[playerid][prem_color] ), GetPremiumName( Premium[playerid][prem_type] ), day );
		psend:( playerid, C_WHITE );
	}
		
	return 1;
}

stock ShowPremiumInfo( playerid, premium ) //���������� ��� ���������, �����������, ������������
{
	clean:<g_big_string>;
	
	format:g_small_string( ""cWHITE"������� �������%s %s\n\n", GetPremiumColor( premium_info[premium][ prem_color ][0] ), GetPremiumName( premium ) ), strcat( g_big_string, g_small_string );
	
	if( premium_info[premium][prem_gmoney][0] )
		format:g_small_string( ""cGRAY"RCoin � PayDay: "cBLUE"%d\n", premium_info[premium][prem_gmoney][0] ), strcat( g_big_string, g_small_string );
	
	if( premium_info[premium][prem_bank][0] )
		format:g_small_string( ""cGRAY"���������� ���������� �� ���������� ����� �� "cBLUE"0.%d %%", premium_info[premium][prem_bank][0] ), strcat( g_big_string, g_small_string );

	if( premium_info[premium][prem_salary][0] )
		format:g_small_string( "\n"cGRAY"���������� ���������� ����� �� "cBLUE"%d %%", premium_info[premium][prem_salary][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_benefit][0] )
		format:g_small_string( "\n"cGRAY"���������� ������� �� ����������� �� "cBLUE"%d %%", premium_info[premium][prem_benefit][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_mass][0] )
		format:g_small_string( "\n"cGRAY"�������������� ���: "cBLUE"%d ��.", premium_info[premium][prem_mass][0] ), strcat( g_big_string, g_small_string );
	
	if( premium_info[premium][prem_admins][0] )
		strcat( g_big_string, "\n"cGRAY"������ � ������� "cBLUE"/admins" );
		
	if( premium_info[premium][prem_supports][0] )
		strcat( g_big_string, "\n"cGRAY"������ � ������� "cBLUE"/supports" );
		
	if( premium_info[premium][prem_h_payment][0] )
		format:g_small_string( "\n"cGRAY"����������� ������ ���� �� "cBLUE"+%d ����", premium_info[premium][prem_h_payment][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_car][0] )
		strcat( g_big_string, "\n"cGRAY"����������� ����� "cBLUE"2"cGRAY" ������������ ��������" );
		
	if( premium_info[premium][prem_house][0] )
		strcat( g_big_string, "\n"cGRAY"����������� ����� "cBLUE"2"cGRAY" ����" );
		
	if( premium_info[premium][prem_business][0] )
		strcat( g_big_string, "\n"cGRAY"����������� ����� "cBLUE"2"cGRAY" �������" );
		
	if( premium_info[premium][prem_house_property][0] )
		format:g_small_string( "\n"cGRAY"���������� ��������� ������� ��������� ����������� �� "cBLUE"%d %%", premium_info[premium][prem_house_property][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_drop_retreature][0] )
		format:g_small_string( "\n"cGRAY"�������� ��� ���������� � ���������� ������������� �� "cBLUE"%d %%", premium_info[premium][prem_drop_retreature][0] ), strcat( g_big_string, g_small_string );
	
	if( premium_info[premium][prem_drop_tuning][0] )
		format:g_small_string( "\n"cGRAY"�������� ��� ������� ���������� �� "cBLUE"%d %%", premium_info[premium][prem_drop_tuning][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_drop_repair][0] )
		format:g_small_string( "\n"cGRAY"�������� ��� ������� ���������� �� "cBLUE"%d %%", premium_info[premium][prem_drop_repair][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_drop_payment][0] )
		format:g_small_string( "\n"cGRAY"�������� ��� ������������ ��������/������ ����/�������� �� "cBLUE"%d %%", premium_info[premium][prem_drop_payment][0] ), strcat( g_big_string, g_small_string );
	
	format:g_small_string( "\n\n"cWHITE"��������� ������������ ������ �� "cBLUE"30"cWHITE" ���� ���������� "cBLUE"%d"cWHITE" RCoin.", premium_info[premium][prem_price] ), strcat( g_big_string, g_small_string );
	format:g_small_string( "\n�� ����� ����� - "cBLUE"%d"cWHITE" RCoin", Player[playerid][uGMoney] ), strcat( g_big_string, g_small_string );
	
	return showPlayerDialog( playerid, d_donate + 3, DIALOG_STYLE_MSGBOX, " ", g_big_string, "������", "�����" );
}

stock ShowMyPremiumInfo( playerid )
{
	clean:<g_big_string>;
	clean:<g_string>;
	
	new
		year, month, day;
	
	format:g_small_string( ""cWHITE"��� ������� �������%s %s\n", GetPremiumColor( Premium[playerid][ prem_color ] ), GetPremiumName( Premium[playerid][prem_type] ) ), strcat( g_big_string, g_small_string );
	
	gmtime( Premium[playerid][prem_time], year, month, day );	
	format:g_small_string( ""cWHITE"���� �������� �������� �������� "cBLUE"%02d.%02d.%d\n\n", day, month, year ), strcat( g_big_string, g_small_string );
	
	if( Premium[playerid][prem_gmoney] )
		format:g_small_string( ""cGRAY"RCoin � PayDay: "cBLUE"%d\n", Premium[playerid][prem_gmoney] ), strcat( g_big_string, g_small_string );
	
	if( Premium[playerid][prem_bank] )
		format:g_small_string( ""cGRAY"���������� ���������� �� ���������� ����� �� "cBLUE"0.%d %%", Premium[playerid][prem_bank] ), strcat( g_big_string, g_small_string );

	if( Premium[playerid][prem_salary] )
		format:g_small_string( "\n"cGRAY"���������� ���������� ����� �� "cBLUE"%d %%", Premium[playerid][prem_salary] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_benefit] )
		format:g_small_string( "\n"cGRAY"���������� ������� �� ����������� �� "cBLUE"%d %%", Premium[playerid][prem_benefit] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_mass] )
		format:g_small_string( "\n"cGRAY"�������������� ���: "cBLUE"%d ��.", Premium[playerid][prem_mass] ), strcat( g_big_string, g_small_string );
	
	if( Premium[playerid][prem_admins] )
		strcat( g_big_string, "\n"cGRAY"������ � ������� "cBLUE"/admins" );
		
	if( Premium[playerid][prem_supports] )
		strcat( g_big_string, "\n"cGRAY"������ � ������� "cBLUE"/supports" );
		
	if( Premium[playerid][prem_h_payment] )
		format:g_small_string( "\n"cGRAY"����������� ������ ���� �� "cBLUE"+%d ����", Premium[playerid][prem_h_payment] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_car] )
	{
		strcat( g_big_string, "\n"cGRAY"����������� ����� "cBLUE"2"cGRAY" ������������ ��������" );
		strcat( g_string, "\n\n"gbDialogError"��������! �� ��������� ����� �������� ������� ��������\n\
		������ ������������ �������� ������������� ��������� ����������� �� �������� ���������." );
	}
		
	if( Premium[playerid][prem_house] )
	{
		strcat( g_big_string, "\n"cGRAY"����������� ����� "cBLUE"2"cGRAY" ����" );
		strcat( g_string, "\n\n"gbDialogError"��������! �� ��������� ����� �������� ������� ��������\n\
		������ ���/�������� ������������� ��������� ����������� �� �������� ���������." );
	}
		
	if( Premium[playerid][prem_business] )
	{
		strcat( g_big_string, "\n"cGRAY"����������� ����� "cBLUE"2"cGRAY" �������" );
		strcat( g_string, "\n\n"gbDialogError"��������! �� ��������� ����� �������� ������� ��������\n\
		������ ������ ������������� ��������� ����������� �� �������� ���������." );
	}
		
	if( Premium[playerid][prem_house_property] )
		format:g_small_string( "\n"cGRAY"���������� ��������� ������� ��������� ����������� �� "cBLUE"%d %%", Premium[playerid][prem_house_property] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_drop_retreature] )
		format:g_small_string( "\n"cGRAY"�������� ��� ���������� � ���������� ������������� �� "cBLUE"%d %%", Premium[playerid][prem_drop_retreature] ), strcat( g_big_string, g_small_string );
	
	if( Premium[playerid][prem_drop_tuning] )
		format:g_small_string( "\n"cGRAY"�������� ��� ������� ���������� �� "cBLUE"%d %%", Premium[playerid][prem_drop_tuning] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_drop_repair] )
		format:g_small_string( "\n"cGRAY"�������� ��� ������� ���������� �� "cBLUE"%d %%", Premium[playerid][prem_drop_repair] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_drop_payment] )
		format:g_small_string( "\n"cGRAY"�������� ��� ������������ ��������/������ ����/�������� �� "cBLUE"%d %%", Premium[playerid][prem_drop_payment] ), strcat( g_big_string, g_small_string );
	
	if( g_string[0] != EOS )
	{
		strcat( g_big_string, g_string );
	}
	
	return showPlayerDialog( playerid, d_donate + 25, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
}

function AddPremium( playerid )
{
	Premium[playerid][prem_id] = cache_insert_id();
	return 1;
}

stock ShowPremiumSettings( playerid )
{
	clean:<g_big_string>;
	strcat( g_big_string, ""cWHITE"���������\t"cWHITE"��������\n" );
	// -- 0
	if( TimePremium[playerid][prem_color] )
		format:g_small_string( ""cWHITE"���� ��������\t%sColor\n", GetPremiumColor( TimePremium[playerid][prem_color] ) ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"���� ��������\t"cBLUE"���\n" );
	// -- 1	
	if( TimePremium[playerid][prem_gmoney] )
		format:g_small_string( ""cWHITE"RCoin � PayDay\t"cBLUE"%d\n", TimePremium[playerid][prem_gmoney] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"RCoin � PayDay\t"cRED"���\n" );
	// -- 2	
	if( TimePremium[playerid][prem_bank] )
		format:g_small_string( ""cWHITE"������� � ����������� �� ���������� �����\t"cBLUE"0.%d %%\n", TimePremium[playerid][prem_bank] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"������� � ����������� �� ���������� �����\t"cRED"���\n" );
	// -- 3	
	if( TimePremium[playerid][prem_salary] )
		format:g_small_string( ""cWHITE"������� � ���������� �����\t"cBLUE"%d %%\n", TimePremium[playerid][prem_salary] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"������� � ���������� �����\t"cRED"���\n" );
	// -- 4	
	if( TimePremium[playerid][prem_benefit] )
		format:g_small_string( ""cWHITE"������� � ������� �� �����������\t"cBLUE"%d %%\n", TimePremium[playerid][prem_benefit] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"������� � ������� �� �����������\t"cRED"���\n" );
	// -- 5	
	if( TimePremium[playerid][prem_mass] )
		format:g_small_string( ""cWHITE"�������������� ���\t"cBLUE"%d ��.\n", TimePremium[playerid][prem_mass] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"�������������� ���\t"cRED"���\n" );
	// -- 6 -- 7	
	format:g_small_string( ""cWHITE"������ � ������� /admins\t%s\n", !TimePremium[playerid][prem_admins] ? (""cRED"���") : (""cBLUE"��") ), strcat( g_big_string, g_small_string );
	format:g_small_string( ""cWHITE"������ � ������� /supports\t%s\n", !TimePremium[playerid][prem_supports] ? (""cRED"���") : (""cBLUE"��") ), strcat( g_big_string, g_small_string );
	// -- 8
	if( TimePremium[playerid][prem_h_payment] )
		format:g_small_string( ""cWHITE"���������� ���������� ���� ��� ������ ����\t"cBLUE"+ %d\n", TimePremium[playerid][prem_h_payment] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"���������� ���������� ���� ��� ������ ����\t"cRED"���\n" );
	// -- 9 -- 10 -- 11	
	format:g_small_string( ""cWHITE"����������� ����� 2 ������������ ��������\t%s\n", !TimePremium[playerid][prem_car] ? (""cRED"���") : (""cBLUE"��") ), strcat( g_big_string, g_small_string );
	format:g_small_string( ""cWHITE"����������� ����� 2 ����\t%s\n", !TimePremium[playerid][prem_house] ? (""cRED"���") : (""cBLUE"��") ), strcat( g_big_string, g_small_string );
	format:g_small_string( ""cWHITE"����������� ����� 2 �������\t%s\n", !TimePremium[playerid][prem_business] ? (""cRED"���") : (""cBLUE"��") ), strcat( g_big_string, g_small_string );
	// -- 12
	if( TimePremium[playerid][prem_house_property] )
		format:g_small_string( ""cWHITE"���������� ��������� ������� ��������� �����������\t"cBLUE"�� %d %%\n", TimePremium[playerid][prem_house_property] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"���������� ��������� ������� ��������� �����������\t"cRED"���\n" );
	// -- 13	
	if( TimePremium[playerid][prem_drop_retreature] )
		format:g_small_string( ""cWHITE"�������� ��� ���������� � ���������� �������������\t"cBLUE"�� %d %%\n", TimePremium[playerid][prem_drop_retreature] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"�������� ��� ���������� � ���������� �������������\t"cRED"���\n" );
	// -- 14	
	if( TimePremium[playerid][prem_drop_tuning] )
		format:g_small_string( ""cWHITE"�������� ��� ������� ����������\t"cBLUE"�� %d %%\n", TimePremium[playerid][prem_drop_tuning] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"�������� ��� ������� ����������\t"cRED"���\n" );
	// -- 15	
	if( TimePremium[playerid][prem_drop_repair] )
		format:g_small_string( ""cWHITE"�������� ��� ������� ����������\t"cBLUE"�� %d %%\n", TimePremium[playerid][prem_drop_repair] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"�������� ��� ������� ����������\t"cRED"���\n" );
	// -- 16	
	if( TimePremium[playerid][prem_drop_payment] )
		format:g_small_string( ""cWHITE"�������� ��� ������������ ��������/������ ����\t"cBLUE"�� %d %%\n", TimePremium[playerid][prem_drop_payment] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"�������� ��� ������������ ��������/������ ����\t"cRED"���\n" );
	// -- 17
	//format:g_small_string( ""cWHITE"���� �������� ��������\t"cBLUE"%d ����\n", ValuePremium[playerid][value_days] ), strcat( g_big_string, g_small_string );
	// -- 18
	format:g_small_string( ""gbDialog"������ ������� �������\t"cBLUE"%d RCoin", ValuePremium[playerid][value_gmoney] ), strcat( g_big_string, g_small_string );
	
	showPlayerDialog( playerid, d_donate + 6, DIALOG_STYLE_TABLIST_HEADERS, "��������� ������� ��������", g_big_string, "�������", "�����" );
}

stock ShowDonatAdd( playerid )
{
	format:g_string( donatadd, 
		PRICE_CHANGE_ROLE,
		PRICE_CHANGE_SEX,
		PRICE_CHANGE_COLOR,
		PRICE_CHANGE_NATION,
		PRICE_CHANGE_COUNTRY,
		PRICE_CHANGE_AGE,
		PRICE_CHANGE_NAME,
		PRICE_STYLE,
		PRICE_STYLE_ALL,
		PRICE_UNWARN,
		PRICE_UNWARN_ALL,
		PRICE_UNJOB,
		PRICE_NUMBER_PHONE );
		
	//PRICE_NUMBER_CAR
		
	showPlayerDialog( playerid, d_donate + 26, DIALOG_STYLE_TABLIST_HEADERS, "�������������� �����������", g_string, "�������", "�����" );
}

stock ConfirmChangePlayer( playerid, type )
{
	SetPVarInt( playerid, "Change:Type", type );
	switch( type )
	{
		case 0: //���
		{
			format:g_small_string( "\
				"cBLUE"��������� ���������: ���\n\n\
				"cWHITE"������� ��� - "cBLUE"%s\n\
				"cWHITE"����� ��� - "cBLUE"%s\n\n\
				"cWHITE"��������� ��������� "cBLUE"%d"cWHITE" RCoin. ����������?",
				GetSexName( Player[playerid][uSex] ),
				GetSexName( GetPVarInt( playerid, "Change:Sex" ) ),
				PRICE_CHANGE_SEX );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_SEX );
		}
		
		case 1: //���� ����
		{
			format:g_small_string( "\
				"cBLUE"��������� ���������: ���� ����\n\n\
				"cWHITE"������� ���� ���� - "cBLUE"%s\n\
				"cWHITE"����� ���� ���� - "cBLUE"%s\n\n\
				"cWHITE"��������� ��������� "cBLUE"%d"cWHITE" RCoin. ����������?",
				Player[playerid][uColor] == 2 ? ("�������") : ("������"),
				GetPVarInt( playerid, "Change:Color" ) == 2 ? ("�������") : ("������"),
				PRICE_CHANGE_COLOR );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_COLOR );
		}
		
		case 2: //��������������
		{
			format:g_small_string( "\
				"cBLUE"��������� ���������: ��������������\n\n\
				"cWHITE"������� �������������� - "cBLUE"%s\n\
				"cWHITE"����� �������������� - "cBLUE"%s\n\n\
				"cWHITE"��������� ��������� "cBLUE"%d"cWHITE" RCoin. ����������?",
				GetNationName( Player[playerid][uNation] ),
				GetNationName( GetPVarInt( playerid, "Change:Nation" ) ),
				PRICE_CHANGE_NATION );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_NATION );
		}
		
		case 3: //������ ��������
		{
			format:g_small_string( "\
				"cBLUE"��������� ���������: ������ ��������\n\n\
				"cWHITE"������� ������ �������� - "cBLUE"%s\n\
				"cWHITE"����� ������ �������� - "cBLUE"%s\n\n\
				"cWHITE"��������� ��������� "cBLUE"%d"cWHITE" RCoin. ����������?",
				GetCountryName( Player[playerid][uCountry] ),
				GetCountryName( GetPVarInt( playerid, "Change:Country" ) ),
				PRICE_CHANGE_COUNTRY );
			
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_COUNTRY );
		}
		
		case 4: //�������
		{
			format:g_small_string( "\
				"cBLUE"��������� ���������: �������\n\n\
				"cWHITE"������� ������� - "cBLUE"%d %s\n\
				"cWHITE"����� ������� - "cBLUE"%d %s\n\n\
				"cWHITE"��������� ��������� "cBLUE"%d"cWHITE" RCoin. ����������?",
				Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ),
				GetPVarInt( playerid, "Change:Age" ), AgeTextEnd( GetPVarInt( playerid, "Change:Age" )%10 ),
				PRICE_CHANGE_AGE );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_AGE );
		}
		
		case 5: //���
		{
			new
				name[ MAX_PLAYER_NAME ];
			GetPVarString( playerid, "Change:Name", name, MAX_PLAYER_NAME );
		
			format:g_small_string( "\
				"cBLUE"��������� ���������: �������\n\n\
				"cWHITE"������� ��� - "cBLUE"%s\n\
				"cWHITE"����� ��� - "cBLUE"%s\n\n\
				"cWHITE"��������� ��������� "cBLUE"%d"cWHITE" RCoin. ����������?",
				Player[playerid][uName],
				name,
				PRICE_CHANGE_NAME );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_NAME );
		}
	}
	
	showPlayerDialog( playerid, d_donate + 38, DIALOG_STYLE_MSGBOX, " ", g_small_string, "��", "���" );
}

stock CheckDonateName( name[] )
{
	if( strlen( name ) < 6 || strlen( name ) > MAX_PLAYER_NAME )
		return STATUS_ERROR;
	
    for( new i = 0; i < strlen( name ); i++ )
    {
		// ������������ ������� � ����
		if( !( ( name[i] >= 'a' && name[i] <= 'z' ) || ( name[i] >= 'A' && name[i] <= 'Z' ) || name[i] == '_' ) )
                return STATUS_ERROR;
	}
		
	new 
		d = strfind( name, "_" );
			
	// ��� _ � ����
    if( d == INVALID_PARAM ) 
		return STATUS_ERROR; 
		
	// ������ ������ _ � ����
    if( strfind( name, "_", false, d + 1 ) != INVALID_PARAM ) 
		return STATUS_ERROR; 
		
	new 
		pname[10];
    strmid( pname, name, 0, d, sizeof pname );
        
	new 
		surname[10];
    strmid( surname, name, d + 1, strlen( name ), sizeof surname);
		
	// �������� ����� �����
    if( strlen( pname ) < 3 || strlen( surname ) < 3 ) 
		return STATUS_ERROR;
        
	// ������ ����� ����� �� ���������
	if( !( pname[0] >= 'A' && pname[0] <= 'Z' ) )
		return STATUS_ERROR;
			
	// ������ ����� ������� �� ���������
    if( !( surname[0] >= 'A' && surname[0]<='Z' ) ) 
		return STATUS_ERROR; 
			
	// �������� ����� � �����
    for( new i = 1; i < strlen( pname ); i++ )
    {
        if( !( pname[i] >= 'a' && pname[i] <= 'z' ) ) 
			return STATUS_ERROR; 
    }
		
	// �������� ����� � �������
    for( new i = 1; i < strlen( surname ); i++ )
    {
        if( !( surname[i] >= 'a' && surname[i] <= 'z' ) )
			return STATUS_ERROR;
	}
		
    return STATUS_OK;
}

function ChangeNumber( playerid, number )
{
	if( cache_get_row_count() )
	{
		DeletePVar( playerid, "Change:Phone" );
		return showPlayerDialog( playerid, d_donate + 45, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"�������� ����� ��������\n\n\
					"cWHITE"������� �������� ����� ��������:\n\
					"gbDialog"����� �������� ������ ���� 6-�������\n\n\
					"gbDialogError"��������� ����� �������� ��� �����, ���������� ������.", "�����", "�����" );
	}
	
	new
		oldnumber,
		item;
		
	/* - - - - - - -  ������ ������� ����� �������� � ���������� ������ - - - - - - - */
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		new
			id = getInventoryId( UseInv[playerid][i][inv_id] );
	
		if( inventory[id][i_type] == INV_PHONE )
		{
			oldnumber = UseInv[playerid][i][inv_param_2];
			item = i;
			break;
		}	
	}
	
	/* - - - - - - -  ������ ����� �������� - - - - - - - */
	for( new i; i < MAX_PHONES; i++ )
	{
		if( Phone[playerid][i][p_number] == oldnumber )
		{
			Phone[playerid][i][p_number] = number;
			break;
		}
	}
	
	mysql_format:g_small_string( "UPDATE `"DB_PHONES"` SET `p_number` = %d WHERE `p_number` = %d AND `p_user_id` = %d LIMIT 1",
		number, oldnumber, Player[playerid][uID] );
	mysql_tquery( mysql, g_small_string );
	
	UseInv[playerid][item][inv_param_2] = number;
	
	mysql_format:g_small_string( "UPDATE `"DB_ITEMS"` SET `item_param_2` = %d WHERE `id` = %d LIMIT 1",
		number, UseInv[playerid][item][inv_bd] );
	mysql_tquery( mysql, g_small_string );
	
	/* - - - - - - - �������� �� �������� ����� ������ - - - - - - - */
	
	pformat:( ""gbSuccess"�� ������� �������� ����� �������� �� "cBLUE"%d"cWHITE" (%d RCoin).", number, PRICE_NUMBER_PHONE );
	psend:( playerid, C_WHITE );
	
	DeletePVar( playerid, "Change:Phone" );
	
	ShowDonatAdd( playerid );
	
	return 1;
}