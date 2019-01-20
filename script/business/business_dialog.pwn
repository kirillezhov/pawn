
function Business_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_buy_business: 
		{
			if( !response ) 
			{	
				DeletePVar( playerid, "Enter:BId" ); 
				return 1;
			}
			
			new
				b = GetPVarInt( playerid, "Enter:BId" );
			
			if( !IsPlayerInRangeOfPoint( playerid, 2.0, BusinessInfo[b][b_enter_pos][0], BusinessInfo[b][b_enter_pos][1], BusinessInfo[b][b_enter_pos][2] ) )
			{
				DeletePVar( playerid, "Enter:BId" ); 
				return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться рядом с входной дверью." );
			}
			
			setPlayerPos( playerid, BusinessInfo[b][b_exit_pos][0],
									BusinessInfo[b][b_exit_pos][1],
									BusinessInfo[b][b_exit_pos][2] );
			SetPlayerFacingAngle( playerid, BusinessInfo[b][b_exit_pos][3] );
			
			Player[playerid][tgpsPos][0] = BusinessInfo[b][b_enter_pos][0];
			Player[playerid][tgpsPos][1] = BusinessInfo[b][b_enter_pos][1];
			Player[playerid][tgpsPos][2] = BusinessInfo[b][b_enter_pos][2];
	
			SetPlayerVirtualWorld( playerid, BusinessInfo[b][b_id] );						
			setHouseWeather( playerid );
			//stopPlayer( playerid, 1 );
		}
		
		case d_buy_business + 1:
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_buy_menu, DIALOG_STYLE_LIST, 
					"Агентство недвижимости", 
					"1. "cGRAY"Каталог жилья"cWHITE"\n\
					2. "cGRAY"Каталог бизнесов", 
				"Выбор", "Закрыть" );
			}
			
			switch( listitem ) 
			{
				case 0: 
				{// Список всех бизнесов
					ShowBusinessList( playerid, 1, 0 );
					SetPVarInt( playerid, "BBuy:case", 1 );
				}
				case 1:
				{
					// Сортировка по ценовой категории
					showPlayerDialog( playerid, d_buy_business + 4, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Сортировка по стоимости\n\n\
					"cWHITE"Укажите диапазон цен для просмотра интересующих Вас бизнесов\
					\nПример: "cBLUE"60000-200000", "Ввод", "Назад" );
					SetPVarInt( playerid, "BBuy:case", 2 );
				}
				case 2: 
				{	// Сортировка по типу бизнеса
					showPlayerDialog( playerid, d_buy_business + 5, DIALOG_STYLE_LIST, "Сортировка по типу бизнеса",
						"1. "cGRAY"Закусочные"cWHITE"\n\ 
						 2. "cGRAY"Рестораны"cWHITE"\n\
						 3. "cGRAY"Бары"cWHITE"\n\
						 4. "cGRAY"Магазины"cWHITE"", 
					"Выбор", "Закрыть" );
					SetPVarInt( playerid, "BBuy:case", 3 );
				}
				case 3: 
				{
					showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Покупка недвижимости\n\n\
						"cWHITE"Укажите номер бизнеса:", "Ввод", "Назад" );
				}
				case 4: 
				{
					//Список бизнесов игрока
					ShowBusinessList( playerid, 4, 0 );
				}
				
			}
		}
		
		case d_buy_business + 2:
		{
			if( !response )
			{
				SetPVarInt( playerid, "BBuy:List", -1 );
				
				switch( GetPVarInt( playerid, "BBuy:case" ) )
				{
					case 1:
					{
						DeletePVar( playerid, "BBuy:case" );
						return showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
								"1. Список всех бизнесов\n2. Сортировка по стоимости\
								\n3. Сортировка по типу бизнеса\n4. Покупка бизнеса по номеру\
								\n5. Продать бизнес", "Выбор", "Назад" 
								);
					}
					
					case 2:
					{
						return showPlayerDialog( playerid, d_buy_business + 4, DIALOG_STYLE_INPUT, " ", 
							""cBLUE"Сортировка по стоимости\n\n\
							"cWHITE"Укажите диапазон цен для просмотра интересующих Вас бизнесов\
							\nПример: "cBLUE"60000-200000", "Ввод", "Назад" );
					}
					
					case 3:
					{
					
						return showPlayerDialog( playerid, d_buy_business + 5, DIALOG_STYLE_LIST, "Сортировка по типу бизнеса",
							"1. "cGRAY"Закусочные"cWHITE"\n\ 
							 2. "cGRAY"Рестораны"cWHITE"\n\
							 3. "cGRAY"Бары"cWHITE"\n\
							 4. "cGRAY"Магазины"cWHITE"", 
						"Выбор", "Закрыть" );
					}
					
					case 4:
					{
						return showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"Покупка недвижимости\n\n\
							"cWHITE"Укажите номер бизнеса:",
							"Ввод", "Назад" );
					}
				}
			}
			
			if( listitem == BBUY_LIST ) 
			{
				return ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) + 1 );
			}
			else if( listitem == BBUY_LIST + 1 || 
				listitem == GetPVarInt( playerid, "BBuy:Last" ) && GetPVarInt( playerid, "BBuy:Last" ) < BBUY_LIST ) 
			{
				return ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) - 1 );
			}
			
			ShowBusinessBuyMenu( playerid, g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_buy_business + 3:
		{
			setPlayerPos( playerid,
				GetPVarFloat( playerid, "BBuy:pos_buy_x" ),
				GetPVarFloat( playerid, "BBuy:pos_buy_y" ),
				GetPVarFloat( playerid, "BBuy:pos_buy_z") 
			);
				
			SetCameraBehindPlayer( playerid );
			
			SetPlayerVirtualWorld( playerid, 13 ), 
			SetPlayerInterior( playerid, 1 );
				
			DeletePVar( playerid, "BBuy:pos_buy_x" ), 
			DeletePVar( playerid, "BBuy:pos_buy_y" ),
			DeletePVar( playerid, "BBuy:pos_buy_z" ),
			DeletePVar( playerid, "BBuy:Camera" );
			
			if( response ) 
			{
				new 
					b = GetPVarInt( playerid, "BBuy:Business" );
				
				if( IsOwnerBusinessCount( playerid ) >= 1 + Premium[playerid][prem_business] ) 
				{
					ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) );
					return SendClient:( playerid, C_WHITE, ""gbError"У Вас уже есть бизнес." );
				}
				
				if( BusinessInfo[b][b_price] > Player[playerid][uMoney] ) 
				{
					ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) );
					return SendClient:( playerid, C_GRAY, ""gbError"У Вас недостаточно средств для покупки этого бизнеса." );
				}
				
				if( BusinessInfo[b][b_user_id] != INVALID_PARAM )
				{
					ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) );
					return SendClient:( playerid, C_WHITE, ""gbError"Этот бизнес был приобретен кем-то ранее." );
				}

				BusinessInfo[b][b_user_id] = Player[playerid][uID];
				UpdateBusiness( b, "b_user_id", BusinessInfo[b][b_user_id] );
				
				BusinessInfo[b][b_products] = 1000;
				UpdateBusiness( b, "b_products", BusinessInfo[b][b_products] );
				
				SetPlayerCash( playerid, "-", BusinessInfo[b][b_price] );
				
				format:g_small_string( "купил%s собственный бизнес", SexTextEnd( playerid ) );
				MeAction( playerid, g_small_string, 1 );
			
				InsertPlayerBusiness( playerid, b );
				
				log( LOG_BUY_BUSINESS, "купил бизнес", Player[playerid][uID], BusinessInfo[b][b_id] );
				
				pformat:(""gbSuccess"Вы стали владельцем "cBLUE"%s #%d"cWHITE". Для управления бизнесом используйте команду "cBLUE"/bpanel"cWHITE".", GetBusinessType( b ), BusinessInfo[b][b_id] );
				psend:( playerid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
			}
			else
			{
				if( GetPVarInt( playerid, "BBuy:case" ) == 4 )
				{
					SetPVarInt( playerid, "BBuy:case", INVALID_PLAYER_ID );
					return showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. Список всех бизнесов\n2. Сортировка по стоимости\
					\n3. Сортировка по типу бизнеса\n4. Покупка бизнеса по номеру\
					\n5. Продать бизнес", "Выбор", "Назад" );
					
				}
				
				ShowBusinessList( playerid, GetPVarInt( playerid, "BBuy:Type" ), GetPVarInt( playerid, "BBuy:List" ) );
			}
						
			DeletePVar( playerid, "BBuy:Business" );
		}
		
		
		case d_buy_business + 4:
		{
			if( !response ) 
			{
				showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. Список всех бизнесов\n2. Сортировка по стоимости\
					\n3. Сортировка по типу бизнеса\n4. Приобретение бизнеса по его номеру\
					\n5. Продать бизнес", "Выбор", "Назад" );
				return 1;
			}
			
			if( sscanf( inputtext, "p<->a<d>[2]", inputtext[0], inputtext[1] ) || inputtext[1] <= inputtext[0] ) 
			{
				showPlayerDialog( playerid, d_buy_business + 4, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Сортировка по стоимости\n\n\
					"cWHITE"Укажите диапазон цен для просмотра интересующих Вас бизнесов\
					\nПример: "cBLUE"60000-200000\n\n\
					"gbDialogError"Вы неправильно указали диапазон.",
				"Ввод", "Назад" );
				return 1;
			}
			
			SetPVarInt( playerid, "BBuy:PriceM", inputtext[0] ), 
			SetPVarInt( playerid, "BBuy:PriceH", inputtext[1] );
			DeletePVar( playerid, "BBuy:Business" );
			ShowBusinessList( playerid, 2, 0 );
		}
		
		case d_buy_business + 5:
		{
			if( !response ) 
			{
				showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. Список всех бизнесов\n2. Сортировка по стоимости\
					\n3. Сортировка по типу бизнеса\n4. Покупка бизнеса по номеру\
					\n5. Продать бизнес", "Выбор", "Назад" );
				return 1;
			}
			
			SetPVarInt( playerid, "BBuy:btype", listitem );
			ShowBusinessList( playerid, 3, 0 );
			
		}
		
		
		case d_buy_business + 6:
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. Список всех бизнесов\n2. Сортировка по стоимости\
					\n3. Сортировка по типу бизнеса\n4. Покупка бизнеса по номеру\
					\n5. Продать бизнес", "Выбор", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Покупка недвижимости\n\n\
					"cWHITE"Укажите номер бизнеса:\n\
					"gbDialogError"Неверное значение.", "Ввод", "Назад" );
			}
			
			for( new b; b < MAX_BUSINESS; b++ )
			{
				if( BusinessInfo[b][b_id] == strval( inputtext ) )
				{
					if( BusinessInfo[b][b_user_id] != INVALID_PARAM )
					{
						return showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"Покупка недвижимости\n\n\
							"cWHITE"Укажите номер бизнеса:\n\
							"gbDialogError"Этим бизнесом владеет кто-то другой.",
						"Ввод", "Назад" );
					}
					
					ShowBusinessBuyMenu( playerid, b );
					SetPVarInt( playerid, "BBuy:case", 4 );
					return 1;
				}
			}
			
			showPlayerDialog( playerid, d_buy_business + 6, DIALOG_STYLE_INPUT, " ", "\
				"cBLUE"Покупка недвижимости\n\n\
				"cWHITE"Укажите номер бизнеса:\n\
				"gbDialogError"Такого бизнеса не существует. ",
				"Ввод", "Назад" );
		}
		
		
		case d_buy_business + 7:
		{
			if( !response )
			{
				showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
					"1. Список всех бизнесов\n2. Сортировка по стоимости\
					\n3. Сортировка по типу бизнеса\n4. Покупка бизнеса по номеру\
					\n5. Продать бизнес", "Выбор", "Назад" 
				);
				return 1;
			}
			
			SetPVarInt( playerid, "BBuy:BId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			showPlayerDialog( playerid, d_buy_business + 8, DIALOG_STYLE_LIST,
				"Продажа недвижимости", 
				""cWHITE"1. "cGRAY"Продать бизнес агентству"cWHITE" \
				\n2. "cGRAY"Продать бизнес игроку",
				"Выбор", "Назад" 
			);	
		}

		
		case d_buy_business + 8:
		{
				
			if( !response )
			{
				ShowBusinessList( playerid, 4, 0 );
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					new
						businessid = GetPVarInt( playerid, "BBuy:BId" );
						
					format:g_string( "\
						"cBLUE"Продажа бизнеса\n\
						"cWHITE"Ваш %s #%d будет продан агентству за $%d.",
						GetBusinessType( businessid ),
						BusinessInfo[businessid][b_id],
						floatround( BusinessInfo[businessid][b_price] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) 
					);
						
						
					showPlayerDialog( playerid, d_buy_business + 11, DIALOG_STYLE_MSGBOX, " ", g_string, 
						"Продать", "Отмена" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Продать бизнес игроку\n\n\
						"cWHITE"Для продажи бизнеса игроку, введите его ID:", "Ввод", "Назад" );
				}
			}
		}
		
		
		case d_buy_business + 9:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_buy_business + 8, DIALOG_STYLE_LIST,
					"Продажа недвижимости", 
					"1. "cGRAY"Продать бизнес агентству"cWHITE" \
					\n2. "cGRAY"Продать бизнес игроку",
				"Выбор", "Назад" );
			}
		
			if( inputtext[0] == EOS ) 
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа бизнеса.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать бизнес:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Введите id игрока.", 
				"Далее", "Назад" );
			}	
					
			if( !IsLogged( strval( inputtext ) ) || strval( inputtext ) == playerid ) 
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа бизнеса.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать бизнес:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы ввели некорректный id игрока.", 
				"Далее", "Назад" );
			}
					
			if( IsOwnerBusinessCount( strval( inputtext ) ) >= 1 + Premium[ strval( inputtext ) ][prem_business] ) 
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа бизнеса.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать бизнес:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Данный игрок уже имеет бизнес.", 
				"Далее", "Назад" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 )
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа бизнеса.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать бизнес:\n\n\
					"gbDialogError"Игрок должен находиться рядом с Вами.", 
				"Далее", "Назад" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа бизнеса.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать бизнес:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы не можете взаимодействовать с данным игроком.", 
				"Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "BBuy:PlayerID", strval( inputtext ) );
			ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), " " );
		}
		
		
		case d_buy_business + 10:
		{
			//new 
			//	sellid = GetPVarInt( playerid, "BBuy:PlayerID" );
			
			if( !response )
			{
				DeletePVar( playerid, "BBuy:PlayerID" );
				return showPlayerDialog( playerid, d_buy_business + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продать бизнес игроку\n\n\
					"cWHITE"Для продажи бизнеса игроку, введите его ID:", "Ввод", "Назад" );
			}
			
			if( inputtext[0] == EOS ) 
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"Введите сумму ниже:" );
			}
			
			if( !IsNumeric( inputtext ) )
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"Введите сумму ниже:" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, GetPVarInt( playerid, "BBuy:PlayerID" ) ) > 3.0 )
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"Игрок должен находиться рядом с Вами." );
			}
			
			if( strval( inputtext ) < floatround( BusinessInfo[GetPVarInt( playerid, "BBuy:BId" )][b_price] * 0.5 ) ||  strval( inputtext ) > ( BusinessInfo[GetPVarInt( playerid, "BBuy:BId" )][b_price] * 2 ) )
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"Указанная сумма выходит за рамки допустимого диапазона." );
			}
		
			if( Player[GetPVarInt( playerid, "BBuy:PlayerID" )][uMoney] < strval( inputtext ) ) 
			{
				return ShowDialogBusinessSell( playerid, GetPVarInt( playerid, "BBuy:BId" ), "\n\n"gbDialogError"У игрока нет необходимого количества наличных денег." );
			}
			
			pformat:( ""gbSuccess"Вы отправили предложение игроку "cBLUE"%s[%d]"cWHITE" о продаже "cBLUE"%s #%d"cWHITE".",
				GetAccountName( GetPVarInt( playerid, "BBuy:PlayerID" ) ),
				GetPVarInt( playerid, "BBuy:PlayerID" ),
				GetBusinessType( GetPVarInt( playerid, "BBuy:BId" ) ),
				BusinessInfo[GetPVarInt( playerid, "BBuy:BId" )][b_id]
			);
			
			psend:( playerid, C_WHITE ); 
			
			format:g_big_string( 
				""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" предлагает Вам\n\ 
				приобрести его "cBLUE"%s #%d"cWHITE" за "cBLUE"$%d"cWHITE".",
				GetAccountName( playerid ),
				playerid,
				GetBusinessType( GetPVarInt( playerid, "BBuy:BId" ) ),
				BusinessInfo[GetPVarInt( playerid, "BBuy:BId" )][b_id],
				strval( inputtext )
			);
			
			showPlayerDialog( GetPVarInt( playerid, "BBuy:PlayerID" ), d_buy_business + 12, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Да", "Нет" );
			
			g_player_interaction{GetPVarInt( playerid, "BBuy:PlayerID" )} = 1;
			
			SetPVarInt( GetPVarInt( playerid, "BBuy:PlayerID" ), "BBuy:SellID", playerid );
			SetPVarInt( GetPVarInt( playerid, "BBuy:PlayerID" ), "BBuy:Price", strval( inputtext ) );
			SetPVarInt( GetPVarInt( playerid, "BBuy:PlayerID" ), "BBuy:BId", GetPVarInt( playerid, "BBuy:BId" ) );
			
			DeletePVar( playerid, "BBuy:PlayerID" );
			DeletePVar( playerid, "BBuy:BId" );
		}
		
		
		case d_buy_business + 11:
		{
			new
				businessid = GetPVarInt( playerid, "BBuy:BId" );
			if( !response )
			{
				return showPlayerDialog( playerid, d_buy_business + 8, DIALOG_STYLE_LIST,
					"Продажа недвижимости", 
					"1. "cGRAY"Продать бизнес агентству"cWHITE" \
					\n2. "cGRAY"Продать бизнес игроку",
				"Выбор", "Назад" );
			}
			
			SellBusiness( businessid );
			
			Player[playerid][uMoney] += floatround( BusinessInfo[businessid][b_price] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) );
				
			UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );
			
			pformat:( ""gbSuccess"Вы продали бизнес агентству за "cBLUE"$%d"cWHITE".", floatround( BusinessInfo[businessid][b_price] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) );
			psend:( playerid, C_WHITE ); 
			
			RemovePlayerBusiness( playerid, businessid );
			g_player_interaction{playerid} = 0;
			
			SetPVarInt( playerid, "BBuy:BId", INVALID_PLAYER_ID );
		}
		
		case d_buy_business + 12:
		{
			new 
				sellid = GetPVarInt( playerid, "BBuy:SellID" ),
				price = GetPVarInt( playerid, "BBuy:Price" ),
				businessid = GetPVarInt( playerid, "BBuy:BId" );
			
			if( !IsLogged( sellid ) ) 
			{
				SendClient:( playerid, C_GRAY, !""gbError"Продавец не в сети, операция прервана!" );
					
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			if( !response )
			{
				pformat:(""gbError"Вы отказались от покупки бизнеса у игрока "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( sellid ),
					sellid
				);
				
				psend:( playerid, C_WHITE );
				
				pformat:(""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от покупки Вашего бизнеса.",
					GetAccountName( playerid ),
					playerid
				);
				
				psend: ( sellid, C_WHITE );

				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				DeletePVar( playerid, "BBuy:BId" );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				return 1;
			}
				
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_GRAY, !NO_MONEY );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"У игрока "cBLUE"%s[%d]"cWHITE" не оказалось необходимого количества денег.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				
				return 1;
			}
			
			if( GetDistanceBetweenPlayers( playerid, sellid ) > 3.0 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Владелец бизнеса находится слишком далеко от Вас." );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"Игрок "cBLUE"%s[%d]"cWHITE" находится слишком далеко от Вас.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				
				return 1;
			}
			
			if( IsOwnerBusinessCount( playerid ) >= 1 + Premium[ playerid ][prem_business] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Операция прервана. Вы уже имеете бизнес." );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"Операция прервана. Игрок "cBLUE"%s[%d]"cWHITE" уже имеет бизнес.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				
				return 1;
			}			
				
			SetPlayerCash( sellid, "+", price );
			SetPlayerCash( playerid, "-", price );
				
			OfferSalePlayerBusiness( sellid, playerid, businessid );
				
			pformat:( ""gbSuccess"Вы купили "cBLUE"%s #%d"cWHITE" у игрока "cBLUE"%s[%d]"cWHITE" за $%d.",
				GetBusinessType( businessid ),
				BusinessInfo[businessid][b_id],
				GetAccountName( sellid ),
				sellid,
				price
			);
			psend:( playerid, C_WHITE );
				
			pformat:( ""gbSuccess"Вы продали "cBLUE"%s #%d"cWHITE" игроку "cBLUE"%s[%d]"cWHITE" за $%d.",
				GetBusinessType( businessid ),
				BusinessInfo[businessid][b_id],
				GetAccountName( playerid ),
				playerid,
				price
			);
			psend:( sellid, C_WHITE );
				
			g_player_interaction{playerid} = 0;
			g_player_interaction{sellid} = 0;
				
			log( LOG_BUY_BUSINESS_FROM_PLAYER, "купил бизнес у", Player[playerid][uID], Player[sellid][uID], price );
				
			DeletePVar( playerid, "BBuy:BId" ), 
			DeletePVar( playerid, "BBuy:SellID" ),
			DeletePVar( playerid, "BBuy:Price" );		
		}
		
//----------------------------------------Диалоги с /bpanel--------------------------
//-----------------------------------------------------------------------------------
		
		case d_business_panel:
		{
			if( !response )
			{
				SetPVarInt( playerid, "Bpanel:BId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Bpanel:Interior", INVALID_PLAYER_ID );
			
				CancelSelectTextDraw( playerid );
				return 1;
			}
			
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" ),
				hour;
				
			if( BusinessInfo[businessid][b_products_time] >= gettime() && !BusinessInfo[businessid][b_products] )
			{
				hour = floatround ( ( 259200 - ( BusinessInfo[businessid][b_products_time] - gettime() ) ) / 1200 );
			}
			else
			{
				hour = 0;
			}
			
			switch( listitem )
			{
				case 0:
				{
					format:g_big_string( "\
						"cWHITE"Информация о бизнесе\n\n\
						"cBLUE"%s"cWHITE"\n\
						Номер: "cBLUE"%d"cWHITE"\n\n\
						Двери: %s\n\n\
						Владелец: "cBLUE"%s"cWHITE"\n\
						Тип бизнеса: "cBLUE"%s"cWHITE"\n\
						Интерьер: "cBLUE"#%d"cWHITE"\n\
						Рыночная стоимость: "cBLUE"$%d"cWHITE"\n\n\
						Заполненность склада: "cBLUE"%d/%d"cWHITE"\n\n\
						Мебель: "cBLUE"%d/%d"cWHITE" ед.\n\n\
						Расширенный склад: %s\n\
						Расширенный прилавок: %s\n\n\
						Простаивание: "cBLUE"%d"cWHITE" ч.",
						BusinessInfo[businessid][b_name],
						BusinessInfo[businessid][b_id],
						BusinessInfo[businessid][b_lock] ? (""cBLUE"открыты"cWHITE"") : 
														   (""cRED"закрыты"cWHITE""),
						Player[playerid][uName],
						GetBusinessType( businessid ),
						BusinessInfo[businessid][b_interior],
						BusinessInfo[businessid][b_price],
						BusinessInfo[businessid][b_products], BusinessInfo[businessid][b_improve][2],
						BusinessInfo[businessid][b_count_furn], GetMaxFurnBusiness( businessid ),
						BusinessInfo[businessid][b_improve][0] ? (""cBLUE"да"cWHITE"") : 
																 (""cRED"нет"cWHITE""),
						BusinessInfo[businessid][b_improve][1] ? (""cBLUE"да"cWHITE"") : 
																 (""cRED"нет"cWHITE""),
						hour
					);
					
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть","" );
				}
					
				case 1:
				{
					format:g_string( b_panel_p2, 
						BusinessInfo[businessid][b_improve][0] ? (""cBLUE"есть") : (""cGRAY"нет"),
						BusinessInfo[businessid][b_improve][1] ? (""cBLUE"есть") : (""cGRAY"нет")
					);
					showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Купить", "Назад" );
				}
				
				case 2:
				{
					format:g_string( "Сейф - "cBLUE"$%d", BusinessInfo[businessid][b_safe] );
					showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "Выбрать", "Назад" );
				}
				
				case 3:
				{
					format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] );
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
				}
			}
		}
		
		case d_business_panel + 1:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "Выбрать", "Закрыть" );
			}
			
			switch( listitem )
			{
				case 0:
				{
					if( BusinessInfo[businessid][b_improve][0] )
					{
						format:g_string( b_panel_p2, 
							BusinessInfo[businessid][b_improve][0] ? (""cBLUE"есть") : (""cGRAY"нет"),
							BusinessInfo[businessid][b_improve][1] ? (""cBLUE"есть") : (""cGRAY"нет")
						);
						
						return SendClient:( playerid, C_GRAY, ""gbError"Склад этого бизнеса уже расширен." ),
							   showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Купить", "Назад" );
					}
					
					format:g_small_string( "\
						"cBLUE"Расширение склада\n\n\
						"cWHITE"Склад бизнеса будет расширен в два раза.\n\
						Склад сможет вмещать большее количество товаров.\n\n\
						"gbDialog"Стоимость расширения "cBLUE"$%d"cWHITE".", GetPriceImprove( businessid ) );
					
					showPlayerDialog( playerid, d_business_panel + 2, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Купить", "Назад" );	
				}
				
				case 1:
				{
					if( BusinessInfo[businessid][b_improve][1] )
					{
						format:g_string( b_panel_p2, 
							BusinessInfo[businessid][b_improve][0] ? (""cBLUE"есть") : (""cGRAY"нет"),
							BusinessInfo[businessid][b_improve][1] ? (""cBLUE"есть") : (""cGRAY"нет")
						);
						
						return SendClient:( playerid, C_GRAY, ""gbError"Прилавок этого бизнеса уже расширен." ),
							   showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Купить", "Назад" );
					}
					
					format:g_small_string( "\
						"cBLUE"Расширение прилавка\n\n\
						"cWHITE"Прилавок бизнеса будет расширен в два раза.\n\
						Вы сможете продавать большее количество товаров.\n\n\
						"gbDialog"Стоимость расширения "cBLUE"$%d"cWHITE".", GetPriceImprove2( businessid ) );
					
					showPlayerDialog( playerid, d_business_panel + 3, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Купить", "Назад" );
				}
				
				case 2:
				{
					showPlayerDialog( playerid, d_mebelbuy + 5, DIALOG_STYLE_LIST, " ", furniture_other, "Выбрать", "Назад" );
				}
			}
		}
		
		case d_business_panel + 2:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( b_panel_p2, 
					BusinessInfo[businessid][b_improve][0] ? (""cBLUE"есть") : (""cGRAY"нет"),
					BusinessInfo[businessid][b_improve][1] ? (""cBLUE"есть") : (""cGRAY"нет")
				);
						
				return showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Купить", "Назад" ); 
			}
			
			if( BusinessInfo[businessid][b_safe] < GetPriceImprove( businessid ) )
			{
				SendClient:( playerid, C_WHITE, ""gbError"В сейфе бизнеса недостаточно средств для расширения склада." );
			
				format:g_string( b_panel_p2, 
					BusinessInfo[businessid][b_improve][0] ? (""cBLUE"есть") : (""cGRAY"нет"),
					BusinessInfo[businessid][b_improve][1] ? (""cBLUE"есть") : (""cGRAY"нет")
				);
						
				return showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Купить", "Назад" ); 
			}
			
			BusinessInfo[businessid][b_safe] -= GetPriceImprove( businessid );
			UpdateBusiness( businessid, "b_safe", BusinessInfo[businessid][b_safe] );
			
			BusinessInfo[businessid][b_improve][0] = 1;
			BusinessInfo[businessid][b_improve][2] = 100000;
			
			UpdateBusinessSlash( businessid, "b_improve", BusinessInfo[businessid][b_improve] );
		
			showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "Выбрать", "Закрыть" );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Склад расширен, теперь он может вмещать до "cBLUE"100000"cWHITE" товаров." );
		}
		
		case d_business_panel + 3:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( b_panel_p2, 
					BusinessInfo[businessid][b_improve][0] ? (""cBLUE"есть") : (""cGRAY"нет"),
					BusinessInfo[businessid][b_improve][1] ? (""cBLUE"есть") : (""cGRAY"нет")
				);
						
				return showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_LIST, " ", g_string, "Купить", "Назад" ); 
			}
			
			if( BusinessInfo[businessid][b_safe] < GetPriceImprove2( businessid ) )
			{
				SendClient:( playerid, C_WHITE, ""gbError"В сейфе бизнеса недостаточно средств для расширения прилавка." );
			
				format:g_string( b_panel_p2, 
					BusinessInfo[businessid][b_improve][0] ? (""cBLUE"есть") : (""cGRAY"нет"),
					BusinessInfo[businessid][b_improve][1] ? (""cBLUE"есть") : (""cGRAY"нет")
				);
						
				return showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Купить", "Назад" );
			}
			
			BusinessInfo[businessid][b_safe] -= GetPriceImprove2( businessid );
			UpdateBusiness( businessid, "b_safe", BusinessInfo[businessid][b_safe] );
			
			BusinessInfo[businessid][b_improve][1] = 1;
			
			UpdateBusinessSlash( businessid, "b_improve", BusinessInfo[businessid][b_improve] );
			
			showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "Выбрать", "Закрыть" );
		
			SendClient:( playerid, C_WHITE, ""gbSuccess"Прилавок расширен, теперь Вы можете продавать больше товаров." );
		}
		
		//Диалог сейфа
		case d_business_panel + 4:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "Выбрать", "Закрыть" );
			}
			
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_business_panel + 5, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Пополнение сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете положить:", 
					"Далее", "Назад" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_business_panel + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Взять деньги из сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете взять:", 
					"Далее", "Назад" );
				}
			}
		}
		
		case d_business_panel + 5:
		{
			new 
				bid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( "Сейф - "cBLUE"$%d", BusinessInfo[bid][b_safe] );
				return showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_business_panel + 5, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Пополнение сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете положить:\n\n\
						"gbDialogError"Неверное значение, повторите ввод.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) > Player[playerid][uMoney] )
			{
				return showPlayerDialog( playerid, d_business_panel + 5, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Пополнение сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете положить:\n\n\
						"gbDialogError"У Вас недостаточно наличных денег, повторите ввод.", 
					"Далее", "Назад" );
			}
			
			pformat:( ""gbDefault"Вы положили в сейф "cBLUE"$%d", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			SetPlayerCash( playerid, "-", strval( inputtext ) );
			
			BusinessInfo[bid][b_safe] += strval( inputtext );
			UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
			
			format:g_string( "Сейф - "cBLUE"$%d", BusinessInfo[bid][b_safe] );
			showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "Выбрать", "Назад" );
		}
		
		case d_business_panel + 6:
		{
			new 
				bid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( "Сейф - "cBLUE"$%d", BusinessInfo[bid][b_safe] );
				return showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				return showPlayerDialog( playerid, d_business_panel + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Взять деньги из сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете взять:\n\n\
						"gbDialogError"Неверное значение, повторите ввод.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) > BusinessInfo[bid][b_safe] )
			{
				return showPlayerDialog( playerid, d_business_panel + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Взять деньги из сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете взять:\n\n\
						"gbDialogError"В сейфе бизнеса нет указанного количества денег.", 
					"Далее", "Назад" );
			}
			
			pformat:( ""gbDefault"Вы взяли из сейфа "cBLUE"$%d", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			SetPlayerCash( playerid, "+", strval( inputtext ) );
			
			BusinessInfo[bid][b_safe] -= strval( inputtext );
			UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
			
			format:g_string( "Сейф - "cBLUE"$%d", BusinessInfo[bid][b_safe] );
			showPlayerDialog( playerid, d_business_panel + 4, DIALOG_STYLE_LIST, g_string, b_panel_p3, "Выбрать", "Назад" );
		}
		
		case d_business_panel + 7:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "Выбрать", "Закрыть" );
			}
		
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_business_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"Изменение названия бизнеса.\n\n\
						Введите желаемое название для Вашего бренда:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.", 
					"Далее", "Назад" );
				}
			
				case 1:
				{
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"Установите цену за 1 продукт.\n\n\
						Введите цену:\n\n\
						"gbDialog"Минимум - $3, максимум - $10.", 
					"Далее", "Назад" );
				}
			
				case 2:
				{
					showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| Заказ продуктов.\n\n\
						Введите количество продуктов, которые Вы хотите заказать:\n\n\
						"gbDialog"Оптовая цена за продукт - $1.\n\
						"gbDialog"Минимум - 1000 продуктов, максимум - 10000 продуктов.",
					"Далее", "Назад" );
				}
			
				case 3:
				{
					showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "Выбрать", "Назад" );
				}
			}
		}
		
		//Диалог с заказом продуктов
		case d_business_panel + 22:
		{
			new 
				bid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				format:g_string( b_panel_p4, BusinessInfo[bid][b_product_price] );
				return showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) )
			{
				return showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| Заказ продуктов.\n\n\
						Введите количество продуктов, которые Вы хотите заказать:\n\n\
						"gbDialog"Оптовая цена за продукт - $1.\n\
						"gbDialog"Минимум - 1000 продуктов, максимум - 10000 продуктов.\n\n\
						"gbDialogError"Недопустимое значение, повторите ввод.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) > 10000 || strval( inputtext ) < 1000  )
			{
				return showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| Заказ продуктов.\n\n\
						Введите количество продуктов, которые Вы хотите заказать:\n\n\
						"gbDialog"Оптовая цена за продукт - $1.\n\
						"gbDialog"Минимум - 1000 продуктов, максимум - 10000 продуктов.\n\n\
						"gbDialogError"Указанное количество не входит в допустимый диапазон, повторите ввод.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) + BusinessInfo[bid][b_products] > BusinessInfo[bid][b_improve][2] )
			{
				return showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| Заказ продуктов.\n\n\
						Введите количество продуктов, которые Вы хотите заказать:\n\n\
						"gbDialog"Оптовая цена за продукт - $1.\n\
						"gbDialog"Минимум - 1000 продуктов, максимум - 10000 продуктов.\n\n\
						"gbDialogError"Склад бизнеса не может вместить указанное количество продуктов.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) > BusinessInfo[bid][b_safe] )
			{
				return showPlayerDialog( playerid, d_business_panel + 22, DIALOG_STYLE_INPUT, " ", "\
						"cWHITE"| Заказ продуктов.\n\n\
						Введите количество продуктов, которые Вы хотите заказать:\n\n\
						"gbDialog"Оптовая цена за продукт - $1.\n\
						"gbDialog"Минимум - 1000 продуктов, максимум - 10000 продуктов.\n\n\
						"gbDialogError"В сейфе бизнеса недостаточно денег для оплаты товаров.", 
					"Далее", "Назад" );
			}
			
			if( BusinessInfo[bid][b_status_prod] == true )
			{
				format:g_string( b_panel_p4, BusinessInfo[bid][b_product_price] );
				
				return SendClient:( playerid, C_WHITE, ""gbError"Ваш предыдущий заказ еще не выполнен, повторите позже."),
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
			}
			
			new 
				bool:count = false;
				
			for( new i; i < MAX_PRODUCT_INFO; i++ )
			{
				if( !ProductsInfo[i][b_id] && !ProductsInfo[i][b_count] )
				{
					ProductsInfo[i][b_id] = bid;
					ProductsInfo[i][b_business_id] = BusinessInfo[bid][b_id];
					ProductsInfo[i][b_count] = strval( inputtext );
					ProductsInfo[i][b_count_time] = strval( inputtext );
					
					count = true;
					
					pformat:( ""gbSuccess"Ваш заказ на "cBLUE"%d"cWHITE" товаров принят.", strval( inputtext ) );
					psend:( playerid, C_WHITE );
					
					BusinessInfo[bid][b_safe] -= strval( inputtext );
					UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
					
					BusinessInfo[bid][b_status_prod] = true;
					
					CreateOrder( i );
					
					break;
				}
			}
			
			if( count == false ) 
			{
				SendClient:( playerid, C_WHITE, ""gbError"В диспетчерской превышен лимит заказов, повторите позже.");
				
				format:g_string( b_panel_p4, BusinessInfo[bid][b_product_price] );
				return showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
			}
		}
		
		case d_business_panel + 8:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
			
			if( !response )
			{
				return 
					format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] ),
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"Изменение названия бизнеса.\n\n\
						Введите желаемое название для Вашего бренда:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.\n\n\
						"gbDialogError"Поле для ввода не должно быть пустым.", 
					"Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"Изменение названия бизнеса.\n\n\
						Введите желаемое название для Вашего бренда:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.\n\n\
						"gbDialogError"Превышено допустимое количество символов.", 
					"Далее", "Назад" );
			}
			
			
			clean:<BusinessInfo[businessid][b_name]>;
			
			strcat( BusinessInfo[businessid][b_name], inputtext, 32 );
			
			UpdateBusinessStr( businessid, "b_name", BusinessInfo[businessid][b_name] );
			UpdateBusiness3DText( businessid );
			
			pformat:(""gbSuccess"Вы изменили название бизнеса на "cBLUE"%s"cWHITE".", BusinessInfo[businessid][b_name] );
			psend:( playerid, C_WHITE );

			showPlayerDialog( playerid, d_business_panel, DIALOG_STYLE_TABLIST, " ", b_panel, "Выбрать", "Закрыть" );
		}
		
		//Цена за продукт
		case d_business_panel + 9:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				return 
					format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] ),
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"Установите цену за 1 продукт.\n\n\
						Введите цену:\n\n\
						"gbDialog"Минимум - $3, максимум - $10.\n\
						"gbDialogError"Поле для ввода не должно быть пустым.", 
					"Далее", "Назад" );
			}
			
			if( !IsNumeric( inputtext ) )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"Установите цену за 1 продукт.\n\n\
						Введите цену:\n\n\
						"gbDialog"Минимум - $3, максимум - $10.\n\
						"gbDialogError"Используйте только цифры.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) == BusinessInfo[businessid][b_product_price] )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"Установите цену за 1 продукт.\n\n\
						Введите цену:\n\n\
						"gbDialog"Минимум - $3, максимум - $10.\n\
						"gbDialogError"Такая цена уже установлена.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) < 3 || strval( inputtext ) > 10 )
			{
				return
					showPlayerDialog( playerid, d_business_panel + 9, DIALOG_STYLE_INPUT, " ", "\
						"gbDefault"Установите цену за 1 продукт.\n\n\
						Введите цену:\n\n\
						"gbDialog"Минимум - $3, максимум - $10.\n\
						"gbDialogError"Цена не входит в указаный диапазон.", 
					"Далее", "Назад" );
			}
			
			BusinessInfo[businessid][b_product_price] = strval( inputtext );
			
			UpdateBusiness( businessid, "b_product_price", BusinessInfo[businessid][b_product_price] );
			
			pformat:( ""gbSuccess"Вы установили "cBLUE"$%d"cWHITE" за продукт.", BusinessInfo[businessid][b_product_price] );
			psend:( playerid, C_WHITE );
			
			format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] );
			showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
		}
		
		case d_business_panel + 11:
		{
			new 
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				return 
					format:g_string( b_panel_p4, BusinessInfo[businessid][b_product_price] ),
					showPlayerDialog( playerid, d_business_panel + 7, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Назад" );
			}
			
			switch( listitem )
			{
				/*case 0:
				{
					ShowBusinessInterior( playerid, businessid );
				}*/
				
				case 0:
				{
					showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, " ", b_panel_texture, "Выбрать", "Назад" );
				}
				
				case 1:
				{
					ShowBusinessFurnList( playerid, businessid, 0 );
				}
				
				case 2:
				{
					format:g_small_string( ""cWHITE"%s", 
						BusinessInfo[businessid][b_state_cashbox] == 0 ? ("Установить кассу"):("Убрать кассу" ) 
					);
					
					showPlayerDialog( playerid, d_business_panel + 18, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Назад" );
				}
			}
	
		}
		
		/*case d_business_panel + 12:
		{
			new
				interior,
				Float:pos[3],
				businessid = GetPVarInt( playerid, "Bpanel:BId" );
				
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "Выбрать", "Назад" );
			}
			
			if( GetCountAroundPlayer( playerid, 40.0 ) )
			{
				ShowBusinessInterior( playerid, businessid );
				return SendClient:( playerid, C_WHITE, ""gbError"В Вашем бизнесе есть другие игроки, попробуйте позже." );			
			}
			
			BusinessInfo[businessid][b_lock] = 0; //Закрываем бизнес, чтобы не могли входить другие
			UpdateBusiness( businessid, "b_lock", BusinessInfo[businessid][b_lock] );
			UpdateBusiness3DText( businessid );
			
			GameTextForPlayer( playerid, "~r~BUSINESS LOCK", 3000, 3 );
			
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
			
			SetPVarFloat( playerid, "Bpanel:pos[0]", pos[0] ),
			SetPVarFloat( playerid, "Bpanel:pos[1]", pos[1] ),
			SetPVarFloat( playerid, "Bpanel:pos[2]", pos[2] );
			
			SetPVarInt( playerid, "Bpanel:Interior", g_dialog_select[playerid][listitem] );
			interior = GetPVarInt( playerid, "Bpanel:Interior" );
			
			setPlayerPos( playerid, business_int[interior][bt_p][0], business_int[interior][bt_p][1], business_int[interior][bt_p][2] );
			stopPlayer( playerid, 2 );
			
			SetPlayerVirtualWorld( playerid, playerid + 100 );
			
			format:g_small_string( "интерьер %d: $%d", business_int[interior][bt_id], GetPriceInterior( businessid, interior ) );
			PlayerTextDrawSetString( playerid, interior_info[playerid], g_small_string );
			
			showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", "\
				"gbDefault"Для изменения интерьера или выхода из просмотра нажмите клавишу "cBLUE"ALT"cWHITE".", "Закрыть", "" );
		}*/
		//Ретекстуризация - выбор части
		case d_business_panel + 13:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "Выбрать", "Назад" );
			}
			
			SetPVarInt( playerid, "Bpanel:Type", listitem );
			ShowBusinessPartInterior( playerid, GetPVarInt( playerid, "Bpanel:BId" ), listitem );
		}
		
		case d_business_panel + 14:
		{			
			if( !response )
			{
				DeletePVar( playerid, "Bpanel:Type" );
				return showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", b_panel_texture, "Выбрать", "Назад" );
			}
			
			SelectedType{playerid} = 1;
			ShowTexViewer( playerid, GetPVarInt( playerid, "Bpanel:Type" ), listitem, 0 );
		}
		
		case d_business_panel + 15:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Bpanel:PriceTexture" );
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"Вы действительно желаете приобрести эту текстуру?\n\
						"gbDialog"Цена: "cBLUE"$%d", GetPVarInt( playerid, "Bpanel:PriceTexture" ) );
						
					showPlayerDialog( playerid, d_business_panel + 23, DIALOG_STYLE_MSGBOX, "Ретекстуризация", g_small_string, "Да", "Нет" );
				}
				
				case 1:
				{
					new
						bid = GetPVarInt( playerid, "Bpanel:BId" );
				
					switch( Menu3DData[playerid][CurrTextureType] )
					{
						case 0: SetBusinessTexture( bid, BusinessInfo[bid][b_wall][ Menu3DData[playerid][CurrPartNumber] ], 0, Menu3DData[playerid][CurrPartNumber] );
						case 1: SetBusinessTexture( bid, BusinessInfo[bid][b_floor][ Menu3DData[playerid][CurrPartNumber] ], 1, Menu3DData[playerid][CurrPartNumber] );
						case 2: SetBusinessTexture( bid, BusinessInfo[bid][b_roof][ Menu3DData[playerid][CurrPartNumber] ], 2, Menu3DData[playerid][CurrPartNumber] );
						case 3: SetBusinessTexture( bid, BusinessInfo[bid][b_stair], 3, INVALID_PARAM );
					}
				
					DeletePVar( playerid, "Bpanel:Type" );
					DeletePVar( playerid, "Bpanel:PriceTexture" );
					DestroyTexViewer( playerid );
					
					showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", h_panel_texture, "Выбрать", "Назад" );
				}
			}
		}
		
		case d_business_panel + 23:
		{
			new
				price = GetPVarInt( playerid, "Bpanel:PriceTexture" ),
				bid = GetPVarInt( playerid, "Bpanel:BId" );
		
			if( !response )
			{
				format:g_small_string( "\
					"cWHITE"Действие\t"cWHITE"Стоимость\n\
					"cWHITE"Купить текстуру\t"cBLUE"$%d\n\
					"cWHITE"Выйти из редактора", price );
		
				return showPlayerDialog( playerid, d_business_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "Ретекстуризация", g_small_string, "Выбрать", "Закрыть" );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
			
				format:g_small_string( "\
					"cWHITE"Действие\t"cWHITE"Стоимость\n\
					"cWHITE"Купить текстуру\t"cBLUE"$%d\n\
					"cWHITE"Выйти из редактора", price );
		
				return showPlayerDialog( playerid, d_business_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "Ретекстуризация", g_small_string, "Выбрать", "Закрыть" );
			}
			
			UpdateBusinessTexture( playerid, bid, Menu3DData[playerid][CurrTextureType], Menu3DData[playerid][CurrPartNumber] );
		
			SetPlayerCash( playerid, "-", price );
			
			DeletePVar( playerid, "Bpanel:Type" );
			DeletePVar( playerid, "Bpanel:PriceTexture" );
			DestroyTexViewer( playerid );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Текстура успешно применена." );
			
			showPlayerDialog( playerid, d_business_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", b_panel_texture, "Выбрать", "Назад" );
		}
		
		case d_business_panel + 16:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Bpanel:FPage" );
				DeletePVar( playerid, "Bpanel:FPageMax" );
				DeletePVar( playerid, "Bpanel:FAll" );
			
				return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "Выбрать", "Назад" );
			}
			
			new
				businessid = GetPVarInt( playerid, "Bpanel:BId" ),
				fid;
			
			if( listitem == FURN_PAGE ) 
			{
				if( GetPVarInt( playerid, "Bpanel:FPage" ) == GetPVarInt( playerid, "Bpanel:FPageMax" ) )
					return ShowBusinessFurnList( playerid, businessid, GetPVarInt( playerid, "Bpanel:FPage" ) );
					
				return ShowBusinessFurnList( playerid, businessid, GetPVarInt( playerid, "Bpanel:FPage" ) + 1 );
			}
			else if( listitem == FURN_PAGE + 1 || 
				listitem == GetPVarInt( playerid, "Bpanel:FAll" ) && GetPVarInt( playerid, "Bpanel:FAll" ) < FURN_PAGE ) 
			{
				return ShowBusinessFurnList( playerid, businessid, GetPVarInt( playerid, "Bpanel:FPage" ) - 1 );
			}
			
			SetPVarInt( playerid, "Bpanel:FId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			fid = GetPVarInt( playerid, "Bpanel:FId" );
			 
			format:g_small_string(  ""cBLUE"1. "cGRAY"%s", 
				!BFurn[businessid][fid][f_state] ? ( "Поставить мебель\n"cBLUE"2. "cGRAY"Уничтожить мебель"):("Передвинуть мебель\n"cBLUE"2. "cGRAY"Убрать мебель на склад бизнеса\n"cBLUE"3. "cGRAY"Уничтожить мебель") );
		    
			showPlayerDialog(playerid, d_business_panel + 17, DIALOG_STYLE_LIST, "Управление мебелью", g_small_string, "Выбрать", "Назад");
		}
		
		case d_business_panel + 17:
		{
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" ),
				fid = GetPVarInt( playerid, "Bpanel:FId" );
				
			if( !response ) return ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) );
				
			switch( listitem )
			{
				case 0:
				{
					if( !BFurn[bid][fid][f_state] )
					{
						new 
							Float:dist = 2.0,
							Float:angle,
							Float:pos[3],
							Float:rot[3];
							
						SendClient:( playerid, C_WHITE, !HELP_EDITOR );
						
						GetPlayerPos( playerid, BFurn[bid][fid][f_pos][0], BFurn[bid][fid][f_pos][1], BFurn[bid][fid][f_pos][2] );
						
						GetPlayerFacingAngle( playerid, angle );

						BFurn[bid][fid][f_pos][0] = BFurn[bid][fid][f_pos][0] + dist * - floatsin( angle, degrees );
	     				BFurn[bid][fid][f_pos][1] = BFurn[bid][fid][f_pos][1] + dist * floatcos( angle, degrees );
						
						for( new i = 0; i != 3; i++ )
						{
							pos[i] = BFurn[bid][fid][f_pos][i];
							rot[i] = BFurn[bid][fid][f_rot][i];
						}
						
						BFurn[bid][fid][f_object] = CreateDynamicObject(
							BFurn[bid][fid][f_model], 
							pos[0], pos[1], pos[2], rot[0], rot[1], rot[2],
							BusinessInfo[bid][b_id] 
						);
						
						EditDynamicObject( playerid, BFurn[bid][fid][f_object] );
						
						BFurn[bid][fid][f_state] = 1;
						
						//UpdateFurnitureBusiness( bid, fid );
						
						SetPVarInt( playerid, "Furn:Edit", 1 );
						
						SendClient:( playerid, C_GRAY, ""gbSuccess"Предмет установлен." );
						
						return 1;
					}
					
					new 
						Float:fpos[3];
					
					GetDynamicObjectPos( BFurn[bid][fid][f_object], fpos[0], fpos[1], fpos[2] );
					
					if( IsPlayerInRangeOfPoint( playerid, 10.0, fpos[0], fpos[1], fpos[2] ) ) 
					{ 
						EditDynamicObject( playerid, BFurn[bid][fid][f_object] );
						SetPVarInt( playerid, "Furn:Edit", 1 );
						return 1;
					}
					else 
					{
						return 
							ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) ),
							SendClient:( playerid, C_GRAY, ""gbError"Данный предмет слишком далеко от Вас." );
					}
				}
				
				case 1:
				{
					if( BFurn[bid][fid][f_state] ) 
					{
						if( IsValidDynamicObject( BFurn[bid][fid][f_object] ) )
							DestroyDynamicObject( BFurn[bid][fid][f_object] );
						
						for( new i = 0; i != 3; i++ )
						{
							BFurn[bid][fid][f_pos][i] = 0.0;
							BFurn[bid][fid][f_rot][i] = 0.0;
						}
						
						BFurn[bid][fid][f_state] = 0;
						
						UpdateFurnitureBusiness( bid, fid );
						
						SendClient:( playerid, C_GRAY, ""gbSuccess"Предмет удален." );
						
						return ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) );
					}
				}
			}
			
			pformat:( ""gbSuccess"Предмет "cBLUE"%s"cWHITE" уничтожен.", BFurn[bid][fid][f_name] );
			psend:( playerid, C_WHITE );
			
			if( IsValidDynamicObject( BFurn[bid][fid][f_object] ) )
				DestroyDynamicObject( BFurn[bid][fid][f_object] );
						
			DeleteFurnitureBusiness( bid, fid );
			BusinessInfo[bid][b_count_furn]--;
						
			ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) );
		}
		
		//Диалог с кассой
		case d_business_panel + 18:
		{
			if( !response ) return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "Выбрать", "Назад" );
			
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" );
			
			if( !BusinessInfo[bid][b_state_cashbox] )
			{
				showPlayerDialog( playerid, d_business_panel + 19, DIALOG_STYLE_MSGBOX, " ",
					""cBLUE"Установка кассы\n\n\
					"cWHITE"Вы действительно желаете установить кассу в этом месте?\n\n\
					"gbDialog"Место установки определяется позицией игрока.",
				"Да","Нет" );
			}
			else
			{
				showPlayerDialog( playerid, d_business_panel + 20, DIALOG_STYLE_MSGBOX, " ",
					""cBLUE"Удаление кассы\n\n\
					"cWHITE"Вы действительно желаете удалить кассу?",
				"Да","Нет" );
			}
		}
		//Диалог с кассой 2
		case d_business_panel + 19:
		{
			if( !response ) return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "Выбрать", "Назад" );
			
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" ),
				Float:pos[3];
			
			BusinessInfo[bid][b_state_cashbox] = 1;
			
			GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
			
			for( new i = 0; i != 3; i++ )
			{
				BusinessInfo[bid][b_pos_cashbox][i] = pos[i];
			}
			
			UpdateBusinessCashBox( bid );
			
			BusinessInfo[bid][b_cashbox] = CreateDynamicPickup( 1239, 23, 
				BusinessInfo[bid][b_pos_cashbox][0],
				BusinessInfo[bid][b_pos_cashbox][1],
				BusinessInfo[bid][b_pos_cashbox][2], BusinessInfo[bid][b_id] 
			);
			
			SendClient:( playerid, C_BLUE, ""gbSuccess"Касса установлена." );
		}
		
		//Диалог с кассой 3
		case d_business_panel + 20:
		{
			if( !response ) return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "Выбрать", "Назад" );
			
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" );
			
			BusinessInfo[bid][b_state_cashbox] = 0;
			
			for( new i = 0; i != 3; i++ )
			{
				BusinessInfo[bid][b_pos_cashbox][i] = 0.0;
			}
			
			UpdateBusinessCashBox( bid );
			
			DestroyDynamicPickup( BusinessInfo[bid][b_cashbox] );
			
			SendClient:( playerid, C_GRAY, ""gbSuccess"Касса удалена." );
		}
		
		//Диалог при изменении интерьера
		case d_business_panel + 21:
		{
			if( !response ) 
			{
				SelectTextDraw( playerid, 0x797C7CFF );
				SetPVarInt( playerid, "Bpanel:IntShow", 1 );
				return 1;
			}
			
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" ),
				interior = GetPVarInt( playerid, "Bpanel:Interior" ),
				price = GetPriceInterior( bid, interior );
			
			if( BusinessInfo[bid][b_safe] < price )
			{
				SendClient:( playerid, C_WHITE, ""gbError"В сейфе бизнеса недостаточно средств для изменения интерьера." );
				
				SelectTextDraw( playerid, 0x797C7CFF );
				SetPVarInt( playerid, "Bpanel:IntShow", 1 );
				return 1;
			}
			
			BusinessInfo[bid][b_interior] = business_int[interior][bt_id];
			
			for( new i = 0; i < 4; i++ )
			{
				BusinessInfo[bid][b_exit_pos][i] = business_int[interior][bt_p][i];
			}
			
			BusinessInfo[bid][b_state_cashbox] = 0;
			for( new i = 0; i != 3; i++ )
			{
				BusinessInfo[bid][b_pos_cashbox][i] = 0.0;
			}
			
			BusinessInfo[bid][b_wall][0] = 
			BusinessInfo[bid][b_wall][1] = 
			BusinessInfo[bid][b_wall][2] = 
			BusinessInfo[bid][b_floor][0] = 
			BusinessInfo[bid][b_floor][1] = 
			BusinessInfo[bid][b_floor][2] = 
			BusinessInfo[bid][b_floor][3] = 
			BusinessInfo[bid][b_roof] = 0;
			
			mysql_format:g_string( "UPDATE `"DB_BUSINESS"` \
			SET `b_int` = '%d', \
				`b_exit_pos` = '%f|%f|%f|%f', \
				`b_wall` = '0|0|0', \
				`b_floor` = '0|0|0|0', \
				`b_roof` = 0 \
			WHERE `b_id` = %d LIMIT 1",
				BusinessInfo[bid][b_interior],
				BusinessInfo[bid][b_exit_pos][0],
				BusinessInfo[bid][b_exit_pos][1],
				BusinessInfo[bid][b_exit_pos][2],
				BusinessInfo[bid][b_exit_pos][3],
				BusinessInfo[bid][b_id]
			);
			mysql_tquery( mysql, g_string );
			
			setPlayerPos( playerid, BusinessInfo[bid][b_exit_pos][0], BusinessInfo[bid][b_exit_pos][1], BusinessInfo[bid][b_exit_pos][2] );
			
			SetPlayerVirtualWorld( playerid, BusinessInfo[bid][b_id] );
			
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
			
			BusinessInfo[bid][b_safe] -= price;
			UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
			
			pformat:( ""gbSuccess"Вы установили интерьер "cBLUE"#%d"cWHITE", с Вашего бизнеса списано "cBLUE"$%d"cWHITE".", BusinessInfo[bid][b_interior], price );
			psend:( playerid, C_WHITE );
			
			LoadBusinessInterior( bid );
			UpdateBusinessCashBox( bid );
			
			DestroyDynamicPickup( BusinessInfo[bid][b_cashbox] );
			
			for( new f; f < GetMaxFurnBusiness( bid ); f++ ) 
			{
				if( BFurn[bid][f][f_id] ) 
				{
					if( BFurn[bid][f][f_state] ) 
					{
						if( IsValidDynamicObject( BFurn[bid][f][f_object] ) )
							DestroyDynamicObject( BFurn[bid][f][f_object] );
						
						for( new j = 0; j != 3; j++ )
						{
							BFurn[bid][f][f_pos][j] = 0.0;
							BFurn[bid][f][f_rot][j] = 0.0;
						}
						
						BFurn[bid][f][f_state] = 0;
					}
				}
			}
			
			mysql_format:g_string( "UPDATE `"DB_BUSINESS_FURN"` \
			SET `f_position` = '0.0|0.0|0.0', \
				`f_rotation` = '0.0|0.0|0.0', \
				`f_state` = 0 \
			WHERE `f_bid` = %d",
				BusinessInfo[bid][b_id]
			);
			mysql_tquery( mysql, g_string );
			
			SetPVarInt( playerid, "Bpanel:Interior", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Bpanel:BId", INVALID_PLAYER_ID );
			SetPVarFloat( playerid, "Bpanel:pos[0]", INVALID_PLAYER_ID ),
			SetPVarFloat( playerid, "Bpanel:pos[1]", INVALID_PLAYER_ID ),
			SetPVarFloat( playerid, "Bpanel:pos[2]", INVALID_PLAYER_ID );
				
			PlayerTextDrawHide( playerid, interior_info[playerid] );
		}
	}
	return 1;
}