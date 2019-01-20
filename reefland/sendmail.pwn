function mail_for_player( playerid )
{
	format:g_small_string( "%d", Player[playerid][uConfirm] );
			
	SendMail( Player[playerid][uEmail], "noreply@reeflandrp.ru", "G-Game RolePlay", Player[playerid][uName], g_small_string );

	return 1;
}

