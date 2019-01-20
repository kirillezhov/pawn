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
				""cBLUE"-"cWHITE" �������� ID-�����\n\
				"cBLUE"-"cWHITE" �������� ������\n\
				"cBLUE"-"cWHITE" �������������\n\
				"cBLUE"-"cWHITE" ��������", 
				"�������", "�������"
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
				format:g_small_string( ""gbSuccess"����� "cBLUE"%s[%d]"cWHITE" ������� ���� ID-�����.",
					GetAccountName( playerid ),
					playerid
				);
				
				SendClient:( targetid, C_WHITE, g_small_string );
					
				format:g_small_string( ""gbSuccess"�� ������� ����������� �� ������ "cBLUE"%s[%d]"cWHITE".",
					GetAccountName( targetid ),
					targetid
				);
				
				SendClient:( playerid, C_WHITE, g_small_string );
				
				showIdCard( targetid, playerid );
				
				format:g_small_string( "�������%s ID-����� %s",
					SexTextEnd( targetid ),
					GetAccountName( playerid )
				);
				
				SendRolePlayAction( targetid, g_small_string, RP_TYPE_AME );
				
				format:g_small_string( "������� ID-����� %s",
					GetAccountName( targetid )
				);
				
				SendRolePlayAction( playerid, g_small_string, RP_TYPE_AME );
			}
			else
			{
				format:g_small_string( ""gbError"����� "cBLUE"%s[%d]"cWHITE" ��������� �� ������ ����������� �� �������� ID-�����.",
					GetAccountName( playerid ),
					playerid
				);
				
				SendClient:( targetid, C_WHITE, g_small_string );
					
				format:g_small_string( ""gbError"�� ���������� �� ����������� ������ "cBLUE"%s[%d]"cWHITE".",
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