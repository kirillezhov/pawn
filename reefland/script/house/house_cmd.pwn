CMD:hpanel( playerid )
{
	if( SelectedMenu[playerid] != INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"�������� �������� �������." );

	if( IsOwnerHouseCount( playerid ) )
	{
		for( new h; h < MAX_PLAYER_HOUSE; h++ )
		{
			if( Player[playerid][tHouse][h] == INVALID_PARAM ) continue;
		
			new
				house = Player[playerid][tHouse][h];
	
			if( HouseInfo[house][hID] == GetPlayerVirtualWorld( playerid ) )
			{
				if( g_player_interaction{ playerid } ) return SendClient:( playerid, C_WHITE, !""gbError"� ������ ������ �� �� ������ ��������������� ������� ����." );
			
				showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
				
				SetPVarInt( playerid, "Hpanel:HId", house );
				
				return 1;
			}
		}
	}
	else if( Player[playerid][uHouseEvict] )
	{
		for( new h; h < MAX_HOUSE; h++ )
		{
			if( !HouseInfo[h][hID] ) continue;
			
			if( HouseInfo[h][hID] == GetPlayerVirtualWorld( playerid ) && Player[playerid][uHouseEvict] == HouseInfo[h][hID] )
			{
				if( g_player_interaction{ playerid } ) return SendClient:( playerid, C_WHITE, !""gbError"� ������ ������ �� �� ������ ��������������� ������� ����." );

				SetPVarInt( playerid, "Hpanel:HId", h );
				showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "�������", "�������" );
			
				return 1;
			}
		}
	}
	else
	{
		return SendClient:( playerid, C_WHITE, !""gbError"� ��� ��� ����������� ����� ����������." );
	}
	
	SendClient:( playerid, C_WHITE, !""gbError"��� ���������� ������ �� ������ ���������� � ��� ���������." );
	
	return 1;
}

CMD:addhouse( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "addhouse" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"�������: /addhouse [ id ��������� ][ ���� ]" );
	
	if( params[0] < 1 || params[0] > sizeof hinterior_info ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������������ ������������� ���������." );
	
	if( params[1] < 5000 || params[1] > 2000000 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������������ �������� ����.");
	
	new 
		Float:pos[4];
		
	GetPlayerPos( playerid, pos[0], pos[1], pos[2] ), 
	GetPlayerFacingAngle( playerid, pos[3] );
	
	for( new h; h < sizeof HouseInfo; h++ ) 
	{
		if( !HouseInfo[h][hID] ) 
		{
			for( new i; i < 4; i++ ) 
			{
				HouseInfo[h][hEnterPos][i] = pos[i], 
				HouseInfo[h][hExitPos][i] = hinterior_info[ params[0] - 1 ][ h_pos_exit ][i];
			}
			
			HouseInfo[h][hType] = GetPlayerVirtualWorld( playerid );
			HouseInfo[h][hPrice] = params[1];
			HouseInfo[h][hInterior] = params[0];
			HouseInfo[h][huID] = INVALID_PARAM;
			HouseInfo[h][hLock] = 1;
			
			mysql_format:g_string( "INSERT INTO `"DB_HOUSE"` \
				( `hPosX`, `hPosY`, `hPosZ`, `hPosA`, `hType`, `hExPosX`, `hExPosY`, `hExPosZ`, `hExPosA`, `hPrice`, `hInterior` ) VALUES \
				( '%f', '%f', '%f', '%f', '%d', '%f', '%f', '%f', '%f', '%d', '%d' )",
				HouseInfo[h][hEnterPos][0], 
				HouseInfo[h][hEnterPos][1], 
				HouseInfo[h][hEnterPos][2],
				HouseInfo[h][hEnterPos][3], 
				HouseInfo[h][hType],
				HouseInfo[h][hExitPos][0], 
				HouseInfo[h][hExitPos][1], 
				HouseInfo[h][hExitPos][2],
				HouseInfo[h][hExitPos][3], 
				HouseInfo[h][hPrice],
				HouseInfo[h][hInterior] );
				
			mysql_tquery( mysql, g_string, "insertHouseCreate", "dd", playerid, h );
			break;	
		}
	}
	
	return 1;
}

CMD:changehouse( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "changehouse" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "ddd", params[0], params[1], params[2] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /changehouse [ id ���� ][ id �������� ][ ���� ]" );
		
	if( params[1] < 1 || params[1] > sizeof hinterior_info ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������������ ������������� ���������." );
	
	if( params[2] < 5000 || params[2] > 2000000 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"������������ �������� ����.");
	
	new
		h = INVALID_PARAM;
	
	for( new i; i < sizeof HouseInfo; i++ ) 
	{
		if( params[0] == HouseInfo[i][hID] ) 
		{
			h = i;
			break;
		}
	} 
	
	if( h == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"��� � ����� ��������������� �� ������." );
		
	for( new i; i < 4; i++ ) 
	{
		HouseInfo[h][hExitPos][i] = hinterior_info[ params[1] - 1 ][ h_pos_exit ][i];
	}

	HouseInfo[h][hInterior] = params[1];
	HouseInfo[h][hPrice] = params[2];
			
	mysql_format:g_string( "UPDATE `"DB_HOUSE"` SET \
		`hExPosX` = '%f', \
		`hExPosY` = '%f', \
		`hExPosZ` = '%f', \
		`hExPosA` = '%f', \
		`hPrice` = %d, \
		`hInterior` = %d WHERE \
		`hID` = %d LIMIT 1", 
		HouseInfo[h][hExitPos][0],
		HouseInfo[h][hExitPos][1],
		HouseInfo[h][hExitPos][2],
		HouseInfo[h][hExitPos][3],
		HouseInfo[h][hPrice],
		HouseInfo[h][hInterior],
		HouseInfo[h][hID]
	);
	mysql_tquery( mysql, g_string );
			
	loadHouseInterior( h );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] ������� ��� ID %d: �������� #%d, ���� $%d.",
		Player[playerid][uName],
		playerid,
		params[0], params[1], params[2] );
		
	SendAdmin:( C_DARKGRAY, g_small_string );
	
	return 1;
}

CMD:delhouse( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "delhouse" ) )
	    return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"�������: /delhouse [ id ���� ]" );
	new
		h = INVALID_PARAM;
	
	for( new i; i < sizeof HouseInfo; i++ ) 
	{
		if( params[0] == HouseInfo[i][hID] ) 
		{
			h = i;
			break;
		}
	} 
	
	if( h == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"��� � ����� ��������������� �� ������." );
		
	if( IsValidDynamicPickup( HouseInfo[h][hPickup] ) )
		DestroyDynamicPickup( HouseInfo[h][hPickup] );
		
	if( IsValidDynamic3DTextLabel( HouseInfo[h][hText][0] ) )
		DestroyDynamic3DTextLabel( HouseInfo[h][hText][0] );
		
	if( IsValidDynamic3DTextLabel( HouseInfo[h][hText][1] ) )
		DestroyDynamic3DTextLabel( HouseInfo[h][hText][1] );
		
	mysql_format:g_small_string( "DELETE FROM `"DB_HOUSE"` WHERE `hID` = %d LIMIT 1", params[0] );
	mysql_tquery( mysql, g_small_string );
	
	clearDataHouse( h );
	
	format:g_small_string( ""ADMIN_PREFIX" %s[%d] ������ ��� � ID %d.",
		Player[playerid][uName],
		playerid,
		params[0] );
		
	SendAdmin:( C_DARKGRAY, g_small_string );
		
	return 1;
}

CMD:knock( playerid )
{
	for( new h; h < sizeof HouseInfo; h++ ) 
	{
		if( HouseInfo[h][hID] && IsPlayerInRangeOfPoint( playerid, 2.0, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] ) ) 
		{
			pformat:( ""gbSuccess"�� ��������� � ����� %s #%d.", !HouseInfo[h][hType] ? ("����") : ("��������"), HouseInfo[h][hID] );
			psend:( playerid, C_WHITE );
			
			format:g_small_string( "* ���-�� �������� � ����� %s.", !HouseInfo[h][hType] ? ("����") : ("��������") );
			inHouseMessage( h, C_PURPLE, g_small_string );
			
			return 1;
		}
	}
	
	SendClient:( playerid, C_WHITE, !""gbDefault"����� ���������, �� ������ ���������� ����� � ������ ����." );

	return 1;
}

CMD:hevict( playerid )
{
	if( !Player[playerid][uHouseEvict] ) 
		return SendClient:( playerid, C_WHITE, !""gbError"�� �� ���������." );
		
	for( new h; h < sizeof HouseInfo; h++ ) 
	{
		if( !HouseInfo[h][hID] ) continue;
	
		if( Player[playerid][uHouseEvict] == HouseInfo[h][hID] )
		{
			for( new e; e < hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_evict]; e++ )
			{
				if( HEvict[h][e][hEvictUID] == Player[playerid][uID] )
				{
					HEvict[h][e][hEvictUID] = 0;
					HEvict[h][e][hEvictName][0] = EOS;
				
					break;
				}
			}
			
			pformat:( ""gbSuccess"�� ������� ���������� �� "cBLUE"%s #%d"cWHITE".",
				!HouseInfo[h][hType] ? ("����") : ("��������"),
				HouseInfo[h][hID] );
			psend:( playerid, C_WHITE );
			
			Player[playerid][uHouseEvict] = 0;
			UpdatePlayer( playerid, "uHouseEvict", 0 );
			
			return 1;
		}
	}
	
	SendClient:( playerid, C_WHITE, !""gbError"�� ���� �������� �����." );
		
	return 1;
}