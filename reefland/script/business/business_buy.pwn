
stock ShowBusinessList( playerid, type, page ) 
{	
	SetPVarInt( playerid, "BBuy:List", page ); 
	SetPVarInt( playerid, "BBuy:Type", type );

	clean: <g_big_string>;
	clean: <g_string>;

	strcat( g_big_string, ""cWHITE"Название\t"cWHITE"Стоимость\n" );

	new 
		idx,
		slot;

	switch( type ) 
	{
		case 1: 
		{
			for( new b = idx; b < MAX_BUSINESS; b++ ) 
			{
				if( BusinessInfo[b][b_id] && BusinessInfo[b][b_user_id] == INVALID_PARAM )
				{
					if( page && idx != page * BBUY_LIST )
					{
						idx++;
						continue;
					}
				
					format:g_string( ""cWHITE"%d. %s #%d \t"cBLUE"$%d\n", 
						idx + ( slot + 1 ),
						GetBusinessType( b ),
						BusinessInfo[b][b_id], 
						BusinessInfo[b][b_price] 
					);

					strcat( g_big_string, g_string );

					g_dialog_select[playerid][slot] = b;
					slot++;

					if( slot == BBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"Следующая страница"cWHITE"" );
						break;
					}
				}							
			}

			if( page || ( page && slot < BBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"Предыдущая страница" );
				
			if( !slot && !page ) 
			{
				SendClient:( playerid, C_GRAY, ""gbError"Нет бизнесов, доступных для покупки." );
				
				return showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. Список всех бизнесов\n\
					2. Сортировка по стоимости\n\
					3. Сортировка по типу бизнеса\n\
					4. Покупка бизнеса по номеру\n\
					5. Продать бизнес", 
				"Выбор", "Назад" );
			}
			
			SetPVarInt( playerid, "BBuy:Last", slot );

			showPlayerDialog( playerid, d_buy_business + 2, DIALOG_STYLE_TABLIST_HEADERS, 
				""cWHITE"Список бизнесов доступных для покупки", g_big_string, "Выбрать", "Назад" );	
		}	
		
		case 2: 
		{
			new 
				price[2]; 

			price[0] = GetPVarInt( playerid, "BBuy:PriceM" ),
			price[1] = GetPVarInt( playerid, "BBuy:PriceH" );
			
			for( new b = idx; b < MAX_BUSINESS; b++ ) 
			{
				if( BusinessInfo[b][b_price] <= price[1] && BusinessInfo[b][b_price] >= price[0] && 
					BusinessInfo[b][b_id] && BusinessInfo[b][b_user_id] == INVALID_PARAM ) 
				{
					if( page && idx != page * BBUY_LIST )
					{
						idx++;
						continue;
					}
					
					format:g_string( ""cWHITE"%d. %s #%d \t"cBLUE"$%d"cWHITE"\n", 
						idx + ( slot + 1 ),
						GetBusinessType( b ),
						BusinessInfo[b][b_id], 
						BusinessInfo[b][b_price] 
					);
					
					strcat( g_big_string, g_string );
						
					g_dialog_select[playerid][slot] = b;
					slot++;
					
					if( slot == BBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"Следующая страница"cWHITE"" );
						break;
					}	
				}	
			}
			
			if( page || ( page && slot < BBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"Предыдущая страница" );
			
			if( !slot && !page ) 
			{
				showPlayerDialog( playerid, d_buy_business + 4, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Сортировка по стоимости\n\n\
					"cWHITE"Укажите диапазон цен для просмотра интересующих Вас бизнесов\
					\nПример: "cBLUE"60000-200000\n\n\
					"gbDialogError"По данному запросу бизнесов не найдено.", "Ввод", "Назад" );
				SetPVarInt( playerid, "BBuy:case", 2 );
				return 1;
			}
			
			SetPVarInt( playerid, "BBuy:Last", slot );
			
			showPlayerDialog( playerid, d_buy_business + 2, DIALOG_STYLE_TABLIST_HEADERS, 
				""cWHITE"Список бизнесов доступных для покупки", g_big_string, "Выбор", "Назад" );
		}
		
		case 3:
		{
			new
				btype = GetPVarInt( playerid, "BBuy:btype" );
			
			for( new b = idx; b < MAX_BUSINESS; b++ )
			{
				if( btype == BusinessInfo[b][b_type] && 
					BusinessInfo[b][b_id] && BusinessInfo[b][b_user_id] == INVALID_PARAM )
				{
					if( page && idx != page * BBUY_LIST )
					{
						idx++;
						continue;
					}
				
					format:g_string( ""cWHITE"%d. %s #%d \t"cBLUE"$%d"cWHITE"\n", 
						idx + ( slot + 1 ),
						GetBusinessType( b ),
						BusinessInfo[b][b_id], 
						BusinessInfo[b][b_price] 
					);
					strcat( g_big_string, g_string );
					
					g_dialog_select[playerid][slot] = b;
					slot++;

					if( slot == BBUY_LIST ) 
					{
						strcat( g_big_string, ""#gbDialog"Следующая страница"cWHITE"" );
						break;
					}	
				}
			}
			
			if( page || ( page && slot < BBUY_LIST ) ) 
				strcat( g_big_string, "\n"#gbDialog"Предыдущая страница" );
			
			if( !slot && !page ) 
			{
				SendClient:( playerid, C_WHITE , ""gbError"По данному запросу бизнесов не найдено." );
				showPlayerDialog( playerid, d_buy_business + 5, DIALOG_STYLE_LIST, 
					"Сортировка по типу бизнеса",
					"1. "cGRAY"Закусочные"cWHITE"\ 
					 \n2. "cGRAY"Рестораны"cWHITE"\
					 \n3. "cGRAY"Бары"cWHITE"\
					 \n4. "cGRAY"Магазины"cWHITE"", 
					"Выбор", "Закрыть" 
				);
				SetPVarInt( playerid, "BBuy:case", 3 );
				return 1;
			}
			
			SetPVarInt( playerid, "BBuy:Last", slot );

			showPlayerDialog( playerid, d_buy_business + 2, DIALOG_STYLE_TABLIST_HEADERS, 
				""cWHITE"Список бизнесов доступных для покупки", g_big_string, "Выбрать", "Назад" );
		}
		
		case 4:
		{
			new 
				count = 0;
				
			for( new i; i < MAX_PLAYER_BUSINESS; i++ ) 
			{
				if( Player[playerid][tBusiness][i] != INVALID_PARAM ) 
				{
					new
						bid = Player[playerid][tBusiness][i];
				
					format:g_string( ""cWHITE"%s #%d \t"cBLUE"$%d"cWHITE"\n", 
						GetBusinessType( bid ),
						BusinessInfo[bid][b_id], 
						BusinessInfo[bid][b_price] 
					);

					strcat( g_big_string, g_string );

					g_dialog_select[playerid][count] = bid;

					count++;
				}
			}
			
			if( !count ) 
			{
				SendClient:( playerid, C_WHITE , ""gbError"Вы не являетесь владельцем бизнеса." );
				return showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. Список всех бизнесов\n\
					2. Сортировка по стоимости\n\
					3. Сортировка по типу бизнеса\n\
					4. Покупка бизнеса по номеру\n\
					5. Продать бизнес", 
				"Выбор", "Назад" );
			}
			
			showPlayerDialog( playerid, d_buy_business + 7, DIALOG_STYLE_TABLIST_HEADERS, 
				""cWHITE"Список Ваших бизнесов", g_big_string, "Продать", "Назад" );
		}
	}	

	return 1;
}

stock ShowBusinessBuyMenu( playerid, b ) 
{
	new
		zone[28];
		
	SetPVarInt( playerid, "BBuy:Business", b );
	SetPVarInt( playerid, "BBuy:Camera", 1 );
	
	new Float: dist = 12.0, Float: pos[4];
	
	GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
	
	SetPVarFloat( playerid, "BBuy:pos_buy_x", pos[0] ),
	SetPVarFloat( playerid, "BBuy:pos_buy_y", pos[1] ),
	SetPVarFloat( playerid, "BBuy:pos_buy_z", pos[2] );
	
	SetPlayerInterior( playerid, 0 );
	SetPlayerVirtualWorld( playerid, 1001 );
	
	setPlayerPos( playerid, 
				  BusinessInfo[b][b_enter_pos][0] + 15.0 * -floatsin( BusinessInfo[b][b_enter_pos][3] + 180.0, degrees ),
				  BusinessInfo[b][b_enter_pos][1] + 15.0 * floatcos( BusinessInfo[b][b_enter_pos][3] + 180.0, degrees ),
				  BusinessInfo[b][b_enter_pos][2] 
	);
					
	InterpolateCameraPos( playerid, 
						  BusinessInfo[b][b_enter_pos][0], 
						  BusinessInfo[b][b_enter_pos][1], 
						  BusinessInfo[b][b_enter_pos][2],
						  BusinessInfo[b][b_enter_pos][0] + dist * -floatsin( BusinessInfo[b][b_enter_pos][3] + 180.0, degrees ), 
						  BusinessInfo[b][b_enter_pos][1] + dist * floatcos( BusinessInfo[b][b_enter_pos][3] + 180.0, degrees ), 
						  BusinessInfo[b][b_enter_pos][2], 600, 1000 
	);
	
	InterpolateCameraLookAt( playerid, 
							 BusinessInfo[b][b_enter_pos][0], 
							 BusinessInfo[b][b_enter_pos][1], 
							 BusinessInfo[b][b_enter_pos][2],
							 BusinessInfo[b][b_enter_pos][0], 
							 BusinessInfo[b][b_enter_pos][1], 
							 BusinessInfo[b][b_enter_pos][2], 600, 1000
	);	
	
	GetPos2DZone( BusinessInfo[b][b_enter_pos][0], BusinessInfo[b][b_enter_pos][1], zone, 28 );
	
	format:g_string( "\
		"cBLUE"Информация о бизнесе\n\n\
		"cWHITE"Номер: "cBLUE"%d\n\
		"cWHITE"Тип бизнеса: "cBLUE"%s\n\
		"cWHITE"Рыночная стоимость: "cBLUE"$%d\n\
		"cWHITE"Район: "cBLUE"%s",
		BusinessInfo[b][b_id], 
		GetBusinessType( b ), 
		BusinessInfo[b][b_price], 
		zone
	);
		
	showPlayerDialog( playerid, d_buy_business + 3, DIALOG_STYLE_MSGBOX, " ", g_string, "Купить", "Назад" );
	
	return 1;
}

