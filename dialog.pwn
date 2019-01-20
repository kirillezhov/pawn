Extra_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{	
	switch( dialogid )
	{
		case d_commands :
		{
			if( !response )
				return 1;
			
			if( inputtext[0] == EOS )
			{
				showPlayerDialog( playerid, d_commands, DIALOG_STYLE_INPUT, " ", 
				""cBLUE"Установить действие\n\n"cWHITE"Введите текст действия:", 
				"Далее", "Закрыть");
				return 1;
			}
			
			format:g_small_string( "%s\n(( %s[%d] ))",
				inputtext,
				GetAccountName( playerid ),
				playerid
			);
		
			GetPlayerPos( playerid, Player[playerid][tPos][0], Player[playerid][tPos][1], Player[playerid][tPos][2] );
			
			Player[playerid][tAction] = CreateDynamic3DTextLabel( 
				g_small_string, 
				C_OPACITY_GRAY, 
				Player[playerid][tPos][0],
				Player[playerid][tPos][1],
				Player[playerid][tPos][2], 
				10.0 
			);
			
			format( Player[playerid][tActionText], 128, "%s", inputtext );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Вы успешно установили действие. Для управления, используйте - "cBLUE"/action"cWHITE".");

			format:g_small_string( ""ADMIN_PREFIX" %s[%d] установил действие: %s",
				GetAccountName( playerid ),
				playerid,
				inputtext
			);
			
			SendAdmin:( C_YELLOW, g_small_string );
			
		}
		 
		case d_commands + 1 :
		{
			switch( listitem )
			{
				case 0 :
				{
					if( Player[playerid][tAction] == Text3D: INVALID_3DTEXT_ID )
					{
						format:g_small_string( ""gbDefault"Текущее действие.\n\n"gbDialog"На данный момент у Вас не установлено описание." );
					}
					else
					{
						format:g_small_string( ""gbDefault"Текущее действие.\n\n"gbDialogSuccess"%s", 
							Player[playerid][tActionText] 
						);
					}
					
					showPlayerDialog( playerid, d_commands + 2, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 1 :
				{
					if( IsMuted( playerid, IC ) )
						return SendClient:( playerid, C_WHITE, !CHAT_MUTE_IC );
						
					showPlayerDialog( playerid, d_commands + 3, DIALOG_STYLE_INPUT, " ", 
					""gbDefault"Установить новое действие.\n\n"gbDialog"Введите текст нового действия:\n\n"gbDialogError"Старое действие удалится.", 
					"Далее", "Назад");
				}
			
				case 2 :
				{
					if( Player[playerid][tAction] != Text3D: INVALID_3DTEXT_ID )
					{
						if( IsValidDynamic3DTextLabel( Player[playerid][tAction] ) )
						{
							DestroyDynamic3DTextLabel( Player[playerid][tAction] );
						}
						
						Player[playerid][tAction] = Text3D: INVALID_3DTEXT_ID;
						clean:<Player[playerid][tActionText]>;
						SendClient:( playerid, C_WHITE, ""gbSuccess"Вы успешно удалили действие персонажа.");
					}
					else 
						printf("[Log] Player %s[%d] trying delete invalid 3dtext.", GetAccountName( playerid ), playerid );
				}
			}
		}
		
		case d_commands + 2 :
		{
			if( !response )
				return 1;
			
			if( Player[playerid][tAction] == Text3D: INVALID_3DTEXT_ID )
			{
				showPlayerDialog( playerid, d_commands, DIALOG_STYLE_INPUT, " ", 
				""cBLUE"Установить действие\n\n"cWHITE"Введите текст действия:", 
				"Далее", "Закрыть");
			}
			else
			{
				showPlayerDialog( playerid, d_commands + 1, DIALOG_STYLE_LIST, " ", 
				""cBLUE"-"cWHITE" Текущее действие\n\
				 "cBLUE"-"cWHITE" Установить новое действие\n\
				 "cBLUE"-"cWHITE" Удалить действие", 
				"Далее", "Закрыть");
			}
		}
		
		case d_commands + 3 :
		{
			if( !response )
				return 1;
			
			if( inputtext[0] == EOS )
			{
				showPlayerDialog( playerid, d_commands + 3, DIALOG_STYLE_INPUT, " ", 
					""gbDefault"Установить новое действие.\n\n"gbDialog"Введите текст нового действия:\n\n"gbDialogError"Старое действие удалится.", 
					"Далее", "Назад");
				return 1;
			}
			
			if( Player[playerid][tAction] != Text3D: INVALID_3DTEXT_ID  )
			{
				if( IsValidDynamic3DTextLabel( Player[playerid][tAction] ) )
				{
					DestroyDynamic3DTextLabel( Player[playerid][tAction] );
				}
				
				Player[playerid][tAction] = Text3D: INVALID_3DTEXT_ID;
				clean:<Player[playerid][tActionText]>;
			}
			
			format:g_small_string( "%s\n(( %s[%d] ))",
				inputtext,
				GetAccountName( playerid ),
				playerid
			);
		
			GetPlayerPos( playerid, Player[playerid][tPos][0], Player[playerid][tPos][1], Player[playerid][tPos][2] );
			
			Player[playerid][tAction] = CreateDynamic3DTextLabel( 
				g_small_string, 
				C_OPACITY_GRAY, 
				Player[playerid][tPos][0],
				Player[playerid][tPos][1],
				Player[playerid][tPos][2], 
				10.0 
			);
			
			format( Player[playerid][tActionText], 128, "%s", inputtext );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Вы успешно установили действие. Для управления, используйте - "cBLUE"/action"cWHITE".");

			format:g_small_string( ""ADMIN_PREFIX" %s[%d] установил действие: %s",
				GetAccountName( playerid ),
				playerid,
				inputtext
			);
			
			SendAdmin:( C_YELLOW, g_small_string );
		}
		
		case d_commands + 4 :
		{
			if( !response )
				return 1;
			
			if( inputtext[0] == EOS )
			{
				return showPlayerDialog( playerid, d_commands + 4, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Установить описание персонажа\n\n\
					"cWHITE"Введите текст описания:", 
					"Далее", "Закрыть");
			}
			
			if( strlen( inputtext ) > 126 )
			{
				return showPlayerDialog( playerid, d_commands + 4, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Установить описание персонажа\n\n\
					"cWHITE"Введите текст описания:\n\
					"gbDialogError"Превышен допустимый лимит символов.", 
					"Далее", "Закрыть");
			}
			
			new
				text[ 128 ];
			
			clean:<Player[playerid][uPame]>;
			
			if( strlen( inputtext ) > 50 )
			{
				strmid( Player[playerid][uPame], inputtext, 0, 49, 128 );
				strmid( text, inputtext, 50, 126, 128 );
				
				strcat( Player[playerid][uPame], "\n", 128 );
				strcat( Player[playerid][uPame], text, 128 );
			}
			else
			{
				strcat( Player[playerid][uPame], inputtext, 128 );
			}
			
			UpdatePlayerString( playerid, "uPame", Player[playerid][uPame] );
			SendClient:( playerid, C_WHITE, ""gbSuccess"Вы успешно установили описание. Для управления используйте - "cBLUE"/mypame"cWHITE".");
		}
	
		case d_commands + 5 :
		{
			if( !response ) return 1;
		
			switch( listitem )
			{
				case 0 :
				{
					if( isnull( Player[playerid][uPame] ) )
					{
						format:g_small_string( ""cBLUE"Текущее описание\n\n\
							"cWHITE"На данный момент у Вас не установлено описание." );
					}
					else
					{
						format:g_small_string( ""cBLUE"Текущее описание\n\n\
							"cWHITE"%s", 
							Player[playerid][uPame] 
						);
					}
					
					showPlayerDialog( playerid, d_commands + 6, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Назад", "" );
				}
				
				case 1 :
				{
					if( IsMuted( playerid, IC ) )
						return SendClient:( playerid, C_WHITE, !CHAT_MUTE_IC );
						
					showPlayerDialog( playerid, d_commands + 7, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Установить новое описание\n\n\
					"cWHITE"Введите текст нового описания:\n\
					"gbDialog"Текущее описание будет удалено.", 
					"Далее", "Назад");
				}
				
				case 2 :
				{
					if( !isnull( Player[playerid][uPame] ) )
					{
						Player[playerid][uPame][0] = EOS;
						SendClient:( playerid, C_WHITE, !""gbSuccess"Вы успешно удалили описание персонажа.");
						
						UpdatePlayerString( playerid, "uPame", Player[playerid][uPame] );
					}
					else
					{
						showPlayerDialog( playerid, d_commands + 5, DIALOG_STYLE_LIST, " ", 
						""cBLUE"-"cWHITE" Текущее описание\n\
						 "cBLUE"-"cWHITE" Установить новое описание\n\
						 "cBLUE"-"cWHITE" Удалить описание", 
						"Далее", "Закрыть");
						
						SendClient:( playerid, C_WHITE, !""gbError"У Вас не установлено описание персонажа." );
					}
				}
			}
		}
		
		case d_commands + 6 :
		{	
			showPlayerDialog( playerid, d_commands + 5, DIALOG_STYLE_LIST, " ", 
			""cBLUE"-"cWHITE" Текущее описание\n\
			 "cBLUE"-"cWHITE" Установить новое описание\n\
			 "cBLUE"-"cWHITE" Удалить описание", 
			"Далее", "Закрыть");
		}
		
		case d_commands + 7 :
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_commands + 5, DIALOG_STYLE_LIST, " ", 
					""cBLUE"-"cWHITE" Текущее описание\n\
					 "cBLUE"-"cWHITE" Установить новое описание\n\
					 "cBLUE"-"cWHITE" Удалить описание", 
					"Далее", "Закрыть");
			}
		
			if( inputtext[0] == EOS || strlen( inputtext ) > 128 )
			{
				return showPlayerDialog( playerid, d_commands + 7, DIALOG_STYLE_INPUT, " ", 
					""cBLUE"Установить новое описание персонажа\n\n\
					"cWHITE"Введите текст описания:", 
					"Далее", "Закрыть");
			}
			
			new
				text[ 128 ];
			
			clean:<Player[playerid][uPame]>;
			
			if( strlen( inputtext ) > 50 )
			{
				strmid( text, inputtext, 50, 126, 128 );
			
				strmid( Player[playerid][uPame], inputtext, 0, 49, 128 );
				
				strcat( Player[playerid][uPame], "\n", 128 );
				strcat( Player[playerid][uPame], text, 128 );
			}
			else
			{
				strcat( Player[playerid][uPame], inputtext, 128 );
			}
			
			UpdatePlayerString( playerid, "uPame", Player[playerid][uPame] );
			SendClient:( playerid, C_WHITE, ""gbSuccess"Вы успешно изменили описание. Для управления, используйте - "cBLUE"/mypame"cWHITE".");
		}
	}
	
	return 1;
}