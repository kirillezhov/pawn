function Police_OnGameModeInit()
{
	mysql_tquery( mysql, "SELECT * FROM `"DB_APPLICATION"` ORDER BY `a_id`", "LoadApplycation" );
	mysql_tquery( mysql, "SELECT * FROM `"DB_VEHICLES_ARREST"` ORDER BY `arrest_id`", "LoadArrest" );
	
	mysql_tquery( mysql, "SELECT * FROM `"DB_SUSPECT"` ORDER BY `s_id`", "LoadPlayerSuspect" );
	mysql_tquery( mysql, "SELECT * FROM `"DB_SUSPECT_VEHICLE"` ORDER BY `s_id`", "LoadVehicleSuspect" );
	
	mysql_tquery( mysql, "SELECT * FROM `"DB_RECOURSE"`", "LoadRecourse" );
	
	return 1;
}

function Police_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED(KEY_WALK) )
	{
		if( IsPlayerInRangeOfPoint( playerid, 1.5, PICKUP_PARKING ) )
		{
			showPlayerDialog( playerid, d_police + 9, DIALOG_STYLE_LIST, " ", ""cWHITE"\
				Информация\n\
				Забрать свой транспорт", "Далее", "Закрыть" ); 
		}
		else if( IsPlayerInRangeOfPoint( playerid, 1.5, PICKUP_POLICE ) || IsPlayerInRangeOfPoint( playerid, 1.5, PICKUP_POLICE_2 ) )
		{
			showPlayerDialog( playerid, d_police, DIALOG_STYLE_LIST, "Стол информации", info_dialog, "Выбрать", "Закрыть" );
		}
	}
	
	return 1;
}

function LoadPlayerPenalty( playerid )
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		if( !Penalty[playerid][i][pen_id] )
		{
			Penalty[playerid][i][pen_id] = cache_get_field_content_int( i, "pen_id", mysql );
			Penalty[playerid][i][pen_type] = cache_get_field_content_int( i, "pen_type", mysql );
			Penalty[playerid][i][pen_price] = cache_get_field_content_int( i, "pen_price", mysql );
			Penalty[playerid][i][pen_date] = cache_get_field_content_int( i, "pen_date", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "pen_name", g_small_string, mysql );
			strmid( Penalty[playerid][i][pen_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "pen_descript", g_small_string, mysql );
			strmid( Penalty[playerid][i][pen_descript], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
	}

	return 1;
}

function LoadArrest()
{
	new 
		rows,
		fields,
		amount;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		if( !VArrest[i][arrest_id] )
		{
			VArrest[i][arrest_id] = cache_get_field_content_int( i, "arrest_id", mysql );
			VArrest[i][arrest_vehid] = cache_get_field_content_int( i, "arrest_vehid", mysql );
			VArrest[i][arrest_date] = cache_get_field_content_int( i, "arrest_date", mysql );
			VArrest[i][arrest_pos] = cache_get_field_content_int( i, "arrest_pos", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "arrest_name", g_small_string, mysql );
			strmid( VArrest[i][arrest_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			amount++;
		}
	}
	
	printf( "[Load] Vehicles arrested load - %d", amount );
	return 1;
}

function LoadVehicleSuspect()
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		SuspectVehicle[i][s_id] = cache_get_field_content_int( i, "s_id", mysql );
		SuspectVehicle[i][s_date] = cache_get_field_content_int( i, "s_date", mysql );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "s_name", g_small_string, mysql );
		strmid( SuspectVehicle[i][s_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "s_officer_name", g_small_string, mysql );
		strmid( SuspectVehicle[i][s_officer_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "s_descript", g_small_string, mysql );
		strmid( SuspectVehicle[i][s_descript], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	}
	
	return 1;
}

function LoadPlayerSuspect()
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		SuspectPlayer[i][s_id] = cache_get_field_content_int( i, "s_id", mysql );
		SuspectPlayer[i][s_date] = cache_get_field_content_int( i, "s_date", mysql );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "s_name", g_small_string, mysql );
		strmid( SuspectPlayer[i][s_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "s_officer_name", g_small_string, mysql );
		strmid( SuspectPlayer[i][s_officer_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "s_descript", g_small_string, mysql );
		strmid( SuspectPlayer[i][s_descript], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	}

	return 1;
}

function InsertPenalty( playerid, penalty )
{
	Penalty[playerid][penalty][pen_id] = cache_insert_id();
	return 1;
}

function InsertArrest( arrestid )
{
	VArrest[arrestid][arrest_id] = cache_insert_id();
	return 1;
}

stock ShowPlayerPenalties( playerid, dialogid, btn[] = "Закрыть" )
{
	clean:<g_string>;
	new
		count,
		year,
		month,
		day;
	
	format:g_small_string( ""cWHITE"Штрафы "cBLUE"%s"cWHITE"\n", Player[playerid][uRPName] );
	strcat( g_string, g_small_string );
	
	for( new i; i < MAX_PENALTIES; i++ )
	{
		if( Penalty[playerid][i][pen_id] )
		{
			gmtime( Penalty[playerid][i][pen_date], year, month, day );
		
			if( Penalty[playerid][i][pen_type] != 2 )
			{
				format:g_small_string( "\n"cBLUE"%d. "cWHITE"%s\t%02d.%02d.%d - "cBLUE"$%d (%s)", 
				count + 1, Penalty[playerid][i][pen_descript], day, month, year,
				Penalty[playerid][i][pen_price], 
				!Penalty[playerid][i][pen_type] ? ("не оплачен") : ("оплачен") );
			}
			else
			{
				format:g_small_string( "\n"cBLUE"%d. "cWHITE"%s\t%02d.%02d.%d - штраф-предупреждение", 
				count + 1, Penalty[playerid][i][pen_descript], day, month, year );
			}
			strcat( g_string, g_small_string );
			
			count++;
		}
	}
	
	if( !count )
	{
		SendClient:( playerid, C_WHITE, !""gbDefault"У Вас нет штрафов." );
		return showPlayerDialog( playerid, d_police, DIALOG_STYLE_LIST, "Стол информации", info_dialog, "Выбрать", "Закрыть" );
	}

	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_MSGBOX, " ", g_string, btn, "" );
	return 1;
}

stock ShowPenalties( playerid )
{
	clean:<g_string>;
	new
		count,
		year,
		month,
		day;
	
	strcat( g_string, ""cWHITE"Дата\t"cWHITE"Сумма\t"cWHITE"Описание" );
	
	for( new i; i < MAX_PENALTIES; i++ )
	{
		if( Penalty[playerid][i][pen_id] && !Penalty[playerid][i][pen_type] )
		{
			gmtime( Penalty[playerid][i][pen_date], year, month, day );
		
			format:g_small_string( "\n"cGRAY"%d. "cWHITE"%02d.%02d.%d\t"cBLUE"$%d\t"cWHITE"%s", 
				Penalty[playerid][i][pen_id], day, month, year,
				Penalty[playerid][i][pen_price],
				Penalty[playerid][i][pen_descript] );

			strcat( g_string, g_small_string );
			g_dialog_select[playerid][count] = i;
			
			count++;
		}
	}
	
	if( !count )
	{
		SendClient:( playerid, C_WHITE, !""gbDefault"У Вас нет неоплаченных штрафов." );
		return showPlayerDialog( playerid, d_bank + 8, DIALOG_STYLE_LIST, "Оплата услуг", dialog_pay, "Выбрать", "Назад" );
	}

	showPlayerDialog( playerid, d_bank + 14, DIALOG_STYLE_TABLIST_HEADERS, "Неоплаченные штрафы", g_string, "Оплатить", "Назад" );
	return 1;
}

stock ShowApplications( playerid )
{
	clean:<g_string>;
	
	new
		count,
		year,
		month,
		day;
		
	strcat( g_string, ""cWHITE"Имя заявителя\t"cWHITE"Уровень\t"cWHITE"Дата" );
		
	for( new i; i < MAX_APPLICATION; i++ )
	{
		if( PApply[i][a_id] )
		{
			gmtime( PApply[i][a_date], year, month, day );
		
			format:g_small_string( "\n"cBLUE"%d. "cWHITE"%s\t%d уровень\t%02d.%02d.%d", 
				count + 1, PApply[i][a_name], PApply[i][a_level], day, month, year );
			strcat( g_string, g_small_string );
			
			g_dialog_select[playerid][count] = i;
			count++;
		}
	}
	
	if( !count ) return SendClient:( playerid, C_WHITE, !""gbError"Заявки на разрешение ношения оружия отсутствуют." );
	
	showPlayerDialog( playerid, d_police + 5, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Выбрать", "Закрыть" );
	
	return 1;
}

stock ShowPlayerInformation( playerid, showid, dialogid = INVALID_PARAM )
{
	new
		bool:status = false,
		vehicleid,
		model,
		businessid,
		index,
		license_date[3];
		
	clean:<g_big_string>;

	format:g_small_string( ""cWHITE"Информация о "cBLUE"%s\n\n", Player[showid][uRPName] );
	strcat( g_big_string, g_small_string );
					
	format:g_small_string( ""cWHITE"Возраст: "cBLUE"%d %s\n", Player[showid][uAge], AgeTextEnd( Player[playerid][uAge]%10 ) );
	strcat( g_big_string, g_small_string );
				
	if( GetPhoneNumber( showid ) )
	{
		format:g_small_string( ""cWHITE"Телефон: "cBLUE"%d\n", GetPhoneNumber( showid ) );
	}
	else
		format:g_small_string( ""cWHITE"Телефон: "cBLUE"нет\n" );
	strcat( g_big_string, g_small_string );
			
	if( Player[showid][uArrestStat] )
		format:g_small_string( ""cWHITE"Судимости: "cBLUE"%d\n", Player[showid][uArrestStat] );
	else
		format:g_small_string( ""cWHITE"Судимости: "cBLUE"нет\n", Player[showid][uArrestStat] );
	strcat( g_big_string, g_small_string );
	
	if( Player[showid][uSuspect] )
	{
		format:g_small_string( ""cWHITE"Розыск: "cBLUE"Да"cGRAY" (%s)\n", Player[showid][uSuspectReason] );
		strcat( g_big_string, g_small_string );	
	}
	else
	{
		strcat( g_big_string, ""cWHITE"Розыск: "cBLUE"нет\n" );	
	}

	strcat( g_big_string, "\n"cWHITE"Личный транспорт:" );
					
	for( new j; j < MAX_PLAYER_VEHICLES; j++ )
	{
		if( Player[showid][tVehicle][j] != INVALID_VEHICLE_ID ) 
		{
			vehicleid = Player[showid][tVehicle][j];
			model = GetVehicleModel( vehicleid );
				
			if( isnull( Vehicle[vehicleid][vehicle_number] ) )
				format:g_small_string( "\n%s %s\tгос.номер: нет", VehicleInfo[ model - 400 ][v_type], VehicleInfo[ model - 400 ][v_name] );
			else
				format:g_small_string( "\n%s %s\tгос.номер: %s", VehicleInfo[ model - 400 ][v_type], VehicleInfo[ model - 400 ][v_name], Vehicle[vehicleid][vehicle_number] );
				
			strcat( g_big_string, g_small_string );
			status = true;
		}
	}
					
	if( !status ) strcat( g_big_string, "\nнет" );
					
	status = false;
	strcat( g_big_string, "\n\n"cWHITE"Дом:" );
	
	for( new j; j < MAX_PLAYER_HOUSE; j++ ) 
	{
		if( Player[showid][tHouse][j] != INVALID_PARAM )
		{
			new
				house = Player[showid][tHouse][j];
		
			format:g_small_string(  "\n"cGRAY"%s[%d]"cWHITE"", !HouseInfo[house][hType] ? ("Дом") : ("Квартира"), HouseInfo[house][hID] ), 
			strcat( g_big_string, g_small_string );
		
			status = true;
		}
	}
	
	if( !status ) strcat( g_big_string, "\nнет" );
	
	status = false;
	strcat( g_big_string, "\n\n"cWHITE"Бизнес:" );
					
	for( new j; j < MAX_PLAYER_BUSINESS; j++ ) 
	{
		if( Player[showid][tBusiness][j] != INVALID_PARAM ) 
		{
			businessid = Player[showid][tBusiness][j];
					
			format:g_small_string( "\n%s\t%s #%d", GetBusinessType( businessid ), BusinessInfo[businessid][b_name], BusinessInfo[businessid][b_id] );
							
			strcat( g_big_string, g_small_string );
			status = true;
		}
	}
					
	if( !status ) strcat( g_big_string, "\nнет" );
	
	strcat( g_big_string, "\n\nЛицензии:\n" );
	
	switch( GetStatusPlayerLicense( showid, LICENSE_DRIVE ) )
	{
		case 1:	
		{
			index = GetIndexPlayerLicense( showid, LICENSE_DRIVE );
		
			gmtime( License[showid][index][lic_gave_date], license_date[0], license_date[1], license_date[2] );
			
			format:g_small_string(" - водительское удостоверение: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0] );
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( showid, LICENSE_DRIVE );
		
			gmtime( License[showid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - водительское удостоверение: "cRED"#%d изъято %02d.%02d.%d ( %s )"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[showid][index][lic_taked_by] ); 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	switch( GetStatusPlayerLicense( showid, LICENSE_AIR ) )
	{
		case 1:	
		{
			index = GetIndexPlayerLicense( showid, LICENSE_AIR );	
				
			gmtime( License[showid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - лицензия пилота: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0] ); 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( showid, LICENSE_AIR );
		
			gmtime( License[showid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - лицензия пилота: "cRED"#%d изъята %02d.%02d.%d ( %s )"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[showid][index][lic_taked_by] ); 
			strcat( g_big_string, g_small_string ); 
		}
	}

	switch( GetStatusPlayerLicense( showid, LICENSE_WATER ) )
	{
		case 1:	
		{
			index = GetIndexPlayerLicense( showid, LICENSE_WATER );
		
			gmtime( License[showid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - свидетельство судоводителя: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0] ), 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( showid, LICENSE_WATER );
		
			gmtime( License[showid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - свидетельство судоводителя: "cRED"#%d изъято %02d.%02d.%d ( %s )"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[showid][index][lic_taked_by] ), 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	switch( GetStatusPlayerLicense( showid, LICENSE_GUN_1 ) )
	{
		case 1:	
		{
			index = GetIndexPlayerLicense( showid, LICENSE_GUN_1 );
		
			gmtime( License[showid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 1 уровня: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0] ), 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( showid, LICENSE_GUN_1 );
		
			gmtime( License[showid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 1 уровня: "cRED"#%d изъято %02d.%02d.%d ( %s )"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[showid][index][lic_taked_by] ), 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	switch( GetStatusPlayerLicense( showid, LICENSE_GUN_2 ) )
	{
		case 1:	
		{
			index = GetIndexPlayerLicense( showid, LICENSE_GUN_2 );
		
			gmtime( License[showid][index][lic_gave_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 2 уровня: "cBLUE"#%d от %02d.%02d.%d"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0] ), 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( showid, LICENSE_GUN_2 );
		
			gmtime( License[showid][index][lic_take_date], license_date[0],  license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 2 уровня: "cRED"#%d изъято %02d.%02d.%d ( %s )"cWHITE"\n", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[showid][index][lic_taked_by] ), 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	switch( GetStatusPlayerLicense( showid, LICENSE_GUN_3 ) )
	{
		case 1:	
		{
			index = GetIndexPlayerLicense( showid, LICENSE_GUN_3 );
		
			gmtime( License[showid][index][lic_gave_date], license_date[0], license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 3 уровня: "cBLUE"#%d от %02d.%02d.%d", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0] ), 
			strcat( g_big_string, g_small_string );
		}
		
		case 2:
		{
			index = GetIndexPlayerLicense( showid, LICENSE_GUN_3 );
		
			gmtime( License[showid][index][lic_take_date], license_date[0], license_date[1], license_date[2] );
			
			format:g_small_string(" - разрешение на ношение оружия 3 уровня: "cRED"#%d изъято от %02d.%02d.%d ( %s )", License[showid][index][lic_id], license_date[2], license_date[1], license_date[0],  License[showid][index][lic_taked_by] ), 
			strcat( g_big_string, g_small_string ); 
		}
	}
	
	strcat( g_big_string, "\n\n"cWHITE"Штрафы:" );
	status = false;
	
	for( new j; j < MAX_PENALTIES; j++ )
	{
		if( Penalty[showid][j][pen_id] )
		{
			gmtime( Penalty[showid][j][pen_date], license_date[0], license_date[1], license_date[2] );
		
			if( Penalty[showid][j][pen_type] != 2 )
			{
				format:g_small_string( "\n- %s\t%02d.%02d.%d - $%d (%s)", 
					Penalty[showid][j][pen_descript], license_date[2], license_date[1], license_date[0],
					Penalty[showid][j][pen_price], 
					!Penalty[showid][j][pen_type] ? ("не оплачен") : ("оплачен") );
			}
			else
			{
				format:g_small_string( "\n- %s\t%02d.%02d.%d - штраф-предупреждение", 
					Penalty[showid][j][pen_descript], license_date[2], license_date[1], license_date[0] );
			}
			
			strcat( g_big_string, g_small_string );
			status = true;
		}
	}
	
	if( !status ) strcat( g_big_string, "\nнет" );
	
	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );

	return 1;
}

stock ShowVehiclePInformation( playerid, vehicleid, dialogid = INVALID_PARAM )
{
	new
		bool:status = false,
		model = GetVehicleModel( vehicleid ),
		year, month, day;
		
	clean:<g_big_string>;

	format:g_small_string( ""cWHITE"Информация о транспорте гос.номер "cBLUE"%s\n\n", Vehicle[vehicleid][vehicle_number] );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( ""cWHITE"Тип: "cBLUE"%s\n", VehicleInfo[ model - 400 ][v_type] );
	strcat( g_big_string, g_small_string );
	
	format:g_small_string( ""cWHITE"Модель: "cBLUE"%s\n\n", GetVehicleModelName( model ) );
	strcat( g_big_string, g_small_string );
	
	switch( Vehicle[vehicleid][vehicle_user_id] )
	{
		case INVALID_PARAM:
		{
			if( Vehicle[vehicleid][vehicle_member] )
			{
				format:g_small_string( ""cWHITE"Владелец: "cBLUE"%s\n", Fraction[ Vehicle[vehicleid][vehicle_member] - 1 ][f_short_name] );
			}
			else
			{
				format:g_small_string( ""cWHITE"Владелец: "cBLUE"Неизвестен\n" );
			}
		}
		
		default:
		{
			foreach(new i: Player)
			{
				if( !IsLogged( i ) ) continue;
				
				if( Vehicle[vehicleid][vehicle_user_id] == Player[i][uID] )
				{
					format:g_small_string( ""cWHITE"Владелец: "cBLUE"%s\n", Player[i][uRPName] );
				
					status = true;
					break;
				}
			}
			
			if( !status ) format:g_small_string( ""cWHITE"Владелец: "cBLUE"неизвестно\n" );
		}
	}
	strcat( g_big_string, g_small_string );
	
	gmtime( Vehicle[vehicleid][vehicle_date], year, month, day );

	format:g_small_string( ""cWHITE"Дата приобретения: "cBLUE"%02d.%02d.%d", day, month, year );
	strcat( g_big_string, g_small_string );
	
	showPlayerDialog( playerid, dialogid, DIALOG_STYLE_MSGBOX, " ", g_big_string, "Назад", "" );
	
	return 1;
}

function DownloadLicense()
{
	new 
		row,
		field;
		
	cache_get_data( row, field );
	
	if( !row )
		return 1;
		
	for( new i = 0; i < row; i++ )
	{
		DLicense[l_id] = cache_get_field_content_int( i, "license_id", mysql );
		DLicense[l_type] = cache_get_field_content_int( i, "license_type", mysql );
		DLicense[l_gave_date] = cache_get_field_content_int( i, "license_gave_date", mysql );
		DLicense[l_take_date] = cache_get_field_content_int( i, "license_take_date", mysql );
			
		clean:<g_small_string>;
		cache_get_field_content( i, "license_name", g_small_string, mysql );
		strmid( DLicense[l_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
		if( DLicense[l_take_date] )
		{
			clean:<g_small_string>;
			cache_get_field_content( i, "license_taked_by", g_small_string, mysql );
			strmid( DLicense[l_taked_by], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
			
		clean:<g_small_string>;
		cache_get_field_content( i, "license_gun_name", g_small_string, mysql );
		strmid( DLicense[l_gun_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	}

	return 1;
}

function InsertSuspectPlayer( suspect )
{
	SuspectPlayer[ suspect ][s_id] = cache_insert_id();

	return 1;
}

function InsertSuspectVehicle( suspect )
{
	SuspectVehicle[ suspect ][s_id] = cache_insert_id();

	return 1;
}

stock SetPoliceCheckpoint( playerid, id )
{
	new
		Float: X, Float: Y, Float: Z;

	if( Player[id][tgpsPos][0] != 0.0 )
	{
		SetPlayerCheckpoint( playerid,  Player[id][tgpsPos][0], Player[id][tgpsPos][1], Player[id][tgpsPos][2], 3.0 );
	}
	else
	{
		GetPlayerPos( id, X, Y, Z );
		SetPlayerCheckpoint( playerid, X, Y, Z, 3.0 );
	}

	return 1;
}