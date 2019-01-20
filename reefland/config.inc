// -- Main
#define GGAME_VERSION						"Reefland 1.0"
#define GGAME_VERSION_AC					"RAC 1.1"
#define GGAME_DESCRIPTION					"Описание проекта"

//#define DEBUG Включаем после выхода глобального обновления.

// -- Settings

#define ANTICHEAT_MIN_ADMIN_LEVEL			( 1 )
#define ANTICHEAT_EXCEPTION_TIME			( 10 ) // Исключение античита
#define ANTICHEAT_EXCEPTION_CARSHOT			( 2 ) // Исключение античита

#define BENEFIT_VALUE						( 100 ) // Пособие по безработице
#define BENEFIT_NORANK						( 200 ) // Зарплата без ранга

#define DELETE_CAR_VALUE					( 900 ) // Удаление личного транспорта при выходе ( 900 = 15 минут )

// -- Tables
#define DB_USERS							"gb_users"
#define DB_ADMINS               			"gb_admins"
#define DB_PERMISSIONS          			"gb_permissions"
#define DB_SUPPORTS             			"gb_supports"
#define DB_ADMIN_LOGS           			"gb_admin_logs"
#define DB_BANS                 			"gb_bans"
#define DB_INVENTORY						"gb_inventory"
#define DB_IPBANS							"gb_ipbans"
#define DB_VEHICLES							"gb_vehicles"
#define DB_ITEMS							"gb_items"
#define DB_SESSIONS							"gb_sessions"
#define DB_FRACTIONS						"gb_fractions"
#define DB_ENTERS							"gb_enters"
#define DB_ENTERS_INSIDE					"gb_enters_inside"
#define DB_LICENSES							"gb_licenses"
#define DB_APPLICATION						"gb_licenses_apply"
#define DB_LOGS								"gb_logs"
#define DB_ANTICHEAT_LOGS					"gb_anticheat_logs"
#define DB_BUSINESS							"gb_business"
#define DB_BUSINESS_FURN					"gb_business_furn"
#define DB_HOUSE_FURN						"gb_house_furn"
#define DB_HOUSE							"gb_houses"
#define DB_BUSINESS_ITEMS					"gb_business_items"
#define DB_SERVER							"gb_server"
#define DB_BUSINESS_ORDERS					"gb_business_orders"
#define DB_ROUTES							"gb_routes"
#define DB_ROUTES_DESCRIPT					"gb_routes_descript"
#define DB_PHONES							"gb_phones"
#define DB_PHONES_CONTACTS					"gb_phones_contacts"
#define DB_PHONES_MESSAGES					"gb_phones_messages"
#define DB_RANKS							"gb_ranks"
#define DB_FRAC_INFO						"gb_frac_info"
#define DB_PENALTIES						"gb_penalties"
#define DB_VEHICLES_ARREST					"gb_vehicles_arrest"
#define DB_SAN								"gb_san"
#define DB_SUSPECT							"gb_suspect"
#define DB_SUSPECT_VEHICLE					"gb_suspect_vehicle"
#define DB_RECOURSE							"gb_recourse"
#define DB_DOCUMENT							"gb_document"
#define DB_PRISON							"gb_prison"
#define DB_CRIME							"gb_crime"
#define DB_CRIME_RANKS						"gb_crime_ranks"
#define DB_CRIME_GUNDEALER					"gb_crime_gundealer"
#define DB_CRIME_ORDER						"gb_crime_order"
#define DB_PREMIUM							"gb_premium"

// -- Colors
#define C_PURPLE							( 0xC2A2DAFF )
#define C_LIGHTRED          				( 0xFF6347AA )
#define C_LIGHTGREEN 						( 0x9ACD32AA )
#define C_YELLOW                			( 0xFFFF00AA )
#define C_GRAY 								( 0xAFAFAFAA )
#define C_DARKGRAY              			( 0x989898FF )
#define C_GREEN 							( 0x46BD38FF )
#define C_PINK 								( 0xE75480FF )
#define C_RED 								( 0xE05A5AFF )
#define C_DARKRED 							( 0xAA3333AA )
#define C_WHITE 							( 0xFFFFFFFF )
#define C_TAXI 								( 0xFFCC00FF )
//#define C_BLUE                  			( 0x4A86B6FF ) -- Старый цвет
#define C_BLUE                  			( 0x1E9999FF )
#define C_ORANGE                			( 0xFF9945FF )
#define C_LIGHTORANGE           			( 0xDEB047FF )
#define C_OPACITY_GRAY						( 0xD0D0D0AA )
#define C_LIGHTBLUE							( 0xCCDCFFAA )
#define C_LIGHTBLUE_TWO						( 0xC2CEEAAA )

#define COLOR_FADE1            				( 0xE6E6E6E6 )
#define COLOR_FADE2             			( 0xC8C8C8C8 )
#define COLOR_FADE3             			( 0xAAAAAAAA )
#define COLOR_FADE4             			( 0x8C8C8C8C )
#define COLOR_FADE5             			( 0x6E6E6E6E )
 
#define cPURPLE								"{C2A2DA}"
#define cYELLOW                 			"{FFFF00}"
#define cGRAY                   			"{AFAFAF}"
#define cPINK                   			"{E75480}"
#define cWHITE                  			"{FFFFFF}"
#define cTAXI                   			"{FFCC00}"
#define cDARKGRAY              	 			"{989898}"
//#define cBLUE                 			"{4a86b6}" -- Старый цвет
#define cBLUE                 				"{04cabf}"
#define cDARKRED							"{AA3333}"
#define cRED                  				"{E05A5A}"
#define cGREEN                				"{46BD38}"
#define cORANGE								"{FF9945}"
#define cDARKORANGE             			"{DEB047}"

// -- TextDraw Colors
//#define td_cBLUE							( 945389823 ) -- Старый цвет
#define td_cBLUE							( 0x1E9999FF )
#define td_cGREEN							( 1166829567 )
#define td_cWHITE							( -1 )

// -- Chat
#define gbError                 			""cRED"* "cWHITE""
#define gbSuccess                			""cGREEN"* "cWHITE""
#define gbDefault               			""cGRAY"* "cWHITE""
#define gbDialog							""cGRAY"* "
#define gbDialogError						""cRED"* "
#define gbDialogSuccess						""cGREEN"* "
#define gbPhone								""cGRAY"[Телефон] "
#define gbRadio								""cWHITE"[Рация] "
#define gbVehicle							""cWHITE"[Транспорт] "

#define ADMIN_PREFIX            			"[A]"
#define SUPPORT_PREFIX          			"[S]"
#define FRACTION_PREFIX						"[F]"
#define DEPARTMENT_PREFIX					"[D]"

// -- Dialogs ID
#define d_auth                  			( 30 )
#define d_death           					( 60 )
#define d_menu                  			( 90 )
#define d_bank                  			( 260 )
#define d_house                 			( 310 )
#define d_a_menu                			( 430 )
#define d_buy_menu              			( 460 )
#define d_fpanel							( 500 )
#define d_fill                  			( 600 )
#define d_frac                  			( 630 )
#define d_medical               			( 700 )
#define d_cnn                   			( 710 )
#define d_licenses              			( 740 )
#define d_admin                 			( 760 )
#define d_support							( 800 )
#define d_mebelbuy              			( 830 )
#define d_fire	                			( 860 )
#define d_gps 								( 890 )
#define d_meria                 			( 910 )
#define d_target                			( 940 )
#define d_buy_menu_select          			( 980 )
#define d_salon                 			( 1000 )
#define d_tune	                 			( 1050 )
#define d_repair                			( 1100 )
#define d_help                 				( 1010 )
#define d_police							( 1100 )
#define d_radio           					( 1400 )
#define d_donate                			( 1500 )
#define d_carjack               			( 1600 )
#define d_priton                			( 1700 )
#define d_mdc                   			( 1900 )
#define d_spec             					( 2100 )
#define d_makeleader            			( 2200 )
#define d_makeroute	            			( 2250 )
#define d_apartment             			( 2300 )
#define d_enterfrac             			( 2400 )
#define d_checkdamages          			( 2450 )
#define d_accept                			( 2540 )
#define d_fobject	            			( 2580 )
#define d_anim                 	 			( 3020 )
#define d_crime								( 3070 )
#define d_cars								( 3400 )
#define d_prison							( 3500 )
#define d_prison_duty						( 3995 )
#define d_arrest							( 4000 )
#define d_house_panel           			( 4050 )
#define d_business_panel					( 4400 )
#define	d_inv  								( 4500 )
#define d_buy_business						( 4550 )
#define	d_inv_settings 						( 5570 )
#define	d_inv_attach 						( 5600 )
#define d_attach							( 5700 )
#define d_commands							( 6000 )
#define d_daln								( 6100 )
#define d_bus								( 6130 )
#define d_wood								( 6140 )
#define d_taxi								( 6160 )
#define d_mech								( 6170 )
#define d_phone								( 6180 )
#define d_food								( 6220 )
#define d_fish								( 6230 )

// -- Prepare Coords
#define RANGE_ADD_ADVERT					1670.8842, -1646.3506, 698.9738
#define RANGE_DE_MORGAN						3958.6768, -942.3129, 3.8427
#define RANGE_CAR_ARREST_1					1524.1223, -1481.3204, 9.5070
#define RANGE_CAR_ARREST_2					1509.8217, -1474.7585, 9.5170

// -- Pickups
#define PICKUP_FURNITURE					-489.8045, -262.2372, 3095.8960
#define PICKUP_SALON						1490.7559, 764.9916, 2001.0859
#define PICKUP_UTILIZATION					1333.8860, 396.6924, 19.7529
#define PICKUP_LICENSES						1494.8933, 1375.8115, 3116.3240
#define PICKUP_PARKING						-1551.4991, 1503.2120, 2001.0869
#define PICKUP_NETWORK						1671.2676, -1646.3319, 1701.9729
#define PICKUP_RECEPTION					1484.9921, -1744.5530, 3910.0859
#define PICKUP_WEAPON						-1503.8457, 95.5487, 3201.9858
#define PICKUP_POLICE						1543.4025, -1680.0443, 2494.2449
#define PICKUP_POLICE_2						-138.8494, -1874.2231, 2501.0859
#define PICKUP_REFILL						2510.0686, 1226.6754, 1801.0859
#define PICKUP_REFILL_2						664.2344, -568.3286, 16.3363

// -- Keys in public KeyStateChange
#define KEY_F								( 16 )

// -- Prepare Numbers

#define UNIX_MONTH							( 2592000 )

#define IC									( 0 )
#define OOC									( 1 )

#define RP_TYPE_ME							( 0 )
#define RP_TYPE_AME							( 1 )
#define RP_TYPE_DO							( 2 )
#define RP_TYPE_TODO						( 3 )

#define TYPE_CMD							( 1 )
#define TYPE_ADMIN							( 2 )

#define MAX_RAD_NAME 						( 16 )
#define TIME_UPDATE 						( 1500 )

#define MAX_PLAYER_VEHICLES					( 2 )
#define MAX_PLAYER_SETTINGS					( 11 )
#define MAX_PLAYER_BUSINESS					( 2 )
#define MAX_PLAYER_HOUSE					( 2 )

// -- Logs
#define LOG_TRANSFER_BANK_MONEY				( 1 )
#define LOG_BUY_HOUSE						( 2 )
#define LOG_BUY_HOUSE_FROM_PLAYER			( 3 )
#define LOG_SELL_HOUSE						( 4 )
#define LOG_TRANSFER_MONEY					( 5 )
#define LOG_TRANSFER_RCOIN					( 6 )
#define LOG_CHANGE_NAME						( 7 )
#define LOG_BUY_PREMIUM						( 8 )
#define LOG_BUY_BUSINESS					( 9 )
#define LOG_BUY_BUSINESS_FROM_PLAYER		( 10 )
#define LOG_RENT_HOUSE						( 11 )
#define LOG_BUY_VEHICLE						( 12 )
#define LOG_BUY_VEHICLE_FROM_PLAYER			( 13 )
#define LOG_SWAP_VEHICLE					( 14 )

// -- Prepare Message
#define PLAYER_DISTANCE						""gbError"Данного игрока нет рядом с Вами."
#define MAX_MASS							""gbError"Вы и так уже несёте с собой достаточно предметов."
#define MAX_BAG_MASS						""gbError"Вы и так уже несёте в сумке достаточно предметов."
#define MAX_MASS_ON_TARGET					""gbError"Данный игрок и так уже несёт с собой достаточно предметов."
#define TIME_CMD							""gbError"Вы не можете использовать так часто данную команду, подождите."
#define CHAT_MUTE_IC						""gbError"У Вас заблокирован доступ к IC чату, Вы не можете его использовать."
#define CHAT_MUTE_OOC						""gbError"У Вас заблокирован доступ к OOC чату, Вы не можете его использовать."
#define NO_ACCESS_CMD       				""gbError"У Вас нет доступа для использования данной команды."
#define NO_ACCESS							""gbError"У Вас нет доступа, Вы не можете совершить данное действие."
#define NO_MONEY							""gbError"У Вас недостаточно средств для совершения данной операции."
#define INCORRECT_PLAYERID      			""gbError"Некорректный id игрока."
#define INCORRECT_VEHICLEID      			""gbError"Некорректный id транспорта."
#define	NO_VEHICLE_FRACTION					""gbError"Данный транспорт не принадлежит Вашей организации"
#define NOT_CHOOSE_ITEM						""gbError"Выберите предмет для выполнения данного действия."
#define NOT_MOVE_ACT_ITEM					""gbError"Данный предмет нельзя переместить в выбранный слот."
#define USE_ACTIVE_SLOT_NOW					""gbError"Вы уже используете подобный предмет в активном слоте."
#define USE_ACTIVE_SLOT_ACTION				""gbError"Для совершения каких-либо действий с данным предметом, уберите его из активного слота."
#define INCORRECT_AMMO						""gbError"Текущие патроны не подходят для оружия в активном слоте."
#define INCORRECT_USE_ITEM					""gbError"Данный предмет не используется таким образом."
#define INCORRECT_USE_CAR					""gbError"Вы не можете использовать багажник временного транспорта."
#define INCORRECT_FRACTION_ITEM				""gbError"Вы не можете переместить этот предмет в транспорт."

#define PLAYER_NEED_VEHICLE					""gbDefault"Для использования данной команды необходимо находиться в транспорте."
#define NO_PERSONAL_TRANSPORT				""gbError"У Вас отсутствует личный транспорт."

#define NO_PERSONAL_BUSINESS				""gbError"Вы не являетесь владельцем бизнеса."

#define NO_MONEY_PLAYER						""gbError"У игрока недостаточно средств для совершения данной операции."

#define HELP_EDITOR							""gbDefault"Используйте "cBLUE"ПРОБЕЛ"cWHITE" для поворота камеры, "cBLUE"ESC"cWHITE" для выхода из редактора."


#define TRANSFER_ITEM_ACCEPT				""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" принял Ваше предложение."
#define TAKE_ITEM_ACCEPT					""gbSuccess"Вы приняли предложение игрока "cBLUE"%s[%d]"cWHITE"."

#define TRANSFER_ITEM_CANCEL				""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от Вашего предложения."
#define TAKE_ITEM_CANCEL					""gbError"Вы отказались от предложения игрока "cBLUE"%s[%d]"cWHITE"."

#define OFFERED_TRANSFER					""gbDefault"Вы предложили игроку "cBLUE"%s[%d]"cWHITE" предмет "cBLUE"%s(%d)"cWHITE"."

#define TRANSFER_IS_BROKEN					""gbError"Передачу предмета невозможно совершить, повторите пожалуйста."
#define NO_ACCESS_INTERACTION				""gbError"Вы не можете взаимодействовать с данным игроком."

#define NO_KEY_CAR							""gbError"У Вас нет ключей зажигания от этого транспорта."
#define NO_LEADER							""gbError"Вы не являетесь лидером организации."

#define NO_NETWORK							""gbError"Вы находитесь вне зоны действия сети."
#define NO_HAVE_RCOIN						""gbError"На Вашем счете недостаточно RCoin, пополните счет не выходя из игры на "cBLUE"reeflandrp.ru/donate"

// -- Prepare Dialog Content
#define acontent_login      	"\
									"cBLUE"Авторизация\n\n\
									"cWHITE"Для продолжения работы необходимо авторизоваться.\n\n\
									Введите Ваш пароль администрирования:\
								"					
#define acontent_reg      		"\
									"cBLUE"Регистрация\n\n\
									"cWHITE"Вам необходимо зарегистрироваться как администратор.\n\n\
									Введите Ваш будущий пароль администрирования:\
								"
#define acontent_acp        	"\
									"cBLUE"-"cWHITE" Команда в сети\n\
									"cBLUE"-"cWHITE" Список команд\n\
									"cBLUE"-"cWHITE" Статистика\n\
									"cBLUE"-"cWHITE" Настройка\n\
									"cBLUE"-"cWHITE" Лог убийств\n\
									"cBLUE"-"cWHITE" Лог отключений\n\
									"cBLUE"-"cWHITE" Обновить права доступа\n\
								"
#define hcontent_hcp        	"\
									"cBLUE"-"cWHITE" Команда в сети\n\
									"cBLUE"-"cWHITE" Список команд\n\
									"cBLUE"-"cWHITE" Статистика\n\
								"
							
#define acontent_giveitem 		"\
									"gbDialog"Выберите раздел\n\
										"cBLUE"-"cWHITE" Поиск предмета\n\
										"cBLUE"-"cWHITE" Одежда\n\
										"cBLUE"-"cWHITE" Холодное оружие\n\
										"cBLUE"-"cWHITE" Огнестрельное оружие\n\
										"cBLUE"-"cWHITE" Патроны\n\
										"cBLUE"-"cWHITE" Сумки\n\
										"cBLUE"-"cWHITE" Еда\n\
										"cBLUE"-"cWHITE" Специальное\n\
										"cBLUE"-"cWHITE" Остальное\
								"
							
#define regtext				""cBLUE"Информация\n\n\
								"cWHITE"Вы успешно зарегистрировались на "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								При дальнейшей игре опирайтесь на продуманную роль, учитывайте характер и личные качества Вашего персонажа.\n\
								Соблюдайте игровую атмосферу, адекватно оценивайте обстановку RolePlay-ситуаций и свои действия, знакомьтесь и заводите новых друзей.\n\n\
								Всю дополнительную информацию Вы сможете найти в Игровом меню ( Y - Игровое меню ).\n\n\
								Приятной игры на "cBLUE"Reefland RolePlay"cWHITE"!\
							"
					
#define logtext 			""cBLUE"Авторизация\n\n\
								%s, "cWHITE"добро пожаловать на "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								Для продолжения игры, Вам необходимо авторизоваться.\n\
								Введите Ваш пароль ниже:\
							"
							
#define logtextold 			""cBLUE"Регистрация\n\n\
								"cWHITE"Добро пожаловать на "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								Аккаунт "cBLUE"%s"cWHITE" найден в базе данных.\n\
								Для продолжения регистрации, введите Ваш старый пароль:\n\
								"gbDialog"На почту, привязанную к аккаунту, будет выслан код подтверждения.\
							"
							
#define logtexmail 			""cBLUE"Регистрация: код\n\n\
								"cWHITE"На Ваш адрес "cBLUE"%s"cWHITE" было выслано письмо с кодом подтверждения.\n\n\
								Для завершения регистрации, введите код подтверждения:\n\
								"gbDialog"Если Вы не обнаружили письмо с кодом подтверждения, проверьте папку Спам.\
							"
							
#define logerror 			""cBLUE"Регистрация: код\n\n\
								"cWHITE"На Ваш адрес "cBLUE"%s"cWHITE" было выслано письмо с кодом подтверждения.\n\n\
								Для завершения регистрации, введите код подтверждения:\n\
								"gbDialogError"Неверный код подтверждения.\
							"
							
#define regpass				""cBLUE"Регистрация: пароль\n\n\
								"cWHITE"Данный аккаунт не зарегистрирован - "cBLUE"%s"cWHITE".\n\n\
								Регистрируясь, Вы автоматически соглашаетесь с правилами сервера "cBLUE"reelfandrp.ru/rules\n\
								"cWHITE"Для продолжения регистрации, придумайте пароль:\n\n\
								"gbDialog"Пароль может содержать цифры и латинские буквы разного регистра от 8 до 20 символов.\n\
								"gbDialog"Для Вашей безопасности не рекомендуем использовать легкие пароли.\
							"
							
#define regpassrepeat		""cBLUE"Регистрация: повторить пароль\n\n\
								"cWHITE"Регистрируясь, Вы автоматически соглашаетесь с правилами сервера "cBLUE"reelfandrp.ru/rules\n\
								"cWHITE"Повторите пароль, введенный в предыдущем шаге:\
							"
							
#define regmail				""cBLUE"Регистрация: почта\n\n\
								"cWHITE"Укажите Ваш действующий Email:\n\n\
								"gbDialog"В дальнейшем с помощью почтового ящика Вы сможете восстановить утерянный пароль или изменить текущий.\n\
								"gbDialog"Рекомендуем использовать почтовые ящики сервисов yandex.ru, mail.ru, google.com\
							"

#define regsex				""cBLUE"Регистрация: пол\n\n\
								"cWHITE"Выберите пол Вашего персонажа:\
							"
							
#define regcolor			""cBLUE"Регистрация: цвет кожи\n\n\
								"cWHITE"Выберите цвет кожи Вашего персонажа:\
							"
							
#define regnation			"\
								"gbDialog"Выберите национальность Вашего персонажа:\n\
								"cBLUE"- "cWHITE"Австралиец\n\
								"cBLUE"- "cWHITE"Албанец\n\
								"cBLUE"- "cWHITE"Американец\n\
								"cBLUE"- "cWHITE"Англичанин\n\
								"cBLUE"- "cWHITE"Армянин\n\
								"cBLUE"- "cWHITE"Бразилец\n\
								"cBLUE"- "cWHITE"Вьетнамец\n\
								"cBLUE"- "cWHITE"Голландец\n\
								"cBLUE"- "cWHITE"Еврей\n\
								"cBLUE"- "cWHITE"Испанец\n\
								"cBLUE"- "cWHITE"Итальянец\n\
								"cBLUE"- "cWHITE"Китаец\n\
								"cBLUE"- "cWHITE"Колумбиец\n\
								"cBLUE"- "cWHITE"Кореец\n\
								"cBLUE"- "cWHITE"Латиноамериканец\n\
								"cBLUE"- "cWHITE"Мексиканец\n\
								"cBLUE"- "cWHITE"Немец\n\
								"cBLUE"- "cWHITE"Поляк\n\
								"cBLUE"- "cWHITE"Португалец\n\
								"cBLUE"- "cWHITE"Русский\n\
								"cBLUE"- "cWHITE"Турок\n\
								"cBLUE"- "cWHITE"Украинец\n\
								"cBLUE"- "cWHITE"Француз\n\
								"cBLUE"- "cWHITE"Чех\n\
								"cBLUE"- "cWHITE"Японец\
							"
							
#define regcountry			"\
								"gbDialog"Выберите страну рождения Вашего персонажа:\n\
								"cBLUE"- "cWHITE"Австралия\n\
								"cBLUE"- "cWHITE"Албания\n\
								"cBLUE"- "cWHITE"Англия\n\
								"cBLUE"- "cWHITE"Армения\n\
								"cBLUE"- "cWHITE"Бразилия\n\
								"cBLUE"- "cWHITE"Вьетнам\n\
								"cBLUE"- "cWHITE"Германия\n\
								"cBLUE"- "cWHITE"Израиль\n\
								"cBLUE"- "cWHITE"Испания\n\
								"cBLUE"- "cWHITE"Италия\n\
								"cBLUE"- "cWHITE"Китай\n\
								"cBLUE"- "cWHITE"Колумбия\n\
								"cBLUE"- "cWHITE"Корея\n\
								"cBLUE"- "cWHITE"Мексика\n\
								"cBLUE"- "cWHITE"Нидерланды\n\
								"cBLUE"- "cWHITE"Польша\n\
								"cBLUE"- "cWHITE"Португалия\n\
								"cBLUE"- "cWHITE"Россия\n\
								"cBLUE"- "cWHITE"США\n\
								"cBLUE"- "cWHITE"Турция\n\
								"cBLUE"- "cWHITE"Франция\n\
								"cBLUE"- "cWHITE"Украина\n\
								"cBLUE"- "cWHITE"Чехия\n\
								"cBLUE"- "cWHITE"Япония\
							"
							
#define regage				""cBLUE"Регистрация: возраст\n\n\
								"cWHITE"Укажите возраст Вашего персонажа:\n\
								"gbDialog"От 16 до 70 лет\
							"
							
#define regnick				""cBLUE"Регистрация: Имя и Фамилия\n\n\
								"cWHITE"Вы используете некорректные Имя и(или) Фамилию для регистрации персонажа - "cBLUE"%s"cWHITE".\n\n\
								Проверьте правильность написания Имени/Фамилии и попробуйте еще раз:\n\
								"cBLUE"- "cGRAY"никнейм должен состоять только из латинских букв,\n\
								"cBLUE"- "cGRAY"между Имени и Фамилии должен использоваться знак '_',\n\
								"cBLUE"- "cGRAY"никнейм не должен содержать больше 24 и меньше 6 символов,\n\
								"cBLUE"- "cGRAY"Имя и(или) Фамилия не должны содержать меньше 3 символов,\n\
								"cBLUE"- "cGRAY"Имя и Фамилия должны начинаться с заглавных букв.\
							"
					
#define retesttext			""gbDefault"Информация\n\n\
								"cWHITE"Добро пожаловать на "cBLUE"Reefland RolePlay"cWHITE".\n\
								Ваш аккаунт отправлен на ретест.\n\
								Пройти ретест можно на сайте - "cBLUE"www.reeflandrp.ru"cWHITE".\
							"

#define checktext			""gbDefault"Информация\n\n\
								"cWHITE"Добро пожаловать на "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								Ваш аккаунт ещё неактивирован. Время активации может занимать до 48 часов.\n\
								Отследить статус Вашего аккаунта можно на сайте - "cBLUE"www.reeflandrp.ru"cWHITE".\
							"

#define unactive			""gbDefault"Информация\n\n\
								"cWHITE"Добро пожаловать на "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								Ваш аккаунт был отклонён.\n\
								Пересоздать аккаунт можно на сайте - "cBLUE"www.reeflandrp.ru"cWHITE".\
							"
						
#define errortext	    	""gbError"Информация\n\n\
								Вы были отсоединены от сервера за неправильный ввод данных.\n\
								Восстановить доступ к аккаунту можно на сайте - "cBLUE"www.reeflandrp.ru"cWHITE".\
							"
#define cktext				"\
								"gbError"Информация\n\n\
								Ваш игровой персонаж погиб по \"IC\" и получил статус - \"CK\".\n\
								Вы не можете авторизоваться.\
							"
						
#define static_gps 			""cBLUE"- "cWHITE"Поиск"

#define invcontent_bone 	""gbDialog"Выберите часть тела:\n\
								"cBLUE"-"cWHITE" Спина\n\
								"cBLUE"-"cWHITE" Голова\n\
								"cBLUE"-"cWHITE" Плечо левой руки\n\
								"cBLUE"-"cWHITE" Плечо правой руки\n\
								"cBLUE"-"cWHITE" Левая рука\n\
								"cBLUE"-"cWHITE" Правая рука\n\
								"cBLUE"-"cWHITE" Левое бедро\n\
								"cBLUE"-"cWHITE" Правое бедро\n\
								"cBLUE"-"cWHITE" Левая нога\n\
								"cBLUE"-"cWHITE" Правая нога\n\
								"cBLUE"-"cWHITE" Правые икры\n\
								"cBLUE"-"cWHITE" Левые икры\n\
								"cBLUE"-"cWHITE" Левое предплечье\n\
								"cBLUE"-"cWHITE" Правое предплечье\n\
								"cBLUE"-"cWHITE" Левая ключица\n\
								"cBLUE"-"cWHITE" Правая ключица\n\
								"cBLUE"-"cWHITE" Шея\n\
								"cBLUE"-"cWHITE" Челюсть\
							"
#define vehcontent_cpanel	"\
								"cBLUE"-"cWHITE" Информация\n\
								"cBLUE"-"cWHITE" Управление транспортом\n\
								"cBLUE"-"cWHITE" Вернуть транспорт на парковочное место\n\
								"cBLUE"-"cWHITE" Найти транспорт на карте\n\
								"cBLUE"-"cWHITE" Припарковать транспорт\n\
								"cBLUE"-"cWHITE" Обменять транспорт\n\
								"cBLUE"-"cWHITE" Продать транспорт игроку\
							"
							
#define b_panel				"\
								"cBLUE"-"cWHITE" Информация\n\
								"cBLUE"-"cWHITE" Расширение бизнеса\n\
								"cBLUE"-"cWHITE" Денежные операции\n\
								"cBLUE"-"cWHITE" Настройки\
							"

#define b_panel_p2			"\
								"cWHITE"Наименование\t"cWHITE"Наличие\n\
								"cWHITE"Расширенный склад \t%s\n\
								"cWHITE"Расширенный прилавок \t%s\n\
								"cWHITE"Дополнительная мебель\
							"
							
#define b_panel_p3			"\
								"cWHITE"Положить деньги в сейф\n\
								"cWHITE"Взять деньги из сейфа\
							"
							
#define b_panel_p4			"\
								"cWHITE"Изменить название бизнеса\n\
								"cWHITE"Изменить цену за продукт - "cBLUE"$%d\n\
								"cWHITE"Заказать товары в бизнес\n\
								"cWHITE"Перепланировка помещения\
							"
							
#define b_panel_plan		"\
								"cWHITE"Ретекстуризация\n\
								"cWHITE"Расстановка мебели\n\
								"cWHITE"Установка кассы\
							"
							
#define b_panel_texture		"\
								"cWHITE"Изменение стен\n\
								"cWHITE"Изменение пола\n\
								"cWHITE"Изменение потолка\n\
								"cWHITE"Изменение лестниц\
							"
			
#define furniture_type		"\
								"cBLUE"1. "cWHITE"Диваны и кресла\n\
								"cBLUE"2. "cWHITE"Спальная\n\
								"cBLUE"3. "cWHITE"Столы\n\
								"cBLUE"4. "cWHITE"Стулья\n\
								"cBLUE"5. "cWHITE"Шкафы и комоды\n\
								"cBLUE"6. "cWHITE"Электроника\n\
								"cBLUE"7. "cWHITE"Кухня\n\
								"cBLUE"8. "cWHITE"Санузел\n\
								"cBLUE"9. "cWHITE"Освещение\n\
								"cBLUE"10. "cWHITE"Декор\n\
								"cBLUE"11. "cWHITE"Окна и стёкла\n\
								"cBLUE"12. "cWHITE"Двери и ограждения\n\
								"cBLUE"13. "cWHITE"Офис\n\
								"cBLUE"14. "cWHITE"Общепит\n\
								"cBLUE"15. "cWHITE"Прилавки и витрины\n\
								"cBLUE"16. "cWHITE"Спорт и отдых\
							"
							
#define furniture_other		"\
								"cBLUE"1. "cWHITE"Головные уборы\n\
								"cBLUE"2. "cWHITE"Кухонные приборы\n\
								"cBLUE"3. "cWHITE"Еда и напитки\n\
								"cBLUE"4. "cWHITE"Для бизнеса\n\
								"cBLUE"5. "cWHITE"Реклама\n\
								"cBLUE"6. "cWHITE"Спорт и отдых\n\
								"cBLUE"7. "cWHITE"Для праздника\n\
								"cBLUE"8. "cWHITE"Мусор\n\
								"cBLUE"9. "cWHITE"Товары повседневного спроса #1\n\
								"cBLUE"10. "cWHITE"Товары повседневного спроса #2\n\
							"
							
#define job_dialog			"\	
								"cBLUE"1. "cWHITE"%s рабочий день\n\
								"cBLUE"2. "cWHITE"Ознакомиться с работой\n\
								"cBLUE"3. "cWHITE"Устроиться на работу\
							"
							
#define dialog_stocks		"\
								"cWHITE"Общая информация\n\
								"cWHITE"Выбрать товар для перевозки\
							"
							