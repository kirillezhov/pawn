#define LICENSE_DRIVE 			( 1 )
#define LICENSE_AIR 			( 2 )
#define LICENSE_WATER 			( 3 )
#define LICENSE_GUN_1 			( 4 )
#define LICENSE_GUN_2 			( 5 )
#define LICENSE_GUN_3 			( 6 )

#define LIC_INSERT	 			( 0 )
#define LIC_UPDATE	 			( 1 )

const
	MAX_LICENSES = 6,
	
	// Цены на лицензии
	PRICE_LIC_CARD = 100,
	PRICE_LIC_DRIVE = 450,
	PRICE_LIC_AIR = 7000,
	PRICE_LIC_WATER = 2400,
	PRICE_LIC_GUN_1 = 10000,
	PRICE_LIC_GUN_2 = 15000,
	PRICE_LIC_GUN_3 = 25000;

enum e_LICENSE
{
	lic_id,
	lic_type,			// 1 - наземный, 2 - воздушный, 3 - водный, 4-6 оружие
	lic_name			[ MAX_PLAYER_NAME ],
	lic_gave_date,
	lic_take_date,
	lic_taked_by		[ MAX_PLAYER_NAME ],
	lic_gun_name		[ 32 ],
}

new
	License		[ MAX_PLAYERS ] [ MAX_LICENSES ] [ e_LICENSE ];
	
new const
	getLicenseName[][] = 
	{
		{ "Водительское удостоверение" },
		{ "Лицензия пилота" },
		{ "Свидетельство судоводителя" },
		{ "Разрешение на ношение оружия 1 уровня" },
		{ "Разрешение на ношение оружия 2 уровня" },
		{ "Разрешение на ношение оружия 3 уровня" }
	};
	
	
#define dialog_licenses		"\
								"cWHITE"Наименование\t"cWHITE"Стоимость\n\
								"cWHITE"ID-карта\t"cBLUE"$%d\n\
								"cWHITE"Водительское удостоверение\t"cBLUE"$%d\n\
								"cWHITE"Лицензия пилота\t"cBLUE"$%d\n\
								"cWHITE"Свидетельство судоводителя\t"cBLUE"$%d\
							"			

GetStatusPlayerLicense( playerid, type )
{
	for( new i; i < MAX_LICENSES; i++ )
	{
		if( License[playerid][i][lic_type] == type )
		{
			if( License[playerid][i][lic_take_date] )
				return 2;
			else
				return 1;
		}
	}

	return STATUS_ERROR;
}

GetIndexPlayerLicense( playerid, type )
{
	for( new i; i < MAX_LICENSES; i++ )
	{
		if( License[playerid][i][lic_type] == type )
			return i;
	}

	return STATUS_ERROR;
}

GivePlayerLicense( playerid, type, index )
{
	switch( type )
	{
		case LIC_INSERT :
		{
			clean:<License[playerid][index][lic_name]>;
			strcat( License[playerid][index][lic_name], Player[playerid][uName], MAX_PLAYER_NAME );
		
			mysql_format:g_string( "\
				INSERT INTO `"DB_LICENSES"`\
					( `license_user_id`, `license_name`, `license_type`, `license_gave_date` ) \
				VALUES \
					( '%d', '%s', '%d', '%d' )",
				Player[playerid][uID],
				License[playerid][index][lic_name],
				License[playerid][index][lic_type],
				License[playerid][index][lic_gave_date]
			);
			
			mysql_tquery( mysql, g_string, "AddLicense", "dd", playerid, index );
		}
		
		case LIC_UPDATE :
		{
			
			mysql_format:g_small_string( 
			"\
				UPDATE `"DB_LICENSES"` \
				SET \
					`license_take_date` = %d, \
					`license_taked_by` = '%s',\
					`license_gun_name` = '%s' \
				WHERE \
					`license_id` = '%d'\
			",
				License[playerid][index][lic_take_date],
				License[playerid][index][lic_taked_by],
				License[playerid][index][lic_gun_name],
				License[playerid][index][lic_id]
			);
					
			mysql_tquery( mysql, g_small_string );
		}
	
	}

	return STATUS_OK;
}							