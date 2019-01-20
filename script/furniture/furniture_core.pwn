Furniture_OnGameModeInit() 
{
    CreateDynamicPickup( 1239, 23, PICKUP_FURNITURE, -1 );
    CreateDynamic3DTextLabel( "Покупка мебели", 0xFFFFFFFF, PICKUP_FURNITURE, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	return 1;
}

Furn_OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) 
{
	if( PRESSED( KEY_WALK ) ) 
	{
		if( IsPlayerInRangeOfPoint( playerid, 1.0, PICKUP_FURNITURE ) ) 
		{
			new
				bool:slot = false;
			
			for( new h; h < MAX_PLAYER_HOUSE; h++ ) 
			{
				if( Player[playerid][tHouse][h] != INVALID_PARAM  )
				{			
					slot = true;
					break;
				}
			}	
			
			for( new i; i < MAX_PLAYER_BUSINESS; i++ ) 
			{
				if( Player[playerid][tBusiness][i] != INVALID_PARAM ) 
				{
					slot = true;
					break;
				}
			}
			
			if( !slot ) return SendClient:( playerid, C_GRAY, ""gbError"У вас нет недвижимости." );
			
			showPlayerDialog( playerid, d_mebelbuy + 2, DIALOG_STYLE_LIST, " ", furniture_type, "Выбрать", "Закрыть" );
		}
	}

	return 1;
}

Furniture_OnPlayerClickTextDraw( playerid, Text:clickedid ) 
{
	clean_array();
	
	if( _:clickedid == INVALID_TEXT_DRAW  ) 
	{
		switch( GetPVarInt( playerid, "Furn:View" ) )
		{
			case 1:
			{
				if( IsValidDynamicObject( furn_object[playerid] ) )
				{
					DestroyDynamicObject( furn_object[playerid] );
					furn_object[playerid] = 0;
				}
				for(new i; i != 7; i ++) 
				{
					TextDrawHideForPlayer(playerid, furnitureBuy[i]);
				}
					
				PlayerTextDrawHide( playerid, furniturePrice[playerid] );
				PlayerTextDrawHide( playerid, furnitureName[playerid] );
				
				SetPlayerVirtualWorld( playerid, GetPVarInt( playerid, "Furn:IntWorld" ) );
				
				setPlayerPos( playerid, PICKUP_FURNITURE );
				
				SetCameraBehindPlayer( playerid );
				
				togglePlayerControllable( playerid, true );
				
				SetPVarInt( playerid, "Furn:IntWorld", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Furn:Type", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Furn:Max", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Furn:Object", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Furn:View", INVALID_PLAYER_ID );
				DeletePVar( playerid, "Furn:PlayerPos" );
				DeletePVar( playerid, "Player:World" );
				
				showPlayerDialog( playerid, d_mebelbuy + 2, DIALOG_STYLE_LIST, " ", furniture_type, "Выбрать", "Закрыть" );
				return 1;
			}
			//Разное в бизнесе
			case 2:
			{
				new 
					bid = GetPVarInt( playerid, "Bpanel:BId" );
				
				if( IsValidDynamicObject( furn_object[playerid] ) )
				{
					DestroyDynamicObject( furn_object[playerid] );
					furn_object[playerid] = 0;
				}
				
				TextDrawHideForPlayer(playerid, furnitureBuy[0]);
				TextDrawHideForPlayer(playerid, furnitureBuy[1]);
				TextDrawHideForPlayer(playerid, furnitureBuy[6]);
					
				for( new i; i != 4; i++ )
				{
					TextDrawHideForPlayer(playerid, furnitureOther[i]);
				}		
					
				PlayerTextDrawHide( playerid, furniturePrice[playerid] );
				PlayerTextDrawHide( playerid, furnitureName[playerid] );
				
				SetPlayerVirtualWorld( playerid,  BusinessInfo[bid][b_id] );
				
				setPlayerPos( playerid, BusinessInfo[bid][b_exit_pos][0], BusinessInfo[bid][b_exit_pos][1], BusinessInfo[bid][b_exit_pos][2] );
				
				SetCameraBehindPlayer( playerid );
				
				togglePlayerControllable( playerid, true );
				
				SetPVarInt( playerid, "FurnOther:Type", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "FurnOther:Max", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "FurnOther:Object", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Furn:View", INVALID_PLAYER_ID );
				DeletePVar( playerid, "Player:World" );
				
				showPlayerDialog( playerid, d_mebelbuy + 5, DIALOG_STYLE_LIST, " ", furniture_other, "Выбрать", "Назад" );
				return 1;
			}
			//Разное в доме
			case 3:
			{
				new 
					h = GetPVarInt( playerid, "Hpanel:HId" );
				
				if( IsValidDynamicObject( furn_object[playerid] ) )
				{
					DestroyDynamicObject( furn_object[playerid] );
					furn_object[playerid] = 0;
				}
				
				TextDrawHideForPlayer(playerid, furnitureBuy[0]);
				TextDrawHideForPlayer(playerid, furnitureBuy[1]);
				TextDrawHideForPlayer(playerid, furnitureBuy[6]);
					
				for( new i; i < 5; i++ )
				{
					if( i == 2 ) continue;
					TextDrawHideForPlayer( playerid, furnitureOther[i] );
				}		
					
				PlayerTextDrawHide( playerid, furniturePrice[playerid] );
				PlayerTextDrawHide( playerid, furnitureName[playerid] );
				
				SetPlayerVirtualWorld( playerid, HouseInfo[h][hID] );
				
				setPlayerPos( playerid, HouseInfo[h][hExitPos][0], HouseInfo[h][hExitPos][1], HouseInfo[h][hExitPos][2] );
				
				SetCameraBehindPlayer( playerid );
				
				togglePlayerControllable( playerid, true );
				
				SetPVarInt( playerid, "FurnOther:Type", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "FurnOther:Max", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "FurnOther:Object", INVALID_PLAYER_ID );
				SetPVarInt( playerid, "Furn:View", INVALID_PLAYER_ID );
				DeletePVar( playerid, "Player:World" );
				
				showPlayerDialog( playerid, d_mebelbuy + 8, DIALOG_STYLE_LIST, " ", furniture_other, "Выбрать", "Назад" );
				return 1;
			}
		}
	}
	else if( clickedid == furnitureBuy[2] ) //Стрелка влево
	{
		if( !GetPVarInt( playerid, "Furn:Object" ) )
		{
			SetPVarInt( playerid, "Furn:Object", GetPVarInt( playerid, "Furn:Max" ) - 1 );

			FurniturePreviewObject( playerid, GetPVarInt( playerid, "Furn:Type") );
			
			return 1;
		}
		
		GivePVarInt( playerid, "Furn:Object", -1 );

		FurniturePreviewObject( playerid, GetPVarInt( playerid, "Furn:Type") );
		return 1;
	}
	else if( clickedid == furnitureBuy[3] ) //Стрелка вправо
	{
		if( GetPVarInt( playerid, "Furn:Object" ) == GetPVarInt( playerid, "Furn:Max" ) - 1 )
		{
			SetPVarInt( playerid, "Furn:Object", 0 );

			FurniturePreviewObject( playerid, GetPVarInt( playerid, "Furn:Type") );
			return 1;
		}
		
		if( GetPVarInt( playerid, "Furn:Object" ) < GetPVarInt( playerid, "Furn:Max" ) ) 
		{
			GivePVarInt( playerid, "Furn:Object", 1 );

			FurniturePreviewObject( playerid, GetPVarInt( playerid, "Furn:Type") );
			return 1;
		}
		
		return 1;
	}
	else if( clickedid == furnitureBuy[5] ) //Кнопка Назад
	{
		CancelSelectTextDraw( playerid );
		return 1;
	}
	else if( clickedid == furnitureBuy[4] )
	{
		if( Player[playerid][uMoney] < furniture_list[GetPVarInt( playerid, "Furn:Type" )][GetPVarInt( playerid, "Furn:Object" )][f_price])
		{
			return SendClient:( playerid, C_GRAY, !NO_MONEY );
		}
		
		DeletePVar( playerid, "Furn:View" );
		
		showPlayerDialog( playerid, d_mebelbuy + 3, DIALOG_STYLE_LIST, "Укажите место для доставки", 
			""cWHITE"Дом\n\
			Бизнес", 
		"Выбрать", "Закрыть" );
		
		CancelSelectTextDraw( playerid );
		return 1;
	}
	
	//Разное в бизнесе
	else if( clickedid == furnitureOther[0] )
	{
		if( !GetPVarInt( playerid, "FurnOther:Object") )
		{
			SetPVarInt( playerid, "FurnOther:Object", GetPVarInt( playerid, "FurnOther:Max" ) - 1 );

			OtherPreviewObject( playerid, GetPVarInt( playerid, "FurnOther:Type") );
			return 1;
		}
		
		GivePVarInt( playerid, "FurnOther:Object", -1 );

		OtherPreviewObject( playerid, GetPVarInt( playerid, "FurnOther:Type") );
		return 1;
	}
	else if( clickedid == furnitureOther[1] )
	{
		if( GetPVarInt( playerid, "FurnOther:Object" ) == GetPVarInt( playerid, "FurnOther:Max" ) - 1 )
		{
			SetPVarInt( playerid, "FurnOther:Object", 0 );

			OtherPreviewObject( playerid, GetPVarInt( playerid, "FurnOther:Type" ) );
			return 1;
		}
		
		if( GetPVarInt( playerid, "FurnOther:Object" ) < GetPVarInt( playerid, "FurnOther:Max" ) ) 
		{
			GivePVarInt( playerid, "FurnOther:Object", 1 );

			OtherPreviewObject( playerid, GetPVarInt( playerid, "FurnOther:Type" ) );
			return 1;
		}
		return 1;
	}
	else if( clickedid == furnitureOther[2] )
	{
		new 
			bid = GetPVarInt( playerid, "Bpanel:BId" );
		
		if( BusinessInfo[bid][b_safe] < other_list[GetPVarInt( playerid, "FurnOther:Type" )][GetPVarInt( playerid, "FurnOther:Object" )][f_price])
		{
			return SendClient:( playerid, C_GRAY, !""gbError"В сейфе бизнеса недостаточно денег для совершения операции." );
		}
		
		DeletePVar( playerid, "Furn:View" );
		
		format:g_small_string( "\
			"cBLUE"Покупка дополнительной мебели\n\n\
			"cWHITE"Вы действительно хотите купить "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?",
			other_list[GetPVarInt( playerid, "FurnOther:Type" )][GetPVarInt( playerid, "FurnOther:Object" )][f_name],
			other_list[GetPVarInt( playerid, "FurnOther:Type" )][GetPVarInt( playerid, "FurnOther:Object" )][f_price]
		);
		
		showPlayerDialog( playerid, d_mebelbuy + 6, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		
		CancelSelectTextDraw( playerid );
		return 1;
	}
	else if( clickedid == furnitureOther[4] )
	{
		new 
			h = GetPVarInt( playerid, "Hpanel:HId" );
		
		if( HouseInfo[h][hMoney] < other_list[GetPVarInt( playerid, "FurnOther:Type" )][GetPVarInt( playerid, "FurnOther:Object" )][f_price] )
		{
			return SendClient:( playerid, C_GRAY, !""gbError"В сейфе дома недостаточно денег для совершения операции." );
		}
		
		DeletePVar( playerid, "Furn:View" );
		
		format:g_small_string( "\
			"cBLUE"Покупка дополнительной мебели\n\n\
			"cWHITE"Вы действительно хотите купить "cBLUE"%s"cWHITE" за "cBLUE"$%d"cWHITE"?",
			other_list[GetPVarInt( playerid, "FurnOther:Type" )][GetPVarInt( playerid, "FurnOther:Object" )][f_name],
			other_list[GetPVarInt( playerid, "FurnOther:Type" )][GetPVarInt( playerid, "FurnOther:Object" )][f_price]
		);
		
		showPlayerDialog( playerid, d_mebelbuy + 9, DIALOG_STYLE_MSGBOX, " ", g_small_string, "Да", "Нет" );
		
		CancelSelectTextDraw( playerid );
		return 1;
	}
	else if( clickedid == furnitureOther[3] )
	{
		CancelSelectTextDraw( playerid );
		return 1;
	}
	
	return 0;
}

stock FurniturePreviewObject( playerid, type ) 
{
	new
		world = GetPlayerVirtualWorld( playerid ),
		objectid = GetPVarInt( playerid, "Furn:Object" ),
		pos = GetPVarInt( playerid, "Furn:PlayerPos" );
		
	if( IsValidDynamicObject( furn_object[playerid] ) )
	{
		DestroyDynamicObject( furn_object[playerid] );
		furn_object[playerid] = 0;
	}
		
	format:g_small_string(  "ЦЕНА: $%d", furniture_list[type][objectid][f_price] );
	PlayerTextDrawSetString( playerid, furniturePrice[playerid], g_small_string );
			
	format:g_string(  "%s", furniture_list[type][objectid][f_name] );
	PlayerTextDrawSetString( playerid, furnitureName[playerid], g_string );
	
	furn_object[playerid] = CreateDynamicObject( furniture_list[type][objectid][f_id], 
												furniture_list[type][objectid][f_pos][0], 
												furniture_list[type][objectid][f_pos][1], 
												furniture_list[type][objectid][f_pos][2], 
												furniture_list[type][objectid][f_pos][3], 
												furniture_list[type][objectid][f_pos][4], 
												furniture_list[type][objectid][f_pos][5], world );
	switch( pos )
	{
		case 1:
		{
			setPlayerPos( playerid, -490.3429, -260.2866, 3600.0859 );
			SetPVarInt( playerid, "Furn:PlayerPos", 2 );
		}
		
		case 2:
		{
			setPlayerPos( playerid, -489.3429, -260.2866, 3600.0859 );
			SetPVarInt( playerid, "Furn:PlayerPos", 1 );
		}
	}
	
	return 1;
}

stock OtherPreviewObject( playerid, type ) 
{
	new
		world = GetPlayerVirtualWorld( playerid ),
		objectid = GetPVarInt( playerid, "FurnOther:Object" ),
		pos = GetPVarInt( playerid, "Furn:PlayerPos" );
		
	if( IsValidDynamicObject( furn_object[playerid] ) )
	{
		DestroyDynamicObject( furn_object[playerid] );
		furn_object[playerid] = 0;
	}
		
	format:g_small_string(  "ЦЕНА: $%d", other_list[type][objectid][f_price] );
	PlayerTextDrawSetString( playerid, furniturePrice[playerid], g_small_string );
			
	format:g_string(  "%s", other_list[type][objectid][f_name] );
	PlayerTextDrawSetString( playerid, furnitureName[playerid], g_string );
	
	furn_object[playerid] = CreateDynamicObject( other_list[type][objectid][f_id], 
												other_list[type][objectid][f_pos][0], 
												other_list[type][objectid][f_pos][1], 
												other_list[type][objectid][f_pos][2], 
												other_list[type][objectid][f_pos][3], 
												other_list[type][objectid][f_pos][4], 
												other_list[type][objectid][f_pos][5], world );	
	switch( pos )
	{
		case 1:
		{
			setPlayerPos( playerid, -490.3429, -260.2866, 3600.0859 );
			SetPVarInt( playerid, "Furn:PlayerPos", 2 );
		}
		
		case 2:
		{
			setPlayerPos( playerid, -489.3429, -260.2866, 3600.0859 );
			SetPVarInt( playerid, "Furn:PlayerPos", 1 );
		}
	}
	
	return 1;
}

AddFurniture( index, ftype, object, subtype, type = 0 )
{
	switch( type )
	{
		case 0:
		{
			for( new i; i < GetMaxFurnBusiness( index ); i++ )
			{
				if( !BFurn[index][i][f_id] )
				{
					switch( subtype )
					{
						case 0:	
						{
							BFurn[index][i][f_model] = furniture_list[ftype][object][f_id];
							
							BFurn[index][i][f_name][0] = EOS;
							strcat( BFurn[index][i][f_name], furniture_list[ftype][object][f_name], 32 );
							
							BFurn[index][i][f_type] = ftype;
						}
						
						case 1:	
						{
							BFurn[index][i][f_model] = other_list[ftype][object][f_id];
							
							BFurn[index][i][f_name][0] = EOS;
							strcat( BFurn[index][i][f_name], other_list[ftype][object][f_name], 32 );
							
							BFurn[index][i][f_type] = ftype + 16;
						}
					}
					
					BFurn[index][i][f_bid] = BusinessInfo[index][b_id];
					BFurn[index][i][f_state] = 0;
					
					mysql_format:g_string( "INSERT INTO `"DB_BUSINESS_FURN"` \
						( `f_bid`, `f_type`, `f_model`, `f_name` ) VALUES \
						( '%d', '%d', '%d', '%e' )",
						BFurn[index][i][f_bid],
						BFurn[index][i][f_type],
						BFurn[index][i][f_model],
						BFurn[index][i][f_name]
					);
					
					mysql_tquery( mysql, g_string, "InsertFurniture", "ddd", index, i, 0 );
					
					break;
				}
			}
		}
		
		case 1:
		{
			for( new i; i < GetMaxFurnHouse( index ); i++ )
			{
				if( !HFurn[index][i][f_id] )
				{
					switch( subtype )
					{
						case 0:	
						{
							HFurn[index][i][f_model] = furniture_list[ftype][object][f_id];
							
							HFurn[index][i][f_name][0] = EOS;
							strcat( HFurn[index][i][f_name], furniture_list[ftype][object][f_name], 32 );
							
							HFurn[index][i][f_type] = ftype;
						}
						
						case 1:	
						{
							HFurn[index][i][f_model] = other_list[ftype][object][f_id];
							
							HFurn[index][i][f_name][0] = EOS;
							strcat( HFurn[index][i][f_name], other_list[ftype][object][f_name], 32 );
							
							HFurn[index][i][f_type] = ftype + 16;
						}
					}
					
					HFurn[index][i][f_hid] = HouseInfo[index][hID];
					HFurn[index][i][f_state] = 0;
					
					mysql_format:g_string( "INSERT INTO `"DB_HOUSE_FURN"` \
						( `f_hid`, `f_type`, `f_model`, `f_name` ) VALUES \
						( '%d', '%d', '%d', '%e' )",
						HFurn[index][i][f_hid],
						HFurn[index][i][f_type],
						HFurn[index][i][f_model],
						HFurn[index][i][f_name]
					);
					
					mysql_tquery( mysql, g_string, "InsertFurniture", "ddd", index, i, 1 );
					
					break;
				}
			}
		}
	}
}

UpdateFurnitureBusiness( businessid, furnitureid )
{
	mysql_format:g_string( "UPDATE `"DB_BUSINESS_FURN"` \
	SET `f_position` = '%f|%f|%f', \
		`f_rotation` = '%f|%f|%f', \
		`f_state` = %d \
	WHERE `f_id` = %d AND `f_bid` = %d LIMIT 1",
		BFurn[businessid][furnitureid][f_pos][0],
		BFurn[businessid][furnitureid][f_pos][1],
		BFurn[businessid][furnitureid][f_pos][2],
		BFurn[businessid][furnitureid][f_rot][0],
		BFurn[businessid][furnitureid][f_rot][1],
		BFurn[businessid][furnitureid][f_rot][2],
		BFurn[businessid][furnitureid][f_state],
		BFurn[businessid][furnitureid][f_id],
		BusinessInfo[businessid][b_id]
	);
	mysql_tquery( mysql, g_string );
	
	return 1;
}

UpdateFurnitureHouse( house, furnitureid )
{
	mysql_format:g_string( "UPDATE `"DB_HOUSE_FURN"` \
	SET `f_position` = '%f|%f|%f', \
		`f_rotation` = '%f|%f|%f', \
		`f_state` = %d \
	WHERE `f_id` = %d AND `f_hid` = %d LIMIT 1",
		HFurn[house][furnitureid][f_pos][0],
		HFurn[house][furnitureid][f_pos][1],
		HFurn[house][furnitureid][f_pos][2],
		HFurn[house][furnitureid][f_rot][0],
		HFurn[house][furnitureid][f_rot][1],
		HFurn[house][furnitureid][f_rot][2],
		HFurn[house][furnitureid][f_state],
		HFurn[house][furnitureid][f_id],
		HouseInfo[house][hID]
	);
	mysql_tquery( mysql, g_string );
	
	return 1;
}

DeleteFurnitureBusiness( bid, fid )
{
	mysql_format:g_string( "DELETE FROM `"DB_BUSINESS_FURN"` \
	WHERE `f_id` = %d AND `f_bid` = %d LIMIT 1",
		BFurn[bid][fid][f_id],
		BusinessInfo[bid][b_id]
	);
	
	mysql_tquery( mysql, g_string );
	
	BFurn[bid][fid][f_id] =
	BFurn[bid][fid][f_state] = 
	BFurn[bid][fid][f_bid] = 
	BFurn[bid][fid][f_type] =
	BFurn[bid][fid][f_object] =
	BFurn[bid][fid][f_model] = 0;
	
	BFurn[bid][fid][f_name][0] = EOS;
	
	for( new i = 0; i != 3; i++ )
	{
		BFurn[bid][fid][f_pos][i] = 
		BFurn[bid][fid][f_rot][i] = 0.0;
	}
	
	return 1;
}

DeleteFurnitureHouse( h, fid )
{
	mysql_format:g_string( "DELETE FROM `"DB_HOUSE_FURN"` \
	WHERE `f_id` = %d AND `f_hid` = %d LIMIT 1",
		HFurn[h][fid][f_id],
		HouseInfo[h][hID]
	);
	
	mysql_tquery( mysql, g_string );
	
	HFurn[h][fid][f_id] =
	HFurn[h][fid][f_state] = 
	HFurn[h][fid][f_bid] = 
	HFurn[h][fid][f_type] =
	HFurn[h][fid][f_object] =
	HFurn[h][fid][f_model] = 0;
	
	HFurn[h][fid][f_name][0] = EOS;
	
	for( new i = 0; i != 3; i++ )
	{
		HFurn[h][fid][f_pos][i] = 
		HFurn[h][fid][f_rot][i] = 0.0;
	}
	
	return 1;
}

function LoadFurnitureBusiness( bid )
{
	new 
		rows, 
		fields;
		
	cache_get_data( rows, fields, mysql );
	
	if( rows ) 
	{
		for( new max_furn; max_furn < rows; max_furn++ )
		{
			if( !BFurn[bid][max_furn][f_id] )
			{
				BFurn[bid][max_furn][f_id] = cache_get_field_content_int( max_furn, "f_id", mysql );
				BFurn[bid][max_furn][f_bid] = cache_get_field_content_int( max_furn, "f_bid", mysql );
				BFurn[bid][max_furn][f_state] = cache_get_field_content_int( max_furn, "f_state", mysql );
				BFurn[bid][max_furn][f_model] = cache_get_field_content_int( max_furn, "f_model", mysql );
				BFurn[bid][max_furn][f_type] = cache_get_field_content_int( max_furn, "f_type", mysql );
				
				clean:<g_small_string>;
				cache_get_field_content( max_furn, "f_position", g_small_string, mysql, 128 );
				sscanf( g_small_string,"p<|>a<f>[3]", BFurn[bid][max_furn][f_pos] );
				
				clean:<g_small_string>;
				cache_get_field_content( max_furn, "f_rotation", g_small_string, mysql, 128 );
				sscanf( g_small_string,"p<|>a<f>[3]", BFurn[bid][max_furn][f_rot] );
				
				clean:<g_small_string>;
				cache_get_field_content( max_furn, "f_name", g_small_string, mysql );
				strmid( BFurn[bid][max_furn][f_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
				
				if( BFurn[bid][max_furn][f_state] )
				{
					BFurn[bid][max_furn][f_object] = CreateDynamicObject(
						BFurn[bid][max_furn][f_model],
						BFurn[bid][max_furn][f_pos][0], BFurn[bid][max_furn][f_pos][1], BFurn[bid][max_furn][f_pos][2],
						BFurn[bid][max_furn][f_rot][0], BFurn[bid][max_furn][f_rot][1], BFurn[bid][max_furn][f_rot][2],
						BusinessInfo[bid][b_id], -1 
					);
				}
			}
		}
	}
	
	BusinessInfo[bid][b_count_furn] = rows;
	
	return 1;
}

function LoadFurnitureHouse( house )
{
	
	new 
		rows, 
		fields;
		
	cache_get_data( rows, fields, mysql );
	
	if( rows ) 
	{
		for( new max_furn; max_furn < rows; max_furn++ )
		{
			if( !HFurn[house][max_furn][f_id] )
			{
				HFurn[house][max_furn][f_id] = cache_get_field_content_int( max_furn, "f_id", mysql );
				HFurn[house][max_furn][f_hid] = cache_get_field_content_int( max_furn, "f_hid", mysql );
				HFurn[house][max_furn][f_state] = cache_get_field_content_int( max_furn, "f_state", mysql );
				HFurn[house][max_furn][f_model] = cache_get_field_content_int( max_furn, "f_model", mysql );
				HFurn[house][max_furn][f_type] = cache_get_field_content_int( max_furn, "f_type", mysql );
				
				clean:<g_small_string>;
				cache_get_field_content( max_furn, "f_position", g_small_string, mysql, 128 );
				sscanf( g_small_string,"p<|>a<f>[3]", HFurn[house][max_furn][f_pos] );
				
				clean:<g_small_string>;
				cache_get_field_content( max_furn, "f_rotation", g_small_string, mysql, 128 );
				sscanf( g_small_string,"p<|>a<f>[3]", HFurn[house][max_furn][f_rot] );
				
				clean:<g_small_string>;
				cache_get_field_content( max_furn, "f_name", g_small_string, mysql );
				strmid( HFurn[house][max_furn][f_name], g_small_string, 0, strlen( g_small_string ), sizeof g_small_string );
				
				if( HFurn[house][max_furn][f_state] )
				{
					HFurn[house][max_furn][f_object] = CreateDynamicObject(
						HFurn[house][max_furn][f_model],
						HFurn[house][max_furn][f_pos][0], HFurn[house][max_furn][f_pos][1], HFurn[house][max_furn][f_pos][2],
						HFurn[house][max_furn][f_rot][0], HFurn[house][max_furn][f_rot][1], HFurn[house][max_furn][f_rot][2],
						HouseInfo[house][hID], -1 
					);
				}
			}
		}
	}
	
	HouseInfo[house][hCountFurn] = rows;
	
	return 1;
}

stock ShowBusinessFurnList( playerid, bid, page ) 
{
	clean:<g_big_string>;	

	strcat( g_big_string, ""cWHITE"Предмет\t"cWHITE"Установка\n" );
	
	new 
		idx = page * FURN_PAGE,
		slot = 0,
		max_furn = GetMaxFurnBusiness( bid ),
		max_page = floatround( float( max_furn ) / FURN_PAGE, floatround_ceil ) - 1;
		
	SetPVarInt( playerid, "Bpanel:FPage", page );	
	SetPVarInt( playerid, "BPanel:FPageMax", max_page );
		
	for( new i = idx; i < max_furn; i++ ) 
	{
		if( BFurn[bid][i][f_id] ) 
		{
			format:g_small_string(  ""cBLUE"%i. "cGRAY"%s \t|%s"cGRAY"|\n",
				idx + ( slot + 1 ), BFurn[bid][i][f_name],
				BFurn[bid][i][f_state] == 0 ? (""cGRAY" Нет "):(""cGREEN" Да   " ) 
			);
			
			strcat( g_big_string, g_small_string );
			
			g_dialog_select[playerid][slot] = i;
			
			slot++;
			
			if( slot == FURN_PAGE ) 
			{
				strcat( g_big_string, "Следующая страница" );
	   	    	break;
			}
		}
	}
	
	if( page || ( page && slot < FURN_PAGE ) ) 
		strcat( g_big_string, "\nПредыдущая страница" );
		
	if( !slot && page < max_page ) 
	{
		SendClient:( playerid, C_GRAY, ""gbDefault"На складе бизнеса нет мебели." );
		return showPlayerDialog( playerid, d_business_panel + 11, DIALOG_STYLE_LIST, " ", b_panel_plan, "Выбрать", "Назад" );
	}
	
	SetPVarInt( playerid, "Bpanel:FAll", slot );
	
	showPlayerDialog( playerid, d_business_panel + 16, DIALOG_STYLE_TABLIST_HEADERS, "Управление мебелью", g_big_string, "Выбрать", "Назад" );
	
	return 1;
}

stock ShowHouseFurnList( playerid, house, page ) 
{
	clean:<g_big_string>;	

	strcat( g_big_string, ""cWHITE"Предмет\t"cWHITE"Установка\n" );
	
	new 
		idx = page * FURN_PAGE,
		slot = 0,
		max_furn = GetMaxFurnHouse( house ),
		max_page = floatround( float( max_furn ) / FURN_PAGE, floatround_ceil ) - 1;
		
	SetPVarInt( playerid, "Hpanel:FPage", page );	
	SetPVarInt( playerid, "HPanel:FPageMax", max_page );
		
	for( new i = idx; i < max_furn; i++ ) 
	{
		if( HFurn[house][i][f_id] ) 
		{
			format:g_small_string(  ""cBLUE"%i. "cGRAY"%s \t|%s"cGRAY"|\n",
				idx + ( slot + 1 ), HFurn[house][i][f_name],
				HFurn[house][i][f_state] == 0 ? (""cGRAY" Нет "):(""cBLUE" Да   " ) 
			);
			
			strcat( g_big_string, g_small_string );
			
			g_dialog_select[playerid][slot] = i;
			
			slot++;
			
			if( slot == FURN_PAGE ) 
			{
				strcat( g_big_string, "Следующая страница" );
	   	    	break;
			}
		}
	}
	
	if( page || ( page && slot < FURN_PAGE ) ) 
		strcat( g_big_string, "\nПредыдущая страница" );
		
	if( !slot && page < max_page ) 
	{
		DeletePVar( playerid, "Hpanel:FPage" );
		DeletePVar( playerid, "HPanel:FPageMax" );
	
		SendClient:( playerid, C_WHITE, !""gbDefault"На складе нет мебели." );
		return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
	}
	
	SetPVarInt( playerid, "Hpanel:FAll", slot );
	
	showPlayerDialog( playerid, d_house_panel + 11, DIALOG_STYLE_TABLIST_HEADERS, "Управление мебелью", g_big_string, "Выбрать", "Назад" );
	
	return 1;
}

function InsertFurniture( index, i, type ) 
{
	switch( type )
	{
		case 0: BFurn[index][i][f_id] = cache_insert_id();
		case 1: HFurn[index][i][f_id] = cache_insert_id();
	}
	
	return 1;
}

Furn_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) 
{
	switch( GetPVarInt( playerid, "Furn:Edit" ) )
	{
		case 1:
		{
			new
				bid = GetPVarInt( playerid, "Bpanel:BId" ),
				fid = GetPVarInt( playerid, "Bpanel:FId" );
			
			//CheckFurnitureObject( bid, objectid );
			
			if( response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL ) 
			{
				if( !IsValidDynamicObject( objectid ) )
				{
					ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) );
					return SendClient:( playerid, C_GRAY, !""gbError"Неверный идентификатор объекта. Попробуйте еще раз." );
				}
					
				if( objectid == BFurn[bid][fid][f_object] ) 
				{
					MoveDynamicObject( objectid, x, y, z, 10.0, rx, ry, rz );
					BFurn[bid][fid][f_pos][0] = x, 
					BFurn[bid][fid][f_pos][1] = y, 
					BFurn[bid][fid][f_pos][2] = z,
					BFurn[bid][fid][f_rot][0] = rx, 
					BFurn[bid][fid][f_rot][1] = ry, 
					BFurn[bid][fid][f_rot][2] = rz;
						
					UpdateFurnitureBusiness( bid, fid );
							
					ShowBusinessFurnList( playerid, bid, GetPVarInt( playerid, "Bpanel:FPage" ) );
							
					DeletePVar( playerid, "Furn:Edit" );
				}
			}
		}
		
		case 2:
		{
			new
				h = GetPVarInt( playerid, "Hpanel:HId" ),
				fid = GetPVarInt( playerid, "Hpanel:FId" );
			
			//CheckFurnitureObject( bid, objectid );
			
			if( response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL ) 
			{
				if( !IsValidDynamicObject( objectid ) )
				{
					ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) );
					return SendClient:( playerid, C_GRAY, !""gbError"Неверный идентификатор объекта. Попробуйте еще раз." );
				}				
					
				if( objectid == HFurn[h][fid][f_object] ) 
				{
					MoveDynamicObject( objectid, x, y, z, 10.0, rx, ry, rz );
					HFurn[h][fid][f_pos][0] = x, 
					HFurn[h][fid][f_pos][1] = y, 
					HFurn[h][fid][f_pos][2] = z,
					HFurn[h][fid][f_rot][0] = rx, 
					HFurn[h][fid][f_rot][1] = ry, 
					HFurn[h][fid][f_rot][2] = rz;
						
					UpdateFurnitureHouse( h, fid );
							
					ShowHouseFurnList( playerid, h, GetPVarInt( playerid, "Hpanel:FPage" ) );
							
					DeletePVar( playerid, "Furn:Edit" );
				}
			}
		}
	}
	
	
	return 1;
}	

/*CheckFurnitureObject( bid, objectid )
{
	if( objectid >= BObjectInterior[0] && objectid <= BObjectInterior[1] ||
		objectid >= BTextureWall[bid][0][0] && objectid <= BTextureWall[bid][0][1] ||
		objectid >= BTextureWall[bid][1][0] && objectid <= BTextureWall[bid][1][1] ||
		objectid >= BTextureWall[bid][2][0] && objectid <= BTextureWall[bid][2][1] ||
		objectid >= BTextureFloor[bid][0][0] && objectid <= BTextureFloor[bid][0][1] ||
		objectid >= BTextureFloor[bid][1][0] && objectid <= BTextureFloor[bid][1][1] ||
		objectid >= BTextureFloor[bid][2][0] && objectid <= BTextureFloor[bid][2][1] ||
		objectid >= BTextureFloor[bid][3][0] && objectid <= BTextureFloor[bid][3][1] ||
		objectid >= BTextureRoof[bid][0] && objectid <= BTextureRoof[bid][1] ) 
	{
		return 1;
	}
	else return 0;
}*/