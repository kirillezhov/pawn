
function Att_OnPlayerConnect( playerid )
{
	SetPVarInt( playerid, "FAttach:Id", -1 );
	SetPVarInt( playerid, "FAttach:Mode", 0 );
	return 1;
}
	
function Att_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	switch( dialogid )
	{
		case d_attach :
		{
			if( !response )
			{
				DeletePVar( playerid, "FAttach:Delete" );
				return 1;
			}
				
			if( GetPVarInt( playerid, "FAttach:Delete" ) == listitem )
			{		
				RemovePlayerAttachedObject( playerid, 7 ); 
				RemovePlayerAttachedObject( playerid, 8 ); 
				RemovePlayerAttachedObject( playerid, 9 );
				
				DeletePVar( playerid, "FAttach:Delete" );
				
				if( GetPVarInt( playerid, "Fire:Attach" ) ) //Если использовал кислородный баллон
					DeletePVar( playerid, "Fire:Attach" );
				
				return SendClient:( playerid, C_WHITE, !""gbSuccess"Вы успешно очистили список прикреплённых объектов." );
			}
			
			SetPVarInt( playerid, "FAttach:Id", listitem );
			SetPVarInt( playerid, "FAttach:Mode", 1 );
			
			if( Player[playerid][uMember] ) 
				showPlayerDialog( playerid, d_attach + 1, DIALOG_STYLE_LIST, " ", attach_bone, "Выбрать", "Назад" );
			else if( Player[playerid][uCrimeM] )
				showPlayerDialog( playerid, d_attach + 2, DIALOG_STYLE_LIST, " ", attach_bone, "Выбрать", "Назад" );
		}
		
		case d_attach + 1 :
		{
			if( !response )
			{
				DeletePVar( playerid, "FAttach:Delete" );
				SetPVarInt( playerid, "FAttach:Id", -1 );
				return cmd_attach( playerid );
			}
			
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_attach + 1, DIALOG_STYLE_LIST, " ", attach_bone, "Выбрать", "Назад" );
			}
			
			new 
				id = GetPVarInt( playerid, "FAttach:Id" ),
				fid = Player[playerid][uMember] - 1;
				
			if( !IsPlayerAttachedObjectSlotUsed( playerid, 7 ) ) 
			{
				SetPlayerAttachedObject( playerid, 7, f_attach[ fid ][id][f_a_object], listitem );
				return EditAttachedObject( playerid, 7 );
			}
    		else if( !IsPlayerAttachedObjectSlotUsed( playerid, 8 ) ) 
			{
				SetPlayerAttachedObject( playerid, 8, f_attach[ fid ][id][f_a_object], listitem );
				return EditAttachedObject( playerid, 8 );
			}
			else if( !IsPlayerAttachedObjectSlotUsed( playerid, 9 ) )
			{
				SetPlayerAttachedObject( playerid, 9, f_attach[ fid ][id][f_a_object], listitem );
				return EditAttachedObject( playerid, 9 );
			}
			else if( IsPlayerAttachedObjectSlotUsed( playerid, 7 ) &&
					 IsPlayerAttachedObjectSlotUsed( playerid, 8 ) &&
					 IsPlayerAttachedObjectSlotUsed( playerid, 9 )
				   )
			{
				DeletePVar( playerid, "FAttach:Delete" );
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете прикрепить предмет, так как слоты заняты." );
			}
		}
		//Аттачи для криминала
		case d_attach + 2 :
		{
			if( !response )
			{
				DeletePVar( playerid, "FAttach:Delete" );
				SetPVarInt( playerid, "FAttach:Id", -1 );
				return cmd_attach( playerid );
			}
			
			if( listitem == 0 )
			{
				return showPlayerDialog( playerid, d_attach + 2, DIALOG_STYLE_LIST, " ", attach_bone, "Выбрать", "Назад" );
			}
			
			new 
				id = GetPVarInt( playerid, "FAttach:Id" );
				
			if( !IsPlayerAttachedObjectSlotUsed( playerid, 7 ) ) 
			{
				SetPlayerAttachedObject( playerid, 7, crime_attach[id][c_a_object], listitem );
				return EditAttachedObject( playerid, 7 );
			}
    		else if( !IsPlayerAttachedObjectSlotUsed( playerid, 8 ) ) 
			{
				SetPlayerAttachedObject( playerid, 8, crime_attach[id][c_a_object], listitem );
				return EditAttachedObject( playerid, 8 );
			}
			else if( !IsPlayerAttachedObjectSlotUsed( playerid, 9 ) )
			{
				SetPlayerAttachedObject( playerid, 9, crime_attach[id][c_a_object], listitem );
				return EditAttachedObject( playerid, 9 );
			}
			else if( IsPlayerAttachedObjectSlotUsed( playerid, 7 ) &&
					 IsPlayerAttachedObjectSlotUsed( playerid, 8 ) &&
					 IsPlayerAttachedObjectSlotUsed( playerid, 9 )
				   )
			{
				DeletePVar( playerid, "FAttach:Delete" );
				return SendClient:( playerid, C_WHITE, !""gbError"Вы не можете прикрепить предмет, так как слоты заняты." );
			}
		}
	}
	
	return 1;
}

function Att_OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	if( GetPVarInt( playerid, "FAttach:Mode" ) )
	{
		if( response )
		{
			SetPlayerAttachedObject(playerid, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
			SendClient:( playerid, C_WHITE, !""gbSuccess"Вы успешно прикрепили объект к персонажу." );
			
			if( modelid == 1008 || modelid == 1009 || modelid == 1010 ) //Кислородные балоны
				SetPVarInt( playerid, "Fire:Attach", 1 );
		}
		else 
		{
			RemovePlayerAttachedObject( playerid, index );
			SendClient:( playerid, C_WHITE, !""gbSuccess"Вы отменили прикрепление объекта к персонажу." );
		}
	
		SetPVarInt( playerid, "FAttach:Mode", 0 );
		SetPVarInt( playerid, "FAttach:Id", 0 );
	}

	return 1;
}
