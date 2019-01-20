function Target_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{	
	/*if( HOLDING( KEY_CTRL_BACK | KEY_HANDBRAKE ) ) 
	{
        new 
			target = GetPlayerTargetPlayer( playerid );
			
        if( target != INVALID_PLAYER_ID ) 
		{
			if( GetDistanceBetweenPlayers( playerid, target ) > 3.0 )
				return 1;
			
			showPlayerDialog( playerid, d_target + 1, DIALOG_STYLE_LIST, Player[target][uName], 
				""cBLUE"-"cWHITE" Показать ID-карту\n\
				"cBLUE"-"cWHITE" Передать деньги\n\
				"cBLUE"-"cWHITE" Поздороваться\n\
				"cBLUE"-"cWHITE" Обыскать", 
				"Выбрать", "Закрыть"
			);
			
			SetPVarInt( playerid, "Target:PlayerId", target );
        }
    }*/
	
	return 1;
}

Target_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	#pragma unused inputtext
	#pragma unused listitem
	
	switch( dialogid )
	{
		case d_target :
		{
			new
				targetid = GetPVarInt( playerid, "Target:PlayerId" );
				
			if( response )
			{
				format:g_small_string( ""gbSuccess"Игрок "cBLUE"%s[%d]"cWHITE" смотрит Вашу ID-карту.",
					GetAccountName( playerid ),
					playerid
				);
				
				SendClient:( targetid, C_WHITE, g_small_string );
					
				format:g_small_string( ""gbSuccess"Вы приняли предложение от игрока "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( targetid ),
					targetid
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
				
				showIdCard( targetid, playerid );
				
				format:g_small_string( "показал%s ID-карту %s",
					SexTextEnd( targetid ),
					GetAccountName( playerid )
				);
				
				SendRolePlayAction( targetid, g_small_string, RP_TYPE_AME );
				
				format:g_small_string( "смотрит ID-карту %s",
					GetAccountName( targetid )
				);
				
				SendRolePlayAction( playerid, g_small_string, RP_TYPE_AME );
			}
			else
			{
				format:g_small_string( ""gbError"Игрок "cBLUE"%s[%d]"cWHITE" отказался от Вашего предложения на просмотр ID-карты.",
					GetAccountName( playerid ),
					playerid
				);
				
				SendClient:( targetid, C_WHITE, g_small_string );
					
				format:g_small_string( ""gbError"Вы отказались от предложения игрока "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( targetid ),
					targetid
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
			}
			
			DeletePVar( playerid, "Target:PlayerId" );
		}
	}
	
	return 1;
}