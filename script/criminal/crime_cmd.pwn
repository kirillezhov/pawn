CMD:mpanel( playerid )
{
	if( !Player[playerid][uCrimeM] )
		return SendClient:( playerid, C_WHITE, !NO_ACCESS_CMD );
		
	new
		crime = getIndexCrimeFraction( Player[playerid][uCrimeM] );
		
	format:g_small_string( ""cBLUE"%s", CrimeFraction[ crime ][c_name] );
	showPlayerDialog( playerid, d_crime, DIALOG_STYLE_LIST, g_small_string, mpanel_dialog, "Выбрать", "Закрыть" );

	return 1;
}