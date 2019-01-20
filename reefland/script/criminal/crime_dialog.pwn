function Crime_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	switch( dialogid )
	{
		case d_crime :
		{
			if( !response ) return 1;
			
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
			
			switch( listitem )
			{
				case 0: //Состав организации
				{
					ShowCrimeMembers( playerid, d_crime + 1, "Назад", "" );
				}
				case 1: //Список рангов
				{
					ShowCrimeRanks( playerid, crime, d_crime + 2 );
				}
				case 2: //Транспорт
				{
					showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
				}
				case 3: //Отметить координаты дилера
				{
					if( CrimeFraction[crime][c_index_dealer] != INVALID_PARAM )
					{
						if( CrimeFraction[crime][c_time_dealer] )
						{
							SendClient:( playerid, C_WHITE, !""gbError"Дилер еще не прибыл на обозначенное место." );
					
							format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
							return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "Выбрать", "Закрыть" );
						}
						
						new
							dealer = CrimeFraction[crime][c_index_dealer];
							
						SetPlayerCheckpoint( playerid, GunDealer[dealer][g_actor_pos][0], GunDealer[dealer][g_actor_pos][1], GunDealer[dealer][g_actor_pos][2], 3.0 );
						
						g_player_gps{playerid} = 1;
						return SendClient:( playerid, C_WHITE, ""gbDefault"Вы установили метку на GPS-навигаторе. Для отмены используйте - "cBLUE"/gps"cWHITE"");
					}
					
					SendClient:( playerid, C_WHITE, !""gbError"В ближайшее время дилера не ожидается." );
					
					format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
					return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "Выбрать", "Закрыть" );
				}
			}
		}
		
		case d_crime + 1:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
		
			format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
			showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "Выбрать", "Закрыть" );
		}
		
		case d_crime + 2:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
		
			if( !response )
			{
				format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
				return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "Выбрать", "Закрыть" );
			}
			
			if( !PlayerLeaderCrime( playerid, crime ) )
			{
				SendClient:( playerid, C_WHITE, !NO_ACCESS );
						
				ShowCrimeRanks( playerid, crime, d_crime + 2 );
				return 1;
			}
			
			if( !listitem )
			{
				format:g_small_string( "\
					"cWHITE"Добавление ранга для\n"cBLUE"%s\n\n\
					"cWHITE"Введите название для нового ранга:", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			else
			{
				new
					rank = g_dialog_select[playerid][listitem - 1];
				
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				ShowCrimeRankSettings( playerid, crime, rank );
			
				SetPVarInt( playerid, "Crime:Rank", rank );
			}
		}
		
		case d_crime + 3:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				bool:flag = false;
		
			if( !response )
			{
				ShowCrimeRanks( playerid, crime, d_crime + 2 );
				return 1;
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"Добавление ранга для\n"cBLUE"%s\n\n\
					"cWHITE"Введите название для нового ранга:\n\
					"gbDialogError"Неправильный формат ввода.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				format:g_small_string( "\
					"cWHITE"Добавление ранга для\n"cBLUE"%s\n\n\
					"cWHITE"Введите название для нового ранга:\n\
					"gbDialogError"Превышен допустимый лимит символов.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < MAX_RANKS; i++ )
			{
				if( !CrimeRank[crime][i][r_id] )
				{
					flag = true;
					
					clean:<CrimeRank[crime][i][r_name]>;
					strcat( CrimeRank[crime][i][r_name], inputtext, 32 );
					
					CreateCrimeRank( i, crime );
					
					pformat:( ""gbSuccess"Вы добавили ранг "cBLUE"%s"cWHITE". Настройте его.", CrimeRank[crime][i][r_name] );
					psend:( playerid, C_WHITE );
					
					CrimeFraction[crime][c_ranks]++;
					
					break;
				}
			}
			
			if( !flag ) 
			{
				SendClient:( playerid, C_WHITE, ""gbError"Превышен количественный лимит рангов для этой организации." );
				
				format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
				return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "Выбрать", "Закрыть" );
			}
			
			ShowCrimeRanks( playerid, crime, d_crime + 2 );
		}
		
		case d_crime + 4:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:Rank" );
				ShowCrimeRanks( playerid, crime, d_crime + 2 );
				return 1;
			}
			
			switch( listitem )
			{
				//Название
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"Изменение ранга "cBLUE"%s\n\n\
						"cWHITE"Введите новое название для ранга:", CrimeRank[crime][rank][r_name] );
					
					showPlayerDialog( playerid, d_crime + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Инвайт
				case 1:
				{
					if( !CrimeRank[crime][rank][r_invite] )
					{
						CrimeRank[crime][rank][r_invite] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_invite] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_invite", CrimeRank[crime][rank][r_invite] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//Анинвайт
				case 2:
				{
					if( !CrimeRank[crime][rank][r_uninvite] )
					{
						CrimeRank[crime][rank][r_uninvite] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_uninvite] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_uninvite", CrimeRank[crime][rank][r_uninvite] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//Аттачи
				case 3:
				{
					if( !CrimeRank[crime][rank][r_attach] )
					{
						CrimeRank[crime][rank][r_attach] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_attach] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_attach", CrimeRank[crime][rank][r_attach] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//Спавн транспорта
				case 4:
				{
					if( !CrimeRank[crime][rank][r_spawnveh] )
					{
						CrimeRank[crime][rank][r_spawnveh] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_spawnveh] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_spawnveh", CrimeRank[crime][rank][r_spawnveh] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//Звонки гандилеру
				case 5:
				{
					if( !CrimeRank[crime][rank][r_call_weapon] )
					{
						CrimeRank[crime][rank][r_call_weapon] = 1;
					}
					else
					{
						CrimeRank[crime][rank][r_call_weapon] = 0;
					}
					
					UpdateCrimeRank( CrimeRank[crime][rank][r_id], "r_call_weapon", CrimeRank[crime][rank][r_call_weapon] );
					ShowCrimeRankSettings( playerid, crime, rank );
				}
				//Транспорт
				case 6:
				{
					ShowCrimeVehicles( playerid, crime, rank );
				}
				//Спавн
				case 7:
				{
					format:g_small_string( "\
						"cWHITE"Установка спавна для "cBLUE"%s\n\n\
						"cWHITE"Вы действительно желаете установить спавн в этом месте?\n\n\
						"gbDialog""cRED"Внимание! "cGRAY"Координаты определяются позицией игрока.", CrimeRank[crime][rank][r_name] );
						
					showPlayerDialog( playerid, d_crime + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
				//Установить ранг игроку
				case 8:
				{
					format:g_small_string( "\
						"cWHITE"Установить ранг "cBLUE"%s\n\n\
						"cWHITE"Введите ID игрока, которому желаете установить ранг:", CrimeRank[crime][rank][r_name] );
				
					showPlayerDialog( playerid, d_crime + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Удалить ранг
				case 9:
				{
					if( !GetAccessAdmin( playerid, 5 ) )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Для удаления ранга обратитесь к администратору." );
						
						ShowCrimeRankSettings( playerid, crime, rank );
						return 1;
					}
				
					format:g_small_string( "\
						"cWHITE"Удаление ранга "cBLUE"%s\n\n\
						"cWHITE"Вы действительно желаете удалить ранг?", CrimeRank[crime][rank][r_name] );
				
					showPlayerDialog( playerid, d_crime + 11, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
			}
		}
		
		case d_crime + 5:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"Изменение ранга "cBLUE"%s\n\n\
					"cWHITE"Введите новое название для ранга:\n\
					"gbDialogError"Неправильный формат ввода.", CrimeRank[crime][rank][r_name] );
					
				return showPlayerDialog( playerid, d_crime + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				format:g_small_string( "\
					"cWHITE"Изменение ранга "cBLUE"%s\n\n\
					"cWHITE"Введите новое название для ранга:\n\
					"gbDialogError"Превышен допустимый лимит символов.", CrimeRank[crime][rank][r_name] );
					
				return showPlayerDialog( playerid, d_crime + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			clean:<CrimeRank[crime][rank][r_name]>;
			strcat( CrimeRank[crime][rank][r_name], inputtext, 32 );
			
			mysql_format:g_string( "UPDATE `"DB_CRIME_RANKS"` SET `r_name` = '%e' WHERE `r_id` = %d",
				CrimeRank[crime][rank][r_name],
				CrimeRank[crime][rank][r_id]
			);
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"Вы изменили название ранга на "cBLUE"%s"cWHITE".", CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowCrimeRankSettings( playerid, crime, rank );
		}
		
		case d_crime + 6:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
			
			if( !listitem )
			{
				format:g_small_string( "\
					"cWHITE"Добавление доступного транспорта для "cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:", CrimeRank[crime][rank][r_name] );
				
				showPlayerDialog( playerid, d_crime + 7, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			else
			{
				new
					index = g_dialog_select[playerid][listitem - 1];
			
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				SetPVarInt( playerid, "Crime:Vehicle", index );
			
				format:g_small_string( "\
					"cWHITE"Удаление транспорта для "cBLUE"%s\n\n\
					"cWHITE"Вы действительно желаете убрать из доступа "cBLUE"%s"cWHITE"?", CrimeRank[crime][rank][r_name], GetVehicleModelName( CrimeRank[crime][rank][r_vehicles][index] ) );
					
				showPlayerDialog( playerid, d_crime + 8, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
		}
		
		case d_crime + 7:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" ),
				bool:flag = false;
		
			if( !response )
			{
				ShowCrimeVehicles( playerid, crime, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 400 || strval( inputtext ) > 611 )
			{
				format:g_small_string( "\
					"cWHITE"Добавление доступного транспорта для "cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:\n\n\
					"gbDialogError"Неправильный формат ввода.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 7, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new j; j < 30; j++ )
			{
				if( !crime_vehicles[ CrimeFraction[crime][c_type] ][j] ) continue;
				
				if( crime_vehicles[ CrimeFraction[crime][c_type] ][j] == strval( inputtext ) )
				{
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				format:g_small_string( "\
					"cWHITE"Добавление доступного транспорта для "cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:\n\n\
					"gbDialogError"Данный транспорт недоступен для вашей организации.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 7, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			flag = false;
			
			for( new i; i < 10; i++ )
			{
				if( !CrimeRank[crime][rank][r_vehicles][i] )
				{
					CrimeRank[crime][rank][r_vehicles][i] = strval( inputtext );
					flag = true;
					
					mysql_format:g_string( "UPDATE `"DB_CRIME_RANKS"` SET `r_vehicles` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
						CrimeRank[crime][rank][r_vehicles][0],
						CrimeRank[crime][rank][r_vehicles][1],
						CrimeRank[crime][rank][r_vehicles][2],
						CrimeRank[crime][rank][r_vehicles][3],
						CrimeRank[crime][rank][r_vehicles][4],
						CrimeRank[crime][rank][r_vehicles][5],
						CrimeRank[crime][rank][r_vehicles][6],
						CrimeRank[crime][rank][r_vehicles][7],
						CrimeRank[crime][rank][r_vehicles][8],
						CrimeRank[crime][rank][r_vehicles][9],
						CrimeRank[crime][rank][r_id]
					);
					
					mysql_tquery( mysql, g_string );
					break;
				}
			}
			
			if( !flag )
			{
				format:g_small_string( "\
					"cWHITE"Добавление доступного транспорта для "cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:\n\n\
					"gbDialogError"Количественный лимит для ранга превышен.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 7, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			pformat:( ""gbSuccess"Транспорт "cBLUE"%s"cWHITE" доступен для ранга "cBLUE"%s"cWHITE".", GetVehicleModelName( strval( inputtext ) ), CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowCrimeVehicles( playerid, crime, rank );
		}
		
		case d_crime + 8:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" ),
				index = GetPVarInt( playerid, "Crime:Vehicle" );
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:Vehicle" );
			
				ShowCrimeVehicles( playerid, crime, rank );
				return 1;
			}
			
			CrimeRank[crime][rank][r_vehicles][index] = 0;
			
			mysql_format:g_string( "UPDATE `"DB_CRIME_RANKS"` SET `r_vehicles` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
				CrimeRank[crime][rank][r_vehicles][0],
				CrimeRank[crime][rank][r_vehicles][1],
				CrimeRank[crime][rank][r_vehicles][2],
				CrimeRank[crime][rank][r_vehicles][3],
				CrimeRank[crime][rank][r_vehicles][4],
				CrimeRank[crime][rank][r_vehicles][5],
				CrimeRank[crime][rank][r_vehicles][6],
				CrimeRank[crime][rank][r_vehicles][7],
				CrimeRank[crime][rank][r_vehicles][8],
				CrimeRank[crime][rank][r_vehicles][9],
				CrimeRank[crime][rank][r_id]
			);
					
			mysql_tquery( mysql, g_string );
			
			DeletePVar( playerid, "Crime:Vehicle" );
			ShowFractionVehicles( playerid, crime, rank );
		}
		
		case d_crime + 9:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
			
			GetPlayerPos( playerid, CrimeRank[crime][rank][r_spawn][0], CrimeRank[crime][rank][r_spawn][1], CrimeRank[crime][rank][r_spawn][2] );
			GetPlayerFacingAngle( playerid, CrimeRank[crime][rank][r_spawn][3] );
			
			CrimeRank[crime][rank][r_world][0] = GetPlayerVirtualWorld( playerid );
			CrimeRank[crime][rank][r_world][1] = GetPlayerInterior( playerid );
			
			mysql_format:g_string( "UPDATE `"DB_CRIME_RANKS"` SET `r_spawn` = '%f|%f|%f|%f', `r_world` = '%d|%d' WHERE `r_id` = %d",
				CrimeRank[crime][rank][r_spawn][0],
				CrimeRank[crime][rank][r_spawn][1],
				CrimeRank[crime][rank][r_spawn][2],
				CrimeRank[crime][rank][r_spawn][3],
				CrimeRank[crime][rank][r_world][0],
				CrimeRank[crime][rank][r_world][1],
				CrimeRank[crime][rank][r_id]
			);
					
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"Вы установили спавн для ранга "cBLUE"%s"cWHITE".", CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowCrimeRankSettings( playerid, crime, rank );
		}
		
		case d_crime + 10:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || !IsLogged( strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"Установить ранг "cBLUE"%s\n\n\
					"cWHITE"Введите ID игрока, которому желаете установить ранг:\n\n\
					"gbDialogError"Некорректный ID игрока.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[strval( inputtext )][uCrimeM] != Player[playerid][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"Установить ранг "cBLUE"%s\n\n\
					"cWHITE"Введите ID игрока, которому желаете установить ранг:\n\n\
					"gbDialogError"Игрок не состоит в Вашей криминальной организации.", CrimeRank[crime][rank][r_name] );
				
				return showPlayerDialog( playerid, d_crime + 10, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( CMember[crime][i][m_id] == Player[strval( inputtext )][uID] )
				{
					CMember[crime][i][m_rank] = rank + 1;
					
					clean:<CMember[crime][i][m_name]>;
					strcat( CMember[crime][i][m_name], Player[strval( inputtext )][uName], 32 );
					
					break;
				}				
			}
			
			Player[strval( inputtext )][uCrimeRank] = CrimeRank[crime][rank][r_id];
			UpdatePlayer( strval( inputtext ), "uCrimeRank", CrimeRank[crime][rank][r_id] );
			
			pformat:( ""gbSuccess"Вы установили игроку "cBLUE"%s"cWHITE" ранг "cBLUE"%s"cWHITE".", Player[strval( inputtext )][uName], CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"%s установил Вам ранг "cBLUE"%s"cWHITE".", Player[playerid][uName], CrimeRank[crime][rank][r_name] );
			psend:( strval( inputtext ), C_WHITE );
			
			ShowCrimeRankSettings( playerid, crime, rank );
		}
		
		case d_crime + 11:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank = GetPVarInt( playerid, "Crime:Rank" );
		
			if( !response )
			{
				ShowCrimeRankSettings( playerid, crime, rank );
				return 1;
			}
		
			mysql_format:g_small_string( "DELETE FROM `"DB_CRIME_RANKS"` WHERE `r_id` = %d LIMIT 1", CrimeRank[crime][rank][r_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeRank` = 0 WHERE `uCrimeRank` = %d AND `uCrimeM` = %d",
				CrimeRank[crime][rank][r_id],
				CrimeFraction[crime][c_id] );
			mysql_tquery( mysql, g_string );
			
			foreach(new i : Player)
			{
				if( Player[i][uCrimeM] == CrimeFraction[crime][c_id] && Player[i][uCrimeRank] == CrimeRank[crime][rank][r_id] )
					Player[i][uCrimeRank] = 0;
			}
			
			CrimeFraction[crime][c_ranks]--;
			
			pformat:( ""gbSuccess"Ранг "cBLUE"%s"cWHITE" успешно удален.", CrimeRank[crime][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ClearDataCrimeRank( crime, rank );	

			DeletePVar( playerid, "Crime:Rank" );
			ShowCrimeRanks( playerid, crime, d_crime + 2 );
		}
		
		case d_crime + 12:
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				DeletePVar( playerid, "Crime:PlayerID" );
				return 1;
			}
			
			new
				id = GetPVarInt( playerid, "Crime:PlayerID" ),
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank;
			
			if( !listitem )
			{
				for( new i; i < MAX_MEMBERS; i++ )
				{
					if( CMember[crime][i][m_id] == Player[id][uID] )
					{
						CMember[crime][i][m_rank] = 0;
						
						clean:<CMember[crime][i][m_name]>;
						strcat( CMember[crime][i][m_name], Player[id][uName], 32 );
						
						break;
					}				
				}
				
				Player[id][uCrimeRank] = 0;
				UpdatePlayer( id, "uCrimeRank", Player[id][uCrimeRank] );
				
				pformat:( ""gbSuccess"Вы удалили ранг игрока "cBLUE"%s"cWHITE".", Player[id][uName] );
				psend:( playerid, C_WHITE );
				
				pformat:( ""gbSuccess"%s удалил Вам ранг.", Player[playerid][uName] );
				psend:( id, C_WHITE );
			}
			else
			{
				rank = g_dialog_select[playerid][listitem - 1];
				
				for( new i; i < MAX_MEMBERS; i++ )
				{
					if( CMember[crime][i][m_id] == Player[id][uID] )
					{
						CMember[crime][i][m_rank] = rank + 1;
						
						clean:<CMember[crime][i][m_name]>;
						strcat( CMember[crime][i][m_name], Player[id][uName], 32 );
						
						break;
					}				
				}
				
				Player[id][uCrimeRank] = CrimeRank[crime][rank][r_id];
				UpdatePlayer( id, "uCrimeRank", Player[id][uCrimeRank] );
				
				pformat:( ""gbSuccess"Вы установили игроку "cBLUE"%s[%d]"cWHITE" ранг "cBLUE"%s"cWHITE".", Player[id][uName], id, CrimeRank[crime][rank][r_name] );
				psend:( playerid, C_WHITE );
				
				pformat:( ""gbSuccess"%s[%d] установил Вам ранг "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, CrimeRank[crime][rank][r_name] );
				psend:( id, C_WHITE );
			}
			
			g_player_interaction{playerid} = 0;
			DeletePVar( playerid, "Crime:PlayerID" );
		}
		
		case d_crime + 13:
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				DeletePVar( playerid, "Crime:PlayerID" );
				return 1;
			}
			
			new
				sendid = GetPVarInt( playerid, "Crime:PlayerID" ),
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				rank;
			
			if( !listitem )
			{
				SetPVarInt( sendid, "Crime:RankID", INVALID_PARAM );
			
				pformat:( ""gbDefault"Вы отправили предложение "cBLUE"%s[%d]"cWHITE" о вступлении в "cBLUE"%s"cWHITE".", Player[sendid][uName], sendid, CrimeFraction[crime][c_name] );
				psend:( playerid, C_WHITE );
			
				format:g_small_string( "\
					"gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" предлагает Вам\n\
					вступить в "cBLUE"%s"cWHITE". Вы согласны?", Player[playerid][uName], playerid, CrimeFraction[crime][c_name] );
					
				showPlayerDialog( sendid, d_crime + 14, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else
			{
				rank = g_dialog_select[playerid][listitem - 1];
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				
				SetPVarInt( sendid, "Crime:RankID", rank );
			
				pformat:( ""gbDefault"Вы отправили предложение "cBLUE"%s[%d]"cWHITE" о вступлении с рангом "cBLUE"%s"cWHITE".", Player[sendid][uName], sendid, CrimeRank[crime][rank][r_name] );
				psend:( playerid, C_WHITE );
			
				format:g_small_string( "\
					"gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" предлагает Вам\n\
					вступить в "cBLUE"%s"cWHITE" c рангом "cBLUE"%s"cWHITE". Вы согласны?", 
					Player[playerid][uName], 
					playerid, 
					CrimeFraction[crime][c_name],
					CrimeRank[crime][rank][r_name] );
					
				showPlayerDialog( sendid, d_crime + 14, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			
			SetPVarInt( sendid, "Crime:PlayerID", playerid );
			SetPVarInt( sendid, "Crime:ID", crime );
			
			g_player_interaction{sendid} = 1;
		}
		
		case d_crime + 14:
		{
			new
				leaderid = GetPVarInt( playerid, "Crime:PlayerID" ),
				crime = GetPVarInt( playerid, "Crime:ID" ),
				rank = GetPVarInt( playerid, "Crime:RankID" ),
				member = INVALID_PARAM;
		
			if( !response )
			{
				pformat:( ""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от вступления в "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, CrimeFraction[crime][c_name] );
				psend:( leaderid, C_WHITE );
				
				pformat:( ""gbError"Вы отказались от вступления в "cBLUE"%s"cWHITE".", CrimeFraction[crime][c_name] );
				psend:( playerid, C_WHITE );
				
				g_player_interaction{leaderid} =
				g_player_interaction{playerid} = 0;
				
				DeletePVar( playerid, "Crime:PlayerID" );
				DeletePVar( leaderid, "Crime:PlayerID" );
				
				DeletePVar( playerid, "Crime:ID" );
				DeletePVar( playerid, "Crime:RankID" );
				
				return 1;
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( !CMember[crime][i][m_id] )
				{
					member = i;
					break;
				}
			}
			
			if( member == INVALID_PARAM )
			{
				pformat:( ""gbError"Игрок "cBLUE"%s[%d]"cWHITE" не может вступить в "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, CrimeFraction[crime][c_name] );
				psend:( leaderid, C_WHITE );
				
				pformat:( ""gbError"Вы не можете вступить в "cBLUE"%s"cWHITE".", CrimeFraction[crime][c_name] );
				psend:( playerid, C_WHITE );
				
				g_player_interaction{leaderid} =
				g_player_interaction{playerid} = 0;
				
				DeletePVar( playerid, "Crime:PlayerID" );
				DeletePVar( leaderid, "Crime:PlayerID" );
				
				DeletePVar( playerid, "Crime:ID" );
				DeletePVar( playerid, "Crime:RankID" );
				
				return 1;
			}
			
			CMember[crime][member][m_id] = Player[playerid][uID];
			
			clean:<CMember[crime][member][m_name]>;
			strcat( CMember[crime][member][m_name], Player[playerid][uName], 32 );
			
			CMember[crime][member][m_lasttime] = Player[playerid][uLastTime];
			
			CrimeFraction[crime][c_members]++;
			
			pformat:( ""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" присоединился к "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, CrimeFraction[crime][c_name] );
			psend:( leaderid, C_WHITE );
			
			switch( rank )
			{
				case INVALID_PARAM :
				{
					pformat:( ""gbSuccess"Вы стали членом криминальной структуры "cBLUE"%s"cWHITE" без ранга.", CrimeFraction[crime][c_name] );
					psend:( playerid, C_WHITE );
				
					Player[playerid][uCrimeM] = CrimeFraction[crime][c_id];
					Player[playerid][uCrimeRank] = 0;
				}
				
				default :
				{
					pformat:( ""gbSuccess"Вы стали членом криминальной структуры "cBLUE"%s"cWHITE" с рангом "cBLUE"%s"cWHITE".", CrimeFraction[crime][c_name], CrimeRank[crime][rank][r_name] );
					psend:( playerid, C_WHITE );
					
					CMember[crime][member][m_rank] = rank + 1;
				
					Player[playerid][uCrimeM] = CrimeFraction[crime][c_id];
					Player[playerid][uCrimeRank] = CrimeRank[crime][rank][r_id];
				}
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeM` = %d, `uCrimeRank` = %d WHERE `uID` = %d",
				Player[playerid][uCrimeM],
				Player[playerid][uCrimeRank],
				Player[playerid][uID]
			);
			mysql_tquery( mysql, g_string );
			
			g_player_interaction{leaderid} =
			g_player_interaction{playerid} = 0;
				
			DeletePVar( playerid, "Crime:PlayerID" );
			DeletePVar( leaderid, "Crime:PlayerID" );
				
			DeletePVar( playerid, "Crime:ID" );
			DeletePVar( playerid, "Crime:RankID" );
		}
		
		case d_crime + 15:
		{
			if( !response ) 
			{
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
				
			switch( listitem )
			{
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"Исключить из криминальной структуры\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите id игрока:", CrimeFraction[crime][c_name] );
						
					showPlayerDialog( playerid, d_crime + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 1:
				{
					format:g_small_string( "\
						"cWHITE"Исключить из криминальной структуры\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите номер аккаунта:", CrimeFraction[crime][c_name] );
						
					showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
		}
		
		case d_crime + 16:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 15, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Исключить по ID игрока\n\
					Исключить по номеру аккаунта", "Выбрать", "Закрыть" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || !IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) )
			{
				format:g_small_string( "\
					"cWHITE"Исключить из криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите id игрока:\n\
					"gbDialogError"Некорректный id игрока.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( PlayerLeaderCrime( strval( inputtext ), crime ) )
			{
				format:g_small_string( "\
					"cWHITE"Исключить из криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите id игрока:\n\
					"gbDialogError"Вы не можете уволить лидера.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[strval( inputtext )][uCrimeM] != Player[playerid][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"Исключить из криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите id игрока:\n\
					"gbDialogError"Игрок не является членом этой криминальной структуры.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( CMember[crime][i][m_id] == Player[strval( inputtext )][uID] )
				{
					CMember[crime][i][m_id] = 
					CMember[crime][i][m_lasttime] = 
					CMember[crime][i][m_rank] = 0;
				
					CMember[crime][i][m_name][0] = EOS;
				
					break;
				}
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeM` = 0, `uCrimeRank` = 0 WHERE `uID` = %d", Player[strval( inputtext )][uID] );
			mysql_tquery( mysql, g_string );
			
			CrimeFraction[crime][c_members]--;
			
			Player[strval( inputtext )][uCrimeM] = 
			Player[strval( inputtext )][uCrimeRank] = 0;
			
			pformat:( ""gbSuccess"Вы уволили "cBLUE"%s[%d]"cWHITE" из "cBLUE"%s"cWHITE".", Player[strval( inputtext )][uName], strval( inputtext ), CrimeFraction[crime][c_name] );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"Вы уволены из "cBLUE"%s"cWHITE" игроком "cBLUE"%s[%d]"cWHITE".", CrimeFraction[crime][c_name], Player[playerid][uName], playerid );
			psend:( strval( inputtext ), C_WHITE );
			
			g_player_interaction{playerid} = 0;
		}
		
		case d_crime + 17:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 15, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Исключить по ID игрока\n\
					Исключить по номеру аккаунта", "Выбрать", "Закрыть" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				member = INVALID_PARAM;
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || Player[playerid][uID] == strval( inputtext ) || strval( inputtext ) < 1 )
			{
				format:g_small_string( "\
					"cWHITE"Исключить из криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите номер аккаунта:\n\
					"gbDialogError"Некорректный номер аккаунта.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			foreach(new i : Player)
			{
				if( strval( inputtext ) == Player[i][uID] )
				{
					format:g_small_string( "\
						"cWHITE"Исключить из криминальной структуры\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите номер аккаунта:\n\
						"gbDialogError"Игрок в онлайне, воспользуйтесь другим способом увольнения.", CrimeFraction[crime][c_name] );
							
					return showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
			
			for( new i; i < 3; i++ )
			{
				if( strval( inputtext ) == CrimeFraction[crime][c_leader][i] )
				{
					format:g_small_string( "\
						"cWHITE"Исключить из криминальной структуры\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите номер аккаунта:\n\
						"gbDialogError"Вы не можете уволить лидера.", CrimeFraction[crime][c_name] );
							
					return showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( strval( inputtext ) == CMember[crime][i][m_id] )
				{
					member = i;
					break;
				}
			}
			
			if( member == INVALID_PARAM )
			{
				format:g_small_string( "\
					"cWHITE"Исключить из криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите номер аккаунта:\n\
					"gbDialogError"Игрок не является членом этой криминальной структуры.", CrimeFraction[crime][c_name] );
						
				return showPlayerDialog( playerid, d_crime + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uCrimeM` = 0, `uCrimeRank` = 0 WHERE `uID` = %d", strval( inputtext ) );
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"Вы уволили "cBLUE"%s"cWHITE" из "cBLUE"%s"cWHITE".", CMember[crime][member][m_name], CrimeFraction[crime][c_name] );
			psend:( playerid, C_WHITE );
			
			CrimeFraction[crime][c_members]--;
			
			CMember[crime][member][m_id] = 
			CMember[crime][member][m_lasttime] = 
			CMember[crime][member][m_rank] = 0;
				
			CMember[crime][member][m_name][0] = EOS;
				
			g_player_interaction{playerid} = 0;
		}
		//Транспорт
		case d_crime + 18:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				rank;
		
			if( !response )
			{
				format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
				return showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "Выбрать", "Закрыть" );
			}
			
			switch( listitem )
			{
				case 0: CrimeVehicles( playerid, crime );
				
				case 1:
				{
					if( !PlayerLeaderCrime( playerid, crime ) )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
						
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
					}
					
					if( CrimeFraction[crime][c_amountveh] >= CrimeFraction[crime][c_vehicles] )
					{
						pformat:( ""gbError"Количественный лимит транспорта для вашей фракции превышен [%d/%d].", CrimeFraction[crime][c_amountveh], CrimeFraction[crime][c_vehicles] );
						psend:( playerid, C_WHITE );
					
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
					}
				
					if( !CrimeFraction[crime][c_type_vehicles] )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
					
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
					}
				
					showPlayerDialog( playerid, d_crime + 20, DIALOG_STYLE_LIST, "Приобретение транспорта", "\
						Список доступного транспорта\n\
						* Продолжить", "Выбрать", "Назад" );
				}
				
				case 2: // cspawn
				{
					if( PlayerLeaderCrime( playerid, crime ) ) goto next_crime;
					
					if( !Player[playerid][uCrimeRank] )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
					}
					
					rank = getCrimeRankId( playerid, crime );
						
					if( !CrimeRank[crime][rank][r_spawnveh] )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
					}
					
					next_crime:
				
					format:g_small_string( "\
						"cWHITE"Вернуть транспорт криминальной организации\n\
						"cBLUE"%s "cWHITE"на парковочное место\n\n\
						"cWHITE"Укажите ID транспорта в /dl:", CrimeFraction[crime][c_name] );
				
					showPlayerDialog( playerid, d_crime + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 3: // fixcarall
				{
					cmd_fixcarall( playerid );
				}
				
				case 4: // Припарковать транспорт
				{
					format:g_small_string( "\
						"cWHITE"Припарковать транспорт криминальной организации\n\
						"cBLUE"%s\n\n\
						"cWHITE"Укажите ID транспорта в /dl:", CrimeFraction[crime][c_name] );
						
					showPlayerDialog( playerid, d_crime + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 5: //Удаление
				{
					if( !PlayerLeaderCrime( playerid, crime ) )
					{
						SendClient:( playerid, C_WHITE, !NO_LEADER );
						
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
					}
					
					if( !GetAccessAdmin( playerid, 5 ) )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Для удаления транспорта организации обратитесь к администратору." );
						
						return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
					}
				
					format:g_small_string( "\
						"cWHITE"Удаление транспорта криминальной организации\n\
						"cBLUE"%s\n\n\
						"cWHITE"Укажите ID транспорта в /dl:", CrimeFraction[crime][c_name] );
				
					showPlayerDialog( playerid, d_crime + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
		}
		
		case d_crime + 19:
		{
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
		}
		
		case d_crime + 20:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				type = CrimeFraction[crime][c_type];
			
			switch( listitem )
			{
				case 0:
				{
					clean:<g_string>;
					strcat( g_string, ""cGRAY"Вашей криминальной организации доступны:\n" );
				
					for( new i; i < 30; i++ )
					{
						if( crime_vehicles[type][i] )
						{
							format:g_small_string( "\n"cWHITE"Модель: %d, "cBLUE"%s"cWHITE"", crime_vehicles[type][i], GetVehicleModelName( crime_vehicles[type][i] ) );
							strcat( g_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_crime + 32, DIALOG_STYLE_MSGBOX, "Список доступного транспорта", g_string, "Назад", "" );
				}
				
				case 1:
				{
					format:g_small_string( "\
						"cWHITE"Приобретение транспорта для криминальной структуры\n\
						"cBLUE"%s\n\n\
						"cWHITE"Укажите номер модели транспорта:", CrimeFraction[crime][c_name] );
					showPlayerDialog( playerid, d_crime + 21, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
		}
		
		case d_crime + 21:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 20, DIALOG_STYLE_LIST, "Приобретение транспорта", "\
					Список доступного транспорта\n\
					* Продолжить", "Выбрать", "Назад" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				type = CrimeFraction[crime][c_type],
				bool:flag = false;
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 400 || strval( inputtext ) > 611 || VehicleInfo[strval( inputtext ) - 400][v_fracspawn] == INVALID_PARAM )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:\n\
					"gbDialogError"Неправильный формат ввода.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 21, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		
			for( new i; i < 66; i++ )
			{
				if( !crime_vehicles[type][i] ) continue;
			
				if( crime_vehicles[type][i] == strval( inputtext ) )
				{
					flag = true;					
					break;
				}
			}
			
			if( flag == false )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:\n\
					"gbDialogError"Данный транспорт недоступен для Вашей криминальной структуры.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 21, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		
			SetPVarInt( playerid, "Crime:BuyVehicle", strval(inputtext) );
			ShowFracVehicleInformation( playerid, strval(inputtext), d_crime + 22, "Далее", "Назад" );
		}
		
		case d_crime + 22:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				model = GetPVarInt( playerid, "Crime:BuyVehicle" ),
				price = floatround( VehicleInfo[ model - 400 ][v_price] / 100 * PERCENT_FOR_VEHICLE );
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:BuyVehicle" );
				
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:", CrimeFraction[crime][c_name] );
				return showPlayerDialog( playerid, d_crime + 21, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				
				ShowFracVehicleInformation( playerid, strval(inputtext), d_crime + 22, "Далее", "Назад" );
				return 1;
			}
			
			format:g_small_string( "\
				"cWHITE"Приобретение транспорта для криминальной структуры\n\
				"cBLUE"%s\n\n\
				"cWHITE"Укажите первый цвет для "cBLUE"%s"cWHITE":", CrimeFraction[crime][c_name], GetVehicleModelName( model ) );
				
			showPlayerDialog( playerid, d_crime + 23, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_crime + 23:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				model = GetPVarInt( playerid, "Crime:BuyVehicle" );
		
			if( !response )
			{
				ShowFracVehicleInformation( playerid, model, d_crime + 22, "Далее", "Назад" );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 255 )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите первый цвет для "cBLUE"%s"cWHITE":\n\
					"gbDialogError"Неправильный формат ввода.", CrimeFraction[crime][c_name], GetVehicleModelName( model ) );
					
				return showPlayerDialog( playerid, d_crime + 23, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Crime:Color1Vehicle", strval( inputtext ) );
			format:g_small_string( "\
				"cWHITE"Приобретение транспорта для криминальной структуры\n\
				"cBLUE"%s\n\n\
				"cWHITE"Укажите второй цвет для "cBLUE"%s"cWHITE":\n\
				"gbDialog"Первый цвет: %d", CrimeFraction[crime][c_name], GetVehicleModelName( model ), strval( inputtext ) );
					
			showPlayerDialog( playerid, d_crime + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_crime + 24:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				model = GetPVarInt( playerid, "Crime:BuyVehicle" ),
				price = floatround( VehicleInfo[ model - 400 ][v_price] / 100 * PERCENT_FOR_VEHICLE ),
				color_1 = GetPVarInt( playerid, "Crime:Color1Vehicle" ),
				color_2,
				spawnveh = VehicleInfo[model - 400][v_fracspawn],
				index = random(5),
				bool:flag = false,
				car,
				number[ 10 ],
				abcnumber[10] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' },
				abcstring[26] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:Color1Vehicle" );
				
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите первый цвет для "cBLUE"%s"cWHITE":", CrimeFraction[crime][c_name], GetVehicleModelName( model ) );
					
				return showPlayerDialog( playerid, d_crime + 23, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 255 )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для криминальной структуры\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите второй цвет для "cBLUE"%s"cWHITE":\n\
					"gbDialog"Первый цвет: %d\n\n\
					"gbDialogError"Неправильный формат ввода.", CrimeFraction[crime][c_name], GetVehicleModelName( model ), color_1 );
						
				return showPlayerDialog( playerid, d_crime + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				DeletePVar( playerid, "Crime:BuyVehicle" );
				DeletePVar( playerid, "Crime:Color1Vehicle" );
			
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
			}
			
			color_2 = strval( inputtext );
			
			for( new i; i < 7; i++ )
			{
				if( i < 1 || i > 3 )
				{
					number[i] = abcnumber[ random(10) ];
					continue;
				}
				
				number[i] = abcstring[ random(26) ];
			}
			
			for( new i; i < CrimeFraction[crime][c_vehicles]; i++ )
			{
				if( CVehicle[crime][i][v_number][0] == EOS )
				{					
					CVehicle[crime][i][v_id] = CreateVehicle( model, crime_vehicles_spawn[spawnveh][index][0], crime_vehicles_spawn[spawnveh][index][1], crime_vehicles_spawn[spawnveh][index][2], crime_vehicles_spawn[spawnveh][index][3], color_1, color_2, INVALID_PARAM );
					car = CVehicle[crime][i][v_id];
					
					clean:<CVehicle[crime][i][v_number]>;			
					strcat( CVehicle[crime][i][v_number], number, 10 );
										
					ClearVehicleData( car );
					
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				DeletePVar( playerid, "Crime:BuyVehicle" );
				DeletePVar( playerid, "Crime:Color1Vehicle" );
			
				SendClient:( playerid, C_WHITE, ""gbSuccess"Количественный лимит для Вашей криминальной организации превышен." );
				return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
			}
			
			SetPlayerCash( playerid, "-", price );
			
			Vehicle[car][vehicle_user_id] = INVALID_PARAM;
			Vehicle[car][vehicle_model] = model;
			Vehicle[car][vehicle_crime] = Player[playerid][uCrimeM]; 
					
			Vehicle[car][vehicle_pos][0] = crime_vehicles_spawn[spawnveh][index][0];
			Vehicle[car][vehicle_pos][1] = crime_vehicles_spawn[spawnveh][index][1];
			Vehicle[car][vehicle_pos][2] = crime_vehicles_spawn[spawnveh][index][2];
			Vehicle[car][vehicle_pos][3] = crime_vehicles_spawn[spawnveh][index][3];
					
			Vehicle[car][vehicle_color][0] = color_1;
			Vehicle[car][vehicle_color][1] = color_2;
			Vehicle[car][vehicle_color][2] = 0;
					
			Vehicle[car][vehicle_fuel] = VehicleInfo[model - 400][v_fuel] / 100.0 * 20.0;
			Vehicle[car][vehicle_engine] = 100.0;
					
			Vehicle[car][vehicle_state_window][0] = 
			Vehicle[car][vehicle_state_window][1] =
			Vehicle[car][vehicle_state_window][2] =
			Vehicle[car][vehicle_state_window][3] = 1;
					
			Vehicle[car][vehicle_engine_date] = 
			Vehicle[car][vehicle_date] = gettime();
			
			clean:<Vehicle[car][vehicle_number]>;
			strcat( Vehicle[car][vehicle_number], number, 10 );
			
			SetVehicleNumberPlate( car, number );

			CreateCar( car );
			SetVehicleParams( car );
					
			CrimeFraction[crime][c_amountveh]++;
			
			pformat:( ""gbSuccess"Вы приобрели "cBLUE"%s %s"cWHITE" гос. номер "cBLUE"%s"cWHITE" для своей криминальной организации.", VehicleInfo[model - 400][v_type], GetVehicleModelName( model ), number );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"%s", crime_vehicles_description[spawnveh] );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Crime:BuyVehicle" );
			DeletePVar( playerid, "Crime:Color1Vehicle" );
			
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
		}
		
		case d_crime + 26:
		{
			if( !response ) return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
			
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"Вернуть транспорт криминальной организации\n\
					"cBLUE"%s "cWHITE"на парковочное место\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Неправильный формат ввода.", CrimeFraction[ crime ][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_crime] != Player[ playerid ][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"Вернуть транспорт криминальной организации\n\
					"cBLUE"%s "cWHITE"на парковочное место\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Данный транспорт не принадлежит Вашей криминальной организации.", CrimeFraction[ crime ][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( IsVehicleOccupied( strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"Вернуть транспорт криминальной организации\n\
					"cBLUE"%s "cWHITE"на парковочное место\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Данный транспорт используется.", CrimeFraction[ crime ][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetVehicleZAngle( strval( inputtext ), Vehicle[strval( inputtext )][vehicle_pos][3] );
			setVehiclePos( strval( inputtext ), 
				Vehicle[ strval( inputtext ) ][vehicle_pos][0],
				Vehicle[ strval( inputtext ) ][vehicle_pos][1],
				Vehicle[ strval( inputtext ) ][vehicle_pos][2]
			);
			
			LinkVehicleToInterior( strval( inputtext ), Vehicle[ strval( inputtext ) ][vehicle_int] );
			SetVehicleVirtualWorld( strval( inputtext ), Vehicle[ strval( inputtext ) ][vehicle_world] );
			
			ResetVehicleParams( strval( inputtext ) );
			
			pformat:( ""gbSuccess"Транспорт "cBLUE"%s[%d]"cWHITE" возвращен на парковочное место.", GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ), strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
		}
		
		case d_crime + 27:
		{
			if( !response ) return 1;
			
			new
				vehicleid,
				amount,
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
			
			for( new i; i < CrimeFraction[crime][c_vehicles]; i++ )
			{
				if( CVehicle[crime][i][v_id]  )
				{
					vehicleid = CVehicle[crime][i][v_id];
				
					if( IsVehicleOccupied( vehicleid ) ) continue;
				
					SetVehicleZAngle( vehicleid, Vehicle[vehicleid][vehicle_pos][3] );
					setVehiclePos( vehicleid, 
						Vehicle[ vehicleid ][vehicle_pos][0],
						Vehicle[ vehicleid ][vehicle_pos][1],
						Vehicle[ vehicleid ][vehicle_pos][2]
					);
						
					LinkVehicleToInterior( vehicleid, Vehicle[ vehicleid ][vehicle_int] );
					SetVehicleVirtualWorld( vehicleid, Vehicle[ vehicleid ][vehicle_world] );
						
					ResetVehicleParams( vehicleid );
					
					amount++;
				}
			}
			
			if( !amount ) return SendClient:( playerid, C_WHITE, !""gbError"Нет свободного транспорта." );
			
			pformat:( ""gbSuccess"Вы успешно вернули неиспользуемый транспорт на парковочные места: "cBLUE"%d", amount );
			psend:( playerid, C_WHITE );
			
			format:g_small_string( ""FRACTION_PREFIX" %s[%d] вернул неиспользуемый транспорт на парковочные места: %d", Player[playerid][uName], playerid, amount );
			SendCrimeLeaderMessage( crime, C_DARKGRAY, g_small_string );
		}
		
		case d_crime + 28:
		{
			if( !response ) return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
			
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"Припарковать транспорт криминальной организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:", CrimeFraction[ crime ][c_name] );
							
				return showPlayerDialog( playerid, d_crime + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_crime] != Player[playerid][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"Припарковать транспорт криминальной организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Данный транспорт не принадлежит Вашей организации.", CrimeFraction[ crime ][c_name] );
							
				return showPlayerDialog( playerid, d_crime + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( !IsPlayerInVehicle( playerid, strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"Припарковать транспорт криминальной организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Для совершения данного действия Вы должны находиться в этом транспорте.", CrimeFraction[ crime ][c_name] );
							
				return showPlayerDialog( playerid, d_crime + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			Vehicle[strval( inputtext )][vehicle_world] = GetVehicleVirtualWorld( strval( inputtext ) );
			
			if( Vehicle[strval( inputtext )][vehicle_world] )
				Vehicle[strval( inputtext )][vehicle_int] = 1;
			else
				Vehicle[strval( inputtext )][vehicle_int] = 0;
				
			SetVehiclePark( strval( inputtext ) );
			
			pformat:( ""gbSuccess"Вы успешно припарковали транспорт - "cBLUE"%s[%d]"cWHITE".", GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ), strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
		}
		
		case d_crime + 29:
		{
			if( !response )
			{
				DeletePVar( playerid, "Crime:VId" );
				return 1;
			}
			
			new
				vid = GetPVarInt( playerid, "Crime:VId" );
				
			if( !IsPlayerInVehicle( playerid, vid ) )
			{
				DeletePVar( playerid, "Fraction:VId" );
				return SendClient:( playerid, C_WHITE, !""gbError"Для совершения данного действия Вы должны находиться в транспорте." );
			}
			
			Vehicle[vid][vehicle_world] = GetVehicleVirtualWorld( vid );
			
			if( Vehicle[vid][vehicle_world] )
				Vehicle[vid][vehicle_int] = 1;
			else
				Vehicle[vid][vehicle_int] = 0;
			
			SetVehiclePark( vid );
			
			pformat:( ""gbSuccess"Вы успешно припарковали транспорт - "cBLUE"%s[%d]"cWHITE".", GetVehicleModelName( Vehicle[vid][vehicle_model] ), vid );
			psend:( playerid, C_WHITE );
				
			DeletePVar( playerid, "Crime:VId" );
		}
		
		case d_crime + 30:
		{
			if( !response ) return showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
		
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"Удаление транспорта криминальной организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Неправильный формат ввода.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_crime] != Player[playerid][uCrimeM] )
			{
				format:g_small_string( "\
					"cWHITE"Удаление транспорта криминальной организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Данный транспорт не принадлежит Вашей организации.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Crime:VId", strval( inputtext ) );			
			
			format:g_small_string( "\
				"cWHITE"Удаление транспорта криминальной организации\n\
				"cBLUE"%s\n\n\
				"cWHITE"Вы действительно желаете удалить "cBLUE"%s[%d] гос. номер %s"cWHITE"?",
				CrimeFraction[crime][c_name], 
				GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ),
				strval( inputtext ),
				Vehicle[strval( inputtext )][vehicle_number]
			);
			showPlayerDialog( playerid, d_crime + 31, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		}
		
		case d_crime + 31:
		{
			new
				crime = getIndexCrimeFraction( Player[ playerid ][uCrimeM] ),
				vid = GetPVarInt( playerid, "Crime:VId" );
		
			if( !response )
			{
				DeletePVar( playerid, "Crime:VId" );
			
				format:g_small_string( "\
					"cWHITE"Удаление транспорта криминальной организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_crime + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < CrimeFraction[crime][c_vehicles]; i++ )
			{
				if( CVehicle[crime][i][v_id] == vid )
				{
					CVehicle[crime][i][v_id] = 0;
					CVehicle[crime][i][v_number][0] = EOS;
					break;
				}
			}
			
			CrimeFraction[crime][c_amountveh]--;
			
			mysql_format:g_string( "DELETE FROM `"DB_VEHICLES"` WHERE `vehicle_id` = %d", Vehicle[vid][vehicle_id] );
			mysql_tquery( mysql, g_string );
			
			mysql_format:g_string( "DELETE FROM `"DB_ITEMS"` WHERE `item_type_id` = %d AND `item_type` = 2", Vehicle[vid][vehicle_id] );	
			mysql_tquery( mysql, g_string );

			pformat:( ""gbSuccess""cBLUE"%s"cWHITE" успешно удален.", GetVehicleModelName( GetVehicleModel( vid ) ) );
			psend:( playerid, C_WHITE );
			
			DestroyVehicleEx( vid );
			DeletePVar( playerid, "Crime:VId" );
			
			showPlayerDialog( playerid, d_crime + 18, DIALOG_STYLE_TABLIST_HEADERS, " ", mpanel_vehicles, "Выбрать", "Назад" );
		}
		//Изменить название
		case d_crime + 32:
		{
			showPlayerDialog( playerid, d_crime + 20, DIALOG_STYLE_LIST, "Приобретение транспорта", "\
				Список доступного транспорта\n\
				* Продолжить", "Выбрать", "Назад" );
		}
		//Звонок гандилеру
		case d_crime + 33:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
				
			if( !response )
			{
				CrimeFraction[crime][c_time_dealer] = 0;
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"Набрать номер\n\
					"cWHITE"Номера сервисных служб\n\
					Другие номера\n\
					Узнать свой номер",
				"Выбрать", "Закрыть" );
			}
			
			CrimeFraction[crime][c_time] = gettime() + DAYS_TO_GUNDEALER * 86400;
			
			switch( CrimeFraction[crime][c_type_weapon] )
			{
				case 1: CrimeFraction[crime][c_amount_weapon] = 15;
				case 2: CrimeFraction[crime][c_amount_weapon] = 30;
				case 3: CrimeFraction[crime][c_amount_weapon] = 45;
			}
			
			for( new i; i < 2; i++ )
			{
				for( new j; j < 10; j++ )
				{
					CrimeOrder[crime][i][gun_id][j] = 
					CrimeOrder[crime][i][gun_amount][j] = 0;
				}
			}
			
			showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "Заказ оружия", "\
				"cBLUE"1."cWHITE" Оружие\n\
				"cBLUE"2."cWHITE" Патроны\n\
				"cBLUE"3."cWHITE" Информация\n\
				"gbDialog"Продолжить", "Выбрать", "Отмена" );
		}
		
		case d_crime + 34:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
				
			if( !response )
			{
				CrimeFraction[crime][c_time] = 0;
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"Набрать номер\n\
					"cWHITE"Номера сервисных служб\n\
					Другие номера\n\
					Узнать свой номер",
				"Выбрать", "Закрыть" );
			}
			
			if( listitem == 3 )
			{
				new
					total,
					amount;
			
				switch( CrimeFraction[crime][c_type_weapon] )
				{
					case 1: 
					{
						if( CrimeFraction[crime][c_amount_weapon] == 15 )
						{
							SendClient:( playerid, C_WHITE, !""gbError"Вы не оформили данные заказа." );
							return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "Заказ оружия", "\
								"cBLUE"1."cWHITE" Оружие\n\
								"cBLUE"2."cWHITE" Патроны\n\
								"cBLUE"3."cWHITE" Информация\n\
								"gbDialog"Продолжить", "Выбрать", "Отмена" );
						}
						
						amount = 15;
					}
					case 2: 
					{
						if( CrimeFraction[crime][c_amount_weapon] == 30 )
						{
							SendClient:( playerid, C_WHITE, !""gbError"Вы не оформили данные заказа." );
							return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "Заказ оружия", "\
								"cBLUE"1."cWHITE" Оружие\n\
								"cBLUE"2."cWHITE" Патроны\n\
								"cBLUE"3."cWHITE" Информация\n\
								"gbDialog"Продолжить", "Выбрать", "Отмена" );
						}
						
						amount = 30;
					}
					case 3: 
					{
						if( CrimeFraction[crime][c_amount_weapon] == 45 )
						{
							SendClient:( playerid, C_WHITE, !""gbError"Вы не оформили данные заказа." );
							return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "Заказ оружия", "\
								"cBLUE"1."cWHITE" Оружие\n\
								"cBLUE"2."cWHITE" Патроны\n\
								"cBLUE"3."cWHITE" Информация\
								"gbDialog"Продолжить", "Выбрать", "Отмена" );
						}
						
						amount = 45;
					}
				}
			
				for( new i; i < 2; i++ )
				{
					for( new j; j < 10; j++ )
					{
						if( CrimeOrder[crime][i][gun_amount][j] )
						{
							total += CrimeOrder[crime][i][gun_amount][j] * weapons_info[i][j][gun_price];
						}
					}
				}
			
				format:g_small_string( "\
					"cBLUE"Заказ дилеру\n\n\
					"cWHITE"Общее количество заказа: "cBLUE"%d\n\
					"cWHITE"На сумму: "cBLUE"$%d\n\n\
					"cWHITE"Передать данные?",
					amount - CrimeFraction[crime][c_amount_weapon], total );
					
				return showPlayerDialog( playerid, d_crime + 37, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else if( listitem == 2 )
			{
				ShowCrimePriceInfo( playerid, CrimeFraction[crime][c_type_weapon] - 1 );
				return 1;
			}
			
			ShowWeaponsCrime( playerid, listitem, crime );
		}
		
		case d_crime + 35:
		{
			if( !response )
			{
				DeletePVar( playerid, "GunDealer:Type" );
				return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "Заказ оружия", "\
					"cBLUE"1."cWHITE" Оружие\n\
					"cBLUE"2."cWHITE" Патроны\n\
					"cBLUE"3."cWHITE" Информация\n\
					"gbDialog"Продолжить", "Выбрать", "Отмена" );
			}
			
			new
				type = GetPVarInt( playerid, "GunDealer:Type" ),
				id = getInventoryId( weapons_info[type][listitem][gun_id] ),
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
				
			SetPVarInt( playerid, "GunDealer:Weapon", listitem );
			format:g_small_string( "\
				"cBLUE"Заказ дилеру\n\n\
				"cWHITE"Укажите количество "cBLUE"%s"cWHITE":\n\
				"gbDialog"Еще доступно: %d",
				inventory[id][i_name],
				CrimeFraction[crime][c_amount_weapon] + CrimeOrder[crime][type][gun_amount][listitem] );
			showPlayerDialog( playerid, d_crime + 36, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_crime + 36:
		{
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				type = GetPVarInt( playerid, "GunDealer:Type" ),
				index = GetPVarInt( playerid, "GunDealer:Weapon" ),
				id = getInventoryId( weapons_info[type][index][gun_id] );
		
			if( !response )
			{
				DeletePVar( playerid, "GunDealer:Weapon" );
				ShowWeaponsCrime( playerid, type, crime );
				
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				format:g_small_string( "\
					"cBLUE"Заказ дилеру\n\n\
					"cWHITE"Укажите количество "cBLUE"%s"cWHITE":\n\
					"gbDialog"Еще доступно: %d\n\n\
					"gbDialogError"Неправильный формат ввода",
					inventory[id][i_name],
					CrimeFraction[crime][c_amount_weapon] + CrimeOrder[crime][type][gun_amount][index] );
				return showPlayerDialog( playerid, d_crime + 36, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( CrimeFraction[crime][c_amount_weapon] - strval( inputtext ) < 0 )
			{
				format:g_small_string( "\
					"cBLUE"Заказ дилеру\n\n\
					"cWHITE"Укажите количество "cBLUE"%s"cWHITE":\n\
					"gbDialog"Еще доступно: %d\n\n\
					"gbDialogError"Вы превысили лимит",
					inventory[id][i_name],
					CrimeFraction[crime][c_amount_weapon] + CrimeOrder[crime][type][gun_amount][index] );
				return showPlayerDialog( playerid, d_crime + 36, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( CrimeOrder[crime][type][gun_amount][index] )
			{
				CrimeFraction[crime][c_amount_weapon] += CrimeOrder[crime][type][gun_amount][index];
			}
			
			CrimeFraction[crime][c_amount_weapon] -= strval( inputtext );
			
			CrimeOrder[crime][type][gun_amount][index] = strval( inputtext );
			
			DeletePVar( playerid, "GunDealer:Weapon" );
			GetPVarInt( playerid, "GunDealer:Type" );
			
			ShowWeaponsCrime( playerid, type, crime );
		}
		
		case d_crime + 37:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "Заказ оружия", "\
					"cBLUE"1."cWHITE" Оружие\n\
					"cBLUE"2."cWHITE" Патроны\n\
					"cBLUE"3."cWHITE" Информация\n\
					"gbDialog"Продолжить", "Выбрать", "Отмена" );
			}
			
			new
				crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
				//time = randomize( 600, 1 * 3600 ),
				time = randomize( 300, 400 ),
				index = random( COUNT_GUNDEALERS ),
				hour, minute;
			
			if( GunDealer[ index ][g_fracid] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Ошибка в передаче данных. Попробуйте еще раз." );
			
				return showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "Заказ оружия", "\
					"cBLUE"1."cWHITE" Оружие\n\
					"cBLUE"2."cWHITE" Патроны\n\
					"cBLUE"3."cWHITE" Информация\n\
					"gbDialog"Продолжить", "Выбрать", "Отмена" );
			}
			
			for( new i; i < 2; i++ )
			{
				for( new j; j < 10; j++ )
				{
					if( CrimeOrder[crime][i][gun_amount][j] )
					{
						DealerOrder[ index ][i][gun_id][j] = weapons_info[i][j][gun_id];
						DealerOrder[ index ][i][gun_amount][j] = CrimeOrder[crime][i][gun_amount][j];
					}
					
					CrimeOrder[crime][i][gun_id][j] = 
					CrimeOrder[crime][i][gun_amount][j] = 0;
				}
				
				mysql_format:g_string( "INSERT INTO `"DB_CRIME_ORDER"` \
					( `point_id`, `point_type`, `point_gunid`, `point_amount` ) \
					VALUES \
					( %d, %d, '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d', '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' )",
					GunDealer[index][g_id],
					i + 1,
					DealerOrder[ index ][i][gun_id][0], DealerOrder[ index ][i][gun_id][1], DealerOrder[ index ][i][gun_id][2],
					DealerOrder[ index ][i][gun_id][3], DealerOrder[ index ][i][gun_id][4], DealerOrder[ index ][i][gun_id][5],
					DealerOrder[ index ][i][gun_id][6], DealerOrder[ index ][i][gun_id][7], DealerOrder[ index ][i][gun_id][8],
					DealerOrder[ index ][i][gun_id][9], 
					DealerOrder[ index ][i][gun_amount][0], DealerOrder[ index ][i][gun_amount][1], DealerOrder[ index ][i][gun_amount][2],
					DealerOrder[ index ][i][gun_amount][3], DealerOrder[ index ][i][gun_amount][4], DealerOrder[ index ][i][gun_amount][5],
					DealerOrder[ index ][i][gun_amount][6], DealerOrder[ index ][i][gun_amount][7], DealerOrder[ index ][i][gun_amount][8],
					DealerOrder[ index ][i][gun_amount][9] );
				mysql_tquery( mysql, g_string );
			}
			
			GunDealer[ index ][g_fracid] = CrimeFraction[crime][c_id];
			CrimeFraction[crime][c_time_dealer] = gettime() + time;
			CrimeFraction[crime][c_index_dealer] = index;
			GetPos2DZone( GunDealer[index][g_actor_pos][0], GunDealer[index][g_actor_pos][1], GunDealer[index][g_zone], 28 );
			
			gmtime( CrimeFraction[crime][c_time_dealer], _, _, _, hour, minute );
			
			format:g_small_string( ""FRACTION_PREFIX" %s[%d] оформил заказ на оружие: дилер будет ожидать в районе %s в %02d:%02d",
				Player[playerid][uName], playerid, GunDealer[index][g_zone], hour, minute );
			SendCrimeMessage( crime, C_DARKGRAY, g_small_string );
			
			mysql_format:g_small_string( "UPDATE `"DB_CRIME"` SET `c_time` = %d, `c_time_dealer` = %d WHERE `c_id` = %d LIMIT 1",
				CrimeFraction[crime][c_time], CrimeFraction[crime][c_time_dealer], CrimeFraction[crime][c_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_small_string( "UPDATE `"DB_CRIME_GUNDEALER"` SET `g_fracid` = 1 WHERE `g_id` = %d LIMIT 1",
				GunDealer[ index ][g_id] );
			mysql_tquery( mysql, g_small_string );
			
			format:g_small_string("\
				"cBLUE"Заказ принят в очередь\n\n\
				"cWHITE"Дилер будет ожидать Вас в районе "cBLUE"%s в %02d:%02d"cWHITE".", 
				GunDealer[index][g_zone], hour, minute );
				
			showPlayerDialog( playerid, d_crime + 38, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
		}
		
		case d_crime + 38:
		{
			showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
				"gbDialog"Набрать номер\n\
				"cWHITE"Номера сервисных служб\n\
				Другие номера\n\
				Узнать свой номер",
			"Выбрать", "Закрыть" );
		}
		
		case d_crime + 39:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Crime:Order" );
				return 1;
			}
			
			SetPVarInt( playerid, "Crime:Type", listitem );
			ShowWeaponsOrder( playerid, listitem, GetPVarInt( playerid, "Crime:Order" ) );
		}
		
		case d_crime + 40:
		{
			new
				type = GetPVarInt( playerid, "Crime:Type" ),
				order = GetPVarInt( playerid, "Crime:Order" );
				
			if( !response )
			{
				DeletePVar( playerid, "Crime:Type" );
				return showPlayerDialog( playerid, d_crime + 39, DIALOG_STYLE_LIST, "Гандилер", "\
					"cBLUE"1."cWHITE" Оружие\n\
					"cBLUE"2."cWHITE" Патроны", "Выбрать", "Закрыть" );
			}
			
			SetPVarInt( playerid, "Crime:Index", g_dialog_select[playerid][listitem] );
			ShowAmountOrder( playerid, type, order, g_dialog_select[playerid][listitem] );
			
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_crime + 41:
		{
			new
				type = GetPVarInt( playerid, "Crime:Type" ),
				order = GetPVarInt( playerid, "Crime:Order" ),
				index = GetPVarInt( playerid, "Crime:Index" );
			
			if( !response )
			{
				DeletePVar( playerid, "Crime:Index" );
				ShowWeaponsOrder( playerid, type, order );
				return 1;
			}
			
			if( Player[playerid][uMoney] < weapons_info[type][index][gun_price] )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
			
				DeletePVar( playerid, "Crime:Index" );
				ShowWeaponsOrder( playerid, type, order );
				return 1;
			}
			
			if( !DealerOrder[order][type][gun_amount][index] )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Этот товар полностью разобран." );
			
				DeletePVar( playerid, "Crime:Index" );
				ShowWeaponsOrder( playerid, type, order );
				return 1;
			}
			
			if( !giveItem( playerid, DealerOrder[order][type][gun_id][index], 1, weapons_info[type][index][gun_amount] ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
			
			DealerOrder[order][type][gun_amount][index] --;
			SetPlayerCash( playerid, "-", weapons_info[type][index][gun_price] );
			
			if( !DealerOrder[order][type][gun_amount][index] )
			{
				DealerOrder[order][type][gun_id][index] = 0;
			
				DeletePVar( playerid, "Crime:Index" );
				ShowWeaponsOrder( playerid, type, order );
				return 1;
			}
			
			ShowAmountOrder( playerid, type, order, index );
		}
		
		case d_crime + 42:
		{
			showPlayerDialog( playerid, d_crime + 34, DIALOG_STYLE_LIST, "Заказ оружия", "\
				"cBLUE"1."cWHITE" Оружие\n\
				"cBLUE"2."cWHITE" Патроны\n\
				"cBLUE"3."cWHITE" Информация\n\
				"gbDialog"Продолжить", "Выбрать", "Отмена" );
		}
	}
	
	return 1;
}