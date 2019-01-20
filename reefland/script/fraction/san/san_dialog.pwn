function San_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_cnn: 
		{
			if( !response ) return 1;
			
			if( inputtext[0] == EOS )
			{
				format:g_string( "\
					"cBLUE"Подать объявление\n\n\
					"cWHITE"Текст объявления должен быть информативным и не должен содержать\n\
					нецензурных выражений. Лимит символов - "cBLUE"100"cWHITE".\n\
					"gbDefault"Стоимость объявления - $%d.\n\n\
					"gbDialogError"Поля для ввода пустое.", NETWORK_ADPRICE );
				return showPlayerDialog( playerid, d_cnn, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
			}
			
			if( strlen( inputtext ) > 100 )
			{
				format:g_string( "\
					"cBLUE"Подать объявление\n\n\
					"cWHITE"Текст объявления должен быть информативным и не должен содержать\n\
					нецензурных выражений. Лимит символов - "cBLUE"100"cWHITE".\n\
					"gbDefault"Стоимость объявления - $%d.\n\n\
					"gbDialogError"Превышен допустимый лимит символов.", NETWORK_ADPRICE );
				return showPlayerDialog( playerid, d_cnn, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
			}
			
			if( COUNT_ADVERTS >= MAX_ADVERT_INFO ) 
				return SendClient:( playerid, C_WHITE, !""gbError"Бегущая строка перегружена, попробуйте позже." );
			
			for( new i; i < MAX_ADVERT_INFO; i++ )
			{
				if( AD[i][a_text][0] == EOS )
				{
					strcat( AD[i][a_text], inputtext, 100 );
					strcat( AD[i][a_name], Player[playerid][uName], MAX_PLAYER_NAME );
					
					AD[i][a_phone] = GetPhoneNumber( playerid );
					AD[i][a_used] = false;
					
					COUNT_ADVERTS++;
					break;
				}
			}
			
			SetPlayerCash( playerid, "-", NETWORK_ADPRICE );
			NETWORK_COFFER += floatround( NETWORK_ADPRICE * 0.85 );
			
			mysql_format:g_small_string( "UPDATE `"DB_SAN"` SET `san_coffers` = %d WHERE 1", NETWORK_COFFER );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Ваше объявление отправлено на модерацию сотрудникам SAN, Вы заплатили "cBLUE"$%d"cWHITE".", NETWORK_ADPRICE );
			psend:( playerid, C_WHITE );
		}
		
		case d_cnn + 1:
		{
			if( !response ) 
			{
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			switch( listitem )
			{
				//Список объявлений
				case 0:
				{
					ShowAds( playerid );
				}
				//Прямой эфир
				case 1:
				{
					if( ETHER_STATUS != INVALID_PARAM )
					{
						if( ETHER_STATUS == playerid )
						{
							SendClient:( playerid, C_WHITE, !""gbDefault"Вы покинули прямой эфир." );
							
							Player[playerid][tEther] = false;
							
							ETHER_STATUS = INVALID_PARAM;
							
							ETHER_CALL = 
							ETHER_SMS = false;
						}
						else
						{
							pformat:( ""gbError"В эфире уже находится ведущий %s.", Player[ ETHER_STATUS ][uName] );
							psend:( playerid, C_WHITE );
						}
						
						g_player_interaction{playerid} = 0;
						return 1;
					}
				
					if( IsPlayerInAnyVehicle( playerid ) )
					{
						if( GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 488 && GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 582 )
						{
							g_player_interaction{playerid} = 0;
							return SendClient:( playerid, C_WHITE, !""gbError"Для начала эфира Вы должны находиться в специализированном транспорте." );
						}
						if( Vehicle[ GetPlayerVehicleID( playerid ) ][vehicle_member] != FRACTION_NEWS )
						{	
							g_player_interaction{playerid} = 0;
							return SendClient:( playerid, C_WHITE, !NO_VEHICLE_FRACTION );
						}
					}
					else if( !IsPlayerInDynamicArea( playerid, NETWORK_ZONE ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"Для начала эфира Вы должны находиться в студии." );
					}
					
					ETHER_STATUS = playerid;
					SendClient:( playerid, C_WHITE, !""gbDefault"Вы вышли в прямой эфир. Используйте "cBLUE"/n"cWHITE" для отправки сообщения." );
				
					Player[playerid][tEther] = true;
				}
				//Пригласить в эфир
				case 2:
				{
					if( ETHER_STATUS != playerid )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не являетесь ведущим эфира." );
					}
						
					showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Пригласить игрока в эфир\n\n\
						"cWHITE"Введите id игрока, которого хотите пригласить в эфир:",
						"Далее", "Назад" );
				}
				//Выгнать с эфира
				case 3:
				{
					if( ETHER_STATUS != playerid && !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не являетесь ведущим эфира." );
					}
					
					showPlayerDialog( playerid, d_cnn + 9, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Выгнать игрока с эфира\n\n\
						"cWHITE"Введите id игрока, которого хотите выгнать с эфира:",
						"Далее", "Назад" );
				}
				//Прием звонков
				case 4:
				{
					if( ETHER_STATUS != playerid && !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не являетесь ведущим эфира." );
					}
					
					if( ETHER_CALL )
					{
						ETHER_CALL = false;
					}
					else
					{
						ETHER_CALL = true;
					}
					
					cmd_newspanel( playerid );
				}
				//Прием смс
				case 5:
				{
					if( ETHER_STATUS != playerid && !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не являетесь ведущим эфира." );
					}
					
					if( ETHER_SMS )
					{
						ETHER_SMS = false;
					}
					else
					{
						ETHER_SMS = true;
					}
					
					cmd_newspanel( playerid );
				}
				//Стоимость объявления
				case 6:
				{
					if( !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !NO_LEADER );
					}
					
					format:g_small_string( "\
						"cBLUE"Изменить стоимость объявления\n\
						"cGRAY"Текущая стоимость: "cBLUE"$%d"cWHITE"\n\n\
						Установите новую стоимость:\n\
						"gbDefault"Диапазон от $1 до $100.", NETWORK_ADPRICE );
						
					showPlayerDialog( playerid, d_cnn + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Бюджет организации
				case 7:
				{
					if( !PlayerLeaderFraction( playerid, FRACTION_NEWS - 1 ) )
					{	
						g_player_interaction{playerid} = 0;
						return SendClient:( playerid, C_WHITE, !NO_LEADER );
					}
					
					format:g_small_string( "\
						"cBLUE"Перевод на банковский счет\n\
						"cGRAY"Доступная сумма: "cBLUE"$%d"cWHITE"\n\n\
						Укажите сумму для перевода на банковский счет:", NETWORK_COFFER );
						
					showPlayerDialog( playerid, d_cnn + 11, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
		}
		
		case d_cnn + 2:
		{
			if( !response ) return cmd_newspanel( playerid );
			
			if( AD[ g_dialog_select[playerid][listitem] ][a_used] ) 
				return SendClient:( playerid, C_WHITE, !""gbError"Это объявление уже просматривает один из сотрудников San Andreas Network." );
			
			SetPVarInt( playerid, "San:AdvertId", g_dialog_select[playerid][listitem] );
			AD[ g_dialog_select[playerid][listitem] ][a_used] = true;
			
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "Выбрать", "Назад" );
		}
		
		case d_cnn + 3:
		{
			if( !response )
			{
				AD[ GetPVarInt( playerid, "San:AdvertId" ) ][a_used] = false;
				DeletePVar( playerid, "San:AdvertId" );
				
				ShowAds( playerid );
				return 1;
			}
			
			new
				aid = GetPVarInt( playerid, "San:AdvertId" );
			
			switch(listitem) 
			{
				//Прочитать и отправить объявление
				case 0: 
				{
					format:g_small_string( "\
						"cWHITE"Текст:\n\n"cBLUE"%s\n\n\
						"cGRAY"Прислал: "cBLUE"%s"cGRAY"\n\
						"cGRAY"Телефон: "cBLUE"%d\n\n\
						"cWHITE"Отправить это объявление?", AD[aid][a_text], AD[aid][a_name], AD[aid][a_phone] );
					
					showPlayerDialog( playerid, d_cnn + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
				//Редактировать объявление
				case 1: 
				{
					format:g_small_string( "\
						"cWHITE"Текст:\n\n"cBLUE"%s\n\n\
						"cGRAY"Прислал: "cBLUE"%s"cGRAY"\n\
						"cGRAY"Телефон: "cBLUE"%d\n\n\
						"cWHITE"Введите отредактированный текст:", AD[aid][a_text], AD[aid][a_name], AD[aid][a_phone] );
					
					showPlayerDialog( playerid, d_cnn + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Да", "Назад" );
				}
				//Удалить объявление
				case 2: 
				{
					format:g_small_string( "\
						"cWHITE"Вы действительно желаете удалить объявление, отправленное "cBLUE"%s"cWHITE"?", AD[aid][a_name] );
						
					showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
			}
		}
		
		case d_cnn + 4:
		{
			if( !response ) return showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "Выбрать", "Назад" );
		
			new
				aid = GetPVarInt( playerid, "San:AdvertId" ),
				fid = Player[playerid][uMember] - 1,
				rank = getRankId( playerid, fid );
				
			foreach(new i : Player) 
			{
				if( !IsLogged(i) || !Player[i][uSettings][4] ) continue;
			
				pformat:( "Объявление: %s. Тел.: %d", AD[aid][a_text], AD[aid][a_phone] );
				psend:( i, C_GREEN );

				pformat:( "Отредактировал %s %s.", FRank[fid][rank][r_name], Player[playerid][uRPName] );
				psend:( i, C_GREEN );
			}
			
			clean:<AD[aid][a_text]>;
			clean:<AD[aid][a_name]>;
					
			AD[aid][a_used] = false;
			AD[aid][a_phone] = 0;
			
			COUNT_ADVERTS --;
			DeletePVar( playerid, "San:AdvertId" );
			
			g_player_interaction{playerid} = 0;
		}
		
		case d_cnn + 5:
		{
			if( !response ) return showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "Выбрать", "Назад" );
			
			new
				aid = GetPVarInt( playerid, "San:AdvertId" );
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"Текст:\n\n"cBLUE"%s\n\n\
					"cGRAY"Прислал: "cBLUE"%s"cGRAY"\n\
					"cGRAY"Телефон: "cBLUE"%d\n\n\
					"cWHITE"Введите отредактированный текст:\n\
					"gbDialogError"Поля для ввода пустое.", AD[aid][a_text], AD[aid][a_name], AD[aid][a_phone] );
					
				return showPlayerDialog( playerid, d_cnn + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Да", "Назад" );
			}
			
			if( strlen( inputtext ) > 100 )
			{
				format:g_small_string( "\
					"cWHITE"Текст:\n\n"cBLUE"%s\n\n\
					"cGRAY"Прислал: "cBLUE"%s"cGRAY"\n\
					"cGRAY"Телефон: "cBLUE"%d\n\n\
					"cWHITE"Введите отредактированный текст:\n\
					"gbDialogError"Превышен допустимый лимит символов.", AD[aid][a_text], AD[aid][a_name], AD[aid][a_phone] );
					
				return showPlayerDialog( playerid, d_cnn + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Да", "Назад" );
			}
			
			clean:<AD[aid][a_text]>;
			strcat( AD[aid][a_text], inputtext, 100 );
			
			SendClient:( playerid, C_WHITE, !""gbSuccess"Текст объявления успешно отредактирован." );
			showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "Выбрать", "Назад" );
		}
		
		case d_cnn + 6:
		{
			if( !response ) return showPlayerDialog( playerid, d_cnn + 3, DIALOG_STYLE_LIST, " ", dialog_advert, "Выбрать", "Назад" );
			
			new
				aid = GetPVarInt( playerid, "San:AdvertId" );
				
			pformat:( ""gbSuccess"Объявление игрока %s успешно удалено.", AD[aid][a_name] );
			psend:( playerid, C_WHITE );
				
			clean:<AD[aid][a_text]>;
			clean:<AD[aid][a_name]>;
					
			AD[aid][a_used] = false;
			AD[aid][a_phone] = 0;
			
			COUNT_ADVERTS--;
			DeletePVar( playerid, "San:AdvertId" );
			
			ShowAds( playerid );
		}
		
		case d_cnn + 7:
		{
			if( !response ) return cmd_newspanel( playerid );
			
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 0 || strval( inputtext ) > MAX_PLAYERS || !IsLogged( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Пригласить игрока в эфир\n\n\
					"cWHITE"Введите id игрока, которого хотите пригласить в эфир:\n\n\
					"gbDialogError"Неправильный формат ввода.",
					"Далее", "Назад" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Пригласить игрока в эфир\n\n\
					"cWHITE"Введите id игрока, которого хотите пригласить в эфир:\n\n\
					"gbDialogError"Вы не можете взаимодействовать с этим игроком.",
					"Далее", "Назад" );
			}
			
			if( Player[ strval( inputtext ) ][tEther] )
			{
				return showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Пригласить игрока в эфир\n\n\
					"cWHITE"Введите id игрока, которого хотите пригласить в эфир:\n\n\
					"gbDialogError"Данный игрок уже находится в эфире.",
					"Далее", "Назад" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_cnn + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Пригласить игрока в эфир\n\n\
					"cWHITE"Введите id игрока, которого хотите пригласить в эфир:\n\n\
					"gbDialogError"Данного игрока нет рядом с Вами.",
					"Далее", "Назад" );
			}
			
			pformat:( ""gbSuccess"Вы отправили приглашение %s в эфир, ожидайте подтверждения.", Player[ strval( inputtext ) ][uName] );
			psend:( playerid, C_WHITE );
			
			format:g_small_string( "\
				"cBLUE"%s"cWHITE" приглашает Вас на участие в эфире. Вы согласны?", Player[playerid][uRPName] );
			
			showPlayerDialog( strval( inputtext ), d_cnn + 8, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );	
			g_player_interaction{ strval( inputtext ) } = 1;		
				
			cmd_newspanel( playerid );
		}
		
		case d_cnn + 8:
		{
			if( !response )
			{
				if( IsLogged( ETHER_STATUS ) && ETHER_STATUS != INVALID_PARAM )
				{
					pformat:( ""gbError"%s отказался от участия в эфире.", Player[playerid][uName] );
					psend:( ETHER_STATUS, C_WHITE );
				}
			
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы отказались от участия в эфире." );
			
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			if( IsLogged( ETHER_STATUS ) && ETHER_STATUS != INVALID_PARAM )
			{
				pformat:( "[ Эфир %s] %s присоединился к эфиру.", Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName] );
				psend:( ETHER_STATUS, C_LIGHTGREEN );
			}
			
			SendClient:( playerid, C_WHITE, !""gbDefault"Вы присоединились к эфиру. Используйте "cBLUE"/n"cWHITE" для отправки сообщения в эфир." );
			
			Player[playerid][tEther] = true;
			g_player_interaction{playerid} = 0;
		}
		
		case d_cnn + 9:
		{
			if( !response ) return cmd_newspanel( playerid );
		
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 0 || strval( inputtext ) > MAX_PLAYERS || !IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) )
			{
				return showPlayerDialog( playerid, d_cnn + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Выгнать игрока с эфира\n\n\
					"cWHITE"Введите id игрока, которого хотите выгнать с эфира:\n\n\
					"gbDialogError"Неправильный формат ввода.",
					"Далее", "Назад" );
			}
			
			if( !Player[ strval( inputtext ) ][tEther] )
			{
				return showPlayerDialog( playerid, d_cnn + 9, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Выгнать игрока с эфира\n\n\
					"cWHITE"Введите id игрока, которого хотите выгнать с эфира:\n\n\
					"gbDialogError"Данный игрок не находится в эфире.",
					"Далее", "Назад" );
			}
			
			if( strval( inputtext ) == ETHER_STATUS )
			{
				ETHER_STATUS = INVALID_PARAM;
				
				ETHER_CALL = 
				ETHER_SMS = false;
				
				pformat:( ""gbDialog"Вы отключили ведущего %s от эфира.", Player[ strval( inputtext ) ][uName] );
			}
			else
				pformat:( ""gbDialog"Вы отключили %s от эфира.", Player[ strval( inputtext ) ][uName] );
			
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbDefault"Вы были отключены от эфира игроком %s.", Player[playerid][uName] );
			psend:( strval( inputtext ), C_WHITE );
			
			Player[ strval( inputtext ) ][tEther] = false;
			cmd_newspanel( playerid );
		}
		
		case d_cnn + 10:
		{
			if( !response ) return cmd_newspanel( playerid );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 100 )
			{
				format:g_small_string( "\
					"cBLUE"Изменить стоимость объявления\n\
					"cGRAY"Текущая стоимость: "cBLUE"$%d"cWHITE"\n\n\
					Установите новую стоимость:\n\
					"gbDefault"Диапазон от $1 до $100.\n\n\
					"gbDialogError"Неправильный формат ввода.", NETWORK_ADPRICE );
						
				return showPlayerDialog( playerid, d_cnn + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}

			if( strval( inputtext ) == NETWORK_ADPRICE )
			{
				format:g_small_string( "\
					"cBLUE"Изменить стоимость объявления\n\
					"cGRAY"Текущая стоимость: "cBLUE"$%d"cWHITE"\n\n\
					Установите новую стоимость:\n\
					"gbDefault"Диапазон от $1 до $100.\n\n\
					"gbDialogError"Указанная стоимость совпадает с текущей.", NETWORK_ADPRICE );
						
				return showPlayerDialog( playerid, d_cnn + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			NETWORK_ADPRICE = strval( inputtext );
			
			mysql_format:g_small_string( "UPDATE `"DB_SAN"` SET `san_adprice` = %d WHERE 1", NETWORK_ADPRICE );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Стоимость объявления изменена на "cBLUE"$%d"cWHITE".", NETWORK_ADPRICE );
			psend:( playerid, C_WHITE );
			
			cmd_newspanel( playerid );
		}
		
		case d_cnn + 11:
		{
			if( !response ) return cmd_newspanel( playerid );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > NETWORK_COFFER )
			{
				format:g_small_string( "\
					"cBLUE"Перевод на банковский счет\n\
					"cGRAY"Доступная сумма: "cBLUE"$%d"cWHITE"\n\n\
					Укажите сумму для перевода на банковский счет:\n\n\
					"gbDialogError"Неправильный формат ввода.", NETWORK_COFFER );
					
				return showPlayerDialog( playerid, d_cnn + 11, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			NETWORK_COFFER -= strval( inputtext );
			SetPlayerBank( playerid, "+", strval( inputtext ) );
			
			mysql_format:g_small_string( "UPDATE `"DB_SAN"` SET `san_coffers` = %d WHERE 1", NETWORK_COFFER );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Вы перевели на банковский счет "cBLUE"$%d"cWHITE".", strval( inputtext ) );
			psend:( playerid, C_WHITE );
	
			cmd_newspanel( playerid );
		}
	}
	
	return 1;
}