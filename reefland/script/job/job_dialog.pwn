Job_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	switch( dialogid )
	{
		case d_daln - 1:
		{
			if( !response )
			{
				if( Player[playerid][uJob] == JOB_PRODUCTS )
				{
					format:g_string( job_dialog, job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
				}
				else
				{
					format:g_string( job_dialog, "Начать" );
				}
				return showPlayerDialog( playerid, d_daln, DIALOG_STYLE_LIST, "Транспортная компания", g_string, "Выбрать", "Закрыть" );
			}
		
			if( Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы не можете устроиться в транспортную компанию." );

		    if( Player[playerid][uJob] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы уже устроены на работу!" );

            if( !GetStatusPlayerLicense( playerid, LICENSE_DRIVE ) )
				return SendClient:( playerid, C_WHITE, ""gbError"Для устройства на работу необходимо водительское удостоверение!" );

			if( !getItem( playerid, INV_SPECIAL, PARAM_CARD ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У Вас отсутствует ID-карта." );
		
			Player[playerid][uJob] = JOB_PRODUCTS;
		    UpdatePlayer( playerid, "uJob", Player[playerid][uJob] );

			Job[playerid][j_time] = gettime() + 21600;
			UpdatePlayer( playerid, "uJobTime", Job[ playerid ][j_time] );

		    SendClient:( playerid, C_WHITE, ""gbSuccess"Вы подписали контракт в транспортной компании на 6 часов." );

			MeAction( playerid, "устраивается на работу", 1 );
		}
	
		case d_daln:
		{
		    if( !response ) return 1;

		    switch(listitem)
			{
		        case 0:
				{
					if( Player[playerid][uJob] != JOB_PRODUCTS )
						return SendClient:( playerid, C_GRAY, ""gbError"Вы не работаете в транспортной компании!" );

		            if( !job_duty{playerid} )
					{
						showPlayerDialog( playerid, d_daln + 1, DIALOG_STYLE_LIST, " ",
							""cBLUE"1. "cWHITE"Развозка ресурсов\n\
							"cBLUE"2. "cWHITE"Развозка продукции",
						"Далее", "Закрыть" );
					}
		            else
					{
					
						clean:<g_string>;
						
						if( Job[playerid][j_trailerid] )
						{
							new
								product = GetPVarInt( playerid, "Job:SelectProduct" ),
								jstock = GetPVarInt( playerid, "Job:StockLoad" ),
								vid = Job[playerid][j_vehicleid];
								
							if( Server[jstock][s_value][product] + VehicleJob[vid][v_count_tons][product] > MAX_COUNT_STOCKS )
							{
								Server[jstock][s_value][product] = MAX_COUNT_STOCKS;
							}
							else
							{
								Server[jstock][s_value][product] += VehicleJob[vid][v_count_tons][product];
							}
							
							UpdateValueServer( jstock, product );
							DeletePVar( playerid, "Job:SelectProduct" ),
							DeletePVar( playerid, "Job:StockLoad" );
						
							DestroyVehicle( Job[playerid][j_trailerid] );
							printf( "[Log]: Destroy job trailer ID: %d = playerid %s[%d].", Job[playerid][j_trailerid], GetAccountName( playerid ), playerid );
							
							VehicleJob[vid][v_count_tons][product] = 
							Job[playerid][j_trailerid] = 0;
						}
						
						if( GetPVarInt( playerid, "Job:SetCheckPointProd" ) )
						{
							new
								order = GetPVarInt( playerid, "Job:SelectOrder" ),
								vid = Job[playerid][j_vehicleid];

							ProductsInfo[order][b_count_time] += Job[playerid][j_count_order];
							
							VehicleJob[vid][v_count_prod] = 
							Job[playerid][j_count_order] = 0;
							
							KillTimer( timer_order[playerid] );

							DeletePVar( playerid, "Job:SetCheckPointProd" );
							DeletePVar( playerid, "Job:SelectOrder" );
							DeletePVar( playerid, "Load:Products" );
						}
						
						DeletePVar( playerid, "Job:Unload" );
						
						if( Job[playerid][j_vehicleid] )
						{
							new
								price = GetPriceForBadVehicle( Job[playerid][j_vehicleid] ),
								text[ 256 ];
						
							if( price )
							{
								format:text( ""gbDialogError"Вы заплатили штраф в размере $%d за испорченный транспорт.\nДеньги списаны с Вашего банковского счета.\n\n", price );
								strcat( g_string, text );
								
								SetPlayerBank( playerid, "-", price );
							}
						
							SetVehicleToRespawn( Job[playerid][j_vehicleid] );
							VehicleJob[ Job[playerid][j_vehicleid] ][v_driverid] = INVALID_PARAM;
							Job[playerid][j_vehicleid] = 0;
						}

						DisablePlayerCheckpoint( playerid );

						format:g_small_string( "\
							"gbSuccess"Рабочий день в транспортной компании завершен.\n\
							Вы заработали "cBLUE"$%d"cWHITE". Деньги перечислены на чековую книжку.", 
							Job[playerid][j_earn] );
						strcat( g_string, g_small_string );
						
						if( Premium[playerid][prem_salary] )
						{
							new
								prem_pay = floatround( Job[playerid][j_earn] * Premium[playerid][prem_salary]/100 );
							
							if( prem_pay )
							{
								format:g_small_string( "\n\n\
									"cGREEN"+ $%d"cGRAY" к заработанной сумме ["cBLUE"Премиум"cGRAY"]", 
									prem_pay );
								strcat( g_string, g_small_string );
							
								Player[playerid][uCheck] += prem_pay;
							}
						}
						
						showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Рабочий день", g_string, "Закрыть", "" );
						UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
						
						Job[playerid][j_earn] = 
						job_duty{playerid} = 0;
		            }
				}

		        case 1:
				{
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", job_description_prod, "Закрыть", "" );
		        }

		        case 2:
				{
					if( Player[playerid][uLevel] < 2 )
						return SendClient:( playerid, C_GRAY, ""gbError"Ваш уровень не позволяет устроиться на эту работу." );
				
		            showPlayerDialog( playerid, d_daln - 1, DIALOG_STYLE_MSGBOX, " ", "\
						"cBLUE"Трудовой контракт\n\n\
						"cWHITE"Вы заключаете шестичасовой трудовой контракт в "cBLUE"транспортной компании.\n\
						"gbDialogError"Заблаговременно расторгнуть трудовой контракт нельзя.\n\n\
						"cWHITE"Желаете продолжить?",
					"Да", "Нет" );
		        }
		    }
		}

		case d_daln + 1:
		{
		    if( !response ) 
			{
				if( Player[playerid][uJob] == JOB_PRODUCTS )
				{
					format:g_string( job_dialog, job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
				}
				else
				{
					format:g_string( job_dialog, "Начать" );
				}
				return showPlayerDialog( playerid, d_daln, DIALOG_STYLE_LIST, "Транспортная компания", g_string, "Выбрать", "Закрыть" );
			}

			switch( listitem )
			{
			    case 0:
				{
					new
						count,
						cars[16];

					for( new i = cars_prod[0]; i < cars_prod[1]; i++ )
					{
						if( VehicleJob[i][v_driverid] == INVALID_PARAM )
						{
							if( GetVehicleModel(i) == 514 || GetVehicleModel(i) == 515 )
							{
								for( new j; j < sizeof cars; j++ )
								{
									if( !cars[j] )
									{
										cars[j] = i;
										count++;
										break;
									}
								}
							}
						}
					}

					if( !count )
						return SendClient:( playerid, C_GRAY, ""gbError"Все транспортные средства заняты." );

					Job[playerid][j_vehicleid] = cars[random( count )];
					VehicleJob[Job[playerid][j_vehicleid]][v_driverid] = playerid;
						
					new
						Float:pos[3];

					format:g_small_string( "получил%s ключи от рабочего авто", SexTextEnd( playerid ) );
					MeAction( playerid, g_small_string, 1 );

					GetVehiclePos( Job[playerid][j_vehicleid], pos[0], pos[1], pos[2] );

					SetPlayerCheckpoint( playerid, pos[0], pos[1], pos[2], 5.0 );

					job_duty{playerid} = 1;
					
					Player[playerid][uRadioChannel] = CHANNEL_TRUCKER;
					
					if( Player[playerid][uSettings][8] )
					{
						UpdateRadioInfo( playerid, 1 );
					}

					SendClient:( playerid, C_WHITE, ""gbSuccess"Вы получили ключи и документы от рабочего транспорта, автомобиль находится на парковке.");
					SendClient:( playerid, C_WHITE, ""gbDefault"Cтационарная рация настроена на волну "cBLUE"535"cWHITE".");
			    }

			    case 1:
				{
				   	new
						cars[9],
						count,
						bool:flag = false;

			    	for(new i; i != MAX_PRODUCT_INFO; i ++)
					{
					    if( ProductsInfo[i][b_count] )
						{
							flag = true;
							break;
						}
					}

					if( flag == false )
						return SendClient:( playerid, C_GRAY, ""gbError"В данный момент заказов на продукты нет!" );

					for( new i = cars_prod[0]; i < cars_prod[1]; i++ )
					{
						if( VehicleJob[i][v_driverid] == INVALID_PARAM )
						{
							if( GetVehicleModel(i) == 499 || GetVehicleModel(i) == 414 )
							{
								for( new j; j < sizeof cars; j++ )
								{
									if( !cars[j] )
									{
										cars[j] = i;
										count++;
										break;
									}
								}
							}
						}
					}

					if( !count )
						return SendClient:( playerid, C_GRAY, ""gbError"Все транспортные средства заняты." );

					Job[playerid][j_vehicleid] = cars[random( count )];
					VehicleJob[Job[playerid][j_vehicleid]][v_driverid] = playerid;	
						
					new
						Float:pos[3];

					format:g_small_string( "получил%s ключи от рабочего авто", SexTextEnd( playerid ) );
					MeAction( playerid, g_small_string, 1 );

					GetVehiclePos( Job[playerid][j_vehicleid], pos[0], pos[1], pos[2] );

					SetPlayerCheckpoint( playerid, pos[0], pos[1], pos[2], 5.0 );

					job_duty{playerid} = 1;
					Player[playerid][uRadioChannel] = CHANNEL_TRUCKER;
					
					if( Player[playerid][uSettings][8] )
					{
						UpdateRadioInfo( playerid, 1 );
					}
					
					SendClient:( playerid, C_WHITE, ""gbSuccess"Вы получили ключи и документы от рабочего транспорта, автомобиль находится на парковке." );
					SendClient:( playerid, C_WHITE, ""gbDefault"Cтационарная рация настроена на волну "cBLUE"535"cWHITE".");
					SendClient:( playerid, C_WHITE, ""gbDefault"Отправляйтесь на склад "cBLUE"Hilltop Farms"cWHITE" для загрузки товаров." );
				}
			}
		}

		//Диалог на складе
		case d_daln + 2:
		{
			if( !response ) 
			{
				if( GetPVarInt( playerid, "Stock:List" ) )
					DeletePVar( playerid, "Stock:List" );
					
				return 1;
			}

			switch( listitem )
			{
				case 0:
				{
					ShowStocksInfo( playerid, 1 );
				}

				case 1:
				{
					if( Player[playerid][uJob] != JOB_PRODUCTS )
						return SendClient:( playerid, C_GRAY, ""gbError"Вы не работаете водителем в транспортной компании!" );

					if( !job_duty{playerid} )
						return SendClient:( playerid, C_GRAY, ""gbError"Вы не начали свой рабочий день!" );

					if( !Job[playerid][j_vehicleid] )
						return SendClient:( playerid, C_GRAY, ""gbError"Вы не арендовали рабочий транспорт!" );

					if( Job[playerid][j_trailerid] )
						return SendClient:( playerid, C_GRAY, ""gbError"У Вашего тягача уже есть прицеп!" );
						
					if( GetPVarInt( playerid, "Job:Turn" ) )
						return SendClient:( playerid, C_GRAY, ""gbError"Вы уже встали в очередь на загрузку." );

					switch( GetVehicleModel( Job[playerid][j_vehicleid] ) )
					{
						case 499,414:
						{
							return SendClient:( playerid, C_GRAY, ""gbError"Вы занимаетесь развозкой товаров!" );
						}
					}

					if( GetPVarInt( playerid,"PlayerMenuShow" ) )
						return SendClient:( playerid, C_GRAY, ""gbError"Недоступно, попробуйте позже.");

					showPlayerDialog( playerid, d_daln + 7, DIALOG_STYLE_LIST, " ", list_products, "Далее", "Назад" );
				}
			}
		}

		case d_daln + 3:
		{
			if( !response )
				return 1;

			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 )
			{
				new
					text[256];

				format:text( load_products, MAX_PRODUCTS_INCAR );

				clean:<g_string>;
				strcat( g_string, text );

				format:g_small_string( ""gbDialogError"\nНеверное значение, повторите ввод." );
				strcat( g_string, g_small_string );

				return showPlayerDialog( playerid, d_daln + 3, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
			}

			if( strval( inputtext ) + VehicleJob[GetPlayerVehicleID( playerid )][v_count_prod] > MAX_PRODUCTS_INCAR )
			{
				new
					text[256];

				format:text( load_products, MAX_PRODUCTS_INCAR );

				clean:<g_string>;
				strcat( g_string, text );

				format:g_small_string( ""gbDialogError"\nАвтомобиль не может вместить столько товаров!" );
				strcat( g_string, g_small_string );

				return showPlayerDialog( playerid, d_daln + 3, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Закрыть" );
			}

			VehicleJob[GetPlayerVehicleID( playerid )][v_count_prod] += strval( inputtext );
			
			format:g_small_string( "Products: %d", VehicleJob[GetPlayerVehicleID( playerid )][v_count_prod] );
			PlayerTextDrawSetString( playerid, Taximeter[playerid], g_small_string );
			
			SendClient:( playerid, C_WHITE,""gbDefault"Используйте "cBLUE"/job, "cWHITE"чтобы посмотреть список заказов!");

			format:g_small_string( "загрузил%s товары в автомобиль", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );

			SetPVarInt( playerid, "Load:Products", 1 );
		}

		case d_daln + 4:
		{
			if( !response )
				return 1;

			if( GetPVarInt( playerid, "Job:SetCheckPointProd" ) )
			{
				return SendClient:( playerid, C_WHITE, ""gbError"У Вас уже есть активный заказ." );
			}

			if( !VehicleJob[GetPlayerVehicleID( playerid )][v_count_prod] )
				return SendClient:( playerid, C_GRAY, ""gbError"В Вашем автомобиле отсутствуют товары!" );

			new
				order,
				bid,
				earn;

			SetPVarInt( playerid, "Job:SelectOrder", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;

			order = GetPVarInt( playerid, "Job:SelectOrder" );

			bid = ProductsInfo[order][b_id];
			earn = floatround( BusinessInfo[bid][b_product_price] * ProductsInfo[order][b_count] / 100 * 10 );

			format:g_string( "\
				"cWHITE"Информация о заказе:\n\n\
				"cWHITE"Номер заказа "cBLUE"%d"cWHITE"\n\
				Бизнес - "cBLUE"%s (#%d)"cWHITE"\n\
				Кол-во товаров - "cBLUE"%d"cWHITE"\n\
				Оплата - "cBLUE"$%d",
				order + 1,
				BusinessInfo[bid][b_name], ProductsInfo[order][b_business_id],
				ProductsInfo[order][b_count],
				earn
			);

			showPlayerDialog( playerid, d_daln + 5, DIALOG_STYLE_MSGBOX, " ", g_string, "Выбрать", "Назад" );
		}

		case d_daln + 5:
		{
			if( !response )
			{
				OpenListOrders( playerid );
				return 1;
			}

			new
				order = GetPVarInt( playerid, "Job:SelectOrder" ),
				vid = GetPlayerVehicleID( playerid ),
				bid = ProductsInfo[order][b_id];

			if( ProductsInfo[order][b_count] - VehicleJob[vid][v_count_prod] > 0 )
			{
				ProductsInfo[order][b_count_time] -= VehicleJob[vid][v_count_prod];
				Job[playerid][j_count_order] = VehicleJob[vid][v_count_prod];
			}
			else
			{
				Job[playerid][j_count_order] = ProductsInfo[order][b_count];
				ProductsInfo[order][b_count_time] = 0;
			}

			pformat:( ""gbDefault"Доставьте продукты в "cBLUE"%s #%d"cWHITE". Для разгрузки используйте "cBLUE"/unload"cWHITE".", GetBusinessType( bid ), BusinessInfo[bid][b_id] );
			psend:( playerid, C_GRAY );

			SetPlayerCheckpoint( playerid, BusinessInfo[bid][b_enter_pos][0], BusinessInfo[bid][b_enter_pos][1], BusinessInfo[bid][b_enter_pos][2], 4.0 );

			format:g_small_string( "взял%s заказ на доставку товаров", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );

			SetPVarInt( playerid, "Job:SetCheckPointProd", 1 );

			SendClient:( playerid, C_WHITE, ""gbDefault"У Вас есть 10 минут на доставку товаров к месту назначения." );

			timer_order[playerid] = SetTimerEx( "OnTimerUpdateOrder", 600000, false, "d", playerid );
		}

		//Диалог информации о складе
		case d_daln + 6:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_daln + 2, DIALOG_STYLE_LIST, " ", dialog_stocks, "Далее", "Закрыть" );
			}
			
			switch( GetPVarInt( playerid, "Stock:List" ) )
			{
				case 1: ShowStocksInfo( playerid, 2 );
				case 2: ShowStocksInfo( playerid, 1 );
			}			
		}

		//Диалог выбора товара
		case d_daln + 7:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_daln + 2, DIALOG_STYLE_LIST, " ", dialog_stocks, "Далее", "Закрыть" );
			}

			new
				jstock = GetPVarInt( playerid, "Job:Stock" );

			if( Server[jstock][s_value][listitem] < 2 )
			{
				SendClient:( playerid, C_WHITE, ""gbError"На складе недостаток этого товара!");
				return showPlayerDialog( playerid, d_daln + 7, DIALOG_STYLE_LIST, " ", list_products, "Далее", "Назад" );
			}

			switch( listitem )
			{
				case 0,4,5:
				{
					SetPVarInt( playerid, "Job:TrailerModel", 591 );
				}

				case 1,3:
				{
					SetPVarInt( playerid, "Job:TrailerModel", 435 );
				}

				case 2:
				{
					SetPVarInt( playerid, "Job:TrailerModel", 584 );
				}
			}
			
			SetPVarInt( playerid, "Job:SelectProduct", listitem );

			format:g_string( "\
				"cWHITE"Укажите, какое количество тонн Вы хотите загрузить:\n\n\
				Цена за 1 тонну: "cBLUE"$%d"cWHITE"\n\
				"gbDialog"Максимум 10 тонн.\n\n\
				%s", 
				GetPriceForProducts( listitem, Server[jstock][s_value][listitem] ),
				listitem > 2 ? (""cGREEN"Этот товар не зависит от повреждений транспорта.") : (""cRED"Этот товар зависит от повреждений транспорта!")
			);

			format:g_small_string( ""cBLUE"%s", name_products[listitem] );

			return showPlayerDialog( playerid, d_daln + 8, DIALOG_STYLE_INPUT, g_small_string, g_string, "Далее", "Назад" );
		}

		//Диалог с вводом количества тонн
		case d_daln + 8:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_daln + 7, DIALOG_STYLE_LIST, " ", list_products, "Далее", "Назад" );
			}

			new
				jstock = GetPVarInt( playerid, "Job:Stock" ),
				product = GetPVarInt( playerid, "Job:SelectProduct" ),
				bool:flag = false;

			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 ||  strval( inputtext ) > 10 )
			{
				format:g_string( "\
					"cWHITE"Укажите, какое количество тонн Вы хотите загрузить:\n\n\
					Цена за 1 тонну: "cBLUE"$%d"cWHITE"\n\
					"gbDialog"Максимум - 10 тонн.\n\n\
					%s\n\n\
					"gbDialogError"Неправильный формат значения, повторите ввод.", 
					GetPriceForProducts( product, Server[jstock][s_value][product] ),
					product > 2 ? (""cGREEN"Этот товар не зависит от повреждений транспорта.") : (""cRED"Этот товар зависит от повреждений транспорта!")
				);

				format:g_small_string( ""cBLUE"%s", name_products[product] );

				return showPlayerDialog( playerid, d_daln + 8, DIALOG_STYLE_INPUT, g_small_string, g_string, "Далее", "Назад" );
			}

			if( Server[jstock][s_value][product] - strval( inputtext ) < MIN_COUNT_STOCKS )
			{
				format:g_string( "\
					"cWHITE"Укажите, какое количество тонн Вы хотите загрузить:\n\n\
					Цена за 1 тонну: "cBLUE"$%d"cWHITE"\n\
					"gbDialog"Максимум - 10 тонн.\n\n\
					%s\n\n\
					"gbDialogError"На складе недостаточно товара!", 
					GetPriceForProducts( product, Server[jstock][s_value][product] ),
					product > 2 ? (""cGREEN"Этот товар не зависит от повреждений транспорта.") : (""cRED"Этот товар зависит от повреждений транспорта!")
				);

				format:g_small_string( ""cBLUE"%s", name_products[product] );

				return showPlayerDialog( playerid, d_daln + 8, DIALOG_STYLE_INPUT, g_small_string, g_string, "Далее", "Назад" );
			}

			if( Player[playerid][uMoney] < strval( inputtext ) * GetPriceForProducts( product, Server[jstock][s_value][product] ) )
			{
				format:g_string( "\
					"cWHITE"Укажите, какое количество тонн Вы хотите загрузить:\n\n\
					Цена за 1 тонну: "cBLUE"$%d"cWHITE"\n\
					"gbDialog"Максимум - 10 тонн.\n\n\
					%s\n\n\
					"gbDialogError"У Вас недостаточно денег для оплаты!", 
					GetPriceForProducts( product, Server[jstock][s_value][product] ),
					product > 2 ? (""cGREEN"Этот товар не зависит от повреждений транспорта.") : (""cRED"Этот товар зависит от повреждений транспорта!")
				);

				format:g_small_string( ""cBLUE"%s", name_products[product] );

				return showPlayerDialog( playerid, d_daln + 8, DIALOG_STYLE_INPUT, g_small_string, g_string, "Далее", "Назад" );
			}
			
			for( new i = 0; i < MAX_LISTITEM_LOAD; i++ )
			{
				if( !job_load_truck[jstock][i] )
				{
					job_load_truck[jstock][i] = Player[playerid][uID];
					flag = true;
					break;
				}
			}
			
			if( !flag )
				return SendClient:( playerid, C_WHITE, !""gbError"Очередь слишком большая, попробуйте позже." );

			SetPVarInt( playerid, "Job:Turn", 1 );
			SetPVarInt( playerid, "Job:CountTons", strval( inputtext ) );
			SetPVarInt( playerid, "Job:StockLoad", GetPlayerVirtualWorld( playerid ) - 1 );

			pformat:( ""gbSuccess"Вы встали в очередь на загрузку "cBLUE"%s"cWHITE". Вы заплатите за товар "cBLUE"$%d"cWHITE".", name_trucker[product], strval( inputtext ) * GetPriceForProducts( product, Server[jstock][s_value][product] )  );
			psend:( playerid, C_WHITE );

			UpdateTurnLoad( jstock );
			
			CreateTrailerForPlayer( jstock, playerid );
		}
		//Диалог разгрузки
		case d_daln + 9:
		{
			if( !response )
			{
				DeletePVar( playerid, "Job:StockUnload" );
				return 1;
			}
			
			new
				j = GetPVarInt( playerid, "Job:StockUnload" ),
				product = GetPVarInt( playerid, "Job:SelectProduct" ),
				vid = Job[playerid][j_vehicleid],
				trailerid = Job[playerid][j_trailerid],
				earn,
				Float:hp1,
				Float:hp2,
				Float:hp3;			
				
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 ||  strval( inputtext ) > VehicleJob[vid][v_count_tons][product] )
			{
				format:g_string( "\
					"cWHITE"Укажите, какое количество тонн Вы хотите разгрузить:\n\n\
					На складе: "cBLUE"%d"cWHITE"\n\
					Цена за 1 тонну: "cBLUE"$%d"cWHITE"\n\n\
					"gbDialog"В вашем прицепе "cBLUE"%d"cWHITE" т.\n\n\
					"gbDialogError"Неправильный формат значения, повторите ввод.",
					Server[j][s_value][product],
					GetPriceForProducts( product, Server[j][s_value][product] ),
					VehicleJob[vid][v_count_tons][product]
				);

				format:g_small_string( ""cBLUE"%s", name_products[product] );

				return showPlayerDialog( playerid, d_daln + 9, DIALOG_STYLE_INPUT, g_small_string, g_string, "Далее", "Назад" );
			}
			
			if( Server[j][s_value][product] + strval( inputtext ) > MAX_COUNT_STOCKS )
			{
				format:g_string( "\
					"cWHITE"Укажите, какое количество тонн Вы хотите разгрузить:\n\n\
					На складе: "cBLUE"%d"cWHITE"\n\
					Цена за 1 тонну: "cBLUE"$%d"cWHITE"\n\n\
					"gbDialog"В вашем прицепе "cBLUE"%d"cWHITE" т.\n\n\
					"gbDialogError"Склад не может вместить такое количество.",
					Server[j][s_value][product],
					GetPriceForProducts( product, Server[j][s_value][product] ),
					VehicleJob[vid][v_count_tons][product]
				);

				format:g_small_string( ""cBLUE"%s", name_products[product] );

				return showPlayerDialog( playerid, d_daln + 9, DIALOG_STYLE_INPUT, g_small_string, g_string, "Далее", "Назад" );
			}
			
			earn = strval( inputtext ) * GetPriceForProducts( product, Server[j][s_value][product] );
			
			if( VehicleJob[trailerid][v_damages_trailer] )
			{
				hp1 = VehicleJob[trailerid][v_damages_trailer];
				hp2 = ( 500.0 - ( hp1 - 500.0 ) ) / 500.0;
				hp3 = 1.0 - hp2;
				
				earn = floatround( strval( inputtext ) * GetPriceForProducts( product, Server[j][s_value][product] ) * hp3 );
				
				pformat:( ""gbDefault"За поврежденный товар с Вас вычли "cBLUE"%d"cWHITE"%s.", floatround( hp2 * 100 ), "%%" );
				psend:( playerid, C_WHITE );
			}
			
			VehicleJob[vid][v_count_tons][product] -= strval( inputtext );
			
			Server[j][s_value][product] += strval( inputtext );
			UpdateValueServer( j, product );
			
			Player[playerid][uCheck] += earn;
			UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
			
			Job[playerid][j_earn] += earn;
			
			pformat:( ""gbSuccess"Вы разгрузили "cBLUE"%d"cWHITE" т. товара "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE". Деньги перечислены на чековую книжку.",
				strval( inputtext ), name_products[product], earn );
			psend:( playerid, C_WHITE );
			
			if( !VehicleJob[vid][v_count_tons][product] )
			{
				DestroyVehicle( Job[playerid][j_trailerid] );
				printf( "[Log]: Destroy job trailer ID: %d = playerid %s[%d].", Job[playerid][j_trailerid], GetAccountName( playerid ), playerid );
				
				VehicleJob[vid][v_damages] = 
				VehicleJob[trailerid][v_damages_trailer] = 0.0;
				
				Job[playerid][j_trailerid] = 0;
				
				DeletePVar( playerid, "Job:StockLoad" );
				DeletePVar( playerid, "Job:SelectProduct" );
				
				PlayerTextDrawHide( playerid, Trucker[playerid] );
				TextDrawHideForPlayer( playerid, TaxiBackground );
			}
			else
			{
				pformat:( ""gbDefault"В Вашем прицепе есть еще "cBLUE"%d"cWHITE" т. товара "cBLUE"%s"cWHITE".", VehicleJob[vid][v_count_tons][product], name_products[product] );
				psend:( playerid, C_WHITE );
				
				switch( product )
				{
					case 0,1,2:
						format:g_small_string( "%s: %d t. %d%s", name_trucker[product], VehicleJob[vid][v_count_tons][product], GetDamagesProduct( Job[playerid][j_trailerid] ) ,"%" );
					case 3,4,5:
						format:g_small_string( "%s: %d t.", name_trucker[product], VehicleJob[vid][v_count_tons][product] );
				}
				PlayerTextDrawSetString( playerid, Trucker[playerid], g_small_string );
			}
			
			DeletePVar( playerid, "Job:StockUnload" );
		}
		
		//Диалоги автобусников
		case d_bus - 1:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0:
				{
					if( Player[playerid][uJob] == JOB_DRIVEBUS )
					{
						format:g_string( job_dialog, job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
					}
					else
					{
						format:g_string( job_dialog, "Начать" );
					}
					return showPlayerDialog( playerid, d_bus, DIALOG_STYLE_LIST, "Водитель автобуса", g_string, "Выбрать", "Назад" );
				}
				
				case 1:
				{
					if( Player[playerid][uJob] == JOB_DRIVETAXI )
					{
						format:g_string( job_dialog, job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
					}
					else
					{
						format:g_string( job_dialog, "Начать" );
					}
					return showPlayerDialog( playerid, d_taxi, DIALOG_STYLE_LIST, "Водитель такси", g_string, "Выбрать", "Назад" );
				}
			}
		}
		
		
		case d_bus:
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_bus - 1, DIALOG_STYLE_LIST, "Пассажирская компания", "\
					Водитель автобуса\n\
					Водитель такси",
				"Выбрать", "Закрыть" );
			}

		    switch(listitem)
			{
		        case 0:
				{
					if( Player[playerid][uJob] != JOB_DRIVEBUS )
						return SendClient:( playerid, C_GRAY, ""gbError"Вы не устроены на должность водителя автобуса!" );

		            if( !job_duty{playerid} )
					{
						new
							count,
							cars[8];

						for( new i = cars_bus[0]; i < cars_bus[1]; i++ )
						{
							if( VehicleJob[i][v_driverid] == INVALID_PARAM )
							{
								for( new j; j < sizeof cars; j++ )
								{
									if( !cars[j] )
									{
										cars[j] = i;
										count++;
										break;
									}
								}	
							}
						}

						if( !count )
							return SendClient:( playerid, C_GRAY, ""gbError"Все транспортные средства заняты." );

						Job[playerid][j_vehicleid] = cars[random( count )];
						VehicleJob[Job[playerid][j_vehicleid]][v_driverid] = playerid;		
							
						new
							Float:pos[3];

						format:g_small_string( "получил%sключи от рабочего авто", Player[playerid][uSex] == 1 ? (" "):("а ") );
						MeAction( playerid, g_small_string, 1 );

						GetVehiclePos( Job[playerid][j_vehicleid], pos[0], pos[1], pos[2] );
						SetPlayerCheckpoint( playerid, pos[0], pos[1], pos[2], 5.0 );

						job_duty{playerid} = 1;

						SendClient:( playerid, C_WHITE, ""gbSuccess"Вы получили ключи и документы от рабочего транспорта, автомобиль находится на парковке.");
					}
		            else
					{
						DestroyDynamicObject( VehicleJob[Job[playerid][j_vehicleid]][v_bus_text] );
						
						clean:<g_string>;
						
						if( Job[playerid][j_vehicleid] )
						{			
							new
								price = GetPriceForBadVehicle( Job[playerid][j_vehicleid] ),
								text[ 256 ];
						
							if( price )
							{
								format:text( ""gbDialogError"Вы заплатили штраф в размере $%d за испорченный транспорт.\nДеньги списаны с Вашего банковского счета.\n\n", price );
								strcat( g_string, text );
								
								SetPlayerBank( playerid, "-", price );
							}
						
							SetVehicleToRespawn( Job[playerid][j_vehicleid] );
							VehicleJob[Job[playerid][j_vehicleid]][v_driverid] = INVALID_PARAM;
							
							VehicleJob[Job[playerid][j_vehicleid]][v_route] = 
							Job[playerid][j_vehicleid] = 0;
						}

						DeletePVar( playerid, "Job:Bus" );
						DisablePlayerRaceCheckpoint( playerid );

						format:g_small_string( "\
							"gbSuccess"Рабочий день в пассажирской компании завершен.\n\
							Вы заработали "cBLUE"$%d"cWHITE". Деньги перечислены на чековую книжку.", 
							Job[playerid][j_earn] );
						strcat( g_string, g_small_string );
						
						if( Premium[playerid][prem_salary] )
						{
							new
								prem_pay = floatround( Job[playerid][j_earn] * Premium[playerid][prem_salary]/100 );
							
							if( prem_pay )
							{
								format:g_small_string( "\n\n\
									"cGREEN"+ $%d"cGRAY" к заработанной сумме ["cBLUE"Премиум"cGRAY"]",  
									prem_pay );
								strcat( g_string, g_small_string );
							
								Player[playerid][uCheck] += prem_pay;
								UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
							}
						}
						
						showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Рабочий день", g_string, "Закрыть", "" );
						
						Job[playerid][j_earn] = 
						job_duty{playerid} = 0;
		            }
				}

		        case 1:
				{
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", job_description_bus, "Закрыть", "" );
		        }

		        case 2:
				{
					if( Player[playerid][uLevel] < 1 )
						return SendClient:( playerid, C_GRAY, ""gbError"Ваш уровень не позволяет устроиться на эту работу." );
						
					showPlayerDialog( playerid, d_bus + 3, DIALOG_STYLE_MSGBOX, " ", "\
						"cBLUE"Трудовой контракт\n\n\
						"cWHITE"Вы заключаете шестичасовой трудовой контракт на должность "cBLUE"водитель автобуса.\n\
						"gbDialogError"Заблаговременно расторгнуть трудовой контракт нельзя.\n\n\
						"cWHITE"Желаете продолжить?",
					"Да", "Нет" );
		        }
		    }
		}
		//Диалог завершения автобусного маршрута
		case d_bus + 2:
		{
			if( !response ) 
			{
				DestroyDynamicObject( VehicleJob[Job[playerid][j_vehicleid]][v_bus_text] );
				
				clean:<g_string>;
				
				new
					price = GetPriceForBadVehicle( Job[playerid][j_vehicleid] );
						
				if( price )
				{
					format:g_small_string( "\
						"gbDialogError"Вы заплатили штраф в размере $%d за испорченный транспорт.\n\
						Деньги списаны с Вашего банковского счета.\n\n\
						"gbDefault"Аренда рабочего транспорта обнулена, завершите рабочий день.", price );
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Закрыть", "" );

					SetPlayerBank( playerid, "-", price );
				}
				else
				{
					SendClient:( playerid, C_WHITE, !""gbDefault"Аренда рабочего транспорта обнулена, завершите рабочий день." );
				}
				
				SetVehicleToRespawn( Job[playerid][j_vehicleid] );
				VehicleJob[Job[playerid][j_vehicleid]][v_driverid] = INVALID_PARAM;
				
				VehicleJob[Job[playerid][j_vehicleid]][v_route] = 
				Job[playerid][j_vehicleid] = 0;
				
				if( Player[playerid][uSettings][0] )
				{
					PlayerTextDrawHide( playerid, Drivebus[playerid] );
					TextDrawHideForPlayer( playerid, TaxiBackground );
				}
				
				DeletePVar( playerid, "Job:SelectRoute" );
				return 1;
			}
			
			VehicleJob[Job[playerid][j_vehicleid]][v_route] = 0;
			
			DestroyDynamicObject( VehicleJob[Job[playerid][j_vehicleid]][v_bus_text] );
			StartRouteBus( playerid, Job[playerid][j_vehicleid] );
		}
		
		case d_bus + 3:
		{
			if( !response )
			{
				if( Player[playerid][uJob] == JOB_DRIVEBUS )
				{
					format:g_string( job_dialog, job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
				}
				else
				{
					format:g_string( job_dialog, "Начать" );
				}
				return showPlayerDialog( playerid, d_bus, DIALOG_STYLE_LIST, "Водитель автобуса", g_string, "Выбрать", "Назад" );
			}
			
			if( Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы не можете устроиться на эту работу." );

		    if( Player[playerid][uJob] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы уже устроены на работу!" );

            if( !GetStatusPlayerLicense( playerid, LICENSE_DRIVE ) )
				return SendClient:( playerid, C_WHITE, ""gbError"Для устройства на работу необходимо водительское удостоверение!");

			if( !getItem( playerid, INV_SPECIAL, PARAM_CARD ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У Вас отсутствует ID-карта." );

			Player[playerid][uJob] = JOB_DRIVEBUS;
		    UpdatePlayer( playerid, "uJob", Player[playerid][uJob] );

			Job[playerid][j_time] = gettime() + 21600;
			UpdatePlayer( playerid, "uJobTime", Job[ playerid ][j_time] );

		    SendClient:( playerid, C_WHITE, ""gbSuccess"Вы подписали контракт в должности водителя автобуса на 6 часов." );

			MeAction( playerid, "устраивается на работу", 1 );
		}
		
		case d_taxi:
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_bus - 1, DIALOG_STYLE_LIST, "Пассажирская компания", "\
					Водитель автобуса\n\
					Водитель такси",
				"Выбрать", "Закрыть" );
			}
			
			switch( listitem )
			{
				case 0:
				{
					if( Player[playerid][uJob] != JOB_DRIVETAXI )
						return SendClient:( playerid, C_GRAY, ""gbError"Вы не устроены на должность водителя такси!" );

		            if( !job_duty{playerid} )
					{
						new
							count,
							cars[13];

						for( new i = cars_taxi[0]; i < cars_taxi[1] + 1; i++ )
						{
							if( VehicleJob[i][v_driverid] == INVALID_PARAM )
							{
								for( new j; j < sizeof cars; j++ )
								{
									if( !cars[j] )
									{
										cars[j] = i;
										count++;
										break;
									}
								}	
							}
						}

						if( !count )
							return SendClient:( playerid, C_GRAY, ""gbError"Все транспортные средства заняты." );

						Job[playerid][j_vehicleid] = cars[random( count )];
						VehicleJob[Job[playerid][j_vehicleid]][v_driverid] = playerid;		
							
						new
							Float:pos[3];

						format:g_small_string( "получил%s ключи от рабочего авто", SexTextEnd( playerid ) );
						MeAction( playerid, g_small_string, 1 );

						GetVehiclePos( Job[playerid][j_vehicleid], pos[0], pos[1], pos[2] );
						SetPlayerCheckpoint( playerid, pos[0], pos[1], pos[2], 5.0 );

						job_duty{playerid} = 1;

						Player[playerid][uRadioChannel] = CHANNEL_TAXI;
						
						if( Player[playerid][uSettings][8] )
						{
							UpdateRadioInfo( playerid, 1 );
						}
						
						SendClient:( playerid, C_WHITE, ""gbSuccess"Вы получили ключи и документы от рабочего транспорта, автомобиль находится на парковке.");
						SendClient:( playerid, C_WHITE, ""gbDefault"Стационарная рация настроена на волну "cBLUE"555"cWHITE". Чтобы начать работу, используйте "cBLUE"/job"cWHITE"." );
					}
		            else
					{
						new
							vid = Job[playerid][j_vehicleid];
							
						DestroyDynamicObject( VehicleJob[vid][v_taxi_text] );
					
						if( vid )
						{
							SetVehicleToRespawn( vid );
							VehicleJob[vid][v_driverid] = 
							VehicleJob[vid][v_passenger] = INVALID_PARAM;
							
							VehicleJob[vid][v_mileage] = 0.0;
							VehicleJob[vid][v_rate] = 0;
							
							Job[playerid][j_vehicleid] = 0;
						}

						DisablePlayerCheckpoint( playerid );

						SendClient:( playerid, C_GRAY, ""gbSuccess"Вы закончили рабочий день в пассажирской компании." );		
						
						Job[playerid][j_taxi] = false;
						
						Job[playerid][j_earn] = 
						job_duty{playerid} = 0;
		            }
				}

		        case 1:
				{
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", job_description_taxi, "Закрыть", "" );
		        }

		        case 2:
				{
					if( Player[playerid][uLevel] < 1 )
						return SendClient:( playerid, C_GRAY, ""gbError"Ваш уровень не позволяет устроиться на эту работу." );
				
					showPlayerDialog( playerid, d_taxi + 1, DIALOG_STYLE_MSGBOX, " ", "\
						"cBLUE"Трудовой контракт\n\n\
						"cWHITE"Вы заключаете шестичасовой трудовой контракт на должность "cBLUE"водитель такси.\n\
						"gbDialogError"Заблаговременно расторгнуть трудовой контракт нельзя.\n\n\
						"cWHITE"Желаете продолжить?",
					"Да", "Нет" );
		        }
			}
		}
		
		case d_taxi + 1:
		{
			if( !response )
			{		
				format:g_string( job_dialog, job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
				return showPlayerDialog( playerid, d_taxi, DIALOG_STYLE_LIST, "Водитель такси", g_string, "Выбрать", "Назад" );
			}
			
			if( Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы не можете устроиться на эту работу." );

            if( Player[playerid][uJob] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы уже устроены на работу!" );

			if( !GetStatusPlayerLicense( playerid, LICENSE_DRIVE ) )
				return SendClient:( playerid, C_WHITE, ""gbError"Для устройства на работу необходимо водительское удостоверение!");

			if( !getItem( playerid, INV_SPECIAL, PARAM_CARD ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У Вас отсутствует ID-карта." );

			Player[playerid][uJob] = JOB_DRIVETAXI;
            UpdatePlayer( playerid, "uJob", Player[playerid][uJob] );

			Job[playerid][j_time] = gettime() + 21600;
			UpdatePlayer( playerid, "uJobTime", Job[ playerid ][j_time] );

            SendClient:( playerid, C_WHITE, ""gbSuccess"Вы подписали контракт в должности водителя такси на 6 часов." );
			
			MeAction( playerid, "устраивается на работу", 1 );
		}
		
		//Панель таксиста
		case d_taxi + 2:
		{
			if( !response ) return 1;
			
			if( Job[playerid][j_taxi] )
				return SendClient:( playerid, C_WHITE, ""gbError"У Вас есть незавершенная заявка." );
				
			switch( listitem )
			{
				case 1:
				{
					if( !VehicleJob[Job[playerid][j_vehicleid]][v_rate] )
					{
						showPlayerDialog( playerid, d_taxi + 3, DIALOG_STYLE_INPUT, " ", "\
							"cBLUE"Установить тариф\n\n\
							"cWHITE"Установите цену за одну милю:\n\n\
							"gbDialog"Минимум $1, максимум $6.",
						"Далее", "Назад" );
					}
					else
						showPlayerDialog( playerid, d_taxi + 4, DIALOG_STYLE_MSGBOX, " ", "\
							"cWHITE"Вы действительно хотите выключить тарификацию?\n\n\
							"gbDialog"При снятии тарифа Вы не сможете просматривать список вызовов.",
						"Да", "Нет" );
				}
				
				case 2:
				{
					if( !VehicleJob[Job[playerid][j_vehicleid]][v_rate] )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Вы не установили тариф." );
						
						format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
						return showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
					}
					
					showPlayerDialog( playerid, d_taxi + 5, DIALOG_STYLE_INPUT, " ", "\
						"cBLUE"Изменить тариф\n\n\
						"cWHITE"Установите цену за одну милю:\n\n\
						"gbDialog"Минимум $1, максимум $6.",
					"Далее", "Назад" );
				}
				
				case 0:
				{
					if( !VehicleJob[Job[playerid][j_vehicleid]][v_rate] )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Вы не установили тариф." );
						
						format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
						return showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
					}
					
					ShowListTaxiCalls( playerid );
				}
				
				case 3:
				{
					if( !VehicleJob[Job[playerid][j_vehicleid]][v_rate] )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Вы не установили тариф." );
						
						format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
						return showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
					}
					
					VehicleJob[Job[playerid][j_vehicleid]][v_mileage] = 0.0;
					SendClient:( playerid, C_WHITE, ""gbError"Счетчик обнулен." );
					
					PlayerTextDrawSetString( playerid, Taximeter[playerid], "taximeter: $0" );
					
					if( VehicleJob[Job[playerid][j_vehicleid]][v_passenger] != INVALID_PARAM )
						PlayerTextDrawSetString( VehicleJob[Job[playerid][j_vehicleid]][v_passenger], Taximeter[VehicleJob[Job[playerid][j_vehicleid]][v_passenger]], "taximeter: $0" );
					
					format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
					showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
				}
			}
		}
		
		case d_taxi + 3:
		{
			if( !response ) 
			{
				format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
				return showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 6 )
			{
				return showPlayerDialog( playerid, d_taxi + 3, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Установить тариф\n\n\
					"cWHITE"Установите цену за одну милю:\n\n\
					"gbDialog"Минимум $1, максимум $6.\n\n\
					"gbDialogError"Неправильное значение, повторите ввод.",
				"Далее", "Назад" );
			}
			
			new
				vid = Job[playerid][j_vehicleid];
			
			VehicleJob[vid][v_rate] = strval( inputtext );
			format:g_string( "Тариф: $%d", VehicleJob[vid][v_rate] );
			
			VehicleJob[vid][v_taxi_text] = CreateDynamicObject( 19477, 0.0, 0.0, -10.0, -50.0, 0, 0, 0 );
			
			switch( GetVehicleModel( vid ) ) 
			{
				case 420: 
					AttachDynamicObjectToVehicle( VehicleJob[vid][v_taxi_text], vid, -0.7, 0.94, 0.33, -0.5, -54, 91);
					
				case 438: 
				    AttachDynamicObjectToVehicle( VehicleJob[vid][v_taxi_text], vid, -1.1, 1.35, -0.02, 0, -24, 90 );
			}
			
			SetDynamicObjectMaterialText( VehicleJob[vid][v_taxi_text], 0, g_string, OBJECT_MATERIAL_SIZE_256x128, "Arial", 14, 1, 0xFFFFFFFF, 0, 0 );
			
			format:g_small_string( "установил%s тариф", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Тариф установлен." );
			
			if( Player[playerid][uSettings][0] )
			{
				PlayerTextDrawShow( playerid, Taximeter[playerid] );
				TextDrawShowForPlayer( playerid, TaxiBackground );
			}
			
			format:g_small_string( taxi_dialog, !VehicleJob[vid][v_rate] ? ("Установить") : ("Снять") );
			showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
		}
		
		case d_taxi + 4:
		{
			if( !response ) 
			{
				format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
				return showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
			}
			
			VehicleJob[Job[playerid][j_vehicleid]][v_rate] = 0;
			DestroyDynamicObject( VehicleJob[Job[playerid][j_vehicleid]][v_taxi_text] );
			
			format:g_small_string( "снял%s тариф", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Тариф снят." );
			
			format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
			showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
		}
		
		case d_taxi + 5:
		{
			if( !response )
			{
				format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
				return showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 1 || strval( inputtext ) > 6 )
			{
				return showPlayerDialog( playerid, d_taxi + 5, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменить тариф\n\n\
					"cWHITE"Установите цену за одну милю:\n\n\
					"gbDialog"Минимум $1, максимум $6.\n\n\
					"gbDialogError"Неправильное значение, повторите ввод.",
				"Далее", "Назад" );
			}
			
			if( strval( inputtext ) == VehicleJob[Job[playerid][j_vehicleid]][v_rate] )
			{
				return showPlayerDialog( playerid, d_taxi + 5, DIALOG_STYLE_INPUT, " ", "\
					"cBLUE"Изменить тариф\n\n\
					"cWHITE"Установите цену за одну милю:\n\n\
					"gbDialog"Минимум $1, максимум $6.\n\n\
					"gbDialogError"Такая цена уже установлена.",
				"Далее", "Назад" );
			}
			
			new
				vid = Job[playerid][j_vehicleid];
			
			VehicleJob[vid][v_rate] = strval( inputtext );
			DestroyDynamicObject( VehicleJob[vid][v_taxi_text] );
			
			format:g_string( "Тариф: $%d", VehicleJob[vid][v_rate] );
			
			VehicleJob[vid][v_taxi_text] = CreateDynamicObject( 19477, 0.0, 0.0, -10.0, -50.0, 0, 0, 0 );
			
			switch( GetVehicleModel( vid ) ) 
			{
				case 420: 
					AttachDynamicObjectToVehicle( VehicleJob[vid][v_taxi_text], vid, -0.7, 0.94, 0.33, -0.5, -54, 91);
					
				case 438: 
				    AttachDynamicObjectToVehicle( VehicleJob[vid][v_taxi_text], vid, -1.1, 1.35, -0.02, 0, -24, 90 );
			}
			
			SetDynamicObjectMaterialText( VehicleJob[vid][v_taxi_text], 0, g_string, OBJECT_MATERIAL_SIZE_256x128, "Arial", 14, 1, 0xFFFFFFFF, 0, 0 );
			
			format:g_small_string( "изменил%s тариф", SexTextEnd( playerid ) );
			MeAction( playerid, g_small_string, 1 );
			
			SendClient:( playerid, C_WHITE, ""gbSuccess"Тариф изменен." );
			
			format:g_small_string( taxi_dialog, !VehicleJob[vid][v_rate] ? ("Установить") : ("Снять") );
			showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
		}
		
		//Список заявок такси
		case d_taxi + 6:
		{
			if( !response )
			{
				format:g_small_string( taxi_dialog, !VehicleJob[Job[playerid][j_vehicleid]][v_rate] ? ("Установить") : ("Снять") );
				return showPlayerDialog( playerid, d_taxi + 2, DIALOG_STYLE_LIST, " ", g_small_string, "Выбрать", "Закрыть" );
			}
			
			new
				taxi = g_dialog_taxi[listitem];
				
			if( taxi == INVALID_PARAM )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Эту заявку уже принял кто-то другой." );
				ShowListTaxiCalls( playerid );
				return 1;
			}
				
			g_dialog_taxi[listitem] = INVALID_PARAM;
			
			format:g_small_string( "[CH: %d] Диспетчер: Хорошо, %s, Вас поняла, координаты высланы вам на GPS. Район %s.", 
				CHANNEL_TAXI,
				Player[playerid][uRPName],
				Taxi[taxi][t_zone]
			);
			SendRadioMessage( CHANNEL_TAXI, g_small_string );
			
			SendClient:( Taxi[taxi][t_playerid], C_WHITE, ""gbSuccess"Ваш вызов был принят одним из сотрудников службы такси. Ожидайте машину." );
			
			Job[playerid][j_taxi] = true;
			SetPlayerCheckpoint( playerid, Taxi[taxi][t_pos][0], Taxi[taxi][t_pos][1], Taxi[taxi][t_pos][2], 5.0 );
			
			//VehicleJob[Job[playerid][j_vehicleid]][v_passenger] = Taxi[taxi][t_playerid];
			SetPVarInt( Taxi[taxi][t_playerid], "Taxi:Driver", playerid );
			
			Taxi[taxi][t_playerid] = INVALID_PARAM;
			Taxi[taxi][t_time] = 0;
			
			Taxi[taxi][t_place][0] =
			Taxi[taxi][t_zone][0] = EOS;
		
			Taxi[taxi][t_pos][0] =
			Taxi[taxi][t_pos][1] =	
			Taxi[taxi][t_pos][2] = 0.0;
		}
		
		case d_makeroute:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0:
				{
					showPlayerDialog( playerid, d_makeroute + 1, DIALOG_STYLE_INPUT, " ", "\
						Для добавления чекпоинтов введите номер маршрута:\n\n\
						"gbDefault"Маршруты 353, 454, 675, 893 и 125.", 
					"Далее", "Назад" );
				}
				
				case 1:
				{
					ShowRoutes( playerid );
				}
				
				case 2:
				{
					new
						route = GetPVarInt( playerid, "Job:AddRoute" );

					if( !route )
						return SendClient:( playerid, C_WHITE, ""gbError"Маршрут не выбран!" );
						
					format:g_string( "\
						Установите описание для маршрута "cBLUE"%d"cWHITE":\n\n\
						"gbDialog"Используйте буквы русского или английского алфавита.", Route[ route - 1 ][r_number] );	
						
					showPlayerDialog( playerid, d_makeroute + 4, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );			
				}
			}
		}
		
		case d_mech:
		{
			if( !response )
				return 1;
			
			switch( listitem )
			{
				case 0:
				{
					if( Player[playerid][uJob] != JOB_MECHANIC )
						return SendClient:( playerid, C_GRAY, ""gbError"Вы не работаете на станции технического обслуживания!" );

		            if( !job_duty{playerid} )
					{
						format:g_small_string( "получил%s ключи от рабочего авто", SexTextEnd( playerid ) );
						MeAction( playerid, g_small_string, 1 );

						job_duty{playerid} = 1;

						Player[playerid][uRadioChannel] = CHANNEL_MECHANIC;
						
						if( Player[playerid][uSettings][8] )
						{
							UpdateRadioInfo( playerid, 1 );
						}
						
						SendClient:( playerid, C_WHITE, ""gbSuccess"Вы получили ключи и документы от рабочего транспорта. Стационарная рация настроена на волну "cBLUE"577"cWHITE"." );
					}
		            else
					{	
						clean:<g_string>;
					
						DisablePlayerCheckpoint( playerid );

						format:g_small_string( "\
							"gbSuccess"Рабочий день на станции технического обслуживания завершен.\n\
							Вы заработали "cBLUE"$%d"cWHITE". Деньги перечислены на чековую книжку.", 
							Job[playerid][j_earn] );
						strcat( g_string, g_small_string );

						if( Premium[playerid][prem_salary] )
						{
							new
								prem_pay = floatround( Job[playerid][j_earn] * Premium[playerid][prem_salary]/100 );
							
							if( prem_pay )
							{
								format:g_small_string( "\n\n\
									"cGREEN"+ $%d"cGRAY" к заработанной сумме ["cBLUE"Премиум"cGRAY"]",  
									prem_pay );
								strcat( g_string, g_small_string );
							
								Player[playerid][uCheck] += prem_pay;
							}
						}
							
						showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Рабочий день", g_string, "Закрыть", "" );
						UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
						
						Job[playerid][j_earn] = 
						job_duty{playerid} = 0;
		            }
				}
				
				case 1:
				{
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", job_description_mech, "Закрыть", "" );
		        }

		        case 2:
				{
					if( Player[playerid][uLevel] < 2 )
						return SendClient:( playerid, C_GRAY, ""gbError"Ваш уровень не позволяет устроиться на эту работу." );
				
					showPlayerDialog( playerid, d_mech + 1, DIALOG_STYLE_MSGBOX, " ", "\
						"cBLUE"Трудовой контракт\n\n\
						"cWHITE"Вы заключаете шестичасовой трудовой контракт на должность "cBLUE"механика.\n\
						"gbDialogError"Заблаговременно расторгнуть трудовой контракт нельзя.\n\n\
						"cWHITE"Желаете продолжить?",
					"Да", "Нет" );
		        }
			}
		}
		
		case d_mech + 1:
		{
			if( !response )
			{
				if( Player[playerid][uJob] == JOB_MECHANIC )
				{
					format:g_string( "\
						"cBLUE"1. "cWHITE"%s рабочий день\n\
						"cBLUE"2. "cWHITE"Ознакомиться с работой\n\
						"cBLUE"3. "cWHITE"Устроиться на работу", job_duty{playerid} ? ( "Завершить" ) : ( "Начать" ) );
				}
				else
				{
					format:g_string( "\
						"cBLUE"1. "cWHITE"Начать рабочий день\n\
						"cBLUE"2. "cWHITE"Ознакомиться с работой\n\
						"cBLUE"3. "cWHITE"Устроиться на работу" );
				}
				return showPlayerDialog( playerid, d_mech, DIALOG_STYLE_LIST, "Станция тех. обслуживания", g_string, "Выбрать", "Закрыть" );
			}
			
			if( Player[playerid][uMember] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы не можете устроиться на эту работу." );

		    if( Player[playerid][uJob] )
				return SendClient:( playerid, C_WHITE, ""gbError"Вы уже устроены на работу!" );

            if( !GetStatusPlayerLicense( playerid, LICENSE_DRIVE ) )
				return SendClient:( playerid, C_WHITE, ""gbError"Для устройства на работу необходимо водительское удостоверение!");

			if( !getItem( playerid, INV_SPECIAL, PARAM_CARD ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У Вас отсутствует ID-карта." );

			Player[playerid][uJob] = JOB_MECHANIC;
		    UpdatePlayer( playerid, "uJob", Player[playerid][uJob] );

			Job[playerid][j_time] = gettime() + 21600;
			UpdatePlayer( playerid, "uJobTime", Job[ playerid ][j_time] );

		    SendClient:( playerid, C_WHITE, ""gbSuccess"Вы подписали контракт в должности механика на 6 часов." );

			MeAction( playerid, "устраивается на работу", 1 );
		}
		
		case d_mech + 2:
		{
			new
				driverid = GetPVarInt( playerid, "Mech:Driverid" ),
				vid = GetPVarInt( playerid, "Mech:Vid" ),
				vmodel = Vehicle[vid][vehicle_model];
			
			if( !response )
			{
				SendClient:( playerid, C_WHITE, ""gbSuccess"Вы отказались от услуг эвакуатора." );
				
				if( IsLogged( driverid ) )
				{
					pformat:( ""gbError"Клиент отказался от эвакуации "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( driverid, C_WHITE );
				}
				
				DeletePVar( playerid, "Mech:Driverid" );
				DeletePVar( playerid, "Mech:Vid" );
				return 1;
			}
			
			if( !IsLogged( driverid ) )
			{
				SendClient:( playerid, C_WHITE, ""gbError"В данный момент эвакуатор не может отбуксировать Ваш транспорт." );
			
				DeletePVar( playerid, "Mech:Driverid" );
				DeletePVar( playerid, "Mech:Vid" );
				return 1;
			}
			
			pformat:( ""gbSuccess"Вы согласились на эвакуацию "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
			psend:( playerid, C_WHITE );
			
			pformat:( ""gbSuccess"Клиент согласен на эвакуацию "cBLUE"%s"cWHITE", используйте "cBLUE"/tow"cWHITE" повторно.", GetVehicleModelName( vmodel ) );
			psend:( driverid, C_WHITE );
			
			SetPVarInt( driverid, "Mech:Vid", vid );
			
			DeletePVar( playerid, "Mech:Driverid" );
			DeletePVar( playerid, "Mech:Vid" );
		}
		
		case d_mech + 3:
		{
			if( !response )
				return 1;
				
			new
				mech = g_dialog_mech[listitem];
				
			if( mech == INVALID_PARAM )
			{
				SendClient:( playerid, C_WHITE, ""gbError"Эту заявку взял кто-то другой." );
				ShowListMechCalls( playerid );
				return 1;
			}
				
			g_dialog_mech[listitem] = INVALID_PARAM;
			
			format:g_small_string( "[CH: %d] Диспетчер: Хорошо, %s, Вас поняла, координаты высланы вам на GPS. Район %s.", 
				CHANNEL_MECHANIC,
				Player[playerid][uRPName],
				Mechanic[mech][m_zone]
			);
			SendRadioMessage( CHANNEL_MECHANIC, g_small_string );
			
			SendClient:( Mechanic[mech][m_playerid], C_WHITE, ""gbSuccess"Ваш вызов был принят одним из механиков СТО. Ожидайте эвакуатор." );
			
			Job[playerid][j_mech] = true;
			SetPlayerCheckpoint( playerid, Mechanic[mech][m_pos][0], Mechanic[mech][m_pos][1], Mechanic[mech][m_pos][2], 5.0 );
			
			SetPVarInt( playerid, "Mech:Callid", Mechanic[mech][m_playerid] );
			SetPVarInt( playerid, "Mech:Accept", 1 );
			
			Mechanic[mech][m_playerid] = INVALID_PARAM;
			Mechanic[mech][m_time] = 0;
			
			Mechanic[mech][m_place][0] =
			Mechanic[mech][m_zone][0] = EOS;
		
			Mechanic[mech][m_pos][0] =
			Mechanic[mech][m_pos][1] =	
			Mechanic[mech][m_pos][2] = 0.0;
		}
		
		case d_mech + 4:
		{
			new
				driverid = GetPVarInt( playerid, "Repair:Driverid" ),
				vid = GetPVarInt( playerid, "Repair:Vid" ),
				part = GetPVarInt( playerid, "Repair:Part" ),
				vmodel = Vehicle[vid][vehicle_model],
				price,
				earn,
				Float:pX,
				Float:pY,
				Float:pZ;
				
			if( !response )
			{
				SendClient:( playerid, C_WHITE, ""gbSuccess"Вы отказались от ремонта." );
				
				if( IsLogged( driverid ) )
				{
					pformat:( ""gbError"Клиент отказался от ремонта "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( driverid, C_WHITE );
				}
				
				DeletePVar( playerid, "Repair:Driverid" );
				DeletePVar( playerid, "Repair:Vid" );
				DeletePVar( playerid, "Repair:Part" );
				DeletePVar( driverid, "Mech:VId" );
				return 1;
			}
			
			GetPlayerPos( driverid, pX, pY, pZ );
			
			if( !IsLogged( driverid ) || GetVehicleDistanceFromPoint( vid, pX, pY, pZ ) > 4.0 )
			{
				SendClient:( playerid, C_WHITE, ""gbError"В данный момент механик не может заняться ремонтом Вашего автомобиля." );
			
				DeletePVar( playerid, "Repair:Driverid" );
				DeletePVar( playerid, "Repair:Vid" );
				DeletePVar( playerid, "Repair:Part" );
				DeletePVar( driverid, "Mech:VId" );
				return 1;
			}
			
			
			switch( part )
			{
				case 0:
				{
					price =  floatround( float( GetVehiclePrice( Vehicle[vid][vehicle_model] ) ) / 100 * REPAIR_MECH_ENGINE );
					
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
						SendClient:( driverid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
					
						DeletePVar( playerid, "Repair:Driverid" );
						DeletePVar( playerid, "Repair:Vid" );
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( driverid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за капитальный ремонт двигателя "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					pformat:( ""gbSuccess"Вы произвели капитальный ремонт двигателя "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( driverid, C_WHITE );
					
					Vehicle[vid][vehicle_engine] = 100.0;
					
					Vehicle[vid][vehicle_engine_date] = gettime();
					UpdateVehicle( vid, "vehicle_engine_date", Vehicle[vid][vehicle_engine_date] );
				}
				
				case 1:
				{
					price =  floatround( float( GetVehiclePrice( Vehicle[vid][vehicle_model] ) ) / 100 * REPAIR_MECH_BODY );
					
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
						SendClient:( driverid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
					
						DeletePVar( playerid, "Repair:Driverid" );
						DeletePVar( playerid, "Repair:Vid" );
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( driverid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за ремонт кузова "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					pformat:( ""gbSuccess"Вы отремонтировали кузов "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( driverid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][1] = 0;
					Vehicle[vid][vehicle_damage][0] = 0;
				}
				
				case 2:
				{
					price =  floatround( float( GetVehiclePrice( Vehicle[vid][vehicle_model] ) ) / 100 * REPAIR_MECH_LIGHT );
					
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
						SendClient:( driverid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
					
						DeletePVar( playerid, "Repair:Driverid" );
						DeletePVar( playerid, "Repair:Vid" );
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( driverid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за замену фар "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					pformat:( ""gbSuccess"Вы заменили фары "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( driverid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][2] = 0;
				}
				
				case 3:
				{
					price =  floatround( float( GetVehiclePrice( Vehicle[vid][vehicle_model] ) ) / 100 * REPAIR_MECH_WHEELS );
					
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
						SendClient:( driverid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
					
						DeletePVar( playerid, "Repair:Driverid" );
						DeletePVar( playerid, "Repair:Vid" );
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( driverid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за замену покрышек "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					pformat:( ""gbSuccess"Вы заменили покрышки "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( driverid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][3] = 0;
				}
				
				case 4:
				{
					price =  floatround( float( GetVehiclePrice( Vehicle[vid][vehicle_model] ) ) / 100 * REPAIR_MECH_COMPLEX);
										
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
						SendClient:( driverid, C_WHITE, ""gbError"У владельца недостаточно денег для оплаты ремонта." );
					
						DeletePVar( playerid, "Repair:Driverid" );
						DeletePVar( playerid, "Repair:Vid" );
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( driverid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за комплексный ремонт "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					pformat:( ""gbSuccess"Вы произвели комплексный ремонт "cBLUE"%s"cWHITE".", GetVehicleModelName( vmodel ) );
					psend:( driverid, C_WHITE );
					
					RepairVehicle( vid );
				}
			}
			
			SetVehicleDamageStatus( vid );
			setVehicleHealthEx( vid );
			
			SetPlayerCash( playerid, "-", price );
			
			earn = floatround( float( price ) / 100 * 2 );
			Job[driverid][j_earn] += earn;
			Player[driverid][uCheck] += earn;
			UpdatePlayer( driverid, "uCheck", Player[driverid][uCheck] );
			
			DeletePVar( playerid, "Repair:Driverid" );
			DeletePVar( playerid, "Repair:Vid" );
			DeletePVar( playerid, "Repair:Part" );
			DeletePVar( driverid, "Mech:VId" );
		}
		
		case d_mech + 5:
		{
			if( !response ) 
			{
				DeletePVar( playerid, "Mech:VId" );
				return 1;
			}
			
			new
				repairid = INVALID_PARAM,
				vid = GetPVarInt( playerid, "Mech:VId" );
				
			foreach(new i : Player)
			{
				if( !IsLogged( i ) )
					continue;
				
				if( Vehicle[vid][vehicle_user_id] == Player[i][uID] )
				{
					repairid = i;
					break;
				}
			}
			
			RepairPartVehicle( playerid, repairid, vid, listitem );
		}
		
		//Ремонт механика своего личного авто
		case d_mech + 9:
		{
			if( !response )
			{
				DeletePVar( playerid, "Mech:VId" );
				DeletePVar( playerid, "Repair:Part" );
				return 1;
			}
			
			new
				part = GetPVarInt( playerid, "Repair:Part" ),
				price,
				vid = GetPVarInt( playerid, "Mech:VId" ),
				vmodel = Vehicle[vid][vehicle_model];
			
			switch( part )
			{
				case 0:
				{
					price =  floatround( float( GetVehiclePrice( vmodel ) ) / 100 * REPAIR_MECH_ENGINE );
					
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
					
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( playerid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за капитальный ремонт двигателя "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					Vehicle[vid][vehicle_engine] = 100.0;
					
					Vehicle[vid][vehicle_engine_date] = gettime();
					UpdateVehicle( vid, "vehicle_engine_date", Vehicle[vid][vehicle_engine_date] );
				}
				
				case 1:
				{
					price =  floatround( float( GetVehiclePrice( vmodel ) ) / 100 * REPAIR_MECH_BODY );
					
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );

						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( playerid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за ремонт кузова "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][1] = 0;
					Vehicle[vid][vehicle_damage][0] = 0;
				}
				
				case 2:
				{
					price =  floatround( float( GetVehiclePrice( vmodel ) ) / 100 * REPAIR_MECH_LIGHT );
					
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
					
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( playerid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за замену фар "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][2] = 0;
				}
				
				case 3:
				{
					price =  floatround( float( GetVehiclePrice( vmodel ) ) / 100 * REPAIR_MECH_WHEELS );
					
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
					
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( playerid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за замену покрышек "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					Vehicle[vid][vehicle_damage][3] = 0;
				}
				
				case 4:
				{
					price =  floatround( float( GetVehiclePrice( vmodel ) ) / 100 * REPAIR_MECH_COMPLEX );
										
					if( Player[playerid][uMoney] < price )
					{
						SendClient:( playerid, C_WHITE, !NO_MONEY );
					
						DeletePVar( playerid, "Repair:Part" );
						DeletePVar( playerid, "Mech:VId" );
						return 1;
					}
					
					pformat:( ""gbSuccess"Вы заплатили "cBLUE"$%d"cWHITE" за комплексный ремонт "cBLUE"%s"cWHITE".", price, GetVehicleModelName( vmodel ) );
					psend:( playerid, C_WHITE );
					
					RepairVehicle( vid );
					
					for( new i; i < 4; i++ )
						Vehicle[vid][vehicle_damage][i] = 0;
				}
			}
			
			SetVehicleDamageStatus( vid );
			setVehicleHealthEx( vid );
			
			SetPlayerCash( playerid, "-", price );
			
			DeletePVar( playerid, "Repair:Part" );
			DeletePVar( playerid, "Mech:VId" );
		}
		
		case d_wood:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0:
				{
					if( Player[playerid][uMember] )
					{
						return SendClient:( playerid, C_WHITE, ""gbError"Ваш социальный статус не позволяет Вам работать здесь." );
					}
					
					if( Player[playerid][uJob] )
					{
						return SendClient:( playerid, C_WHITE, ""gbError"Вы уже устроены на работу." );
					}
				
					if( !job_duty{playerid} )
					{
						SendClient:( playerid, C_WHITE, ""gbSuccess"Вы получили рабочий инструмент и одежду. Подойдите к дереву для его первичной обработки." );
						
						switch( Player[playerid][uSex] )
						{
							case 1:	
							{
								if( Player[playerid][uColor] == 2 )
								{
									SetPlayerSkin( playerid, 27 );
								}
								else
								{
									SetPlayerSkin( playerid, 260 );
								}
							}
							
							case 2:
							{
								SetPlayerSkin( playerid, 157 );
							}
						}
						
						RemovePlayerAttachedObject( playerid, 9 );
						SetPlayerAttachedObject( playerid, 9, 341, 6 );
					
						Job[playerid][j_earn] = 0;
						job_duty{playerid} = 1;
						
						SetPVarInt( playerid, "Job:Wood", 1 );
					}
					else
					{
						clean:<g_string>;
					
						RemovePlayerAttachedObject( playerid, 9 );
					
						SetPlayerSkin( playerid, setUseSkin( playerid, true ) );
					
						format:g_small_string( ""gbSuccess"Рабочий день в лесном хозяйстве завершен. Вы заработали "cBLUE"$%d"cWHITE". Деньги перечислены на чековую книжку.", Job[playerid][j_earn] );
						strcat( g_string, g_small_string );
						
						if( Premium[playerid][prem_salary] )
						{
							new
								prem_pay = floatround( Job[playerid][j_earn] * Premium[playerid][prem_salary]/100 );
							
							if( prem_pay )
							{
								format:g_small_string( "\n\n\
									"cGREEN"+ $%d"cGRAY" к заработанной сумме ["cBLUE"Премиум"cGRAY"]",  
									prem_pay );
								strcat( g_string, g_small_string );
							
								Player[playerid][uCheck] += prem_pay;
							}
						}
						
						showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Рабочий день", g_string, "Закрыть", "" );
						UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
						
						Job[playerid][j_earn] = 
						job_duty{playerid} = 0;
						
						DeletePVar( playerid, "Job:Wood" );
					}
					
				}
				
				case 1:
				{
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", job_description_wood, "Закрыть", "" );
				}
			}
		}
		
		case d_food:
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0: //Начать или завершить рабочий день
				{
					if( Player[playerid][uMember] )
					{
						return SendClient:( playerid, C_WHITE, ""gbError"Ваш социальный статус не позволяет Вам работать здесь." );
					}
					
					if( Player[playerid][uJob] && Player[playerid][uJob] != JOB_FOOD )
					{
						return SendClient:( playerid, C_WHITE, ""gbError"Вы уже устроены на работу." );
					}
				
					if( !job_duty{playerid} )
					{
						SendClient:( playerid, C_WHITE, ""gbSuccess"Вы начали рабочий день в службе доставки, возьмите заказ." );
						
						switch( Player[playerid][uSex] )
						{
							case 1:	
							{
								SetPlayerSkin( playerid, 155 );
							}
							
							case 2:
							{
								SetPlayerSkin( playerid, 205 );
							}
						}
					
						Player[playerid][uJob] = JOB_FOOD;
						Job[playerid][j_earn] = 0;
						job_duty{playerid} = 1;
					}
					else
					{
						clean:<g_string>;
					
						RemovePlayerAttachedObject( playerid, 9 );
					
						SetPlayerSkin( playerid, setUseSkin( playerid, true ) );
					
						format:g_small_string( ""gbSuccess"Рабочий день в службе доставки завершен. Вы заработали "cBLUE"$%d"cWHITE". Все деньги находятся на чековой книжке.", Job[playerid][j_earn] );
						strcat( g_string, g_small_string );
						
						if( Premium[playerid][prem_salary] )
						{
							new
								prem_pay = floatround( Job[playerid][j_earn] * Premium[playerid][prem_salary]/100 );
							
							if( prem_pay )
							{
								format:g_small_string( "\n\n\
									"cGREEN"+ $%d"cGRAY" к заработанной сумме ["cBLUE"Премиум"cGRAY"]", 
									prem_pay );
								strcat( g_string, g_small_string );
							
								Player[playerid][uCheck] += prem_pay;
							}
						}
						
						if( GetPVarInt( playerid, "Job:Food" ) )
						{
							strcat( g_string, "\n\n"cRED"- $20"cGRAY" за отказ от доставки заказа клиенту" );
							Player[playerid][uCheck] -= 20;
						}
						
						showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Рабочий день", g_string, "Закрыть", "" );
						UpdatePlayer( playerid, "uCheck", Player[playerid][uCheck] );
						
						Job[playerid][j_earn] = 
						Player[playerid][uJob] =
						job_duty{playerid} = 0;
						
						DeletePVar( playerid, "Job:Food" );
						DeletePVar( playerid, "Job:FoodSpeed" );
						DeletePVar( playerid, "Job:FoodHouse" );
					}
				}
				
				case 1: //Взять заказ на доставку
				{
					if( Player[playerid][uJob] != JOB_FOOD || !job_duty{playerid} )
					{
						return SendClient:( playerid, C_WHITE, ""gbError"Вы не работаете в службе доставки." );
					}
					
					if( GetPVarInt( playerid, "Job:Food" ) )
					{
						return SendClient:( playerid, C_WHITE, ""gbError"Вы уже взяли заказ на доставку еды." );
					}
					
					RemovePlayerAttachedObject( playerid, 9 );
					switch( Player[playerid][uSex] )
					{
						case 1:	
						{
							SetPlayerAttachedObject( playerid, 9, 19571, 5, 0.463, 0.013, 0.0, 0.5, -93.7, 23.8, 0.928, 1.0, 0.93 );
						}
							
						case 2:
						{
							SetPlayerAttachedObject( playerid, 9, 2814, 5, 0.279, 0.004, 0.0, 0.0, -98.6, 22.8, 1.0, 0.657, 0.845 );
						}
					}
					
					new
						speed = random( 15 ),
						house = random( COUNT_HOUSES );
					
					SendClient:( playerid, C_WHITE, !""gbDefault"Вы взяли заказ на доставку еды клиенту. Место отмечено на Вашем GPS-навигаторе." );
					SetPVarInt( playerid, "Job:Food", _: SetPlayerCheckpoint( playerid, HouseInfo[house][hEnterPos][0], HouseInfo[house][hEnterPos][1], HouseInfo[house][hEnterPos][2], 1.0 ) );
					SetPVarInt( playerid, "Job:FoodHouse", house );
					
					if( speed == 11 )
					{
						SendClient:( playerid, C_WHITE, !""gbDialog"Вы получите "cBLUE"+ 20 %%"cGRAY" за срочность, если доставите этот заказ в течении минуты." );
						SetPVarInt( playerid, "Job:FoodSpeed", 60  );
					}
					
					SendClient:( playerid, C_WHITE, !""gbDefault"В случае отказа от доставки заказа Вы получите штраф в размере "cRED"$20"cWHITE"." );
				}
				
				case 2:
				{
					showPlayerDialog( playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, " ", job_description_food, "Закрыть", "" );
				}
			}
		}
		
		case d_makeroute + 1:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_makeroute, DIALOG_STYLE_LIST, " ", "\
					Добавить чекпоинты\n\
					Удалить маршрут\n\
					Добавить описание", 
				"Выбрать", "Закрыть" );
			}
			
			if( inputtext[0] == EOS || !IsNumeric( inputtext ) || strval( inputtext ) < 0 )
			{
				return showPlayerDialog( playerid, d_makeroute + 1, DIALOG_STYLE_INPUT, " ", "\
					Для добавления чекпоинтов введите номер маршрута:\n\n\
					"gbDefault"Маршруты 353, 454, 675, 893 и 125.\n\n\
					"gbDialogError"Неправильный формат значения, повторите ввод!", 
				"Далее", "Назад" );
			}
			
			new
				bool:status = false;
			
			for( new i; i < sizeof routes; i++ )
			{
				if(  routes[i] == strval( inputtext ) )
				{
					SetPVarInt( playerid, "Job:AddRoute", i + 1 );
					status = true;
				}
			}
			
			if( status == false )
			{
				return
					showPlayerDialog( playerid, d_makeroute + 1, DIALOG_STYLE_INPUT, " ", "\
						Для добавления чекпоинтов введите номер маршрута:\n\n\
						"gbDefault"Маршруты 353, 454, 675, 893 и 125.\n\n\
						"gbDialogError"Такого маршрута нет!", 
					"Далее", "Назад" );
			}
			
			Route[GetPVarInt( playerid, "Job:AddRoute" ) - 1][r_number] = strval( inputtext );
			
			pformat:( ""gbSuccess"Для добавления чекпоинта маршруту "cBLUE"#%d"cWHITE" используйте "cBLUE"/ap [ параметр ]"cWHITE".", strval( inputtext ) );
			psend:( playerid, C_WHITE );
		}
		
		case d_makeroute + 2:
		{
			if( !response ) 
			{
				return showPlayerDialog( playerid, d_makeroute, DIALOG_STYLE_LIST, " ", "\
					Добавить чекпоинты\n\
					Удалить маршрут\n\
					Добавить описание", 
				"Выбрать", "Закрыть" );
			}
			
			SetPVarInt( playerid, "Job:DelRoute", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			format:g_small_string( "\
				Вы действительно хотите удалить маршрут "cBLUE"#%d"cWHITE"?", Route[GetPVarInt( playerid, "Job:DelRoute" )][r_number] );
				
			showPlayerDialog( playerid, d_makeroute + 3, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		}
		
		case d_makeroute + 3:
		{
			if( !response ) return ShowRoutes( playerid );
			
			new
				route = GetPVarInt( playerid, "Job:DelRoute" );
				
			DeleteRoute( route );
			
			pformat:( ""gbSuccess"Маршрут "cBLUE"%d"cWHITE" удален!", Route[route][r_number] );
			psend:( playerid, C_WHITE );
			
			for( new i; i < MAX_CHECKPOINTS; i++ )
			{
				if( Bus[route][i][r_route] == Route[route][r_number] )
				{
					Bus[route][i][r_id] =
					Bus[route][i][r_route] = 
					Bus[route][i][r_param] = 0;
					
					Bus[route][i][r_pos][0] = 
					Bus[route][i][r_pos][1] = 
					Bus[route][i][r_pos][2] = 0.0;
				}	
			}
			
			Route[route][r_number] = 
			Route[route][r_point] = 0;
			
			if( GetPVarInt( playerid, "Job:AddRoute" ) )
				DeletePVar( playerid, "Job:AddRoute" );
				
			DeletePVar( playerid, "Job:DelRoute" );
		}
		
		case d_makeroute + 4:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_makeroute, DIALOG_STYLE_LIST, " ", "\
					Добавить чекпоинты\n\
					Удалить маршрут\n\
					Добавить описание", 
				"Выбрать", "Закрыть" );
			}
			
			new
				route = GetPVarInt( playerid, "Job:AddRoute" ); 
			
			if( inputtext[0] == EOS )
			{
				format:g_string( "\
					Установите описание для маршрута "cBLUE"%d"cWHITE":\n\n\
					"gbDialog"Используйте буквы русского или английского алфавита.\n\n\
					"gbDialogError"Поле для ввода не должно быть пустым.", Route[ route - 1 ][r_number] );	
						
				return	showPlayerDialog( playerid, d_makeroute + 4, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );	
			}
			
			if( strlen( inputtext ) > 32 )
			{
				format:g_string( "\
					Установите описание для маршрута "cBLUE"%d"cWHITE":\n\n\
					"gbDialog"Используйте буквы русского или английского алфавита.\n\n\
					"gbDialogError"Превышено допустимое количество символов.", Route[ route - 1 ][r_number] );	
						
				return	showPlayerDialog( playerid, d_makeroute + 4, DIALOG_STYLE_INPUT, " ", g_string, "Далее", "Назад" );
			}
			
			AddDescriptionRoute( route - 1, inputtext );
			
			pformat:( ""gbSuccess"Вы установили описание маршруту "cBLUE"%d"cWHITE".", Route[ route - 1 ][r_number] );
			psend:( playerid, C_WHITE );
		}
	}
	return 1;
}