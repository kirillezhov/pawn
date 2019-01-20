
#define d_sasd_duty		3996

new sasd_skin_male[] = { 282, 283, 288, 284, 302, 310, 311 },
	sasd_skin_female[] = { 309 };
	
LspdSasd_OnGameModeInit() {
	CreateDynamicPickup( 1275, 23, 627.4626,-584.4551,1994.0859, -1 );
	CreateDynamic3DTextLabel( "[ Одежда ]\n\n"cBLUE"ALT", 0xFFFFFFFF, 627.4626,-584.4551,1994.0859, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1 );

	CreateDynamicPickup( 19132, 23, 609.1158,-559.8854,16.6512 );
	CreateDynamic3DTextLabel( ""cBLUE"ALT", 0xFFFFFFFF, 609.1158,-559.8854,16.6512, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1 );
	return true;
}

LspdSasd_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	#pragma unused oldkeys
	switch( newkeys ) {
		case KEY_WALK: {
			if( IsPlayerInRangeOfPoint( playerid, 2.5, 609.1158,-559.8854,16.6512 ) ) {
				setPlayerPos( playerid, 316.2371,-170.1205,999.5938 );
				SetPlayerVirtualWorld( playerid, 8 ), SetPlayerInterior( playerid, 6 );
			}
			else if( IsPlayerInRangeOfPoint( playerid, 2.5, 316.2371,-170.1205,999.5938 ) && GetPlayerVirtualWorld( playerid ) == 8 ) {
				setPlayerPos( playerid, 609.1158,-559.8854,16.6512 );
				SetPlayerVirtualWorld( playerid, 0 ), SetPlayerInterior( playerid, 0 );
			}
			if( IsPlayerInRangeOfPoint( playerid, 2.0, 627.4626,-584.4551,1994.0859 ) ) {
				if( Player[playerid][uMember] != 8 ) return true;
				if( Player[playerid][uIsPlayerJob][0] == 0 ) {
					showPlayerDialog( playerid, d_sasd_duty, 0, " ","{ffffff}Вы хотите заступить на дежурство ?","Да","Нет");
				}	
				else {
					showPlayerDialog( playerid, d_sasd_duty, 0, " ", "{ffffff}Вы хотите уйти с дежурства ?", "Да", "Нет" );
				}	
				return true;
			}
		}
	}
	return true;
}	

LspdSasd_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	#pragma unused inputtext
	#pragma unused listitem
	switch( dialogid ) {
		case d_sasd_duty: {
			if( !response ) return true;
			if( Player[playerid][uIsPlayerJob][0] ) {
			    SendClientMessage( playerid,C_GRAY,""gbSuccess"Вы закончили своё дежурство!");
			    SetPlayerColor( playerid, FracColor[0] );
			    RemovePlayerAttachedObject( playerid,5 );
			    RemovePlayerAttachedObject( playerid,7  );
			    RemovePlayerAttachedObject( playerid,6 );
			    Player[playerid][uIsPlayerJob][0] = 0;
				format:g_small_string(  "%s", Player[playerid][uSex] == 1 ? ("переоделся"):("переоделась") );
			    MeAction( playerid, g_small_string, 1 );
			}
			else {
				if( Player[playerid][uSex] == 1 ) 
				{
					for( new i; i < sizeof sasd_skin_male; i++ ){
						PlayerTextDrawSetPreviewModel( playerid, NewSkinSelect[i][playerid], 
							sasd_skin_male[i] );
						PlayerTextDrawShow( playerid, NewSkinSelect[i][playerid] );
					}
				}
				else {
					for( new i; i < sizeof sasd_skin_female; i++ ){
						PlayerTextDrawSetPreviewModel( playerid, NewSkinSelect[i][playerid], 
							sasd_skin_female[i] );
						PlayerTextDrawShow( playerid, NewSkinSelect[i][playerid] );
					}
				}
				PlayerTextDrawShow( playerid, NewSkinSelect[12][playerid] );
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "PlayerMenuShow", 9 );
				SetPVarInt( playerid, "GuperOnSelect", 8 );
				showPlayerDialog( playerid, 9999, 0, " ", 
					"{ffffff}Нажмите кнопку "cGREEN"ESC {ffffff}чтобы закрыть меню.","Закрыть","");
			}
		}
	}
	return true;
}

stock callSasdSkin( playerid, PlayerText:playertextid ) {
	if( Player[playerid][uSex] == 1 ) {
		for( new i; i < sizeof sasd_skin_male; i++ ) {
			if( playertextid == NewSkinSelect[i][playerid] ) {
				Player[playerid][uJobSkin] = sasd_skin_male[i];
				break;
			}
		}	
	}
	else {
		for( new i; i < sizeof sasd_skin_female; i++ ) {
			if( playertextid == NewSkinSelect[i][playerid] ) {
				Player[playerid][uJobSkin] = sasd_skin_female[i];
				break;
			}
		}	
	}
	Player[playerid][uIsPlayerJob][0] = 1;
	SetPlayerColor( playerid, FracColor[ Player[playerid][uMember] ] );
	SetPlayerSkin( playerid, Player[playerid][uJobSkin] );
	return true;
}