function House_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_house :
		{
			if( !response )	
			{
				DeletePVar( playerid, "House:EnterId" );
				return 1;
			}
			
			new
				h = GetPVarInt( playerid, "House:EnterId" );
			
			if( !IsPlayerInRangeOfPoint( playerid, 2.0, HouseInfo[h][hEnterPos][0], HouseInfo[h][hEnterPos][1], HouseInfo[h][hEnterPos][2] ) )
			{
				DeletePVar( playerid, "House:EnterId" );
				return SendClient:( playerid, C_WHITE, !""gbError"Вы должны находиться рядом с входной дверью." );
			}
				
			SetPlayerInterior( playerid, 1 );
			SetPlayerVirtualWorld( playerid, HouseInfo[h][hID] );
			
			Player[playerid][tgpsPos][0] = HouseInfo[h][hEnterPos][0];
			Player[playerid][tgpsPos][1] = HouseInfo[h][hEnterPos][1];
			Player[playerid][tgpsPos][2] = HouseInfo[h][hEnterPos][2];
	
			setPlayerPos( playerid, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] );
			SetPlayerFacingAngle( playerid, HouseInfo[h][hExitPos][3] );
			
			setHouseWeather( playerid );
		}
	
		case d_buy_menu: 
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			switch( listitem ) 
			{
				case 0: 
				{ // Каталог домов
					showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "Выбор", "Назад" );
				}
				
				case 1: 
				{ // Каталог бизнесов
					showPlayerDialog( playerid, d_buy_business + 1, DIALOG_STYLE_LIST, " ", 
						"1. Список всех бизнесов\n2. Сортировка по стоимости\
						\n3. Сортировка по типу бизнеса\n4. Покупка бизнеса по номеру\
						\n5. Продать бизнес", "Выбор", "Назад" );
				}
			}
		
		}
		
		case d_buy_menu + 1: 
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_buy_menu, DIALOG_STYLE_LIST, 
					"Агентство недвижимости", "\
					1. "cGRAY"Каталог жилья\n\
					2. "cGRAY"Каталог бизнесов", 
					"Выбор", "Закрыть" );
			}
			
			switch( listitem ) 
			{
				case 0: 
				{	// Список всех домов
					showHouseList( playerid, 1, 0 );
					SetPVarInt( playerid, "HBuy:case", 1 );
				}
				
				case 1: 
				{	// Сортировка по стоимости
					showPlayerDialog( playerid, d_buy_menu + 3, DIALOG_STYLE_INPUT, " ", 
						""cBLUE"Сортировка по стоимости\n\n\
						"cWHITE"Укажите диапазон цен для просмотра интересующего жилья:\
						\nПример: "cBLUE"60000-200000", "Ввод", "Назад" );
					SetPVarInt( playerid, "HBuy:case", 2 );
				}
					// Сортировка по типу
				case 2: 
				{
					showPlayerDialog( playerid, d_buy_menu + 14, DIALOG_STYLE_LIST, " ", ""cWHITE"\
						Дом\n\
						Квартира", "Выбор", "Назад" );
					SetPVarInt( playerid, "HBuy:case", 3 );
				}
					// Найти дом по номеру
				case 3: 
				{
					showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Покупка недвижимости\n\n\
						"cWHITE"Укажите номер дома (квартиры):", "Ввод", "Назад" );
					SetPVarInt( playerid, "HBuy:case", 4 );
				}
				
				case 4:
				{
					showHouseList( playerid, 4, 0 );
				}
			}
		}
		
		case d_buy_menu + 2: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:List" );
				
				switch( GetPVarInt( playerid, "HBuy:case" ) )
				{
					case 2:
					{
						return showPlayerDialog( playerid, d_buy_menu + 3, DIALOG_STYLE_INPUT, " ", 
							""cBLUE"Сортировка по стоимости\n\n\
							"cWHITE"Укажите диапазон цен для просмотра интересующего жилья:\
							\nПример: "cBLUE"60000-200000", "Ввод", "Назад" );
					}
					
					case 3:
					{
						DeletePVar( playerid, "HBuy:TypeTwo" );
						return showPlayerDialog( playerid, d_buy_menu + 15, DIALOG_STYLE_LIST, " ", dialog_house_type, "Выбор", "Назад" );
					}
					
					case 4:
					{
						return showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"Покупка недвижимости\n\n\
							"cWHITE"Укажите номер дома (квартиры):", "Ввод", "Назад" );
					}
					
					default:
					{
						DeletePVar( playerid, "HBuy:case" );
						return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "Выбор", "Назад" );
					}
				}
			}
			
			if( listitem == HBUY_LIST ) 
			{
				return showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) + 1 );
			}
			else if( listitem == HBUY_LIST + 1 || 
				listitem == GetPVarInt( playerid, "HBuy:Last" ) && GetPVarInt( playerid, "HBuy:Last" ) < BBUY_LIST ) 
			{
				return showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) - 1 );
			}
			
			showHouseBuyMenu( playerid, g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_buy_menu + 3: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:case" );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "Выбор", "Назад" );
			}
			
			if( sscanf( inputtext, "p<->a<d>[2]", inputtext[0], inputtext[1] ) || inputtext[1] <= inputtext[0] )
			{
				return showPlayerDialog( playerid, d_buy_menu + 3, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Сортировка по стоимости\n\n\
					"cWHITE"Укажите диапазон цен для просмотра интересующего жилья:\
					\nПример: "cBLUE"60000-200000\n\n\
					"gbDialogError"Вы неправильно указали диапазон.", "Ввод", "Назад" );
			}
			
			SetPVarInt( playerid, "HBuy:PriceM", inputtext[0] ), 
			SetPVarInt( playerid, "HBuy:PriceH", inputtext[1] );
			DeletePVar( playerid, "HBuy:House" );
			showHouseList( playerid, 2, 0 );
		}
		
		//Диалог при просмотре дома
		case d_buy_menu + 4: 
		{
			if( !response )
			{
				setPlayerPos( playerid,
					GetPVarFloat( playerid, "HBuy:PX" ),
					GetPVarFloat( playerid, "HBuy:PY" ),
					GetPVarFloat( playerid, "HBuy:PZ") 
				);
					
				SetCameraBehindPlayer( playerid );
				
				SetPlayerVirtualWorld( playerid, 13 ), 
				SetPlayerInterior( playerid, 1 );
				
				DeletePVar( playerid, "HBuy:PX" ), 
				DeletePVar( playerid, "HBuy:PY" ),
				DeletePVar( playerid, "HBuy:PZ" ),
				DeletePVar( playerid, "HBuy:Camera" );			
				DeletePVar( playerid, "HBuy:House" );
				
				showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) );
				return 1;
			}
		
			if( listitem == 2 )
			{
				return showPlayerDialog( playerid, d_buy_menu + 13, DIALOG_STYLE_MSGBOX, " ", "\
					"cBLUE"Информация\n\n\
					"cWHITE"Если у Вас недостаточное количество денежных средств для покупки дома ( квартиры ),\n\
					Вы можете арендовать жилую площадь, но при этом некоторые функции будут ограничены:\n\
					- ретекстуризация,\n\
					- подселение других игроков,\n\
					- продажа недвижимости другому игроку.\n\n\
					Оплатить жилую площадь Вы можете в Центральном банке. Размер платы зависит от интерьера,\n\
					а в случае аренды дополнительно взимается определенная сумма.", "Назад", "" );
			}
		
			new
				h = GetPVarInt( playerid, "HBuy:House" );
					
			if( Player[playerid][uHouseEvict] )
			{
				showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Покупка\n\
					Аренда\n\
					Информация", "Выбрать", "Назад" );
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете приобрести недвижимость, так как подселены в другой дом. Используйте "cBLUE"/hevict"cWHITE", чтобы выселиться." );
			}
			
			if( IsOwnerHouseCount( playerid ) >= 1 + Premium[playerid][prem_house] )
			{
				showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Покупка\n\
					Аренда\n\
					Информация", "Выбрать", "Назад" );
				return SendClient:( playerid, C_WHITE, !""gbError"У Вас уже есть место жительства." );
			}			
				
			if( HouseInfo[h][huID] != INVALID_PARAM )
			{
				setPlayerPos( playerid,
					GetPVarFloat( playerid, "HBuy:PX" ),
					GetPVarFloat( playerid, "HBuy:PY" ),
					GetPVarFloat( playerid, "HBuy:PZ") 
				);
					
				SetCameraBehindPlayer( playerid );
				
				SetPlayerVirtualWorld( playerid, 13 ), 
				SetPlayerInterior( playerid, 1 );
				
				DeletePVar( playerid, "HBuy:PX" ), 
				DeletePVar( playerid, "HBuy:PY" ),
				DeletePVar( playerid, "HBuy:PZ" ),
				DeletePVar( playerid, "HBuy:Camera" );			
				DeletePVar( playerid, "HBuy:House" );
			
				showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) );
				return SendClient:( playerid, C_GRAY, !""gbError"Этот дом приобрел кто-то ранее." );
			}
			
			if( listitem == 1 )
			{
				if( Player[playerid][uMoney] < GetPriceRentHouse( h ) )
				{
					showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
						Покупка\n\
						Аренда\n\
						Информация", "Выбрать", "Назад" );
					return SendClient:( playerid, C_GRAY, !""gbError"У Вас недостаточно средств для оплаты аренды этого дома на 1 день." );
				}
			
				HouseInfo[h][hSellDate] = gettime() + 1 * 86400;
			
				format:g_small_string( "арендовал%s дом", SexTextEnd( playerid ) );
				MeAction( playerid, g_small_string, 1 );
				
				SetPlayerCash( playerid, "-", GetPriceRentHouse( h ) );
			
				HouseInfo[h][hRent] = 1;
				InsertPlayerHouse( playerid, h );
				
				clean:<HouseInfo[h][hOwner]>;
				strcat( HouseInfo[h][hOwner], Player[playerid][uName], MAX_PLAYER_NAME );
					
				HouseInfo[h][huID] = Player[playerid][uID];
				
				pformat:( ""gbSuccess"Вы арендовали "cBLUE"%s #%d"cWHITE". Арендная плата автоматически произведена на "cBLUE"1"cWHITE" день.", 
					!HouseInfo[h][hType] ? ("дом") : ("квартиру"), 
					HouseInfo[h][hID] );
				psend:( playerid, C_WHITE );
				
				log( LOG_RENT_HOUSE, "арендовал дом", Player[playerid][uID], HouseInfo[h][hID] );
				
				DestroyDynamicPickup( HouseInfo[h][hPickup] );
				
				HouseInfo[h][hPickup] = CreateDynamicPickup( 19524, 23, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2], 
					HouseInfo[h][hType], -1, -1, 30.0 );
			}
			else
			{
				if( HouseInfo[h][hPrice] > Player[playerid][uMoney] )
				{
					showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
						Покупка\n\
						Аренда\n\
						Информация", "Выбрать", "Назад" );
					return SendClient:( playerid, C_GRAY, !""gbError"У Вас недостаточно средств для покупки этого дома." );
				}
			
				HouseInfo[h][hSellDate] = gettime() + 2 * 86400;
			
				format:g_small_string( "купил%s дом", SexTextEnd( playerid ) );
				MeAction( playerid, g_small_string, 1 );
					
				SetPlayerCash( playerid, "-", HouseInfo[h][hPrice] );
				InsertPlayerHouse( playerid, h );
				
				clean:<HouseInfo[h][hOwner]>;
				strcat( HouseInfo[h][hOwner], Player[playerid][uName], MAX_PLAYER_NAME );
					
				HouseInfo[h][huID] = Player[playerid][uID];
			
				pformat:( ""gbSuccess"Вы стали владельцем "cBLUE"%s #%d"cWHITE". Жилая площадь автоматически оплачена на "cBLUE"2"cWHITE" дня.", 
					!HouseInfo[h][hType] ? ("дома") : ("квартиры"), 
					HouseInfo[h][hID] );
				psend:( playerid, C_WHITE );
				
				log( LOG_BUY_HOUSE, "купил дом", Player[playerid][uID], HouseInfo[h][hID] );
				
				DestroyDynamicPickup( HouseInfo[h][hPickup] );
				
				HouseInfo[h][hPickup] = CreateDynamicPickup( 19522, 23, 
					HouseInfo[h][hEnterPos][0], 
					HouseInfo[h][hEnterPos][1], 
					HouseInfo[h][hEnterPos][2], 
					HouseInfo[h][hType], -1, -1, 30.0 );
			}
			
			mysql_format:g_string( "UPDATE `"DB_HOUSE"` SET `huID` = %d, `hRent` = %d, `hOwner` = '%s', `hSellDate` = %d WHERE `hID` = %d LIMIT 1",
				HouseInfo[h][huID], HouseInfo[h][hRent], HouseInfo[h][hOwner], HouseInfo[h][hSellDate], HouseInfo[h][hID] );
			mysql_tquery( mysql, g_string );
		
			setPlayerPos( playerid,
				GetPVarFloat( playerid, "HBuy:PX" ),
				GetPVarFloat( playerid, "HBuy:PY" ),
				GetPVarFloat( playerid, "HBuy:PZ") 
			);
				
			SetCameraBehindPlayer( playerid );
			
			SetPlayerVirtualWorld( playerid, 13 ), 
			SetPlayerInterior( playerid, 1 );
				
			DeletePVar( playerid, "HBuy:PX" ), 
			DeletePVar( playerid, "HBuy:PY" ),
			DeletePVar( playerid, "HBuy:PZ" ),
			DeletePVar( playerid, "HBuy:Camera" );			
			DeletePVar( playerid, "HBuy:House" );
			DeletePVar( playerid, "HBuy:TypeOne" );
			DeletePVar( playerid, "HBuy:TypeTwo" );
			DeletePVar( playerid, "HBuy:Last" );
			DeletePVar( playerid, "HBuy:PriceM" );
			DeletePVar( playerid, "HBuy:PriceH" );
			DeletePVar( playerid, "HBuy:List" );
			DeletePVar( playerid, "HBuy:Type" );
			DeletePVar( playerid, "HBuy:case" );
			
			g_player_interaction{playerid} = 0;
		}
		
		case d_buy_menu + 5: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:HId" );
				showHouseList( playerid, 4, 0 );
				return 1;
			}
			
			new
				h = GetPVarInt( playerid, "HBuy:HId" );
			
			switch( listitem ) 
			{
				case 0: 
				{
					if( HouseInfo[h][hRent] )
					{
						format:g_small_string( "\
							"cBLUE"Подтверждение\n\n\
							"cWHITE"Вы действительно желаете прервать аренду "cBLUE"%s #%d"cWHITE"?",
							!HouseInfo[h][hType] ? ("дома") : ("квартиры"),
							HouseInfo[h][hID] );
						return showPlayerDialog( playerid, d_buy_menu + 6, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Далее", "Назад" );
					}
				
					format:g_string( "\
						"cBLUE"Продажа %s\n\n\
						"cWHITE"Ваш "cBLUE"%s #%d"cWHITE" будет продан%s агенству за "cBLUE"$%d"cWHITE".",
						!HouseInfo[h][hType] ? ("дома") : ("квартиры"),
						!HouseInfo[h][hType] ? ("дом") : ("квартира"),
						HouseInfo[h][hID],
						!HouseInfo[h][hType] ? ("") : ("а"),
						floatround( HouseInfo[h][hPrice] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) 
					);
					
					showPlayerDialog( playerid, d_buy_menu + 6, DIALOG_STYLE_MSGBOX, " ", g_string, "Продать", "Отмена" );
				}
				
				case 1: 
				{
					if( HouseInfo[h][hRent] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете продать арендованный дом (квартиру) другому игроку." );
						return showPlayerDialog( playerid, d_buy_menu + 5, DIALOG_STYLE_LIST,
							"Продажа недвижимости", "\
							"cWHITE"1. "cGRAY"Продать жилье агентству\n\
							"cWHITE"2. "cGRAY"Продать жилье игроку",
							"Выбор", "Назад" );
					}
				
					showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Продажа жилья\n\n\
						"cWHITE"Для продажи жилья игроку введите его ID:", "Ввод", "Назад" );
				}
			}	
		}
		
		case d_buy_menu + 6: 
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_buy_menu + 5, DIALOG_STYLE_LIST,
					"Продажа недвижимости", "\
					"cWHITE"1. "cGRAY"Продать жилье агентству\n\
					"cWHITE"2. "cGRAY"Продать жилье игроку",
				"Выбор", "Назад" );
			}
			
			new 
				h = GetPVarInt( playerid, "HBuy:HId" );
				
			if( !HouseInfo[h][hRent] )
			{
				SetPlayerCash( playerid, "+", floatround( HouseInfo[h][hPrice] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) );
				
				mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uHouseEvict` = 0 WHERE `uHouseEvict` = %d", HouseInfo[h][hID] );
				mysql_tquery( mysql, g_small_string );
			
				foreach( new i : Player) 
				{
					if( !IsLogged(i) ) continue;
				
					if( Player[i][uHouseEvict] == HouseInfo[h][hID] ) 
					{
						SendClient:( i, C_GRAY, !""gbDefault"Дом, в котором Вы проживали, был продан владельцем. Вы выселены." );
						Player[i][uHouseEvict] = 0;
					}
				}
				
				pformat:( ""gbSuccess"Вы успешно продали %s агентству за $%d.", !HouseInfo[h][hType] ? ("дом") : ("квартиру"), 
					floatround( HouseInfo[h][hPrice] * ( 0.6 + ( Premium[playerid][prem_house_property] / 100 ) ) ) );
				psend:( playerid, C_WHITE );
			}
			else
			{
				SendClient:( playerid, C_WHITE, !""gbSuccess"Вы успешно прервали аренду." );
			}
			
			mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `huID` = -1, `hRent` = 0, `hOwner` = '', `hSellDate` = 0 WHERE `hID` = %d LIMIT 1",
				HouseInfo[h][hID] );
			mysql_tquery( mysql, g_small_string );
			
			RemovePlayerHouse( playerid, h );
			
			clean:<HouseInfo[h][hOwner]>;
			HouseInfo[h][huID] = INVALID_PARAM;
			HouseInfo[h][hRent] =
			HouseInfo[h][hSellDate] = 0;
				
			for( new i; i < MAX_EVICT; i++ )
			{
				HEvict[h][i][hEvictUID] = 0;
				HEvict[h][i][hEvictName][0] = EOS;
			}
			
			DestroyDynamicPickup( HouseInfo[h][hPickup] );
			
			HouseInfo[h][hPickup] = CreateDynamicPickup( 1272, 23, 
				HouseInfo[h][hEnterPos][0], 
				HouseInfo[h][hEnterPos][1],
				HouseInfo[h][hEnterPos][2], HouseInfo[h][hType], -1, -1, 30.0 );
			
			g_player_interaction{playerid} = 0;
			
			log( LOG_SELL_HOUSE, "продал дом", Player[playerid][uID], HouseInfo[h][hID] );
		}
		
		case d_buy_menu + 8:
		{
			new 
				sellid = GetPVarInt( playerid, "HBuy:SellID" ), //Продавец
				price = GetPVarInt( playerid, "HBuy:Price" ),	//Покупатель
				house = GetPVarInt( playerid, "HBuy:HId" );
		
			if( !IsLogged( sellid ) ) 
			{
				SendClient:( playerid, C_GRAY, !""gbError"Продавец не в сети, операция прервана!" );
					
				DeletePVar( playerid, "HBuy:HId" ), 
				DeletePVar( playerid, "HBuy:SellID" ),
				DeletePVar( playerid, "HBuy:Price" );
				
				g_player_interaction{playerid} = 0;
				return 1;
			}
		
			if( !response )
			{
				pformat:(""gbError"Вы отказались от покупки жилья у игрока "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( sellid ),
					sellid
				);
				psend:( playerid, C_WHITE );
				
				pformat:(""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от покупки Вашего жилья.",
					GetAccountName( playerid ),
					playerid
				);
				psend: ( sellid, C_WHITE );

				DeletePVar( playerid, "HBuy:SellID" ),
				DeletePVar( playerid, "HBuy:Price" );
				DeletePVar( playerid, "HBuy:HId" );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
				return 1;
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_GRAY, !NO_MONEY );
				
				DeletePVar( playerid, "HBuy:HId" ), 
				DeletePVar( playerid, "HBuy:SellID" ),
				DeletePVar( playerid, "HBuy:Price" );
				
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
				SendClient:( playerid, C_WHITE, !""gbError"Владелец дома находится слишком далеко от Вас." );
				
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
			
			if( Player[playerid][uHouseEvict] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Вы уже подселены в другой дом." );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"Игрок "cBLUE"%s[%d]"cWHITE" уже подселён в другой дом.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
			}
			
			if( IsOwnerHouseCount( playerid ) >= 1 + Premium[ playerid ][prem_house] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Вы уже имеете дом." );
				
				DeletePVar( playerid, "BBuy:BId" ), 
				DeletePVar( playerid, "BBuy:SellID" ),
				DeletePVar( playerid, "BBuy:Price" );
				
				pformat:(""gbError"Игрок "cBLUE"%s[%d]"cWHITE" уже имеет дом.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( sellid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{sellid} = 0;
			}
			
			SetPlayerCash( sellid, "+", price );
			SetPlayerCash( playerid, "-", price );
				
			OfferSalePlayerHouse( sellid, playerid, house );
				
			pformat:( ""gbSuccess"Вы купили "cBLUE"%s #%d"cWHITE" у игрока "cBLUE"%s[%d]"cWHITE".",
				!HouseInfo[house][hType] ? ("дом") : ("квартиру"),
				HouseInfo[house][hID],
				GetAccountName( sellid ),
				sellid
			);
			psend:( playerid, C_WHITE );
				
			pformat:( ""gbSuccess"Вы продали "cBLUE"%s #%d"cWHITE" игроку "cBLUE"%s[%d]"cWHITE".",
				!HouseInfo[house][hType] ? ("дом") : ("квартиру"),
				HouseInfo[house][hID],
				GetAccountName( playerid ),
				playerid 
			);
			psend:( sellid, C_WHITE );
				
			g_player_interaction{playerid} = 0;
			g_player_interaction{sellid} = 0;
				
			log( LOG_BUY_HOUSE_FROM_PLAYER, "купил дом у", Player[playerid][uID], Player[sellid][uID], price );
				
			DeletePVar( playerid, "HBuy:HId" ), 
			DeletePVar( playerid, "HBuy:SellID" ),
			DeletePVar( playerid, "HBuy:Price" );
		}
		
		case d_buy_menu + 9: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:case" );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "Выбор", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Покупка недвижимости\n\n\
					"cWHITE"Укажите номер дома (квартиры):\n\
					"gbDialogError"Неверное значение.", "Ввод", "Назад" );
			}
			
			for( new h; h < MAX_HOUSE; h++ ) 
			{
				if( HouseInfo[h][hID] == strval( inputtext ) )
				{
					if( HouseInfo[h][huID] != INVALID_PARAM ) 
					{
						return showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"Покупка недвижимости\n\n\
							"cWHITE"Укажите номер дома (квартиры):\n\
							"gbDialogError"Данный дом уже продан.", "Ввод", "Назад" );
					}
					
					showHouseBuyMenu( playerid, h );
					return 1;
				}
			}
			
			showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
				"cBLUE"Покупка недвижимости\n\n\
				"cWHITE"Укажите номер дома (квартиры):\n\
				"gbDialogError"Дома с таким номером не существует.", "Ввод", "Назад" );
		}
		
		case d_buy_menu + 10: 
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_buy_menu + 5, DIALOG_STYLE_LIST,
					"Продажа недвижимости", "\
					"cWHITE"1. "cGRAY"Продать жилье агентству\n\
					"cWHITE"2. "cGRAY"Продать жилье игроку",
				"Выбор", "Назад" );
			}
			
			if( inputtext[0] == EOS ) 
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа жилья\n\n\
					"cWHITE"Для продажи жилья игроку введите его ID:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Введите id игрока.", 
				"Далее", "Назад" );
			}	
					
			if( !IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) ) 
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа жилья\n\n\
					"cWHITE"Для продажи жилья игроку введите его ID:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы ввели некорректный id игрока.", 
				"Далее", "Назад" );
			}
					
			if( Player[playerid][uHouseEvict] ) 
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа жилья\n\n\
					"cWHITE"Для продажи жилья игроку введите его ID:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Данный игрок подселён.", 
				"Далее", "Назад" );
			}
			
			if( IsOwnerHouseCount( strval( inputtext ) ) >= 1 + Premium[ strval( inputtext ) ][prem_house] )
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа жилья\n\n\
					"cWHITE"Для продажи жилья игроку введите его ID:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Данный игрок уже имеет дом.", 
				"Далее", "Назад" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 )
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа жилья\n\n\
					"cWHITE"Для продажи жилья игроку введите его ID:\n\n\
					"gbDialogError"Игрок должен находиться рядом с Вами.", 
				"Далее", "Назад" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа жилья\n\n\
					"cWHITE"Для продажи жилья игроку введите его ID:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы не можете взаимодействовать с данным игроком.", 
				"Далее", "Назад" );
			}		
			
			g_player_interaction{strval( inputtext )} = 1;
			SetPVarInt( playerid, "HBuy:PlayerID", strval( inputtext ) );
			ShowDialogHouseSell( playerid, GetPVarInt( playerid, "HBuy:HId" ), " " );
		}
		
		case d_buy_menu + 11: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "HBuy:PlayerID" );
				return showPlayerDialog( playerid, d_buy_menu + 10, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа жилья\n\n\
					"cWHITE"Для продажи жилья игроку, введите его ID:", "Ввод", "Назад" );
			}
		
			new
				h = GetPVarInt( playerid, "HBuy:HId" ),
				sellid = GetPVarInt( playerid, "HBuy:PlayerID" );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) ) 
			{
				return ShowDialogHouseSell( playerid, h, "\n\n"gbDialogError"Неправильный формат ввода." );
			}
			
			if( GetDistanceBetweenPlayers( playerid, sellid ) > 3.0 )
			{
				return ShowDialogHouseSell( playerid, h, "\n\n"gbDialogError"Игрок должен находиться рядом с Вами." );
			}
			
			if( strval( inputtext ) < floatround( HouseInfo[h][hPrice] * 0.5 ) ||  strval( inputtext ) > ( HouseInfo[h][hPrice] * 2 ) )
			{
				return ShowDialogHouseSell( playerid, h, "\n\n"gbDialogError"Указанная сумма выходит за рамки допустимого диапазона." );
			}
		
			if( Player[sellid][uMoney] < strval( inputtext ) ) 
			{
				return ShowDialogHouseSell( playerid, h, "\n\n"gbDialogError"У игрока нет необходимого количества наличных денег." );
			}
			
			pformat:( ""gbSuccess"Вы отправили предложение игроку "cBLUE"%s[%d]"cWHITE" о продаже "cBLUE"%s #%d"cWHITE".",
				GetAccountName( sellid ),
				sellid,
				!HouseInfo[h][hType] ? ("дома") : ("квартиры"),
				HouseInfo[h][hID]
			);
			
			psend:( playerid, C_WHITE ); 
			
			format:g_small_string( 
				""cWHITE"Игрок "cBLUE"%s[%d]"cWHITE" предлагает Вам\n\ 
				приобрести его"cBLUE"%s #%d"cWHITE" за "cBLUE"$%d"cWHITE".",
				GetAccountName( playerid ),
				playerid,
				!HouseInfo[h][hType] ? ("дом") : ("квартиру"),
				HouseInfo[h][hID],
				strval( inputtext )
			);
			
			showPlayerDialog( sellid, d_buy_menu + 8, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			
			SetPVarInt( sellid, "HBuy:SellID", playerid );
			SetPVarInt( sellid, "HBuy:Price", strval( inputtext ) );
			SetPVarInt( sellid, "HBuy:HId", h );
			
			DeletePVar( playerid, "HBuy:PlayerID" );
			DeletePVar( playerid, "HBuy:HId" );
		}

		case d_buy_menu + 12:
		{
			if( !response )
			{
				setPlayerPos( playerid,
					GetPVarFloat( playerid, "HBuy:PX" ),
					GetPVarFloat( playerid, "HBuy:PY" ),
					GetPVarFloat( playerid, "HBuy:PZ") 
				);
					
				SetCameraBehindPlayer( playerid );
				
				SetPlayerVirtualWorld( playerid, 13 ), 
				SetPlayerInterior( playerid, 1 );
					
				DeletePVar( playerid, "HBuy:PX" ), 
				DeletePVar( playerid, "HBuy:PY" ),
				DeletePVar( playerid, "HBuy:PZ" ),
				DeletePVar( playerid, "HBuy:Camera" );
				
				if( GetPVarInt( playerid, "HBuy:case" ) == 4 )
				{
					showPlayerDialog( playerid, d_buy_menu + 9, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Покупка недвижимости\n\n\
						"cWHITE"Укажите номер дома (квартиры):", "Ввод", "Назад" );
				}
				else
				{
					showHouseList( playerid, GetPVarInt( playerid, "HBuy:Type" ), GetPVarInt( playerid, "HBuy:List" ) );
				}
				
				DeletePVar( playerid, "HBuy:House" );
				
				return 1;
			}
		
			showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				Покупка\n\
				Аренда\n\
				Информация", "Выбрать", "Назад" );
		}
		
		case d_buy_menu + 13:
		{
			showPlayerDialog( playerid, d_buy_menu + 4, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				Покупка\n\
				Аренда\n\
				Информация", "Выбрать", "Назад" );
		}
		
		case d_buy_menu + 14:
		{
			if( !response )
			{
				DeletePVar( playerid, "HBuy:case" );
				return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "Выбор", "Назад" );
			}
			
			if( listitem == 1 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"На данный момент нет квартир, доступных для покупки." );
				
				return showPlayerDialog( playerid, d_buy_menu + 14, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Дом\n\
					Квартира", "Выбор", "Назад" );
			}
			
			SetPVarInt( playerid, "HBuy:TypeOne", listitem );
			showPlayerDialog( playerid, d_buy_menu + 15, DIALOG_STYLE_LIST, " ", dialog_house_type, "Выбор", "Назад" );
		}
		
		case d_buy_menu + 15:
		{
			if( !response )
			{
				DeletePVar( playerid, "HBuy:TypeOne" );
				return showPlayerDialog( playerid, d_buy_menu + 14, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Дом\n\
					Квартира", "Выбор", "Назад" );
			}
			
			SetPVarInt( playerid, "HBuy:TypeTwo", listitem );
			showHouseList( playerid, 3, 0 );
		}
		
		case d_buy_menu + 16:
		{
			if( !response ) return showPlayerDialog( playerid, d_buy_menu + 1, DIALOG_STYLE_LIST, " ", dialog_house_buy, "Выбор", "Назад" );
			
			SetPVarInt( playerid, "HBuy:HId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			showPlayerDialog( playerid, d_buy_menu + 5, DIALOG_STYLE_LIST,
				"Продажа недвижимости", "\
				"cWHITE"1. "cGRAY"Продать жилье агентству\n\
				"cWHITE"2. "cGRAY"Продать жилье игроку",
				"Выбор", "Назад" );
		}
		
		
		/*- - - - - - - - - - - - Диалоги с панелью дома - - - - - - - - - - - - -*/
		case d_house_panel: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Hpanel:HId" );
				return 1;
			}
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" ),
				year, month, day;
			
			switch( listitem ) 
			{
				//Информация
				case 0: 
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					gmtime( HouseInfo[h][hSellDate], year, month, day );
				
					format:g_string(  ""cBLUE"Информация о %s\n\n\
						"cWHITE"Статус: "cRED"%s\n\
						"cWHITE"Номер %s: "cBLUE"%d\n\
						"cWHITE"Рыночная стоимость: "cBLUE"$%d\n\
						"cWHITE"Тип интерьера: "cBLUE"%s\n\n\
						"cWHITE"Владелец: "cBLUE"%s\n\
						"cWHITE"Двери: %s\n\
						"cWHITE"Мебель: "cBLUE"%d/%d\n\n\
						"cWHITE"Оплачен до: %02d.%02d.%d", 
						!HouseInfo[h][hType] ? ("доме") : ("квартире"),
						!HouseInfo[h][hRent] ? ("куплен") : ("арендован"),
						!HouseInfo[h][hType] ? ("дома") : ("квартиры"),
						HouseInfo[h][hID],
						HouseInfo[h][hPrice],
						GetNameInteriorHouse(h),
						HouseInfo[h][hOwner],
						HouseInfo[h][hLock] ? (""cBLUE"открыты"cWHITE"") : 
											  (""cRED"закрыты"cWHITE""),
						HouseInfo[h][hCountFurn],
						GetMaxFurnHouse( h ),
						day, month, year
					);
					
					showPlayerDialog( playerid, d_house_panel + 1, DIALOG_STYLE_MSGBOX, " ", g_string, "Назад", "" );
				}
				//Подселение
				case 1:
				{ 
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( HouseInfo[h][hRent] || Player[playerid][uHouseEvict] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете подселять игроков." );
						return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
					}
					
					if( !hinterior_info[ HouseInfo[h][hInterior] - 1 ][h_evict] )
					{
						pformat:( ""gbError"Вы не можете подселять игроков в %s.", !HouseInfo[h][hType] ? ("этот дом") : ("эту квартиру") );
						psend:( playerid, C_WHITE );
					
						return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
					}
					
					format:g_string( "SELECT * FROM `"DB_USERS"` WHERE `uHouseEvict` = %d", HouseInfo[h][hID] );
					mysql_tquery( mysql, g_string, "checkHouseEvict", "dd", playerid, h );
				}
				//Денежные операции
				case 2: 
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] && !HouseInfo[h][hSettings][0] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете пользоваться сейфом дома." );
						return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
					}
				
					format:g_string( "Сейф - "cBLUE"$%d", HouseInfo[h][hMoney] );
					showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "Выбрать", "Назад" );
				}
				//Настройки
				case 3: 
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
				}
			}
		}
		
		case d_house_panel + 1: 
		{
			showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
		}
		
		case d_house_panel + 2:
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
		
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
				
			if( !HEvict[h][listitem][hEvictUID] )
			{
				showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Подселение\n\n\
					"cWHITE"Введите id игрока, которого желаете подселить:", "Далее", "Назад" );
			}
			else
			{
				format:g_small_string("\
					"cBLUE"Выселение\n\n\
					"cWHITE"Вы действительно желаете выселить "cBLUE"%s"cWHITE"?", HEvict[h][listitem][hEvictName] );
				showPlayerDialog( playerid, d_house_panel + 5, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			
			SetPVarInt( playerid, "Hpanel:EvictSlot", listitem );
		}
		
		case d_house_panel + 3: 
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || 
				strval( inputtext ) < 0 || strval( inputtext ) > MAX_PLAYERS || 
				!IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) )
			{
				return showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Подселение\n\n\
					"cWHITE"Введите id игрока, которого желаете подселить:\n\
					"gbDialogError"Некорректный id игрока.", "Далее", "Назад" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Подселение\n\n\
					"cWHITE"Введите id игрока, которого желаете подселить:\n\
					"gbDialogError"Вы не можете взаимодействовать с данным игроком.", "Далее", "Назад" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Подселение\n\n\
					"cWHITE"Введите id игрока, которого желаете подселить:\n\
					"gbDialogError"Данного игрока нет рядом с Вами.", "Далее", "Назад" );
			}
			
			if( Player[ strval( inputtext ) ][uHouseEvict] || IsOwnerHouseCount( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_house_panel + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Подселение\n\n\
					"cWHITE"Введите id игрока, которого желаете подселить:\n\
					"gbDialogError"У данного игрока уже есть место жительства.", "Далее", "Назад" );
			}
			
			pformat:( ""gbDefault"Вы отправили предложение "cBLUE"%s[%d]"cWHITE" о заселении в свой дом, ожидайте его решение.", Player[ strval( inputtext ) ][uName], strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			format:g_string( "\
				"cBLUE"%s[%d]"cWHITE" предлагает Вам заселиться в %s %s "cBLUE"#%d"cWHITE". Вы согласны?",
				Player[playerid][uName], 
				playerid, 
				Player[playerid][uSex] == 2 ? ("её") : ("его"),
				!HouseInfo[h][hType] ? ("дом") : ("квартиру"), 
				HouseInfo[h][hID] 
			);
			showPlayerDialog( strval( inputtext ), d_house_panel + 4, DIALOG_STYLE_MSGBOX, " ", g_string, "Да", "Нет" );
			
			g_player_interaction{ strval( inputtext ) } = 1;
			g_player_interaction{ playerid } = 1;
			
			SetPVarInt( strval( inputtext ), "Hpanel:Playerid", playerid );
		}
		
		case d_house_panel + 4: 
		{
			new
				id = GetPVarInt( playerid, "Hpanel:Playerid" ),
				slot = GetPVarInt( id, "Hpanel:EvictSlot" ),
				h = GetPVarInt( id, "Hpanel:HId" );
				
			if( !IsLogged( id ) || !g_player_interaction{id} || GetDistanceBetweenPlayers( playerid, id ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( id ) )
			{
				g_player_interaction{ id } = 
				g_player_interaction{ playerid } = 0;
				
				DeletePVar( id, "Hpanel:HId" );
				DeletePVar( id, "Hpanel:EvictSlot" );
				DeletePVar( playerid, "Hpanel:Playerid" );
			
				return SendClient:( playerid, C_WHITE, !""gbError"Произошла ошибка при заселении, попробуйте еще раз." );
			}
				
			if( !response )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы отказались от заселения." );
				
				pformat:( ""gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" отказался от заселения.", Player[playerid][uName], playerid );
				psend:( id, C_WHITE );
					
				DeletePVar( id, "Hpanel:HId" );
				DeletePVar( id, "Hpanel:EvictSlot" );
				DeletePVar( playerid, "Hpanel:Playerid" );
			
				g_player_interaction{ id } = 
				g_player_interaction{ playerid } = 0;
			
				return 1;
			}
			
			HEvict[h][slot][hEvictUID] = Player[playerid][uID];
			strcat( HEvict[h][slot][hEvictName], Player[playerid][uName], MAX_PLAYER_NAME );
			
			pformat:( ""gbDefault"Вы заселены в %s #%d, владелец - "cBLUE"%s"cWHITE".", !HouseInfo[h][hType] ? ("дом") : ("квартиру"), HouseInfo[h][hID], Player[id][uName] );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess""cBLUE"%s[%d]"cWHITE" принял Ваше предложение и заселился в Ваш дом.", Player[playerid][uName], playerid );
			psend:( id, C_WHITE );
			
			Player[playerid][uHouseEvict] = HouseInfo[h][hID];
			UpdatePlayer( playerid, "uHouseEvict", Player[playerid][uHouseEvict] );
			
			DeletePVar( id, "Hpanel:HId" );
			DeletePVar( id, "Hpanel:EvictSlot" );
			DeletePVar( playerid, "Hpanel:Playerid" );
			
			g_player_interaction{ id } = 
			g_player_interaction{ playerid } = 0;
		}
		
		case d_house_panel + 5: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Hpanel:EvictSlot" );
				return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
			}
			
			new
				slot = GetPVarInt( playerid, "Hpanel:EvictSlot" ),
				h = GetPVarInt( playerid, "Hpanel:HId" );
			
			pformat:( ""gbDefault"Вы выселили из %s "cBLUE"%s"cWHITE".", !HouseInfo[h][hType] ? ("своего дома") : ("своей квартиры"),
				HEvict[h][slot][hEvictName] );
			psend:( playerid, C_WHITE );
			
			foreach(new i: Player)
			{
				if( !IsLogged( i ) ) continue;
				
				if( HEvict[h][slot][hEvictUID] == Player[i][uID] )
				{
					Player[i][uHouseEvict] = 0;
					
					pformat:( ""gbDefault"Вы были выселены из %s #%d игроком "cBLUE"%s[%d]"cWHITE".", 
						!HouseInfo[h][hType] ? ("дома") : ("квартиры" ), HouseInfo[h][hID],
						Player[playerid][uName], playerid );
					psend:( i, C_WHITE );
					
					break;
				}
			}
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uHouseEvict` = 0 WHERE `uID` = %d LIMIT 1", HEvict[h][slot][hEvictUID] );
			mysql_tquery( mysql, g_small_string );
			
			HEvict[h][slot][hEvictName][0] = EOS;
			HEvict[h][slot][hEvictUID] = 0;
			
			DeletePVar( playerid, "Hpanel:EvictSlot" );
			showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
		}
		
		case d_house_panel + 6: 
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
			
			switch( listitem )
			{
				case 0:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					showPlayerDialog( playerid, d_house_panel + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Пополнение сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете положить:", 
					"Далее", "Назад" );
				}
				
				case 1:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					showPlayerDialog( playerid, d_house_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Взять деньги из сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете взять:", 
					"Далее", "Назад" );
				}
			}
		}
		
		case d_house_panel + 7:
		{
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			if( !response )
			{
				format:g_string( "Сейф - "cBLUE"$%d", HouseInfo[h][hMoney] );
				return showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_house_panel + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Пополнение сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете положить:\n\n\
						"gbDialogError"Неверное значение, повторите ввод.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) > Player[playerid][uMoney] )
			{
				return showPlayerDialog( playerid, d_house_panel + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Пополнение сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете положить:\n\n\
						"gbDialogError"У Вас недостаточно наличных денег, повторите ввод.", 
					"Далее", "Назад" );
			}
			
			pformat:( ""gbDefault"Вы положили в сейф "cBLUE"$%d", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			SetPlayerCash( playerid, "-", strval( inputtext ) );
			
			HouseInfo[h][hMoney] += strval( inputtext );
			HouseUpdate( h, "hMoney", HouseInfo[h][hMoney] );
			
			format:g_string( "Сейф - "cBLUE"$%d", HouseInfo[h][hMoney] );
			showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "Выбрать", "Назад" );
		}
		
		case d_house_panel + 8: 
		{
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			if( !response )
			{
				format:g_string( "Сейф - "cBLUE"$%d", HouseInfo[h][hMoney] );
				return showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				return showPlayerDialog( playerid, d_house_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Взять деньги из сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете взять:\n\n\
						"gbDialogError"Неверное значение, повторите ввод.", 
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) > HouseInfo[h][hMoney] )
			{
				return showPlayerDialog( playerid, d_house_panel + 8, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Взять деньги из сейфа\n\n\
						"cWHITE"Укажите сумму, которую Вы желаете взять:\n\n\
						"gbDialogError"В сейфе дома нет указанного количества денег.", 
					"Далее", "Назад" );
			}
			
			pformat:( ""gbDefault"Вы взяли из сейфа "cBLUE"$%d", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			SetPlayerCash( playerid, "+", strval( inputtext ) );
			
			HouseInfo[h][hMoney] -= strval( inputtext );
			HouseUpdate( h, "hMoney", HouseInfo[h][hMoney] );
			
			format:g_string( "Сейф - "cBLUE"$%d", HouseInfo[h][hMoney] );
			showPlayerDialog( playerid, d_house_panel + 6, DIALOG_STYLE_LIST, g_string, h_panel_p3, "Выбрать", "Назад" );
		}
		
		case d_house_panel + 9: 
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel, DIALOG_STYLE_TABLIST, " ", h_panel, "Выбрать", "Закрыть" );
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
			
			switch( listitem )
			{
				case 0:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] || HouseInfo[h][hRent] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете менять текстуры в этом доме." );
						return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
					}
					
					showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", h_panel_texture, "Выбрать", "Назад" );
				}
				
				case 1:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] && !HouseInfo[h][hSettings][2] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете расставлять мебель в этом доме." );
						return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
					}
					
					ShowHouseFurnList( playerid, h, 0 );
				}
			
				case 2:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете покупать дополнительную мебель в этот дом." );
						return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
					}
				
					showPlayerDialog( playerid, d_mebelbuy + 8, DIALOG_STYLE_LIST, " ", furniture_other, "Выбрать", "Назад" );
				}
				
				case 3:
				{
					if( !Player[playerid][uHouseEvict] && HouseInfo[h][huID] != Player[playerid][uID] ) return 1;
				
					if( Player[playerid][uHouseEvict] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете изменять настройки для заселяемых." );
						return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
					}
				
					format:g_small_string( h_panel_evict,
						!HouseInfo[h][hSettings][0] ? ("Нет") : ("Да"),
						!HouseInfo[h][hSettings][1] ? ("Нет") : ("Да"),
						!HouseInfo[h][hSettings][2] ? ("Нет") : ("Да") );
					showPlayerDialog( playerid, d_house_panel + 10, DIALOG_STYLE_TABLIST_HEADERS, "Настройки заселяемых", g_small_string, "Изменить", "Назад" );
				}
			}
		}
		
		case d_house_panel + 10:
		{
			if( !response )
				return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
		
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			if( HouseInfo[h][hSettings][listitem] )
			{
				HouseInfo[h][hSettings][listitem] = 0;
			}
			else
			{
				HouseInfo[h][hSettings][listitem] = 1;
			}
			
			mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `hSettings` = '%d|%d|%d' WHERE `hID` = %d LIMIT 1", 
				HouseInfo[h][hSettings][0], 
				HouseInfo[h][hSettings][1], 
				HouseInfo[h][hSettings][2],
				HouseInfo[h][hID]
			);
			mysql_tquery( mysql, g_small_string );
			
			format:g_small_string( h_panel_evict,
				!HouseInfo[h][hSettings][0] ? ("Нет") : ("Да"),
				!HouseInfo[h][hSettings][1] ? ("Нет") : ("Да"),
				!HouseInfo[h][hSettings][2] ? ("Нет") : ("Да") );
			showPlayerDialog( playerid, d_house_panel + 10, DIALOG_STYLE_TABLIST_HEADERS, "Настройки заселяемых", g_small_string, "Изменить", "Назад" );
		}
		
		case d_house_panel + 11: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Hpanel:FPage" );
				DeletePVar( playerid, "Hpanel:FPageMax" );
				DeletePVar( playerid, "Hpanel:FAll" );
			
				return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
			}
			
			new
				h = GetPVarInt( playerid, "Hpanel:HId" ),
				page = GetPVarInt( playerid, "Hpanel:FPage" ),
				
				fid;
			
			if( listitem == FURN_PAGE ) 
			{
				if( page == GetPVarInt( playerid, "Hpanel:FPageMax" ) )
					return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) );
					
				return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) + 1 );
			}
			else if( listitem == FURN_PAGE + 1 || 
				listitem == GetPVarInt( playerid, "Hpanel:FAll" ) && GetPVarInt( playerid, "Hpanel:FAll" ) < FURN_PAGE ) 
			{
				return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) - 1 );
			}
			
			SetPVarInt( playerid, "Hpanel:FId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			fid = GetPVarInt( playerid, "Hpanel:FId" );
			 
			format:g_small_string(  ""cBLUE"1. "cGRAY"%s", 
				!HFurn[h][fid][f_state] ? ( "Поставить мебель\n"cBLUE"2. "cGRAY"Уничтожить мебель"):("Передвинуть мебель\n"cBLUE"2. "cGRAY"Убрать мебель на склад\n"cBLUE"3. "cGRAY"Уничтожить мебель") );
		    
			showPlayerDialog(playerid, d_house_panel + 12, DIALOG_STYLE_LIST, "Управление мебелью", g_small_string, "Выбрать", "Назад");
		}
		
		case d_house_panel + 12:
		{
			new
				h = GetPVarInt( playerid, "Hpanel:HId" ),
				fid = GetPVarInt( playerid, "Hpanel:FId" );
					
			if( !response ) return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) );
					
			switch( listitem )
			{
				case 0:
				{
					if( !HFurn[h][fid][f_state] )
					{
						new 
							Float:dist = 2.0,
							Float:angle,
							Float:pos[3],
							Float:rot[3];
								
						SendClient:( playerid, C_WHITE, !HELP_EDITOR );
							
						GetPlayerPos( playerid, HFurn[h][fid][f_pos][0], HFurn[h][fid][f_pos][1], HFurn[h][fid][f_pos][2] );
							
						GetPlayerFacingAngle( playerid, angle );

						HFurn[h][fid][f_pos][0] = HFurn[h][fid][f_pos][0] + dist * - floatsin( angle, degrees );
						HFurn[h][fid][f_pos][1] = HFurn[h][fid][f_pos][1] + dist * floatcos( angle, degrees );
							
						for( new i = 0; i != 3; i++ )
						{
							pos[i] = HFurn[h][fid][f_pos][i];
							rot[i] = HFurn[h][fid][f_rot][i];
						}
							
						HFurn[h][fid][f_object] = CreateDynamicObject(
							HFurn[h][fid][f_model], 
							pos[0], pos[1], pos[2], rot[0], rot[1], rot[2],
							HouseInfo[h][hID] 
						);
							
						EditDynamicObject( playerid, HFurn[h][fid][f_object] );
							
						HFurn[h][fid][f_state] = 1;
							
						SetPVarInt( playerid, "Furn:Edit", 2 );
							
						SendClient:( playerid, C_GRAY, ""gbSuccess"Предмет установлен." );
							
						return 1;
					}
						
					new 
						Float:fpos[3];
						
					GetDynamicObjectPos( HFurn[h][fid][f_object], fpos[0], fpos[1], fpos[2] );
						
					if( IsPlayerInRangeOfPoint( playerid, 10.0, fpos[0], fpos[1], fpos[2] ) ) 
					{ 
						EditDynamicObject( playerid, HFurn[h][fid][f_object] );
						SetPVarInt( playerid, "Furn:Edit", 2 );
						return 1;
					}
					else 
					{
						return 
							ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) ),
							SendClient:( playerid, C_GRAY, ""gbError"Данный предмет слишком далеко от Вас." );
					}
				}
					
				case 1:
				{
					if( HFurn[h][fid][f_state] ) 
					{
						if( IsValidDynamicObject( HFurn[h][fid][f_object] ) )
							DestroyDynamicObject( HFurn[h][fid][f_object] );
						
						for( new i = 0; i != 3; i++ )
						{
							HFurn[h][fid][f_pos][i] = 
							HFurn[h][fid][f_rot][i] = 0.0;
						}
							
						HFurn[h][fid][f_state] = 0;
							
						UpdateFurnitureHouse( h, fid );
							
						SendClient:( playerid, C_GRAY, ""gbSuccess"Предмет удален." );
							
						return ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) );
					}
				}
			}
				
			pformat:( ""gbSuccess"Предмет "cBLUE"%s"cWHITE" уничтожен.", HFurn[h][fid][f_name] );
			psend:( playerid, C_WHITE );
				
			if( IsValidDynamicObject( HFurn[h][fid][f_object] ) )
				DestroyDynamicObject( HFurn[h][fid][f_object] );
							
			DeleteFurnitureHouse( h, fid );
			HouseInfo[h][hCountFurn]--;
							
			ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Bpanel:FPage" ) );
		}
		//Ретекстур
		case d_house_panel + 13:
		{
			if( !response ) return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
		
			SetPVarInt( playerid, "Hpanel:Type", listitem );
			ShowHousePartInterior( playerid, GetPVarInt( playerid, "Hpanel:HId" ), listitem );
		}
		//Список стен
		case d_house_panel + 14:
		{
			if( !response )
			{
				DeletePVar( playerid, "Hpanel:Type" );
				return showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", h_panel_texture, "Выбрать", "Назад" );
			}
			
			ShowTexViewer( playerid, GetPVarInt( playerid, "Hpanel:Type" ), listitem, 0 );
		}
		
		case d_house_panel + 15:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Hpanel:PriceTexture" );
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"Вы действительно желаете приобрести эту текстуру?\n\
						"gbDialog"Цена: "cBLUE"$%d", GetPVarInt( playerid, "Hpanel:PriceTexture" ) );
						
					showPlayerDialog( playerid, d_house_panel + 16, DIALOG_STYLE_MSGBOX, "Ретекстуризация", g_small_string, "Да", "Нет" );
				}
				
				case 1:
				{
					new
						h = GetPVarInt( playerid, "Hpanel:HId" );
				
					switch( Menu3DData[playerid][CurrTextureType] )
					{
						case 0: SetHouseTexture( h, HouseInfo[h][hWall][ Menu3DData[playerid][CurrPartNumber] ], 0, Menu3DData[playerid][CurrPartNumber] );
						case 1: SetHouseTexture( h, HouseInfo[h][hFloor][ Menu3DData[playerid][CurrPartNumber] ], 1, Menu3DData[playerid][CurrPartNumber] );
						case 2: SetHouseTexture( h, HouseInfo[h][hRoof][ Menu3DData[playerid][CurrPartNumber] ], 2, Menu3DData[playerid][CurrPartNumber] );
						case 3: SetHouseTexture( h, HouseInfo[h][hStairs], 3, INVALID_PARAM );
					}
				
					DestroyTexViewer( playerid );
					
					showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", h_panel_texture, "Выбрать", "Назад" );
				}
			}
		}
		
		case d_house_panel + 16:
		{
			new
				price = GetPVarInt( playerid, "Hpanel:PriceTexture" ),
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			if( !response )
			{
				format:g_small_string( "\
					"cWHITE"Действие\t"cWHITE"Стоимость\n\
					"cWHITE"Купить текстуру\t"cBLUE"$%d\n\
					"cWHITE"Выйти из редактора", price );
		
				return showPlayerDialog( playerid, d_house_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "Ретекстуризация", g_small_string, "Выбрать", "Закрыть" );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
			
				format:g_small_string( "\
					"cWHITE"Действие\t"cWHITE"Стоимость\n\
					"cWHITE"Купить текстуру\t"cBLUE"$%d\n\
					"cWHITE"Выйти из редактора", price );
		
				return showPlayerDialog( playerid, d_house_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "Ретекстуризация", g_small_string, "Выбрать", "Закрыть" );
			}
			
			switch( Menu3DData[playerid][CurrTextureType] )
			{
				case 0:
				{
					HouseInfo[h][hWall][ Menu3DData[playerid][CurrPartNumber] ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
				
					mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `hWall` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `hID` = %d LIMIT 1", 
						HouseInfo[h][hWall][0],
						HouseInfo[h][hWall][1],
						HouseInfo[h][hWall][2],
						HouseInfo[h][hWall][3],
						HouseInfo[h][hWall][4],
						HouseInfo[h][hWall][5],
						HouseInfo[h][hWall][6],
						HouseInfo[h][hWall][7],
						HouseInfo[h][hWall][8],
						HouseInfo[h][hWall][9],
						HouseInfo[h][hID] );
					mysql_tquery( mysql, g_small_string );
				}
				
				case 1:
				{
					HouseInfo[h][hFloor][ Menu3DData[playerid][CurrPartNumber] ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
				
					mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `hFloor` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `hID` = %d LIMIT 1", 
						HouseInfo[h][hFloor][0],
						HouseInfo[h][hFloor][1],
						HouseInfo[h][hFloor][2],
						HouseInfo[h][hFloor][3],
						HouseInfo[h][hFloor][4],
						HouseInfo[h][hFloor][5],
						HouseInfo[h][hFloor][6],
						HouseInfo[h][hFloor][7],
						HouseInfo[h][hFloor][8],
						HouseInfo[h][hFloor][9],
						HouseInfo[h][hID] );
					mysql_tquery( mysql, g_small_string );
				}
				
				case 2:
				{
					HouseInfo[h][hRoof][ Menu3DData[playerid][CurrPartNumber] ] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
				
					mysql_format:g_small_string( "UPDATE `"DB_HOUSE"` SET `hRoof` = '%d|%d|%d|%d|%d|%d|%d' WHERE `hID` = %d LIMIT 1", 
						HouseInfo[h][hRoof][0],
						HouseInfo[h][hRoof][1],
						HouseInfo[h][hRoof][2],
						HouseInfo[h][hRoof][3],
						HouseInfo[h][hRoof][4],
						HouseInfo[h][hRoof][5],
						HouseInfo[h][hRoof][6],
						HouseInfo[h][hID] );
					mysql_tquery( mysql, g_small_string );
				}
				
				case 3:
				{
					HouseInfo[h][hStairs] = SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex];
					HouseUpdate( h, "hStairs", HouseInfo[h][hStairs] );
				}
			}
			
			SetPlayerCash( playerid, "-", price );
			
			DeletePVar( playerid, "Hpanel:PriceTexture" );
			DestroyTexViewer( playerid );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Текстура успешно применена." );
			
			showPlayerDialog( playerid, d_house_panel + 13, DIALOG_STYLE_LIST, "Ретекстуризация", h_panel_texture, "Выбрать", "Назад" );
		}
	}
	
	return 1;
}