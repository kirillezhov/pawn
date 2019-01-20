#define NUMBER_GUNDEALER		( 2929282 )
#define DAYS_TO_GUNDEALER		( 5 )

const
	MAX_CRIMINAL = 30,
	MAX_POINTS = 50,
	PERCENT_FOR_VEHICLE = 30,
	MAX_CRIME_ORDERS = 50;

enum e_CRIME_FRACTION 
{
	c_id,					//Ид фракции
	c_name[64],				//Название фракции
	c_type,					//Тип фракции
	c_leader[3],			//uID лидеров фракций
	c_vehicles,				//Ограничение по количеству транспорта
	c_ranks,				//Количество рангов во фракции
	c_amountveh,			//Количество созданного транспорта
	c_members,				//Количество игроков во фракции
	c_type_vehicles,		//Возможность приобретения транспорта
	c_type_weapon,			//Тип оружия у ган диллера
	
	c_time,					//Через сколько появится возможность звонить
	c_time_dealer,			//Через сколько появится дилер
	c_amount_weapon,		//Количество оружия для заказа
	c_index_dealer,			//Индекс дилера
}

enum e_CRIME_RANK
{
	r_id,				
	r_fracid,				//Ид фракции
	r_name[32],				//Название ранга
	r_invite,				//Может ли принимать во фракцию
	r_uninvite,				//Может ли увольнять из фракции
	Float:r_spawn[4],		//Место спавна
	r_world[2],				//Виртуальный мир и интерьер у спавна
	r_attach,				//Может ли использовать аттачи
	r_spawnveh,				//Возможность спавна транспорта
	r_vehicles[10],			//Настройки на использование машин (хранит модели машин)
	r_call_weapon,			//Звонки гандиллеру
}

enum e_CRIME_MEMBER
{
	m_id,
	m_name					[ MAX_PLAYER_NAME ],
	m_rank,
	m_lasttime,
}

enum e_CRIME_VEH
{
	v_id,
	v_number[10],
}

enum e_GUNDEALER
{
	g_id,
	g_actor,
	Float:g_actor_pos[4],
	g_car,
	Float:g_car_pos[4],
	g_time,
	g_fracid,
	g_car_id,
	g_actor_id,
	g_zone[30],
	Text3D: g_text,
}

enum e_GUN_ORDER
{
	gun_id[10],			//Массив, который кранит id предметов
	gun_amount[10],		//Массив, который кранит количество предметов
}

enum e_GUN_INFO
{
	gun_type,
	gun_id,
	gun_price,
	gun_amount,
}

enum e_CRIME_ATTACH
{
	c_a_name[32],
	c_a_object,
}

new
	CrimeFraction		[ MAX_CRIMINAL ][ e_CRIME_FRACTION ],
	CrimeRank			[ MAX_CRIMINAL ][ MAX_RANKS ][ e_CRIME_RANK ],
	CNameLeader			[ MAX_CRIMINAL ][ 3 ][ MAX_PLAYER_NAME ],
	CMember				[ MAX_CRIMINAL ][ MAX_MEMBERS ][ e_CRIME_MEMBER ],
	CVehicle			[ MAX_CRIMINAL ][ MAX_FRACVEHICLES ][ e_CRIME_VEH ],
	GunDealer			[ MAX_POINTS ][ e_GUNDEALER ],
	CrimeOrder			[ MAX_CRIMINAL ][ 2 ][ e_GUN_ORDER ],
	DealerOrder			[ MAX_POINTS ][ 2 ][ e_GUN_ORDER ];

new	const
	crime_vehicles[][] = // Max 30
	{
		{//Банды
			412,413,419,439,440,459,466,467,474,479,
			483,491,492,517,518,516,534,535,536,542,
			551,566,567,575,576,600,0,0,0,0
		},
		{//Мафии
			400,405,409,440,421,426,445,468,505,507,
			529,533,540,545,546,547,550,555,579,580,
			585,587,0,0,0,0,0,0,0,0
		},
		{//Мотоклубы
			463,482,440,413,586, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		}
	},
	
	Float:crime_vehicles_spawn[][][] = 
	{
		{ 
			{ 126.5613, -228.4217, 2.0146, 179.8645 },
			{ 52.0552, -286.5670, 2.1392, 359.8896 },
			{ 103.0101, -288.1937, 2.0157, 357.8291 },
			{ 138.4312, -266.2670, 2.0158, 91.4675 },
			{ 164.3602, -294.7997, 2.0158, 270.1980 }
		},
		{
			{ -36.0146, -578.3973, -0.1773, 228.2476 },
			{ -44.5738, -586.8409, -0.1574, 225.3061 },
			{ -100.3164, -576.2678, -0.1841, 45.2811 },
			{ -88.0937, -588.6165, -0.1518, 224.8030 },
			{ -96.6650, -596.7802, -0.1449, 225.0151 }
		},
		{
			{ 424.8195, 2493.4226, 17.0471, 92.4815 },
			{ 424.7343, 2512.6604, 17.0468, 88.5380 },
			{ 381.8303, 2538.4492, 16.7168, 180.3289 },
			{ 352.6781, 2537.7917, 16.9033, 180.5451 },
			{ 338.2017, 2464.5747, 17.0266, 357.3731 }
		}
	},
	
	crime_vehicles_description[][] =
	{
		{ "Транспорт находится на старом складе в Blueberry." },
		{ "Транспорт находится у причала на Farms Connector." },
		{ "Транспорт находится на заброшенном аэродроме." }
	},
	
	weapons_info[][][ e_GUN_INFO ] = 
	{
		{	//Оружие
			{ 1, 14, 1800, 17 }, //M1911
			{ 1, 17, 2390, 7 },  //Пустынный орел
			{ 1, 25, 3000, 50 },  //TEC-9
			{ 2, 15, 2100, 17 }, //M1911 c глушителем
			{ 2, 18, 2150, 8 },  //Дробовик
			{ 3, 20, 3300, 8 },  //Боевой дробовик
			{ 3, 21, 2900, 50 },  //MAC-10
			{ 3, 23, 4500, 30 },  //АК
			{ 3, 27, 6500, 16 }, //Снайперская винтовка
			//{ 3, 103, 300, 5 }   //Дымовая шашка
			{ 0, 0, 0, 0 }
		},
		{	//Патроны
			{ 1, 35, 210, 51 }, //Патроны для M1911
			{ 1, 36, 175, 21 }, //Патроны для Пустынного орла
			{ 2, 37, 350, 24 }, //Дробовик,боевой дробовик
			{ 2, 38, 420, 100 },//TEC-9, MAC-10
			{ 3, 39, 540, 60 }, //Винтовка,АК
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 }
		}
	},
	
	crime_attach[][ e_CRIME_ATTACH ] = 
	{
		{ "Черная сумка", 11745 },
		{ "Хоккейная маска", 19036 },
		{ "Балаклава", 19801 },
		{ "Рация", 19942 },
		{ "Сумка с деньгами", 1550 },
		{ "Пакет с наркотиками (белый)", 1575 },
		{ "Пакет с наркотиками (красный)", 1580 },
		{ "Пакет с наркотиками (желтый)", 1577 },
		{ "Пакет с наркотиками (зеленый)", 1578 },
		{ "Пакет с наркотиками (синий)", 1579 },
		{ "Респиратор", 19472 },
		{ "Гаечный ключ", 19627 },
		{ "Молоток", 18635 },
		{ "Монтировка", 18634 },
		{ "Фонарик", 18641 },
		{ "Кобура", 19773 },
		{ "Сигарета", 19625 },
		{ "Сигара", 1485 },
		{ "Косяк", 3027 },
		{ "Бейсбольная бита", 19914 },
		{ "Бейсбольная бита c гвоздями", 2045 },
		{ "Пачка денег", 1212 },
		{ "Нож", 335 },
		{ "Светоотражающий жилет", 19904 }
	};
	
#define crime_change		"\
								"cBLUE"1. "cWHITE"Название\n\
								"cBLUE"2. "cWHITE"Лимит транспорта\n\
								"cBLUE"3. "cWHITE"Оружие гандиллера\n\
								"cBLUE"4. "cWHITE"Транспорт\
							"
							
#define weapon_change		"\
								"cWHITE"Нет\n\
								1 группа\n\
								2 группа\n\
								3 группа\n\
								"gbDialog"Информация\
							"
							
#define weapon_info			"\
								"cBLUE"Информация\n\n\
								"cWHITE"Данная настройка позволяет изменить возможное закупаемое оружие у гандилеров.\n\
								Просьба обратить внимание на масштабность группировки, только после этого изменять эту настройку\n\n\
								"cBLUE"1 группа: "cWHITE"M1911, Пустынный орел\n\
								"cBLUE"2 группа: "cWHITE"M1911, M1911 с глушителем, Пустынный орел, Дробовик, TEC-9\n\
								"cBLUE"3 группа: "cWHITE"M1911, M1911 с глушителем, Пустынный орел, Дробовик, Боевой дробовик\n\
								TEC-9, MAC-10, AK, Снайперская винтовка\
							"
							
#define crime_vehicle		"\
								"cWHITE"\t"cWHITE"Настройка\n\
								"cWHITE"Приобретение транспорта\t"cBLUE"%s\
							"
							
#define mpanel_dialog		"\
								"cBLUE"1. "cWHITE"Состав организации\n\
								"cBLUE"2. "cWHITE"Список рангов\n\
								"cBLUE"3. "cWHITE"Транспорт\n\
								"cBLUE"4. "cWHITE"Получить координаты дилера\
							"	
							
#define mpanel_settings		"\
								"cWHITE"Настройка\t"cWHITE"Значение\n\
								Изменить название\n\
								Прием игроков\t"cBLUE"%s"cWHITE"\n\
								Увольнение игроков\t"cBLUE"%s"cWHITE"\n\
								Использование аттачей\t"cBLUE"%s"cWHITE"\n\
								Спавн транспорта\t"cBLUE"%s"cWHITE"\n\
								Звонки гандилеру\t"cBLUE"%s"cWHITE"\n\
								Использование транспорта\n\
								Установка спавна ранга\n\
								Установить ранг игроку\t"cGRAY"/setrank\n\
								"gbDialog"Удалить ранг\
							"
							
#define mpanel_vehicles		"\
								"cWHITE"Действие\t"cWHITE"Аналог\n\
								Список транспорта\n\
								Приобретение транспорта\n\
								Вернуть транспорт на парковочное место\t"cGRAY"/fixcar"cWHITE"\n\
								Вернуть весь транспорт на парковочные места\t"cGRAY"/fixcarall"cWHITE"\n\
								Припарковать транспорт\t"cGRAY"/park"cWHITE"\n\
								Удалить транспорт\
							"	
							
#define dialog_gundealer	"\
								"cBLUE"Исходящий вызов\n\n\
								"cWHITE"Вы позвонили дилеру для заказа партии оружия.\n\n\
								Вашей криминальной группировке доступно оружие "cBLUE"%d"cWHITE" группы.\n\
								При заказе учитывайте, что в одной единице оружия 1 магазин патронов,\n\
								а в одной коробке с патронами - 2(3) магазина.\n\n\
								Обратите внимание, повторный звонок возможно совершить через "cBLUE"%d"cWHITE" дней.\
							"	
	
stock getIndexCrimeFraction( id )
{
	for( new i; i < MAX_CRIMINAL; i++ )
	{
		if( CrimeFraction[i][c_id] == id )
		{
			return i;
		}
	}
	
	return INVALID_PARAM;
}

stock PlayerLeaderCrime( playerid, crime )
{
	for( new i; i < 3; i++ )
	{
		if( Player[playerid][uCrimeL] == CrimeFraction[ crime ][c_id] && 
			Player[playerid][uID] == CrimeFraction[ crime ][c_leader][i] )
			return 1;
	}

	return STATUS_ERROR;
}

stock getCrimeRankId( playerid, crime )
{
	for( new i; i < CrimeFraction[crime][c_ranks]; i++ )
	{
		if( CrimeRank[crime][i][r_id] == Player[playerid][uCrimeRank] )
			return i;
	}

	return INVALID_PARAM;
}

stock SendCrimeLeaderMessage( crime, color, const message[] )
{
	foreach(new playerid : Player)
		if( IsLogged( playerid ) )
			if( PlayerLeaderCrime( playerid, crime ) )
				SendClient:( playerid, color, message );

	return 1;
}