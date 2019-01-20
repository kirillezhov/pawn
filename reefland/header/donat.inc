#define donat 				"\
								"cBLUE"1. "cWHITE"Информация\n\
								"cBLUE"2. "cWHITE"Обмен валюты\n\
								"cBLUE"3. "cWHITE"Премиум аккаунты\n\
								"cBLUE"4. "cWHITE"Дополнительные возможности\
							"
							
#define donatinfo			"\
								"cBLUE"1. "cWHITE"Общая информация\n\
								"cBLUE"2. "cWHITE"Баланс и пополнение счета\n\
								"cBLUE"3. "cWHITE"Мой премиум аккаунт\
							"
							
#define donatadd			""cWHITE" \t"cWHITE"Стоимость"cWHITE"\n\
								Изменение роли\t"cBLUE"%d RCoin"cWHITE"\n\
								Изменение пола\t"cBLUE"%d RCoin"cWHITE"\n\
								Изменение цвета кожи\t"cBLUE"%d RCoin"cWHITE"\n\
								Изменение национальности\t"cBLUE"%d RCoin"cWHITE"\n\
								Изменение страны рождения\t"cBLUE"%d RCoin"cWHITE"\n\
								Изменение возраста\t"cBLUE"%d RCoin"cWHITE"\n\
								Изменить никнейм\t"cBLUE"%d RCoin"cWHITE"\n\
								Изучить стиль боя\t"cBLUE"%d RCoin"cWHITE"\n\
								Изучить все стили боя\t"cBLUE"%d RCoin"cWHITE"\n\
								Снять предупреждение\t"cBLUE"%d RCoin"cWHITE"\n\
								Снять все предупреждения\t"cBLUE"%d RCoin"cWHITE"\n\
								Расторгнуть контракт на работе\t"cBLUE"%d RCoin"cWHITE"\n\
								Изменить номер телефона\t"cBLUE"%d RCoin"cWHITE"\
							"
							
#define donattotal 			""cBLUE"Общая информация"cWHITE"\n\n\
								На сервере присутствует возможность перевода реальных денег в RCoin - особая игровая валюта,\n\
								с помощью которой Вы сможете приобрести премиум аккаунт, а также другие дополнительные услуги,\n\
								позволяющие сделать комфортнее Вашу игру.\n\n\
								Для того, чтобы пополнить счет аккаунта Вам необходимо перейти на "cBLUE"reeflandrp.ru"cWHITE"\n\
								в "cBLUE"Профиль - Пополнение счета"cWHITE" и указать желаемую сумму по курсу 1 рубль = 1 RCoin.\n\n\
								"gbDialogError"Примечание:\n\
								"cWHITE"Приобретая премиум аккаунт с возможностями иметь 2 транспортных средства, 2 дома или 2 бизнеса,\n\
								учитывайте, что по истечении срока действия премиума 2-ое транспортное средство/2-ой дом/2-ой бизнес\n\
								автоматически продается и Вам возвращается его рыночная стоимость.\n\
								Чтобы избежать этого, продлите Ваш премиум аккаунт, не выходя с сервера\n\
								"cBLUE"/donat - Премиум аккаунты - Продлить премиум аккаунт"cWHITE".\n\n\
								Узнайте, когда истекает срок действия Вашего премиум аккаунта, используя "cBLUE"/time"cWHITE".\
							"
							
#define donatbalance		""cBLUE"Баланс и пополнение счета"cWHITE"\n\n\
								На Вашем счете - "cBLUE"%d"cWHITE" RCoin\n\n\
								Чтобы пополнить счет аккаунта Вам необходимо перейти на "cBLUE"reeflandrp.ru"cWHITE"\n\
								в "cBLUE"Профиль - Пополнение счета"cWHITE" и указать желаемую сумму по курсу 1 рубль = 1 RCoin.\n\n\
								"gbDialogError"Примечание:\n\
								"cWHITE"Для пополнения счета необязательно выходить с сервера, достаточно просто свернуть игру.\n\
								После успешной операции разверните игру и заново воспользуйтесь командой "cBLUE"/donat"cWHITE".\n\n\
								Если у Вас возникли проблемы с пополнением RCoin - обратитесь на форум\n\
								в раздел "cBLUE"Ошибки и недоработки - Проблемы с донатом"cWHITE".\n\n\
								"cRED"Обязательно делайте скриншот платежа!\
							"
							
#define donatpremium		"\
								"cBLUE"- "cWHITE"Стартовый\n\
								"cBLUE"- "cWHITE"Комфортный\n\
								"cBLUE"- "cWHITE"Оптимальный\n\
								"cBLUE"- "cWHITE"Настраиваемый\n\
								"gbDialog"Продлить премиум аккаунт\
							"
							
#define donatmoney			""cBLUE"Обмен валюты"cWHITE"\n\n\
								Обмен валюты - это перевод Ваших RCoin в обычную игровую валюту.\n\
								Курс перевода составляет "cBLUE"1 RCoin = $100"cWHITE".\n\n\
								На Вашем счете - "cBLUE"%d"cWHITE" RCoin\n\n\
								"cGRAY"Укажите, сколько RCoin вы хотите обменять:\
							"			

// -- Цены --						
const
	PRICE_UNWARN = 60,				//Снятие варна
	PRICE_UNWARN_ALL = 100,			//Снятие всех варнов
	PRICE_CHANGE_ROLE = 45,			//Роль (национальность, возраст, страна рождения, пол)
	PRICE_CHANGE_NATION = 10, 		//Национальность
	PRICE_CHANGE_AGE = 20,			//Возраст
	PRICE_CHANGE_COUNTRY = 5,		//Страна рождения
	PRICE_CHANGE_SEX = 15,			//Пол
	PRICE_CHANGE_COLOR = 15,		//Цвет кожи
	PRICE_CHANGE_NAME = 40,			//Имя
	PRICE_STYLE = 50,				//Стиль боя
	PRICE_STYLE_ALL = 150,			//Все стили боя
	PRICE_UNJOB = 15,				//Шестичасовой контракт
	PRICE_NUMBER_CAR = 70,			//Номер транспорта
	PRICE_NUMBER_PHONE = 60;		//Номер телефона

							
enum e_PREMIUM
{
	prem_id,				// Икремент премиума
	prem_time,				// Время истечения премиума
	prem_type,				// Тип премиума
	
	prem_color,				// Цвет премиума
	prem_gmoney,			// GMoney в час
	prem_bank,				// Процент к банку
	prem_salary,			// Процент к зарплате
	prem_benefit,			// Процент к пособию по безработице
	prem_mass,				// Дополнительный вес в инвентарь
	
	prem_admins,			// Доступ к /admins
	prem_supports,			// Доступ к /supports
	prem_h_payment,			// Дополнительные дни для оплаты дома
	
	prem_car,				// Возможность иметь 2 машины
	prem_house,				// Возможность иметь 2 дома
	prem_business,			// Возможность иметь 2 бизнеса
	
	prem_house_property,	// Дополнительный процент к продаже имущества
	
	prem_drop_retreature,	// Процент снижения ретекстура
	prem_drop_tuning,		// Процент снижения тюнинга
	prem_drop_repair,		// Процент снижения ремонта
	prem_drop_payment,		// Процент снижения комунальных услуг
}

enum e_PREMIUM_INFO
{
	prem_name	[ 16 ],
	prem_price,
	
	prem_color		[2], //+
	prem_gmoney		[2], //+
	prem_bank		[2], //+
	prem_salary		[2], //+
	prem_benefit	[2], //+
	
	prem_mass		[2], //+
	prem_admins		[2], //+
	prem_supports	[2], //+
	prem_h_payment	[2], //+
	
	prem_car		[2], //+
	prem_house		[2], //+
	prem_business	[2], //+
	
	prem_house_property		[2], //+
	
	prem_drop_retreature	[2], //+
	prem_drop_tuning		[2], //+
	prem_drop_repair		[2], //+
	prem_drop_payment		[2], //+
}

enum e_VALUE_PREMIUM
{
	value_amount,		//Количество выбранных настроек
	value_gmoney,		//Количество RCoin
	value_days,			//Срок действия в днях
}

new
	Premium			[ MAX_PLAYERS ][ e_PREMIUM ],
	TimePremium		[ MAX_PLAYERS ][ e_PREMIUM ],
	ValuePremium	[ MAX_PLAYERS ][ e_VALUE_PREMIUM ];
			
new
	premium_info[][ e_PREMIUM_INFO ] = 
	{
		{ "Нет", 0, 			{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },	{ 0, 0 }, { 0, 0 }, 	{ 0, 0 }, { 0, 0 },
		{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },  	{ 0, 0 },  { 0, 0 },  { 0, 0 },  { 0, 0 } },
		
		{ "Стартовый", 180, 	{ 1, 5 }, { 0, 0 }, { 1, 10 }, { 7, 15 }, { 20, 5 }, { 2, 30 }, { 0, 0 }, 	{ 1, 10 }, { 0, 0 },
		{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 10, 30 }, 	{ 15, 15 },  { 15, 20 },  { 10, 20 },  { 10, 20 } },
		
		{ "Комфортный", 400, 	{ 2, 5 }, { 0, 0 }, { 3, 15 }, { 12, 23 }, { 40, 7 }, { 4, 40 }, { 1, 10 }, 	{ 1, 10 }, { 5, 40 }, 
		{ 1, 50 }, { 1, 40 }, { 0, 0 }, { 20, 50 }, { 20, 20 },  { 20, 30 },  { 15, 30 },  { 15, 30 } },
		
		{ "Оптимальный", 600, 	{ 3, 5 }, { 2, 70 }, { 7, 20 }, { 20, 30 }, { 80, 10 }, { 6, 50 }, { 1, 10 }, 	{ 1, 10 }, { 10, 55 }, 
		{ 1, 50 }, { 1, 40 }, { 1, 40 }, { 30, 60 }, { 30, 30 },  { 30, 40 },  { 20, 40 },  { 20, 40 } },
		
		{ "Настраиваемый", 0, 	{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },	{ 0, 0 }, { 0, 0 }, 	{ 0, 0 },  { 0, 0 },
		{ 0, 0 }, { 0, 0 }, { 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 },  { 0, 0 },  { 0, 0 },  { 0, 0 } }
	},
	
	premium_color[][] = 
	{
		{"{FFFFFF}"},
		{"{46BD38}"},
		{"{E05A5A}"},
		{"{DEB047}"}
	};