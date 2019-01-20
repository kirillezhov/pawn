function Prison_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_prison: 
		{
			if( !response ) return 1;
			
			switch( listitem ) 
			{
				// Открыть-закрыть камеры блока D
				case 0: 
				{
					if( all_block[BLOCK_D] ) 
					{
						SendClient:( playerid, C_GRAY, ""gbDefault"Вы закрыли все камеры блока 'D'." );
						movePrisonBlock( BLOCK_D, false );
					}	
					else 
					{
						SendClient:( playerid, C_GRAY, ""gbDefault"Вы открыли все камеры блока 'D'." );
						movePrisonBlock( BLOCK_D, true );
					}	
					
					format:g_string( prison_computer, 
						all_block[BLOCK_D] ? ("Закрыть"):("Открыть"),
						all_block[BLOCK_E] ? ("Закрыть"):("Открыть"),
						prison_alarm ? ("Деактивировать"):("Активировать")
					);
					showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Закрыть" );
				}
				
				// Открыть-закрыть камеры блока E
				case 1: 
				{
					if( all_block[BLOCK_E] ) 
					{
						SendClient:( playerid, C_GRAY, ""gbDefault"Вы закрыли все камеры блока 'E'." );
						movePrisonBlock( BLOCK_E, false );
					}	
					else 
					{
						SendClient:( playerid, C_GRAY, ""gbDefault"Вы открыли все камеры блока 'E'." );
						movePrisonBlock( BLOCK_E, true );
					}	
					
					format:g_string( prison_computer, 
						all_block[BLOCK_D] ? ("Закрыть"):("Открыть"),
						all_block[BLOCK_E] ? ("Закрыть"):("Открыть"),
						prison_alarm ? ("Деактивировать"):("Активировать")
						);
					showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Закрыть" );
				}
				// Управление камерами видеонаблюдения
				case 2:
				{
					showPlayerDialog( playerid, d_prison + 1, DIALOG_STYLE_LIST, "Видеонаблюдение", "\
						"cBLUE"1. "cWHITE"Видеонаблюдение за улицей\n\
						"cBLUE"2. "cWHITE"Видеонаблюдение за блоком А\n\
						"cBLUE"3. "cWHITE"Видеонаблюдение за блоком B\n\
						"cBLUE"4. "cWHITE"Видеонаблюдение за блоком C\n\
						"cBLUE"5. "cWHITE"Видеонаблюдение за блоками D,E\n\
						"cBLUE"6. "cWHITE"Видеонаблюдение за блоком F\n\
						"cBLUE"7. "cWHITE"Видеонаблюдение за подвалом", "Выбрать", "Назад" );
				}
				//База данных
				case 3:
				{
					showPlayerDialog( playerid, d_prison + 2, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"База данных\n\n\
						"cWHITE"Введите Имя и Фамилию заключенного:\n\
						"gbDialog"Пример: Vasya_Pupkin", "Далее", "Назад" );
				}
				//Тревога
				case 4:
				{
					if( prison_alarm )
					{
						prison_alarm = false;
						SendClient:( playerid, C_WHITE, !""gbDefault"Вы деактивировали сирену тревоги." );
						
						foreach(new i: Player)
						{
							if( !IsLogged(i) ) continue;
							
							if( GetPlayerVirtualWorld(i) == 23 )
							{
								PlayerPlaySound( i, 0, 0.0, 0.0, 0.0 );
							}
							else if( !GetPlayerVirtualWorld(i) && IsPlayerInDynamicArea( i, prison_zone ) )
							{
								PlayerPlaySound( i, 0, 0.0, 0.0, 0.0 );
							}
						}
					}
					else
					{
						prison_alarm = true;
						SendClient:( playerid, C_WHITE, !""gbDefault"Вы активировали сирену тревоги." );
						
						foreach(new i: Player)
						{
							if( !IsLogged(i) ) continue;
							
							if( GetPlayerVirtualWorld(i) == 23 )
							{
								PlayerPlaySound( i, 3401, 0.0, 0.0, 2.0 );
							}
							else if( !GetPlayerVirtualWorld(i) && IsPlayerInDynamicArea( i, prison_zone ) )
							{
								PlayerPlaySound( i, 3401, 0.0, 0.0, 2.0 );
							}
						}
					}
					
					format:g_string( prison_computer, 
						all_block[BLOCK_D] ? ("Закрыть"):("Открыть"),
						all_block[BLOCK_E] ? ("Закрыть"):("Открыть"),
						prison_alarm ? ("Деактивировать"):("Активировать")
						);
					showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Закрыть" );
				}
			}
		}
		
		case d_prison + 1: 
		{
			if( !response ) 
			{
				format:g_string( prison_computer, 
					all_block[BLOCK_D] ? ("Закрыть"):("Открыть"),
					all_block[BLOCK_E] ? ("Закрыть"):("Открыть"),
					prison_alarm ? ("Деактивировать"):("Активировать")
					);
					
				return showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Закрыть" );
			}
			
			switch( listitem ) 
			{
				case 0: initCCTV( playerid, 6 );
				case 1: initCCTV( playerid, 4 );
				case 2: initCCTV( playerid, 3 );
				case 3: initCCTV( playerid, 2 );
				case 4: initCCTV( playerid, 1 );
				case 5: initCCTV( playerid, 7 );
				case 6: initCCTV( playerid, 5 );
			}
			
			SendClient:( playerid, C_WHITE, !""gbDefault"Используйте "cBLUE"стрелки"cWHITE" для переключения между видеокамерами, клавишу "cBLUE"N"cWHITE" для выхода из режима просмотра." );
		}
		
		case d_prison + 2:
		{
			if( !response )
			{
				format:g_string( prison_computer, 
					all_block[BLOCK_D] ? ("Закрыть"):("Открыть"),
					all_block[BLOCK_E] ? ("Закрыть"):("Открыть"),
					prison_alarm ? ("Деактивировать"):("Активировать")
					);
					
				return showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Закрыть" );
			}
			
			if( inputtext[0] == EOS || strlen( inputtext ) > MAX_PLAYER_NAME )
			{
				return showPlayerDialog( playerid, d_prison + 2, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"База данных\n\n\
					"cWHITE"Введите Имя и Фамилию заключенного:\n\
					"gbDialog"Пример: Vasya_Pupkin\n\n\
					"gbDialogError"Неправильный формат ввода.", "Далее", "Назад" );
			}
			
			format:g_small_string( "\
				"cWHITE"Найти информацию о заключенном "cBLUE"%s"cWHITE"?", inputtext );
			showPlayerDialog( playerid, d_prison + 3, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			
			PrisonTemp[ p_name ][0] =
			PrisonTemp[ p_namearrest ][0] =
			PrisonTemp[ p_reason ][0] =
			PrisonTemp[ p_reasonudo ][0] = EOS;
			
			PrisonTemp[ p_camera ] =
			PrisonTemp[ p_uID ] =
			PrisonTemp[ p_cooler ] =
			PrisonTemp[ p_date ] =
			PrisonTemp[ p_dateexit ] =
			PrisonTemp[ p_dateudo ] = 0;
			
			mysql_format:g_small_string( "SELECT * FROM "DB_PRISON" WHERE `pName` = '%s' AND `pStatus` = 1", inputtext );
			mysql_tquery( mysql, g_small_string, "DownloadArrest" );
		}
		
		case d_prison + 3:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_prison + 2, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"База данных\n\n\
					"cWHITE"Введите Имя и Фамилию заключенного:\n\
					"gbDialog"Пример: Vasya_Pupkin", "Далее", "Назад" );
			}
			
			if( PrisonTemp[ p_name ][0] == EOS )
			{
				return showPlayerDialog( playerid, d_prison + 2, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"База данных\n\n\
					"cWHITE"Введите Имя и Фамилию заключенного:\n\
					"gbDialog"Пример: Vasya_Pupkin\n\n\
					"gbDialogError"Заключенный с таким ником не найден.", "Далее", "Назад" );
			}
			
			new
				year,
				month,
				day;
			
			clean:<g_big_string>;
			
			format:g_small_string( ""cWHITE"Заключенный "cBLUE"#%d\n\n", PrisonTemp[p_uID] );
			strcat( g_big_string, g_small_string );
			
			format:g_small_string( ""cWHITE"Имя и Фамилия: "cBLUE"%s\n", PrisonTemp[p_name] );
			strcat( g_big_string, g_small_string );
			
			gmtime( PrisonTemp[p_date], year, month, day );
			
			format:g_small_string( ""cWHITE"Дата заключения: "cBLUE"%02d.%02d.%d\n", day, month, year );
			strcat( g_big_string, g_small_string );
			
			format:g_small_string( ""cWHITE"Номер камеры: "cBLUE"%d\n", PrisonTemp[p_camera] );
			strcat( g_big_string, g_small_string );
			
			if( PrisonTemp[p_cooler] )
			{
				format:g_small_string( ""cWHITE"Номер карцера: "cBLUE"%d\n", PrisonTemp[p_cooler] );
				strcat( g_big_string, g_small_string );
			}
			
			format:g_small_string( ""cWHITE"Причина:\n"cBLUE"%s\n\n", PrisonTemp[p_reason] );
			strcat( g_big_string, g_small_string );
			
			
			format:g_small_string( ""cWHITE"Имя и Фамилия офицера: "cBLUE"%s\n", PrisonTemp[p_namearrest] );
			strcat( g_big_string, g_small_string );
			
			
			if( PrisonTemp[p_dateexit] == INVALID_PARAM )
			{
				strcat( g_big_string, ""cWHITE"Дата освобождения: пожизненно\n\n");
			}
			else
			{
				gmtime( PrisonTemp[p_dateexit], year, month, day );
				
				format:g_small_string( ""cWHITE"Дата освобождения: "cBLUE"%02d.%02d.%d\n\n", day, month, year );
				strcat( g_big_string, g_small_string );
			}
			
			if( PrisonTemp[p_dateudo] )
			{
				gmtime( PrisonTemp[p_dateudo], year, month, day );
				
				format:g_small_string( ""cWHITE"Досрочное освобождение: "cBLUE"%02d.%02d.%d\n", day, month, year );
				strcat( g_big_string, g_small_string );
				
				format:g_small_string( ""cWHITE"Причина:\n"cBLUE"%s", PrisonTemp[p_reasonudo] );
				strcat( g_big_string, g_small_string );
			}
			
			showPlayerDialog( playerid, d_prison + 4, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );
		}
		
		case d_prison + 4:
		{
			format:g_string( prison_computer, 
				all_block[BLOCK_D] ? ("Закрыть"):("Открыть"),
				all_block[BLOCK_E] ? ("Закрыть"):("Открыть"),
				prison_alarm ? ("Деактивировать"):("Активировать")
			);
					
			return showPlayerDialog( playerid, d_prison, DIALOG_STYLE_LIST, " ", g_string, "Выбрать", "Закрыть" );
		}

		
		case d_arrest: 
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Arrest:ID" ), DeletePVar( playerid, "Arrest:ar_info" ),
				DeletePVar( playerid, "Arrest:ar_date" ), DeletePVar( playerid, "Arrest:ar_cam" );
				
				g_player_interaction{playerid} = 0;
				
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					showArrestMenu( playerid );
					return 1;
				}
			
				case 1: 
				{
					showPlayerDialog( playerid, d_arrest + 1, DIALOG_STYLE_INPUT, " ", 
						"Укажите причину ареста игрока:", "Далее", "Назад" );	
				}
				
				case 2: 
				{
					showPlayerDialog( playerid, d_arrest + 2, DIALOG_STYLE_INPUT, " ", 
						"Укажите срок заключения игрока в днях:\n\
						"gbDialog"-1 для пожизненного заключения", "Далее", "Назад" );	
				}
				
				case 3: 
				{
					showPlayerDialog( playerid, d_arrest + 3, DIALOG_STYLE_INPUT, " ", 
						"Укажите номер камеры для игрока\n\
						"gbDialog"Количество камер: 27", "Далее", "Назад" );	
				}
				
				case 4: 
				{
					if( !GetPVarInt( playerid, "Arrest:ar_info" ) ||
						!GetPVarInt( playerid, "Arrest:ar_date" ) || 
						!GetPVarInt( playerid, "Arrest:ar_cam" ) ) 
					{
						SendClient:( playerid, C_WHITE, !""gbError"Не все поля заполнены." );
						showArrestMenu( playerid );
						return 1;
					}	
					
					new 
						giveplayerid = GetPVarInt( playerid, "Arrest:ID" );
					
					if( !IsLogged( giveplayerid ) || GetDistanceBetweenPlayers( playerid, giveplayerid ) > 3.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld( giveplayerid ) )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с вами." );
						
						DeletePVar( playerid, "Arrest:ID" ), DeletePVar( playerid, "Arrest:ar_info_text" ),
						DeletePVar( playerid, "Arrest:ar_info" ), DeletePVar( playerid, "Arrest:ar_date" ), 
						DeletePVar( playerid, "Arrest:ar_cam" );
						
						g_player_interaction{playerid} = 0;
						
						return 1;
					}
					
					Prison[ giveplayerid ][p_date] = gettime();
					
					if( GetPVarInt( playerid, "Arrest:ar_date" ) > INVALID_PARAM )
						Prison[ giveplayerid ][p_dateexit] = gettime() + ( GetPVarInt( playerid, "Arrest:ar_date" ) * 86400 );
					else
						Prison[ giveplayerid ][p_dateexit] = INVALID_PARAM;
					
					Prison[ giveplayerid ][p_camera] = GetPVarInt( playerid, "Arrest:ar_cam" );
					GetPVarString( playerid, "Arrest:ar_info_text", Prison[ giveplayerid ][p_reason], 128 );
					
					format( Prison[ giveplayerid ][p_namearrest], MAX_PLAYER_NAME, "%s", Player[playerid][uName] );
					
					mysql_format:g_string( "INSERT INTO `"DB_PRISON"` \
						( `puID`, `pCamera`, `pName`, `pArrestName`, `pReason`, `pDate`, `pExitDate` ) VALUES \
						( %d, %d, '%s', '%s', '%s', %d, %d )",
						Player[ giveplayerid ][uID],
						Prison[ giveplayerid ][p_camera],
						Player[ giveplayerid ][uName],
						Prison[ giveplayerid ][p_namearrest],
						Prison[ giveplayerid ][p_reason], 
						Prison[ giveplayerid ][p_date],
						Prison[ giveplayerid ][p_dateexit] );
					mysql_tquery( mysql, g_string );
					
					setPlayerPos( giveplayerid, 
						pr_camera[ Prison[ giveplayerid ][p_camera] - 1 ][0],
						pr_camera[ Prison[ giveplayerid ][p_camera] - 1 ][1],
						pr_camera[ Prison[ giveplayerid ][p_camera] - 1 ][2] );
					setPrisonWeather( playerid );
					
					pformat:( ""gbDefault"Офицер "cBLUE"%s"cWHITE" поместил Вас в федеральную тюрьму.", Player[playerid][uRPName] );
					psend:( giveplayerid, C_WHITE );
					
					pformat:( ""gbDefault"Вы поместили "cBLUE"%s"cWHITE" в федеральную тюрьму.", Player[ giveplayerid ][uRPName] );
					psend:( playerid, C_WHITE );
					
					DeletePVar( playerid, "Arrest:ID" ), DeletePVar( playerid, "Arrest:ar_info_text" ),
					DeletePVar( playerid, "Arrest:ar_info" ), DeletePVar( playerid, "Arrest:ar_date" ), 
					DeletePVar( playerid, "Arrest:ar_cam" );
					
					g_player_interaction{playerid} = 0;
				}
			}
		}
		
		case d_arrest + 1: 
		{
			if( !response ) 
			{
				showArrestMenu( playerid );
				return 1;
			}
			
			if( inputtext[0] == EOS || strlen( inputtext ) > 128 ) 
			{
				return showPlayerDialog( playerid, d_arrest + 1, DIALOG_STYLE_INPUT, " ", 
					"Укажите причину ареста игрока:\n\
					"gbDialogError"Неправильный формат ввода.", "Далее", "Назад" );	
			}
			
			SetPVarInt( playerid, "Arrest:ar_info", 1 );
			SetPVarString( playerid, "Arrest:ar_info_text", inputtext );
			
			showArrestMenu( playerid );
		}
		
		case d_arrest + 2: 
		{
			if( !response ) 
			{
				showArrestMenu( playerid );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) ) 
			{
				return showPlayerDialog( playerid, d_arrest + 2, DIALOG_STYLE_INPUT, " ", 
					"Укажите срок заключения игрока в днях:\n\
					"gbDialog"-1 для пожизненного заключения\n\n\
					"gbDialogError"Неправильный формат ввода.", "Далее", "Назад" );	
			}
			
			if( strval( inputtext ) < INVALID_PARAM || strval( inputtext ) == 0 || strval( inputtext ) > 365 )
			{
				return showPlayerDialog( playerid, d_arrest + 2, DIALOG_STYLE_INPUT, " ", 
					"Укажите срок заключения игрока в днях:\n\
					"gbDialog"-1 для пожизненного заключения\n\n\
					"gbDialogError"Количество дней должно быть от -1 до 365 ( не включая 0 ).", "Далее", "Назад" );	
			}
			
			SetPVarInt( playerid, "Arrest:ar_date", strval( inputtext ) );
			
			showArrestMenu( playerid );
		}
		
		
		case d_arrest + 3: 
		{
			if( !response ) 
			{
				showArrestMenu( playerid );
				return 1;
			}
						
			if( !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 27 ) 
			{
				return showPlayerDialog( playerid, d_arrest + 3, DIALOG_STYLE_INPUT, " ", 
					"Укажите номер камеры для игрока\n\
					"gbDialog"Количество камер: 27\n\n\
					"gbDialogError"Неправильный формат ввода.", "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Arrest:ar_cam", strval( inputtext ) );
			showArrestMenu( playerid );
		}
	}
	
	return 1;
}