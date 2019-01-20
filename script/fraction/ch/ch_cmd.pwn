CMD:recept( playerid )
{
	if( Player[playerid][uMember] != FRACTION_CITYHALL || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid ),
		count,
		year, month, day;
		
	if( !FRank[fid][rank][r_add][0] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	clean:<g_big_string>;
	
	strcat( g_big_string, "Кому\tОт кого\tДата" );
		
	for( new i; i < MAX_RECOURSE; i++ )
	{
		if( Recourse[i][r_id] )
		{
			gmtime( Recourse[i][r_date], year, month, day );
			
			format:g_small_string( "\n"cBLUE"%s\t%s\t"cWHITE"%02d.%02d.%d", 
				Recourse[i][r_nameto], Recourse[i][r_namefrom], day, month, year );
			strcat( g_big_string, g_small_string );	
			
			g_dialog_select[playerid][count] = i;
			count++;
		}
	}
	
	if( !count ) return SendClient:( playerid, C_WHITE, !""gbDefault"Обращения не зарегистрированы." );
	
	showPlayerDialog( playerid, d_meria + 5, DIALOG_STYLE_TABLIST_HEADERS, "Приемная", g_big_string, "Выбрать", "Закрыть" );
	
	return 1;
}

CMD:createdoc( playerid, params[] )
{
	if( Player[playerid][uMember] != FRACTION_CITYHALL || !Player[playerid][uRank] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		fid = Player[playerid][uMember] - 1,
		rank = getRankId( playerid, fid ),
		index = INVALID_PARAM;
		
	if( !FRank[fid][rank][r_add][1] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	if( sscanf( params, "d", params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbDefault"Введите: /createdoc [ id игрока ]" );

	if( !IsLogged( params[0] ) || params[0] == playerid )
		return SendClient:( playerid, C_WHITE, !INCORRECT_PLAYERID );
		
	if( GetDistanceBetweenPlayers( playerid, params[0] ) > 3.0 || GetPlayerVirtualWorld( playerid ) != GetPlayerVirtualWorld( params[0] ) ) 
		return SendClient:( playerid, C_WHITE, !""gbError"Данного игрока нет рядом с Вами." );	
	
	for( new i; i < MAX_DOCUMENT; i++ )
	{
		if( !Document[ params[0] ][i][d_id] && Document[ params[0] ][i][d_name][0] == EOS )
		{
			index = i;
			break;
		}
	}
	
	if( index == INVALID_PARAM )
		return SendClient:( playerid, C_WHITE, !""gbError"У игрока слишком много документов." );
		
	SetPVarInt( playerid, "Document:Player", params[0] );
	SetPVarInt( playerid, "Document:Index", index );
	
	clean:<Document[ params[0] ][index][d_name]>;
	strcat( Document[ params[0] ][index][d_name], Player[playerid][uRPName], MAX_PLAYER_NAME );
	
	clean:<g_string>;
	strcat( g_string, ""gbDialog"Выберите тип документа"cWHITE"" );
	
	for( new i; i < sizeof document_type; i++ )
	{
		format:g_small_string( "\n%s", document_type[i] );
		strcat( g_string, g_small_string );
	}
	
	showPlayerDialog( playerid, d_meria + 10, DIALOG_STYLE_LIST, "Создать документ", g_string, "Выбрать", "Закрыть" );
		
	return 1;
}