function Help_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_help: 
		{
			if( !response ) return 1;
			
			if( listitem == 6 )
			{
				return showPlayerDialog( playerid, d_help + 1, DIALOG_STYLE_LIST, "��������������� �����������", "�����\n�������������", "�������", "�����" );
			}
			
			clean:<g_big_string>;
			
			for( new i; i < sizeof help_command; i++ )
			{
				if( listitem == help_command[i][help_index] )
				{
					format:g_small_string( ""cBLUE"%s"cWHITE" - %s\n", help_command[i][help_text], help_command[i][help_descript] );
					strcat( g_big_string, g_small_string );
				}
			}
			
			showPlayerDialog( playerid, d_help + 2, DIALOG_STYLE_MSGBOX, "������� �������", g_big_string, "�����", "" );
		}
		
		case d_help + 1: 
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_help, DIALOG_STYLE_LIST, "������� �������", d_help_command, "�������", "�������" );
			}
			
			switch( listitem )
			{
				case 0:
				{
					clean:<g_big_string>;
			
					for( new i; i < sizeof help_command; i++ )
					{
						if( help_command[i][help_index] == 6 && !help_command[i][help_member] )
						{
							format:g_small_string( ""cBLUE"%s"cWHITE" - %s\n", help_command[i][help_text], help_command[i][help_descript] );
							strcat( g_big_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_help + 3, DIALOG_STYLE_MSGBOX, "������� �������", g_big_string, "�����", "" );
				}
				
				case 1:
				{
					if( !Player[playerid][uMember] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� �������� � ��������������� �����������." );
						return showPlayerDialog( playerid, d_help + 1, DIALOG_STYLE_LIST, "��������������� �����������", "�����\n�������������", "�������", "�����" );
					}
					
					clean:<g_big_string>;
					
					new
						amount;
			
					for( new i; i < sizeof help_command; i++ )
					{
						if( help_command[i][help_index] == 6 && Player[playerid][uMember] == help_command[i][help_member] )
						{
							format:g_small_string( ""cBLUE"%s"cWHITE" - %s\n", help_command[i][help_text], help_command[i][help_descript] );
							strcat( g_big_string, g_small_string );
							
							amount++;
						}
					}
					
					if( !amount )
					{
						SendClient:( playerid, C_WHITE, !""gbError"��� ����� ����������� ��� �������������� ������." );
						return showPlayerDialog( playerid, d_help + 1, DIALOG_STYLE_LIST, "��������������� �����������", "�����\n�������������", "�������", "�����" );
					}
					
					showPlayerDialog( playerid, d_help + 3, DIALOG_STYLE_MSGBOX, "������� �������", g_big_string, "�����", "" );
				}
			}
		}
		
		case d_help + 2:
		{
			showPlayerDialog( playerid, d_help, DIALOG_STYLE_LIST, "������� �������", d_help_command, "�������", "�������" );
		}
		
		case d_help + 3:
		{
			showPlayerDialog( playerid, d_help + 1, DIALOG_STYLE_LIST, "��������������� �����������", "�����\n������� �����������", "�������", "�����" );
		}	
		
		case d_help + 5:
		{
			if( !response ) return 1;
			
			new
				text[ 1256 ];
			
			clean:<g_big_string>;
			
			strcat( g_big_string, help_spawn[ listitem ][ help_dialog ] );
			strcat( g_big_string, "\n" );
			
			strunpack( text, help_spawn[ listitem ][help_text], 1256 );
			strcat( g_big_string, text );
			
			showPlayerDialog( playerid, d_help + 6, DIALOG_STYLE_MSGBOX, "������", g_big_string, "�����", "" );
		}
		
		case d_help + 6:
		{
			clean:<g_string>;
		
			for( new i; i < sizeof help_spawn; i++ )
			{
				strcat( g_string, help_spawn[i][ help_dialog ] );
			}
			
			showPlayerDialog( playerid, d_help + 5, DIALOG_STYLE_LIST, "������", g_string, "�������", "�������" );
		}
		
		case d_help + 7:
		{
			showPlayerDialog( playerid, d_help + 8, DIALOG_STYLE_LIST, "������", d_help_info, "�������", "�������" );
		}
		
		case d_help + 8:
		{
			if( !response ) return 1;
			
			if( listitem == 3 )
			{
				SetPVarInt( playerid, "Help:Index", listitem );
				return showPlayerDialog( playerid, d_help + 10, DIALOG_STYLE_LIST, "������: ������", d_help_job, "�������", "�����" );
			}
			else if( listitem == 4 )
			{
				SetPVarInt( playerid, "Help:Index", listitem );
				return showPlayerDialog( playerid, d_help + 12, DIALOG_STYLE_LIST, "������: ���������", d_help_property, "�������", "�����" );
			}
			
			for( new i; i < sizeof help_info; i++ )
			{
				if( help_info[i][help_dialog] == listitem )
				{
					strunpack( g_big_string, help_info[i][help_text] );
					break;
				}
			}
			
			showPlayerDialog( playerid, d_help + 9, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
		}
		
		case d_help + 9:
		{
			showPlayerDialog( playerid, d_help + 8, DIALOG_STYLE_LIST, "������", d_help_info, "�������", "�������" );
		}
		
		case d_help + 10:
		{
			if( !response )
			{
				DeletePVar( playerid, "Help:Index" );
				return showPlayerDialog( playerid, d_help + 8, DIALOG_STYLE_LIST, "������", d_help_info, "�������", "�������" );
			}
				
			for( new i; i < sizeof help_info; i++ )
			{
				if( help_info[i][help_index] == listitem && help_info[i][help_dialog] == GetPVarInt( playerid, "Help:Index" ) )
				{
					strunpack( g_big_string, help_info[i][help_text] );
					break;
				}
			}
			
			showPlayerDialog( playerid, d_help + 11, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
		}
		
		case d_help + 11:
		{
			showPlayerDialog( playerid, d_help + 10, DIALOG_STYLE_LIST, "������: ������", d_help_job, "�������", "�����" );
		}
		
		case d_help + 12:
		{
			if( !response )
			{
				DeletePVar( playerid, "Help:Index" );
				return showPlayerDialog( playerid, d_help + 8, DIALOG_STYLE_LIST, "������", d_help_info, "�������", "�������" );
			}
				
			for( new i; i < sizeof help_info; i++ )
			{
				if( help_info[i][help_index] == listitem && help_info[i][help_dialog] == GetPVarInt( playerid, "Help:Index" ) )
				{
					strunpack( g_big_string, help_info[i][help_text] );
					break;
				}
			}
			
			showPlayerDialog( playerid, d_help + 13, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�����", "" );
		}
		
		case d_help + 13:
		{
			showPlayerDialog( playerid, d_help + 12, DIALOG_STYLE_LIST, "������: ���������", d_help_property, "�������", "�����" );
		}
	}
	return 1;
}

function Help_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED(KEY_CTRL_BACK) )
	{
		if( IsPlayerInRangeOfPoint( playerid, 1.5, 1517.8912, -1172.0548, 24.0781 ) || IsPlayerInRangeOfPoint( playerid, 1.5, 1465.6993, -1179.5114, 23.8256 ) )
		{
			clean:<g_string>;
		
			for( new i; i < sizeof help_spawn; i++ )
			{
				strcat( g_string, help_spawn[i][ help_dialog ] );
			}
			
			showPlayerDialog( playerid, d_help + 5, DIALOG_STYLE_LIST, "������", g_string, "�������", "�������" );
		}
	}

	return 1;
}