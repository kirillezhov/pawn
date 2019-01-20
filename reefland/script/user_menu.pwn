/*
	0 - ����������� ����������
	1 - ��������� ������
	2 - ����������� ������
	3 - ����������� �����
	4 - ����������� ����������
	5 - �������� �������������
	6 - �������
	7 - ����������� �����
	8 - ����������� �����
	9 - ������ ������� �������
	10 - ����������� ���������� �������
*/

stock ShowSettings( playerid ) 
{
	new 
		spawn	[ 32 ],
		walk	[ 32 ],
		talk	[ 32 ],
		style	[ 32 ];

	switch( Player[playerid][uSettings][1] )
	{
	    case 0: spawn = ""cBLUE"�����";
	    case 1: spawn = ""cBLUE"�������";
	    case 2: spawn = ""cBLUE"���";
		case 3: spawn = ""cBLUE"���, ��� �����";
	}
	
	switch( Player[playerid][uSettings][6] ) 
	{
		case 0: walk = ""cBLUE"�� ���������";
		case 1: walk = ""cBLUE"�������";
		case 2: walk = ""cBLUE"�������������";
		case 3: walk = ""cBLUE"������������";
		case 4: walk = ""cBLUE"�������";
		case 5: walk = ""cBLUE"�������";
		case 6: walk = ""cBLUE"������������";
		case 7: walk = ""cBLUE"�����������";
		case 8: walk = ""cBLUE"�������";
		case 9: walk = ""cBLUE"���������";
		case 10: walk = ""cBLUE"���������";
		case 11: walk = ""cBLUE"������";
		case 12: walk = ""cBLUE"� �����";
	}
	
	switch( Player[playerid][uSettings][7] ) 
	{
		case 0: talk = ""cBLUE"�� ���������";
		case 1: talk = ""cBLUE"���������";
		case 2: talk = ""cBLUE"����������";
		case 3: talk = ""cBLUE"�����������";
		case 4: talk = ""cBLUE"�������������";
		case 5: talk = ""cBLUE"������������";
		case 6: talk = ""cBLUE"�������������";
	}
	
	switch( Player[playerid][uChangeStyle] ) 
	{
		case 0: style = ""cBLUE"�� ���������"cWHITE"";
	    case 1: style = ""cBLUE"����"cWHITE"";
	    case 2: style = ""cBLUE"���� ��"cWHITE"";
	    case 3: style = ""cBLUE"���� �������"cWHITE"";
	    case 4: style = ""cBLUE"���� �����"cWHITE"";
	    case 5: style = ""cBLUE"���� ������"cWHITE"";
	}
	
	format:g_big_string(
    "\
		"cWHITE"���������\t"cWHITE"��������\n\
		"cBLUE"-"cWHITE" ��������� c���������\t%s\n\
		"cBLUE"-"cWHITE" ����������� �����\t%s\n\
		"cBLUE"-"cWHITE" ����������� �������� �������������\t%s\n\
		"cBLUE"-"cWHITE" ����� ���������\t%s\n\
		"cBLUE"-"cWHITE" ����� �������\t%s\n\
		"cBLUE"-"cWHITE" ����� ���������\t%s\n\
		"cBLUE"-"cWHITE" ����� ���\t%s\n\
		"cBLUE"-"cWHITE" OOC ��� � /b\t%s\n\
		"cBLUE"-"cWHITE" OOC ��� � /f\t%s\n\
		"cBLUE"-"cWHITE" OOC ��� � /pm\t%s\n\
		"cBLUE"-"cWHITE" ��������� �����\t%s\n\
		"cBLUE"-"cWHITE" ��������� ��������\t%s\n\
		"cBLUE"-"cWHITE" ����������� ����������\t%s\n\ 
		"cBLUE"-"cWHITE" ����������� ������\t%s\n\ 
		"cBLUE"-"cWHITE" ����������� ���������� �������\t%s\
	",
		Player[playerid][uSettings][0] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		Player[playerid][uSettings][3] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		Player[playerid][uSettings][5] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		spawn,
		walk,
		talk,
		style,
		Player[playerid][uOOC] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		Player[playerid][uRO] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		Player[playerid][uPM] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		Player[playerid][uSettings][8] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		Player[playerid][uSettings][9] ? (""cBLUE"��"cWHITE"") :(""cGRAY"���"cWHITE""),
		Player[playerid][uSettings][4] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		Player[playerid][uSettings][2] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE""),
		Player[playerid][uSettings][10] ? (""cBLUE"��"cWHITE"") : (""cGRAY"���"cWHITE"")
	);
	
    showPlayerDialog( playerid, d_menu, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "��������", "�������" );

    return 1;
}

stock ShowMenu( playerid ) 
{
	clean_array();
	
	new 
		Float:X, 
		Float:Y, 
		Float:Z, 
		Float:R, 
		Float:X2, 
		Float:Y2,
		day, month, year;
		
	if( GetPVarInt( playerid, "UserMenu:Use" ) ) 
		return 1;
		
	if( !IsPlayerInAnyVehicle( playerid ) ) 
	{
		GetPlayerPos( playerid, X, Y, Z );
		GetPlayerFacingAngle( playerid, R );
		X2 = X - 3.5 * floatsin( R, degrees );
		Y2 = Y + 3.5 * floatcos( R, degrees );
		InterpolateCameraPos( playerid, X, Y, Z, X2, Y2, Z, 600, 1000 );
		InterpolateCameraLookAt( playerid, X, Y, Z, X, Y, Z, 600, 1000 );
	}
	
	for( new i; i != 21; i++ ) TextDrawShowForPlayer( playerid, MenuPlayer[i] );
	for( new i; i != 3; i++ ) PlayerTextDrawShow( playerid, menuPlayer[i][playerid] );
	
	format:g_small_string(  "%d", Player[playerid][uLevel] ), strcat( g_big_string, g_small_string );
	
	format:g_small_string(  "~n~%s", getPlayerRank( playerid ) ), strcat( g_big_string, g_small_string );
	
	format:g_small_string(  "~n~$%09d", Player[playerid][uMoney] ), strcat( g_big_string, g_small_string );
	
	if( Player[playerid][uMember] )
	{
		format:g_small_string(  "~n~%s", Fraction[ Player[playerid][uMember] - 1 ][f_short_name] ), strcat( g_big_string, g_small_string );
	}
	else if( Player[playerid][uJob] )
	{
		switch( Player[playerid][uJob] )
		{
			case 1, 2: strcat( g_big_string, "~n~������������ ��������" );
			case 3: strcat( g_big_string, "~n~������������ ��������" );
			case 4: strcat( g_big_string, "~n~���" );
		}
	}
	else
	{
		strcat( g_big_string, "~n~���"  );
	}
	
	if( Player[playerid][uRank] && Player[playerid][uMember] )
	{
		new
			rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
		format:g_small_string(  "~n~%s", FRank[ Player[playerid][uMember] - 1 ][rank][r_name] ), strcat( g_big_string, g_small_string );
	}
	else if( Player[playerid][uJob] )
	{
		switch( Player[playerid][uJob] )
		{
			case 1:	strcat( g_big_string, "~n~�������� �����" );
			case 2:	strcat( g_big_string, "~n~�������� ��������" );
			case 3:	strcat( g_big_string, "~n~��������" );
			case 4: strcat( g_big_string, "~n~�������" );
		}
	}
	else
	{
		strcat( g_big_string, "~n~���"  );
	}
	
	if( IsOwnerHouseCount( playerid ) )
	{
		for( new i; i < MAX_PLAYER_HOUSE; i++ )
		{
			if( Player[playerid][tHouse][i] != INVALID_PARAM )
			{
				if( !i )
				{
					format:g_small_string( "~n~%d", HouseInfo[ Player[playerid][tHouse][i] ][hID] );
					strcat( g_big_string, g_small_string );
				}
				else
				{
					format:g_small_string( ", %d", HouseInfo[ Player[playerid][tHouse][i] ][hID] );
					strcat( g_big_string, g_small_string );
				}
			}
		}
	}
	else
	{
		strcat( g_big_string, "~n~���" );
	}

	if( IsOwnerBusinessCount( playerid ) )
	{
		for( new i; i < MAX_PLAYER_BUSINESS; i++ )
		{
			if( Player[playerid][tBusiness][i] != INVALID_PARAM )
			{
				if( !i )
				{
					format:g_small_string( "~n~%d", BusinessInfo[ Player[playerid][tBusiness][i] ][b_id] );
					strcat( g_big_string, g_small_string );
				}
				else
				{
					format:g_small_string( ", %d", BusinessInfo[ Player[playerid][tBusiness][i] ][b_id] );
					strcat( g_big_string, g_small_string );
				}
			}
		}
	}
	else
	{
		strcat( g_big_string, "~n~���" );
	}
	
	if( !GetPhoneNumber( playerid ) )
	{
		strcat( g_big_string, "~n~���" );
	}
	else
	{
		format:g_small_string(  "~n~%d", GetPhoneNumber( playerid ) ), strcat( g_big_string, g_small_string );
	}
	
	if( !Player[playerid][uWarn] )
	{
		strcat( g_big_string, "~n~���" );
	}
	else
	{
		format:g_small_string(  "~n~%d", Player[playerid][uWarn] ), strcat( g_big_string, g_small_string );
	}
	
	gmtime( Player[playerid][uRegDate], year, month, day );
	
	format:g_small_string(  "~n~%02d.%02d.%d", day, month, year ), strcat( g_big_string, g_small_string );
	format:g_small_string(  "~n~%d ���.", 60 - Player[playerid][uPayTime] ), strcat( g_big_string, g_small_string );
	format:g_small_string(  "~n~%d", Player[playerid][uGMoney] ), strcat( g_big_string, g_small_string );
	
	if( !Premium[playerid][prem_id] )
	{
		strcat( g_big_string, "~n~���" );
	}
	else
	{
		strcat( g_big_string, "~n~" );
		strcat( g_big_string, GetPremiumName( Premium[playerid][prem_type] ) );
		
		gmtime( Premium[playerid][prem_time], _, month, day );
		format:g_small_string(  " (�� %02d.%02d)", day, month ), strcat( g_big_string, g_small_string );
	}
	
	PlayerTextDrawSetString( playerid, menuPlayer[1][playerid], g_big_string );
	PlayerTextDrawSetString( playerid, menuPlayer[0][playerid], 
		"�������:~n~\
		������:~n~\
		��������:~n~\
		�����������:~n~\
		���������:~n~\
		���:~n~\
		������:~n~\
		����� ����������:~n~\
		��������������:~n~\
		���� �����������:~n~\
		����� �� ��������:~n~\
		RCoin:~n~\
		�������:~n~" );
	PlayerTextDrawSetString( playerid, menuPlayer[2][playerid], Player[playerid][uName] );
	
	SetPVarInt( playerid, "UserMenu:Use", 1 );
	SelectTextDraw( playerid, 0xd3d3d3FF );
	
	return 1;
}


CheckInventoryIncluded( playerid )
{
	new 
		i = 0,
		Float: x,
		Float: y,
		Float: z;
	
	/*if( GetPlayerVirtualWorld( playerid ) != 0 )
		goto SKIP_CHECK_VEHICHLES;*/
		
	for( i = 0; i < MAX_VEHICLES; i++ )
	{
		if( !IsVehicleStreamedIn( i, playerid ) ||
			IsPlayerInAnyVehicle( playerid ) || 
			!GetVehicleBag( GetVehicleModel( i ) ) || 
			Vehicle[i][vehicle_use_boot] || 
			!VehicleInfo[GetVehicleModel( i ) - 400][v_boot] || 
			!Vehicle[i][vehicle_state_boot] )
			continue;
		
		GetPosVehicleBoot( i, x, y, z );
		
		if( IsPlayerInRangeOfPoint( playerid, 1.5, x, y, z ) )
		{
			if( Vehicle[i][vehicle_member] )
			{
				if( !Player[playerid][uRank] || Vehicle[i][vehicle_member] != Player[playerid][uMember] ) 
					return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ������������ �������� ���� ������." );
					
				new
					rank = getRankId( playerid, Vehicle[i][vehicle_member] - 1 );
					
				if( !FRank[ Vehicle[i][vehicle_member] - 1 ][rank][r_boot] ) 
					return SendClient:( playerid, C_WHITE, !""gbError"�� �� ������ ������������ �������� ���� ������." );
			}
		
			SetPVarInt( playerid, "Inv:CarId", i );
			
			format:g_small_string( "������%s ��������", SexTextEnd( playerid ) );
			SendRolePlayAction( playerid, g_small_string, RP_TYPE_AME );
			
			format:g_string( "��������� %s %d", GetVehicleModelName( GetVehicleModel(i) ), Vehicle[i][vehicle_id] );
			ShowInventoryAdditional( playerid, g_string, true, GetVehicleBag( GetVehicleModel(i) ) );
			
			Vehicle[i][vehicle_use_boot] = true;
			return STATUS_OK;
		}
	}
	
	//SKIP_CHECK_VEHICHLES:
			
	/*if( Player[playerid][tHouse][0] == INVALID_PARAM && !Player[playerid][uHouseEvict] )
		return STATUS_ERROR;
	
	new
		house = INVALID_PARAM;
	
	if( Player[playerid][tHouse][0] != INVALID_PARAM && GetPlayerVirtualWorld( playerid ) == HouseInfo[ Player[playerid][tHouse][0] ][hID] )
	{
		house = Player[playerid][tHouse][0];
	}
	else if( Player[playerid][uHouseEvict] )
	{
		for( i = 0; i < MAX_HOUSE; i++ )
		{
			if( GetPlayerVirtualWorld( playerid ) != HouseInfo[i][hID] || !HouseInfo[i][hID] )
				continue;
				
			if( Player[playerid][uHouseEvict] != HouseInfo[i][hID] ) continue;

			house = i;
			break;
		}
	}
		
	if( house == INVALID_PARAM ) 
		return STATUS_ERROR;
		
	SetPVarInt( playerid, "Inv:HouseId", house );
				
	format:g_small_string( "������%s ��������� ����", SexTextEnd( playerid ) );
	SendRolePlayAction( playerid, g_small_string, RP_TYPE_AME );
	
	format:g_small_string( "��� [%d]", HouseInfo[house][hID] );
	ShowInventoryAdditional( playerid, g_small_string, true, hinterior_info[ HouseInfo[house][hInterior] - 1 ][h_inventory] );*/
				
	return STATUS_OK;
}

UserMenu_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	switch( dialogid )
	{
		case d_a_menu: 
		{
		    if( !response ) 
				return 1;
				
		    switch( listitem ) 
			{
		        case 0 : ShowMenu( playerid );
				case 1 : 
				{
					showInventory( playerid, true );
					CheckInventoryIncluded( playerid );
				}
				case 2 : 
				{
		        	if( GetPVarInt( playerid, "Player:Cuff" ) ) 
						return SendClient:( playerid, C_WHITE, ""gbError"�� �� ������ ������������ ������� � ����������!" );	
						
					if( GetPVarInt( playerid, "Phone:Incoming" ) )
						return SendClient:( playerid, C_WHITE, ""gbError"������� ��������� �������� �����!" );
						
		        	ShowPhone( playerid, true );
		        }
		        case 3 : cmd_gps( playerid );
				case 4 : cmd_favanim( playerid );
				case 5 : cmd_cpanel( playerid );
		    }
		}
		
		case d_menu: 
		{
		    if( !response ) 
				return 1;
				
		    switch(listitem) {
				case 0: 
				{
					if( !Player[playerid][uSettings][0] ) 
					{
						Player[playerid][uSettings][0] = 1;
					}
					else
					{
						Player[playerid][uSettings][0] = 0;
					}
				}
				case 1: 
				{
					if( !Player[playerid][uSettings][3] ) 
					{
						Player[playerid][uSettings][3] = 1;
						
						foreach(new i : Player) 
							ShowPlayerNameTagForPlayer( playerid, i, true );
					}
					else 
					{
						Player[playerid][uSettings][3] = 0;
						
						foreach(new i : Player)
							ShowPlayerNameTagForPlayer( playerid, i, false );
					}
				}
				
				case 2: 
				{
					if( !Player[playerid][uSettings][5] ) 
					{
						Player[playerid][uSettings][5] = 1;
					}
					else
					{
						Player[playerid][uSettings][5] = 0;
					}
				}
				
				case 3: 
					return showPlayerDialog( playerid, d_menu + 1, DIALOG_STYLE_LIST, "����� ������", "\
						"cBLUE"- "cWHITE"�����\n\
						"cBLUE"- "cWHITE"�����������\n\
						"cBLUE"- "cWHITE"���\n\
						"cBLUE"- "cWHITE"���, ��� �����", "�������", "�����" );
				
				case 4: 
					return showPlayerDialog( playerid, d_menu + 2, DIALOG_STYLE_LIST, "����� �������", "\
						"cBLUE"- "cWHITE"�� ���������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������������\n\
						"cBLUE"- "cWHITE"������������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"������������\n\
						"cBLUE"- "cWHITE"�����������\n\
						"cBLUE"- "cWHITE"�������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"������\n\
						"cBLUE"- "cWHITE"� �����", "�������", "�����" );
				
				case 5: 
					return showPlayerDialog( playerid, d_menu + 3, DIALOG_STYLE_LIST, "����� ���������", "\
						"cBLUE"- "cWHITE"�� ���������\n\
						"cBLUE"- "cWHITE"���������\n\
						"cBLUE"- "cWHITE"����������\n\
						"cBLUE"- "cWHITE"�����������\n\
						"cBLUE"- "cWHITE"�������������\n\
						"cBLUE"- "cWHITE"������������\n\
						"cBLUE"- "cWHITE"�������������", "�������", "�����" );
				
				case 6: 
					return showPlayerDialog( playerid, d_menu + 5, DIALOG_STYLE_LIST, "����� ���", "\
						"cBLUE"- "cWHITE"�� ���������\n\
						"cBLUE"- "cWHITE"����\n\
						"cBLUE"- "cWHITE"���� ��\n\
						"cBLUE"- "cWHITE"���� �������\n\
						"cBLUE"- "cWHITE"���� �����\n\
						"cBLUE"- "cWHITE"���� ������", "�������", "�����" );
				
				case 7:
				{
					if( !Player[playerid][uOOC] )
					{
						Player[playerid][uOOC] = 1;
						UpdatePlayer( playerid, "uOOC", 1 );
					}
					else
					{
						Player[playerid][uOOC] = 0;
						UpdatePlayer( playerid, "uOOC", 0 );
					}
				}
				case 8:
				{
				    if( !Player[playerid][uRO] )
					{			   
						Player[playerid][uRO] = 1;
						UpdatePlayer( playerid, "uRO", 1 );
					}
					else
					{
						Player[playerid][uRO] = 0;
						UpdatePlayer( playerid, "uRO", 0 );
					}
				}
				case 9:
				{
				    if( !Player[playerid][uPM] )
					{
						Player[playerid][uPM] = 1;
						UpdatePlayer( playerid, "uPM", 1 );
					}
					else
					{
						Player[playerid][uPM] = 0;
						UpdatePlayer( playerid, "uPM", 0 );
					}
				}
				case 10:
				{
	    			if( !Player[playerid][uSettings][8] )
					{
					    
						Player[playerid][uSettings][8] = 1;
						ShowRadioInfo( playerid, true );
					}
					else
					{
						Player[playerid][uSettings][8] = 0;
						ShowRadioInfo( playerid, false );
					}
				}
				
				case 11 :
				{
	    			if( !Player[playerid][uSettings][9] )
					{
						Player[playerid][uSettings][9] = 1;
						ShowServerLogo( playerid, true );
					}
					else
					{
						Player[playerid][uSettings][9] = 0;
						ShowServerLogo( playerid, false );
					}
				}
				
				case 12 :
				{
					if( !Player[playerid][uSettings][4] )
					{
						Player[playerid][uSettings][4] = 1;
					}
					else
					{
						Player[playerid][uSettings][4] = 0;
					}
				}
				
				case 13 :
				{
					if( !Player[playerid][uSettings][2] )
					{
						Player[playerid][uSettings][2] = 1;
					}
					else
					{
						Player[playerid][uSettings][2] = 0;
					}
				}
				
				case 14 :
				{
					if( !Player[playerid][uSettings][10] )
					{
						Player[playerid][uSettings][10] = 1;
					}
					else
					{
						Player[playerid][uSettings][10] = 0;
					}
				}
				
				/*case 15 :
				{
				    showPlayerDialog(playerid, d_menu + 15, DIALOG_STYLE_LIST, " ", "{ffffff}1. "cGRAY"��������� ���� ������������\n{ffffff}2. "cGRAY"��������� ��� ������������", "�����", "������");
				}*/

			}
			
			ShowSettings( playerid );
			SavePlayerSettings( playerid );
		}
		
		case d_menu + 4:
		{
			if( !response ) return 1;
			
			if( inputtext[0] == EOS || strval( inputtext ) > 128 )
			{
				return showPlayerDialog( playerid, d_menu + 4, DIALOG_STYLE_INPUT, " ","\
					"cWHITE"������� ���� ��������� ����:\n\n\
					"gbDialog"��������� ������������ ��������������� � ���������.\n\
					"gbDialog"���� �� ��������� �� ����������� ������, �� ���������� ��� ID.\n\
					"gbDialog"�� �������� ��������� �� �� ����, �� ������ �������� ���������� OOC ����.\n\n\
					"gbDialogError"������������ ������ �����.",
				"���������", "�������" );
			}
			
			switch( Premium[playerid][prem_color] )
			{
				case 0:
				{
					format:g_small_string( ""SUPPORT_PREFIX" %s[%d]: %s",
						GetAccountName( playerid ),
						playerid,
						inputtext
					);
					SendSupport:( C_YELLOW, g_small_string, false );
					
					format:g_small_string( ""ADMIN_PREFIX" %s[%d]: %s",
						GetAccountName(playerid),
						playerid,
						inputtext
					);
					SendAdmin:( C_YELLOW, g_small_string );
				}
				
				case 1:
				{
					format:g_small_string( ""SUPPORT_PREFIX" %s[%d]: %s",
						GetAccountName( playerid ),
						playerid,
						inputtext
					);
					SendSupport:( C_LIGHTGREEN, g_small_string, false );
					
					format:g_small_string( ""ADMIN_PREFIX" %s[%d]: %s",
						GetAccountName(playerid),
						playerid,
						inputtext
					);
					SendAdmin:( C_LIGHTGREEN, g_small_string );
				}
				
				case 2:
				{
					format:g_small_string( ""SUPPORT_PREFIX" %s[%d]: %s",
						GetAccountName( playerid ),
						playerid,
						inputtext
					);
					SendSupport:( C_LIGHTORANGE, g_small_string, false );
					
					format:g_small_string( ""ADMIN_PREFIX" %s[%d]: %s",
						GetAccountName(playerid),
						playerid,
						inputtext
					);
					SendAdmin:( C_LIGHTORANGE, g_small_string );
				}
				
				case 3:
				{
					format:g_small_string( ""SUPPORT_PREFIX" %s[%d]: %s",
						GetAccountName( playerid ),
						playerid,
						inputtext
					);
					SendSupport:( C_LIGHTRED, g_small_string, false );
					
					format:g_small_string( ""ADMIN_PREFIX" %s[%d]: %s",
						GetAccountName(playerid),
						playerid,
						inputtext
					);
					SendAdmin:( C_LIGHTRED, g_small_string );
				}
			}
			
			pformat:( ""gbDefault"�����: "cBLUE"%s"cWHITE"", inputtext );
			psend:( playerid, C_WHITE );
			
			SendClient:( playerid, C_WHITE, !""gbDefault"�� ������� ��������� ��������� ��������� � ���������������.");
	
			SetPVarInt( playerid, "Player:ReportTime", GetTickCount() + 20000 );
		}
		
		/*case d_menu + 15:
		{
		    if(!response) return true;
		    switch(listitem)
		    {
		        case 0: showPlayerDialog(playerid, d_menu + 16, DIALOG_STYLE_INPUT, " ", "{B4B5B7}������� ������������ �������� ������:", "�����", "������");
		        case 1:
		        {
		            if(Player[playerid][uPinCode] == 0) return SendClientMessage(playerid, -1, ""gbError"� ��� �� ������������ ������������� ��������������!");
		            Player[playerid][uPinCode] = 0;
		            nowUpdateInfo(playerid , "d" , "gb_users" , "uName" , "uPinCode" , Player[playerid][uPinCode]);
		            SendClientMessage(playerid, -1, ""gbSuccess"�� ��������� ������������� ��������������.");
		        }
		    }
		}
        case d_menu + 16:
        {
            if(!response) return true;
            new code;
            if(sscanf(inputtext, "d", code)) return showPlayerDialog(playerid, d_menu + 16, DIALOG_STYLE_INPUT, " ", "{B4B5B7}������� ������������ �������� ������:", "�����", "������");
            if(strlen(inputtext) != 6) return showPlayerDialog(playerid, d_menu + 16, DIALOG_STYLE_INPUT, " ", "{B4B5B7}������� ������������ �������� ������:", "�����", "������");
            if(code < 0) return showPlayerDialog(playerid, d_menu + 16, DIALOG_STYLE_INPUT, " ", "{B4B5B7}������� ������������ �������� ������:", "�����", "������");
			new bool: status = true;
			for(new i = 0, j = strlen(inputtext); i < j; i++)
			{
			    if(inputtext[0] == '0')
			    {
                    status = false;
					break;
			    }
			}
			if(status == false) return showPlayerDialog(playerid, d_menu + 16, DIALOG_STYLE_INPUT, " ", "{B4B5B7}������� ������������ �������� ������:", "�����", "������");
			nowUpdateInfo(playerid , "d" , "gb_users" , "uName" , "uPinCode" , strval(inputtext));
            SendClientMessage(playerid, -1, ""gbSuccess"��� ������ ����������� �� ������ ������� ��� ������!");
        }*/
		//��������� ����� ���
		case d_menu + 5: 
		{
		    if( !response ) 
			{
				ShowSettings( playerid );
				return 1;
			}
			
			if( listitem && !Player[playerid][uStyle][listitem - 1] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"������ ����� ��� �� ������." );
				return showPlayerDialog( playerid, d_menu + 5, DIALOG_STYLE_LIST, "����� ���", "\
					"cBLUE"- "cWHITE"�� ���������\n\
					"cBLUE"- "cWHITE"����\n\
					"cBLUE"- "cWHITE"���� ��\n\
					"cBLUE"- "cWHITE"���� �������\n\
					"cBLUE"- "cWHITE"���� �����\n\
					"cBLUE"- "cWHITE"���� ������", "�������", "�����" );
			}
			
			Player[playerid][uChangeStyle] = listitem;
			SendClient:( playerid, C_WHITE, ""gbSuccess"����� ��� �������." );	
			
			UpdatePlayer( playerid, "uChangeStyle", listitem );
			
			SetPlayerFightingStyleEx( playerid );
			ShowSettings( playerid );
		}
		//��������� ������
		case d_menu + 1 : 
		{
		    if( !response ) 
			{
				ShowSettings( playerid );
				return 1;
			}
			
			if( Player[playerid][uSettings][1] == listitem )
			{
				SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ����������� ��� ����� ������." );
				return showPlayerDialog( playerid, d_menu + 1, DIALOG_STYLE_LIST, " ", "\
					"cBLUE"- "cWHITE"�����\n\
					"cBLUE"- "cWHITE"�����������\n\
					"cBLUE"- "cWHITE"���\n\
					"cBLUE"- "cWHITE"���, ��� �����", "�������", "�����" );
			}
			
      		switch( listitem ) 
			{
				case 1:
				{
					if( !Player[playerid][uMember] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"�� �� �������� � �����������." );
						return showPlayerDialog( playerid, d_menu + 1, DIALOG_STYLE_LIST, "����� ������", "\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�����������\n\
							"cBLUE"- "cWHITE"���\n\
							"cBLUE"- "cWHITE"���, ��� �����", "�������", "�����" );
					}
					
					if( !Player[playerid][uRank] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� �����." );
						return showPlayerDialog( playerid, d_menu + 1, DIALOG_STYLE_LIST, "����� ������", "\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�����������\n\
							"cBLUE"- "cWHITE"���\n\
							"cBLUE"- "cWHITE"���, ��� �����", "�������", "�����" );
					}
					
					if( FRank[ Player[playerid][uMember] - 1 ][ getRankId( playerid, Player[playerid][uMember] - 1 ) ][r_spawn][0] == 0.0 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"� ������ ����� ��� ����� ������." );
						return showPlayerDialog( playerid, d_menu + 1, DIALOG_STYLE_LIST, "����� ������", "\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�����������\n\
							"cBLUE"- "cWHITE"���\n\
							"cBLUE"- "cWHITE"���, ��� �����", "�������", "�����" );
					}
				}
				
		        case 2: 
				{
					if( Player[playerid][tHouse][0] == INVALID_PARAM && !Player[playerid][uHouseEvict] ) 
					{
						SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ����." );
						return showPlayerDialog( playerid, d_menu + 1, DIALOG_STYLE_LIST, "����� ������", "\
							"cBLUE"- "cWHITE"�����\n\
							"cBLUE"- "cWHITE"�����������\n\
							"cBLUE"- "cWHITE"���\n\
							"cBLUE"- "cWHITE"���, ��� �����", "�������", "�����" );
					}
				}
			}
			
			Player[playerid][uSettings][1] = listitem;
			SendClient:( playerid, C_WHITE, !""gbDefault"�� �������� ����� ������ ���������.");
			
			SavePlayerSettings( playerid );
			ShowSettings(playerid);
		}
		case d_menu + 10:
		{
		    if( !response ) 
				return 1;
		}
		case d_menu + 2:
		{
		    if( !response ) 
			{
				ShowSettings(playerid);
				return 1;
			}
			
			if( Player[playerid][uSettings][6] == listitem )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"� ��� ��� ���������� ���� ����� �������." );
				return showPlayerDialog( playerid, d_menu + 2, DIALOG_STYLE_LIST, "����� �������", "\
					"cBLUE"- "cWHITE"�� ���������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"�������������\n\
					"cBLUE"- "cWHITE"������������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"������������\n\
					"cBLUE"- "cWHITE"�����������\n\
					"cBLUE"- "cWHITE"�������\n\
					"cBLUE"- "cWHITE"���������\n\
					"cBLUE"- "cWHITE"���������\n\
					"cBLUE"- "cWHITE"������\n\
					"cBLUE"- "cWHITE"� �����", "�������", "�����" );
			}
			
		    Player[playerid][uSettings][6] = listitem;
		    SendClient:( playerid, C_WHITE, !""gbDefault"�� �������� ����� �������." );

			SavePlayerSettings( playerid );
			ShowSettings( playerid );
		}
		
		case d_menu + 3: 
		{
			if( !response ) 
			{
				ShowSettings(playerid);
				return 1;
			}
			
			if( Player[playerid][uSettings][7] == listitem )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"� ��� ��� ���������� ���� ����� ���������." );
				return showPlayerDialog( playerid, d_menu + 3, DIALOG_STYLE_LIST, "����� ���������", "\
					"cBLUE"- "cWHITE"�� ���������\n\
					"cBLUE"- "cWHITE"���������\n\
					"cBLUE"- "cWHITE"����������\n\
					"cBLUE"- "cWHITE"�����������\n\
					"cBLUE"- "cWHITE"�������������\n\
					"cBLUE"- "cWHITE"������������\n\
					"cBLUE"- "cWHITE"�������������", "�������", "�����" );
			}
			
		    Player[playerid][uSettings][7] = listitem;
		    SendClientMessage( playerid, C_WHITE, !""gbDefault"�� �������� ����� ���������." );
			
			SavePlayerSettings( playerid );
			ShowSettings(playerid);
		}
	}
	
	return 1;
}

function UserMenu_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED( KEY_YES ) )
	{
		if( GetPVarInt( playerid, "PlayerMenuShow" ) == 5 )
		{
			return 1;
		}
		
		if( !GetPVarInt( playerid, "Phone:Call" ) ) //���� �� �������������� �� ��������
			ShowDialogMenu( playerid );
	}
	return 1;
}

function UserMenu_OnPlayerClickTextDraw( playerid, Text: clickedid )
{
	if( _:clickedid == INVALID_TEXT_DRAW ) 
	{
		if( GetPVarInt( playerid, "UserMenu:Use" ) )
		{
			for( new i; i != 21; i++ ) 
			{
				TextDrawHideForPlayer(playerid, MenuPlayer[i]);
			}
			
			for( new i; i != 3; i++ )
			{
				PlayerTextDrawHide(playerid, menuPlayer[i][playerid]);
			}
			
			SetPVarInt( playerid, "UserMenu:Use", 0 );
			CancelSelectTextDraw( playerid );
			SetCameraBehindPlayer( playerid );
			return 1;
		}
	}
	else if( clickedid == MenuPlayer[15] )
	{
        if( IsMuted( playerid, OOC ) )
			return SendClient:( playerid, C_WHITE, !CHAT_MUTE_OOC );
			
		if( GetPVarInt( playerid, "Player:ReportTime" ) > GetTickCount() )
			return SendClient:( playerid, C_WHITE, !""gbError"������������ ����� � �������������� ����� ��� � 20 ������." );
			
		showPlayerDialog( playerid, d_menu + 4, DIALOG_STYLE_INPUT, " ","\
			"cWHITE"������� ���� ��������� ����:\n\n\
			"gbDialog"��������� ������������ ��������������� � ���������.\n\
			"gbDialog"���� �� ��������� �� ����������� ������, �� ���������� ��� ID.\n\
			"gbDialog"�� �������� ��������� �� �� ����, �� ������ �������� ���������� OOC ����.",
		"���������", "�������" );
	}
    else if( clickedid == MenuPlayer[16] ) //������ �� ����
	{
		cmd_help( playerid );
		return 1;
	}
	else if( clickedid == MenuPlayer[17] ) //���������
	{
		ShowSettings( playerid );
		return 1;
    }
	else if( clickedid == MenuPlayer[18] ) //�������
	{
		showPlayerDialog( playerid, d_help, DIALOG_STYLE_LIST, "������� �������", d_help_command, "�������", "�������" );
		return 1;
	}
	else if( clickedid == MenuPlayer[19] ) //����������
	{
		ShowStats( playerid, playerid );
		return 1;
	}
    else if( clickedid == MenuPlayer[20] ) //�������
	{
		cmd_donate( playerid );
		return 1;
	}
	
	return 0;
}

ShowDialogMenu( playerid )
{
	clean:<g_big_string>;
	
	if( GetPVarInt( playerid, "UserMenu:Use" ) ) 
		return 0;
		
	if( GetPVarInt( playerid, "HTx:Use" ) ) 
		return 0;
		
	strcat( g_big_string, ""cBLUE"-"cWHITE" ������� ����\n" );
	strcat( g_big_string, ""cBLUE"-"cWHITE" ���������\n" );
	strcat( g_big_string, ""cBLUE"-"cWHITE" ������� �������\n" );
	strcat( g_big_string, ""cBLUE"-"cWHITE" GPS ���������\n" );
	//strcat( g_big_string, ""cBLUE"-"cWHITE" ��������������\n" );
	strcat( g_big_string, ""cBLUE"-"cWHITE" ��������� ��������" );
	
	if( IsPlayerInAnyVehicle( playerid ) )
	{
		strcat( g_big_string, "\n"cBLUE"-"cWHITE" ���������� �����������" );
	}
	
	showPlayerDialog( playerid, d_a_menu, 2, " ", g_big_string, "�������", "�������" );
	 
	return 1;
}

SavePlayerSettings( playerid )
{
	format:g_small_string( "%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d",
		Player[playerid][uSettings][0],
		Player[playerid][uSettings][1],
		Player[playerid][uSettings][2],
		Player[playerid][uSettings][3],
		Player[playerid][uSettings][4],
		Player[playerid][uSettings][5],
		Player[playerid][uSettings][6],
		Player[playerid][uSettings][7], 
		Player[playerid][uSettings][8],
		Player[playerid][uSettings][9],
		Player[playerid][uSettings][10]
	);
	
	UpdatePlayerString( playerid, "uSettings", g_small_string );
}

stock ShowStats( playerid, giveplayerid ) 
{
	clean:<g_big_string>;
	
	new 
		bool: idx,
		year,
		month,
		day;
	
	format:g_small_string( ""gbDefault"���������� ������ "cBLUE"%s[%d]"cWHITE".\n\n",
		Player[giveplayerid][uName],
		giveplayerid
	);
	strcat( g_big_string, g_small_string );
	
	strcat( g_big_string, ""cBLUE" - ��������:"cWHITE"\n");
	
	format:g_small_string( "������: "cGRAY"$%d"cWHITE"\n", Player[giveplayerid][uMoney]);
	strcat( g_big_string,g_small_string );
	
	format:g_small_string( "����: "cGRAY"$%d"cWHITE"\n", Player[giveplayerid][uBank]);
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( "���: "cGRAY"%s"cWHITE"\n", GetSexName( Player[giveplayerid][uSex] ) );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( "�������: "cGRAY"%d %s"cWHITE"\n", Player[giveplayerid][uAge], AgeTextEnd( Player[giveplayerid][uAge]%10 ) );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( "������ ��������: "cGRAY"%s"cWHITE"\n", GetCountryName( Player[giveplayerid][uCountry] ) );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( "��������������: "cGRAY"%s"cWHITE"\n", GetNationName( Player[giveplayerid][uNation] ) );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( "���� ����: "cGRAY"%s"cWHITE"\n", Player[giveplayerid][uColor] == 2 ? ("�������") : ("������") );
	strcat( g_big_string, g_small_string );
	
	//format:g_small_string( "���� ���������: "cGRAY"%s"cWHITE"\n", Player[giveplayerid][uRole] == 2 ? ("�����������") : ("������� ������") );
	//strcat( g_big_string, g_small_string );
	
	if( !GetPhoneNumber( playerid ) )
	{
		format:g_small_string( "�������: "cGRAY"���"cWHITE"\n" );
	}
	else
	{
		format:g_small_string( "�������: "cGRAY"%d"cWHITE"\n", GetPhoneNumber( playerid ) );
	}
	strcat( g_big_string, g_small_string );
	
	/*format:g_small_string( "������: "cGRAY"%d"cWHITE"\n", Player[giveplayerid][uSuspect]);
	strcat( g_big_string, g_small_string );*/
	
	format:g_small_string( "������: "cGRAY"%s"cWHITE"\n", GetJobName( Player[giveplayerid][uJob] ) );
	strcat( g_big_string, g_small_string);
	
	if( Player[giveplayerid][uMember] )
	{
		new
			fid = Player[giveplayerid][uMember] - 1,
			rank;
	
		format:g_small_string( "�����������: "cGRAY"%s"cWHITE"\n", Fraction[ fid ][f_name] ), 
		strcat( g_big_string, g_small_string );
		
		format:g_small_string( "�����: "cGRAY"%s"cWHITE"\n", !Player[giveplayerid][uLeader] ? ("���") : ("��") );
		strcat( g_big_string, g_small_string );
		
		if( Player[giveplayerid][uRank] )
		{
			rank = getRankId( giveplayerid, fid );
			format:g_small_string(  "����: "cGRAY"%s"cWHITE"\n", FRank[ fid ][rank][r_name] ), 
			strcat( g_big_string, g_small_string );
		}
		else
		{
			strcat( g_big_string, "����: "cGRAY"���"cWHITE"\n" );
		}
	}
	else if( Player[giveplayerid][uCrimeM] )
	{
		new
			crime = getIndexCrimeFraction( Player[giveplayerid][uCrimeM] ),
			rank;
	
		format:g_small_string(  "�����������: "cGRAY"%s"cWHITE"\n", CrimeFraction[ crime ][c_name] ), 
		strcat( g_big_string, g_small_string );
		
		format:g_small_string( "�����: "cGRAY"%s"cWHITE"\n", !Player[giveplayerid][uLeader] ? ("���") : ("��") );
		strcat( g_big_string, g_small_string );
		
		if( Player[giveplayerid][uCrimeRank] )
		{
			rank = getCrimeRankId( giveplayerid, crime );
			format:g_small_string(  "����: "cGRAY"%s"cWHITE"\n", CrimeRank[ crime ][rank][r_name] ), 
			strcat( g_big_string, g_small_string );
		}
		else
		{
			strcat( g_big_string, "����: "cGRAY"���"cWHITE"\n" );
		}
	}
	else
	{
		strcat( g_big_string, "�������: "cGRAY"���"cWHITE"\n" );
		strcat( g_big_string, "�����: "cGRAY"���"cWHITE"\n" );
		strcat( g_big_string, "����: "cGRAY"���"cWHITE"\n" );
	}
	
	strcat( g_big_string, "\n���������: " );
	
	for( new i; i < MAX_PLAYER_VEHICLES; i++ )
	{
		if( Player[giveplayerid][tVehicle][i] != INVALID_VEHICLE_ID )
		{
			new
				vehicleid = Player[giveplayerid][tVehicle][i];
		
			format:g_small_string(  "\n"cGRAY"%s [%d]"cWHITE"", GetVehicleModelName( GetVehicleModel( vehicleid ) ), vehicleid ), 
			strcat( g_big_string, g_small_string );
			
			idx = true;
		}
	}
	
	if( !idx ) strcat( g_big_string, "���" );
	idx = false;
	
	strcat( g_big_string, "\n���: " );
	
	for( new i; i < MAX_PLAYER_HOUSE; i++ )
	{
		if( Player[giveplayerid][tHouse][i] != INVALID_PARAM )
		{
			new
				house = Player[giveplayerid][tHouse][i];
		
			format:g_small_string(  "\n"cGRAY"%s [%d]"cWHITE"", !HouseInfo[house][hType] ? ("���") : ("��������"), HouseInfo[house][hID] ), 
			strcat( g_big_string, g_small_string );
		
			idx = true;
		}
	}
	
	if( !idx ) strcat( g_big_string, "���" );
	idx = false;
	
	strcat( g_big_string, "\n������: " );
	
	for( new i; i < MAX_PLAYER_BUSINESS; i++ )
	{
		if( Player[giveplayerid][tBusiness][i] != INVALID_PARAM )
		{
			new
				business = Player[giveplayerid][tBusiness][i];
		
			format:g_small_string(  "\n"cGRAY"%s [%d]"cWHITE"", GetBusinessType( business ), BusinessInfo[ business ][b_id] ), 
			strcat( g_big_string, g_small_string );
		
			idx = true;
		}
	}
	
	if( !idx ) strcat( g_big_string, "���" );
	
	strcat( g_big_string, "\n\n"cBLUE" - �������:"cWHITE"\n");
	
	format:g_small_string( "�������: "cBLUE"%d"cWHITE"\n", Player[giveplayerid][uLevel] );
	strcat( g_big_string,g_small_string );
	
	format:g_small_string( "������: "cBLUE"%s"cWHITE"\n", getPlayerRank( giveplayerid ) );
	strcat( g_big_string,g_small_string );
	
	format:g_small_string( "��������� �������: "cBLUE"%d/%d"cWHITE" exp.\n", Player[giveplayerid][uHours] - getLevelHours( giveplayerid ), ( Player[giveplayerid][uLevel] + 1 ) * 6 );
	strcat( g_big_string,g_small_string );
	
	format:g_small_string( "����� ���������� ����� � ����: "cBLUE"%d"cWHITE"\n", Player[giveplayerid][uHours] );
	strcat( g_big_string,g_small_string );
	
	format:g_small_string( "��������������: "cBLUE"%d/3"cWHITE"\n", Player[giveplayerid][uWarn] );
	strcat( g_big_string,g_small_string );
	
	format:g_small_string( "����� �� PayDay: "cGRAY"%d"cWHITE" ���.\n", 60 - Player[giveplayerid][uPayTime] );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( "ID ��������: "cGRAY"%d"cWHITE"\n", Player[giveplayerid][uID] );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( "������� �������: %s%s[%d]"cWHITE"\n", GetPremiumColor( Premium[giveplayerid][prem_color] ), GetPremiumName( Premium[giveplayerid][prem_type] ), Premium[playerid][prem_id] );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( "RCoin: "cBLUE"%d"cWHITE"\n", Player[giveplayerid][uGMoney] );
	strcat( g_big_string, g_small_string );
	
	/*format:g_small_string( "��������������� IP: "cGRAY"%s"cWHITE"\n", Player[giveplayerid][uRegIP] );
	strcat( g_big_string, g_small_string );*/
	
	format:g_small_string( "������� IP: "cGRAY"%s"cWHITE"\n", Player[giveplayerid][tIP] );
	strcat( g_big_string, g_small_string );
	
	gmtime( Player[giveplayerid][uRegDate], year, month, day );
	format:g_small_string( "���� �����������: "cGRAY"%02d.%02d.%d"cWHITE"\n", day, month, year );
	strcat( g_big_string, g_small_string );
	
	if( Player[ giveplayerid ][ uDMJail ] != 0 )
	{
		format:g_small_string( "� ��������� ��������: "cRED"%d"cWHITE" ���.\n", Player[ giveplayerid ][ uDMJail ] );
		strcat( g_big_string, g_small_string );
	}
	
	else if( Player[ giveplayerid ][ uMute ] != 0 )
	{
		format:g_small_string( "���������� IC ����: "cRED"%d"cWHITE" ���.\n", Player[ giveplayerid ][ uMute ] );
		strcat( g_big_string, g_small_string );
	}
	
	else if( Player[ giveplayerid ][ uBMute ] != 0 )
	{
		format:g_small_string( "���������� OOC ����: "cRED"%d"cWHITE" ���.\n", Player[ giveplayerid ][ uBMute ] );
		strcat( g_big_string, g_small_string );
	}
	
	else if( Player[ giveplayerid ][ uWarn ] != 0 )
	{
		format:g_small_string( "��������������: "cRED"%d"cWHITE"\n", Player[ giveplayerid ][ uWarn ] );
		strcat( g_big_string, g_small_string );
	}
	
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "�������", "" );
	
	return 1;
}