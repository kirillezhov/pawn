enum pa_attach_info 
{
	pa_name[64],
	pa_object,
	pa_bone,
	
}

new const
	pa_attach[][pa_attach_info] = {
	{ "���������� ������� �������", 19112, 2 },
	{ "���������� ������� ������", 19115, 2 },
	{ "�������� ����-�����", 18976, 2 },
	{ "�������� �������", 18977, 2 },
	{ "����� ������", 19528, 2},
	{ "������������� [�����]", 19319, 1},
	{ "������������� [������ ����]", 19319, 6 },
	{ "������������� [����� ����]", 19319, 5 },
	{ "��� [������ ����]", 18634, 6 },
	{ "��� [����� ����]", 18634, 5 },
	{ "��� [����]", 18634, 7 },
	{ "������� [������ ����]", 18635, 6 },
	{ "������� [����� ����]", 18635, 5 },
	{ "������� [����]", 18635, 7 },
	{ "������ [������ ����]", 18890, 6 },
	{ "������ [����� ����]", 18890, 5 },
	{ "������������ [������ ����]", 18642, 6 },
	{ "������������ [����� ����]", 18642, 5 },
	{ "������������ [����]", 18642, 7 },
	{ "������� [������ ����]", 18644, 6 },
	{ "������� [����� ����]", 18644, 5 },
	{ "������� [����]", 18644, 7 },
	{ "����� �����", 19136, 2 },
	{ "������ [������ ����]", 19348, 6 },
	{ "������ [����� ����]", 19348, 5},
	{ "����������", 19472, 2},
	{ "��� 1", 19350, 2 },
	{ "��� 2", 19351, 2 },
	{ "���������� �����", 19553, 2 },
	{ "�������� ������", 19559, 1 },
	{ "������� �� ������������ [������ ����]", 19592, 6 },
	{ "������� �� ������������ [����� ����]", 19592, 5 },
	{ "�������� [������ ����]", 19610, 6 },
	{ "�������� [����� ����]", 19610, 5 },
	{ "������� [������ ����]", 19621, 6 },
	{ "������� [����� ����]", 19621, 5 },
	{ "������� ���� [������ ����]", 19627, 6 },
	{ "������� ���� [����� ����]", 19627, 5 },
	{ "������� ���� [����]", 19627, 7 },
	{ "������� [������ ����]", 19624, 6 },
	{ "������� [����� ����]", 19624, 5 },
	{ "���������", 19801, 2 },
	{ "������� �� ���� ����", 19085, 2 }
};


/*CMD:pattach( playerid, params[] ) 
{
	if( Player[playerid][uPremium] ) 
	{
		new slot;
		for( new i; i < sizeof pa_attach; i++ ) 
		{
			format:g_big_string( "%s%d. %s\n", g_big_string, slot + 1, pa_attach[i][pa_name] );
			slot++;
		}
		format:g_small_string(  "%d. �������� �������", slot + 1 ), strcat( g_big_string, g_small_string );
		showPlayerDialog( playerid, 3001, DIALOG_STYLE_LIST, "������ ��������", g_big_string, "�������", "������");
	}
	return 1;
}*/

Pattach_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	#pragma unused inputtext
	
	switch( dialogid ) {
		case 3001: {
			if(!response) return 1;
			if( listitem == sizeof( pa_attach ) ) {
				RemovePlayerAttachedObject( playerid, 5 ), RemovePlayerAttachedObject( playerid, 6 );
	            return SendClient:( playerid, -1, ""gbDefault"�� �������� ������ ��������!" );
			}
			if( IsPlayerAttachedObjectSlotUsed( playerid, 5 ) 
				&& IsPlayerAttachedObjectSlotUsed( playerid, 6 ) ) return SendClient:(playerid, -1, ""gbError"��� ����� ������, �������� �� � ����!");
	        if( !IsPlayerAttachedObjectSlotUsed( playerid, 5 )) {
	            SetPlayerAttachedObject( playerid, 5, pa_attach[listitem][pa_object], pa_attach[listitem][pa_bone] );
    			return EditAttachedObject( playerid, 5 );
	        }
	        else if( IsPlayerAttachedObjectSlotUsed( playerid, 5 )) {
	            SetPlayerAttachedObject( playerid, 6, pa_attach[listitem][pa_object], pa_attach[listitem][pa_bone] );
    			return EditAttachedObject( playerid, 6 );
	        }
	    }
	}
	return 1;
}