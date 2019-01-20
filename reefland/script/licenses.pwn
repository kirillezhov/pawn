function Lic_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED( KEY_WALK ) )
	{
		if( IsPlayerInRangeOfPoint( playerid, 1.5, PICKUP_LICENSES ) )
		{
			format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
			showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" ); 
		}
	}
	
	return 1;
}

function Lic_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid ) 
	{
		case d_licenses :
		{
			if( !response ) return 1;
			
			switch( listitem )
			{
				case 0:
				{
					if( getItem( playerid, INV_SPECIAL, PARAM_CARD ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Вы уже имеете при себе ID-карту." );
					
						format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
						return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
					}
					
					format:g_string( "\
						"cBLUE"ID-карта\n\n\
						"cWHITE"Официальный документ в формате пластиковой карты, удостоверяющий личность.\n\
						Содержит информацию о держателе карты: имя, фамилию, пол, национальность, возраст, лицензии.\n\n\
						"gbDefault"Стоимость приобретения "cBLUE"$%d"cWHITE".", PRICE_LIC_CARD );
						
					showPlayerDialog( playerid, d_licenses + 1, DIALOG_STYLE_MSGBOX, " ", g_string, "Купить", "Назад" );
				}
				
				case 1:
				{
					if( GetStatusPlayerLicense( playerid, LICENSE_DRIVE ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Вы получали водительское удостоверение ранее." );
					
						format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
						return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
					}
				
					format:g_small_string( "\
						"cBLUE"Водительское удостоверение\n\n\
						"cWHITE"Официальный документ, подтверждающий право на управление наземными транспортными средствами.\n\n\
						"gbDefault"Стоимость приобретения "cBLUE"$%d"cWHITE".", PRICE_LIC_DRIVE );
						
					showPlayerDialog( playerid, d_licenses + 2, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Купить", "Назад" );
				}
				
				case 2:
				{
					if( GetStatusPlayerLicense( playerid, LICENSE_AIR ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Вы получали лицензию пилота ранее." );
					
						format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
						return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
					}
					
					format:g_small_string( "\
						"cBLUE"Лицензия пилота\n\n\
						"cWHITE"Официальный документ, удостоверяющий право лица на пилотирование летательного аппарата.\n\n\
						"gbDefault"Стоимость приобретения "cBLUE"$%d"cWHITE".", PRICE_LIC_AIR );
						
					showPlayerDialog( playerid, d_licenses + 3, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Купить", "Назад" );
				}
				
				case 3:
				{
					if( GetStatusPlayerLicense( playerid, LICENSE_WATER ) )
					{
						SendClient:( playerid, C_WHITE, ""gbError"Вы получали свидетельство судоводителя ранее." );
					
						format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
						return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
					}
					
					format:g_small_string( "\
						"cBLUE"Свидетельство судоводителя\n\n\
						"cWHITE"Официальный документ, удостоверящий право лица на управление судном.\n\n\
						"gbDefault"Стоимость приобретения "cBLUE"$%d"cWHITE".", PRICE_LIC_WATER );
						
					showPlayerDialog( playerid, d_licenses + 4, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Купить", "Назад" );
				}
			}
		}
		
		// ID карта
		case d_licenses + 1 :
		{
			if( !response )
			{
				format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
				return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
			}
			
			if( Player[playerid][uMoney] < PRICE_LIC_CARD )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				
				format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
				return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
			}
			
			if( !giveItem( playerid, 33 ) )
				return SendClient:( playerid, C_WHITE, ""gbError"У Вас нет свободного места в инвентаре." );
			
			SetPlayerCash( playerid, "-", PRICE_LIC_CARD );
			
			pformat:( ""gbSuccess"Вы приобрели ID-карту, заплатив "cBLUE"$%d"cWHITE".", PRICE_LIC_CARD );
			psend:( playerid, C_WHITE );
		}
		
		case d_licenses + 2 :
		{
			if( !response )
			{
				format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
				return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
			}
			
			if( Player[playerid][uMoney] < PRICE_LIC_DRIVE )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				
				format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
				return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
			}
			
			for( new i; i < MAX_LICENSES; i++ )
			{
				if( !License[playerid][i][lic_id] )
				{
					License[playerid][i][lic_type] = LICENSE_DRIVE;
					License[playerid][i][lic_gave_date] = gettime();
					
					GivePlayerLicense( playerid, LIC_INSERT, i );
					
					break;
				}
				
			}
			
			SetPlayerCash( playerid, "-", PRICE_LIC_DRIVE );
			
			pformat:( ""gbSuccess"Вы приобрели водительское удостоверение, заплатив "cBLUE"$%d"cWHITE".", PRICE_LIC_DRIVE );
			psend:( playerid, C_WHITE );
		}
		
		case d_licenses + 3 :
		{
			if( !response )
			{
				format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
				return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
			}
			
			if( Player[playerid][uMoney] < PRICE_LIC_AIR )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				
				format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
				return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
			}
			
			for( new i; i < MAX_LICENSES; i++ )
			{
				if( !License[playerid][i][lic_id] )
				{
					License[playerid][i][lic_type] = LICENSE_AIR;
					License[playerid][i][lic_gave_date] = gettime();
					
					GivePlayerLicense( playerid, LIC_INSERT, i );
					
					break;
				}
				
			}
			
			SetPlayerCash( playerid, "-", PRICE_LIC_AIR );
			
			pformat:( ""gbSuccess"Вы приобрели лицензию пилота, заплатив "cBLUE"$%d"cWHITE".", PRICE_LIC_AIR );
			psend:( playerid, C_WHITE );
		}
		
		case d_licenses + 4 :
		{
			if( !response )
			{
				format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
				return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
			}
			
			if( Player[playerid][uMoney] < PRICE_LIC_WATER )
			{
				SendClient:( playerid, C_WHITE, !NO_MONEY );
				
				format:g_string( dialog_licenses, PRICE_LIC_CARD, PRICE_LIC_DRIVE, PRICE_LIC_AIR, PRICE_LIC_WATER ); 
				return showPlayerDialog( playerid, d_licenses, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Далее", "Закрыть" );
			}
			
			for( new i; i < MAX_LICENSES; i++ )
			{
				if( !License[playerid][i][lic_id] )
				{
					License[playerid][i][lic_type] = LICENSE_WATER;
					License[playerid][i][lic_gave_date] = gettime();
					
					GivePlayerLicense( playerid, LIC_INSERT, i );
					
					break;
				}
				
			}
			
			SetPlayerCash( playerid, "-", PRICE_LIC_WATER );
			
			pformat:( ""gbSuccess"Вы приобрели свидетельство судоводителя, заплатив "cBLUE"$%d"cWHITE".", PRICE_LIC_WATER );
			psend:( playerid, C_WHITE );
		}
	}
	
	return 1;
}

function LoadLicenses( playerid )
{
	new
		rows = cache_get_row_count();

	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		License[playerid][i][lic_id] = cache_get_field_content_int( i, "license_id", mysql );
		License[playerid][i][lic_type] = cache_get_field_content_int( i, "license_type", mysql );
		License[playerid][i][lic_gave_date] = cache_get_field_content_int( i, "license_gave_date", mysql );
		License[playerid][i][lic_take_date] = cache_get_field_content_int( i, "license_take_date", mysql );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "license_name", g_small_string, mysql );
		strmid( License[playerid][i][lic_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		
		if( License[playerid][i][lic_take_date] )
		{
			clean:<g_small_string>;
			cache_get_field_content( i, "license_taked_by", g_small_string, mysql );
			strmid( License[playerid][i][lic_taked_by], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
		}
		
		clean:<g_small_string>;
		cache_get_field_content( i, "license_gun_name", g_small_string, mysql );
		strmid( License[playerid][i][lic_gun_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	}

	return 1;
}

function LoadApplycation()
{
	new
		rows = cache_get_row_count();

	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		PApply[i][a_id] = cache_get_field_content_int( i, "a_id", mysql );
		PApply[i][a_level] = cache_get_field_content_int( i, "a_level", mysql );
		PApply[i][a_user_id] = cache_get_field_content_int( i, "a_user_id", mysql );
		PApply[i][a_date] = cache_get_field_content_int( i, "a_date", mysql );
		
		clean:<g_small_string>;
		cache_get_field_content( i, "a_name", g_small_string, mysql );
		strmid( PApply[i][a_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
	}

	return 1;
}

function AddApplycation( index )
{
	PApply[index][a_id] = cache_insert_id();
	
	return STATUS_OK;
}

function AddLicense( playerid, index )
{
	License[playerid][index][lic_id] = cache_insert_id();
	return STATUS_OK;
}