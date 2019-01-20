new
	info_skin[][][] =
	{
		//Мужские
		{
			//Черные (44) + 76
			{ 	
				4, 5, 6, 7, 14, 15, 17, 19, 20, 21, 22, 24, 25, 28, 36, 66, 67, 86, 102, 103, 104, 105,
				106, 107, 134, 136, 142, 143, 144, 156, 176, 180, 182, 183, 220, 221, 222, 241, 262, 269, 270, 271,
				293, 297, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
			}, 
			//Белые (108) + 12
			{ 	
				1, 2, 3, 23, 26, 29, 30, 32, 33, 34, 35, 37, 43, 44, 46, 47, 48, 49, 
				57, 58, 59, 60, 72, 73, 78, 79, 94, 95, 98, 100, 101, 108, 109, 110, 111, 112, 113, 
				114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 135, 137, 147, 
				158, 159, 160, 161, 162, 170, 173, 174, 175, 177, 179, 181, 184, 185, 186, 187, 188, 200, 202, 
				206, 208, 210, 212, 213, 217, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 242, 247, 248, 250, 
				254, 258, 259, 261, 272, 273, 289, 290, 291, 292, 295, 299, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
			} 
		},
		//Женские
		{
			//Черные (12) + 108
			{ 
				9, 10, 13, 65, 69, 76, 148, 190, 195, 215, 218, 219, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
			},
			//Белые (43) + 77
			{ 
				12, 31, 38, 39, 40, 41, 53, 54, 55, 56, 77, 88, 89, 90, 91, 93, 129, 130, 131, 
				141, 150, 151, 157, 169, 191, 192, 193, 196, 197, 198, 199, 201, 211, 214, 216, 224, 225, 226, 
				231, 232, 233, 263, 298, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
			}
		}
	};
	
stock showChooseSkin( playerid, states )
{
	if( states )
	{
		SetPlayerVirtualWorld( playerid, playerid + 1 );
		SetPlayerCameraPos( playerid, 2315.691162, 2356.247314, 1502.251708 ); 
        SetPlayerCameraLookAt( playerid, 2320.666015, 2356.280273, 1501.752807 );
	
		for( new i; i < 4; i++ )
			TextDrawShowForPlayer( playerid, chooseSkin[i] );
			
		SelectTextDraw( playerid, 0xd3d3d3FF );
		SetPVarInt( playerid, "Skin:Show", 1 );
		
		new
			sex = Player[playerid][uSex] - 1,
			color =  Player[playerid][uColor] - 1;
		
		CreateActorSkin( playerid, info_skin[sex][color][0] );
	}
	else
	{
		for( new i; i < 4; i++ )
			TextDrawHideForPlayer( playerid, chooseSkin[i] );
		
		DeletePVar( playerid, "Skin:Show" );
		DeletePVar( playerid, "Skin:Choose" );
		DeletePVar( playerid, "Skin:Amount" );
		
		CancelSelectTextDraw( playerid );
	}

	return 1;
}

Skin_OnPlayerClickTextDraw( playerid, Text:clickedid ) 
{
	if( _:clickedid == INVALID_TEXT_DRAW  ) 
	{
		if( GetPVarInt( playerid, "Skin:Show" ) == 1 )
		{
			DeletePVar( playerid, "Skin:Show" );
			SendClient:( playerid, C_WHITE, !""gbDefault"Вы кикнуты за отказ от выбора скина." );
			gbKick( playerid );
			return 1;
		}
	}
	else if( clickedid == chooseSkin[0] ) //Back
	{
		if( !GetPVarInt( playerid, "Skin:Choose" ) )
		{
			SetPVarInt( playerid, "Skin:Choose", GetPVarInt( playerid, "Skin:Amount" ) - 1 );
			
			CreateActorSkin( playerid, info_skin[ Player[playerid][uSex] - 1 ][ Player[playerid][uColor] - 1 ][ GetPVarInt( playerid, "Skin:Choose" ) ] );
			return 1;
		}
		
		GivePVarInt( playerid, "Skin:Choose", -1 );
		
		CreateActorSkin( playerid, info_skin[ Player[playerid][uSex] - 1 ][ Player[playerid][uColor] - 1 ][ GetPVarInt( playerid, "Skin:Choose" ) ] );
		return 1;
	}
	else if( clickedid == chooseSkin[2] ) //Next
	{
		if( GetPVarInt( playerid, "Skin:Choose" ) == GetPVarInt( playerid, "Skin:Amount" ) - 1 )
		{
			SetPVarInt( playerid, "Skin:Choose", 0 );
			
			CreateActorSkin( playerid, info_skin[ Player[playerid][uSex] - 1 ][ Player[playerid][uColor] - 1 ][0] );
			return 1;
		}
		
		GivePVarInt( playerid, "Skin:Choose", 1 );
		
		CreateActorSkin( playerid, info_skin[ Player[playerid][uSex] - 1 ][ Player[playerid][uColor] - 1 ][ GetPVarInt( playerid, "Skin:Choose" ) ] );
		return 1;
	}
	else if( clickedid == chooseSkin[3] ) //Buy
	{
		GivePVarInt( playerid, "Skin:Show", 1 );
		CancelSelectTextDraw( playerid );
		
		showPlayerDialog( playerid, d_auth + 3, DIALOG_STYLE_MSGBOX, " ", "\
			"cBLUE"Регистрация: подтверждение\n\n\
			"cWHITE"Вы действительно желаете начать игру с этой одеждой?", "Да", "Нет" );
		return 1;
	}

	return 0;
}

stock CreateActorSkin( playerid, skin )
{
	if( IsValidActor( actor_skin[playerid] ) )
	{
		DestroyActor( actor_skin[playerid] );
		actor_skin[playerid] = INVALID_ACTOR_ID;
	}
		
	actor_skin[playerid] = CreateActor( skin, 2321.4104, 2356.3367, 1501.0859, 91.1256 );
	SetActorVirtualWorld( actor_skin[playerid], GetPlayerVirtualWorld( playerid ) );
}