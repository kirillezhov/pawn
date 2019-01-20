function Frac_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	switch( dialogid )
	{
		case d_fpanel :
		{
			if( !response ) return 1;
			
			new
				fid = Player[playerid][uMember] - 1,
				year,
				month,
				day,
				id;
				
			switch( listitem )
			{
				case 0:
				{
					clean:<g_big_string>;
			
					format:g_small_string( ""cWHITE"Список сотрудников "cBLUE"%s", Fraction[fid][f_name] );
					strcat( g_big_string, g_small_string );
					
					strcat( g_big_string, "\n\n"cWHITE"Онлайн:\n"cBLUE"" );
					
					foreach(new i: Player)
					{
						if( !IsLogged(i) ) continue;
						
						if( Player[i][uMember] == fid + 1 )
						{
							id = getRankId( i, fid );
						
							if( Player[i][uRank] ) format:g_string( "%s", FRank[fid][id][r_name] );
							
							format:g_small_string( "%s[%d] - %s\n", Player[i][uName], i, 
								!Player[i][uRank] ? ("Нет ранга") : g_string );
								
							strcat( g_big_string, g_small_string );
						}
					}
					
					strcat( g_big_string, "\n\n"cGRAY"" );
					
					for( new i; i < MAX_MEMBERS; i++ )
					{
						if( FMember[fid][i][m_id] )
						{
							year = month = day = 0;
							gmtime( FMember[fid][i][m_lasttime], year, month, day );
						
							if( FMember[fid][i][m_rank] ) format:g_string( "%s", FRank[fid][ FMember[fid][i][m_rank] - 1 ][r_name] );
							
							format:g_small_string( "%s[ac. %d] - %s - %02d.%02d.%d\n", FMember[fid][i][m_name], FMember[fid][i][m_id],
								!FMember[fid][i][m_rank] ? ("Нет ранга") : g_string,
								day, month, year );
								
							strcat( g_big_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_fpanel + 1, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );
				}
				
				case 1:
				{
					ShowFractionRanks( playerid, fid, d_fpanel + 2 );
				}
				
				case 2:
				{
					showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
				}
				
				case 3:
				{
					ShowFractionInfo( playerid, fid );
				}
			}
		}
		
		case d_fpanel + 1 :
		{
			format:g_small_string( ""cBLUE"%s", Fraction[Player[playerid][uMember] - 1][f_name] );
			showPlayerDialog( playerid, d_fpanel, DIALOG_STYLE_LIST, g_small_string, fpanel_dialog, "Выбрать", "Закрыть" );
		}
		
		case d_fpanel + 2 :
		{
			if( !response )
			{
				format:g_small_string( ""cBLUE"%s", Fraction[Player[playerid][uMember] - 1][f_name] );
				return showPlayerDialog( playerid, d_fpanel, DIALOG_STYLE_LIST, g_small_string, fpanel_dialog, "Выбрать", "Закрыть" );
			}
			
			new
				fid = Player[playerid][uMember] - 1;
			
			if( !PlayerLeaderFraction( playerid, fid ) )
			{
				SendClient:( playerid, C_WHITE, !NO_LEADER );
				
				ShowFractionRanks( playerid, fid, d_fpanel + 2 );
				return 1;
			}
			
			if( !listitem )
			{
				format:g_small_string( "\
					"cWHITE"Добавление ранга для\n"cBLUE"%s\n\n\
					"cWHITE"Введите название для нового ранга:", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			else
			{
				new
					rank = g_dialog_select[playerid][listitem - 1];
				
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				ShowRankSettings( playerid, fid, rank );
			
				SetPVarInt( playerid, "Fraction:Rank", rank );
			}
		}
		
		case d_fpanel + 3 :
		{
			new
				fid = Player[playerid][uMember] - 1,
				bool:flag = false;
		
			if( !response )
			{
				ShowFractionRanks( playerid, fid, d_fpanel + 2 );
				return 1;
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"Добавление ранга для\n"cBLUE"%s\n\n\
					"cWHITE"Введите название для нового ранга:\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				format:g_small_string( "\
					"cWHITE"Добавление ранга для\n"cBLUE"%s\n\n\
					"cWHITE"Введите название для нового ранга:\n\
					"gbDialogError"Превышен допустимый лимит символов.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < MAX_RANKS; i++ )
			{
				if( !FRank[fid][i][r_id] )
				{
					flag = true;
					
					clean:<FRank[fid][i][r_name]>;
					strcat( FRank[fid][i][r_name], inputtext, 32 );
					
					CreateRank( i, fid );
					
					pformat:( ""gbSuccess"Вы добавили ранг "cBLUE"%s"cWHITE". Настройте его.", FRank[fid][i][r_name] );
					psend:( playerid, C_WHITE );
					
					Fraction[fid][f_ranks]++;
					
					break;
				}
			}
			
			if( !flag ) 
			{
				SendClient:( playerid, C_WHITE, ""gbError"Превышен количественный лимит рангов для этой организации." );
				
				format:g_small_string( ""cBLUE"%s", Fraction[Player[playerid][uMember] - 1][f_name] );
				return showPlayerDialog( playerid, d_fpanel, DIALOG_STYLE_LIST, g_small_string, fpanel_dialog, "Выбрать", "Закрыть" );
			}
			
			format:g_small_string( ""cBLUE"%s", Fraction[fid][f_name] );
			showPlayerDialog( playerid, d_fpanel, DIALOG_STYLE_LIST, g_small_string, fpanel_dialog, "Выбрать", "Закрыть" );
		}
		
		case d_fpanel + 4 :
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:Rank" );
				ShowFractionRanks( playerid, fid, d_fpanel + 2 );
				return 1;
			}
			
			switch( listitem )
			{
				//Название
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"Изменение ранга "cBLUE"%s\n\n\
						"cWHITE"Введите новое название для ранга:", FRank[fid][rank][r_name] );
					
					showPlayerDialog( playerid, d_fpanel + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Зарплата
				case 1:
				{
					format:g_small_string( "\
						"cWHITE"Заработная плата для ранга "cBLUE"%s\n\
						"gbSuccess"Доступно: "cBLUE"$%d"cWHITE"\n\n\
						"cWHITE"Установите новое значение:", FRank[fid][rank][r_name], Fraction[fid][f_salary] + FRank[fid][rank][r_salary] );
					
					showPlayerDialog( playerid, d_fpanel + 6, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Инвайт
				case 2:
				{
					if( !FRank[fid][rank][r_invite] )
					{
						FRank[fid][rank][r_invite] = 1;
					}
					else
					{
						FRank[fid][rank][r_invite] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_invite", FRank[fid][rank][r_invite] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Анинвайт
				case 3:
				{
					if( !FRank[fid][rank][r_uninvite] )
					{
						FRank[fid][rank][r_uninvite] = 1;
					}
					else
					{
						FRank[fid][rank][r_uninvite] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_uninvite", FRank[fid][rank][r_uninvite] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Доска информации
				case 4:
				{
					if( !FRank[fid][rank][r_info] )
					{
						FRank[fid][rank][r_info] = 1;
					}
					else
					{
						FRank[fid][rank][r_info] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_info", FRank[fid][rank][r_info] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Радиоволна
				case 5:
				{
					if( !FRank[fid][rank][r_radio] )
					{
						FRank[fid][rank][r_radio] = 1;
					}
					else
					{
						FRank[fid][rank][r_radio] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_radio", FRank[fid][rank][r_radio] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Аттачи
				case 6:
				{
					if( !FRank[fid][rank][r_attach] )
					{
						FRank[fid][rank][r_attach] = 1;
					}
					else
					{
						FRank[fid][rank][r_attach] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_attach", FRank[fid][rank][r_attach] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Объекты
				case 7:
				{
					if( !FRank[fid][rank][r_object] )
					{
						FRank[fid][rank][r_object] = 1;
					}
					else
					{
						FRank[fid][rank][r_object] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_object", FRank[fid][rank][r_object] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Багажник
				case 8:
				{
					if( !FRank[fid][rank][r_boot] )
					{
						FRank[fid][rank][r_boot] = 1;
					}
					else
					{
						FRank[fid][rank][r_boot] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_boot", FRank[fid][rank][r_boot] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Спавн транспорта
				case 9:
				{
					if( !FRank[fid][rank][r_spawnveh] )
					{
						FRank[fid][rank][r_spawnveh] = 1;
					}
					else
					{
						FRank[fid][rank][r_spawnveh] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_spawnveh", FRank[fid][rank][r_spawnveh] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Механик
				case 10:
				{
					if( !FRank[fid][rank][r_mechanic] )
					{
						FRank[fid][rank][r_mechanic] = 1;
					}
					else
					{
						FRank[fid][rank][r_mechanic] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_mechanic", FRank[fid][rank][r_mechanic] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Медик
				case 11:
				{
					if( Fraction[fid][f_id] != FRACTION_FIRE && Fraction[fid][f_id] != FRACTION_HOSPITAL && Fraction[fid][f_id] != FRACTION_SADOC )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вашей фракции данная настройка недоступна." );
						
						ShowRankSettings( playerid, fid, rank );
						return 1;
					}
					
					if( !FRank[fid][rank][r_medic] )
					{
						FRank[fid][rank][r_medic] = 1;
					}
					else
					{
						FRank[fid][rank][r_medic] = 0;
					}
					
					UpdateRank( FRank[fid][rank][r_id], "r_medic", FRank[fid][rank][r_medic] );
					ShowRankSettings( playerid, fid, rank );
				}
				//Транспорт
				case 12:
				{
					ShowFractionVehicles( playerid, fid, rank );
				}
				//Одежда
				case 13:
				{
					ShowFractionSkins( playerid, fid, rank );
				}
				//Спавн
				case 14:
				{
					format:g_small_string( "\
						"cWHITE"Установка спавна для "cBLUE"%s\n\n\
						"cWHITE"Вы действительно желаете установить спавн в этом месте?\n\n\
						"gbDialog""cRED"Внимание! "cGRAY"Координаты определяются позицией игрока.", FRank[fid][rank][r_name] );
						
					showPlayerDialog( playerid, d_fpanel + 11, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
				//Склад
				case 15:
				{
					ShowFractionStock( playerid, fid, rank );
				}
				//Оружие
				case 16:
				{
					ShowFractionGun( playerid, fid, rank );
				}
				//Дополнительно
				case 17:
				{
					switch( Player[playerid][uMember] )
					{
						case FRACTION_POLICE :
						{
							format:g_string( 
								fpanel_add_pd,
								!FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"),
								!FRank[fid][rank][r_add][1] ? ("Нет") : ("Да"), 
								!FRank[fid][rank][r_add][2] ? ("Нет") : ("Да"),
								!FRank[fid][rank][r_add][3] ? ("Нет") : ("Да"), 
								!FRank[fid][rank][r_add][4] ? ("Нет") : ("Да"),
								!FRank[fid][rank][r_add][5] ? ("Нет") : ("Да"),
								!FRank[fid][rank][r_add][6] ? ("Нет") : ("Да") );
						}
						
						case FRACTION_FIRE: format:g_string( fpanel_add_fd, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"), !FRank[fid][rank][r_add][1] ? ("Нет") : ("Да") );
						case FRACTION_NEWS: format:g_string( fpanel_add_san, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да") );
						case FRACTION_CITYHALL: format:g_string( fpanel_add_ch, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"), !FRank[fid][rank][r_add][1] ? ("Нет") : ("Да") );
						case FRACTION_SADOC: 
						{
							format:g_string( 
								fpanel_add_sadoc, 
								!FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"), 
								!FRank[fid][rank][r_add][1] ? ("Нет") : ("Да"),
								!FRank[fid][rank][r_add][2] ? ("Нет") : ("Да") );
						}
						
						case FRACTION_HOSPITAL:
						{
							format:g_string( fpanel_add_medic, 
								!FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"), 
								!FRank[fid][rank][r_add][1] ? ("Нет") : ("Да") );
						}
						
						case FRACTION_FBI:
						{
							format:g_string( fpanel_add_fbi, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да") );
						}
						
						case FRACTION_WOOD:
						{
							format:g_string( fpanel_add_fbi, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да") );
						}
						
						default:
						{
							SendClient:( playerid, C_WHITE, !""gbError"У вашей фракции нет дополнительных настроек." );
							ShowRankSettings( playerid, fid, rank );
							return 1;
						}
					}
					
					showPlayerDialog( playerid, d_fpanel + 14, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Изменить", "Назад" );
				}
				//Установить ранг игроку
				case 18:
				{
					format:g_small_string( "\
						"cWHITE"Установить ранг "cBLUE"%s\n\n\
						"cWHITE"Введите ID игрока, которому желаете установить ранг:", FRank[fid][rank][r_name] );
				
					showPlayerDialog( playerid, d_fpanel + 37, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Удалить ранг
				case 19:
				{
					format:g_small_string( "\
						"cWHITE"Удаление ранга "cBLUE"%s\n\n\
						"cWHITE"Вы действительно желаете удалить ранг?", FRank[fid][rank][r_name] );
				
					showPlayerDialog( playerid, d_fpanel + 15, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
			}
		}
		
		case d_fpanel + 5:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"Изменение ранга "cBLUE"%s\n\n\
					"cWHITE"Введите новое название для ранга:\n\
					"gbDialogError"Неправильный формат ввода.", FRank[fid][rank][r_name] );
					
				return showPlayerDialog( playerid, d_fpanel + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				format:g_small_string( "\
					"cWHITE"Изменение ранга "cBLUE"%s\n\n\
					"cWHITE"Введите новое название для ранга:\n\
					"gbDialogError"Превышен допустимый лимит символов.", FRank[fid][rank][r_name] );
					
				return showPlayerDialog( playerid, d_fpanel + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			clean:<FRank[fid][rank][r_name]>;
			strcat( FRank[fid][rank][r_name], inputtext, 32 );
			
			mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_name` = '%e' WHERE `r_id` = %d",
				FRank[fid][rank][r_name],
				FRank[fid][rank][r_id]
			);
			
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"Вы изменили название ранга на "cBLUE"%s"cWHITE".", FRank[fid][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowRankSettings( playerid, fid, rank );
		}
		
		case d_fpanel + 6:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) == FRank[fid][rank][r_salary] )
			{
				format:g_small_string( "\
					"cWHITE"Заработная плата для ранга "cBLUE"%s\n\
					"gbSuccess"Доступно: "cBLUE"$%d"cWHITE"\n\n\
					"cWHITE"Установите новое значение:\n\n\
					"gbDialogError"Неправильный формат ввода.", FRank[fid][rank][r_name], Fraction[fid][f_salary] + FRank[fid][rank][r_salary] );
				
				return showPlayerDialog( playerid, d_fpanel + 6, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			Fraction[fid][f_salary] += FRank[fid][rank][r_salary];
			
			if( Fraction[fid][f_salary] - strval( inputtext ) < 0 )
			{
				Fraction[fid][f_salary] -= FRank[fid][rank][r_salary];
			
				format:g_small_string( "\
					"cWHITE"Заработная плата для ранга "cBLUE"%s\n\
					"gbSuccess"Доступно: "cBLUE"$%d"cWHITE"\n\n\
					"cWHITE"Установите новое значение:\n\n\
					"gbDialogError"Недостаточно доступных денег.", FRank[fid][rank][r_name], Fraction[fid][f_salary] + FRank[fid][rank][r_salary] );
				
				return showPlayerDialog( playerid, d_fpanel + 6, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			Fraction[fid][f_salary] -= strval( inputtext );
			FRank[fid][rank][r_salary] = strval( inputtext );
			
			UpdateRank( FRank[fid][rank][r_id], "r_salary", FRank[fid][rank][r_salary] );
			
			pformat:( ""gbSuccess"Вы установили заработную плату для "cBLUE"%s"cWHITE" - "cBLUE"$%d"cWHITE".", FRank[fid][rank][r_name], FRank[fid][rank][r_salary] );
			psend:( playerid, C_WHITE );
			
			ShowRankSettings( playerid, fid, rank );
		}
		
		case d_fpanel + 7:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			if( !listitem )
			{
				format:g_small_string( "\
					"cWHITE"Добавление доступного транспорта для "cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:", FRank[fid][rank][r_name] );
				
				showPlayerDialog( playerid, d_fpanel + 8, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			else
			{
				new
					index = g_dialog_select[playerid][listitem - 1];
			
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				SetPVarInt( playerid, "Fraction:Vehicle", index );
			
				format:g_small_string( "\
					"cWHITE"Удаление транспорта для "cBLUE"%s\n\n\
					"cWHITE"Вы действительно желаете убрать из доступа "cBLUE"%s"cWHITE"?", FRank[fid][rank][r_name], GetVehicleModelName( FRank[fid][rank][r_vehicles][index] ) );
					
				showPlayerDialog( playerid, d_fpanel + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
		}
		
		case d_fpanel + 8:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" ),
				bool:flag = false;
		
			if( !response )
			{
				ShowFractionVehicles( playerid, fid, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 400 || strval( inputtext ) > 611 )
			{
				format:g_small_string( "\
					"cWHITE"Добавление доступного транспорта для "cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:\n\n\
					"gbDialogError"Неправильный формат ввода.", FRank[fid][rank][r_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 8, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < 72; i++ )
			{
				if( vehicles_available[fid][i] == strval( inputtext ) )
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
					"gbDialogError"Данный транспорт недоступен для вашей организации.", FRank[fid][rank][r_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 8, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			flag = false;
			
			for( new i; i < 10; i++ )
			{
				if( !FRank[fid][rank][r_vehicles][i] )
				{
					FRank[fid][rank][r_vehicles][i] = strval( inputtext );
					flag = true;
					
					mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_vehicles` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
						FRank[fid][rank][r_vehicles][0],
						FRank[fid][rank][r_vehicles][1],
						FRank[fid][rank][r_vehicles][2],
						FRank[fid][rank][r_vehicles][3],
						FRank[fid][rank][r_vehicles][4],
						FRank[fid][rank][r_vehicles][5],
						FRank[fid][rank][r_vehicles][6],
						FRank[fid][rank][r_vehicles][7],
						FRank[fid][rank][r_vehicles][8],
						FRank[fid][rank][r_vehicles][9],
						FRank[fid][rank][r_id]
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
					"gbDialogError"Количественный лимит для ранга превышен.", FRank[fid][rank][r_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 8, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			pformat:( ""gbSuccess"Транспорт "cBLUE"%s"cWHITE" доступен для ранга "cBLUE"%s"cWHITE".", GetVehicleModelName( strval( inputtext ) ), FRank[fid][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowFractionVehicles( playerid, fid, rank );
		}
		
		case d_fpanel + 9:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" ),
				index = GetPVarInt( playerid, "Fraction:Vehicle" );
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:Vehicle" );
			
				ShowFractionVehicles( playerid, fid, rank );
				return 1;
			}
			
			FRank[fid][rank][r_vehicles][index] = 0;
			
			mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_vehicles` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
				FRank[fid][rank][r_vehicles][0],
				FRank[fid][rank][r_vehicles][1],
				FRank[fid][rank][r_vehicles][2],
				FRank[fid][rank][r_vehicles][3],
				FRank[fid][rank][r_vehicles][4],
				FRank[fid][rank][r_vehicles][5],
				FRank[fid][rank][r_vehicles][6],
				FRank[fid][rank][r_vehicles][7],
				FRank[fid][rank][r_vehicles][8],
				FRank[fid][rank][r_vehicles][9],
				FRank[fid][rank][r_id]
			);
					
			mysql_tquery( mysql, g_string );
			
			DeletePVar( playerid, "Fraction:Vehicle" );
			ShowFractionVehicles( playerid, fid, rank );
		}
	
		case d_fpanel + 10:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			if( !FRank[fid][rank][r_skin][listitem] )
			{
				FRank[fid][rank][r_skin][listitem] = 1;
			}
			else
			{
				FRank[fid][rank][r_skin][listitem] = 0;
			}
			
			mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_skin` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
				FRank[fid][rank][r_skin][0], FRank[fid][rank][r_skin][1], FRank[fid][rank][r_skin][2],
				FRank[fid][rank][r_skin][3], FRank[fid][rank][r_skin][4], FRank[fid][rank][r_skin][5],
				FRank[fid][rank][r_skin][6], FRank[fid][rank][r_skin][7], FRank[fid][rank][r_skin][8],
				FRank[fid][rank][r_skin][9], FRank[fid][rank][r_skin][10], FRank[fid][rank][r_skin][11],
				FRank[fid][rank][r_skin][12], FRank[fid][rank][r_skin][13], FRank[fid][rank][r_skin][14],
				FRank[fid][rank][r_skin][15], FRank[fid][rank][r_skin][16], FRank[fid][rank][r_skin][17],
				FRank[fid][rank][r_skin][18], FRank[fid][rank][r_skin][19],
				FRank[fid][rank][r_id]
			);
					
			mysql_tquery( mysql, g_string );
			
			ShowFractionSkins( playerid, fid, rank );
		}
		
		case d_fpanel + 11:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			GetPlayerPos( playerid, FRank[fid][rank][r_spawn][0], FRank[fid][rank][r_spawn][1], FRank[fid][rank][r_spawn][2] );
			GetPlayerFacingAngle( playerid, FRank[fid][rank][r_spawn][3] );
			
			FRank[fid][rank][r_world][0] = GetPlayerVirtualWorld( playerid );
			FRank[fid][rank][r_world][1] = GetPlayerInterior( playerid );
			
			mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_spawn` = '%f|%f|%f|%f', `r_world` = '%d|%d' WHERE `r_id` = %d",
				FRank[fid][rank][r_spawn][0],
				FRank[fid][rank][r_spawn][1],
				FRank[fid][rank][r_spawn][2],
				FRank[fid][rank][r_spawn][3],
				FRank[fid][rank][r_world][0],
				FRank[fid][rank][r_world][1],
				FRank[fid][rank][r_id]
			);
					
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"Вы установили спавн для ранга "cBLUE"%s"cWHITE".", FRank[fid][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			ShowRankSettings( playerid, fid, rank );
		}
		
		case d_fpanel + 12:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			if( !FRank[fid][rank][r_stock][listitem] )
			{
				FRank[fid][rank][r_stock][listitem] = 1;
			}
			else
			{
				FRank[fid][rank][r_stock][listitem] = 0;
			}
			
			mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_stock` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
				FRank[fid][rank][r_stock][0],
				FRank[fid][rank][r_stock][1],
				FRank[fid][rank][r_stock][2],
				FRank[fid][rank][r_stock][3],
				FRank[fid][rank][r_stock][4],
				FRank[fid][rank][r_stock][5],
				FRank[fid][rank][r_stock][6],
				FRank[fid][rank][r_stock][7],
				FRank[fid][rank][r_stock][8],
				FRank[fid][rank][r_stock][9],
				FRank[fid][rank][r_id]
			);
			mysql_tquery( mysql, g_string );
			
			ShowFractionStock( playerid, fid, rank );
		}
		
		case d_fpanel + 13:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			if( !FRank[fid][rank][r_gun][listitem] )
			{
				FRank[fid][rank][r_gun][listitem] = 1;
			}
			else
			{
				FRank[fid][rank][r_gun][listitem] = 0;
			}
		
			mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_gun` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
				FRank[fid][rank][r_gun][0],
				FRank[fid][rank][r_gun][1],
				FRank[fid][rank][r_gun][2],
				FRank[fid][rank][r_gun][3],
				FRank[fid][rank][r_gun][4],
				FRank[fid][rank][r_gun][5],
				FRank[fid][rank][r_gun][6],
				FRank[fid][rank][r_gun][7],
				FRank[fid][rank][r_gun][8],
				FRank[fid][rank][r_gun][9],
				FRank[fid][rank][r_id]
			);
			mysql_tquery( mysql, g_string );
		
			ShowFractionGun( playerid, fid, rank );
		}
		
		case d_fpanel + 14:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			if( !FRank[fid][rank][r_add][listitem] )
			{
				FRank[fid][rank][r_add][listitem] = 1;
			}
			else
			{
				FRank[fid][rank][r_add][listitem] = 0;
			}
			
			mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_add` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `r_id` = %d",
				FRank[fid][rank][r_add][0],
				FRank[fid][rank][r_add][1],
				FRank[fid][rank][r_add][2],
				FRank[fid][rank][r_add][3],
				FRank[fid][rank][r_add][4],
				FRank[fid][rank][r_add][5],
				FRank[fid][rank][r_add][6],
				FRank[fid][rank][r_add][7],
				FRank[fid][rank][r_add][8],
				FRank[fid][rank][r_add][9],
				FRank[fid][rank][r_id]
			);
			mysql_tquery( mysql, g_string );
			
			switch( Player[playerid][uMember] )
			{
				case FRACTION_POLICE:
				{
					format:g_string( 
						fpanel_add_pd,
						!FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"),
						!FRank[fid][rank][r_add][1] ? ("Нет") : ("Да"), 
						!FRank[fid][rank][r_add][2] ? ("Нет") : ("Да"),
						!FRank[fid][rank][r_add][3] ? ("Нет") : ("Да"), 
						!FRank[fid][rank][r_add][4] ? ("Нет") : ("Да"),
						!FRank[fid][rank][r_add][5] ? ("Нет") : ("Да"),
						!FRank[fid][rank][r_add][6] ? ("Нет") : ("Да") );
				}
				
				case FRACTION_FIRE: format:g_string( fpanel_add_fd, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"), !FRank[fid][rank][r_add][1] ? ("Нет") : ("Да") );
				case FRACTION_NEWS: format:g_string( fpanel_add_san, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да") );
				case FRACTION_CITYHALL: format:g_string( fpanel_add_ch, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"), !FRank[fid][rank][r_add][1] ? ("Нет") : ("Да") );
				case FRACTION_SADOC: 
				{
					format:g_string( 
						fpanel_add_sadoc, 
						!FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"), 
						!FRank[fid][rank][r_add][1] ? ("Нет") : ("Да"),
						!FRank[fid][rank][r_add][2] ? ("Нет") : ("Да") );
				}
				
				case FRACTION_HOSPITAL:
				{
					format:g_string( fpanel_add_medic, 
						!FRank[fid][rank][r_add][0] ? ("Нет") : ("Да"), 
						!FRank[fid][rank][r_add][1] ? ("Нет") : ("Да") );
				}
				
				case FRACTION_FBI:
				{
					format:g_string( fpanel_add_fbi, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да") );
				}
						
				case FRACTION_WOOD:
				{
					format:g_string( fpanel_add_fbi, !FRank[fid][rank][r_add][0] ? ("Нет") : ("Да") );
				}
			}
				
			showPlayerDialog( playerid, d_fpanel + 14, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Изменить", "Назад" );
		}
		
		case d_fpanel + 15:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
		
			mysql_format:g_small_string( "DELETE FROM `"DB_RANKS"` WHERE `r_id` = %d LIMIT 1", FRank[fid][rank][r_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uRank` = 0 WHERE `uRank` = %d AND `uMember` = %d",
				FRank[fid][rank][r_id],
				Fraction[fid][f_id] );
			mysql_tquery( mysql, g_string );
			
			foreach(new i : Player)
			{
				if( Player[i][uMember] == Fraction[fid][f_id] && Player[i][uRank] == FRank[fid][rank][r_id] )
					Player[i][uRank] = 0;
			}
			
			Fraction[fid][f_ranks]--;
			
			ClearDataRank( fid, rank );			
			ShowFractionRanks( playerid, fid, d_fpanel + 2 );
		}
		
		case d_fpanel + 16:
		{
			if( !response )
			{
				format:g_small_string( ""cBLUE"%s", Fraction[Player[playerid][uMember] - 1][f_name] );
				return showPlayerDialog( playerid, d_fpanel, DIALOG_STYLE_LIST, g_small_string, fpanel_dialog, "Выбрать", "Закрыть" );
			}
			
			new
				fid = Player[playerid][uMember] - 1,
				rank;
			
			switch( listitem )
			{
				//Список транспорта
				case 0: FractionVehicles( playerid, fid, 1 );
				
				//Приобретение транспорта
				case 1:
				{
					if( !PlayerLeaderFraction( playerid, fid ) )
					{
						SendClient:( playerid, C_WHITE, !NO_LEADER );
						return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
					}
				
					if( Fraction[fid][f_amountveh] >= Fraction[fid][f_vehicles] )
					{
						pformat:( ""gbError"Количественный лимит транспорта для вашей фракции превышен [%d/%d].", Fraction[fid][f_amountveh], Fraction[fid][f_vehicles] );
						psend:( playerid, C_WHITE );
					
						return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
					}
				
					format:g_small_string( "\
						"cWHITE"Приобретение транспорта для фракции\n\
						"cBLUE"%s\n\n\
						"cWHITE"Укажите номер модели транспорта:", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_fpanel + 22, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Заспавнить траснпорт
				case 2:
				{
					if( PlayerLeaderFraction( playerid, fid ) ) goto next;
	
					if( !Player[playerid][uRank] )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
						return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
					}
					
					rank = getRankId( playerid, fid );
						
					if( !FRank[fid][rank][r_spawnveh] )
					{
						SendClient:( playerid, C_WHITE, !NO_ACCESS );
						return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
					}
					
					next:
				
					format:g_small_string( "\
						"cWHITE"Вернуть транспорт фракции\n\
						"cBLUE"%s "cWHITE" на парковочное место\n\n\
						"cWHITE"Укажите ID транспорта в /dl:", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_fpanel + 27, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Заспавнить весь транспорт
				case 3:
				{
					cmd_fixcarall( playerid );
				}
				//Припарковать транспорт фракции
				case 4:
				{
					format:g_small_string( "\
						"cWHITE"Припарковать транспорт фракции\n\
						"cBLUE"%s\n\n\
						"cWHITE"Укажите ID транспорта в /dl:", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_fpanel + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Удалить транспорт
				case 5:
				{
					if( !PlayerLeaderFraction( playerid, fid ) )
					{
						SendClient:( playerid, C_WHITE, !NO_LEADER );
						return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
					}
				
					format:g_small_string( "\
						"cWHITE"Удаление транспорта фракции\n\
						"cBLUE"%s\n\n\
						"cWHITE"Укажите ID транспорта в /dl:", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_fpanel + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
		}
		
		case d_fpanel + 17:
		{
			showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
		}
		
		case d_fpanel + 18:
		{
			if( !response ) return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
			
			FractionVehicles( playerid, Player[playerid][uMember] - 1, 2 );
		}
		
		case d_fpanel + 19:
		{
			FractionVehicles( playerid, Player[playerid][uMember] - 1, 1 );
		}
		
		case d_fpanel + 20:
		{
			if( !response )
			{
				FractionVehicles( playerid, Player[playerid][uMember] - 1, 1 );
				return 1;
			}
			
			FractionVehicles( playerid, Player[playerid][uMember] - 1, 3 );
		}
		
		case d_fpanel + 21:
		{
			FractionVehicles( playerid, Player[playerid][uMember] - 1, 2 );
		}
		
		case d_fpanel + 22:
		{
			if( !response ) return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
		
			new
				fid = Player[playerid][uMember] - 1,
				bool:flag = false;
		
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 400 || strval( inputtext ) > 611 || VehicleInfo[strval( inputtext ) - 400][v_fracspawn] == INVALID_PARAM )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 22, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		
			for( new i; i < 72; i++ )
			{
				if( !vehicles_available[fid][i] ) continue;
			
				if( vehicles_available[fid][i] == strval( inputtext ) )
				{
					flag = true;					
					break;
				}
			}
			
			if( flag == false )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:\n\
					"gbDialogError"Данный транспорт недоступен для этой организации.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 22, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		
			SetPVarInt( playerid, "Fraction:BuyVehicle", strval(inputtext) );
			ShowFracVehicleInformation( playerid, strval(inputtext), d_fpanel + 23, "Далее", "Назад" );
		}
		
		case d_fpanel + 23:
		{
			new
				fid = Player[playerid][uMember] - 1,
				model = GetPVarInt( playerid, "Fraction:BuyVehicle" );
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:BuyVehicle" );
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 22, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			format:g_small_string( "\
				"cWHITE"Приобретение транспорта для фракции\n\
				"cBLUE"%s\n\n\
				"cWHITE"Укажите первый цвет для "cBLUE"%s"cWHITE":", Fraction[fid][f_name], GetVehicleModelName( model ) );
				
			showPlayerDialog( playerid, d_fpanel + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_fpanel + 24:
		{
			new
				fid = Player[playerid][uMember] - 1,
				model = GetPVarInt( playerid, "Fraction:BuyVehicle" );
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:BuyVehicle" );
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите номер модели транспорта:", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 22, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 255 )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите первый цвет для "cBLUE"%s"cWHITE":\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name], GetVehicleModelName( model ) );
					
				return showPlayerDialog( playerid, d_fpanel + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Fraction:Color1Vehicle", strval( inputtext ) );
			format:g_small_string( "\
				"cWHITE"Приобретение транспорта для фракции\n\
				"cBLUE"%s\n\n\
				"cWHITE"Укажите второй цвет для "cBLUE"%s"cWHITE":\n\
				"gbDialog"Первый цвет: %d", Fraction[fid][f_name], GetVehicleModelName( model ), strval( inputtext ) );
					
			showPlayerDialog( playerid, d_fpanel + 25, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_fpanel + 25:
		{
			new
				fid = Player[playerid][uMember] - 1,
				model = GetPVarInt( playerid, "Fraction:BuyVehicle" ),
				color_1 = GetPVarInt( playerid, "Fraction:Color1Vehicle" );
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:Color1Vehicle" );
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите первый цвет для "cBLUE"%s"cWHITE":", Fraction[fid][f_name], GetVehicleModelName( model ) );
					
				return showPlayerDialog( playerid, d_fpanel + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 255 )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите второй цвет для "cBLUE"%s"cWHITE":\n\
					"gbDialog"Первый цвет: %d\n\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name], GetVehicleModelName( model ), color_1 );
						
				return showPlayerDialog( playerid, d_fpanel + 25, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Fraction:Color2Vehicle", strval( inputtext ) );
			format:g_small_string( "\
				"cWHITE"Приобретение транспорта для фракции\n\
				"cBLUE"%s\n\n\
				"cWHITE"Введите желаемый гос. номер для "cBLUE"%s"cWHITE":\n\
				"gbDialog"Используйте цифры и заглавные буквы английского алфавита.", Fraction[fid][f_name], GetVehicleModelName( model ) );
						
			showPlayerDialog( playerid, d_fpanel + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_fpanel + 26:
		{
			new
				fid = Player[playerid][uMember] - 1,
				model = GetPVarInt( playerid, "Fraction:BuyVehicle" ),
				color_1 = GetPVarInt( playerid, "Fraction:Color1Vehicle" ),
				color_2 = GetPVarInt( playerid, "Fraction:Color2Vehicle" ),
				spawnveh = VehicleInfo[model - 400][v_fracspawn],
				index = random(3),
				bool:flag = false,
				car,
				siren,
				number[ 10 ];
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:Color2Vehicle" );
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите второй цвет для "cBLUE"%s"cWHITE":\n\
					"gbDialog"Первый цвет: %d", Fraction[fid][f_name], GetVehicleModelName( model ), GetPVarInt( playerid, "Fraction:Color1Vehicle" ) );
						
				return showPlayerDialog( playerid, d_fpanel + 25, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите желаемый гос. номер для "cBLUE"%s"cWHITE":\n\
					"gbDialog"Используйте цифры и заглавные буквы английского алфавита.\n\n\
					"gbDialogError"Поля для ввода пустое.", Fraction[fid][f_name], GetVehicleModelName( model ) );
							
				return showPlayerDialog( playerid, d_fpanel + 26, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) != 7 )
			{
				format:g_string( "\
					"cWHITE"Приобретение транспорта для фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите желаемый гос. номер для "cBLUE"%s"cWHITE":\n\
					"gbDialog"Используйте цифры и заглавные буквы английского алфавита.\n\n\
					"gbDialogError"Номер должен иметь 7 позиций.", Fraction[fid][f_name], GetVehicleModelName( model ) );
							
				return showPlayerDialog( playerid, d_fpanel + 26, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
			}
			
			for( new i; i < Fraction[fid][f_vehicles]; i++ )
			{
				if( FVehicle[fid][i][v_number][0] == EOS )
				{
				
					if( Player[playerid][uMember] != FRACTION_NEWS )
						siren = VehicleInfo[model - 400][v_siren];
					
					FVehicle[fid][i][v_id] = CreateVehicle( model, vehicles_spawn[spawnveh][index][0], vehicles_spawn[spawnveh][index][1], vehicles_spawn[spawnveh][index][2], vehicles_spawn[spawnveh][index][3], color_1, color_2, INVALID_PARAM, siren );
					car = FVehicle[fid][i][v_id];
					
					clean:<FVehicle[fid][i][v_number]>;			
					strcat( FVehicle[fid][i][v_number], inputtext, 10 );
										
					ClearVehicleData( car );
					format( number, sizeof number, "%s", FVehicle[fid][i][v_number] );
					
					flag = true;
					break;
				}
			}
			
			if( !flag )
			{
				SendClient:( playerid, C_WHITE, ""gbSuccess"Количественный лимит для Вашей организации превышен." );
				return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
			}
			
			Vehicle[car][vehicle_user_id] = INVALID_PARAM;
			Vehicle[car][vehicle_model] = model;
			Vehicle[car][vehicle_member] = Player[playerid][uMember]; 
					
			Vehicle[car][vehicle_pos][0] = vehicles_spawn[spawnveh][index][0];
			Vehicle[car][vehicle_pos][1] = vehicles_spawn[spawnveh][index][1];
			Vehicle[car][vehicle_pos][2] = vehicles_spawn[spawnveh][index][2];
			Vehicle[car][vehicle_pos][3] = vehicles_spawn[spawnveh][index][3];
					
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
					
			Fraction[fid][f_amountveh]++;
			
			pformat:( ""gbSuccess"Вы приобрели "cBLUE"%s %s"cWHITE" для своей организации. %s", VehicleInfo[model - 400][v_type], GetVehicleModelName( model ), vehicles_description[spawnveh] );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Fraction:BuyVehicle" );
			DeletePVar( playerid, "Fraction:Color1Vehicle" );
			DeletePVar( playerid, "Fraction:Color2Vehicle" );
			
			showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
		}
		
		case d_fpanel + 27:
		{
			if( !response ) return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
			
			new
				fid = Player[playerid][uMember] - 1;
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"Вернуть транспорт фракции\n\
					"cBLUE"%s "cWHITE" на парковочное место\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 27, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_member] != Player[playerid][uMember] )
			{
				format:g_small_string( "\
					"cWHITE"Вернуть транспорт фракции\n\
					"cBLUE"%s "cWHITE" на парковочное место\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Данный транспорт не принадлежит Вашей организации.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 27, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( IsVehicleOccupied( strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"Вернуть транспорт фракции\n\
					"cBLUE"%s "cWHITE" на парковочное место\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Данный транспорт используется.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 27, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
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
			
			showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
		}
		//Припарковать транспорт
		case d_fpanel + 28:
		{
			if( !response ) return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
			
			new
				fid = Player[playerid][uMember] - 1;
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"Припарковать транспорт фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_member] != Player[playerid][uMember] )
			{
				format:g_small_string( "\
					"cWHITE"Припарковать транспорт фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Данный транспорт не принадлежит Вашей организации.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( !IsPlayerInVehicle( playerid, strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"Припарковать транспорт фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Для совершения данного действия Вы должны находиться в этом транспорте.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 28, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			Vehicle[strval( inputtext )][vehicle_world] = GetVehicleVirtualWorld( strval( inputtext ) );
			
			if( Vehicle[strval( inputtext )][vehicle_world] )
				Vehicle[strval( inputtext )][vehicle_int] = 1;
			else
				Vehicle[strval( inputtext )][vehicle_int] = 0;
				
			SetVehiclePark( strval( inputtext ) );
			
			pformat:( ""gbSuccess"Вы успешно припарковали транспорт - "cBLUE"%s[%d]"cWHITE".", GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ), strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
		}
		
		case d_fpanel + 29:
		{
			if( !response )
			{
				DeletePVar( playerid, "Fraction:VId" );
				return 1;
			}
			
			new
				vid = GetPVarInt( playerid, "Fraction:VId" );
			
			if( !IsPlayerInVehicle( playerid, vid ) && GetVehicleModel( vid ) != 591 && GetVehicleModel( vid ) != 584 )
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
				
			DeletePVar( playerid, "Fraction:VId" );
		}
		
		case d_fpanel + 30:
		{
			if( !response ) return showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
		
			new
				fid = Player[playerid][uMember] - 1;
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 2000 )
			{
				format:g_small_string( "\
					"cWHITE"Удаление транспорта фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Vehicle[strval( inputtext )][vehicle_member] != Player[playerid][uMember] )
			{
				format:g_small_string( "\
					"cWHITE"Удаление транспорта фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:\n\
					"gbDialogError"Данный транспорт не принадлежит Вашей организации.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Fraction:VId", strval( inputtext ) );			
			
			format:g_small_string( "\
				"cWHITE"Удаление транспорта фракции\n\
				"cBLUE"%s\n\n\
				"cWHITE"Вы действительно желаете удалить "cBLUE"%s[%d] гос. номер %s"cWHITE"?",
				Fraction[fid][f_name], 
				GetVehicleModelName( Vehicle[strval( inputtext )][vehicle_model] ),
				strval( inputtext ),
				Vehicle[strval( inputtext )][vehicle_number]
			);
			showPlayerDialog( playerid, d_fpanel + 31, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		}
		
		case d_fpanel + 31:
		{
			new
				fid = Player[playerid][uMember] - 1,
				vid = GetPVarInt( playerid, "Fraction:VId" );
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:VId" );
			
				format:g_small_string( "\
					"cWHITE"Удаление транспорта фракции\n\
					"cBLUE"%s\n\n\
					"cWHITE"Укажите ID транспорта в /dl:", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 30, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < Fraction[fid][f_vehicles]; i++ )
			{
				if( FVehicle[fid][i][v_id] == vid )
				{
					FVehicle[fid][i][v_id] = 0;
					FVehicle[fid][i][v_number][0] = EOS;
					break;
				}
			}
			
			Fraction[fid][f_amountveh]--;
			
			mysql_format:g_string( "DELETE FROM `"DB_VEHICLES"` WHERE `vehicle_id` = %d", Vehicle[vid][vehicle_id] );
			mysql_tquery( mysql, g_string );
			
			mysql_format:g_string( "DELETE FROM `"DB_ITEMS"` WHERE `item_type_id` = %d AND `item_type` = 2", Vehicle[vid][vehicle_id] );	
			mysql_tquery( mysql, g_string );

			pformat:( ""gbSuccess""cBLUE"%s"cWHITE" успешно удален.", GetVehicleModelName( GetVehicleModel( vid ) ) );
			psend:( playerid, C_WHITE );
			
			DestroyVehicleEx( vid );
			DeletePVar( playerid, "Fraction:VId" );
			
			showPlayerDialog( playerid, d_fpanel + 16, DIALOG_STYLE_TABLIST_HEADERS, " ", fpanel_vehicles, "Выбрать", "Назад" );
		}
		
		case d_fpanel + 32:
		{
			if( !response )
			{
				format:g_small_string( ""cBLUE"%s", Fraction[Player[playerid][uMember] - 1][f_name] );
				return showPlayerDialog( playerid, d_fpanel, DIALOG_STYLE_LIST, g_small_string, fpanel_dialog, "Выбрать", "Закрыть" );
			}
			
			new
				fid = Player[playerid][uMember] - 1;
			
			switch( listitem )
			{
				case 0:
				{
					if( !PlayerLeaderFraction( playerid, fid ) )
					{
						SendClient:( playerid, C_WHITE, !NO_LEADER );
						ShowFractionInfo( playerid, fid );
						return 1;
					}
					
					new
						bool:flag = false;
						
					for( new i; i < MAX_POSTS; i++ )
					{
						if( !FInfo[fid][i][i_id] )
						{
							SetPVarInt( playerid, "Fraction:Post", i );
							FInfo[fid][i][i_id] = 1;
						
							flag = true;
							break;
						}
					}
					
					if( !flag )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Превышен количественный лимит новостей." );
						ShowFractionInfo( playerid, fid );
						return 1;
					}
					
					showPlayerDialog( playerid, d_fpanel + 33, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Добавление новости\n\n\
						"cWHITE"Укажите тему новой новости:\n\
						"gbDialog"Максимальное количество символов - 32.", "Далее", "Назад" );
				}
				
				default:
				{
					SetPVarInt( playerid, "Fraction:Post", g_dialog_select[playerid][listitem - 1] );
					g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
						
					new
						post[2048];
						
					format:g_small_string( ""cWHITE"Тема: "cBLUE"%s"cWHITE"\n", FInfo[fid][GetPVarInt( playerid, "Fraction:Post")][i_theme] );
					strcat( post, g_small_string );
					
					format:g_small_string( ""cWHITE"Составитель: "cBLUE"%s"cWHITE"\n\n", FInfo[fid][GetPVarInt( playerid, "Fraction:Post")][i_name] );
					strcat( post, g_small_string );

					format:g_string( "%s", FInfo[fid][GetPVarInt( playerid, "Fraction:Post")][i_text] );
					strcat( post, g_string );
					
					showPlayerDialog( playerid, d_fpanel + 35, DIALOG_STYLE_MSGBOX, " ", post, "Удалить", "Назад" );
				}
			}
		}
		
		case d_fpanel + 33:
		{
			new
				fid = Player[playerid][uMember] - 1,
				index = GetPVarInt( playerid, "Fraction:Post" );
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:Post" );
				ShowFractionInfo( playerid, fid );
				return 1;
			}
			
			if( inputtext[0] == EOS )
			{
				return showPlayerDialog( playerid, d_fpanel + 33, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Добавление новости\n\n\
					"cWHITE"Укажите тему новой новости:\n\
					"gbDialog"Максимальное количество символов - 32.\n\n\
					"gbDialogError"Поля для ввода пустое.", "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 32 )
			{
				return showPlayerDialog( playerid, d_fpanel + 33, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Добавление новости\n\n\
					"cWHITE"Укажите тему новой новости:\n\
					"gbDialog"Максимальное количество символов - 32.\n\n\
					"gbDialogError"Превышен допустимый лимит символов.", "Далее", "Назад" );
			}
			
			clean:<FInfo[fid][index][i_theme]>;
			strcat( FInfo[fid][index][i_theme], inputtext, 32 );
			
			FInfo[fid][index][i_text][0] = EOS;
			
			format:g_string( add_news, FInfo[fid][index][i_theme] );
			showPlayerDialog( playerid, d_fpanel + 34, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
		}
		
		case d_fpanel + 34:
		{
			new
				fid = Player[playerid][uMember] - 1,
				index = GetPVarInt( playerid, "Fraction:Post" );
		
			if( !response )
			{
				clean:<FInfo[fid][index][i_theme]>;
				clean:<FInfo[fid][index][i_text]>;
			
				return showPlayerDialog( playerid, d_fpanel + 33, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Добавление новости\n\n\
					"cWHITE"Укажите тему новой новости:\n\
					"gbDialog"Максимальное количество символов - 32.", "Далее", "Назад" );
			}
			
			if( FInfo[fid][index][i_text][0] == EOS )
			{
				if( inputtext[0] == EOS )
				{
					format:g_string( add_news, FInfo[fid][index][i_theme] );
					strcat( g_string, "\n\n"gbDialogError"Поле для ввода пустое." );
					
					return showPlayerDialog( playerid, d_fpanel + 34, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
				}
				else if( strlen( inputtext ) > 128 )
				{
					format:g_string( add_news, FInfo[fid][index][i_theme] );
					strcat( g_string, "\n\n"gbDialogError"Превышен допустимый лимит символов в строке." );
					
					return showPlayerDialog( playerid, d_fpanel + 34, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
				}
				
				strcat( FInfo[fid][index][i_text], inputtext, 1024 );
				
				format:g_big_string( add_news, FInfo[fid][index][i_theme] );
				strcat( g_big_string, "\n\n"cBLUE"Текст новости:" );
				
				format:g_string( "\n"cWHITE"%s", FInfo[fid][index][i_text] );
				strcat( g_big_string, g_string );
				
				return showPlayerDialog( playerid, d_fpanel + 34, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
			}
			else
			{
				if( inputtext[0] != EOS )
				{
					strcat( FInfo[fid][index][i_text], "\n", 1024 );
					strcat( FInfo[fid][index][i_text], inputtext, 1024 );
				
					format:g_big_string( add_news, FInfo[fid][index][i_theme] );
					strcat( g_big_string, "\n\n"cBLUE"Текст новости:" );
					
					format:g_string( "\n"cWHITE"%s", FInfo[fid][index][i_text] );
					strcat( g_big_string, g_string );
					
					return showPlayerDialog( playerid, d_fpanel + 34, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
				}
			}
			
			FInfo[fid][index][i_fracid] = Player[playerid][uMember];
			
			clean:<FInfo[fid][index][i_name]>;
			strcat( FInfo[fid][index][i_name], Player[playerid][uName], 26 );
			
			mysql_format:g_big_string( "INSERT INTO `"DB_FRAC_INFO"` \
				( `i_fracid`, `i_name`, `i_theme`, `i_text` ) VALUES \
				( '%d', '%s', '%e', '%e' )",
				FInfo[fid][index][i_fracid],
				FInfo[fid][index][i_name],
				FInfo[fid][index][i_theme],
				FInfo[fid][index][i_text]
			);
			mysql_tquery( mysql, g_big_string, "InsertFracInfo", "dd", fid, index );
			
			format:g_small_string( ""FRACTION_PREFIX" %s[%d] добавил новость на тему "cBLUE"%s"cDARKGRAY".", Player[playerid][uName], playerid, FInfo[fid][index][i_theme] );
			
			foreach(new i: Player)
			{
				if( !IsLogged(i) ) continue;
				
				if( Player[playerid][uMember] == Player[i][uMember] )
				{
					SendClient:( i, C_DARKGRAY, g_small_string );
				}
			}
			
			DeletePVar( playerid, "Fraction:Post" );
			ShowFractionInfo( playerid, fid );
		}
		
		case d_fpanel + 35:
		{
			new
				fid = Player[playerid][uMember] - 1,
				index = GetPVarInt( playerid, "Fraction:Post" ),
				rank;
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:Post" );
				ShowFractionInfo( playerid, fid );
				return 1;
			}
			
			if( Player[playerid][uRank] )
			{	
				rank = getRankId( playerid, fid );
			
				if( !FRank[fid][rank][r_info] )
				{
					DeletePVar( playerid, "Fraction:Post" );
				
					SendClient:( playerid, C_WHITE, !NO_ACCESS );
					ShowFractionInfo( playerid, fid );
				}
				else
				{
					format:g_small_string( "\
						"cBLUE"Удаление новости\n\n\
						"cWHITE"Вы действительно желаете удалить новость "cBLUE"%s"cWHITE"?", FInfo[fid][index][i_theme] );
						
					showPlayerDialog( playerid, d_fpanel + 36, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
			}
			else
			{
				DeletePVar( playerid, "Fraction:Post" );
				
				SendClient:( playerid, C_WHITE, !NO_ACCESS );
				ShowFractionInfo( playerid, fid );
			}
		}
		
		case d_fpanel + 36:
		{
			new
				fid = Player[playerid][uMember] - 1,
				index = GetPVarInt( playerid, "Fraction:Post" );
		
			if( !response )
			{
				DeletePVar( playerid, "Fraction:Post" );
				ShowFractionInfo( playerid, fid );
				return 1;
			}
			
			mysql_format:g_string( "DELETE FROM `"DB_FRAC_INFO"` WHERE `i_id` = %d", FInfo[fid][index][i_id] );
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"Новость "cBLUE"%s"cWHITE" успешно удалена.", FInfo[fid][index][i_theme] );
			psend:( playerid, C_WHITE );
			
			FInfo[fid][index][i_id] = 
			FInfo[fid][index][i_fracid] = 0;
			
			FInfo[fid][index][i_theme][0] =
			FInfo[fid][index][i_text][0] = EOS;
			
			DeletePVar( playerid, "Fraction:Post" );
			ShowFractionInfo( playerid, fid );
		}
		//Установить ранг игроку
		case d_fpanel + 37:
		{
			new
				fid = Player[playerid][uMember] - 1,
				rank = GetPVarInt( playerid, "Fraction:Rank" );
		
			if( !response )
			{
				ShowRankSettings( playerid, fid, rank );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || !IsLogged( strval( inputtext ) ) )
			{
				format:g_small_string( "\
					"cWHITE"Установить ранг "cBLUE"%s\n\n\
					"cWHITE"Введите ID игрока, которому желаете установить ранг:\n\n\
					"gbDialogError"Некорректный ID игрока.", FRank[fid][rank][r_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 37, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[strval( inputtext )][uMember] != Player[playerid][uMember] )
			{
				format:g_small_string( "\
					"cWHITE"Установить ранг "cBLUE"%s\n\n\
					"cWHITE"Введите ID игрока, которому желаете установить ранг:\n\n\
					"gbDialogError"Игрок не состоит в Вашей организации.", FRank[fid][rank][r_name] );
				
				return showPlayerDialog( playerid, d_fpanel + 37, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( FMember[fid][i][m_id] == Player[strval( inputtext )][uID] )
				{
					FMember[fid][i][m_rank] = rank;
					
					clean:<FMember[fid][i][m_name]>;
					strcat( FMember[fid][i][m_name], Player[strval( inputtext )][uName], 32 );
					
					break;
				}				
			}
			
			Player[strval( inputtext )][uRank] = FRank[fid][rank][r_id];
			UpdatePlayer( strval( inputtext ), "uRank", FRank[fid][rank][r_id] );
			
			pformat:( ""gbSuccess"Вы установили игроку "cBLUE"%s"cWHITE" ранг "cBLUE"%s"cWHITE".", Player[strval( inputtext )][uName], FRank[fid][rank][r_name] );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"%s установил Вам ранг "cBLUE"%s"cWHITE".", Player[playerid][uName], FRank[fid][rank][r_name] );
			psend:( strval( inputtext ), C_WHITE );
			
			ShowRankSettings( playerid, fid, rank );
		}
		
		case d_fpanel + 38:
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				DeletePVar( playerid, "Fraction:PlayerID" );
				return 1;
			}
			
			new
				id = GetPVarInt( playerid, "Fraction:PlayerID" ),
				fid = Player[playerid][uMember] - 1,
				rank;
			
			if( !listitem )
			{
				for( new i; i < MAX_MEMBERS; i++ )
				{
					if( FMember[fid][i][m_id] == Player[id][uID] )
					{
						FMember[fid][i][m_rank] = 0;
						
						clean:<FMember[fid][i][m_name]>;
						strcat( FMember[fid][i][m_name], Player[id][uName], 32 );
						
						break;
					}				
				}
				
				Player[id][uRank] = 0;
				UpdatePlayer( id, "uRank", Player[id][uRank] );
				
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
					if( FMember[fid][i][m_id] == Player[id][uID] )
					{
						FMember[fid][i][m_rank] = rank;
						
						clean:<FMember[fid][i][m_name]>;
						strcat( FMember[fid][i][m_name], Player[id][uName], 32 );
						
						break;
					}				
				}
				
				Player[id][uRank] = FRank[fid][rank][r_id];
				UpdatePlayer( id, "uRank", Player[id][uRank] );
				
				pformat:( ""gbSuccess"Вы установили игроку "cBLUE"%s"cWHITE" ранг "cBLUE"%s"cWHITE".", Player[id][uName], FRank[fid][rank][r_name] );
				psend:( playerid, C_WHITE );
				
				pformat:( ""gbSuccess"%s установил Вам ранг "cBLUE"%s"cWHITE".", Player[playerid][uName], FRank[fid][rank][r_name] );
				psend:( id, C_WHITE );
			}
			
			g_player_interaction{playerid} = 0;
			DeletePVar( playerid, "Fraction:PlayerID" );
		}
		
		case d_fpanel + 39:
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				DeletePVar( playerid, "Fraction:PlayerID" );
				return 1;
			}
			
			new
				sendid = GetPVarInt( playerid, "Fraction:PlayerID" ),
				fid = Player[playerid][uMember] - 1,
				rank;
			
			if( !listitem )
			{
				SetPVarInt( sendid, "Fraction:RankID", INVALID_PARAM );
			
				pformat:( ""gbDefault"Вы отправили предложение "cBLUE"%s[%d]"cWHITE" о вступлении в "cBLUE"%s"cWHITE".", Player[sendid][uName], sendid, Fraction[fid][f_name] );
				psend:( playerid, C_WHITE );
			
				format:g_small_string( "\
					"gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" предлагает Вам\n\
					вступить в "cBLUE"%s"cWHITE". Вы согласны?", Player[playerid][uName], playerid, Fraction[fid][f_name] );
					
				showPlayerDialog( sendid, d_fpanel + 40, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			else
			{
				rank = g_dialog_select[playerid][listitem - 1];
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				
				SetPVarInt( sendid, "Fraction:RankID", rank );
			
				pformat:( ""gbDefault"Вы отправили предложение "cBLUE"%s[%d]"cWHITE" о вступлении с рангом "cBLUE"%s"cWHITE".", Player[sendid][uName], sendid, FRank[fid][rank][r_name] );
				psend:( playerid, C_WHITE );
			
				format:g_small_string( "\
					"gbDefault"Игрок "cBLUE"%s[%d]"cWHITE" предлагает Вам\n\
					вступить в "cBLUE"%s"cWHITE" c рангом "cBLUE"%s"cWHITE". Вы согласны?", 
					Player[playerid][uName],
					playerid,
					Fraction[fid][f_name],
					FRank[fid][rank][r_name] );
					
				showPlayerDialog( sendid, d_fpanel + 40, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			}
			
			SetPVarInt( sendid, "Fraction:PlayerID", playerid );
			SetPVarInt( sendid, "Fraction:ID", fid );
			
			g_player_interaction{sendid} = 1;
		}
		
		case d_fpanel + 40:
		{
			new
				leaderid = GetPVarInt( playerid, "Fraction:PlayerID" ),
				fid = GetPVarInt( playerid, "Fraction:ID" ),
				rank = GetPVarInt( playerid, "Fraction:RankID" ),
				member = INVALID_PARAM;
		
			if( !response )
			{
				pformat:( ""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от вступления в "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, Fraction[fid][f_name] );
				psend:( leaderid, C_WHITE );
				
				pformat:( ""gbError"Вы отказались от вступления в "cBLUE"%s"cWHITE".", Fraction[fid][f_name] );
				psend:( playerid, C_WHITE );
				
				g_player_interaction{leaderid} =
				g_player_interaction{playerid} = 0;
				
				DeletePVar( playerid, "Fraction:PlayerID" );
				DeletePVar( leaderid, "Fraction:PlayerID" );
				
				DeletePVar( playerid, "Fraction:ID" );
				DeletePVar( playerid, "Fraction:RankID" );
				
				return 1;
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( !FMember[fid][i][m_id] )
				{
					member = i;
					break;
				}
			}
			
			if( member == INVALID_PARAM )
			{
				pformat:( ""gbError"Игрок "cBLUE"%s[%d]"cWHITE" не может вступить в "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, Fraction[fid][f_name] );
				psend:( leaderid, C_WHITE );
				
				pformat:( ""gbError"Вы не можете вступить в "cBLUE"%s"cWHITE".", Fraction[fid][f_name] );
				psend:( playerid, C_WHITE );
				
				g_player_interaction{leaderid} =
				g_player_interaction{playerid} = 0;
				
				DeletePVar( playerid, "Fraction:PlayerID" );
				DeletePVar( leaderid, "Fraction:PlayerID" );
				
				DeletePVar( playerid, "Fraction:ID" );
				DeletePVar( playerid, "Fraction:RankID" );
				
				return 1;
			}
			
			FMember[fid][member][m_id] = Player[playerid][uID];
			
			clean:<FMember[fid][member][m_name]>;
			strcat( FMember[fid][member][m_name], Player[playerid][uName], 32 );
			
			FMember[fid][member][m_lasttime] = Player[playerid][uLastTime];
			
			Fraction[fid][f_members]++;
			
			pformat:( ""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" присоединился к "cBLUE"%s"cWHITE".", Player[playerid][uName], playerid, Fraction[fid][f_name] );
			psend:( leaderid, C_WHITE );
			
			switch( rank )
			{
				case INVALID_PARAM :
				{
					pformat:( ""gbSuccess"Вы присоединились к организации "cBLUE"%s"cWHITE" без ранга.", Fraction[fid][f_name] );
					psend:( playerid, C_WHITE );
				
					Player[playerid][uMember] = fid + 1;
					Player[playerid][uRank] = 0;
				}
				
				default :
				{
					pformat:( ""gbSuccess"Вы присоединились к организации "cBLUE"%s"cWHITE" с рангом "cBLUE"%s"cWHITE".", Fraction[fid][f_name], FRank[fid][rank][r_name] );
					psend:( playerid, C_WHITE );
					
					FMember[fid][member][m_rank] = rank;
				
					Player[playerid][uMember] = fid + 1;
					Player[playerid][uRank] = FRank[fid][rank][r_id];
				}
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uMember` = %d, `uRank` = %d WHERE `uID` = %d",
				Player[playerid][uMember],
				Player[playerid][uRank],
				Player[playerid][uID]
			);
			mysql_tquery( mysql, g_string );
			
			g_player_interaction{leaderid} =
			g_player_interaction{playerid} = 0;
				
			DeletePVar( playerid, "Fraction:PlayerID" );
			DeletePVar( leaderid, "Fraction:PlayerID" );
				
			DeletePVar( playerid, "Fraction:ID" );
			DeletePVar( playerid, "Fraction:RankID" );
		}
		
		case d_fpanel + 41:
		{
			if( !response ) 
			{
				g_player_interaction{playerid} = 0;
				return 1;
			}
			
			new
				fid = Player[playerid][uMember] - 1;
				
			switch( listitem )
			{
				case 0:
				{
					format:g_small_string( "\
						"cWHITE"Увольнение из организации\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите id игрока:", Fraction[fid][f_name] );
						
					showPlayerDialog( playerid, d_fpanel + 42, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 1:
				{
					format:g_small_string( "\
						"cWHITE"Увольнение из организации\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите номер аккаунта:", Fraction[fid][f_name] );
						
					showPlayerDialog( playerid, d_fpanel + 43, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
		}
		
		case d_fpanel + 42:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_fpanel + 41, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Уволить по ID игрока\n\
					Уволить по номеру аккаунта", "Выбрать", "Закрыть" );
			}
			
			new
				fid = Player[playerid][uMember] - 1;
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || !IsLogged( strval( inputtext ) ) || playerid == strval( inputtext ) )
			{
				format:g_small_string( "\
					"cWHITE"Увольнение из организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите id игрока:\n\
					"gbDialogError"Некорректный id игрока.", Fraction[fid][f_name] );
						
				return showPlayerDialog( playerid, d_fpanel + 42, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( PlayerLeaderFraction( strval( inputtext ), fid ) )
			{
				format:g_small_string( "\
					"cWHITE"Увольнение из организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите id игрока:\n\
					"gbDialogError"Вы не можете уволить лидера.", Fraction[fid][f_name] );
						
				return showPlayerDialog( playerid, d_fpanel + 42, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( Player[strval( inputtext )][uMember] != Player[playerid][uMember] )
			{
				format:g_small_string( "\
					"cWHITE"Увольнение из организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите id игрока:\n\
					"gbDialogError"Данный игрок не состоит в этой организации.", Fraction[fid][f_name] );
						
				return showPlayerDialog( playerid, d_fpanel + 42, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( FMember[fid][i][m_id] == Player[strval( inputtext )][uID] )
				{
					FMember[fid][i][m_id] = 
					FMember[fid][i][m_lasttime] = 
					FMember[fid][i][m_rank] = 0;
				
					FMember[fid][i][m_name][0] = EOS;
				
					break;
				}
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uMember` = 0, `uRank` = 0 WHERE `uID` = %d", Player[strval( inputtext )][uID] );
			mysql_tquery( mysql, g_string );
			
			Fraction[fid][f_members]--;
			
			Player[strval( inputtext )][uMember] = 
			Player[strval( inputtext )][uRank] = 0;
			
			pformat:( ""gbSuccess"Вы уволили "cBLUE"%s[%d]"cWHITE" из "cBLUE"%s"cWHITE".", Player[strval( inputtext )][uName], strval( inputtext ), Fraction[fid][f_name] );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"Вы уволены из "cBLUE"%s"cWHITE" игроком "cBLUE"%s[%d]"cWHITE".", Fraction[fid][f_name], Player[playerid][uName], playerid );
			psend:( strval( inputtext ), C_WHITE );
			
			g_player_interaction{playerid} = 0;
		}
		
		case d_fpanel + 43:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_fpanel + 41, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Уволить по ID игрока\n\
					Уволить по номеру аккаунта", "Выбрать", "Закрыть" );
			}
			
			new
				fid = Player[playerid][uMember] - 1,
				member = INVALID_PARAM;
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || Player[playerid][uID] == strval( inputtext ) || strval( inputtext ) < 1 )
			{
				format:g_small_string( "\
					"cWHITE"Увольнение из организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите номер аккаунта:\n\
					"gbDialogError"Некорректный номер аккаунта.", Fraction[fid][f_name] );
						
				return showPlayerDialog( playerid, d_fpanel + 43, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			foreach(new i : Player)
			{
				if( strval( inputtext ) == Player[i][uID] )
				{
					format:g_small_string( "\
						"cWHITE"Увольнение из организации\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите номер аккаунта:\n\
						"gbDialogError"Игрок в онлайне, воспользуйтесь другим способом увольнения.", Fraction[fid][f_name] );
							
					return showPlayerDialog( playerid, d_fpanel + 43, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
			
			for( new i; i < 3; i++ )
			{
				if( strval( inputtext ) == Fraction[fid][f_leader][i] )
				{
					format:g_small_string( "\
						"cWHITE"Увольнение из организации\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите номер аккаунта:\n\
						"gbDialogError"Вы не можете уволить лидера.", Fraction[fid][f_name] );
							
					return showPlayerDialog( playerid, d_fpanel + 43, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
			
			for( new i; i < MAX_MEMBERS; i++ )
			{
				if( strval( inputtext ) == FMember[fid][i][m_id] )
				{
					member = i;
					break;
				}
			}
			
			if( member == INVALID_PARAM )
			{
				format:g_small_string( "\
					"cWHITE"Увольнение из организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите номер аккаунта:\n\
					"gbDialogError"Игрок не состоит в этой организации.", Fraction[fid][f_name] );
						
				return showPlayerDialog( playerid, d_fpanel + 43, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			mysql_format:g_string( "UPDATE `"DB_USERS"` SET `uMember` = 0, `uRank` = 0 WHERE `uID` = %d", strval( inputtext ) );
			mysql_tquery( mysql, g_string );
			
			pformat:( ""gbSuccess"Вы уволили "cBLUE"%s"cWHITE" из "cBLUE"%s"cWHITE".", FMember[fid][member][m_name], Fraction[fid][f_name] );
			psend:( playerid, C_WHITE );
			
			Fraction[fid][f_members]--;
			
			FMember[fid][member][m_id] = 
			FMember[fid][member][m_lasttime] = 
			FMember[fid][member][m_rank] = 0;
				
			FMember[fid][member][m_name][0] = EOS;
				
			g_player_interaction{playerid} = 0;
		}
		
		case d_fpanel + 44:
		{
			if( !response ) return 1;
			
			new
				vehicleid,
				amount,
				fid = Player[playerid][uMember] - 1;
			
			for( new i; i < Fraction[fid][f_vehicles]; i++ )
			{
				if( FVehicle[fid][i][v_id]  )
				{
					vehicleid = FVehicle[fid][i][v_id];
				
					if( IsVehicleOccupied( vehicleid ) ) continue;
				
					SetVehicleZAngle( vehicleid, Vehicle[vehicleid][vehicle_pos][3] );
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
			SendLeaderMessage( Player[playerid][uMember] - 1, C_DARKGRAY, g_small_string );
		}
		
		case d_frac:
		{
			if( !response ) return 1;
			
			new
				call = g_dialog_select[playerid][listitem];
				
			if( !CPolice[call][p_time] )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Этот вызов уже аннулирован." );
				ShowEmergencyCall( playerid, Player[playerid][uMember] );
				return 1;
			}
				
			SetPVarInt( playerid, "Fraction:Call", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			format:g_string( "\
				"cBLUE"Экстренный вызов #%s\n\n\
				"cWHITE"От: %s[%d], тел. %d\n\
				Район: %s\n\n\
				"cBLUE"Описание ситуации:\n\
				"cWHITE"%s",
				CPolice[call][p_number],
				Player[CPolice[call][p_playerid]][uRPName], 
				CPolice[call][p_playerid],
				GetPhoneNumber( CPolice[call][p_playerid] ),
				CPolice[call][p_zone],
				CPolice[call][p_descript] );
				
			showPlayerDialog( playerid, d_frac + 1, DIALOG_STYLE_MSGBOX, " ", g_string, "Действия", "Назад" );
		}
		
		case d_frac + 1:
		{
			if( !response )
			{
				DeletePVar( playerid, "Fraction:Call" );
				ShowEmergencyCall( playerid, Player[playerid][uMember] );
				return 1;
			}
			
			showPlayerDialog( playerid, d_frac + 8, DIALOG_STYLE_LIST, " ", "Принять вызов\nАннулировать вызов", "Выбрать", "Назад" );
		}
		//Ремонт на гос. СТО
		case d_frac + 2: 
		{
			if( !response )
			{
				DeletePVar( playerid, "Mech:VId" );
				return 1;
			}
			
			new
				vid = GetPVarInt( playerid, "Mech:VId" ),
				vmodel = Vehicle[vid][vehicle_model];
				
			switch( listitem )
			{
				case 0:
				{
					if( VehicleInfo[vmodel - 400][v_repair] > 0 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете произвести капитальный ремонт двигателя на этом транспорте." );
							
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( vmodel ) );	
						return showPlayerDialog( playerid, d_frac + 2, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки\n\
							Комплексный ремонт",
						"Выбрать", "Закрыть" );
					}
				
					pformat:( ""gbSuccess"Вы произвели капитальный ремонт двигателя "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					Vehicle[vid][vehicle_engine] = 100.0;
					
					Vehicle[vid][vehicle_engine_date] = gettime();
					UpdateVehicle( vid, "vehicle_engine_date", Vehicle[vid][vehicle_engine_date] );
				}
				
				case 1:
				{
					if( VehicleInfo[vmodel - 400][v_repair] > 0 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете отремонтировать кузов на этом транспорте." );
							
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( vmodel ) );	
						return showPlayerDialog( playerid, d_frac + 2, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки\n\
							Комплексный ремонт",
						"Выбрать", "Закрыть" );
					}
				
				
					pformat:( ""gbSuccess"Вы произвели ремонт кузова "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][1] = 0;
					Vehicle[vid][vehicle_damage][0] = 0;
				}
				
				case 2:
				{
					if( VehicleInfo[vmodel - 400][v_repair] >= 1 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете заменить фары на этом транспорте." );
							
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( vmodel ) );	
						return showPlayerDialog( playerid, d_frac + 2, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки\n\
							Комплексный ремонт",
						"Выбрать", "Закрыть" );
					}
				
				
					pformat:( ""gbSuccess"Вы заменили фары "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][2] = 0;
				}
				
				case 3:
				{
					if( VehicleInfo[vmodel - 400][v_repair] == 2 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете заменить покрышки на этом транспорте." );
							
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( vmodel ) );	
						return showPlayerDialog( playerid, d_mech + 5, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки\n\
							Комплексный ремонт",
						"Выбрать", "Закрыть" );
					}
				
					pformat:( ""gbSuccess"Вы заменили покрышки "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][3] = 0;
				}
				
				case 4:
				{
					pformat:( ""gbSuccess"Вы произвели комплексный ремонт "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					RepairVehicle( vid );
					
					for( new i; i < 4; i++ )
						Vehicle[vid][vehicle_damage][i] = 0;
				}
			}
			
			SetVehicleDamageStatus( vid );
			setVehicleHealthEx( vid );
			
			DeletePVar( playerid, "Mech:VId" );
		}
		
		case d_frac + 3: 
		{
			if( !IsLogged( GetPVarInt( playerid, "Target:Player" ) ) || 
				GetDistanceBetweenPlayers( playerid, GetPVarInt( playerid, "Target:Player" ) ) > 3.0 || 
				GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( GetPVarInt( playerid, "Target:Player" ) ) )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Игрок слишком далеко от Вас" );
				DeletePVar( playerid, "Target:Player" );
			
				return 1;
			}
		
			if( !response )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Вы оказали сопротивление при обыске." );
				
				pformat:( ""gbDefault""cBLUE"%s"cWHITE" оказал сопротивление при обыске.", Player[playerid][uName] );
				psend:( GetPVarInt( playerid, "Target:Player" ), C_WHITE );
				
				DeletePVar( playerid, "Target:Player" );
				
				return 1;
			}
			
			new
				id,
				bag_id,
				bool:flag = false,
				bool:find = false;
		
			clean:<g_big_string>;
			
			format:g_small_string( ""cWHITE"При обыске %s найдено:\n", Player[ playerid ][uRPName] );
			strcat( g_big_string, g_small_string );
			
			for( new i; i < MAX_INVENTORY_USE; i++ )
			{
				if( !UseInv[ playerid ][i][inv_id] ) continue;
			
				id = getInventoryId( UseInv[ playerid ][i][inv_id] );
				
				format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d", inventory[id][i_name], UseInv[ playerid ][i][inv_amount] );
				strcat( g_big_string, g_small_string );
				
				if( !find ) find = true;
				flag = true;
			}

			if( flag ) strcat( g_big_string, "\n" );
			flag = false;
			
			for( new i; i < MAX_INVENTORY; i++ )
			{
				if( !PlayerInv[ playerid ][i][inv_id] ) continue;
			
				id = getInventoryId( PlayerInv[ playerid ][i][inv_id] );
				
				format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d", inventory[id][i_name], PlayerInv[ playerid ][i][inv_id] );
				strcat( g_big_string, g_small_string );
				
				if( !find ) find = true;
				flag = true;
			}
			
			if( getUseBag( playerid ) )
			{
				if( flag ) strcat( g_big_string, "\n" );
				flag = false;
			
				strcat( g_big_string, "В сумке: " );
				bag_id = getUseBagId( playerid );
				
				for( new i; i < MAX_INVENTORY_BAG; i++ )
				{
					if( !BagInv[ bag_id ][i][inv_id] ) continue;
					
					id = getInventoryId( BagInv[ bag_id ][i][inv_id] );
					
					format:g_small_string( "\n"cWHITE"%s - "cBLUE"%d", inventory[id][i_name], BagInv[ bag_id ][i][inv_id] );
					strcat( g_big_string, g_small_string );
					
					flag = true;
				}
				
				if( !flag ) strcat( g_big_string, "пусто" );
			}
		
			if( !find )
			{
				pformat:( ""gbDefault"При обыске %s ничего не найдено.", Player[ playerid ][uName] );
				psend:( GetPVarInt( playerid, "Target:Player" ), C_WHITE );
			}
			else
			{
				showPlayerDialog( GetPVarInt( playerid, "Target:Player" ), INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
			}
		
			format:g_small_string( "обыскал%s %s", SexTextEnd( GetPVarInt( playerid, "Target:Player" ) ), Player[ playerid ][uRPName] );
			MeAction( GetPVarInt( playerid, "Target:Player" ), g_small_string, 1 );
			
			pformat:( ""gbDefault""cBLUE"%s"cWHITE" обыскал Вас.", Player[ GetPVarInt( playerid, "Target:Player" ) ][uName] );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Target:Player" );
		}
		//Склад
		case d_frac + 4:
		{
			if( !response ) return 1;
			
			new
				fid = Player[playerid][uMember] - 1,
				amount,
				id;
			
			switch( listitem )
			{	//Одежда
				case 0:
				{
					clean:<g_string>;
				
					for( new i; i < 20; i++ )
					{
						if( Fraction[fid][f_skin][i] )
						{
							format:g_small_string( ""cWHITE"Одежда %d\n", Fraction[fid][f_skin][i] );
							strcat( g_string, g_small_string );
							
							amount++;
						}
					}
					
					if( !amount ) 
					{
						SendClient:( playerid, C_WHITE, !""gbError"У Вашей организации нет одежды." );
						return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
					}
					
					showPlayerDialog( playerid, d_frac + 5, DIALOG_STYLE_LIST, " ", g_string, "Взять", "Назад" );
				}
				//Оружие
				case 1:
				{
					clean:<g_string>;
					
					for( new i; i < 10; i++ )
					{
						if( Fraction[fid][f_gun][i] )
						{
							id = getInventoryId( Fraction[fid][f_gun][i] );
						
							format:g_small_string( ""cWHITE"%s\n", inventory[id][i_name] );
							strcat( g_string, g_small_string );
							
							amount++;
						}
					}
					
					if( !amount ) 
					{
						SendClient:( playerid, C_WHITE, !""gbError"У Вашей организации нет снаряжения." );
						return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
					}
					
					showPlayerDialog( playerid, d_frac + 6, DIALOG_STYLE_LIST, " ", g_string, "Взять", "Назад" );
				}
				//Другое
				case 2:
				{
					clean:<g_string>;
					
					for( new i; i < 10; i++ )
					{
						if( Fraction[fid][f_stock][i] )
						{
							id = getInventoryId( Fraction[fid][f_stock][i] );
						
							format:g_small_string( ""cWHITE"%s\n", inventory[id][i_name] );
							strcat( g_string, g_small_string );
							
							amount++;
						}
					}
					
					if( !amount ) 
					{
						SendClient:( playerid, C_WHITE, !""gbError"У Вашей организации нет других предметов." );
						return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
					}
					
					showPlayerDialog( playerid, d_frac + 7, DIALOG_STYLE_LIST, " ", g_string, "Взять", "Назад" );
				}
			}
		}
		
		case d_frac + 5:
		{
			if( !response ) return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
		
			new
				fid = Player[playerid][uMember] - 1,
				rank = getRankId( playerid, fid );
		
			if( !FRank[ fid ][rank][r_skin][listitem] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"На Вашей должности недоступна эта одежда." );
				return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
			}
		
			if( getItem( playerid, INV_SKIN, Fraction[ fid ][f_skin][listitem] ) || getUseItem( playerid, INV_SKIN, Fraction[ fid ][f_skin][listitem], 1 ) )
			{
				SendClient:( playerid, C_WHITE, !""gbError"У Вас уже есть такая одежда." );
				return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
			}
			
			if( !giveItem( playerid, 1, 1, Fraction[ fid ][f_skin][listitem], INDEX_FRACTION ) )
			{
				SendClient:( playerid, C_WHITE, !""gbError"У Вас нет свободного места в инвентаре." );
				return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
			}
			
			SendClient:( playerid, C_WHITE, !""gbDefault"Вы взяли рабочую одежду." );
		}
		
		case d_frac + 6:
		{
			if( !response ) return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
		
			new
				fid = Player[playerid][uMember] - 1,
				rank = getRankId( playerid, fid ),
				id;
		
			if( !FRank[ fid ][rank][r_gun][listitem] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"На Вашей должности недоступно это снаряжение." );
				return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
			}
			
			id = getInventoryId( Fraction[fid][f_gun][listitem] );
			
			if( inventory[ id ][i_id] == 103 )
			{
				if( !giveItem( playerid, Fraction[fid][f_gun][listitem], 1, 3, INDEX_FRACTION ) )
				{
					SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
					return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
				}
			}
			
			switch( inventory[ id ][i_type] )
			{
				case INV_GUN, INV_SMALL_GUN:
				{
					if( !giveItem( playerid, Fraction[fid][f_gun][listitem], 1, weapon_amount[ Fraction[fid][f_gun][listitem] - 14 ], INDEX_FRACTION ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
						return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
					}
				}
				
				case INV_COLD_GUN:
				{
					if( !giveItem( playerid, Fraction[fid][f_gun][listitem], 1, 1, INDEX_FRACTION ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
						return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
					}
				}
				
				default:
				{
					if( !giveItem( playerid, Fraction[fid][f_gun][listitem], 1, -1, INDEX_FRACTION ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
						return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
					}
				}
			}
			
			pformat:( ""gbDefault"Вы взяли предмет со склада - "cBLUE"%s"cWHITE".", inventory[ id ][i_name] );
			psend:( playerid, C_WHITE );
		}
		
		case d_frac + 7:
		{
			if( !response ) return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
		
			new
				fid = Player[playerid][uMember] - 1,
				rank = getRankId( playerid, fid ),
				id;
		
			if( !FRank[ fid ][rank][r_stock][listitem] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"На Вашей должности недоступен этот предмет." );
				return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
			}
			
			id = getInventoryId( Fraction[fid][f_stock][listitem] );
			
			switch( inventory[id][i_type] )
			{
				case INV_ARMOUR :
				{
					if( !giveItem( playerid, Fraction[fid][f_stock][listitem], 1, 100, INDEX_FRACTION ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
						return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
					}
				}
				
				default :
				{
					if( !giveItem( playerid, Fraction[fid][f_stock][listitem], 1, -1, INDEX_FRACTION ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
						return showPlayerDialog( playerid, d_frac + 4, DIALOG_STYLE_LIST, " ", fstock_dialog, "Выбрать", "Закрыть" );
					}
				}
			}
			
			pformat:( ""gbDefault"Вы взяли предмет со склада - "cBLUE"%s"cWHITE".", inventory[ id ][i_name] );
			psend:( playerid, C_WHITE );
		}
		
		case d_frac + 8:
		{
			new
				call = GetPVarInt( playerid, "Fraction:Call" );
		
			if( !CPolice[call][p_time] )
			{
				DeletePVar( playerid, "Fraction:Call" );
			
				SendClient:( playerid, C_WHITE, ""gbError"Этот вызов уже аннулирован." );
				//ShowEmergencyCall( playerid, Player[playerid][uMember] );
				return 1;
			}
		
			if( !response )
			{
				format:g_string( "\
					"cBLUE"Экстренный вызов #%s\n\n\
					"cWHITE"От: %s[%d], тел. %d\n\
					Район: %s\n\n\
					"cBLUE"Описание ситуации:\n\
					"cWHITE"%s",
					CPolice[call][p_number],
					Player[CPolice[call][p_playerid]][uRPName], 
					CPolice[call][p_playerid],
					GetPhoneNumber( CPolice[call][p_playerid] ),
					CPolice[call][p_zone],
					CPolice[call][p_descript] );
					
				return showPlayerDialog( playerid, d_frac + 1, DIALOG_STYLE_MSGBOX, " ", g_string, "Действия", "Назад" );												
			}
			
			switch( listitem )
			{	//Принять вызов
				case 0:
				{
					if( g_player_gps{playerid} ) DisablePlayerCheckpoint( playerid );
			
					if( !CPolice[call][p_status] && IsLogged( CPolice[call][p_playerid] ) )
					{
						pformat:( ""gbSuccess"Ваш вызов #%s подтвержден сотрудниками Emergency Services, ожидайте на месте.", CPolice[call][p_number] );
						psend:( CPolice[call][p_playerid], C_WHITE );
						
						CPolice[call][p_status] = 1;
					}
					
					SetPlayerCheckpoint( playerid, CPolice[call][p_pos][0], CPolice[call][p_pos][1], CPolice[call][p_pos][2], 3.0 );
					g_player_gps{playerid} = 1;
				
					format:g_small_string( "[CH: 911] %s принял вызов #%s.", 
						Player[playerid][uRPName],
						CPolice[call][p_number]
					);
				}
				
				//Отклонить вызов
				case 1:
				{
					SendClient:( CPolice[call][p_playerid], C_WHITE, ""gbSuccess"Ваш вызов аннулирован сотрудниками Emergency Services." );
				
					format:g_small_string( "[CH: 911] %s аннулировал вызов #%s.", 
						Player[playerid][uRPName],
						CPolice[call][p_number]
					);
					
					Player[ CPolice[call][p_playerid] ][jPolice] = false;
			
					CPolice[call][p_playerid] = 
					CPolice[call][p_time] = 
					CPolice[call][p_type] = 0;
								
					CPolice[call][p_number][0] =
					CPolice[call][p_descript][0] = 
					CPolice[call][p_zone][0] = EOS;
							
					CPolice[call][p_pos][0] =
					CPolice[call][p_pos][1] = 
					CPolice[call][p_pos][2] = 0.0;
				}
			}
			
			foreach(new i : Player)
			{
				if( !IsLogged( i ) || !Player[i][uRank] ) continue;
						
				if( Player[i][uMember] != FRACTION_POLICE && 
					Player[i][uMember] != FRACTION_FIRE && 
					Player[i][uMember] != FRACTION_HOSPITAL ) continue;
	
				if( !FRank[ Player[i][uMember] - 1 ][getRankId( i, Player[i][uMember] - 1 )][r_add][0] ) continue;
				
				if( !getItem( i, INV_SPECIAL, PARAM_RADIO ) ) continue;

				SendClient:( i, C_LIGHTBLUE, g_small_string );	
			}
			
			DeletePVar( playerid, "Fraction:Call" );
		}
	}
	return 1;
}