// -- Main
#define GGAME_VERSION						"Reefland 1.0"
#define GGAME_VERSION_AC					"RAC 1.1"
#define GGAME_DESCRIPTION					"�������� �������"

//#define DEBUG �������� ����� ������ ����������� ����������.

// -- Settings

#define ANTICHEAT_MIN_ADMIN_LEVEL			( 1 )
#define ANTICHEAT_EXCEPTION_TIME			( 10 ) // ���������� ��������
#define ANTICHEAT_EXCEPTION_CARSHOT			( 2 ) // ���������� ��������

#define BENEFIT_VALUE						( 100 ) // ������� �� �����������
#define BENEFIT_NORANK						( 200 ) // �������� ��� �����

#define DELETE_CAR_VALUE					( 900 ) // �������� ������� ���������� ��� ������ ( 900 = 15 ����� )

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
//#define C_BLUE                  			( 0x4A86B6FF ) -- ������ ����
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
//#define cBLUE                 			"{4a86b6}" -- ������ ����
#define cBLUE                 				"{04cabf}"
#define cDARKRED							"{AA3333}"
#define cRED                  				"{E05A5A}"
#define cGREEN                				"{46BD38}"
#define cORANGE								"{FF9945}"
#define cDARKORANGE             			"{DEB047}"

// -- TextDraw Colors
//#define td_cBLUE							( 945389823 ) -- ������ ����
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
#define gbPhone								""cGRAY"[�������] "
#define gbRadio								""cWHITE"[�����] "
#define gbVehicle							""cWHITE"[���������] "

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
#define PLAYER_DISTANCE						""gbError"������� ������ ��� ����� � ����."
#define MAX_MASS							""gbError"�� � ��� ��� ����� � ����� ���������� ���������."
#define MAX_BAG_MASS						""gbError"�� � ��� ��� ����� � ����� ���������� ���������."
#define MAX_MASS_ON_TARGET					""gbError"������ ����� � ��� ��� ���� � ����� ���������� ���������."
#define TIME_CMD							""gbError"�� �� ������ ������������ ��� ����� ������ �������, ���������."
#define CHAT_MUTE_IC						""gbError"� ��� ������������ ������ � IC ����, �� �� ������ ��� ������������."
#define CHAT_MUTE_OOC						""gbError"� ��� ������������ ������ � OOC ����, �� �� ������ ��� ������������."
#define NO_ACCESS_CMD       				""gbError"� ��� ��� ������� ��� ������������� ������ �������."
#define NO_ACCESS							""gbError"� ��� ��� �������, �� �� ������ ��������� ������ ��������."
#define NO_MONEY							""gbError"� ��� ������������ ������� ��� ���������� ������ ��������."
#define INCORRECT_PLAYERID      			""gbError"������������ id ������."
#define INCORRECT_VEHICLEID      			""gbError"������������ id ����������."
#define	NO_VEHICLE_FRACTION					""gbError"������ ��������� �� ����������� ����� �����������"
#define NOT_CHOOSE_ITEM						""gbError"�������� ������� ��� ���������� ������� ��������."
#define NOT_MOVE_ACT_ITEM					""gbError"������ ������� ������ ����������� � ��������� ����."
#define USE_ACTIVE_SLOT_NOW					""gbError"�� ��� ����������� �������� ������� � �������� �����."
#define USE_ACTIVE_SLOT_ACTION				""gbError"��� ���������� �����-���� �������� � ������ ���������, ������� ��� �� ��������� �����."
#define INCORRECT_AMMO						""gbError"������� ������� �� �������� ��� ������ � �������� �����."
#define INCORRECT_USE_ITEM					""gbError"������ ������� �� ������������ ����� �������."
#define INCORRECT_USE_CAR					""gbError"�� �� ������ ������������ �������� ���������� ����������."
#define INCORRECT_FRACTION_ITEM				""gbError"�� �� ������ ����������� ���� ������� � ���������."

#define PLAYER_NEED_VEHICLE					""gbDefault"��� ������������� ������ ������� ���������� ���������� � ����������."
#define NO_PERSONAL_TRANSPORT				""gbError"� ��� ����������� ������ ���������."

#define NO_PERSONAL_BUSINESS				""gbError"�� �� ��������� ���������� �������."

#define NO_MONEY_PLAYER						""gbError"� ������ ������������ ������� ��� ���������� ������ ��������."

#define HELP_EDITOR							""gbDefault"����������� "cBLUE"������"cWHITE" ��� �������� ������, "cBLUE"ESC"cWHITE" ��� ������ �� ���������."


#define TRANSFER_ITEM_ACCEPT				""gbSuccess"����� "cBLUE"%s[%d]"cWHITE" ������ ���� �����������."
#define TAKE_ITEM_ACCEPT					""gbSuccess"�� ������� ����������� ������ "cBLUE"%s[%d]"cWHITE"."

#define TRANSFER_ITEM_CANCEL				""gbError"����� "cBLUE"%s[%d]"cWHITE" ��������� �� ������ �����������."
#define TAKE_ITEM_CANCEL					""gbError"�� ���������� �� ����������� ������ "cBLUE"%s[%d]"cWHITE"."

#define OFFERED_TRANSFER					""gbDefault"�� ���������� ������ "cBLUE"%s[%d]"cWHITE" ������� "cBLUE"%s(%d)"cWHITE"."

#define TRANSFER_IS_BROKEN					""gbError"�������� �������� ���������� ���������, ��������� ����������."
#define NO_ACCESS_INTERACTION				""gbError"�� �� ������ ����������������� � ������ �������."

#define NO_KEY_CAR							""gbError"� ��� ��� ������ ��������� �� ����� ����������."
#define NO_LEADER							""gbError"�� �� ��������� ������� �����������."

#define NO_NETWORK							""gbError"�� ���������� ��� ���� �������� ����."
#define NO_HAVE_RCOIN						""gbError"�� ����� ����� ������������ RCoin, ��������� ���� �� ������ �� ���� �� "cBLUE"reeflandrp.ru/donate"

// -- Prepare Dialog Content
#define acontent_login      	"\
									"cBLUE"�����������\n\n\
									"cWHITE"��� ����������� ������ ���������� ��������������.\n\n\
									������� ��� ������ �����������������:\
								"					
#define acontent_reg      		"\
									"cBLUE"�����������\n\n\
									"cWHITE"��� ���������� ������������������ ��� �������������.\n\n\
									������� ��� ������� ������ �����������������:\
								"
#define acontent_acp        	"\
									"cBLUE"-"cWHITE" ������� � ����\n\
									"cBLUE"-"cWHITE" ������ ������\n\
									"cBLUE"-"cWHITE" ����������\n\
									"cBLUE"-"cWHITE" ���������\n\
									"cBLUE"-"cWHITE" ��� �������\n\
									"cBLUE"-"cWHITE" ��� ����������\n\
									"cBLUE"-"cWHITE" �������� ����� �������\n\
								"
#define hcontent_hcp        	"\
									"cBLUE"-"cWHITE" ������� � ����\n\
									"cBLUE"-"cWHITE" ������ ������\n\
									"cBLUE"-"cWHITE" ����������\n\
								"
							
#define acontent_giveitem 		"\
									"gbDialog"�������� ������\n\
										"cBLUE"-"cWHITE" ����� ��������\n\
										"cBLUE"-"cWHITE" ������\n\
										"cBLUE"-"cWHITE" �������� ������\n\
										"cBLUE"-"cWHITE" ������������� ������\n\
										"cBLUE"-"cWHITE" �������\n\
										"cBLUE"-"cWHITE" �����\n\
										"cBLUE"-"cWHITE" ���\n\
										"cBLUE"-"cWHITE" �����������\n\
										"cBLUE"-"cWHITE" ���������\
								"
							
#define regtext				""cBLUE"����������\n\n\
								"cWHITE"�� ������� ������������������ �� "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								��� ���������� ���� ���������� �� ����������� ����, ���������� �������� � ������ �������� ������ ���������.\n\
								���������� ������� ���������, ��������� ���������� ���������� RolePlay-�������� � ���� ��������, ����������� � �������� ����� ������.\n\n\
								��� �������������� ���������� �� ������� ����� � ������� ���� ( Y - ������� ���� ).\n\n\
								�������� ���� �� "cBLUE"Reefland RolePlay"cWHITE"!\
							"
					
#define logtext 			""cBLUE"�����������\n\n\
								%s, "cWHITE"����� ���������� �� "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								��� ����������� ����, ��� ���������� ��������������.\n\
								������� ��� ������ ����:\
							"
							
#define logtextold 			""cBLUE"�����������\n\n\
								"cWHITE"����� ���������� �� "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								������� "cBLUE"%s"cWHITE" ������ � ���� ������.\n\
								��� ����������� �����������, ������� ��� ������ ������:\n\
								"gbDialog"�� �����, ����������� � ��������, ����� ������ ��� �������������.\
							"
							
#define logtexmail 			""cBLUE"�����������: ���\n\n\
								"cWHITE"�� ��� ����� "cBLUE"%s"cWHITE" ���� ������� ������ � ����� �������������.\n\n\
								��� ���������� �����������, ������� ��� �������������:\n\
								"gbDialog"���� �� �� ���������� ������ � ����� �������������, ��������� ����� ����.\
							"
							
#define logerror 			""cBLUE"�����������: ���\n\n\
								"cWHITE"�� ��� ����� "cBLUE"%s"cWHITE" ���� ������� ������ � ����� �������������.\n\n\
								��� ���������� �����������, ������� ��� �������������:\n\
								"gbDialogError"�������� ��� �������������.\
							"
							
#define regpass				""cBLUE"�����������: ������\n\n\
								"cWHITE"������ ������� �� ��������������� - "cBLUE"%s"cWHITE".\n\n\
								�������������, �� ������������� ������������ � ��������� ������� "cBLUE"reelfandrp.ru/rules\n\
								"cWHITE"��� ����������� �����������, ���������� ������:\n\n\
								"gbDialog"������ ����� ��������� ����� � ��������� ����� ������� �������� �� 8 �� 20 ��������.\n\
								"gbDialog"��� ����� ������������ �� ����������� ������������ ������ ������.\
							"
							
#define regpassrepeat		""cBLUE"�����������: ��������� ������\n\n\
								"cWHITE"�������������, �� ������������� ������������ � ��������� ������� "cBLUE"reelfandrp.ru/rules\n\
								"cWHITE"��������� ������, ��������� � ���������� ����:\
							"
							
#define regmail				""cBLUE"�����������: �����\n\n\
								"cWHITE"������� ��� ����������� Email:\n\n\
								"gbDialog"� ���������� � ������� ��������� ����� �� ������� ������������ ��������� ������ ��� �������� �������.\n\
								"gbDialog"����������� ������������ �������� ����� �������� yandex.ru, mail.ru, google.com\
							"

#define regsex				""cBLUE"�����������: ���\n\n\
								"cWHITE"�������� ��� ������ ���������:\
							"
							
#define regcolor			""cBLUE"�����������: ���� ����\n\n\
								"cWHITE"�������� ���� ���� ������ ���������:\
							"
							
#define regnation			"\
								"gbDialog"�������� �������������� ������ ���������:\n\
								"cBLUE"- "cWHITE"����������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"����������\n\
								"cBLUE"- "cWHITE"����������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"��������\n\
								"cBLUE"- "cWHITE"���������\n\
								"cBLUE"- "cWHITE"���������\n\
								"cBLUE"- "cWHITE"�����\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"���������\n\
								"cBLUE"- "cWHITE"������\n\
								"cBLUE"- "cWHITE"���������\n\
								"cBLUE"- "cWHITE"������\n\
								"cBLUE"- "cWHITE"����������������\n\
								"cBLUE"- "cWHITE"����������\n\
								"cBLUE"- "cWHITE"�����\n\
								"cBLUE"- "cWHITE"�����\n\
								"cBLUE"- "cWHITE"����������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"�����\n\
								"cBLUE"- "cWHITE"��������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"���\n\
								"cBLUE"- "cWHITE"������\
							"
							
#define regcountry			"\
								"gbDialog"�������� ������ �������� ������ ���������:\n\
								"cBLUE"- "cWHITE"���������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"��������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"��������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"������\n\
								"cBLUE"- "cWHITE"�����\n\
								"cBLUE"- "cWHITE"��������\n\
								"cBLUE"- "cWHITE"�����\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"����������\n\
								"cBLUE"- "cWHITE"������\n\
								"cBLUE"- "cWHITE"����������\n\
								"cBLUE"- "cWHITE"������\n\
								"cBLUE"- "cWHITE"���\n\
								"cBLUE"- "cWHITE"������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"�������\n\
								"cBLUE"- "cWHITE"�����\n\
								"cBLUE"- "cWHITE"������\
							"
							
#define regage				""cBLUE"�����������: �������\n\n\
								"cWHITE"������� ������� ������ ���������:\n\
								"gbDialog"�� 16 �� 70 ���\
							"
							
#define regnick				""cBLUE"�����������: ��� � �������\n\n\
								"cWHITE"�� ����������� ������������ ��� �(���) ������� ��� ����������� ��������� - "cBLUE"%s"cWHITE".\n\n\
								��������� ������������ ��������� �����/������� � ���������� ��� ���:\n\
								"cBLUE"- "cGRAY"������� ������ �������� ������ �� ��������� ����,\n\
								"cBLUE"- "cGRAY"����� ����� � ������� ������ �������������� ���� '_',\n\
								"cBLUE"- "cGRAY"������� �� ������ ��������� ������ 24 � ������ 6 ��������,\n\
								"cBLUE"- "cGRAY"��� �(���) ������� �� ������ ��������� ������ 3 ��������,\n\
								"cBLUE"- "cGRAY"��� � ������� ������ ���������� � ��������� ����.\
							"
					
#define retesttext			""gbDefault"����������\n\n\
								"cWHITE"����� ���������� �� "cBLUE"Reefland RolePlay"cWHITE".\n\
								��� ������� ��������� �� ������.\n\
								������ ������ ����� �� ����� - "cBLUE"www.reeflandrp.ru"cWHITE".\
							"

#define checktext			""gbDefault"����������\n\n\
								"cWHITE"����� ���������� �� "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								��� ������� ��� �������������. ����� ��������� ����� �������� �� 48 �����.\n\
								��������� ������ ������ �������� ����� �� ����� - "cBLUE"www.reeflandrp.ru"cWHITE".\
							"

#define unactive			""gbDefault"����������\n\n\
								"cWHITE"����� ���������� �� "cBLUE"Reefland RolePlay"cWHITE".\n\n\
								��� ������� ��� ��������.\n\
								����������� ������� ����� �� ����� - "cBLUE"www.reeflandrp.ru"cWHITE".\
							"
						
#define errortext	    	""gbError"����������\n\n\
								�� ���� ����������� �� ������� �� ������������ ���� ������.\n\
								������������ ������ � �������� ����� �� ����� - "cBLUE"www.reeflandrp.ru"cWHITE".\
							"
#define cktext				"\
								"gbError"����������\n\n\
								��� ������� �������� ����� �� \"IC\" � ������� ������ - \"CK\".\n\
								�� �� ������ ��������������.\
							"
						
#define static_gps 			""cBLUE"- "cWHITE"�����"

#define invcontent_bone 	""gbDialog"�������� ����� ����:\n\
								"cBLUE"-"cWHITE" �����\n\
								"cBLUE"-"cWHITE" ������\n\
								"cBLUE"-"cWHITE" ����� ����� ����\n\
								"cBLUE"-"cWHITE" ����� ������ ����\n\
								"cBLUE"-"cWHITE" ����� ����\n\
								"cBLUE"-"cWHITE" ������ ����\n\
								"cBLUE"-"cWHITE" ����� �����\n\
								"cBLUE"-"cWHITE" ������ �����\n\
								"cBLUE"-"cWHITE" ����� ����\n\
								"cBLUE"-"cWHITE" ������ ����\n\
								"cBLUE"-"cWHITE" ������ ����\n\
								"cBLUE"-"cWHITE" ����� ����\n\
								"cBLUE"-"cWHITE" ����� ����������\n\
								"cBLUE"-"cWHITE" ������ ����������\n\
								"cBLUE"-"cWHITE" ����� �������\n\
								"cBLUE"-"cWHITE" ������ �������\n\
								"cBLUE"-"cWHITE" ���\n\
								"cBLUE"-"cWHITE" �������\
							"
#define vehcontent_cpanel	"\
								"cBLUE"-"cWHITE" ����������\n\
								"cBLUE"-"cWHITE" ���������� �����������\n\
								"cBLUE"-"cWHITE" ������� ��������� �� ����������� �����\n\
								"cBLUE"-"cWHITE" ����� ��������� �� �����\n\
								"cBLUE"-"cWHITE" ������������ ���������\n\
								"cBLUE"-"cWHITE" �������� ���������\n\
								"cBLUE"-"cWHITE" ������� ��������� ������\
							"
							
#define b_panel				"\
								"cBLUE"-"cWHITE" ����������\n\
								"cBLUE"-"cWHITE" ���������� �������\n\
								"cBLUE"-"cWHITE" �������� ��������\n\
								"cBLUE"-"cWHITE" ���������\
							"

#define b_panel_p2			"\
								"cWHITE"������������\t"cWHITE"�������\n\
								"cWHITE"����������� ����� \t%s\n\
								"cWHITE"����������� �������� \t%s\n\
								"cWHITE"�������������� ������\
							"
							
#define b_panel_p3			"\
								"cWHITE"�������� ������ � ����\n\
								"cWHITE"����� ������ �� �����\
							"
							
#define b_panel_p4			"\
								"cWHITE"�������� �������� �������\n\
								"cWHITE"�������� ���� �� ������� - "cBLUE"$%d\n\
								"cWHITE"�������� ������ � ������\n\
								"cWHITE"�������������� ���������\
							"
							
#define b_panel_plan		"\
								"cWHITE"���������������\n\
								"cWHITE"����������� ������\n\
								"cWHITE"��������� �����\
							"
							
#define b_panel_texture		"\
								"cWHITE"��������� ����\n\
								"cWHITE"��������� ����\n\
								"cWHITE"��������� �������\n\
								"cWHITE"��������� �������\
							"
			
#define furniture_type		"\
								"cBLUE"1. "cWHITE"������ � ������\n\
								"cBLUE"2. "cWHITE"��������\n\
								"cBLUE"3. "cWHITE"�����\n\
								"cBLUE"4. "cWHITE"������\n\
								"cBLUE"5. "cWHITE"����� � ������\n\
								"cBLUE"6. "cWHITE"�����������\n\
								"cBLUE"7. "cWHITE"�����\n\
								"cBLUE"8. "cWHITE"�������\n\
								"cBLUE"9. "cWHITE"���������\n\
								"cBLUE"10. "cWHITE"�����\n\
								"cBLUE"11. "cWHITE"���� � �����\n\
								"cBLUE"12. "cWHITE"����� � ����������\n\
								"cBLUE"13. "cWHITE"����\n\
								"cBLUE"14. "cWHITE"�������\n\
								"cBLUE"15. "cWHITE"�������� � �������\n\
								"cBLUE"16. "cWHITE"����� � �����\
							"
							
#define furniture_other		"\
								"cBLUE"1. "cWHITE"�������� �����\n\
								"cBLUE"2. "cWHITE"�������� �������\n\
								"cBLUE"3. "cWHITE"��� � �������\n\
								"cBLUE"4. "cWHITE"��� �������\n\
								"cBLUE"5. "cWHITE"�������\n\
								"cBLUE"6. "cWHITE"����� � �����\n\
								"cBLUE"7. "cWHITE"��� ���������\n\
								"cBLUE"8. "cWHITE"�����\n\
								"cBLUE"9. "cWHITE"������ ������������� ������ #1\n\
								"cBLUE"10. "cWHITE"������ ������������� ������ #2\n\
							"
							
#define job_dialog			"\	
								"cBLUE"1. "cWHITE"%s ������� ����\n\
								"cBLUE"2. "cWHITE"������������ � �������\n\
								"cBLUE"3. "cWHITE"���������� �� ������\
							"
							
#define dialog_stocks		"\
								"cWHITE"����� ����������\n\
								"cWHITE"������� ����� ��� ���������\
							"
							