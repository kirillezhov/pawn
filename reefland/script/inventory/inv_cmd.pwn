/*CMD:inv_bag( playerid, params[] )
{
	pformat:( "bag_id: %d", getUseBagId( playerid ) );
	psend:(playerid, C_WHITE );
	return 1;
}

CMD:inv_type( playerid, params[] )
{
	if( sscanf( params, "d", params[0] ) )
		return 1;
		
	pformat:( "type: %d", getItemType( playerid, params[0], TYPE_USE ) );
	psend:(playerid, C_WHITE );
	return 1;
}

CMD:drop_item( playerid, params[] )
{
	if( sscanf( params, "d", params[0] ) )
		return 1;
		
	pformat:( "%0.2f %0.2f %0.2f", DropItem[params[0]][item_pos_x], DropItem[params[0]][item_pos_y], DropItem[params[0]][item_pos_z] );
	psend:( playerid, C_WHITE );
	
	return 1;
}

CMD:click_inv( playerid, params[] )
{
	new 
		i = GetPVarInt( playerid, "Inv:Select" );
		
	clean:<g_big_string>;
	
	format:g_string( "inv_bd: %d", PlayerInv[playerid][i][inv_bd] ); strcat( g_big_string, g_string );
	format:g_string( "\ninv_id: %d", PlayerInv[playerid][i][inv_id] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_amount: %d", PlayerInv[playerid][i][inv_amount] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_type: %d", PlayerInv[playerid][i][inv_type] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_active_type: %d", PlayerInv[playerid][i][inv_active_type] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_slot: %d", PlayerInv[playerid][i][inv_slot] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_pos_x: %f", PlayerInv[playerid][i][inv_pos_x] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_pos_y: %f", PlayerInv[playerid][i][inv_pos_y] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_pos_z: %f", PlayerInv[playerid][i][inv_pos_z] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_rot_x: %f", PlayerInv[playerid][i][inv_rot_x] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_rot_y: %f", PlayerInv[playerid][i][inv_rot_y] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_rot_z: %f", PlayerInv[playerid][i][inv_rot_z] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_scale_x: %f", PlayerInv[playerid][i][inv_scale_x] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_scale_y: %f", PlayerInv[playerid][i][inv_scale_y] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_scale_z: %f", PlayerInv[playerid][i][inv_scale_z] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_bone: %d", PlayerInv[playerid][i][inv_bone] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_param_1: %d", PlayerInv[playerid][i][inv_param_1] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_param_2: %d", PlayerInv[playerid][i][inv_param_2] );strcat( g_big_string, g_string );
	
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
	return 1;
}

CMD:click_useinv( playerid, params[] )
{
	new 
		i = GetPVarInt( playerid, "UseInv:Select" );
		
	clean:<g_big_string>;
	
	format:g_string( "inv_bd: %d", UseInv[playerid][i][inv_bd] ); strcat( g_big_string, g_string );
	format:g_string( "\ninv_id: %d", UseInv[playerid][i][inv_id] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_amount: %d", UseInv[playerid][i][inv_amount] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_type: %d", UseInv[playerid][i][inv_type] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_active_type: %d", UseInv[playerid][i][inv_active_type] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_slot: %d", UseInv[playerid][i][inv_slot] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_pos_x: %f", UseInv[playerid][i][inv_pos_x] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_pos_y: %f", UseInv[playerid][i][inv_pos_y] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_pos_z: %f", UseInv[playerid][i][inv_pos_z] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_rot_x: %f", UseInv[playerid][i][inv_rot_x] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_rot_y: %f", UseInv[playerid][i][inv_rot_y] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_rot_z: %f", UseInv[playerid][i][inv_rot_z] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_scale_x: %f", UseInv[playerid][i][inv_scale_x] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_scale_y: %f", UseInv[playerid][i][inv_scale_y] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_scale_z: %f", UseInv[playerid][i][inv_scale_z] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_bone: %d", UseInv[playerid][i][inv_bone] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_param_1: %d", UseInv[playerid][i][inv_param_1] );strcat( g_big_string, g_string );
	format:g_string( "\ninv_param_2: %d", UseInv[playerid][i][inv_param_2] );strcat( g_big_string, g_string );
	
	showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
	return 1;
}*/

CMD:card( playerid, params[] ) 
{		
	if( !getItem( playerid, INV_SPECIAL, PARAM_CARD ) )
		return SendClient:( playerid, C_WHITE, !""gbError"В данный момент у Вас отсутствует ID-карта." );
	
	if( sscanf( params, "u", params[0] ) )
		return showIdCard( playerid, playerid );
	
	if( params[0] == playerid )
			return showIdCard( playerid, playerid );
			
	new 
		server_tick = GetTickCount();
	
	if( GetPVarInt( playerid, "Target:CardTime" ) > server_tick )
		return SendClient:( playerid, C_WHITE, !TIME_CMD );
	
	if( !IsLogged( params[0] ) || IsKicked( params[0] ) )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
	
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 
		|| GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) )
		return SendClient:( playerid, C_WHITE, !PLAYER_DISTANCE );
	
	format:g_small_string( ""gbDefault"Вы отправили предложение игроку "cBLUE"%s[%d]"cWHITE" на просмотр Вашей ID-карты",
		GetAccountName( params[0] ),
		params[0]
	);
	SendClient:( playerid, C_WHITE, g_small_string );
			
	clean:<g_big_string>;
	strcat( g_big_string, ""cBLUE"Предложение от игрока\n\n" );
	format:g_small_string( ""cWHITE"Игрок "cBLUE"%s[%d]"cWHITE" предлагает показать Вам ID-карту.\n\n\
	"gbDialog"Ваши действия?",
		GetAccountName( playerid ),
		playerid
	);
	strcat( g_big_string, g_small_string );
	
	showPlayerDialog( params[0], d_target, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Принять", "Отклонить" );

	SetPVarInt( params[0], "Target:PlayerId", playerid );
	SetPVarInt( playerid, "Target:CardTime", server_tick + 5000 );
	
	return 1;
}

CMD:channel( playerid, params[] ) 
{
	if( !getItem( playerid, INV_SPECIAL, PARAM_RADIO ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует рация." );
		
	if( Player[playerid][uJob] == JOB_DRIVETAXI || Player[playerid][uJob] == JOB_PRODUCTS )
		return SendClient:( playerid, C_WHITE, !""gbError"В данный момент Вы не можете воспользоваться портативной рацией." );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /channel [ канал ]");
		
	if( params[0] <= 0 || params[0] > 999 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Данный канал не существует. Существующие каналы: "cGRAY"от 0 до 999"cWHITE"." );
	
	switch( params[0] )
	{
		case 911 : return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
		
		case CHANNEL_CITYHALL :
		{
			if( Player[playerid][uMember] != FRACTION_CITYHALL || !Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
				
			if( !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			new
				rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
			if( !FRank[Player[playerid][uMember] - 1][rank][r_radio] ) 
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		}
	
		case CHANNEL_HOSPITAL :
		{
			if( Player[playerid][uMember] != FRACTION_HOSPITAL  || !Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
				
			if( !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			new
				rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
			if( !FRank[Player[playerid][uMember] - 1][rank][r_radio] ) 
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		}
	
		case CHANNEL_POLICE, CHANNEL_SHERIFF:
		{
			if( Player[playerid][uMember] != FRACTION_POLICE || !Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
				
			if( !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			new
				rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
			if( !FRank[Player[playerid][uMember] - 1][rank][r_radio] ) 
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		}
		
		case CHANNEL_FBI :
		{
			if( Player[playerid][uMember] != FRACTION_FBI || !Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
				
			if( !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			new
				rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
			if( !FRank[Player[playerid][uMember] - 1][rank][r_radio] ) 
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		}
		
		case CHANNEL_NEWS :
		{
			if( Player[playerid][uMember] != FRACTION_NEWS || !Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
				
			if( !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			new
				rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
			if( !FRank[Player[playerid][uMember] - 1][rank][r_radio] ) 
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		}
		
		case CHANNEL_FIRE :
		{
			if( Player[playerid][uMember] != FRACTION_FIRE || !Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
				
			if( !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			new
				rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
			if( !FRank[Player[playerid][uMember] - 1][rank][r_radio] )
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		}
		
		case CHANNEL_WOOD :
		{
			if( Player[playerid][uMember] != FRACTION_WOOD || !Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
				
			if( !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			new
				rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
			if( !FRank[Player[playerid][uMember] - 1][rank][r_radio] ) 
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		}
		
		case CHANNEL_SADOC :
		{
			if( Player[playerid][uMember] != FRACTION_SADOC || !Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			if( PlayerLeaderFraction( playerid, Player[playerid][uMember] - 1 ) ) goto next;
				
			if( !Player[playerid][uRank] )
				return SendClient:( playerid, C_WHITE, !""gbError"Данный канал зашифрован." );
				
			new
				rank = getRankId( playerid, Player[playerid][uMember] - 1 );
			
			if( !FRank[Player[playerid][uMember] - 1][rank][r_radio] ) 
				return SendClient:( playerid, C_WHITE, !NO_ACCESS );
		}
	}
	
	next:	
	Player[playerid][uRadioChannel] = params[0];
	
	pformat:( ""gbDefault"Вы переключили канал своей рации на "cBLUE"%d"cWHITE".", params[0] );
	psend:( playerid, C_WHITE );

	if( Player[playerid][uSettings][8] )
	{
		UpdateRadioInfo( playerid, 1 );
	}
	
	UpdatePlayer( playerid, "uRadioChannel", params[0] );
	PlayerPlaySound( playerid, 21000, 0.0, 0.0, 0.0 );
	
	return 1;
}

CMD:slot( playerid, params[] ) //Настроить подканал рации
{	
	if( !getItem( playerid, INV_SPECIAL, PARAM_RADIO ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует рация." );
	
	if( Player[playerid][uRadioChannel] == 555 || Player[playerid][uRadioChannel] == 535 )
		return SendClient:( playerid, C_WHITE, !""gbError"У данного канала нет подканалов." );
	
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /slot [ подканал ]");
		
	if( params[0] < 1 || params[0] > 99 ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Данный подканал не существует. Существующие подканалы: "cGRAY"от 1 до 99"cWHITE"." );
	
	Player[playerid][uRadioSubChannel] = params[0];	
	
	pformat:( ""gbDefault"Вы переключили подканал своей рации на "cBLUE"%d"cWHITE".", params[0] );
	psend:( playerid, C_WHITE );
	
	if( Player[playerid][uSettings][8] )
	{
		UpdateRadioInfo( playerid, 2 );
	}
	
	UpdatePlayer( playerid, "uRadioSubChannel", params[0] );
	PlayerPlaySound( playerid, 41603, 0.0, 0.0, 0.0 );
	
	return 1;
}

CMD:r( playerid, params[] ) //Общение в канал рации
{
	if( !getItem( playerid, INV_SPECIAL, PARAM_RADIO ) && 
		Player[playerid][uRadioChannel] != CHANNEL_TAXI && 
		Player[playerid][uRadioChannel] != CHANNEL_TRUCKER &&
		Player[playerid][uRadioChannel] != CHANNEL_MECHANIC )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует рация." );
		
	if( !Player[playerid][uRadioChannel] ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Вы не настроили рацию. Для настройки рации используйте - "cBLUE"/channel"cWHITE","cBLUE"/slot"cWHITE".");	
		
	if( isnull( params ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /r [ текст ]");
	
	if( Player[playerid][uJailSettings][2] != 0 || Player[playerid][uJailSettings][4] != 0 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не в состоянии говорить что-то в рацию.");
	
	switch( Player[playerid][uRadioChannel] )
	{
		//Волна таксистов
		case CHANNEL_TAXI:
		{
			if( Player[playerid][uJob] != JOB_DRIVETAXI )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете говорить на этой радиоволне." );
			
			if( !job_duty{playerid} )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете говорить на этой радиоволне." );
				
			if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerVehicleID( playerid ) < cars_taxi[0] ||  GetPlayerVehicleID( playerid ) > cars_taxi[1] )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться в рабочей машине." );
			
			if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться на водительском месте." );
			
			format:g_small_string( "[CH: %d] %s: %s", 
				Player[playerid][uRadioChannel],
				Player[playerid][uRPName], 
				params[0]
			);
		}
		
		//Волна дальнобойщиков
		case CHANNEL_TRUCKER:
		{
			if( Player[playerid][uJob] != JOB_PRODUCTS )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете говорить на этой радиоволне." );
			
			if( !job_duty{playerid} )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете говорить на этой радиоволне." );
				
			if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerVehicleID( playerid ) < cars_prod[0] ||  GetPlayerVehicleID( playerid ) > cars_prod[1] )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться в рабочей машине." );
			
			if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться на водительском месте." );
			
			format:g_small_string( "[CH: %d] %s: %s", 
				Player[playerid][uRadioChannel],
				Player[playerid][uRPName], 
				params[0]
			);
		}
		
		case CHANNEL_MECHANIC:
		{
			if( Player[playerid][uJob] != JOB_MECHANIC )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете говорить на этой радиоволне." );
			
			if( !job_duty{playerid} )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете говорить на этой радиоволне." );
				
			if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerVehicleID( playerid ) < cars_mech[0] ||  GetPlayerVehicleID( playerid ) > cars_mech[1] )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться в рабочей машине." );
			
			if( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
				return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться на водительском месте." );
			
			format:g_small_string( "[CH: %d] %s: %s", 
				Player[playerid][uRadioChannel],
				Player[playerid][uRPName], 
				params[0]
			);
		}
		
		default:
		{
			format:g_small_string( "[CH: %d, S: 1] %s: %s", 
				Player[playerid][uRadioChannel],
				Player[playerid][uRPName], 
				params[0]
			);
		}
		
	}
		
	SendRadioMessage( Player[playerid][uRadioChannel], g_small_string );	
		
	format:g_small_string( ""gbRadio"%s: %s", Player[playerid][uRPName], params[0] );
	ProxDetector( 8.0, playerid, g_small_string, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, 2, 1 );
	
	return 1;
}

CMD:rr( playerid, params[] ) //Общение в подканал рации
{
	if( !getItem( playerid, INV_SPECIAL, PARAM_RADIO ) )
		return SendClient:( playerid, C_WHITE, !""gbError"У Вас отсутствует рация." );
		
	if( isnull( params ) )
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /rr [ текст ]");
	
	if( Player[playerid][uJailSettings][2] != 0 || Player[playerid][uJailSettings][4] != 0 ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Вы не в состоянии говорить что-то в рацию.");
	
	if( !Player[playerid][uRadioChannel] || !Player[playerid][uRadioSubChannel] ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Вы не настроили рацию. Для настройки рации используйте - "cBLUE"/channel"cWHITE", "cBLUE"/slot"cWHITE".");
		
	format:g_small_string( "[CH: %d, S: %d] %s: %s", 
		Player[playerid][uRadioChannel],
		Player[playerid][uRadioSubChannel],
		GetCharacterName( playerid ), 
		params[0]
	);
	
	SendRadioMessageForSubChanel( Player[playerid][uRadioChannel], Player[playerid][uRadioSubChannel], g_small_string );

	format:g_small_string( ""gbRadio"%s: %s", Player[playerid][uRPName], params[0] );
	ProxDetector( 8.0, playerid, g_small_string, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, 2, 1 );
	
	return 1;
}