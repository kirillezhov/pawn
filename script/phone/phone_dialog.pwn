Phone_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	//Диалог, если телефон выключен
	switch( dialogid )
	{
		case d_phone:
		{
			if( !response ) return 1;
			
			new
				phone = GetPVarInt( playerid, "Phone:Select" );
			
			Phone[playerid][phone][p_settings][0] = 1;
			UpdatePhoneSettings( Phone[playerid][phone][p_number], Phone[playerid][phone][p_settings] );
			
			ShowPhone( playerid, true );
		}
		
		//Диалог выключения
		case d_phone + 1:
		{
			if( !response ) return 1;
			
			new
				phone = GetPVarInt( playerid, "Phone:Select" );
			
			Phone[playerid][phone][p_settings][0] = 0;
			UpdatePhoneSettings( Phone[playerid][phone][p_number], Phone[playerid][phone][p_settings] );
			
			ShowPhone( playerid, false );
		}
		
		//Телефонная книга
		case d_phone + 2:
		{
			if( !response ) return 1;
			
			new
				bool:flag = false;
			
			switch( listitem )
			{
				case 0:
				{
					for( new i; i < MAX_CONTACTS; i++ )
					{
						if( !PhoneContacts[playerid][i][p_id] )
						{
							flag = true;
							break;
						}
					}
					
					if( !flag )
					{
						SendClient:( playerid, C_WHITE, ""gbError"В телефонной книге закончилась память!" );
						OpenPhoneBook( playerid );
						return 1;
					}
				
					showPlayerDialog( playerid, d_phone + 3, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Добавление контакта\n\n\
						"cWHITE"Введите номер телефона:\n\n\
						"gbDialog"Номер телефона может содержать только цифры.",
					"Далее", "Назад" );
				}
				
				default:
				{
					SetPVarInt( playerid, "Phone:Contact", g_dialog_select[playerid][listitem - 1] );
					g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
				
					showPlayerDialog( playerid, d_phone + 5, DIALOG_STYLE_LIST, " ", "\
						"cWHITE"Позвонить\n\
						"cWHITE"Написать сообщение\n\
						"cWHITE"Изменить контакт\n\
						"cWHITE"Удалить контакт",
					"Выбрать", "Назад" );
				}
			}
		}
		
		//Ввод номера на добавление контакта
		case d_phone + 3:
		{
			if( !response ) 
			{
				OpenPhoneBook( playerid );
				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				return showPlayerDialog( playerid, d_phone + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Добавление контакта\n\n\
					"cWHITE"Введите номер телефона:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.\n\
					"gbDialogError"Неправильный формат значения, повторите ввод.",
				"Далее", "Назад" );
			}
			
			if( strval( inputtext ) == GetPhoneNumber( playerid ) )
			{
				return showPlayerDialog( playerid, d_phone + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Добавление контакта\n\n\
					"cWHITE"Введите номер телефона:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.\n\
					"gbDialogError"Вы не можете добавить контакт со своим номером.",
				"Далее", "Назад" );
			}
			
			SetPVarInt( playerid, "Phone:Number", strval( inputtext ) );
			
			showPlayerDialog( playerid, d_phone + 4, DIALOG_STYLE_INPUT, " ", "\
				"cBLUE"Добавление контакта\n\n\
				"cWHITE"Введите имя:",
			"Далее", "Назад" );
		}
		
		case d_phone + 4:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Добавление контакта\n\n\
					"cWHITE"Введите номер телефона:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.",
				"Далее", "Назад" );
			}
			
			if( inputtext[0] == EOS )
			{
				return showPlayerDialog( playerid, d_phone + 4, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Добавление контакта\n\n\
					"cWHITE"Введите имя:\n\n\
					"gbDialogError"Поле для ввода пустое.",
				"Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 25 )
			{
				return showPlayerDialog( playerid, d_phone + 4, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Добавление контакта\n\n\
					"cWHITE"Введите имя:\n\n\
					"gbDialogError"Превышено допустимое количество символов.",
				"Далее", "Назад" );
			}
			
			CreateContact( playerid, inputtext );
			
			OpenPhoneBook( playerid );
		}
		
		case d_phone + 5:
		{
			if( !response ) 
			{
				OpenPhoneBook( playerid );
				return 1;
			}
			
			new
				contact = GetPVarInt( playerid, "Phone:Contact" );
			
			switch( listitem )
			{
				case 0:
				{
					if( !IsPlayerInNetwork( playerid ) )
					{
						SendClient:( playerid, C_WHITE, !NO_NETWORK );
						showPlayerDialog( playerid, d_phone + 5, DIALOG_STYLE_LIST, " ", "\
							"cWHITE"Позвонить\n\
							"cWHITE"Написать сообщение\n\
							"cWHITE"Изменить контакт\n\
							"cWHITE"Удалить контакт",
						"Выбрать", "Назад" );
						return 1;
					}
				
					if( !CheckNumberNetwork( playerid, PhoneContacts[playerid][contact][p_number] ) ) 
					{
						Call[playerid][c_call_id] = 0;
						showPlayerDialog( playerid, d_phone + 5, DIALOG_STYLE_LIST, " ", "\
							"cWHITE"Позвонить\n\
							"cWHITE"Написать сообщение\n\
							"cWHITE"Изменить контакт\n\
							"cWHITE"Удалить контакт",
						"Выбрать", "Назад" );
						return 1;
					}
					
					new
						callid = Call[playerid][c_call_id];
						
					if( GetPVarInt( callid, "Phone:Call" ) || GetPVarInt( callid, "San:Call" ) )
					{
						SendClient:( playerid, C_WHITE, ""gbPhone"Абонент занят." );
						
						Call[playerid][c_call_id] = 0;
						showPlayerDialog( playerid, d_phone + 5, DIALOG_STYLE_LIST, " ", "\
							"cWHITE"Позвонить\n\
							"cWHITE"Написать сообщение\n\
							"cWHITE"Изменить контакт\n\
							"cWHITE"Удалить контакт",
						"Выбрать", "Назад" );
						return 1;
					}					
					
					pformat:( ""gbPhone"Исходящий вызов "cBLUE"%d "cWHITE"%s"cGRAY"...( "cBLUE"H"cGRAY" )", PhoneContacts[playerid][contact][p_number], PhoneContacts[playerid][contact][p_name] );
					psend:( playerid, C_WHITE );
						
					if( !CheckIncomingNumber( callid, GetPhoneNumber( playerid ) ) )
					{
						pformat:( ""gbPhone"Входящий вызов "cBLUE"%d"cGRAY"...( "cGREEN"Y"cGRAY" | "cRED"N"cGRAY" )", GetPhoneNumber( playerid ) );
						psend:( callid, C_WHITE );
					}
					else
					{
						pformat:( ""gbPhone"Входящий вызов "cWHITE"%s"cGRAY"...( "cGREEN"Y"cGRAY" | "cRED"N"cGRAY" )", Call[callid][c_name] );
						psend:( callid, C_WHITE );
					}
					
					PlayerPlaySound( playerid, 3600, 0.0, 0.0, 0.0 );
					PlayerPlaySound( callid, call_sound[Call[playerid][c_sound]][s_id], 0.0, 0.0, 0.0 );
										
					Call[callid][c_status] = true;
					Call[callid][c_call_id] = playerid;
					
					SetPVarInt( playerid, "Phone:Call", 1 );
					SetPVarInt( callid, "Phone:Call", 1 );
					
					PhoneStatus( playerid, true );
				}
				
				case 1:
				{
					if( !IsPlayerInNetwork( playerid ) )
					{
						SendClient:( playerid, C_WHITE, !NO_NETWORK );
						return showPlayerDialog( playerid, d_phone + 5, DIALOG_STYLE_LIST, " ", "\
							"cWHITE"Позвонить\n\
							"cWHITE"Написать сообщение\n\
							"cWHITE"Изменить контакт\n\
							"cWHITE"Удалить контакт",
						"Выбрать", "Назад" );
					}
				
					clean:<g_string>;
					mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PHONES " WHERE p_number = %d", PhoneContacts[playerid][contact][p_number] );
					mysql_tquery( mysql, g_string, "CheckNumber", "d", playerid );
				
					format:g_small_string( "\
						"cBLUE"Новое сообщение\n\n\
						"gbDialog"Получатель: "cWHITE"%s\n\n\
						"cWHITE"Введите текст сообщения:",
						PhoneContacts[playerid][contact][p_name]
					);
					
					showPlayerDialog( playerid, d_phone + 20, DIALOG_STYLE_INPUT, " ", g_small_string, "Отправить", "Назад" );
				}
				
				case 2:
				{
					showPlayerDialog( playerid, d_phone + 6, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Изменение контакта\n\n\
						"cWHITE"Введите новый номер телефона:\n\n\
						"gbDialog"Введите 0, если номер остается неизменным.",
					"Далее", "Назад" );
				}
				
				case 3:
				{
					showPlayerDialog( playerid, d_phone + 8, DIALOG_STYLE_MSGBOX, " ", "\
						"cWHITE"Вы уверены, что желаете удалить этот контакт?",
					"Да", "Нет" );
				}
			}
		}
		
		case d_phone + 6:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 5, DIALOG_STYLE_LIST, " ", "\
					"cWHITE"Позвонить\n\
					"cWHITE"Написать сообщение\n\
					"cWHITE"Изменить контакт\n\
					"cWHITE"Удалить контакт",
				"Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				return showPlayerDialog( playerid, d_phone + 6, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменение контакта\n\n\
					"cWHITE"Введите новый номер телефона:\n\n\
					"gbDialog"Введите 0, если номер остается неизменным.\n\n\
					"gbDialogError"Неправильный формат значения, повторите ввод.",
				"Далее", "Назад" );
			}
			
			new
				contact = GetPVarInt( playerid, "Phone:Contact" );
			
			if(  strval( inputtext ) == 0 )
			{
				SetPVarInt( playerid, "Phone:Number", PhoneContacts[playerid][contact][p_number] );
			}
			else
				SetPVarInt( playerid, "Phone:Number", strval( inputtext ) );
			
			showPlayerDialog( playerid, d_phone + 7, DIALOG_STYLE_INPUT, " ", "\
				"cBLUE"Изменение контакта\n\n\
				"cWHITE"Введите новое имя:\n\n\
				"gbDialog"Оставьте поле пустым, если имя остается неизменным.",
			"Далее", "Назад" );
		}
		
		case d_phone + 7:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 6, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменение контакта\n\n\
					"cWHITE"Введите новый номер телефона:\n\n\
					"gbDialog"Введите 0, если номер остается неизменным.",
				"Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 25 )
			{
				return showPlayerDialog( playerid, d_phone + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменение контакта\n\n\
					"cWHITE"Введите новое имя:\n\n\
					"gbDialog"Оставьте поле пустым, если имя остается неизменным.\n\n\
					"gbDialogError"Превышено допустимое количество символов.",
				"Далее", "Назад" );
			}
			
			new
				contact = GetPVarInt( playerid, "Phone:Contact" );
			
			if( inputtext[0] == EOS )
			{
				UpdateContact( playerid, contact, PhoneContacts[playerid][contact][p_name] );
			}
			else
				UpdateContact( playerid, contact, inputtext );
			
			DeletePVar( playerid, "Phone:Contact" );
			OpenPhoneBook( playerid );
		}
		
		//Удаление контакта
		case d_phone + 8:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 5, DIALOG_STYLE_LIST, " ", "\
					"cWHITE"Позвонить\n\
					"cWHITE"Написать сообщение\n\
					"cWHITE"Изменить контакт\n\
					"cWHITE"Удалить контакт",
				"Выбрать", "Назад" );
			}
			
			DeleteContact( playerid, GetPVarInt( playerid, "Phone:Contact" ) );
			
			DeletePVar( playerid, "Phone:Contact" );
			
			OpenPhoneBook( playerid );
		}
		
		//Диалог настроек
		case d_phone + 9:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0:
				{
					clean:<g_string>;
			
					for( new i; i < sizeof color_name; i++ )
					{
						format:g_small_string( ""cWHITE"%s\n", color_name[i] );
						strcat( g_string, g_small_string );
					}
					
					showPlayerDialog( playerid, d_phone + 10, DIALOG_STYLE_LIST, "Выбрать панель", g_string, "Установить", "Назад" );
				}
				
				case 1:
				{
					ShowListSound( playerid );
				}
				
				case 2:
				{
					if( !IsPlayerInNetwork( playerid ) )
					{
						return showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", "\
							"cBLUE"Состояние сети\n\n\
							"cWHITE"Сим карта SA:Telecom\n\n\
							"cGRAY"Нет сети",
						"Закрыть", "" );
					}
					
					new
						network = GetNetwork( playerid ),
						Float:distance,
						Float:interval,
						percent;
						
					distance = GetPlayerDistanceFromPoint( playerid, action_network[network][0], action_network[network][1], action_network[network][2] );
					interval = distance/action_network[network][3];
					percent = 100 - floatround( interval * 100 );
					
					switch( percent )
					{
						case 0..15: format:g_small_string( ""cGRAY"Состояние сети: "cRED"очень плохое" );
				
						case 16..44: format:g_small_string( ""cGRAY"Состояние сети: "cRED"плохое" );
						
						case 45..84: format:g_small_string( ""cGRAY"Состояние сети: "cYELLOW"хорошее" );
						
						case 85..100: format:g_small_string( ""cGRAY"Состояние сети: "cGREEN"отличное" );
					}
					
					clean:<g_string>;
					
					strcat( g_string, "\
						"cBLUE"Состояние сети\n\n\
						"cWHITE"Сим карта SA:Telecom\n\n" );
					strcat( g_string, g_small_string );
					
					return showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_string, "Закрыть", "" );
				}
			}
		}
		
		case d_phone + 10:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 9, DIALOG_STYLE_LIST, "Настройки", "\
					"cWHITE"Изменить цвет панели\n\
					"cWHITE"Изменить мелодию вызова\n\
					"cWHITE"Проверить состояние сети",
				"Выбрать", "Закрыть" );
			}
			
			new
				phone = GetPVarInt( playerid, "Phone:Select" );
			
			switch( GetUsePhone( playerid ) )
			{
				case 18874:
				{
					TextDrawHideForPlayer( playerid, phoneFonOne[Phone[playerid][phone][p_settings][1]] );
					
					Phone[playerid][phone][p_settings][1] = listitem;
					UpdatePhoneSettings( Phone[playerid][phone][p_number], Phone[playerid][phone][p_settings] );
			
					TextDrawShowForPlayer( playerid, phoneFonOne[Phone[playerid][phone][p_settings][1]] );
				}
				
				case 18872:
				{
					TextDrawHideForPlayer( playerid, phoneFonThree[Phone[playerid][phone][p_settings][1]] );
					
					Phone[playerid][phone][p_settings][1] = listitem;
					UpdatePhoneSettings( Phone[playerid][phone][p_number], Phone[playerid][phone][p_settings] );
			
					TextDrawShowForPlayer( playerid, phoneFonThree[Phone[playerid][phone][p_settings][1]] );
				}
			}
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Цвет панели Вашего телефона изменен." );
			
			clean:<g_string>;
			
			for( new i; i < sizeof color_name; i++ )
			{
				format:g_small_string( ""cWHITE"%s\n", color_name[i] );
				strcat( g_string, g_small_string );
			}
			
			showPlayerDialog( playerid, d_phone + 10, DIALOG_STYLE_LIST, "Выбрать панель", g_string, "Установить", "Назад" );
		}
		
		case d_phone + 11:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 9, DIALOG_STYLE_LIST, "Настройки", "\
					"cWHITE"Изменить цвет панели\n\
					"cWHITE"Изменить мелодию вызова\n\
					"cWHITE"Проверить состояние сети",
				"Выбрать", "Закрыть" );
			}
			
			SetPVarInt( playerid, "Phone:Sound", listitem );
			
			if( !listitem )
			{
				showPlayerDialog( playerid, d_phone + 24, DIALOG_STYLE_LIST, " ", "\
					"cWHITE"Установить",
				"Выбрать", "Назад" );
				return 1;
			}
			
			showPlayerDialog( playerid, d_phone + 12, DIALOG_STYLE_LIST, " ", "\
				"cWHITE"Прослушать\n\
				"cWHITE"Установить",
			"Выбрать", "Назад" );
		}
		
		case d_phone + 12:
		{
			if( !response )
			{	
				PlayerPlaySound( playerid, 0, 0.0, 0.0, 0.0 );
				ShowListSound( playerid );
				return 1;
			}
			
			new
				sound = GetPVarInt( playerid, "Phone:Sound" ),
				phone = GetPVarInt( playerid, "Phone:Select" );
			
			switch( listitem )
			{
				case 0:
				{
					PlayerPlaySound( playerid, call_sound[sound][s_id], 0.0, 0.0, 0.0 );
					
					return showPlayerDialog( playerid, d_phone + 12, DIALOG_STYLE_LIST, " ", "\
						"cWHITE"Прослушать\n\
						"cWHITE"Установить",
					"Выбрать", "Назад" );
				}
				
				case 1:
				{
					Phone[playerid][phone][p_settings][2] = sound;
					UpdatePhoneSettings( Phone[playerid][phone][p_number], Phone[playerid][phone][p_settings] );
				}
			}
			
			PlayerPlaySound( playerid, 0, 0.0, 0.0, 0.0 );
			SendClient:( playerid, C_WHITE, ""gbSuccess"Мелодия вызова изменена." );
			DeletePVar( playerid, "Phone:Sound" ); 
			ShowListSound( playerid );
		}
		
		//Диалог сообщений
		case d_phone + 13:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0:
				{
					if( !IsPlayerInNetwork( playerid ) )
					{
						SendClient:( playerid, C_WHITE, !NO_NETWORK );
						
						return showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
							"gbDialog"Написать сообщение\n\
							"cWHITE"Входящие сообщения\n\
							"cWHITE"Исходящие сообщения",
						"Выбрать", "Закрыть" );
					}
					
					showPlayerDialog( playerid, d_phone + 14, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Новое сообщение\n\n\
						"cWHITE"Введите номер телефона получателя:\n\n\
						"gbDialog"Номер телефона может содержать только цифры.",
					"Далее", "Назад" );
				}
				
				case 1:
				{
					ShowComingList( playerid );
				}
				
				case 2:
				{
					ShowIncomingList( playerid );
				}
			}
		}
		
		case d_phone + 14:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
					"gbDialog"Написать сообщение\n\
					"cWHITE"Входящие сообщения\n\
					"cWHITE"Исходящие сообщения",
				"Выбрать", "Закрыть" ); 
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				return showPlayerDialog( playerid, d_phone + 14, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Новое сообщение\n\n\
					"cWHITE"Введите номер телефона получателя:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.\n\n\
					"gbDialogError"Неправильный формат значения, повторите ввод.",
				"Далее", "Назад" );
			}
			
			if( strval( inputtext ) == GetPhoneNumber( playerid ) )
			{
				return showPlayerDialog( playerid, d_phone + 14, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Новое сообщение\n\n\
					"cWHITE"Введите номер телефона получателя:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.\n\n\
					"gbDialogError"Вы не можете отправить сообщение себе.",
				"Далее", "Назад" );
			}
			
			new
				bool:flag = false;
				
			for( new i; i < MAX_MESSAGES; i++ )
			{
				if( !Messages[playerid][i][m_id] )
				{
					flag = true;
					break;
				}
			}

			if( !flag )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Память телефона переполнена." );
				
				return showPlayerDialog( playerid, d_phone + 14, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Новое сообщение\n\n\
					"cWHITE"Введите номер телефона получателя:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.\n\n\
					"gbDialogError"Неправильный формат значения, повторите ввод.",
				"Далее", "Назад" );
			}
			
			clean:<g_string>;
			mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM " #DB_PHONES " WHERE p_number = %d", strval( inputtext ) );
			mysql_tquery( mysql, g_string, "CheckNumber", "d", playerid );
			
			format:g_small_string( "\
				"cBLUE"Новое сообщение\n\n\
				"gbDialog"Получатель: "cWHITE"%d\n\n\
				"cWHITE"Введите текст сообщения:",
				strval( inputtext ) 
			);
			
			SetPVarInt( playerid, "Phone:Number", strval( inputtext ) );
			
			showPlayerDialog( playerid, d_phone + 15, DIALOG_STYLE_INPUT, " ", g_small_string, "Отправить", "Назад" );
		}
		
		case d_phone + 15:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 14, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Новое сообщение\n\n\
					"cWHITE"Введите номер телефона получателя:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.",
				"Далее", "Назад" );
			}
			
			new
				number = GetPVarInt( playerid, "Phone:Number" ),
				phone = GetPVarInt( playerid, "Phone:Select" );
			
			if( strlen( inputtext ) > 120 )
			{
				format:g_small_string( "\
					"cBLUE"Новое сообщение\n\n\
					"gbDialog"Получатель: %d\n\n\
					"cWHITE"Введите текст сообщения:\n\n\
					"gbDialogError"Слишком длинный текст сообщения.",
					number 
				);
				
				return showPlayerDialog( playerid, d_phone + 15, DIALOG_STYLE_INPUT, " ", g_small_string, "Отправить", "Назад" );
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cBLUE"Новое сообщение\n\n\
					"gbDialog"Получатель: %d\n\n\
					"cWHITE"Введите текст сообщения:\n\n\
					"gbDialogError"Вы не можете отправить пустое сообщение.",
					number 
				);
				
				return showPlayerDialog( playerid, d_phone + 15, DIALOG_STYLE_INPUT, " ", g_small_string, "Отправить", "Назад" );
			}
			
			if( number == NEWS_NUMBER )
			{
				if( !ETHER_SMS || ETHER_STATUS == INVALID_PARAM )
				{
					SendClient:( playerid, C_WHITE, !""gbError"Ошибка при отправке сообщения." );
				}
				else
				{
					pformat:( "[Эфир %s] SMS от %s[%d], тел. %d: %s", 
							Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName], playerid, GetPhoneNumber( playerid ), inputtext );
					psend:( ETHER_STATUS, C_LIGHTGREEN );
				
					pformat:( ""gbSuccess"Сообщение на номер "cBLUE"%d"cWHITE" отправлено.", number );
					psend:( playerid, C_WHITE );
				
					CreateMessage( playerid, INVALID_PARAM, Phone[playerid][phone][p_number], number, inputtext );
				}
			
				IsValidPhone{playerid} = 0;
				DeletePVar( playerid, "Phone:Number" );
				
				return showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
					"gbDialog"Написать сообщение\n\
					"cWHITE"Входящие сообщения\n\
					"cWHITE"Исходящие сообщения",
				"Выбрать", "Закрыть" );
			}
			
			if( !IsValidPhone{playerid} )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Сообщение не отправлено. Указанного номера не существует." );
				DeletePVar( playerid, "Phone:Number" );
				
				return showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
					"gbDialog"Написать сообщение\n\
					"cWHITE"Входящие сообщения\n\
					"cWHITE"Исходящие сообщения",
				"Выбрать", "Закрыть" );
			}
			
			if( SendMessage( playerid, number ) )
			{
				if( GetPVarInt( playerid, "Phone:Playerid" ) )
				{
					CreateMessage( playerid, GetPVarInt( playerid, "Phone:Playerid" ) - 1, Phone[playerid][phone][p_number], number, inputtext );
					DeletePVar( playerid, "Phone:Playerid" );
				}
				else
					CreateMessage( playerid, INVALID_PARAM, Phone[playerid][phone][p_number], number, inputtext );
				
				pformat:( ""gbSuccess"Сообщение на номер "cBLUE"%d"cWHITE" отправлено.", number );
				psend:( playerid, C_WHITE );
			}
			
			IsValidPhone{playerid} = 0;
			DeletePVar( playerid, "Phone:Number" );
				
			showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
				"gbDialog"Написать сообщение\n\
				"cWHITE"Входящие сообщения\n\
				"cWHITE"Исходящие сообщения",
			"Выбрать", "Закрыть" );
		}
		
		case d_phone + 16:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
					"gbDialog"Написать сообщение\n\
					"cWHITE"Входящие сообщения\n\
					"cWHITE"Исходящие сообщения",
				"Выбрать", "Закрыть" );
			}
					
			ShowIncomingMessage( playerid, g_dialog_select[playerid][listitem] );
			SetPVarInt( playerid, "Phone:Message", g_dialog_select[playerid][listitem] );
			
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_phone + 17:
		{
			if( !response )
			{
				DeletePVar( playerid, "Phone:Message" );
				ShowIncomingList( playerid );
				return 1;
			}
			
			new
				message = GetPVarInt( playerid, "Phone:Message" );
				
			DeleteMessage( playerid, message );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Сообщение удалено." );
			
			showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
				"gbDialog"Написать сообщение\n\
				"cWHITE"Входящие сообщения\n\
				"cWHITE"Исходящие сообщения",
			"Выбрать", "Закрыть" );
		}
		
		case d_phone + 18:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
					"gbDialog"Написать сообщение\n\
					"cWHITE"Входящие сообщения\n\
					"cWHITE"Исходящие сообщения",
				"Выбрать", "Закрыть" );
			}
			
			ShowComingMessage( playerid, g_dialog_select[playerid][listitem] );
			SetPVarInt( playerid, "Phone:Message", g_dialog_select[playerid][listitem] );
			
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
		}
		
		case d_phone + 19:
		{
			if( !response )
			{
				DeletePVar( playerid, "Phone:Message" );
				ShowComingList( playerid );
				return 1;
			}
			
			new
				message = GetPVarInt( playerid, "Phone:Message" );
				
			DeleteMessage( playerid, message );
			SendClient:( playerid, C_WHITE, ""gbSuccess"Сообщение удалено." );
			
			showPlayerDialog( playerid, d_phone + 13, DIALOG_STYLE_LIST, "Сообщения", "\
				"gbDialog"Написать сообщение\n\
				"cWHITE"Входящие сообщения\n\
				"cWHITE"Исходящие сообщения",
			"Выбрать", "Закрыть" );
		}
		
		case d_phone + 20:
		{
			if( !response )
			{
				OpenPhoneBook( playerid );
				return 1;
			}
			
			new
				contact = GetPVarInt( playerid, "Phone:Contact" );
			
			if( strlen( inputtext ) > 120 )
			{
				format:g_small_string( "\
					"cBLUE"Новое сообщение\n\n\
					"gbDialog"Получатель: "cWHITE"%s\n\n\
					"cWHITE"Введите текст сообщения:\n\n\
					"gbDialogError"Слишком длинный текст сообщения.",
					PhoneContacts[playerid][contact][p_name]
				);
						
				return showPlayerDialog( playerid, d_phone + 20, DIALOG_STYLE_INPUT, " ", g_small_string, "Отправить", "Назад" );
			}
			
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cBLUE"Новое сообщение\n\n\
					"gbDialog"Получатель: "cWHITE"%s\n\n\
					"cWHITE"Введите текст сообщения:\n\n\
					"gbDialogError"Вы не можете отправить пустое сообщение.",
					PhoneContacts[playerid][contact][p_name]
				);
						
				return showPlayerDialog( playerid, d_phone + 20, DIALOG_STYLE_INPUT, " ", g_small_string, "Отправить", "Назад" );
			}
	
			
			
			if( !IsValidPhone{playerid} )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Сообщение не отправлено. Указанного номера не существует." );
				
				DeletePVar( playerid, "Phone:Contact" );
				
				OpenPhoneBook( playerid );
				return 1;
			}
			
			if( SendMessage( playerid, PhoneContacts[playerid][contact][p_number] ) )
			{
				if( GetPVarInt( playerid, "Phone:Playerid" ) )
				{
					CreateMessage( playerid, GetPVarInt( playerid, "Phone:Playerid" ) - 1, GetPhoneNumber( playerid ), PhoneContacts[playerid][contact][p_number], inputtext );
					DeletePVar( playerid, "Phone:Playerid" );
				}
				else
					CreateMessage( playerid, INVALID_PARAM, GetPhoneNumber( playerid ), PhoneContacts[playerid][contact][p_number], inputtext );
				
				pformat:( ""gbSuccess"Сообщение контакту "cBLUE"%s"cWHITE" отправлено.", PhoneContacts[playerid][contact][p_name] );
				psend:( playerid, C_WHITE );
			}
			
			IsValidPhone{playerid} = 0;
			DeletePVar( playerid, "Phone:Number" );
			DeletePVar( playerid, "Phone:Contact" );
			OpenPhoneBook( playerid );
		}
		
		case d_phone + 21:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_phone + 22, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Новый вызов\n\n\
						"cWHITE"Введите номер телефона:\n\n\
						"gbDialog"Номер телефона может содержать только цифры.",
					"Вызов", "Назад" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_phone + 23, DIALOG_STYLE_LIST, " ", "\
						"cWHITE"Экстренная служба\n\
						"cWHITE"Служба такси\n\
						"cWHITE"Автомобильная сервисная служба",
					"Вызов", "Назад" );
				}
				
				case 2:
				{
					showPlayerDialog( playerid, d_phone + 29, DIALOG_STYLE_LIST, " ", "\
						"cWHITE"Новостная корпорация",
					"Вызов", "Назад" );
				}
				
				case 3:
				{
					format:g_small_string( "\
						"cBLUE"SA:Telecom\n\n\
						"gbSuccess"Ваш номер: %d",
						GetPhoneNumber( playerid )
					);
					
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );
				}
			}
		}
		
		case d_phone + 22:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"Набрать номер\n\
					"cWHITE"Номера сервисных служб\n\
					Другие номера\n\
					Узнать свой номер",
				"Выбрать", "Закрыть" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 10000000 )
			{
				return showPlayerDialog( playerid, d_phone + 22, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Новый вызов\n\n\
					"cWHITE"Введите номер телефона:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.\n\n\
					"gbDialogError"Неправильный формат значения, повторите ввод.",
				"Вызов", "Назад" );
			}
			
			if( strval( inputtext ) == GetPhoneNumber( playerid ) )
			{
				return showPlayerDialog( playerid, d_phone + 22, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Новый вызов\n\n\
					"cWHITE"Введите номер телефона:\n\n\
					"gbDialog"Номер телефона может содержать только цифры.\n\n\
					"gbDialogError"Вы не можете позвонить на свой телефон.",
				"Вызов", "Назад" );
			}
			
			if( strval( inputtext ) == NUMBER_GUNDEALER )
			{
				if( !Player[playerid][uCrimeM] )
				{
					return showPlayerDialog( playerid, d_phone + 22, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Новый вызов\n\n\
						"cWHITE"Введите номер телефона:\n\n\
						"gbDialog"Номер телефона может содержать только цифры.\n\n\
						"gbDialogError"Телефон с таким номером не зарегистрирован в сети.",
					"Вызов", "Назад" );
				}
				
				new
					crime = getIndexCrimeFraction( Player[playerid][uCrimeM] ),
					rank,
					day, hour, minute,
					Float:interval, Float:interval_2, Float:interval_3;
					
				if( PlayerLeaderCrime( playerid, crime ) ) goto next;
				
				rank = getCrimeRankId( playerid, crime );
				
				if( !CrimeRank[crime][rank][r_call_weapon] )
				{
					return showPlayerDialog( playerid, d_phone + 22, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Новый вызов\n\n\
						"cWHITE"Введите номер телефона:\n\n\
						"gbDialog"Номер телефона может содержать только цифры.\n\n\
						"gbDialogError"Вы не можете совершить звонок на этот номер.",
					"Вызов", "Назад" );
				}
				
				next:
				
				if( !CrimeFraction[crime][c_type_weapon] )
				{
					return showPlayerDialog( playerid, d_phone + 22, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Новый вызов\n\n\
						"cWHITE"Введите номер телефона:\n\n\
						"gbDialog"Номер телефона может содержать только цифры.\n\n\
						"gbDialogError"Вы не можете совершить звонок на этот номер.",
					"Вызов", "Назад" );
				}
				
				if( CrimeFraction[crime][c_time] )
				{
					interval = float( CrimeFraction[crime][c_time] - gettime() ) / 86400.0;
					day = floatround( interval, floatround_floor );
					
					interval_2 = ( interval - float( day ) ) * 86400.0 / 3600.0;
					hour = floatround( interval_2, floatround_floor );
					
					interval_3 = ( interval_2 - float( hour ) ) * 3600.0 / 60.0;
					minute = floatround( interval_3 );
				
					format:g_small_string( "\
						"cBLUE"Новый вызов\n\n\
						"cWHITE"Введите номер телефона:\n\n\
						"gbDialog"Номер телефона может содержать только цифры.\n\n\
						"gbDialogError"Повторный звонок Вы сможете сделать через %d дн. %d ч. %d мин.",
						day, hour, minute );
					return showPlayerDialog( playerid, d_phone + 22, DIALOG_STYLE_INPUT, " ", g_small_string, "Вызов", "Назад" );
				}
				
				format:g_string( dialog_gundealer, CrimeFraction[crime][c_type_weapon], DAYS_TO_GUNDEALER );
				return showPlayerDialog( playerid, d_crime + 33, DIALOG_STYLE_MSGBOX, " ", g_string, "Далее", "Отмена" );
			}
			
			if( !CheckNumberNetwork( playerid, strval( inputtext ) ) )
			{
				Call[playerid][c_call_id] = 0;
				
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"Набрать номер\n\
					"cWHITE"Номера сервисных служб\n\
					Другие номера\n\
					Узнать свой номер",
				"Выбрать", "Закрыть" );
			}
			
			new
				callid = Call[playerid][c_call_id];
				
			if( GetPVarInt( callid, "Phone:Call" ) )
			{
				SendClient:( playerid, C_WHITE, ""gbPhone"Абонент занят." );
						
				Call[playerid][c_call_id] = 0;
				
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"Набрать номер\n\
					"cWHITE"Номера сервисных служб\n\
					Другие номера\n\
					Узнать свой номер",
				"Выбрать", "Закрыть" );
			}					
					
			pformat:( ""gbPhone"Исходящий вызов "cBLUE"%d "cGRAY"...( "cBLUE"H"cGRAY" )",  strval( inputtext ) );
			psend:( playerid, C_WHITE );
						
			if( !CheckIncomingNumber( callid, GetPhoneNumber( playerid ) ) )
			{
				pformat:( ""gbPhone"Входящий вызов "cBLUE"%d"cGRAY"...( "cGREEN"Y"cGRAY" | "cRED"N"cGRAY" )", GetPhoneNumber( playerid ) );
				psend:( callid, C_WHITE );
			}
			else
			{
				pformat:( ""gbPhone"Входящий вызов "cWHITE"%s"cGRAY"...( "cGREEN"Y"cGRAY" | "cRED"N"cGRAY" )", Call[callid][c_name] );
				psend:( callid, C_WHITE );
			}
					
			PlayerPlaySound( playerid, 3600, 0.0, 0.0, 0.0 );
			PlayerPlaySound( callid, call_sound[Call[playerid][c_sound]][s_id], 0.0, 0.0, 0.0 );
										
			Call[callid][c_status] = true;
			Call[callid][c_call_id] = playerid;
					
			SetPVarInt( playerid, "Phone:Call", 1 );
			SetPVarInt( callid, "Phone:Call", 1 );
					
			PhoneStatus( playerid, true );
		}
		
		case d_phone + 23:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"Набрать номер\n\
					"cWHITE"Номера сервисных служб\n\
					Другие номера\n\
					Узнать свой номер",
				"Выбрать", "Закрыть" );
			}
			
			switch( listitem )
			{
				//Экстренный вызов
				case 0:
				{
					if( Player[playerid][jPolice] )
						return SendClient:( playerid, C_WHITE, ""gbError"Вы уже подали заявку в службу 911." );
				
					showPlayerDialog( playerid, d_phone + 27, DIALOG_STYLE_TABLIST, ""cBLUE"Служба 911", ""cWHITE"\
						POLICE\n\
						FIRE & EMS\n\
						POLICE & FIRE & EMS", 
					"Вызов", "Назад" );
				}
				
				//Служба такси
				case 1:
				{
					if( !IsPlayerInNetwork( playerid ) )
					{
						SendClient:( playerid, C_WHITE, !NO_NETWORK );
						
						return showPlayerDialog( playerid, d_phone + 23, DIALOG_STYLE_LIST, " ", "\
							"cWHITE"Экстренная служба\n\
							"cWHITE"Служба такси\n\
							"cWHITE"Автомобильная сервисная служба",
						"Вызов", "Назад" );
					}
				
					showPlayerDialog( playerid, d_phone + 25, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Служба такси\n\n\
						"cWHITE"Пожалуйста, коротко сообщите о своем местоположении диспетчеру:\n\n\
						"gbDialog"Координаты Вашего местоположения будут отправлены в службу такси.",
					"Вызов", "Назад" );
				}
				
				case 2:
				{
					showPlayerDialog( playerid, d_phone + 26, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Автомобильная сервисная служба\n\n\
						"cWHITE"Пожалуйста, коротко сообщите о своем местоположении диспетчеру:\n\n\
						"gbDialog"Координаты Вашего местоположения будут отправлены в сервисную службу.",
					"Вызов", "Назад" );
				}
			}
			
		}
		
		//Режим без звука
		case d_phone + 24:
		{
			if( !response )
			{	
				ShowListSound( playerid );
				return 1;
			}
			
			new
				sound = GetPVarInt( playerid, "Phone:Sound" ),
				phone = GetPVarInt( playerid, "Phone:Select" );
			
			switch( listitem )
			{
				case 0:
				{
					Phone[playerid][phone][p_settings][2] = sound;
					UpdatePhoneSettings( Phone[playerid][phone][p_number], Phone[playerid][phone][p_settings] );
				}
			}
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Режим без звука включен." );
			DeletePVar( playerid, "Phone:Sound" ); 
			ShowListSound( playerid );
		}
	
		//Вызов в такси
		case d_phone + 25:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 23, DIALOG_STYLE_LIST, " ", "\
					"cWHITE"Экстренная служба\n\
					"cWHITE"Служба такси\n\
					"cWHITE"Автомобильная сервисная служба",
				"Вызов", "Назад" );
			}
			
			if( Player[playerid][jTaxi] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы уже подали заявку в службу такси." );
			
			if( inputtext[0] == EOS || strlen( inputtext ) > 30 )
			{
				return showPlayerDialog( playerid, d_phone + 25, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Служба такси\n\n\
					"cWHITE"Пожалуйста, коротко сообщите о своем местоположении диспетчеру:\n\n\
					"gbDialog"Координаты Вашего местоположения будут отправлены в службу такси.\n\n\
					"gbDialogError"Неправильный формат ввода.",
				"Вызов", "Назад" );
			}
			
			new
				bool:flag = false,
				call;
			
			for( new i; i < MAX_TAXICALLS; i++ )
			{
				if( Taxi[i][t_playerid] == INVALID_PARAM )
				{
					new
						Float:pos[3];
						
					GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
				
					Taxi[i][t_playerid] = playerid;
					Taxi[i][t_time] = gettime() + 300;
					
					Taxi[i][t_place][0] = 
					Taxi[i][t_zone][0] = EOS;
					
					strcat( Taxi[i][t_place], inputtext, 30 );
					GetPlayer2DZone( playerid, Taxi[i][t_zone], 28 );
					
					Taxi[i][t_pos][0] = pos[0];
					Taxi[i][t_pos][1] = pos[1];
					Taxi[i][t_pos][2] = pos[2];
					
					call = i;
					flag = true;
					break;
				}
			}
			
			if( !flag ) return SendClient:( playerid, C_WHITE, ""gbError"К сожалению, в данный момент все машины заняты." );
			
			Player[playerid][jTaxi] = true;		
			SendClient:( playerid, C_WHITE, ""gbSuccess"Данные переданы в службу такси. Ожидайте, Ваш вызов обрабатывается." );
			
			format:g_small_string( "[CH: %d] Диспетчер: Поступил новый вызов из района %s.", 
				CHANNEL_TAXI,
				Taxi[call][t_zone]
			);
			SendRadioMessage( CHANNEL_TAXI, g_small_string );
		}
		
		case d_phone + 26:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 23, DIALOG_STYLE_LIST, " ", "\
					"cWHITE"Экстренная служба\n\
					"cWHITE"Служба такси\n\
					"cWHITE"Автомобильная сервисная служба",
				"Вызов", "Назад" );
			}
			
			if( Player[playerid][jMech] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы уже подали заявку в сервисную службу." );
			
			if( inputtext[0] == EOS || strlen( inputtext ) > 30 )
			{
				return showPlayerDialog( playerid, d_phone + 25, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Автомобильная сервисная служба\n\n\
					"cWHITE"Пожалуйста, коротко сообщите о своем местоположении диспетчеру:\n\n\
					"gbDialog"Координаты Вашего местоположения будут отправлены в сервисную службу.\n\n\
					"gbDialogError"Неправильный формат ввода.",
				"Вызов", "Назад" );
			}
			
			new
				bool:flag = false,
				call;
			
			for( new i; i < MAX_MECHCALLS; i++ )
			{
				if( Mechanic[i][m_playerid] == INVALID_PARAM )
				{
					new
						Float:pos[3];
						
					GetPlayerPos( playerid, pos[0], pos[1], pos[2] );
				
					Mechanic[i][m_playerid] = playerid;
					Mechanic[i][m_time] = gettime() + 300;
					
					Mechanic[i][m_place][0] = 
					Mechanic[i][m_zone][0] = EOS;
					
					strcat( Mechanic[i][m_place], inputtext, 30 );
					GetPlayer2DZone( playerid, Mechanic[i][m_zone], 28 );
					
					Mechanic[i][m_pos][0] = pos[0];
					Mechanic[i][m_pos][1] = pos[1];
					Mechanic[i][m_pos][2] = pos[2];
					
					call = i;
					flag = true;
					break;
				}
			}
			
			if( !flag ) return SendClient:( playerid, C_WHITE, ""gbError"К сожалению, в данный момент все машины заняты." );
			
			Player[playerid][jMech] = true;		
			SendClient:( playerid, C_WHITE, ""gbSuccess"Данные переданы в сервисную службу. Ожидайте, Ваш вызов обрабатывается." );
			
			format:g_small_string( "[CH: %d] Диспетчер: Поступил новый вызов из района %s.", 
				CHANNEL_MECHANIC,
				Mechanic[call][m_zone]
			);
			SendRadioMessage( CHANNEL_MECHANIC, g_small_string );
		}
		
		case d_phone + 27:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 23, DIALOG_STYLE_LIST, " ", "\
					"cWHITE"Экстренная служба\n\
					"cWHITE"Служба такси\n\
					"cWHITE"Автомобильная сервисная служба",
				"Вызов", "Назад" );
			}
			
			SetPVarInt( playerid, "Phone:Fraction", listitem );
			
			showPlayerDialog( playerid, d_phone + 28, DIALOG_STYLE_INPUT, " ", "\
				"cBLUE"Служба 911\n\n\
				"cWHITE"Пожалуйста, коротко опишите Вашу ситуацию:\n\
				"gbDialog"Координаты Вашего местоположения будут отправлены в службу 911.",
			"Вызов", "Назад" );
		}
		
		case d_phone + 28:
		{
			if( !response )
			{
				DeletePVar( playerid, "Phone:Fraction" );
				return showPlayerDialog( playerid, d_phone + 27, DIALOG_STYLE_TABLIST, ""cBLUE"Служба 911", ""cWHITE"\
					POLICE\n\
					FIRE & EMS\n\
					POLICE & FIRE & EMS",
				"Вызов", "Назад" );
			}
			
			if( inputtext[0] == EOS || strlen( inputtext ) > 32 )
			{
				return showPlayerDialog( playerid, d_phone + 28, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Служба 911\n\n\
					"cWHITE"Пожалуйста, коротко опишите Вашу ситуацию:\n\
					"gbDialog"Координаты Вашего местоположения будут отправлены в службу 911.\n\n\
					"gbDialogError"Неправильный формат ввода.",
				"Вызов", "Назад" );
			}
			
			new
				index = INVALID_PARAM,
				type = GetPVarInt( playerid, "Phone:Fraction" ),
				abc[10] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
			
			for( new i; i < MAX_POLICECALLS; i++ )
			{
				if( !CPolice[i][p_time] )
				{
					index = i;
					break;
				}
			}
			
			if( index == INVALID_PARAM )
			{
				new
					cmin;
			
				for( new i; i < MAX_POLICECALLS; i++ )
				{
					if( CPolice[cmin][p_time] > CPolice[i][p_time] )
						cmin = i;
				}
				
				if( IsLogged( CPolice[cmin][p_playerid] ) ) 
				{
					SendClient:( CPolice[cmin][p_playerid], C_WHITE, ""gbDialog"Ваш звонок в службу 911 был анулирован." );
					Player[ CPolice[cmin][p_playerid] ][jPolice] = false;
				}
				
				index = cmin;
			}
			
			GetPlayerPos( playerid, CPolice[index][p_pos][0], CPolice[index][p_pos][1], CPolice[index][p_pos][2] );
				
			CPolice[index][p_playerid] = playerid;
			CPolice[index][p_time] = gettime() + 300; 
			CPolice[index][p_type] = type;
				
			CPolice[index][p_number][0] =
			CPolice[index][p_descript][0] = 
			CPolice[index][p_zone][0] = EOS;
					
			strcat( CPolice[index][p_descript], inputtext, 32 );
			GetPlayer2DZone( playerid, CPolice[index][p_zone], 28 );
			
			for( new i; i < 4; i++ ) 
			{
				CPolice[index][p_number][i] = 0;
				CPolice[index][p_number][i] = abc[ random( 10 ) ];
			}
			
			CPolice[index][p_status] = 0;
			Player[playerid][jPolice] = true;
			
			pformat:( ""gbSuccess"Данные переданы в службу 911. Ожидайте, Ваш вызов "cBLUE"#%s"cWHITE" обрабатывается.", CPolice[index][p_number] );
			psend:( playerid, C_WHITE );
			
			DeletePVar( playerid, "Phone:Fraction" );
			SendEmergencyCall( playerid, type, index );
		}
		
		case d_phone + 29:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_phone + 21, DIALOG_STYLE_LIST, " ", "\
					"gbDialog"Набрать номер\n\
					"cWHITE"Номера сервисных служб\n\
					Другие номера\n\
					Узнать свой номер",
				"Выбрать", "Закрыть" );
			}
			
			switch( listitem )
			{
				case 0:
				{
					if( ETHER_STATUS == INVALID_PARAM || ETHER_CALL == false )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Звонки в прямой эфир отключены." );
						return showPlayerDialog( playerid, d_phone + 29, DIALOG_STYLE_LIST, " ", "\
							"cWHITE"Новостная корпорация",
						"Вызов", "Назад" );
					}
					
					if( Player[playerid][tEther] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы уже находитесь в прямом эфире." );
						return showPlayerDialog( playerid, d_phone + 29, DIALOG_STYLE_LIST, " ", "\
							"cWHITE"Новостная корпорация",
						"Вызов", "Назад" );
					}
					
					if( ETHER_CALLID != INVALID_PARAM )
					{
						SendClient:( playerid, C_WHITE, !""gbError"В эфир уже поступил звонок, попробуйте позже." );
						return showPlayerDialog( playerid, d_phone + 29, DIALOG_STYLE_LIST, " ", "\
							"cWHITE"Новостная корпорация",
						"Вызов", "Назад" );
					}
					
					pformat:( ""gbPhone"Исходящий вызов "cBLUE"%s "cGRAY"...( "cBLUE"H"cGRAY" )", Fraction[ FRACTION_NEWS - 1 ][f_name] );
					psend:( playerid, C_WHITE );
					
					PlayerPlaySound( playerid, 3600, 0.0, 0.0, 0.0 );
					
					pformat:( "[Эфир %s] Новый звонок от %s[%d], тел. %d. Используйте /ether, чтобы принять звонок.", 
						Fraction[ FRACTION_NEWS - 1 ][f_short_name], Player[playerid][uName], playerid, GetPhoneNumber( playerid ) );
					psend:( ETHER_STATUS, C_LIGHTGREEN );
					
					ETHER_CALLID = playerid;
					SetPVarInt( playerid, "San:Call", 1 );
							
					PhoneStatus( playerid, true );
				}
			}
		}
	}
	
	return 1;
}