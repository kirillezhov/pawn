function Texture_OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if( SelectedMenu[playerid] != INVALID_PARAM )
	{
		new 
			MenuID = SelectedMenu[playerid];

	    if( PRESSED(KEY_CTRL_BACK) )
	    {
			new 
				model,
				txd[32],
				texture[32], 
				color;
				
			GetDynamicObjectMaterial( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ], 0, model, txd, texture, color);
		 	SetDynamicObjectMaterial( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ], 0, model, txd, texture, MenuInfo[MenuID][ UnselectColor ][ SelectedBox[playerid] ] );

			MoveDynamicObject( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ],
				MenuInfo[MenuID][OrigPosX][ SelectedBox[playerid] ],
				MenuInfo[MenuID][OrigPosY][ SelectedBox[playerid] ],
				MenuInfo[MenuID][OrigPosZ][ SelectedBox[playerid] ], 1.0 );
				
			SelectedBox[ playerid ]++;

			if( SelectedBox[playerid] == MenuInfo[MenuID][Boxes] ) // Если последняя ячейка на странице
			{
				SetPageTexViewer( playerid, "+", Menu3DData[playerid][CurrTextureType] );
				
				SelectedBox[playerid] = 0;
			}

			GetDynamicObjectMaterial( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ],0,model, txd, texture, color);
		 	SetDynamicObjectMaterial( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ], 0, model, txd, texture, MenuInfo[MenuID][SelectColor][ SelectedBox[playerid] ] );

			MoveDynamicObject( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ], 
				MenuInfo[MenuID][OrigPosX][ SelectedBox[playerid] ] + MenuInfo[MenuID][AddingX],
				MenuInfo[MenuID][OrigPosY][ SelectedBox[playerid] ] + MenuInfo[MenuID][AddingY],
				MenuInfo[MenuID][OrigPosZ][ SelectedBox[playerid] ], 1.0 );
			
			if( !SelectedType{playerid} )
			{
				SetHouseTexture( GetPVarInt( playerid, "Hpanel:HId" ), SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex], Menu3DData[playerid][CurrTextureType], Menu3DData[playerid][CurrPartNumber] );
			}
			else
			{
				SetBusinessTexture( GetPVarInt( playerid, "Bpanel:BId" ), SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex], Menu3DData[playerid][CurrTextureType], Menu3DData[playerid][CurrPartNumber] );
			}
			
			return 1;
		}
		
		if( PRESSED(KEY_F) )
	    {
			new 
				model,
				txd[32],
				texture[32], 
				color;
				
			GetDynamicObjectMaterial( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ] ,0,model, txd, texture, color);
		 	SetDynamicObjectMaterial( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ] ,0, model, txd, texture, MenuInfo[MenuID][UnselectColor][ SelectedBox[playerid] ] );

	        MoveDynamicObject( MenuInfo[MenuID][Objects][SelectedBox[playerid]], 
				MenuInfo[MenuID][OrigPosX][ SelectedBox[playerid] ], 
				MenuInfo[MenuID][OrigPosY][ SelectedBox[playerid] ], 
				MenuInfo[MenuID][OrigPosZ][ SelectedBox[playerid] ], 1.0 );
			
			SelectedBox[playerid]--;

			if( SelectedBox[playerid] < 0 ) 
			{
				SetPageTexViewer( playerid, "-", Menu3DData[playerid][CurrTextureType] );
			
				SelectedBox[playerid] = MenuInfo[MenuID][Boxes] - 1;
			}

			GetDynamicObjectMaterial(MenuInfo[MenuID][Objects][SelectedBox[playerid]],0,model, txd, texture, color);
		 	SetDynamicObjectMaterial(MenuInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, MenuInfo[MenuID][SelectColor][ SelectedBox[playerid] ] );

			MoveDynamicObject( MenuInfo[MenuID][Objects][ SelectedBox[playerid] ], 
				MenuInfo[MenuID][OrigPosX][ SelectedBox[playerid] ] + MenuInfo[MenuID][AddingX],
				MenuInfo[MenuID][OrigPosY][ SelectedBox[playerid] ] + MenuInfo[MenuID][AddingY],
				MenuInfo[MenuID][OrigPosZ][ SelectedBox[playerid] ], 1.0 );
				
			if( !SelectedType{playerid} )
			{
				SetHouseTexture( GetPVarInt( playerid, "Hpanel:HId" ), SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex], Menu3DData[playerid][CurrTextureType], Menu3DData[playerid][CurrPartNumber] );
			}
			else
			{
				SetBusinessTexture( GetPVarInt( playerid, "Bpanel:BId" ), SelectedBox[playerid] + Menu3DData[playerid][CurrTextureIndex], Menu3DData[playerid][CurrTextureType], Menu3DData[playerid][CurrPartNumber] );
			}
			
			return 1;
		}
		
		if( PRESSED(KEY_WALK) )
		{
			new
				mprice;
				
			switch( Menu3DData[playerid][CurrTextureType] )
			{
				case 0: mprice = PRICE_HOUSE_WALL - floatround( PRICE_HOUSE_WALL * Premium[playerid][prem_drop_retreature] / 100 );
				case 1: mprice = PRICE_HOUSE_FLOOR - floatround( PRICE_HOUSE_FLOOR * Premium[playerid][prem_drop_retreature] / 100 );
				case 2: mprice = PRICE_HOUSE_ROOF - floatround( PRICE_HOUSE_ROOF * Premium[playerid][prem_drop_retreature] / 100 );
				case 3: mprice = PRICE_HOUSE_STAIR - floatround( PRICE_HOUSE_STAIR * Premium[playerid][prem_drop_retreature] / 100 );
			}
			
			format:g_small_string( "\
				"cWHITE"Действие\t"cWHITE"Стоимость\n\
				"cWHITE"Купить текстуру\t"cBLUE"$%d\n\
				"cWHITE"Выйти из редактора", mprice );
			
			if( !SelectedType{playerid} )
			{
				SetPVarInt( playerid, "Hpanel:PriceTexture", mprice );
				showPlayerDialog( playerid, d_house_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "Ретекстуризация", g_small_string, "Выбрать", "Закрыть" );
			}
			else
			{
				SetPVarInt( playerid, "Bpanel:PriceTexture", mprice );
				showPlayerDialog( playerid, d_business_panel + 15, DIALOG_STYLE_TABLIST_HEADERS, "Ретекстуризация", g_small_string, "Выбрать", "Закрыть" );
			}
		}
	}

	return 1;
}

SetHouseTexture( h, texture, type, number ) // Применение текстур на объектах
{
	if( texture < 0 )
		texture = 0;
	
	switch( type )
	{
		case 0://Текстуры стен
		{	
			for( new i = HTextureWall[h][number][0]; i < HTextureWall[h][number][1] + 1; i++ )
			{
				if( !IsValidDynamicObject( i ) || !i ) continue;
				
				SetDynamicObjectMaterial( i, 0, b_wall_textures[ texture ][b_tx_id], b_wall_textures[ texture ][b_tx_number], b_wall_textures[ texture ][b_tx_model], 0 );
			}
		}
		case 1://Текстуры пола
		{
			for( new i = HTextureFloor[h][number][0]; i < HTextureFloor[h][number][1] + 1; i++ )
			{
				if( !IsValidDynamicObject( i ) || !i ) continue;
				
				SetDynamicObjectMaterial( i, 0, b_floor_textures[ texture ][b_tx_id], b_floor_textures[ texture ][b_tx_number], b_floor_textures[ texture ][b_tx_model], 0 );
			}
		}
		case 2://Текстуры потолка
		{
			for( new i = HTextureRoof[h][number][0]; i < HTextureRoof[h][number][1] + 1; i++ )
			{
				if( !IsValidDynamicObject( i ) || !i ) continue;
				
				SetDynamicObjectMaterial( i, 0, b_roof_textures[ texture ][b_tx_id], b_roof_textures[ texture ][b_tx_number], b_roof_textures[ texture ][b_tx_model], 0 );
			}
		}
		case 3://Текстуры лестниц
		{
			for( new i = HTextureStairs[h][0]; i < HTextureStairs[h][1] + 1; i++ )
			{
				if( !IsValidDynamicObject( i ) || !i ) continue;
				
				SetDynamicObjectMaterial( i, 0, b_floor_textures[ texture ][b_tx_id], b_floor_textures[ texture ][b_tx_number], b_floor_textures[ texture ][b_tx_model], 0 );
				SetDynamicObjectMaterial( i, 1, b_floor_textures[ texture ][b_tx_id], b_floor_textures[ texture ][b_tx_number], b_floor_textures[ texture ][b_tx_model], 0 );
			}
		}
	}
	
	return 1;
}

//Создание 3D меню и отображение первых текстур
ShowTexViewer( playerid, type, number, index )
{
	SendClient:( playerid, C_WHITE, !""gbDefault"Вы открыли редактор текстур. Используйте клавиши "cBLUE"F"cWHITE" и "cBLUE"H"cWHITE" - для управления," );
	SendClient:( playerid, C_WHITE, !""gbDefault""cBLUE"ALT"cWHITE" - для покупки текстуры или выхода из редактора." );
 
	Menu3DData[playerid][ CurrTextureIndex ] = index;
	Menu3DData[playerid][ CurrPartNumber ] = number;
	Menu3DData[playerid][ CurrTextureType ] = type;
		
	CreateTexViewer( playerid );
	
	switch( type )
	{
		case 0:	// Стена
		{
			for( new i = 0; i < MAX_BOXES; i++ )
			{
				if( i + index >= sizeof b_wall_textures - 1 ) continue;
			
				SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
					b_wall_textures[ i+index ][b_tx_id],
					b_wall_textures[ i+index ][b_tx_number],
					b_wall_textures[ i+index ][b_tx_model], 
					0, 0xFF999999 );
			}
		}
		
		case 1, 3: // Пол, лестницы
		{
			for( new i = 0; i < MAX_BOXES; i++ )
			{
				if( i + index >= sizeof b_floor_textures - 1 ) continue;
			
				SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
					b_floor_textures[ i+index ][b_tx_id],
					b_floor_textures[ i+index ][b_tx_number],
					b_floor_textures[ i+index ][b_tx_model], 
					0, 0xFF999999 );
			}
		}
		
		case 2: // Потолок
		{
			for( new i = 0; i < MAX_BOXES; i++ )
			{
				if( i + index >= sizeof b_roof_textures - 1 ) continue;
			
				SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
					b_roof_textures[ i+index ][b_tx_id],
					b_roof_textures[ i+index ][b_tx_number],
					b_roof_textures[ i+index ][b_tx_model], 
					0, 0xFF999999 );
			}
		}
	}
	
	if( !SelectedType{playerid} )
	{
		SetHouseTexture( GetPVarInt( playerid, "Hpanel:HId" ), Menu3DData[playerid][CurrTextureIndex], Menu3DData[playerid][CurrTextureType], Menu3DData[playerid][CurrPartNumber] );
	}
	else
	{
		SetBusinessTexture( GetPVarInt( playerid, "Bpanel:BId" ), Menu3DData[playerid][CurrTextureIndex], Menu3DData[playerid][CurrTextureType], Menu3DData[playerid][CurrPartNumber] );
	}
	
	return 1;
}

//Создание меню
CreateTexViewer( playerid )
{
	new 
		Float:x, 
		Float:y, 
		Float:z, 
		Float:fa;
		
	GetPlayerPos( playerid, x, y, z );
	GetPlayerFacingAngle( playerid, fa );
	
	x = ( x + 1.75 * floatsin( -fa + -90, degrees ) );
	y = ( y + 1.75 * floatcos( -fa + -90, degrees ) );
	
	x = ( x + 2.0 * floatsin( -fa, degrees ) );
	y = ( y + 2.0 * floatcos( -fa, degrees ) );
	
	Menu3DData[ playerid ][ Menus3D ] = Create3DMenu( playerid, x, y, z, fa, MAX_BOXES );
	Select3DMenu( playerid, Menu3DData[ playerid ][ Menus3D ] );
}

DestroyTexViewer( playerid )
{
	CancelSelect3DMenu( playerid );
	Destroy3DMenu( Menu3DData[playerid][Menus3D] );
	Clear3DMenuData( playerid );
}

//Создание меню из объектов
Create3DMenu(playerid,Float:x,Float:y,Float:z,Float:rotation,boxes)
{
	// Make sure box is in range
	if( boxes > MAX_BOXES || boxes <= 0 ) return INVALID_PARAM;

	// Create 3D Menu
	for( new i = 0; i < MAX_3DMENUS; i++ )
	{
		// Menu exists continue
	    if( MenuInfo[i][IsExist] ) continue;

     	new 
			Float:NextLineX,
			Float:NextLineY,
			lineindx,
			binc;

       	//MenuInfo[i][MenuRotation] = rotation;
		MenuInfo[i][Boxes] = boxes;
		MenuInfo[i][AddingX] = 0.25 * floatsin( rotation, degrees );
		MenuInfo[i][AddingY] = -floatcos( rotation, degrees ) * 0.25;

		NextLineX = floatcos( rotation, degrees ) + 0.05 * floatcos( rotation, degrees );
		NextLineY = floatsin( rotation, degrees ) + 0.05 * floatsin( rotation, degrees );

		// Create menu objects
		for( new b = 0; b < boxes; b++ )
		{
  			if( b%4 == 0 && b != 0 )
				lineindx ++,
				binc += 4;
				
   			MenuInfo[i][Objects][b] = CreateDynamicObject( 2661, 
				x+NextLineX*lineindx, 
				y+NextLineY*lineindx, 
				z+1.65-0.55*(b-binc), 
				0, 0, rotation, 
				INVALID_PARAM,
				INVALID_PARAM,
				playerid, 100.0 );
				
      		GetDynamicObjectPos( 
				MenuInfo[i][Objects][b], 
				MenuInfo[i][OrigPosX][b], 
				MenuInfo[i][OrigPosY][b], 
				MenuInfo[i][OrigPosZ][b] );
		}
		
		MenuInfo[i][IsExist] = true;
		MenuInfo[i][MPlayer] = playerid;
		
		Streamer_Update( playerid );
		
		return i;
	}
	
	return INVALID_PARAM;
}

//Выбор первой текстуры
Select3DMenu( playerid, MenuID )
{
	if( !IsLogged( playerid ) || !MenuInfo[MenuID][IsExist] || MenuInfo[MenuID][MPlayer]		 != playerid ) 
		return INVALID_PARAM;

	if( SelectedMenu[playerid] != INVALID_PARAM ) 
		CancelSelect3DMenu( playerid );

	SelectedBox[playerid] = 0;
	SelectedMenu[playerid] = MenuID;

	new 
		model,
		txd[32],
		texture[32], 
		color;
		
	GetDynamicObjectMaterial( MenuInfo[MenuID][Objects][0], 0, model, txd, texture, color );
 	SetDynamicObjectMaterial( MenuInfo[MenuID][Objects][0], 0, model, txd, texture, MenuInfo[MenuID][SelectColor][0] );

 	MoveDynamicObject( MenuInfo[MenuID][Objects][0], 
		MenuInfo[MenuID][OrigPosX][0] + MenuInfo[MenuID][AddingX],
		MenuInfo[MenuID][OrigPosY][0] + MenuInfo[MenuID][AddingY],
		MenuInfo[MenuID][OrigPosZ][0], 
		1.0 );

	return 1;
}

SetBoxMaterial( MenuID, box, index, model, txd[], texture[], selectcolor, unselectcolor )
{
	if( !MenuInfo[MenuID][IsExist] || box == MenuInfo[MenuID][Boxes] || box < 0 || MenuInfo[MenuID][Objects][box] == INVALID_OBJECT_ID ) 
		return INVALID_PARAM;

	MenuInfo[MenuID][SelectColor][box] = selectcolor;
	MenuInfo[MenuID][UnselectColor][box] = unselectcolor;
	
	if( SelectedBox[ MenuInfo[MenuID][MPlayer] ] == box ) 
		SetDynamicObjectMaterial( MenuInfo[MenuID][Objects][box], index, model, txd, texture, selectcolor );
	else 
		SetDynamicObjectMaterial( MenuInfo[MenuID][Objects][box], index, model, txd, texture, unselectcolor );
	
	return 1;
}

SetPageTexViewer( playerid, act[] = "+", type )
{
	new
		mAMOUNT,
		mINDEX;

	switch( act[0] )
	{
		case '+':
		{
			Menu3DData[playerid][CurrTextureIndex] += MAX_BOXES; // Добавляем индекс
			
			switch( type )
			{
				case 0: // Стены
				{
					mAMOUNT = sizeof b_wall_textures;

					if( Menu3DData[playerid][CurrTextureIndex] >= mAMOUNT - 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = 0;
					else if( mAMOUNT - 1 - Menu3DData[playerid][CurrTextureIndex] - MAX_BOXES < 0 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - 1 - MAX_BOXES;
				
					mINDEX = Menu3DData[playerid][CurrTextureIndex];
				
					for(new i = 0; i < MAX_BOXES; i++)
					{
						if( i + mINDEX >= mAMOUNT - 1 ) continue;
					
						SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
							b_wall_textures[ i+mINDEX ][b_tx_id],
							b_wall_textures[ i+mINDEX ][b_tx_number],
							b_wall_textures[ i+mINDEX ][b_tx_model], 
							0, 0xFF999999 );
					}
				}
				
				case 1, 3: // Пол, лестницы
				{
					mAMOUNT = sizeof b_floor_textures;

					if( Menu3DData[playerid][CurrTextureIndex] >= mAMOUNT - 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = 0;
					else if( mAMOUNT - 1 - Menu3DData[playerid][CurrTextureIndex] - MAX_BOXES < 0 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - 1 - MAX_BOXES;
				
					mINDEX = Menu3DData[playerid][CurrTextureIndex];
				
					for(new i = 0; i < MAX_BOXES; i++)
					{
						if( i + mINDEX >= mAMOUNT - 1 ) continue;
					
						SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
							b_floor_textures[ i+mINDEX ][b_tx_id],
							b_floor_textures[ i+mINDEX ][b_tx_number],
							b_floor_textures[ i+mINDEX ][b_tx_model], 
							0, 0xFF999999 );
					}
				}
				
				case 2: // Потолок
				{
					mAMOUNT = sizeof b_roof_textures;

					if( Menu3DData[playerid][CurrTextureIndex] >= mAMOUNT - 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = 0;
					else if( mAMOUNT - 1 - Menu3DData[playerid][CurrTextureIndex] - MAX_BOXES < 0 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - 1 - MAX_BOXES;
				
					mINDEX = Menu3DData[playerid][CurrTextureIndex];
				
					for(new i = 0; i < MAX_BOXES; i++)
					{
						if( i + mINDEX >= mAMOUNT - 1 ) continue;
					
						SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
							b_roof_textures[ i+mINDEX ][b_tx_id],
							b_roof_textures[ i+mINDEX ][b_tx_number],
							b_roof_textures[ i+mINDEX ][b_tx_model], 
							0, 0xFF999999 );
					}
				}
			}
		}
		
		case '-':
		{
			Menu3DData[playerid][CurrTextureIndex] -= MAX_BOXES; //Вычитаем индекс

			switch( type )
			{
				case 0: // Стены
				{
					mAMOUNT = sizeof b_wall_textures;
				
					if( Menu3DData[playerid][CurrTextureIndex] < 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - MAX_BOXES - 1;

					if( Menu3DData[playerid][CurrTextureIndex] >= mAMOUNT - 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - 1;
					
					mINDEX = Menu3DData[playerid][CurrTextureIndex];
					
					for(new i = 0; i < MAX_BOXES; i++)
					{
						if( i + mINDEX >= mAMOUNT - 1 ) continue;
					
						SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
							b_wall_textures[ i+mINDEX ][b_tx_id],
							b_wall_textures[ i+mINDEX ][b_tx_number],
							b_wall_textures[ i+mINDEX ][b_tx_model], 
							0, 0xFF999999 );
					}
				}
				
				case 1, 3: //Пол, лестницы
				{
					mAMOUNT = sizeof b_floor_textures;
				
					if( Menu3DData[playerid][CurrTextureIndex] < 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - MAX_BOXES - 1;

					if( Menu3DData[playerid][CurrTextureIndex] >= mAMOUNT - 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - 1;
					
					mINDEX = Menu3DData[playerid][CurrTextureIndex];
					
					for(new i = 0; i < MAX_BOXES; i++)
					{
						if( i + mINDEX >= mAMOUNT - 1 ) continue;
					
						SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
							b_floor_textures[ i+mINDEX ][b_tx_id],
							b_floor_textures[ i+mINDEX ][b_tx_number],
							b_floor_textures[ i+mINDEX ][b_tx_model], 
							0, 0xFF999999 );
					}
				}
				
				case 2: //Потолок
				{
					mAMOUNT = sizeof b_roof_textures;
				
					if( Menu3DData[playerid][CurrTextureIndex] < 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - MAX_BOXES - 1;

					if( Menu3DData[playerid][CurrTextureIndex] >= mAMOUNT - 1 ) 
						Menu3DData[playerid][CurrTextureIndex] = mAMOUNT - 1;
					
					mINDEX = Menu3DData[playerid][CurrTextureIndex];
					
					for(new i = 0; i < MAX_BOXES; i++)
					{
						if( i + mINDEX >= mAMOUNT - 1 ) continue;
					
						SetBoxMaterial( Menu3DData[playerid][Menus3D], i, 0, 
							b_roof_textures[ i+mINDEX ][b_tx_id],
							b_roof_textures[ i+mINDEX ][b_tx_number],
							b_roof_textures[ i+mINDEX ][b_tx_model], 
							0, 0xFF999999 );
					}
				}
			}
		}
	}
	
	return 1;
}

CancelSelect3DMenu( playerid )
{
	if( !IsLogged( playerid ) || SelectedMenu[playerid] == INVALID_PARAM ) 
		return INVALID_PARAM;
	
	new 
		MenuID = SelectedMenu[playerid];

	new 
		model,
		txd[32],
		texture[32], 
		color;
		
	GetDynamicObjectMaterial( MenuInfo[MenuID][Objects][SelectedBox[playerid]], 0, model, txd, texture, color);
 	SetDynamicObjectMaterial( MenuInfo[MenuID][Objects][SelectedBox[playerid]], 0, model, txd, texture, MenuInfo[MenuID][UnselectColor][ SelectedBox[playerid] ] );

	MoveDynamicObject( MenuInfo[MenuID][Objects][SelectedBox[playerid]],
		MenuInfo[MenuID][OrigPosX][ SelectedBox[playerid] ],
		MenuInfo[MenuID][OrigPosY][ SelectedBox[playerid] ],
		MenuInfo[MenuID][OrigPosZ][ SelectedBox[playerid] ], 1.0 );
	
	SelectedMenu[playerid] = 
	SelectedBox[playerid] = INVALID_PARAM;
	if( SelectedType{playerid} ) SelectedType{playerid} = 0;
	
	return 1;
}

Destroy3DMenu( MenuID )
{
    if( !MenuInfo[MenuID][IsExist] ) 
		return INVALID_PARAM;
    
	if( SelectedMenu[ MenuInfo[MenuID][MPlayer]		 ] == MenuID ) 
		CancelSelect3DMenu( MenuInfo[MenuID][MPlayer] );
   
	for( new i = 0; i < MenuInfo[MenuID][Boxes]; i++ )
    {
		DestroyDynamicObject( MenuInfo[MenuID][Objects][i] );
		MenuInfo[MenuID][Objects][i] = INVALID_OBJECT_ID;
	}
	
 	MenuInfo[MenuID][Boxes] = 0;
 	MenuInfo[MenuID][IsExist] = false;
 	MenuInfo[MenuID][AddingX] = 
 	MenuInfo[MenuID][AddingY] = 0.0;
 	MenuInfo[MenuID][MPlayer] = INVALID_PARAM;
	
	return 1;
}

Clear3DMenuData( playerid )
{
	Menu3DData[playerid][CurrTextureIndex] =
	Menu3DData[playerid][CurrTextureType] =
	Menu3DData[playerid][CurrPartNumber] =
	Menu3DData[playerid][Menus3D] = 0;

	SelectedMenu[playerid] = 
	SelectedBox[playerid] = INVALID_PARAM;
	SelectedType{playerid} = 0;
}

checkPlayerUseTexViewer( playerid )
{
	if( SelectedMenu[playerid] != INVALID_PARAM )
	{
		if( !SelectedType{playerid} )
		{
			new
				h = GetPVarInt( playerid, "Hpanel:HId" );
		
			SetHouseTexture( h, HouseInfo[h][hWall][ Menu3DData[playerid][CurrPartNumber] ], 0, Menu3DData[playerid][CurrPartNumber] );
			SetHouseTexture( h, HouseInfo[h][hFloor][ Menu3DData[playerid][CurrPartNumber] ], 1, Menu3DData[playerid][CurrPartNumber] );
			SetHouseTexture( h, HouseInfo[h][hRoof][ Menu3DData[playerid][CurrPartNumber] ], 2, Menu3DData[playerid][CurrPartNumber] );
			SetHouseTexture( h, HouseInfo[h][hStairs], 3, INVALID_PARAM );
		}
		else
		{
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" );
		
			SetBusinessTexture( bid, BusinessInfo[bid][b_wall][ Menu3DData[playerid][CurrPartNumber] ], 0, Menu3DData[playerid][CurrPartNumber] );
			SetBusinessTexture( bid, BusinessInfo[bid][b_floor][ Menu3DData[playerid][CurrPartNumber] ], 1, Menu3DData[playerid][CurrPartNumber] );
			SetBusinessTexture( bid, BusinessInfo[bid][b_roof][ Menu3DData[playerid][CurrPartNumber] ], 2, Menu3DData[playerid][CurrPartNumber] );
			SetBusinessTexture( bid, BusinessInfo[bid][b_stair], 3, INVALID_PARAM );
		}
	
		DestroyTexViewer( playerid );
	}

	return 1;
}