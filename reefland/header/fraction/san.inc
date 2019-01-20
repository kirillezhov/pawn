const
	NEWS_NUMBER = 777;
	
enum e_AD 
{
	a_text[ 100 ],
	a_name[ MAX_PLAYER_NAME ],
	a_phone,
	bool:a_used,
}

new 
	NETWORK_ZONE,
	NETWORK_COFFER,
	NETWORK_ADPRICE,
	bool:ETHER_CALL,
	bool:ETHER_SMS,
	AD				[ MAX_ADVERT_INFO ][ e_AD ],
	ETHER_STATUS 	= INVALID_PARAM,
	ETHER_CALLID	= INVALID_PARAM;

#define dialog_sanpanel		"\
								"cWHITE"Список объявлений - "cBLUE"%d новых\n\
								"cWHITE"Прямой эфир - %s\n\
								"cWHITE"Пригласить игрока в эфир\n\
								"cWHITE"Выгнать игрока с эфира\n\
								"cWHITE"Прием звонков в эфире - %s\n\
								"cWHITE"Прием смс в эфире - %s\n\
								"cWHITE"Изменить стоимость объявления - "cBLUE"$%d\n\
								"cWHITE"Бюджет организации - "cBLUE"$%d\
							"

#define dialog_advert		"\
								"cBLUE"1. "cGRAY"Отправить объявление\n\
								"cBLUE"2. "cGRAY"Редактировать объявление\n\
								"cBLUE"3. "cGRAY"Удалить объявление\
							"