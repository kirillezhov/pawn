/*
stock CreateBankomat( Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz ) 
{
    CreateDynamicObject( 2754, x, y, z, rx, ry, rz );
    CreateDynamic3DTextLabel( "Банкомат", 0xFFFFFFFF, x, y, z, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0 );
    atm_zone[ atm_server ] = CreateDynamicSphere( x, y, z, 2.0 );
    atm_server++;
	
	return 1;
}

function Atm_OnPlayerEnterDynamicArea( playerid, areaid ) 
{
	//if( atm_zone[0] <= areaid <= atm_zone[ atm_server - 1 ] ) SetPVarInt( playerid, "ATM:Use", 1 );
	return 1;
}

function Atm_OnPlayerLeaveDynamicArea( playerid, areaid ) 
{
	//if( atm_zone[0] <= areaid <= atm_zone[ atm_server - 1 ] ) DeletePVar( playerid, "ATM:Use" );
	return 1;
}*/

function Atm_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_bank + 1: 
		{
		    if( !response ) return 1;
		   
			switch(listitem) 
			{
		        case 0: 
				{
					clean:<g_string>;
					new
						hour, minute;
				
		            format:g_small_string( "\
						"cBLUE"Информация о банковском счете\n\n\
						"cWHITE"На банковском счете - "cBLUE"$%d", Player[playerid][uBank] );
						
					strcat( g_string, g_small_string );
					
					format:g_small_string( "\n"cWHITE"На чековой книжке - "cBLUE"$%d", Player[playerid][uCheck] );
					strcat( g_string, g_small_string );
						
					strcat( g_string, "\n\n"cGRAY"История банковских операций:" );
						
					for( new i; i < MAX_HISTORY; i++ )
					{
						if( Payment[playerid][i][HistoryTime] )
						{
							gmtime( Payment[playerid][i][HistoryTime], _, _, _, hour, minute );
							format:g_small_string( "\n"cGRAY"%02d:%02d %s", hour, minute, Payment[playerid][i][HistoryName] );
							
							strcat( g_string, g_small_string );
						}
					}

		            showPlayerDialog( playerid, d_bank + 7, DIALOG_STYLE_MSGBOX, " ", g_string, "Назад", "" );
		        }
				
		        case 1: 
				{
					showPlayerDialog( playerid, d_bank + 3, DIALOG_STYLE_INPUT, " ", dialog_cashout, "Далее", "Назад" );
				}
				
		        case 2:
				{
					showPlayerDialog( playerid, d_bank + 4, DIALOG_STYLE_INPUT, " ", dialog_cashin, "Далee", "Назад" );
				}
				
				case 3: 
				{
					showPlayerDialog( playerid, d_bank + 5, DIALOG_STYLE_INPUT, " ", dialog_transfer, "Далее", "Назад" );
				}
				
				case 4: 
				{
					if( job_duty{playerid} ) 
					{
						showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
						return SendClient:( playerid, C_WHITE, ""gbError"Вы не завершили рабочий день.");
					}
					
					if( !Player[playerid][uCheck] ) 
					{
						showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
						return SendClient:( playerid, C_WHITE, ""gbError"На Вашей чековой книжке нет денег.");
					}
					
					SetPlayerBank( playerid, "+", Player[playerid][uCheck] );
					
					Player[playerid][uCheck] = 0;
					UpdatePlayer( playerid, "uCheck", 0 );
					
					SendClient:( playerid, C_WHITE, ""gbSuccess"Вы обналичили свою чековую книжку. Все средства переведены на банковский счет." );
					showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
				}
		    
				case 5:
				{
					showPlayerDialog( playerid, d_bank + 8, DIALOG_STYLE_LIST, "Оплата услуг", dialog_pay, "Выбрать", "Назад" );
				}
			}
		}
		
		//Снять деньги
		case d_bank + 3: 
		{
		    if( !response ) 
				return showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
			
		    if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 100000 ) 
			{
				format:g_small_string( "%s\n\n"gbDialogError"Неправильный формат ввода.", dialog_cashout );
				
				return showPlayerDialog( playerid, d_bank + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		   
			if( Player[playerid][uBank] < strval( inputtext ) ) 
			{
				format:g_small_string( "%s\n\n"gbDialogError"На Вашем банковском счете недостаточно средств.", dialog_cashout );
				
				return showPlayerDialog( playerid, d_bank + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPlayerBank( playerid, "-", strval( inputtext ) );
			SetPlayerCash( playerid, "+", strval( inputtext ) );
			
			pformat:( ""gbSuccess"Вы сняли "cBLUE"$%d"cWHITE" с банковского счета.", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			format:g_small_string(  "снял%s деньги со счета", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
			
			ApplyAnimation( playerid, "PED", "ATM", 4.0, 0, 1, 1, 0, 0, 1 );
			
			showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
		}
		
		case d_bank + 4:
		{
		    if( !response ) 
				return showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 100000 ) 
			{
				format:g_small_string( "%s\n\n"gbDialogError"Неправильный формат ввода.", dialog_cashin );
				
				return showPlayerDialog( playerid, d_bank + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		   
			if( Player[playerid][uMoney] < strval( inputtext ) ) 
			{
				format:g_small_string( "%s\n\n"gbDialogError"У Вас недостаточно наличных средств.", dialog_cashin );
				
				return showPlayerDialog( playerid, d_bank + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		
			SetPlayerBank( playerid, "+", strval( inputtext ) );
			SetPlayerCash( playerid, "-", strval( inputtext ) );
			
			pformat:( ""gbSuccess"Вы положили "cBLUE"$%d"cWHITE" на банковский счет.", strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			format:g_small_string(  "положил%s деньги на счет", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
			
			ApplyAnimation( playerid, "PED", "ATM", 4.0, 0, 1, 1, 0, 0, 1 );
			
			showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
		}
		
		case d_bank + 5: 
		{
		    if( !response ) 
				return showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) >= MAX_PLAYERS ) 
			{
				format:g_small_string( "%s\n\n"gbDialogError"Неправильный формат ввода.", dialog_transfer );
				
				return showPlayerDialog( playerid, d_bank + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
				
		    if( !IsLogged( strval( inputtext ) ) || strval( inputtext ) == playerid )
			{
				format:g_small_string( "%s\n\n"gbDialogError"Некорректный ID игрока.", dialog_transfer );
				
				return showPlayerDialog( playerid, d_bank + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Bank:Playerid", strval( inputtext ) );
			
			format:g_small_string( dialog_transfer_2, Player[strval( inputtext )][uName], strval( inputtext ) );
			showPlayerDialog( playerid, d_bank + 6, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_bank + 6: 
		{
		    if( !response )
			{
				DeletePVar( playerid, "Bank:Playerid" );
				return showPlayerDialog( playerid, d_bank + 5, DIALOG_STYLE_INPUT, " ", dialog_transfer, "Далее", "Назад" );
			}
			
			new
				id = GetPVarInt( playerid, "Bank:Playerid" );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 1000000 )
			{
				format:g_small_string( dialog_transfer_2, Player[id][uName], id );
				strcat( g_small_string, "\n\n"gbDialogError"Неправильный формат ввода." );
				
				return showPlayerDialog( playerid, d_bank + 6, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( !IsLogged( id ) )
			{
				DeletePVar( playerid, "Bank:Playerid" );
				format:g_small_string( "%s\n\n"gbDialogError"Некорректный ID игрока.", dialog_transfer );
				
				return showPlayerDialog( playerid, d_bank + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[playerid][uBank] < strval( inputtext ) )
			{
				format:g_small_string( dialog_transfer_2, Player[id][uName], id );
				strcat( g_small_string, "\n\n"gbDialogError"На Вашем банковском счете недостаточно средств." );
				
				return showPlayerDialog( playerid, d_bank + 6, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			format:g_small_string( ""gbSuccess"Вы перевели %s[%d] - "cBLUE"$%d", Player[id][uName], id, strval( inputtext ) );
			SendClient:( playerid, C_WHITE, g_small_string );
			
			format:g_small_string( ""gbSuccess"%s[%d] перевел%s Вам на банковский счёт - "cBLUE"$%d", Player[playerid][uName], playerid, SexTextEnd( playerid ), strval(inputtext) );
			SendClient:( id, C_WHITE, g_small_string );
			
			SetPlayerBank( playerid, "-", strval( inputtext ) );
			SetPlayerBank( id, "+", strval( inputtext ) );
			
			ApplyAnimation( playerid, "PED", "ATM",4.0, 0, 1, 1, 0, 0, 1 );
			DeletePVar( playerid, "Bank:Playerid" );
			
			log( LOG_TRANSFER_BANK_MONEY, "перевёл деньги", Player[playerid][uID], Player[id][uID], strval( inputtext ) );
			format:g_small_string(  
				"[A] %s[%d][%s] перевёл деньги через банк %s[%d][%s] в размере $%d", 
				Player[playerid][uName], playerid, Player[playerid][tIP], Player[id][uName], 
				id, Player[id][tIP], strval( inputtext ) );
			SendAdminMessage( C_DARKGRAY, g_small_string );
		}
		
		case d_bank + 7:
		{
			showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
		}
		
		case d_bank + 8:
		{
			if( !response )
				return showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
		
			switch( listitem )
			{
				case 0://Оплата дома
				{
					ShowHousePlayerList( playerid, d_bank + 9, "Далее", "Назад" );
				}
				
				case 1://Оплата штрафов
				{
					ShowPenalties( playerid );
				}
			}
		}
		
		case d_bank + 9:
		{
			if( !response )
				return showPlayerDialog( playerid, d_bank + 8, DIALOG_STYLE_LIST, "Оплата услуг", dialog_pay, "Выбрать", "Назад" );
				
			new
				h = g_dialog_select[playerid][listitem],
				days = floatround( float( HouseInfo[h][hSellDate] - gettime() ) / float( 86400 ), floatround_ceil ),
				month, day,
				price;
				
			if( days < 0 ) days = 0;
				
			gmtime( HouseInfo[h][hSellDate], _, month, day );
				
			if( 7 + Premium[playerid][prem_h_payment] - days == 0 )
			{
				pformat:( ""gbDefault"Эта жилая площадь уже оплачена на максимальное количество дней - до %02d.%02d", day, month );
				psend:( playerid, C_WHITE );
			
				ShowHousePlayerList( playerid, d_bank + 9, "Далее", "Назад" );
				return 1;
			}
				
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			SetPVarInt( playerid, "Bank:hID", h );
			SetPVarInt( playerid, "Bank:Day", days );
			
			if( !HouseInfo[h][hRent] )
			{
				price = GetPricePaymentHouse( h ) - ( GetPricePaymentHouse( h ) * Premium[playerid][prem_drop_payment] / 100 );
			
				format:g_small_string( "\
					"cBLUE"Оплата коммунальных услуг\n\n\
					"cWHITE"%s #%d: оплачен до "cBLUE"%02d.%02d\n\
					"cWHITE"Тариф: "cBLUE"%d/день\n\n\
					"cWHITE"Для продления укажите количество дней:\n\
					"gbDialog"Максимум: %d",
					!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
					HouseInfo[h][hID],
					day, month,
					price,
					7 + Premium[playerid][prem_h_payment] - days );
					
				showPlayerDialog( playerid, d_bank + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			else
			{
				price = GetPriceRentHouse( h ) - ( GetPriceRentHouse( h ) * Premium[playerid][prem_drop_payment] / 100 );
			
				format:g_small_string( "\
					"cBLUE"Оплата аренды\n\n\
					"cWHITE"%s #%d: оплачен до "cBLUE"%02d.%02d\n\
					"cWHITE"Тариф: "cBLUE"%d/день\n\n\
					"cWHITE"Для продления укажите количество дней:\n\
					"gbDialog"Максимум: %d",
					!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
					HouseInfo[h][hID],
					day, month,
					price,
					7 + Premium[playerid][prem_h_payment] - days );
					
				showPlayerDialog( playerid, d_bank + 12, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		}
		
		case d_bank + 10:
		{
			if( !response )
			{
				DeletePVar( playerid, "Bank:hID" );
				DeletePVar( playerid, "Bank:Day" );
			
				ShowHousePlayerList( playerid, d_bank + 9, "Далее", "Назад" );
				
				return 1;
			}
			
			new
				h = GetPVarInt( playerid, "Bank:hID" ),
				days = GetPVarInt( playerid, "Bank:Day" ),
				month, day,
				price = GetPricePaymentHouse( h ) - ( GetPricePaymentHouse( h ) * Premium[playerid][prem_drop_payment] / 100 );
			
			gmtime( HouseInfo[h][hSellDate], _, month, day );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 7 + Premium[playerid][prem_h_payment] - days )
			{
				format:g_small_string( "\
					"cBLUE"Оплата коммунальных услуг\n\n\
					"cWHITE"%s #%d: оплачен до "cBLUE"%02d.%02d\n\
					"cWHITE"Тариф: "cBLUE"%d/день\n\n\
					"cWHITE"Для продления укажите количество дней:\n\
					"gbDialog"Максимум: %d\n\
					"gbDialogError"Неправильный формат ввода.",
					!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
					HouseInfo[h][hID],
					day, month,
					price,
					7 + Premium[playerid][prem_h_payment] - days );
					
				return showPlayerDialog( playerid, d_bank + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Bank:PayDays", strval( inputtext ) );
			
			format:g_small_string( "\
				"cWHITE"Счет на оплату коммунальных услуг для "cBLUE"%s #%d:\n\
				"cWHITE"Количество дней: "cBLUE"%d"cWHITE" на сумму "cBLUE"$%d\n\n\
				"cWHITE"Продолжить?",
				!HouseInfo[h][hType] ? ("дома") : ("квартиры"),
				HouseInfo[h][hID],
				strval( inputtext ), 
				price * strval( inputtext ) );
				
			showPlayerDialog( playerid, d_bank + 11, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Оплата", "Назад" );
		}
		
		case d_bank + 11:
		{
			new
				h = GetPVarInt( playerid, "Bank:hID" ),
				days = GetPVarInt( playerid, "Bank:Day" ),
				paydays = GetPVarInt( playerid, "Bank:PayDays" ),
				month, day,
				price = GetPricePaymentHouse( h ) - ( GetPricePaymentHouse( h ) * Premium[playerid][prem_drop_payment] / 100 );
			
			gmtime( HouseInfo[h][hSellDate], _, month, day );
			
			if( !response )
			{
				DeletePVar( playerid, "Bank:PayDays" );
			
				format:g_small_string( "\
					"cBLUE"Оплата коммунальных услуг\n\n\
					"cWHITE"%s #%d: оплачен до "cBLUE"%02d.%02d\n\
					"cWHITE"Тариф: "cBLUE"%d/день\n\n\
					"cWHITE"Для продления укажите количество дней:\n\
					"gbDialog"Максимум: %d",
					!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
					HouseInfo[h][hID],
					day, month,
					price,
					7 + Premium[playerid][prem_h_payment] - days );
					
				return showPlayerDialog( playerid, d_bank + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[playerid][uBank] < paydays * price )
			{
				format:g_small_string( "\
					"cBLUE"Оплата коммунальных услуг\n\n\
					"cWHITE"%s #%d: оплачен до "cBLUE"%02d.%02d\n\
					"cWHITE"Тариф: "cBLUE"%d/день\n\n\
					"cWHITE"Для продления укажите количество дней:\n\
					"gbDialog"Максимум: %d\n\n\
					"gbDialogError"На Вашем банковском счете недостаточно средств.",
					!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
					HouseInfo[h][hID],
					day, month,
					price,
					7 + Premium[playerid][prem_h_payment] - days );
					
				return showPlayerDialog( playerid, d_bank + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPlayerBank( playerid, "-", paydays * price );
			
			HouseInfo[h][hSellDate] += paydays * 86400;
			HouseUpdate( h, "hSellDate", HouseInfo[h][hSellDate] );
			
			pformat:( ""gbSuccess"Вы успешно оплатили "cBLUE"%s #%d"cWHITE" на "cBLUE"%d дня/дней"cWHITE" за "cBLUE"$%d"cWHITE".",
				!HouseInfo[h][hType] ? ("дом") : ("квартиру"),
				HouseInfo[h][hID],
				paydays,
				paydays * price );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Bank:hID" );
			DeletePVar( playerid, "Bank:Day" );
			DeletePVar( playerid, "Bank:PayDays" );
			
			showPlayerDialog( playerid, d_bank + 8, DIALOG_STYLE_LIST, "Оплата услуг", dialog_pay, "Выбрать", "Назад" );
		}
		
		case d_bank + 12:
		{
			if( !response )
			{
				DeletePVar( playerid, "Bank:hID" );
				DeletePVar( playerid, "Bank:Day" );
			
				ShowHousePlayerList( playerid, d_bank + 9, "Далее", "Назад" );
				
				return 1;
			}
			
			new
				h = GetPVarInt( playerid, "Bank:hID" ),
				days = GetPVarInt( playerid, "Bank:Day" ),
				month, day,
				price = GetPriceRentHouse( h ) - ( GetPriceRentHouse( h ) * Premium[playerid][prem_drop_payment] / 100 );
			
			gmtime( HouseInfo[h][hSellDate], _, month, day );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 7 + Premium[playerid][prem_h_payment] - days )
			{
				format:g_small_string( "\
					"cBLUE"Оплата аренды\n\n\
					"cWHITE"%s #%d: оплачен до "cBLUE"%02d.%02d\n\
					"cWHITE"Тариф: "cBLUE"%d/день\n\n\
					"cWHITE"Для продления укажите количество дней:\n\
					"gbDialog"Максимум: %d\n\
					"gbDialogError"Неправильный формат ввода.",
					!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
					HouseInfo[h][hID],
					day, month,
					price,
					7 + Premium[playerid][prem_h_payment] - days );
					
				return showPlayerDialog( playerid, d_bank + 12, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Bank:PayDays", strval( inputtext ) );
			
			format:g_small_string( "\
				"cWHITE"Счет на оплату аренды "cBLUE"%s #%d:\n\
				"cWHITE"Количество дней: "cBLUE"%d"cWHITE" на сумму "cBLUE"$%d\n\n\
				"cWHITE"Продолжить?",
				!HouseInfo[h][hType] ? ("дома") : ("квартиры"),
				HouseInfo[h][hID],
				strval( inputtext ), 
				price * strval( inputtext ) );
				
			showPlayerDialog( playerid, d_bank + 13, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Оплата", "Назад" );
		}
		
		case d_bank + 13:
		{
			new
				h = GetPVarInt( playerid, "Bank:hID" ),
				days = GetPVarInt( playerid, "Bank:Day" ),
				paydays = GetPVarInt( playerid, "Bank:PayDays" ),
				month, day,
				price = GetPriceRentHouse( h ) - ( GetPriceRentHouse( h ) * Premium[playerid][prem_drop_payment] / 100 );
			
			gmtime( HouseInfo[h][hSellDate], _, month, day );
			
			if( !response )
			{
				DeletePVar( playerid, "Bank:PayDays" );
			
				format:g_small_string( "\
					"cBLUE"Оплата аренды\n\n\
					"cWHITE"%s #%d: оплачен до "cBLUE"%02d.%02d\n\
					"cWHITE"Тариф: "cBLUE"%d/день\n\n\
					"cWHITE"Для продления укажите количество дней:\n\
					"gbDialog"Максимум: %d",
					!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
					HouseInfo[h][hID],
					day, month,
					price,
					7 + Premium[playerid][prem_h_payment] - days );
					
				showPlayerDialog( playerid, d_bank + 12, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[playerid][uBank] < paydays * price )
			{
				format:g_small_string( "\
					"cBLUE"Оплата аренды\n\n\
					"cWHITE"%s #%d: оплачен до "cBLUE"%02d.%02d\n\
					"cWHITE"Тариф: "cBLUE"%d/день\n\n\
					"cWHITE"Для продления укажите количество дней:\n\
					"gbDialog"Максимум: %d\n\n\
					"gbDialogError"На Вашем банковском счете недостаточно средств.",
					!HouseInfo[h][hType] ? ("Дом") : ("Квартира"),
					HouseInfo[h][hID],
					day, month,
					price,
					7 + Premium[playerid][prem_h_payment] - days );
					
				return showPlayerDialog( playerid, d_bank + 12, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPlayerBank( playerid, "-", paydays * price );
			
			HouseInfo[h][hSellDate] += paydays * 86400;
			HouseUpdate( h, "hSellDate", HouseInfo[h][hSellDate] );
			
			pformat:( ""gbSuccess"Вы успешно оплатили "cBLUE"%s #%d"cWHITE" на "cBLUE"%d дня/дней"cWHITE" за "cBLUE"$%d"cWHITE".",
				!HouseInfo[h][hType] ? ("дом") : ("квартиру"),
				HouseInfo[h][hID],
				paydays,
				paydays * price );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Bank:hID" );
			DeletePVar( playerid, "Bank:Day" );
			DeletePVar( playerid, "Bank:PayDays" );
			
			showPlayerDialog( playerid, d_bank + 8, DIALOG_STYLE_LIST, "Оплата услуг", dialog_pay, "Выбрать", "Назад" );
		}
		
		case d_bank + 14:
		{
			if( !response )
				return showPlayerDialog( playerid, d_bank + 8, DIALOG_STYLE_LIST, "Оплата услуг", dialog_pay, "Выбрать", "Назад" );
			
			new
				pen = g_dialog_select[playerid][listitem];
				
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			if( Player[playerid][uBank] < Penalty[playerid][pen][pen_price] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"На Вашем банковском счете недостаточно средств." );
			
				ShowPenalties( playerid );
				return 1;
			}
			
			SetPlayerBank( playerid, "-", Penalty[playerid][pen][pen_price] );
			Penalty[playerid][pen][pen_type] = 1;
			
			mysql_format:g_small_string( "UPDATE `"DB_PENALTIES"` SET `pen_type` = 1 WHERE `pen_id` = %d LIMIT 1", Penalty[playerid][pen][pen_id] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Штраф "cBLUE"#%d"cWHITE" успешно оплачен. Деньги списаны с банковского счета.", Penalty[playerid][pen][pen_id] );
			psend:( playerid, C_WHITE );
			
			showPlayerDialog( playerid, d_bank + 8, DIALOG_STYLE_LIST, "Оплата услуг", dialog_pay, "Выбрать", "Назад" );
		}
	}
	
	return 1;
}

function Atm_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED(KEY_WALK) ) 
	{
		for( new i; i < sizeof cashbox_info; i++ )
		{
			if( IsPlayerInRangeOfPoint( playerid, 1.0, cashbox_info[i][c_cashbox_pos][0], cashbox_info[i][c_cashbox_pos][1], cashbox_info[i][c_cashbox_pos][2] ) ) 
			{
				return showPlayerDialog( playerid, d_bank + 1, DIALOG_STYLE_LIST, "Управление личным счетом", dialog_bank, "Далее", "Закрыть" );
			}
		}
	}
	
	return 1;
}