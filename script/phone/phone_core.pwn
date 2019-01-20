/*
 *	Developer: kirillezhov
 *	2016
*/


Phone_OnGameModeInit()
{
	Phone_TextDraws();

	for( new i; i < MAX_NETWORKS; i++ )
	{
		zone_network[i] = CreateDynamicSphere( action_network[i][0], action_network[i][1], action_network[i][2], action_network[i][3], 0, 0, -1 );
	}
	
	return 1;
}

stock IsPlayerInNetwork( playerid )
{
	if( GetPlayerVirtualWorld( playerid ) )
		return 2;
		
	for( new i; i < sizeof action_network; i++ )
	{
		if( IsPlayerInDynamicArea( playerid, zone_network[i] ) )
			return 1;
	}
	
	return 0;
}

function Phone_OnPlayerClickTextDraw( playerid, Text:clickedid ) 
{
	if( _:clickedid == INVALID_TEXT_DRAW )
	{
		if( GetPVarInt(playerid,"PlayerMenuShow") == 5 )
		{
			if( GetPVarInt( playerid, "Phone:Call" ) ) return 1;
			
			ShowPhone( playerid, false );
			return 1;
		}
	}
	else if( clickedid == phoneOne[23] || clickedid == phoneThree[10] )  //��������
	{
		OpenPhoneBook( playerid );
		return 1;
	}
	else if( clickedid == phoneOne[24] || clickedid == phoneThree[9] ) //���������
	{
		showPlayerDialog( playerid, d_phone + 9, DIALOG_STYLE_LIST, "���������", "\
			"cWHITE"�������� ���� ������\n\
			"cWHITE"�������� ������� ������\n\
			"cWHITE"��������� ��������� ����",
		"�������", "�������" );
		return 1;
	}
	else if( clickedid == phoneOne[25] || clickedid == phoneThree[12] ) //���������
	{
		showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "���������", "\
			"gbDialog"�������� ���������\n\
			"cWHITE"�������� ���������\n\
			"cWHITE"��������� ���������",
		"�������", "�������" );
		return 1;
	}
	else if( clickedid == phoneOne[26] || clickedid == phoneThree[11] ) //������� �����
	{
		if( !IsPlayerInNetwork( playerid ) )
		{
			SendClient:( playerid, C_WHITE, !NO_NETWORK );
			return 1;
		}
		
		showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
			"gbDialog"������� �����\n\
			"cWHITE"������ ��������� �����\n\
			������ ������\n\
			������ ���� �����",
		"�������", "�������" );
		return 1;
	}
	
	else if( clickedid == phoneOne[27] || clickedid == phoneThree[17] )  //��������� �������
	{
		showPlayerDialog( playerid, d_phone + 1, DIALOG_STYLE_MSGBOX, " ", "\
			"cWHITE"�� �������, ��� ������� ��������� �������?\n\n\
			"gbDialog"������ ������������ ���� �� ������ ��������� ��� �������� ��� ���������.",
		"��", "���" );
		return 1;
	}
		
	return 0;
}

ShowPhone( playerid, bool:status )
{
	if( !getItem( playerid, INV_PHONE, INVALID_PARAM ) && !GetUsePhone( playerid ) )
		return SendClient:( playerid, C_WHITE, ""gbError"� ��� ��� ��������." );
		
	if( !GetUsePhone( playerid ) )
		return SendClient:( playerid, C_WHITE, ""gbError"�������� ������� � �������� ���� ���������." );
			
	for( new i; i < MAX_PHONES; i++ )
	{
		if( GetPhoneNumber( playerid ) == Phone[playerid][i][p_number] )
		{
			SetPVarInt( playerid, "Phone:Select", i );
			break;
		}
	}
			
	new
		phone = GetPVarInt( playerid, "Phone:Select" );

	switch( status )
	{
		case true: //�������� �������
		{
			if( !Phone[playerid][phone][p_settings][0] )
				return showPlayerDialog( playerid, d_phone, DIALOG_STYLE_MSGBOX, " ", "\
					"gbDialog"������� ��������\n\n\
					"cWHITE"������� ��������?",
				"��", "���" );
				
			switch( GetUsePhone( playerid ) )
			{
				case 18874:
				{
					TextDrawShowForPlayer( playerid, phoneFonOne[Phone[playerid][phone][p_settings][1]] );
					
					for( new i = 1; i != 28; i++ ) 
						TextDrawShowForPlayer( playerid, phoneOne[i] );
				}
				
				case 18872:
				{
					TextDrawShowForPlayer( playerid, phoneFonThree[Phone[playerid][phone][p_settings][1]] );
					
					for( new i = 1; i != 19; i++ ) 
						TextDrawShowForPlayer( playerid, phoneThree[i] );
				}
			}
			
			
			new 
				y, m, d;
				
			getdate( y, m, d );
			
			format:g_small_string( "%02d/%02d/%d", d, m, y );
			TextDrawSetString( phoneThree[7], g_small_string );
			TextDrawSetString( phoneOne[22], g_small_string );
				
			SetPVarInt( playerid, "PlayerMenuShow", 5 );
			SelectTextDraw( playerid, 0xd3d3d3FF );
				
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_USECELLPHONE );
			SetPlayerAttachedObject( playerid, 5, GetUsePhone( playerid ), 6, 0.107999, 0.015000, -0.016000, 97.100006, -165.800048, -3.000013 );
			
			format:g_small_string( "������%s������� �������", Player[playerid][uSex] == 1 ? (" "):("� ") );
			MeAction( playerid, g_small_string, 1 );
			
			SendClient:( playerid, C_WHITE, ""gbDefault"������� "cBLUE"ESC"cWHITE", ����� ������ ������� � ������." );
		}
		
		case false:	//������ �������
		{
			switch( GetUsePhone( playerid ) )
			{
				case 18874:
				{
					TextDrawHideForPlayer( playerid, phoneFonOne[Phone[playerid][phone][p_settings][1]] );
					
					for( new i = 1; i != 28; i++ ) 
						TextDrawHideForPlayer( playerid, phoneOne[i] );
				}
				
				case 18872:
				{
					TextDrawHideForPlayer( playerid, phoneFonThree[Phone[playerid][phone][p_settings][1]] );
					
					for( new i = 1; i != 19; i++	) 
						TextDrawHideForPlayer( playerid, phoneThree[i] );
				}
			}
		
			DeletePVar( playerid, "PlayerMenuShow" );
			DeletePVar( playerid, "Phone:Select" );
			
			CancelSelectTextDraw( playerid );
			
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_STOPUSECELLPHONE );
			RemovePlayerAttachedObject( playerid, 5 );
			
			format:g_small_string( "�����%s������� �������", Player[playerid][uSex] == 1 ? (" "):("� ") );
			MeAction( playerid, g_small_string, 1 );
		}
	}
	
	return 1;
}

stock GetUsePhone( playerid ) // ����������, ������������ �� �������
{
	new
		id;
		
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		id = getInventoryId( UseInv[playerid][i][inv_id] );
	
		if( inventory[id][i_type] == INV_PHONE ) 			// ���� � �������� ����� �������
			return UseInv[playerid][i][inv_param_1];		// ���������� �������� �������
	}
	
	return 0;
}

stock GetPhoneNumber( playerid ) // �������� ����� ������������� ��������	
{
	new
		id;
		
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		id = getInventoryId( UseInv[playerid][i][inv_id] );
	
		if( inventory[id][i_type] == INV_PHONE ) 			// ���� � �������� ����� �������
			return UseInv[playerid][i][inv_param_2];		// ���������� ����� ��������
	}
	
	return 0;
}

CreatePhone( playerid, number )
{
	for( new i; i < MAX_PHONES; i++ )
	{
		if( !Phone[playerid][i][p_id] )
		{
			Phone[playerid][i][p_user_id] = Player[playerid][uID];
			Phone[playerid][i][p_number] = number;
			
			Phone[playerid][i][p_settings][0] = 
			Phone[playerid][i][p_settings][1] =
			Phone[playerid][i][p_settings][2] =
			Phone[playerid][i][p_settings][3] = 0;
			
			mysql_format:g_small_string( "INSERT INTO `"DB_PHONES"` \
				( `p_user_id`, `p_number` ) VALUES \
				( '%d', '%d' )",
				Phone[playerid][i][p_user_id],
				Phone[playerid][i][p_number]
			);
			
			mysql_tquery( mysql, g_small_string, "InsertPhone", "dd", playerid, i );
			break;
		}
	}
	return 1;
}

function InsertPhone( playerid, i )
{
	Phone[playerid][i][p_id] = cache_insert_id();
	return 1;
}

function LoadPhones( playerid )
{
	new
		rows = cache_get_row_count();
		
	if( rows )
	{
		for( new i; i < rows; i++ )
		{
			if( !Phone[playerid][i][p_id] )
			{
				Phone[playerid][i][p_id] = cache_get_field_content_int( i, "p_id", mysql );
				Phone[playerid][i][p_user_id] = cache_get_field_content_int( i, "p_user_id", mysql );
				Phone[playerid][i][p_number] = cache_get_field_content_int( i, "p_number", mysql );
				
				clean:<g_small_string>;
				cache_get_field_content( i, "p_settings", g_small_string, mysql, 128 );
				sscanf( g_small_string,"p<|>a<d>[4]", Phone[playerid][i][p_settings] );
			}
		}
	}
		
	return 1;
}

function LoadContacts( playerid )
{
	new
		rows = cache_get_row_count();
	
	if( rows )
	{
		for( new i; i < rows; i++ )
		{
			PhoneContacts[playerid][i][p_id] = cache_get_field_content_int( i, "p_id", mysql );
			PhoneContacts[playerid][i][p_owner] = cache_get_field_content_int( i, "p_owner", mysql );
			PhoneContacts[playerid][i][p_number] = cache_get_field_content_int( i, "p_number", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "p_name", g_small_string, mysql );
			strmid( PhoneContacts[playerid][i][p_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
	}
	
	return 1;
}

function LoadMessages( playerid )
{
	new
		rows = cache_get_row_count();
	
	if( rows )
	{
		for( new i; i < rows; i++ )
		{
			if( !Messages[playerid][i][m_id] )
			{
				Messages[playerid][i][m_id] = cache_get_field_content_int( i, "m_id", mysql );
				Messages[playerid][i][m_number] = cache_get_field_content_int( i, "m_number", mysql );
				Messages[playerid][i][m_numberto] = cache_get_field_content_int( i, "m_numberto", mysql );
				Messages[playerid][i][m_read] = cache_get_field_content_int( i, "m_read", mysql );
				Messages[playerid][i][m_date] = cache_get_field_content_int( i, "m_date", mysql );
				
				clean:<g_string>;
				cache_get_field_content( i, "m_text", g_string, mysql );
				strmid( Messages[playerid][i][m_text], g_string, 0, strlen( g_string ), sizeof g_string );
			}
		}
	}
	
	return 1;
}

function CheckNumber( playerid )
{
	new
		rows = cache_get_row_count();
		
	if( rows ) IsValidPhone{playerid} = 1;
	else IsValidPhone{playerid} = 0;
	
	return 1;
}

stock UpdatePhoneSettings( field, value[] )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_PHONES"` SET `p_settings` = '%d|%d|%d|%d' WHERE `p_number` = %d",
		value[0],
		value[1],
		value[2],
		value[3],
		field
	);
	
	return mysql_tquery( mysql, g_string );
}

stock UpdateUserPhone( value, field )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_PHONES"` SET `p_user_id` = '%d' WHERE `p_number` = %d",
		value,
		field
	);
	
	return mysql_tquery( mysql, g_string );
}

DeletePhone( playerid, number )
{
	mysql_format:g_string( "DELETE FROM "DB_PHONES" WHERE p_number = '%d'",
		number
	);
	mysql_tquery( mysql, g_string );
	
	mysql_format:g_string( "DELETE FROM "DB_PHONES_CONTACTS" WHERE p_owner = '%d'",
		number
	);
	mysql_tquery( mysql, g_string );
	
	mysql_format:g_string( "DELETE FROM "DB_PHONES_MESSAGES" WHERE m_number = '%d' OR m_numberto = '%d' ",
		number, number
	);
	mysql_tquery( mysql, g_string );
	
	ClearPhoneNumber( playerid, number );
	
	return 1;
}


stock ClearPhoneNumber( playerid, number )
{
	for( new i; i < MAX_PHONES; i++ )
	{
		if( Phone[playerid][i][p_number] == number )
		{
			Phone[playerid][i][p_id] = 
			Phone[playerid][i][p_user_id] = 
			Phone[playerid][i][p_number] = 
			Phone[playerid][i][p_settings][0] = 
			Phone[playerid][i][p_settings][1] = 
			Phone[playerid][i][p_settings][2] = 
			Phone[playerid][i][p_settings][3] = 0;
			break;
		}
	}
	
	for( new j; j < MAX_CONTACTS; j++ )
	{
		if( PhoneContacts[playerid][j][p_owner] == number )
		{	
			PhoneContacts[playerid][j][p_id] =
			PhoneContacts[playerid][j][p_owner] = 
			PhoneContacts[playerid][j][p_number] = 0;
			
			PhoneContacts[playerid][j][p_name][0] = EOS;
		}
	}
	
	for( new k; k < MAX_MESSAGES; k++ )
	{
		if( Messages[playerid][k][m_number] == number || Messages[playerid][k][m_numberto] == number )
		{
			Messages[playerid][k][m_id] =
			Messages[playerid][k][m_number] =
			Messages[playerid][k][m_numberto] =
			Messages[playerid][k][m_read] =
			Messages[playerid][k][m_date] = 0;
			
			Messages[playerid][k][m_text][0] = EOS;
		}
	}
	
	return 1;
}

LoadPhoneData( playerid, number )
{
	CleanPhoneData( playerid );
		
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PHONES " WHERE p_number = %d LIMIT 1", number );
	mysql_tquery( mysql, g_string, "LoadPhones", "d", playerid );	
		
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PHONES_CONTACTS " WHERE p_owner = %d ORDER BY `p_id`", number );
	mysql_tquery( mysql, g_string, "LoadContacts", "d", playerid );
			
	clean:<g_string>;
	mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PHONES_MESSAGES " WHERE m_number = %d OR m_numberto = %d ORDER BY `m_id`", number, number );
	mysql_tquery( mysql, g_string, "LoadMessages", "d", playerid );

	return 1;
}

OpenPhoneBook( playerid )
{
	new 
		count;
		
	clean:<g_big_string>;
	strcat( g_big_string, ""gbDialog"�������� �������" );
	
	for( new i; i < MAX_CONTACTS; i++ )
	{
		if( PhoneContacts[playerid][i][p_owner] )
		{
			format:g_small_string( "\n"cBLUE"%d."cWHITE" %d\t"cBLUE"%s", 
				count + 1, 
				PhoneContacts[playerid][i][p_number], 
				PhoneContacts[playerid][i][p_name] 
			);
			
			strcat( g_big_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			
			count++;
		}
	}
	
	showPlayerDialog( playerid, d_phone + 2, DIALOG_STYLE_LIST, "���������� �����", g_big_string, "�������", "�������" );
	
	return 1;
}

CreateMessage( playerid, sendid, number, numberto, text[] )
{
	for( new i; i < MAX_MESSAGES; i++ )
	{
		if( !Messages[playerid][i][m_id] )
		{
			Messages[playerid][i][m_number] = number;
			Messages[playerid][i][m_numberto] = numberto;
			Messages[playerid][i][m_read] = 0;
			
			Messages[playerid][i][m_date] = gettime();
			
			GetEditText( text, Messages[playerid][i][m_text] );
			
			mysql_format:g_string( "INSERT INTO `"DB_PHONES_MESSAGES"` \
				( `m_number`, `m_numberto`, `m_date`, `m_text` ) VALUES \
				( '%d', '%d', '%d', '%e' )",
				Messages[playerid][i][m_number],
				Messages[playerid][i][m_numberto],
				Messages[playerid][i][m_date],
				Messages[playerid][i][m_text]
			);
			
			mysql_tquery( mysql, g_string, "InsertMessage", "dd", playerid, i );
			break;
		}
	}
	
	if( sendid != INVALID_PARAM )
	{
		for( new i; i < MAX_MESSAGES; i++ )
		{
			if( !Messages[sendid][i][m_id] )
			{
				Messages[sendid][i][m_number] = number;
				Messages[sendid][i][m_numberto] = numberto;
				Messages[sendid][i][m_read] = 0;
				
				Messages[sendid][i][m_date] = gettime();
				
				GetEditText( text, Messages[sendid][i][m_text] );
				
				break;
			}
		}
	}
	
	return 1;
}

function InsertMessage( playerid, i )
{
	Messages[playerid][i][m_id] = cache_insert_id();
	return 1;
}

CreateContact( playerid, name[] )
{
	for( new i; i < MAX_CONTACTS; i++ )
	{
		if( !PhoneContacts[playerid][i][p_id] )
		{
			PhoneContacts[playerid][i][p_owner] = GetPhoneNumber( playerid );
			PhoneContacts[playerid][i][p_number] = GetPVarInt( playerid, "Phone:Number" );
			
			PhoneContacts[playerid][i][p_name][0] = EOS;
			strcat( PhoneContacts[playerid][i][p_name], name, 25 );
			
			mysql_format:g_small_string( "INSERT INTO `"DB_PHONES_CONTACTS"` \
				( `p_owner`, `p_number`, `p_name` ) VALUES \
				( '%d', '%d', '%e' )",
				PhoneContacts[playerid][i][p_owner],
				PhoneContacts[playerid][i][p_number],
				PhoneContacts[playerid][i][p_name]
			);
			
			mysql_tquery( mysql, g_small_string, "InsertContact", "dd", playerid, i );
			
			break;
		}
	}
	
	DeletePVar( playerid, "Phone:Number" );
	
	return 1;
}

function InsertContact( playerid, i )
{
	PhoneContacts[playerid][i][p_id] = cache_insert_id();
	return 1;
}

UpdateContact( playerid, contact, value[] )
{			
	PhoneContacts[playerid][contact][p_number] = GetPVarInt( playerid, "Phone:Number" );
	
	if( strcmp( PhoneContacts[playerid][contact][p_name], value, true ) )
	{
		PhoneContacts[playerid][contact][p_name][0] = EOS;
		strcat( PhoneContacts[playerid][contact][p_name], value, 25 );
	}
	
	mysql_format:g_string( "UPDATE `"DB_PHONES_CONTACTS"` \
		SET `p_number` = '%d', \
			`p_name` = '%e' \
		WHERE `p_id` = '%d' LIMIT 1",
		PhoneContacts[playerid][contact][p_number],
		PhoneContacts[playerid][contact][p_name],
		PhoneContacts[playerid][contact][p_id]
	);		
	
	mysql_tquery( mysql, g_string );
	
	DeletePVar( playerid, "Phone:Number" );
	return 1;
}

DeleteContact( playerid, contact )
{
	mysql_format:g_string( "DELETE FROM "DB_PHONES_CONTACTS" WHERE p_number = '%d'",
		PhoneContacts[playerid][contact][p_number]
	);
	
	mysql_tquery( mysql, g_string );
	
	PhoneContacts[playerid][contact][p_id] = 
	PhoneContacts[playerid][contact][p_owner] = 
	PhoneContacts[playerid][contact][p_number] = 0;
	
	PhoneContacts[playerid][contact][p_name][0] = EOS;
	
	return 1;
}

DeleteMessage( playerid, message )
{
	mysql_format:g_string( "DELETE FROM "DB_PHONES_MESSAGES" WHERE m_id = '%d' LIMIT 1",
		Messages[playerid][message][m_id]
	);
	
	mysql_tquery( mysql, g_string );
	
	Messages[playerid][message][m_id] = 
	Messages[playerid][message][m_numberto] =
 	Messages[playerid][message][m_number] =
	Messages[playerid][message][m_read] =
	Messages[playerid][message][m_date] = 0;
	
	Messages[playerid][message][m_text][0] = EOS;

	DeletePVar( playerid, "Phone:Message" );
	return 1;
}

CheckNumberNetwork( playerid, number ) //�������� ����������� ������ �� �����������
{
	foreach(new i : Player)
	{
		if( !IsLogged( i ) )
			continue;
	
		if( i == playerid )
			continue;
		
		for( new j; j < MAX_PHONES; j++ )
		{
			if( Phone[i][j][p_number] == number &&  GetPhoneNumber( i ) == number )
			{
				if( !IsPlayerInNetwork( i ) )
					return SendClient:( playerid, C_WHITE, ""gbError"������� ��������� ��� ���� �������� ����." ), 0;
			
				if( Phone[i][j][p_settings][0] )
				{
					Call[playerid][c_sound] = Phone[i][j][p_settings][2];
					Call[playerid][c_call_id] = i;
					return 1;
				}
				else
					return SendClient:( playerid, C_WHITE, ""gbError"������� �������� ��������." ), 0;
			}
		}
	}

	return SendClient:( playerid, C_WHITE, ""gbError"������ ����� �� ��������������� � ���� SA:Telecom." ), 0;
}



CheckIncomingNumber( playerid, number ) //��������, ������� �� ����� � ���������� ����� �������� ��������� �����
{
	new
		bool:status = false;
	
	for( new j; j < MAX_CONTACTS; j++ )
	{
		if( PhoneContacts[playerid][j][p_number] == number )
		{
			Call[playerid][c_name][0] = EOS;
			strcat( Call[playerid][c_name], PhoneContacts[playerid][j][p_name], 25 );
			
			status = true;
			break;
		}
	}
	
	if( !status ) return 0;
	
	return 1;
}

function Phone_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED( KEY_YES ) )
	{
		if( Call[playerid][c_status] && !Call[playerid][c_accept] )
		{
			new
				callid = Call[playerid][c_call_id];
				
			PlayerPlaySound( playerid, 0, 0.0, 0.0, 0.0 );
				
			Call[playerid][c_accept] = 
			Call[callid][c_accept] = true;
				
			SendClient:( callid, C_WHITE, ""gbDialog"������� ������� �� ��� �����. ������� "cBLUE"H"cGRAY", ����� ��������� ��������." );
			SendClient:( playerid, C_WHITE, ""gbDialog"�� �������� �� �����. ������� "cBLUE"H"cGRAY", ����� ��������� ��������." );
			
			PhoneStatus( playerid, true );
			
			Call[playerid][c_status] = false;
		}
	}
		
	if( PRESSED( KEY_NO ) )
	{
		if( Call[playerid][c_status] )
		{
			new
				callid = Call[playerid][c_call_id];
			
			PlayerPlaySound( playerid, 0, 0.0, 0.0, 0.0 );
			
			SendClient:( playerid, C_WHITE, ""gbDialog"�� �������� �����." );
			SendClient:( callid, C_WHITE, ""gbDialog"������� ������� �����." );
			
			Call[playerid][c_status] = false;
			
			Call[callid][c_call_id] = 
			Call[playerid][c_call_id] = 0;	
			
			DeletePVar( playerid, "Phone:Call" );
			DeletePVar( callid, "Phone:Call" );
			
			PhoneStatus( callid, false );
		}
		
		if( GetPVarInt( playerid, "San:Call" ) == 2 )
		{
			if( ETHER_STATUS != INVALID_PARAM )
			{
				pformat:( "[���� %s] %s �������� �������� �����.", Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName] );
				psend:( ETHER_STATUS, C_LIGHTGREEN );
			}
			
			ETHER_CALLID = INVALID_PARAM;
			SendClient:( playerid, C_WHITE, !""gbDefault"�� ��������� ��������� �����." );
			
			DeletePVar( playerid, "San:Call" );
			PhoneStatus( playerid, false );
		}
	}
	
	if( PRESSED( KEY_CTRL_BACK ) )
	{
		if( !Call[playerid][c_accept] && GetPVarInt( playerid, "Phone:Call" ) )
		{
			new
				callid = Call[playerid][c_call_id];
			
			SendClient:( playerid, C_WHITE, ""gbDialog"�� �������� �����." );
			SendClient:( callid, C_WHITE, ""gbDialog"������� ������� �����." );
			
			Call[callid][c_status] = false;
			
			Call[callid][c_call_id] = 
			Call[playerid][c_call_id] = 0;	
			
			DeletePVar( playerid, "Phone:Call" );
			DeletePVar( callid, "Phone:Call" );
			
			PlayerPlaySound( callid, 0, 0.0, 0.0, 0.0 );
			PlayerPlaySound( playerid, 0, 0.0, 0.0, 0.0 );
			
			PhoneStatus( playerid, false );
		}
		
		if( Call[playerid][c_accept] )
		{
			new
				callid = Call[playerid][c_call_id];
				
			SendClient:( playerid, C_WHITE, ""gbDialog"�� ��������� �����." );
			SendClient:( callid, C_WHITE, ""gbDialog"������� �������� �����." );

			Call[callid][c_call_id] = 
			Call[playerid][c_call_id] = 0;
			
			Call[callid][c_accept] =
			Call[playerid][c_accept] = 
			Call[callid][c_status] =
			Call[playerid][c_status] = false;
			
			DeletePVar( playerid, "Phone:Call" );
			DeletePVar( callid, "Phone:Call" );
			
			PhoneStatus( callid, false );
			PhoneStatus( playerid, false );
		}
		
		if( GetPVarInt( playerid, "San:Call" ) == 1 )
		{
			if( ETHER_STATUS != INVALID_PARAM )
			{
				pformat:( "[���� %s] %s �������� �������� �����.", Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName] );
				psend:( ETHER_STATUS, C_LIGHTGREEN );
			}
			
			ETHER_CALLID = INVALID_PARAM;
			SendClient:( playerid, C_WHITE, !""gbDefault"�� ��������� ��������� �����." );
			
			DeletePVar( playerid, "San:Call" );
			PhoneStatus( playerid, false );
		}
	}
	
	return 1;
}

stock PhoneStatus( playerid, bool:status ) 
{
	
	if( status )
	{
		if( GetPVarInt( playerid, "PlayerMenuShow" ) == 5 ) CancelSelectTextDraw( playerid );
		else 
		{
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_USECELLPHONE );
			SetPlayerAttachedObject( playerid, 5, GetUsePhone( playerid ), 6, 0.107999, 0.015000, -0.016000, 97.100006, -165.800048, -3.000013 );
			
			format:g_small_string( "������%s ������� �������", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
		}
	}
	else
	{
		if( GetPVarInt( playerid, "PlayerMenuShow" ) == 5 ) SelectTextDraw( playerid, 0xd3d3d3FF );
		else 
		{
			SetPlayerSpecialAction( playerid, SPECIAL_ACTION_STOPUSECELLPHONE );
			RemovePlayerAttachedObject( playerid, 5 );
			
			format:g_small_string( "�����%s ������� �������", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
		}
	}
}

ShowListSound( playerid )
{
	clean:<g_string>;
	
	for( new i; i < sizeof call_sound; i++ )
	{
		format:g_small_string( "%s\n", call_sound[i][s_name] );
		strcat( g_string, g_small_string );
	}
	
	showPlayerDialog( playerid, d_phone + 11, DIALOG_STYLE_LIST, "����� �������", g_string, "�������", "�����" );
	return 1;
}

GetNetwork( playerid ) //���������� ��������� �����
{
	new
		Float:pos[ MAX_NETWORKS ],
		Float:maximum,
		number;

	for( new i; i < MAX_NETWORKS; i++ )
	{
		if( IsPlayerInDynamicArea( playerid, zone_network[i] ) )
		{
			pos[i] = GetPlayerDistanceFromPoint( playerid, action_network[i][0], action_network[i][1], action_network[i][2] );
		}
	}
	
	for( new i; i < MAX_NETWORKS; i++ )
	{
		if( pos[i] > maximum )
		{
			maximum = pos[i];
			number = i;
		}
	}
	
	return number;
}

ShowIncomingList( playerid )
{
	clean:<g_big_string>;
	
	new
		name[25],
		count;
	
	strcat( g_big_string, "����������\t����\n" );
	
	for( new i; i < MAX_MESSAGES; i++ )
	{
		if( Messages[playerid][i][m_id] && Messages[playerid][i][m_number] == GetPhoneNumber( playerid ) )
		{
			CleanDate;
			gmtime( Messages[playerid][i][m_date], _, g_month, g_day, g_hour, g_minute );
			
			if( CheckNumberInPhone( playerid, Messages[playerid][i][m_numberto], name ) )
			{
				format:g_small_string( "\
					"cBLUE"%s\t"cWHITE"%02d.%02d %02d:%02d\n", 
					name, 
					g_day, g_month, g_hour, g_minute 
				);
			}
			else
				format:g_small_string( "\
					"cBLUE"%d\t"cWHITE"%02d.%02d %02d:%02d\n", 
					Messages[playerid][i][m_numberto], 
					g_day, g_month, g_hour, g_minute  
				);
			
			strcat( g_big_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			count++;
		}
	}

	if( !count ) 
	{
		SendClient:( playerid, C_WHITE, ""gbError"� ��� ��� ��������� ���������." );
		
		return showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "���������", "\
			"gbDialog"�������� ���������\n\
			"cWHITE"�������� ���������\n\
			"cWHITE"��������� ���������",
		"�������", "�������" );
	}
	
	showPlayerDialog( playerid, d_phone + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "�������", "�����" );
	return 1;
}

ShowComingList( playerid )
{
	clean:<g_big_string>;
	
	new
		name[25],
		count;
	
	strcat( g_big_string, "�����������\t����\t������\n" );
	
	for( new i; i < MAX_MESSAGES; i++ )
	{
		if( Messages[playerid][i][m_id] && Messages[playerid][i][m_numberto] == GetPhoneNumber( playerid ) )
		{
			if( CheckNumberInPhone( playerid, Messages[playerid][i][m_number], name ) )
			{
				CleanDate;
				gmtime( Messages[playerid][i][m_date], _, g_month, g_day, g_hour, g_minute );
			
				format:g_small_string("\
					"cBLUE"%s\t"cWHITE"%02d.%02d %02d:%02d\t%s\n", 
					name, 
					g_day, g_month, g_hour, g_minute,
					!Messages[playerid][i][m_read] ? ("�����") : (" ") 
				);
			}
			else
				format:g_small_string("\
					"cBLUE"%d\t"cWHITE"%02d.%02d %02d:%02d\t%s\n", 
					Messages[playerid][i][m_numberto], 
					g_day, g_month, g_hour, g_minute, 
					!Messages[playerid][i][m_read] ? ("�����") : (" ")
				);
			
			strcat( g_big_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			count++;
		}
	}

	if( !count ) 
	{
		SendClient:( playerid, C_WHITE, ""gbError"� ��� ��� �������� ���������." );
		
		return showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "���������", "\
			"gbDialog"�������� ���������\n\
			"cWHITE"�������� ���������\n\
			"cWHITE"��������� ���������",
		"�������", "�������" );
	}
	
	showPlayerDialog( playerid, d_phone + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "�������", "�����" );
	return 1;
}

ShowIncomingMessage( playerid, message )
{
	new
		name[25];
		
	CleanDate;
	gmtime( Messages[playerid][message][m_date], _, g_month, g_day, g_hour, g_minute, _ );	
		
	if( CheckNumberInPhone( playerid, Messages[playerid][message][m_numberto], name ) )
		format:g_string( "\
			"cBLUE"��������� ���������\n\n\
			"cGRAY"����: "cWHITE"%s\n\
			"cGRAY"�����: "cWHITE"%02d.%02d %02d:%02d\n\n\
			"cGRAY"�����:\n\
			"cWHITE"%s",
			name,
			g_day, g_month, g_hour, g_minute,
			Messages[playerid][message][m_text] 
		);	
	else
		format:g_string( "\
			"cBLUE"��������� ���������\n\n\
			"cGRAY"����: "cWHITE"%d\n\
			"cGRAY"�����: "cWHITE"%02d.%02d %02d:%02d\n\n\
			"cGRAY"�����:\n\
			"cWHITE"%s",
			Messages[playerid][message][m_numberto],
			g_day, g_month, g_hour, g_minute,
			Messages[playerid][message][m_text] 
		);
	
	
	showPlayerDialog( playerid, d_phone + 17, DIALOG_STYLE_MSGBOX, " ", g_string, "�������", "�����" );
	return 1;
}

ShowComingMessage( playerid, message )
{
	new
		name[25];
	
	CleanDate;
	gmtime( Messages[playerid][message][m_date], _, g_month, g_day, g_hour, g_minute, _ );	
		
	if( CheckNumberInPhone( playerid, Messages[playerid][message][m_number], name ) )
		format:g_string( "\
			"cBLUE"�������� ���������\n\n\
			"cGRAY"�� ����: "cWHITE"%s\n\
			"cGRAY"�����: "cWHITE"%02d.%02d %02d:%02d\n\n\
			"cGRAY"�����:\n\
			"cWHITE"%s",
			name,
			g_day, g_month, g_hour, g_minute,
			Messages[playerid][message][m_text] 
		);	
	else
		format:g_string( "\
			"cBLUE"�������� ���������\n\n\
			"cGRAY"�� ����: "cWHITE"%d\n\
			"cGRAY"�����: "cWHITE"%02d.%02d %02d:%02d\n\n\
			"cGRAY"�����:\n\
			"cWHITE"%s",
			Messages[playerid][message][m_number],
			g_day, g_month, g_hour, g_minute,
			Messages[playerid][message][m_text] 
		);
	
	if( !Messages[playerid][message][m_read] )
	{
		Messages[playerid][message][m_read] = 1;
			
		mysql_format:g_small_string( "UPDATE `"DB_PHONES_MESSAGES"` \
			SET `m_read` = '%d' \
			WHERE `m_id` = '%d' LIMIT 1",
			Messages[playerid][message][m_read],
			Messages[playerid][message][m_id]
		);		
		
		mysql_tquery( mysql, g_small_string );
	}
	
	showPlayerDialog( playerid, d_phone + 19, DIALOG_STYLE_MSGBOX, " ", g_string, "�������", "�����" );
	return 1;
}

CheckNumberInPhone( playerid, number, name[] ) //��������, ���� �� � ���������� ����� ����� �����
{
	name[0] = EOS;
	
	for( new i; i < MAX_CONTACTS; i++ )
	{
		if( PhoneContacts[playerid][i][p_number] == number )
		{
			strcat( name, PhoneContacts[playerid][i][p_name], 25 );
			return 1;
		}
	}
	
	return 0;
}

SendMessage( playerid, number )
{
	new
		bool:flag = false;
		
	foreach(new i : Player)
	{
		if( !IsLogged( i ) )
			continue;
			
		if( i == playerid )
			continue;
		
		for( new j; j < MAX_PHONES; j++ )
		{
			if( GetPhoneNumber( i ) == number )
			{
				for( new m; m < MAX_MESSAGES; m++ )
				{
					if( !Messages[i][m][m_id] )
					{
						if( !IsPlayerInNetwork( i ) )
							return SendClient:( playerid, C_WHITE, ""gbError"��������� �� ����������. ������� ���������� ��� ���� �������� ����." ), 0;
						
						SetPVarInt( playerid, "Phone:Playerid", i + 1 );
						
						if( !Phone[i][j][p_settings][0] )
						{
							flag = true;
							return 1;
						}
						
						SendClient:( i, C_WHITE, ""gbSuccess"� ��� ����� ���������." );
						
						if( Phone[i][j][p_settings][2] )
							PlayerPlaySound( i, 5201, 0.0, 0.0, 0.0 );
						
						flag = true;
						return 1;
					}
				}
				
				if( !flag )
					return SendClient:( playerid, C_WHITE, ""gbError"��������� �� ����������. � �������� ������������ ������." ), 0;
			}
		}
	}

	return 1;
}

PhoneTimer( playerid )
{
	new
		hour,
		minute,
		second;
		
	gettime( hour, minute, second );
	
	for( new i; i < MAX_MESSAGES; i++ )
	{
		if( Messages[playerid][i][m_numberto] == GetPhoneNumber( playerid ) && !Messages[playerid][i][m_read] && GetUsePhone( playerid ) )
		{
			SendClient:( playerid, C_WHITE, ""gbSuccess"� ��� ���� ������������� ���������." );
			//PlayerPlaySound( playerid, 5201, 0.0, 0.0, 0.0 );
			break;
		}
	}
	
	//��������� ����� �� ��������
	format:g_small_string( "%02d:%02d", hour, minute );
	TextDrawSetString( phoneOne[16], g_small_string );
    TextDrawSetString( phoneThree[5], g_small_string );
	
	return 1;
}

CleanPhoneData( playerid )
{
	for( new i; i < MAX_CONTACTS; i++ )
	{
		if( PhoneContacts[playerid][i][p_id] )
		{
			PhoneContacts[playerid][i][p_id] = 
			PhoneContacts[playerid][i][p_owner] = 
			PhoneContacts[playerid][i][p_number] = 0;
			
			PhoneContacts[playerid][i][p_name][0] = EOS;
		}
	}
	
	return 1;
}

stock ClearPlayerPVarData( playerid )
{
	SetPVarInt( playerid, "Phone:Call", 0 );
	SetPVarInt( playerid, "Phone:Select", 0 );
	SetPVarInt( playerid, "Phone:Number", 0 );
	SetPVarInt( playerid, "Phone:Playerid", 0 );
	SetPVarInt( playerid, "Phone:Fraction", 0 );
	SetPVarInt( playerid, "Phone:Sound", 0 );
	SetPVarInt( playerid, "Phone:Incoming", 0 );
	SetPVarInt( playerid, "San:Call", 0 );
	SetPVarInt( playerid, "San:AdvertId", 0 );

	return 1;
}