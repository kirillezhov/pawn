function City_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( PRESSED(KEY_WALK) && IsPlayerInRangeOfPoint( playerid, 1.5, PICKUP_RECEPTION ) )
	{
		showPlayerDialog( playerid, d_meria, DIALOG_STYLE_MSGBOX, " ", reception_info, "Далее", "Закрыть" );
	}
	
	return 1;
}

function InsertRecourse( index )
{
	Recourse[index][r_id] = cache_insert_id();
	return 1;
}

function InsertDocument( playerid, index )
{
	Document[playerid][index][d_id] = cache_insert_id();
	return 1;
}

function LoadRecourse()
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		if( !Recourse[i][r_id] )
		{
			Recourse[i][r_id] = cache_get_field_content_int( i, "r_id", mysql );
			Recourse[i][r_date] = cache_get_field_content_int( i, "r_date", mysql );
			Recourse[i][r_status] = cache_get_field_content_int( i, "r_status", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_nameto", g_small_string, mysql );
			strmid( Recourse[i][r_nameto], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_namefrom", g_small_string, mysql );
			strmid( Recourse[i][r_namefrom], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "r_nameans", g_small_string, mysql );
			strmid( Recourse[i][r_nameans], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_string>;
			cache_get_field_content( i, "r_text", g_string, mysql );
			strmid( Recourse[i][r_text], g_string, 0, strlen( g_string ), sizeof g_string );
			
			clean:<g_string>;
			cache_get_field_content( i, "r_answer", g_string, mysql );
			strmid( Recourse[i][r_answer], g_string, 0, strlen( g_string ), sizeof g_string );
		}
	}

	return 1;
}

function LoadDocument( playerid )
{
	new 
		rows,
		fields;
		
	cache_get_data( rows, fields );
	
	if( !rows )
		return 1;
		
	for( new i; i < rows; i++ )
	{
		if( !Document[playerid][i][d_id] )
		{
			Document[playerid][i][d_id] = cache_get_field_content_int( i, "d_id", mysql );
			Document[playerid][i][d_type] = cache_get_field_content_int( i, "d_type", mysql );
			Document[playerid][i][d_date] = cache_get_field_content_int( i, "d_date", mysql );
			
			clean:<g_small_string>;
			cache_get_field_content( i, "d_name", g_small_string, mysql );
			strmid( Document[playerid][i][d_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
			
			clean:<g_string>;
			cache_get_field_content( i, "d_text", g_string, mysql );
			strmid( Document[playerid][i][d_text], g_string, 0, strlen( g_string ), sizeof g_string );
		}
	}
	
	return 1;
}

stock ShowDocument( showid, playerid, document, dialogid, btn[], btn2[] = "" )
{
	new
		year, month, day;

	gmtime( Document[playerid][document][d_date], year, month, day );
			
	format:g_big_string( "\
		"cWHITE"Документ "cBLUE"%s\n\n\
		"cWHITE"Тип: "cBLUE"%s\n\n\
		"cWHITE"Текст:\n"cGRAY"%s\n\n\
		"cWHITE"Подпись: "cBLUE"%s\t"cWHITE"Дата: "cBLUE"%02d.%02d.%d",
		Player[playerid][uRPName],
		document_type[ Document[playerid][document][d_type] ],
		Document[playerid][document][d_text],
		Document[playerid][document][d_name],
		day, month, year );
			
	return showPlayerDialog( showid, dialogid, DIALOG_STYLE_MSGBOX, " ", g_big_string, btn, btn2 );
}