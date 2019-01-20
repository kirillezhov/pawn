Admin_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_admin : 
		{
		    if( response ) 
			{
				if( inputtext[0] == EOS ) 
				    return showPlayerDialog( playerid, d_admin, DIALOG_STYLE_INPUT, " ", acontent_login, "Далее", "Закрыть" );
				 
				OnAdminLogin( playerid, inputtext );
			}
			
			return 1;
		}
		case d_admin + 1 : 
		{
		    if( response ) 
			{
				if( !GetAccessCommand( playerid, "acp" ) )
					return SendClientMessage( playerid, C_WHITE, NO_ACCESS_CMD );
				
				switch( listitem ) 
				{
					case 0 : 
					{

						new
						    fmt_player[ 32 + MAX_PLAYER_NAME + 2 ],
							fmt_spectate[ 64 ],
							fmt_afk [ 32 ],
							admin_count = 0,
							support_count = 0;
							
						clean_array();
						
						strcat( g_big_string, ""gbDefault"Администраторы в сети:\n\n" );
						foreach(new i : Player) 
						{
							if( !IsLogged( i ) || !GetAccessAdmin( i, 1, false ) ) 
								continue;

							format( fmt_player, sizeof fmt_player, "(%d) "cBLUE"%s[%d]"cWHITE"",
								Admin[i][aLevel],
								Player[i][uName],
								i
							);
							
							if( GetPVarInt( i, "Admin:SpectateId" ) != INVALID_PLAYER_ID ) 
							{
								format( fmt_spectate, sizeof fmt_spectate, " - "cGREEN"/sp %d"cWHITE"",
								    GetPVarInt( i, "Admin:SpectateId" )
								);
							}
							
							if( IsAfk( i ) ) 
							{
                                format( fmt_afk, sizeof fmt_afk, " - "cGRAY"[AFK: %d]"cWHITE"",
								    GetPVarInt( i, "Player:Afk" )
								);
							}
							
							
							format:g_small_string(  "%s%s%s%s\n",
								fmt_player,
								GetPVarInt( i, "Admin:SpectateId" ) != INVALID_PLAYER_ID ? fmt_spectate : (""),
								IsAfk( i ) ? fmt_afk : (""),
								!GetPVarInt( i, "Admin:Duty" ) ? (" - "cRED"[Не авторизован]"cGRAY"") : ("")
							);
							
							++admin_count;
							strcat( g_big_string, g_small_string );
						}
						
						strcat( g_big_string, "\n\n\n"gbDefault" Саппорты в сети:\n\n" );

						foreach(new i : Player) 
						{
							if( !IsLogged( i ) || !GetAccessSupport( i ) ) 
								continue;
							
							if( IsAfk( i ) ) 
							{
                                format( fmt_afk, sizeof fmt_afk, " - "cGRAY"[AFK: %d]",
								    GetPVarInt( i, "Player:Afk" )
								);
							}
							
							format( fmt_player, sizeof fmt_player, ""cBLUE"%s[%d]%s%s"cWHITE"\n",
								Player[i][uName],
								i,
								IsAfk( i ) ? fmt_afk : (""),
								!GetPVarInt( i, "Support:Duty" ) ? (" - "cGRAY"[Не на дежурстве]"cWHITE"") : ("")
							);
							
							++support_count;
							
							strcat( g_big_string, fmt_player );
						}
						
						if( support_count == 0 )
						    strcat( g_big_string, "Саппортов нет в сети.\n" );
						
						format:g_small_string(  "\n\nВсего администраторов в сети: "cBLUE"%d\n"cWHITE"Всего саппортов в сети: "cBLUE"%d",
							admin_count,
							support_count
						);
						
						strcat( g_big_string, g_small_string );
						
						showPlayerDialog( playerid, d_admin + 1, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "");
						clean_array();
					}
					
					case 1 : 
					{
						clean_array();
						if( GetAccessAdmin( playerid, 1 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"1"cWHITE"\n" );
						if( GetAccessAdmin( playerid, 2 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"2"cWHITE"\n" );
						if( GetAccessAdmin( playerid, 3 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"3"cWHITE"\n" );
						if( GetAccessAdmin( playerid, 4 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"4"cWHITE"\n" );
						if( GetAccessAdmin( playerid, 5 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"5"cWHITE"\n" );
						if( GetAccessAdmin( playerid, 6 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"6"cWHITE"\n" );
						if( GetAccessAdmin( playerid, 7 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"7"cWHITE"\n" );
    					showPlayerDialog( playerid, d_admin + 2, DIALOG_STYLE_TABLIST, " ", g_big_string, "Далее", "Назад");
					}
					case 2 : 
					{
						clean:<g_big_string>;
						strcat( g_big_string, ""gbSuccess"Статистика.\n\n" );
						format:g_small_string( " - Идентификатор: "cBLUE"%d"cWHITE"\n", Admin[playerid][aID] ), strcat( g_big_string, g_small_string );
						format:g_small_string( " - Имя: "cBLUE"%s"cWHITE"\n", Admin[playerid][aName] ), strcat( g_big_string, g_small_string );
						format:g_small_string( " - Уровень доступа: "cBLUE"%d"cWHITE"\n\n", Admin[playerid][aLevel] ), strcat( g_big_string, g_small_string );
						format:g_small_string( " - Часов наиграно: "cBLUE"-"cWHITE"\n"), strcat( g_big_string, g_small_string );
						format:g_small_string( "     За день:"cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( "     За неделю: "cBLUE"-"cWHITE"\n\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( " - Действий совершил: "cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( "     Отсоединил от сервера: "cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( "     Заблокировал: "cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( "     Заблокировал чат: "cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( "     Выдал предупреждение: "cBLUE"-"cWHITE"\n\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( " - Всего проверил заявлений: "cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( "     Одобрил заявлений: "cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
						format:g_small_string( "     Отклонил заявлений: "cBLUE"-"cWHITE"" ), strcat( g_big_string, g_small_string );
						showPlayerDialog( playerid, d_admin + 7, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "Закрыть");
					}
					case 3 :
					{
						return 1;
					}
					case 4 :
					{
						if( !COUNT_KILL_LOG )
							return SendClient:( playerid, C_WHITE, ""gbError"На данный момент лог убийств пуст.");
					
						new 
							weapon_name[32];
									
						clean:<g_big_string>;
						strcat( g_big_string, ""cBLUE"Имя\t"cBLUE"Оружие\t"cBLUE"Убил\t"cBLUE"Время"cWHITE"\n" );
					
						for( new i; i != COUNT_KILL_LOG; i++ )
						{
							GetWeaponName( KillLog[i][killerGun], weapon_name, sizeof weapon_name );
							
							if( weapon_name[0] == EOS )	
								strcat( weapon_name, "Fist", 32 );
							
							format:g_small_string( "%s[%d]\t%s\t%s[%d]\t%s\n",
								KillLog[i][killerName],
								KillLog[i][killerID],
								weapon_name,
								KillLog[i][killedName],
								KillLog[i][killedID],
								date( "%hh:%ii:%ss", KillLog[i][killedTime] )
							);
							
							strcat( g_big_string, g_small_string );
						}
						
						showPlayerDialog( playerid, d_admin + 7, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "Назад", "Закрыть" );
					}
					case 5 :
					{	
						if( !COUNT_DISCONNECT_LOG )
							return SendClient:( playerid, C_WHITE, ""gbError"На данный момент лог отключений пуст.");
					
						clean:<g_big_string>;
						strcat( g_big_string, ""cBLUE"Имя\t"cBLUE"Время\t"cBLUE"Причина"cWHITE"\n" );
					
						for( new i; i != COUNT_DISCONNECT_LOG; i++ )
						{
							format:g_small_string( "%s\t%s\t%s\n",
								DisconnectLog[i][disconnectName],
								date( "%hh:%ii:%ss", DisconnectLog[i][disconnectTime] ),
								DisconnectLog[i][disconnectReason]
							);
							
							strcat( g_big_string, g_small_string );
						}
						
						showPlayerDialog( playerid, d_admin + 7, DIALOG_STYLE_TABLIST_HEADERS, " ", g_big_string, "Назад", "Закрыть" );
					}
					case 6 :
					{
						new
							server_tick = GetTickCount();
							
						if( GetPVarInt( playerid, "Admin:UpdateTime" ) > server_tick )
							return SendClientMessage(playerid, C_WHITE, !""gbError"Вы не можете использовать данный пункт так часто.");
						
						SetPVarInt( playerid, "Admin:Level", Admin[playerid][aLevel] );
						
						clean:<g_string>;
						mysql_format( mysql, g_string, sizeof g_string, "SELECT * FROM "DB_ADMINS" WHERE aUserID = %d", Player[playerid][uID] );
						mysql_tquery( mysql, g_string, "ReloadAdminAccount", "iii", playerid, 2, server_tick );
					}
				}
			}
			return 1;
		}
		
		case d_admin + 2 : 
		{
		    if( !response )
		        return showPlayerDialog( playerid, d_admin + 1, DIALOG_STYLE_LIST, " ", acontent_acp, "Далее", "Закрыть" );
			new
			    level = listitem + 1;
			
			format:g_small_string( ""gbSuccess"Список команд\n - Уровень доступа: "cBLUE"%d"cWHITE"\n\n", level );
			strcat( g_big_string, g_small_string);

			for( new i; i != COUNT_PERMISSIONS; i++ ) 
			{
				if( Permission[i][pLevel] != level )
					continue;
					
				format:g_small_string( ""cBLUE"/%s"cWHITE" - %s\n", 
					Permission[i][pName],
					Permission[i][pDescription] 
				);
				
				strcat( g_big_string, g_small_string);
			}
			
			showPlayerDialog( playerid, d_admin + 3, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "Закрыть" );

		    return 1;
		}
		
		case d_admin + 3 : 
		{
			if( !response )
			    return 1;
				
        	clean_array();
			if( GetAccessAdmin( playerid, 1 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"1"cWHITE"\n" );
			if( GetAccessAdmin( playerid, 2 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"2"cWHITE"\n" );
			if( GetAccessAdmin( playerid, 3 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"3"cWHITE"\n" );
			if( GetAccessAdmin( playerid, 4 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"4"cWHITE"\n" );
			if( GetAccessAdmin( playerid, 5 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"5"cWHITE"\n" );
			if( GetAccessAdmin( playerid, 6 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"6"cWHITE"\n" );
			if( GetAccessAdmin( playerid, 7 ) ) strcat( g_big_string, " - Уровень доступа\t"cBLUE"7"cWHITE"\n" );
			showPlayerDialog( playerid, d_admin + 2, DIALOG_STYLE_TABLIST, " ", g_big_string, "Далее", "Назад");
		}
		case d_admin + 4 : 
		{
			if( !response )
			    return 1;

			SetPVarInt( playerid, "Admin:vehicleSelectServerID", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;

			showPlayerDialog( playerid, d_admin + 5, DIALOG_STYLE_TABLIST, " ", "\
				- Телепортироваться\n\
				- Удалить", "Далее", "Назад");
		}
		case d_admin + 5 : 
		{
			if( !response )
			{
				DeletePVar( playerid, "Admin:VehicleSelectServerID" );
				return cmd_vehlist( playerid );
			}
			
			new
				vehicleid = GetPVarInt( playerid, "Admin:VehicleSelectServerID" );
		
			switch( listitem ) 
			{
				case 0 : 
				{
				    new
				        Float:vehicle_x,
				        Float:vehicle_y,
				        Float:vehicle_z;
				        
					GetVehiclePos( vehicleid, vehicle_x, vehicle_y, vehicle_z );
					setPlayerPos( playerid, vehicle_x + 1.0, vehicle_y + 1.0, vehicle_z );
					
					SetPlayerVirtualWorld( playerid, GetVehicleVirtualWorld( vehicleid ) );
					if( GetVehicleVirtualWorld( vehicleid ) ) SetPlayerInterior( playerid, 1 );
					
                    format:g_small_string( ""gbSuccess"Вы успешно телепортировались к транспорту - ID: "cBLUE"%d"cWHITE".",
                        GetPVarInt( playerid, "Admin:VehicleSelectServerID" )
					);
					SendClient:( playerid, C_WHITE, g_small_string );
				}
				
				case 1 : 
				{					
					format:g_small_string( "%d", GetPVarInt( playerid, "Admin:VehicleSelectServerID" ) );
					cmd_dveh( playerid, g_small_string );
				}
			}
			
			DeletePVar( playerid, "Admin:VehicleSelectServerID" );
		}
		case d_admin + 6 : 
		{
			if( response ) 
			{
				if( inputtext[0] == EOS ) 
						return showPlayerDialog( playerid, d_admin + 6, DIALOG_STYLE_INPUT, " ", acontent_reg, "Далее", "Закрыть" );
				
				OnAdminRegister( playerid, inputtext );
			}
		}
		case d_admin + 7 :
		{
			if( response )
				return showPlayerDialog( playerid, d_admin + 1, DIALOG_STYLE_LIST, " ", acontent_acp, "Далее", "Закрыть" );
			else
				return 1;
		}
		
		case d_admin + 8 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Admin:ClickedPlayerid", INVALID_PLAYER_ID );
				return 1;
			}
			
			new 
				clickedplayerid = GetPVarInt( playerid, "Admin:ClickedPlayerid" );
			
			switch( listitem )
			{
				case 0 :
				{
					format:g_small_string( "%d", clickedplayerid );
					cmd_sp( playerid, g_small_string );
				}
				case 1 :
				{
					format:g_small_string( "%d", clickedplayerid );
					cmd_goto( playerid, g_small_string );
				}
				case 2 :
				{
					SendClient:( playerid, C_WHITE, ""gbError"Данный пункт находится в разработке." );
				}
				case 3 :
				{
					format:g_small_string( "%d", clickedplayerid );
					cmd_slap( playerid, g_small_string );
				}
			}

			SetPVarInt( playerid, "Admin:ClickedPlayerid", INVALID_PLAYER_ID );
		}
		
		//Диалог изменения фракции
		case d_admin + 9:
		{
			if( !response ) return 1;
			
			SetPVarInt( playerid, "Admin:SelectFrac", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			showPlayerDialog( playerid, d_admin + 10, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				Информация\n\
				Изменить", "Далее", "Назад" );
		}
		
		case d_admin + 10:
		{
			if( !response )
			{
				DeletePVar( playerid, "Admin:SelectFrac" );
				return cmd_frac( playerid );
			}	
			
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
			
			switch( listitem )
			{
				case 0:
				{
					clean:<g_big_string>;
					
					strcat( g_big_string, ""cWHITE"Информация об организации\n\n" );
					
					format:g_small_string( ""cWHITE"Название:\n"cBLUE"%s"cWHITE"", Fraction[fid][f_name] );
					strcat( g_big_string, g_small_string );
					
					format:g_small_string( "\n\n"cWHITE"Количество рангов: "cBLUE"%d"cWHITE"", Fraction[fid][f_ranks] );
					strcat( g_big_string, g_small_string );
					
					strcat( g_big_string, "\n\nЛидеры:" );
					
					for( new i; i < 3; i++ )
					{
						if( Fraction[fid][f_leader][i] )
						{
							format:g_small_string( "\n"cBLUE"%s", FNameLeader[fid][i] );
							strcat( g_big_string, g_small_string );
						}
					}
					
					format:g_small_string( "\n\n"cWHITE"Транспорт: "cBLUE"%d/%d"cWHITE" ед.", Fraction[fid][f_amountveh], Fraction[fid][f_vehicles] );
					strcat( g_big_string, g_small_string );
					
					format:g_small_string( "\n\n"cWHITE"Деньги на заработную плату: "cBLUE"$%d"cWHITE"", Fraction[fid][f_salary] );
					strcat( g_big_string, g_small_string );
					
					strcat( g_big_string, "\n\nСкины организации:\n"cBLUE"" );
					
					for( new i; i < 10; i++ )
					{
						if( Fraction[fid][f_skin][i] )
						{
							format:g_small_string( " %d", Fraction[fid][f_skin][i] );
							strcat( g_big_string, g_small_string );
						}
					}
					
					strcat( g_big_string, "\n" );
					
					for( new i = 10; i < 20; i++ )
					{
						if( Fraction[fid][f_skin][i] )
						{
							format:g_small_string( " %d", Fraction[fid][f_skin][i] );
							strcat( g_big_string, g_small_string );
						}
					}
					
					strcat( g_big_string, "\n\n"cWHITE"Доступное оружие:\n"cBLUE"" );
					
					for( new i; i < 10; i++ )
					{
						if( Fraction[fid][f_gun][i] )
						{
							format:g_small_string( " %d", Fraction[fid][f_gun][i] );
							strcat( g_big_string, g_small_string );
						}
					}
					
					strcat( g_big_string, "\n\n"cWHITE"Склад:\n"cBLUE"" );
					for( new i; i < 10; i++ )
					{
						if( Fraction[fid][f_stock][i] )
						{
							format:g_small_string( " %d", Fraction[fid][f_stock][i] );
							strcat( g_big_string, g_small_string );
						}
					}
					
					showPlayerDialog( playerid, d_admin + 11, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
				}
			}
		}
		
		case d_admin + 11:
		{
			showPlayerDialog( playerid, d_admin + 10, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				Информация\n\
				Изменить", "Далее", "Назад" );
		}
		
		
		case d_admin + 12:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 10, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Информация\n\
					Изменить", "Далее", "Назад" );
			}
			
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
			
			switch( listitem )
			{
				case 0: //Изменить название
				{
					format:g_small_string( "\
						"cBLUE"Изменение названия организации\n\n\
						"cWHITE"Текущее название: "cBLUE"%s\n\
						"cWHITE"Введите новое название:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_admin + 13, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 1:	//Изменить сокращенное название
				{
					format:g_small_string( "\
						"cWHITE"Сокращенное название для организации\n\
						"cBLUE"%s\n\n\
						"cWHITE"Введите сокращенное название:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_admin + 19, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 2:	//Изменить лимит транспорта
				{
					format:g_small_string( "\
						"cBLUE"Изменение лимита транспорта для\n\
						%s\n\n\
						"cWHITE"Старое значение: "cBLUE"%d"cWHITE" ед.\n\
						Введите новый лимит:", Fraction[fid][f_name], Fraction[fid][f_vehicles] );
				
					showPlayerDialog( playerid, d_admin + 14, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 3://Изменения списка скинов
				{
					format:g_small_string( "\
						"cBLUE"Изменение доступных скинов для\n\
						%s\n\n\
						"cWHITE"Введите новый список скинов:\n\n\
						"gbDialog"Ввод 20 значений через запятую без пробелов.\n\
						"gbDialog"Значение по умолчанию 0.", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_admin + 15, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 4://Изменения списка оружия
				{
					format:g_small_string( "\
						"cBLUE"Изменение доступного оружия для\n\
						%s\n\n\
						Введите новый список оружия:\n\n\
						"gbDialog"Ввод 10 значений через запятую без пробелов.\n\
						"gbDialog"Значение по умолчанию 0.", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_admin + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 5:
				{
					format:g_small_string( "\
						"cBLUE"Изменение склада для\n\
						%s\n\n\
						Введите новый список склада:\n\n\
						"gbDialog"Ввод 10 значений через запятую без пробелов.\n\
						"gbDialog"Значение по умолчанию 0.", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_admin + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 6:
				{
					format:g_small_string( "\
						"cWHITE"Общее количество денег на зарплату для\n\
						"cBLUE"%s\n\n\
						"cWHITE"Установите новое значение:\n\
						"gbDialog"Заработная плата для всех рангов фракции будет обнулена.", Fraction[fid][f_name] );
				
					showPlayerDialog( playerid, d_admin + 18, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
			}
		}
		
		case d_admin + 13 :
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
			}
			
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
				
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
						"cBLUE"Изменение названия организации\n\n\
						"cWHITE"Текущее название: "cBLUE"%s\n\
						"cWHITE"Введите новое название:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.\n\n\
						"gbDialogError"Поля для ввода пустое.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_admin + 13, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 64 )
			{
				format:g_small_string( "\
						"cBLUE"Изменение названия организации\n\n\
						"cWHITE"Текущее название: "cBLUE"%s\n\
						"cWHITE"Введите новое название:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.\n\n\
						"gbDialogError"Превышен допустимый лимит символов.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_admin + 13, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			clean:<Fraction[fid][f_name]>;
			
			strcat( Fraction[fid][f_name], inputtext, 64 );
			
			mysql_format:g_string( "UPDATE `"DB_FRACTIONS"` SET `f_name` = '%e' WHERE `f_id` = %d",
				Fraction[fid][f_name],
				Fraction[fid][f_id]
			);
			mysql_tquery( mysql, g_string );
			
			pformat:(""gbSuccess"Вы изменили название организации на "cBLUE"%s"cWHITE".", Fraction[fid][f_name] );
			psend:( playerid, C_WHITE );

			showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
		}
		
		case d_admin + 14:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
			}
			
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) == Fraction[fid][f_vehicles] || strval( inputtext ) < 0 || strval( inputtext ) > MAX_FRACVEHICLES )
			{
				format:g_small_string( "\
					"cBLUE"Изменение лимита транспорта для\n\
					%s\n\n\
					"cWHITE"Старое значение: "cBLUE"%d"cWHITE" ед.\n\
					Введите новый лимит:\n\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name], Fraction[fid][f_vehicles] );
				
				return showPlayerDialog( playerid, d_admin + 14, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			Fraction[fid][f_vehicles] = strval( inputtext );
			
			mysql_format:g_string( "UPDATE `"DB_FRACTIONS"` SET `f_vehicles` = %d WHERE `f_id` = %d",
				Fraction[fid][f_vehicles],
				Fraction[fid][f_id]
			);
			mysql_tquery( mysql, g_string );
			
			pformat:(""gbSuccess"Вы изменили лимит транспорта на "cBLUE"%d"cWHITE" ед.", Fraction[fid][f_vehicles] );
			psend:( playerid, C_WHITE );

			showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
		}
		
		case d_admin + 15:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
			}
		
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
				
			if( sscanf( inputtext, "p<,>a<d>[20]", inputtext[0], inputtext[1], inputtext[2], inputtext[3], inputtext[4], inputtext[5], inputtext[6], inputtext[7], inputtext[8],
				inputtext[9], inputtext[10], inputtext[11], inputtext[12], inputtext[13], inputtext[14], inputtext[15], inputtext[16], inputtext[17], inputtext[18], inputtext[19] ) ) 
			{
				format:g_small_string( "\
					"cBLUE"Изменение доступных скинов для\n\
					%s\n\n\
					"cWHITE"Введите новый список скинов:\n\n\
					"gbDialog"Ввод 20 значений через запятую без пробелов.\n\
					"gbDialog"Значение по умолчанию 0.\n\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				return	showPlayerDialog( playerid, d_admin + 15, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			for( new i; i < 20; i++ )
				Fraction[fid][f_skin][i] = inputtext[i];
			
			mysql_format:g_string( "UPDATE `"DB_FRACTIONS"` SET `f_skin` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `f_id` = %d",
				Fraction[fid][f_skin][0], Fraction[fid][f_skin][1], Fraction[fid][f_skin][2], Fraction[fid][f_skin][3],
				Fraction[fid][f_skin][4], Fraction[fid][f_skin][5], Fraction[fid][f_skin][6], Fraction[fid][f_skin][7],
				Fraction[fid][f_skin][8], Fraction[fid][f_skin][9], Fraction[fid][f_skin][10], Fraction[fid][f_skin][11],
				Fraction[fid][f_skin][12], Fraction[fid][f_skin][13], Fraction[fid][f_skin][14], Fraction[fid][f_skin][15],
				Fraction[fid][f_skin][16], Fraction[fid][f_skin][17], Fraction[fid][f_skin][18], Fraction[fid][f_skin][19],
				Fraction[fid][f_id]
			);
			mysql_tquery( mysql, g_string );

			SendClient:( playerid, C_WHITE, ""gbSuccess"Список скинов изменен." );
		
			showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
		}
		
		case d_admin + 16:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
			}
	
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
				
			if( sscanf( inputtext, "p<,>a<d>[10]", inputtext[0], inputtext[1], inputtext[2], inputtext[3], inputtext[4], inputtext[5], inputtext[6], inputtext[7], inputtext[8], inputtext[9] ) ) 
			{
				format:g_small_string( "\
					"cBLUE"Изменение доступного оружия для\n\
					%s\n\n\
					Введите новый список оружия:\n\n\
					"gbDialog"Ввод 10 значений через запятую без пробелов.\n\
					"gbDialog"Значение по умолчанию 0.\n\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_admin + 16, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		
			for( new i; i < 10; i++ )
				Fraction[fid][f_gun][i] = inputtext[i];
			
			mysql_format:g_string( "UPDATE `"DB_FRACTIONS"` SET `f_gun` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `f_id` = %d",
				Fraction[fid][f_gun][0], Fraction[fid][f_gun][1], Fraction[fid][f_gun][2], Fraction[fid][f_gun][3],
				Fraction[fid][f_gun][4], Fraction[fid][f_gun][5], Fraction[fid][f_gun][6], Fraction[fid][f_gun][7],
				Fraction[fid][f_gun][8], Fraction[fid][f_gun][9],
				Fraction[fid][f_id]
			);
			mysql_tquery( mysql, g_string );

			SendClient:( playerid, C_WHITE, ""gbSuccess"Список доступного оружия изменен." );
		
			showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
		}
		
		case d_admin + 17:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
			}
	
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
				
			if( sscanf( inputtext, "p<,>a<d>[10]", inputtext[0], inputtext[1], inputtext[2], inputtext[3], inputtext[4], inputtext[5], inputtext[6], inputtext[7], inputtext[8], inputtext[9] ) ) 
			{
				format:g_small_string( "\
					"cBLUE"Изменение склада для\n\
					%s\n\n\
					Введите новый список склада:\n\n\
					"gbDialog"Ввод 10 значений через запятую без пробелов.\n\
					"gbDialog"Значение по умолчанию 0.\n\n\
					"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				showPlayerDialog( playerid, d_admin + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
		
			for( new i; i < 10; i++ )
				Fraction[fid][f_stock][i] = inputtext[i];
			
			mysql_format:g_string( "UPDATE `"DB_FRACTIONS"` SET `f_stock` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `f_id` = %d",
				Fraction[fid][f_stock][0], Fraction[fid][f_stock][1], Fraction[fid][f_stock][2], Fraction[fid][f_stock][3],
				Fraction[fid][f_stock][4], Fraction[fid][f_stock][5], Fraction[fid][f_stock][6], Fraction[fid][f_stock][7],
				Fraction[fid][f_stock][8], Fraction[fid][f_stock][9],
				Fraction[fid][f_id]
			);
			mysql_tquery( mysql, g_string );

			SendClient:( playerid, C_WHITE, ""gbSuccess"Склад изменен." );
		
			showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
		}
		
		case d_admin + 18:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
			}
			
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 1000000 )
			{
				format:g_small_string( "\
						"cWHITE"Общее количество денег на зарплату для\n\
						"cBLUE"%s\n\n\
						"cWHITE"Установите новое значение:\n\
						"gbDialog"Заработная плата для всех рангов фракции будет обнулена.\n\n\
						"gbDialogError"Неправильный формат ввода.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_admin + 18, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			Fraction[fid][f_salary] = strval( inputtext );
			
			mysql_format:g_string( "UPDATE `"DB_FRACTIONS"` SET `f_salary` = %d WHERE `f_id` = %d",
				Fraction[fid][f_salary],
				Fraction[fid][f_id]
			);
			mysql_tquery( mysql, g_string );
			
			pformat:(""gbSuccess"Вы изменили лимит денег на "cBLUE"$%d"cWHITE". Заработная плата всех рангов фракции обнулена.", Fraction[fid][f_salary] );
			psend:( playerid, C_WHITE );
			
			for( new i; i < MAX_RANKS; i++ )
			{
				if( FRank[fid][i][r_id] )
					FRank[fid][i][r_salary] = 0;
			}
			
			mysql_format:g_string( "UPDATE `"DB_RANKS"` SET `r_salary` = 0 WHERE `r_fracid` = %d", fid );
			mysql_tquery( mysql, g_string );

			showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
		}
		
		case d_admin + 19:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
			}
			
			new
				fid = GetPVarInt( playerid, "Admin:SelectFrac" );
				
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
					"cWHITE"Сокращенное название для организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите сокращенное название:\n\n\
					"gbDialog"Используйте буквы русского или английского алфавита.\n\
					"gbDialogError"Поля для ввода пустое.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_admin + 19, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 10 )
			{
				format:g_small_string( "\
					"cWHITE"Сокращенное название для организации\n\
					"cBLUE"%s\n\n\
					"cWHITE"Введите сокращенное название:\n\n\
					"gbDialog"Используйте буквы русского или английского алфавита.\n\
					"gbDialogError"Превышен допустимый лимит символов.", Fraction[fid][f_name] );
				
				return showPlayerDialog( playerid, d_admin + 19, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			clean:<Fraction[fid][f_short_name]>;
			
			strcat( Fraction[fid][f_short_name], inputtext, 10 );
			
			mysql_format:g_string( "UPDATE `"DB_FRACTIONS"` SET `f_short_name` = '%e' WHERE `f_id` = %d",
				Fraction[fid][f_short_name],
				Fraction[fid][f_id]
			);
			mysql_tquery( mysql, g_string );
			
			pformat:(""gbSuccess"Вы изменили сокращенное название организации на "cBLUE"%s"cWHITE".", Fraction[fid][f_short_name] );
			psend:( playerid, C_WHITE );

			showPlayerDialog( playerid, d_admin + 12, DIALOG_STYLE_LIST, "Изменить...", fraction_change, "Далее", "Назад" );
		}
		
		// Панель криминальной фракции
		case d_admin + 20:
		{
			if( !response ) return 1;
			
			if( !listitem )
			{
				showPlayerDialog( playerid, d_admin + 32, DIALOG_STYLE_LIST, "Выберите тип", "\
					Банда\n\
					Мафия\n\
					Мотоклуб\n\
					Другое", "Выбрать", "Назад" );
			}
			else
			{
				SetPVarInt( playerid, "Crime:ID", g_dialog_select[playerid][listitem - 1] );
				g_dialog_select[playerid][listitem - 1] = INVALID_PARAM;
			
				showPlayerDialog( playerid, d_admin + 21, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Информация\n\
					Изменить\n\
					Удалить", "Далее", "Назад" );
			}
		}
		
		case d_admin + 21:
		{
			if( !response )
			{
				DeletePVar( playerid, "Crime:ID" );
				return cmd_cfrac( playerid );
			}
			
			new
				crime = GetPVarInt( playerid, "Crime:ID" );
				
			switch( listitem )
			{
				case 0:
				{
					clean:<g_string>;
				
					format:g_small_string( "\
						"cWHITE"Информация о криминальной структуре #%d\n\
						"cBLUE"%s"cWHITE"",
						CrimeFraction[crime][c_id],
						CrimeFraction[crime][c_name] );
					strcat( g_string, g_small_string );
					
					strcat( g_string, "\n\nЛидеры:" );
					
					for( new i; i < 3; i++ )
					{
						if( CrimeFraction[ crime ][c_leader][i] )
						{
							format:g_small_string( "\n"cBLUE"%s", CNameLeader[crime][i] );
							strcat( g_string, g_small_string );
						}
					}
					
					format:g_small_string( "\n\n"cWHITE"Транспорт: "cBLUE"%d/%d"cWHITE" ед.", CrimeFraction[crime][c_amountveh], CrimeFraction[crime][c_vehicles] );
					strcat( g_string, g_small_string );
					
					strcat( g_string, "\n\nВозможность приобретения транспорта:" );
					
					if( CrimeFraction[crime][c_type_vehicles] )
					{
						strcat( g_string, "\n"cBLUE"Да" );
					}
					else
					{
						strcat( g_string, "\n"cBLUE"Нет" );
					}
					
					strcat( g_string, "\n\n"cWHITE"Оружие у гандилера:" );
					
					switch( CrimeFraction[crime][c_type_weapon] )
					{
						case 0: strcat( g_string, "\n"cBLUE"Нет" );
						case 1: strcat( g_string, "\n"cBLUE"1 группа" );
						case 2: strcat( g_string, "\n"cBLUE"2 группа" );
						case 3: strcat( g_string, "\n"cBLUE"3 группа" );
					}
					
					showPlayerDialog( playerid, d_admin + 22, DIALOG_STYLE_MSGBOX, " ", g_string, "Назад", "" );
				}
				
				case 1:
				{
					showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
				}
				
				case 2:
				{
					format:g_small_string( "\
						"cBLUE"Удаление криминальной структуры #%d\n\n\
						"cWHITE"Вы действительно желаете удалить "cBLUE"%s"cWHITE"?",
						CrimeFraction[crime][c_id],
						CrimeFraction[crime][c_name]						
					);
					
					showPlayerDialog( playerid, d_admin + 29, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
			}
		}
		
		case d_admin + 22:
		{
			return showPlayerDialog( playerid, d_admin + 21, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				Информация\n\
				Изменить\n\
				Удалить", "Далее", "Назад" );
		}
		
		case d_admin + 23:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_admin + 21, DIALOG_STYLE_LIST, " ", ""cWHITE"\
					Информация\n\
					Изменить\n\
					Удалить", "Далее", "Назад" );
			}
			
			new
				crime = GetPVarInt( playerid, "Crime:ID" );
			
			switch( listitem )
			{	//Изменить название
				case 0:
				{
					format:g_small_string( "\
						"cBLUE"Изменение названия криминальной структры\n\n\
						"cWHITE"Текущее название: "cBLUE"%s\n\
						"cWHITE"Введите новое название:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.", CrimeFraction[crime][c_name] );
				
					showPlayerDialog( playerid, d_admin + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Изменить лимит транспорта
				case 1:
				{
					format:g_small_string( "\
						"cBLUE"Изменение лимита транспорта для\n\
						%s\n\n\
						"cWHITE"Старое значение: "cBLUE"%d"cWHITE" ед.\n\
						Введите новый лимит:", CrimeFraction[crime][c_name], CrimeFraction[crime][c_vehicles] );
				
					showPlayerDialog( playerid, d_admin + 25, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				//Оружие гандиллера
				case 2:
				{
					showPlayerDialog( playerid, d_admin + 26, DIALOG_STYLE_LIST, "Оружие", weapon_change, "Выбрать", "Назад" );
				}
				//Доступность к транспорту
				case 3:
				{
					format:g_small_string( crime_vehicle, 
						CrimeFraction[crime][c_type_vehicles] ? ("Да") : ("Нет")
					);
					showPlayerDialog( playerid, d_admin + 28, DIALOG_STYLE_TABLIST_HEADERS, "Транспорт", g_small_string, "Изменить", "Назад" );
				}
			}
		}
		
		case d_admin + 24:
		{
			if( !response )
				return showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
		
			new
				crime = GetPVarInt( playerid, "Crime:ID" );
		
			if( inputtext[0] == EOS )
			{
				format:g_small_string( "\
						"cBLUE"Изменение названия криминальной структуры\n\n\
						"cWHITE"Текущее название: "cBLUE"%s\n\
						"cWHITE"Введите новое название:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.\n\n\
						"gbDialogError"Поля для ввода пустое.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_admin + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( strlen( inputtext ) > 64 )
			{
				format:g_small_string( "\
						"cBLUE"Изменение названия криминальной структуры\n\n\
						"cWHITE"Текущее название: "cBLUE"%s\n\
						"cWHITE"Введите новое название:\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.\n\n\
						"gbDialogError"Превышен допустимый лимит символов.", CrimeFraction[crime][c_name] );
				
				return showPlayerDialog( playerid, d_admin + 24, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			clean:<CrimeFraction[crime][c_name]>;
			strcat( CrimeFraction[crime][c_name], inputtext, 64 );
			
			mysql_format:g_string( "UPDATE `"DB_CRIME"` SET `c_name` = '%e' WHERE `c_id` = %d",
				CrimeFraction[crime][c_name],
				CrimeFraction[crime][c_id]
			);
			mysql_tquery( mysql, g_string );
			
			pformat:(""gbSuccess"Вы изменили название криминальной структуры на "cBLUE"%s"cWHITE".", CrimeFraction[crime][c_name] );
			psend:( playerid, C_WHITE );

			showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
		}
		
		case d_admin + 25:
		{
			if( !response )
				return showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
			
			new
				crime = GetPVarInt( playerid, "Crime:ID" );
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) == CrimeFraction[crime][c_vehicles] || strval( inputtext ) < 0 || strval( inputtext ) > MAX_FRACVEHICLES )
			{
				format:g_small_string( "\
					"cBLUE"Изменение лимита транспорта для\n\
					%s\n\n\
					"cWHITE"Старое значение: "cBLUE"%d"cWHITE" ед.\n\
					Введите новый лимит:\n\n\
					"gbError"Неправильный формат ввода.", CrimeFraction[crime][c_name], CrimeFraction[crime][c_vehicles] );
				
				return showPlayerDialog( playerid, d_admin + 25, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			CrimeFraction[crime][c_vehicles] = strval( inputtext );
			
			mysql_format:g_string( "UPDATE `"DB_CRIME"` SET `c_vehicles` = %d WHERE `c_id` = %d",
				CrimeFraction[crime][c_vehicles],
				CrimeFraction[crime][c_id]
			);
			mysql_tquery( mysql, g_string );
			
			pformat:(""gbSuccess"Вы изменили лимит транспорта на "cBLUE"%d"cWHITE" ед.", CrimeFraction[crime][c_vehicles] );
			psend:( playerid, C_WHITE );

			showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
		}
		
		case d_admin + 26:
		{
			if( !response )
				return showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
				
			if( listitem == 4 )
			{
				return showPlayerDialog( playerid, d_admin + 27, DIALOG_STYLE_MSGBOX, " ", weapon_info, "Назад", "" );
			}
			
			new
				crime = GetPVarInt( playerid, "Crime:ID" );
				
			if( CrimeFraction[crime][c_type_weapon] == listitem )
			{
				SendClient:( playerid, C_WHITE, !""gbError"У этой криминальной структуры уже выставлена эта группа оружия." );
				return showPlayerDialog( playerid, d_admin + 26, DIALOG_STYLE_LIST, "Оружие", weapon_change, "Выбрать", "Назад" );
			}
			
			CrimeFraction[crime][c_type_weapon] = listitem;
			
			mysql_format:g_string( "UPDATE `"DB_CRIME"` SET `c_type_weapon` = %d WHERE `c_id` = %d",
				CrimeFraction[crime][c_type_weapon],
				CrimeFraction[crime][c_id]
			);
			mysql_tquery( mysql, g_string );
			
			SendClient:( playerid, C_WHITE, !""gbSuccess"Вы изменили группу оружия для криминальной структуры." );
			
			showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
		}
		
		case d_admin + 27:
		{
			showPlayerDialog( playerid, d_admin + 26, DIALOG_STYLE_LIST, "Оружие", weapon_change, "Выбрать", "Назад" );
		}
		
		case d_admin + 28:
		{
			if( !response )
				return showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
				
			new
				crime = GetPVarInt( playerid, "Crime:ID" );
				
			if( CrimeFraction[crime][c_type_vehicles] )
				CrimeFraction[crime][c_type_vehicles] = 0;
			else
				CrimeFraction[crime][c_type_vehicles] = 1;
				
			mysql_format:g_string( "UPDATE `"DB_CRIME"` SET `с_type_vehicles` = '%d' WHERE `c_id` = %d",
				CrimeFraction[crime][c_type_vehicles],
				CrimeFraction[crime][c_id]
			);
			mysql_tquery( mysql, g_string );
			
			format:g_small_string( crime_vehicle, 
				CrimeFraction[crime][c_type_vehicles] ? ("Да") : ("Нет")
			);
			showPlayerDialog( playerid, d_admin + 28, DIALOG_STYLE_TABLIST_HEADERS, "Транспорт", g_small_string, "Изменить", "Назад" );
		}
		
		case d_admin + 29:
		{
			if( !response )
				return showPlayerDialog( playerid, d_admin + 23, DIALOG_STYLE_LIST, "Изменить...", crime_change, "Выбрать", "Назад" );
				
			new
				crime = GetPVarInt( playerid, "Crime:ID" );
				
			if( !CrimeFraction[crime][c_id] )
			{
				SendClient:( playerid, C_WHITE, !""gbDefault"Эта криминальная структура была удалена ранее." );
			
				DeletePVar( playerid, "Crime:ID" );
				return cmd_cfrac( playerid );
			}
				
			mysql_format:g_small_string( "DELETE FROM `"DB_CRIME"` WHERE `c_id` = %d LIMIT 1", CrimeFraction[crime][c_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_small_string( "DELETE FROM `"DB_CRIME_RANKS"` WHERE `r_fracid` = %d", CrimeFraction[crime][c_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_small_string( "DELETE FROM `"DB_VEHICLES"` WHERE `vehicle_crime` = %d", CrimeFraction[crime][c_id] );
			mysql_tquery( mysql, g_small_string );
			
			mysql_format:g_small_string( "UPDATE `"DB_USERS"` SET `uCrimeL` = 0, `uCrimeM` = 0, `uCrimeRank` = 0 WHERE `uCrimeM` = %d", CrimeFraction[crime][c_id] );
			mysql_tquery( mysql, g_small_string );
			
			foreach(new i: Player)
			{
				if( !IsLogged(i) || Player[i][uCrimeM] != CrimeFraction[crime][c_id] ) continue;
				
				Player[i][uCrimeM] = 
				Player[i][uCrimeL] = 
				Player[i][uCrimeRank] = 0;
				
				pformat:( !""gbDialog"Ваша криминальная организация расформирована администратором %s[%d].", Player[playerid][uName], playerid );
				psend:( i, C_WHITE );
			}
			
			for( new i; i < CrimeFraction[crime][c_amountveh]; i++ )
			{
				DestroyVehicleEx( CVehicle[ crime ][i][v_id] );
				
				mysql_format:g_string( "DELETE FROM `"DB_ITEMS"` WHERE `item_type_id` = %d AND `item_type` = 2", Vehicle[ CVehicle[ crime ][i][v_id] ][vehicle_id] );	
				mysql_tquery( mysql, g_string );
				
				CVehicle[ crime ][i][v_id] = 0;
				CVehicle[ crime ][i][v_number][0] = EOS;
			}
			
			for( new i; i < MAX_RANKS; i++ )
			{
				if( CrimeRank[crime][i][r_id] )
				{
					CrimeRank[crime][i][r_id] =
					CrimeRank[crime][i][r_fracid] =
					CrimeRank[crime][i][r_invite] =
					CrimeRank[crime][i][r_uninvite] =
					CrimeRank[crime][i][r_attach] =
					CrimeRank[crime][i][r_spawnveh] =
					CrimeRank[crime][i][r_call_weapon] = 0;
					
					CrimeRank[crime][i][r_name][0] =
					CrimeRank[crime][i][r_vehicles][0] =
					CrimeRank[crime][i][r_world][0] = EOS;
					
					for( new j; j < 4; j++ ) CrimeRank[crime][i][r_spawn][j] = 0.0;
				}
			}
			
			for( new i; i < 3; i++ )
			{
				CNameLeader[crime][i][0] = EOS;
			}
			
			pformat:( ""gbSuccess"Криминальная структура "cBLUE"%s"cWHITE" успешно удалена.", CrimeFraction[crime][c_name] );
			psend:( playerid, C_WHITE );
			
			CrimeFraction[crime][c_id] =
			CrimeFraction[crime][c_vehicles] =
			CrimeFraction[crime][c_ranks] =
			CrimeFraction[crime][c_amountveh] =
			CrimeFraction[crime][c_members] =
			CrimeFraction[crime][c_type_vehicles] =
			CrimeFraction[crime][c_type_weapon] = 0;
			
			CrimeFraction[crime][c_name][0] = 
			CrimeFraction[crime][c_leader][0] = EOS;
			
			CrimeFraction[crime][c_time] = 
			CrimeFraction[crime][c_time_dealer] = 0;
			
			CrimeFraction[crime][c_index_dealer] = INVALID_PARAM;
			
			COUNT_CRIMES --;
			
			DeletePVar( playerid, "Crime:ID" );
			cmd_cfrac( playerid );
		}
		
		case d_admin + 30:
		{
			if( !response ) return 1;
			
			SetPVarInt( playerid, "Admin:CrimePoint", listitem );
			
			showPlayerDialog( playerid, d_admin + 31, DIALOG_STYLE_LIST, "Действия", "\
				- Телепортироваться\n\
				- Удалить", "Выбрать", "Назад" );
		}
		
		case d_admin + 31:
		{
			if( !response ) return cmd_showpoint( playerid );
			
			new
				index = GetPVarInt( playerid, "Admin:CrimePoint" );
			
			switch( listitem )
			{
				case 0:
				{
					setPlayerPos( playerid, GunDealer[index][g_actor_pos][0], GunDealer[index][g_actor_pos][1], GunDealer[index][g_actor_pos][2] );
					SetPlayerVirtualWorld( playerid, 0 );
					SetPlayerInterior( playerid, 0 );
					
					pformat:( ""gbSuccess"Вы успешно телепортировались к точке гадилера ID %d.", GunDealer[index][g_id] );
					psend:( playerid, C_WHITE );
				}
				
				case 1:
				{
					if( GunDealer[index][g_fracid] )
					{
						SendClient:( playerid, C_WHITE, !""gbDefault"Вы не можете удалить активную точку." );
						return showPlayerDialog( playerid, d_admin + 31, DIALOG_STYLE_LIST, "Действия", "\
							- Телепортироваться\n\
							- Удалить", "Выбрать", "Назад" );
					}
				
					mysql_format:g_small_string( "DELETE FROM `"DB_CRIME_GUNDEALER"` WHERE `g_id` = %d LIMIT 1", GunDealer[index][g_id] );
					mysql_tquery( mysql, g_small_string );
					
					format:g_small_string( ""ADMIN_PREFIX" %s[%d] удалил точку гандилера ID %d в районе %s",
						Player[playerid][uName],
						playerid,
						GunDealer[index][g_id], GunDealer[index][g_zone] );
						
					SendAdmin:( C_DARKGRAY, g_small_string );
					
					GunDealer[index][g_id] = 
					GunDealer[index][g_actor] = 
					GunDealer[index][g_actor_id] = 
					GunDealer[index][g_car] = 
					GunDealer[index][g_car_id] = 
					GunDealer[index][g_fracid] = 
					GunDealer[index][g_time] = 0;
					
					for( new i; i < 4; i++ )
					{
						GunDealer[index][g_actor_pos][i] =
						GunDealer[index][g_car_pos][i] = 0;
					}
				}
			}
			
			DeletePVar( playerid, "Admin:CrimePoint" );
		}
		
		case d_admin + 32:
		{
			if( !response )
			{
				return cmd_cfrac( playerid );
			}
		
			for( new i; i < MAX_CRIMINAL; i++ )
			{
				if( !CrimeFraction[i][c_id] )
				{
					CrimeFraction[i][c_type] = listitem;
				
					mysql_format:g_string( "INSERT INTO `"DB_CRIME"` ( `c_name`, `c_type`, `c_leader` ) VALUES ( 'Crime Fraction', %d, '0|0|0' )", CrimeFraction[i][c_type] );
					mysql_tquery( mysql, g_string, "InsertCrimeFraction", "di", playerid, i );
				
					clean:<CrimeFraction[i][c_name]>;
					strcat( CrimeFraction[i][c_name], "New Crime Fraction", 64 );
					
					CrimeFraction[i][c_index_dealer] = INVALID_PARAM;
					
					return 1;
				}
			}
				
			SendClient:( playerid, C_WHITE, !""gbError"Ошибка. Количественный лимит криминальных структур превышен." );
			cmd_cfrac( playerid );
		}

		case d_makeleader :
		{
			if( !response )
			{
				DeletePVar( playerid, "UnLeader:Fraction" );
				return 1;
			}
				
			new 
				fid = GetPVarInt( playerid, "UnLeader:Fraction" );
				
			if( !Fraction[fid][f_leader][listitem] )
			{
				SendClient:( playerid, C_WHITE, ""gbError"В этой ячейке нет лидера." );
				format:g_small_string( "%d", fid + 1 );
				cmd_unleader( playerid, g_small_string );
				return 1;
			}
			
			SetPVarInt( playerid, "UnLeader:Select", listitem );
		
			format:g_small_string( "\
				"cBLUE"Снятие лидера\n\n\
				"cWHITE"Вы действительно желаете снять "cBLUE"%s"cWHITE" с поста лидера организации "cBLUE"%s"cWHITE".",
				FNameLeader[fid][listitem], Fraction[fid][f_name] );
			
			showPlayerDialog( playerid, d_makeleader + 1, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		}
		
		case d_makeleader + 1 : 
		{
			new 
				fid = GetPVarInt( playerid, "UnLeader:Fraction" ),
				index = GetPVarInt( playerid, "UnLeader:Select" );
		
			if( !response )
			{
				format:g_small_string( "%d", fid + 1 );
				return cmd_unleader( playerid, g_small_string );
			}
				
			if( !Fraction[fid][f_leader][index] )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Данный лидер уже снят." );
				format:g_small_string( "%d", fid + 1 );
				return cmd_unleader( playerid, g_small_string );
			}
			
			foreach(new i: Player)
			{
				if( IsLogged( i ) && Fraction[fid][f_leader][index] == Player[i][uID] )
				{
					Player[i][uLeader] = 
					Player[i][uMember] = 
					Player[i][uRank] = 0;
					
					break;
				}
			}

			clean:<g_string>;
			mysql_format( mysql, g_string, sizeof g_string, 
				"\
					UPDATE "DB_USERS" \
					SET \
						uLeader = 0, \
						uMember = 0, \
						uRank = 0 \
					WHERE uID = %d\
				",
				Fraction[fid][f_leader][index]
			);
			mysql_tquery( mysql, g_string );
			
			format:g_small_string("" #ADMIN_PREFIX " %s[%d] снял %s с поста лидера организации '%s'.",
				GetAccountName( playerid ),
				playerid,
				FNameLeader[fid][index],
				Fraction[fid][f_name]
			);
				
			SendAdmin:( C_GRAY, g_small_string );
			
			Fraction[fid][f_leader][index] = 0;
			clean:<FNameLeader[fid][index]>;
			
			clean:<g_string>;
			mysql_format( mysql, g_string, sizeof g_string, 
				"\
					UPDATE `"DB_FRACTIONS"` \
					SET \
						`f_leader` = '%d|%d|%d', \
						`f_leadername_1` = '%e', \
						`f_leadername_2` = '%e', \
						`f_leadername_3` = '%se' \
					WHERE `f_id` = %d\
				",
				Fraction[fid][f_leader][0],
				Fraction[fid][f_leader][1],
				Fraction[fid][f_leader][2],
				FNameLeader[fid][0],
				FNameLeader[fid][1],
				FNameLeader[fid][2],
				Fraction[fid][f_id]
			);		
			mysql_tquery( mysql, g_string );
			
			DeletePVar( playerid, "UnLeader:Fraction" );
			DeletePVar( playerid, "UnLeader:Select" );
			
			return 1;
		}
		
		case d_makeleader + 2:
		{
			if( !response )
			{
				DeletePVar( playerid, "UnLeader:Crime" );
				return 1;
			}
			
			new 
				crime = GetPVarInt( playerid, "UnLeader:Crime" );
			
			SetPVarInt( playerid, "UnLeader:Select", listitem );
		
			format:g_small_string( "\
				"cBLUE"Снятие лидера\n\n\
				"cWHITE"Вы действительно желаете снять "cBLUE"%s"cWHITE" с поста лидера криминальной структуры "cBLUE"%s"cWHITE".",
				CNameLeader[crime][listitem], CrimeFraction[crime][c_name] );
			
			showPlayerDialog( playerid, d_makeleader + 3, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		}
		
		case d_makeleader + 3:
		{
			new 
				crime = GetPVarInt( playerid, "UnLeader:Crime" ),
				index = GetPVarInt( playerid, "UnLeader:Select" );
		
			if( !response )
			{
				format:g_small_string( "%d", CrimeFraction[crime][c_id] );
				return cmd_uncleader( playerid, g_small_string );
			}
				
			if( !CrimeFraction[crime][c_leader][index] )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Данный лидер уже снят." );
				format:g_small_string( "%d", CrimeFraction[crime][c_id] );
				return cmd_uncleader( playerid, g_small_string );
			}
			
			foreach(new i: Player)
			{
				if( IsLogged( i ) && CrimeFraction[crime][c_leader][index] == Player[i][uID] )
				{
					Player[i][uCrimeL] = 
					Player[i][uCrimeM] = 
					Player[i][uCrimeRank] = 0;
					
					break;
				}
			}

			mysql_format:g_string(
				"\
					UPDATE "DB_USERS" \
					SET \
						uCrimeL = 0, \
						uCrimeM = 0, \
						uCrimeRank = 0 \
					WHERE uID = %d\
				",
				CrimeFraction[crime][c_leader][index]
			);
			mysql_tquery( mysql, g_string );
			
			format:g_small_string("" #ADMIN_PREFIX " %s[%d] снял %s с поста лидера криминальной структуры '%s'.",
				GetAccountName( playerid ),
				playerid,
				CNameLeader[crime][index],
				CrimeFraction[crime][c_name]
			);
				
			SendAdmin:( C_GRAY, g_small_string );
			
			CrimeFraction[crime][c_leader][index] = 0;
			clean:<CNameLeader[crime][index]>;
			
			mysql_format:g_string(
				"\
					UPDATE `"DB_CRIME"` \
					SET \
						`c_leader` = '%d|%d|%d', \
						`c_leadername_1` = '%e', \
						`c_leadername_2` = '%e', \
						`c_leadername_3` = '%e' \
					WHERE `c_id` = %d\
				",
				CrimeFraction[crime][c_leader][0],
				CrimeFraction[crime][c_leader][1],
				CrimeFraction[crime][c_leader][2],
				CNameLeader[crime][0],
				CNameLeader[crime][1],
				CNameLeader[crime][2],
				CrimeFraction[crime][c_id]
			);		
			mysql_tquery( mysql, g_string );
			
			DeletePVar( playerid, "UnLeader:Crime" );
			DeletePVar( playerid, "UnLeader:Select" );
		}
		
		case d_support :
		{
			if( !response )
				return 1;
				
			switch( listitem )
			{
				case 0 :
				{
					new
					    fmt_player[ 32 + MAX_PLAYER_NAME + 2 ],
						fmt_spectate[ 64 ],
						fmt_afk [ 32 ],
						admin_count = 0,
						support_count = 0;
						
					clean:<g_big_string>;
					
					strcat( g_big_string, ""gbDefault"Администраторы в сети:\n\n" );
					
					foreach(new i : Player) 
					{
						if( !IsLogged( i ) || !GetAccessAdmin( i, 1, false ) ) 
							continue;
						
						format( fmt_player, sizeof fmt_player, "(%d) "cBLUE"%s[%d]"cWHITE"",
							Admin[i][aLevel],
							Player[i][uName],
							i
						);
						
						if( GetPVarInt( i, "Admin:SpectateId" ) != INVALID_PLAYER_ID ) 
						{
							format( fmt_spectate, sizeof fmt_spectate, " - "cGREEN"/sp %d"cWHITE"",
							    GetPVarInt( i, "Admin:SpectateId" )
							);
						}
						
						if( IsAfk( i ) ) 
						{
                               format( fmt_afk, sizeof fmt_afk, " - "cGRAY"[AFK: %d]"cWHITE"",
							    GetPVarInt( i, "Player:Afk" )
							);
						}
						
						
						format:g_small_string(  "%s%s%s%s\n",
							fmt_player,
							GetPVarInt( i, "Admin:SpectateId" ) != INVALID_PLAYER_ID ? fmt_spectate : (""),
							IsAfk( i ) ? fmt_afk : (""),
							!GetPVarInt( i, "Admin:Duty" ) ? (" - "cRED"[Не авторизован]"cGRAY"") : ("")
						);
						
						++admin_count;
						strcat( g_big_string, g_small_string );
					}
					
					strcat( g_big_string, "\n\n\n"gbDefault"Саппорты в сети:\n\n" );
					
					foreach(new i : Player) 
					{
						if( !IsLogged( i ) || !GetAccessSupport( i ) ) 
							continue;
						
						if( IsAfk( i ) ) 
						{
                               format( fmt_afk, sizeof fmt_afk, " - "cGRAY"[AFK: %d]",
							    GetPVarInt( i, "Player:Afk" )
							);
						}
						
						format( fmt_player, sizeof fmt_player, ""cBLUE"%s[%d]%s%s"cWHITE"\n",
							Player[i][uName],
							i,
							IsAfk( i ) ? fmt_afk : (""),
							!GetPVarInt( i, "Support:Duty" ) ? (" - "cGRAY"[Не на дежурстве]"cWHITE"") : ("")
						);
						
						++support_count;
						
						strcat( g_big_string, fmt_player );
					}
					
					if( support_count == 0 )
					    strcat( g_big_string, "Саппортов нет в сети.\n" );
					
					format:g_small_string(  "\n\nВсего администраторов в сети: "cBLUE"%d\n"cWHITE"Всего саппортов в сети: "cBLUE"%d",
						admin_count,
						support_count
					);
					
					strcat( g_big_string, g_small_string );
				
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Закрыть", "");
				}
				
				case 1 :
				{
					clean:<g_big_string>;
					strcat( g_big_string, "" #gbSuccess "Список команд.\n\n" );
					strcat( g_big_string, "\
						"cBLUE"/h"cWHITE" - Чат саппортов.\n\
						"cBLUE"/scp"cWHITE" - Панель саппорта.\n\
						"cBLUE"/sduty"cWHITE" - Выйти на / покинуть дежурство.\n\
						"cBLUE"/ans"cWHITE" - Ответить игроку." );
					
					showPlayerDialog( playerid, d_support + 1, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "Закрыть" );
				}
				
				case 2 :
				{
					clean:<g_big_string>;
					strcat( g_big_string, ""gbSuccess"Статистика.\n\n" );
					format:g_small_string( " - Идентификатор: "cBLUE"%d"cWHITE"\n", Support[playerid][sID] ), strcat( g_big_string, g_small_string );
					format:g_small_string( " - Имя: "cBLUE"%s"cWHITE"\n", Support[playerid][sName] ), strcat( g_big_string, g_small_string );

					format:g_small_string( " - Часов наиграно: "cBLUE"-"cWHITE"\n"), strcat( g_big_string, g_small_string );
					format:g_small_string( "     За день:"cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
					format:g_small_string( "     За неделю: "cBLUE"-"cWHITE"\n\n" ), strcat( g_big_string, g_small_string );

					format:g_small_string( " - Всего ответов: "cBLUE"-"cWHITE"\n" ), strcat( g_big_string, g_small_string );
					showPlayerDialog( playerid, d_support + 1, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "Закрыть");
				}
			}
		}
		
		case d_support + 1 :
		{
			if( response )
				return showPlayerDialog( playerid, d_support, DIALOG_STYLE_LIST, " ", hcontent_hcp, "Далее", "Закрыть" );
		}
	
	}
	
	return 1;
}