Dobject_OnGameModeInit() 
{
	//Объект Де Морган
	CreateObject(18759, 3959.89966, -942.35260, 2.84273,   0.00000, 0.00000, 0.00000);
	
    CreateDynamicPickup(1239,23,1072.4669,-342.6463,2797.7004,-1); // Центр купли - продажи
    //CreateDynamicPickup(1239,23,1065.0851,-339.9360,2797.7010,-1); // Центр купли - пикап2
	
    //warehouse
    CreateDynamicPickup(1239,23,2596.7729,-833.8965,2879.5870,-1); // Центр купли - продажи'
    CreateDynamicPickup(1239,23,2776.6360,-716.4243,2883.0959,-1); // Центр купли - продажи
    CreateDynamicPickup(1239,23,-2842.7400,-55.5776,2999.0289,-1); // Центр купли - продажи
    CreateDynamicPickup(1239,23,-2737.1760,841.4919,2996.6509,-1); // Центр купли - продажи
    CreateDynamicPickup(1239,23,2623.4070,-183.9477,2879.5859,-1); // Центр купли - продажи

    CreateDynamic3DTextLabel("Агентство недвижимости",0xFFFFFFFF,1072.4669,-342.6463,797.7004,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1);
	
	//Кассы банка
	for( new i; i < sizeof cashbox_info; i++ )
	{
		format:g_string( "%s", cashbox_info[i][c_name] );
		CreateDynamic3DTextLabel( g_string,0xFFFFFFFF,cashbox_info[i][c_cashbox_pos][0],cashbox_info[i][c_cashbox_pos][1],cashbox_info[i][c_cashbox_pos][2],5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1,-1);
	}
	
	//Пикап покупки авто
	CreateDynamicPickup( 1239, 23, PICKUP_SALON, -1 );
	CreateDynamic3DTextLabel( "Покупка транспорта", 0xFFFFFFFF, PICKUP_SALON, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	//Пикап утилизации
	CreateDynamicPickup( 1239, 23, PICKUP_UTILIZATION, -1 );
	CreateDynamic3DTextLabel( "Утилизация транспорта", 0xFFFFFFFF, PICKUP_UTILIZATION, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	//Пикап центр лизензирования
	CreateDynamicPickup( 1239, 23, PICKUP_LICENSES, -1 );
	CreateDynamic3DTextLabel( "Получение лицензий", 0xFFFFFFFF, PICKUP_LICENSES, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	//Пикап штрафстоянки
	CreateDynamicPickup( 1239, 23, PICKUP_PARKING, -1 );
	CreateDynamic3DTextLabel( "Стол информации", 0xFFFFFFFF, PICKUP_PARKING, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	//Пикап приемной мэрии
	CreateDynamicPickup( 1239, 23, PICKUP_RECEPTION, -1 );
	CreateDynamic3DTextLabel( "Приемная мэра", 0xFFFFFFFF, PICKUP_RECEPTION, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	//Пикап оружейного магазина
	CreateDynamicPickup( 1239, 23, PICKUP_WEAPON, -1 );
	
	//Пикап в минимаркете АЗС
	CreateDynamicPickup( 1239, 23, PICKUP_REFILL, -1 );
	CreateDynamicPickup( 1239, 23, PICKUP_REFILL_2, -1 );

	//Пикапы в полицейском департаменте
	CreateDynamicPickup( 1239, 23, PICKUP_POLICE, -1 );
	CreateDynamic3DTextLabel( "Стол информации", 0xFFFFFFFF, PICKUP_POLICE, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	CreateDynamicPickup( 1239, 23, PICKUP_POLICE_2, -1 );
	CreateDynamic3DTextLabel( "Стол информации", 0xFFFFFFFF, PICKUP_POLICE_2, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	//Боты на спавне
	new
		actor;
		
	actor =  CreateActor( 236, 1517.8912, -1172.0548, 24.0781, 139.4900 );
	ApplyActorAnimation( actor, "CAMERA","camstnd_cmon",4.0,1,0,0,0,0 );
	
	actor =  CreateActor( 235, 1465.6993, -1179.5114, 23.8256, 306.8917 );
	ApplyActorAnimation( actor, "CAMERA","camstnd_cmon",4.0,1,0,0,0,0 );
	
	CreateDynamic3DTextLabel( "Помощь '"cBLUE"H"cWHITE"'", 0xFFFFFFFF, 1517.8912, -1172.0548, 24.5781, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	CreateDynamic3DTextLabel( "Помощь '"cBLUE"H"cWHITE"'", 0xFFFFFFFF, 1465.6993, -1179.5114, 24.3256, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1 );
	
	actor = CreateActor(76,1451.0986,-1004.1474,2725.8760,182.5154); // Банк
	SetActorVirtualWorld( actor, 75 );
	ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
	
	actor = CreateActor(98,1455.7592,-1004.2281,2725.8760,165.4490); // Банк
	SetActorVirtualWorld( actor, 75 );
	ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
	
	actor = CreateActor(150,1463.7074,-1004.3875,2725.8760,191.6439); // Банк
	SetActorVirtualWorld( actor, 75 );
	ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
	
	actor = CreateActor(71,1466.1984,-1011.6840,2725.8760,84.0860); // Банк
	SetActorVirtualWorld( actor, 75 );
	
	actor = CreateActor(71,1445.5970,-1035.7144,2725.8760,264.2937); // Банк
	SetActorVirtualWorld( actor, 75 );
	ApplyActorAnimation( actor,"COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1 );

	for( new i = 1004; i < 1008; i++ )
	{
		actor = CreateActor(119,2510.2446,1228.4462,1801.0859,178.5761); // АЗС интерьер
		SetActorVirtualWorld( actor, i );
	}
	
	actor = CreateActor(128,664.1229,-566.7401,16.3363,179.1579); // АЗС на улице

	for( new i = 1; i < 6; i++ )
	{
		actor = CreateActor(72,1037.1707,-304.2475,2076.6460,182.9827); // /sit...Склад
		SetActorVirtualWorld( actor, i );
		ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
		
		actor = CreateActor(67,1028.1823,-304.7317,2076.6460,204.4148); // /sit...Склад
		SetActorVirtualWorld( actor, i );
		ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
		
		actor = CreateActor(98,1032.0647,-303.2000,2076.6460,358.0306); // Склад
		SetActorVirtualWorld( actor, i );
	}
	
	actor = CreateActor(71,-502.8904,-75.3671,61.7376,72.9423); // лесопилка улица
	
	actor = CreateActor(162,-465.1520,-81.2150,60.0411,171.3716); // лесопилка улица
	ApplyActorAnimation( actor,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0 );
	
	actor = CreateActor(27,-467.5204,-87.1297,60.0965,9.8363); // лесопилка улица
	ApplyActorAnimation( actor,"COP_AMBIENT","Copbrowse_in",4.1,0,1,1,1,0 );
	
	actor = CreateActor(27,-452.8084,-79.5894,61.5749,179.0169); // Лесопилка улица
	ApplyActorAnimation( actor,"GANGS","leanIDLE",4.0,0,0,1,1,0 );
	
	actor = CreateActor(258,-509.2945,-67.5010,1805.4299,84.9350); // /crossarms...Лесопилка инт
	SetActorVirtualWorld( actor, 50 );
	ApplyActorAnimation( actor,"COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1 );
	
	actor = CreateActor(44,-504.6394,-66.8343,1805.4299,116.6679); // /sit...Лесопилка инт
	ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
	SetActorVirtualWorld( actor, 50 );
	
	actor = CreateActor(27,-519.7987,-75.3597,1801.0778,30.5607); // /copa...Лесопилка инт
	SetActorVirtualWorld( actor, 50 );
	ApplyActorAnimation( actor,"COP_AMBIENT","Copbrowse_in",4.1,0,1,1,1,0 );
	
	actor = CreateActor(27,-522.7399,-79.4216,1801.0778,173.0635); // Лесопилка инт
	SetActorVirtualWorld( actor, 50 );

	actor = CreateActor(222,1335.2472,395.8866,19.7529,68.1990); // Утилизация
	
	for( new i = 10; i < 13; i++ )
	{
		actor = CreateActor(150,1488.9301,764.4249,2001.0859,270.5229); // Автосалон инт
		SetActorVirtualWorld( actor, i );
	}
	
	for( new i = 113; i < 117; i++ )
	{
		actor = CreateActor(179,-1503.7958,93.5207,3201.9858,355.8047); // Оружейный магазин
		SetActorVirtualWorld( actor, i );
	}
	
	actor = CreateActor(9,1145.9255,-1341.0416,2201.0859,271.6440); // Пассажирская компания
	SetActorVirtualWorld( actor, 3 );
	
	actor = CreateActor(93,1145.8997,-1338.7997,2201.0859,271.2471); // /sit...Пассажирская компания
	SetActorVirtualWorld( actor, 3 );
	ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
	
	actor = CreateActor(177,588.0640,-1539.4636,2001.0859,89.4863); // СТО инт
	SetActorVirtualWorld( actor, 10 );

	actor = CreateActor(170,1073.8457,-342.3788,2797.7000,79.2354); // /sit...Агентство недвижимости
	SetActorVirtualWorld( actor, 13 );
	ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
	
	actor = CreateActor(216,1063.5441,-340.5923,2797.7000,272.5405); // Агентство недвижимости
	SetActorVirtualWorld( actor, 13 );
	
	actor = CreateActor(186,1077.1406,-348.4432,2797.7000,207.0534); // Агентство недвижимости
	SetActorVirtualWorld( actor, 13 );
	
	actor = CreateActor(185,1078.9106,-348.3918,2797.7000,154.2666); // /crossarms...Агентство недвижимости
	SetActorVirtualWorld( actor, 13 );
	ApplyActorAnimation( actor,"COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1 );
	
	actor = CreateActor(240,1079.4662,-339.0892,2797.7000,9.3640); // /sit...Агентство недвижимости
	SetActorVirtualWorld( actor, 13 );
	ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );
	
	actor = CreateActor(250,1082.1580,-346.2502,2797.7000,129.2255); // /sit...Агентство недвижимости
	SetActorVirtualWorld( actor, 13 );
	ApplyActorAnimation( actor,"PED","SEAT_down",4.0,0,0,1,1,0 );

	for( new i = 31; i < 34; i++ )
	{
		actor = CreateActor(194,-488.1833,-261.5951,3095.8960,90.3300); // Магазин мебели
		SetActorVirtualWorld( actor, i );
		actor = CreateActor(240,-488.1824,-263.1257,3095.8960,89.9331); // Магазин мебели
		SetActorVirtualWorld( actor, i );
	}
	
	actor = CreateActor(190,1687.2175,-1457.9667,1401.2169,358.7936); // Служба доставки
	SetActorVirtualWorld( actor, 51 );
	
	actor = CreateActor(192,1685.1285,-1457.9640,1401.2169,358.7936); // Служба доставки
	SetActorVirtualWorld( actor, 51 );
}