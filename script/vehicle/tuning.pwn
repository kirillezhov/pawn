function Tuning_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED( KEY_CROUCH ) && IsPlayerInAnyVehicle( playerid ) && !GetPlayerVehicleSeat( playerid ) )
	{
		for( new i; i < sizeof TuningPosition; i++ )
		{
			if( !IsPlayerInRangeOfPoint( playerid, 1.5, TuningPosition[i][0], TuningPosition[i][1], TuningPosition[i][2] ) ) continue;

			new
				vid = GetPlayerVehicleID( playerid );
		
			if( IsVelo( vid ) )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Недоступно для этого транспорта." );
				return 1;
			}
			
			g_player_interaction{playerid} = 1;
		
			if( Job[playerid][j_vehicleid] != vid )
				showVehicleHud( playerid, false );
			
			SetPVarInt( playerid, "Tune:Carid", vid );
			SetPVarInt( playerid, "Tune:Position", i );
		
			showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
				"cBLUE"1. "cWHITE"Покрасочные работы\n\
				"cBLUE"2. "cWHITE"Тюнинг\n\
				"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
					
			break;
		}
	}

	return 1;
}

function Tune_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	switch( dialogid )
	{
		case d_tune:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Tune:Carid" );
				DeletePVar( playerid, "Tune:Position" );
			
				g_player_interaction{playerid} = 0;
				showVehicleHud( playerid, true );
				return 1;
			}
			
			new
				vid = GetPVarInt( playerid, "Tune:Carid" );
			
			switch( listitem )
			{
				case 0:
				{
					if( Vehicle[vid][vehicle_user_id] == INVALID_PARAM )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Недоступно для этого транспорта." );
						return showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
							"cBLUE"1. "cWHITE"Покрасочные работы\n\
							"cBLUE"2. "cWHITE"Тюнинг\n\
							"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
					}
				
					format:g_small_string( ""cBLUE"Покраска %s", GetVehicleModelName( GetVehicleModel( vid ) ) );
					showPlayerDialog( playerid, d_tune + 4, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
						Слой 1\n\
						Слой 2\n\
						Аэрография", "Выбрать", "Назад" );
				}
				
				case 1:
				{
					if( Vehicle[vid][vehicle_user_id] == INVALID_PARAM )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Недоступно для этого транспорта." );
						return showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
							"cBLUE"1. "cWHITE"Покрасочные работы\n\
							"cBLUE"2. "cWHITE"Тюнинг\n\
							"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
					}
				
					if( !VehicleInfo[ GetVehicleModel(vid) - 400 ][v_tune] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете модернизировать этот транспорт." );
							
						return showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
							"cBLUE"1. "cWHITE"Покрасочные работы\n\
							"cBLUE"2. "cWHITE"Тюнинг\n\
							"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
					}
				
					CheckVehicleDamageStatus( vid );
					
					for( new i; i < 4; i++ )
					{
						if( Vehicle[vid][vehicle_damage][i] )
						{
							SendClient:( playerid, C_WHITE, ""gbError"Вы не можете модернизировать поврежденный транспорт." );
							
							showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
								"cBLUE"1. "cWHITE"Покрасочные работы\n\
								"cBLUE"2. "cWHITE"Тюнинг\n\
								"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
							return 1;
						}
					}
				
					format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( GetVehicleModel( vid ) ) );
					showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
				}
				
				case 2:
				{
					if( VehicleInfo[GetVehicleModel( vid ) - 400][v_repair] == INVALID_PARAM )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете отремонтировать этот транспорт." );
					
						return showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
							"cBLUE"1. "cWHITE"Покрасочные работы\n\
							"cBLUE"2. "cWHITE"Тюнинг\n\
							"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
					}
					
					if( VehicleInfo[GetVehicleModel( vid ) - 400][v_repair] == 2 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Чтобы произвести комплексный ремонт, обратитесь к механику." );
					
						return showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
							"cBLUE"1. "cWHITE"Покрасочные работы\n\
							"cBLUE"2. "cWHITE"Тюнинг\n\
							"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
					}
				
					format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( GetVehicleModel( vid ) ) );
					showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
						Двигатель\n\
						Кузов\n\
						Фары\n\
						Покрышки",
					"Выбрать", "Назад" );
				}
			}
		}
		
		case d_tune + 1:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
					"cBLUE"1. "cWHITE"Покрасочные работы\n\
					"cBLUE"2. "cWHITE"Тюнинг\n\
					"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
			}
			
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				model = GetVehicleModel( carid ),
				amount,
				count,
				get_price,
				price;
			
			if( GetVehicleDistanceFromPoint( carid, TuningPosition[GetPVarInt( playerid, "Tune:Position" )][0], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][1], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][2] ) > 5.0 )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Ваш транспорт находится далеко от подъемника." );
			
				format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( model ) );
				return showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
			}
			
			switch( listitem )
			{
				case 0 .. 10:
				{
					for( new i; i < 29; i++ )
					{
						if( ComponentsInfo[listitem][i][c_id] )
						{
							amount++;
							
							if( IsVehicleUpgradeCompatible( model, ComponentsInfo[listitem][i][c_id] ) ) 
							{
								count++;
							}
						}
					}
					
					if( !count )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Нет элементов, доступных для установки на этот автомобиль." );
					
						format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
					}
					
					SetPVarInt( playerid, "Tune:Max", amount );
					SetPVarInt( playerid, "Tune:Type", listitem );
					SetPVarInt( playerid, "Tune:Page", INVALID_PARAM );
					SetPVarInt( playerid, "Tune:Show", 1 );

					ShowMenuTuning( playerid, true );
					SelectTextDraw( playerid, 0xd3d3d3FF );
					
					PreviewTuning( playerid, carid, listitem, INVALID_PARAM );
				}
				
				case 11:
				{
					if( !IsVehicleUpgradeCompatible( model, 1087 ) )
					{
						showVehicleHud( playerid, true );
						return SendClient:( playerid, C_GRAY, ""gbError"Вы не можете установить пневматическую подвеску на этот автомобиль." );
					}
						
					if( !Vehicle[carid][vehicle_tuning][11] )
					{
						get_price = floatround( float( GetVehiclePrice( model ) ) * PRICE_HYDRAULICS / 100 ),
						price = get_price - ( get_price * Premium[playerid][prem_drop_tuning] / 100 );
						
						if( Player[playerid][uMoney] < price )
						{
							SendClient:( playerid, C_GRAY, !NO_MONEY );
							
							format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( model ) );
							return showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
						}
						
						format:g_small_string( "\
						"cBLUE"Тюнинг\n\n\
						"cWHITE"Вы действительно желаете установить "cBLUE"пневматическую подвеску"cWHITE" на "cBLUE"%s"cWHITE"?\n\n\
						"gbDialog"Стоимость установки "cBLUE"$%d"cGRAY".", GetVehicleModelName( model ), price );
					}
					else
					{
						format:g_small_string( "\
						"cBLUE"Тюнинг\n\n\
						"cWHITE"Вы действительно желаете демонтировать "cBLUE"пневматическую подвеску"cWHITE" на "cBLUE"%s"cWHITE"?", GetVehicleModelName( model ) );
					}
					showPlayerDialog( playerid, d_tune + 2, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
				}
			}
		
		}
		
		//Гидравлика
		case d_tune + 2:
		{
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				model = GetVehicleModel( carid ),
				get_price,
				price;
		
			if( !response )
			{
				format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( model ) );
				showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
				return 1;
			}
				
			if( !Vehicle[carid][vehicle_tuning][11] )
			{
				get_price = floatround( float( GetVehiclePrice( model ) ) / 100 * PRICE_HYDRAULICS ),
				price = get_price - ( get_price * Premium[playerid][prem_drop_tuning] / 100 );
						
				if( Player[playerid][uMoney] < price )
				{
					SendClient:( playerid, C_GRAY, !NO_MONEY );
					
					format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( model ) );
					return showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
				}
			
				pformat:( ""gbSuccess"Пневматическая подвеска успешно установлена на "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", GetVehicleModelName( model ), price );
				
				SetPlayerCash( playerid, "-", price );
			
				Vehicle[carid][vehicle_tuning][11] = 1087;
				AddVehicleComponent( carid, 1087 );
				
				PlayerPlaySound( playerid, 1133, 0, 0, 0 );
			}
			else
			{
				pformat:( ""gbSuccess"Пневматическая подвеска успешно демонтирована на "cBLUE"%s"cWHITE".", GetVehicleModelName( model ) );
			
				Vehicle[carid][vehicle_tuning][11] = 0;
				RemoveVehicleComponent( carid, 1087 );
			}
			psend:( playerid, C_WHITE );
			
			if( Vehicle[carid][vehicle_user_id] ) UpdateTuning( carid );
			
			format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( model ) );
			showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
		}
		
		case d_tune + 3:
		{
			if( !response )
			{
				SetPVarInt( playerid, "Tune:Show", 1 );
				SelectTextDraw( playerid, 0xd3d3d3FF );
				return 1;
			}
			
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				model = GetVehicleModel( carid ),
				type = GetPVarInt( playerid, "Tune:Type" ),
				page = GetPVarInt( playerid, "Tune:Page" ),
				price = GetPVarInt( playerid, "Tune:Price" );
				
			if( page == INVALID_PARAM )
			{	
				RemoveVehicleComponent( carid, Vehicle[carid][vehicle_tuning][type] );
				Vehicle[carid][vehicle_tuning][type] = 0;
				
				pformat:( ""gbSuccess"Вы успешно установили "cBLUE"сток деталь"cWHITE" на "cBLUE"%s"cWHITE".", GetVehicleModelName( model ) );
				psend:( playerid, C_WHITE );
			}
			else
			{
				if( Player[playerid][uMoney] < price )
				{
					DeletePVar( playerid, "Tune:Price" );
				
					SetPVarInt( playerid, "Tune:Show", 1 );
					SelectTextDraw( playerid, 0xd3d3d3FF );
					
					SendClient:( playerid, C_WHITE, !NO_MONEY );
					return 1;
				}
				
				Vehicle[carid][vehicle_tuning][type] = ComponentsInfo[type][page][c_id];
				
				Player[playerid][uMoney] -= price;
				UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );
				
				pformat:( ""gbSuccess"Вы успешно установили "cBLUE"%s"cWHITE" на "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", 
					ComponentsInfo[type][page][c_name],
					GetVehicleModelName( model ),
					price );
				psend:( playerid, C_WHITE );
				
				PlayerPlaySound( playerid, 1133, 0, 0, 0 );
			}
				
			if( Vehicle[carid][vehicle_user_id] ) UpdateTuning( carid );	
			ShowMenuTuning( playerid, false );
			
			DeletePVar( playerid, "Tune:Type" );
			DeletePVar( playerid, "Tune:Page" );
			DeletePVar( playerid, "Tune:Price" );
			
			g_tuning_select[playerid] = 0;
				
			format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( model ) );
			showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
		}
		//Покраска
		case d_tune + 4:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
					"cBLUE"1. "cWHITE"Покрасочные работы\n\
					"cBLUE"2. "cWHITE"Тюнинг\n\
					"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
			}
			
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				price;
			
			if( GetVehicleDistanceFromPoint( carid, TuningPosition[GetPVarInt( playerid, "Tune:Position" )][0], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][1], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][2] ) > 5.0 )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Ваш транспорт находится далеко от подъемника." );
						
				format:g_small_string( ""cBLUE"Покраска %s", GetVehicleModelName( GetVehicleModel( carid ) ) );
				return showPlayerDialog( playerid, d_tune + 4, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Слой 1\n\
					Слой 2\n\
					Аэрография", "Выбрать", "Назад" );
			}
			
			switch( listitem )
			{
				case 0,1:
				{
					format:g_small_string( "\
						"cBLUE"Покраска слоя %d\n\n\
						"cWHITE"Укажите номер цветовой гаммы:\n\n\
						"gbDialog"Диапазон цветов от 0 до 255.\n\
						%s", listitem + 1 );
						
					SetPVarInt( playerid, "Tune:Color", listitem + 1 );
					showPlayerDialog( playerid, d_tune + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
				}
				
				case 2:
				{
					if( !IsVehiclePaintjobCompatible( GetVehicleModel( carid ) ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Покраска этого автомобиля аэрографом невозможна." );
						
						format:g_small_string( ""cBLUE"Покраска %s", GetVehicleModelName( GetVehicleModel( carid ) ) );
						return showPlayerDialog( playerid, d_tune + 4, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Слой 1\n\
							Слой 2\n\
							Аэрография", "Выбрать", "Назад" );
					}
					
					price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_AERO );
					
					PlayerTextDrawSetString( playerid, tuning_name[playerid], "Аэрография" );
					format:g_small_string( "$%d", price );
					PlayerTextDrawSetString( playerid, tuning_price[playerid], g_small_string );
					
					PlayerTextDrawShow( playerid, tuning_name[playerid] );
					PlayerTextDrawShow( playerid, tuning_price[playerid] );
					
					for( new i; i < 9; i++ )
					{
						if( i == 2 || i == 3 ) continue;
						TextDrawShowForPlayer( playerid, car_tuning[i] );
					}
					
					ChangeVehicleColor( carid, 1, 1 );
					ChangeVehiclePaintjob( carid, 0 );
					
					SelectTextDraw( playerid, 0xd3d3d3FF );
					SetPVarInt( playerid, "Tune:ShowAero", 1 );
					SetPVarInt( playerid, "Tune:PageAero", 0 );
				}
			}
		}
		
		case d_tune + 5:
		{
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				price;
		
			if( !response )
			{
				format:g_small_string( ""cBLUE"Покраска %s", GetVehicleModelName( GetVehicleModel( carid ) ) );
				return showPlayerDialog( playerid, d_tune + 4, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Слой 1\n\
					Слой 2\n\
					Аэрография", "Выбрать", "Назад" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 || strval( inputtext ) > 255 )
			{
				format:g_small_string( "\
					"cBLUE"Покраска слоя %d на "cBLUE"%s\n\n\
					"cWHITE"Укажите номер цветовой гаммы:\n\n\
					"gbDialog"Диапазон цветов от 0 до 255.\n\
					"gbDialogError"Неправильный формат, повторите ввод.", 
					GetPVarInt( playerid, "Tune:Color" ),
					GetVehicleModelName( GetVehicleModel( carid ) ) );
				return showPlayerDialog( playerid, d_tune + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			}
			
			if( GetVehicleDistanceFromPoint( carid, TuningPosition[GetPVarInt( playerid, "Tune:Position" )][0], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][1], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][2] ) > 5.0 )
			{
				SendClient:( playerid, C_WHITE, !""gbError"Ваш транспорт находится далеко от подъемника." );
			
				format:g_small_string( ""cBLUE"Покраска %s", GetVehicleModelName( GetVehicleModel( carid ) ) );
				return showPlayerDialog( playerid, d_tune + 4, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Слой 1\n\
					Слой 2\n\
					Аэрография", "Выбрать", "Назад" );
			}
			
			if( Vehicle[carid][vehicle_color][2] )
			{
				ChangeVehiclePaintjob( carid, 3 );
			}
			
			switch( GetPVarInt( playerid, "Tune:Color" ) )
			{
				case 1:
				{
					price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_COLOR_1 );
				
					ChangeVehicleColor( carid, strval( inputtext ), Vehicle[carid][vehicle_color][1] );
				}
				case 2:
				{
					price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_COLOR_2 );
				
					ChangeVehicleColor( carid, Vehicle[carid][vehicle_color][0], strval( inputtext ) );
				}
			}
			
			SetPVarInt( playerid, "Tune:ColorNumber", strval( inputtext ) );
			
			format:g_small_string( "Покраска слоя %d", GetPVarInt( playerid, "Tune:Color" ) );
			PlayerTextDrawSetString( playerid, tuning_name[playerid], g_small_string );
			format:g_small_string( "$%d", price );
			PlayerTextDrawSetString( playerid, tuning_price[playerid], g_small_string );
			
			PlayerTextDrawShow( playerid, tuning_name[playerid] );
			PlayerTextDrawShow( playerid, tuning_price[playerid] );
					
			for( new i = 4; i < 9; i++ )
			{
				TextDrawShowForPlayer( playerid, car_tuning[i] );
			}
			
			SelectTextDraw( playerid, 0xd3d3d3FF );
			SetPVarInt( playerid, "Tune:ShowColor", 1 );
		}
		
		case d_tune + 6:
		{
			if( !response )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Tune:ShowColor", 1 );
				return 1;
			}
			
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				price;
			
			switch( GetPVarInt( playerid, "Tune:Color" ) )
			{
				case 1: price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_COLOR_1 ); 
				case 2: price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_COLOR_2 );
			}
			
			if( Player[playerid][uMoney] < price )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Tune:ShowColor", 1 );
				
				return SendClient:( playerid, C_WHITE, !NO_MONEY );
			}
			
			Player[playerid][uMoney] -= price;
			UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );
			
			Vehicle[carid][vehicle_color][GetPVarInt( playerid, "Tune:Color" ) - 1] = GetPVarInt( playerid, "Tune:ColorNumber" );
			Vehicle[carid][vehicle_color][2] = 0;
			UpdateColorCar( carid );
			
			PlayerTextDrawHide( playerid, tuning_name[playerid] );
			PlayerTextDrawHide( playerid, tuning_price[playerid] );
					
			for( new i = 4; i < 9; i++ )
			{
				TextDrawHideForPlayer( playerid, car_tuning[i] );
			}
			
			DeletePVar( playerid, "Tune:Color" );
			DeletePVar( playerid, "Tune:ColorNumber" );
			
			pformat:( ""gbSuccess"Вы успешно перекрасили "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", GetVehicleModelName( GetVehicleModel( carid ) ), price );
			psend:( playerid, C_WHITE );
			
			PlayerPlaySound( playerid, 1134, 0, 0, 0 );
			
			format:g_small_string( ""cBLUE"Покраска %s", GetVehicleModelName( GetVehicleModel( carid ) ) );
			showPlayerDialog( playerid, d_tune + 4, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
				Слой 1\n\
				Слой 2\n\
				Аэрография", "Выбрать", "Назад" );
		}
		
		case d_tune + 7:
		{
			if( !response )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Tune:ShowAero", 1 );
				return 1;
			}
			
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_AERO ); 
			
			if( Player[playerid][uMoney] < price )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Tune:ShowAero", 1 );
				
				return SendClient:( playerid, C_WHITE, !NO_MONEY );
			}
				
			PlayerTextDrawHide( playerid, tuning_name[playerid] );
			PlayerTextDrawHide( playerid, tuning_price[playerid] );
							
			for( new i; i < 9; i++ )
			{
				if( i == 2 || i == 3 ) continue;
				TextDrawHideForPlayer( playerid, car_tuning[i] );
			}
			
			Player[playerid][uMoney] -= price;
			UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );
			
			Vehicle[carid][vehicle_color][2] = GetPVarInt( playerid, "Tune:PageAero" ) + 1;
			Vehicle[carid][vehicle_color][1] = 1;
			Vehicle[carid][vehicle_color][0] = 1;
			UpdateColorCar( carid );
			
			DeletePVar( playerid, "Tune:PageAero" );
			
			pformat:( ""gbSuccess"Аэрография успешно нанесена на "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", GetVehicleModelName( GetVehicleModel( carid ) ), price );
			psend:( playerid, C_WHITE );
			
			PlayerPlaySound( playerid, 1134, 0, 0, 0 );
			
			format:g_small_string( ""cBLUE"Покраска %s", GetVehicleModelName( GetVehicleModel( carid ) ) );
			showPlayerDialog( playerid, d_tune + 4, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
				Слой 1\n\
				Слой 2\n\
				Аэрография", "Выбрать", "Назад" );
		}
		
		//Ремонт
		case d_tune + 8:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_tune, DIALOG_STYLE_LIST, "Станция технического обслуживания", "\
					"cBLUE"1. "cWHITE"Покрасочные работы\n\
					"cBLUE"2. "cWHITE"Тюнинг\n\
					"cBLUE"3. "cWHITE"Ремонт", "Выбрать", "Закрыть" );
			}
			
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				model = GetVehicleModel( carid ),
				price, get_price;
				
			CheckVehicleDamageStatus( carid );
				
			switch( listitem )
			{
				case 0:
				{
					if( VehicleInfo[model - 400][v_repair] > 0 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете произвести капитальный ремонт двигателя на этом транспорте." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
					
					if( Vehicle[carid][vehicle_engine] >= 90.0 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Двигатель находится в хорошем состоянии." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
				
					get_price = floatround( floatround ( float( GetVehiclePrice( model ) ) / 100 * REPAIR_ENGINE ) );
					price = get_price - ( get_price * Premium[playerid][prem_drop_repair] / 100 );
					
					format:g_small_string( "\
						"cBLUE"Ремонт %s\n\n\
						"cWHITE"Вы желаете произвести капитальный ремонт двигателя за "cBLUE"$%d"cWHITE"?",
						GetVehicleModelName( model ),
						price );
				}
				
				case 1:
				{
					if( VehicleInfo[model - 400][v_repair] > 0 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете отремонтировать кузов на этом транспорте." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
				
					if( !Vehicle[carid][vehicle_damage][0] && !Vehicle[carid][vehicle_damage][1] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Кузов этого транспорта не поврежден." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
				
					if( Vehicle[carid][vehicle_damage][2] )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Прежде чем ремонтировать кузов, замените фары." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
				
					get_price = floatround( floatround ( float( GetVehiclePrice( model ) ) / 100 * REPAIR_BODY ) );
					price = get_price - ( get_price * Premium[playerid][prem_drop_repair] / 100 );
					
					format:g_small_string( "\
						"cBLUE"Ремонт %s\n\n\
						"cWHITE"Вы желаете произвести ремонт кузова за "cBLUE"$%d"cWHITE"?",
						GetVehicleModelName( model ),
						price );
				}
				
				case 2:
				{
					if( VehicleInfo[model - 400][v_repair] >= 1 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете заменить фары на этом транспорте." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
				
					if( !Vehicle[carid][vehicle_damage][2] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Фары этого транспорта не повреждены." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
				
					get_price = floatround( floatround ( float( GetVehiclePrice( model ) ) / 100 * REPAIR_LIGHT ) );
					price = get_price - ( get_price * Premium[playerid][prem_drop_repair] / 100 );
					
					format:g_small_string( "\
						"cBLUE"Ремонт %s\n\n\
						"cWHITE"Вы желаете заменить фары за "cBLUE"$%d"cWHITE"?",
						GetVehicleModelName( model ),
						price );
				}
				
				case 3:
				{
					if( VehicleInfo[model - 400][v_repair] == 2 )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Вы не можете заменить покрышки на этом транспорте." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
					
					if( !Vehicle[carid][vehicle_damage][3] )
					{
						SendClient:( playerid, C_WHITE, !""gbError"Покрышки этого транспорта не повреждены." );
					
						format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( model ) );
						return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
							Двигатель\n\
							Кузов\n\
							Фары\n\
							Покрышки",
						"Выбрать", "Назад" );
					}
				
					get_price = floatround( floatround ( float( GetVehiclePrice( model ) ) / 100 * REPAIR_WHEELS ) );
					price = get_price - ( get_price * Premium[playerid][prem_drop_repair] / 100 );
					
					format:g_small_string( "\
						"cBLUE"Ремонт %s\n\n\
						"cWHITE"Вы желаете заменить покрышки за "cBLUE"$%d"cWHITE"?",
						GetVehicleModelName( model ),
						price );
				}
			}
			
			SetPVarInt( playerid, "Tune:RepairPart", listitem );
			SetPVarInt( playerid, "Tune:RepairPrice", get_price );
			
			showPlayerDialog( playerid, d_tune + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			
		}
		
		case d_tune + 9:
		{
			new
				vid = GetPVarInt( playerid, "Tune:Carid" ),
				part,
				price, get_price;
		
			if( !response )
			{
				DeletePVar( playerid, "Tune:RepairPart" );
				DeletePVar( playerid, "Tune:RepairPrice" );
			
				format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( GetVehicleModel( vid ) ) );
				showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Двигатель\n\
					Кузов\n\
					Фары\n\
					Покрышки",
				"Выбрать", "Назад" );
				return 1;
			}
			
			part = GetPVarInt( playerid, "Tune:RepairPart" );
			get_price = GetPVarInt( playerid, "Tune:RepairPrice" );
			price = get_price - ( get_price * Premium[playerid][prem_drop_repair] / 100 );
			
			if( Player[playerid][uMoney] < price )
			{
				DeletePVar( playerid, "Tune:RepairPart" );
				DeletePVar( playerid, "Tune:RepairPrice" );
			
				SendClient:( playerid, C_WHITE, !NO_MONEY );
					
				format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( GetVehicleModel( vid ) ) );
				return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Двигатель\n\
					Кузов\n\
					Фары\n\
					Покрышки",
				"Выбрать", "Назад" );
			}
			
			if( GetVehicleDistanceFromPoint( vid, TuningPosition[GetPVarInt( playerid, "Tune:Position" )][0], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][1], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][2] ) > 5.0 )
			{
				DeletePVar( playerid, "Tune:RepairPart" );
				DeletePVar( playerid, "Tune:RepairPrice" );
			
				SendClient:( playerid, C_WHITE, !""gbError"Ваш транспорт находится далеко от подъемника." );
			
				format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( GetVehicleModel( vid ) ) );
				return showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
					Двигатель\n\
					Кузов\n\
					Фары\n\
					Покрышки",
				"Выбрать", "Назад" );
			}
			
			CheckVehicleDamageStatus( vid );
			
			switch( part )
			{
				case 0:
				{
					pformat:( ""gbSuccess"Вы произвели капитальный ремонт двигателя на "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", GetVehicleModelName( GetVehicleModel( vid ) ), price );
				
					Vehicle[vid][vehicle_engine] = 100.0;
					Vehicle[vid][vehicle_engine_date] = gettime();
					UpdateVehicle( vid, "vehicle_engine_date", Vehicle[vid][vehicle_engine_date] );
				}
				
				case 1:
				{
					pformat:( ""gbSuccess"Вы отремонтировали кузов на "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", GetVehicleModelName( GetVehicleModel( vid ) ), price );
				
					Vehicle[vid][vehicle_damage][0] = 0;
					Vehicle[vid][vehicle_damage][1] = 0;
				}
				
				case 2:
				{
					pformat:( ""gbSuccess"Вы заменили фары на "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", GetVehicleModelName( GetVehicleModel( vid ) ), price );
				
					Vehicle[vid][vehicle_damage][2] = 0;
				}
				
				case 3:
				{
					pformat:( ""gbSuccess"Вы заменили покрышки на "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE".", GetVehicleModelName( GetVehicleModel( vid ) ), price );
					
					Vehicle[vid][vehicle_damage][3] = 0;
				}
			}
			psend:( playerid, C_WHITE );
			
			SetVehicleDamageStatus( vid );
			setVehicleHealthEx( vid );
			
			Player[playerid][uMoney] -= price;
			UpdatePlayer( playerid, "uMoney", Player[playerid][uMoney] );
			
			DeletePVar( playerid, "Tune:RepairPart" );
			DeletePVar( playerid, "Tune:RepairPrice" );
			
			format:g_small_string( ""cBLUE"Ремонт %s", GetVehicleModelName( GetVehicleModel( vid ) ) );
			showPlayerDialog( playerid, d_tune + 8, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
				Двигатель\n\
				Кузов\n\
				Фары\n\
				Покрышки",
			"Выбрать", "Назад" );
		}
	}
	return 1;
}

Tuning_OnPlayerClickTextDraw( playerid, Text:clickedid ) 
{
	//clean_array();
	
	if( _:clickedid == INVALID_TEXT_DRAW  ) 
	{
		if( GetPVarInt( playerid, "Tune:Show" ) )
		{
			new
				carid = GetPVarInt( playerid, "Tune:Carid" ),
				model = GetVehicleModel( carid ),
				type = GetPVarInt( playerid, "Tune:Type" );
			
			ShowMenuTuning( playerid, false );
			
			if( Vehicle[carid][vehicle_tuning][type] )
			{
				AddVehicleComponent( carid, Vehicle[carid][vehicle_tuning][type] );
			}
			else if( !Vehicle[carid][vehicle_tuning][type] && g_tuning_select[playerid] )
			{
				RemoveVehicleComponent( carid, g_tuning_select[playerid] );
				g_tuning_select[playerid] = 0;
			}
			
			DeletePVar( playerid, "Tune:Type" );
			DeletePVar( playerid, "Tune:Page" );
			DeletePVar( playerid, "Tune:Price" );
			DeletePVar( playerid, "Tune:Show" );
			
			g_tuning_select[playerid] = 0;
				
			format:g_small_string( ""cBLUE"Тюнинг %s", GetVehicleModelName( model ) );
			showPlayerDialog( playerid, d_tune + 1, DIALOG_STYLE_LIST, g_small_string, tune_dialog, "Выбрать", "Назад" );
			return 1;
		}
	
		if( GetPVarInt( playerid, "Tune:ShowColor" ) )
		{
			new
				carid = GetPVarInt( playerid, "Tune:Carid" );
				
			PlayerTextDrawHide( playerid, tuning_name[playerid] );
			PlayerTextDrawHide( playerid, tuning_price[playerid] );
					
			for( new i = 4; i < 9; i++ )
			{
				TextDrawHideForPlayer( playerid, car_tuning[i] );
			}
			
			DeletePVar( playerid, "Tune:ShowColor" );
			DeletePVar( playerid, "Tune:ColorNumber" );
			
			CancelSelectTextDraw( playerid );
			ChangeVehicleColor( carid, Vehicle[carid][vehicle_color][0], Vehicle[carid][vehicle_color][1] );
			
			if( Vehicle[carid][vehicle_color][2] )
			{
				ChangeVehiclePaintjob( carid, Vehicle[carid][vehicle_color][2] - 1 );
			}
			
			format:g_small_string( "\
				"cBLUE"Покраска слоя %d\n\n\
				"cWHITE"Укажите номер цветовой гаммы:\n\n\
				"gbDialog"Диапазон цветов от 0 до 255.", GetPVarInt( playerid, "Tune:Color" ) );
						
			showPlayerDialog( playerid, d_tune + 5, DIALOG_STYLE_INPUT, " ", g_small_string, "Далее", "Назад" );
			return 1;
		}
		
		if( GetPVarInt( playerid, "Tune:ShowAero" ) )
		{
			DeletePVar( playerid, "Tune:ShowAero" );
			DeletePVar( playerid, "Tune:PageAero" );
			
			PlayerTextDrawHide( playerid, tuning_name[playerid] );
			PlayerTextDrawHide( playerid, tuning_price[playerid] );
							
			for( new i; i < 9; i++ )
			{
				if( i == 2 || i == 3 ) continue;
				TextDrawHideForPlayer( playerid, car_tuning[i] );
			}
			
			new
				carid = GetPVarInt( playerid, "Tune:Carid" );
			
			if( Vehicle[carid][vehicle_color][2] )
			{
				ChangeVehiclePaintjob( carid, Vehicle[carid][vehicle_color][2] - 1 );
			}
			else
			{
				ChangeVehiclePaintjob( carid, 3 );
				ChangeVehicleColor( carid, Vehicle[carid][vehicle_color][0], Vehicle[carid][vehicle_color][1] );
			}
			
			format:g_small_string( ""cBLUE"Покраска %s", GetVehicleModelName( GetVehicleModel( carid ) ) );
			showPlayerDialog( playerid, d_tune + 4, DIALOG_STYLE_LIST, g_small_string, ""cWHITE"\
				Слой 1\n\
				Слой 2\n\
				Аэрография", "Выбрать", "Назад" );
			return 1;
		}
	}
	else if( clickedid == car_tuning[0] ) //Стрелка влево
	{
		new
			carid = GetPVarInt( playerid, "Tune:Carid" );
	
		if( GetVehicleDistanceFromPoint( carid, TuningPosition[GetPVarInt( playerid, "Tune:Position" )][0], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][1], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][2] ) > 5.0 )
		{
			return SendClient:( playerid, C_WHITE, ""gbError"Ваш транспорт находится далеко от подъемника." );
		}
	
		if( GetPVarInt( playerid, "Tune:ShowAero" ) )
		{
			if( !GetPVarInt( playerid, "Tune:PageAero" ) )
				return 1;
				
			GivePVarInt( playerid, "Tune:PageAero", -1 );
			ChangeVehiclePaintjob( carid, GetPVarInt( playerid, "Tune:PageAero" ) );
			
			return 1;
		}
	
		if( GetPVarInt( playerid, "Tune:Page" ) == INVALID_PARAM )
			return 1;
			
		PreviewTuning( playerid, carid, GetPVarInt( playerid, "Tune:Type" ), GetPVarInt( playerid, "Tune:Page" ) - 1 );
		return 1;
	}
	else if( clickedid == car_tuning[1] ) //Стрелка вправо
	{
		new
			carid = GetPVarInt( playerid, "Tune:Carid" );
	
		if( GetVehicleDistanceFromPoint( carid, TuningPosition[GetPVarInt( playerid, "Tune:Position" )][0], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][1], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][2] ) > 5.0 )
		{
			return SendClient:( playerid, C_WHITE, ""gbError"Ваш транспорт находится далеко от подъемника." );
		}
	
		if( GetPVarInt( playerid, "Tune:ShowAero" ) )
		{
			if( GetPVarInt( playerid, "Tune:PageAero" ) + 1 == IsVehiclePaintjobCompatible( GetVehicleModel( GetPVarInt( playerid, "Tune:Carid" ) ) ) )
				return 1;
				
			GivePVarInt( playerid, "Tune:PageAero", 1 );
			ChangeVehiclePaintjob( carid, GetPVarInt( playerid, "Tune:PageAero" ) );
			
			return 1;
		}
	
		if( GetPVarInt( playerid, "Tune:Page" ) + 1 == GetPVarInt( playerid, "Tune:Max" ) )
			return 1;
			
		PreviewTuning( playerid, carid, GetPVarInt( playerid, "Tune:Type" ), GetPVarInt( playerid, "Tune:Page" ) + 1 );
		return 1;
	}
	else if( clickedid == car_tuning[2] ) //Установить
	{
		new
			carid = GetPVarInt( playerid, "Tune:Carid" ),
			get_price,
			price,
			type = GetPVarInt( playerid, "Tune:Type" );
	
		if( GetVehicleDistanceFromPoint( carid, TuningPosition[GetPVarInt( playerid, "Tune:Position" )][0], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][1], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][2] ) > 5.0 )
		{
			return SendClient:( playerid, C_WHITE, ""gbError"Ваш транспорт находится далеко от подъемника." );
		}
	
		if( GetPVarInt( playerid, "Tune:Page" ) == INVALID_PARAM )
		{	
			if( !Vehicle[carid][vehicle_tuning][type] )
			{
				SendClient:( playerid, C_WHITE, ""gbError"На этом автомобиле уже установлена сток деталь." );
				return 1;
			}
			
			showPlayerDialog( playerid, d_tune + 3, DIALOG_STYLE_MSGBOX, " ", "\
				"cBLUE"Тюнинг\n\n\
				"cWHITE"Вы действительно желаете установить сток деталь?", "Да", "Нет" );
				
			DeletePVar( playerid, "Tune:Show" );
			CancelSelectTextDraw( playerid );
			return 1;
		}
		
		if( Vehicle[carid][vehicle_tuning][type] == g_tuning_select[playerid] )
		{
			SendClient:( playerid, C_WHITE, ""gbError"На этом автомобиле уже установлена такая деталь." );
			return 1;
		}
		
		get_price = floatround( float( GetVehiclePrice( GetVehicleModel ( carid ) ) ) / 100.0 * ComponentsInfo[type][GetPVarInt( playerid, "Tune:Page" )][c_price] ),
		price = get_price - floatround( get_price * Premium[playerid][prem_drop_tuning] / 100 );
		
		if( Player[playerid][uMoney] <  price )
		{
			SendClient:( playerid, C_WHITE, !NO_MONEY );
			return 1;
		}
		
		SetPVarInt( playerid, "Tune:Price", price );
		
		format:g_small_string( "\
			"cBLUE"Тюнинг\n\n\
			"cWHITE"Вы действительно желаете установить "cBLUE"%s"cWHITE" на "cBLUE"%s"cWHITE"?\n\n\
			"gbDialog"Стоимость установки "cBLUE"$%d"cGRAY".", 
			ComponentsInfo[type][GetPVarInt( playerid, "Tune:Page" )][c_name],
			GetVehicleModelName( GetVehicleModel ( carid ) ),
			price );
		
		showPlayerDialog( playerid, d_tune + 3, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		
		DeletePVar( playerid, "Tune:Show" );
		CancelSelectTextDraw( playerid );
		return 1;
	}
	else if( clickedid == car_tuning[3] ) //Назад
	{
		CancelSelectTextDraw( playerid );
		return 1;
	}
	else if( clickedid == car_tuning[7] ) //Покраска
	{
		new
			carid = GetPVarInt( playerid, "Tune:Carid" ),
			price;
			
		if( GetVehicleDistanceFromPoint( carid, TuningPosition[GetPVarInt( playerid, "Tune:Position" )][0], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][1], TuningPosition[GetPVarInt( playerid, "Tune:Position" )][2] ) > 5.0 )
		{
			return SendClient:( playerid, C_WHITE, ""gbError"Ваш транспорт находится далеко от подъемника." );
		}
	
		if( GetPVarInt( playerid, "Tune:ShowAero" ) )
		{
			if( Vehicle[carid][vehicle_color][2] - 1 == GetPVarInt( playerid, "Tune:PageAero" ) )
			{
				pformat:( ""gbError"Такая аэрография уже нанесена на "cBLUE"%s"cWHITE".", GetVehicleModelName( GetVehicleModel( carid ) ) );
				psend:( playerid, C_WHITE );
				return 1;
			}
			
			price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_AERO );
		
			if( Player[playerid][uMoney] < price )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				return 1;
			}
		
			DeletePVar( playerid, "Tune:ShowAero" );
			CancelSelectTextDraw( playerid );
			
			format:g_small_string( "\
				"cBLUE"Покраска аэрографом\n\n\
				"cWHITE"Вы действительно желаете нанести эту аэрографию на "cBLUE"%s"cWHITE"?\n\n\
				"gbDialog"Стоимость покраски "cBLUE"$%d"cGRAY".", 
				GetVehicleModelName( GetVehicleModel( carid ) ),
				price );
				
			showPlayerDialog( playerid, d_tune + 7, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
			return 1;
		}
		
		switch( GetPVarInt( playerid, "Tune:Color" ) )
		{
			case 1: price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_COLOR_1 ); 
			case 2: price = floatround( float( GetVehiclePrice( GetVehicleModel( carid ) ) ) / 100 * PRICE_COLOR_2 );
		}
	
		if( Player[playerid][uMoney] < price )
		{
			SendClient:( playerid, C_WHITE, !NO_MONEY );
			return 1;
		}
	
		DeletePVar( playerid, "Tune:ShowColor" );
		CancelSelectTextDraw( playerid );
		
		format:g_small_string( "\
			"cBLUE"Покраска слоя %d\n\n\
			"cWHITE"Вы действительно желаете покрасить "cBLUE"%s"cWHITE" в этот цвет?\n\n\
			"gbDialog"Стоимость покраски "cBLUE"$%d"cWHITE".\n\
			%s",
			GetPVarInt( playerid, "Tune:Color" ),
			GetVehicleModelName( GetVehicleModel( carid ) ),
			price,
			Vehicle[carid][vehicle_color][2] ? (""cRED"Существующая аэрография будет перекрыта слоем краски.") : (" ") );
		showPlayerDialog( playerid, d_tune + 6, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		return 1;
	}
	else if( clickedid == car_tuning[8] ) //Назад из покраски
	{
		if( GetPVarInt( playerid, "Tune:ShowAero" ) )
		{
			CancelSelectTextDraw( playerid );
			return 1;
		}
		
		CancelSelectTextDraw( playerid );
		return 1;
	}
	
	return 0;
}

PreviewTuning( playerid, vehicleid, type, page )
{
	new
		model = GetVehicleModel( vehicleid ),
		get_price,
		price;
		
	begin:
	
	if( page == INVALID_PARAM )
	{
		if( g_tuning_select[playerid] )
		{
			RemoveVehicleComponent( vehicleid, g_tuning_select[playerid] );
		}
		
		if( Vehicle[vehicleid][vehicle_tuning][type] )
		{
			RemoveVehicleComponent( vehicleid, Vehicle[vehicleid][vehicle_tuning][type] );
		}
		
		SetPVarInt( playerid, "Tune:Page", page );
		
		PlayerTextDrawSetString( playerid, tuning_name[playerid], "Сток" );
		PlayerTextDrawSetString( playerid, tuning_price[playerid], "$0" );
	}
	else if( page < GetPVarInt( playerid, "Tune:Page" ) )
	{
		for( new i = page; i > INVALID_PARAM; i-- )
		{
			if( IsVehicleUpgradeCompatible( model, ComponentsInfo[type][i][c_id] ) )
			{
				get_price = floatround( float( VehicleInfo[model - 400][v_price] ) / 100.0 * ComponentsInfo[type][i][c_price] ),
				price = get_price - floatround( get_price * Premium[playerid][prem_drop_tuning] / 100 );
			
				format:g_small_string( "%s", ComponentsInfo[type][i][c_name] );
				PlayerTextDrawSetString( playerid, tuning_name[playerid], g_small_string );
				format:g_small_string( "$%d", price );
				PlayerTextDrawSetString( playerid, tuning_price[playerid], g_small_string );
				
				SetPVarInt( playerid, "Tune:Page", i );
				g_tuning_select[playerid] = ComponentsInfo[type][i][c_id];
				
				AddVehicleComponent( vehicleid, ComponentsInfo[type][i][c_id] );
				return 1;
			}
		}
		
		page = INVALID_PARAM;
		goto begin;
	}
	else if( page > GetPVarInt( playerid, "Tune:Page" ) )
	{
		for( new i = page; i < GetPVarInt( playerid, "Tune:Max" ); i++ )
		{
			if( IsVehicleUpgradeCompatible( model, ComponentsInfo[type][i][c_id] ) )
			{
				get_price = floatround( float( VehicleInfo[model - 400][v_price] ) / 100.0 * ComponentsInfo[type][i][c_price] ),
				price = get_price - floatround( get_price * Premium[playerid][prem_drop_tuning] / 100 );
			
				format:g_small_string( "%s", ComponentsInfo[type][i][c_name] );
				PlayerTextDrawSetString( playerid, tuning_name[playerid], g_small_string );
				format:g_small_string( "$%d", price );
				PlayerTextDrawSetString( playerid, tuning_price[playerid], g_small_string );
				
				SetPVarInt( playerid, "Tune:Page", i );
				g_tuning_select[playerid] = ComponentsInfo[type][i][c_id];
				
				AddVehicleComponent( vehicleid, ComponentsInfo[type][i][c_id] );
				return 1;
			}
		}
	}
	
	return 1;
}

ShowMenuTuning( playerid, bool:flag )
{
	switch( flag )
	{
		case true:
		{
			PlayerTextDrawShow( playerid, tuning_name[playerid] );
			PlayerTextDrawShow( playerid, tuning_price[playerid] );
					
			for( new i; i < 7; i++ )
			{
				TextDrawShowForPlayer( playerid, car_tuning[i] );
			}
		}
		
		case false:
		{
			PlayerTextDrawHide( playerid, tuning_name[playerid] );
			PlayerTextDrawHide( playerid, tuning_price[playerid] );
					
			for( new i; i < 7; i++ )
			{
				TextDrawHideForPlayer( playerid, car_tuning[i] );
			}
			
			DeletePVar( playerid, "Tune:Max" );
			DeletePVar( playerid, "Tune:Type" );
			DeletePVar( playerid, "Tune:Page" );
			DeletePVar( playerid, "Tune:Show" );
		}
	}
	
	return 1;
}

stock UpdateTuning( vehicleid )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_VEHICLES"` SET `vehicle_tuning` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE `vehicle_id` = %d",
		Vehicle[vehicleid][vehicle_tuning][0],
		Vehicle[vehicleid][vehicle_tuning][1],
		Vehicle[vehicleid][vehicle_tuning][2],
		Vehicle[vehicleid][vehicle_tuning][3],
		Vehicle[vehicleid][vehicle_tuning][4],
		Vehicle[vehicleid][vehicle_tuning][5],
		Vehicle[vehicleid][vehicle_tuning][6],
		Vehicle[vehicleid][vehicle_tuning][7],
		Vehicle[vehicleid][vehicle_tuning][8],
		Vehicle[vehicleid][vehicle_tuning][9],
		Vehicle[vehicleid][vehicle_tuning][10],
		Vehicle[vehicleid][vehicle_tuning][11],
		Vehicle[vehicleid][vehicle_id]
	);
	
	return mysql_tquery( mysql, g_string, "", "" );
}

stock UpdateColorCar( vehicleid )
{
	clean:<g_string>;
	
	mysql_format( mysql, g_string, sizeof g_string, "UPDATE `"DB_VEHICLES"` SET `vehicle_color` = '%d|%d|%d' WHERE `vehicle_id` = %d",
		Vehicle[vehicleid][vehicle_color][0],
		Vehicle[vehicleid][vehicle_color][1],
		Vehicle[vehicleid][vehicle_color][2],
		Vehicle[vehicleid][vehicle_id]
	);
	
	return mysql_tquery( mysql, g_string, "", "" );
}