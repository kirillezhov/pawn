function showDonatPanel( playerid )
{
	Player[playerid][uGMoney] = cache_get_field_content_int( 0, "uGMoney", mysql );
	showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );

	return 1;
}

function Donate_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_donate:
		{
			if( !response )
				return 1;
				
			switch( listitem )
			{
				case 0: //Информация
				{
					showPlayerDialog( playerid, d_donate + 1, DIALOG_STYLE_LIST, "Информация", donatinfo, "Выбрать", "Назад" );
				}
				
				case 1: //Обмен валюты
				{
					format:g_small_string( donatmoney, Player[playerid][uGMoney] );
					showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 2: //Премиум аккаунты
				{
					showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
				}
				
				case 3: //Дополнительные возможности
				{
					ShowDonatAdd( playerid );
				}
			}
		}
		
		case d_donate + 1:
		{
			if( !response )
				return showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
				
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_donate + 25, DIALOG_STYLE_MSGBOX, " ", donattotal, "Назад", "" );
				}
				
				case 1:
				{
					format:g_string( donatbalance, Player[playerid][uGMoney] );
					showPlayerDialog( playerid, d_donate + 25, DIALOG_STYLE_MSGBOX, " ", g_string, "Назад", "" );
				}
				
				case 2:
				{
					if( !Premium[playerid][prem_id] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"У Вас нет премиум аккаунта." );
						return showPlayerDialog( playerid, d_donate + 1, DIALOG_STYLE_LIST, "Информация", donatinfo, "Выбрать", "Назад" );
					}
					
					ShowMyPremiumInfo( playerid );
				}
			}
		}
		
		case d_donate + 2:
		{
			if( !response )
				return showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
				
			if( listitem == 4 ) //Продление
			{
				if( !Premium[playerid][prem_id] )
				{
					SendClient:( playerid, C_WHITE, !""gbError"У Вас нет премиум аккаунта." );
					return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
				}
				
				if( Premium[playerid][prem_type] == 4 )
				{
					SendClient:( playerid, C_WHITE, !""gbError"Вы не можете продлить премиум аккаунт 'Настраиваемый'." );
					return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
				}
				
				new
					days,
					Float:interval;
					
				interval = float( Premium[playerid][prem_time] - gettime() ) / 86400.0;
				days = floatround( interval, floatround_floor );
				
				if( days > 7 )
				{
					SendClient:( playerid, C_WHITE, !""gbError"Вы можете продлить премиум аккаунт за 7 дней до окончания срока действия." );
					return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
				}
				
				if( Player[playerid][uGMoney] < premium_info[ Premium[playerid][prem_type] ][prem_price] || !Player[playerid][uGMoney] )
				{
					SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
				}
				
				Premium[playerid][prem_time] = Premium[playerid][prem_time] + 30 * 86400;
				Player[playerid][uGMoney] -= premium_info[ Premium[playerid][prem_type] ][prem_price];
				UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
				
				mysql_format:g_small_string( "UPDATE `"DB_PREMIUM"` SET `prem_time` = %d WHERE `prem_id` = %d LIMIT 1", 
					Premium[playerid][prem_time], Premium[playerid][prem_id] );
				mysql_tquery( mysql, g_small_string );
				
				pformat:( ""gbSuccess"Вы успешно продлили премиум аккаунт %s%s"cWHITE" (%d RCoin) на "cBLUE"30"cWHITE" дней.", GetPremiumColor( Premium[playerid][prem_color] ), 
					GetPremiumName( Premium[playerid][prem_type] ), premium_info[ Premium[playerid][prem_type] ][prem_price] );
				psend:( playerid, C_WHITE );
				
				showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
			}
			else if( listitem == 3 ) //Настраиваемый
			{
				TimePremium[playerid][prem_id] =
				TimePremium[playerid][prem_time] = 
				TimePremium[playerid][prem_type] = 
				TimePremium[playerid][prem_color] = 
				TimePremium[playerid][prem_gmoney] = 
				TimePremium[playerid][prem_bank] = 
				TimePremium[playerid][prem_salary] = 
				TimePremium[playerid][prem_benefit] = 
				TimePremium[playerid][prem_mass] = 
				TimePremium[playerid][prem_admins] = 
				TimePremium[playerid][prem_supports] = 
				TimePremium[playerid][prem_h_payment] = 
				TimePremium[playerid][prem_house] = 
				TimePremium[playerid][prem_car] = 
				TimePremium[playerid][prem_business] = 
				TimePremium[playerid][prem_house_property] = 
				TimePremium[playerid][prem_drop_retreature] = 
				TimePremium[playerid][prem_drop_tuning] = 
				TimePremium[playerid][prem_drop_repair] = 
				TimePremium[playerid][prem_drop_payment] = 0;
				
				ValuePremium[playerid][value_amount] =
				ValuePremium[playerid][value_gmoney] = 0;
				ValuePremium[playerid][value_days] = 30;
			
				SetPVarInt( playerid, "Premium:Type", listitem + 1 );
				ShowPremiumSettings( playerid );
			}
			else
			{
				SetPVarInt( playerid, "Premium:Type", listitem + 1 );
				ShowPremiumInfo( playerid, listitem + 1 );
			}
		}
		
		case d_donate + 3: //Покупка Стартового, Комфортного, Оптимального 
		{
			if( !response )
			{
				DeletePVar( playerid, "Premium:Type" );
				return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
			}
			
			new
				type = GetPVarInt( playerid, "Premium:Type" );
				
			if( Premium[playerid][prem_id] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"У Вас уже есть премиум аккаунт." );
				
				DeletePVar( playerid, "Premium:Type" );
				return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
			}
				
			if( Player[playerid][uGMoney] < premium_info[type][prem_price] )
			{
				SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
				
				DeletePVar( playerid, "Premium:Type" );
				return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
			}
			
			Player[playerid][uGMoney] -= premium_info[type][prem_price];
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
				
			Premium[playerid][prem_time] 		= gettime() + 30 * 86400;
			Premium[playerid][prem_type] 		= type;
			Premium[playerid][prem_color] 		= premium_info[type][prem_color][0];
			Premium[playerid][prem_gmoney]	 	= premium_info[type][prem_gmoney][0];
			Premium[playerid][prem_bank] 		= premium_info[type][prem_bank][0];
			Premium[playerid][prem_salary]		= premium_info[type][prem_salary][0];
			Premium[playerid][prem_benefit]	 	= premium_info[type][prem_benefit][0];
			Premium[playerid][prem_mass]	 	= premium_info[type][prem_mass][0];
			Premium[playerid][prem_admins]		= premium_info[type][prem_admins][0];
			Premium[playerid][prem_supports] 	= premium_info[type][prem_supports][0];
			Premium[playerid][prem_h_payment]	= premium_info[type][prem_h_payment][0];
			Premium[playerid][prem_car]			= premium_info[type][prem_car][0];
			Premium[playerid][prem_house]		= premium_info[type][prem_house][0];
			Premium[playerid][prem_business]	= premium_info[type][prem_business][0];
			Premium[playerid][prem_house_property]	= premium_info[type][prem_house_property][0];
			Premium[playerid][prem_drop_retreature]	= premium_info[type][prem_drop_retreature][0];
			Premium[playerid][prem_drop_tuning]		= premium_info[type][prem_drop_tuning][0];
			Premium[playerid][prem_drop_repair]		= premium_info[type][prem_drop_repair][0];
			Premium[playerid][prem_drop_payment]	= premium_info[type][prem_drop_payment][0];
			
			mysql_format:g_string( "\
				INSERT INTO `"DB_PREMIUM"`\
					( `prem_user_id`, `prem_type`, `prem_time`, `prem_color`, `prem_gmoney`, `prem_bank`, `prem_salary`,\
					`prem_benefit`, `prem_mass`, `prem_admins`, `prem_supports`, `prem_h_payment`, `prem_house`,\
					`prem_car`, `prem_business`, `prem_house_property`, `prem_drop_retreature`, `prem_drop_tuning`,\
					`prem_drop_repair`, `prem_drop_payment`\
					) \
				VALUES \
					( %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d )",
				Player[playerid][uID], 
				Premium[playerid][prem_type], 
				Premium[playerid][prem_time],
				Premium[playerid][prem_color],
				Premium[playerid][prem_gmoney],
				Premium[playerid][prem_bank],
				Premium[playerid][prem_salary],
				Premium[playerid][prem_benefit],
				Premium[playerid][prem_mass],
				Premium[playerid][prem_admins],
				Premium[playerid][prem_supports],
				Premium[playerid][prem_h_payment],
				Premium[playerid][prem_house],
				Premium[playerid][prem_car],
				Premium[playerid][prem_business],
				Premium[playerid][prem_house_property],
				Premium[playerid][prem_drop_retreature],
				Premium[playerid][prem_drop_tuning],
				Premium[playerid][prem_drop_repair],
				Premium[playerid][prem_drop_payment]
			);
			
			mysql_tquery( mysql, g_string, "AddPremium", "d", playerid );
			
			pformat:( ""gbSuccess"Вы приобрели премиум аккаунт %s%s"cWHITE" (%d RCoin), cрок действия - "cBLUE"30"cWHITE" дней.", GetPremiumColor( Premium[playerid][prem_color] ), premium_info[type][prem_price], GetPremiumName( type ) );
			psend:( playerid, C_WHITE );
			
			log( LOG_BUY_PREMIUM, "купил премиум аккаунт", Player[playerid][uID], type );
			
			DeletePVar( playerid, "Premium:Type" );
			showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
		}
		
		case d_donate + 4: //Обмен валюты
		{
			if( !response )
				return showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1  )
			{
				clean:<g_string>;
			
				format:g_small_string( donatmoney, Player[playerid][uGMoney] ), strcat( g_string, g_small_string );
				strcat( g_string, "\n"gbDialogError"Неправильный формат ввода." );
				
				return showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
			}
			
			if( strval( inputtext ) > Player[playerid][uGMoney] )
			{
				clean:<g_string>;
			
				format:g_small_string( donatmoney, Player[playerid][uGMoney] ), strcat( g_string, g_small_string );
				strcat( g_string, "\n"gbDialogError"На Вашем счете недостаточно RCoin." );
				
				return showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Donat:Money", strval( inputtext ) );
			
			format:g_small_string( "\
				"cBLUE"Обмен валюты"cWHITE"\n\n\
				Подтверждение: Вы обмениваете "cBLUE"%d RCoin"cWHITE" на "cBLUE"$%d"cWHITE".\n\
				Продолжить?",
				strval( inputtext ),
				strval( inputtext ) * 100 );
			showPlayerDialog( playerid, d_donate + 5, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		}
		
		case d_donate + 5:
		{
			if( !response )
			{
				DeletePVar( playerid, "Donat:Money" );
				
				format:g_small_string( donatmoney, Player[playerid][uGMoney] );
				return showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			new
				money = GetPVarInt( playerid, "Donat:Money" );
				
			if( money > Player[playerid][uGMoney] || !Player[playerid][uGMoney] )
			{
				clean:<g_string>;
			
				format:g_small_string( donatmoney, Player[playerid][uGMoney] ), strcat( g_string, g_small_string );
				strcat( g_string, "\n"gbDialogError"На Вашем счете недостаточно RCoin." );
				
				return showPlayerDialog( playerid, d_donate + 4, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
			}
			
			Player[playerid][uGMoney] -= money;
			
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			SetPlayerCash( playerid, "+", money * 100 );
			
			DeletePVar( playerid, "Donat:Money" );
			
			pformat:( ""gbSuccess"Вы обменяли "cBLUE"%d"cWHITE" RCoin на "cBLUE"$%d"cWHITE".", money, money * 100 );
			psend:( playerid, C_WHITE );
			
			log( LOG_TRANSFER_RCOIN, "обменял валюту", Player[playerid][uID], money, money * 100 );
			
			showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
		}
		
		case d_donate + 6: //Диалог с настройкой премиума
		{
			if( !response )
			{
				TimePremium[playerid][prem_id] =
				TimePremium[playerid][prem_time] = 
				TimePremium[playerid][prem_type] = 
				TimePremium[playerid][prem_color] = 
				TimePremium[playerid][prem_gmoney] = 
				TimePremium[playerid][prem_bank] = 
				TimePremium[playerid][prem_salary] = 
				TimePremium[playerid][prem_benefit] = 
				TimePremium[playerid][prem_mass] = 
				TimePremium[playerid][prem_admins] = 
				TimePremium[playerid][prem_supports] = 
				TimePremium[playerid][prem_h_payment] = 
				TimePremium[playerid][prem_house] = 
				TimePremium[playerid][prem_car] = 
				TimePremium[playerid][prem_business] = 
				TimePremium[playerid][prem_house_property] = 
				TimePremium[playerid][prem_drop_retreature] = 
				TimePremium[playerid][prem_drop_tuning] = 
				TimePremium[playerid][prem_drop_repair] = 
				TimePremium[playerid][prem_drop_payment] = 0;
				
				ValuePremium[playerid][value_amount] =
				ValuePremium[playerid][value_gmoney] = 0;
				ValuePremium[playerid][value_days] = 30;
			
				DeletePVar( playerid, "Premium:Type" );
				return showPlayerDialog( playerid, d_donate + 2, DIALOG_STYLE_LIST, "Премиум аккаунты", donatpremium, "Выбрать", "Назад" );
			}
			
			clean:<g_string>;
			
			new
				count = 0;
			
			switch( listitem )
			{
				case 0: //Цвет
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						format:g_small_string( "\n%sВыбрать цвет", GetPremiumColor( i ) );
						strcat( g_string, g_small_string );
					}
					
					showPlayerDialog( playerid, d_donate + 7, DIALOG_STYLE_LIST, "Цвет премиума", g_string, "Выбрать", "Назад" );
				}
				
				case 1: //RCoin
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_gmoney ][0] )
						{
							format:g_small_string( "\n%d RCoin", premium_info[i][ prem_gmoney ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 8, DIALOG_STYLE_LIST, "RCoin в PayDay", g_string, "Выбрать", "Назад" );
				}
				
				case 2: //Банк
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_bank ][0] )
						{
							format:g_small_string( "\n0.%d %%", premium_info[i][ prem_bank ][0] );
							strcat( g_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_donate + 9, DIALOG_STYLE_LIST, "Банковские накопления", g_string, "Выбрать", "Назад" );
				}
				
				case 3: //Зарплата
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_salary ][0] )
						{
							format:g_small_string( "\n%d %%", premium_info[i][ prem_salary ][0] );
							strcat( g_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_donate + 10, DIALOG_STYLE_LIST, "Заработная плата", g_string, "Выбрать", "Назад" );
				}
				
				case 4: //Пособие по безработице
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_benefit ][0] )
						{
							format:g_small_string( "\n%d %%", premium_info[i][ prem_benefit ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 11, DIALOG_STYLE_LIST, "Пособие по безработице", g_string, "Выбрать", "Назад" );
				}
				
				case 5: //Вес 
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_mass ][0] )
						{
							format:g_small_string( "\n%d кг", premium_info[i][ prem_mass ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 12, DIALOG_STYLE_LIST, "Дополнительный вес", g_string, "Выбрать", "Назад" );
				}
				
				case 6: //admins 
				{
					showPlayerDialog( playerid, d_donate + 13, DIALOG_STYLE_LIST, "Команда /admins", "Нет\nДа", "Выбрать", "Назад" );
				}
				
				case 7: //supports 
				{
					showPlayerDialog( playerid, d_donate + 14, DIALOG_STYLE_LIST, "Команда /supports", "Нет\nДа", "Выбрать", "Назад" );
				}
				
				case 8: //Дни на оплату дома
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_h_payment ][0] )
						{
							format:g_small_string( "\n+ %d дней", premium_info[i][ prem_h_payment ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 15, DIALOG_STYLE_LIST, "Оплата дома", g_string, "Выбрать", "Назад" );
				}
				
				case 9: //Транспорт
				{
					showPlayerDialog( playerid, d_donate + 16, DIALOG_STYLE_LIST, "Возможность иметь 2 авто", "Нет\nДа", "Выбрать", "Назад" );
				}
				
				case 10: //Дома
				{
					showPlayerDialog( playerid, d_donate + 17, DIALOG_STYLE_LIST, "Возможность иметь 2 дома", "Нет\nДа", "Выбрать", "Назад" );
				}
				
				case 11: //Бизнесы
				{
					showPlayerDialog( playerid, d_donate + 18, DIALOG_STYLE_LIST, "Возможность иметь 2 бизнеса", "Нет\nДа", "Выбрать", "Назад" );
				}
				
				case 12: //Продажа имущества
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_house_property ][0] )
						{
							format:g_small_string( "\n+ %d %%", premium_info[i][ prem_house_property ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 19, DIALOG_STYLE_LIST, "Продажа имущества государству", g_string, "Выбрать", "Назад" );
				}
				
				case 13: //Ретекстур
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_drop_retreature ][0] )
						{
							format:g_small_string( "\n- %d %%", premium_info[i][ prem_drop_retreature ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 20, DIALOG_STYLE_LIST, "Стоимость ретекстуризации", g_string, "Выбрать", "Назад" );
				}
				
				case 14: //Тюнинг
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_drop_tuning ][0] )
						{
							format:g_small_string( "\n- %d %%", premium_info[i][ prem_drop_tuning ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 21, DIALOG_STYLE_LIST, "Стоимость тюнинга", g_string, "Выбрать", "Назад" );
				}
				
				case 15: //Ремонт
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_drop_repair ][0] )
						{
							format:g_small_string( "\n- %d %%", premium_info[i][ prem_drop_repair ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 22, DIALOG_STYLE_LIST, "Стоимость ремонта", g_string, "Выбрать", "Назад" );
				}
				
				case 16: //Коммунальные платежи
				{
					strcat( g_string, "Нет" );
				
					for( new i = 1; i < 4; i++ )
					{
						if( premium_info[i][ prem_drop_payment ][0] )
						{
							format:g_small_string( "\n- %d %%", premium_info[i][ prem_drop_payment ][0] );
							strcat( g_string, g_small_string );
							
							count++;
							g_dialog_select[playerid][count] = i;
						}
					}
					
					showPlayerDialog( playerid, d_donate + 23, DIALOG_STYLE_LIST, "Оплата дома", g_string, "Выбрать", "Назад" );
				}
				
				case 17: //При покупке выбираем срок действия премиума
				{
					if( Premium[playerid][prem_id] )
					{
						ShowPremiumSettings( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"У Вас уже есть премиум аккаунт." );
					}
				
					if( Player[playerid][uGMoney] < ValuePremium[playerid][value_gmoney] || !Player[playerid][uGMoney] )
					{
						ShowPremiumSettings( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( ValuePremium[playerid][value_gmoney] < premium_info[1][prem_price] || ValuePremium[playerid][value_amount] < 11 )
					{
						ShowPremiumSettings( playerid );
						
						pformat:( ""gbError"Недостаточно настроек ("cBLUE"%d/11"cWHITE") для покупки премиум аккаунта.", ValuePremium[playerid][value_amount] );
						psend:( playerid, C_WHITE );
						return 1;
					}
				
					format:g_small_string( "\
						"cWHITE"Количество дней\t"cWHITE"Стоимость\n\
						"cWHITE"30 дней\t"cBLUE"%d RCoin\n\
						"cWHITE"60 дней\t"cBLUE"%d RCoin "cGREEN"(скидка 6 %%)\n\
						"cWHITE"90 дней\t"cBLUE"%d RCoin "cGREEN"(скидка 12 %%)\n",
						ValuePremium[playerid][value_gmoney], 
						floatround( ValuePremium[playerid][value_gmoney] * 2 * 0.94 ),
						floatround( ValuePremium[playerid][value_gmoney] * 3 * 0.88 ) );
			
					showPlayerDialog( playerid, d_donate + 24, DIALOG_STYLE_TABLIST_HEADERS, "Срок действия премиума", g_small_string, "Купить", "Назад" );
				}
				
				case 18: //Купить
				{
					if( Premium[playerid][prem_id] )
					{
						ShowPremiumSettings( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"У Вас уже есть премиум аккаунт." );
					}
				
					if( Player[playerid][uGMoney] < ValuePremium[playerid][value_gmoney] || !Player[playerid][uGMoney] )
					{
						ShowPremiumSettings( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( ValuePremium[playerid][value_gmoney] < premium_info[1][prem_price] || ValuePremium[playerid][value_amount] < 11 )
					{
						ShowPremiumSettings( playerid );
						
						pformat:( ""gbError"Недостаточно настроек ("cBLUE"%d/11"cWHITE") для покупки премиум аккаунта.", ValuePremium[playerid][value_amount] );
						psend:( playerid, C_WHITE );
						return 1;
					}
					
					Player[playerid][uGMoney] -= ValuePremium[playerid][value_gmoney];
					UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
						
					Premium[playerid][prem_time] 		= gettime() + ValuePremium[playerid][value_days] * 86400;
					Premium[playerid][prem_type] 		= 4;
					Premium[playerid][prem_color] 		= TimePremium[playerid][prem_color];
					Premium[playerid][prem_gmoney]	 	= TimePremium[playerid][prem_gmoney];
					Premium[playerid][prem_bank] 		= TimePremium[playerid][prem_bank];
					Premium[playerid][prem_salary]		= TimePremium[playerid][prem_salary];
					Premium[playerid][prem_benefit]	 	= TimePremium[playerid][prem_benefit];
					Premium[playerid][prem_mass]	 	= TimePremium[playerid][prem_mass];
					Premium[playerid][prem_admins]		= TimePremium[playerid][prem_admins];
					Premium[playerid][prem_supports] 	= TimePremium[playerid][prem_supports];
					Premium[playerid][prem_h_payment]	= TimePremium[playerid][prem_h_payment];
					Premium[playerid][prem_car]			= TimePremium[playerid][prem_car];
					Premium[playerid][prem_house]		= TimePremium[playerid][prem_house];
					Premium[playerid][prem_business]	= TimePremium[playerid][prem_business];
					Premium[playerid][prem_house_property]	= TimePremium[playerid][prem_house_property];
					Premium[playerid][prem_drop_retreature]	= TimePremium[playerid][prem_drop_retreature];
					Premium[playerid][prem_drop_tuning]		= TimePremium[playerid][prem_drop_tuning];
					Premium[playerid][prem_drop_repair]		= TimePremium[playerid][prem_drop_repair];
					Premium[playerid][prem_drop_payment]	= TimePremium[playerid][prem_drop_payment];
					
					mysql_format:g_string( "\
						INSERT INTO `"DB_PREMIUM"`\
							( `prem_user_id`, `prem_type`, `prem_time`, `prem_color`, `prem_gmoney`, `prem_bank`, `prem_salary`,\
							`prem_benefit`, `prem_mass`, `prem_admins`, `prem_supports`, `prem_h_payment`, `prem_house`,\
							`prem_car`, `prem_business`, `prem_house_property`, `prem_drop_retreature`, `prem_drop_tuning`,\
							`prem_drop_repair`, `prem_drop_payment`\
							) \
						VALUES \
							( %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d )",
						Player[playerid][uID], 
						Premium[playerid][prem_type], 
						Premium[playerid][prem_time],
						Premium[playerid][prem_color],
						Premium[playerid][prem_gmoney],
						Premium[playerid][prem_bank],
						Premium[playerid][prem_salary],
						Premium[playerid][prem_benefit],
						Premium[playerid][prem_mass],
						Premium[playerid][prem_admins],
						Premium[playerid][prem_supports],
						Premium[playerid][prem_h_payment],
						Premium[playerid][prem_house],
						Premium[playerid][prem_car],
						Premium[playerid][prem_business],
						Premium[playerid][prem_house_property],
						Premium[playerid][prem_drop_retreature],
						Premium[playerid][prem_drop_tuning],
						Premium[playerid][prem_drop_repair],
						Premium[playerid][prem_drop_payment]
					);
					
					mysql_tquery( mysql, g_string, "AddPremium", "d", playerid );
					
					pformat:( ""gbSuccess"Вы приобрели премиум аккаунт %sНастраиваемый"cWHITE", cрок действия - "cBLUE"%d"cWHITE" дней.", GetPremiumColor( Premium[playerid][prem_color] ), ValuePremium[playerid][value_days] );
					psend:( playerid, C_WHITE );
					
					log( LOG_BUY_PREMIUM, "купил премиум аккаунт", Player[playerid][uID], 4 );
					
					TimePremium[playerid][prem_id] =
					TimePremium[playerid][prem_time] = 
					TimePremium[playerid][prem_type] = 
					TimePremium[playerid][prem_color] = 
					TimePremium[playerid][prem_gmoney] = 
					TimePremium[playerid][prem_bank] = 
					TimePremium[playerid][prem_salary] = 
					TimePremium[playerid][prem_benefit] = 
					TimePremium[playerid][prem_mass] = 
					TimePremium[playerid][prem_admins] = 
					TimePremium[playerid][prem_supports] = 
					TimePremium[playerid][prem_h_payment] = 
					TimePremium[playerid][prem_house] = 
					TimePremium[playerid][prem_car] = 
					TimePremium[playerid][prem_business] = 
					TimePremium[playerid][prem_house_property] = 
					TimePremium[playerid][prem_drop_retreature] = 
					TimePremium[playerid][prem_drop_tuning] = 
					TimePremium[playerid][prem_drop_repair] = 
					TimePremium[playerid][prem_drop_payment] = 0;
					
					ValuePremium[playerid][value_amount] =
					ValuePremium[playerid][value_gmoney] = 0;
					ValuePremium[playerid][value_days] = 30;
					
					showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
				}
			}
		}
		
		/* - - - - - - - Настраиваемый премиум аккаунт - - - - - - - */
		
		case d_donate + 7: //Цвет
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_color] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_color] == premium_info[i][ prem_color ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_color ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_color] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_color] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_color] == premium_info[i][ prem_color ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_color ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[listitem][ prem_color ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_color] = listitem;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 8: //RCoin
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_gmoney] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_gmoney] == premium_info[i][ prem_gmoney ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_gmoney ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_gmoney] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_gmoney] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_gmoney] == premium_info[i][ prem_gmoney ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_gmoney ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_gmoney ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_gmoney] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_gmoney ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}

		case d_donate + 9: //Банк
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_bank] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_bank] == premium_info[i][ prem_bank ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_bank ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_bank] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_bank] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_bank] == premium_info[i][ prem_bank ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_bank ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[listitem][ prem_bank ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_bank] = premium_info[listitem][ prem_bank ][0];
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 10: //Заработная плата
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_salary] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_salary] == premium_info[i][ prem_salary ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_salary ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_salary] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_salary] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_salary] == premium_info[i][ prem_salary ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_salary ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[listitem][ prem_salary ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_salary] = premium_info[listitem][ prem_salary ][0];
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 11: //Пособие по безработице
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_benefit] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_benefit] == premium_info[i][ prem_benefit ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_benefit ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_benefit] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_benefit] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_benefit] == premium_info[i][ prem_benefit ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_benefit ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_benefit ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_benefit] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_benefit ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 12: //Вес
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_mass] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_mass] == premium_info[i][ prem_mass ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_mass ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_mass] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_mass] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_mass] == premium_info[i][ prem_mass ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_mass ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_mass ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_mass] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_mass ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 13: //admins
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_admins] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_admins ][1];
				}
				
				TimePremium[playerid][prem_admins] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_admins] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[ 3 ][ prem_admins ][1];
				}
				
				TimePremium[playerid][prem_admins] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 14: //supports
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_supports] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_supports ][1];
				}
				
				TimePremium[playerid][prem_supports] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_supports] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[3][ prem_supports ][1];
				}
				
				TimePremium[playerid][prem_supports] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 15: //Дни для оплаты дома
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_h_payment] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_h_payment] == premium_info[i][ prem_h_payment ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_h_payment ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_h_payment] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_h_payment] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_h_payment] == premium_info[i][ prem_h_payment ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_h_payment ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_h_payment ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_h_payment] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_h_payment ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 16: //Транспорт
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_car] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_car ][1];
				}
				
				TimePremium[playerid][prem_car] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_car] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[3][ prem_car ][1];
				}
				
				TimePremium[playerid][prem_car] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 17: //Дома
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_house] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_house ][1];
				}
				
				TimePremium[playerid][prem_house] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_house] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[3][ prem_house ][1];
				}
				
				TimePremium[playerid][prem_house] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 18: //Бизнесы
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_business] )
				{
					ValuePremium[playerid][value_amount] --;
					ValuePremium[playerid][value_gmoney] -= premium_info[3][ prem_business ][1];
				}
				
				TimePremium[playerid][prem_business] = 0;
			}
			else
			{
				if( !TimePremium[playerid][prem_business] )
				{
					ValuePremium[playerid][value_amount] ++;
					ValuePremium[playerid][value_gmoney] += premium_info[3][ prem_business ][1];
				}
				
				TimePremium[playerid][prem_business] = 1;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 19: //Продажа имущества
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_house_property] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_house_property] == premium_info[i][ prem_house_property ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_house_property ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_house_property] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_house_property] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_house_property] == premium_info[i][ prem_house_property ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_house_property ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_house_property ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_house_property] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_house_property ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 20: //Ретекстур
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_drop_retreature] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_drop_retreature] == premium_info[i][ prem_drop_retreature ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_retreature ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_drop_retreature] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_drop_retreature] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_drop_retreature] == premium_info[i][ prem_drop_retreature ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_retreature ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_retreature ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_drop_retreature] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_retreature ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 21: //Тюнинг
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_drop_tuning] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_drop_tuning] == premium_info[i][ prem_drop_tuning ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_tuning ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_drop_tuning] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_drop_tuning] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_drop_tuning] == premium_info[i][ prem_drop_tuning ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_tuning ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_tuning ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_drop_tuning] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_tuning ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 22: //Ремонт
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_drop_repair] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_drop_repair] == premium_info[i][ prem_drop_repair ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_repair ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_drop_repair] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_drop_repair] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_drop_repair] == premium_info[i][ prem_drop_repair ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_repair ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_repair ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_drop_repair] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_repair ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 23: //Оплата дома
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				if( TimePremium[playerid][prem_drop_payment] )
					ValuePremium[playerid][value_amount] --;
			
				for( new i; i < 4; i++ )
				{
					if( TimePremium[playerid][prem_drop_payment] == premium_info[i][ prem_drop_payment ][0] )
					{
						ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_payment ][1];
						break;
					}
				}
				
				TimePremium[playerid][prem_drop_payment] = 0;
			}
			else
			{
				if( TimePremium[playerid][prem_drop_payment] )
				{
					ValuePremium[playerid][value_amount] --;
					
					for( new i = 1; i < 4; i++ )
					{
						if( TimePremium[playerid][prem_drop_payment] == premium_info[i][ prem_drop_payment ][0] )
						{
							ValuePremium[playerid][value_gmoney] -= premium_info[i][ prem_drop_payment ][1];
							break;
						}
					}
				}
			
				ValuePremium[playerid][value_gmoney] += premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_payment ][1];
				ValuePremium[playerid][value_amount] ++;
			
				TimePremium[playerid][prem_drop_payment] = premium_info[ g_dialog_select[playerid][listitem] ][ prem_drop_payment ][0];
				g_dialog_select[playerid][listitem] = INVALID_PARAM;
			}
			
			ShowPremiumSettings( playerid );
		}
		
		case d_donate + 24: //Время
		{
			if( !response )
			{
				ShowPremiumSettings( playerid );
				return 1;
			}
			
			new
				price;
			
			ValuePremium[playerid][value_days] = 30 * (listitem + 1);
			
			switch( listitem )
			{
				case 0: price = ValuePremium[playerid][value_gmoney];
				case 1: price = floatround( ValuePremium[playerid][value_gmoney] * 2 * 0.94 );
				case 2: price = floatround( ValuePremium[playerid][value_gmoney] * 3 * 0.88 );
			}
			
			if( Premium[playerid][prem_id] )
			{
				ShowPremiumSettings( playerid );
				return SendClient:( playerid, C_WHITE, !""gbError"У Вас уже есть премиум аккаунт." );
			}
				
			if( Player[playerid][uGMoney] < price || !Player[playerid][uGMoney] )
			{
				ShowPremiumSettings( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
					
			if( ValuePremium[playerid][value_gmoney] < premium_info[1][prem_price] || ValuePremium[playerid][value_amount] < 11 )
			{
				ShowPremiumSettings( playerid );
						
				pformat:( ""gbError"Недостаточно настроек ("cBLUE"%d/11"cWHITE") для покупки премиум аккаунта.", ValuePremium[playerid][value_amount] );
				psend:( playerid, C_WHITE );
				return 1;
			}
					
			Player[playerid][uGMoney] -= price;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
						
			Premium[playerid][prem_time] 		= gettime() + ValuePremium[playerid][value_days] * 86400;
			Premium[playerid][prem_type] 		= 4;
			Premium[playerid][prem_color] 		= TimePremium[playerid][prem_color];
			Premium[playerid][prem_gmoney]	 	= TimePremium[playerid][prem_gmoney];
			Premium[playerid][prem_bank] 		= TimePremium[playerid][prem_bank];
			Premium[playerid][prem_salary]		= TimePremium[playerid][prem_salary];
			Premium[playerid][prem_benefit]	 	= TimePremium[playerid][prem_benefit];
			Premium[playerid][prem_mass]	 	= TimePremium[playerid][prem_mass];
			Premium[playerid][prem_admins]		= TimePremium[playerid][prem_admins];
			Premium[playerid][prem_supports] 	= TimePremium[playerid][prem_supports];
			Premium[playerid][prem_h_payment]	= TimePremium[playerid][prem_h_payment];
			Premium[playerid][prem_car]			= TimePremium[playerid][prem_car];
			Premium[playerid][prem_house]		= TimePremium[playerid][prem_house];
			Premium[playerid][prem_business]	= TimePremium[playerid][prem_business];
			Premium[playerid][prem_house_property]	= TimePremium[playerid][prem_house_property];
			Premium[playerid][prem_drop_retreature]	= TimePremium[playerid][prem_drop_retreature];
			Premium[playerid][prem_drop_tuning]		= TimePremium[playerid][prem_drop_tuning];
			Premium[playerid][prem_drop_repair]		= TimePremium[playerid][prem_drop_repair];
			Premium[playerid][prem_drop_payment]	= TimePremium[playerid][prem_drop_payment];
					
			mysql_format:g_string( "\
				INSERT INTO `"DB_PREMIUM"`\
					( `prem_user_id`, `prem_type`, `prem_time`, `prem_color`, `prem_gmoney`, `prem_bank`, `prem_salary`,\
					`prem_benefit`, `prem_mass`, `prem_admins`, `prem_supports`, `prem_h_payment`, `prem_house`,\
					`prem_car`, `prem_business`, `prem_house_property`, `prem_drop_retreature`, `prem_drop_tuning`,\
					`prem_drop_repair`, `prem_drop_payment`\
					) \
				VALUES \
					( %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d )",
				Player[playerid][uID], 
				Premium[playerid][prem_type], 
				Premium[playerid][prem_time],
				Premium[playerid][prem_color],
				Premium[playerid][prem_gmoney],
				Premium[playerid][prem_bank],
				Premium[playerid][prem_salary],
				Premium[playerid][prem_benefit],
				Premium[playerid][prem_mass],
				Premium[playerid][prem_admins],
				Premium[playerid][prem_supports],
				Premium[playerid][prem_h_payment],
				Premium[playerid][prem_house],
				Premium[playerid][prem_car],
				Premium[playerid][prem_business],
				Premium[playerid][prem_house_property],
				Premium[playerid][prem_drop_retreature],
				Premium[playerid][prem_drop_tuning],
				Premium[playerid][prem_drop_repair],
				Premium[playerid][prem_drop_payment]
			);
					
			mysql_tquery( mysql, g_string, "AddPremium", "d", playerid );
			
			pformat:( ""gbSuccess"Вы приобрели премиум аккаунт %sНастраиваемый"cWHITE" (%d RCoin), cрок действия - "cBLUE"%d"cWHITE" дней.", GetPremiumColor( Premium[playerid][prem_color] ), price, ValuePremium[playerid][value_days] );
			psend:( playerid, C_WHITE );
					
			TimePremium[playerid][prem_id] =
			TimePremium[playerid][prem_time] = 
			TimePremium[playerid][prem_type] = 
			TimePremium[playerid][prem_color] = 
			TimePremium[playerid][prem_gmoney] = 
			TimePremium[playerid][prem_bank] = 
			TimePremium[playerid][prem_salary] = 
			TimePremium[playerid][prem_benefit] = 
			TimePremium[playerid][prem_mass] = 
			TimePremium[playerid][prem_admins] = 
			TimePremium[playerid][prem_supports] = 
			TimePremium[playerid][prem_h_payment] = 
			TimePremium[playerid][prem_house] = 
			TimePremium[playerid][prem_car] = 
			TimePremium[playerid][prem_business] = 
			TimePremium[playerid][prem_house_property] = 
			TimePremium[playerid][prem_drop_retreature] = 
			TimePremium[playerid][prem_drop_tuning] = 
			TimePremium[playerid][prem_drop_repair] = 
			TimePremium[playerid][prem_drop_payment] = 0;
					
			ValuePremium[playerid][value_amount] =
			ValuePremium[playerid][value_gmoney] = 0;
			ValuePremium[playerid][value_days] = 30;
					
			showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
		}
		
		case d_donate + 25:
		{
			showPlayerDialog( playerid, d_donate + 1, DIALOG_STYLE_LIST, "Информация", donatinfo, "Выбрать", "Назад" );
		}
		
		/* - - - - - - - - - - Дополнительные возможности - - - - - - - - - - */
		
		case d_donate + 26:
		{
			if( !response )
				return showPlayerDialog( playerid, d_donate, DIALOG_STYLE_LIST, "Магазин", donat, "Выбрать", "Закрыть" );
		
			switch( listitem )
			{
				case 0: //Смена роли
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_ROLE )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
				
					showPlayerDialog( playerid, d_donate + 27, DIALOG_STYLE_LIST, ""cBLUE"Изменить: пол", "\
							"gbDialog"Выберите пол Вашего персонажа:\n\
							"cBLUE"- "cWHITE"Мужской\n\
							"cBLUE"- "cWHITE"Женский\
						", "Выбрать", "Назад" );
				}
				
				case 1: //Смена пола
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_SEX )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 33, DIALOG_STYLE_LIST, ""cBLUE"Изменить: пол", "\
							"gbDialog"Выберите пол Вашего персонажа:\n\
							"cBLUE"- "cWHITE"Мужской\n\
							"cBLUE"- "cWHITE"Женский\
						", "Выбрать", "Назад" );
				}
				
				case 2: //Смена цвета кожи
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_COLOR )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 34, DIALOG_STYLE_LIST, ""cBLUE"Изменить: цвет кожи", "\
							"gbDialog"Выберите цвет кожи Вашего персонажа:\n\
							"cBLUE"- "cWHITE"Темный\n\
							"cBLUE"- "cWHITE"Светлый\
						", "Выбрать", "Назад" );
				}
				
				case 3: //Смена национальности
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_NATION )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 35, DIALOG_STYLE_LIST, ""cBLUE"Изменить: национальность", "\
							"gbDialog"Выберите национальность Вашего персонажа:\n\
							"cBLUE"- "cWHITE"Австралиец\n\
							"cBLUE"- "cWHITE"Албанец\n\
							"cBLUE"- "cWHITE"Американец\n\
							"cBLUE"- "cWHITE"Англичанин\n\
							"cBLUE"- "cWHITE"Армянин\n\
							"cBLUE"- "cWHITE"Бразилец\n\
							"cBLUE"- "cWHITE"Вьетнамец\n\
							"cBLUE"- "cWHITE"Голландец\n\
							"cBLUE"- "cWHITE"Еврей\n\
							"cBLUE"- "cWHITE"Испанец\n\
							"cBLUE"- "cWHITE"Итальянец\n\
							"cBLUE"- "cWHITE"Китаец\n\
							"cBLUE"- "cWHITE"Колумбиец\n\
							"cBLUE"- "cWHITE"Кореец\n\
							"cBLUE"- "cWHITE"Латиноамериканец\n\
							"cBLUE"- "cWHITE"Мексиканец\n\
							"cBLUE"- "cWHITE"Немец\n\
							"cBLUE"- "cWHITE"Поляк\n\
							"cBLUE"- "cWHITE"Португалец\n\
							"cBLUE"- "cWHITE"Русский\n\
							"cBLUE"- "cWHITE"Турок\n\
							"cBLUE"- "cWHITE"Украинец\n\
							"cBLUE"- "cWHITE"Француз\n\
							"cBLUE"- "cWHITE"Чех\n\
							"cBLUE"- "cWHITE"Японец\
						", "Выбрать", "Назад" );
				}
				
				case 4: //Смена страны рождения
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_COUNTRY )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 36, DIALOG_STYLE_LIST, ""cBLUE"Изменить: страну рождения", "\
							"gbDialog"Выберите страну рождения Вашего персонажа:\n\
							"cBLUE"- "cWHITE"Австралия\n\
							"cBLUE"- "cWHITE"Албания\n\
							"cBLUE"- "cWHITE"Англия\n\
							"cBLUE"- "cWHITE"Армения\n\
							"cBLUE"- "cWHITE"Бразилия\n\
							"cBLUE"- "cWHITE"Вьетнам\n\
							"cBLUE"- "cWHITE"Германия\n\
							"cBLUE"- "cWHITE"Израиль\n\
							"cBLUE"- "cWHITE"Испания\n\
							"cBLUE"- "cWHITE"Италия\n\
							"cBLUE"- "cWHITE"Китай\n\
							"cBLUE"- "cWHITE"Колумбия\n\
							"cBLUE"- "cWHITE"Корея\n\
							"cBLUE"- "cWHITE"Мексика\n\
							"cBLUE"- "cWHITE"Нидерланды\n\
							"cBLUE"- "cWHITE"Польша\n\
							"cBLUE"- "cWHITE"Португалия\n\
							"cBLUE"- "cWHITE"Россия\n\
							"cBLUE"- "cWHITE"США\n\
							"cBLUE"- "cWHITE"Турция\n\
							"cBLUE"- "cWHITE"Франция\n\
							"cBLUE"- "cWHITE"Украина\n\
							"cBLUE"- "cWHITE"Чехия\n\
							"cBLUE"- "cWHITE"Япония\
						", "Выбрать", "Назад" );
				}
				
				case 5: //Смена возраста
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_AGE )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 37, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"Изменить: возраст\n\n\
							"cWHITE"Укажите возраст Вашего персонажа:\n\
							"gbDialog"От 16 до 70 лет",
						"Далее", "Назад" );
				}
				
				case 6: //Смена ника
				{
					if( Player[playerid][uGMoney] < PRICE_CHANGE_NAME )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					showPlayerDialog( playerid, d_donate + 39, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"Изменить: никнейм\n\n\
								"cWHITE"Укажите новые Имя и Фамилию:\n\n\
								Учитывайте правильность написания Имени/Фамилии:\n\
								"cBLUE"- "cGRAY"никнейм должен состоять только из латинских букв,\n\
								"cBLUE"- "cGRAY"между Имени и Фамилии должен использоваться знак '_',\n\
								"cBLUE"- "cGRAY"никнейм не должен содержать больше 24 и меньше 6 символов,\n\
								"cBLUE"- "cGRAY"Имя и(или) Фамилия не должны содержать меньше 3 символов,\n\
								"cBLUE"- "cGRAY"Имя и Фамилия должны начинаться с заглавных букв.",
						"Далее", "Назад" );
				}
				
				case 7: //Изучить стиль боя
				{
					if( Player[playerid][uGMoney] < PRICE_STYLE )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
				
					showPlayerDialog( playerid, d_donate + 40, DIALOG_STYLE_LIST, "Изучить стиль боя", "\
						"gbDialog"Выберите стиль боя:\n\
						"cBLUE"- "cWHITE"бокс\n\
						"cBLUE"- "cWHITE"кунг фу\n\
						"cBLUE"- "cWHITE"удар коленом\n\
						"cBLUE"- "cWHITE"удар ногой\n\
						"cBLUE"- "cWHITE"удар локтем", "Выбрать", "Назад" );
				}
				
				case 8: //Изучить все стили боя
				{
					if( Player[playerid][uGMoney] < PRICE_STYLE_ALL )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					new
						amount = 5;
					
					for( new i; i < 5; i++ )
					{
						if( Player[playerid][uStyle][i] )
							amount--;
					}
					
					if( !amount )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"Все стили боя уже изучены." );
					}
					
					clean:<g_string>;
					
					strcat( g_string, ""cBLUE"Изучить все стили боя\n\n"cWHITE"Вы изучите:" );
					
					if( !Player[playerid][uStyle][0] )
						strcat( g_string, "\n"cBLUE"Бокс" );
					
					if( !Player[playerid][uStyle][1] )
						strcat( g_string, "\n"cBLUE"Кунг Фу" );
						
					if( !Player[playerid][uStyle][2] )
						strcat( g_string, "\n"cBLUE"Удар коленом" );
						
					if( !Player[playerid][uStyle][3] )
						strcat( g_string, "\n"cBLUE"Удар ногой" );
					
					if( !Player[playerid][uStyle][4] )
						strcat( g_string, "\n"cBLUE"Удар локтем" );
						
					format:g_small_string( "\n\n"cWHITE"Стоимость "cBLUE"%d"cWHITE" RCoin. Продолжить?", PRICE_STYLE_ALL );
					strcat( g_string, g_small_string );
					
					showPlayerDialog( playerid, d_donate + 41, DIALOG_STYLE_MSGBOX, " ", g_string, "Да", "Нет" );
				}
				
				case 9: //Снять предупреждение
				{
					if( Player[playerid][uGMoney] < PRICE_UNWARN )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( !Player[playerid][uWarn] )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет предупреждений." );
					}
					
					format:g_small_string( "\
						"cBLUE"Снять предупреждение\n\n\
						"cWHITE"У Вас предупреждений: "cBLUE"%d/3\n\
						"cWHITE"Стоимость снятия одного предупреждения "cBLUE"%d"cWHITE" RCoin. Продолжить?", 
						Player[playerid][uWarn], PRICE_UNWARN );
					
					showPlayerDialog( playerid, d_donate + 42, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
				
				case 10: //Снять все предупреждения
				{
					if( Player[playerid][uGMoney] < PRICE_UNWARN_ALL )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( !Player[playerid][uWarn] )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"У Вас нет предупреждений." );
					}
					
					format:g_small_string( "\
						"cBLUE"Снять все предупреждения\n\n\
						"cWHITE"У Вас предупреждений: "cBLUE"%d/3\n\
						"cWHITE"Стоимость снятия всех предупреждений "cBLUE"%d"cWHITE" RCoin. Продолжить?", 
						Player[playerid][uWarn], PRICE_UNWARN_ALL );
					
					showPlayerDialog( playerid, d_donate + 43, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
				
				case 11: //Расторгнуть контракт
				{
					if( Player[playerid][uGMoney] < PRICE_UNJOB )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( !Player[ playerid ][uJob] )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не устроены на работу." );
					}
						
					if( job_duty{playerid} )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"Вы должны завершить рабочий день." );
					}
					
					format:g_small_string( "\
						"cBLUE"Расторгнуть шестичасовой рабочий контракт\n\n\
						"cWHITE"Стоимость расторжения трудового контракта на текущей работе "cBLUE"%d"cWHITE" RCoin. Продолжить?",
						PRICE_UNJOB );
					
					showPlayerDialog( playerid, d_donate + 44, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
				
				case 12: //Сменить номер телефона
				{
					if( Player[playerid][uGMoney] < PRICE_NUMBER_PHONE )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
					}
					
					if( !GetPhoneNumber( playerid ) )
					{
						ShowDonatAdd( playerid );
						return SendClient:( playerid, C_WHITE, !""gbError"Переложите в активный слот инвентаря телефон, на котором желаете изменить номер." );
					}
					
					showPlayerDialog( playerid, d_donate + 45, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Изменить номер телефона\n\n\
						"cWHITE"Укажите желаемый номер телефона:\n\
						"gbDialog"Номер телефона должен быть 6-значным", "Далее", "Назад" );
				}
			}
		}
		
		case d_donate + 27:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
		
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 27, DIALOG_STYLE_LIST, ""cBLUE"Изменить: пол", "\
						"gbDialog"Выберите пол Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Мужской\n\
						"cBLUE"- "cWHITE"Женский\
					", "Выбрать", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Sex", listitem );
			
			showPlayerDialog( playerid, d_donate + 28, DIALOG_STYLE_LIST, ""cBLUE"Изменить: цвет кожи", "\
					"gbDialog"Выберите цвет кожи Вашего персонажа:\n\
					"cBLUE"- "cWHITE"Темный\n\
					"cBLUE"- "cWHITE"Светлый\
				", "Выбрать", "Назад" );
		}
		
		case d_donate + 28: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Sex" );
				return showPlayerDialog( playerid, d_donate + 27, DIALOG_STYLE_LIST, ""cBLUE"Изменить: пол", "\
						"gbDialog"Выберите пол Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Мужской\n\
						"cBLUE"- "cWHITE"Женский\
					", "Выбрать", "Назад" );
			}
		
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 28, DIALOG_STYLE_LIST, ""cBLUE"Изменить: цвет кожи", "\
						"gbDialog"Выберите цвет кожи Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Темный\n\
						"cBLUE"- "cWHITE"Светлый\
					", "Выбрать", "Назад" );
			}
		
			SetPVarInt( playerid, "Change:Color", listitem );
		
			showPlayerDialog( playerid, d_donate + 29, DIALOG_STYLE_LIST, ""cBLUE"Изменить: национальность", "\
					"gbDialog"Выберите национальность Вашего персонажа:\n\
					"cBLUE"- "cWHITE"Австралиец\n\
					"cBLUE"- "cWHITE"Албанец\n\
					"cBLUE"- "cWHITE"Американец\n\
					"cBLUE"- "cWHITE"Англичанин\n\
					"cBLUE"- "cWHITE"Армянин\n\
					"cBLUE"- "cWHITE"Бразилец\n\
					"cBLUE"- "cWHITE"Вьетнамец\n\
					"cBLUE"- "cWHITE"Голландец\n\
					"cBLUE"- "cWHITE"Еврей\n\
					"cBLUE"- "cWHITE"Испанец\n\
					"cBLUE"- "cWHITE"Итальянец\n\
					"cBLUE"- "cWHITE"Китаец\n\
					"cBLUE"- "cWHITE"Колумбиец\n\
					"cBLUE"- "cWHITE"Кореец\n\
					"cBLUE"- "cWHITE"Латиноамериканец\n\
					"cBLUE"- "cWHITE"Мексиканец\n\
					"cBLUE"- "cWHITE"Немец\n\
					"cBLUE"- "cWHITE"Поляк\n\
					"cBLUE"- "cWHITE"Португалец\n\
					"cBLUE"- "cWHITE"Русский\n\
					"cBLUE"- "cWHITE"Турок\n\
					"cBLUE"- "cWHITE"Украинец\n\
					"cBLUE"- "cWHITE"Француз\n\
					"cBLUE"- "cWHITE"Чех\n\
					"cBLUE"- "cWHITE"Японец\
				", "Выбрать", "Назад" );
		}
		
		case d_donate + 29: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Color" );
				return showPlayerDialog( playerid, d_donate + 28, DIALOG_STYLE_LIST, ""cBLUE"Изменить: цвет кожи", "\
						"gbDialog"Выберите цвет кожи Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Темный\n\
						"cBLUE"- "cWHITE"Светлый\
					", "Выбрать", "Назад" );
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 29, DIALOG_STYLE_LIST, ""cBLUE"Изменить: национальность", "\
						"gbDialog"Выберите национальность Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Австралиец\n\
						"cBLUE"- "cWHITE"Албанец\n\
						"cBLUE"- "cWHITE"Американец\n\
						"cBLUE"- "cWHITE"Англичанин\n\
						"cBLUE"- "cWHITE"Армянин\n\
						"cBLUE"- "cWHITE"Бразилец\n\
						"cBLUE"- "cWHITE"Вьетнамец\n\
						"cBLUE"- "cWHITE"Голландец\n\
						"cBLUE"- "cWHITE"Еврей\n\
						"cBLUE"- "cWHITE"Испанец\n\
						"cBLUE"- "cWHITE"Итальянец\n\
						"cBLUE"- "cWHITE"Китаец\n\
						"cBLUE"- "cWHITE"Колумбиец\n\
						"cBLUE"- "cWHITE"Кореец\n\
						"cBLUE"- "cWHITE"Латиноамериканец\n\
						"cBLUE"- "cWHITE"Мексиканец\n\
						"cBLUE"- "cWHITE"Немец\n\
						"cBLUE"- "cWHITE"Поляк\n\
						"cBLUE"- "cWHITE"Португалец\n\
						"cBLUE"- "cWHITE"Русский\n\
						"cBLUE"- "cWHITE"Турок\n\
						"cBLUE"- "cWHITE"Украинец\n\
						"cBLUE"- "cWHITE"Француз\n\
						"cBLUE"- "cWHITE"Чех\n\
						"cBLUE"- "cWHITE"Японец\
					", "Выбрать", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Nation", listitem );
			
			showPlayerDialog( playerid, d_donate + 30, DIALOG_STYLE_LIST, ""cBLUE"Изменить: страну рождения", "\
					"gbDialog"Выберите страну рождения Вашего персонажа:\n\
					"cBLUE"- "cWHITE"Австралия\n\
					"cBLUE"- "cWHITE"Албания\n\
					"cBLUE"- "cWHITE"Англия\n\
					"cBLUE"- "cWHITE"Армения\n\
					"cBLUE"- "cWHITE"Бразилия\n\
					"cBLUE"- "cWHITE"Вьетнам\n\
					"cBLUE"- "cWHITE"Германия\n\
					"cBLUE"- "cWHITE"Израиль\n\
					"cBLUE"- "cWHITE"Испания\n\
					"cBLUE"- "cWHITE"Италия\n\
					"cBLUE"- "cWHITE"Китай\n\
					"cBLUE"- "cWHITE"Колумбия\n\
					"cBLUE"- "cWHITE"Корея\n\
					"cBLUE"- "cWHITE"Мексика\n\
					"cBLUE"- "cWHITE"Нидерланды\n\
					"cBLUE"- "cWHITE"Польша\n\
					"cBLUE"- "cWHITE"Португалия\n\
					"cBLUE"- "cWHITE"Россия\n\
					"cBLUE"- "cWHITE"США\n\
					"cBLUE"- "cWHITE"Турция\n\
					"cBLUE"- "cWHITE"Франция\n\
					"cBLUE"- "cWHITE"Украина\n\
					"cBLUE"- "cWHITE"Чехия\n\
					"cBLUE"- "cWHITE"Япония\
				", "Выбрать", "Назад" );
		}
		
		case d_donate + 30:
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Nation" );
				return showPlayerDialog( playerid, d_donate + 29, DIALOG_STYLE_LIST, ""cBLUE"Изменить: национальность", "\
						"gbDialog"Выберите национальность Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Австралиец\n\
						"cBLUE"- "cWHITE"Албанец\n\
						"cBLUE"- "cWHITE"Американец\n\
						"cBLUE"- "cWHITE"Англичанин\n\
						"cBLUE"- "cWHITE"Армянин\n\
						"cBLUE"- "cWHITE"Бразилец\n\
						"cBLUE"- "cWHITE"Вьетнамец\n\
						"cBLUE"- "cWHITE"Голландец\n\
						"cBLUE"- "cWHITE"Еврей\n\
						"cBLUE"- "cWHITE"Испанец\n\
						"cBLUE"- "cWHITE"Итальянец\n\
						"cBLUE"- "cWHITE"Китаец\n\
						"cBLUE"- "cWHITE"Колумбиец\n\
						"cBLUE"- "cWHITE"Кореец\n\
						"cBLUE"- "cWHITE"Латиноамериканец\n\
						"cBLUE"- "cWHITE"Мексиканец\n\
						"cBLUE"- "cWHITE"Немец\n\
						"cBLUE"- "cWHITE"Поляк\n\
						"cBLUE"- "cWHITE"Португалец\n\
						"cBLUE"- "cWHITE"Русский\n\
						"cBLUE"- "cWHITE"Турок\n\
						"cBLUE"- "cWHITE"Украинец\n\
						"cBLUE"- "cWHITE"Француз\n\
						"cBLUE"- "cWHITE"Чех\n\
						"cBLUE"- "cWHITE"Японец\
					", "Выбрать", "Назад" );
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 30, DIALOG_STYLE_LIST, ""cBLUE"Изменить: страну рождения", "\
						"gbDialog"Выберите страну рождения Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Австралия\n\
						"cBLUE"- "cWHITE"Албания\n\
						"cBLUE"- "cWHITE"Англия\n\
						"cBLUE"- "cWHITE"Армения\n\
						"cBLUE"- "cWHITE"Бразилия\n\
						"cBLUE"- "cWHITE"Вьетнам\n\
						"cBLUE"- "cWHITE"Германия\n\
						"cBLUE"- "cWHITE"Израиль\n\
						"cBLUE"- "cWHITE"Испания\n\
						"cBLUE"- "cWHITE"Италия\n\
						"cBLUE"- "cWHITE"Китай\n\
						"cBLUE"- "cWHITE"Колумбия\n\
						"cBLUE"- "cWHITE"Корея\n\
						"cBLUE"- "cWHITE"Мексика\n\
						"cBLUE"- "cWHITE"Нидерланды\n\
						"cBLUE"- "cWHITE"Польша\n\
						"cBLUE"- "cWHITE"Португалия\n\
						"cBLUE"- "cWHITE"Россия\n\
						"cBLUE"- "cWHITE"США\n\
						"cBLUE"- "cWHITE"Турция\n\
						"cBLUE"- "cWHITE"Франция\n\
						"cBLUE"- "cWHITE"Украина\n\
						"cBLUE"- "cWHITE"Чехия\n\
						"cBLUE"- "cWHITE"Япония\
					", "Выбрать", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Country", listitem );
			
			showPlayerDialog( playerid, d_donate + 31, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменить: возраст\n\n\
					"cWHITE"Укажите возраст Вашего персонажа:\n\
					"gbDialog"От 16 до 70 лет",
				"Далее", "Назад" );
		}
		
		case d_donate + 31:
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Country" );
				return showPlayerDialog( playerid, d_donate + 30, DIALOG_STYLE_LIST, ""cBLUE"Изменить: страну рождения", "\
						"gbDialog"Выберите страну рождения Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Австралия\n\
						"cBLUE"- "cWHITE"Албания\n\
						"cBLUE"- "cWHITE"Англия\n\
						"cBLUE"- "cWHITE"Армения\n\
						"cBLUE"- "cWHITE"Бразилия\n\
						"cBLUE"- "cWHITE"Вьетнам\n\
						"cBLUE"- "cWHITE"Германия\n\
						"cBLUE"- "cWHITE"Израиль\n\
						"cBLUE"- "cWHITE"Испания\n\
						"cBLUE"- "cWHITE"Италия\n\
						"cBLUE"- "cWHITE"Китай\n\
						"cBLUE"- "cWHITE"Колумбия\n\
						"cBLUE"- "cWHITE"Корея\n\
						"cBLUE"- "cWHITE"Мексика\n\
						"cBLUE"- "cWHITE"Нидерланды\n\
						"cBLUE"- "cWHITE"Польша\n\
						"cBLUE"- "cWHITE"Португалия\n\
						"cBLUE"- "cWHITE"Россия\n\
						"cBLUE"- "cWHITE"США\n\
						"cBLUE"- "cWHITE"Турция\n\
						"cBLUE"- "cWHITE"Франция\n\
						"cBLUE"- "cWHITE"Украина\n\
						"cBLUE"- "cWHITE"Чехия\n\
						"cBLUE"- "cWHITE"Япония\
					", "Выбрать", "Назад" );
			}
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 16 || strval( inputtext ) > 70 )
			{
				return showPlayerDialog( playerid, d_donate + 31, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Изменить: возраст\n\n\
						"cWHITE"Укажите возраст Вашего персонажа:\n\
						"gbDialog"От 16 до 70 лет\n\n\
						"gbDialogError"Неправильный формат ввода",
					"Далее", "Назад" );
			}
			 
			SetPVarInt( playerid, "Change:Age", strval( inputtext ) );
			
			format:g_string( ""cBLUE"Подтвердите изменение роли\n\n\
				"cWHITE"Текущая роль:\n\
				"cWHITE"пол - "cBLUE"%s,\n\
				"cWHITE"цвет кожи - "cBLUE"%s,\n\
				"cWHITE"национальность - "cBLUE"%s,\n\
				"cWHITE"страна рождения - "cBLUE"%s,\n\
				"cWHITE"возраст - "cBLUE"%d %s\n\n\
				"cWHITE"Новая роль:\n\
				"cWHITE"пол - "cBLUE"%s,\n\
				"cWHITE"цвет кожи - "cBLUE"%s,\n\
				"cWHITE"национальность - "cBLUE"%s,\n\
				"cWHITE"страна рождения - "cBLUE"%s,\n\
				"cWHITE"возраст - "cBLUE"%d %s\n\n\
				"cWHITE"Стоимость изменения роли "cBLUE"%d"cWHITE" RCoin. Продолжить?",
				GetSexName( Player[playerid][uSex] ),
				Player[playerid][uColor] == 2 ? ("Светлый") : ("Темный"),
				GetNationName( Player[playerid][uNation] ),
				GetCountryName( Player[playerid][uCountry] ),
				Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ), 
				GetSexName( GetPVarInt( playerid, "Change:Sex" ) ),
				GetPVarInt( playerid, "Change:Color" ) == 2 ? ("Светлый") : ("Темный"),
				GetNationName( GetPVarInt( playerid, "Change:Nation" ) ),
				GetCountryName( GetPVarInt( playerid, "Change:Country" ) ),
				GetPVarInt( playerid, "Change:Age" ), AgeTextEnd( GetPVarInt( playerid, "Change:Age" )%10 ),
				PRICE_CHANGE_ROLE );
				
			showPlayerDialog( playerid, d_donate + 32, DIALOG_STYLE_MSGBOX, " ", g_string, "Да", "Нет" );
		}
		
		case d_donate + 32:
		{
			if( !listitem )
			{
				DeletePVar( playerid, "Change:Sex" );
				DeletePVar( playerid, "Change:Color" );
				DeletePVar( playerid, "Change:Nation" );
				DeletePVar( playerid, "Change:Country" );
				DeletePVar( playerid, "Change:Age" );
				
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !""gbDefault"Вы отказались от изменения роли." );
			}
			
			if( Player[playerid][uGMoney] < PRICE_CHANGE_ROLE )
			{
				DeletePVar( playerid, "Change:Sex" );
				DeletePVar( playerid, "Change:Color" );
				DeletePVar( playerid, "Change:Nation" );
				DeletePVar( playerid, "Change:Country" );
				DeletePVar( playerid, "Change:Age" );
			
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= PRICE_CHANGE_ROLE;
			
			Player[playerid][uSex] = GetPVarInt( playerid, "Change:Sex" );
			Player[playerid][uColor] = GetPVarInt( playerid, "Change:Color" );
			Player[playerid][uNation] = GetPVarInt( playerid, "Change:Nation" );
			Player[playerid][uCountry] = GetPVarInt( playerid, "Change:Country" );
			Player[playerid][uAge] = GetPVarInt( playerid, "Change:Age" );
			
			DeletePVar( playerid, "Change:Sex" );
			DeletePVar( playerid, "Change:Color" );
			DeletePVar( playerid, "Change:Nation" );
			DeletePVar( playerid, "Change:Country" );
			DeletePVar( playerid, "Change:Age" );
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET \
				`uSex` = %d, `uColor` = %d, `uNation` = %d, `uCountry` = %d, `uAge` = %d, `uGMoney` = %d \
				WHERE `uID` = %d LIMIT 1", 
				Player[playerid][uSex],
				Player[playerid][uColor],
				Player[playerid][uNation],
				Player[playerid][uCountry],
				Player[playerid][uAge],
				Player[playerid][uGMoney],
				Player[playerid][uID] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Вы успешно изменили роль персонажа (%d RCoin). Приобретите одежду, подходящую для новой роли.", PRICE_CHANGE_ROLE );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 33: //Смена пола
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 33, DIALOG_STYLE_LIST, ""cBLUE"Изменить: пол", "\
						"gbDialog"Выберите пол Вашего персонажа:\n\
						"cBLUE"- "cWHITE"Мужской\n\
						"cBLUE"- "cWHITE"Женский\
					", "Выбрать", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Sex", listitem );
			ConfirmChangePlayer( playerid, 0 );
		}
		
		case d_donate + 34: //Смена цвета кожи
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 34, DIALOG_STYLE_LIST, ""cBLUE"Изменить: цвет кожи", "\
							"gbDialog"Выберите цвет кожи Вашего персонажа:\n\
							"cBLUE"- "cWHITE"Темный\n\
							"cBLUE"- "cWHITE"Светлый\
						", "Выбрать", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Color", listitem );
			ConfirmChangePlayer( playerid, 1 );
		}
		
		case d_donate + 35: //Смена национальности
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 35, DIALOG_STYLE_LIST, ""cBLUE"Изменить: национальность", "\
							"gbDialog"Выберите национальность Вашего персонажа:\n\
							"cBLUE"- "cWHITE"Австралиец\n\
							"cBLUE"- "cWHITE"Албанец\n\
							"cBLUE"- "cWHITE"Американец\n\
							"cBLUE"- "cWHITE"Англичанин\n\
							"cBLUE"- "cWHITE"Армянин\n\
							"cBLUE"- "cWHITE"Бразилец\n\
							"cBLUE"- "cWHITE"Вьетнамец\n\
							"cBLUE"- "cWHITE"Голландец\n\
							"cBLUE"- "cWHITE"Еврей\n\
							"cBLUE"- "cWHITE"Испанец\n\
							"cBLUE"- "cWHITE"Итальянец\n\
							"cBLUE"- "cWHITE"Китаец\n\
							"cBLUE"- "cWHITE"Колумбиец\n\
							"cBLUE"- "cWHITE"Кореец\n\
							"cBLUE"- "cWHITE"Латиноамериканец\n\
							"cBLUE"- "cWHITE"Мексиканец\n\
							"cBLUE"- "cWHITE"Немец\n\
							"cBLUE"- "cWHITE"Поляк\n\
							"cBLUE"- "cWHITE"Португалец\n\
							"cBLUE"- "cWHITE"Русский\n\
							"cBLUE"- "cWHITE"Турок\n\
							"cBLUE"- "cWHITE"Украинец\n\
							"cBLUE"- "cWHITE"Француз\n\
							"cBLUE"- "cWHITE"Чех\n\
							"cBLUE"- "cWHITE"Японец\
						", "Выбрать", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Nation", listitem );
			ConfirmChangePlayer( playerid, 2 );
		}
		
		case d_donate + 36: //Смена страны рождения
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 36, DIALOG_STYLE_LIST, ""cBLUE"Изменить: страну рождения", "\
							"gbDialog"Выберите страну рождения Вашего персонажа:\n\
							"cBLUE"- "cWHITE"Австралия\n\
							"cBLUE"- "cWHITE"Албания\n\
							"cBLUE"- "cWHITE"Англия\n\
							"cBLUE"- "cWHITE"Армения\n\
							"cBLUE"- "cWHITE"Бразилия\n\
							"cBLUE"- "cWHITE"Вьетнам\n\
							"cBLUE"- "cWHITE"Германия\n\
							"cBLUE"- "cWHITE"Израиль\n\
							"cBLUE"- "cWHITE"Испания\n\
							"cBLUE"- "cWHITE"Италия\n\
							"cBLUE"- "cWHITE"Китай\n\
							"cBLUE"- "cWHITE"Колумбия\n\
							"cBLUE"- "cWHITE"Корея\n\
							"cBLUE"- "cWHITE"Мексика\n\
							"cBLUE"- "cWHITE"Нидерланды\n\
							"cBLUE"- "cWHITE"Польша\n\
							"cBLUE"- "cWHITE"Португалия\n\
							"cBLUE"- "cWHITE"Россия\n\
							"cBLUE"- "cWHITE"США\n\
							"cBLUE"- "cWHITE"Турция\n\
							"cBLUE"- "cWHITE"Франция\n\
							"cBLUE"- "cWHITE"Украина\n\
							"cBLUE"- "cWHITE"Чехия\n\
							"cBLUE"- "cWHITE"Япония\
						", "Выбрать", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Country", listitem );
			ConfirmChangePlayer( playerid, 3 );
		}
		
		case d_donate + 37: //Смена возраста
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 16 || strval( inputtext ) > 70 )
			{
				return showPlayerDialog( playerid, d_donate + 37, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Изменить: возраст\n\n\
						"cWHITE"Укажите возраст Вашего персонажа:\n\
						"gbDialog"От 16 до 70 лет\n\n\
						"gbDialogError"Неправильный формат ввода",
					"Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Age", strval( inputtext ) );
			ConfirmChangePlayer( playerid, 4 );
		}
		
		case d_donate + 38: //Диалог подтверждения изменения
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Sex" );
				DeletePVar( playerid, "Change:Color" );
				DeletePVar( playerid, "Change:Nation" );
				DeletePVar( playerid, "Change:Country" );
				DeletePVar( playerid, "Change:Age" );
				DeletePVar( playerid, "Change:Price" );
				DeletePVar( playerid, "Change:Type" );
				DeletePVar( playerid, "Change:Name" );
			
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !""gbError"Вы отказались от изменения." );
			}
			
			new
				price = GetPVarInt( playerid, "Change:Price" ),
				type = GetPVarInt( playerid, "Change:Type" );
				
			if( Player[playerid][uGMoney] < price )
			{
				DeletePVar( playerid, "Change:Sex" );
				DeletePVar( playerid, "Change:Color" );
				DeletePVar( playerid, "Change:Nation" );
				DeletePVar( playerid, "Change:Country" );
				DeletePVar( playerid, "Change:Age" );
				DeletePVar( playerid, "Change:Price" );
				DeletePVar( playerid, "Change:Type" );
				DeletePVar( playerid, "Change:Name" );
			
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= price;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			switch( type )
			{
				case 0:
				{
					Player[playerid][uSex] = GetPVarInt( playerid, "Change:Sex" );
					pformat:( ""gbSuccess"Вы успешно изменили пол на "cBLUE"%s"cWHITE" (%d RCoin).", GetSexName( Player[playerid][uSex] ), price );
					UpdatePlayer( playerid, "uSex", Player[playerid][uSex] );
				}
				
				case 1:
				{
					Player[playerid][uColor] = GetPVarInt( playerid, "Change:Color" );
					pformat:( ""gbSuccess"Вы успешно изменили цвет кожи на "cBLUE"%s"cWHITE" (%d RCoin).", Player[playerid][uColor] == 2 ? ("Светлый") : ("Темный"), price );
					UpdatePlayer( playerid, "uColor", Player[playerid][uColor] );
				}
				
				case 2:
				{
					Player[playerid][uNation] = GetPVarInt( playerid, "Change:Nation" );
					pformat:( ""gbSuccess"Вы успешно изменили национальность на "cBLUE"%s"cWHITE" (%d RCoin).", GetNationName( Player[playerid][uNation] ), price );
					UpdatePlayer( playerid, "uNation", Player[playerid][uNation] );
				}
				
				case 3:
				{
					Player[playerid][uCountry] = GetPVarInt( playerid, "Change:Country" );
					pformat:( ""gbSuccess"Вы успешно изменили страну рождения на "cBLUE"%s"cWHITE" (%d RCoin).", GetCountryName( Player[playerid][uCountry] ), price );
					UpdatePlayer( playerid, "uCountry", Player[playerid][uCountry] );
				}
				
				case 4:
				{
					Player[playerid][uAge] = GetPVarInt( playerid, "Change:Age" );
					pformat:( ""gbSuccess"Вы успешно изменили возраст на "cBLUE"%d %s"cWHITE" (%d RCoin).", Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ), price );
					UpdatePlayer( playerid, "uAge", Player[playerid][uAge] );
				}
				
				case 5:
				{
					new
						name[ MAX_PLAYER_NAME ];
					GetPVarString( playerid, "Change:Name", name, MAX_PLAYER_NAME );
				
					format:g_small_string( "%s изменил никнейм на %s", Player[playerid][uName], name );
					log( LOG_CHANGE_NAME, g_small_string, Player[playerid][uID] );
				
					format:g_small_string( ""ADMIN_PREFIX" %s[%d] изменил никнейм на %s",
						Player[playerid][uName],
						playerid,
						name );
						
					SendAdmin:( C_DARKGRAY, g_small_string );
				
					SetPlayerName( playerid, name );
					
					Player[playerid][uName][0] = EOS;
					GetPlayerName( playerid, Player[playerid][uName], MAX_PLAYER_NAME );
					
					pformat:( ""gbSuccess"Вы успешно изменили никнейм на "cBLUE"%s"cWHITE" (%d RCoin).", Player[playerid][uName], price );
					UpdatePlayerString( playerid, "uName", Player[playerid][uName] );
				}	
			}
			
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Change:Sex" );
			DeletePVar( playerid, "Change:Color" );
			DeletePVar( playerid, "Change:Nation" );
			DeletePVar( playerid, "Change:Country" );
			DeletePVar( playerid, "Change:Age" );
			DeletePVar( playerid, "Change:Price" );
			DeletePVar( playerid, "Change:Type" );
			DeletePVar( playerid, "Change:Name" );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 39:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
		
			if( !CheckDonateName( inputtext ) )
			{
				return showPlayerDialog( playerid, d_donate + 39, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"Изменить: никнейм\n\n\
								"cWHITE"Укажите новые Имя и Фамилию:\n\
								"gbDialogError"Некорректный никнейм\n\n\
								Проверьте правильность написания Имени/Фамилии и попробуйте еще раз:\n\
								"cBLUE"- "cGRAY"никнейм должен состоять только из латинских букв,\n\
								"cBLUE"- "cGRAY"между Имени и Фамилии должен использоваться знак '_',\n\
								"cBLUE"- "cGRAY"никнейм не должен содержать больше 24 и меньше 6 символов,\n\
								"cBLUE"- "cGRAY"Имя и(или) Фамилия не должны содержать меньше 3 символов,\n\
								"cBLUE"- "cGRAY"Имя и Фамилия должны начинаться с заглавных букв.",
						"Далее", "Назад" );
			}
			
			SetPVarString( playerid, "Change:Name", inputtext );
			ConfirmChangePlayer( playerid, 5 );
		}
		
		case d_donate + 40:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !listitem )
			{
				return showPlayerDialog( playerid, d_donate + 40, DIALOG_STYLE_LIST, "Изучить стиль боя", "\
							"gbDialog"Выберите стиль боя:\n\
							"cBLUE"- "cWHITE"бокс\n\
							"cBLUE"- "cWHITE"кунг фу\n\
							"cBLUE"- "cWHITE"удар коленом\n\
							"cBLUE"- "cWHITE"удар ногой\n\
							"cBLUE"- "cWHITE"удар локтем", 
						"Выбрать", "Назад" );
			}
			
			if( Player[playerid][uStyle][listitem - 1] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Данный стиль боя уже изучен." );
				return showPlayerDialog( playerid, d_donate + 40, DIALOG_STYLE_LIST, "Изучить стиль боя", "\
							"gbDialog"Выберите стиль боя:\n\
							"cBLUE"- "cWHITE"бокс\n\
							"cBLUE"- "cWHITE"кунг фу\n\
							"cBLUE"- "cWHITE"удар коленом\n\
							"cBLUE"- "cWHITE"удар ногой\n\
							"cBLUE"- "cWHITE"удар локтем", 
						"Выбрать", "Назад" );
			}
			
			if( Player[playerid][uGMoney] < PRICE_STYLE )
			{
				SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
				return showPlayerDialog( playerid, d_donate + 40, DIALOG_STYLE_LIST, "Изучить стиль боя", "\
							"gbDialog"Выберите стиль боя:\n\
							"cBLUE"- "cWHITE"бокс\n\
							"cBLUE"- "cWHITE"кунг фу\n\
							"cBLUE"- "cWHITE"удар коленом\n\
							"cBLUE"- "cWHITE"удар ногой\n\
							"cBLUE"- "cWHITE"удар локтем", 
						"Выбрать", "Назад" );
			}
			
			Player[playerid][uStyle][listitem - 1] = 1;
			Player[playerid][uGMoney] -= PRICE_STYLE;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uStyle` = '%d|%d|%d|%d|%d' WHERE `uID` = %d LIMIT 1",
				Player[playerid][uStyle][0],
				Player[playerid][uStyle][1],
				Player[playerid][uStyle][2],
				Player[playerid][uStyle][3],
				Player[playerid][uStyle][4],
				Player[playerid][uID]
				);
			mysql_tquery( mysql, g_small_string );
			
			switch( listitem )
			{
				case 1: pformat:( ""gbSuccess"Вы успешно изучили стиль боя "cBLUE"Бокс"cWHITE" (%d RCoin).", PRICE_STYLE );
				case 2: pformat:( ""gbSuccess"Вы успешно изучили стиль боя "cBLUE"Кунг Фу"cWHITE" (%d RCoin).", PRICE_STYLE );
				case 3: pformat:( ""gbSuccess"Вы успешно изучили стиль боя "cBLUE"Удар коленом"cWHITE" (%d RCoin).", PRICE_STYLE );
				case 4: pformat:( ""gbSuccess"Вы успешно изучили стиль боя "cBLUE"Удар ногой"cWHITE" (%d RCoin).", PRICE_STYLE );
				case 5: pformat:( ""gbSuccess"Вы успешно изучили стиль боя "cBLUE"Удар локтем"cWHITE" (%d RCoin).", PRICE_STYLE );
			}
			
			psend:( playerid, C_WHITE );
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 41:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( Player[playerid][uGMoney] < PRICE_STYLE )
			{
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			for( new i; i < 5; i++ )
			{
				if( !Player[playerid][uStyle][i] )
					Player[playerid][uStyle][i] = 1;
			}
			
			Player[playerid][uGMoney] -= PRICE_STYLE_ALL;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uStyle` = '1|1|1|1|1' WHERE `uID` = %d LIMIT 1", Player[playerid][uID] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Вы успешно изучили все стили боя (%d RCoin).", PRICE_STYLE_ALL );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 42: //Снять предупреждение
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( Player[playerid][uGMoney] < PRICE_UNWARN )
			{
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= PRICE_UNWARN;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			Player[playerid][uWarn] --;
			UpdatePlayer( playerid, "uWarn", Player[playerid][uWarn] );
			
			pformat:( ""gbSuccess"Вы успешно сняли одно предупреждение (%d RCoin). Предупреждения: "cBLUE"%d/3", PRICE_UNWARN, Player[playerid][uWarn] );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 43: //Снять все предупреждения
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( Player[playerid][uGMoney] < PRICE_UNWARN_ALL )
			{
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= PRICE_UNWARN_ALL;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
		
			Player[playerid][uWarn] = 0;
			UpdatePlayer( playerid, "uWarn", 0 );
			
			pformat:( ""gbSuccess"Вы успешно сняли все предупреждения (%d RCoin).", PRICE_UNWARN_ALL );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 44: //Расторгнуть контракт
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( Player[playerid][uGMoney] < PRICE_UNJOB )
			{
				ShowDonatAdd( playerid );
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
			
			Player[playerid][uGMoney] -= PRICE_UNJOB;
			UpdatePlayer( playerid, "uGMoney", Player[playerid][uGMoney] );
			
			Player[ playerid ][uJob] = 
			Job[ playerid ][j_time] =
			job_duty{ playerid } = 0;
			
			UpdatePlayer( playerid, "uJob", 0 );
			UpdatePlayer( playerid, "uJobTime", 0 );
			
			pformat:( ""gbSuccess"Вы успешно расторгли шестичасовой рабочий контракт (%d RCoin).", PRICE_UNJOB );
			psend:( playerid, C_WHITE );
			
			ShowDonatAdd( playerid );
		}
		
		case d_donate + 45:
		{
			if( !response )
			{
				ShowDonatAdd( playerid );
				return 1;
			}
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 100000 || strval( inputtext ) > 999999 || strlen( inputtext ) < 6 )
			{
				return showPlayerDialog( playerid, d_donate + 45, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменить номер телефона\n\n\
					"cWHITE"Укажите желаемый номер телефона:\n\
					"gbDialog"Номер телефона должен быть 6-значным\n\n\
					"gbDialogError"Неправильный формат ввода.", "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Change:Phone", strval( inputtext ) );
			
			format:g_small_string( "\
				"cBLUE"Изменить номер телефона\n\n\
				"cWHITE"Текущий номер: "cBLUE"%d\n\
				"cWHITE"Новый номер: "cBLUE"%d\n\n\
				"cWHITE"Стоимость изменения номера телефона "cBLUE"%d"cWHITE" RCoin. Продолжить?\n\
				"gbDialog"После подтверждения последует проверка желаемого номера на существование.",
				GetPhoneNumber( playerid ),
				strval( inputtext ),
				PRICE_NUMBER_PHONE );
				
			showPlayerDialog( playerid, d_donate + 46, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		}
		
		case d_donate + 46:
		{
			if( !response )
			{
				DeletePVar( playerid, "Change:Phone" );
				return showPlayerDialog( playerid, d_donate + 45, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменить номер телефона\n\n\
					"cWHITE"Укажите желаемый номер телефона:\n\
					"gbDialog"Номер телефона должен быть 6-значным", "Далее", "Назад" );
			}
		
			new
				number = GetPVarInt( playerid, "Change:Phone" );
		
			if( Player[playerid][uGMoney] < PRICE_NUMBER_PHONE )
			{
				DeletePVar( playerid, "Change:Phone" );
				ShowDonatAdd( playerid );
				
				return SendClient:( playerid, C_WHITE, !NO_HAVE_RCOIN );
			}
		
			mysql_format:g_small_string( "SELECT * FROM `"DB_PHONES"` WHERE `p_number` = %d", number );
			mysql_tquery( mysql, g_small_string, "ChangeNumber", "dd", playerid, number );
		}
	}
	
	return 1;
}

function LoadPremiumAccount( playerid )
{
	new 
		rows = cache_get_row_count(); 
	
	if( !rows )
		return 1;
		
	Premium[playerid][prem_id] = cache_get_field_content_int( 0, "prem_id", mysql );
	Premium[playerid][prem_type] = cache_get_field_content_int( 0, "prem_type", mysql );
	Premium[playerid][prem_time] = cache_get_field_content_int( 0, "prem_time", mysql );
	Premium[playerid][prem_color] = cache_get_field_content_int( 0, "prem_color", mysql );
	Premium[playerid][prem_gmoney] = cache_get_field_content_int( 0, "prem_gmoney", mysql );
	Premium[playerid][prem_bank] = cache_get_field_content_int( 0, "prem_bank", mysql );
	Premium[playerid][prem_salary] = cache_get_field_content_int( 0, "prem_salary", mysql );
	Premium[playerid][prem_benefit] = cache_get_field_content_int( 0, "prem_benefit", mysql );
	Premium[playerid][prem_mass] = cache_get_field_content_int( 0, "prem_mass", mysql );
	Premium[playerid][prem_admins] = cache_get_field_content_int( 0, "prem_admins", mysql );
	Premium[playerid][prem_supports] = cache_get_field_content_int( 0, "prem_supports", mysql );
	Premium[playerid][prem_h_payment] = cache_get_field_content_int( 0, "prem_h_payment", mysql );
	
	Premium[playerid][prem_house] = cache_get_field_content_int( 0, "prem_house", mysql );
	Premium[playerid][prem_car] = cache_get_field_content_int( 0, "prem_car", mysql );
	Premium[playerid][prem_business] = cache_get_field_content_int( 0, "prem_business", mysql );
	
	Premium[playerid][prem_house_property] = cache_get_field_content_int( 0, "prem_house_property", mysql );
	
	Premium[playerid][prem_drop_retreature] = cache_get_field_content_int( 0, "prem_drop_retreature", mysql );
	Premium[playerid][prem_drop_tuning] = cache_get_field_content_int( 0, "prem_drop_tuning", mysql );
	Premium[playerid][prem_drop_repair] = cache_get_field_content_int( 0, "prem_drop_repair", mysql );
	Premium[playerid][prem_drop_payment] = cache_get_field_content_int( 0, "prem_drop_payment", mysql );
	
	printf( "[load] Load Premium #%d for %s[%d]", Premium[playerid][prem_type], Player[playerid][uName], playerid );
	
	if( Premium[playerid][prem_time] )
	{
		new
			day,
			Float:interval;
			
		interval = float( Premium[playerid][prem_time] - gettime() ) / 86400.0;
		day = floatround( interval, floatround_floor );
	
		pformat:( ""gbDialog"Срок действия премиум аккаунта %s%s"cGRAY" истекает через "cBLUE"%d"cGRAY" дней.", GetPremiumColor( Premium[playerid][prem_color] ), GetPremiumName( Premium[playerid][prem_type] ), day );
		psend:( playerid, C_WHITE );
	}
		
	return 1;
}

stock ShowPremiumInfo( playerid, premium ) //Информация для Стартвого, Комфортного, Оптимального
{
	clean:<g_big_string>;
	
	format:g_small_string( ""cWHITE"Премиум аккаунт%s %s\n\n", GetPremiumColor( premium_info[premium][ prem_color ][0] ), GetPremiumName( premium ) ), strcat( g_big_string, g_small_string );
	
	if( premium_info[premium][prem_gmoney][0] )
		format:g_small_string( ""cGRAY"RCoin в PayDay: "cBLUE"%d\n", premium_info[premium][prem_gmoney][0] ), strcat( g_big_string, g_small_string );
	
	if( premium_info[premium][prem_bank][0] )
		format:g_small_string( ""cGRAY"Увеличение накоплений на банковском счете на "cBLUE"0.%d %%", premium_info[premium][prem_bank][0] ), strcat( g_big_string, g_small_string );

	if( premium_info[premium][prem_salary][0] )
		format:g_small_string( "\n"cGRAY"Увеличение заработной платы на "cBLUE"%d %%", premium_info[premium][prem_salary][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_benefit][0] )
		format:g_small_string( "\n"cGRAY"Увеличение пособия по безработице на "cBLUE"%d %%", premium_info[premium][prem_benefit][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_mass][0] )
		format:g_small_string( "\n"cGRAY"Дополнительный вес: "cBLUE"%d кг.", premium_info[premium][prem_mass][0] ), strcat( g_big_string, g_small_string );
	
	if( premium_info[premium][prem_admins][0] )
		strcat( g_big_string, "\n"cGRAY"Доступ к команде "cBLUE"/admins" );
		
	if( premium_info[premium][prem_supports][0] )
		strcat( g_big_string, "\n"cGRAY"Доступ к команде "cBLUE"/supports" );
		
	if( premium_info[premium][prem_h_payment][0] )
		format:g_small_string( "\n"cGRAY"Возможность оплаты дома на "cBLUE"+%d дней", premium_info[premium][prem_h_payment][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_car][0] )
		strcat( g_big_string, "\n"cGRAY"Возможность иметь "cBLUE"2"cGRAY" транспортных средства" );
		
	if( premium_info[premium][prem_house][0] )
		strcat( g_big_string, "\n"cGRAY"Возможность иметь "cBLUE"2"cGRAY" дома" );
		
	if( premium_info[premium][prem_business][0] )
		strcat( g_big_string, "\n"cGRAY"Возможность иметь "cBLUE"2"cGRAY" бизнеса" );
		
	if( premium_info[premium][prem_house_property][0] )
		format:g_small_string( "\n"cGRAY"Увеличение стоимости продажи имущества государству на "cBLUE"%d %%", premium_info[premium][prem_house_property][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_drop_retreature][0] )
		format:g_small_string( "\n"cGRAY"Снижение цен ретекстура в управлении недвижимостью на "cBLUE"%d %%", premium_info[premium][prem_drop_retreature][0] ), strcat( g_big_string, g_small_string );
	
	if( premium_info[premium][prem_drop_tuning][0] )
		format:g_small_string( "\n"cGRAY"Снижение цен тюнинга транспорта на "cBLUE"%d %%", premium_info[premium][prem_drop_tuning][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_drop_repair][0] )
		format:g_small_string( "\n"cGRAY"Снижение цен ремонта транспорта на "cBLUE"%d %%", premium_info[premium][prem_drop_repair][0] ), strcat( g_big_string, g_small_string );
		
	if( premium_info[premium][prem_drop_payment][0] )
		format:g_small_string( "\n"cGRAY"Снижение цен коммунальных платежей/аренды дома/квартиры на "cBLUE"%d %%", premium_info[premium][prem_drop_payment][0] ), strcat( g_big_string, g_small_string );
	
	format:g_small_string( "\n\n"cWHITE"Стоимость приобретения сроком на "cBLUE"30"cWHITE" дней составляет "cBLUE"%d"cWHITE" RCoin.", premium_info[premium][prem_price] ), strcat( g_big_string, g_small_string );
	format:g_small_string( "\nНа Вашем счете - "cBLUE"%d"cWHITE" RCoin", Player[playerid][uGMoney] ), strcat( g_big_string, g_small_string );
	
	return showPlayerDialog( playerid, d_donate + 3, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Купить", "Назад" );
}

stock ShowMyPremiumInfo( playerid )
{
	clean:<g_big_string>;
	clean:<g_string>;
	
	new
		year, month, day;
	
	format:g_small_string( ""cWHITE"Мой премиум аккаунт%s %s\n", GetPremiumColor( Premium[playerid][ prem_color ] ), GetPremiumName( Premium[playerid][prem_type] ) ), strcat( g_big_string, g_small_string );
	
	gmtime( Premium[playerid][prem_time], year, month, day );	
	format:g_small_string( ""cWHITE"Срок действия премиума истекает "cBLUE"%02d.%02d.%d\n\n", day, month, year ), strcat( g_big_string, g_small_string );
	
	if( Premium[playerid][prem_gmoney] )
		format:g_small_string( ""cGRAY"RCoin в PayDay: "cBLUE"%d\n", Premium[playerid][prem_gmoney] ), strcat( g_big_string, g_small_string );
	
	if( Premium[playerid][prem_bank] )
		format:g_small_string( ""cGRAY"Увеличение накоплений на банковском счете на "cBLUE"0.%d %%", Premium[playerid][prem_bank] ), strcat( g_big_string, g_small_string );

	if( Premium[playerid][prem_salary] )
		format:g_small_string( "\n"cGRAY"Увеличение заработной платы на "cBLUE"%d %%", Premium[playerid][prem_salary] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_benefit] )
		format:g_small_string( "\n"cGRAY"Увеличение пособия по безработице на "cBLUE"%d %%", Premium[playerid][prem_benefit] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_mass] )
		format:g_small_string( "\n"cGRAY"Дополнительный вес: "cBLUE"%d кг.", Premium[playerid][prem_mass] ), strcat( g_big_string, g_small_string );
	
	if( Premium[playerid][prem_admins] )
		strcat( g_big_string, "\n"cGRAY"Доступ к команде "cBLUE"/admins" );
		
	if( Premium[playerid][prem_supports] )
		strcat( g_big_string, "\n"cGRAY"Доступ к команде "cBLUE"/supports" );
		
	if( Premium[playerid][prem_h_payment] )
		format:g_small_string( "\n"cGRAY"Возможность оплаты дома на "cBLUE"+%d дней", Premium[playerid][prem_h_payment] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_car] )
	{
		strcat( g_big_string, "\n"cGRAY"Возможность иметь "cBLUE"2"cGRAY" транспортных средства" );
		strcat( g_string, "\n\n"gbDialogError"Внимание! По окончании срока действия премиум аккаунта\n\
		второе транспортное средство автоматически продается государству по рыночной стоимости." );
	}
		
	if( Premium[playerid][prem_house] )
	{
		strcat( g_big_string, "\n"cGRAY"Возможность иметь "cBLUE"2"cGRAY" дома" );
		strcat( g_string, "\n\n"gbDialogError"Внимание! По окончании срока действия премиум аккаунта\n\
		второй дом/квартира автоматически продается государству по рыночной стоимости." );
	}
		
	if( Premium[playerid][prem_business] )
	{
		strcat( g_big_string, "\n"cGRAY"Возможность иметь "cBLUE"2"cGRAY" бизнеса" );
		strcat( g_string, "\n\n"gbDialogError"Внимание! По окончании срока действия премиум аккаунта\n\
		второй бизнес автоматически продается государству по рыночной стоимости." );
	}
		
	if( Premium[playerid][prem_house_property] )
		format:g_small_string( "\n"cGRAY"Увеличение стоимости продажи имущества государству на "cBLUE"%d %%", Premium[playerid][prem_house_property] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_drop_retreature] )
		format:g_small_string( "\n"cGRAY"Снижение цен ретекстура в управлении недвижимостью на "cBLUE"%d %%", Premium[playerid][prem_drop_retreature] ), strcat( g_big_string, g_small_string );
	
	if( Premium[playerid][prem_drop_tuning] )
		format:g_small_string( "\n"cGRAY"Снижение цен тюнинга транспорта на "cBLUE"%d %%", Premium[playerid][prem_drop_tuning] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_drop_repair] )
		format:g_small_string( "\n"cGRAY"Снижение цен ремонта транспорта на "cBLUE"%d %%", Premium[playerid][prem_drop_repair] ), strcat( g_big_string, g_small_string );
		
	if( Premium[playerid][prem_drop_payment] )
		format:g_small_string( "\n"cGRAY"Снижение цен коммунальных платежей/аренды дома/квартиры на "cBLUE"%d %%", Premium[playerid][prem_drop_payment] ), strcat( g_big_string, g_small_string );
	
	if( g_string[0] != EOS )
	{
		strcat( g_big_string, g_string );
	}
	
	return showPlayerDialog( playerid, d_donate + 25, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );
}

function AddPremium( playerid )
{
	Premium[playerid][prem_id] = cache_insert_id();
	return 1;
}

stock ShowPremiumSettings( playerid )
{
	clean:<g_big_string>;
	strcat( g_big_string, ""cWHITE"Настройка\t"cWHITE"Значение\n" );
	// -- 0
	if( TimePremium[playerid][prem_color] )
		format:g_small_string( ""cWHITE"Цвет премиума\t%sColor\n", GetPremiumColor( TimePremium[playerid][prem_color] ) ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Цвет премиума\t"cBLUE"Нет\n" );
	// -- 1	
	if( TimePremium[playerid][prem_gmoney] )
		format:g_small_string( ""cWHITE"RCoin в PayDay\t"cBLUE"%d\n", TimePremium[playerid][prem_gmoney] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"RCoin в PayDay\t"cRED"Нет\n" );
	// -- 2	
	if( TimePremium[playerid][prem_bank] )
		format:g_small_string( ""cWHITE"Процент к накоплениям на банковском счёте\t"cBLUE"0.%d %%\n", TimePremium[playerid][prem_bank] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Процент к накоплениям на банковском счёте\t"cRED"Нет\n" );
	// -- 3	
	if( TimePremium[playerid][prem_salary] )
		format:g_small_string( ""cWHITE"Процент к заработной плате\t"cBLUE"%d %%\n", TimePremium[playerid][prem_salary] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Процент к заработной плате\t"cRED"Нет\n" );
	// -- 4	
	if( TimePremium[playerid][prem_benefit] )
		format:g_small_string( ""cWHITE"Процент к пособию по безработице\t"cBLUE"%d %%\n", TimePremium[playerid][prem_benefit] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Процент к пособию по безработице\t"cRED"Нет\n" );
	// -- 5	
	if( TimePremium[playerid][prem_mass] )
		format:g_small_string( ""cWHITE"Дополнительный вес\t"cBLUE"%d кг.\n", TimePremium[playerid][prem_mass] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Дополнительный вес\t"cRED"Нет\n" );
	// -- 6 -- 7	
	format:g_small_string( ""cWHITE"Доступ к команде /admins\t%s\n", !TimePremium[playerid][prem_admins] ? (""cRED"Нет") : (""cBLUE"Да") ), strcat( g_big_string, g_small_string );
	format:g_small_string( ""cWHITE"Доступ к команде /supports\t%s\n", !TimePremium[playerid][prem_supports] ? (""cRED"Нет") : (""cBLUE"Да") ), strcat( g_big_string, g_small_string );
	// -- 8
	if( TimePremium[playerid][prem_h_payment] )
		format:g_small_string( ""cWHITE"Увеличение количества дней для оплаты дома\t"cBLUE"+ %d\n", TimePremium[playerid][prem_h_payment] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Увеличение количества дней для оплаты дома\t"cRED"Нет\n" );
	// -- 9 -- 10 -- 11	
	format:g_small_string( ""cWHITE"Возможность иметь 2 транспортных средства\t%s\n", !TimePremium[playerid][prem_car] ? (""cRED"Нет") : (""cBLUE"Да") ), strcat( g_big_string, g_small_string );
	format:g_small_string( ""cWHITE"Возможность иметь 2 дома\t%s\n", !TimePremium[playerid][prem_house] ? (""cRED"Нет") : (""cBLUE"Да") ), strcat( g_big_string, g_small_string );
	format:g_small_string( ""cWHITE"Возможность иметь 2 бизнеса\t%s\n", !TimePremium[playerid][prem_business] ? (""cRED"Нет") : (""cBLUE"Да") ), strcat( g_big_string, g_small_string );
	// -- 12
	if( TimePremium[playerid][prem_house_property] )
		format:g_small_string( ""cWHITE"Увеличение стоимости продажи имущества государству\t"cBLUE"на %d %%\n", TimePremium[playerid][prem_house_property] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Увеличение стоимости продажи имущества государству\t"cRED"Нет\n" );
	// -- 13	
	if( TimePremium[playerid][prem_drop_retreature] )
		format:g_small_string( ""cWHITE"Снижение цен ретекстура в управлении недвижимостью\t"cBLUE"на %d %%\n", TimePremium[playerid][prem_drop_retreature] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Снижение цен ретекстура в управлении недвижимостью\t"cRED"Нет\n" );
	// -- 14	
	if( TimePremium[playerid][prem_drop_tuning] )
		format:g_small_string( ""cWHITE"Снижение цен тюнинга транспорта\t"cBLUE"на %d %%\n", TimePremium[playerid][prem_drop_tuning] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Снижение цен тюнинга транспорта\t"cRED"Нет\n" );
	// -- 15	
	if( TimePremium[playerid][prem_drop_repair] )
		format:g_small_string( ""cWHITE"Снижение цен ремонта транспорта\t"cBLUE"на %d %%\n", TimePremium[playerid][prem_drop_repair] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Снижение цен ремонта транспорта\t"cRED"Нет\n" );
	// -- 16	
	if( TimePremium[playerid][prem_drop_payment] )
		format:g_small_string( ""cWHITE"Снижение цен коммунальных платежей/аренды дома\t"cBLUE"на %d %%\n", TimePremium[playerid][prem_drop_payment] ), strcat( g_big_string, g_small_string );
	else
		strcat( g_big_string, ""cWHITE"Снижение цен коммунальных платежей/аренды дома\t"cRED"Нет\n" );
	// -- 17
	//format:g_small_string( ""cWHITE"Срок действия премиума\t"cBLUE"%d дней\n", ValuePremium[playerid][value_days] ), strcat( g_big_string, g_small_string );
	// -- 18
	format:g_small_string( ""gbDialog"Купить премиум аккаунт\t"cBLUE"%d RCoin", ValuePremium[playerid][value_gmoney] ), strcat( g_big_string, g_small_string );
	
	showPlayerDialog( playerid, d_donate + 6, DIALOG_STYLE_TABLIST_HEADERS, "Настройка премиум аккаунта", g_big_string, "Выбрать", "Назад" );
}

stock ShowDonatAdd( playerid )
{
	format:g_string( donatadd, 
		PRICE_CHANGE_ROLE,
		PRICE_CHANGE_SEX,
		PRICE_CHANGE_COLOR,
		PRICE_CHANGE_NATION,
		PRICE_CHANGE_COUNTRY,
		PRICE_CHANGE_AGE,
		PRICE_CHANGE_NAME,
		PRICE_STYLE,
		PRICE_STYLE_ALL,
		PRICE_UNWARN,
		PRICE_UNWARN_ALL,
		PRICE_UNJOB,
		PRICE_NUMBER_PHONE );
		
	//PRICE_NUMBER_CAR
		
	showPlayerDialog( playerid, d_donate + 26, DIALOG_STYLE_TABLIST_HEADERS, "Дополнительные возможности", g_string, "Выбрать", "Назад" );
}

stock ConfirmChangePlayer( playerid, type )
{
	SetPVarInt( playerid, "Change:Type", type );
	switch( type )
	{
		case 0: //Пол
		{
			format:g_small_string( "\
				"cBLUE"Изменение персонажа: пол\n\n\
				"cWHITE"Текущий пол - "cBLUE"%s\n\
				"cWHITE"Новый пол - "cBLUE"%s\n\n\
				"cWHITE"Стоимость изменения "cBLUE"%d"cWHITE" RCoin. Продолжить?",
				GetSexName( Player[playerid][uSex] ),
				GetSexName( GetPVarInt( playerid, "Change:Sex" ) ),
				PRICE_CHANGE_SEX );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_SEX );
		}
		
		case 1: //Цвет кожи
		{
			format:g_small_string( "\
				"cBLUE"Изменение персонажа: цвет кожи\n\n\
				"cWHITE"Текущий цвет кожи - "cBLUE"%s\n\
				"cWHITE"Новый цвет кожи - "cBLUE"%s\n\n\
				"cWHITE"Стоимость изменения "cBLUE"%d"cWHITE" RCoin. Продолжить?",
				Player[playerid][uColor] == 2 ? ("Светлый") : ("Темный"),
				GetPVarInt( playerid, "Change:Color" ) == 2 ? ("Светлый") : ("Темный"),
				PRICE_CHANGE_COLOR );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_COLOR );
		}
		
		case 2: //Национальность
		{
			format:g_small_string( "\
				"cBLUE"Изменение персонажа: национальность\n\n\
				"cWHITE"Текущая национальность - "cBLUE"%s\n\
				"cWHITE"Новая национальность - "cBLUE"%s\n\n\
				"cWHITE"Стоимость изменения "cBLUE"%d"cWHITE" RCoin. Продолжить?",
				GetNationName( Player[playerid][uNation] ),
				GetNationName( GetPVarInt( playerid, "Change:Nation" ) ),
				PRICE_CHANGE_NATION );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_NATION );
		}
		
		case 3: //Страна рождения
		{
			format:g_small_string( "\
				"cBLUE"Изменение персонажа: страна рождения\n\n\
				"cWHITE"Текущая страна рождения - "cBLUE"%s\n\
				"cWHITE"Новая страна рождения - "cBLUE"%s\n\n\
				"cWHITE"Стоимость изменения "cBLUE"%d"cWHITE" RCoin. Продолжить?",
				GetCountryName( Player[playerid][uCountry] ),
				GetCountryName( GetPVarInt( playerid, "Change:Country" ) ),
				PRICE_CHANGE_COUNTRY );
			
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_COUNTRY );
		}
		
		case 4: //Возраст
		{
			format:g_small_string( "\
				"cBLUE"Изменение персонажа: возраст\n\n\
				"cWHITE"Текущий возраст - "cBLUE"%d %s\n\
				"cWHITE"Новый возраст - "cBLUE"%d %s\n\n\
				"cWHITE"Стоимость изменения "cBLUE"%d"cWHITE" RCoin. Продолжить?",
				Player[playerid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ),
				GetPVarInt( playerid, "Change:Age" ), AgeTextEnd( GetPVarInt( playerid, "Change:Age" )%10 ),
				PRICE_CHANGE_AGE );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_AGE );
		}
		
		case 5: //Ник
		{
			new
				name[ MAX_PLAYER_NAME ];
			GetPVarString( playerid, "Change:Name", name, MAX_PLAYER_NAME );
		
			format:g_small_string( "\
				"cBLUE"Изменение персонажа: никнейм\n\n\
				"cWHITE"Текущий ник - "cBLUE"%s\n\
				"cWHITE"Новый ник - "cBLUE"%s\n\n\
				"cWHITE"Стоимость изменения "cBLUE"%d"cWHITE" RCoin. Продолжить?",
				Player[playerid][uName],
				name,
				PRICE_CHANGE_NAME );
				
			SetPVarInt( playerid, "Change:Price", PRICE_CHANGE_NAME );
		}
	}
	
	showPlayerDialog( playerid, d_donate + 38, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
}

stock CheckDonateName( name[] )
{
	if( strlen( name ) < 6 || strlen( name ) > MAX_PLAYER_NAME )
		return STATUS_ERROR;
	
    for( new i = 0; i < strlen( name ); i++ )
    {
		// недопустимые символы в нике
		if( !( ( name[i] >= 'a' && name[i] <= 'z' ) || ( name[i] >= 'A' && name[i] <= 'Z' ) || name[i] == '_' ) )
                return STATUS_ERROR;
	}
		
	new 
		d = strfind( name, "_" );
			
	// нет _ в нике
    if( d == INVALID_PARAM ) 
		return STATUS_ERROR; 
		
	// больше одного _ в нике
    if( strfind( name, "_", false, d + 1 ) != INVALID_PARAM ) 
		return STATUS_ERROR; 
		
	new 
		pname[10];
    strmid( pname, name, 0, d, sizeof pname );
        
	new 
		surname[10];
    strmid( surname, name, d + 1, strlen( name ), sizeof surname);
		
	// неверная длина имени
    if( strlen( pname ) < 3 || strlen( surname ) < 3 ) 
		return STATUS_ERROR;
        
	// первая буква имени не заглавная
	if( !( pname[0] >= 'A' && pname[0] <= 'Z' ) )
		return STATUS_ERROR;
			
	// первая буква фамилии не заглавная
    if( !( surname[0] >= 'A' && surname[0]<='Z' ) ) 
		return STATUS_ERROR; 
			
	// неверные буквы в имени
    for( new i = 1; i < strlen( pname ); i++ )
    {
        if( !( pname[i] >= 'a' && pname[i] <= 'z' ) ) 
			return STATUS_ERROR; 
    }
		
	// неверные буквы в фамилии
    for( new i = 1; i < strlen( surname ); i++ )
    {
        if( !( surname[i] >= 'a' && surname[i] <= 'z' ) )
			return STATUS_ERROR;
	}
		
    return STATUS_OK;
}

function ChangeNumber( playerid, number )
{
	if( cache_get_row_count() )
	{
		DeletePVar( playerid, "Change:Phone" );
		return showPlayerDialog( playerid, d_donate + 45, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменить номер телефона\n\n\
					"cWHITE"Укажите желаемый номер телефона:\n\
					"gbDialog"Номер телефона должен быть 6-значным\n\n\
					"gbDialogError"Указанный номер телефона уже занят, попробуйте другой.", "Далее", "Назад" );
	}
	
	new
		oldnumber,
		item;
		
	/* - - - - - - -  Узнаем текущий номер телефона и запоминаем индекс - - - - - - - */
	for( new i; i < MAX_INVENTORY_USE; i++ ) 
	{
		new
			id = getInventoryId( UseInv[playerid][i][inv_id] );
	
		if( inventory[id][i_type] == INV_PHONE )
		{
			oldnumber = UseInv[playerid][i][inv_param_2];
			item = i;
			break;
		}	
	}
	
	/* - - - - - - -  Меняем номер телефона - - - - - - - */
	for( new i; i < MAX_PHONES; i++ )
	{
		if( Phone[playerid][i][p_number] == oldnumber )
		{
			Phone[playerid][i][p_number] = number;
			break;
		}
	}
	
	mysql_format:g_small_string( "UPDATE `"DB_PHONES"` SET `p_number` = %d WHERE `p_number` = %d AND `p_user_id` = %d LIMIT 1",
		number, oldnumber, Player[playerid][uID] );
	mysql_tquery( mysql, g_small_string );
	
	UseInv[playerid][item][inv_param_2] = number;
	
	mysql_format:g_small_string( "UPDATE `"DB_ITEMS"` SET `item_param_2` = %d WHERE `id` = %d LIMIT 1",
		number, UseInv[playerid][item][inv_bd] );
	mysql_tquery( mysql, g_small_string );
	
	/* - - - - - - - Сообщаем об успешной смене номера - - - - - - - */
	
	pformat:( ""gbSuccess"Вы успешно изменили номер телефона на "cBLUE"%d"cWHITE" (%d RCoin).", number, PRICE_NUMBER_PHONE );
	psend:( playerid, C_WHITE );
	
	DeletePVar( playerid, "Change:Phone" );
	
	ShowDonatAdd( playerid );
	
	return 1;
}