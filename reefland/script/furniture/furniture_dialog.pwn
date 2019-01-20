
function Furniture_OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] ) 
{
	clean_array();
	
	switch( dialogid ) 
	{
		// покупка мебели
	
		case d_mebelbuy + 2:
		{
			if( !response ) return 1;
			
			SetPVarInt( playerid, "Furn:IntWorld", GetPlayerVirtualWorld( playerid ) );
			SetPlayerVirtualWorld( playerid, playerid );
			
			setPlayerPos( playerid, -489.3429, -260.2866, 3600.0859 );
			SetPVarInt( playerid, "Furn:PlayerPos", 1 );
			
			SetPlayerCameraPos( playerid, -486.4647, -251.8813, 3597.9995 );
			SetPlayerCameraLookAt( playerid, -486.4789, -256.7297, 3596.7776, 2 );
			
			SetPVarInt( playerid, "Furn:Type", listitem );
			SetPVarInt( playerid, "Furn:Object", 0 );
			SetPVarInt( playerid, "Furn:View", 1 );
			SetPVarInt( playerid, "Player:World", 10 );
			
			new 
				count = 0;
	
			for( new i; i < MAX_OBJECTS_FURN; i++ )
			{
				if( !furniture_list[GetPVarInt( playerid, "Furn:Type" )][i][f_id] )
				{
					count ++;
				}
			}
			
			SetPVarInt( playerid, "Furn:Max", MAX_OBJECTS_FURN - count );
			
			for(new i; i != 7; i ++) 
			{
				TextDrawShowForPlayer(playerid, furnitureBuy[i]);
			}
			
			SelectTextDraw( playerid, 0xd3d3d3FF );
			
			PlayerTextDrawShow( playerid, furniturePrice[playerid] );
			PlayerTextDrawShow( playerid, furnitureName[playerid] );
			furn_object[playerid] = 0;
			
			FurniturePreviewObject( playerid, GetPVarInt( playerid, "Furn:Type") ); 
			
			togglePlayerControllable( playerid, false );
		}
		
		case d_mebelbuy + 3:
		{
			if( !response ) 
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Furn:View", 1 );
				return 1;
			}
			
			switch( listitem )
			{
				case 0:
				{
					if( !ShowHousePlayerList( playerid, d_mebelbuy + 7, "Выбрать", "Назад" ) )
					{
						return 
							showPlayerDialog( playerid, d_mebelbuy + 3, DIALOG_STYLE_LIST, "Укажите место для доставки", 
								""cWHITE"Дом\n\
								Бизнес", 
							"Выбрать", "Закрыть" );
					}
				}
				case 1:
				{
					if( !ShowBusinessPlayerList( playerid, d_mebelbuy + 4, "Выбрать", "Назад" ) )
					{
						return 
							showPlayerDialog( playerid, d_mebelbuy + 3, DIALOG_STYLE_LIST, "Укажите место для доставки", 
								""cWHITE"Дом\n\
								Бизнес", 
							"Выбрать", "Закрыть" );
					}
				}
			}
		}
		
		case d_mebelbuy + 4:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_mebelbuy + 3, DIALOG_STYLE_LIST, "Укажите место для доставки", 
					""cWHITE"Дом\n\
					Бизнес", 
				"Выбрать", "Закрыть" );
			}
			
			SetPVarInt( playerid, "Furn:BId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			new 
				bid = GetPVarInt( playerid, "Furn:BId" );
				
			if( BusinessInfo[bid][b_count_furn] == GetMaxFurnBusiness( bid ) )
			{
				ShowBusinessPlayerList( playerid, d_mebelbuy + 4, "Выбрать", "Назад" );
				return SendClient:( playerid, C_GRAY, ""gbError"Склад бизнеса переполнен." );
			}
			
			AddFurniture( bid, GetPVarInt( playerid, "Furn:Type" ), GetPVarInt( playerid, "Furn:Object" ), 0 );
			
			BusinessInfo[bid][b_count_furn] ++;
			
			SetPlayerCash( playerid, "-", furniture_list[GetPVarInt( playerid, "Furn:Type" )][GetPVarInt( playerid, "Furn:Object" )][f_price] );
			
			pformat:( ""gbSuccess"Выбранный товар доставлен в %s #%d.",  GetBusinessType( bid ), BusinessInfo[bid][b_id] );
			psend:( playerid, C_GRAY );
			
			SetPVarInt( playerid, "Furn:View", 1 );
			SelectTextDraw( playerid, 0xd3d3d3FF );
		}
		
		//Дополнительная мебель в бизнесе
		case d_mebelbuy + 5:
		{
			new 
				bid = GetPVarInt( playerid, "Bpanel:BId" );
			
			if( !response )
			{
				format:g_string( b_panel_p2, 
					BusinessInfo[bid][b_improve][0] ? (""cBLUE"есть") : (""cGRAY"нет"),
					BusinessInfo[bid][b_improve][1] ? (""cBLUE"есть") : (""cGRAY"нет")
				);
						
				return
					showPlayerDialog( playerid, d_business_panel + 1, DIALOG_STYLE_TABLIST_HEADERS, " ", g_string, "Купить", "Назад" );
			}
			
			SetPlayerVirtualWorld( playerid, playerid );
			
			setPlayerPos( playerid, -489.3429, -260.2866, 3600.0859 );
			SetPVarInt( playerid, "Furn:PlayerPos", 1 );
			
			SetPlayerCameraPos( playerid, -486.4647, -251.8813, 3597.9995 );
			SetPlayerCameraLookAt( playerid, -486.4789, -256.7297, 3596.7776, 2 );
			
			SetPVarInt( playerid, "FurnOther:Type", listitem );
			SetPVarInt( playerid, "FurnOther:Object", 0 );
			
			new 
				count = 0;
	
			for( new i; i < MAX_OBJECTS_FURNOTHER; i++ )
			{
				if( !other_list[listitem][i][f_id] )
				{
					count ++;
				}
			}
			
			SetPVarInt( playerid, "FurnOther:Max", MAX_OBJECTS_FURNOTHER - count );
			SetPVarInt( playerid, "Furn:View", 2 );
			SetPVarInt( playerid, "Player:World", 5 );
			
			TextDrawShowForPlayer( playerid, furnitureBuy[0] );
			TextDrawShowForPlayer( playerid, furnitureBuy[1] );
			TextDrawShowForPlayer( playerid, furnitureBuy[6] );
			
			for( new i; i != 4; i++ )
			{
				TextDrawShowForPlayer( playerid, furnitureOther[i] );
			}
			
			SelectTextDraw( playerid, 0xd3d3d3FF );
			
			PlayerTextDrawShow( playerid, furniturePrice[playerid] );
			PlayerTextDrawShow( playerid, furnitureName[playerid] );
			furn_object[playerid] = 0;
			
			OtherPreviewObject( playerid, GetPVarInt( playerid, "FurnOther:Type" ) );
			
			togglePlayerControllable( playerid, false );
		}
		
		case d_mebelbuy + 6:
		{
			if( !response )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Furn:View", 2 );
				return 1;
			}
			
			new 
				bid = GetPVarInt( playerid, "Bpanel:BId" ),
				type = GetPVarInt( playerid, "FurnOther:Type" ),
				object = GetPVarInt( playerid, "FurnOther:Object" );
				
			if( BusinessInfo[bid][b_count_furn] == GetMaxFurnBusiness( bid ) )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Furn:View", 2 );
				return SendClient:( playerid, C_GRAY, !""gbError"Склад бизнеса переполнен." );
			}
			
			if( BusinessInfo[bid][b_safe] < other_list[type][object][f_price] )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Furn:View", 2 );
				return SendClient:( playerid, C_GRAY, !""gbError"В сейфе бизнеса недостаточно денег для совершения операции." );
			}
			
			AddFurniture( bid, type, object, 1 );
			
			SetPVarInt( playerid, "Furn:View", 2 );
			
			BusinessInfo[bid][b_count_furn]++;
			
			BusinessInfo[bid][b_safe] -= other_list[type][object][f_price];
				
			UpdateBusiness( bid, "b_safe", BusinessInfo[bid][b_safe] );
			
			pformat:( ""gbSuccess"Выбранный товар помещен на склад в %s #%d.",  GetBusinessType( bid ), BusinessInfo[bid][b_id] );
			psend:( playerid, C_GRAY );
			
			SelectTextDraw( playerid, 0xd3d3d3FF );
		}
		//Покупка мебели в дом
		case d_mebelbuy + 7:
		{
			if( !response )
			{
				return showPlayerDialog( playerid, d_mebelbuy + 3, DIALOG_STYLE_LIST, "Укажите место для доставки", 
					""cWHITE"Дом\n\
					Бизнес", 
				"Выбрать", "Закрыть" );
			}
			
			SetPVarInt( playerid, "Furn:HId", g_dialog_select[playerid][listitem] );
			g_dialog_select[playerid][listitem] = INVALID_PARAM;
			
			new 
				h = GetPVarInt( playerid, "Furn:HId" );
				
			if( HouseInfo[h][hCountFurn] == GetMaxFurnHouse( h ) )
			{
				ShowHousePlayerList( playerid, d_mebelbuy + 7, "Выбрать", "Назад" );
				return SendClient:( playerid, C_GRAY, !""gbError"Склад дома переполнен." );
			}
			
			AddFurniture( h, GetPVarInt( playerid, "Furn:Type" ), GetPVarInt( playerid, "Furn:Object" ), 0, 1 );
			
			HouseInfo[h][hCountFurn]++;
			
			SetPlayerCash( playerid, "-", furniture_list[GetPVarInt( playerid, "Furn:Type" )][GetPVarInt( playerid, "Furn:Object" )][f_price] );
			
			pformat:( ""gbSuccess"Выбранный товар доставлен в %s #%d.",  !HouseInfo[h][hType] ? ("дом") : ("квартиру"), HouseInfo[h][hID] );
			psend:( playerid, C_WHITE );
			
			SetPVarInt( playerid, "Furn:View", 1 );
			SelectTextDraw( playerid, 0xd3d3d3FF );
		}
		
		case d_mebelbuy + 8:
		{
			if( !response )
				return showPlayerDialog( playerid, d_house_panel + 9, DIALOG_STYLE_LIST, "Настройки", h_panel_plan, "Выбрать", "Назад" );
			
			SetPlayerVirtualWorld( playerid, playerid );
			
			setPlayerPos( playerid, -489.3429, -260.2866, 3600.0859 );
			SetPVarInt( playerid, "Furn:PlayerPos", 1 );
			
			SetPlayerCameraPos( playerid, -486.4647, -251.8813, 3597.9995 );
			SetPlayerCameraLookAt( playerid, -486.4789, -256.7297, 3596.7776, 2 );
			
			SetPVarInt( playerid, "FurnOther:Type", listitem );
			SetPVarInt( playerid, "FurnOther:Object", 0 );
			
			new 
				count = 0;
	
			for( new i; i < MAX_OBJECTS_FURNOTHER; i++ )
			{
				if( !other_list[listitem][i][f_id] )
				{
					count ++;
				}
			}
			
			SetPVarInt( playerid, "FurnOther:Max", MAX_OBJECTS_FURNOTHER - count );
			SetPVarInt( playerid, "Furn:View", 3 );
			SetPVarInt( playerid, "Player:World", 5 );
			
			TextDrawShowForPlayer( playerid, furnitureBuy[0] );
			TextDrawShowForPlayer( playerid, furnitureBuy[1] );
			TextDrawShowForPlayer( playerid, furnitureBuy[6] );
			
			for( new i; i < 5; i++ )
			{
				if( i == 2 ) continue;
				TextDrawShowForPlayer(playerid, furnitureOther[i] );
			}
			
			SelectTextDraw( playerid, 0xd3d3d3FF );
			
			PlayerTextDrawShow( playerid, furniturePrice[playerid] );
			PlayerTextDrawShow( playerid, furnitureName[playerid] );
			furn_object[playerid] = 0;
			
			OtherPreviewObject( playerid, GetPVarInt( playerid, "FurnOther:Type" ) );
			
			togglePlayerControllable( playerid, false );
		}
		
		case d_mebelbuy + 9:
		{
			if( !response )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Furn:View", 3 );
				return 1;
			}
			
			new 
				h = GetPVarInt( playerid, "Hpanel:HId" ),
				type = GetPVarInt( playerid, "FurnOther:Type" ),
				object = GetPVarInt( playerid, "FurnOther:Object" );
				
			if( HouseInfo[h][hCountFurn] == GetMaxFurnHouse( h ) )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Furn:View", 3 );
				return SendClient:( playerid, C_GRAY, !""gbError"Склад бизнеса переполнен." );
			}
			
			if( HouseInfo[h][hMoney] < other_list[type][object][f_price] )
			{
				SelectTextDraw( playerid, 0xd3d3d3FF );
				SetPVarInt( playerid, "Furn:View", 3 );
				return SendClient:( playerid, C_GRAY, !""gbError"В сейфе дома недостаточно денег для совершения операции." );
			}
			
			AddFurniture( h, type, object, 1, 1 );
			
			SetPVarInt( playerid, "Furn:View", 3 );
			
			HouseInfo[h][hCountFurn]++;
			
			HouseInfo[h][hMoney] -= other_list[type][object][f_price];
			HouseUpdate( h, "hMoney", HouseInfo[h][hMoney] );
			
			pformat:( ""gbSuccess"Выбранный товар помещен на склад %s #%d.",  !HouseInfo[h][hType] ? ("дома") : ("квартиры"), HouseInfo[h][hID] );
			psend:( playerid, C_WHITE );
			
			SelectTextDraw( playerid, 0xd3d3d3FF );
		}
	}
	
	return 1;
}