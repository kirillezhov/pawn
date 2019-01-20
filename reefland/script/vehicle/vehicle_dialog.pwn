function Vehicle_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{	
	switch( dialogid ) 
	{		
		case d_cars :
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				return 1;
			}	
			if( listitem == 0 )
				return cmd_cpanel( playerid );
				
			if( Vehicle[ g_dialog_select[playerid][listitem] ][vehicle_arrest] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Эта машина находится на штрафстоянке." );
				return cmd_cpanel( playerid );
			}
			
			if( GetPVarInt( playerid, "Utilization:Carid" ) == g_dialog_select[playerid][listitem] )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Вы не можете пользоваться этим транспортом во время его утилизации." );
				return cmd_cpanel( playerid );
			}
				
			SetPVarInt( playerid, "Vehicle:Id", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			ShowDialogCarPanel( playerid, d_cars + 1 );
		}
		
		case d_cars + 1 :
		{
			if( !response )
			{
				SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
				ShowPlayerVehicleList( playerid, d_cars );		
				return 1;
			}
			
			new
				vehicleid = GetPVarInt( playerid, "Vehicle:Id" );

			g_player_interaction{playerid} = 0;
			
			switch( listitem )
			{
				case 0 :
				{
					return ShowVehicleInformation( playerid, vehicleid, d_cars + 2, "Подробнее", "Назад" );
				}
				
				case 1 :
				{
					if( !ShowDialogCarManaged( playerid, vehicleid ) )
					{
						SendClient:( playerid, C_WHITE, !""gbError"У данного транспорта отсутствует капот и багажник." );
						ShowDialogCarPanel( playerid, d_cars + 1 );
					}
					
					return 1;
				}
				
				case 2 :
				{
					if( IsVehicleOccupied( vehicleid ) )
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете совершить данное действие, Ваш транспорт используется." );
					
					SetVehicleZAngle( vehicleid, Vehicle[vehicleid][vehicle_pos][3] );
					setVehiclePos( vehicleid, 
						Vehicle[vehicleid][vehicle_pos][0],
						Vehicle[vehicleid][vehicle_pos][1],
						Vehicle[vehicleid][vehicle_pos][2]
					);
					
					ResetVehicleParams( vehicleid );
					
					pformat:( ""gbSuccess"Вы успешно вернули транспорт - "cBLUE"%s"cWHITE" на парковочное место.",
						GetVehicleModelName( Vehicle[vehicleid][vehicle_model] )
					);
					psend:( playerid, C_WHITE );
				}
				
				case 3 :
				{
					if( IsPlayerInAnyVehicle( playerid ) && GetPlayerVehicleID( playerid ) == vehicleid )
					{
						ShowDialogCarPanel( playerid, d_cars + 1 );
						
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете совершить данное действие, находясь уже в этом транспорте." );
					}
				
					SetSearchVehicleMod( playerid, vehicleid, true );
					
					if( g_player_gps{playerid} )
					{
						pformat:( ""gbSuccess"Вы установили метку на транспорт - "cBLUE"%s"cWHITE".",
							GetVehicleModelName( Vehicle[vehicleid][vehicle_model] )
						);
						psend:( playerid, C_WHITE );
					}
					else
					{
						SendClient:( playerid, C_WHITE, ""gbSuccess"Вы убрали метку на своем GPS." );
					}	
				}
				
				case 4 :
				{
					/*if( IsVehicleOccupied( vehicleid ) )
						return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете совершить данное действие, Ваш транспорт используется." );*/
				
					if( !IsPlayerInVehicle( playerid, vehicleid ) )
						return SendClient:( playerid, C_WHITE, !""gbError"Для совершения данного действия, Вы должны находиться в транспорте." );
					
					SetVehiclePark( vehicleid );
					SendClient:( playerid, C_WHITE, !""gbSuccess"Вы успешно припарковали свой транспорт." );
				}
				
				case 5 :
				{
					return showPlayerDialog( playerid, d_cars + 4, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Обмен транспорта.\n\n\
						"cWHITE"Введите id игрока, c которым Вы хотите обменяться транспортом:\n\n\
						"gbDialog"Игрок должен находиться рядом с Вами.", 
					"Далее", "Назад" );
					
					// Обмен
				}
				
				case 6 :
				{
					return showPlayerDialog( playerid, d_cars + 7, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Продажа транспорта.\n\n\
						"cWHITE"Введите id игрока, которому Вы хотите продать транспорт:\n\n\
						"gbDialog"Игрок должен находиться рядом с Вами.",
					"Далее", "Назад" );
					// Продажа
				}
			}
			
			ShowDialogCarPanel( playerid, d_cars + 1 );
		}
		
		case d_cars + 2 :
		{
			if( !response )
				return showPlayerDialog( playerid, d_cars + 1, DIALOG_STYLE_LIST, " ", vehcontent_cpanel, "Выбрать", "Назад" );
				
			ShowVehicleAddInformation( playerid, GetPVarInt( playerid, "Vehicle:Id" ), d_cars + 16 );
		}
		
		case d_cars + 3 :
		{
			if( !response )
				return ShowDialogCarPanel( playerid, d_cars + 1 );
				
			switch( listitem )
			{
				case 0 : 
				{
					if( g_dialog_select[playerid][0] == 1 )
						cmd_boot( playerid );
					else
						cmd_hood( playerid );
				}
				case 1 : cmd_boot( playerid );
			}
			
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			ShowDialogCarManaged( playerid, GetPVarInt( playerid, "Vehicle:Id" ) );
		}
		
		
		case d_cars + 4 :
		{
			if( !response )
				return ShowDialogCarPanel( playerid, d_cars + 1 );
				
			if( listitem == 0 )
			{	
				ShowPlayerVehicleList( playerid, d_cars + 4, "Отмена");	

				return 1;
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) )
			{			
				return showPlayerDialog( playerid, d_cars + 4, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Обмен транспорта.\n\n\
					"cWHITE"Введите id игрока, c которым Вы хотите обменяться транспортами:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Введите id игрока.", 
				"Далее", "Назад" );
			}
			
			if( !IsLogged( strval( inputtext ) ) || strval( inputtext ) == playerid )
			{
				return showPlayerDialog( playerid, d_cars + 4, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Обмен транспорта.\n\n\
					"cWHITE"Введите id игрока, c которым Вы хотите обменяться транспортами:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы ввели некорректный id игрока.", 
				"Далее", "Назад" );
			}
			
			if( !Player[strval( inputtext )][uLevel] )
			{
				return showPlayerDialog( playerid, d_cars + 4, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Обмен транспорта.\n\n\
					"cWHITE"Введите id игрока, c которым Вы хотите обменяться транспортами:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы не можете обменяться с этим игроком транспортом.", 
				"Далее", "Назад" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 )
			{
				return showPlayerDialog( playerid, d_cars + 4, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Обмен транспорта.\n\n\
					"cWHITE"Введите id игрока, c которым Вы хотите обменяться транспортами:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.", 
				"Далее", "Назад" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } != 0 )
			{
				return showPlayerDialog( playerid, d_cars + 4, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Обмен транспорта.\n\n\
					"cWHITE"Введите id игрока, c которым Вы хотите обменяться транспортами:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы не можете взаимодействовать с данным игроком, повторите попытку позже.", 
				"Далее", "Назад" );
			}
				
			SetPVarInt( playerid, "Vehicle:TradeId", strval( inputtext ) );
			
			new 
				tradeid = GetPVarInt( playerid, "Vehicle:TradeId" );
			
			pformat:( ""gbSuccess"Вы отправили предложение игроку "cBLUE"%s[%d]"cWHITE" об обмене транспорта.",
				GetAccountName( tradeid ),
				tradeid
			);
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" предлагает обменять Ваш выбранный транспорт на "cBLUE"%s"cWHITE".",
				GetAccountName( playerid ),
				playerid,
				GetVehicleModelName( Vehicle[GetPVarInt( playerid, "Vehicle:Id" )][vehicle_model] )
			);
			psend:( tradeid, C_WHITE );
			
			SetPVarInt( tradeid, "Vehicle:PlayerId", playerid );
			
			g_player_interaction{playerid} = 1;
			g_player_interaction{tradeid} = 1;
			
			ShowPlayerVehicleList( tradeid, d_cars + 5, "Отмена" );
		}
		
		case d_cars + 5 :
		{
			new 
				offer_tradeid = GetPVarInt( playerid, "Vehicle:PlayerId" );
			
			if( !response )
			{
				pformat:( ""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от Вашего предложения.",
					GetAccountName( playerid ),
					playerid
				);
				psend:( offer_tradeid, C_WHITE );
				
				pformat:( ""gbError"Вы отказались от предложения "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( offer_tradeid ),
					offer_tradeid
				);
				
				psend:( playerid, C_WHITE );
				
				SetPVarInt( playerid, "Vehicle:PlayerId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
				SetPVarInt( offer_tradeid, "Vehicle:TradeId", INVALID_PLAYER_ID );
				SetPVarInt( offer_tradeid, "Vehicle:Id", INVALID_PARAM );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{offer_tradeid} = 0;
			
				return 1;
			}
				
			SetPVarInt( playerid, "Vehicle:Id", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			pformat:( ""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" подтверждает обмен.",
				GetAccountName( offer_tradeid ),
				offer_tradeid
			);
			
			psend:( playerid, C_WHITE );
			
			clean:<g_big_string>;
			strcat( g_big_string, ""cBLUE"Обмен транспорта.\n\n" );
			format:g_string( ""cWHITE"Вы действительно хотите обменять Ваш транспорт "cBLUE"%s"cWHITE" на транспорт "cBLUE"%s[%d]"cWHITE" - "cBLUE"%s"cWHITE"?",
				GetVehicleModelName( Vehicle[GetPVarInt( offer_tradeid, "Vehicle:Id" )][vehicle_model] ),
				GetAccountName( playerid ),
				playerid,
				GetVehicleModelName( Vehicle[GetPVarInt( playerid, "Vehicle:Id" )][vehicle_model] )
			);
			
			strcat( g_big_string, g_string );
			
			showPlayerDialog( offer_tradeid, d_cars + 6, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Далее", "Отмена" );
		}
		
		case d_cars + 6 :
		{		
		
			new 
				tradeid = GetPVarInt( playerid, "Vehicle:TradeId" );
				
			if( !response )
			{
				pformat:( ""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от Вашего предложения.",
					GetAccountName( playerid ),
					playerid
				);
				
				psend:( tradeid, C_WHITE );
				
				pformat:( ""gbError"Вы отказались от предложения "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( tradeid ),
					tradeid
				);
				
				psend:( playerid, C_WHITE );
				
				SetPVarInt( tradeid, "Vehicle:PlayerId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Vehicle:TradeId", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
				SetPVarInt( tradeid, "Vehicle:Id", INVALID_PARAM );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{tradeid} = 0;
				return 1;
			}	
			
			OfferTradePlayerVehicle( playerid, tradeid );

			pformat:( ""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" принял Ваше предложение.",
				GetAccountName( playerid ),
				playerid
			);
			
			psend:( tradeid, C_WHITE );
			
			pformat:( ""gbSuccess"Вы приняли предложение "cBLUE"%s[%d]"cWHITE".",
				GetAccountName( tradeid ),
				tradeid
			);
			
			psend:( playerid, C_WHITE );
			
			log( LOG_SWAP_VEHICLE, "обменялся транспортом", Player[playerid][uID], Player[tradeid][uID], Vehicle[GetPVarInt( playerid, "Vehicle:Id" )][vehicle_id], Vehicle[GetPVarInt( tradeid, "Vehicle:Id" )][vehicle_id] );
			
			SetPVarInt( tradeid, "Vehicle:PlayerId", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Vehicle:TradeId", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
			SetPVarInt( tradeid, "Vehicle:Id", INVALID_PARAM );	
			
			g_player_interaction{playerid} = 0;
			g_player_interaction{tradeid} = 0;
		}
		
		case d_cars + 7 :
		{
			if( !response )
				return ShowDialogCarPanel( playerid, d_cars + 1 );
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) )
			{			
				return showPlayerDialog( playerid, d_cars + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа транспорта.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать транспорт:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Введите id игрока.", 
				"Далее", "Назад" );
			}
			
			if( !IsLogged( strval( inputtext ) ) || strval( inputtext ) == playerid )
			{
				return showPlayerDialog( playerid, d_cars + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа транспорта.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать транспорт:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы ввели некорректный id игрока.", 
				"Далее", "Назад" );
			}
			
			if( !Player[strval( inputtext )][uLevel] )
			{
				return showPlayerDialog( playerid, d_cars + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа транспорта.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать транспорт:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы не можете продать транспорт этому игроку.", 
				"Далее", "Назад" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, strval( inputtext ) ) > 3.0 )
			{
				return showPlayerDialog( playerid, d_cars + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа транспорта.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать транспорт:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.", 
				"Далее", "Назад" );
			}
			
			if( g_player_interaction{ strval( inputtext ) } != 0 )
			{
				return showPlayerDialog( playerid, d_cars + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа транспорта.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать транспорт:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Вы не можете взаимодействовать с данным игроком, повторите попытку позже.", 
				"Далее", "Назад" );
			}
				
			SetPVarInt( playerid, "Vehicle:SaleId", strval( inputtext ) );
			
			g_player_interaction{playerid} = 1;
			g_player_interaction{strval( inputtext )} = 1;
			
			ShowDialogVehicleSell( playerid, GetPVarInt( playerid, "Vehicle:Id" ) );
		}
		
		case d_cars + 8 :
		{
			if( !response )
			{
				g_player_interaction{playerid} = 0;
				g_player_interaction{GetPVarInt( playerid, "Vehicle:SaleId")} = 0;
				
				SetPVarInt( playerid, "Vehicle:SaleId", INVALID_PLAYER_ID );
				
				return showPlayerDialog( playerid, d_cars + 7, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Продажа транспорта.\n\n\
					"cWHITE"Введите id игрока, которому Вы хотите продать транспорт:\n\n\
					"gbDialog"Игрок должен находиться рядом с Вами.\n\
					"gbDialogError"Введите id игрока.", 
				"Далее", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) )
			{			
				return ShowDialogVehicleSell( playerid, GetPVarInt( playerid, "Vehicle:Id" ), "\n\n"gbDialogError"Введите сумму ниже:" );
			}
			
			if( GetDistanceBetweenPlayers( playerid, GetPVarInt( playerid, "Vehicle:SaleId" ) ) > 3.0 )
			{
				return ShowDialogVehicleSell( playerid, GetPVarInt( playerid, "Vehicle:Id" ), "\n\n"gbDialogError"Игрок должен находиться рядом с Вами." );
			}
			
			if( IsOwnerVehicleCount( GetPVarInt( playerid, "Vehicle:SaleId" ) ) >= 1 + Premium[ GetPVarInt( playerid, "Vehicle:SaleId" ) ][prem_car] )
			{
				return ShowDialogVehicleSell( playerid, GetPVarInt( playerid, "Vehicle:Id" ), "\n\n"gbDialogError"Игрок не может иметь такое количество автомобилей." );
			}
			
			new 
				price = GetVehiclePrice( Vehicle[GetPVarInt( playerid, "Vehicle:Id" )][vehicle_model] );
			
			if( strval( inputtext ) < 1 || strval( inputtext) > floatround( ( price * 0.2 ) + price ) )
			{
				return ShowDialogVehicleSell( playerid, GetPVarInt( playerid, "Vehicle:Id" ), "\n\n"gbDialogError"Вы ввели некорректную сумму." );
			}
			
			new 
				saleid = GetPVarInt( playerid, "Vehicle:SaleId" );
			
			pformat:( ""gbSuccess"Вы отправили предложение игроку "cBLUE"%s[%d]"cWHITE" о продаже транспорта.",
				GetAccountName( saleid ),
				saleid
			);
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" предлагает продать свой транспорт "cBLUE"%s"cWHITE".",
				GetAccountName( playerid ),
				playerid,
				GetVehicleModelName( Vehicle[GetPVarInt( playerid, "Vehicle:Id" )][vehicle_model] )
			);
			psend:( saleid, C_WHITE );
			
			SetPVarInt( saleid, "Vehicle:PlayerId", playerid );
			
			clean:<g_big_string>;
			strcat( g_big_string, ""cBLUE"Продажа транспорта.\n\n" );
			format:g_string( ""cWHITE"Вы действительно хотите купить транспорт "cBLUE"%s"cWHITE" игрока "cBLUE"%s[%d]"cWHITE"?\n\n%sЦена: $%d",
				GetVehicleModelName( Vehicle[GetPVarInt( playerid, "Vehicle:Id" )][vehicle_model] ),
				GetAccountName( playerid ),
				playerid,
				( strval( inputtext ) < Player[saleid][uMoney] ) ? (""gbDialogSuccess"") : (""gbDialogError""),
				strval( inputtext )
			);
			strcat( g_big_string, g_string );
			
			showPlayerDialog( saleid, d_cars + 9, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Далее", "Отмена" );
			
			SetPVarInt( saleid, "Vehicle:SellPrice", strval( inputtext ) );
		}
		
		case d_cars + 9 :
		{
			new 
				id = GetPVarInt( playerid, "Vehicle:PlayerId" );
				
			if( !response )
			{
				pformat:( ""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от Вашего предложения.",
					GetAccountName( playerid ),
					playerid
				);
				
				psend:( id, C_WHITE );
				
				pformat:( ""gbError"Вы отказались от предложения "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( id ),
					id
				);
				
				psend:( playerid, C_WHITE );
				
				g_player_interaction{playerid} = 0;
				g_player_interaction{id} = 0;
				
				SetPVarInt( playerid, "Vehicle:PlayerId", INVALID_PLAYER_ID );
				SetPVarInt( id, "Vehicle:SaleId", INVALID_PLAYER_ID );
				SetPVarInt( id, "Vehicle:Id", INVALID_PARAM );
				SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
				SetPVarInt( playerid, "Vehicle:SellPrice", INVALID_PARAM );
				
				return 1;
			}
			
			if( GetPVarInt( playerid, "Vehicle:SellPrice" ) > Player[playerid][uMoney] )
			{
				g_player_interaction{playerid} = 0;
				g_player_interaction{id} = 0;
				
				SetPVarInt( playerid, "Vehicle:PlayerId", INVALID_PLAYER_ID );
				SetPVarInt( id, "Vehicle:SaleId", INVALID_PLAYER_ID );
				SetPVarInt( id, "Vehicle:Id", INVALID_PARAM );
				SetPVarInt( playerid, "Vehicle:SellPrice", INVALID_PARAM );
				SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
				
				SendClient:( id, C_WHITE, !NO_MONEY_PLAYER );
				return SendClient:( playerid, C_WHITE, !NO_MONEY );
			}
			
			if( GetDistanceBetweenPlayers( playerid, id ) > 3.0 )
			{
				g_player_interaction{playerid} = 0;
				g_player_interaction{id} = 0;
				
				SetPVarInt( playerid, "Vehicle:PlayerId", INVALID_PLAYER_ID );
				SetPVarInt( id, "Vehicle:SaleId", INVALID_PLAYER_ID );
				SetPVarInt( id, "Vehicle:Id", INVALID_PARAM );
				SetPVarInt( playerid, "Vehicle:SellPrice", INVALID_PARAM );
				SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
				
				SendClient:( id, C_WHITE, !""gbError"Покупатель находится слишком далеко от Вас." );
				return SendClient:( playerid, C_WHITE, !""gbError"Владелец транспорта находится слишком далеко от Вас." );
			}
			
			if( IsOwnerVehicleCount( playerid ) >= 1 + Premium[ playerid ][prem_car] )
			{
				g_player_interaction{playerid} = 0;
				g_player_interaction{id} = 0;
				
				SetPVarInt( playerid, "Vehicle:PlayerId", INVALID_PLAYER_ID );
				SetPVarInt( id, "Vehicle:SaleId", INVALID_PLAYER_ID );
				SetPVarInt( id, "Vehicle:Id", INVALID_PARAM );
				SetPVarInt( playerid, "Vehicle:SellPrice", INVALID_PARAM );
				SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
				
				SendClient:( id, C_WHITE, !""gbError"Произошла ошибка при продаже." );
				return SendClient:( playerid, C_WHITE, !""gbError"У Вас уже есть транспортное средство." );
			}
			
			pformat:( ""gbSuccess"Вы продали игроку "cBLUE"%s[%d]"cWHITE" транспорт "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".",
				GetAccountName( playerid ),
				playerid,
				GetVehicleModelName( Vehicle[GetPVarInt( id, "Vehicle:Id" )][vehicle_model] ),
				GetPVarInt( playerid, "Vehicle:SellPrice" )
			);
			
			psend:( id, C_WHITE );
			
			pformat:( ""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" продал Вам транспорт "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".",
				GetAccountName( id ),
				id,
				GetVehicleModelName( Vehicle[GetPVarInt( id, "Vehicle:Id" )][vehicle_model] ),
				GetPVarInt( playerid, "Vehicle:SellPrice" )
			);
			
			psend:( playerid, C_WHITE );
			
			log( LOG_BUY_VEHICLE_FROM_PLAYER, "купил транспорт у", Player[playerid][uID], Player[id][uID], Vehicle[GetPVarInt( id, "Vehicle:Id" )][vehicle_id], GetPVarInt( playerid, "Vehicle:SellPrice" ) );
			
			OfferSalePlayerVehicle( id, playerid, GetPVarInt( id, "Vehicle:Id" ), GetPVarInt( playerid, "Vehicle:SellPrice" ) );
				
			SetPVarInt( id, "Vehicle:PlayerId", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Vehicle:SaleId", INVALID_PLAYER_ID );
			SetPVarInt( playerid, "Vehicle:Id", INVALID_PARAM );
			SetPVarInt( id, "Vehicle:Id", INVALID_PARAM );
			SetPVarInt( playerid, "Vehicle:SellPrice", INVALID_PARAM );
			
			g_player_interaction{playerid} = 0;
			g_player_interaction{id} = 0;
		}
		
		//Покупка авто
		case d_cars + 10:
		{
			if( !response ) return 1;
			
			new
				amount,
				shop = GetPlayerVirtualWorld( playerid ) - 10;
			
			for( new i; i < 48; i++ )
			{
				if( Salon[shop][i][s_model] )
				{
					amount++;
				}
			}
			
			PlayerTextDrawShow( playerid, carshop_info[playerid] );
			PlayerTextDrawShow( playerid, tuning_name[playerid] );
			PlayerTextDrawShow( playerid, tuning_price[playerid] );
					
			for( new i; i < 7; i++ )
			{
				TextDrawShowForPlayer( playerid, carshop[i] );
			}
			
			SelectTextDraw( playerid, 0xd3d3d3FF );
			
			SetPVarInt( playerid, "Salon:Shop", shop );
			SetPVarInt( playerid, "Salon:Show", 1 );
			SetPVarInt( playerid, "Salon:Max", amount );
			
			SetPVarInt( playerid, "Player:World", 15 );
			
			ShowSalonPage( playerid, shop, 0 );
		}
		
		case d_cars + 11:
		{
			if( !response )
			{
				SetPVarInt( playerid, "Salon:Show", 1 );
				SelectTextDraw( playerid, 0xd3d3d3FF );
				return 1;
			}
			
			new
				shop = GetPVarInt( playerid, "Salon:Shop" ),
				page = GetPVarInt( playerid, "Salon:Page" ),
				index = Salon[shop][page][s_model] - 400;
			
			if( Player[playerid][uMoney] < VehicleInfo[index][v_price] )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				SetPVarInt( playerid, "Salon:Show", 1 );
				SelectTextDraw( playerid, 0xd3d3d3FF );
				return 1;
			}
			
			format:g_small_string( ""cBLUE"Цвет %s", VehicleInfo[index][v_name] );
			showPlayerDialog( playerid, d_cars + 12, DIALOG_STYLE_LIST, g_small_string, "\
				Черный\n\
				"cWHITE"Белый\n\
				{2A77A1}Голубой\n\
				{840410}Красный\n\
				{263739}Темно-зеленый", "Выбрать", "Назад" );
		}
		
		case d_cars + 12:
		{
			if( !response )
			{
				SetPVarInt( playerid, "Salon:Show", 1 );
				SelectTextDraw( playerid, 0xd3d3d3FF );
				return 1;
			}
			
			new
				shop = GetPVarInt( playerid, "Salon:Shop" ),
				page = GetPVarInt( playerid, "Salon:Page" ),
				index = Salon[shop][page][s_model] - 400,
				pos = random(3),
				car;
				
			Player[playerid][uMoney] -= VehicleInfo[index][v_price];
			UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );
			
			car = CreateVehicle( Salon[shop][page][s_model], car_buy_pos[shop][pos][0], car_buy_pos[shop][pos][1], car_buy_pos[shop][pos][2], car_buy_pos[shop][pos][3], listitem, listitem, 99999 );
			
			ClearVehicleData( car );
			
			Vehicle[car][vehicle_user_id] = Player[playerid][uID];
			Vehicle[car][vehicle_model] = Salon[shop][page][s_model];
			Vehicle[car][vehicle_member] = 
			Vehicle[car][vehicle_crime] = 0;
			
			Vehicle[car][vehicle_pos][0] = car_buy_pos[shop][pos][0];
			Vehicle[car][vehicle_pos][1] = car_buy_pos[shop][pos][1];
			Vehicle[car][vehicle_pos][2] = car_buy_pos[shop][pos][2];
			Vehicle[car][vehicle_pos][3] = car_buy_pos[shop][pos][3];
			
			Vehicle[car][vehicle_color][0] = listitem;
			Vehicle[car][vehicle_color][1] = listitem;
			Vehicle[car][vehicle_color][2] = 0;
			
			Vehicle[car][vehicle_fuel] = VehicleInfo[index][v_fuel] / 100.0 * 20.0;
			Vehicle[car][vehicle_engine] = 100.0;
			
			Vehicle[car][vehicle_state_window][0] = 
			Vehicle[car][vehicle_state_window][1] =
			Vehicle[car][vehicle_state_window][2] =
			Vehicle[car][vehicle_state_window][3] = 1;
			
			Vehicle[car][vehicle_engine_date] = 
			Vehicle[car][vehicle_date] = gettime();
			
			CreateCar( car );
			SetVehicleParams( car );
			
			SetVehicleNumberPlate( car, "W/O PLATES" );
		
			InsertPlayerVehicle( playerid, car );
			
			PlayerTextDrawHide( playerid, carshop_info[playerid] );
			PlayerTextDrawHide( playerid, tuning_name[playerid] );
			PlayerTextDrawHide( playerid, tuning_price[playerid] );
						
			for( new i; i < 7; i++ )
			{
				TextDrawHideForPlayer( playerid, carshop[i] );
			}
			
			stopPlayer( playerid, 2 );
			setPlayerPos( playerid, PICKUP_SALON );
			SetPlayerVirtualWorld( playerid, GetPVarInt( playerid, "Salon:Shop" ) + 10 );
			SetCameraBehindPlayer( playerid );
			
			DeletePVar( playerid, "Salon:Shop" );
			DeletePVar( playerid, "Salon:Page" );
			DeletePVar( playerid, "Salon:Max" );
			DeletePVar( playerid, "Player:World" );
			
			pformat:( ""gbSuccess"Вы стали владельцем "cBLUE"%s %s"cWHITE". Транспорт находится на парковке.", VehicleInfo[index][v_type], VehicleInfo[index][v_name] );
			psend:( playerid, C_WHITE );
			
			log( LOG_BUY_VEHICLE, "купил транспорт", Player[playerid][uID], car, Vehicle[car][vehicle_model] );
		}
		//Утилизация
		case d_cars + 13:
		{
			if( !response ) return 1;
			
			if( !listitem )
			{
				return ShowPlayerVehicleList( playerid, d_cars + 13 );
			}
			
			SetPVarInt( playerid, "Utilization:Carid", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			new
				model = GetVehicleModel( GetPVarInt( playerid, "Utilization:Carid" ) );
			
			format:g_small_string( "\
				"cBLUE"Утилизация %s\n\n\
				"gbDefault"Гос. стоимость: "cBLUE"$%d"cWHITE"\n\
				"gbDefault"Процент возврата: "cBLUE"$%d"cWHITE"\n\n\
				Желаете продолжить?",
				VehicleInfo[model - 400][v_name],
				VehicleInfo[model - 400][v_price],
				floatround( float( VehicleInfo[model - 400][v_price] ) / 100.0 * ( 60.0 + float( Premium[playerid][prem_house_property] ) ) )
			);
			
			showPlayerDialog( playerid, d_cars + 14, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Далее", "Назад" );
		}
		
		case d_cars + 14:
		{
			if( !response )
			{
				DeletePVar( playerid, "Utilization:Carid" );
				ShowPlayerVehicleList( playerid, d_cars + 13 );
				return 1;
			}
			
			pformat:( ""gbDefault"Подъедьте в указанное место для утилизации "cBLUE"%s"cWHITE".", VehicleInfo[GetVehicleModel( GetPVarInt( playerid, "Utilization:Carid" ) ) - 400][v_name] );
			psend:( playerid, C_WHITE );
			
			SetPlayerRaceCheckpoint( playerid, 2, 1311.0554, 407.4430, 18.5524, 1311.0554, 407.4430, 18.5524, 4.0 );
			
			g_player_gps{playerid} = 1;
		}
		
		case d_cars + 15:
		{
			if( !response ) return 1;
			
			pformat:( ""gbSuccess"Вы отказались от утилизации "cBLUE"%s"cWHITE".", VehicleInfo[GetVehicleModel( GetPVarInt( playerid, "Utilization:Carid" ) ) - 400][v_name] );
			psend:( playerid, C_WHITE );
			
			DisablePlayerRaceCheckpoint( playerid );
			DeletePVar( playerid, "Utilization:Carid" );
			
			g_player_gps{playerid} = 0;
		}
		
		//Дополнительная информация
		case d_cars + 16:
		{
			ShowVehicleInformation( playerid, GetPVarInt( playerid, "Vehicle:Id" ), d_cars + 2, "Подробнее", "Назад" );
		}
		
		//Диалог бензоколонки
		case d_cars + 17:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Gas:ID" ); 
				return 1;
			}
			
			if( !IsPlayerInAnyVehicle( playerid ) || GetPlayerState( playerid ) != PLAYER_STATE_DRIVER )
				return 1;
				
			if( IsVelo( GetPlayerVehicleID( playerid  ) ) )
				return 1;
			
			new
				vehicleid = GetPlayerVehicleID( playerid ),
				model = GetVehicleModel( vehicleid ),
				gas_station = GetPVarInt( playerid, "Gas:ID" ),
				price = PRICE_FOR_LITER;
				
			if( gas_station_pos[gas_station][gas_frac] && Vehicle[vehicleid][vehicle_member] )
			{
				price -= 5;
			}
				
			if( !IsNumeric( inputtext ) || inputtext[0] == EOS || strval( inputtext ) < 1 )
			{
				format:g_small_string( "\
					"cBLUE"Заправочная станция\n\n\
					"cWHITE"Транспорт: "cGRAY"%s\n\
					"cWHITE"Топливный бак: "cGRAY"%0.2f/%0.2f"cWHITE" л.\n\
					За литр: "cGRAY"$%d\n\n\
					"cWHITE"Укажите количество литров для заправки:\n\
					"gbDialogError"Неправильный формат ввода.",
					GetVehicleModelName( model ),
					Vehicle[vehicleid][vehicle_fuel], VehicleInfo[ model - 400 ][v_fuel], 
					price );
				return showPlayerDialog( playerid, d_cars + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Заправка", "Закрыть" );
			}
			
			if( float( strval( inputtext ) ) + Vehicle[vehicleid][vehicle_fuel] > VehicleInfo[ model - 400 ][v_fuel] )
			{
				format:g_small_string( "\
					"cBLUE"Заправочная станция\n\n\
					"cWHITE"Транспорт: "cGRAY"%s\n\
					"cWHITE"Топливный бак: "cGRAY"%0.2f/%0.2f"cWHITE" л.\n\
					За литр: "cGRAY"$%d\n\n\
					"cWHITE"Укажите количество литров для заправки:\n\
					"gbDialogError"Топливый бак не может вместить такое количество.",
					GetVehicleModelName( model ),
					Vehicle[vehicleid][vehicle_fuel], VehicleInfo[ model - 400 ][v_fuel], 
					price );
				return showPlayerDialog( playerid, d_cars + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Заправка", "Закрыть" );
			}
			
			if( strval( inputtext ) * price > Player[playerid][uMoney] )
			{
				format:g_small_string( "\
					"cBLUE"Заправочная станция\n\n\
					"cWHITE"Транспорт: "cGRAY"%s\n\
					"cWHITE"Топливный бак: "cGRAY"%0.2f/%0.2f"cWHITE" л.\n\
					За литр: "cGRAY"$%d\n\n\
					"cWHITE"Укажите количество литров для заправки:\n\
					"gbDialogError"Недостаточно наличных денег.",
					GetVehicleModelName( model ),
					Vehicle[vehicleid][vehicle_fuel], VehicleInfo[ model - 400 ][v_fuel], 
					price );
				return showPlayerDialog( playerid, d_cars + 17, DIALOG_STYLE_INPUT, " ", g_small_string, "Заправка", "Закрыть" );
			}
			
			if( GetVehicleDistanceFromPoint( vehicleid, gas_station_pos[gas_station][gas_pos][0], gas_station_pos[gas_station][gas_pos][1], gas_station_pos[gas_station][gas_pos][2] ) > 5.0 )
			{
				return SendClient:( playerid, C_WHITE, !""gbError"Транспорт должен находится рядом с бензоколонкой." );
			}
			
			Vehicle[vehicleid][vehicle_fuel] += float( strval( inputtext ) );
			SetPlayerCash( playerid, "-", strval( inputtext ) * price );
			DeletePVar( playerid, "Gas:ID" );
			
			if( Vehicle[vehicleid][vehicle_id] )
				UpdateVehicleFloat( vehicleid, "vehicle_fuel", Vehicle[vehicleid][vehicle_fuel] );
			
			pformat:( ""gbSuccess"Вы заправили "cBLUE"%s"cWHITE" на "cBLUE"%d"cWHITE" л. за $%d.", GetVehicleModelName( model ), strval( inputtext ), strval( inputtext ) * price );
			psend:( playerid, C_WHITE );
		}
	}
	
	return 1;
}