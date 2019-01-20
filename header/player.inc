
const
	MAX_HISTORY = 20;

enum uInfo 
{
	uID,
	uName							[ MAX_PLAYER_NAME ],
	uRPName							[ MAX_PLAYER_NAME + 2 ],
	uHash							[ 64 + 1 ],
	uLevel,							//Уровень
	uSex,
	uColor,
	uNation,
	uCountry,
	uRole,
	uAge,
	uSettings						[ MAX_PLAYER_SETTINGS + 1 ],
	uMoney,
	uJob,
	uConfirm,						//Код подтверждения
	
	Float:uP						[ 3 ],
	uLastTime,
	
	uInt							[ 2 ],
	
	uSuspect,
	uSuspectReason					[ 64 ],
	
	uLastIP							[ 16 ],
	uRegIP							[ 16 ],
	uLeader,
	uMember,
	uRank,
	uJailSettings					[ 5 ],
	uWarn,
	uMute,
	uRegDate,
	uBank,
	uEmail							[ 64 ],
	Float:uHP,
	Float:uArmor,
	uPM,
	uOOC,
	uRO,
	uRadio,
	uDMJail,
    uGMoney,
	uCheck,
	
	uStyle							[ 5 ],
	uChangeStyle,
	
	uRadioChannel,
	uRadioSubChannel,
	uRetest,
	uBMute,
	uPayTime,
	uPinCode,
	uAnimList						[ 10 ],
	uAnimListParam					[ 10 ],
	uDeath,
	uCrimeL,								// Лидерка крайма
	uCrimeM,								// Состоит в крайме
	uCrimeRank,								// Ранг
	uHouseEvict,							// Дом, в который игрок подселен
	
	// Тюрьма
	uArrest, 								// Игрок отбывает заключение
	uArrestCamera,							// Камера игрока
	uArrestTime,							// Время которое будет сидеть игрок
	uArrestStatDate,						// Дата сколько сидит игрок
	uArrestStat,							// Статистика пишет сколько раз отбывал наказание игрок
	uArrestReason					[ 64 ], // Статья по которой сидит
	uArrestCooler,							// Карцер
	
	uJail,									// Посадить у копов и Шерифов
	uJailTime,								// Время сколько сидеть у копов и шерифов
	
	uPame							[ 128 ],
	uHours,									// Количество часов, проведенных в игре
	
	Float: tPos						[ 3 ],
	tSpectate,
	tFirstTime,
	tIP								[ 16 ],
	tEnterVehicle,
	tEnterVehicleTime,
	Text3D: tAction,
	tActionText						[ 128 ],
	tDialogId,
	tTrueShot,
	tFalseShot,
	tPing,
	tSpeed,
	tVehicleSpeed,
	bool:tEther,					//Эфиры SAN
	
	tHouse							[ MAX_PLAYER_HOUSE ],
	tVehicle						[ MAX_PLAYER_VEHICLES ],
	tBusiness						[ MAX_PLAYER_BUSINESS ], 
	
	bool:jTaxi,						//Статус заявки в службу такси
	bool:jMech,						//Статус заявки в СТО
	bool:jPolice,					//Статус заявки в 911
	Float:tgpsPos					[ 3 ],
}

enum e_PAYMENT
{
	HistoryTime,							// Время платежа
	HistoryName						[ 32 ],	// Имя платежа
}

enum e_VEH_POS
{
	Float: vp_x,
	Float: vp_y,
	Float: vp_z,
	Float: vp_z_angle,
	Float: vp_distance,
}

new 
	Player							[ MAX_PLAYERS ][ uInfo ],
	Payment							[ MAX_PLAYERS ][ MAX_HISTORY ][ e_PAYMENT ],
	actor_skin						[ MAX_PLAYERS ];
	
new
    Text:MenuPlayer					[ 21 ],
    Text:SpeedFon					[ 3 ],
    PlayerText:menuPlayer			[ 3 ][ MAX_PLAYERS ],
    PlayerText:Speed				[ 7 ][ MAX_PLAYERS ];
	
new 
	g_player_gun_protect			[ MAX_PLAYERS char ],
	g_player_airbreak_protect		[ MAX_PLAYERS char ],
	g_player_carshot				[ MAX_PLAYERS char ],
	g_player_tp_in_car				[ MAX_PLAYERS char ],
	g_player_attach_mode			[ MAX_PLAYERS char ],
	g_player_edit_mode				[ MAX_PLAYERS char ],
	g_player_hp_protect				[ MAX_PLAYERS char ],
	g_player_login					[ MAX_PLAYERS char ] = { 0, ... },
	g_player_gps					[ MAX_PLAYERS ] = { 0, ... },
	g_player_interaction			[ MAX_PLAYERS char ] = { 0, ... },
	g_player_taser					[ MAX_PLAYERS char ],
	ac_vehicle_pos					[ MAX_VEHICLES ][ e_VEH_POS ];

	