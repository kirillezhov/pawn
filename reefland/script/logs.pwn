/*
	1 - Перевод денег в банк
	2 - Лог покупки дома
	3 - Лог покупки дома от игрока
    4 - Лог продажи дома
	5 - Лог передачи денег игроку
	6 - Лог обмена валюты
	7 - Лог смены ника
	8 - Лог покупки премиум аккаунта
	9 - Лог покупки бизнеса
	10 - Лог покупки бизнеса от игрока
	11 - Лог аренды дома
	12 - Лог покупки транспорта
	13 - Лог обмена транспорта
	14 - Лог покупки транспорта у игрока
*/

stock log( type, text[], param, param_2 = -1, param_3 = -1, param_4 = -1, param_5 = -1 ) 
{
	clean:<g_big_string>;
	mysql_format( mysql, g_big_string, sizeof g_big_string, 
		"INSERT INTO `"DB_LOGS"` \
			( `lg_type`, `lg_text`, `lg_param_1`, `lg_param_2`, `lg_param_3`, `lg_param_4`, `lg_param_5`, `lg_date` ) \
		 VALUES \
			( %d, '%s', %d, %d, %d, %d, %d, %d ) \
		", 
		type, 
		text, 
		param,
		param_2, 
		param_3, 
		param_4, 
		param_5, 
		gettime() 
	);
	
	return mysql_tquery( mysql, g_big_string, "", "" );	
} 


stock admlog( adminid, text[], param_1, param_2 = -1, param_3 = -1, param_4 = -1 ) 
{
	clean:<g_big_string>;
	mysql_format( mysql, g_big_string, sizeof g_big_string, "\
		INSERT INTO `"DB_ADMIN_LOGS"` \
			( `lg_adminid`, `lg_admin_name`, `lg_text`, `lg_param_1`, `lg_param_2`, `lg_param_3`, `lg_param_4`, `lg_admin_ip`, `lg_date` ) \
		VALUES \
		    ( %d, '%s', '%s', %d, %d, %d, %d, '%s', %d ) \
		",
		Player[adminid][uID],
		Player[adminid][uName],
		text,
		param_1,
		param_2,
		param_3,
		param_4,
		Player[adminid][tIP],
		gettime()
	);
	
	return mysql_tquery( mysql, g_big_string );
}

stock aclog( type = 1, playerid, code, reason[] )
{
	mysql_format:g_big_string( "\
		INSERT INTO `"DB_ANTICHEAT_LOGS"` \
			( `ac_type`, `ac_user_id`, `ac_name`, `ac_reason`, `ac_code`, `ac_user_ip`, `ac_date` ) \
		VALUES \
			( %d, %d, '%s', '%s', %d, '%s', %d ) \
		",
		type,
		Player[playerid][uID],
		Player[playerid][uName],
		reason,
		code,
		Player[playerid][tIP],
		gettime()
	);
	
	return mysql_tquery( mysql, g_big_string );
}