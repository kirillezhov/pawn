CMD:bpanel( playerid )
{
	if( SelectedMenu[playerid] != INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"Закройте редактор текстур." );

	if( !IsOwnerBusinessCount( playerid ) )
		return SendClient:( playerid, C_WHITE, !NO_PERSONAL_BUSINESS );
	
	for( new b; b < MAX_PLAYER_BUSINESS; b++ )
	{
		if( Player[playerid][tBusiness][b] == INVALID_PARAM ) continue;
	
		new
			id = Player[playerid][tBusiness][b];
	
		if( BusinessInfo[id][b_id] == GetPlayerVirtualWorld( playerid ) )
		{
			showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "Выбрать", "Закрыть" );
			
			SetPVarInt( playerid, "Bpanel:BId", id );
			SetPVarInt( playerid, "Bpanel:Interior", BusinessInfo[id][b_interior] );
			
			return 1;
		}	
	}
	
	SendClient:( playerid, C_WHITE, ""gbError"Для управления бизнесом Вы должны находиться в его помещении." );
	
	return 1;
} 

CMD:addbusiness( playerid, params[] ) 
{
	if( !GetAccessCommand( playerid, "addbusiness" ) )
	   return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "ddd", params[0], params[1], params[2] ) ) 
		return SendClient:( playerid, C_WHITE, ""gbDefault"Введите: /addbusiness [ интерьер ] [ цена ] [ номер магазина ]" );
	
	if( params[0] <= 0 || params[0] > sizeof( business_int ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Недопустимое значение интерьера." );
	
	if( params[1] < 50000 || params[1] > 10000000 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Недопустимое значение цены.");
		
	if( params[2] < 0 || params[2] > 9 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Недопустимый номер магазина.");
	
	new 
		Float:pos[4]; 
	
	for( new b; b < MAX_BUSINESS; b++ ) 
	{
		if( !BusinessInfo[b][b_id] ) 
		{
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] ), 
			GetPlayerFacingAngle( playerid, pos[3] ); 
						
			for( new i; i < 4; i++ ) 
			{
				BusinessInfo[b][b_enter_pos][i] = pos[i]; 
				BusinessInfo[b][b_exit_pos][i] = business_int[ params[0] - 1 ][bt_p][i];
			}
			
			BusinessInfo[b][b_interior] = business_int[ params[0] - 1 ][bt_id];
			BusinessInfo[b][b_price] = params[1];
			BusinessInfo[b][b_type] = business_int[ params[0] - 1 ][bt_type];
			BusinessInfo[b][b_shop] = params[2];
			
			mysql_format:g_string( "INSERT INTO `"DB_BUSINESS"` \
				( `b_type`, `b_shop`, `b_int`, `b_enter_pos`, `b_exit_pos`, `b_price`, `b_name` ) VALUES \
				( '%d', '%d', '%d', '%f|%f|%f|%f', '%f|%f|%f|%f', '%d', '%s' )",
				BusinessInfo[b][b_type],
				BusinessInfo[b][b_shop],
				BusinessInfo[b][b_interior],
				BusinessInfo[b][b_enter_pos][0],
				BusinessInfo[b][b_enter_pos][1],
				BusinessInfo[b][b_enter_pos][2],
				BusinessInfo[b][b_enter_pos][3],
				BusinessInfo[b][b_exit_pos][0],
				BusinessInfo[b][b_exit_pos][1],
				BusinessInfo[b][b_exit_pos][2],
				BusinessInfo[b][b_exit_pos][3],
				BusinessInfo[b][b_price],
				GetBusinessType( b )
			);
			mysql_tquery( mysql, g_string, "CreateBusiness", "dd", playerid, b );
			
			return 1;
		}
	}
	
	SendClient:( playerid, C_WHITE, !""gbError"Ошибка. Превышен количественный лимит бизнесов." );
	
	return 1;
}

CMD:delbusiness( playerid, params[] )
{
	if( !GetAccessCommand( playerid, "delbusiness" ) )
	   return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /delbusiness [ id бизнеса ]" );	
	
	for( new bid; bid < MAX_BUSINESS; bid++ )
	{
		if( params[0] == BusinessInfo[bid][b_id] )
		{
			mysql_format:g_small_string( "DELETE FROM `"DB_BUSINESS"` WHERE `b_id` = %d LIMIT 1", params[0] );
			mysql_tquery( mysql, g_small_string );
			
			if( IsValidDynamicPickup( BusinessInfo[bid][b_pickup] ) )
				DestroyDynamicPickup( BusinessInfo[bid][b_pickup] );
				
			if( IsValidDynamic3DTextLabel( BusinessInfo[bid][b_text] ) )
				DestroyDynamic3DTextLabel( BusinessInfo[bid][b_text] );
				
			if( IsValidDynamic3DTextLabel( BusinessInfo[bid][b_alt_text] ) )
				DestroyDynamic3DTextLabel( BusinessInfo[bid][b_alt_text] );
				
			format:g_small_string( ""ADMIN_PREFIX" %s[%d] удалил бизнес с ID %d", 
				Player[playerid][uName], 
				playerid, 
				BusinessInfo[bid][b_id] );
			SendAdmin:( C_DARKGRAY, g_small_string );
			
			ClearBusinessData( bid );
			
			return 1;
		}
	}
	
	SendClient:( playerid, C_WHITE, !""gbError"Ошибка. Бизнес с таким ID не найден." );

	return 1;
}

CMD:chbusiness( playerid, params[0] )
{
	if( !GetAccessCommand( playerid, "chbusiness" ) )
	   return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
	   
	if( sscanf( params, "dd", params[0], params[1] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /chbusiness [ id бизнеса ][ id интерьера ]" );
		
	if( params[1] <= 0 || params[1] > sizeof( business_int ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Недопустимое значение интерьера." );

	for( new bid; bid < MAX_BUSINESS; bid++ )
	{
		if( params[0] == BusinessInfo[bid][b_id] )
		{
			if( BusinessInfo[bid][b_type] != business_int[ params[1] - 1 ][bt_type] )
				return SendClient:( playerid, C_WHITE, !""gbError"Недопустимое значение для этого типа бизнеса." );

			BusinessInfo[bid][b_interior] = business_int[ params[1] - 1 ][bt_id];
			
			for( new i; i < 4; i++ ) 
				BusinessInfo[bid][b_exit_pos][i] = business_int[ params[1] - 1 ][bt_p][i];
				
			if( IsValidDynamic3DTextLabel( BusinessInfo[bid][b_alt_text] ) )
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
			
			mysql_format:g_small_string( "UPDATE `"DB_BUSINESS"` SET `b_int` = %d, `b_exit_pos` = '%f|%f|%f|%f' WHERE `b_id` = %d LIMIT 1",
				BusinessInfo[bid][b_interior], 
				BusinessInfo[bid][b_exit_pos][0],
				BusinessInfo[bid][b_exit_pos][1],
				BusinessInfo[bid][b_exit_pos][2],
				BusinessInfo[bid][b_exit_pos][3],
				BusinessInfo[bid][b_id] );
			mysql_tquery( mysql, g_small_string );
			
			LoadBusinessInterior( bid );
			
			format:g_small_string( ""ADMIN_PREFIX" %s[%d] изменил бизнес с ID %d: интерьер #%d", 
				Player[playerid][uName], 
				playerid, 
				BusinessInfo[bid][b_id],
				BusinessInfo[bid][b_interior] );
				
			SendAdmin:( C_DARKGRAY, g_small_string );
			
			return 1;
		}
	}
		
	SendClient:( playerid, C_WHITE, !""gbError"Ошибка. Бизнес с таким ID не найден." );
		
	return 1;
}