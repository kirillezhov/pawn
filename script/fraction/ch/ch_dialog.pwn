function City_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{	
	switch( dialogid ) 
	{	
		case d_meria:
		{
			if( !response ) return 1;
			
			showPlayerDialog( playerid, d_meria + 1, DIALOG_STYLE_LIST, "Приемная мэра", dialog_reception, "Выбрать", "Закрыть" );
		}
		
		case d_meria + 1:
		{
			if( !response ) return 1;
			
			new
				index = INVALID_PARAM,
				year, month, day;
			
			switch( listitem )
			{
				case 0:
				{
					for( new i; i < MAX_RECOURSE; i++ )
					{
						if( Recourse[i][r_namefrom][0] != EOS && !strcmp( Recourse[i][r_namefrom], Player[playerid][uName], true ) )
							return SendClient:( playerid, C_WHITE, !""gbDefault"Вы оставляли обращение ранее, попробуйте позже." );
					
						if( Recourse[i][r_nameto][0] == EOS && index == INVALID_PARAM )
							index = i;
					}
					
					if( index == INVALID_PARAM )
						return SendClient:( playerid, C_WHITE, !""gbError"На рассмотрении слишком много обращений, попробуйте позже." );
					
					showPlayerDialog( playerid, d_meria + 2, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Оставить обращение\n\n\
						"cWHITE"Укажите, кому будет адресовано Ваше обращение:", "Далее", "Назад" );
				}
				
				case 1:
				{
					for( new i; i < MAX_RECOURSE; i++ )
					{
						if( Recourse[i][r_namefrom][0] != EOS && !strcmp( Recourse[i][r_namefrom], Player[playerid][uName], true ) )
						{
							index = i;
							break;
						}
					}
					
					if( index == INVALID_PARAM ) 
						return SendClient:( playerid, C_WHITE, !""gbError"Среди обращений Вашего не найдено." );
						
					clean:<g_big_string>;
					gmtime( Recourse[index][r_date], year, month, day );
					
					format:g_small_string( ""cBLUE"Обращение к %s\n\n", Recourse[index][r_nameto] );
					strcat( g_big_string, g_small_string );
					
					format:g_small_string( ""cWHITE"Дата: "cBLUE"%02d.%02d.%d\n\n", day, month, year );
					strcat( g_big_string, g_small_string );
					
					format:g_string( ""cWHITE"Текст обращения:\n%s", Recourse[index][r_text] );
					strcat( g_big_string, g_string );
					
					if( Recourse[index][r_answer][0] != EOS )
					{
						format:g_string( "\n\n"cWHITE"Ответ от %s:\n"cBLUE"%s", Recourse[index][r_nameans], Recourse[index][r_answer] );
						strcat( g_big_string, g_string );
					
						if( !Recourse[index][r_status] ) 
						{
							Recourse[index][r_status] = 1;
							
							mysql_format:g_small_string( "UPDATE `"DB_RECOURSE"` SET `r_status` = 1 WHERE `r_id` = %d LIMIT 1", Recourse[index][r_id] );
							mysql_tquery( mysql, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "" );
				}
			}
		}
		
		case d_meria + 2:
		{
			if( !response ) return showPlayerDialog( playerid, d_meria + 1, DIALOG_STYLE_LIST, "Приемная мэра", dialog_reception, "Выбрать", "Закрыть" );
		
			new
				index = INVALID_PARAM;
				
			if( inputtext[0] == EOS || strlen( inputtext ) > MAX_PLAYER_NAME )
			{
				return showPlayerDialog( playerid, d_meria + 2, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Оставить обращение\n\n\
					"cWHITE"Укажите, кому будет адресовано Ваше обращение:\n\
					"gbDialogError"Неправильный формат ввода.", "Далее", "Назад" );
			}
				
			for( new i; i < MAX_RECOURSE; i++ )
			{
				if( Recourse[i][r_nameto][0] == EOS  )
				{
					index = i;
					break;
				}
			}
			
			if( index == INVALID_PARAM ) 
			{
				SendClient:( playerid, C_WHITE, !""gbError"На рассмотрении слишком много обращений, попробуйте позже." );
				return showPlayerDialog( playerid, d_meria + 1, DIALOG_STYLE_LIST, "Приемная мэра", dialog_reception, "Выбрать", "Закрыть" );
			}
			
			strcat( Recourse[index][r_nameto], inputtext, MAX_PLAYER_NAME );
			SetPVarInt( playerid, "CityHall:Recourse", index );
			
			format:g_small_string( "\
				"cBLUE"Обращение к %s\n\n\
				"cWHITE"Введите текст обращения:\n\n\
				"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
				а максимальное количество символов в обращении - 1024.\n\
				Оставьте поле пустым по завершению составления обращения.", Recourse[index][r_nameto] );
				
			showPlayerDialog( playerid, d_meria + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_meria + 3:
		{
			if( !response )
			{
				Recourse[ GetPVarInt( playerid, "CityHall:Recourse" ) ][r_nameto][0] = EOS;
				DeletePVar( playerid, "CityHall:Recourse" );
				
				return showPlayerDialog( playerid, d_meria + 2, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Оставить обращение\n\n\
					"cWHITE"Укажите, кому будет адресовано Ваше обращение:", "Далее", "Назад" );
			}
			
			new
				index = GetPVarInt( playerid, "CityHall:Recourse" );
			
			if( Recourse[index][r_text][0] == EOS )
			{
				if( inputtext[0] == EOS )
				{
					format:g_string( "\
						"cBLUE"Обращение к %s\n\n\
						"cWHITE"Введите текст обращения:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в обращении - 1024.\n\
						Оставьте поле пустым по завершению составления обращения.\n\n\
						"gbDialogError"Поле для ввода пустое.", Recourse[index][r_nameto] );
						
					return showPlayerDialog( playerid, d_meria + 3, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
				}
				else if( strlen( inputtext ) > 128 )
				{
					format:g_string( "\
						"cBLUE"Обращение к %s\n\n\
						"cWHITE"Введите текст обращения:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в обращении - 1024.\n\
						Оставьте поле пустым по завершению составления обращения.\n\n\
						"gbDialogError"Превышен допустимый лимит символов в строке.", Recourse[index][r_nameto] );
						
					return showPlayerDialog( playerid, d_meria + 3, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
				}
				
				strcat( Recourse[index][r_text], inputtext, 1024 );
				
				format:g_big_string( "\
					"cBLUE"Обращение к %s\n\n\
					"cWHITE"Введите текст обращения:\n\n\
					"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
					а максимальное количество символов в обращении - 1024.\n\
					Оставьте поле пустым по завершению составления обращения.\n\n\
					"cBLUE"Текст:"cWHITE"\n\
					%s", Recourse[index][r_nameto], Recourse[index][r_text] );
						
				return showPlayerDialog( playerid, d_meria + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
			}
			else
			{
				if( inputtext[0] != EOS )
				{
					if( strlen( inputtext ) > 128 )
					{
						format:g_big_string( "\
							"cBLUE"Обращение к %s\n\n\
							"cWHITE"Введите текст обращения:\n\n\
							"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
							а максимальное количество символов в обращении - 1024.\n\
							Оставьте поле пустым по завершению составления обращения.\n\n\
							"cBLUE"Текст:"cWHITE"\n\
							%s\n\n\
							"gbDialogError"Превышен допустимый лимит символов в строке.", Recourse[index][r_nameto], Recourse[index][r_text] );
								
						return showPlayerDialog( playerid, d_meria + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
					}
					else if( Recourse[index][r_text][1023] != EOS )
					{
						format:g_big_string( "\
							"cBLUE"Обращение к %s\n\n\
							"cWHITE"Введите текст обращения:\n\n\
							"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
							а максимальное количество символов в обращении - 1024.\n\
							Оставьте поле пустым по завершению составления обращения.\n\n\
							"cBLUE"Текст:"cWHITE"\n\
							%s\n\n\
							"gbDialogError"Лимит символов в обращении превышен.", Recourse[index][r_nameto], Recourse[index][r_text] );
								
						return showPlayerDialog( playerid, d_meria + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
					}
				
					strcat( Recourse[index][r_text], "\n", 1024 );
					strcat( Recourse[index][r_text], inputtext, 1024 );
				
					format:g_big_string( "\
						"cBLUE"Обращение к %s\n\n\
						"cWHITE"Введите текст обращения:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в обращении - 1024.\n\
						Оставьте поле пустым по завершению составления обращения.\n\n\
						"cBLUE"Текст:"cWHITE"\n\
						%s", Recourse[index][r_nameto], Recourse[index][r_text] );
							
					return showPlayerDialog( playerid, d_meria + 3, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
				}
			}
			
			format:g_big_string( "\
				"cBLUE"Обращение к %s\n\n\
				"cWHITE"Текст:"cGRAY"\n\
				%s\n\n\
				"cWHITE"Отправить обращение?", Recourse[index][r_nameto], Recourse[index][r_text] );
				
			showPlayerDialog( playerid, d_meria + 4, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Да", "Нет" );
		}
		
		case d_meria + 4:
		{
			new
				index = GetPVarInt( playerid, "CityHall:Recourse" );
		
			if( !response )
			{
				Recourse[ GetPVarInt( playerid, "CityHall:Recourse" ) ][r_text][0] = EOS;
			
				format:g_small_string( "\
					"cBLUE"Обращение к %s\n\n\
					"cWHITE"Введите текст обращения:\n\n\
					"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
					а максимальное количество символов в обращении - 1024.\n\
					Оставьте поле пустым по завершению составления обращения.", Recourse[index][r_nameto] );
					
				return showPlayerDialog( playerid, d_meria + 3, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			strcat( Recourse[index][r_namefrom], Player[playerid][uName], MAX_PLAYER_NAME );
			Recourse[index][r_date] = gettime();
			
			mysql_format:g_big_string( "INSERT INTO `"DB_RECOURSE"`\
				( `r_date`, `r_nameto`, `r_text`, `r_namefrom` ) VALUES \
				( %d, '%s', '%e', '%s' )",
				Recourse[index][r_date],
				Recourse[index][r_nameto],
				Recourse[index][r_text],
				Recourse[index][r_namefrom] );
			mysql_tquery( mysql, g_big_string, "InsertRecourse", "d", index );
			
			pformat:( ""gbSuccess"Вы оставили свое обращение "cBLUE"%s"cWHITE". Ваш ответ будет рассмотрен в кратчайшие сроки.", Recourse[index][r_nameto] );
			psend:( playerid, C_WHITE );
			
			format:g_small_string( ""FRACTION_PREFIX" %s[%d] оставил новое обращение к "cBLUE"%s"cDARKGRAY".", Player[playerid][uName], playerid, Recourse[index][r_nameto] );
			
			foreach(new i: Player)
			{
				if( !IsLogged(i) ) continue;
				
				if( Player[playerid][uMember] == FRACTION_CITYHALL )
				{
					SendClient:( i, C_DARKGRAY, g_small_string );
				}
			}
			
			DeletePVar( playerid, "CityHall:Recourse" );
		}
		
		case d_meria + 5:
		{
			if( !response ) return 1;
			
			new
				index = g_dialog_select[playerid][listitem],
				day, month, year;
				
			SetPVarInt( playerid, "CityHall:Recourse", index );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
				
			clean:<g_big_string>;
			gmtime( Recourse[index][r_date], year, month, day );
				
			format:g_small_string( ""cBLUE"Обращение к %s\n\n", Recourse[index][r_nameto] );
			strcat( g_big_string, g_small_string );
					
			format:g_small_string( ""cWHITE"Дата: "cBLUE"%02d.%02d.%d\n\n", day, month, year );
			strcat( g_big_string, g_small_string );
					
			format:g_string( ""cWHITE"Текст обращения:"cGRAY"\n%s", Recourse[index][r_text] );
			strcat( g_big_string, g_string );
					
			if( Recourse[index][r_answer][0] != EOS )
			{
				format:g_string( "\n\n"cWHITE"Ответ от %s:\n"cBLUE"%s\n\n", Recourse[index][r_nameans], Recourse[index][r_answer] );
				strcat( g_big_string, g_string );
					
				format:g_small_string( ""cWHITE"Статус: "cBLUE"%s", !Recourse[index][r_status] ? ("не просмотрено") : ("просмотрено") );
				strcat( g_big_string, g_small_string );
			}
			
			showPlayerDialog( playerid, d_meria + 6, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Далее", "Назад" );
		}
		
		case d_meria + 6:
		{
			if( !response )
			{
				DeletePVar( playerid, "CityHall:Recourse" );
				return cmd_recept( playerid );
			}
			
			showPlayerDialog( playerid, d_meria + 7, DIALOG_STYLE_LIST, "Действие", "\
				"cGRAY"Ответить\n\
				"cGRAY"Удалить", "Выбрать", "Назад" );
				
		}
		
		case d_meria + 7:
		{
			if( !response )
			{
				DeletePVar( playerid, "CityHall:Recourse" );
				return cmd_recept( playerid );
			}
			
			new
				index = GetPVarInt( playerid, "CityHall:Recourse" ),
				day, month, year;
				
			switch( listitem )
			{
				case 0:
				{
					if( Recourse[index][r_answer][0] != EOS )
					{
						SendClient:( playerid, C_WHITE, !""gbError"На это обращение было отвечено ранее." );
					
						return showPlayerDialog( playerid, d_meria + 7, DIALOG_STYLE_LIST, "Действие", "\
							"cGRAY"Ответить\n\
							"cGRAY"Удалить", "Выбрать", "Назад" );
					}
					
					format:g_small_string( "\
						"cWHITE"Ответить на обращение %s к "cBLUE"%s\n\n\
						"cWHITE"Введите текст ответа:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в ответе - 256.\n\
						Оставьте поле пустым по завершению составления ответа.", Recourse[index][r_namefrom], Recourse[index][r_nameto] );
						
					showPlayerDialog( playerid, d_meria + 8, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 1:
				{
					gmtime( Recourse[index][r_date], year, month, day );
				
					format:g_small_string( "\
						"cBLUE"Удаление обращения\n\n\
						"cWHITE"Вы действительно желаете удалить обращение "cBLUE"%s от %02d.%02d.%d"cWHITE"?",
						Recourse[index][r_namefrom], day, month, year );
						
					showPlayerDialog( playerid, d_meria + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
			}
		}
		
		case d_meria + 8:
		{
			if( !response )
			{
				DeletePVar( playerid, "CityHall:Recourse" );
			
				return cmd_recept( playerid );
			}
			
			new
				index = GetPVarInt( playerid, "CityHall:Recourse" );
				
				
			if( Recourse[index][r_answer][0] == EOS )
			{
				if( inputtext[0] == EOS )
				{
					format:g_string( "\
						"cWHITE"Ответить на обращение %s к "cBLUE"%s\n\n\
						"cWHITE"Введите текст ответа:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в ответе - 256.\n\
						Оставьте поле пустым по завершению составления ответа.\n\n\
						"gbDialogError"Поле для ввода пустое.", Recourse[index][r_namefrom], Recourse[index][r_nameto] );
						
					return showPlayerDialog( playerid, d_meria + 8, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
				}
				else if( strlen( inputtext ) > 128 )
				{
					format:g_string( "\
						"cWHITE"Ответить на обращение %s к "cBLUE"%s\n\n\
						"cWHITE"Введите текст ответа:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в ответе - 256.\n\
						Оставьте поле пустым по завершению составления ответа.\n\n\
						"gbDialogError"Превышен допустимый лимит символов в строке.", Recourse[index][r_namefrom], Recourse[index][r_nameto] );
						
					return showPlayerDialog( playerid, d_meria + 8, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
				}
				
				strcat( Recourse[index][r_answer], inputtext, 256 );
				
				format:g_big_string( "\
					"cWHITE"Ответить на обращение %s к "cBLUE"%s\n\n\
					"cWHITE"Введите текст ответа:\n\n\
					"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
					а максимальное количество символов в ответе - 256.\n\
					Оставьте поле пустым по завершению составления ответа.\n\n\
					"cBLUE"Ваш ответ:"cWHITE"\n\
					%s", Recourse[index][r_namefrom], Recourse[index][r_nameto], Recourse[index][r_answer] );

				return showPlayerDialog( playerid, d_meria + 8, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
			}
			else
			{
				if( inputtext[0] != EOS )
				{
					if( strlen( inputtext ) > 128 )
					{
						format:g_big_string( "\
							"cWHITE"Ответить на обращение %s к "cBLUE"%s\n\n\
							"cWHITE"Введите текст ответа:\n\n\
							"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
							а максимальное количество символов в ответе - 256.\n\
							Оставьте поле пустым по завершению составления ответа.\n\n\
							"cBLUE"Ваш ответ:"cWHITE"\n\
							%s\n\n\
							"gbDialogError"Превышен допустимый лимит символов в строке.", Recourse[index][r_namefrom], Recourse[index][r_nameto], Recourse[index][r_answer] );

						return showPlayerDialog( playerid, d_meria + 8, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
					}
					else if( Recourse[index][r_answer][255] != EOS )
					{
						format:g_big_string( "\
							"cWHITE"Ответить на обращение %s к "cBLUE"%s\n\n\
							"cWHITE"Введите текст ответа:\n\n\
							"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
							а максимальное количество символов в ответе - 256.\n\
							Оставьте поле пустым по завершению составления ответа.\n\n\
							"cBLUE"Ваш ответ:"cWHITE"\n\
							%s\n\n\
							"gbDialogError"Превышен допустимый лимит символов в ответе.", Recourse[index][r_namefrom], Recourse[index][r_nameto], Recourse[index][r_answer] );

						return showPlayerDialog( playerid, d_meria + 8, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
					}
					
					strcat( Recourse[index][r_answer], "\n", 256 );
					strcat( Recourse[index][r_answer], inputtext, 256 );
				
					format:g_big_string( "\
						"cWHITE"Ответить на обращение %s к "cBLUE"%s\n\n\
						"cWHITE"Введите текст ответа:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в ответе - 256.\n\
						Оставьте поле пустым по завершению составления ответа.\n\n\
						"cBLUE"Ваш ответ:"cWHITE"\n\
						%s", Recourse[index][r_namefrom], Recourse[index][r_nameto], Recourse[index][r_answer] );

					return showPlayerDialog( playerid, d_meria + 8, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Назад" );
				}
			}
			
			strcat( Recourse[index][r_nameans], Player[playerid][uName], MAX_PLAYER_NAME );
			
			mysql_format:g_string( "UPDATE `"DB_RECOURSE"` \
				SET \
				`r_answer` = '%e', \
				`r_nameans` = '%s' \
				WHERE \
				`r_id` = %d LIMIT 1", 
				Recourse[index][r_answer], 
				Recourse[index][r_nameans], 
				Recourse[index][r_id] );
			mysql_tquery( mysql, g_string );
			
			DeletePVar( playerid, "CityHall:Recourse" );
			
			pformat:( ""gbSuccess"Вы ответили на обращение "cBLUE"%s"cWHITE".", Recourse[index][r_namefrom] );
			psend:( playerid, C_WHITE );
			
			cmd_recept( playerid );
		}
		
		case d_meria + 9:
		{
			if( !response )
			{
				DeletePVar( playerid, "CityHall:Recourse" );
				return cmd_recept( playerid );
			}
			
			new
				index = GetPVarInt( playerid, "CityHall:Recourse" );
				
			mysql_format:g_small_string( "DELETE FROM `"DB_RECOURSE"` WHERE `r_id` = %d LIMIT 1", Recourse[index][r_id] );
			mysql_tquery( mysql, g_small_string );
			
			pformat:( ""gbSuccess"Вы удалили обращение "cBLUE"%s"cWHITE".", Recourse[index][r_namefrom] );
			psend:( playerid, C_WHITE );
			
			Recourse[index][r_id] =
			Recourse[index][r_date] =
			Recourse[index][r_status] = 0;
			
			Recourse[index][r_nameto][0] = 
			Recourse[index][r_namefrom][0] = 
			Recourse[index][r_nameans][0] = 
			Recourse[index][r_text][0] = 
			Recourse[index][r_answer][0] = EOS;
			
			DeletePVar( playerid, "CityHall:Recourse" );
		}
		
		case d_meria + 10:
		{
			if( !response )
			{
				clean:<Document[ GetPVarInt( playerid, "Document:Player" ) ][ GetPVarInt( playerid, "Document:Index" ) ][d_name]>;
				
				DeletePVar( playerid, "Document:Player" );
				DeletePVar( playerid, "Document:Index" );
				
				return 1;
			}
			
			if( !listitem )
			{
				clean:<g_string>;
				strcat( g_string, ""gbDialog"Выберите тип документа"cWHITE"" );
				
				for( new i; i < sizeof document_type; i++ )
				{
					format:g_small_string( "\n%s", document_type[i] );
					strcat( g_string, g_small_string );
				}
				
				return showPlayerDialog( playerid, d_meria + 10, DIALOG_STYLE_LIST, " ",g_string, "Выбрать", "Закрыть" );
			}
			
			new
				takeid = GetPVarInt( playerid, "Document:Player" ),
				index = GetPVarInt( playerid, "Document:Index" );
				
			Document[takeid][index][d_type] = listitem - 1;
			
			format:g_string( "\
				"cWHITE"Создание документа "cBLUE"%s"cWHITE" для "cBLUE"%s\n\n\
				"cWHITE"Введите текст документа:\n\n\
				"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
				а максимальное количество символов в документе - 512.\n\
				Оставьте поле пустым по завершению создания документа.", document_type[ listitem - 1 ], Player[takeid][uName] );
				
			showPlayerDialog( playerid, d_meria + 11, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
		}
		
		case d_meria + 11:
		{
			if( !response )
			{
				clean:<Document[ GetPVarInt( playerid, "Document:Player" ) ][ GetPVarInt( playerid, "Document:Index" ) ][d_name]>;
				clean:<Document[ GetPVarInt( playerid, "Document:Player" ) ][ GetPVarInt( playerid, "Document:Index" ) ][d_text]>;
				Document[ GetPVarInt( playerid, "Document:Player" ) ][ GetPVarInt( playerid, "Document:Index" ) ][d_type] = 0;
				
				DeletePVar( playerid, "Document:Player" );
				DeletePVar( playerid, "Document:Index" );
				
				return 1;
			}
			
			new
				takeid = GetPVarInt( playerid, "Document:Player" ),
				index = GetPVarInt( playerid, "Document:Index" );
			
			if( Document[takeid][index][d_text][0] == EOS )
			{
				if( inputtext[0] == EOS )
				{
					format:g_string( "\
						"cWHITE"Создание документа "cBLUE"%s"cWHITE" для "cBLUE"%s\n\n\
						"cWHITE"Введите текст документа:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в документе - 512.\n\
						Оставьте поле пустым по завершению создания документа.\n\n\
						"gbDialogError"Поле для ввода пустое.", document_type[ Document[takeid][index][d_type] ], Player[takeid][uName] );
						
					return showPlayerDialog( playerid, d_meria + 11, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
				}
				else if( strlen( inputtext ) > 128 )
				{
					format:g_string( "\
						"cWHITE"Создание документа "cBLUE"%s"cWHITE" для "cBLUE"%s\n\n\
						"cWHITE"Введите текст документа:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в документе - 512.\n\
						Оставьте поле пустым по завершению создания документа.\n\n\
						"gbDialogError"Превышен допустимый лимит символов в строке.", document_type[ Document[takeid][index][d_type] ], Player[takeid][uName] );
						
					return showPlayerDialog( playerid, d_meria + 11, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
				}
				
				strcat( Document[takeid][index][d_text], inputtext, 512 );
				
				format:g_big_string( "\
					"cWHITE"Создание документа "cBLUE"%s"cWHITE" для "cBLUE"%s\n\n\
					"cWHITE"Введите текст документа:\n\n\
					"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
					а максимальное количество символов в документе - 512.\n\
					Оставьте поле пустым по завершению создания документа.\n\n\
					"cBLUE"Текст:"cWHITE"\n\
					%s", document_type[ Document[takeid][index][d_type] ], Player[takeid][uName], Document[takeid][index][d_text] );
						
				return showPlayerDialog( playerid, d_meria + 11, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
			}
			else
			{
				if( inputtext[0] != EOS )
				{
					if( strlen( inputtext ) > 128 )
					{
						format:g_big_string( "\
							"cWHITE"Создание документа "cBLUE"%s"cWHITE" для "cBLUE"%s\n\n\
							"cWHITE"Введите текст документа:\n\n\
							"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
							а максимальное количество символов в документе - 512.\n\
							Оставьте поле пустым по завершению создания документа.\n\n\
							"cBLUE"Текст:"cWHITE"\n\
							%s\n\n\
							"gbDialogError"Превышен допустимый лимит символов в строке.", document_type[ Document[takeid][index][d_type] ], Player[takeid][uName], Document[takeid][index][d_text] );
								
						return showPlayerDialog( playerid, d_meria + 11, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
					else if( Document[takeid][index][d_text][511] != EOS )
					{
						format:g_big_string( "\
							"cWHITE"Создание документа "cBLUE"%s"cWHITE" для "cBLUE"%s\n\n\
							"cWHITE"Введите текст документа:\n\n\
							"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
							а максимальное количество символов в документе - 512.\n\
							Оставьте поле пустым по завершению создания документа.\n\n\
							"cBLUE"Текст:"cWHITE"\n\
							%s\n\n\
							"gbDialogError"Превышен допустимый лимит символов в документе.", document_type[ Document[takeid][index][d_type] ], Player[takeid][uName], Document[takeid][index][d_text] );
								
						return showPlayerDialog( playerid, d_meria + 11, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
					}
					
					strcat( Document[takeid][index][d_text], "\n", 512 );
					strcat( Document[takeid][index][d_text], inputtext, 512 );
					
					format:g_big_string( "\
						"cWHITE"Создание документа "cBLUE"%s"cWHITE" для "cBLUE"%s\n\n\
						"cWHITE"Введите текст документа:\n\n\
						"cGRAY"Вводите текст по строкам, в одной строке - не более 128 символов,\n\
						а максимальное количество символов в документе - 512.\n\
						Оставьте поле пустым по завершению создания документа.\n\n\
						"cBLUE"Текст:"cWHITE"\n\
						%s", document_type[ Document[takeid][index][d_type] ], Player[takeid][uName], Document[takeid][index][d_text] );
							
					return showPlayerDialog( playerid, d_meria + 11, DIALOG_STYLE_INPUT, " ", g_big_string, "Далее", "Закрыть" );
				}
			}
			
			format:g_string( "\
				"cBLUE"Создание документа для %s\n\n\
				"cWHITE"Тип: "cBLUE"%s\n\n\
				"cWHITE"Текст:\n\
				"cGRAY"%s\n\n\
				"cWHITE"Вы действительно желаете создать этот документ?", 
				Player[takeid][uName], 
				document_type[ Document[takeid][index][d_type] ], 
				Document[takeid][index][d_text] );
				
			showPlayerDialog( playerid, d_meria + 12, DIALOG_STYLE_MSGBOX, " ", g_string, "Да", "Нет" );
		}
		
		case d_meria + 12:
		{
			new
				takeid = GetPVarInt( playerid, "Document:Player" ),
				index = GetPVarInt( playerid, "Document:Index" );
		
			if( !response )
			{
				clean:<Document[ takeid ][ index ][d_name]>;
				clean:<Document[ takeid ][ index ][d_text]>;
				
				Document[ takeid ][ index ][d_type] = 0;
				
				DeletePVar( playerid, "Document:Player" );
				DeletePVar( playerid, "Document:Index" );
				
				return 1;
			}
			
			if( !IsLogged( takeid ) || GetDistanceBetweenPlayers( playerid, takeid ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( takeid ) )
			{
				clean:<Document[ takeid ][ index ][d_name]>;
				clean:<Document[ takeid ][ index ][d_text]>;
				
				Document[ takeid ][ index ][d_type] = 0;
				
				DeletePVar( playerid, "Document:Player" );
				DeletePVar( playerid, "Document:Index" );
				
				SendClient:( playerid, C_WHITE, !""gbError"Произошла ошибка при создании документа." );
				
				return 1;
			}
			
			Document[ takeid ][ index ][d_date] = gettime();
			
			mysql_format:g_big_string( "INSERT INTO `"DB_DOCUMENT"`\
				( `d_user_id`, `d_type`, `d_date`, `d_name`, `d_text` ) VALUES \
				( %d, %d, %d, '%s', '%e' )",
				Player[takeid][uID],
				Document[ takeid ][ index ][d_type], 
				Document[ takeid ][ index ][d_date],
				Document[ takeid ][ index ][d_name],
				Document[ takeid ][ index ][d_text] );
				
			mysql_tquery( mysql, g_big_string, "InsertDocument", "dd", takeid, index );
			
			pformat:( ""gbDefault"%s подписал для Вас документ. Используйте "cBLUE"/doc"cWHITE", чтобы открыть свои документы.", Player[playerid][uName] );
			psend:( takeid, C_WHITE );
			
			pformat:( ""gbSuccess"Вы создали документ для "cBLUE"%s[%d]"cWHITE".", Player[takeid][uName], takeid );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Document:Player" );
			DeletePVar( playerid, "Document:Index" );
		}
		//Мои документы
		case d_meria + 13:
		{
			if( !response ) return 1;
			
			SetPVarInt( playerid, "Document:Index", g_dialog_select[playerid][listitem] );
			
			ShowDocument( playerid, playerid, g_dialog_select[playerid][listitem], d_meria + 14, "Действия", "Назад" );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_meria + 14:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Document:Index" );
				return cmd_doc( playerid );
			}
			
			showPlayerDialog( playerid, d_meria + 15, DIALOG_STYLE_LIST, "Действия", ""cGRAY"Показать документ\n"cGRAY"Удалить документ", "Выбрать", "Назад" );
		}
		
		case d_meria + 15:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Document:Index" );
				return cmd_doc( playerid );
			}
			
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_meria + 16, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Показать документ\n\n\
						"cWHITE"Введите ID игрока, которому желаете показать этот документ:", "Далее", "Назад" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_meria + 17, DIALOG_STYLE_MSGBOX, " ", "\
						"cBLUE"Удалить документ\n\n\
						"cWHITE"Вы действительно желаете уничтожить этот документ?", "Да", "Нет" );
				}
			}
		}
		
		case d_meria + 16:
		{
			if( !response ) return showPlayerDialog( playerid, d_meria + 15, DIALOG_STYLE_LIST, "Действия", ""cGRAY"Показать документ\n"cGRAY"Удалить документ", "Выбрать", "Назад" );

			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) > MAX_PLAYERS || strval( inputtext ) < 0 )
			{
				return showPlayerDialog( playerid, d_meria + 16, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Показать документ\n\n\
					"cWHITE"Введите ID игрока, которому желаете показать этот документ:\n\
					"gbDialogError"Неправильный формат ввода.", "Далее", "Назад" );
			}
			
			if( !IsLogged( strval( inputtext ) ) || strval( inputtext ) == playerid )
			{
				return showPlayerDialog( playerid, d_meria + 16, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Показать документ\n\n\
					"cWHITE"Введите ID игрока, которому желаете показать этот документ:\n\
					"gbDialogError"Некорректный ID игрока.", "Далее", "Назад" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( strval( inputtext ) ) )
			{
				return showPlayerDialog( playerid, d_meria + 16, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Показать документ\n\n\
					"cWHITE"Введите ID игрока, которому желаете показать этот документ:\n\
					"gbDialogError"Данного игрока нет рядом с Вами.", "Далее", "Назад" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } )
			{
				return showPlayerDialog( playerid, d_meria + 16, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Показать документ\n\n\
					"cWHITE"Введите ID игрока, которому желаете показать этот документ:\n\
					"gbDialogError"Вы не можете взаимодействовать с данным игроком.", "Далее", "Назад" );
			}
			
			ShowDocument( strval( inputtext ), playerid, GetPVarInt( playerid, "Document:Index" ), INVALID_DIALOG_ID, "Закрыть" );
			
			format:g_small_string( "показал%s документ", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
			
			pformat:( ""gbDefault"Вы показали документ "cBLUE"%s[%d]"cWHITE".", Player[ strval( inputtext ) ][uName], strval( inputtext ) );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Document:Index" );
		}
		
		case d_meria + 17:
		{
			if( response ) return showPlayerDialog( playerid, d_meria + 15, DIALOG_STYLE_LIST, "Действия", ""cGRAY"Показать документ\n"cGRAY"Удалить документ", "Выбрать", "Назад" );
			
			new
				index = GetPVarInt( playerid, "Document:Index" );
			
			mysql_format:g_small_string( "DELETE FROM `"DB_DOCUMENT"` WHERE `d_id` = %d LIMIT 1", Document[playerid][index][d_id] );
			mysql_tquery( mysql, g_small_string );
			
			Document[playerid][index][d_id] = 
			Document[playerid][index][d_type] = 
			Document[playerid][index][d_date] = 0;
			
			clean:<Document[playerid][index][d_text]>;
			clean:<Document[playerid][index][d_name]>;
			
			SendClient:( playerid, C_WHITE, ""gbDefault"Вы успешно удалили документ." );
			
			DeletePVar( playerid, "Document:Index" );
		}
	}
	
	return 1;
}